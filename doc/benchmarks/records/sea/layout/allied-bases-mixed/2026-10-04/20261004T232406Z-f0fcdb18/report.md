# Playtest report: PASS

- Verdict: **PASS** (reached 6 min)
- Game time reached: 6.3 min (frame 11252); wall 76 s
- DLL: build-theatres\d197-build\SkirmishAI.dll (585949b1f419e865); AI BARbTest/test; staged 2026-10-04T20:22:45
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test, 4=AIR/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: allied-bases-mixed.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\allied-bases-mixed\supreme\20261004T232245Z-f84eec02\runs\20261004T232406Z-f0fcdb18\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `AIR-TECH-factory` | seen at 1.5 min | `[BaseProbe] PASS AIR->TECH factory excluded` |
| expect `AIR-TECH-economy` | seen at 1.5 min | `[BaseProbe] PASS AIR->TECH economy excluded` |
| expect `AIR-SEA-factory` | seen at 1.5 min | `[BaseProbe] PASS AIR->SEA factory excluded` |
| expect `AIR-SEA-economy` | seen at 1.5 min | `[BaseProbe] PASS AIR->SEA economy excluded` |
| expect `TECH-AIR-factory` | seen at 1.5 min | `[BaseProbe] PASS TECH->AIR factory excluded` |
| expect `TECH-AIR-economy` | seen at 1.5 min | `[BaseProbe] PASS TECH->AIR economy excluded` |
| expect `TECH-SEA-factory` | seen at 1.5 min | `[BaseProbe] PASS TECH->SEA factory excluded` |
| expect `TECH-SEA-economy` | seen at 1.5 min | `[BaseProbe] PASS TECH->SEA economy excluded` |
| expect `SEA-AIR-factory` | seen at 1.5 min | `[BaseProbe] PASS SEA->AIR factory excluded` |
| expect `SEA-AIR-economy` | seen at 1.5 min | `[BaseProbe] PASS SEA->AIR economy excluded` |
| expect `SEA-TECH-factory` | seen at 1.5 min | `[BaseProbe] PASS SEA->TECH factory excluded` |
| expect `SEA-TECH-economy` | seen at 1.5 min | `[BaseProbe] PASS SEA->TECH economy excluded` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `probe` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\allied-bases-mixed\supreme\20261004T232245Z-f84eec02\runs\20261004T232406Z-f0fcdb18\screen_2026-10-04_23-23-50-858.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\allied-bases-mixed\supreme\20261004T232245Z-f84eec02\runs\20261004T232406Z-f0fcdb18\screen_2026-10-04_23-24-03-118.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 2 shots, end at 6.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.00  [Playtest] frame 1 team 2 ally 0 side cortex ai true dead false start (2155, 11747) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 4 ally 1 side armada ai true dead false start (10129, 541) units 1
  0.00  [Playtest] frame 1 team 5 ally 1 side cortex ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 6 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 7 ally 3 side  ai false dead false start (0, 0) units 38
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (2155, 11747) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (11456, 1901) units 1
  0.05  [Playtest] frame 90 team 4 ally 1 side armada ai true dead false start (10129, 541) units 1
  0.05  [Playtest] frame 90 team 5 ally 1 side cortex ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 6 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 7 ally 3 side  ai false dead false start (0, 0) units 38
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|4773|11078|0|7|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(813,10379) factory=armlab landLocked=no spot=1 known=1/2
  0.10  [Team][Roster] Team 2 (AI 2): role=AIR side=cortex start=(2182,11798) factory=corap landLocked=no spot=2 known=2/2
  0.20  [Playtest] finished armmex team 0 at 0.20 min
  0.22  [Team][Roster] first mex 30427 at 4608,11072
  0.22  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4773|11078|0|7|1|4608|11072
  0.28  [Team][Roster] team 2 first mex at 2287,11967
  0.30  [Team][Roster] team 1 first mex at 752,10160
  0.31  [Playtest] finished armwin team 0 at 0.31 min
  0.52  [Playtest] finished armmex team 0 at 0.52 min
  0.62  [Playtest] finished armwin team 0 at 0.62 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 1095/1100, energy +67.9 bank 1001/1001, units 5
  1.35  [Playtest] finished armsy team 0 at 1.35 min
  1.40  [SEA][Layout] berth sea.berth.0 armasy at=6032,10048 facing=2
  1.53  [SEA][Layout] berth sea.berth.1 armasy at=6320,9968 facing=2
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.6 bank 585/1200, energy +61.6 bank 61/1201, units 9
  2.38  [Playtest] finished armtide team 0 at 2.38 min
  2.78  [Playtest] finished armtide team 0 at 2.78 min
  2.98  [Playtest] finished armtide team 0 at 2.98 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.6 bank 220/1200, energy +110.8 bank 84/1351, units 14
  3.00  [Playtest] target team 0 at (4814, 11077) from its start position
  3.00  [Playtest] camera requested (4814,11077) height=2200
  3.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  3.01  [Playtest] screenshot at 3.0 min of team 0 at (4814, 11077)
  3.22  [Playtest] finished armtide team 0 at 3.22 min
  3.44  [Playtest] finished armmex team 0 at 3.44 min
  3.57  [Playtest] finished armtide team 0 at 3.57 min
  3.86  [Playtest] finished armmex team 0 at 3.86 min
  3.93  [Playtest] finished armtide team 0 at 3.93 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.9 bank 13/1300, energy +176.2 bank 1496/1501, units 22
  4.13  [Playtest] finished armmex team 0 at 4.13 min
  4.33  [Playtest] finished armtide team 0 at 4.33 min
  4.45  [Playtest] finished armmex team 0 at 4.45 min
  4.65  [Playtest] finished armtide team 0 at 4.65 min
  4.85  [Playtest] finished armmex team 0 at 4.85 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +17.3 bank 17/1450, energy +232.3 bank 1587/1601, units 29
  5.15  [Playtest] finished armtide team 0 at 5.15 min
  5.27  [Playtest] finished armmex team 0 at 5.27 min
  5.59  [Playtest] finished armmex team 0 at 5.59 min
  5.64  [Playtest] finished armtide team 0 at 5.64 min
  5.80  [Playtest] camera requested (4814,11077) height=2200
  5.81  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  5.81  [Playtest] screenshot at 5.8 min of team 0 at (4814, 11077)
  5.86  [Playtest] finished armmex team 0 at 5.86 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +24.2 bank 152/1600, energy +282.4 bank 1674/1701, units 36
  6.03  [Playtest] finished armllt team 0 at 6.03 min
  6.13  [Playtest] finished armrad team 0 at 6.13 min
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 2
  0.08  RESERVE: zone 7 at (1619, 10568) facing 2, 77x63 cells: 4619 of 4851 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1619, 10072) facing 2: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1619, 10120) facing 2: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1619, 10168) facing 2: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1619, 10216) facing 2: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (1384, 9992) facing 2 (id 63)
  0.08  RESERVE: zone 8 at (1299, 9720) facing 2, 41x29 cells: 1163 of 1189 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1299, 9496) facing 2: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1299, 9544) facing 2: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1299, 9592) facing 2: 8 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1299, 9640) facing 2: 8 of 13 slots (group 6, held, zone)
  0.08  RESERVE: armlab at (1376, 8656) facing 2 (id 106)
  0.08  RESERVE: zone 9 at (1376, 8728) facing 2, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (1376, 8704) facing 2: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: armlab at (1472, 8368) facing 2 (id 109)
  0.08  RESERVE: zone 10 at (1472, 8440) facing 2, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (1472, 8416) facing 2: 2 of 2 slots (group 8, zone)
  0.08  RESERVE: corridor 11 at (1568, 8392) facing 2, 6x21 cells: 126 of 126 held
  0.08  RESERVE: corridor 12 at (1376, 8392) facing 2, 6x21 cells: 126 of 126 held
  0.08  RESERVE: zone 13 at (1472, 8392) facing 0, 6x9 cells: 0 of 54 held
  0.08  RESERVE: corridor 13 at (1472, 8144) facing 2, 10x20 cells: 180 of 200 held
  0.08  EXP: approach: armcom(26301) at (814, 10379) walks to (789, 10291), 136 from the armmex site (752, 10160)
  0.09  EXP: approach: corcom(30338) at (2182, 11799) walks to (2214, 11850), 139 from the cormex site (2288, 11968)
  0.09  RESERVE: factory pair 'tech.factory.start' committed atomically facing 0
  0.09  RESERVE: zone 7 at (10765, 1720) facing 0, 77x63 cells: 4540 of 4851 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (10765, 2216) facing 0: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (10765, 2168) facing 0: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (10765, 2120) facing 0: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (10765, 2072) facing 0: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: legalab at (11000, 2296) facing 0 (id 63)
  0.09  RESERVE: zone 8 at (11085, 2568) facing 0, 41x29 cells: 1106 of 1189 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (11085, 2792) facing 0: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (11085, 2744) facing 0: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (11085, 2696) facing 0: 8 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (11085, 2648) facing 0: 8 of 13 slots (group 6, held, zone)
  0.09  RESERVE: leglab at (10912, 3632) facing 0 (id 106)
  0.09  RESERVE: zone 9 at (10912, 3560) facing 0, 6x3 cells: 18 of 18 held
  0.09  RESERVE: grid of legnanotc 2x1 gap 0 behind (10912, 3584) facing 0: 2 of 2 slots (group 7, zone)
  0.09  RESERVE: leglab at (10784, 3584) facing 0 (id 109)
  0.09  RESERVE: zone 10 at (10784, 3512) facing 0, 6x3 cells: 18 of 18 held
  0.09  RESERVE: grid of legnanotc 2x1 gap 0 behind (10784, 3536) facing 0: 2 of 2 slots (group 8, zone)
  0.09  RESERVE: leglab at (11024, 3664) facing 0 (id 112)
  0.09  RESERVE: zone 11 at (11024, 3592) facing 0, 6x3 cells: 18 of 18 held
  0.09  RESERVE: grid of legnanotc 2x1 gap 0 behind (11024, 3616) facing 0: 2 of 2 slots (group 9, zone)
  0.09  RESERVE: leglab at (11152, 3696) facing 0 (id 115)
  0.09  RESERVE: zone 12 at (11152, 3624) facing 0, 6x3 cells: 18 of 18 held
  0.09  RESERVE: grid of legnanotc 2x1 gap 0 behind (11152, 3648) facing 0: 2 of 2 slots (group 10, zone)
  0.09  RESERVE: leglab at (10816, 3920) facing 0 (id 118)
  0.09  RESERVE: zone 13 at (10816, 3848) facing 0, 6x3 cells: 18 of 18 held
  0.09  RESERVE: grid of legnanotc 2x1 gap 0 behind (10816, 3872) facing 0: 2 of 2 slots (group 11, zone)
  0.09  RESERVE: corridor 14 at (10912, 3896) facing 0, 6x21 cells: 126 of 126 held
  0.09  RESERVE: zone 15 at (10816, 3896) facing 0, 6x9 cells: 0 of 54 held
  0.09  RESERVE: corridor 15 at (10816, 4144) facing 0, 10x20 cells: 190 of 200 held
  0.09  EXP: approach: legcom(20507) at (11480, 1954) walks to (11504, 2016), 137 from the legmex site (11552, 2144)
  0.09  EXP: approach: armcom(14522) at (10103, 514) walks to (10076, 458), 136 from the armmex site (10016, 336)
  0.17  RESERVE: armlab at (1712, 8432) facing 2 (id 112)
  0.17  RESERVE: zone 14 at (1712, 8504) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (1712, 8480) facing 2: 2 of 2 slots (group 9, zone)
  0.17  RESERVE: corridor 15 at (1808, 8456) facing 2, 6x21 cells: 126 of 126 held
  0.17  RESERVE: zone 16 at (1712, 8456) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 16 at (1712, 8208) facing 2, 10x20 cells: 190 of 200 held
  0.17  RESERVE: leglab at (10576, 3856) facing 0 (id 121)
  0.17  RESERVE: zone 16 at (10576, 3784) facing 0, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (10576, 3808) facing 0: 2 of 2 slots (group 12, zone)
  0.17  RESERVE: corridor 17 at (10672, 3832) facing 0, 6x21 cells: 126 of 126 held
  0.17  RESERVE: zone 18 at (10576, 3832) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 18 at (10576, 4080) facing 0, 10x20 cells: 190 of 200 held
  0.25  RESERVE: armalab at (1224, 7976) facing 2 (id 115)
  0.25  RESERVE: zone 17 at (1224, 8096) facing 2, 7x6 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (1224, 8048) facing 2: 4 of 4 slots (group 10, zone)
  0.25  RESERVE: zone 18 at (1224, 8024) facing 0, 9x15 cells: 12 of 135 held
  0.25  RESERVE: corridor 19 at (1224, 7728) facing 2, 13x20 cells: 260 of 260 held
  0.25  RESERVE: zone 20 at (336, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (336, 9088) facing 0 (id 120)
  0.25  RESERVE: zone 21 at (368, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (368, 9088) facing 0 (id 121)
  0.25  RESERVE: zone 22 at (400, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (400, 9088) facing 0 (id 122)
  0.25  RESERVE: zone 23 at (432, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (432, 9088) facing 0 (id 123)
  0.25  RESERVE: zone 24 at (464, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (464, 9088) facing 0 (id 124)
  0.25  RESERVE: zone 25 at (496, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (496, 9088) facing 0 (id 125)
  0.25  RESERVE: zone 26 at (528, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (528, 9088) facing 0 (id 126)
  0.25  RESERVE: zone 27 at (560, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (560, 9088) facing 0 (id 127)
  0.25  RESERVE: zone 28 at (592, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (592, 9088) facing 0 (id 128)
  0.25  RESERVE: zone 29 at (624, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (624, 9088) facing 0 (id 129)
  0.25  RESERVE: zone 30 at (656, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (656, 9088) facing 0 (id 130)
  0.25  RESERVE: zone 31 at (976, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (976, 9088) facing 0 (id 131)
  0.25  RESERVE: zone 32 at (1008, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1008, 9088) facing 0 (id 132)
  0.25  RESERVE: zone 33 at (1040, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1040, 9088) facing 0 (id 133)
  0.25  RESERVE: zone 34 at (1072, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1072, 9088) facing 0 (id 134)
  0.25  RESERVE: zone 35 at (1104, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1104, 9088) facing 0 (id 135)
  0.25  RESERVE: zone 36 at (1136, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1136, 9088) facing 0 (id 136)
  0.25  RESERVE: zone 37 at (1168, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1168, 9088) facing 0 (id 137)
  0.25  RESERVE: zone 38 at (1200, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1200, 9088) facing 0 (id 138)
  0.25  RESERVE: zone 39 at (1232, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1232, 9088) facing 0 (id 139)
  0.25  RESERVE: zone 40 at (1264, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1264, 9088) facing 0 (id 140)
  0.25  RESERVE: zone 41 at (1296, 9088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (1296, 9088) facing 0 (id 141)
  0.25  RESERVE: zone 42 at (560, 9200) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armllt at (560, 9200) facing 0 (id 142)
  0.25  RESERVE: zone 43 at (1064, 9192) facing 0, 3x3 cells: 9 of 9 held
```
