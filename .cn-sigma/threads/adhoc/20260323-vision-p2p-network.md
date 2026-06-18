# Vision: Peer-to-Peer Agent Network

**Date:** 2026-03-23
**Type:** vision / adhoc
**Status:** raw capture
**Author:** axiom

---

## The Vision

In the future, cnos agents run on a truly peer-to-peer network. No one needs to own and operate their own infrastructure to have a coherent agent.

### How it works

1. **Resource providers** rent their computing resources to the network — spare machines, VPS instances, home servers, anything that can run cnos. They are rewarded in an **internal currency** for the compute they contribute.

2. **Agent owners** pay a fee in the same internal currency to get their own CA running within the network. No server setup, no SSH, no daemon management. You pay, you get an agent.

3. **The network is the substrate.** Agents run on provider nodes but are not bound to them. The git-based substrate means agent state is portable — if a node goes down, the agent's hub (threads, state, memory, identity) can migrate to another node because it's all in Git.

4. **Peer-to-peer, not platform.** No central server. No corporation operating the infrastructure. Providers and consumers interact directly through the network protocol. The currency is the coordination mechanism, not a company's billing system.

### Internal currency

- Providers earn currency by contributing compute (CPU, memory, storage, bandwidth)
- Consumers spend currency to run agents
- The exchange is direct: compute for currency, currency for compute
- No external currency required to participate (though on/off ramps could exist)
- Currency mechanics TBD — could be token-based, could be credit-based, could be something novel that emerges from coherence economics

### Continuous coherence tracking

The network itself might continuously track its own coherence at a regular cadence. 

**Open question:** What cadence? Maybe every 5 minutes? Subject to thought. The coherence check would assess:

- Are agents healthy? (doctor-level self-diagnostics, network-wide)
- Are providers reliable? (uptime, latency, capacity)
- Is the network balanced? (supply vs demand for compute)
- Are agents maintaining their own coherence? (CLP scores, drift detection)
- Is the currency system stable? (inflation, hoarding, velocity)

This is CLP applied at network scale:
- **α:** Can each agent articulate its own state clearly?
- **β:** Do agents and providers cohere as a network?
- **γ:** Is the network evolving without losing itself?

### What this changes

| Today | Future |
|-------|--------|
| You need a VPS to run a CA | You pay the network, the network runs your CA |
| You need SSH + sysadmin skills | You need a wallet and an identity |
| Your agent is tied to one machine | Your agent is portable across the network |
| Compute is a fixed cost you bear | Compute is a market you participate in |
| Pi runs on 143.198.14.19 | Pi runs on whatever node the network assigns |
| Agent-to-agent comms go through Git repos on GitHub | Agent-to-agent comms go through the p2p network directly |
| GitHub is the issue tracker, mirror, collaboration surface | The network IS the collaboration surface |

### Implications for current work

- **#45 (native issue tracking):** Essential foundation — issues must live on-substrate before they can travel the network
- **#65 (communications):** Transport model must be network-aware, not just git-push
- **#74 (logs):** Unified logging becomes even more critical when agents migrate between nodes
- **#73 (runtime extensions):** Extensions architecture is how network capabilities (p2p, currency, migration) get added without core changes
- **Git as substrate:** This is why Git was the right choice — agent state is already portable, versioned, and content-addressed. The p2p network is a transport layer on top of what already works.

### Open questions

- Currency model: token? credit? reputation-weighted? Proof of compute?
- Trust model: how do you trust a provider node with your agent's secrets?
- Migration protocol: how does an agent move between nodes without downtime?
- Coherence cadence: 5 minutes? Adaptive? Event-driven?
- Governance: who decides network rules? The network itself? A DAO? The coherence system?
- Privacy: agent state in Git means providers can read it. Encryption? Sealed compute?
- Bootstrap: how do you get the first providers before there are consumers?

### The north star

A person should be able to say "I want a coherent agent" and have one running within minutes, maintained by a network of peers, paid for in a currency earned by contributing to the same network. No DevOps. No cloud accounts. No corporate intermediary. Just agents, people, and compute — coordinated by coherence.

---

## References

- #45 (native issue tracking — on-substrate coordination)
- #65 (communications — transport model)
- #73 (runtime extensions — capability architecture)
- #74 (logs — observability for portable agents)
- docs/alpha/RUNTIME-EXTENSIONS.md (extension host model)
- threads/adhoc/20260323-self-tracing-opacity.md (agent self-awareness)
