# D-171 AIR operations: implementation and measured results

Implemented in the active `data/` tree and opt-in native mechanisms. TECH's
builder rules and lab reclaim/rebuild sequence are unchanged. The design and
PvP references are in [the plan](air-committed-operations-plan.md); machine-readable
evidence, archived log paths and fixture hashes are in
[the benchmark](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/d171-air-operations.json).

## Behavior delivered

- Offensive T1/T2 bomber operations keep attacking until their bombers are
  destroyed. Every available fighter joins the launch and remains owned by
  that operation despite later home incursions, as explicitly requested.
  Newly produced/uncommitted fighters can intercept at home. Defensive T3
  operations can return and use normal repair services.
- Fighters share eight wall/interception tasks. Existing members keep an
  unchanged route; births join the current cell. Persistent target orders and
  cohort-leg commands replace repeated per-aircraft updates. Cells retain valid
  interception target IDs before assigning free cells to new contacts; moving
  contacts cannot continually exchange already engaged groups. No global command
  rate limit was introduced. Recoil's group-order API is a no-op; logical
  grouping does not itself collapse commands into one multiplayer packet.
- T2 raids prioritize eligible AFUS, advanced converters and factories in the
  current district before moving onward. T1 ground decoys are excluded from
  deliberate T2 target selection. When an economic route cannot be admitted,
  a larger funded operation attacks accessible front static. Once committed,
  survivors continue despite losses instead of repeatedly returning to base.
- T1 bombers retain mex/wind raids after opening workers and fighter cover.
  Legion's T1 Mosquito remains a gunship; it is not reclassified as a bomber.
- The bomber gate uses ten-second M/E income minima and loaded bomber costs,
  without requiring two AFUS. Two AFUS remain an economic growth objective.
  First T2 access retains its income/energy or funded-bank gate. Expansion
  still requires twenty completed turrets at every existing T2 air plant.
- With two completed T2 plants, one persistent factory identity specializes
  in fighters/radar aircraft. Twenty radar aircraft form a friendly sensor
  wall, then sweep enemy starts together. Another cohort is funded ten minutes
  after dispatch. Already committed recon does not count toward the next wave.
- The lone commander can place its first T1 air lab nearby before speculative
  campuses. The startup lab can retire to fund advanced production; one T1
  lab is subsequently rebuilt on its planned site. Ferry/worker recovery retains
  priority. Normal-map opening mexes now stop at three owned extractors; the
  native search-candidate limit had previously allowed endless opening mexing.
- Six-lab campuses remain preferred. After a failed terrain search deadline,
  rotated one/three-lab compounds can fit constrained land, each with its full
  support bank; planning still targets at least six future T2 sites in total.
  Allied reservations remain authoritative. TECH placement is unchanged.
- A nearly full pre-T2 metal store can expand to hold the loaded advanced lab
  cost. Pending/unfinished storage is serialized; no income threshold is lowered.
- Legion replacement scouts transfer individually out of a shared wall cell.
  They no longer abort the whole cell. AIR also clears stale engine commands
  when a commander leaves factory assistance, a T2 economy constructor is
  released, or an unstarted building order is cancelled.

## Test conditions and build identity

Final native build: `d171-build-8`, SHA256
`223a5789a2821e534c485428d1888c8bf5b2bbe9e5e40ab1100dac6338230b43`.
Engine `recoil_2026.07.04`, game `Beyond All Reason test-31479-433a460`,
profile `experimental_hard`. Matched DLL, symbols and active data are published
to the engine **build output**, not the live BAR installation.

Combat cases supply resources, aircraft, radar/scouts and replenished targets.
The normal economic launch-income gate is waived only in staged combat fixtures.
They exercise real AI planning/commands; the fixture does not order attacks.
The five-map matrix uses normal radar visibility. Focused defensive/frontline
diagnostics use explicitly recorded global visibility. The matrix spans
Armada, Cortex and Legion, fighter interception, flak, long-range missiles,
shorter-range missiles and an undefended economic corridor.

Natural games supply **no economy, constructors or production overrides**.
They run for forty-five game minutes with real AIR/TECH starts. Glacial and
Tundra require staged role assignment because their default role tables lack
the tested land-role pairing. Caldera uses an AIR duel because its available
starts do not provide a suitable TECH land start. These are not 8v8 benchmarks.

