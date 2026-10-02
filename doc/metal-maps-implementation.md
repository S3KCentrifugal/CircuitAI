# Metal-map implementation and validation

This implements the field and economy architecture from the
[revised design](metal-maps-revised-design.md). D-170 records the decisions;
the proposal's original fixed grid and converter-driven economy were not used.
This document distinguishes focused economy checks from the full invariant
verdict. Passing the former is not a claim of optimal PvP play.
See [measured results](metal-maps-results.md) for the final build, runs and limits.

## Mode boundary

[metal_map.json](../data/config/metal_map.json) is a separate shared configuration
fragment loaded by every active profile. Putting this under the root economy
fragment alone was insufficient: profile economy files replace that fragment.
The native service requires BAR's published `mex_count == -1`, positive raw
metal, and either a recognized map or a broad connected deposit. Missing game
metadata, barren terrain and positive ordinary spot counts keep normal mode.
Detection precedes terrain reservations and manager resource initialization.

The normal branch does not build a field grid, scan field candidates, reserve
field claims, invoke MetalEconomy, alter factory cluster shapes or suppress
converters. The independent pre-existing index-zero mex cancellation bug is
fixed for all maps; bounds checks also protect legacy spot callers. A diagnostic
now identifies the actual producer of a unit instead of inferring its producer
from proximity to a retiring lab. These are the explicit normal-mode changes.

## Extraction, ownership and bounded work

[MetalField.h](../src/circuit/resource/MetalField.h) evaluates strict extraction
circles against raw metal cells, separately from building footprints. It reports
isolated yield and marginal yield after maximum-depth overlap. There is one raw
grid per game and one claim ledger per ally team. Friendly frames reserve output
conservatively. Task keys include the owner; unit keys use a separate namespace.
Releasing one task does not free another player's claim or a standing frame.
Upgrade locks name the actual owned mex, rather than a nearby synthetic spot.

[MetalFieldEconomy.cpp](../src/circuit/module/MetalFieldEconomy.cpp) searches a
deterministic local grid, continuing its cursor on subsequent calls. Candidate
and extraction-cell budgets are configurable; budget exhaustion means pending,
never “all metal exhausted.” Placement checks terrain, engine buildability,
factory exits, allied layouts, nearest-start ownership and safe builder reach.
The broad allied-base exclusion is deliberately omitted for field mexes: on
SpeedMetal it excluded an AIR player's own start. Exact reservations still win.

Positional mex orders from older helpers are normalized at native enqueue, so
they use the same claim lifecycle. Field tasks retain their exact position and
abort when invalid; they do not fall back to the nearest legacy spot. New field
save records append their versioned identity after the old payload; ordinary
records retain the old format. Reload restores task identities and reacquires
claims. Runtime save/load still requires a dedicated engine validation fixture.

## Economy policy

[MetalEconomy](../data/script/src/manager/metal_economy.as) owns experimental
economic decisions; [MetalMath](../data/script/src/helpers/metal_math.as) contains
the independently tested arithmetic. Production funding considers both metal
and energy. AIR reads current aircraft costs to estimate workload; energy demand
also includes committed pull. The first constructor's forty-mex commitment
continues through a full metal bank. Additional extraction follows energy and
production demand after that opening commitment.

The opening has both a mex budget and a time limit. A rich field needs only one
opening mex. AIR preserves scout/constructor recruitment and commander factory
assistance; afterward aircraft do expansion, while an idle commander returns to
economy work. First T2 access follows the owner's explicit worker/screen triggers;
subsequent investment gates consider both banks and a bounded income forecast.
AIR increases storage, one project at a time, when its full bank cannot hold the next lab or
advanced fusion, avoiding a permanent affordability ceiling.

