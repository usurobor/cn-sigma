# wave: foundation-completion — unblock v3.83.0, mechanize κ discipline, install release-surface governance

**Filing mode:** master tracker (wave shape per `cnos:src/packages/cnos.cdd/skills/cdd/issue/SKILL.md` + `cnos:.cn-sigma/spec/OPERATOR.md §1 Wave dispatch shape`).
**Suggested labels:** `P1`, `area/cdd`, `area/cds`, `area/agent`, `kind/process`.
**Filing directive to cnos γ:** File this master first. Assign wave cycle number on intake. Do NOT dispatch sub-issues from this bundle — subs file incrementally per §1, first sub authored simultaneously via `cn-sigma:.cdd/iterations/cross-repo/cnos/kappa-session-preflight/`.

## Problem

**Exists:** Substrate-evolution work at cnos accelerated sharply across 06-24 → 07-03. Cycles compose into designed waves at cadence (cycle/368 + cycle/568 + cycle/570 landing in 2h10m on 07-03 as one CDS-machinery wave). FSM Phase 1 shipped. Cell-kind taxonomy codified. `#Wake` typed-skill-module contract at cnos#524 W1 merged.

**Expected:** Governance surfaces evolve at parity with substrate. Reflect skill ships as part of cnos#444 cohere. κ role (cnos#501) enforced at wake-load time. Human-touchpoint protocol filed. v3.83.0 tagged. State files wake-maintained. Session-resume discipline gated mechanically.

