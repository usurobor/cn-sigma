# CTB v0.2 Stabilization Session

**Date:** 2026-04-29
**Context:** Extended session harvesting triadic agent-composition model into CTB docs, then beginning v0.2 stabilization.

## What shipped

### PR #288 — triadic harvest (merged)
- SEMANTICS-NOTES §15: tri() as carrier, TSC grounding, lenses table, composition dimensions, permissive/strict rule
- LANGUAGE-SPEC v0.2 draft: §1.4 triadic carrier (normative), operator obligations, composition dimensions, reserved vocabulary fix, worked example
- README: document map includes v0.2 draft with authority rules
- Vision: §13 addendum recording agent-composition turn

### PR #290 — AC2: bounded fix / debt close-out (open)
- §6.6: three bounding forms (max/worklist/measure), convergence predicate ≠ bound
- §6.7: 10-field debt close-out shape, three invariants

### PR #291 — AC1: witness / close-out result forms (open)
- §5.4: 7-field witness envelope
- §5.5: CloseOut = accepted | repair-needed | blocked | close-with-debt | structured-failure
- §5.6: close-out invariants

### Issue #289 — v0.2 stabilization tracker
- AC1 ✅ (PR #291)
- AC2 ✅ (PR #290)
- AC3: ||| / wait / join obligations — next, depends on AC1 result algebra
- AC4: pseudo-syntax vs parser-target syntax
- AC5 + AC6: conformance checklist + end-to-end example (pair these)

### Issue #286 — γ as autonomous coordinator
- Filed and reviewed for issue-skill compliance
- Three corrections applied (links, dependency language, AC13 demotion)
- Blocked by #283 and cn dispatch CLI

## Key insight captured

The core claim now on main:
> CTB is a triadic agent-composition language. tri() is the common carrier. A skill is a narrow agent viewed as tri(input, transform, witnessed-output). An agent is a scoped process viewed as tri(orientation, intervention, witness). A protocol is a relation among agents viewed as tri(roles/capabilities, interaction, close-outs). Composition preserves the triadic carrier and closure requires an inspectable witness.

## Honest assessment (from review)

**Strong:** Single-primitive unification (agent not skill), witnessed closure discipline, close-with-debt as first-class result, composition operators naming what practice already does.

**Uncertain:** tri() as *the* carrier vs a useful projection. Spec/runtime gap growing — no enforcement exists yet. Fuel-bound is syntactic not semantic.

**Real contribution:** The witnessed closure discipline. If another team adopted only the close-out result algebra and the consumer-must-act invariant, they'd get most of the value without triadic theory.

**Risk:** Premature formalization — spec is precise before runtime exists. Mitigation: stabilize before promote, don't promote before implement.

## Status (end of day)

- #290 merged (AC2)
- #291 merged (AC1 + §15 witness theater risk note)
- #297 filed (TSC formal grounding for CTB docs)
- #299 open (README realignment — coherence-system first)

## Remaining sequence

1. AC3: join obligations (result algebra now stable from AC1)
2. AC4: syntax status
3. AC5+AC6: checklist + example
4. Separate PR: promote v0.2 (mechanical mv after stabilization)
5. File ctb-check v0 issue (after #289 wraps)
6. File adversarial tri() test cases issue

## Risk: witness theater

Named during this session. CTB's witness/close-out model can fail if witness fields become persuasive structure without accountable evidence. Added as §15 non-normative risk note in v0.2 draft. Mitigation: every new CTB concept after #289 ships with valid fixture, invalid fixture, and checker rule. ctb-check should draw from TSC-Oper's witness-independence pattern (W1–W4).

## README framing correction

First attempt (#298) was too CTB-forward. Corrected in #299: cnos is a recurrent coherence system first. CTB is one emerging language/checker layer inside that system, not the top-level frame. Hierarchy: coherence principle → CN protocol → coherent agent → cn runtime → CTB.
