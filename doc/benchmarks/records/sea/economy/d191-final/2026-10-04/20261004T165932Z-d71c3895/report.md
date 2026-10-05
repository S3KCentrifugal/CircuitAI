# Playtest report: PASS

- Verdict: **PASS** (reached 25 min)
- Game time reached: 25.1 min (frame 45141); wall 172 s
- DLL: build-theatres\d191-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T13:56:37
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-final\supreme\20261004T165636Z-ddc666be\runs\20261004T165932Z-d71c3895\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:44.883757][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.5 min | `[t=00:00:59.449243][f=0002615] [SeaWatch] finished frame=2615 id=28410 def=armsy builder=28578` |
| expect `first-ship-exit` | seen at 5.6 min | `[t=00:01:17.189201][f=0010080] [SeaWatch] egress id=24564 yard=28410 seconds=218.7 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-final\supreme\20261004T165636Z-ddc666be\runs\20261004T165932Z-d71c3895\screen_2026-10-04_16-57-55-739.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-final\supreme\20261004T165636Z-ddc666be\runs\20261004T165932Z-d71c3895\screen_2026-10-04_16-58-16-726.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-final\supreme\20261004T165636Z-ddc666be\runs\20261004T165932Z-d71c3895\screen_2026-10-04_16-59-01-303.png

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
  0.61  [Playtest] finished armwin team 0 at 0.61 min
  0.72  [Playtest] finished armwin team 0 at 0.72 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.3 bank 1050/1050, energy +68.0 bank 1001/1001, units 4
  1.45  [Playtest] finished armsy team 0 at 1.45 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +4.3 bank 600/1150, energy +54.5 bank 92/1151, units 7
  2.57  [Playtest] finished armtide team 0 at 2.57 min
  2.88  [Playtest] finished armtide team 0 at 2.88 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +4.3 bank 256/1150, energy +120.4 bank 269/1301, units 12
  3.19  [Playtest] finished armtide team 0 at 3.19 min
  3.21  [Playtest] finished armtide team 0 at 3.21 min
  3.58  [Playtest] finished armtide team 0 at 3.59 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +4.3 bank 13/1150, energy +171.5 bank 1450/1451, units 14
  4.02  [Playtest] finished armtide team 0 at 4.02 min
  4.73  [Playtest] finished armtide team 0 at 4.73 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +4.3 bank 13/1150, energy +212.5 bank 1550/1551, units 17
  5.00  [Playtest] target team 0 at (4814, 11077) from its start position
  5.00  [Playtest] camera requested (4814,11077) height=2200
  5.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (4814, 11077)
  5.16  [Playtest] finished armtide team 0 at 5.16 min
  5.55  [Playtest] finished armtide team 0 at 5.55 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +4.3 bank 14/1150, energy +270.7 bank 1648/1651, units 19
  6.51  [Playtest] finished armfmkr team 0 at 6.51 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +5.3 bank 12/1150, energy +252.0 bank 1610/1651, units 21
  7.39  [Playtest] finished armfmkr team 0 at 7.39 min
  7.91  [Playtest] finished armtide team 0 at 7.91 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +6.3 bank 13/1150, energy +291.9 bank 1638/1701, units 22
  8.61  [Playtest] finished armfmkr team 0 at 8.61 min
  8.98  [Playtest] finished armfmkr team 0 at 8.98 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +6.9 bank 13/1150, energy +289.1 bank 1384/1701, units 25
  9.48  [Playtest] finished armtide team 0 at 9.48 min
  9.96  [Playtest] finished armtide team 0 at 9.96 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +7.8 bank 14/1150, energy +333.7 bank 1498/1801, units 28
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 10.53  [Playtest] finished armtide team 0 at 10.53 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +8.3 bank 84/1150, energy +342.4 bank 1743/1851, units 30
 12.00  [Playtest] eco team 0 at 12.0 min: metal +8.3 bank 582/1150, energy +322.9 bank 1740/1851, units 30
 12.06  [Playtest] finished armfmkr team 0 at 12.06 min
 12.66  [Playtest] finished armfmkr team 0 at 12.66 min
 12.98  [Playtest] finished armtide team 0 at 12.98 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +8.7 bank 811/1150, energy +334.9 bank 1597/1901, units 33
 13.30  [Playtest] finished armtide team 0 at 13.30 min
 13.62  [Playtest] finished armtide team 0 at 13.62 min
 13.94  [Playtest] finished armtide team 0 at 13.94 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +9.8 bank 917/1150, energy +439.0 bank 1710/2051, units 39
 14.25  [Playtest] finished armtide team 0 at 14.25 min
 14.77  [Playtest] finished armtide team 0 at 14.77 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +10.3 bank 852/1150, energy +480.0 bank 2043/2151, units 41
 15.09  [Playtest] finished armtide team 0 at 15.09 min
 15.47  [Playtest] finished armfmkr team 0 at 15.47 min
 15.79  [Playtest] finished armtide team 0 at 15.79 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +10.2 bank 919/1150, energy +521.8 bank 1894/2251, units 49
 16.13  [Playtest] finished armtide team 0 at 16.13 min
 16.50  [Playtest] finished armfmkr team 0 at 16.50 min
 16.83  [Playtest] finished armtide team 0 at 16.83 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +11.4 bank 911/1150, energy +563.4 bank 2010/2351, units 54
 17.16  [Playtest] finished armtide team 0 at 17.16 min
 17.24  [Playtest] finished armfmkr team 0 at 17.24 min
 17.58  [Playtest] finished armtide team 0 at 17.58 min
 17.91  [Playtest] finished armtide team 0 at 17.91 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +12.8 bank 941/1150, energy +613.0 bank 2156/2501, units 61
 18.24  [Playtest] finished armtide team 0 at 18.24 min
 18.57  [Playtest] finished armtide team 0 at 18.57 min
 18.64  [Playtest] finished armfmkr team 0 at 18.64 min
 18.91  [Playtest] finished armtide team 0 at 18.91 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +11.5 bank 580/1150, energy +671.0 bank 2249/2651, units 66
 19.09  [Playtest] finished armfmkr team 0 at 19.09 min
 19.23  [Playtest] finished armtide team 0 at 19.23 min
 19.43  [Playtest] finished armfmkr team 0 at 19.43 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +11.9 bank 993/1150, energy +688.3 bank 2291/2701, units 69
 20.00  [Playtest] camera requested (4814,11077) height=2200
 20.02  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (4814, 11077)
 20.17  [Playtest] finished armtide team 0 at 20.17 min
 20.20  [Playtest] finished armfmkr team 0 at 20.20 min
 20.50  [Playtest] finished armtide team 0 at 20.50 min
 20.84  [Playtest] finished armtide team 0 at 20.84 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +14.3 bank 1019/1150, energy +772.9 bank 2564/2951, units 75
 21.17  [Playtest] finished armtide team 0 at 21.17 min
 21.49  [Playtest] finished armtide team 0 at 21.49 min
 21.82  [Playtest] finished armtide team 0 at 21.83 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +15.5 bank 1148/1150, energy +852.0 bank 2716/3101, units 81
 22.23  [Playtest] finished armtide team 0 at 22.23 min
 22.62  [Playtest] finished armmex team 0 at 22.62 min
 22.96  [Playtest] finished armtide team 0 at 22.96 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +18.5 bank 1199/1200, energy +880.5 bank 2791/3201, units 89
 23.30  [Playtest] finished armtide team 0 at 23.30 min
 23.68  [Playtest] finished armtide team 0 at 23.68 min
 23.73  [Playtest] finished armfmkr team 0 at 23.73 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +15.5 bank 1197/1200, energy +920.6 bank 2821/3301, units 96
 24.07  [Playtest] finished armtide team 0 at 24.07 min
 24.07  [Playtest] finished armfmkr team 0 at 24.07 min
 24.39  [Playtest] finished armtide team 0 at 24.39 min
 24.52  [Playtest] finished armfmkr team 0 at 24.52 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +19.0 bank 1198/1200, energy +977.8 bank 2985/3401, units 101
 25.03  [Playtest] finished armtide team 0 at 25.03 min
```

## Native lines (all AIs, first 120)

```
  1.47  RESERVE: zone 1 at (5768, 10872) facing 2, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (5768, 10872) facing 2 (id 1)
  1.47  RESERVE: zone 1 released
  1.47  RESERVE: corridor 2 at (5808, 10416) facing 2, 12x30 cells: 232 of 360 held
  1.47  RESERVE: zone 3 at (5808, 11152) facing 2, 40x40 cells: 1600 of 1600 held
  1.47  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (5808, 11056) facing 2: 6 of 16 slots (group 1, held, zone)
  1.47  RESERVE: zone 3 released
  1.47  RESERVE: zone 4 at (5680, 11152) facing 2, 40x40 cells: 1600 of 1600 held
  1.47  RESERVE: zone 4 released
  1.47  RESERVE: zone 5 at (5936, 11152) facing 2, 40x40 cells: 1600 of 1600 held
  1.47  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (5936, 11056) facing 2: 14 of 16 slots (group 3, held, zone)
  1.47  RESERVE: zone 5 released
  1.47  RESERVE: zone 6 at (6064, 11152) facing 2, 40x40 cells: 1600 of 1600 held
  1.47  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6064, 11056) facing 2: 16 of 16 slots (group 4, held, zone)
  1.47  RESERVE: armuwfus at (6144, 11280) facing 2 (id 38)
  1.47  RESERVE: packed armuwfus at (6144, 11280) facing 2 in zone 6, 313 from a turret (id 38, group 0, 1040 candidates)
  1.47  RESERVE: zone 1 at (6488, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6488, 1544) facing 0 (id 1)
  1.47  RESERVE: zone 2 at (6536, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6536, 1544) facing 0 (id 2)
  1.47  RESERVE: zone 3 at (6584, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6584, 1544) facing 0 (id 3)
  1.47  RESERVE: zone 4 at (6632, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6632, 1544) facing 0 (id 4)
  1.47  RESERVE: zone 1 released
  1.47  RESERVE: zone 2 released
  1.47  RESERVE: zone 3 released
  1.47  RESERVE: zone 4 released
  1.47  RESERVE: zone 5 at (6424, 1560) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6424, 1560) facing 0 (id 5)
  1.47  RESERVE: zone 6 at (6472, 1560) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6472, 1560) facing 0 (id 6)
  1.47  RESERVE: zone 7 at (6520, 1560) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6520, 1560) facing 0 (id 7)
  1.47  RESERVE: zone 8 at (6568, 1560) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6568, 1560) facing 0 (id 8)
  1.47  RESERVE: zone 9 at (6616, 1560) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6616, 1560) facing 0 (id 9)
  1.47  RESERVE: zone 5 released
  1.47  RESERVE: zone 6 released
  1.47  RESERVE: zone 7 released
  1.47  RESERVE: zone 8 released
  1.47  RESERVE: zone 9 released
  1.47  RESERVE: zone 10 at (6344, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6344, 1544) facing 0 (id 10)
  1.47  RESERVE: zone 11 at (6392, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6392, 1544) facing 0 (id 11)
  1.47  RESERVE: zone 12 at (6440, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6440, 1544) facing 0 (id 12)
  1.47  RESERVE: zone 13 at (6488, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6488, 1544) facing 0 (id 13)
  1.47  RESERVE: zone 14 at (6536, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6536, 1544) facing 0 (id 14)
  1.47  RESERVE: zone 15 at (6344, 1592) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6344, 1592) facing 0 (id 15)
  1.47  RESERVE: zone 10 released
  1.47  RESERVE: zone 11 released
  1.47  RESERVE: zone 12 released
  1.47  RESERVE: zone 13 released
  1.47  RESERVE: zone 14 released
  1.47  RESERVE: zone 15 released
  1.47  RESERVE: zone 16 at (6280, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6280, 1496) facing 0 (id 16)
  1.47  RESERVE: zone 17 at (6328, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6328, 1496) facing 0 (id 17)
  1.47  RESERVE: zone 18 at (6376, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6376, 1496) facing 0 (id 18)
  1.47  RESERVE: zone 19 at (6424, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6424, 1496) facing 0 (id 19)
  1.47  RESERVE: zone 20 at (6472, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6472, 1496) facing 0 (id 20)
  1.47  RESERVE: zone 21 at (6280, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6280, 1544) facing 0 (id 21)
  1.47  RESERVE: zone 22 at (6328, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6328, 1544) facing 0 (id 22)
  1.47  RESERVE: zone 23 at (6376, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6376, 1544) facing 0 (id 23)
  1.47  RESERVE: zone 24 at (6424, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6424, 1544) facing 0 (id 24)
  1.47  RESERVE: zone 25 at (6472, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6472, 1544) facing 0 (id 25)
  1.47  RESERVE: zone 26 at (6280, 1592) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6280, 1592) facing 0 (id 26)
  1.47  RESERVE: zone 27 at (6328, 1592) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6328, 1592) facing 0 (id 27)
  1.47  RESERVE: zone 16 released
  1.47  RESERVE: zone 17 released
  1.47  RESERVE: zone 18 released
  1.47  RESERVE: zone 19 released
  1.47  RESERVE: zone 20 released
  1.47  RESERVE: zone 21 released
  1.47  RESERVE: zone 22 released
  1.47  RESERVE: zone 23 released
  1.47  RESERVE: zone 24 released
  1.47  RESERVE: zone 25 released
  1.47  RESERVE: zone 26 released
  1.47  RESERVE: zone 27 released
  1.47  RESERVE: zone 28 at (6232, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6232, 1448) facing 0 (id 28)
  1.47  RESERVE: zone 29 at (6280, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6280, 1448) facing 0 (id 29)
  1.47  RESERVE: zone 30 at (6328, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6328, 1448) facing 0 (id 30)
  1.47  RESERVE: zone 31 at (6376, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6376, 1448) facing 0 (id 31)
  1.47  RESERVE: zone 32 at (6424, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6424, 1448) facing 0 (id 32)
  1.47  RESERVE: zone 33 at (6232, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6232, 1496) facing 0 (id 33)
  1.47  RESERVE: zone 34 at (6280, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6280, 1496) facing 0 (id 34)
  1.47  RESERVE: zone 35 at (6328, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6328, 1496) facing 0 (id 35)
  1.47  RESERVE: zone 36 at (6376, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6376, 1496) facing 0 (id 36)
  1.47  RESERVE: zone 37 at (6424, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6424, 1496) facing 0 (id 37)
  1.47  RESERVE: zone 38 at (6232, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6232, 1544) facing 0 (id 38)
  1.47  RESERVE: zone 39 at (6280, 1544) facing 0, 3x3 cells: 9 of 9 held
```
