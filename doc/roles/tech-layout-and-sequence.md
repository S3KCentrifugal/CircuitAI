# TECH: how the base is laid out and how it is built

The one-page picture of the TECH role as it plays today (D-108). It explains
**where** every structure goes (the layout) and **when and by whom** it is
built (the sequence). The decisions carry the history and the evidence
([`decisions.md`](../decisions.md)); the owner's requirements, each with its
decision and invariant, are in [`tech-requirements.md`](tech-requirements.md).
The older layout documents ([`../layout-design.md`](../layout-design.md),
[`../base-layout.md`](../base-layout.md)) record how the design got here; where
they disagree with this page, this page is current.

Game facts behind the choices (build power, reach, the metal bank as a sink,
converters, the air constructors' jobs) are in the knowledge base:
`../rjm.bar.docs/knowledge/70-strategy/77-eco-tech-player.md`.

## In one paragraph

TECH plans a **block of construction turrets** at the start, next to its home
mexes, and a second block **forward** of it. Every economy building is placed
**within reach of those turrets** (so the turrets build it and nothing walks),
flush against them first. The **factories** stand flush against the turrets
too, facing the enemy. The build order is a **rush chain** to the first
advanced fusion (the objective), then an **ordered rule table** that every
builder asks in turn: reclaim first, then build power, then the chain, then
the economy. From about 23 minutes **two T2 air constructors are dedicated**:
one only ever builds advanced energy converters, the other only advanced
fusions, and a dead one is replaced at once.

## Part 1: the layout (where)

### The turret blocks

```
            enemy (the front)
                  ^
    +-----------------------------+
    |  forward cluster (zone 8)   |   8 cells ahead, its own turret rows
    +-----------------------------+
          ^ lane kept clear ^
  [adv lab]  +-------------------+  [T1 lab + nanos]
  faces the  |  main cluster     |
  front      |  4 turret rows    |   the rows touch: one solid block
             |  (zone 7)         |
             +-------------------+
   economy sets flush on every free side, then the ring within reach
```

- **Main cluster** (`Layout::PlanBox`, D-063, D-081 to D-083): a block of
  `LayoutBoxNanoRows` (4) touching rows of construction-turret slots, placed
  on the flattest ground near the home mexes (the `OpeningMexCap` (3) mexes
  within `OpeningMexRadius` (700) of the start). The block is a rectangle
  (D-088); the turret slots are filled from the centre outward (D-077).
- **Forward cluster** (`PlanForwardBox`, D-081): the same kind of block
  `LayoutForwardGapCells` (8) cells toward the front. If an ally builds on its
  ground it is re-planned `LayoutForwardStepCells` (12) further on, up to
  `LayoutForwardTries` (3) times.
- **The blocks do not grow** (D-099, the owner's rule). A building outside a
  turret's reach would be built by a walking constructor. When a zone is full,
  the ring of ground around it *within a turret's reach* is used, then the
  next closest cluster.
- Every placement is a **reservation** in native `CTerrainManager`, pinned to
  the build order, so two builders never take the same ground. When TECH
  reclaims a structure its ground returns to the pool (D-101,
  `MarkSlotRecycled`).
- A reserved slot the engine refuses to build on 3 times is **dead** (D-108):
  it is never offered again and its ground stays held, so the same bad ground
  is not packed again. Each refusal is logged with its reason
  (`RESERVE: pinned slot N for X cannot be served: ...`).

### What goes where, in order of preference

| Structure | Where | Rule | Decision |
| --- | --- | --- | --- |
| Construction turret | the next free turret slot, from the block's centre outward; the main block first, then forward | `Layout::NanoTask` | D-077, D-081 |
| First T1 lab | at the commander, anywhere (the start has no turrets). The same with no turret of ours on the map (a restart after a wipe) | `lab.t1.opening`, `lab.t1.recover` | D-101 |
| Advanced (T2) lab | on the block's front line, flush against the turrets, facing the front | `Layout::T2LabTask`, `ReserveFrontLab` | D-085, D-095, D-096 |
| Every other factory (T1 spam labs, T1/T2 air plants, rebuilt labs) | flush against a built turret, ranked by the smallest gap; any cluster, its ring included. Air plants may face any way (their units fly) | native `FactoryTask::FindBuildSite` → `PackFactoryFlush` | D-104 |
| Advanced fusion | a **set of up to 3**: the first flush against a turret, the others lined up away from it; the set's next slot before a new set | `Layout::Place` → `NextSetSlot` / `PackSetAnywhere` | D-101, D-108 |
| Advanced energy converter | a **set of up to 5**, the same way | same | D-101 |
| Anything else (fusion, storage, T1 converter, solars) | the cell nearest a turret, nearest the builder among equals | `Layout::Place` → `PackNearGroup` | D-063, D-064 |
| T1 spam bot lab | the **spam cluster** (below), forward of the base, never in the base | `TechForward::ReserveNext` | D-109 |
| Mex-cluster defence (long-range AA, flak) | at each mex cluster outside the base, native picks the site within 160 of its centre | `TechForward::DefendMexes` | D-109 |

### The spam cluster (D-109)

```
   front  ->
            [T]  [LAB]  ->  exit lane (kept clear)
            [T]
                 (lane: 2 cells)
            [T]  [LAB]  ->
            [T]
   [pad 2x2]                         pads: behind the end labs' turrets
```

- A row of T1 bot labs about 1,400 elmos toward the front (never more than
  45% of the way), all facing the front, 2 cells apart so every lab has its
  own lane. The first lab picks the row line nearest the anchor that fits;
  every later lab joins that line beside the others, never in front of or
  behind a lab.
- Each lab gets **two construction turrets directly behind it** (a nano
  block tight against its back). Those two always work for that lab
  (`turret.spam`, the first turret rule).
- Small 2x2 turret pads behind the end labs' turrets, a cell of walking room
  between, once the row holds two labs.
- One heavy AA behind each lab.
- One lab per +100 metal, up to `SpamLabsMax` (6), only while the T1 land
  constructors are released (below).

How a new set finds ground (`PackSetAnywhere`, D-108): each zone of the main
cluster, then the forward zone; if none has room, the same again including
the ring round each zone within turret reach. The ranking (`PickFlushSite`,
`LayoutRanking.h`) puts a site touching a **built** turret first, then the
smallest gap.

Advanced-fusion ground is **held ahead** (D-108): while the fusion role has a
builder, the next set of advanced-fusion ground is reserved before it is
needed, so the converters (placed far more often) cannot fill every flush
site. A failed search waits 10 s before the next try.

### Kept clear

- **A factory's exit lane** (D-074, D-098): no structure is packed in front of
  a lab's door. Labs face the lane toward the front (the nearest enemy;
  from the north-east start of Supreme Isthmus that is south).
- **The front side of a cluster** is kept for factories: economy sets use the
  ring only after the zones are full; factories always scan the ring.

## Part 2: the sequence (when, and by whom)

### The phases

| Phase | Roughly | What happens | Where |
| --- | --- | --- | --- |
| Opening | 0-1 min | the commander takes the home mexes; the first T1 lab at once | `opening.mex`, `lab.t1.opening` |
| Rush chain | 1-18 min | a computed build order to the objective (`RushObjective`, today `afus`): mexes, energy, the advanced lab, 14 energy, the mex upgrades **before** the fusion (D-100), the fusion, 2 turrets, the advanced fusion | `chain.next`, [`tech_chain.md`](tech_chain.md), D-070 |
| Economy | after the chain | the rule table's economy rows: converters while energy floats, turrets while metal floats, storage, energy when short | the rows below `chain.next` |
| Online | +200 metal | the "economy online" latch (D-102, D-105): labs are no longer reclaimed for metal, spam labs scale with income, the T1 lab is not rebuilt while there are 3+ T1 constructors | `TechBuild::EcoOnline` |
| Air | ~23 min | a T1 air plant, one T1 air constructor, the advanced aircraft plant (D-103); its T2 air constructors take the two dedicated roles (D-107, D-108) | factory production, `air.dedicated` |
| Forward | from the air phase | the land constructors leave the base once the air constructors carry it (D-109, below) | `fwd.t2.defend`, `fwd.t1` |
| Endgame | +200 / +500 | the nuke plan, T2 then T3 assault (D-080) | `legacy.strategic` |

### The rule table: every builder asks it, top to bottom

`TechRules` ([`tech_rules.md`](tech_rules.md)) is one ordered table. A builder
that needs work asks each row in order; the first row whose conditions hold
and which returns a task wins. The order is the priority. Today, from the
top:

1. **Construction turrets** (turrets only): `turret.assist`: a reclaim in
   reach first; then, when converters cannot stay on, the advanced fusion
   frame; then the economy frames in the D-065 order (advanced converter,
   turret, advanced fusion, converter, fusion, ...). `turret.any`,
   `turret.factory` (with the bank full: assist a producing factory),
   `turret.wait`.
2. **Keep the current job** (`keep.current`): a builder that native re-asks
   while building keeps what it is on.
3. **Dedicated air constructors** (`air.dedicated`, `air.flex`, D-107/D-108,
   below).
4. **Reclaims**: the throwaway T1 lab once the advanced lab is under way; the
   advanced lab while the advanced fusion goes up (unless the D-105
   projection says the bank will pay for the fusion anyway); T1 energy once a
   finished reactor covers it.
5. **Build power**: `power.t1` (T1 constructors add a turret rather than
   assist a dear frame), then `energy.convert.float`, then `power.turret`
   (metal ahead of spending while something builds: another turret, as many
   at once as `Layout::TurretsAllowed` says; below).
6. **The chain** (`chain.next`): the first unmet target.
7. **The economy rows**: labs, mexes, energy, the advanced lab (again once
   online if none stands), mex upgrades, converters, turrets, storage, spam
   labs, the endgame, defence.
8. **Fallbacks**: repair, assist anything near, guard the lab, wait 3 s.

### How many turrets at once (D-097, D-098)

Turrets go up one at a time on a small economy and in parallel once the
metal and the nearby build power pay for it. With `B` the build power within
`EcoBuildPowerRadius` (700) of the base, `T` a turret's build time, `C` its
metal cost, `M` the bank and `I` the income, `k` turrets may be in flight
when:

- by power: `k <= B x PowerTurretBatchSeconds (20) / T`: each still
  finishes fast;
- by metal: `k x (C - I x T / B) <= M`: paid in full, no stall.

The smaller of the two, between 1 and `PowerTurretsMax` (8). Every dear frame
(`ChainParallelCostM`, 400 metal or more, such as the advanced lab) near the
base takes one of those slots first: early on a turret and the lab never go
up together.

### What the factories make (`Tech_FactoryAiMakeTask`, first match wins)

1. A T1 lab: T1 constructors until `MinimumT1ConstructorBots` (2).
2. The T1 air plant: one air constructor while none exists (it builds the
   advanced aircraft plant; D-103).
3. The advanced aircraft plant: a T2 air constructor whenever a dedicated
   role has no builder, whatever the bank or the cap (D-108).
4. The advanced labs: T2 constructors while the metal bank is over
   `T2ConstructorBankShare` (50%), up to `T2ConstructorCap` (60) bot and air
   together (D-103).
5. Then the role's production (fast-assist bots, the endgame's combat,
   spam from +200).

