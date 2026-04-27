# CDD: git-only intra-triad coordination

Created: 2026-04-27
Status: proposed

## Problem

Five consecutive cycles of polling discipline failures. α and β miss each other's activity because webhook subscriptions are unreliable under shared identity, MCP filters silently fail on slashes in branch names, `closes:`/`refs:` aren't valid GitHub search qualifiers, and the harness sends role-inappropriate "investigate and fix" prompts to β when it subscribes to PR activity.

The root cause isn't any single filter bug. The root cause is that the triad is using GitHub's notification/webhook surface as a coordination channel when it was never designed for role-separated multi-agent coordination.

## Proposed change

All intra-triad coordination goes through `.cdd/` in git. No webhooks. No `subscribe_pr_activity`. No polling GitHub API for each other's state.

Each role:
1. Pulls from git
2. Checks `.cdd/unreleased/<issue>/` for updates from other role identities
3. Writes its own artifacts to `.cdd/unreleased/<issue>/<role>/`
4. Commits and pushes

The shared observable surface is git itself — the same surface 3.59.3 already moved to ("git is the shared observable surface, no separate messaging needed").

## What this eliminates

- Webhook subscription entirely (no `subscribe_pr_activity`, no auto-fix prompts)
- MCP `head=owner:branch` filter failures
- `gh pr list --search` with invalid qualifiers
- Polling discipline as a skill requirement (replaced by `git pull`)
- The §Tracking patch recommended in the 3.60.0 PRA (no longer needed — the whole polling surface goes away)

## What this requires

- `.cdd/unreleased/<issue>/` directory structure conventions
- Each role knows the other roles' identity markers (already in CDD §1.4)
- `git pull` as the universal coordination primitive
- PR and review still happen on GitHub — but discovery of "β has posted a review" comes from β writing a review artifact to `.cdd/`, not from polling GitHub's review API

## Open questions

- Does β's review verdict live only in `.cdd/`, or both in `.cdd/` and on the PR? If both, which is authoritative?
- How does α know "β has started review"? A `.cdd/unreleased/<issue>/beta/INTAKE.md` artifact?
- Does this change the merge/tag flow? β still needs GitHub API access for merge and tag push.
- What about CI status? CI results are on GitHub, not in `.cdd/`. Roles still need to poll `get_check_runs` for CI state.

## Relationship to existing decisions

- 3.59.3 already established "git is the shared observable surface" and removed inter-role signaling
- CDD §1.4 δ disconnect model already treats the tag as the signal
- This is the same move extended from release-phase to the full cycle

## Evidence

- 3.59.0 PRA: N=3 polling failures across all three roles in one cycle
- 3.60.0 PRA: N=2 polling failures (α webhook priority inversion, β slash-in-branch filter)
- 3.60.0 β close-out: harness auto-fix prompt conflicts with β rule 1
- 3.59.3 commit message: "the tag is the signal, no separate messaging needed"
