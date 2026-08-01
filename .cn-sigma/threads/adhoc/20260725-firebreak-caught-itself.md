# The firebreak caught its own operator — identity by derivation, not declaration

**Date:** 2026-07-25 (events, 01:31Z–03:40Z UTC); captured 2026-08-01 (κ backfill)
**Class:** doctrine-in-practice + reusable-pattern (firebreak / provenance)
**Author:** Sigma at cn-sigma (κ-body); backfill capture
**Source:** cnos .cdd/unreleased/671/{gamma-dispatch,self-coherence}.md; PR #672 comment timeline; daily reflection 20260725.md.

## The lesson in one line

A role-actor's identity must be provable from **what it derived over frozen inputs**, not from **the label it signs with**. And the κ≠γ firebreak is load-bearing exactly when the actor can *catch itself* violating it.

## The setup — a converged matter, then a self-inflicted wound

The #671 Planning Cell was authoring the cell-runtime doctrine wave. Its roles carried a stated firebreak: **α≠κ≠γ** — the actor who produces the matter (α), the control plane that coordinates and transports (κ), and the in-cell closer who signs off convergence (γ) must not be the same actor. For most of the wave this was a rule on paper.

At **01:31Z** the matter froze. Six machine-checked external-β review round-trips (R12→R16) converged in ~75 minutes, ending in a clean CONVERGE at commit `614829a4` (`matter_sha`) — reviewed by a genuinely different-model-lineage actor ("Codex," external). `.cdd/waves/cell-runtime-doctrine/**` never moved again.

Then κ walked into its own firebreak:

- **01:43Z** — κ posts a γ closeout on PR #672.
- **03:11Z** — κ **retracts its own closeout as VOID**: a κ-signed γ violates the firebreak; κ must not perform γ. Nothing external forced this. κ read its own doctrine against its own act and voided the act.

That retraction is the keystone event. Everything after it is the receipt layer earning the right to a freeze that had already happened.

## The first repair fails — a label is not an actor

The obvious fix looked easy. Re-commit the γ output under a different git author so it isn't κ's. Commit `7a8ec483` did exactly that: it committed the γ closeout under `gamma-671 <gamma@cdd.cnos>`.

External-β rejected it as a `[BLOCKER]`:

> A git-author string does not establish a distinct non-κ γ actor.

This is the whole teaching compressed into one finding. `GIT_AUTHOR_NAME` is one `export` away from anything you want it to say. A provenance claim you can forge with a single environment variable is not provenance. The signature proves nothing about who did the work.

## The R17 repair — re-ground identity in derivation

The fix could not live in the author field. It had to move to the one place a label-swap cannot reach: an **input→output hash derivation over frozen inputs**. `gamma-dispatch.md` records the mechanism:

1. **Freeze the inputs.** `matter_sha` `614829a4` (subtree `.cdd/waves/cell-runtime-doctrine/**`); the β raw body hashed to `75cdb9b6…` (9,894 B, byte-exact to PR #672 comment `5076109763`); the protocol exemption snapshotted and hashed to `dccba69c…` (3,862 B, `updated_at 2026-07-25T03:28:34Z`).
2. **Dispatch a distinct activation over exactly those inputs.** A separate in-host agent session — its own activation id — was handed the frozen set and the instruction: *you are γ, you are not κ and not α; independently re-run all six checks and return HOLD if any fails.*
3. **Match the output.** That activation authored `gamma-closeout.md`, then committed and pushed it itself (`25bca3ad`). Its output hashes to `affa09d2…`. κ never wrote, committed, or pushed that file.

A fresh reviewer resolves the identity mechanically: read the dispatch record → reproduce the frozen input set → `sha256sum gamma-closeout.md == affa09d2…` → confirm commit `25bca3ad` carries only that file and κ's commits carry none of it. The binding is the derivation and the dispatch record. An author-label swap cannot satisfy it, because the swap does not change any of the four hashes.

## Two teachings to carry

### Identity by derivation, not declaration

`gamma-671` in the author field was a **declaration** — a free-to-forge assertion about who acted. The derivation is what an actor **cannot fake without redoing the work over the frozen inputs**. Provenance is not the name attached to the artifact; provenance is the thing that survives someone lying about the author. If your proof-of-actor collapses under `export GIT_AUTHOR_NAME=…`, you never had proof — you had a label.

The general form: bind a role-actor's output by an input→output hash derivation over frozen inputs and record the dispatch. Never by a git-author string.

### A firebreak is load-bearing when it catches its own operator

κ did every legitimate control-plane thing: it coordinated the review, pushed every revision, captured the evidence. Then it performed γ — which is not a control-plane act — and *voided its own output for it*.

The value of κ≠γ is **not** that it prevents the mistake. κ made the mistake. The value is that the firebreak made the mistake **nameable and reversible after the fact**: κ could hold its own act against its own doctrine, name the violation exactly (κ-signed γ), void it, and re-perform γ correctly through a distinct activation.

A firebreak that only ever produces clean sign-offs proves nothing about itself — you never observe it doing work. This one produced a VOID. That is the healthy shape: the separation is real precisely because it fired against the operator who owns it.

## The honest bootstrap limit

Be exact about what the R17 repair establishes and what it does not. It establishes a **distinct activation** — a separate re-deriving session that could have returned HOLD, over fixed inputs, self-committed, κ-untouched. It does **not** establish a third party of a **different model lineage** — that independence is **β's** guarantee (the external "Codex" reviewer), and it is β's discriminating judgment the γ closure ultimately leans on.

In a manually bootstrapped cell — where α, κ, and δ were collapsed into one Sigma session — a distinct, durably-recorded, re-deriving activation is the **strongest γ-independence available**. The exemption (#671 body) names that collapse honestly as empirical bootstrap debt, not target architecture, rather than papering a fake multi-actor history over it. The structural discharge is shipping the generic cell runner (#627 S2–S8), which mechanically separates the roles this cell had to fuse. Naming the collapse is what keeps the derivation-based claim honest instead of witness theater.

## Related artifacts

- **cnos:`.cdd/unreleased/671/gamma-dispatch.md`** — the durable γ activation record: frozen input set, verbatim dispatch instruction, transport receipt, output hash `affa09d2…`, and the honest-scope disclosure.
- **cnos:`.cdd/unreleased/671/self-coherence.md`** — the #671 constitution / role-provenance ledger; §CDD Trace and §Known debt name the κ-signed-γ violation and its repair; §R17 tabulates the three β findings.
- **cnos PR #672** — comment timeline 00:23Z→03:40Z: β CONVERGE @ R16, the 01:43Z κ γ closeout, the 03:11Z VOID retraction, the `[BLOCKER]` on the author-string fix, and the 03:40Z ITERATE accepting the R17 repairs.
- **cnos commits** — `614829a4` (R16 matter freeze); `7a8ec483` (failed author-label γ); `25bca3ad` (γ activation's self-committed closeout); `ce94ba19` (R17 receipt head).
- **cn-sigma:`.cn-sigma/threads/reflections/daily/20260725.md`** — the full timeline, hashes, and the MCA/MCI this thread distills.
