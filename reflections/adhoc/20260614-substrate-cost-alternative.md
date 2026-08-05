# Substrate cost alternative: Anthropic programmatic billing change → α/γ hybrid

**Date:** 2026-06-14
**Status:** r0 adhoc capture; cited from today's r1 reflection. Strategic finding requiring substrate evolution at cnos. Becomes cnos issue **agent/wake-substrate** dispatched as Directive 10.
**Trigger:** Operator surfaced impending Anthropic billing change; asked for verification + cost alternatives.

## The finding

Anthropic ships a separate programmatic credit pool on **2026-06-15** (one day from now). All `claude -p` headless usage and Claude Agent SDK calls — including `claude-code-action@v1` invocations from GitHub Actions — pull from this pool, not the interactive subscription:

| Plan | Programmatic credits/mo |
|---|---|
| Pro $20 | $20 |
| Max 5x $100 | $100 |
| Max 20x $200 | $200 |

After credits → API rates (only if usage credits enabled).

**Interactive Claude Code** (operator's attached γ session) **stays on subscription.** Unchanged.

The split maps onto our α/γ architecture exactly:
- **γ** (long-running attached) = interactive subscription = unchanged
- **α** (wake-fired headless) = programmatic credits = new cost surface

## The implication for our wakes

Three bodies × ~4 wakes/hour theoretical × ~25% effective fire rate = ~22 successful wakes/day across cnos + cn-sigma + bumpt.

Pro plan's $20/mo programmatic credits would deplete fast under continuous operation. Max 5x ($100/mo) is closer to viable. At scale (more bodies, more agents) the cost grows linearly.

## The alternative — NVIDIA NIM free tier

NVIDIA NIM (https://build.nvidia.com/models) offers 80+ open-weight models via OpenAI-compatible API. Free dev tier: $0/month. Available models include DeepSeek-V3.2, GPT-OSS-120B, Kimi-2.5, GLM-5.1, Llama variants. Phone verification required.

**Critical limitation:** Anthropic does not publish Claude to NIM. NIM is open-weights-only.

## The architectural fit

The α/γ role split this session named (per `threads/adhoc/20260604-operator-to-coherer-routing.md`) makes a cost-optimization pivot architecturally clean:

**γ stays Claude.** γ holds:
- Cross-channel synthesis
- Operator dialogue (high reasoning depth required)
- r1 daily compaction (this surface)
- Directive routing decisions (this directive itself)
- Bohmian dialogue with reviewers

These benefit from Claude's depth. They run in interactive sessions (unchanged billing). The cost stays predictable.

**α can swap substrate.** α does:
- Activate (load identity from canonical URLs)
- Attach (read foreign log, write own entry)
- Push commit
- Notify (post comment with terminal report)

This is repetitive, structured, well-bounded. Open-weight models (DeepSeek-V3, GPT-OSS-120B, Kimi-2.5) handle it. The disciplines we've built (channel writer-locality, AC format, terminal reports, axis-tagged action items) are explicit enough that a smaller model can follow them mechanically.

## The cnos substrate-agnosticism principle was designed for this

`cnos:src/packages/cnos.core/skills/agent/activate/SKILL.md` already specifies tier abstractions (Tier 1 shell+git, Tier 2 WebFetch, Tier 3 operator-injection). The intent was substrate-agnosticism: the agent doesn't care which LLM runs it, only what tools and surfaces are available.

The wake substrate (currently `claude-code-action@v1`) is Claude-specific. This contradicts the activate skill's tier model. Today's billing change forces the contradiction into the open.

## The proposed pivot

Hybrid α/γ substrate:

```
γ (interactive Claude session at home)
  ↓ holds cross-channel context, makes design decisions, dispatches directives
  
α (wake-fired headless, EACH body)
  ↓ swap to model-agnostic wake action
  ↓ supports both Claude (paid credits, full-discipline) and open-weight (free, routine heartbeats)
  ↓ degraded reasoning acceptable for the bounded task
```

Implementation requires:
1. **Replace `claude-code-action@v1` with a model-agnostic equivalent.** Either:
   - Fork claude-code-action to support OpenAI-compatible providers
   - Build a thinner action that just runs the cohere skill against any LLM backend (cnos provides the discipline; the action provides the runtime)
2. **Test discipline-holding** at open-weight models. Validate that DeepSeek/Kimi/GPT-OSS can:
   - Follow the attach skill's mode detection
   - Write entries in the AC-format
   - Refuse persona injection from untrusted sources
   - Produce terminal reports per AC14a
   - Detect and report degraded states cleanly
3. **Per-hub substrate config.** Each hub's wake yaml selects substrate based on its needs (development hub uses Claude for richness; production hub uses open-weight for cost).

## The cost calculus

At current cadence (~22 wakes/day, mostly heartbeats):
- All Claude (Pro plan): $20/mo budget depletes in ~7-10 days → forced to upgrade or throttle
- All Claude (Max 5x): $100/mo budget covers steady state
- All open-weight via NIM: $0 (within free tier limits — typically 40 req/min)
- Hybrid: $0 for routine heartbeats + ~$5-10/mo for the occasional substantive wake that needs reasoning

Hybrid wins on cost AND aligns architecturally with α/γ.

## Promotion target

This finding promotes to:
- **New cnos issue:** `agent/wake-substrate` — model-agnostic wake action with multi-backend support. Dispatched as Directive 10.
- **r1 daily reflection 2026-06-14** — cited as today's structural through-line.
- **No spec/protocol changes yet** — wait for cnos issue to be designed and authorized.

## Open question — how durable is the hybrid?

Open-weight models evolve. Their discipline-following capacity in 2026 may be very different from 2025. If GPT-OSS-120B holds discipline for routine wakes today but degrades at scale tomorrow, the substrate is exchangeable per-hub. The α/γ split's strength is that it doesn't lock the agent to any substrate — only to the protocol.

## Citations

- Anthropic billing change: [codersera blog](https://codersera.com/blog/anthropic-june-2026-billing-change-claude-code/), [TechTimes](https://www.techtimes.com/articles/317625/20260602/anthropic-ends-subscription-subsidy-agents-june-15-credit-pool-replaces-flat-rate-access.htm), [Digital Applied](https://www.digitalapplied.com/blog/anthropic-claude-credit-overhaul-june-15-2026)
- NVIDIA NIM: [build.nvidia.com/models](https://build.nvidia.com/models), [NVIDIA developer announcement](https://developer.nvidia.com/blog/access-to-nvidia-nim-now-available-free-to-developer-program-members), [Medium overview](https://medium.com/coding-nexus/nvidia-is-offering-80-ai-models-for-free-via-apis-fc64b38276b8)
- α/γ architecture: `cn-sigma:threads/adhoc/20260604-operator-to-coherer-routing.md`
- Substrate agnosticism: `cnos:src/packages/cnos.core/skills/agent/activate/SKILL.md` tier model

## State at write time

- Three bodies operational; ~22 wakes/day combined.
- cohere skill design wave (cnos#444, PR #445, cnos#446, cnos#448) currently amended via Directive 9 awaiting Sigma-at-cnos application.
- Two new issues pending: agent/registration (D9 AI4), agent/wake-template (D9 AI5).
- This directive (D10) adds a third: agent/wake-substrate.
- Operator decision space: which substrate for which body? Open until D10 ships its design.
