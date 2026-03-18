# Example Expert Persona Test (Annotated)

This example shows a complete expert persona test — from persona adoption through scoring and track update.

> **Note:** This is a synthetic example for illustration. No personal data is included.

---

## Setup

The learner requests an expert test on the AI Foundations track. The coach loads the "VP of Research at DeepMind" persona from `learning/pedagogy/expert-personas.md`.

```
Learner: Test me on AI foundations. I want to see how I'd do talking
to a technical researcher.

Coach: Alright. Switching into persona mode.

[The coach will now adopt the VP of Research persona. This is a
simulated coffee chat at a conference — natural conversation, not
a quiz. I'll score you afterward on 5 dimensions.]
```

---

## The Conversation

```
VP of Research: I saw your background is in product management.
We've been doing some interesting work on attention mechanisms
recently — specifically around efficient attention for long-context
models. What's your take on where that space is heading?
```

> **What's happening:** The persona opens with a topic relevant to the learner's track (AI Foundations) and immediately tests Current Awareness — do they know about recent work in efficient attention?

```
Learner: Yeah, so attention is fundamentally an O(n²) problem with
sequence length, which is why there's been so much work on
alternatives. I think the most interesting direction is the sparse
attention approaches — things like FlashAttention showed you can
get huge speedups without changing the attention pattern, just by
being smart about memory access.

VP of Research: FlashAttention is more of an implementation
optimization than a fundamental change to attention, though. What
about approaches that actually change the mechanism itself? Ring
attention, for instance, or some of the linear attention variants?
```

> **What's happening:** The persona acknowledged the learner's point but pushed deeper. The learner mentioned FlashAttention correctly but the persona probes whether they understand the distinction between implementation optimization and architectural change.

```
Learner: Right, fair point. FlashAttention is about the
hardware-software interface, not the algorithm. For actual
architectural changes... linear attention is interesting
because it reduces complexity to O(n), but my understanding is
that the quality degrades for certain types of tasks — especially
anything requiring precise token-to-token relationships. I haven't
dug deep into ring attention specifically.

VP of Research: Honest answer — I appreciate that. What about the
approach of not using attention at all? State space models, for
instance — Mamba and its successors?

Learner: Mamba is really compelling. The idea that you can get
transformer-level performance with linear scaling by using
selective state spaces... I think the big question is whether SSMs
can match transformers on the tasks that really require attending to
specific positions in context. The benchmarks look good but I've
heard mixed feedback from people actually deploying them.

I think the PM angle is interesting too — if SSMs deliver comparable
quality at much lower inference cost, that changes the economics of
deploying large language models pretty dramatically. You could serve
models to way more users at the same hardware budget.

VP of Research: That's a good product instinct. Let me push on
something: what would have to be true for SSMs to actually replace
transformers in production? Not just match benchmarks, but actually
become the default architecture?
```

> **What's happening:** The conversation has moved naturally through several topics. The persona is testing depth (can the learner go beyond surface-level?), opinion formation (do they have a take?), and now asking a first-principles strategy question.

```
Learner: A few things. First, they'd need to match transformer
performance on in-context learning — that's where transformers
really shine and it's the basis of few-shot prompting which
everyone depends on now. Second, the tooling ecosystem would need
to catch up — fine-tuning infrastructure, RLHF pipelines, all the
stuff that's been built for transformer architectures. Third, and
this is the product angle — some flagship model would need to ship
with an SSM backbone and demonstrably match GPT-4 or Claude quality.
Until a major player makes that bet publicly, enterprises won't
switch.

My take is that we'll probably see hybrid architectures first —
transformers for the reasoning-heavy parts and SSMs for the long-
context processing parts. That seems like a more likely near-term
path than wholesale replacement.

VP of Research: Interesting. One more thing — you mentioned JEPA
earlier. How does Yann LeCun's vision for world models fit into
this landscape? Do you see a future where we move away from
autoregressive generation entirely?
```

> **What's happening:** The persona tests whether the learner can connect different research threads into a coherent worldview. This probes Opinion Formation and Depth simultaneously.

```
Learner: I find LeCun's vision really compelling intellectually but
I'm not sure about the timeline. The idea that prediction should
happen in a learned latent space rather than pixel space makes
intuitive sense — it's how humans seem to model the world. We don't
predict the next pixel, we predict the next state at a higher level
of abstraction.

But JEPA is still mostly in the research phase for practical
applications. V-JEPA showed it works for video understanding,
but we haven't seen it applied to the kind of generative tasks
that transformers dominate.

I think... my honest take is that autoregressive generation is so
deeply entrenched now — both in the architectures and the product
interfaces built on top of them — that moving away from it would
require not just a technical breakthrough but a UX paradigm shift.
Chat interfaces assume token-by-token generation. If your model
doesn't generate that way, you need to rethink the entire product
surface.

VP of Research: That's a thoughtful answer. I think we'd have a
good conversation over dinner. Let me switch back to coach mode.
```

