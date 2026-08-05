# GitHub as rendering surface, not authority

**Date:** 2026-03-25
**Context:** PR #107 review revealed that GH Issues are the only authoritative state living on GitHub. Everything else (repo, commits, CI, PR diffs) is already substrate-first, GH-rendered.

## Observation

GitHub's role in cnos:
- **Render:** commits, diffs, PRs, markdown preview, CI runs
- **Authoritative (today):** issues — this is the exception
- **Should be:** fully read-only rendering surface

## Decision

- #45 (native cnos issue tracking) eliminates the last authoritative dependency on GH
- Once thread-based issues land, GH holds zero primary state
- New GH issues should be avoided; track in hub adhoc threads or wait for #45
- #108 (review identity gap) closed on GH, queued in #45 migration list as first example

## Implication

Agent shouldn't need `gh` CLI for core cognitive work — only for CI triggers and PR mechanics. Observe/orient loop should work fully offline from hub threads.

## Pattern

One source of truth per fact. If the substrate is git, the authority is git. External platforms render, they don't govern.
