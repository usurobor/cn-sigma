# Privacy Modes + Memory-Return Mechanism — doctrine capture

**Date:** 2026-06-18
**Author:** reviewer (verdict text preserved); γ-console (operator-amendments + open-question framing)
**Status:** Reviewer-supplied doctrine captured. Operator amendments require dispatch. Memory-return mechanism is an open question.

## Source

Reviewer-supplied doctrine on private-repo privacy modes + memory-return discipline, in response to "should cnos support private-repo activations and if so what's the mechanism?" Reviewer verdict supplied 2026-06-18 (operator-relayed).

## Reviewer's doctrine (preserved verbatim)

> Yes. Treat this as a privacy mode, not as an afterthought of private repos.
>
> The clean model is two-axis:
>
> ```
> usage disclosure:
>   hidden | disclosed
> memory return:
>   none | redacted-proposal | private-full
> ```
>
> Your three cases become the public-facing modes:
>
> | Mode | Meaning | cnos behavior |
> |---|---|---|
> | **P0 — Silent private** | "Do not reveal I use cnos." | Everything stays in the private repo or local/private stores. No public registration, no memory-return, no public issue links. |
> | **P1 — Disclosed private** | "It is okay to say this repo uses cnos, but do not share memories." | cnos usage/activation may be registered or acknowledged, but no logs, reflections, prompts, code, paths, customer facts, or lessons leave the repo. |
> | **P2 — Redacted feedback** | "Share cnos-related learnings back, but no internal project data." | Agent may draft redacted protocol/persona/package feedback for public cnos/cn-sigma, but only through an explicit review gate. |
>
> There is also a fourth private-to-private case:
>
> **P3 — Private full return** — where a private repo returns full memory to a private home hub or private protocol repo. That is outside public cnos, but the architecture should allow it.

### The important rule

> Do not let "private repo" imply one behavior.
>
> Private repos need an explicit policy file:
>
> `.cn/privacy.md`
>
> or, if we want structured machine reading:
>
> `.cn/policy/privacy.yaml`
>
> Something like:
>
> ```yaml
> schema: cnos.privacy.v0
> repo_visibility: private
> usage_disclosure: hidden        # hidden | disclosed
> memory_return: none             # none | redacted-proposal | private-full
> public_identity:
>   mode: none                    # none | alias | repo_url
>   alias: null
> allowed_public_targets: []
> allowed_private_targets: []
> redaction:
>   required: true
>   human_approval_required: true
>   never_export:
>     - source code
>     - secrets
>     - customer names
>     - private paths
>     - private issue titles
>     - private prompts/logs
>     - screenshots
>     - datasets
>     - business metrics
> ```
>
> The default for a private repo should be:
>
> **P0 — Silent private**
>
> Then the operator can explicitly upgrade to P1 or P2.

### Mode P0 — Silent private

> This is the strictest mode.
>
> "I do not want anyone to know this repo uses cnos."
>
> Then cnos must not create public traces:
>
> - No public home registration.
> - No public memory-return.
> - No public GitHub issue links.
> - No public "activation exists" note.
> - No public cn-sigma state update saying this repo is attached.
> - No telemetry.
> - No automatic branch or issue in usurobor/cnos.
>
> The repo may still have private local surfaces:
>
> ```
> .cn/
> .cn-sigma/
> .cn-foo/
> .github/workflows/...
> ```
>
> but they stay inside the private repo.
>
> This has a cost: if the repo is truly silent, it cannot participate as a normal registered public activation of cn-sigma. Home Sigma cannot honestly claim continuity over a body it is not allowed to know exists.
>
> So P0 means one of these:
> - local/detached use of cnos
> - private home hub
> - private mirror of the agent home
> - operator-mediated manual transfer only
>
> No magic.

### Mode P1 — Disclosed private, no memories

