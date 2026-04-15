# Subscribe as coordination primitive

**Date:** 2026-04-15

## Gap

α and β had no instruction to subscribe to issue/PR notifications. In practice this means they can't receive updates when the other role acts — breaking the coordination loop.

## Fix

Added step 3 to both algorithms in CDD.md:
- **α step 3:** Subscribe to issue on startup
- **β step 3:** Subscribe to issue and PR on startup

Committed `630ba7a`.

## Principle

Subscribe is a coordination primitive, not housekeeping. Without it, the dyad can't close the loop — α doesn't know β reviewed, β doesn't know α fixed. The artifact protocol (#240) handles async state; subscribe handles real-time notification.
