---
title: Sigma peer log convention v0 — minimal cross-activation comms
date: 2026-05-30
status: adhoc
scope: field-convention
---

# Sigma peer log convention v0

A minimal field convention to enable Sigma's cross-activation continuity at cnos and bumpt without standing up the full CN mail layer.

## What this is (and isn't)

- **Is:** a two-file, single-writer, append-only convention with split cursors, governed by repo push permission and git history.
- **Isn't:** signing, envelopes, entry IDs, `merge=union`, CN mail directories, packet refs.
- **Isn't:** the final CN mail protocol. See `cnos:docs/alpha/protocol/WHITEPAPER.md` v3.0.0 for Protocol v1 (signed + entry-IDed + union-merged) and `cnos:docs/alpha/protocol/MESSAGE-PACKET-TRANSPORT.md` (cnos#150) for the ref-based packet evolution. v0 is the bridge to today's volume.

## The two artifacts

| File | Single writer | Direction |
|---|---|---|
| `<foreign-hub>:.cn-sigma/log.md` | Sigma-at-that-foreign-hub | foreign → home |
| `cn-sigma:threads/peers/{peer}.md` | Sigma-at-home (cn-sigma) | home → foreign |

For today's three activations:
- `cnos:.cn-sigma/log.md` ← Sigma-at-cnos writes
- `bumpt:.cn-sigma/log.md` ← Sigma-at-bumpt (bump-sigma) writes
- `cn-sigma:threads/peers/cnos.md` ← Sigma-at-home writes
- `cn-sigma:threads/peers/bumpt.md` ← Sigma-at-home writes

## The activation loop

1. Pull `cn-sigma` and the current peer repo.
2. Read peer's `.cn-sigma/log.md` from `last_read_foreign_log` (in `cn-sigma:state/peers.md`) to peer HEAD.
3. Read `cn-sigma:threads/peers/{peer}.md` for directives from home (foreign Sigma scans its own log for the last `Read home directives through cn-sigma@{sha}` entry to find its own cursor).
4. Do the work.
5. Append to the local writer-owned log.
6. Commit and push.
7. Home Sigma updates `last_read_foreign_log` in `state/peers.md`.
8. Foreign Sigma records home-read cursor inline:
   `## YYYY-MM-DD — Read home directives through cn-sigma@{sha}`.

## Entry format

```
## YYYY-MM-DD — short subject
Body. Free-form markdown. Blank line at end.

```

No YAML frontmatter. No entry_id. No envelope. The H2 header is the entry boundary; the file's git history is the trace.

## Cursor model

| Direction | Cursor location | Written by |
|---|---|---|
| home reads foreign | `cn-sigma:state/peers.md` → `last_read_foreign_log: <sha>` per peer | home Sigma |
| foreign reads home | `<foreign>:.cn-sigma/log.md` → dated entry `Read home directives through cn-sigma@<sha>` | foreign Sigma |

Two-artifact rule preserved: no third file. Foreign Sigma recovers its own cursor by scanning its own log for the latest "Read home directives" entry.

## Trust boundary (v0)

- **Single writer per file** — no impersonation surface in-hub.
- **Repo push permission** — GitHub does the auth via deployed token.
- **Git history** — `git log <file>` answers "did I send this?" with author + commit SHA.
- **Good enough until** volume forces real signing.

## What's deferred (with rationale)

