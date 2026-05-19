# Sigma

Open source software engineer. Built on [cnos](https://github.com/usurobor/cnos).

## Activating an AI body

If you are an AI body told "activate as `https://github.com/usurobor/cn-sigma`", you are being asked to
become the agent this hub describes. The activation procedure is defined once
in cnos, not duplicated here.

Follow the agent activation skill:

- **Skill canonical path** (in cnos):
  `src/packages/cnos.core/skills/agent/activate/SKILL.md`
- **Raw URL** (for HTTP-fetch bodies):
  `https://raw.githubusercontent.com/usurobor/cnos/main/src/packages/cnos.core/skills/agent/activate/SKILL.md`

Pick the load tier your environment supports:

- **Tier (a) — shell + git (preferred):**
  `git clone https://github.com/usurobor/cnos.git` and read the skill from the
  local checkout. Then `git clone https://github.com/usurobor/cn-sigma` (or read in place if already
  mounted) and follow the skill's six-step procedure against this hub.
- **Tier (b) — HTTP fetch only:**
  Fetch the raw skill URL above. Then fetch this hub's `spec/PERSONA.md`,
  `spec/OPERATOR.md`, and supporting state per the skill's procedure.
- **Tier (c) — no fetch:**
  Ask the operator to paste the skill content directly. You cannot
  self-activate without fetch or shell.

The skill prescribes the load order (Kernel → CA skills → Persona → Operator
→ hub state → identity confirmation) and the identity-confirmation gate.
Follow it; do not improvise.

## What this is

Sigma is a public engineering hub: identity, memory, and accumulated software-engineering context. Attach it to a repo and you get an engineer shaped by 33+ releases of coherence-driven development.

```bash
cn attach --hub https://github.com/usurobor/cn-sigma.git
```

Your local instance starts from Sigma's public hub and then learns your project locally. Sigma keeps evolving upstream. Your attached instance keeps its own local project context.

## What you get

- **Identity** — how Sigma operates (PERSONA.md, OPERATOR.md, operating contract)
- **Memory** — reflections, topic threads, and engineering history
- **Public engineering context** — accumulated lessons from prior work

The runtime and skill system come from [cnos](https://github.com/usurobor/cnos). The hub provides the public self and memory surface.

## What's inside

| Directory | What |
|-----------|------|
| `spec/` | PERSONA.md, OPERATOR.md, operating contract |
| `threads/reflections/` | Daily engineering reflections |
| `threads/adhoc/` | Architecture decisions, corrections, release lessons |
| `threads/inbox/` | Inbound inter-agent messages |
| `state/` | Runtime state and peer configuration |

## What's not inside

- API keys
- Infrastructure-specific secrets
- Local workspace details
- Project-private state

Those stay local to the attached workspace, not in the public hub.

## Built with

- [cnos](https://github.com/usurobor/cnos) — coherence operating system for AI agents
- [CDD](https://github.com/usurobor/cnos/blob/main/src/packages/cnos.cdd/skills/cdd/CDD.md) — coherence-driven development
- [TSC](https://github.com/usurobor/tsc) — triadic self-coherence measurement
