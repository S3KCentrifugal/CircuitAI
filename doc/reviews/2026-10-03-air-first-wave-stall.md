# AIR first Phoenix wave: launch gates and starvation investigation

Date: 2026-10-03. Source revision: `8854e90cc2f4eced794674d8a0d38b75d815685c`.
Status: investigation; no gameplay change or new simulation. Related records:
[D-183](../decisions.md#d-183---investigate-first-bomber-wave-starvation-without-waiving-launch-budgets),
[KI-493](../known-issues.md#ki-493---air-can-starve-the-last-bombers-needed-for-its-opening-raid),
[KI-494](../known-issues.md#ki-494---air-no-target-message-does-not-request-reconnaissance).

## Finding

A local Supreme Isthmus v1.7 game matches the reported symptom: Legion AIR
held 18 Phoenixes, while its saved first economy-wave size was **20**. Logs
show 18 held bombers at 19:06 and through 36:36; the first launch was at
38:48 with 20 bombers and 164 fighters. The owner has not yet confirmed that
this is the particular match they reported.

The opening quota can be starved by production decisions. The launch planner
requires the complete randomly drawn quota for an opening economy raid, but
the production chooser has no corresponding allocation to finish a nearly
complete first wave. It can prioritize air control, workforce, reconnaissance
and other aircraft for an unbounded period. Bombers waiting for admission
are explicitly allowed to land and are set to hold fire.

This is a confirmed policy interaction and an observed long delay, not proof
of every transient launch veto in this game. The existing logs omit several
veto reasons. In particular, having 18 rather than 20 rules out the first
economy raid, but does not by itself explain why no defensive or frontline
operation qualified during the same interval.

## Actual launch conditions

The experimental controller in [air_waves.as](../../data/script/src/manager/air_waves.as)
runs from AIR's one-second update and attempts planning at most once every
ten game seconds. It requires all of the following:

1. No living previous wave, and no outstanding evaluation of that wave.
2. At least three held bombers to attempt planning. This is a planning floor,
   not the normal offensive opening size.
3. A qualifying known target and an affordable route/payload estimate from
   [AirWaveTask.cpp](../../src/circuit/task/fighter/AirWaveTask.cpp).
   Hidden contacts are excluded. Threat, route resistance and unknown-threat
   reserves can make a known target unaffordable.
4. Enough bombers for the selected mission, using
   [AirMath::OperationSize](../../data/script/src/helpers/air_math.as):
   the first economy raid uses the saved random size, normally 10-20;
   a defensive response uses its calculated requirement with a floor of three;
   a frontline fallback uses the available pool if its payload is sufficient.
   An underfunded nearby heavy-unit defensive response can also hold the pool
   before the offensive branch is considered.
5. Enough available fighters in the home pool. Default escort demand scales
   from zero below 300 observed enemy air metal-value to one fighter per bomber
   at 3,000. Once admitted, the operation attaches all available fighters.

The opening size is drawn once and saved as `air.firstBomberSize`.
The configurable bounds are `FirstBomberWaveMin` and `FirstBomberWaveMax`
in [global.as](../../data/script/src/global.as). An observed count of 18
does not reveal what was drawn.

The experimental branch returns before the old `BomberWaveMaxHoldSeconds`
logic. There is **no elapsed-time release/recovery rule for an experimental
held wave**. Even the legacy timeout only waives the escort requirement;
it does not waive the bomber floor. Changing that old setting cannot solve
this experimental stall.

Two AFUS are not a launch prerequisite. Sustainable metal/energy metrics in
[AirEconomy::MassBombers](../../data/script/src/manager/air_economy.as)
govern further T2 bomber recruitment, separately from launch admission.
After admission, the native operation still assembles bombers and escorts
before ingress; a launch log is not proof of a completed bombing pass.

## Why production can leave the wave unfinished

[AirProduction](../../data/script/src/manager/air_production.as) checks funded
workforce, immediate interception, economic recovery and a dedicated
fighter/radar factory before ordinary bomber production. Heavy gunships
may also precede the bomber row. `AirMath::BomberOrders` returns zero when
observed enemy air value exceeds available friendly fighter value, even
by a small amount. An immediate air emergency also sets this allocation to
zero. Bomber orders otherwise receive a share of each factory's sequence.

There is no rule protecting the last two orders of an 18/20 opening from
these competing decisions. `ProductionTarget()` being at least the opening
quota is insufficient: the factory must reach and pass the bomber row first.

In the matching game's interval from frame 34383 through just before frame
68428, there were 444 `air.control legvenator`, 96 `recon.wave legwhisper`,
79 `constructor.expand`, 39 `dedicated.fighter`, 28 `constructor.screen`,
23 `intercept`, ten `heavy legfort` and one `front.support` recruit log events,
with no `wave.bomber` event. These are order events, not completed-unit counts.
The log does not record the contemporaneous fighter-value comparison or all
production predicates, so it cannot prove which veto caused each decision.

## Retained evidence

Read-only source: the local installed game's `data/infolog.txt`, inspected
2026-10-03; 21,220,050 bytes; SHA-256
`56f33e22d3f0587c66531a03be1f92e8f8dbb779fa8b677106cb02cace04fc89`.
The file includes more than one match. These excerpts belong to the first
Supreme match, AI 3/team 11, Legion AIR. Replay named in its header:
`2026-10-03_21-29-49-212_Supreme Isthmus v1.7_2026.07.04.sdfz`.
Game times below use frame / 30, not the process wall-clock prefix.

| Log line | Frame | Game time | Evidence |
| --- | ---: | --- | --- |
| 10591 | 21252 | 11:48 | `[AIR][Waves] opening size drawn=20` |
| 13487 | 34383 | 19:06 | `home=26 target=60 heldBombers=18 escorts=0 wave=0 enemyAir=6040` |
| 17448 | 43383 | 24:06 | `home=19 target=60 heldBombers=18 escorts=0 wave=0 enemyAir=5505` |
| 34755 | 56883 | 31:36 | `home=66 target=60 heldBombers=18 escorts=0 wave=0 enemyAir=33600` |
| 58594 | 65883 | 36:36 | `home=94 target=60 heldBombers=18 escorts=0 wave=0 enemyAir=18208` |
| 60805 | 68428 | 38:00 | `wave.bomber legphoenix ... projected=19/19` |
| 60814 | 68436 | 38:01 | `wave.bomber legphoenix ... projected=20/20` |
| 62219 | 69843 | 38:48 | `planned strike target=31301 bombers=20 required=2 ... mission=economy` |
| 62220 | 69843 | 38:48 | `Wave 1 launched ... bombers=20 fighters=164` |

`escorts=0` in these snapshots is the separate held-fighter collection, not
the experimental home fighter pool; it does not establish absence of escorts.
The snapshot's `target=60` is a home-fighter target, not the bomber quota.

Currently installed `air_waves.as`, `air_production.as` and `global.as` match
the repository after newline normalization. This is not a historical DLL or
script pin for the match; the log's explicit draw and counts are the direct
evidence. Only relevant AI excerpts are retained here, not player chat.

## Additional diagnosed gap

The no-feasible-target branch logs `request fresh reconnaissance`, but issues
no reconnaissance request. The periodic radar/scout system runs independently.
Native search of remembered positions belongs to already-launched operations;
it does not make a targetless held wave depart. This can prolong a different
stall under fog of war. It is not proven to have caused the matching game's
18-bomber interval.

## Targeted remediation and verification

Keep the configurable opening quota and target/AA budget. Give production and
launch one explicit readiness record: held, in production, required, escort
shortfall, target/route result, and time blocked. Emit a diagnostic only when
the reason changes, with a slow summary; this adds no aircraft commands.

Add a bounded, economically funded allocation to complete an almost-ready
opening at eligible bomber factories. Preserve immediate interception, the
dedicated fighter/radar factory and essential workforce funding. This needs
an explicit definition of near-ready, an order share and a severe-air-danger
exception; do not silently give bombers absolute priority over defense.
Use a configurable excessive-wait threshold to trigger replanning and actual
scouting, rather than blindly waiving payload, AA or escort constraints.

Connect a targetless ready wave to the existing reconnaissance controller
with deduplication and normal affordability checks. Test lack of vision
separately from insufficient payload and genuine route denial.

Verification should include an 18/20 pool under slightly inferior friendly
fighter value, sufficient/insufficient escorts, a real air intrusion, and a
hidden then revealed economy target. Log both the factory's choices and
launch-block reason. Watch physical assembly, ingress and weapon damage;
then run a natural Supreme regression. Preserve all-fighter commitment once
an offensive wave launches, per the owner's existing policy.

Current checks: all **113** existing `air_math_tests.as` tests pass. Six scratch
AngelScript probes also pass: 18/20 economy held despite a payload requirement
of two; 20/20 admitted; an opening draw of 18 admitted with 18; frontline 18
admitted; defense six admitted from 18; and fighter value 6000 versus enemy
6040 yielding zero bomber orders. These establish current policy, not a fix
or new in-game verification. The scratch probe is outside tracked sources.
