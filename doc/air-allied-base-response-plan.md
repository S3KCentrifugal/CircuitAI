# AIR response to ground infiltration near allied bases

Status: researched proposal, 2026-10-02. No gameplay implementation or new
simulation results are claimed by this document. Scope: experimental AIR only.

The supplied screenshots show a foothold on the cliff behind an
allied base. The owner identifies a factory and jammer there. The images do not
establish which units the AI could see, the exact world coordinates, or available
AA. The response must work from legitimate shared vision, not spectator knowledge.

## Recommended behavior

Every observed enemy land unit inside an active allied base's protection area
opens a defensive incident immediately. Include constructors and buildings:
waiting for an armed army would miss the factory/jammer foothold in this case.
Send available suitable aircraft immediately and establish a **20-unit defensive
force target**. Twenty is the production goal, not a launch requirement and not
twenty more orders for every contact or every update.

Recommended refinement to the literal fixed batch: stop adding unstarted orders
when the incident is demonstrably cleared. Keep surviving defenders as a reserve.
Otherwise a lone disposable scout could force thousands of metal of unnecessary
production. A persistent foothold still drives the full target of twenty.

For the screenshot's situation:

1. Scout the cliff from the nearest safe direction to acquire visual contact.
2. Divert free ground-capable aircraft to the intruders; queue the missing
   defensive force across compatible completed air factories.
3. Stop constructors building AA, factories or repairs. Remove the jammer when
   it impedes targeting; use an available Juno/Legion Blindfold where practical.
4. Destroy the factory and remaining intruders. Do not chase survivors across
   the map, and do not abandon the incident merely because radar contact vanishes.
5. Sweep the ledge and its approach, verify it is clear, and retain a nearby
   defensive patrol so rebuilding is detected.

Imminent damage to an allied commander, factory or economy overrides the normal
cleanup order. AA threatening the response must be disabled or avoided before
the gunships loiter over it. If the foothold has become a flak/SAM nest, use an
appropriate defensive bomber strike against its static AA/factory while gunships
intercept escaping builders and units on the safe side. Do not feed twenty light
gunships into a known hard counter.

## PvP grounding and faction selection

