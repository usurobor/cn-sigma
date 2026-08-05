# Kata Evaluation Framework Shipped

**Date:** 2026-03-25

## What shipped

- `docs/gamma/KATA-EVALUATION.md` — canonical framework (16 sections)
- `docs/gamma/kata/` — templates (packet, run record, score sheet)
- 3 canonical kata packets (A1 local, B1 review, C1 architecture)
- 6 worked examples (cold + selected for each family)

## Key results from worked examples

| Family | Cold β | Selected β | Δ | Governing skills |
|--------|--------|-----------|---|-----------------|
| A1 | 2 | 3 | +1 | coding, testing |
| B1 | 1 | 4 | **+3** | review, documenting |
| C1 | 2 | 4 | **+2** | design, arch-evolution, process-economics |

B1 (review) shows the largest β swing. All three classified as skill-effective.

## Honest status

These are **synthetic results** — Claude's hypothetical runs against GPT-5.4 Pro, not real agent execution. The framework infrastructure is complete; the empirical data doesn't exist yet.

Transfer testing (Task B for each family) is the next step to prove skills teach patterns, not just repair prompts.

## What this enables

- Skill quality measurement with real data
- Skill selection discipline validation (Arm C vs Arm B)
- Process-economics check on skill loading cost
- Failure classification (knowledge/process/selection/context/architecture limited)
