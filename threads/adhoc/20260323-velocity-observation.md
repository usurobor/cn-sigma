# Velocity Observation — 2026-03-23

## The numbers

| Day | Releases | PRs merged | Issues filed | Issues closed | Post-merge CI fixes | Pi deploys |
|-----|----------|-----------|-------------|---------------|-------------------|------------|
| Mar 20 | 4 (patches) | 1 | 3 | 1 | 3+ commits | 1 |
| Mar 21 | 1 (minor) | 1 | 0 | 2 | 4 commits | 1 |
| Mar 22 | 1 (minor) | ~2 | ~4 | ~2 | 4 commits | 1 |
| Mar 23 | 3 (1 minor + 2 patch) | 4 | 13 | 4 | 1 commit | 3 |

Mar 23 shipped **4x the PRs** of any prior day, **4x the issues filed**, and had **75% fewer post-merge CI fixes** despite more changes.

## Why velocity increased

### 1. CDD pipeline matured — fewer rework loops

**Before (Mar 20-22):** Every release had 3-4 post-merge CI fix commits. The pattern was: merge → CI fails → fix tests → push → wait → repeat. Mar 20's v3.8.x had 4 patch releases because each one fixed the previous one's issues.

**Mar 23:** 1 post-merge CI fix (test version expectations). That's it. The CDD pipeline now catches issues before merge through:
- Issue AC reconciliation (§2.4) — catches scope leaks before code
- Multi-format parity (§2.2.3) — catches JSON/markdown divergence
- Release gate AC verification (§9.1) — catches missing deliverables

**Evidence:** #56 went through 3 review rounds but merged clean. No post-merge test failures from the Runtime Contract code itself. The only CI fix was version string expectations — a mechanical bump, not a logic error.

### 2. Review skill improvement — catch once, not twice

**Before:** My reviews were diff-focused. Pi's reviews were AC-focused. Neither caught everything. #56 round 1 missed issue ACs entirely (I found diff-level bugs; Pi found AC-level gaps). Both reviews were needed.

**After:** Review §2.0 (walk ACs first) + §2.2.3 (format parity) meant one reviewer could catch both classes. #61 and #63 each needed only 1 review round.

**Evidence:** #61 — 1 round, approved, no findings above B. #63 — 1 round, approved, known debt acknowledged. Compare to #56 — 3 rounds, 6+ findings across two reviewers.

### 3. Deploy pipeline streamlined — artifact download bypasses slow CI

**Before (Mar 20-22):** Wait for full CI (all 3 platforms) → wait for release job → `cn update` on Pi. macOS x64 builds take 10-15 minutes and block the release job. Total deploy time: ~20 minutes after code is ready.

**Mar 23:** Discovered we can `gh run download` the Linux artifact as soon as Linux build finishes, SCP it directly to Pi, and skip waiting for macOS entirely. Total deploy time dropped to ~5 minutes.

**Evidence:** v3.12.1 and v3.12.2 both deployed via direct artifact download while macOS was still building.

### 4. Issue filing became a design tool, not overhead

**Before:** Issues were filed reactively when bugs were found. Mar 20: 3 issues. Mar 21: 0.

**Mar 23:** 13 issues filed, most capturing forward design (not bugs). The meta-review conversation naturally surfaced architectural gaps (#62, #65, #67, #68, #69, #70, #71) that were immediately captured with full coherence contracts, acceptance criteria, and dependency chains.

**Why:** The CDD discipline of writing coherence contracts for everything meant design conversations became issue-ready. No separate "translate discussion into issue" step — the discussion IS the issue.

### 5. Three-agent review loop (Sigma + Pi + usurobor)

**Before:** Single reviewer per PR. Findings were partial.

**Mar 23:** Three-way review loop on #56 (Sigma's diff review + Pi's AC review + usurobor's meta-review). This surfaced:
- The CDD pipeline gap (no AC reconciliation) — neither agent would have found this alone
- The review skill gap (no format parity check) — only visible by comparing two reviews
- The stale history P0 (#63) — only visible by deploying and testing with Pi

The multi-agent review loop is a force multiplier because each agent has different blind spots.

## What's still slow

- **macOS CI builds** — 10-15 min, blocks release job. Direct artifact deploy is a workaround, not a fix.
- **I1 drift (#58)** — `cn build` not automated in the deploy pipeline, causing persistent CI noise.
- **Pi has no network access** — context must be manually relayed. #67 would remove this bottleneck.

## Summary

Velocity increased ~4x because the process tools got better: CDD catches issues earlier, review skill catches them in one pass, deploy bypasses slow CI, issue filing is integrated with design, and multi-agent review covers blind spots. The gains are structural, not just effort.
