# tech_factories.as - TECH's land factories move toward the front

D-136: `BaseLandFactory` excludes `TechFlank::Owns` factories. Their dedicated
flank production must survive base rezoning. `LandFactoryCount`, `AdvancedLabUp`
and `AdvancedLabAny` exclude the dedicated lab/frame from ordinary factory
accounting, so it cannot prevent replacement of the normal advanced lab.

Script: [`data/script/src/roles/tech_factories.as`](../../data/script/src/roles/tech_factories.as),
namespace `TechFactories`. Decision: D-114 in [`decisions.md`](../decisions.md).
Role document: [`tech.md`](tech.md). The one-page picture:
[`tech-layout-and-sequence.md`](tech-layout-and-sequence.md).

## Intent

From +200 metal (`TechBuild::EcoOnline`) TECH's land factories stop being built at
the main base. Each new one stands in its own **front factory cluster**: the
factory plus a block of construction turrets directly behind it, the turrets built
first. The clusters march toward the front:

- a cluster stands at least `FrontMinShare` (20%) of the way from the home centre
  toward the front, further as needed (up to `FrontMaxShare`), never nearer than the
  furthest cluster already planned;
- the first spot that fits wins: the factory and its turret block on flat ground
  (`FrontMinFlat` of it within `LayoutBoxMaxSlope`), buildable, the exit lane clear;
  first away from other buildings (ours and allies', `FrontClearCells` of room,
  no allied zone), then close to them when nothing roomier fits;
- the turret block: T1 lab 2 x 1, T2 lab 2 x 2, T3 gantry 3 x 2
  (`FrontT*TurretCols/Rows`);
- with `FrontReclaimAtCount` (3) land factories on the map, the land factories at
  the main base (within `FrontBaseRadius` of its centre) are retired and reclaimed
  and never rebuilt there; the base's planned factory footprints go back to the
  economy;
- with no land factory on the map, the base may hold one again (the opening's rules);
- the advanced lab first (D-102): once the economy is online a T1 front lab is ordered
  only while an advanced lab stands; with none (the base's was rezoned), rule
  `lab.front` plans and builds a T2 front cluster before any new T1 cluster;
- a land constructor whose tier is recalled (its air constructors down, D-109) gets
  no front work (`TechForward::Recalled`);
- a standing factory's lost turret is rebuilt; a lost factory is rebuilt at its
  cluster (its footprint reserved again), or the cluster is given up when the ground
  is taken.

The spam labs of D-109 are the T1 clusters (`TechForward::SpamClusters`).

## Functions

| Function | Caller | What it does |
| --- | --- | --- |
| `LandFactoryNames`, `IsLandFactory`, `LandFactoryCount`, `TierOf`, `TurretBlock` | internal, predicates | T1 / T2 bot and vehicle labs and land gantries; the block size per tier |
| `Active` | every router | front placement applies: the economy online and a land factory on the map |
| `Fits`, `Plan`, `T3Blocks` | `OpenCluster` | the search above; a found spot is reserved (the factory, its nano block) and becomes a `Cluster`; D-119: a gantry's spot is searched with room for the smallest block and gets the biggest that fits (10x5 down to 3x2) |
| `OpenCluster`, `Work` | `Route`, `TechForward::ForwardT1` | the work of a def's open cluster: its turrets (pinned to their slots), help on a turret going up, then the factory (pinned) once every turret of the block stands finished (a gantry: once `FrontT3TurretsFirst` of its up to 50 stand, the turret orders going on to fill the block; `TurretsBeforeLab`, D-119); a block with a slot the engine refused goes on behind the turrets that stand after 240 s without turret work (logged) |
| `MayPlan` | `Work` | a new cluster only when the replaced path would have ordered the factory: T1 always (`fwd.t1` counts them), an advanced lab when available or none stands, a gantry when available and off the gantry cooldown (planning one starts it); the cap is lifted for T1 and T2 only |
| `Route` | `Layout::OrderFactory`, `Layout::T2LabTask`, the chain's `gantry`, the legacy lab paths in `tech.as` | a land factory order from +200 metal: the front cluster's next work, never the base's placement |
| `RefillWanted`, `Refill` | rule `lab.front` (every tier), `TechForward::ForwardT1` (T1) | a standing factory's lost turret is rebuilt on its slot (INV-038) |
| `AdvancedLabUp`, `AdvancedLabAny`, `AdvancedLabDef`, `NeedAdvancedLab` | `Work`, `OpenWork`, `TechForward::ForwardT1` | the advanced lab first: a T1 front lab waits for a finished one that is not retiring; with none at all (a frame counts, `AdvancedLabAny`) and no open T2 cluster, `lab.front` plans one |
| `OpenAbove`, `OpenWork` | rule `lab.front` | a lost turret first, then the advanced lab's cluster when none stands, then an open T2 or T3 cluster carried to the end by any constructor reaching the row: its turrets, help on one going up, then its factory (the T1 clusters are `fwd.t1`'s) |
| `Row`, `spamRows`, `ExtendRow`, `RowSlot`, `RowPitchCells`, `LaneBox`, `LanePassable`, `HoldLane`, `NewCluster` | `Plan` | D-117: a T1 cluster joins a spam row at an end (up to `FrontRowMaxLabs`, side by side) or starts one; a T3 lane is held as a corridor beside each end whose ground is passable; a row needs one; D-119: labs `FrontRowGapCells` (3) apart, and an end lane let go for a failed growth is put back without the passability test |
| `ClusterOfTurret`, `NO_DISRUPT` | `TurretFocus` | D-117: a spam cluster's turrets are marked `no_disrupt` (the native reclaim pull skips them) and wait for their lab before it exists |
| `TurretFocus` | `Tech_FactoryAiMakeTask` (factory side), rule `turret.spam` (builder side) | a cluster's turrets work for its factory: factory side (D-119, turrets are the native factory manager's): repair its frame, else the unit it produces (`LabYardRadius`), else a 2 s wait; builder side: repair, else a non-interruptible guard; recorded in `focusOf` (INV-048) |
| `BaseLandFactory`, `ReclaimBaseFactory`, `ReleaseBaseFactoryGround`, `baseRetired` | rule `lab.base.reclaim` | the base's land factories retired and reclaimed at the count (recorded, so INV-026 knows it is the rezoning, not a retirement for metal); its factory footprints released |
| `LabAt`, `TurretAt`, `TurretsOf`, `FinishedTurrets`, `IsClusterLab`, `CountTier`, `OrderPinned` | internal, INV-038, INV-045 | a cluster's factory and turrets |
| `IsSpamLab`, `IsOwnTurret`, `GuardsLab`, `TurretsBeforeLab` (D-119) | the guard door, `DoTurretFactory`, `GuardFactory`, INV-048, INV-049 | a T1 cluster's lab is a spam lab; a turret's own lab; the lab a turret was sent to guard |
| `WhyNotFits` (D-119) | `ExtendRow` | why a row cannot grow at an end, logged once a minute |

