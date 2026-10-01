# AIR local economy, recruitment and territorial interception (D-156)

Status: design written before implementation, 2026-09-30; implemented and tested as described below. This changes the experimental AIR controller; TECH keeps its current policy.

## Problem and evidence

The constructor-gift control used for D-155 ended with stronger build power but still filled metal storage. Its constructor ceilings were ten T1 and eight T2 aircraft, its economic target was only eight build-power units per metal income, and energy construction allowed one unfinished structure per definition. More aircraft alone cannot fix builders piling onto the same project or leaving home for native defense jobs.

AIR currently inherits the shared porcupine planner, including AA at allied resource clusters. Its expansion query is centered on each builder, so repeated expansion moves the effective home area outward. Its fighter screen updates a patrol line but does not dispatch nearby fighters to a new incursion. These mechanisms conflict with the requested local economy and territorial air-defense role.

Game doctrine and roster evidence live in the shared knowledge base: `../rjm.bar.docs/knowledge/70-strategy/78-air-pvp-meta.md`, `50-economy/51-build-power.md`, `60-tactics/63-air-tactics.md`, and the relevant files in `30-units/`. Primary sources checked for this design:

- [BAR air warfare](https://www.beyondallreason.info/guide/basics-of-air-warfare): fighter control, escorted strikes, fragile but useful gunships/EMP aircraft, low flying-constructor build power, and static assistance.
- [BAR economy](https://www.beyondallreason.info/guide/in-depth-look-at-economy): metal, energy and build power must grow together. Its general build-power ratio is a reference, not a universal AIR build order.
- [BAR early air raids](https://www.beyondallreason.info/guide/early-air-raids): scout targets and AA before committing a strike. Its early-air transition example does not replace this role's dedicated air opening.
- [Armada anti-nuke](https://www.beyondallreason.info/unit/armamd) and the pinned game UnitDef: interception coverage differs from missile weapon range. Placement must query the loaded coverage.

There is no defensible universal minute for producing each aircraft type. The controller will use jobs, observed threats, income, storage and available construction work. Numerical thresholds below are tunable policy defaults, to be checked in simulations.

## Preserved contracts

1. Scouts, three completed T1 flying constructors with commander assistance, then an immediate fighter floor. Transport requests retain first claim on factory production.
2. Upgrade all owned basic mexes before a reactor starts; aim for the first fusion by 20 minutes. A gifted remote mex may need one local-to-that-mex upgrade worker; this is not permission for general forward expansion.
3. The first T2 factory uses the existing ten-second minimum-income or full-bank gate. Every additional T2 factory requires twenty completed, uniquely assigned, physically in-range turrets on every existing T2 factory, even with a full metal bank.
4. Six or more late T2 bays remain possible. Six-wind clusters and allied layout exclusions remain authoritative.
5. No TECH build-order, wall, weapon or economy changes. Native additions expose observations or geometry only; AngelScript owns all decisions.

## Economic controller

- Anchor expansion to the AIR start, with a configurable home mex radius. Never use the mobile builder's current position as the next expansion center.
- Bound new economic sites to the home campus and current allied layout reservations. Leave room for the planned factory campus. Existing distant owned mexes may still be upgraded, with only one such upgrade active at a time; ordinary constructors return to local work.
- Raise the economic build-power target and constructor ceilings. Compute the target from stable income plus a finite metal-bank drawdown. Keep T1 energy builders useful after T2 rather than immediately idling the T1 factory.
- Fund constructors against a short resource horizon. An unfinished fusion's entire remaining price must not veto an affordable constructor. Recovery may fund a constructor when it improves a local energy shortage, but never recruit an unfundable queue.
- Permit several funded energy projects while limiting helpers on a project by its useful completion rate. Start local small energy work before sending all idle constructors to the same reactor. Static factory support remains separate from mobile economic power; twenty factory turrets do not mean twenty free economic builders.
- Measure actual completed mobile build power, local/remote constructor positions, metal-overflow duration, energy recovery and build-task assignments. A higher constructor count alone does not count as fixing overflow.

## Recruitment policy

| Job | Admission and priority |
| --- | --- |
| Transport | Existing teammate request protocol, ahead of ordinary recruitment. |
| Opening scout/crew | Preserve the established sequence and completion latch. |
| Fighters | Immediate opening floor; urgent replacement when observed friendly-territory threats exceed the defending screen; ongoing income/threat-scaled control reserve. |
| Constructors | Grow funded economic capacity before optional strike spending; maintain both T1 small-energy workers and T2 upgrade/reactor workers. Higher caps prevent the old ten/eight bottleneck. |
| Bombers | After fighter coverage and economic recruitment are funded, allocate a bounded strike share; preserve T2 wave/escort ownership and existing targeting mechanics. |
| Gunships/EMP aircraft | Bounded land-support complement when enemy land presence is known; Cortex Shurikens remain available after T2. Do not substitute them for fighter defense. |

Keep fighter and constructor production interleaved so a growing workforce cannot monopolize the only factory indefinitely. Existing bomber targeting limitations remain documented rather than silently claimed fixed by production changes.

## Friendly-territory interception

Expose a once-per-second snapshot of currently observed enemy aircraft: position and metal cost, with bounds checks. Do not use the old decaying air-heat map as if it represented a live raid; do not reveal unseen enemy aircraft. Script classifies friendly territory from participating allied/enemy starts, groups nearby contacts, and assigns the nearest available home fighters proportionally to threat. Other home fighters retain the screen. Re-evaluate frequently and restore patrols when contact is gone. Wave ownership remains exclusive.

## Static defense and anti-nuke placement

Experimental AIR opts out of shared porcupine planning and native queued defense distribution. Build only a bounded own-base flak/long-range AA complement, and anti-nuke protection. Use existing loaded faction helper names and existing native stockpile behavior. No AA at distant allied mexes, no ground-defense chains, and no walls from this controller.

For anti-nukes, query actual interceptor coverage from loaded weapons. Rank buildable sites toward the closest known neighboring start while keeping the AIR economic core covered. Prefer coverage of both base cores where geometry allows; otherwise maximize coverage toward that neighbor without sacrificing the AIR core. Reject allied reserved clusters and recheck the snapped position. Do not treat the 72,000-elmo missile range as a coverage radius. A placed launcher still needs a completed stockpiled missile; verify that in the simulation.

## Implementation boundaries and reuse

- Shared pure arithmetic belongs beside existing production math and gets executable tests. Shared placement/observation primitives remain role-neutral.
- AIR home geometry and defense selection live in AIR policy modules, reused by layout, builder rules and interception. Avoid separate copies of allied-start selection and constructor funding logic.
- Extend native battlefield observations only where the current script API lacks required data. Register matching declarations, rebuild the DLL, and stage matching data.
- Keep lifecycle ownership, reservation rollback and queued-task cancellation paths intact. Cancel forbidden unstarted work; do not reclaim a completed structure or abandon an actual construction frame merely because policy changed.

## Verification plan

1. Unit tests: workforce growth/funding bounds, interleaved recruitment, useful assist/parallel-project limits, friendly-territory classification and anti-nuke overlap geometry, including unreachable neighbor and edge cases.
2. Script/API and native test suites; live script compilation with the rebuilt DLL. Faction helper validation for Armada, Cortex and optional Legion.
3. Matched natural/gift runs against D-155's seed and six-minute constructor gift. Compare metal-overflow seconds, economic builder count/power, energy trajectory and fusion time. Inspect task placement, not just final resource snapshots.
4. A controlled friendly-territory air incursion with an allied neighbor. Observe fighter redirection, actual engagement and return; no remote AIR static-AA orders.
5. Anti-nuke scenario checks completed launcher location, own/neighbor coverage using the loaded radius, and stockpile completion. A wealthy capacity fixture continues to check the strict twenty-turret expansion rule.
6. Preserve TECH source and inspect its smoke behavior if shared native mechanisms change. Publish DLL, symbols and data to the required build output; commit locally, without pushing.

Failures and limitations will be recorded in the decision and known-issue registers. Do not report a timing goal or lower overflow as achieved without measured evidence.

## Implementation and evidence

The controller now uses 24 economic build power per stable metal income, up to
40 T1/24 T2 constructors, six parallel energy commitments, and useful assistance
limits based on remaining work. New mexes stay within 1,400 elmos of start;
ordinary economy sites stay within 2,400. The old factory-stopping T2 branch
now retains constructors and finite T1 land support. Optional strikes require
available completed fighters (home plus waiting escorts) worth 1.25 times known
enemy air, and no live friendly-territory incursion. This is a tunable estimate
of air control, not a claim that equal metal means equal combat strength.

AIR static defense is limited to four flak, one long-range AA and one anti-nuke,
shared across faction variants, within 1,500 elmos of its start. The limit is
checked against frames and unstarted orders. A donated Armada constructor must
not add a second anti-nuke to a Cortex base. Anti-nuke placement reads the
loaded coverage and maintains an 800-elmo own core while favoring the nearest
ally. Existing native stockpile handling remains responsible for ammunition.

### Matched Armada economic runs

All use Supreme Isthmus v1.7, `Beyond All Reason test-31450-6562fb1`, engine
`recoil_2026.07.04`, experimental_hard, zero bonus, seed 930146 and one T2 air
constructor donated at six minutes. No metal or energy is injected.

| Measurement | D-155 baseline | D-156 initial run | D-156 corrected-observer run | D-156 final |
| --- | ---: | ---: | ---: | ---: |
| First fusion completed | 18:33.7 | 13:54.3 | 14:50.4 | 13:43.6 |
| First T2 air lab completed | 15:48.6 | 16:13.4 | 17:46.5 | 16:42.4 |
| T1/T2 air constructors at 20 min | 10 / 7 | 29 / 5 | 28 / 4 | 25 / 6 |
| Mobile economic build power at 20 min | 1,340 | 2,050 | 1,880 | 1,970 |
| Metal bank at 20 min | 4,089 / 6,150 | 230 / 3,700 | 201 / 3,700 | 149 / 3,700 |
| Metal income at 20 min | 78.0 | 44.0 | 43.2 | 69.5 |
| Energy income at 20 min | 1,732.5 | 3,313.8 | 3,037.9 | 2,502.1 |
| Seconds sampled above 75% metal storage, minutes 6-20 | 400 | 0 | 0 | 0 |
| Seconds sampled above 95% metal storage, minutes 6-20 | 150 | 0 | 0 | 0 |

The sample interval is ten seconds (84 samples in the comparison window);
this measures storage occupancy, not exact wasted metal. Lower metal income
partly reflects the intended removal of remote mex expansion, so the bank
improvement cannot all be attributed to faster spending. All D-156 games
still fund considerably more local workers and energy. Energy starvation is
not eliminated: the first D-156 run has 0.5 additional seconds below one energy
between minutes 6 and 20, against zero in D-155. The second also has intermittent
metal stalls. The final run accumulates 17 seconds below one energy before
minute six and none thereafter, plus 20.5 seconds below one metal through
minute twenty. These are sampled starvation counters, not exact engine stall
durations. This is a tradeoff, not a perfect resource-balance claim. Same-seed
runs still vary; this small series is not a deterministic timing guarantee.

The corrected-observer run passes `air_local_economy`: fusion before 20 minutes,
mexes completed before the reactor, more than ten T1 constructors, no remote
workforce samples and no script/invariant errors through 25 minutes. Its final
crew is 28 T1/eight T2, 2,360 mobile power. The pre-existing strict fourteen-minute
T2-lab expectation remains unmet (KI-436); its actual income/full-bank gate is
preserved. Two local native movement stalls remain KI-443.

The final run also passes all `air_local_economy` checks through 25 minutes,
with zero script/invariant lines and every constructor sample local. It ends
with 25 T1/eight T2 constructors, 2,210 mobile power, 25 construction turrets,
81.9 metal/s and 837/3,700 banked metal. A local worker again exhibits the
native movement stall recorded in KI-443, despite the aggregate improvement.

Exact retained logs:

- D-155: `build-theatres/d155-gift-fixed02/runs/20260930-212955/`.
- D-156 initial: `build-theatres/d156-gift02/runs/20260930-222235/`. The old wind observer incorrectly assumed slot zero was built first; its six false positives are retained in the failed report.
- D-156 corrected observer: `build-theatres/d156-gift03/runs/20260930-223321/` (PASS).
- D-156 final: `build-theatres/d156-gift04/runs/20260930-225353/` (PASS).
- Computed comparison: `build-theatres/d156-economy-audit.json`.

### Controlled defense checks

These inject a sustainable economy, a fighter reserve and two raids near an
allied TECH start. They are capability tests, not natural economic benchmarks.
The final fixture limits AIR to three production bays to bound simulation load;
earlier unrestricted exploratory runs also reach six bays, with the independent
twenty-completed-turret expansion audit clean.

The Armada exploratory run, `build-theatres/d156-defence02/runs/20260930-223202/`,
dispatches seventeen fighters at 6:42 against the 6:40 raid. Its fighters damage
the raiders and return to the screen at 7:00. Anti-nuke admission at 15:00.1 uses
coverage 2,000, retains its own core and covers the nearest TECH core. Completion
is 15:33.8; a missile is observed stocked at 17:10. This run stops at 19:58.5 and
its strict report fails TECH invariants and a Legion framed-wind audit. The
latter was corrected to use reservation-to-unit identity because model offsets
make exact coordinate equality invalid after a frame exists.

The Cortex exploratory run verifies transport delivery, actual fighter damage
at the first raid, and independently measures both base cores inside loaded
anti-nuke coverage. It exposed per-faction defense caps; the final implementation
sums all three variants before placing a new defense. Strict reports retain
all TECH invariant failures; none are treated as a clean whole-match verdict.

The final Cortex run, `build-theatres/d156-defence04/runs/20260930-225000/`,
reaches 20 minutes and satisfies every AIR expectation. Its first request is
queued at 1:00.1, a transport is ordered at 1:07.2 and handed over at 1:31.
Eighteen fighters are dispatched at 6:42 for the 6:40 raid, damage its bombers
from 6:51.7, and return at 7:06. The second raid also triggers dispatch within
two seconds. T1 Shurikens and bombers are recruited after T2, beginning at
8:43.8 and 9:08.7 respectively. One anti-nuke is admitted at 15:00; the engine
observer independently confirms both 800-elmo base cores inside its loaded
2,000-elmo coverage, and observes one stocked missile at 17:00. There are no
AIR or observer invariant lines, and every sampled AIR constructor is local.
The strict whole-game report is **FAIL** on 36 TECH invariant lines (KI-427).
`build-theatres/d156-defence-audit.json` retains per-team counts and raid events;
the fixture-injected enemy bombers themselves account for two TECH INV-010
events. Other TECH warnings require independent triage rather than attribution
to that injection or a presumed baseline.

### Build and static checks

Pinned native output: `build-theatres/air/d156-build-01/`.
DLL SHA-256: `db9d138c9eed799679f75a040c1d9c9b5cf6b46bce49ec37fb1bd14e783f63dd`.
Matching symbols: `afa5bed010e0c078247a5ce2a434c13f655938e7d5c9fba3df305cf1a60ee1e2`.
The native suite passes 76 ranking checks, geometry tests, eight lane suites,
128 production-policy cases and twenty placement-policy cases. Script/API,
role-document and invariant-register checks pass. Documentation links retain
the eight missing-hover-document findings (KI-404); unit helpers retain the two
TECH sonar findings (KI-425). No TECH source or existing policy setting changes.

The stripped DLL, matching symbols and all 241 current data files are published
together to the required Recoil build-output `AI/Skirmish/BARb/stable` directory.
All file hashes match the tested sources/artifacts; the published DLL passes
the 253-member API parity check. The live BAR installation is untouched.

Save/load, all map geometries, constructor-loss recovery and natural unassisted
twenty-minute fusion are not established by these runs. Late injected economies
can still fill metal storage (KI-442). Start-based friendly territory is an
approximation; it does not track the moving ground front.
