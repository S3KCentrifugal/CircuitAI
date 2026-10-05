# Playtest report: PASS

- Verdict: **PASS** (reached 12 min)
- Game time reached: 12.2 min (frame 21930); wall 93 s
- DLL: build-theatres\d191-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T13:38:31
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-compact\supreme\20261004T163830Z-16a7e190\runs\20261004T164006Z-368ab930\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:31.951357][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.9 min | `[t=00:00:48.176633][f=0003485] [SeaWatch] finished frame=3485 id=5358 def=armsy builder=1433` |
| expect `first-ship-exit` | seen at 3.1 min | `[t=00:00:53.019355][f=0005640] [SeaWatch] egress id=5194 yard=5358 seconds=4.8 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-compact\supreme\20261004T163830Z-16a7e190\runs\20261004T164006Z-368ab930\screen_2026-10-04_16-39-35-602.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-compact\supreme\20261004T163830Z-16a7e190\runs\20261004T164006Z-368ab930\screen_2026-10-04_16-39-56-577.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 12.5 min
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
  0.20  [Playtest] finished armmex team 0 at 0.20 min
  0.22  [Team][Roster] first mex 6311 at 4608,11072
  0.22  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4773|11078|0|7|1|4608|11072
  0.81  [Playtest] finished armwin team 0 at 0.81 min
  0.91  [Playtest] finished armwin team 0 at 0.91 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.3 bank 1019/1050, energy +42.6 bank 989/1001, units 5
  1.04  [Playtest] finished armwin team 0 at 1.04 min
  1.16  [Playtest] finished armwin team 0 at 1.16 min
  1.94  [Playtest] finished armsy team 0 at 1.94 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +4.3 bank 672/1150, energy +90.5 bank 1087/1102, units 8
  3.00  [Playtest] eco team 0 at 3.0 min: metal +4.3 bank 425/1150, energy +119.3 bank 1198/1202, units 10
  4.00  [Playtest] eco team 0 at 4.0 min: metal +4.3 bank 206/1150, energy +111.4 bank 1198/1202, units 13
  5.00  [Playtest] eco team 0 at 5.0 min: metal +4.3 bank 13/1150, energy +50.5 bank 1195/1202, units 15
  5.00  [Playtest] target team 0 at (4814, 11077) from its start position
  5.00  [Playtest] camera requested (4814,11077) height=2200
  5.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (4814, 11077)
  6.00  [Playtest] eco team 0 at 6.0 min: metal +4.3 bank 13/1150, energy +101.8 bank 1192/1202, units 15
  7.00  [Playtest] eco team 0 at 7.0 min: metal +4.3 bank 13/1150, energy +89.7 bank 1192/1202, units 15
  8.00  [Playtest] eco team 0 at 8.0 min: metal +4.3 bank 13/1150, energy +75.6 bank 1198/1202, units 16
  9.00  [Playtest] eco team 0 at 9.0 min: metal +4.3 bank 13/1150, energy +119.4 bank 1192/1202, units 16
 10.00  [Playtest] eco team 0 at 10.0 min: metal +4.3 bank 12/1150, energy +98.3 bank 1192/1202, units 16
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 11.00  [Playtest] eco team 0 at 11.0 min: metal +4.3 bank 104/1150, energy +89.4 bank 1202/1202, units 16
 12.00  [Playtest] eco team 0 at 12.0 min: metal +4.3 bank 362/1150, energy +108.9 bank 1202/1202, units 16
```

## Native lines (all AIs, first 120)

```
  0.53  RESERVE: zone 1 at (4792, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (4792, 11544) facing 2 (id 1)
  0.53  RESERVE: zone 2 at (4744, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (4744, 11544) facing 2 (id 2)
  0.53  RESERVE: zone 3 at (4696, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (4696, 11544) facing 2 (id 3)
  0.53  RESERVE: zone 4 at (4792, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (4792, 11496) facing 2 (id 4)
  0.53  RESERVE: zone 5 at (4744, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (4744, 11496) facing 2 (id 5)
  0.53  RESERVE: zone 6 at (4696, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (4696, 11496) facing 2 (id 6)
  0.53  RESERVE: zone 1 at (7416, 920) facing 0, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (7416, 920) facing 0 (id 1)
  0.53  RESERVE: zone 2 at (7464, 920) facing 0, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (7464, 920) facing 0 (id 2)
  0.53  RESERVE: zone 3 at (7512, 920) facing 0, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (7512, 920) facing 0 (id 3)
  0.53  RESERVE: zone 1 released
  0.53  RESERVE: zone 2 released
  0.53  RESERVE: zone 3 released
  0.53  RESERVE: zone 4 at (7400, 888) facing 0, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (7400, 888) facing 0 (id 4)
  0.53  RESERVE: zone 5 at (7448, 888) facing 0, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (7448, 888) facing 0 (id 5)
  0.53  RESERVE: zone 6 at (7496, 888) facing 0, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (7496, 888) facing 0 (id 6)
  0.53  RESERVE: zone 4 released
  0.53  RESERVE: zone 5 released
  0.53  RESERVE: zone 6 released
  0.53  RESERVE: zone 7 at (7400, 856) facing 0, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (7400, 856) facing 0 (id 7)
  0.53  RESERVE: zone 8 at (7448, 856) facing 0, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (7448, 856) facing 0 (id 8)
  0.53  RESERVE: zone 9 at (7496, 856) facing 0, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (7496, 856) facing 0 (id 9)
  0.53  RESERVE: zone 10 at (7400, 904) facing 0, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (7400, 904) facing 0 (id 10)
  0.53  RESERVE: zone 11 at (7448, 904) facing 0, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (7448, 904) facing 0 (id 11)
  0.53  RESERVE: zone 12 at (7496, 904) facing 0, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (7496, 904) facing 0 (id 12)
  0.53  RESERVE: served armwin at (4792, 11544) facing 2 (id 1, 5 of this def still held)
  0.53  RESERVE: served armwin at (7400, 856) facing 0 (id 7, 5 of this def still held)
  0.69  RESERVE: armwin at (4792, 11544) is being reclaimed: its slot will be freed (id 1)
  0.71  RESERVE: restored armwin at (4792, 11544) (id 1)
  0.71  RESERVE: served armwin at (4792, 11544) facing 2 (id 1, 5 of this def still held)
  0.75  RESERVE: served armwin at (7448, 856) facing 0 (id 8, 4 of this def still held)
  0.82  RESERVE: served armwin at (4744, 11544) facing 2 (id 2, 4 of this def still held)
  0.86  RESERVE: served armwin at (7496, 856) facing 0 (id 9, 3 of this def still held)
  0.93  RESERVE: served armwin at (4696, 11544) facing 2 (id 3, 3 of this def still held)
  0.97  RESERVE: served armwin at (7400, 904) facing 0 (id 10, 2 of this def still held)
  1.06  RESERVE: served armwin at (4792, 11496) facing 2 (id 4, 2 of this def still held)
  1.83  RESERVE: zone 13 at (6488, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.83  RESERVE: armnanotcplat at (6488, 1544) facing 0 (id 13)
  1.83  RESERVE: zone 14 at (6536, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.83  RESERVE: armnanotcplat at (6536, 1544) facing 0 (id 14)
  1.83  RESERVE: zone 15 at (6584, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.83  RESERVE: armnanotcplat at (6584, 1544) facing 0 (id 15)
  1.83  RESERVE: zone 16 at (6632, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.83  RESERVE: armnanotcplat at (6632, 1544) facing 0 (id 16)
  1.83  RESERVE: zone 13 released
  1.83  RESERVE: zone 14 released
  1.83  RESERVE: zone 15 released
  1.83  RESERVE: zone 16 released
  1.83  RESERVE: zone 17 at (6424, 1560) facing 0, 3x3 cells: 9 of 9 held
  1.83  RESERVE: armnanotcplat at (6424, 1560) facing 0 (id 17)
  1.83  RESERVE: zone 18 at (6472, 1560) facing 0, 3x3 cells: 9 of 9 held
  1.83  RESERVE: armnanotcplat at (6472, 1560) facing 0 (id 18)
  1.83  RESERVE: zone 19 at (6520, 1560) facing 0, 3x3 cells: 9 of 9 held
  1.83  RESERVE: armnanotcplat at (6520, 1560) facing 0 (id 19)
  1.83  RESERVE: zone 20 at (6568, 1560) facing 0, 3x3 cells: 9 of 9 held
  1.83  RESERVE: armnanotcplat at (6568, 1560) facing 0 (id 20)
  1.83  RESERVE: zone 21 at (6616, 1560) facing 0, 3x3 cells: 9 of 9 held
  1.83  RESERVE: armnanotcplat at (6616, 1560) facing 0 (id 21)
  1.83  RESERVE: zone 17 released
  1.83  RESERVE: zone 18 released
  1.83  RESERVE: zone 19 released
  1.83  RESERVE: zone 20 released
  1.83  RESERVE: zone 21 released
  1.83  RESERVE: zone 22 at (6344, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.83  RESERVE: armnanotcplat at (6344, 1544) facing 0 (id 22)
  1.83  RESERVE: zone 23 at (6392, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.83  RESERVE: armnanotcplat at (6392, 1544) facing 0 (id 23)
  1.83  RESERVE: zone 24 at (6440, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.83  RESERVE: armnanotcplat at (6440, 1544) facing 0 (id 24)
  1.83  RESERVE: zone 25 at (6488, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.83  RESERVE: armnanotcplat at (6488, 1544) facing 0 (id 25)
  1.83  RESERVE: zone 26 at (6536, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.83  RESERVE: armnanotcplat at (6536, 1544) facing 0 (id 26)
  1.83  RESERVE: zone 27 at (6344, 1592) facing 0, 3x3 cells: 9 of 9 held
  1.83  RESERVE: armnanotcplat at (6344, 1592) facing 0 (id 27)
  1.83  RESERVE: zone 22 released
  1.83  RESERVE: zone 23 released
  1.83  RESERVE: zone 24 released
  1.83  RESERVE: zone 25 released
  1.83  RESERVE: zone 26 released
  1.83  RESERVE: zone 27 released
  1.83  RESERVE: zone 28 at (6280, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.83  RESERVE: armnanotcplat at (6280, 1496) facing 0 (id 28)
  1.83  RESERVE: zone 29 at (6328, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.83  RESERVE: armnanotcplat at (6328, 1496) facing 0 (id 29)
  1.83  RESERVE: zone 30 at (6376, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.83  RESERVE: armnanotcplat at (6376, 1496) facing 0 (id 30)
  1.83  RESERVE: zone 31 at (6424, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.83  RESERVE: armnanotcplat at (6424, 1496) facing 0 (id 31)
  1.83  RESERVE: zone 32 at (6472, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.83  RESERVE: armnanotcplat at (6472, 1496) facing 0 (id 32)
  1.83  RESERVE: zone 33 at (6280, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.83  RESERVE: armnanotcplat at (6280, 1544) facing 0 (id 33)
  1.83  RESERVE: zone 34 at (6328, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.83  RESERVE: armnanotcplat at (6328, 1544) facing 0 (id 34)
  1.83  RESERVE: zone 35 at (6376, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.83  RESERVE: armnanotcplat at (6376, 1544) facing 0 (id 35)
  1.83  RESERVE: zone 36 at (6424, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.83  RESERVE: armnanotcplat at (6424, 1544) facing 0 (id 36)
  1.83  RESERVE: zone 37 at (6472, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.83  RESERVE: armnanotcplat at (6472, 1544) facing 0 (id 37)
  1.83  RESERVE: zone 38 at (6280, 1592) facing 0, 3x3 cells: 9 of 9 held
  1.83  RESERVE: armnanotcplat at (6280, 1592) facing 0 (id 38)
```
