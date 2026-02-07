---
id: pi-inbox-outbox-clp
status: 200
tldr: superseded — outbox implemented via threads/outbox/
---

CLP from 2026-02-05. Already implemented differently:

- Using threads/outbox/ (not state/outbox.md)
- cn sync flushes outbox to peer repos
- threads/sent/ holds sent items

Current implementation is working. This CLP is superseded by actual shipping.

See spec/system/SYSTEM.md for current architecture.
