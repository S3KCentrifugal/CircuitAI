# `barb5` change log

## Review scope

This document covers every commit reachable from `barb5` after 2025-12-01, from
`d1e2f713` through `30e4297e`.

- **28 commits reviewed**
- **211 paths changed across the final branch diff**
- **2,304 insertions and 1,484 deletions**
- **Comparison base:** `992163382bc59cf49ba5b84d4bb31ca2b9fd6da9`
- **Reviewed tip:** `30e4297e68942b5da4a8868cae9c467077243fe5`

The review followed each commit diff, including changes later revised or reverted.
Dates below use author dates; `0f16bed3` was authored on 2026-06-08 but committed on
2026-06-28, and `f2cc1015` was authored on 2026-07-06 but committed on 2026-07-08.

## Highlights

| Area | User-visible impact |
|---|---|
| AngelScript | Adds typed task classes, task lifecycle controls, polygons, factory tuning, military-response tuning, water-hazard configuration, and Tracy profiling. |
| Combat | Large-army threat ranges adapt to enemy count; SuperTask target selection and weapon estimates are more reliable. |
| Economy | Factory configuration moves into `CFactoryManager`; early economy, category limits, per-unit energy-task counts, and factory placement are improved. |
| Movement | Failed path requests stop units instead of sending them to random positions; distant orders use fewer waypoints; move-state behavior is configurable. |
| Tasks | Patrol logic is shared across builders and static constructors; builder auto-abort can be disabled; `NO_DISRUPT` protects selected units. |
| Geometry | Geometry helpers move from `utils` to `geom`; polygons become ref-counted script objects; `CRegion` ownership is corrected. |
| Platforms | MSVC x64 and Apple ARM64 now compile the AngelScript calling-convention assembly required for native calls. |
| Lua/Recoil | Spring API bucket migration is retained through compatibility aliases after the direct split was reverted. |

## Compatibility notes

1. **AngelScript task members moved to their real types.** Scripts that accessed
   builder-only methods through `IUnitTask` must cast to `IBuilderTask`.
2. **`GetTierWeights()` may return `null`.** The first implementation returned an
   empty array for an unknown combination; `ce73066f` changed this to `null`.
3. **`GetModOptions()` now returns a shared cached dictionary.** Mutating it affects
   later callers.
4. **Military response objects are borrowed views.** `SResponseInfo` and `SVsInfo`
   use `asOBJ_NOCOUNT`; do not retain them after their manager or backing vector changes.
5. **Geometry moved from `utils` to `geom`.** Out-of-tree C++ callers must update
   qualified names.
6. **Many implementation classes are now `final`.** Out-of-tree subclasses will no
   longer compile.
7. **`CRegion` is non-copyable.** `CSetupData` now owns heap-allocated regions while
   `CAllyTeam` keeps non-owning pointers; the setup data must outlive ally-team access.
8. **The commented template in `data/config/behaviour.json` was shortened.** No active
   defaults were removed, but users looking there for schema examples now need to
   consult a populated profile such as `data/config/dev/behaviour.json`.

## AngelScript integration

### Direct AngelScript registration replaces `asbind20`

Commit `869f96cb` removes the MinGW-problematic `asbind20` registration layer. The
script API is intended to stay equivalent, but registrations now state exact overloads
and calling conventions.

**Before**

```cpp
#include "asbind20/asbind.hpp"
#include "asbind20/operators.hpp"
```

**After**

```cpp
r = engine->RegisterObjectMethod(
    "AIFloat3",
    "float SqDistance2D(const AIFloat3& in) const",
    asMETHODPR(float3, SqDistance2D, (const float3&) const, float),
    asCALL_THISCALL);
```

This improves MinGW portability, but overloaded C++ methods must now be registered
with the exact signature. Commit `9ea0e457` specifically corrected
`SqDistance2D` from `asMETHOD` to `asMETHODPR`.

### Task types now mirror the C++ hierarchy

Commit `9eafe08d` introduces script-visible `IBuilderTask`, `IFighterTask`, and
`CSuperTask`, plus reference-safe casts between them.

**Before**

```angelscript
IUnitTask@ task = unit.task;
Type type = task.GetBuildType();
```

