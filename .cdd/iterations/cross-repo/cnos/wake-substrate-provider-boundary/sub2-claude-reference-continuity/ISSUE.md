# Sub 2: Claude reference-backend continuity

**Parent:** `wake-substrate-provider-boundary` master (execution decomposition of cnos#452).
**Filing kind:** design-and-build cell.
**Mode:** design-and-build.
**Gate:** dispatch only after Sub 1 contract is frozen.
**Suggested labels:** `P2`, `area/agent`, `area/cds`, `protocol:cds`.

## Problem

**Exists:** current Claude execution runs directly against `claude-code-action`, outside any backend boundary.

**Expected:** current Claude execution is routed *through* the Sub 1 `WakeBackend` contract as the reference backend, with provably zero production behavior change — same permissions, concurrency, secrets, bot identity; terminal reports normalized through the contract.

**Divergence:** until Claude runs through the boundary, the boundary is untested against real production traffic and the migration risk is unmeasured.

## Impact

- Protects the working substrate: the boundary must not become the thing that breaks admin/dispatch wakes.
- Gives β a clean review surface — *same behavior, new boundary* — the cheapest possible diff to verify.

## Status truth

- Depends on Sub 1 contract (types + selection projection).
- claude-code adapter is the reference backend; it is the only production backend through this sub.

## Source of truth

| Artifact | Path |
|---|---|
| Backend contract | Sub 1 output |
| Live wakes | `cnos:.github/workflows/cnos-agent-admin.yml`, `cnos-cds-dispatch.yml` |
| Golden renders | cnos wake-provider golden fixtures |

## Scope

**In:** claude-code adapter as reference backend; generated workflows behaviorally equivalent; existing permissions/concurrency/secrets unchanged; terminal reports normalized through the contract; backend choice operator-visible; fallback/degraded states visible not silent.
**Out (non-goals):** no openai-compat routing; no new permissions; no default-backend change; no canary.

## Acceptance criteria

- **AC1 — golden render diff proves no unintended drift.**
  - invariant: rendering admin + dispatch wakes through the claude-code adapter differs from pre-boundary goldens only by explicit backend metadata.
  - oracle: golden diff.
  - positive: metadata-only delta.
  - negative: any change to triggers/permissions/concurrency/secret names/identity → AC fails.
  - surface: golden fixtures diff in CI.
- **AC2 — existing wake paths still render and execute.**
  - invariant: `cnos-agent-admin.yml` and `cnos-cds-dispatch.yml` render valid, executable workflows through the adapter.
  - oracle: render + workflow-lint; live wake dry-run if available.
  - positive: both render and pass lint.
  - negative: a render error or invalid workflow → AC fails.
  - surface: CI render/lint job.
- **AC3 — backend choice operator-visible.**
  - invariant: the rendered workflow and terminal report both name the backend used.
  - oracle: grep rendered workflow + terminal report for backend id.
  - positive: `claude-code` visible in both.
  - negative: backend absent from either → AC fails.
  - surface: rendered workflow + terminal report artifact.
- **AC4 — fallback/degraded states visible, not silent.**
  - invariant: a claude-code failure resolves to a typed terminal state (`substrate_discipline_failed` / `executor_error`), never a silent pass.
  - oracle: fault-injection fixture forcing a claude-code failure.
  - positive: typed terminal state emitted with reason.
  - negative: failure yields `success` or empty report → AC fails.
  - surface: terminal-report fixture test.

## Proof plan

- oracle: golden render diffs + render/lint job + claude-code failure fixture.
- positive: metadata-only diff; both wakes render; backend visible; failure typed.
- negative: any non-metadata workflow drift; silent failure.
- operator-visible: backend id in rendered workflow and terminal report.
- known gap: real execution equivalence beyond render is bounded by whether a live wake dry-run is available in CI.

## Non-goals

- No non-Claude execution.
- No contract changes (Sub 1 owns the contract).
- No selection-policy expansion beyond claude-code.
