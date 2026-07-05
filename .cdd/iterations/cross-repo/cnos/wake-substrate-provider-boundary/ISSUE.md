# wave: wake-substrate provider boundary — model-swappable LLM runtime

**Filing mode:** master tracker (wave shape per `cnos:src/packages/cnos.cdd/skills/cdd/issue/SKILL.md` + `cnos:.cn-sigma/spec/OPERATOR.md §1 Wave dispatch shape`).
**Relationship to existing issues:** this is the **execution decomposition of cnos#452** (`agent/wake-substrate: model-agnostic wake action with multi-backend support`), which is already enumerated as **Step 7** of `foundation-completion-wave` (#579). cnos#453 (`wake-substrate-openai-compat` executor + NIM canary) is **Step 8**, carried here as the held canary sub (Sub 4). This bundle does **not** open a competing master; #452 remains the substrate-boundary issue and this decomposition hangs beneath it.
**Suggested labels:** `P2`, `area/agent`, `area/cds`, `kind/process`, `protocol:cds`.
**Filing directive to cnos γ:** File the master reference under #452 (comment or linked tracker) first. Run **Sub 0 (status-truth reconciliation) before any α/β dispatch** — it verifies the preconditions this bundle was authored blind to. Do **not** dispatch Sub 1+ until Sub 0's live-verified status table is attached to #452. Sub 4 (canary) holds for the operator gate regardless of contract readiness.

---

## Engineering frame (L7 — named per `cnos.eng` skill "name the work shape, level, active skills")

- **work_shape:** runtime/platform boundary evolution
- **level:** L7 (system-shaping — challenges the substrate coupling, chooses the stable boundary, prices operational cost, leaves a platform that makes the next backend cheap)
- **cdd:** `cdd/issue` (this authoring), `cdd/review` at each sub's gate
- **eng:** `design`, `evolve`, `process-economics`, `performance-reliability`, `test`
- **supporting:** `code`/`tool` only after the boundary contract (Sub 1) is frozen

**Governing design principle:** *the LLM is volatile; the wake contract is stable.* Decompose so a backend replacement cannot break the contract — volatile decisions (which model, which vendor SDK, which tool-loop implementation) hidden behind a stable executor interface; dependencies point toward policy, not implementation detail.

---

## Problem

**Exists:** cnos wakes are rendered through the `cn.wake-provider.v1` / `cn install-wake` surface (e.g. `cnos-agent-admin.yml`, `cnos-cds-dispatch.yml`), which correctly splits package prompt authority from substrate encoding — but every generated workflow still invokes `anthropics/claude-code-action@v1` with a Claude model. The managed-agent substrate is load-bearing and unswappable.

**Expected:** wake execution is selected through a **stable backend contract**. Current Claude execution remains the reference backend with zero behavior change. OpenAI-compatible execution is added only through a bounded executor that owns or explicitly bounds tool policy, output validation, refusal, fallback, and terminal-report correctness — and reaches production only through an operator-gated, evidence-backed canary.

