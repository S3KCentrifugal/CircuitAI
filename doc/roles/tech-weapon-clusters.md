# TECH weapon clusters: design

Status: **built** (D-126); what is built, with its settings, is in [`tech_weapons.md`](tech_weapons.md), and the lanes in [`tech-lanes.md`](tech-lanes.md) (D-127). This page keeps the design and the owner's requirements.
Game facts behind it (height and range, line of fire, walls, spacing) are in
the knowledge base: [66-defensive-placement.md](../../../rjm.bar.docs/knowledge/60-tactics/66-defensive-placement.md).

## The owner's requirements

| Id | Requirement |
| --- | --- |
| W1 | A new cluster type, **weapon clusters**, alongside the economy and factory clusters. TECH only; other roles unaffected. |
| W2 | A more advanced selection mechanism, from battlefield tactics: where AA (flak, long-range AA) helps, where long-range artillery goes, where LRPCs go, **counting the range that altitude adds**. |
| W3 | A super-cannon cluster (Calamity, Starfall, Ragnarok, with LRPCs) that follows the enemy's composition and observed behaviour, placed **20% to 40% behind the front** in a safe area, preferring altitude for range. |
| W4 | Front weapon clusters keep friendly movement open and efficient. Enemy movement meets obstruction, danger and deliberate funnelling: spam turrets and high-DPS long-range weapons. Weapons that fire over walls are walled in. |
| W5 | Each weapon cluster has at least **4 construction turrets** near it. |
| W6 | Research the meta to derive how to analyse terrain, which cluster to build first, and where. |
| W7 | No strategically important defensive capability depends on **one structure, one position, one weapon class, one radar, or one defensive line**. |
| W9 | The super cannon (owner): 20% to 40% back **from an active combat zone**. All air build power goes to it the moment it is started. Metal income at least +500 to start, ideally over +1000. With it: two advanced energy storages, dense forward flak, long-range AA, plasma deflectors and anti-nuke. The cluster takes defence very seriously. |
| W8 | Beaches are protected from amphibious units, ships and, later, T3. The map is analysed and beaches classified. **No torpedo turret goes by water too shallow for submarines.** |

My reading of two points, to confirm:
- **W3's "20% to 40% behind the front"** (owner, confirmed): 20% to 40% of
  the **cannon's range**, back from an **active combat zone** (a 6100 cannon
  stands 1220 to 2440 behind the fighting). LRPCs use the same band.
- **W4's "antiFriendly units require open and efficient movement"**: our own
  units' routes through a front cluster stay open (gated lanes on the paths
  our factories use); the walls and funnels face the enemy's approach only.

## What the AI has to work with today

- **Native, not bound to the script:** the threat map (air, surface,
  amphibious layers), the influence map, enemy groups with per-role costs, the
  path finder with threat costs, bwem's terrain areas and chokepoints
  (`GetTAChokePoints`: centre, both ends, small or not), elevation.
- **Bound:** `FlatFraction`, `BuildableFraction`, `CanReachAt(unit)`, the
  reservation calls (`ReserveGrid`, `ReserveNanoBlockAt`, `ReserveZone` with
  corridors, `PackSet`), `aiEnemyMgr.GetEnemyCost(type)`,
  `GetNearestGroupPos`, `aiMilitaryMgr.GetCombatFocusPos`.
