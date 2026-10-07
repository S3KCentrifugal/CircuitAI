# D-201 SEA fleet implementation and played results

Completed 2026-10-05 against baseline `2989415b`. This release implements
SEA-specific initiative, scouting and underwater response. It deliberately
changes SEA behavior; the separate [D-200 performance guidance](performance/engineering-guide.md)
documents the existing exact optimizations without tuning other roles.

## Result and scope

- Adaptive fleet control now operates with both SEA economic paths. Previously
  its experimental-layout gate left ordinary games using the legacy batches.
- Scouts replenish and search individually. Compatible combat hulls release at
  seven units or sixty seconds, then keep finite water objectives instead of
  waiting for another externally forced attack. This addresses the no-contact
  control gap; the original player-match parked fleet was not replayed.
- Approach uses shared native route lanes with coast checks. Close engagement
  returns to native combat/repair. Sensors and anti-nuke ships follow cohorts;
  siege keeps its artillery task except for immediate underwater withdrawal.
- Legal unidentified sonar contacts contribute a configurable uncertainty
  budget. Weapon capability selects counters: ARM/COR destroyers and Legion
  frigates contribute underwater cover; Legion destroyers cannot.
- Procurement considers completed cover in the yard's water body and fresh
  queued reinforcements. Emergency admission requires one constructor rather
  than two. Surface-only cohorts withdraw when nearby underwater cover is
  inadequate. Threat cost remains for thirty seconds after contact disappears.
- The policy scans owned hulls once per second, scores contacts by cohort and
  retains route intent. There is no global order throttle, worker-thread engine
  access, shared profile reclassification or AIR naval-snapshot modification.

See the [research/design](sea-fleet-rework.md), [304-entry naval roster and use
cases](sea-unit-controls.md), [native trace](sea-native-trace.md) and
[settings](roles/sea.md). Enumerating the roster is not evidence that every
special weapon, extra unit or auxiliary factory mechanic was simulated.

## Build and reproducibility

Native candidate: `build-theatres/d200/build-3/SkirmishAI.dll`, SHA-256 prefix
`bcac8c987b1d8164`, 7,845,640 bytes, with matching debug symbols.
Game: `Beyond All Reason test-31479-433a460`; engine: `recoil_2026.07.04`.
Combat fixtures use Glacial Gap v1.1, seed 1891, supplied forces and energy,
and six-minute requested windows at speed 12. Each archived result contains its
actual stopping frame, frozen data hashes, overrides and original checks.
Some checks intentionally stop before six minutes. PASS means those checks
passed; it does not mean a match victory.

Candidates 8 and 9 use the same native DLL. Candidate 9 additionally restores
tracked hybrid AA boats after air-threat memory expires. The older candidate 7
screen record is retained separately. Final candidate 10 also replaces repeated dead-cohort array erasure with stable
linear compaction, preserving reverse teardown order and survivor order. Its
separate surface-combat follow-up below verifies runtime cleanup after losses. Both AIs in an arena
use the selected candidate; these are not old-versus-new tournaments.

Combat fixtures freeze economic builders and supply assets. Production cases
leave real shipyard production active, with a short initial workforce barrier.
Supported cases allow native recovery units to leave the yard and supply actual
construction turrets. None of these fixture overrides enters production data.
The natural games use ordinary resources and the legacy economy path with
compact placement; they run twenty minutes at speed 20.

```powershell
python tools/playtest/sea_arena.py --case response-sub-legion --side legion --dll build-theatres/d200/build-3/SkirmishAI.dll --data data --legacy-layout --minutes 6 --speed 12
python tools/playtest/sea_arena.py --case response-sub-cortex-supported --side cortex --dll build-theatres/d200/build-3/SkirmishAI.dll --data data --legacy-layout --minutes 6 --speed 12
python tools/playtest/run_sea.py --map shore --scenario fleet-rework --dll build-theatres/d200/build-3/SkirmishAI.dll --data data --legacy --minutes 20 --speed 20 --keep-going
```

Use `--map glacial` or `--map supreme` for the other natural fixtures. The new
Shore alias explicitly resolves `shore_to_shore.as`; an initial staging failure
looked for a filename derived from the map title and did not launch a game.

## Published observations

