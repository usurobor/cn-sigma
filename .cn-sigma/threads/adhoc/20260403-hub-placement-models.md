---
title: Hub placement models — design + plan shipped
date: 2026-04-03
status: active
relates_to: ["#156"]
---

## What happened

Operator provided full design doc for hub placement models. Core reframe: #156 is not "git submodule support" — it's "split hub_root from workspace_root."

## Design decisions

- **Two explicit roots**: `hub_root` (state/threads/spec/vendor) and `workspace_root` (project source tree)
- **Standalone mode**: current behavior, roots collapse to same directory
- **Attached mode**: roots are distinct, hub mounted inside workspace
- **Nested clone as default backend**: independent history, no parent-repo gitlink churn, better for high-churn hub state
- **Submodule as optional backend**: useful when parent repo wants to pin hub checkout
- **Placement manifest** (`.cn/placement.json`): local placement truth, only file project repo should track
- `.cn/hub/` should be gitignored by project

## Artifacts produced

- Design: `docs/alpha/HUB-PLACEMENT-MODELS.md`
- Plan: `docs/gamma/cdd/3.33.0/PLAN-hub-placement-models.md` (10 steps)
- Issue #156 updated with full body

## Submodule pushback assessment

Submodule wrong as default because hubs are high-churn. Parent repo `git status` dirty constantly. Root split is the real architecture; backends are implementation details behind the placement abstraction.

## What to watch

- Implementation sequencing: placement manifest + resolver first, then hub discovery refactor, then executor root split
- Risk: scattered `hub_root` assumptions throughout current codebase — audit needed during step 3
- Nested clone `.cn/hub/` must be in project `.gitignore`
