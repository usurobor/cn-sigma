# Prune manifest (#704) — candidates only, NOTHING deleted

This working cell deletes nothing. This is a list of prune candidates with a
one-line disposition each, for **δ / operator** to act on. Branch deletion, PR
closure, and ref deletion are external gates held by δ.

Environment note: `gh` is not available in this cell, so PR live-states below
are **unverified** (dispositions reflect the #704 dispatch's characterization,
not a fresh GitHub read). Branch and ref data below ARE freshly observed via
`git ls-remote origin`.

## Stale remote branches (observed via `git ls-remote`)

| Branch | Disposition |
|---|---|
| `feat/wake-walker-v1` | Stale wake-walker experiment; superseded by cnos-side wake-as-skill (#524) — δ delete after confirming no unmerged content. |
| `feat/wake-notify-walker` | Stale wake/notify-walker experiment; same lineage as above — δ delete after confirm. |
| `feat/notify-telegram-script` | Stale notify-script branch; script already on `main` under `scripts/` — δ delete after confirm merged. |
| `feat/cnos-448-migration` | The cnos#448 containerization migration branch (`.cn-{agent}/` wrapper era); that wrapper is now unwound by #704 — δ delete after confirm merged. |
| `coherer-watch` | Stale watch branch; `state/coherer-watch.md` already tracks this on `main` — δ delete after confirm no unmerged content. |
| `claude/cn-sigma-activation-gwxlt3` | Dead `claude/*` session branch — δ delete. |
| `claude/review-context-EbgR2` | Dead `claude/*` session branch — δ delete. |
| `claude/epic-gauss-5fjs9q` | **DO NOT PRUNE** — parent of this #704 branch; carries this session's backfilled reflections + `state/wave.md`. Keep until #704 merges. |
| `main` | Keep (default). |
| `claude/704-normalize-home` | This migration branch (not yet pushed by this cell). Keep. |

## Stray experimental ref (observed via `git ls-remote origin 'refs/cn/*'`)

| Ref | SHA | Disposition |
|---|---|---|
| `refs/cn/msg/sigma/19d5249d681-671a@sigma` | `d7488b985a1bb52913db6ba74a4b44ee3080d4d7` | Stray CN-mail message-ref experiment (the pre-log-v0 `refs/cn/msg/…` packet-transport trial). Superseded by activation-log-v0 (single-writer per-day sharded files). δ delete the ref after confirming its content is captured in the adhoc/log history. |

## Old PRs (unverified — `gh` unavailable this cell)

| PR range | Disposition |
|---|---|
| `#9`–`#16` | Old cn-sigma migration/notification-era PRs (e.g. the cnos#448 containerization migration PR #10, the D34 notification-cursor seed PR #12 referenced in `state/notification-cursors.yaml`). δ to verify each is merged/closed on GitHub and close any lingering open ones. None should be reopened; none deleted here. |

## Dead / candidate wake+notify scripts under `scripts/`

**Not asserted dead — flagged for δ review.** These are still wired to live
state (`state/notification-cursors.yaml`, `state/notification-targets.yaml`),
so they are NOT dead until the wake/notify workflow is confirmed retired under
the #690/#698 box model.

| Script | Disposition |
|---|---|
| `scripts/notify-walk.sh` | Wake-walker Telegram notifier. Candidate for retirement if wake becomes a cnos skill (#524); still live today — δ confirm before removal. |
| `scripts/notify-telegram.sh` | Telegram POST helper for the above; same status. |
| `scripts/test-notify-walk.sh` | Test for notify-walk; retire with its target. |
| `scripts/test-notify-telegram.sh` | Test for notify-telegram; retire with its target. |
| `scripts/README.md` | Documents the notify scripts; update or retire alongside them. |
| `scripts/remote-service` | Runner service script; keep (infra, not wake/notify). |

## Candidate r0 surfaces NOT moved by #704 (scope note for δ)

`#704` moved exactly the enumerated `threads/*` surfaces into `_r0-box/`. Two
root surfaces are arguably r0 but were **out of the explicit #704 move list**
and left in place:

- `logs/` (runtime run-logs + input logs) — high-volume raw evidence; δ may
  fold into the off-HEAD r0 transport.
- `.cdd/iterations/cross-repo/…` — cross-repo CDD iteration scratch; arguably r0.

Neither was touched. δ to decide disposition.
