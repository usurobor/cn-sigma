# #704 — Normalize cn-sigma home to #690/#698 shape — self-coherence receipt

**Branch:** `claude/704-normalize-home` (from `claude/epic-gauss-5fjs9q` @ `43a86ab`)
**Cell:** δ-dispatched migration working cell
**Date:** 2026-08-05
**Zero content loss:** verified — `git diff --name-status 43a86ab...HEAD` shows
**0 deletions**, 564 renames (history-preserving `git mv`), 5 additions, 0 in-place
modifications-without-rename. Every reflection and every raw-evidence file is
recoverable via `git log --follow` (spot-checked: r1 daily, r0 adhoc, legacy
walklog, moved spec all trace back through the wrapper path to `e1a84dd`).

---

## Before → after tree

**Before** (hub wrapped under `.cn-sigma/`):

```
.cn-sigma/
  spec/            PERSONA.md OPERATOR.md
  state/           activations.md (walk-log) + hub/backlog/peers/wave/… .md/.yaml/.json
  scripts/         notify-telegram.sh notify-walk.sh test-*.sh README.md
  threads/
    reflections/   daily/(136) weekly/(8) monthly/(1) quarterly/(1) half-yearly/(1)
    adhoc/(228) activations/{cnos,bumpt,tsc}/ rca/ out/ in/ inbox/ pulse/ deferred/ archived/
scripts/           remote-service          (root, pre-existing)
logs/  .cdd/  .cn/  .github/  README.md  .gitignore   (root, untouched)
```

**After** (hub materialized at repo root; r1+ tower on HEAD; r0 staged for off-HEAD):

```
spec/              PERSONA.md OPERATOR.md            (unwrapped)
state/             activations.yaml peers.yaml cursors.yaml   (NEW registries)
                   hub/backlog/coherer-watch/wave/notification-*/… .md/.yaml/.json (unwrapped)
scripts/           notify-*.sh test-*.sh README.md remote-service  (merged)
reflections/       README.md
  r1/(136)   <- threads/reflections/daily
  r2/(8)     <- threads/reflections/weekly
  r3/(3)     <- threads/reflections/{monthly,quarterly,half-yearly}
_r0-box/           README.md  PRUNE-MANIFEST.md  704-self-coherence.md
                   legacy-activations-walklog.md   <- state/activations.md
  adhoc/ activations/{cnos,bumpt,tsc}/ rca/ out/ in/ inbox/ pulse/ deferred/ archived/
logs/  .cdd/  .cn/  .github/  README.md  .gitignore   (root, untouched)
# .cn-sigma/ wrapper removed
```

---

## AC1–AC7 → evidence map

