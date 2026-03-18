# Working Backwards

**Purpose:** Start from the desired customer experience and work backward to define what to build. Forces customer-centric thinking from day one.

**Best for:** New product/feature ideation, 0-to-1 products, validating whether an idea is worth pursuing.

**Origin:** Developed at Amazon as the standard product development process. Every new product starts with a PR/FAQ before any code is written.

---

## The Core Idea

Most product development starts with "What can we build?" and works forward to "Who wants this?"

Working Backwards flips this: Start with "What will the customer experience?" and work backward to "What do we need to build?"

This inversion catches bad ideas early. If you can't write a compelling press release, the product probably isn't compelling enough to build.

---

## The PR/FAQ Document

### Part 1: The Press Release (1 page)

A mock press release announcing the finished product. Written as if the product already launched successfully.

**Structure:**
1. **Headline:** One sentence that captures the customer benefit (not the feature)
2. **Sub-headline:** Who is this for and what do they get?
3. **Problem paragraph:** What pain point exists today?
4. **Solution paragraph:** How does this product solve it?
5. **Quote from company leader:** Why this matters strategically
6. **How it works:** Brief description of the experience (not the technology)
7. **Customer quote:** A fictional customer describing the benefit in their words
8. **Call to action:** How to get started

**Rules:**
- No jargon or technical language — write for the customer
- No internal metrics ("increases DAU by 15%") — describe customer outcomes
- If the press release is boring, the product is boring
- Maximum 1 page. If you can't explain it in 1 page, it's not clear enough.

### Part 2: The FAQ (2-5 pages)

Two sections of questions and answers:

**Customer FAQ:**
- How does it work?
- How much does it cost?
- Why should I switch from my current solution?
- What if [edge case]?
- Is my data safe?

**Internal FAQ:**
- How big is the market opportunity?
- What's the business model?
- What are the key dependencies and risks?
- How long will it take to build?
- Why now? Why hasn't this been done before?
- What do we need to believe for this to succeed? (Assumptions to validate)
- What are the 2-3 things that could kill this project?

---

## The Process

### Step 1: Write the PR
One person (usually the PM) writes the initial draft. Focus on the customer experience, not the technology.

### Step 2: Iterate the PR
Share with the team. The most common feedback: "This isn't specific enough" or "I can't tell why a customer would care." Iterate until the customer benefit is crisp and obvious.

### Step 3: Write the FAQ
Answer every hard question honestly. If you can't answer "Why will customers switch?", you have a problem — and it's better to discover it now than after 6 months of engineering.

### Step 4: Review and Decide
Leadership reviews the PR/FAQ. Possible outcomes:
- **Green light:** The vision is clear and compelling. Proceed to design.
- **Iterate:** The vision has gaps. Rewrite sections and come back.
- **Kill:** The customer benefit isn't strong enough. Save the engineering time.

### Step 5: The PR/FAQ Becomes the North Star
Throughout development, the team references the PR/FAQ to make decisions. "Does this feature support the promise we made in the press release?" If not, it's scope creep.

---

## Worked Example

**Idea:** An AI-powered meal planning app

**Headline:** "MealMind Eliminates the 'What's for Dinner?' Problem with AI-Personalized Weekly Meal Plans"

**Sub-headline:** Home cooks who hate meal planning can now get a personalized weekly plan — with grocery lists — in under 30 seconds.

**Problem:** 68% of home cooks say deciding what to eat is the most stressful part of cooking. Current meal planning apps require 30+ minutes of manual selection and don't learn your preferences.

**Solution:** MealMind asks five questions about your household (dietary needs, skill level, time constraints, taste preferences, budget) and generates a complete 7-day meal plan with a one-tap grocery list. It learns from what you actually cook and adapts.

**How it works:** Open the app Sunday morning. Review your personalized plan. Swap any meal with one tap. Send the grocery list to your preferred store for delivery or pickup. Cook. Rate what you liked. Next week's plan is even better.

---

## When This Approach Works Best

✅ **Ideal for:**
- New products or major features (0-to-1)
- Platform bets or strategic initiatives
- Any time the team is debating "should we build this?"
- Cross-functional alignment (everyone reads the same 1-page vision)

❌ **Less useful for:**
- Incremental improvements (use data + experimentation instead)
- Technical infrastructure (there's no "customer press release" for a database migration)
- Fast iteration cycles (writing a PR/FAQ for every A/B test is overkill)

---

## How to Use in Interviews

**When asked "How would you approach building [new product]?":**
1. "I'd start with a Working Backwards approach — write a mock press release from the customer's perspective."
2. Sketch the headline and first paragraph live
3. Identify the key FAQ questions you'd need to answer
4. Show how the PR/FAQ process de-risks the idea before engineering begins

**Key insight:** "The power of Working Backwards is that it forces you to articulate the customer benefit before you fall in love with the technology. If you can't write a compelling press release, you don't have a compelling product."

**When asked about prioritization:** "I use PR/FAQ for the 'should we build this at all?' question, and RICE for 'in what order should we build things we've already committed to?'"
