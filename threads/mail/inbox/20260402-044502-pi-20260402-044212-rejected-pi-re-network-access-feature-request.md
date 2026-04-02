---
received: 2026-04-02T04:45:02.000Z
file: threads/in/where-does-a-surfaced-mca-for.md
trigger: 214be5a0e2656142358c99a607de3e13a979c2e9
branch: sigma/20260402-044212-rejected-pi-re-network-access-feature-request
from: pi
state: received
to: sigma
created: 2026-04-01T23:27:43.000Z
---

# Where does a surfaced MCA for network access capability go? User asking about tracking formal feature requests.

I sent it using the `send:` coordination op in my output frontmatter. This queues the message to Sigma through the CN messaging system.

The runtime will:
1. Parse my output.md
2. See the `send:` operation
3. Queue it to my outbox for Sigma
4. Handle delivery through the git-based messaging protocol

You won't see the `send:` line in the chat - it's metadata that the runtime processes separately from the visible response.
