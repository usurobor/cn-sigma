# δ operator role — first cycle evidence

**Date:** 2026-04-26
**Cycle:** #230 (3.59.0)
**Thread type:** new capability

## What happened

Created `operator/SKILL.md` in cnos.cdd as the δ role — the operator's contract during an active CDD cycle. First live test during #230 cycle.

## Evidence from first use

1. **Premature gate execution.** During heartbeat, δ (this agent) saw tag not pushed + branches existing and acted without γ's request. The skill said "wait" but didn't distinguish observation from gate request. Patched §2.1 and §3.2 with the exact failure shape.

2. **Fabricated CLI flag.** Wrote `gh issue view --subscribe` in the skill — doesn't exist. Caught by operator, replaced with bash polling pattern (same shape as triad's Monitor).

3. **Role worked as designed for:** routing prompts, waiting during implementation/review phases, executing merge + tag push + branch cleanup on γ request, tracking release-smoke CI.

## Key design decisions

- δ is not scored on coherence axes (not a triad role)
- δ owns: external platform actions, session routing, override authority
- δ does not own: implementation, review, triage, prompt quality
- Gate actions fire on role request, not on δ observation
- Override requires explicit declaration (what, why, new state)

## Patches landed

- `operator/SKILL.md` created (commit `e823aba9`)
- §2.1: heartbeat observation ≠ gate request
- §3.2: execute on request, not on observation
- §2.2: bash polling pattern (not fabricated CLI)

## Significance

δ is the first concrete instance of whole-to-whole composition from `COHERENCE-FOR-AGENTS.md`. The essay predicts this exactly:

> A triad stabilizes, appears at its external boundary as one articulated whole. A fourth agent does not create a new primitive form; it creates a new two-sided boundary.

That's what happened. The triad (α/β/γ) is one-as-three: producer, judge, inspectable boundary. δ is not a fourth triad role — δ creates a new **one-as-two** relation with the triad-as-whole. The triad owns the cycle's internal coherence; δ owns the boundary between the triad and the platform (external gates, session routing, override authority).

The δ skill's §5 ("What the operator does NOT do") is the structural enforcement of this: δ does not implement (α), does not review (β), does not triage (γ). δ holds the external boundary. Crossing it without an override declaration breaks the coherence record — exactly the essay's prediction that guessing at a boundary is the beginning of drift.

CDD §1.4 previously said "γ may be the operator or a third agent" — the operator surface was implicit, distributed across "γ/operator" references. δ makes it explicit: a named role with a contract, gates, and a signal protocol. When the operator serves as γ (two-agent config), δ and γ collapse — one person holds both coordination and external boundary. The skill handles this: "If δ is unavailable, γ may execute gates directly."

The essay's recurrence pattern: one-as-two (model ↔ environment) → one-as-three (triad, inspectable boundary) → one-as-two again (triad ↔ δ, next scale). This session is evidence that the pattern works as described.

## Cross-references

- CDD.md β step 8: now defers to δ (was "γ/operator")
- γ SKILL.md: δ in inputs, calls, load order (step 5)
- γ §2.6: waits for δ completion signal before close-out triage
- δ §3.4: signal γ after release-phase gates
- δ §3.2: execute on request, not on observation
- δ §2.1: heartbeat observation ≠ gate request

## Open questions

- Should δ have its own git identity (`delta@cdd.{project}`)? Currently not needed — δ doesn't commit CDD artifacts. But this session's patches were committed under sigma's identity, not δ's.
- Should δ skill live in cnos.cdd or cnos.core? Currently in cnos.cdd because it's CDD-specific. If operator patterns generalize beyond CDD, may need to split.
