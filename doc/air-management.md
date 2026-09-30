# AIR building management

The experimental AIR role has its own economy, layout and ordered building
controller. TECH continues through `TechRules`, `TechBuild`, `TechChain` and
`Layout`. Both now share native allied reservations (D-153); their spending
sequences and cluster geometries remain separate.

## Layout and economy

The T1 starter has a rear bank of up to five ordinary construction turrets.
T2 production bays have two side banks, with up to twenty planned turrets and
separate build pads. The campus adds one bay at a time at a nominal 560-elmo
spacing; the configurable safety ceiling is twelve T2 plants, not a target.
The candidate search covers 25 rings in 128-elmo steps, allowing replacement
sites beyond the original crowded 2,048-elmo radius.
If terrain only fits a partial bank, capacity uses those actual slots. Standing
gifted plants are adopted in place and nearby support slots are fitted around
them. Windmills use atomically reserved 3-by-2 groups of six touching footprints,
with at least 144 elmos between group bounding circles. Existing slots are
filled and destroyed windmills replaced before new groups are opened. The
layout keeps native slot identity and named `air.wind.*` metadata. Other
ordinary energy/storage uses spaced patches. Its search expands
over 24 rings of 96 elmos, with 24 samples each; failed definitions back off for
three seconds. The earlier 12-by-12 search could exhaust its coastal candidates
and stop energy growth despite ample resources. Late reactors search a
separate rear region with a 700-elmo factory setback. This is separation, not a
claim of blast immunity.

Native reservations retain each factory/turret's identity through claim, frame,
completion and destruction. Compound plans publish only after their usable
slots have been reserved; rejected candidate slots are rolled back. Slot IDs
and bay coordinates are saved under `air.bay.*`, separate from TECH's metadata.
The overlay selects the active role's layout. Coordinates are checked before
native grid queries, including at map edges.

AIR holds six complete future T2 bays and two T1 sites when terrain permits.
TECH holds two future clusters per factory type. Native allied slot and zone
rectangles exclude other allied instances; full cluster envelopes also exclude
unreserved defense placement. Before the first order, an obstructed unused
cluster releases its claims and searches again. A claimed or started cluster
stays fixed. See [the shared contract](base-layout.md) and
[D-153 design](allied-layout-air-income-plan.md).

`AirEconomy` samples owned units and the ten-second low income once per second.
Each live in-range ordinary nano belongs to its nearest production bay once;
unfinished turrets are future capacity. Physical build speed comes from the
engine's unmodified worker time, in work/second, not the JSON `build_speed`
policy value. Production estimates use build time and metal/energy cost from
the loaded UnitDefs. The initial mix is seven fighters to three bombers.

AIR targets its first completed fusion by **20 minutes**, with every owned mex
upgraded before any reactor starts (D-148). A T2 air lab needs either a complete,
fresh ten-second window whose minimum metal income is at least +50, or the
lab's full metal cost in the bank (D-153). Mex completion no longer gates labs.
Further bays require sustained spare income for twenty seconds and useful
support on existing bays, unless the entire next lab is already banked. The
full-bank exception bypasses those expansion waits; the configured plant cap
and one unfinished lab limit still apply. The role
keeps growing T1 energy/storage while those conditions are unmet. Three bad
energy samples enter recovery; ten adequately buffered samples leave it.
Mobile construction targets scale at eight work/second per metal/second,
multiplied by 1.5 when metal floats. Loaded constructor work rates determine
counts, with ceilings of ten T1 and eight T2 constructors. After T2, the work
target splits 40%/60%, with three T1 and two T2 as the funded floors. Queued
recruits and frames count once. Growth requires a bank and cost forecast and
pauses in recovery; it follows the immediate fighter screen and precedes the
full interception quota. Factory turrets are not credited as mobile work.

The first advanced energy investment is ordinary fusion. Advanced fusion needs
an owned completed reactor plus the metal-income and bank gates; a frame does
not qualify. This gives AIR reactor income before its small mobile crew takes
on the much larger project.

Before the first reactor, AIR limits its own early expansion to six mexes and
closes that expansion when preparation begins. Owned gifts anywhere on the map
still count. Two advanced constructors can upgrade distinct spots while other
workers assist frames; the old 3,500-elmo upgrade limit is removed. Fusion is
blocked by any basic mex, unfinished advanced mex, or queued mex/upgrade,
including the reclaim-to-frame gap. The check uses loaded extraction rates,
covering cloaked/armed/underwater variants without changing shared catalogs.
An unreachable owned basic mex delays the goal; the clock never bypasses it.
Queued unstarted reactors are cancelled when new mex work appears; existing
reactor construction continues. Transports and the defensive fighter quota
remain ahead of optional aircraft. Fusion preparation does not by itself pause
T1 combat production. Energy recovery and immediate defense can still defer it.