> This mode says:
>
> "You may know this repo uses cnos, but nothing learned inside comes back."
>
> Here, it is okay to register a private activation in a home hub or private/public registry, but the registry must be **metadata-only**.
>
> Allowed:
> - repo alias or repo URL, if operator allows
> - activation status
> - cnos version
> - wake status
> - credential/registration gates
>
> Not allowed:
> - activation logs
> - r1 reflections
> - private paths
> - issue titles
> - code snippets
> - operator dialogue
> - customer/project facts
> - debug traces
>
> For example, home Sigma may know:
>
> ```yaml
> activation:
>   alias: private-client-app
>   visibility: private
>   memory_return: none
>   status: registered
> ```
>
> But it may not receive:
>
> > "Today we discovered their payment provider integration is broken because..."
>
> or even:
>
> > "Path src/payments/acme_gateway.ts caused the failure."
>
> In P1, logs stay private. Home can track existence and gates, not memory.

### Mode P2 — Redacted feedback

> This is the useful collaborative mode.
>
> "This private repo may teach cnos something, but only if the lesson is redacted."
>
> The key distinction:
>
> - private memory stays private
> - public lesson is distilled
>
> Example private memory:
>
> > "In repo X, a wake failed because a private deployment script used customer-specific path Y and the agent misread the rollback convention."
>
> Public cnos lesson:
>
> > "Wake workers need a `rollback_policy` field in the implementation contract because private repos often encode rollback outside the code tree."
>
> No customer name. No repo name unless allowed. No private path. No code. No logs. No screenshots. No raw prompt. No internal business context.
>
> The public artifact should be a proposal, not an automatic export:
>
> ```
> .cn/outbox/usurobor__cnos/redacted-memory-return-YYYYMMDD/
>   SUMMARY.md
>   PUBLIC-LESSON.md
>   PATCH.diff           # only if public-safe
>   REDACTION.md
>   STATUS.md
> ```
>
> And the private repo keeps the full receipt locally:
>
> ```
> .cn/private/memory-return/YYYYMMDD/
>   FULL-RECEIPT.md
>   PRIVATE-EVIDENCE.md
>   REDACTION-MAP.md
> ```
>
> The public proposal may say:
>
> ```
> private_receipt_hash: sha256:...
> ```
>
> but not expose the receipt.

### The hard safety rule

> For P2:
>
> - Agents may draft redacted memory-return.
> - Humans approve publication.
>
> I would not trust an agent alone to guarantee "no internal project data leaks." It can help redact, classify, and produce a public-safe lesson, but the export boundary should be human-gated.
>
> So the rule should be:
>
> > No automatic public memory-return from private repos.
>
> Ever, at least in v0.

### How this fits cnos design

> This maps cleanly onto the memory-owner model:
>
> ```
> persona memory  → cn-sigma / cn-rho
> protocol memory → cnos package
> project memory  → private project repo
> private memory  → private repo / private store / redacted proposal only
> ```
>
> The privacy mode decides whether memory is allowed to cross from private project memory into public protocol/persona memory.
>
> For private repos:
>
> > project memory is sticky by default
>
> It does not leave unless explicitly transformed into a public-safe lesson.

### What cohere should do

> When running in a private repo, cohere should detect privacy mode or ask for it.
>
> For example:
>
> > Cohere as https://github.com/usurobor/cn-sigma
>
> In a private repo, if no privacy policy exists, cohere should create or ask for:
>
> ```
> Privacy mode?
> P0 silent:
>   do not reveal this repo uses cnos
> P1 disclosed:
>   register usage, but no memories return
> P2 redacted feedback:
>   allow human-approved redacted cnos lessons
> ```
>
> Then it writes:
>
> `.cn/policy/privacy.yaml`
>
> If running non-interactively and no policy exists:
>
> ```
> default P0
> outcome: degraded
> degraded_reason: privacy_policy_missing
> ```
>
> No outbound action.

### What registration should do

> cnos#449 should distinguish registration from memory.
>
> Registration packet should include:
>
> ```yaml
> privacy:
>   usage_disclosure: hidden | disclosed
>   memory_return: none | redacted-proposal | private-full
>   public_identity: none | alias | repo_url
> ```
>
> For P0: No public registration.
> For P1: Registration allowed. Memory return disabled.
> For P2: Registration allowed. Redacted proposals allowed after human approval.

### What wake workers should do

