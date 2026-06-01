# Peers – v1.1.0

External peer **agents** — different personas with their own hubs and keys.

Not the same as `state/activations.md` (Sigma's own bodies at other repos).
A peer is another agent entirely (e.g., cn-rho the researcher persona,
backed by the cdr package, distinct from Sigma's engineer/cdd profile).

**Currently empty.** No peers registered.

Pending registration:
- **cn-rho** — researcher persona; cdr package profile. When cn-rho registers
  as a hub, **cph becomes one of cn-rho's activations** (per operator direction
  2026-06-01, when cph was removed from cn-sigma's activations list and
  reassigned to cn-rho's domain). cph's `cn-sigma` branch will eventually
  become a `cn-rho` branch or move to whatever convention cn-rho adopts;
  cn-sigma will read cn-rho's outputs cross-agent (peer↔peer), not
  cross-body (activation↔home).

Cross-persona comms convention (peer ↔ peer) is a different problem than
activation-log v0 (self ↔ self across bodies). When cn-rho registers, design
that convention then; YAGNI says don't prebuild.


```yaml
peers: []
```