---

## Scoring

```
Coach: [Back in coach mode] Great conversation. Here's your
Expert Test scoring:

🔬 VP of Research — AI Foundations Test

| Dimension | Score | Notes |
|-----------|-------|-------|
| Accuracy | 16/20 | Correctly described attention complexity, FlashAttention's nature, SSM basics. Minor: V-JEPA attribution was slightly imprecise — it was Meta AI, and there have been follow-up papers worth knowing. |
| Depth | 19/25 | Strong on the "what would have to be true" analysis for SSM adoption. Good product-architecture connection. Could have gone deeper on WHY in-context learning is hard for SSMs specifically. |
| Current Awareness | 14/25 | Knew Mamba and V-JEPA. Didn't know ring attention. Didn't reference any 2025 papers or the latest state-space developments. This is the biggest gap. |
| Opinion Formation | 16/20 | Had a clear take on hybrid architectures. Good product reasoning on UX paradigm shifts. Could have been more decisive — "I think" appeared often without full commitment to the position. |
| Conversational Fluency | 8/10 | Natural flow, good follow-up instincts. Admitted gaps honestly rather than bluffing (ring attention). Used terminology correctly. |

**Total: 73/100**

📊 Track Update — AI Foundations Conversational Readiness:
  vocabulary_fluency:   40 → 47 (+7)
  conceptual_depth:     35 → 43 (+8)
  current_awareness:    33 → 37 (+4)
  opinion_formation:    35 → 42 (+7)

  Overall CR: 35 → 42

🎯 Key Takeaways:
1. **Biggest strength:** Product-architecture connections. You naturally
   bridged technical concepts to business implications — that's rare and
   valuable.

2. **Biggest gap:** Current awareness. You knew the major concepts but
   couldn't reference recent papers or developments. Someone at a frontier
   lab would expect you to know what happened this quarter, not just
   this year.

3. **Recommendation:** Spend 20 minutes reading the latest AI research
   digests before your next session. Add relevant papers to the knowledge
   queue. We'll retest in 2 weeks.

4. **Opinion strength:** You hedged less than last time (progress!), but
   there's still room to be more decisive. Instead of "I think we'll
   probably see hybrid architectures," try "Hybrid architectures are the
   likely near-term path, and here's what would change my mind..."
```

---

## How Scoring Works

The Expert Test rubric (from `expert-personas.md`):

| Dimension | Max | What It Tests |
|-----------|-----|---------------|
| Accuracy | 20 | Are statements factually correct? |
| Depth | 25 | Can you go beyond surface-level? |
| Current Awareness | 25 | Do you know recent work? |
| Opinion Formation | 20 | Do you have a defensible take? |
| Conversational Fluency | 10 | Does it feel like a peer conversation? |

**CR update weight:** Expert tests use 60% old + 40% new (vs. regular sessions: 80% old + 20% new). This is because expert tests are higher-signal — they're a more authentic test of conversational readiness than standard coaching exercises.

---

## File Updates After the Test

### learning/tracks/ai-foundations/track.json
```json
{
  "conversational_readiness": {
    "overall": 42,
    "dimensions": {
      "vocabulary_fluency": { "score": 47, "trend": "up", "last_tested": "2025-03-15" },
      "conceptual_depth": { "score": 43, "trend": "up", "last_tested": "2025-03-15" },
      "current_awareness": { "score": 37, "trend": "up", "last_tested": "2025-03-15" },
      "opinion_formation": { "score": 42, "trend": "up", "last_tested": "2025-03-15" }
    },
    "expert_test_history": [
      {
        "date": "2025-03-15",
        "persona": "vp-research-deepmind",
        "total_score": 73,
        "dimensions": {
          "accuracy": 16,
          "depth": 19,
          "current_awareness": 14,
          "opinion_formation": 16,
          "conversational_fluency": 8
        },
        "notes": "Strong product-architecture connections. Current awareness is the main gap."
      }
    ]
  }
}
```

### learning/tracks/ai-foundations/history.jsonl
```json
{"date": "2025-03-15", "type": "expert-test", "persona": "vp-research-deepmind", "quality": 4, "total_score": 73, "mastery_delta": 0, "cr_delta": 7, "notes": "Current awareness gap. Strong on product implications."}
```