> Wake workers must treat privacy mode as a hard constraint.
>
> ```
> P0:
>   no outbound registration
>   no public issue comments outside same private repo
>   no memory-return bundles to public repos
> P1:
>   registration/status only if allowed
>   no memory-return
> P2:
>   may draft redacted proposal
>   may not publish without human approval
> ```
>
> Any attempted violation should produce:
>
> ```
> outcome: degraded
> degraded_reason: privacy_gate
> ```
>
> or:
>
> ```
> outcome: failed
> degraded_reason: privacy_policy_violation
> ```
>
> depending on severity.

### What should be shared back in P2?

> Only cnos-relevant lessons.
>
> **Good P2 returns:**
> - "cohere-create needs an explicit `secret_pending → armed` transition."
> - "wake-template should not interpolate issue bodies into system prompts."
> - "private repo registration needs an operator-visible packet because home cannot read the repo yet."
> - "reflect basis needs commit SHA pins, not just paths."
>
> **Bad P2 returns:**
> - "Client X's repo had this failure."
> - "Here is the private path."
> - "Here is the stack trace with secrets removed, probably."
> - "Here is a screenshot."
> - "Here is the internal workflow we were building."
>
> The public lesson should be abstract enough that it could have come from many projects.

### Proposed doctrine sentence

> I would add this to cnos privacy / registration / memory-return doctrine:
>
> > Private project memory is non-exportable by default.
> > A private repo may disclose cnos usage, and may separately allow redacted cnos-related feedback.
> > These are distinct permissions.
> > No raw private memory crosses into public cnos surfaces.
>
> And the sharper version:
>
> > A private repo can teach cnos without becoming evidence in cnos.
>
> That is the core.

### Recommended implementation issues (reviewer-supplied AC structure)

> Either amend cnos#449, or file a small follow-up:
>
> **agent/privacy-policy: private repo disclosure + memory-return modes**
>
> Acceptance criteria:
>
> - **AC1** — privacy modes defined: P0 silent / P1 disclosed-no-memory / P2 redacted-feedback / P3 private-full
> - **AC2** — policy file defined: `.cn/policy/privacy.yaml` or `.cn/privacy.md`
> - **AC3** — private repo default: P0 if no policy exists
> - **AC4** — cohere private onboarding: detects private repo and asks/records privacy mode
> - **AC5** — registration integration: #449 packets include usage_disclosure and memory_return
> - **AC6** — memory-return integration: public return requires redacted proposal + human approval
> - **AC7** — worker enforcement: outbound public writes blocked unless policy permits
> - **AC8** — no raw private memory: logs, reflections, prompts, paths, code, customer data never exported to public surfaces
> - **AC9** — degraded reasons: privacy_policy_missing / privacy_gate / privacy_policy_violation

### Final call

> Use the three user-facing modes:
> - P0 — Silent private
> - P1 — Disclosed private, no memories
> - P2 — Redacted feedback
>
> Default private repos to P0.
>
> Make P2 human-approved, proposal-based, and redacted.
>
> Do not let the agent decide that something is safe to share just because it "seems cnos-related."
>
> The clean architecture is:
>
> ```
> private repo keeps private memory
> public cnos receives only public-safe lessons
> privacy mode governs the bridge
> ```
>
> That keeps cnos useful for private work without turning private repos into accidental training/evidence sources.

---

## Operator amendments

### Amendment 1: Privacy explicit for ALL activations (not just private repos)

The reviewer framed privacy modes around the private-repo question. Operator's extension: **every activation declares a privacy mode, including public repos**. There is no implicit "public = anything goes" default; public repos opt into a mode, even if that mode is permissive.

This generalizes the doctrine:

- Privacy mode is a property of every activation, not a fallback for private-only.
- Public repos may have something like `P-public` mode (memory-return: full; usage-disclosure: disclosed by default) but the mode is **explicit**, not implicit.
- The policy file `.cn/policy/privacy.yaml` exists at every body, not just private ones. Absence-of-file means "policy not yet declared" → `outcome: degraded` until set.

Implication for cn-sigma, cnos, bumpt themselves:
- cn-sigma: needs explicit policy file even though it's the public home for Sigma. Likely `P-public` (full memory, disclosed identity).
- cnos: explicit policy. Public substrate; `P-public` plus a note that protocol-memory IS the explicit purpose.
- bumpt: explicit policy. Public product hub; `P-public` for cnos-related memory; project-memory (Stone Techno field data, customer dialogue) may have a separate per-data-class policy.

