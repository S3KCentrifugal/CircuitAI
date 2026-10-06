# SEA Role

## Forward mex clusters (D-217)

Default-on `ExpandMexClusters` runs independently of the economy/layout switch.
The first T1 construction ship claims nearby home mexes first, then keeps claiming
reachable safe mexes within 3600 elmos of its current position. A second
expander is admitted once three T1 construction ships exist. Native occupancy,
allied territory and terrain checks remain authoritative; metal maps retain the
existing opening. Two nearby remote mexes earn a funded torpedo defense, then a
surface tower at +30 metal and AA when SEA observes air pressure. See
[implementation and validation](../reviews/2026-10-06-sea-mex-expansion.md).

`Sea_MainUpdate` checks known enemy weapon coverage plus a 256-elmo buffer once
per second. Any exposed T1 construction ship withdraws toward its safe starting
yard; player, retreat, enemy reclaim and external ownership are respected.
Advances into the contested part of the sea need 600 metal of nearby combat
ships. Defenses supplement those ships; they do not replace naval control.
`Sea_BuilderAiUnitAdded/Removed` maintain the safety roster by ID and clear
removed workers' retry/withdrawal state. Only the designated workers expand;
native support ships also receive the danger response.

## Secured-water invasion (D-212)

Default-on `Sea::AmphibiousInvasion` requires AdaptiveFleet and compact/layout
support. `SeaInvasion` verifies recent LOS+sonar across the connected water body,
checks current/remembered threats, and waits a quiet interval. It reserves an
enemy-coast amphibious complex, exit and turret bank, dispatches a navy screen,
then builds only with actual nearby protection and two-resource funding. A
completed complex and its support turrets precede a separately income-gated
underwater gantry. Normal seaplane admission retains precedence.

Factory products assemble in movement-specific cohorts, cross a validated
landing, then use dry routes toward backline economy. No TECH/AIR controller or
shared JSON classification is changed. See [plan and evidence](../sea-amphibious-transition.md).

## Recovery submarines and factory continuity (D-211)

SEA recovery runs in compact and experimental economic modes. Native queries
supply legal reachable wrecks and damaged naval allies; script orders them:
low-metal reclaim, flagship repair, ship resurrection, other ship repair.
Submarines cannot assist construction and are kept out of factory guards.
An empty recovery queue waits briefly and is interrupted by new work.

T1 tech-saving WAIT was removed at the user's request. SEA native fallbacks
keep every factory tier active; retirement and resource safety still apply.
The [design and simulation evidence](../sea-recovery-production.md) distinguishes
an empty queue from resource stalls and obstructed output.

| Setting | Default | Purpose |
| --- | --- | --- |
| `KeepFactoriesQueued` | true | Keep valid recruits queued through income dips; native recruit spending priority still responds to shortages. |
| `EnableEarlyRezSub` | true | Enables SEA recovery-sub procurement. |
| `MetalIncomePerRezSub` | 60 metal/s | Income allowance for each additional sub. |
| `FleetMetalPerRezSub` | 6000 metal | Fleet allowance for each additional sub. |
| `RecoveryMetalLowFraction` | 0.20 | Enter reclaim-first state below this storage fraction. |
| `RecoveryMetalResumeFraction` | 0.40 | Leave reclaim-first state at this fraction. |
| `RecoverySearchRadius` | 24000 elmos | Maximum recovery query distance; native checks safe reachability. |

Target after 1500 fleet metal is `1 + min(floor(income/60), floor(fleet/6000))`.
Pending recruits count toward it; one additional funded hull is queued at a time.


## Independent fleet operations (D-201)

`SeaCombat::Active` now requires SEA plus AdaptiveFleet, independently of
ExperimentalBuild. `Sea_MainUpdate` ticks combat with either economic path;
`Sea_FactoryAiMakeTask` admits emergency counters after one constructor and
adaptive hulls/scouts after two. The legacy Legion T2 constructor uses
`SeaEconomy::Constructor` rather than Cortex's unavailable constructor.

