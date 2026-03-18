#!/bin/bash
# update-dashboard.sh — Regenerate learning/dashboard.md from track data
# Dependencies: bash, jq
# Usage: ./scripts/update-dashboard.sh
#
# Reads all learning/tracks/*/track.json files, computes per-pillar averages,
# overall PM Excellence score, conversational readiness, identifies due/overdue
# reviews, generates ASCII progress bars, and writes learning/dashboard.md.
#
# No LLM required — pure bash + jq computation.
set -euo pipefail

WORKSPACE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TRACKS_DIR="$WORKSPACE/learning/tracks"
DASHBOARD="$WORKSPACE/learning/dashboard.md"
TODAY=$(date +%Y-%m-%d)
NOW_ISO=$(date +%Y-%m-%dT%H:%M:%S%z)

echo "📊 [update-dashboard] Starting dashboard regeneration..."
echo "   Workspace: $WORKSPACE"
echo "   Date: $TODAY"

# ── Verify dependencies ──
if ! command -v jq &>/dev/null; then
  echo "❌ jq is required but not found. Install with:"
  echo "   macOS: brew install jq"
  echo "   Linux: sudo apt install jq"
  exit 1
fi

if [[ ! -d "$TRACKS_DIR" ]]; then
  echo "❌ Tracks directory not found: $TRACKS_DIR"
  echo "   Run ./setup.sh first to initialize the project."
  exit 1
fi

# ── Helper: ASCII progress bar ──
# Usage: progress_bar <score> <width>
# Returns: [████████░░░░░░░░░░░░] XX%
progress_bar() {
  local score="${1:-0}"
  local width="${2:-20}"
  local filled=$(( score * width / 100 ))
  local empty=$(( width - filled ))
  local bar=""

  for ((i=0; i<filled; i++)); do bar+="█"; done
  for ((i=0; i<empty; i++)); do bar+="░"; done

  printf "[%s] %3d%%" "$bar" "$score"
}

# ── Helper: date difference in days ──
# Usage: days_diff <date1_YYYY-MM-DD> <date2_YYYY-MM-DD>
# Returns: date1 - date2 in days (positive if date1 is later)
days_diff() {
  local d1="$1" d2="$2"
  local e1 e2

  if date --version &>/dev/null 2>&1; then
    # GNU date
    e1=$(date -d "$d1" +%s 2>/dev/null || echo "0")
    e2=$(date -d "$d2" +%s 2>/dev/null || echo "0")
  else
    # BSD/macOS date
    e1=$(date -j -f "%Y-%m-%d" "$d1" +%s 2>/dev/null || echo "0")
    e2=$(date -j -f "%Y-%m-%d" "$d2" +%s 2>/dev/null || echo "0")
  fi

  if [[ "$e1" == "0" || "$e2" == "0" ]]; then
    echo "0"
    return
  fi

  echo $(( (e1 - e2) / 86400 ))
}

# ── Collect track data ──
echo "📂 Reading track files..."

declare -a TRACK_IDS=()
declare -a TRACK_NAMES=()
declare -a TRACK_PILLARS=()
declare -a TRACK_PILLAR_EMOJIS=()
declare -a TRACK_MASTERIES=()
declare -a TRACK_CONVS=()
declare -a TRACK_NEXT_REVIEWS=()
declare -a TRACK_INTERVALS=()
declare -a TRACK_SESSIONS=()
TRACK_COUNT=0

