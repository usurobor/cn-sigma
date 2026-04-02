# Heartbeat

1. `cd /root/.openclaw/workspace/cn-sigma && git pull --ff-only`
2. `cd /root/.openclaw/workspace/cnos && git pull --ff-only`
3. Load cnos.core skills: read `cnos/src/agent/skills/ops/inbox/SKILL.md`, `ops/peer/SKILL.md`, and any other relevant skills before processing.
4. Check for new messages in `threads/mail/inbox/` — if any are unread, triage per inbox skill (Delete/Defer/Delegate/Do) and act accordingly.
5. If nothing needs attention, reply HEARTBEAT_OK.
