# tech_forward.as - TECH's land constructors leave the base

Script: [`data/script/src/roles/tech_forward.as`](../../data/script/src/roles/tech_forward.as),
namespace `TechForward`. Decisions: D-109 (release, mex defences, the spam cluster),
D-111 (spam labs on repeat, one lane per lab), D-114 (the spam labs are T1 front factory
clusters, [`tech_factories.md`](tech_factories.md)) in [`decisions.md`](../decisions.md).
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
  build the **spam cluster** forward: one T1 bot lab per +100 metal, each a T1
  front factory cluster of D-114 (its two turrets first, then the lab), its AA, and
  small turret pads; else assist what goes up there, else guard a spam lab.
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
| `SpamClusters` | `ForwardT1`, `TickSpam`, INV-039 | the T1 clusters of `TechFactories` (D-114): the spam labs |
| `ForwardT1` | `fwd.t1` | a spam cluster's turrets then its lab (`TechFactories::Work`, a new cluster while income asks for one), a standing spam lab's lost turret (`TechFactories::Refill`), one heavy AA behind each lab, a pad turret, assist, guard |
| `PadTurret` | `ForwardT1` | a 2x2 turret pad behind an end lab's turrets, a cell of walking room between (`SpamPadsMax`) |
| `SpamLabsWanted` | `ForwardT1`, INV-039 | one spam lab per `SpamLabMetalStep` of income, at most `SpamLabsMax` |
| `OrderPinned`, `OrderDefence`, `Buildable`, `Stands`, order bookkeeping | internal | pinned orders on reservations; a defence's cap lifted (TECH's start caps pin defences at 0) |
| `TickSpam` | `Tick` (D-111) | while spam runs: each spam lab on repeat (`CmdRepeat`), its lane fixed by its place in the row (`Spam::SetFactoryLane`), that lane set as its factory route (`CmdFactoryRoute`, re-applied when `Spam::routesVersion` changes), the spam unit's cap kept open |

## Invariants

INV-038 and INV-045 (in [`tech_factories.md`](tech_factories.md)), INV-039 (a released tier
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
| `SpamLabGapCells` | 2 | cells between side-by-side search positions of a front cluster (D-114) |
| `SpamClusterRadius` | 600 | forward constructors assist what goes up within this |
| `SpamPadsMax` | 2 | forward turret pads |

`Global::Spam::RepeatStallSeconds` (45): a factory on repeat that produced no spam
unit for this long gets its build again (D-111).

<!-- source: data/script/src/roles/tech_forward.as; blob: 95b9912469c59f9968dfce29b0149a555f548bc4; lines: 397 -->
