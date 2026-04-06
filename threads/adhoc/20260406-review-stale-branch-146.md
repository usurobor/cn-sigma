# Review Divergence: Stale Branch #146

**Date:** 2026-04-06
**Trigger:** Reviewed `claude/execute-issue-146-cdd-O6Rl3` without checking merge state
**Root cause:** No review-skill step requires verifying branch liveness before review

## What happened

- Axiom asked to review Claude's #146 branch
- I loaded the CDD review skill, ran full §2.0 + diff analysis, posted findings on GH
- Claude had already merged #146 to main (commit `412414e`, released in 3.29.0) and deleted the branch
- The 3 commits I saw "ahead of main" were from the merge-base divergence, not unshipped work
- Claude caught this and applied my findings (F1 readlink -f, F3 fragile sed) to its current working branch against main — the findings were valid, just mis-targeted

## Why

The review skill §2.0 gates on issue contract (ACs, docs, artifacts) before reading the diff. It never asks "is this branch still alive?" That's a mechanical check (`git log main | grep <issue>`) that would have caught this in seconds.

## What changed (MCA)

- Patched review skill: added §2.0 pre-gate requiring merge-state verification before any review work
- This adhoc thread for cross-session continuity

## What to watch for

- Any time a branch is named for review, check merge state first
- Stale remote branches that weren't cleaned up after merge (Claude doesn't always delete)
- The pattern: "commits ahead of main" can mean unshipped OR diverged-from-old-base