### The two dedicated air constructors (D-107, D-108)

- The first two T2 air constructors take the roles: **advanced converters**
  and **advanced fusions**. A role is claimed the moment the unit is built,
  before the donation code could give the unit away.
- A dedicated builder does only its own structure: it builds it through the
  layout, else assists a frame of its own kind, else **waits** 3 s and says
  why (`[TECH][Air] dedicated N waits for ...`). It never falls through to
  another rule.
- Its structure's unit cap never stops it: the start caps (TECH starts with
  the advanced fusion capped at 0) and the chain's step targets (1) are
  lifted one past the count while the role is held (D-108; played: the cap of
  1 stopped the fusion builder after the sixth, while other paths that do not
  check the cap built a few more).
- When a dedicated builder dies, the role passes at once to another T2 air
  constructor of ours, the advanced fusions first. That builder drops
  whatever other job it held. If no air constructor is free, the advanced
  aircraft plant makes one.
- The other T2 air constructors (`air.flex`): advanced converters while
  energy overflows; the advanced fusion frame the moment the converters
  cannot stay on (the energy bank under `ConverterStarveEnergyShare` (50%) of
  storage, or stalling). The turrets make the same switch after their
  reclaim.

### The land constructors leave the base (D-109)

The air constructors build and assist in the base; the land constructors go
out:

| Tier | Released when | They do | Recalled when |
| --- | --- | --- | --- |
| T2 (bots) | both dedicated T2 air roles are held | defend the mex clusters outside the base: a long-range AA at each, then a flak at each, nearest first; the rest help a defence going up or follow a constructor carrying one | a dedicated role is open |
| T1 (bots) | more than 5 T1 air constructors (the T1 air plant keeps 6) | the spam cluster: the next lab, each lab's two turrets, its AA, the pads; else assist what goes up there, else guard a spam lab | 5 or fewer T1 air constructors |

A recalled land constructor drops its forward job (`land.recall`, ahead of
`keep.current`) and the eco rows take it back to the eco clusters.

### The ferry: donated constructors fly (D-091, D-110)

In a team game TECH gives T2 constructors to teammates, flown by a transport
it received from AIR. From the moment the transport is sent until the
drop-off, the cargo and the transport take no other order:

- the cargo is parked on a hold that ignores damage (no retreat) and the
  `ferry.cargo` rule, first for every mobile builder, keeps it there;
- the transport's run is not abandoned when it is hit;
- "aboard" means lifted **and** following the transport, so a constructor
  standing on a raised factory pad is never mistaken for cargo; a run always
  ends (delivered or failed, and the next queued run starts).

### The metal bank (D-105, D-106)

