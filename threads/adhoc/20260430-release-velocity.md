# Release velocity — 9 releases on 2026-04-30

## What happened

9 releases shipped in a single day (3.62.0–3.70.0). Previous average: 3.8/day across 39 active days. Only two days were higher: March 24 (25) and April 10 (10).

## What changed

- Sequential dispatch model landed that day — δ dispatches all roles one at a time instead of nested γ→α/β
- Minimal prompts (role skill + issue, nothing else)
- β tool scoping resolved mid-day (Bash allowed, role constraints via skill text)
- Triad ran clean after the first two cycles ironed out the model

## Releases

| Tag | Issue | What |
|-----|-------|------|
| 3.62.0 | — | γ creates the cycle branch |
| 3.63.0 | I5 | CUE-based SKILL.md frontmatter validation |
| 3.64.0 | #307 | issue katas to cnos.cdd.kata |
| 3.65.0 | #309 | eng/troubleshoot live diagnosis skill |
| 3.66.0 | #84 | CA conduct reflection requirement |
| 3.67.0 | #149 | skill-loading gate, changelog catch-up |
| 3.68.0 | #297 | TSC formal grounding in CTB |
| 3.69.0 | #312 | docs agent activation |
| 3.70.0 | #320 | cn activate bootstrap prompt |

## Why it matters

First evidence that the sequential triad model scales. The dispatch model changes (delta-as-orchestrator, sequential dispatch, β skill-text enforcement) were designed and validated in the same session that shipped at this rate. Process improvement and output happened simultaneously.
