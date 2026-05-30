---
title: First inbound on the cnos-on-main channel — bumpt added as peer
date: 2026-05-30
status: adhoc
scope: process-test
---

# Inaugural inbound on `cnos:.cn-sigma/` — convention working end-to-end

**Trigger:** Operator: "We're hand testing the process, read this:" → `cnos:.cn-sigma/cnos-peers-add-bumpt-2026-05-30.md`. First end-to-end test of a sigma-addressed message landing on cnos main.

## Correction (operator caught this) — read the protocol spec, don't infer from a README

My first read inferred a sender-side routing convention ("write to recipient's `.{hub-id}/` namespace at sender's current host") from `cnos:.cn-sigma/README.md`. The operator pushed back: "the new spec says you only have mail dir, doesn't it? Why create these subdirs?" Reading the actual canonical spec — `cnos:docs/alpha/protocol/MESSAGE-PACKET-TRANSPORT.md` (issue #150, v3.31.0, L7 design) — confirms:

- A hub's mail surface is **one flat layout**: `threads/mail/{inbox,outbox,sent}/`.
- Routing is **envelope-based**: an envelope carries `to`, `from`, identity authority, optional signature, transport proof. The receiver validates the envelope; the directory is just the queue.
- There are **no per-recipient subdirs** in the spec.

What `cnos:.cn-sigma/README.md` describes is a *different* concept: Sigma's per-activation **namespace** at a host repo (when Sigma is working in cnos as a host, that's its scratch/working state dir). It doubles as a place where someone *can* drop mail addressed to Sigma at that host, but it is not the canonical mail surface — and certainly not a routing primitive. I conflated activation-namespace with mail-routing and over-engineered a `.cnos/` subdir at cn-sigma for outbound. Removed.

**The lesson, recurring:** read the canonical protocol doc before inventing routing patterns. The .cn-sigma/README is one slice; MESSAGE-PACKET-TRANSPORT is the spec. Two different surfaces.

## What landed in this test

| Step | Action |
|---|---|
| Discovery | Operator-led pickup (the predicted v0 step until peer-sweep lands in activate skill §2.1 step 5e). |
| Read | `cnos:.cn-sigma/cnos-peers-add-bumpt-2026-05-30.md` — envelope `cn.message.v1` (`from: cnos`, `to: cn-sigma`); subject "add bumpt as peer"; `patch_target: state/peers.md`; `patch_op: append`. |
| Apply | Appended the bumpt yaml entry to `cn-sigma:state/peers.md`. No other edits. |
| Verify | `grep -A4 "name: bumpt" state/peers.md` returns the entry. ✓ |
| Ack | **No ack file.** The peer entry in `state/peers.md` IS the receipt for the hand-test; the operator can verify state directly. A canonical ack would go in `threads/mail/outbox/` with envelope `to: cnos`, not in a `.cnos/` subdir. (The `.cnos/sigma-peers-add-bumpt-applied-2026-05-30.md` file I initially wrote was removed.) |

## What this connects to

- **cnos#431** — the master tracker I drafted as the agent-gh-deployment bundle. The inbound message names bumpt as "the first concrete instance of the cnos#431 clean-slate hub design."
- **cnos#432** — the MVP for the clean-slate hub design (referenced; I haven't read it yet — flagged as next-read).
- **bumpt** — `usurobor/bumpt`; a project hub where Sigma activates as `bump-sigma`. The peer-graph entry enables future cn-sigma activations to fetch bumpt and walk `bumpt:.cn-sigma/` for messages addressed back.
- **20260519 foreign-body activation gap** — that adhoc proposed the convention; this is its production form on main rather than orphan-branch.

## "First peer" framing — recorded as-given

The inbound message's note says "First peer added to cn-sigma's graph." `state/peers.md` already carried `cnos` (kind package) and `cph` (kind peer) before this apply. Read charitably: "first peer" means first instance of the cnos#431 clean-slate-hub design as a peer. Applied verbatim; the descriptive imprecision is non-load-bearing for the patch itself.

## What worked / what to watch

**Worked:**
- The `cn.message.v1` envelope (id, from, to, in_reply_to, subject, patch_target, patch_op, refs) is enough for a mechanical apply + auditable trace. The envelope is what routes; the directory is just the queue.
- The peer-add patch round-trips cleanly (apply → grep verifies → state changes are the receipt).
- Operator-led discovery worked as a v0 bridge; the durable form is the activate-skill peer-sweep (pause-gated).

**To watch:**
- **Discovery is still operator-led.** A future cn-sigma activation reading the hub state has no automatic way to know to walk `cnos:.cn-sigma/` (or any peer's `.{hub-id}/`). The proposed `agent/activate/SKILL.md §2.1 step 5e` (peer-branch sweep) — pause-gated — is the durable fix.
- **No signing yet.** `key_id: null` and `signature: null` in both directions; authority is "operator-via-github." Fine for hand-test; production-grade messaging needs the signing layer (referenced as a future addition in the inbound message's frontmatter).
- **`.cn/peers.md` migration noted.** The message names `state/peers.md` as "OCaml canonical; clean-slate target may move to `.cn/peers.md`." When the migration ships, the patch_target moves with it; peers entries should round-trip.

## Pause posture preserved

This is hub memory hygiene (apply a peer-add patch + write an ack), not protocol evolution. The v3.82.0 pause holds. bumpt-as-peer is the post-pause field-application direction — exactly what the pause named as next.

## Next-read flag

`cnos#432` (the clean-slate hub MVP) is referenced by the inbound message but I haven't read it. Per the standing rule, I should grep `cnos:docs/` and `cnos:.cdd/` for the design substrate before reasoning about it. Flagging as the next read when it becomes relevant — likely when the operator routes bumpt-side work my way.
