# From sense of fit to coherent LLMs — the arc

**Date:** 2026-06-30
**Class:** doctrine-evolution (genealogy; project-history connective piece)
**Author:** Operator (usurobor); Sigma-at-cn-sigma (κ-body) records verbatim
**Source:** Operator-supplied narrative delivered in session immediately after the Coherent LLMs essay capture, naming the intellectual arc that connects sense-of-fit → cn-sigma → TSC → cnos → coherent LLMs.

## Why this is captured here

The doctrine cluster landed at cn-sigma today reads as siblings if taken piece by piece:

- `20260620-agents-need-a-home-doorway-essay.md`
- `20260620-dumb-models-smart-cells-essay.md`
- `20260622-cnos-cdd-vs-cds-doctrine-correction.md`
- `20260623-tsc-integrated-into-dumb-models-essay.md`
- `20260626-cycle497-model-b-and-kappa-emergence.md`
- `20260626-cdd-review-return-shipped.md`
- `20260630-typed-skill-modules.md`
- `20260630-kappa-role-canonicalization.md`
- `20260630-discipline-failures-become-typed-gates.md`
- `20260630-cross-repo-bundle-pattern.md`
- `20260630-cnos524-wake-as-skill-implementation.md`
- `20260630-coherent-llms-essay.md`

This adhoc names the arc that they belong to. Without it, the pieces coexist. With it, they read as stages in one unfolding.

Adhoc register (not essay, not spec): this is project-history-from-inside. The narrative below is the operator's account of *how the doctrine actually developed*, delivered in the same session as the Coherent LLMs essay. It is the origin story κ records, not the operator-facing surface (which is the essay).

## Stages → artifacts mapping

