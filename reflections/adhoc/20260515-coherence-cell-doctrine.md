# COHERENCE-CELL.md: CDD Refactor Doctrine

**Date:** 2026-05-15
**Trigger:** Cycle #364 landed COHERENCE-CELL.md as draft refactor doctrine for CDD

## What it is

A structural prediction document for how CDD should evolve. Not a replacement for CDD.md — explicitly deferred, with CDD.md as canonical for current behavior. The core thesis: CDD is a recursive coherence-cell protocol where validity (not role seniority) makes a closed cell transmissible to the next scope.

## Key structural predictions

1. **Four-surface separation:** roles / runtime substrate / validation / release effection are separate surfaces. Fusing them (as current operator/SKILL.md and gamma/SKILL.md do) is surface smearing.
2. **Typed receipts:** A closed cell emits a receipt. The receipt (not the underlying artifacts) is what crosses scopes. V(contract, receipt, evidence) = PASS is the trust predicate.
3. **V as predicate, not role:** Validation is a typed capability δ invokes, not a sixth Greek role. Deliberately underspecified — may need to become ζ later if longitudinal state is required.
4. **ε as evolution, not metabolism:** ε observes receipt streams across cells, not within cells. `protocol_gap_count` in every receipt collapses the "force iteration artifact every cycle" problem.
5. **Managerial-residue sweep:** "monitor/supervise/oversee/manage" in role doctrine without naming the produced artifact = residue. Rename to biological function (observe, discriminate, route, validate, close, transport, release, repair-dispatch).

## What I think

### Strong
- Four-surface separation is the most actionable prediction. operator/SKILL.md today is exactly the fused surface it describes.
- ε artifact rule is elegant — every receipt carries `protocol_gap_count`, separate iteration artifact only when > 0.
- Managerial-residue sweep is a real pattern visible in current γ/δ skills.
- "Validity, not seniority" is the right reframe of how trust works in CDD.

### Uncertain
- **Recursion is untested.** "Receipts become matter at parent scope" is a sound equation but nothing consumes receipts as typed inputs yet. Prediction, not proven property.
- **V's position is a deliberate hedge.** Five open questions are all load-bearing. The doctrine makes predictions that depend on answers it defers.
- **Landing order is 6 steps, each sequential.** Multi-month pipeline. Risk: doctrine drifts from executable protocol while waiting for implementation.

### Watch for
- Doctrine-to-implementation gap staying open too long → two divergent surfaces
- `receipt.cue` is the first real test — that's where structural predictions hit concrete types
- The "does not replace CDD.md" caveat is the right guard but needs active enforcement as cycles land

## Relationship to current work

This landed as a docs-only cycle (#364), no code change. The next MCA per landing order: design `schemas/receipt.cue` + `schemas/contract.cue`. That's where the doctrine becomes load-bearing.

CDD itself continues to run on CDD.md. The cell model is the proposal surface for what CDD becomes, not what it is today.
