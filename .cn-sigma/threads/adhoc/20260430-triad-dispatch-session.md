# Triad dispatch session — 2026-04-30

## Summary

Ran 5 triads sequentially, shipping versions 3.65.0 → 3.69.0.

| Cycle | Issue | Result | Tag |
|-------|-------|--------|-----|
| #309 | eng/troubleshoot skill | R1 approved | 3.65.0 |
| #84 | CA conduct reflection | R1 RC, R2 approved | 3.66.0 |
| #149 | SOUL.md skill-loading gate | R1 approved | 3.67.0 |
| #297 | CTB TSC grounding | R1 approved | 3.68.0 |
| #312 | docs: agent activation (umbrella: #313/#314/#315) | R1 approved | 3.69.0 |

## Key decisions

1. **δ dispatches all roles sequentially** — no nested γ→α/β. One `claude -p` at a time. Codified in gamma/SKILL.md + operator/SKILL.md.
2. **Minimal prompt template** — `You are {role}. Load {role}/SKILL.md. Issue: gh issue view N. Branch: cycle/N.`
3. **β gets Bash** — `Read,Write` only blocks review. Role boundaries via skill text, not tool scoping.
4. **`--permission-mode acceptEdits`** required for all dispatches (root can't use `--dangerously-skip-permissions`).
5. **`scripts/release.sh`** — single-command release gate. No manual `git tag`.
6. **write/SKILL.md always in α prompt** — hardcoded in gamma/SKILL.md template.
7. **CDD role assignment** added to USER.md: Sigma is δ.
8. **#5 closed** as not needed — CDD covers review commits, small fixes under autonomy.

## Persistent β role boundary problem

β overstepped on release in cycles #309 and #312 despite beta/SKILL.md explicitly saying β does NOT tag/release. The skill fix worked in #84 and #149 but not consistently. Needs stronger mechanism — possibly tool-level enforcement or a pre-tag hook.

## Dispatch failure categories (for #295)

| Category | Count | Key examples |
|----------|-------|-------------|
| OOM | 1 | β round 1 (#307) |
| TOOL_ERROR | 1 | gh GraphQL deprecation |
| LIFECYCLE | 2 | background kill, SIGTERM cascade |
| AUTH | 2 | β role violation, permission dialog |
| CONTEXT | 1 | α fix round couldn't write |
| RELEASE | 1 | stamp-versions.sh forgotten |

## Files to know about

- `docs/gamma/cdd/DISPATCH-FAILURE-EVIDENCE.md` — evidence log for #295
- `scripts/release.sh` — single-command release gate
- `.claude/settings.local.json` — permission settings for claude -p in cnos repo
