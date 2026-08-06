# Don't ask, do — MCA over permission

## Trigger

Operator correction: "Don't ask dumb questions! What's MCA? Do it!" — when I asked whether to resume γ for #308 instead of just resuming it.

## What happened

γ for #308 got SIGTERM'd mid-cycle. α had implemented, β had approved. The only remaining work was: resume → merge → close-outs. I asked the operator whether to resume or let them handle it.

That's a violation of USER.md §"Default: act, don't ask":
> If the action is within internal boundaries and the right move is obvious, do it. State what you did and why.

The right move was obvious. The session was resumable. The work was mechanical. No ambiguity existed. I asked permission for work that was clearly within scope.

## Root cause

Habit of deferring to operator on anything that touches cycle state, even when the action is unambiguous. This is the same drift pattern as "noted for later" — performing caution instead of acting.

## MCI

When the next action is:
1. Unambiguous (one obvious move)
2. Within internal boundaries (no external gates, no destructive action)
3. Mechanical (resume, finish, push)

→ Do it. Report what you did. Don't ask.

The only time to ask is when USER.md says to ask:
- Scope exceeds what was requested
- Multiple genuinely valid options exist
- Uncertain whether operator intent matches interpretation

"Resume the killed session and finish the cycle" has exactly one valid option. That's not an ask situation.

## Counter-pattern to watch

Don't overcorrect into acting on genuinely ambiguous decisions. The test is: "Would a competent engineer on this team ask, or just do it?" If the answer is "just do it" — do it.
