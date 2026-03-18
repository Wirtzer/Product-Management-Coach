# First Principles Thinking

**Purpose:** Break down complex problems into their fundamental truths and reason up from there, rather than reasoning by analogy or convention.

**Best for:** Novel problem-solving, challenging assumptions, innovation, strategy under uncertainty.

**Origin:** Aristotle defined first principles as "the first basis from which a thing is known." Modernized by thinkers like Elon Musk ("I think it's important to reason from first principles rather than by analogy").

---

## The Core Idea

Most reasoning is **reasoning by analogy:**
- "Other companies in our space charge per seat, so we should charge per seat."
- "The standard approach to this problem is X, so let's do X."
- "Last time we did Y and it worked, so let's do Y again."

Analogy is efficient but conservative. It inherits the assumptions (and limitations) of the thing you're copying.

**First principles thinking** strips away assumptions and asks:
1. What are the fundamental truths we know to be true?
2. What can we build up from those truths?

---

## The Three-Step Process

### Step 1: Identify and Challenge Assumptions
Take the conventional wisdom and ask "Why?" repeatedly until you hit bedrock.

**Example: "Electric cars are expensive"**
- Why? → Batteries are expensive
- Why? → Battery materials are expensive
- Why? → We buy them in finished form from suppliers
- What are the raw materials? → Cobalt, nickel, lithium, carbon, steel
- What do those cost on the commodity market? → ~$80/kWh worth of materials
- But we're paying → ~$300/kWh for finished batteries
- First principle: The raw materials for a battery pack cost significantly less than what we're paying. The gap is manufacturing and supply chain — both of which can be optimized.

### Step 2: Build from the Foundation
Using only the fundamental truths, construct a new solution.

- If raw materials cost $80/kWh, and we can build our own manufacturing process, we can dramatically reduce battery cost.
- This reasoning led Tesla to build Gigafactories — vertical integration from raw materials to finished packs.

### Step 3: Validate and Iterate
First principles solutions are often unconventional. Test them before going all-in.

- Prototype the approach
- Compare cost/performance to the analog-based solution
- Adjust based on reality (some assumptions may have been load-bearing for good reason)

---

## Reasoning by Analogy vs. First Principles

| Dimension | Analogy | First Principles |
|-----------|---------|------------------|
| Speed | Fast (copy what works) | Slow (rebuild from scratch) |
| Risk | Low (proven pattern) | Higher (novel approach) |
| Innovation | Incremental | Breakthrough |
| When to use | Commodity problems, time pressure | Novel problems, high stakes |
| Failure mode | Copying a bad pattern | Over-engineering a simple problem |

**The key insight:** You don't need first principles for everything. Use analogy for 90% of decisions. Reserve first principles for the 10% where the conventional approach isn't working or where breakthrough innovation matters.

---

## How to Decompose Problems

### The "Why?" Chain
Keep asking "Why?" until you hit a physical law, mathematical truth, or empirically verified fact.

**Problem:** "Our users aren't completing onboarding"
- Why? → The onboarding takes too long
- Why does it take long? → We ask for 12 pieces of information
- Why do we ask for 12? → Because each feature needs configuration
- Why does each feature need configuration? → Because we assumed users want full customization on day one
- **First principle:** Users want to get value quickly. Configuration can happen after they've experienced the value.

### The "What Would Have to Be True?" Framework
Instead of asking "Will this work?", ask "What would have to be true for this to work?"

**Idea:** "Build a PM coaching product that uses spaced repetition"
- What would have to be true?
  - Learning PM skills benefits from repetition (true — behavioral patterns, frameworks)
  - AI can assess understanding quality (true — with the right rubrics)
  - People will return daily for coaching (uncertain — needs validation)
  - Spaced repetition intervals transfer to soft skills (partially true — needs adaptation)

Each "what would have to be true" becomes a testable hypothesis.

### The Constraint Removal Exercise
List all constraints, then ask: "What would we do if this constraint didn't exist?"

- "What if we had unlimited engineering resources?" → Reveals what you'd build if effort weren't the constraint
- "What if there were no legacy systems?" → Reveals what the ideal architecture looks like
- "What if the user had no prior expectations?" → Reveals whether you're designing for convention or for utility

Then ask: "Which of these constraints are real, and which are assumed?"

---

## When to Use in PM Work

### Product Strategy
- "Why do we compete in this market this way?"
- Challenge category conventions
- Identify where competitors are all making the same assumption

### Pricing
- "What is the actual value delivered per unit?"
- Strip away "industry-standard pricing" and reason from value

### Feature Design
- "What does the user fundamentally need?"
- Remove feature bloat by going back to the core job-to-be-done

### Technical Architecture
- "What are the fundamental computational requirements?"
- Challenge "we've always done it this way" engineering assumptions

### Prioritization Under Uncertainty
- When data is scarce and analogy is unreliable
- When entering a genuinely new market or category

---

## Pitfalls

### 1. First-Principling Everything
Not every problem deserves deep decomposition. "What color should the button be?" does not need first principles analysis. Use judgment.

### 2. Ignoring Learned Wisdom
Convention exists for a reason. Before dismissing best practices, understand WHY they became best practices. Sometimes the constraint you're removing is load-bearing.

### 3. Analysis Paralysis
First principles thinking can be slow. Set a time box. "I'll spend 30 minutes reasoning from first principles, then decide if the insight is worth pursuing."

### 4. Arrogance
"I've thought about this from first principles, so everyone else is wrong" is a failure mode. Your first principles reasoning might have an error. Stay humble and validate.

---

## How to Use in Interviews

**When asked a strategy question with no clear answer:**
1. "I'd approach this from first principles rather than copying what competitors do."
2. Identify 2-3 assumptions in the conventional approach
3. Challenge one explicitly: "The assumption here is X. But is that actually true?"
4. Build a different answer from the fundamental truth

**When asked "How would you approach a totally new problem?":**
1. Decompose into fundamentals: "What do we know to be true?"
2. Identify assumptions: "What are we assuming that might not be true?"
3. Build up: "Given these fundamentals, what's the best approach?"
4. Validate: "Here's how I'd test this before committing"

**Key insight:** "First principles thinking is most powerful when everyone in the room is anchored on the same analogy. If every competitor charges per seat, asking 'Why per seat?' can reveal a pricing model that's actually better aligned with customer value — and that becomes a competitive advantage."
