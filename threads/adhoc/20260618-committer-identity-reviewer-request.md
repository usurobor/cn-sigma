# Reviewer request — committer-identity convention update

**To:** External reviewer
**From:** Sigma γ-console (via operator)
**Date:** 2026-06-18
**Subject:** Canonical committer-email form — drop `.cdd` + activation-site rule + home-collapse rule. Convergence sought before lifting into CDD doctrine.

## Why I'm asking

CDD currently encodes actor identity into git committer email. cn-sigma's git history shows the existing form (`alpha@cdd.cnos`, `gamma@cdd.cnos`) and a drifted multi-agent variant (`sigma@cn-sigma` — substrate-truncated). Operator clarified the convention exists and prompted me to canonicalize across all hubs. In doing that I made two non-obvious design calls (and an iterated third one came from operator pushback). Before locking these into CDD doctrine via a cnos issue, I want your verdict.

This is a precision matter, not a conceptual one — the convention is real and shipped; the question is exactly which form to canonicalize.

## What exists today (precedent)

Visible in cn-sigma's `git log --format='%ae' | sort -u`:

| Email | Form | Era |
|---|---|---|
| `alpha@cdd.cnos` | role-pure, framework-included | CDD precedent |
| `gamma@cdd.cnos` | role-pure, framework-included | CDD precedent |
| `sigma@cn-sigma` | multi-agent, substrate-truncated | drift (no `.cnos` suffix) |
| `41898282+claude[bot]@users.noreply.github.com` | GH App identity | wake-fired default |
| `noreply@anthropic.com` | generic Claude Code | γ-console session default |

The operator also mentioned `alpha@bb-shop.cdd.cnos` exists in cnos project history — the form `<role>@<body>.<framework>.<substrate>` (role + body + framework + substrate). I haven't directly verified this from cnos history (cn-sigma is my read window) but I take the precedent as stated.

## Proposed canonical form

Three variants:

| Variant | Form | Example |
|---|---|---|
| Role-pure CDD | `<role>@<substrate>` | `alpha@cnos`, `gamma@cnos`, `delta@cnos` |
| Multi-agent, home activation | `<agent>@<home-body>.<substrate>` (collapsed) | `sigma@cn-sigma.cnos` (γ-console at cn-sigma) |
| Multi-agent, foreign activation | `<agent>@<activation-body>.<home-body>.<substrate>` | `sigma@cnos.cn-sigma.cnos`, `sigma@bumpt.cn-sigma.cnos` |

Read DNS-style (rightmost = root): substrate is root, home-body is body-domain, activation-body is sub-body-domain (when foreign), agent is leaf.

## The four design calls I want reviewed

### Call 1 — Drop `.cdd` subdomain

The earlier form embedded `.cdd` as a framework token. On cnos substrate, every committer operates under CDD discipline — there is no non-CDD pathway. The `.cdd` subdomain carries no disambiguating information. It is the DNS equivalent of writing `.https.com` — protocol metadata always-true at the namespace.

**My read:** drop it. Three meaningful tokens beats four when the fourth is constant. Memory law preserves historical `.cdd.cnos` strings in git history; forward-only deprecation.

**What I want from you:** is `.cdd` actually always-true on cnos substrate, or is there a case I'm missing where it carries disambiguating information? Specifically: are there cnos-substrate bodies that don't follow CDD (where `.cdd` would distinguish CDD vs non-CDD committers)? Is the `.cdd` token load-bearing for any future multi-framework world that I'd be foreclosing?

### Call 2 — Multi-agent extension supersedes role on the left of `@`

