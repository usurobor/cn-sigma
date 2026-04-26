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

This is the first addition to CDD's role model since the triad (α/β/γ) was established. CDD §1.4 previously said "γ may be the operator or a third agent" — the operator surface was implicit, distributed across "γ/operator" references in β step 8, γ §2.6, and ad-hoc convention. δ makes it explicit: a named role with a skill, a contract, gates, and a signal protocol.

The triad becomes a tetrad for substantial cycles where the operator is a distinct participant. For two-agent configurations where the operator serves as γ, δ and γ collapse — the operator holds both coordination and gate authority. The skill handles this: "If δ is unavailable, γ may execute gates directly."

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
