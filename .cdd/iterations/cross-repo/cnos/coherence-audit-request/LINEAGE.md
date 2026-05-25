# Cross-Repo Lineage: cn-sigma → cnos (coherence-audit-request)

Case (a) operator-directed cross-repo proposal. cn-sigma operator requested an external coherence audit of cdd/cds/cdr; cn-sigma Sigma drafted the audit charter (terms of reference). The audit itself is run by an actor external to the authoring loop — NOT Sigma.

## Source

- **Repo:** `usurobor/cn-sigma`
- **Branch:** `main`
- **Authoring commit:** filled at filing
- **Path:** `.cdd/iterations/cross-repo/cnos/coherence-audit-request/`
- **Source posture:** fifth cross-repo bundle from cn-sigma. A charter/request, not an implementation proposal.

## Upstream — operator directive

Operator (usurobor / Axiom), 2026-05-24: "We should also request an external audit of our cdd, cds, cdr for coherence."

Followed the architecture judgment that cell design needs no CDD refactor (`cn-sigma:threads/adhoc/20260524-cell-design-no-refactor.md`). The audit is the right first check before any refactor talk: an independent coherence read on whether the v3.82.0 baseline holds together. Order: audit → field-test → (if evidence warrants) refactor.

## The critical constraint — Sigma is not the auditor

The cell model (`CELL-OF-CELLS.md §5`) makes α≠β structural. The protocol packages are a cell; auditing them is the β/V function at architecture scope; the auditor must be external to the authoring loop. Sigma has deep authoring stake (cnos#379, #403/#404 waves, #413, #422, the agent-gh-deployment tracker). **Sigma stages the charter; Sigma does not run the audit.** An audit by Sigma would be producer-reviews-own-matter — degraded evidence.

This is the first cross-repo bundle where Sigma explicitly excludes itself from executing the work it stages — and that exclusion is the point, not a limitation.

## Target

- **Repo:** `usurobor/cnos` (audit subject + report destination)
- **Auditor:** external actor, operator-routed — fresh model instance / human / TSC mechanical (when Wave 1 wires it). NOT Sigma.
- **Kind:** tracking / charter
- **Title (proposed):** "External coherence audit of cdd / cds / cdr (audit charter)"
- **Labels (proposed):** `tracking`, `P2`, `core`
- **Disposition:** pending

## Audit frame

TSC axes at protocol-package scope:
- α_TSC pattern — internal structural consistency per package
- β_TSC relation — kernel/realization fit, no leakage, cross-refs resolve, loss-functions don't bleed
- γ_TSC process — b-lite soundness, five-layer chain integrity, schema+V validation

Oracle: per-package + cross-package coherence verdict (intuition-level CLP letter grades, since mechanical TSC is paused) + named findings (D/C/B/A/info per review/SKILL.md §3.2) + field-ready/fix-first recommendation.

## Pause posture

Pause-aligned: an external coherence audit is assessment of the shipped baseline (the "collect field evidence" direction the pause names), not theory expansion. Running the audit does not lift the pause. Any remediation cycle the findings motivate dispatches separately under explicit operator authorization.

## Notes for the operator / routing body

- This is a charter/request, not the audit. The deliverable is the audit report, produced by an external auditor.
- **Route to a non-authoring actor.** A fresh Claude/Codex session with no history on these packages is the most available external auditor today; a human reviewer or TSC-mechanical (post-Wave-1) are alternatives.
- The audit subject is cdd/cds/cdr per the operator's named scope; handoff is adjacent-relation only.
- Findings feed `cdd-iteration.md` / ε as protocol-gap candidates if actionable.
- Companion: `cn-sigma:threads/adhoc/20260524-cell-design-no-refactor.md` — the architecture judgment this audit precedes (audit → field-test → refactor-only-if-evidence).
