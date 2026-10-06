# SEA production continuity and recovery fleet

## Plan (D-211)

Scope: experimental-profile SEA instances only, in both compact and experimental
economic modes. Other roles retain their native production and recovery policy.

1. Remove the experimental T1 factory's deliberate tech-saving WAIT. Preserve
   retirement/draining, player ownership, availability and resource safety.
   Keep complementary SEA factories active after T2 using the existing per-call
   native lever. Trace empty-queue reasons separately from resource stalls and
   obstructed exits; an order is not proof of productive throughput.
2. Replace the one-sub utility request with a queue-aware, fleet/income-scaled
   target. Admit one additional submarine at a time, only with funded build
   capacity; emergency counter hulls and recovery constructors retain priority.
3. Add a reusable native recovery selector, opted into by SEA script. Script
   selects low-metal state, priority repair definitions and search distance.
   Order: reclaim metal when low, repair flagships, resurrect reachable ship
   wrecks, repair other ships. Use legal observed features, terrain reachability
   and threat checks. Never reclaim living allies or steal player/retreat units.
4. Preserve an existing selected job and its engine command. Re-evaluate on a
   modest shared observation cadence; issue only genuine task transitions.
   Share feature snapshots across submarines and retain IDs, not borrowed
   engine objects. Document snapshot age and selection cost including existing task-claim lookups.
5. Verify deterministic policy boundaries in the actual AngelScript VM. Add
   a supplied fixture that exercises all four priorities and priority changes,
   and an 8v8 natural SEA run on Shore to Shore, covering all three factions.
   Observe every completed factory's queue, build progress, tier, resource
   state and exits. Record submarine counts, actual repair/reclaim/resurrection
   commands and completed outcomes. Save screenshots during the runs.
6. Publish matched DLL/data, run API/embedded-VM checks, retain immutable results
   including failures, update decisions/invariants/actor matrix and test index.

## Evidence and constraints

