# SEA layout, economy and forward shipyard migration

Review date: 2026-10-03. Baseline: `smrt-test` at
`3d8c66d208d7c407e6d22d7d5178049dbbe7ab39`.

**Historical review status: proposed on 2026-10-03.** Implementation and staged
simulations began on 2026-10-04; see [D-188 results](sea-layout-migration-results.md)
for the implemented subset, evidence and remaining rollout gates. The review
below records what was known before those changes.
The owner requested a comprehensive review before changes. Findings below are
source-confirmed unless explicitly described as a risk or test hypothesis.
They do not establish the cause of a particular replay's congestion.

## Recommendation

Give experimental SEA an independent policy controller over the existing native
layout/reservation engine. Reserve naval production berths, their exits and a
shared transit channel before placing dense economy modules beside or behind
them. Expand to safe forward harbors as water control progresses. Retire an old
yard only after a suitable replacement is complete and operational.

Reuse geometry, pins, allied reservation sharing, lifecycle concepts and pure
funding calculations. Do not call TECH's rule table, AIR's factory geometry or
either role's economy state machine from SEA. Preserve their current policy.
In particular, do not transfer AIR's six-lab arrangement, twenty-turret rule,
bomber milestones or TECH's lab-reclaim sequence to naval production.

## Research basis

