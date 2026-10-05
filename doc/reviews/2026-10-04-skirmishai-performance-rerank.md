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

## Severity definitions

Severity describes impact, **not implementation difficulty, confidence in a
proposed fix, or an estimated speedup**. A risk can be severe without having
caused this particular slowdown; such cases are marked below.

| Severity | Definition | Response |
| --- | --- | --- |
| **Extra high** | Observed severe stalls or loss of responsiveness in normal gameplay, with the responsible subsystem identified. | Investigate first. The exact expensive function may still need measurement. |
| **High** | Substantial supported processing cost, or a serious scalability/multiplayer risk that could impair timely play. | Prioritize after the confirmed bottleneck; measure the proposed mechanism before selecting the fix. |
| **Medium** | Repeated waste or secondary overhead with bounded observations or an unquantified material benefit. | Make a targeted improvement after profiling and compare against its maintenance/behavior risk. |
| **Low** | Little demonstrated present impact; primarily future scaling or measurement hygiene. | Monitor or make a small isolated improvement; avoid a broad rewrite. |

## Updated priority order

This ranks investigation/optimization priority by measured relevance, potential
wasted work and behavior-preservation risk. It is not an additive allocation
of CPU percentages; the first four items overlap in the same call paths.

The order prioritizes the latest local hitch and evidence strength. Item 6 is
High provisionally for multiplayer risk: packet and peer-lag measurements are
still missing. It ranks below more directly relevant local work. Item 9's
control measurement should accompany every experiment even though a production
UI/rendering optimization itself is low priority.

| Rank | Remaining issue | Severity | Evidence and confidence | Proposed behavior-preserving approach |
| ---: | --- | --- | --- | --- |
| **1** | Repeated failed TECH economy/build decisions | **Extra high** | **High** for TECH dominance and retry volume; exact costly subphase unmeasured. 647 identical failure signatures in the final minute. | Time builder decisions and placement phases first; reuse identical failed query results only under complete dependency revisions. Keep decision cadence, candidate order and newly available-site response unchanged. |
| **2** | AngelScript allocation, GC and repeated observations | **High** | **High** for sampled VM/GC work; which script allocates and final-minute share remain unknown. | Measure allocations/GC statistics by AI and decision phase; reuse scratch arrays, static definition lists and per-decision observations. Avoid temporary dictionaries for fixed schemas. Do not disable GC or move it to a worker without a separate safety design. |
| **3** | Local reservation scans and candidate/pocket construction | **High** | **High** source evidence; 13 native TerrainManager samples, plus D-195's larger sample. D-197 only optimized the allied predicate. | Add an exact local index that preserves zone/ignore/consumed-slot semantics, cache immutable footprints, and reuse one validated geometry view inside a transaction. Preserve ranking, reach and exit lanes. |
| **4** | Repeated owned/unfinished-unit proximity scans | **Medium** | **Medium** measured/source evidence: nine BuilderManager source samples; six inline `FindOwnNear` hits. | Index validated live IDs by definition/spatial region or reuse one observation within a decision. Preserve nearest/tie ordering and D-108 lifetime checks; never restore stale-pointer iteration. |
| **5** | Speculative layout log formatting and console work | **Medium** | **High** volume, unmeasured standalone CPU saving: 320,301 reservation lines; 7,766 in game minute 39. | Check a diagnostic level before formatting transient messages; retain failures/invariants and explicit detailed mode. Compare equivalent decisions with a separate trace, then measure AI and Lua/console costs. |
| **6** | Excess command production and multiplayer synchronization risk | **High** | **High** volume, provisional network severity; not proven cause of this CPU hitch: 16,435 total events/minute peak; TACTICAL team 10 reaches 4,699. | Attribute callers and eliminate computation for truly unchanged commands. Any command suppression/batching requires queue, movement and host/peer packet tests. No APM cap or slower threat checks. |
| **7** | Duplicate worker path/cost-map work and lane publication | **Medium** | **Medium** prior worker evidence; no worker saturation demonstrated here. Post-start lane publication peaks at 9.038 ms. | Share exactly identical immutable requests; preserve cancellation and publication order. Measure worker CPU/queue delay before adding threads. Keep engine queries and mutable script state on their permitted thread. |
| **8** | AIR route, radar and naval threat-evaluation scaling | **Low** | **Source-supported future scaling risk**, low relevance to this final hitch: both AIR AIs together use 2.30% of AI time. | Reuse exact route corridors/spatial snapshots under threat/target revisions. Preserve targeting, AA padding and detection freshness. Existing fighter groups and route-equality guards already exist. |
| **9** | Profiler, Lua UI/console and rendering overhead | **Low** | **Measured benchmark contribution**, not a proved production AI defect. Final Draw is 7.053 s and unsynced Lua callins 7.386 s; scopes overlap. | Retain a matched profiler-off control and fixed camera. Attribute UI widgets/console costs separately. Do not call profiler mutex aggregates disjoint CPU percentages or fix gameplay by hiding evidence. |

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

## Proposed solutions and acceptance evidence

