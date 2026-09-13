# Version Compatibility and Sources

## CircuitAI Baseline

CircuitAI's vendored header declares:

```cpp
#define ANGELSCRIPT_VERSION        23900
#define ANGELSCRIPT_VERSION_STRING "2.39.0 WIP"
```

Source: `src/lib/angelscript/include/angelscript.h`.

The vendored snapshot was imported by CircuitAI commit `4218f69f` on
2025-10-31. Its core compiler and array sources match official upstream commit
[`365b8fb`](https://github.com/anjo76/angelscript/commit/365b8fb559e9ba075d77cbd5a9a9761a73e6d5c1).
CircuitAI subsequently applied local patches, including changes to
`scriptbuilder`, `scriptdictionary`, AATC, and core/JIT integration. Use the
in-tree source as the authority for those components.

Use **2.39.0 WIP at `365b8fb`** as the compatibility identifier. The WIP label
alone is insufficient because upstream continued changing without changing
that label.

## CircuitAI Engine Configuration

`src/circuit/script/ScriptManager.cpp` configures:

| Setting | CircuitAI value | Author impact |
| --- | --- | --- |
| Unsafe references | Disabled | Do not design around unsafe primitive `&inout` references. |
| Bytecode optimization | Enabled | Code must still be interpreter-correct. |
| Implicit handle types | Disabled | Write handle types and assignment deliberately. |
| Property accessor mode | 3 | Script-created accessors require `property`. |
| Automatic GC | Enabled | Cycles can be collected, but reclamation is not prompt. |
| Compiler warnings | Errors | Eliminate warnings and use exact callback signatures. |
| Script scanner | UTF-8 | UTF-8 source is accepted; identifiers remain ASCII-only. |
| Multiline strings | Enabled | Host permits multiline string literals. |
| Nested context executions | 100 | Limits host/script context re-entry, not script recursion. |
| VM stack size | Unlimited (`0`) | Ordinary recursion has no configured stack-size guard. |
| Call-stack size | Unlimited (`0`) | Prefer iteration for potentially deep traversal. |

Registered SDK/add-on facilities:

- `string` and string utilities;
- `array<T>` as the default array type;
- `dictionary`;
- script math functions;
- AATC containers;
- `CScriptBuilder` preprocessing and `#include`.

Do not assume other bundled add-ons are registered merely because their source
exists under `src/lib/angelscript/add_on/`.

CircuitAI registers AATC `vector`, `list`, `deque`, `set`, `unordered_set`,
`map`, and `unordered_map`. Prefer `array<T>` for indexed sequences,
`dictionary` for dynamic string-keyed values, and typed AATC `map`/`set`
containers when key ordering, uniqueness, or typed associative lookup is part
of the model. AATC is locally patched, so consult the in-tree registration and
implementation before depending on less common methods.

## Feature Boundary

The pinned snapshot includes recent 2.x language features such as:

- `foreach`;
- `using namespace`;
- template functions;
- default script-class copy constructor and assignment behavior;
- deleting generated default/copy operations;
- contextual boolean conversion;
- enum underlying types;
- apostrophe numeric separators such as `1'000'000` (not `1_000_000`).

For broad portability, prefer established 2.x syntax and avoid requiring the
last two WIP features unless the target is explicitly CircuitAI.

## Post-Pin WIP Changes

The current upstream WIP branch includes fixes newer than CircuitAI's pin.
Conservative mitigations for the pinned snapshot:

- Avoid a class and namespace with the same name.
- Prefer explicit namespace qualification in reusable code.
- Avoid placing `foreach` directly inside complicated `switch` control flow.
- Do not rely on const-call validation as a security or correctness boundary.
- Split mixed 64-bit/32-bit arithmetic into typed intermediate values.
- Keep constructor/default-argument expressions simple when they create
  temporary objects.
- Do not assume later host-exception cleanup fixes are present.

These are defensive compatibility rules, not claims that every corresponding
construct fails.

## Core Language vs Host API

AngelScript is embedded. The application decides:

- which object types and methods exist;
- value/reference/ownership behavior of registered types;
- available global functions and properties;
- which add-ons are registered;
- whether exception helpers or assertions exist;
- module loading and include behavior;
- context scheduling and thread safety.

Before using a host API, inspect `RegisterObjectType`,
`RegisterObjectMethod`, `RegisterObjectProperty`, `RegisterGlobalFunction`, and
`RegisterGlobalProperty` calls.

In CircuitAI, a public C++ method is not script-accessible unless it is
registered. Use `doc/angelscript-references.md` for the current binding map.

## Official Sources

Use commit-pinned documentation where exact compatibility matters:

- [Official AngelScript repository](https://github.com/anjo76/angelscript)
- [Pinned upstream commit `365b8fb`](https://github.com/anjo76/angelscript/tree/365b8fb559e9ba075d77cbd5a9a9761a73e6d5c1)
- [Official WIP page](https://www.angelcode.com/angelscript/wip.php)
- [Official 2.x changelog](https://www.angelcode.com/angelscript/changes.php?ver=2)
- [Data types](https://github.com/anjo76/angelscript/blob/365b8fb559e9ba075d77cbd5a9a9761a73e6d5c1/sdk/docs/doxygen/source/doc_script_datatypes.h)
- [Object handles](https://github.com/anjo76/angelscript/blob/365b8fb559e9ba075d77cbd5a9a9761a73e6d5c1/sdk/docs/doxygen/source/doc_script_handle.h)
- [Functions and references](https://github.com/anjo76/angelscript/blob/365b8fb559e9ba075d77cbd5a9a9761a73e6d5c1/sdk/docs/doxygen/source/doc_script_function.h)
- [Classes and interfaces](https://github.com/anjo76/angelscript/blob/365b8fb559e9ba075d77cbd5a9a9761a73e6d5c1/sdk/docs/doxygen/source/doc_script_class.h)
- [Operators](https://github.com/anjo76/angelscript/blob/365b8fb559e9ba075d77cbd5a9a9761a73e6d5c1/sdk/docs/doxygen/source/doc_script_class_ops.h)
- [Property accessors](https://github.com/anjo76/angelscript/blob/365b8fb559e9ba075d77cbd5a9a9761a73e6d5c1/sdk/docs/doxygen/source/doc_script_class_prop.h)
- [Statements and exceptions](https://github.com/anjo76/angelscript/blob/365b8fb559e9ba075d77cbd5a9a9761a73e6d5c1/sdk/docs/doxygen/source/doc_script_statement.h)
- [Garbage collection](https://github.com/anjo76/angelscript/blob/365b8fb559e9ba075d77cbd5a9a9761a73e6d5c1/sdk/docs/doxygen/source/doc_gc.h)
- [Multithreading](https://github.com/anjo76/angelscript/blob/365b8fb559e9ba075d77cbd5a9a9761a73e6d5c1/sdk/docs/doxygen/source/doc_adv_multithread.h)
- [Standard library/add-ons](https://github.com/anjo76/angelscript/blob/365b8fb559e9ba075d77cbd5a9a9761a73e6d5c1/sdk/docs/doxygen/source/doc_script_stdlib.h)
- [Compiling scripts and modules](https://github.com/anjo76/angelscript/blob/365b8fb559e9ba075d77cbd5a9a9761a73e6d5c1/sdk/docs/doxygen/source/doc_compile_script.h)

The official website's generated manual may reflect newer WIP code. Prefer the
commit-pinned documentation links above when the current manual and CircuitAI
behavior differ.

## Feature Verification Checklist

Before recommending a feature:

1. Confirm it exists in upstream commit `365b8fb`.
2. Confirm CircuitAI did not modify the relevant behavior.
3. For add-ons, confirm CircuitAI registers the add-on.
4. For native types, confirm the exact declaration in registration code.
5. Confirm ownership flags (`VALUE`, `REF`, `NOCOUNT`, `NOHANDLE`, GC).
6. Check CircuitAI engine properties that alter syntax or diagnostics.
7. Avoid relying on newer WIP fixes.
8. Validate by loading the script through CircuitAI/BAR.
