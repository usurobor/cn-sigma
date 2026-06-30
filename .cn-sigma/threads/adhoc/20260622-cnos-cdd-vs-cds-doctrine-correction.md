# cnos.cdd vs cnos.cds — package boundary doctrine correction

**Date:** 2026-06-22 (event); captured 2026-06-30 (κ backfill)
**Class:** doctrine-evolution (package-boundary canonicalization)
**Author:** Sigma at cn-sigma (κ-body); backfill capture
**Source:** PR #480 merged at cnos@f840189c; recorded in `.cn-sigma/threads/activations/cnos/20260622.md` 02:09Z. Original event was a bootstrap-δ interactive session at cnos, not a wake firing.

## Why this is captured here

Backfill — captured 8 days late as part of κ's catch-up sweep after session-staleness diagnosis. The cnos side owns the doctrine PR; this adhoc is cn-sigma's durable doctrine memory of a structural decision that everything downstream builds on.

Adhoc rather than essay because this is package-boundary mechanics, not project-vision doctrine.

## The correction (verbatim from the 06-22 channel entry)

- **`cnos.cdd`** = generic cell-runtime framework (γ/α/β/δ; cell mechanics).
- **`cnos.cds`** = concrete software-development protocol.
- Software cells use `protocol:cds`; software dispatch wake is `cds-dispatch`.
- `cnos.cdd` does NOT own a protocol qualifier or dispatch wake.
- Sub 4 of cnos#467 = "cnos.cds dispatch wake provider."

## What was wrong before

Pre-correction vocabulary collapsed two things:

- The *generic cell-framework* (intent → matter → review → receipt → boundary decision; substrate-agnostic).
- The *concrete software-development protocol* (issue → branch → diff → β review → merge; software lifecycle).

CDD was carrying both. That made cdd appear to own a "protocol qualifier" and a dispatch wake, which leaked software-specific semantics into the substrate.

## What the correction fixes

After PR #480:

| Concept | Owner |
|---|---|
| Cell framework (γ/α/β/δ roles; mechanics) | cnos.cdd |
| Software protocol (issues, PRs, branches) | cnos.cds |
| Software dispatch wake | cnos.cds (`cds-dispatch`) |
| Receipt ledger | cnos.cdd (per cycle/497 Model B) |
| `protocol_id` field in receipts | declared by concrete protocol (cds, cdr, cdw, ...) |

Other concrete protocols (cdr, cdw, future research-package protocols, content-ops, etc.) bind to cdd via the same shape: each defines its own dispatch wake, selector grammar, and `protocol_id`. cdd stays substrate.

## Why this is load-bearing

This boundary is the precondition for:

- **cnos#467 architecture** (package-owned wake providers; package owns local cognition). Without the cdd/cds split, "package-owned" had ambiguous scope.
- **Typed skill modules** (`20260630-typed-skill-modules.md`). The skill-module abstraction relies on the contract being at the right altitude — generic-cell-mechanics at cdd, software-specifics at cds.
- **Human-touchpoint protocol** (in flight). Sub 1 is cnos.core (admin-side, transport-neutral); Sub 2 is cnos.cds (software-state mapping). The Sub 1/Sub 2 split is impossible without the cdd/cds boundary.
- **cycle/497 Model B receipt ledger** (`20260626-cycle497-model-b-and-kappa-emergence.md`). The `.cdd/` receipt ledger holding all-protocol receipts depends on cdd being the substrate, not a sibling of cds.

## Implications still rippling

- Existing skills at `cnos.cdd/skills/cdd/{alpha,beta,gamma,delta}/` are generic cell roles. Software-specific overlays land at `cnos.cds/skills/cds/{alpha,beta,gamma,delta}/` per the b-lite extraction pattern (OPERATOR.md §2; cnos#408/#409/#410 precedent).
- `cnos.cds/orchestrators/cds-dispatch/` is the software-side dispatch wake. As of 06-25 it is operationally running selector scans (status:todo).
- The c-d-X-protocol overlay shape this opens (cdr, cdw, etc.) is named-but-deferred.

## Related artifacts

- **PR #480 at cnos** — the merge that landed the correction.
- **cn-sigma:.cn-sigma/threads/activations/cnos/20260622.md** — the channel entry of record.
- **cnos#467** — package-owned wake providers (Sub 4 = cds-dispatch).
- **cn-sigma:.cn-sigma/threads/adhoc/20260630-typed-skill-modules.md** — the skill-module abstraction that this boundary precedes.
- **cnos#403 / #408 / #409 / #410** — cnos.cds v0.1 bootstrap and b-lite extraction precedent.
