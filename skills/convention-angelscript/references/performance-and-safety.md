# Performance, Memory, and Safety

## Functional Style by Execution Frequency

Use functional style selectively:

| Context | Preferred approach |
| --- | --- |
| Initialization/configuration | Pure transformations and fresh return values |
| Small policy decisions | Pure functions and immutable snapshots |
| Infrequent event callbacks | Clarity first; modest temporary allocation is acceptable |
| Periodic updates | Pure scalar decisions; reuse collection storage |
| Per-unit/per-frame loops | Fused loops, cached lookups, controlled local mutation |
| Native side effects | Imperative shell with explicit ordering and error handling |

Functional programming is a design tool, not a requirement to allocate a new
container at every stage.

## Allocation Discipline

AngelScript script classes and registered reference containers use handles and
reference counting; cycles are reclaimed by garbage collection.

- Reserve arrays before predictable growth.
- Reuse scratch arrays in hot code when ownership is unambiguous.
- Fuse `filter -> map -> reduce` into one loop when intermediate arrays are not
  otherwise useful.
- Avoid constructing dictionaries in per-frame loops.
- Avoid repeated string concatenation for disabled or low-priority logging.
- Break unneeded cyclic handle graphs by assigning handles to `null`.
- Do not rely on destructors running promptly.

Example fused reduction:

```angelscript
float SumSafeThreat(const array<UnitView@>& in units)
{
    float total = 0.0f;
    for (uint i = 0; i < units.length(); ++i) {
        const UnitView@ unit = units[i];
        if (unit !is null && unit.active && unit.threat > 0.0f) {
            total += unit.threat;
        }
    }
    return total;
}
```

## Data Types

- Prefer `int` and `uint` for ordinary counters and indexes. The VM is optimized
  for 32-bit values; `int8` and `int16` locals do not inherently save work.
- Use `uint` for array indexes when comparing directly with `length()`.
- Convert deliberately at signed/unsigned boundaries.
- Use `float` unless the domain needs `double`.
- Split complex expressions that mix 32-bit and 64-bit arithmetic into
  explicitly typed intermediate values because the pinned WIP predates a later
  optimizer fix in this area.

```angelscript
const uint count = values.length();
if (count > uint(maxCount)) {
    return;
}
```

## Distance and Geometry

When only ordering or threshold comparison matters, compare squared distance:

```angelscript
const float maxDistance = 512.0f;
if (origin.SqDistance2D(target) <= maxDistance * maxDistance) {
    Select(target);
}
```

Avoid square roots in large candidate scans. Compute the real distance only
for the selected result or user-facing output.

## Native Boundary Costs

Treat host calls as potentially more expensive and less optimizable than local
script arithmetic:

1. Read native state once.
2. Convert it into a compact script snapshot.
3. Run pure scoring/filtering over the snapshot.
4. Commit the selected effect through the host API.

Do not cache borrowed host handles unless the host guarantees their lifetime.
For CircuitAI `CCircuitUnit`, store `Id` and reacquire with
`ai.GetTeamUnit(id)`.

## Handles and Aliasing

Reference types can share mutable state:

```angelscript
Config@ a = Config();
Config@ b;
@b = @a;
b.enabled = false; // Also observed through a.
```

To preserve functional reasoning:

- pass read-only handles as `const T@`;
- remember that `const array<T@>& in` does not make each referenced `T` const;
  bind elements to `const T@` before use when mutation is forbidden;
- keep mutation in a small owner;
- return values for small immutable data;
- document functions that retain a passed handle;
- explicitly clone when independent mutable state is required.

Array object assignment copies elements, but contained handles remain aliases.
Handle assignment aliases the array object itself:

```angelscript
array<Node@> source;
array<Node@> copied = source; // Separate array, same referenced Node objects.

array<Node@>@ alias;
@alias = @source;             // Same array object.
```

## Borrowed and Non-Counted Host Objects

A host may register a reference type with `asOBJ_NOCOUNT`. Script handles then
do not extend native lifetime.

- Do not retain borrowed handles across callbacks, scheduled jobs, or state
  transitions unless explicitly guaranteed.
- Check the handle immediately before use.
- Prefer stable IDs and host lookups.
- Never access borrowed handles from background execution without a documented
  host guarantee.

CircuitAI-specific lifetime details are documented in
`doc/angelscript-references.md`.

## Container Safety

### Arrays

