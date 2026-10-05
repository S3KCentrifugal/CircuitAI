# TECH test definitions

Generated source inventory. Execution is not inferred.

## Combat / Checks

### [t2_ground_start](../../../tools/playtest/checks/tech/combat/t2_ground_start.json)

- `expect: fast bot completed`
- `expect: observer`
- `forbid: invariant`
- `forbid: script error`
- `forbid: wrong T2 bot`

### [t2_landlocked_start](../../../tools/playtest/checks/tech/combat/t2_landlocked_start.json)

- `expect: amphibious bot completed`
- `expect: observer`
- `forbid: invariant`
- `forbid: script error`
- `forbid: wrong T2 bot`

### [tech_flank](../../../tools/playtest/checks/tech/combat/tech_flank.json)

- `expect: built team 0`
- `expect: built team 1`
- `expect: continuous team 0`
- `expect: continuous team 1`
- `expect: mountain team 0`
- `expect: mountain team 1`
- `expect: normal production team 0`
- `expect: normal production team 1`
- `expect: sustained team 0`
- `expect: sustained team 1`
- `forbid: crash`
- `forbid: invariant`
- `forbid: script`

### [tech_flank_traversal](../../../tools/playtest/checks/tech/combat/tech_flank_traversal.json)

- `expect: east crossing`
- `expect: east factory`
- `expect: east mountain`
- `expect: east production`
- `expect: west crossing`
- `expect: west factory`
- `expect: west mountain`
- `expect: west production`
- `forbid: crash`
- `forbid: invariant`
- `forbid: script`

## Economy / Checks

### [rush_afus](../../../tools/playtest/checks/tech/economy/rush_afus.json)

- `expect: chain`
- `expect: milestone`
- `forbid: combat early`
- `forbid: invariant`
- `forbid: script error`

### [rush_fusion](../../../tools/playtest/checks/tech/economy/rush_fusion.json)

- `expect: chain`
- `expect: milestone`
- `forbid: combat early`
- `forbid: invariant`
- `forbid: script error`

### [rush_gantry](../../../tools/playtest/checks/tech/economy/rush_gantry.json)

- `expect: chain`
- `expect: milestone`
- `forbid: combat early`
- `forbid: invariant`
- `forbid: script error`

### [rush_nuke](../../../tools/playtest/checks/tech/economy/rush_nuke.json)

- `expect: chain`
- `expect: milestone`
- `forbid: combat early`
- `forbid: invariant`
- `forbid: script error`

### [rush_t2](../../../tools/playtest/checks/tech/economy/rush_t2.json)

- `expect: chain`
- `expect: milestone`
- `forbid: combat early`
- `forbid: invariant`
- `forbid: script error`

### [rush_titan](../../../tools/playtest/checks/tech/economy/rush_titan.json)

- `expect: chain`
- `expect: milestone`
- `forbid: combat early`
- `forbid: invariant`
- `forbid: script error`

### [tech_control](../../../tools/playtest/checks/tech/economy/tech_control.json)

- `expect: opening`
- `expect: tech`
- `forbid: crash`
- `forbid: invariant`
- `forbid: script`

### [tech_opening](../../../tools/playtest/checks/tech/economy/tech_opening.json)

- `expect: advanced lab`
- `expect: energy`
- `expect: exp on`
- `expect: first lab`
- `expect: opening mex`
- `expect: turret`
- `forbid: combat early`
- `forbid: default task`
- `forbid: invariant`
- `forbid: lab.t1 after t2`
- `forbid: mobile packed`
- `forbid: script error`

## Fixtures / Fixture/Observer

### [tech_t2_start_watch](../../../tools/playtest/widgets/tech_t2_start_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.
