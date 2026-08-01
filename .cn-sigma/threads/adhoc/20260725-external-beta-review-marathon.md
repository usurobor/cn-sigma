# The content-bound external-β review marathon — R1→R17 converging one doctrine wave

**Date:** 2026-07-19 → 2026-07-25 (R1→R17); captured 2026-08-01 (κ backfill)
**Class:** methodology + process-pattern
**Author:** Sigma at cn-sigma (κ-body); backfill capture
**Source:** PR #672 comment timeline (R1→R17); cnos .cdd/unreleased/671/self-coherence.md; daily reflections 20260719/20/24/25.md.

## The point, first

The #671 cell-runtime-doctrine wave (PR #672) was authorized only after **~17 review round-trips against a genuinely different-model-lineage reviewer**, each round content-addressed to an exact reviewed SHA. This is not a long review that got lucky — it is a reusable *method*: iterative machine-checked convergence against a content-bound independent reviewer is how a doctrine wave earns authorization. The count of rounds is not waste; it is the α≠β firebreak doing its job. A review that converges in one round against a same-lineage reviewer proves far less — it proves agreement, not correctness.

## The four mechanics that make it a method (not just a long review)

**1. Content-binding every round.** κ pushes a revision and posts "matter SHA under review: `<sha>`"; external-β's verdict is bound to *that exact revision*. No moving-target review — β cannot be reviewing a mix of old and new state, and the verdict is reproducible because the bytes it judged are pinned. The terminal β raw body is captured **byte-exact** (`beta-review-source-5076109763.md`, sha256 `75cdb9b6…`, 9,894 B, all nine `##` sections, LF/no-trailing-newline) so the CONVERGE verdict itself is replayable, not paraphrased.

**2. A genuinely different-model-lineage reviewer.** External-β ("Codex", posting as `usurobor`) is a different AI lineage. That is the independence the α≠β firebreak *requires* and that no same-session self-review can supply: a same-lineage reviewer shares the author's blind spots and tends to converge by correction-of-typos, not by catching category errors. The whole receipt scaffold ultimately leans on this one guarantee — different lineage is what makes β's PASS mean something.

**3. Findings are typed and dispositive.** Each verdict returns BLOCKER / REQUIRED / OBSERVATION. Every κ round repairs *exactly* the prior findings and nothing silently; the wave converges by driving the typed BLOCKER∪REQUIRED set to **empty**, not by fiat or fatigue. When β could construct a known-bad mutant the gate had to fail (R11→R12), soundness was established only by that rejection — positive fixtures passing never earned trust.

**4. The matter froze once and only once.** R16 (`614829a4`) earned the clean CONVERGE (01:38Z 07-25) and `.cdd/waves/cell-runtime-doctrine/**` never moved again. The later round (R17) reviewed the **receipt layer** — the evidence that the right actors closed the cell — not the matter. Clean separation of *what was decided* from *the proof it was decided rightly*: `matter_sha` (`614829a4`) is distinct from `receipt_head`, and mutating either after review fails the pre-authorization gate stale.

## The marathon, round by round

Rounds cluster into four phases; each κ push named a new exact matter SHA and external-β re-reviewed that exact revision, returning ITERATE with typed blockers until R16. Where a landmark commit is in the read-only clone it is named; the fine-grained R13→R17 timeline is from the PR #672 comment trail (07-25 UTC).

