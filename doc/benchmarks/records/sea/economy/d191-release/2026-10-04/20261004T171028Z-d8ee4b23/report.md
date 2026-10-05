# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.1 min (frame 54270); wall 181 s
- DLL: build-theatres\d191-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T14:07:23
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-release\supreme\20261004T170723Z-8201cce4\runs\20261004T171028Z-d8ee4b23\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:34.957691][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.4 min | `[t=00:00:49.491591][f=0002585] [SeaWatch] finished frame=2585 id=10240 def=armsy builder=28578` |
| expect `first-ship-exit` | seen at 3.8 min | `[t=00:00:59.180185][f=0006810] [SeaWatch] egress id=19532 yard=10240 seconds=127.5 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-release\supreme\20261004T170723Z-8201cce4\runs\20261004T171028Z-d8ee4b23\screen_2026-10-04_17-08-33-044.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-release\supreme\20261004T170723Z-8201cce4\runs\20261004T171028Z-d8ee4b23\screen_2026-10-04_17-08-54-031.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-release\supreme\20261004T170723Z-8201cce4\runs\20261004T171028Z-d8ee4b23\screen_2026-10-04_17-09-37-020.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-release\supreme\20261004T170723Z-8201cce4\runs\20261004T171028Z-d8ee4b23\screen_2026-10-04_17-10-20-965.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 30.5 min
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
  0.38  [Playtest] finished armmex team 0 at 0.38 min
  0.49  [Playtest] finished armwin team 0 at 0.49 min
  0.60  [Playtest] finished armwin team 0 at 0.60 min
  0.71  [Playtest] finished armwin team 0 at 0.71 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 1085/1100, energy +86.2 bank 1001/1001, units 6
  1.44  [Playtest] finished armsy team 0 at 1.44 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.6 bank 590/1200, energy +93.8 bank 31/1151, units 9
  2.22  [Playtest] finished armtide team 0 at 2.22 min
  2.42  [Playtest] finished armtide team 0 at 2.42 min
  2.60  [Playtest] finished armtide team 0 at 2.60 min
  2.95  [Playtest] finished armtide team 0 at 2.95 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.6 bank 0/1200, energy +185.0 bank 1401/1401, units 16
  3.26  [Playtest] finished armtide team 0 at 3.26 min
  3.42  [Playtest] finished armmex team 0 at 3.42 min
  3.58  [Playtest] finished armtide team 0 at 3.59 min
  3.83  [Playtest] finished armmex team 0 at 3.83 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.9 bank 15/1300, energy +223.0 bank 1495/1501, units 20
  4.11  [Playtest] finished armtide team 0 at 4.11 min
  4.12  [Playtest] finished armmex team 0 at 4.12 min
  4.31  [Playtest] finished armtide team 0 at 4.31 min
  4.44  [Playtest] finished armmex team 0 at 4.44 min
  4.82  [Playtest] finished armfmkr team 0 at 4.82 min
  4.84  [Playtest] finished armmex team 0 at 4.84 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +18.3 bank 132/1450, energy +269.0 bank 1545/1601, units 27
  5.00  [Playtest] target team 0 at (4814, 11077) from its start position
  5.00  [Playtest] camera requested (4814,11077) height=2200
  5.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (4814, 11077)
  5.21  [Playtest] finished armfmkr team 0 at 5.22 min
  5.22  [Playtest] finished armmex team 0 at 5.22 min
  5.53  [Playtest] finished armmex team 0 at 5.53 min
  5.54  [Playtest] finished armfmkr team 0 at 5.54 min
  5.77  [Playtest] finished armtide team 0 at 5.77 min
  5.81  [Playtest] finished armmex team 0 at 5.81 min
  5.96  [Playtest] finished armtide team 0 at 5.96 min
  5.98  [Playtest] finished armllt team 0 at 5.98 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +25.3 bank 435/1600, energy +317.8 bank 1415/1751, units 37
  6.11  [Playtest] finished armrad team 0 at 6.11 min
  6.11  [Playtest] finished armtide team 0 at 6.11 min
  6.26  [Playtest] finished armtide team 0 at 6.26 min
  6.58  [Playtest] finished armmex team 0 at 6.58 min
  6.75  [Playtest] finished armfmkr team 0 at 6.74 min
  6.76  [Playtest] finished armllt team 0 at 6.76 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +29.9 bank 1172/1650, energy +366.9 bank 1542/1901, units 45
  7.07  [Playtest] finished armtide team 0 at 7.07 min
  7.16  [Playtest] finished armtide team 0 at 7.16 min
  7.25  [Playtest] finished armtide team 0 at 7.25 min
  7.34  [Playtest] finished armtide team 0 at 7.34 min
  7.71  [Playtest] finished armfmkr team 0 at 7.71 min
  7.85  [Playtest] finished armmex team 0 at 7.85 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +33.5 bank 1698/1700, energy +439.6 bank 1755/2151, units 54
  8.04  [Playtest] finished armtide team 0 at 8.04 min
  8.13  [Playtest] finished armtide team 0 at 8.14 min
  8.21  [Playtest] finished armtide team 0 at 8.22 min
  8.43  [Playtest] finished armmex team 0 at 8.43 min
  8.51  [Playtest] finished armtide team 0 at 8.51 min
  8.82  [Playtest] finished armtide team 0 at 8.82 min
  8.96  [Playtest] finished armtl team 0 at 8.95 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +34.5 bank 1748/1750, energy +537.9 bank 1982/2451, units 67
  9.06  [Playtest] finished armtl team 0 at 9.06 min
  9.12  [Playtest] finished armmex team 0 at 9.12 min
  9.15  [Playtest] finished armtide team 0 at 9.15 min
  9.30  [Playtest] finished armfmkr team 0 at 9.30 min
  9.46  [Playtest] finished armtide team 0 at 9.46 min
  9.69  [Playtest] finished armtl team 0 at 9.69 min
  9.75  [Playtest] finished armfrad team 0 at 9.75 min
  9.78  [Playtest] finished armtide team 0 at 9.78 min
  9.99  [Playtest] finished armfmkr team 0 at 9.99 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +37.9 bank 1798/1800, energy +625.6 bank 2122/2601, units 77
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 10.06  [Playtest] finished armmex team 0 at 10.06 min
 10.09  [Playtest] finished armmex team 0 at 10.09 min
 10.24  [Playtest] finished armmex team 0 at 10.24 min
 10.61  [Playtest] finished armfrad team 0 at 10.61 min
 10.62  [Playtest] finished armtl team 0 at 10.62 min
 10.63  [Playtest] finished armtl team 0 at 10.63 min
 10.66  [Playtest] finished armtide team 0 at 10.66 min
 10.77  [Playtest] finished armtl team 0 at 10.77 min
 10.90  [Playtest] finished armfrad team 0 at 10.90 min
 10.98  [Playtest] finished armtide team 0 at 10.98 min
 10.99  [Playtest] finished armmex team 0 at 10.99 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +45.0 bank 1961/2000, energy +634.4 bank 2245/2701, units 87
 11.19  [Playtest] finished armllt team 0 at 11.19 min
 11.31  [Playtest] finished armtide team 0 at 11.31 min
 11.34  [Playtest] finished armtl team 0 at 11.34 min
 11.59  [Playtest] finished armfrad team 0 at 11.59 min
 11.64  [Playtest] finished armtide team 0 at 11.64 min
 11.87  [Playtest] finished armestor team 0 at 11.87 min
 11.95  [Playtest] finished armtide team 0 at 11.95 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +42.6 bank 1978/2000, energy +689.8 bank 5978/8851, units 95
 12.09  [Playtest] finished armmstor team 0 at 12.09 min
 12.30  [Playtest] finished armtide team 0 at 12.30 min
 12.78  [Playtest] finished armtide team 0 at 12.78 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +49.6 bank 3759/5000, energy +776.9 bank 8938/8951, units 98
 13.10  [Playtest] finished armtide team 0 at 13.10 min
 13.43  [Playtest] finished armtide team 0 at 13.43 min
 13.45  [Playtest] finished armmex team 0 at 13.45 min
 13.62  [Playtest] finished armllt team 0 at 13.62 min
 13.75  [Playtest] finished armtide team 0 at 13.75 min
 13.78  [Playtest] finished armrad team 0 at 13.78 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +51.9 bank 5048/5050, energy +817.7 bank 9062/9101, units 107
 14.07  [Playtest] finished armtide team 0 at 14.07 min
 14.21  [Playtest] finished armfmkr team 0 at 14.21 min
 14.50  [Playtest] finished armtide team 0 at 14.50 min
 14.60  [Playtest] finished armfmkr team 0 at 14.60 min
 14.80  [Playtest] finished armfmkr team 0 at 14.80 min
 14.80  [Playtest] finished armllt team 0 at 14.80 min
 14.93  [Playtest] finished armfmkr team 0 at 14.93 min
 14.97  [Playtest] finished armrad team 0 at 14.97 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +54.4 bank 5048/5050, energy +856.8 bank 7246/9201, units 114
 15.11  [Playtest] finished armtide team 0 at 15.11 min
 15.43  [Playtest] finished armtide team 0 at 15.43 min
 15.45  [Playtest] finished armmakr team 0 at 15.44 min
 15.67  [Playtest] finished armmakr team 0 at 15.67 min
 15.79  [Playtest] finished armtide team 0 at 15.79 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +56.1 bank 5049/5050, energy +947.7 bank 7404/9351, units 120
 16.13  [Playtest] finished armtide team 0 at 16.13 min
 16.40  [Playtest] finished armllt team 0 at 16.40 min
 16.46  [Playtest] finished armtide team 0 at 16.46 min
 16.51  [Playtest] finished armrad team 0 at 16.51 min
 16.81  [Playtest] finished armtide team 0 at 16.81 min
 16.85  [Playtest] finished armrad team 0 at 16.85 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +57.1 bank 5049/5050, energy +1004.8 bank 7551/9501, units 126
 17.14  [Playtest] finished armllt team 0 at 17.14 min
 17.43  [Playtest] finished armtide team 0 at 17.43 min
 17.75  [Playtest] finished armtide team 0 at 17.75 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +57.5 bank 5048/5050, energy +1049.5 bank 7643/9601, units 131
 18.06  [Playtest] finished armtide team 0 at 18.06 min
 18.26  [Playtest] finished armtide team 0 at 18.26 min
 18.47  [Playtest] finished armtide team 0 at 18.47 min
 18.66  [Playtest] finished armtide team 0 at 18.66 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +57.9 bank 5049/5050, energy +1126.7 bank 9593/9801, units 135
 19.26  [Playtest] finished armtide team 0 at 19.26 min
 19.45  [Playtest] finished armtide team 0 at 19.45 min
 19.66  [Playtest] finished armtide team 0 at 19.66 min
 19.80  [Playtest] finished armfmkr team 0 at 19.80 min
 19.85  [Playtest] finished armtide team 0 at 19.85 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +58.9 bank 5047/5050, energy +1198.2 bank 9493/10001, units 145
 20.00  [Playtest] camera requested (4814,11077) height=2200
 20.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (4814, 11077)
 20.05  [Playtest] finished armtide team 0 at 20.05 min
 20.14  [Playtest] finished armfmkr team 0 at 20.14 min
 20.16  [Playtest] finished armfmkr team 0 at 20.16 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +56.5 bank 5044/5050, energy +1236.1 bank 7941/10051, units 148
 22.00  [Playtest] eco team 0 at 22.0 min: metal +56.5 bank 5044/5050, energy +1242.0 bank 7945/10051, units 151
 23.00  [Playtest] eco team 0 at 23.0 min: metal +56.8 bank 5042/5050, energy +1235.2 bank 7954/10051, units 155
 24.00  [Playtest] eco team 0 at 24.0 min: metal +56.4 bank 5042/5050, energy +1235.0 bank 7941/10051, units 163
 25.00  [Playtest] eco team 0 at 25.0 min: metal +56.5 bank 5042/5050, energy +1242.0 bank 7945/10051, units 166
 25.63  [Playtest] finished armtl team 0 at 25.63 min
 25.73  [Playtest] finished armfrad team 0 at 25.73 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +59.1 bank 5048/5050, energy +1198.2 bank 8035/10051, units 170
 26.24  [Playtest] finished armtl team 0 at 26.24 min
 26.26  [Playtest] finished armtl team 0 at 26.26 min
 26.68  [Playtest] finished armtl team 0 at 26.68 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +59.5 bank 5050/5050, energy +1224.1 bank 8107/10051, units 174
 27.25  [Playtest] finished armrad team 0 at 27.25 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +59.7 bank 5047/5050, energy +1241.8 bank 8057/10051, units 178
 29.00  [Playtest] eco team 0 at 29.0 min: metal +59.2 bank 5047/5050, energy +1222.9 bank 8037/10051, units 183
 29.00  [Playtest] camera requested (4814,11077) height=2200
 29.02  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (4814, 11077)
 30.00  [Playtest] eco team 0 at 30.0 min: metal +60.9 bank 5047/5050, energy +1236.9 bank 8058/10051, units 189
```

## Native lines (all AIs, first 120)

```
  1.45  RESERVE: zone 1 at (5800, 10904) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (5800, 10904) facing 2 (id 1)
  1.45  RESERVE: zone 1 released
  1.45  RESERVE: corridor 2 at (5840, 10448) facing 2, 12x30 cells: 210 of 360 held
  1.45  RESERVE: zone 3 at (5840, 11184) facing 2, 40x40 cells: 1600 of 1600 held
  1.45  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (5840, 11088) facing 2: 7 of 16 slots (group 1, held, zone)
  1.45  RESERVE: zone 3 released
  1.45  RESERVE: zone 4 at (5712, 11184) facing 2, 40x40 cells: 1600 of 1600 held
  1.45  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (5712, 11088) facing 2: 1 of 16 slots (group 2, held, zone)
  1.45  RESERVE: zone 4 released
  1.45  RESERVE: zone 5 at (5968, 11184) facing 2, 40x40 cells: 1600 of 1600 held
  1.45  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (5968, 11088) facing 2: 16 of 16 slots (group 3, held, zone)
  1.45  RESERVE: armuwfus at (5984, 11056) facing 2 (id 26)
  1.45  RESERVE: packed armuwfus at (5984, 11056) facing 2 in zone 5, 313 from a turret (id 26, group 0, 1040 candidates)
  1.45  RESERVE: zone 1 at (6472, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6472, 1496) facing 0 (id 1)
  1.45  RESERVE: zone 2 at (6520, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6520, 1496) facing 0 (id 2)
  1.45  RESERVE: zone 1 released
  1.45  RESERVE: zone 2 released
  1.45  RESERVE: zone 3 at (6408, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6408, 1512) facing 0 (id 3)
  1.45  RESERVE: zone 4 at (6456, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6456, 1512) facing 0 (id 4)
  1.45  RESERVE: zone 5 at (6504, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6504, 1512) facing 0 (id 5)
  1.45  RESERVE: zone 3 released
  1.45  RESERVE: zone 4 released
  1.45  RESERVE: zone 5 released
  1.45  RESERVE: zone 6 at (6328, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6328, 1496) facing 0 (id 6)
  1.45  RESERVE: zone 7 at (6376, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6376, 1496) facing 0 (id 7)
  1.45  RESERVE: zone 8 at (6424, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6424, 1496) facing 0 (id 8)
  1.45  RESERVE: zone 9 at (6472, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6472, 1496) facing 0 (id 9)
  1.45  RESERVE: zone 10 at (6520, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6520, 1496) facing 0 (id 10)
  1.45  RESERVE: zone 11 at (6328, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6328, 1544) facing 0 (id 11)
  1.45  RESERVE: zone 6 released
  1.45  RESERVE: zone 7 released
  1.45  RESERVE: zone 8 released
  1.45  RESERVE: zone 9 released
  1.45  RESERVE: zone 10 released
  1.45  RESERVE: zone 11 released
  1.45  RESERVE: zone 12 at (6264, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6264, 1448) facing 0 (id 12)
  1.45  RESERVE: zone 13 at (6312, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6312, 1448) facing 0 (id 13)
  1.45  RESERVE: zone 14 at (6360, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6360, 1448) facing 0 (id 14)
  1.45  RESERVE: zone 15 at (6408, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6408, 1448) facing 0 (id 15)
  1.45  RESERVE: zone 16 at (6456, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6456, 1448) facing 0 (id 16)
  1.45  RESERVE: zone 17 at (6264, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6264, 1496) facing 0 (id 17)
  1.45  RESERVE: zone 18 at (6312, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6312, 1496) facing 0 (id 18)
  1.45  RESERVE: zone 19 at (6360, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6360, 1496) facing 0 (id 19)
  1.45  RESERVE: zone 20 at (6408, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6408, 1496) facing 0 (id 20)
  1.45  RESERVE: zone 21 at (6456, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6456, 1496) facing 0 (id 21)
  1.45  RESERVE: zone 22 at (6264, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6264, 1544) facing 0 (id 22)
  1.45  RESERVE: zone 23 at (6312, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6312, 1544) facing 0 (id 23)
  1.45  RESERVE: zone 12 released
  1.45  RESERVE: zone 13 released
  1.45  RESERVE: zone 14 released
  1.45  RESERVE: zone 15 released
  1.45  RESERVE: zone 16 released
  1.45  RESERVE: zone 17 released
  1.45  RESERVE: zone 18 released
  1.45  RESERVE: zone 19 released
  1.45  RESERVE: zone 20 released
  1.45  RESERVE: zone 21 released
  1.45  RESERVE: zone 22 released
  1.45  RESERVE: zone 23 released
  1.45  RESERVE: zone 24 at (6216, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6216, 1400) facing 0 (id 24)
  1.45  RESERVE: zone 25 at (6264, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6264, 1400) facing 0 (id 25)
  1.45  RESERVE: zone 26 at (6312, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6312, 1400) facing 0 (id 26)
  1.45  RESERVE: zone 27 at (6360, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6360, 1400) facing 0 (id 27)
  1.45  RESERVE: zone 28 at (6408, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6408, 1400) facing 0 (id 28)
  1.45  RESERVE: zone 29 at (6216, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6216, 1448) facing 0 (id 29)
  1.45  RESERVE: zone 30 at (6264, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6264, 1448) facing 0 (id 30)
  1.45  RESERVE: zone 31 at (6312, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6312, 1448) facing 0 (id 31)
  1.45  RESERVE: zone 32 at (6360, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6360, 1448) facing 0 (id 32)
  1.45  RESERVE: zone 33 at (6408, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6408, 1448) facing 0 (id 33)
  1.45  RESERVE: zone 34 at (6216, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6216, 1496) facing 0 (id 34)
  1.45  RESERVE: zone 35 at (6264, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6264, 1496) facing 0 (id 35)
  1.45  RESERVE: zone 36 at (6312, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6312, 1496) facing 0 (id 36)
  1.45  RESERVE: zone 37 at (6360, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6360, 1496) facing 0 (id 37)
  1.45  RESERVE: zone 38 at (6408, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6408, 1496) facing 0 (id 38)
  1.45  RESERVE: zone 39 at (6216, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6216, 1544) facing 0 (id 39)
  1.45  RESERVE: zone 40 at (6264, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6264, 1544) facing 0 (id 40)
  1.45  RESERVE: zone 41 at (6312, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6312, 1544) facing 0 (id 41)
  1.45  RESERVE: zone 24 released
```
