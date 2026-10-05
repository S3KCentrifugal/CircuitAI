# Playtest report: PASS

- Verdict: **PASS** (reached 20 min)
- Game time reached: 20.0 min (frame 36008); wall 175 s
- DLL: build-theatres\d190-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T11:31:21
- Map: Tundra Continents v2.3.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\tundra\20261004T143120Z-e4c91d14\runs\20261004T143418Z-d9955086\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:34.449353][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.6 min | `[t=00:00:49.388101][f=0001089] [SeaWatch] finished frame=1089 id=967 def=armsy builder=21079` |
| expect `first-ship-exit` | seen at 2.4 min | `[t=00:00:56.956569][f=0004290] [SeaWatch] egress id=28938 yard=967 seconds=13.7 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\tundra\20261004T143120Z-e4c91d14\runs\20261004T143418Z-d9955086\screen_2026-10-04_14-32-32-699.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\tundra\20261004T143120Z-e4c91d14\runs\20261004T143418Z-d9955086\screen_2026-10-04_14-32-57-286.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\tundra\20261004T143120Z-e4c91d14\runs\20261004T143418Z-d9955086\screen_2026-10-04_14-34-17-570.png

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
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(5323,790) factory=armsy landLocked=no spot=4 known=1/3
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(6399,801) factory=corsy landLocked=no spot=5 known=2/3
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(7814,1506) factory=legsy landLocked=no spot=6 known=3/3
  0.12  [SEA][Layout] berth sea.berth.1 armasy at=4496,2096 facing=0
  0.13  [SEA][Layout] berth sea.berth.2 armasy at=4896,2096 facing=0
  0.15  [Playtest] finished armmex team 0 at 0.16 min
  0.17  [Team][Roster] first mex 9129 at 4016,2016
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4100|2097|0|3|1|4016|2016
  0.17  [Team][Roster] team 2 first mex at 6384,720
  0.20  [Team][Roster] team 3 first mex at 7984,1504
  0.27  [Team][Roster] team 1 first mex at 5136,752
  0.60  [Playtest] finished armsy team 0 at 0.61 min
  0.83  [Playtest] finished armmex team 0 at 0.83 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 645/1200, energy +30.0 bank 79/1100, units 5
  1.28  [Playtest] finished armtide team 0 at 1.28 min
  1.63  [Playtest] finished armmex team 0 at 1.63 min
  1.91  [Playtest] finished armtide team 0 at 1.91 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 689/1250, energy +60.0 bank 135/1200, units 9
  2.10  [Playtest] finished armtide team 0 at 2.10 min
  2.31  [Playtest] finished armtide team 0 at 2.31 min
  2.85  [Playtest] finished armmex team 0 at 2.85 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 1080/1300, energy +104.0 bank 677/1400, units 15
  3.20  [Playtest] finished armmex team 0 at 3.20 min
  3.24  [Playtest] finished armmex team 0 at 3.24 min
  3.40  [Playtest] finished armtide team 0 at 3.40 min
  3.84  [Playtest] finished armmex team 0 at 3.84 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +16.0 bank 1288/1450, energy +119.0 bank 115/1450, units 21
  4.17  [Playtest] finished armmex team 0 at 4.17 min
  4.26  [Playtest] finished armtide team 0 at 4.26 min
  4.37  [Playtest] finished armtl team 0 at 4.37 min
  4.49  [Playtest] finished armmex team 0 at 4.49 min
  4.99  [Playtest] finished armmex team 0 at 4.99 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +20.0 bank 1449/1600, energy +134.0 bank 159/1500, units 24
  5.00  [Playtest] target team 0 at (4100, 2100) from its start position
  5.00  [Playtest] camera requested (4100,2100) height=2200
  5.01  [Playtest] camera captured name=ta position=(4100,2100) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (4100, 2100)
  5.03  [Playtest] finished armtide team 0 at 5.03 min
  5.31  [Playtest] finished armmex team 0 at 5.31 min
  5.34  [Playtest] finished armtide team 0 at 5.34 min
  5.35  [Playtest] finished armmex team 0 at 5.35 min
  5.64  [Playtest] finished armtide team 0 at 5.64 min
  5.95  [Playtest] finished armtide team 0 at 5.95 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +26.0 bank 1680/1700, energy +194.0 bank 984/1700, units 33
  6.06  [Playtest] finished armtl team 0 at 6.06 min
  6.26  [Playtest] finished armtide team 0 at 6.26 min
  6.57  [Playtest] finished armtide team 0 at 6.57 min
  6.80  [Playtest] finished armmex team 0 at 6.80 min
  6.90  [Playtest] finished armmex team 0 at 6.90 min
  6.97  [Playtest] finished armtl team 0 at 6.97 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +26.0 bank 1693/1700, energy +238.0 bank 1890/1900, units 38
  7.13  [Playtest] finished armmex team 0 at 7.13 min
  7.19  [Playtest] finished armtide team 0 at 7.19 min
  7.31  [Playtest] finished armllt team 0 at 7.31 min
  7.51  [Playtest] finished armtide team 0 at 7.51 min
  7.77  [Playtest] finished armtide team 0 at 7.77 min
  7.78  [Playtest] finished armtide team 0 at 7.78 min
  7.79  [Playtest] finished armtl team 0 at 7.79 min
  7.83  [Playtest] finished armtide team 0 at 7.83 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +28.0 bank 1725/1750, energy +320.0 bank 2156/2200, units 46
  8.05  [Playtest] finished armtl team 0 at 8.05 min
  8.34  [Playtest] finished armtide team 0 at 8.34 min
  8.60  [Playtest] finished armnanotcplat team 0 at 8.60 min
  8.61  [Playtest] finished armmex team 0 at 8.61 min
  8.62  [Playtest] finished armnanotcplat team 0 at 8.61 min
  8.76  [Playtest] finished armnanotcplat team 0 at 8.76 min
  8.83  [Playtest] finished armtide team 0 at 8.83 min
  8.94  [Playtest] finished armmex team 0 at 8.94 min
  8.98  [Playtest] finished armtide team 0 at 8.98 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +31.9 bank 1533/1850, energy +357.5 bank 2328/2350, units 56
  9.04  [Playtest] finished armtide team 0 at 9.04 min
  9.13  [Playtest] finished armfrad team 0 at 9.13 min
  9.15  [Playtest] finished armtide team 0 at 9.15 min
  9.20  [Playtest] finished armtide team 0 at 9.20 min
  9.26  [Playtest] finished armtide team 0 at 9.26 min
  9.27  [Playtest] finished armmex team 0 at 9.27 min
  9.39  [Playtest] finished armtide team 0 at 9.39 min
  9.58  [Playtest] finished armtide team 0 at 9.58 min
  9.73  [Playtest] finished armtide team 0 at 9.73 min
  9.79  [Playtest] finished armtide team 0 at 9.79 min
  9.86  [Playtest] finished armtide team 0 at 9.86 min
  9.95  [Playtest] finished armfmkr team 0 at 9.95 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +33.0 bank 1640/1850, energy +500.0 bank 2611/2800, units 68
 10.00  [Playtest] camera requested (4100,2100) height=2200
 10.02  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (4100, 2100)
 10.17  [Playtest] finished armtide team 0 at 10.17 min
 10.20  [Playtest] finished armtide team 0 at 10.20 min
 10.21  [Playtest] finished armfmkr team 0 at 10.21 min
 10.44  [Playtest] finished armtide team 0 at 10.44 min
 10.46  [Playtest] finished armtide team 0 at 10.46 min
 10.56  [Playtest] finished armmex team 0 at 10.56 min
 10.59  [Playtest] finished armtide team 0 at 10.59 min
 10.59  [Playtest] finished armtl team 0 at 10.59 min
 10.73  [Playtest] finished armtide team 0 at 10.73 min
 10.88  [Playtest] finished armfrad team 0 at 10.88 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +35.9 bank 1033/1900, energy +597.0 bank 3122/3150, units 78
 11.10  [Playtest] finished armtl team 0 at 11.10 min
 11.81  [Playtest] finished armmex team 0 at 11.81 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +35.9 bank 112/1900, energy +597.0 bank 3117/3150, units 83
 12.20  [Playtest] finished armfrad team 0 at 12.20 min
 12.24  [Playtest] finished armfmkr team 0 at 12.24 min
 12.45  [Playtest] finished armmex team 0 at 12.44 min
 12.48  [Playtest] finished armfmkr team 0 at 12.48 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +37.9 bank 130/1900, energy +597.0 bank 2792/3150, units 87
 13.13  [Playtest] finished armmex team 0 at 13.13 min
 13.17  [Playtest] finished armtl team 0 at 13.17 min
 13.46  [Playtest] finished armmex team 0 at 13.46 min
 13.73  [Playtest] finished armfrad team 0 at 13.73 min
 13.93  [Playtest] finished armfrad team 0 at 13.93 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +41.9 bank 19/2000, energy +597.0 bank 2959/3150, units 90
 14.39  [Playtest] finished armfmkr team 0 at 14.40 min
 14.55  [Playtest] finished armfmkr team 0 at 14.55 min
 14.55  [Playtest] finished armtl team 0 at 14.55 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +42.1 bank 18/2000, energy +597.0 bank 2433/3150, units 94
 15.09  [Playtest] finished armtl team 0 at 15.09 min
 15.12  [Playtest] finished armfmkr team 0 at 15.13 min
 15.55  [Playtest] finished armfmkr team 0 at 15.55 min
 15.94  [Playtest] finished armfmkr team 0 at 15.94 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +39.8 bank 92/2000, energy +597.0 bank 2391/3150, units 95
 16.54  [Playtest] finished armfmkr team 0 at 16.54 min
 16.74  [Playtest] finished armmex team 0 at 16.74 min
 16.91  [Playtest] finished armmex team 0 at 16.91 min
 16.91  [Playtest] finished armfmkr team 0 at 16.91 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +46.0 bank 21/2100, energy +597.0 bank 2426/3150, units 104
 17.33  [Playtest] finished armfmkr team 0 at 17.33 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +40.5 bank 267/2050, energy +583.0 bank 2522/3050, units 98
 18.14  [Playtest] finished armfmkr team 0 at 18.14 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +45.9 bank 353/2050, energy +590.0 bank 2452/3100, units 102
 20.00  [Playtest] eco team 0 at 20.0 min: metal +40.5 bank 143/2050, energy +590.0 bank 2307/3100, units 108
 20.00  [Playtest] camera requested (4100,2100) height=2200
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(22971) at (5323, 791) walks to (5269, 780), 136 from the armmex site (5136, 752)
  0.09  EXP: approach: legcom(18714) at (7814, 1506) walks to (7847, 1506), 137 from the legmex site (7984, 1504)
  0.09  EXP: approach: corcom(365) at (9054, 11420) walks to (9370, 11501), 139 from the cormex site (9504, 11536)
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
  0.10  RESERVE: zone 1 at (7808, 1504) facing 0, 6x6 cells: 36 of 36 held
  0.10  RESERVE: legsy at (7808, 1504) facing 0 (id 1)
  0.10  RESERVE: corridor 2 at (7808, 1792) facing 0, 12x30 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (7752, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7752, 1288) facing 0 (id 2)
  0.10  RESERVE: zone 4 at (7816, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7816, 1288) facing 0 (id 3)
  0.10  RESERVE: zone 5 at (7880, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7880, 1288) facing 0 (id 4)
  0.10  RESERVE: zone 6 at (7752, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7752, 1352) facing 0 (id 5)
  0.10  RESERVE: zone 7 at (7816, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7816, 1352) facing 0 (id 6)
  0.10  RESERVE: zone 8 at (7880, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7880, 1352) facing 0 (id 7)
  0.10  RESERVE: zone 9 at (7808, 1312) facing 0, 12x8 cells: 42 of 96 held
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
  0.11  EXP: idle: legcom(18714) on legmex at (7840, 1506), site (7984, 1504), target yes, fails 1 (arrived at the approach point)
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