Energy chooses available wind, solar, tidal, advanced solar and funded reactors
using current costs, output and build power. Failed placement tries the next
candidate. The metal controller lifts obsolete finite-rush energy caps as needed.
Density and unit-cap pressure favor larger power sources; completed advanced
fusion alone does not justify reclaiming needed wind. TECH's ordered lab
reclaim/rebuild rows remain in place; the normal converter/rush recipe is bypassed
only in metal mode. Legacy profiles use a separate native, JSON-tunable energy
ratio adapter.

Every native construction enqueue and restored construction task rejects an
energy converter in metal mode, using BAR's conversion custom parameters. Role
cap changes cannot reopen this admission path. Existing gifted converters are
not destroyed. INV-111 checks queued converter work; a read-only Lua observer
independently records actual converter creation on every team.

## Layout exceptions

AIR still uses the shared native layout engine. Metal-mode reactor modules omit
converter slots. Six-lab compounds remain the first choice; the planner also
tries rotations and narrower arrangements. After 120 seconds without a suitable
site it can reserve an atomic three-lab or single-lab compound, with all required
support slots. Further demand reserves additional compounds. This exception was
needed on SpeedMetal where an allied TECH expansion occupied much of the small
platform; it does not release or overlap the ally's reservation.

The AIR reactor district waits for a factory reservation before claiming land.
Normal AIR shapes and TECH geometry are unchanged. INV-006's mandatory post-AFUS
wind removal, INV-009's converter-first assertion and INV-021's mex-upgrade-before-fusion
assertion are normal-mode promises;
metal mode intentionally follows the energy-balance policy above. Factory,
allied-overlap, build-power and other invariant failures remain enabled.

## Reproducible checks

- `tools/run_native_tests.sh`: existing geometry, routing, targeting and policy
  suites, plus strict-circle yield, overlap, cancellation, upgrade ownership,
  restored key uniqueness and metal economy arithmetic.
- [prepare_metal_check.py](../tools/playtest/prepare_metal_check.py): explicit
  AIR/TECH starts for Full Metal Plate, SpeedMetal and Nine Metal Islands,
  registered only in the isolated staged script tree. No resource gifts.
- [metal_watch.lua](../tools/playtest/widgets/metal_watch.lua): every 30 seconds,
  actual extraction, converter starts, wind, workers, labs, banks and spending.
- [audit_metal_check.py](../tools/playtest/audit_metal_check.py): independent
  opening/growth/converter audit, peaks and final losses, alongside the unchanged
  full invariant results. It does not treat combat losses as proof that no
  economic expansion occurred.

The rendered camera now sets a complete overhead state. The playtest watcher
drains final log bytes after engine exit before deciding whether a fast run
ended prematurely. Retained screenshots and logs, build hashes, results and
remaining limitations are recorded in the accompanying benchmark evidence.


## Revised dedicated opening

The owner's later instruction supersedes bank-limited initial extraction:
MetalEconomy assigns persistent first/second/third T1 constructor identities.
The first builds toward forty owned mexes even with a full metal bank; the
second builds needed power or assists power construction. TECH's third starts
T2 after the unchanged lab reclaim rows; dedicated workers bypass discretionary
frontline/defense work that previously stole the mex builder. INV-113 checks that
assignment. AIR starts T2 after its completed
initial fighter screen. Later investments retain energy and support checks.

MetalLayout preplans five dense eight-mex modules. PlanMexCluster uses the
shared native geometry/reservation engine, snapped footprints, extraction-radius
spacing and atomic rollback. Forty is a minimum opening commitment, not a cap:
further demand reserves additional modules. Blocked unused modules are replanned. A positional
mex task hands its initial blocker back to its persistent slot before claiming
and serving it; otherwise the slot would reject its own task as ground taken.
INV-112 independently checks the resulting frame against the served slot.
Cancellation uses the shared builder cleanup to release a claimed or served
unframed pin; INV-114 checks the dead task after that cleanup. The dedicated
worker resumes abandoned mex orders before creating another commitment.
Other roles request positional field sites near their moving constructor.
