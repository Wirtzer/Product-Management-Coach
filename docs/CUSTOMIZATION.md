# Customization Guide

PM Coach is designed to be extended and personalized. This guide covers the most common customizations.

---

## Table of Contents

- [Add a New Learning Track](#add-a-new-learning-track)
- [Create Custom Expert Personas](#create-custom-expert-personas)
- [Modify Pedagogy Approaches](#modify-pedagogy-approaches)
- [Populate the Question Bank](#populate-the-question-bank)
- [Extend the Knowledge Base](#extend-the-knowledge-base)
- [Add PM Framework References](#add-pm-framework-references)
- [Change the LLM Model](#change-the-llm-model)
- [Adapt for Non-PM Domains](#adapt-for-non-pm-domains)

---

## Add a New Learning Track

Each track lives in `learning/tracks/<track-id>/` and needs three files.

### 1. Create the Directory

```bash
mkdir -p learning/tracks/my-new-track
```

### 2. Create track.json

```json
{
  "track_id": "my-new-track",
  "display_name": "My New Track",
  "pillar": "pm-craft",
  "pillar_emoji": "🛠️",
  "pillar_tier": "always-on",
  "created": "2025-01-15",
  "last_updated": "2025-01-15",
  "topic_type": "framework-application",
  "session_count": 0,
  "mastery": {
    "overall": 30,
    "dimensions": {
      "core_concepts": { "score": 30, "trend": "flat", "notes": "" },
      "practical_application": { "score": 30, "trend": "flat", "notes": "" },
      "current_research": { "score": 30, "trend": "flat", "notes": "" }
    }
  },
  "conversational_readiness": {
    "overall": 20,
    "dimensions": {
      "vocabulary_fluency": { "score": 20, "trend": "flat", "last_tested": null },
      "conceptual_depth": { "score": 20, "trend": "flat", "last_tested": null },
      "current_awareness": { "score": 20, "trend": "flat", "last_tested": null, "staleness_days": 0 },
      "opinion_formation": { "score": 20, "trend": "flat", "last_tested": null }
    },
    "target_persona": "principal-engineer",
    "expert_test_history": []
  },
  "spaced_repetition": {
    "current_interval_days": 2,
    "next_review_date": "2025-01-15",
    "consecutive_successes": 0,
    "last_review_quality": null,
    "flagged_for_immediate_review": false
  },
  "pedagogy": {
    "approach": "framework-application",
    "current_phase": "Learn",
    "phase_progression": ["Learn", "Apply (Guided)", "Apply (Solo)", "Transfer", "Adapt"],
    "active_techniques": ["worked-example"],
    "techniques_tried": []
  }
}
```

**Key fields to customize:**
- `track_id` — URL-safe slug (matches directory name)
- `display_name` — Human-readable name
- `pillar` — Must match an existing pillar slug (or create a new one)
- `topic_type` — Maps to a pedagogy approach in `approaches.md`
- `pedagogy.approach` — Which of the 10 approaches to use
- `spaced_repetition.next_review_date` — Set to today so it's due immediately

### 3. Create Empty history.jsonl

```bash
touch learning/tracks/my-new-track/history.jsonl
```

### 4. Create lesson-plan.md

```markdown
# Lesson Plan: My New Track

## Current Focus
Introduction to core concepts.

## Key Topics
- Topic A
- Topic B
- Topic C

## Exercises
1. Walk through a worked example of [concept]
2. Apply the framework to a familiar product
3. Compare two approaches and discuss tradeoffs

## Resources
- [Link to relevant material]
```

### 5. Regenerate the Dashboard

```bash
./scripts/update-dashboard.sh
```

See `examples/custom-track-example/` for a complete working example.

---

## Create Custom Expert Personas

Expert personas live in `learning/pedagogy/expert-personas.md`. To add a new one:

### Template

```markdown
### N. 🎭 Your Pillar — "Role Title at Company"

**Role:** Description of who this persona is and their expertise.

**Conversation opener:**
- "Opening line that tests a specific aspect..."
- "Alternative opener for a different angle..."

**Evaluation emphasis:**
- **Accuracy** and **Depth** are critical because...
- **Current Awareness** is tested through...
- **Opinion Formation** matters because...

**Example probing questions:**
- "Question that tests depth..."
- "Question that tests current awareness..."
- "Question that challenges opinions..."
```

### Tips
- Each persona should have a distinct "personality" — a skeptical engineer tests differently than a visionary CPO
- Tie the persona to a specific pillar so the coach knows when to deploy it
- Include 2-3 conversation openers so tests don't feel repetitive
- Be specific about what each persona probes hardest

---

## Modify Pedagogy Approaches

Teaching approaches live in `learning/pedagogy/approaches.md`. Each approach defines:

1. **Phase Progression** — The 5 stages of learning
2. **Techniques** — Specific teaching methods per phase
3. **Mastery Signals** — How to know the learner has achieved the phase
4. **Phase-to-Dimension Mapping** — Which mastery dimensions gate each phase transition

### Adding a New Technique

Find the relevant approach section and add a row to the Techniques table:

```markdown
| `my-new-technique` | Description of what this does | Best Phase |
```

### Adding a New Approach

Add a new numbered section (##) following the existing pattern. You'll also need to add a corresponding Phase → Focus Dimension Mapping section at the bottom of the file.

### Caution

The reflection engine reads `approaches.md` programmatically. Maintain the existing Markdown table formats and section headers to ensure compatibility.

---

## Populate the Question Bank

The question bank in `data/question-bank/` starts empty — you add your own questions.

### Question Sources

Build your question bank from:
- **Your own interview experiences** — After each real interview, add the questions you received
- **Job postings** — Extract skill requirements and turn them into practice questions
- **Interview prep communities** — Public forums, study groups, peer practice
- **Framework application** — Create questions that exercise specific frameworks (CIRCLES, RICE, etc.)

### Adding Questions

1. Copy `data/question-bank/template.json` to a new file (e.g., `product-sense.json`)
2. Fill in the `questions` array with your questions
3. Tag each question with:
   - `category` and `subcategory` for organization
   - `company_tags` for company-specific prep
   - `framework_tags` to link to relevant frameworks
   - `difficulty` for session calibration

### During Coaching Sessions

You can also tell the coach: *"Add this question to the bank: How would you design a notification system for a healthcare app?"*

The coach will create or update the appropriate file.

### Pro Tips
- After real interviews, immediately add questions while they're fresh
- Tag questions by company to create targeted mock interview sessions
- Rate difficulty honestly — the coach uses it to calibrate session intensity
- Add follow-up questions you've encountered for more realistic drills

---

## Extend the Knowledge Base

### Adding Knowledge Sources

Drop articles, papers, and notes as `.md` or `.txt` files into the configured knowledge directories (default: `knowledge/`).

Then run:
```bash
./scripts/feed-knowledge-queue.sh
```

The pipeline will:
1. Detect new files
2. Score them for relevance (if an LLM CLI is available)
3. Add them to `learning/knowledge-queue.jsonl`
4. The next reflection cycle integrates them into track lesson plans

### Recommended Knowledge Sources

**Podcasts:** [Lenny's Podcast](https://www.lennyspodcast.com/) by Lenny Rachitsky is an outstanding source of PM knowledge. We recommend distilling episode notes organized by topic (product sense, metrics, growth, strategy, hiring, etc.) and adding them to `knowledge/`. The reflection engine will score and route the insights to the relevant learning tracks automatically.

**Articles:** Blog posts from product leaders, company engineering blogs, and industry analysis pieces.

**Research papers:** For technical tracks, add markdown summaries of relevant AI/ML papers. Include the paper title, key contributions, and your notes on PM implications.

**Your own notes:** After meetings, conferences, or conversations — capture insights and add them to the pipeline.

### Configuring Knowledge Directories

Edit `config.json` to add multiple knowledge source directories:

```json
{
  "paths": {
    "knowledge_sources": [
      "./knowledge",
      "/path/to/my/pm-notes",
      "/path/to/podcast-notes"
    ]
  }
}
```

### Manual Topic Addition

To add a specific topic for the coach to teach you:

```bash
./scripts/add-topic.sh "transformer attention mechanisms"
./scripts/add-topic.sh "RICE prioritization" --tracks pm-frameworks
```

---

## Add PM Framework References

Framework documents live in `data/frameworks/`. To add a new one:

1. Create `data/frameworks/your-framework.md`
2. Follow the existing structure:
   - Title and purpose
   - Core concepts with explanations
   - Worked example
   - "How to Use in Interviews" section
   - "When NOT to Use" section

The coach references these during framework teaching sessions. Good framework docs are 80-150 lines with clear headers and practical examples.

---

## Change the LLM Model

### For Reflections

Set the `REFLECTION_MODEL` environment variable:
```bash
REFLECTION_MODEL=claude-opus-4-5 ./scripts/run-reflection.sh
```

Or edit `config.json`:
```json
{
  "model": {
    "default": "claude-sonnet-4-5",
    "deep": "claude-opus-4-5"
  }
}
```

### For Coaching Sessions

This depends on your platform:
- **Claude Code:** `claude --model claude-opus-4-5`
- **Cursor:** Change model in Cursor settings
- **Windsurf:** Change model in Windsurf settings

### Recommended Models

| Use Case | Recommended Model | Why |
|----------|-------------------|-----|
| Coaching sessions | Claude Sonnet 4.5+ | Good balance of speed and depth |
| Reflections | Claude Sonnet 4.5+ | Handles complex multi-file analysis |
| Deep analysis | Claude Opus 4.5+ | Best for nuanced technique evaluation |

Any model with strong instruction-following and file access should work. The system has been primarily tested with Claude models.

---

## Adapt for Non-PM Domains

PM Coach's architecture is domain-agnostic. The PM-specific content lives entirely in:
- Track definitions (`learning/tracks/*/track.json`)
- Pedagogy approaches (`learning/pedagogy/approaches.md`)
- Expert personas (`learning/pedagogy/expert-personas.md`)
- Framework library (`data/frameworks/`)
- System prompt (`CLAUDE.md`)

### To adapt for another domain (e.g., Software Engineering, Data Science, Design):

1. **Replace tracks** — Create tracks for your domain's skill areas
2. **Update pedagogy** — Modify or create approaches suited to your domain's learning patterns
3. **Create expert personas** — Design personas relevant to your field (e.g., "Senior Staff Engineer" for SWE, "Design Director" for Design)
4. **Replace frameworks** — Add framework references for your domain
5. **Update CLAUDE.md** — Modify the system prompt to reflect the new domain, coaching style, and scoring rubrics
6. **Update config.json** — Point knowledge sources at relevant materials

The spaced repetition algorithm, session logging, reflection loop, and dashboard scripts work for any domain without modification.

### Example Adaptations
- **Software Engineering Coach** — Tracks: system design, algorithms, code review, architecture. Personas: Staff Engineer, Tech Lead, Hiring Manager.
- **Data Science Coach** — Tracks: statistics, ML algorithms, experiment design, communication. Personas: Principal Data Scientist, VP of Analytics.
- **Design Coach** — Tracks: visual design, UX research, interaction design, design systems. Personas: Design Director, UX Researcher, Product Partner.
