# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.1 min (frame 54192); wall 309 s
- DLL: build-theatres\d188-build-4\SkirmishAI.dll (4269e12be49092f4); AI BARbTest/test; staged 2026-10-04T01:11:34
- Map: Tundra Continents v2.3.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\tundra\20261004T041133Z-9f079cb5\runs\20261004T041647Z-bce2a680\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:42.254421][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.8 min | `[t=00:01:02.595840][f=0001416] [SeaWatch] finished frame=1416 id=1131 def=armsy builder=1613` |
| expect `first-ship-exit` | seen at 2.4 min | `[t=00:01:09.054154][f=0004320] [SeaWatch] egress id=26426 yard=1131 seconds=6.2 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\tundra\20261004T041133Z-9f079cb5\runs\20261004T041647Z-bce2a680\screen_2026-10-04_04-12-59-646.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\tundra\20261004T041133Z-9f079cb5\runs\20261004T041647Z-bce2a680\screen_2026-10-04_04-13-32-237.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\tundra\20261004T041133Z-9f079cb5\runs\20261004T041647Z-bce2a680\screen_2026-10-04_04-15-03-176.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\tundra\20261004T041133Z-9f079cb5\runs\20261004T041647Z-bce2a680\screen_2026-10-04_04-16-36-067.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4100, 2100) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (5400, 800) units 1
  0.00  [Playtest] frame 1 team 2 ally 0 side cortex ai true dead false start (6400, 800) units 1
  0.00  [Playtest] frame 1 team 3 ally 0 side legion ai true dead false start (7800, 1500) units 1
  0.00  [Playtest] frame 1 team 4 ally 1 side armada ai true dead false start (1504, 12000) units 1
  0.00  [Playtest] frame 1 team 5 ally 1 side cortex ai true dead false start (1610, 10300) units 1
  0.00  [Playtest] frame 1 team 6 ally 1 side legion ai true dead false start (6700, 10600) units 1
  0.00  [Playtest] frame 1 team 7 ally 1 side armada ai true dead false start (8200, 10900) units 1
  0.00  [Playtest] frame 1 team 8 ally 1 side cortex ai true dead false start (9000, 11400) units 1
  0.00  [Playtest] frame 1 team 9 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 10 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4100, 2100) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (5400, 800) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (6400, 800) units 1
  0.05  [Playtest] frame 90 team 3 ally 0 side legion ai true dead false start (7800, 1500) units 1
  0.05  [Playtest] frame 90 team 4 ally 1 side armada ai true dead false start (1504, 12000) units 1
  0.05  [Playtest] frame 90 team 5 ally 1 side cortex ai true dead false start (1610, 10300) units 1
  0.05  [Playtest] frame 90 team 6 ally 1 side legion ai true dead false start (6700, 10600) units 1
  0.05  [Playtest] frame 90 team 7 ally 1 side armada ai true dead false start (8200, 10900) units 1
  0.05  [Playtest] frame 90 team 8 ally 1 side cortex ai true dead false start (9000, 11400) units 1
  0.05  [Playtest] frame 90 team 9 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 10 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|4098|2103|0|3|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(5346,796) factory=armsy landLocked=no spot=4 known=1/3
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(6399,801) factory=corsy landLocked=no spot=5 known=2/3
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(7823,1501) factory=legsy landLocked=no spot=6 known=3/3
  0.17  [SEA][Layout] berth sea.berth.0 armsy at=4000,2096 facing=0
  0.17  [Team][Roster] team 2 first mex at 6384,720
  0.18  [SEA][Layout] berth sea.berth.1 armasy at=4496,2096 facing=0
  0.20  [SEA][Layout] berth sea.berth.2 armasy at=4896,2096 facing=0
  0.22  [Team][Roster] team 3 first mex at 7984,1504
  0.24  [Playtest] finished armmex team 0 at 0.24 min
  0.25  [Team][Roster] first mex 15367 at 4016,2016
  0.25  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4098|2103|0|3|1|4016|2016
  0.28  [Team][Roster] team 1 first mex at 5136,752
  0.44  [Playtest] finished armmex team 0 at 0.44 min
  0.79  [Playtest] finished armsy team 0 at 0.79 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 719/1200, energy +30.0 bank 87/1100, units 5
  1.18  [Playtest] finished armmex team 0 at 1.18 min
  1.64  [Playtest] finished armtide team 0 at 1.64 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +7.0 bank 1122/1250, energy +45.0 bank 3/1150, units 8
  2.21  [Playtest] finished armtl team 0 at 2.21 min
  2.41  [Playtest] finished armtide team 0 at 2.41 min
  2.56  [Playtest] finished armtide team 0 at 2.56 min
  2.75  [Playtest] finished armtide team 0 at 2.75 min
  2.79  [Playtest] finished armmex team 0 at 2.79 min
  2.89  [Playtest] finished armtide team 0 at 2.89 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 1291/1300, energy +112.0 bank 243/1450, units 15
  3.09  [Playtest] finished armmex team 0 at 3.09 min
  3.51  [Playtest] finished armmex team 0 at 3.51 min
  3.71  [Playtest] finished armmex team 0 at 3.71 min
  3.97  [Playtest] finished armtl team 0 at 3.97 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +16.0 bank 1447/1450, energy +126.0 bank 182/1500, units 22
  4.01  [Playtest] finished armtide team 0 at 4.01 min
  4.12  [Playtest] finished armmex team 0 at 4.13 min
  4.17  [Playtest] finished armmex team 0 at 4.17 min
  4.33  [Playtest] finished armllt team 0 at 4.33 min
  4.38  [Playtest] finished armtide team 0 at 4.39 min
  4.39  [Playtest] finished armtide team 0 at 4.39 min
  4.69  [Playtest] finished armtide team 0 at 4.69 min
  4.69  [Playtest] finished armtide team 0 at 4.69 min
  5.00  [Playtest] finished armfrad team 0 at 5.00 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +20.0 bank 1516/1550, energy +201.0 bank 1150/1750, units 31
  5.00  [Playtest] target team 0 at (4100, 2100) from its start position
  5.00  [Playtest] camera requested (4100,2100) height=2200
  5.00  [Playtest] finished armtide team 0 at 5.00 min
  5.02  [Playtest] camera captured name=ta position=(4100,2100) height=2200
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (4100, 2100)
  5.26  [Playtest] finished armmex team 0 at 5.26 min
  5.31  [Playtest] finished armtide team 0 at 5.31 min
  5.36  [Playtest] finished armtide team 0 at 5.36 min
  5.58  [Playtest] finished armmex team 0 at 5.59 min
  5.81  [Playtest] finished armtide team 0 at 5.81 min
  5.84  [Playtest] finished armtide team 0 at 5.84 min
  5.85  [Playtest] finished armtl team 0 at 5.85 min
  5.90  [Playtest] finished armmex team 0 at 5.90 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +26.0 bank 1696/1700, energy +283.0 bank 2036/2050, units 45
  6.06  [Playtest] finished armtide team 0 at 6.06 min
  6.16  [Playtest] finished armtide team 0 at 6.16 min
  6.28  [Playtest] finished armtide team 0 at 6.28 min
  6.39  [Playtest] finished armmex team 0 at 6.39 min
  6.46  [Playtest] finished armtide team 0 at 6.46 min
  6.65  [Playtest] finished armtide team 0 at 6.65 min
  6.79  [Playtest] finished armmex team 0 at 6.79 min
  6.81  [Playtest] finished armtide team 0 at 6.81 min
  6.83  [Playtest] finished armtide team 0 at 6.83 min
  6.99  [Playtest] finished armtide team 0 at 6.99 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +30.0 bank 1791/1800, energy +395.0 bank 2491/2500, units 56
  7.03  [Playtest] finished armtide team 0 at 7.03 min
  7.19  [Playtest] finished armtide team 0 at 7.19 min
  7.29  [Playtest] finished armtide team 0 at 7.29 min
  7.36  [Playtest] finished armtide team 0 at 7.36 min
  7.36  [Playtest] finished armmex team 0 at 7.36 min
  7.41  [Playtest] finished armmex team 0 at 7.41 min
  7.58  [Playtest] finished armtide team 0 at 7.58 min
  7.82  [Playtest] finished armtide team 0 at 7.82 min
  7.85  [Playtest] finished armtide team 0 at 7.85 min
  7.88  [Playtest] finished armtide team 0 at 7.88 min
  7.97  [Playtest] finished armtide team 0 at 7.97 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +33.9 bank 1897/1900, energy +544.5 bank 2991/3000, units 68
  8.09  [Playtest] finished armtide team 0 at 8.09 min
  8.25  [Playtest] finished armtide team 0 at 8.25 min
  8.38  [Playtest] finished armtide team 0 at 8.38 min
  8.59  [Playtest] finished armtide team 0 at 8.59 min
  8.72  [Playtest] finished armtide team 0 at 8.72 min
  8.79  [Playtest] finished armtide team 0 at 8.79 min
  8.86  [Playtest] finished armtl team 0 at 8.86 min
  8.96  [Playtest] finished armtide team 0 at 8.96 min
  8.96  [Playtest] finished armnanotcplat team 0 at 8.96 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +33.9 bank 1883/1900, energy +657.0 bank 3344/3350, units 78
  9.07  [Playtest] finished armtide team 0 at 9.07 min
  9.16  [Playtest] finished armtide team 0 at 9.16 min
  9.17  [Playtest] finished armmex team 0 at 9.17 min
  9.36  [Playtest] finished armtl team 0 at 9.36 min
  9.40  [Playtest] finished armtide team 0 at 9.40 min
  9.58  [Playtest] finished armtide team 0 at 9.58 min
  9.65  [Playtest] finished armtide team 0 at 9.65 min
  9.80  [Playtest] finished armtide team 0 at 9.80 min
  9.88  [Playtest] finished armtide team 0 at 9.88 min
  9.88  [Playtest] finished armtl team 0 at 9.88 min
  9.97  [Playtest] finished armtide team 0 at 9.97 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +35.9 bank 1934/1950, energy +777.0 bank 3738/3750, units 86
 10.00  [Playtest] camera requested (4100,2100) height=2200
 10.02  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (4100, 2100)
 10.10  [Playtest] finished armnanotcplat team 0 at 10.10 min
 10.21  [Playtest] finished armtl team 0 at 10.21 min
 10.28  [Playtest] finished armtide team 0 at 10.28 min
 10.53  [Playtest] finished armnanotcplat team 0 at 10.53 min
 10.56  [Playtest] finished armtide team 0 at 10.56 min
 10.96  [Playtest] finished armtide team 0 at 10.96 min
 10.98  [Playtest] finished armtl team 0 at 10.98 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +30.0 bank 1731/1800, energy +822.0 bank 3886/3900, units 90
 11.06  [Playtest] finished armtl team 0 at 11.06 min
 11.16  [Playtest] finished armmex team 0 at 11.16 min
 11.17  [Playtest] finished armtide team 0 at 11.17 min
 11.28  [Playtest] finished armtide team 0 at 11.28 min
 11.39  [Playtest] finished armtide team 0 at 11.39 min
 11.62  [Playtest] finished armtide team 0 at 11.63 min
 11.66  [Playtest] finished armtide team 0 at 11.66 min
 11.72  [Playtest] finished armtide team 0 at 11.72 min
 11.84  [Playtest] finished armtide team 0 at 11.84 min
 11.85  [Playtest] finished armmex team 0 at 11.85 min
 11.94  [Playtest] finished armtide team 0 at 11.94 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +33.9 bank 974/1900, energy +942.0 bank 4299/4300, units 103
 12.14  [Playtest] finished armtide team 0 at 12.14 min
 12.34  [Playtest] finished armmex team 0 at 12.34 min
 12.50  [Playtest] finished armtide team 0 at 12.50 min
 12.55  [Playtest] finished armtide team 0 at 12.55 min
 12.70  [Playtest] finished armfrad team 0 at 12.70 min
 12.82  [Playtest] finished armtide team 0 at 12.82 min
 12.87  [Playtest] finished armtide team 0 at 12.87 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +35.9 bank 184/1950, energy +1010.0 bank 4478/4500, units 113
 13.14  [Playtest] finished armtide team 0 at 13.14 min
 13.16  [Playtest] finished armmex team 0 at 13.16 min
 13.19  [Playtest] finished armtide team 0 at 13.19 min
 13.61  [Playtest] finished armmex team 0 at 13.60 min
 13.64  [Playtest] finished armtide team 0 at 13.64 min
 13.75  [Playtest] finished armtl team 0 at 13.75 min
 13.75  [Playtest] finished armtide team 0 at 13.75 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +39.9 bank 353/2050, energy +1070.0 bank 4669/4700, units 121
 14.20  [Playtest] finished armtide team 0 at 14.20 min
 14.21  [Playtest] finished armtl team 0 at 14.21 min
 14.33  [Playtest] finished armfrad team 0 at 14.33 min
 14.52  [Playtest] finished armtide team 0 at 14.52 min
 14.92  [Playtest] finished armtide team 0 at 14.92 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +39.9 bank 90/2050, energy +1115.0 bank 4813/4850, units 122
 15.23  [Playtest] finished armtide team 0 at 15.23 min
 15.28  [Playtest] finished armtide team 0 at 15.28 min
 15.56  [Playtest] finished armfrad team 0 at 15.56 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +37.9 bank 13/2000, energy +1152.0 bank 4994/5000, units 122
 16.14  [Playtest] finished armtide team 0 at 16.14 min
 16.14  [Playtest] finished armtide team 0 at 16.14 min
 16.99  [Playtest] finished armasy team 0 at 16.99 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +37.9 bank 14/2200, energy +1154.0 bank 5093/5100, units 115
 17.59  [Playtest] finished armfmkr team 0 at 17.59 min
 17.65  [Playtest] finished armtide team 0 at 17.65 min
 17.77  [Playtest] finished armtl team 0 at 17.77 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +34.9 bank 242/2100, energy +1206.0 bank 5260/5350, units 113
 18.42  [Playtest] finished armuwmme team 0 at 18.42 min
 18.77  [Playtest] finished armtl team 0 at 18.77 min
 18.97  [SEA][Layout] berth sea.berth.3 armsy at=4176,2288 facing=0
 19.00  [Playtest] eco team 0 at 19.0 min: metal +33.9 bank 1963/2200, energy +554.5 bank 2540/2550, units 50
 19.43  [SEA][Layout] berth sea.berth.4 legsy at=3904,2096 facing=0
 20.00  [Playtest] eco team 0 at 20.0 min: metal +16.0 bank 900/900, energy +5.0 bank 525/550, units 14
 20.00  [Playtest] camera requested (4100,2100) height=2200
 20.02  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (4100, 2100)
 21.00  [Playtest] eco team 0 at 21.0 min: metal +16.0 bank 900/900, energy +7.0 bank 527/550, units 14
 22.00  [Playtest] eco team 0 at 22.0 min: metal +14.0 bank 850/850, energy +0.0 bank 474/500, units 12
 22.47  [SEA][Layout] berth sea.berth.5 armsy at=3808,2096 facing=0
 23.00  [Playtest] eco team 0 at 23.0 min: metal +10.0 bank 750/750, energy +0.0 bank 476/500, units 8
 24.00  [Playtest] eco team 0 at 24.0 min: metal +0.0 bank 500/500, energy +0.0 bank 388/500, units 0
 25.00  [Playtest] eco team 0 at 25.0 min: metal +0.0 bank 500/500, energy +0.0 bank 388/500, units 0
 26.00  [Playtest] eco team 0 at 26.0 min: metal +0.0 bank 500/500, energy +0.0 bank 388/500, units 0
 27.00  [Playtest] eco team 0 at 27.0 min: metal +0.0 bank 500/500, energy +0.0 bank 388/500, units 0
 28.00  [Playtest] eco team 0 at 28.0 min: metal +0.0 bank 500/500, energy +0.0 bank 388/500, units 0
 29.00  [Playtest] eco team 0 at 29.0 min: metal +0.0 bank 500/500, energy +0.0 bank 388/500, units 0
 29.00  [Playtest] camera requested (4100,2100) height=2200
 29.01  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 29.01  [Playtest] screenshot at 29.0 min of team 0 at (4100, 2100)
 30.00  [Playtest] eco team 0 at 30.0 min: metal +0.0 bank 500/500, energy +0.0 bank 388/500, units 0
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(2752) at (5346, 797) walks to (5269, 780), 136 from the armmex site (5136, 752)
  0.09  EXP: approach: legcom(10333) at (7824, 1502) walks to (7847, 1502), 137 from the legmex site (7984, 1504)
  0.09  EXP: approach: corcom(29830) at (9040, 11417) walks to (9370, 11502), 139 from the cormex site (9504, 11536)
  0.10  RESERVE: zone 1 at (7824, 1504) facing 0, 6x6 cells: 36 of 36 held
  0.10  RESERVE: legsy at (7824, 1504) facing 0 (id 1)
  0.10  RESERVE: corridor 2 at (7824, 1792) facing 0, 12x30 cells: 348 of 360 held
  0.10  RESERVE: zone 3 at (7768, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7768, 1288) facing 0 (id 2)
  0.10  RESERVE: zone 4 at (7832, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7832, 1288) facing 0 (id 3)
  0.10  RESERVE: zone 5 at (7896, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7896, 1288) facing 0 (id 4)
  0.10  RESERVE: zone 6 at (7768, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7768, 1352) facing 0 (id 5)
  0.10  RESERVE: zone 7 at (7832, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7832, 1352) facing 0 (id 6)
  0.10  RESERVE: zone 8 at (7896, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7896, 1352) facing 0 (id 7)
  0.10  RESERVE: zone 9 at (7824, 1312) facing 0, 12x8 cells: 42 of 96 held
  0.10  RESERVE: zone 1 at (9040, 11424) facing 2, 6x6 cells: 36 of 36 held
  0.10  RESERVE: corsy at (9040, 11424) facing 2 (id 1)
  0.10  RESERVE: corridor 2 at (9040, 11136) facing 2, 12x30 cells: 360 of 360 held
  0.10  RESERVE: zone 3 at (9112, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9112, 11656) facing 2 (id 2)
  0.10  RESERVE: zone 4 at (9048, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9048, 11656) facing 2 (id 3)
  0.10  RESERVE: zone 5 at (8984, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (8984, 11656) facing 2 (id 4)
  0.10  RESERVE: zone 6 at (9112, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9112, 11592) facing 2 (id 5)
  0.10  RESERVE: zone 7 at (9048, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9048, 11592) facing 2 (id 6)
  0.10  RESERVE: zone 8 at (8984, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (8984, 11592) facing 2 (id 7)
  0.10  RESERVE: zone 9 at (9040, 11616) facing 2, 12x8 cells: 42 of 96 held
  0.11  EXP: idle: legcom(10333) on legmex at (7839, 1502), site (7984, 1504), target yes, fails 2 (arrived at the approach point)
  0.12  RESERVE: zone 10 at (8224, 1504) facing 0, 12x12 cells: 144 of 144 held
  0.12  RESERVE: legadvshipyard at (8224, 1504) facing 0 (id 8)
  0.12  RESERVE: corridor 11 at (8224, 1840) facing 0, 18x30 cells: 540 of 540 held
  0.12  RESERVE: zone 12 at (8264, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8264, 1288) facing 0 (id 9)
  0.12  RESERVE: zone 13 at (8328, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8328, 1288) facing 0 (id 10)
  0.12  RESERVE: zone 14 at (8392, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8392, 1288) facing 0 (id 11)
  0.12  RESERVE: zone 15 at (8264, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8264, 1352) facing 0 (id 12)
  0.12  RESERVE: zone 16 at (8328, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8328, 1352) facing 0 (id 13)
  0.12  RESERVE: zone 17 at (8392, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8392, 1352) facing 0 (id 14)
  0.12  RESERVE: zone 18 at (8320, 1312) facing 0, 12x8 cells: 42 of 96 held
  0.12  RESERVE: zone 10 at (8640, 11424) facing 2, 12x12 cells: 144 of 144 held
  0.12  RESERVE: corasy at (8640, 11424) facing 2 (id 8)
  0.12  RESERVE: corridor 11 at (8640, 11088) facing 2, 18x30 cells: 540 of 540 held
  0.12  RESERVE: zone 12 at (8808, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cornanotcplat at (8808, 11656) facing 2 (id 9)
  0.12  RESERVE: zone 13 at (8744, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cornanotcplat at (8744, 11656) facing 2 (id 10)
  0.12  RESERVE: zone 14 at (8680, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cornanotcplat at (8680, 11656) facing 2 (id 11)
  0.12  RESERVE: zone 15 at (8808, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cornanotcplat at (8808, 11592) facing 2 (id 12)
  0.12  RESERVE: zone 16 at (8744, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cornanotcplat at (8744, 11592) facing 2 (id 13)
  0.12  RESERVE: zone 17 at (8680, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cornanotcplat at (8680, 11592) facing 2 (id 14)
  0.12  RESERVE: zone 18 at (8736, 11616) facing 2, 12x8 cells: 42 of 96 held
  0.14  RESERVE: zone 19 at (8240, 11424) facing 2, 12x12 cells: 144 of 144 held
  0.14  RESERVE: corasy at (8240, 11424) facing 2 (id 15)
  0.14  RESERVE: corridor 20 at (8240, 11088) facing 2, 18x30 cells: 516 of 540 held
  0.14  RESERVE: zone 21 at (8392, 11688) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: cornanotcplat at (8392, 11688) facing 2 (id 16)
  0.14  RESERVE: zone 22 at (8328, 11688) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: cornanotcplat at (8328, 11688) facing 2 (id 17)
  0.14  RESERVE: zone 23 at (8264, 11688) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: cornanotcplat at (8264, 11688) facing 2 (id 18)
  0.14  RESERVE: zone 24 at (8392, 11624) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: cornanotcplat at (8392, 11624) facing 2 (id 19)
  0.14  RESERVE: zone 25 at (8328, 11624) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: cornanotcplat at (8328, 11624) facing 2 (id 20)
  0.14  RESERVE: zone 26 at (8264, 11624) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: cornanotcplat at (8264, 11624) facing 2 (id 21)
  0.14  RESERVE: zone 27 at (8329, 11653) facing 2, 13x9 cells: 63 of 117 held
  0.17  RESERVE: zone 1 at (4000, 2096) facing 0, 6x6 cells: 36 of 36 held
  0.17  RESERVE: armsy at (4000, 2096) facing 0 (id 1)
  0.17  RESERVE: corridor 2 at (4000, 2384) facing 0, 12x30 cells: 338 of 360 held
  0.17  RESERVE: zone 3 at (3944, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotcplat at (3944, 1880) facing 0 (id 2)
  0.17  RESERVE: zone 4 at (4008, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotcplat at (4008, 1880) facing 0 (id 3)
  0.17  RESERVE: zone 5 at (4072, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotcplat at (4072, 1880) facing 0 (id 4)
  0.17  RESERVE: zone 6 at (3944, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotcplat at (3944, 1944) facing 0 (id 5)
  0.17  RESERVE: zone 7 at (4008, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotcplat at (4008, 1944) facing 0 (id 6)
  0.17  RESERVE: zone 8 at (4072, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotcplat at (4072, 1944) facing 0 (id 7)
  0.17  RESERVE: zone 9 at (4000, 1904) facing 0, 12x8 cells: 42 of 96 held
  0.17  RESERVE: zone 1 at (6608, 10640) facing 3, 6x6 cells: 36 of 36 held
  0.17  RESERVE: legsy at (6608, 10640) facing 3 (id 1)
  0.17  RESERVE: corridor 2 at (6320, 10640) facing 3, 30x12 cells: 360 of 360 held
  0.17  RESERVE: zone 3 at (7000, 10648) facing 2, 3x3 cells: 9 of 9 held
  0.17  RESERVE: legnanotcplat at (7000, 10648) facing 2 (id 2)
  0.17  RESERVE: zone 4 at (6936, 10648) facing 2, 3x3 cells: 9 of 9 held
  0.17  RESERVE: legnanotcplat at (6936, 10648) facing 2 (id 3)
  0.17  RESERVE: zone 3 released
  0.17  RESERVE: zone 4 released
  0.17  RESERVE: zone 5 at (6984, 10680) facing 2, 3x3 cells: 9 of 9 held
  0.17  RESERVE: legnanotcplat at (6984, 10680) facing 2 (id 4)
  0.17  RESERVE: zone 5 released
  0.17  RESERVE: zone 6 at (6968, 10712) facing 2, 3x3 cells: 9 of 9 held
  0.17  RESERVE: legnanotcplat at (6968, 10712) facing 2 (id 5)
  0.17  RESERVE: zone 6 released
  0.17  RESERVE: zone 7 at (6936, 10728) facing 2, 3x3 cells: 9 of 9 held
  0.17  RESERVE: legnanotcplat at (6936, 10728) facing 2 (id 6)
  0.17  RESERVE: zone 8 at (6872, 10728) facing 2, 3x3 cells: 9 of 9 held
  0.17  RESERVE: legnanotcplat at (6872, 10728) facing 2 (id 7)
  0.17  RESERVE: zone 9 at (6808, 10728) facing 2, 3x3 cells: 9 of 9 held
```
