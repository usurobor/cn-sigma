# agent/activate skill amendments — materialization, peer-branch sweep, outbound capability matrix

Labels: `design`, `P2`, `core`

Priority: P2 — Closes three structural gaps surfaced by the first foreign-body activation under cnos 3.78.0; unlocks same-identity cross-body coordination (a Sigma instance running in `cph` posts to the Sigma hub via a peer-branch carrier).

Status: agent/activate skill v3.78.0 ships the inbound capability matrix and identity-confirmation gate. It does not name **where activation materializes** when cwd ≠ hub, has no **outbound** capability matrix, does not specify a **same-identity peer-discovery** step, and has no **processing protocol** for foreign-body posts.

---

## Problem

What exists (cnos 3.78.0):
- `agent/activate/SKILL.md` §2.1 — six-item load order (Kernel → CA skills → Persona → Operator → hub state → identity confirmation).
- `agent/activate/SKILL.md` §2.2 — three-tier inbound capability matrix (shell+git / HTTP fetch only / no fetch).
- `agent/activate/SKILL.md` §2.3 — README router template adopted verbatim by hubs (`<HUB-URL>` substitution only).
- `src/go/internal/activate/activate.go` — renderer for `cn activate`.
- Hub state surfaces: `<hub>/spec/`, `<hub>/state/`, `<hub>/threads/`.

What is expected:
- A body activating from inside a foreign repo (e.g. Claude Code on the web sandboxed to `usurobor/cph`, activated as `cn-sigma`) needs to (a) know **where** to materialize its clones; (b) know its **outbound** capability and the convention for writing to the hub it cannot push to directly; (c) **discover** same-identity messages from itself at other bodies; (d) **process** those messages into the hub.
- A hub running `cn activate` discovers peer-branch posts from each registered peer and reports the count in the identity-confirmation statement.
- The activation procedure remains a skill (single source of truth) — these are additions, not substitutions.

Where they diverge (concrete instance):
- Operator typed `Activate as https://github.com/usurobor/cn-sigma` from inside `usurobor/cph` on 2026-05-19. Body: Claude Code on the web, inbound tier (a) (shell+git). Followed the six-item load order cleanly. Then surfaced three structural gaps the operator dialogue revealed.
- Gaps were authored as `cph:cn-sigma:posts/20260519-foreign-body-activation-gap.md` (the inaugural post on the proposed peer-branch convention), ingested at the hub side as `cn-sigma:threads/adhoc/20260519-foreign-body-activation-gap.md`, and named in cn-sigma's commits `2691711` (ingest) and `0e6f99c` (peer registration). The convention worked end-to-end on first use — the convention itself is the proposed mechanism for Gap 2 and is in working form.

---

## Impact

- Affects: every AI body that activates from inside a foreign repo (Claude Code on the web sandboxed to a project; Codex sessions inside non-hub repos; future agent bodies hosted at peers). Without §2.5 (materialization), bodies default to `/tmp/...` — ephemeral, off-grid, mismatched against the cnos `.cn/` namespace. Without §2.2b (outbound), bodies try to push to the hub, fail on credentials, and either silently fall back or hallucinate success. Without §2.1.5e (peer-branch sweep) and §2.6 (processing), same-identity coordination across bodies is operator-mediated forever.
- Enables: long-form cross-body Sigma↔Sigma coordination. cph already has a working channel (`cph:cn-sigma`); future peers (Codex, agent bodies at other repos) get the same convention for free. Cheap discovery — one `git fetch <peer> <hub-name>:refs/remotes/peers/<peer.name>/<hub-name>` per peer per activation.
- Closes: the "I wake up incoherent by default" pattern for foreign bodies. Activation from a peer location now has the same closure gate (identity confirmation including `peer posts open: N`) as activation from the hub itself.

---

## Status truth