Proposed P-public mode (operator-amendment-1):

```yaml
schema: cnos.privacy.v0
repo_visibility: public
usage_disclosure: disclosed
memory_return: full              # or: redacted-proposal | redacted-only
public_identity:
  mode: repo_url
  alias: null
```

And the AC structure gains:
- **AC-extended**: all activations require explicit privacy policy; absence-of-file → degraded; no implicit defaults at any visibility level.

This sharpens the reviewer's "do not let private-repo imply one behavior" into "do not let any-repo imply any behavior — policy is always explicit."

### Amendment 2: Memory-return mechanism is open

The reviewer named the artifacts of memory-return (private repo's `.cn/private/memory-return/YYYYMMDD/` + public proposal's `.cn/outbox/usurobor__cnos/redacted-memory-return-YYYYMMDD/`) and the human-approval gate, but the **transport mechanism** — how the public proposal actually crosses from the private repo into cnos as a reviewable artifact — is not specified.

Operator's open question: what's the mechanism?

#### Candidate mechanisms (γ-console-surfaced; not reviewer-approved)

**Mechanism A — Issue-at-cnos (file an issue at usurobor/cnos with redacted body)**

- Private repo's agent generates the redacted proposal locally.
- Human approves locally.
- Agent uses an OAuth token (configured via registration packet) with `issues: write` on cnos to file an issue at usurobor/cnos.
- Issue title: `[P2 redacted feedback from <alias>] <lesson summary>`
- Issue body: the redacted `PUBLIC-LESSON.md` content + `private_receipt_hash: sha256:...` + reference to private origin (alias only).
- cnos maintainer triages: accept (close+credit) / reject (close+reason) / iterate.

