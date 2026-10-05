# AIR / SEA compact economy and naval build power

Requested 2026-10-04. Baseline: `build-theatres/d190-baseline` (the complete
working data tree and D189 build 7, before these edits).

1. Remove the 16-elmo internal gap from AIR's advanced converter bank. Keep
   its AFUS separation, support bank, T1 wind clusters and T1 converter policy.
2. SEA tidal, converter and T1 economy patches use full-footprint pitch with
   no internal gap. Keep small patches so their perimeter remains accessible.
   A completely filled patch needs no second envelope: its persistent building
   reservations already own every cell. Preserve fusion separation and shipyard
   exits. Never move a claimed or framed module.
3. Reserve more dense support slots behind naval factories. Extend support and
   assist eligibility to amphibious complexes, floating hover factories and
   underwater gantries, independently of shipyard-only tech/handover logic.
4. Use each busy factory's actual product, share the production budget among
   factories, and count finished, framed and queued turret capacity exactly once.
   Require funding for the turret and its subsequent metal/energy consumption;
   banked donations count, hypothetical future gifts do not.
5. Verify pure geometry/funding boundaries, actual engine-snapped placements,
   completion of touching tidal/converter patches, physical turret assistance
   for shipyards and amphibious complexes, and natural Glacial/Tundra openings.
   Capture screenshots and publish immutable evidence. Compare with the pinned
   baseline; do not conflate smoke-test passes with gameplay benchmark wins.

Scope: policy in the active `data/` tree. TECH, other roles, profile JSON,
native placement masks and AIR's T1 layout remain unchanged. SEA's existing
experimental rollout switch is not changed by this targeted correction.
