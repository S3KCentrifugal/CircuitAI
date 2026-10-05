# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 6.2 min (frame 11124); wall 74 s
- DLL: build-theatres\d188-build-6\SkirmishAI.dll (ac71826721992d84); AI BARbTest/test; staged 2026-10-04T01:48:22
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\supreme\20261004T044821Z-cd9ec9fa\runs\20261004T044939Z-a1a36d16\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:37.897660][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.3 min | `[t=00:00:51.077654][f=0002375] [SeaWatch] finished frame=2375 id=18785 def=armsy builder=15307` |
| expect `first-ship-exit` | **missing** (by 6 min) | |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Failures

- 'first-ship-exit' not seen by 6.0 min

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\supreme\20261004T044821Z-cd9ec9fa\runs\20261004T044939Z-a1a36d16\screen_2026-10-04_04-49-32-790.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 31
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 31
  0.19  [Playtest] finished armmex team 0 at 0.19 min
  0.20  [Team][Roster] first mex 5388 at 4608,11072
  0.20  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4775|11078|0|7|1|4608|11072
  0.38  [Playtest] finished armmex team 0 at 0.38 min
  0.49  [Playtest] finished armwin team 0 at 0.49 min
  0.60  [Playtest] finished armwin team 0 at 0.60 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 1100/1100, energy +66.6 bank 1001/1001, units 5
  1.32  [Playtest] finished armsy team 0 at 1.32 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.6 bank 666/1200, energy +74.6 bank 87/1151, units 9
  2.53  [Playtest] finished armtide team 0 at 2.53 min
  2.89  [Playtest] finished armtide team 0 at 2.89 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.6 bank 251/1200, energy +105.0 bank 83/1301, units 14
  3.20  [Playtest] finished armtide team 0 at 3.20 min
  3.23  [Playtest] finished armtide team 0 at 3.23 min
  3.51  [Playtest] finished armmex team 0 at 3.51 min
  3.55  [Playtest] finished armtide team 0 at 3.55 min
  3.86  [Playtest] finished armtide team 0 at 3.86 min
  3.92  [Playtest] finished armmex team 0 at 3.92 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.9 bank 14/1300, energy +178.1 bank 1493/1501, units 20
  4.18  [Playtest] finished armmex team 0 at 4.18 min
  4.26  [Playtest] finished armtide team 0 at 4.26 min
  4.35  [Playtest] finished armtide team 0 at 4.35 min
  4.48  [Playtest] finished armmex team 0 at 4.48 min
  4.53  [Playtest] finished armtide team 0 at 4.53 min
  4.76  [Playtest] finished armfmkr team 0 at 4.76 min
  4.88  [Playtest] finished armmex team 0 at 4.88 min
  4.96  [Playtest] finished armfmkr team 0 at 4.96 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +19.3 bank 106/1450, energy +247.9 bank 1325/1651, units 27
  5.00  [Playtest] target team 0 at (4814, 11077) from its start position
  5.00  [Playtest] camera requested (4814,11077) height=2200
  5.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (4814, 11077)
  5.21  [Playtest] finished armtide team 0 at 5.21 min
  5.29  [Playtest] finished armmex team 0 at 5.29 min
  5.51  [Playtest] finished armtide team 0 at 5.51 min
  5.60  [Playtest] finished armmex team 0 at 5.60 min
  5.71  [Playtest] finished armfmkr team 0 at 5.71 min
  5.88  [Playtest] finished armmex team 0 at 5.88 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +24.2 bank 241/1600, energy +316.1 bank 488/1801, units 38
  6.04  [Playtest] finished armllt team 0 at 6.04 min
  6.06  [Playtest] finished armnanotcplat team 0 at 6.06 min
  6.14  [Playtest] finished armtide team 0 at 6.14 min
  6.18  [Playtest] finished armtide team 0 at 6.18 min
  6.18  [Playtest] finished armrad team 0 at 6.18 min
```

## Native lines (all AIs, first 120)

```
  1.65  BUILDER: discarded 1 unused default task(s) in the last minute
  1.67  BUILDER: discarded 1 unused default task(s) in the last minute
  2.65  BUILDER: discarded 1 unused default task(s) in the last minute
  2.67  BUILDER: discarded 1 unused default task(s) in the last minute
  3.66  BUILDER: discarded 3 unused default task(s) in the last minute
  4.66  BUILDER: discarded 1 unused default task(s) in the last minute
  4.76  BUILDER: discarded 1 unused default task(s) in the last minute
  5.71  BUILDER: discarded 1 unused default task(s) in the last minute
  5.77  BUILDER: discarded 34 unused default task(s) in the last minute
```
