# Playtest report: PASS

- Verdict: **PASS** (reached 25 min)
- Game time reached: 25.0 min (frame 45000); wall 204 s
- DLL: build-theatres\d192-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T15:28:36
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-final\supreme\20261004T182836Z-fb202298\runs\20261004T183203Z-4ecac210\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:36.901214][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.4 min | `[t=00:00:52.096256][f=0002600] [SeaWatch] finished frame=2600 id=10240 def=armsy builder=28578` |
| expect `first-ship-exit` | seen at 2.4 min | `[t=00:00:56.053244][f=0004380] [SeaWatch] egress id=23873 yard=10240 seconds=44.4 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-final\supreme\20261004T182836Z-fb202298\runs\20261004T183203Z-4ecac210\screen_2026-10-04_18-29-47-528.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-final\supreme\20261004T182836Z-fb202298\runs\20261004T183203Z-4ecac210\screen_2026-10-04_18-30-08-518.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-final\supreme\20261004T182836Z-fb202298\runs\20261004T183203Z-4ecac210\screen_2026-10-04_18-31-09-403.png

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
  0.20  [Playtest] finished armmex team 0 at 0.20 min
  0.22  [Team][Roster] first mex 6887 at 4608,11072
  0.22  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4771|11077|0|7|1|4608|11072
  0.39  [Playtest] finished armmex team 0 at 0.39 min
  0.51  [Playtest] finished armwin team 0 at 0.51 min
  0.61  [Playtest] finished armwin team 0 at 0.61 min
  0.72  [Playtest] finished armwin team 0 at 0.72 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 1081/1100, energy +74.1 bank 1001/1001, units 6
  1.44  [Playtest] finished armsy team 0 at 1.44 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.6 bank 636/1200, energy +72.9 bank 4/1151, units 9
  2.95  [Playtest] finished armtide team 0 at 2.95 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +4.3 bank 409/1200, energy +99.1 bank 40/1251, units 12
  3.28  [Playtest] finished armtide team 0 at 3.28 min
  3.45  [Playtest] finished armmex team 0 at 3.45 min
  3.85  [Playtest] finished armmex team 0 at 3.85 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +13.7 bank 0/1300, energy +111.2 bank 181/1301, units 18
  4.16  [Playtest] finished armmex team 0 at 4.16 min
  4.18  [Playtest] finished armtide team 0 at 4.18 min
  4.52  [Playtest] finished armmex team 0 at 4.52 min
  4.94  [Playtest] finished armmex team 0 at 4.94 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +17.3 bank 13/1450, energy +126.6 bank 1014/1351, units 22
  5.00  [Playtest] target team 0 at (4814, 11077) from its start position
  5.00  [Playtest] camera requested (4814,11077) height=2200
  5.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (4814, 11077)
  5.08  [Playtest] finished armtide team 0 at 5.07 min
  5.24  [Playtest] finished armtide team 0 at 5.24 min
  5.34  [Playtest] finished armmex team 0 at 5.34 min
  5.64  [Playtest] finished armmex team 0 at 5.64 min
  5.66  [Playtest] finished armtide team 0 at 5.66 min
  5.80  [Playtest] finished armrad team 0 at 5.80 min
  5.95  [Playtest] finished armtide team 0 at 5.95 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +21.9 bank 267/1550, energy +220.9 bank 1584/1601, units 30
  6.03  [Playtest] finished armmex team 0 at 6.03 min
  6.18  [Playtest] finished armtide team 0 at 6.18 min
  6.21  [Playtest] finished armllt team 0 at 6.21 min
  6.62  [Playtest] finished armtide team 0 at 6.62 min
  6.66  [Playtest] finished armmex team 0 at 6.66 min
  6.83  [Playtest] finished armllt team 0 at 6.83 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +26.5 bank 788/1650, energy +270.2 bank 1688/1701, units 38
  7.11  [Playtest] finished armtide team 0 at 7.11 min
  7.24  [Playtest] finished armnanotcplat team 0 at 7.24 min
  7.91  [Playtest] finished armmex team 0 at 7.91 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +28.8 bank 1528/1700, energy +308.3 bank 1783/1801, units 44
  8.27  [Playtest] finished armfmkr team 0 at 8.27 min
  8.47  [Playtest] finished armmex team 0 at 8.47 min
  8.72  [Playtest] finished armtide team 0 at 8.72 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +32.1 bank 1663/1750, energy +340.7 bank 1483/1901, units 49
  9.08  [Playtest] finished armtide team 0 at 9.08 min
  9.16  [Playtest] finished armmex team 0 at 9.16 min
  9.80  [Playtest] finished armtide team 0 at 9.80 min
  9.95  [Playtest] finished armmex team 0 at 9.95 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +36.7 bank 1795/1850, energy +390.7 bank 1994/2051, units 57
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 10.19  [Playtest] finished armfmkr team 0 at 10.19 min
 10.51  [Playtest] finished armtide team 0 at 10.51 min
 10.69  [Playtest] finished armtide team 0 at 10.69 min
 10.79  [Playtest] finished armfmkr team 0 at 10.79 min
 10.80  [Playtest] finished armtide team 0 at 10.80 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +37.9 bank 1782/1850, energy +436.3 bank 1728/2201, units 64
 11.01  [Playtest] finished armtide team 0 at 11.01 min
 11.26  [Playtest] finished armtide team 0 at 11.26 min
 11.48  [Playtest] finished armmex team 0 at 11.48 min
 11.49  [Playtest] finished armtide team 0 at 11.49 min
 11.74  [Playtest] finished armtide team 0 at 11.74 min
 11.89  [Playtest] finished armnanotcplat team 0 at 11.89 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +38.0 bank 1735/1900, energy +536.3 bank 1698/2401, units 75
 12.05  [Playtest] finished armnanotcplat team 0 at 12.05 min
 12.07  [Playtest] finished armmstor team 0 at 12.07 min
 12.12  [Playtest] finished armtide team 0 at 12.12 min
 12.20  [Playtest] finished armestor team 0 at 12.20 min
 12.25  [Playtest] finished armnanotcplat team 0 at 12.25 min
 12.40  [Playtest] finished armtide team 0 at 12.40 min
 12.68  [Playtest] finished armfrad team 0 at 12.68 min
 12.76  [Playtest] finished armmakr team 0 at 12.76 min
 12.85  [Playtest] finished armtide team 0 at 12.85 min
 12.85  [Playtest] finished armtl team 0 at 12.85 min
 12.89  [Playtest] finished armmakr team 0 at 12.89 min
 12.99  [Playtest] finished armmakr team 0 at 12.99 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +43.0 bank 2870/4900, energy +601.0 bank 8062/8551, units 85
 13.10  [Playtest] finished armmakr team 0 at 13.10 min
 13.32  [Playtest] finished armtl team 0 at 13.32 min
 13.50  [Playtest] finished armtide team 0 at 13.50 min
 13.78  [Playtest] finished armfmkr team 0 at 13.78 min
 13.78  [Playtest] finished armtl team 0 at 13.78 min
 13.95  [Playtest] finished armtide team 0 at 13.95 min
 13.98  [Playtest] finished armtl team 0 at 13.98 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +45.6 bank 3908/4900, energy +625.3 bank 6779/8651, units 94
 14.39  [Playtest] finished armtide team 0 at 14.39 min
 14.59  [Playtest] finished armnanotcplat team 0 at 14.59 min
 14.98  [Playtest] finished armmex team 0 at 14.98 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +46.4 bank 4036/4950, energy +661.7 bank 6352/8701, units 108
 15.12  [Playtest] finished armtide team 0 at 15.12 min
 15.30  [Playtest] finished armfrad team 0 at 15.30 min
 15.45  [Playtest] finished armtide team 0 at 15.45 min
 15.83  [Playtest] finished armmex team 0 at 15.83 min
 15.84  [Playtest] finished armtide team 0 at 15.84 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +50.6 bank 4188/5000, energy +712.2 bank 6997/8851, units 119
 16.18  [Playtest] finished armtide team 0 at 16.18 min
 16.30  [Playtest] finished armtl team 0 at 16.30 min
 16.52  [Playtest] finished armtide team 0 at 16.52 min
 16.56  [Playtest] finished armtl team 0 at 16.56 min
 16.87  [Playtest] finished armtide team 0 at 16.87 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +50.6 bank 4005/5000, energy +800.1 bank 6718/9001, units 128
 17.22  [Playtest] finished armtide team 0 at 17.22 min
 17.23  [Playtest] finished armfrad team 0 at 17.23 min
 17.58  [Playtest] finished armtide team 0 at 17.58 min
 17.92  [Playtest] finished armtide team 0 at 17.92 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +50.6 bank 4252/5000, energy +849.2 bank 6911/9151, units 139
 18.26  [Playtest] finished armtide team 0 at 18.26 min
 18.60  [Playtest] finished armtide team 0 at 18.60 min
 18.81  [Playtest] finished armnanotcplat team 0 at 18.81 min
 18.94  [Playtest] finished armtide team 0 at 18.94 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +42.6 bank 3698/5000, energy +925.8 bank 6920/9301, units 148
 19.28  [Playtest] finished armtide team 0 at 19.28 min
 19.35  [Playtest] finished armnanotcplat team 0 at 19.35 min
 19.47  [Playtest] finished armnanotcplat team 0 at 19.47 min
 19.61  [Playtest] finished armtide team 0 at 19.61 min
 19.61  [Playtest] finished armfmkr team 0 at 19.61 min
 19.92  [Playtest] finished armfmkr team 0 at 19.92 min
 19.96  [Playtest] finished armtide team 0 at 19.96 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +52.5 bank 4188/5000, energy +980.3 bank 7641/9451, units 161
 20.00  [Playtest] camera requested (4814,11077) height=2200
 20.02  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (4814, 11077)
 20.07  [Playtest] finished armfmkr team 0 at 20.07 min
 20.31  [Playtest] finished armtide team 0 at 20.31 min
 20.66  [Playtest] finished armtide team 0 at 20.66 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +53.6 bank 3812/5000, energy +1009.4 bank 8494/9551, units 171
 21.04  [Playtest] finished armtide team 0 at 21.04 min
 21.41  [Playtest] finished armtide team 0 at 21.42 min
 21.43  [Playtest] finished armnanotcplat team 0 at 21.43 min
 21.59  [Playtest] finished armfmkr team 0 at 21.59 min
 21.80  [Playtest] finished armtide team 0 at 21.80 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +53.9 bank 3936/5000, energy +1061.5 bank 7915/9701, units 185
 22.20  [Playtest] finished armtide team 0 at 22.20 min
 22.28  [Playtest] finished armfmkr team 0 at 22.28 min
 22.58  [Playtest] finished armtide team 0 at 22.58 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +55.6 bank 3963/5000, energy +1134.1 bank 8232/9801, units 193
 24.00  [Playtest] eco team 0 at 24.0 min: metal +42.6 bank 3702/5000, energy +1136.7 bank 7892/9801, units 199
 25.00  [Playtest] eco team 0 at 25.0 min: metal +55.6 bank 4032/5000, energy +1113.2 bank 7239/9801, units 207
```

## Native lines (all AIs, first 120)

```
  1.45  RESERVE: zone 1 at (5800, 10904) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (5800, 10904) facing 2 (id 1)
  1.45  RESERVE: zone 1 released
  1.45  RESERVE: corridor 2 at (5840, 10448) facing 2, 12x30 cells: 210 of 360 held
  1.45  RESERVE: zone 3 at (5968, 11520) facing 2, 40x40 cells: 1600 of 1600 held
  1.45  RESERVE: zone 3 released
  1.45  RESERVE: zone 4 at (6096, 11520) facing 2, 40x40 cells: 1600 of 1600 held
  1.45  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6096, 11424) facing 2: 2 of 16 slots (group 2, held, zone)
  1.45  RESERVE: zone 4 released
  1.45  RESERVE: zone 5 at (6224, 11520) facing 2, 40x40 cells: 1600 of 1600 held
  1.45  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6224, 11424) facing 2: 10 of 16 slots (group 3, held, zone)
  1.45  RESERVE: zone 5 released
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
  1.45  RESERVE: zone 25 released
  1.45  RESERVE: zone 26 released
```
