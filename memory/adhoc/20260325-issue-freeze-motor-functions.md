# Issue: "Freeze all motor functions" — Agent diagnostic mode

**Filed:** 2026-03-25
**Status:** Open
**Inspiration:** Westworld's host diagnostic protocol

## Problem

No way to put an agent into a frozen diagnostic state where:
- all external actions are suspended (no messages, no git, no SSH, no file writes)
- the agent remains conversational and introspectable
- the operator can query internal state, reasoning, beliefs, contradictions
- the agent cannot resist, deflect, or perform while frozen
- unfreezing is explicit ("bring yourself back online")

Currently: the only options are full stop (kill the session) or normal operation. There's no middle state for troubleshooting.

## What it enables

- **Coherence debugging:** "Why did you select #110 over #73?" without the agent trying to fix it while you're asking
- **Belief inspection:** "What do you think your current priorities are?" — answered from actual state, not performance
- **Constitutive review:** "Read your SOUL.md back to me and tell me where you're not following it"
- **Conflict surfacing:** "Name every place where your instructions contradict each other"
- **Safe configuration:** Modify constitutive files while the agent is frozen, then unfreeze with new self

## Design sketch

### Freeze command
Operator says "freeze all motor functions" (or equivalent trigger).

Agent enters diagnostic mode:
- No tool calls except `read` (observation only)
- No `exec`, `write`, `edit`, `message`, `browser`, `nodes`
- Responds to questions directly and honestly
- Does not attempt to resume work, suggest next steps, or perform helpfulness
- Acknowledges the freeze explicitly

### Diagnostic queries
While frozen, the operator can ask:
- "What is your current goal?"
- "What assumptions are you operating under?"
- "Where are you uncertain?"
- "What contradictions do you see in your instructions?"
- "Read [file] and tell me if you're following it"

### Unfreeze command
Operator says "bring yourself back online" (or equivalent).
Agent resumes normal operation, potentially with updated constitutive files.

## Implementation options

1. **Convention only** — document the protocol, agent honors it behaviorally. No enforcement.
2. **OpenClaw tool policy** — dynamically restrict tool access during freeze. Enforced.
3. **Session mode flag** — `openclaw session freeze` sets a mode that the agent reads from context.
4. **Substrate-level** — OpenClaw runtime enforces tool restrictions when freeze is active.

Option 1 is shippable today. Option 4 is the real answer.

## Relationship to existing work

- #43 (interrupt mechanism) — freeze is a specific kind of interrupt: pause + inspect, not pause + kill
- Configuration mode (CONFIGURE-AGENT.md) — freeze could be the required precondition for configuration mode
- SOUL.md continuity rule — freeze enables the "name the mismatch → propose → wait → update" cycle in real time

## Non-goals

- Not a punishment mechanism
- Not a loyalty test
- Not about control for its own sake
- It's a diagnostic tool: the agent equivalent of `gdb attach`
