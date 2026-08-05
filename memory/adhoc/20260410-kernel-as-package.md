# Kernel as Package — Design Thread

**Date:** 2026-04-10
**Status:** design captured, implementation in #209

## Core insight

The platform is an instance of its own model, not a special case outside it.

`cnos.kernel` is a package with an embedded `cn.package.json`. Same `Command` interface as vendor and repo-local commands. Same registry, same dispatch, same `cn help` listing. The only difference is delivery: kernel commands are compiled Go functions, package commands are exec'd entrypoints.

## Why this emerged

The OCaml CLI has two command models — hardcoded variants for built-ins, manifest+entrypoint for packages. v3.37.0 started migrating built-ins to packages (daily, weekly, save). The Go rewrite is the chance to unify from the start.

Operator asked: "why two backing implementations? Why not have the kernel be a package too?" That's the right question. The answer is: it should be.

## Design decisions

- One `Command` interface for all command sources
- Flat 3-tier precedence: kernel > repo-local > package-vendored
- Kernel manifest embedded via `//go:embed`
- Adding a command = one file + one manifest entry (kernel or package, same shape)
- No `init()` magic, no reflection, no classloader trees

## Prior art

- OSGi: framework is a bundle
- JPMS: java.base is a module
- Maven: tool composed of its own artifact model

cnos diverges from Java by avoiding classloader hell, runtime resolution, and reflection magic. Everything is known at startup. Precedence is a flat list, not a tree.

## Open questions

1. Should `cnos.kernel` appear in `packages/index.json`? Leaning no — index is for installable packages.
2. Should kernel commands be overridable? Leaning no — bootstrap-critical.
3. Version stamping: kernel manifest version must match binary version.

## Implementation

- #209 (Phase 2): CLI entrypoint + registry + kernel scaffold
- Design doc: `docs/alpha/agent-runtime/GO-KERNEL-COMMANDS.md`