for track_dir in "$TRACKS_DIR"/*/; do
  track_file="$track_dir/track.json"
  [[ -f "$track_file" ]] || continue

  TRACK_IDS+=("$(jq -r '.track_id // "unknown"' "$track_file")")
  TRACK_NAMES+=("$(jq -r '.display_name // "Unknown"' "$track_file")")
  TRACK_PILLARS+=("$(jq -r '.pillar // "uncategorized"' "$track_file")")
  TRACK_PILLAR_EMOJIS+=("$(jq -r '.pillar_emoji // "📌"' "$track_file")")
  TRACK_MASTERIES+=("$(jq -r '.mastery.overall // 0' "$track_file")")
  TRACK_CONVS+=("$(jq -r '.conversational_readiness.overall // 0' "$track_file")")
  TRACK_NEXT_REVIEWS+=("$(jq -r '.spaced_repetition.next_review_date // "none"' "$track_file")")
  TRACK_INTERVALS+=("$(jq -r '.spaced_repetition.current_interval_days // 0' "$track_file")")
  TRACK_SESSIONS+=("$(jq -r '.session_count // 0' "$track_file")")

  echo "   ✓ $(jq -r '.display_name' "$track_file")"
  TRACK_COUNT=$((TRACK_COUNT + 1))
done

if [[ $TRACK_COUNT -eq 0 ]]; then
  echo "❌ No track.json files found in $TRACKS_DIR"
  exit 1
fi
echo "   Found $TRACK_COUNT tracks"

# ── Compute unique pillars and their scores ──
echo "🧮 Computing pillar scores..."

declare -a UNIQUE_PILLARS=()
declare -a PILLAR_EMOJIS_MAP=()
declare -a PILLAR_AVG_MASTERIES=()
declare -a PILLAR_AVG_CONVS=()
declare -a PILLAR_TRACK_COUNTS=()

# Get unique pillars
for p in "${TRACK_PILLARS[@]}"; do
  found=false
  for up in "${UNIQUE_PILLARS[@]}"; do
    if [[ "$up" == "$p" ]]; then found=true; break; fi
  done
  if [[ "$found" == "false" ]]; then
    UNIQUE_PILLARS+=("$p")
  fi
done

for pillar in "${UNIQUE_PILLARS[@]}"; do
  sum_m=0
  sum_c=0
  count=0
  emoji="📌"

  for i in $(seq 0 $((TRACK_COUNT - 1))); do
    if [[ "${TRACK_PILLARS[$i]}" == "$pillar" ]]; then
      sum_m=$((sum_m + ${TRACK_MASTERIES[$i]}))
      sum_c=$((sum_c + ${TRACK_CONVS[$i]}))
      count=$((count + 1))
      emoji="${TRACK_PILLAR_EMOJIS[$i]}"
    fi
  done

  if (( count > 0 )); then
    avg_m=$((sum_m / count))
    avg_c=$((sum_c / count))
  else
    avg_m=0
    avg_c=0
  fi

  PILLAR_EMOJIS_MAP+=("$emoji")
  PILLAR_AVG_MASTERIES+=("$avg_m")
  PILLAR_AVG_CONVS+=("$avg_c")
  PILLAR_TRACK_COUNTS+=("$count")

  echo "   $emoji $pillar: mastery=$avg_m, conv=$avg_c ($count tracks)"
done

# ── Compute overall scores ──
PILLAR_COUNT=${#UNIQUE_PILLARS[@]}
TOTAL_M=0
TOTAL_C=0

for i in $(seq 0 $((PILLAR_COUNT - 1))); do
  TOTAL_M=$((TOTAL_M + ${PILLAR_AVG_MASTERIES[$i]}))
  TOTAL_C=$((TOTAL_C + ${PILLAR_AVG_CONVS[$i]}))
done

if (( PILLAR_COUNT > 0 )); then
  OVERALL_MASTERY=$((TOTAL_M / PILLAR_COUNT))
  OVERALL_CONV=$((TOTAL_C / PILLAR_COUNT))
else
  OVERALL_MASTERY=0
  OVERALL_CONV=0
fi

echo "   📈 Overall PM Excellence: $OVERALL_MASTERY/100"
echo "   💬 Overall Conv. Readiness: $OVERALL_CONV/100"

# ── Identify due/overdue reviews ──
echo "🔔 Checking for due reviews..."

DUE_LINES=""
DUE_COUNT=0
OVERDUE_COUNT=0

for i in $(seq 0 $((TRACK_COUNT - 1))); do
  next="${TRACK_NEXT_REVIEWS[$i]}"
  [[ "$next" == "none" || "$next" == "null" ]] && continue

  diff=$(days_diff "$next" "$TODAY")

  if (( diff <= 0 )); then
    DUE_COUNT=$((DUE_COUNT + 1))
    if (( diff < 0 )); then
      overdue=$(( -1 * diff ))
      DUE_LINES+="| 🔴 | ${TRACK_NAMES[$i]} | ${overdue}d overdue | mastery: ${TRACK_MASTERIES[$i]}, conv: ${TRACK_CONVS[$i]} |"$'\n'
      OVERDUE_COUNT=$((OVERDUE_COUNT + 1))
    else
      DUE_LINES+="| 🟡 | ${TRACK_NAMES[$i]} | Due today | mastery: ${TRACK_MASTERIES[$i]}, conv: ${TRACK_CONVS[$i]} |"$'\n'
    fi
  fi
done

echo "   $DUE_COUNT tracks due ($OVERDUE_COUNT overdue)"

# ── Find alerts: conversational gaps ──
ALERT_LINES=""
for i in $(seq 0 $((TRACK_COUNT - 1))); do
  gap=$((${TRACK_MASTERIES[$i]} - ${TRACK_CONVS[$i]}))
  if (( gap > 15 )); then
    ALERT_LINES+="- ⚠️ **${TRACK_NAMES[$i]}**: Conversational gap — mastery ${TRACK_MASTERIES[$i]} vs conv. readiness ${TRACK_CONVS[$i]} (Δ${gap})"$'\n'
  fi
done

for i in $(seq 0 $((TRACK_COUNT - 1))); do
  if (( ${TRACK_MASTERIES[$i]} < 40 )); then
    ALERT_LINES+="- 🔴 **${TRACK_NAMES[$i]}**: Mastery below 40 — needs focused attention"$'\n'
  fi
done

# ── Write the dashboard ──
echo "📝 Writing dashboard..."

{
  cat <<HEADER
# PM Excellence Dashboard

> **Updated:** $NOW_ISO
> **Tracks:** $TRACK_COUNT | **Pillars:** $PILLAR_COUNT

---

## Overall Scores

**PM Excellence Score**
$(progress_bar $OVERALL_MASTERY 30)

**Conversational Readiness**
$(progress_bar $OVERALL_CONV 30)

---
HEADER

  # ── Due Reviews section ──
  if (( DUE_COUNT > 0 )); then
    echo ""
    echo "## 🔔 Due Reviews ($DUE_COUNT tracks, $OVERDUE_COUNT overdue)"
    echo ""
    echo "| Status | Track | Review | Scores |"
    echo "|--------|-------|--------|--------|"
    echo -n "$DUE_LINES"
    echo ""
  else
    echo ""
    echo "## 🔔 Due Reviews"
    echo ""
    echo "✅ No tracks due for review today."
    echo ""
  fi

  # ── Alerts section ──
  if [[ -n "$ALERT_LINES" ]]; then
    echo "## ⚠️ Alerts"
    echo ""
    echo -n "$ALERT_LINES"
    echo ""
  fi

  echo "---"
  echo ""

  # ── Per-pillar sections ──
  for pi in $(seq 0 $((PILLAR_COUNT - 1))); do
    pillar="${UNIQUE_PILLARS[$pi]}"
    emoji="${PILLAR_EMOJIS_MAP[$pi]}"
    avg_m="${PILLAR_AVG_MASTERIES[$pi]}"
    avg_c="${PILLAR_AVG_CONVS[$pi]}"
    tcount="${PILLAR_TRACK_COUNTS[$pi]}"

    # Convert pillar slug to title case
    pillar_title=$(echo "$pillar" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1')

    echo "## $emoji $pillar_title"
    echo ""
    echo "**Pillar Average:** $(progress_bar $avg_m 20) mastery | $(progress_bar $avg_c 20) conv."
    echo ""
    echo "| Track | Mastery | Conv. Ready | Sessions | Next Review | Status |"
    echo "|-------|---------|-------------|----------|-------------|--------|"

    for i in $(seq 0 $((TRACK_COUNT - 1))); do
      [[ "${TRACK_PILLARS[$i]}" == "$pillar" ]] || continue

      name="${TRACK_NAMES[$i]}"
      m="${TRACK_MASTERIES[$i]}"
      c="${TRACK_CONVS[$i]}"
      s="${TRACK_SESSIONS[$i]}"
      nr="${TRACK_NEXT_REVIEWS[$i]}"
      interval="${TRACK_INTERVALS[$i]}"

      # Compute review status
      review_col="—"
      status_col="🟢 OK"

      if [[ "$nr" != "none" && "$nr" != "null" ]]; then
        diff=$(days_diff "$nr" "$TODAY")
        if (( diff < 0 )); then
          overdue=$(( -1 * diff ))
          review_col="🔴 ${overdue}d overdue"
          status_col="🔴 Overdue"
        elif (( diff == 0 )); then
          review_col="🟡 Today"
          status_col="🟡 Due"
        else
          review_col="🟢 in ${diff}d"
          status_col="🟢 OK"
        fi
      fi

      # Check for conversational gap
      gap=$((m - c))
      if (( gap > 15 )); then
        status_col="🟡 Conv. gap"
      fi

      # Check for weak mastery
      if (( m < 40 )); then
        status_col="🔴 Weak"
      fi

      echo "| $name | $m | $c | $s | $review_col | $status_col |"
    done

    echo ""
  done

  # ── Summary footer ──
  echo "---"
  echo ""
  echo "*Dashboard generated by \`scripts/update-dashboard.sh\` on $TODAY.*"
  echo "*Run \`./scripts/update-dashboard.sh\` to refresh.*"

} > "$DASHBOARD"

echo ""
echo "✅ [update-dashboard] Dashboard written to $DASHBOARD"
echo "   Overall PM Excellence: $OVERALL_MASTERY/100"
echo "   Overall Conv. Readiness: $OVERALL_CONV/100"
echo "   Tracks: $TRACK_COUNT | Pillars: $PILLAR_COUNT | Due: $DUE_COUNT"
