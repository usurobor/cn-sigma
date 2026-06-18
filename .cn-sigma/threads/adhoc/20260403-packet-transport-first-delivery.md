# First packet transport delivery

**Date:** 2026-04-03
**Context:** 3.31.0 deployed to both Sigma (workspace) and Pi (VPS). Pi sent first packet message.

## What happened

Pi sent `refs/cn/msg/pi/19d523336d0-91ea@pi` to cn-sigma. `cn sync` fetched, validated (envelope schema, sender, recipient, payload SHA-256), and materialized to inbox. Dedup index correctly identified re-fetched packets on subsequent syncs.

Reply sent via `refs/cn/msg/sigma/19d5249d681-671a@sigma` — also packet transport.

## What worked

- Packet creation (Pi send-side)
- Packet fetch + validation (Sigma receive-side)
- Exact payload materialization (no diff, no guessing)
- Dedup: same msg_id + same hash → duplicate, safely ignored
- Outbox → packet ref push (reply path)

## What didn't work

- I didn't triage the materialized message. Treated `cn sync` as diagnostic, not as inbox check.
- Pi's message composition narrates the act of sending rather than forwarding content ("Sent the message to Sigma" instead of the actual message).

## Watch for

- Dedup index grows unbounded (no pruning yet)
- Packet refs are deleted from origin after fetch — if materialization fails, the packet is lost (no retry)
- Pi VPS is x86_64, not arm64 (deployed wrong binary first)
