# Opportunity Solution Tree

**Purpose:** Map the path from a desired outcome to specific experiments, ensuring every solution is connected to a real customer opportunity.

**Best for:** Product discovery, connecting research to solutions, avoiding "solution-first" thinking, aligning teams on what to explore.

**Origin:** Developed by Teresa Torres as a core tool in her Continuous Discovery Habits framework.

---

## The Structure

```
                [Desired Outcome]
                /       |       \
        [Opportunity] [Opportunity] [Opportunity]
         /     \         |          /     \
   [Solution] [Sol]  [Solution]  [Sol]  [Sol]
      |          |       |         |       |
   [Experiment] [Exp]  [Exp]    [Exp]   [Exp]
```

### Layer 1: Desired Outcome
The measurable business or product outcome you're trying to achieve. This comes from your OKRs or strategy.

**Examples:**
- "Increase weekly active users by 20%"
- "Reduce time-to-first-value from 3 days to 30 minutes"
- "Improve NPS from 42 to 60"

**Rule:** One tree per outcome. Don't mix outcomes.

### Layer 2: Opportunities
Customer needs, pain points, or desires that, if addressed, would move the outcome. These come from research — interviews, data, support tickets, observations.

**Examples** (for outcome: increase WAU):
- "Users forget the product exists between sessions"
- "Users can't find the feature that would help them most"
- "Users complete their task but don't see what else the product can do"

**Rule:** Opportunities are customer problems, not solutions. "Users need email reminders" is a solution. "Users forget the product exists" is an opportunity.

### Layer 3: Solutions
Specific product changes that address the opportunity. Multiple solutions per opportunity — you're exploring, not committing.

**Examples** (for opportunity: users forget the product exists):
- Weekly email digest with personalized highlights
- Push notification when new content is relevant
- Integration with tools they already use daily (Slack, calendar)
- Reduce friction so they solve more tasks per session (fewer reasons to leave)

### Layer 4: Experiments
How you'll test whether a solution actually works. Small, fast, cheap tests before building the full thing.

**Examples** (for solution: weekly email digest):
- Send a manually crafted email to 100 users, measure re-engagement
- A/B test: email vs. no email, measure WAU difference
- Survey: "Would you open a weekly summary email?" (weakest signal)

---

## How to Use the Tree

### Step 1: Set the Outcome
Pull from your OKRs or current strategic priority. Write it at the top of a whiteboard or doc.

### Step 2: Populate Opportunities from Research
Don't brainstorm opportunities — discover them. Sources:
- Customer interviews (most reliable)
- Support tickets and complaints
- Analytics (where do users drop off? what do they skip?)
- Sales call recordings
- Social media and reviews

**Aim for 5-10 opportunities per outcome.** You'll prioritize later.

### Step 3: Prioritize Opportunities
You can't address all opportunities at once. Prioritize by:
- **Frequency:** How many customers face this?
- **Severity:** How painful is it?
- **Strategic fit:** Does addressing this align with our strengths?

Pick 2-3 to explore with solutions.

### Step 4: Generate Solutions
For each prioritized opportunity, brainstorm 3-5 solutions. Range from simple to ambitious.

**Key discipline:** Don't fall in love with one solution. The tree forces you to explore multiple paths, which leads to better decisions.

### Step 5: Design Experiments
For each promising solution, design the smallest possible test:
- **Prototype test:** Show a mockup and observe reactions
- **Wizard of Oz:** Manually deliver the experience before building it
- **Concierge:** Do the job for the customer manually to validate demand
- **Fake door:** Show the feature in the UI and measure clicks (but explain it's coming soon)
- **A/B test:** Ship a minimal version to a small percentage of users

---

## Worked Example

**Outcome:** Reduce churn from 8% to 4% monthly

**Opportunities (from customer interviews):**
1. Customers don't see enough value in the first week
2. Customers outgrow the free tier but balk at the price jump
3. Customers' key champion leaves the company and no one else knows the product
4. Customers find a competitor that does one thing better (even if worse overall)

**Prioritized opportunity:** #1 — first-week value (highest frequency, most addressable)

**Solutions:**
- A. Guided onboarding with milestone celebration
- B. Personalized "quick win" tutorial based on use case
- C. Assign a customer success rep for the first 7 days
- D. Reduce setup steps from 8 to 3

**Experiments:**
- A: Build a simple 3-step onboarding wizard, measure Day-7 activation rate
- B: Manually send personalized "try this" emails to 50 new users, measure engagement
- C: Have 2 CSRs handle 20 accounts each, compare to self-serve cohort
- D: Remove 5 setup steps behind feature flags, measure completion rate

---

## Common Mistakes

### 1. Starting with Solutions
"Let's build a chatbot" → finds reasons to justify it. Instead: discover the opportunity first, then explore whether a chatbot is the right solution.

### 2. One Solution per Opportunity
If you only have one solution, you haven't explored enough. Force yourself to generate at least 3. The best solution is often the third or fourth one you think of.

### 3. Skipping Experiments
"We already know this will work" → Build it → It doesn't work → Months wasted. Experiments are cheaper than engineering time.

### 4. Orphan Solutions
Solutions that don't connect to an opportunity are pet projects. Every solution on the tree must trace back to a real customer need.

### 5. Static Trees
The tree should evolve weekly as you learn from experiments and interviews. A frozen tree means you stopped learning.

---

## How to Use in Interviews

**When asked "How would you approach improving [metric]?":**
1. "I'd use an Opportunity Solution Tree to connect customer needs to testable solutions."
2. Name the outcome (the metric)
3. Brainstorm 3-4 opportunities (customer pain points that affect the metric)
4. For the top opportunity, sketch 2-3 solutions
5. Describe one experiment you'd run first

**When asked about product discovery:**
1. "I believe in continuous discovery — weekly customer interviews that feed an Opportunity Solution Tree."
2. Explain how the tree prevents solution-first thinking
3. Show how experiments reduce risk before full build

**Key insight:** "The Opportunity Solution Tree forces you to separate the problem space from the solution space. Most product failures I've seen come from jumping to solutions without deeply understanding the customer's real problem. The tree makes that impossible."
