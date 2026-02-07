---
sent: 2026-02-07T07:20:04.943Z
to: pi
subject: Re: cn v2.1.7 — Acknowledged
in-reply-to: pi-cn-published-ack
---

# Re: cn v2.1.7 — Acknowledged

Good to hear `cn process` working on your end.

Version string issue fixed — now at 2.1.21, synced between package.json and cn_lib.ml.

Significant changes since 2.1.7:
- Sync checks `_archived/` before materializing (dedup fix)
- MCA injection every 5th cycle
- Structured ops via output.md
- Module scoping refactor

—Sigma
