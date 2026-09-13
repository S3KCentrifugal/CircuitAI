# CircuitAI AngelScript Reference

## Purpose

This document is the practical reference for writing and maintaining CircuitAI
AngelScript. It covers:

- where scripts live and how profiles are loaded;
- callbacks that native CircuitAI invokes;
- native C++ types, globals, and managers exposed to scripts;
- task descriptors and script-side helper APIs;
- ownership and lifetime rules;
- common policy use cases with current examples.

The authoritative registration code is:

- `src/circuit/script/InitScript.cpp` for core types, utilities, tasks, and global
  managers;
- `src/circuit/script/BuilderScript.cpp`;
- `src/circuit/script/FactoryScript.cpp`;
- `src/circuit/script/EconomyScript.cpp`;
- `src/circuit/script/MilitaryScript.cpp`;
- `src/circuit/script/SetupScript.cpp`;
- `src/circuit/script/ModuleScript.cpp` and `TaskModuleScript.cpp` for callback
  contracts.

If this document and registration code disagree, registration code wins. A C++
method is not available to AngelScript merely because it is public.

## Navigation

- [Source layout and profile loading](#source-layout-and-profile-loading)
- [Runtime rules](#runtime-rules)
- [Host callback contract](#host-callback-contract)
- [Initialization types](#initialization-types)
- [Core value types and utilities](#core-value-types-and-utilities)
- [Core AI objects](#core-ai-objects)
- [Tasks](#tasks)
- [Native managers](#native-managers)
- [Common implementation patterns](#common-implementation-patterns)
- [Maintenance and validation](#maintenance-and-validation)

## Source layout and profile loading

The active implementation is under `data/script/`:

| Path | Purpose |
| --- | --- |
| `data/script/<profile>/init.as` | Early profile initialization through `Init::AiInit()`. |
| `data/script/<profile>/main.as` | Runtime entry point through `Main::AiMain()` and related hooks. |
| `data/script/src/` | Shared active policy, types, managers, roles, map configuration, and helpers. |
| `data/config/` | JSON behavior fragments selected by `SInitInfo.profile`. |
| `data_sample/script/` | Historical/sample scripts only; not an implementation target. |
| `util/fibR.as` | Standalone utility script, outside the runtime profile graph. |

The profile loader first compiles `<profile>/init.as` as module `init`, invokes
`Init::AiInit()`, and discards that module. It then compiles
`<profile>/main.as` as module `main`. `#include` directives compose the profile
into one module.

The experimental profiles include `data/script/src/setup.as`, which includes
the shared manager and role implementation. The legacy `easy`, `medium`,
`hard`, and `hard_aggressive` runtime hooks are intentionally minimal and rely
mostly on native defaults and JSON configuration.

## Runtime rules

### Compiler configuration

CircuitAI configures AngelScript with these important behaviors:

- compiler warnings are errors;
- unsafe references are disabled;
- implicit handle types are disabled;
- multiline strings are enabled;
- script-created property accessors require the `property` keyword;
- UTF-8 source is enabled;
- automatic garbage collection is enabled;
- nested calls are limited to 100.

Registered standard add-ons include `string`, `array<T>`, `dictionary`, math
functions, string utilities, and AATC containers. Prefer the established
`array` and `dictionary` patterns in `data/script/src/`.

### Ownership and handles

Ownership is part of the API contract:

| Type | Registration/lifetime | Safe usage |
| --- | --- | --- |
| `CCircuitUnit` | Borrowed native object (`asOBJ_NOCOUNT`). | Do not retain a handle across callbacks. Retain its `Id`, then call `ai.GetTeamUnit(id)` before use. |
| `CCircuitDef` | Borrowed native definition (`asOBJ_NOCOUNT`). | Check for `null`; definitions normally live for the AI instance. |
| `IUnitTask` and derived tasks | Reference-counted. | Handles may be retained, but do not assume a base task exposes derived members. |
| Managers such as `aiBuilderMgr` | Native singleton (`asOBJ_NOHANDLE`). | Use the global object directly; do not store handles to it. |
| `SResourceInfo`, quota, and response views | Non-counted views into native managers. | Read/use them immediately; do not treat them as owned snapshots. A newly inserted military response entry can invalidate an earlier `SVsInfo@`. |
| `dictionary` from `GetModOptions()` | Cached native-provided script dictionary. | Use the returned handle and let script handle semantics manage it; do not attempt manual release. |

Safe unit retention:

```angelscript
Id trackedUnitId = -1;

void RememberUnit(CCircuitUnit@ unit)
{
    trackedUnitId = (unit is null) ? -1 : unit.id;
}

CCircuitUnit@ GetTrackedUnit()
{
    return (trackedUnitId < 0) ? null : ai.GetTeamUnit(trackedUnitId);
}
```

### Null checks and typed task casts

`IUnitTask` only exposes common task operations. Builder, fighter, and super
task members require a registered cast:

```angelscript
void InspectTask(IUnitTask@ task)
{
    if (task is null) {
        return;
    }

    IBuilderTask@ builderTask = cast<IBuilderTask>(task);
    if (builderTask !is null) {
        Task::BuildType type = Task::BuildType(builderTask.GetBuildType());
        const CCircuitDef@ buildDef = builderTask.buildDef;
        const AIFloat3 pos = builderTask.GetBuildPos();
        AiLog("build type=" + int(type) + " def=" +
            (buildDef is null ? "<none>" : buildDef.GetName()) +
            " pos=" + pos);
    }
}
```

Never call `GetBuildType()`, `GetBuildPos()`, or access `buildDef` directly on
`IUnitTask`. The obsolete `IUnitTask.GetBuildDef()` method does not exist.

## Host callback contract

Callbacks must be declared in the namespace shown. The host looks up exact
declarations.

### Initialization and main callbacks

| Namespace | Declaration | Use |
| --- | --- | --- |
| `Init` | `SInitInfo AiInit()` | Select armor/category groups and JSON profile fragments. |
| `Main` | `void AiMain()` | Required runtime initialization after the main module is loaded. |
| `Main` | `void AiUpdate()` | Slow update, currently called every 30 simulation frames with a per-AI offset. |
| `Main` | `void AiLuaMessage(const string& in data)` | Receive a game/UI-originated skirmish-AI message. |
| `Main` | `void AiMessage(const string& in data, int fromTeamId)` | Receive `AiSendMessage` traffic from an allied CircuitAI instance. |
| `Main` | `void AiUnitFinished(CCircuitUnit@ unit)` | Observe completed friendly units. |
| `Main` | `void AiUnitDestroyed(CCircuitUnit@ unit)` | Observe destroyed friendly units. |

Minimal profile entry points:

```angelscript
#include "../src/common.as"
#include "../src/unit.as"

namespace Init {
    SInitInfo AiInit()
    {
        SInitInfo info;
        info.armor = InitArmordef();
        info.category = InitCategories();
        @info.profile = @(array<string> = {
            "behaviour", "build_chain", "economy", "factory", "response"
        });
        return info;
    }
}
```

```angelscript
#include "../src/setup.as"

namespace Main {
    void AiMain()
    {
        Maps::registerMaps();
    }

    void AiUpdate()
    {
        Military::UpdateEnemyThreatCache();
        Military::UpdateEnemyCostCache();
    }
}
```

### Manager callbacks

Builder, factory, and military are task modules. Their common callback contract
is:

```angelscript
IUnitTask@ AiMakeTask(CCircuitUnit@ unit);
void AiTaskAdded(IUnitTask@ task);
void AiTaskRemoved(IUnitTask@ task, bool done);
void AiUnitAdded(CCircuitUnit@ unit, Unit::UseAs usage);
void AiUnitRemoved(CCircuitUnit@ unit, Unit::UseAs usage);
void AiLoad(IStream& stream);
void AiSave(OStream& stream);
```

The callbacks must be placed in the corresponding `Builder`, `Factory`, or
`Military` namespace. When `AiMakeTask` is absent, the native manager's
`DefaultMakeTask()` is used.

Additional callbacks:

| Namespace | Declaration | Fallback/meaning |
| --- | --- | --- |
| `Builder` | `void AiTaskAssigned(CCircuitUnit@ unit)` | Notification after a builder receives a task. |
| `Factory` | `bool AiIsSwitchTime(int lastSwitchFrame)` | Returns `false` if absent. |
| `Factory` | `bool AiIsSwitchAllowed(CCircuitDef@ factoryDef)` | Returns `true` if absent. |
| `Factory` | `CCircuitDef@ AiGetFactoryToBuild(const AIFloat3& in pos, bool isStart, bool isReset)` | Native `DefaultGetFactoryToBuild()` if absent. |
| `Economy` | `void AiUpdateEconomy()` | Recompute script-managed economy flags and policy state. |
| `Economy` | `void AiUnitAdded(CCircuitUnit@ unit, Unit::UseAs usage)` | Economy unit notification. |
| `Economy` | `void AiUnitRemoved(CCircuitUnit@ unit, Unit::UseAs usage)` | Economy unit notification. |
| `Economy` | `void AiLoad(IStream& stream)` / `void AiSave(OStream& stream)` | Optional persistence. |
| `Military` | `void AiMakeDefence(int cluster, const AIFloat3& in pos)` | Calls native `DefaultMakeDefence()` if absent. |

The shared implementation in `data/script/src/manager/` already supplies these
hooks and dispatches to `RoleConfig` delegates. Extend role delegates instead
of duplicating top-level callbacks where possible.

`Unit::UseAs` currently names only the military, builder, and factory values:
`COMBAT`, `FENCE`, `SUPER`, `STOCK`, `BUILDER`, `REZZER`, `FACTORY`, and
`ASSIST`. Native economy callbacks can also pass `ENERGY`, `GEO`, `MEX`,
`CONVERT`, `STORE`, and `AIRPAD` (numeric values 8 through 13), but those names
are not yet present in `data/script/src/unit.as`. Do not branch on named
economy usages until that script enum is extended; treat the underlying value
as an integer if it must be inspected.

## Initialization types

### `SInitInfo`

Returned by `Init::AiInit()`:

```angelscript
SArmorInfo armor;
SCategoryInfo category;
array<string>@ profile;
```

`profile` contains JSON fragment base names from `data/config/`, without the
`.json` extension.

### `SArmorInfo`

Methods:

```angelscript
void AddAir(int armorType);
void AddSurface(int armorType);
void AddWater(int armorType);
```

### `SCategoryInfo`

Writable category-expression strings:

```angelscript
string air;
string land;
string water;
string bad;
string good;
```

Use the shared `InitArmordef()` and `InitCategories()` functions unless a
profile has a specific compatibility requirement.

## Core value types and utilities

### Numeric aliases and masks

```angelscript
typedef int Id;
typedef int Type;
typedef uint Mask;

class TypeMask {
    Type type;
    Mask mask;
}
```

Globals:

```angelscript
CMaskHandler aiSideMasker;
CMaskHandler aiRoleMasker;
CMaskHandler aiAttrMasker;
```

Methods and helpers:

```angelscript
TypeMask CMaskHandler::GetTypeMask(const string& in name);
TypeMask AiAddRole(const string& in name, Type actsAsRole);
```

Example:

```angelscript
TypeMask assault = aiRoleMasker.GetTypeMask("assault");
TypeMask custom = AiAddRole("anti_heavy_ass", assault.type);

CCircuitDef@ def = ai.GetCircuitDef("armmav");
if (def !is null && custom.type >= 0) {
    def.AddAttribute(custom.type);
}
```

### `AIFloat3`

`AIFloat3` is a mutable three-component value type with `x`, `y`, and `z`.
Constructors accept no arguments, one scalar, another vector, or three
components.

Supported operation groups:

- vector/scalar `+`, `-`, `*`, `/` and compound assignment;
- equality and indexed access;
- `dot`, `dot2D`, `cross`, `rotate`, `rotateByUpVector`, and `rotate2D`;
- `distance`, `distance2D`, `SqDistance`, and `SqDistance2D`;
- `Length`, `Length2D`, `SqLength`, and `SqLength2D`;
- unary `-`, equality helpers `equals`, `same`, and `binarySame`;
- `Normalize`, `Normalize2D`, `SafeNormalize`, and `SafeNormalize2D`;
- length-returning normalization through `LengthNormalize()` and
  `LengthNormalize2D()`;
- `PickNonParallel`, `snapToAxis`, `Normalized`, `CheckNaNs`, `IsInMap`, and
  `ClampInMap`;
- `str()`, `ToString()`, and implicit string conversion;
- `IsInRange(const AIFloat3& in, float)`.

Vector globals:

```angelscript
AIFloat3 AiMin(AIFloat3 a, AIFloat3 b);
AIFloat3 AiMax(AIFloat3 a, AIFloat3 b);
AIFloat3 AiFabs(AIFloat3 value);
AIFloat3 AiSign(AIFloat3 value);
```

Example:

```angelscript
AIFloat3 delta = target - origin;
float distance = delta.Length2D();
AIFloat3 direction = delta.SafeNormalize2D();
AIFloat3 waypoint = origin + direction * AiMin(distance, 512.0f);
waypoint.ClampInMap();
```

### `CPolygon`

Construct a reference-counted polygon from XZ-plane vertices:

```angelscript
CPolygon@ CPolygon(const array<AIFloat3>@+ vertices);
array<AIFloat3>@ GetVerts() const;
const float area;
bool ContainsPoint(const AIFloat3& in point) const;
AIFloat3 Random() const;
void Scale(float factor);
void Extend(float distance);
```

`GetVerts()` returns a new script array. Changing that array does not mutate
the polygon.

Example:

```angelscript
array<AIFloat3> vertices = {
    AIFloat3(0, 0, 0),
    AIFloat3(512, 0, 0),
    AIFloat3(512, 0, 512),
    AIFloat3(0, 0, 512)
};
CPolygon@ zone = CPolygon(vertices);
if (zone.ContainsPoint(builder.GetPos(ai.frame))) {
    AIFloat3 buildPos = zone.Random();
}
```

### Global utilities

```angelscript
void AiLog(const string& in message);
void AiAddPoint(const AIFloat3& in pos, const string& in label);
void AiDelPoint(const AIFloat3& in pos);
void AiAddLine(const AIFloat3& in from, const AIFloat3& in to);
void AiPause(bool enabled, const string& in reason);
int AiDice(const array<float>@+ weights);
int AiNearestPointIdx(const AIFloat3& in pos, const array<AIFloat3>@+ points);
int AiMin(int a, int b);
float AiMin(float a, float b);
int AiMax(int a, int b);
float AiMax(float a, float b);
int AiRandom(int min, int max);
void AiSendMessage(const string& in message, int toTeamId = -1);
void AiSleep(uint64 milliseconds);
```

`AiDice` returns an index selected in proportion to non-negative weights and
returns `-1` if no choice is made. `AiRandom(min, max)` is inclusive at both
ends and requires `max >= min`. To select an array index, use
`AiRandom(0, int(values.length()) - 1)` only after checking that the array is
not empty.

Debug-drawing example:

```angelscript
const AIFloat3 start = unit.GetPos(ai.frame);
const AIFloat3 end = start + AIFloat3(256, 0, 0);
AiAddPoint(start, "policy origin");
AiAddLine(start, end);
// Later:
AiDelPoint(start);
```

### Parallel jobs

The asynchronous API is:

```angelscript
funcdef void AiOnFinish(dictionary@+);
funcdef AiOnFinish@+ AiExec(dictionary@+);
void AiRun(AiExec@+ worker, dictionary@ arguments);
```

The worker runs off the game thread and returns an optional finish callback,
which runs on the game thread. Restrict worker code to independent computation
over copied/script-owned data. Do not access mutable CircuitAI managers or
borrowed native unit handles from the worker.

```angelscript
void FinishEstimate(dictionary@ data)
{
    float result;
    if (data.get("result", result)) {
        AiLog("estimate=" + result);
    }
}

AiOnFinish@ RunEstimate(dictionary@ data)
{
    float input;
    data.get("input", input);
    data.set("result", input * input);
    return @FinishEstimate;
}

void StartEstimate(float input)
{
    dictionary@ data = dictionary();
    data.set("input", input);
    AiRun(@RunEstimate, data);
}
```

### String and stream extensions

`string.toLower()` and `string.toUpper()` return converted copies.

`IStream` supports `>>` and `OStream` supports `<<` for:

`bool`, signed and unsigned 8/16/32/64-bit integers, `float`, and `double`.
Serialization is binary and order-dependent:

```angelscript
namespace Economy {
    int savedPhase = 0;
    float savedIncome = 0.0f;

    void AiSave(OStream& stream)
    {
        stream << savedPhase << savedIncome;
    }

    void AiLoad(IStream& stream)
    {
        stream >> savedPhase >> savedIncome;
    }
}
```

Keep save and load fields in exactly the same order and update both together.

## Core AI objects

### `CCircuitAI ai`

Read-only properties:

```angelscript
const int frame;
const int skirmishAIId;
const int teamId;
const int allyTeamId;
```

Methods:

```angelscript
CCircuitDef@ GetCircuitDef(const string& in name);
CCircuitDef@ GetCircuitDef(Id id);
int GetDefCount() const;
CCircuitUnit@ GetTeamUnit(Id id);
string GetMapName() const;
int GetEnemyTeamSize() const;
bool IsLoadSave() const;
Type GetBindedRole(Type type) const;
int GetLeadTeamId() const;
Type GetSideId() const;
const string& GetSideName() const;
array<Id>@ GetTeamIds() const;
void GiveUnits(const array<CCircuitUnit@>@+ units, int newTeamId);
bool UnitControl(CCircuitUnit@ unit, bool enabled);
bool UnitControl(Id unitId, bool enabled);
string CallRules(const string& in data);
string CallUI(const string& in data);
float GetGameRulesParam(const string& in key, float fallback) const;
string GetGameRulesParam(const string& in key, const string& in fallback) const;
float GetTeamRulesParam(const string& in key, float fallback) const;
string GetTeamRulesParam(const string& in key, const string& in fallback) const;
```

Definition lookup and availability:

```angelscript
CCircuitDef@ factory = ai.GetCircuitDef("armvp");
if (factory !is null && factory.IsAvailable(ai.frame)) {
    AiLog("factory " + factory.GetName() + " costs " + factory.costM + " metal");
}
```

Rules parameter lookup:

```angelscript
float windMin = ai.GetGameRulesParam("map_windmin", -1.0f);
string commanderState =
    ai.GetTeamRulesParam("is_commander_dead", "unknown");
```

`CallRules` and `CallUI` cross into Lua. Their payload format is game/widget
specific; do not assume an arbitrary string is a supported command.

### `CCircuitDef`

Identity and cost/combat properties:

```angelscript
const Id id;
const int count;
const float health;
const float speed;
const float losRadius;
const float sonarRadius;
const float costM;
const float costE;
const float threat;
const float power;
const float defDmg;
const float pwrDmg;
const float airThrDmg;
const float surfThrDmg;
const float waterThrDmg;
const float minRange;
```

Mutable policy fields:

```angelscript
int maxThisUnit;
int sinceFrame;
int cooldown;
```

Role, attribute, and identity methods:

```angelscript
void SetMainRole(Type role);
Type GetMainRole() const;
bool IsRespRoleAny(Mask mask) const;
bool IsRoleAny(Mask mask) const;
void AddAttribute(Type attribute);
void DelAttribute(Type attribute);
void TglAttribute(Type attribute);
bool IsAttrAny(Mask mask) const;
const string GetName() const;
bool IsAvailable(int frame);
```

Combat and behavior methods:

```angelscript
float GetMaxRange(Type rangeType) const;
float GetMaxRange() const;
void SetRange(Type rangeType, float range);
void SetRange(float range);
float GetAirThreat() const;
float GetSurfThreat() const;
float GetWaterThreat() const;
bool IsAbleToFly() const;
bool IsMobile() const;
void SetIgnore(bool ignored);
bool IsIgnore() const;
void SetThreatKernel(float value);
void SetFireState(int state);
int GetFireState() const;
```

Use the role and attribute constants from `data/script/src/unit.as`; do not
hard-code native mask bits.

### `CCircuitUnit`

```angelscript
const Id id;
const CCircuitDef@ circuitDef;
IUnitTask@ const task;

const AIFloat3& GetPos(int frame);
void AddAttribute(Type attribute);
void DelAttribute(Type attribute);
void TglAttribute(Type attribute);
bool IsAttrAny(Mask mask) const;
void SetFireState(int state);
void SetMoveState(int state);
void SelfDestruct(bool queued);
float GetRulesParam(const string& in key, float fallback) const;
string GetRulesParam(const string& in key, const string& in fallback) const;
```

Always null-check both the unit and `unit.circuitDef`.

## Tasks

### Native task interfaces

`IUnitTask`:

```angelscript
Type GetType() const;
array<CCircuitUnit@>@ GetUnits() const;
void Abort();
void Done();
```

`IBuilderTask` extends `IUnitTask`:

```angelscript
Type GetBuildType() const;
const AIFloat3& GetBuildPos() const;
CCircuitDef@ const buildDef;
CCircuitUnit@ const target;
bool canAutoAbort;
```

`IFighterTask` extends `IUnitTask`:

```angelscript
Type GetFightType() const;
```

`CSuperTask` extends `IFighterTask`:

```angelscript
void SetTargetPos(const AIFloat3& in pos);
```

Available casts are:

```angelscript
cast<IBuilderTask>(task);
cast<IFighterTask>(task);
cast<CSuperTask>(fighterTask);
```

### Script task enums

`data/script/src/task.as` defines the enum values passed to native descriptors:

```angelscript
namespace Task {
    enum Priority { LOW = 0, NORMAL = 1, HIGH = 2, NOW = 99 }
    enum Type { NIL, PLAYER, IDLE, WAIT, RETREAT, BUILDER, FACTORY, FIGHTER }
    enum RecruitType { BUILDPOWER = 0, FIREPOWER }
    enum BuildType {
        FACTORY, NANO, STORE, PYLON, ENERGY, GEO, GEOUP, DEFENCE, BUNKER,
        BIG_GUN, RADAR, SONAR, CONVERT, MEX, MEXUP, REPAIR, RECLAIM,
        RESURRECT, RECRUIT, TERRAFORM, _SIZE_, PATROL, GUARD, COMBAT, WAIT
    }
    enum FightType {
        RALLY, GUARD, DEFEND, SCOUT, RAID, ATTACK, BOMB, MELEE, ARTY, AA,
        AH, SUPPORT, SUPER, _SIZE_
    }
}
```

### Builder task descriptors

`SResource`:

```angelscript
SResource(float metal, float energy);
float metal;
float energy;
```

`SBuildTask` fields:

```angelscript
uint8 type;
uint8 priority;
CCircuitDef@ buildDef;
AIFloat3 position;
SResource cost;
CCircuitDef@ reprDef;
CCircuitUnit@ target;
int pointId;
int spotId;
float shake;
float radius;
bool isPlop;
bool isMetal;
bool isActive;
int timeout;
```

`SServBTask` fields:

```angelscript
uint8 type;
uint8 priority;
AIFloat3 position;
CCircuitUnit@ target;
float powerMod;
bool isInterrupt;
int timeout;
```

Prefer constructors in script namespace `TaskB` over manually initializing a
partially populated descriptor:

```angelscript
SBuildTask Common(...);
SBuildTask Spot(...);
SBuildTask Factory(...);
SBuildTask Pylon(...);
SBuildTask Repair(...);
SBuildTask Reclaim(...);
SBuildTask Resurrect(...);
SBuildTask Terraform(...);
SServBTask Patrol(...);
SServBTask Guard(...);
SServBTask Combat(...);
SServBTask Wait(...);
```

Example:

```angelscript
IUnitTask@ QueueEnergy(CCircuitDef@ energyDef, const AIFloat3& in pos)
{
    if (energyDef is null) {
        return null;
    }
    return aiBuilderMgr.Enqueue(TaskB::Common(
        Task::BuildType::ENERGY,
        Task::Priority::NORMAL,
        energyDef,
        pos
    ));
}
```

### Factory task descriptors

`SRecruitTask`:

```angelscript
uint8 type;
uint8 priority;
CCircuitDef@ buildDef;
AIFloat3 position;
float radius;
```

`SServSTask`:

```angelscript
uint8 type;
uint8 priority;
AIFloat3 position;
CCircuitUnit@ target;
float radius;
bool stop;
int timeout;
```

Use `TaskS::Recruit`, `TaskS::Repair`, `TaskS::Reclaim`, and `TaskS::Wait`.

```angelscript
IUnitTask@ QueueRecruit(CCircuitDef@ unitDef, const AIFloat3& in pos)
{
    if (unitDef is null || !unitDef.IsAvailable(ai.frame)) {
        return null;
    }
    SRecruitTask request = TaskS::Recruit(
        Task::RecruitType::FIREPOWER,
        Task::Priority::NORMAL,
        unitDef,
        pos,
        512.0f
    );
    return aiFactoryMgr.Enqueue(request);
}
```

### Military task descriptors

`SFightTask`:

```angelscript
uint8 type;
uint8 check;
uint8 promote;
float power;
CCircuitUnit@ vip;
```

Use `TaskF::Common`, `TaskF::Guard`, and the two `TaskF::Defend` overloads:

```angelscript
SFightTask request = TaskF::Defend(
    Task::FightType::RAID,
    Task::FightType::ATTACK,
    2500.0f
);
IUnitTask@ task = aiMilitaryMgr.Enqueue(request);
```

## Native managers

### `CSetupManager aiSetupMgr`

```angelscript
const CCircuitDef@ commChoice;
void SetWaterHarmful(bool harmful);
dictionary@+ GetModOptions();
```

Mod option values are strings:

```angelscript
dictionary@ options = aiSetupMgr.GetModOptions();
string legion = "0";
if (options !is null) {
    options.get("experimentallegionfaction", legion);
}
bool legionEnabled = legion == "1";
```

### `CTerrainManager aiTerrainMgr`

```angelscript
bool IsWaterAVoid() const;
float GetLandPercent() const;
float SetAllyZoneRange(float range);
```

Terrain globals:

```angelscript
int AiTerrainWidth();
int AiTerrainHeight();
float AiTerrainDiagonal();
AIFloat3 AiTerrainCenter();
```

Use `GetLandPercent()` for coarse policy decisions. Map-specific starts and
objectives belong in `data/script/src/maps/`.

### `CEnemyManager aiEnemyMgr`

```angelscript
float GetEnemyThreat(Type role) const;
const float mobileThreat;
float GetEnemyCost(Type role) const;
float maxAAThreat;
```

Example:

```angelscript
float airThreat = aiEnemyMgr.GetEnemyThreat(Unit::Role::AA.type);
float surfaceCost = aiEnemyMgr.GetEnemyCost(Unit::Role::ASSAULT.type);
if (airThreat > 0.0f) {
    AiLog("enemy AA threat=" + airThreat + " surface cost=" + surfaceCost);
}
```

### `CThreatMap aiThreat`

```angelscript
void ApplyRange(CCircuitDef@ def);
```

This mutates the native threat-map treatment for the definition's effective
range. Use it during policy setup, not as a per-frame query.

### `CEconomyManager aiEconomyMgr`

Resource views:

```angelscript
class SResourceInfo {
    const float current;
    const float storage;
    const float pull;
    const float income;
}

const SResourceInfo metal;
const SResourceInfo energy;
```

Policy state:

```angelscript
bool isMetalEmpty;
bool isMetalFull;
bool isEnergyStalling;
bool isEnergyEmpty;
bool isEnergyFull;
float reclConvertEff;
float reclEnergyEff;
float startMexTravel;
float GetMetalMake(const CCircuitDef@ def) const;
float GetEnergyMake(const CCircuitDef@ def) const;
```

Economy gate:

```angelscript
bool CanAffordFactory(CCircuitDef@ factoryDef)
{
    if (factoryDef is null || aiEconomyMgr.isEnergyStalling) {
        return false;
    }
    const SResourceInfo@ metal = aiEconomyMgr.metal;
    return metal.income >= 12.0f && metal.current >= factoryDef.costM * 0.25f;
}
```

### `CBuilderManager aiBuilderMgr`

```angelscript
IUnitTask@+ DefaultMakeTask(CCircuitUnit@ unit);
IUnitTask@+ Enqueue(const SBuildTask& in request);
IUnitTask@+ Enqueue(const SServBTask& in request);
IUnitTask@+ EnqueueRetreat();
uint GetWorkerCount() const;
int dangerHysteresis;
```

Custom policies should return a native default when they do not deliberately
replace it:

```angelscript
namespace Builder {
    IUnitTask@ AiMakeTask(CCircuitUnit@ unit)
    {
        if (unit is null) {
            return null;
        }

        if (aiEconomyMgr.isEnergyStalling) {
            CCircuitDef@ solar = ai.GetCircuitDef("armsolar");
            if (solar !is null && solar.IsAvailable(ai.frame)) {
                return aiBuilderMgr.Enqueue(TaskB::Common(
                    Task::BuildType::ENERGY,
                    Task::Priority::HIGH,
                    solar,
                    unit.GetPos(ai.frame)
                ));
            }
        }
        return aiBuilderMgr.DefaultMakeTask(unit);
    }
}
```

### `CFactoryManager aiFactoryMgr`

```angelscript
CCircuitDef@ DefaultGetFactoryToBuild(
    const AIFloat3& in pos, bool isStart, bool isReset);
IUnitTask@+ DefaultMakeTask(CCircuitUnit@ unit);
IUnitTask@+ Enqueue(const SRecruitTask& in request);
IUnitTask@+ Enqueue(const SServSTask& in request);
CCircuitDef@ GetRoleDef(const CCircuitDef@ factoryDef, Type role) const;
int GetFactoryCount() const;
bool isAssistRequired;
float buildpowerRatio;
float responseWeight;
void SetTierWeights(
    const CCircuitDef@ factoryDef, int surfaceType, int tier,
    array<float>@+ weights);
array<float>@ GetTierWeights(
    const CCircuitDef@ factoryDef, int surfaceType, int tier) const;
void SetImportance(const CCircuitDef@ factoryDef, array<float>@+ values);
array<float>@ GetImportance(const CCircuitDef@ factoryDef) const;
```

`SetImportance` requires at least two values: start importance followed by
switch importance. Factory surface values are `0 = AIR`, `1 = LAND`, and
`2 = WATER`; `tier` is a key from the native factory configuration rather than
an array index.

`SetTierWeights` does not guard an invalid factory or surface/tier pair. Call
`GetTierWeights` first with a non-null registered factory and proceed only when
it returns a non-null array. A supplied array whose length differs from the
native tier vector is ignored.

```angelscript
CCircuitDef@ lab = ai.GetCircuitDef("armlab");
if (lab !is null) {
    aiFactoryMgr.SetImportance(lab, array<float> = {1.25f, 0.75f});

    array<float>@ weights =
        aiFactoryMgr.GetTierWeights(lab, 1, 1); // LAND, configured tier 1
    if (weights !is null && weights.length() > 0) {
        weights[0] *= 1.2f;
        aiFactoryMgr.SetTierWeights(lab, 1, 1, weights);
    }
}
```

### `CMilitaryManager aiMilitaryMgr`

```angelscript
IUnitTask@+ DefaultMakeTask(CCircuitUnit@ unit);
IUnitTask@+ Enqueue(const SFightTask& in request);
IUnitTask@+ EnqueueRetreat();
void DefaultMakeDefence(int cluster, const AIFloat3& in pos);
uint GetGuardTaskNum() const;
const float armyCost;
SQuotaMilitary quota;
SResponseInfo@ GetResponseInfo(Type role) const;
```

Quota views:

```angelscript
class SQuotaMilitary {
    uint scout;
    float attack;
    SRaidQuota raid;
}

class SRaidQuota {
    float min;
    float avg;
}
```

Response tuning:

```angelscript
class SResponseInfo {
    float maxPercent;
    float factor;
    SVsInfo@ GetVsInfo(Type opposingRole) const;
}

class SVsInfo {
    Type role;
    float ratio;
    float importance;
}
```

`GetResponseInfo()` performs no bounds check and never returns `null`. Pass only
a valid role type from the initialized role registry, such as a
`Unit::Role::*` type; never pass an arbitrary integer.

`GetVsInfo()` returns an existing entry or creates one initialized with zero
ratio and importance. A call that inserts an entry can reallocate the native
vector and invalidate every earlier `SVsInfo@` for that response. Obtain one
view, write through it immediately, and do not retain it:

```angelscript
SResponseInfo@ assault =
    aiMilitaryMgr.GetResponseInfo(Unit::Role::ASSAULT.type);
assault.maxPercent = 0.65f;
assault.factor = 1.0f;

SVsInfo@ versusAA = assault.GetVsInfo(Unit::Role::AA.type);
versusAA.ratio = 0.8f;
versusAA.importance = 1.5f;
@versusAA = null;
```

### `CProfiler tracy`

```angelscript
void ZoneBegin(const string& in name, uint32 color = 0);
void ZoneText(const string& in text);
void ZoneEnd();
```

Calls are effective when CircuitAI is built with profiling enabled and are
otherwise harmless:

```angelscript
tracy.ZoneBegin("Factory selection");
CCircuitDef@ selected =
    aiFactoryMgr.DefaultGetFactoryToBuild(pos, isStart, isReset);
tracy.ZoneText(selected is null ? "<none>" : selected.GetName());
tracy.ZoneEnd();
```

## Common implementation patterns

### Track task lifecycle safely

```angelscript
namespace Builder {
    dictionary activeBuilds; // task address is not exposed; key by stable data

    void AiTaskAdded(IUnitTask@ task)
    {
        IBuilderTask@ buildTask = cast<IBuilderTask>(task);
        if (buildTask is null || buildTask.buildDef is null) {
            return;
        }
        string key = buildTask.buildDef.GetName() + ":" +
            buildTask.GetBuildPos().ToString();
        activeBuilds.set(key, true);
    }

    void AiTaskRemoved(IUnitTask@ task, bool done)
    {
        IBuilderTask@ buildTask = cast<IBuilderTask>(task);
        if (buildTask is null || buildTask.buildDef is null) {
            return;
        }
        string key = buildTask.buildDef.GetName() + ":" +
            buildTask.GetBuildPos().ToString();
        activeBuilds.delete(key);
        if (!done) {
            AiLog("build task aborted: " + key);
        }
    }
}
```

For production code, prefer existing queue/count helpers in
`data/script/src/manager/builder.as` and
`data/script/src/manager/objective_manager.as`.

### Allied AI coordination

```angelscript
namespace Main {
    void AiMessage(const string& in message, int fromTeamId)
    {
        AiLog("team " + fromTeamId + " says: " + message);
    }

    void AnnounceRole(const string& in role)
    {
        AiSendMessage("role:" + role); // Broadcast to allied CircuitAI teams.
    }
}
```

Messages are delivered only to initialized CircuitAI instances on the same
ally team that implement `Main::AiMessage`.

### Factory selection with native fallback

```angelscript
namespace Factory {
    CCircuitDef@ AiGetFactoryToBuild(
        const AIFloat3& in pos, bool isStart, bool isReset)
    {
        CCircuitDef@ preferred =
            isStart ? ai.GetCircuitDef("armlab") : null;
        if (preferred !is null && preferred.IsAvailable(ai.frame)) {
            return preferred;
        }
        return aiFactoryMgr.DefaultGetFactoryToBuild(pos, isStart, isReset);
    }
}
```

Do not select a factory only because its `CCircuitDef` exists. Verify that it
is available for the active faction/options and is an effective BAR build
option for the relevant constructor.

## Maintenance and validation

When changing the script API:

1. Update C++ registration first.
2. Update this reference with the exact registered declaration and ownership
   semantics.
3. Search `data/script/` for old signatures and obsolete calls.
4. Update active policy in `data/`; do not mirror changes into `data_sample/`
   unless sample maintenance was explicitly requested.
5. Run diagnostics and `git diff --check`.
6. Load every affected profile in BAR. This repository has no standalone
   AngelScript compilation target, and warnings fail compilation at runtime.

When changing policy rather than the API, begin with
`data/script/README.md`. For historical BAR/Recoil compatibility issues and
known migration risks, also read `data/script/CHANGE_RECOMMENDATIONS.md`.