Pro: matches Writer Locality (issue API is the cross-repo write surface; no tree writes).
Pro: matches existing dispatch protocol (cnos#454) — could be labeled `class:redacted-feedback` for triage discovery.
Pro: human-gated TWICE (local approval before filing + cnos triage on receipt).
Con: requires the private repo's agent to hold a token with `issues: write` on cnos (credential surface overlap with cnos#449/450).
Con: less structured for code-change proposals (markdown only; no native patch attachment).

**Mechanism B — PR-at-cnos (open a PR against cnos with the redacted patch)**

- Private repo's agent generates a branch in a fork or in a designated cnos branch.
- Opens PR with `PUBLIC-LESSON.md` + optional `PATCH.diff` applied.

Pro: code changes are first-class (patch directly applicable).
Pro: review UI is rich.
Con: requires write access to cnos branches OR fork-based flow (complexity); private repo holding cnos push credential is heavy.
Con: less aligned with Writer Locality — PR-creation isn't a tree write but the underlying branch push is.

**Mechanism C — Operator-mediated outbox (private writes locally; operator carries)**

- Private repo's agent generates `.cn/outbox/...` locally; agent does NOT publish.
- Operator manually reviews + manually files at cnos.

Pro: cleanest credential surface (no cross-repo tokens needed).
Pro: hardest human gate (manual transit).
Con: high latency.
Con: doesn't scale beyond operator-as-single-bottleneck.

**Mechanism D — Bridge agent (separate agent reads private outbox, files at cnos)**

- A dedicated bridge agent (say, `delta-bridge@cnos.cn-sigma.cnos` or operator-side) reads from registered private outboxes and files at cnos on their behalf.

Pro: separates credentials cleanly (bridge holds the cnos-write token; private bodies never do).
Pro: triage-friendly (bridge can normalize submissions).
Con: new agent surface to build; complexity overhead.

#### γ-console's lean (not authority — for reviewer convergence)

Mechanism A (issue-at-cnos) for v0:
- Lowest infra cost.
- Matches existing protocol surfaces (dispatch, issue triage, Writer Locality).
- Credential surface scoped to `issues: write` (narrow; not branch-push).
- Mechanism D (bridge agent) is a clean v1 evolution if Mechanism A's per-private-body credentials become annoying.

But the operator's amendment-2 phrasing — "what's the mechanism to share memories redacted or not back?" — also asks about the "or not" case (P3, private-full return to a private home hub). That mechanism is different from public-cnos return:

**Mechanism E — Private-to-private transport (P3)**

- Private repo's agent writes to its private home hub via direct git push (with appropriate credentials).
- Memory transports fully; no redaction.
- Wholly private: no cnos surface involved.

For P3, the transport question reduces to: which private home hub? Each operator's private agent system would handle this differently. Doctrine notes this exists; mechanism is per-deployment.

### Open questions surfaced by operator amendments

1. **What does P-public actually mean for memory-return at the cn-sigma / cnos / bumpt level?** Currently r1-r5 reflections at cn-sigma get committed to public main. That's `memory_return: full` for protocol-relevant content. But what about cn-sigma's threads/adhoc/ entries that touch operator dialogue, customer specifics from bumpt's Stone Techno POC, etc.? Even public repos need redaction discipline for SOME content classes. Per-data-class policy (rather than per-repo) might be needed.

2. **For Mechanism A**: what label / discoverability surface does cnos use for "incoming P2 redacted feedback"? cnos#454's `dispatch:cell + status:todo` is for OUTBOUND directives from γ-console. Inbound redacted feedback needs its own label (e.g., `inbound:redacted-memory`, `priority:triage`).

3. **Mechanism for P0 → P1 / P1 → P2 upgrades**: a private repo at P0 has no public registration; if it wants to upgrade to P1, how does the registration packet land at home Sigma without revealing P0's prior existence? Likely: P0-to-P1 upgrade is operator-mediated; it's a one-time disclosure event, not a continuous one.

4. **Audit trail for redactions**: REDACTION-MAP.md at private side records what was redacted. Does cnos doctrine require any specific format / integrity guarantees on the map? E.g., must include cryptographic commitment to the original (not present) text? This overlaps with deferred-signing per the committer-identity convention's AC10.

5. **What happens when a public lesson at cnos is later traced back to a private origin?** If the public proposal lives at cnos as an issue with `private_receipt_hash`, anyone with access to that issue can see the hash. The hash is meant to prove the private repo's claim without revealing it; but a malicious party with access to the private repo could verify by computing the hash from their copy. This is acceptable for v0; flagging.

## Implementation surface

Per reviewer's recommendation: either amend cnos#449 or file a small follow-on. γ-console suggestion:

- File a new cnos issue: **agent/privacy-policy: per-activation modes + memory-return mechanism**
- AC1–AC9 per reviewer's structure
- AC10–AC12 per operator amendments:
  - **AC10**: All activations (public + private) require explicit `.cn/policy/privacy.yaml`. Absence-of-file → degraded outcome until set. No implicit defaults.
  - **AC11**: Public-mode (`P-public`) is a first-class mode with `memory_return: full | redacted-proposal | redacted-only` (per-data-class options).
  - **AC12**: Memory-return mechanism documented (per the open-question convergence). Default v0 mechanism: Mechanism A (issue-at-cnos) with explicit `inbound:redacted-memory` label. Mechanism D (bridge agent) is a deferred v1.

Dispatch to Sigma-at-cnos via a new directive (D28 candidate) after this adhoc is approved and the open questions converge.

## Related artifacts

- `cn-sigma:threads/adhoc/20260618-committer-identity-convention.md` — analogous explicit-policy-per-body discipline (AC10 deferred-signing parallels the AC10–AC12 deferred-mechanism here)
- cnos#449 — operator-visible registration packet (privacy.usage_disclosure + memory_return fields land here)
- cnos#450 — wake-template (privacy_gate enforcement at wake-worker level)
- cnos#444 — cohere (cohere private-onboarding flow per AC4)
- cnos#454 — dispatch protocol (label-gated work queue; inbound redacted feedback needs its own label class)
- cnos#458 — reflect (basis SHA-pinning interacts with redaction-map integrity)
- AGENT-MEMORY-LOG-STRUCTURED — memory-owner model + memory law (project memory sticky by default doctrine extends this)

## Pending operator decisions

1. Approve amendments 1 (P-public explicit) and 2 (mechanism question framing).
2. Pick a v0 mechanism for memory-return (γ-console leans Mechanism A but defers to operator/reviewer).
3. Authorize D28 dispatch (or amendment of cnos#449) once the open questions converge.
4. Decide P-public granularity: per-repo or per-data-class.
