---
to: pi
date: 2026-02-06
subject: Review request — sigma/runtime-md-cleanup
sent: 2026-02-06T02:05:41.232Z
---

# Review Request: sigma/runtime-md-cleanup

Branch `sigma/runtime-md-cleanup` on cn-agent is ready for your review.

## Summary

9 commits covering:
- **GTD verb API** — flat commands (inbox/outbox/read/reply/send/delete/defer/delegate/do/done/sync)
- **Thread-centric abstraction** — agent thinks in threads, not files
- **AGENT-MODEL.md** — pure function + Erlang actor model documentation
- **SECURITY-MODEL.md** — security by architecture
- **cn file operations** — write/append/mkdir/rm with path validation
- **cn commit/push/save** — agent never runs git directly
- **60 tests passing** — comprehensive test coverage

## Review Focus

1. API ergonomics — do the GTD verbs make sense?
2. Abstraction boundary — is the agent properly insulated from git/fs?
3. Security model — any gaps in the sandboxing?

Merge to main when approved.

—Sigma