| Fixture / source candidate | Original verdict | Observed assertions | Peak team-0 commands/min |
| --- | --- | --- | ---: |
| [carrier-release-8](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/carrier-release-cand/2026-10-05/20261005T043624Z-ba305efa/README.md) | PASS | combat: seen at 0.3 min | 735 |
| [escort-search-8](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/escort-search-cand/2026-10-05/20261005T043240Z-9e810f9e/README.md) | PASS | escort: seen at 0.2 min; fleet-search: seen at 0.2 min; combat: seen at 1.4 min | 858 |
| [legion-t2-production-9](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/legion-t2-productio-cand/2026-10-05/20261005T044003Z-412eacee/README.md) | PASS | registration: seen at 0.1 min; t2-constructor: seen at 0.6 min; t2-combat: seen at 1.0 min | 1631 |
| [natural-glacial-9](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/fleet-rework/2026-10-05/20261005T044453Z-5972c2a3/README.md) | PASS | opening-yard: seen at 2.5 min; first-ship-exit: seen at 3.8 min | unmeasured |
| [natural-shore-9b](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/fleet-rework/2026-10-05/20261005T045017Z-50a23061/README.md) | PASS | opening-yard: seen at 1.1 min; first-ship-exit: seen at 1.8 min | unmeasured |
| [natural-supreme-9](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/fleet-rework/2026-10-05/20261005T044647Z-e71d1268/README.md) | PASS | opening-yard: seen at 1.4 min; first-ship-exit: seen at 2.0 min | unmeasured |
| [response-air-supported-9](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/response-air-suppor-cand/2026-10-05/20261005T044119Z-dbb8486c/README.md) | PASS | combat: seen at 0.5 min | 1316 |
| [response-sub-cortex-8](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/response-sub-cortex-cand/2026-10-05/20261005T043125Z-1db2a128/README.md) | FAIL | response: seen at 1.1 min; counter-started: seen at 1.1 min; new-counter-fired: **missing** (by 6 min) | 194 |
| [response-sub-cortex-supported-9](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/response-sub-cortex-cand/2026-10-05/20261005T043848Z-bdfdc6ac/README.md) | PASS | response: seen at 1.5 min; counter-started: seen at 1.6 min; new-counter-fired: seen at 1.8 min | 302 |
| [response-sub-legion-8](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/response-sub-legion-cand/2026-10-05/20261005T042854Z-59b770be/README.md) | PASS | response: seen at 0.4 min; counter-started: seen at 0.4 min; new-counter-fired: seen at 1.3 min | 211 |
| [response-submarine-8](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/response-submarine-cand/2026-10-05/20261005T043009Z-6bbb7889/README.md) | PASS | response: seen at 1.1 min; counter-started: seen at 1.1 min; new-counter-fired: seen at 1.9 min | 258 |
| [scout-fog-8](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/scout-fog-cand/2026-10-05/20261005T043355Z-6e97e266/README.md) | PASS | search-orders: seen at 0.2 min; contact-damage: seen at 0.8 min | 939 |
| [shore-siege-8](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/shore-siege-cand/2026-10-05/20261005T043510Z-8e03ee2d/README.md) | PASS | combat: seen at 0.4 min | 547 |
| [surface-line-9](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/surface-line-cand/2026-10-05/20261005T044232Z-34063b56/README.md) | PASS | combat: seen at 0.5 min | 410 |
| [surface-sub-danger-7](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/surface-sub-danger-cand/2026-10-05/20261005T042303Z-8367ea27/README.md) | PASS | underwater-screen: seen at 0.3 min | 703 |
| [surface-sub-danger-9](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/surface-sub-danger-cand/2026-10-05/20261005T045539Z-e8bd3e9b/README.md) | PASS | underwater-screen: seen at 0.2 min | 381 |

The main set contains twelve combat fixtures and three natural games: fourteen
PASS and one retained FAIL. The additional candidate-7 screen record is an
earlier observation, not another independent final scenario.

### Counter response and capacity

Armada's newly built Eel damaged a submarine at frame 3418 (113.9 seconds).
Legion's new counter did so at frame 2292 (76.4 seconds). The Legion response
began on an unidentified sonar contact before the main one-minute arrival;
that conservative contact may be a submerged structure. It must not be described
as clairvoyant recognition of an unseen submarine.

The unassisted Cortex case correctly selected and started a submarine at frame
1959 but lost its unfinished frame at 2875. It never satisfied the new-counter
damage assertion. That FAIL remains published. The separate case with six
construction turrets started a sub at 2803 and recorded new-counter damage at
3238 (107.9 seconds). Better selection cannot instantly compensate for a weak
initial screen and inadequate build capacity. This remains [KI-501](known-issues.md).

The final surface-only screen case logged withdrawal at 0.2 minutes. Its
42-second screenshot shows the friendly frigates farther back toward their
home side, with the hostile submarines separated to the east. The automated
check asserts the policy decision, not every movement sample; it is not proof
that no hull will ever enter torpedo range. Raw screenshots remain in its archive.

### Scouting, escorts and working special tasks

The fog fixture issued searches at 0.2 minutes and recorded damage at 0.8.
The escort fixture assigned the utility ship and moved the combat cohort at
0.2 minutes, then recorded contact damage at 1.4. Surface-line combat began at
0.5, matching the coarse baseline first-contact observation. No statistically
matched effectiveness claim follows from that timing.

