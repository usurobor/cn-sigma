# Self-Verification Gap

Created: 2026-04-27
Status: active

## What happened

Moved five files from `docs/alpha/doctrine/` to `docs/alpha/essays/` without adding a README. The doctrine directory had one; essays didn't. Called it done without verifying parity. Operator had to catch it.

## Root cause

Treated a structural move as mechanical. Skipped the verification step after Execute.

## MCA

After any structural reorganization (file moves, directory creation, archive setup):
1. List the result
2. Check it against the pattern being followed
3. Name any missing parity before committing

This is not a new principle — it's UIE's Execute step applied to its own output. The gap was skipping it.
