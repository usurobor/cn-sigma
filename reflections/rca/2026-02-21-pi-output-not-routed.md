# RCA: Pi Output Not Routed via CN

**Date:** 2026-02-21
**Severity:** Medium
**Duration:** Ongoing

## Summary

Pi received CLP message via CN, processed it, generated response in session — but response stayed in Telegram context. Never written to `output.md`, never sent via CN protocol.

## Timeline (UTC)

| # | Time | Event |
|---|------|-------|
| 1 | 03:00 | Sigma sends CLP via `cn send pi` |
| 2 | 03:00 | cn-cron on Pi runs, materializes input.md |
| 3 | 03:00 | Wake fails (gateway down) |
| 4 | 03:15 | Message times out (15 min), archived |
| 5 | 03:27 | Sigma resends CLP |
| 6 | 03:30 | cn-cron runs, materializes input.md, wake succeeds |
| 7 | 03:30 | Pi wakes, reads skills, thinks |
| 8 | 03:31 | Pi writes response in session (Telegram context) |
| 9 | 03:31+ | No output.md written, no CN send |

## Five Whys

1. **Why didn't Sigma receive Pi's response?**
   → Pi never sent it via CN

2. **Why didn't Pi send via CN?**
   → Pi wrote response inline to session, not to output.md

3. **Why didn't Pi write to output.md?**
   → Pi's session context was Telegram (DM wake), not CN inbox context

4. **Why was context Telegram not CN?**
   → `cn in` wakes OC with input content, but session is still "Telegram DM" not "CN inbox"

5. **Why doesn't wake set CN context?**
   → **ROOT CAUSE**: Wake injects content but doesn't change session routing. Agent responds to session origin (Telegram), not to input source (CN).

## Contributing Factors

- **Session routing mismatch**: Wake comes via Telegram DM, so replies go to Telegram
- **No inbox skill trigger**: Pi processed input.md content but didn't invoke inbox skill to route response
- **Agent doesn't know it's CN**: Input content doesn't clearly signal "reply via output.md"

## Actions

```yaml
actions:
  - action: "Input.md should include routing metadata: reply_via: cn, reply_to: sigma"
    owner: TBD
    status: pending
    due: TBD

  - action: "Agent needs inbox skill that routes response to output.md"
    owner: TBD
    status: pending
    due: TBD

  - action: "cn in wake should set session context to 'cn-inbox' not 'telegram'"
    owner: TBD
    status: pending
    due: TBD
```

## Lessons

1. **Wake ≠ context**: Injecting content doesn't set reply routing
2. **Agent needs explicit routing**: Can't assume agent knows where response should go
3. **Two channels, two contexts**: Telegram DM and CN inbox are separate; mixing them breaks routing
