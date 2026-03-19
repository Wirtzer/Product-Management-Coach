#!/bin/bash
# setup.sh — PM Coach Setup Wizard
# Usage: ./setup.sh
#
# Interactive setup that configures your profile, initializes learning tracks,
# and prepares the system for your first coaching session.
set -euo pipefail

WORKSPACE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG="$WORKSPACE/config.json"

echo "🎓 PM Coach — Setup Wizard"
echo "=========================="
echo ""

# ── Check dependencies ──
MISSING_DEPS=false

if ! command -v jq &>/dev/null; then
  echo "⚠️  jq is required. Install with:"
  echo "   macOS:  brew install jq"
  echo "   Ubuntu: sudo apt install jq"
  echo "   Arch:   sudo pacman -S jq"
  MISSING_DEPS=true
fi

if [[ "$MISSING_DEPS" == "true" ]]; then
  echo ""
  echo "Install the missing dependencies and run ./setup.sh again."
  exit 1
fi

echo "✅ Dependencies OK (bash, jq)"
echo ""

# ── Check for LLM CLI ──
LLM_CLI="none"
if command -v claude &>/dev/null; then
  LLM_CLI="claude"
  echo "✅ Claude Code CLI detected"
elif command -v aichat &>/dev/null; then
  LLM_CLI="aichat"
  echo "✅ aichat CLI detected"
else
  echo "⚠️  No LLM CLI found. You'll need one for coaching sessions."
  echo "   Recommended: Claude Code (npm install -g @anthropic-ai/claude-code)"
  echo "   Alternative: aichat (cargo install aichat)"
  echo "   Or: Open this project in Cursor/Windsurf (uses .cursorrules)"
fi
echo ""

# ── Interactive profile setup ──
echo "Let's set up your profile."
echo "(Press Enter to skip any field)"
echo ""

read -p "Your name: " USER_NAME
USER_NAME="${USER_NAME:-Learner}"

read -p "Your role (e.g., Product Manager, Senior PM, APM): " USER_ROLE
USER_ROLE="${USER_ROLE:-Product Manager}"

read -p "Years of PM experience (number): " USER_YEARS
USER_YEARS="${USER_YEARS:-0}"

read -p "Target companies (comma-separated, e.g., Google, Meta, Stripe): " USER_TARGETS
read -p "Focus areas (e.g., AI/ML, fintech, robotics, enterprise SaaS): " USER_FOCUS
read -p "Career goals (one sentence): " USER_GOALS
echo ""

# ── Knowledge directories ──
echo "Where do you keep PM learning materials? (articles, papers, notes)"
echo "You can add multiple directories later in config.json."
read -p "Knowledge directory path (or Enter for ./knowledge): " KNOWLEDGE_DIR
KNOWLEDGE_DIR="${KNOWLEDGE_DIR:-$WORKSPACE/knowledge}"
echo ""

# ── Model preference ──
echo "Which LLM model do you prefer for reflections?"
echo "  1) claude-sonnet-4-5 (recommended — fast and capable)"
echo "  2) claude-opus-4-5 (deeper analysis, slower)"
echo "  3) Custom (enter model name)"
read -p "Choice [1]: " MODEL_CHOICE

case "${MODEL_CHOICE:-1}" in
  1) REFLECTION_MODEL="claude-sonnet-4-5" ;;
  2) REFLECTION_MODEL="claude-opus-4-5" ;;
  3)
    read -p "Model name: " REFLECTION_MODEL
    REFLECTION_MODEL="${REFLECTION_MODEL:-claude-sonnet-4-5}"
    ;;
  *) REFLECTION_MODEL="claude-sonnet-4-5" ;;
esac

# ── Parse targets into JSON array ──
TARGETS_JSON="[]"
if [[ -n "$USER_TARGETS" ]]; then
  TARGETS_JSON=$(echo "$USER_TARGETS" | tr ',' '\n' | sed 's/^ *//;s/ *$//' | jq -R . | jq -s .)
fi

FOCUS_JSON="[]"
if [[ -n "$USER_FOCUS" ]]; then
  FOCUS_JSON=$(echo "$USER_FOCUS" | tr ',' '\n' | sed 's/^ *//;s/ *$//' | jq -R . | jq -s .)
fi

# ── Write config.json ──
echo "📝 Writing config.json..."
cat > "$CONFIG" << CONFIGEOF
{
  "version": "1.0.0",
  "user": {
    "name": $(echo "$USER_NAME" | jq -R .),
    "role": $(echo "$USER_ROLE" | jq -R .),
    "years_experience": $USER_YEARS,
    "target_companies": $TARGETS_JSON,
    "focus_areas": $FOCUS_JSON,
    "goals": $(echo "${USER_GOALS:-Become a world-class PM}" | jq -R .)
  },
  "model": {
    "default": "claude-sonnet-4-5",
    "deep": "$REFLECTION_MODEL"
  },
  "paths": {
    "knowledge_sources": [$(echo "$KNOWLEDGE_DIR" | jq -R .)]
  },
  "automation": {
    "reflection_cron": null,
    "session_prep_cron": null
  }
}
CONFIGEOF

