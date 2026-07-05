# Sub 0: issue/status-truth reconciliation for #452/#453

**Parent:** `wake-substrate-provider-boundary` master (execution decomposition of cnos#452).
**Filing kind:** reconciliation cell (docs-only). Not an α-build cell — this is a κ/γ translate-and-record move that patches the executable issue contract before any implementation.
**Mode:** docs-only.
**Suggested labels:** `P2`, `area/agent`, `kind/process`.

## Problem

**Exists:** #452 and #453 reference the older wake-template path and #450; they predate the wake-provider / `cn install-wake` landing. The master bundle above was authored from cn-sigma (κ-body) **without live cnos read access**, so its status-truth table is proposal-asserted, and one row is an open conflict.

**Expected:** #452 and #453 carry a live-verified status table so an engineer not in this conversation can dispatch against the current boundary, not a stale one.

**Divergence:** proposal asserts `#450 superseded/closed`; the filed foundation wave (#579, 07-04) status table says `#450 — Queued`. Both cannot be current. No build may proceed on an unreconciled contract.

## Impact

- A raw #452 dispatch would build the right idea against the wrong boundary (wake-template vs wake-provider).
- Downstream subs (contract, continuity) cite #452's status truth; if it is stale, every sub inherits the error.

## Status truth (to be produced by this sub)

This sub's *output* is the verified table. Inputs to verify (all currently `verify`/`CONFLICT` — see master): #452 open, #453 open, #450 disposition, #467 disposition, current rendered-workflow schema (`cn.wake-provider.v1`), Claude-action lock presence.

## Source of truth

| Artifact | Path |
|---|---|
| Issues under review | `cnos#452`, `cnos#453`, `cnos#450`, `cnos#467` |
| Live workflows | `cnos:.github/workflows/cnos-agent-admin.yml`, `cnos-cds-dispatch.yml` |
| Foundation wave table | `cnos#579` / `cn-sigma:.cdd/iterations/cross-repo/cnos/foundation-completion-wave/ISSUE.md` |

## Acceptance criteria

- **AC1 — #452 verified status table.**
  - invariant: #452 carries a table mapping each status claim to live cnos state.
  - oracle: table present in #452 body/comment; each row cites a live artifact (issue state, workflow header).
  - positive: `#450` row resolved to a single verified disposition with citation.
  - negative: any row left `verify`/`CONFLICT` → AC fails.
  - surface: #452 issue body or pinned comment.
- **AC2 — #453 dependency statement.**
  - invariant: #453 states "depends on #452 backend contract" and is not a drop-in API-swap.
  - oracle: dependency sentence present; links #452.
  - positive: #453 notes hermetic executor-design may proceed pre-contract.
  - negative: #453 still framed as "open follow-on later" → AC fails.
  - surface: #453 issue body/comment.
- **AC3 — stale-reference correction.**
  - invariant: every stale reference (#450 wake-template path, pre-wake-provider language) is explicitly named as corrected.
  - oracle: a "corrected references" list exists.
  - positive: #450 conflict named and resolved.
  - negative: silent edit with no correction list → AC fails.
  - surface: reconciliation comment.
- **AC4 — dispatch gate.**
  - invariant: no #452/#453 α/β dispatch occurs before AC1–AC3 land.
  - oracle: no worker branch/cell exists for #452/#453 predating the reconciliation comment timestamp.
  - positive: master bundle's dispatch rule cites this sub as precondition.
  - negative: a build cell opened before reconciliation → AC fails.
  - surface: cnos cell ledger / branch list.

## Proof plan

- oracle: issue diff + reconciliation comment with per-row live-state citations.
- positive: #450 conflict shown resolved against live issue state.
- negative: presence of any unverified row, or a build cell opened pre-reconciliation.
- operator-visible: reconciliation comment on #452 links the verified table.
- known gap: this sub cannot itself be executed from cn-sigma (no cnos scope); it runs at the cnos body.

## Non-goals

- No implementation.
- No new boundary design (that is Sub 1).
- No issue closure (δ gate).
