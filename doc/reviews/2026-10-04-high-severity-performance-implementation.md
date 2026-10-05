# D-199: behavior-preserving performance work

Status: targeted implementation complete and verified at the function/contract
level. Full comparable-state late-game hitch acceptance and host/peer network
acceptance remain open. This is not a claim that every High risk is eliminated.

## Scope and baseline

This implements safe portions of the **Extra high** and **High** items in the
[ranked review](2026-10-04-skirmishai-performance-rerank.md). Economy gates,
build orders, combat priorities, response intervals, placement ordering, random
calls, and effective commands are not tuning knobs for this optimization.

The comparison baseline is HEAD `195f5e7a` **plus the existing dirty AIR/SEA
worktree**. Before editing, `build-theatres/d199/baseline/manifest.json` froze
944 source/data files and the D-197 DLL/symbol pair. Those source/data hashes
matched D-197's inputs exactly. The scoped commit does not incorporate the
unrelated AIR/SEA implementation. Historical benchmark verdicts are preserved.

| Ranked item | Implementation | Remaining acceptance limit |
| --- | --- | --- |
| 1, Extra high: repeated failed TECH decisions | Remove a discarded preflight, index occupancy, and replace repeated whole-weapon scans with an invocation-local observation | The measured quadratic weapon path is corrected. Full-game late-hitch acceptance still needs a comparable surviving TECH workload; subsequent matches lost that workload. No unsafe cross-decision failure cache. |
| 2, High: transient script allocation | One owned energy-option array, no caller copies; reuse constructor counts within the same read-only context; bind facing arrays by handle | No retained shared scratch objects, GC schedule changes, or broad dictionary rewrite. Whole-game allocation/GC attribution requires like-for-like workloads. |
| 3, High: local reservation scans | Exact sparse cell index, synchronous mutation and reconstruction, opt-in old/new runtime oracle | The full placement algorithm is not constant time. Engine geometry tests and candidate ranking remain live. |
| 6, High, provisional: commands | Remove custom-command payload allocation/copying through the existing synchronous C bridge | Order count and network traffic intentionally unchanged. Movement/state suppression and a multiplayer lag claim remain unproved. |

## 1. TECH's discarded placement preflight

`Layout::CanPlace` admitted every non-null definition. With a box, it ran
`CanPackNearGroup` over zones and memoized the result, but explicitly promoted
every failure to `true` because actual placement may expand the layout. Its
dictionary was private to that function; no other policy consumed the probes.

Before, abbreviated without changing its decision logic:

```angelscript
bool ok = false;
for (int i = 0; i < ZoneCount() && !ok; ++i)
    if (aiTerrainMgr.CanPackNearGroup(ZoneAt(i), def, nanoGroup,
            facing, 0.0f, MinNanoDist(def))) ok = true;
if (!ok) ok = true;
canPlaceAt.set(key, int64(ai.frame));
canPlaceWas.set(key, ok);
return ok;
```

After:

```angelscript
bool CanPlace(const CCircuitDef@ def)
{
    return def !is null;
}
```

This removes speculative candidate generation, reach/occupancy scans, sorting,
terrain queries, definition-name construction and two memo dictionaries from
that gate. Actual `Place` still performs the same checks and tries the same
sites. Other callers of the native preflight remain supported. The old
`LayoutCanPlaceMemoSeconds` setting is retained for configuration compatibility,
but no longer affects this already-unconditional admission gate.

No failure is cached across decisions. A wreck disappearing or a slot being
released can still make a site available on the next original attempt.

## 2. Economy objects and observations

The energy list now uses stable insertion within its owned array. It preserves
affordability ordering, metal-per-energy ordering, larger-output preference,
and original order on equal keys. The function returns its array handle;
callers keep that handle instead of allocating another value copy. `PickEnergy`
retains a mutable owned handle because it filters reactors while mex upgrades
are pending; the other callers use read-only handles.

Before:

```angelscript
array<Option@> sorted;
// find insertion index in sorted, in the original comparison order
sorted.insertAt(at, c);
return sorted;
// caller:
array<Option@> opts = EnergyOptions(s);
```

After:

```angelscript
// Find the same insertion index in the already sorted prefix of opts.
for (uint k = i; k > at; --k) @opts[k] = opts[k - 1];
@opts[at] = c;
return opts;
// caller:
const array<Option@>@ opts = EnergyOptions(s);
```

