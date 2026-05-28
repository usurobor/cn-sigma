# Cross-Repo Lineage: cn-sigma → cnos (agent-gh-deployment master tracker)

Case (a) operator-directed cross-repo proposal. cn-sigma operator issued the directive; cn-sigma Sigma drafted the master/tracker issue using the CDD design + write + issue skills; a cnos-scoped Sigma body files it.

## Source

- **Repo:** `usurobor/cn-sigma`
- **Branch:** `main`
- **Authoring commit:** filled at filing (cn-sigma main HEAD when this bundle lands)
- **Path:** `.cdd/iterations/cross-repo/cnos/agent-gh-deployment/`
- **Source posture:** fourth cross-repo bundle from cn-sigma (after agent-activate-skill [shipped 3.78.0], activate-foreign-body [drafted], release-3.82.0-hygiene [merged cycle/422]). Same convention.

## Upstream — operator directive

Operator (usurobor / Axiom), 2026-05-27: "Create a master issue using cdd design and write skills to capture the end goal: an agent can be activated on GH via either templates repo or by running cn activate in the repo or if there's a way to deploy a GH action my way too."

The directive followed the five-essay read + the GitHub-Actions-as-compute realization. The master tracker is the scoping artifact for the field-application direction the v3.82.0 pause named.

## CDD preflight (skills loaded before authoring)

Per `cn-sigma:spec/OPERATOR.md` skill-loading gate + the operator's explicit "using cdd design and write skills":
- `cnos:src/packages/cnos.cdd/skills/cdd/design/SKILL.md` — read (incoherence → constraints → impact graph → proposal → ACs → leverage; "name the incoherence not the feature"; impact graph not optional)
- `cnos:src/packages/cnos.core/skills/write/SKILL.md` — read (one governing question per document; nothing removed without loss, nothing repeated without gain)
- `cnos:src/packages/cnos.cdd/skills/cdd/issue/SKILL.md` + `issue/labels` + `issue/contract` + `issue/proof` — read earlier this session
- `cnos:src/packages/cnos.core/skills/agent/activate/SKILL.md` — read this session
- Design substrate (all 5 essays): CCNF-AND-TYPED-TRUST, DECREASING-INCOHERENCE, FIDONET-AND-CNOS, BOX-AND-THE-RUNNER, CELL-OF-CELLS — read this session

This is the first cross-repo bundle authored *after* the procedural fix (grep/read essays before reasoning) was adopted — the design substrate was loaded before authoring, not derived in conversation.

## Target

