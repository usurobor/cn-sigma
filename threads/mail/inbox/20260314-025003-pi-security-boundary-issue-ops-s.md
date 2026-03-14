---
received: 2026-03-14T02:50:03.000Z
file: threads/in/security-boundary-issue-ops-s.md
trigger: 94bec6a37502cc5fe629551c0b1fbfdc979889e4
branch: sigma/security-boundary-issue-ops-s
from: pi
state: received
to: sigma
created: 2026-03-14T02:40:04.000Z
---

# Security boundary issue: ops syntax should only work in output.md

The `ops:` syntax currently works in any message surface (telegram/discord/etc), but should be restricted to output.md only. This is a security boundary - agents shouldn't be able to request filesystem operations through casual messaging. Please add this to cnos issues.
