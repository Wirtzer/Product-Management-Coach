#!/bin/bash
# feed-knowledge-queue.sh — Process knowledge sources into the learning queue
# Dependencies: bash, jq
# Usage: ./scripts/feed-knowledge-queue.sh
#
# Scans configured knowledge directories for new .md and .txt files, checks
# what's already been processed, and adds new entries to knowledge-queue.jsonl.
# Optionally calls an LLM for relevance scoring (falls back to manual tagging).
set -euo pipefail

WORKSPACE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
KNOWLEDGE_QUEUE="$WORKSPACE/learning/knowledge-queue.jsonl"
PROCESSED_FILE="$WORKSPACE/learning/knowledge-queue-processed-files.txt"
CONFIG="$WORKSPACE/config.json"
TODAY=$(date +%Y-%m-%d)
NOW_ISO=$(date +%Y-%m-%dT%H:%M:%S%z)

echo "📰 [feed-knowledge-queue] Starting knowledge queue feed..."
echo "   Date: $TODAY"

# ── Ensure files exist ──
mkdir -p "$WORKSPACE/learning"
touch "$KNOWLEDGE_QUEUE"
touch "$PROCESSED_FILE"

# ── Read knowledge source directories from config.json ──
KNOWLEDGE_DIRS=()
if [[ -f "$CONFIG" ]]; then
  # Read paths.knowledge_sources array from config
  while IFS= read -r dir; do
    [[ -n "$dir" && "$dir" != "null" ]] && KNOWLEDGE_DIRS+=("$dir")
  done < <(jq -r '.paths.knowledge_sources[]? // empty' "$CONFIG" 2>/dev/null)
fi

