# Kata framework refactor — mechanism vs content

**Date:** 2026-04-15

## What happened

#251 filed: move kata framework (`kata-run`, `kata-list`, `kata-judge`) from `cnos.cdd.kata` to `cnos.kata`. The framework is a cnos-wide concept; CDD katas are content that runs on it.

α flagged the architectural tension — #251 contradicts the shape just shipped in #237 (Tier 2 kata as `cnos.kata`). Two design questions surfaced:

### Q1: Where do R1-R4 runtime katas live?

Options considered:
1. **Keep in cnos.kata** (chosen) — framework dogfoods itself. R1-R4 prove the framework works. Least churn.
2. New `cnos.runtime.kata` package — cleanest separation but +1 package for no gain.
3. Delete R1-R4 — smallest surface but loses explicit runtime coverage.

### Q2: Unified `cn kata-run` or split commands?

Options considered:
1. **One unified `cn kata-run`** (chosen) — framework detects kata class from `kata.md`. `cn kata-run R1` runs binary pass/fail; `cn kata-run M1 --mode cdd` runs scored.
2. Split `kata-run` / `kata-runtime` — two commands for one concept. Rejected.

## Design

- `cnos.kata` = framework + bootstrap katas (R1-R4)
- `cnos.cdd.kata` = CDD-specific kata content (M0-gap, M4-full-cycle). No commands.
- Each domain owns its kata content; framework lives once.
- Discovery: `cn kata run` finds katas from any installed package.

## Connection

This is mechanism/content separation applied to kata — same principle as CDD protocol vs execution model (#240).
