# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.2 min (frame 54350); wall 183 s
- DLL: build-theatres\d189-build-3\SkirmishAI.dll (e3e7562cd0a45623); AI BARbTest/test; staged 2026-10-04T06:50:27
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-candidate-2\glacial\20261004T095027Z-e2278147\runs\20261004T095333Z-455efb5d\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:29.673734][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.8 min | `[t=00:00:42.589767][f=0001464] [SeaWatch] finished frame=1464 id=3580 def=armsy builder=17544` |
| expect `first-ship-exit` | seen at 2.5 min | `[t=00:00:49.468679][f=0004560] [SeaWatch] egress id=21269 yard=3580 seconds=4.6 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-candidate-2\glacial\20261004T095027Z-e2278147\runs\20261004T095333Z-455efb5d\screen_2026-10-04_09-51-31-594.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-candidate-2\glacial\20261004T095027Z-e2278147\runs\20261004T095333Z-455efb5d\screen_2026-10-04_09-51-52-621.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-candidate-2\glacial\20261004T095027Z-e2278147\runs\20261004T095333Z-455efb5d\screen_2026-10-04_09-52-36-099.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-candidate-2\glacial\20261004T095027Z-e2278147\runs\20261004T095333Z-455efb5d\screen_2026-10-04_09-53-24-817.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (1430, 4000) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (700, 4600) units 1
  0.00  [Playtest] frame 1 team 2 ally 0 side cortex ai true dead false start (1900, 5800) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (12925, 4000) units 1
  0.00  [Playtest] frame 1 team 4 ally 1 side armada ai true dead false start (13700, 4600) units 1
  0.00  [Playtest] frame 1 team 5 ally 1 side cortex ai true dead false start (12618, 5800) units 1
  0.00  [Playtest] frame 1 team 6 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 7 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (1430, 4000) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (700, 4600) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (1900, 5800) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (12925, 4000) units 1
  0.05  [Playtest] frame 90 team 4 ally 1 side armada ai true dead false start (13700, 4600) units 1
  0.05  [Playtest] frame 90 team 5 ally 1 side cortex ai true dead false start (12618, 5800) units 1
  0.05  [Playtest] frame 90 team 6 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 7 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.10  [SEA][Layout] berth sea.berth.0 armsy at=1424,4000 facing=1
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(700,4597) factory=armsy landLocked=no spot=5 known=1/2
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(1899,5801) factory=corsy landLocked=no spot=6 known=2/2
  0.12  [SEA][Layout] berth sea.berth.1 armasy at=1424,3600 facing=1
  0.15  [Team][Roster] team 1 first mex at 704,4448
  0.15  [Playtest] finished armmex team 0 at 0.15 min
  0.17  [SEA][Layout] berth sea.berth.2 armasy at=1424,3296 facing=3
  0.17  [Team][Roster] first mex 10286 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.17  [Team][Roster] team 2 first mex at 1904,5967
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.81  [Playtest] finished armsy team 0 at 0.81 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 715/1200, energy +30.0 bank 94/1100, units 5
  1.24  [Playtest] finished armtide team 0 at 1.24 min
  1.60  [Playtest] finished armtide team 0 at 1.60 min
  1.85  [Playtest] finished armtide team 0 at 1.85 min
  1.99  [Playtest] finished armtide team 0 at 1.99 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.0 bank 462/1200, energy +106.0 bank 127/1350, units 10
  2.26  [Playtest] finished armtide team 0 at 2.26 min
  2.56  [Playtest] finished armtide team 0 at 2.56 min
  2.73  [Playtest] finished armmex team 0 at 2.73 min
  2.93  [Playtest] finished armmex team 0 at 2.93 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 208/1300, energy +182.0 bank 1475/1500, units 17
  3.28  [Playtest] finished armtide team 0 at 3.28 min
  3.70  [Playtest] finished armtl team 0 at 3.70 min
  3.74  [Playtest] finished armmex team 0 at 3.74 min
  4.00  [Playtest] finished armmex team 0 at 4.00 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +12.0 bank 0/1400, energy +205.0 bank 1524/1550, units 23
  4.16  [Playtest] finished armtide team 0 at 4.16 min
  4.23  [Playtest] finished armmex team 0 at 4.23 min
  4.43  [Playtest] finished armmex team 0 at 4.43 min
  4.84  [Playtest] finished armtide team 0 at 4.84 min
  4.92  [Playtest] finished armmex team 0 at 4.93 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +20.0 bank 26/1550, energy +251.0 bank 1630/1650, units 29
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.01  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.14  [Playtest] finished armmex team 0 at 5.14 min
  5.15  [Playtest] finished armtide team 0 at 5.15 min
  5.18  [Playtest] finished armtide team 0 at 5.18 min
  5.34  [Playtest] finished armmex team 0 at 5.34 min
  5.49  [Playtest] finished armtide team 0 at 5.49 min
  5.52  [Playtest] finished armmex team 0 at 5.52 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +26.0 bank 740/1700, energy +320.0 bank 1785/1800, units 35
  6.05  [Playtest] finished armfmkr team 0 at 6.05 min
  6.59  [Playtest] finished armtide team 0 at 6.59 min
  6.82  [Playtest] finished armnanotcplat team 0 at 6.82 min
  6.98  [Playtest] finished armnanotcplat team 0 at 6.98 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +26.0 bank 1283/1700, energy +350.0 bank 1501/1900, units 41
  7.08  [Playtest] finished armtide team 0 at 7.08 min
  7.13  [Playtest] finished armtide team 0 at 7.13 min
  7.42  [Playtest] finished armtide team 0 at 7.42 min
  7.49  [Playtest] finished armtide team 0 at 7.49 min
  7.58  [Playtest] finished armfmkr team 0 at 7.58 min
  7.59  [Playtest] finished armtide team 0 at 7.59 min
  7.95  [Playtest] finished armtide team 0 at 7.95 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +28.0 bank 321/1700, energy +488.0 bank 2167/2200, units 51
  8.04  [Playtest] finished armtide team 0 at 8.04 min
  8.19  [Playtest] finished armtide team 0 at 8.19 min
  8.37  [Playtest] finished armtide team 0 at 8.37 min
  8.50  [Playtest] finished armtide team 0 at 8.50 min
  8.68  [Playtest] finished armtide team 0 at 8.68 min
  8.95  [Playtest] finished armfmkr team 0 at 8.95 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +29.0 bank 104/1700, energy +603.0 bank 2409/2450, units 60
  9.27  [Playtest] finished armtide team 0 at 9.27 min
  9.28  [Playtest] finished armtide team 0 at 9.28 min
  9.31  [Playtest] finished armfmkr team 0 at 9.31 min
  9.62  [Playtest] finished armtide team 0 at 9.62 min
  9.67  [Playtest] finished armfmkr team 0 at 9.67 min
  9.75  [Playtest] finished armtide team 0 at 9.75 min
  9.99  [Playtest] finished armtide team 0 at 9.99 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +31.0 bank 17/1700, energy +695.0 bank 2525/2700, units 67
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.01  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.04  [Playtest] finished armfmkr team 0 at 10.04 min
 10.11  [Playtest] finished armtide team 0 at 10.11 min
 10.58  [Playtest] finished armfmkr team 0 at 10.58 min
 10.60  [Playtest] finished armtide team 0 at 10.60 min
 10.60  [Playtest] finished armtide team 0 at 10.60 min
 10.83  [Playtest] finished armtide team 0 at 10.83 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +31.8 bank 77/1700, energy +810.0 bank 2372/2900, units 79
 11.24  [Playtest] finished armtide team 0 at 11.24 min
 11.26  [Playtest] finished armtide team 0 at 11.26 min
 11.90  [Playtest] finished armfmkr team 0 at 11.90 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +34.0 bank 793/1700, energy +856.0 bank 2473/3000, units 79
 12.03  [Playtest] finished armfmkr team 0 at 12.02 min
 12.50  [Playtest] finished armfmkr team 0 at 12.50 min
 12.63  [Playtest] finished armmex team 0 at 12.63 min
 12.66  [Playtest] finished armtide team 0 at 12.66 min
 12.91  [Playtest] finished armfmkr team 0 at 12.91 min
 12.93  [Playtest] finished armmex team 0 at 12.93 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +38.0 bank 1403/1800, energy +893.0 bank 2626/3150, units 88
 13.03  [Playtest] finished armtide team 0 at 13.03 min
 13.32  [Playtest] finished armtide team 0 at 13.32 min
 13.46  [Playtest] finished armtl team 0 at 13.46 min
 13.64  [Playtest] finished armtide team 0 at 13.64 min
 13.94  [Playtest] finished armmex team 0 at 13.94 min
 13.95  [Playtest] finished armtide team 0 at 13.95 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +42.0 bank 1703/1850, energy +992.0 bank 2915/3400, units 92
 14.22  [Playtest] finished armtide team 0 at 14.22 min
 14.26  [Playtest] finished armmex team 0 at 14.26 min
 14.29  [Playtest] finished armtide team 0 at 14.29 min
 14.53  [Playtest] finished armmex team 0 at 14.53 min
 14.66  [Playtest] finished armtide team 0 at 14.66 min
 14.92  [Playtest] finished armtide team 0 at 14.92 min
 14.98  [Playtest] finished armtide team 0 at 14.98 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +47.9 bank 1912/1950, energy +1095.5 bank 3081/3650, units 99
 15.25  [Playtest] finished armtide team 0 at 15.25 min
 15.30  [Playtest] finished armtide team 0 at 15.30 min
 15.56  [Playtest] finished armtide team 0 at 15.56 min
 15.80  [Playtest] finished armnanotcplat team 0 at 15.80 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +43.0 bank 1850/1850, energy +1176.0 bank 3767/3800, units 98
 16.38  [Playtest] finished armtide team 0 at 16.38 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +43.0 bank 838/1850, energy +1192.0 bank 3528/3800, units 101
 17.91  [Playtest] finished armtide team 0 at 17.91 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +43.0 bank 0/1850, energy +1208.0 bank 3730/3800, units 99
 18.40  [Playtest] finished armasy team 0 at 18.40 min
 18.73  [Playtest] finished armfmkr team 0 at 18.73 min
 18.92  [Playtest] finished armtide team 0 at 18.92 min
 18.96  [Playtest] finished armtide team 0 at 18.96 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +42.8 bank 19/2050, energy +1254.0 bank 3483/4100, units 99
 19.43  [Playtest] finished armfmkr team 0 at 19.43 min
 19.49  [Playtest] finished armtide team 0 at 19.49 min
 19.49  [Playtest] finished armfmkr team 0 at 19.49 min
 19.80  [Playtest] finished armfmkr team 0 at 19.81 min
 19.84  [Playtest] finished armuwmme team 0 at 19.84 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +46.6 bank 1/2600, energy +1337.0 bank 3663/4450, units 107
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.02  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
 20.18  [Playtest] finished armtide team 0 at 20.18 min
 20.77  [Playtest] finished armuwmme team 0 at 20.77 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +52.3 bank 0/3100, energy +1353.0 bank 3729/4450, units 106
 21.02  [Playtest] finished armtide team 0 at 21.02 min
 21.51  [Playtest] finished armuwmme team 0 at 21.51 min
 21.62  [Playtest] finished armatl team 0 at 21.62 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +58.9 bank 2/3650, energy +1369.0 bank 3721/4450, units 103
 23.00  [Playtest] eco team 0 at 23.0 min: metal +54.5 bank 1/3500, energy +1362.0 bank 3738/4400, units 97
 24.00  [Playtest] eco team 0 at 24.0 min: metal +55.2 bank 0/3500, energy +1369.0 bank 3798/4450, units 97
 24.47  [Playtest] finished armuwfus team 0 at 24.47 min
 24.54  [Playtest] finished armbats team 0 at 24.54 min
 24.57  [Playtest] finished armmex team 0 at 24.57 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +57.0 bank 26/3500, energy +2569.0 bank 6907/6950, units 100
 25.66  [Playtest] finished armllt team 0 at 25.66 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +57.0 bank 207/3500, energy +2869.0 bank 8389/8450, units 104
 26.60  [Playtest] finished armmex team 0 at 26.60 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +53.0 bank 280/3550, energy +2477.0 bank 6524/6700, units 92
 27.03  [Playtest] finished armfmkr team 0 at 27.03 min
 27.35  [Playtest] finished armuwmmm team 0 at 27.35 min
 27.48  [Playtest] finished armuwmmm team 0 at 27.48 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +48.2 bank 1885/2000, energy +1964.0 bank 4606/5300, units 60
 28.49  [Playtest] finished armmex team 0 at 28.49 min
 28.84  [Playtest] finished armfmkr team 0 at 28.84 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +41.6 bank 1000/1450, energy +1964.0 bank 4610/5300, units 50
 29.00  [Playtest] camera requested (1700,4550) height=4000
 29.02  [Playtest] camera captured name=ta position=(1700,4550) height=4000
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (1700, 4550)
 29.12  [Playtest] finished armasy team 0 at 29.12 min
 29.21  [Playtest] finished armuwmmm team 0 at 29.21 min
 29.33  [Playtest] finished armmex team 0 at 29.33 min
 29.38  [SEA][Layout] berth sea.berth.3 armsy at=1680,4624 facing=1
 29.67  [Playtest] finished armatl team 0 at 29.67 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +41.2 bank 2/1650, energy +1994.0 bank 4674/5650, units 55
 30.16  [Playtest] finished armatl team 0 at 30.16 min
```

## Native lines (all AIs, first 120)

```
  0.09  EXP: approach: corcom(22766) at (1899, 5801) walks to (1900, 5829), 139 from the cormex site (1904, 5968)
  0.10  RESERVE: zone 1 at (1424, 4000) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (1424, 4000) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (1712, 4000) facing 1, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (1208, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1208, 4072) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (1208, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1208, 4008) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (1208, 3944) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1208, 3944) facing 1 (id 4)
  0.10  RESERVE: zone 6 at (1272, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1272, 4072) facing 1 (id 5)
  0.10  RESERVE: zone 7 at (1272, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1272, 4008) facing 1 (id 6)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 released
  0.10  RESERVE: zone 6 released
  0.10  RESERVE: zone 7 released
  0.10  RESERVE: zone 8 at (1304, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1304, 4072) facing 1 (id 7)
  0.10  RESERVE: zone 9 at (1304, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1304, 4008) facing 1 (id 8)
  0.10  RESERVE: zone 8 released
  0.10  RESERVE: zone 9 released
  0.10  RESERVE: zone 10 at (1288, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1288, 4104) facing 1 (id 9)
  0.10  RESERVE: zone 11 at (1288, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1288, 4040) facing 1 (id 10)
  0.10  RESERVE: zone 12 at (1288, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1288, 3976) facing 1 (id 11)
  0.10  RESERVE: zone 13 at (1352, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 4104) facing 1 (id 12)
  0.10  RESERVE: zone 14 at (1352, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 4040) facing 1 (id 13)
  0.10  RESERVE: zone 15 at (1352, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 3976) facing 1 (id 14)
  0.10  RESERVE: zone 16 at (1321, 4037) facing 1, 9x13 cells: 54 of 117 held
  0.10  RESERVE: zone 1 at (704, 4592) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (704, 4592) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (992, 4592) facing 1, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (488, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4664) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (488, 4600) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4600) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (488, 4536) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4536) facing 1 (id 4)
  0.10  RESERVE: zone 6 at (552, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4664) facing 1 (id 5)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 released
  0.10  RESERVE: zone 6 released
  0.10  RESERVE: zone 7 at (584, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (584, 4664) facing 1 (id 6)
  0.10  RESERVE: zone 7 released
  0.10  RESERVE: zone 8 at (568, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (568, 4696) facing 1 (id 7)
  0.10  RESERVE: zone 8 released
  0.10  RESERVE: zone 9 at (552, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4728) facing 1 (id 8)
  0.10  RESERVE: zone 10 at (552, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4664) facing 1 (id 9)
  0.10  RESERVE: zone 9 released
  0.10  RESERVE: zone 10 released
  0.10  RESERVE: zone 11 at (520, 4744) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (520, 4744) facing 1 (id 10)
  0.10  RESERVE: zone 12 at (520, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (520, 4680) facing 1 (id 11)
  0.10  RESERVE: zone 11 released
  0.10  RESERVE: zone 12 released
  0.10  RESERVE: zone 13 at (488, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4760) facing 1 (id 12)
  0.10  RESERVE: zone 14 at (488, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4696) facing 1 (id 13)
  0.10  RESERVE: zone 15 at (488, 4632) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4632) facing 1 (id 14)
  0.10  RESERVE: zone 16 at (552, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4760) facing 1 (id 15)
  0.10  RESERVE: zone 17 at (552, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4696) facing 1 (id 16)
  0.10  RESERVE: zone 13 released
  0.10  RESERVE: zone 14 released
  0.10  RESERVE: zone 15 released
  0.10  RESERVE: zone 16 released
  0.10  RESERVE: zone 17 released
  0.10  RESERVE: zone 18 at (440, 4744) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (440, 4744) facing 1 (id 17)
  0.10  RESERVE: zone 19 at (440, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (440, 4680) facing 1 (id 18)
  0.10  RESERVE: zone 20 at (440, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (440, 4616) facing 1 (id 19)
  0.10  RESERVE: zone 21 at (504, 4744) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (504, 4744) facing 1 (id 20)
  0.10  RESERVE: zone 22 at (504, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (504, 4680) facing 1 (id 21)
  0.10  RESERVE: zone 18 released
  0.10  RESERVE: zone 19 released
  0.10  RESERVE: zone 20 released
  0.10  RESERVE: zone 21 released
  0.10  RESERVE: zone 22 released
  0.10  RESERVE: zone 23 at (408, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (408, 4728) facing 1 (id 22)
  0.10  RESERVE: zone 24 at (408, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (408, 4664) facing 1 (id 23)
  0.10  RESERVE: zone 25 at (408, 4600) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (408, 4600) facing 1 (id 24)
  0.10  RESERVE: zone 26 at (472, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (472, 4728) facing 1 (id 25)
  0.10  RESERVE: zone 27 at (472, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (472, 4664) facing 1 (id 26)
  0.10  RESERVE: zone 28 at (472, 4600) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (472, 4600) facing 1 (id 27)
  0.10  RESERVE: zone 29 at (444, 4660) facing 1, 9x13 cells: 63 of 117 held
  0.10  RESERVE: zone 1 at (12928, 4000) facing 3, 6x6 cells: 36 of 36 held
  0.10  RESERVE: legsy at (12928, 4000) facing 3 (id 1)
  0.10  RESERVE: corridor 2 at (12640, 4000) facing 3, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (13160, 3944) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (13160, 3944) facing 3 (id 2)
  0.10  RESERVE: zone 4 at (13160, 4008) facing 3, 3x3 cells: 9 of 9 held
```
