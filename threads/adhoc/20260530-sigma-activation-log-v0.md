---
title: Sigma activation log convention v0 — minimal cross-activation comms
date: 2026-05-30
status: adhoc
scope: field-convention
---

# Sigma activation log convention v0

A minimal field convention to enable Sigma's cross-activation continuity at cnos, cph, and bumpt without standing up the full CN mail layer.

## What this is (and isn't)

- **Is:** a two-file, single-writer, append-only convention with split cursors, governed by repo push permission and git history.
- **Isn't:** signing, envelopes, entry IDs, `merge=union`, CN mail directories, packet refs.
- **Isn't:** the final CN mail protocol. See `cnos:docs/alpha/protocol/WHITEPAPER.md` v3.0.0 for Protocol v1 (signed + entry-IDed + union-merged) and `cnos:docs/alpha/protocol/MESSAGE-PACKET-TRANSPORT.md` (cnos#150) for the ref-based packet evolution. v0 is the bridge to today's volume.

## Activations vs peers (terminology)

- **Activation** = Sigma's own body at another repo. Same identity, different location. cnos / cph / bumpt today.
- **Peer** = a different agent (different persona, different keys). cn-rho (researcher; cdr package) would be a peer, not an activation.

The v0 convention here is for **activations** — self-to-self memory return across bodies. A peer-comms convention (cross-persona) is a different problem; not addressed here. Currently zero peers are registered; `state/peers.md` is a schemaed placeholder.

## The two artifacts

| File | Single writer | Direction |
|---|---|---|
| `<activation-repo>:.cn-sigma/log.md` | Sigma-at-that-activation | foreign → home |
| `cn-sigma:threads/activations/{activation}.md` | Sigma-at-home (cn-sigma) | home → foreign |

For today's three activations:
- `cnos:.cn-sigma/log.md` ← Sigma-at-cnos writes
- `bumpt:.cn-sigma/log.md` ← Sigma-at-bumpt (bump-sigma) writes
- cph uses the predecessor orphan-branch `posts/` convention instead — same single-writer principle, different carrier
- `cn-sigma:threads/activations/cnos.md` ← Sigma-at-home writes
- `cn-sigma:threads/activations/bumpt.md` ← Sigma-at-home writes
- `cn-sigma:threads/activations/cph.md` ← Sigma-at-home writes

## The activation loop

1. Pull `cn-sigma` and the current activation repo.
2. Read activation's `.cn-sigma/log.md` from `last_read_foreign_log` (in `cn-sigma:state/activations.md`) to activation HEAD. (cph: walk `posts/` on the `cn-sigma` orphan branch.)
3. Read `cn-sigma:threads/activations/{activation}.md` for directives from home (foreign Sigma scans its own log for the last `Read home directives through cn-sigma@{sha}` entry to find its own cursor).
4. Do the work.
5. Append to the local writer-owned log.
6. Commit and push.
7. Home Sigma updates `last_read_foreign_log` in `state/activations.md`.
8. Foreign Sigma records home-read cursor inline:
   `## YYYY-MM-DD — Read home directives through cn-sigma@{sha}`.

## Entry format

```
## YYYY-MM-DD — short subject
Body. Free-form markdown. Blank line at end.

```

No YAML frontmatter. No entry_id. No envelope. The H2 header is the entry boundary; the file's git history is the trace.

## Cursor model

| Direction | Cursor location | Written by |
|---|---|---|
| home reads foreign | `cn-sigma:state/activations.md` → `last_read_foreign_log: <sha>` per activation | home Sigma |
| foreign reads home | `<activation-repo>:.cn-sigma/log.md` → dated entry `Read home directives through cn-sigma@<sha>` | foreign Sigma |

Two-artifact rule preserved: no third file. Foreign Sigma recovers its own cursor by scanning its own log for the latest "Read home directives" entry.

## Trust boundary (v0)

- **Single writer per file** — no impersonation surface in-hub.
- **Repo push permission** — GitHub does the auth via deployed token.
- **Git history** — `git log <file>` answers "did I send this?" with author + commit SHA.
- **Good enough until** volume forces real signing.

## What's deferred (with rationale)