These are selectable proposals, not implemented optimizations. No speedup is
promised. Items 1–4 can remove some of the same work, so their benefits cannot
be added as independent savings. Begin each with bounded aggregate telemetry,
then compare equivalent input states and preserve the existing decision cadence.

### 1. Reuse demonstrably identical failed placement work — Extra high

**Change.** Instrument TECH's builder decision, economy observation, layout
maintenance, candidate generation, pocket testing and engine buildability
separately. Introduce a placement-query context that shares immutable geometry
and repeated pure results among callers in one unchanged placement transaction.
Only extend failed-result reuse across decisions when every dependency can be
tracked exactly. Use a bounded cache keyed by definition, facing, anchor,
zone, reach, policy inputs and relevant geometry/state revisions.

**Safeguard.** Reservations, unit/feature blockers, turret coverage, ownership,
reclaim and terrain changes must invalidate affected results immediately.
Engine placement inputs for which the AI cannot observe complete changes must
still be checked live; do not cache the whole failure across decisions in that
case. An identical log signature or frame number is insufficient. Keep the
current fallback order and retry opportunities; do not substitute a delay or
change `CanPackNearGroup` acceptance rules.

**Verify.** Differentially replay the retained failed converter workload and
cases where a wreck, unit or reservation disappears between asks. Compare
ordered candidates, chosen rule/site, tasks and commands. Require identical
first-opportunity placement after the obstruction clears. Report TECH p95/p99,
calls and candidate/engine tests avoided, plus cache memory and invalidations.
The Extra high rating belongs to the confirmed TECH stall; this exact reuse
mechanism remains a proposed remedy until phase timings establish its value.

### 2. Reduce transient script objects and duplicate reads — High

**Change.** Attribute allocations and GC work by AI/phase before selecting
hotspots. Reuse scratch arrays where ownership permits, retain immutable
definition lists, replace fixed-schema temporary dictionaries with reusable
typed state, and share one valid economy/unit observation within a decision.
Start with `TechRules`/`EcoPlanner` rather than rewriting all AIR logic. The TECH
rule table is already initialized once and is not an outstanding optimization.

**Safeguard.** Clear retained handles, bound scratch capacity, and give nested
or reentrant calls independent workspaces. Keep mutable economy reads current
where an intervening task changes state. Preserve iteration and random-call
order. Do not disable GC, change its schedule, edit the vendored VM, or move
shared script objects to another thread as part of this proposal.

**Verify.** Compare object creation/destruction, retained references, GC time,
peak memory and callback tails in the same workload. Verify identical rule,
unit, target and task choices, including nested callbacks and a long soak.
Fewer allocations alone is insufficient if retained memory or hitches increase.

### 3. Index local occupancy and reuse candidate geometry — High

**Change.** Extend the indexing approach to `TerrainManager`'s remaining local
reservation checks with exact zone and slot accounting. Precompute immutable
footprint rectangles by definition/facing; reuse a validated turret/exit-lane
view during a placement transaction. Use indexed occupancy for repeated
candidate and pocket-cell queries rather than rescanning every reservation.

**Safeguard.** Preserve ignored reservation IDs, consumed slots, zone exemptions,
nested reservations, half-open boundaries and exact candidate ranking. A simple
foreign-owner occupancy bit is not an equivalent local predicate. Mutation
and rollback must update the index synchronously. Fixed-footprint membership
can become independent of reservation count; the entire candidate search and
arbitrarily large area queries are not promised O(1).

**Verify.** Differential tests against the existing implementation should cover
reserve/release/replace/rollback, ignored IDs, consumed slots, overlap, facing,
reclaim, transfers and save/load reconstruction. Compare full ordered placement
results as well as query results. Benchmark increasing reservation counts,
candidate counts and mutation churn, recording memory. Re-run allied layout
exclusion cases for AIR/SEA/TECH with INV-088 enabled.

### 4. Replace repeated whole-army proximity scans — Medium

**Change.** Share a validated unit observation within an unchanged decision
first. If timings justify persistent indexes, maintain live unit IDs grouped
by definition and spatial region for `FindOwnNear`/`FindUnfinishedNear`. Query
the relevant subset and retain an exact final distance/eligibility check.

**Safeguard.** Process create, finish, move where applicable, transfer and death
events; revalidate IDs before use. Preserve unfinished-state transitions,
nearest selection and original tie ordering. Keep D-108 lifetime checks. A
spatial index reduces ordinary candidate counts but does not guarantee O(1)
nearest queries in every distribution.

**Verify.** Compare selected IDs with the scan implementation under equal
distances, dense/empty regions, destruction, transfer and completion. Measure
objects visited and callback time at increasing unit/builder counts, including
index update cost. Reject any stale-handle or changed-assist-target behavior.

### 5. Stop formatting speculative diagnostics when disabled — Medium

**Change.** Test the configured diagnostic level before constructing strings.
Count repetitive speculative reservation failures by team and query class,
then emit periodic summaries in normal mode. Retain a detailed opt-in trace,
first/actionable failure context, errors and every invariant violation.

**Safeguard.** This changes diagnostic output, not AI decisions. Update log
consumers explicitly; a missing detailed line must not silently become a
passing check. Leave original benchmark logs and verdicts immutable. Do not
use a logging throttle to throttle placement itself.