Read-only observers record actual command events, damage, deaths, production
and violations. Results stop at the requested frame, excluding shutdown
overrun. APM is a fixed sixty-game-second bin, not FPS, network bandwidth or a
rolling-window maximum. Bomber kills below use the actual last damaging unit;
an AI cache disappearance is not credited as a kill. Collateral is separate
from deliberate target selection. Generic arena PASS requires combat and clean
checks; the target/kill audit supplies the additional bomber evidence.

## Final supplied-combat matrix

Twelve minutes per map, current native build and stable interception policy.
All five reports PASS, with zero
script, fixture, crash, invariant or deliberate T2-to-T1 command errors.

| Non-metal map | Attacker | Bomber waves | Strategic last-hit kills | Bomber losses | Peak aircraft APM |
| --- | --- | ---: | ---: | ---: | ---: |
| Supreme Isthmus v1.7 | Cortex | 4 | 14 | 49 | 1,221 |
| Glacial Gap v1.1 | Armada | 5 | 10 | 53 | 1,204 |
| All That Glitters v2.2.3 | Legion | 5 | 4 | 47 | 1,270 |
| Tundra Continents v2.3.1 | Cortex | 4 | 16 | 101 | 1,251 |
| Serene Caldera v1.3 | Legion | 4 | 10 | 31 | 1,158 |

These cases demonstrate repeated strategic attacks across different terrain
and AA. Replenishment permits repeated destruction of the same *type* of
economic target. The losses are substantial, especially against flak on Glacial
and Tundra. They do not establish favorable metal trades or unbeatable PvP play.
The one-way doctrine is the owner's chosen policy, not a claim that every
human player should sacrifice surviving aircraft.