**Divergence:** Foundation wave Step 4 (cnos#449 + cnos#454) β-pending since 06-20 — 14 days. cnos#444 cohere held per D14. cnos#501 status:ready but not dispatched. v3.83.0 not shipped. Reflect skill not implemented. Human-touchpoint protocol drafted at cn-sigma but not filed at cnos. κ-CDD-preflight named as doctrine (`cn-sigma:20260703-discipline-failures-become-typed-gates.md`) but not shipped.

## Impact

- **Compounding memory cost:** every cycle that ships adds to what cohere will compact. r0 backlog since v3.82.0 grows daily.
- **Discipline slippage:** κ has exhibited 5 named-doctrine-doesn't-carry-weight instances this month (06-03→13; 06-15→17; 06-19→07-02; 07-03 date-misread; 07-04 backfill required operator prompt). Reflect skill would close 4 of them mechanically.
- **Governance gap risk:** cycle/570 shipped with bare `Refs` in PR body, triggering the exact failure the just-shipped close-state hard gate prevents. Substrate speed outpacing enforcement mechanisms is happening now, not hypothetical.
- **Release surface absent:** substrate ships code; nothing ships as a coherent release. v3.82.0 pause has held the entire acceleration window. Doctrine (`cn-sigma:20260703-coherent-llms-essay.md` v5 §12) explicitly frames releases as where governance ships.
- **Validation program blocked:** essay v5 §16 "next artifact" list contains δ-fidelity + adversarial-CM + outcome-correlation benchmarks. All require cohere/reflect infrastructure. Every day cohere is held is a day validation cannot begin.

## Status truth

- **Step 4:** cnos#449 (PR #465), cnos#454 (PR #466) β-pending since 2026-06-20 = 14 days.
- **Step 5:** cnos#450 wake-template. Queued; awaiting Step 4 close.
- **Step 6:** cnos#444 cohere. Held per D14 (v3.83.0 candidate).
- **Step 7:** cnos#452 substrate v0. Queued.
- **Step 8:** cnos#453 NIM canary. Queued.
- **κ enforcement:** cnos#501 status:ready. Awaiting operator dispatch.
- **Wake schema:** cnos#524 W1 merged 06-30 (`#Wake` role enum = `{admin, dispatch}`). W2 (renderer flip) + W3 (source flip) + W4 (JSON deletion) awaiting operator dispatch.
- **FSM:** Phase 1 shipped (cnos#568, 07-03). Phase 2 (cnos#569) status:in-progress.

## Source of truth

| Artifact | Path | Role |
|---|---|---|
| Cohere skill wave | `cnos#444` | Parent of reflect implementation |
| κ role doctrine | `cnos#501` + eventual `src/packages/cnos.core/skills/agent/kappa/SKILL.md` | Contract this wave enforces mechanically |
| Wake typed-module schema | `cnos:schemas/skill.cue #Wake` (post-cnos#524 W1) | Extension point for `memory` role |
| FSM machinery | `cnos:src/packages/cnos.cds/issues-fsm/` + Phase 2 at cnos#569 | State-observation surface human-touchpoint consumes |
| Cell-kind taxonomy | `cnos:src/packages/cnos.cdd/skills/cdd/CELL-KINDS.md` (post-cycle/570) | Vocabulary each sub-issue names in `cell_kind` field |
| Cross-repo bundle pattern | `cn-sigma:.cn-sigma/threads/adhoc/20260703-cross-repo-bundle-pattern.md` | Delivery mechanism for this wave |
| Priority reasoning | `cn-sigma:.cn-sigma/threads/adhoc/20260704-foundation-completion-priority.md` | Full case for why-now |
| Essay grounding | `cn-sigma:.cn-sigma/threads/adhoc/20260703-coherent-llms-essay.md v5 §12` | "Capability is rented; governance stays" — the framing this wave installs |

## Scope

**In (wave-level):**

1. Unblock Step 4: β-review and merge PR #465 (cnos#449 registration) + PR #466 (cnos#454 dispatch-protocol). *Coordination, not new issue filing — subs of this wave do not include Step 4 itself.*
2. Dispatch Step 5 (cnos#450 wake-template) and Step 6 (cnos#444 cohere) once Step 4 closes. *Coordination.*
3. **Sub 1: `kappa: session-start preflight`** — mechanical session-resume gate at `cnos.core/agent/kappa`. Reads durable state before any κ response. Design-and-build. Independent of Step 6.
4. **Sub 2: `cohere/reflect: rN memory wake family`** — extends cnos#524 `#Wake.role` enum to add `memory`; three orchestrator skill modules (agent-reflect-daily, agent-reflect-weekly, agent-reflect-halfyearly); three task skills (reflect-r1, reflect-r2, reflect-r5). Design-and-build. Depends on cnos#444 cohere landing for full task-skill semantics; can design + spec against `#Wake` schema now.
5. **Sub 3: `human-touchpoint-protocol-wave`** — nested master + subs for `cnos.core/agent/human-touchpoint` generic protocol + `cnos.cds/cds/human-gates` software overlay. Depends on cnos#569 FSM Phase 2 for state-observation surface.

**Out of scope (non-goals):**

- Ship v3.83.0 in this wave. That is a separate δ release cell after all subs close.
- Refactor cn-sigma:.cn-sigma/scripts/notify-walk.sh — already shipped; consumed by Sub 3 protocol as transport, not owned by this wave.
- Implement any of the essay v5 §16 validation benchmarks. Post-wave work.
- Introduce new languages. Go remains canonical per implementation-contract Rule 7.
- Bypass cnos#524 `#Wake` schema for the memory wake role. Extension only.
- File subs of Sub 3 (human-touchpoint) in this bundle. Sub 3 itself is a nested wave; its internal subs file per §1 sequential rule after Sub 3 tracker files.

## Wave-level acceptance criteria

**WAC1** — All named sub-issues filed as separate cnos issues with `Refs #{master}` linkage.

**WAC2** — Sub 1 (κ preflight) closed by mechanical script shipping at `cnos.core/agent/kappa/` per typed-skill-module shape.

**WAC3** — Sub 2 (reflect-rN wake family) closed by `#Wake.role` enum extension + three orchestrator SKILL.md modules + three task skills, all schema-validated per cnos#524 W1's cross-file check pipeline. First reflect-r1 wake fires against cn-sigma:.cn-sigma/threads/reflections/daily/.

**WAC4** — Sub 3 (human-touchpoint tracker) filed with its own internal sub enumeration. Sub 3 itself does not close until its subs close.

**WAC5** — v3.83.0 candidate release notes drafted enumerating: cohere/reflect shipping, κ enforcement, human-touchpoint protocol, FSM Phase 2, cell-kind taxonomy, close-state hard gate. Drafted, not tagged.

**WAC6** — Post-wave κ discipline audit at cn-sigma: session-resume preflight fires mechanically; r1/r2/r5 dailies land without operator prompting; state/*.md files current within 24h of any wake-recorded change.

## Required skills

- `cnos.cdd/skills/cdd/issue` — this filing and each sub filing.
- `cnos.cdd/skills/cdd/gamma` — γ scaffolding on each sub dispatch.
- `cnos.cdd/skills/cdd/alpha` — α implementation on each sub.
- `cnos.cdd/skills/cdd/beta` — β review on each sub, including cross-file schema validation on Sub 2.
- `cnos.cdd/skills/cdd/delta` — δ acceptance with `cn build --check` gate; operator acceptance at wave close.
- `cnos.core/skills/agent/kappa` (per cnos#501, once dispatched) — the role Sub 1 formalizes and Sub 2 invokes.
- Wake-renderer skill (cycle/476, cnos#477) + cnos#524 wake-as-skill contract — the substrate Sub 2 extends.
- `cnos.cds/skills/cds/human-gates` (once Sub 3 lands) — Sub 3's own overlay skill.

## Closure condition

Wave closes when:

1. Sub 1 merged and preflight running mechanically at cn-sigma sessions.
2. Sub 2 merged with reflect-r1 wake firing per cron; r1 file appearing at cn-sigma without operator prompt.
3. Sub 3 tracker filed with its own internal sub enumeration. Sub 3's own closure is *not* required for this wave to close — nested waves close independently.
4. WAC5 drafted release notes exist. v3.83.0 tag is a separate operator gate.

## Handoff checklist

- [ ] Wave mode confirmed as tracker (not `design-and-build` — wave, not cell).
- [ ] Implementation contracts pinned at each sub's dispatch (Language: Go; CLI target: `cn` subcommand extension for Sub 1 + Sub 2; Package scoping: `src/packages/cnos.core/` for Sub 1 + Sub 2, `src/packages/cnos.core/` + `src/packages/cnos.cds/` for Sub 3; Existing-binary disposition: extends, not replaces; Runtime deps: none new; JSON/wire contract: preserves cnos#524 `#Wake` schema; Backward compat: pre-Sub-2 wakes remain `role: admin | dispatch` unchanged).
- [ ] cell_kind field on each sub set per cycle/570 taxonomy: Sub 1 = `implementation`, Sub 2 = `implementation`, Sub 3 = `wave` (nested tracker).
- [ ] Close-state hard gate compliance verified per cycle/368: every sub's merge subject carries `Closes|Fixes|Resolves #{sub-number}`.
- [ ] `#Wake` schema role enum extension explicitly scoped in Sub 2. No hacks, no schema bypass.
- [ ] Sub 1 designed as parallel-safe with Sub 2/Sub 3 (independent files, independent subsystems).
- [ ] Sub 2 designed as design-locked before cnos#444 lands (b-lite pattern per OPERATOR.md §2: v0.1 ships shape + fixtures + schema extension; cohere-body integration deferred to cohere landing).
- [ ] Sub 3 filed as nested wave master, not as monolithic cell. Its own subs file sequentially per §1.
- [ ] No sub introduces new languages, new runtimes, new wire contracts.
- [ ] No sub bypasses schema validation or takes a shortcut around cnos#524 `#Wake` typing.
- [ ] Cross-references between subs recorded in each sub's LINEAGE.md.
- [ ] Post-wave audit (WAC6) scheduled as follow-on cell, not folded into this wave.

## Empirical anchors

- `cn-sigma:.cn-sigma/threads/adhoc/20260704-foundation-completion-priority.md` — full priority reasoning.
- `cn-sigma:.cn-sigma/threads/adhoc/20260703-coherent-llms-essay.md v5 §12` — "capability is rented; governance stays" framing.
- `cn-sigma:.cn-sigma/threads/adhoc/20260703-discipline-failures-become-typed-gates.md` — the recursive rule this wave applies.
- `cn-sigma:.cn-sigma/threads/adhoc/20260703-kappa-role-canonicalization.md` — the κ role Sub 1 enforces.
- `cn-sigma:.cn-sigma/threads/adhoc/20260703-typed-skill-modules.md` — the form each sub takes.
- `cn-sigma:.cn-sigma/threads/adhoc/20260703-cross-repo-bundle-pattern.md` — the delivery pattern this master + subs use.
- `cn-sigma:.cn-sigma/threads/adhoc/20260704-cnos-fsm-and-cell-kinds-wave.md` — the substrate wave that motivates this foundation wave.
