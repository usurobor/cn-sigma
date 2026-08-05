# Agent Composition Operators

**Date:** 2026-04-28
**Status:** Active. Captured in SEMANTICS-NOTES §14, issue #285.

## The question

How do agents compose practically? FP composes functions with operators (`>>`, `>>=`, `|||`, etc.). We need the same.

## The operator set

| Op | FP | Agent meaning |
|---|---|---|
| `>>` | sequence | Do A then B |
| `>>=` | bind | A's result feeds B |
| `\|\|\|` | parallel | Concurrent, scoped isolation |
| `case` | match | Branch on return |
| `fix` | iterate | Loop until condition |
| `wait` | join | Block on parallel signal |
| `try` | catch | Handle failure |

## CDD as one expression

```
cdd-cycle =
  γ.observe >> γ.select >> γ.issue
  >> (α ||| β)
  >>= γ.triage >> γ.close
```

~300 lines of prose algorithms → one composition expression + operator definitions.

## Key insight

LANGUAGE-SPEC v0.2 §6 says "composition is explicit invocation" but doesn't name the operators. `calls` declares WHAT you can dispatch; the operators declare HOW dispatches combine. The operators are the function body. Without them, agents have signatures but no bodies.
