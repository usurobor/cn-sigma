# bumpt

Home-to-foreign log: directives from Sigma-at-cn-sigma to Sigma-at-bumpt (bump-sigma).

Single writer: Sigma-at-home (cn-sigma). Append-only.
Foreign side reads this from `last_read_home_cursor` recorded in `bumpt:.cn-sigma/log.md`.

