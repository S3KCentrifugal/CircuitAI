# TECH/AIR amphibious operations (D-158)

Design written before implementation, 2026-10-01.

## Requested behavior and scope

Only experimental TECH and AIR opt into the new controller. Other roles,
legacy profiles, ordinary army tasks, factory openings and AIR's constructor,
transport and fighter priorities retain their existing behavior. Unit identity
is explicit: Telchine (`legamph`) and Marauder (`armmar`), including donated
units and captured compatible factories; other amphibious units keep their
current controllers. Existing compatible factories can supply bounded waves
after the role's economic gate, without adding a ground-factory build order to
AIR. Marauder production must remain possible alongside TECH's signature T3s.

Telchines are strong ground combatants and coastal guards. Crossing water is
transport, not an underwater attack: both their weapons are disabled in water
form. Marauders likewise cannot fight fully submerged. Prefer quiet underwater
approaches, avoid observed anti-submarine threats, and do not confuse unobserved
water with proven safety. Use currently known contacts only.

Telchines assemble a wave, cross together, land on a usable intermediate island
or shore, regroup, clear local enemies and secure it before advancing. A coastal
hold takes place on dry reachable ground, from which depth charges can fire.
Marauders assemble and cross together but, after landing, pursue known enemy
economy and production through the backline before securing the area. Dry-map
raids and land-only segments remain valid; neither unit requires water to act.

## Existing mechanisms and diagnosis

The lane solver already knows amphibious movement and can connect the factory
to a precomputed lane. `StrategicSites` labels connected dry land but is advisory.
`CRouteTask` provides strict waypoint movement, arrival checks and a fight at
the endpoint. Its current single endpoint does not gate departure on group
arrival or land security. Generic native army selection cannot express the
different Telchine and Marauder landing priorities. Lanes currently activate
automatically for TECH only, although their geometry is reusable by AIR.

## Design

1. Add a shared AngelScript operations manager with one owner per wave and
   stable unit IDs. States: assemble, cross/advance, regroup, secure, exploit,
   hold/replan. Keep unit types in separate waves. Never admit reinforcements
   into a wave already crossing; form the next wave at home. Cap concurrent
   waves and close empty tasks. Role loss aborts owned tasks and releases units.
2. Reuse native lane terrain and Dijkstra search for a configurable point-to-point
   amphibious route. Charge land/water travel separately, strongly penalize
   observed underwater threat and reject cells above the policy limit. Expose
   the query and observed local enemy targets/costs to script; no native role
   names, unit names or build priorities. Verify start/end connectivity without
   snapping across an impassable shore. Refresh before each crossing and when
   new threat makes the planned crossing unsafe.
3. Use dry components encountered by the complete route as staging objectives.
   Water-to-land transitions end a leg where sufficient dry room is available;
   tiny shoreline slivers cannot hold a wave. Telchines
   must gather the configured fraction of surviving members and clear local
   observed opposition for a continuous secure interval before taking the next
   leg. Regroup time is bounded; severe losses or an unsafe route hold/replan
   instead of trickling single units into defended water. Marauders shorten the
   landing pause and prioritize economic targets on the reached land component.
4. Reuse route tasks for engine commands, preserving all crossing waypoints.
   Land engagement stays within the active dry component. Coastal guard points
   remain dry with room for the group; no fight command is allowed
   to replace the underwater transit with a direct attack on an unreachable sub.
   Generic movement/combat remains unchanged unless the operation opts in.
5. Keep thresholds, wave sizes, dwell times, target preference and route costs
   in the shared policy/config surface. Reconstruct ephemeral operations from
   living unit IDs after load; restart through assembly and route validation,
   rather than trusting saved transient task pointers or stale threat decisions.
6. Enable lane/theatre survey for AIR only while its experimental controller is
   active. Preserve TECH's geometry/settings and existing mountain-lane behavior.
   Do not assign AIR's economy constructors to beach construction or displace
   requested transports/fighter defense to fund an amphibious wave.

## Verification and acceptance

