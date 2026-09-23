# TECH native base-layout design

This is the current design for TECH's planned base. It supersedes the
script-composed bay/spine/tenant design recorded by D-053 and D-057 while
retaining the repaired reservation lifecycle from D-059. D-063 replaced the
mature economy module of D-060 with the turret box below; the factory pair
of D-060 stands.

Decisions: [D-060](decisions.md#d-060--tech-layout-uses-native-canonical-clusters-and-an-ordered-economy-module)
(factory pair),
[D-063](decisions.md#d-063--the-turret-box-invisible-construction-turrets-first-the-economy-packed-against-them)
(turret box).
Implementation overview: [`base-layout.md`](base-layout.md).

## The turret box (D-063)

The owner's picture: invisible construction turrets in a reserved space
that did a terrain calculation to maximise build area; every building after
that plan built connected to the turrets, fitting up against that space.

```text
factory line / front (exits toward the enemy)
[ T1 lab ][ T2 lab ]        the D-060 pair
[ n n ]   [ n n n ]         their rear nano blocks
[ n n ]   [ n n n ]
------------------------    box front, one cell behind the deepest block
[ N N N N N N N N N N ... ] turret row 0   (held slots: invisible turrets)
[ shelf A: 12 cells of economy, packed nearest a turret first ]
[ N N N N N N N N N N ... ] turret row 1
[ shelf B ]
[ N N N N N N N N N N ... ] turret row 2
[ shelf C ]
[ N N N N N N N N N N ... ] turret row 3  (Supreme: four rows)
------------------------    box rear
```

**Fitting.** The box is a `ReserveZone` rectangle: `LayoutBoxAcrossCells x
LayoutBoxDepthCells` (40 x 44 cells) centred on the pair, its front one cell
behind the deeper nano block. Candidates are scored over rear offsets
(`LayoutBoxRearStepCells x LayoutBoxRearTries`) and side offsets
(`LayoutBoxSideStepCells x LayoutBoxSideTries`) by `FlatFraction(maxSlope =
LayoutBoxMaxSlope) x BuildableFraction(turret def)`; the largest size whose
best candidate reaches `LayoutBoxMinScore` (0.75) is taken, shrinking the
width first, then the depth, by `LayoutBoxShrinkCells` down to the minimum
size. Blocked cells inside the rectangle (a mex, a wreck, another plan) are
holes in the zone, not a refusal.

**Rows.** Turret rows are `LayBand` grids of one row each, laid slot by slot
at a pitch of `LayoutBoxShelfCells` (12) plus the turret's depth, from the
box front toward the rear, as many as fit up to `LayoutBoxNanoRows`. Slots
are held (unarmed): a plain nano task never takes one; only the planner's
pinned turret tasks do. A slot the terrain refuses is a hole in its row.
Every row spans the box width, so any cell of a shelf is within 12 cells
(192 elmos) of the nearest turret row: inside a turret's 400-elmo reach with
room to spare.

**Packing.** `PackNearGroup(zone, def, turretGroup, facing, anchor, reach,
minGap, group)` enumerates every footprint position of `def` inside the
zone whose cells are free (the zone's own marks tolerated, other slots and
structures not), keeps those within `reach` (0 = the turret def's build
distance) of the nearest turret slot and at least `minGap` from every one,
sorts by distance to the nearest turret then by distance to `anchor` (the
factory line), and reserves the first the terrain accepts. The result is an
armed any-reach reservation the task is pinned to. `CanPackNearGroup` is the
dry run; the planner offers only options that pass it.

**Grouping by def.** Once a structure or planned slot of the same def
stands in the box, `PackNearGroup` sorts by distance to that group first
(then nearest turret, then the asking builder), so each def grows as one
contiguous block - the winds together, the converters together - each block
still inside a turret's reach because the reach filter is applied before
the sort.

**Building order.** Turrets: a factory's own rear block first (D-060), then
`NextSlotAny(turretGroup, factoryCentre)`, the held slot nearest the
factories, so row 0 fills from the middle out, then row 1. The economy:
whatever `EcoPlanner::Decide` names next, packed nearest a turret; shelf A
fills before shelf B because ties go to the factory side.

**Explosions.** `LayoutConverterNanoGap` and `LayoutFusionNanoGap` (elmos)
keep those defs away from turret slots; both default to 0 (see the kill
distances below: 173 for an advanced converter, 379 for a fusion; a
12-cell shelf cannot hold a converter 173 from both rows). Density and
shared build power were chosen over firebreaks, as D-060 chose.

**Fallback.** No candidate clears the score: no box, the planner places
within `LayoutFallbackShakeCells` (8) of the factory nanos through the
ordinary search, logged once at level 1. That is the only spiral left for
TECH's economy.

**Persistence.** The zone id, turret group, size, rows, centre and factory
centre are native layout ints (`tech.box.*`), saved with the registry and
adopted by name after a load.

## Where the rules live (D-094)

Every ranking rule of the layout is written once in `src/circuit/terrain/LayoutRanking.h`
(engine-free, unit-tested in `tests/layout_ranking_test.cpp`, run with
`bash tools/run_native_tests.sh`); the terrain manager gathers slots and cells
and asks it. In the script, `LayRows` lays turret rows, `BetterBox` ranks box
candidates and `OrderLabOn` orders the advanced lab. The lab's site is flush
with a turret slot before it is near the home centre (D-095). The labs face
the nearest enemy from the front side of the block, and nothing is packed into
a factory's exit lane (D-096); the advanced lab stands on the block's front
line, its back to turret row 0. Turrets go up as many at a time as the nearby
build power and the metal pay for (D-097). Decision:
[D-094](decisions.md#d-094--the-layouts-ranking-rules-live-once-in-a-tested-header-the-layout-scripts-repeated-blocks-are-helpers).

## Rectangles, and the block grows from the advanced lab (D-088)

Same-def structures are packed nearest the centroid of their group, so they
fill a rectangle instead of a line. With the block at the home mexes the
pair's factory-nano slots are not used. The advanced lab's site is chosen
in any facing, nearest the home centre among sites eight slots reach, and
the block fills from it, so its first turrets stand flush (INV-017, the
distance logged). Decision:
[D-088](decisions.md#d-088--same-def-structures-fill-a-rectangle-the-block-and-its-turrets-grow-from-the-advanced-lab-the-lab-may-face-any-way).

## The home mexes anchor the layout; the lab next to a standing turret (D-086)

`Layout::HomeCentre`, the centroid of the home mex spots from native
`GetMexCentroidWithin`, anchors the box search, seeds the block and breaks
the lab's ties: the builders are at the mexes when the turrets begin. The
advanced lab keeps its planned footprint only while a standing turret is
within `LayoutLabServedReach`; otherwise it is packed nearest a standing
turret like every other building, exit clear. Decision:
[D-086](decisions.md#d-086--the-home-mexes-anchor-the-layout-the-advanced-lab-goes-next-to-a-standing-turret).

## The advanced lab at the seed side of the block (D-085)

`PickMost` weighs a served turret slot three times a planned one and breaks
ties by nearness to `Layout::TurretSeed` (the start position, or the
nearest lab when the box is behind the pair), the same seed the block
fills from, so the lab stands where the first turrets go. INV-016 says so
if it stands 90 s with no turret in reach. Decision:
[D-085](decisions.md#d-085--the-advanced-lab-stands-where-the-turrets-are-or-will-be-first-served-slots-weigh-three-ties-go-to-the-blocks-seed).

## The block at the start, built turrets first, the probe memoised (D-083)

The owner's rules after D-082: the first turrets near the starting mexes,
centred or slightly offset; buildings in range of built turrets first,
planned slots second; and a fifteen-second freeze at a converter order.
`LayoutBoxAtStart` centres the box search on the start position (never
over a pair factory slot); native `PackCandidates` ranks candidates by the
nearest served slot with planned slots penalised by 256 elmos;
`Layout::CanPlace` memoises the native probe for `LayoutCanPlaceMemoSeconds`
and the probe tries forty candidates at most. Decision:
[D-083](decisions.md#d-083--the-main-cluster-is-centred-on-the-start-built-turrets-outrank-planned-slots-for-placement-the-placement-probe-is-memoised).

## The block is placed for the ground around it (D-082)

The owner's finding: the first turrets stood against a mountain and the
fusion far from them. The box is scored and its zone reserved with a halo
of `LayoutHaloCells` on both sides and behind the block (never in front,
where the factory pair is), candidates whose block clears the floor ranked
by the halo's ground, and the side search reaches `LayoutBoxSideTries` x
`LayoutBoxSideStepCells` cells either way and may stand beside the pair
(`LayoutBoxForwardTries`, `LayoutBoxBesideClearCells`), so the block moves
off the mountain and the structures pack around it within a turret's reach
(INV-014). Decision:
[D-082](decisions.md#d-082--the-turret-block-is-placed-for-the-ground-around-it-a-halo-of-packing-space-on-both-sides-and-behind-scored-with-the-block).

## A block of touching rows, filled across, and a forward cluster (D-081)

The owner's rule: turrets are packed close, four rows per cluster (three
when the ground is tight), every row worked at once; a flat-area check
sizes the main cluster and at least one cluster is planned forward in
clear space, moved on if an ally takes it. `LayoutTurretBlock` makes the
rows touch with the shelf behind the block; `LayoutBoxNanoRows` is four
and `LayoutBoxMinRows` three (INV-012); native `NextSlotConnected` fills
the block outward from the centroid of the taken slots. `PlanForwardBox`
plans the forward cluster `LayoutForwardGapCells` ahead in ground that
scores and is not an ally zone, in its own turret group; `CheckForward`
gives it up and re-plans further forward when `IsZoneAlly` says an ally
took it (INV-013). Decision:
[D-081](decisions.md#d-081--the-turret-cluster-is-a-block-of-four-touching-rows-filled-across-with-a-forward-cluster-planned-in-clear-space).

## Turrets from the centre outward (D-077)

The owner's rule: turrets start at the centre of the planned layout and
grow outward as one connected cluster, so the most structures sit inside the
build power. `Layout::NanoTask` asks native `NextSlotConnected(group,
boxCentre)`: the first turret takes the slot nearest the box centre; every
later one the free slot nearest an already taken slot, ties broken towards
the centre. `ExpTurretCentreOut` (true) selects it; off restores D-069.
Decision:
[D-077](decisions.md#d-077--turrets-grow-outward-from-the-layouts-centre-t1-energy-is-reclaimed-once-fusion-tier-income-carries-the-base).

## Turrets beside a lab, the advanced lab beside the turrets (D-069)

`Layout::NanoTask` gives a box slot the anchor of the nearest standing lab
(every lab in `Factory::allFactories` asks `NextSlotAny` for its nearest
free slot; the shortest pair wins), so each turret reaches a lab;
`ExpTurretNearLab` off restores the pair's centre as the anchor.
`Layout::T2LabTask` orders the advanced lab on the pair's planned slot
unless a free footprint inside the turret layout is reached within
`ExpLabBuildPowerReach` (260) by strictly more turret slots, standing or
planned (native `PickMost`, front first among equals, D-073); then that
footprint, reserved, pinned and facing as the pair. The first lab is
placed by `tech_build.as` at the commander (D-066). Decision:
[D-069](decisions.md#d-069--turrets-beside-the-nearest-lab-the-advanced-lab-where-the-most-build-power-reaches).

## A factory's exit stays clear (D-074)

Native `IsExitClear`: the ground in front of a factory footprint (320 elmos
deep, the footprint's width plus 32 each side) must hold no structure and
overlap no planned slot of any group. The advanced lab's layout search, the
stock packer for gantries and labs, and the first lab's ring search all
refuse a site whose exit is not clear; the advanced lab's exit cone is held
once it stands, like the first lab's.

## The box grows, and never walls a unit in (D-072)

When no box zone has room for a structure, or no turret slot is left,
`Layout::GrowBox` reserves another box of the same width behind the last
one or beside the first (whichever ground scores best), with its own turret
rows in the same group (up to `LayoutBoxMaxExtra`), so energy, converters, fusions and labs keep packing
tight to the turret cluster instead of scattering around the base centre.
Native `LeavesPocket` refuses a packed footprint that would cut the zone's
free cells into a pocket not connected to the zone's edge (a constructor
was walled in by turbines). Decision:
[D-072](decisions.md#d-072--owners-rules-from-play-spot-ownership-income-bonus-deferred-reclaim-no-pockets-the-box-grows-upgrades-before-the-fusion).

## Goals

- TECH alone opts into planned placement.
- Factory exits remain clear.
- Every land factory receives a compact, symmetric rear nano cluster.
- Mature AFUS and advanced-converter production uses one compact, high-build-
  power module at the rear of the base.
- Layout geometry is deterministic and testable without Recoil.
- Script controls candidates, economy gates and build progression.
- Save/load and runtime role switching cannot orphan slot ownership.

## Meta basis

Current BAR construction turrets are 3x3 cells, provide 200 build power and
reach 400 elmos for Armada, Cortex and Legion. The shared knowledge base's
[build-power analysis](../../rjm.bar.docs/knowledge/50-economy/51-build-power.md)
places normal factory assistance around 1-3 turrets for T1 and 4-8 for T2.
That supports the two- and six-turret factory blocks below.

The mature module follows the compact pattern in RogueL1ke's
[blueprint guide](https://roguel1kegaming.com/top-10-tips-to-master-blueprints/)
and its July 2025 blueprint archive: 24 construction turrets shared by four
advanced fusions and an advanced-converter bank. CircuitAI uses the
18-converter variant so the AFUS group approximately funds its converters
while preserving production energy.

This compact arrangement is intentionally one blast domain. The shared
[structure-explosion analysis](../../rjm.bar.docs/knowledge/20-game-mechanics/26-structure-explosions-and-base-spacing.md)
shows that no T1 construction turret close enough to assist an AFUS can survive
that AFUS's destruction. The practical protection is therefore to put a
finite module at the rear and defend it. D-062's compact-base requirement
accepts the nearby factory line as part of that working blast domain; a second
base and irreplaceable strategic defenses stay separate rather than adding
small internal gaps that preserve neither safety nor density.

## Coordinate model

The blocking map uses 16-elmo cells. Canonical geometry uses integer
half-cells (8 elmos) for centres and integer cell edges for rectangles.
Odd-width buildings therefore have odd half-cell centres and even-width
buildings have even half-cell centres. Rotation is applied to the actual
`CCircuitDef` footprint before any width or depth is calculated.

This model lives in
[`BaseLayoutGeometry.h`](../src/circuit/terrain/BaseLayoutGeometry.h). It has
no engine dependencies and is the sole source for:

- facing vectors;
- footprint rotation and rectangle conversion;
- grids behind a front edge;
- factory rear blocks and exit rectangles;
- full and half economy modules;
- intersection, touching-edge and map-bounds checks.

## Factory layout

The initial T1 and T2 bot labs share a rear edge and face the native lane
point, with perpendicular facings tried if terrain rejects the preferred
bearing. Their clusters are atomic:

```text
             20-cell exits, width = factory width + 4
        [ T1 factory ]    [ T2 factory ]
            [n][n]        [n][n][n]
                           [n][n][n]
```

- T1: two 3x3 construction turrets in one centred row.
- T2: six 3x3 construction turrets in a centred 3x2 block.
- Nano footprints touch the factory rear edge.
- Exit rectangles touch the front edge and extend 20 cells / 320 elmos.
- Factories are separated enough that the widened exit rectangles do not
  overlap a neighbouring factory.

Every later non-water factory task asks native layout code for the next
cluster on the shorter side of the factory line. Candidate offsets are
deterministic. The cluster is committed only if the factory slot, every nano
slot and the complete exit rectangle pass preflight.

Completed factories expose their own named nano groups. TECH fills those
groups through exact, builder-reachable pins before it starts the main economy
module; they are not globally armed for unrelated nano tasks.

## Mature economy module

**Removed (D-063 cleanup).** `PlanEconomyModule`, `MakeEconomyModule`, the
module's script progression and its geometry tests are deleted; the
section is kept as the record of what D-060 built and why it was replaced
(it never fit on the Supreme tech starts and left no turret plan).

The module was a single deliberate blast domain at the rear of the base:

```text
factory line / front

[ C C C C C C ]  advanced converters, 3 rows
[ C C C C C C ]
[ C C C C C C ]
[ N N N N N N N N ]  T1 nanos, 3 rows
[ N N N N N N N N ]
[ N N N N N N N N ]
[ N N N N N N N N ]  Supreme override: fourth reserved row
[ A A A A ]      advanced fusions, 1 row
                         [ four-cell exterior access corridor ]
rear
```

The drawing is schematic; each symbol is one building, not one cell. With the
current footprints, the three bands are all 24 cells wide and their depths
sum to 27:

- 18 advanced converters: `3 x 6`, each 4x4;
- 24 T1 nanos by default: `3 x 8`, each 3x3; Supreme reserves `4 x 8 = 32`;
- 4 advanced fusions: `1 x 4`, each 6x6.

The half tier keeps the same default 27-cell depth at 12 cells wide:

- 9 advanced converters (`3 x 3`);
- 12 nanos (`3 x 4`);
- 2 advanced fusions (`1 x 2`).

There is no internal gap. The nano band touches both structure bands. The
access corridor is outside one long edge, four cells wide, so a constructor
retains a path along the module while the far-to-near rows fill.

## Candidate and degradation policy

AngelScript supplies candidate order, not coordinates:

1. lane-facing factory pair;
2. the two perpendicular facings;
3. deterministic forward and side offsets in configured cell steps.

After the factory line commits, script searches economy-module candidates by
increasing rear distance from a compact 12-cell front-edge setback and alternating side
offsets. Every full-tier
candidate is tried before any half-tier candidate. There is no partial module:
a failed candidate changes no reservation, group, zone or blocking-map cell.

If no factory pair fits, TECH disables the runtime opt-in and uses normal
placement. If the pair fits but neither module tier does, the factory clusters
remain active and normal economy placement continues.

## Slot ownership and order

The native registry names groups:

- `tech.factory.start.t1.factory`
- `tech.factory.start.t1.nano`
- `tech.factory.start.t2.factory`
- `tech.factory.start.t2.nano`
- `tech.economy.nano`
- `tech.economy.afus`
- `tech.economy.converter`

Automatically appended factories use native-generated `tech.factory.auto.N`
names. The registry, its names, slot order and plan metadata are serialized.

Economy slots start unarmed. Only
`CBuilderManager::EnqueueLayout(task, groupName, builder)` may claim one. Claim occurs
at enqueue time, before a builder searches, and required-pin searches accept
only that reservation. Native chooses the first ordered slot the requesting
builder can reach. A missing or invalid required pin aborts the task instead
of falling through to the spiral.

Each band is generated in far-to-near order: rear row to front row, then from
the side opposite the access corridor toward it. This prevents completed near
structures from blocking access to farther slots.

## Build policy

**Since D-063** the build policy is the planner's next-building function
([`eco-planner.md`](eco-planner.md)): turrets when build power is short or
metal floats, energy by cheapest E/s when short, converters when energy
floats, every structure packed against the turret rows. The module policy
below is the D-060 record.

At `LayoutModuleMinMetalIncome` and `LayoutModuleMinEnergyIncome`, an eligible
TECH constructor advanced the native module:

1. fill every completed factory's rear nano group;
2. build the nano rows currently justified by regional build power and income;
3. start exactly one AFUS frame;
4. after it completes, build four advanced converters;
5. start the next AFUS only after that baseline tranche and only when no AFUS frame is
   active;
6. admit fifth converters only from a 90%-full bank and measured surplus.

Nano and converter concurrency are bounded by script settings. AFUS concurrency
is always one. Existing economy policy remains responsible for all structures
outside the module.

## Save/load and role changes

The native registry is authoritative. Save version 8 contains group and zone
names, integer metadata, slot order, claim state, factory-line bounds and the
complete reservation/zone state. Builder tasks serialize their exact pin and
required/failure flags.

On load, the registry is restored before builder tasks. Script adopts the plan
by name and re-reads facing and module tier. Numeric group IDs are never the
script's source of truth.

On role leave, `ResetLayout` aborts layout-owned builder tasks before releasing
their reservations and zones. This prevents stale tasks from constructing
after TECH is no longer active.

## Validation

The standalone C++20 test target under [`tests/`](../tests/) verifies:

- all four facings;
- odd/even footprint alignment;
- T1/T2 nano counts and symmetry;
- touching edges and non-overlap;
- rear direction and exit dimensions;
- full/half module dimensions and counts;
- exterior corridor placement;
- far-to-near slot order;
- bounds and intersection helpers.

Command:

```text
cmake -S tests -B build-layout-tests
cmake --build build-layout-tests --config Release
ctest --test-dir build-layout-tests -C Release --output-on-failure
```

The geometry tests pass. Full engine integration and in-game behavior remain
unverified; see
[KI-407](known-issues.md#ki-407--native-tech-layout-refactor-is-not-yet-played).
