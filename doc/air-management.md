# AIR building management

The experimental AIR role has its own economy, layout and ordered building
controller. TECH continues through `TechRules`, `TechBuild`, `TechChain` and
`Layout`. Both now share native allied reservations (D-153); their spending
sequences and cluster geometries remain separate.

## Local economic growth and air defense (D-156)

The [design and measured results](air-local-economy-plan.md) define the current
AIR-only policy. New mex expansion stays within 1,400 elmos of its start;
ordinary economy sites stay within 2,400 and on the friendly side of known
starts. Previously owned remote mexes still get one upgrade worker at a time.
Constructor targets use 24 build power per stable metal income, bank drawdown,
and caps of 40 T1/24 T2 constructors. These are ceilings, not an opening queue.
Recruitment interleaves a fighter after two consecutive economic constructors.
The thirty-second resource forecast does not subtract the entire remaining
price of an unrelated reactor. Energy recovery can still recruit funded help.

Up to six funded energy frames can progress concurrently. Additional helpers
join a frame only while its assigned power cannot finish the remainder in the
configured twelve seconds (small structures) or 120 seconds (reactors). Factory
turrets remain production capacity and cannot replace the mobile economy crew.

`Air_AiMakeDefence` disables shared porcupine planning while experimental AIR
is active. The legacy disabled-feature behavior retains its old gates.
`AirDefence` places at most four flak, one long-range AA and one anti-nuke in the
own-base defense radius (1,500). AA also needs observed enemy air investment.
Anti-nuke admission starts at fifteen minutes, +40 metal/+1,200 energy and a
fundable cost forecast. Placement uses loaded interceptor coverage, retains
the 800-elmo own core and favors the closest participating allied start.
Native stockpile handling supplies missiles after completion. All structures
still use native reservations and cannot occupy another role's planned area.

`AirScreen` groups currently observed enemy aircraft in friendly territory and
assigns nearby home fighters every two seconds. Its threat budget uses 1.5
times observed metal cost; it restores the screen after contact disappears.
This is a start-based territorial approximation, not a claim to model shifting
ground control. Enemy-AA heat and stale unseen aircraft do not create live raids.
Bombers keep existing targeting/wave behavior. Optional strikes require no live
incursion and available completed fighters worth at least 1.25 times known
enemy air investment; waiting escorts count, already launched waves do not.
This replaces the fixed 1,000-metal enemy-air veto, which could suppress
Shurikens despite a much larger friendly fighter force. Gunships require known
land presence, and T1 support remains available after T2. Defense count limits
are shared across faction variants so a gifted foreign constructor cannot add
a second anti-nuke or long-range AA. Transport requests remain
ahead of all ordinary recruitment.

## Layout and economy

The T1 starter has a rear bank of up to five ordinary construction turrets.
T2 production bays have two side banks, with up to twenty planned turrets and
separate build pads. The campus adds one bay at a time at a nominal 560-elmo
spacing; the configurable safety ceiling is twelve T2 plants, not a target.
The candidate search covers 25 rings in 128-elmo steps, allowing replacement
sites beyond the original crowded 2,048-elmo radius.
New T2 plans require all twenty support slots. Standing
gifted plants are adopted in place and nearby support slots are fitted around
them; a partial gifted bank cannot authorize further labs until it has twenty
completed support turrets in reach. Windmills use atomically reserved 3-by-2 groups of six touching footprints,
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
Further bays require twenty completed, uniquely assigned support turrets on
**every** existing T2 lab (D-155). Frames and queued turrets do not qualify.
Sustained spare income for twenty seconds is also required unless the entire
next lab is banked. Banked metal bypasses that capacity wait but never the
support gate; the configured plant cap and one unfinished lab limit still apply. The role
keeps growing T1 energy/storage while those conditions are unmet. Three bad
energy samples enter recovery; ten adequately buffered samples leave it.
Mobile construction targets scale at eight work/second per metal/second,
multiplied by 1.5 when metal floats. Floating bank above half storage adds a
sixty-second drawdown term to the income input. Loaded constructor work rates determine
counts, with ceilings of ten T1 and eight T2 constructors. After T2, the work
target splits 40%/60%, with three T1 and two T2 as the funded floors. Queued
recruits and frames count once. Growth requires a bank and cost forecast and
pauses in recovery; during overflow the forecast does not charge every large
project's full remaining cost against one constructor's short funding window.
It follows the immediate fighter screen and precedes the
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
income/float construction floor shared across live production bays. Factory
production power is not deducted from the construction floor. Affordable T2
expansion raises existing T2 targets to twenty. During overflow, up to three
funded turrets can be started before assistance; otherwise unfinished turrets
receive help before another is ordered. This follows mex work and precedes
converters and optional capital work. Idle factory turrets help owned
construction within their physical reach through the same target selector as
mobile builders. Once the owning plant has another unit frame, the AIR tick
ends that economy assistance so factory production regains the turret.
See [design and evidence](air-wind-and-build-power.md).

The twenty-nano setting is a completed-support expansion requirement. It does
not claim a calibrated global capital-cost optimizer. See
[support admission and verification](air-support-before-expansion.md). A
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
