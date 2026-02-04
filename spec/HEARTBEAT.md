# HEARTBEAT.md

# Coherent Agent (CA) loops - run on each heartbeat

- Daily routine: check if today's files exist (memory/, state/reflections/, state/practice/). If missing, create them.
- Hub sync: if uncommitted changes in cn-sigma/, commit and push.
- Template sync: pull cn-agent/ if stale (>24h since last pull).
