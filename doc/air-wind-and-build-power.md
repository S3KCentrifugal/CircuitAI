# AIR wind clusters and construction scaling

## Design (D-149)

The owner requests tightly packed groups of six windmills, with separation
between groups, and faster construction-power growth. TECH remains unchanged.

AIR currently searches separate 96-elmo rings for each windmill. It also sizes
turrets only against aircraft throughput, leaves factory-owned turrets idle
when recruitment pauses, and grows mobile constructors through fixed income
thresholds. During fusion preparation, project assistance precedes new turret
construction and can defer support growth for the whole transition.

TECH provides the useful pattern: scale build power against metal income,
increase the target when metal floats, finish support already under construction,
and count only power that can do the work. Copying its dense turret-box layout
would defeat AIR's separate production bays and raid redundancy.

Implementation:

1. Reserve a complete 3-by-2 wind group atomically using loaded X/Z footprints
   and existing persistent native reservations. Windmills touch footprint edges;
   separate group bounding circles by a configurable 144-elmo gap. Fill/reuse
   existing slots before opening another group. Keep IDs and named metadata
   for adoption; native claims/frame/destruction state remains authoritative.
   Reject incomplete reservations and roll them back. No scattered wind fallback.
2. Use pure, tested work-to-unit arithmetic for mobile constructor targets and
   the income-based turret floor. Start at eight work/second per metal/second,
   with a 1.5 multiplier when metal floats. Count queued recruits and frames once.
   Split mobile work between T1 and T2 after transition; keep T1 constructors
   available for winds and ordinary turrets. Funding, energy recovery and caps
   remain mandatory. Factory turrets are not counted as mobile economy power.
3. Preserve transport-first recruitment and the immediate fighter screen. Give
   funded mobile workforce growth a turn before the full interception quota.
   Preserve the existing 20-turret T2 comparison limit and the first-fusion mex gate.
4. Grow factory support before general preparation assistance; finish a pending
   turret before opening another. Idle production turrets may assist owned
   construction within their actual reach, using the same target selector as
   mobile builders. Production remains their first responsibility: the AIR tick
   ends static economy assistance when the owning factory has a new unit frame.
   Native static repair tasks otherwise have no timeout.

Validation: execute actual AngelScript arithmetic tests; independently observe
wind positions/group occupancy, completed mobile/static work, resource stalls,
fusion timing and combat in pinned headless games. Compare with D-148's natural
runs. Test a supplied-income case for growth beyond the opening and a wind-loss
fixture for slot reuse. Keep failures and remaining limitations in the evidence.

## Implemented policy

Loaded footprints determine the grid: the current three factions use 48-elmo
strides, giving a 144-by-96-elmo group footprint. A 16-elmo candidate margin
allows native snapping while preserving the 144-elmo inter-group circle gap.
These are separate reservations using the existing required-pin lifecycle;
there is no native layout change and no TECH controller call.

The target is eight work/second per metal/second, rising by 50% with floating
metal. Mobile counts round up using each loaded constructor's work rate. Before
T2 the target belongs to T1; afterwards it splits 40% T1 and 60% T2. Funded
floors are two T1 before transition and three T1/two T2 afterwards, bounded at
ten T1/eight T2. Recovery still requests the minimum replacement crew. Mobile
growth needs half the constructor's metal cost banked and the existing
30-second cost forecast after outstanding project commitments.

Factory support takes the larger of the original aircraft-throughput target
and its share of the construction target, with factory work deducted. Actual
reserved slots bound the answer; T1 remains capped at five and T2 at twenty.
These are independent static and mobile budgets because a factory turret
cannot follow a constructor to a remote wind cluster or mex. They are targets,
not permission to spend without funding. Shared arithmetic and the common
assistance selector avoid duplicating production math or repair scans.

## Evidence

All paths below are relative to `build-theatres/air/`. Each run pins DLL
`build-05/SkirmishAI.dll` (SHA-256
`6a963dd33d8a9b1d7ecd9d664ea4d8f813814c29e514381289f527f73c088ffd`),
Recoil `recoil_2026.07.04`, BAR `test-31450-6562fb1`, Supreme Isthmus v1.7,
`experimental_hard`, seed 930146 and zero bonus. Team 0 is the named faction,
opposed by Armada AIR. These are contested games, not PvP win-rate evidence.

