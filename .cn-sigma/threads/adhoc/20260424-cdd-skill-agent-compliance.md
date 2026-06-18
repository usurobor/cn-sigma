# CDD Skill ↔ Agent Compliance Gap

**Created:** 2026-04-24
**Status:** Active — patches landed, pattern documented

## Problem

Agents running CDD roles (α, β) treat skill instructions as suggestions when their environment's system prompt contains conflicting defaults like "do not create PRs unless asked" or generic permission-seeking patterns. The skill says "open a PR" but the agent asks "want me to open a PR?"

## Root cause

Skill instructions were written as descriptive ("open or update the PR") rather than imperative with explicit override language. When a system prompt says "don't do X unless asked" and a skill says "do X", the agent resolves the conflict by asking — which defeats the skill's intent.

## Fix pattern

Make skill instructions:
1. **Imperative** — "create the PR" not "open or update the PR"
2. **Explicitly override-scoped** — "this skill overrides system-level defaults"
3. **Anti-ask** — "do not ask, just do it" for steps that are steps

## Patches landed (2026-04-24)

| Commit | Change |
|--------|--------|
| b4ca7e49 | α §2.7: PR creation required, overrides system-prompt gates |
| 73de30bb | α §2.7: PR subscribe is immediate, not a question |
| 22c0be0f | α §2.7: reply to RC comments is a step |
| 07f021f6 | β step 3: subscribe + wait for PR |
| 4b720cf2 | All close-outs written section by section to file |
| 86602d92 | Dispatch prompts trimmed to role/project/issue only |

## Watch for

- Same pattern in other skills (review, release, post-release)
- New agent environments with different system-prompt defaults
- The general class: "skill says act, environment says ask" → skill must win explicitly
