# tech_forward.as - TECH's land constructors leave the base

Script: [`data/script/src/roles/tech_forward.as`](../../data/script/src/roles/tech_forward.as),
namespace `TechForward`. Decisions: D-109 (release, mex defences, the spam cluster),
D-111 (spam labs on repeat, one lane per lab) in [`decisions.md`](../decisions.md).
Role document: [`tech.md`](tech.md). Rule rows: [`tech_rules.md`](tech_rules.md).
The one-page picture: [`tech-layout-and-sequence.md`](tech-layout-and-sequence.md).

## Intent

Once the air constructors carry the base (they build and assist the eco
clusters), the land constructors go out. The owner's rules:

- **T2** (bots): released once both dedicated T2 air roles are held
  (`TechBuild::airConvId`, `airAfusId`, D-107/D-108). They defend the mex clusters
  outside the base: a long-range AA at each, then a flak at each, nearest first.
- **T1** (bots): released while more than `T1AirReleaseAbove` (5) T1 air
  constructors stand (the T1 air plant keeps `T1AirConstructorTarget`, 6). They
  build the **spam cluster** forward: one T1 bot lab per +100 metal, each lab's
  two turrets, its AA, and small turret pads; else assist what goes up there, else
  guard a spam lab.
- A tier whose air constructors go down is **recalled**: its land constructors drop
  a forward job and the eco rows take them back to the eco clusters.

## Functions

| Function | Rule row / caller | What it does |
| --- | --- | --- |
| `T1Released`, `T2Released`, `Released(tier)`, `T1AirCons` | predicates | the release conditions above |
| `IsLand`, `Tier` | `LandCon` predicate | a bot, not an air constructor; the constructor tier |
| `Tick` | `TechBuild::Tick` | logs each release and recall once, keeps the frames INV-039/040 read, runs `TickSpam` |
| `IsForwardJob`, `Recall` | `land.recall` | a construction beyond `ForwardHomeRadius` of the base is dropped when the tier is recalled (INV-040) |
| `Clusters` | `DefendMexes`, INV-039 | our mexes (`Economy::MexTracker::myMexes`) grouped within `MexClusterRadius` |
| `DefendMexes` | `fwd.t2.defend` | long-range AA then flak at each cluster outside `MexDefenceBaseClear`; else help a defence going up, else follow a constructor carrying one |
| `Plan`, `LinePos`, `RowMiddle`, `SiteFits`, `ReserveNext` | `ForwardT1` | the spam cluster: an anchor `SpamForwardElmos` toward the front (at most `SpamForwardMaxShare` of the way); the first lab takes the fitting line nearest the anchor, later labs join it beside the others (never in a lab's lane); each lab reserved with a 2x1 nano block tight behind it |
| `ForwardT1` | `fwd.t1` | the next spam lab, a lab's turrets, one heavy AA behind each lab, a pad turret, assist, guard |
| `PadTurret` | `ForwardT1` | a 2x2 turret pad behind an end lab's turrets, a cell of walking room between (`SpamPadsMax`) |
| `TurretFocus` | `turret.spam` | the two turrets behind a spam lab always guard (or build) that lab |
| `LabAt`, `TurretAt`, `TurretsOf`, `SpamLabsStanding`, `SpamLabsWanted` | internal, INV-038 | a spam site's lab and turrets |
| `OrderPinned`, `OrderDefence`, `Buildable`, `Stands`, order bookkeeping | internal | pinned orders on reservations; a defence's cap lifted (TECH's start caps pin defences at 0) |
| `TickSpam` | `Tick` (D-111) | while spam runs: each spam lab on repeat (`CmdRepeat`), its lane fixed by its place in the row (`Spam::SetFactoryLane`), that lane set as its factory route (`CmdFactoryRoute`, re-applied when `Spam::routesVersion` changes), the spam unit's cap kept open |

## Invariants

INV-038 (a spam lab standing 180 s has both its turrets), INV-039 (a released tier
with forward work waiting orders some of it within 180 s), INV-040 (a recalled land
constructor drops its forward job within 60 s); D-111's INV-043 lives in
`Spam::CheckRoutedUnits`. See [`../invariants.md`](../invariants.md).

## Settings (`Global::RoleSettings::Tech`)

| Setting | Default | Meaning |
| --- | ---: | --- |
| `T1AirReleaseAbove` | 5 | more than this many T1 air constructors release the T1 land constructors |
| `T1AirConstructorTarget` | 6 | the T1 air plant keeps this many |
| `ForwardHomeRadius` | 900 | a construction beyond this from the base centre is a forward job |
| `MexClusterRadius` | 600 | a mex within this of a cluster's centre joins it |
| `MexDefenceBaseClear` | 900 | clusters nearer the base are the eco layout's ground |
| `MexDefenceRadius` | 400 | a defence within this of a cluster's centre counts for it |
| `MexDefenceShake` | 160 | native picks the defence's site within this |
| `ForwardOrderHoldSeconds` | 120 | an order at one place is not repeated within this |
| `SpamForwardElmos` / `SpamForwardMaxShare` | 1400 / 0.45 | the spam cluster's distance toward the front |
| `SpamLabGapCells` | 2 | cells between two labs of the row |
| `SpamRowTries` / `SpamSearchLines` | 12 / 12 | positions across and lines along searched for a lab |
| `SpamClusterRadius` | 600 | forward constructors assist what goes up within this |
| `SpamPadsMax` | 2 | forward turret pads |

`Global::Spam::RepeatStallSeconds` (45): a factory on repeat that produced no spam
unit for this long gets its build again (D-111).

<!-- source: data/script/src/roles/tech_forward.as; blob: c1ed229c7df0aa3e43226782dfbd79e500fc2750; lines: 597 -->
