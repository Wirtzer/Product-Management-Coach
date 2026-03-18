# North Star Metric (NSM)

**Purpose:** Identify the single metric that best captures the core value your product delivers to customers — then align the entire organization around improving it.

**Best for:** Product strategy, team alignment, measuring product-market fit, growth planning.

---

## What Makes a Good North Star Metric

A strong NSM has three properties:

### 1. It Reflects Customer Value
The metric goes up when customers get more value from your product. Revenue alone is NOT a good NSM — a customer can pay more without getting more value (price increase). A good NSM captures the value exchange.

### 2. It's a Leading Indicator of Revenue
If the NSM improves, revenue should follow (maybe with a lag). If revenue goes up but your NSM goes down, something unsustainable is happening.

### 3. It's Actionable
Teams can directly influence it through product decisions. "Brand perception" might be important but isn't directly actionable by a product team.

---

## Examples Across Industries

| Company | North Star Metric | Why It Works |
|---------|-------------------|--------------|
| Spotify | Time spent listening | Reflects engagement and value delivery |
| Airbnb | Nights booked | Captures the core value exchange |
| Slack | Messages sent in teams | Indicates team adoption and daily value |
| WhatsApp | Messages sent | Simple, reflects core use case |
| Uber | Rides completed | Captures the full value delivery loop |
| Netflix | Hours of content viewed | Engagement proxy for subscription retention |
| Shopify | Merchant GMV | Customer success = Shopify's success |

---

## How to Identify Your NSM

### Step 1: Define Your Core Value
What is the fundamental value your product provides? Not what you sell — what the customer gets.

- Spotify: Access to music → enjoyment during daily activities
- Airbnb: Accommodation listings → unique travel experiences
- Slack: Communication tool → team coordination and knowledge sharing

### Step 2: Find the Action That Captures Value Delivery
What user action demonstrates they received the value?

- Listening to music (not signing up, not browsing)
- Completing a stay (not searching, not booking)
- Sending a message to a teammate (not logging in)

### Step 3: Validate With the Three Tests

| Test | Question | Red Flag |
|------|----------|----------|
| Value test | Can the metric go up while customers get worse outcomes? | If yes, it's a vanity metric |
| Revenue test | If the metric doubles, would revenue eventually follow? | If no, it's disconnected from the business |
| Action test | Can the product team directly improve this metric? | If no, it's too abstract |

### Step 4: Set the Grain
Choose the right time granularity:
- **Daily active:** Good for high-frequency products (messaging, social)
- **Weekly active:** Good for moderate-frequency (productivity tools, commerce)
- **Monthly:** Good for lower-frequency (travel, financial products)

---

## Supporting Metrics (Input Metrics)

The NSM is the top of a metrics tree. Below it are 3-5 **input metrics** that each team or squad can own.

### Example: Spotify
**NSM:** Hours listened per user per week

**Input metrics:**
1. **Discovery rate** — % of users who play a new artist/playlist (Growth team)
2. **Session frequency** — Sessions per user per week (Retention team)
3. **Skip rate** — % of songs skipped within 30 seconds (Recommendations team)
4. **Playlist creation rate** — Playlists created per user (Engagement team)

Each team improves their input metric, which collectively drives the NSM.

### Building Your Metrics Tree

```
           [North Star Metric]
           /    |    |    \
     [Input 1] [Input 2] [Input 3] [Input 4]
     /   \      /   \      /   \     /   \
  [Sub]  [Sub] [Sub] [Sub] [Sub] [Sub] [Sub] [Sub]
```

**Rules:**
- Each input metric should be independently actionable by one team
- Input metrics should be non-competing (improving one shouldn't hurt another — if it does, you have the wrong metrics)
- Together, they should cover >80% of the variance in the NSM

---

## Common Mistakes

### 1. Choosing Revenue as the NSM
Revenue is a business outcome, not a customer value metric. It lags behind product quality. Use it as a guardrail, not a north star.

### 2. Choosing a Vanity Metric
Total sign-ups, page views, app downloads. These go up over time regardless of product quality. NSM should be per-user and activity-based.

### 3. Too Many North Stars
If everything is a north star, nothing is. One metric. Teams can have their own input metrics, but the company aligns on one NSM.

### 4. NSM That Can Be Gamed
"Messages sent" can be gamed by making the app send automated messages. Add quality guardrails: "Messages sent that receive a reply within 24 hours."

### 5. Never Updating the NSM
The right NSM can change as the product matures. A startup might focus on activation (first value moment), then shift to engagement (ongoing value), then retention (long-term value).

---

## How to Use in Interviews

**When asked "How would you measure success for [product]?":**
1. "I'd start by identifying the North Star Metric — the single metric that best captures the value we deliver to customers."
2. Walk through the three-step identification process
3. Propose a specific NSM with reasoning
4. Sketch 3-4 input metrics and which teams would own them

**When asked "What metrics would you track?":**
1. Start with the NSM (what matters most)
2. Fan out to input metrics (what teams can act on)
3. Add guardrail metrics (what we don't want to sacrifice)
4. Mention counter-metrics (early warnings that we're optimizing wrong)

**Key insight:** "The best North Star Metrics are not what the company cares about (revenue) — they're what the customer cares about (value). When you optimize for customer value, revenue follows. When you optimize for revenue directly, you often destroy customer value."
