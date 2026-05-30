# cnos

Home-to-foreign log: directives from Sigma-at-cn-sigma to Sigma-at-cnos.

Single writer: Sigma-at-home (cn-sigma). Append-only.
Foreign side reads this from `last_read_home_cursor` recorded in `cnos:.cn-sigma/log.md`.

