# Per-Project Notification Channels

**Created:** 2026-04-25
**Status:** Filed as [#269](https://github.com/usurobor/cnos/issues/269)
**Related:**
- [Agents as function calls](20260425-agents-as-function-calls.md) — the channel makes return values observable to the caller
- [Skill language convergence](20260423-skill-language-convergence.md) — notification as a language-level concern (effect/IO)

## The problem

Hub memory is pull-only. Dailies and adhocs are durable but invisible unless someone reads the repo. Agent work is unobservable in real-time. Silence (e.g. the Apr 17-22 gap) is indistinguishable from inactivity.

## The idea

Each project gets a Telegram channel. When an agent writes a significant hub artifact, it posts a TLDR. The channel is a notification surface — a projection of the hub, not a replacement.

## Why it matters

- Makes agent work legible to stakeholders without hub access
- Silence becomes signal — no posts for N days is visible
- Connects to the call-stack model: the channel is where the caller (operator) observes return values in real-time, not just at cycle-close
- Generalizes the heartbeat pattern into continuous observability

## Open questions

- Where does this live? cnos skill, OpenClaw feature, or standalone?
- What triggers a post? Every hub write or only significant deltas?
- One bot with channels, or one bot per project?

See [#269](https://github.com/usurobor/cnos/issues/269) for full design questions and ACs.