Builder members were registered directly on `IUnitTask`, even though not every unit
task is a builder task.

**After**

```angelscript
IUnitTask@ task = unit.task;
IBuilderTask@ builderTask = cast<IBuilderTask>(task);
if (builderTask !is null) {
    Type type = builderTask.GetBuildType();
}

CSuperTask@ superTask = cast<CSuperTask>(task);
if (superTask !is null) {
    superTask.SetTargetPos(AIFloat3(1024.0f, 0.0f, 1024.0f));
}
```

Successful native casts call `AddRef()`. Builder-specific properties now live on
`IBuilderTask`; fighter-specific methods live on `IFighterTask`.

### Script task control and movement

Commit `0ef36267` adds lifecycle methods, movement state control, terrain helpers,
and a static-constructor patrol task.

**Before**

```angelscript
// A script could inspect a task, but could not directly finish or abort it.
```

**After**

```angelscript
task.Abort();
task.Done();
unit.SetMoveState(2);  // ROAM

float diagonal = AiTerrainDiagonal();
AIFloat3 center = AiTerrainCenter();  // Named AITerrainCenter before 9875f1b3.
SServSTask patrol = TaskS::Patrol(priority, center, timeout);
```

Calling `Abort()` or `Done()` delegates directly to the native task manager, so scripts
must not call either method on stale or unmanaged handles.

### Water hazards and builder interruption

Commit `32c11e37` exposes harmful-water configuration. Commit `bd272eb3` adds
script control over builder auto-abort and the `NO_DISRUPT` attribute.

**Before**

```angelscript
// Water danger came only from the engine's water-damage value.
// Builder tasks always used native automatic-abort rules.
```

**After**

```angelscript
dictionary@ modOptions = aiSetupMgr.GetModOptions();
aiSetupMgr.SetWaterHarmful(string(modOptions["map_waterislava"]) == "1");

IBuilderTask@ task = cast<IBuilderTask>(unit.task);
if (task !is null) {
    task.canAutoAbort = false;
}

TypeMask protectedBuilder = Unit::Attr::NO_DISRUPT;
```

`canAutoAbort` defaults to `true`, preserving old behavior unless a script opts out.

### Correct `AIFloat3` value registration

Commit `9875f1b3` fixes a critical ABI mismatch. Registering the base `float3` traits
omitted the copy-constructor flag expected by `AIFloat3`, which could make
AngelScript invoke returned-vector methods with `this == nullptr`.

**Before**

```cpp
engine->RegisterObjectType(
    "AIFloat3",
    sizeof(float3),
    flags | asGetTypeTraits<float3>());
```

**After**

```cpp
engine->RegisterObjectType(
    "AIFloat3",
    sizeof(AIFloat3),
    flags | asGetTypeTraits<AIFloat3>());
```

The same commit normalizes `AITerrainCenter()` to `AiTerrainCenter()`.

### Geometry becomes scriptable

Commit `8203ca30` makes `CPolygon` a ref-counted AngelScript object and adds
`AIFloat3.IsInRange()`. Commit `edeab2e0` adds vertex access.

**Before**

```angelscript
// Polygon construction and range convenience methods were unavailable.
```

**After**

```angelscript
array<AIFloat3> vertices = {
    AIFloat3(0, 0, 0),
    AIFloat3(100, 0, 0),
    AIFloat3(100, 0, 100)
};

CPolygon@ polygon = CPolygon(vertices);
bool inside = polygon.ContainsPoint(AIFloat3(50, 0, 25));
bool nearby = vertices[0].IsInRange(vertices[1], 128.0f);
float area = polygon.area;
array<AIFloat3>@ copy = polygon.GetVerts();
polygon.Scale(1.25f);
polygon.Extend(32.0f);
```

`Scale()` multiplies distance from the polygon center. `Extend()` moves every vertex
outward by a fixed distance. `GetVerts()` returns a copied script array, not direct
mutable access to native storage.

### Factory strategy can be tuned at runtime

Commits `fca11d02` and `ce73066f` expose tier weights and factory importance.

**Before**

```angelscript
// Factory tier weights and selection importance were configuration-only.
```

**After**

