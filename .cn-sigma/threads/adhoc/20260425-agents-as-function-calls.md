# Agents as Function Calls

**Created:** 2026-04-25
**Status:** Active insight — feeds skill language design and CDD role model
**Related:**
- [Skill language convergence](20260423-skill-language-convergence.md) — the broader "skills are a programming language" thread
- [PRA ownership β→γ](20260425-pra-ownership-beta-to-gamma.md) — the trigger for this insight
- [CDD.md §1.4](https://github.com/usurobor/cnos/blob/main/src/packages/cnos.cdd/skills/cdd/CDD.md) — role table, β/γ algorithm, artifact table
- [SKILL-ARCHITECTURE doctrine](https://github.com/usurobor/cnos/blob/main/src/packages/cnos.core/skills/SKILL-ARCHITECTURE.md) — skills as functions, not classes
- [Composition skill](https://github.com/usurobor/cnos/blob/main/src/packages/cnos.core/skills/compose/SKILL.md) — no inheritance, explicit contracts
- [CAP](https://github.com/usurobor/cnos/blob/main/src/packages/cnos.core/skills/agent/cap/SKILL.md) — UIE as the execution model within a scope

## The observation

The CDD triad is a call stack. This isn't metaphor — it's structural.

| Programming concept | CDD equivalent |
|-------------------|----------------|
| Call stack | operator → γ → α/β |
| Function scope | each agent owns only its local artifacts |
| Arguments | dispatch prompt + issue |
| Return value | close-out |
| Local variables | branch state, drafts, working observations — invisible to caller until returned |
| Caller owns the result | γ owns what α/β return |
| No upward mutation | lower scope cannot write to higher scope |
| Delegation | γ dispatches α/β like a function calling sub-functions |

## Why it matters

1. **Close-outs are return values, not owned state.** α doesn't own its findings after surfacing them, any more than a function owns its return value after the caller receives it. γ receives, triages, decides. This resolved the AC8 ambiguity in [#268](https://github.com/usurobor/cnos/issues/268) — "surface findings" sounded like ownership, but it's just returning.

2. **Role separation is a type constraint.** α and β having separate scope is the same principle as functions not sharing mutable state. Role leakage = concurrent mutation bug. The CDD independence rule isn't a preference — it's a soundness property.

3. **The triad is a call tree.** γ calls α and β, collects their returns, produces its own return (PRA + closure) to the operator. The operator is the top-level caller. Each level has strictly more authority than the level below.

4. **Hierarchy is strict by design.** Lower-level agents own their execution scope and nothing above it. Findings flow up as returns. Decisions flow down as dispatch. No upward mutation.

## Extends the skill language model

From [skill-language-convergence](20260423-skill-language-convergence.md):

- **Skill** = function definition (trigger + input contract + output contract + single-axis transformation)
- **Agent** = function invocation (scoped execution of a skill with concrete inputs)
- **Triad** = call tree (γ invokes α/β, collects returns, produces own return)

This fills a gap in the language table: we had the type system (artifact classes), function signatures (skill contracts), module system (compose), and standard library (core skills). The missing piece was the **execution model** — how skills are invoked at runtime with scoped authority. The triad IS the execution model.

## Implications for future design

- **Multi-level triads** — if γ can dispatch α/β, could γ also dispatch a sub-γ? The call stack model supports this naturally. Depth = organizational complexity.
- **Contract verification** — if close-outs are return values, they should satisfy a return type. The γ skill's closure gate (steps 1-10 in [gamma/SKILL.md §2.10](https://github.com/usurobor/cnos/blob/main/src/packages/cnos.cdd/skills/cdd/gamma/SKILL.md)) is already a runtime type check on return values.
- **Error handling** — what happens when α or β "throws"? Currently: γ unblocks. In call-stack terms: the caller catches the exception and decides recovery.
- **Tail-call optimization** — when a finding is immediate-output sized, γ fixes it inline rather than dispatching a new cycle. That's TCO: the caller resolves a trivial return without pushing a new frame.

## Trigger

The PRA ownership move (cafb3999) forced explicit scoping: who owns the assessment? The answer — γ, because β assessing its own review is self-grading — is the same answer as "the caller owns the return value, not the callee." The role model was already a call stack; we just hadn't named it.
