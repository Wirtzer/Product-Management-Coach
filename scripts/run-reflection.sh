#!/bin/bash
# run-reflection.sh — Run the daily reflection analysis via LLM
# Dependencies: bash, jq, and one of: claude CLI, aichat, or manual LLM access
# Usage: ./scripts/run-reflection.sh
#
# Collects all track data, session history, pedagogy approaches, memory, knowledge
# queue, and lesson plans. Builds a comprehensive prompt and sends it to an LLM
# for deep analysis. Saves the reflection and updates the system.
set -euo pipefail

WORKSPACE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TRACKS_DIR="$WORKSPACE/learning/tracks"
REFLECTIONS_DIR="$WORKSPACE/learning/reflections"
ARCHIVE_DIR="$REFLECTIONS_DIR/archive"
PEDAGOGY="$WORKSPACE/learning/pedagogy/approaches.md"
MEMORY="$WORKSPACE/memory.md"
KNOWLEDGE_QUEUE="$WORKSPACE/learning/knowledge-queue.jsonl"
DASHBOARD="$WORKSPACE/learning/dashboard.md"
SESSION_PREP="$WORKSPACE/learning/session-prep.md"
CONFIG="$WORKSPACE/config.json"
TODAY=$(date +%Y-%m-%d)
NOW_ISO=$(date +%Y-%m-%dT%H:%M:%S%z)

echo "🔮 [run-reflection] Starting daily reflection..."
echo "   Workspace: $WORKSPACE"
echo "   Date: $TODAY"

# ── Verify dependencies ──
if ! command -v jq &>/dev/null; then
  echo "❌ jq is required but not found. Install with: brew install jq"
  exit 1
fi

# ── Read configurable model ──
REFLECTION_MODEL="${REFLECTION_MODEL:-}"
if [[ -z "$REFLECTION_MODEL" && -f "$CONFIG" ]]; then
  REFLECTION_MODEL=$(jq -r '.model.deep // .model.default // ""' "$CONFIG")
fi
REFLECTION_MODEL="${REFLECTION_MODEL:-claude-sonnet-4-5}"
echo "   Model: $REFLECTION_MODEL"

# ── Ensure directories exist ──
mkdir -p "$ARCHIVE_DIR"

# ── Read learner name from config ──
LEARNER_NAME="the learner"
if [[ -f "$CONFIG" ]]; then
  cfg_name=$(jq -r '.user.name // ""' "$CONFIG")
  [[ -n "$cfg_name" ]] && LEARNER_NAME="$cfg_name"
fi

# ── Collect ALL track data ──
echo "📂 Collecting track data..."
ALL_TRACK_JSON=""
TRACK_COUNT=0

for track_dir in "$TRACKS_DIR"/*/; do
  track_file="$track_dir/track.json"
  [[ -f "$track_file" ]] || continue

  track_id=$(jq -r '.track_id' "$track_file")
  display_name=$(jq -r '.display_name' "$track_file")
  TRACK_COUNT=$((TRACK_COUNT + 1))

  ALL_TRACK_JSON+="
=== TRACK: $display_name ($track_id) ===
$(cat "$track_file")
"
  echo "   ✓ $display_name"
done
echo "   Total: $TRACK_COUNT tracks"

# ── Collect ALL history (last 7 entries each) ──
echo "📜 Collecting session history..."
ALL_HISTORY=""
HISTORY_COUNT=0

for track_dir in "$TRACKS_DIR"/*/; do
  history_file="$track_dir/history.jsonl"
  [[ -f "$history_file" ]] || continue

  track_id=$(basename "$track_dir")
  entries=$(wc -l < "$history_file" | tr -d ' ')
  recent=$(tail -7 "$history_file")

  if [[ -n "$recent" ]]; then
    ALL_HISTORY+="
=== HISTORY: $track_id (last 7 of $entries entries) ===
$recent
"
    HISTORY_COUNT=$((HISTORY_COUNT + 1))
    echo "   ✓ $track_id ($entries total entries)"
  fi
done
echo "   Loaded history from $HISTORY_COUNT tracks"

# ── Read pedagogy approaches ──
PEDAGOGY_CONTENT=""
if [[ -f "$PEDAGOGY" ]]; then
  PEDAGOGY_CONTENT=$(cat "$PEDAGOGY")
  echo "📚 Read pedagogy/approaches.md"
else
  echo "⚠️  No pedagogy/approaches.md found"
fi

# ── Read memory ──
MEMORY_CONTENT=""
if [[ -f "$MEMORY" ]]; then
  MEMORY_CONTENT=$(cat "$MEMORY")
  echo "🧠 Read memory.md"
else
  echo "⚠️  No memory.md found"
fi

# ── Read knowledge queue ──
KQ_CONTENT=""
KQ_COUNT=0
if [[ -f "$KNOWLEDGE_QUEUE" ]]; then
  KQ_COUNT=$(wc -l < "$KNOWLEDGE_QUEUE" | tr -d ' ')
  KQ_CONTENT=$(cat "$KNOWLEDGE_QUEUE")
  echo "📰 Read knowledge-queue.jsonl ($KQ_COUNT items)"
