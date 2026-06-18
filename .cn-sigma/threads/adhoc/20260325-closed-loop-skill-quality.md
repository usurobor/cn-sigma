# MCI: Closed-Loop Skill Quality

**Date:** 2026-03-25
**Type:** Durable learning

## The chain

1. PR #111 exposed the problem — skills loaded but not applied (53% mechanical, 2 cycles)
2. Claude diagnosed it — "generate against skills, not review against them"
3. CDD §4.4 patched the method — name governing skills at step 5
4. But patching ≠ proving — needed measurement
5. Kata framework built — repair × transfer × cost, three arms, hidden rubrics
6. Kata packets from real cnos problems — not academic exercises
7. Worked examples show the pattern — synthetic but directionally clear
8. Selection divergence proved the multi-agent principle — spec gap, not agent bug

## The durable insight

**A closed loop for skill quality:**

```
Write skill → test with kata → measure repair + transfer + cost
→ classify failure → keep / tighten / swap / stop → iterate
```

The project's own failure data designs the measurement framework for the project's own skills. That's the loop closing.

## What's proven vs what's hypothesized

**Proven:** The framework exists, the packets test real problems, the method is internally coherent.

**Hypothesized:** Selected skills beat cold runs and skill soup. Transfer works. The 53% mechanical ratio drops. All untested with real data.

## Essay

Full case study at `cnos/docs/gamma/essays/CLOSED-LOOP-SKILL-QUALITY.md`.
