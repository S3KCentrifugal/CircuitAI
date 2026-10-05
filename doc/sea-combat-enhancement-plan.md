# SEA combat, response and economy acceptance plan

Date: 2026-10-04. Follows [D-188 migration results](sea-layout-migration-results.md).
This plan is written before D-189 policy changes. SEA alone opts in; neither
shared TACTICAL naval constructor behavior nor AIR/TECH policy is a target.

## Evidence and interpretation

The official [naval guide](https://www.beyondallreason.info/guide/basics-on-sea-warfare)
supports layered fleets: surface screens, underwater coverage, protected ranged
damage and scouting. Ships, submarines and hovercraft have different legal
weapon targets; a torpedo-only response cannot stop hovers. Long range ships
need vision and escorts. Capturing a wreck field is part of winning the fight,
not merely killing an equivalent amount of metal. These are tactical principles,
not proof that a fixed build ratio wins every match.

The [repair/reclaim guide](https://www.beyondallreason.info/guide/reclaim-resurrect-repair)
documents persistent work orders. Repair preserves experienced hulls; reclaim
funds immediate reinforcements; resurrection requires time and energy and is
safer behind control of the battlefield. Do not send recovery subs into enemy
depth charges just because a wreck is valuable.

Use the pinned game's actual build options, target categories, sonar, weapon
arcs, range and reloads for implementation. Website balance can be newer than
the installed simulation. The local effective roster is BAR `1d267c20d1`, and
the simulation is `Beyond All Reason test-31479-433a460` on Recoil
`recoil_2026.07.04`. Runtime capability checks must protect against differences.
The [Legion roster](https://www.beyondallreason.info/units/legion-ships) must not
be treated as renamed Armada: Legion's T1 frigate fires torpedoes, its destroyer
is surface-only, and its scout lacks the Armada scout's AA weapon.

## Player doctrine translated into controls

| Group | Use and controls | Avoid |
| --- | --- | --- |
| Fast surface scouts/raiders | Sparse vision screen; raid exposed mexes/tidals; persistent movement through safe water; disengage from stronger destroyers | Repeatedly resetting movement; treating radar as precise LOS |
| Frigates and short-range surface ships | Front screen, focus reachable ships, surround slow isolated artillery with adequate numbers | Sending torpedo-only Legion frigates into hovers |
| Destroyers/cruisers | Layer-specific firing range; line/arc of hulls; screen artillery and kill submerged threats only when actual weapon permits | Using longest gun range for shorter depth charges |
| T1/fast attack submarines | Attack unprotected ships and enemy subs; sonar-supported flanks; avoid depth-charge concentrations | Pursuing hovers, aircraft or dry-land targets |
| Battle submarines | Fire from range behind screen, preserve long-reload shots for valuable hulls, use external sonar | Blind pursuit into torpedo turrets |
| Battleships/missile ships | Protected ranged fire against reachable surface/static targets; prefer high-value shore economy for missiles | Building a missile fleet before anti-sub and AA protection |
| AA ships | Cover nearby valuable fleet and harbor; react immediately to observed aircraft; maintain some cover in otherwise safe fleets | Fixed AA flood before any aircraft, or waiting for five cruisers during a raid |
| Jammer/radar/anti-nuke support | Stay behind combat hulls; avoid duplicated coverage; stockpile interceptors; radar does not replace sonar | Leading attacks with support units; interpreting interceptor range as attack range |
| Construction/engineer/recovery units | Safe expansion, protected reclaim/repair, energy-funded build power, recovery after yard loss | Idle guard chains and overcommitted simultaneous projects |
| Seaplanes | Sonar scout exposes subs; torpedo aircraft engage water targets; surface gunships/bombers attack surface; fighters screen | Sharing ordinary ship movement assumptions or forcing torpedo weapons onto hovers |
| Amphibious/hover auxiliaries | Exploit shore access and islands; torpedo-resistant hovers counter underwater-only fleets; secure landing | Assuming a ship corridor proves a land route or changing AIR/TECH amphibious doctrine |
| Mines/static defenses | Cover chokepoints/retreat lanes, mixed surface/underwater weapons, sonar and AA coverage | Closing reserved shipyard exits or replacing mobile map control with base clutter |

The [per-unit annex](sea-unit-controls.md) enumerates 304 reachable shipyard,
seaplane and amphibious products, constructor structures and optional extras,
with actual weapons and control families. Scavenger-generated copies are outside
PvP scope. A list entry is not a claim of autonomous use or matchup verification.

## Existing policy and native trace

| Decision | AngelScript owner | Native continuation / engine mechanism |
| --- | --- | --- |
| Role selection and update | `setup.as`, `roles/sea.as`, `RoleConfig` | `CircuitAI::Update`, scheduler, script hooks |
| Economy and placements | `SeaBuild`, `SeaEconomy`, `SeaLayout` | `BuilderManager`, `EconomyManager`, builder tasks, `TerrainManager` reservations and movement areas |
| Production | `SeaFactories::Produce`, legacy `Sea_FactoryAiMakeTask`, optional `factory_configs_sea.as` | `FactoryScript`, `FactoryManager`, `RecruitTask`, engine build command |
| Enemy knowledge | role policy consumes snapshot | `EnemyManager`, `BattleAnalysis::Update`, LOS/radar/sonar events; no hidden-unit callback queries |
| Fleet task ownership | SEA retains native choices except opt-in attached-carrier children and hybrid scout AA response | `MilitaryManager::DefaultMakeTask`: Scout/Raid/Defend-to-Attack/AntiAir/Artillery/Support; `CExternalControlTask` yields game-owned queues; observed raids move Armada hybrid scouts to native AA |
| Movement and formation | native squad tasks | `SquadTask`, `AttackTask`, `PathFinder`, `MoveAction`, movement-area and threat queries |
| Firing | native fighter tasks | `CircuitDef` weapon categories/ranges; `CircuitUnit::Attack`, engine command queue and weapon target validation |
| Support / stockpile | native support/static dispatch | `SupportAction`, `SupportTask`, `SuperTask`, engine interceptor/repair mechanics |

Findings: optional production lists mislabel missile scout boats as anti-sub;
T2 uses fixed quotas rather than observed counter deficits; native squad attacks
periodically replace equivalent move/attack/fight queues. Initial suspicion
that formation rows used maximum range was corrected by tracing
`ISquadTask::AssignTo`: rows use minimum weapon range, while routing/engagement
gates use maximum range. The first candidate's unconditional switch to maximum
usable range lost the destroyer fixture. The range-advantage revision and even
attack-only order reuse also lost. **All these native movement changes were
removed**, restoring the original formation and command code. Current global
army-cost versus enemy-per-player quota comparison is not a local naval balance.
D-188 also left opening/economic regressions, funding double-counting and harbor
loss recovery gates. Each correction needs its own physical evidence.

## Changes, in order

1. Pin D-188 final DLL and data before edits; retain every prior benchmark.
   Add independent naval combat/order observation and reproducible supplied
   cases before drawing efficacy conclusions.
2. Add read-only native capability/contact queries, lazily called by SEA.
   Snapshot only current known contacts. Classify submerged, surface, hover,
   airborne and static targets separately. Native defaults remain unchanged.
3. SEA production uses pending-aware counter deficits, capability-checked
   candidates and build-time-aware selection. Emergency counters precede
   discretionary constructors; preserve recovery workforce. Keep fleet AA,
   sonar, reclaim and support proportions explicit in SEA settings. Reconsider
   at each factory completion and on the next one-second snapshot; finish
   current hulls rather than repeatedly canceling production.
4. Experiment with SEA-only command equivalence and target-layer ranges.
   Keep compatible active orders, update changed targets/formation goals or
   empty queues immediately. This is not a command-per-minute rate limiter.
   Do not rewrite all unit orders every role tick or claim a player selection
   group becomes one synchronized unit order in the Skirmish AI interface.
   Result: rejected after repeated surface losses despite fewer commands.
   Retained improvements issue no extra per-unit movement commands. Measure
   native order volume and AI time before proposing a different optimization.
   Subsequent trace found carrier-gadget/AI drone contention; test a generic
   passive ownership task opted into only by SEA, releasing when the host rule
   disappears. Separate Lua orders from non-Lua callbacks in all new APM claims.
5. Diagnose the Glacial opening gap from task transitions. Fix exact funding
   accounting and energy starvation without subsidizing natural benchmarks.
   Recover completed shipyard losses and preserve replacement-before-retire.
6. Iterate candidate-versus-pinned-control cases, then serial natural games on
   Glacial Gap, Supreme Isthmus, Tundra Continents, Serene Caldera and Erebos.
   Use multiple seeds and side swaps where needed; characterize faction effects.

## Test and acceptance matrix

| Test | Independent measurements and pass condition |
| --- | --- |
| Surface, subs, hovers | Actual damage, kills/loss metal, survival and target layer; zero impossible target orders; correct counter chosen with pending queue counted |
| Air/torpedo raid | First known contact -> response decision -> counter completion -> first damaging hit; detection and production latency reported separately |
| Shore static / artillery | Real firing from accessible water; protected standoff, no idle unreachable shore pursuit |
| Fog/sonar loss | No response to hidden injected units; detect when sensor coverage arrives; no stale target pursuit after confirmed destruction |
| Support/reclaim | Wreck reclaimed or resurrected, resources gained, support remains covered; interceptor stockpile and actual intercepted missile separately measured |
| Large fleet | 32/64/128 hulls; commands per game minute and per hull; duplicate signatures; real-time-factor/CPU from serial runs, not concurrent FPS anecdotes |
| Economic opening/scaling | First yard/constructor/nano/T2/fusion, resource stall/overflow, live build power, egress, recovery after loss, survival through equal observation windows |
| Isolation | SEA off control; unchanged AIR/TECH/TACTICAL script/config hashes except pre-existing migration integration; role switch restores opt-in mechanisms |
| Reliability | All affected experimental profiles compile; native and AS unit tests; transfer/death/cancellation; original immutable verdicts retained |

Pure tests cover counter deficits and impossible candidates, pending counts,
stable ties, two-resource funding, and order equivalence boundaries. Runtime
fixtures must observe the engine, not merely a policy log saying success.
Supplied games waive economy only explicitly and never compete with natural
economy records. A smoke PASS is neither combat victory nor a benchmark win.

## Benchmark claims

### Follow-up: stalled unstarted economy work

The Tundra repeat spent several minutes changing builder approaches to two
unstarted tidal slots while banks filled. A blanket switch to native builder
travel made the opening worse and is rejected. Test a SEA-only progress watch:
track the nearest assigned worker's distance to an unframed energy/converter/
nano project once per second. After 60 seconds without at least 96 elmos of
approach progress, cancel that unstarted task and exclude its slot for 90
seconds so another reserved slot can be tried. Never relocate a frame or a
factory, or cancel a human task. Expired exclusions and departed tasks must be
removed from the watch. This adds O(projects + assigned workers) work to the
existing census, without continuous movement commands. Test boundaries in
SeaMath, rerun natural Tundra and Glacial, and require actual energy growth,
tech milestones, survival and clean invariants before retaining it.

The rendered Tundra field also shows adjacent six-slot patches merging into a
solid obstruction. Test a 96-elmo placement exclusion between ordinary economy
patches (48 on each edge), leaving ship access alongside each small module.
Turret pads keep their existing dense reach-constrained geometry. The exclusion
uses the existing allied reservation engine, not a physical wall or movement
command. Compare energy growth and ship access on Tundra and Glacial; do not
claim the screenshot alone establishes the full navigation root cause.

**Outcome: both experiments rejected and removed.** The timeout-only Tundra
repeat reached T2 at 28:16, later than the preceding 20:00. Lanes plus timeout
lost the Tundra and Glacial bases without T2; lanes alone also lost Tundra
without T2. These do not justify changing the retained placement or task
lifetime. KI-235 remains open, with original runs retained.

Beat comparable retained measurements, not arbitrary rows with different
durations/bonuses/versions. Preserve the strongest prior Glacial T2 10:27 and
fusion 15:31 as historical targets; later paired legacy was 12:25 / 15:54.
Report every run and censored/eliminated run. Improving one stage while losing
the fleet is not acceptance. No global default activation until economy,
combat, isolation and runtime gates pass. Unmet gates remain documented with
reproduction evidence; do not label unfinished tests verified.
