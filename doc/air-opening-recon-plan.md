# AIR opening, compact factories and reconnaissance (D-179)

## Findings and game constraints

AIR currently refuses construction turrets below 250 energy income; its
commander's dedicated post-crew path never asks for one. Production support
therefore arrives late even with banked metal. The first bomber is only a
discretionary mixed-production choice, not a persistent opening batch.

Factory geometry reserves two nano banks beside every lab: four nano columns
separate neighbouring factory footprints. These are future support slots, not
an aircraft exit requirement. AIR can instead use touching factory rows with
dense support rows behind each factory. TECH's ground exit geometry must stay
unchanged. Explicit support-slot ownership must precede nearest-lab assignment
so the rear bank is not incorrectly credited to the next factory row.

Radar planes currently share a patrol through enemy starts with 160-elmo lanes.
There is no formation-ready gate or distinct straight crossing. Loaded ground
sight is approximately 1,250 elmos, much larger than that separation. Twenty
planes at half-diameter spacing can exceed the map width; use parallel ranks
when needed, shrinking spacing only if map/friendly depth cannot fit the ranks.
Fixed-wing planes circle their positions rather than hovering motionless.

The official [economy guide](https://www.beyondallreason.info/guide/in-depth-look-at-economy)
supports scaling efficient local build power with funded income. The official
[early air guide](https://www.beyondallreason.info/guide/early-air-raids)
supports small bomber raids against vulnerable clustered economy and avoiding
AA. The loaded roster and shared air knowledge confirm that Legion's Mosquito
is a gunship; its T1 aircraft plant has no ordinary bomber. Use a configured
Mosquito opening counterpart rather than inventing a build edge.

## Implementation

1. Add AIR settings for two opening support turrets and their minimum energy
   income (160 by default). After three completed air constructors, prioritize
   funded T1 support before discretionary converters/expansion; recovery and
   requested transports retain priority. Let the commander assist nearby nano
   frames or construct a nano only if its actual build options permit it.
   Existing ongoing work and later twenty-nano T2 expansion gates remain.
2. Add a persistent random T1 opening batch of 1-10 aircraft, configurable
   independently of the existing T2 opening. Require the completed crew and
   opening nanos; retain the fighter floor and resource recovery. Use projected
   bomber counts (including frames and pending orders), replace pre-launch losses,
   and launch the completed opening
   cohort at its drawn size (including one), then retain ordinary later raids.
   Legion counts accepted gunship orders instead. Target economy using the
   existing visibility, payload and escort rules; the random draw does not
   authorize an attack on an unknown target.
3. Change only AIR compound geometry: contiguous factories per row, each with
   twenty individually owned support slots in a dense bank behind it. Keep all
   footprints snapped, non-overlapping, inside the compound and within real
   build reach. Existing saved reservations stay in place. Cache support-slot
   owners by layout revision to avoid repeated nested unit/slot scans.
4. Expose loaded ground LOS radius as a read-only script query. Replace recon's
   common narrow patrol with one shared task and stable member routes. Stage
   at distinct friendly positions facing the enemy; dispatch only when the
   full eligible cohort is assembled. Each plane gets a straight MOVE to a
   corresponding position behind the enemy starts, then nearby-base scouting.
   Do not repeat unchanged orders; clean up dead/returned routes and exclude
   PLAYER-controlled units from both commands and the production quota.

## Verification and preservation

Pure tests cover random range bounds, opening gates, LOS spacing, map capacity,
and support counts. Native geometry tests cover all facings, odd footprints,
non-overlap, touching factory rows, support reach and unchanged TECH geometry.
Run the complete native test script, script API checks and profile compile run.

Rendered tests: a supplied recon cohort on a broad map and a narrower map,
with loss cleanup; manual ownership injection remains follow-up KI-479. A supplied multi-factory cluster with all
support slots; natural AIR openings on normal maps with income/build-power and
first-batch measurements. Capture actual staging/crossing/base screenshots
while the games run. Preserve original pass/fail reports in the categorized
test store. Include a TECH control and keep existing known failures distinct.

Record new invariants and actor ownership, update AIR/API/layout references,
publish a matched DLL/debug/data build to the required build output, and commit
and push the completed changes. Do not alter the live game installation.

## Additional findings during implementation

The local starter often had no initial support pins. `NanoTarget` capped demand
by existing pin count before `RepairSupport` ran: zero pins therefore disabled
repair forever. Demand now uses the role cap; the placement layer repairs a
missing site. After the initial fighter floor, healthy normal-map production
can reserve funding for the two opening turrets before extra constructors or
peacetime aircraft. This reservation requires a viable/free or active support
pin, so physically blocked sites cannot halt production indefinitely. Emergencies,
transports, energy recovery and the metal-map opening retain precedence.

Waiting for all twenty fixed-wing aircraft to be inside their inner assembly
disc on the same frame caused several minutes of avoidable delay. Each plane
must now have visited its own 480-elmo disc and still be within a 960-elmo
holding envelope. This accepts circling without issuing corrective orders.
The planner tries centering the transverse line across the map before reducing
spacing; otherwise Glacial's side-edge start unnecessarily compressed its wall.

## Settings

All live under `Global::RoleSettings::Air` in [global.as](../data/script/src/global.as).

| Setting | Default | Purpose |
| --- | --- | --- |
| `OpeningNanoCount` | 2 | Completed starter support goal, bounded by the T1 support limit (five). |
| `OpeningNanoMinEnergy` | 160 | Sustained energy income for the early support exception; bank/commitment checks still apply. |
| `T1OpeningRaidEnabled` | true | Enable the independent first T1 raid batch. |
| `T1OpeningBomberMin` / `T1OpeningBomberMax` | 1 / 10 | Inclusive saved random draw, independent of the T2 opening. |
| `RadarSightOverlap` | 0.5 | Linear overlap of ground-sight diameters. |
| `RadarAssemblyRadius` | 480 | Initial slot visit radius; circling envelope is twice this. |
| `RadarBacklineInset` | 256 | Map-edge inset of each straight crossing endpoint. |

Existing `RadarWaveSize=20` and `RadarWaveIntervalSeconds=600` remain.
The native engine owns motion; a single shared task still requires per-unit
engine orders for distinct positions. This change avoids repeated re-forming,
not the networking cost of every individual unit command.

## Verification (2026-10-03)

Built and tested against the installed BAR test-31479-433a460 game and Recoil
2026.07.04. DLL short SHA-256: `7be8085c281c3a0f`. Complete native tests passed,
including TECH geometry; all 303 pure AngelScript policy tests passed. The 66
playtest tooling tests passed. API/binary parity passed. These are capability
checks and short natural runs, not an 8v8 win-rate or FPS benchmark.

| Scenario | Observed behavior | Strict full-run result |
| --- | --- | --- |
| Supreme, Cortex, 15-minute natural AIR/TECH game | First two nanos at 6.60/6.82 minutes; saved draw two; two bombers and six escorts dispatched at 7.27 minutes. | FAIL: TECH INV-008 reclaim-assistance reports. |
| Glacial, Armada, 18-minute natural AIR/TECH game | Nanos at 6.51/6.82; one opening bomber ordered at 6.87; T2 air lab completed 13.90. No T1 dispatch observed before the run ended. | FAIL: TECH INV-028/021/008/010; no AIR/script crash. |
| Glitters, Legion, 15-minute natural AIR/TECH game | Nanos at 6.76/6.92; one Mosquito opening order at 6.94. | FAIL: existing ferry INV-052. |
| Glacial supplied recon, final | Twenty at 1,275-elmo pitch (50% overlap), six columns; synchronized MOVE at 1:28; all twenty surveying by 2:36. | [PASS](benchmarks/records/air/combat/recon-d179-centered/2026-10-03/20261003T151752Z-6be08fde/README.md). |
| Supreme supplied recon and physical cluster, final | Twenty at 1,125-elmo pitch (55% overlap), eleven columns; MOVE at 1:29; all twenty surveying by 2:36. Six T2 labs and 120 nanos, exactly twenty credited to each. | [PASS](benchmarks/records/air/combat/recon-d179-centered/2026-10-03/20261003T151753Z-093b24ce/README.md). |

Earlier iterations are retained: the fixture's unconditional freeze produced
an unreachable-code warning and failed compilation ([original FAIL](benchmarks/records/air/combat/recon-d179/2026-10-03/20261003T145857Z-25a42eb3/README.md));
an armed-commander Glacial fixture dispatched all twenty, but losses prevented
the thirty-second sample from observing all twenty surveying together
([original FAIL](benchmarks/records/air/combat/recon-d179-final/2026-10-03/20261003T151316Z-5d2874ef/README.md)).
Final route fixtures use passive commanders to isolate geometry and task
transitions. They supply aircraft/factories and do not demonstrate economic
timings, enemy-AA penetration or combat strength.

Natural raw archives remain under `build-theatres/games/air/economy/`:
`opening-d179-v3/supreme/20261003T150435Z-ef1e3e25/supreme/runs/20261003T150853Z-2f20cc89`,
`opening-d179-final/glacial/20261003T150905Z-b04b1291/glacial/runs/20261003T151254Z-cced57e4`,
and `opening-d179-final/glitters/20261003T151145Z-304f3d0d/glitters/runs/20261003T151449Z-3b1cd401`.
Their original verdicts and metadata were not rewritten. The natural runner
now carries an allocated parent's category into its nested map directory for
future publication. KI-472 retains the pre-existing TECH/ferry failures;
KI-479 retains manual-takeover verification; KI-485 records the unobserved
single-bomber Glacial dispatch. No claim that these issues are fixed.

Run the focused fixture with [prepare_air_recon_check.py](../tools/playtest/prepare_air_recon_check.py),
then `playtest.py launch` and `watch --checks air_recon --minutes 8`.
Add `--clusters` for supplied six-lab/120-nano geometry evidence. Existing
supplied T1 arenas explicitly disable the new economy-opening gate in their
isolated data because their builders/factories are frozen.

The existing Armada `t1-economy` supplied arena was repeated for six minutes:
three actual bomber launches, two completed sorties and one unfinished sortie;
the strict script/invariant/fixture checks [passed](benchmarks/records/air/combat/t1-economy/2026-10-03/20261003T152405Z-a76cb112/README.md).
This preserves the earlier combat benchmark's meaning by disabling only the
new economy-opening gate in the supplied fixture.

Final static checks: role markers, invariant register, Python compilation and
API/binary parity pass. The documentation checker retains the eight pre-existing
missing-hover links (KI-404); the unit helper checker retains 165 unknown map
hover-factory references plus two unreachable sonar references (KI-481 and the
existing TECH catalog findings). No new AIR unit-reference finding was introduced.
The matched stripped DLL, debug symbols and all 312 active data files were
published to the engine build-output `BARb/stable` directory and hash verified.
