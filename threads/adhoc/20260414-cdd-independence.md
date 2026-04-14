# CDD is Independent of cnos

**Date:** 2026-04-14

## Decision

CDD artifacts live in `.cdd/` at repo root, not `.cn/cdd/`.

## Why

CDD is a development practice. It doesn't require cnos, a hub, or an agent runtime. Any git repo can adopt it: add `.cdd/`, commit review findings, track identity per role.

Coupling CDD to `.cn/` means you can't use CDD without adopting cnos. `.cdd/` is self-contained.

## Structure

```
.cdd/
  3.54.0/
    gamma/       ← coordinator artifacts (issue, dispatch prompts)
    alpha/       ← implementer artifacts (self-coherence)
    beta/        ← reviewer artifacts (review findings, assessment)
```

Git author on each file matches the dir. The dir structure is the audit trail.

## Implication

- `cn cdd run` (#240) orchestrates the `.cdd/` workflow but isn't required for it
- Identity switching (#241) automates `git config` but manual switching works too
- The git/gh split (#242) follows naturally: git is the practice, forge is infrastructure

CDD stands alone. cnos makes it easier.