Game mechanics, source values, arithmetic examples and research caveats are in
the shared knowledge base's
[naval economy review](../../rjm.bar.docs/knowledge/50-economy/54-naval-economy-planning.md).
It combines the pinned BAR UnitDefs with the official
[naval guide](https://www.beyondallreason.info/guide/basics-on-sea-warfare),
[economy guide](https://www.beyondallreason.info/guide/in-depth-look-at-economy)
and [repair/reclaim guide](https://www.beyondallreason.info/guide/reclaim-resurrect-repair).
This is researched doctrine, not a tournament-statistical claim of optimality.

The resulting SEA policy should account for contested versus uncontested water,
local fighting and repair requirements, accessible metal/upgrades, recoverable
wrecks, map-dependent energy choices, and funded useful build power. Neither
gross income alone nor a fixed number of constructors captures those needs.

Use loaded UnitDefs and MoveDefs in simulations. The local BAR reference is
`1d267c20d1e2d27586dfb39aaa622698b203c303`; Recoil is
`92efda5e60fb6df54a8f17a87e4f4cdb4aa2de31`. These are pinned references,
not an assertion that every current lobby runs those revisions.

## Current SEA behavior, traced end to end

Primary sources:
[sea.as](../data/script/src/roles/sea.as),
[naval construction helpers](../data/script/src/helpers/sea_constructor_helpers.as),
[builder manager](../data/script/src/manager/builder.as),
[factory manager](../data/script/src/manager/factory.as),
[economy helpers](../data/script/src/helpers/economy_helpers.as),
[settings](../data/script/src/global.as).

| Area | Actual behavior | Migration requirement |
| --- | --- | --- |
| Scope/selection | Shared experimental profiles register SEA; map-preferred SEA selects it. Legacy difficulty profiles use their native/config behavior. | Gate both the role and experimental option; preserve legacy profiles. |
| Initialization | Ally range 2,000; scout quota 3; attack threshold 1, scale 0.7, wait 120 s; T1 naval combat fire-state configuration; faction/map caps. | Preserve these while testing placement independently. |
| Layout | No `LayoutPlanHandler`. `LayoutHelpers::ApplyForRole` leaves native placement active. | Add SEA plan/init/adoption/leave lifecycle. |
| Builder dispatch | Shared manager preserves an existing construction frame and task tracking, then calls SEA. SEA creates a native default task *first*. It immediately keeps default MEX/MEXUP/GEO/GEOUP/ENERGY tasks. | A new controller must own placement before an ordinary task is enqueued; handle all construction paths, including objectives and defaults. |
| Commander | Within the first 180 s, may guard the primary T1 shipyard in renewable 10 s tasks, after the resource-task early return. No explicit productive-work check here. | Keep local opening construction efficient; assist only useful funded production, release when it stops. |
| T1 constructors | Primary executes objectives then the shared ladder; other constructors may guard the primary for 160 s below 500 E/s, otherwise default. | Assign economic, expansion and field work explicitly; check target progress, capability, reach and safety. |
| T2 constructors | First is registered as freelance, second as primary. Freelance uses default tasks; primary runs converter/fusion ladder, then may guard T1 primary for 120 s. | Preserve useful independence; all capable subs should receive real economic jobs, with bounded productive assist leases. |
| T1 energy/conversion | Primary ladder builds floating converters below 40 M/s, above 250 E/s and at least 90% energy storage. Tidals are requested below 1,200 E/s. Placement follows the worker within 256 elmos. | Reserve energy/converter modules; use net funded energy demand and map yield rather than one lifetime income threshold. |
| Advanced economy | Primary ladder tries advanced converter above 18 M/s and 1,200 E/s with healthy energy storage, else a naval fusion above 30 M/s and 1,200 E/s when energy is low. Explicit fusion branch requires fewer than one existing naval fusion. Positions are within 256 elmos of primary T2 yard. | Repeated modules with useful spending and surplus gates; no unbounded converter-first loop, no explicit one-fusion ceiling. Native fallback currently remains another source of economy. |
| Mex upgrades | The explicit shared ladder upgrade call is on the T1 path; its helper rejects constructors below tier 2 and resolves a land T2 mex. It is not a functioning universal naval upgrade-first policy. Native MEXUP can still occur. | Select an upgrade actually buildable by the specific worker at that site, using native terrain-aware economy queries. Handle underwater mexes and gifted constructors. |
| T2 yard | Ladder asks at 40 M/s and 800 E/s, needs primary T1 yard, allows one T2 yard, anchors within 480 elmos of the primary T1 yard; shared T2 factory cooldown applies. | One consistent admission rule and separate expansion/replacement capacity. |
| Yard limits | `Sea_IncomeLabLimits` assigns `floor(metalIncome / 75)` to every T2 shipyard, then map limits are reapplied. Below 75, the default cap is zero despite the 40-income ladder. | Eliminate competing owners for enabled SEA; preserve explicit map/config prohibitions. |
| Build power | Two T1 and two T2 constructors are explicitly guaranteed; further constructors rely on native production. `Sea_IncomeBuilderLimits` is empty. Nanos use income-derived global counts plus bounded reserve surplus, then per-factory order counters. | Count actual useful regional BP, pending commitments and arrivals; reconcile losses/cancellations. |
| T1 output | Two constructors precede other specialized production; optional early rez sub is disabled; optional dynamic production is called only in the T1 branch; then native output. | First retain ordering for layout comparison; later test contested opening and reclaim-responsive production. |
| T2 output | Two cons, cruiser target 5 in batches of 5, AA target 2 in batches of 2, jammer 1, radar/utility 1, missile ships 5 in batches of 5, anti-nuke 1, flagship 1, then native output. | Capability-safe, pending-aware decisions. Retain combat doctrine initially except correctness fixes. |
| Objectives | T1 SEA workers process PRIMARY objectives. Seaplane platform at 30 M/s; NOW-priority tidals toward 1,200 E/s. Completion uses a historical queued count. | Feed objectives into reserved placement; cancellation/destruction must not satisfy a required building. |
| Cooperation | Third observed T2 constructor donation to team leader; separate `SeaAssist` gives a T1 ship to a TACTICAL ally above sustained 50 M/s while retaining one. Shared metal donation policy applies. | Preserve agreements, verify successful transfer and adequate remaining workforce. |
| Combat | Native naval tasks, response profiles and siege behavior remain important. After six minutes, quota adjustment compares all own army metal with cached enemy water cost per player, raising attack/raid thresholds when behind. | Layout migration must not rewrite engagement behavior; do not use that global cost comparison as proof a forward harbor is safe. |
| Metal maps | Shared `MetalEconomy` precedes SEA builder policy for mobile non-commanders; native converter veto protects metal maps. Compact `MetalLayout::Managed` currently names AIR/TECH only. | Deliberately route enabled SEA field economy through its layout; retain universal converter suppression. |

### Diagnosed issues and confidence

| Finding | Evidence / impact | Record |
| --- | --- | --- |
| Conflicting T2 gate/cap and ignored reserve setting | `ShouldBuildT2Shipyard` sets `mcOk = true`; the configured 800-metal reserve is not enforced. A 40-income decision can still be rejected by a zero UnitDef cap. Map overrides can change the effective result. | KI-221 |
| Legion wrong-faction requests | `Sea_FactoryAiMakeTask` resolves Legion's guaranteed T2 constructor to `coracsub` and flagship to `corblackhy`. Legion's actual yard builds its own units. Donation recognition only includes Armada/Cortex subs. | KI-222 |
| Fragmented placement ownership | Default energy/resource work can precede policy; yard/nano/economy/objective requests lack a complete SEA reservation owner and exit network. A layout toggle alone would not fix them. | KI-223 |
| Limited late economy / unproductive assistance admission | Explicit primary T2 economy only requests its first fusion; assist checks use energy income and target presence, not target progress. Additional native work may hide this in some games. | KI-224 |
| Fleet batches ignore outstanding recruits | At four cruisers the branch requests five more, not the deficit of one. Multiple yards can independently request batches before they finish. | KI-225 |
| Explicit mex-first path is ineffective for naval T2 | T1-only call cannot pass the tier test; helper selects land T2 mex, whereas inspected Armada construction sub builds `armuwmme`. The old role document's shared pre-role gate description is stale. | KI-213 review correction |
| Lost nano capacity is not restored by legacy accounting | Per-factory counter increments on enqueue without loss/cancellation reconciliation. AIR has its own fix; SEA still uses legacy counter. | Existing KI-217 |
| Objective completion can outlive actual platform | Enqueued-once count is not a current structure lifecycle. | Existing KI-210 |
| Switch/limits/documentation inconsistencies | Switch-time predicate hardcodes 30 s while interval generator uses 20-60 s; builder-limit function is empty; faction-asymmetric start caps and misleading log strings remain. | KI-226 |

These findings are not permission to change TACTICAL or TECH's naval behavior.
TACTICAL consumes `SeaConstructor::FromSea/T1Ladder/T2Ladder`; TECH's
[harbor controller](../data/script/src/roles/tech_harbour.as) has its own ladder
but shares builder enqueue helpers and native placement. Keep compatibility
paths intact. The dynamic Legion T2 table now exists in
[factory_configs_sea.as](../data/script/src/manager/factory_production/factory_configs_sea.as);
the old KI-308 placeholder description is stale for this portion. Enabling the
flag does not make SEA's T2 branch call that table.

## What TECH actually does

In [tech_factories.as](../data/script/src/roles/tech_factories.as):

- `FrontReclaimAtCount = 3`: the trigger is **at least three**, not more than
  three. `LandFactoryCount()` includes owned land factory frames and subtracts
  `TechFlank::Count()`; shipyards and aircraft factories do not qualify.
- `BaseLandFactory()` finds an eligible owned land factory within
  `FrontBaseRadius = 1,200` of `Layout::BaseCentre()`. Registered forward-cluster
  labs and `TechFlank` labs are excluded.
- `lab.base.reclaim` calls `ReclaimBaseFactory`: mark it retiring, release the
  base factory reservations, then use a nearby worker/turrets to reclaim it.
  This predicate itself has no completed-replacement or +200 income check.
- Forward placement is separately enabled by `Active()`: an existing land
  factory and `TechBuild::EcoOnline()`, which latches after the ten-second
  minimum metal income reaches the default +200 threshold. The advanced bot
  lab is rebuilt before new T1 front labs.
- TECH's early T1/T2 lab recycling to fund its economy is another sequence.
  None of these rules should change for this SEA work.

**Recommendation:** reuse the retirement lifecycle, not TECH's count trigger.
At sea, a completed replacement with a tested route is a stronger prerequisite
than three structures, some possibly unfinished or in disconnected water.

## Proposed architecture and ownership

### Shared mechanisms that already exist

Use [BaseLayoutGeometry.h](../src/circuit/terrain/BaseLayoutGeometry.h),
[TerrainManager](../src/circuit/terrain/TerrainManager.cpp) and its
[script bindings](../src/circuit/script/InitScript.cpp) for rotation, loaded
footprints, grid snapping, atomic reservation/rollback, named groups, persistent
slots, pinning and save/load. Reuse `LayoutHelpers::ActivationState` and allied
reservation checks. `ShareSlot/ShareZone` publish to the ally-team reservation
store, which ordinary placement also consults; no second SEA messaging protocol
is needed for participating CircuitAI instances. Humans and other AI versions
can still physically obstruct plans, so revalidation remains necessary.

Do not use `PlanAirFactoryCluster` for ships: it explicitly requires aircraft
factories. `CBFactoryTask::Activate` automatically acquires a cluster only for
land factories. Explicit pins can already constrain other construction, but
naval compound creation and egress validation need an explicit new entry point.

`WaterTheatres` is currently advisory: its 64-elmo grid and generic water-body
exit check do not certify each hull. `GetUnitTerrainRoute` currently rejects
non-ground MoveData classes. Reusing the amphibious route API as if it already
supports ships would silently fail. Existing naval lanes provide candidate
directions, not a substitute for product-specific navigability.

### New SEA policy modules (proposed names)

| Module | Responsibility |
| --- | --- |
| `manager/sea_layout.as` | Harbor/module state, candidate ordering, atomic plans, adoption, first-use revalidation, exit reservations, overlays and release |
| `manager/sea_economy.as` | One sampled economy/workload snapshot; safe energy/metal/BP growth and finite-resource opportunities |
| `manager/sea_workforce.as` | Local useful BP, arriving/pending workers, exclusive turret assignment, productive assistance leases |
| `roles/sea_rules.as`, `roles/sea_build.as` | Ordered policy decisions and construction effects; explicit stop/recovery reasons |
| `roles/sea_factories.as` | Existing-output adapter, pending-aware faction-safe recruitment, forward replacement state |
| `helpers/sea_math.as` | Pure admission, retirement and module-ranking functions, executed by AngelScript tests |

Keep these boundaries small. Reuse `BuildPowerMath` and `ProductionMath`
directly. Extract genuinely repeated reservation/assignment utilities only
when tests demonstrate unchanged AIR/TECH callers. Do not generalize their
entire state machines in the same migration.

Native additions should expose mechanism, for example a parameterized naval
compound planner and an egress feasibility query. These are proposed APIs,
not existing registrations. Accept actual factory/support defs, builder and
product movement requirements, orientation and script-selected clearances.
Return a bounded result with explicit reasons: footprint blocked, unreachable
constructor, shallow exit, disconnected product route, allied reservation or
unknown route. Keep investment, safety margins and priorities in SEA settings.

### Harbor layout

```text
                         secured water front
                                 ^
                    shared clear transit channel
                         |               |
                    exit apron      exit apron
                     T1 yard          T2 yard
                  support bank     support bank
                 access aisle / constructor circulation
            tidal/converter block     fusion/support/converter block
                          protected rear water
```

This is a topology, not an exact scale diagram. Initial experiments compare
one- and two-berth modules; additional modules have no arbitrary map-wide
maximum beyond unit limits, safe space and economic admission. Each yard has
its own apron leading to a shared channel; no yard exits through another yard.
Reserve optional seaplane space separately. Future large/extra factories use
their actual rosters and geometry, not a T2 footprint assumption.

The opening yard must not send a lone commander on a long walk to satisfy a
future layout. Search nearby legal water first, reserve its immediate exit,
and adopt that yard as a temporary starter berth if the full harbor does not
fit. Preserve terrain, allied occupancy and basic egress checks. A failed
large plan must not prevent the first usable factory or recovery after losing
all production.

- Use tightly packed economy within small modules, with enough separation for
  construction access, traffic and assessed explosion risk. Compare 2x3 and
  2x6 tidal modules; their sizes are test candidates, not mandatory spending.
- Reserve ship access *before* economy. Turrets go behind or beside the berth
  within actual assist range. Do not fill the apron with defense or storage.
- Validate the constructor's approach and the yard-to-open-water path for all
  products admitted at that berth, including wide ships and submarines. A
  berth that cannot pass a product must not recruit that product.
- Use engine movement/collision semantics: an underwater structure is not
  automatically impassable to every surface ship. Conversely, a generic
  water-body label does not prove sufficient depth, width or turn clearance.
- Place mexes/geos at their resource sites, protecting access around them.
  Safe coast wind is optional and requires a capable builder; a sea constructor
  cannot be assumed to build every land energy structure.
- Pre-plan a bounded number of future modules. Before the first claim/frame,
  revalidate the whole cluster and relocate atomically if blocked. After work
  starts, retain its identity, repair missing support or add an adjacent module;
  do not move a partly built compound or steal another role's reservations.
- Defense protects approaches outside economy envelopes and channels. Preserve
  existing allied-start wall exclusions. Emergency defenses still need legal
  non-blocking placement; a layout is not a reason to abandon base defense.

Native and script construction must have one placement owner. Save and restore
any native automatic-nano settings changed by SEA, as AIR does for its own
instance. Keep useful native task mechanisms through explicit adapters rather
than running two competing planners. The legacy naval converter helpers create
`TaskB::Factory` requests; audit that bookkeeping before choosing the enabled
SEA task type, and leave TECH/TACTICAL callers unchanged.

### Economy and build-power policy

Separate the economy state (opening, contested, growth, recovery) from harbor
layout state. The same reserved sites can be built in different orders.

1. Keep useful existing construction; emergency recovery/defense may override
   according to explicit settings. Preserve construction turrets' highest
   priority enemy-reclaim behavior and player control.
2. Fund immediate energy survival and sufficient naval fighting production.
   Allocate safe mex expansion/upgrades, repair and reclaim before optional
   conversion investments. Do not force an exposed geo or unreachable upgrade.
3. Assign workers to reachable jobs. Release assistance when its project ends,
   stalls without funding, target dies/retires or the route becomes unsafe.
4. Admit BP when a real project can consume it and both resources can fund it.
   Calculate additional metal/energy draw from actual build time and costs,
   deduct assigned/traveling/pending BP, and choose turret versus mobile worker
   according to reach, travel and future work. Reuse tested funding math.
5. Use sustained income plus available bank and recent refill/overflow evidence.
   Received metal/reclaim can fund a finite investment despite negative net
   income; do not assume future gifts or count received resources twice.
6. Evaluate a T2 package: yard + first useful constructor + intended upgrade or
   combat output + support, alongside fleet commitments and energy headroom.
   Current 40/800 thresholds can be initial comparison settings, not sufficient
   admission by themselves. Replace the contradictory +75 cap with the same
   decision's allowed count. Keep profile/map prohibitions authoritative.
7. Grow repeated naval fusion/converter modules when funded; count converters'
   usable capacity and net surplus. Avoid copying an AFUS requirement onto
   construction subs lacking that build option. Land advanced economy is a
   separate optional capability if a suitable worker exists.
8. Reclaim obsolete own economy only for a defined space/efficiency reason,
   after replacement output is completed and verified. Never remove all tidals
   just because one fusion finished. Respect storage headroom for recycling.

Do not import AIR's twenty-turret-per-lab saturation assumption. Measure naval
handoff and exit time, effective output and marginal support value for each
faction/product mix. Factory duplication is justified by usable throughput,
travel savings, new capabilities or resilience, not a rising unit count alone.

### Forward production and retirement

Use the appropriate naval lane/water theater, observed surface/sub/shore/air
threats, recent vision and fleet coverage. A land front marker or nearest-enemy
straight line is not enough. Unknown water needs scouting and a safety margin.

Proposed sequence:

`candidate -> reserved -> building -> completed -> exit verified -> serving -> old yard retiring -> reclaimed`

- Trigger consideration when reinforcement travel or measured congestion
  materially hurts output and a secured forward site exists. A clock or raw
  three-yard count is not sufficient. Reorient/clear an obstruction first when
  that solves the problem more cheaply.
- Permit one funded replacement per theater at a time, with explicit temporary
  overlap allowance so the normal yard cap cannot deadlock replacement.
- Keep the old yard producing during construction. A candidate becomes usable
  only after the required constructor/product route checks and an ordinary
  produced ship physically leaves its apron. Validate large hull classes in
  controlled tests, not by buying a flagship just to certify a live match yard.
- Retain required T1 and T2 build capabilities and productive capacity. Drain
  the old yard's current product, redirect new orders/assists, then retire it
  through `Lifecycle`. Check metal storage headroom and local threat again.
- Cancel an unsafe *unstarted* replacement without losing the old yard. If a
  new harbor dies before retirement, retain old production. After retirement
  begins, use explicit recovery state if replacement is lost; do not allow
  actors to alternate guard, production and reclaim on the same structure.
- Do not reclaim an ally's structures. Old support turrets may still serve
  economy/repair; relocate them only if their remaining work warrants it.
- Avoid oscillation using minimum travel improvement, stable safety evidence
  and a re-evaluation delay. Safety can justify a lateral or rear recovery
  harbor; never enforce TECH's monotonic forward movement on SEA.

## Concrete code change map

All entries below are planned, not modified by this review.

| Files / symbols | Change and isolation requirement | Verification |
| --- | --- | --- |
| `roles/sea.as`, `global.as`, `setup.as`, `types/role_config.as` | SEA-only `ExperimentalBuild`, configuration and layout hook; new-controller dispatch before default creation. Use existing callback fields where adequate. Preserve disabled path. | Script compilation; enabled/disabled role traces; opener and recovery fixtures |
| `manager/commands.as` | SEA leave/enter cleanup, settings restore, reservation release/adoption | SEA -> other role -> SEA; no stale pins or changed other-role settings |
| Proposed SEA modules above | Construction, workforce, priority and relocation ownership | Pure policy tests + runtime actor/state assertions |
| `helpers/unit_helpers.as`, `roles/sea.as` | Resolve Legion roster through verified catalogs and `CanBuild`; successful-transfer donation state; pending recruitment accounting | All three factions, optional content and captured factories |
| `helpers/sea_constructor_helpers.as`, `helpers/economy_helpers.as` | Preserve legacy/shared consumers; extract only pure reusable decisions. Enabled SEA uses capability-aware naval upgrade path. | TACTICAL donation ladder and TECH harbor controls |
| `manager/builder.as` | Enabled SEA placement and task lifecycle integration; `AiTaskAdded` currently does not dispatch the generic role callback. Add an explicit scoped call or a separately tested generic repair; do not merely register an unreachable hook. | Add/cancel/finish/death tests; exactly one lifecycle transition |
| `manager/factory.as`, native `FactoryManager` if required | SEA retirement veto before production overrides; pending recruitment snapshot and product/exit progress query; preserve other roles' ordering | No production/assist on retiring yards; queue not duplicated |
| `manager/lifecycle.as`, `manager/invariants.as` | Reuse retirement state; make SEA actors obey it; record new invariants/actor matrix. Review TECH-specific settings before extracting shared memory policy. | Retirement race, interruption, reload and recovery tests |
| `manager/lanes.as`, `water_theatres.as`, `strategic_sites.as` | Opt-in SEA read-side lane/theater access with independent settings; no unconditional widening of TECH/AIR policy | Multiple ponds, different hull classes, fog and changed fronts |
| `src/circuit/terrain/BaseLayoutGeometry.h`, `TerrainManager.{h,cpp}` | Parameterized naval berths/modules, atomic plans and product-aware exit/route checks | Existing geometry snapshots unchanged; new geometry and route tests |
| `src/circuit/terrain/TerrainData.*`, `BattleAnalysis.h`, `BattleLanes.cpp` as needed | Reuse native movement areas/pathing for ships; add minimal hull-aware query rather than invoking ground-only routes | Shallow neck, narrow turn, shoreline cliff, disconnected water and blocked channel |
| `src/circuit/script/InitScript.cpp`, `BuilderScript.cpp`, `FactoryScript.cpp` as needed | Register new mechanisms/snapshots with explicit ownership contracts | `check_script_api.py`, real script compilation, installed-DLL parity |
| `src/circuit/task/builder/FactoryTask.cpp`, `BuilderTask.cpp` | Ensure explicit naval pins cannot drift into ordinary placement; keep automatic land/AIR paths unchanged | Pin failure/rollback, bootstrap, production egress |
| `manager/metal_economy.as`, `metal_layout.as` | Explicit SEA opt-in integration; field mex layout must not use a land-only capability assumption | Water metal-map economy; zero converters; normal-map controls |
| `data/config/block_map.json` and experimental overrides only if required | Audit actual naval footprints/classification, especially Legion/extra units; avoid changing global spacing as a shortcut | Base/extra faction matrices and legacy placement controls |
| `tools/playtest`, `tests/`, `doc/roles/sea.md`, role index, references/invariants/actor matrix | Tests, observers and updated role documentation after implementation | All storage/checker contracts; preserved historical evidence |

## Performance contract

Maintain registries by lifecycle events; sample economic/assignment state once
per simulation second using one owned-unit pass. Cache per-factory build options
and product movement classes. Do not scan all map cells per builder query.
With U owned units, P pending tasks and C clusters, ordinary bookkeeping should
be O(U + P + C), with spatial queries for local support/obstacles rather than
O(U*C) repeated reach comparisons.

Run bounded candidate batches and cached/asynchronous terrain work on revisions
or meaningful front shifts. A practical initial search budget is eight candidates
per scheduler slice; measure before tuning. Constructor orders change on task
or target state changes, not every planning poll. No arbitrary APM rate limiter.
Threat response and emergency reclaim retain immediate event handling.

Measure p50/p95/p99 AI update and placement-query time, worst spikes, game-speed
ratio, command counts, pending queue size and memory by map and unit count.
Count actual engine commands, not script decisions. Shared mechanisms must not
add SEA scans to disabled roles. Performance comparison requires identical build,
hardware, speed, map and concurrency conditions; FPS alone is insufficient.

## Verification plan

### Before implementation

Capture the existing build as immutable baseline. Reproduce cramped yards and
late economy with independent observers, separating geometry blockage from
factory policy idle, resource stall, absent target or an unfinished order.
Record actual loaded defs/options, map checksum, engine/DLL/data hash, role,
start coordinates, seed and speed. Keep uncertainty visible.

### Unit and integration tests

Use the existing AngelScript executable test harness for `sea_math.as` and
shared funding functions; test actual policy functions rather than copied
Python formulas. Extend dependency-free native geometry/route tests.

- All facings, odd/even footprints, shallow/deep sites, hull clearance, separate
  ship/sub routes, blocked connector, builder access, overlapping ally zones,
  constructor aisles and out-of-map candidates.
- Atomic failure of every reservation step; no leaked zones. Replan before
  first construction, but never relocate active work. Restore old save data
  without fabricating new ownership.
- Income 39/40/74/75, reserve requirement, low energy, sustained deficit,
  received-metal refill, reclaim burst, exhausted bank and outstanding costs.
  New BP must have work; incoming BP must prevent duplicate purchases.
- Build-option checks for every faction; pending/active/completed distinction;
  four completed plus one pending cruiser must not enqueue five more.
- Naval mex upgrade ahead of optional conversion; no feasible upgrade must not
  deadlock economy. Native metal-map veto remains effective.
- Canceled nano, killed nano, transferred nano/factory/constructor, newly gifted
  T2 sub, guard target idle/dead, commander release, switching roles and reload.
- Replacement at normal yard cap; threatened site; lost replacement; old yard
  finishes current ship; no tier/capability loss; no orders after retirement.

### Controlled rendered cases

| Scenario / category | Physical evidence and pass condition |
| --- | --- |
| `sea/layout/berth-egress` | Spawn funded construction and representative products from each yard. Ship leaves the apron and reaches an external rally point. Inspect largest admitted hull and sub separately. No permanently trapped units. |
| `sea/layout/economy-fill` | Grow energy/conversion/support to fill several modules; overlays and screenshots show clear exits/channels, no ally overlap and correct actual BP reach. |
| `sea/layout/blocked-first-slot` | Ally building/wreck obstructs an unused reservation; whole unused module is recalculated. Active neighboring module remains fixed. |
| `sea/strategy/forward-yard` | Old yard continues output while replacement builds; new ship exits; old product drains; retirement/reclaim follows. Repeat after front reversal and replacement destruction. |
| `sea/economy/workforce-pressure` | Gift/reclaim bursts, ordinary deficit and energy stall. Workers complete useful structures/ships; no unlimited nano/constructor buying and no idle guard chain. |
| `sea/cooperation/mixed-bases` | SEA next to AIR/TECH and a seeded TACTICAL ally; placements respect reservations, donations succeed, defense stays out of economic clusters and routes. |
| `sea/reliability/lifecycle` | Save/load, unit transfers, destroyed/canceled support and role changes; ownership, capacity and claims agree with real units. |

A queued task or printed route is not evidence of success. Observe actual
construction, ship departure, repair/reclaim amounts and resource expenditure.
Set scenario-specific egress deadlines from path length, unit speed/acceleration
and unobstructed baseline; label a timeout failure, not a successful completion.

### Natural games and regression matrix

Use Supreme Isthmus, Glacial Gap, Tundra Continents, Serene Caldera and Erebos
Lakes. Pin installed versions and inspect valid water starts. These cover broad
water fronts, constrained coasts, islands and disconnected/limited water.
Use explicit SEA assignments where needed and record fixture overrides; do not
claim the ordinary role selector chose a forced test position.

Start with one baseline/candidate pair on each map. After controlled cases pass,
expand to all three factions, two deterministic seeds and side swaps: 60 games
per build across five maps. Run 45-60 game minutes or retain an explicit early
defeat/censored result. Add representative 8v8 games on Supreme, Glacial and
Tundra with AIR/TECH/TACTICAL allies. Also test a water-capable metal map such as
Nine Metal Islands, a dry map fallback, extra units and disabled SEA layout.

Track at 5/10/15/20/30/45 minutes: completed economy, mex income/upgrades,
energy surplus/deficit, waste/overflow/donations, useful and idle BP, factory
utilization, egress times/blocked time, reinforcement travel, navy delivered,
losses, reclaimed/repaired value, water/metal control and base survival.
Do not rank supplied-resource fixtures on natural-economy leaderboards.

Acceptance has two levels:

1. **Hard correctness:** no invariant/crash/API error; no forbidden converter
   on metal maps; no wrong-faction recruits; no lost/leaked claims; no structure
   ordered into protected exits; successful observed replacement before planned
   retirement; no layout-induced permanently trapped product in test fixtures.
2. **Gameplay/performance:** reduce blocked-production and reinforcement delay
   without losing early fleet viability or worsening resource waste. Compare
   paired distributions, not the single best run. Provisional regression guard:
   investigate >5% worse median milestone/usable-output or p95 AI update time
   versus the matching baseline, accounting for normal variance. No universal
   win-rate or optimality claim from a small test set.

AIR/TECH controls must retain their disabled-SEA deterministic decision traces
and current tests, including TECH's exact lab recycling and AIR's transport,
fighter/bomber and workforce priorities. In mixed games their outcomes can
legitimately change as SEA reserves space; validate reservation cooperation
separately from policy regression. Include TACTICAL's construction-ship gift
and TECH's own harbor as direct consumers of shared mechanisms.

During simulations provide screenshots and behavioral analysis while running,
as requested by the owner. Required views: opening harbor; filled economy with
clear channel; wide ship leaving; old/new yards during handover; completed
forward relocation; and every failed congestion case. Preserve the screenshots,
replay/log, observer data and original verdict.

Use the established [storage convention](test-storage.md): cases/checks under
`tools/playtest/{cases,checks}/sea/<area>/`; raw games under
`build-theatres/games/sea/<area>/<scenario>/<map>/<UTC-id>/`; compact immutable
results under `doc/benchmarks/records/sea/<area>/<scenario>/<date>/<UTC-id>/`.
Reuse storage allocation/publication; never rename or overwrite old benchmarks.

### Rollout and stop points

1. Add observers, baseline games, pure tests and faction/cap correctness fixes
   behind SEA's experimental gate. Reproduce each defect before claiming it fixed.
2. Introduce naval reservations and required pins while retaining production
   priorities. Pass geometry, exit, ally-overlap and normal-role controls.
3. Enable SEA economic/workforce ownership and capability-aware mex upgrades.
   Pass ordinary/metal-map economy, loss, donation and idle-assist cases.
4. Enable forward replacement, product draining and retirement. Pass reversal,
   destruction and multi-theater cases before long natural games.
5. Consider adaptive combat composition/opening tuning separately, using the
   new evidence. Do not hide a combat rewrite inside a placement migration.

Compile the complete shared graph for all experimental profiles, run
`check_script_api.py` against the deployed DLL before every launch, and run
native/AngelScript tests plus unit helpers, role docs, invariants and doc links.
Known unrelated checker findings must be reported, not suppressed. The existing
eight missing-hover documentation links are a baseline issue (KI-404).

Keep the feature disabled by default until the hard gates and regression matrix
pass. There is no external blocker to starting implementation after review;
product-aware naval egress and safe task ownership are engineering prerequisites,
and effective naval support saturation remains a measurement question.

## Review deliverables

This document and the shared research note are the plan. Open findings are
recorded in [known issues](known-issues.md); the deliberate SEA-only design and
deferred implementation are recorded as D-187 in [decisions](decisions.md).
No scripts, native code, profiles, test definitions or benchmark evidence were
changed, and no new match was launched for this review.

Review checks: invariant practice has zero findings; CircuitAI's documentation
checker inspected 4,829 relative links and reported only the eight existing
missing-hover links. The shared knowledge checker inspected 758 files, with
zero broken links/images; its five unknown unit IDs are in the pre-existing
air-mechanics document, not this research note. `git diff --check` passed.
