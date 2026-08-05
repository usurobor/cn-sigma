# cn-sigma home r0 box — `refs/heads/cn-sigma/home/memory`

Home's own **r0** evidence box (per cnos#690). Orphan ref, off `main` ancestry,
single-writer (this home), append-only, fast-forward-only, no force-push,
no-delete-while-registered.

- **r0 here** = home's raw local evidence.
- **r1+** (compactions) live at `main` HEAD under `reflections/{r1,r2,r3}/` — home
  reads this box + every registered activation box and compacts upward, citing
  the SHAs it read (`reads:`).
- This box starts empty: the pre-#704 raw evidence was either already compacted
  into the r1 tower or was heartbeat churn (dematerialized to ancestry, not lost).

Governing design: cnos#690 (ranked memory), cnos#698 (dialogue protocol).
