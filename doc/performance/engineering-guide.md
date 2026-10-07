# CircuitAI performance engineering

Applies to native C++, the embedded AngelScript VM and BAR/Recoil callbacks.
Read the [measured D-199 changes](../reviews/2026-10-04-high-severity-performance-implementation.md)
before replacing an optimization. These are maintenance contracts, not a claim
that every optimization improves whole-game FPS.

## Establish cost and preserve semantics

Record callback frequency, collection sizes and the owner of mutable state.
Distinguish simulation frames from rendered frames: engine events and scheduled
jobs invoke the AI, not a render loop. Count engine calls, allocations and
commands as well as elapsed CPU time. Report inclusive and exclusive timings
separately; nested phase times cannot be added together.

For a behavior-preserving change, compare decisions, ordering, random draws,
task ownership, command parameters/options/timeouts and error propagation on
identical inputs. Keep an old implementation as a test oracle when practical.
Run mutation, role transition, destruction and reload cases. Do not describe a
new tactic, cadence, threat tolerance or order suppression as an optimization.

## Contracts retained by the recent optimizations

| Path | Performance contract | Maintenance hazard and verification |
| --- | --- | --- |
| [LocalReservations](../../src/circuit/terrain/LocalReservations.h) | Direct paged cells make a query O(A), where A is the candidate footprint in half-cells, independent of reservation count N. Mutation costs O(log N + A); memory follows occupied pages plus ID maps. | Counts preserve overlapping owners; XOR alone cannot. Consume/release/move/load must update the index. Full zone envelopes remain reserved. Fixed-footprint queries are constant in N; full placement search is not O(1). See [oracle tests](../../tests/local_reservations_test.cpp). |
| [Layout](../../data/script/src/manager/layout.as) | Removed an expensive probe whose failure was already converted to success. Real placement still performs its authoritative checks. | Do not reintroduce speculative packing at every eligibility check. Compare predicates with [policy checker](../../tools/knowledge/check_performance_policy.py). |
| [EcoPlanner](../../data/script/src/manager/eco_planner.as) | One owned array with stable insertion and handle consumers avoids repeated container copies. | PickEnergy filters its array, so its handle must be mutable and privately owned. Shared scratch storage could alias recursive/reentrant callbacks. Preserve tie order. |
| [TechRules](../../data/script/src/roles/tech_rules.as) | Reuse the constructor census already obtained in the same decision context. | Only reuse across read-only operations. Enqueueing, transfers and completion can invalidate counts. Cross-frame reuse is a different contract. |
| [TechWeapons](../../data/script/src/roles/tech_weapons.as) | Outstanding-order count is lazy and valid within one Work call until a mutation. | Invalidate before every Order and after cleanup changes. Buildable can raise a UnitDef cap; it is not a pure predicate. Two calls in one frame can intentionally observe different state. See [oracle](../../tools/knowledge/check_weapon_work.py). |
| [CustomCommand](../../src/circuit/spring/CustomCommand.cpp) | Borrow parameters only during the synchronous generated C bridge call. | A queued/asynchronous bridge would require owned storage. Preserve exception codes. This removes allocation, not commands, packets or network APM. See [bridge test](../../tests/custom_command_test.cpp). |

## Engine and VM boundaries

Engine wrappers and borrowed CCircuitUnit pointers are not worker-thread APIs.
Store IDs across callbacks and reacquire live units. A worker may calculate over
an immutable owned snapshot; the owning AI callback must validate its version
and commit results. Read Scheduler, AiRun and the specific callback contract
before proposing parallelism. thread_local profiling state is isolation of
instrumentation, not permission to parallelize game managers.

Array object assignment copies storage; handle binding aliases storage. An
AngelScript object `&out` uses a temporary and copy-back, so it is not a reusable
output buffer. Global buffers need an explicit non-reentrancy/lifetime proof.
Scalar dictionary outputs can also pass through conversion temporaries: on a
failed `get`, assign a fallback after the call. An earlier initializer is not
a guarantee. D-201's [actual-VM test](../../tests/collection_helpers_tests.as)
guards against phantom counter coverage from missing keys.
Keep scalar decision functions pure, but do not impose allocating pipelines on
hot loops. Profile native calls inside apparently cheap script helpers.

## Commands and multiplayer

One fleet task or visual formation can still submit one engine command per
unit. Distinguish AI orders from Lua gadget orders and network traffic. Avoid
reissuing an identical *still active* intent only after checking queue state,
command expiry, changed targets and task ownership. Broad throttles delay
responses; blind equality suppression can suppress necessary recovery orders.
Earlier SEA suppression experiments lost combat fixtures and were removed.

## Evidence and comments required for future changes

