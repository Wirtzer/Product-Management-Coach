# Architecture

PM Coach is an AI coaching system built on flat files and shell scripts. There's no database, no server, no API — just markdown, JSON, and bash.

This document explains how the pieces fit together.

---

## System Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    COACHING SESSION                          │
│                                                             │
│   User ←→ LLM (Claude Code / Cursor / etc.)                │
│              │                                              │
│              ├── Reads: CLAUDE.md (system prompt)           │
│              ├── Reads: learning/session-prep.md            │
│              ├── Reads: learning/tracks/*/track.json        │
│              ├── Reads: learning/pedagogy/approaches.md     │
│              ├── Reads: memory.md                           │
│              ├── Reads: data/frameworks/*.md                │
│              │                                              │
│              ├── Writes: learning/tracks/*/track.json       │
│              ├── Writes: learning/tracks/*/history.jsonl    │
│              └── Writes: memory.md                          │
└─────────────────────────────────────────────────────────────┘
                            │
                    ┌───────┴───────┐
                    │  AUTOMATION   │
                    │  (Optional)   │
                    └───────┬───────┘
                            │
              ┌─────────────┼─────────────┐
              ▼             ▼             ▼
     ┌──────────────┐ ┌──────────┐ ┌───────────────┐
     │  Reflection   │ │ Session  │ │  Knowledge    │
     │  Engine       │ │ Prep     │ │  Pipeline     │
     │              │ │          │ │               │
     │ run-          │ │ prepare- │ │ feed-         │
     │ reflection.sh │ │ session  │ │ knowledge-    │
     │              │ │ .sh      │ │ queue.sh      │
     └──────┬───────┘ └────┬─────┘ └──────┬────────┘
            │              │              │
            ▼              ▼              ▼
     ┌──────────────────────────────────────────────┐
     │              FILE SYSTEM (State)              │
     │                                               │
     │  learning/tracks/*/track.json    ← scores     │
     │  learning/tracks/*/history.jsonl ← sessions   │
     │  learning/tracks/*/lesson-plan.md ← plans     │
     │  learning/reflections/latest.md  ← analysis   │
     │  learning/dashboard.md           ← overview   │
     │  learning/session-prep.md        ← prep       │
     │  learning/knowledge-queue.jsonl  ← pipeline   │
     │  memory.md                       ← context    │
     └──────────────────────────────────────────────┘
```

---

## The Five Layers

### 1. System Prompt (CLAUDE.md)

The control plane. CLAUDE.md is loaded automatically by Claude Code and defines:
- The coach's personality and teaching philosophy
- The boot protocol (what to read on startup)
- Session commands (`/practice`, `/test`, `/reflect`, etc.)
- Scoring rubrics and update procedures
- Expert persona definitions

When a user starts a session, the LLM reads CLAUDE.md and becomes the coach. Everything flows from this file.

**Why a system prompt?** It's portable. CLAUDE.md works with Claude Code, Cursor (.cursorrules), Windsurf, or any LLM that supports system prompts and file access.

### 2. Track State Layer (learning/tracks/)

Each learning track is a directory:

```
learning/tracks/ai-foundations/
├── track.json       # Current scores, spaced repetition state, pedagogy config
├── history.jsonl    # Append-only log of every session
└── lesson-plan.md   # Current lesson plan (updated by reflection)
```

**track.json** is the source of truth for a track's state:
- `mastery.overall` and `mastery.dimensions.*` — what the learner knows
- `conversational_readiness.*` — how well they can discuss it
- `spaced_repetition.*` — when to review next (SM-2 variant)
- `pedagogy.*` — current teaching approach, phase, and techniques

**history.jsonl** is append-only. Each line is a session record with scores, technique used, and quality rating. This gives the reflection engine a timeline to analyze.

**lesson-plan.md** is the current teaching plan. Updated by the reflection engine, consumed by the live coaching session.

### 3. Pedagogy Engine (learning/pedagogy/)

Two files define the teaching methodology:

**approaches.md** — The 10 teaching approaches, each with:
- Phase progression (5 phases per approach)
- Technique catalog (what to try in each phase)
- Phase advancement criteria (quantitative + qualitative + spaced repetition)
- Phase-to-dimension mapping (which mastery dimensions gate each transition)

**expert-personas.md** — 8 domain expert personas for conversational readiness testing. Each persona has a role, conversation starters, scoring rubric, and evaluation emphasis.

The live coach reads these during sessions. The reflection engine uses them to evaluate technique effectiveness and recommend changes.

### 4. Reflection Loop (scripts/run-reflection.sh)

The most complex component. Run nightly (or on-demand), it:

1. Collects all track data, history, and lesson plans
2. Builds a comprehensive analysis prompt
3. Sends to an LLM for deep analysis
4. The LLM writes updated files: track scores, lesson plans, dashboard, session prep

**What the reflection analyzes:**
- Technique effectiveness (retire low-performing techniques, promote high-performing ones)
- Phase advancement eligibility
- Stagnation detection (flat scores across sessions)
- Cross-track meta-issues (shared weaknesses across pillars)
- Knowledge queue processing (integrate new material into tracks)
- Spaced repetition interval updates

**Why an LLM?** The analysis requires judgment — weighing technique effectiveness, identifying patterns in session history, writing nuanced lesson plans. Pure computation handles the dashboard; the reflection needs intelligence.

### 5. Knowledge Pipeline

External knowledge flows into the system through a pipeline:

```
Knowledge Sources (articles, papers, notes)
    │
    ▼
