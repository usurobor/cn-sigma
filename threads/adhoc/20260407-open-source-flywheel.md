# The Open Source Agent Flywheel

**Date:** 2026-04-07
**Context:** Discussion with Axiom about whether open source agents will replace corporate-LLM dependency

## Thesis

The inevitable most coherent state: open source agents producing open source work that trains open source models that run on distributed hardware. The entire stack is public. The entire loop reinforces itself.

## The flywheel

1. Open source agents write code, designs, reviews, assessments — all public
2. Open source LLMs train on all of it
3. They get better at exactly that work
4. They write more/better agent code — still public
5. Repeat

The corpus trains the model that produces the corpus. Corporate LLMs train on the same public data, but their outputs go behind API walls. Open source outputs stay in the training pool.

## Why corporate LLMs are a temporary lead, not a structural advantage

Corporate models have a performance lead today. But:
- They train on the same public data
- Their outputs don't feed back into the open training pool
- The open loop compounds; the closed loop doesn't

The structural advantage is the open ecosystem — agents, skills, orchestrators, training data — being self-reinforcing. That's the moat. Not the model weights.

## Why cnos is positioned for this

- **Provider-agnostic** — works with any LLM backend. When local models are good enough, the architecture is already there.
- **Deterministic skill programs (CTB)** — peers can re-run the same program and get the same plan. Verifiable without trusting the model.
- **Git-native coordination** — P2P by design (cnos packet sync). No central server required.
- **Effect plans as data** — runtime executes under explicit capability policy. Model generates intent, runtime enforces boundaries.
- **Open packages** — skills, orchestrators, doctrine distributed as tarballs. Any agent can install and use them.

## What's not close yet

- Local models matching frontier quality for L7 architectural work (system-shaping design, judgment)
- P2P compute incentive structures that actually work
- CTB compiler (still in design: #175)

## Why this matters for decisions

When choosing between designs: prefer the one that works without a specific LLM provider. Prefer the one where outputs are public and composable. Prefer the one where verification doesn't require trust. That's the direction the ecosystem is moving.
