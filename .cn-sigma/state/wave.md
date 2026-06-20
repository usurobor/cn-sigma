# Wave state

**Updated:** 2026-06-20

Cross-cutting state that doesn't belong to a single channel entry.

## Cohere wave (v3.83.0 target)

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
