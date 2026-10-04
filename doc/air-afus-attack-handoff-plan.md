# Visible AFUS attack handoff

Implementation and rendered verification: [results](air-afus-attack-handoff-results.md).

The reported fly-by has a concrete cause in experimental AIR's operation path:
`UpdateOperation` sends HOLD-fire bombers through a MOVE leg ending at the
target, waits for the arrival quorum, and only then issues ATTACK. It also
does not reconsider a nearby newly visible AFUS during travel or an attack
on a lower-priority building. The legacy attack synchronization path is not
used by these operations.

## Implementation

1. Add a script-controlled immediate-strike policy to `CAirWaveTask`. AIR
   enables it for offensive operations, with priority 4 (the existing AFUS
   priority) and a 1,800-elmo local radius. Zero disables it. Unit identities
   and strategic priorities stay in AngelScript; other roles retain their
   existing task behavior.
2. Replace the final target-centre MOVE leg with persistent ATTACK orders.
   Retain assembly, intermediate formation legs and edge ingress. The final
   straight approach must not wait for aircraft to fly over their victim.
3. On each scheduled operation update after commitment, scan known enemies
   once for a currently LOS-visible, live, identified, stationary target
   meeting the configured priority within the bomber cohort's local radius.
   This uses actual team LOS, not omniscient positions or radar-only contacts.
   Select nearest among equal priorities. Keep an already attacked qualifying
   target until it dies or loses visibility to avoid AFUS-to-AFUS order churn.
   Skip excluded regions. Do not run route/AA planning per candidate.
4. A qualifying target immediately replaces travel/search or a lower-priority
   target. One transition issues one persistent ATTACK per bomber and one
   forward-screen FIGHT per escort. It clears stale route-arrival state.
   No periodic command refresh and no new rate limit. Subsequent idle recovery
   retains the existing empty-command-queue check. Fighters remain committed;
   offensive waves never return. Defensive T3 missions retain their target
   policy and return behavior but receive the same earlier final approach.
5. Keep the reactive scan O(enemies + aircraft), with no enemy-by-aircraft
   pair loop. The radius is measured from the bomber cohort centre; it is a
   local engagement policy, not a claim that every individual plane sees the
   AFUS. Normal scheduled task updates determine reaction latency.

## Verification

Add engine-independent tests for final-leg handoff and priority interruption
eligibility, including disabled, assembling, defensive, hidden/radar-only,
distant, mobile, and existing equal-priority target cases. Add a production
invariant rejecting stale formation MOVE after attack handoff and an
independent arena observer measuring local LOS, actual ATTACK commands, first
damage and target destruction. A command is not proof of weapon release;
turning, reload and the engine's bombing geometry remain applicable.

Run the old DLL first against an isolated supplied-force AFUS fixture, then
repeat with the fix and actual screenshots. Exercise Armada, Cortex and
Legion bombers, a newly revealed AFUS during a lower-priority raid, continued
cleanup and defensive T3 return. Load all three experimental profiles. Pin
data from the last verified snapshot so concurrent unrelated map edits are
not included. Record timings, screenshots, limitations and hashes; run native
tests, API/invariant/document checks, publish matching DLL/debug/data, and
commit/push only this change.

Acceptance: the selected target receives ATTACK before the target-centre
formation leg; a local visible AFUS interrupts a committed lower-priority run
at the next operation update; the arena observes ATTACK within one second
of the qualifying local contact, with no recurring command bursts or escort
release. Do not promise instantaneous bomb release or ignore route safety
for a distant AFUS seen by an allied scout.
