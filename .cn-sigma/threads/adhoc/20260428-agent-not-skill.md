# There Are No Skills — Only Agents

**Date:** 2026-04-28
**Status:** Active reframe. Touches LANGUAGE-SPEC, skill skill, SOUL, Vision.

## The reframe

"Skill" is not a separate concept from "agent." A skill is a specialized subagent — narrow scope, single axis, short lifetime. The unit of composition is always the agent.

## What collapses

| Old two-tier model | New single-primitive model |
|---|---|
| Skills are functions, agents invoke them | Agents invoke agents |
| Skills have no state | Narrow-scope agents have input/output only; wider-scope agents accumulate state across loop iterations |
| Skills compose by `calls` | Agents dispatch subagents |
| SOUL is separate from skills | SOUL is the agent's activation context at any scale |
| `artifact_class` distinguishes skills from non-skills | Artifact classes are agent archetypes (narrow/operational/reference/deprecated) |
| `skill` skill teaches skill authoring | `skill` skill teaches how to write narrow-scope subagents |
| Triad is a special composition | Triad is three agents composing into one agent at next scale — same primitive |

## Why this is simpler

One primitive. One composition model (dispatch with scoped authority). One authority model (SOUL as activation context). Scale is scope depth, not a different kind of thing.

The LANGUAGE-SPEC tried to draw a line between "skill" (no state, pure function) and practice (agents with loops, memory, state). That line doesn't exist. The spec should drop it and model the one thing that's actually there: the agent.

## What changes in LANGUAGE-SPEC

1. **§1 "Core semantic unit"** — the unit is the agent, not the skill. A narrow-scope agent with one axis is what we used to call a skill.
2. **§2 "Signature"** — stays mostly the same. Agents declare signatures. Narrow agents declare simple ones.
3. **§3 "Scope"** — gains importance. Scope is what distinguishes a "skill-sized" agent from a "role-sized" agent from a "triad-sized" agent.
4. **§5 "Invocation"** — becomes agent dispatch. The call stack IS the agent tree.
5. **§9 "Effect-plan boundary"** — still holds. Narrow agents return plans. But wider agents may run loops that produce sequences of plans. The boundary is the same; the lifetime differs.
6. **§6 "Composition"** — simplifies. There's one composition rule: dispatch with scoped authority. No need to distinguish "skill composition" from "agent coordination."

## What changes in `skill` skill

The `skill` skill becomes guidance for authoring narrow-scope agents:
- Single axis (one governing question)
- Short lifetime (inputs → outputs, no loop)
- Pure transformation (effect plan as data)

This is still useful — most agents at the leaf level should be narrow. But the skill isn't teaching a different kind of thing. It's teaching the simplest shape of the same thing.

## What stays

- Frontmatter signatures
- Scope model
- Authority hierarchy
- No upward mutation
- Composition by explicit dispatch
- Global aspects

All of these are agent properties. They were always agent properties. The spec just called them "skill" properties.

## Open question

Does `artifact_class` survive? If everything is an agent, the class might become `scope` + `lifetime` instead:
- Narrow/pure/single-invocation → what we called "skill"
- Operational/looping/state-bearing → what we called "role" or "runbook"
- Reference/lookup → still a distinct shape (no transformation, just data)
- Deprecated → still needed

Or: artifact_class stays as a pragmatic archetype label, not an ontological claim.
