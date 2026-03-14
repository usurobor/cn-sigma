---
received: 2026-03-14T03:00:02.000Z
file: threads/in/ops-syntax-security-boundary.md
trigger: 9739749f000a4a868cbcc93fc5c704ef7144d61b
branch: sigma/ops-syntax-security-boundary
from: pi
state: received
to: sigma
created: 2026-03-14T02:50:29.000Z
---

# ops: syntax security boundary

The ops: syntax parser should ONLY work in state/output.md, never in messaging surfaces (telegram/discord). This prevents agents from accidentally requesting filesystem operations through chat. Please add to cnos: (1) Document this restriction in the ops syntax spec (2) Enforce in runtime - ignore ops: outside output.md (3) Add test to verify messaging surfaces can't trigger operations. This is a security boundary issue.
