# SEA policy to engine trace

Read alongside the [plan](sea-combat-enhancement-plan.md) and [roster](sea-unit-controls.md).
These are code ownership and complexity findings, not measured speedups.

| Stage | Active source and behavior |
| --- | --- |
| Engine callback | [AIExport](../src/AIExport.cpp) enters [CCircuitAI::HandleEvent/Update](../src/circuit/CircuitAI.cpp). `EVENT_UPDATE` runs scheduled work; creation, completion, damage, destruction and LOS/radar events also drive managers. It is not one script loop over every unit every rendered frame. |
| Role installation | [setup](../data/script/src/setup.as) chooses role delegates. [RoleSea](../data/script/src/roles/sea.as) installs builder/factory/update hooks. Migration calls `SeaLayout::Init`; only active SEA calls `SeaBuild::Tick` and `SeaCombat::Tick`. |
| Contact memory | [EnemyManager](../src/circuit/unit/enemy/EnemyManager.cpp) and enemy-unit events maintain known definitions and contacts. [BattleAnalysis](../src/circuit/terrain/BattleAnalysis.cpp) offers a separate, explicitly invoked `SampleNavalThreat`. This loops known enemies once, rejects hidden/neutral/dead/ignored contacts, constrains naval contacts to a connected water body and radius, and separates current underwater/surface/air/static costs. It does not issue orders. |
| Script surface | [InitScript](../src/circuit/script/InitScript.cpp) registers the four weapon-capability methods and snapshot methods. An unregistered native method cannot be used by scripts. A matching DLL/data pair is mandatory. |
| Procurement | [SeaFactories](../data/script/src/roles/sea_factories.as) and [SeaCombat](../data/script/src/manager/sea_combat.as) choose one available, buildable unit at a time. [FactoryScript](../src/circuit/script/FactoryScript.cpp) counts pending recruits without framed units; [FactoryManager](../src/circuit/module/FactoryManager.cpp) and [RecruitTask](../src/circuit/task/static/RecruitTask.cpp) execute factory work. A counter decision is not counter completion. |
| Missing factory metadata | `Sea_Init` explicitly calls `RegisterScriptFactory` for Legion's advanced yard when migration is enabled. Hard/terrible profiles omit its native table. The generic mechanism keeps existing metadata, derives actual mobile build options, and copies the prototype's lifecycle handlers. Zero start/switch importance leaves procurement in script. The gate reads the setting because role initialization runs before layout activation. No global profile table is changed. |
| Fleet ownership | [MilitaryManager::DefaultMakeTask](../src/circuit/module/MilitaryManager.cpp) selects native scout/raid/defend/AA/artillery/support tasks by loaded roles. Defend squads promote using reachable enemy-group power and a script-configurable wait. Existing damage events can force earlier task updates. |
| Grouping and approach | [AttackTask](../src/circuit/task/fighter/AttackTask.cpp) merges compatible movement classes and speeds nearby. [SquadTask](../src/circuit/task/fighter/SquadTask.cpp) lays out range rows/arcs. [PathFinder](../src/circuit/terrain/path/PathFinder.cpp) and [TravelAction](../src/circuit/unit/action/TravelAction.cpp) handle routes. Minimum weapon range controls formation rows; maximum range participates in approach tests. A blanket max-range substitution was experimentally worse and was removed. |
| Firing | [CircuitDef](../src/circuit/unit/CircuitDef.cpp) derives target-layer capabilities from weapons/categories. [CircuitUnit](../src/circuit/unit/CircuitUnit.cpp) submits move/attack/fight commands through the generated engine wrapper. The engine still decides legal firing, projectile trajectory, turret aim and damage. A group task is not one network command for the whole fleet. |
| AA and siege | [AntiAirTask](../src/circuit/task/fighter/AntiAirTask.cpp) and [ArtilleryTask](../src/circuit/task/fighter/ArtilleryTask.cpp) own their existing movement/targeting. SEA procurement must not infer anti-sub capability from a scout or frigate name. |
| Hybrid scout AA | `SeaCombat::MilitaryTask/AirResponse` assigns Armada's hybrid scout/AA boat to the existing native AA task during observed raids. A one-second scan transfers only SCOUT tasks; player, retreat and existing AA tasks are preserved. Removal clears tracked IDs; role exit returns surviving responders to default task selection. Global UnitDef roles and other AI roles are unchanged. |
| Repair and withdrawal | [FighterTask](../src/circuit/task/fighter/FighterTask.cpp) responds to damage, shields and configured retreat thresholds; [RetreatTask](../src/circuit/task/RetreatTask.cpp) handles withdrawal. Current experimental profiles can set naval retreat to zero. The candidate does not silently override every faction's retreat policy. |
| Escorts | [SupportTask](../src/circuit/task/fighter/SupportTask.cpp) allocates sensor escorts using movement compatibility and squad coverage. [SupportAction](../src/circuit/unit/action/SupportAction.cpp) already preserves a current guard order. Specialized carrier/drone and weapon-mode commands require their own fixtures. |
| Carrier children | SEA checks the game's `carrier_host_unit_id` rule and calls the generic [ExternalControlTask](../src/circuit/task/common/ExternalControlTask.cpp) through [MilitaryScript](../src/circuit/script/MilitaryScript.cpp). This task issues no commands, including on damage, idle or movement failure; removal of the owner rule returns the drone to native idle/task selection. Only SEA opts in. Human-owned tasks retain precedence. |
| Economy | [SeaEconomy](../data/script/src/manager/sea_economy.as) measures owned units and retained pinned work; [SeaBuild](../data/script/src/roles/sea_build.as) prioritizes expansion, resource balance, T2 package, upgrades and existing-power assistance. [EconomyManager](../src/circuit/module/EconomyManager.cpp) supplies allied-aware, safe/reachable mex selection and shared services; [BuilderManager](../src/circuit/module/BuilderManager.cpp) executes tasks. |
| Space and egress | [SeaLayout](../data/script/src/manager/sea_layout.as), [TerrainManager](../src/circuit/terrain/TerrainManager.cpp) and [NavalGeometry](../src/circuit/terrain/NavalGeometry.h) reserve shipyard/support/exit space. Straight berth egress does not prove a clear ocean route around future allied structures. |
| Stalled approach | A SEA-only progress timeout and wider patch gaps were tested and removed after natural-game regressions. The underlying tidal access failure remains KI-235; neither experiment modifies the final native travel or layout policy. |

