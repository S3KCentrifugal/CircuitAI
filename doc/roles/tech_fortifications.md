# TECH fortification controller

D-152 implements the [protected expansion design](../air-tech-expansion-plan.md).
`Piece` holds an exact persistent building reservation and a live task. `Site`
groups pieces around a lane or an owned asset. `Advanced` checks actual
advanced construction capability, cached once per planning tick; `Asset` identifies completed geos and
advanced mexes. `Add` adopts or reserves a coordinate/role keyed slot; `Find`
prevents duplicate site plans. `Lane` leaves a wide traffic gap between two
wall lines with guns behind them. `Protect` adds resource perimeter segments
with access gaps, ground defense and AA (floating teeth and a floating gun for
water). `Protect` searches wider perimeters when existing reservations block the
first radius, and retries empty plans after sixty seconds. Impossible slots and
friendly lanes leave deliberate gaps; this is not a guarantee of a closed wall.
`Tick` budgets five percent of metal income, discovers assets after T2
and releases unused plans for lost assets. `Work` checks affordability, native
reach, observed threat and lane clearance before pinning an order. Resource
perimeters are selected before base lane lines; idle TECH air builders use this
same finite plan. T1 lane work waits for static build power; T2 access can start
resource protection immediately.

Settings: `weapons/fortification/share`, `work_radius`, `concurrent`. TECH only.
No claimed protection against bombers: walls obstruct ground movement/fire.

Verification is tracked by D-152 in the decision record.

<!-- source: data/script/src/roles/tech_fortifications.as; blob: 5a572394a2ccd5071f42f92876ba8ac87857e975; lines: 200 -->

`Reset` clears script caches at TECH initialization; saved native coordinate keys are adopted by `Add`.