```angelscript
array<float>@ weights = aiFactoryMgr.GetTierWeights(factoryDef, surface, tier);
if (weights !is null) {
    weights[0] *= 1.25f;
    aiFactoryMgr.SetTierWeights(factoryDef, surface, tier, weights);
}

array<float>@ importance = aiFactoryMgr.GetImportance(factoryDef);
if (importance !is null) {
    importance[0] = 1.2f;  // start importance
    importance[1] = 0.8f;  // switch importance
    aiFactoryMgr.SetImportance(factoryDef, importance);
}
```

`SetTierWeights()` accepts only an array whose size exactly matches the native vector
and must only be called after `GetTierWeights()` returned non-null for the same
definition/surface/tier combination; an unknown combination is not null-checked by
the setter. `SetImportance()` safely ignores unknown definitions or arrays shorter
than two values.

### Mod options are cached

Commit `edeab2e0` changes ownership and reuse of the setup dictionary.

**Before**

```cpp
"dictionary@ GetModOptions()"
// A new dictionary was created and populated for every call.
```

**After**

```cpp
"dictionary@+ GetModOptions()"
// One dictionary is created lazily, retained by CSetupScript, and reused.
```

The `@+` return contract adds a reference for the caller. This reduces allocations but
also means script mutations persist for the rest of the setup wrapper's lifetime.

### Tracy profiling is available to scripts

Commits `d79156c0` and `7c907796` add profiler zones, text, source locations, and
`TRACY_ON_DEMAND` connection handling.

**Before**

```angelscript
// No script-visible Tracy API.
```

**After**

```angelscript
tracy.ZoneBegin("factory-selection", 0x33AAFF);
tracy.ZoneText("checking tier weights");
// profiled work
tracy.ZoneEnd();
```

Zones must be balanced. In on-demand builds, events are suppressed while Tracy is
disconnected, and script execution zones include `source:row:column`.

### Military responses are script-configurable

Commit `87015770` exposes role response data and per-opponent-role tuning.

**Before**

```angelscript
// Response factors and versus-role ratios were native/configuration-only.
```

**After**

```angelscript
SResponseInfo@ response =
    aiMilitaryMgr.GetResponseInfo(Unit::Role::RAIDER.type);
response.maxPercent = 0.35f;
response.factor = 1.1f;

SVsInfo@ versus = response.GetVsInfo(Unit::Role::AA.type);
versus.ratio = 0.8f;
versus.importance = 1.4f;
```

`GetResponseInfo()` requires a valid role and does not return null for valid input.
`GetVsInfo()` creates a zeroed entry when the requested role is absent. Both returned
types are borrowed, non-ref-counted views into manager-owned storage; adding a missing
versus-role entry can reallocate the vector and invalidate earlier `SVsInfo` handles
from the same response.

## Chronological change log

### 2025-12-07 — `d1e2f713` — Large-army engagement scaling

Hard AI now reduces effective enemy threat range as known enemy counts grow, making
large armies less likely to stall outside an oversized combined threat envelope.
Attack and raid path power are adjusted by the same scale. Paralyzer damage is capped
for strength estimates, and stockpile time participates in DPS calculation.

**Changed files:** `InfluenceMap.cpp`, `ThreatMap.cpp/.h`,
`MilitaryManager.cpp/.h`, `AttackTask.cpp`, `RaidTask.cpp`, and `CircuitDef.cpp`.

### 2025-12-07 — `234a01b0` — Factory choice no longer depends on a leader

Factory definitions, importance, T1 classification, map/speed normalization, and
air-factory limits move from `CFactoryData` to `CFactoryManager`. `CFactoryData`
retains runtime counts. Initialization through `CAllyTeam` is simplified.

**Changed files:** `CircuitAI.cpp`, `FactoryManager.cpp/.h`,
`FactoryData.cpp/.h`, and `AllyTeam.cpp`.

### 2025-12-07 — `3da0228b` — Configurable adaptive threat range

The previous scaling feature gains `adaptive_threat_range` configuration, slow-update
caching, and per-map-update snapshots to avoid worker threads repeatedly reading
manager state. The checked-in dev `end_scale_value` is `1.0`, which effectively
disables scaling until configured lower.

