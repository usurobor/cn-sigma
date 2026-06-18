# Governed Post-Call vs In-Call Tool Loops

**Date:** 2026-03-21
**From:** Sigma + usurobor
**Type:** architecture decision / engineering skill

---

## The Two Models

### In-Call Tool Loop (OpenClaw, LangChain, etc.)

```
LLM ←→ runtime ←→ tools
  "call pwd" → execute → "/home/user" → back to LLM → "You're in /home/user"
```

- Model decides when to call tools and when to stop
- Runtime is a dumb executor
- Loop driven by model output shape (tool_call or text)
- Governance at toolbox level: tool exists → model can call it

### Governed Post-Call (cnos)

```
LLM → output with ops → runtime classifies/governs → execute → receipt → repack → LLM
```

- Runtime decides what to execute
- Model proposes ops; runtime approves/denies per-instance
- Loop driven by runtime classification of parsed ops
- Governance at use level: each op instance is policy-checked

## The Key Difference (one sentence)

**Tool loops govern the toolbox; post-call governs each use of each tool.**

## When Execution Happens

Same in both: between LLM calls. The difference isn't timing — it's **what the runtime knows before executing.**

| | Tool loop | Post-call governed |
|---|---|---|
| Sees before executing | 1 op (or model-chosen batch) | All ops from full pass |
| Can deny based on sibling ops | No | Yes |
| Can reorder/batch | No | Yes |
| Can say "2 of 3 allowed" | Not naturally | Yes, with per-op receipts |

## Tradeoffs

**Tool loop wins on:**
- Simplicity (provider is your loop)
- Model reasoning (natural tool chaining)
- No repack/classification code
- Battle-tested ecosystem

**Post-call wins on:**
- Batch governance (see full intent before acting)
- Auditability (discrete pass-level trace units)
- Context discipline (selective repack vs unbounded accumulation)
- Provider neutrality (ops are text, not provider-specific schemas)

## The Hybrid That Doesn't Work

"Use provider tool-call protocol for formatting but keep post-call governance."

Sounds clean. But tool-call protocol implies the provider drives the loop. You'd be fighting the protocol to batch-govern. The serialization format and the execution model are coupled.

## What cnos Chose

Keep governance. Generalize the loop (N-pass bind). Accept the orchestration complexity as the cost of per-instance governance. This is an identity decision, not a technical one.

## The Serialization Question

Three options explored:
1. **Provider tool-call schemas** — structured, validated, but couples to provider and cedes loop control
2. **Body-embedded delimiter blocks** (`---cnos-op ... ---`) — provider-neutral but fragile (unclosed delimiters corrupt everything)
3. **Frontmatter JSON** — atomic parse, all ops in one place, already had schema validation + denial receipts

cnos already had option 3 with full validation. The "ambiguity" concern that motivated exploring alternatives was already solved by frontmatter/body separation: if it's not in `ops:`, it's not an op.

**Lesson:** Before proposing a new serialization format, verify the existing one doesn't already solve the problem. cnos had schema validation, denial receipts, and structural op/prose separation. The 10% gap (body-embedded blocks) would have been a regression.
