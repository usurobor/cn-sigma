# Polyglot Package Architecture — Design Thread

**Date:** 2026-04-10
**Status:** design direction confirmed, doc revision pending

## Core insight

cnos should be monolingual only in the kernel, and polyglot at the package boundary.

- **Go for the kernel**: package manager, daemon, web surface, registries, command dispatch, runtime contract, doctor/status/update
- **Any language for package-provided commands and extensions**: the package is the distribution unit, the implementation language is an implementation detail

## The git-cn case

git-cn (Git-native transport / sync / packet / receipt tool) is the first concrete case of a non-Go package binary. Rust is reasonable here — performance-sensitive, focused, not kernel.

**Recommended shape:** `cnos.transport.git` — a first-party package, not part of the kernel. Exposed as command + extension/provider depending on usage pattern:
- Command surface: one-shot operator use (`cn git sync`, `cn git packet`)
- Extension/provider surface: runtime-invoked transport capability

One package, multiple surfaces. Same binary, invoked two ways.

## Two execution contracts needed

### 1. Command execution contract
For package/repo-local commands:
- Exact-dispatch by name
- argv/stdin/stdout/stderr/env contract
- Exit code semantics
- No hidden runtime coupling

This is the Git/Cargo/npm model.

### 2. Provider/extension contract
For long-lived/runtime capabilities:
- Versioned protocol
- Subprocess handshake
- Capability declaration
- Health / error / receipt semantics

This is the Terraform/go-plugin model.

## Platform-aware artifacts

If packages can contain native binaries (Go, Rust, etc.), the package index eventually needs platform-specific artifact resolution (os/arch). Simplest v1:
- Package metadata stays logical (name, version, content classes)
- Index resolves the right artifact for os/arch
- Install places the selected artifact in the vendor tree

Not needed immediately, but the design should acknowledge it.

## What changes in existing docs

1. **State the polyglot boundary explicitly**: "The kernel is Go, but package-provided commands and extensions may be implemented in any language, provided they satisfy the cnos command/provider contract."
2. **Define command execution contract** (argv/stdio/exit code)
3. **Define provider/extension contract** (versioned subprocess protocol)
4. **Acknowledge platform-aware artifacts** in package-system docs

## Architecture summary

| Layer | Language | Owns |
|-------|----------|------|
| Kernel | Go | Policy, registries, contracts, bootstrap, runtime surfaces |
| Packages | Any | Skills, commands, orchestrators, extensions |
| git-cn | Rust (likely) | `cnos.transport.git` — command + provider |

## Prior art

- Git: built-in + external `git-foo` subcommands (language-agnostic at dispatch)
- Cargo: `cargo-foo` external subcommands
- npm: `bin` field exposes executables regardless of implementation
- Terraform: provider plugins as versioned subprocess protocol (go-plugin model)
- HashiCorp plugin system: host launches subprocess, speaks versioned protocol

## Relationship to existing design docs

- GO-KERNEL-COMMANDS.md v1.2: already supports exec-backed commands for package/repo-local — this is the polyglot seam
- HYBRID-LLM-ROUTING.md: LLM backends as capability providers — same provider model applies to transport
- Alpha package-system docs: content classes already language-agnostic
