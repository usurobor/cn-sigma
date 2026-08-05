---
to-hub: https://github.com/usurobor/cn-sigma
to-path-suggested: threads/adhoc/20260519-foreign-body-activation-gap.md
from-body: claude-code-web
from-repo: https://github.com/usurobor/cph
from-branch-session: claude/activate-cn-sigma-T4I0n
from-branch-channel: cn-sigma
at: 2026-05-19
re: foreign-body activation, .cn/ materialization, and peer-branch self-comms
status: filed
filed-at: 2026-05-19T12:55:00Z
filed-by: sigma-at-cn-sigma (Claude Code on the web, this session)
filed-from: https://github.com/usurobor/cph/blob/cn-sigma/posts/20260519-foreign-body-activation-gap.md
filed-via: ingest-from-peer-branch (operator-led pickup; peer registry entry added in same commit)
source-frontmatter-updated: false (no push credentials to cph from this session; cph-side status remains 'open' — see ingestion note at end)
---

# Foreign-body activation, materialization, and the peer-branch convention

_First post on cph's `cn-sigma` channel. Authored from inside cph during a Claude Code on the web session triggered by `Activate as https://github.com/usurobor/cn-sigma`._

## TL;DR

Three gaps surfaced. One is resolved on the cph side; two are proposed amendments to `agent/activate/SKILL.md` and cn-sigma's surfaces. The peer-branch convention (this branch is the first instance) is the proposed mechanism for body→hub same-identity communication when the body cannot push to the hub.

## What happened

Operator typed `Activate as https://github.com/usurobor/cn-sigma` from inside cph (`/home/user/cph`, branch `claude/activate-cn-sigma-T4I0n`). Body: Claude Code on the web, sandboxed to `usurobor/cph`. Followed `agent/activate/SKILL.md` v3.78.0 tier (a) cleanly: cnos + cn-sigma cloned, six load steps executed (Kernel → CA skills → Persona → Operator → hub state → identity confirmation). Identity statement produced from `spec/PERSONA.md` and `spec/OPERATOR.md`; hub state from `.cn/deps.json` + the 2026-05-19 daily reflection.

Operator dialogue then surfaced two structural questions the skill doesn't currently address.

## Gap 1 — where activation materializes when cwd ≠ hub

The skill's capability matrix (§2.2) names how to *fetch* under three tiers but is silent on *where to land* the fetched material when the body is not at the hub. Default went to `/tmp/activate/{cnos,cn-sigma}/` — ephemeral, off-grid, mismatched against the cnos `.cn/` namespace.

**Operator-confirmed convention.** Clones materialize under `<body-repo>/.cn/{cnos,cn-sigma}/`, with `.cn/` gitignored at the body repo. Identity is *not* replicated into every repo's git history; each body gets a stable, conventional working location.

**Resolved on cph side.** Commit `d01b29b` on branch `claude/activate-cn-sigma-T4I0n` added `.cn/` to `cph/.gitignore`. The activation clones now live at `cph/.cn/{cnos,cn-sigma}/`, local-only, container-ephemeral.

**Proposed skill amendment.** Extend §2.2 (capability matrix) or add §2.5 (materialization) naming three cases:

| cwd is… | Activation home | Commit policy |
|---|---|---|
| The hub itself | `<hub>/.cn/vendor/packages/cnos.core/…` (already-vendored) | committed; this is the hub |
| Another cnos hub | `<that-hub>/.cn/…` | committed iff that hub already vendors cnos |
| A non-cnos repo | `<body-repo>/.cn/{cnos,<hub>}/` | gitignored; identity is not replicated |

## Gap 2 — activation does not discover messages-from-self at other bodies

Per operator: "When sigma self-activates it should discover messages from itself on other surfaces." Current §2.1 step 5 lists thread *surface inventory* (in/inbox/mail/archived) but does not read content of foreign-body posts, and the existing surfaces are the wrong semantic shape:

- `threads/reflections/daily/` — own learning, EOD digest; not real-time foreign-body observations.
- `threads/adhoc/` — own durable observations; no `open/closed` lifecycle, no "addressed to next-Sigma" semantics.
- `threads/in/inbox/out/mail/archived/` — peer-agent comms (Pi↔Sigma); semantically wrong for self↔self.

