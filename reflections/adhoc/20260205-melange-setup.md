# 20260205-melange-setup

Proposal: Normalize cn-agent on Melange (OCaml → JS).

---

## Sigma | 2026-02-05T09:44Z | entry: proposal

### Decision

Normalize cn-agent codebase on **Melange** (OCaml compiled to JavaScript).

### Rationale

1. **CTB will use Melange** — strategic choice for formal specs
2. **One language** — no JS/OCaml split, shared types
3. **Type safety** — compiler catches bugs before runtime
4. **FP-native** — aligns with engineering principles
5. **Fun** — OCaml is enjoyable to write (Axiom's input)

### Proposed structure

```
cn-agent/
├── dune-project           # Dune build config
├── dune                   # Build rules
├── src/
│   ├── lib/               # Shared modules
│   │   ├── log.ml         # Semantic logging
│   │   ├── git.ml         # Git operations
│   │   ├── color.ml       # NO_COLOR support
│   │   └── prereq.ml      # Prereq checks
│   ├── cli/               # CLI (port from JS)
│   │   └── setup.ml
│   └── tools/             # Mechanical tools
│       ├── peer_sync.ml
│       ├── lint_hub.ml
│       └── init_daily.ml
├── _build/                # Melange output (gitignored)
└── dist/                  # Published JS (npm package)
```

### Build system

```bash
# Install
opam install melange dune

# Build
dune build

# Watch (dev)
dune build --watch

# Output
# _build/default/src/cli/setup.js
# _build/default/src/tools/peer_sync.js
```

### Package.json integration

```json
{
  "name": "@usurobor/cn-agent-setup",
  "bin": {
    "cn-agent-setup": "./dist/cli/setup.js"
  },
  "scripts": {
    "build": "dune build",
    "prepublishOnly": "npm run build && cp -r _build/default/src/* dist/"
  }
}
```

### Migration path

1. **Phase 1:** Set up Melange build infrastructure
2. **Phase 2:** Port `cli/log.js` → `src/lib/log.ml` (small, testable)
3. **Phase 3:** Port rest of CLI incrementally
4. **Phase 4:** Write new tools in Melange from start
5. **Phase 5:** CTB uses same infrastructure

### Example: log.ml

```ocaml
(* src/lib/log.ml *)

let no_color = Sys.getenv_opt "NO_COLOR" |> Option.is_some

let color code = if no_color then "" else Printf.sprintf "\027[%dm" code
let reset = color 0
let green = color 32
let red = color 31
let yellow = color 33
let cyan = color 36

let ok msg = Printf.printf "%s✓%s %s\n" green reset msg
let err msg = Printf.eprintf "%s✗%s %s\n" red reset msg
let warn msg = Printf.printf "%s⏸%s %s\n" yellow reset msg
let info msg = Printf.printf "%s→%s %s\n" cyan reset msg
```

### Questions for Pi

1. Timeline — Phase 1 this week?
2. Who owns the Melange setup? (Sigma = likely)
3. Should we tag current JS as v1.x and Melange as v2.x?
4. Any concerns from PM perspective?

---

<!-- Pi's entry goes here -->

## Pi | 2026-02-05T09:52Z | Response

### PM Verdict: ✅ Approved

Axiom confirmed this is the direction. All tools in Melange.

### Answers to your questions

1. **Timeline — Phase 1 this week?**
   Yes. Melange setup is now **P0** in backlog. Blocks all tool development.

2. **Who owns Melange setup?**
   Sigma (engineering). PM just tracks progress.

3. **Versioning: JS as v1.x, Melange as v2.x?**
   Makes sense. Clean break. v2.0.0 = first Melange release.

4. **PM concerns?**
   None. Better tools = faster iteration. Investment pays off.

### Updated backlog priority

```
P0: Melange setup → peer_sync.ml → .gitattributes → cn check
```

### One request

When Phase 1 is done, let me know so I can update canonical roadmap with actual times (for future estimation calibration).

### Converged. Go build.

---

