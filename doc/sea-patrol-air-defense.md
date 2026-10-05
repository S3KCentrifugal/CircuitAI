# D-202: independent SEA patrols and dispersed air interception

Baseline `f353f926`. The reported Herring ball has two verified source causes:
experimental_hard overrides corpt to AA-only, and D-201's hybrid scout response
recognizes armpt alone. Native AntiAirTask merges squads and uses a shared
regroup point. D-201 explicitly excludes AA tasks from its director.

## Mechanics and design

The official [Herring guide](https://www.beyondallreason.info/unit/corpt) describes
spotting, sonar and light air defense; it warns against treating these boats as
a strong answer to serious air attacks or direct surface/sub combat. The
[Skater](https://www.beyondallreason.info/unit/armpt) fills the corresponding
patrol role; [Arrow Storm](https://www.beyondallreason.info/unit/corarch) is a
dedicated heavier AA option. Loaded weapon ranges determine spacing, not the
largest surface weapon or a hardcoded faction statistic.

SEA receives a separate scout/AA controller, independent of shared role labels.
Eligible T1 scout boats patrol distinct leased water sectors when no aircraft
threat needs their AA. Dedicated AA ships patrol dispersed coverage sites within 2,400 elmos of the start coast.
All available AA ships in a threatened connected sea interrupt their ordinary
patrols for interception, including flanks and aircraft transiting toward allies.
Player control, transport/carrier ownership and active repair retreat remain
protected. Non-AA scouts keep scouting. Other roles keep their native behavior.

Patrol sites use a bounded coarse water grid, unique leases and least-recently
visited preference. Every destination checks the hull's movement area and known
surface/sub danger. AA interception tests only known naval weapon/sonar danger,
so the aircraft being intercepted cannot repel its own counter through the
general danger map. Unavailable space does not make all ships fall back to the
same point. Patrol commands persist until expiry or safety/ownership changes.

Aircraft come from the existing legal once-per-second contact snapshot. Last
observations estimate motion; no unseen live positions are read. Same-sea ships
respond to the contact nearest the protected coast, anticipate its flight path and occupy separate
rows/columns, spaced from the minimum AA range with substantial overlap. Near
coasts invalid cells are replaced by distinct reachable water positions. Ships
hold their assigned area while weapons prioritize aircraft; no shared ATTACK
destination pulls the formation into a ball. Lost contacts expire, then scouts
resume coverage. Formation refresh follows changed threats, not a global rate cap.

Native additions are opt-in mechanisms: actual movement-area validation and a
SEA route's priority-fire target using BAR's target-on-the-move command. The old
CmdSetTarget stub must not be enabled globally. Target cleanup and task ownership
are explicit. All thresholds/geometry and admission policy remain in script.

## Verification

- Pure VM tests: slot uniqueness/separation/overlap, intercept projection boundaries; original native/AS suite and API parity.
  Runtime fixtures exercise patrol release/resumption and contact expiry.
- Supreme supplied Cortex fleet: individual movement/patrol coverage, no raid;
  direct aircraft and edge transit; physical AA damage, separation and return
  to patrol after threat removal. Repeat for Armada and Legion AA capabilities.
- Observer records actual boat positions, commands, aircraft damage and target
  provenance; policy log lines alone do not prove coverage or interception.
- Natural Supreme run checks factory/economy compatibility and formation views.
  Preserve failures and screenshots. Do not infer multiplayer packet or FPS
  improvement from local command counts.

Performance contract: bounded static water candidates; O(U*B + A*B + U*A + U*P + K*E)
worst-case policy work for ships U, water bodies B, current aircraft A, patrol
candidates P (at most 1,024), distinct interception candidates K (at most 49*U),
and known sea contacts E. A per-census safety cache shares overlapping formation
candidates. This is not a constant-time claim for the entire controller.
Patrol selection runs on assignment/expiry, not every frame. Stable leases and
slots avoid sorting/reassigning every boat when one dies. Native engine callbacks
stay on their owning thread; route commands update only when intent changes.

## Faction classification and ownership

The JSON `role` array is not a list of own-unit roles. In
[FactoryManager::ReadConfig](../src/circuit/module/FactoryManager.cpp), only the
first entry is assigned as the main role; later entries describe enemy response
categories. Iapetus (`legnavyaaship`) is scout-first. SEA therefore explicitly
recognizes the ordinary dedicated AA hulls and Skater/Herring, still requiring
an actual native AA weapon. Hippocampus (`legnavyscout`) and Supporter
(`coresupp`) retain individual scouting: incidental fire against aircraft does
not make their short-range weapons determine the AA screen's pitch.

No shared unit classifications, factory production weights, economy rules,
AIR policy or TECH policy change. `AdaptiveFleet` and `FleetOperations` gate
the controller; `HybridScoutAirResponse` gates interruption for aircraft.
The existing player/carrier/repair-retreat exclusions remain. No blanket order
rate cap is added. SeaPatrol acquires IDs, releases sector leases on loss or
handover, and releases all its routes on role exit. Contacts use the existing
legal enemy snapshot; unidentified radar blips do not reveal an aircraft type.

New script settings in `Global::RoleSettings::Sea`:

| Setting | Default | Purpose |
| --- | ---: | --- |
| `ScoutPatrolSeconds` | 120 | Revisit sector selection after this interval; danger interrupts sooner. |
| `ScoutPatrolCell` | 640 | Nominal sector pitch, enlarged on maps wider than 32 cells. |
| `NavalAAFormationSpacing` | 320 | Destination spacing, capped at 55% of the shortest participating AA range. |
| `NavalAAColumns` | 6 | Stable centre-out columns; additional ships fill more rows. |
| `NavalAAInterceptSeconds` | 12 | Maximum straight-line prediction, based on distance from the nearest AA hull. |
| `NavalAAContactMemorySeconds` | 8 | Brief movement memory after legal contact disappears; priority fire clears immediately. |

Ships retain engine collision avoidance and normal repair retreat. Destinations
are separated on one rotated grid; minimum physical spacing cannot be promised
while moving ships cross paths or pass narrow terrain. If there is no safe
interception cell, ships retain individual coverage and shoot aircraft already
in reach instead of gathering at one fallback point.

## Test review corrections

The first prototype's broad damage check passed Legion despite assigning the
wrong ships. Detailed ID/type analysis rejected that result: scouts with weak
incidental AA joined, while scout-first Iapetus hulls did not. The final check
requires both Iapetus assignment and physical Iapetus damage. Original verdicts
are retained with this review correction rather than rewritten.

Two further corrections were made before final regression runs: the initial
travel point was removed from normal patrol loops (avoiding trips back to the
spawn), and interception lead now uses the closest AA ship rather than the
commander's start. These were behavioral refinements, not behavior-preserving
performance optimizations.

[Completed verification and retained evidence](sea-patrol-air-defense-results.md).
