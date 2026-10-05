# SEA economy blocks and placement ownership

2026-10-04, D191. Screenshot: Supreme Isthmus v1.7. The current local game log
contains SEA roles but no migrated layout startup marker. It cannot prove the
screenshot's exact runtime settings, but the shipped default has migration off.

## Findings

1. D190 only executes under ExperimentalBuild. Normal SEA still uses loose
   native/script placements. Its cheap naval T1 converter costs 1 metal and
   1,150 energy in the pinned BAR source; low metal cost is not free construction.
2. The migrated layout has dense independent patches but no shared economy
   block. Converters can consume the space useful to future fusion support.
3. Economy anchors follow a harbor's hull exit facing. That is not necessarily
   the enemy-facing direction. Radial fallback can also put reactors forward.
4. The unpinned-project sweep only knows projects recorded by SeaLayout::Pinned;
   it therefore misses native/build-chain projects it was intended to reject.

## Change

- Add an enabled-by-default CompactEconomy placement option for SEA. Keep the
  broader ExperimentalBuild/AdaptiveFleet migration off by default. Legacy
  production/combat decisions remain in place; route their naval economy/nano
  construction through the same placement owner used by migrated SEA.
- Use TECH's existing native ReserveZone/LayBand/PackSet/PackNearGroup mechanisms
  in a SEA-owned module. Reserve square turret blocks and fusion capacity first,
  then fill contiguous T1/advanced converter rows against those blocks. Preserve
  zero-gap tidal patches, mex positions, shipyard exits and allied reservations.
- Derive strategic facing from actual enemy starts when known, with map centre
  fallback. Search only rear/lateral water for economy blocks; check the reactor
  footprint stays behind the harbor independently of factory hull orientation.
- Separate factory support from economy support. Factory turret admission checks
  actual snapped range. Economy turrets must cover an active/planned fusion,
  grow only with funded work, and assist its construction through native tasks.
- Retain only successfully pinned SEA tasks. Inspect live unit task ownership
  to replace unframed naval bypass orders;
  preserve existing frames, player tasks and enemy reclaim. No global masks,
  TECH policy, AIR policy, or native combat changes.

## Verification

Pure tests cover rear half-plane and minimum useful support. Supplied Supreme
fixtures exercise actual placement/funding/assistance with supplied demand under
both native and experimental builder movement. Ordinary games exercise the
legacy decision adapter and migrated build owner. The fixtures
build T1/advanced converters and a naval fusion, observe turret assist commands,
check factory range and fusion rear placement, and capture screenshots. Run
ordinary Supreme economy and a Glacial regression smoke, preserving all failed
iterations and comparing against the D190 working tree in d191-baseline. Check
script API, role docs, invariants, other-role source isolation and output parity.
These tests establish placement/control behavior, not a general strength win.

## Corrections found while playing

- Legacy helpers label tidals/converters as factory tasks. Classify the actual
  naval definition before dispatch; preserve land work for coastal commanders.
- A claimed pin has no served reservation ID until the builder reaches it.
  `SeaEconomy::OwnsTask` recognizes the pinned ledger during travel as well as
  native served IDs. Do not cancel a legitimate approach as an unplanned job.
- T2 construction subs cannot build T1 naval turrets. Persist fusion preparation
  demand in the block and let T1 ships supply its initial two turrets.
- Native converter tasks abort below 55% stored energy. Admission requires 60%
  to avoid immediately reissuing doomed work. SEA disables old-converter tier
  reclaim while this layout is active, restoring the prior setting on exit.
- Retaining every native task-added handle crashed on a dormant chain link;
  that approach was removed. The native destructor bypasses reference ownership
  for `nextTask`, so the ledger stays restricted to our explicitly pinned tasks.

See [results](sea-economy-block-results.md) for original failures and final scope.

- The ordinary adapter must preserve null/native fallback and productive native
  guards. Replacing null with Wait suppressed expansion in normal games; the
  corrected path restores native decisions, keeping the commander and one T1
  ship out of discretionary factory-support purchases.

- Keep the economy envelope behind the factory's assist disc, not overlapping
  it: on Supreme's tight shoreline an early economy claim could otherwise take
  the remaining feasible support space before the larger factory bank fitted.
