# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 2.2 min (frame 3995); wall 62 s
- DLL: build-theatres\d188-build-6\SkirmishAI.dll (ac71826721992d84); AI BARbTest/test; staged 2026-10-04T01:51:54
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=TECH/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=TECH/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\mixed-legacy-control\glacial\20261004T045153Z-b96b3051\runs\20261004T045300Z-e05c8858\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:36.008867][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.9 min | `[t=00:00:54.705469][f=0001597] [SeaWatch] finished frame=1597 id=20734 def=armsy builder=24261` |
| expect `first-ship-exit` | seen at 2.1 min | `[t=00:00:59.590837][f=0003720] [SeaWatch] egress id=28140 yard=20734 seconds=4.6 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 2.1 min: [INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s

## Screenshots

- none

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 8.5 min
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
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(490,1137) factory=armlab landLocked=no spot=0 known=1/3
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(699,4601) factory=corsy landLocked=no spot=5 known=2/3
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(1900,5800) factory=legsy landLocked=no spot=6 known=3/3
  0.15  [Team][Roster] team 1 first mex at 496,1296
  0.16  [Playtest] finished armmex team 0 at 0.16 min
  0.17  [Team][Roster] first mex 16479 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.17  [Team][Roster] team 2 first mex at 704,4447
  0.17  [Team][Roster] team 3 first mex at 1904,5968
  0.29  [Playtest] finished armmex team 0 at 0.29 min
  0.44  [Playtest] finished armtide team 0 at 0.44 min
  0.58  [Playtest] finished armtide team 0 at 0.58 min
  0.89  [Playtest] finished armsy team 0 at 0.89 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 515/1200, energy +76.0 bank 898/1200, units 8
  1.08  [Playtest] finished armmex team 0 at 1.08 min
  1.21  [Playtest] finished armmex team 0 at 1.21 min
  1.39  [Playtest] finished armtide team 0 at 1.39 min
  1.53  [Playtest] finished armtide team 0 at 1.53 min
  1.72  [Playtest] finished armtide team 0 at 1.72 min
  1.84  [Playtest] finished armtide team 0 at 1.84 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +10.0 bank 69/1300, energy +182.0 bank 1028/1500, units 16
  2.03  [Playtest] finished armtide team 0 at 2.03 min
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
  0.17  RESERVE: armlab at (1824, 848) facing 1 (id 120)
  0.17  RESERVE: zone 13 at (1752, 848) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (1776, 848) facing 1: 2 of 2 slots (group 9, zone)
  0.17  RESERVE: corridor 14 at (1800, 944) facing 1, 21x6 cells: 126 of 126 held
  0.17  RESERVE: zone 15 at (1800, 848) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 15 at (2048, 848) facing 1, 20x10 cells: 190 of 200 held
  0.17  RESERVE: armlab at (12512, 848) facing 3 (id 66)
  0.17  RESERVE: zone 12 at (12584, 848) facing 3, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (12560, 848) facing 3: 2 of 2 slots (group 7, zone)
  0.17  RESERVE: corridor 13 at (12536, 752) facing 3, 21x6 cells: 126 of 126 held
  0.17  RESERVE: zone 14 at (12536, 848) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 14 at (12288, 848) facing 3, 20x10 cells: 190 of 200 held
  0.25  RESERVE: armalab at (1704, 2280) facing 1 (id 123)
  0.25  RESERVE: zone 16 at (1584, 2280) facing 1, 6x7 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (1632, 2280) facing 1: 4 of 4 slots (group 10, zone)
  0.25  RESERVE: zone 17 at (1656, 2280) facing 0, 15x9 cells: 12 of 135 held
  0.25  RESERVE: corridor 18 at (1952, 2280) facing 1, 20x13 cells: 258 of 260 held
  0.25  RESERVE: zone 19 at (1792, 656) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1792, 656) facing 0 (id 128)
  0.25  RESERVE: zone 20 at (1792, 688) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1792, 688) facing 0 (id 129)
  0.25  RESERVE: zone 21 at (1792, 720) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1792, 720) facing 0 (id 130)
  0.25  RESERVE: zone 22 at (1792, 752) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1792, 752) facing 0 (id 131)
  0.25  RESERVE: zone 23 at (1792, 784) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1792, 784) facing 0 (id 132)
  0.25  RESERVE: zone 24 at (1792, 1296) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1792, 1296) facing 0 (id 133)
  0.25  RESERVE: zone 25 at (1792, 1328) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1792, 1328) facing 0 (id 134)
  0.25  RESERVE: zone 26 at (1792, 1360) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1792, 1360) facing 0 (id 135)
  0.25  RESERVE: zone 27 at (1792, 1392) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1792, 1392) facing 0 (id 136)
  0.25  RESERVE: zone 28 at (1792, 1424) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1792, 1424) facing 0 (id 137)
  0.25  RESERVE: zone 29 at (1792, 1456) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1792, 1456) facing 0 (id 138)
  0.25  RESERVE: zone 30 at (1792, 1488) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1792, 1488) facing 0 (id 139)
  0.25  RESERVE: zone 31 at (1792, 1520) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1792, 1520) facing 0 (id 140)
  0.25  RESERVE: zone 32 at (1792, 1616) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1792, 1616) facing 0 (id 141)
  0.25  RESERVE: zone 33 at (1680, 880) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armllt at (1680, 880) facing 0 (id 142)
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
```
