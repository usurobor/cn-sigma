# Cross-Repo Lineage: cn-sigma → cnos (human-touchpoint-protocol-wave, Sub 3 of foundation-completion-wave)

## Source

- **Repo:** `usurobor/cn-sigma`
- **Branch:** `main`
- **Path:** `.cdd/iterations/cross-repo/cnos/human-touchpoint-protocol-wave/`
- **Filing kind:** nested wave master (sub of foundation-completion-wave master; itself decomposes into sequential sub-subs).
- **Sub position:** Sub 3 of foundation-completion-wave.

## Upstream — what drives this proposal

Multiple design iterations at cn-sigma culminated in operator's 2026-06-25 ruling. Key formative moments:

1. Initial framing (session, 2026-06-25): "humans are not interested in activity, they're interested in highlights."
2. Operator ruling (2026-06-25) — split into cnos.core (generic) + cnos.cds (mapping); three action classes are `dispatch/approve/intervene` (not `ready/landed/stuck`); `approve` fires *before* the production boundary, not after; `state_ref`-based dedupe.
3. κ-sharpening (2026-06-25): "the GH repo is the agent; the agent K articulation of it must be prohibited from doing anything but creating issues for worker articulation." Confirms κ writes issues; workers do everything else.
4. Prior filing attempt (2026-06-30): directive-out at `cn-sigma:.cn-sigma/threads/activations/cnos/20260630.md` 19:00Z carried the earlier iteration inline. Superseded by this bundle per `cn-sigma:.cn-sigma/threads/adhoc/20260703-cross-repo-bundle-pattern.md` (substantive proposals belong in bundles, not directive-out channel entries).
5. Coherent LLMs essay v5 (2026-07-03): §5 "the whole is the hard part" applies directly — a repository CM must state authority, invariants, known tensions. This protocol is the human-touchpoint CM extension of that general shape.

## Target

- **Repo:** `usurobor/cnos`
- **Filing kind:** wave master. Its own decomposition:
  - **Sub 3.1:** cnos.core/agent/human-touchpoint (generic protocol).
  - **Sub 3.2:** cnos.cds/cds/human-gates (software overlay).
- **Suggested labels (this master):** `P1`, `area/agent`, `area/cds`, `kind/process`, `protocol:cds`.

## Bilateral trace

When cnos accepts:
- cnos-side mirror expected at `cnos:.cdd/iterations/cross-repo/cn-sigma/human-touchpoint-protocol-wave/`.
- STATUS advances via ledger events.
- Sub 3.1 and Sub 3.2 file as their own bundles when their turn comes.

## Sub relationship to parent master

Parent master: `foundation-completion-wave`.
Sub position: 3 of 3.
Filed in parallel with parent master + Sub 1 + Sub 2 per operator directive.

Dependence rationale:
- **Design surfaces** are ready to file now (operator ruling settled 06-25).
- **Full implementation** of Sub 3.2 depends on cnos#569 FSM Phase 2 shipping (state-observation surface with mutation authority is required to reliably detect the state transitions that map to `dispatch`/`approve`/`intervene`).
- **Authorship enforcement** (WAC5) depends on cnos#501 κ role dispatched.

Therefore Sub 3 (this master) can file now. Sub 3.1 dispatches when cnos#501 dispatches. Sub 3.2 dispatches when both Sub 3.1 closes AND cnos#569 lands.

## Sub 3 does NOT depend on

- Sub 1 (kappa-session-preflight) — different κ surface (preflight vs. authorship rule).
- Sub 2 (reflect-rN-wake-family) — different memory surface (compaction vs. touchpoint emission).
- cnos#444 cohere landing — cohere is r-ladder mechanization; touchpoint is human-surface routing. Orthogonal.

## Sub 3 DOES depend on

- cnos#568 FSM Phase 1 (shipped) — read-only observation baseline.
- cnos#569 FSM Phase 2 (in progress) — mutation authority for reliable state observation.
- cnos#501 κ role (status:ready) — authorship rule enforcement.
- Operator dispatch of Sub 3.1 → dispatch of Sub 3.2 in sequence.
