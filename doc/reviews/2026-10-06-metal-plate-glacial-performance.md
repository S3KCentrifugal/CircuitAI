# Metal Plate and Glacial Gap: 8v8 performance investigation

Status: investigation complete, remediation proposed (D-220). Both games ran
with all 16 AI teams and ordinary resources. Metal Plate was stopped at 30:01
because simulation speed had collapsed; Glacial reached its 60-minute horizon.
Neither reached GameOver. A further 12-minute Glacial run separated SEA costs.
These are competitive 8v8 performance observations, **not completed matches to
victory**. No production AI policy, native implementation, unit classification,
response interval or command has been changed by this investigation.

## Scope and interpretation

The investigation uses the current working tree, experimental_hard, all three
factions, ordinary resources, seed 220001, and one rendered game at a time.
Full Metal Plate 1.7 needs a staged 16-start role fixture because the production
map registry does not contain that opening. Glacial Gap v1.1 uses its registered
starts. Metal Plate is a dense land workload; Glacial adds connected naval
theatres. They are complementary workloads, not a paired old/new speedup test.

Pinned native DLL: `build-theatres/d216-final/SkirmishAI.dll`, SHA-256
`45eb0f2e89a285e336bcafdddcc550246f79619c2e747a9a73ad628b3d8b67ff`.
Matching debug symbols:
`b3c269fd8fa0d566c538ad54ed55eb7dc41b3994f72fdc7d8414abae259044f1`.
Engine: Recoil 2026.07.04. Game: BAR test-31479-433a460. Per-run manifests pin
the staged script/config bytes, including diagnostic wrappers. The production
data tree is untouched.

Host reported by Recoil: i9-12900KF, 16 physical / 24 logical cores, 65,349 MB
RAM, RTX 3080 Ti, NVIDIA 616.64, Windows build 26200. Rendered resolution is
1280x720 with the runner's lean-render settings. This is one host, not a hardware
or internet-player benchmark.

Native opt-in phase timers and staged AngelScript dispatch labels measure
elapsed work. The engine profiler measures AI, simulation, animation, path and
render scopes. Inclusive parents and children are **not additive**, and worker
elapsed times can overlap. Native exclusive phase and label tables remove their
instrumented descendants; they still sit inside the engine AI scope.

Unit-command observers count actual UnitCommand events, including a separate
Lua-origin count. They do not count UDP packets or establish internet latency.
Repeated air signatures alone do not prove that an order can be suppressed.
Randomized instruction samples record instruction locations and inline debug
symbols, **not runtime call stacks or unbiased CPU-cycle percentages**. Thread
CPU deltas and capture overhead are retained alongside them.

Normal-speed observation windows are separated from 12x fast-forward requests.
Achieved game speed, rendering FPS and AI milliseconds per simulation frame
are different measurements. Engine profiling itself has overhead. At 30 Hz,
the entire simulation has 33.33 ms per frame before rendering and other work;
that is not an allowance of 33.33 ms for each AI.

