# Go Skill Convergence Thread

**Date:** 2026-04-09
**Status:** converged at `38dfb53`

## What happened

Built the `eng/go` skill from scratch through 4 iterations in one session.

### v1 — base Go craft
Package boundaries, concrete types, consumer-owned interfaces, context flow, error wrapping with `errors.Is`/`errors.As`, side-effect boundaries (adapter injection), concurrency discipline, table-driven testing, boring builds.

### v2 — cnos-specific systems rules
Added 5 new sections: schema/compatibility (manifests as public contracts), determinism/reproducibility (stable ordering, canonical serialization), idempotence/retry safety (atomic writes, interruption handling), traceability/receipts (structured state for doctor/status/contract), cnos runtime boundaries (commands/orchestrators/extensions/skills stay separate, kernel stays minimal, mechanical first). Also: shell/archive safety, override precedence.

### v3 — resource lifecycles + observability
`defer` bonded to acquisition (files, HTTP bodies, locks). `log/slog` for structured queryable state instead of opaque `fmt.Printf`. Both added to failure modes, rules, smell list, and verify checklist.

### v4 — convergence
Rule numbering fixed (was out of order). Katas completed per meta-skill contract (added Inputs + Reflection sections). Trailing Reasoning appendix removed — skill demonstrates its own formula.

## Packaging fix
Initially placed in `packages/cnos.core/skills/eng/go/` — wrong. `eng/*` skills belong in `cnos.eng`. Moved at `d1badee`, manifest updated. CI drift check was failing on v2/v3 commits because of this.

## Key design choices
- **Struct injection over globals** — `init()` and package-level mutable state explicitly banned
- **`errors.Is`/`errors.As` mandated** — not just `%w` wrapping but programmatic inspection for fallback logic
- **"Mechanical first, semantic second"** — kernel resolves, validates, registers, dispatches, enforces policy. No hidden interpretation.
- **`log/slog` not `log.Printf`** — structured key-value attributes tied to `context.Context`
- **Katas mirror real cnos work** — package restore over HTTP, runtime contract extraction

## What to watch
- When the Go rewrite (#192) starts, this skill is the governing constraint
- The skill should be loaded and read before any Go code is written or reviewed
- If new failure classes emerge during the rewrite, patch the skill (same CDD self-learning loop as the review skill)
