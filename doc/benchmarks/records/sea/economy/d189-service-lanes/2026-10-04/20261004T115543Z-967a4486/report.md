# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.1 min (frame 54126); wall 278 s
- DLL: build-theatres\d189-build-7\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T08:51:02
- Map: Tundra Continents v2.3.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-service-lanes\tundra\20261004T115102Z-737bd599\runs\20261004T115543Z-967a4486\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:36.002989][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.6 min | `[t=00:00:51.496645][f=0001104] [SeaWatch] finished frame=1104 id=3076 def=armsy builder=24679` |
| expect `first-ship-exit` | seen at 2.1 min | `[t=00:00:57.376536][f=0003750] [SeaWatch] egress id=24884 yard=3076 seconds=11.1 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-service-lanes\tundra\20261004T115102Z-737bd599\runs\20261004T115543Z-967a4486\screen_2026-10-04_11-52-16-706.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-service-lanes\tundra\20261004T115102Z-737bd599\runs\20261004T115543Z-967a4486\screen_2026-10-04_11-52-38-358.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-service-lanes\tundra\20261004T115102Z-737bd599\runs\20261004T115543Z-967a4486\screen_2026-10-04_11-53-55-831.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-service-lanes\tundra\20261004T115102Z-737bd599\runs\20261004T115543Z-967a4486\screen_2026-10-04_11-55-29-251.png

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
  0.10  [SEA][Layout] berth sea.berth.0 armsy at=4096,2096 facing=0
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|4100|2097|0|3|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(5326,791) factory=armsy landLocked=no spot=4 known=1/3
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(6399,801) factory=corsy landLocked=no spot=5 known=2/3
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(7823,1501) factory=legsy landLocked=no spot=6 known=3/3
  0.12  [SEA][Layout] berth sea.berth.1 armasy at=4496,2096 facing=0
  0.13  [SEA][Layout] berth sea.berth.2 armasy at=4896,2096 facing=0
  0.15  [Playtest] finished armmex team 0 at 0.16 min
  0.17  [Team][Roster] first mex 21142 at 4016,2016
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4100|2097|0|3|1|4016|2016
  0.17  [Team][Roster] team 2 first mex at 6384,720
  0.20  [Team][Roster] team 3 first mex at 7984,1504
  0.27  [Team][Roster] team 1 first mex at 5136,752
  0.61  [Playtest] finished armsy team 0 at 0.61 min
  0.92  [Playtest] finished armtide team 0 at 0.92 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.0 bank 546/1150, energy +45.0 bank 89/1150, units 5
  1.27  [Playtest] finished armmex team 0 at 1.27 min
  1.62  [Playtest] finished armmex team 0 at 1.62 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 659/1250, energy +52.0 bank 127/1200, units 9
  2.52  [Playtest] finished armtide team 0 at 2.52 min
  2.61  [Playtest] finished armtide team 0 at 2.61 min
  2.72  [Playtest] finished armmex team 0 at 2.72 min
  2.81  [Playtest] finished armtide team 0 at 2.81 min
  2.98  [Playtest] finished armmex team 0 at 2.98 min
  2.99  [Playtest] finished armtide team 0 at 2.99 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +11.0 bank 1106/1350, energy +97.0 bank 187/1400, units 14
  3.46  [Playtest] finished armtl team 0 at 3.46 min
  3.52  [Playtest] finished armtide team 0 at 3.52 min
  3.68  [Playtest] finished armfrad team 0 at 3.68 min
  3.77  [Playtest] finished armmex team 0 at 3.77 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +14.0 bank 1197/1400, energy +134.0 bank 162/1500, units 22
  4.10  [Playtest] finished armmex team 0 at 4.10 min
  4.35  [Playtest] finished armtide team 0 at 4.35 min
  4.41  [Playtest] finished armmex team 0 at 4.41 min
  4.45  [Playtest] finished armtl team 0 at 4.45 min
  4.92  [Playtest] finished armmex team 0 at 4.92 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +20.0 bank 1398/1550, energy +149.0 bank 1060/1550, units 26
  5.00  [Playtest] target team 0 at (4100, 2100) from its start position
  5.00  [Playtest] camera requested (4100,2100) height=2200
  5.01  [Playtest] camera captured name=ta position=(4100,2100) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (4100, 2100)
  5.24  [Playtest] finished armmex team 0 at 5.24 min
  5.24  [Playtest] finished armtide team 0 at 5.24 min
  5.36  [Playtest] finished armmex team 0 at 5.36 min
  5.55  [Playtest] finished armtide team 0 at 5.55 min
  5.86  [Playtest] finished armtide team 0 at 5.86 min
  5.95  [Playtest] finished armtl team 0 at 5.95 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +24.0 bank 1642/1650, energy +194.0 bank 1016/1650, units 32
  6.17  [Playtest] finished armtide team 0 at 6.17 min
  6.48  [Playtest] finished armtide team 0 at 6.48 min
  6.67  [Playtest] finished armmex team 0 at 6.67 min
  6.99  [Playtest] finished armtide team 0 at 6.99 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +24.0 bank 1639/1650, energy +224.0 bank 1828/1850, units 36
  7.23  [Playtest] finished armmex team 0 at 7.23 min
  7.33  [Playtest] finished armtide team 0 at 7.33 min
  7.56  [Playtest] finished armmex team 0 at 7.56 min
  7.66  [Playtest] finished armtide team 0 at 7.66 min
  7.71  [Playtest] finished armtl team 0 at 7.70 min
  7.88  [Playtest] finished armmex team 0 at 7.88 min
  7.97  [Playtest] finished armtide team 0 at 7.97 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +28.0 bank 1749/1750, energy +284.0 bank 1993/2000, units 41
  8.29  [Playtest] finished armtide team 0 at 8.29 min
  8.96  [Playtest] finished armtl team 0 at 8.96 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +26.0 bank 1694/1700, energy +299.0 bank 2034/2050, units 43
  9.06  [Playtest] finished armnanotcplat team 0 at 9.06 min
  9.36  [Playtest] finished armfrad team 0 at 9.36 min
  9.43  [Playtest] finished armtide team 0 at 9.43 min
  9.76  [Playtest] finished armtide team 0 at 9.76 min
  9.93  [Playtest] finished armnanotcplat team 0 at 9.93 min
  9.99  [Playtest] finished armtide team 0 at 9.99 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +26.0 bank 1404/1700, energy +329.0 bank 2197/2200, units 50
 10.00  [Playtest] camera requested (4100,2100) height=2200
 10.02  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (4100, 2100)
 10.14  [Playtest] finished armtide team 0 at 10.14 min
 10.38  [Playtest] finished armtide team 0 at 10.38 min
 10.45  [Playtest] finished armtide team 0 at 10.45 min
 10.67  [Playtest] finished armtide team 0 at 10.67 min
 10.74  [Playtest] finished armtide team 0 at 10.74 min
 10.98  [Playtest] finished armtide team 0 at 10.98 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +26.0 bank 1189/1700, energy +440.5 bank 2595/2600, units 59
 11.02  [Playtest] finished armtide team 0 at 11.02 min
 11.13  [Playtest] finished armtide team 0 at 11.13 min
 11.23  [Playtest] finished armtide team 0 at 11.23 min
 11.30  [Playtest] finished armtide team 0 at 11.30 min
 11.32  [Playtest] finished armtl team 0 at 11.32 min
 11.39  [Playtest] finished armmex team 0 at 11.39 min
 11.72  [Playtest] finished armmex team 0 at 11.72 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +30.0 bank 597/1800, energy +522.0 bank 2859/2900, units 69
 12.02  [Playtest] finished armfrad team 0 at 12.02 min
 12.31  [Playtest] finished armfrad team 0 at 12.31 min
 12.42  [Playtest] finished armmex team 0 at 12.42 min
 12.71  [Playtest] finished armtl team 0 at 12.71 min
 12.93  [Playtest] finished armtl team 0 at 12.93 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +31.9 bank 17/1850, energy +522.0 bank 2871/2900, units 82
 13.10  [Playtest] finished armtide team 0 at 13.10 min
 13.19  [Playtest] finished armtl team 0 at 13.19 min
 13.43  [Playtest] finished armtide team 0 at 13.43 min
 13.73  [Playtest] finished armtide team 0 at 13.73 min
 13.77  [Playtest] finished armfrad team 0 at 13.77 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +31.9 bank 17/1850, energy +567.0 bank 3034/3050, units 81
 14.04  [Playtest] finished armtide team 0 at 14.04 min
 14.34  [Playtest] finished armfrad team 0 at 14.34 min
 14.39  [Playtest] finished armtide team 0 at 14.39 min
 14.42  [Playtest] finished armtl team 0 at 14.42 min
 14.73  [Playtest] finished armtide team 0 at 14.73 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +29.9 bank 123/1350, energy +582.0 bank 2668/2700, units 80
 15.06  [Playtest] finished armtide team 0 at 15.06 min
 15.41  [Playtest] finished armtide team 0 at 15.41 min
 15.78  [Playtest] finished armtide team 0 at 15.78 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +22.0 bank 10/1150, energy +620.0 bank 2790/2800, units 75
 16.44  [Playtest] finished armtl team 0 at 16.44 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +17.8 bank 0/1000, energy +595.5 bank 2592/2600, units 66
 17.18  [Playtest] finished armfrad team 0 at 17.18 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +10.0 bank 176/700, energy +590.0 bank 2500/2500, units 53
 18.15  [SEA][Layout] berth sea.berth.3 legsy at=2944,2096 facing=0
 19.00  [Playtest] eco team 0 at 19.0 min: metal +2.0 bank 392/550, energy +0.0 bank 492/500, units 4
 20.00  [Playtest] eco team 0 at 20.0 min: metal +2.0 bank 512/550, energy +0.0 bank 492/500, units 4
 20.00  [Playtest] camera requested (4100,2100) height=2200
 20.02  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (4100, 2100)
 21.00  [Playtest] eco team 0 at 21.0 min: metal +2.0 bank 522/550, energy +0.0 bank 492/500, units 4
 22.00  [Playtest] eco team 0 at 22.0 min: metal +0.0 bank 445/500, energy +0.0 bank 487/500, units 0
 23.00  [Playtest] eco team 0 at 23.0 min: metal +0.0 bank 445/500, energy +0.0 bank 487/500, units 0
 24.00  [Playtest] eco team 0 at 24.0 min: metal +0.0 bank 445/500, energy +0.0 bank 487/500, units 0
 25.00  [Playtest] eco team 0 at 25.0 min: metal +0.0 bank 445/500, energy +0.0 bank 487/500, units 0
 26.00  [Playtest] eco team 0 at 26.0 min: metal +0.0 bank 445/500, energy +0.0 bank 487/500, units 0
 27.00  [Playtest] eco team 0 at 27.0 min: metal +0.0 bank 445/500, energy +0.0 bank 487/500, units 0
 28.00  [Playtest] eco team 0 at 28.0 min: metal +0.0 bank 445/500, energy +0.0 bank 487/500, units 0
 29.00  [Playtest] eco team 0 at 29.0 min: metal +0.0 bank 445/500, energy +0.0 bank 487/500, units 0
 29.00  [Playtest] camera requested (4100,2100) height=2200
 29.02  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (4100, 2100)
 30.00  [Playtest] eco team 0 at 30.0 min: metal +0.0 bank 445/500, energy +0.0 bank 487/500, units 0
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(891) at (5327, 792) walks to (5269, 780), 136 from the armmex site (5136, 752)
  0.09  EXP: approach: legcom(28578) at (7824, 1502) walks to (7847, 1502), 137 from the legmex site (7984, 1504)
  0.09  EXP: approach: corcom(22737) at (9054, 11421) walks to (9370, 11501), 139 from the cormex site (9504, 11536)
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
  0.11  EXP: idle: legcom(28578) on legmex at (7839, 1502), site (7984, 1504), target yes, fails 1 (arrived at the approach point)
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
