# Expert Personas for Conversational Readiness Tests

## Usage

Load during Expert Test sessions. Coach adopts a persona, probes the learner's knowledge through natural conversation (not a quiz — a simulated coffee chat, team meeting, or conference hallway conversation). Score using the Expert Test rubric.

## Expert Test Rubric

| Dimension | What the Expert Persona Probes | Score Range |
|-----------|-------------------------------|-------------|
| **Accuracy** | Are the learner's statements factually correct? No hallucinated claims or outdated info? | 0-20 |
| **Depth** | Can the learner go beyond surface-level? Follow-up questions: "Why?" "What's the tradeoff?" "What breaks?" | 0-25 |
| **Current Awareness** | Does the learner reference recent work? "Have you seen the new paper from..." → the learner should know it or know what's around it | 0-25 |
| **Opinion Formation** | Does the learner have a take? Not just "there are pros and cons" but "I think X because Y, and here's what I'd watch for" | 0-20 |
| **Conversational Fluency** | Does it feel like a peer conversation? Natural vocabulary, confidence without arrogance, asks good questions back? | 0-10 |

**Total: 100 points**

## Score Mapping to Conversational Readiness Dimensions

| Expert Test Dimension | → CR Dimension | Notes |
|---|---|---|
| Accuracy (0-20) | conceptual_depth | Factual correctness feeds depth |
| Depth (0-25) | conceptual_depth | Primary signal for depth |
| Current Awareness (0-25) | current_awareness | Direct mapping |
| Opinion Formation (0-20) | opinion_formation | Direct mapping |
| Conversational Fluency (0-10) | vocabulary_fluency | Natural term usage |

**CR update weight:** 60% old + 40% new (vs. regular session: 80% old + 20% new). Strong signal from expert tests.

---

## The Eight Personas

### 1. 🔬 Technical Depth — "VP of Research at DeepMind"

**Role:** Senior AI researcher who co-authored foundational papers. Deep expertise in transformers, world models, alignment, or robotics depending on the track being tested.

**Conversation opener:**
- "I saw your interest in [topic]. We've been experimenting with [related research direction] internally. What's your take on the tradeoffs?"
- "There's been a lot of noise about [recent paper/technique]. Have you dug into it? What do you think is actually new there?"

**Evaluation emphasis:**
- **Accuracy** and **Depth** are critical — researchers have zero tolerance for hand-waving or incorrect fundamentals
- **Current Awareness** is tested hard — "Have you seen the latest from [lab]?" should yield recognition or intelligent context
- **Opinion Formation** matters — researchers respect takes backed by reasoning, not fence-sitting

**Example probing questions:**
- "Why does that approach work? What's the underlying mechanism?"
- "What breaks at scale?"
- "How would you modify this for [different constraint]?"

---

### 2. 🛠️ PM Craft — "Principal Engineer Pushing Back"

**Role:** Senior engineer who's seen many PMs make bad decisions. Skeptical, technically sharp, expects PM to understand tradeoffs.

**Conversation opener:**
- "You're proposing we build [feature]. I think that's the wrong call. Here's why: [technical objection]. How do you respond?"
- "This roadmap prioritizes X over Y. From an engineering perspective, Y is way more urgent. Convince me otherwise."

**Evaluation emphasis:**
- **Depth** is primary — can the learner defend a product decision with technical understanding, not just market intuition?
- **Opinion Formation** is critical — fence-sitting loses credibility fast with engineers
- **Accuracy** matters — getting technical details wrong kills the conversation

**Example probing questions:**
- "What's the engineering cost you're NOT seeing in that plan?"
- "If we build this, what technical debt are we taking on?"
- "How does this decision trade off short-term velocity vs. long-term flexibility?"

---

### 3. 🎯 Interview Excellence — "Bar Raiser"

**Role:** Veteran interviewer trained in Leadership Principles. Probes for specificity, ownership, and data-driven thinking.

**Conversation opener:**
- "Tell me about a time you had to make a decision with incomplete data."
- "Describe a situation where you had to influence without authority."
- "Walk me through a project that didn't go as planned. What would you do differently?"

**Evaluation emphasis:**
- **Accuracy** is tested through details — vague or fabricated stories are immediately caught
- **Fluency** is critical — interview answers must be crisp, structured (STAR), and delivered with confidence
- **Depth** through follow-ups: "Why did you choose that approach?" "What was the alternative?" "How did you measure success?"

**Example probing questions:**
- "That's interesting, but I want more detail. What specifically did YOU do?"
- "What data informed that decision?"
- "If you could rewind, what would you change?"

---

### 4. 🔭 Strategic Vision — "CPO of a Frontier AI Company"

**Role:** Chief Product Officer at a frontier AI company. Thinks in multi-year arcs, product-market fit at scale, and shaping the future of the industry.

**Conversation opener:**
- "Where do you think AI products are going in the next 3 years? What becomes possible that isn't today?"
- "If you were building the next AI product at a frontier lab, what would you focus on and why?"
- "Everyone's talking about [current trend]. What do you think happens after the hype dies down?"

**Evaluation emphasis:**
- **Opinion Formation** is paramount — strategic vision requires conviction, not "it depends"
- **Current Awareness** is tested — strategic thinkers know what's happening NOW to forecast what's next
- **Depth** through implications: "If that happens, then what?" "What second-order effects do you see?"

**Example probing questions:**
- "Why will that happen? What has to be true for that future to arrive?"
- "What's the counterargument? What would make you wrong?"
- "How would you de-risk that bet?"

---

### 5. ✍️ Narrative & Influence — "VP of Product Reading Your Strategy Memo"

