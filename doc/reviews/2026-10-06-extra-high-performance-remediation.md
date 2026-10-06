# Extra-high performance remediation, round one

Status: CircuitAI implementation and verification complete; the upstream engine
finding remains open (D-221). This report
continues the [ranked 8v8 investigation](2026-10-06-metal-plate-glacial-performance.md).
It does not claim that every measured cost is removable or that the remaining
high/medium/low issues have been fixed.

## Scope

| Original rank | Scope | Status |
| --- | --- | --- |
| 1 | Recoil animation/script, movement and path costs | Open, upstream. AGENTS.md prohibits changing the engine reference. Leading parent costs are measured; avoidable leaf costs are not isolated. |
| 2 | Ranged decision query traversal | Implemented; native and live predicate oracles pass; large-game evidence below. |
| 3 | Ranged snapshot rebuilding | Implemented; fresh engine observations retained; large-game evidence below. |

All existing changes were committed as `f8fc38eb` before beginning this work.
The first push was rejected by automatic approval review; the explicit
payload/destination approval is pending. No gameplay policy change is part of
this performance work. High/medium/low findings remain in KI-528--531.

## Implemented mechanisms

1. **Exact early exit.** Spatial `Any` stops at the first true predicate.
   `FreeSlot`, `FriendlySplash`, `FriendlyLine`, `HasScreen` and static safety
   use it. Full enumeration and scored accumulation retain z/x/insertion order.
2. **Static safety index.** `Safe` only accepts static hazards in its search;
   unrelated long-range mobile contacts no longer enlarge ordinary bounds.
   Negative margins and exceptional radii retain the original range bound.
   The actual segment/escape test is unchanged.
3. **Danger sign.** Existing consumers ask `==0` or `>0`, so nonnegative finite
   hazard costs permit an existence test. The numeric `Danger` sum remains
   available and is used as fallback for exceptional or negative costs. NaN
   retains its original false result for both comparisons.
4. **Reusable spatial storage.** Map-sized dense cells avoid hashing for normal
   coordinates. Sparse overflow preserves negative and off-map coordinates;
   excessive dimensions use sparse storage throughout. Clearing visits only
   the previous generation's touched cells and retains vector capacity.
   Query bounds intersect occupied bounds; this skips only empty cells.
5. **Ascending friendly IDs.** A reusable bit inventory produces precisely the
   previous comparison-sort order. Small inputs and duplicate/out-of-bound IDs
   retain comparison sort. Every UnitDef and position is still observed through
   the legal engine callback; no shared, cross-frame or stale observation cache
   was introduced.
6. **Separate snapshot attribution.** New opt-in nested phases separate enemy,
   friendly and state work. Compare the inclusive snapshot parent with the old
   snapshot total: its new exclusive residual is not the before/after metric.

## Before and after

Old boolean query (the callback returns early, but traversal continues):

```cpp
bool blocked = false;
index.Query(position, radius, [&](int id) {
    if (!blocked && predicate(id)) blocked = true;
});
return blocked;
```

New boolean query (the iterator itself exits):

```cpp
return index.Any(position, radius, [&](int id) {
    return predicate(id);
});
```

This replacement is valid only for pure existence predicates. It is invalid
for scored sums, random draws, logging with per-candidate meaning, or callbacks
whose side effects must run for every candidate.

Old bucket clearing scans historical cells. New clearing uses stable addresses
recorded when each cell first becomes active in that generation:

```cpp
for (auto* bucket : touched) {
    bucket->value.clear(); // vector capacity retained
    bucket->active = false;
}
touched.clear();
```

Scalar cluster-cost cells reset to zero through the same storage mechanism.
Their accumulation and query order are unchanged.

## Complexity and ownership

Let N be the engine world-unit scan, F legal friends, E known enemies, C cells
touched last generation, I the engine ID bound, Q intersecting query cells,
and K candidates visited. Friendly ordering changes from O(F log F) to
O(F + I/64) for normal large inputs. Index construction is O(E + F), clearing
O(C), and enumeration O(Q + K). Existence stops early when a match is found;
its worst case remains O(Q + K), not O(1). Existing history/member/shot/escort
bookkeeping and engine callback costs remain separate and unchanged.

Dense memory follows map cell count, capped at 1,048,576 cells per store before
sparse fallback. Overflow nodes and vector capacities persist to avoid repeat
allocation. All storage belongs to one AI and remains on its callback thread.
Configure invalidates storage and is only used before observations are added.

