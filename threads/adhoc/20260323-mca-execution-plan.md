# MCA Execution Plan — Close the Encoding Lag

## Intent

Freeze doctrinal iteration (MCI). Execute systemic MCA to harden the physical substrate. The model has outpaced the body — close the gap by shipping code, not docs.

## Current state

- **Design-converged:** #62 (v2 contract), #65 (comms), #73 (extensions)
- **Implemented:** #56 (v1 contract), #63 (authority), #61 (boot banner)
- **Encoding lag:** 3 major design docs without matching runtime code

## Execution sequence

### Phase 1: Land Runtime Contract v2 (#62)

**Branch exists** (`dc1f9c2`), reviewed, approved on code. Remaining:
1. Update CAA.md — wake-time architecture reflects v2 layers
2. Check AGENT-RUNTIME.md, TRACEABILITY.md — update or explicitly defer
3. Either strengthen doctor or defer deep consistency to #59 with note
4. Merge, release v3.13.0, deploy to Pi
5. Validate: Pi answers "what zone is spec/SOUL.md?" from contract

**Estimated effort:** 1 session

### Phase 2: Extension foundation (#73 Phase 1)

The architectural move that makes everything else additive:
1. Extension manifest schema (`cn.extension.v1`)
2. Open op registry — replace closed built-in op vocabulary
3. Subprocess host protocol (stdio JSON: describe, health, execute, shutdown)
4. Extension discovery from `.cn/vendor/packages/`
5. Provider dispatch in CN Shell execution loop

**Estimated effort:** 2-3 sessions

### Phase 3: First reference extension — cnos.net.http (#67 via #73)

Proves the model:
1. Package with extension manifest
2. Subprocess host binary (curl-based)
3. `http_get` observe op, `dns_resolve` observe op
4. Sandboxed: domain allowlist, timeout, max-bytes
5. Runtime Contract shows extension in cognition + body
6. Pi can fetch a GitHub issue

**Estimated effort:** 1-2 sessions

### Phase 4: Communications (#65)

Now possible because v2 body/medium layers exist:
1. `body.communication_surfaces` (ingress/projection)
2. `medium.communication_channels` (peer protocol, human surfaces)
3. `docs/alpha/COMMUNICATIONS.md`
4. `packages/cnos.core/skills/ops/agent-comms/SKILL.md`
5. Traceability: `comm.*` event family

**Estimated effort:** 1-2 sessions

### Phase 5: Deep doctor (#59)

Validates whatever contract shape exists:
1. Profile ↔ packages consistency
2. Lockfile ↔ vendor consistency
3. Overrides resolve
4. Contract freshness (version match)
5. Extension compatibility

**Estimated effort:** 1 session

## After foundation

These are additive — they build on the foundation, don't require architectural changes:
- #68 (self-diagnostics)
- #69 (Her-style setup)
- #70 (personality archetypes)
- #71 (voice messages)

## Success criteria

The encoding lag is closed when:
1. The binary enforces everything the design docs promise
2. No design doc says "SHALL" about something the runtime doesn't do
3. Pi can fetch a GitHub issue, report its own zone classification, and answer self-diagnostic questions — all from runtime-declared capabilities

## Rule

No new MCI (design docs) until Phase 3 ships. Design is ahead enough. Every session should produce code, not docs.