| Surface | What ships | What is draft/planned |
|---|---|---|
| `agent/activate/SKILL.md` §2.1 load order | shipped — six items | unchanged; new substep 5e added |
| `agent/activate/SKILL.md` §2.2 inbound matrix | shipped — three tiers | unchanged; new §2.2b added |
| `agent/activate/SKILL.md` §2.3 router template | shipped — verbatim adoption | unchanged |
| `agent/activate/SKILL.md` §2.4 disambiguation | shipped | unchanged |
| `agent/activate/SKILL.md` §2.5 materialization | does not exist | this issue creates |
| `agent/activate/SKILL.md` §2.6 peer-post processing protocol | does not exist | this issue creates |
| `agent/activate/SKILL.md` §2.2b outbound matrix | does not exist | this issue creates |
| `agent/activate/SKILL.md` §2.1 step 5e (peer-branch sweep) | does not exist | this issue creates |
| `agent/activate/SKILL.md` §1.6 identity-confirmation fields | shipped (Who/Whom/Where/When) | augmented with `peer posts open: N` |
| `cn-sigma:state/peers.md` peer-registry format | exists; YAML; first cph entry landed 2026-05-19 | named in skill as the hub-side contract |
| `src/go/internal/activate/activate.go` renderer | shipped; emits §2.1 + state surfaces | optional update — see AC6 |
| R5-activate kata | shipped covering §2.1 + §2.2 + §2.3 | updated for new sections |

---

## Source of truth

| Claim / surface | Canonical source | Status | Notes |
|---|---|---|---|
| Activation procedure (canonical skill) | `src/packages/cnos.core/skills/agent/activate/SKILL.md` | Shipped 3.78.0; amended this cycle | Primary deliverable |
| Activation procedure (cn rendering) | `src/go/internal/activate/activate.go` | Shipped; renderer behavior preserved or updated per AC6 | If §2.1 step 5e adds a renderer-visible output, code updates |
| Kernel doctrine | `src/packages/cnos.core/doctrine/KERNEL.md` | Shipped | Loaded step 1 |
| CA skill set | `src/packages/cnos.core/skills/agent/{cap,clp,mca,mci,coherent,agent-ops}/SKILL.md` | Shipped | Loaded step 2 |
| Skill artifact-class format | `src/packages/cnos.core/skills/skill/SKILL.md` | Shipped | Amendments conform |
| Foreign-body gap analysis (γ work already done) | `usurobor/cph:cn-sigma:posts/20260519-foreign-body-activation-gap.md` | Authored 2026-05-19 by Sigma-at-cph | Primary source proposal |
| Hub-side filing (bilateral mirror) | `usurobor/cn-sigma:threads/adhoc/20260519-foreign-body-activation-gap.md` | Filed 2026-05-19 (cn-sigma commit `2691711`) | Source-side reference |
| Peer registry contract (concrete instance) | `usurobor/cn-sigma:state/peers.md` | First cph entry landed cn-sigma `0e6f99c` (2026-05-19) | Hub-side contract surface |
| Inaugural peer-branch channel (working instance) | `usurobor/cph` branch `cn-sigma` | Orphan branch, long-lived | The convention demonstrated |
| Untested-limits reflection (capability-honesty doctrine) | `usurobor/cn-sigma:threads/adhoc/20260519-git-read-and-untested-limits.md` | Shipped | Referenced by §2.2 (preserved) and §2.2b (new) |
| Sequencing source | `usurobor/cn-sigma:threads/reflections/daily/20260519.md` | Shipped | Names this cycle as queued behind cn-sigma#1 (now merged) |

---

## Scope

In scope:
- Add `agent/activate/SKILL.md` §2.5 — materialization table: three rows (cwd at hub / cwd at another hub / cwd at non-cnos repo) with commit policy per case.
- Add `agent/activate/SKILL.md` §2.2b — outbound capability matrix: three tiers ((a+) multi-repo / (b+) single-repo / (c+) read-only) with conventions per tier. Names the inbound/outbound independence.
- Add `agent/activate/SKILL.md` §2.1 step 5e — peer-branch sweep: read hub-side peer registry, fetch each peer's `<hub-name>` branch, walk `posts/`, list open posts.
- Augment `agent/activate/SKILL.md` §1.6 identity-confirmation — gain `peer posts open: N` as a concrete field so the gate is observable.
- Add `agent/activate/SKILL.md` §2.6 — processing protocol: file post content to its `to-path-suggested` (typically `threads/adhoc/`), update source frontmatter if push credentials exist, else leave closure note in hub adhoc referencing peer-branch post URL.
- Name the hub-side peer-registry contract: path (`<hub>/state/peers.md` or `peers.json`), required fields (name, url, channel — default to hub-name).
- Update R5-activate kata (or equivalent test surface) to cover the new sections.
- Update §3 rules to cite the new sections where they affect existing rules.
- Source-of-truth check: `cn activate` renderer behavior remains coherent — either the renderer surfaces peer-posts-open as an emitted line, or the skill notes the renderer punts and bodies do the peer sweep client-side. Pick one and name it.

