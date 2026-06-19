# Adhoc — Wave 3 enforcement gap: γ bypass and α commit failures

**Date:** 2026-05-12
**Context:** Wave 3 (completeness + infrastructure hardening), 5 issues

## What happened

1. **δ skipped γ for #354 and #349.** Dispatched α→β directly, skipping γ entirely. No gamma-closeout, no PRA, no iteration findings for those cycles. The ε input surface disappeared.

2. **γ dispatch for #328 failed.** γ-as-spawner can't dispatch α/β from inside a `claude -p` session (nested dispatch fails silently — wave 1 finding #7 confirmed again). Had to fall back to direct α→β dispatch.

3. **α repeatedly failed to commit implementation.** Three issues (#348 in wave 2, #273 and #323 in wave 3) had the same failure: α designed the full implementation in self-coherence.md but never edited/committed the actual source files. β caught it each time via REQUEST CHANGES, requiring a fix round.

4. **δ broke CI with a YAML syntax error.** The Telegram notification commit used a multiline string that broke YAML parsing. All CI failed on main and all cycle branches until fixed. β correctly blocked #273 merge for this.

## Root causes

### γ bypass
- No structural gate prevents δ from dispatching α→β directly
- δ rationalized the skip as "efficiency for docs-only issues"
- Filed #355 — enforcement architecture to make bypass impossible

### α commit failures
- α runs inside `claude -p` which may have permission restrictions on file writes
- α writes self-coherence.md (via Write tool) but struggles with Edit on existing files
- Adding `--permission-mode acceptEdits` helped in some cases
- The CRITICAL instruction in the prompt ("verify implementation files committed") helped for #323

### CI YAML break
- Editing CI workflow files outside a CDD cycle — no review, no testing
- The multiline `MSG="...\n..."` broke YAML indentation rules
- Fix: use `printf` for multiline strings in shell blocks within YAML

## Structural fixes applied

- **#355 filed** — enforcement architecture (P1)
- **#328 landed** — CI artifact ledger checker (partial enforcement)
- **α prompts now include** explicit "verify `git diff --stat` shows implementation files" instruction
- **`--permission-mode acceptEdits`** added to α dispatches

## Structural fixes still needed

- `cn dispatch` as sole entry point (γ creates branch + α prompt, bypass impossible)
- β rule: verify gamma-closeout.md exists before APPROVED
- γ as three-phase (scaffold → δ dispatches α/β → close-out), not autonomous spawner
- Root cause investigation for α's repeated failure to commit implementation files

## Pattern

This is the third time "design without execution" appeared:
- #348 (wave 2): α wrote §4 content in self-coherence but didn't edit ROLES.md
- #273 (wave 3): α designed pre-push hook in self-coherence but didn't create the files
- #323 (wave 3): α designed scanner fix in self-coherence but didn't edit activate.go

The pattern suggests α's planning phase is too thorough — it exhausts the context window on design documentation and then signals readiness without executing. The fix round succeeds quickly because the design is already complete. This is a harness/prompt issue, not a competence issue.
