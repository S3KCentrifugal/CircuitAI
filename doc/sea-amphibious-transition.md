# SEA: secured-water amphibious invasion

Implementation and evidence, D-212. Scope: experimental SEA only. TECH/AIR amphibious
controllers, ordinary naval attack, recovery, carrier and player ownership stay
independent.

1. Prove control from legal observations: every sampled cell of the connected
   sea must have recent LOS and sonar, no current hostile or unresolved last-known
   static, and a 30-second quiet interval. Assignment of a scout patrol is not
   observation. Unknown sonar contacts and unfinished enemy structures block the
   transition. Restart proof after load; never infer knowledge from spectator data.
2. Keep scouts covering stale cells. Sample the existing 64-elmo water grid at
   most once per five seconds, retaining timestamps; no per-unit map rescans or
   worker-thread engine calls. Expose generic observation mechanisms to script.
3. Select a reachable enemy-facing beach and an offshore staging site, avoiding
   known weapon ranges plus clearance. Reserve factory footprints/exits and
   reachable construction-turret pads using the existing layout engine. Do not
   change normal base placement or claim allies' reserved economic space.
4. Move ordinary surface/sub cohorts into a dispersed ship screen. Preserve
   scout/AA duties and immediate naval response. Require actual nearby cover,
   not just an issued escort order, before admitting construction.
5. Build one amphibious complex, support it, then admit an underwater gantry
   after the complex is complete and sustained income/budget can fund it.
   The previous funded seaplane transition retains its place. Retain existing
   resource forecasting and queue-aware commitments; do not make an early gantry
   spend the navy's recovery budget.
6. Produce faction-appropriate amphibians through verified effective factory
   edges. Form separate movement-definition cohorts, release by size or timeout,
   travel on validated ground/amphibious routes, and prefer known backline economy.
   Once ashore, use dry routes where possible and retain a dry landing fallback.
7. Tests: pure gates, native observation-history tests, all experimental profile
   compilation, supplied Supreme transition/invasion, hostile return, stale/partial
   coverage rejection, and faction factory/production validation. Preserve failures
   and screenshots. Report supplied tests separately from natural economy proof.

