# PRA Ownership: β → γ

**Created:** 2026-04-25
**Status:** Landed (cafb3999)

## What changed

Post-release assessment ownership moved from β to γ across 5 CDD files:
- CDD.md (role table, β algorithm, γ algorithm, artifact table, role key)
- beta/SKILL.md (description, ownership list, load order, phase map, rules 2/5, kata)
- gamma/SKILL.md (load order, close-out collection, closure gate)
- post-release/SKILL.md (Who section, scoring sequence)
- release/SKILL.md (ownership statement, CDD trace, kata)

## Why

β assessing its own review quality is a self-grading problem. The PRA measures α's implementation, β's review quality, and cycle economics — all three axes require independent observational authority. γ already held cycle-level context; the PRA was the missing piece.

## Broader realization: γ owns more than coordination

The original CDD design treated γ as lightweight orchestration: select, dispatch, unblock, close. In practice γ has accumulated:

1. **Selection + issue creation** (original)
2. **Dispatch** (original)
3. **Unblocking** (original)
4. **PRA** (moved from β, 2026-04-25) — the cycle's independent assessment
5. **Cycle iteration / skill patching** (step 12a, already γ)
6. **Close-out triage** (already γ)
7. **Hub memory** (already γ)

γ is not a coordinator in the "traffic cop" sense. γ is the cycle's observer-assessor — the role that holds enough context to judge whether the cycle was coherent. The PRA move makes this explicit rather than leaving it split across β (who writes the assessment) and γ (who triages its findings).

## Impact on #268

AC8 in issue #268 says "β owns skill/spec patches identified during assessment." This is now wrong — γ owns the PRA and the patches that flow from it. AC4 Tier 1c says "β always loads post-release for closure" — also wrong, β no longer loads post-release. α should reconcile against main, not the issue text.

## Watch for

- Dispatch prompts that tell β to write the PRA (old pattern)
- β sessions that try to produce POST-RELEASE-ASSESSMENT.md
- #268 ACs that contradict the new ownership (AC4, AC8)
