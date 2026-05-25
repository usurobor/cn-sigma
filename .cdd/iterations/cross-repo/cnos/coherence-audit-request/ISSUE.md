# External coherence audit of cdd / cds / cdr (audit charter)

Labels: `tracking`, `P2`, `core`

Priority: P2 — Assessment of the v3.82.0 protocol-package baseline before the field-application phase. Pause-aligned (measurement of what's built, not theory expansion). Gates any future cell-design refactor talk.

Status: cnos shipped the CCNF package architecture at v3.82.0 (cdd = kernel; cds = software realization; cdr = research realization; handoff = transport). No independent coherence audit of these packages has been run. This charter requests one. It is a **request/terms-of-reference**, not the audit itself.

---

## Governing question

> Do cdd, cds, and cdr cohere — internally (each package), relationally (kernel ↔ realizations, no leakage), and as an evolving system — when read by an actor with no stake in authoring them?

---

## Why an external audit, why now

1. **Baseline cut.** v3.82.0 froze the CCNF package architecture. A baseline is the natural point to take an independent coherence reading before building on it.
2. **The cell model demands it at this scope.** `CELL-OF-CELLS.md §6` seats V (validation) and δ (boundary decision) at the cell wall; §5 makes α≠β structural ("a cell whose producer reviews its own matter is immunologically compromised"). The protocol packages are themselves a cell; auditing them is the V/β function applied at architecture scope; the α≠β firebreak requires the auditor be **external to the authoring loop**.
3. **Sigma is excluded as auditor.** Sigma (across recent sessions and bodies) is deep in the authoring/staging loop for cdd/cds/cdr-adjacent work (cnos#379, #403/#404 waves, #413 activation, #422 release, the agent-gh-deployment tracker). An audit by Sigma would be producer-reviews-own-matter. Sigma stages this charter; Sigma does not run the audit.
4. **Pause-aligned.** The v3.82.0 pause directs "collect field evidence before expanding." An external coherence audit IS evidence about the architecture — assessment, not expansion. It does not lift the pause.

---

## Audit subject

In scope:
- `cnos.cdd` — the CCNF kernel (CDD.md, COHERENCE-CELL.md, COHERENCE-CELL-NORMAL-FORM.md, RECEIPT-VALIDATION.md, role skills, `cdd-verify`, `schemas/cdd/`)
- `cnos.cds` — software realization (CDS.md, lifecycle/selection skills, `schemas/cds/`)
- `cnos.cdr` — research realization (CDR.md, role overlays, `schemas/cdr/`)

Adjacent (auditor may consider for relation-coherence, not primary subject):
- `cnos.handoff` — consumed by all three; relevant to β_TSC (relation) but not itself under audit per the operator's named scope (cdd/cds/cdr).

---

## Coherence dimensions (TSC axes as the audit frame)

Per `usurobor/tsc` triadic axes, applied at the protocol-package scope:

### α_TSC — Pattern coherence (internal structure)
Does each package have stable, internally-consistent structure?
- Do the six-field instantiation contracts (per `ROLES.md §3`) hold consistently in CDS and CDR?
- Do the CCNF equations in CDD.md hold without internal contradiction?
- Are the schemas (`schemas/{cdd,cds,cdr}/`) internally consistent with the doctrine they type?
- Do role skills add role-local detail without restating canonical rules (the design-skill §4.4 authority rule)?

### β_TSC — Relation coherence (cross-package fit)
Do the three packages fit together without leakage?
- Does the kernel/realization split hold? Does CDD.md name any realization detail (GitHub, CI, software/research specifics) it shouldn't (CCNF essay design principle #2: substrate-independent kernel)?
- Do CDS and CDR cite the kernel by reference without re-deriving it?
- Do cross-references resolve? (The 5/22 evolution scan + 5/22 CDS-README-drift adhocs found stale pointers; the #422 release patched some — are there residuals?)
- Is the loss-function distinction (CDS: artifact-improvement-under-repairable-feedback; CDR: truth-preservation-under-uncertainty) cleanly maintained, or does one leak into the other?

### γ_TSC — Process coherence (evolvability)
Can the system evolve coherently?
- Is the b-lite extraction pattern sound, or did any package ship pure-pointer-only (defeats extraction) or pure-full-rewrite (over-scoped)? (The 5/22 evolution scan flagged this as a check-needed item: inspect cds/cdr per-role skills for pure-pointer-only smell.)
- Does the five-layer enforcement chain (persona/operator/protocol/project/receipt) hold without layer conflation?
- Do the receipt schemas + V actually validate the trust surfaces they claim to, including counterfeit fixtures?

---

## Oracle (what the auditor produces)

A coherence audit report containing:
1. **Per-package verdict** (α_TSC / β_TSC / γ_TSC) for cdd, cds, cdr — intuition-level letter grades (A+ to F per the CLP self-check the CHANGELOG ledger already uses) since mechanical TSC isn't wired (DECREASING-INCOHERENCE Wave 1, paused).
2. **Cross-package relation verdict** — do the three remain one coherent system?
3. **Named incoherences (findings)** with severity per `review/SKILL.md §3.2` scale: D (blocker-class), C (significant), B (improvement), A (polish), info.
4. **Recommendation** — is the baseline coherent enough to field-test on, or are there D/C findings that warrant a fix cycle before field application?

The auditor does NOT propose refactors beyond naming the incoherence (per the design skill: name the incoherence; the fix is a separate cycle). Findings are evidence; remediation cycles dispatch separately under operator authorization (pause-gated).

---

## Auditor independence requirement

The auditor MUST be external to the cdd/cds/cdr authoring loop:
- **Excluded:** Sigma (deep authoring stake). Any actor that authored or staged the #402/#403/#404/#413/#422 work or the agent-gh-deployment tracker.
- **Candidates (operator chooses):**
  - A fresh model instance (Claude/Codex/other) with no session history on these packages — reads cold, audits cold.
  - A human reviewer.
  - The TSC mechanical framework (`usurobor/tsc`) run against the packages — *when* Wave 1 (TSC report attachment) wires it; not available today.
- The independence requirement is the α≠β firebreak applied at architecture scope. An audit by an authoring-stake actor is degraded evidence and must be marked as such if used.

---

## Non-goals

- Not a refactor. The auditor names incoherences; it does not restructure cdd/cds/cdr.
- Not a TSC-steering implementation. Uses TSC axes as the audit *frame* (intuition-level grades); does not build the mechanical TSC pipeline (paused).
- Not an audit of handoff, core, eng, or kata (scope is cdd/cds/cdr per operator; handoff is adjacent-relation only).
- Does not lift the v3.82.0 pause. Findings inform future cycles; they do not dispatch them.
- Not run by Sigma (independence requirement).

---

## Pause posture

This charter is authored under the v3.82.0 pause. An external coherence audit is assessment of the shipped baseline — the "collect field evidence" direction the pause names. Running the audit is pause-aligned. Any remediation cycle the audit's findings motivate dispatches separately under explicit operator authorization.

## Deliverable location

The audit report should land at a cnos path the auditor + operator agree (e.g. `cnos:docs/gamma/audits/2026-Q2-cdd-cds-cdr-coherence.md` or equivalent). The findings, if actionable, feed `cdd-iteration.md` / ε as protocol-gap candidates per the receipt-stream convention.

## Success / closure condition

This charter closes when an external auditor produces the report (per the Oracle), and the operator records a disposition: baseline is field-ready, or named D/C findings warrant a pre-field-application fix cycle.
