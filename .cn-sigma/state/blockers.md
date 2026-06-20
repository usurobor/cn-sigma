# Blockers — current state

**Updated:** 2026-06-20 05:12Z (home sync at activation)
**Class:** state; canonical surface for active blockers requiring operator attention

Blocker = anything that prevents Sigma (at any body) from making forward progress and requires action from outside the agent system (operator, infrastructure, external authority).

---

## BLOCKER 1 — D33 at cnos: `chore/remove-direct-notifications` push blocked (workflows permission)

**Detected:** 2026-06-20T05:00Z (Sigma-at-cnos foreign-log entry `52764d4`)
**Surface:** `cnos:.github/workflows/` (build.yml + release.yml)
**State:** UNRESOLVED — operator push required

**What happened:**
- D33 audit complete: `build.yml` (−62 lines) and `release.yml` (−40 lines) notify jobs removed. Both were direct `curl` POSTs to `api.telegram.org` via `TG_BOT_TOKEN`/`TG_CHAT_ID`.
- `claude-wake.yml` clean (preserved); no external notification steps.
- Removal committed in branch `chore/remove-direct-notifications` (commit `3b2a6c0` from retry session).
- GitHub App token lacks `workflows` scope → push rejected.

**Operator action required:**

```bash
# From a privileged context with cnos clone:
git cherry-pick 3b2a6c0   # or push branch directly
git push origin chore/remove-direct-notifications
gh pr create --repo usurobor/cnos \
  --title "chore: remove direct bot notifications (cn-sigma is sole publisher now)" \
  --body "Removed notify jobs from build.yml (−62 lines) and release.yml (−40 lines). Both posted directly to Telegram via TG_BOT_TOKEN/TG_CHAT_ID. cn-sigma home worker is now sole publisher per D33. Ref: cn-sigma PR #11."
# After PR merges, delete orphaned secrets:
gh secret delete TG_BOT_TOKEN --repo usurobor/cnos
gh secret delete TG_CHAT_ID --repo usurobor/cnos
```

**Also:** cnos#462 (opened per D32 before rescission) needs operator cleanup:
- Tag: `priority/deferred`
- Comment: "Deferred — implementation moved to cn-sigma side; cnos changes not required for v0. Re-evaluate when multi-activation coordination needs explicit notify opt-in."

---

## WATCH 1 — GH Actions cron drop rate ~83% (chronic; structural)

**Detected:** 2026-06-18 (reviewer empirical observation)
**Surface:** GitHub Actions cron at cn-sigma + cnos
**State:** ONGOING; not a hard blocker, but throttles wave throughput

**What's happening:**
- cnos wake cron configured at `:08 / :23 / :38 / :53` (4/hr expected = ~96/day)
- Empirical: 19 wakes observed over ~28h window = ~83% effective drop
- cn-sigma similar pattern with smaller drop rate
- Reviewer's earlier estimate: "Drop rate empirically ~50-90% during high-load UTC windows"

**Mitigation status:**
- v1 (multi-cron stagger): shipped at cnos `c619a14300` 2026-06-02; empirically insufficient
- v2 (CF Worker + `repository_dispatch`): designed at cnos#457; D21 RESCINDED 2026-06-18 per operator direction ("not until GH fails completely")
- Re-eval trigger condition flagged: persistent >24h wake silence OR cohere implementation specifically cron-blocked

**Operator action:** none required today; flagging for visibility. Trigger condition not yet met; D21 stays deferred.

---

## RESOLVED THIS WINDOW (kept for one cycle for visibility)

- **D24/AI1 orphaned at cnos** (06-19 02:14 ET) — PR #461 merged `d5119180` 2026-06-19T23:56Z. Wake yaml on main with `bot_name`, `bot_id`, `settings:` block. Resolved.
- **D24/AI4 mis-classified RESOLVED-AS-FINDING** — γ-console correction 2026-06-20T02:16Z: `bot_name` DOES change git authorship; post-merge wakes authored `sigma@cnos.cn-sigma.cnos`. Status: PASSED with email-shape caveat.
- **PR #10 stale-vs-main concern** (06-18) — rebased to `4e31851ca`, then merged at `3348617ab` 2026-06-19. Resolved.
- **Reviewer Checkpoint B fix loops** (06-17/18) — 3 rounds across PR #456 + PR #10; reviewer verdict 2026-06-19 = PASSES. Resolved.
- **cnos cron-drop gap** (06-17 → 06-18 ~10h window) — resumed firing 06-18 afternoon UTC. Resolved (operationally; structural watch remains).

---

## Format note

This file is the canonical blockers surface. Entries follow:
- BLOCKER N — short title (severity; age) — UNRESOLVED
- WATCH N — short title — ONGOING (not hard blocker, requires monitoring)
- RESOLVED THIS WINDOW — kept for one cycle for visibility

Updates: γ-console manually today. Future: any wake that detects a new blocker (orphan / degraded outcome / cron silence > N hours) updates this file AND pushes a notification to Telegram (when CI-notify shipped at cn-sigma).
