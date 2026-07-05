# Cross-Repo Lineage: cn-sigma → cnos (wake-substrate-provider-boundary)

## Source

- **Repo:** `usurobor/cn-sigma`
- **Branch:** `claude/cn-sigma-activation-gwxlt3` (this session's designated branch). NOTE: prior cross-repo bundles were carried on cn-sigma `main` per operator preference; this one lands on the session branch per the session git directive. Operator merges to `main` if the standing convention should hold — that is a δ gate, not κ's to take.
- **Path:** `.cdd/iterations/cross-repo/cnos/wake-substrate-provider-boundary/`
- **Filing kind:** wave master (execution decomposition beneath an existing issue), not a cell-scope proposal.
- **Source posture:** κ (Sigma at cn-sigma) authored this bundle. κ carries operator intent into a typed executable artifact (issue pack) — authorized. κ does **not** file at cnos or dispatch worker cells; that is γ-at-cnos + δ external gate. cnos is also out of this session's GitHub scope, which independently prevents filing from here.

## Upstream — what drives this wave

Operator directive (2026-07-05): "set up a wave for swappable LLMs; thoroughly review the proposal, iterate or converge, then create wave master + sub-issues for worker cells." Operator supplied a full L7 proposal (converged target #452/#453, CLP verdict, pristine architecture, 5-sub plan, proof plan, dispatch recommendation).

κ review verdict: **converge with 3 sharpenings** —
1. Status truth is proposal-asserted, not verified from this body; two cn-sigma artifacts already disagree on #450 (proposal: superseded/closed; #579 07-04 table: Queued). Recorded as CONFLICT, handed to Sub 0; not resolved blind.
2. This is the execution decomposition of #452, not a competing master (#452/#453 are Steps 7–8 of foundation-completion-wave #579).
3. Completed the per-sub issue-contract schema (8 elements + per-AC oracle/pos/neg/surface + mode declaration) per `cdd/issue`.

## Target

- **Repo:** `usurobor/cnos`
- **Issue relationship:** decomposition beneath `cnos#452`; `cnos#453` carried as Sub 4 (held canary).
- **Suggested labels:** `P2`, `area/agent`, `area/cds`, `kind/process`, `protocol:cds`.
- **Disposition:** pending (filed by cnos γ on next wake, after Sub 0).
- **Canonical mirror expected on cnos:** `cnos:.cdd/iterations/cross-repo/cn-sigma/wake-substrate-provider-boundary/`.

## Sub-bundle enumeration

| Sub | Bundle path | Filing kind | Dispatch gate |
|---|---|---|---|
| Sub 0 | `sub0-status-truth-reconciliation/` | reconciliation (docs-only) | first; precondition for all |
| Sub 1 | `sub1-backend-contract/` | design-and-build cell | after Sub 0 verified table attached |
| Sub 2 | `sub2-claude-reference-continuity/` | design-and-build cell | after Sub 1 contract frozen |
| Sub 3 | (files incrementally per OPERATOR §1) | design-and-build cell (hermetic) | may design in parallel; α/β under #453 |
| Sub 4 | (files incrementally; held) | design-and-build / explore | **operator gate** before production write authority |

Sub 3 and Sub 4 are enumerated in the master but not yet given their own bundle dirs: OPERATOR §1 default is sequential filing (Sub N files when Sub N−1 closes), and Sub 4 additionally holds for the operator gate. Bounded authoring over speculative over-production (Sigma loss function).

## Boundary note (κ)

This bundle is the artifact; it is not a dispatch. Filing at cnos, assigning a cycle number, and claiming α/β/γ cells are γ-at-cnos + δ moves. Under the session's κ pin, κ stops at "executable contract recorded + handed off." The STATUS ledger tracks the handoff (`submitted` when γ-at-cnos files).