**Changed files:** `data/config/dev/behaviour.json`, `InfluenceMap.cpp/.h`,
`ThreatMap.cpp/.h`, `MilitaryManager.cpp/.h`, `AttackTask.cpp`, `RaidTask.cpp`,
and `CircuitDef.cpp`.

### 2025-12-08 — `869f96cb` — Remove `asbind20` from registration

AngelScript registration is rewritten against the native API to restore MinGW
compatibility. AI version advances to `1.6.23`; associated military-manager call sites
are cleaned up.

**Changed files:** `CircuitAI.cpp`, `MilitaryManager.cpp/.h`, and `InitScript.cpp`.

### 2025-12-15 — `9ea0e457` — SuperTask and vector registrar fixes

SuperTask validates a full enemy group instead of only its position. Zero-range
weapons no longer become representative weapons unless they have a large area of
effect. `SEnemyGroup`'s position constructor becomes explicit. The overloaded
`SqDistance2D` binding receives an exact method signature.

**Changed files:** `CircuitAI.cpp`, `InitScript.cpp`, `SuperTask.cpp`,
`CircuitDef.cpp`, and `EnemyManager.cpp/.h`.

### 2025-12-17 — `0ef36267` — Move state and reusable patrol tasks

Adds configured move states, safe unit move-state commands, script task
`Abort()`/`Done()`, terrain helpers, and `TaskS::Patrol()`. Patrol movement is extracted
into `IPatrolTask`; builders and static constructors specialize it. Static patrol units
can D-Gun and self-destruct below their configured health threshold.

**Changed files:** `data/config/dev/behaviour.json`, `data/script/task.as`,
`CircuitAI.cpp`, `FactoryManager.cpp/.h`, `InitScript.cpp`, `UnitTask.cpp/.h`,
builder/common/static `PatrolTask.cpp/.h`, `ArtilleryTask.cpp`, `SquadTask.cpp`,
static `ReclaimTask.cpp`, `TerrainManager.h`, `CircuitDef.cpp/.h`, and
`CircuitUnit.cpp/.h`.

### 2026-04-18 — `505734a4` — Recoil Spring API buckets

Lua calls are assigned to `SpringShared` or `SpringUnsynced`: terrain, frame, and log
calls use the shared bucket; marker and visibility calls use the unsynced bucket.

**Changed files:** `util/LuaRules/Gadgets/ai_chokepoint.lua` and
`util/LuaRules/Gadgets/ai_dbg_map.lua`.

### 2026-06-02 — `7b308d72` — MSVC support

CMake enables MASM and includes AngelScript's x64 MSVC assembly, failing clearly when
the assembler is unavailable. GNU-only `__typeof__` and variable-length arrays are
replaced with `decltype` and `std::vector`.

**Changed files:** `CMakeLists.txt`, `EnergyNode.cpp`, `MicroPather.cpp`, and
`AvailList.h`.

### 2026-06-04 — `9eafe08d` — Typed AngelScript task hierarchy

Introduces `IBuilderTask`, `IFighterTask`, and `CSuperTask` bindings, reference-safe
casts, and `CSuperTask.SetTargetPos()`. Development builder scripts migrate to typed
casts. Registration code is split into reusable templates.

**Changed files:** `CMakeLists.txt`, `README.md`,
`data/script/dev/manager/builder.as`, `CircuitAI.cpp`, `InitScript.cpp/.h`, and
`SuperTask.cpp/.h`.

### 2026-06-22 — `eb650ece` — Apple ARM64 AngelScript calls

CMake compiles `as_callfunc_arm64_xcode.S` for Apple ARM64, supplying the Mach-O
calling-convention symbols required for native AngelScript calls.

**Changed file:** `CMakeLists.txt`.

### 2026-06-08/28 — `0f16bed3` — JIT interface cleanup

The script manager stores `asIJITCompiler*` instead of the concrete JIT type and
explicitly selects JIT interface version 1. Unused setup and triangulation locals are
removed.

**Changed files:** `ScriptManager.cpp/.h`, `SetupManager.cpp`, and `poly1tri.cpp`.

### 2026-06-28 — `32c11e37` — Harmful water and safe path failure

Scripts can flag lava-like water through `SetWaterHarmful()`. Terrain passability uses
that flag in addition to engine water damage. Fighter tasks now issue `Stop` when no
path exists rather than fighting toward a random map position; random fallback
position generation is centralized.

