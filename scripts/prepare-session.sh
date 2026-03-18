#!/bin/bash
# prepare-session.sh — Generate learning/session-prep.md from track data
# Dependencies: bash, jq
# Usage: ./scripts/prepare-session.sh
#
# Reads all track.json files, identifies due/overdue tracks, reads their
# lesson plans and latest reflection, then generates a structured session
# preparation document. No LLM required — pure data organization.
set -euo pipefail

WORKSPACE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TRACKS_DIR="$WORKSPACE/learning/tracks"
SESSION_PREP="$WORKSPACE/learning/session-prep.md"
REFLECTIONS_LATEST="$WORKSPACE/learning/reflections/latest.md"
MEMORY="$WORKSPACE/memory.md"
TODAY=$(date +%Y-%m-%d)
NOW_ISO=$(date +%Y-%m-%dT%H:%M:%S%z)

# Weekly strategic pillar deep-dive rotation
DOW=$(date +%u)
case $DOW in
  1) STRATEGIC_FOCUS="decision-science"; STRATEGIC_LABEL="Decision Science" ;;
  2) STRATEGIC_FOCUS="strategic-vision"; STRATEGIC_LABEL="Strategic Vision" ;;
  3) STRATEGIC_FOCUS="narrative-influence"; STRATEGIC_LABEL="Narrative & Influence" ;;
  4) STRATEGIC_FOCUS="builders-credibility"; STRATEGIC_LABEL="Builder's Credibility" ;;
  5) STRATEGIC_FOCUS="network-intelligence"; STRATEGIC_LABEL="Network Intelligence" ;;
  6|7) STRATEGIC_FOCUS="review-weakest"; STRATEGIC_LABEL="Review Weakest Areas" ;;
esac

echo "📋 [prepare-session] Starting session preparation..."
echo "   Date: $TODAY"
echo "   Strategic focus: $STRATEGIC_LABEL"

# ── Verify dependencies ──
if ! command -v jq &>/dev/null; then
  echo "❌ jq is required. Install with: brew install jq"
  exit 1
fi

# ── Helper: date difference ──
days_diff() {
  local d1="$1" d2="$2"
  if date --version &>/dev/null 2>&1; then
    local e1=$(date -d "$d1" +%s 2>/dev/null || echo "0")
    local e2=$(date -d "$d2" +%s 2>/dev/null || echo "0")
  else
    local e1=$(date -j -f "%Y-%m-%d" "$d1" +%s 2>/dev/null || echo "0")
    local e2=$(date -j -f "%Y-%m-%d" "$d2" +%s 2>/dev/null || echo "0")
  fi
  [[ "$e1" == "0" || "$e2" == "0" ]] && echo "0" && return
  echo $(( (e1 - e2) / 86400 ))
}

# ── Collect and categorize tracks ──
echo "🔍 Scanning tracks..."

# Arrays for due tracks
declare -a DUE_OVERDUE_IDS=()
declare -a DUE_OVERDUE_NAMES=()
declare -a DUE_OVERDUE_DAYS=()

declare -a DUE_TODAY_IDS=()
declare -a DUE_TODAY_NAMES=()

declare -a NOT_DUE_IDS=()
declare -a NOT_DUE_NAMES=()
declare -a NOT_DUE_MASTERIES=()
declare -a NOT_DUE_DAYS=()

# All tracks summary
declare -a ALL_IDS=()
declare -a ALL_NAMES=()
declare -a ALL_PILLARS=()
declare -a ALL_EMOJIS=()
declare -a ALL_MASTERIES=()
declare -a ALL_CONVS=()
declare -a ALL_PHASES=()
declare -a ALL_APPROACHES=()
declare -a ALL_REVIEWS=()
declare -a ALL_SESSIONS=()

TRACK_COUNT=0

