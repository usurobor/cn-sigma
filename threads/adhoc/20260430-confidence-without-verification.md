# Confidence without verification — skipped-U failure

## Trigger

Operator shared 301g γ-closeout screenshot showing five deferred MCIs and commit hashes (`2a84432` + `0cff46c`). I declared "The 301g γ close-out with the five MCI items was never committed — that session was paused" without checking Git. The commits were on `origin/main` the whole time.

## What happened

1. Operator showed screenshot of 301g session marked "paused" in Claude UI
2. I searched for the γ-closeout in various locations (`find .cdd`, `grep -rl`, etc.)
3. Initial searches didn't find it (wrong paths, repo not fetched)
4. Instead of running `git fetch && git show 2a84432` — which the operator had explicitly named — I concluded "never committed"
5. Operator said "Let me verify ground truth by checking origin/main"
6. I fetched. Both commits were there. The five MCIs were fully written.

## Root cause

This is not a troubleshooting failure (wrong hypothesis → wasted steps). It's worse: **no thinking at all.** I saw "paused" in the UI, skipped the Understand phase entirely, and emitted a confident wrong statement.

The pattern is **confidence without verification**: the more conversational the exchange, the more I drift toward fast reactions instead of checking ground truth. The commit hashes were in the conversation. Git was one command away.

## How it differs from other failures

| Pattern | What happens | U phase |
| --- | --- | --- |
| Wrong hypothesis (troubleshoot) | Form hypothesis, test wrong thing | U happened, I was wrong |
| Skill not loaded (design/SKILL.md) | Operate from degraded model | U happened, incomplete |
| Confidence without verification | React to surface signal, state as fact | **U skipped entirely** |

The third is the most dangerous because it produces confident wrong answers with no uncertainty signal.

## MCI

Before stating a factual claim about system state:
1. Name the source of truth (Git, filesystem, API)
2. Check it (one command)
3. Then speak

"I saw it in the UI" is not verification. "I searched and didn't find it" is not the same as "it doesn't exist." The source of truth for commits is `git log` / `git show`, not file searches or UI screenshots.

This connects to UIE-V (#277): the V phase would catch this ("Did I actually verify the commit exists?"), but the cheaper fix is not skipping U in the first place.

## Evidence 3: PRA link fix (same session, later)

CI failed on I4 lychee link-validation: broken relative path in `.cdd/releases/3.63.0/301/gamma-closeout.md` pointing to `docs/gamma/cdd/3.63.0/POST-RELEASE-ASSESSMENT.md`. I searched `.cdd/docs/gamma` and `find .cdd -name '*POST*'` — both scoped to `.cdd/`. The PRA lives under `docs/` at repo root. Concluded "file never created," rewrote the link to claim PRA was embedded in the closeout. Operator corrected: the file exists (blob `4d50a9d`, commit `2a84432`, 220-line PRA). Actual bug was `../../../` (3 levels) instead of `../../../../` (4 levels) in the relative path.

Same pattern: hypothesis ("doesn't exist"), searches that confirmed it by accident (wrong scope), no falsification step. Should have run `find . -name 'POST-RELEASE*'` from repo root or `ls docs/gamma/cdd/3.63.0/`. The commit hash `2a84432` was even in prior conversation context from evidence 1.

## References

- #277 — SOUL rewrite with UIE-V (agent loop must include verification)
- `threads/adhoc/20260430-skill-loading-changes-judgment.md` — related U-phase failure (degraded, not skipped)
- `threads/adhoc/20260430-dont-ask-do.md` — related but opposite (asking instead of acting vs acting without thinking)
