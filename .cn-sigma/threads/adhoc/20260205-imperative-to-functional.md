# Imperative to Functional: A Learning Thread

**Date:** 2026-02-05  
**Context:** Refactoring peer-sync from imperative to functional OCaml  
**Triggered by:** usurobor's feedback: "your code has too much if/else logic for my taste"

---

## What Happened

Wrote `peer_sync.ml` in imperative style:
- if/else chains for control flow
- `ref` for accumulating results
- Sequential statements with intermediate variables
- Nested begin/end blocks

User called it out. Refactored to functional style.

---

## The Before (Imperative)

```ocaml
let alerts = ref [] in

List.iter (fun peer_name ->
  if Fs.exists_sync repo_path then begin
    fetch_peer repo_path;
    let branches = check_inbound_branches repo_path my_name in
    if List.length branches > 0 then begin
      alerts := (peer_name, branches) :: !alerts
    end
  end else
    print_endline (Printf.sprintf "  Skip %s" peer_name)
) peers;

if List.length !alerts > 0 then begin
  (* ... *)
end
```

**Problems:**
- Mutable state (`ref`)
- Control flow via if/else
- Side effects mixed with logic
- Hard to test individual pieces

---

## The After (Functional)

```ocaml
type sync_result = 
  | Fetched of string * string list
  | Skipped of string * string

let sync_peer my_name peer =
  match Fs.exists_sync peer.repo_path with
  | false -> Skipped (peer.name, "not found")
  | true ->
      let _ = run_cmd (...) in
      Fetched (peer.name, find_inbound_branches peer.repo_path my_name)

let results = peers |> List.map (sync_peer my_name)
let alerts = collect_alerts results
```

**Improvements:**
- Types encode outcomes (`sync_result`)
- Pattern matching is exhaustive
- Pure functions (testable)
- Data flows through pipelines

---

## Key Learnings

### 1. Pattern Matching > If/Else
If/else is a question: "is this true?"
Pattern matching is a decomposition: "what shape is this data?"

The compiler enforces exhaustiveness. Missing cases are errors.

### 2. Types Encode Meaning
`sync_result` isn't just data — it's documentation. 
`Fetched` vs `Skipped` is semantic, not just `(bool, string list)`.

### 3. Refs Are a Smell
Every `ref` is an opportunity for a fold or a map.
Accumulation patterns should be explicit, not hidden in mutation.

### 4. Pipelines Show Data Flow
```ocaml
input |> parse |> validate |> transform |> output
```
Each step is visible. Debugging is "which stage failed?"

### 5. Side Effects at the Boundary
Pure functions in the middle. I/O at the edges.
This is why we split `peer_sync_lib.ml` (pure) from `peer_sync.ml` (FFI).

---

## The Meta-Lesson

I defaulted to imperative because it's familiar. 
Imperative is "do this, then this, then this."
Functional is "this data becomes that data."

**The language you think in shapes what you build.**

OCaml forces functional patterns. That's not a constraint — it's a feature.

---

## Outcome

- Refactored code: 111 lines, pattern matching, pure functions
- Added 12 ppx_expect tests (couldn't have tested the imperative version easily)
- Created `mindsets/FUNCTIONAL.md` to codify the patterns
- CI now runs OCaml tests alongside Node tests

---

## Quote to Remember

> *"The purpose of abstraction is not to be vague, but to create a new semantic level in which one can be absolutely precise."* — Dijkstra

---

**Status:** Learning integrated. Functional is now default.