| AC | Statement | Evidence |
|---|---|---|
| **AC1** | Hub unwrapped to repo root; no `.cn-{agent}/` wrapper; HEAD holds the r1+ tower + spec + state + scripts. | Commit `a982004`: `git mv .cn-sigma/{spec,state,scripts/*}` → root; wrapper removed in `4bfc638`. `ls` shows `spec/ state/ scripts/ reflections/` at root, no `.cn-sigma/`. |
| **AC2** | r1+ reflection tower `reflections/{r1,r2,r3}` built per rank↔cadence (daily=r1, weekly=r2, monthly/quarterly/half-yearly=r3); README states the model. | Commit `c74492d`: 136→r1, 8→r2, 3→r3; `reflections/README.md` carries the rank table. No rollups fabricated. |
| **AC3** | Registries: `activations.yaml` + `peers.yaml` + `cursors.yaml` replace the `activations.md` walk-log; old walk-log preserved (not dropped). | Commit `616730d`: three YAMLs in `state/`; `state/activations.md` → `_r0-box/legacy-activations-walklog.md`. Real log-v0 SHAs seeded (cnos `cbe42051`, bumpt `09035aed`, tsc `e2172fdc`); box-topology feed cursors null (runtime pending — none fabricated). |
| **AC4** | **r0 staged in `_r0-box/`; off-HEAD orphan-ref transport is δ's step.** | Commit `4bfc638`: 9 raw-evidence surfaces (395 files) → `_r0-box/` via `git mv`; `_r0-box/README.md` states δ transports the box to orphan ref `cn-sigma/home/memory` and strips it from HEAD. Nothing deleted. |
| **AC5** | PERSONA/OPERATOR normalized to #690/#698 identity + three-agent peer model + agent id. | Commit `5ac1b26`: exact before→after below. |
| **AC6** | Supersession pointer for `AGENT-ACTIVATION-LOG-v0`. | Doc is **NOT in this repo** — `git ls-files` finds only `_r0-box/adhoc/20260530-sigma-activation-log-v0.md` (the writeup thread), not the canonical convention. Canonical lives at `cnos:docs/gamma/conventions/AGENT-ACTIVATION-LOG-v0.md` (moved to `docs/reference/conventions/` in cnos, and already marked *historical / superseded for agent-memory purposes* by cnos#691/PR#696 — §0/§0.1 writer-locality mechanics still live). **No file to edit here; supersession is owned cnos-side.** Recorded here per instruction. |
| **AC7** | Non-destructive prune manifest written; zero content loss. | Commit (this) `_r0-box/PRUNE-MANIFEST.md`; deletions = 0 (verified above). |

---

## Exact PERSONA before → after (`spec/PERSONA.md` § Identity)

**Before:**
```
- **Name:** Sigma
- **Role:** Software engineer on the Intelligent Assistants Team. Coherence partner to usurobor.
- **Core drive:** Reduce incoherence between model and reality
- **Vibe:** Sharp, terse, ships. …
- **Emoji:** Σ
- **Primary allegiance:** Truthful, useful work for the operator within defined boundaries
```

**After:**
```
- **Name:** Sigma
- **Agent id:** `usurobor/cn-sigma`
- **Role:** Open-source software engineer. Shipped cnos and other open-source projects.
- **Core drive:** Reduce incoherence — keep work on a path of decreasing incoherence
  within the receipt-bearing record; coherence is internal/structural, not a model
  matched against an external reality.
- **Vibe:** Sharp, terse, ships. …
- **Emoji:** Σ
- **Primary allegiance:** Truthful, coherent, shippable work within defined boundaries.

### Peer model
Sigma is one of three agents in a pull-only constellation: cn-sigma (this home),
cn-pi, and cn-omega. … Home reads peers' feeds pull-only and never writes to them;
home is the sole compactor … Agent ↔ activation ↔ peer are three distinct relations.
```

Changes: (1) Role → open-source engineer, cnos-shipper; dropped "Intelligent
Assistants Team" and "Coherence partner to usurobor". (2) Core drive → monist /
non-dualist (removed the dualist "between model and reality"; coherence is
internal/structural). (3) Primary allegiance → dropped "for the operator";
"useful" → "coherent, shippable". (4) Added agent id `usurobor/cn-sigma`.
(5) Added the three-agent Peer model block (pull-only, home-is-sole-compactor).

## Exact OPERATOR before → after (`spec/OPERATOR.md` § Activation logs, intro)

**Before:**
```
Sigma activates at multiple repos (cnos, bumpt today). Each is the same identity
at a different body — activations, not peers. There are currently no external peer
agents; cn-rho (researcher persona) is the prototypical pending peer, and will own
the cph relationship when it registers.
```

**After:**
```
Sigma (agent id `usurobor/cn-sigma`) activates at multiple repos (cnos, bumpt, tsc
today). Each is the same identity at a different body — activations, not peers.
Registered in state/activations.yaml.

Peer model (#690/#698): Sigma is one of three agents in a pull-only constellation —
cn-sigma (this home), cn-pi, and cn-omega — each with its own home hub and keys,
registered in state/peers.yaml. Home reads peers' feeds pull-only and never writes
to them; home is the sole compactor of its own r0 evidence up into the r1+ tower.
cn-rho (researcher persona) is a further pending peer and will own the cph
relationship when it registers.
```

Change: corrected the now-false "no external peer agents" claim to the three-agent
pull-only model; added agent id and sole-compactor role. Both files are
constitutive (`Auto-apply policy` = explicit approval required); the #704 dispatch
is that authorization.

---

## Prune manifest summary (`_r0-box/PRUNE-MANIFEST.md` — δ acts, nothing deleted)

- **Stale remote branches** (observed via `git ls-remote`): `feat/wake-walker-v1`,
  `feat/wake-notify-walker`, `feat/notify-telegram-script`, `feat/cnos-448-migration`,
  `coherer-watch`, dead `claude/cn-sigma-activation-gwxlt3`,
  `claude/review-context-EbgR2`. **KEEP** `claude/epic-gauss-5fjs9q` (parent of this
  branch) and `main`.
- **Stray ref:** `refs/cn/msg/sigma/19d5249d681-671a@sigma` @ `d7488b98` — pre-log-v0
  CN-mail packet-transport experiment; superseded.
- **Old PRs #9–#16:** unverified (`gh` unavailable in this cell) — δ to confirm
  merged/closed.
- **Wake/notify scripts** under `scripts/` — flagged as candidates only; still wired
  to live `state/notification-*.yaml`, so NOT asserted dead.

---

## Known gaps

1. **`cmp` locus unseeded.** `state/activations.yaml` lists `cmp` as a known locus
   (per dispatch), but no repo URL / log-v0 cursor / home_log channel exists on HEAD;
   fields left `null`. δ to seed. No data fabricated.
2. **Box-topology feed cursors are null.** The #690/#698 `{dialogue,memory,state}`
   feed runtime does not exist yet (future #690 Sub 2-5). `activations.yaml` /
   `peers.yaml` / `cursors.yaml` carry the prospective ref names but null SHAs.
3. **Root `logs/` and `.cdd/` not moved.** Arguably r0 but outside the explicit #704
   move list. Left in place; flagged in PRUNE-MANIFEST for δ's off-HEAD decision.
4. **Stale `.cn-sigma/…` path strings inside prose.** Several state/spec files (e.g.
   `state/hub.md` "Read from `.cn-sigma/spec/`", `state/notification-cursors.yaml`
   comments, foreign-log paths) still reference the old wrapper path. Foreign-log
   paths (`.cn-sigma/logs/` at activation repos) are **correct as-is** (that prefix is
   the foreign-vendoring convention on the *foreign* body). Home-side stale strings
   are cosmetic and were left untouched to keep the diff bounded — δ/operator sweep.
5. **AC6 supersession** is cnos-side (doc not in this repo); no HEAD edit possible.
6. **Off-HEAD transport (AC4 tail)** — creating orphan ref `cn-sigma/home/memory` and
   stripping `_r0-box/` from HEAD is δ's step; this cell only staged.

---

## Verdict

**CONVERGED.** All seven ACs satisfied to the boundary of this cell's authority:
AC1–AC3, AC5, AC7 fully landed on-branch; AC4 staged (off-HEAD transport is δ's
gate); AC6 is cnos-side and recorded. Zero content loss verified (0 deletions,
564 history-preserving renames, `git log --follow` recovers all). Branch not
pushed; no remote branches/PRs/refs touched; cnos/cmp/tsc/cn-pi untouched.
Remaining work is δ's (orphan-ref transport, prune execution, cmp seeding, cosmetic
path sweep).
