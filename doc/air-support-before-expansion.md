# AIR support before additional T2 labs (D-155)

Plan: require twenty completed, owned construction turrets assigned within
reach of **each** existing T2 air factory before ordering another T2 factory.
Queued and unfinished turrets do not qualify; a turret serves one primary bay.
Check current ownership again when admitting or resuming an unstarted order.
The first T2 lab retains the income/full-bank gate. Banked metal cannot bypass
the support requirement for expansion. TECH policy remains unchanged.

The earlier full-bank exception (D-153) is superseded for additional labs.
BAR's [economy guide](https://www.beyondallreason.info/guide/in-depth-look-at-economy)
supports adding construction assistance before duplicate factories and keeping
energy, metal and build power balanced. Twenty is the owner's explicit AIR
expansion threshold, not a universal game rule.

Implementation plan:

1. Extract shared live support accounting and a pure expansion predicate.
   Recheck completed turrets, unfinished factories, gifts and losses; preserve
   unique bay ownership. New T2 plans require a complete twenty-slot bank.
2. When an additional lab would be affordable, target twenty turrets on current
   T2 bays. Give floating-metal support work precedence over converters and
   optional expansion. Build at most three funded support frames concurrently;
   prioritize finishing them after those slots are occupied.
3. Include a bounded drawdown of stored metal in the construction-power target.
   Do not subtract a factory's production power from the economy support target.
   Allow funded constructor recruitment during overflow without charging the
   full remaining cost of distant future projects against the short forecast.
   Preserve energy recovery, transport priority, the opening screen, and mex
   completion before reactors.
4. Test the pure predicates, observe a natural economy with a donated T2
   constructor, and use a supplied economy to verify twenty completed turrets
   before each new lab. Keep runtime invariants and record all failed checks.

Control: `build-theatres/d155-gift-control`, seed 930146, Supreme Isthmus,
Armada AIR, no economy injections; one T2 air constructor is gifted at six
minutes. Before this change AIR completed T2 labs at 16:29, 17:55, 19:33 and
22:49. At 20 minutes it held roughly 5,090 metal with only two turrets on the
first T2 lab and none on the next two.

## Implementation and verification

All AIR admission paths use fresh support accounting. Each owned completed
turret within build distance belongs to its nearest non-retiring live bay.
An unadopted gifted T2 lab blocks expansion until the next ownership refresh
can associate it with its bay. Orders and frames do not count as completed
support; the separate commitment count prevents duplicate support orders.
The reusable arithmetic has sixteen new cases covering 19/20, incomplete labs,
uneven per-lab support, losses, invalid input, bank drawdown and funded queues.
No TECH policy or existing reusable arithmetic was changed.

The full suite passes: 76 ranking checks, geometry, eight lane suites,
109 production-policy cases and ten placement-policy cases. Role references,
invariants and 248 script API members pass validation. Documentation links
retain the eight existing missing-hover-document findings (KI-404).

### Donated-constructor comparison

Both games use Supreme Isthmus v1.7, Armada experimental_hard, seed 930146,
normal resources, and one gifted T2 aircraft constructor at six minutes.
The pinned DLL is `d153-build-03`, SHA256
`fcc2c7ea532f9ef37b3f3991023d6e6bca018b49d9d5f906234ad7f2f13b6046`.
BAR is `test-31450-6562fb1`, engine `recoil_2026.07.04`.

| Measurement | Control | D-155 |
| --- | --- | --- |
| First T2 lab finished | 16:28.7 | 15:48.6 |
| First fusion finished | 21:10.2 | 18:33.7 |
| Completed T2 labs at 20:00 | 3 | 1 |
| Completed support turrets at 20:00 | 5 | 23 |
| Completed mobile build power at 20:00 | 590 | 1,340 |
| Metal bank at 20:00 | 5,144 / 5,300 (97%) | 4,089 / 6,150 (66%) |
| Completed T1/T2 constructors at 25:00 | 7 / 4 | 10 / 8 |
| Completed support turrets at 25:00 | 6 | 35 |

The D-155 second T2 lab frame starts at 20:30.1 with the prior lab at exactly
twenty completed turrets, and finishes at 21:39.3. Every reactor frame had
zero basic or unfinished owned mexes. The strict `air_transition` result is
still FAIL because the first lab misses its existing 14-minute deadline;
fusion now meets the 20-minute aim, with no script or invariant failures.

Control archive: `build-theatres/d155-gift-control/runs/20260930-211421`.
Final archive: `build-theatres/d155-gift-fixed02/runs/20260930-212955`.
An earlier `d155-gift-fixed` attempt failed host compilation on a const-handle
signature; it is superseded and supplies no gameplay evidence.

More construction power does not eliminate overflow. Between minutes six and
twenty, ten-second samples at or above 75% metal storage total 300 seconds in
the control and 400 in D-155. At 25 minutes D-155 holds 8,094 / 8,100 metal.
The mobile ceilings are reached and aircraft energy demand exceeds supply;
work assignment and energy investment still need calibration (KI-442).
This single matched scenario is not a repeated-map or PvP win-rate claim.

### Supplied-economy capacity check

`d155-capacity` uses the same map, side and seed, with the existing supplied
economy fixture. The first six T2 labs finish at 4:50.8, 6:31.9, 8:32.1,
10:34.0, 12:08.8 and 13:51.0. The engine observer sees twenty completed
turrets on **each** prior lab at every expansion frame, including the sixth.
This verifies capacity and ordering, not natural transition timings.
The existing attack controller launches its first wave at 25:46 with 300
bombers and 302 escorts. Expansion continues to ten labs, with the same
completed-support condition observed at each new frame.

Archive: `build-theatres/d155-capacity/runs/20260930-214018`. The strict
`air_capacity` verdict is FAIL because the ten-minute wall-clock allowance
expires at 44.5 game minutes, short of the requested 45. All four gameplay
expectations are met and every script/invariant/crash forbid is clean.
`air-support-audit.json` in that archive separately confirms all new support
event expectations by their deadlines and explicitly records incomplete
45-minute duration. Do not relabel the strict timeout as a passing full run.
Future capacity runs should allow twenty wall minutes for this unit load.

### Publication and tooling

The mandatory Recoil build output contains all 239 current data files, the
unchanged stripped DLL and matching symbols; hashes and script API parity
match the pinned test build. The live BAR installation is not modified.

The launcher path fix resolves KI-438. A mocked launch verifies absolute
write-dir/start-script arguments from a relative input; the live capacity
engine is found equally by relative and absolute paths. A mocked targeted-stop
check confirms both forms select only the intended process and exclude an
unrelated engine. Save/load and the full faction/map matrix remain unplayed.
