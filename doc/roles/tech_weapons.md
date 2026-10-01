# `roles/tech_weapons.as` — TECH's weapon clusters (D-126)

The design and the owner's requirements (W1 to W9) are in
[`tech-weapon-clusters.md`](tech-weapon-clusters.md); this page describes what
is built. The lanes it shares its analysis with are in
[`tech-lanes.md`](tech-lanes.md) (D-127).

## Who runs it

Only TECH, and only under the experimental build system
(`TechWeapons::Enabled`: `WeaponClustersEnabled` and `ExperimentalBuild`).
Nothing is ordered before **+200 metal income** (`WeaponStartMetalIncome`,
owner); every kind of cluster also waits for its own income gate. The analysis
it uses (`aiBattle`, [`BattleAnalysis.cpp`](../../src/circuit/terrain/BattleAnalysis.cpp))
answers queries only, so other roles are unchanged; another role may call
`TechWeapons::Tick` and `Work` later.

## Settings

D-142: never build T1 artillery. Every artillery slot uses `art2`, including
kill-zone and coast support, and waits for `WeaponArtyMinIncome` (default +300).
The former `art1` roster slot stays empty to preserve role-array alignment.
Actual T2 artillery is Armada `armamb`, Cortex `cortoast`, Legion `legacluster`.
LRPCs retain their +350 gate; super cannons retain the +500/+1000 gates and
energy affordability checks. These are eligibility gates, not a mandatory
build sequence. A separate construction veto applies across all roles/profiles.

All profiles include `ArtilleryPolicy`: a Ragnarok, Calamity or Starfall's first
confirmed shot queues a lowercase `lol` drawing at its target through the
same paced map-line queue used for nuclear smileys. Each cannon draws once
per AI session, not once per salvo. `weapons/celebration/enabled` (true) and
`letter_height` (220 elmos, clamped) control it. Destroyed IDs are forgotten.

Every setting is a `Global::RoleSettings::Tech` default
([`global.as`](../../data/script/src/global.as), block "WEAPON CLUSTERS") that
[`data/config/weapons.json`](../../data/config/weapons.json) overrides at game
start (`LoadSettings`, one line per JSON key; a profile folder may carry its
own `weapons.json`). The JSON is read through `aiSetupMgr.ConfigFloat/Int/Bool`
(the config's `weapons` and `lanes` sections outlive the engine's config close).

| JSON | Setting | Default | What |
| --- | --- | ---: | --- |
| `start_metal_income` | `WeaponStartMetalIncome` | 200 | owner: no weapon cluster below this |
| `budget/share` | `WeaponBudgetShare` | 0.25 | share of metal income spent on clusters |
| `budget/share_attacked` | `WeaponBudgetShareAttacked` | 0.40 | while the base area is fought over (`attacked_heat` within `base_radius`) |
| `budget/window_seconds` | `WeaponBudgetWindowSeconds` | 60 | the budget saves up at most this many seconds |
| `budget/max_concurrent` | `WeaponMaxConcurrent` | 4 | orders out at once (the super cannon's escort apart) |
| `gates/*` | `Weapon*MinIncome` | 200 / 200 / 250 / 300 / 350 | kill zone, air defence, coast, artillery, long range |
| `max/*` | `WeaponMax*` | 4 / 4 / 4 / 3 / 3 / 1 | clusters of each kind (super 1) |
| `cluster/nanos` | `WeaponNanoPerCluster` | 4 | owner: at least 4 construction turrets |
| `super/*` | `Super*` | +500 / +1000, 6 flak, 2 LR AA, 2 deflectors, 1 anti-nuke, 8 turrets, 2 radars, storage x1.1 | the owner's super-cannon rules (W9) |
| `long_range/band_*`, `super/band_*` | | 0.2 to 0.4 | of the gun's range back from the active combat zone |
| `analysis/*` | | | replan 60 s, analyse 600 s, 3 route alternatives, chokes, heat half-lives, coast radius |

## Each second (`Tick`)

1. `LoadSettings` once.
2. Under +200: log once and stop.
3. The budget grows by share x income (`attacked`: the larger share).
4. `Analyse` at the start and every `WeaponAnalyseSeconds`:
   - approach routes from the enemy's starts (`Lanes::EnemyStarts`: the start
     script's playing teams, else the enemy's start boxes);
   - chokes;
   - hostile water near those starts;
   - beach segments.
5. `Replan` every `WeaponReplanSeconds`: `Discover` finds the strategic
   defence points again and every cluster is re-ranked by
   `Need(kind) x site score` (below). A point found again keeps its cluster; a
   point no longer found marks it stale (no new orders). A better point
   replaces the weakest cluster of its kind when nothing of it stands.
6. Slots standing are recorded; a slot whose structure died is rebuilt.
   `Upkeep` (each replan) handles clusters whose slots find no site:
   - a started cluster whose construction-turret slots found no site gets new
     ones on another side;
   - a cluster with nothing built and no slot left moves its anchor 250 back
     and is laid again, at most 3 times.
   The replan log counts slots with no site.
7. `SuperTick`: the super cannon's air build power.
8. `Checks`: the invariants.

## Where each kind goes (`Discover`)

| Kind | Points | Site score |
| --- | --- | --- |
| kill zone | chokes on the approach routes between `WeaponKillShareMin` and `Max` of the way out | route heat x (1 + combat heat) / enemy threat there |
| air defence | the base, the factory centre, mex clusters of 2+, front factory clusters | 2 for the base, x (1 + air heat); faces the heat-weighted air approach (`aiBattle.AirCentre`), else the front |
| artillery | high ground behind each kill-zone choke, in reach of it | height above the surroundings x effective range to the choke (engine formula) / threat |
| long range | 20% to 40% of an LRPC's range back from the active combat zone | effective range past the fighting x height; never in enemy threat; 1280 from another critical structure |
| super cannon | the same band with the super cannon's range | as long range |
| coast | beach segments with hostile ship or deep water, a hover beach, or a wading shelf on a landing route | landing routes x 1.5 for deep water / distance to base |

