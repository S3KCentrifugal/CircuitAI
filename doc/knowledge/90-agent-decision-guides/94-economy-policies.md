---
layer: 90
confidence: synthesis
sources:
  - 50-economy/52-scaling-curves.md, 51-build-power.md, 53-expansion-and-territory.md
  - 20-game-mechanics/21-resources.md
  - 80-theory/83-logistics-as-economy.md
  - data/script/src/helpers/economy_helpers.as (EconomyHelpers::Should*)
  - data/script/src/roles/tech.as, doc/roles/tech.md
  - doc/t2-constructor-stall.md
---

# Economy policies

When to expand, add energy, add build power, bank, tech, convert. Each policy
gives the rule, the arithmetic behind it, and how it compares with what BARb
does today.

## P1 - Expansion: claim every spot you can hold

- **Rule**: while any unclaimed spot within reach has expected survival >
  30 s, a constructor is going to it. Order by (spot value / travel time).
- **Arithmetic**: mex payback 25 s ([52](../../../../rjm.bar.docs/knowledge/50-economy/52-scaling-curves.md)).
- **BARb**: native `MEX` tasks at high priority; `IsIgnoreStallingPull`
  whitelists MEX so expansion continues during stalls - correct. Ordering is
  by `distCost / (priority+1)^2`, i.e. nearest first; value-per-second
  ordering is a refinement.

## P2 - Energy: hold a margin above spend

- **Rule**: target energy income >= 1.2 x energy spend (production + weapons +
  cloak + upkeep) and energy storage >= 20 s of spend. Build the best E per
  metal available for the map (wind if average wind >= 10, else solar; geo
  when a vent is safe; fusion at T2).
- **Arithmetic**: [21](../../../../rjm.bar.docs/knowledge/20-game-mechanics/21-resources.md) E-per-metal
  table; T2 units at 12-24 E per M.
- **BARb**: `Economy::AiUpdateEconomy` sets `isEnergyStalling` from a
  threshold; energy builds at `Priority::HIGH`; Tech role redirects energy
  builders to an in-progress reactor (session change). The margin is
  reactive (stalling flag), not predictive (spend forecast).

## P3 - Build power: keep the BP : income ratio in band

- **Rule**: BP / metal income between 1.0 and 1.5 at T1, 2.0 and 3.0 at T2+.
  Below band: add nanos at the factory (cheapest BP per metal); above band:
  stop building constructors, start banking or add production.
- **Arithmetic**: [51](../../../../rjm.bar.docs/knowledge/50-economy/51-build-power.md); [83](../../../../rjm.bar.docs/knowledge/80-theory/83-logistics-as-economy.md).
- **BARb**: `CheckMobileAssistRequired` compares `buildtime / workertime`
  per factory; constructor count from factory weights. No global ratio.

## P4 - Stall handling: stop the least valuable job

- **Rule**: when `isMetalStalling` or `isEnergyStalling`, suspend jobs in
  order: converters (if metal stall), non-essential statics, second factory
  production, then T2 lab construction - never mex, never energy during an
  energy stall, never repair.
- **Arithmetic**: stalls slow every job by the same factor
  ([15](../../../../rjm.bar.docs/knowledge/10-engine/15-construction-economy-rules.md)); removing one job
  speeds all others.
- **BARb**: native `isNotReady` gate refuses new tasks except NOW-priority and
  `IsIgnoreStallingPull` types (MEX, PYLON, ENERGY-when-energy-stalling).
  `MEXUP` is not whitelisted, which stalls T2 constructors
  ([t2-constructor-stall.md](../../t2-constructor-stall.md)). The gate is
  all-or-nothing; job-by-value suspension does not exist.

## P5 - Banking: save for gates, not by accident

- **Rule**: before a gate purchase (T2 lab, fusion, gantry, nuke), set a
  bank target = 60% of the gate's metal and energy; stop non-essential builds
  until reached; then start the gate with all available BP.
- **Arithmetic**: a 2600-M lab at 720 BP takes 35 s; starting it with 500 M
  banked and 15 M/s income takes 140 s and stalls everything else.
- **BARb**: Tech role gates the T2 lab on metal income threshold, not on
  bank; storage fill is `isMetalFull` (used to allow spending, not to plan
  saving).

## P6 - Tech: income gate + BP gate + safety gate

- **Rule**: T2 when income >= 15 M/s **and** >= 3 constructors free **and**
  no enemy army bigger than ours within 60 s of the base **and** (bank per
  P5). Immediately if enemy T2 is seen and we have >= 12 M/s.
- **Arithmetic**: [71](../../../../rjm.bar.docs/knowledge/70-strategy/71-timing-and-tech.md), [52](../../../../rjm.bar.docs/knowledge/50-economy/52-scaling-curves.md).
- **BARb**: income threshold only (`MetalIncomeThresholdForEarlyBotLabExpansion`);
  the 18-M/s rush symptom was the income gate without the BP and safety
  gates.

## P7 - T3 and gantry: energy first

- **Rule**: gantry only when energy income >= 6000 E/s with a second
  fusion-class plant complete; first T3 unit only when energy storage >=
  10 000.
- **BARb**: `EnergyIncomePerGantry = 6000` gate exists; the reactor-assist
  redirect helps reach it. Gantry idle when energy is short is by design; the
  fix is P2's margin, not the gate.

## P8 - Converters: only on surplus

- **Rule**: build converters when energy storage is > 80% full for 30 s and
  metal storage < 50%; sell them (reclaim, 100% refund) when energy stalls.
- **Arithmetic**: 70 E per M; a converter is worth its 1 M only when the
  energy would be wasted.
- **BARb**: converters in build chains by config; on/off via `onoff`
  attribute; no surplus trigger.

## P9 - Reclaim: every wreck field is income

- **Rule**: after any fight in own-controlled sectors, a constructor is
  assigned to the wreck field within 30 s; priority proportional to field
  metal / distance.
- **Arithmetic**: 100% return, wrecks always visible
  ([15](../../../../rjm.bar.docs/knowledge/10-engine/15-construction-economy-rules.md)).
- **BARb**: reclaim tasks exist in `CBuilderManager`; priority relative to
  MEX/energy is the question.

## P10 - Repair before replace

- **Rule**: damaged units in own sectors are repaired before new units of
  the same role are queued.
- **Arithmetic**: repair costs no resources.
- **BARb**: repair tasks exist; `no_repair` attribute opts out. Production
  does not consider repairable inventory.

## P11 - Territory decay

- **Rule**: expansion aggression (P1 reach) decays after converters exceed
  30% of metal income; raid targeting shifts from mexes to reactors and
  converters.
- **Arithmetic**: [53](../../../../rjm.bar.docs/knowledge/50-economy/53-expansion-and-territory.md).
- **BARb**: no phase model; bomber targeting by lowest health
  ([bomber-targeting.md](../../bomber-targeting.md)).

## Where the policies disagree with `EconomyHelpers::Should*`

The helper functions in `data/script/src/helpers/economy_helpers.as` encode
absolute thresholds (metal income, energy income, storage fractions) tuned for
default options. The policies above differ in three ways: they add BP and
safety gates to the tech decision (P6), they plan banking (P5), and they
scale with map spot value and option multipliers rather than absolute income.
Recording the current constants beside each policy is a task in
[95-open-questions.md](95-open-questions.md).

## Related

- [roles/tech.md](../../roles/tech.md), [52-scaling-curves.md](../../../../rjm.bar.docs/knowledge/50-economy/52-scaling-curves.md), [90-decision-architecture.md](90-decision-architecture.md).
