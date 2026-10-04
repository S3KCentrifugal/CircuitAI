# Allied layout reservations and AIR income progression

Design recorded before implementation, 2026-09-30 (D-153).

## Requirements and current failures

AIR and TECH reserve terrain in separate native blocking maps. KI-405 records
that another allied instance cannot see those reservations. AIR bays reserve
individual footprints but leave gaps available to unrelated defenses. TECH's
future factory clusters have one speculative plan per factory type, and neither
controller validates every member immediately before activating a new cluster.
An existing TECH forward-box check can abandon a cluster after work has begun.

AIR currently requires every owned mex to be upgraded before ordering a T2
plant. That D-152 lab gate is superseded by the owner's income/bank requirement.
The fusion mex gate remains. `PreparingFusion()` also stops strike production
from eight minutes onward, and the T1 fallback only orders fighters once the
small strike opener is exhausted. Cortex's opener already names `corbw`, but
does not replenish a sustained frontline support force.

## Native mechanism

Use the existing shared `CAllyTeam` object for a spatial index of reserved cell
rectangles, keyed by owner team, reservation kind and local ID. It is the same
in-process ally boundary already used for friendly units and reclaim marks.
Only same-library allied AIs participate; human and other-AI builds remain
physical obstructions handled at activation. No enemy plans are read.

Publish each native zone and slot synchronously, including held/unarmed slots
and consumed slots whose pending construction has not yet become a structure.
Remove entries on release, plain-slot completion, reset and owner destruction;
reconstruct them from authoritative native state after load. Spatial buckets
bound query cost as the number of speculative clusters grows. Overlapping
reservations belonging to one owner are valid and release independently.

All reservation admission, zone admission, packing and normal placement searches
must reject footprint overlap with another owner's rectangles. Wrap the normal
search predicate so masked, coarse, ignore-blocker and experimental searches all
honor the same rule. Recheck exact reserved sites and command retries. This
also makes ordinary native defenses respect an ally's future economic space.

Provide script queries for a reservation's current buildability and a group's
activation state (untouched/buildable, untouched/blocked, already started).
Queries check complete footprints against engine buildability, not only a
cluster's centre or coarse ally-base radius. Group inspection never consumes
slots. Keep all relocation decisions in AngelScript.

## Layout policy

Keep the existing private persistent slots. Reserve the gaps in AIR factory
bays and six-wind clusters with enclosing zones after all member slots succeed.
TECH factory footprints, rear banks and exits likewise retain a protected
envelope. Ordinary placements, including walls and guns, cannot occupy these
zones; authorized economy packing continues through the existing zone API.
Zone admission is atomic with respect to allied reservations: do not create a
partial cluster over another role's ground. Roll back every provisional member
if the compound plan fails.

AIR continues to plan six T2 and two T1 bays, configurable independently of
spending limits. TECH gains a configurable reserve count per T1/T2/gantry type,
default two future clusters each, replenished incrementally. These reservations
do not start cooldowns, spend resources or change TECH's construction order.

Immediately before the first cluster member is ordered, validate the factory
and every support slot. If an untouched cluster is blocked, release only that
cluster's speculative slots/zones, clear its saved identity, and search again.
Persist stable keys and the activation state. Claimed, framed or completed
members lock the cluster in place; never move it out from under a live task.
Wind clusters follow the same rule. TECH forward economy boxes also validate
before first use and keep active boxes when a nearby ally changes the coarse
ally-base marker. Retry failed searches with bounded cadence and advance search
locations rather than indefinitely retrying one obstructed site.

Implementation refinement: TECH economy boxes deliberately fit partially usable
terrain. Pre-existing terrain holes do not invalidate the entire rectangle;
new physical structures on reserved cells trigger first-use relocation. The
tightly packed six-wind footprints cover their rectangle completely, so their
private slot zones need no extra envelope.

## AIR economy and production

The T2 plant eligibility rule is: a complete ten-second income window whose
minimum is at least **50 metal/s**, OR current metal bank at least the plant's
full metal cost. Use the shared income minimum and an explicit full-window
readiness check. A banked lab bypasses old earliest-time, mex, fusion-access,
partial-funding and existing-nano gates. Keep availability, build capability,
one unfinished lab at a time, and configured maximum capacity constraints.
After a plant order is accepted, an income fluctuation does not cancel it.
Additional income-funded plants still require sustained spare production
capacity; a fully banked next plant bypasses that wait as requested.

Transports requested by any allied requestor remain ahead of ordinary
recruitment through the existing ferry hook. Preserve scout, three completed
air constructors, then immediate home fighter floor. Constructor growth and
emergency interceptors remain ahead of optional strikes. Remove the indefinite
fusion-preparation strike pause. Sustain a bounded T1 bomber component and,
for a Cortex-capable T1 plant, an income-scaled Shuriken support component;
replenish losses and continue a fighter majority. Keep useful T1 production
after a T2 plant exists when the economy cannot yet sustain T2-only production.
Retain actual energy-stall recovery and resource-pressure throttles.

The shared unit catalog identifies `corbw` as a T1 Cortex paralyzer drone built
by `corap`; use its existing native combat task routing. Do not invent a
Shuriken for other factions or change TECH production settings.

## Verification and completion

Add executable native tests for cross-owner overlap, touching boundaries,
replacement/release, nested own claims, owner removal and spatial query behavior.
Extend executable AngelScript policy tests for the 50-metal boundary, full-bank
override, invalid inputs, incomplete window and T1 mix targets. Build the native
DLL, compile all experimental scripts against it, and run existing geometry and
policy tests.

Run serial isolated engine simulations: mixed AIR/TECH natural progression;
controlled low-income T1 combat and bank/income threshold cases; close allied
plans and a physical obstruction inserted into an unused cluster. Observe
reservation ownership, relocation, active cluster stability, defensive placement,
transport priority and T1 unit completions. Keep baseline TECH invariant failures
visible and report limits of coverage. Add runtime invariants for the new
promises, update the actor matrix, role/API references and decision register,
and record any diagnosed unfinished issues. Publish matching DLL/debug/data to
the documented build output, commit locally, and do not push.
