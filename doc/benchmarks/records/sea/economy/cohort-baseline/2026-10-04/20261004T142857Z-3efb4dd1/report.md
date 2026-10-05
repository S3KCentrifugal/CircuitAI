# Playtest report: PASS

- Verdict: **PASS** (reached 20 min)
- Game time reached: 20.0 min (frame 36011); wall 169 s
- DLL: build-theatres\d190-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T11:26:06
- Map: Tundra Continents v2.3.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\tundra\20261004T142605Z-07a7bd8e\runs\20261004T142857Z-3efb4dd1\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:33.676568][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.6 min | `[t=00:00:48.949869][f=0001104] [SeaWatch] finished frame=1104 id=3076 def=armsy builder=24679` |
| expect `first-ship-exit` | seen at 2.1 min | `[t=00:00:55.112068][f=0003720] [SeaWatch] egress id=7625 yard=3076 seconds=10.3 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\tundra\20261004T142605Z-07a7bd8e\runs\20261004T142857Z-3efb4dd1\screen_2026-10-04_14-27-17-362.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\tundra\20261004T142605Z-07a7bd8e\runs\20261004T142857Z-3efb4dd1\screen_2026-10-04_14-27-41-355.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\tundra\20261004T142605Z-07a7bd8e\runs\20261004T142857Z-3efb4dd1\screen_2026-10-04_14-28-56-999.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 20.5 min
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
  0.10  [SEA][Layout] berth sea.berth.0 armsy at=4096,2096 facing=0
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|4100|2097|0|3|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(5332,793) factory=armsy landLocked=no spot=4 known=1/3
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(6399,801) factory=corsy landLocked=no spot=5 known=2/3
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(7820,1503) factory=legsy landLocked=no spot=6 known=3/3
  0.12  [SEA][Layout] berth sea.berth.1 armasy at=4496,2096 facing=0
  0.13  [SEA][Layout] berth sea.berth.2 armasy at=4896,2096 facing=0
  0.15  [Playtest] finished armmex team 0 at 0.16 min
  0.17  [Team][Roster] first mex 10685 at 4016,2016
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4100|2097|0|3|1|4016|2016
  0.17  [Team][Roster] team 2 first mex at 6384,720
  0.22  [Team][Roster] team 3 first mex at 7984,1504
  0.27  [Team][Roster] team 1 first mex at 5136,752
  0.61  [Playtest] finished armsy team 0 at 0.61 min
  0.92  [Playtest] finished armtide team 0 at 0.92 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.0 bank 554/1150, energy +45.0 bank 143/1150, units 5
  1.27  [Playtest] finished armmex team 0 at 1.27 min
  1.62  [Playtest] finished armmex team 0 at 1.62 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 670/1250, energy +52.0 bank 135/1200, units 9
  2.16  [Playtest] finished armtide team 0 at 2.16 min
  2.30  [Playtest] finished armtide team 0 at 2.30 min
  2.46  [Playtest] finished armtide team 0 at 2.46 min
  2.73  [Playtest] finished armmex team 0 at 2.73 min
  2.99  [Playtest] finished armmex team 0 at 2.99 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 948/1350, energy +104.0 bank 165/1400, units 15
  3.06  [Playtest] finished armtide team 0 at 3.06 min
  3.37  [Playtest] finished armtide team 0 at 3.37 min
  3.48  [Playtest] finished armmex team 0 at 3.48 min
  3.59  [Playtest] finished armmex team 0 at 3.59 min
  3.72  [Playtest] finished armmex team 0 at 3.72 min
  3.82  [Playtest] finished armtide team 0 at 3.82 min
  3.92  [Playtest] finished armmex team 0 at 3.92 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +20.0 bank 1093/1550, energy +149.0 bank 328/1550, units 25
  4.16  [Playtest] finished armtide team 0 at 4.16 min
  4.22  [Playtest] finished armmex team 0 at 4.22 min
  4.46  [Playtest] finished armtide team 0 at 4.46 min
  4.72  [Playtest] finished armmex team 0 at 4.72 min
  4.78  [Playtest] finished armtide team 0 at 4.78 min
  4.86  [Playtest] finished armtide team 0 at 4.86 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +24.0 bank 1137/1650, energy +209.0 bank 1315/1750, units 30
  5.00  [Playtest] target team 0 at (4100, 2100) from its start position
  5.00  [Playtest] camera requested (4100,2100) height=2200
  5.01  [Playtest] camera captured name=ta position=(4100,2100) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (4100, 2100)
  5.05  [Playtest] finished armmex team 0 at 5.05 min
  5.09  [Playtest] finished armtide team 0 at 5.09 min
  5.36  [Playtest] finished armmex team 0 at 5.36 min
  5.73  [Playtest] finished armmex team 0 at 5.73 min
  5.81  [Playtest] finished armtide team 0 at 5.81 min
  5.94  [Playtest] finished armllt team 0 at 5.94 min
  5.96  [Playtest] finished armmex team 0 at 5.96 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +31.9 bank 1551/1850, energy +246.0 bank 1886/1900, units 40
  6.12  [Playtest] finished armtide team 0 at 6.12 min
  6.13  [Playtest] finished armmex team 0 at 6.13 min
  6.25  [Playtest] finished armtide team 0 at 6.25 min
  6.34  [Playtest] finished armrad team 0 at 6.34 min
  6.57  [Playtest] finished armtide team 0 at 6.57 min
  6.84  [Playtest] finished armnanotcplat team 0 at 6.84 min
  6.87  [Playtest] finished armtide team 0 at 6.87 min
  6.92  [Playtest] finished armnanotcplat team 0 at 6.92 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +33.9 bank 1869/1900, energy +306.0 bank 1933/2100, units 45
  7.05  [Playtest] finished armtide team 0 at 7.05 min
  7.13  [Playtest] finished armtl team 0 at 7.13 min
  7.21  [Playtest] finished armtide team 0 at 7.21 min
  7.40  [Playtest] finished armtide team 0 at 7.40 min
  7.46  [Playtest] finished armtide team 0 at 7.46 min
  7.54  [Playtest] finished armtide team 0 at 7.54 min
  7.67  [Playtest] finished armtide team 0 at 7.67 min
  7.72  [Playtest] finished armtide team 0 at 7.72 min
  7.90  [Playtest] finished armtide team 0 at 7.90 min
  7.92  [Playtest] finished armtl team 0 at 7.92 min
  7.92  [Playtest] finished armtl team 0 at 7.92 min
  7.97  [Playtest] finished armtide team 0 at 7.97 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +28.0 bank 1629/1750, energy +440.5 bank 2591/2600, units 57
  8.05  [Playtest] finished armtide team 0 at 8.05 min
  8.16  [Playtest] finished armtide team 0 at 8.16 min
  8.23  [Playtest] finished armtide team 0 at 8.23 min
  8.39  [Playtest] finished armtide team 0 at 8.39 min
  8.50  [Playtest] finished armtide team 0 at 8.50 min
  8.58  [Playtest] finished armtide team 0 at 8.58 min
  8.65  [Playtest] finished armtide team 0 at 8.65 min
  8.73  [Playtest] finished armtide team 0 at 8.73 min
  8.85  [Playtest] finished armtl team 0 at 8.85 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +28.0 bank 1722/1750, energy +582.0 bank 3083/3100, units 69
  9.02  [Playtest] finished armtide team 0 at 9.02 min
  9.16  [Playtest] finished armtl team 0 at 9.16 min
  9.63  [Playtest] finished armmex team 0 at 9.63 min
  9.69  [Playtest] finished armtl team 0 at 9.69 min
  9.74  [Playtest] finished armtide team 0 at 9.74 min
  9.90  [Playtest] finished armtide team 0 at 9.90 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +30.0 bank 1756/1800, energy +627.0 bank 3191/3250, units 78
 10.00  [Playtest] camera requested (4100,2100) height=2200
 10.02  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (4100, 2100)
 10.18  [Playtest] finished armfrad team 0 at 10.18 min
 10.23  [Playtest] finished armmex team 0 at 10.23 min
 10.26  [Playtest] finished armfmkr team 0 at 10.26 min
 10.33  [Playtest] finished armtl team 0 at 10.33 min
 10.76  [Playtest] finished armmex team 0 at 10.76 min
 10.93  [Playtest] finished armfmkr team 0 at 10.93 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +35.9 bank 1560/1900, energy +634.0 bank 3105/3300, units 88
 11.21  [Playtest] finished armfmkr team 0 at 11.21 min
 11.28  [Playtest] finished armtl team 0 at 11.28 min
 11.34  [Playtest] finished armmex team 0 at 11.34 min
 11.49  [Playtest] finished armfmkr team 0 at 11.49 min
 11.50  [Playtest] finished armfrad team 0 at 11.50 min
 11.56  [Playtest] finished armfmkr team 0 at 11.56 min
 11.66  [Playtest] finished armfmkr team 0 at 11.66 min
 11.69  [Playtest] finished armmex team 0 at 11.69 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +39.1 bank 1239/2000, energy +634.0 bank 2536/3300, units 96
 12.08  [Playtest] finished armtl team 0 at 12.08 min
 12.19  [Playtest] finished armfmkr team 0 at 12.19 min
 12.42  [Playtest] finished armfmkr team 0 at 12.42 min
 12.48  [Playtest] finished armmex team 0 at 12.48 min
 12.58  [Playtest] finished armfmkr team 0 at 12.58 min
 12.59  [Playtest] finished armfmkr team 0 at 12.59 min
 12.69  [Playtest] finished armtl team 0 at 12.69 min
 12.77  [Playtest] finished armfmkr team 0 at 12.77 min
 12.92  [Playtest] finished armtide team 0 at 12.92 min
 12.98  [Playtest] finished armfrad team 0 at 12.98 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +42.5 bank 1018/2050, energy +649.0 bank 2518/3350, units 107
 13.06  [Playtest] finished armtl team 0 at 13.06 min
 13.10  [Playtest] finished armfmkr team 0 at 13.10 min
 13.58  [Playtest] finished armtl team 0 at 13.58 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +48.1 bank 1411/2050, energy +649.0 bank 2605/3350, units 114
 14.02  [Playtest] finished armfmkr team 0 at 14.02 min
 14.19  [Playtest] finished armfrad team 0 at 14.19 min
 14.19  [Playtest] finished armfmkr team 0 at 14.19 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +45.7 bank 1501/2050, energy +649.0 bank 2613/3350, units 117
 15.09  [Playtest] finished armmex team 0 at 15.09 min
 15.40  [Playtest] finished armfrad team 0 at 15.40 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +45.0 bank 1853/2100, energy +635.0 bank 2529/3250, units 119
 16.13  [Playtest] finished armmex team 0 at 16.13 min
 16.67  [Playtest] finished armtl team 0 at 16.67 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +47.5 bank 2126/2150, energy +642.0 bank 2586/3300, units 122
 17.40  [Playtest] finished armtide team 0 at 17.40 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +47.7 bank 1991/2150, energy +657.0 bank 2625/3350, units 124
 18.12  [Playtest] finished armtide team 0 at 18.12 min
 18.30  [Playtest] finished armtide team 0 at 18.30 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +51.8 bank 1767/2150, energy +687.0 bank 2899/3450, units 125
 19.35  [Playtest] finished armtl team 0 at 19.35 min
 19.41  [Playtest] finished armtide team 0 at 19.41 min
 19.64  [Playtest] finished armmex team 0 at 19.64 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +51.8 bank 2199/2200, energy +702.0 bank 2917/3500, units 129
 20.00  [Playtest] camera requested (4100,2100) height=2200
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(891) at (5333, 793) walks to (5269, 780), 136 from the armmex site (5136, 752)
  0.09  EXP: approach: legcom(28578) at (7821, 1503) walks to (7847, 1503), 137 from the legmex site (7984, 1504)
  0.09  EXP: approach: corcom(22737) at (9050, 11420) walks to (9370, 11502), 139 from the cormex site (9504, 11536)
  0.10  RESERVE: zone 1 at (4096, 2096) facing 0, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (4096, 2096) facing 0 (id 1)
  0.10  RESERVE: corridor 2 at (4096, 2384) facing 0, 12x30 cells: 356 of 360 held
  0.10  RESERVE: zone 3 at (4040, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4040, 1880) facing 0 (id 2)
  0.10  RESERVE: zone 4 at (4104, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4104, 1880) facing 0 (id 3)
  0.10  RESERVE: zone 5 at (4168, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4168, 1880) facing 0 (id 4)
  0.10  RESERVE: zone 6 at (4040, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4040, 1944) facing 0 (id 5)
  0.10  RESERVE: zone 7 at (4104, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4104, 1944) facing 0 (id 6)
  0.10  RESERVE: zone 8 at (4168, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4168, 1944) facing 0 (id 7)
  0.10  RESERVE: zone 9 at (4096, 1904) facing 0, 12x8 cells: 42 of 96 held
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
  0.10  RESERVE: zone 1 at (6800, 10608) facing 2, 6x6 cells: 36 of 36 held
  0.10  RESERVE: legsy at (6800, 10608) facing 2 (id 1)
  0.10  RESERVE: corridor 2 at (6800, 10320) facing 2, 12x30 cells: 360 of 360 held
  0.10  RESERVE: zone 3 at (6872, 10840) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6872, 10840) facing 2 (id 2)
  0.10  RESERVE: zone 4 at (6808, 10840) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6808, 10840) facing 2 (id 3)
  0.10  RESERVE: zone 5 at (6744, 10840) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6744, 10840) facing 2 (id 4)
  0.10  RESERVE: zone 6 at (6872, 10776) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6872, 10776) facing 2 (id 5)
  0.10  RESERVE: zone 7 at (6808, 10776) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6808, 10776) facing 2 (id 6)
  0.10  RESERVE: zone 8 at (6744, 10776) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6744, 10776) facing 2 (id 7)
  0.10  RESERVE: zone 9 at (6800, 10800) facing 2, 12x8 cells: 42 of 96 held
  0.10  RESERVE: zone 1 at (8208, 10896) facing 2, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (8208, 10896) facing 2 (id 1)
  0.10  RESERVE: corridor 2 at (8208, 10608) facing 2, 12x30 cells: 360 of 360 held
  0.10  RESERVE: zone 3 at (8376, 11128) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8376, 11128) facing 2 (id 2)
  0.10  RESERVE: zone 4 at (8312, 11128) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8312, 11128) facing 2 (id 3)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 at (8360, 11160) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8360, 11160) facing 2 (id 4)
  0.10  RESERVE: zone 5 released
  0.10  RESERVE: zone 6 at (8344, 11192) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8344, 11192) facing 2 (id 5)
  0.10  RESERVE: zone 6 released
  0.10  RESERVE: zone 7 at (8312, 11208) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8312, 11208) facing 2 (id 6)
  0.10  RESERVE: zone 7 released
  0.10  RESERVE: zone 8 at (8280, 11224) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8280, 11224) facing 2 (id 7)
  0.10  RESERVE: zone 9 at (8216, 11224) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8216, 11224) facing 2 (id 8)
  0.10  RESERVE: zone 10 at (8152, 11224) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8152, 11224) facing 2 (id 9)
  0.10  RESERVE: zone 8 released
  0.10  RESERVE: zone 9 released
  0.10  RESERVE: zone 10 released
  0.10  RESERVE: zone 11 at (8200, 11192) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8200, 11192) facing 2 (id 10)
  0.10  RESERVE: zone 12 at (8136, 11192) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8136, 11192) facing 2 (id 11)
  0.10  RESERVE: zone 13 at (8072, 11192) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8072, 11192) facing 2 (id 12)
  0.10  RESERVE: zone 14 at (8200, 11128) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8200, 11128) facing 2 (id 13)
  0.10  RESERVE: zone 15 at (8136, 11128) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8136, 11128) facing 2 (id 14)
  0.10  RESERVE: zone 16 at (8072, 11128) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8072, 11128) facing 2 (id 15)
  0.10  RESERVE: zone 17 at (8140, 11156) facing 2, 13x9 cells: 59 of 117 held
  0.10  RESERVE: zone 1 at (9056, 11424) facing 2, 6x6 cells: 36 of 36 held
  0.10  RESERVE: corsy at (9056, 11424) facing 2 (id 1)
  0.10  RESERVE: corridor 2 at (9056, 11136) facing 2, 12x30 cells: 360 of 360 held
  0.10  RESERVE: zone 3 at (9128, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9128, 11656) facing 2 (id 2)
  0.10  RESERVE: zone 4 at (9064, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9064, 11656) facing 2 (id 3)
  0.10  RESERVE: zone 5 at (9000, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9000, 11656) facing 2 (id 4)
  0.10  RESERVE: zone 6 at (9128, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9128, 11592) facing 2 (id 5)
  0.10  RESERVE: zone 7 at (9064, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9064, 11592) facing 2 (id 6)
  0.10  RESERVE: zone 8 at (9000, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9000, 11592) facing 2 (id 7)
  0.10  RESERVE: zone 9 at (9056, 11616) facing 2, 12x8 cells: 42 of 96 held
  0.11  EXP: idle: legcom(28578) on legmex at (7840, 1503), site (7984, 1504), target yes, fails 1 (arrived at the approach point)
  0.12  RESERVE: zone 10 at (4496, 2096) facing 0, 12x12 cells: 144 of 144 held
  0.12  RESERVE: armasy at (4496, 2096) facing 0 (id 8)
  0.12  RESERVE: corridor 11 at (4496, 2432) facing 0, 18x30 cells: 540 of 540 held
  0.12  RESERVE: zone 12 at (4536, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (4536, 1880) facing 0 (id 9)
  0.12  RESERVE: zone 13 at (4600, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (4600, 1880) facing 0 (id 10)
  0.12  RESERVE: zone 14 at (4664, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (4664, 1880) facing 0 (id 11)
  0.12  RESERVE: zone 15 at (4536, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (4536, 1944) facing 0 (id 12)
  0.12  RESERVE: zone 16 at (4600, 1944) facing 0, 3x3 cells: 9 of 9 held
```
