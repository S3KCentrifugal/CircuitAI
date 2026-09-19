# TACTICAL Role

Reference for the `TACTICAL` AngelScript role: the mobile-builder posture that
forces a hover opening. How it is registered, what it installs at init, how its
objective-chain executor works, and where it is currently wrong.

Source: `data/script/src/roles/tactical.as` (709 lines), namespace
`RoleTactical`. Line references are as of branch `smrt`, 2026-09-17. Prefer
function names over line numbers when navigating.

Note: this file is tab-indented where the other five role files use spaces.

## Contents

- [Intent](#intent)
- [Registration](#registration)
- [Settings](#settings)
- [Init: what TACTICAL installs](#init-what-tactical-installs)
- [Factory selection: the one role that overrides it](#factory-selection-the-one-role-that-overrides-it)
- [The objective chain executor](#the-objective-chain-executor)
- [Decision flows](#decision-flows)
- [Known defects](#known-defects)
- [Naval unlock](#naval-unlock)
- [Related](#related)

## Intent

The enum comments TACTICAL as "Tactical role (formerly HOVER_SEA), favoring
mobile builders (often hover-based)". In practice it is the hover-opening role:
it zeroes every bot lab, vehicle plant, aircraft plant and shipyard at start, and
its `SelectFactoryHandler` returns the side's land hover plant directly rather
than deferring to the generic selector.

It is the only role that enables `Builder::SetTacticalEnabled(true)`, and one of
two (with SEA) driving construction through `Objectives::` - but TACTICAL is the
only one with a full multi-step chain executor.

Because it opens on a hover plant and caps every other factory line at zero, the
native T1-retirement gate documented in [hover.md](hover.md) hits this role
hardest. Read that document alongside this one.

## Registration

`RoleTactical::Register()` fills **14 of 22** slots - the common thirteen plus
`FactoryAiMakeTaskHandler`.

| Slot | Handler |
| --- | --- |
| `MainUpdateHandler` | `Tactical_MainUpdate` |
| `InitHandler` | `Tactical_Init` |
| `EconomyUpdateHandler` | `Tactical_EconomyUpdate` |
| `AiIsSwitchTimeHandler` | `Tactical_AiIsSwitchTime` |
| `AiIsSwitchAllowedHandler` | `Tactical_AiIsSwitchAllowed` |
| `MakeSwitchIntervalHandler` | `Tactical_MakeSwitchInterval` |
| `BuilderAiMakeTaskHandler` | `Tactical_BuilderAiMakeTask` |
| `BuilderAiTaskAddedHandler` | `Tactical_BuilderAiTaskAdded` |
| `BuilderAiTaskRemovedHandler` | `Tactical_BuilderAiTaskRemoved` |
| `BuilderAiUnitAdded` | `Tactical_BuilderAiUnitAdded` |
| `BuilderAiUnitRemoved` | `Tactical_BuilderAiUnitRemoved` |
| `FactoryAiMakeTaskHandler` | `Tactical_FactoryAiMakeTask` |
| `SelectFactoryHandler` | `Tactical_SelectFactoryHandler` |
| `RoleMatchHandler` | `Tactical_RoleMatch` |

Not filled: both factory task hooks, both factory unit hooks, all three military
hooks, `AiMakeDefenceHandler`.

## Settings

`Global::RoleSettings::Tactical` (`global.as:718`), 21 references - the smallest
block of the six.

**Posture**

| Setting | Value |
| --- | --- |
| `AllyRange` | 3000.0 |
| `MilitaryScoutCap` | 4 |
| `MilitaryAttackThreshold` | 20.0 |
| `MilitaryRaidMinPower` / `MilitaryRaidAvgPower` | 30.0 / 60.0 |

`AllyRange` 3000.0 is the widest of all six roles - more than triple FRONT's 900.

**Hover**

| Setting | Value |
| --- | --- |
| `MinHoverConstructorCount` | 10 |
| `MetalIncomePerExtraHoverPlant` | 50.0 |
| `MaxHoverPlants` | 3 |
| `RequiredMetalIncomeForT2VehiclePlant` | 25.0 |

`MinHoverConstructorCount` of 10 is a very high constructor floor and is the
clearest expression of the "mobile builders" intent.

**Energy** - `SolarEnergyIncomeMinimum` 160.0,
`AdvancedSolarEnergyIncomeMinimum` 1200.0, `AdvancedSolarEnergyIncomeMaximum`
3000.0 (the widest advanced-solar band of any role).

**Nano** - `NanoEnergyPerUnit` 200.0, `NanoMetalPerUnit` 10.0, `NanoMaxCount`
**300** (every other role uses 200), `NanoBuildWhenOverMetal` 1000.0.

**Start caps** - all zero: `StartCapT1BotLabs`, `StartCapT2BotLabs`,
`StartCapT1VehiclePlants`, `StartCapT1AircraftPlants`, `StartCapT2AircraftPlants`,
`StartCapT1Shipyards`, `StartCapT2Shipyards`.

`UseDynamicFactoryProduction` is **false**.

## Init: what TACTICAL installs

`Tactical_Init` does more than any role except TECH:

1. `aiTerrainMgr.SetAllyZoneRange(3000.0)`.
2. Installs the four military quota values.
3. `Tactical_ApplyStartLimits()` - all seven start caps above, applied through
   `UnitHelpers::BatchApplyUnitCaps` over `GetAllT1BotLabs()`-style accessors.
   This is the clean style; only TECH and TACTICAL use it.
4. Fire state: iterates `UnitHelpers::GetAllT1HoverCombatUnits()` and applies
   `d.SetFireState(3)` - scoped to hover units, mirroring FRONT's land pass.
5. `ObjectiveHelpers::LogAllObjectivesFromStart(AiRole::TACTICAL, "TACTICAL")`.
6. `ObjectiveHelpers::LogMatchingObjectivesForRole(...)` with
   `Objectives::ConstructorClass::HOVER` and a limit of 5 - logging only, no
   assignment.
7. `Tactical_SelectObjectiveForGroup(Objectives::BuilderGroup::TACTICAL)` -
   **the only objective selection that ever runs**, see below.
8. `Builder::SetTacticalEnabled(true)`.
9. `FactoryProduction::Initialize()` only if the flag is set.

## Factory selection: the one role that overrides it

Where FRONT, AIR, SEA and SUPPORT share a verbatim-identical handler,
`Tactical_SelectFactoryHandler` has real logic:

```angelscript
if (isStart) {
    string hoverFac = UnitHelpers::GetT1HoverPlantForSide(side); // armhp/corhp/leghp
    if (hoverFac.length() > 0) return hoverFac;
    // WARNING: hover plant unresolved; defer to generic selector
    ...
}
return "";
```

The comment states the intent plainly: *"Explicitly start with a land hover plant
for TACTICAL role to avoid bot labs."* Only when the side's hover plant cannot be
resolved does it fall back to `FactoryHelpers::SelectStartFactoryForRole`, and it
logs a WARNING when it does.

This bypasses the per-map factory weights that every other role respects. A map
config weighting TACTICAL toward some other factory is ignored at start.

## The objective chain executor

TACTICAL's distinguishing mechanism, and the most elaborate objective handling in
the role layer.

| Function | Purpose |
| --- | --- |
| `Tactical_SelectObjectiveForGroup(group)` | choose the current objective for a builder group |
| `Tactical_SelectTacticalObjective()` | thin wrapper for `BuilderGroup::TACTICAL` |
| `Tactical_TryHandleObjective(builder, group)` | entry point from the builder handler |
| `_Tactical_HasPendingChain(objective, side)` | does this objective still have steps left |
| `_Tactical_TryGetNextType(objective, out t)` | next `Objectives::BuildingType` in the chain |
| `_Tactical_TryExecuteChain(objective, builder, label)` | drive one step of the chain |
| `_Tactical_TryHandleSeaplaneFactory(...)` | special case for seaplane factories |
| `_Tactical_TryHandleStandardBuild(...)` | the general build step |
| `_Tactical_GetObjectiveBuildPos(objective, fallback)` | resolve a position |
| `_Tactical_GetDefNameFor(side, t)` | map a building type to a side-specific def name |
| `Tactical_FallbackEcoTask(builder)` | ~70-line economy fallback when no objective applies |

The underscore-prefixed functions are the private half of the module - a
convention no other role file uses.

Objectives are grouped by `Objectives::BuilderGroup`, so TACTICAL can in
principle run separate chains for separate builder cohorts. Today only
`BuilderGroup::TACTICAL` is ever selected.

## Decision flows

### Builder

`Tactical_BuilderAiMakeTask(builder)` is the largest builder handler in the role
layer (~127 lines). It routes through `Tactical_TryHandleObjective` first, then
`Tactical_FallbackEcoTask` when no objective step applies.

### Factory

`Tactical_FactoryAiMakeTask(u)` is comparatively small (~58 lines) - the role's
weight sits in the builder path, not production.

### Main and economy updates

Both are empty:

```angelscript
void Tactical_MainUpdate() {
    // MainUpdate: no periodic objective scanning (performance). Selection occurs at Init.
}

void Tactical_EconomyUpdate() {
    // No tactical-specific economy adjustments yet
}
```

The `MainUpdate` comment is the important one: **objective selection happens once,
at init, and never again**. If the chosen objective becomes unreachable or
irrelevant, nothing re-selects. `Tactical_FallbackEcoTask` is the only recovery
path, and it does not choose a new objective.

## Known defects

1. **The whole settings block is commented as SEA.** `Global::RoleSettings::Tactical`
   carries `"/**** SEA BASE SETTINGS ****/"`, `"All settings applied to sea role
   at game start"`, `"/**** SEA MILITARY QUOTAS ****/"` and `"Scout unit cap for
   SEA role"`. Every comment in the block was copy-pasted from the Sea block
   above it and none was updated.

2. **The settings block is indented at 4 spaces** where Tech, Air, Front, Support
   and Sea all use 8, making it read as if it sits outside `RoleSettings`. It
   does not - `Global::RoleSettings::Tactical::` resolves and is referenced 21
   times - but the indentation is actively misleading.

3. **Objective selection runs once and never re-runs.** Documented above. The
   performance rationale is stated, but there is no re-selection trigger of any
   kind - not on objective completion, not on failure, not on a timer.

4. **`Tactical_MainUpdate` and `Tactical_EconomyUpdate` are both empty but
   registered.** Two delegate calls per cycle for nothing.

5. **Start factory selection ignores map configuration.** The forced hover plant
   overrides per-map factory weights. On a map whose config points TACTICAL
   somewhere else, that config is silently ineffective at start.

6. **`NanoMaxCount = 300` diverges from every other role's 200** with no comment
   explaining why.

7. **Tab indentation** in a tree where the other five role files use spaces.
   Cosmetic, but it makes cross-role diffs and greps noisier.

8. **Only one builder group is ever used.** The group machinery
   (`Tactical_SelectObjectiveForGroup`, the `group` parameter threaded through
   `Tactical_TryHandleObjective`) supports several; `BuilderGroup::TACTICAL` is
   the only one selected. Unused generality.

## Naval unlock

`Tactical_ApplyStartLimits` caps both `GetAllT1Shipyards` and
`GetAllT2Shipyards` at **0**, so TACTICAL cannot build a shipyard, a floating
nano, or anything else naval. That is right for a hover role on its own and
wrong next to a SEA ally.

`Team::SeaAssist::UnlockNaval` raises those caps to
`Global::SeaAssist::UnlockedT1Shipyards` / `UnlockedT2Shipyards` (2 / 1) the
moment TACTICAL **owns a sea constructor** - T1 or T2, from any source. The
usual source is the one a SEA ally donates at +50 metal income, but the unlock
is keyed on ownership rather than on the donation message, so a construction
ship arriving any other way works too.

`Tactical_ApplyStartLimits` runs once, from `Tactical_Init`, so nothing
re-applies the zero caps afterwards.

Shipyard caps are TACTICAL's **only** naval restriction - it puts no limit on
naval units themselves - so lifting these two is the whole *permission*.

It was not the whole unlock. In the first game the ship arrived, the caps
lifted, and the ship never moved: nothing in `Tactical_BuilderAiMakeTask` or
the native default ever *asks* for a naval structure, and every task TACTICAL
had queued was on land the ship could not reach. `SeaAssist::SeedShipyard`
now enqueues a T1 shipyard at the ship's own position (`TaskB::Factory`,
priority NOW, the ship itself as the representer so the site test is answered
by the unit that will do the building). Permission plus one concrete demand;
the shipyard's own build chain takes it from there.

## Related

- [README.md](README.md) - the role contract and cross-role findings.
- [hover.md](hover.md) - **read this**. TACTICAL opens on a hover plant and caps
  every other factory at zero, so the native T1-retirement gate applies to it
  most severely.
- [sea.md](sea.md) - the other objective-driven role, and the source of this
  role's copy-pasted settings comments.

<!-- source: data/script/src/roles/tactical.as; blob: 1f5e08403a7e340dd06e3d052d27f48b193f22c8; lines: 709 -->
