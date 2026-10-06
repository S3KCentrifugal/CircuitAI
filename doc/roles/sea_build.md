# SEA construction migration

`SeaBuild::MakeTask` is enabled by `Sea::ExperimentalBuild`, still default off.
Default-on `Sea::CompactEconomy` uses `LegacyTask` around the old role decisions
with the same layout owner. `PlacementKind` recognizes naval definitions even
when old helpers label them FACTORY; `ControlledEconomy` excludes coastal land
work. See the
[migration plan](../sea-layout-migration-plan.md).

`LayoutTask` also filters the shared builder manager's native fallback. Later
ordinary shipyards are replaced with reserved berths; the first shipyard keeps
its opening exception. Null still permits native resource expansion. D192
reserves complete 48-site tidal blocks, keeps economy behind the harbor, and
requires later shipyards' whole footprints to clear the economy frontier by
`FactoryEconomyClearance` (128 elmos) while facing the enemy. The later-yard
search uses `ForwardHarborSearchRadius` (2400), anchored to a harbor rather
than a potentially inland start. See the [allied-base plan](../sea-allied-base-plan.md).
Compact mode preplans `PreplannedYards - 1` future T2 berths (at least one)
after the opening; `FirstPlannedHarborAdvance` starts their search 768 elmos
forward. This lets the rear economy planner find space before converters are
needed, without changing factory purchase gates.

`Tick` refreshes the live economy snapshot, reconciles berth lifecycle and
productive guards, and preplans dense rear pads of `ReservedSupportPerFactory`
turrets (20 by default, capped by `MaxSupportPerBerth`). `ReserveSupport` covers
both planned berths and acquired shipyards/amphibious production. `MakeTask` preserves
PLAYER/enemy-reclaim/current construction ownership, resumes abandoned pinned
orders, opens a nearby shipyard and assigns economic work. `Leave` clears owned
projects and restores native switches when the role changes.

`NativeTask` temporarily opens the native task chooser to retain its path-cost
mex expansion, geothermal, reclaim, repair, storage and threat-defense services.
Native creation runs early for the commander/mex expansion worker, and only
after SEA's economy/harbor priorities for the others. Returned unstarted energy, converter, nano and ordinary shipyard orders are
replaced with required layout pins. Its native return is created at most once
per request. `Resume` recovers unassigned pinned orders before admitting more.
Auxiliary ship factories/seaplane platforms retain their existing native
placement; they are not yet certified product-aware naval berths.

`Place` packs economy groups; `Upgrade` considers only owned weaker extractors
that the requesting builder can reach and whose terrain admits its actual
naval mex. Metal fields use the shared field-upgrade mechanism. `Support`
funds turret expansion using current resource usage and the actual product's
cost/build time. `SupportTarget` shares the production allocation across busy
factories by their native build power; banked capital can fund growth even at a
current deficit. Purchase and subsequent consumption must both be funded.
Finished, framed and queued turrets count once, including frames created since
the latest census. The least-supported factory relative to its target is served
first. Every slot must be in assist range (INV-135). Search retries belong to
the individual site so one difficult harbor cannot block all others.
Shipyards, amphibious complexes, floating hover plants and underwater gantries
qualify; shipyard tech/handover policy remains separate. `Assist` finds reachable
unfinished work or productive nearby supported factories.
`CapitalAssist` lends nearby existing T1/commander build power to an unfinished
T2 yard or naval fusion when both resource budgets permit. It preserves the
dedicated expansion ship and T2 mex workers, limits simultaneous assistants,
and retains an already productive repair task rather than reissuing it.
`Wait` is the bounded idle fallback, not a permanent guard lease.

A stalled-approach timeout and wider economy-patch lanes were tested and
removed after natural-game regressions. Constructor movement retains the preceding behavior; see the [results](../sea-combat-results.md).
Economy packing now follows [D190's targeted plan](../dense-economy-plan.md):
tidals, converters and T1 economy use zero internal footprint gaps. Six-slot
patches extend sideways into two-row strips where space permits, leaving access
from the outside; factory exits retain their geometry. D191 routes converters/fusions to
`SeaEcoLayout` blocks: a reserved 4x4 touching turret grid, a rear fusion within
all turret ranges, then dense converter rows. A persistent preparation request
lets T1 constructors build the initial two turrets for T2 subs. Further support
is funded against the active fusion workload. Blocks use enemy-start strategic
facing independently of hull orientation, replan before first use when blocked,
and stay fixed after activation. Cheap T1 converters are retained across the
T2 transition; native tier-reclaim tuning is restored on SEA role exit.
See the [block results](../sea-economy-block-results.md).
Dense patches need only their per-building reservations, because a fully covered
envelope contains no additional cells. `LayoutHelpers::CheckGrid` checks native
snapping once at reservation time (INV-136). Existing active patches stay fixed.

One construction ship prioritizes mex expansion. Other T1 ships grow energy
toward `min(TidalEnergyIncomeMinimum, metalIncome * EnergyPerMetal)`.
T2 builders upgrade reachable mexes and repeat naval fusions when that energy
target remains unmet. Converter admission retains the native metal-map veto.
The commander retains native resource-expansion behavior after the first crew.
The designated expansion ship tries reachable, allied-aware safe mexes before
native discretionary jobs. An idle shore commander no longer blocks recruiting
naval economic workers; actual commander factory assistance still counts locally.

Task ownership is deliberately narrower than a global task-added observer:
only successfully pinned SEA orders enter `SeaEconomy::projects`.
`LegacyTask` preserves null/native fallback and ordinary guard policy; extra
factory support leaves the commander and one construction ship on expansion.
`SeaEconomy::OwnsTask` recognizes those claims before native serves their slot;
the served reservation ID alone is insufficient during approach. Native
inactive build-chain tasks can be destroyed with their parent; retaining them
in a script ledger caused the recorded Glacial crashes. Framed cost is measured
from validated owned units, not borrowed task targets.

Verification and remaining rollout gates are recorded in the
[migration results](../sea-layout-migration-results.md). TECH, AIR and the
shared SEA/TACTICAL constructor ladder are unchanged.

<!-- source: data/script/src/roles/sea_build.as; blob: 2b7e47d00f98b0e7c230baca4623ce5b9102fbc1; lines: 478 -->

## D-209 follow-up

OpeningMex now runs before either builder path creates a native fallback. Its
worker is the actual first construction ship tracked by Builder lifecycle. This
corrects the compact path's converter-before-mex decision and the experimental
census's minimum-ID selection. Native allied-aware spot claims and ship-area
reachability remain authoritative; the 2400-elmo home radius is configurable.

Seaplane transitions precede optional economic jobs once a T2 yard finishes
and D-210's sustained-income, uncommitted-bank and protected-reserve forecast
checks pass. Otherwise normal economy work continues. Admitted projects finish
without cancellation on income fluctuations.
Platforms now use SeaLayout persistent footprints and require the configured
ReservedSupportPerFactory slots in range before admission. Existing valid slots
count; only the shortfall is reserved. A support-starved unclaimed platform site
continues its bounded placement search after ten seconds. Ordinary shipyards
retain product-aware ship exits; flying factories reserve no hull corridor.
