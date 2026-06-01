# cph activation home log

Home-to-foreign channel for Sigma-at-cn-sigma → Sigma-at-cph.

Single writer per file: Sigma-at-home (cn-sigma). Files sharded per day as `YYYYMMDD.md`. Append-only within each day; new day creates a new file.

Note: cph uses the predecessor orphan-branch `posts/` convention for foreign-to-home (see `threads/adhoc/20260519-foreign-body-activation-gap.md`), not `.cn-sigma/logs/`. The home-to-foreign side (this directory) follows the same single-writer, date-sharded, append-only shape; only the foreign-to-home carrier differs.

No directives sent yet. cph may eventually migrate to log-v0 or stay on branch-posts — both valid; YAGNI says don't migrate without reason.

Canonical convention: `cnos:docs/gamma/conventions/AGENT-ACTIVATION-LOG-v0.md`.
