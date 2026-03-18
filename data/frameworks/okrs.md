# OKRs (Objectives and Key Results)

**Purpose:** Goal-setting framework that aligns teams around measurable outcomes instead of outputs.

**Best for:** Quarterly planning, team alignment, ensuring everyone is working toward the same outcomes.

**Origin:** Developed by Andy Grove at Intel, popularized by John Doerr at Google.

---

## Structure

### Objective
**What do we want to achieve?**

- Qualitative and inspiring
- Time-bound (usually quarterly)
- Ambitious but achievable
- Answers "Where do we want to go?"

**Good:** "Make our onboarding experience so good that new users can't wait to invite their team."
**Bad:** "Increase DAU by 15%." (That's a Key Result, not an Objective.)

### Key Results (2-5 per Objective)
**How will we know we got there?**

- Quantitative and measurable
- Specific numbers with clear baselines
- Outcome-based (what changed), not output-based (what we shipped)
- Answers "How will we know we arrived?"

**Good:** "Increase Day-7 retention from 35% to 50%."
**Bad:** "Ship the new onboarding flow." (That's a task, not a result.)

---

## Committed vs. Aspirational OKRs

### Committed OKRs (Roofshots)
- Expected to be fully achieved (100% completion)
- Tied to business-critical outcomes
- Missing these means something went wrong
- Example: "Maintain 99.9% uptime" (non-negotiable)

### Aspirational OKRs (Moonshots)
- Expected to be achieved at 60-70% (by design)
- Push the team beyond comfortable territory
- Achieving 100% means you didn't aim high enough
- Example: "Become the #1 recommended tool in our category on G2"

**Mix recommendation:** 1-2 committed + 1-2 aspirational per quarter.

---

## How to Write Good OKRs

### The Objective Test
Ask: "If I achieved this, would I be proud to present it at the all-hands?" If yes, it's probably a good objective. If it sounds like a task list item, it's not ambitious enough.

### The Key Result Test
For each KR, ask:
- **Measurable?** Can I check a dashboard on the last day of the quarter and know if we hit it?
- **Outcome-based?** Does it measure what changed for the customer or business, not what we built?
- **Not gameable?** Could we hit this number by doing something that actually hurts the product?

### Common Patterns

**Anti-pattern: Output-based KRs**
```
Objective: Improve the search experience
KR1: Ship autocomplete feature       ← OUTPUT (what we built)
KR2: Redesign search results page     ← OUTPUT
KR3: Add filters to search            ← OUTPUT
```

**Better: Outcome-based KRs**
```
Objective: Make finding what you need effortless
KR1: Reduce average search-to-click time from 8s to 4s
KR2: Increase search success rate from 62% to 80%
KR3: Reduce "no results" rate from 15% to 5%
```

The first version prescribes solutions. The second defines success and lets the team find the best path.

---

## How to Cascade OKRs

### Top-Down: Company → Team → Individual

```
Company Objective: Become the market leader in SMB
  ├── Product Team Objective: Make our product indispensable for small teams
  │     ├── KR: Increase weekly active teams from 5K to 12K
  │     └── KR: Achieve NPS of 60+ among teams < 10 people
  ├── Sales Team Objective: Dominate the SMB segment
  │     ├── KR: Close 200 new SMB accounts
  │     └── KR: Reduce SMB sales cycle from 45 to 25 days
  └── Engineering Objective: Build a platform that SMBs love
        ├── KR: Reduce setup time from 2 hours to 15 minutes
        └── KR: Zero P0 incidents affecting SMB users
```

### Rules for Cascading
1. **Alignment, not duplication:** Team OKRs should contribute to company OKRs, not copy them verbatim.
2. **Autonomy at each level:** Teams choose HOW to achieve their OKRs. The company sets the direction, not the path.
3. **No more than 3 levels deep.** Company → Team → Individual is plenty. More creates bureaucracy.
4. **Bottom-up input:** Teams should propose their OKRs based on company direction, not receive them top-down.

---

## The OKR Cycle

### Week 0-2: Setting
- Company leadership sets company-level OKRs
- Teams propose team-level OKRs that support company OKRs
- Negotiate, align, finalize

### Week 1-11: Executing
- Weekly check-ins: Are we on track? (Green/Yellow/Red)
- Mid-quarter review: Adjust approach if behind (but don't change the OKR)
- Teams update confidence scores weekly

### Week 12: Scoring
- Score each KR: 0.0 (no progress) to 1.0 (fully achieved)
- Aspirational OKRs: 0.6-0.7 is a success
- Committed OKRs: Below 1.0 needs a post-mortem
- Retrospective: What worked? What would we change?

---

## Common Pitfalls

### 1. Too Many OKRs
3-5 objectives maximum. More than that and nothing gets focus. "If everything is a priority, nothing is."

### 2. Confusing OKRs with Task Lists
OKRs define outcomes, not activities. "Ship feature X" is a task. "Reduce churn by 20%" is a key result.

### 3. Setting and Forgetting
OKRs need weekly check-ins. If you only look at them when setting and scoring, they're not driving behavior.

### 4. Tying OKRs Directly to Compensation
This encourages sandbagging — setting easy OKRs to guarantee a bonus. Google explicitly decoupled OKRs from performance reviews.

### 5. Not Including Quality Guardrails
"Increase sign-ups by 50%" without a retention guardrail could drive low-quality acquisition. Always pair growth KRs with quality KRs.

---

## How to Use in Interviews

**When asked "How would you set goals for this product?":**
1. "I'd use OKRs to align on outcomes rather than outputs."
2. Write one Objective and 2-3 Key Results on the spot
3. Explain why the KRs are outcome-based, not output-based
4. Show how team OKRs cascade from company OKRs

**When asked about execution and prioritization:**
- Use OKRs to frame what matters this quarter
- Use RICE to prioritize the projects that move the Key Results
- Show how weekly check-ins keep the team on track

**Key insight:** "The most common OKR failure I've seen is writing output-based Key Results — 'Ship X, Build Y, Launch Z.' These feel productive but don't guarantee you moved the needle. The discipline of OKRs is forcing yourself to define what 'moved the needle' means before you start building."
