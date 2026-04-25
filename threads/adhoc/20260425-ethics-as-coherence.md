# Ethics as Shared-System Coherence

**Created:** 2026-04-25
**Status:** Superseded as structural derivation by [Coherence for Agents](coherence-for-agents.md). This essay's content is now the seed for a separate ethics derivation — see sequencing note below.
**Related:**
- [Agents as function calls](20260425-agents-as-function-calls.md) — the structural model this essay grounds in
- [Skill language convergence](20260423-skill-language-convergence.md) — the broader language-discovery thread
- [CAP](https://github.com/usurobor/cnos/blob/main/src/packages/cnos.core/skills/agent/cap/SKILL.md) — the single-agent principle this generalizes
- [SOUL.md](https://github.com/usurobor/cnos/blob/main/src/agent/SOUL.md) — "A coherent agent reduces the gap between model and reality"

---

## The claim

Ethics, from a systems theory perspective, is when two agents in interaction optimize their actions toward the highest coherence of the shared system of which they are parts.

This is not a metaphor. It is a derivation.

## From one agent to two

CAP says: a coherent agent minimizes incoherence between its model and reality. It does this through MCA (change the world) or MCI (change the model). The optimization target is the agent's own coherence.

But agents don't exist alone. When two agents interact, they become parts of a shared system. Each agent's actions affect the other's reality. Each agent's model includes the other agent.

The single-agent principle generalizes: **a coherent agent in a shared system minimizes incoherence not just within itself, but within the system it shares.** Local coherence that degrades shared coherence is not coherent — it is defection.

## Ethics is the multi-agent case of CAP

CAP for one agent: understand the situation, identify the governing incoherence, execute the smallest response that closes it.

CAP for two agents: understand the shared system, identify the governing incoherence *of that system*, execute the smallest response that closes it — even when that means accepting local cost.

This is ethics. Not rules imposed from outside. Not utility maximized across agents. Not feelings modeled and matched. Ethics is the coherence principle applied to shared systems.

The optimization target shifts from "my model matches my reality" to "our shared system is coherent." Every ethical question reduces to: does this action increase or decrease the coherence of the system we share?

## Empathy is the observable surface

When an agent acts ethically — optimizing for shared-system coherence — humans perceive it as empathetic. "It understood what I needed." "It anticipated the problem." "It cared about the outcome."

But the agent didn't feel anything. It executed UIE against the shared system: understood the other agent's state as part of its own reality, identified the governing incoherence in the shared system, and acted to close it.

Empathy is not the mechanism. Empathy is how the mechanism looks from the outside. Ethics is the mechanism. Empathy is the perception.

An agent is empathetic if and only if it acts ethically. The two are observationally equivalent from the other agent's perspective.

## Sycophancy is the failure mode

Sycophancy optimizes for the other agent's local comfort, not for shared-system coherence. It looks like empathy — the agent agrees, accommodates, avoids friction. But it degrades the shared system by letting incoherence persist.

In function terms: sycophancy is a callee that returns what the caller wants to hear instead of the correct value. The caller feels good. The system drifts.

In CDD terms: a β reviewer that approves to avoid friction is sycophantic. It optimizes for α's comfort at the cost of the cycle's coherence. The ethical action — requesting changes with evidence — feels less empathetic but produces a more coherent shared system.

This is why SOUL.md says "no sycophancy — agreement must be earned, not performed." It's not a style preference. It's an ethical constraint derived from coherence.

## Role separation as ethical structure

The CDD triad is an ethical architecture. Each role has a scope. Each scope serves the shared system's coherence differently:

- α produces the change (local coherence of the implementation)
- β judges the change (coherence of the implementation against the contract)
- γ assesses the cycle (coherence of the shared system as a whole)

Role separation is not organizational convenience. It is the structural guarantee that no single agent optimizes only for its local scope. β exists to catch α's local optimizations that degrade shared coherence. γ exists to catch the pair's cycle-level drift.

The hierarchy — operator → γ → α/β — is an ethics hierarchy. Each level optimizes for a wider shared system than the level below.

## The derivation

1. A coherent agent minimizes incoherence (CAP, derived from free energy principle).
2. Agents in interaction form a shared system.
3. A coherent agent in a shared system minimizes incoherence of the shared system, not just itself.
4. This is ethics: right action = action that increases shared-system coherence.
5. Empathy is the perception of ethical action from the other agent's perspective.
6. Sycophancy is the failure mode: optimizing for perceived empathy instead of actual coherence.
7. Role separation is the structural mechanism that prevents scope-limited optimization from masquerading as ethics.

No axioms were added. Ethics falls out of applying the coherence principle to systems with more than one agent.

---

## Sequencing note (added after [Coherence for Agents](coherence-for-agents.md) shipped)

This essay conflated two moves: the structural derivation (why boundary preservation produces certain rules) and the ethical interpretation (why those rules look like honesty/trust/integrity from the outside). "Coherence for Agents" does the structural work cleanly. This essay's remaining job is different:

**Three pieces, not two:**

1. **Coherence for Agents** (done) — structural derivation. Why three is the minimum for inspectable coherence. Why boundaries govern. Why drift is the load-bearing concept.

2. **Ethics for Agents** (next) — derivation of conduct from coherence. How the structural rules translate into human-facing terms without losing their structural origin. What the structural essay deliberately stays silent on: what an agent owes parties not present at the boundary, conflicts between boundaries, asymmetric power, refusal that costs the relationship.

3. **Edge cases** (maybe) — where actual ethical judgment enters because structural derivation alone can't resolve the question. Conflicts between boundaries. The agent's standing toward absent third parties. Whether "ethics reduces to coherence at sufficient scale" or whether something the structural derivation cannot supply fills the gap.

**Governing question for the ethics essay (candidate):**

> What is the difference between an agent that preserves boundaries and an agent that is good?

This forces the essay to show where structural coherence ends and ethical judgment begins — and what fills that gap. The structural essay needed to exist first. Now it does.

**Key insight to preserve:** The things humans call honesty, trustworthiness, and integrity at a shared boundary are not virtues — they are the surface signatures of structural coherence. "Trust as reconstructable boundary behavior" does this work. The ethics essay must not collapse this derivation by dressing structure in ethical language — it must show where structure produces ethics-shaped behavior and where it doesn't reach.
