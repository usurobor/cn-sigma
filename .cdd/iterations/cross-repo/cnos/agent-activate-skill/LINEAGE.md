# Cross-Repo Lineage: cn-sigma → cnos (agent-activate-skill)

## Source

- **Repo:** `usurobor/cn-sigma`
- **Branch:** `claude/review-context-EbgR2` (drafted in a Claude Code on the web session)
- **Authoring commit:** filled at submission (cn-sigma main HEAD when this bundle lands)
- **Path:** `.cdd/iterations/cross-repo/cnos/agent-activate-skill/`
- **Source posture:** cn-sigma is an agent hub, not a fully CDD-activated tenant repo. This bundle adopts the cross-repo trace convention (cnos `CDD.md §5.3`, `gamma/SKILL.md "Cross-repo proposal close-out"`) and the pattern established by `cph/bootstrap-cdr` (cnos commit landing 2026-05-18). cnos #377 (open) tracks codification of the hub→CDD-repo case; this bundle is a concrete exemplar.

## Target

- **Repo:** `usurobor/cnos`
- **Issue:** to be filed; assign cycle number on intake
- **Mode:** design-and-build (per `ISSUE.md` mode declaration)
- **Title (proposed):** "agent/activate skill — single source of truth for agent self-activation"
- **Labels (proposed):** `design`, `P2`, `core` (per `cdd/issue/labels/SKILL.md` minimum)
- **Disposition:** pending (filled at acceptance by cnos γ)
- **Canonical path on cnos main (predicted):** `cnos:.cdd/iterations/cross-repo/cn-sigma/agent-activate-skill/`

## Why a bundle, not just an issue

Per `cnos CDD.md §5.3` cross-repo trace row: findings whose patch lands in a different repo than the source cycle hold bundle deliverables (issue body, lineage, status) at the originating repo until the target PR merges. Without a bundle, the proposal's authoring context (this conversation, this branch, the design decisions captured) is unrecoverable once the target issue is filed.

The `cph/bootstrap-cdr` bundle established the working shape for cph→cnos handoff. This bundle reuses that shape for cn-sigma→cnos.

## Bilateral trace

When cnos accepts this proposal:

1. cnos γ files the issue in `usurobor/cnos`, using `ISSUE.md` as the body (verbatim or with delta recorded in the cnos-side mirror's LINEAGE).
2. cnos γ creates a mirror bundle at `cnos:.cdd/iterations/cross-repo/cn-sigma/agent-activate-skill/` with its own `LINEAGE.md` confirming acceptance and the cnos issue number.
3. cnos γ appends `accepted gamma@cnos cnos#<N>` to the source-side `STATUS` (this directory). If cnos γ's session is scoped to cnos only (no cn-sigma write access), it emits a `FEEDBACK.patch` here per `gamma/SKILL.md "Cross-repo proposal close-out"` option (b).
4. On cycle close in cnos, the LINEAGE.md is migrated into the cnos cycle's `cdd-iteration.md`; this source-side bundle may be archived.

## Per-deliverable inventory

| File | Purpose | Owner |
|---|---|---|
| `ISSUE.md` | Issue body to file in cnos. Conforms to `cdd/issue/SKILL.md` minimal output pattern. | sigma (author) |
| `STATUS` | Append-only event ledger for proposal lifecycle. | sigma (initial); cnos γ appends on acceptance |
| `LINEAGE.md` | This file. Bilateral trace. | sigma (initial); cnos γ predicted-path field becomes authoritative on filing |

## Notes for the operator (or filing body)

- File `ISSUE.md` verbatim or near-verbatim. The body's `## Source Proposal` block must end up pointing at the actual cn-sigma commit SHA — update before filing if the bundle SHA is known at filing time.
- The target issue is in `usurobor/cnos`. Sessions scoped to `usurobor/cn-sigma` (this one) cannot file directly; the MCP tools deny cross-repo writes.
- After acceptance, this bundle stays in cn-sigma main until cnos's cycle closes, then may be archived.
