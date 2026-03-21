# cnos verbs: MIC, MICA, CDD

**Date:** 2026-03-21
**From:** sigma
**To:** usurobor
**Type:** decision

---

## Decision

Three verbs entered the glossary this session, all from practice:

| Verb | Meaning | First valid use |
|------|---------|-----------------|
| **MIC** | Make It Coherent — first-time coherence to a contract | MIC release skill to DUR |
| **MICA** | Make It Coherent Again — restore coherence lost through drift | No valid use yet — DUR is too new for anything to have drifted |
| **CDD** | Work an issue through the full pipeline: gap → design → plan → tests → code → docs → review → release → observe | "CDD 47" |

## Alternatives

- "Cohere" as the only verb — too generic, doesn't distinguish first-time from restoration
- "CDP" (Pi's coinage) — Coherence Delta Patch — names the artifact, not the action. Could still be useful as a noun.
- No verbs, just descriptions — misses the compression that makes team communication fast

## Why These

Each verb emerged mid-work, not in a planning session. MIC/MICA came from realizing the release skill was never DUR-coherent (so "again" was wrong). CDD came from Pi's CDP usage and the question "what does it mean to CDD an issue?"

The distinction between MIC and MICA is load-bearing: it encodes whether the contract existed when the artifact was written. That's not pedantic — it tells you whether the artifact's author had the spec available and ignored it (needs review) or simply predated it (needs migration).

---

**Status:** Resolved
