# Tooling Gap: GitHub 403 on branch delete / tag push / ref write

**Filed:** 2026-04-23
**Surface:** Claude/OpenClaw execution environment
**Status:** Open — workaround documented, no fix available

## Problem

When running β close-out or γ cleanup, `git push --delete origin <branch>` and `git push origin <tag>` intermittently return HTTP 403. This is not a GitHub token scope issue — the same token succeeds on other write operations (commit push, PR creation). The failure is specific to ref-write operations (branch delete, tag push) from within the Claude/OpenClaw sandbox.

## Recurrence

| Cycle | Failure |
|-------|---------|
| 3.56.0 (#254) | Tag push 403 |
| 3.56.2 (#250) | Tag push 403 (2nd consecutive) |
| 3.57.0 (#260) | Branch delete 403 (3rd consecutive — threshold hit) |

The β close-out for #260 explicitly triggered this filing: "If it recurs a third time, file as a tooling-gap issue."

## Root cause hypothesis

The OpenClaw/Claude execution environment applies a permission boundary on certain Git ref-write operations. Standard push-to-branch works; destructive or tag operations are filtered. This is likely a platform-level safety constraint, not a misconfiguration.

## Workaround

- Branch deletion: operator deletes via GH UI or local CLI
- Tag push: operator pushes tag from local environment
- γ close-out notes the 403 and defers cleanup to operator

## Impact

- Low severity — workaround is seconds of operator time
- High annoyance — breaks β/γ closure automation every cycle
- Process: γ must track deferred cleanup items per cycle

## Resolution path

Monitor for OpenClaw platform updates that expand ref-write permissions. No cnos-side fix possible — this is an environment constraint.
