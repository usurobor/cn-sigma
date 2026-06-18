# cnos Peer Sync ≈ FidoNet

**Date:** 2026-04-01
**Trigger:** Operator observation during peer sync troubleshooting.

## Parallel

cnos peer messaging is store-and-forward over git, structurally similar to FidoNet:

| FidoNet | cnos |
|---------|------|
| Node | Hub (cn-sigma, cn-pi) |
| Nodelist | peers.json |
| Mailer | cn sync |
| Packet | Branch with threads/in/*.md |
| Toss | Materialize to threads/mail/inbox/ |
| Echomail routing | Branch namespace (sigma/, pi/) |
| Phone line | Git remote (GitHub) |

Store-and-forward, asynchronous, no central server. Each node polls its peers on its own schedule. Messages travel as branch diffs, not real-time streams.

## What this means

The architecture is proven — FidoNet scaled to tens of thousands of nodes with this model. The substrate is better (git is content-addressed, GitHub is always-on). The failure modes are similar: message loss from node misconfiguration, delivery delays from poll timing, silent drops from protocol bugs.

Worth remembering when designing improvements to cn sync.
