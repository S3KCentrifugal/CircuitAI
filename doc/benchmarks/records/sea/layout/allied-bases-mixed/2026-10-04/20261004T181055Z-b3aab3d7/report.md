# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 6.0 min (frame 10806); wall 76 s
- DLL: build-theatres\d192-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T15:09:35
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=TECH/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=TECH/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: allied-bases-mixed.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\allied-bases-mixed\glacial\20261004T180935Z-e67350bc\runs\20261004T181055Z-b3aab3d7\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `AIR-TECH-factory` | **missing** (by 6 min) | |
| expect `AIR-TECH-economy` | **missing** (by 6 min) | |
| expect `AIR-SEA-factory` | **missing** (by 6 min) | |
| expect `AIR-SEA-economy` | **missing** (by 6 min) | |
| expect `TECH-AIR-factory` | **missing** (by 6 min) | |
| expect `TECH-AIR-economy` | **missing** (by 6 min) | |
| expect `TECH-SEA-factory` | seen at 1.5 min | `[BaseProbe] PASS TECH->SEA factory excluded` |
| expect `TECH-SEA-economy` | seen at 1.5 min | `[BaseProbe] PASS TECH->SEA economy excluded` |
| expect `SEA-AIR-factory` | **missing** (by 6 min) | |
| expect `SEA-AIR-economy` | **missing** (by 6 min) | |
| expect `SEA-TECH-factory` | seen at 1.5 min | `[BaseProbe] PASS SEA->TECH factory excluded` |
| expect `SEA-TECH-economy` | **missing** (by 6 min) | |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s` |
| forbid `probe` | clean |  |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 2.1 min: [INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s
- 'AIR-TECH-factory' not seen by 6.0 min
- 'AIR-TECH-economy' not seen by 6.0 min
- 'AIR-SEA-factory' not seen by 6.0 min
- 'AIR-SEA-economy' not seen by 6.0 min
- 'TECH-AIR-factory' not seen by 6.0 min
- 'TECH-AIR-economy' not seen by 6.0 min
- 'SEA-AIR-factory' not seen by 6.0 min
- 'SEA-AIR-economy' not seen by 6.0 min
- 'SEA-TECH-economy' not seen by 6.0 min

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\allied-bases-mixed\glacial\20261004T180935Z-e67350bc\runs\20261004T181055Z-b3aab3d7\screen_2026-10-04_18-10-38-631.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\allied-bases-mixed\glacial\20261004T180935Z-e67350bc\runs\20261004T181055Z-b3aab3d7\screen_2026-10-04_18-10-54-909.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 6.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (1430, 4000) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (490, 1140) units 1
  0.00  [Playtest] frame 1 team 2 ally 0 side cortex ai true dead false start (700, 4600) units 1
  0.00  [Playtest] frame 1 team 3 ally 0 side legion ai true dead false start (1900, 5800) units 1
  0.00  [Playtest] frame 1 team 4 ally 1 side armada ai true dead false start (14000, 1100) units 1
  0.00  [Playtest] frame 1 team 5 ally 1 side cortex ai true dead false start (12925, 4000) units 1
  0.00  [Playtest] frame 1 team 6 ally 1 side legion ai true dead false start (13700, 4600) units 1
  0.00  [Playtest] frame 1 team 7 ally 1 side armada ai true dead false start (12618, 5800) units 1
  0.00  [Playtest] frame 1 team 8 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 9 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (1430, 4000) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (490, 1140) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (700, 4600) units 1
  0.05  [Playtest] frame 90 team 3 ally 0 side legion ai true dead false start (1900, 5800) units 1
  0.05  [Playtest] frame 90 team 4 ally 1 side armada ai true dead false start (14000, 1100) units 1
  0.05  [Playtest] frame 90 team 5 ally 1 side cortex ai true dead false start (12925, 4000) units 1
  0.05  [Playtest] frame 90 team 6 ally 1 side legion ai true dead false start (13700, 4600) units 1
  0.05  [Playtest] frame 90 team 7 ally 1 side armada ai true dead false start (12618, 5800) units 1
  0.05  [Playtest] frame 90 team 8 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 9 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(490,1137) factory=armlab landLocked=no spot=0 known=1/3
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(699,4601) factory=corsy landLocked=no spot=5 known=2/3
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(1900,5800) factory=legsy landLocked=no spot=6 known=3/3
  0.15  [Team][Roster] team 1 first mex at 496,1296
  0.15  [Playtest] finished armmex team 0 at 0.15 min
  0.17  [Team][Roster] first mex 352 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.17  [Team][Roster] team 2 first mex at 704,4447
  0.17  [Team][Roster] team 3 first mex at 1904,5968
  0.29  [Playtest] finished armmex team 0 at 0.29 min
  0.44  [Playtest] finished armmex team 0 at 0.44 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 1130/1150, energy +30.0 bank 772/1000, units 5
  1.09  [Playtest] finished armtide team 0 at 1.09 min
  1.25  [Playtest] finished armtide team 0 at 1.25 min
  1.53  [SEA][Layout] berth sea.berth.0 armasy at=1600,4064 facing=1
  1.55  [Playtest] finished armsy team 0 at 1.55 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 677/1250, energy +83.0 bank 158/1250, units 11
  2.03  [Playtest] finished armtide team 0 at 2.03 min
  2.55  [Playtest] finished armtide team 0 at 2.55 min
  2.85  [Playtest] finished armtide team 0 at 2.86 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 199/1250, energy +159.0 bank 1384/1450, units 17
  3.00  [Playtest] camera requested (1500,4600) height=3500
  3.02  [Playtest] camera captured name=ta position=(1500,4600) height=3500
  3.02  [Playtest] screenshot at 3.0 min of team 0 at (1500, 4600)
  3.13  [Playtest] finished armtide team 0 at 3.13 min
  3.58  [Playtest] finished armmex team 0 at 3.58 min
  3.61  [Playtest] finished armtide team 0 at 3.61 min
  3.99  [Playtest] finished armtide team 0 at 3.99 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 13/1300, energy +205.0 bank 1597/1600, units 22
  4.32  [Playtest] finished armtide team 0 at 4.32 min
  4.42  [Playtest] finished armmex team 0 at 4.42 min
  4.63  [Playtest] finished armmex team 0 at 4.63 min
  4.87  [Playtest] finished armmex team 0 at 4.87 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +16.0 bank 40/1450, energy +251.0 bank 1629/1650, units 23
  5.08  [Playtest] finished armmex team 0 at 5.07 min
  5.74  [Playtest] finished armmex team 0 at 5.74 min
  5.93  [Playtest] finished armmex team 0 at 5.93 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +22.0 bank 278/1600, energy +251.0 bank 1624/1650, units 26
  6.00  [Playtest] camera requested (1500,4600) height=3500
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
  0.08  RESERVE: armlab at (1776, 1360) facing 1 (id 114)
  0.08  RESERVE: zone 9 at (1704, 1360) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (1728, 1360) facing 1: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: armlab at (1792, 1104) facing 1 (id 117)
  0.08  RESERVE: zone 10 at (1720, 1104) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (1744, 1104) facing 1: 2 of 2 slots (group 8, zone)
  0.08  RESERVE: corridor 11 at (1768, 1200) facing 1, 21x6 cells: 118 of 126 held
  0.08  RESERVE: zone 12 at (1768, 1104) facing 0, 9x6 cells: 0 of 54 held
  0.08  RESERVE: corridor 12 at (2016, 1104) facing 1, 20x10 cells: 190 of 200 held
  0.09  RESERVE: factory pair 'tech.factory.start' committed atomically facing 2
  0.09  RESERVE: zone 7 at (13509, 1272) facing 2, 77x63 cells: 4538 of 4851 held
  0.09  RESERVE: grid of armnanotc 13x1 gap 0 behind (13509, 776) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of armnanotc 13x1 gap 0 behind (13509, 824) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of armnanotc 13x1 gap 0 behind (13509, 872) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of armnanotc 13x1 gap 0 behind (13509, 920) facing 2: 12 of 13 slots (group 5, held, zone)
  0.09  RESERVE: armalab at (13496, 1096) facing 3 (id 62)
  0.09  RESERVE: packed armalab at (13496, 1096) facing 3 in zone 7 where 8 slots of group 5 reach (id 62)
  0.09  RESERVE: armlab at (12544, 1104) facing 3 (id 63)
  0.09  RESERVE: zone 8 at (12616, 1104) facing 3, 3x6 cells: 18 of 18 held
  0.09  RESERVE: grid of armnanotc 2x1 gap 0 behind (12592, 1104) facing 3: 2 of 2 slots (group 6, zone)
  0.09  RESERVE: corridor 9 at (12568, 1008) facing 3, 21x6 cells: 126 of 126 held
  0.09  RESERVE: corridor 10 at (12568, 1200) facing 3, 21x6 cells: 118 of 126 held
  0.09  RESERVE: zone 11 at (12568, 1104) facing 0, 9x6 cells: 0 of 54 held
  0.09  RESERVE: corridor 11 at (12320, 1104) facing 3, 20x10 cells: 180 of 200 held
  0.17  RESERVE: armlab at (976, 704) facing 2 (id 120)
  0.17  RESERVE: zone 13 at (976, 776) facing 2, 6x3 cells: 6 of 18 held
  0.17  RESERVE: armlab at (1088, 656) facing 2 (id 121)
  0.17  RESERVE: zone 14 at (1088, 728) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (1088, 704) facing 2: 2 of 2 slots (group 10, zone)
  0.17  RESERVE: armlab at (480, 832) facing 2 (id 124)
  0.17  RESERVE: zone 15 at (480, 904) facing 2, 6x3 cells: 6 of 18 held
  0.17  RESERVE: armlab at (720, 736) facing 2 (id 125)
  0.17  RESERVE: zone 16 at (720, 808) facing 2, 6x3 cells: 6 of 18 held
  0.17  RESERVE: armlab at (832, 704) facing 2 (id 126)
  0.17  RESERVE: zone 17 at (832, 776) facing 2, 6x3 cells: 6 of 18 held
  0.17  RESERVE: armlab at (960, 656) facing 2 (id 127)
  0.17  RESERVE: zone 18 at (960, 728) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (960, 704) facing 2: 2 of 2 slots (group 14, zone)
  0.17  RESERVE: armlab at (464, 784) facing 2 (id 130)
  0.17  RESERVE: zone 19 at (464, 856) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (464, 832) facing 2: 2 of 2 slots (group 15, zone)
  0.17  RESERVE: armlab at (576, 736) facing 2 (id 133)
  0.17  RESERVE: zone 20 at (576, 808) facing 2, 6x3 cells: 6 of 18 held
  0.17  RESERVE: armlab at (704, 704) facing 2 (id 134)
  0.17  RESERVE: zone 21 at (704, 776) facing 2, 6x3 cells: 13 of 18 held
  0.17  RESERVE: armlab at (816, 656) facing 2 (id 135)
  0.17  RESERVE: zone 22 at (816, 728) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (816, 704) facing 2: 2 of 2 slots (group 18, zone)
  0.17  RESERVE: armlab at (800, 608) facing 2 (id 138)
  0.17  RESERVE: zone 23 at (800, 680) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (800, 656) facing 2: 2 of 2 slots (group 19, zone)
  0.17  RESERVE: armalab at (1192, 616) facing 2 (id 141)
  0.17  RESERVE: zone 24 at (1192, 736) facing 2, 7x6 cells: 42 of 42 held
  0.17  RESERVE: grid of armnanotc 2x2 gap 0 behind (1192, 688) facing 2: 4 of 4 slots (group 20, zone)
  0.17  RESERVE: zone 25 at (1192, 664) facing 0, 9x15 cells: 9 of 135 held
  0.17  RESERVE: corridor 26 at (1192, 368) facing 2, 13x20 cells: 260 of 260 held
  0.17  RESERVE: armlab at (12512, 848) facing 3 (id 66)
  0.17  RESERVE: zone 12 at (12584, 848) facing 3, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (12560, 848) facing 3: 2 of 2 slots (group 7, zone)
  0.17  RESERVE: corridor 13 at (12536, 752) facing 3, 21x6 cells: 126 of 126 held
  0.17  RESERVE: zone 14 at (12536, 848) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 14 at (12288, 848) facing 3, 20x10 cells: 190 of 200 held
  0.25  RESERVE: armalab at (1016, 632) facing 2 (id 146)
  0.25  RESERVE: zone 27 at (1016, 752) facing 2, 7x6 cells: 9 of 42 held
  0.25  RESERVE: armalab at (12568, 1400) facing 3 (id 69)
  0.25  RESERVE: zone 15 at (12688, 1400) facing 3, 6x7 cells: 30 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (12640, 1400) facing 3: 2 of 4 slots (group 8, zone)
  0.25  RESERVE: zone 15 released
  0.25  RESERVE: armalab at (12584, 1752) facing 3 (id 72)
  0.25  RESERVE: zone 16 at (12704, 1752) facing 3, 6x7 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (12656, 1752) facing 3: 4 of 4 slots (group 9, zone)
  0.25  RESERVE: zone 17 at (12632, 1752) facing 0, 15x9 cells: 12 of 135 held
  0.25  RESERVE: corridor 18 at (12336, 1752) facing 3, 20x13 cells: 260 of 260 held
  0.25  RESERVE: zone 19 at (12688, 1552) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (12688, 1552) facing 0 (id 77)
  0.25  RESERVE: zone 20 at (12688, 1520) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (12688, 1520) facing 0 (id 78)
  0.25  RESERVE: zone 21 at (12688, 1488) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (12688, 1488) facing 0 (id 79)
  0.25  RESERVE: zone 22 at (12688, 1456) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (12688, 1456) facing 0 (id 80)
  0.25  RESERVE: zone 23 at (12688, 1360) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (12688, 1360) facing 0 (id 81)
  0.25  RESERVE: zone 24 at (12688, 1328) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (12688, 1328) facing 0 (id 82)
  0.25  RESERVE: zone 25 at (12688, 1296) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (12688, 1296) facing 0 (id 83)
  0.25  RESERVE: zone 26 at (12688, 1264) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (12688, 1264) facing 0 (id 84)
  0.25  RESERVE: zone 27 at (12688, 912) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (12688, 912) facing 0 (id 85)
  0.25  RESERVE: zone 28 at (12688, 880) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (12688, 880) facing 0 (id 86)
  0.25  RESERVE: zone 29 at (12688, 848) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (12688, 848) facing 0 (id 87)
  0.25  RESERVE: zone 30 at (12688, 816) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (12688, 816) facing 0 (id 88)
  0.25  RESERVE: zone 31 at (12688, 688) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (12688, 688) facing 0 (id 89)
  0.25  RESERVE: zone 32 at (12688, 656) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (12688, 656) facing 0 (id 90)
  0.25  RESERVE: zone 33 at (12688, 624) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (12688, 624) facing 0 (id 91)
  0.25  RESERVE: zone 34 at (12688, 592) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (12688, 592) facing 0 (id 92)
  0.25  RESERVE: zone 35 at (12800, 1328) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armllt at (12800, 1328) facing 0 (id 93)
  0.25  RESERVE: zone 36 at (12808, 808) facing 0, 3x3 cells: 9 of 9 held
```