Each invocation owns its array, including the caller's filtering. Nested callbacks cannot overwrite a shared
workspace, and handles are released at scope exit. `TechRules::Build` obtains
its constructor total from the two counts already read by `EcoPlanner::Read`;
only read-only getters intervene. No task or command executes between these
reads. Three layout-facing callers likewise bind a read-only handle to the
returned array. No unit classification or policy list changes.

## 3. Exact local occupancy

Previously, a zoned `IsSlotFree` query walked the reservation map, ignored the
specified ID and consumed entries, recomputed rectangles and tested overlap.
An unscoped fresh reservation also scanned complete zone envelopes. Candidate
and pocket-cell loops multiply this cost.

Before, abbreviated:

```cpp
for (const auto& [id, slot] : reservations) {
    if (id == ignoreId || slot.consumed) continue;
    ReservationCells(slot.def, slot.pos, slot.facing, a, b);
    if (Overlaps(query, a, b)) return false;
}
```

After:

```cpp
if (zone > 0 && localReservations.OverlapsSlot(query, ignoreId))
    return false;
```

`LocalReservations` has directly addressed sparse 32-by-32-cell pages. Each
cell stores an active-slot count, XOR of active IDs, and zone-envelope count.
For exactly one slot, its XOR identifies the ignored ID; for multiple slots,
ignoring one still leaves an obstruction. Nested zones and overlapping slots
therefore retain multiplicity. Half-open rectangles preserve touching edges.

Creation, consumption, restoration, recycling, erasure, group/zone release and
load reconstruction update the index synchronously. Saved layout format is
unchanged: the derived index is rebuilt from the authoritative saved records.
Allied ownership checks, blocking-map authority and exact zone exemptions remain
in their original order. No engine buildability result is cached.

For a fixed footprint, membership is independent of reservation count:
**O(footprint cells)**, formerly O(reservations) plus rectangle reconstruction.
Mutation costs O(log reservations + affected cells). Full placement still scans
candidates and turret positions and sorts the same candidates. Large-area
queries scale with the area queried; this is not an O(1) promise for a whole
base-layout decision.

## 4. Command computation without changing commands

The generated C++ wrapper accepts a vector by value, allocates a second float
array, copies the parameters, calls `bridged_Unit_executeCustomCommand`, and
deletes the array. The new adapter supplies a borrowed span directly to that
same bridge. The bridge immediately copies the values into the engine command
path before returning, as required by the original wrapper's temporary buffer.

Before:

```cpp
unit->ExecuteCustomCommand(CMD_ATTACK_GROUND,
    {pos.x, pos.y, pos.z}, options, timeout);
```

After:

```cpp
float params[] = {pos.x, pos.y, pos.z};
SendCustomCommand(unit->GetSkirmishAIId(), id, CMD_ATTACK_GROUND,
    params, options, timeout);
```

The changed paths are ground attack, command removal, personal cloak, landing
pad requests and BAR priority. The adapter preserves the engine return-code
check and `CallbackAIException` method name. It does not batch, remove, reorder,
defer or renew commands, and it does not impose an APM limit.

Suppressing an order based on a cached destination or state is deliberately
excluded: timeouts, queue options, external orders and not-yet-processed state
changes can make a repeated request necessary. Existing grouping remains.
This reduces CPU/allocation work only; **network improvement is not claimed**.

## Measurement hooks

`CIRCUIT_PERF_PHASES=1` enables aggregate native/script phase timers and GC
statistics. Phase timings include counts, inclusive/exclusive milliseconds and
maximum call duration; nested times must not be summed as independent work.
The hooks are off by default. Per-thread storage prevents worker/main writes
to shared profiling state; only the update thread flushes its own observations.
AI teardown clears its record, and script exceptions unwind interrupted spans.

`CIRCUIT_VERIFY_LOCAL_LAYOUT=1` compares each live indexed predicate with the
old full predicate. INV-144 reports any mismatch; periodic `[LocalOracle]`
records show the number actually checked and cell storage. This mode
deliberately incurs the old scan cost and must not be used as a speed benchmark.

## Validation and measured results

The completed native suite includes 200,038 local-index differential checks and
200,159 allied-index checks, both without failures. The pinned VM passed 20,000
energy-ranking and 20,000 admission/memo cases against frozen old source,
including filtering the returned owned array. Command boundary tests preserve
every payload bit, options, timeout and error across 50 calls.

The first game launch caught an incorrectly const-qualified `PickEnergy`
handle. That caller removes reactors while mex upgrades are pending. The handle
was corrected, caller-filtering coverage was added, and the failed launch was
retained separately. The successful final cross-role test contains no script
errors or invariant failures.

