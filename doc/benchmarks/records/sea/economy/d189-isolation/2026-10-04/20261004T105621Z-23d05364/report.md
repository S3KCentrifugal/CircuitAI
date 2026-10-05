# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 2.3 min (frame 4170); wall 65 s
- DLL: build-theatres\d189-build-6\SkirmishAI.dll (fa67b4da76d8a753); AI BARbTest/test; staged 2026-10-04T07:55:13
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=TECH/armada/test, 2=FRONT/cortex/test, 3=FRONT/legion/test, 4=FRONT/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=TACTICAL/armada/test, 8=FRONT/cortex/test, 9=TECH/legion/test, 10=FRONT/armada/test, 11=FRONT/cortex/test, 12=SEA/legion/test, 13=SEA/armada/test, 14=SEA/cortex/test, 15=TACTICAL/legion/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-isolation\glacial\20261004T105512Z-06ecaa7c\runs\20261004T105621Z-23d05364\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:34.657033][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.0 min | `[t=00:00:58.006196][f=0001837] [SeaWatch] finished frame=1837 id=29047 def=armsy builder=12850` |
| expect `first-ship-exit` | seen at 2.1 min | `[t=00:01:02.703687][f=0003840] [SeaWatch] egress id=23121 yard=29047 seconds=4.5 worker=false` |
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
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(490,1137) factory=armlab landLocked=no spot=0 known=1/7
  0.10  [Team][Roster] Team 2 (AI 2): role=FRONT side=cortex start=(1799,1401) factory=corvp landLocked=no spot=1 known=2/7
  0.10  [Team][Roster] Team 3 (AI 3): role=FRONT side=legion start=(430,2300) factory=leglab landLocked=no spot=2 known=3/7
  0.10  [Team][Roster] Team 4 (AI 4): role=FRONT side=armada start=(1800,2547) factory=armvp landLocked=no spot=3 known=4/7
  0.10  [Team][Roster] Team 5 (AI 5): role=SEA side=cortex start=(699,4601) factory=corsy landLocked=no spot=5 known=5/7
  0.10  [Team][Roster] Team 6 (AI 6): role=SEA side=legion start=(1900,5800) factory=legsy landLocked=no spot=6 known=6/7
  0.10  [Team][Roster] Team 7 (AI 7): role=TACTICAL side=armada start=(880,6847) factory=armhp landLocked=no spot=7 known=7/7
  0.15  [Playtest] finished armmex team 0 at 0.15 min
  0.17  [Team][Roster] first mex 7159 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.17  [Team][Roster] team 1 first mex at 496,1296
  0.17  [Team][Roster] team 2 first mex at 1952,1407
  0.17  [Team][Roster] team 3 first mex at 448,2416
  0.17  [Team][Roster] team 4 first mex at 1952,2576
  0.17  [Team][Roster] team 5 first mex at 704,4447
  0.17  [Team][Roster] team 6 first mex at 1904,5968
  0.17  [Team][Roster] team 7 first mex at 880,6720
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.43  [Playtest] finished armmex team 0 at 0.43 min
  0.57  [Playtest] finished armtide team 0 at 0.57 min
  0.71  [Playtest] finished armtide team 0 at 0.71 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 624/1150, energy +76.0 bank 1057/1100, units 7
  1.02  [Playtest] finished armsy team 0 at 1.02 min
  1.19  [Playtest] finished armmex team 0 at 1.19 min
  1.41  [Playtest] finished armtide team 0 at 1.41 min
  1.61  [Playtest] finished armtide team 0 at 1.61 min
  1.80  [Playtest] finished armtide team 0 at 1.80 min
  1.83  [Playtest] finished armtide team 0 at 1.83 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +10.0 bank 203/1300, energy +182.0 bank 1055/1500, units 16
  2.02  [Playtest] finished armtide team 0 at 2.03 min
  2.22  [Playtest] finished armtide team 0 at 2.22 min
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
  0.17  RESERVE: armlab at (1776, 960) facing 1 (id 117)
  0.17  RESERVE: zone 12 at (1704, 960) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (1728, 960) facing 1: 2 of 2 slots (group 8, zone)
  0.17  RESERVE: armlab at (1776, 832) facing 1 (id 120)
  0.17  RESERVE: zone 13 at (1704, 832) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (1728, 832) facing 1: 2 of 2 slots (group 9, zone)
  0.17  RESERVE: armlab at (1776, 704) facing 1 (id 123)
  0.17  RESERVE: zone 14 at (1704, 704) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (1728, 704) facing 1: 2 of 2 slots (group 10, zone)
  0.17  RESERVE: armlab at (2048, 816) facing 1 (id 126)
  0.17  RESERVE: zone 15 at (1976, 816) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (2000, 816) facing 1: 2 of 2 slots (group 11, zone)
  0.17  RESERVE: corridor 16 at (2024, 912) facing 1, 21x6 cells: 126 of 126 held
  0.17  RESERVE: zone 17 at (2024, 816) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 17 at (2272, 816) facing 1, 20x10 cells: 190 of 200 held
  0.17  RESERVE: leglab at (12560, 832) facing 3 (id 66)
  0.17  RESERVE: zone 12 at (12632, 832) facing 3, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (12608, 832) facing 3: 2 of 2 slots (group 7, zone)
  0.17  RESERVE: corridor 13 at (12584, 736) facing 3, 21x6 cells: 126 of 126 held
  0.17  RESERVE: zone 14 at (12584, 832) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 14 at (12336, 832) facing 3, 20x10 cells: 190 of 200 held
  0.25  RESERVE: armalab at (2072, 1608) facing 1 (id 129)
  0.25  RESERVE: zone 18 at (1952, 1608) facing 1, 6x7 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (2000, 1608) facing 1: 4 of 4 slots (group 12, zone)
  0.25  RESERVE: zone 19 at (2024, 1608) facing 0, 15x9 cells: 12 of 135 held
  0.25  RESERVE: corridor 20 at (2320, 1608) facing 1, 20x13 cells: 260 of 260 held
  0.26  RESERVE: legalab at (12520, 1784) facing 3 (id 69)
  0.26  RESERVE: zone 15 at (12640, 1784) facing 3, 6x7 cells: 42 of 42 held
  0.26  RESERVE: grid of legnanotc 2x2 gap 0 behind (12592, 1784) facing 3: 4 of 4 slots (group 8, zone)
  0.26  RESERVE: zone 16 at (12568, 1784) facing 0, 15x9 cells: 12 of 135 held
  0.26  RESERVE: corridor 17 at (12272, 1784) facing 3, 20x13 cells: 260 of 260 held
  0.29  EXP: approach: armcom(891) at (490, 1137) walks to (430, 868), 136 from the armmex site (512, 976)
  0.33  RESERVE: armalab at (2088, 1960) facing 1 (id 134)
  0.33  RESERVE: zone 21 at (1968, 1960) facing 1, 6x7 cells: 42 of 42 held
  0.33  RESERVE: grid of armnanotc 2x2 gap 0 behind (2016, 1960) facing 1: 4 of 4 slots (group 13, zone)
  0.33  RESERVE: zone 22 at (2040, 1960) facing 0, 15x9 cells: 12 of 135 held
  0.33  RESERVE: corridor 23 at (2336, 1960) facing 1, 20x13 cells: 260 of 260 held
  0.34  RESERVE: legalab at (12520, 2136) facing 3 (id 74)
  0.34  RESERVE: zone 18 at (12640, 2136) facing 3, 6x7 cells: 42 of 42 held
  0.34  RESERVE: grid of legnanotc 2x2 gap 0 behind (12592, 2136) facing 3: 4 of 4 slots (group 9, zone)
  0.34  RESERVE: zone 19 at (12568, 2136) facing 0, 15x9 cells: 12 of 135 held
  0.34  RESERVE: corridor 20 at (12272, 2136) facing 3, 20x13 cells: 260 of 260 held
  0.41  RESERVE: served armlab at (672, 1056) facing 1 (id 1, 2 of this def still held)
  0.42  RESERVE: armshltx at (2368, 2608) facing 1 (id 139)
  0.42  RESERVE: zone 24 at (2152, 2608) facing 1, 15x30 cells: 450 of 450 held
  0.42  RESERVE: grid of armnanotc 10x5 gap 0 behind (2272, 2608) facing 1: 50 of 50 slots (group 14, zone)
  0.42  RESERVE: zone 25 at (2248, 2608) facing 0, 27x30 cells: 216 of 810 held
  0.42  RESERVE: corridor 26 at (2640, 2608) facing 1, 20x16 cells: 320 of 320 held
  0.42  RESERVE: leggant at (11968, 2608) facing 3 (id 79)
  0.42  RESERVE: zone 21 at (12184, 2608) facing 3, 15x30 cells: 450 of 450 held
  0.42  RESERVE: grid of legnanotc 10x5 gap 0 behind (12064, 2608) facing 3: 50 of 50 slots (group 10, zone)
  0.42  RESERVE: zone 22 at (12088, 2608) facing 0, 27x30 cells: 216 of 810 held
  0.42  RESERVE: corridor 23 at (11696, 2608) facing 3, 20x16 cells: 320 of 320 held
  0.50  RESERVE: armshltx at (3472, 3072) facing 1 (id 190)
  0.50  RESERVE: zone 27 at (3256, 3072) facing 1, 15x30 cells: 450 of 450 held
  0.50  RESERVE: grid of armnanotc 10x5 gap 0 behind (3376, 3072) facing 1: 50 of 50 slots (group 15, zone)
  0.50  RESERVE: zone 28 at (3352, 3072) facing 0, 27x30 cells: 216 of 810 held
  0.50  RESERVE: corridor 29 at (3744, 3072) facing 1, 20x16 cells: 320 of 320 held
  0.51  RESERVE: leggant at (11408, 3104) facing 3 (id 130)
  0.51  RESERVE: zone 24 at (11624, 3104) facing 3, 15x30 cells: 450 of 450 held
  0.51  RESERVE: grid of legnanotc 10x5 gap 0 behind (11504, 3104) facing 3: 50 of 50 slots (group 11, zone)
  0.51  RESERVE: zone 25 at (11528, 3104) facing 0, 27x30 cells: 216 of 810 held
  0.51  RESERVE: corridor 26 at (11136, 3104) facing 3, 20x16 cells: 320 of 320 held
  0.57  RESERVE: served leglab at (14160, 960) facing 2 (id 1, 2 of this def still held)
  0.85  RESERVE: corridor 30 at (880, 1056) facing 1, 20x10 cells: 0 of 200 held
  0.86  RESERVE: armwin at (712, 1224) facing 1 (id 241)
  0.86  RESERVE: packed armwin at (712, 1224) facing 1 in zone 7, 304 from a turret (id 241, group 0, 1569 candidates)
  0.86  EXP: swap: armcom(891) from task type 5 to task type 5
  0.86  RESERVE: served armwin at (712, 1224) facing 1 (id 241, 0 of this def still held)
  0.87  RESERVE: corridor 30 at (880, 1056) facing 1, 20x10 cells: 0 of 200 held
  0.88  RESERVE: corridor 30 at (880, 1056) facing 1, 20x10 cells: 0 of 200 held
  0.90  RESERVE: corridor 30 at (880, 1056) facing 1, 20x10 cells: 0 of 200 held
  0.92  RESERVE: corridor 30 at (880, 1056) facing 1, 20x10 cells: 0 of 200 held
  0.93  RESERVE: corridor 30 at (880, 1056) facing 1, 20x10 cells: 0 of 200 held
  0.95  RESERVE: corridor 30 at (880, 1056) facing 1, 20x10 cells: 0 of 200 held
  0.97  RESERVE: corridor 30 at (880, 1056) facing 1, 20x10 cells: 0 of 200 held
  0.97  RESERVE: corridor 27 at (14157, 750) facing 2, 11x21 cells: 10 of 231 held
  0.98  RESERVE: legwin at (13848, 904) facing 2 (id 181)
  0.98  RESERVE: packed legwin at (13848, 904) facing 2 in zone 7, 304 from a turret (id 181, group 0, 1167 candidates)
  0.98  EXP: approach: legcom(24526) at (13999, 1070) walks to (13855, 756), 148 from the legwin site (13848, 904)
  0.98  RESERVE: served legwin at (13848, 904) facing 2 (id 181, 0 of this def still held)
  0.98  RESERVE: corridor 30 at (880, 1056) facing 1, 20x10 cells: 0 of 200 held
  1.00  RESERVE: corridor 30 at (880, 1056) facing 1, 20x10 cells: 0 of 200 held
  1.02  RESERVE: corridor 30 at (880, 1056) facing 1, 20x10 cells: 0 of 200 held
  1.02  RESERVE: armwin at (712, 1272) facing 1 (id 242)
  1.02  RESERVE: packed armwin at (712, 1272) facing 1 in zone 7, 304 from a turret (id 242, group 0, 1554 candidates)
  1.02  RESERVE: served armwin at (712, 1272) facing 1 (id 242, 0 of this def still held)
```
