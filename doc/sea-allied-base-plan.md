# Allied SEA bases and forward shipyards

2026-10-04, D192. The supplied screenshot shows interleaved SEA economy and
backline shipyards. Existing D153 native allied reservations already reject
foreign slot/zone overlap; D191 SEA converter/fusion blocks use that index.
However, six-tidal patches only reserve six footprints, allowing different
owners to alternate patches. Ordinary SEA shipyards bypass SeaLayout entirely;
experimental berth search tries four facings and a radial search about start.

## Change and boundaries

1. Retain the shared native rectangle index, including ordinary build retry
   enforcement. AIR/TECH production and spending remain unchanged. Confirm
   reciprocal SEA/AIR/TECH exclusion with hostile placement probes against
   each other's unused factory and economy slots. Weapon/forward-mex areas do
   not acquire exclusive base envelopes: their actual building footprints
   still cannot overlap, but neighbouring allied construction is allowed.
2. Reserve a complete SEA tidal cluster before its first building, with a
   configurable 48-site touching grid. Ownership follows the complete reserved
   cluster, not the nearest start: coastal starts can be on land, and a strict
   start-based bisector partition starved legal naval economy in the first
   Glacial supplied tests. That partition was tested and removed. No base-wide
   native exclusion is added to weapon/mex tasks. Terrain or foreign claims
   can reject a candidate; search another site instead of breaking a plan.
3. Use enemy-start facing for SEA strategy independently of the opening yard's
   hull orientation. Only the first actual T1 factory can use relaxed berth
   orientation. All subsequent yards route through the same placement owner,
   face the enemy, and put their entire footprint forward of reserved and
   existing naval economy. Preserve the historical first-factory flag even
   after destruction; a replacement is not a new opening exception.
   Filter both role-selected tasks and the shared manager's native fallback.
   Keep opening searches at 1200 elmos; later searches can reach 2400 elmos
   from their harbor when neighbouring clusters exhaust the nearer sites.
   Compact SEA also preplans future T2 berths after its opening yard exists,
   using a configurable initial 768-elmo forward anchor. This reserves rear
   economy room even when the opening yard hugs the map edge. These are empty
   reservations: income gates still decide when a yard is actually purchased.
4. Keep future economy behind the harbor and its support area. Preserve framed
   work and started blocks; invalidate only unused candidates. Keep bounded
   placement searches and per-second geometry snapshots, not per-frame scans.

## Verification

Pure tests cover footprint/frontier boundaries and the one-time opening gate.
Runtime checks reject foreign-plan overlap and incorrect admitted yard facing
or position. A staged multi-ally probe tests real native reservations in both
directions across SEA/AIR/TECH and refusal inside an empty cluster. Native
index unit tests cover release/replacement and legal neighbouring defense/mex
footprints outside private clusters. Physical obstruction/replan and save/load
remain separate lifecycle coverage; do not infer those from overlap probes.
A supplied multi-SEA game creates economy and later shipyard demand;
an independent Lua observer checks completed geometry, ownership and facing.
Run ordinary Glacial and Supreme games to catch native fallback/expansion
regressions, show screenshots while running, retain original failed results,
and distinguish placement acceptance from strength or economy improvements.
