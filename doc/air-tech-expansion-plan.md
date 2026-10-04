# AIR economy, protected expansion and mex delivery

Design recorded before implementation, 2026-09-30. This implements the owner's
request following D-151. Existing opening scouts, three constructor crew,
fighter screen and transport priority remain the AIR production contract.

## Spending and reservations

AIR's completed-owned-mex predicate gates every new T2 air plant, including
fusion-access and later capacity plants. Revalidate unstarted orders when a
new basic mex appears; finish existing frames. No self-tech exception is
assumed: AIR requests the allied TECH constructor through the existing donation
protocol. Without allied advanced construction access it remains T1 until
upgrades become possible. The first fusion retains the same mex-first gate.

Before upgrades finish, scale T1 conversion capacity to surplus energy, without
an income/count ceiling. Count completed, framed and queued converters, permit
a small bounded number of concurrent orders, and reserve energy for aircraft
and construction. Mex upgrade/assist and energy recovery stay ahead of
conversion. Do not buy advanced converters while basic mexes remain. Commander
local economy uses this same action after its opening crew is complete.

AIR reserves two T1 sites and six T2 production sites in advance. T2 sites
require complete twenty-turret banks; speculative sites never count as built
power or trigger construction. Plan incrementally, before economy placement,
retry where terrain prevents a complete bank, retain native persistent claims
through task aborts, destruction and save/load. Existing income/capacity gates
decide when to build a reserved plant. The production cap remains configurable.

TECH retains its base factory pair and economy boxes. Reuse the front-factory
planner to hold one future T1 bot, T2 bot and gantry cluster ahead, including
turret banks and exit clearance. Future is a distinct state: no build tasks,
cooldowns, production counts or overdue-construction invariants until an
existing spending rule activates it. Renew the advance reservation after
activation. Existing reclaim and factory production rules keep their gates.

## Fortification

Use one TECH fortification controller for early lane defense and owned assets.
Plan teeth in lines on the sides of the lane, leaving the lane open, with gun
sites on the protected side. Pin sites exactly; no placement spiral may move
walls into the lane or weapons ahead of them. Future factory/turret/exit claims
are created first and all defense sites respect them.

After T2 construction access, add a second wall line and protective perimeter
segments around owned geos and advanced mexes. Leave access gaps toward the
base and lane; never fence builders into a closed ring. Add local ground/air
defense behind the perimeter. Only owned assets qualify; neutral/enemy geos do
not justify spending. Lost assets release unused plans. Terrain failures skip
individual impossible slots rather than blocking the whole economy. A bounded
construction budget and parallel order limit keep fortification affordable.

Existing weapon clusters build their planned walls before their weapons,
respecting lane and reserved-economy exclusions. This is protection against
ground fire and movement; teeth do not make structures safe from air attacks.

## First mex and transport

Every controlled AI role latches its first completed owned mex position and
announces it immediately, even when the startup roster exchange has ended.
Append optional fields to the existing roster version for compatibility;
validate sender identity and coordinate bounds. Preserve the anchor through
mex upgrades/destruction; update recipients and late joiners through normal
roster replies. Humans cannot announce through the AI-only message channel.

TECH targets the recipient's first mex when known, falling back to its start
for older peers. Reuse native FindDropSpot's nearest-first free-ground and
cargo-movement checks with script-configurable surface/air threat limits.
Revalidate when landing, retaining refused-position retries. Do not apply
the old start-position pullback to mex targets. If no safe drop exists, retain
the cargo and retry/fall back through the existing bounded ferry lifecycle.

## Verification and delivery

- Pure policy tests: converter demand/queue bounds, mex gates, reservation
  state versus active capacity, wall geometry/access gaps, roster decoding.
- Native compile and registered API/DLL parity check when widening landing
  search; test safety filtering and nearest-first selection.
- AIR opening and mixed AIR/TECH simulations: converters continue before
  upgrades; no T2 lab before the last upgrade; complete planned turret banks;
  scout/crew/fighter opening and transport precedence remain.
- TECH simulation with advanced economy/assets: future sites remain free of
  defenses, walls are pinned outside lanes, asset protection expands at T2,
  factory spending is not triggered by speculative plans.
- Record actual transport landing distance from the reported first mex and
  verify upgrade work follows delivery. Test fallback for an absent anchor.
- Add runtime invariants and actor documentation, update role source markers,
  run repository validators. Publish matching stripped DLL, symbols and data
  to the engine build output, commit locally, do not push.

Verification status will be recorded in the decision log with actual runs;
this document alone makes no claim that any behavior has been played.
