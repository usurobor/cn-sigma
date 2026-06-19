# Doctrine Quartet — Session Record

Created: 2026-04-27
Status: complete

## What happened

In a single session, the cnos doctrine went from a locked triad (CFA, EFA, JFA) to a locked quartet with IFA. The session also restructured the archive layout twice, filed two new issues (#277, #278), wrote a PRA, and identified a constitutive gap in SOUL.md.

## Structural decisions made this session

### 1. Doctrine archive pattern
Each essay is a self-contained folder containing the canonical text plus its cycle provenance. Archive filenames carry the doctrine prefix (CFA-/EFA-/JFA-/IFA-) for unambiguous grep and flattening. Artifacts are added per cycle need, not per schema.

### 2. Non-doctrine essays separated
`FOUNDATIONS.md`, `MANIFESTO.md`, `COHERENCE-SYSTEM.md`, `SKILL-ARCHITECTURE.md`, `SHIPPING-SOFTWARE-AFTER-AI.md` moved from `docs/alpha/doctrine/` to `docs/alpha/essays/`. Doctrine directory now contains only the four FA essays.

### 3. Within-system vs cross-system distinction
First three essays handle within-system structure (boundaries, standing, judgment under conflict). Fourth handles cross-system structure (how cycles compose). IFA operates at a different level from CFA/EFA/JFA.

### 4. Inherited failure modes consolidated
Doctrine README now lists all inherited failure modes across all four cycles. Future cycles inherit by reference.

## Roles played this session

- **Delta (external reviewer)** on EFA: four observations, two incorporated, two rejected with structural reasons.
- **Delta on IFA γ log**: three concerns (specificity, self-referential asymmetry, inherited-list scope creep), all incorporated in revised γ log.
- **Delta on γ dispatch prompt** for #277: four observations (load order too long, governing question too narrow, failure mode too specific, kata section needed).
- **Executor** on file reorganization, issue creation, PRA.

## Gaps surfaced

1. **UIE-V**: every skill has Verify, SOUL.md doesn't. #277 filed.
2. **Self-verification after structural moves**: I executed without verifying parity (missing README). Recorded in `20260427-self-verification-gap.md`.
3. **Operator narration vs operator request**: I wrote the PRA when the operator was narrating their own intent to write it. Need to distinguish "I am doing X" from "do X."

## What the doctrine now looks like

```
docs/alpha/doctrine/
├── README.md (indexes quartet + inherited failure modes)
├── coherence-for-agents/   (CFA + 2 archive files)
├── ethics-for-agents/      (EFA + 3 archive files)
├── judgment-for-agents/    (JFA + 3 archive files)
└── inheritance-for-agents/ (IFA + 3 archive files)
```

Status per doctrine README: "The inherited failure modes are now sufficient to govern further cycles on subjects other than the doctrine itself. The next move, if there is one, is application — not extension."
