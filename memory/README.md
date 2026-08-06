# Reflections — the r1+ compaction tower

Home **is** Sigma. This directory holds the rank-1-and-up reflection tower that
lives ON HEAD. Raw evidence (r0) does not live here — it is transported
off-HEAD (see `../_r0-box/README.md`).

## Rank ↔ cadence model (#690 / #698)

| Rank | Cadence | Directory | What it is |
|---|---|---|---|
| **r0** | continuous | `../_r0-box/` (off-HEAD) | Raw evidence: adhoc, activation logs, rca, coordination surfaces. Fans out. |
| **r1** | daily | `r1/` | Daily compactions that cite r0. |
| **r2** | weekly | `r2/` | Weekly rollups compacting r1. |
| **r3** | monthly / quarterly / half-yearly | `r3/` | Longer-horizon rollups compacting r2 (and lower r3). |

`r0 fans out / r1 funnels in` — home is the sole compactor. Each rank is a
compaction of the rank below, citing it. HEAD holds only the r1+ tower plus
spec, state, and scripts; r0 evidence is preserved off-HEAD, never on HEAD.

## Contents

- `r1/` — daily reflections (was `threads/memory/daily/`).
- `r2/` — weekly reflections (was `threads/memory/weekly/`).
- `r3/` — monthly, quarterly, and half-yearly reflections (was
  `threads/memory/{monthly,quarterly,half-yearly}/`).

No rollups were fabricated during the #704 migration — every file here is a
relocation of an existing reflection into its correct rank. `git log --follow`
recovers each file's full history.
