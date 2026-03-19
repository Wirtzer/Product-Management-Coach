# 🎓 PM Coach

**An adaptive AI coaching system that uses spaced repetition, 10 teaching approaches, and expert personas to make you a world-class Product Manager.**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform: Claude Code](https://img.shields.io/badge/Platform-Claude%20Code-orange.svg)](#-quickstart-5-minutes)
[![Platform: Cursor](https://img.shields.io/badge/Platform-Cursor-purple.svg)](#-platform-compatibility)

**Architected by Alex Wirtzer.**
Got feedback? Send it to Genie.Wirtzer@gmail.com and we will look into it!

---

## What is This?

PM Coach is a complete coaching system that turns your AI coding assistant into a persistent, adaptive PM tutor. Unlike asking ChatGPT to "help me prepare for PM interviews," PM Coach remembers everything — your strengths, your gaps, which teaching techniques work for you, and exactly when you need to review each topic.

The system tracks your progress across **13 learning tracks** organized into **8 pillars** of PM excellence. It uses a spaced repetition algorithm (SM-2 variant) to schedule reviews at optimal intervals, rotates through **10 pedagogical approaches** with automatic technique retirement when something isn't working, and tests your conversational readiness through **8 expert persona simulations** — from a "VP of Research at DeepMind" probing your AI knowledge to a "Principal Engineer pushing back" on your product decisions.

Everything is stored in plain text files: JSON for state, JSONL for history, Markdown for lesson plans and reflections. You can read every piece of your learning state, version-control your progress, and customize anything. There's no server, no database, no subscription — just you, your AI, and a well-structured file system.

---

## ⚡ Quickstart (5 minutes)

### 1. Clone the Repository

```bash
git clone https://github.com/Wirtzer/Product-Management-Coach.git
cd Product-Management-Coach
```

### 2. Run Setup

```bash
./setup.sh
```

The interactive wizard will configure your profile, check dependencies, and initialize the system.

### 3. Start Coaching

**With Claude Code (recommended):**
```bash
claude
# Then say: "let's go"
```

**With Cursor:**
Open the `pm-coach` folder in Cursor. The `.cursorrules` file loads automatically. Start a new chat and say "let's go."

**With Windsurf:**
Copy `.cursorrules` to `.windsurfrules`, then open the folder in Windsurf.

### 4. Your First Session

The coach will:
1. Read your profile and current track state
2. Identify what's due for review (on first run: everything)
3. Start with your weakest area or a framework introduction
4. Score your responses and update your tracks
5. Plan the next session

---

## Why PM Coach?

### The Problem with Generic AI Coaching

Asking ChatGPT "Help me prepare for PM interviews" gets you a generic answer. Ask again tomorrow and it has no memory of yesterday. You're starting from zero every time.

PM skills are built through **deliberate practice with feedback loops** — the same way musicians practice scales or athletes drill fundamentals. You need:
- **Persistence:** Track what you've practiced and how you scored
- **Spacing:** Review topics at optimal intervals for long-term retention
- **Adaptation:** Retire techniques that aren't working, intensify what is
- **Pressure testing:** Simulate real conversations, not just Q&A

PM Coach provides all four.

### How It Compares

| Feature | ChatGPT / Generic AI | PM Coach |
|---------|---------------------|----------|
| Remembers past sessions | ❌ Starts fresh each time | ✅ 13 tracks with persistent scores and full history |
| Adapts teaching approach | ❌ Same approach every time | ✅ 10 pedagogy approaches with automatic technique rotation |
| Spaced repetition | ❌ No scheduling | ✅ SM-2 variant with per-track intervals (1-30 days) |
| Expert persona tests | ❌ Generic role-play | ✅ 8 calibrated expert personas with scoring rubrics |
| Automated reflection | ❌ No analysis loop | ✅ Nightly reflection analyzes patterns and updates plans |
| PM-specific frameworks | Generic knowledge | ✅ Deep framework library: CIRCLES, RICE, JTBD, Working Backwards, and more |
| Progress tracking | None | ✅ Dashboard with 8 pillars, per-dimension scoring, trend analysis |
| Knowledge pipeline | Manual | ✅ Feed articles and papers → auto-scored and routed to tracks |
| Add your own interview questions | N/A | ✅ Structured question bank with company tags and scoring |

---

## 🏗️ Architecture

```
┌──────────────────────────────────────────────────┐
│              YOUR COACHING SESSION                │
│                                                  │
│  You ←→ LLM ←→ CLAUDE.md (system prompt)        │
│              │                                    │
│              ├─ reads track state + lesson plans   │
│              ├─ reads pedagogy approaches          │
│              ├─ reads memory + frameworks          │
│              │                                    │
│              └─ writes updated scores + history    │
└──────────────────────┬───────────────────────────┘
                       │
          ┌────────────┼────────────┐
          ▼            ▼            ▼
   ┌─────────────┐ ┌────────┐ ┌──────────┐
   │ Reflection   │ │Session │ │Knowledge │
   │ Engine (LLM) │ │Prep    │ │Pipeline  │
   └──────┬──────┘ └───┬────┘ └────┬─────┘
          │            │           │
          ▼            ▼           ▼
   ┌──────────────────────────────────────┐
   │         FLAT FILE STATE              │
   │  tracks/ → JSON scores + JSONL logs  │
   │  pedagogy/ → teaching methodology    │
   │  reflections/ → analysis archive     │
   │  dashboard.md → progress overview    │
   │  memory.md → session context         │
   └──────────────────────────────────────┘
```

All state is in human-readable flat files. No database. Git-friendly. See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) for the full technical deep-dive.

---

## 📚 The 8 Pillars

PM Coach organizes learning into 8 pillars covering the full spectrum of PM excellence:

| # | Pillar | Tracks | What You'll Learn |
|---|--------|--------|-------------------|
| 1 | 🔬 **Technical Depth** | AI Foundations, World Models, Agent Architectures, Robot Learning | AI/ML concepts, model architectures, research landscape |
| 2 | 🛠️ **PM Craft** | Product Sense, PM Frameworks | Product intuition, CIRCLES, RICE, JTBD, metrics design |
| 3 | 🎯 **Interview Excellence** | LP Stories | STAR stories, behavioral answers, delivery under pressure |
| 4 | 🔭 **Strategic Vision** | AI Product Strategy | Industry landscape, product strategy, market analysis |
| 5 | ✍️ **Narrative & Influence** | Narrative & Influence | Product narratives, strategy memos, stakeholder communication |
| 6 | 🕸️ **Network Intelligence** | Network Intelligence, Industry Landscape | Talent flows, company dynamics, ecosystem mapping |
| 7 | 🔨 **Builder's Credibility** | Builder's Credibility | Technical specs, architecture review, prototyping |
| 8 | 🧠 **Decision Science** | Decision Science | Cognitive biases, decision frameworks, probabilistic thinking |

Each pillar contains 1-4 tracks. Each track has its own mastery scores, conversational readiness scores, spaced repetition schedule, and lesson plan.

---

## 🧠 The Learning Science

### Spaced Repetition

PM Coach uses a 5-tier quality system adapted from the SM-2 algorithm:

| Quality | Score Range | Interval Change |
|---------|------------|-----------------|
| 5 — Perfect | ≥ 90 | × 2.5 (max 30d) |
| 4 — Good | 80–89 | × 2.0 (max 30d) |
| 3 — Adequate | 70–79 | × 1.5 (max 30d) |
| 2 — Poor | 55–69 | Reset to 1 day |
| 1 — Fail | < 55 | Reset to 1 day + flag |

Tracks you master get reviewed monthly. Tracks you struggle with appear daily until they stabilize.

### 10 Teaching Approaches

Each approach has a 5-phase progression with specific techniques per phase:

1. **Storytelling Practice** — Structure and deliver STAR stories fluently
2. **Framework Application** — Internalize PM frameworks for automatic deployment
3. **Case Analysis** — Pattern recognition and structured analytical thinking
4. **Concept Learning** — Deep understanding through concrete-to-abstract progression
5. **AI Concept Learning** — Technical AI depth for expert-level conversation
6. **Industry Case Analysis** — Current, deep knowledge of the AI landscape
7. **Interview Drill** — Integration of all skills under realistic pressure
8. **Craft-Based Practice** — Persuasive communication through iterative writing
9. **Pattern Recognition & Briefing** — Industry awareness and intelligence synthesis
10. **Project-Based Learning** — Technical credibility through hands-on work

The reflection engine monitors which techniques work for you and automatically retires low-performing ones after 3+ sessions.

### Expert Persona Tests

8 domain expert personas test your conversational readiness — your ability to discuss topics naturally, not just answer quiz questions:

| Persona | Tests | Key Emphasis |
|---------|-------|--------------|
| 🔬 VP of Research (DeepMind) | Technical depth | Accuracy, depth, current awareness |
| 🛠️ Principal Engineer | PM craft | Depth, opinion formation, accuracy |
| 🎯 Bar Raiser | Interview skills | Accuracy, fluency, depth |
| 🔭 CPO (frontier AI company) | Strategic vision | Opinion formation, current awareness |
| ✍️ VP of Product | Narrative & influence | Opinion formation, fluency |
| 🕸️ Conference Attendee | Network intelligence | Current awareness, opinion formation |
| 🔨 Hiring Manager | Builder's credibility | Accuracy, depth, builder fluency |
| 🧠 Board Member | Decision science | Depth, opinion formation, accuracy |

Each test is scored on 5 dimensions (100 points total) and updates your conversational readiness scores.

### Phase Advancement

You advance to the next phase when **all three criteria** are met:

1. **Quantitative:** Mastery score for the current phase's target dimensions exceeds 75/100
2. **Qualitative:** You demonstrate the phase's mastery signals in 2+ consecutive sessions
3. **Spaced Repetition:** At least one successful review after a 3+ day gap

---

## 🎯 Features

- **Adaptive Coaching** — Teaching approach evolves based on what works for you
- **Mock Interviews** — Company-specific with structured STAR feedback
- **Framework Teaching** — Deep dives with worked examples and practice scenarios
- **Expert Tests** — Simulated conversations with domain experts who score you
- **Daily Reflection** — Automated analysis of progress, technique effectiveness, and lesson planning
- **Knowledge Pipeline** — Feed articles, papers, and notes → auto-scored and integrated into tracks
- **Progress Dashboard** — Visual tracking across all 8 pillars with ASCII progress bars
- **Spaced Repetition** — Never forget what you've learned; review at optimal intervals
- **Question Bank** — Add your own interview questions following the included template
- **PM Framework Library** — 10 reference guides for core PM frameworks (CIRCLES, RICE, JTBD, and more)

---

## 📁 Project Structure

```
pm-coach/
├── CLAUDE.md                          # System prompt (the coach's brain)
├── .cursorrules                       # Cursor/Windsurf rules (compact CLAUDE.md)
├── setup.sh                           # Interactive setup wizard
├── config.json                        # Your profile and preferences
├── memory.md                          # Persistent session memory
│
├── learning/
│   ├── dashboard.md                   # Progress dashboard (auto-generated)
│   ├── session-prep.md                # Today's session plan (auto-generated)
│   ├── knowledge-queue.jsonl          # Knowledge pipeline queue
│   ├── tracks/
│   │   ├── ai-foundations/
│   │   │   ├── track.json             # Scores, spaced repetition state
│   │   │   ├── history.jsonl          # Session-by-session log
│   │   │   └── lesson-plan.md         # Current teaching plan
│   │   ├── pm-frameworks/
│   │   ├── lp-stories/
│   │   └── ... (13 tracks total)
│   ├── pedagogy/
│   │   ├── approaches.md              # 10 teaching approaches
│   │   └── expert-personas.md         # 8 expert personas
│   └── reflections/
│       ├── latest.md                  # Most recent reflection
│       └── archive/                   # Historical reflections
│
├── data/
│   ├── frameworks/                    # PM framework reference docs
│   │   ├── circles.md
│   │   ├── rice.md
│   │   ├── working-backwards.md
│   │   ├── jobs-to-be-done.md
│   │   ├── north-star-metric.md
│   │   ├── okrs.md
│   │   ├── star-soar.md
│   │   ├── first-principles.md
│   │   ├── opportunity-solution-tree.md
│   │   └── kano-model.md
│   └── question-bank/                 # Your interview questions (add your own)
│       ├── README.md
│       └── template.json
│
├── knowledge/                         # Drop articles and papers here
│
├── scripts/
│   ├── update-dashboard.sh            # Regenerate dashboard from track data
│   ├── prepare-session.sh             # Generate session prep for today
│   ├── run-reflection.sh              # Run the nightly reflection analysis
│   ├── feed-knowledge-queue.sh        # Process knowledge sources into queue
│   └── add-topic.sh                   # "Teach me about X"
│
├── docs/
│   ├── ARCHITECTURE.md                # System architecture deep-dive
│   ├── CUSTOMIZATION.md               # How to personalize everything
│   ├── PLATFORMS.md                    # Setup for Claude Code, Cursor, Windsurf
│   ├── CONTRIBUTING.md                # How to contribute
│   └── FAQ.md                         # Common questions
│
└── examples/
    ├── session-transcript.md          # Annotated coaching session
    ├── expert-test-example.md         # Annotated expert test
    └── custom-track-example/          # How to create a custom track
```

---

## 📚 Knowledge Sources

PM Coach includes a **framework library** with original syntheses of 10 core PM frameworks, each with worked examples and interview application guidance.

The `knowledge/` directory is designed for you to add your own learning materials:

- **Articles and blog posts** — Drop `.md` files and run `feed-knowledge-queue.sh`
- **Research paper summaries** — Markdown summaries of relevant papers
- **Podcast notes** — We recommend distilling insights from [Lenny's Podcast](https://www.lennyspodcast.com/) by Lenny Rachitsky — organize notes by PM topic (product sense, metrics, growth, strategy, etc.) and drop them in `knowledge/`
- **Your own notes** — Anything relevant to your PM growth

The knowledge pipeline automatically scores new materials for relevance and routes them to the appropriate learning tracks.

---

## 🔧 Platform Compatibility

| Platform | Status | How It Works |
|----------|--------|--------------|
| **Claude Code** | ✅ Full support | `CLAUDE.md` auto-loads as system prompt |
| **Cursor** | ✅ Full support | `.cursorrules` auto-loads |
| **Windsurf** | ✅ Full support | Copy `.cursorrules` → `.windsurfrules` |
| **Aider** | ⚠️ Partial | Needs manual system prompt loading |
| **ChatGPT** | ⚠️ Limited | No file persistence or automation |
| **Other LLMs** | ⚠️ Varies | Needs tool use + file access capability |

See [docs/PLATFORMS.md](docs/PLATFORMS.md) for detailed setup instructions per platform.

---

## 🛠️ Automation

All scripts require only `bash` and `jq`. No other dependencies.

### Daily Reflection (Recommended)

The reflection engine analyzes your progress, updates lesson plans, rotates techniques, and processes the knowledge queue:

```bash
./scripts/run-reflection.sh
```

**Optional: Run nightly via cron:**
```bash
# Edit crontab
crontab -e

# Add (runs at 11 PM daily):
0 23 * * * cd /path/to/pm-coach && ./scripts/run-reflection.sh >> /tmp/pm-coach-reflection.log 2>&1
```

### Session Prep (Recommended)

Generates a session plan based on what's due and what needs attention:

```bash
./scripts/prepare-session.sh
```

### Other Scripts

```bash
# Regenerate the progress dashboard
./scripts/update-dashboard.sh

# Add a topic to learn
./scripts/add-topic.sh "transformer attention mechanisms"
./scripts/add-topic.sh "RICE prioritization" --tracks pm-frameworks

# Process new knowledge sources
./scripts/feed-knowledge-queue.sh
```

---

## 🎨 Customization

PM Coach is designed to be extended. Common customizations:

- **Add a new learning track** — Create a directory in `learning/tracks/` with `track.json`, `history.jsonl`, and `lesson-plan.md`
- **Add interview questions** — Follow the template in `data/question-bank/`
- **Add knowledge** — Drop `.md` files in `knowledge/` and run the pipeline
- **Modify expert personas** — Edit `learning/pedagogy/expert-personas.md`
- **Change the LLM model** — Set `REFLECTION_MODEL` env var or edit `config.json`
- **Adapt for non-PM domains** — The architecture is domain-agnostic; swap the content

See [docs/CUSTOMIZATION.md](docs/CUSTOMIZATION.md) for detailed guides.

---

## 🤝 Contributing

We welcome contributions! Whether it's new frameworks, better pedagogy approaches, additional expert personas, or script improvements.

See [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md) for guidelines.

---

## 📄 License

MIT — see [LICENSE](LICENSE).

---

## 🙏 Acknowledgments

- **[Lenny's Podcast](https://www.lennyspodcast.com/)** by Lenny Rachitsky — PM insights distilled from this essential podcast for product people informed many of the framework applications and coaching patterns in this system
- **[Product Manager Skills](https://github.com/deanpeters/Product-Manager-Skills)** by Dean Peters — Complementary PM skills library
- **Spaced repetition algorithm** adapted from [SM-2](https://en.wikipedia.org/wiki/SuperMemo#Description_of_SM-2_algorithm) by Piotr Wozniak
- **Coaching methodology** informed by [The Prompt Report](https://arxiv.org/abs/2406.06608) (2025) — a comprehensive survey of prompting techniques
- **PM frameworks** synthesized from publicly available industry-standard sources (CIRCLES, RICE, JTBD, OKRs, Kano, and more)