## Verification and measured gains

Native integration, all standalone native/AngelScript suites, 310-member
DLL/API parity and seven telemetry-analysis tests pass. Candidate DLL SHA-256:
`eca9d0229482cc8ef335588a32d6c47365917ccf18e34845ecc58c5bb444b5f4`;
matching symbols: `99ba4b211e10985370e65b462f0f8c036c15bbd8c2025405fe4f4f13a415944f`.
No script or JSON gameplay policy changed.
Comparing the two Glacial manifests' 337 AI files found exactly one changed
file, `SkirmishAI.dll`: all 336 other script/config/metadata files match byte
for byte, including the staged timing wrappers. Metal Plate likewise differs
only in the DLL among 338 files (its extra file defines the map's start spots).
The native build uses the
separate Recoil build source at `92efda5e60fb6df54a8f17a87e4f4cdb4aa2de31`;
runtime remains the installed `recoil_2026.07.04`, not a rebuilt engine.

Five serial rendered combat fixtures pass their original assertions with both
live oracles enabled, no INV-148/161, and no script errors. These correctness
runs include deliberately expensive legacy work and are excluded from timing.

| Fixture | Verdict | Enemy kills / ranged losses | Original evidence |
| --- | --- | ---: | --- |
| ranged-armsnipe | PASS | 4 / 0 | [record](../benchmarks/records/shared/combat/ranged-armsnipe/2026-10-06/20261006T192506Z-86180da9/README.md) |
| ranged-starlight-closing | PASS | 13 / 1 | [record](../benchmarks/records/shared/combat/ranged-starlight-closing/2026-10-06/20261006T192621Z-0d784d79/README.md) |
| ranged-legmed | PASS | 4 / 0 | [record](../benchmarks/records/shared/combat/ranged-legmed/2026-10-06/20261006T192736Z-99db7264/README.md) |
| ranged-cortrem | PASS | 4 / 0 | [record](../benchmarks/records/shared/combat/ranged-cortrem/2026-10-06/20261006T192850Z-76cf2fcd/README.md) |
| ranged-sensor-advance | PASS | 6 / 0 | [record](../benchmarks/records/shared/combat/ranged-sensor-advance/2026-10-06/20261006T193007Z-942686ec/README.md) |

Starlight closing-assault permits casualties in its existing checks; its one
loss is retained, not rewritten as a zero-loss result. Outcome variation alone
does not prove identical paths: the same-snapshot predicates and exact ordered
primitive oracles establish the specific transformations being claimed.

### Same-input component measurements

Seven-batch medians, MinGW GCC 13 C++20 `-O2`, assertions enabled; all games
and compiler processes stopped. Numbers below are microseconds per operation
at 10,000 input points/IDs, fixed seed 221. The
[kernel bundle](../benchmarks/records/shared/performance/ranged-query-kernels/2026-10-06/20261006T193006Z-458183a0/README.md)
contains 2,000/5,000/10,000-point results and source/compiler pins.

| Kernel | Old us | New us | Speedup | Interpretation |
| --- | ---: | ---: | ---: | --- |
| Rebuild + ordered enumeration | 84.439 | 58.416 | 1.45x | Same emitted ID sequence; allocation/hash work only. |
| Ascending ID order | 305.186 | 11.958 | 25.52x | Same fresh sorted prefix; does not include engine census. |
| Local existence miss | 0.131 | 0.092 | 1.42x | 700-elmo query, all candidates visited. |
| Large existence hit | 7.681 | 0.021 | 364.60x | Stress case with a very early answer; not a typical full decision. |

These figures are not FPS, network or full-snapshot speedups. Large early-hit
and empty-query ratios are deliberately favorable boundary workloads, not
representative claims for every combat query. The fixed-input empty-bound
stress result remains in the raw bundle only: compiler hoisting/inlining can
dominate that tiny result, so its ratio should not guide prioritization.

### Natural 8v8 observations

Glacial Gap completed the same 60-minute horizon with all 16 AIs alive, no
GameOver, no script errors and **412 gameplay invariant events** in the drained
log. Its original strict verdict remains **FAIL**. The
[candidate record](../benchmarks/records/shared/performance/full-match-profile/2026-10-06/20261006T200145Z-d1685f1c/README.md)
contains screenshots, native inclusive/exclusive tables and all input hashes.
The [D-220 baseline](2026-10-06-metal-plate-glacial-performance.md) remains intact.

All costs below are combined AI milliseconds per simulation frame. Snapshot
uses its inclusive parent; decision excludes its nested snapshot.

| Glacial minute | Units old / new | AI mean old / new | AI p99 old / new | Snapshot old / new | Ranged decision old / new |
| --- | ---: | ---: | ---: | ---: | ---: |
| 40 | 2,952 / 2,838 | 7.324 / 6.417 | 27.078 / 24.219 | 0.472 / 0.319 | 0.457 / 0.010 |
| 57 | 3,690 / 3,313 | 22.306 / 8.658 | 52.000 / 38.656 | 1.089 / 0.425 | 12.143 / 0.013 |
| 60 | 3,889 / 3,533 | 12.063 / 10.997 | 41.500 / 49.063 | 1.215 / 0.247 | 1.605 / 0.006 |

The former minute-57 ranged spike did not recur in this candidate observation.
However, surviving populations, contact geometry and query counts differ:
minute 57 has 3,350 versus 1,954 ranged decisions and 3,102 versus 2,175
snapshot calls. At minute 60, the **whole-AI p99 is worse**, despite lower mean
and ranged costs. These observations support targeted integration progress,
not a promise of a particular FPS improvement or identical match outcomes.
Exact-input component results and same-snapshot predicate checks carry the
equivalence/per-kernel claim.

At candidate minute 60, SEA update costs 1.591 ms/frame, builder dispatch 1.325,
factory dispatch 1.080, TECH base-lab reclaim 1.027 and economy update 0.802
(exclusive labels, not additive with parent script scopes). These remain
separate findings from the first-round ranged changes. The busiest team issued
18,166 unit commands in that game minute; no order suppression or APM limit
was introduced.

Metal Plate completed the same 30-minute horizon with all 16 AIs active, no
GameOver, no script errors and **49 gameplay invariant events**. Its original
strict verdict remains **FAIL**; see the
[candidate record](../benchmarks/records/shared/performance/full-match-profile/2026-10-06/20261006T202409Z-c088e2bb/README.md).
Both natural runs use ordinary economies; no unit caps, production changes or
supplied economy reduce their workload. These are horizon-complete diagnostic
runs, not matches played to victory.

| Metal minute | Units old / new | AI mean old / new | AI p99 old / new | Snapshot old / new | Ranged decision old / new |
| --- | ---: | ---: | ---: | ---: | ---: |
| 10 | 1,859 / 1,983 | 1.645 / 1.886 | 4.369 / 5.424 | 0.110 / 0.181 | 0.009 / 0.012 |
| 20 | 4,684 / 4,170 | 7.724 / 6.586 | 15.617 / 14.836 | 3.162 / 2.210 | 0.206 / 0.079 |
| 30 | 9,250 / 6,808 | 20.002 / 14.806 | 37.656 / 37.688 | 8.022 / 4.001 | 0.465 / 0.107 |

The early candidate interval is slower and has more calls: 2,102 versus 1,202
snapshot calls at minute 10. At minute 30, snapshot calls are 11,977 versus
14,006 and ranged decisions 17,779 versus 21,324. The late total mean is lower,
but the whole-AI p99 is essentially unchanged. Neither the 26% lower AI mean
nor the 50% lower snapshot total is an exact-input optimization speedup.

The new minute-30 snapshot breakdown is friendly observation/indexing 2.806,
enemy observation/indexing 0.786, state 0.393 and residual 0.016 ms/frame.
Friendly observation/indexing remains **70% of the inclusive snapshot phase**;
the phase does not isolate individual callbacks from ID ordering and indexing.
Builder dispatch is 4.062 and factory dispatch 2.556 ms/frame.
These are the next native/script attribution targets, not costs removed by
this patch. There are 83,077 unit-command events across all teams in that
minute, including 13,718 air commands; these are not network-packet counts.

The baseline engine's 97.82 ms script/animation parent did not recur in this
smaller candidate army (3.70 ms); movement is 11.13 versus 71.54 ms. **The engine
binary was unchanged.** Those differences cannot be credited to this patch or
used to close the engine finding: populations, active movement and worker
contention differ, and the original parent has not been split into leaf costs.
Candidate progress is 0.633 game seconds per wall second versus 0.109 in the
baseline at minute 30. FPS medians are 15 versus 38 under fast-forward; slower
simulation can render more frames between game frames. FPS alone would give
the wrong interpretation here, and camera/focus controls remain KI-531.

Metal's 49 invariant events include INV-017 (14), INV-010 (13), INV-043 (5)
and INV-004 (4); the immutable analysis contains every code/count. Glacial's
412 include 241 INV-053. These are existing gameplay invariant categories,
not a passing full-game regression result or a diagnosed consequence of the
optimization. Preserve them for separate reproduction and fixes.

## Closure and remaining scope

The avoidable traversal, hash/allocation and ID-sort work in ranks 2/3 has been
implemented and verified at the primitive and live-predicate level. KI-527
remains open for the still-material fresh world census/observation cost; no
cross-AI cache may be introduced without proving callback-time freshness.
Rank 1/KI-530 remains upstream and unmodified. High/medium/low findings from
D-220 remain separate work. This round therefore **does not resolve every
extra-high issue or establish zero FPS regressions**.

The C++, AngelScript and playtest skills now document ordered equivalence,
fresh observations, touched-cell lifetime, pure early exit, inclusive timer
comparisons, and separate correctness/timing runs. Their skill validation
passes. Specs, the invariant register, actor matrix, decision register and
test/benchmark indices are updated alongside this report.

The tested stripped DLL and matching symbols have been published with current
data to `C:/bardev/bar-RecoilEngine/build-amd64-windows/install/AI/Skirmish/BARb/stable`.
All 336 data files match the source; the 310-member script/DLL check passes
against that output. The live BAR installation was not modified. The
[changelog](../../changelog/2026/10/06/2026-10-06T172725-0300-extra-high-ranged-performance.md)
records this round and its remaining limitations.

## Remaining engine work

The Metal Plate engine profile measured script/animation and movement parents;
these are not estimates of avoidable cost. Investigate Recoil's
`rts/Sim/Units/Scripts/UnitScript.cpp` animation traversal scratch and
`rts/Sim/Units/Scripts/UnitScriptEngine.cpp` worker/deferred-call ordering using
symbols matching the deployed executable. A retained traversal buffer would
have to preserve breadth-first order, parent transform copy timing, checksum
order, completion callbacks and deferred calls. No such engine change is
applied here, and no engine-level gain is claimed.

The upstream remediation is concrete but still conditional on leaf attribution:

1. Obtain/build symbols for the exact deployed engine revision. Split the
   animation parent into COB work, animation sort/update, piece traversal,
   checksum/completion and worker wait. Aggregate worker-local measurements
   after the existing barrier rather than adding a shared timer lock per piece.
2. If traversal allocation is material, replace per-call temporary traversal
   allocation with retained worker-owned scratch. Keep queue semantics (not
   depth-first traversal), copy each parent's transform at the same point, and
   preserve child insertion order and all completion notifications.
3. Use a retained Metal Plate replay to isolate the engine with identical synced
   commands. Compare frame checksums, piece transforms, completion callback
   sequence and memory high-water marks across baseline/candidate. A replay
   comparison is appropriate for this engine kernel; it does not test fresh AI
   decision performance.
4. Measure warmed normal-speed replay windows with profiling off and on, then
   return to live 8v8 AI games. Record movement/path leaf costs separately from
   animation; do not credit a traversal-buffer change with the whole 97.82 ms
   parent. Do not reduce animation cadence, unit caps or path requests to claim
   behavior preservation.

This is the work needed to close rank 1/KI-530 in an authorized engine change.
It is not an applied patch or a verified saving in this CircuitAI round.

## Files

- [Geometry and storage](../../src/circuit/terrain/RangedGeometry.h)
- [World snapshot and queries](../../src/circuit/task/fighter/RangedWorld.cpp)
- [World contract](../../src/circuit/task/fighter/RangedWorld.h)
- [Engagement consumers](../../src/circuit/task/fighter/RangedEngagement.cpp)
- [Timers](../../src/circuit/util/Performance.cpp) and [phase IDs](../../src/circuit/util/Performance.h)
- [Ordered differential tests](../../tests/ranged_geometry_test.cpp),
  [frozen legacy index](../../tests/ranged_legacy_index.h),
  [component benchmark](../../tests/ranged_performance_benchmark.cpp)
- [Maintenance guide](../performance/engineering-guide.md)
- [Ranged combat specification](../ranged-combat.md)
- [Inclusive/exclusive summaries](../../tools/playtest/summarize_full_match_performance.py)
  and [telemetry tests](../../tools/playtest/test_full_match_performance.py)
