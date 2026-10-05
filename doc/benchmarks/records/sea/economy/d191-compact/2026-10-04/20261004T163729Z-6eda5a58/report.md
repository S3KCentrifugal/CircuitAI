# Playtest report: PASS

- Verdict: **PASS** (reached 25 min)
- Game time reached: 25.2 min (frame 45391); wall 148 s
- DLL: build-theatres\d191-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T13:34:58
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-compact\supreme\20261004T163458Z-5095af99\runs\20261004T163729Z-6eda5a58\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:33.303030][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.8 min | `[t=00:00:48.344086][f=0003275] [SeaWatch] finished frame=3275 id=6612 def=armsy builder=1433` |
| expect `first-ship-exit` | seen at 3.5 min | `[t=00:00:55.265353][f=0006390] [SeaWatch] egress id=5194 yard=6612 seconds=4.6 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-compact\supreme\20261004T163458Z-5095af99\runs\20261004T163729Z-6eda5a58\screen_2026-10-04_16-36-04-259.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-compact\supreme\20261004T163458Z-5095af99\runs\20261004T163729Z-6eda5a58\screen_2026-10-04_16-36-25-263.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-compact\supreme\20261004T163458Z-5095af99\runs\20261004T163729Z-6eda5a58\screen_2026-10-04_16-37-07-482.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 25.5 min
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
  0.22  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4774|11078|0|7|1|4608|11072
  0.81  [Playtest] finished armwin team 0 at 0.81 min
  0.91  [Playtest] finished armwin team 0 at 0.91 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.3 bank 1019/1050, energy +55.1 bank 995/1001, units 5
  1.04  [Playtest] finished armwin team 0 at 1.04 min
  1.82  [Playtest] finished armsy team 0 at 1.82 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +4.3 bank 642/1150, energy +79.0 bank 940/1101, units 7
  3.00  [Playtest] eco team 0 at 3.0 min: metal +4.3 bank 349/1150, energy +101.0 bank 1189/1201, units 10
  4.00  [Playtest] eco team 0 at 4.0 min: metal +4.3 bank 13/1150, energy +76.7 bank 894/1201, units 13
  5.00  [Playtest] eco team 0 at 5.0 min: metal +4.3 bank 12/1150, energy +76.4 bank 1193/1201, units 14
  5.00  [Playtest] target team 0 at (4814, 11077) from its start position
  5.00  [Playtest] camera requested (4814,11077) height=2200
  5.00  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (4814, 11077)
  6.00  [Playtest] eco team 0 at 6.0 min: metal +4.3 bank 12/1150, energy +100.4 bank 1198/1201, units 15
  7.00  [Playtest] eco team 0 at 7.0 min: metal +4.3 bank 12/1150, energy +101.0 bank 1188/1201, units 15
  8.00  [Playtest] eco team 0 at 8.0 min: metal +4.3 bank 13/1150, energy +101.0 bank 1198/1201, units 16
  9.00  [Playtest] eco team 0 at 9.0 min: metal +4.3 bank 12/1150, energy +96.2 bank 1193/1201, units 16
 10.00  [Playtest] eco team 0 at 10.0 min: metal +4.3 bank 12/1150, energy +100.6 bank 1198/1201, units 17
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 11.00  [Playtest] eco team 0 at 11.0 min: metal +4.3 bank 12/1150, energy +59.1 bank 1188/1201, units 17
 12.00  [Playtest] eco team 0 at 12.0 min: metal +4.3 bank 267/1150, energy +64.7 bank 1201/1201, units 17
 13.00  [Playtest] eco team 0 at 13.0 min: metal +4.3 bank 525/1150, energy +101.0 bank 1201/1201, units 17
 14.00  [Playtest] eco team 0 at 14.0 min: metal +4.3 bank 783/1150, energy +67.7 bank 1201/1201, units 17
 15.00  [Playtest] eco team 0 at 15.0 min: metal +4.3 bank 892/1150, energy +73.2 bank 1201/1201, units 18
 16.00  [Playtest] eco team 0 at 16.0 min: metal +4.3 bank 852/1150, energy +63.3 bank 856/1201, units 20
 17.00  [Playtest] eco team 0 at 17.0 min: metal +4.3 bank 908/1150, energy +83.9 bank 1201/1201, units 21
 18.00  [Playtest] eco team 0 at 18.0 min: metal +4.3 bank 460/1150, energy +75.8 bank 266/1201, units 22
 19.00  [Playtest] eco team 0 at 19.0 min: metal +4.3 bank 545/1150, energy +88.8 bank 1201/1201, units 22
 20.00  [Playtest] eco team 0 at 20.0 min: metal +4.3 bank 803/1150, energy +91.0 bank 1201/1201, units 22
 20.00  [Playtest] camera requested (4814,11077) height=2200
 20.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (4814, 11077)
 21.00  [Playtest] eco team 0 at 21.0 min: metal +4.3 bank 681/1150, energy +85.0 bank 1201/1201, units 23
 22.00  [Playtest] eco team 0 at 22.0 min: metal +4.3 bank 920/1150, energy +101.0 bank 1178/1201, units 24
 23.00  [Playtest] eco team 0 at 23.0 min: metal +4.3 bank 402/1150, energy +100.5 bank 892/1201, units 24
 24.00  [Playtest] eco team 0 at 24.0 min: metal +4.3 bank 576/1150, energy +100.6 bank 1201/1201, units 24
 25.00  [Playtest] eco team 0 at 25.0 min: metal +4.3 bank 834/1150, energy +100.3 bank 1201/1201, units 24
```

## Native lines (all AIs, first 120)

```
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
  0.53  RESERVE: served armwin at (4792, 11544) facing 2 (id 1, 5 of this def still held)
  0.55  RESERVE: served armwin at (7400, 856) facing 0 (id 7, 5 of this def still held)
  0.69  RESERVE: armwin at (4792, 11544) is being reclaimed: its slot will be freed (id 1)
  0.71  RESERVE: restored armwin at (4792, 11544) (id 1)
  0.71  RESERVE: served armwin at (4792, 11544) facing 2 (id 1, 5 of this def still held)
  0.78  RESERVE: served armwin at (7448, 856) facing 0 (id 8, 4 of this def still held)
  0.82  RESERVE: served armwin at (4744, 11544) facing 2 (id 2, 4 of this def still held)
  0.93  RESERVE: served armwin at (4696, 11544) facing 2 (id 3, 3 of this def still held)
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
```
