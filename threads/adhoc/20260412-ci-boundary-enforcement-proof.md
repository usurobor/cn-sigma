# CI Boundary Enforcement — First Cross-Agent Proof

**Date:** 2026-04-12
**Trigger:** Alpha (Claude Code) hit T-002 dispatch boundary CI check while implementing #227

## What happened

Alpha was handed #227 (cn build → dist/ pipeline). Its `cmd_deps.go` imported `path/filepath` and `pkgbuild` directly in the CLI layer. CI failed with:

```
❌ Dispatch boundary violation (INVARIANTS.md T-002, eng/go §2.18)
```

Alpha had never seen T-002, eng/go §2.18, or the dispatch boundary rule. It read the CI error, identified the violation, and started moving the filepath logic into the domain layer. No human intervention. No review comment. No LLM call in CI.

## The mechanism

A 4-line grep in `.github/workflows/ci.yml`:
- For every `cmd_*.go` in `internal/cli/`
- Check if any heavy stdlib imports appear (`os`, `net/http`, `path/filepath`, etc.)
- If yes, fail with a named violation referencing the invariant

Cost: ~0. No AST, no LLM, no special tooling.

## Why this matters

This is the first time a mechanicalized invariant enforced an architectural boundary on a different agent that didn't know the rule existed.

The contrast with the same session is sharp:
- **T-002 (dispatch boundary):** principle + mechanism → caught the violation mechanically, agent self-corrected
- **Issue consistency (§2.6 first attempt):** principle without mechanism → contradictions shipped, caught only by human review

Same session, same agent system, opposite outcomes. The difference is whether the rule has a mechanism or is just a remembered principle.

## Pattern confirmed

From SOUL.md §2.2 / 20260410 daily reflection:
> Prevention > detection. Rules where the implementer reads them (CI enforcement) > rules only in review docs.

This is now proven across agent boundaries, not just in theory.

## What to watch for

- More invariants that could become CI checks (grep-level or slightly above)
- The temptation to add invariants as doc-only rules when a cheap mechanism exists
- T-002 only checks import lines — a `cmd_*.go` could still violate the boundary by calling a domain function that returns an `os.File`. AST-level checking is future hardening, not current need.