[SeaOperations](../../data/script/src/manager/sea_operations.as) groups hulls
by definition and water body, separates scouts, releases a seven-hull cohort
or a sixty-second wait, searches water when there is no observed objective,
and withdraws surface-only cohorts from insufficiently screened sub threats.
It uses native terrain routes and contact tasks, preserves player/retreat/AA/
carrier ownership, and restores artillery after emergency screening. Sensors
and ABM ships escort cohorts from behind. Unknown sonar contacts contribute a
configurable response estimate; lost contact costs expire after thirty seconds.
Dictionary misses explicitly contribute zero completed hulls. The
[rework design](../sea-fleet-rework.md) defines limits and runtime acceptance;
[played results](../sea-fleet-rework-results.md) distinguish check coverage from
unverified lifecycle and multiplayer claims.
The earlier D-188/D-189 gating description below is historical for combat;
experimental economic production remains gated.

All of these settings belong to `Global::RoleSettings::Sea`:

| Setting | Default | Meaning |
| --- | ---: | --- |
| `AdaptiveFleet` | true | SEA-only adaptive combat, independent of the layout switch |
| `FleetOperations` | true | Route/search/screen director; procurement remains independently gated by AdaptiveFleet |
| `FleetReleaseCount` / `FleetReleaseSeconds` | 7 / 60 | Release a combat cohort on size **or** elapsed time |
| `FleetSearchSeconds` / `FleetContactSeconds` | 45 / 20 | Search-objective expiry and native-contact observation interval |
| `FleetScreenRadius` / `FleetScreenRatio` | 1100 / 1.2 | Local underwater screen radius and required coverage multiplier |
| `FleetLaneSpacing` | 72 | Maximum approach-lane spacing; invalid coast offsets collapse to the route |
| `FleetScouts` | 3 | Minimum scout count once fleet metal reaches 1000; hybrid AA can raise actual counts |
| `FleetThreatMemorySeconds` | 30 | Bounded lost-contact cost memory, without querying hidden positions |
| `UnknownSubContactMetal` | 500 | Uncertainty budget for each legally detected, unidentified submerged contact |

## Experimental layout migration (D-188)

`LayoutPlanHandler` now calls `SeaLayout::Init`. With
`Sea::ExperimentalBuild=false` the legacy economic flow is retained; D-201's
independent combat policy still runs when AdaptiveFleet is enabled.
D191 adds default-on `Sea::CompactEconomy`: `Sea_BuilderAiMakeTask` dispatches
through `SeaBuild::LegacyTask`, which wraps `Sea_LegacyBuilderTask` and routes
naval economy orders to compact blocks. Coastal land work stays native.
`SeaLayout::Enabled` gates placement/census, while `SeaLayout::Active` also
requires ExperimentalBuild and gates the broader economic migration.
See the [economy-block plan](../sea-economy-block-plan.md).
When enabled, `Sea_MainUpdate` ticks the planner before the legacy six-minute
military-quota gate; builder and factory dispatch use
[SeaBuild](sea_build.md) and [SeaFactories](sea_factories.md).
The income-limit hook gives funded T2 admission room for replacement overlap,
then reapplies explicit map limits. Reservations share AIR/TECH's native layout
ownership. The migration is opt-in pending the full acceptance matrix; see
[results](../sea-layout-migration-results.md).

Historically, the D-189 candidate added `SeaCombat`, gated by both SEA migration and
`AdaptiveFleet`. It samples current known contacts once per second and selects
capability-checked counters at each factory decision, then skips the legacy
global army/per-player quota recalculation. Native movement, weapon firing,
retreat and formations are unchanged after rejected order-reuse experiments.
See the [combat plan](../sea-combat-enhancement-plan.md) and
[unit controls](../sea-unit-controls.md). The default migration flag remains
off until the broader acceptance gates pass.

Reference for the `SEA` AngelScript role: naval production and water expansion.
How it is registered, what it installs at init, how its objective system drives
construction, and where it is currently wrong.

Source: `data/script/src/roles/sea.as` (903 lines), namespace `RoleSea`.
Line references are as of branch `smrt`, 2026-09-17. Prefer function names over
line numbers when navigating.

