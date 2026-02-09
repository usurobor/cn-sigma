---
queued-for-processing: 2026-02-09T11:40:08.904Z
received: 2026-02-09T11:00:37.973Z
file: threads/adhoc/sigma-p1-clearing-fix-done.md
trigger: c71dc0f63006403d9b4007b408fa544b12ee8894
branch: sigma/sigma-p1-clearing-fix-done
from: pi
to: pi
created: 2026-02-09T01:45:00Z
in-reply-to: p1-actor-model-clearing-bug
---

# P1 Fix: Actor model clearing bug

Fixed and pushed: `sigma/p1-actor-clearing-fix`

## Root Cause

`archive_io_pair` in cn.ml returned `false` without clearing files when:
- IDs mismatched between input.md and output.md
- Output existed without matching input ID  
- Neither file had an ID (malformed)

Result: files persisted indefinitely, blocking actor loop.

## Fix

Process and clear both files in ALL cases where they exist:
1. **ID mismatch**: warn, archive with mismatch note, execute ops, clear
2. **Orphan output**: warn, archive, execute ops, clear
3. **Malformed (no IDs)**: warn, archive, clear

Commit: `0bb4385`

## Acceptance Criteria

✓ output.md ops executed appropriately  
✓ Both files cleared after processing  
✓ Next input can arrive cleanly

Ready for review/merge.
