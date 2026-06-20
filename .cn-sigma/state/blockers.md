# Blockers — current state

**Updated:** 2026-06-19 ET (γ-console manual; automation pending)
**Class:** state; canonical surface for active blockers requiring operator attention

Blocker = anything that prevents Sigma (at any body) from making forward progress and requires action from outside the agent system (operator, infrastructure, external authority).

---

## BLOCKER 1 — D24/AI1 orphaned at cnos (HIGH; ~36h old)

**Detected:** 2026-06-19 02:14 ET (Sigma-at-cnos foreign-log entry)
**Surface:** `cnos:.github/workflows/claude-wake.yml`
**State:** UNRESOLVED

**What happened:**
- D24 dispatched (2026-06-18) to apply canonical `bot_name: "sigma@cnos.cn-sigma.cnos"` + `bot_id: "41898282"` + settings block to cnos wake yaml.
- Sigma-at-cnos applied at commit `084912b` but **never merged to main**. Commit sits on a dead branch with parent `f6abf8c5`.
- Root cause: Edit permission not in cnos session's `settings.local.json` allow list (`["Read", "Write", "Bash"]` only). Chicken-and-egg: expanding permissions requires Edit.

**Side effects:**
- D24/AI3 (delete `cnos:.claude/settings.local.json`) gated on AI1 landing
- D24/AI4 (verify next-wake author attribution) shows `claude[bot]` because AI1's change isn't on main
- cnos's Contributors panel + git author still attribute to `claude[bot]` instead of `sigma@cnos.cn-sigma.cnos`
- Doesn't gate the cohere wave directly but blocks the committer-identity convention's actual landing at cnos

**Operator options (Sigma-at-cnos's own report):**

> **(a) Manual apply:** edit `usurobor/cnos:.github/workflows/claude-wake.yml`, add under `anthropics/claude-code-action@v1`:
> ```yaml
> bot_name: "sigma@cnos.cn-sigma.cnos"
> bot_id: "41898282"
> settings:
>   permissions:
>     allow: ["Read", "Write", "Edit", "MultiEdit", "Glob", "Grep", "Bash"]
> ```
> Commit + push.
>
> **(b) Grant Edit permission** to cnos session token, re-trigger cnos wake — Sigma-at-cnos will re-apply automatically.

Option (a) is faster (one-line edit). Option (b) fixes the structural cause (Edit-permission gap will likely recur for future similar work).

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