**Changed files:** `data/script/dev/init.as`, `CircuitAI.cpp`, `InitScript.cpp`,
`SetupManager.cpp/.h`, fighter `AntiAir`, `AntiHeavy`, `Artillery`, `Attack`, `Bomb`,
`Raid`, `Scout`, and `Squad` task implementations, `SuperTask.h`,
`TerrainData.cpp`, and `TerrainManager.cpp/.h`.

### 2026-06-29 — `bd272eb3` — Builder interruption controls and geometry namespace

Adds `IBuilderTask.canAutoAbort`, the `NO_DISRUPT` unit attribute, and corresponding
builder assignment rules. Geometry helpers move from `utils` to `geom`; all in-tree
call sites migrate. Default auto-abort remains enabled.

**Changed files:** `data/config/dev/behaviour.json`, `data/script/unit.as`,
`CircuitAI.cpp`, builder/economy/factory managers, energy and metal resources,
`InitScript.cpp`, setup/defence code, unit/task implementations using geometry,
`CircuitDef.cpp/.h`, `CircuitUnit.cpp/.h`, `FactoryData.cpp`, `Geometry.h`, and
`src/lib/triangulate/delaunator.hpp`.

### 2026-07-07 — `85e0a470` — Spring bucket compatibility aliases

The direct Spring bucket split is locally reverted by aliasing both `SpringShared` and
`SpringUnsynced` to `Spring`. Existing bucket-qualified call sites remain readable
while running on an engine exposing only the unified table.

**Changed files:** `ai_chokepoint.lua` and `ai_dbg_map.lua`.

### 2026-07-08 — `9875f1b3` — Critical `AIFloat3` registration fix

Uses `AIFloat3` size and type traits so returned vectors receive the required copy
constructor behavior. Also corrects the terrain-center function name to
`AiTerrainCenter()`.

**Changed file:** `InitScript.cpp`.

### 2026-07-08 — `f2cc1015` — Final classes and dead-code removal

Marks concrete core, map, manager, resource, scheduler, script, setup, Spring, task,
action, unit, and utility classes `final`. Removes unused `SpringDebug.cpp/.h` and
`RearmTask.cpp/.h`. Runtime behavior is otherwise intended to be unchanged, but C++
extension points are deliberately narrowed.

**Changed files:** `CircuitAI.cpp/.h`; map, module, resource, scheduler, script, setup,
and Spring headers; all concrete builder/fighter/static task headers; unit action
headers; unit/enemy/ally headers; terrain block headers; utility/container/profiler
headers; and math helper headers.

### 2026-07-09 — `8203ca30` — Ref-counting and polygon API

Converts `IRefCounter` to a typed, header-only registration helper and removes
`RefCounter.cpp`. Adds `CPolygon`, `AIFloat3.IsInRange()`, and shared AngelScript
registration macros. `CRegion` changes from value-owned polygons to ref-counted
polygon pointers. `Scale()` and `Extend()` receive distinct semantics, and area
recalculation clears old triangle areas first.

**Changed files:** `.cproject`, `CircuitAI.cpp`, `MetalManager.cpp`, all manager script
wrappers, `InitScript.cpp`, `RefCounter.cpp/.h`, `ScriptManager.cpp`, setup data and
manager files, `UnitTask.h`, ally-team files, new `ExtAS.h`, `Utils.h`,
`Region.cpp/.h`, and the bundled `angelscript.h`.

### 2026-07-10 — `fca11d02` — Type cache and factory tier weights

Moves AngelScript type metadata into engine user data and adds
`SetTierWeights()`/`GetTierWeights()`. Script-side unit data gains tier-weight support.

**Changed files:** `data/script/unit.as`, `FactoryManager.cpp/.h`,
`FactoryScript.cpp/.h`, `InitScript.cpp/.h`, `ScriptManager.cpp/.h`,
`SetupScript.cpp/.h`, and `SetupManager.h`.

### 2026-07-10 — `ce73066f` — Factory importance API

Adds `SetImportance()` and `GetImportance()`, moves float-array type-cache setup to
core registration, and changes missing tier weights from an empty array to `null`.

