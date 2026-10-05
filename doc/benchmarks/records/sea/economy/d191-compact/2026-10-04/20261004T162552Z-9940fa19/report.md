# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 6.1 min (frame 10920); wall 73 s
- DLL: build-theatres\d191-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T13:24:36
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-compact\supreme\20261004T162435Z-0110d95e\runs\20261004T162552Z-9940fa19\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:38.720911][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.7 min | `[t=00:00:53.338355][f=0003095] [SeaWatch] finished frame=3095 id=17664 def=armsy builder=1433` |
| expect `first-ship-exit` | **missing** (by 6 min) | |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Failures

- 'first-ship-exit' not seen by 6.0 min

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-compact\supreme\20261004T162435Z-0110d95e\runs\20261004T162552Z-9940fa19\screen_2026-10-04_16-25-46-878.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 20.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 36
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 36
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.19  [Playtest] finished armmex team 0 at 0.19 min
  0.20  [Team][Roster] first mex 6311 at 4608,11072
  0.20  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4775|11078|0|7|1|4608|11072
  0.82  [Playtest] finished armwin team 0 at 0.82 min
  0.94  [Playtest] finished armwin team 0 at 0.94 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.3 bank 1037/1050, energy +65.4 bank 1001/1001, units 4
  1.72  [Playtest] finished armsy team 0 at 1.72 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +4.3 bank 617/1150, energy +52.0 bank 644/1101, units 6
  2.61  [Playtest] finished armtide team 0 at 2.61 min
  2.95  [Playtest] finished armtide team 0 at 2.95 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +4.3 bank 207/1150, energy +108.6 bank 211/1301, units 11
  3.32  [Playtest] finished armtide team 0 at 3.32 min
  3.65  [Playtest] finished armtide team 0 at 3.65 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +4.3 bank 0/1150, energy +158.5 bank 1399/1401, units 15
  4.00  [Playtest] finished armtide team 0 at 4.00 min
  4.35  [Playtest] finished armtide team 0 at 4.35 min
  4.70  [Playtest] finished armtide team 0 at 4.70 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +4.3 bank 0/1150, energy +228.6 bank 1550/1551, units 18
  5.00  [Playtest] target team 0 at (4814, 11077) from its start position
  5.00  [Playtest] camera requested (4814,11077) height=2200
  5.00  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (4814, 11077)
  5.05  [Playtest] finished armtide team 0 at 5.05 min
  5.39  [Playtest] finished armtide team 0 at 5.39 min
  5.81  [Playtest] finished armfmkr team 0 at 5.81 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +5.3 bank 13/1150, energy +269.9 bank 1616/1651, units 22
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
  0.55  RESERVE: served armwin at (4792, 11544) facing 2 (id 1, 5 of this def still held)
  0.55  RESERVE: served armwin at (7400, 856) facing 0 (id 7, 5 of this def still held)
  0.71  RESERVE: armwin at (4792, 11544) is being reclaimed: its slot will be freed (id 1)
  0.73  RESERVE: restored armwin at (4792, 11544) (id 1)
  0.73  RESERVE: served armwin at (4792, 11544) facing 2 (id 1, 5 of this def still held)
  0.78  RESERVE: served armwin at (7448, 856) facing 0 (id 8, 4 of this def still held)
  0.84  RESERVE: served armwin at (4744, 11544) facing 2 (id 2, 4 of this def still held)
  1.63  RESERVE: zone 13 at (6488, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6488, 1544) facing 0 (id 13)
  1.63  RESERVE: zone 14 at (6536, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6536, 1544) facing 0 (id 14)
  1.63  RESERVE: zone 15 at (6584, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6584, 1544) facing 0 (id 15)
  1.63  RESERVE: zone 16 at (6632, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6632, 1544) facing 0 (id 16)
  1.63  RESERVE: zone 13 released
  1.63  RESERVE: zone 14 released
  1.63  RESERVE: zone 15 released
  1.63  RESERVE: zone 16 released
  1.63  RESERVE: zone 17 at (6424, 1560) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6424, 1560) facing 0 (id 17)
  1.63  RESERVE: zone 18 at (6472, 1560) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6472, 1560) facing 0 (id 18)
  1.63  RESERVE: zone 19 at (6520, 1560) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6520, 1560) facing 0 (id 19)
  1.63  RESERVE: zone 20 at (6568, 1560) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6568, 1560) facing 0 (id 20)
  1.63  RESERVE: zone 21 at (6616, 1560) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6616, 1560) facing 0 (id 21)
  1.63  RESERVE: zone 17 released
  1.63  RESERVE: zone 18 released
  1.63  RESERVE: zone 19 released
  1.63  RESERVE: zone 20 released
  1.63  RESERVE: zone 21 released
  1.63  RESERVE: zone 22 at (6344, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6344, 1544) facing 0 (id 22)
  1.63  RESERVE: zone 23 at (6392, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6392, 1544) facing 0 (id 23)
  1.63  RESERVE: zone 24 at (6440, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6440, 1544) facing 0 (id 24)
  1.63  RESERVE: zone 25 at (6488, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6488, 1544) facing 0 (id 25)
  1.63  RESERVE: zone 26 at (6536, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6536, 1544) facing 0 (id 26)
  1.63  RESERVE: zone 27 at (6344, 1592) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6344, 1592) facing 0 (id 27)
  1.63  RESERVE: zone 22 released
  1.63  RESERVE: zone 23 released
  1.63  RESERVE: zone 24 released
  1.63  RESERVE: zone 25 released
  1.63  RESERVE: zone 26 released
  1.63  RESERVE: zone 27 released
  1.63  RESERVE: zone 28 at (6280, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6280, 1496) facing 0 (id 28)
  1.63  RESERVE: zone 29 at (6328, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6328, 1496) facing 0 (id 29)
  1.63  RESERVE: zone 30 at (6376, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6376, 1496) facing 0 (id 30)
  1.63  RESERVE: zone 31 at (6424, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6424, 1496) facing 0 (id 31)
  1.63  RESERVE: zone 32 at (6472, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6472, 1496) facing 0 (id 32)
  1.63  RESERVE: zone 33 at (6280, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6280, 1544) facing 0 (id 33)
  1.63  RESERVE: zone 34 at (6328, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6328, 1544) facing 0 (id 34)
  1.63  RESERVE: zone 35 at (6376, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6376, 1544) facing 0 (id 35)
  1.63  RESERVE: zone 36 at (6424, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6424, 1544) facing 0 (id 36)
  1.63  RESERVE: zone 37 at (6472, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6472, 1544) facing 0 (id 37)
  1.63  RESERVE: zone 38 at (6280, 1592) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6280, 1592) facing 0 (id 38)
  1.63  RESERVE: zone 39 at (6328, 1592) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6328, 1592) facing 0 (id 39)
  1.63  RESERVE: zone 28 released
  1.63  RESERVE: zone 29 released
```