Research: [official sea warfare guide](https://www.beyondallreason.info/guide/basics-on-sea-warfare)
and [Marauder](https://www.beyondallreason.info/unit/armmar), checked against local
BAR build menus and the shared unit knowledge base. These support exploiting
cleared water for amphibious flanks and keeping naval protection; the numeric
thresholds below are AI policy choices, not claimed universal PvP rules.

Initial tuning: 10-minute survey freshness, 30-second quiet period, 1,500 metal
of nearby combat escort, 640-elmo offshore staging, complex at sustained
60 metal/s and 1,200 energy/s, gantry at 150 metal/s and 5,000 energy/s, with
two-resource funding/reserves. Six initial turrets at the complex, twelve at the
gantry, then existing income/workload support scaling. Six amphibians per wave
or a 90-second fallback. All live in SEA settings.

## Implemented ownership and ordering

`SeaInvasion` owns the forward factories and amphibious cohorts. Existing
`SeaOperations` owns the ship screen and can interrupt it for compatible naval
targets. `SeaPatrol` retains scouting/AA ownership, but uses actual stale survey
cells when choosing the next scout patrol. A missing sensor observation never
counts as a visit. Invasion builders preserve active construction, retreat,
player control and enemy reclaim; the first construction ship still takes nearby
mexes before discretionary work.

The script asks generic native APIs for water coverage, stale scout destinations
and known enemy count. Coverage requires simultaneous surface LOS and submerged
sonar; radar alone cannot certify a sea. Enemy structures remembered outside LOS
continue blocking control until their positional memory is invalidated. The
numeric proof is 100% of the existing 64-elmo water samples, not every point
between samples. It cannot guarantee that a unit has not moved back through an
older surveyed area.

The lab and gantry use persistent shared layout reservations, including empty
exit corridors. The gantry searches twelve flank/seaward alternatives in batches
of four, once per thirty seconds. Both positions must pass threat/range checks
and actual amphibious movement-definition paths to the landing. Support pads
are reserved before admission. Six completed turrets within reach of the complex
are required before starting the gantry; its twelve-turret footprint must fit.
Small coastal patches fall back to individual reachable pads, retaining progress.
Missing, exhausted or blocked untouched slots are replanned; claimed slots and
started frames retain their lifecycle owner. Loss of surveyed control or local
escort cancels unframed invasion factories, rather than abandoning sunk metal in
an existing frame.

| Faction | Amphibious complex product | Underwater gantry product |
| --- | --- | --- |
| Armada | `armcroc` | `armmar` |
| Cortex | `corsala` | `corshiva` |
| Legion | `legamphtank` | `legjav` |

These are verified effective build edges in the pinned game, not new shared
UnitDef classifications. Cohorts use one exact unit definition each; other
factions/roles retain their existing production and amphibious controllers.
Units clear the factory exit before assembling, travel to a validated landing,
then fight toward known dry enemy economy. Map start hypotheses are fallback
objectives, never treated as observations of hidden enemies.

## Cost and maintenance contract

- Native survey storage is allocated lazily on the first survey request. Other
  roles using water analysis incur no new survey storage or update loop.
- Refresh and coverage are O(W), where W is the sampled cells in the requested
  connected sea. Refresh runs at most every five seconds using cached ally sensor
  maps. Enemy counting is O(E) in legal remembered contacts. No engine callbacks
  run on a worker thread.
- Each renewing scout can make an O(W) stale-cell search. It does not rescan all
  ships, query per-cell engine wrappers, or mutate the shared random stream.
- Beach placement is capped at four candidates per five-second update; gantry
  placement at four per thirty seconds. Wave path searches are capped at two per
  five-second update. Failed paths retry after fifteen seconds; unchanged reached
  backline objectives are not resent until the ninety-second renewal.
- Escort/turret counts inspect the compact SEA-owned roster. Persistent native
  reservations preserve allied exclusions. These bounds are a complexity review,
  not a measured whole-game FPS or multiplayer APM claim.
- The generic per-second production-factory planner skips the two actual pinned
  invasion factories through O(1) reservation identity lookups. Their coastal
  6/12-pad planner already owns the space; the generic 24-pad rectangle repeatedly
  failed around the same coast. Ordinary/donated amphibious factories and the
  existing income-based support construction remain on their prior paths.

## Verification method and limits

The supplied fixtures use Supreme Isthmus v1.7, Recoil `2026.07.04`, BAR
`test-31479-433a460`, seed 2121 and the experimental balanced profile. They supply
economy, workers and navy; freeze non-invasion factories and the opposing AI;
then add real stationary sensor aircraft after first checking incomplete survey
rejection. There is no `globallos`. Only the observer inspects spectator data.
The AI chooses, builds, supports, escorts, produces and commands the invasion.
The negative fixture also holds the friendly navy so its enemy submarine remains
alive. Exact overrides and script/DLL hashes are retained in `invasion-pins.json`
beside each immutable result.

The final DLL is `f224e17dc3c6f798` (SHA-256 prefix). Eighteen actual-VM SEA
policy tests pass, including resource/escort gates and invalid-slot lifecycle
cases. Nine native observation-history assertions pass. All three experimental
profile mains compile with the interface checker; the played balanced-profile
games verify the real embedded VM and bindings. Standalone interface warnings
about stub template callbacks are harness limitations, not runtime script
warnings. API parity and invariant/role-document checks pass.

The results below distinguish supplied mechanism verification from natural
economy timing, competitive match strength, save/load and multiplayer performance;
those broader claims have not been established by these fixtures.

Reproduce, serially, from the repository root:

```powershell
python tools/playtest/run_sea_invasion.py --dll <pinned.dll> --side armada
python tools/playtest/run_sea_invasion.py --dll <pinned.dll> --side cortex
python tools/playtest/run_sea_invasion.py --dll <pinned.dll> --side legion
python tools/playtest/run_sea_invasion.py --dll <pinned.dll> --blocked --minutes 5
```

Earlier positive runs used `z<5000` as a backline assertion, too close to the
landing. They establish the original factory/landing/damage checks, but are not
proof of a gantry unit reaching deep inland. Final repeats require dry
`x>9500, z<3500`, log the actual coordinates and capture the first gantry arrival.
The final fallback also prefers a backline start category before distance, so a
cleared frontline hypothesis cannot indefinitely attract the army. The earlier
Legion positive predates both this correction and the missing/exhausted-slot
recovery guard. Every original verdict and source pin is retained.

## Validation caveats

The unit-helper checker reports 170 existing findings: obsolete floating-hover
IDs in map configurations and static sonars (KI-481/KI-473). No new invasion
product appears in those findings; actual effective build menus and production
are recorded by the game observer. The documentation link checker retains eight
existing missing `roles/hover.md` links (KI-404). New D-212 links resolve.

One full regression run hit an AngelScript reference-count assertion in the
unchanged TECH weapon-work differential fixture. The exact isolated repeat
passed both tests. KI-518 retains the unresolved intermittent harness issue;
neither TECH policy nor the vendor runtime was modified. The first full log and
the repeated full-suite result are preserved with the final validation evidence.

Concurrent rendered attempts also exposed host resource pressure (KI-517).
Final games run serially. The original allocation failure and a separate
image-library crash remain failures; the latter's connection to memory pressure
is an inference, not a diagnosed CircuitAI crash.

## Final outcome and measured limits

The strict Armada and Cortex runs passed 11 checks each. Legion passed all
13 final checks both before and after the support-ownership cleanup: incomplete
survey rejection, both factories and products, actual escort, six/twelve
completed turrets within build range, landing, inland arrival and economic
damage. The live-submarine negative test also passed with 100% coverage and one
known enemy keeping control false.

In the final Legion supplied repeat, the complex completed at 5.8 minutes,
gantry at 9.0, gantry support reached twelve at 9.8, and gantry units entered
the inland region at 12.2. These are component-fixture timings, not an economy
benchmark. The full native regression runner passed on repeat; its initial
intermittent assertion is retained in
[validation evidence](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/amphib-transition-legion/2026-10-06/20261006T040105Z-b4c1a40a/regression-validation.json).

The final source removes duplicate *ownership* of support preplanning. It does
**not have a demonstrated aggregate performance gain**: the two Legion runs
both logged 120 coastal turret-reservation creations and zero served reservations
during game minutes 18–24 in x=[7600,9600], z=[4800,6600]. See the
[exact counts](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/amphib-transition-legion/2026-10-06/20261006T040105Z-b4c1a40a/reservation-events.json).
This counter combines callers and counts successful temporary reservations, not
failed placement probes or CPU time. It therefore cannot establish which caller
dominates the remaining work. No FPS, APM or network gain is claimed (KI-519).

The final Legion repeat includes the support-ownership and escort-lifecycle
follow-ups; the strict Armada/Cortex results precede those shared SEA follow-ups.
All three profiles compile with the final source. Dedicated save/load,
blocked-site relocation and hostile-return interruption scenarios remain future
coverage; current evidence establishes the normal transition and occupied-water
gate rather than those lifecycle claims.

<!-- D212-RUNS-BEGIN -->
## Preserved simulation history

Times are game minutes in supplied fixtures. A dash means not observed; a PASS applies only to that archive's original checks. Each record retains its exact DLL/script/widget pins and raw-evidence hashes.

| Game | Verdict | Complex / gantry complete | First / gantry inland | Interpretation |
| --- | --- | --- | --- | --- |
| [20261006T024608Z-ce226d4a](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/amphib-blocked-armada/2026-10-06/20261006T024804Z-dbebb807/README.md) | PASS | - / - | not a strict inland check | INVALID PASS: enemy died; old observer mishandled nil liveness. |
| [20261006T025930Z-74096888](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/amphib-blocked-armada/2026-10-06/20261006T030115Z-63b9c6e5/README.md) | FAIL | - / - | not a strict inland check | Engine allocation failure during concurrent startup; KI-517. |
| [20261006T031556Z-3f2eafe0](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/amphib-blocked-armada/2026-10-06/20261006T031805Z-727ff9f0/README.md) | FAIL | - / - | not a strict inland check | Negative fixture generated unreachable script code; corrected and repeated. |
| [20261006T031858Z-6496d215](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/amphib-blocked-armada/2026-10-06/20261006T032038Z-ae6637e1/README.md) | PASS | - / - | not a strict inland check | Complete coverage plus live enemy contact kept invasion blocked. |
| [20261006T021357Z-51c21f10](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/amphib-transition-armada/2026-10-06/20261006T021539Z-67b8fe83/README.md) | FAIL | - / - | not a strict inland check | Startup failed with insufficient disk space; no gameplay proof. |
| [20261006T021903Z-09b858d6](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/amphib-transition-armada/2026-10-06/20261006T022058Z-5ff2119e/README.md) | FAIL | - / - | not a strict inland check | Invalid fixture: unsupported wait task and incorrect unit ID. |
| [20261006T022114Z-0d29c1c7](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/amphib-transition-armada/2026-10-06/20261006T022655Z-9a08a903/README.md) | FAIL | 5.5 / - | not a strict inland check | Complex and landing worked; single-point gantry placement failed. |
| [20261006T023413Z-faeead2f](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/amphib-transition-armada/2026-10-06/20261006T023922Z-dbfc2e50/README.md) | PASS | 6.0 / 11.9 | not a strict inland check | Earlier Armada checks; before strict inland assertion. |
| [20261006T025847Z-dda77ab8](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/amphib-transition-armada/2026-10-06/20261006T030038Z-263c2f7d/README.md) | FAIL | - / - | not a strict inland check | Engine image-library crash; no AI stack frame; KI-517. |
| [20261006T032315Z-fe30536c](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/amphib-transition-armada/2026-10-06/20261006T032945Z-45c633a2/README.md) | PASS | 5.9 / 11.4 | not a strict inland check | Armada full chain and economic damage; older coast-based backline assertion. |
| [20261006T033805Z-86e6a22b](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/amphib-transition-armada/2026-10-06/20261006T034506Z-e532b320/README.md) | PASS | 6.5 / 12.3 | 11.0 / 15.0 | Strict inland backline and economic damage; 11 checks. |
| [20261006T023734Z-380e3378](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/amphib-transition-cortex/2026-10-06/20261006T024241Z-f6091b07/README.md) | PASS | 7.0 / 16.2 | not a strict inland check | Earlier Cortex checks; before strict inland assertion. |
| [20261006T033053Z-612b7bab](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/amphib-transition-cortex/2026-10-06/20261006T033742Z-f915a230/README.md) | PASS | 5.9 / 11.4 | 9.3 / 15.2 | Strict inland backline and economic damage; 11 checks. |
| [20261006T024016Z-daa2f297](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/amphib-transition-legion/2026-10-06/20261006T024507Z-2c49a9c7/README.md) | FAIL | - / - | not a strict inland check | Legion coastal support footprint failed; no factory. |
| [20261006T024527Z-b0472b16](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/amphib-transition-legion/2026-10-06/20261006T025145Z-d7f24cad/README.md) | FAIL | - / - | not a strict inland check | Confirmed that full support rectangle and original gantry points did not fit. |
| [20261006T025705Z-a987c843](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/amphib-transition-legion/2026-10-06/20261006T030413Z-7e695aaf/README.md) | FAIL | 5.5 / - | not a strict inland check | Small support patches fixed the complex/landing; four gantry alternatives still failed. |
| [20261006T030724Z-211681ba](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/amphib-transition-legion/2026-10-06/20261006T031432Z-edbf1d89/README.md) | PASS | 5.3 / 10.9 | not a strict inland check | Legion full chain and economic damage; older coast-based backline assertion. |
| [20261006T034555Z-6a426aa3](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/amphib-transition-legion/2026-10-06/20261006T035345Z-639013c7/README.md) | PASS | 5.9 / 11.5 | 9.5 / 15.7 | Strict inland checks plus independent completed-turret counts; before duplicate planning removal. |
| [20261006T035428Z-fec16459](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/amphib-transition-legion/2026-10-06/20261006T040105Z-b4c1a40a/README.md) | PASS | 5.8 / 9.0 | 8.8 / 12.2 | Final repeat after removing duplicate support preplanning; strict checks and completed-turret counts. |

<!-- D212-RUNS-END -->
