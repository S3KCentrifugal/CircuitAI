# Shared ranged-combat cases

Definitions belong here; engine output belongs in the uniquely allocated
`build-theatres/games/shared/combat/<scenario>/<map>/<UTC-id>/` tree.
Published evidence is indexed separately in the
[benchmark catalog](../../../../../doc/benchmarks/README.md).

Run with [ranged_benchmark.py](../../../ranged_benchmark.py). Use the case file
stem, not its shortened internal scenario name. Keep seed, game, engine,
observer, supplied forces and observation duration fixed for comparisons.
The `baseline` variant requires pinned old DLL **and** data. The `siege`
variant changes only the staged role/attribute lists of the selected units.

| Family | Definitions / purpose |
| --- | --- |
| Unit firing | `ranged-armfboy`, `ranged-armfido`, `ranged-armsnipe`, `ranged-armmanni`, `ranged-cormort`, `ranged-corban`, `ranged-cortrem`, `ranged-legamcluster`, `ranged-legmed`, `ranged-legvcarry`: real shots or carrier-child damage, target clearance and survival. |
| Precision / safety | Sharpshooter and Starlight `repaired-bait` and `closing-assault`: defended bait and approaching assault. |
| Sensors | `ranged-mixed-sensors` on Glitters and `ranged-mixed-flat` on Comet: radar/jammer support, clearance and survival. `ranged-sensor-advance` adds a second defensive line to exercise continued forward coverage. |
| Weapon mechanics | `ranged-corban-air`, `ranged-splash-screen`, `ranged-armsnipe-energy-starved`: compatible AA, friendly splash and energy-starved firing/cloak. |
| Lifecycle | `ranged-foreign-death`: an unrelated allied constructor dies while ranged tasks remain active. |
| Load | `ranged-population-120`: five explosive-target waves, commands, survival and engine timing. Run performance trials serially, with diagnostics disabled. |
| Configuration | `ranged-profile-load`: all ten types admitted in each supported profile; one-minute load smoke, not a combat-effectiveness benchmark. |

Assertions and observer behavior are explicit in each JSON. A watch PASS means
the original checks passed; the versioned measurement file separately evaluates
combat acceptance. Retain failures, including invalid fixtures and crashes.
Do not count a designed case, generated index entry, or source inspection as a
played result. The [implementation and limitations](../../../../../doc/ranged-combat.md)
explain which mechanics are engine-owned and where evidence remains limited.
