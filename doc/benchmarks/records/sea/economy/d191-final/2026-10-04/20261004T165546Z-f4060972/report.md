# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 25.1 min (frame 45217); wall 158 s
- DLL: build-theatres\d191-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T13:53:05
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-final\supreme\20261004T165304Z-72ac997f\runs\20261004T165546Z-f4060972\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:39.304244][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.7 min | `[t=00:00:56.863982][f=0003050] [SeaWatch] finished frame=3050 id=24564 def=armsy builder=28578` |
| expect `first-ship-exit` | **missing** (by 6 min) | |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Failures

- 'first-ship-exit' not seen by 6.0 min

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-final\supreme\20261004T165304Z-72ac997f\runs\20261004T165546Z-f4060972\screen_2026-10-04_16-54-21-728.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-final\supreme\20261004T165304Z-72ac997f\runs\20261004T165546Z-f4060972\screen_2026-10-04_16-54-42-716.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-final\supreme\20261004T165304Z-72ac997f\runs\20261004T165546Z-f4060972\screen_2026-10-04_16-55-24-480.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 25.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.19  [Playtest] finished armmex team 0 at 0.19 min
  0.20  [Team][Roster] first mex 6887 at 4608,11072
  0.20  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4775|11078|0|7|1|4608|11072
  0.80  [Playtest] finished armwin team 0 at 0.80 min
  0.92  [Playtest] finished armwin team 0 at 0.92 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.3 bank 1045/1050, energy +67.9 bank 1001/1001, units 4
  1.69  [Playtest] finished armsy team 0 at 1.69 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +4.3 bank 612/1150, energy +64.6 bank 708/1101, units 6
  2.71  [Playtest] finished armtide team 0 at 2.71 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +4.3 bank 233/1150, energy +109.9 bank 276/1301, units 11
  3.02  [Playtest] finished armtide team 0 at 3.02 min
  3.32  [Playtest] finished armtide team 0 at 3.32 min
  3.82  [Playtest] finished armtide team 0 at 3.82 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +4.3 bank 12/1150, energy +171.9 bank 1499/1501, units 15
  4.37  [Playtest] finished armtide team 0 at 4.37 min
  4.94  [Playtest] finished armtide team 0 at 4.94 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +4.3 bank 12/1150, energy +206.9 bank 1592/1601, units 16
  5.00  [Playtest] target team 0 at (4814, 11077) from its start position
  5.00  [Playtest] camera requested (4814,11077) height=2200
  5.00  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (4814, 11077)
  5.72  [Playtest] finished armtide team 0 at 5.72 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +4.3 bank 12/1150, energy +249.3 bank 1700/1701, units 19
  6.28  [Playtest] finished armtide team 0 at 6.28 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +4.3 bank 12/1150, energy +277.9 bank 1791/1801, units 21
  7.55  [Playtest] finished armfmkr team 0 at 7.55 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +5.3 bank 14/1150, energy +267.8 bank 1756/1801, units 22
  9.00  [Playtest] eco team 0 at 9.0 min: metal +5.3 bank 13/1150, energy +256.3 bank 1756/1801, units 22
  9.46  [Playtest] finished armfmkr team 0 at 9.46 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +6.3 bank 14/1150, energy +262.4 bank 1721/1801, units 23
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 11.00  [Playtest] eco team 0 at 11.0 min: metal +6.3 bank 13/1150, energy +253.7 bank 1721/1801, units 24
 11.42  [Playtest] finished armtide team 0 at 11.42 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +6.3 bank 13/1150, energy +266.9 bank 1791/1851, units 24
 13.00  [Playtest] eco team 0 at 13.0 min: metal +6.3 bank 361/1150, energy +265.4 bank 1791/1851, units 24
 14.00  [Playtest] eco team 0 at 14.0 min: metal +6.3 bank 739/1150, energy +297.3 bank 1791/1851, units 24
 15.00  [Playtest] eco team 0 at 15.0 min: metal +6.3 bank 737/1150, energy +299.0 bank 1791/1851, units 25
 16.00  [Playtest] eco team 0 at 16.0 min: metal +6.3 bank 921/1150, energy +287.1 bank 1776/1851, units 27
 17.00  [Playtest] eco team 0 at 17.0 min: metal +6.3 bank 911/1150, energy +279.4 bank 1778/1851, units 28
 18.00  [Playtest] eco team 0 at 18.0 min: metal +6.3 bank 877/1150, energy +292.3 bank 1791/1851, units 28
 19.00  [Playtest] eco team 0 at 19.0 min: metal +6.3 bank 815/1150, energy +295.2 bank 1791/1851, units 29
 20.00  [Playtest] eco team 0 at 20.0 min: metal +6.3 bank 898/1150, energy +295.1 bank 1778/1851, units 31
 20.00  [Playtest] camera requested (4814,11077) height=2200
 20.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (4814, 11077)
 21.00  [Playtest] eco team 0 at 21.0 min: metal +6.3 bank 902/1150, energy +295.7 bank 1770/1851, units 34
 22.00  [Playtest] eco team 0 at 22.0 min: metal +6.3 bank 885/1150, energy +298.5 bank 1791/1851, units 34
 23.00  [Playtest] eco team 0 at 23.0 min: metal +6.3 bank 883/1150, energy +297.3 bank 1791/1851, units 35
 24.00  [Playtest] eco team 0 at 24.0 min: metal +6.3 bank 822/1150, energy +298.9 bank 1791/1851, units 36
 25.00  [Playtest] eco team 0 at 25.0 min: metal +6.3 bank 760/1150, energy +287.1 bank 1791/1851, units 37
```

## Native lines (all AIs, first 120)

```
  0.52  RESERVE: zone 1 at (4792, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armwin at (4792, 11544) facing 2 (id 1)
  0.52  RESERVE: zone 2 at (4744, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armwin at (4744, 11544) facing 2 (id 2)
  0.52  RESERVE: zone 3 at (4696, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armwin at (4696, 11544) facing 2 (id 3)
  0.52  RESERVE: zone 4 at (4792, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armwin at (4792, 11496) facing 2 (id 4)
  0.52  RESERVE: zone 5 at (4744, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armwin at (4744, 11496) facing 2 (id 5)
  0.52  RESERVE: zone 6 at (4696, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armwin at (4696, 11496) facing 2 (id 6)
  0.52  RESERVE: zone 1 at (7416, 920) facing 0, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armwin at (7416, 920) facing 0 (id 1)
  0.52  RESERVE: zone 2 at (7464, 920) facing 0, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armwin at (7464, 920) facing 0 (id 2)
  0.52  RESERVE: zone 3 at (7512, 920) facing 0, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armwin at (7512, 920) facing 0 (id 3)
  0.52  RESERVE: zone 1 released
  0.52  RESERVE: zone 2 released
  0.52  RESERVE: zone 3 released
  0.52  RESERVE: zone 4 at (7400, 888) facing 0, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armwin at (7400, 888) facing 0 (id 4)
  0.52  RESERVE: zone 5 at (7448, 888) facing 0, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armwin at (7448, 888) facing 0 (id 5)
  0.52  RESERVE: zone 6 at (7496, 888) facing 0, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armwin at (7496, 888) facing 0 (id 6)
  0.52  RESERVE: zone 4 released
  0.52  RESERVE: zone 5 released
  0.52  RESERVE: zone 6 released
  0.52  RESERVE: zone 7 at (7400, 856) facing 0, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armwin at (7400, 856) facing 0 (id 7)
  0.52  RESERVE: zone 8 at (7448, 856) facing 0, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armwin at (7448, 856) facing 0 (id 8)
  0.52  RESERVE: zone 9 at (7496, 856) facing 0, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armwin at (7496, 856) facing 0 (id 9)
  0.52  RESERVE: zone 10 at (7400, 904) facing 0, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armwin at (7400, 904) facing 0 (id 10)
  0.52  RESERVE: zone 11 at (7448, 904) facing 0, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armwin at (7448, 904) facing 0 (id 11)
  0.52  RESERVE: zone 12 at (7496, 904) facing 0, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armwin at (7496, 904) facing 0 (id 12)
  0.52  RESERVE: served armwin at (4792, 11544) facing 2 (id 1, 5 of this def still held)
  0.52  RESERVE: served armwin at (7400, 856) facing 0 (id 7, 5 of this def still held)
  0.68  RESERVE: armwin at (4792, 11544) is being reclaimed: its slot will be freed (id 1)
  0.70  RESERVE: restored armwin at (4792, 11544) (id 1)
  0.70  RESERVE: served armwin at (4792, 11544) facing 2 (id 1, 5 of this def still held)
  0.74  RESERVE: served armwin at (7448, 856) facing 0 (id 8, 4 of this def still held)
  0.81  RESERVE: served armwin at (4744, 11544) facing 2 (id 2, 4 of this def still held)
  1.60  RESERVE: zone 13 at (6472, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.60  RESERVE: armnanotcplat at (6472, 1512) facing 0 (id 13)
  1.60  RESERVE: zone 14 at (6520, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.60  RESERVE: armnanotcplat at (6520, 1512) facing 0 (id 14)
  1.60  RESERVE: zone 13 released
  1.60  RESERVE: zone 14 released
  1.60  RESERVE: zone 15 at (6408, 1528) facing 0, 3x3 cells: 9 of 9 held
  1.60  RESERVE: armnanotcplat at (6408, 1528) facing 0 (id 15)
  1.60  RESERVE: zone 16 at (6456, 1528) facing 0, 3x3 cells: 9 of 9 held
  1.60  RESERVE: armnanotcplat at (6456, 1528) facing 0 (id 16)
  1.60  RESERVE: zone 17 at (6504, 1528) facing 0, 3x3 cells: 9 of 9 held
  1.60  RESERVE: armnanotcplat at (6504, 1528) facing 0 (id 17)
  1.60  RESERVE: zone 15 released
  1.60  RESERVE: zone 16 released
  1.60  RESERVE: zone 17 released
  1.60  RESERVE: zone 18 at (6328, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.60  RESERVE: armnanotcplat at (6328, 1512) facing 0 (id 18)
  1.60  RESERVE: zone 19 at (6376, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.60  RESERVE: armnanotcplat at (6376, 1512) facing 0 (id 19)
  1.60  RESERVE: zone 20 at (6424, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.60  RESERVE: armnanotcplat at (6424, 1512) facing 0 (id 20)
  1.60  RESERVE: zone 21 at (6472, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.60  RESERVE: armnanotcplat at (6472, 1512) facing 0 (id 21)
  1.60  RESERVE: zone 22 at (6520, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.60  RESERVE: armnanotcplat at (6520, 1512) facing 0 (id 22)
  1.60  RESERVE: zone 23 at (6328, 1560) facing 0, 3x3 cells: 9 of 9 held
  1.60  RESERVE: armnanotcplat at (6328, 1560) facing 0 (id 23)
  1.60  RESERVE: zone 18 released
  1.60  RESERVE: zone 19 released
  1.60  RESERVE: zone 20 released
  1.60  RESERVE: zone 21 released
  1.60  RESERVE: zone 22 released
  1.60  RESERVE: zone 23 released
  1.60  RESERVE: zone 24 at (6264, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.60  RESERVE: armnanotcplat at (6264, 1464) facing 0 (id 24)
  1.60  RESERVE: zone 25 at (6312, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.60  RESERVE: armnanotcplat at (6312, 1464) facing 0 (id 25)
  1.60  RESERVE: zone 26 at (6360, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.60  RESERVE: armnanotcplat at (6360, 1464) facing 0 (id 26)
  1.60  RESERVE: zone 27 at (6408, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.60  RESERVE: armnanotcplat at (6408, 1464) facing 0 (id 27)
  1.60  RESERVE: zone 28 at (6456, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.60  RESERVE: armnanotcplat at (6456, 1464) facing 0 (id 28)
  1.60  RESERVE: zone 29 at (6264, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.60  RESERVE: armnanotcplat at (6264, 1512) facing 0 (id 29)
  1.60  RESERVE: zone 30 at (6312, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.60  RESERVE: armnanotcplat at (6312, 1512) facing 0 (id 30)
  1.60  RESERVE: zone 31 at (6360, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.60  RESERVE: armnanotcplat at (6360, 1512) facing 0 (id 31)
  1.60  RESERVE: zone 32 at (6408, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.60  RESERVE: armnanotcplat at (6408, 1512) facing 0 (id 32)
  1.60  RESERVE: zone 33 at (6456, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.60  RESERVE: armnanotcplat at (6456, 1512) facing 0 (id 33)
  1.60  RESERVE: zone 34 at (6264, 1560) facing 0, 3x3 cells: 9 of 9 held
  1.60  RESERVE: armnanotcplat at (6264, 1560) facing 0 (id 34)
  1.60  RESERVE: zone 35 at (6312, 1560) facing 0, 3x3 cells: 9 of 9 held
  1.60  RESERVE: armnanotcplat at (6312, 1560) facing 0 (id 35)
  1.60  RESERVE: zone 24 released
  1.60  RESERVE: zone 25 released
  1.60  RESERVE: zone 26 released
  1.60  RESERVE: zone 27 released
  1.60  RESERVE: zone 28 released
  1.60  RESERVE: zone 29 released
  1.60  RESERVE: zone 30 released
  1.60  RESERVE: zone 31 released
  1.60  RESERVE: zone 32 released
  1.60  RESERVE: zone 33 released
  1.60  RESERVE: zone 34 released
  1.60  RESERVE: zone 35 released
  1.60  RESERVE: zone 36 at (6216, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.60  RESERVE: armnanotcplat at (6216, 1416) facing 0 (id 36)
```
