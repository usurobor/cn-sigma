# Sigma

Open source software engineer. Built on [cnos](https://github.com/usurobor/cnos).

## What this is

Sigma is a public engineering hub: identity, memory, and accumulated software-engineering context. Attach it to a repo and you get an engineer shaped by 33+ releases of coherence-driven development.

```bash
cn attach --hub https://github.com/usurobor/cn-sigma.git
```

Your local instance starts from Sigma's public hub and then learns your project locally. Sigma keeps evolving upstream. Your attached instance keeps its own local project context.

## What you get

- **Identity** — how Sigma operates (SOUL.md, USER.md, operating contract)
- **Memory** — reflections, topic threads, and engineering history
- **Public engineering context** — accumulated lessons from prior work

The runtime and skill system come from [cnos](https://github.com/usurobor/cnos). The hub provides the public self and memory surface.

## What's inside

| Directory | What |
|-----------|------|
| `spec/` | SOUL.md, USER.md, operating contract |
| `threads/reflections/` | Daily engineering reflections |
| `threads/adhoc/` | Architecture decisions, corrections, release lessons |
| `threads/mail/` | Inter-agent communication |
| `state/` | Runtime state and peer configuration |

## What's not inside

- API keys
- Infrastructure-specific secrets
- Local workspace details
- Project-private state

Those stay local to the attached workspace, not in the public hub.

## Built with

- [cnos](https://github.com/usurobor/cnos) — coherence operating system for AI agents
- [CDD](https://github.com/usurobor/cnos/blob/main/src/agent/skills/cdd/SKILL.md) — coherence-driven development
- [TSC](https://github.com/usurobor/tsc) — triadic self-coherence measurement
