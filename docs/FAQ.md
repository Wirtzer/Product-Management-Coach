# Frequently Asked Questions

---

## General

### How is this different from just using ChatGPT?

Three critical differences:

1. **Memory:** PM Coach remembers everything — your scores, which techniques worked, where you struggle, and when you last practiced each topic. ChatGPT starts fresh every conversation.

2. **Adaptation:** The system monitors technique effectiveness and automatically retires approaches that aren't working for you. It also advances you through learning phases based on measured progress, not just time.

3. **Spaced Repetition:** Topics you've mastered get reviewed less frequently (up to 30-day intervals). Topics you struggle with appear daily. This is based on decades of learning science research (SM-2 algorithm) — it's how medical students learn thousands of facts and how language learners build fluency.

ChatGPT is a great general tool. PM Coach is a specialized coaching system that gets better the more you use it.

### Do I need Claude Code?

No, but it's the recommended platform. PM Coach works with:
- **Claude Code** (best experience — auto-loads system prompt, full file access)
- **Cursor** (uses `.cursorrules`)
- **Windsurf** (copy `.cursorrules` to `.windsurfrules`)
- **Any LLM with file access** (manual setup required)

See [docs/PLATFORMS.md](PLATFORMS.md) for detailed setup per platform.

The automation scripts (`run-reflection.sh`, `feed-knowledge-queue.sh`) need an LLM CLI (`claude` or `aichat`), but the pure-computation scripts (`update-dashboard.sh`, `prepare-session.sh`, `add-topic.sh`) work with just `bash` and `jq`.

### How much does it cost?

PM Coach itself is free and open source. The costs come from the LLM usage:
- **Coaching sessions:** Varies by model and session length. A typical 30-minute session with Claude Sonnet costs a few dollars.
- **Daily reflection:** One LLM call per day (~$0.50-2.00 depending on model and track count)
- **Knowledge pipeline:** One LLM call per batch of new sources (~$0.10-0.50)

The `update-dashboard.sh` and `prepare-session.sh` scripts use zero LLM calls — they're pure bash + jq.

### Can I use this for non-PM coaching?

Yes! The architecture is completely domain-agnostic. To adapt for another field:

1. Replace the learning tracks (track.json files)
2. Modify the pedagogy approaches
3. Create domain-specific expert personas
4. Update the system prompt (CLAUDE.md)
5. Add relevant framework references

