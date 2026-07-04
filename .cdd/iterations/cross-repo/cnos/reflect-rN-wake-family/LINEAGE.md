# Cross-Repo Lineage: cn-sigma → cnos (reflect-rN-wake-family, Sub 2 of foundation-completion-wave)

## Source

- **Repo:** `usurobor/cn-sigma`
- **Branch:** `main`
- **Path:** `.cdd/iterations/cross-repo/cnos/reflect-rN-wake-family/`
- **Filing kind:** design-and-build cell (sub of foundation-completion-wave master).
- **Sub position:** Sub 2 of foundation-completion-wave.

## Upstream — what drives this proposal

This bundle **supersedes** an earlier lightweight directive-out that filed the same intent in the wrong shape:

- `cn-sigma:.cn-sigma/threads/activations/cnos/20260630.md` (2026-06-30 19:00Z) — directive-out labeled "agent-memory-wakes" issued to Sigma-at-cnos with the full issue body embedded inline.

That directive-out was heavier than the directive-out format is intended for. Per `cn-sigma:.cn-sigma/threads/adhoc/20260703-cross-repo-bundle-pattern.md`, substantive multi-paragraph cross-repo proposals belong as bundles at `.cdd/iterations/cross-repo/<target>/<slug>/`, not embedded in channel entries. Directive-out is reserved for lightweight signals.

This bundle is the correct-shape version. The 06-30 directive-out remains in the channel record as history but is subsumed.

## Target

- **Repo:** `usurobor/cnos`
- **Package:** `cnos.core` (agent-admin surface owner + memory-role owner per cnos#467 architecture).
- **Skill paths:**
  - `src/packages/cnos.core/orchestrators/agent-reflect-{daily,weekly,halfyearly}/`
  - `src/packages/cnos.core/skills/agent/reflect-r{1,2,5}/`
- **Schema surface:** `cnos:schemas/skill.cue #Wake.role` enum extension.
- **Suggested labels:** `P1`, `area/agent`, `area/coherence`, `area/wake`, `kind/feature`, `protocol:cds`.

## Bilateral trace

When cnos accepts:
- cnos-side mirror expected at `cnos:.cdd/iterations/cross-repo/cn-sigma/reflect-rN-wake-family/`.
- STATUS advances via ledger events.

## Sub relationship to master

Parent master: `foundation-completion-wave`.
Sub position: 2 of 3.
Filed in parallel with master + Sub 1 + Sub 3 per operator directive.

Dependence rationale:
- **Schema extension** (AC1) is fully independent of cohere landing. `#Wake.role` enum can grow to include `memory` at any time.
- **Wake provider rendering** (AC5) depends on `cn install-wake` renderer extension. γ may split renderer patch into a preceding cell.
- **Task-skill body** semantics depend on cnos#444 cohere landing. Sub 2 ships stub v0.1 bodies referencing cohere (b-lite pattern per OPERATOR.md §2). Full body completion is a post-cohere follow-on.
- **First fire** (AC closure item 3) requires the cn-sigma-side workflow to be installed and cron to fire. This is inherent latency, not a design dependency.

Therefore Sub 2 is design-lockable now, mergeable when γ resolves the renderer-patch scope question, and observable-in-production when cn-sigma installs the rendered workflows.

## Sub 2 does NOT depend on

- Sub 1 (kappa-session-preflight) — preflight consumes existing state; reflect wakes produce new state. Different directions.
- Sub 3 (human-touchpoint-protocol-wave) — human-touchpoint consumes state observation from FSM Phase 2; reflect produces memory compaction. Different consumers.
- cnos#524 W2/W3/W4 — W1 (schema shipped) is all Sub 2 needs. W2+ is the renderer flip; Sub 2 uses the current renderer per AC5.

## Sub 2 DOES depend on

- cnos#524 W1 (shipped) — for the `#Wake` schema this sub extends.
- cycle/476 renderer (shipped as cnos#477) — for `cn install-wake` pipeline this sub uses.
- cnos#444 cohere landing — for full task-skill body semantics (b-lite deferrable).
- Operator dispatch of this sub — for γ to scaffold.
