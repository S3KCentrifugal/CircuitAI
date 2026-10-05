# SkirmishAI performance review: Shore to Shore 8v8

Date: 2026-10-04. Decision: D-195. **Recommendations only; no gameplay optimization implemented.**

Implementation follow-up: [D-197](../layout-reservation-performance.md) implements
recommendation 1 with exact paged occupancy, making fixed-footprint allied
reservation checks independent of claim count. The original proposal below is
retained as the review record; D-197 documents its stronger representation,
benchmarks, mutation/memory tradeoffs and gameplay verification. Other rankings
remain proposals.

Current order: [D-198's reranking](2026-10-04-skirmishai-performance-rerank.md)
uses the latest per-team timers and failed-placement counts. TECH accounts for
87.41% of the final minute's AI callback time; AIR accounts for 2.30%. Repeated
failed TECH decisions and script/allocation work now lead the investigation.
The D-195 ordering below remains a historical record.

Follow-up: the reported Juno shots beyond Shore's map edge are investigated in the [D-196 evidence report](2026-10-04-juno-map-edge-investigation.md). The report distinguishes logged aims, projectile motion and actual explosion centers; the observation remains unconfirmed (KI-499). It does not change the performance ranking or production behavior.

The leading identifiable AI hotspot in the slowed discovery run is **construction-layout reservation checking**, particularly repeated tree lookups inside the existing allied spatial index. Optimizing AIR combat alone would miss it. Early FPS loss was mostly outside AI callbacks; later, AI callbacks became a substantial main-thread cost. The control did not independently reproduce that severe tail; this ranking targets observed waste, not a universal bottleneck or a promised FPS gain.

The first forty-minute run fell from 203 to 39 median FPS in nominal 1x measurement windows. Aggregate AI time rose from 1.57 to 17.46 ms per simulation frame; late p95/p99 reached 88.69/113.00 ms. This run had engine profiling enabled and the harness's known extra spectator commander. It is discovery evidence, **not an uncontaminated stock-FPS measurement or a gameplay PASS**. The clean profiler-off control is documented below separately.

## What was measured

- Map: `Shore_to_Shore_V3`, installed `shore_to_shore_v3.sd7`.
- Sixteen current-build AIs: each side has one AIR, one TECH, one TACTICAL and five SEA. The repository map supplies six starts per side; the benchmark expands only the fixture to eight, retaining three land starts and distributing five naval starts along each coast. This is intentionally a naval-heavy 8v8. FRONT and SUPPORT receive source review, not role-specific runtime certification from this map.
- Seed `1954001`; mixed Armada, Cortex and Legion; `experimental_hard`; ordinary economy, no supplied resources or combat units. Other inherited modoptions and the complete start scripts are retained with each run.
- BAR `Beyond All Reason test-31479-433a460`; installed Recoil `2026.07.04`; Windows; i9-12900KF, 16 cores / 24 logical processors; RTX 3080 Ti, 12 GB.
- Window 1280x720, playtest lean rendering, AIR-side base-follow camera at height 2200. Discovery requests `(776,1936)` through minute 30 and `(1416,2376)` at minute 40; the control requests `(680,2016)` early and `(550,1740)` at minute 30. Camera/scene changes confound drawing-FPS comparisons. Normal-speed windows occur among 4x fast-forward sections; never compare accelerated FPS directly with 1x FPS. Screenshots briefly slow the game for rendering: minute windows containing them are approximately 60.7 seconds, and the screenshot HUD itself is not the FPS benchmark.
- One simulation at a time. The user's existing BAR lobby was left untouched. GPU activity from other applications was not isolated, so FPS is supplementary to callback timing and instruction samples.
- DLL SHA256 `d28b4dcb6a319109509202639ac142a919bbae93669a466b5ecab4cc1cc4d450`, 7,816,377 bytes; matching debug file SHA256 `66eaba767af7c1f7af44adb48b471c6563c9cc755aabf0fd711af91a56fc45a4`. The source checkout is dirty over `3d8c66d208d7c407e6d22d7d5178049dbbe7ab39`; that commit alone does not reproduce this build. Retained data hashes, DLL identity and fixtures are authoritative.
- Current native compilation is already `-O3 -DNDEBUG`, C++20. This is not an accidental unoptimized/debug build. Tracy is disabled in the pinned build; its existing scopes therefore cannot supply timings without a separate diagnostic build.

### Measurement limits

The Lua observer reads Recoil's cumulative `AI` elapsed-time scope every simulation frame and reports distributions of differences. It covers all locally hosted AI callbacks, including native and script work and synchronous engine queries; it does not identify a particular role and does not include asynchronous worker duration. Engine scopes overlap: **do not add AI, Sim, Lua and Draw as disjoint CPU percentages**. Values are elapsed time, not CPU cycles; scheduling and instrumentation can affect them.

`debug 1 0` enables ordinary engine profiling without its overlay. The profiler uses a shared mutex in `CTimeProfiler::AddTime`; its own `Misc::Profiler::AddTime` record is substantial. That record aggregates overlapping/threaded work and is not a main-thread CPU percentage. The control therefore alternates profiling within one continuing match, and supplies ordinary profiler-off FPS windows.

Windows WPR refused CPU sampling with `0xc5585011` (performance-profiling policy unavailable). The fallback samples only the benchmark process's instruction pointers, briefly suspending/resuming selected threads. These are **randomized wall-clock instruction samples, not ETW CPU samples or stack traces**. Matching DWARF symbols resolve inline chains, but not the full runtime caller stack or AngelScript function. They localize hotspots; they do not prove an exact percentage speedup.

The sixty-second late sample made 34,659 captures across the main thread and eight AI workers with zero failures. Total capture-section time was 776.6 ms summed across threads, including handle work; it is an overhead indicator, not a measured FPS correction. Unresolved addresses remain unresolved rather than being assigned to an attractive hypothesis. Samples are conditional on the sampled module and thread.

## Runtime findings

### Discovery run, profiling enabled

| End of game minute | Units, all teams | Median FPS | AI mean ms/frame | AI p95 | AI p99 | AI maximum |
| ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| 4 | 267 | 203 | 1.57 | 3.82 | 7.04 | 10.04 |
| 10 | 489 | 176 | 2.07 | 4.63 | 7.23 | 49.65 |
| 20 | 617 | 153 | 1.92 | 4.92 | 7.41 | 17.42 |
| 30 | 1,092 | 171 | 2.72 | 6.48 | 10.46 | 21.95 |
| 35 | 1,540 | 117 | 8.56 | 34.77 | 95.38 | 343.67 |
| 40 | 1,822 | 39 | 17.46 | 88.69 | 113.00 | 176.94 |

The recovery at minute 30 matters: FPS does not fall monotonically with total unit count. At minute 38 the requested 4x run achieved about 1.24x over the minute; at minute 40 the normal-speed window still achieved approximately 0.99x, despite visible drawing stalls. Low drawing FPS and falling simulation throughput must be reported separately.

Within the late window, 1,304 of 3,851 main-thread instruction samples landed in `SkirmishAI.dll`. Resolved AI source attribution included:

| Area | Samples | Fraction of those 1,304 AI samples | Interpretation |
| --- | ---: | ---: | --- |
| `terrain/AlliedReservations.h` | 255 | 19.6% | Largest clearly identified AI source-file hotspot |
| `terrain/TerrainManager.cpp` | 156 | 12.0% | Local placement, slot and reservation geometry |
| `terrain/BaseLayoutGeometry.h` | 20 | 1.5% | Footprint geometry |
| `module/BuilderManager.cpp` | 44 | 3.4% | Includes unfinished/nearby structure queries |
| Unresolved leaf addresses | 225 | 17.3% | Not attributed to a subsystem |

These source categories are distinct in the analyzer; inline helper counts and parent-function counts must not be added again. The allied-index tuple/tree lookup chain accounted for 208 samples by itself. AngelScript execution/dispatch and reference-management helpers also appear prominently, but the samples cannot name which script routine generated each cost.

The main thread used 59.56 CPU seconds in the sixty-second late window. **All eight AI workers combined used 4.20 CPU seconds**, about 0.07 fully occupied cores. This is not worker-pool saturation. In earlier samples, worker execution was mainly MicroPather heap operations and cost-map/path search; moving more work to workers may be useful eventually, but increasing the worker count is not the first remedy.

The run emitted **296,651 `RESERVE:` log lines** by the final snapshot. Source tracing finds unconditional success/zone/release logs inside speculative layout work, including patches that are subsequently discarded. This is objectively excessive diagnostic output; its isolated CPU cost has not been timed. It also feeds engine/Lua console processing, so some AI-generated cost appears outside the `AI` scope.

### Corrected-roster control and its limits

The corrected fixture removes only the harness spectator team's commander after host loading, restores cheats off, and verifies `spectator_units=0 competing_ai_teams=16`. It leaves all participating units and AI data unchanged. Two failed cleanup guards and an earlier short control with a command-observer hook conflict are retained as failed raw evidence and excluded from the clean comparison.

The control reached frame 72,000, but **the awards overlay is visible by its 29.8-minute screenshot**. The original observer did not record GameOver/TeamDied. The exact end/defeat event is therefore unverified, and the late windows are excluded from competitive 8v8 FPS comparisons. A large unit loss between minutes 25 and 26 also changed the workload. This is a corrected-roster control, not a certified forty-minute match with all sixteen AIs still competing.

| End minute | Units | Median FPS | Profiling | Interpretation |
| ---: | ---: | ---: | --- | --- |
| 4 | 268 | 284 | Off | Early control |
| 10 | 499 | 235 | Off | Control |
| 15 | 621 | 236 | Off | Control |
| 19 | 690 | 221 | On | AI mean 2.29 ms; p99 9.05 ms |
| 20 | 735 | 201 | Off | Screenshot still awards-free |
| 21 | 749 | 202 | On | AI mean 2.54 ms; p99 9.45 ms |
| 22 | 714 | 224 | Off | No isolated profiler-overhead estimate |
| 25 | 708 | 234 | Off | Before the large observed unit-count loss |
| 30 | 747 | 263 | Off | Awards overlay; exclude from competitive comparison |
| 35 | 1,172 | 232 | Off | Late workload only |
| 40 | 1,666 | 182 | Off | Late workload only |

It starts with profiling disabled, enables it for minutes 18–19 and 20–21, and keeps 18–22 at 1x. The on/off sequence does not isolate profiling overhead from evolving combat, rendering or scene changes. Different runs can diverge despite a fixed seed because of asynchronous work and fixture differences; cross-run FPS ratios are not causal speedup claims.

Profiler-off main-thread samples contained 122/3,206 AI-module locations in a middle window and 217/3,205 in the later window. The allied-index attribution was only 3 and 2 samples, respectively. These samples **do not replicate** the discovery hotspot; the later sample also has the awards/workload caveat. A final requested 40-second sample was cut short when the watcher stopped the game: only 808 valid locations over 12.61 seconds remain, 70 in the AI module. Exited-thread failures are retained, not counted as CPU samples. The sampler now exits when the process does.

The control still emitted **309,020 reservation log lines**. Its original check verdict is **FAIL** from 25 TECH invariant reports (INV-001/008/009/013/014/019/022/029/039); script and instrumentation checks were clean. Neither run certifies gameplay correctness. The later observer revision logs GameOver and TeamDied and the reusable checks forbid premature GameOver; those lifecycle additions were parser-checked, not replayed in-engine during this review.

### Command volume and network implications

The discovery run's largest recorded team-minute was TECH team 1: **8,655 command events at minute 39**. Unit attribution: 5,139 for `armfast`, 1,516 for `armmar`, 1,055 for `armaca`; 6,775 events were MOVE commands. AIR teams 0 and 9 recorded 583 and 1,834 total events that minute. All teams together reached **21,962 events/minute** at minute 40.

The control's largest team-minute through minute 25 was TACTICAL team 10, **4,582 events**, with zero air-unit events in that bin. Its complete elapsed-frame log contains 271,745 `nonlua` and 3,247 `lua` events. After the awards overlay it reaches 10,311 events for TACTICAL at minute 40, predominantly `armanac` (7,543) and `armsh` (1,411); this is useful diagnostic traffic, not a competitive late-game APM benchmark. Ground/hover command ownership deserves attention alongside AIR.

These are synchronized `UnitCommand` observations, not transmitted packet counts. They include game-generated commands, factory/constructor work and Lua actions. The clean observer also records `fromLua`; even `nonlua` is not identical to AI network-origin traffic. The aircraft repeated-signature counter ignores some options and intervening completion, so a repeated signature is **not proof that an order can safely be removed**. No remote-peer/WAN test was performed, and 3,000 APM is not an engine-defined universal failure threshold.

Source trace: `CAICallback::GiveOrder` sends one `SendAICommand` per unit command; the server validates/relays it and each peer applies it. Queries are local wrapper calls, not network messages. A native `CRouteTask` controlling a group still loops through members to issue orders. Recoil's `NETMSG_AICOMMANDS` multi-unit path explicitly services LuaUnsyncedCtrl; the current SkirmishAI callback interface does not expose that path. Merely calling a task a control group does not make its commands one network packet.

## Ranked recommendations

Rank reflects observed relevance, confidence and the ability to preserve existing decisions. No overall FPS percentage is promised. Implement one item at a time and compare exact query/command results before accepting it.

| Rank | Proposal | Evidence | Expected benefit | Behavior risk |
| ---: | --- | --- | --- | --- |
| **1** | Remove repeated tree lookup from the **existing allied reservation index** | 255 late AI samples; 208 in tuple/tree lookup chain | Direct reduction in measured hottest layout query | Low with exact lifecycle tests |
| **2** | Index local zones/slots and cache immutable footprint geometry | 156 terrain + 20 geometry samples; per-candidate linear scans | Reduce placement work as bases accumulate reservations | Low–medium; ownership and invalidation are critical |
| **3** | Gate speculative reservation diagnostics before formatting | 296,651 discovery / 309,020 control reservation lines | Eliminate unwanted string, wrapper, sink and console work | Very low for gameplay; diagnostic output changes |
| **4** | Query unfinished structures through a validated ID index | 44 BuilderManager samples; repeated all-unit queries from TECH rules/invariants | Reduce `Q × all owned units` work to relevant candidates | Low–medium; preserve D-108 stale-pointer fix |
| **5** | Remove temporary allocation and repeated reads within a single script decision | VM/dispatch/refcount samples; repeated arrays/dictionaries in source | Lower script and GC overhead without slowing decisions | Medium; same-frame reentrancy and admissions must stay fresh |
| **6** | Reuse exact failed-placement/query results within valid revisions | Repeated reserve/discard logs and layout retry structure | Avoid repeated speculative work without changing candidate sequence | Medium; only exact, correctly invalidated reuse qualifies |
| **7** | Reduce redundant movement computation; investigate true batch transport separately | TECH MOVE event volume; per-unit native send path | Potential local CPU and network reduction | Medium–high; queue equality alone is insufficient |
| **8** | Share identical path/cost-map work and reduce remaining lane postprocessing | Worker samples; existing lane timers | Reduce background waste and intermittent publication cost | Medium–high; identical snapshots and commit timing required |
| **9** | Exact spatial/route reuse for bomber, radar and naval target evaluation | Nested loops verified in current source, not dominant in this sample | Bounds future large-fleet scaling | Medium; target and AA semantics must remain identical |

### 1. Allied reservations: remove the second lookup

[`AlliedReservations.h`](../../src/circuit/terrain/AlliedReservations.h) already partitions rectangles into 32-cell buckets. `OverlapsOther` walks each bucket's `set<Key>` and then calls `entries.at(key)` for each other owner's entry. Tuple comparisons and red-black-tree traversal are therefore repeated inside the spatial query. A rectangle spanning several touched buckets can also be tested repeatedly.

Retain the same half-open rectangles, owner exclusions and spatial buckets. Store a stable entry reference or handle alongside each bucket membership so overlap testing does not search the second map. A query-local duplicate stamp can avoid repeated rectangle tests across buckets. Keep `Put`, `Erase`, `RemoveOwner`, restore and release behavior exact; erase memberships before their referenced entry dies. Do not retain invalid references across owner removal or replacement.

With B buckets visited, K memberships and R entries, the current lookup component is approximately `O(B log bucket_count + K log R)`, plus bucket iteration. Direct entry access removes the `log R` factor; duplicate elimination reduces K to distinct entries tested. This is an algorithmic saving, not a measured FPS prediction.

Verify old/new boolean results against a brute-force oracle for random rectangles, boundary-touching cells, negative/off-map input, large multi-bucket zones, own/foreign owners, repeated Put, Erase and RemoveOwner. Replay recorded query arguments in their original mutation order. Test AIR/TECH/SEA sharing, factory exits, reclaimed slots, role changes and save/load; preserve every placement and owner decision.

### 2. Local reservations and footprint queries

[`TerrainManager::IsSlotFree`](../../src/circuit/terrain/TerrainManager.cpp) scans all local zones for an unscoped site and all unconsumed reservations for a zoned site. `PackCandidates` calls it for many cells; `LeavesPocket` calls it for each cell in its bounded flood-fill window. `ReservationCells` repeatedly reads UnitDef dimensions and reconstructs footprint rectangles. `FactoryExitLanes` is rebuilt for some placement paths.

Use an exact local rectangle index and precomputed UnitDef/facing footprints. Share an immutable exit-lane snapshot within one placement transaction. Keep candidate iteration, ranking, ties, builder reach, water/slope tests, zone exceptions and first-factory exceptions identical. Do not replace exact geometry with a coarse occupancy approximation or share mutable per-role policy.

Measure candidate count, memberships examined, geometry calls, engine buildability calls and elapsed p99 per layout operation at fixed saved inputs. Require identical ordered candidates, pins, first accepted site and failed result. Check invalidation on frame creation, destruction, reclaim, transfer, blocking-map and terrain change. A cache keyed only by game frame is not enough when multiple AIs mutate reservations within that frame.

### 3. Diagnostic output

[`CircuitAI.h`](../../src/circuit/CircuitAI.h) formats every `LOG` argument before calling the engine. [`TerrainManager.cpp`](../../src/circuit/terrain/TerrainManager.cpp) emits successful slot creation, zone creation and release messages unconditionally. The script's ordinary log level does not suppress those native calls.

Add a script/JSON-controlled layout diagnostic level and check it **before formatting**. Preserve invariant, exception and explicit diagnostic-mode output. Normal mode should log meaningful cluster commits/failures, not every transient candidate mutation. This is independent of placement logic and is the safest small first change if minimum risk matters more than measured hotspot rank. Do not turn off the entire AI log sink or alter error behavior.

Validate identical command and reservation traces with diagnostic output captured through a separate test channel; benchmark elapsed AI and Lua console work with and without detailed logs. Existing test expectations relying on `RESERVE:` require explicit diagnostic mode. Savings outside the AI scope must be reported separately.

### 4. Unfinished-structure lookups

[`BuilderManager::FindUnfinishedNear`](../../src/circuit/module/BuilderManager.cpp) deliberately iterates currently owned units and checks membership in `unfinishedUnits`; D-108 replaced unsafe stale-pointer iteration. TECH rules, planner and invariants call it repeatedly. Other `FindProducedNear`/count queries also traverse ownership.

Maintain a validated set/index of unfinished **IDs**, reacquiring the unit from the owner table before use. Update on lifecycle transitions and keep the existing nearest-distance comparison and unit-ID tie order. A small per-decision view may be sufficient before adding a persistent spatial index. Never restore raw traversal of the stale-pointer map to gain speed.

Compare returned IDs and counts across births, completion, destruction, capture/gift, overlapping repairs, definition filters and equal distances. Include the historical freed-unit reproduction and checks for factory products versus building frames. Record actual reduction in visited units rather than claiming every scan is avoidable.

### 5. AngelScript allocation and repeated observations

The current AIR workforce and SEA economy already take useful censuses; the previous review's blanket `O(projects × all units)` description no longer applies everywhere. Inspect the remaining repeated `getKeys`, `GetOwnedUnitIds`, UnitDef-name arrays, temporary dictionaries and per-builder proximity queries in [`air_workforce.as`](../../data/script/src/manager/air_workforce.as), [`sea_economy.as`](../../data/script/src/manager/sea_economy.as), [`air_build.as`](../../data/script/src/roles/air_build.as) and [`tech_rules.as`](../../data/script/src/roles/tech_rules.as).

Reuse scratch storage or a compact view for one complete decision, while retaining iteration order. Use immutable definition/faction lookup tables for unchanged roster data. Do not cache live borrowed unit handles, reuse stale funding/admission totals, disable garbage collection, or simply reduce callback frequency. Explicit script-subphase timers in a separate diagnostic build should identify the next script hotspot before broad rewriting: instruction sampling cannot attribute VM time to a specific AngelScript function.

Verify exact selected rule, task, recruit, funds reserved and target IDs for the same input snapshots, including reentrant task removal and same-frame donations/admissions. Compare allocations, GC steps, p95/p99 and memory at stable live populations.

### 6. Failed placement and speculative transactions

[`SeaLayout::PlanPatch`](../../data/script/src/manager/sea_layout.as) already limits attempts and has a per-key one-second retry. It still reserves successive slots while trying a patch, then discards the partial set if a later slot fails. Similar placement paths repeatedly examine unchanged geometry.

First hoist immutable geometry and lookup results within each transaction. Consider an exact negative-result cache only when keyed by candidate, definition, facing, own/allied reservation revision, terrain/blocking revision and every engine-dependent input used by the query. Preserve the existing cursor and retry schedule. Bulk validation/commit must reproduce intra-patch blocking and the same failure point. Reservation ID consumption and named-state references also require comparison; skipping allocation can otherwise change subsequent tie behavior or save data.

Do not add longer retry delays or coarser searches under the label of optimization. Those change when/where the AI builds. This recommendation extends KI-464; it is not permission to weaken allied base exclusion.

### 7. Commands: investigate the observed source, preserve response

Trace high-volume TECH assault MOVE orders through [`Spam::RefreshRoutes`](../../data/script/src/manager/spam.as), [`AmphibiousOps`](../../data/script/src/manager/amphibious_ops.as), native route/formation and [`MoveAction`](../../src/circuit/unit/action/MoveAction.cpp). These are source candidates, not a measured caller attribution from the aggregate event log. Distinguish changed destinations, path repair, game-generated commands and exact redundant work. The discovery's highest APM came from land assault units, although AIR also owns constructors and transports that issue commands.

Current [`air_screen.as`](../../data/script/src/manager/air_screen.as) uses group tasks, chooses a final patrol/intercept mission and [`RouteTask.cpp`](../../src/circuit/task/fighter/RouteTask.cpp) checks route/version equality for opt-in AIR control. Do not recommend those already implemented measures as new savings. Empty transient-route cleanup also needs current source verification rather than repeating KI-463 verbatim.

For strict behavior preservation, optimize construction of an unchanged command before considering its removal. Removing or delaying a repeated MOVE can alter path recovery; repeated attack/repair orders can affect engine queues and callback timing. Any suppression experiment must compare complete queues, options, tags, timeouts, mission ownership, queue completion and movement/firing outcomes. No APM cap, reduced threat-check cadence, changed formations or changed bomber policy is proposed.

True network batching needs an engine/interface design, not just an AngelScript array. Preserve per-unit parameters, order within a simulation frame, AI attribution, permissions and server flood accounting. Validate with host plus remote peers and capture actual packets/bytes, queue delay and synchronization. This is a separately selectable higher-risk project, not part of the low-risk first pass.

### 8. Workers and lane postprocessing

[`Scheduler.cpp`](../../src/circuit/scheduler/Scheduler.cpp) owns a **shared process-wide pool**, capped at eight workers, not eight threads per AI. Path/cost-map work, threat/influence preparation and lane solving already use asynchronous jobs. [`BattleLanes.cpp`](../../src/circuit/terrain/BattleLanes.cpp) uses owned immutable snapshots and main-thread publication. Existing discovery `LANE_POST` measurements peak at 22.156 ms on Shore; earlier Supreme measurements in KI-433 were larger.

The worker sample's leading functions are MicroPather heap operations and full cost-map searches. [`BuilderManager`](../../src/circuit/module/BuilderManager.cpp) starts the next cost map when the previous one is ready; [`RetreatTask`](../../src/circuit/task/RetreatTask.cpp) also uses cost maps to find repairers. Exact reuse requires identical source cell, movement type, power/threat limit and immutable map revisions. Do not reuse a map merely because destinations look close or reverse a threat-weighted search without proving equivalence.

For lanes, separate `Finish` consumer timings before offloading more. Cache immutable topology-derived advisories and move only pure computations on owned snapshots. Preserve the current publication frame and stale-result rejection if behavior must be identical. Returning a result one tick later is a behavior change even when the numerical path is the same. A per-frame job budget or spreading callbacks across ticks likewise changes timing and is not recommended under this request.

### 9. Combat query scaling

[`AirWaveTask::SelectStrikeTarget`](../../src/circuit/task/fighter/AirWaveTask.cpp) computes routes per eligible target and rescans hostile AA/local peaceful economy for some scores: roughly `O(targets × (route samples + hostiles + nearby-economy scan))`. An exact spatial index and per-snapshot route-result reuse can reduce this without changing score order or safety padding.

[`AirRecon::Patrols`](../../data/script/src/manager/air_recon.as) uses a bounded candidate grid (default 14×14, maximum 20×20), retaining safe assignments and replanning only invalid ones. Selection can scan the candidate list repeatedly after unsafe travel rejection. Sorting a plane's unchanged candidate scores once with the original tie order can replace that repeated maximum search; preserve rejection and assignment order. [`AirSafety.h`](../../src/circuit/terrain/AirSafety.h) already scans a corridor-sized capsule rather than its entire diagonal bounding box. Reintroducing the older bounding-box critique would be inaccurate.

[`air_naval_support.as`](../../data/script/src/manager/air_naval_support.as) already uses periodic fleet snapshots/spatial buckets and bounded ingress candidates. [`BattleAnalysis::AirThreatAlong`](../../src/circuit/terrain/BattleAnalysis.cpp) still tests cached physical AA envelopes after low grid-threat results; exact spatial filtering could help larger enemy counts. These are source-supported opportunities, **not measured leading causes in this run**. Test hidden contacts, zero-weight AA definitions, map edges, bomber commitment, radar overlap and torpedo approaches before accepting any replacement.

## Whole-AI review coverage and deliberate non-changes

| Subsystem | Current mechanism / conclusion |
| --- | --- |
| Engine dispatch and events | Hosted AIs execute serially in `EngineOutHandler`; callbacks include idle/damage/lifecycle events as well as frame updates. Moving the whole AI or script engine to a worker is unsafe without engine/API redesign. |
| Scheduler/tasks/actions | Due jobs and completed-worker callbacks drain on main. Task updates distribute counts over about 30 frames, not elapsed time. One heavy callback can still stall. No artificial work budget proposed. |
| Shared ally data | Friendly wrappers are deleted/recreated on refresh; main-thread samples include this allocation/lifecycle path. A stable ID-based wrapper cache is a later measured candidate, with resignation/definition-lifetime tests. |
| Map/threat/influence/lanes | Already use shared data and worker machinery. `BattleAnalysis` still has per-AI observations and raster work; do not merge visibility or role-dependent state across enemies/teams. |
| Layout/economy/builders | Strongest measured late-game hotspot. Prioritize exact index/data-representation changes, not altered build priorities or spacing. |
| Factory/nano response | Enemy reclaim and idle recovery deliberately preserve urgent actions. Use existing radius queries/caches; do not throttle the response to reduce counts. |
| AIR | Grouped screens, command-version guards, workforce census and efficient corridor rasterization already present. Review remaining target/patrol/query work as above. |
| SEA | Census and response tick are already bounded. Dense patches and many neighboring planned bases stress shared placement. Preserve forward-yard and protected economy rules. |
| TECH | Highest command-volume team in discovery; repeated unfinished queries and layout/invariant work also remain. Preserve exact reclaim/rebuild/build order rules. |
| TACTICAL | Main periodic hook is empty; shared framework/native tasks still consume time. Empty role hook does not mean zero CPU. |
| FRONT/SUPPORT | Source reviewed: periodic quota/economy hooks plus shared/native managers. Not directly represented as roles in this naval-heavy benchmark. |
| Strategic weapons/retreat/resources | Existing target scans, repair searches and energy/metal graph updates inspected. No evidence they dominate this sample. Retain nuke/Juno priorities, repair behavior and resource timing. |
| Serialization/startup | Outside the steady-state window. Preserve reservation IDs, ownership and restored caches in any index redesign. |
| Compiler/VM | Optimized native build; bytecode optimization enabled. No fast-math, speculative SIMD precision change, JIT enablement, GC disablement or vendored-library rewrite proposed. |

AngelScript supports multithreaded use under its documented constraints, but that does not make this AI's globals, contexts, bound C++ objects or engine callbacks thread-safe. Native workers should compute pure results over owned snapshots; all engine effects, task ownership and script execution stay on main. Sharing an immutable result is useful; sharing mutable script state across sixteen role instances is not an equivalent optimization.

## Acceptance plan before any optimization is accepted

1. Freeze the same DLL/data, fixture, settings and hardware conditions; preserve old benchmark bundles. Compare serial runs, not concurrent games.
   Record GameOver, TeamDied, active AI counts and fixed camera coordinates. Stop competitive comparisons at the first disqualifying lifecycle/fixture event. Reproduce the stressed reservation state with recorded queries or a clearly labeled placement stress fixture before treating a natural control as a speedup comparison.
2. For ranks 1–2 and 4, record arguments/results and mutation sequences; require exact old/new query results, stable ties and placement/task selections. Add randomized geometry/lifecycle tests and replay the D-108 stale-pointer scenario.
3. For rank 3, prove that only diagnostics change. For script reuse, compare same-decision resource snapshots/admissions and selected rule/target IDs.
4. Use the corrected 8v8 Shore fixture, then Supreme and Glacial for ordinary-map regression, plus dense AIR/TECH/SEA base and late-combat fixtures. Require the same economic/production/target rules, no missed urgent threat response and no new invariant failures. Existing baseline invariant failures are tracked, not relabeled PASS.
5. Compare main-thread callback mean/p95/p99/max at comparable state/population, worker CPU/queue delay, memory/allocation, command types and origins, and both 1x FPS and achieved simulation speed. A win rate or higher FPS alone does not establish unchanged behavior.
6. For command changes, add packet-level host/peer tests; for worker changes, add cancellation, owner destruction, save/load, stale snapshot, queue saturation and deterministic publication tests. Identical seed alone is not enough: asynchronous completion can diverge natural games.

Recommended first selection: **ranks 1–4**, each independently reviewable. They target measured waste while preserving decision cadence, priorities, formations, target choice and command semantics. Ranks 5–9 need more focused attribution or stronger behavior-equivalence tests before broad implementation.

## Evidence and references

- [Discovery benchmark bundle](../benchmarks/records/shared/performance/shore-8v8-d195/2026-10-04/20261004T215058Z-7fcb4c2a/README.md): original FAIL verdict, input hashes, measurements, symbol summary and screenshots. `skirmish-performance.json` is the original interim analysis captured by the watcher; `skirmish-performance-final.json` is the separately named final analysis. Both are preserved.
- [Corrected-roster control bundle](../benchmarks/records/shared/performance/shore-clean-control/2026-10-04/20261004T222147Z-3387c795/README.md): original FAIL verdict, profiler-off/on windows, command origins, sample summaries and the final awards screenshot. [Review notes](../benchmarks/records/shared/performance/shore-clean-control/2026-10-04/20261004T222147Z-3387c795/review-notes.json) explicitly exclude the late windows from competitive comparison. Raw instruction files and their hashes remain in the recorded archive's `instruction-samples` directory.
- [Earlier AIR source review](2026-10-02-air-performance-review.md), [AIR workforce measurements](../air-workforce-results.md), [known issues](../known-issues.md): prior hypotheses and tests are not substituted for current evidence.
- Diagnostic tools: [scope/FPS observer](../../tools/playtest/widgets/skirmish_perf_watch.lua), [command observer](../../tools/playtest/widgets/air_command_watch.lua), [instruction sampler](../../tools/playtest/sample_process_instruction.ps1), [analyzer](../../tools/playtest/analyze_skirmish_performance.py), [clean-roster fixture](../../tools/playtest/widgets/perf_spectator_cleanup.lua).
- Engine source reference `92efda5e60fb6df54a8f17a87e4f4cdb4aa2de31`: [AI dispatcher](https://github.com/beyond-all-reason/RecoilEngine/blob/92efda5e60fb6df54a8f17a87e4f4cdb4aa2de31/rts/ExternalAI/EngineOutHandler.cpp), [callback order submission](https://github.com/beyond-all-reason/RecoilEngine/blob/92efda5e60fb6df54a8f17a87e4f4cdb4aa2de31/rts/ExternalAI/AICallback.cpp), [multi-unit transport](https://github.com/beyond-all-reason/RecoilEngine/blob/92efda5e60fb6df54a8f17a87e4f4cdb4aa2de31/rts/Game/SelectedUnitsHandler.cpp), [profiler implementation](https://github.com/beyond-all-reason/RecoilEngine/blob/92efda5e60fb6df54a8f17a87e4f4cdb4aa2de31/rts/System/TimeProfiler.cpp). This local source reference is distinct from the installed engine release identifier.
- [AngelScript multithreading contract](https://www.angelcode.com/angelscript/sdk/docs/manual/doc_adv_multithread.html) and [Microsoft CPU analysis guidance](https://learn.microsoft.com/en-us/windows-hardware/test/wpt/cpu-analysis) support the distinction between application threading, sampled CPU profiling and the fallback used here.