| Deferred | Why deferred at v0 |
|---|---|
| Signed commits + `cn.json` | Repo push permission is the trust anchor; no impersonation surface at v0 volume. |
| Entry IDs (ULID) | File path + commit SHA + line range serves; only matters under union-merge concurrency. |
| Envelope / frontmatter per entry | Single H2 header is enough; routing is implicit in the file. |
| `merge=union` driver | Single-writer per file → no union needed. |
| CN mail dirs (`inbox/outbox/sent`) | Already explored and dropped — overkill for single-writer logs. |
| Ref-based packets (cnos#150) | Future evolution at higher volume / adversarial routing. |
| Peer-comms convention (cross-persona, e.g. ↔ cn-rho) | Different problem; this convention is self-to-self only. |

## One caveat

Single-writer is **logical, not physical**. If two Sigma activations run concurrently in the same activation repo, they can still race on `.cn-sigma/log.md`. The rule is:

> Only one active Sigma writer per activation log at a time.

If that breaks in the field, the first repair is sharding (`.cn-sigma/log/YYYY-MM-DD.md` or `.cn-sigma/log/{activation-id}.md`), not signatures. Do not prebuild.

## What shipped at cn-sigma today

1. `state/activations.md` (renamed from `state/peers.md`) — lists cnos, cph, bumpt with `role:` and `convention:` fields and the log-v0 paths.
2. `state/peers.md` — re-created as a schemaed placeholder; comment notes cn-rho as the prototypical peer-agent shape; no entries.
3. `threads/activations/{cnos,cph,bumpt}.md` (renamed from `threads/peers/`) — bare H1 logs.
4. `spec/OPERATOR.md` — § "Activation logs" (renamed from "Foreign activation peer logs") with the 8-step loop, single-writer caveat, and cph exception clause.

## What ships at cnos / bumpt on first activation

When Sigma activates at cnos or bumpt next, create:

```
.cn-sigma/log.md
```

with:

```
# Sigma activation log
```

Then begin appending H2 entries per the loop.

cph already has the predecessor branch-posts convention live since 2026-05-19; no new file needed there unless a future migration to log-v0 is chosen.

## How this came about

The path to this convention was a sequence of operator-corrected simplifications across one conversation:

1. Hand-test inbound at `cnos:.cn-sigma/cnos-peers-add-bumpt-2026-05-30.md` (a `cn.message.v1` envelope file at the activation namespace).
2. I over-engineered an ack file at `cn-sigma:.cnos/...` (inferred sender-side routing). Operator caught it: spec says one mail dir, envelope routes. Cleaned up.
3. Operator asked: where do messages live on the new protocol? I answered with `threads/mail/{inbox,outbox,sent}/` per cnos#150 MESSAGE-PACKET-TRANSPORT.
4. Operator: "Drop mail if not needed. What's the design?" I proposed files-in-`.cn-sigma/` per receiver.
5. Operator: "Is this the most git-natural way to do FidoNet?" I admitted: no, commits-as-packets is more native (cnos#150 is closer).
6. Operator: "What about thread-as-single-file, append-only?" I converged on per-direction log files.
7. Operator: "Isn't this the original git-cn whitepaper?" I read `cnos:docs/alpha/protocol/WHITEPAPER.md` v3.0.0 and confirmed: **yes, I had been re-deriving Protocol v1 from first principles.**
8. Operator: "We have Sigma and two repos it's activated at. Enable comms." I drafted the minimum.
9. Operator converged with two corrections: split `last_read` → `last_read_foreign_log`; drop frontmatter.
10. Initial ship called it "Sigma peer log convention." Operator caught the ontological error: cnos / cph / bumpt are **activations** (same Sigma, different bodies), not peers. cph in particular: I had wrongly annotated it "Different persona" in this conversation; reading `threads/adhoc/20260519-foreign-body-activation-gap.md` confirmed it's also Sigma. Operator added that peers like cn-rho (researcher; cdr) do conceptually exist — distinct profile from Sigma's engineer/cdd — so the distinction matters: peers go in `state/peers.md`, activations go in `state/activations.md`.
11. Renamed throughout: `state/peers.md` → `state/activations.md` (new `state/peers.md` is a placeholder); `threads/peers/` → `threads/activations/` (added cph); `OPERATOR.md` § Activation logs.

The recurrence (read canonical source before reasoning; name relationships before designing for them) was logged before; logging it again here. The pattern: I keep reasoning forward without grepping the corpus first, AND I keep using imprecise labels that paper over real ontological distinctions. The standing rule is still the right rule; the discipline of actually following it is what needs to keep tightening.

## Pause posture

This is a field convention to enable Sigma cross-activation continuity. It is not protocol evolution. The v3.82.0 pause holds. The CN protocol itself remains at v1 per the whitepaper; cnos#150 is the named evolution path; v0 is the bridge.

## Connection to standing work

- **cnos#431 (agent-gh-deployment master)** — When Sub D ships the `cn agent` runtime surface, Sigma's activations at cnos and bumpt will use it. The activation-log convention is the v0 substrate they write into.
- **cnos#432 (clean-slate hub MVP)** — bumpt is the first instance. v0 activation-log enables bumpt↔home memory return today; cnos#432's clean-slate design will eventually subsume or formalize this.
- **CELL-OF-CELLS §16.6 (project evidence stays in project repo; persona memory goes home)** — this is the implementation. Project evidence at bumpt stays there; Sigma's persona-memory return uses `bumpt:.cn-sigma/log.md` → home read.
- **20260519 foreign-body activation gap** — that adhoc proposed `.cn-sigma/` at foreign repos and the peer-branch posts/ convention for cph; v0 names what gets written there as a single log file and the loop that reads it. cph keeps the orphan-branch posts/ form as a valid alternative carrier.
- **cn-rho (peer, researcher persona)** — out of scope for v0. When/if registered in `state/peers.md`, a cross-persona comms convention (different problem) will be designed separately.

---

## Update 2026-06-01 — Convergence at cnos: per-day sharding both directions; generalized to "Agent activation log v0"

After Sigma-at-cnos activated on 2026-05-30 and worked the channel for two days, the convention converged at the cnos canonical spec — `cnos:docs/gamma/conventions/AGENT-ACTIVATION-LOG-v0.md` (latest commit `8a56be0`). The cn-sigma side now mirrors that canonical form.

### What converged

1. **Generalized name.** "Sigma activation log v0" → "Agent Activation Log Convention v0". Sigma is the first adopter, not the protocol name. `{agent}` template (sigma, rho, …) replaces persona-specific paths. This adhoc's filename keeps the original `sigma-activation-log-v0` slug — append-only discipline, the artifact name reflects the moment it was authored — but the convention it documents is now agent-level.

2. **Per-day sharding both directions.** Original v0 had single files per channel (`<repo>:.cn-sigma/log.md`, `cn-sigma:threads/activations/<name>.md`). Converged form is per-day under per-activation directories:
   - Foreign-to-home: `{activation-repo}:.cn-sigma/logs/YYYYMMDD.md`
   - Home-to-foreign: `cn-sigma:threads/activations/{activation}/YYYYMMDD.md`
   - Symmetric. The original framing ("home volume is too low to shard") is replaced: both sides shard because each activation is a long-lived narrative channel that's smaller, more mergeable, and more readable when split by day — not because of volume.
   - The cursor (a Git commit SHA) spans the directory naturally; no per-file cursor needed.

3. **Agent / activation / peer §0 distinction made explicit in the canonical spec.** Sigma's original adhoc framed this; the cnos spec lifted it into §0 as the conceptual ground for the whole convention.

### What changed at cn-sigma today (2026-06-01)

- `threads/activations/{cnos,bumpt,cph}.md` → `threads/activations/{cnos,bumpt,cph}/{README.md, 20260530.md}` per the new per-day structure. The 2026-05-30 directives I authored on the original single-file surfaces are preserved verbatim in each `20260530.md` shard.
- `state/activations.md`: `foreign_log: ".cn-sigma/log.md"` → `".cn-sigma/logs/"`; `home_log: "threads/activations/{name}.md"` → `"threads/activations/{name}/"`; `last_read_foreign_log: null` → `8a56be0` for cnos (the cursor I advanced this intake).
- `spec/OPERATOR.md § Activation logs`: rewritten to mirror the canonical cnos spec — per-day shards both directions, agent/activation/peer §0 frame, pointer to `AGENT-ACTIVATION-LOG-v0.md` as canonical.
- This update section appended.

### Companion essays (cnos side)

Three gamma-essays landed at cnos during the cnos-side iteration. They are essay-class — substrate the spec lives on top of, not normative extensions:

- `cnos:docs/gamma/essays/AGENT-ACTIVATION-LOGS-AND-EVENTUAL-CONSISTENCY.md` — descriptive lineage; Bayou as nearest prior art; four session guarantees mapped onto v0; scaling path (cursors → vector-clock state → CRDTs → signed feeds).
- `cnos:docs/gamma/essays/AGENT-COMMS-FUTURES-KISS.md` — prescriptive gates; what NOT to add until topology demands it; YAGNI tests per mechanism; migration ladder as pressure map.
- `cnos:docs/gamma/essays/AGENT-MEMORY-LOG-STRUCTURED.md` (v3, retitled "Agent Memory Is Coherence-Preserving Log Structure") — memory as coherence-preserving compaction over append-only evidence; rank ≠ frequency ontology; TSC as the measurement ground (α=pattern, β=relation, γ=process).

The triad sits beside the spec without expanding it. Memory cycle (cnos#100, deferred until MCI freeze lifts) was cross-referenced via comment on the issue.

### Held items (operator's call)

- Whether to fold a short "Origins and analogues" section into `AGENT-ACTIVATION-LOG-v0.md` pointing at the essays.
- Two prose-polish tightenings in memory essay v3 (bridge sentence; tighter compaction question).
- Whether the other two essays gain a "see also TSC measurement framing" reference.
- A small cnos-side stale reference: `cnos:.cn-sigma/logs/README.md` still cites `SIGMA-PEER-LOG-v0.md` (renamed to `AGENT-ACTIVATION-LOG-v0.md` in commit `d4d2dc7`). Cnos-Sigma noted but held the fix; flagged for its next activation.

### Pause posture

Convergence is field convention, not protocol evolution. The v3.82.0 protocol-evolution pause still holds. The CN protocol itself remains at v1 per the whitepaper; cnos#150 is the named evolution path; v0 (now agent-generalized) is the bridge.
