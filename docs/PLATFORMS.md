# Platform Setup Guides

PM Coach works with any AI tool that can read files and follow system prompts. Here's how to set it up on each platform.

---

## Claude Code (Primary — Recommended)

[Claude Code](https://docs.anthropic.com/en/docs/claude-code) is the recommended platform. PM Coach was designed for it.

### Setup

1. Install Claude Code:
   ```bash
   npm install -g @anthropic-ai/claude-code
   ```

2. Clone and set up PM Coach:
   ```bash
   git clone https://github.com/your-username/pm-coach.git
   cd pm-coach
   ./setup.sh
   ```

3. Start:
   ```bash
   claude
   ```

4. Say `let's go` to begin coaching.

### How It Works

Claude Code automatically reads `CLAUDE.md` as its system prompt when launched from the project directory. It has full file system access, so it can read and update track files, write history, and generate lesson plans.

### Automation

All scripts work natively:
```bash
./scripts/run-reflection.sh          # Uses 'claude --print' internally
./scripts/prepare-session.sh         # Pure bash + jq
./scripts/update-dashboard.sh        # Pure bash + jq
./scripts/feed-knowledge-queue.sh    # Uses 'claude --print' for scoring
./scripts/add-topic.sh "topic"       # Pure bash + jq
```

---

## Cursor

[Cursor](https://cursor.sh/) is an AI-powered code editor that supports custom rules files.

### Setup

1. Clone PM Coach and run setup:
   ```bash
   git clone https://github.com/your-username/pm-coach.git
   cd pm-coach
   ./setup.sh
   ```

2. Open the `pm-coach` folder in Cursor.

3. The `.cursorrules` file loads automatically as the system prompt.

4. Open the AI chat panel and say `let's go`.

### Limitations

- Cursor has tighter context limits than Claude Code. The `.cursorrules` file is a compressed version of `CLAUDE.md`.
- File writes may require confirmation depending on your Cursor settings.
- Automation scripts that need an LLM CLI won't work unless you also have Claude Code or aichat installed.

### Tips

- Use the "Composer" mode for multi-file operations (updating tracks after sessions)
- Pin `CLAUDE.md` in chat context if `.cursorrules` isn't providing enough detail
- Consider installing Claude Code alongside Cursor for running automation scripts

---

## Windsurf

[Windsurf](https://codeium.com/windsurf) supports `.windsurfrules` files.

### Setup

1. Clone PM Coach and run setup:
   ```bash
   git clone https://github.com/your-username/pm-coach.git
   cd pm-coach
   ./setup.sh
   ```

2. Copy the rules file:
   ```bash
   cp .cursorrules .windsurfrules
   ```

3. Open the `pm-coach` folder in Windsurf.

4. Start a chat and say `let's go`.

### Notes

- Windsurf uses the same `.cursorrules` format, just with a different filename.
- Same context limitations as Cursor apply.

---

## Aider

[Aider](https://aider.chat/) is a terminal-based AI coding assistant.

### Setup

1. Clone PM Coach and run setup:
   ```bash
   git clone https://github.com/your-username/pm-coach.git
   cd pm-coach
   ./setup.sh
   ```

2. Start aider with the system prompt:
   ```bash
   aider --read CLAUDE.md
   ```

3. Add key files to context:
   ```
   /add learning/session-prep.md memory.md
   ```

4. Say `let's go`.

### Limitations

- Aider needs manual context management — add track files when working on specific tracks
- No automatic `.cursorrules` support — use `--read CLAUDE.md`
- File edits work well; multi-file orchestration is more manual

---

## ChatGPT (Limited)

ChatGPT can be used for individual coaching conversations, but lacks the persistence and automation that make PM Coach powerful.

### Setup

1. Copy the contents of `CLAUDE.md`
2. Paste it as a "Custom Instructions" or at the start of a conversation
3. Manually paste track data when needed

### Limitations

- **No file persistence** — ChatGPT can't read or write your track files
- **No spaced repetition** — You'd need to manage review scheduling manually
- **No automation** — Scripts require a local environment
- **Context limits** — `CLAUDE.md` may exceed Custom Instructions limits; use `.cursorrules` content instead

### What Works

- Framework teaching (paste the framework doc)
- Mock interview practice (paste your STAR stories)
- General PM coaching conversation

### What Doesn't

- Persistent score tracking
- Automated reflection and lesson planning
- Knowledge pipeline
- Expert persona tests with scoring updates

---

## Generic LLM with File Access

Any LLM that supports system prompts and file reading/writing can run PM Coach.

### Requirements

1. **System prompt support** — Ability to load CLAUDE.md or equivalent
2. **File read access** — Must be able to read .json, .jsonl, and .md files
3. **File write access** — Must be able to update track.json, append to history.jsonl, and write markdown
4. **Sufficient context** — CLAUDE.md + session-prep.md + track data needs ~15K tokens minimum

### Setup Pattern

```
1. Load CLAUDE.md as system prompt
2. On each session:
   a. Read learning/session-prep.md
   b. Read track.json for due tracks
   c. Read memory.md
   d. Conduct coaching session
   e. Write updated scores to track.json
   f. Append session record to history.jsonl
   g. Update memory.md
```

### For Reflection Scripts

The `run-reflection.sh` script supports:
- `claude` CLI (Claude Code)
- `aichat` CLI (multi-provider)

If your LLM has a different CLI, modify the LLM dispatch section in `scripts/run-reflection.sh` (look for the `if command -v claude` block).

---

## Comparison Matrix

| Feature | Claude Code | Cursor | Windsurf | Aider | ChatGPT |
|---------|-------------|--------|----------|-------|---------|
| Auto-loads system prompt | ✅ CLAUDE.md | ✅ .cursorrules | ✅ .windsurfrules | ⚠️ --read flag | ❌ Manual paste |
| File read/write | ✅ Native | ✅ Native | ✅ Native | ✅ Native | ❌ No |
| Multi-file edits | ✅ Easy | ✅ Composer | ✅ Cascade | ⚠️ Manual | ❌ No |
| Script automation | ✅ Full | ⚠️ External | ⚠️ External | ⚠️ External | ❌ No |
| Context depth | ✅ Large | ⚠️ Medium | ⚠️ Medium | ⚠️ Medium | ⚠️ Small |
| Cost | API usage | Subscription + API | Subscription + API | API usage | Subscription |