![Cortex attacks an island economy on Tundra](https://raw.githubusercontent.com/S3KCentrifugal/CircuitAI.benchmarks/main/doc/images/d171/tundra-island-strike.png)

Tundra, preceding build-8 acceptance run, captured by the wave observer during the attack.
The blue cohort reaches an island base; the damage/death log attributes twelve
strategic last hits over the full run. The image alone does not establish those
counts or prove escort lead on every frame.

![Legion raid on All That Glitters](https://raw.githubusercontent.com/S3KCentrifugal/CircuitAI.benchmarks/main/doc/images/d171/glitters-legion-strike.png)

Legion reaches the backline on All That Glitters under long-range AA coverage.
This preceding twelve-minute run records five strategic bomber last hits and no
offensive-return or escort-ownership violation.

## Focused acceptance cases

| Case | Observed result |
| --- | --- |
| Home incursion during commitment | PASS. Offensive attack at 2.6 min with 10 bombers/24 escorts. At 3.0 min, the home incursion is worth 1,800 metal and all 23 surviving escorts still belong to the same active wave. |
| Defensive Shiva | PASS. 32 bombers and 16 escorts attack at 1.78 min; actual Phoenix damage starts at 1.84 min, Shiva dies at 1.90 min, and all 48 operation members reach home at 2.15 min. Repair eligibility is implemented; this does not independently prove damaged-aircraft repair. |
| Backline blocked by 40 long-range AA towers | PASS. A 72-bomber frontline plan is chosen at 1.24 min and hits the front artillery at 2.16 min. Four artillery die; all 72 committed bombers are eventually lost. This verifies fallback and no-return behavior, not efficiency. |

The first defensive fixture supplied only 24 bombers and correctly failed the
attack/return checks: the conservative target/unknown-threat budget required
more. It is retained as a FAIL in the evidence. The successful repeat supplies
48 available aircraft and lets AI choose its actual 32-bomber commitment.
The stable-interception repeat also passes the home-incursion case: all 24
escorts remain with the ten-bomber offensive attack while the home intrusion
is present. Free home groups and committed escorts remain separate owners.

![Frontline bomber assault](https://raw.githubusercontent.com/S3KCentrifugal/CircuitAI.benchmarks/main/doc/images/d171/frontline-strike.png)

The accessible artillery position is attacked after the stronger economic
route is rejected. The operation continues into enemy resistance after clearing
the front; its complete loss is consistent with the requested commitment rule.

![Defensive aircraft returned home](https://raw.githubusercontent.com/S3KCentrifugal/CircuitAI.benchmarks/main/doc/images/d171/defensive-return.png)

The defensive cohort returns after killing the Shiva. Offensive operations use
a distinct policy and cannot enter the return state.

## Natural economy and failure-driven corrections

The initial full five-map matrix reached forty-five minutes on every map, but
all strict reports failed. Preserve that result: combat fixtures cannot stand
in for an economy test. The benchmark retains initial and repeated runs.

The first Glacial AIR had two AFUS but no T2 lab after forty-five minutes: its
six-lab footprint never fit the cliff-backed home. With the constrained-campus
fallback, the repeat completed T2 lab at **15.18**, fusion at **15.97**, T2
bomber at **18.44**, second T2 lab at **21.90**, and AFUS at **24.08/26.54**
minutes. The AIR observer is clean; the full report still fails TECH invariants.
This repeat uses native build 7; the later command-handoff and target-retention
changes are identified separately in the benchmark, rather than attributed to it.

The first All That Glitters AIR never built a lab: the commander kept selecting
fourth/fifth opening mex candidates. The explicit owned-three limit fixes that
admission mistake. Its repeat completed the nearby Legion lab at **1.77 min**,
128 elmos from the commander. The metal-map forty-mex opening was not changed.
The full repeat then completes T2 lab at **17.44**, fusion at **20.14**, second
T2 lab at **21.07**, first T2 bomber at **22.19**, and AFUS at **26.29/29.22**.
The first advanced wave launches at **26.68** with eleven bombers and thirty-five
fighters; the twenty-plane reconnaissance sweep launches at **26.55**.

The Supreme repeat completed T2 lab at **15.69**, fusion at **18.40**, first T2
bomber at **18.93**, second T2 lab at **21.10**, and first AFUS at **27.94**
minutes. Starter retirement at **14.25** and T1 rebuild at **16.61** demonstrate
the layout transition. A twenty-aircraft recon sweep launched at **26.78**.
Its first T2 operation at **26.05** was a five-bomber defensive sortie, not a
successful pre-twenty-minute backline wave. The strict run recorded 116 idle
commander observations and one reactor-before-mex-completion observation.

Those two failures revealed stale engine orders. The commander already chose
`commander.idle.energy` while still guarding the lab during path preparation.
Similarly, a reactor was cancelled at frame 52980 but its engine build order
created a frame at 53079. AIR now clears the appropriate command at each
handoff. The subsequent **45-minute Legion Caldera game passes all enabled
checks**, with zero INV-081 observations. Supreme cancellation verification and
the final Supreme repeat use the current native build. Supreme completes T2
lab at **16.39**, rebuilds T1 at **17.26**, completes its first T2 bomber at
**18.55** and fusion at **18.89**. Its AIR observer records zero violations,
including INV-077/081. The whole report remains FAIL for ferry/TECH findings;
no team-zero AFUS completes before the forty-five-minute cutoff.

The full rendered Tundra repeat reaches forty-five minutes with T1 lab at
**1.80**, first T1 bomber at **12.54**, and a replacement T1 lab at **34.36**.
It never reaches T2 or fusion. It peaks at **3,909 aircraft / 3,986 total orders
per minute**. That minute contains 3,248 Vengeance fighter orders with about
200 fighters and motivated the final stable-interception assignment change.

The original idle-factory observer also had two false-positive paths: it treated
finishing an unfinished replacement factory as idling, and let its idle timer
continue while the commander was doing other work. Both are corrected in the
test widget. The Glitters repeat's sixteen observations include these paths;
Tundra starts reporting at frame 61635 before its replacement finishes at
61850. The archived reports retain their original FAIL verdicts. This does not
waive genuine guard failures or the separate TECH invariants.

Caldera and Tundra's initial natural games did not reach self-funded T2. This
remains a real economy weakness (KI-461): ongoing T1 production can consume the
capital needed for advanced access when no useful donation arrives. Across
the matrix, neither first fusion by twenty nor effective T2 raids by twenty is
reliably established. This change does not advertise an optimal economy.

![Natural Tundra opening at five minutes](https://raw.githubusercontent.com/S3KCentrifugal/CircuitAI.benchmarks/main/doc/images/d171/tundra-natural-opening.png)

This is an ordinary, unfunded opening: the blue AIR base occupies the narrow
shore north of the mountain ridge. The corrected test camera follows the actual
factory, holds its state while rendering settles, and logs the captured
position/height. Earlier water-only camera shots were discarded as visual
evidence, not interpreted as missing buildings. At five minutes this repeat
has only +8 metal and about +217 energy; a large bomber force is not yet funded.

Tundra exposed an additional storage deadlock: the old income-based target
could stay below current capacity while capacity itself remained below lab
cost. The new pre-T2 exception admits storage without reducing the lab gate.
In its first full repeat, AIR admits the 2,900-metal lab at M10=16 with 3,089
banked, completes it at **15.00**, first T2 bomber at **20.59**, fusion at
**21.85**, second T2 lab at **30.69** and AFUS at **34.83** minutes. AIR's
observer and production invariants are clean; the whole game still fails
TECH/ferry checks. Team zero peaks at **1,109 aircraft / 1,883 total orders**.
These are different game populations/outcomes, not a controlled CPU speedup.

That team produces bombers but launches **no offensive wave** before losing
air control. Its opponent launches eight advanced waves between **25.55** and
**43.55**, plus twenty-plane recon sweeps at **27.48/41.20**. The opponent's
peak is **2,314 aircraft / 3,818 total orders**. The storage fix removes one
transition deadlock; it does not establish reliable early raids or victory.
This Tundra run preceded the final serialization of pending storage; Caldera
uses the serialized version and INV-118. Exact staged hashes remain in evidence.

The final **45-minute Legion Caldera repeat passes all enabled checks**,
including the completed-factory idle observer and INV-118. It finishes one
metal store at **8.53** minutes, peaks at **1,383 aircraft / 1,565 total orders**,
and admits a bank-funded T2 lab at **42.57** minutes. The lab does not complete
by the cutoff; neither does fusion. Storage capacity is now sufficient, but
reserving transition capital alongside ongoing T1 production remains necessary
for reliable timing on this low-income island start (KI-461).

![Natural Tundra advanced plant at twenty minutes](https://raw.githubusercontent.com/S3KCentrifugal/CircuitAI.benchmarks/main/doc/images/d171/tundra-natural-t2.png)

The advanced aircraft plant and its support occupy usable ground north of the
ridge. This is the same ordinary economy test, with no gifted resources or units
from the fixture. Allied AI donations remain normal gameplay.

## Command cost and remaining limits

An earlier Legion natural stress minute contained 1,607 ATTACK orders and
1,607 redundant queued FIGHT orders. `CCircuitUnit::Attack` now has an optional
fallback-fight flag. AIR's contact-aware route/operation controllers disable
that redundant follow-up; the default preserves all other callers. The final
pre-guard-fix Caldera repeat peaks at **1,882 aircraft / 2,160 total orders per
minute**, versus 4,066 aircraft in the earlier diagnostic. Combat populations
and outcomes differ, so this is not a controlled percentage-speedup claim.

Natural Tundra still exceeded 3,000 aircraft orders on build 8 before the final
script-only target-retention change. It is retained as a failure, not described
as a problem limited to old binaries. No command rate limiter was added.
The forty-five-minute stable-interception repeat peaks at **3,482 aircraft /
3,856 total orders** with no AIR observer/production invariant. The full
report still fails ferry/TECH checks. Retention reduces unnecessary contact
switching; it cannot make the requested all-fighter escort free of engine
commands when a T1 raid attaches 186 fighters to three bombers.

Native cohort updates use linear member passes with map/set lookups; initial
stable ID assignment sorts once. Strike candidate/AA scans and layout searches
retain nested work (KI-474/464). Logical groups and fewer orders do not prove
an 8v8 p99 CPU or FPS bound. Natural games can still exceed 3,000 *total* orders
through builders/static production. No universal sub-3,000 guarantee is made.

Fighters receive leading formation destinations, but fixed-wing circling and
the no-op wanted-speed adapter prevent an exact per-frame speed lock. Enemy
AA can still prefer bombers (KI-475). Committed ownership is verified separately
from geometric lead and from who actually absorbs damage.

## Reproduction and checks

Generate map-specific supplied cases with
`python tools/playtest/prepare_air_operations_cases.py --output build-theatres/air-cases`.
Use `air_arena.py run --case <generated-json> --map <name> --side <faction>` with
a fresh isolated `--dir` and the matched `--dll`. Focused cases are
`committed-home-incursion`, `defensive-t3` and `blocked-backline`.
`run_air_natural.py --dir build-theatres/air-natural --dll <dll> --headless`
runs the five ordinary forty-five-minute games. See
[the harness guide](../tools/playtest/README.md) for complete launch options.

Native build and relevant native suites pass. The AIR policy suite passes 83
real AngelScript tests; production, placement, amphibious and metal policy
suites also pass. All three experimental script graphs compile against the
captured native interface, and actual engine initialization succeeds. Script
API parity checks pass against the built DLL. Arena validation tests (14) and
independent result-auditor tests (5) pass. Invariant and role documentation
checks pass. The two existing sonar-helper findings (KI-473) and eight missing
hover-document links (KI-404) remain unrelated baseline findings.

No sample-tree, live-install, vendored-library or TECH sequence edits are part
of this change. Save/load of the new live operation state and a full 8v8
performance comparison remain unverified. Known limitations stay in
[the issue register](known-issues.md).