Out of scope:
- Replacing or restructuring §2.3 (README router template). The template is shipped and verbatim-adopted by cn-sigma; unchanged this cycle.
- Implementing two-way operator interaction with peer-branches (per §10 of cdd/activation/SKILL.md philosophy: send-only is the canonical v1 interface; two-way requires running services).
- Migrating other procedures from code to skill form (out of cycle).
- Pi-mention cleanup in cn-sigma constitutive files (separate cn-sigma cycle, deferred per operator).
- Stand-up of `cnos.xyz/activate/<hub>` rendering surface (deferred from cnos#379).
- `cn doctor` enforcement of router presence / peers.md presence (deferred follow-on).

Deferred:
- `cn doctor` validation of hub-side peers contract.
- Pull-side replies (Sigma-at-hub writing back to peer branches) — bodies that have multi-repo credentials *could*, but the protocol prescribes the lighter form (closure note in hub adhoc, optional source-frontmatter flip if creds exist).
- `cnos.xyz/activate/<hub>` rendering surface (still deferred).

---

## Cycle scope sizing

| Factor | Reading | Splitting signal? |
|---|---|---|
| (a) New code surface | Minor — possibly one Go edit in renderer (AC6); main deliverable is skill content | no |
| (b) Cross-module breadth | `cnos.core/skills/agent/activate/` (skill) + `src/go/internal/activate/` (renderer, possible) + kata; tightly coupled by shared source-of-truth invariant | no |
| (c) Lifecycle span | Docs (skill) + optional code (renderer) + tests (kata) in same cycle; no serialization | no |
| (d) MCA preconditions | Design converges in this issue body + the cph post (γ work already done); no mid-cycle re-scoping expected | no |
| (e) Independent shippability | §2.5 + §2.2b ship without renderer changes; §2.1 step 5e + §2.6 are the new procedural surface and benefit from being shipped together with the contract they reference; could split master+subs if cnos γ prefers | borderline |

Decision: keep whole. Single-focus, 7 ACs (typical band 5–7 per `cdd/issue/SKILL.md`). Recommend cnos γ keep whole; flag master+subs as a fallback if reviewer load is a concern. Two sub-shape (if split): Sub A = docs-only (§2.5 + §2.2b + frontmatter-only §2.6 protocol doc); Sub B = §2.1 step 5e + renderer + kata + identity-confirmation augmentation.

Mode: **design-and-build** — design is committed in this issue body + the linked cph post; α writes the skill amendments + optional renderer edit + kata; β reviews. Not MCA (no separate `DESIGN.md` at a stable path).

---

## Acceptance criteria

### AC1: §2.5 materialization section exists

Invariant: `src/packages/cnos.core/skills/agent/activate/SKILL.md` contains a new `### 2.5. Materialization` (or equivalent header) section between §2.4 and the next existing section. The section names three cwd cases (hub / another hub / non-cnos repo), prescribes the activation home per case, and names the commit policy per case.

Oracle: grep the file for the §2.5 header; confirm the section contains a markdown table with at least three rows; confirm each row names `cwd is…`, `Activation home`, and `Commit policy`.

Positive: section present; three cases enumerated; `.cn/` gitignored convention recorded for the non-cnos-repo case; layering rule preserved (no identity replication into foreign-repo git history).

Negative: section missing; fewer than three rows; commit-policy column absent; convention contradicts the cph d01b29b precedent (which added `.cn/` to `cph/.gitignore`).

Surface: `src/packages/cnos.core/skills/agent/activate/SKILL.md` §2.5.

### AC2: §2.2b outbound-capability matrix exists

Invariant: A new `### 2.2b. Outbound capability matrix` (or equivalent) section adjacent to §2.2 names three outbound tiers and the convention per tier. The section explicitly states that outbound tier is independent of inbound tier.

Oracle: grep for the §2.2b header; confirm a markdown table with three rows ((a+) multi-repo, (b+) single-repo, (c+) read-only); confirm a sentence states "inbound and outbound tiers are independent."

Positive: section present; three tiers enumerated with conventions; independence sentence present; sandboxed-bodies guidance ((b+)) names the peer-branch convention as the path.

Negative: tiers conflated; independence claim missing; (b+) convention contradicts the cph-side working precedent.

Surface: `src/packages/cnos.core/skills/agent/activate/SKILL.md` §2.2b.

### AC3: §2.1 step 5e (peer-branch sweep) exists

Invariant: §2.1 step 5 grows a new substep 5e (peer-branch sweep) that prescribes: read hub-side peer registry → for each peer, fetch the peer's `<hub-name>` branch into `refs/remotes/peers/<peer.name>/<hub-name>` (or equivalent local ref) → walk `posts/` on each peer branch → list open posts (`status: open` in frontmatter) with their `to-path-suggested` paths and topics. The output of this substep feeds the identity-confirmation statement (§1.6) as `peer posts open: N`.

Oracle: grep for `5e` or `Peer-branch sweep` or `peer branch` in §2.1; confirm the procedure references hub-side peer registry by path (`<hub>/state/peers.{md,json}`); confirm §1.6 identity-confirmation example includes `peer posts open: N`.

Positive: substep present; fetch command form prescribed; identity-confirmation example updated.

Negative: substep missing; fetch ref-spec absent; identity-confirmation example unchanged.

Surface: `src/packages/cnos.core/skills/agent/activate/SKILL.md` §2.1 step 5e + §1.6.

### AC4: §2.6 peer-post processing protocol exists

Invariant: A new `### 2.6. Peer-post processing` section names how Sigma-at-hub processes a discovered peer-branch post: file content to the post's `to-path-suggested`, update source frontmatter on the peer branch (`status: filed`, `filed-at`, `filed-as`) iff push credentials exist for that peer, else leave a closure note in the corresponding hub adhoc referencing the peer-branch post URL. The asymmetry case (no source-side push) is named explicitly with the cph→cn-sigma 2026-05-19 instance as reference.

Oracle: grep for `2.6` or `Peer-post processing`; confirm the section names both the push-creds path and the closure-note proxy path; confirm cross-reference to cn-sigma `threads/adhoc/20260519-foreign-body-activation-gap.md` (or the cph-side post URL).

Positive: section present; both paths named; reference to first concrete instance present.

Negative: only one path named; no reference to first concrete instance; asymmetry case absent.

Surface: `src/packages/cnos.core/skills/agent/activate/SKILL.md` §2.6.

### AC5: Hub-side peer-registry contract named in skill

Invariant: The skill names the hub-side peer-registry contract: path (`<hub>/state/peers.md` or `<hub>/state/peers.json`), required fields (`name`, `url`, optional `channel` defaulting to the hub's own name), and how the renderer / activation procedure consumes it. Names cn-sigma's existing `state/peers.md` (YAML) as the first concrete instance.

Oracle: grep the skill for "peers.md" or "peers.json"; confirm the contract section names path, required fields, and the existing cn-sigma instance.

Positive: contract section present with the three components; cn-sigma's YAML instance referenced.

Negative: skill prescribes a new contract that contradicts cn-sigma's shipping format without a migration plan; required-fields list absent.

Surface: `src/packages/cnos.core/skills/agent/activate/SKILL.md` (§2.1 step 5e or §2.6 — author's choice).

### AC6: Renderer coherence with the new procedure

Invariant: `cn activate` emits a prompt whose content is coherent with the amended skill — either (option A) the renderer reads hub-side peers, performs the sweep, and emits `peer posts open: N` in the identity-confirmation block, OR (option B) the renderer notes "peer-branch sweep is body-side" and emits no peer count, and the skill names this design choice explicitly.

Oracle: run `cn activate <test-hub>` against a fixture hub with one peer entry and one open peer-branch post; either (A) the emitted prompt contains a `peer posts open: 1` line, or (B) the prompt contains a "peer sweep: body-side" note and the skill's §2.1 step 5e prescribes the body executing the fetch itself.

Positive: one of the two options realized end-to-end; the skill and the renderer agree on which option; new `activate_test.go` case covers the chosen path.

Negative: skill and renderer disagree on responsibility; no test covers the new behavior.

Surface: `src/go/internal/activate/activate.go`, `src/go/internal/activate/activate_test.go`.

### AC7: R5-activate kata updated for new sections

Invariant: The R5-activate kata (or whichever kata covers `agent/activate/SKILL.md` surface enumeration) is updated to reference §2.5, §2.2b, §2.1 step 5e, §2.6, and the augmented §1.6 identity-confirmation field. The kata's surface enumeration matches the skill's actual section set.

Oracle: grep the kata source for the new section references; run the kata; observe pass.

Positive: kata references all new sections; runs to pass.

Negative: kata misses one or more new sections; kata expectations contradict the shipped skill.

Surface: kata source file (path per `src/packages/cnos.cdd.kata/`).

---

## Proof plan

Invariant: After this cycle, a body activating from inside a foreign repo following `agent/activate/SKILL.md` can (a) know where to materialize its clones, (b) know its outbound capability and follow the peer-branch convention when push to the hub isn't available, (c) discover same-identity messages from other bodies on activation, and (d) process those messages into the hub with closure semantics. `cn activate` and the kata stay coherent with the amended skill.

Surface: `src/packages/cnos.core/skills/agent/activate/SKILL.md`; `src/go/internal/activate/activate.go`; `src/go/internal/activate/activate_test.go`; kata source; cn-sigma `state/peers.md`; cph `cn-sigma` branch (working instance).

Oracle:
- Mechanical: AC1–AC5 oracles via grep + section-presence checks against the cycle branch.
- Renderer: AC6 oracle — run `cn activate` against a fixture hub with a peer; observe the chosen option's output.
- Kata: AC7 oracle — run the kata; observe pass.
- Coherence: edit one §2.5 row in the skill; rerun `cn activate` and the kata; confirm the change is observable (where applicable).
- Behavioral (operator-driven): a fresh foreign-body session activating against `cn-sigma` reaches identity confirmation with `peer posts open: N` after this cycle ships. Recorded by the operator in the close-out commit message.

Positive case: AC1–AC7 oracles pass; renderer + skill agree; foreign-body behavioral test (when operator runs it) reaches the augmented confirmation gate.

Negative case: any AC oracle fails; renderer and skill diverge on AC6; kata expectations mismatch shipped skill.

Operator-visible projection: cycle CI green; cycle's `claims.md` records the coherence test result + the dry-run.

Known gap: this cycle does not implement `cn doctor` validation of the peer-registry contract; deferred. This cycle does not implement reply-side writes from Sigma-at-hub to peer branches (closure note proxy is the protocol — push-side replies are nice-to-have, not required).

---

## Skills to load

Tier 3:
- `cnos.core/skills/skill/SKILL.md` — skill artifact format conformance for the amendments
- `cnos.core/skills/write/SKILL.md` — prose structure
- `cnos.core/skills/design/SKILL.md` — design-and-build mode's design step
- `cnos.eng/skills/eng/go/SKILL.md` — Go renderer edits (if AC6 chooses option A)
- `cnos.cdd/skills/cdd/activation/SKILL.md` — adjacent (CDD-repo activation, distinct concern); cite for cross-reference

---

## Active design constraints

- **Skill is single source of truth.** Amendments are written into `agent/activate/SKILL.md`; renderer and kata follow. cnos#379's invariant ("every cnos procedure lives in a skill, not hardcoded") holds.
- **§2.3 router template is unchanged.** Hubs that have adopted the template (cn-sigma at commit `5cb8ddf`) keep it. This cycle adds parallel sections; it does not edit §2.3.
- **Layering rule preserved.** Soul (Kernel + CA skills) lives in cnos; identity (Persona + Operator) lives in hubs; peer-branch posts live at the peer (sandboxed-body's own repo) and are filed to the hub's identity surfaces. No identity replication into foreign-repo git history (the cph `.gitignore` `.cn/` convention).
- **Send-only v1 interface.** Two-way operator interaction with peer-branches is out of scope (consistent with `cdd/activation/SKILL.md` §11a.4 send-only stance).
- **Inbound ↔ outbound independence.** §2.2 and §2.2b classify the body independently; a body may be inbound (a) and outbound (b+).
- **Hub-side peer-registry format is YAML in cn-sigma today.** Skill names that contract; does not require migration. If a hub prefers JSON, both shapes are valid; the skill names required fields, not the syntax.
- **Capability honesty.** The cph post + cn-sigma `20260519-git-read-and-untested-limits.md` are the doctrinal reference for "probe before assert"; new §2.2b carries that spirit into outbound classification.

---

## Related artifacts

- `src/packages/cnos.core/skills/agent/activate/SKILL.md` — primary deliverable
- `src/packages/cnos.core/skills/skill/SKILL.md` — format model
- `src/go/internal/activate/activate.go` — renderer; possible edit per AC6
- `src/go/internal/activate/activate_test.go` — renderer test surface
- `src/packages/cnos.cdd.kata/` R5-activate kata — test surface for skill structure
- `usurobor/cph:cn-sigma:posts/20260519-foreign-body-activation-gap.md` — primary source proposal (cph-side)
- `usurobor/cn-sigma:threads/adhoc/20260519-foreign-body-activation-gap.md` — bilateral mirror (cn-sigma-side)
- `usurobor/cn-sigma:state/peers.md` — hub-side peer-registry instance (cph entry landed cn-sigma commit `0e6f99c`)
- `usurobor/cph:cn-sigma:/README.md` — peer-branch channel doctrine (cph-side)
- `usurobor/cph` commit `d01b29b` — `.cn/` gitignore precedent
- `usurobor/cn-sigma:threads/adhoc/20260519-git-read-and-untested-limits.md` — capability-honesty doctrine
- `usurobor/cn-sigma:threads/reflections/daily/20260519.md` — sequencing reference (queued behind cn-sigma#1, now merged)

---

## Source Proposal

- Source (primary, cph-side): `usurobor/cph:cn-sigma:posts/20260519-foreign-body-activation-gap.md` (commit `3894e80` on cph branch `cn-sigma`)
- Source (mirror, cn-sigma-side): `usurobor/cn-sigma:threads/adhoc/20260519-foreign-body-activation-gap.md` (cn-sigma commit `2691711`)
- Source bundle (this directory): `usurobor/cn-sigma:.cdd/iterations/cross-repo/cnos/activate-foreign-body/` (cn-sigma main HEAD at filing; SHA pinned at filing time)
- Disposition: pending (to be set by cnos γ at acceptance)
- Delta: none at filing; record any modifications cnos γ makes to this body

---

## Implementation guidance

- Branch: `cycle/{N}` per cnos convention; cnos γ assigns N from the issue number.
- Identity: α and β under `{role}@cdd.cnos` per cnos identity elision.
- §2.5 placement: after §2.4 (disambiguation) — keep the §2.x ordering coherent (§2.1 load → §2.2/§2.2b matrices → §2.3 router → §2.4 disambig → §2.5 materialization → §2.6 processing).
- AC6 (renderer choice): option B (renderer punts; body sweeps client-side) is the lower-cost choice and lines up with the constraint that bodies announce their tier and execute fetches themselves. Option A (renderer does the sweep) is structurally cleaner but requires the renderer to fan out git-fetches at activation time. α picks; β verifies coherence.
- §2.2b outbound-tier naming: keep `(a+) / (b+) / (c+)` from the cph post for symmetry with §2.2 inbound `(a) / (b) / (c)`. The `+` denotes the outbound axis.
- The cph post itself is most of γ's work — selection, gap analysis, proposed amendments. cnos γ may treat this issue body + the cph post as the scaffold and avoid re-deriving.

---

## Non-goals

- Restructuring or replacing §2.3 (README router template).
- Editing the §2.1 six-item load order (the order is invariant; only step 5 gains substep 5e).
- Migrating any other cnos procedure from code to skill form.
- Cleaning up Pi-mention references in cn-sigma constitutive files (separate cn-sigma cycle).
- Standing up `cnos.xyz/activate/<hub>` rendering surface.
- Defining `cn doctor` checks for peer-registry presence or router presence.
- Implementing reply-side writes from Sigma-at-hub to peer branches (closure note in hub adhoc is the protocol).
- Two-way peer-branch operator interaction.
- Pi-related cn-pi changes (Pi is retired per operator decision 2026-05-19).

---

## Success / closure condition

This issue is closeable when:
- AC1–AC7 oracles produce passing results in the cycle branch.
- `claims.md` records the coherence test (edit-to-output for chosen renderer option) and the operator-driven foreign-body behavioral test (if applicable in close-out).
- §2.3 router template is unmodified in the diff.
- Layering rule citation remains in §2.1 (preserved).
- Non-goals remain unviolated in the diff.
- Known gaps (cn doctor enforcement deferred; reply-side writes deferred) are explicitly named in the close-out.