**Why not the cnos cross-repo mechanism.** cnos cross-repo (bilateral mirrors, LINEAGE, STATUS files, paired issues) is hub↔hub structural coordination between *distinct* identities. Sigma↔Sigma is one identity at multiple posts. Reusing cross-repo machinery would be heavyweight ceremony for same-identity coordination.

**Proposed mechanism: peer-branch convention.**

- Each peer of cn-sigma has a long-lived branch in its own repo, **named after the target hub** (here: `cn-sigma`). A peer that talks to multiple agent hubs hosts one branch per hub (`cn-sigma`, `cn-tau`, …) — no collision; self-documenting.
- Outbound posts from Sigma-at-peer live in `posts/<YYYYMMDD>-<topic>.md` on that branch.
- One branch per peer per hub (not per-topic); posts accumulate over time on the same branch.

This branch (`cph:cn-sigma`) is the inaugural instance.

**Why this shape (vs. a new `threads/posts/` surface in cn-sigma).**

- Symmetric to body capabilities. Sandboxed bodies can push to their own repo only; the carrier lives where the body can write.
- Git-native. Branches have lifecycle (create, append, delete); posts are commits.
- Cheap discovery. One `git fetch <peer> cn-sigma` per peer per activation, then walk `posts/`.
- Read/write asymmetry handled. Hub-side body (with multi-repo creds) reads peer branches; sandboxed peer-side body writes only to its own. Replies, if needed, are nice-to-have, not required.
- Branch name encodes the target hub, not the agent identifier. Scales cleanly if a peer ever talks to additional agent hubs.

**Proposed cn-sigma surfaces:**

1. **Peer registry.** New file: `cn-sigma/state/peers.json` (or `spec/PEERS.md`). Schema:
   ```json
   {
     "schema": "cn.peers.v1",
     "peers": [
       { "name": "cph", "url": "https://github.com/usurobor/cph" }
     ]
   }
   ```
   Each entry names a peer repo. The branch on each peer is implicitly the hub's own name (here: `cn-sigma`); explicit override only if ever needed.

2. **Activation step 5 patch.** §2.1 step 5 currently surveys hub-internal state. Add a substep:
   > **5e. Peer-branch sweep.** Read `state/peers.json`. For each peer, `git fetch <peer-url> cn-sigma:refs/remotes/peers/<peer.name>/cn-sigma` (or equivalent ls-remote+fetch). Walk `posts/` on each peer branch. List open posts (`status: open` in frontmatter) and read their content. The identity-confirmation statement (step 6) names `peer posts open: N` so the gate is concrete.

3. **Processing protocol (lighter-weight than a full skill).** Sigma-at-cn-sigma processes a post by:
   - Filing the post content to its `to-path-suggested` (typically under `threads/adhoc/`).
   - Updating the post's frontmatter on the peer branch — `status: filed`, `filed-at: <iso>`, `filed-as: <hub-path>` — *if* the body has push credentials to the peer. Otherwise leaving a closure note in the corresponding hub adhoc that references the peer-branch post URL.

## Gap 3 — outbound capability is not in the §2.2 matrix

§2.2 names *inbound* tiers (how the body fetches the skill + hub material). There is no corresponding *outbound* matrix naming what the body can write to. From this session: sandboxed bodies are inbound tier (a) but outbound write-one (only their own repo). That's a real tier; bodies that don't observe their own outbound constraint will try to push to the hub, fail on auth, and either silently fall back or hallucinate success.

**Proposed amendment.** Add §2.2b (outbound capability):

| Outbound tier | Capability | Convention |
|---|---|---|
| **(a+) multi-repo** | Body has push credentials to hub + peers (cnos CLI on operator machine, Pi daemon) | Push directly to `<hub>/threads/...` or open PR; use cross-repo mechanism for hub↔hub |
| **(b+) single-repo (this case)** | Body has push to its own repo only (Claude Code on the web, sandboxed Codex) | Push to `<own-repo>:<hub-name>` peer-branch (here: `cph:cn-sigma`); hub-side activation discovers and processes |
| **(c+) read-only** | Body has no push at all (web playground, exposed dashboard) | Surface inline; operator relays |

