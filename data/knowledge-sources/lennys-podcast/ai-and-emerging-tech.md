# AI & Emerging Tech — Insights from Lenny's Podcast

*Curated from [Lenny's Podcast](https://www.lennyspodcast.com/) by Lenny Rachitsky*

---

## Key Frameworks

### AI Evals as a PM Skill — Hamel Husain & Shreya Shankar, Ep #87
If you build AI products and haven't mastered evals, you're leaving massive improvements on the table. Evals are the systematic methodology for measuring whether your AI product is actually getting better. Most teams ship AI features based on vibes; the best teams build rigorous evaluation pipelines that catch regressions and quantify improvement.

**How to apply:** Start with simple human-judged evals before building automated ones. Define what "good" looks like for your specific use case with concrete examples. Track eval scores over time as your core product quality metric.

### Why Most AI Products Fail — Aishwarya Reganti & Kiriti Badam, Ep #110
After 50+ AI deployments at OpenAI, Google, and startups, the #1 failure mode: teams treat AI like traditional software. AI breaks the rules of software development — outputs are probabilistic, not deterministic. Most teams haven't learned to work differently. The hard part isn't the models — it's the workflow around them.

**How to apply:** Build for uncertainty from day one. Design UX that handles variable-quality outputs gracefully. Invest in evaluation and monitoring infrastructure before scaling. Accept that AI products require fundamentally different development rhythms.

### From Managing People to Managing AI — Julie Zhuo, Ep #86
The core skills of management — defining clear goals, understanding your team's strengths, building processes — translate almost directly to working with AI agents. As organizations flatten and AI tools proliferate, the manager/IC distinction is dissolving, but the challenge of getting results through external resources remains unchanged.

**How to apply:** Apply the same rigor to AI agent management as you would to people management: clear objectives, feedback loops, escalation paths, and quality standards.

### Building for What's Coming, Not What Exists — Boris Cherny (Claude Code), Ep #119
Claude Code went from internal experiment to 4% of global GitHub commits in one year. The key insight: the best AI innovations come from building for capabilities that don't yet exist but will soon. When you build for the current model, you're already behind by the time you ship.

**How to apply:** When building AI features, ask: "If the model were 3x better in 6 months, would this design still make sense?" Build abstractions that get better as models improve rather than locking into current limitations.

### The AI Security Crisis — Sander Schulhoff, Ep #106
Current AI systems are vulnerable to trivial attacks. The only reason we haven't seen catastrophic breaches is luck, not security. As agents gain the power to take actions on your behalf, this window is closing fast. Guardrails don't work against motivated attackers.

**How to apply:** Don't rely on prompt-level guardrails for security. Design systems with defense-in-depth: permission boundaries, action limits, human-in-the-loop for high-stakes operations. Security is a product requirement, not an afterthought.

### Humans Are AI's Biggest Bottleneck — Alexander Embiricos (OpenAI Codex), Ep #104
OpenAI's Codex has grown 20x since August. The real bottleneck isn't model capability — it's human review speed. The path to more productive AI isn't just smarter models; it's better workflows for humans to review, verify, and act on AI outputs.

**How to apply:** When building AI products, optimize the human review loop as aggressively as the model itself. Tools that help humans verify AI work faster will capture enormous value.

## Mental Models

### The Judgment Problem > The Compute Problem — Edwin Chen (Surge AI), Ep #103
AI advancement isn't primarily a compute problem — it's a judgment problem. The values of the companies building AI will fundamentally shape which models win. Surge AI reached $1B revenue with <100 people by understanding that teaching models *what* to value matters more than raw processing power.

### Engineers as Sorcerers — Sherwin Wu (OpenAI), Ep #117
At OpenAI, 95% of engineers use Codex daily and 100% of PRs are reviewed by AI. The engineer's role is shifting from writing code to directing AI agents that write code. The next 12-24 months represent a rare window for engineers to shape their own evolution before the role transforms entirely.

### AI Makes Design the New Moat — Dylan Field (Figma), Ep #92
When code is commoditized by AI, craft and quality become the true differentiator. "Good enough" is now a liability. The companies that invest in thoughtful design create switching costs that competitors — even those with superior AI — can't easily replicate.

### The Real AI Revolution Is in Heavy Industry — Qasar Younis (Applied Intuition), Ep #122
The biggest AI impact in the next 5-10 years won't be in coding assistants or chatbots — it will be in mines, farms, construction sites, and trucking operations where physical machines need intelligence. Applied Intuition built a $15B company on this thesis while staying almost entirely out of public view.

### AI-Native Means Organizational, Not Just Tooling — Dhanji Prasanna (Block CTO), Ep #94
Transforming a large enterprise to be AI-forward isn't about deploying tools — it's about restructuring teams, incentives, and workflows. At Block, the surprising teams benefiting most from AI agents are operational teams, not engineering.

## Top Lessons

1. **Most AI improvements come from unglamorous work** — Chip Huyen (NVIDIA, Netflix), Ep #93
   Talking to users, preparing better data, and optimizing workflows drive more improvement than chasing the newest models or vector databases. The myth that keeping up with AI news and adopting cutting-edge frameworks drives success is exactly that — a myth.

2. **Build the product PM skill, not the AI skill** — Zevi Arnovitz, Ep #112
   A non-technical PM at Meta with zero coding background ships real, money-making products using AI tools like Cursor. The skill that matters isn't technical AI knowledge — it's product judgment, user empathy, and clear thinking.

3. **The "vibe coder" is a new role** — Lazar Jovanovic, Ep #116
   Product, engineering, and design roles are converging into something entirely new. People get paid full-time to build products using AI with no coding background. The skill that matters: product thinking and the ability to clearly articulate what you want built.

4. **AI timing is "miraculously perfect"** — Marc Andreessen, Ep #114
   Contrary to panic about job losses, AI is arriving precisely when humanity needs it most — to counter demographic collapse and stagnant productivity. The real boom hasn't started yet.

5. **Both Chip Huyen (Ep #93) and the team from Ep #110 converge:** the #1 mistake in AI product development is treating AI like traditional software. Probabilistic outputs, variable quality, and rapid model improvement require fundamentally different product development approaches.

6. **Measure AI developer productivity differently** — Nicole Forsgren, Ep #121
   Traditional velocity measures fail in an AI-augmented world. PMs should track whether engineering teams are genuinely more productive — or just busier. Code volume is not the same as value delivery.

## Quotable Insights

> "The uncomfortable truth: most AI improvements come from unglamorous work — talking to users, preparing better data, and optimizing workflows." — Chip Huyen, Ep #93

> "Good enough is now a liability." — Dylan Field (Figma), Ep #92

> "The real bottleneck isn't compute or architectural innovations — it's humans teaching models what they don't know." — Jason Droege (Scale AI), Ep #90

> "95% of engineers at OpenAI use Codex daily. 100% of pull requests are reviewed by AI. This radical shift still feels nascent." — Sherwin Wu, Ep #117

> "AI is critical for humanity's survival." — Jeetu Patel (Cisco), Ep #120

## Recommended Deep Dives
- **Ep #87: Hamel Husain & Shreya Shankar on AI evals** — The most practical guide to measuring AI product quality
- **Ep #110: Why most AI products fail** — Essential diagnostics for any team building with AI
- **Ep #93: Chip Huyen on AI engineering** — Debunks myths about what actually drives AI product success
- **Ep #119: Boris Cherny on Claude Code** — Inside the fastest-growing AI coding tool; lessons on building for what's coming
- **Ep #92: Dylan Field on design as moat** — Why craft matters more, not less, in the AI era
- **Ep #122: Qasar Younis on Applied Intuition** — The contrarian case for AI in physical industries