The active combat zone is the nearest cell of the decaying combat heat (our
losses and damage, enemy losses) above `WeaponCombatMinHeat`, else
`Layout::FrontTarget`.

## The shape of each kind (`Shape`)

Slots are laid when a cluster is found, facing its threat:

- **Kill zone.** An arc of LLTs, a beamer, HLTs and a pop-up behind the choke
  (from T2 income two T2 pop-ups; a heavy turret once enemy heavies are seen).
  Every direct-fire turret gets a staggered double row of dragon's teeth 2 to 3
  segments in front of it. Smart artillery 700 behind, walled in. Heavy AA,
  a radar, 4 construction turrets.
- **Air defence.** From T2 income, 3 flak on the approach 420 out, each walled;
  before it, 2 light AA. Heavy AA; long-range AA once enemy air passes 3000
  metal or at T2. Pieces `WeaponAirSpacing` (260) apart.
- **Artillery.** Two T2 artillery pieces from `WeaponArtyMinIncome`, heavy
  AA, radar, a wall ring of 300, 4 construction turrets.
- **Long range.** The LRPC, 2 flak toward the air approach, a radar, a wall
  ring of 360, 4 construction turrets.
- **Super cannon** (W9, `ShapeSuper`). The cannon; 1 anti-nuke (2 once an
  enemy silo is seen); 2 deflectors; a forward arc of 6 flak 380 to 500 out;
  2 long-range AA; advanced energy storage for a full shot
  (`SuperStorages`: `max(2, ceil((shot x 1.1 - storage now) / 40000))`, a
  Starfall salvo being 360,000); 2 radars; 8 construction turrets; a wall ring.
- **Coast** (W8, `ShapeCoast`). On the beach: 2 HLTs, an LLT, a T2 pop-up, a
  heavy turret against heavies, dragon's teeth at the land exit, heavy AA, a
  radar, 4 turrets. Ship or deep water: a floating HLT, artillery behind, 2
  floating teeth in the shallows. Deep water: 2 torpedo launchers where
  `TorpedoSiteOK` passes, 2 depth-charge launchers on the shore, 2 sonars.

## Work for a builder (`Work`, rows `weapons.cluster` and `air.defend`)

The highest-priority cluster over its income gate and not stale, its first
open slot the builder can build:
- land constructors within `WeaponWorkRadius` (8000: the kill zones stand 5000 to 6000 out); air constructors anywhere;
- at most `WeaponMaxConcurrent` orders out: an order in the last 30 s, or a
  frame going up; twice that with the metal bank full, when the budget is also
  lifted (the economy has nothing else to spend it on);
- the slot's cost within the budget (the super cannon's escort is not
  budgeted: owner, "take defence very seriously");
- the site passes `Site`:
  - never on a friendly lane;
  - the torpedo rule for torpedoes and depth charges;
  - the engine's footprint test, trying up to 16 points within 96 of the slot.
  A slot with no site is dropped.

`Order` enqueues a build task (`TechForward::Buildable` lifts TECH's
start caps one at a time) and logs `[TECH][Weapons] <kind> #<id>: ... orders`.

`air.defend` (D-123) asks `Work` before its old defence ring.

## The super cannon (`SuperTask`, `SuperTick`, row `weapons.super`)

- **Startable** (`SuperStartable`): metal income at least +500, and at
  `SuperIdealMetalIncome` (+1000) or a need of at least `SuperMinNeed`. Energy
  income must also cover its sustained draw (shot / reload).
- **Framing.** Any air constructor frames it at the cluster's site.
- **Air build power.** From the frame on, every air constructor assists it:
  - `SuperTick` aborts every other air-constructor task every 5 s;
  - the row `weapons.super`, above `keep.current`, hands them the repair.
- **The escort** is built by land constructors and turrets through `Work`.

## Invariants

| Id | Checked |
| --- | --- |
| INV-054 | no torpedo or depth-charge launcher of ours stands where submarines cannot come |
| INV-057 | while the super cannon is framed (after 20 s), every air constructor is on it |
| INV-058 | the super cannon's escort is framed or standing `SuperEscortSeconds` after the frame |
| INV-059 | no super cannon framed under +500 metal |
| INV-060 | a cluster with 3 weapons standing keeps 4 construction turrets after 10 minutes |
| INV-061 | no weapon-cluster order under +200 metal |

## Log lines

- `[TECH][Weapons] analysis: ...`
- `new <kind> cluster #n at (x, z): <why>, <slots>, priority`
- `replan: ... ranked: ...`
- `<kind> #n: <builder> orders <def> (<role>) at (x, z)`
- `budget: ...`
- `super cannon framed ...`

<!-- source: data/script/src/roles/tech_weapons.as; blob: ecf5cc47ea01842876a810d6ec17d629dbf4d1a0; lines: 1108 -->

## D-152 protected weapon placement

`SortSlots` puts walls first. `Site` keeps wall coordinates exact; `Order`
reserves and pins the chosen site, aborting if the claim fails. Every candidate
therefore respects future factory/turret/corridor reservations. The existing
weapon budget, income gates and unit choices remain.

D-154: `Site` and `Order` also apply shared `WallHelpers::Allowed` to wall
footprints before and after snapping. Walls inside the 1,200-elmo default
allied-start exclusion are omitted; other weapons keep their existing placement
rules. See [wall base exclusion](../wall-base-exclusion.md).
