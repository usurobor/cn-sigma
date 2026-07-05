# Sub 1: canonical WakeBackend contract + schema projection

**Parent:** `wake-substrate-provider-boundary` master (execution decomposition of cnos#452).
**Filing kind:** design-and-build cell.
**Mode:** design-and-build. (MCA not eligible: no stable `DESIGN.md`/`PLAN.md` committed yet.)
**Gate:** dispatch only after Sub 0's verified status table attaches to #452.
**Suggested labels:** `P2`, `area/agent`, `area/cds`, `protocol:cds`.

## Problem

**Exists:** wake execution is Claude-action-specific; there is no interface a second backend could satisfy, and no normalized terminal-report semantics across backends.

**Expected:** a stable `WakeBackend` contract exists — a common executor interface + terminal-report schema + discipline-failure + fallback semantics — projected through the `cn.wake-provider.v1` rendering so backend selection is config, not a workflow edit. claude-code remains the only production backend.

**Divergence:** the volatile decision (which model/vendor) is currently baked into the substrate encoding; there is no stable seam to hide it behind.

## Impact

- Turns repeated "try another backend" workflow edits into a contract/config extension point (`evolve`-skill: workarounds → extension points, invariants strengthened, future changes cheaper).
- Establishes the seam every later sub (continuity, executor, canary) plugs into. Without it they have no shared contract.

## Status truth

- Depends on Sub 0's verified table (workflow schema, action lock).
- No backend contract exists today; this sub creates it.
- openai-compat remains non-production until Sub 3/4.

## Source of truth

| Artifact | Path |
|---|---|
| Wake-provider schema | `cnos:` `cn.wake-provider.v1` (rendered in `cnos-agent-admin.yml` / `cnos-cds-dispatch.yml`) |
| Parent boundary | master `ISSUE.md` "Pristine architecture target" + "Terminal-report contract" |
| Eng skills | `cnos.eng` `design`, `evolve` |

## Scope

**In:** define backend contract types; define backend selection config; project backend selection through wake-provider schema/rendering; keep claude-code the only production backend.
**Out (non-goals):** no production cutover; no self-hosted deploy; no fine-tuning; no vendor-specific behavior leaking into package wake providers; no openai-compat production authority.

## Terminal-report semantics (the contract's core invariant)

Every backend MUST resolve to exactly one of:
`success` · `rejected_by_policy` · `substrate_discipline_failed` · `degraded_fallback_used` · `executor_error` · `validation_failed`.

## Acceptance criteria

- **AC1 — backend contract types exist.**
  - invariant: a single interface defines executor entry + terminal-report enum + fallback semantics.
  - oracle: type/schema file present; enum matches the six states exactly.
  - positive: claude-code adapter type-checks against it.
  - negative: a backend that returns an out-of-enum terminal state fails validation.
  - surface: contract schema file + package build.
- **AC2 — selection config projects through wake-provider rendering.**
  - invariant: backend choice is expressible in the provider declaration and flows to the rendered workflow as metadata.
  - oracle: render a provider with explicit backend → workflow carries backend metadata.
  - positive: default (unspecified) renders claude-code, unchanged.
  - negative: an unknown backend id fails render with a typed error, not a silent default.
  - surface: rendered workflow + renderer test.
- **AC3 — authority boundary preserved.**
  - invariant: package prompt authority does not leak into substrate encoding, and backend metadata does not alter role/prompt/triggers/permissions/secrets.
  - oracle: golden diff of a rendered Claude workflow before/after = only added backend metadata.
  - positive: diff shows metadata-only delta.
  - negative: any change to permissions/concurrency/secret names → AC fails.
  - surface: golden render diff.
- **AC4 — production backend set unchanged.**
  - invariant: claude-code is the only backend eligible for production; openai-compat is declarable but non-production.
  - oracle: selection policy rejects openai-compat for production wakes.
  - positive: openai-compat selectable only under a canary/non-production flag.
  - negative: openai-compat rendered into a production wake → policy rejects.
  - surface: selection-policy test.

## Proof plan

- oracle: package build + renderer golden diffs + selection-policy tests.
- positive: claude-code satisfies the contract; default render unchanged.
- negative: out-of-enum terminal state; unknown backend id; openai-compat-in-production.
- operator-visible: backend metadata appears in rendered workflow.
- known gap: contract validated against claude-code only until Sub 3 supplies an openai-compat implementation.

## Non-goals

- No executor implementation for openai-compat (Sub 3).
- No behavior change to Claude execution (Sub 2 proves continuity).
- No canary (Sub 4).
