# AIR compact factory clusters and retirement of early energy

Design before implementation, 2026-10-02. Supersedes individual AIR bay placement
in [the campus design](air-campus-strike-design.md). TECH's build order, reclaim
sequence, factory reconstruction and layout choices remain unchanged.

## Requirements and interpretation

- A cluster contains at most six labs total. The first contains one T1 and five
  T2 labs. Further clusters contain up to six T2 labs; there is no default total
  lab cap. Reserve a second cluster to preserve the previous minimum of six
  planned T2 sites overall. Reservation does not order or fund construction.
- Reserve the complete first cluster before its first lab. Keep the AFUS district
  separate. Revalidate the entire cluster immediately before its first structure;
  relocate all unused slots together if blocked. Once any slot starts, retain
  the cluster and repair individual unavailable slots without moving structures.
- Use TECH's native half-cell geometry, reservation, allied exclusion, persistent
  slot, claim, pin and serialization mechanisms. AIR owns policy and membership.
- Pack lab cells in three columns and two rows, with adjacent banks of nanos.
  Each T2 bay has twenty distinct nano slots within construction range. The T1
  bay reserves its configured early support count. Flying output does not need
  the ground-factory exit corridor inside this air-only compound.
- Keep the existing twenty completed turrets per standing T2 lab expansion gate.
  Gifts and existing saves retain their individual bay records; new expansion
  uses clusters. Do not relocate an occupied legacy bay.

## Native mechanism

Add a deterministic compact compound geometry constructor to
`BaseLayoutGeometry.h`, taking actual footprints, counts and column count. Test
alignment, rotations, mixed lab footprints, overlap, bounds and support reach.
A native atomic planning API preflights the whole rectangle and each footprint,
then creates the ordinary persistent slots and a shared envelope. Roll back all
created reservations on failure. Return stable slot IDs through named layout
state. No TECH factory-front or factory-line state is changed.

Existing ground exit lanes are checked before the transaction. Internal air-lab
exit lanes are excluded only within this air-specific transaction; other
reservation callers keep their existing behavior. Search only the perimeter of
each candidate ring, with a bounded retry interval and one compound search per
planning tick. Future reservations remain visible to allied AIR/TECH and defence
placement through the existing shared native index.

## Reclaim policy

Extract TECH's scalar permission calculation into a tested shared helper:
completed reactor required; with a completed AFUS low-tier energy is eligible;
otherwise subtract the whole retiring tier's output from income and require
1.25 times energy pull for wind/basic solar, 1.5 for advanced solar. TECH passes
its unchanged inputs and retains its execution, concurrency, radius and guards.

AIR runs the same calculation after mex upgrades, outside energy recovery.
Disable the native legacy energy-reclaim policy while AIR owns this decision,
and preserve/restore its original float bits on role exit. Prune dead task
handles from AIR accounting; dead reactor jobs cannot hold the serial gate. It
reclaims wind first, then basic and advanced solar, with bounded concurrency and
fresh task ownership. Mark targets retiring through Lifecycle; do not enqueue
duplicates. Release their persistent wind slots after destruction and prevent
wind/basic-solar/advanced-solar reconstruction while a completed AFUS exists. Reactor loss must allow
energy recovery again. Completed AFUS means completed, never a frame.

## Bomber timing and meta

The requested twenty-minute useful T2 wave is a performance target, not a timer
that makes unfunded units affordable. The previous natural run reached first
AFUS at 32.89 minutes and second at 37.54; see
[the recorded results](air-economy-zone-results.md). Compact placement alone
cannot establish twenty-minute effectiveness.

The [official air guide](https://www.beyondallreason.info/guide/basics-of-air-warfare)
supports energy investment, stationary support for weak aircraft build power,
scouting and coordinated air forces. The [official economy guide](https://www.beyondallreason.info/guide/in-depth-look-at-economy)
and the pinned [shared PvP air analysis](../../rjm.bar.docs/knowledge/70-strategy/78-air-pvp-meta.md)
support judging transitions by affordable production and survivable targets.
Inference: two AFUS is not a universal prerequisite for an effective opening
bomber wave. A funded first wave with escorts and an energy reserve can precede
the mass-production economy milestone. User clarification is pending because
the earlier instruction explicitly required two AFUS. Preserve that gate until
answered; do not silently reverse it.

## Validation and acceptance

1. Run native geometry and AngelScript scalar tests, including unchanged TECH
   threshold boundaries, AFUS frame exclusion and retirement recovery.
2. Build a paired DLL/symbol artifact outside the reference engine checkout,
   load the affected experimental profiles with no script warnings/errors.
3. Run rendered controlled games to observe dense reservations, first placement,
   blocked unused-cluster relocation, twenty support slots per T2 lab, expansion
   past six labs, and wind retirement without reconstruction. Show screenshots
   during runs. Controlled resource injection proves mechanics, not economy.
4. Run natural AIR economy with allied TECH and record T2 access, first fusion,
   AFUS, support, constructor and bomber milestones at 10/15/20 minutes. Report
   misses and their causes; do not claim an optimal or unbeatable economy.
5. Recheck invariants, role documentation and API parity. Publish DLL, matching
   symbols and data together to the required engine build output. Commit locally;
   do not push, following the user's last push instruction.
