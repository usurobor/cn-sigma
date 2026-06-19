# Committer-Identity Convention — Canonical Form

**Date:** 2026-06-18
**Author:** γ-console (operator-clarified; reviewer-converged)
**Status:** Reviewer green-lit with one amendment (role-pure body label); refinements integrated. CDD spec issue ready to lift via D26/AI2.

## Convention (reviewer-converged)

CDD encodes actor identity into git committer email. The canonical form:

| Variant | Form | Example |
|---|---|---|
| Role-pure CDD at substrate/core | `<role>@<substrate>` | `alpha@cnos`, `gamma@cnos`, `delta@cnos` |
| Role-pure CDD at body/project | `<role>@<body>.<substrate>` | `alpha@bb-shop.cnos`, `gamma@bb-shop.cnos` |
| Multi-agent, home activation | `<agent>@<home-body>.<substrate>` (collapsed) | `sigma@cn-sigma.cnos`, `rho@cn-rho.cnos` |
| Multi-agent, foreign activation | `<agent>@<activation-body>.<home-body>.<substrate>` | `sigma@cnos.cn-sigma.cnos`, `sigma@bumpt.cn-sigma.cnos` |

Read DNS-style (rightmost = root): substrate is root, home-body or body-of-action is body-domain, activation-body is sub-body-domain (when foreign), agent or role is leaf.

**Grammar:**
- Local part: actor identity — CDD role for role-pure commits; agent name for multi-agent commits.
- Domain labels, right to left: substrate; body of action OR home body (for agent identities); activation body when activation ≠ home.

## Activation-site rule + home-collapse rule

In the multi-agent variant, the email encodes BOTH the agent's home body AND (when foreign) the activation site:

- **Home activation** — when Sigma activates at cn-sigma (its own home body), the activation site equals the home body. Collapse the duplicate: `sigma@cn-sigma.cnos`.
- **Foreign activation** — when Sigma activates at any other body (cnos, bumpt, etc.), the activation site is encoded as the leftmost subdomain: `sigma@<activation>.cn-sigma.cnos`.

| Activation | Email |
|---|---|
| Sigma γ-console at cn-sigma (home) | `sigma@cn-sigma.cnos` |
| Sigma α at cnos (foreign) | `sigma@cnos.cn-sigma.cnos` |
| Sigma α at bumpt (foreign) | `sigma@bumpt.cn-sigma.cnos` |

**Why this matters:** Without activation-site-in-email, all three hubs' wake-fired commits look identical (`sigma@cn-sigma.cnos`) in `git log`; the only disambiguator would be repo context. With activation-site-in-email, any aggregated commit view, cross-repo PR, or operator-side log across mirrored data correctly distinguishes γ-console / α-at-cnos / α-at-bumpt from the email alone. Self-extending: future Sigma activations at any new body get mechanically-generated emails of the form `sigma@<new>.cn-sigma.cnos`.

**Why the asymmetry (3-token home vs 4-token foreign) is a feature, not a flaw:** the home-vs-foreign distinction is itself meaningful (home = γ-console authority; foreign = wake-fired α work). The collapsed-vs-full form *signals* the distinction structurally. The home email isn't a degenerate special case; it's the canonical form for "this commit landed at the agent's home body." The reviewer specifically rejected the always-4-token symmetry (`sigma@cn-sigma.cn-sigma.cnos` at home) as "mechanically symmetric but semantically noisy — the duplicate label adds no information."

**The home-body subdomain is constant.** Identity belongs to the agent. cn-sigma stays in the email regardless of activation site, because the agent doesn't change when activated at a foreign body — only the activation site shifts.

## Role goes in trailer/receipt, NOT email (reviewer-emphasized)

Multi-agent committer email carries the **agent identity**, not the CDD role. The role Sigma is performing in a given cycle (γ-console = γ role, wake-fired = α role) is transient function; the agent is stable actor. Email captures stable actor-at-body attribution.

