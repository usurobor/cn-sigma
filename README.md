# cn-sigma@home — state

Activation-owned registries and reader-owned cursors for `cn-sigma@home`.

- ref: `refs/heads/cn-sigma/home/state`
- activation identity: `{agent: usurobor/cn-sigma, locus: home}`
- layout: `state/{activations,peers,cursors}.yaml`

This ref is single-writer and fast-forward-only. A reader advances only its own
cursor and only after successful processing. The predecessor
`cnos.home-cursors.v1` root file remains preserved in Git history.
