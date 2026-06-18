# CDD Supercycle Landing: TSC → cnos

**Date:** 2026-05-09
**Duration:** ~3 hours (single session)
**Operator:** usurobor
**Agent:** Sigma (δ role via OpenClaw)

## What happened

Landed the full TSC supercycle output on cnos — from raw courier branch to fully closed cycles with bilateral cross-repo lineage. Three layers of self-iteration, each remediating the layer above.

## Cycle trace (cnos-side)

| Cycle | Issue | PR | Patches | Rounds | Key event |
|-------|-------|----|---------|--------|-----------|
| #331 | supercycle learnings (6 patches) | #332 | +202/−11 | 0 | Merged without close-out artifacts |
| #330 | TSC upstream patches (3 patches) | #333 | +10/−5 | 0 | Merged without close-out artifacts |
| #334 | scope-sizing heuristic | #336 | +62 | 0 | Claude Code α, clean |
| #335 | retro close-out for #331+#333 | #337 | +1003/−2 | 2 | Agent timeout → operator override → TSC β audit |

## The recursive loop

1. **#331/#333** — patches landed, protocol skipped
2. **#335** — retro restored missing artifacts, but initially claimed "α-only per §2.5b" (false — §2.5b doesn't grant β-skip)
3. **TSC β audit** — caught 6 honest-claim findings (F1–F6); fix-round resolved all; R2 APPROVED
4. **β-completion bundle** — TSC delivered full review record + close-out; applied to cnos

Each layer remediated the layer above. The pattern that started as "supercycle patches skipped recording their own learnings" is now fully recorded across both repos.

## Dispatch findings

### `--output-format stream-json` requires `--verbose` with `-p`
Both initial agent dispatches (#334 and #335) failed instantly. Claude CLI exits with error when combining `stream-json` with `-p` without `--verbose`. Fixed in operator skill and dispatched again.

### Timeout sizing matters
#335 agent (9 ACs, 22 files) timed out at 600s after writing all files but before committing. #334 agent (5 ACs, 1 file) completed in ~90s. Rule of thumb: ~120s per AC for docs, more for complex cycles. The prompt should say "commit early, commit often."

### Lightweight tasks need lightweight prompts
Same family as §1.6b (TSC finding). The #335 agent spent most of its budget reading skill files and issue body. Could have been slimmer — or split into two prompts ("commit 331 artifacts, then 333").

## Artifacts landed on cnos

- 6 supercycle patches (review/SKILL.md, issue/SKILL.md, release/SKILL.md, post-release/SKILL.md, CDD.md, gamma/SKILL.md)
- 3 upstream patches (alpha/SKILL.md rows 11-13, operator/SKILL.md stream-json, CDD.md §1.6b)
- 1 scope-sizing section in issue/SKILL.md
- 22 close-out files across cycles 331/333/335
- .cdd/iterations/INDEX.md initialized (3 rows)
- Cross-repo LINEAGE.md (bilateral)
- Combined PRA for #331/#333
- CHANGELOG ledger rows
- CI notification improvement (issue URL in Telegram builds)
- `--verbose` fix pushed directly to main

## Open threads

- F7: rubric §3.8 closure-gate-failure handling gap — small follow-on issue needed
- F2 (cdd-iteration): mechanical pre-merge closure-gate enforcement — `next-MCA`, no issue filed yet
- TSC-side cleanup: delete `courier/cnos-cdd-supercycle` branch + cross-repo trace dir (TSC's responsibility per Step 5.6b)
- #334 scope-sizing heuristic quantitative validation — deferred until ≥10 cycles of round-count data accumulate

## What the operator override pattern taught

When agent-α times out and operator finishes the work, the right move is:
1. Declare the override per operator/SKILL.md §4
2. Name which ACs each entity completed
3. Include a friction log (what failed, why, what would prevent it)
4. Don't hide it as protocol compliance — honest declaration is the protocol
