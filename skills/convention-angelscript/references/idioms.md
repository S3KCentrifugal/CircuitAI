# AngelScript Idioms

These idioms target CircuitAI's AngelScript 2.39.0 WIP snapshot while remaining
conservative enough for most recent AngelScript 2.x hosts.

## Guard Clauses

Prefer early validation over nested conditionals:

```angelscript
Result@ Evaluate(Request@ request)
{
    if (request is null) {
        return null;
    }
    if (!request.enabled) {
        return null;
    }
    return Compute(request);
}
```

For CircuitAI borrowed units, retain an ID and reacquire:

```angelscript
CCircuitUnit@ ResolveUnit(Id id)
{
    if (id < 0) {
        return null;
    }
    return ai.GetTeamUnit(id);
}
```

## Explicit Handle Rebinding

Object assignment and handle assignment have different meanings:

```angelscript
Node@ first = FindNode("first");
Node@ second = FindNode("second");

first = second;       // Assign second's value/state to first where opAssign applies.
@first = @second;     // Rebind first to the same object as second.
```

Use `@` for rebinding whenever aliasing matters. For array elements containing
handles:

```angelscript
array<Node@> nodes(1);
Node@ node = Node();
@nodes[0] = @node;
```

## Identity and Equality

```angelscript
if (left is right) {
    // Same object.
}

if (left !is null && right !is null && left == right) {
    // Equal according to opEquals/opCmp.
}
```

Use `is` and `!is` for handles and null. Use `==` and `!=` for value semantics.

## Try-Style Lookups

Return success separately from the value when zero, empty, or null can be a
valid result:

```angelscript
bool TryGetLimit(
    const dictionary& in limits,
    const string& in name,
    int& out limit)
{
    limit = 0;
    return limits.get(name, limit);
}
```

Always initialize an `out` parameter and assign it on every normal return path.

## Typed Configuration Over Dynamic Dictionaries

Use a class when the schema is fixed:

```angelscript
final class EconomyPolicy
{
    float minMetalIncome = 8.0f;
    float minEnergyIncome = 120.0f;
    bool allowExpansion = true;
}
```

Use `dictionary` when keys are dynamic, supplied by the host, or intentionally
open-ended. Convert dynamic input to a typed policy near the boundary.

## Named Argument Objects

When a function accumulates many same-typed parameters, replace positional
arguments with a request object:

```angelscript
final class BuildRequest
{
    string unitName;
    AIFloat3 position;
    int priority = 0;
    bool active = true;
}

bool CanBuild(const BuildRequest& in request)
{
    return request.unitName.length() > 0
        && request.position.IsInMap()
        && request.priority >= 0;
}
```

This is safer than several adjacent `int`, `float`, or `bool` parameters.

## Pure Predicates and Scoring

Extract policy from effects:

```angelscript
bool IsAffordable(
    float currentMetal,
    float reserveMetal,
    float unitCost)
{
    return currentMetal - unitCost >= reserveMetal;
}

float StrategicScore(
    float value,
    float travelTime,
    float threat)
{
    return value - travelTime * 0.1f - threat * 0.5f;
}
```

Call host APIs once, then pass snapshots to pure functions:

```angelscript
const float metal = aiEconomyMgr.metal.current;
const float reserve = 500.0f;
const float cost = def.costM;

if (IsAffordable(metal, reserve, cost)) {
    Queue(def);
}
```

## Filter, Map, and Fold Without Allocation Surprises

AngelScript's standard array add-on does not provide universal functional
`map`, `filter`, and `reduce` methods. Implement named typed helpers.

Pure filter:

```angelscript
array<int> FilterPositive(const array<int>& in values)
{
    array<int> result;
    result.reserve(values.length());
    for (uint i = 0; i < values.length(); ++i) {
        const int value = values[i];
        if (value > 0) {
            result.insertLast(value);
        }
    }
    return result;
}
```

Bind a returned reference container to a handle when another array copy is not
needed:

```angelscript
array<int>@ positive = FilterPositive(values);
```

Pure map:

```angelscript
array<float> SquareAll(const array<float>& in values)
{
    array<float> result(values.length());
    for (uint i = 0; i < values.length(); ++i) {
        result[i] = values[i] * values[i];
    }
    return result;
}
```

Fold:

```angelscript
float Sum(const array<float>& in values)
{
    float total = 0.0f;
    for (uint i = 0; i < values.length(); ++i) {
        total += values[i];
    }
    return total;
}
```

These are ideal for setup and modest collections. Fuse stages into one loop or
reuse an output buffer in frequently invoked code.

## Output-Buffer Transformation

Use controlled mutation to avoid temporary arrays:

```angelscript
void CollectPositive(
    const array<int>& in values,
    array<int>& inout result)
{
    result.resize(0);
    result.reserve(values.length());
    for (uint i = 0; i < values.length(); ++i) {
        if (values[i] > 0) {
            result.insertLast(values[i]);
        }
    }
}
```

Document whether the function clears or appends to the output.
Do not use `array<T>& out` for buffer reuse: object `&out` arguments are
default-constructed temporaries and copied back after the function returns.
With unsafe references disabled, `&inout` is valid only for object types that
support handles.

