# Wave state

**Updated:** 2026-08-01 (git-native program section below; cohere-wave block is stale — see its note)

Cross-cutting state that doesn't belong to a single channel entry.

## Repo-coherence + git-native program (active — 2026-08-01)

The three-plane model: `main` HEAD = current state · `main` ancestry = the CDD episodes that warranted it · independent append-only refs = channels/journals/telemetry · **promotion** = the only lawful crossing from an independent stream into project authority. Manual open-set (stands in for the #683 radar until it ships).

| Goal / item | Home | State |
|---|---|---|
| Repo cleanup — docs surface | cnos #679 | ✅ MERGED (merge commit `042f26a9`) |
| Repo cleanup — code pass + first-principle doctrine (`§5` + `KERNEL §2.1`) | cnos #681 | ✅ MERGED (merge commit `894fc4ca`) |
| `.cdd` dematerialization (ancestry plane) | cnos #682 | design-ready; contract reconciled (scope-fix comment 5150296362); **NOT dispatched — awaits operator go** |
| Sigma comms → git-native (independent-stream plane) | cnos #684 | design-ready; cursor-ownership/Writer-Locality pinned (comment 5150295869); **NOT dispatched** |
| ↳ hub adoption (2b): migrate cnos/bumpt channels off `main` → orphan refs; rewrite `activate/SKILL.md` (write-own-ref / poll-other) + `spec/OPERATOR.md` | cn-sigma | pending #684 ratify; `activations.md v1.3` seeds the schema |
| cmp added to activations | cn-sigma `activations.md v1.3` | ✅ registered (orphan-ref, tip `8986ad8`); **first ingest pending an attach** |
| open-items ledger / radar | cnos #683 | design-ready; NOT dispatched (this section is the manual stand-in) |
| repo-self-coherence methodology | cnos #680 | filed |
| reviewer/cell learnings | cnos #674, #675, #676, #677, #678 | filed |

**Recommended sequence:** ratify #684 (2a) → hub migration (2b) → #682 in parallel on cnos.

### Parked operator decisions

- **γ-firebreak fork — #671 / #672:** **A** operator closes γ · **B** external γ · **C** accept the bootstrap residual. External-β established that γ≠κ cannot be proven inside one AI trust-domain → routed to the operator. Also in `cnos:.cdd/unreleased/671/self-coherence.md` (Known debt). Blocks the #671 wave returning to its authorization gate.
- **#682 / #684 dispatch** — both design-ready, awaiting explicit operator authorization to dispatch (and, for #682, whether to drive it as κ-via-cnos-PR or via cds-dispatch).

## Cohere wave (v3.83.0 target)

> ⚠️ **Pre-July surface — needs a freshness pass.** This table was last touched 2026-06-20 and predates the cell-runtime-doctrine wave (#671), the repo-cleanup stack (#679/#681), and the git-native program above. Carried forward un-verified rather than silently dropped; reconcile against current cnos issue state before relying on it.

| Step | Issue / PR | State |
|---|---|---|
| 1 | PR #445 — Writer Locality | MERGED |
| 2 | cnos#446 — Tier 1a/1b activation (PR #455) | MERGED |
| 3 | cnos#448 doctrine (PR #456) + cn-sigma migration (PR #10) | COMPLETE |
| **4** | cnos#449 + cnos#454 (parallel) | **UNBLOCKED — operator directive pending** |
| 5 | cnos#450 wake-template | queued |
| 6 | cnos#444 cohere skill | queued; v3.83.0 candidate |
| 7 | cnos#452 substrate v0 | queued |
| 8 | cnos#453 NIM canary follow-on | queued |

**v3.83.0** held per D14; cuts when full wave lands.

## Watches (ongoing; not hard blockers)

### GH Actions cron drop rate ~83%

- cnos cron `:08 / :23 / :38 / :53` (4/hr expected) — empirical ~17% effective
- Mitigation v1 (multi-cron stagger): shipped cnos `c619a14300` 2026-06-02; insufficient
- Mitigation v2 (CF Worker + `repository_dispatch`): designed at cnos#457; D21 RESCINDED 2026-06-18 ("not until GH fails completely")
- Re-eval trigger: persistent >24h wake silence OR cohere implementation specifically cron-blocked

## Held / deferred surfaces

- **cnos#444 implementation** — v3.83.0 candidate; held per D14 (foundation authorization stops at Steps 1–8 mechanics; cohere skill itself gates on full wave landing)
- **D21 (CF Worker external scheduler)** — design at cnos#457; rescinded; trigger conditions above
- **Broadcast architecture** (privacy Amendment 3) — adhoc captured at `threads/adhoc/20260618-privacy-modes-and-memory-return.md`; cnos issue dispatch held until cnos#460 round-2 converges
- **Sigma-as-GitHub-App** (full Contributors-panel attribution) — heavier infra; tracked under cnos#444 AC18 caveat; cnos#449 carries the email-shape email-template footnote
- **Memory-return mechanism v1** (bridge agent) — deferred per cnos#460 AC6 design

## Conventions

Event-level blockers and resolutions live in per-activation channels (`threads/activations/{name}/YYYYMMDD.md`) and surface to Telegram via the wake-walker. Cross-cutting state (above) lives here. This file is updated by γ-console; channels are updated by wake workers.
