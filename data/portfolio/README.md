# Personal Portfolio

Drop your personal documents here so the coach can learn about your
background, experience, and accomplishments. The coach synthesizes
these into a profile that informs mock interviews, coaching context,
and personalization.

**This directory starts empty.** Add your own documents using any
supported format.

---

## What to Add

| Document Type | Examples | How the Coach Uses It |
|--------------|----------|----------------------|
| Resume/CV | resume.md | Career trajectory, skills inventory, gap identification |
| Project write-ups | project-search-redesign.md | Behavioral story bank, impact examples, technical depth calibration |
| Performance reviews | perf-review-2025-h1.md | Strengths and growth areas from manager perspective |
| Win lists | wins-2024.md | Accomplishment inventory for behavioral answers |
| Career narrative | career-story.md | Personal positioning, "tell me about yourself" prep |
| Writing samples | prd-example.md, one-pager.md | Communication style assessment |
| Interview notes | interview-log-google.md | Post-interview reflection, pattern identification |

---

## Supported Formats

- **Markdown (.md)** -- recommended, the coach reads these directly
- **Plain text (.txt)** -- works fine
- **JSON (.json)** -- for structured data (e.g., exported project lists)

For PDFs, create a companion .md file with the key content summarized.

---

## File Naming

Use descriptive names. The coach scans filenames to understand content type:

```
resume-2024.md
project-search-ranking-redesign.md
perf-review-2025-h1.md
wins-2024.md
career-narrative.md
```

---

## What NOT to Add

- Confidential company documents (legal risk)
- Raw data exports or spreadsheets
- Anything already captured in config.json (name, role, level, targets)

---

## After Adding Documents

The coach will detect new files on the next session boot and synthesize
them into your profile. You can also tell the coach: "I added new
documents to my portfolio" to trigger re-synthesis.

The synthesized profile lives in `profile-synthesis.md` in this directory.
Do not edit it manually; the coach maintains it.
