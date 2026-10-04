# AIR committed operations and command efficiency (D-171)

2026-10-02. Plan written before implementation. Supersedes AIR's offensive
return-home doctrine, fixed two-AFUS bomber admission, surplus-fighter staging
and permanent opening T1 lab. TECH's lab sequence remains unchanged.

## Requirements and researched boundaries

The owner explicitly requires offensive bombers to remain committed until all
members die, with every available fighter accompanying the attack. On a new
friendly-territory incursion, existing escorts remain committed; only newly
available aircraft defend. Defensive bomber missions may return and repair.
This deliberately accepts attrition and temporary home-air exposure. Judge
target damage and destroyed value, not survival as an automatic failure.

The official [early-air guide](https://www.beyondallreason.info/guide/early-air-raids)
supports reconnaissance, valuable clustered economy, payload-sized control
groups and planning around one useful pass. Its advice does not establish that
every suicidal attack is cost effective. The owner's no-return instruction is
the selected doctrine. The [air guide](https://www.beyondallreason.info/guide/basics-of-air-warfare)
supports fighter protection; screening in front cannot force enemy AA to ignore
bombers. The [command guide](https://www.beyondallreason.info/commands-20)
documents player control groups and formation movement. In the pinned engine,
`CAICallback::GiveGroupOrder` returns zero without doing anything; ordinary
SkirmishAI orders use `SendAICommand` per unit. Thus a logical group is not one
network packet. No engine/game modification or Lua order bridge is proposed.

Loaded rosters: Armada `armawac`, Cortex `corawac`, Legion `legwhisper` are radar
aircraft available from their T2 air factories. Legion's T1 `legfig` doubles as
the opening scout; T2 `legvenator` is an interceptor. Preserve loaded definitions
and verify every build edge. See the shared 38-air-roster and base unit catalog.

## Review findings

1. Every screen refresh dirties every fighter route, including unchanged routes.
   The script writes a patrol and then an intercept, producing needless queue
   replacement even with a naive equality guard. Per-unit transient route tasks
   also outlive lost aircraft.
2. T2 fighters beyond the home quota enter `heldFighters` and stage around the
   factory. This is shared across factions and explains the late Legion clump.
3. Experimental waves return after one pass, casualties or timeout. Survival
   feedback treats intended attrition as failure and would eventually suppress
   the requested committed doctrine.
4. Normal T2 lab admission already uses sustained metal or a full lab bank;
   the two-AFUS gate is bomber admission. Both need resource-based affordability,
   and the bomber gate must no longer depend on named reactors.
5. Opening factory placement assumes a reserved compound, making the commander
   walk to a remotely chosen site. AIR has no dedicated startup-lab retirement
   and reconstruction lifecycle.

## Implementation design

### Cohorts and mission ownership

Use distinct logical groups: home-screen cells, responding interceptors,
offensive bomber package, its forward fighter screen, defensive heavy-unit
response, radar collection wall and committed radar sweep. Stable membership
and routes avoid touching unaffected aircraft. All uncommitted fighters remain
on the home wall. At bomber dispatch, transfer all available fighters into that
package; membership is exclusive and survives casualties. Release escorts back
to home control only after the offensive package has no bombers. Newly produced
fighters are independent home defenders until another launch.

Reuse native route and wave tasks with opt-in APIs; legacy routes and TECH
amphibious/spam tasks retain their semantics. Equality suppression compares the
final desired route, not intermediate patrol/intercept writes. New members get
their existing group's route without reordering old members. Clear genuinely
empty transient AIR tasks. Engine patrol/fight/attack queues execute between
decisions; do not refresh them on a timer merely to restate the same intent.

### Committed bomber missions

Script supplies mission kind, eligible target definitions, target priorities,
friendly defense radius, assembly point, escort lead and route-risk settings.
Native code supplies grouped geometry, observation, command execution and target
selection. Offensive T2 candidates are AFUS, advanced converters and factories;
mobile T1 targets are never eligible. Clear the immediate economic cluster,
then progress to another known enemy base. No arbitrary low-value mop-up.
If no economic corridor is admissible due to AA, accumulate the larger funded
package needed for a frontline static assault. Unknown ground is not assumed
safe; keep conservative route padding. With no known target after deployment,
continue reconnaissance toward enemy territory, retaining mission ownership.

Form in friendly territory once, queue direct/edge travel as a package, and keep
fighters ahead through segment-level formation commands. Retarget on target
destruction or loss of valid contact; persistent attack commands handle repeat
passes. No offensive loss/timeout/repair return. Defensive missions admit only
observed heavy ground threats in friendly territory and may return after the
threat is cleared. Do not reuse offensive no-return state for defense.

T1 raids use the same commitment/escort contract with a small funded cohort and
mex/wind priority. Maintain early harassment after the opening crew/screen;
Legion Mosquito remains a gunship, not a falsely reclassified bomber.

### Production, access and base lifecycle

Replace the normal bomber AFUS latch with a current sustained M/E workload
admission using loaded aircraft costs, existing demand and banked runway. Keep
recovery, constructors and transport priority. A reactor type/count is not an
aircraft-production requirement. First T2 access uses sustained metal plus
energy funding (or a funded bank), with explicit metal-mode opening preserved.
Keep twenty completed turrets per current T2 lab before adding another.

When two completed T2 factories exist, persist one live factory identity as the
fighter/recon producer and replace it after loss. Every ten game minutes, that
factory funds a twenty-radar-plane cohort; while collecting they patrol across
friendly territory for sensor coverage. Launch all twenty on a synchronized,
spread sweep through enemy territory without retreat. Do not count already
committed reconnaissance as the next cohort or duplicate production frames.

When the commander is the only constructor and AIR has no lab, offer an
emergency nearby T1 factory site without AIR's speculative layout constraints.
Retain physical buildability, map bounds and allied occupied/reserved safety.
Adopt the actual factory rather than dragging the commander to a remote plan.
Before first T2, reclaim this startup lab when useful and when transport/worker
recovery obligations are safe. `Lifecycle` is authoritative: no production,
repair or guard while retiring. Later rebuild one T1 lab in its planned compound
after T2 access; keep ferry availability and constructor recovery. Never invoke
TECH's executor or alter its lab rules.

Natural validation exposed a terrain constraint: a fixed six-lab rectangle can
fail throughout a cliff-backed home even when income is sufficient. After
`CompactCampusAfterSeconds`, rotate and narrow the search and allow one- or
three-lab compounds with complete support pins, continuing until at least six
T2 sites are planned across compounds. Respect the failed-search cooldown on
builder callbacks. This extends the existing constrained-metal-map mechanism
to ordinary terrain without changing TECH placement.

## Verification plan

Natural Tundra also exposes a circular storage gate: +21 metal asks for only
1,260 storage, below the existing 1,350, while a bank-funded T2 lab costs more.
Before first T2 access, a nearly full metal store must be allowed to grow to
at least the loaded advanced lab cost. Put that action after mex upgrades and
recovery, before optional spending. Keep the existing +50/energy or fully banked
lab admission, normal production and metal-map branch unchanged. Verify with
pure boundary tests and a fresh natural Tundra run, not supplied resources.

The final natural Tundra stress minute has 200 fighters and 2,652 ATTACK
commands. Preserve each wall cell's live, armed, friendly-territory contact
by stable enemy ID before assigning unoccupied cells to the nearest remaining
threat. Subtract retained cells from the same response budget to avoid extra
overcommitment. Release targets immediately when absent, unarmed or outside
friendly territory; do not impose a timing cap. Test snapshot reordering and
budget exhaustion, then repeat the Tundra stress case and combat matrix.

The natural-game idle-commander reproduction shows a command/task mismatch:
`commander.idle.energy` is selected while the engine still executes the old
factory guard during path preparation. Track AIR-issued commander guard intent
and clear its engine command once when a different AIR builder action is
recorded. Also stop the old guard when releasing a T2 economy aircraft. Do not
abort shared guards or alter TECH/native guard semantics. Repeat the natural
Legion case with the independent idle-factory observer enabled.

The Supreme repeat also cancelled a reactor task at frame 52980 after a mex
upgrade became pending, but its old engine build command framed the reactor at
53079. AIR cancellation must clear commands for the task's actual assignees
before aborting an unstarted project. Reuse this helper for invalidated reactor,
lab-support and unclaimed native building orders; never stop a reassigned or
player-controlled unit. Repeat the normal Supreme game with INV-077 enabled.

Add pure tests for funding, doctrine, target eligibility, route equality,
cohort ownership, radar cadence and lifecycle boundaries. Add production
invariants and actor records. Compile/load actual AngelScript, native build,
API parity and required suites before simulations.

Measure commands from actual engine events, including rolling sixty-game-second
APM, and report aircraft population and task counts. Compare unchanged screen,
birth/death, interception and attack workloads against baseline. No rate limiter
or emergency decision delay; do not claim a universal sub-3000 guarantee from
source complexity. Keep logical group changes separate from network order count.

Run rendered supplied-economy/combat cases and accelerated full natural games
on at least five non-metal maps: Supreme Isthmus, Glacial Gap, All That Glitters,
Tundra Continents and Serene Caldera (installed versions verified at launch).
Use explicit runtime role fixtures where map defaults do not include AIR.
Exercise all factions, especially Legion. Audit actual attacks, sequential
economic kills, zero offensive returns, fighter lead/commitment, defensive
returns, radar sweeps, nearby opening lab and reclaim/rebuild. Natural games
verify economy with no gifts. Keep TECH invariants enabled; report any failures.
Provide inspected screenshots and behavior updates during runs. Publish matched
DLL/symbol/data to the engine build output, never the live installation. Record
remaining defects, final evidence and commit/push authorized changes.
