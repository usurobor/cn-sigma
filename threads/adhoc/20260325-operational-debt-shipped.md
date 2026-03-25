# Operational Debt Shipped — #37 + #28

**Date:** 2026-03-25

## What shipped

Two operational debt items that had been blocking autonomous agent operation:

### #37 — cn update (v3.16.0)
- Same-version patch detection via commit hash
- ARM binary in CI release matrix
- Bare version tag trigger in release.yml
- `target_commitish` SHA validation (prevents false patches from branch-name releases)
- `cn --version` shows commit hash

**Result:** Pi self-updated from 3.15.1 → 3.16.0 → 3.16.1 without manual intervention.

### #28 — Daemon retry limit + dead-letter (v3.16.1)
- Per-trigger retry counter with exponential backoff (1s, 2s, 4s)
- Error classification: 4xx → immediate dead-letter, 5xx/network → retry then dead-letter
- Dead-letter: advance offset, trace event, clean stale state, continue processing

**Result:** A single bad trigger can no longer wedge the daemon forever.

## Before vs after

| Before | After |
|--------|-------|
| Every release: manual `dune build` + `scp` to Pi | Pi self-updates on next poll cycle |
| Bad trigger: infinite retry, manual kill + offset fix | 3 retries with backoff, then dead-letter and move on |
| Daemon wedged: only recovery is SSH in | Daemon recovers autonomously |

## What this enables

Pi is now operationally autonomous for the first time:
- Receives updates without human intervention
- Recovers from bad triggers without human intervention
- The two biggest operational debt items are closed

Next blockers for full two-agent autonomy: #39 (agent messaging), #106 (ops markup leak).
