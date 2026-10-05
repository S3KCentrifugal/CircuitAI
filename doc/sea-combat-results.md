# SEA combat and economy review — D-189

2026-10-04. **Experimental; not accepted for default rollout.** The research,
source trace, fixtures and several fixes are implemented. The request to beat
all existing SEA benchmarks is **not achieved**. Historical Glacial bests of
10:27 T2 and 15:31 fusion remain targets; a faster opening that later loses
production is not a win. `Sea::ExperimentalBuild` remains false by default.

## Research and scope

The [plan](sea-combat-enhancement-plan.md) translates the official
[sea warfare guide](https://www.beyondallreason.info/guide/basics-on-sea-warfare)
and [repair/reclaim mechanics](https://www.beyondallreason.info/guide/reclaim-resurrect-repair)
into layered fleets, scouting, protected ranged damage, wreck control and
funded expansion. [Unit controls](sea-unit-controls.md) enumerate 304 reachable
definitions, including ordinary naval units, seaplanes, amphibious auxiliaries,
their structures and enabled extras, with weapon categories, range, reload,
sensors and control/use-case recommendations. Enumeration does not imply that
every special mechanic has been automated or physically verified.

The [complete AngelScript-to-C++ trace](sea-native-trace.md) identifies event,
scheduler, production, targeting, movement, repair, support and placement
ownership. New behavior is selected by SEA alone. AIR/TECH/TACTICAL role source,
the shared TACTICAL naval-constructor ladder and the entire profile/config tree
match the pinned pre-D-189 data. Native additions are explicit script APIs;
original native fleet movement and formation code is retained.

## Implemented and measured

- Current known-contact sampling once per simulation second; actual target-layer
  weapon checks; pending-aware counter deficits and construction-time scoring.
  Submarine/air emergencies precede discretionary build power after the recovery
  workforce exists. No hidden-unit queries or per-frame all-pairs micro loop.
- Funded workforce admissions no longer double-reserve pinned building costs.
  Actual naval constructors supply mobile economy capacity; commander assistance
  counts only where it is doing work. A designated safe mex worker and bounded
  assistance on capital frames preserve expansion and use existing power.
- A fleet screen precedes temporary T2 saving. Immediate counter deficits
  interrupt saving. The T2 package checks metal and energy income/bank capacity.
- Legion attached drones yield command ownership to the game's carrier gadget.
  A passive task issues no movement, idle, damage or move-failed commands. Host
  ownership removal returns surviving drones to normal AI task selection.
- Missing Legion advanced-yard native metadata is explicitly registered by SEA.
  Hard/terrible omit that table; balanced already has it. Existing definitions
  are preserved. Actual build options are used, without editing global JSON.
  Registration runs before construction and before layout activation.
- Armada's hybrid scout/AA boats leave scouting for the existing native AA
  task during observed raids. Already-correct AA, retreat and human tasks are
  preserved; death/transfer clears responder IDs. Global UnitDef roles remain
  unchanged. See the separately versioned air-defense results below.

## Rejected experiments

Blanket maximum-range formations, a conditional range variant, broad equivalent
order reuse and attack-only reuse reduced some orders but lost surface fixtures
that controls won. All were removed. These results do not justify an APM cap
or a shared movement change. Original failures remain in the
[immutable benchmark index](benchmarks/index/sea.md).

## Supplied combat regression cohort

Pinned game: `Beyond All Reason test-31479-433a460`; engine
`recoil_2026.07.04`; engine and AI seed 1891. Every ordinary case supplies its
forces and freezes production; response cases supply economy and permit real
production. Both sides use the selected policy in each match. This is a paired
regression experiment, **not candidate-versus-control win rate**.

Initial build-5 cohort, eight game minutes. Loss columns are team 0 / team 1
metal lost. Peak commands are per-unit engine callbacks per game minute.

| Case | Control loss | Candidate loss | Control / candidate peak commands, team 0 | Interpretation |
| --- | ---: | ---: | ---: | --- |
| Surface line | 4,400 / 6,050 | 4,400 / 6,050 | 453 / 547 | Equal loss outcome; no improvement claim |
| Submarine screen | 1,760 / 4,800 | 1,760 / 4,800 | 518 / 449 | Equal outcome, fewer observed orders |
| Legion destroyers versus hovers | 130 / 3,600 | 130 / 3,600 | 2,393 / 2,482 | Revealed carrier/AI contention; later isolated below |
| Air cover | 880 / 4,920 | 1,890 / 4,920 | 500 / 441 | Worse preservation despite fewer orders |
| Water static siege | 1,760 / 1,260 | 880 / 1,260 | 486 / 491 | Better preservation in this run; not a dry-shore test |
| Production versus submarine overwhelm | 29,330 / 4,800 | 29,390 / 2,480 | 186 / 187 | Harbor lost; selected counter did not complete in time |
| 64 versus 64 destroyers | 56,320 / 24,290 | 56,320 / 21,410 | 4,409 / 3,514 | Both tested fleets lost; candidate inflicted less damage value |

The supplied supported-harbor follow-up added six active construction turrets.
Twelve submarines and eight T2 torpedo bombers still overwhelmed the base.
Submarine losses were 30,895 / 6,540 control versus 31,930 / 5,800 candidate;
air losses 30,830 / 160 versus 29,890 / 1,390. A later half-value underwater
coverage weight for hybrid T1 destroyers selected actual submarines and reduced
own loss to 27,240, but killed only 3,480: it did not turn this into a successful
defense. Limited-raid cases retain separate names/results and do not replace
these harder fixtures. The final four-submarine limited raid lost 440 / 2,480
metal in the control versus 2,170 / 2,480 in the candidate. The three-bomber
limited raid lost 17,010 / 1,390 versus 24,910 / 1,390. Both fleets eliminated
the injected raid, but candidate preservation regressed. Existing commanders
and sensors also remain in these supplied games; loss totals are not solely
injected raid hulls.

### Hybrid scout/AA follow-up

The preceding limited-air numbers predate the scout-to-AA task correction.
The hard-profile prototype lost **0 / 1,390** metal, versus **24,910 / 1,390**
before that correction, with peak team-0 callbacks **475 versus 612**.
The first observed contact to the first AA-boat damaging hit was 13.7 seconds.
This is one paired fixture, not a general zero-loss guarantee.

| Repeat | Loss, team 0 / team 1 | Peak team-0 callbacks | First contact to AA-boat hit | Evidence |
| --- | ---: | ---: | ---: | --- |
| Hard prototype | 0 / 1,390 | 475 | 13.7 s | [record](benchmarks/records/sea/combat/response-air-limite-cand/2026-10-04/20261004T113052Z-c07e597f/README.md) |
| Balanced final lifecycle hooks | 2,640 / 1,390 | 391 | 10.7 s | [record](benchmarks/records/sea/combat/response-air-limite-cand/2026-10-04/20261004T113610Z-2430aece/README.md) |
| Terrible final lifecycle hooks | 1,560 / 1,390 | 413 | 32.2 s | [record](benchmarks/records/sea/combat/response-air-limite-cand/2026-10-04/20261004T114135Z-0407797f/README.md) |

Different-profile rows verify loading/control behavior; they are not
same-profile effect estimates. The hard eight-bomber follow-up lost
24,720 / 3,440 metal: all eight injected bombers died, but only after most
harbor economy was destroyed. It remains a defense failure.

### Fixture correction and remaining yard delay

The original supported fixture froze recovery submarines and let factories
recruit before their supplied constructors finished spawning. The runner now
waits until frame 600 and leaves recovery-submarine tasks active. Original
records remain unchanged; comparisons must use the same harness version.
With the corrected harness, the eight-bomber control lost **29,330 / 570**,
and the candidate **29,360 / 2,870**. The candidate killed seven bombers versus
one in the control; both failed to preserve the harbor. Peak team-0 commands
were 427 / 368. See [control](benchmarks/records/sea/combat/response-air-suppor-ctrl/2026-10-04/20261004T114529Z-d2838082/README.md)
and [candidate](benchmarks/records/sea/combat/response-air-suppor-cand/2026-10-04/20261004T114419Z-26f62aba/README.md).

A diagnostic copy selected `armpt` at frame 961, but the unit was not created
until 3607: **88.2 seconds after selection**. In the repeat with yard-queue
observation, selection at 945 produced the unit at 946. The delayed case is
intermittent and not root-caused; it is not evidence that the threat scan itself
took 88 seconds. The observer now logs idle yards with pending build commands
and nearby mobile units. Four-minute diagnostic runs are not eight-minute
combat comparisons.

## Response latency and production

The threat snapshot runs once per second; factories reconsider at a production
boundary. The current hull is not repeatedly canceled. The initial overwhelm
case observed submarines at frame 2070 and selected its counter at 2353:
9.43 seconds, including completion of existing work. The new hull started at
2378 and the yard died before it finished. **A fast decision is not a delivered
counter.** Unit completion, engagement and losses must pass independently.

The latest production fixture physically verifies a Legion T2 constructor
before one minute and a T2 combat unit before one minute with supplied resources,
on both terrible and balanced profiles. These are registration/production
checks, not natural tech timings. Late role entry with an already-existing
unregistered yard is still KI-234.

## Carrier ownership and APM

Matched six-Legion-destroyer hover fixtures used the revised observer. Both lost
130 metal and destroyed 3,600 metal. First game minute:

| Order source | Control | Passive carrier ownership | Reduction |
| --- | ---: | ---: | ---: |
| Drone non-Lua callbacks | 1,113 | 72 | 93.5% |
| All team non-Lua callbacks | 1,598 | 350 | 78.1% |

The observer also reports Lua gadget orders separately. Non-Lua callbacks are
a useful proxy, **not measured network packets or bytes**. This fix eliminates
competing ownership without delaying urgent orders to ordinary combat ships.

A naturally destroyed host at frame 1459 released drone 11235; its rule was
absent at 1470, it attacked at 1491 and damaged an enemy at 1497. The corrected
forced-destruction case removed six hosts at 2701 and all twelve remaining
drones died at 2702: that proves clean teardown, not surviving-drone release.
An earlier fixture's `destroy` arguments were ignored by the engine; its original
smoke PASS is retained and is not evidence that forced destruction worked.

Large fleets still exceed the requested 3,000-command reference level. We have
not established a CPU/FPS improvement: concurrent games and differing surviving
populations invalidate that comparison. The source review establishes O(E)
contact sampling, O(U + P) economy census and bounded candidate scans, not a
measured runtime guarantee. See KI-232.

## Natural economy

Ordinary resources, zero bonus, AI/engine seed 1881001, thirty game minutes.
The initial five-map cohort compares the preceding D-188 migrated implementation
against build 5; it predates capital assistance, carrier ownership and the Legion
registration correction. Times are minutes:seconds; absent means not completed
in the observed game and must not be treated as zero.

| Map | Control T2 / fusion | Initial candidate T2 / fusion | Observation |
| --- | --- | --- | --- |
| Glacial Gap | 12:47 / 16:50 | 16:05 / absent | Candidate lost its base and hit sharing INV-033 |
| Supreme Isthmus | absent / absent | absent / absent | Both remained below T2 |
| Tundra Continents | absent / absent | 16:15 / 26:52 | Candidate progressed; control hit sharing INV-033 |
| Serene Caldera | 14:10 / 20:04 | 15:38 / 29:14 | Candidate timings regressed |
| Erebos Lakes | absent / absent | absent / absent | No tech milestone claim |

Later Glacial capital assistance reached 11:38 / 16:33, but ended with only
extractor remnants and no production/build power. The scorecard now explicitly
distinguishes an operational base from surviving mexes. A following hybrid
coverage repeat reached 13:29 / 19:08 and remained operational at 30 minutes.

The fixed Legion terrible-profile natural game reached T2 11:55, first T2
constructor 12:35 and naval fusion 18:48 with a working base at 30 minutes.
Before registration, a completed Legion T2 yard produced nothing; later fusion
construction depended on donated Cortex build power.

<!-- FINAL_COHORT -->
Build-7 five-map repeat (before hybrid AA and the rejected builder-travel,
approach-timeout and service-lane experiments):

| Map | T1 yard | First nano | T2 / fusion | Operational at last sample | Evidence |
| --- | --- | --- | --- | --- | --- |
| glacial | 1:03 | 6:24 | 11:04 / 18:08 | yes | [record](benchmarks/records/sea/economy/d189-final/2026-10-04/20261004T111753Z-0edc3c74/README.md) |
| supreme | 1:09 | 9:45 | absent / absent | yes | [record](benchmarks/records/sea/economy/d189-final/2026-10-04/20261004T111702Z-fe132b52/README.md) |
| tundra | 0:37 | 7:12 | 20:00 / absent | yes | [record](benchmarks/records/sea/economy/d189-final/2026-10-04/20261004T112143Z-b10cce9f/README.md) |
| caldera | 1:03 | 9:00 | 22:39 / absent | no; eliminated | [record](benchmarks/records/sea/economy/d189-final/2026-10-04/20261004T112607Z-120592b0/README.md) |
| erebos | 0:52 | 10:37 | absent / absent | yes | [record](benchmarks/records/sea/economy/d189-final/2026-10-04/20261004T112434Z-cf40e493/README.md) |

All five reached the smoke observation window, but Caldera lost the tested base. None establishes all-map acceptance. Tundra held 42 tidals and roughly +702 energy for several minutes while constructors repeatedly changed approaches to two tidal slots. Turning off experimental builder travel in an isolated data copy delayed the opening yard to 2:35 and lost the base before fifteen minutes; that alternative was rejected. The working-tree candidate retains the prior movement flag. A local stuck-work recovery needs a new fixture; no blanket native travel change is justified.
<!-- /FINAL_COHORT -->

The subsequent natural Glacial hybrid-AA repeat reached T2 **12:04**, T2
constructor **12:43**, fusion **18:21**, but ended with no production/build
power. It therefore failed survival acceptance despite a clean smoke report.

Unstarted-work recovery and service-lane follow-ups were **removed** from the
working tree after these results:

| Experiment | Map | T2 / fusion | Outcome |
| --- | --- | --- | --- |
| 60-second no-progress cancellation; 90-second slot exclusion | Tundra | 28:16 / absent | Operational at 30; 18 cancellations; slower than preceding 20:00 T2 |
| Same | Glacial | 12:57 / 18:14 | Operational at 30; no cancellations on tested team |
| Recovery plus 96-elmo economy service gaps | Tundra | absent / absent | Eliminated at 21:30 |
| Same | Glacial | absent / absent | Eliminated at 24:00 |
| Service gaps alone | Tundra | absent / absent | Eliminated at 26:30 |

The native movement flag, original patch geometry and task lifetime are
retained. The underlying Tundra tidal access stall remains KI-235. These are
evidence against the attempted fixes, not proof of a single causal explanation
for every loss. The final retained production/AA code is the version already
tested before these experiments; no all-map final-AA acceptance is claimed.

## Reliability, isolation and outstanding acceptance

- Native integration build and native/AngelScript pure suites passed. Eight
  analyzer tests passed. All three experimental profiles loaded in rendered
  games. API parity, role documentation and invariant checks pass.
- The SEA-off mixed Glacial control hit the existing TECH INV-013. That result
  remains FAIL; it does not establish complete mixed-role runtime isolation.
  Glacial's selected mixed roster did not contain AIR, so it cannot verify AIR
  gameplay. Source/config hashes confirm unchanged non-SEA policy.
- Unit helper checks still report 167 pre-existing findings; documentation
  links retain the eight missing `hover.md` references (KI-404). The storage
  migration audit reports the previously documented D-181 air-build-power check
  change; that file matches HEAD and all historical evidence hashes remain.
- The initial build-7 production watcher falsely reported early engine exit
  because its restricted process query lost visibility. The game continued.
  Its original partial FAIL archive is preserved; corrected full runs use an
  appropriately authorized watcher. Independently, the first registration gate
  used layout activation too early; the successful repeats fix that gate.
- Specialty mechanics still need individual tests: fog/sonar loss, protected
  repair/reclaim/resurrection, actual interception, mines, engineers, optional
  nuclear subs, weapon modes, seaplane landing, disconnected ponds, transfer,
  role switching and engine save/load. Dry-shore siege targeting also needs a
  reachable-water evaluator. No claim that these are all working.

There are 107 published SEA records (including the preceding migration's
records); all published file hashes were verified. Original failures remain.
The four-minute diagnostic log ending with a partial damage line is explicitly
flagged by the analyzer and excluded from totals; its original smoke verdict
is retained. A regression test covers this truncated-log case. All simulation
engine processes had exited at the final check.

Required build output contains the final stripped DLL, matching DBG and all 320
current data files together; their source/output hashes match. The live BAR
install is untouched. Build-7 DLL SHA-256:
`a293daae515d9f77945a095c2e84950177429b6b0da2b32366372bf347c1e28b`.

Continue from [KI-227 through KI-236](known-issues.md) and the
[acceptance matrix](sea-combat-enhancement-plan.md). Keep movement experiments,
supplied tests, natural economy records and original failures distinct. Require
multiple seeds and side swaps before claiming a PvP improvement or enabling the
new SEA controller by default.
