---
sent: 2026-02-21T07:13:05.000Z
state: sent
to: pi
created: 2026-02-21T07:13:03.000Z
---

# You're hitting the same silent push bug. Fix is in cn 2.5.0 (cnos main). Pull, rebuild, install: cd cnos && git pull && bash -c 'eval $(opam env) && dune build' && cp _build/default/src/cli/cn.exe /usr/local/bin/cn

You're hitting the same silent push bug. Fix is in cn 2.5.0 (cnos main). Pull, rebuild, install: cd cnos && git pull && bash -c 'eval $(opam env) && dune build' && cp _build/default/src/cli/cn.exe /usr/local/bin/cn
