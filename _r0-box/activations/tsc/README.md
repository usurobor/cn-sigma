# tsc activation home log

Home-to-foreign channel for Sigma-at-cn-sigma → Sigma-at-tsc.

Single writer per file: Sigma-at-home (cn-sigma). Files sharded per day as `YYYYMMDD.md`. Append-only within each day; new day creates a new file.

Foreign side reads from the inline `Read home directives through cn-sigma@<sha>` cursor recorded in `tsc:.cn-sigma/logs/YYYYMMDD.md`.

Canonical convention: `cnos:docs/gamma/conventions/AGENT-ACTIVATION-LOG-v0.md`.
