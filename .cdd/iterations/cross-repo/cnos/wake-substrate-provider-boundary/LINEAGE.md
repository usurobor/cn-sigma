# Cross-Repo Lineage: cn-sigma → cnos (wake-substrate-provider-boundary)

## Source

- **Repo:** `usurobor/cn-sigma`
- **Branch:** `claude/cn-sigma-activation-gwxlt3` (this session's designated branch). NOTE: prior cross-repo bundles were carried on cn-sigma `main` per operator preference; this one lands on the session branch per the session git directive. Operator merges to `main` if the standing convention should hold — that is a δ gate, not κ's to take.
- **Path:** `.cdd/iterations/cross-repo/cnos/wake-substrate-provider-boundary/`
- **Filing kind:** wave master (execution decomposition beneath an existing issue), not a cell-scope proposal.
- **Source posture:** κ (Sigma at cn-sigma) authored this bundle. κ carries operator intent into a typed executable artifact (issue pack) — authorized. κ does **not** file at cnos or dispatch worker cells; that is γ-at-cnos + δ external gate. _(Historical: at authoring time cnos was out of session scope, which prevented filing from here. The operator then directed filing and authorized adding cnos to the session — see `## Filed`. κ still holds the dispatch/close gates; filing was the operator-directed external action.)_

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
- **Disposition:** ~~pending (filed by cnos γ on next wake, after Sub 0)~~ — **FILED 2026-07-05** as #596 (master) + #597 (Sub 0); see `## Filed` below. Pre-filing text retained as historical only.
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

## Filed (2026-07-05, operator-directed)

Operator directed κ to file real GH issues (not just the bundle). Added `usurobor/cnos` to the session (operator-authorized via AskUserQuestion) and filed at cnos:

| GH issue | Role |
|---|---|
| **#596** | wave master tracker (umbrella over #452/#453 + Sub 0/0.25) |
| **#597** | Sub 0 — status-truth reconciliation (the one genuinely-new cell) |
| **#598** | Sub 0.25 — human quickstart oracle (user-first re-center, 2026-07-05); mock at `sub0_25-human-quickstart/QUICKSTART.md` |
| #452 | linked as native sub-issue — execution cell A (contract + claude-code) |
| #453 | linked as native sub-issue — execution cell B (executor + NIM canary) |

**Wave re-ordering (operator, 2026-07-05, user-first):** Sub 0 (#597) → Sub 0.25 (#598 human quickstart, the design oracle) → Sub 0.5 (impl mock/golden pack derived from the quickstart; files next per §1) → Sub 1 (#452 contract + Claude continuity) → Sub 2 (#453 executor + canary). The human guide is the optimization target; every schema/fixture/workflow-diff/report is justified only by whether it makes the guide true. #452 held until the quickstart exists; #453 hermetic-only until the quickstart defines safe canary/refusal/fallback/rollback.

Reconciliation on filing: live #452 was already scope-corrected (2026-06-16) into contract + claude-code + openai-compat stub; #453 already owns the functional executor + canary. Wave Sub 1/2 → #452, Sub 3/4 → #453 — not re-filed (would duplicate). This is exactly Sub 0's own finding, applied at filing time.

Labels (corrected 2026-07-05 per β F1): #596 = `P1`, `area/agent`, `area/wake`, `area/runtime`, `tracking`; #597 = `P1`, `area/agent`, `area/wake`, `kind/process`. **Correction to an earlier claim:** `area/cds` and `kind/process` *do* exist in cnos's label set (live #579 carries both) — they were simply *not applied* to these issues, not absent. `protocol:cds` was not used/verified. `kind/docs` does not exist; `kind/process` is the accepted process/docs-equivalent kind label used for the Sub 0 reconciliation cell.

## Boundary note (κ)

This bundle is the artifact; it is not a dispatch. Filing at cnos, assigning a cycle number, and claiming α/β/γ cells are γ-at-cnos + δ moves. Under the session's κ pin, κ stops at "executable contract recorded + handed off." The STATUS ledger tracks the handoff (`submitted` when γ-at-cnos files).
