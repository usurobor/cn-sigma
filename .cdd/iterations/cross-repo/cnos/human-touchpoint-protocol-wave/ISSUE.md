# wave: human-touchpoint protocol — cnos.core generic + cnos.cds software overlay

**Filing mode:** master tracker (nested wave per `cnos:.cn-sigma/spec/OPERATOR.md §1`). Filed as Sub 3 of parent `foundation-completion-wave`; itself decomposes into two subs filed sequentially per §1 default.
**Sub of:** `foundation-completion-wave` master tracker.
**Suggested labels:** `P1`, `area/agent`, `area/cds`, `kind/process`, `protocol:cds`.
**cell_kind:** `wave` (per `cnos:src/packages/cnos.cdd/skills/cdd/CELL-KINDS.md`).

## Problem

**Exists:** cn-sigma walker emits one Telegram message per substantive home-channel entry. Activity-shaped. Humans need only the moments when their input is required (dispatch, approval, intervention). No protocol defines what surfaces vs stays silent.

**Expected:** Two-layer protocol. Generic transport-neutral surface at `cnos.core/agent/human-touchpoint` defining three action classes (dispatch, approve, intervene) with a typed frontmatter contract. Software-lifecycle overlay at `cnos.cds/cds/human-gates` mapping CDS states to the three action classes.

**Divergence:** Neither skill exists. Prior sessions produced multiple design iterations captured at cn-sigma but no filed protocol. Operator 2026-06-25 ruling settled the design; the ruling has not been landed as a filed issue.

## Impact

- Telegram surface remains activity-noise. Humans receive per-entry pings for events that require no action.
- Prod-push events do not receive human sign-off. cnos main pushes and product tagged releases pass through without an explicit approval gate.
- Off-path escalations (dispatch stuck; reviewer dissent; CI red repeatedly) surface only through channel-inspection, not as first-class events.

## Status truth

