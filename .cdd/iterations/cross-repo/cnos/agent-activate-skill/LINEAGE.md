# Cross-Repo Lineage: cn-sigma → cnos (agent-activate-skill)

## Source

- **Repo:** `usurobor/cn-sigma`
- **Branch:** `claude/review-context-EbgR2` (drafted in a Claude Code on the web session; merged to cn-sigma main 2026-05-19)
- **Authoring commit:** `8f153c15e` (bundle initial filing on the source branch; pre-AC4-refinement)
- **AC4-refinement commit:** `bdda457f5` (3-tier capability-matrix replaces single capability-gate AC4; folded into bundle 7 min after issue filing per `threads/adhoc/20260519-git-read-and-untested-limits.md`)
- **Post-merge main commit:** `1a4e25f75` (cn-sigma main HEAD carrying the full bundle + AC4 refinement; pinned in cnos#379 `## Source Proposal` block)
- **Path:** `.cdd/iterations/cross-repo/cnos/agent-activate-skill/`
- **Source posture:** cn-sigma is an agent hub, not a fully CDD-activated tenant repo. This bundle adopts the cross-repo trace convention (cnos `CDD.md §5.3`, `gamma/SKILL.md "Cross-repo proposal close-out"`) and the pattern established by `cph/bootstrap-cdr` (cnos commit `7a7f7152`, 2026-05-18). cnos #377 (open) tracks codification of the hub→CDD-repo case; this bundle is a concrete exemplar. Unlike `cph/bootstrap-cdr` (minimal anchor on source main; full bundle on dormant branch), this bundle is carried in full on cn-sigma main per operator preference.

## Target

- **Repo:** `usurobor/cnos`
- **Issue:** [#379](https://github.com/usurobor/cnos/issues/379) — agent/activate skill — single source of truth for agent self-activation
- **Mode:** `design-and-build` (per `ISSUE.md` mode declaration); single-focus, ~7 ACs, two tightly coupled modules (new skill + Go renderer)
- **Title:** "agent/activate skill — single source of truth for agent self-activation"
- **Labels:** `design`, `P2`, `core` (per `cdd/issue/labels/SKILL.md` minimum)
- **Disposition:** accepted (body filed verbatim from source `ISSUE.md` @ `8f153c15e`; `## Source Proposal` block inserted at canonical position per `cdd/issue/SKILL.md`; AC4 capability-matrix refinement folded into issue body post-filing at `2026-05-19T10:21:01Z` — see Delta below)
- **Canonical path on cnos main:** `cnos:.cdd/iterations/cross-repo/cn-sigma/agent-activate-skill/` @ cnos commit `212d5239` on branch `sigma/cross-repo-mirror-agent-activate-skill` (pending operator merge to cnos main)

## Delta

cnos#379 was filed at `2026-05-19T02:38:33Z` from bundle SHA `8f153c15e` (pre-refinement AC4: "capability gate", single fetch path). The AC4 refinement landed on the source branch at `bdda457f5` (`2026-05-19T02:45:45Z`, 7 min after filing) per `threads/adhoc/20260519-git-read-and-untested-limits.md`. Issue body was reconciled at `2026-05-19T10:21:01Z` to fold in the post-refinement AC4 (3-tier capability-matrix: shell+git / WebFetch / no-fetch). cnos#379 `## Source Proposal` block now pins `1a4e25f75` (post-merge cn-sigma main) as Source commit, with `8f153c15e` retained as Filing-time source commit.

## Why a bundle, not just an issue

Per `cnos CDD.md §5.3` cross-repo trace row: findings whose patch lands in a different repo than the source cycle hold bundle deliverables (issue body, lineage, status) at the originating repo until the target PR merges. Without a bundle, the proposal's authoring context (this conversation, this branch, the design decisions captured) is unrecoverable once the target issue is filed.

The `cph/bootstrap-cdr` bundle established the working shape for cph→cnos handoff. This bundle reuses that shape for cn-sigma→cnos.

## Bilateral trace

Steps as executed:

1. **Filed:** cnos#379 filed in `usurobor/cnos` at `2026-05-19T02:38:33Z` with `ISSUE.md` @ `8f153c15e` as body. ✓
2. **Mirror created:** `cnos:.cdd/iterations/cross-repo/cn-sigma/agent-activate-skill/` with its own `LINEAGE.md` confirming acceptance and citing cnos#379. Landed at cnos commit `212d5239` on branch `sigma/cross-repo-mirror-agent-activate-skill` (pending operator merge to cnos main). ✓
3. **STATUS appended:** `submitted` + `accepted` + `modified` events appended to this directory's `STATUS` and mirrored on the cnos-side `STATUS`. ✓
4. **Issue body reconciled:** cnos#379 body edited at `2026-05-19T10:21:01Z` to fold in the AC4 capability-matrix refinement from cn-sigma branch HEAD `bdda457f5`. Source-Proposal SHA advanced from `8f153c1` to `1a4e25f75`. ✓
5. **On cycle close in cnos:** the LINEAGE.md is migrated into the cnos cycle's `cdd-iteration.md`; this source-side bundle may be archived. Pending.

## Per-deliverable inventory

| File | Purpose | Owner |
|---|---|---|
| `ISSUE.md` | Issue body to file in cnos. Conforms to `cdd/issue/SKILL.md` minimal output pattern. | sigma (author) |
| `STATUS` | Append-only event ledger for proposal lifecycle. | sigma (initial); cnos γ appends on acceptance |
| `LINEAGE.md` | This file. Bilateral trace. | sigma (initial); cnos γ predicted-path field becomes authoritative on filing |

## Notes for the operator (or filing body)

- This bundle has been filed and reconciled; the original notes (now historical) named pre-filing concerns about the filing body's write scope and the placeholder fields in `ISSUE.md`.
- The target issue cnos#379 is OPEN; the design-and-build cycle is yet to be dispatched (δ holds the wave-launch gate).
- After acceptance and cycle close on cnos main, this bundle stays in cn-sigma main until the cnos cycle's `cdd-iteration.md` carries the LINEAGE forward, then may be archived.