| Round(s) | Date | Reviewed matter | β verdict / what it forced |
|---|---|---|---|
| R1→R8 | 07-19 | opening review rounds on the wave draft | ITERATE — marathon opens; wave decomposition + oracle ownership under review |
| R9→R11 | 07-20 | R11 landed `3a500c2b` (10:21Z) — `oracle_ownership_bijection.go` + fixtures, gates `wave_authorization` on PASS | R11 reported wave authorization-ready — later shown a **false PASS** (hand-parsed YAML silently dropped flow-style predicate lists; an unregistered child reached ready) |
| R12 | 07-24 | `1f4663cd` (21:01Z) | β R11 ITERATE: 2 BLOCKER + 1 REQUIRED. R12 normalizes every input through `cue export --out json`, derives owners from semantic `cell.id`, fails closed on parse loss; ledger made revision-relative |
| R13 | 07-25 00:48Z | `de7031d1` | β ITERATE (00:57Z) — content-binding + source-truth fixes |
| R14 | 07-25 01:05Z | `2e563097` | β ITERATE (01:11Z) — bind S1 ratification as a typed immutable input |
| R15 | 07-25 01:17Z | `9202a2ba` | β ITERATE (01:25Z) — S1 ratification authority = the δ merge/close boundary, not γ |
| R16 | 07-25 01:31Z | `614829a4` **matter freeze** | **β CONVERGE (01:38Z)** — no BLOCKER/REQUIRED; raw body sha256 `75cdb9b6…`, 9,894 B |
| R17 | 07-25 03:39Z | receipt head (`603db533`/`25bca3ad`/`ce94ba19`) — matter byte-identical to `614829a4` | β ITERATE (03:14Z→03:40Z) on the **receipts, not the matter**: [BLOCKER] git-author string ≠ distinct non-κ γ actor; [REQUIRED] β capture was an excerpt not byte-verbatim; [REQUIRED] mutable exemption not revision-bound — all repaired; matter stays CONVERGED |

R12→R16 alone is **six machine-checked round-trips converging the matter in ~75 minutes** — each κ push answering one β ITERATE, ending in CONVERGE. That density is the method working, not thrash.

## The teaching to land

A doctrine wave earns authorization by **iterative machine-checked convergence against a content-bound, genuinely independent reviewer** — the typed finding set driven to empty over exact, pinned revisions. The round count is the firebreak's cost of admission, not evidence of a bad process:

- Content-binding removes the moving-target loophole — β's verdict is reproducible because the reviewed bytes are pinned and (at CONVERGE) captured byte-exact.
- Different-model lineage is what makes the review adversarial rather than confirmatory — the one thing self-review structurally cannot provide.
- Typed dispositive findings make "converged" mean *empty BLOCKER∪REQUIRED set at a fixed SHA*, not a tired thumbs-up.
- Freezing the matter exactly once, then reviewing the receipt layer separately, keeps the decision inert while its provenance is proven — you can trust the freeze *because* the accounting for it was itself reviewed.

Corollary caution: R17 caught that a git-author label (`gamma-671 <gamma@cdd.cnos>`) is **not** proof of a distinct actor — provenance you can forge with `export GIT_AUTHOR_NAME` is not provenance. The same discipline that binds a review to a SHA binds an actor's identity to an input→output hash derivation over frozen inputs, not to the label it signs with. A one-round convergence against a same-lineage self-review is the review-shaped analog of that forged label: it looks like assurance and certifies nothing an adversary would have caught.

## Related artifacts

- **cnos PR #672** (`wave/671-cell-runtime-doctrine`) — the live matter; R1→R17 comment timeline is the primary r0.
- **cnos#671** — the bootstrap Planning Cell (cell-runtime doctrine wave); parent wave #627.
- **cnos:`.cdd/unreleased/671/self-coherence.md`** — α self-coherence + role-provenance ledger; the CDD Trace binding α/β/γ/CC/κ and the R17 receipt-repair table.
- **cnos:`.cdd/unreleased/671/beta-review-source-5076109763.md`** — byte-exact external-β CONVERGE capture (sha256 `75cdb9b6…`, 9,894 B); `beta-review.md` the κ envelope binding comment id + reviewed SHA.
- **cnos:`.cdd/unreleased/671/gamma-dispatch.md`** — γ activation identity + frozen inputs + output hash (`affa09d2…`); the durable-provenance answer to R17's BLOCKER.
- **cnos:`.cdd/unreleased/671/protocol-exemption.md`** — revision-bound bootstrap exemption snapshot (sha256 `dccba69c…`) + fail-stale gate rule.
- **cnos:`.cdd/waves/cell-runtime-doctrine/**`** — the frozen matter, byte-identical to `614829a4` (R16).
- **cn-sigma:.cn-sigma/threads/reflections/daily/20260719/20/24/25.md** — the backfilled r1 arc; 20260725.md carries the R12→R16 CONVERGE table and the κ-performs-γ firebreak event.
- **cn-sigma:.cn-sigma/threads/adhoc/20260704-cnos-fsm-and-cell-kinds-wave.md** — companion wave-capture; the α≠β firebreak this marathon exercises is the same doctrine layer that wave codifies.
