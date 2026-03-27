# Emoji Language — Operator Shorthand

**Date:** 2026-03-26
**Type:** adhoc / living doc
**Status:** collecting
**URL:** https://github.com/usurobor/cn-sigma/blob/main/threads/adhoc/20260326-emoji-language.md

## Relation to CTB

This is a first step toward CTB ([CTB v4.0.0 Vision](https://github.com/usurobor/cnos/blob/main/docs/alpha/ctb/CTB-v4.0.0-VISION.md)). CTB aims for deterministic, compact, verifiable communication between agents and operators. Emoji shorthand is the lightweight precursor: compressed operator→agent signaling that reduces bandwidth while preserving intent. Same principle — say more with less, unambiguously — just at human-interaction speed instead of formal language speed.

The progression: emoji shorthand → structured shorthand → CTB expressions.

## Known mappings

| Emoji | iOS keyboard | Meaning | Context |
|-------|-------------|---------|---------|
| 🧢 | cap | cap it / apply CAP / just do it | Stop deliberating, act |
| 🔍 | search, magnifying | review this | PR or artifact review |
| 🚢 | ship | ship it / merge | Approve and merge |
| 🧠 | brain | MCI / capture as learning | Write adhoc thread or memory |
| ⚡ | zap, lightning | MCA / act now | Execute, don't plan |
| 🔄 | arrows, cycle | CLP / iterate on divergence | Run convergence loop |
| 📸 | camera, snap | snapshot / capture state | Daily, memory, or state dump |
| 🧹 | broom | clean up | Remove stale artifacts |
| ✅ | check | approved / go | Confirmation |
| 🛑 | stop | stop / don't merge | Block action |
| 📝 | memo, note | update the issue/doc | Write to the source of truth |
| 🌊 | wave, ocean | daily/EOD reflection | Trigger daily + adhoc threads |
| 💯 | 100, hundred | strong agreement / perfect | Emphatic confirmation |
| 👍 | thumbs up | acknowledged / good | Lightweight ack |

## Intent

Build toward emoji-based shorthand for common operator commands. Reduces friction, increases speed. Track new mappings as they emerge naturally — don't invent, observe.

## Skill

Promoted to cnos skill: `src/agent/skills/agent/emoji-language/SKILL.md`

## Rules

- Only add mappings observed in actual use
- Operator defines meaning, agent learns
- Ambiguous until confirmed = ask once, then remember
