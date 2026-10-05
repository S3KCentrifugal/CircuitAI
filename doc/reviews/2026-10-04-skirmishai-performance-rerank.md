# Performance ranking after the reservation optimization

Date: 2026-10-04. Decision: D-198. This reanalyzes D-197's retained forty-minute
Shore 8v8. No new simulation or production changes. The [original ranking](2026-10-04-skirmishai-performance-review.md)
and [reservation optimization](../layout-reservation-performance.md) remain intact.
Derived counts, original input hashes and exact log excerpts are retained in
[the analysis data](2026-10-04-skirmishai-performance-rerank.json).

## What caused the latest slowdown?

**The immediate measured cause was long, synchronous TECH callbacks, overwhelmingly
team 1 in the final minute.** The timers identify the responsible AI. They do
not yet identify the exact expensive script function or divide its time between
script execution, garbage collection, native placement and synchronous engine calls.

| Final minute, frames 70,200–72,000 | Measured elapsed time |
| --- | ---: |
| Aggregate AI callbacks | 43.121 s |
| TECH team 1 | 36.600 s: **84.88%** of aggregate AI time |
| TECH team 8 | 1.091 s |
| Both TECH AIs | **87.41%** of aggregate AI time |
| Both AIR AIs, teams 0 and 9 | 0.991 s: **2.30%** |
| Highest remaining individual AI, SEA team 3 | 1.503 s |

The sum of individual AI scopes is 43.103 s, close to the aggregate scope with
its surrounding overhead. These are elapsed callback times, not CPU-cycle
percentages. They should not be added again to the parent AI scope.

Median aggregate AI time was only **2.47 ms/frame**, but p95 reached **194.59 ms**,
p99 **225.25 ms**, and the mean **23.96 ms**. This is a hitching workload, not
uniformly slow frames. The normal-speed window fell to 8 median FPS. TECH
dominance develops after minute 30: team 8 leads at minute 37, before team 1
dominates the final minute. It is not exclusively one broken faction's CPU path.

The strongest late-window workload clue is unsuccessful economy placement:

- The exact log signature `armmmkr`, zone 7, 29 candidates and 29 tried occurs
  **647 times in the final minute**, versus 47, 83 and 30 in the preceding three
  minutes. That means at least 18,763 recorded candidate attempts for that
  signature, in addition to candidate generation and other unlogged preflight work.
- `corestor` and `cormstor` each fail 55 times with eight candidates. Across
  failed-pack messages, **558 are additional same-definition failures within an
  already represented frame**. This is a count of repeated work signatures,
  not proof of identical anchors, reservations or engine buildability inputs.
- Same-frame gaps of roughly 130–140 ms occur between repeated converter
  failure messages. A TECH team 1 role message also reports no room for that
  converter for 114 seconds. Native reservation messages themselves lack team
  IDs, so do not attribute every untagged line to team 1 solely from its unit name.
- A log gap includes all intervening unlogged work. It is **not** a measured
  `PackNearGroup` duration. The source has 20 ms `SSlowCall` diagnostics for some
  layout functions, but this log has no `SLOW:` entries; that is another reason
  not to assign the entire gap to one native call.

The earlier 30-second instruction sample adds supporting, not final-minute,
evidence: **216 of 304 AI locations** resolve to AngelScript source; **41 of
those 304** explicitly name collection/reference enumeration in their inline
chains. Native source accounts for 70 and unresolved locations for 18. Only
one inline chain contains the optimized allied reservation check. These groups
must not be summed with overlapping inline-function counts. The sample has no
script-level stack or AI-instance attribution.

The defensible explanation is **repeated TECH decision work when economy
placement cannot succeed, with substantial script/allocation overhead and
remaining native placement costs**. The split is still a hypothesis to measure.
The evidence does not establish a memory leak, a garbage-collector-only stall,
or a new occupancy-index regression. It also does not prove an overall FPS gain
from D-197: complete-game trajectories differ and the latest final FPS is worse.

## Updated priority order

