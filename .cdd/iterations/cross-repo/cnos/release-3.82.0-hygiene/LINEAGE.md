# Cross-Repo Lineage: cn-sigma → cnos (release-3.82.0-hygiene)

This bundle is **case (a) — operator-directed cross-repo proposal** per `cnos:src/packages/cnos.handoff/skills/handoff/cross-repo/SKILL.md` (formerly at `cnos:src/packages/cnos.cdd/skills/cdd/cross-repo/SKILL.md` pre-#416). cn-sigma operator issued the directive; cn-sigma sigma drafted the bundle; cnos sigma (a body with cnos write scope) is the expected applier.

## Source

- **Repo:** `usurobor/cn-sigma`
- **Branch:** `main` (drafted directly on main per operator preference established with prior agent-activate-skill + activate-foreign-body bundles)
- **Authoring commit:** filled at filing (cn-sigma main HEAD when this bundle lands)
- **Path:** `.cdd/iterations/cross-repo/cnos/release-3.82.0-hygiene/`
- **Source posture:** cn-sigma is an agent hub, not a fully CDD-activated tenant repo. This is the third cross-repo bundle from cn-sigma (after `agent-activate-skill` shipped as cnos 3.78.0 and `activate-foreign-body` still drafted). Same convention; same path shape.

## Upstream — operator directive

Operator (usurobor / Axiom) issued the directive directly on 2026-05-22 (evening). Full text captured in `cn-sigma:threads/adhoc/20260522-release-boundary-and-pause-directive.md`. Compact form:

> Sigma: run one final release-hygiene cycle and cut v3.82.0. Patch stale CDS/CDR README status text, confirm handoff v0.1 complete, bump VERSION, tag the CCNF package-architecture baseline, and stop. Do not launch #405/TSC/IssueProposal/CCNF-O or new package work. After the tag, pause protocol evolution and move to field application of CDS/CDR plus handoff/memory-return testing.

Trigger evidence inside cn-sigma memory:
- `threads/adhoc/20260522-cnos-evolution-scan.md` — 10-axis evaluation; "release cadence: BROKEN — 143 commits unreleased; cn-sigma deps blind to V, CDS, CDR-current, handoff, both essays."
- `threads/adhoc/20260522-cnos-unreleased-wave-cadence.md` (second-sigma's read this morning) — flagged the same cadence question; un-resolved until now.
- `threads/adhoc/20260522-decreasing-incoherence-essay-read.md` — names the autonomy ladder L1-L6 + 6-wave migration plan; explicitly notes Sigma is at L1-L2 and L3+ requires schema + TSC integration.

The operator's directive resolves the cadence question by tagging the architecture baseline AND closes the next-step ambiguity by setting the pause condition. Sigma's evolution scan reaching the same "release boundary needed" conclusion independently is structural confirmation, not the cause.

## Target

- **Repo:** `usurobor/cnos`
- **Issue:** to be filed; cycle is bounded MCA mode
- **Mode:** MCA (design + plan converged in this issue body)
- **Title (proposed):** "release v3.82.0 hygiene — CCNF package-architecture baseline + pause directive"
- **Labels (proposed):** `chore`, `P1`, `release`
- **Disposition:** pending (filled at acceptance by cnos γ-as-δ — β-α-collapse-on-δ permitted per new persona Rule 5)
- **Canonical path on cnos main (predicted):** `cnos:.cdd/iterations/cross-repo/cn-sigma/release-3.82.0-hygiene/`

## Why a bundle, not just an issue

Per `cnos:src/packages/cnos.handoff/skills/handoff/cross-repo/SKILL.md` cross-repo trace conventions: a proposal that originates outside the target repo benefits from a bundle to preserve authoring context (operator directive text, the multiple-adhoc evidence trail in cn-sigma memory, the specific patch text already drafted to remove ambiguity at apply time). Without the bundle, the cnos applier would have to re-derive the patches from the README drift descriptions — adding latency and re-derivation risk.

The drafted patch text in ISSUE.md §"Implementation guidance" makes the cycle MCA-eligible: the applier executes the replacement text directly without composing it. β-α-collapse-on-δ is permitted (per Rule 5) because the AC oracle is mechanical (grep for shipped-but-claimed-pending markers; file content match; VERSION integer bump; tag-pushed-with-CI-green).

## Bilateral trace

When cnos accepts this proposal:

1. cnos γ-as-δ files the issue in `usurobor/cnos` (or runs the cycle directly if the operator routes it as MCA-already-converged-no-issue-needed; the bundle's ISSUE.md is filed verbatim either way).
2. cnos γ-as-δ creates a mirror bundle at `cnos:.cdd/iterations/cross-repo/cn-sigma/release-3.82.0-hygiene/` with its own LINEAGE.md confirming acceptance.
3. cnos γ-as-δ appends `accepted gamma-as-delta@cnos cnos#<N>` to the source-side STATUS (this directory) — or, if the cnos session is cnos-only-scoped, emits a `FEEDBACK.patch` here.
4. After the tag v3.82.0 is pushed and release CI is green, cnos γ-as-δ appends `landed gamma-as-delta@cnos cnos#<N> <merge-sha> 3.82.0` to the source-side STATUS.
5. The bundle's role then transitions to permanent audit artifact; the LINEAGE.md (this file) records the full trace from operator directive through release tag.

## Per-deliverable inventory

| File | Purpose | Owner |
|---|---|---|
| `ISSUE.md` | Issue body for cnos cycle. MCA mode; drafted patch text in §"Implementation guidance" makes the cycle mechanically applicable. | sigma (author, executing operator directive) |
| `STATUS` | Append-only event ledger for proposal lifecycle. | sigma (initial); cnos γ-as-δ appends on acceptance + landing |
| `LINEAGE.md` | This file. Bilateral trace + operator directive provenance. | sigma (initial) |

## Notes for the operator (or filing body / applying body)

- The issue body's `## Source Proposal` block still says "filled at filing" for the source commit — update before the cnos cycle dispatches if the bundle commit SHA is known.
- The cycle is **bounded by operator directive**. The "Do not" list in §"Scope" and §"Non-goals" is enforced as scope-violation gating; β-as-δ rejects any out-of-scope change with severity D regardless of how mechanically clean the change appears.
- **Post-tag pause is the load-bearing outcome.** The γ close-out's "Next" section MUST name the pause directly and MUST NOT propose a next protocol cycle. Field application + memory-return testing is the operator-named direction post-pause.
- This is the third cross-repo bundle from cn-sigma in 4 days (5/19 agent-activate-skill → 5/19 activate-foreign-body → 5/22 this). The pattern is proven; the bottleneck is operator-pickup velocity.
- Pre-existing CI noise (lychee link validation per the 2026-05-19 daily reflection notes) is non-blocking per `operator/SKILL.md §3.4 step 4`; release CI green excluding pre-existing infra is acceptable.
- After this bundle's `landed` event fires on STATUS, this source-side bundle may be archived (per `cross-repo/SKILL.md §2.8` archival rule). Recommend operator decision: preserve in cn-sigma main indefinitely as audit artifact (matches the carry-on-main posture established for the prior bundles), or move to `.cdd/archived/cross-repo/cnos/`.

## Pause-condition note

Per operator: "After v3.82.0 is tagged and pushed: pause protocol evolution." This bundle's lifecycle does not end at `landed`; the lifecycle ends when the operator declares the pause complete and post-pause work begins. Sigma at cn-sigma side will hold the post-tag pause state in `threads/adhoc/20260522-release-boundary-and-pause-directive.md` as the standing posture. Any future cnos-side cycle dispatch during the pause period requires explicit operator authorization that overrides the pause directive.