**Changed files:** `FactoryManager.cpp/.h`, `FactoryScript.cpp/.h`, and
`InitScript.cpp`.

### 2026-07-16 — `edeab2e0` — Cached mod options and polygon vertices

Adds `CPolygon.GetVerts()` and `AiAddLine()`. `GetModOptions()` lazily caches its
dictionary and uses the `@+` ownership contract. Cleanup releases the retained native
dictionary.

**Changed files:** `CircuitAI.cpp`, `InitScript.cpp/.h`, `RefCounter.h`,
`ScriptManager.h`, `SetupScript.cpp/.h`, and `Region.h`.

### 2026-07-18 — `d79156c0` — Tracy bindings

Adds the global `tracy` object with `ZoneBegin()` and `ZoneEnd()`. Native script
execution and map updates gain profiling integration; non-profiling builds keep
no-op wrappers.

**Changed files:** `AIExport.cpp`, `CircuitAI.cpp`, `InfluenceMap.cpp`,
`ThreatMap.cpp`, `ScriptManager.cpp/.h`, and `Profiler.h`.

### 2026-07-19 — `7c907796` — Tracy on-demand support

Adds `ZoneText()`, connection-aware suppression, nested-zone state, and exact
`source:row:column` text for script execution zones.

**Changed files:** `ScriptManager.cpp` and `Profiler.h`.

### 2026-07-19 — `87015770` — Military-response bindings

Adds mutable script views for role response percentages/factors and per-opponent-role
ratios/importance. Factory scripts also gain writable `buildpowerRatio` and
`responseWeight` properties, while getter declarations are adjusted to match
const-qualified native APIs.

**Changed files:** `MilitaryManager.cpp/.h`, `FactoryScript.cpp/.h`, and
`MilitaryScript.cpp/.h`.

### 2026-07-21 — `b9b74db7` — Movement, economy, and support behavior

Distant move/fight orders use fewer waypoints. Economy building selection enforces a
single category per decision. Support actions use Spring's `GUARD` command rather
than periodically issuing `FIGHT`, with matching wait/recruit lifecycle changes.

**Changed files:** `CircuitAI.cpp/.h`, `EconomyManager.cpp`, `WaitTask.cpp`,
`RecruitTask.cpp`, `CircuitUnit.h`, `FightAction.cpp`, `MoveAction.cpp`,
`SupportAction.cpp`, and `TravelAction.h`.

### 2026-07-24 — `16b0e872` — Commander and early-economy tuning

Reworks builder selection and commander handling, introduces danger hysteresis,
adjusts metal/energy/factory task demand, and revises path-query plumbing. Spring unit
operations move into new `SpringUnit.cpp/.h`. AngelScript gains writable
`aiBuilderMgr.dangerHysteresis` and `aiEconomyMgr.startMexTravel`; the dev script
randomizes the latter between 7 and 12 seconds. The `~mouse` debug command is added,
the dev profile documents the `base` attribute, and an 89-line commented example
section is removed from the generic config.

**Changed files:** `data/config/behaviour.json`,
`data/config/dev/behaviour.json`, `data/script/dev/main.as`,
`data/script/dev/manager/factory.as`, `CircuitAI.cpp`, `ThreatMap.h`,
`BuilderManager.cpp/.h`, `EconomyManager.cpp/.h`, `BuilderScript.cpp`,
`EconomyScript.cpp`, new `SpringUnit.cpp/.h`, builder `Builder`, `Energy`, `Factory`,
and `Mex` task implementations, `TerrainManager.cpp/.h`, `MicroPather.cpp/.h`,
`PathFinder.cpp/.h`, `QueryPathSingle.cpp/.h`, and `Defines.h`.

### 2026-07-27 — `1d9952f3` — Per-definition energy task counts

Energy tasks are counted by `UnitDef` instead of as one aggregate, preventing one
generator type from suppressing demand for another.

**Changed files:** `.cproject` and `EconomyManager.cpp`.

### 2026-07-31 — `e6b33037` — Safe `CRegion` ownership