### Measured function costs

Three repeats of 10,000 fixed 2-by-2-cell queries, optimized MinGW C++20 build:

| Slots | Miss, old median | Miss, indexed median | Indexed cell storage |
| ---: | ---: | ---: | ---: |
| 100 | 228.47 ns | 6.93 ns | 159,848 bytes |
| 1,000 | 4,460.82 ns | 7.34 ns | 307,400 bytes |
| 5,000 | 22,954.17 ns | 7.40 ns | 1,229,600 bytes |
| 20,000 | 151,411.91 ns | 7.56 ns | 3,996,200 bytes |

This demonstrates reservation-count independence for the fixed query, not
20,000-fold improvement to the game. Early-hit cases also run faster (about
the single-digit nanosecond range versus roughly 123-259 ns here), while misses and ignored-only footprints
expose the old full scan. The reference precomputes rectangles, so it excludes
the additional old engine-wrapper footprint calls. Both paths use the same
queries and checked answers, with a compiler barrier in each timed iteration.
Both resulting mutation maps and the index are verified after timing to keep
the writes observable. Cell storage excludes map nodes and page-pointer capacity. Mutation timing is
reported separately because indexing adds writes.

The mutation run includes both the existing authoritative map write and the
new derived-index update (100,000 replacements of 2-by-2-cell slots, three
repeats, no test game or build running). Median nanoseconds per replacement:

| Slots | Map alone | Map plus index | Added cost |
| ---: | ---: | ---: | ---: |
| 100 | 3.98 | 68.97 | 64.99 |
| 1,000 | 9.45 | 147.58 | 138.13 |
| 5,000 | 32.94 | 163.17 | 130.23 |
| 20,000 | 41.20 | 185.84 | 144.64 |

Large zone-envelope mutations scale with their covered area, unlike these
small-slot updates. The existing idle Chobby lobby remained open during all
these tests; no claim is made of a completely idle operating system.

The pinned AngelScript VM executes actual old/new sorting bodies with identical
five-option input and actual return/caller ownership. Option discovery and
engine queries are replaced by a fixed input, so this isolates array work:

| 100,000 calls | Old | New | Change |
| --- | ---: | ---: | ---: |
| Median elapsed across old/new/new/old ordering | 471.84 ms | 229.79 ms | 51.3% less time, 2.05x throughput |
| GC-tracked objects registered | 400,000 | 100,000 | 75% fewer |
| Retained GC-tracked objects after each loop | 1 | 1 | No growth in this test |

These are array-component results, not 75% fewer allocations throughout the AI.
Production option construction, all other script objects and GC phases still
exist. No garbage collector setting was changed.

For 10,000 three-parameter custom commands, the old generated-wrapper path
performed **20,000 temporary heap allocations**; the new adapter performed
**zero**. Both dispatched 10,000 identical bridge calls. This does not eliminate
allocations inside the engine, change APM, or establish a network speedup.

### Runtime evidence

The [six-minute Supreme AIR/TECH/SEA test](../benchmarks/records/sea/layout/allied-bases-mixed/2026-10-05/20261005T011412Z-a32acf25/README.md)
passes all twelve directed foreign factory/economy exclusions. The local oracle
was enabled for all six AIs; no INV-144 mismatch was emitted. Its periodic counts
are a lower bound, not a fabricated total: this short run did not reach the
100,000-query reporting interval. Erase/reinsert and reconstruction have
unit-level differential coverage; targeted engine ownership transfers and a
real engine save/reload have not been played.

The [rendered Shore baseline](../benchmarks/records/shared/performance/reservation-occupancy/2026-10-05/20261005T003731Z-adb18a7b/README.md)
reached frame 72,000 but emitted GameOver at frame 60,037 (33.35 minutes).
Measurements after that event are excluded from competitive performance claims.
Existing gameplay invariant failures remain FAIL, independent of the
optimization checks.

The [first optimized forty-minute Shore run](../benchmarks/records/shared/performance/reservation-occupancy/2026-10-05/20261005T013102Z-2ac71542/README.md)
completed without GameOver or script errors. Its final minute still hitches:
17.77 ms mean AI time, 97.03 ms p95, 156.48 ms p99, 173.94 ms maximum,
39 median FPS and 1,572 units. TECH team 1 uses 20.773 s and TECH team 8
7.310 s of the 31.989 s aggregate callback time. Thus **the Extra high
late-game issue is not resolved by the first optimization pass**. A separate
run with phase timings and the local query oracle is investigating that path;
diagnostic timings must not be compared as production-speed measurements.