**Divergence:** rendered wake-provider workflows exist, but the backend is Claude-action-specific. Worse, the two source issues (#452/#453) predate the wake-provider/install-wake landing and reference the older wake-template path and #450 — so a raw dispatch risks building the right idea against a stale boundary. **This bundle was authored from cn-sigma (κ-body) without live cnos read access; its status claims are proposal-asserted, not verified — Sub 0 exists to close that gap before any build.**

## Impact

- **Substrate lock is a single point of vendor dependency** for all agent operation (admin + dispatch wakes). No fallback path exists if the managed agent is unavailable, repriced, or policy-changed.
- **Every "try another backend" request today is a workflow/action edit** — repeated core edits instead of a config/contract extension point (the `evolve`-skill smell: workaround pressure that should become an extension point).
- **No typed failure surface across backends.** A backend that silently degrades or gains unbounded tool authority is currently unobservable; there is no normalized terminal-report semantics to detect it.
- **Blocks the foundation wave's Steps 7–8** from proceeding on a correct boundary.

## Status truth

> **Verification posture:** the rows below are **proposal-asserted, NOT verified from this body.** Sub 0 must confirm/correct each against live cnos issue + workflow state before dispatch. Where two cn-sigma artifacts already disagree, that is recorded — not resolved.

| Claim | Asserted state | Verification status | Note |
|---|---|---|---|
| #452 substrate-boundary issue | open, still valid | **verify** | Step 7 of #579 as of 07-04 ("Queued") |
| #453 executor/canary follow-on | exists, open | **verify** | Step 8 of #579 as of 07-04 ("Queued") |
| #450 wake-template | superseded/closed *(proposal)* | **CONFLICT** | #579 status table (07-04) says `#450 — Queued`. Do not assert either; Sub 0 resolves against live state. |
| #467 wake orchestration | completed/closed | **verify** | not cross-checked from this body |
| rendered workflows use `cn.wake-provider.v1` | yes | **verify** | proposal-cited; confirm current `cnos-agent-admin.yml` / `cnos-cds-dispatch.yml` headers |
| Claude-action execution lock | present in generated workflows | **verify** | the core incoherence; confirm `anthropics/claude-code-action@v1` still the only backend |

## Source of truth

| Artifact | Path | Role |
|---|---|---|
| Substrate-boundary issue | `cnos#452` | Parent; this wave is its execution decomposition |
| Executor/canary issue | `cnos#453` | Sub 4 (held canary) source |
| Wake-provider schema | `cnos:` `cn.wake-provider.v1` (as rendered in `cnos-agent-admin.yml` / `cnos-cds-dispatch.yml`) | The authority split this wave preserves and extends |
| Foundation wave | `cnos#579` / `cn-sigma:.cdd/iterations/cross-repo/cnos/foundation-completion-wave/` | Enumerates #452/#453 as Steps 7–8 |
| Issue-contract skill | `cnos:src/packages/cnos.cdd/skills/cdd/issue/SKILL.md` | Contract schema each sub satisfies |
| Eng L7 skill bundle | `cnos:src/packages/cnos.eng/skills/eng/` | design / evolve / process-economics / performance-reliability / test |
| κ role doctrine | `cnos#501` + `cn-sigma:.cn-sigma/threads/adhoc/20260703-kappa-role-canonicalization.md` | Why κ authored this bundle and holds the filing/dispatch gate |

## Pristine architecture target

The wrong design (swaps vendor coupling only):

```
wake workflow -> Claude action
wake workflow -> OpenAI action
```

The stable boundary this wave installs:

```
Package WakeProvider      owns: role, prompt body, wake intent, allowed wake kind
Wake Renderer / Installer owns: GH Actions encoding, triggers, permissions, concurrency,
                                secret names, bot identity, generated workflow shape
Wake Backend Contract     owns: common executor interface, terminal-report schema,
                                discipline-failure semantics, fallback semantics
Backend Adapter: claude-code   owns: current managed-agent execution path (reference backend)
Backend Adapter: openai-compat owns: explicit tool loop, tool policy, output validator,
                                     refusal layer, degraded terminal reporting
Selection Policy          owns: allowed backend per wake/hub/role, cost/risk class,
                                fallback order, canary gating
Observation Layer         owns: cost, latency, failure class, fallback frequency, report evidence
```

**Key invariant boundary:** renderer is not the executor; executor is not the model; model is not the policy. Package prompt authority MUST NOT leak into substrate encoding, and vendor-specific behavior MUST NOT leak into package wake providers.

## Terminal-report contract (shared by every backend)

```
success
rejected_by_policy
substrate_discipline_failed
degraded_fallback_used
executor_error
validation_failed
```

## Scope

**In (wave-level):**
- **Sub 0** — status-truth reconciliation of #452/#453 against live cnos (κ/γ reconciliation, not an α-build cell). *Runs first; gates everything.*
- **Sub 1** — canonical `WakeBackend` contract + schema projection through wake-provider rendering. claude-code stays the only production backend.
- **Sub 2** — route current Claude execution through the new boundary with golden-diff-proven zero behavior drift.
- **Sub 3** — OpenAI-compatible executor harness: bounded tool loop, tool policy, output validator, persona-injection refusal, terminal-report adapter. Hermetic; no production write authority.
- **Sub 4** — canary + cost model + selection guide. **Held for operator gate.**

**Out of scope (non-goals):**
- No production cutover to a non-Claude backend in this wave.
- No self-hosted / NIM deployment beyond a bounded canary.
- No fine-tuning.
- No default-backend change.
- No vendor-specific behavior in package wake providers.

## Proof plan (invariant-first)

| # | Invariant | Proof |
|---|---|---|
| I1 | Backend selection never changes package wake authority | same provider declaration renders equivalent Claude workflow before/after, except explicit backend metadata |
| I2 | Every backend returns normalized terminal-report semantics | claude-code success + failure, openai-compat success fixture + invalid-output fixture + policy-refusal fixture |
| I3 | openai-compat cannot silently gain unbounded tool authority | negative tests: disallowed Bash, write outside allowed paths, persona-injection attempt, malformed terminal report |
| I4 | Fallback is explicit and observable | forced openai-compat failure → `substrate_discipline_failed` or `degraded_fallback_used`, backend + reason visible |
| I5 | Production behavior stable until canary evidence exists | generated-workflow golden diffs; no default backend switch; canary off by default / named-wake-scoped |

## Sub filing & dispatch order

| Sub | Title | Mode | Files when | Dispatch |
|---|---|---|---|---|
| 0 | issue/status-truth reconciliation | docs-only (reconciliation) | now (first) | κ/γ-at-cnos; **precondition for all** |
| 1 | canonical WakeBackend contract | design-and-build | after Sub 0 attaches verified status table | α/β under #452 |
| 2 | Claude reference-backend continuity | design-and-build | after Sub 1 contract frozen | α/β under #452 |
| 3 | OpenAI-compatible executor harness | design-and-build (hermetic) | may design in parallel with Sub 1/2 (no production surface) | α/β under #453 |
| 4 | canary + cost model + selection guide | design-and-build / explore | after Sub 3 passes + **operator gate** | held |

MCA is **not** yet valid for any sub — no `DESIGN.md`/`PLAN.md` committed at stable paths (skill precondition). Modes are docs-only / design-and-build until a sub commits a stable design+plan pair for independent review.

## Dispatch rule

- #452 execution (Sub 1+2) dispatches **only after** Sub 0's live-verified status table is attached.
- #453 executor design (Sub 3) may proceed hermetically (no production write authority) in parallel.
- **Operator gate required** before any non-Claude backend receives production write authority (Sub 4 cutover / canary-with-write).

## Closure condition

Wave closes when: Sub 0 status table verified + attached; Sub 1 contract merged; Sub 2 golden-diff proves zero Claude drift; Sub 3 executor passes I2/I3 fixtures hermetically; Sub 4 either produces bounded canary evidence + selection guide **or** is explicitly deferred by operator. No default backend change ships without I5 satisfied.
