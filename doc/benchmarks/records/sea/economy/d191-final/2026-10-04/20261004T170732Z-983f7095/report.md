# Playtest report: PASS

- Verdict: **PASS** (reached 25 min)
- Game time reached: 25.0 min (frame 45000); wall 159 s
- DLL: build-theatres\d191-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T14:04:50
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-final\supreme\20261004T170450Z-a15c0895\runs\20261004T170732Z-983f7095\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:31.575888][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.4 min | `[t=00:00:44.808396][f=0002585] [SeaWatch] finished frame=2585 id=10240 def=armsy builder=28578` |
| expect `first-ship-exit` | seen at 2.9 min | `[t=00:00:50.665736][f=0005220] [SeaWatch] egress id=7065 yard=10240 seconds=6.3 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-final\supreme\20261004T170450Z-a15c0895\runs\20261004T170732Z-983f7095\screen_2026-10-04_17-05-54-187.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-final\supreme\20261004T170450Z-a15c0895\runs\20261004T170732Z-983f7095\screen_2026-10-04_17-06-15-804.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-final\supreme\20261004T170450Z-a15c0895\runs\20261004T170732Z-983f7095\screen_2026-10-04_17-07-02-727.png

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
  0.38  [Playtest] finished armmex team 0 at 0.38 min
  0.49  [Playtest] finished armwin team 0 at 0.49 min
  0.60  [Playtest] finished armwin team 0 at 0.60 min
  0.71  [Playtest] finished armwin team 0 at 0.71 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 1085/1100, energy +86.4 bank 1001/1001, units 6
  1.44  [Playtest] finished armsy team 0 at 1.44 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.6 bank 609/1200, energy +93.8 bank 76/1151, units 9
  2.25  [Playtest] finished armtide team 0 at 2.25 min
  2.42  [Playtest] finished armtide team 0 at 2.42 min
  2.59  [Playtest] finished armtide team 0 at 2.59 min
  2.78  [Playtest] finished armtide team 0 at 2.78 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.6 bank 0/1200, energy +185.0 bank 1401/1401, units 18
  3.28  [Playtest] finished armtide team 0 at 3.28 min
  3.44  [Playtest] finished armmex team 0 at 3.44 min
  3.64  [Playtest] finished armtide team 0 at 3.64 min
  3.83  [Playtest] finished armmex team 0 at 3.83 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.9 bank 14/1300, energy +226.6 bank 1484/1501, units 23
  4.10  [Playtest] finished armmex team 0 at 4.10 min
  4.20  [Playtest] finished armtide team 0 at 4.20 min
  4.40  [Playtest] finished armmex team 0 at 4.40 min
  4.43  [Playtest] finished armtide team 0 at 4.43 min
  4.80  [Playtest] finished armmex team 0 at 4.80 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +17.3 bank 221/1450, energy +261.8 bank 1588/1601, units 31
  5.00  [Playtest] target team 0 at (4814, 11077) from its start position
  5.00  [Playtest] camera requested (4814,11077) height=2200
  5.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (4814, 11077)
  5.18  [Playtest] finished armmex team 0 at 5.18 min
  5.20  [Playtest] finished armmex team 0 at 5.20 min
  5.43  [Playtest] finished armfmkr team 0 at 5.43 min
  5.52  [Playtest] finished armmex team 0 at 5.52 min
  5.74  [Playtest] finished armfmkr team 0 at 5.74 min
  5.81  [Playtest] finished armmex team 0 at 5.81 min
  5.98  [Playtest] finished armllt team 0 at 5.98 min
  5.98  [Playtest] finished armfmkr team 0 at 5.98 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +27.3 bank 843/1650, energy +282.6 bank 1373/1701, units 40
  6.07  [Playtest] finished armrad team 0 at 6.07 min
  6.29  [Playtest] finished armtide team 0 at 6.29 min
  6.38  [Playtest] finished armtide team 0 at 6.38 min
  6.50  [Playtest] finished armtide team 0 at 6.50 min
  6.53  [Playtest] finished armmex team 0 at 6.53 min
  6.66  [Playtest] finished armtide team 0 at 6.66 min
  6.72  [Playtest] finished armllt team 0 at 6.72 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +31.8 bank 1606/1700, energy +373.3 bank 1695/1951, units 51
  7.07  [Playtest] finished armfmkr team 0 at 7.07 min
  7.48  [Playtest] finished armtide team 0 at 7.48 min
  7.57  [Playtest] finished armtide team 0 at 7.57 min
  7.68  [Playtest] finished armtide team 0 at 7.68 min
  7.77  [Playtest] finished armtide team 0 at 7.77 min
  7.81  [Playtest] finished armmex team 0 at 7.81 min
  7.87  [Playtest] finished armtide team 0 at 7.87 min
  7.95  [Playtest] finished armtide team 0 at 7.95 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +35.1 bank 1707/1750, energy +483.8 bank 1976/2251, units 61
  8.03  [Playtest] finished armtide team 0 at 8.03 min
  8.38  [Playtest] finished armmex team 0 at 8.38 min
  8.82  [Playtest] finished armtl team 0 at 8.82 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +37.4 bank 1797/1800, energy +527.3 bank 2166/2351, units 72
  9.14  [Playtest] finished armfrad team 0 at 9.14 min
  9.22  [Playtest] finished armfmkr team 0 at 9.23 min
  9.28  [Playtest] finished armtide team 0 at 9.28 min
  9.43  [Playtest] finished armtl team 0 at 9.43 min
  9.45  [Playtest] finished armfmkr team 0 at 9.45 min
  9.59  [Playtest] finished armtide team 0 at 9.59 min
  9.64  [Playtest] finished armfmkr team 0 at 9.64 min
  9.69  [Playtest] finished armmex team 0 at 9.69 min
  9.71  [Playtest] finished armfmkr team 0 at 9.71 min
  9.89  [Playtest] finished armtl team 0 at 9.89 min
  9.91  [Playtest] finished armtide team 0 at 9.91 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +41.4 bank 1848/1850, energy +578.7 bank 2066/2501, units 80
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 10.23  [Playtest] finished armtide team 0 at 10.23 min
 10.26  [Playtest] finished armtl team 0 at 10.26 min
 10.28  [Playtest] finished armfrad team 0 at 10.28 min
 10.55  [Playtest] finished armtide team 0 at 10.55 min
 10.61  [Playtest] finished armmex team 0 at 10.61 min
 10.81  [Playtest] finished armllt team 0 at 10.81 min
 10.82  [Playtest] finished armmex team 0 at 10.82 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +46.0 bank 1948/1950, energy +632.4 bank 2150/2601, units 88
 11.10  [Playtest] finished armmex team 0 at 11.10 min
 11.36  [Playtest] finished armtl team 0 at 11.36 min
 11.52  [Playtest] finished armtide team 0 at 11.52 min
 11.56  [Playtest] finished armmstor team 0 at 11.56 min
 11.65  [Playtest] finished armtl team 0 at 11.65 min
 11.82  [Playtest] finished armestor team 0 at 11.82 min
 11.85  [Playtest] finished armtide team 0 at 11.85 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +42.6 bank 2401/5000, energy +649.7 bank 6699/8701, units 97
 12.13  [Playtest] finished armfrad team 0 at 12.13 min
 12.18  [Playtest] finished armtide team 0 at 12.18 min
 12.22  [Playtest] finished armfrad team 0 at 12.22 min
 12.23  [Playtest] finished armllt team 0 at 12.23 min
 12.51  [Playtest] finished armtide team 0 at 12.51 min
 12.86  [Playtest] finished armtide team 0 at 12.86 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +50.6 bank 4392/5000, energy +735.3 bank 8755/8851, units 102
 13.22  [Playtest] finished armtide team 0 at 13.22 min
 13.35  [Playtest] finished armmex team 0 at 13.35 min
 13.52  [Playtest] finished armllt team 0 at 13.52 min
 13.67  [Playtest] finished armtide team 0 at 13.67 min
 13.71  [Playtest] finished armrad team 0 at 13.71 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +52.9 bank 5048/5050, energy +770.0 bank 8857/8951, units 109
 14.01  [Playtest] finished armtide team 0 at 14.01 min
 14.35  [Playtest] finished armtide team 0 at 14.35 min
 14.37  [Playtest] finished armfmkr team 0 at 14.37 min
 14.53  [Playtest] finished armfmkr team 0 at 14.53 min
 14.66  [Playtest] finished armtide team 0 at 14.66 min
 14.68  [Playtest] finished armrad team 0 at 14.68 min
 14.77  [Playtest] finished armfmkr team 0 at 14.77 min
 14.99  [Playtest] finished armtide team 0 at 14.99 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +54.8 bank 5049/5050, energy +842.3 bank 7159/9151, units 118
 15.18  [Playtest] finished armrad team 0 at 15.18 min
 15.32  [Playtest] finished armtide team 0 at 15.32 min
 15.36  [Playtest] finished armfmkr team 0 at 15.36 min
 15.48  [Playtest] finished armllt team 0 at 15.48 min
 15.90  [Playtest] finished armllt team 0 at 15.90 min
 15.99  [Playtest] finished armtide team 0 at 15.99 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +55.4 bank 5048/5050, energy +883.3 bank 7284/9251, units 124
 16.35  [Playtest] finished armtide team 0 at 16.35 min
 16.72  [Playtest] finished armtide team 0 at 16.72 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +56.1 bank 5048/5050, energy +947.6 bank 7404/9351, units 128
 17.05  [Playtest] finished armtide team 0 at 17.05 min
 17.41  [Playtest] finished armtide team 0 at 17.41 min
 17.75  [Playtest] finished armtide team 0 at 17.75 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +56.9 bank 5048/5050, energy +1010.4 bank 7765/9501, units 131
 18.40  [Playtest] finished armtide team 0 at 18.40 min
 18.74  [Playtest] finished armtide team 0 at 18.74 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +56.9 bank 5047/5050, energy +1018.1 bank 8284/9601, units 136
 19.09  [Playtest] finished armtide team 0 at 19.09 min
 19.29  [Playtest] finished armfmkr team 0 at 19.29 min
 19.41  [Playtest] finished armtide team 0 at 19.41 min
 19.73  [Playtest] finished armtide team 0 at 19.73 min
 19.92  [Playtest] finished armtide team 0 at 19.92 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +57.9 bank 5048/5050, energy +1126.7 bank 8691/9801, units 140
 20.00  [Playtest] camera requested (4814,11077) height=2200
 20.02  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (4814, 11077)
 20.50  [Playtest] finished armtide team 0 at 20.50 min
 20.69  [Playtest] finished armtide team 0 at 20.69 min
 20.87  [Playtest] finished armtide team 0 at 20.87 min
 20.97  [Playtest] finished armfmkr team 0 at 20.97 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +58.4 bank 5047/5050, energy +1167.4 bank 9792/9951, units 147
 21.06  [Playtest] finished armtide team 0 at 21.06 min
 21.12  [Playtest] finished armfmkr team 0 at 21.12 min
 21.25  [Playtest] finished armtide team 0 at 21.25 min
 21.25  [Playtest] finished armfmkr team 0 at 21.25 min
 21.66  [Playtest] finished armfmkr team 0 at 21.66 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +59.1 bank 5049/5050, energy +1220.6 bank 8043/10051, units 151
 23.00  [Playtest] eco team 0 at 23.0 min: metal +59.4 bank 5048/5050, energy +1218.1 bank 8046/10051, units 156
 24.00  [Playtest] eco team 0 at 24.0 min: metal +59.2 bank 5048/5050, energy +1202.8 bank 8037/10051, units 159
 25.00  [Playtest] eco team 0 at 25.0 min: metal +60.1 bank 5048/5050, energy +1220.5 bank 8069/10051, units 162
```

## Native lines (all AIs, first 120)

```
  1.43  RESERVE: zone 1 at (6472, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6472, 1496) facing 0 (id 1)
  1.43  RESERVE: zone 2 at (6520, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6520, 1496) facing 0 (id 2)
  1.43  RESERVE: zone 1 released
  1.43  RESERVE: zone 2 released
  1.43  RESERVE: zone 3 at (6408, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6408, 1512) facing 0 (id 3)
  1.43  RESERVE: zone 4 at (6456, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6456, 1512) facing 0 (id 4)
  1.43  RESERVE: zone 5 at (6504, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6504, 1512) facing 0 (id 5)
  1.43  RESERVE: zone 3 released
  1.43  RESERVE: zone 4 released
  1.43  RESERVE: zone 5 released
  1.43  RESERVE: zone 6 at (6328, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6328, 1496) facing 0 (id 6)
  1.43  RESERVE: zone 7 at (6376, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6376, 1496) facing 0 (id 7)
  1.43  RESERVE: zone 8 at (6424, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6424, 1496) facing 0 (id 8)
  1.43  RESERVE: zone 9 at (6472, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6472, 1496) facing 0 (id 9)
  1.43  RESERVE: zone 10 at (6520, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6520, 1496) facing 0 (id 10)
  1.43  RESERVE: zone 11 at (6328, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6328, 1544) facing 0 (id 11)
  1.43  RESERVE: zone 6 released
  1.43  RESERVE: zone 7 released
  1.43  RESERVE: zone 8 released
  1.43  RESERVE: zone 9 released
  1.43  RESERVE: zone 10 released
  1.43  RESERVE: zone 11 released
  1.43  RESERVE: zone 12 at (6264, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6264, 1448) facing 0 (id 12)
  1.43  RESERVE: zone 13 at (6312, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6312, 1448) facing 0 (id 13)
  1.43  RESERVE: zone 14 at (6360, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6360, 1448) facing 0 (id 14)
  1.43  RESERVE: zone 15 at (6408, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6408, 1448) facing 0 (id 15)
  1.43  RESERVE: zone 16 at (6456, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6456, 1448) facing 0 (id 16)
  1.43  RESERVE: zone 17 at (6264, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6264, 1496) facing 0 (id 17)
  1.43  RESERVE: zone 18 at (6312, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6312, 1496) facing 0 (id 18)
  1.43  RESERVE: zone 19 at (6360, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6360, 1496) facing 0 (id 19)
  1.43  RESERVE: zone 20 at (6408, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6408, 1496) facing 0 (id 20)
  1.43  RESERVE: zone 21 at (6456, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6456, 1496) facing 0 (id 21)
  1.43  RESERVE: zone 22 at (6264, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6264, 1544) facing 0 (id 22)
  1.43  RESERVE: zone 23 at (6312, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6312, 1544) facing 0 (id 23)
  1.43  RESERVE: zone 12 released
  1.43  RESERVE: zone 13 released
  1.43  RESERVE: zone 14 released
  1.43  RESERVE: zone 15 released
  1.43  RESERVE: zone 16 released
  1.43  RESERVE: zone 17 released
  1.43  RESERVE: zone 18 released
  1.43  RESERVE: zone 19 released
  1.43  RESERVE: zone 20 released
  1.43  RESERVE: zone 21 released
  1.43  RESERVE: zone 22 released
  1.43  RESERVE: zone 23 released
  1.43  RESERVE: zone 24 at (6216, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6216, 1400) facing 0 (id 24)
  1.43  RESERVE: zone 25 at (6264, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6264, 1400) facing 0 (id 25)
  1.43  RESERVE: zone 26 at (6312, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6312, 1400) facing 0 (id 26)
  1.43  RESERVE: zone 27 at (6360, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6360, 1400) facing 0 (id 27)
  1.43  RESERVE: zone 28 at (6408, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6408, 1400) facing 0 (id 28)
  1.43  RESERVE: zone 29 at (6216, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6216, 1448) facing 0 (id 29)
  1.43  RESERVE: zone 30 at (6264, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6264, 1448) facing 0 (id 30)
  1.43  RESERVE: zone 31 at (6312, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6312, 1448) facing 0 (id 31)
  1.43  RESERVE: zone 32 at (6360, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6360, 1448) facing 0 (id 32)
  1.43  RESERVE: zone 33 at (6408, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6408, 1448) facing 0 (id 33)
  1.43  RESERVE: zone 34 at (6216, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6216, 1496) facing 0 (id 34)
  1.43  RESERVE: zone 35 at (6264, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6264, 1496) facing 0 (id 35)
  1.43  RESERVE: zone 36 at (6312, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6312, 1496) facing 0 (id 36)
  1.43  RESERVE: zone 37 at (6360, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6360, 1496) facing 0 (id 37)
  1.43  RESERVE: zone 38 at (6408, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6408, 1496) facing 0 (id 38)
  1.43  RESERVE: zone 39 at (6216, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6216, 1544) facing 0 (id 39)
  1.43  RESERVE: zone 40 at (6264, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6264, 1544) facing 0 (id 40)
  1.43  RESERVE: zone 41 at (6312, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (6312, 1544) facing 0 (id 41)
  1.43  RESERVE: zone 24 released
  1.43  RESERVE: zone 25 released
  1.43  RESERVE: zone 26 released
  1.43  RESERVE: zone 27 released
  1.43  RESERVE: zone 28 released
  1.43  RESERVE: zone 29 released
  1.43  RESERVE: zone 30 released
  1.43  RESERVE: zone 31 released
  1.43  RESERVE: zone 32 released
  1.43  RESERVE: zone 33 released
  1.43  RESERVE: zone 34 released
  1.43  RESERVE: zone 35 released
  1.43  RESERVE: zone 36 released
  1.43  RESERVE: zone 37 released
  1.43  RESERVE: zone 38 released
```