The [engine performance reference](https://github.com/beyond-all-reason/RecoilEngine/blob/master/coding-agents/ENGINE_PERFORMANCE.md)
describes the serial main simulation/draw loop and worker phases. Actual code
checks also use the local `2026.07.04` tag; current upstream documentation is
context, not a claim that the installed executable contains every later change.

## Severity definitions

| Severity | Meaning in this review |
| --- | --- |
| Extra high | A leading measured cost associated with loss of real-time simulation, or a large sustained share of the AI budget. Address first; it does not imply the whole cost is avoidable. |
| High | A substantial measured recurring cost or command load with a concrete investigation/remediation path. Requires focused attribution and equivalence tests before claiming savings. |
| Medium | A verified repeated-work pattern in a measured hot subsystem, but its individual cost is not yet isolated, or a smaller measured contributor. |
| Low | Small current cost, instrumentation/maintenance work, or an idea whose benefit is not established by these runs. |

Severity, confidence in attribution, implementation risk and expected savings
are separate. No numerical FPS gain is promised for an unimplemented proposal.

## Observed results

Times below are game minutes. AI time is the **combined sixteen-AI scope**,
not per player. Each row summarizes the preceding game minute; p99 is across
its simulation-frame samples. Average progress is game seconds / wall seconds.

| Map / minute | Units | AI mean ms/frame | AI p99 ms/frame | Average progress | Render FPS median / mode |
| --- | ---: | ---: | ---: | ---: | --- |
| Metal Plate / 5 | 777 | 0.978 | 3.184 | 1.015x | 252 / normal speed |
| Metal Plate / 20 | 4,684 | 7.724 | 15.617 | 0.773x | 22 / normal speed |
| Metal Plate / 30 | 9,250 | 20.002 | 37.656 | 0.109x | 38 / 12x requested, severe simulation slowdown |
| Glacial / 5 | 413 | 1.291 | 5.709 | 1.014x | 242 / normal speed |
| Glacial / 20 | 1,122 | 2.257 | 8.305 | 1.016x | 156 / normal speed |
| Glacial / 40 | 2,952 | 7.324 | 27.078 | 1.014x | 51 / normal speed |
| Glacial / 57 | 3,690 | 22.306 | 52.000 | 0.772x | 8 / 12x requested |
| Glacial / 60 | 3,889 | 12.063 | 41.500 | 1.002x | 10 / normal speed |

Metal's final game minute took **548.46 wall seconds**. Its higher final render
FPS does not mean recovery: fewer simulation steps were completed. Glacial's
minute-57 spike subsided, but its late p99 AI time alone still exceeds the
33.33 ms real-time simulation-frame budget. The last Glacial minute includes
an isolated AI maximum of 180.375 ms; this is not its sustained mean.

All 16 competing teams remained alive through the final complete interval in
each game. No script crash or instrumentation error was observed. Strict
gameplay checks nevertheless **FAIL**, with invariant counts retained in the
original reports: 15 Metal events; 679 Glacial events in the drained log, of
which 553 are INV-053 (TECH's dedicated T2 air constructor idle check).
The watcher observed 676 Glacial failures before draining shutdown output.
Do not reinterpret a useful performance capture as a gameplay pass or attribute
these existing gameplay failures to the new read-only timing wrappers.

### Severity-ranked findings

The order is impact-first across these two workloads. Engine work has the
largest measured scope, while items 2 and 3 are the strongest **CircuitAI**
optimization targets. A measured scope is a cost envelope, not a promised saving.

| Rank | Severity | Finding and measured evidence | Behavior-preserving remediation | Scope / confidence |
| --- | --- | --- | --- | --- |
| 1 | Extra high | Metal engine scaling: `Sim` 186.18 ms/frame, `CUnitScriptEngine::Tick` 97.82, `MoveType` 71.54 and path requests 20.08 at minute 30. These scopes overlap. | Obtain matching engine symbols; isolate COB, animation traversal/allocation, movement and waits. Reuse animation traversal buffers and exact path/command scratch only where equivalence is proven. | Recoil; measured parent cost, avoidable leaf share unmeasured. |
| 2 | Extra high | Ranged decision queries: **12.14 ms/frame** at Glacial 57 (54.4% of AI), versus 1.605 at 60. | Add true early-stop spatial predicates; avoid irrelevant mobile-range inflation for static safety checks; retain exact candidates, firing-site order and all eight-frame response timing. | C++; measured phase, source-verified repeated traversal. |
| 3 | Extra high | Ranged snapshots: **8.02 ms/frame** at Metal 30 (40.1% of AI); each requesting AI refreshes overlapping world data. | Touched-cell/generation storage, stable ascending-ID inventory, definition-ID reuse with lifecycle versions; only share observations when freshness and authority are proven. | C++; measured phase plus matching instruction samples. |
| 4 | High | Builder/factory dispatch: Metal **3.87 + 3.43 ms/frame** exclusive; Glacial **1.72 + 1.42** at 60. The factory label includes construction turrets. Late samples repeatedly hit owned-unit scans and ally-wrapper rebuilding. | Exact unfinished/pending ledgers and spatial/type indexes; retain friendly wrappers instead of rebuilding the full registry; remove AIR terminal-state and non-commander scans. | C++ and AngelScript; aggregate cost measured, individual savings need subphase tests. |
| 5 | High | Command/path workload: Metal **108,463 unit orders/game-minute** across teams; Glacial peaks at **20,011** for one SEA team, minute 60. | Attribute issuing task and queue intent; optimize command/path preparation while keeping orders identical. Omit only proven no-ops. True order batching requires an engine ABI with identical frame/order/error semantics. | C++ / engine; count verified, redundant share and internet lag unmeasured. |
| 6 | High | SEA economy/layout work: `sea-update` peaks at **1.65 ms/frame** across six teams; Glacial emits **433,177 reservation trace lines**. Detail run attributes 81% of measured SEA subphase time to economy/build/geometry. | Index zone membership for release, maintain exact local support/unfinished counts, reuse planning scratch, and separate optional detailed reservation tracing. Preserve every candidate, retry cadence and placement result. | C++ and AngelScript; parent/subphase evidence, exact rollback/logging share not isolated. |
| 7 | Medium | Immutable roster allocation and disabled-log formatting in hot script paths; TECH `lab.base.reclaim` reaches **1.385 ms/frame** at Glacial 50, including more than list allocation. | Initialize immutable definition rosters once, guard formatting before strings/loops, reuse decision-local buffers. Keep live counts, adoption side effects and RNG draws fresh. | AngelScript; source verified, allocation-only cost unmeasured. |
| 8 | Medium | Instrumentation overhead can distort diagnosis: profiler `AddTime` accumulates **14.00 ms/sim-frame** at Metal 30, including worker lock wait. | Repeat fixed-load profiler-off controls; consider thread-local profiler aggregation after verifying timer semantics. Keep diagnostics off in ordinary play. | Engine diagnostics; measured, not directly subtractable from game CPU. |
| 9 | Low | Broad threading/GC rewrites and further reservation collision-check work are not justified as leading fixes by these captures. | Retain existing indexed collision lookup. Profile allocation/GC duration and worker saturation first; offload only immutable pure work with the same-frame commit deadline. | Investigation only; no established gain from more threads or less GC. |

Items 4, 6 and 7 can touch the same helper. Their envelopes must not be added
as independent savings. In particular, SEA economy calls also occur under
builder dispatch, and generic script labels include native callbacks.

### SEA attribution and command detail

The follow-up used identical DLL/settings with additional staged, nested SEA
labels, ending after 12 minutes. Summed exclusive time across six SEA AIs:

| SEA subphase | Cumulative ms |
| --- | ---: |
| Economy census/accounting | 3,341.57 |
| Build planning/support | 3,199.83 |
| Layout geometry | 718.47 |
| Patrol | 526.82 |
| Operations | 401.18 |
| Combat | 237.25 |
| Coast/recovery/eco-layout/invasion/expansion combined | 574.53 |

Economy/build/geometry total 7,259.87 of 8,999.65 measured SEA subphase ms
(80.7%). This is an **opening attribution**, not proof of the same late-game
proportions. It emitted 102,335 reservation traces. SEA ran its default compact
economy path (`CompactEconomy=true`, `ExperimentalBuild=false`), with adaptive
fleet and forward harbors enabled; the result is not limited to opting into the
experimental-build toggle.

Metal's maximum single-team count was 15,307 at minute 29, on FRONT team 14;
15,296 of those events were non-Lua-origin. At minute 30, only 13,385 of its
108,463 orders were for air units. Glacial's final interval had 77,768 total
orders, 7,625 for air units, with SEA team 12 issuing 20,011 total. AIR is not
the sole source of high command volume. These counters measure unit orders,
not human clicks, network packets or proof that repeated orders are redundant.

## Remediation contracts

### Ranged snapshots and spatial storage

Files: [RangedWorld.cpp](../../src/circuit/task/fighter/RangedWorld.cpp),
[RangedWorld.h](../../src/circuit/task/fighter/RangedWorld.h),
[RangedGeometry.h](../../src/circuit/terrain/RangedGeometry.h),
[SpringUnit.cpp](../../src/circuit/spring/SpringUnit.cpp).

`Refresh()` already runs at most once per requesting AI per simulation frame.
It still asks Recoil to filter **all active units** for friends, sorts friendly
IDs, reads definitions/positions, rebuilds spatial buckets, and refreshes enemy
contacts and shot/formation state. With A active ranged controllers, N world
units and F friendly units, the repeated friendly component costs roughly
O(A * (N + F log F)). The existing direct API path removed wrapper churn; it
did not eliminate these scans or the sorting.

Start with representation-only changes:

1. Retain flat map-bounded spatial cells with generation stamps or touched-cell
   lists. Preserve z/x cell traversal and insertion order. Skip only provably
   empty out-of-map cells and retain an overflow path for any legal out-of-map
   record; clamping a stored point to another cell is not equivalent.
   Do not truncate candidates. Current `SpatialIndex::Clear` visits all buckets
   retained since startup; `clusterValues.clear()` also frees/recreates nodes.
2. Use an ascending ID bitset/radix pass instead of comparison sorting, or a
   lifecycle-maintained ordered ID inventory. A bitset preserves exact ascending
   traversal without relying on the engine's active-vector order. Validate ID
   bounds and reuse storage.
3. Retain compact friendly records and avoid repeating engine definition-ID
   resolution when an explicit unit-lifecycle version proves it unchanged.
   `MetadataFor()` already caches immutable definition facts; that is not a new
   optimization. Separating stationary/moving records must still refresh dynamic
   positions and radii at the original observation instant where the engine
   permits them to change.
4. Only then consider a shared ally snapshot. It needs an explicit observation
   epoch and invalidation on create/destroy/give/take, definition changes,
   teleport, load and authority handover. Per-AI enemy visibility, contact
   history, shot reservations, formation slots and policy remain private.
   A plain frame-number cache is insufficient if state changes between callbacks.

Illustrative representation change, not a patch:

```cpp
// Current: revisit every historical bucket on every refresh.
void Clear() { for (auto& [key, values] : cells) values.clear(); }

// Proposed: clear only cells populated in the previous generation.
void Clear() {
    for (CellId id : touched) cells[id].values.clear();
    touched.clear();
    AdvanceGenerationWithWrapReset();
}
void Add(CellId id, int value) {
    auto& cell = cells[id];
    if (cell.generation != generation) {
        cell.generation = generation;
        touched.push_back(id);
    }
    cell.values.push_back(value); // unchanged candidate/tie order
}
```

Validation: extend the existing snapshot oracle to all decision-relevant fields,
compare ordered candidates and actual command traces, and test movement,
destruction, transfer, fog transitions, authority death and save/load. Benchmark
2k/5k/10k units with multiple ranged AIs. Keep refresh cadence and response
logic identical. **C++ only initially; no JSON or AngelScript tuning change.**

### Ranged decision queries: stop when the answer is known

Files: [RangedWorld.cpp](../../src/circuit/task/fighter/RangedWorld.cpp),
[RangedGeometry.h](../../src/circuit/terrain/RangedGeometry.h),
[RangedEngagement.cpp](../../src/circuit/task/fighter/RangedEngagement.cpp).

Glacial exposes a different ranged cost from Metal Plate's snapshot rebuilding.
The ranged-decision exclusive phase reaches 2.90 ms/frame at minute 34, then
12.14 at minute 57; their snapshot phases are only 0.344 and 1.089 respectively.
The decision considers up to
17 firing sites per compatible weapon and another 27 staging sites when blocked.
Each site can make several spatial queries. Bounded site count does not imply
constant query cost: coverage expands with weapon range and contacts.

`SpatialIndex::Query` always visits every cell/result. `Safe` merely makes its
lambda return once `safe` is false; the enclosing cell traversal continues.
`FreeSlot`, `FriendlySplash`, `HasScreen` and `FriendlyLine` similarly need only
an existence answer. Add an `Any`/early-stop traversal for these pure predicates:

```cpp
// Current: the visitor does no useful work after the first unsafe contact,
// but Query still performs the remaining bucket lookups and visits.
enemies.Query(center, radius, [&](int i) {
    if (!safe) return;
    if (ViolatesExistingRule(contacts[i])) safe = false;
});

// Proposed: same predicate; the traversal itself stops on the first match.
const bool safe = !enemies.Any(center, radius, [&](int i) {
    return ViolatesExistingRule(contacts[i]);
});
```

`Danger` is currently used only as zero/nonzero by these callers. An explicit
`HasDanger` can short-circuit after a positive contribution once the finite,
nonnegative cost contract is proven; retain the sum for any numeric consumer
or unsupported values. Do not change float summation order for scored results.

`Safe` ignores mobile contacts but expands its query by the largest hazard range
including mobiles. Maintain a separate static-hazard maximum/index for that
predicate. A conservative range-tiered coverage index can avoid searching a
map-sized rectangle because of one distant artillery unit; exact segment/disc
tests remain the final authority. Deduplicate candidates without changing the
ordering used by scored target selection. Do not truncate local threats.

Validate against brute force on dense fleets, one extreme-range static,
formation slot changes within a frame, blocked retreats, unknown radar contacts,
death blasts and friendly fire. Preserve the eight-frame decision interval,
damage/idle invalidation, firing-site order, command ownership and all retreat
rules. These are **native C++ representation/query changes**, not profile edits.

### Builder/factory dispatch and repeated unit/task scans

Files: [factory_production.as](../../data/script/src/manager/factory_production.as),
[generic_helpers.as](../../data/script/src/helpers/generic_helpers.as),
[FactoryScript.cpp](../../src/circuit/script/FactoryScript.cpp),
[BuilderManager.cpp](../../src/circuit/module/BuilderManager.cpp),
[MetalFieldEconomy.cpp](../../src/circuit/module/MetalFieldEconomy.cpp),
[metal_economy.as](../../data/script/src/manager/metal_economy.as),
[AllyTeam.cpp](../../src/circuit/unit/ally/AllyTeam.cpp).

The labels measure whole dispatch bodies, including native calls. They do not
prove that any single loop accounts for the whole cost. Proposed work:

- Split actual lab production from construction-turret dispatch. Native
  `CFactoryManager::CreateAssistTask` refreshes the entire ally wrapper registry
  before performing a local friendly query. Many turrets asking in different
  frames can repeatedly pay for the whole allied army. Retain local-query
  semantics and target order while removing the global allocation requirement;
  do not reduce assistance or enemy-reclaim responsiveness.
  `UpdateFriendlyUnits` also prunes reclaim marks and Juno/nuke histories;
  separating its wrapper rebuild must retain those lifecycle duties and their
  original visibility/expiry semantics.
- AIR's `AirBuild::RetireStarter` still obtains/scans every owned unit after
  its persistent `air.starter.retired` flag is set. Add an early terminal-state
  check **after** servicing an existing retiring lab, so an unfinished reclaim
  is never abandoned. `StarterReadyToRetire` already rejects every candidate
  in that state. This is an exact O(N)-to-O(1) opportunity for those calls.
- `MetalEconomy::AirTask` asks `NearestPlant` for every constructor, although
  only the commander uses the result. Move that pure search inside the commander
  path and retain its observation point. This removes an unnecessary full owned
  scan for each aircraft constructor without changing its economic decisions.

- Guard disabled diagnostic formatting at its call site. `LogUtil` checks the
  level **after** argument strings and probability lists have been constructed.
  Factory production constructs multiple strings even at normal log level 1.
  Retain warnings and visible logs at their current levels.
- Pre-resolve immutable factory/role rosters to definition handles/IDs after
  profile loading. Re-evaluate availability, caps, threat and economy on the
  same invocation. Preserve role order, score arithmetic and random draws.
- TECH's `LandFactoryNames()` constructs nested arrays on each call, including
  from `IsLandFactory()` for each factory inspected by `BaseLandFactory()`.
  Retain the ordered roster after content/profile initialization and a matching
  definition-membership table. Keep live counts and `TechFlank::Owns` adoption
  fresh: that helper has side effects. In Glacial minute 47, the separate
  `lab.base.reclaim` label alone accounts for 0.652 ms/frame across the two TECH
  teams; its immutable-list allocations are a code-verified candidate, not a
  measured allocation-only share. This does not change the three-factory gate,
  reclaim ordering, or the front-placement policy.
- Build candidate lists once within the read-only portion of one production
  decision. Avoid copying the same role list for validation and selection.
  Do not reuse across enqueue/cap mutations or alias recursive callbacks.
- Replace repeated `GetPendingRecruitCount` full task scans with an exact
  per-definition pending ledger. It must update synchronously on enqueue,
  frame attachment, repeat renewal, cancellation, completion, death and reload.
  Live frames already belong to definition count; never double-count them.
- Index unfinished and definition-specific owned IDs for `FindOwnNear` and
  `FindUnfinishedNear`. Reacquire units by ID, retain original radius filtering
  and smallest-ID/equal-distance behavior. Do not resurrect stale pointers.
- For metal fields, index mex records and queued proposals spatially, preserving
  the live-frame/pending distinction and fresh mutation visibility. Do not
  combine the two script censuses across `MetalLayout::Plan` without proving
  that its mutations cannot change the second result.
- Reuse existing ally wrappers or owned snapshot records instead of deleting
  and reconstructing all friendly wrappers and ordered-map nodes. Preserve
  authority-definition lifetime and per-observation freshness.

```angelscript
// Current: the string is built even when LogUtil discards level 4.
GenericHelpers::LogUtil("weights=" + weightsText + " income=" + income, 4);

// Proposed: include the loop that creates weightsText inside this guard.
if (LOG_LEVEL >= 4) {
    GenericHelpers::LogUtil("weights=" + weightsText + " income=" + income, 4);
}
```

This needs **AngelScript and native C++ changes**, with no production-weight,
income-gate or priority change. Do not memoize the selected product: that changes
RNG consumption and responsiveness. First add bounded subphase timers to split
formatting, rosters, task counts, owned scans and actual placement. Validate
each ledger against the old scan after every relevant mutation in tests.
The TECH roster work is in
[tech_factories.as](../../data/script/src/roles/tech_factories.as), with rule
dispatch in [tech_rules.as](../../data/script/src/roles/tech_rules.as).

AIR-specific files are [air_build.as](../../data/script/src/roles/air_build.as)
and [air_rules.as](../../data/script/src/roles/air_rules.as). At Metal Plate
minute 28 the two AIR builder-dispatch labels account for 4,324.99 ms per game
minute (2.40 ms per simulation frame); individual helper savings are still
unmeasured. The broad factory label must not be presented as proof that verbose
factory-string formatting alone costs its entire measured duration.

### SEA layout retries and script/native boundary work

Files: [sea_build.as](../../data/script/src/roles/sea_build.as),
[sea_layout.as](../../data/script/src/manager/sea_layout.as),
[sea_eco_layout.as](../../data/script/src/manager/sea_eco_layout.as),
[sea_combat.as](../../data/script/src/manager/sea_combat.as),
[TerrainManager.cpp](../../src/circuit/terrain/TerrainManager.cpp).

The six SEA controllers are a recurring Glacial cost. `Sea_MainUpdate` includes
construction planning, combat/patrol, coast, expansion and invasion, so its
parent label alone must not be attributed entirely to combat or entirely to
layout. The separate `--detail-sea` attribution mode distinguishes these.

Source-level candidates:

- `CTerrainManager::ReleaseZone` scans **all** reservations to discover the
  released zone's slots. Keep an exact zone-to-slot membership index, updated
  on creation, relocation, release, reset and load. Preserve ascending slot-ID
  removal order. This changes a release from O(R + zone area) to
  O(K + zone area), where R is every reservation and K is this zone's slots.
  Frequent failed SEA patch attempts amplify the otherwise unrelated global
  scan. The existing constant-in-reservation-count collision index does not
  solve this mutation cost. This index is a smaller and safer first patch than
  redesigning the complete planning transaction.
- `PlanPatch` attempts up to eight candidates, reserving slots individually and
  rolling them back on failure. Each persistent slot owns a zone; attempts can
  produce many native calls, published reservation mutations and log lines.
  A native transaction can calculate the identical ordered trial once and
  commit its successful result atomically. Preserve snapping, buildability,
  candidate/cursor progression, reservation identities where observable, first
  valid placement and allied exclusion. Test partial failure and simultaneous
  allied plans. This is not permission to shrink the support footprint.
- Keep temporary geometry and cell scratch buffers across attempts. Cache only
  facts whose complete dependency version is known (terrain, footprint and
  relevant blocking state). A failed engine build test can change when a mobile
  unit moves; never cache it indefinitely or introduce a longer retry interval.
- `SupportFootprint` walks patch slots for each berth/actual factory. An exact
  spatial index over current valid nano slots can answer the same radius query,
  including consumed slots. Update on reserve/release/relocation/load. Do not
  count completed nanos a second time or change which factory receives support.
- `SeaEconomy::LocalPower` scans the owned census for each queried factory and
  constructs a string-keyed `seen` dictionary, then examines live projects.
  Use the shared exact spatial/type index plus reused integer-ID membership
  storage. Retain framed-versus-pending accounting, current task ownership and
  the observation instant; caching a factory's power across an assist transfer
  would change build-power admission. Reuse immutable constructor rosters in
  `Tick`, but keep the once-per-second census and its reset semantics intact.
- Native `RESERVE` creation/release messages are unconditional. Offer explicit
  detailed tracing and cheap aggregate counters for performance observations;
  avoid constructing thousands of discarded strings or synchronously writing
  per-slot trace lines by default. Keep warnings and the detailed mode required
  by existing tests. This changes diagnostic verbosity, not game orders.
- `SeaCombat::Select` already uses one owned census plus roster arithmetic.
  Retain that improvement. Reuse exact pending-recruit ledgers and immutable
  roster facts rather than adding a new per-hull global scan. Native batch
  reads may reduce VM boundary crossings only if they return the same ordered
  legal observations at the same point in the callback.

No formation spacing, patrol cadence, submarine response ratio, scout count,
construction priorities or production weights should change. A proposal to
make the planner try fewer sites would change behavior and is excluded.

### Command processing, spam routes and path work

Files: [RouteTask.cpp](../../src/circuit/task/fighter/RouteTask.cpp),
[spam.as](../../data/script/src/manager/spam.as),
[RangedEngagement.cpp](../../src/circuit/task/fighter/RangedEngagement.cpp),
[CircuitUnit.cpp](../../src/circuit/unit/CircuitUnit.cpp),
[CustomCommand.cpp](../../src/circuit/spring/CustomCommand.cpp).

The Recoil 2026.07.04 `CAICallback::GiveOrder` path serializes an AI command per
unit; `GiveGroupOrder` is a stub. Merely calling a collection a control group
does not make its commands a single network message. Unit-command counts in
this local test are still not UDP datagram counts: transport aggregation and
Lua-generated commands differ.

For strict behavior preservation, keep every effective command and optimize
route geometry reuse, scratch storage, command parameter construction and
callback overhead first. Record issuing task, reason, queue state, options,
timeout, target and route version. Then distinguish genuine route changes,
new recruits, required recovery and truly redundant intent. Only a proven
no-op can be omitted; MOVE equality alone is insufficient because reissuing can
reset pathing, queue order or expiry.

A new batched engine ABI could reduce encoding/transport overhead while
preserving every command in order, its issuing AI identity, timeout and exact
frame of application. It is an **engine/interface project**, not an AngelScript
formation switch. Test result codes, command event ordering, packet size limits,
replay determinism and two actual peers. Preserve synchronous error behavior;
do not defer commands across simulation frames to fill a batch.

Reject global APM limits, longer update intervals, fewer spam units, fewer scouts
or less threat response as remedies for this request: those alter behavior.

### Engine animation/movement and profiler overhead

The installed engine tag has a per-unit animation sort and a temporary
`std::deque<pair<LocalModelPiece*, Transform>>` breadth-first traversal in
`CUnitScript::TickAllAnims`. `CUnitScriptEngine::Tick` also includes COB work,
worker completion and ordered animation-finished callbacks. A high parent timer
does not identify which subpart is waste.

Collect matching engine symbols or finer timers for COB, animation transforms,
allocation and worker waits before an engine patch. A concrete candidate is a
reused worker-local breadth-first buffer, preserving the exact visit order and
copy timing; alternatively retain immutable model traversal order. Keep synced
piece transforms, checksums and callback order unchanged. Do not drop animation
updates or lower unit caps to make a benchmark look faster. Path work needs
separate counts for real searches, cache hits, retries and command replacement.

The engine profiler serializes `AddTime` through a shared mutex when enabled.
Its self-timer includes lock wait on participating threads, so its accumulated
time is not directly removable main-thread CPU. Use explicit profiler-off
control intervals and external samples before blaming this cost on ordinary
games. Thread-local timer accumulation with an ordered main-thread merge is a
possible diagnostics-only engine improvement, provided snapshots and lifetime
are handled safely.

### Threading boundaries

[Scheduler.cpp](../../src/circuit/scheduler/Scheduler.cpp) already has a shared
worker pool, capped at eight; Recoil also has its own workers. Sixteen AIs do
not each get an independent eight-thread allowance. Callback-driven managers,
the AngelScript VM and engine wrappers are not safe to move wholesale to workers.

Use workers only for pure calculations on owned immutable snapshots. To preserve
behavior, commit results in the same order and on the same simulation frame,
with version validation and a synchronous fallback at the original deadline.
Otherwise worker completion timing changes decisions. Prioritize data access
and allocation fixes before adding scheduling overhead. Measure worker queue
delay and saturation; low total-machine CPU usage does not show that the main
thread is free.

## What is already optimized

Do not re-propose D-197/D-199 as new fixes. Allied/local reservation lookup uses
direct paged occupancy, O(candidate footprint area), independent of reservation
count for a fixed footprint. Candidate search, terrain checks and placement
retries remain separate costs. The redundant layout preflight was removed;
TECH context/economy array reuse, outstanding-weapon-order counting and borrowed
synchronous custom-command parameters already exist. See the
[engineering contracts](../performance/engineering-guide.md).

## Acceptance criteria for any later implementation

1. A deterministic old-path oracle must agree on ordered candidates, selected
   target/build/task, RNG calls and outgoing commands including options/timeouts.
2. Exercise death, gifting, capture, canceled frames, repeat factory tasks,
   visibility changes, authority loss and save/load. New indexes must agree with
   brute-force scans after mutations, including multiple asks in the same frame.
3. Keep all roles and legacy profiles covered. No change to policy defaults or
   content classification belongs in a pure performance patch.
4. Measure allocations, callback count, phase mean/p95/p99/max and memory as well
   as whole-frame cost. Use serial matched fixed-army tests before natural games.
5. Repeat both 8v8 workloads with matched DLL/data, render settings, game content,
   camera and population windows. Preserve failed checks and unequal population
   caveats. Report measured component gains separately from whole-game FPS.
6. Multiplayer claims require an actual host/peer trace: command packets/bytes,
   backlog, catch-up and checksums. Local UnitCommand APM is only a screening metric.

## Implementation order and verification gates

Implement narrowly, with one old/new measurement per change:

1. **Ranged query and storage primitives (ranks 2/3).** Add brute-force/old-path
   oracle tests before replacing traversal. Test empty/dense cells, enormous
   ranges, boundary/overflow positions, generation wrap, equal scores and
   transfers. Keep scored traversal and arithmetic order identical. Then
   measure fixed 2k/5k/10k-unit workloads and these two natural maps.
2. **Exact ownership/task indexes (rank 4).** Validate every lifecycle event
   against current scans, including simultaneous asks in one frame, repeat
   recruitment, frame cancellation, unit gifts and save/load. Separate ally
   wrapper storage from the unrelated history-pruning duties of its refresh.
   Apply AIR's two exact early exits independently for easy attribution.
3. **SEA reservation mutation (rank 6).** Start with zone-to-slot membership,
   not a wholesale planner rewrite. Compare the complete ordered reservation
   journal and chosen positions. Exercise failed partial patches, occupied
   slots, allied plans, moved blockers and reload. Then optimize local support
   scans and scratch allocation under the same oracle.
4. **Script allocations (rank 7).** Cache only immutable rosters and guard
   disabled formatting. Preserve all three faction/content menus, live limits,
   adoption side effects, role order, selected products and random draws.
5. **Command attribution (rank 5) and engine work (rank 1).** These are high
   impact but higher uncertainty. Record exact queues/reasons and obtain matching
   engine profiles first. Do not implement a generic command suppression rule
   or model-animation shortcut on the strength of aggregate counts alone.
6. **Final acceptance.** No differing policy decisions/commands in the fixed
   observation oracle, no new invariant failures, and lower measured component
   time/allocation without worse p99 response or memory growth. Follow with
   normal-speed matched 8v8 runs and an actual multiplayer peer test before
   claiming network improvement. Natural games alone cannot prove equivalence.

No production JSON changes are required. Proposed AngelScript changes are
internal roster/buffer/formatting and exact guard changes; settings, priorities,
formation spacing, economy thresholds, unit counts and update intervals remain
unchanged. C++ supplies indexes and query mechanisms. Broad background-thread
policy execution is excluded.

## Evidence, limitations and reproducibility

The immutable bundles contain original strict checks/verdicts, manifests,
screenshots, full telemetry JSON and compact interval summaries. Logs/replays
remain in their recorded raw archives. Publication does not copy large replays
into Git or overwrite earlier benchmarks.

| Observation | Evidence | Result and scope |
| --- | --- | --- |
| Metal Plate main | [Bundle](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/performance/full-match-profile/2026-10-06/20261006T172815Z-e43a1112/README.md), [intervals](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/performance/full-match-profile/2026-10-06/20261006T172815Z-e43a1112/full-match-summary-v1.json) | 30:01, all 16 active, manually stopped after severe slowdown; gameplay FAIL. |
| Glacial main | [Bundle](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/performance/full-match-profile/2026-10-06/20261006T180246Z-cda9aa55/README.md), [intervals](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/performance/full-match-profile/2026-10-06/20261006T180246Z-cda9aa55/full-match-summary-v1.json) | 60-minute horizon, all 16 active; gameplay FAIL. |
| Glacial SEA attribution | [Bundle](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/performance/full-match-profile/2026-10-06/20261006T180619Z-a4813114/README.md), [intervals](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/performance/full-match-profile/2026-10-06/20261006T180619Z-a4813114/full-match-summary-v1.json) | 12-minute horizon; additional nested labels, not an old/new speed comparison; FAIL on two TECH invariants. |
| Initial Metal fixture | [Original archive summary](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/performance/full-match-profile/2026-10-06/20261006T163111Z-2132de28/README.md) | Stopped at 7.6 minutes to correct a screenshot/speed-restoration fixture problem. Excluded from the ranking. |

Main log SHA-256 values:

- Metal: `6ad4442804d81c999f8c0bfbde613ddf8fa8fb1700d15c43780a604638ff7c21`
- Glacial: `f120a3c402c8bb0ae5b844e223cef7eccc89bc99af966bd874026baa74bf0af9`

Instruction samples, resolved against the pinned AI symbols:

| Capture | Captures / failures | Capture overhead / duration | Main-thread CPU delta | AI-module locations |
| --- | --- | --- | --- | ---: |
| Metal 20m, all running threads | 2,137 / 0 | 109.06 ms / 30.03 s | 29.86 s | 110 |
| Metal 26m, main thread | 1,921 / 0 | 65.29 ms / 30.01 s | 29.70 s | 72 |
| Glacial 17m, main thread | 1,918 / 0 | 66.19 ms / 30.01 s | 29.39 s | 170 |
| Glacial 35m, main thread | 1,919 / 0 | 66.98 ms / 30.00 s | 29.89 s | 281 |
| Glacial 50m, main thread | 1,921 / 0 | 64.49 ms / 30.01 s | 29.94 s | 381 |

The Metal 26m capture contains 24 ranged-world instruction locations; Glacial
50m contains 43 owned-unit count/proximity helper locations and 14 ally-registry
locations. These are corroborating samples, not percentages of total AI CPU.
Engine-module samples can include callbacks invoked by AI. Matching engine
debug symbols were unavailable, so engine leaf attribution is deliberately open.

Limitations that affect interpretation:

- One seed/host per principal map, with different populations, factions and
  terrain. No previous-version run was made: the data does not establish which
  recent commit caused the cost or any before/after performance gain.
- Intended camera resets were present, but mouse-edge panning/focus can alter
  framing between resets. Rendering and profiler overhead also vary. FPS is
  contextual observation, **not a controlled GPU or fixed-camera comparison**.
  Draw-scope totals divided by simulation frames are not milliseconds per draw.
- Fast-forward FPS is not normal-game FPS. Metal's final interval requested 12x
  but averaged 0.109x. Use the preceding normal-speed minute-20 observation to
  establish that a visible slowdown was already present.
- Glacial profiler-off minutes 31/32 have unavailable AI/engine timing (encoded
  zeros, explicitly marked invalid in summaries). FPS medians were 109/95,
  between on observations of 113 at minute 30 and 82 at 33. Population/combat
  changed, so these are not a numerical profiler-overhead estimate. Metal has
  no accepted profiler-off control at its late load.
- Sampling pauses, diagnostic formatting, disk logging and engine profiling
  perturb timing. They do not change production settings or intentionally issue
  competing-unit orders, but timings can affect asynchronous/network scheduling.
- All games stopped before victory. No win-rate, complete-match duration,
  LAN/internet synchronization improvement or behavior-equivalence claim follows.

Reproduce serially from this workspace using the pinned DLL:

```powershell
python tools/playtest/run_full_match_performance.py --map metal-plate --dll build-theatres/d216-final/SkirmishAI.dll --minutes 30
python tools/playtest/run_full_match_performance.py --map glacial --dll build-theatres/d216-final/SkirmishAI.dll --minutes 60
python tools/playtest/run_full_match_performance.py --map glacial --dll build-theatres/d216-final/SkirmishAI.dll --minutes 12 --detail-sea
```

These commands stage the current source data; reproduce the recorded workload
with the archived manifests and matching staged bytes, not merely the same DLL.
Record the actual end reason. A horizon is not a GameOver assertion. Analyze
only after exit with `analyze_full_match_performance.py <write-dir>` followed by
`summarize_full_match_performance.py <write-dir>`; `--live` prints ephemeral
observations only. Publish after adding analyses to the original archive.

Verification of this investigation's tooling: three telemetry/parser tests pass;
Python compilation, script API parity (310 used members), invariant-practice
checks and scoped whitespace checks pass. The live VM loaded successfully in
both principal games and the SEA attribution run. Documentation validation
retains eight pre-existing missing hover-reference links (KI-404). No native
behavior code was changed, so no native performance improvement is claimed.

The unresolved work is recorded in KI-527 through KI-531. Existing optimization
history and behavior limits remain in the decision and known-issue registers.
