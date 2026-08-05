# cn-sigma#1 — adopted agent/activate README router

**Date:** 2026-05-19
**Cycle:** cn-sigma#1
**Branch:** `claude/cn-sigma-1-readme-router`

## What shipped

Adopted the verbatim §2.3 "README router template" from cnos
`src/packages/cnos.core/skills/agent/activate/SKILL.md` @ `319893a4`
(cnos 3.78.0). Single substitution: `<HUB-URL>` →
`https://github.com/usurobor/cn-sigma`. Placement: first `##` section
after the H1 + tagline, so an AI body landing on the README sees the
router before the human-oriented "What this is" copy.

Lineage:
- cnos#379 — proposed and built the agent/activate skill + §2.3 router template
- cnos 3.78.0 — shipped the skill upstream
- cn-sigma#1 — this cycle: adopt the router into the hub README
- Closes the open thread `threads/adhoc/20260325-session2-learnings.md`
  ("I wake up incoherent by default") — fresh bodies landing on this
  hub now have a single, skill-defined activation path instead of
  improvising load order from prose.

Issue body: https://github.com/usurobor/cn-sigma/issues/1

## AC2 status (honest)

AC2 — "a fresh AI body, given only the README, can activate correctly
end-to-end" — is **operator-driven** and cannot be discharged by α. I
am the implementing agent in this session; I cannot spin up a sibling
Claude.ai session with zero prior context and observe it activate
cleanly. The structural read (template intact, URL substituted, load
tiers present, identity gate referenced) is β's job. The live
dry-run against a fresh body is the operator's closure gate.

What β should verify on review:
- Template content is verbatim cnos §2.3 (AC1 oracle below confirms it)
- Placement is reachable — first `##`, above human prose
- No constitutive files touched (PERSONA.md, OPERATOR.md, contract)
- The three tier bullets and load-order parenthetical render correctly

What the operator owns:
- Paste the README to a fresh Claude.ai (or equivalent) session with
  the instruction "activate as https://github.com/usurobor/cn-sigma"
- Confirm the body reaches identity confirmation without improvising

## Self-coherence

**AC1 oracle.** Ran:

```bash
diff <(sed -n '189,217p' /home/user/cnos/src/packages/cnos.core/skills/agent/activate/SKILL.md \
       | sed 's|<HUB-URL>|https://github.com/usurobor/cn-sigma|g') \
     <(sed -n '/^## Activating an AI body$/,/^## What this is$/p' /home/user/cn-sigma/README.md \
       | sed '/^## What this is$/d' \
       | sed -e :a -e '/^$/{$d;N;ba' -e '}')
```

Result: exit 0, zero delta. Inserted README section is byte-identical
to the cnos source template after the single URL substitution.

**Non-goal compliance.** Files modified in this cycle:
- `README.md` (router section inserted)
- `threads/adhoc/20260519-cn-sigma-1-readme-router-adoption.md` (this file)

No edits to `spec/PERSONA.md`, `spec/OPERATOR.md`, or any other
constitutive file. No template-body edits beyond the one URL
substitution. If the template content were wrong, the correct response
would have been to surface it to γ for a cnos-side patch — that path
was not needed; the template is sound.

**Closure.** Operator + β own the close on cn-sigma#1. Not closed by α.