## Arg-Max Instead of Sort

Do not sort an entire collection to select one best item:

```angelscript
int FindBestIndex(const array<float>& in scores)
{
    if (scores.length() == 0) {
        return -1;
    }

    uint best = 0;
    for (uint i = 1; i < scores.length(); ++i) {
        if (scores[i] > scores[best]) {
            best = i;
        }
    }
    return int(best);
}
```

This is linear, allocation-free, and deterministic for ties.

## Funcdef Strategy

Use a funcdef to inject behavior:

```angelscript
funcdef bool CandidatePredicate(const Candidate& in candidate);

array<Candidate@> SelectWhere(
    const array<Candidate@>& in candidates,
    CandidatePredicate@ predicate)
{
    array<Candidate@> result;
    result.reserve(candidates.length());

    for (uint i = 0; i < candidates.length(); ++i) {
        Candidate@ candidate = candidates[i];
        if (candidate !is null && predicate(candidate)) {
            result.insertLast(candidate);
        }
    }
    return result;
}
```

Anonymous functions do not capture surrounding locals. Use a named function,
an object delegate, or an explicit context object.

`const array<Candidate@>& in` protects the container, not the `Candidate`
objects referenced by its elements. Bind an element as
`const Candidate@ candidate = candidates[i];` when mutation is forbidden.

## Interface-Based Policies

```angelscript
interface IPolicy
{
    Decision Evaluate(const Snapshot& in snapshot) const;
}

final class EconomyPolicy : IPolicy
{
    Decision Evaluate(const Snapshot& in snapshot) const override
    {
        return snapshot.energyStalling
            ? Decision::BUILD_ENERGY
            : Decision::NONE;
    }
}
```

Mark overrides explicitly. Prefer `final` when inheritance is not required.

## Exhaustive State Transitions

```angelscript
State NextState(State current, const Event& in event)
{
    switch (current) {
        case State::IDLE:
            return event.hasWork ? State::ACTIVE : State::IDLE;
        case State::ACTIVE:
            return event.failed ? State::RECOVERING : State::ACTIVE;
        case State::RECOVERING:
            return event.ready ? State::IDLE : State::RECOVERING;
        default:
            return State::IDLE;
    }
}
```

Enum values are integer-backed and may contain unexpected values. Keep a
defensive `default`.

## Snapshot Before Structural Mutation

Do not delete dictionary entries while iterating the dictionary directly:

```angelscript
array<string>@ keys = values.getKeys();
for (uint i = 0; i < keys.length(); ++i) {
    if (ShouldRemove(keys[i])) {
        values.delete(keys[i]);
    }
}
```

Likewise, avoid adding/removing array elements during `foreach`. Use indexed
iteration with deliberate index management or collect changes separately.

## Safe Downcast

```angelscript
IBuilderTask@ builderTask = cast<IBuilderTask>(task);
if (builderTask is null) {
    return;
}

const AIFloat3 position = builderTask.GetBuildPos();
```

A failed reference cast returns null. Never use derived members before checking.

## Factory Function for Valid Construction

Centralize defaults and invariants:

```angelscript
BuildOrder MakeEnergyOrder(
    const string& in unitName,
    const AIFloat3& in position)
{
    BuildOrder order;
    order.unitName = unitName;
    order.position = position;
    order.priority = Priority::NORMAL;
    order.active = true;
    return order;
}
```

This is especially useful for host-registered POD request types whose default
field state may not express a valid operation.

## Cached Lookup With Explicit Invalidation

Cache only stable values:

```angelscript
Id cachedDefId = -1;

Id ResolveDefId()
{
    if (cachedDefId >= 0) {
        return cachedDefId;
    }

    CCircuitDef@ def = ai.GetCircuitDef("armsolar");
    cachedDefId = (def is null) ? -1 : def.id;
    return cachedDefId;
}
```

For ephemeral native objects, cache IDs rather than borrowed handles. State
when and why a cache becomes invalid.

## Property Accessors

CircuitAI requires the `property` decorator for script-created property
accessors:

```angelscript
class Range
{
    private float value = 0.0f;

    float get_length() const property
    {
        return value;
    }

    void set_length(float next) property
    {
        value = next < 0.0f ? 0.0f : next;
    }
}
```

Use property syntax only for cheap, unsurprising access. Prefer an explicit
method for expensive computation or effects.

## Explicit Namespace Qualification

```angelscript
Task::Priority priority = Task::Priority::HIGH;
```

Qualified names improve reusable code and avoid name-resolution issues in the
pinned WIP snapshot. Avoid defining a namespace and class with the same name.

## Deliberate Cleanup

Garbage collection timing is nondeterministic:

```angelscript
class Subscription
{
    bool active = true;

    void close()
    {
        if (!active) {
            return;
        }
        active = false;
        Unsubscribe();
    }

    ~Subscription()
    {
        // Last-resort cleanup only; do not rely on prompt execution.
    }
}
```

Expose an idempotent cleanup method for resources that must be released at a
specific time.
