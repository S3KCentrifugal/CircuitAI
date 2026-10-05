# SEA fleet rework: intelligence, initiative and underwater screening

Design recorded before behavioral edits, 2026-10-05. Baseline: `2989415b`;
the supplied Glacial surface-line baseline engages by 0.5 game minutes. This
does not reproduce every reported parked fleet. Existing D-189 naval work and
its failed formation experiments remain evidence, not discarded history.

Implementation and played acceptance are recorded in the
[results report](sea-fleet-rework-results.md). The design below is broader than
the fixtures completed; unplayed acceptance rows remain explicit there.

## Findings and PvP interpretation

The [official naval guide](https://www.beyondallreason.info/guide/basics-on-sea-warfare)
explains distinct surface/underwater/hover layers, the need for sonar, and the
value of repairing and reclaiming expensive ships. Radar alone does not reveal
submerged opponents. These facts favor a screened fleet with forward vision,
not a periodic blind charge. [Corsair](https://www.beyondallreason.info/unit/armroy)
has separate 700-range surface and 400-range underwater weapons: its largest
range cannot be used as its anti-sub engagement distance.

The current [Argonaut](https://www.beyondallreason.info/unit/legnavyfrigate) and
[Syracusia](https://www.beyondallreason.info/unit/legnavydestro) pages and local
BAR `units/Legion/Ships` definitions corroborate the faction distinction:
Legion's frigate has torpedo weapons; its destroyer's surface weapon/drone
system does not substitute for an underwater counter. Effective loaded weapon
capabilities and build edges must still decide admission, not translated names.

The following tactics are engineering proposals inferred from those mechanics,
not a claim that a fixed metal ratio is an established or optimal PvP formula.

## Baseline source trace and diagnosed gaps

- [SeaCombat](../data/script/src/manager/sea_combat.as) is gated by experimental
  layout, default off. Procurement counts global hulls, including those far
  from the threatened water body. Scouts are guaranteed only below 1,000 fleet
  metal. The emergency selector is skipped until two constructors of that tier.
- [RoleSea](../data/script/src/roles/sea.as) falls back to static batches and
  map-wide cost quotas outside experimental building. Combat should have its
  own SEA-only switch and continue using the chosen economy implementation.
- [DefendTask](../src/circuit/task/fighter/DefendTask.cpp) already has a wait cap.
  Another unconditional four-minute ATTACK order does not fix finding a target
  after promotion. [AttackTask](../src/circuit/task/fighter/AttackTask.cpp) uses
  shared enemy groups and leader capabilities; no-contact fallback returns to
  friendly fronts/base. Artillery uses a separate task, consistent with the
  reported distinction but not yet proof of the exact player-match cause.
- `SEnemyData::IsHidden` includes IGNORE. Existing naval threat sampling checks
  IsHidden before its exception for profile-ignored units, making that exception
  ineffective. SEA needs a separate, legal-contact snapshot respecting true
  fog, neutral/dead states and game `ignoredByAI`, independent of threat weights.
- Native formation and broad order-suppression experiments previously lost
  fixtures. Preserve working native engagement where possible and test any
  alternative against that baseline. No global classification changes.

## Implementation stages and ownership

1. Separate adaptive SEA combat activation from layouts. Maintain a SEA-owned
   once-per-second ID census. Counter/scout selection runs with either economy;
   retain one recovery constructor before emergency hulls, then return to
   workforce/economy. Pending recruits count at admission, not from stale cache.
2. Add an opt-in SEA contact snapshot in BattleAnalysis, without changing AIR's
   existing naval support snapshot. Expose scalar contact accessors. Respect
   legal knowledge and water connectivity. Include static coastal objectives.
3. SEA operation groups organize compatible surface, underwater and support
   hulls. Use shared native route/path mechanisms for approach/search/withdrawal,
   with retained objectives and formation lanes rather than orders every tick.
   Preserve player, transport, retreat and game-owned carrier tasks. Keep
   missile/capital artillery's working task unless screened withdrawal is needed.
4. Provide finite assembly/search deadlines and distributed scout objectives.
   Replenish scouts after opening; send available scouts without a large wave.
   Search reachable water/frontier objectives when no legal contact exists.
5. Compute underwater deficits from weapon-qualified nearby completed cover
   and queued reinforcements. Surface-only groups must not advance through
   detected underwater danger while coverage is insufficient. Route around or
   fall back to a reachable safe anchor; counters engage at their actual layer
   range. Reassess promptly when threat/cover changes, not at a four-minute gate.
6. Form a surface line with underwater screen, AA and sensors behind it; use
   shorter anti-sub ranges when engaging submarines. Terrain-check formation
   offsets; narrow channels collapse width. Do not push ships onto shore.

## Faction and unit use cases

The [complete reachable naval roster](sea-unit-controls.md) enumerates each
definition, factory edge, weapon layer and current control. Use it alongside
this table; an enumerated unit is not a tested special mechanic.

| Class | Armada / Cortex / Legion | Intended use and constraints |
| --- | --- | --- |
| Scouts | Skater / Herring / Legion scout | Independent forward and flank vision, sonar where actually present; avoid known weapon envelopes. Hybrid AA may answer raids without consuming every scout. |
| Fast surface raiders | Dolphin / Supporter / Legion scout | Early exposed economy, flanks and cleanup; never count as underwater cover. |
| Surface line | Ellysaw and Corsair / Riptide and Oppressor / Syracusia | Broadsides/line pressure. ARM/COR destroyers contribute discounted underwater cover; Legion destroyers do not. |
| T1 underwater | Eel / Orca / Legion sub and Argonaut | Counter unescorted surface forces and subs, secure underwater economy; check sonar, depth and weapon category. |
| T2 cruisers and hunter subs | armcrus/armsubk / corcrus/corshark / leganavycruiser/leganavybattlesub | Mobile screen and immediate underwater response; avoid crediting surface guns as anti-sub power. |
| Long-range subs | armserp / corssub / leganavyheavysub | Underwater standoff with forward sonar; do not assume max range supplies vision. |
| Dedicated AA | armaas / corarch / leganavyaaship (plus T1 Legion AA) | Follow fleet rather than replace its anti-surface/underwater screen. |
| Battleships, missile ships, flagships | faction T2 siege roster | Coastal siege after securing water; protect against subs and aircraft. Preserve existing artillery task during first migration. |
| Recovery and construction | resurrection subs, engineers, construction ships/subs | Repair and reclaim behind screen; constructors retain builder ownership and economic duties. |
| Utility | jammers, radar/sonar, mobile anti-nukes/generators | Escort; jammer is not sonar. Preserve game stockpile/anti-nuke mechanics and carrier child ownership. |
| Seaplanes, hover, amphibious | roster's auxiliary factory edges | Separate movement/target layers; use current native tasks initially. Dedicated invasion and air coordination require their own fixtures before migration. |

## Complexity and command budget

One legal contact scan O(E) and owned census O(U) per policy interval; group
scoring O(G*E) plus utility attachment O(S*G), not every ship against every enemy
every frame. The snapshot also sorts C contacts in O(C log C). G depends on
active water bodies and compatible cohorts. Route searches run on objective
changes or expiry, not every census. Retain group/member state and compare
orders before replacing routes. Do not claim O(1) planning or one network
packet for a fleet. Engine callbacks remain on their owning thread.

## Verification and acceptance

| Test | Required observation |
| --- | --- |
| Pure policy | Assembly expiry, no-target search, weapon-layer admission, pending counts, range/cover boundaries, deterministic ties |
| Surface baseline pair | Contact and damage latency, survivor metal, native formation regression, order sources |
| Distant/fog fleet | 7+ frigates progress without periodic user orders; split scout searches reveal new contacts |
| Three-faction sub cases | Surface-only ships avoid unsupported push; correct faction counter starts and fires; submarines are actually damaged |
| Production under constraint | Responses still occur with limited economy, interruption does not permanently starve workforce |
| Carrier/AA/siege | Preserve gadget ownership, hybrid AA and previously working artillery |
| Natural Glacial/Supreme/Shore | Economic milestones, ocean control, orders and stalled hulls; no other-role policy changes |
| Role exit / switch disabled | No retained SEA route ownership after leaving SEA; native defaults restored |
| Profile compile | Hard, balanced, terrible compile with matched DLL and scripts; API/static/invariant checks |

Use categorized cases and retain each original verdict, hashes and screenshots.
Report implemented versus deferred mechanisms and measured outcomes separately.
No whole-game win-rate or optimality claim follows from one supplied fixture.

## Implemented policy and maintenance decisions

The implementation uses a dedicated SEA extension over the existing naval
snapshot; AIR's original snapshot is untouched. Legally detected, unidentified
submerged contacts have unknown definition/cost and a script-controlled
500-metal uncertainty estimate. Legion tests exposed why this matters: sonar
contact does not imply a known UnitDef. The estimate may conservatively include
an unidentified submerged structure until identification resolves it.

An unchecked dictionary output in the initial census also invented enormous
coverage during simulation. DictIntOr chooses its fallback after failed get.
Its regression uses the real embedded dictionary add-on. Unrelated dictionary
call sites are not silently rewritten.

Counters are available under either SEA economy after one recovery constructor.
Actual weapons qualify each recruit, ranked by coverage per build time.
Completed cover is local to the water body; pending counts remain fresh and
AI-wide. Lost threat cost persists for 30 seconds. This budget is tunable, not
a guarantee that equal metal wins. Long-range battle subs require a mixed fleet:
the official [Serpent guidance](https://www.beyondallreason.info/unit/armserp)
describes vulnerability to close-range hunters; [Barracuda](https://www.beyondallreason.info/unit/armsubk)
provides fast underwater assault. Neither replaces scouting or screening.

Scouts have independent water searches and avoid observed surface-weapon range
with a 128-elmo margin. Other cohorts release at seven ships or 60 seconds and
refresh objectives after 45 seconds. Approach uses spread route lanes; close
contact returns to native combat/repair formations. No global order throttle.

Surface-only ships, including siege, withdraw from nearby underwater danger
without adequate local cover. Siege regains artillery when safe. Sensor/ABM
ships follow combat cohorts from behind; builders/recovery subs retain builder
ownership, carriers retain gadget control, and AA keeps native interception.
No other role opts into SeaControl or SeaOperations.

This release does not claim optimized matchup coefficients, specialized weapon
modes, amphibious invasion coordination or every extra-unit mechanic. The full
roster retains those use cases and the acceptance matrix identifies next tests.
Save/reload, role-exit stress and multiplayer traffic need separate evidence.
