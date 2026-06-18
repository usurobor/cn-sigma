# coherer-watch

Long-lived PR used by the cn-sigma home wake to notify the coherer
session of channel activity. Each home wake's last step posts a
comment to this PR; the coherer session is subscribed to PR activity
and is woken by each comment.

This PR is **never merged**. It exists as a notification surface
only — the branch carries no functional changes, only this marker.

## Why

Per `threads/adhoc/20260604-operator-to-coherer-routing.md`, the
operator-coherer routing topology routes all cross-body coordination
through the home-side coherer. The coherer session needs to learn
about wake completions without polling. PR comments fire
PR-activity webhooks that surface to a subscribed session.

## Mechanism

```
cn-sigma wake fires
  ├── activate
  ├── attach (sweeps cnos + bumpt foreign logs, writes home entries)
  ├── push
  └── post comment on this PR  ← notification fires here
        │
        ▼
  coherer session woken via subscribe_pr_activity
```

Foreign hubs (cnos, bumpt) push to their channels normally. The
cn-sigma wake aggregates by sweeping their foreign logs each fire —
its push reflects all channel activity, and its notification comment
covers everything.

## Format

Each comment is a one-liner:

```
wake @ <sha>: <cursor-deltas-and-summary>
```

Coherer parses cheaply on receipt; reads channel surfaces for detail
if material.

## Do not merge

Closing this PR breaks the notification loop. Reopen if accidentally
closed.
