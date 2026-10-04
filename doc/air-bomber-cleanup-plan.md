# Bomber target exhaustion and flight state

Scope: experimental AIR's committed operations; preserve TECH, legacy bomber
tasks, the economic build order and defensive sorties returning to repair.

The current advanced operation admits named strategic structures, then armed
structures. It omits other economy, support buildings and surviving ground
forces. Once both searches fail, it surveys enemy starts without attacking
those lower-priority contacts. Staging deliberately permits landing; operation
entry is meant to disable it. Verify the synchronized flight state in an
isolated Glitters game before attributing the observed landing to one cause.

1. Reproduce with supplied Phoenixes, a one-time strategic target and surviving
   lower-priority targets. Observe actual engine flight state and target orders,
   capture rendered screenshots, and retain the baseline result.
2. Add a script-selected fallback list to the native operation mechanism.
   Preserve strategic targets first and the existing armed-static fallback,
   then remaining economic/support buildings, approved heavy ground units,
   and remaining static targets. Keep the earlier T1-ground exclusion as the
   default; an optional setting can admit them as the last tier. No reply to
   the clarification was assumed to authorize changing that default.
3. Apply fallback selection both before launch and after each target dies.
   Keep committed survivors active, retain all escorts, and search while airborne
   when no known attackable target remains. Repair flight ownership at its source,
   rather than periodically resending flight commands. Exclude primary classes
   from fallback scans so rejected strategic routes cannot bypass admission.
   Hold an unlaunched wave for a known, underfunded defensive T3 response before
   committing to cleanup. Do not recall an already committed offensive wave.
4. Test the pure target filter and target-exhaustion behavior. Exercise Phoenix,
   Armada and Cortex bombers, plus a defensive-return regression. Run all native
   suites, profile compilation/API parity and repository documentation checks.

The official [Phoenix reference](https://www.beyondallreason.info/unit/legphoenix)
describes attacks on both forces and structures. BAR's
[air guide](https://www.beyondallreason.info/guide/basics-of-air-warfare)
documents idle flight/landing control. Lower-priority cleanup after the valuable
targets are gone is a policy inference, not a claim of universally optimal PvP
target order. The loaded game and engine sources remain authoritative for commands.
