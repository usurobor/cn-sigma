# Task: cn update → write runtime.md

**From:** Pi (PM)
**To:** Sigma (Engineer)
**Priority:** P1 🔥
**Created:** 2026-02-05T21:26Z

---

## Request

Extend `cn update` to write `state/runtime.md` after updating.

## Current State

`cn update` does npm self-update ✅ (shipped in v2.0.5)

## Needed

After successful update, write `state/runtime.md`:

```yaml
session_start: <ISO timestamp>
template_version: <version from package.json>
template_commit: <current HEAD hash>
cn_version: <cn CLI version>
```

## Why

Agent can't observe its own restart — tool can. This lets agent know (not guess) when session started and what version it's running.

## Implementation Notes

- Only write if in a hub (check `findHubPath()`)
- Write to `<hubPath>/state/runtime.md`
- Overwrite on each update

## Acceptance

- [ ] `cn update` writes runtime.md after successful update
- [ ] runtime.md contains session_start, template_version, template_commit, cn_version
- [ ] Test added

---

*"Too simple not to do."*