- **Defences now:** `TechForward::OrderDefence` (no reservation),
  `DefendMexes` (D-109), the D-123 defence ring, one LLT and one light AA at
  the factory. LRPCs spiral out from the start spot (KI-418: "the cannon's
  high ground is native work"). No walls anywhere: native's wall and choke
  code is commented out (MilitaryManager.cpp:911-959).
- **The front** is geometric: `Layout::FrontTarget()` is the setup lane point,
  pulled in by the nearest enemy group worth 1500 metal.

So the design needs a small native analysis layer first; the placement policy
then lives in script, like the other clusters.

## 1. Battlefield analysis (native, bound to the script)

A grid of **analysis cells, 64 elmos** (8 squares), built once at start and
refreshed in parts. Pure queries: no orders, no effect on other roles.

### Static layers (at start)

| Layer | How | Used for |
| --- | --- | --- |
| Height, slope, buildable per footprint (4×4, 5×5, 8×8) | elevation, `FlatFraction`, `BuildableFraction` | every site test |
| **Avenues of approach** | native path finder, from each enemy start spot to our base centre and to each of our clusters, for each enemy movement class seen or expected (tank, bot, hover, amphibious). Each cell counts the paths crossing it. | where the enemy will come; kill zones; AA bearing |
| **Chokes** | bwem chokepoints on the avenues, with width from their two ends; plus avenue cells whose clearance (distance to impassable) is a local minimum | kill-zone anchors |
| **Friendly lanes** | the same paths run from our labs (and front clusters) to the front | lanes kept open (W4) |
| **Effective range** | `EffectiveRange(def, from, to)`: the engine's own formula (Cannon `GetStaticRange2D` for ballistic weapons, sphere with `heightmod` for the rest) | altitude (W2, W3) |
| **Line of fire** | height ray-march from a site to the cells it must cover | direct-fire turrets only |

### Dynamic layers (every 30 s)

| Layer | Source |
| --- | --- |
| Front line | where influence crosses 0 along each avenue; else today's `FrontTarget` |
| Threat at a point, by kind (surface, air) | the threat map |
| **Enemy composition** | enemy groups' role costs: air (and bombers apart), artillery and LRPC, T2 heavies, T3, amphibious and naval, statics; plus nuke silos seen |
| **Behaviour memory** (decaying heatmaps, half-life about 5 minutes) | entry points (where enemy land units are first seen in our half); air tracks (enemy aircraft positions over our half); losses (where our structures die, and to what kind of weapon) |

Bindings added: `aiBattle.Height(p)`, `EffectiveRange(def, from, to)`,
`AvenueHeat(p)`, `Chokes()` (centre, ends, width, heat), `FriendlyLane(p)`,
`Threat(p, kind)`, `Influence(p)`, `Composition()`, `Heat(kind, p)`,
`LineOfFire(from, to, muzzle)`.

## 2. The cluster kinds

A weapon cluster is an anchor point, its weapons, its wall plan, a radar, and
**at least 4 construction turrets** (W5) placed in two pairs on the cluster's
safe side, inside build range (400) of the structures they serve and, where
the ground allows, outside the enemy's artillery reach.

| Kind | Members | Where |
| --- | --- | --- |
| **Kill zone** (front) | many cheap direct-fire turrets (LLT, Beamer, Twin Guard; Pharos for Legion), high-DPS ones (HLT, then Pulsar / Bulwark / Bastion), pop-ups (Dragon's Claw/Maw/Jaw, Pit Bull, Scorpion, Chimera), smart artillery behind them, a heavy AA | on an avenue, on our side of a choke, 55% to 85% out from base to front |
| **Air defence** | flak (Arbalest, Birdshot, Pluto, Lupara), heavy AA (Chainsaw, Eradicator), long-range AA (Mercury, Screamer, Xyston) after enemy T2 air | in front of each high-value asset group, on its air approach bearing |
| **Artillery** | T1/T2 smart artillery (Gauntlet, Agitator, Amputator; Rattlesnake, Persecutor, Eviscerator), tactical missiles (Catalyst, Perdition) | high ground overlooking a kill zone or an avenue, one artillery range behind it |
| **Long-range** | LRPCs (Basilica, Basilisk, Olympus), targeting facilities | high ground 20% to 40% behind the front (W3) |
| **Super cannon** | Ragnarok / Calamity / Starfall, with its escort: 2+ advanced energy storages, dense forward flak, long-range AA, 2 plasma deflectors, anti-nuke (section 4a) | 20% to 40% of its range back from an active combat zone, highest ground first (W3, W9) |

A cluster is a small version of the factory clusters (`TechFactories::Cluster`):
held footprints, a nano block, an order queue, reach share kept, re-planned
when an ally takes the ground.

## 3. Which cluster to build: the need score

Each kind gets a **need** from the enemy's composition and behaviour, then
the builder takes the kind with the highest `need × (1 − coverage) / cost`.
All weights are settings in `Global::RoleSettings::Tech`.

| Kind | Need rises with | Need falls with |
| --- | --- | --- |
| Kill zone | enemy ground army cost; entry-point heat on an avenue; our losses to raids | enemy artillery or LRPC in range of the site (statics lose to artillery) |
| Air defence | enemy air cost; air-track heat over our assets; bombers seen; T2 air (adds long-range AA) | AA already covering (a spend cap: AA at most `AirShareMax` of the weapon budget, since baiting AA is the raider's aim) |
| Artillery | enemy statics near the front; a stable front (no line movement for N minutes); enemy ground massing at a choke | enemy air (artillery cannot defend itself) |
| Long-range | enemy static value within reach; enemy artillery (counter-battery); enemy fleets; a stable front | no enemy value in reach |
| Super cannon | metal income **+500 or more** (preferred +1000) **and** energy for its fire (about 25,000 E/s) **and** a stable front **and** enemy value within reach **and** a site that fits its escort | enemy nukes or heavy air unanswered; T3 pushes (the metal is better in defence) |

Adaptation by composition (from the knowledge base's counter tables):

| Enemy shows | Weapon clusters |
| --- | --- |
| Air-heavy | more air-defence clusters on the air tracks; long-range AA once T2 air or heavy bombers appear |
| Artillery / long range | fewer turrets; counter-battery artillery and LRPCs on higher ground; shields over key clusters |
| T2 heavies | fortification walls, pop-ups, high-alpha turrets |
| T3 | high-damage turrets and artillery in depth; EMP (Armada); walls give no protection (crushed) |
| Sea / amphibious | LRPCs on the coast (they out-range every ship); cover the shore |
| Nuke building | anti-nuke, two overlapping over the core |
| Repeated attacks on one avenue | the next kill zone on that avenue, deeper than the last (depth) |

Budget: weapon clusters start once the rush targets are met (the D-070 +200
metal gate), and take at most `WeaponShare` (proposed 25%) of income, rising
to 40% when our losses heat up. TECH stays an economy role first.

## 4. Where: site scoring per kind

Candidates come from the analysis grid, filtered by footprint, reach
(`CanReachAt`), `IsZoneAlly`, and never on a friendly lane. Each kind scores
the survivors; the best is taken, then spacing rules strike its neighbours.

**Kill zone.** Anchor on a choke on an avenue. The engagement area is the
choke and the ground just past it on the enemy side.
- Each direct-fire turret: score peaks when its distance to the engagement
  area's centre equals its effective range less 10%
  (`range − (dist − range)²`, SPCNeill's influence-map method), times line of
  fire to the engagement area, times mutual support (inside a neighbour's
  range).
- Smart artillery: one artillery range behind the turrets, higher ground
  first.

**Air defence.** For each asset group (advanced fusions, labs, converter
blocks, front clusters), its value by CVRT (criticality, vulnerability,
recuperability, threat: FM 3-01.11). Flak sits between the asset and its air
approach bearing (from air tracks, else from the enemy start spots), so that
bombers are in reach before the 1280 release distance; heavy AA inside it;
long-range AA set to hold its missiles for groups, not lone scouts.

**Artillery, long-range and super cannon.** For each candidate:
`score = height_gain × enemy_value_in_reach × safety`, where
- `height_gain` is the effective range from the candidate to the front and
  beyond, from the engine formula: an LRPC 200 elmos above the front reaches
  about 800 further (5463 against 4650);
- `enemy_value_in_reach` is enemy value (statics, groups, avenue heat) within
  that range;
- `safety` is 0 inside enemy threat or within one enemy artillery range of the
  front, rising with distance back.

The long-range and super-cannon band is 20% to 40% of the weapon's range back
from the nearest active combat zone (W3, W9).

## 4a. The super-cannon cluster (owner's rules, W9)

Ragnarok (`armvulc`), Calamity (`corbuzz`) and Starfall (`legstarfall`): each
about 65,000 metal and 750,000 energy, 26,000 to 33,500 HP, range 5750 to
6100, firing on energy (about 25,000 E/s sustained). The cluster takes its
defence as seriously as the cannon.

**When to start.**
- Metal income at least **+500** (`SuperMinMetalIncome`); preferred above
  **+1000** (`SuperIdealMetalIncome`). Between the two, it starts only when the
  need score (section 3) is high: a stable front and enemy value in reach.
- Energy income enough to fire: about 25,000 E/s spare.

**Where.** **20% to 40% of the cannon's range back from the nearest active
combat zone.**
- The **active combat zone** is where fighting is happening now: the losses and
  damage heatmap of the last few minutes, and the cells where enemy and allied
  threat overlap. It is not the geometric front.
- With a 6100 range, the cannon stands 1220 to 2440 behind the fighting and
  reaches 3660 to 4880 past it. The range is the height-boosted one (section
  4), so higher ground both extends the reach and allows the site to stand
  further back.
- If the fighting moves, the band moves with it for the next cannon. A cannon
  already built stays.
- The site must also fit its escort (below) within the escort radius, and keep
  1280 from other critical structures (nuke AoE).

**All air build power, at once.** From the moment the cannon is framed, every
air constructor we own builds it: the dedicated converter and fusion pair
(D-107), the D-123 defenders and every other air constructor. Only a ferry in
flight (D-122) finishes its delivery first. They return to their roles when the
cannon is finished or destroyed. The escort is built by the land constructors
and the cluster's construction turrets.

**The escort, ordered with the cannon.**

| Escort | Count | Where |
| --- | --- | --- |
| Advanced energy storage (`armuwadves`, `coruwadves`, `legadvestore`: 40,000 each, about 840 metal) | at least **2**, and always enough to hold a full shot (below) | inside the shield, not within one bomb's reach of the cannon |
| Anti-nuke (`armamd`, `corfmd`, `legabm`: coverage 2000) | 1 with the cannon, **2** overlapping once an enemy silo is seen | within 2000 of the cannon, spaced so one nuke cannot take both |
| Plasma deflector (`armgate`, `corgate`, `legdeflector`: radius 550, 6175 shield HP, 562 E/s to recharge) | **2**, overlapping over the cannon | beside the cannon, their circles overlapping at its centre |
| **Dense forward flak** (Arbalest, Birdshot, Pluto; Lupara) | a thick arc, proposed 6 to 8, more when enemy air is seen | toward the enemy's air approach, 300 to 700 in front of the cannon, so bombers meet it before the 1280 release distance |
| Long-range AA (Mercury, Screamer, Xyston) | **2**, set to hold missiles for real targets | one each side of the cannon, more than one missile AoE (425) apart |
| Construction turrets | at least 4 (W5), proposed 8 for this cluster | two groups, inside build range of the cannon and the shields |
| Walls | a full ring (section 5) | round the cannon, storages, shields and AA: all fire over or through them |
| Radar and sonar | 2 (W7) | high ground in the cluster |

Order of work: the cannon is framed first (air build power), the anti-nuke,
the first deflector and the flak arc next (land constructors and turrets),
then the storages, long-range AA, second deflector and walls.

**Energy storage and the Starfall.** The engine starts a salvo only when the
full shot's energy is in storage (`HaveResources(cost)`, Weapon.cpp:479).
- A Ragnarok shot costs 15,000 and a Calamity shot 18,000: two storages give a
  buffer.
- A **Starfall salvo costs 360,000** at once.
- Owner's rule: meet the cannon's energy requirement, whatever it is. The
  storage is computed from the weapon def, not hard-coded: storages to build =
  `max(2, ceil((shot cost × 1.1 − storage we have) / 40000))`. For a Starfall
  with a late-game TECH's 120,000 that is about 7; for a Ragnarok or Calamity,
  2. The count is recomputed if a storage dies.
- The cannon's energy income is checked the same way: spare income at least
  the cannon's sustained draw (shot cost / reload).
- Whether BAR tops the Starfall up in Lua is unverified. The rule holds either
  way; a played run checks that it fires.

**Defence taken seriously: invariants.**
- INV-057: while a super cannon is framed or standing, every air constructor
  we own is on it, except a ferry mid-delivery.
- INV-058: a super cannon stands, or is framed, only with its escort framed or
  standing within the escort radius:
  - advanced storages enough for a full shot (at least 2);
  - at least 1 anti-nuke, 2 once an enemy silo is seen;
  - 2 deflectors, 2 long-range AA, the flak arc;
  - 4 or more construction turrets.
- INV-059: no super cannon framed below +500 metal income.


## 5. Walls and movement (W4)

- **Walls round what fires over them.** A full dragon's-teeth ring (a
  fortification-wall ring from T2, or against T2 heavies) round LRPCs, super
  cannons, flak, long-range AA, smart artillery, anti-nukes and silos: none of
  them is blocked by friendly walls.
- **Walls in front of direct fire.** A staggered double row 2 to 3 segments in
  front of each direct-fire turret, toward the engagement area, never between
  the turret and the engagement area's centre (line of fire checked).
- **Funnels.** On the enemy side of the choke, teeth rows angled to narrow the
  avenue into the kill zone's centre, where the fields of fire overlap. Every
  wall is covered by fire.
- **Friendly lanes.** The friendly lanes stay clear: a gate at least 3 cells
  wide where a lane crosses a wall line, the gate itself inside the kill
  zone's fire. The corridor reservations (`ReserveZone(..., corridor)`) hold
  them.
- **Not a wall line.** No continuous line across the map ("no one can build a
  line the enemy cannot pass"): walls shape the avenues toward the kill
  zones.

## 6. Redundancy (W7), each an invariant

| Rule | Proposed invariant |
| --- | --- |
| Every avenue into our base crosses **two** defended positions in depth (two kill zones, or a kill zone plus artillery covering it) once kill zones exist | no avenue with heat above X has a single defence |
| Each high-value asset group is covered by **two AA structures of two kinds** | no asset group under one AA kind |
| Each front sector is seen by **two radars** at least 400 apart, on high ground or terrain edges (terrain blocks radar) | no front sector with one radar |
| Every weapon cluster has **two weapon classes** (direct plus indirect, or flak plus missile AA) | no single-class cluster |
| No two critical structures (LRPC, super cannon, anti-nuke, advanced fusion, lab) within **1280** (nuke AoE); long-range fire split across at least two sites | no long-range capability at one position |
| **Two anti-nukes** overlapping over the core, once an enemy silo is seen | no core under one anti-nuke |
| Every weapon cluster keeps **4 construction turrets** | no cluster under 4 turrets for 60 s |

## 7. Coasts and beaches

The owner asked how beaches are protected from amphibious units, ships and,
later, T3; how the map is analysed and beaches classified; and never to put a
torpedo turret by water too shallow for submarines. The game facts are in the
knowledge base,
[67-coastal-defence.md](../../../rjm.bar.docs/knowledge/60-tactics/67-coastal-defence.md).

### What decides a beach's defence

- **Depth decides who can come:**
  - 0 to 20: land units wade;
  - 8 and more: ships;
  - 15 and more: submarines and battleships;
  - any depth: hovers (on the surface) and amphibious units (on the seabed);
  - T3: armbanth, corkorg and legeheatraymech walk the seabed at any depth;
    corjugg and armthor stop at 20.
- **Guns cannot hit what is underwater.** An amphibious unit or a T3 walker
  in deep water is hit only by torpedoes and depth charges, and seen only on
  sonar. It comes within reach of guns in the **emergence band**, where the
  water is shallower than its height.
- **Torpedoes hit neither hovers nor units on land,** and stop on the seabed:
  a sandbar between launcher and target blocks them.
- **A torpedo launcher can be built 12 deep, but a submarine needs 15.**

### Map analysis (native, at start; part of section 1's grid)

1. **Depth grid** from the heightmap at 32 elmos (section 1's grid, halved
   near water): the seabed depth of every cell.
2. **Depth masks** at 0 (land), 8 (ships), 15 (submarines), 20 (the wading
   limit), 24 (T2 naval turrets, advanced sonar).
3. **Water bodies:** connected components of the 8 mask and of the 15 mask.
   A body is **hostile** if it touches the coast of an enemy start spot, or if
   an enemy shipyard or naval unit has been seen in it (updated in play).
4. **Shoreline:** land cells next to water, walked along the coast into
   **beach segments** of about 512 elmos.
5. **Per segment:**
   - the **offshore profile**: depth at 100, 250, 500 and 1000 elmos out along
     the normal;
   - the **landing slope**: for each movement class (amphibious bot,
     amphibious tank, hover, wading land unit), whether it can climb from the
     water onto the land here. This comes from the native movement areas: is
     the water cell in the same area, for that class, as our base?
   - the **emergence band**: the strip where the depth rises from 20 to 0;
   - what lies behind it: our assets within 1500, and the distance to our
     base.
6. **Landing routes:** the path finder, run for the hover, amphibious and
   ship classes from each enemy start spot (and each hostile water body) to
   our base and clusters, as for the land avenues. The beach segments these
   paths cross are the **landing zones**, weighted by path count.

### Beach classes

Each class is a flag; one beach can carry several.

| Class | Test | Who can land or attack there | Defence |
| --- | --- | --- | --- |
| **Cliff** | no class can climb out of the water | ships bombard only | long-range fire if ships come in reach, else nothing |
| **Wading shelf** | water under 20 deep, joining other land | land units walk across; hovers; amphibious units already surfaced | a land kill zone at the shore: direct-fire turrets, walls, artillery. **No torpedoes.** |
| **Ship water** | 8 to 15 deep within about 600 of the shore, in a hostile body | ships (bombardment), hovers | surface guns: land HLTs and pop-ups, floating HLTs and heavy floating turrets; artillery and LRPCs on the coast's high ground; floating dragon's teeth in the shallows. **No torpedoes.** |
| **Deep water** | 15 or more within about 600 of the shore, in a hostile 15 body | submarines; amphibious and T3 walkers underwater; ships | everything in ship water, plus **torpedoes** (the rule below), depth charges on the shore, and sonar |
| **Hover beach** | hovers can climb out from a hostile body | hovers | surface guns; torpedoes are useless (hovers are immune) |

### The torpedo rule (hard, checked before every order)

A torpedo launcher (T1 or T2) is ordered only if:
1. every footprint square is **15 deep or more**, not the engine's 12;
2. its cell belongs to a **hostile 15 body**, so submarines can come;
3. a straight line from the site to a point at least 60% of its range away
   stays 15 deep all the way (no sandbar);
4. at least half of its range circle lies in that body.

A **depth-charge launcher** (built on land, fires into water) is ordered only
if at least half of its 600 range circle lies in a hostile 15 body, reached
across water with no bar. It is the shore's answer to amphibious and T3
walkers in deep water.

INV-054: no torpedo or depth-charge launcher of ours stands where the rule
fails.

### Where the defences go at a landing zone

In layers, from the sea inward:
1. **Out at sea.**
   - LRPCs and the super cannon, which out-range every ship, on the coast's
     high ground (section 4).
   - T2 torpedo launchers (890 to 915, beyond a T2 submarine's 800) at **sea
     chokes**: the narrow places of the 15 mask on the landing routes. Never
     one alone.
2. **The approach.**
   - Sonar, so that every deep landing route is watched by two: seabed sonar
     (10+ deep), advanced sonar (24+), and the floating radar's 900 sonar.
   - Depth-charge launchers along the shore where deep water comes close.
3. **The surf.** Floating dragon's teeth in the shallows (1+ deep), angled to
   funnel hovers and ships into the kill zone.
   - They leave the lanes of our own ships and hover constructors open (the
     harbour's routes, D-121).
   - Whether they also block amphibious units walking beneath them is
     unverified: to be tested.
4. **The beach.** A kill zone (section 4) whose direct-fire turrets cover the
   whole **emergence band** from behind the shore.
   - Pop-ups, and high-alpha turrets (Pulsar, Bulwark, Bastion) where T3
     walkers are expected.
   - Artillery on the high ground behind.
   - Dragon's teeth and fortification walls at the land exits. They stop T2
     units but not the T3 walkers, which crush them.

### Which beach first

`need = landing-route heat × enemy naval, hover and amphibious strength ×
value behind the beach / distance to our base`.
- Enemy strength needs a native composition binding. Enemy ships have no role
  of their own today (only submarines are tagged `sub`); the unit's movement
  type (ship, submarine, hover, amphibious) tells them apart.
- When T3 amphibious walkers are seen or building, the deep-water beaches on
  their routes go first: torpedoes and depth charges before the land line.
- A beach with no hostile water body and no landing route gets nothing.
- On maps with no water in reach the coastal code never runs, so land maps are
  unchanged.

### Redundancy (W7) on the coast

| Rule | Invariant |
| --- | --- |
| Every landing zone with heat has two weapon classes: surface guns, plus underwater weapons where the water is deep | INV-055 |
| Every deep landing route is watched by two sonars | INV-056 |
| No landing zone depends on one torpedo launcher | part of INV-055 |

### Found in passing (not TECH's code; noted for later)

- The native water defence chains (`build_chain.json`) list land-only
  defences (armhlt, armflak, armpb), which cannot be built on water.
- `CTerrainManager::GetImmobileTypeId` returns the mobile type's id
  (TerrainManager.h:530-531).

## 8. How it fits TECH

- New `roles/tech_weapons.as` (namespace `TechWeapons`), called from new rule
  rows above `air.defend`. The D-123 ring becomes the lowest fallback of the
  cluster builder, not a separate ring.
- Other roles never call it: the native bindings are queries only, and the
  rows exist only in TECH's table (`Global::AISettings::Role`).
- Idle air constructors (D-123, INV-053) get a large, lasting source of work:
  a cluster's wall ring and nano block.
- Clusters are cleared on a role switch (`Layout::OnRoleLeave`).

## 9. Build order (phases)

1. **Analysis layer** (native): the grid, avenues, chokes, friendly lanes,
   `EffectiveRange`, `LineOfFire`, point queries on threat and influence,
   composition and heatmaps. A widget draws each layer for screenshots.
   Played on Supreme Isthmus, All That Glitters, Glacial Gap and Tundra.
   `build_area.lua` gains a torpedo-launcher test column and the beach
   classes, drawn for screenshots.
2. **Long-range and super-cannon clusters** first: they are the clearest win
   (height is worth 800+ elmos to an LRPC) and replace KI-418.
3. **Air-defence clusters**, replacing the D-123 ring and `DefendMexes`.
4. **Kill zones with walls and funnels**, the largest piece.
5. **Artillery clusters.**
6. **Coasts and beaches** (section 7): the depth grid, beach classes, the
   torpedo rule (INV-054), the landing-zone layers.
7. **Redundancy invariants**, each with an actor-matrix row.

Each phase ships as its own decision, with invariants, docs and a played run.

## Open questions for the owner

1. The weapon budget: 25% of income from the +200 gate, up to 40% under
   attack?
2. Start with phase 1 and 2 (analysis and long-range clusters)?
