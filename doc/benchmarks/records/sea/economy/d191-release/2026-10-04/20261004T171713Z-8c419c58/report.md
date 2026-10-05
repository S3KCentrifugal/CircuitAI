# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54000); wall 283 s
- DLL: build-theatres\d191-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T14:12:27
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-release\supreme\20261004T171227Z-e0a9c8dc\runs\20261004T171713Z-8c419c58\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:36.432103][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.4 min | `[t=00:00:51.187499][f=0002585] [SeaWatch] finished frame=2585 id=10240 def=armsy builder=28578` |
| expect `first-ship-exit` | seen at 1.9 min | `[t=00:00:52.979772][f=0003390] [SeaWatch] egress id=23873 yard=10240 seconds=13.1 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-release\supreme\20261004T171227Z-e0a9c8dc\runs\20261004T171713Z-8c419c58\screen_2026-10-04_17-13-37-859.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-release\supreme\20261004T171227Z-e0a9c8dc\runs\20261004T171713Z-8c419c58\screen_2026-10-04_17-13-59-995.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-release\supreme\20261004T171227Z-e0a9c8dc\runs\20261004T171713Z-8c419c58\screen_2026-10-04_17-15-03-471.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-release\supreme\20261004T171227Z-e0a9c8dc\runs\20261004T171713Z-8c419c58\screen_2026-10-04_17-16-55-880.png

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
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 1085/1100, energy +86.4 bank 1001/1001, units 6
  1.44  [Playtest] finished armsy team 0 at 1.44 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +4.3 bank 556/1200, energy +94.0 bank 30/1151, units 10
  2.31  [Playtest] finished armtide team 0 at 2.31 min
  2.52  [Playtest] finished armtide team 0 at 2.52 min
  2.70  [Playtest] finished armtide team 0 at 2.70 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.6 bank 0/1200, energy +163.3 bank 1351/1351, units 18
  3.24  [Playtest] finished armtide team 0 at 3.24 min
  3.43  [Playtest] finished armmex team 0 at 3.43 min
  3.57  [Playtest] finished armtide team 0 at 3.57 min
  3.83  [Playtest] finished armmex team 0 at 3.83 min
  3.86  [Playtest] finished armtide team 0 at 3.86 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.9 bank 39/1300, energy +222.4 bank 1487/1501, units 23
  4.10  [Playtest] finished armmex team 0 at 4.10 min
  4.26  [Playtest] finished armtide team 0 at 4.26 min
  4.41  [Playtest] finished armmex team 0 at 4.41 min
  4.50  [Playtest] finished armtide team 0 at 4.50 min
  4.83  [Playtest] finished armmex team 0 at 4.82 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +17.3 bank 62/1450, energy +269.0 bank 1584/1601, units 29
  5.00  [Playtest] target team 0 at (4814, 11077) from its start position
  5.00  [Playtest] camera requested (4814,11077) height=2200
  5.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (4814, 11077)
  5.12  [Playtest] finished armfmkr team 0 at 5.12 min
  5.23  [Playtest] finished armmex team 0 at 5.23 min
  5.39  [Playtest] finished armfmkr team 0 at 5.39 min
  5.53  [Playtest] finished armmex team 0 at 5.53 min
  5.81  [Playtest] finished armmex team 0 at 5.81 min
  5.82  [Playtest] finished armtide team 0 at 5.82 min
  5.97  [Playtest] finished armllt team 0 at 5.97 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +24.3 bank 297/1600, energy +289.9 bank 1314/1701, units 39
  6.14  [Playtest] finished armtide team 0 at 6.14 min
  6.15  [Playtest] finished armrad team 0 at 6.15 min
  6.31  [Playtest] finished armtide team 0 at 6.31 min
  6.40  [Playtest] finished armtide team 0 at 6.40 min
  6.56  [Playtest] finished armnanotcplat team 0 at 6.56 min
  6.66  [Playtest] finished armtide team 0 at 6.66 min
  6.67  [Playtest] finished armmex team 0 at 6.67 min
  6.78  [Playtest] finished armtide team 0 at 6.78 min
  6.85  [Playtest] finished armllt team 0 at 6.85 min
  6.91  [Playtest] finished armtide team 0 at 6.91 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +28.5 bank 95/1650, energy +382.3 bank 1952/2001, units 48
  7.36  [Playtest] finished armfmkr team 0 at 7.36 min
  7.64  [Playtest] finished armtide team 0 at 7.64 min
  7.82  [Playtest] finished armtide team 0 at 7.82 min
  7.93  [Playtest] finished armmex team 0 at 7.93 min
  7.99  [Playtest] finished armtide team 0 at 7.99 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +31.5 bank 71/1700, energy +465.7 bank 1905/2251, units 56
  8.36  [Playtest] finished armfmkr team 0 at 8.36 min
  8.50  [Playtest] finished armmex team 0 at 8.50 min
  8.51  [Playtest] finished armfmkr team 0 at 8.51 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +35.1 bank 361/1750, energy +461.6 bank 1847/2251, units 62
  9.07  [Playtest] finished armtide team 0 at 9.07 min
  9.16  [Playtest] finished armtide team 0 at 9.16 min
  9.21  [Playtest] finished armmex team 0 at 9.21 min
  9.34  [Playtest] finished armtide team 0 at 9.34 min
  9.57  [Playtest] finished armtl team 0 at 9.57 min
  9.68  [Playtest] finished armtide team 0 at 9.68 min
  9.80  [Playtest] finished armtl team 0 at 9.80 min
  9.99  [Playtest] finished armtide team 0 at 9.99 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +36.3 bank 687/1800, energy +590.4 bank 1977/2551, units 78
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 10.02  [Playtest] finished armmex team 0 at 10.02 min
 10.06  [Playtest] finished armnanotcplat team 0 at 10.06 min
 10.18  [Playtest] finished armtide team 0 at 10.18 min
 10.24  [Playtest] finished armfmkr team 0 at 10.24 min
 10.29  [Playtest] finished armfrad team 0 at 10.29 min
 10.34  [Playtest] finished armtide team 0 at 10.34 min
 10.63  [Playtest] finished armtide team 0 at 10.63 min
 10.72  [Playtest] finished armtl team 0 at 10.72 min
 10.77  [Playtest] finished armtide team 0 at 10.77 min
 10.96  [Playtest] finished armmex team 0 at 10.96 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +44.0 bank 1516/1900, energy +647.3 bank 2389/2751, units 91
 11.02  [Playtest] finished armfrad team 0 at 11.02 min
 11.14  [Playtest] finished armtide team 0 at 11.14 min
 11.17  [Playtest] finished armtl team 0 at 11.17 min
 11.31  [Playtest] finished armtide team 0 at 11.31 min
 11.45  [Playtest] finished armtide team 0 at 11.45 min
 11.46  [Playtest] finished armfmkr team 0 at 11.46 min
 11.50  [Playtest] finished armmakr team 0 at 11.50 min
 11.80  [Playtest] finished armfmkr team 0 at 11.80 min
 11.89  [Playtest] finished armtide team 0 at 11.89 min
 11.97  [Playtest] finished armestor team 0 at 11.97 min
 11.99  [Playtest] finished armmex team 0 at 11.99 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +39.4 bank 1509/1950, energy +772.6 bank 2850/8951, units 105
 12.23  [Playtest] finished armtide team 0 at 12.23 min
 12.26  [Playtest] finished armmstor team 0 at 12.26 min
 12.52  [Playtest] finished armtl team 0 at 12.52 min
 12.56  [Playtest] finished armtide team 0 at 12.56 min
 12.68  [Playtest] finished armllt team 0 at 12.68 min
 12.83  [Playtest] finished armmex team 0 at 12.83 min
 12.89  [Playtest] finished armfmkr team 0 at 12.89 min
 12.90  [Playtest] finished armtide team 0 at 12.90 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +52.6 bank 2386/5000, energy +842.8 bank 8118/9101, units 115
 13.23  [Playtest] finished armtide team 0 at 13.23 min
 13.34  [Playtest] finished armfrad team 0 at 13.34 min
 13.38  [Playtest] finished armtl team 0 at 13.38 min
 13.42  [Playtest] finished armfmkr team 0 at 13.42 min
 13.56  [Playtest] finished armtide team 0 at 13.56 min
 13.72  [Playtest] finished armfrad team 0 at 13.72 min
 13.78  [Playtest] finished armmex team 0 at 13.77 min
 13.96  [Playtest] finished armllt team 0 at 13.96 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +53.9 bank 4428/5050, energy +879.7 bank 7088/9201, units 124
 14.15  [Playtest] finished armrad team 0 at 14.15 min
 14.17  [Playtest] finished armnanotcplat team 0 at 14.17 min
 14.31  [Playtest] finished armnanotcplat team 0 at 14.31 min
 14.51  [Playtest] finished armtide team 0 at 14.51 min
 14.85  [Playtest] finished armtide team 0 at 14.85 min
 14.95  [Playtest] finished armnanotcplat team 0 at 14.95 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +55.4 bank 4566/5050, energy +923.5 bank 7019/9301, units 140
 15.05  [Playtest] finished armrad team 0 at 15.06 min
 15.19  [Playtest] finished armtide team 0 at 15.19 min
 15.57  [Playtest] finished armtide team 0 at 15.57 min
 15.60  [Playtest] finished armnanotcplat team 0 at 15.60 min
 15.62  [Playtest] finished armmakr team 0 at 15.62 min
 15.70  [Playtest] finished armnanotcplat team 0 at 15.70 min
 15.79  [Playtest] finished armnanotcplat team 0 at 15.79 min
 15.90  [Playtest] finished armtide team 0 at 15.90 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +56.9 bank 4248/5050, energy +989.8 bank 7852/9451, units 155
 16.23  [Playtest] finished armnanotcplat team 0 at 16.23 min
 16.25  [Playtest] finished armtide team 0 at 16.25 min
 16.32  [Playtest] finished armllt team 0 at 16.32 min
 16.72  [Playtest] finished armtide team 0 at 16.72 min
 16.84  [Playtest] finished armtide team 0 at 16.84 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +54.6 bank 3795/5050, energy +1052.6 bank 7909/9601, units 168
 17.05  [Playtest] finished armtide team 0 at 17.05 min
 17.26  [Playtest] finished armrad team 0 at 17.26 min
 17.39  [Playtest] finished armtide team 0 at 17.39 min
 17.53  [Playtest] finished armllt team 0 at 17.53 min
 17.54  [Playtest] finished armfmkr team 0 at 17.54 min
 17.69  [Playtest] finished armtide team 0 at 17.69 min
 17.99  [Playtest] finished armtide team 0 at 17.99 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +48.9 bank 4224/5050, energy +1104.5 bank 7978/9801, units 184
 18.49  [Playtest] finished armnanotcplat team 0 at 18.49 min
 18.63  [Playtest] finished armtide team 0 at 18.63 min
 18.88  [Playtest] finished armtide team 0 at 18.88 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +57.9 bank 4109/5050, energy +1178.8 bank 7700/9901, units 203
 19.25  [Playtest] finished armtide team 0 at 19.25 min
 19.50  [Playtest] finished armtide team 0 at 19.50 min
 19.80  [Playtest] finished armtide team 0 at 19.80 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +47.7 bank 4227/5050, energy +1219.1 bank 8118/10051, units 214
 20.00  [Playtest] camera requested (4814,11077) height=2200
 20.02  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (4814, 11077)
 20.95  [Playtest] finished armfmkr team 0 at 20.95 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +45.9 bank 4236/5050, energy +1239.7 bank 8241/10051, units 226
 21.56  [Playtest] finished armmakr team 0 at 21.56 min
 21.67  [Playtest] finished armmakr team 0 at 21.67 min
 21.76  [Playtest] finished armnanotcplat team 0 at 21.76 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +45.4 bank 3999/5050, energy +1241.2 bank 8195/10051, units 241
 23.00  [Playtest] eco team 0 at 23.0 min: metal +44.9 bank 3629/5050, energy +1238.9 bank 8130/10051, units 249
 24.00  [Playtest] eco team 0 at 24.0 min: metal +60.0 bank 4092/5050, energy +1216.0 bank 7451/10051, units 259
 25.00  [Playtest] eco team 0 at 25.0 min: metal +46.0 bank 3994/5050, energy +1241.2 bank 6706/10051, units 266
 25.56  [Playtest] finished armrad team 0 at 25.56 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +58.7 bank 4124/5050, energy +1240.6 bank 7666/10051, units 283
 26.11  [Playtest] finished armfrad team 0 at 26.11 min
 26.12  [Playtest] finished armtl team 0 at 26.12 min
 26.29  [Playtest] finished armtl team 0 at 26.29 min
 26.70  [Playtest] finished armtl team 0 at 26.70 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +44.9 bank 3923/5050, energy +1222.8 bank 8069/10051, units 293
 27.14  [Playtest] finished armtl team 0 at 27.14 min
 27.96  [Playtest] finished armtl team 0 at 27.96 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +60.9 bank 4263/5050, energy +1212.1 bank 7356/10051, units 300
 28.35  [Playtest] finished armtide team 0 at 28.35 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +60.9 bank 4289/5050, energy +1262.7 bank 8908/10101, units 308
 29.00  [Playtest] camera requested (4814,11077) height=2200
 29.02  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (4814, 11077)
 30.00  [Playtest] eco team 0 at 30.0 min: metal +44.9 bank 4015/5050, energy +1262.2 bank 8178/10101, units 322
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
