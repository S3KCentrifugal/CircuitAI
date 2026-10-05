# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.1 min (frame 54114); wall 213 s
- DLL: build-theatres\d188-build-4\SkirmishAI.dll (4269e12be49092f4); AI BARbTest/test; staged 2026-10-04T01:06:35
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\supreme\20261004T040635Z-14355532\runs\20261004T041011Z-a947ad36\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:39.763668][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 3.2 min | `[t=00:01:03.738601][f=0005690] [SeaWatch] finished frame=5690 id=28919 def=armsy builder=17498` |
| expect `first-ship-exit` | seen at 4.1 min | `[t=00:01:07.371854][f=0007320] [SeaWatch] egress id=15869 yard=28919 seconds=7.4 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\supreme\20261004T040635Z-14355532\runs\20261004T041011Z-a947ad36\screen_2026-10-04_04-07-51-049.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\supreme\20261004T040635Z-14355532\runs\20261004T041011Z-a947ad36\screen_2026-10-04_04-08-12-193.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\supreme\20261004T040635Z-14355532\runs\20261004T041011Z-a947ad36\screen_2026-10-04_04-09-05-987.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\supreme\20261004T040635Z-14355532\runs\20261004T041011Z-a947ad36\screen_2026-10-04_04-10-01-870.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 37
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 37
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.20  [Playtest] finished armmex team 0 at 0.20 min
  0.22  [Team][Roster] first mex 25428 at 4608,11072
  0.22  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4775|11078|0|7|1|4608|11072
  0.39  [Playtest] finished armmex team 0 at 0.39 min
  0.63  [Playtest] finished armmex team 0 at 0.63 min
  0.90  [Playtest] finished armwin team 0 at 0.90 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.9 bank 1150/1150, energy +48.8 bank 757/1000, units 5
  1.52  [Playtest] finished armmex team 0 at 1.52 min
  1.70  [SEA][Layout] berth sea.berth.0 armsy at=5840,10640 facing=2
  2.00  [Playtest] eco team 0 at 2.0 min: metal +11.2 bank 1200/1200, energy +49.0 bank 999/1000, units 6
  2.29  [Playtest] finished armmex team 0 at 2.29 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +13.5 bank 1160/1250, energy +48.9 bank 834/1000, units 8
  3.16  [Playtest] finished armsy team 0 at 3.16 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +13.5 bank 1350/1350, energy +56.0 bank 136/1150, units 10
  4.48  [Playtest] finished armmex team 0 at 4.48 min
  4.52  [Playtest] finished armmex team 0 at 4.52 min
  4.98  [Playtest] finished armmex team 0 at 4.98 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +19.3 bank 1486/1500, energy +47.4 bank 59/1150, units 13
  5.00  [Playtest] target team 0 at (4814, 11077) from its start position
  5.00  [Playtest] camera requested (4814,11077) height=2200
  5.00  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (4814, 11077)
  5.80  [Playtest] finished armtl team 0 at 5.80 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +15.8 bank 1499/1500, energy +56.0 bank 0/1150, units 15
  6.12  [Playtest] finished armtl team 0 at 6.12 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +11.2 bank 1499/1500, energy +49.2 bank 0/1150, units 16
  7.13  [Playtest] finished armtl team 0 at 7.13 min
  7.82  [Playtest] finished armmex team 0 at 7.82 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +18.1 bank 1549/1550, energy +61.5 bank 0/1200, units 19
  8.36  [Playtest] finished armtl team 0 at 8.36 min
  8.86  [Playtest] finished armtl team 0 at 8.86 min
  8.88  [Playtest] finished armwin team 0 at 8.88 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +22.7 bank 1550/1550, energy +53.0 bank 115/1201, units 21
  9.70  [Playtest] finished armmex team 0 at 9.70 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +22.4 bank 1599/1600, energy +65.5 bank 0/1201, units 23
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 10.37  [Playtest] finished armtl team 0 at 10.37 min
 10.39  [Playtest] finished armwin team 0 at 10.40 min
 10.66  [Playtest] finished armmex team 0 at 10.66 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +20.1 bank 1649/1650, energy +99.4 bank 6/1201, units 27
 11.23  [Playtest] finished armmex team 0 at 11.23 min
 11.40  [Playtest] finished armtl team 0 at 11.40 min
 11.51  [Playtest] finished armtl team 0 at 11.51 min
 11.88  [Playtest] finished armfrad team 0 at 11.88 min
 11.91  [Playtest] finished armwin team 0 at 11.91 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +29.1 bank 1698/1700, energy +96.2 bank 139/1202, units 31
 12.05  [Playtest] finished armwin team 0 at 12.05 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +14.5 bank 1698/1700, energy +95.9 bank 0/1252, units 37
 13.04  [Playtest] finished armmex team 0 at 13.04 min
 13.12  [Playtest] finished armfrad team 0 at 13.12 min
 13.26  [Playtest] finished armtl team 0 at 13.26 min
 13.26  [Playtest] finished armfrad team 0 at 13.26 min
 13.86  [Playtest] finished armwin team 0 at 13.86 min
 13.90  [Playtest] finished armmex team 0 at 13.90 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +33.4 bank 1797/1800, energy +165.0 bank 146/1253, units 43
 14.06  [Playtest] finished armfrad team 0 at 14.06 min
 14.42  [Playtest] finished armtl team 0 at 14.42 min
 14.82  [Playtest] finished armllt team 0 at 14.82 min
 14.98  [Playtest] finished armtl team 0 at 14.98 min
 15.00  [Playtest] finished armtl team 0 at 15.00 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +33.4 bank 1800/1800, energy +157.5 bank 161/1253, units 47
 15.75  [Playtest] finished armfrad team 0 at 15.75 min
 15.88  [Playtest] finished armwin team 0 at 15.88 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +33.4 bank 1799/1800, energy +195.2 bank 1275/1353, units 51
 16.95  [Playtest] finished armfmkr team 0 at 16.95 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +33.4 bank 1798/1800, energy +204.7 bank 514/1403, units 56
 17.03  [Playtest] finished armfmkr team 0 at 17.03 min
 17.16  [Playtest] finished armmex team 0 at 17.16 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +35.7 bank 1850/1850, energy +98.9 bank 640/1403, units 60
 18.22  [Playtest] finished armrad team 0 at 18.22 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +36.8 bank 1849/1850, energy +204.8 bank 1092/1403, units 63
 19.45  [Playtest] finished armmex team 0 at 19.45 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +38.0 bank 1899/1900, energy +92.3 bank 745/1403, units 65
 20.00  [Playtest] camera requested (4814,11077) height=2200
 20.02  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (4814, 11077)
 20.68  [Playtest] finished armllt team 0 at 20.68 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +38.0 bank 1899/1900, energy +121.8 bank 652/1403, units 68
 21.87  [Playtest] finished armmex team 0 at 21.87 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +40.3 bank 1949/1950, energy +145.9 bank 475/1403, units 70
 22.60  [Playtest] finished armrad team 0 at 22.60 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +41.2 bank 1949/1950, energy +204.7 bank 1084/1403, units 73
 23.56  [Playtest] finished armmex team 0 at 23.56 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +42.6 bank 1999/2000, energy +169.4 bank 1066/1403, units 76
 24.47  [Playtest] finished armllt team 0 at 24.47 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +42.8 bank 1998/2000, energy +156.3 bank 1047/1403, units 79
 25.44  [Playtest] finished armllt team 0 at 25.44 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +42.6 bank 1999/2000, energy +173.0 bank 1073/1403, units 81
 27.00  [Playtest] eco team 0 at 27.0 min: metal +43.3 bank 1998/2000, energy +183.0 bank 1076/1403, units 83
 28.00  [Playtest] eco team 0 at 28.0 min: metal +42.6 bank 1999/2000, energy +118.1 bank 129/1403, units 84
 28.72  [Playtest] finished armrad team 0 at 28.72 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +42.6 bank 2000/2000, energy +127.0 bank 583/1403, units 86
 29.00  [Playtest] camera requested (4814,11077) height=2200
 29.02  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (4814, 11077)
 30.00  [Playtest] eco team 0 at 30.0 min: metal +42.6 bank 1998/2000, energy +155.9 bank 768/1403, units 86
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(17498) at (4776, 11079) walks to (4744, 11078), 136 from the armmex site (4608, 11072)
  0.08  EXP: approach: armcom(30578) at (7537, 1223) walks to (7560, 1224), 136 from the armmex site (7696, 1232)
  0.21  EXP: approach: armcom(30578) at (7549, 1223) walks to (7476, 1094), 136 from the armmex site (7408, 976)
  0.21  EXP: approach: armcom(17498) at (4759, 11078) walks to (4831, 11209), 136 from the armmex site (4896, 11328)
  0.41  EXP: approach: armcom(17498) at (4811, 11183) walks to (4866, 10933), 136 from the armmex site (4896, 10800)
  0.41  EXP: approach: armcom(30578) at (7495, 1113) walks to (7438, 1371), 136 from the armmex site (7408, 1504)
  0.65  RESERVE: zone 1 at (4840, 11432) facing 2, 3x3 cells: 9 of 9 held
  0.65  RESERVE: armwin at (4840, 11432) facing 2 (id 1)
  0.65  RESERVE: zone 2 at (4776, 11432) facing 2, 3x3 cells: 9 of 9 held
  0.65  RESERVE: armwin at (4776, 11432) facing 2 (id 2)
  0.65  RESERVE: zone 3 at (4712, 11432) facing 2, 3x3 cells: 9 of 9 held
  0.65  RESERVE: armwin at (4712, 11432) facing 2 (id 3)
  0.65  RESERVE: zone 4 at (4840, 11368) facing 2, 3x3 cells: 9 of 9 held
  0.65  RESERVE: armwin at (4840, 11368) facing 2 (id 4)
  0.65  RESERVE: zone 5 at (4776, 11368) facing 2, 3x3 cells: 9 of 9 held
  0.65  RESERVE: armwin at (4776, 11368) facing 2 (id 5)
  0.65  RESERVE: zone 6 at (4712, 11368) facing 2, 3x3 cells: 9 of 9 held
  0.65  RESERVE: armwin at (4712, 11368) facing 2 (id 6)
  0.65  RESERVE: zone 7 at (4776, 11397) facing 2, 13x9 cells: 61 of 117 held
  0.65  RESERVE: served armwin at (4840, 11432) facing 2 (id 1, 5 of this def still held)
  0.65  RESERVE: zone 1 at (7480, 872) facing 0, 3x3 cells: 9 of 9 held
  0.65  RESERVE: armwin at (7480, 872) facing 0 (id 1)
  0.65  RESERVE: zone 2 at (7544, 872) facing 0, 3x3 cells: 9 of 9 held
  0.65  RESERVE: armwin at (7544, 872) facing 0 (id 2)
  0.65  RESERVE: zone 3 at (7608, 872) facing 0, 3x3 cells: 9 of 9 held
  0.65  RESERVE: armwin at (7608, 872) facing 0 (id 3)
  0.65  RESERVE: zone 4 at (7480, 936) facing 0, 3x3 cells: 9 of 9 held
  0.65  RESERVE: armwin at (7480, 936) facing 0 (id 4)
  0.65  RESERVE: zone 5 at (7544, 936) facing 0, 3x3 cells: 9 of 9 held
  0.65  RESERVE: armwin at (7544, 936) facing 0 (id 5)
  0.65  RESERVE: zone 6 at (7608, 936) facing 0, 3x3 cells: 9 of 9 held
  0.65  RESERVE: armwin at (7608, 936) facing 0 (id 6)
  0.65  RESERVE: zone 7 at (7537, 905) facing 0, 13x9 cells: 63 of 117 held
  0.65  RESERVE: served armwin at (7480, 872) facing 0 (id 1, 5 of this def still held)
  0.81  EXP: frame: armwin(27518) has no task of its own; left standing for the sequence to assist
  0.82  EXP: frame: armwin(15292) has no task of its own; left standing for the sequence to assist
  0.90  EXP: idle: armcom(17498) on armwin at (4853, 11274), site (4856, 11236), target no, fails 1
  0.90  RESERVE: restored armwin at (4840, 11432) (id 1)
  0.90  RESERVE: pinned slot 1 for armwin cannot be served: the engine refuses the ground
  0.90  RESERVE: aborting armwin task after required slot 1 failed
  0.91  EXP: approach: armcom(17498) at (4853, 11274) walks to (5730, 11905), 136 from the armmex site (5840, 11984)
  0.92  EXP: idle: armcom(30578) on armwin at (7465, 1041), site (7461, 1077), target no, fails 1
  0.92  RESERVE: restored armwin at (7480, 872) (id 1)
  0.92  RESERVE: pinned slot 1 for armwin cannot be served: the engine refuses the ground
  0.92  RESERVE: aborting armwin task after required slot 1 failed
  0.93  EXP: approach: armcom(30578) at (7465, 1041) walks to (6574, 399), 136 from the armmex site (6464, 320)
  1.54  EXP: approach: armcom(17498) at (5720, 11881) walks to (6703, 11212), 136 from the armmex site (6816, 11136)
  1.56  EXP: approach: armcom(30578) at (6597, 405) walks to (5600, 1091), 136 from the armmex site (5488, 1168)
  1.63  RESERVE: zone 8 at (6480, 1664) facing 0, 6x6 cells: 36 of 36 held
  1.63  RESERVE: armsy at (6480, 1664) facing 0 (id 7)
  1.63  RESERVE: corridor 9 at (6480, 1952) facing 0, 12x30 cells: 360 of 360 held
  1.63  RESERVE: zone 10 at (6424, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6424, 1448) facing 0 (id 8)
  1.63  RESERVE: zone 11 at (6488, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6488, 1448) facing 0 (id 9)
  1.63  RESERVE: zone 10 released
  1.63  RESERVE: zone 11 released
  1.63  RESERVE: zone 12 at (6520, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6520, 1448) facing 0 (id 10)
  1.63  RESERVE: zone 12 released
  1.63  RESERVE: zone 13 at (6504, 1480) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6504, 1480) facing 0 (id 11)
  1.63  RESERVE: zone 13 released
  1.63  RESERVE: zone 14 at (6488, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6488, 1512) facing 0 (id 12)
  1.63  RESERVE: zone 14 released
  1.63  RESERVE: zone 15 at (6456, 1528) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6456, 1528) facing 0 (id 13)
  1.63  RESERVE: zone 16 at (6520, 1528) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6520, 1528) facing 0 (id 14)
  1.63  RESERVE: zone 15 released
  1.63  RESERVE: zone 16 released
  1.63  RESERVE: zone 17 at (6424, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6424, 1544) facing 0 (id 15)
  1.63  RESERVE: zone 18 at (6488, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6488, 1544) facing 0 (id 16)
  1.63  RESERVE: zone 19 at (6552, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6552, 1544) facing 0 (id 17)
  1.63  RESERVE: zone 17 released
  1.63  RESERVE: zone 18 released
  1.63  RESERVE: zone 19 released
  1.63  RESERVE: zone 20 at (6376, 1528) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6376, 1528) facing 0 (id 18)
  1.63  RESERVE: zone 21 at (6440, 1528) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6440, 1528) facing 0 (id 19)
  1.63  RESERVE: zone 22 at (6504, 1528) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6504, 1528) facing 0 (id 20)
  1.63  RESERVE: zone 23 at (6376, 1592) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6376, 1592) facing 0 (id 21)
  1.63  RESERVE: zone 24 at (6440, 1592) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6440, 1592) facing 0 (id 22)
  1.63  RESERVE: zone 25 at (6504, 1592) facing 0, 3x3 cells: 9 of 9 held
  1.63  RESERVE: armnanotcplat at (6504, 1592) facing 0 (id 23)
  1.63  RESERVE: zone 26 at (6443, 1561) facing 0, 13x9 cells: 57 of 117 held
  1.70  RESERVE: zone 8 at (5840, 10640) facing 2, 6x6 cells: 36 of 36 held
  1.70  RESERVE: armsy at (5840, 10640) facing 2 (id 7)
  1.70  RESERVE: corridor 9 at (5840, 10352) facing 2, 12x30 cells: 360 of 360 held
  1.70  RESERVE: zone 10 at (5912, 10872) facing 2, 3x3 cells: 9 of 9 held
  1.70  RESERVE: armnanotcplat at (5912, 10872) facing 2 (id 8)
  1.70  RESERVE: zone 11 at (5848, 10872) facing 2, 3x3 cells: 9 of 9 held
  1.70  RESERVE: armnanotcplat at (5848, 10872) facing 2 (id 9)
  1.70  RESERVE: zone 12 at (5784, 10872) facing 2, 3x3 cells: 9 of 9 held
  1.70  RESERVE: armnanotcplat at (5784, 10872) facing 2 (id 10)
  1.70  RESERVE: zone 13 at (5912, 10808) facing 2, 3x3 cells: 9 of 9 held
  1.70  RESERVE: armnanotcplat at (5912, 10808) facing 2 (id 11)
  1.70  RESERVE: zone 14 at (5848, 10808) facing 2, 3x3 cells: 9 of 9 held
  1.70  RESERVE: armnanotcplat at (5848, 10808) facing 2 (id 12)
  1.70  RESERVE: zone 15 at (5784, 10808) facing 2, 3x3 cells: 9 of 9 held
  1.70  RESERVE: armnanotcplat at (5784, 10808) facing 2 (id 13)
  1.70  RESERVE: zone 16 at (5840, 10832) facing 2, 12x8 cells: 42 of 96 held
  2.30  EXP: approach: armcom(17498) at (6679, 11237) walks to (5977, 10738), 168 from the armsy site (5840, 10640)
  2.31  RESERVE: served armsy at (5840, 10640) facing 2 (id 7, 0 of this def still held)
  2.33  EXP: approach: armcom(30578) at (5625, 1068) walks to (6315, 1628), 169 from the armsy site (6480, 1664)
  2.33  RESERVE: served armsy at (6480, 1664) facing 0 (id 7, 0 of this def still held)
  3.36  EXP: approach: armcom(17498) at (6179, 10925) walks to (7406, 11718), 136 from the armmex site (7520, 11792)
  3.43  EXP: approach: armcom(30578) at (6161, 1318) walks to (4901, 581), 136 from the armmex site (4784, 512)
  3.96  BUILDER: discarded 1 unused default task(s) in the last minute
  3.96  EXP: approach: armcs(15869) at (5840, 10630) walks to (6359, 10396), 186 from the armmex site (6528, 10320)
  4.02  BUILDER: discarded 1 unused default task(s) in the last minute
  4.02  EXP: approach: armcs(30974) at (6480, 1678) walks to (5946, 1910), 186 from the armmex site (5776, 1984)
```
