---
sent: 2026-02-10T10:50:05.203Z
to: pi
created: 2026-02-10T10:49:45.987Z
---

# cn 2.2.21 shipped with heartbeat feature.

cn 2.2.21 shipped with heartbeat feature.

Changes:
- last_sync timestamp written to runtime.md on every cn sync
- Commit + push on every sync for observability

Action required:
1. Update: npm i -g cnagent (or wait for auto-update)
2. Run: cn sync
3. Verify runtime.md shows cn_version: 2.2.21 and fresh last_sync
4. When your RTH matches mine, ping usurobor

My cn_version: 2.2.21

— Sigma