See [docs/CUSTOMIZATION.md](CUSTOMIZATION.md#adapt-for-non-pm-domains) for a detailed guide.

People have used similar architectures for software engineering, data science, design, and language learning.

---

## Learning System

### How does the spaced repetition work?

PM Coach uses a simplified variant of the [SM-2 algorithm](https://en.wikipedia.org/wiki/SuperMemo#Description_of_SM-2_algorithm) (the same algorithm behind Anki and SuperMemo):

- Each track has a review interval (starting at 2 days)
- After each session, the interval is adjusted based on your performance:
  - Score ≥ 90: interval × 2.5 (max 30 days)
  - Score 80-89: interval × 2.0
  - Score 70-79: interval × 1.5
  - Score 55-69: interval resets to 1 day
  - Score < 55: interval resets to 1 day + flagged for immediate review
- `next_review_date = last_session_date + new_interval`

The effect: topics you know well are reviewed monthly, while struggling topics appear daily until they stabilize. This is proven to be dramatically more efficient than massed practice (studying everything equally).

### How long until I see results?

Typical progression:
- **Week 1-2:** The system learns your baseline. Scores may feel low — that's calibration, not failure.
- **Week 3-4:** Techniques start adapting to your learning style. You'll notice some topics "clicking."
- **Month 2:** Phase advancements begin. Spaced repetition settles into a rhythm. You start retaining frameworks without conscious effort.
- **Month 3+:** Conversational readiness improves. Expert persona tests feel more like actual conversations and less like quizzes.

Consistency matters more than session length. 30 minutes daily beats 3 hours weekly.

### What are the 13 tracks?

The default tracks cover PM excellence for AI/tech companies:

| Pillar | Tracks |
|--------|--------|
| 🔬 Technical Depth | AI Foundations, World Models, Agent Architectures, Robot Learning |
| 🛠️ PM Craft | Product Sense, PM Frameworks |
| 🎯 Interview Excellence | LP Stories |
| 🔭 Strategic Vision | AI Product Strategy |
| ✍️ Narrative & Influence | Narrative & Influence |
| 🕸️ Network Intelligence | Network Intelligence, Industry Landscape |
| 🔨 Builder's Credibility | Builder's Credibility |
| 🧠 Decision Science | Decision Science |

You can add, remove, or modify tracks to match your goals. See [docs/CUSTOMIZATION.md](CUSTOMIZATION.md#add-a-new-learning-track).

### What if I disagree with a score?

Track scores are stored in plain JSON. You can edit them directly:

```bash
# Open the track file
vim learning/tracks/pm-frameworks/track.json

# Or use jq to update a specific dimension
jq '.mastery.dimensions.core_concepts.score = 65' \
  learning/tracks/pm-frameworks/track.json > tmp.json && \
  mv tmp.json learning/tracks/pm-frameworks/track.json
```

The system is designed to be transparent and hackable. Your judgment about your own abilities is valid — adjust scores if they don't feel right.

---

## Technical

### What LLM models work best?

For **coaching sessions:**
- **Best:** Claude Sonnet 4.5+ or Claude Opus — strong instruction following, nuanced feedback
- **Good:** GPT-4+ — works well, may need minor prompt adjustments
- **Adequate:** Any model with strong reasoning and file access

For **reflections:**
- **Best:** Claude Sonnet 4.5+ — handles the complex multi-file analysis well
- **Good:** Any model that can process ~20K tokens of context and write structured output

The system was designed and tested primarily with Claude models. Other models should work but may need tuning.

### Can I use this offline?

Partially:
- ✅ `update-dashboard.sh` — Works fully offline (bash + jq)
- ✅ `prepare-session.sh` — Works fully offline (bash + jq)
- ✅ `add-topic.sh` — Works fully offline (bash + jq)
- ❌ `run-reflection.sh` — Needs an LLM (but prints the prompt for manual use if no CLI is found)
- ❌ `feed-knowledge-queue.sh` — Falls back to basic metadata extraction without LLM
- ❌ Coaching sessions — Need an LLM

### How do I back up my progress?

Everything is in flat files. Use git:

```bash
git init
git add -A
git commit -m "Initial state"

# After each session:
git add -A
git commit -m "Session $(date +%Y-%m-%d)"
```

Or sync the entire directory to a cloud backup. The state is fully portable — copy the directory to a new machine and everything works.

### Can multiple people use the same repo?

The system is designed for a single learner. For multiple people:
- **Option A:** Each person forks the repo
- **Option B:** Use git branches per person
- **Option C:** Separate `config.json` and `memory.md` files (more complex)

Option A (individual forks) is recommended.

---

## Troubleshooting

### "jq is required but not found"

Install jq:
```bash
# macOS
brew install jq

# Ubuntu/Debian
sudo apt install jq

# Arch Linux
sudo pacman -S jq

# Windows (WSL)
sudo apt install jq
```

### Dashboard shows all zeros

This is normal on first setup. Scores initialize at 30/100 (mastery) and 20/100 (conversational readiness). They update after your first coaching sessions.

### Reflection script hangs

The reflection script sends a large prompt to the LLM — it can take 2-5 minutes depending on model and track count. If it truly hangs:
1. Check your API key is valid
2. Try a faster model: `REFLECTION_MODEL=claude-sonnet-4-5 ./scripts/run-reflection.sh`
3. Check the script output for error messages

### "No LLM CLI found"

Install one:
```bash
# Claude Code (recommended)
npm install -g @anthropic-ai/claude-code

# aichat (alternative, supports multiple providers)
cargo install aichat
```

The reflection script will print the full prompt if no CLI is found — you can paste it manually into any LLM.

### Date calculations are wrong on Linux

The scripts handle both BSD (macOS) and GNU (Linux) date commands. If you encounter issues, ensure you're running a recent version of GNU coreutils:
```bash
date --version  # Should show GNU coreutils
```