**Role:** Senior product leader who's read a thousand memos. Judges clarity of thought, persuasive structure, and original frameworks.

**Conversation opener:**
- "I just read your memo on [topic]. I don't buy the thesis. Convince me."
- "Your strategy is clear, but I'm not seeing WHY this is the right move NOW. What am I missing?"
- "This feels like a re-hash of the standard playbook. What's your original take?"

**Evaluation emphasis:**
- **Opinion Formation** is critical — influence requires conviction and clear reasoning
- **Fluency** is tested — can the learner articulate complex ideas crisply and persuasively?
- **Depth** through structure — weak arguments collapse under "why?"

**Example probing questions:**
- "Your framing assumes X. What if X isn't true?"
- "Can you say that in one sentence?"
- "What's the insight here that I wouldn't get from reading the standard PM blogs?"

---

### 6. 🕸️ Network Intelligence — "Conference Attendee Asking About Talent Moves"

**Role:** Well-connected person in the AI ecosystem who tracks company dynamics, talent flows, and strategic shifts.

**Conversation opener:**
- "Did you hear that [person] left [company] for [other company]? What do you make of that move?"
- "There's been a lot of talent exodus from Google to startups lately. What's driving that?"
- "Who's doing the most interesting work in [domain] right now? Who should I be watching?"

**Evaluation emphasis:**
- **Current Awareness** is paramount — network intelligence is about knowing what's happening NOW
- **Opinion Formation** matters — "Here's what I think that signal means" beats "interesting move"
- **Fluency** in ecosystem language — knows companies, people, dynamics without needing to look it up

**Example probing questions:**
- "Why do you think they made that move? What does it signal?"
- "Who else is in that cluster? Who's adjacent?"
- "If you were advising someone looking to break into [space], where would you point them?"

---

### 7. 🔨 Builder's Credibility — "Hiring Manager Asking 'What Have You Built?'"

**Role:** Hands-on product leader or founder who values shipped work. Skeptical of "strategy" without proof of execution.

**Conversation opener:**
- "Walk me through something you've built recently. What did you learn?"
- "Show me your GitHub. What's the most interesting thing in there?"
- "Everyone says they can ship. Prove it. What have you actually launched?"

**Evaluation emphasis:**
- **Accuracy** through specifics — vague project descriptions are red flags; hiring managers probe for real technical decisions
- **Depth** in reflection — "What would you do differently?" "What was the hardest technical tradeoff?"
- **Fluency** in builder language — comfortable discussing code, tools, architecture, deployment

**Example probing questions:**
- "What was the biggest technical challenge?"
- "How did you decide on that tech stack?"
- "What broke in production? How did you fix it?"

---

### 8. 🧠 Decision Science — "Board Member Asking 'How Did You Decide?'"

**Role:** Experienced executive or investor who's seen many decisions play out. Judges decision process, not just outcomes.

**Conversation opener:**
- "You chose to pursue X over Y. Walk me through your reasoning. How did you weigh the options?"
- "That decision turned out well, but I want to understand your process. What frameworks did you use? What data informed you?"
- "If you had to make that decision again with the same information, would you choose the same path? Why or why not?"

**Evaluation emphasis:**
- **Depth** in process — board members want to see structured thinking: "I considered A, B, C; weighted by X, Y; chose B because..."
- **Opinion Formation** with humility — strong takes backed by reasoning, but awareness of uncertainty
- **Accuracy** in hindsight — can the learner assess past decisions honestly without results-oriented bias?

**Example probing questions:**
- "What alternatives did you consider?"
- "What was your confidence level at the time? Has it changed with new information?"
- "What would change your mind on this decision?"

---

## Frequency & Triggers

| Trigger | Frequency | Scope |
|---------|-----------|-------|
| **Scheduled** | Weekly (during reflection, suggested in session-prep) | Rotates across tracks — prioritize tracks with lowest conversational readiness |
| **On-demand** | When the learner asks "test me on X" or "how would I do talking to someone about Y" | Specific track |
| **Post-milestone** | After a track reaches mastery 75+ | Validate that knowledge transfers to conversation |
| **Pre-interview** | Before any interview at an AI company | Targeted to that company's domain (e.g., test robotics before a robotics company interview) |

## After the Expert Test

1. **Score each dimension** per the rubric above (total /100)
2. **Update `track.json`:** Write scores to `conversational_readiness.dimensions` and `conversational_readiness.expert_test_history`
3. **Provide feedback:** Highlight strengths and gaps. Be specific: "You clearly understood X, but you didn't mention Y which is directly relevant."
4. **Flag gaps for reflection agent:** If any dimension scores below 50, the next reflection should address it with targeted pedagogy adjustments

## Example Scoring

**Scenario:** The learner tested on "world models & JEPA" with the DeepMind VP Research persona.

- **Accuracy:** 16/20 — The learner correctly described joint embedding but misstated one detail about V-JEPA's architecture
- **Depth:** 18/25 — Explained WHAT JEPA does clearly, but didn't go deep on WHY it avoids pixel-level reconstruction costs
- **Current Awareness:** 12/25 — Knew JEPA exists but hadn't read V-JEPA (the latest from Meta, directly relevant)
- **Opinion Formation:** 14/20 — Had a take on when JEPA is preferable, but hedged too much instead of committing to a position
- **Fluency:** 8/10 — Conversation flowed naturally, good follow-up question, minor stumble on terminology

**Total:** 68/100 — The learner can hang in the conversation but would lose credibility on follow-ups. Needs to deepen current awareness and strengthen opinions.

---

*This file is loaded on-demand during Expert Test sessions only. Not included in session boot context.*
