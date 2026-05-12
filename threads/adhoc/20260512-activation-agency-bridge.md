# Activation-Based Agency Bridge — #311 Design Input

Status: captured for #311 (triadic-agent contract) design phase
Source: operator conversation 2026-05-12

## Core reframing

The positive definition first: agents are sequences of activations leaving receipts in a hub, scheduled by a runner. This dissolves the category error in dominant paradigms:

### Vocabulary mapping to cnos

| Activation-based term | cnos surface | Issue |
|---|---|---|
| Hub | run state + artifacts + attempt log | #311, #329 |
| Runner | bounded triad runner | #329 |
| Activation | bounded identity-task dispatch | #310 |
| Receipt | attempt record + witness | #311 |

### Three paradigm rejections

1. **Tool-loop agents (ReAct, function calling):** agent = loop; state in conversation context. Rejected — the agent isn't the loop, the runner is. The agent is what gets activated inside one step and doesn't exist between steps.

2. **Multi-agent frameworks (AutoGen, CrewAI, LangGraph):** agents are persistent personas passing messages. Rejected — no stateful actor; each activation is fresh, context loaded from the hub. Memory is in the hub, not in the agent.

3. **Autonomous agents (AutoGPT, SWE-agent):** agents have goals, plan, execute, reflect over long horizons. Rejected hardest — "autonomy" is a property of runner + profile, not of any activation. No single activation is autonomous. The illusion of autonomy emerges from the runner choosing to keep activating.

### Closest honest analog

Workflow engines (Temporal, Step Functions) + three additions:
- Activations are identity-shaped (they carry a lens)
- Receipts are richer than return values (artifacts + debt + witness)
- Hub is content-addressable artifact space, not just event log

### What it dissolves

- "Is the agent alive between calls?" — badly framed. Activations don't persist; receipts do.
- Failure modes localize: bad activation, missing receipt, confused hub, broken runner — mechanically distinct.
- "One risk per move" makes failure classification tractable (named as editorial choice, not fact — real activations can fail compoundly).
- Single closing rule kills "the agent decided it was done." Closure is receipt-log property.

### Two tensions to address in #311

1. **Hub-loading cost.** Every move pays a context-load tax. Argues for narrower identities. Runner's real job may be minimizing hub→activation hydration, not just sequencing.

2. **"One risk per move" is a discipline.** Real activations fail compoundly. The rule says: classify the primary risk and route. Right editorial choice, but must be named as a choice.

### Bridge to CDD

The triad runner (#329) is one runner over one hub with one profile. δ is exactly "the receipt named a failure the profile can't close on" — a property of the receipt log, not a role. Same move activation-based agency makes at the framing level. Same idea at two altitudes.

## Where this lives in cnos

- Essays: `ACTIVATION-NOT-DEPLOYMENT.md` and `AGENT-CONTINUITY.md` ship the core vocabulary
- Issues: #310, #311, #329 are the implementation specs
- Gap: no shipped artifact connects the two altitudes. This bridge text is the missing link.
- Natural home: #311 design note (AC1 requires comparing against tool-loop/multi-agent/autonomous paradigms)