- Indexes are zero-based.
- Out-of-range access raises a script exception.
- Check empty arrays before computing `length() - 1`.
- Use `findByRef` for object identity and `find` for value equality.
- Do not structurally modify an array during `foreach`.

```angelscript
if (values.length() == 0) {
    return -1;
}
return AiRandom(0, int(values.length()) - 1);
```

### Dictionaries

- `get` returns false for missing or type-incompatible values.
- Non-const indexing can insert a missing key.
- Iteration order is unspecified.
- Snapshot keys before deleting entries.
- Prefer typed storage when keys are known at compile time.

```angelscript
array<string>@ keys = values.getKeys();
for (uint i = 0; i < keys.length(); ++i) {
    const string key = keys[i];
    int value;
    if (values.get(key, value) && value <= 0) {
        values.delete(key);
    }
}
```

## Exceptions and Recovery

Core runtime failures include null dereference, division by zero, and array
bounds violations. `try/catch` is language syntax, but `throw`,
`getExceptionInfo`, and `assert` depend on host registration.

- Prevent predictable failures with guards.
- Catch only where the caller can recover or add useful context.
- Never use an empty catch block.
- Do not invent a success-shaped fallback after state corruption.
- In CircuitAI, use logging and explicit failure paths; the exception helper
  routines are not registered by the primary engine setup.

```angelscript
float SafeRatio(float numerator, float denominator, float fallback)
{
    if (denominator == 0.0f) {
        return fallback;
    }
    return numerator / denominator;
}
```

## Initialization and Destruction

- Initialize every primitive local before reading it.
- Give members explicit defaults.
- Mark one-argument conversion constructors `explicit` unless conversion is
  intentionally implicit.
- Avoid virtual calls from constructors.
- Do not rely on destructor timing for deterministic cleanup.
- Make explicit cleanup methods idempotent.

Uninitialized primitive locals may contain unspecified values.

## Globals and Initialization Order

Global initialization can become order-sensitive across included script
sections.

- Prefer constants and simple immutable definitions at global scope.
- Initialize dependent state from an explicit `Init` or `AiMain` function.
- Avoid hidden native calls in complex global initializers.
- Keep global mutable state in a clearly owned namespace or controller.
- Reset state explicitly when scripts can be reloaded.

## Concurrency

AngelScript contexts are execution units; the host controls threading.
Language-level arrays, dictionaries, globals, and registered objects are not
automatically thread-safe.

- Never share one context between simultaneous executions.
- Do not mutate module globals from parallel jobs without host-provided
  synchronization.
- Pass copied or script-owned immutable input into workers.
- Return a result for the main thread to commit.
- Do not call game-engine managers from a worker unless explicitly documented
  as thread-safe.
- Keep garbage-collection behavior in mind when creating cross-thread cycles.

For CircuitAI `AiRun`, perform independent computation in the worker and native
effects in its returned finish callback.

## Recursion

CircuitAI does not cap ordinary script recursion: both maximum stack size and
maximum call-stack size are configured as unlimited. Its limit of 100 applies
to nested context executions caused by host/script re-entry, not
script-to-script call depth. Prefer iterative traversal for potentially deep
graphs or trees.

```angelscript
void Walk(Node@ root)
{
    array<Node@> stack;
    if (root !is null) {
        stack.insertLast(root);
    }

    while (stack.length() > 0) {
        Node@ node = stack[stack.length() - 1];
        stack.removeLast();
        Visit(node);
        node.AppendChildrenTo(stack);
    }
}
```

## Profiling and Optimization Order

1. Verify correctness under the interpreter.
2. Measure the actual hot callback.
3. Reduce algorithmic complexity.
4. Reduce native calls and allocations.
5. Reuse storage where safe.
6. Cache only with a clear invalidation rule.
7. Re-measure.

Do not make correctness depend on JIT behavior. CircuitAI can be compiled with
or without its AngelScript JIT.

## Hot-Path Review

- [ ] Is this called per frame, periodic update, per unit, or only at setup?
- [ ] Can native values be read once?
- [ ] Can repeated lookup become an indexed array or stable ID?
- [ ] Can several collection passes be fused?
- [ ] Can distance comparisons stay squared?
- [ ] Can temporary arrays/dictionaries be removed or reused?
- [ ] Is logging gated before formatting?
- [ ] Does caching have explicit invalidation?
- [ ] Does controlled mutation materially reduce cost?
- [ ] Has the optimized form been measured?
