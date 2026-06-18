# v3.24.0 — Template Distribution via Package System

## Context

PR #129 (supersedes #128). Issue #119 (P0). Branch: `claude/3.24.0-119-setup-templates`.

## What shipped

Templates as 6th content class in the package system. `cn init` and `cn setup` read SOUL.md/USER.md from installed cnos.core templates instead of hardcoded inline stubs.

Key pieces:
- `source_decl.templates` field in `cn_build.ml` — follows mindsets copy mode (individual file)
- `read_template` in `cn_system.ml` — Result-typed, 3-case: Ok / not installed / not found
- `run_init` reordered: `setup_assets` before `read_template` (ensures package installed first)
- `run_setup` populates missing `spec/` files from templates, never overwrites operator content
- PACKAGE-SYSTEM.md — architecture doc with content class taxonomy, pipeline, explicit-vs-generic rationale
- 11 new tests (7 build + 4 e2e regression)

## Review

- R1: 1 D-level mechanical finding (stale cross-ref `src/agent/SOUL.md` in SETUP-INSTALLER.md)
- R2: Fixed, rebased onto 3.23.0, approved
- Unicode hygiene patch shipped in-band (review skill §2.1.3, checklist P2.9)

## Level assessment

L7 — templates as content class extends the package platform. Future template distribution reuses existing infrastructure with zero new code. Explicit-vs-generic model documented with sunset threshold.

## Process notes

- PR #128 superseded due to non-compliant branch name (Claude Code)
- Branch forked before 3.23.0, required rebase between R1/R2
- 3.23.0 post-release assessment missing — §9.11 gate not enforced
- Also created eng-level-backprop-prompt.md (analysis prompt for Claude to classify all 40 changelog releases by engineering level)
