# Hover Factories

Reference for hover production: what owns it, how a hover plant decides what to
build, the native contract behind it, and the confirmed cause of hover
production stalling once a T2 factory exists.

Line references are as of branch `smrt`, 2026-09-15.

## Contents

- [There is no hover role](#there-is-no-hover-role)
- [What hover actually is](#what-hover-actually-is)
- [Who selects a hover factory](#who-selects-a-hover-factory)
- [Production paths](#production-paths)
- [Native contract](#native-contract)
- [The bug: production stops once any T2 factory exists](#the-bug-production-stops-once-any-t2-factory-exists)
- [The hover line tech-ups into its own shutdown](#the-hover-line-tech-ups-into-its-own-shutdown)
- [Why it looks intermittent](#why-it-looks-intermittent)
- [Fix options](#fix-options)
- [Other findings](#other-findings)

## There is no hover role

The role set is fixed at six: `air`, `front`, `sea`, `support`, `tactical`,
`tech` (`data/script/src/roles/`). There is no `hover.as` and no
`AiRole::HOVER`.

Hover is a **factory family plus a production config**, reachable by several
roles depending on map terrain. That distinction matters for this bug: the
failure is not in role logic at all, it is in the native factory manager.

## What hover actually is

| Piece | Location |
| --- | --- |
| Hover plant defs | `armhp`/`armfhp`, `corhp`/`corfhp`, `leghp`/`legfhp` (land and floating) |
| Production config | `data/script/src/manager/factory_production/factory_configs_hover.as` |
| Strategic objective type | `StrategicObjective::HOVER` (`types/strategic_objectives.as`) |
| Terrain fallback mapping | `maps/factory_mapping.as` |
| Per-map factory weights | `maps/*.as` (e.g. `eight_horses.as`) |

`factory_configs_hover.as` registers a `FactoryConfig` per hover plant with five
roles and four economic tiers. For `armhp`:

```angelscript
cfg.AddRole("builder", {"armch"});
cfg.AddRole("scout",   {"armsh"});
cfg.AddRole("raider",  {"armthovr", "armanac"});
cfg.AddRole("assault", {"armmh"});
cfg.AddRole("support", {"armah"});
```

with tier probability vectors for `<20`, `20-40`, `40-80` and `80+` metal
income.

## Who selects a hover factory

`FactoryHelpers::SelectStartFactoryForRole(role, side)` reads per-map, per-role
factory weights from the map config, falling back to
`maps/factory_mapping.as`. That fallback hands hover plants to **tech** and
**front** on land-locked starts:

```angelscript
if (role == "tech" || role == "front/tech") return landLocked ? "armhp" : "armlab";
if (role == "front")                        return landLocked ? "armhp" : "armvp";
```

Map configs can also weight hover plants directly for sea-ish maps. So hover
ownership is terrain-driven, not role-owned.

Note that TECH separately zeroes hover plants in `Tech_ApplyStartLimits`:

```angelscript
UnitHelpers::BatchApplyUnitCaps(UnitHelpers::GetAllT1HoverPlants(), 0);
UnitHelpers::BatchApplyUnitCaps(UnitHelpers::GetAllFloatingHoverPlants(), 0);
```

so in practice hover production belongs to FRONT (and whichever role a map
config points at it).

## Production paths

There are two, and **only the second one runs**.

### Path A - FactoryProduction (currently dead code)

`FactoryProduction::MakeTask(factory)` is the dynamic selector: economic tier,
threat weighting, availability filtering, then `EnhancedPickBestUnit` scoring on
damage/survivability/mobility/cost, finally enqueuing a batch of
`BATCH_REUSE_COUNT` recruit tasks.

Every role calls it behind a flag:

```angelscript
if (Global::RoleSettings::Front::UseDynamicFactoryProduction) {
    IUnitTask@ dynTask = FactoryProduction::MakeTask(u);
    ...
}
```

**All four `UseDynamicFactoryProduction` declarations in `global.as` are
`false`.** So `FactoryProduction` never executes, and `factory_configs_hover.as`
- the entire per-tier, per-role hover unit table - has no effect on the game
today. Its `priorityQueue` also has no producers anywhere in the tree.

### Path B - native default (live)

With the flag off, every role's factory handler falls through to
`aiFactoryMgr.DefaultMakeTask(u)`, which reaches
`CFactoryManager::CreateFactoryTask`. That is where hover production is actually
decided, and where it breaks.

## Native contract

```text
factory goes idle
  -> CFactoryManager idleHandler -> unit->GetTask()->OnUnitIdle(unit)
  -> AssignTask -> MakeTask
  -> CFactoryScript::MakeTask -> Factory::AiMakeTask (script)
       -> RoleConfig.FactoryAiMakeTaskHandler (e.g. Front_FactoryAiMakeTask)
            -> constructor guarantees (guarded by factory type)
            -> FactoryProduction::MakeTask   [disabled]
            -> aiFactoryMgr.DefaultMakeTask(u)
                 -> CFactoryManager::CreateFactoryTask(unit)
                      -> UpdateBuildPower(unit, isActive)
                      -> UpdateFirePower(unit, isActive)
                           -> RequiredFireDef(builder, isActive)
```

Registered APIs used along the hover path: `aiFactoryMgr.Enqueue`,
`aiFactoryMgr.DefaultMakeTask`, `aiEconomyMgr.metal.income`,
`cdef.IsAvailable(frame)`, `cdef.costM`, `cdef.GetAirThreat/GetSurfThreat/
GetWaterThreat`, `cdef.health`, `cdef.speed`.

## The bug: production stops once any T2 factory exists

Two native lines produce the behaviour.

**1. T1 factories are deactivated once a non-T1 factory exists.**
`CFactoryManager::CreateFactoryTask`:

```cpp
const bool isActive = (noT1FacCount <= 0) || !IsT1Factory(unit->GetCircuitDef());
```

`noT1FacCount` is incremented in `EnableFactory` for every factory where
`!IsT1Factory(...)`, and decremented in `DisableFactory`. A hover plant is a T1
factory, so the moment **any** non-T1 factory finishes - T2 vehicle lab, T2 bot
lab, T2 air plant, gantry - `isActive` becomes `false` for every hover plant.

**2. An inactive T1 factory may only build `rare` units.**
`CFactoryManager::RequiredFireDef`, in the candidate validity predicate:

```cpp
&& (isActive || bd->IsAttrRare())
```

The `RARE` attribute is documented in `CircuitDef.h` as exactly this escape
hatch:

```cpp
* RARE:       build unit from T1 factory even when T2+ factory is available
```

When no candidate passes, `RequiredFireDef` returns `{-1}`, `UpdateFirePower`
returns `nullptr`, and `CreateFactoryTask` ends at:

```cpp
return Enqueue(TaskS::Wait(false, isActive ? (FRAMES_PER_SEC * 3) : (FRAMES_PER_SEC * 10)));
```

The hover plant sits in a 10-second wait loop building nothing - and is polled
3.3x less often than an active factory.

**3. `rare` coverage for hover units is incomplete.** This is the part that is
ours to fix. Against `data/config/experimental_balanced/behaviour.json`:

| Hover role | Armada unit | `rare`? | Buildable after T2 |
| --- | --- | --- | --- |
| builder | `armch` | no | **yes** - constructors bypass the filter, see below |
| scout | `armsh` | no | no |
| raider | `armthovr` | no | no |
| raider | `armanac` | **yes** | yes |
| assault | `armmh` | **yes** | yes |
| support | `armah` | **yes** | yes |

Constructors are the exception because they are produced by a different
function. `UpdateBuildPower` contains **no `IsAttrRare` check** at all, so the
`builder` role def is unaffected by the gate. Worse, the random throttle in that
function is `(isActive && (r >= RAND_MAX / 2))` - when `isActive` is false the
clause short-circuits, so the 50% skip is **disabled** and an inactive factory
attempts constructor production on *every* cycle.

So the accurate post-T2 behaviour of a hover plant is not "stops building"; it
is **"stops building combat hovers and biases hard toward constructors"**.

Cortex mirrors this (`corah`, `cormh`, `corhal` are rare). **Legion has no rare
hover units at all** - `behaviour_leg.json` flags only `legbar`, `legfig`,
`leggat`, `legnavyaaship`, `legnavydestro`, `legnavyrezsub`, `legrezbot`, while
the Legion hovers `legah`, `legcar`, `legch`, `legmh`, `legner`, `legsh` are all
present but unflagged.

## The hover line tech-ups into its own shutdown

Hover constructors are not a dead end: they build the T2 vehicle plant. From
BAR `buildoptions`:

| Constructor | T2 factories it can build |
| --- | --- |
| `armch` | `armavp` (Advanced Vehicle Plant), `armasy` (Advanced Shipyard) |
| `corch` | `coravp`, `corasy` |
| `legch` | `legavp`, `legadvshipyard` |

That closes a self-defeating loop:

```text
hover plant builds armch  ->  armch builds armavp
      ^                              |
      |                              v
 more constructors  <-  noT1FacCount++ -> armhp isActive = false
                          -> combat hovers filtered out by the rare gate
                          -> constructor bias amplified (random skip disabled)
```

The hover factory's own tech path is what deactivates it, and the resulting
constructor bias makes further T2 factories *more* likely. This is why the
correlation with the T2 vehicle lab is so visible: on a hover opening the
vehicle plant is usually the first non-T1 factory built, and a hover
constructor is what builds it.

## Why it looks intermittent

- **Armada/Cortex**: 3 of 6 hover unit types survive the filter, so production
  becomes sparse and erratic rather than stopping outright. Whether anything is
  produced depends on which role `RequiredFireDef` picks that cycle - pick
  `scout` or `builder` and nothing is queued.
- **Legion**: production stops completely.
- **"Some games fine all game"**: games where no non-T1 factory was ever
  completed keep `noT1FacCount == 0`, so `isActive` stays true.
- **Recovery**: `DisableFactory` decrements `noT1FacCount`, so losing the T2
  factory restores full hover production. Rebuilding it stops it again.
- The trigger is **any** non-T1 factory, not specifically the T2 vehicle lab -
  that is just what was observed being built at the time.

## Fix options

Ordered by scope. None applied.

1. **Flag the missing hover units `rare` in the behaviour configs.** Smallest,
   most idiomatic fix, and it uses the mechanism CircuitAI provides for exactly
   this case. Add `"rare"` to the `attribute` array for `armsh`, `armthovr`,
   `corsh`, `corthovr`, `corsnap` and the whole Legion hover set in
   `behaviour_leg.json`. Consider leaving the `builder` hovers (`armch`/`corch`/
   `legch`) unflagged, since constructor production is handled separately by
   `UpdateBuildPower`.
   Leave the builder hovers (`armch`/`corch`/`legch`) unflagged - they do not
   need it, since `UpdateBuildPower` never consults `rare`.
   - Caveat: `rare` is global to the unit def, so a flagged unit also becomes
     buildable from other T1 factories after T2. For hovers that is usually the
     intent; verify none of these units are shared with a T1 bot/vehicle lab.
2. **Enable `UseDynamicFactoryProduction` for the hover-owning role.**
   `FactoryProduction::MakeTask` enqueues recruit tasks directly through
   `aiFactoryMgr.Enqueue`, bypassing `CreateFactoryTask` and therefore the
   `isActive` gate entirely. This would also activate the tuned per-tier hover
   tables that are currently inert. Much larger behavioural change - it switches
   unit selection for *every* factory of that role - so it wants its own
   testing pass.
3. **Decide whether T1 hover retirement is even wanted.** The native rule
   assumes a T1 factory is superseded by a T2 factory of the same line - true for
   a bot lab feeding an advanced bot lab. Hover has no T2 hover plant; its
   "upgrade" is the T2 *vehicle* plant, a different unit line entirely. So
   retiring the hover plant does not migrate hover production anywhere, it just
   ends it. If hover is meant to remain an army source on water-heavy maps,
   option 1 is a workaround and option 2 is the real answer.

## Other findings

- **The whole `factory_production/` subsystem is dead.** Five config files
  (`sea`, `hover`, `bot`, `vehicle`, `air`), the threat weighting, the tier
  tables and `EnhancedPickBestUnit` are all unreachable while every
  `UseDynamicFactoryProduction` is `false`. That is a large amount of tuned logic
  with no effect - either enable it or retire it.
- **`priorityQueue` in `FactoryProduction` has no producers.** `QueueUnitByName`
  and `QueueUnitDef` are never called from outside the namespace.
- **`FactoryProduction::MakeTask` enqueues `BATCH_REUSE_COUNT` tasks in a loop**
  at `Priority::NORMAL`. If that path is ever enabled, note that the script
  `Enqueue` does not consult `CFactoryManager::CanEnqueueTask()`
  (`factoryTasks.size() < factories.size() * 2`), so batches can overrun the
  native queue ceiling.
- **Diagnosis needs `LOG_LEVEL` raised.** All `[FactoryProduction]` and most
  `[FRONT][Factory]` lines log at level 2-4, while `data/script/src/define.as`
  sets `const uint LOG_LEVEL = 1`. No hover or FactoryProduction line appears in
  any current log for that reason. Raise it to at least 3 before trying to
  confirm behaviour in game.

## Related

- `doc/roles/tech.md` - TECH role reference, including the shared unit-cap system.
- `doc/angelscript-references.md` - callback contracts and registered API.
- `skills/troubleshoot-bar-logs/SKILL.md` - filtering the `:::AI LOG` stream.
