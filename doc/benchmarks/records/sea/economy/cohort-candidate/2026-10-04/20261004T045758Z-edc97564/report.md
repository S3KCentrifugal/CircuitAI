# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54004); wall 308 s
- DLL: build-theatres\d188-build-6\SkirmishAI.dll (ac71826721992d84); AI BARbTest/test; staged 2026-10-04T01:52:46
- Map: Tundra Continents v2.3.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\tundra\20261004T045246Z-f1e0ca0c\runs\20261004T045758Z-edc97564\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:37.124192][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.5 min | `[t=00:00:57.818931][f=0002722] [SeaWatch] finished frame=2722 id=14569 def=armsy builder=7504` |
| expect `first-ship-exit` | seen at 3.5 min | `[t=00:01:05.767492][f=0006300] [SeaWatch] egress id=9448 yard=14569 seconds=37.5 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\tundra\20261004T045246Z-f1e0ca0c\runs\20261004T045758Z-edc97564\screen_2026-10-04_04-54-03-885.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\tundra\20261004T045246Z-f1e0ca0c\runs\20261004T045758Z-edc97564\screen_2026-10-04_04-54-33-724.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\tundra\20261004T045246Z-f1e0ca0c\runs\20261004T045758Z-edc97564\screen_2026-10-04_04-55-58-181.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\tundra\20261004T045246Z-f1e0ca0c\runs\20261004T045758Z-edc97564\screen_2026-10-04_04-57-41-925.png

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
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(5344,796) factory=armsy landLocked=no spot=4 known=1/3
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(6399,801) factory=corsy landLocked=no spot=5 known=2/3
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(7824,1501) factory=legsy landLocked=no spot=6 known=3/3
  0.17  [SEA][Layout] berth sea.berth.0 armsy at=4000,2096 facing=0
  0.17  [Team][Roster] team 2 first mex at 6384,720
  0.18  [SEA][Layout] berth sea.berth.1 armasy at=4496,2096 facing=0
  0.20  [SEA][Layout] berth sea.berth.2 armasy at=4896,2096 facing=0
  0.22  [Team][Roster] team 3 first mex at 7984,1504
  0.23  [Playtest] finished armmex team 0 at 0.23 min
  0.23  [Team][Roster] first mex 24212 at 4016,2016
  0.23  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4098|2103|0|3|1|4016|2016
  0.28  [Team][Roster] team 1 first mex at 5136,752
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.0 bank 1043/1050, energy +30.0 bank 977/1000, units 2
  1.21  [Playtest] finished armmex team 0 at 1.21 min
  1.51  [Playtest] finished armsy team 0 at 1.51 min
  1.98  [Playtest] finished armtide team 0 at 1.98 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.0 bank 702/1200, energy +37.5 bank 65/1150, units 6
  2.31  [Playtest] finished armmex team 0 at 2.31 min
  2.54  [Playtest] finished armtide team 0 at 2.54 min
  2.72  [Playtest] finished armtide team 0 at 2.72 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 955/1250, energy +82.0 bank 0/1300, units 11
  3.21  [Playtest] finished armtl team 0 at 3.21 min
  3.33  [Playtest] finished armtide team 0 at 3.33 min
  3.39  [Playtest] finished armtide team 0 at 3.39 min
  3.75  [Playtest] finished armtide team 0 at 3.75 min
  3.88  [Playtest] finished armmex team 0 at 3.88 min
  3.94  [Playtest] finished armtide team 0 at 3.94 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 814/1300, energy +149.0 bank 360/1550, units 18
  4.25  [Playtest] finished armtide team 0 at 4.25 min
  4.55  [Playtest] finished armtide team 0 at 4.55 min
  4.79  [Playtest] finished armmex team 0 at 4.79 min
  4.87  [Playtest] finished armtide team 0 at 4.87 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +12.0 bank 736/1350, energy +194.0 bank 1568/1700, units 27
  5.00  [Playtest] target team 0 at (4100, 2100) from its start position
  5.00  [Playtest] camera requested (4100,2100) height=2200
  5.01  [Playtest] finished armmex team 0 at 5.01 min
  5.02  [Playtest] camera captured name=ta position=(4100,2100) height=2200
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (4100, 2100)
  5.19  [Playtest] finished armtide team 0 at 5.19 min
  5.24  [Playtest] finished armtl team 0 at 5.24 min
  5.47  [Playtest] finished armmex team 0 at 5.47 min
  5.50  [Playtest] finished armtide team 0 at 5.50 min
  5.90  [Playtest] finished armtide team 0 at 5.90 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +16.0 bank 595/1450, energy +239.0 bank 1832/1850, units 34
  6.07  [Playtest] finished armfrad team 0 at 6.07 min
  6.19  [Playtest] finished armmex team 0 at 6.19 min
  6.22  [Playtest] finished armtide team 0 at 6.22 min
  6.54  [Playtest] finished armtide team 0 at 6.54 min
  6.73  [Playtest] finished armmex team 0 at 6.73 min
  6.86  [Playtest] finished armtide team 0 at 6.86 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +20.0 bank 503/1550, energy +284.0 bank 1992/2000, units 37
  7.12  [Playtest] finished armfrad team 0 at 7.12 min
  7.18  [Playtest] finished armtide team 0 at 7.18 min
  7.59  [Playtest] finished armtide team 0 at 7.59 min
  7.64  [Playtest] finished armtl team 0 at 7.64 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +20.0 bank 554/1550, energy +321.0 bank 2143/2150, units 43
  8.08  [Playtest] finished armtide team 0 at 8.08 min
  8.21  [Playtest] finished armmex team 0 at 8.21 min
  8.41  [Playtest] finished armtide team 0 at 8.41 min
  8.44  [Playtest] finished armtide team 0 at 8.44 min
  8.47  [Playtest] finished armtl team 0 at 8.47 min
  8.52  [Playtest] finished armfmkr team 0 at 8.52 min
  8.84  [Playtest] finished armtide team 0 at 8.84 min
  8.90  [Playtest] finished armfmkr team 0 at 8.90 min
  8.90  [Playtest] finished armtide team 0 at 8.90 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +24.0 bank 592/1600, energy +396.0 bank 2334/2400, units 52
  9.26  [Playtest] finished armtide team 0 at 9.26 min
  9.36  [Playtest] finished armfmkr team 0 at 9.36 min
  9.76  [Playtest] finished armnanotcplat team 0 at 9.76 min
  9.95  [Playtest] finished armfrad team 0 at 9.95 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +25.0 bank 687/1600, energy +418.0 bank 2349/2500, units 59
 10.00  [Playtest] camera requested (4100,2100) height=2200
 10.02  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (4100, 2100)
 10.08  [Playtest] finished armtide team 0 at 10.08 min
 10.11  [Playtest] finished armtl team 0 at 10.11 min
 10.28  [Playtest] finished armtide team 0 at 10.28 min
 10.30  [Playtest] finished armtide team 0 at 10.30 min
 10.61  [Playtest] finished armtide team 0 at 10.61 min
 10.66  [Playtest] finished armtide team 0 at 10.66 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +29.6 bank 22/1600, energy +493.0 bank 2683/2750, units 65
 11.03  [Playtest] finished armtide team 0 at 11.03 min
 11.44  [Playtest] finished armtl team 0 at 11.44 min
 11.46  [Playtest] finished armtide team 0 at 11.46 min
 11.59  [Playtest] finished armtide team 0 at 11.59 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +25.7 bank 148/1550, energy +538.0 bank 2857/2900, units 64
 12.18  [Playtest] finished armtide team 0 at 12.18 min
 12.30  [Playtest] finished armtide team 0 at 12.30 min
 12.38  [Playtest] finished armfrad team 0 at 12.38 min
 12.72  [Playtest] finished armmex team 0 at 12.72 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +13.0 bank 4/1300, energy +554.0 bank 2868/2900, units 54
 13.94  [Playtest] finished armtl team 0 at 13.94 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +5.0 bank 407/550, energy +382.0 bank 1700/1700, units 30
 14.02  [SEA][Layout] berth sea.berth.3 armsy at=4288,2096 facing=0
 14.22  [SEA][Layout] berth sea.berth.4 armsy at=3648,2288 facing=0
 14.47  [SEA][Layout] berth sea.berth.5 armsy at=4352,2720 facing=0
 14.60  [SEA][Layout] berth sea.berth.6 armsy at=3824,2368 facing=0
 15.00  [Playtest] eco team 0 at 15.0 min: metal +0.0 bank 395/500, energy +7.0 bank 548/550, units 4
 15.12  [SEA][Layout] berth sea.berth.7 armsy at=4096,2672 facing=0
 15.16  [SEA][Layout] berth sea.berth.8 armsy at=4096,2096 facing=0
 15.70  [SEA][Layout] berth sea.berth.9 armsy at=3472,2368 facing=0
 16.00  [Playtest] eco team 0 at 16.0 min: metal +0.0 bank 395/500, energy +7.0 bank 527/550, units 3
 16.35  [SEA][Layout] berth sea.berth.10 armsy at=4320,1568 facing=1
 17.00  [Playtest] eco team 0 at 17.0 min: metal +0.0 bank 382/500, energy +7.0 bank 514/550, units 4
 17.20  [SEA][Layout] berth sea.berth.11 armsy at=4400,1392 facing=1
 18.00  [Playtest] eco team 0 at 18.0 min: metal +0.0 bank 413/500, energy +7.0 bank 550/550, units 2
 19.00  [Playtest] eco team 0 at 19.0 min: metal +0.0 bank 437/500, energy +0.0 bank 500/500, units 0
 20.00  [Playtest] eco team 0 at 20.0 min: metal +0.0 bank 437/500, energy +0.0 bank 500/500, units 0
 20.00  [Playtest] camera requested (4100,2100) height=2200
 20.01  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (4100, 2100)
 21.00  [Playtest] eco team 0 at 21.0 min: metal +0.0 bank 437/500, energy +0.0 bank 500/500, units 0
 22.00  [Playtest] eco team 0 at 22.0 min: metal +0.0 bank 437/500, energy +0.0 bank 500/500, units 0
 23.00  [Playtest] eco team 0 at 23.0 min: metal +0.0 bank 437/500, energy +0.0 bank 500/500, units 0
 24.00  [Playtest] eco team 0 at 24.0 min: metal +0.0 bank 437/500, energy +0.0 bank 500/500, units 0
 25.00  [Playtest] eco team 0 at 25.0 min: metal +0.0 bank 437/500, energy +0.0 bank 500/500, units 0
 26.00  [Playtest] eco team 0 at 26.0 min: metal +0.0 bank 437/500, energy +0.0 bank 500/500, units 0
 27.00  [Playtest] eco team 0 at 27.0 min: metal +0.0 bank 437/500, energy +0.0 bank 500/500, units 0
 28.00  [Playtest] eco team 0 at 28.0 min: metal +0.0 bank 437/500, energy +0.0 bank 500/500, units 0
 29.00  [Playtest] eco team 0 at 29.0 min: metal +0.0 bank 437/500, energy +0.0 bank 500/500, units 0
 29.00  [Playtest] camera requested (4100,2100) height=2200
 29.02  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (4100, 2100)
 30.00  [Playtest] eco team 0 at 30.0 min: metal +0.0 bank 437/500, energy +0.0 bank 500/500, units 0
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(7132) at (5345, 797) walks to (5269, 780), 136 from the armmex site (5136, 752)
  0.09  EXP: approach: legcom(27495) at (7824, 1502) walks to (7847, 1502), 137 from the legmex site (7984, 1504)
  0.09  EXP: approach: corcom(6129) at (9041, 11417) walks to (9370, 11502), 139 from the cormex site (9504, 11536)
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
  0.11  EXP: idle: legcom(27495) on legmex at (7839, 1502), site (7984, 1504), target yes, fails 2 (arrived at the approach point)
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
