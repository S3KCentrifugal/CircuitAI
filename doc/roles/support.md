# SUPPORT Role

Reference for the `SUPPORT` AngelScript role: the hybrid economic substitute.
How it is registered, what it installs at init, why its factories are not
role-controlled, and where it is currently wrong.

Source: `data/script/src/roles/support.as` (497 lines), namespace `RoleSupport`.
Line references are as of branch `smrt`, 2026-09-17. Prefer function names over
line numbers when navigating.

## Contents

- [Intent](#intent)
- [Registration](#registration)
- [Settings](#settings)
- [Init: what SUPPORT installs](#init-what-support-installs)
- [Decision flows](#decision-flows)
- [The missing factory handler](#the-missing-factory-handler)
- [Known defects](#known-defects)
- [Related](#related)

## Intent

SUPPORT is the smallest role at 497 lines - roughly a quarter of TECH. The enum
comments it as "hybrid support / economic substitute (renamed from
ECO/FrontTech)", and the code matches: it disables its own T1 combat production
entirely, keeps a high resurrect-bot cap, and spends its effort on constructor
management and guard assignment rather than on shaping what its factories build.

It is best understood as an economy role that expects allies to fight, sitting
between TECH (pure economy, full factory control) and FRONT (pure army).

## Registration

`RoleSupport::Register()` fills **15 of 22** slots.

| Slot | Handler |
| --- | --- |
| `MainUpdateHandler` | `Support_MainUpdate` |
| `InitHandler` | `Support_Init` |
| `EconomyUpdateHandler` | `Support_EconomyUpdate` |
| `AiIsSwitchTimeHandler` | `Support_AiIsSwitchTime` |
| `AiIsSwitchAllowedHandler` | `Support_AiIsSwitchAllowed` |
| `MakeSwitchIntervalHandler` | `Support_MakeSwitchInterval` |
| `BuilderAiMakeTaskHandler` | `Support_BuilderAiMakeTask` |
| `BuilderAiTaskAddedHandler` | `Support_BuilderAiTaskAdded` |
| `BuilderAiTaskRemovedHandler` | `Support_BuilderAiTaskRemoved` |
| `BuilderAiUnitAdded` | `Support_BuilderAiUnitAdded` |
| `BuilderAiUnitRemoved` | `Support_BuilderAiUnitRemoved` |
| `FactoryAiUnitAdded` | `Support_FactoryAiUnitAdded` |
| `FactoryAiUnitRemoved` | `Support_FactoryAiUnitRemoved` |
| `SelectFactoryHandler` | `Support_SelectFactoryHandler` |
| `RoleMatchHandler` | `Support_RoleMatch` |

**`FactoryAiMakeTaskHandler` is not filled.** SUPPORT is the only role without
one - see [The missing factory handler](#the-missing-factory-handler).

Also not filled: both factory task hooks, all three military hooks,
`AiMakeDefenceHandler`.

## Settings

`Global::RoleSettings::Support` (`global.as:545`), 24 references - the second
smallest block after TACTICAL.

**Posture**

| Setting | Value |
| --- | --- |
| `AllyRange` | 1300.0 |
| `MilitaryScoutCap` | 2 |
| `MilitaryAttackThreshold` | 40.0 |
| `MilitaryRaidMinPower` / `MilitaryRaidAvgPower` | 60.0 / 80.0 |

`MilitaryAttackThreshold` 40.0 is the highest in the role layer - SUPPORT
commits to an attack far later than any other role, consistent with disabling its
own T1 combat units.

**Economy**

| Setting | Value |
| --- | --- |
| `SolarEnergyIncomeMinimum` | 160.0 |
| `BuildT1ConvertersUntilMetalIncome` | 18.0 |
| `BuildT1ConvertersMinimumEnergyIncome` | 250.0 |
| `BuildT1ConvertersMinimumEnergyCurrentPercent` | 0.90 |
| `AdvancedSolarEnergyIncomeMinimum` / `Maximum` | 600.0 / 1000.0 |

**T2** - `MinimumMetalIncomeForT2Lab` 17.0, `MinimumEnergyIncomeForT2Lab` 550.0,
`RequiredMetalCurrentForT2Lab` 800.0, `MaxT2BotLabs` 1. These are the lowest T2
gates of any role - SUPPORT techs earlier than TECH does (18.0 / 500.0 / 1000.0).

**Builders** - `MaxT1Builders` 5, `MaxT2Builders` 5,
`SecondaryT1AssistMetalIncomeMax` 80.0.

**Nano** - `NanoEnergyPerUnit` 200.0, `NanoMetalPerUnit` 10.0, `NanoMaxCount`
200, `NanoBuildWhenOverMetal` 1000.0.

**Commander assist** - `CommanderFactoryAssistDeadlineSeconds` 80 (the comment
says "first 2 minutes"; 80 seconds is not 2 minutes),
`CommanderFactoryAssistGuardTimeoutSeconds` 10.

SUPPORT does **not** declare `UseDynamicFactoryProduction`.

## Init: what SUPPORT installs

`Support_Init`:

1. `aiTerrainMgr.SetAllyZoneRange(1300.0)`.
2. Installs the four military quota values.
3. `Support_ApplyStartLimits()`.
4. `ObjectiveHelpers::LogAllObjectivesFromStart(AiRole::SUPPORT, "SUPPORT")`.

No fire-state pass (FRONT, SEA and TACTICAL each have one) and no
`FactoryProduction::Initialize()` branch.

`Support_ApplyStartLimits` is the only start-limit function that mixes styles:

```angelscript
startLimits.set("armap", 0);   // hardcoded aircraft plants
startLimits.set("corap", 0);
startLimits.set("legap", 0);
startLimits.set("armsilo", 0); // hardcoded nuke silos
startLimits.set("corsilo", 0);
startLimits.set("legsilo", 0);
startLimits.set("armrectr", 5); // resurrect bots allowed
startLimits.set("cornecro", 5);

RoleLimitHelpers::DisableT1Combat(startLimits, Global::AISettings::Side);
UnitHelpers::ApplyUnitLimits(startLimits);
```

`RoleLimitHelpers::DisableT1Combat` is used by no other role. It is the
side-aware way to do what AIR does by hand, and it is the reason SUPPORT's
`MilitaryAttackThreshold` of 40.0 is coherent: the role has no early combat units
to attack with.

`armrectr`/`cornecro` at 5 is the highest resurrect-bot allowance outside FRONT's
`StartCapRezBots` of 10. There is no Legion equivalent listed.

## Decision flows

### Builder

`Support_BuilderAiMakeTask(u)` is the clearest statement of the role's shape:

```text
null u                              -> null
build a defaultTask once, cache it  (never recreated inside this function)
null circuitDef                     -> defaultTask
defaultTask is a builder task whose build type is
    MEX | MEXUP | GEO | GEOUP | ENERGY  -> return defaultTask unchanged
commander                           -> Support_Commander_AiMakeTask(u, defaultTask)
constructor tier 1:
    is primary or secondary T1 bot constructor -> Support_T1Constructor_AiMakeTask
    else if registered as a guard of primary   -> GuardHelpers::AssignWorkerGuard(primary, HIGH, 200s)
    else if registered as a guard of secondary -> GuardHelpers::AssignWorkerGuard(secondary, HIGH, 200s)
otherwise                           -> defaultTask
```

Two things distinguish it. First, the **early-out on resource tasks**: if the
native default already wants a mex, mex upgrade, geo, geo upgrade or energy
building, SUPPORT does not override it. Second, the explicit **guard fan-out** -
constructors that are neither primary nor secondary are put on `HIGH`-priority
200-second guard tasks against the leaders rather than given independent work.

### Economy

`Support_EconomyUpdate` reads `aiEconomyMgr.metal.income` directly and calls
`Support_IncomeBuilderLimits(metalIncome)` - builder caps only. It is commented
"similar to TECH" but implements a fraction of TECH's income-gated cap system.

### Main update

`Support_MainUpdate` has no body beyond a commented-out log line.

## The missing factory handler

Because `FactoryAiMakeTaskHandler` is null, every SUPPORT factory going idle
reaches the native path directly:

```text
factory idle -> CFactoryScript::MakeTask -> Factory::AiMakeTask
             -> RoleConfig.FactoryAiMakeTaskHandler is null
             -> aiFactoryMgr.DefaultMakeTask(u)
             -> CFactoryManager::CreateFactoryTask
```

Consequences worth holding:

- SUPPORT cannot run openers, batching, or priority enqueues. There is no
  equivalent of FRONT's scout rush or AIR's strike opener.
- SUPPORT's production is shaped **only** by unit caps - the start limits, the
  `DisableT1Combat` call, and `Support_IncomeBuilderLimits`. Caps are the entire
  control surface.
- The native `isActive` / `rare` gate described in [hover.md](hover.md) applies
  to SUPPORT with no script mediation at all. Once any non-T1 factory exists,
  SUPPORT's T1 factories are subject to the full native filter.

Whether this is intentional minimalism or an unfinished role is not recorded
anywhere in the source.

## Known defects

1. **`Support_BuilderAiMakeTask` logs with the `[FRONT]` prefix.** The
   early-out on MEX/MEXUP/GEO/GEOUP/ENERGY logs
   `"[FRONT] defaultTask is MEX/MEXUP/GEO/GEOUP/ENERGY; returning early"` from
   inside `support.as`. Copy-paste from `front.as`; makes log filtering by role
   wrong.

2. **`Support_MainUpdate` is empty but registered.** A delegate call per tick for
   nothing.

3. **No `FactoryAiMakeTaskHandler`.** Documented above. Whether deliberate is
   unknown; it is the single largest behavioural difference between SUPPORT and
   every other role.

4. **`CommanderFactoryAssistDeadlineSeconds = 80` contradicts its own comment**
   ("default: first 2 minutes"). Either the value or the comment is wrong. SEA
   uses `3 * 60` with the same misleading comment.

5. **T2 gates are lower than TECH's.** `MinimumMetalIncomeForT2Lab` 17.0 vs
   TECH's 18.0, energy 550.0 vs 500.0, metal current 800.0 vs 1000.0. A role
   described as an economic *substitute* techs sooner than the dedicated economy
   role. Probably unintended.

6. **`armrectr`/`cornecro` at 5 with no Legion equivalent.** Legion's resurrect
   bot is uncapped here where the other two factions are limited.

7. **Registers `FactoryAiUnitAdded`/`Removed` but no factory task handler.** It
   observes factory unit lifecycle without being able to act on production - an
   odd pairing worth confirming is intended.

## Related

- [README.md](README.md) - the role contract and cross-role findings.
- [tech.md](tech.md) - the dedicated economy role, and the cap system SUPPORT's
  economy update is modelled on.
- [hover.md](hover.md) - the native factory gate that reaches SUPPORT unmediated.

<!-- source: data/script/src/roles/support.as; blob: 354ce85d4c2d9450e508a6c400dd3b485908d024; lines: 497 -->