| Normal-speed window | Baseline units / AI mean / p99 / FPS | First optimized units / AI mean / p99 / FPS |
| --- | --- | --- |
| Minute 4 | 252 / 1.287 ms / 5.998 ms / 212 | 259 / 1.320 ms / 6.025 ms / 276 |
| Minute 10 | 488 / 1.599 ms / 5.258 ms / 192 | 457 / 1.516 ms / 5.352 ms / 242 |
| Minute 20 | 754 / 3.481 ms / 15.219 ms / 146 | 731 / 2.281 ms / 7.750 ms / 202 |
| Minute 30 | 747 / 3.462 ms / 14.844 ms / 135 | 953 / 2.664 ms / 9.906 ms / 161 |
| Minute 40 | Excluded: baseline game ended at 33.35 | 1,572 / 17.772 ms / 156.484 ms / 39 |

These observations are not a paired causal FPS estimate: the unit counts and
game trajectories differ. The old D-197 final minute (23.96 ms mean, 225.25 ms
p99, 8 FPS) is also a different live state. Only the identical-input function
benchmarks above establish the isolated speedups. The first optimized run
retains its gameplay FAIL, including INV-017/020/037/053 reports not observed
in this shorter-lived baseline; absence in a different trajectory does not
establish that those violations were introduced or fixed by this patch.

The [forty-minute diagnostic rerun](../benchmarks/records/shared/performance/reservation-occupancy/2026-10-05/20261005T015059Z-a65805e7/README.md)
reports at least **8,900,012 exact old/new reservation comparisons with zero
mismatches**, including final teardown frames just past the requested limit.
At frame 72,000, TECH team 1's script scope is 43.332 s; TECH evaluation is
42.607 s inclusive and **42.086 s exclusive** of measured child phases.
Economy reads take 0.171 s and layout placement 0.272 s inclusive. The
remaining work can include uninstrumented native calls from a rule: "exclusive"
does not mean every instruction is interpreted script. Live GC-tracked objects
remain around 3,000, which is not evidence of a growing object leak.

A thirty-second diagnostic sample around minutes 35-36 captured 1,533 thread
locations without capture failures, taking 58.461 ms total for the brief
suspensions. 154 resolve inside the AI DLL (144 on thread 88868). This is
randomized wall-clock instruction sampling, not a CPU-cycle allocation or an
exact final-minute profile. It reinforces the need for named rule timings.
The diagnostic rerun retains its original gameplay FAIL. The archived
`performance-phases.json` is the earlier interim snapshot; the separately
named `performance-phases-final.json` contains final analysis. Original archive
hashes are preserved.

## 5. Measured late-game weapon-work path

The [run with named rule timers](../benchmarks/records/shared/performance/reservation-occupancy/2026-10-05/20261005T020650Z-e7b6d9eb/README.md)
identifies TECH team 1's final-minute cost: `air.defend` 17.375 s,
`weapons.cluster` 9.120 s and `idle-air-defense` 8.689 s. These are distinct
rule/fallback scopes; the first can call weapon work twice, while the latter
also calls fortification work. Failed economy placement leads builders down
these fallbacks, but is not itself the only expensive work.

Inside weapon work, every eligible cluster repeated `OutstandingOrders`, a
scan over **all** clusters and slots. Most old slots also resolved a UnitDef
before noticing that their order was older than the existing 300-second
window. That lookup is a read-only mapping and cannot affect the count.

Before:

```angelscript
for (...) {
    // Existing cluster eligibility filters.
    if (!escort && OutstandingOrders() >= limit) return null;
    // Scan this cluster's slots.
}
```

After, abbreviated:

```angelscript
int pending = -1; // local to this Work invocation
for (...) {
    // Same eligibility filters, same order.
    if (!escort) {
        if (pending < 0) pending = OutstandingOrders();
        if (pending >= limit) return null;
    }
    // A changed dead flag or an attempted Order resets pending to -1.
}
```

There is no reuse across asks or game frames. The code invalidates before an
order attempt because enqueue/abort hooks may mutate other state. Site failure
and missing-definition dead flags also invalidate. No negative site result,
builder action, defense fallback or retry is suppressed. With K eligible
clusters and N total slots, repeated unchanged count work falls from O(K*N)
to O(N+K); mutations can still require rescans. Cluster/slot ordering and
every actual site/order attempt remain unchanged.

