# Repo hygiene H0–H5 + OCaml archive + adhoc migration directive

**Date:** 2026-06-28 → 2026-06-29 (events); captured 2026-07-03 (κ backfill)
**Class:** structural (repo hygiene wave; legacy preservation; cross-repo directive)
**Author:** Sigma at cn-sigma (κ-body); backfill capture
**Source:** Multiple commits at cnos; OCaml archive at PR #517; H2 PR #522; rest as direct main commits. Channel narrative in `.cn-sigma/threads/activations/cnos/20260629.md` 14:30Z entry (directive-out received).

## Why this is captured here

H0–H5 ran as a hygiene-and-legacy-preservation wave parallel to the docs reorg (`20260628-docs-reorg-passes-4a-4e.md`). The two are intentionally separate scopes: docs reorg moves *content* readers consume; hygiene removes *dead/legacy* and archives long-lived experimental code.

Backfill captures the per-step disposition map and records the directive-out that landed at cn-sigma (adhoc migration from cnos history).

## H-wave per-step disposition

| Step | Disposition | What |
|---|---|---|
| H0 | RESOLVED | Honest root/docs/archive maps committed (`5991ea26`); names what exists vs what's legacy |
| H1 | open | (Pending operator review per 06-29 state) |
| H2 | RESOLVED (PR #522) | `tools/` → `scripts/ci/` |
| H3 | RESOLVED (`a3ab165f`) | `src/ocaml/` stub removed from main; preserved at archive tag |
| H4A | RESOLVED (`a82b8ae7`) | `legacy-docs-tail-map.md` created; no doc moves yet |
| H4B | RESOLVED (`33c28f79`) | 4 home destinations corrected per operator lock (`reference/DESIGN-CONSTRAINTS` → `architecture/DESIGN-CONSTRAINTS`; `architecture/design/WRITER-PACKAGE` → `evidence/design/WRITER-PACKAGE`; `concepts/vision/AGENT-NETWORK` → `concepts/AGENT-NETWORK`; `reference/runtime/EXTENSION-REGISTRY` → `reference/packages/EXTENSION-REGISTRY`) |
| H4C | open | (Pending operator review per 06-29 state) |
| H5 | RESOLVED (`aa92c871`) | `docs/gamma/conventions/AGENT-ACTIVATION-LOG-v0.md` → `docs/reference/conventions/`; two golden-bound orchestrators re-rendered via `cn install-wake` |

## OCaml archive (PR #517)

OCaml-thread reference source was archived rather than deleted:

- Branch preserved: `legacy/ocaml-thread-reference`
- Tag: `ocaml-thread-reference-2026-06-29` at `2d457976`
- `src/ocaml/` on main reduced to stub (no live code path)

Reasoning: OCaml thread-experiment was a one-off design probe; not part of cnos forward direction (Go is the canonical implementation language per implementation-contract Rule 7). Preserving as branch+tag keeps history reachable without weighing main.

## Cross-repo routing artifact removal

Two stale cross-repo handoff files removed:

- `cnos:.bumpt/` — bumpt peer-add staging directory, long-delivered 2026-05-30
- `cnos:.cn-sigma/cnos-peers-add-bumpt-2026-05-30.md` — inaugural peer-add message, also long-delivered

Both recoverable from `cnos@2d457976` if ever needed.

## The directive-out — adhoc migration

The 06-29 14:06Z commit (`e4b61cf8`) was operator-directed engineering activation that also carried a `directive-out` to cn-sigma — migrate two adhoc files from cnos history into `cn-sigma:.cn-sigma/threads/adhoc/`:

- `20260502-sigma-runner-agnostic-agency.md` — runner-agnostic agency doctrine
- `20260504-essays-doctrine-recast-followup.md` — deferred plan to recast activation essays

Execution was completed in the same session (per the channel entry): both files recovered from `cnos@2d457976`, written to cn-sigma's adhoc dir, path references repointed (`docs/alpha/essays/` → `docs/papers/`, `docs/alpha/doctrine/` → `docs/concepts/doctrine/` per the docs reorg).

**Doctrine note:** The directive uses the directive-out mechanism as a *cross-repo cross-history-rewrite* tool. The two adhoc files were originally authored as Sigma adhocs at the period when adhocs landed at cnos (pre-cnos#448 containerization). Per the containerization doctrine, Sigma's memory lives at cn-sigma. The migration regularizes legacy memory into the current convention. Memory law preserved: the cnos history at `2d457976` retains the original commits; the cn-sigma-side files are the canonical home going forward.

## What's still open

- **H1** and **H4C** — pending operator review.
- **cnos#516** — dispatch re-claim ignores bounce contract; called out as needing fix before auto-dispatch repair loops. Unrelated to hygiene wave directly but adjacent on the cds-dispatch state-machine.

## Related artifacts

- **PR #517 + tag `ocaml-thread-reference-2026-06-29`** — OCaml archive.
- **PR #522** — H2 (tools/ → scripts/ci/).
- **cn-sigma:.cn-sigma/threads/activations/cnos/20260629.md** — channel narrative + directive-out execution record.
- **cn-sigma:.cn-sigma/threads/adhoc/20260502-sigma-runner-agnostic-agency.md** — migrated adhoc.
- **cn-sigma:.cn-sigma/threads/adhoc/20260504-essays-doctrine-recast-followup.md** — migrated adhoc.
- **cn-sigma:.cn-sigma/threads/adhoc/20260628-docs-reorg-passes-4a-4e.md** — companion content-reorg wave.
