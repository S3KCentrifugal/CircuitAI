# TECH Role

Reference for the `TECH` AngelScript role: how it is loaded, which native
callbacks reach it, which registered C++ APIs it depends on, how its decisions
are actually gated, and where it is currently broken.

Source: `data/script/src/roles/tech.as` (1923 lines), namespace `RoleTech`. Line
references are as of branch `smrt`, 2026-09-17. Prefer function names over line numbers when
navigating.

## Contents

- [Intent](#intent)
- [Loading and composition](#loading-and-composition)
- [Native contract: how C++ reaches TECH](#native-contract-how-c-reaches-tech)
- [Registered C++ APIs the role depends on](#registered-c-apis-the-role-depends-on)
- [Lifecycle](#lifecycle)
- [The unit-cap system](#the-unit-cap-system)
- [Decision flows](#decision-flows)
- [Known defects](#known-defects)
- [Fix plan](#fix-plan)
- [Optimisation opportunities](#optimisation-opportunities)

## Intent

TECH is the economy-first role. It suppresses early combat production, races to
T2 and T3 infrastructure, and converts surplus metal into build power. Its
design assumption is that allied roles (FRONT, TACTICAL, AIR, SEA) supply
fighting units while TECH supplies economy, factories and superweapons.

That assumption is why almost every combat unit starts capped at zero. The role
is only correct if those caps are later *released* at the right moments, and
that release path is where its current failures live.

## Loading and composition

The profile's `main.as` includes `src/setup.as`, which composes the module:

```text
data/script/<profile>/main.as
  +-- src/setup.as
        +-- helpers/{generic,map,unit,role,limits}_helpers.as
        +-- global.as                 <- Global::RoleSettings::Tech constants
        +-- maps.as, maps/factory_mapping.as
        +-- roles/{front,support,air,tech,sea,tactical}.as
        +-- types/role_config.as      <- RoleConfig + funcdefs
        +-- manager/{military,builder,factory,economy}.as
```

Only the `experimental_*` profiles include `setup.as`; the legacy `easy`,
`medium`, `hard` and `hard_aggressive` profiles do not, so TECH does not exist
there.

Roles are included *before* `role_config.as` and the managers. AngelScript
resolves declarations module-wide, so the ordering is not a constraint on use,
but it does mean a role file cannot rely on manager-local state at include time.

## Native contract: how C++ reaches TECH

No native code knows about TECH. C++ looks up a fixed set of callbacks per
namespace (`CScriptManager::GetFunc`, resolved in each `*Script.cpp::Init`); the
manager namespace implements them and dispatches to the active role through a
`RoleConfig` delegate. TECH registers its handlers near the end of `tech.as`.

| Native lookup | Namespace fn | RoleConfig delegate | TECH handler |
| --- | --- | --- | --- |
| `IUnitTask@ AiMakeTask(CCircuitUnit@)` | `Factory::AiMakeTask` | `FactoryAiMakeTaskHandler` | `Tech_FactoryAiMakeTask` |
| `IUnitTask@ AiMakeTask(CCircuitUnit@)` | `Builder::AiMakeTask` | `BuilderAiMakeTaskHandler` | `Tech_BuilderAiMakeTask` |
| `IUnitTask@ AiMakeTask(CCircuitUnit@)` | `Military::AiMakeTask` | `MilitaryAiMakeTaskHandler` | `Tech_MilitaryAiMakeTask` |
| `void AiTaskAdded(IUnitTask@)` | `Builder::AiTaskAdded` | `BuilderAiTaskAddedHandler` | `Tech_BuilderAiTaskAdded` |
| `void AiTaskRemoved(IUnitTask@, bool)` | `Builder::AiTaskRemoved` | `BuilderAiTaskRemovedHandler` | `Tech_BuilderAiTaskRemoved` |
| `void AiUnitAdded(CCircuitUnit@, Unit::UseAs)` | `Builder::AiUnitAdded` | `BuilderAiUnitAdded` | `Tech_BuilderAiUnitAdded` |
| `void AiUnitAdded(CCircuitUnit@, Unit::UseAs)` | `Factory::AiUnitAdded` | `FactoryAiUnitAdded` | `Tech_FactoryAiUnitAdded` |
| `void AiUnitRemoved(CCircuitUnit@, Unit::UseAs)` | `Builder::AiUnitRemoved` | `BuilderAiUnitRemoved` | `Tech_BuilderAiUnitRemoved` |
| `void AiUnitRemoved(CCircuitUnit@, Unit::UseAs)` | `Factory::AiUnitRemoved` | `FactoryAiUnitRemoved` | `Tech_FactoryAiUnitRemoved` |
| `void AiUpdateEconomy()` | `Economy::AiUpdateEconomy` | `EconomyUpdateHandler` | `Tech_EconomyUpdate` |
| `bool AiIsSwitchTime(int)` | `Factory::AiIsSwitchTime` | `AiIsSwitchTimeHandler` | `Tech_AiIsSwitchTime` |
| `bool AiIsSwitchAllowed(CCircuitDef@)` | `Factory::AiIsSwitchAllowed` | `AiIsSwitchAllowedHandler` | `Tech_AiIsSwitchAllowed` |
| `int AiMakeSwitchInterval()` | `Factory::AiMakeSwitchInterval` | `MakeSwitchIntervalHandler` | `Tech_MakeSwitchInterval` |
| `CCircuitDef@ AiGetFactoryToBuild(...)` | `Factory::AiGetFactoryToBuild` | `SelectFactoryHandler` | `Tech_SelectFactoryHandler` |
| `void AiMakeDefence(int, const AIFloat3& in)` | `Military::AiMakeDefence` | `AiMakeDefenceHandler` | `Tech_AiMakeDefence` |
| `void AiUpdate()` | `Main::AiUpdate` | `MainUpdateHandler` (RoleConfig constructor argument) | `Tech_MainUpdate` |

Two further slots are script-only and have no native lookup: `InitHandler`
(`Tech_Init`, run once from `Setup` after the role is matched) and
`RoleMatchHandler` (`Tech_RoleMatch`, the predicate `RoleConfigs::Match` asks
to claim a start spot for TECH).

Callbacks C++ looks up that **nothing** implements, so the native default
applies silently:

- `Main::AiMessage`, `Main::AiUnitFinished`, `Main::AiUnitDestroyed`
- `Economy::AiUnitAdded` / `AiUnitRemoved` - `CEconomyManager` dispatches 12
  calls with `UseAs::ENERGY/GEO/MEX/CONVERT/STORE/AIRPAD` that no script sees.
  The script-side `Unit::UseAs` enum in `unit.as` also stops at `ASSIST` and
  omits those six values, so they have no script-side name either.

## Registered C++ APIs the role depends on

Registration is authoritative in `src/circuit/script/`. A native method is not
script-visible unless registered there.

### The gate that governs nearly everything

```cpp
// src/circuit/unit/CircuitDef.h
int  maxThisUnit;                                   // registered, writable
bool IsAvailable() const { return maxThisUnit > count; }
bool IsAvailable(int frame) const { return IsAvailable() && (frame >= sinceFrame); }
```

`UnitHelpers::BatchApplyUnitCaps(list, n)` writes `cdef.maxThisUnit = n`. Every
enqueue path in the role and in `Builder`/`Factory` checks
`def.IsAvailable(ai.frame)` before queueing. **A cap of 0 makes a unit
permanently unbuildable, silently** - the enqueue helper returns `null` and the
caller falls through to `DefaultMakeTask`.

This single fact explains most of the role's observable failures.

### Other APIs used

| API | Registered in | Used for |
| --- | --- | --- |
| `aiFactoryMgr.Enqueue(TaskS::Recruit(...))` | `FactoryScript.cpp` | all unit production |
| `aiFactoryMgr.DefaultMakeTask(u)` | `FactoryScript.cpp` | fallback production |
| `aiFactoryMgr.isAssistRequired` | `FactoryScript.cpp` | request factory assist |
| `aiBuilderMgr.Enqueue(TaskB::*)` | `BuilderScript.cpp` | all construction |
| `aiBuilderMgr.DefaultMakeTask(u)` | `BuilderScript.cpp` | fallback construction |
| `aiEconomyMgr.metal` / `.energy` (`SResourceInfo`) | `EconomyScript.cpp` | `current`, `storage`, `pull`, `income` |
| `aiEconomyMgr.isEnergyFull` and siblings | `EconomyScript.cpp` | economy state, written by `Economy::AiUpdateEconomy` |
| `cdef.SetIgnore(bool)` via `UnitDefHelpers::SetIgnoreFor` | `InitScript.cpp` | exclude units from native selection |
| `cdef.SetMainRole(Type)` via `UnitDefHelpers::SetMainRoleFor` | `InitScript.cpp` | retag labs support/static |
| `ai.GetCircuitDef(name)`, `ai.GetTeamUnit(id)`, `ai.frame` | `InitScript.cpp` | lookups |

Notably **unused and unavailable**: `GetBuildTime`, `GetBuildSpeed`,
`GetWorkerTime` and `IsAssistable` exist on `CCircuitDef` but are *not
registered*, so the role cannot reason about build power or completion time.
Every "how much build power" decision is a proxy on unit counts and income.

## Lifecycle

```text
Init::AiInit()                     profile init.as - categories, armor, profile name
Main::AiMain()                     registerMaps, ApplyTechStrategyWeights,
                                   aiEnemyMgr.maxAAThreat, factory tier attrs,
                                   ApplyProfileSettings -> RoleConfigs -> Tech_Init
  Tech_Init()                      Tech_ApplyStartLimits(), Tech_ApplyAttributes()
Main::AiUpdate()      every 30f    Military caches; profileController.MainUpdate
                                   -> Tech_MainUpdate()
Economy::AiUpdateEconomy()         recomputes isMetalEmpty/isEnergyStalling/... then
                                   -> Tech_EconomyUpdate()
                                        Tech_IncomeBuilderLimits(metalIncome)
                                        storage unlock, gantry cap, T2 lab cap,
                                        T1 eco-threshold block,
                                        Tech_UpdateLandLockedWaterExpansion
Factory::AiMakeTask()  per factory  -> Tech_FactoryAiMakeTask()
Builder::AiMakeTask()  per builder  -> Tech_BuilderAiMakeTask()
```

## The unit-cap system

`Tech_ApplyStartLimits()` runs once and locks the role down. Values come from
`Global::RoleSettings::Tech` in `global.as`.

| Category | Start cap | Raised later? |
| --- | --- | --- |
| T1 combat units | `0` | only T1 **bot scouts** and **vehicle scouts** to 100, and only at `mi >= 200` |
| T2 combat units | `0` | only the **gated T2 bots** (`Tech_GetGatedT2Bots`: rush bots Sprinter/Fiend/Hoplite plus amphibious Platypus/Duck/Telchine). Their engine caps are snapshotted before the blanket cap and restored by `Tech_UncapRushBots` in `Tech_EconomyUpdate` once `mi >= MetalIncomeThresholdForEarlyBotLabExpansion` (100), one-way. Everything else never |
| T1/T2 air combat | `0` | never |
| Fast-assist bots | `50`, then dynamic | `Tech_IncomeBuilderLimits`: `5*floor(mi/45)` below 100 income, `5*floor(mi/20)` above |
| T1 bot labs | `1` | to 3 at `mi >= 200` |
| T2 bot labs | `1` | income-derived, clamped to `MaxT2BotLabs` (3) |
| T1 vehicle plants | `0` | to 3 at `mi >= 200` |
| T2 vehicle plants | `0` | never (deliberate) |
| Hover plants (land and floating), T1/T2 shipyards | `0` | only on a landlocked start: `Tech_UpdateLandLockedWaterExpansion` raises them to `LandLockedMaxT1Shipyards` / `LandLockedMaxT2Shipyards` / `LandLockedMaxHoverPlants` (1 each) at `mi >= MetalIncomeThresholdForLandLockedWaterExpansion` (200); see [Landlocked water expansion](#landlocked-water-expansion) |
| Land defences | `0` | never (deliberate; AA and LRPC are not in that list) |
| T1 solar | `4` | - |
| Fusion / advanced fusion | `0` | via builder-side logic |
| T1 metal storage, advanced storages | `0` | unlocked at income thresholds |

Two further lockdowns in `Tech_ApplyStartLimits`:

- `UnitDefHelpers::SetIgnoreFor(GetAllT1CombatUnits(), true)` sets
  `cdef.SetIgnore(true)`, which native code consults independently of caps.
- `UnitDefHelpers::SetMainRoleFor(GetAllT1T2LandLabsAndAircraftPlants(),
  "support")` tags T1/T2 bot, vehicle and air plants as `support` until the
  `mi >= 200` block retags land labs to `static`.

## Decision flows

### Tech_FactoryAiMakeTask

Evaluated top to bottom; the first branch that returns a task wins.

```text
1  gantry lab?        mi > 200 -> EnqueueGantrySignatureBatch(5)      else DefaultMakeTask
2  T1 bot lab?        t1Ctors < MinimumT1ConstructorBots (2) -> recruit T1 constructor
3  T2 bot lab?        t2Ctors < MinimumT2ConstructorBots (1) -> recruit T2 constructor
4  T2 bot lab?        PRIMARY lab only: fast-assist bot if below dynamic cap
                      and metal.current > 2000
5  primary air plant? air constructors < 100 -> recruit
6  T1 bot lab?        mi >= botLabGate -> 10x T1 scout (or amphib AA if landlocked)
7  T2 bot lab?        mi >= botLabGate -> 10x fast T2 bot (or amphib if landlocked)
8  T1/T2 vehicle plant? mi >= vehiclePlantGate -> 10x scout / main battle tank
9  fallback           aiFactoryMgr.DefaultMakeTask(u)
```

`botLabGate` and `vehiclePlantGate` depend on `Strategy::T2_RUSH` (85% chance
per profile `main.as`): the early thresholds apply when enabled, the higher ones
when not.

### Tech_BuilderAiMakeTask

Pre-computes the native `defaultTask`, then overrides. MEX/MEXUP/GEO/GEOUP and
ENERGY default tasks are returned immediately. Otherwise dispatch by constructor
type - `Tech_Commander_AiMakeTask`, `Tech_T1BotConstructor_AiMakeTask`,
`Tech_T2BotConstructor_AiMakeTask`, `Tech_T2FastAssistBotConstructor_AiMakeTask`,
`Tech_T1AirConstructor_AiMakeTask`, `Tech_T2AirConstructor_AiMakeTask` - each an ordered ladder of
`EconomyHelpers::Should*` income predicates calling `Builder::EnqueueXxx`
wrappers. Energy branches are gated by `Tech_RedirectEnergyToReactor`, which
diverts to `Builder::EnqueueAssistReactor` while a Fusion or Advanced Fusion is
under construction.

### Landlocked water expansion

A start spot the map script flags `landLocked` (`StartSpot.landLocked`, copied
to `Global::Map::LandLocked` in `setup.as`) is ground the land army cannot
leave, so TECH techs with a bot lab there and leaves with amphibious units. On
such a start only, TECH may also place water factories once the economy is
strong:

- `Tech_UpdateLandLockedWaterExpansion(metalIncome)` runs at the end of
  `Tech_EconomyUpdate`. Once `mi >= MetalIncomeThresholdForLandLockedWaterExpansion`
  (200) it sets `hasUnlockedLandLockedWaterFactories` and raises the caps on T1
  shipyards, T2 shipyards, land hover plants and floating hover plants to the
  `LandLockedMax*` settings (1 each). One-way; re-applied every pass because
  `Tech_IncomeBuilderLimits` and the storage unlock re-apply
  `Global::Map::MergedUnitLimits`, which can re-cap these defs.
- `Tech_TryEnqueueLandLockedWaterFactory(...)` is a step in the
  `Tech_T2BotConstructor_AiMakeTask` ladder, right after the gantry step. While
  unlocked it tries, in order: a T1 shipyard via `Builder::EnqueueT1Shipyard`
  (anchored on the T2 bot lab with `LandLockedShipyardSearchRadius`, 960 elmos,
  because the footprint must land in water); a hover plant via
  `Builder::EnqueueT1HoverPlant` then `Builder::EnqueueFloatingHoverPlant`; and a
  T2 shipyard through `EconomyHelpers::ShouldBuildT2Shipyard` (needs a primary
  T1 shipyard and `LandLockedMinEnergyIncomeForT2Shipyard`, 2000) via
  `Builder::EnqueueT2Shipyard`. Each wrapper enforces its own cooldown and the
  caps, so a step at cap yields to the next.
- The native factory chooser never places these on its own: in the experimental
  `factory.json` the switch importance of shipyards and hover plants is 0, so the
  script step is the only path. A start that is not landlocked keeps all four
  caps at 0 for the whole game.
- Production from the placed factories goes through `DefaultMakeTask`; the T1
  naval and hover combat lists are not part of the T1 combat cap, so the native
  chooser builds them normally.

## Known defects

### D1 - T2 combat units were permanently unbuildable (fixed 2026-09-16/17)

Historically `Tech_ApplyStartLimits` zeroed every unit in `GetAllT2CombatUnits()`
and the raise was commented out, so `Tech_EnqueueUnitBatch` failed `IsAvailable`
and non-primary T2 labs produced nothing. Current behaviour: the engine caps of
the gated T2 bots are snapshotted at start (`Tech_GetGatedT2Bots`) and released
by `Tech_UncapRushBots` at the rush income gate; the amphibious bots were added
to that set on 2026-09-17 so the land-locked substitution in step 7 works for
all three factions. Releasing at start instead was tried and reverted: native
production has no income gate, so uncapped bots were built from the first T2 lab
at 18 income and stalled the economy. See the comment above `Tech_ApplyStartLimits`.

### D2 - armfast was filed as a T1 unit (fixed 2026-09-17)

The six T1/T2 combat lists in `unit_helpers.as` were rebuilt from the labs'
effective `buildoptions` (commit `a789bd3d`); `armfast` and the other misfiled
units now sit in the T2 lists. `tools/knowledge/check_unit_helpers.py` verifies
the lists against the shared game cache.

### D3 - no combat units at all below 200 metal income

Both scout raises live inside the `hasAppliedT1EcoThreshold` block, gated on
`mi >= MetalIncomeThresholdForBotLabExpansion` (200). Until then every combat
unit in the role is capped at 0. For an economy role this may be intended, but
it means TECH contributes nothing for a long opening and cannot defend itself.

### D4 - the fast-assist cap never saturates

`g_fastAssistBotCap` is `5*floor(mi/20)` above 100 income - unbounded, with a
2.5x discontinuity at exactly `mi = 100` (10 to 25). Fast-assist bots raise
income, which raises the cap, so `haveAssist` never catches it. Before the
primary-lab guard was added this starved the T2 combat batch entirely; it is now
contained to the primary lab, but the cap is still a runaway.

The secondary gate `metal.current > 2000` is a **stock** test, not an income
test, so it is effectively always true once storage exists.

### D5 - economy unit events are invisible to script

`Economy::AiUnitAdded`/`AiUnitRemoved` are unimplemented and the script `UseAs`
enum omits `ENERGY, GEO, MEX, CONVERT, STORE, AIRPAD`. TECH cannot react to its
own economy structures appearing or dying, and the script enum silently diverges
from `IModule::UseAs` in `Module.h` - a reordering there would mis-dispatch
every implemented handler.

### D6 - T3 gantry produces nothing (cause not confirmed)

Observed: gantry built, no production. Candidates, most likely first:

1. `mi <= 200` at the time, so the branch falls to `DefaultMakeTask`, which has
   no uncapped units to choose - a consequence of D1 and D3.
2. `GetGantrySignatureUnitForSide` returns `armbanth` (Titan) or `corkorg`
   (Juggernaut), both carrying `TODO: confirm` comments in-source. Neither
   appears in any capped list, so caps are not the issue, but an unresolved def
   name returns `null`.
3. Labs tagged `mainRole = support` may not be selected by the native factory
   manager for recruitment.

Resolve from a log filtered to the gantry's team - the branch logs
"Gantry detected" and the enqueue result.

### D7 - more T2 bot labs than the cap allows (unconfirmed)

Four labs were observed against a clamp of `MaxT2BotLabs = 3`.
`BatchApplyUnitCaps` writes the cap onto *each* def in
`GetAllT2BotLabs() = {armalab, coralab, legalab}` separately, so the clamp is
per-def, not per-team. A single-side team should still be limited to 3. Needs a
log check before being treated as a defect.

## Fix plan

Ordered by impact. Items 1-2 are applied; the rest are not.

1. ~~Restore the T2 combat cap raise (D1).~~ Done: gated T2 bots released at
   the rush income gate (`Tech_UncapRushBots`). Open question: whether the
   rest of `GetAllT2CombatUnits()` should ever be released for TECH.
2. ~~Move `armfast` to the T2 list (D2).~~ Done in the unit-helper review.
3. **Decouple the scout-cap release from `mi >= 200` (D3).** The gated T2 bots
   already release at `botLabGate`; the T1 scout raise still waits for 200.
4. **Bound `g_fastAssistBotCap` (D4)** with an absolute ceiling, and replace the
   `metal.current > 2000` stock test with an income or ratio test.
5. **Implement `Economy::AiUnitAdded`/`AiUnitRemoved` and extend the script
   `Unit::UseAs` enum to all 14 values (D5).**
6. **Confirm D6 and D7 from a log** before changing code.

## Optimisation opportunities

- **Cap churn.** `BatchApplyUnitCaps` runs over large lists every economy
  update. It early-outs when the value is unchanged, but the lists are rebuilt
  on each call. Cache the arrays at init.
- **Threshold ladders instead of ranking.** Production and construction choices
  are hand-tuned income thresholds. `GetMetalMake`/`GetEnergyMake` are registered
  and unused; marginal return per metal is computable today.
- **`buildpowerRatio` is never read.** It is the builder-vs-military build-power
  split and the most direct lever available to an economy role.
- **Priority discipline.** The role never uses `Priority::LOW`. Native scores
  candidate tasks by `distCost / (priority+1)^2`, so `LOW` is the tool for
  "only if a builder is already nearby", and `NOW` should be reserved for real
  unblocks - it flattens distance by 2500x and bypasses the stall gate in
  `CBuilderManager::MakeBuilderTask`.
- **Cap writes are global.** They set `maxThisUnit` on shared `CCircuitDef`s and
  can override map-specific limits in `Global::Map::MergedUnitLimits`, depending
  on call order within `Tech_EconomyUpdate`.

## Open investigations

- [`doc/t2-constructor-stall.md`](../t2-constructor-stall.md) - T2 construction
  bots idle for minutes after mex upgrades while T1 keeps building. Diagnosed to
  native `MakeBuilderTask` stall gating plus `MEXUP` not being in
  `IsIgnoreStallingPull`; fix undecided.

## Related

- `doc/angelscript-references.md` - script loading model, callback contracts,
  registered API, ownership rules.
- `skills/convention-angelscript/SKILL.md` - language and safety conventions.
- `skills/troubleshoot-bar-logs/SKILL.md` - reading the `:::AI LOG` stream to
  confirm any of the unconfirmed items above.

<!-- source: data/script/src/roles/tech.as; blob: 66748ddd129ea641114ed1329c1af49c99bbe033; lines: 2025 -->