This ranks investigation/optimization priority by measured relevance, potential
wasted work and behavior-preservation risk. It is not an additive allocation
of CPU percentages; the first four items overlap in the same call paths.

| Rank | Remaining issue | Evidence and confidence | Proposed behavior-preserving approach |
| ---: | --- | --- | --- |
| **1** | Repeated failed TECH economy/build decisions | **High** for TECH dominance and retry volume; exact costly subphase unmeasured. 647 identical failure signatures in the final minute. | Time builder decisions and placement phases first; reuse identical failed query results only under complete dependency revisions. Keep decision cadence, candidate order and newly available-site response unchanged. |
| **2** | AngelScript allocation, GC and repeated observations | **High** for sampled VM/GC work; which script allocates and final-minute share remain unknown. | Measure allocations/GC statistics by AI and decision phase; reuse scratch arrays, static definition lists and per-decision observations. Avoid temporary dictionaries for fixed schemas. Do not disable GC or move it to a worker without a separate safety design. |
| **3** | Local reservation scans and candidate/pocket construction | **High** source evidence; 13 native TerrainManager samples, plus D-195's larger sample. D-197 only optimized the allied predicate. | Add an exact local index that preserves zone/ignore/consumed-slot semantics, cache immutable footprints, and reuse one validated geometry view inside a transaction. Preserve ranking, reach and exit lanes. |
| **4** | Repeated owned/unfinished-unit proximity scans | **Medium** measured/source evidence: nine BuilderManager source samples; six inline `FindOwnNear` hits. | Index validated live IDs by definition/spatial region or reuse one observation within a decision. Preserve nearest/tie ordering and D-108 lifetime checks; never restore stale-pointer iteration. |
| **5** | Speculative layout log formatting and console work | **High** volume, unmeasured standalone CPU saving: 320,301 reservation lines; 7,766 in game minute 39. | Check a diagnostic level before formatting transient messages; retain failures/invariants and explicit detailed mode. Compare equivalent decisions with a separate trace, then measure AI and Lua/console costs. |
| **6** | Excess command production and multiplayer synchronization risk | **High** volume, not proven cause of this CPU hitch: 16,435 total events/minute peak; TACTICAL team 10 reaches 4,699. | Attribute callers and eliminate computation for truly unchanged commands. Any command suppression/batching requires queue, movement and host/peer packet tests. No APM cap or slower threat checks. |
| **7** | Duplicate worker path/cost-map work and lane publication | **Medium** prior worker evidence; no worker saturation demonstrated here. Post-start lane publication peaks at 9.038 ms. | Share exactly identical immutable requests; preserve cancellation and publication order. Measure worker CPU/queue delay before adding threads. Keep engine queries and mutable script state on their permitted thread. |
| **8** | AIR route, radar and naval threat-evaluation scaling | **Source-supported future scaling risk**, low relevance to this final hitch: both AIR AIs together use 2.30% of AI time. | Reuse exact route corridors/spatial snapshots under threat/target revisions. Preserve targeting, AA padding and detection freshness. Existing fighter groups and route-equality guards already exist. |
| **9** | Profiler, Lua UI/console and rendering overhead | **Measured benchmark contribution**, not a proved production AI defect. Final Draw is 7.053 s and unsynced Lua callins 7.386 s; scopes overlap. | Retain a matched profiler-off control and fixed camera. Attribute UI widgets/console costs separately. Do not call profiler mutex aggregates disjoint CPU percentages or fix gameplay by hiding evidence. |

**Completed/demoted:** allied reservation membership/tree traversal. D-197's
fixed-footprint query is independent of claim count, and only one of 304 AI
samples resolves through it. Sparse mutation/memory tradeoffs still merit
measurement, but there is no present evidence to rank another rewrite above
the remaining work.

High APM and high CPU are different measurements. In the final minute TACTICAL
team 10 issues 3,509 events but spends only 212 ms in its AI callback scope;
TECH team 1 issues 2,209 and spends 36,600 ms. Command transport can still hurt
network play; those counts do not prove it caused this local slowdown. Event
origin and complete queues matter, and events are not packet counts.

