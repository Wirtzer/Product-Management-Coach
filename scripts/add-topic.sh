#!/bin/bash
# add-topic.sh — "Teach me about X" — adds a topic to the knowledge queue
# Dependencies: bash, jq
# Usage: ./scripts/add-topic.sh "transformer attention mechanisms"
#        ./scripts/add-topic.sh "RICE prioritization" --tracks pm-frameworks
set -euo pipefail

WORKSPACE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
KNOWLEDGE_QUEUE="$WORKSPACE/learning/knowledge-queue.jsonl"
TODAY=$(date +%Y-%m-%d)

# ── Parse arguments ──
TOPIC=""
TRACKS=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --tracks|-t)
      TRACKS="$2"
      shift 2
      ;;
    --help|-h)
      echo "Usage: add-topic.sh <topic> [--tracks track1,track2]"
      echo ""
      echo "Add a topic to the PM Coach knowledge queue for the next reflection"
      echo "cycle to process and integrate into your learning tracks."
      echo ""
      echo "Examples:"
      echo "  ./scripts/add-topic.sh \"transformer attention mechanisms\""
      echo "  ./scripts/add-topic.sh \"RICE prioritization\" --tracks pm-frameworks"
      echo "  ./scripts/add-topic.sh \"Figure AI Series B funding\" --tracks industry-landscape,robot-learning"
      exit 0
      ;;
    *)
      TOPIC="$1"
      shift
      ;;
  esac
done

if [[ -z "$TOPIC" ]]; then
  echo "❌ Please provide a topic."
  echo "   Usage: ./scripts/add-topic.sh \"topic description\""
  echo "   Run with --help for more options."
  exit 1
fi

# ── Ensure queue file exists ──
mkdir -p "$(dirname "$KNOWLEDGE_QUEUE")"
touch "$KNOWLEDGE_QUEUE"

# ── Generate unique ID ──
# Count existing entries for today to get the sequence number
TODAY_COUNT=$(grep -c "\"kq-${TODAY}-" "$KNOWLEDGE_QUEUE" 2>/dev/null || true)
SEQ=$(printf '%03d' $((TODAY_COUNT + 1)))
ID="kq-${TODAY}-${SEQ}"

# ── Parse tracks into JSON array ──
TRACKS_JSON="[]"
if [[ -n "$TRACKS" ]]; then
  TRACKS_JSON=$(echo "$TRACKS" | tr ',' '\n' | jq -R . | jq -s .)
fi

# ── Build and append the entry ──
ENTRY=$(jq -n \
  --arg id "$ID" \
  --arg date "$TODAY" \
  --arg title "$TOPIC" \
  --argjson tracks "$TRACKS_JSON" \
  '{
    id: $id,
    date_added: $date,
    source_type: "manual-topic",
    source_file: null,
    title: $title,
    summary: ("Manual topic request: " + $title),
    topics: [],
    relevance_score: 7,
    suggested_tracks: $tracks,
    status: "pending",
    integrated_date: null
  }')

echo "$ENTRY" >> "$KNOWLEDGE_QUEUE"

echo "✅ Added to knowledge queue: \"$TOPIC\""
echo "   ID: $ID"
if [[ -n "$TRACKS" ]]; then
  echo "   Suggested tracks: $TRACKS"
fi
echo "   Status: pending (will be processed in the next reflection cycle)"
echo ""
echo "   Run './scripts/run-reflection.sh' to process immediately,"
echo "   or wait for the next scheduled reflection."