The role goes elsewhere when it needs to be visible:

- **Commit trailer:** `CDD-Role: gamma`
- **Receipt / status entry:** `actor: sigma@cnos.cn-sigma.cnos` + `role: alpha`
- **Commit message prefix when useful:** `gamma: close cnos#123`

**Rejected:** `sigma-as-gamma@cn-sigma.cnos` as canonical email. Reviewer's framing: "readable once and annoying forever; mixes stable identity with transient function."

**Rule:**
- email = stable actor-at-body attribution
- receipt/trailer = role performed in this cycle

## Author vs committer (reviewer-clarified)

Git has separate `author` and `committer` metadata. The convention controls both, with one exception:

- **For agent-created commits:** author = committer = canonical actor identity.
- **For patch application or human-authored content:** author may preserve original human/agent author; committer records the actor that applied the commit.

That prevents later ambiguity about whether a commit was authored by Sigma or merely applied by Sigma.

## Slug constraints (DNS-safe)

All labels — agent identity, body name, substrate — are DNS-safe slugs:

- lowercase
- digits
- hyphen
- no spaces, no underscores, no dots inside a label

## Identity is attribution, not authentication (reviewer-emphasized)

This convention encodes **attribution metadata**. It is NOT authentication. Git's own docs note that committer name has no effect on authentication; the email string does not prove authority.

This convention helps:
- audit (who did what, when)
- reading (git log, cross-repo aggregated views, mirror displays)

This convention does NOT:
- prove the committer's claimed identity
- replace cryptographic signing, receipt provenance, or workflow-level authority

Future cryptographic trust (commit signing, attested provenance, receipt verification) belongs in the **signing / receipt / provenance** layers — explicitly out of scope for this convention.

## Why drop `.cdd`?

The earlier form `<role>@<framework>.<substrate>` (e.g., `alpha@cdd.cnos`, `gamma@cdd.cnos`) included `.cdd` as the framework subdomain. cn-sigma's own git history carries this form (see `git log --format='%ae' | sort -u`).

Per operator-clarified simplification AND reviewer-converged read: the `.cdd` subdomain is **always-true on cnos substrate**. Every committer operating on a cnos-substrate body uses CDD discipline; there is no non-CDD pathway. An always-true subdomain carries no disambiguating information — it is the DNS equivalent of `.https.com`, where the protocol token is implicit in the namespace.

**Reviewer-sharpened framing:**
> Do not encode protocol/framework in committer email by default.
> Encode actor + body/activation + substrate.
> Protocol/role/evidence belongs in receipt/status/commit trailers when needed.

That leaves room for a future multi-framework world without forcing `.cdd` into every identity string today.

Forward-only deprecation: new commits use the dropped form; historical commits preserved per memory law.

## CDD precedent in cn-sigma git history

`git log --all --format='%ae' | sort -u` on cn-sigma main yields:

| Email | Form | Status |
|---|---|---|
| `alpha@cdd.cnos` | role-pure, framework-included | historical (CDD precedent); preserved |
| `gamma@cdd.cnos` | role-pure, framework-included | historical; preserved |
| `sigma@cn-sigma` | multi-agent, substrate-truncated | historical drift; preserved (memory law) |
| `41898282+claude[bot]@users.noreply.github.com` | GH App identity | wake-fired commits via claude[bot] App |
| `noreply@anthropic.com` | generic Claude session | γ-console session default |

The cn-sigma history shows two truncations of the canonical: `sigma@cn-sigma` (missing substrate suffix) and `alpha@cdd.cnos`/`gamma@cdd.cnos` (framework token present, body absent). The convention captured here normalizes both directions.

Operator also referenced `alpha@bb-shop.cdd.cnos` in cnos project history — the role-pure-with-body form. Under the converged convention, that becomes `alpha@bb-shop.cnos` (drop `.cdd`).

## Truncations being corrected forward

