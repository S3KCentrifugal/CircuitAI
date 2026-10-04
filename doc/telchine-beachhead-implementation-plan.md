# D-160: Telchine recruitment and persistent beachheads

Status: implementation plan, 2026-10-01. Written before production edits.

## Problem and scope

The natural D-159 Tundra 8v8 match produced its first Telchine at 32:58,
then landed and secured two islands but inflicted no damage before victory.
Its +200 metal gate inherited the general TECH combat policy. SECURE was a
short regrouping state, not a persistent garrison. The controlled retreat
probe proved six Telchines could fire from land without pursuing a ship into
water, but did not prove natural recruitment or valuable beachhead ownership.

Change experimental TECH/AIR amphibious policy only. Preserve Marauder gates,
ordinary TECH rush/build order, AIR transport/constructor priority, other
roles and legacy profiles. Native additions expose observations and safe task
transfer; recruitment, allocation and objective selection remain script/JSON.

## Recruitment

Separate the Telchine threshold from the caller's general combat gate. Start
with a configurable +80 metal minimum sustained over ten seconds. Require
one unit's metal plus a 300 metal reserve, an energy buffer, and positive
energy income. Limit average recruitment to 15% of metal income and 20% of
energy income through a per-role cooldown derived from both unit costs.
Constructor obligations still run before this optional production branch.
Keep a bounded standing force and account for pending recruits. Do not
unlock unrelated combat units or change factory construction policy.

Pure tests cover the sustained-income window, insufficient bank/energy,
cadence, zero income/cost and population bounds. Measure actual recruitment
and spending during games; these initial values are hypotheses, not tuned
meta constants. Marauders retain the existing general/T3 gate.

## Beachhead ownership

Represent retained Telchine guards separately from assault waves. After a
wave secures a dry component, reserve up to three defenders only if at least
three assault members remain. Bound guard groups (initially two per AI) and
standing population. Guard useful shores near completed allied mexes,
geothermal plants or factories; observed naval approaches increase value.
Never treat an empty defeated start or the presence of unclaimed metal spots
as protected economic assets.

Use actual ally-visible snapshots, stable IDs and current observed naval
positions. Cache allied economic observations and refresh periodically.
Search a bounded set of dry shoreline candidates on the same land component,
rank coverage and travel, and retain the assignment while its economic assets
remain. Share expiring claims through the existing ally message mechanism so
TECH and AIR do not both allocate a garrison to the same beachhead. Resolve
simultaneous claims deterministically. Release stale claims on loss, role
change or asset disappearance. Keep lane/objective geometry advisory; only
the wave's route task owns movement.

Expose a checked military task-transfer mechanism to split a wave safely.
Transfer only living units between tasks owned by the same military manager;
never borrow a builder task or retain borrowed unit pointers across ticks.
A guard uses hold-position and ground-only routes. It may reposition along
its dry component to cover an observed ship but never takes a ship position
as its destination, never uses an amphibious fallback, and never leaves to
pursue navy. Assault waves retain explicit threat-tested sea crossings,
intermediate island regrouping and local land clearance. Marauders remain
backline raiders.

## Verification and iteration

Add pure policy tests, documented runtime invariants and actor ownership.
Build the DLL, publish matching DLL/debug symbols/data together to the engine
build output, check script/API parity, and compile all experimental profiles.

First run a controlled Tundra fixture with valuable allied shore assets,
enough Telchines to split, an advancing assault and a retreating enemy ship.
Require persistent guards, remaining assault progress, real shore fire, an
alive retreat target, zero wet pursuit and no runtime invariant or script
errors. Retain failed runs and fix observed causes before repeating.

Then run complete natural 8v8 Tundra matches with mirrored roles/factions and
multiple seeds. No gifts or resource boosts in natural matches. Cut metrics
at GameOver. Track first production/landing/contact, damage and losses,
protected assets, guard persistence, underwater commands and economy. Show
actual screenshots and behavior analysis while matches run. Preserve the
D-159 natural result as baseline. Review broader TECH invariant failures by
root cause; do not hide them with relaxed check patterns or claim an overall
pass while unresolved failures remain.

Record verification boundaries, decisions and unresolved diagnoses. Commit
completed work locally; do not push under the user's latest Git preference.

## Additional diagnosed regression: constructor donation ownership

D-159 INV-041 reports identify T2 naval construction subs in the donation
queue. OnConstructorBuilt accepts any T2 constructor, although donation
orders are made only at the T2 bot lab. The naval constructor then runs the
higher-priority harbour rule (SEA_CON is outside the MOBILE ferry mask), so
the queued gift continues economy work and cannot be delivered to land.
Restrict request fulfillment to the same bot roster the request producer
orders. Put ferry ownership before discretionary harbour land construction
for valid gifts. This preserves naval economy constructors and the intended
TECH constructor request contract. Reuse INV-041 and verify in natural runs.

## Owner resolution: preserve lab reclaim and recovery

The first D-160 natural run confirmed a separate delay: TECH may reclaim its
T2 lab for the first advanced fusion and restore it only after +200 metal.
On 2026-10-01 the owner chose: "Keep TECH's lab reclaim/rebuild rules exact,
accepting later Telchines." Do not add the proposed +80 water-map lab
recovery exception. The +80 unit recruitment budget applies only while a
suitable existing lab can produce. Report this limit in match comparisons.

## Follow-up validation findings

D-160 native factory fallbacks must exclude the two script-managed amphibious
units while choosing ordinary units; otherwise a donated AIR bot lab can
bypass the cadence after its cap opens. Use one scoped wrapper in both roles,
restoring limits immediately after the synchronous native choice.

INV-018 must compare a completed lab with its saved construction facing.
Rejecting a previously correct lab when the observed front reverses is an
invalid assertion: buildings cannot rotate. Keep the exit-blockage check.

Repeat the beachhead encounter with allied TECH and AIR waves competing for
the same economic island to verify the shared claim protocol in game.

The combined allied fixture exposed dry landing congestion: after reaching
quorum, waves could be pushed beyond the original 240-elmo radius and wait
forever in SECURE. Keep the initial landing quorum tight, but allow 1.5x
radius for subsequent dry security checks on the same land component. This
does not admit wet stragglers or skip the eighteen-second security dwell.
The repeated fixture must show all twenty-one non-guards advancing.
