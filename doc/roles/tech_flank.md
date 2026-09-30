# TECH specialist flank production

D-136 adds one dedicated advanced bot factory when TECH's ten-second minimum
metal income reaches +200 and its start can reach an all-terrain specialist
lane by land. The ordinary advanced lab must exist first and remains available
for normal constructors, fast bots and other production. T1 spam is unchanged.

`Work` is the `flank.factory` rule, after current construction and dedicated air
economy work, before forward defenses and the economic chain. It only uses land
constructors with the effective factory build option. It reserves a buildable
footprint with a clear exit, tests constructor reach, and separately tests the
combat route from that site. The pending order is shared, so repeated builder
asks do not create duplicate labs. Failed orders retry; a lost lab is replaced
once the income gate is met again.

`Select` uses native `GetLaneRoute`: a connected approach to the friendly lane
end, followed by every lane cell. It rejects unreachable lanes instead of
snapping across water. Selection favors sustained elevated routes and keeps a
standing factory in the same theatre. This does not use transports.

`Owns` identifies the dedicated lab by stable ID and reserved site. Factory
registration excludes it from the normal primary advanced lab. Base-factory
reclaim excludes it too; lifecycle retirement is still authoritative. `Count`
includes its frame and `NormalLabCount` subtracts it from ordinary T2 accounting,
so it neither triggers base rezoning nor prevents ordinary lab replacement.
`Produce` queues one combat unit per completion indefinitely, independently of
later income dips. Defaults are Recluse (`armsptk`), Termite (`cortermite`) and
Arquebus (`legsrail`); the effective factory build option is checked at runtime.

`MilitaryTask` accepts only the dedicated factory's offspring, using the native
creation-event producer ID. `Route` gives them an unspread waypoint task with
48-elmo arrival tolerance, preserving intermediate mountain waypoints and
fighting at the destination. Other combat units keep their existing policies.

D-143: Arquebus has `behaviour/legsrail/standoff: 0.90` in every Legion
profile. The native route task pauses its queued waypoints for an observed,
targetable enemy near weapon range. It holds about 90% of the railgun's reach,
backs away from close targets, and resumes preserved waypoints when contact
is gone. It keeps the same task throughout (INV-067). Ordinary attacks also
use this range control. Zero disables it; units without the setting keep
legacy movement. This uses observed enemies only; allied vision/radar helps
exploit weapon range beyond the Arquebus's own sight radius.
`TaskRemoved` clears dead task handles; `UnitRemoved` clears membership before
unit IDs can be reused; `Tick` resolves live IDs and checks
INV-067. Factory/site and routed-unit markers use native layout integers for
save/load reconstruction; terrain routes are recalculated rather than storing
transient lane indexes. Survey revisions update the established theatre route
with preserved waypoints. Save/load runtime validation is pending (KI-426).

Settings in [lanes.json](../../data/config/lanes.json): `flank_enabled`,
`flank_min_metal`, `flank_site_radius`, and `flank_unit_<faction>`.

Verification: built and played on both sides of Glacial Gap with all three
factions. Natural-economy orders occurred at +203/+202 metal; both streams
reached the mountain and sustained production. See the [played review](../reviews/2026-09-29-tech-flank-production.md)
for fixtures, screenshots and the broader invariant failures.

<!-- source: data/script/src/roles/tech_flank.as; blob: 561fbe61c2d3ccaa13c814a61e1d5d6902b8ca4a; lines: 191 -->

## D-145: strategic mountain qualification

`Select` uses native `IsLaneSpecialist`, not class alone. Every selection attempt
first clears `laneQualified`; only successful reachable selection sets it.
`Produce` checks this flag after revision revalidation, preventing a failed
refresh from allowing the next ask to reuse an old route. Ordinary factory
composition remains separate from dedicated mountain-flank production.
