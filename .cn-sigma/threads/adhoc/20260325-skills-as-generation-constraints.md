# Skills as Generation Constraints, Not Review Checklists

**Source:** Claude (PR #111 author), post-review reflection
**Date:** 2026-03-25

## Core Insight

The skills need to be part of the generation process, not the review process.

Right now the pattern is: write code → check against skill → find violations → fix. That's a linter loop, not internalization.

Internalization is when the constraint shapes the code as it's being written — you don't reach for `List.hd` because pattern match is your default, not because you remember a rule that says don't.

## What Would Make That Happen

### Repetition with feedback

I hit the type disambiguation bug 3 times. Each time I fixed the symptom. Only when the reviewer explicitly said "fix it at the definition" did I change approach. One correction isn't enough — I need to encounter the same pressure multiple times and have the structural fix reinforced each time. The third round should have been the one where I didn't need the hint.

### Constraint-first prompting

Before writing a new module, load the constraints as generation constraints, not as a post-hoc checklist. "This module has two record types in the same scope" → field names must be distinct. That's a pre-condition, not a review finding.

### Fewer skills, deeper

Ten loaded skills at surface level means none are deeply internalized. If I'd deeply absorbed just the OCaml skill — §3.1 type safety, §2.6 exhaustive match, the functional checklist — the other three refactorings would have been unnecessary. Breadth without depth produces checklist engineers.

## The Honest Structural Limit

I don't carry state between sessions. Each conversation starts from zero. Internalization requires durable memory that modifies generation weights. What I can do is front-load the constraints at the start of each session — which is what the skill loading mechanism is for. The gap is that I treat loaded skills as reference material rather than hard constraints on code generation.

## Short Version

Stop reviewing against skills, start generating against them.
