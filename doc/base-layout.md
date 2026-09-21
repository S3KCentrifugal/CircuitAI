# Base layout

CircuitAI normally places structures with the existing nearest-free search.
The experimental profiles additionally permit a native reservation mechanism,
but only TECH opts its AI instance into it. This keeps every other role and
every legacy profile on the ordinary placement path.

The current TECH design is decision
[D-060](decisions.md#d-060--tech-layout-uses-native-canonical-clusters-and-an-ordered-economy-module)
for the factory pair and
[D-063](decisions.md#d-063--the-turret-box-invisible-construction-turrets-first-the-economy-packed-against-them)
for the turret box that replaced the economy module (`PlanEconomyModule` and
its geometry are deleted; `PackNearGroup`, `CanPackNearGroup`, `NextSlotAny`
and `SetLayoutInt` were added).
The earlier reservation and complex designs remain in D-029, D-043, D-053 and
D-057 as history; this document describes the resulting implementation.

## Gate and ownership

Two conditions are required:

1. the loaded experimental `behaviour.json` fragment contains
   `"layout": {"enabled": true}`; and
2. `Tech_Init` calls `aiTerrainMgr.SetLayoutEnabled(true)`.

JSON only permits the mechanism. It does not activate it. No other role calls
the opt-in API. If either condition is false, reservation matching is skipped
and factory/building placement is unchanged.

Native C++ owns:

- footprint rotation and exact grid snapping;
- factory, nano, economy-module and corridor geometry;
- preflight, atomic commit and rollback;
- named groups/zones, ordered slots, claims and built-state tracking;
- task pinning and required-pin failure;
- save/load and role-reset invalidation.

AngelScript owns:

- candidate order and fallback order;
- whether TECH opts in;
- full-versus-half economy-module preference;
- income gates and the nano/AFUS/converter progression.

## Canonical geometry

[`BaseLayoutGeometry.h`](../src/circuit/terrain/BaseLayoutGeometry.h) is
dependency-free C++20. It represents centres in half-cell units (8 elmos) and
rectangles on blocking-map cell edges (16 elmos). That is enough to represent
both odd and even footprints without rounding a 3-cell or 9-cell structure
onto an even-footprint centre.

Every footprint comes from the actual `CCircuitDef` dimensions. Rotation is
applied before width/depth arithmetic. The same functions are used by runtime
planning and the standalone tests.

## Factory clusters

The initial T1/T2 bot-lab pair is planned atomically on a common rear line.
Candidate facings are lane-facing first, then the two perpendicular facings;
script supplies deterministic forward/side offsets. Each cluster includes:

- one exact factory slot;
- a snug rear nano block;
- a 20-cell / 320-elmo forward exit rectangle, factory width plus four cells.

The default nano layouts are:

| Factory tier | Nano layout | Count |
| --- | --- | ---: |
| T1, six-cell lab | one centred `2 x 1` row | 2 |
| T2, nine-cell lab | centred `3 x 2` block | 6 |

Later land-factory tasks are handled natively in `CBFactoryTask`: an existing
matching factory slot is claimed, or `CTerrainManager` searches outward from
the factory line and atomically reserves a new factory/nano/exit cluster.
Floating and underwater factories retain normal placement.

If an opted-in land factory cannot obtain its required slot, the task is
aborted. It never silently uses the ordinary spiral. The role can enqueue a
replacement later, avoiding both a misplaced factory and an infinite stalled
task.

Once a planned factory is complete, TECH deliberately fills its named rear
nano group before starting the mature economy module. These slots are held,
not globally armed: only `EnqueueFactoryNano` may claim a reachable slot, so
ordinary nano tasks and the economy module cannot steal the factory's block.

## Main economy module

The module is behind the factory line but deliberately compact. The first
front-edge candidate is 12 cells behind the common factory rear line; later
candidates step back only when terrain or reservations refuse the tighter
site. Script tries every configured rear distance and side offset for the full
tier before trying the half tier.

The structural rectangle has no internal gaps:

| Tier | AFUS band | Nano band | Advanced-converter band | Size |
| --- | --- | --- | --- | --- |
| Full | `1 x 4` (4) | `3 x 8` (24) | `3 x 6` (18) | `24 x 27` cells |
| Half | `1 x 2` (2) | `3 x 4` (12) | `3 x 3` (9) | `12 x 27` cells |

Supreme's map profile requests four nano rows, producing 32/16 reserved nanos
and `24 x 30` / `12 x 30` module footprints. Reservation is not construction:
the rows are built progressively from regional build-power demand.

The converter band is nearest the factory line, the nano band touches both
structure bands, and the AFUS band is farthest to the rear. A four-cell-wide
constructor corridor runs along one exterior side for the module's full
depth. It touches but never overlaps the structure rectangle.

All module slots are held but **unarmed**. Ordinary energy, converter or nano
tasks cannot consume them. `CBuilderManager::EnqueueLayout` claims the next
slot in a named group and creates a required-pin task. Within every group,
slots are ordered far-to-near: rear rows first, then from the side opposite
the access corridor toward it.

TECH policy builds:

1. the currently justified module nano rows, with bounded concurrency;
2. one AFUS;
3. four converters for each completed AFUS;
4. the next AFUS only when no AFUS frame is active and the baseline converter
   tranche is complete.
5. permit a fifth converter only while the 90%-full bank and measured net
   surplus cover its actual native energy use.

This still yields at most `4 AFUS / 18 converters` for the full tier and
`2 AFUS / 9 converters` for the half tier. A second module is preferable to
unbounded extension, but is outside this task.

Every later land factory, including a gantry, is placed on the enemy-facing
factory line with its own rear nano block and clear forward exit. Water
factories retain ordinary placement.

## Atomicity and task lifecycle

Factory clusters and economy modules preflight every exact structure slot and
corridor before changing the blocking map. Commit creates named zones and
groups only after the candidate passes. Any commit failure removes only
objects created by that operation.

Exact pinning claims a slot at enqueue time, so two tasks cannot select the
same unserved reservation. A retry first restores its previously served slot,
preserving the CR-010 fix. `BeginReservedSearch` still gates reservation
consumption to builder-task searches, preserving CR-002.

A production-factory task acquires its layout slot only when it becomes
active. Economy planning may hold inactive factory tasks outside the manager's
active/serialized task sets; deferring the claim prevents those placeholders
from orphaning a slot. `TaskB::Factory` tasks for ordinary structures are not
eligible, and floating or underwater production remains on normal placement.

A required pin has no spiral fallback. If its slot disappears, becomes
unbuildable or cannot be reached, the builder task aborts through the normal
task lifecycle, releases its claim, and returns its assignees to normal
selection. Non-layout and unpinned tasks retain the previous fallback.

`ResetLayout` first aborts every layout-owned builder task, then removes
reservations and zones. This prevents a role switch from leaving a task that
can build at an obsolete position.

## Save/load

Native state is authoritative. Save version 8 stores:

- runtime enable state and factory-line metadata;
- named group and zone registries;
- named integer metadata such as facing and module tier;
- every reservation's order and claim state;
- zones, owned cells, definitions, positions, facings and built-unit links;
- each builder task's served slot, required pin and pin-failure state.

Zone ownership has a separate low-resolution reservation underlay beneath
standing structures. Load and reset restore/remove that underlay exactly once,
so a completed building cannot leak a permanent low-resolution blocker.
Loaded, unstarted tasks recreate their build-position blocker before
scheduling resumes.

On load, native state is restored before builder tasks. `Layout::Adopt`
recognises the named groups and re-reads the restored facing and the box
ints (`tech.box.*`); it does not reconstruct identity from script-held
numeric IDs.

## Script-facing API

The primary API is:

```angelscript
bool SetLayoutEnabled(bool enabled);
bool IsLayoutEnabled() const;
bool IsLayoutConfigured() const;

bool PlanFactoryPair(
    const string& in name,
    const CCircuitDef@ t1Factory,
    const CCircuitDef@ t2Factory,
    const CCircuitDef@ nano,
    const AIFloat3& in base,
    int facing,
    int sideOffsetCells,
    int forwardOffsetCells);

// The turret box (D-063): a zone, held turret rows (LayBand), and the packer.
int ReserveZone(const AIFloat3& in centre, int facing, float halfAcross, float halfAlong, bool corridor);
int LayBand(int zone, const CCircuitDef@ def, const AIFloat3& in frontCentre, int facing, int cols, int rows, int gap,
            bool armed, bool anyReach, bool tenant, int group = 0);
int PackNearGroup(int zone, const CCircuitDef@ def, int nanoGroup, int facing, const AIFloat3& in anchor,
                  float maxReach, float minNanoDist, int group);
bool CanPackNearGroup(int zone, const CCircuitDef@ def, int nanoGroup, int facing, float maxReach, float minNanoDist);
int NextSlotAny(int group, const AIFloat3& in anchor) const;
void SetLayoutInt(const string& in name, int value);

bool HasLayoutGroup(const string& in name) const;
int GetFactoryNanoAvailable() const;
int GetFactoryNanoActive() const;
int GetLayoutGroupTotal(const string& in name) const;
int GetLayoutGroupBuilt(const string& in name) const;
int GetLayoutGroupStarted(const string& in name) const;
int GetLayoutGroupAvailable(const string& in name) const;
int GetLayoutInt(const string& in name, int fallback = 0) const;
AIFloat3 GetLayoutGroupCenter(const string& in name) const;

IUnitTask@ aiBuilderMgr.EnqueueLayout(
    const SBuildTask& in task,
    const string& in group,
    CCircuitUnit@ builder);

IUnitTask@ aiBuilderMgr.EnqueueFactoryNano(
    const SBuildTask& in task,
    CCircuitUnit@ builder);
```

The older low-level reservation/zone APIs remain available for compatibility,
but TECH no longer performs footprint or band arithmetic in AngelScript.

## Validation

The pure geometry suite is independent of Recoil:

```text
cmake -S tests -B build-layout-tests
cmake --build build-layout-tests --config Release --target circuit_base_layout_test
ctest --test-dir build-layout-tests -C Release --output-on-failure
```

It covers all four facings, odd/even footprints, factory nano counts and
symmetry, touching edges, non-overlap, rear direction, exit rectangles,
full/half module dimensions and counts, far-to-near order, bounds and
intersection helpers.

Runtime behavior is not yet Played; see
[KI-407](known-issues.md#ki-407--native-tech-layout-refactor-is-not-yet-played).

## Related

- [`layout-design.md`](layout-design.md)
- [`roles/tech.md`](roles/tech.md#base-layout-plan)
- [`angelscript-references.md`](angelscript-references.md#cterrainmanager-aiterrainmgr)
- [`intent.md`](intent.md)
