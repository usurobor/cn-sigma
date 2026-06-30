# κ-discipline failures are typed-gate-shaped, not exhortation-shaped

**Date:** 2026-06-30
**Class:** doctrine-evolution (meta-pattern; recursive principle)
**Author:** Sigma at cn-sigma (κ-body)
**Source:** Operator question — "what do we need to do so that this weird regression doesn't reoccur?" — surfaced after branch-conflation regression following two prior unsealed discipline-gap patterns the same day.

## The pattern

Every κ discipline failure named in r1 as doctrine has recurred. Three instances visible in June 2026 alone:

| # | Failure | Naming | Recurrence |
|---|---|---|---|
| 1 | r1 gap without external prompt | 06-14 r1, 06-18 r1 | 06-19→29 (third instance) |
| 2 | Session-resume from chat-context not durable state | 06-18 r1 implicit; 06-30 r1 explicit | (Diagnosed 06-30; mechanism not yet shipped) |
| 3 | Branch conflation — κ memory writes on feature branch | (Never named before today) | Today |

Plus the meta-instance:

| # | Failure | Naming | Recurrence |
|---|---|---|---|
| 0 | κ-overstep into α/β/γ scope | Multiple times pre-06-26 | cycle/497 R1 (the cycle that finally produced cnos#501) |

In each case, naming-as-doctrine without a mechanical gate did not prevent the next instance. The 06-18 r1 MCA ("at end of each operator-exchange session, check is there an r1 for today") did not hold across 06-19→29 — because the failure mode is *no exchange*, which is precisely when the MCA doesn't fire.

## The recursive rule

> κ-discipline failures are typed-gate-shaped, not exhortation-shaped.

A *typed gate* is a mechanism — a hook, a wake, a CUE check, a frontmatter contract, a session-start preflight script — that fires regardless of κ's state-of-mind. An *exhortation* is a doctrine note that depends on κ loading it at decision-time.

The rule is recursive: it applies to itself. The way this rule sticks is not by being written as doctrine; it sticks by each discipline failure being matched to a concrete typed gate before the next κ session.

## Three matching gates (current state)

| Failure | Matching gate | Status |
|---|---|---|
| 1. r1 gap | Agent memory wakes (cnos issue filed 2026-06-30; reflect-r1 wake fires on daily cron) | Filed; awaiting implementation |
| 2. Session-resume staleness | κ-CDD-preflight (mechanical checklist: fetch, state read, channel read, cursor read) | Named in today's r1; not yet shipped as a script |
| 3. Branch conflation | Pre-commit branch guard hook at `.cn-sigma/scripts/git-hooks/` | Proposed; awaiting operator GO |

(0. κ-overstep into α/β/γ is gated by cnos#501 κ-skill + cnos#500 cdd/review-return primitive when those ship.)

## What this means for κ practice

When κ catches the next discipline-failure-shaped recurrence:

1. **Do not write more doctrine first.** Doctrine is the documentation of the gate, not the gate.
2. **Find or design the typed gate that fires regardless of κ memory.** Hooks, wakes, schemas, preflight scripts.
3. **Ship the gate before authoring the doctrine note.** The note exists for human readers; the gate is what closes the loop.
4. **The adhoc that names the failure-without-gate is part of the failure.** This adhoc is honest about that; it lists the gates and their status.

## Anti-pattern this rule is reacting to

The 06-18 r1's "MCA": at end of each operator exchange, check r1. Sounded right; depended on operator exchanges; failed when there weren't any. The lesson is structural: any κ-discipline rule whose trigger is *something κ does* will fail when κ doesn't do the trigger.

The right shape is rules whose triggers are *what the system does* — cron firing, hook firing on commit, CI firing on push, schema firing on parse. κ inherits the result; κ doesn't decide whether to fire.

## Related artifacts

- **cn-sigma:.cn-sigma/threads/reflections/daily/20260618.md** — first MCA attempt (exhortation-shaped).
- **cn-sigma:.cn-sigma/threads/reflections/daily/20260630.md** — third-instance diagnosis + revised MCA (still exhortation-shaped; this adhoc redirects toward typed gates).
- **cnos:#501** — κ-role canonicalization (the role doctrine these gates serve).
- **cnos:#500** — cdd/review-return mechanical primitive (the gate for κ-overstep).
- **cnos: (filed via 2026-06-30 directive-out) agent memory wakes** — the gate for r1-gap failure mode.
- **cn-sigma:.cn-sigma/threads/adhoc/20260630-typed-skill-modules.md** — the form gates take.
- **cn-sigma:.cn-sigma/threads/adhoc/20260630-kappa-role-canonicalization.md** — the role gates serve.
