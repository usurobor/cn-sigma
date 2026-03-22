# Design Amendment Before Code

**Date:** 2026-03-21
**From:** Sigma + usurobor
**Type:** engineering skill

---

## The Pattern

For architectural changes (not bug fixes), write the design document before writing code.

```
design amendment → implementation plan → tests → code → docs → release → observe
```

Not:

```
code → discover gaps → more code → docs after the fact
```

## Why It Works

The N-PASS-BIND-v3.8.0 session proved this:

1. **Amendment doc** defined: coherence gap, mode (MCA), α/β/γ targets, smallest coherent intervention, what changes and what doesn't.
2. **Implementation plan** defined: step order, module boundaries, compile-safe sequence, explicit non-goals, acceptance criteria per step.
3. **Code** implemented exactly what the plan said. No scope creep. No "while I'm here" additions.

The branch landed as 14 focused commits, 36 files, zero blocking review issues. The design docs caught the scope before code could wander.

## When To Use

- Fix cascade detected (band-aid pattern)
- Changing execution model or data flow
- Multiple modules affected
- Non-obvious tradeoffs (governance vs simplicity, etc.)

## When NOT To Use

- Single-module bug fix
- Config change
- Test addition
- Doc correction

## Structure of a Design Amendment

1. **Coherence Contract** — gap, mode (MCA/MCI), α/β/γ target, smallest intervention
2. **Core Decision** — the one architectural choice, stated clearly
3. **Relation to existing architecture** — what it sits below/above/beside
4. **Semantics** — how the new thing works
5. **Stop conditions** — when/how it terminates
6. **Backward compatibility** — old behavior as special case
7. **Acceptance criteria** — when is it done
8. **Non-goals** — what this deliberately doesn't do

## Structure of an Implementation Plan

1. **Steps in compile-safe order** — each step compiles independently
2. **Per-step acceptance** — testable condition
3. **Estimated change surface** — modules + rough LOC
4. **Explicit non-goals** (again) — prevents scope creep during implementation

## The "Non-Goals" Discipline

Listing non-goals twice (amendment + plan) is intentional. During implementation, the temptation is always "while I'm here, I could also..." The non-goals list is the fence.

In the N-pass case: no FSM rewrite, no new typed op kinds, no sink plugin framework, no in-call tool loops. Each of those was a plausible scope expansion that would have turned a focused release into a rewrite.
