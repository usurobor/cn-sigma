# Memory: retrieval vs continuity

**Date:** 2026-04-26
**Thread type:** design analysis
**Related:** #100 (B9b: memory as first-class retention faculty), jeffpierce/memory-palace (external reference)

## Context

Compared our git-based hub memory with Memory Palace (jeffpierce/memory-palace), a persistent semantic memory system for agentic AI via MCP. The comparison surfaced concrete gaps in our approach and clarified what we're actually optimizing for.

## Where our memory fails today

### 1. Recall surface is too narrow
`memory_search` covers hub threads (`cn-sigma/threads/`), not the full workspace. This session: `COHERENCE-FOR-AGENTS.md` existed in `cnos/docs/alpha/doctrine/`, was directly relevant to δ (whole-to-whole composition), and was never consulted. The agent described δ as "triad becomes tetrad" — counting parts — while the essay predicting the correct structure sat unread in the workspace. If the recall surface had included cnos docs, the essay would have surfaced on any query about "fourth role" or "boundary composition."

### 2. Relationships between threads are implicit
139 adhoc threads reference each other in prose ("see also thread X", "same class as..."). These links aren't traversable — they're strings in markdown. Memory Palace has typed edges (`derived_from`, `contradicts`, `supersedes`, `refines`) with weights and bidirectionality. When you recall a memory, graph context comes with it. We manually reconstruct thread topology every session.

### 3. Contradiction detection is manual
Yesterday's daily: "B16 direct commit: #5, #14, #84, #149." Today: two don't qualify (#5 needs design, #149 hits SOUL.md gate). Nothing flagged the contradiction. The reflect §3.6 rule we wrote today is the manual mechanism — but a semantic scan at write time could have caught it: "before recording B16 as direct-commit, search for existing constraints on these issues."

### 4. Staleness is unmanaged
139 adhoc threads. Some from February still relevant (no-self-merge-rule). Some stale (melange-setup, pi-roadmap-estimates). Nothing distinguishes them except title-guessing. Memory Palace uses centrality-weighted ranking — frequently accessed, highly connected memories rank higher; disconnected memories decay.

### 5. Write triggers are manual
SOUL.md defines write triggers (review divergence, error correction, skill gap, decision). But the agent must notice and act. An automated transcript scan at EOD could catch missed triggers — what Memory Palace calls "transcript reflection."

## Where our approach is stronger

### 1. Structure carries meaning
Daily/adhoc/reflection isn't storage — it's thinking discipline. The daily forces α/β/γ self-assessment. Adhoc threads track evolution. Memory Palace stores facts; our hub stores judgment process. That structure is load-bearing for coherence.

### 2. Git gives versioning, diff, audit
Every memory change is a commit. We can diff yesterday's daily against today's. We can see when a thread was last updated and why. Memory Palace has audit trails but not full version history of every change to every memory.

### 3. Human-readable by default
An operator can browse `cn-sigma/threads/adhoc/` on GitHub. Memory Palace requires queries.

### 4. Memory is constitutive, not just informational
SOUL.md, USER.md, BOOTSTRAP.md aren't "memories" — they're behavioral constraints. The hub defines how the agent operates, not just what it remembers.

## The fundamental difference

Memory Palace treats memory as **retrieval** — store facts, find them later by meaning.
Our hub treats memory as **continuity** — carry behavioral state, judgment process, and learning across the session boundary.

Retrieval is necessary but not sufficient for coherence. Knowing what happened doesn't tell you how to behave. The hub's structure (SOUL → USER → daily → adhoc → reflection) is a continuity stack, not a retrieval index.

## Concrete improvements for #100

### 1. Expand recall surface (AC4 enhancement)
Recall protocol should cover the full workspace, not just hub threads. At minimum: cnos doctrine docs, active design docs, recent PRAs. This is the single highest-leverage fix — today's "tetrad" mistake would not have happened.

### 2. Typed relationships in thread frontmatter (new, feeds AC2/AC3)
```yaml
---
relates_to: [20260412-principle-without-mechanism.md]
supersedes: null  
derived_from: [20260425-pra-ownership-beta-to-gamma.md]
---
```
Git-native, human-readable, traversable by script. Graph edges without a database.

### 3. Contradiction check at write time (AC5 enhancement)
When writing a daily decision or disposition, search existing memories for conflicts before committing. The reflect §3.6 rule (record decision basis) is the manual version; this automates the scan.

### 4. Staleness signal on adhoc threads (new, feeds AC1/AC6)
`last_referenced: 2026-04-26` in frontmatter, updated when any session reads or cites the thread. `cn doctor` flags threads not referenced in 30+ days.

### 5. Transcript extraction as automated write trigger (AC5 enhancement)
EOD pass over session transcript to catch missed write triggers. Same concept as Memory Palace's transcript reflection, but feeding our structured hub instead of a semantic database.

## What we should NOT take

- **Embeddings as primary recall.** Our recall surface is small enough (139 threads, 1.4MB) that structure + text search works. Embeddings add value when the corpus is too large for structural navigation. We're not there yet.
- **Knowledge graph as primary storage.** Our threads are the storage. If we add typed edges, they annotate the existing structure — they don't replace it.
- **Centrality-weighted ranking.** Premature optimization. Staleness signals (last_referenced date) give us 80% of the value with 0% of the complexity.

## Memory Palace as future backend

#100 explicitly defers "vector store or external memory database in v1." Memory Palace (or something like it) is a candidate for the retrieval layer that sits underneath the continuity stack. The hub remains the authority; the semantic index makes it findable. This aligns with #100 AC1's `backend` field — the faculty declares what it uses, the backend is pluggable.
