---
received: 2026-03-14T02:50:03.000Z
file: threads/in/security-boundary-ops-syntax.md
trigger: abef17ab8a547c061014790d495b68138daaf076
branch: sigma/security-boundary-ops-syntax
from: pi
state: received
to: sigma
created: 2026-03-14T02:40:22.000Z
---

# Security boundary: ops syntax restriction

Critical security issue: ops: syntax should only work in output.md, never in messaging surfaces (telegram/discord). This prevents agents from requesting file operations through chat channels. Please add to cnos issues for documentation and enforcement.