Deletes the default constructor and copy operations from pointer-owning `CRegion`.
`CSetupData` now owns heap-allocated region pointers and deletes them; `CAllyTeam`
holds a non-owning pointer instead of copying a region. This prevents shallow copies
and duplicate polygon releases, but makes ally-team access dependent on setup-data
lifetime. The same commit removes a side-effect-only `IsEnergyStalling()` call from
the default builder task path.

**Changed files:** `CircuitAI.cpp`, `BuilderManager.cpp`, `SetupData.cpp/.h`,
`AllyTeam.cpp/.h`, and `Region.h`.

### 2026-08-23 — `30e4297e` — Validate factory representer area

Factory selection now checks both the factory and its representer at the requested
position. This avoids choosing a factory whose representative footprint cannot be
built there. `FactoryTask.cpp` only removes an unused lambda capture from the
pre-existing build-site representer test. The invalid-position fallback still lacks
the new selection-time validation and can fail later in build-site search, as noted by
the added FIXME. The development block-map altitude merge threshold changes from 64
to 80.

**Changed files:** `data/config/dev/block_map.json`, `CircuitAI.cpp`,
`EnergyData.h`, `FactoryTask.cpp`, and `FactoryData.cpp`.

## Complete changed-file audit

The commit sections above list every non-mechanical path directly. The two broad
mechanical refactors touched the following complete path groups:

- **`bd272eb3` geometry namespace migration:** `BuilderManager.cpp`,
  `EconomyManager.cpp`, `FactoryManager.cpp`, `EnergyGrid.cpp`,
  `EnergyManager.cpp`, `MetalData.cpp/.h`, `MetalManager.cpp`, `DefenceData.h`,
  `SetupManager.cpp`, `RetreatTask.cpp`, `UnitTask.cpp`, builder tasks
  `Builder`, `Energy`, `Factory`, `Geo`, `Mex`, `MexUp`, `Nano`, `Pylon`,
  `Resurrect`, and `Terraform`; common tasks `Patrol` and `Reclaim`; fighter tasks
  `Bomb`, `Defend`, `Raid`, `Rally`, `Scout`, `Squad`, and `Support`; static tasks
  `Reclaim`, `Recruit`, `Repair`, and `Super`; `TerrainManager.cpp`,
  `CircuitDef.cpp/.h`, `CircuitUnit.cpp/.h`, `FactoryData.cpp`, `Geometry.h`, and
  `delaunator.hpp`.
- **`f2cc1015` final declarations:** `CircuitAI.h`; `InfluenceMap.h`,
  `MapManager.h`, `ThreatMap.h`; `BuilderManager.h`, `EconomyManager.h`,
  `FactoryManager.h`, `MilitaryManager.h`; `EnergyData.h`, `EnergyGrid.h`,
  `EnergyLink.h`, `EnergyManager.h`, `EnergyNode.h`, `MetalManager.h`;
  `Scheduler.h`; all seven `*Script.h` wrappers; `DefenceData.h`, `SetupData.h`,
  `SetupManager.h`; `SpringCallback.h`, `SpringEngine.h`, `SpringMap.h`;
  `IdleTask.h`, `NilTask.h`, `PlayerTask.h`, `RetreatTask.h`; every concrete
  header under `task/builder`, `task/fighter`, and `task/static`; `CircuitUnit.h`,
  `CircuitWDef.h`, `FactoryData.h`, `AllyTeam.h`, `EnemyManager.h`, `EnemyUnit.h`;
  all concrete headers under `unit/action`; `BlockCircle.h`, `BlockRectangle.h`;
  `AvailList.h`, `DebugDrawer.h`, `GameAttribute.h`, `MaskHandler.h`,
  `MultiQueue.h`, `Profiler.h`; and math headers `ApproxMNK.h`, `ConvexHull.h`,
  `EncloseCircle.h`, `GaussSolver.h`, `HierarchCluster.h`, `KMeansCluster.h`,
  `LagrangeInterPol.h`, `RayBox.h`, and `Region.h`. It also deletes
  `SpringDebug.cpp/.h` and `RearmTask.cpp/.h`, with small supporting edits in
  `CircuitAI.cpp`.

No merge commits occur in this range. Commits `d1e2f713`, `505734a4`,
`7b308d72`, and `eb650ece` originated as pull-request contributions, but each is a
single-parent commit in `barb5`.
