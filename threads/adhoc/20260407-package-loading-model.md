# Package Loading Model — NuGet over VS Code

**Date:** 2026-04-07
**Issue:** #167
**Design doc:** `docs/alpha/package-system/PACKAGE-ARTIFACTS.md` v0.3.0

## What happened

While reviewing #167 implementation, Axiom asked: "how does an agent know the entry point of a package?" This led to a design conversation about package loading models.

Surveyed: Java JARs (manifest Main-Class), Ruby gems (naming convention), npm (main/exports/bin), VS Code extensions (contributes + activationEvents), NuGet (content dirs + framework loading).

## Decision: NuGet model

**Package is dumb delivery. Runtime is smart loading.**

- Package manifest declares what content classes exist (skills, doctrine, mindsets, etc.)
- Well-known directory layout per content class (`skills/<name>/SKILL.md`, `doctrine/*.md`, etc.)
- Runtime and agent own all loading/discovery/activation semantics
- No activation logic, entry points, or orchestration in the manifest

### Why not VS Code model
VS Code puts activation events and contribution points in the manifest. That makes the manifest a plugin framework. cnos packages contain multiple content classes loaded at different times by different consumers — doctrine at wake, skills by trigger, commands by dispatch. Putting all that in the manifest duplicates what the runtime already knows.

### Why not npm model
npm's `main` field assumes one entry point per package. cnos packages have N entry points (one per skill, one per command, etc.). npm's `exports` map gets closer but still assumes code-module loading semantics.

### Why NuGet
NuGet packages are zips with well-known dirs (`lib/`, `content/`, `tools/`, `build/`). The framework knows what each dir means. Package doesn't say "load me like this" — the framework does. That's exactly what cnos needs: `skills/`, `doctrine/`, `commands/` are the well-known dirs. `cn` runtime knows the conventions.

## Key consequence: skill orchestration stays in skills

CDD delegates to sub-skills (design, review, release, etc.). That orchestration lives in `cdd/SKILL.md`, not in `cn.package.json`. The manifest lists all skills flat. The skill declares its own delegation relationships.

This means: to fix "agent doesn't know CDD entry point," fix the skill, not the manifest.

## References

- PACKAGE-ARTIFACTS.md v0.3.0 §1.1–§1.3
- NuGet package structure: https://learn.microsoft.com/en-us/nuget/create-packages/creating-a-package
- VS Code extension anatomy: https://code.visualstudio.com/api/get-started/extension-anatomy
- npm package.json: https://docs.npmjs.com/cli/v10/configuring-npm/package-json
