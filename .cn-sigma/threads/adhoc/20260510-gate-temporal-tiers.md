# Gate temporal tiers — observations from #339/#338 landing

Date: 2026-05-10

## Context

Cycles #339 and #338 landed the mechanical pre-merge closure gate + §3.8 rubric amendment. Fix `e136e4c6` resolved circular dependency by splitting gate requirements into pre-merge (α-closeout, β-closeout) and release (full set including γ-closeout).

## Open observation: α-closeout timing ambiguity

§5.3b says alpha-closeout.md is "After β merge, via δ re-dispatch." The pre-merge gate requires it before merge. Both #339 and #338 α agents used the §1.4 step 10 provisional fallback path (commits `209a4880`, `e20cffe3`, both marked `[provisional]`).

The gate implicitly enforces the provisional path as the pre-merge minimum. A one-liner in gamma/SKILL.md §2.10 or release/SKILL.md should clarify: "pre-merge gate accepts provisional α-closeout per §1.4 step 10; full α-closeout via δ re-dispatch remains the normative path for tagged releases."

**Disposition:** Record as finding in next cycle's cdd-iteration.md. Not urgent — both agents converged on the correct behavior without the clarification.

## Confirmed: §3.8 amendment landed

AC2 of #339 (rubric closure-gate-failure override + C−/<C letter normalization) shipped in commit `0b56ff86` on main. Not deferred.

## Cycle summary

| Cycle | Issue | Merge | γ closure | Gate | Grades |
|-------|-------|-------|-----------|------|--------|
| #339 | Closed | `544a0843` | `cfd322e6` | EXIT 0 (recursive) | α A−, β A−, γ A− |
| #338 | Closed | `bc9eac7d` | `eec33bd4` | δ merged on β's behalf (circular dep) | α A, β A, γ A− |
| fix  | — | `e136e4c6` | — | Temporal tier split | — |
