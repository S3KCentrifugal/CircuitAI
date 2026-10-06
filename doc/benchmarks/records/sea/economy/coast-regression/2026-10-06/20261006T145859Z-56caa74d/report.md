# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 10.0 min (frame 18014); wall 108 s
- DLL: build-theatres\d216-final\SkirmishAI.dll (45eb0f2e89a285e3); AI BARbTest/test; staged 2026-10-06T11:57:08
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=TECH/armada/test, 2=FRONT/cortex/test, 3=AIR/legion/test, 4=FRONT/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=TACTICAL/armada/test, 8=FRONT/cortex/test, 9=TECH/legion/test, 10=FRONT/armada/test, 11=AIR/cortex/test, 12=SEA/legion/test, 13=SEA/armada/test, 14=SEA/cortex/test, 15=TACTICAL/legion/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\coast-regression\glacial\20261006T145708Z-d7572154\runs\20261006T145859Z-56caa74d\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:28.329238][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.8 min | `[t=00:00:50.411132][f=0001358] [SeaWatch] finished frame=1358 id=7065 def=armsy builder=12850` |
| expect `first-ship-exit` | seen at 3.0 min | `[t=00:00:59.983080][f=0005490] [SeaWatch] egress id=20323 yard=7065 seconds=66.1 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 2.1 min: [INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s
- forbid 'invariant' hit at 4.2 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 840 (3 by power), bank 0 + 12/s (0 by metal))
- forbid 'invariant' hit at 5.2 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 840 (3 by power), bank 0 + 12/s (0 by metal))
- forbid 'invariant' hit at 5.8 min: [INVARIANT] INV-029 legalab 614 stands 3 cells from the turrets, not tight

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\coast-regression\glacial\20261006T145708Z-d7572154\runs\20261006T145859Z-56caa74d\screen_2026-10-06_14-58-22-665.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\coast-regression\glacial\20261006T145708Z-d7572154\runs\20261006T145859Z-56caa74d\screen_2026-10-06_14-58-58-615.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 10.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (1430, 4000) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (490, 1140) units 1
  0.00  [Playtest] frame 1 team 2 ally 0 side cortex ai true dead false start (1800, 1400) units 1
  0.00  [Playtest] frame 1 team 3 ally 0 side legion ai true dead false start (430, 2300) units 1
  0.00  [Playtest] frame 1 team 4 ally 0 side armada ai true dead false start (1800, 2550) units 1
  0.00  [Playtest] frame 1 team 5 ally 0 side cortex ai true dead false start (700, 4600) units 1
  0.00  [Playtest] frame 1 team 6 ally 0 side legion ai true dead false start (1900, 5800) units 1
  0.00  [Playtest] frame 1 team 7 ally 0 side armada ai true dead false start (880, 6850) units 1
  0.00  [Playtest] frame 1 team 8 ally 1 side cortex ai true dead false start (12572, 1400) units 1
  0.00  [Playtest] frame 1 team 9 ally 1 side legion ai true dead false start (14000, 1100) units 1
  0.00  [Playtest] frame 1 team 10 ally 1 side armada ai true dead false start (12640, 2500) units 1
  0.00  [Playtest] frame 1 team 11 ally 1 side cortex ai true dead false start (13890, 2246) units 1
  0.00  [Playtest] frame 1 team 12 ally 1 side legion ai true dead false start (12925, 4000) units 1
  0.00  [Playtest] frame 1 team 13 ally 1 side armada ai true dead false start (13700, 4600) units 1
  0.00  [Playtest] frame 1 team 14 ally 1 side cortex ai true dead false start (12618, 5800) units 1
  0.00  [Playtest] frame 1 team 15 ally 1 side legion ai true dead false start (13454, 6850) units 1
  0.00  [Playtest] frame 1 team 16 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 17 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (1430, 4000) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (490, 1140) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (1800, 1400) units 1
  0.05  [Playtest] frame 90 team 3 ally 0 side legion ai true dead false start (430, 2300) units 1
  0.05  [Playtest] frame 90 team 4 ally 0 side armada ai true dead false start (1800, 2550) units 1
  0.05  [Playtest] frame 90 team 5 ally 0 side cortex ai true dead false start (700, 4600) units 1
  0.05  [Playtest] frame 90 team 6 ally 0 side legion ai true dead false start (1900, 5800) units 1
  0.05  [Playtest] frame 90 team 7 ally 0 side armada ai true dead false start (880, 6850) units 1
  0.05  [Playtest] frame 90 team 8 ally 1 side cortex ai true dead false start (12572, 1400) units 1
  0.05  [Playtest] frame 90 team 9 ally 1 side legion ai true dead false start (14000, 1100) units 1
  0.05  [Playtest] frame 90 team 10 ally 1 side armada ai true dead false start (12640, 2500) units 1
  0.05  [Playtest] frame 90 team 11 ally 1 side cortex ai true dead false start (13890, 2246) units 1
  0.05  [Playtest] frame 90 team 12 ally 1 side legion ai true dead false start (12925, 4000) units 1
  0.05  [Playtest] frame 90 team 13 ally 1 side armada ai true dead false start (13700, 4600) units 1
  0.05  [Playtest] frame 90 team 14 ally 1 side cortex ai true dead false start (12618, 5800) units 1
  0.05  [Playtest] frame 90 team 15 ally 1 side legion ai true dead false start (13454, 6850) units 1
  0.05  [Playtest] frame 90 team 16 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 17 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.10  [SEA][Layout] berth sea.berth.0 armsy at=1424,4000 facing=1
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(490,1137) factory=armlab landLocked=no spot=0 known=1/7
  0.10  [Team][Roster] Team 2 (AI 2): role=FRONT side=cortex start=(1799,1401) factory=corvp landLocked=no spot=1 known=2/7
  0.10  [Team][Roster] Team 3 (AI 3): role=AIR side=legion start=(430,2300) factory=legap landLocked=no spot=2 known=3/7
  0.10  [Team][Roster] Team 4 (AI 4): role=FRONT side=armada start=(1800,2547) factory=armvp landLocked=no spot=3 known=4/7
  0.10  [Team][Roster] Team 5 (AI 5): role=SEA side=cortex start=(699,4601) factory=corsy landLocked=no spot=5 known=5/7
  0.10  [Team][Roster] Team 6 (AI 6): role=SEA side=legion start=(1900,5800) factory=legsy landLocked=no spot=6 known=6/7
  0.10  [Team][Roster] Team 7 (AI 7): role=TACTICAL side=armada start=(880,6847) factory=armhp landLocked=no spot=7 known=7/7
  0.12  [SEA][Layout] berth sea.berth.1 armasy at=1424,3600 facing=1
  0.13  [SEA][Layout] berth sea.berth.2 armplat at=1488,3264 facing=1
  0.15  [Team][Roster] team 1 first mex at 496,1296
  0.15  [Team][Roster] team 4 first mex at 1952,2576
  0.15  [Team][Roster] team 7 first mex at 880,6720
  0.16  [Playtest] finished armmex team 0 at 0.16 min
  0.17  [Team][Roster] first mex 15629 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.17  [Team][Roster] team 2 first mex at 1952,1407
  0.17  [Team][Roster] team 3 first mex at 448,2416
  0.17  [Team][Roster] team 5 first mex at 704,4447
  0.19  [Team][Roster] team 6 first mex at 1904,5968
  0.29  [Playtest] finished armmex team 0 at 0.29 min
  0.75  [Playtest] finished armsy team 0 at 0.75 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 668/1200, energy +30.0 bank 1/1100, units 6
  1.04  [Playtest] finished armmex team 0 at 1.04 min
  1.27  [Playtest] finished armmex team 0 at 1.27 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +10.0 bank 1010/1300, energy +37.0 bank 67/1150, units 8
  2.62  [Playtest] finished armtl team 0 at 2.62 min
  2.84  [Playtest] finished armfrad team 0 at 2.84 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 1180/1300, energy +37.0 bank 318/1150, units 10
  3.48  [Playtest] finished armtide team 0 at 3.48 min
  3.64  [Playtest] finished armtide team 0 at 3.64 min
  3.80  [Playtest] finished armtide team 0 at 3.80 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 807/1300, energy +113.0 bank 1311/1350, units 17
  4.12  [Playtest] finished armtide team 0 at 4.12 min
  4.34  [Playtest] finished armfmkr team 0 at 4.34 min
  4.43  [Playtest] finished armtide team 0 at 4.43 min
  4.71  [Playtest] finished armfmkr team 0 at 4.71 min
  4.76  [Playtest] finished armtide team 0 at 4.76 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +12.0 bank 470/1300, energy +182.0 bank 1343/1500, units 22
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.02  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.08  [Playtest] finished armtide team 0 at 5.08 min
  5.21  [Playtest] finished armfmkr team 0 at 5.21 min
  5.40  [Playtest] finished armfmkr team 0 at 5.40 min
  5.40  [Playtest] finished armtide team 0 at 5.40 min
  5.58  [Playtest] finished armfmkr team 0 at 5.58 min
  5.72  [Playtest] finished armtide team 0 at 5.72 min
  5.93  [Playtest] finished armfrad team 0 at 5.93 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +15.0 bank 193/1300, energy +251.0 bank 1469/1650, units 30
  6.04  [Playtest] finished armtide team 0 at 6.05 min
  6.36  [Playtest] finished armtide team 0 at 6.36 min
  6.68  [Playtest] finished armtide team 0 at 6.68 min
  6.89  [Playtest] finished armmex team 0 at 6.89 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +16.9 bank 27/1350, energy +320.0 bank 1514/1800, units 38
  7.00  [Playtest] finished armtide team 0 at 7.00 min
  7.09  [Playtest] finished armllt team 0 at 7.09 min
  7.57  [Playtest] finished armtl team 0 at 7.57 min
  7.58  [Playtest] finished armtide team 0 at 7.58 min
  7.95  [Playtest] finished armtide team 0 at 7.95 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +17.0 bank 0/1350, energy +389.0 bank 1832/1950, units 43
  8.22  [Playtest] finished armfrad team 0 at 8.22 min
  8.41  [Playtest] finished armtide team 0 at 8.41 min
  8.54  [Playtest] finished armfmkr team 0 at 8.54 min
  8.55  [Playtest] finished armmex team 0 at 8.56 min
  8.76  [Playtest] finished armtide team 0 at 8.76 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +20.0 bank 79/1400, energy +435.0 bank 1898/2050, units 46
  9.08  [Playtest] finished armtide team 0 at 9.08 min
  9.27  [Playtest] finished armmex team 0 at 9.27 min
  9.40  [Playtest] finished armtide team 0 at 9.40 min
  9.54  [Playtest] finished armfrad team 0 at 9.54 min
  9.75  [Playtest] finished armtide team 0 at 9.75 min
  9.94  [Playtest] finished armfmkr team 0 at 9.94 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +21.9 bank 102/1450, energy +504.0 bank 1770/2200, units 53
 10.00  [Playtest] camera requested (1450,4350) height=3200
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 1
  0.08  RESERVE: zone 7 at (427, 1512) facing 1, 58x77 cells: 3799 of 4466 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (923, 1512) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (875, 1512) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (827, 1512) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (779, 1512) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (1000, 1272) facing 1 (id 63)
  0.08  RESERVE: zone 8 at (1403, 1832) facing 1, 45x41 cells: 1841 of 1845 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1755, 1832) facing 1: 11 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1707, 1832) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1659, 1832) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1611, 1832) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: armlab at (1792, 1088) facing 1 (id 114)
  0.08  RESERVE: zone 9 at (1720, 1088) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (1744, 1088) facing 1: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: corridor 10 at (1768, 1184) facing 1, 21x6 cells: 122 of 126 held
  0.08  RESERVE: zone 11 at (1768, 1088) facing 0, 9x6 cells: 0 of 54 held
  0.08  RESERVE: corridor 11 at (2016, 1088) facing 1, 20x10 cells: 190 of 200 held
  0.09  EXP: approach: legcom(3424) at (1900, 5800) walks to (1901, 5831), 137 from the legmex site (1904, 5968)
  0.09  RESERVE: factory pair 'tech.factory.start' committed atomically facing 2
  0.09  RESERVE: zone 7 at (13509, 1272) facing 2, 77x63 cells: 4538 of 4851 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (13509, 776) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (13509, 824) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (13509, 872) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (13509, 920) facing 2: 12 of 13 slots (group 5, held, zone)
  0.09  RESERVE: legalab at (13496, 1096) facing 3 (id 62)
  0.09  RESERVE: packed legalab at (13496, 1096) facing 3 in zone 7 where 8 slots of group 5 reach (id 62)
  0.09  RESERVE: leglab at (12544, 1088) facing 3 (id 63)
  0.09  RESERVE: zone 8 at (12616, 1088) facing 3, 3x6 cells: 18 of 18 held
  0.09  RESERVE: grid of legnanotc 2x1 gap 0 behind (12592, 1088) facing 3: 2 of 2 slots (group 6, zone)
  0.09  RESERVE: corridor 9 at (12568, 992) facing 3, 21x6 cells: 126 of 126 held
  0.09  RESERVE: corridor 10 at (12568, 1184) facing 3, 21x6 cells: 122 of 126 held
  0.09  RESERVE: zone 11 at (12568, 1088) facing 0, 9x6 cells: 0 of 54 held
  0.09  RESERVE: corridor 11 at (12320, 1088) facing 3, 20x10 cells: 180 of 200 held
  0.09  EXP: approach: corcom(5679) at (13889, 2247) walks to (13909, 2246), 139 from the cormex site (14048, 2240)
  0.10  RESERVE: zone 1 at (1424, 4000) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (1424, 4000) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (1712, 4000) facing 1, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (1208, 4280) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1208, 4280) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (1208, 4232) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1208, 4232) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (1208, 4184) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1208, 4184) facing 1 (id 4)
  0.10  RESERVE: zone 6 at (1208, 4136) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1208, 4136) facing 1 (id 5)
  0.10  RESERVE: zone 7 at (1208, 4088) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1208, 4088) facing 1 (id 6)
  0.10  RESERVE: zone 8 at (1256, 4280) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1256, 4280) facing 1 (id 7)
  0.10  RESERVE: zone 9 at (1256, 4232) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1256, 4232) facing 1 (id 8)
  0.10  RESERVE: zone 10 at (1256, 4184) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1256, 4184) facing 1 (id 9)
  0.10  RESERVE: zone 11 at (1256, 4136) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1256, 4136) facing 1 (id 10)
  0.10  RESERVE: zone 12 at (1256, 4088) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1256, 4088) facing 1 (id 11)
  0.10  RESERVE: zone 13 at (1304, 4280) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1304, 4280) facing 1 (id 12)
  0.10  RESERVE: zone 14 at (1304, 4232) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1304, 4232) facing 1 (id 13)
  0.10  RESERVE: zone 15 at (1304, 4184) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1304, 4184) facing 1 (id 14)
  0.10  RESERVE: zone 16 at (1304, 4136) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1304, 4136) facing 1 (id 15)
  0.10  RESERVE: zone 17 at (1304, 4088) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1304, 4088) facing 1 (id 16)
  0.10  RESERVE: zone 18 at (1352, 4280) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 4280) facing 1 (id 17)
  0.10  RESERVE: zone 19 at (1352, 4232) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 4232) facing 1 (id 18)
  0.10  RESERVE: zone 20 at (1352, 4184) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 4184) facing 1 (id 19)
  0.10  RESERVE: zone 21 at (1352, 4136) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 4136) facing 1 (id 20)
  0.10  RESERVE: zone 22 at (1352, 4088) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 4088) facing 1 (id 21)
  0.10  RESERVE: zone 23 at (640, 4000) facing 1, 40x40 cells: 1600 of 1600 held
  0.10  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (736, 4000) facing 1: 16 of 16 slots (group 1, held, zone)
  0.10  RESERVE: armuwfus at (512, 3984) facing 1 (id 38)
  0.10  RESERVE: packed armuwfus at (512, 3984) facing 1 in zone 23, 313 from a turret (id 38, group 0, 1040 candidates)
  0.10  RESERVE: zone 1 at (704, 4608) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: corsy at (704, 4608) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (992, 4608) facing 1, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (488, 4888) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (488, 4888) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (488, 4840) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (488, 4840) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (488, 4792) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (488, 4792) facing 1 (id 4)
  0.10  RESERVE: zone 6 at (488, 4744) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (488, 4744) facing 1 (id 5)
  0.10  RESERVE: zone 7 at (488, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (488, 4696) facing 1 (id 6)
  0.10  RESERVE: zone 8 at (536, 4888) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (536, 4888) facing 1 (id 7)
  0.10  RESERVE: zone 9 at (536, 4840) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (536, 4840) facing 1 (id 8)
  0.10  RESERVE: zone 10 at (536, 4792) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (536, 4792) facing 1 (id 9)
  0.10  RESERVE: zone 11 at (536, 4744) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (536, 4744) facing 1 (id 10)
  0.10  RESERVE: zone 12 at (536, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (536, 4696) facing 1 (id 11)
  0.10  RESERVE: zone 13 at (584, 4888) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (584, 4888) facing 1 (id 12)
  0.10  RESERVE: zone 14 at (584, 4840) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (584, 4840) facing 1 (id 13)
  0.10  RESERVE: zone 15 at (584, 4792) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (584, 4792) facing 1 (id 14)
  0.10  RESERVE: zone 16 at (584, 4744) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (584, 4744) facing 1 (id 15)
  0.10  RESERVE: zone 17 at (584, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (584, 4696) facing 1 (id 16)
  0.10  RESERVE: zone 18 at (632, 4888) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (632, 4888) facing 1 (id 17)
  0.10  RESERVE: zone 19 at (632, 4840) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (632, 4840) facing 1 (id 18)
  0.10  RESERVE: zone 20 at (632, 4792) facing 1, 3x3 cells: 9 of 9 held
```
