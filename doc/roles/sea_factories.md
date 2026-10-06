# SEA production and harbor handover

`SeaFactories::Produce` owns production only while SEA's experimental layout
is enabled. `Recruit` verifies faction build options and availability. Each tier
has a two-constructor opening/recovery guarantee; discretionary additional
workers require a resource-funding decision. With `AdaptiveFleet=true`,
the D-201 emergency counter check may interrupt after the first constructor;
the second constructor resumes when that immediate deficit is covered.
`SeaCombat::Select` replaces fixed combat quotas with observed aircraft/submarine
coverage deficits, a small standing AA/underwater screen, then surface or siege
production. Candidates must be buildable and have a weapon for that layer
(INV-131); pending recruits count. Selection uses coverage delivered per build
second and discounts an oversized response to a small deficit. These are
heuristics to test, not calibrated combat power or guaranteed optimal counters.

Urgent counters follow the first recovery constructor and precede discretionary
workers. D-211 removes the deliberate T1 tech-saving pause and keeps SEA
T1 factories active after T2. Recovery submarines scale with fleet value and
income, with one pending hull at a time and a two-resource funding check.
T2 jammer/anti-nuke escorts remain capped to one. `AdaptiveFleet=false` retains
the previous dynamic T1 and fixed T2 mixes. See the
[combat plan](../sea-combat-enhancement-plan.md).

`CombatHull` uses combat-role masks, not profile threat weights (naval weights
can deliberately be zero). `Safe` requires nearby completed naval fighting value and low observed local
surface/water and air threat. It does not infer safety from global army cost.
`Tick` considers one forward replacement at a time, requires sustained local
cover and useful travel reduction, and admits a funded replacement berth.
`Hold` suppresses recruits only while a yard drains or retires.

The original yard continues until its same-capability replacement is complete,
a real product has physically moved beyond its exit corridor, the site remains
safe, the original yard's current product is finished, and metal storage can
accept the reclaim. Only then does `Lifecycle::Retire` hand it to construction
reclaim. A lost old yard does not destroy the replacement; an unsafe unstarted
replacement is cancelled and its builders' orders cleared. Retired berth
reservations are released after the old structure disappears.

The migration currently limits replacement coordination to one operation for
the role. Separate simultaneous water-theater ownership and global navigation
around allied structures remain rollout work; straight berth egress and native
movement-area connectivity are not a guarantee of an unobstructed full route.
See the [plan](../sea-layout-migration-plan.md) and
[runtime results](../sea-layout-migration-results.md).

<!-- source: data/script/src/roles/sea_factories.as; blob: 81753c9202c439abe4f0e2264f3a1528f4a7c832; lines: 227 -->

## D-209 follow-up

FactoryAllowed and NeedSeaplane enforce the SEA-only post-T2 platform transition.
Frames and queued orders prevent duplicates; T1 recovery is still allowed.
Platform purchases additionally require D-210 economic readiness; the missing
platform preference remains distinct so another optional factory cannot spend
its bank while SEA is waiting for adequate income.
RoleSea calls native MakeFactoryTask(platform,true), preserving configured
aircraft weights while bypassing the T1 shutdown that otherwise leaves a new
platform idle after a T2 shipyard. No other role opts into this lever.

D-211: SEA passes KeepFactoriesQueued to the optional third native argument.
This removes pre-enqueue resource admission waits while native recruit tasks
retain low-metal spending priority and empty-energy control. It does not
guarantee progress without resources or an open physical exit.
