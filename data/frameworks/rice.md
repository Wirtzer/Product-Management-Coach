# RICE Prioritization Framework

**Purpose:** Quantitative scoring system for prioritizing features, projects, or initiatives.

**Best for:** Roadmap planning, backlog prioritization, resolving stakeholder disagreements about what to build next.

---

## The Four Dimensions

### R — Reach
**How many people will this impact in a given time period?**

- Measured in: users/month, transactions/quarter, or percentage of user base
- Must be a real number, not a guess — use data from analytics, surveys, or estimates
- Time-bound: "10,000 users per month" not just "a lot of users"

**Examples:**
- A settings change every user sees: Reach = 100% of MAU
- An enterprise feature for top accounts: Reach = 50 accounts/quarter
- A mobile-only feature: Reach = 60% of MAU (if 60% are mobile)

### I — Impact
**How much will this move the needle for each person reached?**

Use a standardized scale:
- **3** = Massive impact (completely solves a major pain point)
- **2** = High impact (significantly improves experience)
- **1** = Medium impact (noticeable improvement)
- **0.5** = Low impact (minor improvement)
- **0.25** = Minimal impact (barely noticeable)

**The hardest part:** Being honest about impact. Everything feels like a "3" when it's your idea. Force yourself to compare against past launches — what actually moved metrics?

### C — Confidence
**How confident are you in your estimates?**

- **100%** = High confidence — solid data, user research, A/B test precedent
- **80%** = Medium confidence — some data, directional signals
- **50%** = Low confidence — gut feel, no direct evidence

**Rule:** If you can't justify at least 50% confidence, the project needs more research before scoring.

### E — Effort
**How much total work is required?**

- Measured in: person-months (engineering + design + other)
- Include: development, testing, rollout, documentation, support
- Be honest about hidden costs (migrations, backward compatibility, etc.)

**Examples:**
- Quick experiment: 0.5 person-months
- Standard feature: 2 person-months
- Platform rewrite: 12 person-months

---

## The Formula

```
RICE Score = (Reach × Impact × Confidence) / Effort
```

**Higher scores = higher priority.**

### Example Calculation

| Project | Reach | Impact | Confidence | Effort | RICE Score |
|---------|-------|--------|------------|--------|------------|
| Search redesign | 50,000/mo | 2 | 80% | 4 mo | 20,000 |
| Dark mode | 30,000/mo | 1 | 100% | 1 mo | 30,000 |
| AI recommendations | 50,000/mo | 3 | 50% | 6 mo | 12,500 |

In this example, dark mode wins — not because it's the most impactful, but because it's high-reach, low-effort, and high-confidence. That's the power of RICE: it prevents you from always chasing the biggest, riskiest project.

---

## Best Practices

### 1. Score Everything on the Same Scale
Don't change the Reach unit mid-scoring. Pick one (users/month, transactions/quarter) and stick with it across all projects being compared.

### 2. Use RICE for Relative Ranking, Not Absolute Truth
The scores themselves are less important than the **relative order**. If changing an assumption doesn't change the ranking, the ranking is robust.

### 3. Have the Team Score Independently, Then Compare
Averaging individual RICE scores reduces bias. Discuss items where estimates diverge — that's where the real conversation happens.

### 4. Revisit Confidence After Research
Low confidence items aren't automatically deprioritized — they're flagged for research. Once you run a survey or prototype, re-score with better confidence.

### 5. Watch for Gaming
- Inflating Reach by counting tangential users
- Defaulting Impact to 2 for everything (use the full scale)
- Underestimating Effort (add 30% buffer for unknowns)
- Overconfidence (if you haven't talked to users, you're not at 100%)

---

## When to Use RICE

✅ **Good for:**
- Quarterly roadmap planning with 10-30 candidates
- Breaking ties between features that "feel" equally important
- Creating transparency in prioritization decisions
- Communicating tradeoffs to stakeholders

❌ **Not good for:**
- Strategic bets (building a new product line) — these don't fit neatly into Reach/Impact
- Compliance or security mandates — these bypass prioritization frameworks
- Foundational infrastructure — "rewrite the data pipeline" has diffuse, hard-to-quantify impact
- Very early-stage exploration — if you can't estimate Reach, RICE won't help yet

---

## RICE Variants

### ICE (Impact, Confidence, Ease)
Drops Reach. Simpler but loses the "who does this affect?" dimension. Good for early-stage products where all features touch all users.

### WSJF (Weighted Shortest Job First)
SAFe framework: (Business Value + Time Criticality + Risk Reduction) / Job Size. More complex, includes urgency. Better for enterprise contexts.

### Value vs. Effort Matrix
The 2x2 version of RICE. Quick and visual, but loses nuance. Good for whiteboard discussions, not rigorous planning.

---

## How to Use in Interviews

**When asked "How would you prioritize these features?":**
1. State the framework: "I'd use RICE to create a quantitative comparison."
2. Define your Reach metric based on the product context
3. Score 2-3 features quickly (don't calculate exact numbers — show the thinking)
4. Highlight where Confidence is low and what you'd research
5. Note any strategic factors RICE doesn't capture

**Key insight to demonstrate:** "RICE gives us a data-informed starting point, but it shouldn't be the only input. Strategic alignment, technical dependencies, and market timing also matter. I'd use RICE to identify the top candidates, then apply judgment for the final call."