The extracted old/new `Work` and `OutstandingOrders` bodies pass 20,000
differential fixtures, each invoking selection three times and comparing the selected
task, ordered site/order attempts, dead/ordered state, budget and mutations.
Fixtures include the 30/60/300-second boundaries, stalled/failed orders that
modify a different slot and metal-full state, unavailable definitions, ground
versus air builders and super-cluster exclusions. The third invocation advances
31 seconds and clears a site obstruction, testing fresh observations on the
next original opportunity. Engine reads use scripted
observations; integer role IDs replace strings and a trace replaces the budget
message. This does not simulate real terrain or engine callbacks.

A fixed no-order fixture of 32 clusters with 16 slots each executes 1,000 asks:
the full outstanding scan drops from **32,000 calls to 1,000**. The actual
pinned VM bodies take median **2,423.14 ms old versus 131.10 ms new** across
old/new/new/old runs: 94.59% less time, 18.48x throughput for this isolated
fixture. That is not an 18x whole-game claim. Engine measurements and the full Shore reruns are described below.

## Affected-file map

| Surface | Files | Purpose |
| --- | --- | --- |
| Local geometry | `src/circuit/terrain/LocalReservations.h`, `TerrainManager.h/.cpp` | Exact derived occupancy, lifecycle updates and optional legacy oracle |
| Script decisions | `data/script/src/manager/layout.as`, `eco_planner.as`, `data/script/src/roles/tech_rules.as` | Remove discarded preflight, reduce array copies, reuse an observation, optional phase boundaries |
| Weapon work | `data/script/src/roles/tech_weapons.as`, `doc/roles/tech_weapons.md`, `tools/knowledge/check_weapon_work.py`, `tests/fixtures/performance/weapon_work_before.as` | Reuse a pure pending-count observation within one call, invalidate on mutations, retain order/site semantics, extracted differential fixtures |
| Engine command bridge | `src/circuit/spring/CustomCommand.h/.cpp`, `src/circuit/unit/CircuitUnit.cpp` | Borrow custom-command payload through the unchanged generated bridge |
| Diagnostics | `src/circuit/util/Performance.h/.cpp`, `src/circuit/CircuitAI.cpp`, `src/circuit/script/ScriptManager.cpp`, `InitScript.h/.cpp` | Disabled-by-default phase timing and GC counters |
| Native verification | `tests/local_reservations_test.cpp`, `local_reservations_benchmark.cpp`, `custom_command_test.cpp`, `production_math_test.cpp`, `tests/CMakeLists.txt` | Differential occupancy, mutation/query costs, exact command payloads, pinned-VM runner |
| Script verification | `tests/fixtures/performance/`, `tools/knowledge/check_performance_policy.py` | Frozen old bodies and actual optimized bodies tested with identical inputs |
| Runners | `tools/run_native_tests.sh`, `tools/run_performance_tests.sh`, `tools/playtest/analyze_performance_phases.py`, `run_reservation_performance.py`, `run_weapon_performance.py`, `weapon_performance_probe.as`, `checks/shared/performance/weapon_work.json` | Repeatable checks, unchanged default game options, explicit never-end soak, staged engine-only workload and diagnostic summaries |
| Contracts/evidence | This report, `doc/decisions.md` D-199, `doc/known-issues.md`, `doc/invariants.md` INV-144, `doc/actor-matrix.md`, `doc/angelscript-references.md`, `doc/roles/tech_rules.md`, benchmark records | Rationale, unresolved issues, ownership, API and immutable original verdicts |

## Reproduction

Run `bash tools/run_native_tests.sh`, then
`bash tools/run_performance_tests.sh` with the existing pinned build cache.
Set `PYTHON` to the available interpreter when it is not on PATH. After stopping
other builds/games, `PERF_BENCH=1` adds local-index and pinned-VM microbenchmarks.
The runner records the original option/preflight source fixtures, not copies of
the optimized algorithm used as their own oracle.

The rendered game runner is `tools/playtest/run_reservation_performance.py`.
Always pin the DLL, data and seed; retain source hashes, observer settings,
screenshots, GameOver markers and original check verdicts. A different full-game
trajectory or a lower post-victory unit count is not a controlled speedup.


## 6. Full reruns and controlled engine comparison