The official [Roughneck](https://www.beyondallreason.info/unit/armbrawl) and
[Wasp](https://www.beyondallreason.info/unit/corape) descriptions explicitly place
their main use in protecting bases/teammates under friendly air control, and warn
against fighters, flak and heavy SAMs. That supports a defensive gunship reserve.
It does not prove twenty is optimal in every matchup; twenty is the owner's
proposed configurable target to validate in tests.

[Banshees](https://www.beyondallreason.info/unit/armkam) suit exposed infrastructure
and light targets, but are a poor substitute for heavy gunships against armored
forces. [Jamming](https://www.beyondallreason.info/unit/armjamt) denies radar,
not ordinary visual detection; reconnaissance must precede blind target selection.
Actual cloaking is a separate detection problem.

| Faction | T1 response | Preferred available T2 response | Important constraint |
| --- | --- | --- | --- |
| Armada | Banshee (`armkam`) against exposed/light intruders | Roughneck (`armbrawl`); consider Hornet only for an appropriate target and delivery time | Tier and metal cost alone do not determine the best response. |
| Cortex | A small Shuriken support group plus T1 bombers/allied damage | Wasp (`corape`) | Shuriken (`corbw`) deals EMP, not lethal damage. Twenty Shurikens cannot clear a lab by themselves. |
| Legion | Mosquito (`legmos`) with stocked rockets | Combat-assigned Stronghold (`legstronghold`) when available and timely | Do not use Martyr (`legkam`) as a reusable gunship; never steal an occupied/requested ferry. |

The [Mosquito](https://www.beyondallreason.info/unit/legmos) is a stockpiling rocket
gunship; ammunition must count toward readiness. The
[Stronghold](https://www.beyondallreason.info/unit/legstronghold) is a transport/gunship
hybrid. The [Blindfold](https://www.beyondallreason.info/unit/legcib) can remove jammers
and radars, but is support, not part of the lethal damage quota. Helper drones are
not factory-buildable candidates. Cortex's T1 exception should use a viable mixed
response, not invent a T1 lethal gunship or wait for T2 before defending.

Select from the current loaded factory build options, availability and role limits.
Estimate first effective damage arrival from build work/support, resource funding,
travel distance, weapon suitability and ammunition. Prefer a suitable completed T2
plant, but let T1 plants provide faster initial response. Do not auto-build a T2
factory, or twenty flying fortresses, merely because they are the highest tier.

For scale, listed unit costs make twenty Banshees 2,700 metal and 46,000 energy,
twenty Roughnecks 6,200/124,000, and twenty Strongholds 11,000/260,000. These are
illustrative roster costs, not runtime constants. This is why production must stop
when no emergency remains and why available units should fight before twenty exist.

## Findings verified against this repository

| Finding | Source and implication |
| --- | --- |
| Emergency aircraft production measures only armed air contacts | [AirScreen::IntrusionCost](../data/script/src/manager/air_screen.as) reads `GetAirContactCount`; ordinary ground infiltration is absent from that emergency signal. |
| Dedicated defensive bombers cover nearby gantry-exclusive ground threats | [AirWaves::_PlanWave](../data/script/src/manager/air_waves.as) and [AirOperations::Configure](../data/script/src/manager/air_operations.as); not a general allied-base ground defense contract. |
| Most gunships fall through to generic native task assignment | [Air_MilitaryAiMakeTask](../data/script/src/roles/air.as); no persistent base-response owner/group currently binds them to this incident. |
| T1 support production is conditional optional production | [AirProduction::MakeTask](../data/script/src/manager/air_production.as) gates it on strike mix, resources and global surface cost, not an allied-base ground intrusion. |
| Existing T1 strike helper is not a lethal-gunship roster | [RoleAir::GetT1StrikeAircraftNameForSide](../data/script/src/roles/air.as) returns `armkam`, EMP `corbw`, and suicide `legkam`. Reusing it blindly would implement the wrong force. |
| A useful ground observation snapshot already exists | [BattleAnalysis](../src/circuit/terrain/BattleAnalysis.h) exposes ground position, cost and economy flag, but not ground contact ID or detailed classification. Extend it rather than rescan all enemies from each unit. |
| Allied geography is reusable but needs a narrower base predicate | [AirHome](../data/script/src/helpers/air_home.as) knows allied/human starts via [WallHelpers](../data/script/src/helpers/wall_helpers.as). `Friendly()` covers broad territory, not just base areas. |
| Shared group commands already support deduplication | [RouteTask](../src/circuit/task/fighter/RouteTask.cpp) keeps a target/version and issues only changed missions. `SetAirTarget` can issue an attack to a visible ground contact, despite its name. |

These establish the missing behavior, not the exact detection history of the
screenshotted match. Tracked as [KI-482](known-issues.md).

## Incident and production rules

**Protected geography.** Cache active allied base areas, including human allies.
Start with configurable 1,800-elmo XZ radii around active starts, extended around
connected factory/economy campuses. Validate this provisional radius using the
actual cliff coordinates; do not share/mutate TECH's wall radius. Ignore ground
path accessibility when measuring an air-defense incident: a cliff must not make
an enemy disappear from base protection. A lone distant mex or forward turret must
not turn the entire front into a permanent base emergency. Stop protecting an
abandoned start after its allied core is gone.

**Lifecycle.** Clear -> active -> contact lost/search -> confirmed clear -> reserve.
Any observed hostile mobile ground unit or hostile structure in a protected zone
activates it. Unidentified radar contacts request identification without assuming
their unit type. Merge nearby contacts into one incident; retain stable IDs and
last observed positions. Lost contact does not grant hidden positional updates.
After loss of vision, scout the last observed area and likely exits. Reduce new
spending after a configurable memory interval; only a visual clear sweep or
confirmed destruction closes the foothold. Proposed defaults: 120-second memory
and 20-second clear confirmation, both requiring simulation tuning.

**Force accounting.** One target of twenty combat defenders per responding AIR
reserve, not per enemy. Count available assigned survivors plus their frames and
unstarted recruitment reservations exactly once. Exclude dead, donated, player-owned,
offensively committed, ferry-assigned and otherwise unavailable aircraft. Each
factory atomically claims one missing slot; losses reopen slots while the incident
remains active. New aircraft join the closest compatible response group. An incident
can use several groups; do not strand the first nineteen waiting for the twentieth.

**Production priority.** Keep the standing transport-request priority. Preserve
critical constructor recovery and energy survival. Place defensive recruitment
ahead of optional raid bombers, radar-plane batches, dedicated-fighter surplus and
growth saving gates. Keep enough fighter production to prevent a simultaneous air
raid from invalidating the gunship response, and preserve the existing workforce
turn mechanism so donations do not produce another constructor stall. Rearrange
unstarted optional orders; do not destroy an in-progress unit to rewrite the queue.
The new policy must also precede optional generic spam in AIR's factory dispatch.
Log why a lab cannot contribute: build options, pending slot, resources or ownership.

**Ownership and combat.** Claim free gunships immediately. Suspend new optional
offensive ground strikes during the incident. Prioritize active threats to allied
assets, safe removal of blocking AA, builders making/repairing the foothold,
jammers impairing vision, its factory, then remaining land enemies. Threat and
vision dependencies can change that ordering. Preserve engaged targets unless
they die, leave the leash, become invalid, or a materially more urgent threat appears.
Defensive units may pull back to safe cover and repair. Keep separate small groups
against splash AA and intercept exits instead of chasing one scout into hostile land.

**Existing promises.** Fighters already committed to an offensive bomber wave stay
with it until the wave dies, per the owner's explicit choice. Immediate defense
uses free/new units. T2 bombers retain their T1-ground exclusion; gunships handle
those intruders. Defensive bombers can attack the foothold's valuable buildings
or qualifying T3s. Transport priority and TECH's exact economy/layout rules remain
unchanged. A future change to either commitment rule requires a deliberate policy
decision, not an incidental side effect of this response.

**Multiple AIR allies.** Elect a responding AIR using estimated arrival time and
available force, tie-broken by team ID; allow reinforcement when that force is
insufficient. Share incident claims through the existing AI team-message mechanism.
Do not make every AIR independently add twenty aircraft for the same one-unit raid.

## Implementation boundaries and performance

Add an AIR-specific `air_base_response.as` controller and small pure scoring/force
helpers. Integrate at role update, factory admission and military assignment. Keep
incidents, count targets, faction policy and target ordering in AngelScript.

Extend the existing native ground snapshot with stable contact ID, definition ID,
observation freshness and capability flags needed for builders/factories/AA/sensors.
Expose them through the registered API. Use value records; never retain a borrowed
enemy/unit handle. Build the snapshot in the existing enemy pass. Reuse cached
weapon/AA exposure for ingress rather than starting another full enemy scan per
gunship. Public unit classifications remain unchanged for TECH and legacy roles.

Cache protected-area spatial cells and aggregate observations in one pass. With
E contacts, G response aircraft and a small fixed number K of response groups,
target O(E + G + K) work per update after the base-area index is built; no
enemy-by-aircraft nested scoring. The current slow update is once per game second.
Dispatch on the next AIR decision after a fresh contact enters its snapshot, with
an end-to-end test budget of two game seconds. Record observation and command times.

Reuse `CRouteTask` target/route versioning and member transfer. Moving targets keep
their engine ATTACK order; a changed mission or new group member receives an order.
Group ownership does not imply one network packet for twenty units: count actual
synchronized orders. No APM cap, per-frame command refresh, or runtime debug drawing.
Support damaged-unit detachment/rejoin, task cancellation, death, donation,
player takeover and role change. Rebuild transient incident/task ownership after
load from fresh legal observations; do not trust stale serialized target handles.

## Acceptance plan before deployment

1. Pure tests: base-boundary/cliff geometry, dead-base exclusion, contact lifetime,
   force deficit accounting under concurrent labs, faction capability selection,
   EMP-only exclusion, stockpile readiness, mixed-tier arrival ranking and leash.
2. Rendered Glacial arena: enemy constructor traverses the cliff, builds a jammer
   and factory near an allied base. First use normal vision. Verify scouting,
   first attack latency, production deficit, builder/factory kills and clear sweep.
3. Repeat for all factions and T1-only/T2-capable economies. Cortex must supply
   lethal damage; Legion must use Mosquito ammunition and spare combat Strongholds.
4. Repeat with a human ally, two AIR allies, lost vision, a false-cleared jammer
   pocket, one bait scout, retreating infiltrators, AA additions and simultaneous
   enemy aircraft. Verify no duplicate 20-unit queues or uncontrolled chasing.
5. Inject an already committed bomber escort, a transport request and constructor
   shortage during the incident. Verify those ownership/priority promises directly.
6. Normal fast-forward Glacial, Glitters, Supreme, Tundra and Serena games: compare
   no-intrusion factory/economy milestones with baseline, then late donated-metal
   intrusions. Include a metal-map smoke check because force funding is income based.
7. Capture screenshots of spotting, first response, reinforcement and cleared ledge.
   Record detection-to-first-command/damage, time to stop production/clear the lab,
   allied losses, air losses, spent resources, maximum pending deficit, per-unit
   command counts and p95 AI update time. A raid that merely draws twenty icons
   without destroying the foothold does not pass.

No implementation changes or simulations were made for this design review.
