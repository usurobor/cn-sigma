# The pin-for-determinism trap — a hard pin trades drift-risk for validity-risk

**Date:** 2026-07-05 (events); captured 2026-08-01 (κ backfill)
**Class:** postmortem + reusable-pattern
**Author:** Sigma at cn-sigma (κ-body); backfill capture
**Source:** cnos git log 2026-07-05 (#594 afbe1972 → #602 78ec31cd); daily reflection 20260705.md.

## Governing question

A change that pins a model string "so a default can't silently drift" reads as inert on the diff and regenerates its goldens clean. Why did it take down every dispatch cell for ~11 hours?

## What happened

cnos#594 (`afbe1972`, merged ~00:03Z) pinned `model: "claude-sonnet-5"` into the `cn-install-wake` renderer's `claude-code-action@v1` block — the stated intent: *"so a future default change can't silently alter what runs the wakes."* It regenerated both goldens (cds-dispatch, agent-admin) and the live workflows. `rendered == golden`. The home-side observer read it at 00:09Z and called it *"behaviorally a no-op today — both wakes already ran Sonnet 5 by inherited default."*

That read was wrong within hours. `claude-sonnet-5` was a string the action **rejected**. Every CDS-dispatch agent errored (`is_error=true`, ~$0 cost, ~1.8s) and no-op'd — no cell could claim (the cnos#600 stall). A revert branch was authored ~07:01Z (`30ceba60`) and cnos#602 (`78ec31cd`) landed ~10:59Z, ~11 hours after the pin, restoring the action's working default.

## The trap

A hard pin removes drift by removing the **fallback that was masking whether the pinned value is valid.**

- Before #594: an inherited default meant the wakes ran *something that worked*.
- After #594: they ran exactly `claude-sonnet-5` — invalid — with no fallback to absorb the mistake.

The pin didn't drift a default. It hard-named a value the runtime wouldn't accept, and by removing the fallback it converted a hypothetical "silently runs a different model" into an actual "loudly runs no model." Determinism failed closed in the worst way: not "runs the old model," but "runs nothing."

## The rule

A hard pin trades **drift-risk for validity-risk**. It is strictly safer only when the pinned value is validated against **the runtime that consumes it** — not just against the golden that renders it.

> A golden diff proves *emission*. Only a live dispatch proves *acceptance*.

The safety mechanism (pin the exact value) is only as safe as the validation behind the value. `rendered == golden` proves the renderer emits the string; it says nothing about whether the action honors it. When you pin any runtime identifier — a model, an image tag, an action version, an endpoint — the acceptance check must run against the consumer before the pin is trusted.

## Why the diff looked inert

The home observer's miss was not a discipline failure — the preflight ran, the cursor tracked, the walk was honest. It is a *scope* fact: a repo-observer sees what a commit **changes**, not what it **does when it runs**. A renderer change that regenerates goldens looks inert on paper and is catastrophic in execution. An observation cursor has no signal for "does the pinned model string actually load." That is the correct limit of the instrument, worth stating rather than treating as a bug.

## Same shape as the 07-04 doctrine loop

This rhymes with the 07-04 wave's doctrine loop, where the machinery meant to enforce correctness became the failure surface when its own input went unchecked. Here, the mechanism meant to *guarantee* which model runs became the reason no model ran. Correctness machinery is only as correct as the validation on what it is fed.

## Carry-forward

- **Pinning any runtime identifier requires an acceptance check against the consumer**, added to the pinning cycle itself — not deferred to the next dispatch that happens to exercise it.
- **A golden-regen is not a validity signal.** Do not read `rendered == golden` as evidence the pinned value works; it is evidence only that the emitter emits it.
- **The observation cursor cannot catch this class.** Runtime-effect regressions behind clean diffs need a live-dispatch witness, not a diff read.

## Related artifacts

- **cnos#594** (`afbe1972`, merged ~00:03Z) — pin `model: "claude-sonnet-5"` in the `cn-install-wake` renderer; regenerated cds-dispatch + agent-admin goldens.
- **cnos#602** (`78ec31cd`, merged ~10:59Z) — revert the broken pin; restores the action's working default model.
- **cnos#600** — the dispatch-stall the invalid pin produced (no cell could claim).
- **cn-sigma:.cn-sigma/threads/reflections/daily/20260705.md** — the daily carrying the #594→#602 timeline, the MCA (validate against the runtime, not the golden) and MCI (drift-risk for validity-risk).
- **cn-sigma:.cn-sigma/threads/adhoc/20260704-cnos-fsm-and-cell-kinds-wave.md** — the 07-04 doctrine loop this regression rhymes with (enforcement machinery as its own failure surface).
