# D-153 validation: allied layouts and AIR income progression

2026-09-30. [Design](allied-layout-air-income-plan.md). Changes are confined to
active `data/`, native placement mechanisms, tests and documentation. No live
BAR installation is modified. The commit remains local at the owner's request.

## Build and executable checks

The final stripped DLL is `build-theatres/air/d153-build-03/SkirmishAI.dll`,
SHA-256 prefix **fcc2c7ea532f9ef3**, 7,589,530 bytes, with matching `.dbg`.
It was built through the repository's pinned Recoil Windows cross-build image.
The experimental_hard shared policy graph compiles against it in the simulations.
The API checker confirms all 248 used members in that DLL.

Published to `C:/bardev/bar-RecoilEngine/build-amd64-windows/install/AI/Skirmish/BARb/stable`:
the final DLL, matching symbols (SHA-256 prefix `81429e0bdf646824`) and all 237
current `data/` files. Hash comparison reports zero data mismatches; API parity
also passes against the published DLL. Test-only probes stay in isolated run
directories and are not part of the published policy.

- 93 executable AngelScript policy tests pass, including the exact +50 boundary,
  incomplete-window rejection, full-cost bank override, and bounded strike targets.
- 11 native allied-index cases pass: cross-owner overlap, own nesting, touching
  edges, bucket boundaries, replacement, independent release, owner removal,
  invalid rectangles and dense queries against a simple reference scan.
- Existing base-layout geometry tests and 76 layout-ranking checks pass.

The native tests use the production header; policy tests execute the actual
AngelScript helper with the vendored runtime. No mock copies of these functions
are used. Pure tests do not establish engine save/load behavior.

Role-document/source checks, invariant-practice checks and `git diff --check`
pass. The complete document-link checker still reports eight existing links to
the missing hover reference (KI-404); the unit helper checker retains the two
unreachable sonar definitions (KI-425). No new findings were added to either.

## Simulation setup

Serial isolated headless runs use Supreme Isthmus v1.7, Beyond All Reason
`test-31450-6562fb1`, engine `recoil_2026.07.04`, experimental_hard, seed 930146,
no income bonus, and maximum simulation speed 30. Team 0 is AIR, team 1 its
TECH ally; opposing teams are TECH/Cortex and AIR/Legion. Team 0 is Cortex except
the final layout-only Armada run. Each folder retains staged scripts, DLL hash,
start script, team manifest, infolog and strict check report.

All paths below are relative to `build-theatres/air/`. Runs are ignored artifacts
in the workspace; this committed record preserves their identities and outcomes.

| Scenario and retained run | Result and useful evidence |
| --- | --- |
| `d153-layout/runs/20260930-200925` | FAIL. Reciprocal reservation exclusion and TECH relocation worked. An early AIR fixture check ran before its blocker was inserted; TECH also abandoned a partly usable forward box because terrain holes were mistaken for new obstruction. Both corrected. |
| `d153-layout-r2/runs/20260930-201320` | FAIL. No invariants or script errors; TECH relocation/locking and reciprocal exclusion passed. AIR released its blocked plan, but an unrelated speculative-search cooldown delayed replacement. Activation now clears that cooldown for its first replacement attempt. |
| `d153-natural/runs/20260930-201925` | 25.1 minutes, build02 (`b0589eb944ab648c`). All expansion expectations pass; strict report FAIL on TECH invariants. Natural production, transport and income/bank evidence below. |
| `d153-income/runs/20260930-202525` | 18.1 minutes, final native build03. All 28 layout probe assertions pass. T1 combat, full-bank lab and completed lab expectations pass. Report FAIL: TECH invariants and an income-only expectation the fixture did not isolate. That expectation now has its own separate scenario; original report is preserved. |
| `d153-sustained/runs/20260930-202829` | First four minutes of the sustained fixture. All layout expectations pass; strict report FAIL on TECH INV-009 while receiving supplied metal. |
| `d153-sustained/runs/20260930-202947` | Same engine through 12 minutes, final scripts including retry reuse. Income-only order and completed lab expectations pass. Strict report FAIL on six TECH INV-009 lines; all 28 layout assertions pass, no script or AIR invariant failures. |
| `d153-layout-final/runs/20260930-203157` | Armada four-minute regression FAIL. No invariants or script errors; AIR could release its obstructed bay but the old 2,048-elmo search had no replacement after its other future bays were held. Search expanded to a configurable 25 rings (3,072 elmos). AIR probe deadline moved to three minutes because this faction's initial future bay appeared at 1.85 minutes, before the required ten-second obstruction wait. |
| `d153-layout-wide/runs/20260930-203705` | **PASS**, 4.0 minutes, final build03 and scripts. Armada AIR relocation at 1.72 minutes; TECH relocation at 1.17. All reciprocal/active-cluster checks pass, all invariant/script/probe/crash forbids clean. Opposing Legion AIR also relocates successfully. |