The official [Death Cavalry reference](https://www.beyondallreason.info/unit/correcl)
describes a fragile support submarine for reclaim, repair and resurrection;
resurrection consumes half the original unit's energy cost. The local effective
roster and BAR source establish all three factions' T1 resurrection subs at
240 metal and 150 build power. Their lack of construction-assist capability
means they must not be counted as shipyard construction support.

Native `EconomyManager::UpdateReclaimTasks` selects resurrection solely from
the worker capability, including during metal shortages. `SeaFactories::Utility`
requests only the first sub. `SeaFactories::Produce` explicitly WAITs while
saving for T2. These are the implementation paths this change addresses.

Continuous production is the user's updated priority over the previous
deliberate T1 saving pause. This can delay accumulation for later factories;
the existing seaplane admission gate remains unchanged. Resource starvation,
unit limits and unavailable build options cannot be solved by fabricating a
productive order and will be reported separately.

## Implemented policy

SEA keeps T1 factories eligible after higher tiers and removes the experimental
builder path's deliberate tech-saving WAIT. This does not override player
orders, explicit harbor retirement or unavailable definitions.
`KeepFactoriesQueued=true` skips the native pre-enqueue resource-admission WAIT,
while the existing recruit task still gates energy and reduces spending
priority under metal pressure. The native third argument defaults false for
other roles.
Native factory dispatch can still leave brief intervals between completed
products; queue continuity and product throughput are measured separately.

Recovery procurement starts after 1,500 metal of combat fleet. Its target is
`1 + min(floor(metalIncome/60), floor(fleetMetal/6000))`, with no new fixed cap.
Existing definition availability still applies. There is at most one pending
recovery hull, and admission uses the requesting factory's build power plus
available metal/energy after existing commitments. Emergency counters and
recovery construction ships keep priority. These submarines cannot assist
construction, so they are not a substitute for construction ships or turrets.

The recovery priority is re-evaluated every two simulation seconds:

1. Below 20% stored metal, reclaim safe reachable metal-bearing features.
   Remain in that state until storage reaches 40%, avoiding rapid switching.
2. Repair a damaged flagship, including an ally's flagship.
3. Resurrect reachable naval wrecks.
4. Repair other damaged naval units.
5. Stand by if no legal job exists; new work interrupts standby.

Player control, retreat and existing enemy-reclaim ownership are preserved.
Within one priority, retain eligible current work rather than chase a nearer
candidate each check. The native command is sent only on a task transition.
A one-second value/ID feature snapshot avoids per-sub wrapper reconstruction.
Feature selection is worst-case O(F * (1 + R)) for F features and R existing
reclaim/resurrection claims; the existing claim API scans tasks. Repair queries
scan U friendly units. There are at most four repair-class queries per sub,
not a claim of constant-time selection. No callbacks move to worker threads.

## Crash found and corrected

The first supplied 8v8 reached frame 4439 then crashed in
`CBRepairTask::OnUnitIdle`, RVA `0x1098a3` of DLL `8f86a21003fa1cb7`.
Matching debug symbols located the null dereference at RepairTask.cpp:53.
`IRepairTask::SetRepTarget` intentionally stores allied ships by `targetId`,
leaving the own-team `target` pointer null. Execute and Reevaluate already
resolve this case; the idle callback did not. It now follows the same contract
and aborts cleanly if the ally has disappeared. Existing own-team repair
completion semantics are preserved. This is a shared native crash fix, not
an additional production/targeting policy for other roles.

## Verification and limits

The actual vendored AngelScript VM passes 15 SEA policy test functions,
including threshold boundaries, hysteresis and scaling with both fleet and
income. Native compilation and the script/DLL API checker pass. All three
experimental profile mains compiled against an actual runtime interface dump.

The preliminary Supreme priority fixture passed all four priority observations
and produced units at T1, T2 and seaplane factories, growing recovery subs to
three. Two earlier fixture failures are retained: an undersupplied scenario
and invalid dry-water placement. Final-build repeats and supplied
8v8 results are recorded below.

The 30-minute natural Shore to Shore 8v8 completed 516 factory products across
16 T1 yards. Across 2,762 ten-second factory samples, none had an empty queue
for 15 seconds or longer. Thirty-eight samples made no progress on the same
product; these are not classified as empty queues. No T2 factory completed,
and no player exceeded one recovery sub. Consequently its original verdict
is FAIL (missing sub-scaling), not a passing late-game economy benchmark.
Low-income continuous T1 spending and earlier SEA economy limitations remain
open; this task does not claim to fix KI-228/KI-231/KI-235. The final minute's
engine AI scope averaged 4.32 ms for all 16 AIs, p95 9.86 ms. It is a single
candidate observation, not an old/new speed or internet APM comparison.

The first 8v8 attempt was invalid because the runner emitted a trailing comma
in its start array, adding a seventeenth null start. The generator now joins
entries without a trailing comma and the check requires exactly 16 starts.
A later capacity launch failed before gameplay due to insufficient disk space;
completed evidence was losslessly compressed, never deleted or rewritten.

Save/load and mid-game role changes are source-reviewed but unplayed. Full-route
safety, every map and every blocked-exit configuration are not established by
these tests. Native `CanReachAtSafe2` tests destination influence and movement
connectivity; it is not a guarantee that every point on the route is safe.


The first crash-fixed supplied 8v8 completed 946 factory products across 70
observed yards/platforms; every team produced at all three tested factory
families. Four teams reached three recovery subs and another reached one.
Allied repair was observed at 1.8 minutes. At the end, one Cortex platform
had a 58-second empty queue, and two low-metal samples on a Legion platform
showed no progress. This prompted the final KeepFactoriesQueued change.
The single INV-033 failure is retained and documented as KI-516: the
diagnostic clock included time when all allies were full, then saw new
storage space at its deadline. The donation policy was not changed.

The crash-fixed Supreme fixture repeated all nine acceptance checks with PASS
(reclaim 0.3m, flagship repair 0.5m, resurrection 1.9m, other repair 4.8m;
all three factory families producing by 4.7m; multiple recovery subs at 5m).

## Final build and repeat

Final DLL SHA-256: `3a6cae6daa1b3852acbb209989e0ff695a46a50d7733580a6ee223097e6d4917`.
Matched DLL, symbols and current data are published to the required Recoil
development output. The live BAR installation was not modified.

The final 12-minute supplied Shore to Shore 8v8 completed **950 products**
across **73 observed factories**. Across **2,898 factory samples**, there were
**zero empty intervals of 15 seconds or more**, a longest completed empty
interval of **3 seconds**, and **zero unchanged-progress samples** on the same
product. These observations support queue continuity; they do not promise
zero engine-frame dispatch latency. Recovery fleets reached three subs in
both Cortex and Legion teams and two in Armada. Allied repair orders were
observed without recurrence of the native crash.

The strict verdict remains **FAIL**: INV-033/KI-516 fired once, and team 7's
platform disappeared before finishing its first aircraft. That platform had
a queued aircraft progressing from 20.6% to 50.6% before its last observation;
the observer removes factories on UnitDestroyed. Thus 47/48 per-team factory
completion checks passed, not 48. The preceding supplied run passed all 48
but exposed the now-fixed empty interval. Neither report is relabeled.

The final minute's all-AI engine scope averaged **3.89 ms**, p95 **9.98 ms**,
p99 **17.98 ms**, maximum **24.05 ms**. The earlier candidate averaged 4.14 ms
in its final minute, but combat populations diverged: this is **not** a measured
performance improvement. No network/APM or FPS non-regression claim is made.

Validation: the complete `tools/run_native_tests.sh` suite passed, including
15 SEA policy tests, 400k+ reservation checks and the other native/VM suites.
The evidence parser test passes, including truncated logs and separating
resource stalls from new products. All three experimental mains compile with
the final runtime interface; compile-helper template-callback warnings concern
unimplemented helper stubs, not policy source or the embedded runtime.
API parity, role-doc and invariant checks pass. Documentation link validation
still reports the eight existing missing hover-document links (KI-404). Unit
validation reports 167 existing findings plus three from a concurrent unrelated
Tropical Assault map edit, with none in this change's unit IDs.

## Reproduce

```powershell
python tools/playtest/run_sea_recovery.py --dll <matching-SkirmishAI.dll>
python tools/playtest/run_sea_recovery.py --capacity --dll <matching-SkirmishAI.dll>
python tools/playtest/run_sea_recovery.py --fixture --dll <matching-SkirmishAI.dll>
python tools/playtest/analyze_sea_recovery.py <archived-infolog.txt> --output <new-analysis.json>
```

The runner pins BAR test-31479-433a460, Recoil 2026.07.04 and seed 2111. It
forces SEA only in the staged data, writes exact script/DLL hashes, and keeps
normal start resources in the natural game. Capacity runs inject real economy,
three factory families and flagships; priority fixtures additionally hold
combat/construction units and release factories at four minutes. Those
overrides are recorded in recovery-pins.json. Their supplied placement is
not evidence of the AI's natural base-layout decisions.

Final-DLL Supreme repeat: **PASS**, all nine checks. The flagship and ordinary
repair target both returned to full health. Recovery priorities remained in
order, multiple subs were produced, and T1/T2/platform products completed.
This fixture is supplied and Armada-specific; all-faction production/scaling
coverage comes from the 8v8 runs.

## Immutable evidence

| Run | Original verdict | Game minutes | Evidence |
| --- | --- | ---: | --- |
| Priority fixture: inadequate supply | FAIL | 8.2 | [Original report](benchmarks/records/sea/economy/priorities/2026-10-06/20261006T005013Z-1b234a1e/report.md) |
| Priority fixture: dry placements | FAIL | 8.0 | [Original report](benchmarks/records/sea/economy/priorities/2026-10-06/20261006T005302Z-2b792f67/report.md) |
| Corrected priority fixture | PASS | 8.0 | [Original report](benchmarks/records/sea/economy/priorities/2026-10-06/20261006T005544Z-9ed9e41e/report.md) |
| Invalid 17-start harness | FAIL | 2.7 | [Original report](benchmarks/records/sea/economy/production-8v8/2026-10-06/20261006T010330Z-8370d1c0/report.md) |
| Natural 8v8 | FAIL | 30.0 | [Original report](benchmarks/records/sea/economy/production-8v8/2026-10-06/20261006T011019Z-cd0a68df/report.md) |
| Capacity 8v8: allied repair crash | FAIL | 2.5 | [Original report](benchmarks/records/sea/economy/capacity-8v8/2026-10-06/20261006T011335Z-fd71210c/report.md) |
| Capacity launch: disk space | FAIL | 0.0 | [Original report](benchmarks/records/sea/economy/capacity-8v8/2026-10-06/20261006T011919Z-b11c6a10/report.md) |
| Capacity 8v8: queue gap | FAIL | 12.0 | [Original report](benchmarks/records/sea/economy/capacity-8v8/2026-10-06/20261006T012422Z-4fec9b21/report.md) |
| Crash-fixed priority fixture | PASS | 8.0 | [Original report](benchmarks/records/sea/economy/priorities/2026-10-06/20261006T012624Z-9d0e1632/report.md) |
| Final queue-continuity 8v8 | FAIL | 12.0 | [Original report](benchmarks/records/sea/economy/capacity-8v8/2026-10-06/20261006T014002Z-79186b9e/report.md) |
| Final priority fixture | PASS | 8.2 | [Original report](benchmarks/records/sea/economy/priorities/2026-10-06/20261006T014157Z-7548bdee/report.md) |