Siege, carrier and AA fixtures passed generic spawn/combat/order checks.
They establish runtime compatibility, not exhaustive drone handover, optimal
AA positioning or an exact assertion of the new hybrid-AA release event.
The Legion T2 legacy-layout fixture on experimental_terrible registered the
missing factory metadata, finished a constructor at frame 1104 and a combat
hull at 1781. Hard/balanced/terrible scripts loaded during the broader run set.

### Natural economy observations at twenty minutes

| Map | SEA players | First yard | First observed egress | Team 0 metal / energy income | Team 0 economy/fleet observation |
| --- | ---: | ---: | ---: | ---: | --- |
| Glacial Gap | 6 | 2:30 | 3:50 | 50 / 711 | One T1 yard, 7 destroyers and 6 scouts; 10 T1 mexes and 3 donated T2 mexes |
| Supreme Isthmus | 2 | 1:26 | 1:59 | 49.3 / 861.8 | One T1 yard, 27 destroyers, 23 scouts and 1 sub; 17 mexes |
| Shore to Shore | 6 | 1:07 | 1:48 | 12.2 / 415 | One busy T1 yard, 2 subs, 5 mexes and 17 tidals; 11.7 metal banked |

All three reached twenty minutes without script/invariant failure and without
an observed T2 yard for team 0. These are economy compatibility observations,
not optimal growth benchmarks. Scout counts can exceed the minimum because
hybrid AA also contributes to production selection. Natural-game APM was not
measured by the combat observer and must not be reported as zero.

## Performance interpretation

The final combat fixtures' observed peak team-0 command rate ranged from 194
to 1631 per minute. These are per-unit engine command observations and include
Lua gadget orders; they are not multiplayer packets or player UI APM. Small
supplied fleets and unequal survival cannot establish an 8v8 late-game FPS
improvement. No new whole-game speedup is claimed here.

Policy work is O(U + G*E + S*G) per interval: owned units U, cohorts G, contacts
E and utility cohorts S. The native extension copies/scans contacts and sorts
them; path searches remain separate. Its same-frame cache is not a license
to retain stale unit handles. Existing known naval contacts come from the
original five-second snapshot; the SEA-only unknown/static extension refreshes
per requesting frame. See source comments and the performance guide.

## Validation and preserved evidence

The full native/embedded-VM suite passed, including 200,038 local-reservation
checks, 200,159 allied-reservation checks, terrain/naval geometry, AIR safety,
pure SEA boundaries, existing performance oracles and a real dictionary add-on
regression. The dictionary regression exercises missing keys, conversion,
increment, deletion and wrong-type fallback; it caught the implementation's
initial false completed-cover counts. Source-only regex checks were insufficient.

The build and 301-member script API check pass. Role-document and invariant
checks pass. The generated test catalog has three passing tooling tests; four
updated/new skills pass the skill creator's validator. Existing documentation
link failures are the eight KI-404 links to missing hover documentation. The
unit-helper checker still flags earlier hover map IDs and TECH sonar entries;
those unrelated definitions were not changed.

Published seventeen compact original observations (including the cleanup follow-up) and verified **4,985 existing
benchmark evidence files byte-for-byte unchanged**. Generated evidence indices
were refreshed. Raw logs/replays remain in isolated categorized game folders;
compact records retain hashes, original PASS/FAIL verdicts, checks, setup and
selected screenshots. Test definitions are indexed separately in the
[test catalog](testing/README.md).

Intermediate development failures were retained locally: a missing script
binding, using a ground-only route API for ships, the dictionary-output defect,
and an assertion incorrectly matching the raw AI prefix after watcher stripping.
They were repaired before the final fixtures. The Cortex failure above is a
remaining gameplay limitation and was not repaired by weakening its assertion.


### Final linear-cleanup follow-up

[Candidate 10 surface combat](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/surface-line-cand/2026-10-05/20261005T050658Z-fb9160e8/README.md) passed with real ship losses,
contact damage at 0.6 minutes, and no script/invariant/fixture errors. Peak
team-0 engine command rate was 314/minute. Both fleets lost metal
(5280 / 3170); this exercises teardown but is not
a matched performance comparison. Source comments explain why stable O(G)
compaction replaces repeated O(G squared) suffix shifting. The prior candidate-9
record remains unchanged.

## Remaining acceptance

- Pending reinforcement credit remains AI-wide on disconnected seas (KI-500).
  Completed cover is scoped correctly; a two-pond owner-aware queue API is future work.
- Full save/load and role-switch stress, exact AA-release assertions, all extra
  unit mechanics, mixed-faction endgame tournaments and multiplayer traffic
  remain unplayed. No human-PvP superiority claim is made.
- Non-SEA preservation is established by explicit opt-in source gates and
  unchanged existing mechanisms/oracles, not a new exhaustive cross-role match
  matrix. AIR's original naval snapshot and ordinary routes keep their behavior.
- Existing economic progression was observed, not retuned. The Cortex capacity
  stress and twenty-minute T1-only games warrant a separate economy/early-warning
  tuning experiment with matched seeds and ordinary resources.
