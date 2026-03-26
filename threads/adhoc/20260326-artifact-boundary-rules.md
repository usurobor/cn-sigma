# Artifact Boundary Rules — Learning from Package-System Work

**Date:** 2026-03-26
**Evidence:** Package-system design→plan→issue pipeline

## What happened

The package-system work produced the same 7 gaps restated 4 times:
1. Code review (original analysis)
2. #113 issue body v1
3. PLAN-package-system.md §0
4. #113 issue body v2 (Claude's expanded version)

Each artifact re-derived the gap instead of pointing to one source.

## Root cause

CDD skills (design, plan, issue) didn't specify what each artifact *owns* vs what it should *reference*. Without explicit boundaries, each artifact tried to be self-contained, duplicating everything.

## Fix

Added artifact boundary rules to all three CDD skills:

| Artifact | Owns | References |
|----------|------|------------|
| Design | gap, constraints, proposal, impact graph, ACs | issue, plan |
| Plan | step order, per-step ACs, file changes, test strategy | design (for gap) |
| Issue | problem summary (3-5 lines), outcome ACs, priority, scope | design, plan |

Key rule: **reference, don't restate**. If another artifact already says it, link to it.

## Also done

- CDD skills consolidated under `skills/cdd/` (were scattered across eng/, pm/, ops/, release/)
- Plan skill created (was missing entirely)
- Issue skill rewritten to meta-skill pattern
- All CDD skills moved to cnos.core package (CDD is core process)

## Durable principle

Every artifact in a pipeline should have explicit ownership boundaries. Without them, duplication is the default because each generator tries to make its output self-contained.