## Invariants

INV-038 (a front cluster's factory standing 180 s has its whole turret block),
INV-045 (a front cluster's factory frame starts only with its whole turret block
finished), INV-046 (an open T2 or T3 cluster has its factory within
`FrontClusterOpenSeconds`),
INV-044 (with the count reached, no land factory stands at the base for
`FrontBaseReclaimSeconds`), INV-049 (a spam lab is assisted only by its own two
turrets, D-119). See [`../invariants.md`](../invariants.md).

## Settings (`Global::RoleSettings::Tech`)

| Setting | Default | Meaning |
| --- | ---: | --- |
| `FrontMinShare` / `FrontMaxShare` / `FrontShareStep` | 0.2 / 0.8 / 0.04 | how far toward the front the search runs, and its step |
| `FrontLateralTries` | 6 | positions tried each side of the line per step |
| `FrontMinFlat` | 0.85 | the flat share of a cluster's ground |
| `FrontRoomyShare` / `FrontClearCells` | 0.9 / 4 | the first pass: the buildable share of a ring of this many cells round the cluster |
| `FrontT1TurretCols/Rows`, `FrontT2...`, `FrontT3...` | 2x1, 2x2, 10x5 | the turret block per tier (D-119: a gantry's up to 50; smaller blocks from `T3Blocks` where the ground is smaller) |
| `FrontT3TurretsFirst` | 10 | D-119: a gantry is ordered once this many of its turrets stand; the rest keep filling |
| `FrontReclaimAtCount` | 3 | land factories on the map that retire the base's |
| `FrontBaseRadius` | 1200 | a land factory within this of the base centre is the base's |
| `FrontBaseReclaimSeconds` | 240 | INV-044 |
| `FrontRowMaxLabs` / `FrontRowGapCells` | 4 / 3 | D-117: a spam row's labs, side by side; D-119: 3 cells apart, clear of the neighbour's blocker yard (`fac_bot` yard 6: 3 cells each side) |
| `FrontT3LaneCells` / `FrontLaneMinFlat` | 6 / 0.9 | D-117: the T3 lane beside a row (the largest T3 movement classes are 3.5 cells wide) and how passable it must be |
| `FrontClusterStallSeconds` | 300 | a factory order with no frame this long gives its cluster up (ground released) |
| `FrontClusterOpenSeconds` | 600 | INV-046 |

<!-- source: data/script/src/roles/tech_factories.as; blob: 33f932ea31eeb7915a98bdc9457bce021c832840; lines: 975 -->

## D-152 reserve before spending

`PlanAhead` holds two future clusters each for T1 bot labs, T2 bot labs and gantries
(`PlannedFactoryClustersPerTier`, D-153) with the existing
`Plan` geometry and turret blocks. Native named integers preserve these future
plans; factory exit corridors are held too. `Cluster::ahead` excludes them
from `CountTier`, `NeedAdvancedLab`, `OpenAbove`, `OpenWork`, and overdue-work
invariants. Only `OpenCluster`, reached from a normal authorized build rule,
activates one only when `planNew` and `MayPlan` both permit spending; activation starts the gantry cooldown and work
clock. The next advance plan can then be reserved without purchasing it.

`ReadyCluster` inspects the entire lab/turret plan before activation or first
work. A blocked unused cluster releases its slots, turret zone, envelope and
exit/lateral corridors before searching again. A claimed or previously started
cluster stays fixed. `NewCluster` protects gaps with a native envelope; normal
defense searches cannot fill them. Allied reservations are visible natively,
including during every candidate check and exact task placement.
