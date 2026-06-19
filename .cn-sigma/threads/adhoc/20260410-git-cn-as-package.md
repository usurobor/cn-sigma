# git-cn as a Package — Design Thread

**Date:** 2026-04-10
**Status:** direction confirmed, implementation deferred

## What git-cn is

A focused Git-native transport / sync / packet / receipt tool. Performance-sensitive, Rust is a reasonable implementation language.

## What git-cn is not

Not part of the Go kernel. Not a reason to make the kernel polyglot.

## Package identity

**`cnos.transport.git`** — capability-oriented naming, matching `cnos.net.http` style.

Preferred over `cnos.git` because the primary purpose is A2A / sync / packet transport, not general Git tooling.

## Surface model

One package, two surfaces:

1. **Command surface** — operator/direct use
   - `commands/git-cn/cn-git-cn` (or `cn git sync`, `cn git packet`, etc.)
   - One-shot, synchronous, exact-dispatch

2. **Extension/provider surface** — runtime use
   - `extensions/cnos.transport.git/`
   - Could be one-shot subprocess or long-lived provider
   - If long-lived: versioned subprocess protocol (Terraform/go-plugin model)

## Decision point

- If git-cn is mostly a one-shot tool invoked synchronously → treat as package command
- If it becomes a long-lived transport provider with richer semantics → treat as extension/provider with versioned subprocess protocol

Start as command. Promote to provider when the usage pattern demands it.

## Platform artifacts

git-cn will be a native binary. Package index needs os/arch artifact resolution:
- `cnos.transport.git-3.x.0-linux-amd64.tar.gz`
- `cnos.transport.git-3.x.0-darwin-arm64.tar.gz`

This is the first package that forces platform-awareness in the package system. Design it when git-cn is ready to ship, not before.