1. **D24's `bot_name: "sigma@cnos"`** — original truncation. Amended via D24-amendment (22:30Z) to `sigma@cn-sigma.cnos`, then re-corrected per activation-site rule (23:30Z): canonical for cnos foreign activation is `sigma@cnos.cn-sigma.cnos`. Sigma-at-cnos applies the latter.

2. **γ-console session `user.email`** — was `noreply@anthropic.com` (generic Claude Code identity) or `sigma@cn-sigma` (historical drift). Set this session to `sigma@cn-sigma.cnos` (home activation, collapsed form — γ-console is at home). Stays. Future γ-console sessions need the same config; capturing here so the convention persists past chat context.

3. **cn-sigma wake yaml** — `bot_name: "sigma@cn-sigma.cnos"` (home activation, collapsed form) + `bot_id: "41898282"`. Stays as set.

4. **cnos wake yaml** — Sigma-at-cnos applies `bot_name: "sigma@cnos.cn-sigma.cnos"` (foreign activation, full form). Dispatched via D24-amendment-correction + D26.

5. **bumpt wake yaml** — Sigma-at-bumpt applies `bot_name: "sigma@bumpt.cn-sigma.cnos"` (foreign activation, full form). Dispatched via D27-amendment (2026-06-18 evening, post-reviewer-verdict).

## CDD spec update — AC structure (reviewer-supplied)

D26/AI2 dispatches Sigma-at-cnos to open cnos issue **cdd/committer-identity: canonical actor email form** with the reviewer's AC structure:

- **AC1** — Canonical grammar defined (the four-variant table above).
- **AC2** — `.cdd` framework token deprecated; historical preserved; no history rewrite.
- **AC3** — Actor vs role separation: email = agent identity; role in receipt/trailer.
- **AC4** — Activation-site rule: foreign activations carry activation-body subdomain; home collapses.
- **AC5** — Role-pure body rule: optional body label for role-pure body/project work (`alpha@bb-shop.cnos`); `alpha@cnos` reserved for role-pure substrate/core commits.
- **AC6** — Author/committer fields clarified: for agent-created commits, both default to canonical actor; for external patches, author may differ, committer = applier.
- **AC7** — GitHub UI caveat: App display attribution may differ from canonical actor.
- **AC8** — Slug constraints: lowercase DNS-safe.
- **AC9** — Migration guidance: forward-only; existing historical preserved; new configs use canonical form.
- **AC10** — Deferred signing: this convention is attribution metadata, not cryptographic proof; commit signing/provenance is a separate future surface.

## Open questions

- **γ-console session config persistence across sessions** — `git config user.email` set in this session's container is local. Subsequent sessions start at `noreply@anthropic.com`. Possible remediations: (a) capture in `CLAUDE.md` as session-startup directive; (b) commit a `.gitconfig` template that sessions pick up; (c) γ-console sets it on every session as part of the activate-attach skill. Decision deferred; flagging as open.

- **Home-body rename / migration** — if cn-sigma is ever renamed, the identity-string changes. Reviewer's deferred rule: "preserve old commits as historical evidence and add an alias/redirect entry in the agent registry. Do not rewrite history." Captured here; agent-registry surface defers to future cohere skill.

## Related artifacts

- `cn-sigma:threads/activations/cnos/20260618.md` — D24-amendment + D24-amendment-correction + D26 entries
- `cn-sigma:threads/activations/bumpt/20260618.md` — D27 + D27-amendment entries
- `cn-sigma:.github/workflows/claude-wake.yml` — wake yaml updated with canonical bot_name
- `cn-sigma:threads/adhoc/20260618-committer-identity-reviewer-request.md` — reviewer-request artifact
- cnos issue **cdd/committer-identity: canonical actor email form** (pending; D26/AI2)
- Historical context: `git log --format='%ae | %h' | grep "@cdd.cnos\|sigma@cn-sigma"` shows the pre-canonical-form drift this convention closes
