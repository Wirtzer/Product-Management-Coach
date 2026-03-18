# CIRCLES Framework

**Purpose:** Structured approach to product design questions — ensures you cover all critical aspects before jumping to solutions.

**Best for:** Product sense interviews, feature design, new product proposals.

---

## The Seven Steps

### C — Comprehend the Situation
Clarify the prompt before diving in. Ask questions to understand scope, constraints, and context.

**Key questions:**
- What is the product? Who makes it? What stage is it at?
- What's the business context? (Growth phase? Retention problem? New market?)
- Are there constraints? (Timeline, resources, platform, regulations)
- What does success look like?

**Common mistake:** Jumping to solutions without clarifying. Interviewers WANT you to ask questions — it shows product maturity.

### I — Identify the Customer
Who are you building for? Be specific — not "users" but specific segments with distinct needs.

**Key questions:**
- Who are the primary users? Secondary users?
- What segments exist? (Demographics, behavior, use case)
- Which segment should we prioritize and why?

**Pro tip:** State your chosen segment explicitly. "I'm going to focus on [segment] because [reason]. I can explore other segments afterward."

### R — Report the Customer's Needs
What are the user's pain points, goals, and jobs-to-be-done?

**Key questions:**
- What problem are they trying to solve?
- What's their current workflow? Where does it break?
- What are the emotional needs (not just functional)?
- What would delight them vs. what's table stakes?

### C — Cut Through Prioritization
You'll have many needs — prioritize ruthlessly.

**Prioritization criteria:**
- **Impact:** How many users affected? How severely?
- **Frequency:** Is this a daily pain or a rare annoyance?
- **Alignment:** Does it support the business goal stated in Step 1?
- **Feasibility:** Can we realistically build this?

**Framework:** Use a simple 2x2 (Impact vs. Effort) or RICE scoring to make your prioritization explicit.

### L — List Solutions
Brainstorm 3-5 solutions for your top-priority need. Range from conservative to ambitious.

**Good practice:**
- Start with the simplest possible solution
- Include one "moonshot" option
- Consider both product and non-product solutions (e.g., better onboarding vs. new feature)
- Think across the stack: UI changes, backend logic, data/ML, process changes

### E — Evaluate Tradeoffs
Compare your solutions on clear dimensions.

**Evaluation dimensions:**
- User impact (which solves the need best?)
- Engineering cost (build time, complexity, tech debt)
- Business impact (revenue, retention, engagement)
- Risk (what could go wrong?)
- Reversibility (can we undo this if it fails?)

**Pro tip:** Be explicit about tradeoffs. "Solution A is faster to build but doesn't scale. Solution B takes 3x longer but creates a platform we can extend."

### S — Summarize Your Recommendation
Close with a clear recommendation. State what you'd build, why, and what you'd measure.

**Template:**
> "I recommend [Solution X] because it [addresses the key need] for [target segment]. We'd measure success by [metric]. The main risk is [risk], which we'd mitigate by [approach]. As a next step, I'd [validate/prototype/A-B test]."

---

## Worked Example

**Prompt:** "How would you improve Instagram for creators?"

1. **Comprehend:** Instagram is a mature social platform. Creators are a key growth lever. Revenue comes from ads — creators drive engagement that drives ad revenue.
2. **Identify:** Focus on mid-tier creators (10K-100K followers) — large enough to be serious, small enough to need help growing. They create the most diverse content.
3. **Report needs:** Discoverability is the #1 pain point. Mid-tier creators struggle to reach new audiences. They also lack analytics to understand what's working.
4. **Cut:** Discoverability > Analytics > Monetization. Discoverability unlocks the others.
5. **List:** (a) Improved recommendation algorithm, (b) "Creator spotlight" features, (c) Cross-pollination between Reels and Stories, (d) Collaborative content tools.
6. **Evaluate:** (a) is high-impact but opaque to users. (d) is user-visible and creates network effects. Recommend (d) with (a) as backend support.
7. **Summarize:** "I'd build collaborative content tools — co-authored posts and duets — because they let mid-tier creators tap into each other's audiences. We'd measure by creator-to-creator collaboration rate and new follower acquisition for participating creators."

---

## How to Use in Interviews

1. **Say the framework name:** "I'll use the CIRCLES framework to structure my answer."
2. **Don't rush:** Spend 2-3 minutes on C and I before touching solutions.
3. **Be explicit about choices:** "I'm prioritizing X over Y because..."
4. **Time management:** ~2 min on C+I, ~2 min on R+C, ~3 min on L+E+S for a 7-minute answer.
5. **Invite follow-ups:** "I focused on mid-tier creators — happy to explore other segments if you'd like."

---

## When NOT to Use CIRCLES

- **Metric/analytics questions** → Use a metrics tree or funnel analysis instead
- **Strategy questions** → Use a strategy framework (market analysis, competitive positioning)
- **Estimation questions** → Use a Fermi estimation approach
- **Execution/prioritization questions** → Use RICE or a prioritization matrix directly

CIRCLES is for **"design a product/feature"** questions. If the question is about something else, pick a better-fit framework.