## Concrete code paths and costs

1. [TECH's rules](../../data/script/src/roles/tech_rules.as) construct `Ctx` and
   [EcoPlanner::State](../../data/script/src/manager/eco_planner.as) for each ask;
   helper calls create arrays and options. The rule table itself is already
   initialized once. [TECH's economy update](../../data/script/src/roles/tech.as)
   also calls build/chain/forward/factory/weapon/invariant/layout maintenance.
   Instrument these separately instead of assuming all TECH work is its once-a-second tick.
2. [Layout::Place](../../data/script/src/manager/layout.as) tries main and forward
   zones again when no set slot succeeds. Its 30-second diagnostic throttle
   throttles a message, **not the repeated search**. Preserve its live response
   by caching exact work, not by delaying attempts. `CanPackNearGroup` and actual
   placement have different tests; changing preflight acceptance could change
   the build order and must not be smuggled into this performance pass.
3. [TerrainManager](../../src/circuit/terrain/TerrainManager.cpp) still calls
   `IsSlotFree` for candidate cells; zoned checks walk local reservations and
   recompute rectangles. `PackCandidates` also scans turret positions and factory
   exits. `LeavesPocket` is already limited to an eight-cell halo and bounded
   attempts, but its cells call `IsSlotFree` again. A simplified worst-case term
   is candidate count times local reservations/turrets, plus pocket cells times
   local reservations; it is not just one O(N) loop. Do not replace exact zone
   exemptions with D-197's simpler foreign-owner predicate.
4. [BuilderManager](../../src/circuit/module/BuilderManager.cpp) iterates owned
   units in `FindOwnNear` and `FindUnfinishedNear`. Repeating a U-unit scan across
   B builders/clusters can create O(BU) work. Some callers already share observations;
   measure the remaining calls rather than describing all roles as uncached.
5. [ScriptManager](../../src/circuit/script/ScriptManager.cpp) enables automatic
   GC. The pinned [collector](../../src/lib/angelscript/source/as_gc.cpp) performs
   incremental work when registering new objects. That agrees with the
   [official GC documentation](https://www.angelcode.com/angelscript/sdk/docs/manual/doc_gc.html).
   GC statistics are needed before distinguishing normal allocation churn from
   retained cyclic objects. No vendored-library edit is proposed.

## Next verification, before choosing a fix

- Add opt-in aggregate phase timers and call counts around TECH builder asks,
  `EcoPlanner::Read`, layout maintenance, native candidate/pocket/engine tests,
  and script context execution. Record team, frame, inputs/revisions, calls,
  failures, scanned objects and p95/p99; avoid per-candidate logging.
- Record GC current/new/destroyed/detected counts by AI and allocation phase;
  capture script function context during **39–40 minutes**, rather than relying
  on the earlier instruction sample. Do not label native inline symbols a full
  script stack.
- Replay identical failed-placement inputs with ordered candidate/result traces.
  Cache keys must cover definition, facing, anchor, reach, zone, turret geometry,
  own/allied reservation revision, engine blockers/features and terrain changes.
  Same frame or identical failure text is insufficient. A cleared wreck or lost
  reservation must immediately invalidate the result.
- Require identical chosen rule/site, task/command queues and tie order before
  a candidate is called behavior preserving. Test owner removal, reclaim,
  transfer and save/load. Keep original gameplay invariant failures visible.
- Use a matched observer-off/on control, fixed camera and continuing-match
  markers. Report callback timings, frame hitches, allocations and memory as
  well as FPS. Restrict threading experiments to owned immutable snapshots;
  [AngelScript's threading contract](https://www.angelcode.com/angelscript/sdk/docs/manual/doc_adv_multithread.html)
  does not make shared script globals or registered engine objects automatically safe.

Recommended next selection: **instrument TECH's failed-decision path, then
implement exact reuse and allocation reduction where the timings point**.
Local occupancy indexing is the next concrete native mechanism, but it should
not be represented as a guaranteed cure for the entire remaining hitch.
