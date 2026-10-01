# Telchine shoreline formations and land-preferred travel (D-161)

Plan written before implementation, 2026-10-01. Scope is the experimental
TECH/AIR controller. Preserve TECH's exact lab reclaim/rebuild cycle, economic
priorities, recruitment budget and Marauder travel preferences.

## Evidence and tactical interpretation

The [official Telchine reference](https://www.beyondallreason.info/unit/legamph)
describes coastal defence and amphibious assault: neither weapon fires while
submerged; the heat ray reaches 450 elmos and loses half its damage at maximum
range; the depth charge reaches 600. The loaded game remains authoritative.
The local BAR unit source selects HABOT5 (five-square movement footprint),
whose movement definition permits 54-degree dry slopes. UnitDef `maxslope=14`
is not the mobile movement definition's slope limit.

Tactical inference: use mutually supporting, separated dry firing positions
along the coast; approach land targets as a line, close enough for the heat ray,
and cross water only to reach otherwise inaccessible ground. An absolute ban
on water would defeat the unit's island assault purpose. A weighted water cost
after trying a dry route balances exposure against extreme detours. Preserve
the existing observed underwater-threat veto. Avoid chasing ships offshore.

Inspection confirms every guard currently shares one endpoint and Telchines
share Marauders' water-favouring cost. The cliff sighting itself is unconfirmed.
There is a real terrain approximation gap: half of a 64-elmo cell being
passable is sufficient, water cells bypass slope checks, and edges do not
validate the intervening shoreline. Valid dry endpoints do not prove a safe
landing transition.

## Implementation

1. Add an opt-in native unit-specific terrain query, reusing the lane solver.
   Derive footprint and dry slope limits from the loaded MoveData. Validate
   cell centres and connecting corridors against fine engine slope/height
   samples, including diagonal transitions and strictly dry paths. Cache
   terrain-only masks, retain dynamic observed threats and empty-on-failure.
   Existing lane users and Marauder queries retain their contracts.
2. Telchines try strictly dry travel first. If unavailable, use land cost 1,
   water cost 6, reject known underwater threat, and retain intermediate-island
   dry regrouping. Use this query for landing, recovery and formation paths;
   never bypass a failed cliff query with an unchecked direct order.
3. Add generic per-assignee route overrides to CRouteTask. SetRoute clears
   overrides; removal erases them; arrival/resume/idle use each unit's actual
   route. No role names or formation policy in native code.
4. Script assigns distinct dry shoreline slots around the defended coast,
   nominally 192 elmos apart, within mutual support. Candidate slots follow
   terrain/shore geometry instead of applying blind lateral offsets. Every
   member gets a validated dry connector. Land assaults use a 96-elmo spaced
   line facing the objective, with a close dry firing approach. Narrow ground
   reduces available spacing rather than sending units into water or cliffs.
   Form after landfall and while guarding/holding; individual arrival checks
   use assigned slots so dispersal cannot deadlock the security phase.
5. Keep one task owner and stable unit IDs. Recompute only after a new order,
   membership change, material target movement or a failed progress check.
   Record formation slot count/span and route land/water distance for evidence.

## Verification and acceptance

- Pure/native regressions: prefer a longer dry route, reject a narrow cliff
  edge between valid endpoints, use the reachable ramp, no diagonal corner
  cutting, reject threatened water, preserve legacy/Marauder costs, handle
  invalid inputs and formation spacing/arrival.
- Runtime invariant: Telchine formation endpoints and connectors stay dry,
  assigned endpoints are distinct; guard invariant still checks actual dry
  hold-position units and no offshore pursuit.
- Controlled Tundra TECH and AIR simulations: gift units only, let AI own all
  their orders; observe crossing, accessible landfall, a visibly spread shore
  perimeter, formation during land contact, and a surviving retreating ship
  without underwater pursuit. Observer checks actual unit positions and
  engine TestMoveOrder, not just planner logs. Save screenshots during runs.
- Load all three experimental profiles, run API/DLL parity before each launch,
  native/pure policy tests and documentation/invariant checks. Publish matching
  stripped DLL, debug symbols and data to the engine build output.
- Record all failures and limits honestly. Controlled fixtures demonstrate
  movement/combat behavior, not natural PvP recruitment or win-rate impact.
  Existing KI-449/450/453 still limit natural-match claims. Commit locally;
  do not push, following the owner's earlier choice.

## Corrections established during the simulations

The loaded Recoil ground movement code checks the MoveData slope limit on
seabed as well as land, despite the separate maxwaterslope field in BAR's Lua
MoveDef source. A corner/centre footprint sample missed steep squares inside
the footprint: check every eight-elmo square and connecting edge. Independent
Spring.TestMoveOrder rejected initial targets and accepted the corrected ones.

Formation slots must avoid allied structure footprints. A valued shoreline
site can become occupied by an allied factory; select a reachable nearby dry
anchor, and revalidate individual connectors. Use a 128-elmo formation arrival
tolerance consistently in script and native member routes: observed idle unit
centres stopped 97-106 elmos from valid requested endpoints. The original
240-elmo landing quorum and dry-component/security dwell still apply.

Exact-route idle callbacks defer retries to a later update, at most once per
second per member, instead of re-entering command submission or dropping an
idle notification during the rate limit. Preserve the first failed engine
out-of-memory run; no root-cause claim follows solely from later stable runs.
