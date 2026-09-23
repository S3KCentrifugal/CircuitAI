# TECH Role

Reference for the `TECH` AngelScript role: how it is loaded, which native
callbacks reach it, which registered C++ APIs it depends on, how its decisions
are actually gated, and where it is currently broken.

Source: `data/script/src/roles/tech.as` (2432 lines), namespace `RoleTech`. Line
references are as of branch `smrt`, 2026-09-20. Prefer function names over line numbers when
navigating.

## Contents

- [Intent](#intent)
- [Loading and composition](#loading-and-composition)
- [Native contract: how C++ reaches TECH](#native-contract-how-c-reaches-tech)
- [Registered C++ APIs the role depends on](#registered-c-apis-the-role-depends-on)
- [Lifecycle](#lifecycle)
- [The unit-cap system](#the-unit-cap-system)
- [Mex upgrade priority](#mex-upgrade-priority)
- [Decision flows](#decision-flows)
- [Known defects](#known-defects)
- [Fix plan](#fix-plan)
- [Optimisation opportunities](#optimisation-opportunities)
- [Floating metal](#floating-metal)
- [Transport ferry](#transport-ferry)

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
| `void AiTaskRemoved(IUnitTask@, bool)` | `Military::AiTaskRemoved` | `MilitaryAiTaskRemovedHandler` | `Tech_MilitaryAiTaskRemoved` (drops the nuke first-strike task handle) |
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
| `void AiMakeDefence(int, const AIFloat3& in)` | `Military::AiMakeDefence` | `AiMakeDefenceHandler` | `Tech_AiMakeDefence`; below `MilitaryDefenceMetalIncomeThreshold` it calls `Military::Porc::MakeDefence` (shared porcupine policy, `manager/porc_policy.as`), which sets the native porc mode and budget and then places natively |
| `void AiUpdate()` | `Main::AiUpdate` | `MainUpdateHandler` (RoleConfig constructor argument) | `Tech_MainUpdate` |

Two further slots are script-only and have no native lookup: `InitHandler`
(`Tech_Init`, run once from `Setup` after the role is matched) and
`RoleMatchHandler` (`Tech_RoleMatch`, the predicate `RoleConfigs::Match` asks
to claim a start spot for TECH). `LayoutPlanHandler` is also script-only:
`LayoutHelpers::ApplyForRole` invokes `Tech_LayoutPlan` after TECH's limits
and porcupine chain are applied.

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
| T1 combat units | `0` | only T1 **bot scouts** and **vehicle scouts** to 100, and only at `mi >= 200`; with the experimental system on, bot scouts wait for the combat gate below (D-068) |
| T2 combat units | `0` | only the **gated T2 bots** (`Tech_GetGatedT2Bots`: rush bots Sprinter/Fiend/Hoplite plus amphibious Platypus/Duck/Telchine). Their engine caps are snapshotted before the blanket cap and restored by `Tech_UncapRushBots` in `Tech_EconomyUpdate` once `mi >= MetalIncomeThresholdForEarlyBotLabExpansion` (100), one-way - raised to `ExpCombatMetalIncome` (200; 0 = never) by `Tech_CombatGate` while the experimental system is on, together with the bot-lab and vehicle-plant batch gates of `Tech_FactoryAiMakeTask` ([D-068](../decisions.md#d-068--tech-makes-no-combat-unit-before-the-combat-gate-packed-sites-are-for-structures-only)); logged once as `[TECH][Factory] combat production unlocked`. Everything else never |
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

## Mex upgrade priority

Ahead of this role's energy ladder, `Builder_AiMakeTask` calls
`EconomyHelpers::EnqueueMexUpgradeIfFirst`. A metal extractor upgrade is the
best metal-per-metal available (roughly 1.9x a T2 converter once the
converter's 600 E/s is priced as advanced fusion) and metal spots are finite
while converters are not, so an upgrade outranks everything that merely
converts energy.

The gate answers only for constructors of tier 2 or above — a T1 builder
cannot place the advanced extractor and falls straight through — and it skips a
spot that is already being upgraded. Ownership and upgrade state come from
`Economy::MexTracker`, which is now fed role-independently from
`Builder::AiTaskAdded` / `AiTaskRemoved` rather than from TECH alone.

Settings: `Global::RoleSettings::MexUpgradeFirst`, `MexUpgradeRadius` (2500),
`MexUpgradeMaxConcurrent` (1). See `KI-213` in
[`../known-issues.md`](../known-issues.md).

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

Pre-computes the native `defaultTask` (`Builder::MakeDefaultTaskWithLog`),
then overrides. A MEX/GEO/GEOUP default is returned immediately and a MEXUP
default is redirected to an owned mex. Otherwise dispatch by constructor
type - `Tech_Commander_AiMakeTask`, `Tech_T1BotConstructor_AiMakeTask`,
`Tech_T2BotConstructor_AiMakeTask`, `Tech_T2FastAssistBotConstructor_AiMakeTask`,
`Tech_T1AirConstructor_AiMakeTask`, `Tech_T2AirConstructor_AiMakeTask` - each an ordered ladder of
`EconomyHelpers::Should*` income predicates calling `Builder::EnqueueXxx`
wrappers. Energy branches are gated by `Tech_RedirectEnergyToReactor`, which
diverts to `Builder::EnqueueAssistReactor` while a Fusion or Advanced Fusion is
under construction, and otherwise to `Builder::EnqueueAssistEnergy` while the
T1 energy structure the script last queued is under construction (see
[Energy focus](#energy-focus)).

### Energy focus

Three constructors used to have three energy structures going at once - a
solar, an advanced solar and a second solar - each at a third of the build
power, while the user's expectation is one structure at a time finished
fast. Two causes, one native and one in this role
([D-037](../decisions.md#d-037--builders-focus-one-energy-structure-and-unused-default-tasks-are-discarded)):

1. **The pre-created default task was never thrown away.**
   `aiBuilderMgr.DefaultMakeTask` does not just *pick* a task, it **enqueues**
   the one it returns - `CEconomyManager::UpdateEnergyTasks` adds an ENERGY
   task to the builder queue, and the ladder's own solar is a FACTORY-type
   task that the native energy count never sees. When the ladder returned its
   own task, the native one stayed in the queue for `ASSIGN_TIMEOUT` (300 s)
   and the next idle constructor took it. Every role's builder policy has the
   same shape, so this is fixed natively: `CBuilderManager::MakeTask`
   remembers the tasks `DefaultMakeTask` created for that call and aborts the
   ones the policy did not return; `IBuilderTask::Reevaluate` discards the
   one it makes and does not use. The native line
   `BUILDER: discarded N unused default task(s) in the last minute` shows it
   working.
2. **Nothing assisted.** The only assist the ladder knew was the reactor one.
   `Builder::EnergyBuildTask` now tracks the last T1 solar, advanced solar or
   converter the script queued; `Tech_RedirectEnergyToReactor` calls
   `Builder::EnqueueAssistEnergy` before every energy rung, which puts up to
   `EnergyFocusMaxAssists` (3) constructors onto that structure with a
   `Repair` task. A repair of an unfinished structure is the engine's assist,
   and the task **ends when the structure completes**, so the constructor
   re-plans immediately instead of trailing another builder.

Related stall: a constructor blocked by the solar cooldown used to *guard the
previous builder* for 200 s (`Builder::TryAssignBuilderAssistOnCooldown`),
which outlived the solar by minutes and looked like a stalled constructor.
It now assists the structure when one is up, and otherwise guards for
`COOLDOWN_GUARD_TIMEOUT_FRAMES` (30 s).

| Setting (`Global::RoleSettings::Tech`) | Default | Effect |
| --- | --- | --- |
| `EnergyFocusAssist` | true | false restores the old ladder (each constructor starts its own structure) |
| `EnergyFocusMaxAssists` | 3 | constructors allowed on one energy structure at a time |

Level-1 log: `[BUILDER] EnqueueAssistEnergy: <def>(<id>) assists=k/max`.
Not Played.

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

### Donations

Two hand-outs, both in `Team::Donation` (`manager/donation.as`), see
[Donations](#donations-t2-bots-by-plan-constructors-on-request) below.
`Tech_MilitaryAiUnitAdded` (wired to `MilitaryAiUnitAdded`) calls
`OnCombatBotBuilt` for every finished military unit: N of the T2 combat bots
the advanced lab batches go to the closest allies. `Tech_BuilderAiUnitAdded`
calls `OnConstructorBuilt` for every finished builder: a T2 constructor goes
to the oldest teammate that asked for one, and is otherwise TECH's own.

### Nuke first strike (fixed 2026-09-18 crash)

`Tech_MilitaryAiMakeTask` gives the first nuke silo its native `CSuperTask` via
`aiMilitaryMgr.DefaultMakeTask` and forces the farthest TECH start as its
target with `CSuperTask::SetTargetPos`; `Tech_UpdateNukeFirstStrike` (from
`Tech_MainUpdate`) clears the override after `NukeFirstStrikeOverrideSeconds`
(30) so native targeting resumes, and `Tech_MilitaryAiTaskRemoved` drops the
handle if the task dies first. It used to return a **factory-manager**
`TaskS::Wait` for the silo: the military idle list never released the unit, it
later also received a super task, the expired Wait re-parented it to the factory
idle task, and when the silo died the super task kept a freed pointer and
crashed in `CSuperTask::ExecuteAttack` (infolog f=37389). Native
`ITaskModule::AssignTask` now refuses tasks of another manager and logs it.

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

## Donations: T2 bots by plan, constructors on request

Decision: [D-041](../decisions.md#d-041--tech-donates-t2-bots-by-plan-and-t2-constructors-only-on-request).

**T2 combat bots, by plan.** `Team::Donation::OnCombatBotBuilt` runs from
`Tech_MilitaryAiUnitAdded` for every finished military unit and acts on the
bots the advanced lab batches - `GetAllFastT2Bots()` (Sprinter, Fiend,
Hoplite) and `GetAllAmphibiousT2Bots()` for landlocked starts:

1. **Draw the count once**, when the first such bot appears:
   `DrawCount(T2BotDonationMin, T2BotDonationMax)` builds a geometric weight
   list `1, 0.6, 0.36, ...` (`T2BotDonationDecay`) over Min..Max and makes
   one roll in 0-999 over the cumulative weights, so the minimum (2) is the
   most likely outcome and the maximum (7) the least. That is the plan for
   the game.
2. **Pick a recipient per bot.** `PickRecipient` is the *closest* ally with
   the *fewest* donations so far (`givenTo`, read through the
   `exists()`-guarded `Count()` - [D-019](../decisions.md#d-019--donation-counts-are-read-and-written-as-int64),
   [D-025](../decisions.md#d-025--a-dictionary-out-is-undefined-after-a-miss-check-exists-first)).
3. **Give it** with `ai.GiveUnits`; the recipient's military adopts it. The
   ferry is not involved: it exists for constructors.
4. **Stop at the plan.** `botGiven >= botPlanned` ends it silently.

**T2 constructors, on request.** TECH never donates a constructor on its
own. Any teammate may ask - `Team::Donation::RequestConstructor(why)`, which
broadcasts `barbdon|conreq` - and `Update()` asks automatically for a
non-TECH BARb that has no T2 constructor and no T2 lab of its own once its
sliding-minimum metal income clears `Global::ConstructorRequest::
RequestMinMetalIncome` (15) - but only once a TECH ally is on the roster
(`_HasTechAlly`), and at most `MaxRequests` (1) times, so under the default
there is no automatic retry; `RequestCooldownSeconds` only spaces requests
when the limit is raised. TECH always answers:

1. `HandleMessage` queues the requester (`pendingRequests`) and replies
   `ack`.
2. `Team::Donation::FactoryMakeTask` runs from `Factory::AiMakeTask` before
   the role handler, like the ferry's: while requests outnumber orders, the
   advanced bot lab's next task is one T2 constructor at HIGH priority. An
   order the lab has not delivered within `OrderTimeoutSeconds` is
   re-placed.
3. `OnConstructorBuilt` gives the next T2 constructor to finish to the
   oldest requester - **flown by the ferry transport when TECH owns one**
   (`Team::Ferry::TryCarry`, [`../transport-ferry.md`](../transport-ferry.md)),
   walked with `ai.GiveUnits` when it does not - and sends `sent|<id>`.

| Setting | Default | Where |
| --- | --- | --- |
| `T2BotDonationMin` / `Max` / `Decay` | 2 / 7 / 0.6 | `Global::RoleSettings::Tech` |
| `Enabled` | true | `Global::ConstructorRequest` |
| `RequestMinMetalIncome` | 15 | requester's sliding-minimum metal income |
| `MaxRequests` | 1 | automatic requests per game per requester |
| `RequestCooldownSeconds` | 300 | between re-asks |
| `AutoRequestFromSupport` | false | SUPPORT ("front tech") techs on its own and never asks automatically; its explicit `RequestConstructor` is still served ([D-046](../decisions.md#d-046--support-never-receives-an-unrequested-t2-constructor)) |
| `OrderTimeoutSeconds` | 240 | TECH re-places an undelivered order after this |

Every decision logs at **level 1**: `Plan: donate N T2 bots`,
`PickRecipient -> team T`, `Gave T2 bot #k`, `constructor request from team
T queued`, `TECH: ordered <def> for team T`, `requested constructor ...
being ferried` / `Gave requested constructor`, and `is ours: no request
pending` for a constructor nobody asked for.

**Known limits.** With two TECH players on a team both answer a request, so
the requester may receive two constructors. A requester with no TECH ally
never asks. Not Played.

**Donations keep TECH's own first.** `Team::Donation` orders no T2
constructor for an ally, and keeps a built one, while TECH owns fewer than
`DonationKeepT2Constructors` (2); played, every one it built was ferried
away and the advanced lab built nothing else.

## Floating metal

TECH was seen queuing construction turrets one after another with nothing
under construction for them to assist, metal overflowing, and no advanced
converter or nuclear silo started. Two causes, one per constructor tier.

**T1 constructors.** `EconomyHelpers::ShouldBuildT1Nano` returned
`(have < want) || reservesOk`, and `reservesOk` is "metal >= 1000 and energy
>= 90%" - true on every idle poll of a floating economy, unrelated to demand,
with no ceiling short of `NanoMaxCount` (200). That is the spam. The
reserves branch is now capped: it may add at most `NanoReserveSurplus` (2)
nanos beyond the income-derived target.

**T2 constructors.** Every rung of `Tech_T2BotConstructor_AiMakeTask` -
gantry, advanced converter, anti-nuke, advanced fusion, fusion, silo - is
gated on *income*. A full bank on a modest income clears none of them: the
converter wants 1 200 energy income, the fusions their own floors, the silo
its own. So the bank sat.

`Tech_FloatSpend` now runs at the top of both policies while metal is
floating - the gate is `Tech_IsFloating`: `aiEconomyMgr.isMetalFull`, or
current >= `FloatMetalCurrent` 2 500, with income >= `FloatMetalIncome` 25
either way:

| Constructor | Floating action |
| --- | --- |
| T2 | advanced converter if energy income >= `FloatConverterMinEnergyIncome` (800); otherwise the energy first - advanced fusion when the bank is >= `FloatAFUSMetalCurrent` (6 000), a fusion below that; then a nuclear silo if fewer than `FloatMaxNukeSilos` (1) exist or are queued |
| T1 | guard the primary T2 constructor - it cannot build any of the above, so it assists the one that can; with no T2 constructor, the normal ladder with capped nanos |

Every action logs at level 1 as `[TECH][Float] ...`. Settings are the
`FLOATING METAL` block in `Global::RoleSettings::Tech`.

## Transport ferry

TECH no longer walks its donated T2 constructors. Once its sliding-minimum
metal income clears `Global::Ferry::RequestMinMetalIncome` (20) while it owns
no transport, `Team::Ferry::_AutoRequest` broadcasts a request; the AIR player
on the team builds an air transport, flies it to TECH's base and transfers it
there. If TECH still owns none after `RequestCooldownSeconds` (180) — the
transport died, or AIR was busy — it asks again. From then on `Team::Donation::OnConstructorBuilt` offers each donation
to `Team::Ferry::TryCarry` before falling back to `ai.GiveUnits`, and the
transport flies the constructor to the recipient's base and returns home.

The request was originally tied to the first T2 lab task being enqueued,
which is when TECH *plans* the lab rather than when a builder starts it, and
the transport arrived far too early. Income is the signal now. Every failure
path walks the constructor exactly as before.

One TECH-specific trap: `Tech_MilitaryAiMakeTask` returns **null** for every
military unit until metal income reaches 50, which withheld the transport's
`CFerryTask` for the whole window in which the donations happen.
`Military::AiMakeTask` now routes any ferry transport to the native default
task before this handler runs - see
[`../transport-ferry.md`](../transport-ferry.md), trap 7. Full sequence and limits in
[`../transport-ferry.md`](../transport-ferry.md). The same guard covers every
immobile `super` def - Juno, Catalyst, the silo - so a TECH launcher gets its
`CSuperTask` at completion rather than at +50 income
([`../launcher-targets.md`](../launcher-targets.md#who-gives-the-launcher-its-task)).

## The experimental build system (D-066): the hard split

`Tech::ExperimentalBuild` (true) is the one switch. `Tech_Init` sets
`aiBuilderMgr.experimentalBuild` for this instance only, and
`Tech_BuilderAiMakeTask`'s first line hands every ask to
`TechBuild::MakeTask` ([`tech_build.as`](../../data/script/src/roles/tech_build.as)),
which since D-067 evaluates the rule table in
[`tech_rules.md`](tech_rules.md) (`roles/tech_rules.as`) and
which never returns null, so native's chooser (`DefaultMakeTask`, empty for
the instance) is never reached. Natively the start-factory and storage jobs
are silent and `holdStartFactory` stays on; the script orders the lab on
its reserved slot right after the opening. Placement for the instance is
never the spiral: a planned slot, an exact spot, or the free footprint
nearest the task's anchor within `ExperimentalSearchRadius` (512), packed,
reserved and served (`PackNearPoint`, block masks respected). Sequence:
turrets, keep-current, opening, start factory, mex expansion (constructors,
`EcoMexExpandRadius` 2,500 while income is under `EcoMexExpandUntilIncome`
60, allied ground excluded), T2 lab gate, the planner, the strategic rungs,
native's queued defence/sensor/repair orders (`aiBuilderMgr.FindQueuedTask`),
assist within `ExpAssistRadius`, guard the primary factory, wait.

With the switch off nothing of this runs: no layout, no opening, no
planner, `assistNanoEnabled` as the economy settings say, native's start
factory, the stock ladder rungs and the stock placement - the same path as
every other role. Not Played:
[`KI-411`](../known-issues.md#ki-411--the-experimental-build-system-is-not-yet-played).

## Experimental build mode (D-064)

`Tech_Init` sets `aiBuilderMgr.experimentalBuild` (from
`Tech::ExperimentalBuild`, true) and `experimentalDirectRange` (1,600) for
this AI instance only. In the mode every builder task's goal is the
engine's own build range - `0.9 x (buildDistance + buildee model radius)`,
the rule of Recoil's `MoveInBuildRange` - so no waypoint is ever placed
inside it; within the direct range on safe ground the AI cancels its path
and gives the construction command at once, and the engine walks the
shortest path to the range disc; a unit gets one command per engagement and
never a second on arrival or re-evaluation; construction commands carry no
60 s timeout. The turret-box packer breaks ties by the asking builder's
position. Design, the engine rule and the alternatives:
[`../experimental-build.md`](../experimental-build.md). Not Played:
[`KI-410`](../known-issues.md#ki-410--experimental-build-mode-is-not-yet-played).
`Commands::NativeState` snapshots and restores both properties on a role
switch.

## Construction turrets: what they assist (D-065)

A static builder's ask goes to `Tech_TurretAssist` before anything else:
a structure of ours being reclaimed within the turret's reach is reclaimed
(HIGH); else the first structure under construction within reach, in the
order advanced converter, turret, advanced fusion, T1 converter, fusion,
advanced solar, solar, wind, energy storage, metal storage, mex
(`Tech_T1MexName` names the side's T1 extractor), gets a HIGH repair task; else native's default assist (whatever is in range, the
factory). Reach is native (`aiBuilderMgr.FindReclaimTargetFor`,
`FindUnfinishedFor`: build distance plus the target's model radius), so a
turret never gets a target it cannot touch. Level 2 logs `[TECH][Turret]
<id> reclaims <def>` / `assists <def>`.

## Base layout plan

Decisions:
[D-060](../decisions.md#d-060--tech-layout-uses-native-canonical-clusters-and-an-ordered-economy-module)
(the factory pair) and
[D-063](../decisions.md#d-063--the-turret-box-invisible-construction-turrets-first-the-economy-packed-against-them)
(the opening, the turret box, the next-building function). The design is
[`../layout-design.md`](../layout-design.md); the native mechanism is
[`../base-layout.md`](../base-layout.md); the economy model is
[`../tech-eco-meta.md`](../tech-eco-meta.md).

**Opening (`Opening`, commander only).** Before any other structure the
commander claims up to `OpeningMexCap` (3) reachable mexes nearest the start
within `OpeningMexRadius` (700 elmos, the home cluster; played, a third spot
at 947 elmos was too far), taken nearest to itself first
(the opener counts the distinct spots it has ordered and stops at the cap;
`aiEconomyMgr.EnqueueMexWithin` is called uncapped and hands out the open
reachable spot nearest the commander. Played: a native cap re-evaluated
"open" on every call and reached a fourth spot at 1,866 elmos once the
first three were ours). Played: a fourth
spot 944 elmos out toward an ally, and the third mex already empties the
1,000 E bank, so three and then the planner's energy. One order at a
time: native re-asks a busy builder every few seconds (`IBuilderTask::Update`
swaps only when the kind differs), so the opener answers a re-ask with the
mex the commander is on, and `EnqueueMexWithin` hands back an untaken order
in the radius before it closes a new spot. Native's start-factory job is
held (`holdStartFactory`) until no open reachable spot and no pending order
(`aiEconomyMgr.GetMexTaskCountWithin`) is left, or `OpeningMaxSeconds` (240)
pass, or the commander is gone (`Opening::Tick` from `Tech_EconomyUpdate`).
`[TECH][Opening] home mex order N at (x, z), D from start` and `complete
after N mexes, S s: <reason>` log at level 1. The commander is exempt from
native's wait-on-empty-energy rule, so the mexes build at the energy
trickle. An opening order is also exempt from the ally-zone abort in
`CBMexTask::Reevaluate` (`SetIgnoreAlly`), which otherwise drops a mex task,
frame and all, once an allied structure is marked within `AllyRange` of the
spot; a half-built order whose builder was taken off it is handed back
before a new spot is opened. After the opening the commander stays home: a native mex or geo default
farther than `CommanderMexRadiusAfterOpening` (600 elmos) from the start
is skipped (`farMex`; the unused default is discarded natively) and left to
the constructors, whose defaults are not capped. Both the skip and a taken
mex log at level 1 (`[TECH] commander skips a native mex ...` /
`takes a native mex ...`). Played: the ladder's mex-first rule had been
sending the commander to a fourth spot inside 2,000 elmos after the
opening, and the opening itself ends early when one of the three nearest
spots is not open (`complete after 2 mexes`).

**The factory is honoured.** A FACTORY default task is returned the moment
native asks, before every layout and economy rung. The one exception: energy
is stalling (`isEnergyStalling`) and the planner names a solar, wind or
advanced solar this constructor can build now; that goes first and logs
`[TECH] factory waits: energy stalling, <key> first`.

**A construction is kept.** Native re-asks a busy builder every few seconds
while it walks to its site and swaps only when the kind differs; the TECH
ladder answers such a re-ask for a constructor on any construction task
(build type below `REPAIR`) with that same task. Every other answer made a
new packed and pinned task nobody ran (played: 50 advanced solars packed
for 9 served), an answer of another kind pulled the builder off the turret
it was walking to (17 served, 3 built), and the phantom queue was handed
back as defaults and discarded, so native's own mex expansion never ran.

**Only TECH.** Experimental JSON permits layout support, but the native
manager starts disabled. `Tech_Init` is the only role hook that calls
`Layout::Enable(true)`; every non-TECH role retains normal placement.

**Factory clusters (D-060).** `Tech_LayoutPlan` tries the lane-facing
direction and both perpendicular facings with deterministic cell offsets
(`LayoutFactory*`); native commits the T1/T2 pair atomically with each lab's
rear nano block and a 20-cell exit rectangle.

**The turret box (D-063).** Directly behind the pair's rear nanos,
`Layout::PlanBox` searches a rectangle of `LayoutBoxAcrossCells x
LayoutBoxDepthCells` (40 x 44), shrinking by `LayoutBoxShrinkCells` down to
`LayoutBoxMinAcrossCells x LayoutBoxMinDepthCells`, over `LayoutBoxRear*` and
`LayoutBoxSide*` offsets, scoring each candidate by `FlatFraction`
(`LayoutBoxMaxSlope`) times `BuildableFraction` of the turret def; the
largest size whose best candidate clears `LayoutBoxMinScore` (0.75) is
reserved as a zone. Turret rows are laid with `LayBand`, one slot at a time
(a refused slot is a hole), at a pitch of `LayoutBoxShelfCells` (12) plus a
turret depth, up to `LayoutBoxNanoRows` (3; Supreme 4). The slots are held,
not armed: only the planner's pinned tasks take them. The box is mirrored
in native layout ints (`tech.box.*`) and adopted after a load.
`[Layout] turret box AxD cells at (x, z), ... ground P%: zone Z, R rows, S
of T turret slots` logs at level 1; without a box the fallback (economy
within `LayoutFallbackShakeCells` of the factory nanos) is logged once.

**Everything against the turrets, each def in one group.** `Layout::Place`
asks native `PackNearGroup` for the free box cells nearest to any turret
slot (built or not), within the turret's reach and at least
`LayoutConverterNanoGap` / `LayoutFusionNanoGap` from every slot (both 0 by
default). Once a structure or planned slot of the same def stands in the
box, the cell nearest that group wins first, so the winds form one
contiguous block and the converters another; ties go to the asking builder.
The task is pinned to that footprint and never spirals. `[Layout]
no room in the turret box for <def>` means the planner's choice is skipped,
not placed elsewhere. `Layout::CanPlace` is the dry run the planner uses
before offering an option.

**Turrets on demand.** `Layout::NanoTask` builds a factory's own rear slot
first (D-060), then the box row nearest the factories (`NextSlotAny`). The
planner asks for one when the assist build power within
`EcoBuildPowerRadius` of `Layout::BaseCentre` is under `EcoBuildPowerPerMetal`
(8) times the metal income (times `EcoBuildPowerFloatFactor` when metal
floats), with `EcoTurretMinMetalIncome` and `EcoTurretBankFraction` as
guards, and only while `Layout::CanPlaceTurret`; the power measured is the
turrets' alone (`aiBuilderMgr.GetStaticBuildPowerNear`), since the commander
and constructors passing through hid every shortage when they counted. One
turret at a time
(`EcoMaxConcurrentNanos` 1, orders plus turrets under construction): a
mobile constructor that asks while one is going up assists it
(`aiBuilderMgr.FindUnfinishedNear` within `EcoTurretAssistRadius`) instead
of starting another, so build power is focused. Native's own assist nanos
are off for TECH from `Tech_Init` (`assistNanoEnabled = false`), not only
after the economy switch. Build power is measured in workertime units
(commander 300, turret 200): played, the per-frame figure the native
helper used to return (10 for the commander) against a per-second target
made the turret rule fire for ever - eleven turrets per TECH at +20 metal.
The old `ShouldBuildT1Nano` rung runs only with `EcoPlannerEnabled` false,
and then through `EcoPlanner::Enqueue("nano")` too, as do the old converter
and fusion rungs and the float spend (`"advconv"`, `"afus"`, `"fusion"`):
the ladder never places anything itself. `Tech_IsBuilding`
keeps the assist redirects from pulling a constructor off a structure it has
already started or is walking to build (D-050).

**Persistence and reset.** Native named groups, zones, ints and claims are
saved before builder tasks; script adopts by name (`Layout::Adopt`). Leaving
TECH aborts layout-owned tasks before releasing the registry.

**Seeing it.** `/barblayout` draws the native registry: held turret slots
yellow, claimed orange, served cyan, built blue; the box zone as a
rectangle. The manual `/barbroute` verbs of D-053 are gone.

**Not Played.** See
[`KI-409`](../known-issues.md#ki-409--the-turret-box-and-the-mex-first-opening-are-not-yet-played).

### The eco planner (D-058, D-063)

The solar, advanced solar, wind, converter, fusion, advanced fusion, storage
and construction-turret decisions of the T1 and T2 constructor ladders and
the commander's are one deterministic function of the game's state,
`EcoPlanner::Next` / `Execute`
([`manager/eco_planner.as`](../../data/script/src/manager/eco_planner.as)),
called before the old rungs; those rungs run only when `EcoPlannerEnabled`
is false. Inputs: the map's wind range, energy and metal income, banks and
storage, what stands, the assist build power around the box, the planned
turret slots left, the constructor tiers on the field, queued storage,
converters and turrets, and what the asking constructor can build and the
box can hold. Output: the next structure, or nothing (the ladder continues
with factories, defence and military). The order: energy draining, energy
floating (converter), build power short or metal floating (turret), energy
below target, storage, metal floating (best-payback energy). The formula,
the numbers and the settings (`Tech::Eco*`) are
in [`../eco-planner.md`](../eco-planner.md).

### Energy settings, this role only

`economy.json` is shared by every role. TECH changes its own instance of
`CEconomyManager` (D-047) - but not at init: **it starts on the shared
defaults and switches** (`Tech_ApplyEconomySettings`, from
`Tech_EconomyUpdate`) once the 10-second minimum metal income reaches
`EconomySwitchMetalIncome` (20) and energy income reaches
`EconomySwitchEnergyIncome` (1000), D-054. `EconomySwitchEnabled` false
applies them in `Tech_Init` as before. Both moments log at level 1
(`[TECH][Economy] on shared defaults ...`, `[TECH][Economy] own settings
at +M metal, +E energy: ...`). The settings that wait:

| Setting (`Global::RoleSettings::Tech`) | Default | Effect |
| --- | --- | --- |
| `ReclaimEnergyEff` | 2.0 | `aiEconomyMgr.reclEnergyEff`: when an energy def finishes, every standing energy def near the base whose score x this is below the new one's is reclaimed (income permitting). Native default 20 never reclaims a solar (score 0.026) against an advanced solar (0.225); 2 does, and reclaims advanced solars once a fusion stands |
| `ReclaimOldConvertersAlways` | true | an advanced converter marks obsolete T1 converters for reclaim even while the energy bank is full, recycling their footprint and metal into the higher tier |
| `EnergyLimitSolar` / `EnergyLimitAdvSolar` | -1 (keep json) | `aiEconomyMgr.SetEnergyCondition(def, limit, -1, -1)` caps this role's count of the def |

`aiEconomyMgr.SetEnergyCondition(def, limit, metalIncome, energyIncome)` and
`GetEnergyLimit(def)` are the general lever; any role may use them.

### Construction turrets early (D-051)

Two sources of turrets: the ladder's nano rung (`ShouldBuildT1Nano`, one per
`NanoMetalPerUnit` of metal income, plus `NanoReserveSurplus` on a full bank)
and native `CEconomyManager::CheckAssistRequired`, which hands any factory
that "needs upgrade" a HIGH-priority nano whenever income covers it - a
source the script never saw. Played: TECH metal-stalled its first T2
constructor under turrets from both. Now:

| Setting (`Global::RoleSettings::Tech`) | Default | Effect |
| --- | --- | --- |
| `NanoMetalPerUnit` | 15 (was 10) | at +30 metal two turrets, not three |
| `NanoHoldForFirstT2Constructors` | true | no nano from the ladder while a T2 bot lab stands and fewer than `MinimumT2ConstructorBots` T2 constructors exist |
| `NanoMinMetalCurrent` | 150 | no nano from the ladder while the bank is below this |
| `AssistNanoEnabled` | false | `aiEconomyMgr.assistNanoEnabled`: native assist nanos off for this instance; the script owns the count |
| `AssistNanoIncomeMod` | 1.0 | `aiEconomyMgr.assistNanoIncomeMod`: when enabled, scales the income a native assist nano must be covered by |

## Lifecycle and invariants (D-076)

`tech.as` includes `manager/lifecycle.as` and `manager/invariants.as`.
`Tech_FactoryAiMakeTask` returns nothing for a factory that `Lifecycle` marks
retiring (played: the T1 lab produced a Lazarus while it was being
reclaimed). `Tech_FactoryAiUnitRemoved` calls `Lifecycle::Forget`;
`Tech_BuilderAiUnitAdded` and `Tech_MilitaryAiUnitAdded` call
`Invariants::OnUnitAdded` (INV-001); the role's tick calls
`Invariants::Tick` once a second (INV-002, INV-004). A broken promise is
logged as `[INVARIANT] INV-nnn` and fails every playtest. The practice is
[`../practice-invariants.md`](../practice-invariants.md); the register
[`../invariants.md`](../invariants.md); who acts on what
[`../actor-matrix.md`](../actor-matrix.md).

## Related

- `doc/angelscript-references.md` - script loading model, callback contracts,
  registered API, ownership rules.
- `skills/convention-angelscript/SKILL.md` - language and safety conventions.
- `skills/troubleshoot-bar-logs/SKILL.md` - reading the `:::AI LOG` stream to
  confirm any of the unconfirmed items above.

<!-- source: data/script/src/roles/tech.as; blob: dfbad546847fa42d7437222245caacb282d8f7bb; lines: 2582 -->