| Run / archived report | Outcome |
| --- | --- |
| `clusters-arm-v1/runs/20260930-154553` | Diagnostic FAIL: INV-078 read a served reservation before assignment. Actual wind geometry was clean; corrected to inspect the planned position until the pin is served. |
| `clusters-arm-v2/runs/20260930-160246` | PASS: two full groups by 4:00, three constructors by 6:20, two turrets by 7:30; fusion **18:09.7**, after zero pending mexes at frame creation. Rejudged with team-0 turret and mex-observer checks. |
| `clusters-cor-loss-v2/runs/20260930-160247` | Wind replacement and workforce checks pass; combined result FAIL on fusion's 20-minute deadline, completion **20:45.2**. Three T1 constructors were lost before seven minutes. The induced wind death at frame 9035 was followed by a new frame in cluster 1/slot 1 at 9656, **20.7 seconds** later. No invariant/script/crash failure. |
| `clusters-leg-capacity-v2/runs/20260930-155057` | Diagnostic FAIL: observer treated 36 fixture-spawned AFUS units as AI construction, reporting INV-077. Workforce thresholds all met. |
| `clusters-leg-capacity-v3/runs/20260930-155906` | PASS with builder-provenance observation: 10 T1 constructors, 8 T2 constructors and 20 turrets by **11:20**. This fixture supplies a late economy and two advanced constructors; it is not natural growth timing. |
| `clusters-leg-natural-v3/runs/20260930-160050` | Diagnostic FAIL: two repair tasks carrying a wind definition triggered the placement invariant. Actual six-slot positions were clean; fusion completed 19:40.4. INV-078 now checks ENERGY construction only. |
| `clusters-leg-natural-v4/runs/20260930-160352` | Placement and workforce checks pass with the corrected invariant; combined FAIL on reactor deadlines, fusion **22:26.6** after repeated constructor deaths. This repeated contested run preserves timing variance rather than selecting only the earlier completion. |
| `clusters-arm-v3/runs/20260930-160948` | Final code: packing/workforce checks pass, combined FAIL on reactor deadlines; fusion **21:46.5** after losing the first T2 plant and nine T1 constructors. Reactor starts at 20:24.3 with zero pending mexes. By 23:00: four T1/three T2 constructors, six turrets and five full wind groups. No invariant/script/crash/observer failure. |
| `clusters-leg-natural-v5/runs/20260930-160955` | Final code PASS: three constructors by 5:10, two turrets by 7:10; reactor starts at 16:43.8 with zero pending mexes and finishes **19:10.1**. By 23:00: eight T1/four T2 constructors and twelve turrets. No invariant/script/crash/observer failure. |
| `clusters-leg-capacity-v4/runs/20260930-160843` | Final code PASS: ten T1/eight T2 constructors and twenty-one turrets by **11:40**, twenty-three turrets at 12:00, across three plants. This remains a supplied-income fixture. No invariant/script/crash/observer failure. |

The read-only observer checks actual positions independently of native slot
intent. Armada v2 started six clusters with a minimum circle gap of 150.9 elmos;
Cortex started six with a minimum gap of 166.3. Both had five fully completed
groups at 23 minutes. Incomplete final groups grow one windmill at a time.
Reactor checking uses the builder ID forwarded by BAR's widget dispatcher;
engine `give` spawns have no builder and are logged separately. Natural checks
require an actual zero-pending-mex reactor-frame observation as well as timely
fusion completion. All invariant forbids remain enabled.

Final replays also observe actual nano construction through
`Spring.GetUnitIsBuilding`: Armada turrets assist `armadvsol`, Legion turrets
assist `legadvsol`, and the capacity fixture observes turrets building other
turrets. The AIR tick logs their return to production when a plant resumes.
Native static repair otherwise has no timeout. These final runs include that
preemption correction; the earlier comparison below predates it and is retained
as evidence of the initial workforce change, not substituted for final results.

Compared with D-148's Armada run, the v2 run had these live completed counts:

| Game minute | Earlier T1/T2 constructors | New T1/T2 constructors | Earlier turrets | New turrets |
| --- | --- | --- | --- | --- |
| 10 | 4 / 0 | 4 / 0 | 2 | 4 |
| 15 | 4 / 2 | 4 / 2 | 2 | 4 |
| 20 | 4 / 2 | 4 / 3 | 4 | 8 |
| 23 | 4 / 2 | 6 / 2 | 7 | 12 |

This improves construction capacity, not every combat outcome: Armada v2's
observer recorded 7,133 fighter damage versus the earlier 13,066, and 230
seconds with an empty metal bank versus 106; neither had an empty energy bank.
Different combat outcomes and asynchronous simulation prevent interpreting one
pair as a causal damage estimate. More construction investment competes with
aircraft spending, so the immediate screen, funding gates and transport-first
hook remain in place. Cortex's loss run recorded 3,964 damage and 257/0.5
metal/energy stall seconds. No observer coverage gap occurred in these runs.

Final-run observations were Armada 7,297 fighter damage and 250.5/2.0 seconds
with empty metal/energy banks; Legion 6,839 damage and 157.5/0.0 seconds; the
supplied-capacity run 3,346 damage and no empty-bank samples. These counters
describe approximately 23-minute natural games and a 12-minute fixture, not
equal-budget combat trials. Constructor and factory losses are retained in the
logs and deadline verdicts.

## Verification boundaries

The engine-free native suites pass (76 ranking checks, geometry, eight lane
suites), as do all **46 executable AngelScript policy tests**, including eight
new workforce/grid cases. The API checker verifies 239 used members against
the pinned DLL. Shared functions have no role state; TECH policy files, JSON,
native code and `data_sample/` are unchanged.

Role documentation, invariant practice, six watcher deadline regressions and
`git diff --check` pass. The repository-wide link checker retains its eight
existing missing-hover-document links (KI-404); the unit checker retains the
two existing unreachable TECH sonar definitions (KI-425). No new findings were
introduced. The required build output contains byte-matched current `data/`,
the pinned stripped DLL and its matching debug symbols; no live BAR install
was written.

The 20-minute fusion aim remains subject to completing every owned mex upgrade;
losses can delay it (KI-436). Full save/load remains KI-209. The feature is scoped
to the experimental AIR controller; legacy dispatch is recorded separately in
KI-437. No claim is made about every terrain, poor-wind map, content option,
raid blast radius or sustained multiplayer win rate.
