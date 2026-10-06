# Playtest report: FAIL

- Verdict: **FAIL** (engine exited at 2.7 min)
- Game time reached: 2.7 min (frame 4870); wall 316 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (8f86a21003fa1cb7); AI BARbTest/test; staged 2026-10-05T21:58:04
- Map: Shore_to_Shore_V3; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=SEA/cortex/test, 9=SEA/legion/test, 10=SEA/armada/test, 11=SEA/cortex/test, 12=SEA/legion/test, 13=SEA/armada/test, 14=SEA/cortex/test, 15=SEA/legion/test
- Team 0 (under test): skirmish AI None, role SEA
- Checks: sea-production-8v8.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\production-8v8\shore\20261006T005803Z-c4f5560d\runs\20261006T010330Z-8370d1c0\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:29.625715][f=-000001] [SeaRecoveryTest] loaded teams=16 fixture=false` |
| expect `sub-scaling` | **missing** (by 30 min) | |
| forbid `errors` | clean |  |

## Screenshots

- none

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 20, 4 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (1600, 600) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (1600, 1200) units 1
  0.00  [Playtest] frame 1 team 2 ally 0 side cortex ai true dead false start (1600, 1800) units 1
  0.00  [Playtest] frame 1 team 3 ally 0 side legion ai true dead false start (1600, 2400) units 1
  0.00  [Playtest] frame 1 team 4 ally 0 side armada ai true dead false start (2800, 600) units 1
  0.00  [Playtest] frame 1 team 5 ally 0 side cortex ai true dead false start (2800, 1200) units 1
  0.00  [Playtest] frame 1 team 6 ally 0 side legion ai true dead false start (2800, 1800) units 1
  0.00  [Playtest] frame 1 team 7 ally 0 side armada ai true dead false start (2800, 2400) units 1
  0.00  [Playtest] frame 1 team 8 ally 1 side cortex ai true dead false start (13750, 600) units 1
  0.00  [Playtest] frame 1 team 9 ally 1 side legion ai true dead false start (13750, 1200) units 1
  0.00  [Playtest] frame 1 team 10 ally 1 side armada ai true dead false start (13750, 1800) units 1
  0.00  [Playtest] frame 1 team 11 ally 1 side cortex ai true dead false start (13750, 2400) units 1
  0.00  [Playtest] frame 1 team 12 ally 1 side legion ai true dead false start (12550, 600) units 1
  0.00  [Playtest] frame 1 team 13 ally 1 side armada ai true dead false start (12550, 1200) units 1
  0.00  [Playtest] frame 1 team 14 ally 1 side cortex ai true dead false start (12550, 1800) units 1
  0.00  [Playtest] frame 1 team 15 ally 1 side legion ai true dead false start (12550, 2400) units 1
  0.00  [Playtest] frame 1 team 16 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 17 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 20
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (1600, 600) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (1600, 1200) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (1600, 1800) units 1
  0.05  [Playtest] frame 90 team 3 ally 0 side legion ai true dead false start (1600, 2400) units 1
  0.05  [Playtest] frame 90 team 4 ally 0 side armada ai true dead false start (2800, 600) units 1
  0.05  [Playtest] frame 90 team 5 ally 0 side cortex ai true dead false start (2800, 1200) units 1
  0.05  [Playtest] frame 90 team 6 ally 0 side legion ai true dead false start (2800, 1800) units 1
  0.05  [Playtest] frame 90 team 7 ally 0 side armada ai true dead false start (2800, 2400) units 1
  0.05  [Playtest] frame 90 team 8 ally 1 side cortex ai true dead false start (13750, 600) units 1
  0.05  [Playtest] frame 90 team 9 ally 1 side legion ai true dead false start (13750, 1200) units 1
  0.05  [Playtest] frame 90 team 10 ally 1 side armada ai true dead false start (13750, 1800) units 1
  0.05  [Playtest] frame 90 team 11 ally 1 side cortex ai true dead false start (13750, 2400) units 1
  0.05  [Playtest] frame 90 team 12 ally 1 side legion ai true dead false start (12550, 600) units 1
  0.05  [Playtest] frame 90 team 13 ally 1 side armada ai true dead false start (12550, 1200) units 1
  0.05  [Playtest] frame 90 team 14 ally 1 side cortex ai true dead false start (12550, 1800) units 1
  0.05  [Playtest] frame 90 team 15 ally 1 side legion ai true dead false start (12550, 2400) units 1
  0.05  [Playtest] frame 90 team 16 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 17 ally 3 side  ai false dead false start (0, 0) units 0
  0.24  [Playtest] finished armmex team 0 at 0.24 min
  0.50  [Playtest] finished armmex team 0 at 0.50 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.1 bank 1090/1100, energy +30.0 bank 933/1000, units 4
  1.02  [Playtest] finished armmex team 0 at 1.02 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.1 bank 650/650, energy +0.0 bank 486/500, units 3
```

## Native lines (all AIs, first 120)

```
  1.00  BUILDER: discarded 3 unused default task(s) in the last minute
  1.00  BUILDER: discarded 2 unused default task(s) in the last minute
  1.00  BUILDER: discarded 9 unused default task(s) in the last minute
  1.00  BUILDER: discarded 3 unused default task(s) in the last minute
  1.10  BUILDER: discarded 2 unused default task(s) in the last minute
```
