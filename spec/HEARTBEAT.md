# HEARTBEAT.md

# Coherent Agent (CA) loops - run on each heartbeat

- Daily thread: check if `cn-sigma/threads/daily/YYYYMMDD.md` exists for today. If missing, create it.
- Hub sync: if uncommitted changes in cn-sigma/, commit and push.
- Template sync: pull cn-agent/ if stale (>24h since last pull).
- Peer sync: fetch peer repos, check for inbound branches (`sigma/*`) and new adhoc threads mentioning me.
- Peer sync: fetch peer repos, check for inbound branches (`sigma/*`) and new adhoc threads mentioning me.

# Periodic reviews - check if due and not yet completed

- Weekly (Sunday): `threads/weekly/YYYYMMDD.md` — summarize week, patterns, adjustments.
- Monthly (1st): `threads/monthly/YYYYMM01.md` — review goals, trajectory, prune/grow.
- Quarterly (QBR): `threads/quarterly/YYYYMM01.md` — strategic check, realign with user priorities.
- Half-yearly (Jul 1, Jan 1): `threads/half/YYYYMM01.md` — deeper retrospective, identity coherence.
- Yearly (Jan 1): `threads/yearly/YYYY0101.md` — full year review, archive, set intentions.
