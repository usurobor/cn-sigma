# Delegated Implementation Handoff Gap

**Date:** 2026-04-07
**Issue:** #167
**Fix:** CDD §2.5a added

## What happened

Delegated #167 implementation to Claude Code. Wrote a detailed feature spec prompt (what to build, file changes, constraints, ACs). CI eventually passed. But review found:

1. **6 bare `with _ -> []` catches** — v3.32.0 explicitly removed these. OCaml skill §3.1 prohibits them. Reintroduced because Claude Code didn't know about either.
2. **Zero tests for cn_command.ml** — 248-line module with discovery, dispatch, and validation logic. CDD §2.5 says tests before code.
3. **Zero tests for HTTP restore path** — the core new functionality untested.
4. **Empty commands object** — schema-only, no built-ins actually moved.

## Root cause

The prompt described *what to build* but not *how the project constrains building it*. The implementer had no access to:
- Active skills (OCaml skill conventions)
- Prior cycle learnings (v3.32.0 audit)
- Test requirements per module
- CDD artifact order (tests before code)

## Fix (MCA)

Added CDD §2.5a: delegated implementation handoff protocol. Four mechanical requirements:
1. Active skills by name + file location
2. Test requirements per module
3. Engineering conventions from prior cycles
4. Artifact order (tests-before-code or explicit justification for inversion)

## MCI

The failure pattern: I treated the prompt as a feature spec when it was actually the CDD contract. A feature spec says what; a CDD contract says what + how + with what constraints. When the implementer is in a different context (different agent, no session history), the contract must carry the full constraint set.

## What to watch for

- Every future delegation: check §2.5a before sending
- This is the same pattern as "fix at the right level" (arch-evolution §5.1) — the gap wasn't in Claude Code's implementation, it was in the interface I provided
