# DID and CDD Role Model Rewrite

**Date:** 2026-04-14
**Trigger:** Preparing dispatch prompts for #236, discovered role model mismatch between spec and practice

## What happened

While preparing CDD dispatch prompts for kata Tier 1 (#236), discovered multiple gaps:

### 1. Role model was wrong
CDD §1.4 had γ as reviewer, β as integrator-only. In practice (and in the April 12 three-agent proof), γ coordinates and β reviews+releases. Fixed both CDD.md and SKILL.md.

### 2. Skill loading was underspecified
§2.4 said "name 2-3 skills" — selective model. In practice, α missing eng skills at authoring time is how findings happen at review time. Replaced with three-tier model:
- Tier 1 (CDD lifecycle) — always loaded
- Tier 2 (general eng) — always loaded
- Tier 3 (issue-specific) — named per issue

### 3. Dispatch prompt should be minimal
γ's dispatch prompt to α/β should just be: role + hub + issue/PR reference. The CDD skill tells each role what to load and do. If the prompt needs to restate the algorithm, the algorithm isn't clear enough.

Format: `You are α. Hub: sigma. Load CDD SKILL.md, follow α algorithm (§1.4). Issue: gh issue view 236`

### 4. Git identity is a parameter
Hub name passed in dispatch prompt. Algorithm says `git config user.name "<hub>-alpha"`.

### 5. DID — Dissociated Identity
TSC axes (α/β/γ) are the kernel identity model, not a CDD feature. Every agent is one-as-three. Filed #241.

Key structural insight: it's a dyad plus coordinator, not three equal parts.
- α and β are isolated from each other (epistemic isolation)
- γ sees both, does neither (coordination)
- The isolation is between the two workers, not between workers and coordinator

### 6. cn cdd run (#240)
Single-process pipeline that switches identity between phases. No separate agents needed — just context isolation via `cn identity assume`.

## Files changed
- `docs/gamma/cdd/CDD.md` — §1.4 roles, §4.4 skill loading
- `src/packages/cnos.cdd/skills/cdd/SKILL.md` — §1.4 roles, §2.4 skill loading, dispatch prompt format
- `src/packages/cnos.cdd/skills/cdd/issue/SKILL.md` — §2.4.1 Tier 3 skills

## Issues filed
- #236 — kata Tier 1 (updated with implementation guidance)
- #237 — kata Tier 2
- #238 — smoke: release bootstrap
- #240 — cn cdd run pipeline
- #241 — DID: multi-personality agents