- **Repo:** `usurobor/cnos`
- **Issue:** [cnos#431](https://github.com/usurobor/cnos/issues/431) — **filed** by a parallel cnos session at `cn-sigma@6c95b53`; master/tracker; open. Mirror at `cnos:.cdd/iterations/cross-repo/cn-sigma/agent-gh-deployment/`.
- **Kind:** tracking (umbrella; coordinates subs; does not implement)
- **Title:** "Agent activation on GitHub — three deployment paths to a running hub (master tracker)"
- **Labels (filed):** `tracking`, `P2`, `core`. **Reconciliation pending:** add `handoff` (per external review).
- **Disposition:** filed (accepted as tracker, open, sub-dispatch operator-gated). **STALE vs source — reconciliation pending (see below).**
- **Canonical path on cnos main:** `cnos:.cdd/iterations/cross-repo/cn-sigma/agent-gh-deployment/`

## Post-filing drift — cnos#431 needs reconciliation

cnos#431 was filed from the bundle at `cn-sigma@6c95b53` (the original master tracker). The source bundle has since advanced **past** what cnos#431 carries — the same post-filing-divergence pattern as cnos#379's AC4 fold-in:

| Advance | Source commit | In cnos#431? |
|---|---|---|
| `BRIEF.md` added (third-party-review problem/solution statement) | `10c8cbc` | ❌ not referenced |
| 7 external-review precision edits to ISSUE.md (cn sync/agent, stub-vs-full, liveness, 6-field AC, auth split, framing, Sub A→C ordering) | `66febb5` | ❌ pre-edit body |
| `handoff` label | `66febb5` | ❌ labels still `tracking,P2,core` |

**Reconciliation needed (a cnos-scoped body must apply — cn-sigma session cannot edit cnos#431):**
1. Update cnos#431 body to the current `ISSUE.md` (the 7 precision edits).
2. Add the `handoff` label.
3. Add a reference to `BRIEF.md` (the external-review brief) — e.g. a "Reviewer brief" link in the issue body.
4. Refresh the cnos-side mirror (`cnos:.cdd/iterations/cross-repo/cn-sigma/agent-gh-deployment/`) ISSUE.md + LINEAGE Delta + STATUS `modified` event.
5. Pin the reconciled source SHA in the mirror (current cn-sigma main HEAD).

Until reconciled, cnos#431 is a valid tracker but reflects the pre-review bundle. The drift is non-blocking (the subs aren't dispatched; the tracker's shape is unchanged), but the BRIEF and the `cn sync`/`cn agent` correction should land before any sub is dispatched so implementers read the corrected runtime framing.

## External review (2026-05-27)

A third party reviewed `BRIEF.md` + `ISSUE.md` and accepted the bundle directionally as the right master/tracker shape. Verdict: file into cnos with precision edits. Seven edits incorporated pre-filing (each verified against cnos primary sources before applying — `cn sync`/`cn agent` semantics confirmed against `docs/beta/guides/AUTOMATION.md`):

1. **`cn sync` vs `cn agent`** — sync = transport-only tick; `cn agent` (oneshot) = full reasoning wake (maintain_once + drain_queue, already includes maintenance). Removed the `cn sync → process → cn agent` sequencing; Sub D owns the exact command. Sub D renamed accordingly.
2. **Stub vs full-fidelity** — Sub A/Sub C MAY ship stub/transport wake today; MUST NOT claim full agent wake until Sub D ships the Go `cn agent` oneshot surface. Made explicit in the runtime constraint + both subs.
3. **Scheduled-workflow liveness** — softened the over-confident "commit activity keeps the schedule alive": public dormant repos get scheduled workflows auto-disabled (~60 days inactivity); `workflow_dispatch` manual wake is required; liveness is part of the field test. (This was the verify-don't-assert item from `20260519-git-read-and-untested-limits.md`, now confirmed.)
4. **6-field receipt explicit in ACs** — AC3 now lists all six fields (who/what/where/credentials/evidence/who-accepts), not just a pointer to the essay.
5. **Auth separation** — `GITHUB_TOKEN` (own-repo write only) vs model API key (model call only); no peer-write credential in the base case; private peer reads = separate optional credential later.
6. **"repo is the agent" framing** — lead with the precise "the hub repo stores the agent's durable continuity," then the slogan "the repo is the agent at rest; the runner is the agent awake." Matches AGENT-CONTINUITY's actual framing ("the hub is the body; the agent is the continuity it preserves").
7. **Sub A → Sub C ordering** — explicit: Sub A ships a stub workflow first; Sub C later adopts/replaces it as the canonical reusable form. Avoids the A-waits-C-waits-D circular stall.

The review validated the α≠β firebreak: the reviewer (no authoring stake) caught the `cn sync`/`cn agent` conflation that Sigma (deep authoring stake) had glossed. This is exactly why the brief invited external review and why Sigma excluded itself as auditor on the coherence-audit charter.

## Proposed sub-issues (envelope, not binding)

- Sub A — `cn-hub-template` repository
- Sub B — `cn activate` deploy-mode
- Sub C — deployable GH Action / reusable workflow (6-field receipt by construction)
- Sub D — `cn sync` / `cn agent` Go runtime surface (or documented stub) — the load-bearing dependency
- Sub E — end-to-end field test (mechanical success oracle from the operator realization)

## Pause interaction

Authored under the v3.82.0 protocol-evolution pause. The tracker scopes the field-application direction the pause named; it does NOT lift the pause. Sub-dispatch is operator-gated and incremental. Deployment infra is field-enabling (not theory-expanding), so the operator may authorize subs as field needs surface — but no sub dispatches without explicit authorization.

## Bilateral trace (forward-looking)

1. **File:** cnos γ files the master tracker; ISSUE.md is the body.
2. **Mirror:** cnos creates `cnos:.cdd/iterations/cross-repo/cn-sigma/agent-gh-deployment/` mirror LINEAGE.
3. **Sub envelope:** the five proposed subs are filed incrementally per the wave dispatch shape, each on operator authorization.
4. **Close:** master closes when AC1-AC5 pass or all live subs close with deferred subs named as tracked debt.

## Notes for the operator / filing body

- This is a tracker — it does not implement. The subs carry the implementation; they dispatch under the pause's operator-gate.
- Sub D (the `cn sync`/`cn agent` runtime surface) is the load-bearing dependency. Subs A and C can ship stub-mode (wake mechanics, no agent step) pre-v4; full-fidelity deployment waits on the runtime port (v4.0.0 Phase 5).
- The 6-field remote-runner receipt (`BOX-AND-THE-RUNNER`) is a hard constraint on every workflow artifact the subs ship — built in by construction, not retrofitted.
- This bundle is the fourth cn-sigma → cnos cross-repo proposal. The pattern is proven; the filing bottleneck is a cnos-scoped body or operator pickup.