At a hot path, comment why the representation is used, its complexity variables,
ownership, invalidation events and correctness oracle. Document measured gains
in reports, not as timeless speedup claims in source. Include memory/mutation
tradeoffs and deliberately rejected alternatives.

Use serial old/new runs with the same build flags, game content, map, seed,
population and observation window. Preserve failing results. Microbenchmarks
establish component cost; unequal surviving armies do not establish FPS gain.
Do not infer internet-peer savings from a local game. Runtime counters should
be opt-in, bounded and cheap when disabled. Run the actual interpreter and
engine with matched DLL/data, not just regex/API checks.

## Ranged combat snapshots (D-207)

`CRangedWorld` owns one lazy snapshot per AI simulation frame. Do not call
`UpdateFriendlyUnits` from its reader: that path reconstructs engine wrappers,
ally objects and map nodes for the whole ally army. The direct `CUnitAPI`
reader retains its ID buffer, uses the same legal callback and authority
definitions, and sorts IDs to preserve ordered-map traversal. This is
O(F + I/64) for normal large inventories after D-221, where I is the engine ID
bound; small or duplicate/out-of-bound inputs retain O(F log F) comparison sort.
This reorders freshly read IDs and does not cache observations. The optional
`CIRCUIT_VERIFY_RANGED_SNAPSHOT` oracle compares positions, IDs, counts and
radii and sensor/screen metadata against the old view; enable it for correctness,
never for timing.

Definition metadata is immutable within the AI lifetime. Frame snapshots are
borrowed only during the owning callback. D-221 retains spatial bucket storage,
but clears only cells touched in the last generation. Dense map cells have
sparse overflow for legal off-map coordinates and a bounded-allocation fallback.
Pointers in the touched list must remain stable until clearing. Configure only
before use. Query traversal remains ordered z/x/insertion; clipping may skip
only provably empty cells. The [ordered legacy oracle](../../tests/ranged_geometry_test.cpp)
checks mutation, overflow, generation boundaries and sorting fallback.

`SpatialIndex::Any` is for pure existence predicates only. Do not use it for
ordered score accumulation or observable side effects. `DangerSign` relies on
nonnegative finite contributions and otherwise uses the original numeric sum;
its sentinel retains NaN comparison behavior. Static safety uses a separate
static index and conservative bounds, not a changed threat threshold. Run
`CIRCUIT_VERIFY_RANGED_QUERIES` against live old predicates separately from
timing. Do not describe local queries as unconditional O(1), or move engine
callbacks onto path workers.

After nested `ranged-enemies`, `ranged-friends` and `ranged-state` timers were
added, compare **inclusive** `ranged-snapshot` time across builds. Comparing its
new exclusive residual to the former unsplit parent manufactures a gain.
The [D-221 report](../reviews/2026-10-06-extra-high-performance-remediation.md)
records component measurements separately from natural-game evidence and the
unresolved upstream engine finding. The [focused runner](../../tools/run_ranged_performance_tests.sh)
compiles its tests and optional same-input kernels; run timing with games and
compilers stopped. Storage reuse does not remove the engine world scan or
justify cross-AI snapshot sharing without mutation/authority versions.
The [ranged report](../benchmarks/ranged-combat.md) separates behavior changes,
allocation savings, local command counts and the limits of FPS evidence.

## Entry points

- [AngelScript skill](../../skills/convention-angelscript/SKILL.md)
- [C++ skill](../../skills/convention-cpp/SKILL.md)
- [Test catalog](../testing/README.md)
- [Native tests](../../tools/run_native_tests.sh)
- [Performance tests](../../tools/run_performance_tests.sh)

## Builder GUARD queue preservation (D-223)

[GuardCommand](../../src/circuit/spring/GuardCommand.h) and the direct C callback
adapter suppress equivalent live builder guard intent, not all repeated target
IDs. Recoil's BuilderCAI prepends unflagged single-unit REPAIR while assisting;
internal MOVE and the task's finite right-mouse clearance MOVE may precede it.
A conflicting order, changed option/target or expired prefix must still recover.
No frame cache or rate limit is safe here: same-frame STOP and ownership changes
must remain observable. Read only on the callback thread. Complexity is O(Q) in
the inspected prefix, normally one/two commands, with O(1) stack storage and no
wrapper allocations. Keep predicate tests, real C-ABI adapter tests and supplied
recovery games when extending the accepted prefix. See [evidence](guard-orders.md).
CIRCUIT_VERIFY_GUARD intentionally adds wrapper reads and per-event logs; leave it
disabled for CPU timing. Command-count reductions do not establish FPS or peer
network savings. Other combat/support guard implementations are outside D-223.
