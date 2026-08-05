# r0 box — home's raw evidence (staged for off-HEAD transport)

This is home's **r0 evidence**: the raw, continuous, fan-out surfaces that sit
at the bottom of the compaction tower. Under the #690/#698 box-topology model,
**r0 belongs OFF-HEAD** — HEAD holds only the r1+ tower plus spec, state, and
scripts.

**δ transports this box to the off-HEAD orphan ref `cn-sigma/home/memory` and
strips it from HEAD (#704 AC4).** This working cell cannot create orphan refs
cleanly, so its job was to gather all of home's r0 into one clearly-labeled
place with **zero content loss**. The orphan-ref transport + HEAD-strip is δ's
step.

**Nothing here is deleted. It is relocated.** Every file was moved with
`git mv`; `git log --follow <file>` recovers each file's full history back
through its former `.cn-sigma/threads/...` path.

## Contents (each a relocated raw-evidence surface)

| Dir / file | Former path | What it is |
|---|---|---|
| `adhoc/` | `.cn-sigma/threads/adhoc/` | Adhoc decision-capture threads (the primary r0 stream). |
| `activations/` | `.cn-sigma/threads/activations/` | Per-activation home→foreign log channels (`cnos/`, `bumpt/`, `tsc/`). |
| `rca/` | `.cn-sigma/threads/rca/` | Root-cause analyses. |
| `out/` | `.cn-sigma/threads/out/` | Outbound coordination surface. |
| `in/` | `.cn-sigma/threads/in/` | Inbound coordination surface. |
| `inbox/` | `.cn-sigma/threads/inbox/` | Inbox + `inbox/archive/`. |
| `pulse/` | `.cn-sigma/threads/pulse/` | Pulse thread. |
| `deferred/` | `.cn-sigma/threads/deferred/` | Deferred coordination items. |
| `archived/` | `.cn-sigma/threads/archived/` | Archived peer threads. |
| `legacy-activations-walklog.md` | `.cn-sigma/state/activations.md` | The old walk-log activations registry (r0 history), superseded on HEAD by `state/activations.yaml` + `state/peers.yaml` + `state/cursors.yaml`. |
| `PRUNE-MANIFEST.md` | (new) | Non-destructive prune candidates for δ/operator to act on. |
| `704-self-coherence.md` | (new) | The #704 migration receipt. |

## Why r0 is off-HEAD

`r0 fans out / r1 funnels in`. r0 is high-volume, append-heavy, and cited by
r1 compactions but not itself carried on HEAD. Keeping it off-HEAD keeps the
working tree small and the compaction tower clean while preserving all evidence
behind a ref. Home is the sole compactor.
