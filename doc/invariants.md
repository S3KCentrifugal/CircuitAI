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
| `ChainEnergyFloatSeconds` / `ChainEnergyFloatMax` / `InvariantFloatOrderSeconds` | 15 / 300 / 45 | D-079: the energy bank at `EcoConvertEnergyPercent` of storage this long, or at it now with income over the pull by this = energy floats; INV-009 after the longer wait, so the order was made while floating |
| `PowerAheadSeconds` / `PowerAheadRise` | 15 / 30 | D-075: the metal bank full this long, or risen by this over the window = metal income above spending |
| `InvariantReclaimJoinSeconds` / `ReclaimTurretMargin` | 10 / 48 | INV-008's patience and the turret reach margin |
