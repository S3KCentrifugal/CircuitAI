# AIR ordered building rules

`AirRules::MakeTask` is a total dispatcher for a valid owned builder while
`Air.ExperimentalBuild` is enabled. A successful action ends evaluation;
otherwise the next action is tried. Every construction action rechecks current
capability, queue and reservation state. Economy observations are cached once
per second; existing construction stays assigned.

| Order | Rule | Purpose |
| --- | --- | --- |
| 1 | current construction | Finish committed work before choosing another project |
| 1a | `opening.commander.guard`, `commander.energy.assist`, `commander.energy.local`, `commander.local.assist`, `commander.factory.guard` | With a live air plant, commander finishes/guards production through three completed T1 constructors; local recovery may prevent a stall; subsequent work stays local |
| 2 | `recovery.resume`, `recovery.assist`, `recovery.energy` | Recover an energy order, finish energy or add quickly payable supply during a sustained stall |
| 2a | `project.resume` | Reassign an owned orphan order before adding another project |
| 3 | `opening.mex`, `opening.energy` | Three nearby mexes and initial energy before the starter |
| 4 | `transport.plant`, `opening.plant` | Recover or build the T1 air plant, retaining transport capability |
| 5 | `mex.upgrade`, `mex.assist` | Upgrade all owned basic mexes without a base-radius restriction; help existing frames |
| 5a | `fusion.first` | Target fusion by 20 minutes; no reactor until all mexes finish |
| 5b | `support.assist`, `production.support` | Finish a support turret or grow funded support before general preparation assistance |
| 5c | `fusion.access`, `fusion.prepare.assist` | Obtain T2 access and assist committed projects |
| 5d | `mex.expand` | Before first reactor, at most six self-expanded mexes and no new expansion after preparation starts; normal expansion resumes with reactor income |
| 6 | `storage.buffer` | Fund the first wind buffer without starvation |
| 6a | `transition.bay` | Admit a funded first T2 package before the moving T1 energy-growth target can starve it |
| 7 | `energy.assist`, `energy.grow` | Supply aircraft demand and T1 economy growth |
| 8 | `intel.radar`, `defence.flak` | Radar and bounded T2 AA against observed aircraft |
| 9 | `storage.metal` | Save income needed for a funded T2 package |
| 10 | `production.bay` | Fund first T2 or one additional independent bay |
| 11 | `storage.energy`, `surplus.convert` | Buffer fluctuations; convert only surplus with metal capacity |
| 12 | `service.queued` | Explicit native repair, defence and radar service |
| 13 | `project.assist`, `production.assist`, `wait` | Useful nearby work, short factory guard, or bounded retry |

The factory recruiter separately prioritizes allied transport obligations, then
one initial scout, three completed constructors, an immediate fighter screen, funded income-scaled economic builders,
the full interception floor, a finite T1 strike, heavies and escorted waves.
Task priority controls engine resource priority; admission gates and available
build power also limit competing spending.
While preparing first fusion, optional aircraft wait after the defensive floor
and constructor quotas. Transports remain first. The 20-minute target cannot
override any pending owned mex upgrade, including distant or gifted mexes.
The initial scout is latched on completion, so its loss cannot restart the
opening. Legion uses its first Noctua as that scout. Completed constructor
counts control the commander; frames and pending recruits only suppress duplicate orders.

This sequence deliberately keeps the T1 utility plant when T2 starts. It has no
TECH rush chain, gantry ladder, dense reactor block or automatic lab reclaim.
Turning the feature off returns AIR to its existing legacy dispatcher.

See [building actions](air_build.md), [AIR integration](air.md),
[implementation/evidence](../air-management.md).

<!-- source: data/script/src/roles/air_rules.as; blob: 4cfeb8cab90918e3df2fcf4a3910b467a59dd8ff; lines: 128 -->
