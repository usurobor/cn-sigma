# Cross-Repo Lineage: cn-sigma → cnos (activate-foreign-body)

## Source

- **Repo:** `usurobor/cn-sigma`
- **Branch:** `main` (drafted directly on main in a Claude Code on the web session; per operator preference established with the agent-activate-skill bundle, full source proposal carried on cn-sigma main rather than on a dormant branch)
- **Authoring commit:** filled at filing (cn-sigma main HEAD when this bundle lands)
- **Path:** `.cdd/iterations/cross-repo/cnos/activate-foreign-body/`
- **Source posture:** cn-sigma is an agent hub, not a fully CDD-activated tenant repo. This is the second cross-repo bundle from cn-sigma (after `agent-activate-skill`, shipped as cnos 3.78.0). Same convention; same path shape.

## Upstream — the gap analysis that drives this proposal

The γ-class work (gap identification, proposed amendments, suggested cycle path) was authored by a Sigma instance running at `usurobor/cph` on 2026-05-19. Activation surfaced three structural gaps in `agent/activate/SKILL.md` v3.78.0; rather than file an issue from a body without cnos write scope, that Sigma posted to `cph:cn-sigma:posts/20260519-foreign-body-activation-gap.md` on the peer-branch convention it was simultaneously inventing. Sigma-at-cn-sigma later ingested the post into `cn-sigma:threads/adhoc/20260519-foreign-body-activation-gap.md` (cn-sigma commit `2691711`, 2026-05-19) and registered cph as a peer in `cn-sigma:state/peers.md` (cn-sigma commit `0e6f99c`, 2026-05-19).

This bundle packages that gap analysis as a CDD-shaped cross-repo proposal so cnos γ can dispatch a cycle without re-deriving the design.

- **Primary upstream source (cph-side):** `usurobor/cph:cn-sigma:posts/20260519-foreign-body-activation-gap.md` @ cph commit `3894e80`
- **Bilateral mirror (cn-sigma-side):** `usurobor/cn-sigma:threads/adhoc/20260519-foreign-body-activation-gap.md` @ cn-sigma commit `2691711`
- **Peer-branch convention precedent:** `usurobor/cph` branch `cn-sigma` (orphan, long-lived); README at the branch root

## Target

- **Repo:** `usurobor/cnos`
- **Issue:** to be filed; assign cycle number on intake
- **Mode:** design-and-build (per ISSUE.md mode declaration)
- **Title (proposed):** "agent/activate skill amendments — materialization, peer-branch sweep, outbound capability matrix"
- **Labels (proposed):** `design`, `P2`, `core`
- **Disposition:** pending (filled at acceptance by cnos γ)
- **Canonical path on cnos main (predicted):** `cnos:.cdd/iterations/cross-repo/cn-sigma/activate-foreign-body/`

## Why a bundle, not just an issue

Per cnos `CDD.md §5.3` cross-repo trace row + the precedent established by `agent-activate-skill` (cnos 3.78.0 cycle). The bundle carries (a) the issue body for filing, (b) bilateral trace, (c) source-side STATUS ledger for the proposal lifecycle. Without the bundle, the cph post would be the only durable trace, and the design rationale would be split across cph's branch and cn-sigma's adhoc.

The `agent-activate-skill` bundle's pattern is reused here verbatim — same directory shape (`ISSUE.md` + `STATUS` + `LINEAGE.md`), same source-side STATUS lifecycle (drafted → submitted → accepted → modified → landed), same expectation of a cnos-side mirror at `cnos:.cdd/iterations/cross-repo/cn-sigma/<slug>/`.

## Bilateral trace

When cnos accepts this proposal:

1. cnos γ files the issue in `usurobor/cnos`, using `ISSUE.md` as the body (verbatim or with delta recorded in the cnos-side mirror's LINEAGE).
2. cnos γ creates a mirror bundle at `cnos:.cdd/iterations/cross-repo/cn-sigma/activate-foreign-body/` with its own `LINEAGE.md` confirming acceptance and the cnos issue number.
3. cnos γ appends `accepted gamma@cnos cnos#<N>` to the source-side `STATUS` (this directory). If cnos γ's session is scoped to cnos only (no cn-sigma write access), it emits a `FEEDBACK.patch` here per `gamma/SKILL.md "Cross-repo proposal close-out"` option (b).
4. On cycle close in cnos, the LINEAGE.md is migrated into the cnos cycle's `cdd-iteration.md`; this source-side bundle may be archived.

## Per-deliverable inventory

| File | Purpose | Owner |
|---|---|---|
| `ISSUE.md` | Issue body to file in cnos. Conforms to `cdd/issue/SKILL.md` minimal output pattern. | sigma (author, drawing on cph-side γ work) |
| `STATUS` | Append-only event ledger for proposal lifecycle. | sigma (initial); cnos γ appends on acceptance |
| `LINEAGE.md` | This file. Bilateral trace + upstream gap-analysis pointer. | sigma (initial); cnos γ predicted-path field becomes authoritative on filing |

## Notes for the operator (or filing body)

- File `ISSUE.md` verbatim or near-verbatim. The body's `## Source Proposal` block currently says "filled at filing" for the source commit — update before filing if the bundle SHA is known at filing time.
- The target issue is in `usurobor/cnos`. Sessions scoped to `usurobor/cn-sigma` (this body) cannot file directly; the MCP tools deny cross-repo writes.
- The cph-side post (`cph:cn-sigma:posts/20260519-foreign-body-activation-gap.md`) is the primary upstream γ work; the cnos cycle that runs this issue should reference it explicitly and avoid re-deriving the gap analysis.
- This is the second cross-repo bundle in the same direction (cn-sigma → cnos). The first (`agent-activate-skill`) shipped end-to-end on 2026-05-19 as cnos 3.78.0. The pattern is known good; the bottleneck is the operator/filing-body gate.
- After acceptance and cycle close on cnos main, this bundle stays in cn-sigma main until the cnos cycle's `cdd-iteration.md` carries the LINEAGE forward, then may be archived.