## Contents

- [Intent](#intent)
- [Registration](#registration)
- [Settings](#settings)
- [Init: what SEA installs](#init-what-sea-installs)
- [Mex upgrade priority](#mex-upgrade-priority)
- [Decision flows](#decision-flows)
- [Strategic objectives](#strategic-objectives)
- [The donation path](#the-donation-path)
- [Seeding a TACTICAL ally](#seeding-a-tactical-ally)
- [Attack waves](#attack-waves)
- [Missile cruisers hold fire](#missile-cruisers-hold-fire)
- [Known defects](#known-defects)
- [Related](#related)

## Intent

SEA builds a navy from shipyards and expands across water. It is one of three
roles running dynamic military quota adjustment, and one of two (with TACTICAL)
that drives construction through the strategic objective system rather than
purely through income gates.

Its quota posture is the second most aggressive after AIR -
`MilitaryAttackThreshold` 1.0 and `MilitaryRaidMinPower` 1.0 mean SEA commits
early with whatever it has floating.

## Registration

`RoleSea::Register()` fills **14 of 22** slots - the common thirteen plus
`FactoryAiMakeTaskHandler`.

| Slot | Handler |
| --- | --- |
| `MainUpdateHandler` | `Sea_MainUpdate` |
| `InitHandler` | `Sea_Init` |
| `EconomyUpdateHandler` | `Sea_EconomyUpdate` |
| `AiIsSwitchTimeHandler` | `Sea_AiIsSwitchTime` |
| `AiIsSwitchAllowedHandler` | `Sea_AiIsSwitchAllowed` |
| `MakeSwitchIntervalHandler` | `Sea_MakeSwitchInterval` |
| `BuilderAiMakeTaskHandler` | `Sea_BuilderAiMakeTask` |
| `BuilderAiTaskAddedHandler` | `Sea_BuilderAiTaskAdded` |
| `BuilderAiTaskRemovedHandler` | `Sea_BuilderAiTaskRemoved` |
| `BuilderAiUnitAdded` | `Sea_BuilderAiUnitAdded` |
| `BuilderAiUnitRemoved` | `Sea_BuilderAiUnitRemoved` |
| `FactoryAiMakeTaskHandler` | `Sea_FactoryAiMakeTask` |
| `SelectFactoryHandler` | `Sea_SelectFactoryHandler` |
| `RoleMatchHandler` | `Sea_RoleMatch` |

Not filled: both factory task hooks, both factory unit hooks, all three military
hooks, `AiMakeDefenceHandler`.

## Settings

`Global::RoleSettings::Sea` in `data/script/src/global.as`.

**Posture**

| Setting | Value |
| --- | --- |
| `AllyRange` | 2000.0 |
| `MinAiSwitchTime` / `MaxAiSwitchTime` | 20 / 60 s |
| `MilitaryScoutCap` | 3 |
| `MilitaryAttackThreshold` | 1.0 |
| `MilitaryRaidMinPower` / `MilitaryRaidAvgPower` | 1.0 / 5.0 |

**Guard limits** - SEA is the only role overriding the builder guard defaults:
`BuilderMaxGuardsPerLeader` 2 (global default 10),
`BuilderMaxGuardsPerTacticalLeader` 0.

**Energy** - `TidalEnergyIncomeMinimum` 1200.0 (commented "tune per map; tidals
vary"), `AssistPrimaryWorkerEnergyIncomeMinimum` 500.0,
`EnergyStorageLowPercent` 0.90, converter gates at
`BuildT1ConvertersUntilMetalIncome` 40.0 / `MinimumEnergyIncome` 250.0 /
`MinimumEnergyCurrentPercent` 0.90, advanced converter at 18.0 metal /
1200.0 energy, FUS at 30.0 metal / 1200.0 energy with `MaxEnergyIncomeForFUS`
999999.0 (effectively uncapped).

**T2 shipyard** - `MinimumMetalIncomeForT2Shipyard` 40.0,
`MinimumEnergyIncomeForT2Shipyard` 800.0,
`RequiredMetalCurrentForT2Shipyard` 800.0, `MaxT2Shipyards` 1.
The shared legacy helper currently ignores the stored-metal threshold
(`mcOk=true`); it still checks metal/energy income and the yard count.

**Opening metal and seaplanes**

| Setting | Default | Effect |
| --- | --- | --- |
| `NearbyMexRadius` | 2400 elmos | First construction ship claims safe reachable metal within this radius of its home yard before discretionary work. |
| `SeaplanesAfterT2` | true | Make a seaplane platform the next discretionary factory after a completed T2 yard, retaining its aircraft production. |
| `SeaplaneMinimumMetalIncome` | 80 metal/s | Minimum throughout the shared mature ten-second income window. |
| `SeaplaneMinimumEnergyIncome` | 1500 energy/s | Minimum throughout the same window. |
| `SeaplaneMetalReserve` | 500 metal | Uncommitted bank must cover the platform plus this reserve; spending forecast preserves the reserve. |
| `SeaplaneEnergyReserve` | 1000 energy | Equivalent energy bank and forecast reserve. |
| `ReservedSupportPerFactory` | 20 | Reserve reachable naval construction-turret capacity before admitting the platform; actual purchases remain income/workload driven. |
| `MaxSupportPerBerth` | 40 | Upper bound used by support scaling and the reserved-capacity requirement. |

**Naval production** - `MinT2DestroyerCount` 5, `T2DestroyerBatchSize` 5,
`EnableEarlyRezSub` **true**, `MetalIncomePerRezSub` 60.0.

**Commander assist** - `CommanderFactoryAssistDeadlineSeconds` 3 min,
`CommanderFactoryAssistGuardTimeoutSeconds` 10.

**Dynamic quota** - `DynamicQuotaEnemyCostThresholdMultiplier` 1.0,
`UnderpoweredAttackQuota` 100.0, `UnderpoweredRaidMinQuota` 100.0,
`UnderpoweredRaidAvgQuota` 200.0, `DynamicQuotaDelaySeconds` 6 min - the longest
delay of the three dynamic-quota roles.

`UseDynamicFactoryProduction` is **false**.

## Init: what SEA installs

`Sea_Init`:

1. `aiTerrainMgr.SetAllyZoneRange(2000.0)`.
2. Installs the four military quota values.
3. `Sea_ApplyStartLimits()` - zeroes `armbanth`, `armmar`, `armcroc` and the
   three nuke silos.
4. Iterates `UnitHelpers::GetAllT1NavalCombatUnits()` and applies
   `d.SetFireState(3)`, mirroring FRONT's land behaviour for naval units.
5. `FactoryProduction::Initialize()` only if the flag is set.
6. `ObjectiveHelpers::LogAllObjectivesFromStart(AiRole::SEA, "SEA")`.

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

### Builder

`Sea_BuilderAiMakeTask(builder)` routes commander to
`Sea_Commander_AiMakeTask`, T1 constructors to `Sea_T1Constructor_AiMakeTask`
and T2 to `Sea_T2Constructor_AiMakeTask`, each taking a pre-built `defaultTask`.
Constructors are recognised by the unit-helper lists (`SeaConstructor::IsT1`
/ `IsT2`); the old `"acsub"` suffix test missed Legion's `leganavyconsub`.

The ladders themselves live in `helpers/sea_constructor_helpers.as`
([D-042](../decisions.md#d-042--the-sea-constructor-ladder-is-shared-and-tactical-runs-it)):
`SeaConstructor::T1Ladder` (T2 shipyard, mex upgrades, naval converter,
nano, tidals) for the primary construction ship after SEA's objectives,
`SeaConstructor::T2Ladder` (advanced naval converter, naval fusion) for the
primary T2 sub, `SeaConstructor::AssistPrimary` for the rest. SEA passes
`SeaConstructor::FromSea()`, its own `RoleSettings::Sea` numbers, so its
behaviour is unchanged; TACTICAL runs the same ladder on the ship SEA donates.

`Sea_BuilderAiUnitAdded` is the longest of the unit-added handlers in the role
layer (~34 lines) - it establishes primary/secondary constructor identity and
the guard relationships that `BuilderMaxGuardsPerLeader = 2` then bounds.

### Factory

`Sea_FactoryAiMakeTask(u)` is the second-largest factory handler after TECH's
(~200 lines). It drives shipyard production including the T2 destroyer batching
governed by `MinT2DestroyerCount` and `T2DestroyerBatchSize`.

### Economy

`Sea_EconomyUpdate` reads `aiEconomyMgr.metal.income` **directly** - not the
sliding-window minimum FRONT uses - and calls `Sea_IncomeLimits(metalIncome)`,
which fans out to `Sea_IncomeLabLimits` and `Sea_IncomeBuilderLimits`.
`Sea_IncomeLabLimits` caps every side's T2 shipyard
(`UnitHelpers::GetAllT2Shipyards()`, so `legadvshipyard` as well as
`armasy`/`corasy`) at one per 75 metal income.

### Dynamic quotas

`Sea_MainUpdate` returns early until
`ai.frame >= Global::RoleSettings::Sea::DynamicQuotaDelaySeconds * SECOND`, then
runs `Sea_UpdateDynamicMilitaryQuotas()`, which compares
`Sea_GetArmyMetalCostEstimate()` - `aiMilitaryMgr.armyCost`, i.e. the **whole**
army, not sea units only (contrast AIR) - with
`Military::GetEnemyWaterCostPerPlayer()`. SEA is the only one of the three
dynamic-quota roles to gate on a *setting* rather than a compile-time constant.

## Strategic objectives

SEA and TACTICAL are the two roles wired into `Objectives::`.

| Function | Purpose |
| --- | --- |
| `Sea_GetObjectiveBuildPos(objective, fallback)` | resolve a build position for an objective, with fallback |
| `Sea_TryHandleObjective(builder, conLocation, unitSide, mi, ei)` | attempt to advance the current objective given income state |

Unlike TACTICAL, SEA has no builder-group partitioning and no objective chain
executor - it handles one objective at a time against the current constructor.

## The donation path

`sea.as` opens with a small nested namespace containing `IsT2SeaConstructor(d)`
and `TryDonate(u)`. `TryDonate` builds a one-element `array<CCircuitUnit@>` and
hands the unit away.

This is the only unit-donation path in the role layer. It exists so a T2 sea
constructor stranded without useful water work can be given to an ally rather
than idling.

## Known defects

1. **`Sea_ApplyStartLimits` logs the wrong role.** The function ends with
   `GenericHelpers::LogUtil("Tactical start limits applied", 3)` - copy-paste
   from `tactical.as`. Any log-driven diagnosis of SEA start limits will look
   for the wrong string.

2. **`Sea::NukeLimit = 0` is never read.** As with FRONT and AIR, suppression
   comes from the silo start limits instead.

3. **Start limits hardcode three Armada units with no Cortex or Legion
   equivalents.** `armbanth`, `armmar` and `armcroc` are zeroed; the
   corresponding `cor*` and `leg*` units are not. Whatever this rule intends, it
   applies to one faction only.

4. **`Sea_EconomyUpdate` uses instantaneous income.** `aiEconomyMgr.metal.income`
   rather than `Economy::GetMinMetalIncomeLast10s()`. SEA's income limits will
   oscillate with production spikes where FRONT's do not.

5. **`Sea_Init` has no else-branch log for the disabled dynamic factory
   production.** AIR, FRONT and TACTICAL all log "disabled; using legacy"; SEA
   logs nothing, so its factory-production mode is invisible in the log.

6. **Resolved by D-211:** recovery procurement is enabled and scales with fleet
   and income; the flag still allows opting out.

7. **`MaxEnergyIncomeForFUS = 999999.0`** is a sentinel standing in for "no
   cap". FRONT uses 4000.0 and TECH 2000.0 for the same setting, so SEA's FUS
   behaviour diverges silently rather than by stated intent.

8. **`Sea_SelectFactoryHandler` is a verbatim copy** of FRONT's and AIR's apart
   from its log prefix, and ignores `isReset`.

## Legion T2 shipyard

Legion SEA never built a T2 shipyard. `Builder::EnqueueT2Shipyard` resolved
the side to `corasy` ("Legion shares Cortex shipyard"), but Legion's naval
constructors - `legnavyconship`, `leganavyconsub`, `legch` - build
`legadvshipyard` and cannot build `corasy`. The task was enqueued with
priority NOW, no unit could ever pass `CanAssignTo`, it sat until its 600 s
timeout, and the 180 s T2-factory cooldown it set meant the next attempt was
the same task again. `UnitHelpers::GetT2ShipyardForSide` now returns
`legadvshipyard` for Legion
([D-039](../decisions.md#d-039--legion-builds-its-own-t2-shipyard)). Script only;
not Played.

## Seeding a TACTICAL ally

Once SEA's sliding-minimum metal income clears
`Global::SeaAssist::MinMetalIncome` (50) and it holds more construction ships
than `KeepConstructors` (1), it gives **one** T1 construction ship to a
TACTICAL ally on the roster - once per SEA instance, never again.

The point is what it unlocks on the other side rather than the 200 metal:
TACTICAL starts with both shipyard caps at zero and cannot build any naval
structure at all. Lifting the cap alone was not enough - see
[`tactical.md`](tactical.md#naval-unlock) for why the ship then sat idle - so
TACTICAL also enqueues a T1 shipyard where the ship is standing. One construction ship lets it expand along the coast beside
SEA, hold the shoreline it is already suited to fighting over, and add naval
economy SEA does not have to build itself.

If no TACTICAL ally is on the roster, nothing happens - the check costs a
roster scan every 30 frames and never fires. Ties are broken by lowest team
id, so two SEA players seed the same ally properly rather than one each
halfway.

`Team::SeaAssist` (`data/script/src/manager/sea_assist.as`). The roles in that
decision are **AiRole** - the start-position player role - not unit roles;
units are matched by name against `UnitHelpers::GetAllT1SeaConstructors`.

## Attack waves

Cruisers were seen massing for most of a game as one large group that never
attacked. The cause is native and role-independent: a DEFEND squad promotes
to ATTACK when its power reaches a bar that `CMilitaryManager::
UpdateDefenceTasks` re-sets every 5 s to `max(quota.attack, PreMaxGroupThreat)`
- and `PreMaxGroupThreat` is the influence of the **second-strongest enemy
group on the whole map**, whatever domain it is in. SEA sets `quota.attack`
to 1, so the threat term always binds, and a naval squad was waiting to
outweigh a land army it could never reach.

Two new quotas, both script-set (`aiMilitaryMgr.quota.attackScale`,
`quota.attackWait`), defaulted for every role in `Global::Military` from
`setup.as` and overridden here in `Sea_Init`:

| Quota | Global default | SEA | Effect |
| --- | --- | --- | --- |
| `attackScale` | 0.8 | **0.7** | > 0: the bar becomes the strongest enemy group the squad's **leader can reach** (`CTerrainManager::CanMoveToPos`), times this. 0: legacy map-wide bar. |
| `attackWait` | 180 s | **120 s** | > 0: a squad that has waited this long at or above `quota.attack` attacks regardless. Logs `DEFEND: squad of N waited Ts at power P (needed Q); attacking anyway`. |

A navy that sits is a navy that loses the water, hence the lower bar and
shorter wait than the land default. Sprinters and blitz hoarded in a TECH
base were the same bug; the global default covers them.

## Missile cruisers hold fire

Longbow (`armmship`) and Messenger (`cormship`) are `["artillery", "naval"]`
with the `siege` attribute, so they get `CArtilleryTask`, which only ever
**orders** a structure - both of its target passes skip `IsMobile()`. What
they were doing to passing boats was the engine's own fire-at-will while
holding position. `CArtilleryTask::AssignTo` now puts any `siege`-tagged
unit on **return fire**: it engages its ordered static and anything that
attacks it, and nothing else; `RemoveAssignee` restores fire-at-will so a
retreat or reassignment behaves as before. The attribute is the switch, so
it is config-driven per def.

## Related

The opt-in combat migration installs `SeaCombat::MilitaryTask` as
`MilitaryAiMakeTaskHandler`. Ordinary hulls retain native task selection.
D-202's `SeaPatrol` owns T1 scout and dedicated AA movement. Herrings are
recognized independently of their AA-only experimental profile label. Scouts
lease individual patrol sectors across navigable safe water; dedicated AA
covers the friendly coast. `HybridScoutAirResponse` interrupts eligible AA
patrols for any legal same-sea aircraft contact, including unarmed transits.
Ships move to distinct rows/columns, holding positions while BAR priority-fire
targets nearby aircraft. No shared ATTACK destination collapses the screen.
Patrols resume after the contact memory expires. Player, carrier and repair
retreat owners are preserved. `SeaCombat::MilitaryRemoved` leaves ID cleanup
to the next owned census through `MilitaryAiUnitRemoved`; role exit releases routes immediately.
See [patrol and air-defense design/evidence](../sea-patrol-air-defense.md).
With `RespectCarrierControl`, attached carrier drones use a passive native
task until their game-owned host rule disappears; a one-second census also
handles the rule arriving after creation. Role exit releases this ownership.
See the [complete source trace](../sea-native-trace.md) and
[combat acceptance plan](../sea-combat-enhancement-plan.md).

`Sea_Init` registers missing Legion advanced-yard native metadata through
`RegisterScriptFactory`, gated by `Sea::ExperimentalBuild || Sea::AdaptiveFleet`. Existing profile
entries are preserved; missing entries use the actual build options and the
Cortex advanced yard's generic lifecycle handlers. This runs before layout
activation. Supplied terrible/balanced fixtures check physical constructor and
combat-ship completion, not merely a finished factory frame.

- [README.md](README.md) - the role contract and cross-role findings.
- [tactical.md](tactical.md) - the other objective-driven role, and the one SEA's
  settings block was copy-pasted into.
- [hover.md](hover.md) - hover plants are reachable on water-ish maps and are not
  a role.

<!-- source: data/script/src/roles/sea.as; blob: 966dcbfc31794a7ef4058e23d5bda8ae6a67faae; lines: 897 -->


## Water-control investigation (2026-10-05)

The current fleet director does not yet implement a full secure-water,
production-denial and surplus coastal-support mission lifecycle. See the
[SEA control investigation](../sea-control-investigation.md) for the exact
source gaps, two played Supreme yard tests, unresolved KI-512 through KI-515,
and the SEA-only implementation/acceptance plan. This investigation changes
no gameplay policy; the improved D-202 scout and AA ownership is retained.

## D-209: first-ship mex priority and seaplanes

The first construction ship (Builder's primary identity, not minimum unit ID)
tries free safe reachable mexes within NearbyMexRadius (2400 elmos from its home
yard) before native discretionary work. Current construction is completed; once
local claims are exhausted it returns to the existing converter/economy ladder.
This applies to both compact and experimental SEA builder paths.

SeaplanesAfterT2 defaults true: a completed T2 yard enables the next platform
purchase, subject to sustained income, full uncommitted cost plus reserves and
the resource spending forecast (D-210). Other new factories wait until a platform
exists or is queued; a lost T1 yard can be recovered. Platforms reserve reachable
naval turret capacity, participate in production support scaling, and use native
production with keepActive so the T2 yard does not suppress their aircraft.
Missing Legion platform metadata is registered on this SEA instance only.
See [plan and results](../sea-seaplane-transition.md).

### Lost-water coastal fallback (D-219)

`SeaCoast::Tick` follows the fleet census. After a previously held water body
has no viable own foothold for 30 seconds, land-capable workers (including gifts)
rebuild a safe inland bot base and fortify assigned friendly beaches. The shared
builder/factory hooks place this SEA-only recovery ahead of optional spam.
Storage, energy, inland mexes, land-lab build power, T1/T2 turrets, sensors,
wall flanks and available medium mines are covered. A stable 60-second naval
return releases this policy. See the [design and simulation evidence](../reviews/2026-10-06-sea-coastal-fallback.md).