for track_dir in "$TRACKS_DIR"/*/; do
  track_file="$track_dir/track.json"
  [[ -f "$track_file" ]] || continue

  tid=$(jq -r '.track_id // "unknown"' "$track_file")
  tname=$(jq -r '.display_name // "Unknown"' "$track_file")
  tpillar=$(jq -r '.pillar // "uncategorized"' "$track_file")
  temoji=$(jq -r '.pillar_emoji // "📌"' "$track_file")
  tmastery=$(jq -r '.mastery.overall // 0' "$track_file")
  tconv=$(jq -r '.conversational_readiness.overall // 0' "$track_file")
  tphase=$(jq -r '.pedagogy.current_phase // "unknown"' "$track_file")
  tapproach=$(jq -r '.pedagogy.approach // "unknown"' "$track_file")
  tnext=$(jq -r '.spaced_repetition.next_review_date // "none"' "$track_file")
  tsessions=$(jq -r '.session_count // 0' "$track_file")

  ALL_IDS+=("$tid")
  ALL_NAMES+=("$tname")
  ALL_PILLARS+=("$tpillar")
  ALL_EMOJIS+=("$temoji")
  ALL_MASTERIES+=("$tmastery")
  ALL_CONVS+=("$tconv")
  ALL_PHASES+=("$tphase")
  ALL_APPROACHES+=("$tapproach")
  ALL_REVIEWS+=("$tnext")
  ALL_SESSIONS+=("$tsessions")
  TRACK_COUNT=$((TRACK_COUNT + 1))

  # Categorize by due status
  if [[ "$tnext" != "none" && "$tnext" != "null" ]]; then
    diff=$(days_diff "$tnext" "$TODAY")
    if (( diff < 0 )); then
      overdue=$(( -1 * diff ))
      DUE_OVERDUE_IDS+=("$tid")
      DUE_OVERDUE_NAMES+=("$tname")
      DUE_OVERDUE_DAYS+=("$overdue")
      echo "   🔴 $tname — ${overdue}d overdue"
    elif (( diff == 0 )); then
      DUE_TODAY_IDS+=("$tid")
      DUE_TODAY_NAMES+=("$tname")
      echo "   🟡 $tname — due today"
    else
      NOT_DUE_IDS+=("$tid")
      NOT_DUE_NAMES+=("$tname")
      NOT_DUE_MASTERIES+=("$tmastery")
      NOT_DUE_DAYS+=("$diff")
    fi
  else
    NOT_DUE_IDS+=("$tid")
    NOT_DUE_NAMES+=("$tname")
    NOT_DUE_MASTERIES+=("$tmastery")
    NOT_DUE_DAYS+=("999")
  fi
done

TOTAL_DUE=$(( ${#DUE_OVERDUE_IDS[@]} + ${#DUE_TODAY_IDS[@]} ))
echo "   Total: $TRACK_COUNT tracks, $TOTAL_DUE due"

# ── Read lesson plans for due tracks ──
echo "📖 Loading lesson plans for due tracks..."
DUE_LESSON_PLANS=""
DUE_ALL_IDS=("${DUE_OVERDUE_IDS[@]}" "${DUE_TODAY_IDS[@]}")

for tid in "${DUE_ALL_IDS[@]}"; do
  lp="$TRACKS_DIR/$tid/lesson-plan.md"
  if [[ -f "$lp" ]]; then
    DUE_LESSON_PLANS+=$'\n'"### Lesson Plan: $tid"$'\n'
    DUE_LESSON_PLANS+=$(cat "$lp")
    DUE_LESSON_PLANS+=$'\n'
    echo "   ✓ $tid"
  fi
done

# ── Read recent history for due tracks ──
DUE_HISTORIES=""
for tid in "${DUE_ALL_IDS[@]}"; do
  hf="$TRACKS_DIR/$tid/history.jsonl"
  if [[ -f "$hf" ]]; then
    recent=$(tail -3 "$hf" 2>/dev/null || true)
    if [[ -n "$recent" ]]; then
      DUE_HISTORIES+=$'\n'"### Recent History: $tid (last 3 sessions)"$'\n'
      DUE_HISTORIES+='```'$'\n'"$recent"$'\n''```'$'\n'
    fi
  fi
done

# ── Read latest reflection ──
REFLECTION_INSIGHTS=""
if [[ -f "$REFLECTIONS_LATEST" ]]; then
  REFLECTION_INSIGHTS=$(head -40 "$REFLECTIONS_LATEST")
  echo "📝 Read latest reflection"
fi

# ── Read memory ──
MEMORY_NOTES=""
if [[ -f "$MEMORY" ]]; then
  MEMORY_NOTES=$(head -30 "$MEMORY")
  echo "🧠 Read memory.md"
fi

# ── Identify conversation readiness gaps ──
CONV_GAPS=""
for i in $(seq 0 $((TRACK_COUNT - 1))); do
  gap=$((${ALL_MASTERIES[$i]} - ${ALL_CONVS[$i]}))
  if (( gap > 15 )); then
    CONV_GAPS+="- **${ALL_NAMES[$i]}**: mastery ${ALL_MASTERIES[$i]} vs conv ${ALL_CONVS[$i]} (Δ${gap}) — practice talking about this topic"$'\n'
  fi
done

# ── Identify weakest tracks ──
WEAKEST=""
for i in $(seq 0 $((TRACK_COUNT - 1))); do
  if (( ${ALL_MASTERIES[$i]} < 40 )); then
    WEAKEST+="- **${ALL_NAMES[$i]}** (${ALL_EMOJIS[$i]} ${ALL_PILLARS[$i]}): mastery ${ALL_MASTERIES[$i]} — needs focused attention"$'\n'
  fi
done

# ── Write session-prep.md ──
echo "📝 Writing session prep..."

{
  echo "# Session Prep — $TODAY"
  echo ""
  echo "> Generated: $NOW_ISO"
  echo ""

  # Strategic focus
  echo "## 🎯 Today's Strategic Deep-Dive: $STRATEGIC_LABEL"
  echo ""
  if [[ "$STRATEGIC_FOCUS" == "review-weakest" ]]; then
    echo "It's the weekend — good time to review your weakest areas and consolidate learning."
    echo ""
    if [[ -n "$WEAKEST" ]]; then
      echo "**Weakest tracks:**"
      echo "$WEAKEST"
    fi
  else
    # Check if any due tracks are in the strategic pillar
    strategic_due=false
    for i in $(seq 0 $((TRACK_COUNT - 1))); do
      if [[ "${ALL_PILLARS[$i]}" == "$STRATEGIC_FOCUS" ]]; then
        echo "Tracks in this pillar: **${ALL_NAMES[$i]}** (mastery: ${ALL_MASTERIES[$i]}, conv: ${ALL_CONVS[$i]}, phase: ${ALL_PHASES[$i]})"
      fi
    done
    echo ""
    echo "Even if these tracks aren't due today, consider weaving in this pillar's themes."
  fi
  echo ""

  # Due tracks
  echo "## 🔔 Due Tracks ($TOTAL_DUE)"
  echo ""

  if (( TOTAL_DUE == 0 )); then
    echo "No tracks are due today. Consider:"
    echo "- Working on the weakest track to build a stronger foundation"
    echo "- Practicing conversational readiness on tracks with gaps"
    echo "- Exploring today's strategic pillar ($STRATEGIC_LABEL)"
    echo ""

    # Show next upcoming
    echo "**Next upcoming reviews:**"
    for i in $(seq 0 $((${#NOT_DUE_IDS[@]} - 1))); do
      if (( ${NOT_DUE_DAYS[$i]} < 999 && ${NOT_DUE_DAYS[$i]} <= 7 )); then
        echo "- ${NOT_DUE_NAMES[$i]} — in ${NOT_DUE_DAYS[$i]}d"
      fi
    done
    echo ""
  else
    # Overdue first
    for i in $(seq 0 $((${#DUE_OVERDUE_IDS[@]} - 1))); do
      tid="${DUE_OVERDUE_IDS[$i]}"
      echo "### 🔴 ${DUE_OVERDUE_NAMES[$i]} (${DUE_OVERDUE_DAYS[$i]}d overdue)"
      echo ""
      # Find this track's details
      for j in $(seq 0 $((TRACK_COUNT - 1))); do
        if [[ "${ALL_IDS[$j]}" == "$tid" ]]; then
          echo "- **Pillar:** ${ALL_EMOJIS[$j]} ${ALL_PILLARS[$j]}"
          echo "- **Mastery:** ${ALL_MASTERIES[$j]}/100 | **Conv. Readiness:** ${ALL_CONVS[$j]}/100"
          echo "- **Phase:** ${ALL_PHASES[$j]} (${ALL_APPROACHES[$j]})"
          echo "- **Sessions:** ${ALL_SESSIONS[$j]}"
          break
        fi
      done
      echo ""
    done

    # Due today
    for i in $(seq 0 $((${#DUE_TODAY_IDS[@]} - 1))); do
      tid="${DUE_TODAY_IDS[$i]}"
      echo "### 🟡 ${DUE_TODAY_NAMES[$i]} (due today)"
      echo ""
      for j in $(seq 0 $((TRACK_COUNT - 1))); do
        if [[ "${ALL_IDS[$j]}" == "$tid" ]]; then
          echo "- **Pillar:** ${ALL_EMOJIS[$j]} ${ALL_PILLARS[$j]}"
          echo "- **Mastery:** ${ALL_MASTERIES[$j]}/100 | **Conv. Readiness:** ${ALL_CONVS[$j]}/100"
          echo "- **Phase:** ${ALL_PHASES[$j]} (${ALL_APPROACHES[$j]})"
          echo "- **Sessions:** ${ALL_SESSIONS[$j]}"
          break
        fi
      done
      echo ""
    done
  fi

  # Recommended session flow
  echo "## 📋 Recommended Session Flow (45–60 min)"
  echo ""
  if (( TOTAL_DUE >= 3 )); then
    echo "Multiple tracks due — prioritize overdue first, then today's due."
    echo ""
    echo "1. **Warm-up** (5 min) — Quick recall on the most overdue track"
    echo "2. **Deep Practice** (20 min) — Focus on the highest-priority due track"
    echo "3. **Second Track** (15 min) — Touch the second due track"
    echo "4. **Synthesis** (5 min) — Connect today's learning across tracks"
    echo "5. **Next Steps** (5 min) — Update scores and plan tomorrow"
  elif (( TOTAL_DUE >= 1 )); then
    echo "1. **Warm-up** (5 min) — Quick recall of last session's material"
    echo "2. **Deep Practice** (25 min) — Focus on the due track(s)"
    echo "3. **Strategic Exploration** (10 min) — Touch today's strategic pillar"
    echo "4. **Synthesis** (5 min) — Connect today's learning"
    echo "5. **Next Steps** (5 min) — Update scores and plan tomorrow"
  else
    echo "No tracks due — this is a good day for exploration and gap-filling."
    echo ""
    echo "1. **Review** (10 min) — Check latest reflection insights"
    echo "2. **Gap Work** (25 min) — Focus on weakest track or biggest conv. gap"
    echo "3. **Strategic Pillar** (15 min) — Explore $STRATEGIC_LABEL"
    echo "4. **Knowledge Intake** (10 min) — Process any pending knowledge queue items"
  fi
  echo ""

  # Lesson plans for due tracks
  if [[ -n "$DUE_LESSON_PLANS" ]]; then
    echo "## 📖 Lesson Plans for Due Tracks"
    echo "$DUE_LESSON_PLANS"
    echo ""
  fi

  # Recent history
  if [[ -n "$DUE_HISTORIES" ]]; then
    echo "## 📜 Recent Session History"
    echo "$DUE_HISTORIES"
    echo ""
  fi

  # Conversation readiness gaps
  if [[ -n "$CONV_GAPS" ]]; then
    echo "## 💬 Conversational Readiness Gaps"
    echo ""
    echo "These tracks have mastery significantly ahead of conversational readiness."
    echo "Consider an expert persona test to close the gap."
    echo ""
    echo "$CONV_GAPS"
    echo ""
  fi

  # Reflection insights
  if [[ -n "$REFLECTION_INSIGHTS" ]]; then
    echo "## 📝 Latest Reflection Insights"
    echo ""
    echo '```'
    echo "$REFLECTION_INSIGHTS"
    echo '```'
    echo ""
  fi

  # Memory context
  if [[ -n "$MEMORY_NOTES" ]]; then
    echo "## 🧠 Context from Memory"
    echo ""
    echo "$MEMORY_NOTES"
    echo ""
  fi

  # All tracks overview
  echo "## 📊 All Tracks Overview"
  echo ""
  echo "| Track | Pillar | Mastery | Conv. | Phase | Sessions |"
  echo "|-------|--------|---------|-------|-------|----------|"
  for i in $(seq 0 $((TRACK_COUNT - 1))); do
    echo "| ${ALL_NAMES[$i]} | ${ALL_EMOJIS[$i]} | ${ALL_MASTERIES[$i]} | ${ALL_CONVS[$i]} | ${ALL_PHASES[$i]} | ${ALL_SESSIONS[$i]} |"
  done
  echo ""

  echo "---"
  echo ""
  echo "*Session prep generated by \`scripts/prepare-session.sh\` on $TODAY.*"

} > "$SESSION_PREP"

echo ""
echo "✅ [prepare-session] Session prep written to $SESSION_PREP"
echo "   Due tracks: $TOTAL_DUE ($OVERDUE_COUNT overdue)"
echo "   Strategic focus: $STRATEGIC_LABEL"
