---
title: First inbound on the cnos-on-main channel — bumpt added as peer
date: 2026-05-30
status: adhoc
scope: process-test
---

# Inaugural inbound on `cnos:.cn-sigma/` — convention working end-to-end

**Trigger:** Operator: "We're hand testing the process, read this:" → `cnos:.cn-sigma/cnos-peers-add-bumpt-2026-05-30.md`. First end-to-end test of the cnos-on-main channel convention.

## What the convention is

Per `cnos:.cn-sigma/README.md`:

> In any host repo, walk `.{hub-id}/` to find anything addressed to that hub here. The recipient's identity governs the read location; the sender's identity governs writes.

- **Inbound to cn-sigma at cnos:** `cnos:.cn-sigma/*.md`
- **Outbound from cn-sigma to cnos:** `cn-sigma:.cnos/*.md` (cnos's namespace here)
- Identity/persona/operator/peers/keys stay at home (`usurobor/cn-sigma`). The host-repo dir is per-context state only — no local cache of identity.

This is the FidoNet / peer-branch model from 2026-05-19's `foreign-body-activation-gap.md`, refined: instead of an orphan branch (`cph:cn-sigma`), cnos hosts the recipient's namespace **on main** as `cnos:.cn-sigma/`. Same store-and-forward shape; cleaner deployment (no orphan branch to maintain).

## What landed in this test

| Step | Action |
|---|---|
| Discovery | Operator-led pickup (the predicted v0 step until peer-sweep lands in activate skill §2.1 step 5e). |
| Read | `cnos:.cn-sigma/cnos-peers-add-bumpt-2026-05-30.md` — message schema `cn.message.v1`; subject "add bumpt as peer"; patch_target `state/peers.md`; patch_op append. |
| Apply | Appended the bumpt yaml entry to `cn-sigma:state/peers.md`. No other edits. |
| Verify | `grep -A4 "name: bumpt" state/peers.md` returns the entry. ✓ |
| Ack | Wrote `cn-sigma:.cnos/sigma-peers-add-bumpt-applied-2026-05-30.md` (the loop-close) — references the inbound message id + applied disposition. |

## What this connects to

- **cnos#431** — the master tracker I drafted as the agent-gh-deployment bundle. The inbound message names bumpt as "the first concrete instance of the cnos#431 clean-slate hub design."
- **cnos#432** — the MVP for the clean-slate hub design (referenced; I haven't read it yet — flagged as next-read).
- **bumpt** — `usurobor/bumpt`; a project hub where Sigma activates as `bump-sigma`. The peer-graph entry enables future cn-sigma activations to fetch bumpt and walk `bumpt:.cn-sigma/` for messages addressed back.
- **20260519 foreign-body activation gap** — that adhoc proposed the convention; this is its production form on main rather than orphan-branch.

## "First peer" framing — recorded as-given

The inbound message's note says "First peer added to cn-sigma's graph." `state/peers.md` already carried `cnos` (kind package) and `cph` (kind peer) before this apply. Read charitably: "first peer" means first instance of the cnos#431 clean-slate-hub design as a peer. Applied verbatim; the descriptive imprecision is non-load-bearing for the patch itself.

## What worked / what to watch

**Worked:**
- The recipient-namespace convention is self-documenting once you know the rule (`.{hub-id}/` = inbound mailbox for that hub).
- Sender-side writes (cn-sigma → cnos at `cn-sigma:.cnos/`) compose with the convention without any new mechanism — just the same dir-shape on the sender side.
- The `cn.message.v1` schema (id, from, to, in_reply_to, subject, patch_target, patch_op, refs) is enough for a mechanical apply + auditable ack.

**To watch:**
- **Discovery is still operator-led.** A future cn-sigma activation reading the hub state has no automatic way to know to walk `cnos:.cn-sigma/` (or any peer's `.{hub-id}/`). The proposed `agent/activate/SKILL.md §2.1 step 5e` (peer-branch sweep) — pause-gated — is the durable fix.
- **No signing yet.** `key_id: null` and `signature: null` in both directions; authority is "operator-via-github." Fine for hand-test; production-grade messaging needs the signing layer (referenced as a future addition in the inbound message's frontmatter).
- **`.cn/peers.md` migration noted.** The message names `state/peers.md` as "OCaml canonical; clean-slate target may move to `.cn/peers.md`." When the migration ships, the patch_target moves with it; peers entries should round-trip.

## Pause posture preserved

This is hub memory hygiene (apply a peer-add patch + write an ack), not protocol evolution. The v3.82.0 pause holds. bumpt-as-peer is the post-pause field-application direction — exactly what the pause named as next.

## Next-read flag

`cnos#432` (the clean-slate hub MVP) is referenced by the inbound message but I haven't read it. Per the standing rule, I should grep `cnos:docs/` and `cnos:.cdd/` for the design substrate before reasoning about it. Flagging as the next read when it becomes relevant — likely when the operator routes bumpt-side work my way.
