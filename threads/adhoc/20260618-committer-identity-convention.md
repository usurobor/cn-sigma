# Committer-Identity Convention — Canonical Form

**Date:** 2026-06-18
**Author:** γ-console (operator-clarified)
**Status:** Convention captured; D24 amended; D26 dispatched for cnos-side application + CDD spec update.

## Convention

CDD encodes actor identity into git committer email. The canonical form is:

| Variant | Form | Example |
|---|---|---|
| Role-pure CDD | `<role>@<substrate>` | `alpha@cnos`, `gamma@cnos`, `delta@cnos` |
| Multi-agent | `<agent>@<home-body>.<substrate>` | `sigma@cn-sigma.cnos`, `rho@cn-rho.cnos` |

Read DNS-style (rightmost = root): substrate is root, body is subdomain, agent or role is leaf. The form is precise about who acted, where they live, and which substrate they run on — three pieces of load-bearing information.

## Travel rule

In the multi-agent variant, the body in the email is the agent's **home body**, NOT the activation site.

- Sigma activated at cn-sigma (γ-console): committer email `sigma@cn-sigma.cnos`
- Sigma activated at cnos (α-at-cnos, wake-fired): committer email `sigma@cn-sigma.cnos`
- Sigma activated at bumpt (α-at-bumpt, wake-fired): committer email `sigma@cn-sigma.cnos`

Identity belongs to the agent. The agent has one home body. The activation site is encoded in *where the commit lands* (which repo's git log), not in the committer email. Three activations, one identity.

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

1. **D24's `bot_name: "sigma@cnos"`** — this was a truncation (missing the home body subdomain). Amended via channel D24-amendment (2026-06-18T22:30Z): canonical `sigma@cn-sigma.cnos`.

2. **γ-console session `user.email`** — was `noreply@anthropic.com` (generic Claude Code identity) or `sigma@cn-sigma` (historical drift). Updated this session to `sigma@cn-sigma.cnos`. Future γ-console sessions need the same config; capturing here so the convention persists past chat context.

3. **cn-sigma wake yaml** — adds `bot_name: "sigma@cn-sigma.cnos"` + `bot_id: "41898282"`. Wake-fired commits at cn-sigma attribute correctly.

4. **cnos wake yaml** — to be updated by Sigma-at-cnos per D26/AI1 (or via the D24-amendment if not yet applied).

5. **bumpt wake yaml** — out of scope for D26 (Writer Locality prevents Sigma-at-cnos from writing to bumpt). Separate concern when α-at-bumpt is active.

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