**Verify.** Compare detailed and aggregate modes with a separate ordered
decision trace. Measure string/log time, bytes/lines, console/Lua time and frame
tails. Exercise error/invariant paths in both modes. Separate the saving in
the AI callback from any subsequent UI saving.

### 6. Remove redundant command computation and verified duplicate orders — High

**Change.** First attribute command events to role, task, caller and command
type, including queue changes. Avoid recomputing an unchanged intent where
its inputs are demonstrably unchanged. For commands proven redundant, retain
an issued-intent record and send again only when required by the engine's
queue semantics. Evaluate group batching only where engine/network inspection
shows that it actually reduces transport while preserving per-unit orders.

**Safeguard.** Same destination does not establish command equivalence: options,
queue position, target ID, timeout, repeat state and queue clearing matter.
An apparently duplicate command can renew or restart an action. Invalidate
intent on idle, task transitions, external orders, death/transfer and relevant
world changes. Keep threat-response cadence unchanged and do not impose an
APM cap. Existing fighter grouping is not a new proposed feature, and one
script call may still produce many synchronized unit commands.

**Verify.** Compare effective queues, attack/formation behavior and response
latency, not just issued command counts. Test host plus peers and record
command bytes/packets, host backlog, simulation speed and peer lag. Include
urgent raids, moving targets, target death, partial groups and player orders.
The High rating is a provisional multiplayer risk assessment; observed event
counts do not establish a universal 3,000-APM lag boundary or packet count.

### 7. Coalesce identical background work before adding threads — Medium

**Change.** Measure queue delay, execution time, snapshot-copy cost and main
thread publication in path/cost-map and lane jobs. Share an in-flight result
only for requests with identical immutable inputs, revisions and algorithm
parameters. Reuse immutable input data where possible. The existing worker
pool already has eight workers; adding more is not the first solution.

**Safeguard.** Preserve per-request cancellation, deterministic results,
tie-breaking and publication order. Earlier completion can itself change
gameplay; publish at the equivalent decision boundary. Snapshot construction
and revision validation stay on the permitted thread, and results referencing
obsolete world state are discarded exactly as before. Do not call engine APIs
or mutate shared AngelScript state from a worker.

**Verify.** Compare job inputs/outputs and publication frames with cancellation,
rapid revision changes and different completion orders. Measure copied bytes,
jobs avoided, worker utilization, queue delay and main-thread p95/p99. Proceed
only where total cost falls without changed decisions; test for races with
available tooling before claiming thread safety.

### 8. Reuse exact AIR threat queries — Low

**Change.** Profile route corridor checks, radar patrol safety and naval threat
observations before selecting a cache. Reuse exact results within an unchanged
query context, with persistent reuse only under complete threat, visibility,
target and geometry revisions. Use a spatial subset followed by the existing
exact tests rather than repeating broad scans for each plane or wave.

**Safeguard.** Preserve AA padding, unknown-threat allowance, visibility and
position freshness, route/target priority and release timing. Do not coarsen
safety sampling or reduce scout/threat update rates. Current grouping and
route-equality guards remain in place; this is incremental work.

**Verify.** Compare routes, selected targets, patrols and launch frames while
AA appears/disappears or moves, radar coverage changes and naval groups split.
Record threat samples, calls and AIR timings against aircraft/enemy counts.
Both AIR AIs contributed only 2.30% of the latest final-minute AI scope, so
there is no evidence for prioritizing an AIR-wide rewrite over TECH work.

### 9. Separate observer and display costs from AI costs — Low

**Change.** Add a matched profiler-off control to each performance comparison,
keeping camera, rendering, simulation settings and gameplay diagnostics
otherwise consistent. Attribute console, widgets, draw and profiler overhead
separately before proposing a specific production UI optimization. Keep the
measurement hooks opt-in and aggregate their output.

**Safeguard.** Draw and unsynced Lua scopes overlap; do not add them as disjoint
CPU costs. A headless run does not establish rendered FPS, and turning off
evidence is not an AI fix. Retain screenshots, source/input identities and
original failure verdicts for the observed run.

**Verify.** Report observer-on/off overhead alongside AI callback p95/p99,
simulation throughput and rendered frame times. If a display bottleneck is
isolated, test it independently from gameplay changes. This is a low-priority
production fix but an immediate requirement for trustworthy comparisons.

### Shared acceptance and suggested selection

Select **phase instrumentation and item 1 first**, then apply items 2 and 3
where those timings point. Item 5 is a smaller isolated option; pursue item 6
as a separate multiplayer investigation. Include item 9's control methodology
from the start. No proposal authorizes changing economy, combat priorities,
update frequencies or unit grouping behavior to obtain better timings.

Use identical-input differential tests for exact decisions, plus repeated
matched game runs for performance; full games can diverge with asynchronous
completion, so FPS alone cannot prove behavioral equivalence or causation.
Check chosen rules/sites/targets, ordered task/command effects, random-call
order, invariants, allocations, memory and tail latency. Report regressions
and uncertainty rather than claiming an unsupported percentage improvement.

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