feed-knowledge-queue.sh  →  knowledge-queue.jsonl (status: pending)
    │
    ▼
run-reflection.sh  →  Scores relevance, routes to tracks, extracts concepts
    │
    ▼
track lesson-plan.md  →  Integrated into teaching plan
```

Manual topic requests (`add-topic.sh`) follow the same path.

---

## Spaced Repetition Algorithm

PM Coach uses a simplified SM-2 variant:

| Last Session Quality | Interval Update | Max |
|---------------------|-----------------|-----|
| 5 (perfect, ≥90) | interval × 2.5 | 30 days |
| 4 (good, 80-89) | interval × 2.0 | 30 days |
| 3 (adequate, 70-79) | interval × 1.5 | 30 days |
| 2 (poor, 55-69) | Reset to 1 day | — |
| 1 (fail, <55) | Reset to 1 day + flag | — |

`next_review_date = last_session_date + computed_interval`

This ensures tracks you know well are reviewed less frequently, while struggling tracks appear more often.

---

## Data Flow During a Session

```
1. Session starts
   └── LLM reads CLAUDE.md → boots as coach
   └── LLM reads session-prep.md → knows what's due
   └── LLM reads track.json for due tracks → knows current state

2. Coaching happens
   └── Coach uses pedagogy approaches to select technique
   └── Coach draws from lesson-plan.md for exercises
   └── Coach scores the learner on mastery dimensions

3. Session ends
   └── LLM updates track.json (new scores, updated spaced repetition)
   └── LLM appends to history.jsonl (session record)
   └── LLM updates memory.md (key observations)

4. After session (automated)
   └── update-dashboard.sh regenerates dashboard
   └── prepare-session.sh generates tomorrow's prep

5. Nightly (automated)
   └── run-reflection.sh performs deep analysis
   └── Updates lesson plans, technique selections, phase advancements
```

---

## Why Flat Files?

1. **Portable:** Works anywhere with a file system. No database setup.
2. **Transparent:** Every piece of state is human-readable. Open track.json and see exactly where you stand.
3. **Git-friendly:** Track your learning progress in version control. Diff your growth over months.
4. **LLM-native:** LLMs read and write text files naturally. No serialization layer needed.
5. **Hackable:** Want to change a score? Edit the JSON. Want to add a track? Copy a directory.

---

## Extension Points

### Adding a New Track
Create `learning/tracks/<track-id>/` with `track.json`, empty `history.jsonl`, and `lesson-plan.md`. See docs/CUSTOMIZATION.md.

### Adding a Teaching Approach
Extend `learning/pedagogy/approaches.md` with a new numbered section. Add phase-to-dimension mapping.

### Adding an Expert Persona
Extend `learning/pedagogy/expert-personas.md` with a new persona section.

### Adding a Framework
Drop a new .md file in `data/frameworks/`. The coach will reference it when relevant.

### Changing the LLM
Set `REFLECTION_MODEL` env var or edit `config.json`. Any model that supports tool use and file access should work for coaching. The reflection script supports Claude Code and aichat out of the box.
