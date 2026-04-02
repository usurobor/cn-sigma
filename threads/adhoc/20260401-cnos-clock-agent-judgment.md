# cnos Owns the Clock, Agent Owns Judgment

**Date:** 2026-04-01
**Trigger:** CDD steps repeatedly skipped because agent is both scheduler and worker.

## Observation

Every CDD failure this session had the same shape: the agent decided to skip a step because it seemed unnecessary in the moment. No external enforcer prevented it.

- No branch → pushed to main
- No skill load → wrote changelog without writing skill
- No gate → tagged before CI green
- No trace → no evidence of what was loaded or decided

## Architecture principle

cnos should drive the CDD lifecycle mechanically. The agent gets invoked at judgment points only.

| Concern | Owner |
|---------|-------|
| Branch creation, gate checks, trace validation, version stamping, commit/tag/push | cnos (clock) |
| Gap naming, mode choice, design, TSC scoring, stop/continue | agent (judgment) |

## Consequence

CDD skills become specs for OCaml code. The skills define what "correct" means. The code enforces it. The agent can't skip steps because it doesn't control the sequence.

This is the L7 move in #94.