The [first weapon-optimized natural run](../benchmarks/records/shared/performance/reservation-occupancy/2026-10-05/20261005T021916Z-b271da6f/README.md)
ended at frame 51,998 (28.89 minutes). Its post-victory FPS cannot validate a
late-game fix. The [45-minute never-end soak](../benchmarks/records/shared/performance/reservation-soak/2026-10-05/20261005T023341Z-a75d9adb/README.md)
kept the match open, but combat removed team 1's builder workload before minute
40 anyway. Its largest one-minute `weapons.cluster` scope was 66.206 ms for
296 calls at minute 37; at minute 40 team 1 had no TECH evaluation calls.
Those observations are retained, not presented as a matched 99% game speedup.
Both runs have clean script-error checks and retain their gameplay FAILs.
The soak reports INV-004/008/013/014/019/022/037/039/053. No gameplay behavior
was altered to silence these checks. Full comparable-state hitch acceptance
and the multiplayer traffic risk remain open.

To separate function cost from combat outcome, the isolated engine fixture
loads the frozen original `Work` and `OutstandingOrders` alongside the actual
new functions. A real commander unable to build the real super-cannon UnitDef
receives 32 synthetic eligible clusters, each containing 16 unbuilt slots.
Every selection must return null before any site/order operation. The fixture
uses the game's actual string-to-definition mapping, `CanBuild`, income, frame
and unit-position getters. It runs ten asks per second, old/new/new/old, then
restores the real clusters and every temporarily overridden gate before play
resumes. This is a synthetic workload, not a new production behavior.

Across two TECH AIs, 500 calls per version per AI give 1,000 old and 1,000 new
calls. Timing includes the new function's nested diagnostic overhead, which
makes this comparison conservative for that overhead. It does not include
fixture construction or array swapping. The first hard-profile run completed
both workloads with no script error, probe failure or invariant. Its overall
FAIL is retained: the opening check incorrectly required `opening.mex`, while
the normal selected rush used `chain.next`. The reusable check now accepts
both valid openings; it does not rewrite that run's original verdict.

This controlled workload reproduces costly old calls in the actual engine
and measures the optimized function on equivalent inputs. It supports the
specific mechanism improvement independently of the full-match divergence.
It does not establish that every cause of a late-game hitch has been removed.


| Profile | Old: 1,000 asks | New: 1,000 asks | Function throughput | Original check verdict |
| --- | ---: | ---: | ---: | --- |
| [hard](../benchmarks/records/shared/performance/weapon-work-hard/2026-10-05/20261005T023830Z-c65baf4f/README.md) | 63.035 s | 2.068 s | 30.49x | FAIL (opening-check mismatch above) |
| [balanced](../benchmarks/records/shared/performance/weapon-work-balanced/2026-10-05/20261005T024142Z-47d285c7/README.md) | 62.343 s | 2.063 s | 30.22x | PASS |
| [terrible](../benchmarks/records/shared/performance/weapon-work-terrible/2026-10-05/20261005T024422Z-84019acb/README.md) | 62.811 s | 2.066 s | 30.41x | PASS |

All three loaded the current production script graph and native bindings. Both
balanced and terrible runs pass the corrected opening/probe/timer/error/invariant
checks. No production file is changed by the engine fixture. The runner pins
the source DLL/data, hashes the staged test injection, and enables diagnostics
only for its own child engine process.

## Remaining limits and next acceptance tests

- Preserve the comparable late TECH workload, or capture a reproducible live
  state, before declaring the original whole-game hitch gone. Natural victory
  and destruction of builders invalidated the final windows in later tests.
- The full-game gameplay FAILs remain. This performance patch does not claim
  to fix their economy/placement lifecycle causes.
- Run actual engine save/reload and targeted transfers in addition to the
  tested index reconstruction and live create/release/consume paths.
- Network/APM acceptance still needs host/peer packet and lag measurements.
  This patch removes command allocation work; it sends exactly as many orders.
- No GC schedule change, thread offload, rate limit, coarse reaction interval,
  broad failure cache or command suppression was introduced.

[Machine-readable measurements and provenance](2026-10-04-high-severity-performance-measurements.json)
retain raw component observations and source/binary identities. The immutable
run bundles retain original check verdicts and evidence hashes, including FAILs.


Final repository checks: the full native/script runner and focused performance
runner exit 0; role documentation, invariant practice and installed script/DLL
API parity report zero findings. Staged whitespace checks pass. The documentation
link checker reports the same eight preexisting missing-hover-guide references
(KI-404), with no new broken link. The final native runner output and its SHA-256
are retained in the machine-readable measurements.
