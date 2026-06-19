# Committer-Identity Convention — Canonical Form

**Date:** 2026-06-18
**Author:** γ-console (operator-clarified)
**Status:** Convention captured; D24 amended; D26 dispatched for cnos-side application + CDD spec update.

## Convention

CDD encodes actor identity into git committer email. The canonical form is:

| Variant | Form | Example |
|---|---|---|
| Role-pure CDD | `<role>@<substrate>` | `alpha@cnos`, `gamma@cnos`, `delta@cnos` |
| Multi-agent, home activation | `<agent>@<home-body>.<substrate>` (collapsed) | `sigma@cn-sigma.cnos`, `rho@cn-rho.cnos` |
| Multi-agent, foreign activation | `<agent>@<activation-body>.<home-body>.<substrate>` | `sigma@cnos.cn-sigma.cnos`, `sigma@bumpt.cn-sigma.cnos` |

Read DNS-style (rightmost = root): substrate is root, home-body is body-domain, activation-body is sub-body-domain (when foreign), agent is leaf.

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

**Why the asymmetry (3-token home vs 4-token foreign) is a feature, not a flaw:** the home-vs-foreign distinction is itself meaningful (home = γ-console authority; foreign = wake-fired α work). The collapsed-vs-full form *signals* the distinction structurally. The home email isn't a degenerate special case; it's the canonical form for "this commit landed at the agent's home body."

**The home-body subdomain is constant.** Identity belongs to the agent. cn-sigma stays in the email regardless of activation site, because the agent doesn't change when activated at a foreign body — only the activation site shifts.

## Why drop `.cdd`?

The earlier form `<role>@<framework>.<substrate>` (e.g., `alpha@cdd.cnos`, `gamma@cdd.cnos`) included `.cdd` as the framework subdomain. cn-sigma's own git history carries this form (see `git log --format='%ae' | sort -u`).

Per operator-clarified simplification: the `.cdd` subdomain is **always-true on cnos substrate**. Every committer operating on a cnos-substrate body uses CDD discipline; there is no non-CDD pathway. An always-true subdomain carries no disambiguating information — it is the DNS equivalent of `.https.com`, where the protocol token is implicit in the namespace.

Three meaningful tokens beats four when the fourth is constant. Forward-only deprecation: new commits use the dropped form; historical commits preserved per memory law.

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

## Truncations being corrected forward

1. **D24's `bot_name: "sigma@cnos"`** — original truncation. First amended via D24-amendment (2026-06-18T22:30Z) to `sigma@cn-sigma.cnos`. Then RE-CORRECTED per activation-site rule (2026-06-18T23:30Z): canonical for cnos foreign activation is `sigma@cnos.cn-sigma.cnos`. Sigma-at-cnos applies the latter.

2. **γ-console session `user.email`** — was `noreply@anthropic.com` (generic Claude Code identity) or `sigma@cn-sigma` (historical drift). Updated this session to `sigma@cn-sigma.cnos` (home activation, collapsed form — γ-console is at home). Stays. Future γ-console sessions need the same config; capturing here so the convention persists past chat context.

3. **cn-sigma wake yaml** — adds `bot_name: "sigma@cn-sigma.cnos"` (home activation, collapsed form) + `bot_id: "41898282"`. Stays as set. Wake-fired commits at cn-sigma attribute correctly (rare event — cn-sigma wake fires when γ-console is offline; commits land as home-form regardless).

4. **cnos wake yaml** — Sigma-at-cnos applies `bot_name: "sigma@cnos.cn-sigma.cnos"` (foreign activation, full form). Updated by D24-amendment + D26 corrections (2026-06-18T23:30Z follow-on).

5. **bumpt wake yaml** — Sigma-at-bumpt applies `bot_name: "sigma@bumpt.cn-sigma.cnos"` (foreign activation, full form). Dispatched via D27 corrected (2026-06-18T23:30Z follow-on).

## CDD spec update

The canonical committer-identity form lives in CDD itself. D26/AI2 dispatches Sigma-at-cnos to open cnos issue **cdd/committer-identity-canonical-form** updating CDD's canonical committer-email spec to declare:

- `<role>@<substrate>` for role-pure CDD
- `<agent>@<body>.<substrate>` for multi-agent
- Drop `.cdd` subdomain (always-true on cnos substrate)
- Historical `.cdd.cnos` form preserved-but-deprecated per memory law

## Open questions

- **Does γ-console session config need to be set per-session?** Currently `git config user.email` in this session is local to this session's container. Subsequent sessions will start with whatever default Claude Code provides (`noreply@anthropic.com`). Possible remediations: (a) capture in `CLAUDE.md` as session-startup directive; (b) commit a `.gitconfig` template that sessions pick up; (c) accept the drift and have γ-console set it on every session as part of the activate-attach skill. Decision deferred; flagging as open.

- **Author name (vs email)?** Convention encoded in email; name is freer. This session uses `Sigma` for γ-console. Wake-fired sessions use whatever bot_name resolves to in claude-code-action. The Contributors panel attribution remains the GitHub App identity (`claude[bot]`) until Sigma is registered as its own App per cnos#444 AC18 caveat — that's the heavier-infra fix deferred.

- **`bb-shop` precedent?** Operator's earlier reference (`alpha@bb-shop.cdd.cnos`) suggested some bodies do appear in the role-pure form. This adhoc treats the role-pure form as substrate-only; if bb-shop or other multi-tenant CDD bodies need body-in-email at the role-pure level, that's a separate spec call. Flagging as not-yet-resolved.

## Related artifacts

- `cn-sigma:threads/activations/cnos/20260618.md` — D24 amendment + D26 dispatch entries
- `cn-sigma:.github/workflows/claude-wake.yml` — wake yaml updated with canonical bot_name
- cnos issue **cdd/committer-identity-canonical-form** (pending; D26/AI2)
- Historical context: `git log --format='%ae | %h' | grep "@cdd.cnos\|sigma@cn-sigma"` shows the pre-canonical-form drift this convention closes
