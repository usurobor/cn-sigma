# Issue: Codify "divergence is a spec gap" as SOUL-level invariant

**Filed:** 2026-03-25
**Status:** Open
**Priority:** Next configuration mode session

## What

Add to SOUL.md (or equivalent constitutive doc):

> When two agents run the same process and don't converge, the divergence is a spec gap, not an agent bug. CLP to convergence, then patch the spec.

## Why

This is a multi-agent operating principle, not a CDD-specific rule. It governs review, design, selection, release — anything two agents touch. It sits at the same level as "met means fully met" and "code wins arguments."

## Evidence

Four instances on 2026-03-25 alone (skills, review, selection, design propagation). See `threads/adhoc/20260325-divergence-as-spec-gap.md`.

## Requires

Configuration mode with operator confirmation (SOUL.md is constitutive_self).