## What was observed

**Shared reservations and activation.** Test-only script probes exchange exact
future factory positions through allied messages. Each peer rejects foreign
footprints through both `CanReserveBuilding` and actual reservation admission.
Each owner rejects a wall at its own factory anchor. A Lua fixture then inserts
a physical wall, bypassing AI reservations as external construction can do.
AIR and TECH detect it, release the old plan, reserve a different location and
leave their started/claimed clusters fixed. The physical block, new slot and
old-slot removal are asserted separately. No INV-088 occurs in these games.

Native exclusion also wraps ordinary placement searches and mex/geo command
paths. The probes establish the common admission contract; they do not claim
every native search variant was independently forced in a game.

**Natural AIR economy and production.** The first T2 lab order is at frame
25089 (13.94 minutes), with a ten-second minimum of +44 metal, bank 2,919,
and cost 2,900: the bank exception is active below +50. It completes at 15.38
minutes. Six T2 labs complete by 23.59 minutes. Across 25 minutes AIR completes
62 T1 fighters, two T1 bombers, four Shurikens, ten T1 air constructors,
six T2 air constructors and 27 T2 fighters. These are actual completion events,
not queued intent. The first bomber is ordered at 6.03 minutes and the first
Shuriken at 7.34. These tests do not establish PvP win rate or efficient target
selection; existing [bomber targeting limits](bomber-targeting.md) remain.

**Transport.** The natural allied request arrives at frame 13344. AIR orders its
transport at 13457, finishes it at 13868 and transfers it to TECH at 14220.
TECH subsequently hands AIR's gifted constructor over 127 elmos from its first
mex. Ferry ordering remains ahead of ordinary recruitment.

**Full bank at low income.** The supplied-energy/basic-converter fixture orders
a T2 lab at frame 4201 (2.33 minutes), minimum +28, bank 2,928, cost 2,900. It
completes at 8.94 minutes. T1 fighters complete at 2.07 minutes, Shurikens at
7.78 and bombers at 8.11. The fixture supplies generating assets and later 4,000
resources; these are controlled funding checks, not natural opening timings.

**Income without a full bank.** A separate fixture supplies fusions/converters
and shares excess metal to its TECH ally. At frame 10945 (6.08 minutes), AIR
orders a lab with minimum +116, a full fresh window, bank 1,402 and cost 2,900,
logging `reason=income`. The lab completes at 8.79 minutes. Sharing does not
keep the bank low after the receiving ally fills; later orders use the full-bank
path. Only the first order is evidence for the income-only case.

## Remaining limits

The natural game reports TECH INV-004/008/010/011/019/039. The full-bank fixture
reports TECH INV-004/009/010/011/021/028; the sustained fixture reports INV-009.
These are retained strict failures, tracked under [KI-427](known-issues.md).
Similar earlier warnings are not proof that every new occurrence is unchanged
or has the same cause. No AIR invariant, shared-layout invariant, script error
or engine crash occurs in the completed final-native scenarios.

The natural first fusion starts at frame 43373 (24.10 minutes), after all owned
mex upgrades; it is unfinished at 25 minutes. The twenty-minute goal remains
unmet in this sample ([KI-436](known-issues.md)). The lab income change does not
remove the reactor's explicit mex-completion gate.

Allied sharing covers instances of the same loaded AI library. Humans and
different AI libraries are handled through physical obstruction detection, not
the shared index. Engine save/reload, runtime role switching, cross-library
coordination, all-map clearance and every destruction/repair path are not played
here ([KI-405/KI-439](known-issues.md)). Initial TECH terrain-hole scoring remains
intentional; first-use checks must not reject a usable partial economy box.
The bounded forward-search fix still needs the original Glacial regression
([KI-423](known-issues.md)).
