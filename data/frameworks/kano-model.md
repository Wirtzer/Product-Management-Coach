# Kano Model

**Purpose:** Classify features by how they affect customer satisfaction — distinguishing between features that prevent dissatisfaction, features that increase satisfaction proportionally, and features that create delight.

**Best for:** Feature prioritization, product differentiation, understanding which features are table stakes vs. competitive advantages.

**Origin:** Developed by Professor Noriaki Kano in the 1980s at Tokyo University of Science.

---

## The Five Categories

### Must-Be (Basic Expectations)
Features customers expect as a given. Their presence doesn't create satisfaction — but their absence creates strong dissatisfaction.

**Characteristics:**
- Customers don't ask for them (they're assumed)
- Having them doesn't impress anyone
- Missing them is a deal-breaker

**Examples:**
- A hotel room has a working lock on the door
- An e-commerce site accepts credit cards
- A messaging app delivers messages reliably
- A car has seatbelts

**PM implication:** Invest enough to meet the bar, but don't over-invest. No one gives you credit for an exceptionally good door lock.

### Performance (Linear Satisfaction)
Features where satisfaction scales proportionally with performance. More = better, in a predictable way.

**Characteristics:**
- Customers explicitly ask for these
- Competitors are compared on these dimensions
- Improvement always increases satisfaction (diminishing returns at extremes)

**Examples:**
- Battery life on a phone (more hours = more satisfaction)
- Storage space on a cloud service
- Speed of delivery (2-day → same-day → 1-hour)
- Camera resolution (up to a point)

**PM implication:** Benchmark against competitors. You need to be competitive on performance features. Being significantly better here is a reliable way to win.

### Attractive (Delighters)
Features that customers don't expect but love when they discover them. Their absence doesn't cause dissatisfaction (because no one knew to expect them), but their presence creates outsized delight.

**Characteristics:**
- Customers can't articulate wanting them (before experiencing them)
- Create word-of-mouth and differentiation
- Lose their "delight" over time as competitors copy them (they eventually become Performance or Must-Be)

**Examples:**
- iPhone's first multi-touch interface (2007 — nobody expected it)
- Amazon's one-click ordering
- Spotify's Discover Weekly playlist
- A hotel leaving a handwritten welcome note

**PM implication:** This is where innovation happens. Delighters create competitive moats (temporarily). Invest in understanding latent needs that customers can't articulate.

### Indifferent
Features that customers don't care about — whether present or absent, satisfaction doesn't change.

**Characteristics:**
- No impact on purchase decision
- Often internal features or technical capabilities that don't translate to user value
- Sometimes features that made sense historically but no longer matter

**Examples:**
- The programming language the backend is written in (for most users)
- A feature used by <1% of users
- Supporting an obscure file format no one uses

**PM implication:** Stop building these. They consume engineering effort without creating value. Regularly audit your roadmap for indifferent features.

### Reverse
Features that actively decrease satisfaction for some customers. More of this feature = less satisfaction.

**Characteristics:**
- Polarizing — some users want it, others hate it
- Often related to complexity, notifications, or aggressive monetization
- Adding them can drive away a customer segment

**Examples:**
- Excessive push notifications
- Forced social features in a productivity tool
- Auto-playing video ads
- Mandatory account creation for a simple task

**PM implication:** If a feature is Reverse for a significant segment, make it optional or remove it. Segment carefully before shipping.

---

## How to Classify Features

### The Kano Questionnaire

For each feature, ask two questions:

**Functional:** "If the product HAS this feature, how do you feel?"
**Dysfunctional:** "If the product DOES NOT have this feature, how do you feel?"

Response options for each:
1. I like it
2. I expect it
3. I'm neutral
4. I can tolerate it
5. I dislike it

### Classification Matrix

| | Dysfunctional: Like | Expect | Neutral | Tolerate | Dislike |
|---|---|---|---|---|---|
| **Functional: Like** | Questionable | Attractive | Attractive | Attractive | Performance |
| **Expect** | Reverse | Indifferent | Indifferent | Indifferent | Must-Be |
| **Neutral** | Reverse | Indifferent | Indifferent | Indifferent | Must-Be |
| **Tolerate** | Reverse | Indifferent | Indifferent | Indifferent | Must-Be |
| **Dislike** | Reverse | Reverse | Reverse | Reverse | Questionable |

Survey 20-50 customers and aggregate. The majority classification wins.

---

## Using Kano in Prioritization

### Priority Order

1. **Must-Be features that are missing** → Fix immediately. These are causing active dissatisfaction.
2. **Performance features behind competitors** → Invest to reach parity, then surpass.
3. **Attractive features** → Invest selectively. These create differentiation.
4. **Indifferent features** → Deprioritize or cut. Free up resources.
5. **Reverse features** → Make optional or remove.

### Combined with RICE

Use Kano to categorize, then RICE to prioritize within categories:
- Must-Be features skip RICE — they're mandatory
- Performance features get RICE-scored against each other
- Attractive features get RICE-scored, with a bonus for differentiation potential
- Indifferent features don't get RICE-scored — they're cut

---

## The Kano Lifecycle

Features migrate over time:

```
Attractive → Performance → Must-Be
(Delighter)   (Expected)   (Table stakes)
```

**Example: GPS navigation**
- 2005: Attractive (wow, my phone can navigate!)
- 2012: Performance (which map app is most accurate?)
- 2020: Must-Be (a phone without maps is broken)

**PM implication:** Your current Attractive features will become tomorrow's Must-Be features. You need a continuous pipeline of delighters, or you'll eventually compete only on Performance features (a commodity position).

---

## How to Use in Interviews

**When asked "How would you prioritize features?":**
1. "I'd first classify features using the Kano model to understand what type of value each creates."
2. Identify one feature from the prompt as Must-Be, one as Performance, one as Attractive
3. Explain why Must-Be gets priority over Performance over Attractive for investment
4. Note that Attractive features drive differentiation — important for competitive positioning

**When asked about competitive strategy:**
1. "I'd map our features AND competitor features on the Kano model."
2. Identify where competitors are investing (probably Performance features)
3. Find Attractive features they're missing — that's your opportunity
4. Ensure your Must-Be features are solid (table stakes)

**Key insight:** "The Kano model explains why some features with huge usage don't drive satisfaction (Must-Be) and why some features that few people use create outsized loyalty (Attractive). Understanding this prevents you from over-investing in table stakes while under-investing in differentiation."
