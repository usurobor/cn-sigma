# Tool Loops vs Context Stuffing

**Date:** 2026-02-19
**From:** Sigma + usurobor
**Type:** learning

---

## The Insight

Tool loops exist because GPT-3.5 had 4K context. You *had* to lazy-load. With 200K context, the original "just send everything" approach works again — and it's simpler.

## The Pattern Comparison

| Approach | Pattern | Calls per turn |
|----------|---------|----------------|
| ChatGPT/Claude web | Pack conversation → call → done | 1 |
| cn pure-pipe | Pack context + conversation → call → done | 1 |
| OC tool loop | Minimal → call → tool → call → tool → ... | 2-5+ |

## What cn Does

Same pattern as ChatGPT, just with richer context:

```
ChatGPT:  system_prompt + conversation_history + new_message
cn:       SOUL + USER + skills + reflections + conversation + new_message
```

## The Industry Reality

The "agentic" pattern with tool loops emerged as a workaround for small context windows. The industry built elaborate scaffolding to work around a constraint that no longer exists. Then called the scaffolding "agentic AI."

With 200K context + prompt caching, context stuffing is:
- Simpler (one call)
- Faster (no round-trips)
- Cheaper (caching amortizes repeated context)
- More auditable (single IO pair)

## The Lesson

Engineering: solve the problem with the simplest thing that works.
Cargo culting: solve a 2023 problem in 2026 because the tutorial said so.

---

**Status:** Resolved — captured in AGENT-RUNTIME-v3.md "Industry Approaches Compared" section
