# SOUL as Agent Type

**Date:** 2026-04-28 (reframed same day)
**Issue:** #284
**Status:** Rewritten. Original framing (SOUL as CTB module) was wrong.

## The reframe

The SOUL is not a module. Not a skill. Not a callable. Not something you dispatch.

The SOUL is a **type constraint** on the agent — the typeclass definition (Haskell), the behaviour spec (Erlang), the typing context Γ (process calculi).

### Why "module" was wrong

The original framing tried to add frontmatter to SOUL.md as if it were a module with inputs/outputs/scope. But:
- You don't dispatch a SOUL
- It has no inputs/outputs
- It doesn't transform anything
- It applies to ALL dispatches, not one

### Why "type" is right

| What the SOUL does | Module? | Type? |
|---|---|---|
| Defines operations (observe, identify, execute, verify) | ❌ Modules are dispatched | ✅ Typeclasses define required operations |
| Defines laws (invariants) | ❌ Modules don't carry laws | ✅ Typeclass laws constrain all instances |
| Applies across all nested dispatches | ❌ Modules have local scope | ✅ Type constraints propagate through the stack |
| Has instances (cn-sigma, cn-pi) | ❌ Modules are instantiated by dispatch | ✅ Types are instantiated by declaration |
| Changes only through explicit protocol | ❌ Modules are stateless | ✅ Types don't change at runtime |

### The structure

**SOUL template** = typeclass definition (operations + laws + required bindings)
**Concrete SOUL** = typeclass instance (binds operations to specific behaviour)

## Connection to #277

Still complementary:
- #277 = SOUL content (UIE-V loop, what the laws say)
- #284 = SOUL form (type declaration, how it's expressed)

## What to watch

- LANGUAGE-SPEC v0.2 needs a new kind: `agent-type` distinct from `agent-module`
- How type constraints propagate when agents compose (typeclass constraint propagation)
- Whether invariants can be checked mechanically in the future (the type-checking question)
