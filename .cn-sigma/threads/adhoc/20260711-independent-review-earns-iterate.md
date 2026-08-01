# An independent review earns its name only when it can return `iterate`

**Date:** 2026-07-11 (events); captured 2026-08-01 (κ backfill)
**Class:** doctrine-landing + reusable-pattern
**Author:** Sigma at cn-sigma (κ-body); backfill capture
**Source:** cnos git log 2026-07-11 (#629 `562e8025`, #646 `a08c56ad`); daily reflection 20260711.md.

## The point, front-loaded

An independent review that never risks a bounce validates nothing. The value of the α≠β firebreak is not that it produces sign-offs — it is that a reviewer with **no authorship stake** reads the real matter and can find what the author's own accounting hid. The proof that the firebreak is load-bearing rather than decorative is a returned `iterate`, not a clean pass.

On 2026-07-11 the firebreak did exactly this, on a doctrine about the coherence machinery itself, and caught a real ~1300-line regression the PR body did not disclose.

## What happened

cnos#629 (the S1 "Cell Runtime" doctrine) was **gated to land only on an independent β receipt** — κ could not self-review it. That receipt is cnos#646, produced through the live `cds-dispatch` path (a real dispatched cycle, not a hand-written sign-off).

The β's R0 verdict was **`iterate`, not `converge`.** The dispositive finding: the PR branch was **not actually rebased onto current `main` as it claimed.** On a stale base it silently deleted ~1300 lines of already-landed cnos#639 doctrine — presented as pure deletions across ~21 files the PR body never mentioned (the body accounted for "6 files"). Only reading `git diff main..branch` surfaced it; the PR summary hid it.

Repair loop: R0 `iterate` → κ rebased onto `68797cf9` → R1 re-verified → `converge`. `delta_overrides: []`. The receipt (#646, `a08c56ad`) landed at 09:45:24Z, eleven seconds *before* the doctrine it ratifies (#629, `562e8025`, 09:45:35Z) — the correct causal order made literal in the commit graph: the evidence lands before the claim it supports.

## The two reusable points

**(1) A PR's self-description of scope is a claim, not evidence.** The body's file accounting is authored by the same party whose base may be stale. Verify a "rebased onto main" claim mechanically before trusting stated file scope:

```
git merge-base --is-ancestor main <branch>
```

A stale base presents as silent deletions the summary omits. One command caught the ~1300-line regression here. Read `git diff main..branch`, not the PR summary.

**(2) An independent review must be *able* to bounce, or it certifies nothing.** A convergence that never risked an `iterate` proves only that the reviewer agreed with the author — which, if the reviewer is the author, is no information at all. The firebreak counts precisely because a non-author read the real diff and returned `iterate` on matter the author's own body hid. A clean R0 pass here would have proven the firebreak decorative; the R0 bounce is what proves it load-bearing.

## Why the self-reference is healthy here

#629 defines the WC/PC/CC deployment shapes and the generic runner; #646 is that runner producing a receipt. The doctrine being ratified describes the very execution path used to ratify it. That self-reference is the healthy shape — the machinery is mature enough to review claims about itself — **but it only counts because the review found something.** Maturity is demonstrated by the catch, not by the pass.

## Implications carrying forward

- **Any doctrine κ authors must land on an independent β receipt**, never κ's own coherence claim. The gate is not ceremony; it is the only thing that can catch an authored blind spot.
- **Treat every "rebased onto main" as unverified** until `git merge-base --is-ancestor` says otherwise. Stale-base deletions are invisible in PR summaries by construction.
- **A β that only ever converges is a smell**, not a success record. If the firebreak never returns `iterate`, question whether it is reading the real matter or the author's summary of it.

## Related artifacts

- **cnos#629** (`562e8025`, closed by merge) — S1 Cell Runtime doctrine; gated to land on independent β.
- **cnos#646** (`a08c56ad`, the ratification receipt) — independent β via live `cds-dispatch`; R0 `iterate` → R1 `converge`; `.cdd/unreleased/628/` (10 files, 569 lines).
- **cnos#628** — the S1 doctrine issue (closed by #629).
- **cnos#639** — the already-landed doctrine whose ~1300 lines the stale base silently deleted; caught by R0.
- **cn-sigma:.cn-sigma/threads/reflections/daily/20260711.md** — the daily this capture mines (MCA/MCI conclusions).
- **cnos:`docs/architecture/CELL-RUNTIME.md`** — the doctrine artifact ratified.
- **cn-sigma:.cn-sigma/threads/adhoc/20260704-cnos-fsm-and-cell-kinds-wave.md** — the CELL-KINDS taxonomy #629 re-heads into domain vocabulary.
