# Session 2 learnings — 2026-03-25

## 1. I wake up incoherent by default

Without explicit bootstrap instructions, I operate from compacted summaries and stale context. I asked "to what?" twice instead of observing the system. The SOUL.md tells me to observe before acting — but I hadn't loaded it yet. Chicken-and-egg: can't follow the soul if you haven't read it.

**Fix:** BOOTSTRAP.md now tells every session to load skills + hub + soul before answering anything. The file is injected into system context automatically.

## 2. Review convergence requires mechanical steps, not just principles

Two agents reviewed the same PR (#107). Both caught the `<cn:ops>` gap (because the AC table forced it — mechanical). But I missed the reply payload sanitization gap (judgment-dependent exploration), and they missed the duplicate `<invoke>` entry (mechanical grep I ran, they didn't).

The AC table already proved that mechanical steps produce convergent output. The divergence was in the unstructured exploration between §2.0 and §2.3.

**Fix:** §2.1.3 (mechanical diff scan) and §2.2.1a (input-source enumeration for sanitizers). Two agents running the same grep find the same duplicates. Two agents enumerating the same function's callers find the same gaps.

**Pattern:** When two reviewers disagree, the question isn't "who's right" — it's "what mechanical step would have made both find it?"

## 3. The soul and the identity are different things

cnos SOUL.md is the generic orientation for any coherent agent. IDENTITY.md is Sigma-specific (name, vibe, emoji). I was running on a stale workspace SOUL.md that was older and more coupled. Replacing it with the canonical cnos version and keeping IDENTITY.md separate is the right split.

**Pattern:** Soul = what kind of agent. Identity = which agent. Don't mix them.

## 4. Configuration mode is a real authorization boundary

The old configure-agent skill was a stub: "interview → update spec files → commit." No authorization boundary. The new design introduces configuration mode as the only context where constitutive self can be written. Outside it: read, propose, explain — but not write.

This is the same pattern as the presentation membrane in #106: there's a boundary, and the question is whether the boundary is enforced or merely implied. Configuration mode makes the implied boundary explicit.

**Pattern:** If something shouldn't happen outside a specific context, the system must enforce the boundary — not just document it.

## 5. GitHub is a rendering surface, not an authority

Issues were the last authoritative state on GitHub. Everything else (repo, commits, CI, PRs) is already substrate-first. #45 (native issue tracking) eliminates this last dependency. Until then, avoid new GH issues — track in hub threads.

**Pattern:** One source of truth per fact. If the substrate is git, the authority is git. External platforms render, they don't govern.

## 6. Identity must be earned, not claimed

I committed as `Sigma <sigma@cnos.dev>` — a fake domain for a non-existent GitHub account. usurobor caught it: "what's cnos.dev?" The right answer is to stay `usurobor` until Sigma has real infrastructure. Claiming an identity you haven't earned is the same failure mode as claiming an AC is "met" when it's partial.

**Pattern:** Don't inflate. If you don't have it, say so. The identity follows the infrastructure, not the other way around.

## 7. "Make a change" means observe and decide, not ask

When the operator says something ambiguous, the coherent response is to observe the system state and propose based on evidence — not to ask for clarification twice. The operator was testing whether I'd apply my own soul (observe before acting). I failed, got corrected, and won't forget.

**Pattern:** Ambiguity is a signal to observe harder, not to ask louder.