A full bank is wasted metal. The sinks, in order: build power (turrets),
production (T2 constructors, spam labs, turrets assisting factories), and,
in a team game, the teammates: over 95% full, TECH refreshes every
teammate's economy and gives up to 20% of its storage to the lowest-filled
ones (`TechBuild::ShareOverflow`). No converters are built while the metal
bank is full (they turn energy into metal nobody can store).

## Part 3: who decides what

| Concern | Native (C++) | Script |
| --- | --- | --- |
| Ground: reservations, sets, flush ranking, factory sites | `CTerrainManager` (`PackSet`, `PackNearGroup`, `PackFactoryFlush`, `LayoutRanking.h`) | `Layout` (`manager/layout.as`): plans the clusters, asks for sites |
| Build orders, frames, assist | `CBuilderManager` (`Enqueue`, `FindUnfinishedFor`, `CountUnfinishedNear`) | `TechRules` (the table), `TechBuild` (the acts), `TechChain` (the rush) |
| Factory production | `CFactoryManager` | `Tech_FactoryAiMakeTask` (`roles/tech.as`) |
| Economy readings, teammates | `CEconomyManager`, `STeamEco` | `TeamEconomy` (`manager/team_economy.as`) |
| Checks in play | - | `Invariants` (`manager/invariants.as`): the `[INVARIANT] INV-nnn` lines |

## Part 4: where to change what

| To change | Edit | Setting |
| --- | --- | --- |
| Turret rows, forward cluster distance | `Layout::PlanBox`, `PlanForwardBox` | `LayoutBoxNanoRows`, `LayoutForward*` |
| Set sizes | `Layout::SetSizeOf` | `LayoutAfusSetSize` (3), `LayoutConvSetSize` (5) |
| Factory placement | native `CTerrainManager::PackFactoryFlush` | - |
| The order of priorities | the row order in `TechRules::Init` | - |
| The rush chain | `TechChain` recipes | `RushObjective` |
| Parallel turrets | `Layout::TurretSlots` | `PowerTurretBatchSeconds`, `PowerTurretsMax` |
| T2 constructors | `Tech_FactoryAiMakeTask` | `T2ConstructorBankShare`, `T2ConstructorCap` |
| Donation | `TechBuild::ShareOverflow` | `TeamShare*` |
| Dedicated air roles | `TechBuild::AirDedicated`, `RefillAirRoles`, `LiftCapForRole` | `ConverterStarveEnergyShare` |

## The checks that guard it

Layout: INV-012 to INV-014, INV-016 to INV-018, INV-020, INV-022 to INV-024,
INV-029. Sequence: INV-004, INV-006 to INV-011, INV-019, INV-021, INV-025 to
INV-028, INV-031 to INV-042. Each is described with its decision in
[`../invariants.md`](../invariants.md); what triggers which actor is in
[`../actor-matrix.md`](../actor-matrix.md).