The turret target takes the larger of funded aircraft throughput and an
income/float construction floor shared across live production bays. Support
growth precedes general fusion-preparation assistance, and unfinished turrets
receive help before another is ordered. Idle factory turrets help owned
construction within their physical reach through the same target selector as
mobile builders. Once the owning plant has another unit frame, the AIR tick
ends that economy assistance so factory production regains the turret.
See [design and evidence](air-wind-and-build-power.md).

The twenty-nano setting is the current expansion comparison point. The first
implementation fills useful available support up to that point before another
plant; it does not claim a calibrated global capital-cost optimizer. A
configured warm handoff estimate is separate from cold startup; playtest
observations distinguish idle gaps from the previous unit's build time. No
runtime adaptation is inferred from contaminated resource-stalled samples.

## Transport and attacks

Any allied role can call `Team::Ferry::RequestTransport`. TECH retains its
automatic income-triggered request. AIR validates ally membership, ignores
self/duplicate outstanding requests, queues distinct teams FIFO, and orders a
transport before spam or combat at its next eligible T1 plant decision. An
existing frame or recruit remains the same obligation even after the retry
timeout. The latch is set only after enqueue succeeds. AIR flies the unit to
the requesting base, transfers it, then serves the next request. A destroyed
transport is retried while still owed. The finite queue preserves the existing
TECH cargo protocol and permits future requestor roles.

Scouts, initial fighters and economic constructors have finite quotas. T1 strike
aircraft replenish toward income-scaled limits: one strike order per two extra
fighter orders after the defensive screen, alternating support and bombers.
Cortex support uses Shurikens (up to sixteen); bombers cap at twelve. Other
factions retain their three-gunship support limit. A T2 purchase below +50 does
not idle the T1 plant. Constructor growth retains its funded priority.
T2 fighters assigned to home interception cannot enter
the held/launched wave ledgers (INV-072). Finished units, frames and pending
recruits are counted without a second "queued" count at birth. Existing wave
methods, native bombing, AA-led porc, heavy aircraft and dynamic-production
fallback remain available. Leaving AIR releases its military holds and building
tasks before the next role adopts standing structures.

`WaveAvoidHomeFocus` replaces an absent or home-area front focus with the nearest
participating enemy start before planning the sortie. This prevents an AIR duel
from carpeting its own runway merely because enemy fighters were intercepted
there. Explicit STRIKE/DEEP target selection can still choose a known target;
the six existing wave methods and native bombing tasks remain in use.

## Shared mechanisms and TECH boundary

`ProductionMath` contains pure rates, mixed-batch timing, funding, support
targets, bounds and capacity gating. Its tests execute the actual AngelScript
using the vendored runtime. New native observations expose owned IDs, pending
unframed recruits, physical work/time/reach and persistent reservation states.
The flying-builder approach lever defaults false; AIR alone enables it and
resets it on leave. TECH's spending gates and build sequence remain intact;
D-153 adds speculative factory sites, activation checks and shared native
placement exclusion without routing TECH through AIR's economy controller.

Shared manager changes are guarded by AIR role and/or its feature flag. Native
completion-chain economy orders are reconciled after enqueue so they cannot
compete with AIR's planner. Native automatic nano planning is disabled only for
the AIR instance. TECH's existing leave/restore sequence remains in place.

## Verification and limits

See [simulation evidence](benchmarks/air-management.md) for pinned DLLs, settings,
milestones, failures and the difference between natural games and supplied
late-economy fixtures. Runtime observations are logged as `[AIR][Rule]`,
`[Economy]`, `[Bay]`, `[Claim]`, `[Produce]`, `[Attack]`, `[Waves]` and `[Ferry]`.
The read-only `air_watch.lua` records completions, losses, resources, factory
gaps and aircraft damage independently of the AI's intent logs.

Full script save/load remains subject to KI-209: native named layout metadata
can be adopted, but this is not complete persistence of wave/transport histories.
No claim is made that a headless synthetic test establishes competitive PvP win
rate, every map's geometry, or every faction/product's saturation point.

Sources: [AIR](roles/air.md), [ordered rules](roles/air_rules.md),
[actions](roles/air_build.md), [original plan](air-layout-and-priority-plan.md),
[ferry protocol](transport-ferry.md), [invariants](invariants.md).
