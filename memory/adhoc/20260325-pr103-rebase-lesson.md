# PR #103 Rebase Lesson — Reset + Cherry-Pick over Conflict Rebase

**Date:** 2026-03-25
**Context:** PR #103 (`claude/3.15.2-29-telegram-empty-filter`) landed after history rewrite (git filter-repo to fix Test→usurobor authorship) plus 2 CDD commits on main since branch fork.

## What happened

1. Branch forked before 3 CDD commits landed on main
2. Then git filter-repo rewrote all SHAs (Test→usurobor)
3. Branch was now doubly diverged: old SHAs + missing new commits
4. Normal rebase would have been conflict-heavy and would smuggle unrelated reconciliation into the PR

## What was done

Reset branch to current `origin/main`, cherry-pick only the 2 intended fix commits. Clean merge means one thing: #29's fix landed.

## Process lesson

**When a branch is far behind or history has been rewritten, prefer reset-to-main + cherry-pick the intended delta over conflict-heavy rebase**, unless the branch contains a large coherent stack that must be preserved intact.

This keeps the merge semantically clean — the diff means what it says, nothing more.

## Reusable rule

Add to CDD/process knowledge:

- If `git rebase` produces conflicts from unrelated history drift, stop
- Reset the branch to current main
- Cherry-pick only the commits that carry the actual change
- The goal is: merge diff = intended coherence delta, nothing else

## Follow-through

- [ ] Close #29 with exact shipped commits
- [ ] CHANGELOG/release notes mention actual fix behavior
- [ ] Capture in v3.15.2 post-release assessment