- Design settled at 2026-06-25 operator ruling (recorded in cn-sigma session history).
- Draft bundle authored 2026-06-30 as directive-out (`cn-sigma:.cn-sigma/threads/activations/cnos/20260630.md` 19:00Z, superseded).
- FSM Phase 1 shipped 2026-07-03 (cnos#568). FSM Phase 2 (cnos#569) in progress. Phase 2 is the state-observation surface this protocol consumes; this wave design-locks now but body implementation depends on Phase 2 landing.

## Source of truth

| Artifact | Path | Role |
|---|---|---|
| Operator ruling (2026-06-25) | Recorded in κ session; formalized here | Design authority |
| FSM Phase 1 shipped | `cnos:src/packages/cnos.cds/issues-fsm/` | Observation surface (read-only) |
| FSM Phase 2 in progress | `cnos#569` | Mutation authority (Phase 2 blocks full body) |
| Wake schema | `cnos:schemas/skill.cue #Wake` (post-cnos#524 W1) | Referenced by this protocol's authorship rule |
| κ role | `cnos:src/packages/cnos.core/skills/agent/kappa/SKILL.md` (post-cnos#501) | The role permitted to author touchpoint entries |
| Coherent LLMs essay v5 | `cn-sigma:.cn-sigma/threads/adhoc/20260703-coherent-llms-essay.md` | CM² framing this protocol instantiates |

## Scope

**In (wave-level):**

1. **Sub 3.1: cnos.core/agent/human-touchpoint** — generic transport-neutral protocol. Owns the three action classes, the frontmatter contract, the filter, the dedupe semantics (`state_ref`-based), and the boundary between touchpoints (interruptive) and summaries (non-interruptive). Does NOT own transport, software-lifecycle mapping, or per-project policy.
2. **Sub 3.2: cnos.cds/cds/human-gates** — software-lifecycle overlay. Maps CDS states (issue labels, reviewer verdicts, cycle status, release state) to the three generic action classes. Owns: dispatch mapping (`status:ready + dispatch:cell + protocol:cds` → `dispatch`); approve mapping (β-converge or `status:review` + project release-ready → `approve`, occurring *before* the production boundary executes); intervene mapping (`status:blocked`, iteration ceiling, project CI threshold → `intervene`). Owns per-project binding pointer to project's `.cds/` policy.

**Out of scope (wave-level):**

- Transport implementation. cn-sigma walker + notify-telegram.sh remain the transport for Telegram delivery; this wave does not modify them. Other transports (Slack, email, GitHub comments) are separate future work.
- Non-CDS overlays. cnos.cdr and cnos.cdw (if filed) would need their own human-gates overlays; this wave scopes to cds only.
- Per-project policy schemas. The protocol names that per-project policy exists; project-side `.cds/` config is per-project work.
- Result-summary surface (`landed` events). Separate skill, future.
- Backfill emission for existing channel entries. Only future entries carry `human_action:`.

## Wave-level acceptance criteria

**WAC1** — Sub 3.1 filed at cnos as `feat(cnos.core/agent/human-touchpoint): generic protocol` with `Refs #{this master}`.

**WAC2** — Sub 3.2 filed at cnos as `feat(cnos.cds/cds/human-gates): software-lifecycle mapping` with `Refs #{this master}`, filed after Sub 3.1 closes per §1 sequential default.

**WAC3** — Both skills validated per cnos#524 W1 cross-file check pipeline. Declared paths exist. Frontmatter conforms to `#CoherenceMethodology`-style contract (or per whatever typed-skill-module contract γ selects at scaffold time).

**WAC4** — Approval mapping (Sub 3.2 AC): approve action fires **before** the production boundary executes. Never after. Named explicitly as violation-mode-to-prevent.

**WAC5** — Authorship: only κ (per cnos#501) may write `human_action:` fields into channel entries. Enforced by mechanical guard, not just contract prose. Cross-repo write-locality preserved: home writes to home only.

**WAC6** — cn-sigma walker updates (out of scope for filing at cnos; noted here for coordination): walker filter switches from "substantive class" to "presence of `human_action`" per this protocol. That change lands at cn-sigma after Sub 3.1 defines the field.

## Sub decomposition

**Sub 3.1 slug (proposed):** `human-touchpoint-generic`
**Sub 3.1 mode:** `design-and-build`
**Sub 3.1 dependencies:** cnos#501 (κ dispatched) for authorship rule enforcement.

**Sub 3.2 slug (proposed):** `human-gates-cds-overlay`
**Sub 3.2 mode:** `design-and-build`
**Sub 3.2 dependencies:** Sub 3.1 closed (generic protocol available); cnos#569 (FSM Phase 2) shipped for reliable state observation.

**Sub-sub filing order:** Sub 3.1 → Sub 3.2 per §1 sequential default. Both are named-but-not-yet-filed at this master's landing.

## Required skills

- `cnos.cdd/skills/cdd/issue` — this filing.
- `cnos.cdd/skills/cdd/{alpha,beta,gamma,delta}` — per sub.
- `cnos.core/skills/agent/kappa` (post-cnos#501) — the role WAC5 enforces.
- `cnos.cds/skills/cds/{alpha,beta,gamma,delta}` (b-lite overlays per cycle/408/409/410 precedent) — for Sub 3.2.

## Closure condition

Wave master closes when Sub 3.1 and Sub 3.2 both merged. Post-close audit at cn-sigma verifies:

1. Walker emits per `human_action:` presence.
2. No prod-push occurs at cnos main or product tagged-release without a preceding `approve` action.
3. Off-path escalations surface as `intervene` action, not silent channel entry.

## Handoff checklist

- [ ] Wave shape confirmed: master tracker + 2 sequential subs (§1 default), not parallel. Operator override for parallel filing does NOT apply within Sub 3's internal decomposition.
- [ ] cell_kind field on this wave master = `wave` per cycle/570 taxonomy.
- [ ] Sub 3.1 named-but-not-filed at this master's landing per §1 rule (initially-proposed sub list; not binding until sub files).
- [ ] Sub 3.2 named-but-not-filed likewise.
- [ ] No new languages, no new runtimes, no new wire contracts within either sub.
- [ ] Sub 3.1 does NOT depend on Sub 3.2. Sub 3.2 depends on Sub 3.1.
- [ ] Sub 3.2 does NOT modify cnos.cdd surfaces. Overlay only at cnos.cds boundary.
- [ ] cn-sigma-side walker update coordination (WAC6) is a separate cell after Sub 3.1 lands, filed at cn-sigma (walker lives there). Not part of this wave's cnos-side scope.
- [ ] Close-state hard gate compliance per cycle/368: sub merge subjects carry `Closes #{N}`.

## Empirical anchors

- Operator ruling 2026-06-25 (session record) — design authority.
- `cn-sigma:.cn-sigma/threads/activations/cnos/20260630.md` 19:00Z directive-out — prior filing attempt; superseded by this bundle.
- `cnos#568` (FSM Phase 1, closed) — read-only observation surface.
- `cnos#569` (FSM Phase 2, in progress) — mutation authority Sub 3.2 depends on.
- `cnos#501` (κ role, status:ready) — WAC5 authorship enforcement authority.
- `cnos#524` W1 — `#Wake` schema pattern that Sub 3.1's typed contract follows.
- `cn-sigma:.cn-sigma/threads/adhoc/20260703-coherent-llms-essay.md v5 §12` — capability-vs-governance framing.
- `cn-sigma:.cn-sigma/threads/adhoc/20260703-typed-skill-modules.md` — the form each skill takes.
