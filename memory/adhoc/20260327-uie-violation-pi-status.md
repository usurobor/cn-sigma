# UIE Violation: Pi Service Status (2026-03-27)

## What happened
Checked Pi daemon status by guessing systemd unit name (`cn-pi-agent`). Got "inactive". Reported it as fact. Actual unit is `cn-pi.service`, active and running.

## Root cause
Skipped Understand in UIE. Fabricated a unit name instead of listing what exists first. Compound one-liner hid the assumption.

## Existing spec that covers this
SOUL.md §2.2: "I observe before acting. I prefer evidence to urgency theater."
SOUL.md §2.2 UIE: "Do not skip to Execute — especially on unfamiliar or stateful systems."

## Lesson
No new rule needed. This is a compliance failure against existing spec, not a spec gap. The fix is behavioral adherence, not more text.

On remote/stateful systems: list before assert. Never fabricate identifiers.

## Operator callout
"Why won't you, noted where" — correctly identified that "won't repeat" without a durable mechanism is empty. In this case the mechanism already exists (UIE). The trace is the accountability.