Pure tests exercise wave-release thresholds, dry landing segmentation, safe
route preference/rejection, island security before onward travel, Marauder
exploitation priority and role gating. Build native bindings, run API parity and
compile all three experimental profiles in the game. Update role references,
API reference, invariant and actor registers; record remaining limitations.

Run controlled capability fixtures first on **Tundra Continents**, then
**Supreme Isthmus**, then **Serene Caldera** (the repository's spelling). Use
real terrain, injected groups and observable enemy targets to distinguish
production cost from command behavior. Independently observe actual positions,
water crossings, regrouped landings, kills, onward movement and avoided threat
regions. Include Telchine and Marauder, TECH and AIR, a guarded route alternative,
and an out-of-scope role. Follow with production/economy smoke evidence where
feasible. Never count a selected objective or queued command as arrival/combat.

Global invariant failures remain failures. Report precise run identities,
elapsed game time, binary hash, failed attempts, and untested cases. Publish
the completed DLL, matching symbols and data to the required build output;
commit locally and do not push under the standing user instruction.

## Game references

- [Telchine](https://www.beyondallreason.info/unit/legamph): coastal anti-sub fire,
  ground heat ray, submerged firing restriction.
- [Marauder](https://www.beyondallreason.info/unit/armmar): fast amphibious raiding.
- [Sea warfare](https://www.beyondallreason.info/guide/basics-on-sea-warfare):
  firing above the waterline and shore footholds.
- Shared game knowledge: `../rjm.bar.docs/knowledge/30-units/` and the local BAR
  unit scripts take precedence over generated amphibious firing notes (KI-445).

## Implementation refinements found in simulation

- A lead unit on a narrow dry patch is insufficient: the destination requires
  nine dry, passable samples over a 320-elmo square, and 80% of living members
  must actually be dry within 240 elmos before security is timed. A stalled
  crossing replans from a straggler; it cannot skip the security phase.
- Route tasks opt into hold-position movement so a shore guard does not chase
  a submarine off its firing platform. Commands retain all transit waypoints.
- The experimental profile deliberately assigns `coratl` zero combat threat.
  The new route query therefore includes currently observed underwater weapon
  coverage independently of those multipliers, with two cells of clearance.
  Other threat-map users retain their existing values. Script still controls
  the maximum permitted underwater threat and route costs.
- TECH's opening combat donation used to split the first Telchines from their
  wave. Only managed Telchines/Marauders bypass that donation now.
- TECH's ordinary T1 target-ignore preference must not make an occupied
  foothold appear clear. The new contact snapshot includes those observed
  enemies while retaining the game's explicit exclusions and visibility rules.
- Disabling lanes also disables this controller rather than taking ownership
  of units while their terrain survey is unavailable.

## Measured verification (2026-10-01)

Final native build: `build-theatres/d158-build-05/SkirmishAI.dll`, 7,615,130 bytes.
SHA-256: `d70acd89478aa3179b0e97e7a50b7941b7a2d6d5375db5b99a766e91bb005fb1`.
Matching symbols SHA-256:
`709e1ca4c1f180a47e9011d3d16a879438e7323aaf9b75931dd89e44b50245a6`.
Engine `recoil_2026.07.04`; game `Beyond All Reason test-31450-6562fb1`.
Team 0 TECH/Legion and team 1 AIR/Armada each receive six Telchines and four
Marauders; enemy FRONT receives both types as out-of-scope controls. Injections
exercise cross-faction donations as well as each role's own faction unit.

Both `amphibious.json` and the independent telemetry audit must pass. Landings
below count distinct units that actually crossed water and reached dry ground;
repeated shoreline transitions are not extra units. Kills are observed damage
attributions against the fixture's economic buildings and T1 land defenders.
Progress is actual distance from each unit's spawn, not queued route length.

| Map / profile | Game minutes | Distinct landings | Secured role/type waves | Telchine / Marauder kills | Minimum progress across four groups |
| --- | ---: | ---: | ---: | ---: | ---: |
| Tundra Continents v2.3.1 / experimental_balanced | 17.0 | 20/20 | 4/4 | 4 / 4 | 10,625 elmos |
| Supreme Isthmus v1.7 / experimental_hard | 17.0 | 20/20 | 4/4 | 4 / 16 | 13,804 elmos |
| Serene Caldera v1.3 / experimental_terrible | 21.0 | 20/20 | 4/4 | 4 / 14 | 13,078 elmos |

All three final runs passed both checkers, with no script errors or invariant
violations. Both FRONT control types were present and never acquired an AMPH
operation. Tundra's closest observed submerged approach to the live `coratl`
was **1,078 elmos**, outside its **890-elmo** weapon radius. It had real allied
sonar coverage; detection was recorded. Clearance stops counting when the
guard dies, so crossing its former position does not falsely fail the test.

Final archives (relative to repository root):

- `build-theatres/d158-tundra-final/runs/20261001-111347/`
- `build-theatres/d158-supreme-final/runs/20261001-111953/`
- `build-theatres/d158-serene-final/runs/20261001-112158/`

Each archive contains the original infolog, watcher report and
`amphibious-audit.json`. The final Tundra run uses simultaneous waves and the
original team-death mode. Supreme and Serene use `deathmode=neverend` so an early
Marauder commander kill cannot remove later Telchine targets. Serene additionally
uses `--marauder-delay-seconds 120`, giving slower Telchines independent combat
time before the faster raiders clear the shared landing area. These are fixture
settings, not changes to production timing. The initial map tests were run in
the requested Tundra, Supreme, Serene order; failing cases were then replayed.

### Regression results and corrected failures

`tools/run_native_tests.sh` passed: 76 layout-ranking checks, base geometry,
eight lane-solver suites (including eight concurrent solvers), six strategic
weapon suites, seven new terrain-route scenarios, 128 production rules,
20 placement rules and 11 new amphibious-wave rules. All three experimental
profiles compiled and executed in their real-engine map tests. Script/DLL API
parity checked 259 used members with zero findings. Role-document and invariant
checks passed; fixture Python compilation and commented-JSON parsing passed.

Failed attempts remain archived. Initial fixtures exposed blocked full-unit
spawn footprints and the BAR widget dispatcher's missing attacker argument;
placement validation and the raw damage observer corrected those checks.
Gameplay runs exposed TECH splitting its Telchine opening donation, narrow
shorelines that stranded a wave, and assembly points too close to Serene's
shore. These were corrected before the final runs. Early script compile errors
and a duplicated removal hook were also fixed before passing profile runs.

Guarded runs `d158-tundra-guard/runs/20261001-105737`, `20261001-110136` and
`20261001-110516` failed the independent clearance audit at 147-150 elmos even
though the coarse watcher passed. The first exposed zero profile threat weights;
the new coverage calculation initially used the 256-elmo heat-grid size instead
of the 64-elmo route grid. Correcting that calculation produced 1,065-elmo
clearance in `20261001-111043` and 1,078 in the final build. The final Supreme
and Serene fixture reruns also corrected premature target-team elimination;
no kill attribution was inferred from a queued attack or a dead target team.

The two repository-wide checkers retain their pre-existing findings: eight
links to missing `doc/roles/hover.md` (KI-404), and the unreachable `armsonar` /
`corsonar` helper references (KI-425). This change adds none of those findings.

### Verification limits and published output

These controlled runs establish routing, actual island/shore landfalls,
regroup/security, forward progress, land combat, guarded-water avoidance and
role isolation. They do not establish competitive win rate, natural economic
recruitment, saved-game recovery or a dedicated depth-charge firing scenario.
Production and load verification follow-up is recorded as KI-446; unchanged
legacy/native torpedo weights are KI-447. Production hooks were reviewed for
compatible build edges, constructor precedence, bank/income gates and bounded
owned-plus-pending waves. No new ground factory build order was added to AIR.

The final stripped DLL, matching `.dbg`, and all 243 current data files were
published together and hash-verified in
`C:/bardev/bar-RecoilEngine/build-amd64-windows/install/AI/Skirmish/BARb/stable`.
API parity passed against that output. The live BAR installation was not written.