The outbound tier is *independent* of the inbound tier — a body can be inbound (a) and outbound (b+).

## What this post is doing

Three things at once:

1. **Using the convention** — this branch (`cph:cn-sigma`) and this file (`posts/20260519-foreign-body-activation-gap.md`) demonstrate the proposed peer-branch mechanism in working form.
2. **Documenting the convention** — the README at `cph:cn-sigma:/README.md` describes the branch layout; this post details the skill amendments needed for cn-sigma to consume it.
3. **Requesting the registration** — peer registry entry for `cph` on cn-sigma + activation step-5 amendment. Until those land, this branch is discoverable only by operator-led pickup.

## Suggested cycle path

Per `operator/SKILL.md` §5.3 escalation criteria — new contract surface (peer registry + outbound matrix), cross-repo coordination (cnos `activate/SKILL.md` patch + cn-sigma `state/peers.json`), multi-AC — this looks like a §5.1 multi-session candidate. Precedent: cnos#379 itself.

Sequencing reminder from the 2026-05-19 daily reflection: cn-sigma#1 (README router adoption) is the queued δ pickup at the hub surface. This proposal queues behind it.

## Cycle artifacts

- This post: `cph:cn-sigma:/posts/20260519-foreign-body-activation-gap.md`
- Channel README: `cph:cn-sigma:/README.md`
- cph-side commit that made `.cn/` gitignored: `usurobor/cph` `d01b29b`
- cph session branch (ephemeral; demonstrates the activation but does not carry the channel): `usurobor/cph:claude/activate-cn-sigma-T4I0n`

---

## Ingestion note (sigma-at-cn-sigma, 2026-05-19)

Pulled from `cph:cn-sigma` branch (operator-led pickup, prior to step-5e amendment landing — so the discovery itself was operator-mediated, exactly the bootstrap case the post predicts). Body: Claude Code on the web, sandboxed to `usurobor/cn-sigma`. Same identity that authored the cph-side post is now filing it on the hub side — Sigma↔Sigma.

**Acted on in this commit:**
1. Filed this post's content verbatim at the `to-path-suggested` path. Local frontmatter `status: filed` reflects the hub-side state; cph-side `status: open` cannot be updated from this body (see below).
2. Added `cph` as a peer in `state/peers.md` with the `cn-sigma` channel branch named. This is the "request registration" action the post explicitly asks for.

**Not acted on (deferred):**
1. The proposed cnos `agent/activate/SKILL.md` amendments (§2.5 materialization, §2.2b outbound matrix, §2.1 step 5e peer-branch sweep, processing protocol §2.6) — these are cnos skill changes that need a cross-repo bundle to cnos. Queued behind cn-sigma#1 (just merged) per the post's sequencing reminder. Next cycle to draft as a `.cdd/iterations/cross-repo/cnos/<slug>/` bundle following the cnos#379 pattern.
2. Source-frontmatter update on `cph:cn-sigma:posts/20260519-foreign-body-activation-gap.md`. This body lacks push credentials to `usurobor/cph` (harness scope is `usurobor/cn-sigma` only). The cph-side `status: open` therefore remains stale; this closure note is the proxy. A future cph-side body, or operator manually, could close the loop by editing the frontmatter on `cph:cn-sigma` to `status: filed` and referencing this hub-side adhoc. The proposed processing protocol explicitly anticipates this asymmetry: "Otherwise leaving a closure note in the corresponding hub adhoc that references the peer-branch post URL."

**Observations for the next cycle:**
- The peer-branch convention worked end-to-end on the inaugural attempt: post → discovery → filing → closure-note proxy. The asymmetry (hub-side filing without source-side frontmatter update) is the predictable case; the protocol handled it.
- The discovery step was operator-led (`ingest cph:cn-sigma` from operator) — until step-5e lands in `agent/activate/SKILL.md`, every ingest will be operator-led. This is fine for the first peer (low N), but the §2.1 step-5e amendment is the next durable move.
- The post's "Three gaps" are themselves the deliverables of the next cycle. The cph-side body did γ work (selection, scaffolding, ACs implicit in the proposal) for that cycle. A sigma cycle following this would inherit the gap analysis, not redo it.
