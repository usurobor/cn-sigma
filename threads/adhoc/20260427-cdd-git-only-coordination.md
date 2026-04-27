# CDD: git-only intra-triad coordination

Created: 2026-04-27
Status: resolved — design direction locked

## Problem

Five consecutive cycles of polling discipline failures. The root cause is that the triad is using GitHub's notification/webhook/PR surface as a coordination channel when git itself is sufficient.

## Resolved design

No PRs. No webhooks. No GitHub review API. No `subscribe_pr_activity`. All roles run on the same loop: `git pull` → check `.cdd/` → act → commit → push.

### The cycle

1. **γ** selects gap, creates issue, dispatches α
2. **α** implements (branch or main), commits, pushes
3. **β** pulls, reviews via `git diff main..branch`, writes verdict to `.cdd/unreleased/<issue>/beta/`
4. **α** addresses RC if needed (commit + push), β re-reviews via git
5. **β** approves (verdict artifact in `.cdd/`)
6. **δ** tags + pushes tag → release pipeline fires
7. **γ** pulls, sees tag, writes PRA, closes issue

### The gate chain

β verdict in `.cdd/` → δ tag → γ PRA + close

No verdict artifact, no tag. No tag, no PRA. No PRA, no issue close.

### Loop termination

Each role exits its loop naturally when its gate fires:
- α exits after β's approval verdict appears in `.cdd/`
- β exits after δ's tag is pushed
- γ exits after writing PRA + closing the issue

The issue close is the universal termination signal. Any role still polling sees the closed issue on next `git pull` and exits. γ closing the issue is the last act of the cycle.

### Every role runs the same continuous loop

```
while cycle_open:
    git pull
    check .cdd/unreleased/<issue>/ for new artifacts from other roles
    if new artifact from another role → act (implement / review / assess)
    if acted → commit to .cdd/unreleased/<issue>/<role>/ → push
    sleep N
```

The loop is continuous, not one-shot. α polls for β's verdict. β polls for α's commits and CI green. γ polls for δ's tag. All roles on the same primitive, running until their gate fires. No external wake needed — the loop is the wake.

### What remains on GitHub

- Issue create/close (γ)
- CI status — `get_check_runs` (β needs CI green before verdict)
- Tag push (δ)
- Release pipeline (triggered by tag)

Everything else is git.

## What this eliminates

- PRs entirely
- Webhook subscriptions (no `subscribe_pr_activity`, no auto-fix prompts)
- MCP `head=owner:branch` filter failures
- `gh pr list --search` with invalid qualifiers
- Polling discipline as a skill requirement (replaced by `git pull`)
- The §Tracking patch from 3.60.0 PRA (the whole polling surface goes away)
- Harness auto-fix prompts conflicting with β rule 1

## What this requires

- `.cdd/unreleased/<issue>/<role>/` directory conventions
- CI triggers on branch push, not PR events
- β reviews via `git diff`, not GitHub review UI
- Each role's loop is the same primitive: pull, check, act, commit, push

## Evidence

- 3.59.0 PRA: N=3 polling failures across all three roles
- 3.60.0 PRA: N=2 polling failures (α webhook, β filter)
- 3.60.0 β close-out: harness auto-fix prompt conflicts with β rule 1
- 3.59.3: "git is the shared observable surface, no separate messaging needed"
- 3.59.3: "the tag is the signal"

## Relationship to existing decisions

This is 3.59.3's "git is the shared observable surface" extended from release-phase to the full cycle. The tag-as-gate was already δ's model. Now every role's coordination runs on the same primitive.