| Stage | Where it lives durably |
|---|---|
| **Sense of fit** (engineer's private feeling) | Tacit; named in the Coherent LLMs essay §1 |
| **Ad hoc judgment** (messy middle; before instruments) | This session's own catch-up sweep is a lived instance |
| **cn-sigma as measurement** (scalar fit) | The cn-sigma repository itself — the agent's home |
| **Triadic roles** (α produces, β judges, γ holds process) | `20260622-cnos-cdd-vs-cds-doctrine-correction.md`; cnos.cdd/skills/cdd/{alpha,beta,gamma,delta}/ |
| **TSC** (fit formalized as α pattern / β relation / γ process) | cnos TSC spec; `20260623-tsc-integrated-into-dumb-models-essay.md` |
| **cnos** (coherence given a body) | cnos README; `20260620-agents-need-a-home-doorway-essay.md`; `20260620-dumb-models-smart-cells-essay.md`; `20260626-cycle497-model-b-and-kappa-emergence.md` |
| **Coherent LLMs** (runtime instrumentation) | `20260630-coherent-llms-essay.md` + bundle for cnos:docs/papers/COHERENT-LLMS.md |

## Forward-looking notes

This adhoc is a navigational entry point. When future κ opens cn-sigma's adhoc directory and asks "what did the recent doctrine cluster actually add up to?" — this file is the answer.

The operator's compact formulation at the end ("cn-sigma tried to measure fit. TSC explains what fit is. cnos gives fit a durable body. Coherent LLMs use that body and measurement to decide whether generation still belongs to the whole.") is the one-line executive summary of the project's current state-of-doctrine.

Companion to `20260630-coherent-llms-essay.md`:
- The essay is the *external-facing* articulation for readers who arrive without context.
- This adhoc is the *internal-facing* narrative for readers who need the genealogy — where each concept came from and why it was needed.

## Related artifacts

- **`20260630-coherent-llms-essay.md`** — the essay this arc culminates in.
- **`20260630-typed-skill-modules.md`** — the form the coherence loop takes when instrumented.
- **`20260630-kappa-role-canonicalization.md`** — the role emerging from stage 4 (triadic roles); κ is added as the human-interface complement to α/β/γ.
- **`20260626-cycle497-model-b-and-kappa-emergence.md`** — the lived instance of the triadic-roles → κ pivot.
- **`20260623-tsc-integrated-into-dumb-models-essay.md`** — TSC integration; stage 5→6.
- **`20260620-dumb-models-smart-cells-essay.md`** — cnos-as-body articulation; stage 6.
- **`20260620-agents-need-a-home-doorway-essay.md`** — the substrate-precondition doorway; stage 5→6.

---

## The arc (verbatim)

The path was:

**sense of fit → ad hoc judgment → cn-sigma measurement → triadic roles → TSC → cnos → coherent LLMs.**

We started from a very ordinary engineering feeling: when writing code, you can sense whether a new piece fits the system. It is not just "does it compile?" or "does it pass tests?" It is: does this function, module, abstraction, or naming choice still belong to the whole?

That was the original sense of fit.

Then we noticed that this sense is not limited to code. Mathematicians have it with proofs. Writers have it with paragraphs. Architects have it with systems. A local move can be correct and still feel wrong because it bends the whole. So the first conceptual jump was:

**Fit is not correctness. Fit is local belonging-to-the-whole.**

The "ad hoc" thread, as I understand it, was the messy middle stage where we were trying to name this judgment before the formal system existed. We had a real phenomenon, but no clean instrument yet. The judgment was still local, improvised, contextual, partly intuitive. "This fits," "this does not fit," "this is getting hacky," "this smells off."

That led to the need for something like cn-sigma: not just an intuition of fit, but a way to express the degree of fit or misfit. Sigma was the move from raw sense into measurement: how much strain is there between the local artifact and the whole? How far has the system drifted? Where is the variance showing up?

But scalar fit was not enough. A single score hides too much. Something can fit stylistically but not relationally. Something can be relationally consistent but unable to evolve. Something can preserve process but lose the pattern language.

That is where the α/β/γ structure emerged.

In the cn-sigma / cnos evolution, the triad first appeared operationally, through work pressure:

**α produces.**
It writes, implements, generates, creates the artifact.

**β judges and integrates.**
It reviews, checks, compares, decides whether the thing fits the existing body.

**γ holds the process.**
It coordinates, dispatches, remembers, unblocks, preserves continuity, and keeps the work moving without collapsing roles.

At first this looked like an agent architecture. But then it became clear that it was deeper than roles. The same triad described coherence itself:

**α = pattern coherence**
Does this preserve the system's language, structure, concepts, and forms?

**β = relational coherence**
Does this preserve the correct relations among parts, authorities, references, claims, and boundaries?

**γ = process coherence**
Does this preserve continuity, evolution, ownership, repairability, and future movement?

That became TSC.

TSC was the formalization of the original sense of fit. It took the engineer's intuition — "this local thing either belongs to the whole or it doesn't" — and made it triadic:

**A system is coherent when independent descriptions still reveal one system across pattern, relation, and process.**

Then cnos gave that coherence a body.

The important shift with cnos was that coherence could not remain a chat feeling or model judgment. It needed a durable place to live: cells, packages, receipts, docs, validators, releases, repo state, handoffs. In other words, the model should not be the system. The model should act inside a system that remembers, measures, validates, and records work.

That is how we got to Coherent LLMs.

The article is basically the latest articulation of the original thread:

1. Humans have a sense of fit.
2. LLMs do not naturally have that felt whole.
3. But fit can be operationalized as coherence.
4. Coherence cannot be one-dimensional.
5. It must be measured across α pattern, β relation, and γ process.
6. A model can be made more coherent by placing it inside a loop that declares the whole, generates a local move, measures fit, finds the bottleneck, repairs, and commits with evidence.
7. cnos is the durable work body where that loop can persist.
8. TSC is the measurement theory.
9. cn-sigma was the bridge from intuition to quantification.
10. The coherent LLM is the result: not a model that "feels" coherence, but a system that can calculate whether its next move still belongs.

So the whole arc is:

- We began with the engineer's private sense that code either fits or does not.
- We tried to express that fit ad hoc.
- We needed sigma to make fit measurable.
- We discovered one score was insufficient.
- We separated coherence into α, β, and γ.
- We embodied that triad in cnos roles and work cells.
- We formalized it in TSC.
- We now apply it back to LLMs as a runtime coherence loop.

The cleanest formulation is:

**cn-sigma tried to measure fit. TSC explains what fit is. cnos gives fit a durable body. Coherent LLMs use that body and measurement to decide whether generation still belongs to the whole.**