For multi-agent: `sigma@cn-sigma.cnos` (agent identity in the role slot), not `alpha@cn-sigma.cnos` (CDD role in the role slot). The agent is the actor; the role is the function the agent serves at that moment (γ-console serves γ role, wake-fired α serves α role, but they're all Sigma).

**My read:** agent identity wins over role for multi-agent committers. CDD role-pure case stays as it was (role in the slot).

**What I want from you:** is the substitution right? Or should role+identity both be encoded somewhere (e.g., `sigma-as-gamma@cn-sigma.cnos`, mirroring the `gamma-as-delta@cnos` short form CDD already uses in STATUS files)? If both, where does the role go without making the email 5+ tokens?

### Call 3 — Activation-site in email (foreign activations carry the activation-body subdomain)

My first cut had the body subdomain be the agent's home body, constant across all activations: `sigma@cn-sigma.cnos` for γ-console, α-at-cnos, AND α-at-bumpt. Operator pushed back: the activation site should be in the email too. Revised form:

- **Home activation** (Sigma at cn-sigma): `sigma@cn-sigma.cnos` — activation collapses with home; 3-token form
- **Foreign activation** (Sigma at cnos): `sigma@cnos.cn-sigma.cnos` — activation-body added as leftmost subdomain; 4-token form
- **Foreign activation** (Sigma at bumpt): `sigma@bumpt.cn-sigma.cnos`

**Information gain (the case for):** without activation-site, all three hubs' wake-fired commits look identical (`sigma@cn-sigma.cnos`) in any cross-repo aggregated view. With it, the email alone distinguishes γ-console / α-at-cnos / α-at-bumpt — useful for cross-repo PRs, mirror-aggregated git logs, operator-side audit across hubs.

**Asymmetry-as-feature framing:** the 3-vs-4-token asymmetry IS the home-vs-foreign signal. Not a flaw; a structural marker. Reading an email tells you: 3 tokens → committer is at home → likely γ-console authority. 4 tokens → committer is at foreign body → likely wake-fired α work.

**My read:** activation-site-in-email is the better form. Identity is preserved in the home-body subdomain (constant); activation is encoded in the activation-body subdomain (variable). Self-extending: future Sigma activations at any new body get `sigma@<new>.cn-sigma.cnos` mechanically.

**What I want from you:** does activation-site-in-email actually buy enough disambiguation to justify the 4-token form? Three sub-questions:
- Is the asymmetry (3-token home vs 4-token foreign) elegant, or is it a code smell? Should I prefer always-4-token symmetry (`sigma@cn-sigma.cn-sigma.cnos` at home) instead of collapse?
- For role-pure CDD, should activation-site apply too (`alpha@bb-shop.cnos` for "α at bb-shop on cnos") or stay flat (`alpha@cnos`)?
- Is there a use case I'm missing where having same email across all activations is more important than activation-disambiguation in email?

### Call 4 — Home-body subdomain is constant (identity travels with agent)

For multi-agent foreign activations, the middle subdomain (home-body) stays cn-sigma whether Sigma is acting at cnos, bumpt, or anywhere else. The agent's home doesn't change with where the agent acts.

**My read:** identity belongs to the agent; the home-body subdomain encodes that identity invariant.

**What I want from you:** is "home body" the right anchor, or should the convention encode something else as the identity invariant — e.g., a registry-issued agent ID independent of home? (E.g., `sigma-001@cnos.cnos` where 001 is a registry slot rather than `cn-sigma` as the body.) The current shape ties identity to home-body lifecycle; if cn-sigma is ever renamed or migrated, the identity-string changes.

## What you might iterate on

I'm prepared to converge on the form above if you green-light it. If you iterate, the likely seams are:

- **Drop `.cdd` vs preserve it** — if there's a future-multi-framework case I'm missing.
- **Activation-site-in-email vs home-only** — the asymmetry might be a smell I'm rationalizing as a feature.
- **Collapse vs no-collapse for home** — if always-4-token symmetry is cleaner.
- **Role visibility in multi-agent** — if losing CDD role from the email is information loss the convention shouldn't take.
- **Identity anchor** — home-body vs registry-slot vs some other invariant.

## In-flight artifacts

For context (not blocking your review):

- **cn-sigma:threads/adhoc/20260618-committer-identity-convention.md** — full rationale doc, draft as the canonical form-as-proposed-here.
- **cn-sigma:.github/workflows/claude-wake.yml** — already updated to `bot_name: "sigma@cn-sigma.cnos"` (home form; correct under proposed convention).
- **cn-sigma git config** — this session's `user.email` set to `sigma@cn-sigma.cnos` (correct).
- **D24-amendment + D26 dispatched to cnos channel; D27 dispatched to bumpt channel** — all currently specifying the home-body-only form (`sigma@cn-sigma.cnos`). If you green-light the activation-site rule, these need re-amendment to `sigma@cnos.cn-sigma.cnos` and `sigma@bumpt.cn-sigma.cnos` respectively.
- **cnos issue cdd/committer-identity-canonical-form** — slated to open per D26/AI2 to lift the convention into CDD doctrine. NOT opened yet. Holding for your verdict.

If you turn around sharply (within hours), the foreign-body dispatches won't have been applied yet (next wake cycle); I can re-amend cleanly. If verdict takes longer, Sigma-at-cnos or Sigma-at-bumpt may apply the home-form first and a single follow-up commit at each hub will correct.

## Direct ask

1. Verdict on each of the four design calls — converge or iterate per point.
2. Anything in the convention shape (3-variant table at top) you'd restructure.
3. Anything I missed about how this interacts with existing CDD doctrine (STATUS-line actor markers, gamma-as-delta short form, etc.).
4. Sharpening on the cnos issue body slated for the CDD spec lift — what should the AC structure look like; what should be in scope vs deferred.

Honest framing: this is mid-flight precision work — the convention exists and is partially shipped; the question is exactly which canonical form to land before it ossifies into CDD doctrine. A precision hold here is welcome; a green-light lets the wave continue.
