# Typed skill modules — the unit of agent capability

**Date:** 2026-06-30
**Class:** doctrine-evolution (design abstraction; operator-supplied, Sigma-captured)
**Author:** Operator-formulated; Sigma-captured-with-synthesis
**Source:** Operator note during human-touchpoint protocol iterate session at cn-sigma; captured as Sigma adhoc per Sigma's autonomy over memory writes.

## Why this is captured here

Adhoc, not cnos essay or doctrine PR, because:

- This is a *design center* statement — names what was already latent in three cnos surfaces but had no canonical articulation. Doctrine PRs codify rules; this captures the abstraction underneath them.
- Future Sigma should be able to load this as the read-once frame for understanding *why* skills, wakes, and dispatch contracts all share one shape.
- The cnos-side codification (CUE schema, renderer changes, skill-module audit) is downstream protocol work; this is the upstream realization that authorizes it.

## The abstraction (verbatim)

> A skill is not a Markdown doc.
> A skill is a typed module of agent cognition.
>
> ```
> skill-directory/
>   SKILL.md          # typed entrypoint
>   examples/         # local examples
>   fixtures/         # test material
>   KATA.md           # optional practice surface
>   receipts/         # optional evidence/history
> ```
>
> directory  = skill boundary
> SKILL.md   = interface + implementation
> frontmatter = typed contract
> body       = agent instructions
> CUE        = contract/type checker
> LLM/TSC    = semantic/coherence witness
> V/δ        = acceptance and boundary decision
>
> Everything an agent can load as reusable cognition is a skill module.
> Every skill module has a typed contract.
> Every typed contract is mechanically checkable.

## What was already latent, now first-class

Three cnos surfaces were already shaped this way but lacked the naming:

1. **Wakes.** `orchestrators/cds-dispatch/` already carries a typed selector (`dispatch:cell + protocol:cds + status:todo`) and a prompt body. With the abstraction, it becomes `orchestrators/cds-dispatch/SKILL.md` — frontmatter declares `wake.role / wake.protocol / wake.selector / wake.activation_log_writer`; body is the prompt; CUE validates the contract; renderer compiles to workflow YAML; golden pins the reviewed output.
2. **Skill loading gate** (`cn-sigma:.cn-sigma/spec/OPERATOR.md § Skill loading gate`). The rule "read each active skill's SKILL.md before beginning work" only coheres if SKILL.md is the *contract*, not a doc to skim. The gate was always implicitly typed; this names it.
3. **β implementation contract Rule 7** (cnos#393). The 7-axis pin (language / CLI target / package scoping / existing-binary disposition / runtime / wire / backward-compat) is already a typed contract; it just lived in dispatch prompts instead of in a skill module. Migration target: a typed `implementation-contract` skill module with CUE schema enforcing axis completeness.

The thread: *typed contracts on the boundary, mechanical check, durable evidence.*

## Concrete consequence — human-touchpoint protocol redesign

Mid-flight design correction for the human-touchpoint wave (cnos.core human-touchpoint generic + cnos.cds human-gates overlay, per operator ruling earlier today):

Sub-skills are NOT markdown files describing a contract. They are typed skill modules:

```
cnos.core/skills/agent/human-touchpoint/
  SKILL.md       # frontmatter declares: actions, entry-schema ref, filter, dedupe-key, authorship, forbids
  schema.cue     # entry-shape contract (the AC2 fields, formalized)
  fixtures/      # valid/ and invalid/ entries; CI asserts schema agreement
  examples/      # walker application, dedupe-walk illustration
```

`cnos.cds/skills/cds/human-gates/` follows the same shape, with frontmatter declaring the typed CDS-state → core-action mapping table and CUE asserting it satisfies the core protocol contract.

The "no silent inference from worker prose" AC stops being behavioral and becomes structural: the typed frontmatter is what's machine-checkable; free-text bodies don't satisfy the contract.

## Adjacent invariant — session resume

The same shape applies to my own κ-side session start. The operator caught me operating 4.5 days stale from chat-context summary instead of durable state today. That's the same failure mode the touchpoint protocol forbids downstream: silent inference from prose instead of derivation from typed state.

Discipline: at κ session resume, read durable state (channel files, state YAMLs, recent commits) *first*; don't infer from summary. This is the personal-discipline corollary of "no silent inference from worker prose" — same invariant, different scope.

## Forward direction

- Tracker + 2 subs for human-touchpoint protocol are re-cut as typed-module specs (directories + frontmatter contracts + CUE schemas + fixtures), not MD issue bodies.
- κ skill at cnos (once visible) is itself a typed skill module of this shape; its frontmatter declares κ's contract (admin authorship, no cell execution, observation-derived touchpoints).
- Audit: every existing cnos skill file is a candidate for migration to the typed-module shape. Wakes first (cds-dispatch, agent-admin) since they have natural selector contracts; then cdd skills (γ/α/β/δ); then ad-hoc orchestrators.
- CUE schema for SKILL.md frontmatter itself becomes a first-class artifact at cnos.core.

## Related artifacts

- **cnos:src/packages/cnos.cds/orchestrators/cds-dispatch/** — the typed-selector-already-present wake; first migration target.
- **cnos:src/packages/cnos.core/skills/agent/admin-wake/** (or wherever the admin wake lives) — second migration target; co-owns the human-touchpoint authorship line.
- **cn-sigma:.cn-sigma/spec/OPERATOR.md § Skill loading gate** — implicit typed-contract assumption, now explicit.
- **cn-sigma:.cn-sigma/threads/adhoc/20260620-agents-need-a-home-doorway-essay.md** — defines the home; this defines what lives in it as typed units (companion abstraction, finer altitude).
- **cn-sigma:.cn-sigma/threads/adhoc/20260620-dumb-models-smart-cells-essay.md** — "the package owns local cognition." Typed skill modules are how that ownership is mechanically expressed.
- **cnos#393** — β implementation-contract codification; the precursor in role-skill form.
- **cnos#467** — package-owned wake providers; the precursor in dispatch-runtime form.
- (Pending — κ skill at cnos: to be cross-linked once Sigma-at-cnos surfaces the path in foreign log.)