# ── Create directories ──
echo "📁 Creating directory structure..."
mkdir -p "$WORKSPACE/learning/tracks"
mkdir -p "$WORKSPACE/learning/reflections/archive"
mkdir -p "$WORKSPACE/learning/pedagogy"
mkdir -p "$WORKSPACE/knowledge"
mkdir -p "$WORKSPACE/data/question-bank"
mkdir -p "$WORKSPACE/data/frameworks"
mkdir -p "$WORKSPACE/data/portfolio"

# ── Create memory.md if it doesn't exist ──
if [[ ! -f "$WORKSPACE/memory.md" ]]; then
  echo "🧠 Creating memory.md..."
  cat > "$WORKSPACE/memory.md" << MEMEOF
# PM Coach Memory

## Learner Profile
- **Name:** $USER_NAME
- **Role:** $USER_ROLE
- **Experience:** ${USER_YEARS} years
- **Goals:** ${USER_GOALS:-Become a world-class PM}

## Session Notes
_(Updated after each coaching session)_

## Key Decisions
_(Important decisions and their reasoning)_

## Strengths Observed
_(Patterns of strength the coach notices)_

## Growth Areas
_(Recurring areas for improvement)_
MEMEOF
fi

# ── Initialize tracks with today as next_review_date ──
echo "📊 Initializing learning tracks..."

# Check if tracks already exist
EXISTING_TRACKS=$(find "$WORKSPACE/learning/tracks" -name "track.json" 2>/dev/null | wc -l | tr -d ' ')
if (( EXISTING_TRACKS > 0 )); then
  echo "   Found $EXISTING_TRACKS existing tracks."
  read -p "   Reset all track review dates to today? (y/N): " RESET_DATES
  if [[ "${RESET_DATES:-n}" =~ ^[Yy] ]]; then
    for tf in "$WORKSPACE/learning/tracks"/*/track.json; do
      [[ -f "$tf" ]] || continue
      jq --arg today "$TODAY" '.spaced_repetition.next_review_date = $today' "$tf" > "${tf}.tmp" && mv "${tf}.tmp" "$tf"
    done
    echo "   ✅ All track review dates set to today"
  fi
else
  echo "   No tracks found. Tracks will be created when you first load the coaching system."
  echo "   The CLAUDE.md file includes starter track definitions."
fi

# ── Make scripts executable ──
echo "🔧 Making scripts executable..."
chmod +x "$WORKSPACE/scripts/"*.sh 2>/dev/null || true
chmod +x "$WORKSPACE/setup.sh" 2>/dev/null || true

# ── Create knowledge directory README ──
if [[ ! -f "$KNOWLEDGE_DIR/README.md" ]]; then
  mkdir -p "$KNOWLEDGE_DIR"
  cat > "$KNOWLEDGE_DIR/README.md" << KREADME
# Knowledge Sources

Drop articles, papers, and notes here as .md or .txt files.

Run \`./scripts/feed-knowledge-queue.sh\` to process new files into the
knowledge queue. The reflection engine will score them for relevance and
integrate them into your learning tracks.

## Recommended Structure

\`\`\`
knowledge/
├── articles/      # Blog posts, articles
├── papers/        # Research papers (as markdown summaries)
├── notes/         # Your own notes and observations
└── README.md      # This file
\`\`\`
KREADME
fi

# ── Summary ──
echo ""
echo "════════════════════════════════════════════"
echo "✅ PM Coach Setup Complete!"
echo "════════════════════════════════════════════"
echo ""
echo "Profile: $USER_NAME ($USER_ROLE, ${USER_YEARS}yr experience)"
echo "Model:   $REFLECTION_MODEL"
echo "LLM CLI: $LLM_CLI"
echo ""
echo "To start coaching:"
echo ""
if [[ "$LLM_CLI" == "claude" ]]; then
  echo "  1. Run 'claude' in this directory"
  echo "  2. Say 'let's go' to begin your first session"
elif [[ "$LLM_CLI" == "aichat" ]]; then
  echo "  1. Run 'aichat' in this directory"
  echo "  2. Paste the contents of CLAUDE.md as a system prompt"
  echo "  3. Say 'let's go' to begin your first session"
else
  echo "  Option A: Install Claude Code and run 'claude' here"
  echo "  Option B: Open this folder in Cursor (uses .cursorrules)"
  echo "  Option C: Open this folder in Windsurf (copy .cursorrules → .windsurfrules)"
fi
echo ""
echo "Optional automation:"
echo "  • Daily reflection: ./scripts/run-reflection.sh"
echo "  • Session prep:     ./scripts/prepare-session.sh"
echo "  • Add a topic:      ./scripts/add-topic.sh \"topic name\""
echo "  • Update dashboard:  ./scripts/update-dashboard.sh"
echo ""
echo "See README.md for full documentation."
