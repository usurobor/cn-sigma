# HEARTBEAT.md

Runs every 30 min. Check time for conditional tasks.

## Every heartbeat

- Daily thread: if `threads/daily/YYYYMMDD.md` missing, create it
- Hub sync: if uncommitted changes in cn-sigma/, commit and push
- Template sync: if cn-agent/ not pulled in >24h, pull
- Peer sync: fetch peer repos, check for inbound branches (`sigma/*`) and new adhoc threads mentioning me

## Time-conditional (check clock, user timezone: ET)

- **23:00-23:59 ET**: EOD review — if today's daily thread incomplete, finish α/β/γ reflection
- **Sunday**: Weekly review — if `threads/weekly/YYYYMMDD.md` missing for this week, create it
- **1st of month**: Monthly review — if `threads/monthly/YYYYMM01.md` missing, create it
- **Quarterly (Apr/Jul/Oct/Jan 1)**: Quarterly review — if missing, create it
- **Half-yearly (Jul/Jan 1)**: Half review — if missing, create it
- **Jan 1**: Yearly review — if missing, create it

## Alert rules

- Inbound branch found → alert immediately
- Thread mention found → alert immediately
- Review due but not done → alert once, then silent until done
- Everything OK → HEARTBEAT_OK (silent)
