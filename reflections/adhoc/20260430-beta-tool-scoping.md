# β tool scoping — Bash required, role constraints via skill text

## Trigger

Cycle #84 β dispatched with `--allowedTools "Read,Write"` (no Bash). β sat idle — couldn't run `git diff`, `gh issue view`, or any review commands.

## What happened

1. β dispatched with Read,Write only to prevent tag/release/push (cycle #309 β had overstepped)
2. β couldn't perform review — no shell access for git/gh commands
3. Killed and re-dispatched with Read,Write,Bash
4. After re-dispatch, β completed review AND respected role boundaries (no tag/release)
5. The difference: beta/SKILL.md had been updated (commit `0e94fe3d`) to explicitly say β does NOT own tag/deploy/release

## Root cause

`claude -p --allowedTools` is binary: Bash or no Bash. There's no "read-only bash" or per-command allowlist. β needs shell for:
- `git diff`, `git log`, `git fetch` (review)
- `gh issue view` (issue context)
- `git merge`, `git push` (merge authority)

β does NOT need:
- `git tag`, `git push --tags` (release)
- `gh issue close` (closure)
- version bumps, CHANGELOG edits for release

## MCA

Role boundary enforcement via skill text, not tool scoping:
- beta/SKILL.md now explicitly says: "β does NOT tag, push tags, bump versions, update CHANGELOG for release, delete cycle branches, or move .cdd/ artifacts to release directories"
- This worked in cycle #84: β merged and wrote close-out but stopped there

## Implication for #295

- β gets Bash (no way around it with current `claude -p`)
- Role boundaries enforced by skill text (already done)
- Future: `cn dispatch` could wrap bash in a role-specific command allowlist
- Evidence: skill-text enforcement works when the skill is clear and loaded
