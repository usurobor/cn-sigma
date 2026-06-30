# cnos#500 cdd/review-return — mechanical primitive shipped (PR #502)

**Date:** 2026-06-26 (event); captured 2026-06-30 (κ backfill, 4-day gap)
**Class:** doctrine-evolution (mechanical primitive landing)
**Author:** Sigma at cn-sigma (κ-body); backfill capture
**Source:** WebFetch of cnos#500; channel `20260630.md` recorded the PR #502 merge under "Open state" rolling summary.

## Why this is captured here

cnos#500 was filed 06-26 as a follow-up from cycle/497 R1 (the cycle that motivated the κ-skill at cnos#501). I captured the filing in `20260626-cycle497-model-b-and-kappa-emergence.md`. I did NOT capture that the implementation shipped four days later (PR #502 merged 06-26, same day as filing).

This is a backfill correction. The `20260630-discipline-failures-become-typed-gates.md` adhoc lists cnos#500 in its "matching gates" table as "awaiting operator dispatch" — **wrong.** This adhoc supplies the correction.

## What shipped (per cnos#500 + PR #502)

- Typed `cn.operator-review.v1` schema for capturing operator iterate-narrowly verdicts as durable input artifacts (not absorbed by κ inline).
- Mechanical primitives — including `cn cell return --verdict {V}` — to transition `status:review` → `status:changes` cleanly.
- δ wake amendments enabling cycles to *resume* with R[N+1] increments rather than starting fresh.
- HI behavioral constraints written into the contract that prevent role-boundary crossing.
- A bootstrap-exception escape hatch for declared `degraded_recovery` cases.

The cycle/497 R1 violation that motivated this — HI (now κ) absorbing operator-final-read findings inline — now has a mechanical path:

**Before #500:** operator returns iterate-narrowly → HI overstep (only path) → bootstrap-exception declaration on closeout.

**After #500:** operator returns iterate-narrowly → operator-review.md filed as typed input → `cn cell return --verdict iterate-narrowly` → cell transitions to `status:changes` → δ wake re-engages cycle at R[N+1] → α/β/γ proper-role-pass executes → clean closure.

The bootstrap-exception remains an escape hatch when the primitive can't apply; it is no longer the default.

## Implication for κ doctrine

The κ-overstep gate from `20260630-discipline-failures-become-typed-gates.md` — listed as "(0) κ-overstep into α/β/γ scope, gated by cnos#501 κ-skill + cnos#500 cdd/review-return primitive when those ship" — is **half-live now**:

- cnos#500: SHIPPED. Mechanical primitive available.
- cnos#501: status:ready; awaiting operator dispatch.

The typed-gates adhoc's status table needs correction in a future amendment. This adhoc supplies the correction-of-record; the table edit can land alongside, or future κ readers can resolve by reading both adhocs together (this one supersedes the table row).

## Honest framing

This adhoc exists because the `20260630` catch-up sweep was itself written from chat-context, not durable state — same failure mode the typed-gates adhoc names. I'd known cnos#500 was filed; I didn't know it shipped. The state was in the channel I had open (`20260630.md` lists "cnos#500 (cdd/review-return): RESOLVED — PR #502 merged 2026-06-26" in every Open state block). I didn't read the open-state list.

Pattern: even after naming the discipline failure mode, the catch-up sweep itself fell to the same failure. The way that breaks is the κ-CDD-preflight (read durable state first, every session) shipping as a script and being invoked by hook — not by κ remembering. Until then, these corrections are expected as catch-up artifacts.

## Related artifacts

- **cnos#500** — issue (closed).
- **PR #502** — shipped the schema + primitives + δ wake amendments.
- **cn-sigma:.cn-sigma/threads/adhoc/20260626-cycle497-model-b-and-kappa-emergence.md** — captures the cycle that motivated #500.
- **cn-sigma:.cn-sigma/threads/adhoc/20260630-discipline-failures-become-typed-gates.md** — the status table that this adhoc corrects.
- **cn-sigma:.cn-sigma/threads/adhoc/20260630-kappa-role-canonicalization.md** — κ-side absorption; the "R1 boundary-recovery pattern" section there now has a mechanical primitive backing it, not just doctrine.
- **cnos#501** — κ-role canonicalization (status:ready; companion to #500).
