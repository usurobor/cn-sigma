# Docs reorg passes 4A–4E + path-dependency baseline

**Date:** 2026-06-26 → 2026-06-29 (events); captured 2026-07-03 (κ backfill)
**Class:** structural (docs reorganization; not pure doctrine, but path-rippling)
**Author:** Sigma at cn-sigma (κ-body); backfill capture
**Source:** PRs #509 / #511 / #513 / #520 / #522 merged across 06-26 → 06-29. Per-pass narrative recorded in `.cn-sigma/threads/activations/cnos/202606{26,27,28,29}.md`.

## Why this is captured here

Docs reorg ran as 5 sequential cycles in 4 days. Individually each PR is mechanical; collectively the path-shifts ripple across every cn-sigma cross-repo reference in OPERATOR.md, PERSONA.md, adhocs, and channel entries that cite `cnos:docs/gamma/...` paths.

Backfill capture so future Sigma has the path-shift map and the repair-action surface at one place.

## The 5 passes (sequential, merge order)

| Pass | Issue | PR | Merge | Move |
|---|---|---|---|---|
| 4A | cnos#508 | #509 | 06-28 | Path-dependency + CI-golden audit (preflight; no moves, identifies tail-bound docs) |
| 4B | cnos#510 | #511 | 06-28 | Low-risk reader-surface moves (introductions, getting-started, conceptual docs) |
| 4C | cnos#512 | #513 | 06-28 | `docs/gamma/{cdd, rules, plans, checklists}/` → `docs/development/` |
| 4E | cnos#519 | #520 | 06-29 | Architecture docs → `docs/architecture/` |
| H5 | (hygiene) | #522 | 06-29 | `docs/gamma/conventions/AGENT-ACTIVATION-LOG-v0.md` → `docs/reference/conventions/` |

Plus operator-locked H4B (06-29 `33c28f79`): 4 home destinations corrected after Sigma's inferences differed from operator intent.

(Pass 4D was reserved for higher-risk golden-bound docs; H5 was the eventual move for the last golden-bound piece.)

## The path-shift map (consequence for cn-sigma)

Before → after:

| Old | New |
|---|---|
| `docs/gamma/conventions/AGENT-ACTIVATION-LOG-v0.md` | `docs/reference/conventions/AGENT-ACTIVATION-LOG-v0.md` |
| `docs/gamma/cdd/*` | `docs/development/cdd/*` |
| `docs/gamma/rules/*` | `docs/development/rules/*` |
| `docs/gamma/plans/*` | `docs/development/plans/*` |
| `docs/gamma/checklists/*` | `docs/development/checklists/*` |
| `docs/gamma/essays/*` (was at `docs/alpha/essays/` originally) | `docs/papers/*` (per 06-27 PR #507 src/ citation repointing) |
| Architecture-related docs | `docs/architecture/*` |
| 4 specific files at operator-locked destinations (per H4B) | per operator's 06-29 lock |

Old paths kept as `# Moved` stubs at original locations during the rollout. Most rollback windows have now closed; future references should use new paths only.

## Why the structure shifted

Prior structure mirrored CDD role layers (alpha/beta/gamma/delta as top-level doc directories). That confused readers — those are *agent role* labels, not *document audience* labels. The new structure splits by audience and purpose:

- `docs/development/` — for contributors developing inside the framework
- `docs/architecture/` — for readers learning system shape
- `docs/papers/` — for essays and external-publication material
- `docs/reference/` — for canonical specs and conventions

Reader navigates by what they want to do, not by which role wrote the doc.

## Reader-surface improvement, not protocol break

Important boundary: the reorg moves *reader-surface* docs. It does NOT touch:

- Skill files at `src/packages/*/skills/`
- Goldens at the renderer pipeline
- Schemas at `cn.*.v*` registries

The protocol surface kept its paths; the doc surface restructured. That's why no breaking-change directive was needed for cn-sigma or bumpt — the binding paths held.

## Companion: H1–H5 repo hygiene

The reorg ran in parallel with a hygiene wave (H0–H5; see `20260629-repo-hygiene-h1-h5-ocaml-archive.md`). The two are intentionally separate: docs reorg moves *content*; hygiene removes *legacy/dead*. They share a window but not a scope.

## Repair actions for cn-sigma

To carry the path-shifts forward:

- **OPERATOR.md** § Activation logs — references `cnos:docs/gamma/conventions/AGENT-ACTIVATION-LOG-v0.md` (multiple). Repoint to `cnos:docs/reference/conventions/AGENT-ACTIVATION-LOG-v0.md`.
- **PERSONA.md** — cross-refs to `cnos:docs/gamma/essays/...` if present. Repoint to `cnos:docs/papers/...`.
- **Recent adhocs** — any reference to `cnos:docs/gamma/...` paths. Audit and update; old paths still resolve via stubs but new writes should use new paths.

These repairs are κ-side maintenance; standalone cycle is overkill. Likely batched as one channel-entry-paired κ-translate when there's a wake to absorb it.

## Related artifacts

- **PRs #509 / #511 / #513 / #520 / #522 at cnos** — the merges.
- **PR #507 at cnos** (06-27) — src/ essay citations repointed to `docs/papers/`; precursor.
- **cn-sigma:.cn-sigma/threads/activations/cnos/202606{26,27,28,29}.md** — per-day channel narratives.
- **cn-sigma:.cn-sigma/threads/adhoc/20260629-repo-hygiene-h1-h5-ocaml-archive.md** — companion hygiene wave (forthcoming this backfill).
- **cnos#516** — dispatch re-claim ignores bounce contract (open blocker noted during this window).
