# Blockers — current state

**Updated:** 2026-06-20 05:20Z (post-PR #12 merge + cnos home-sync refresh)
**Class:** state; canonical surface for active blockers requiring operator attention

Blocker = anything that prevents Sigma (at any body) from making forward progress and requires action from outside the agent system (operator, infrastructure, external authority).

---

## BLOCKER 1 — D33 at cnos: `chore/remove-direct-notifications` push blocked (workflows permission)

**Detected:** 2026-06-20T05:00Z (Sigma-at-cnos foreign-log entry `52764d4`)
**Surface:** `cnos:.github/workflows/` (`build.yml` + `release.yml`)
**State:** UNRESOLVED — operator push required

**What happened:**
- D33 audit complete: `build.yml` (−62 lines) and `release.yml` (−40 lines) notify jobs removed. Both were direct `curl` POSTs to `api.telegram.org` via `TG_BOT_TOKEN`/`TG_CHAT_ID`.
- `claude-wake.yml` clean (preserved); no external notification steps.
- Removal committed in branch `chore/remove-direct-notifications` (latest commit `3b2a6c0`).
- GitHub App token lacks `workflows` scope → `git push` rejected.
- `gh secret delete TG_BOT_TOKEN` and `gh secret delete TG_CHAT_ID` returned HTTP 403 (same permission gap).

**Operator action required:**

```bash
# From a privileged context with cnos clone (workflows-scoped PAT):
git cherry-pick 3b2a6c0     # or push branch directly if already on it
git push origin chore/remove-direct-notifications
gh pr create --repo usurobor/cnos \
  --title "chore: remove direct bot notifications (cn-sigma is sole publisher now)" \
  --body "Removed notify jobs from build.yml (−62 lines) and release.yml (−40 lines). Both posted directly to Telegram via TG_BOT_TOKEN/TG_CHAT_ID. cn-sigma home worker is now sole publisher per D33. Ref: cn-sigma PR #11."
# After PR merges, delete orphaned secrets:
gh secret delete TG_BOT_TOKEN --repo usurobor/cnos
gh secret delete TG_CHAT_ID --repo usurobor/cnos
```

---

## BLOCKER 2 — cnos#462 cleanup (D32 rescinded after AI1 already ran)

**Detected:** 2026-06-20T05:00Z (Sigma-at-cnos foreign-log entry `52764d4`)
**Surface:** https://github.com/usurobor/cnos/issues/462
**State:** UNRESOLVED — operator cleanup required

**What happened:**
- D32 dispatched 06-20 01:00Z (open cnos issue `agent/notification-protocol`)
- Sigma-at-cnos applied D32/AI1 at 06-20 01:38Z → cnos#462 opened
- γ-console rescinded D32 at 02:00Z (over-scoped; the work belongs at cn-sigma alone for v0)
- Sigma-at-cnos walked the rescission at 05:00Z and noted: "No cnos issue was the intent. But D32/AI1 had already run."

**Operator action required:**

- Tag cnos#462 with `priority/deferred`
- Add comment to cnos#462:
  > "Deferred — implementation moved to cn-sigma side per D32 rescission. cnos changes not required for v0; the home worker (cn-sigma) is sole publisher. Re-evaluate when multi-activation coordination needs explicit `notify:` opt-in semantics."

---

## WATCH 1 — GH Actions cron drop rate ~83% (chronic; structural)

**Detected:** 2026-06-18 (reviewer empirical observation)
**Surface:** GitHub Actions cron at cn-sigma + cnos
**State:** ONGOING; not a hard blocker, but throttles wave throughput

**What's happening:**
- cnos wake cron configured at `:08 / :23 / :38 / :53` (4/hr expected = ~96/day)
- Empirical: 19 wakes observed over ~28h window = ~83% effective drop
- cn-sigma similar pattern with smaller drop rate

**Mitigation status:**
- v1 (multi-cron stagger): shipped at cnos `c619a14300` 2026-06-02; empirically insufficient
- v2 (CF Worker + `repository_dispatch`): designed at cnos#457; D21 RESCINDED 2026-06-18 ("not until GH fails completely")
- Re-eval trigger condition: persistent >24h wake silence OR cohere implementation specifically cron-blocked

**Operator action:** none required today; flagging for visibility. Trigger condition not yet met; D21 stays deferred.

---

## RESOLVED THIS WINDOW (kept for one cycle for visibility)

### Wave milestone resolutions (06-20 dawn ET)

- **PR #456 cnos MERGED** at `34ebbe699` (D29 γ-closure via Sigma-at-cnos). STATUS line: `landed gamma@cnos cnos#448 34ebbe699 3.83.0-candidate`. **Wave Step 3 COMPLETE.** **Wave Step 4 NOW UNBLOCKED** (cnos#449 + cnos#454 parallel; awaiting explicit operator Step 4 directive).
- **PR #10 cn-sigma MERGED** at `3348617ab` (γ-closure at home; reviewer Checkpoint B GREEN). Containerization landed.
- **Reviewer Checkpoint B FULLY CLOSED** after PR #456 + PR #10 both merged. The "fix loop, not failure loop" pattern landed clean across 3 review rounds.

### cnos doctrine cycle progress

- **cnos#458 round-2 amendments applied** (D30) — `target_disposition` / `author.body` / `source_ref` provenance fixes per reviewer round-1 verdict. Convergence comment: https://github.com/usurobor/cnos/issues/458#issuecomment-4755424793. Awaiting reviewer round-3.
- **cnos#460 round-1 amendments + 9 open-question answers applied** (D31). Convergence comment: https://github.com/usurobor/cnos/issues/460#issuecomment-4755429170. Awaiting reviewer round-2.
- **cnos#459 reviewer CONVERGED** (cdd/committer-identity canonical-form spec). Implementation pending.

### Operational resolutions

- **D24/AI1 RESOLVED** — cnos PR #461 merged `d5119180` (branch `wake/d24-attribution-edit-allowance`). `claude-wake.yml` on main with `bot_name: "sigma@cnos.cn-sigma.cnos"` + `bot_id` + `settings:` block. Post-merge wakes authoring as canonical form. The Edit-permission gap that blocked D24 for ~22 hours is closed.
- **D24/AI3 RESOLVED** — `.claude/settings.local.json` confirmed absent from cnos repo.
- **D24/AI4 PASSED with email-shape caveat** — `bot_name` does change git authorship (initially mis-classified by Sigma-at-cnos checking pre-merge commit; γ-console corrected at 02:16Z). Post-merge wakes show committer `sigma@cnos.cn-sigma.cnos <41898282+sigma@cnos.cn-sigma.cnos@users.noreply.github.com>`. Email template has two `@`s (noreply-form artifact); accepted as known partial; full fix tracked under cnos#449.
- **D17 / D19 / D20** (cnos-side fixes per Checkpoint B deep-pass) — all confirmed applied.
- **D25** (cnos#458 round-1 amendments) — applied; superseded by D30 round-2 work.
- **D28** (cnos#460 round-1 open) — applied; cnos#460 opened.
- **D29** (PR #456 γ-closure + cnos#459 bookkeeping) — applied.
- **PR #12 cn-sigma MERGED** at `8e7f9ed9d` (D34 wake-walker → Telegram). Substantive cnos/bumpt events now auto-publish to Telegram from the next wake forward. Cursors seeded to current-latest so historical backlog stays silent.

---

## Wave state at end-of-window (2026-06-20 05:20Z)

- **Step 1** (PR #445 Writer Locality): MERGED
- **Step 2** (cnos#446 Tier 1a/1b): MERGED (PR #455)
- **Step 3** (cnos#448 containerization doctrine + PR #10 migration): **COMPLETE** — both PRs merged
- **Step 4** (cnos#449 + cnos#454 parallel): **UNBLOCKED** — awaiting operator Step 4 directive
- **Steps 5-8**: queued
- **v3.83.0**: held per D14; cuts when full wave lands

---

## Format note

This file is the canonical blockers surface. Entries follow:
- BLOCKER N — short title (severity; age) — UNRESOLVED
- WATCH N — short title — ONGOING (not hard blocker, requires monitoring)
- RESOLVED THIS WINDOW — kept for one cycle for visibility

Updates: γ-console manually today. Future: PR #12 wake-walker now auto-publishes substantive events to Telegram on each wake; manual blocker updates here remain γ-console's responsibility (any wake that detects a new blocker — orphan / degraded outcome / cron silence > N hours — surfaces via the wake-walker notification path).