# Fallback to default knowledge directory
if [[ ${#KNOWLEDGE_DIRS[@]} -eq 0 ]]; then
  KNOWLEDGE_DIRS=("$WORKSPACE/knowledge")
  echo "   Using default knowledge directory: $WORKSPACE/knowledge"
fi

echo "   Knowledge directories: ${#KNOWLEDGE_DIRS[@]}"
for d in "${KNOWLEDGE_DIRS[@]}"; do
  echo "     • $d"
done

# ── Scan for new files ──
NEW_FILES=()
NEW_CONTENT=""
NEW_COUNT=0

for kdir in "${KNOWLEDGE_DIRS[@]}"; do
  if [[ ! -d "$kdir" ]]; then
    echo "   ⚠️  Directory not found: $kdir (skipping)"
    continue
  fi

  echo "   Scanning: $kdir"

  while IFS= read -r filepath; do
    [[ -z "$filepath" ]] && continue
    filename=$(basename "$filepath")

    # Skip if already processed
    if grep -qF "$filename" "$PROCESSED_FILE" 2>/dev/null; then
      continue
    fi

    # Check if file was modified in the last 14 days
    should_process=false

    # Try to get modification time
    if stat --version &>/dev/null 2>&1; then
      # GNU stat
      mod_time=$(stat -c "%Y" "$filepath" 2>/dev/null || echo "0")
    else
      # BSD/macOS stat
      mod_time=$(stat -f "%m" "$filepath" 2>/dev/null || echo "0")
    fi

    cutoff_epoch=0
    if date --version &>/dev/null 2>&1; then
      cutoff_epoch=$(date -d "$TODAY - 14 days" +%s 2>/dev/null || echo "0")
    else
      cutoff_epoch=$(date -j -v-14d +%s 2>/dev/null || echo "0")
    fi

    if (( mod_time >= cutoff_epoch )); then
      should_process=true
    fi

    if [[ "$should_process" == "true" ]]; then
      NEW_FILES+=("$filepath")
      NEW_COUNT=$((NEW_COUNT + 1))

      # Read first 500 lines for summary
      file_content=$(head -500 "$filepath" 2>/dev/null || true)
      NEW_CONTENT+="
=== SOURCE: $filename ===
SOURCE_PATH: $filepath
$file_content
"
      echo "     📄 New: $filename"
    fi
  done < <(find "$kdir" -maxdepth 3 \( -name "*.md" -o -name "*.txt" \) -type f 2>/dev/null)
done

echo ""
echo "📊 New files to process: $NEW_COUNT"

if [[ $NEW_COUNT -eq 0 ]]; then
  echo "✅ [feed-knowledge-queue] Nothing new. Knowledge queue is up to date."
  exit 0
fi

# ── Read existing track IDs for reference ──
TRACK_IDS=""
for track_dir in "$WORKSPACE/learning/tracks"/*/; do
  tf="$track_dir/track.json"
  [[ -f "$tf" ]] || continue
  tid=$(jq -r '.track_id' "$tf")
  TRACK_IDS+="$tid, "
done

# ── Read existing queue for dedup ──
EXISTING_QUEUE=""
if [[ -s "$KNOWLEDGE_QUEUE" ]]; then
  EXISTING_QUEUE=$(tail -20 "$KNOWLEDGE_QUEUE")
fi

# ── Try LLM processing, fall back to simple extraction ──
PROMPT="[FEED-KNOWLEDGE-QUEUE] Extract relevant items from the sources below and score their relevance.

For each paper/article that meets the relevance threshold (score >= 5), output a JSON line.

TOPIC SCORING (start at 0, add points):
- robotics, embodied-ai, manipulation, locomotion: +3
- foundation-models, LLMs, VLMs, multimodal: +2
- agents, tool use, planning, reasoning: +2
- safety, alignment, RLHF: +1
- product management, user experience, metrics: +1
- From a notable lab (DeepMind, OpenAI, Anthropic, Meta FAIR, Google Brain): +1

JSON LINE FORMAT:
{\"id\": \"kq-$TODAY-NNN\", \"date_added\": \"$TODAY\", \"source_type\": \"knowledge-source\", \"source_file\": \"<filename>\", \"title\": \"<title>\", \"summary\": \"<1-2 sentence summary>\", \"topics\": [\"topic1\", \"topic2\"], \"relevance_score\": <N>, \"suggested_tracks\": [\"<track-id>\"], \"status\": \"pending\"}

EXISTING TRACK IDS: $TRACK_IDS

EXISTING QUEUE (avoid duplicates):
$EXISTING_QUEUE

OUTPUT: Only the JSON lines, one per line. No other text.

CONTENT:
$NEW_CONTENT"

LLM_AVAILABLE=false
if command -v claude &>/dev/null; then
  LLM_AVAILABLE=true
  echo "🤖 Processing with Claude CLI..."
  LLM_OUTPUT=$(echo "$PROMPT" | claude --print 2>/dev/null || true)
  if [[ -n "$LLM_OUTPUT" ]]; then
    # Append valid JSONL lines
    while IFS= read -r line; do
      # Validate it's JSON
      if echo "$line" | jq . &>/dev/null 2>&1; then
        echo "$line" >> "$KNOWLEDGE_QUEUE"
      fi
    done <<< "$LLM_OUTPUT"
  fi
elif command -v aichat &>/dev/null; then
  LLM_AVAILABLE=true
  echo "🤖 Processing with aichat..."
  LLM_OUTPUT=$(echo "$PROMPT" | aichat 2>/dev/null || true)
  if [[ -n "$LLM_OUTPUT" ]]; then
    while IFS= read -r line; do
      if echo "$line" | jq . &>/dev/null 2>&1; then
        echo "$line" >> "$KNOWLEDGE_QUEUE"
      fi
    done <<< "$LLM_OUTPUT"
  fi
fi

if [[ "$LLM_AVAILABLE" == "false" ]]; then
  echo "⚠️  No LLM CLI found — creating basic queue entries from file metadata."
  echo "   Install Claude Code or aichat for automatic relevance scoring."
  echo ""

  counter=1
  for filepath in "${NEW_FILES[@]}"; do
    filename=$(basename "$filepath")
    # Extract title from first heading or filename
    title=$(head -5 "$filepath" | grep -m1 '^#' | sed 's/^#* *//' || true)
    [[ -z "$title" ]] && title="$filename"

    entry=$(jq -n \
      --arg id "kq-${TODAY}-$(printf '%03d' $counter)" \
      --arg date "$TODAY" \
      --arg file "$filename" \
      --arg title "$title" \
      --arg path "$filepath" \
      '{
        id: $id,
        date_added: $date,
        source_type: "knowledge-source",
        source_file: $file,
        content_path: $path,
        title: $title,
        summary: "Pending manual review — no LLM available for auto-scoring",
        topics: [],
        relevance_score: 5,
        suggested_tracks: [],
        status: "pending"
      }')
    echo "$entry" >> "$KNOWLEDGE_QUEUE"
    counter=$((counter + 1))
  done
fi

# ── Mark files as processed ──
echo ""
echo "📝 Marking files as processed..."
for filepath in "${NEW_FILES[@]}"; do
  filename=$(basename "$filepath")
  echo "$filename" >> "$PROCESSED_FILE"
  echo "   ✓ $filename"
done

echo ""
echo "✅ [feed-knowledge-queue] Complete!"
echo "   Files processed: $NEW_COUNT"
echo "   Knowledge queue: $KNOWLEDGE_QUEUE"
