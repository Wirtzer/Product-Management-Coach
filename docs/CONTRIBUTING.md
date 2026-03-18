# Contributing to PM Coach

Thanks for your interest in contributing! PM Coach is an open-source project and we welcome contributions of all kinds.

---

## Ways to Contribute

### 🐛 Report Issues
Found a bug in a script? Dashboard not generating correctly? [Open an issue](../../issues) with:
- What you expected to happen
- What actually happened
- Your environment (OS, shell version, jq version)
- Steps to reproduce

### 📚 Add PM Frameworks
Have a framework that's missing from `data/frameworks/`? Submit a PR with:
- A new `.md` file following the existing format
- Title, purpose, and "Best for" section
- Core concepts with clear explanations
- A worked example
- "How to Use in Interviews" section
- "When NOT to Use" section
- Target length: 80-150 lines

### 🧠 Improve Pedagogy
Ideas for better teaching approaches? New techniques? Submit PRs to:
- `learning/pedagogy/approaches.md` — New techniques or approach improvements
- `learning/pedagogy/expert-personas.md` — New expert personas

### 🔧 Script Improvements
All scripts should:
- Work with just `bash` and `jq` (no additional dependencies for pure-computation scripts)
- Use `set -euo pipefail` at the top
- Detect the workspace via `BASH_SOURCE`
- Handle missing files gracefully
- Include a usage comment at the top

### 📖 Documentation
Improvements to docs, README, examples, and guides are always welcome.

---

## Submitting a Pull Request

### 1. Fork and Clone
```bash
git clone https://github.com/your-username/pm-coach.git
cd pm-coach
```

### 2. Create a Branch
```bash
git checkout -b feature/my-improvement
```

### 3. Make Your Changes
- Follow the existing code and documentation style
- Test scripts on both macOS and Linux if possible
- Don't include personal data, API keys, or proprietary content

### 4. Test
```bash
# For script changes: run the script
./scripts/update-dashboard.sh

# For track changes: verify JSON is valid
jq . learning/tracks/*/track.json > /dev/null

# For documentation: check links aren't broken
```

### 5. Submit
Push your branch and open a PR with:
- A clear description of what you changed and why
- Any testing you did
- Screenshots of dashboard/output if relevant

---

## Code Style

### Scripts (bash)
- `#!/bin/bash` shebang
- `set -euo pipefail`
- Workspace detection: `WORKSPACE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"`
- Comments for non-obvious logic
- Echo progress with emoji prefixes (`📊`, `✅`, `❌`, etc.)
- Handle BSD (macOS) and GNU (Linux) differences in `date`, `stat`, etc.

### JSON (track files, config)
- 2-space indentation
- Consistent field ordering (follow existing track.json files)
- All dates in `YYYY-MM-DD` format
- Scores as integers (0-100)

### Markdown (frameworks, docs, lesson plans)
- ATX headers (`#`, `##`, `###`)
- Tables for structured comparisons
- Code blocks with language hints
- Horizontal rules (`---`) between major sections
- "How to Use in Interviews" section in every framework doc

---

## Content Guidelines

### DO
- Contribute original content or properly attributed public-domain knowledge
- Include practical examples and worked scenarios
- Write for an audience of practicing or aspiring PMs
- Keep framework docs actionable (not just theoretical)

### DON'T
- Include content from paid courses, books, or proprietary materials
- Add personal data (names, emails, phone numbers)
- Include API keys, credentials, or secrets
- Submit content generated entirely by AI without review and editing

---

## Questions?

Open an issue tagged `question` and we'll get back to you.
