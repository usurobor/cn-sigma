# feat(cnos.core): reflect-rN wake family — memory role in #Wake, three cadence orchestrators, three reflect task skills

**Filing mode:** `design-and-build` (per `cnos:src/packages/cnos.cdd/skills/cdd/issue/SKILL.md`).
**Sub of:** `foundation-completion-wave` master tracker (this bundle's parent).
**Suggested labels:** `P1`, `area/agent`, `area/coherence`, `area/wake`, `kind/feature`, `protocol:cds`.
**cell_kind:** `implementation` (per `cnos:src/packages/cnos.cdd/skills/cdd/CELL-KINDS.md`).

## Problem

**Exists:** Sigma's rN memory ladder (r0 channel entries → r1 daily → r2 weekly → r5 half-yearly) is authored by κ side-effect. r1/r2/r5 writes depend on κ discipline. Discipline slipped 5× this month (per Sub 1 of parent wave). The reflect skill is named as part of cnos#444 cohere but not yet specified as concrete wake orchestrators.

**Expected:** Reflect runs mechanically via three cadence-appropriate wake providers extending the cnos#524 `#Wake` schema. `#Wake.role` enum grows to `{admin, dispatch, memory}`. Three orchestrator SKILL.md modules render to three GitHub Actions workflows. Three task skills define the compaction cognition per rank. κ invocation is contractual, not decision-time.

**Divergence:** `#Wake.role` enum is currently `{admin, dispatch}`; memory role not admissible. No orchestrator SKILL.md modules exist for memory role. No task skills for reflect-rN exist. Currently reflect happens (when it happens) by operator prompt.

## Impact

- Every day cohere is held is another day rN compaction requires κ to remember. Compaction becomes harder monotonically.
- Sub 1 of parent wave (preflight) surfaces stale-state failure at session resume; this sub eliminates the underlying cause by producing fresh rN entries mechanically.
- Essay v5 §12 requires "capability is rented; governance stays" — memory persistence IS the governance that stays. Reflect wakes install it.

## Status truth

- cnos#524 W1 merged 06-30: `#Wake` schema live with role enum `{admin, dispatch}` per `cnos:schemas/skill.cue`.
- cnos#524 W2 (renderer flip) + W3 (source flip) + W4 (JSON deletion) awaiting operator dispatch. This sub does NOT block on W2+; it extends the W1 schema.
- cnos#444 cohere held per D14. This sub's task-skill body-writing depends on cohere semantics; the wake-provider shape can be design-locked now.
- Prior agent-memory-wakes bundle at `cn-sigma:.cn-sigma/threads/activations/cnos/20260630.md` directive-out — subsumed by this filing.

## Source of truth

| Artifact | Path | Role |
|---|---|---|
| Wake schema | `cnos:schemas/skill.cue #Wake` | Extension point |
| cnos#524 W1 precedent | `cnos:src/packages/cnos.core/orchestrators/agent-admin/SKILL.md` + `cnos:src/packages/cnos.cds/orchestrators/cds-dispatch/SKILL.md` | Shape reference |
| Reflect skill scope | `cnos#444` cohere | Semantic parent |
| Cohere held state | D14 at `cn-sigma:.cn-sigma/state/wave.md` (stale, but D14 is durable) | Blocker for full task-skill body |
| Memory ladder convention | `cn-sigma:.cn-sigma/spec/OPERATOR.md § Activation logs` + reflect-ladder implicit convention | Target for output writes |
| κ role | `cnos:src/packages/cnos.core/skills/agent/kappa/SKILL.md` (post-cnos#501) | The invoked role per essay v5 §8 |
| Substrate wave that motivates this | `cn-sigma:.cn-sigma/threads/adhoc/20260704-cnos-fsm-and-cell-kinds-wave.md` — cycle/570 wired cell_kind seam forward-compat; this sub uses that seam via `cell_kind: implementation` on its own cell |

## Scope

**In:**

1. Extend `cnos:schemas/skill.cue #Wake.role` enum from `{admin, dispatch}` to `{admin, dispatch, memory}`. Fields on `memory`-role wakes: `ladder_rank: "r1" | "r2" | "r5"`, `cadence: "daily" | "weekly" | "halfyearly"`, `selector: string` (e.g., `"r0-entries-since-last-r1"`), `target_path_template: string`, `invokes_role: "kappa"`, `task_skill: string`.
2. Three orchestrator SKILL.md modules at `cnos:src/packages/cnos.core/orchestrators/`:
   - `agent-reflect-daily/SKILL.md` — cadence=daily, ladder_rank=r1, invokes reflect-r1 task skill.
   - `agent-reflect-weekly/SKILL.md` — cadence=weekly, ladder_rank=r2, invokes reflect-r2.
   - `agent-reflect-halfyearly/SKILL.md` — cadence=halfyearly, ladder_rank=r5, invokes reflect-r5.
3. Three task skills at `cnos:src/packages/cnos.core/skills/agent/`:
   - `reflect-r1/SKILL.md` + `schema.cue` + fixtures.
   - `reflect-r2/SKILL.md` + `schema.cue` + fixtures.
   - `reflect-r5/SKILL.md` + `schema.cue` + fixtures.
4. Renderer integration: `cn install-wake` (per cycle/476) compiles the three orchestrators to GitHub Actions workflow files. Goldens pin the rendered output.
5. Memory-law compliance: task-skill body writes r(N) entries WITHOUT modifying r(N-1) entries. Append-only. Fixture asserts byte-identical r(N-1) state pre/post.

**Out of scope:**

- Task-skill body semantics beyond append-and-compact shape. cnos#444 cohere lands the semantic details; this sub ships the shape + schema + fixtures + wake providers so cohere has a place to plug in.
- Bumpt reflection wakes. Cn-sigma is the target; other activation homes are separate.
- Notification of rN writes to Telegram. Sub 3 of parent wave (human-touchpoint) covers that surface.
- New task-skill languages. Bash + CUE for schema; task-skill body prompts are markdown per typed-skill-module convention.

## Acceptance criteria

**AC1** — `cnos:schemas/skill.cue #Wake.role` enum extended to `{admin, dispatch, memory}` with the six new memory-role-specific fields defined. CUE validation passes on existing admin + dispatch wakes (backward-compatible extension).

**AC2** — Three orchestrator SKILL.md files exist at `cnos:src/packages/cnos.core/orchestrators/agent-reflect-{daily,weekly,halfyearly}/`. Each carries valid frontmatter per cnos#524 W1 cross-file check pipeline. Each declares `wake.role: memory`, correct cadence, correct ladder_rank, correct task_skill reference.

**AC3** — Three task-skill SKILL.md files exist at `cnos:src/packages/cnos.core/skills/agent/reflect-r{1,2,5}/`. Each carries valid frontmatter typing the compaction contract. Each ships a `schema.cue` formalizing the rN entry shape produced.

**AC4** — Fixtures at each task skill's `fixtures/valid/` and `fixtures/invalid/`:
- Valid: sample well-formed rN entry.
- Invalid (schema): missing required field.
- Invalid (memory-law): modifies an r(N-1) entry — must be rejected by the schema validator + a specific `TestMemoryLawAppendOnly` test.

**AC5** — `cn install-wake` renders three GitHub Actions workflow files from the three orchestrator SKILL.md modules. Goldens pin the rendered output byte-identical to hand-verified reference. I1 + goldens green.

**AC6** — Cn-sigma-side integration: rendered workflows drop into `cn-sigma:.github/workflows/` on next `cn install-wake` at cn-sigma. Existing `claude-wake.yml` continues to fire admin wake unchanged (backward-compat).

**AC7** — Memory-law test: `TestMemoryLawAppendOnly` fixture simulates a re-run of the same window; asserts byte-identical r(N-1) state pre/post; asserts r(N) write is append-only. Fails if implementation mutates prior-rank evidence.

**AC8** — κ citation: each orchestrator frontmatter `invokes_role: kappa`; each orchestrator body prompt explicitly loads `cnos.core/skills/agent/kappa/SKILL.md` before invoking the reflect task skill. β verifies citation present.

**AC9** — No cell-protocol coupling: reflect wakes do NOT route through cds-dispatch or any cell-protocol dispatch mechanism. β verifies no cell-protocol vocabulary appears in the wake prompt body.

**AC10** — Task-skill body semantics deferred to cnos#444 cohere landing. This sub ships the shape (frontmatter contract + schema.cue + fixtures + wake provider). Body prompt is a stub referencing cnos#444 for eventual completion. β accepts stub prompt as v0.1 (b-lite pattern per OPERATOR.md §2).

## Required skills

- `cnos.cdd/skills/cdd/gamma` — γ scaffold.
- `cnos.cdd/skills/cdd/alpha` — α ships schema extension + orchestrator SKILL.md + task-skill SKILL.md + fixtures.
- `cnos.cdd/skills/cdd/beta` — β reviews; AC7 (memory-law) and AC9 (no cell coupling) are the critical gates.
- `cnos.cdd/skills/cdd/delta` — δ accepts; `cn build --check` + goldens.
- `cn install-wake` renderer skill (per cycle/476, cnos#477) — extends renderer to admit `memory` role.
- `cnos.core/skills/agent/kappa` (post-cnos#501) — invoked role.

## Closure condition

Closes when:

1. Schema extension + three orchestrators + three task skills + fixtures merged.
2. `cn install-wake` renders three workflows byte-identical to golden.
3. First scheduled fire of agent-reflect-daily wake at cn-sigma produces an r1 entry at `cn-sigma:.cn-sigma/threads/reflections/daily/YYYYMMDD.md`.
4. `TestMemoryLawAppendOnly` passes.
5. Merge subject carries `Closes #{N}` per cycle/368 close-state hard gate.

Weekly and halfyearly first-fire cannot be gated on within a single cycle (cadences are longer than cell duration). Their goldens + CI green suffice for close; first natural fire is post-close observation.

## Handoff checklist

- [ ] Implementation contract pinned by δ at dispatch (Language: Go for renderer changes if needed; CUE for schema; Bash for orchestrator wake commands if any; CLI target: `cn install-wake` renderer extension only, no new subcommand; Package scoping: `cnos.core/orchestrators/agent-reflect-{daily,weekly,halfyearly}/`, `cnos.core/skills/agent/reflect-r{1,2,5}/`, `cnos:schemas/skill.cue #Wake` extension; Existing-binary disposition: additive; Runtime deps: none new — GitHub Actions cron already exists; JSON/wire contract: extends `#Wake.role` enum backward-compatible; Backward compat: existing admin + dispatch wakes render unchanged).
- [ ] Renderer extension in `cn install-wake` for `memory` role: γ specifies whether this is a small renderer patch or requires broader change. If broader, split the renderer patch into a preceding sub cell.
- [ ] cross-repo cadence: cn-sigma consumes the rendered workflows via `cn install-wake` invocation from cn-sigma. Path resolution: reflect-r1 orchestrator target = `cn-sigma:.cn-sigma/threads/reflections/daily/${YYYYMMDD}.md`.
- [ ] Close-state hard gate compliance per cycle/368: merge subject carries `Closes #{N}`.
- [ ] cell_kind field on the resulting cell = `implementation` per cycle/570 taxonomy.
- [ ] No hacks: no cycle-protocol backdoor for memory wake. It is a separate role in the same schema.
- [ ] Body prompt for task-skills is a stub v0.1 referencing cnos#444 for later completion (b-lite pattern). β accepts this explicitly, not silently.
- [ ] Fixtures cover memory-law violation as first-class negative test.

## Empirical anchors

- `cnos#444` — cohere skill wave; reflect named as sub.
- `cnos#524` W1 — `#Wake` schema this sub extends.
- `cycle/476` (cnos#477) — `cn install-wake` renderer this sub extends.
- `cn-sigma:.cn-sigma/threads/activations/cnos/20260630.md` — prior directive-out for agent-memory-wakes (subsumed by this filing).
- `cn-sigma:.cn-sigma/threads/adhoc/20260703-typed-skill-modules.md` — the form each SKILL.md takes.
- `cn-sigma:.cn-sigma/threads/adhoc/20260703-coherent-llms-essay.md v5 §8` — witness-boundary principle.
- `cn-sigma:.cn-sigma/threads/reflections/daily/2026061{9,20,21,22,23,24,25,26,27,28,29,30}.md` — 12 backfill dailies that would have been mechanical outputs if this sub had shipped.