| Deferred | Why deferred at v0 |
|---|---|
| Signed commits + `cn.json` | Repo push permission is the trust anchor; no impersonation surface at v0 volume. |
| Entry IDs (ULID) | File path + commit SHA + line range serves; only matters under union-merge concurrency. |
| Envelope / frontmatter per entry | Single H2 header is enough; routing is implicit in the file. |
| `merge=union` driver | Single-writer per file → no union needed. |
| CN mail dirs (`inbox/outbox/sent`) | Already explored and dropped — overkill for single-writer logs. |
| Ref-based packets (cnos#150) | Future evolution at higher volume / adversarial routing. |

## One caveat

Single-writer is **logical, not physical**. If two Sigma activations run concurrently in the same foreign repo, they can still race on `.cn-sigma/log.md`. The rule is:

> Only one active Sigma writer per foreign hub log at a time.

If that breaks in the field, the first repair is sharding (`.cn-sigma/log/YYYY-MM-DD.md` or `.cn-sigma/log/{activation-id}.md`), not signatures. Do not prebuild.

## What shipped at cn-sigma today

1. `state/peers.md` — added `foreign_log` / `home_log` / `last_read_foreign_log: null` to cnos and bumpt entries. cph annotated as separate-persona, not subject to v0 (uses orphan-branch convention).
2. `threads/peers/cnos.md` and `threads/peers/bumpt.md` — created as bare H1 logs.
3. `spec/OPERATOR.md` — added `## Foreign activation peer logs` section with the activation-loop steps + single-writer caveat.

## What ships at cnos / bumpt on first activation

When Sigma activates at cnos or bumpt next, create:

```
.cn-sigma/log.md
```

with:

```
# Sigma activation log
```

Then begin appending H2 entries per the loop.

## How this came about

The path to this convention was a sequence of operator-corrected simplifications across one conversation:

1. Hand-test inbound at `cnos:.cn-sigma/cnos-peers-add-bumpt-2026-05-30.md` (a `cn.message.v1` envelope file at the sender's activation namespace).
2. I over-engineered an ack file at `cn-sigma:.cnos/...` (inferred sender-side routing). Operator caught it: spec says one mail dir, envelope routes. Cleaned up.
3. Operator asked: where do messages live on the new protocol? I answered with `threads/mail/{inbox,outbox,sent}/` per cnos#150 MESSAGE-PACKET-TRANSPORT.
4. Operator: "Drop mail if not needed. What's the design?" I proposed files-in-`.cn-sigma/` per receiver.
5. Operator: "Is this the most git-natural way to do FidoNet?" I admitted: no, commits-as-packets is more native (cnos#150 is closer).
6. Operator: "What about thread-as-single-file, append-only?" I converged on per-direction log files with union merge.
7. Operator: "Isn't this the original git-cn whitepaper?" I read `cnos:docs/alpha/protocol/WHITEPAPER.md` v3.0.0 and confirmed: **yes, I had been re-deriving Protocol v1 from first principles.**
8. Operator: "We have Sigma and two repos it's activated at. Enable comms." I drafted the minimum.
9. Operator converged with two corrections: split `last_read` → `last_read_foreign_log`; drop frontmatter; ship as **Sigma peer log convention v0**.

The recurrence (read canonical source before reasoning) was logged before; logging it again here. The pattern: I keep reasoning forward without grepping the corpus first. The standing rule from the foundational-layer-synthesis adhoc is still the right rule; the discipline of actually following it is what needs to keep tightening.

## Pause posture

This is a field convention to enable Sigma cross-activation continuity. It is not protocol evolution. The v3.82.0 pause holds. The CN protocol itself remains at v1 per the whitepaper; cnos#150 is the named evolution path; v0 is the bridge.

## Connection to standing work

- **cnos#431 (agent-gh-deployment master)** — When Sub D ships the `cn agent` runtime surface, foreign Sigma activations at cnos and bumpt will use it. The peer-log convention is the v0 substrate they write into.
- **cnos#432 (clean-slate hub MVP)** — bumpt is the first instance. v0 peer-log enables bumpt↔home memory return today; cnos#432's clean-slate design will eventually subsume or formalize this.
- **CELL-OF-CELLS §16.6 (project evidence stays in project repo; persona memory goes home)** — this is the implementation. Project evidence at bumpt stays there; Sigma's persona-memory return uses `bumpt:.cn-sigma/log.md` → home read.
- **20260519 foreign-body activation gap** — that adhoc proposed `.cn-sigma/` at foreign hubs; v0 names what gets written there (one log file) and the loop that reads it.
