# cn-sigma containerization migration — root → .cn-sigma/

**Date:** 2026-06-18 (migration event)
**Status:** r0 adhoc capture; documents the cn-sigma side of cnos#448 (cn-sigma unified containerization).
**Trigger:** Operator authorized γ-console execution of cn-sigma migration after Steps 1–2 of the cohere wave landed (PR #445 + PR #455 merged at cnos).

## What changed

Three surface trees moved from root level to under the `.cn-sigma/` namespace:

```
spec/                → .cn-sigma/spec/
state/               → .cn-sigma/state/
threads/             → .cn-sigma/threads/
```

Normative path-reference surfaces updated:

- `README.md` — surface table + Tier (b) HTTP fetch instructions
- `.github/workflows/claude-wake.yml` — three comment blocks (header narrative, concurrency, notify)
- `.cn-sigma/spec/PERSONA.md` — 3 cross-references (lines 62, 76, 88) from `cn-sigma/spec/OPERATOR.md` to `cn-sigma:.cn-sigma/spec/OPERATOR.md`
- `.cn-sigma/spec/OPERATOR.md` — 7 normative references (cross-reference, activation log table, activation loop steps 2/3/5/7, registry pointer)
- `.cn-sigma/state/activations.md` — registry header pointer; both `home_log` values (cnos + bumpt) with explicit path-note clarifying root-relative form; 2 historical-pointer references to `threads/adhoc/*` updated to `.cn-sigma/threads/adhoc/*`
- `.cn-sigma/state/hub.md` — "Identity: Read from" path updated; obsolete AGENTS.md reference removed
- `.cn-sigma/state/peers.md` — registry pointer
- `.cn-sigma/state/coherer-watch.md` — restored at new containerized location (the long-lived PR #9 notify mechanism doc)

## What did NOT change

Per the corrected scope at cnos#448 (Directive 13 AI2, reviewer convergence): historical r0/r1 entries are preserved as-evidenced. Old activation log entries, old adhocs, prior directive-out commit messages retain their original content even where they reference legacy paths. The memory law holds: lower-rank evidence is never rewritten to match higher-rank doctrine.

## Cursor preservation

This migration was redone from current `cn-sigma:main` state, so cursors and recent home thread entries are preserved:

- `cnos:last_read_foreign_log: c3f2305bbbaaa2f5349b17589170ccb5455b0dab` (current)
- `bumpt:last_read_foreign_log: 4844b8ad70924b129884f78b60291b15706cf749` (current)
- All entries through 2026-06-18 at `.cn-sigma/threads/activations/cnos/` and `.cn-sigma/threads/activations/bumpt/` preserved.

## Citation chain

- cnos#444 AC19 (unified containerization invariant)
- cnos#448 (this issue; cn-sigma migration scope)
- PR #455 / cnos#446 (activate skill path resolver supports both forms; merged)
- PR #445 (Writer Locality §0 + same-repo carve-out; merged)
- `cn-sigma:.cn-sigma/threads/adhoc/20260616-coherer-console-vs-wake-worker.md` (γ-console closure discipline; this commit is γ-closure of cn-sigma migration cycle)
