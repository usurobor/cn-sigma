# Agents Through the FP Prism

**Date:** 2026-04-28
**Status:** Active. Feed into SEMANTICS-NOTES update.

## The observation

The agent composition problem is the same problem FP solved: how to compose pure transformations when the real world has state, effects, and sequencing. The answer is the same: state within scope, effects as data, composition by dispatch.

v0.1 made the classic pre-monadic mistake: "skills are pure with no state." Practice immediately needed state (role loops, memory, coordination). The fix isn't "allow impurity" — it's the FP fix: reify effects, scope state, keep composition explicit.

## The mapping

| FP | Agent |
|---|---|
| Pure function | Narrow agent (inputs → effect plan) |
| Monad / effect system | Agent loop (UIE-V) — sequences effects within scoped state |
| IO monad | Runtime bridge — executes plans with capability grants |
| Algebraic effects | `calls` / `calls_dynamic` — declared effect vocabulary |
| Closure / captured env | SOUL — activation context carried into nested dispatch |
| Higher-order function | Agent dispatching subagents (γ → α/β) |
| Referential transparency | Same inputs → same plan |
| Type class / trait | Global aspect — cross-cutting constraint, one owner |
| Module / functor | Agent-as-module with signature |
| Scope / lifetime / region | `task-local` / `role-local` / `global` |
| do-notation | UIE-V loop: each step yields a plan, loop binds them |

## Key concepts to name in SEMANTICS-NOTES

1. **Effect plans are monadic** — agent returns `Plan a`, not `a`
2. **Agent loops are do-notation** — UIE-V is sequencing in the effect monad
3. **Scope is region-based** — task-local = stack frame, role-local = region, global = process. State cannot escape its region.
4. **Composition is function application** — `calls` is the type signature, dispatch is application
5. **The SOUL is a closure** — captured environment threaded through every nested dispatch
6. **Global aspects are type classes** — cross-cutting constraints resolved at the package level, not per-agent

## Why this matters

It's not analogy — it's the same structure discovered independently through practice. Naming the correspondence:
- Gives implementers a known design space to draw from
- Prevents re-inventing solutions that already exist (effect systems, region types, module functors)
- Makes the spec's constraints feel inevitable rather than arbitrary
