# Invariants

The promises the TECH role makes, checked once a second in the game by
`Invariants::Tick` and the unit hooks in
[`invariants.as`](../data/script/src/manager/invariants.as), logged as
`[INVARIANT] INV-nnn ...` when broken, and forbidden by every playtest check
file. The practice is [`practice-invariants.md`](practice-invariants.md);
`tools/knowledge/check_invariants.py` keeps this table and the scripts in
step.

| Id | Invariant | Checked | Decision |
| --- | --- | --- | --- |
| INV-001 | A retiring factory produces nothing. | `Invariants::OnUnitAdded` from the role's unit-added hooks: a mobile unit appearing within `InvariantFactoryRadius` of a factory retired less than `LifecycleMemorySeconds` ago. | [D-076](decisions.md#d-076--one-lifecycle-state-per-structure-invariants-checked-in-every-game-the-actor-matrix) |
| INV-002 | A frame of ours under construction has build power on it within `InvariantFrameSeconds`. | `Invariants::Tick`: the nearest unfinished structure to the base with no build power within `InvariantFrameRadius` for that long. | D-076 (from KI-413) |
| INV-003 | The chain never skips a step whose frame is under construction. | `Invariants::ChainStepSkipped` at the chain's stall-guard skip. | D-076 (from KI-413) |
| INV-005 | Only the throwaway T1 lab is ever retired. | `TechBuild::Tick`: a retiring T1 lab whose id is not `throwawayLabId`. | D-076 (played) |
| INV-006 | No wind, solar or advanced solar stands `InvariantReclaimSeconds` after an advanced fusion does. | `Invariants::Tick`: counts of the three defs while an advanced fusion stands. | [D-077](decisions.md#d-077--turrets-grow-outward-from-the-layouts-centre-t1-energy-is-reclaimed-once-fusion-tier-income-carries-the-base) |
| INV-007 | An advanced lab never stays active while an advanced fusion is under construction and the bank has room for its metal. | `TechBuild::Tick`: the condition holding `InvariantT2ReclaimSeconds` with the lab not retiring. | [D-078](decisions.md#d-078--the-advanced-lab-is-reclaimed-while-the-advanced-fusion-is-built-every-turret-in-range-joins-any-reclaim-at-once) |
| INV-008 | Every construction turret in range of a reclaim of ours is on it. | `Invariants::Tick`: native `TurretsOnReclaim(id, margin, false)` above zero for `InvariantReclaimJoinSeconds` on a remembered reclaim target. | D-078 |
| INV-009 | No energy structure is ordered while energy floats. | `Invariants::Tick`: an energy def's unfinished count rising while `TechChain::EnergyFloats` holds. | [D-079](decisions.md#d-079--no-energy-structure-while-energy-floats-the-surplus-is-converted-and-the-ai-chases-metal) |
| INV-010 | No mobile combat unit of ours appears while metal income is under the plan's gate. | `Invariants::OnUnitAdded`: a mobile non-builder added with the 10-second metal income under `TechPlan::CombatGate`. | [D-080](decisions.md#d-080--the-endgame-plans-the-metal-ladder-after-the-objective-and-the-income-gates-for-combat) |
| INV-011 | Past the objective the metal bank does not float while an income step of the plan is unmet. | `Invariants::Tick`: the bank at `InvariantFloatPercent` for `InvariantLadderFloatSeconds` while `TechChain::LadderUnmet`. | D-080 (from KI-415) |
| INV-012 | The main turret cluster has at least `LayoutBoxMinRows` rows. | `Layout::PlanBox` at the plan. | [D-081](decisions.md#d-081--the-turret-cluster-is-a-block-of-four-touching-rows-filled-across-with-a-forward-cluster-planned-in-clear-space) |
| INV-013 | A main cluster has a forward cluster planned within `InvariantForwardSeconds`, unless every re-plan was used up. | `Invariants::Tick`: `Layout::ForwardPlanned` false that long with `ForwardGivenUp` false. | D-081 |
| INV-014 | Every economy structure the layout places stands within `InvariantReachElmos` of a turret slot; none is ordered outside the layout. | `Layout::Place` at the pack (`CountGroupSlotsWithin`); the chain's fallback order. | [D-082](decisions.md#d-082--the-turret-block-is-placed-for-the-ground-around-it-a-halo-of-packing-space-on-both-sides-and-behind-scored-with-the-block) |
| INV-015 | A dear chain order does not wait more than `InvariantDearOrderSeconds` for its first builder. | `Invariants::Tick`: `TechChain::DearOrderPendingSeconds`. | [D-084](decisions.md#d-084--a-dear-chain-order-outranks-the-float-converter-and-power-turret-rows-until-its-frame-exists) |
| INV-016 | The advanced lab, once it has stood `InvariantLabReachSeconds`, has a turret or a planned turret slot within `ExpLabBuildPowerReach` (D-099: placement, not timing; D-098 lets the lab come first). | `Invariants::Tick`: `CountGroupSlotsWithin` and `GetStaticBuildPowerNear` at the primary T2 lab. | [D-085](decisions.md#d-085--the-advanced-lab-stands-where-the-turrets-are-or-will-be-first-served-slots-weigh-three-ties-go-to-the-blocks-seed) |
| INV-017 | 90 s after the advanced lab stands, the nearest construction turret is within `LayoutLabFlushElmos` of it. | `Invariants::Tick`: `FindOwnNear` from the primary T2 lab; the distance is logged on change. | [D-088](decisions.md#d-088--same-def-structures-fill-a-rectangle-the-block-and-its-turrets-grow-from-the-advanced-lab-the-lab-may-face-any-way), [D-095](decisions.md#d-095--the-advanced-labs-site-is-flush-with-a-turret-slot-before-it-is-near-the-home-centre) |
| INV-018 | 90 s after the advanced lab stands, it faces the facing it was ordered with (`Layout::LabPlannedFacing()`, the front then: the lane, D-098), never away from the current front, and no structure of ours (extractors aside, D-099) stands in its exit lane. | `Invariants::Tick`: `GetBuildingFacing` and `CountStructuresInExit` on the primary T2 lab; logged on change. | [D-096](decisions.md#d-096--labs-face-the-nearest-enemy-from-the-front-side-of-the-block-and-nothing-is-packed-into-a-factorys-exit), [D-098](decisions.md#d-098--the-front-is-the-lane-the-pair-faces-a-dear-frame-takes-a-build-power-slot-and-a-turret-going-up-is-finished-first) |
| INV-019 | No more construction-turret frames stand unfinished than `Layout::TurretSlots()` for `InvariantTurretFlightSeconds`. | `Invariants::Tick`: `GetUnfinishedCount` of the turret def against the slots (D-098). | [D-097](decisions.md#d-097--construction-turrets-go-up-one-at-a-time-until-the-metal-and-the-nearby-build-power-pay-for-more) |
| INV-020 | The layout does not refuse an economy structure for lack of room for `InvariantNoRoomSeconds`. | `Layout::Place`: the frame room was first missing, reset when a structure is packed. | [D-099](decisions.md#d-099--structures-fill-the-ground-within-reach-of-a-clusters-turrets-then-the-next-cluster-no-reservation-in-a-factorys-exit) |
| INV-004 | Metal does not float while a structure is under construction and static build power is under the income target. | `Invariants::Tick`: the bank at `InvariantFloatPercent` of storage for `InvariantFloatSeconds` with a frame standing and static build power under `PowerBuildPowerPerMetal` x metal income. | D-076 (from D-075) |

## Settings (`Global::RoleSettings::Tech`)

| Setting | Default | Meaning |
| --- | --- | --- |
| `LifecycleMemorySeconds` | 120 | a retired factory's position is remembered this long after it is gone |
| `InvariantFactoryRadius` | 200 | INV-001's radius around a retiring factory |
| `InvariantFrameRadius` / `InvariantFrameSeconds` | 320 / 60 | INV-002's build-power radius and patience |
| `InvariantFloatPercent` / `InvariantFloatSeconds` | 0.9 / 60 | INV-004's bank share and patience |
| `InvariantReclaimSeconds` | 240 | INV-006's patience after the advanced fusion |
| `InvariantT2ReclaimSeconds` | 15 | INV-007's patience |
| `InvariantLadderFloatSeconds` | 60 | INV-011's patience |
| `InvariantDearOrderSeconds` | 45 | INV-015's patience |
| `InvariantLabReachSeconds` | 90 | INV-016's, INV-017's and INV-018's patience |
| `InvariantTurretFlightSeconds` | 30 | INV-019's patience |
| `InvariantNoRoomSeconds` | 120 | INV-020's patience |
| `PowerTurretBatchSeconds` / `PowerTurretsMax` / `PowerTurretBuildTime` | 20 / 8 / 5300 | D-097's calculation: turrets the nearby build power finishes in this time, the ceiling, the turret's buildtime |
| `LayoutLabFrontGapCells` | 3 | D-096: how far ahead of turret row 0 the front-line lab site may stand |
| `LayoutFrontMinCost` | 1500 | the metal cost at which a seen enemy group becomes the front (D-096) |
| `InvariantForwardSeconds` / `LayoutBoxMinRows` | 120 / 3 | INV-013's patience; INV-012's row floor |
| `InvariantReachElmos` / `LayoutHaloCells` | 450 / 18 | INV-014's reach; the halo of packing ground around the block |
| `ChainEnergyFloatSeconds` / `ChainEnergyFloatMax` / `InvariantFloatOrderSeconds` | 15 / 300 / 90 | D-079: the energy bank at `EcoConvertEnergyPercent` of storage this long, or at it now with income over the pull by this = energy floats; INV-009 after the longer wait, so the order was made while floating |
| `PowerAheadSeconds` / `PowerAheadRise` | 15 / 30 | D-075: the metal bank full this long, or risen by this over the window = metal income above spending |
| `InvariantReclaimJoinSeconds` / `ReclaimTurretMargin` | 10 / 48 | INV-008's patience and the turret reach margin |