## Runtime budget and remaining work

With `U` owned units, `E` known enemies, `P` pinned/recruit tasks and `R` the
fixed naval roster, the new threat snapshot costs O(E) per simulation second.
The economy census is O(U + P + berths); fleet value is O(R). A factory choice
uses O(R * pending-recruit scan + U + P), with a small fixed R, not all friendly
versus all enemy pairs. Pending counts must stay fresh at admission, so blindly
caching them for a second could overproduce counters. Capital assistance uses
two owned-unit passes per free worker request; it is not an all-pairs per-frame
scan. Forward-site candidates are capped before full cover checks.

The policy sends no per-unit fleet movement orders. It can hand carrier children
to a passive task once per ownership change. Existing native repeated
formation queues can nevertheless produce high synchronized APM. Two attempts
to suppress them reduced APM but lost previously won surface fixtures; both
were removed. Preserve every result and investigate command types before
proposing a replacement. An APM cap would hide the symptom and delay reactions.

The arena observes the engine's aggregate AI timer and command callbacks.
Total callbacks include game-gadget orders, which are not AI network packets.
The revised observer reports `fromLua` sources and per-definition counts;
non-Lua orders remain a proxy, not a byte or packet count.
Concurrent games cannot establish a CPU/FPS improvement; later surviving-unit
counts also differ. Use serial fixed-population windows for scaling claims.
The timer covers all AI callbacks, not just the SEA policy or pathfinding.