else
  echo "📰 No knowledge queue found"
fi

# ── Read existing lesson plans ──
echo "📖 Collecting lesson plans..."
ALL_LESSON_PLANS=""
LP_COUNT=0

for track_dir in "$TRACKS_DIR"/*/; do
  lesson_plan="$track_dir/lesson-plan.md"
  [[ -f "$lesson_plan" ]] || continue

  track_id=$(basename "$track_dir")
  ALL_LESSON_PLANS+="
=== LESSON PLAN: $track_id ===
$(cat "$lesson_plan")
"
  LP_COUNT=$((LP_COUNT + 1))
done
echo "   Found $LP_COUNT lesson plans"

# ── Build the reflection prompt ──
PROMPT="[DAILY-REFLECTION] Perform comprehensive daily reflection and learning system update.

DATE: $TODAY
TIMESTAMP: $NOW_ISO
LEARNER: $LEARNER_NAME

FILE-ONLY: Write all output to files. Do NOT send messages.

YOU ARE the PM Coach's reflection engine. Your job is to deeply analyze the learner's progress, identify patterns, and update the learning system.

== TASK CHECKLIST ==

1. ANALYZE ALL TRACKS — Compare mastery scores, conversational readiness, trends.
   Identify: plateaus (scores not improving), gaps (mastery >> conv readiness),
   strengths (consistent high scores), and areas needing technique changes.

2. ANALYZE HISTORY — Look at the last 7 session entries per track. Compare techniques
   used, scores over time, what worked vs. didn't. Look for patterns across tracks.

3. PEDAGOGY ANALYSIS — For each track:
   a. TECHNIQUE EFFECTIVENESS: Review pedagogy.techniques_tried in track.json.
      For each technique where sessions >= 3 AND effectiveness == \"low\":
      - RETIRE IT: Remove from pedagogy.active_techniques in track.json
      - Add a \"retired\" note to the technique entry: effectiveness = \"retired\"
      - SELECT REPLACEMENT: Pick a new technique from the same phase in
        pedagogy/approaches.md that hasn't been tried yet (or was tried with
        \"high\" effectiveness). Add it to active_techniques.
      - Log the retirement and replacement in the reflection archive.
      For techniques with sessions >= 2 AND effectiveness == \"high\":
      - PRIORITIZE: Ensure it's in active_techniques
      - Consider applying to similar tracks in the same pillar

   b. PHASE ADVANCEMENT CHECK: For each track, evaluate phase advancement:
      - Read the Phase → Focus Dimension Mapping in approaches.md
      - Look up the current phase's focus dimensions for this track's approach
      - Check if ALL focus dimensions exceed 75/100 in mastery.dimensions
      - Check history.jsonl: 2+ consecutive sessions with passing quality
        (quality >= 4 if integer, or quality == \"success\" if string legacy format)
      - Check history.jsonl: at least one passing session after a 3+ day gap
      - If ALL THREE criteria met: advance pedagogy.current_phase to the next
        value in phase_progression. Update active_techniques for the new phase.
        Log the advancement in the reflection.
      - If NOT met: stay in current phase. Note which criteria are blocking.

   c. STAGNATION DETECTION: If a mastery dimension has trend == \"flat\" for 3+
      sessions, flag as plateau. Try cross-pollinating a technique from a
      different approach. Log the cross-pollination attempt.

4. PILLAR BALANCE — Group tracks by pillar. Identify imbalanced pillars (some much
   stronger than others). Recommend rebalancing if needed.

4.5. CROSS-TRACK META-ISSUE DETECTION — Scan ALL tracks across ALL pillars for
   shared weakness patterns:
   a. For each mastery dimension name that appears in 2+ tracks across DIFFERENT
      pillars: check if the score is < 60 in both tracks.
   b. Also check for conceptually similar dimensions across tracks even if names differ:
      - \"delivery_clarity\" and \"vocabulary_fluency\" both relate to communication
      - \"strategic_frame\" and \"opinion_formation\" both relate to higher-order thinking
      - \"current_research\" and \"current_awareness\" both relate to staying current
   c. For each meta-issue found:
      - Write it to the dashboard.md Alerts section
      - Write it to session-prep.md under a Meta-Issues section
      - Recommend a specific intervention

5. PROCESS KNOWLEDGE QUEUE — Read the knowledge queue. Filter for items where
   status == \"pending\".

   NOTE: Use each item's \"summary\" field for concept extraction. Reference
   content_path in the lesson plan so the live session coach can load excerpts
   on demand.

   For EACH pending item:

   a. TAG MATCHING: Compare the item's topic_tags against all existing tracks.
   b. TRACK ROUTING: Assign the item to 1-3 existing tracks.
      - relevance_score >= 8 AND no matching track → CREATE a new track
      - relevance_score >= 7 → Integrate into lesson-plan.md
      - relevance_score 5-6 → Note in lesson-plan.md as Background Reading
      - relevance_score < 5 → Mark as \"skipped\" with reason

   c. CONCEPT EXTRACTION from the item's summary:
      - 2-5 key concepts the learner should understand
      - 1-2 vocabulary terms
      - 1 current events hook
      - 1 opinion-formation prompt

   d. LESSON PLAN UPDATE: Append extracted concepts to the relevant track's lesson-plan.md.
   e. CURRENT AWARENESS UPDATE in routed track(s)' track.json
   f. STATUS UPDATE: Write a new line with status \"processed\"
   g. CURRENT AWARENESS DECAY for inactive tracks

5.5. SPACED REPETITION UPDATES — For each track with session history:
   - Quality 5 (score >= 90): interval *= 2.5 (max 30d)
   - Quality 4 (score 80-89): interval *= 2.0 (max 30d)
   - Quality 3 (score 70-79): interval *= 1.5 (max 30d)
   - Quality 2 (score 55-69): interval = 1 day, reset consecutive_successes
   - Quality 1 (score < 55): interval = 1 day, flag for immediate review
   - Update next_review_date = last_session_date + computed_interval

6. UPDATE LESSON PLANS — For each track, update lesson-plan.md with:
   - Next session focus
   - Specific exercises or questions
   - Technique to use
   - Knowledge queue items to integrate
   Write each to: $TRACKS_DIR/<track-id>/lesson-plan.md

7. WRITE REFLECTION — Comprehensive document covering:
   - Overall progress summary
   - Track-by-track analysis
   - Pillar balance assessment
   - Technique effectiveness comparison
   - Knowledge queue integration notes
   - Recommended focus for next 7 days
   - Alerts and concerns

   Write to BOTH:
   - $ARCHIVE_DIR/$TODAY.md (permanent archive)
   - $REFLECTIONS_DIR/latest.md (always overwritten)

8. REGENERATE DASHBOARD — Write a fresh dashboard.md to $DASHBOARD.
   Include: overall scores, per-pillar sections with track tables, due reviews, alerts.

9. REGENERATE SESSION PREP — Write a fresh session-prep.md to $SESSION_PREP
   focusing on what's due tomorrow or most needed.

== ALL TRACK DATA ==
$ALL_TRACK_JSON

== ALL SESSION HISTORY ==
$ALL_HISTORY

== PEDAGOGY APPROACHES ==
$PEDAGOGY_CONTENT

== MEMORY ==
$MEMORY_CONTENT

== KNOWLEDGE QUEUE ($KQ_COUNT items) ==
$KQ_CONTENT

== EXISTING LESSON PLANS ==
$ALL_LESSON_PLANS

== KEY PATHS ==
- Track files: $TRACKS_DIR/<track-id>/track.json
- Lesson plans: $TRACKS_DIR/<track-id>/lesson-plan.md
- Reflection archive: $ARCHIVE_DIR/$TODAY.md
- Latest reflection: $REFLECTIONS_DIR/latest.md
- Dashboard: $DASHBOARD
- Session prep: $SESSION_PREP

IMPORTANT: Write ALL files. Do not skip any step."

# ── Send to LLM ──
echo "🤖 Sending to LLM..."
echo "   This may take a few minutes..."

REFLECTION_OUTPUT=""
LLM_USED=""

if command -v claude &>/dev/null; then
  LLM_USED="claude"
  echo "   Using: Claude Code CLI (model: $REFLECTION_MODEL)"
  REFLECTION_OUTPUT=$(echo "$PROMPT" | claude --print --model "$REFLECTION_MODEL" 2>&1)
elif command -v aichat &>/dev/null; then
  LLM_USED="aichat"
  echo "   Using: aichat"
  REFLECTION_OUTPUT=$(echo "$PROMPT" | aichat 2>&1)
else
  echo ""
  echo "⚠️  No LLM CLI found. Install one of:"
  echo "   • Claude Code: npm install -g @anthropic-ai/claude-code"
  echo "   • aichat:      cargo install aichat"
  echo ""
  echo "   Alternatively, copy the prompt below and paste into your preferred LLM."
  echo "   Then manually save the output to:"
  echo "     $ARCHIVE_DIR/$TODAY.md"
  echo "     $REFLECTIONS_DIR/latest.md"
  echo ""
  echo "═══════════════════════════════════════════════════"
  echo "$PROMPT"
  echo "═══════════════════════════════════════════════════"
  exit 1
fi

echo ""
echo "✅ [run-reflection] Daily reflection complete!"
echo "   LLM used: $LLM_USED"
echo "   Reflection archive: $ARCHIVE_DIR/$TODAY.md"
echo "   Latest: $REFLECTIONS_DIR/latest.md"
echo "   Dashboard: $DASHBOARD"
echo "   Session prep: $SESSION_PREP"
echo "   Tracks analyzed: $TRACK_COUNT"

# ── Post-reflection: regenerate dashboard with updated data ──
DASHBOARD_SCRIPT="$WORKSPACE/scripts/update-dashboard.sh"
if [[ -x "$DASHBOARD_SCRIPT" ]]; then
  echo ""
  echo "📊 Regenerating dashboard with updated data..."
  bash "$DASHBOARD_SCRIPT"
fi
