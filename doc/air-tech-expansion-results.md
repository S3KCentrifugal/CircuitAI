# AIR and TECH protected expansion — D-152 evidence

Design: [plan](air-tech-expansion-plan.md). Implementation: [decision](decisions.md#d-152--reserve-expansion-before-fortification-air-mex-first-access-and-first-mex-delivery).

## Scope

Experimental AIR buys T1 conversion against surplus energy while owned mex
upgrades remain, without a metal-income ceiling, and rejects every new T2 air
plant until those upgrades finish. This strictly depends on allied advanced
construction access when AIR owns basic mexes. Initial scouts, three air
constructors, immediate fighters and transport priority retain their existing
production paths.

AIR holds two T1 sites and six complete twenty-turret T2 banks. TECH holds one
future T1 bot, T2 bot and gantry cluster, including support and exits, before
fortification claims ground. Reservations do not authorize spending. TECH's
idle air builders now use the same finite wall/weapon plans instead of the old
expanding defense spiral. Walls leave access gaps and skip terrain, occupied
claims and friendly lanes; a partial perimeter is possible.

Every experimental-role AI announces its first completed mex through the
allied roster. TECH selects the nearest sampled free, observed-safe landing
point around that mex and revalidates on arrival. Humans do not participate in
this AI protocol. Engine area-unload offsets remain possible.

## Reproduction

Engine `recoil_2026.07.04`; BAR `Beyond All Reason test-31450-6562fb1`;
Supreme Isthmus v1.7; `experimental_hard`, bonus 0, seed 930146, speed 30.
All directories below are under repository `build-theatres/air/`; reports and
logs are retained there. Use absolute `--dir` (KI-438). Stage with
`tools/playtest/playtest.py`, add `expansion_watch.lua` and the named observers,
then `prepare_air_check.py --scenario natural|capacity`, launch, and watch.
Launch/watch require the same process visibility on Windows; an unprivileged
watcher incorrectly reported an elevated engine exited. Its completed log was
subsequently rejudged. No live BAR installation was modified.

| Run | Build | Evidence and result |
| --- | --- | --- |
| `d152-compile/runs/20260930-190307` | 07 | Script/native startup clean. Reused smoke check expected an unrelated TECH flag/screenshot: overall FAIL. |
| `d152-mixed/runs/20260930-190715` | 07 | Natural 25 min. All expansion expectations seen; overall FAIL on TECH invariants. Six T2 banks by 1:48; TECH future T1/T2/gantry by 0:15. All six AIR mex upgrades before fusion/T2 air lab. |
| `d152-cortex/runs/20260930-190737` | 07 | Natural Cortex opening, 12 min: PASS. Scout, crew, fighter and patrol checks; first fighter 0.90 s after crew; no invariants. |
| `d152-capacity-assets/runs/20260930-191353` | 07 | Supplied late AIR economy plus TECH assets, 30 min. Five T2 plants and completed twenty-nano banks observed. Stopped before the 44-minute six-plant/wave deadline; expectations missing and TECH invariants: FAIL. Not natural economy evidence. |
| `d152-assets-final/runs/20260930-191617` | 07 | Supplied TECH assets, 12 min. Geo/mex wall plans present; whole report FAIL on TECH invariants. This exposed starvation by the old idle-defense spiral, subsequently replaced. |
| `d152-protection/runs/20260930-192421` | 08 | Final script, supplied TECH assets, 15.5 min: actual geo and advanced-mex wall completions, all expansion expectations seen. Overall FAIL: INV-010/022/039/053. No new INV-083–087, script error or crash. |
| `d152-legion-final/runs/20260930-191337` | 07 | Engine load-thread watchdog before AI initialization; stopped, no gameplay result. Mixed games include Legion AIR, but this dedicated opening run is unverified. |

Build 07 DLL SHA prefix `4f06517dafaccb11`; build 08 `b07aee03ffe6c44a`.
Build 09 is the final DLL, SHA prefix `e16cdf1d88afba37`, 7,569,050 bytes,
with matching `.dbg`. It additionally preserves same-area reachability when a
constructor walks off its factory pad; ferry landing uses destination move-type
passability so disconnected land areas are allowed.

The protection log is also judged by `fortification.json` at
`d152-protection/runs/20260930-193101`: all five explicit future-gantry,
geo-plan, geo-wall, mex-wall and T2-line expectations are seen. Overall FAIL
is retained on the same global TECH invariants.

Final capacity: `d152-six/runs/20260930-193207`, build 09, 45.1 minutes,
**PASS** with zero script, crash or invariant failures. Six T2 plants finish
by frame 42357 (23:31.9); all six twenty-nano banks are visible by frame
46980 (26:06). It later finishes eight T2 plants by 28:56.1, demonstrating
capacity beyond the six reserved sites under sufficient supplied income.
Wave 1 launches 300 bombers at 35:15. This is an explicitly injected economy
(36 AFUS, 80 advanced converters, two T2 constructors), not a natural-growth
benchmark. Final input-validation-only changes in converter arithmetic have
78 unit tests and are compiled in the subsequent natural regression.

`d152-final-mixed/runs/20260930-192928` is a stopped slow-start attempt while
the capacity engine was running. Its load-thread watchdog occurs before
useful gameplay (only two frames); it is retained, not treated as an AI
behavior result. The same final staged scenario is rerun serially below.

## Measured behavior

In the initial natural mixed game, AIR's three-constructor crew is complete at
2:59 and the next fighter frame appears 0.70 seconds later. T1 converters
continue during the upgrade phase (four by 13:30). The first fusion completes
at 21:04.6; the T2 air plant frame appears at 21:18.6 with basic=0,
upgraded=6, pending=0. The strict 20-minute fusion target is missed (KI-436).

Initial first-mex ferry destinations were 63/64 elmos from the anchor; actual
constructor handovers were 147/148 elmos away. The protection run delivered a
Cortex constructor to Legion AIR 193 elmos from its first mex. Recoil's
256-elmo area unload is retained because the previous 96-elmo radius caused
repeated unload refusal (D-110); choosing a sampled destination does not force
an exact final coordinate.

The protection fixture supplies a geo, advanced mex, constructors and economy;
those early protection times do not represent autonomous economic timing. It
plans 17 geo pieces, starts geo walls at frame 2210 and completes the first at
2590. The observer sees repeated wall completions near that geo and owned
advanced mexes. Natural opponents also construct Cortex teeth and T2 walls.

## Checks and remaining limits

- 78 executable AngelScript production-policy tests pass (eleven new converter
  demand/queue cases). Existing mex, capacity and support cases remain green.
- Native base-layout geometry tests and 76 layout-ranking checks pass.
- Registered API/DLL parity: 241 used members, zero findings.
- Role documentation and invariant practice checks pass.
- Existing documentation links to missing hover documentation (KI-404) and
  unreachable sonar helper findings (KI-425) remain; no new link/API findings.

The old TECH global invariants remain strict. Mixed/fixture reports are FAIL,
not a clean regression result. Their occurrences are recorded under KI-427;
previous baseline failures do not prove the cause of every warning here.
In particular, removal of the idle defense spiral exposes `power.turret`
waits; INV-053 has not been silenced.

Save/reload, cramped-map coverage, disconnected-island delivery and contested
no-safe-landing paths need dedicated fixtures (KI-439). Named native adoption
and the landing safety mechanisms are implemented; the played evidence above
does not establish those untested lifecycle cases. No separate roster parser or
wall-geometry unit harness was added; those paths are covered by runtime
compilation, invariants and the observer scenarios listed here.

## Final natural regression and delivery correction

`d152-final-mixed/runs/20260930-193459` reaches 25.1 minutes on build 09,
with all then-current expansion expectations seen and no new INV-083–087.
The strict overall report remains FAIL on TECH invariants. Fusion finishes
at 21:47.0; the T2 lab frame at 22:12.5 follows all six completed mex upgrades.
Legion receives its constructor 158 elmos from the first mex.

This run also exposes a distinct delivery race: Armada TECH creates its gift
before requesting a carrier, then donates at base (2,219 elmos from AIR's
first mex). Merely checking a logged target for the other ally missed it.
Final code now queues that gift, requests transport immediately and retains
it for up to 120 seconds for a known AIR provider. The observer check now
requires team 0's actual handover within 999 elmos in this scenario. The
subsequent final delivery run verifies this correction.

The final delivery run explicitly exercises the queue branch for both TECH
players. Cortex queues at frame 13530 and begins carrying at 13892; Armada
queues at 15269 and begins carrying at 16051. Actual handovers occur 216
and 182 elmos from the respective first-mex anchors. This verifies the race
correction with physical deliveries, not only request or destination logs.

Final rejudgment: `d152-delivery-final/runs/20260930-193930`, 25.1 minutes,
final build 09 and scripts. All seven expansion/delivery expectations are
seen. No script/crash or new INV-083 through INV-087 failures. Overall
**FAIL** remains: TECH INV-008 (6), INV-009 (1), INV-011 (13), INV-035 (1).
AIR has five T1 converters and all six completed mex upgrades by 16:00;
its T2 air-lab frame starts at 23:14.2 with no basic/unfinished mexes. Its
first fusion is still pending at 25 minutes in this sample. Thus the earlier
21:04 result is not a final timing guarantee, and KI-436 remains open.
The final build's converter guards and cached fortification access also
compile and execute in this run. All owned simulation engines are stopped.
