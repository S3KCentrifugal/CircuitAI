# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54085); wall 183 s
- DLL: build-theatres\d188-build-1\SkirmishAI.dll (cb02a8cead57aabf); AI BARbTest/test; staged 2026-10-04T00:23:22
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\migration-first\glacial\20261004T032322Z-fc89f2d7\runs\20261004T032629Z-1f6bb628\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:43.959532][f=-000001] [SeaWatch] loaded` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\migration-first\glacial\20261004T032322Z-fc89f2d7\runs\20261004T032629Z-1f6bb628\screen_2026-10-04_03-24-45-006.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\migration-first\glacial\20261004T032322Z-fc89f2d7\runs\20261004T032629Z-1f6bb628\screen_2026-10-04_03-25-05-990.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\migration-first\glacial\20261004T032322Z-fc89f2d7\runs\20261004T032629Z-1f6bb628\screen_2026-10-04_03-25-46-980.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\migration-first\glacial\20261004T032322Z-fc89f2d7\runs\20261004T032629Z-1f6bb628\screen_2026-10-04_03-26-23-968.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (1430, 4000) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (700, 4600) units 1
  0.00  [Playtest] frame 1 team 2 ally 0 side cortex ai true dead false start (1900, 5800) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (12925, 4000) units 1
  0.00  [Playtest] frame 1 team 4 ally 1 side armada ai true dead false start (13700, 4600) units 1
  0.00  [Playtest] frame 1 team 5 ally 1 side cortex ai true dead false start (12618, 5800) units 1
  0.00  [Playtest] frame 1 team 6 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 7 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (1430, 4000) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (700, 4600) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (1900, 5800) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (12925, 4000) units 1
  0.05  [Playtest] frame 90 team 4 ally 1 side armada ai true dead false start (13700, 4600) units 1
  0.05  [Playtest] frame 90 team 5 ally 1 side cortex ai true dead false start (12618, 5800) units 1
  0.05  [Playtest] frame 90 team 6 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 7 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(700,4597) factory=armsy landLocked=no spot=5 known=1/2
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(1899,5801) factory=corsy landLocked=no spot=6 known=2/2
  0.15  [Team][Roster] team 1 first mex at 704,4448
  0.16  [Playtest] finished armmex team 0 at 0.16 min
  0.17  [Team][Roster] first mex 19544 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.18  [Team][Roster] team 2 first mex at 1904,5967
  0.29  [Playtest] finished armmex team 0 at 0.29 min
  0.56  [Playtest] finished armtide team 0 at 0.56 min
  0.69  [Playtest] finished armmex team 0 at 0.69 min
  0.83  [Playtest] finished armtide team 0 at 0.83 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 994/1150, energy +76.0 bank 1036/1100, units 7
  1.08  [Playtest] finished armmex team 0 at 1.08 min
  1.91  [Playtest] finished armmex team 0 at 1.91 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +12.0 bank 1250/1250, energy +76.0 bank 1097/1100, units 8
  2.12  [Playtest] finished armmex team 0 at 2.12 min
  2.33  [Playtest] finished armmex team 0 at 2.33 min
  2.50  [Playtest] finished armmex team 0 at 2.50 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +18.0 bank 1400/1400, energy +76.0 bank 1092/1100, units 11
  3.12  [Playtest] finished armmex team 0 at 3.12 min
  3.34  [Playtest] finished armmex team 0 at 3.34 min
  3.56  [Playtest] finished armmex team 0 at 3.56 min
  3.74  [Playtest] finished armmex team 0 at 3.74 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +26.0 bank 1600/1600, energy +76.0 bank 1086/1100, units 15
  5.00  [Playtest] eco team 0 at 5.0 min: metal +26.0 bank 1600/1600, energy +76.0 bank 1086/1100, units 15
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.00  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  6.00  [Playtest] eco team 0 at 6.0 min: metal +26.0 bank 1600/1600, energy +76.0 bank 1086/1100, units 15
  7.00  [Playtest] eco team 0 at 7.0 min: metal +26.0 bank 1600/1600, energy +76.0 bank 1086/1100, units 15
  8.00  [Playtest] eco team 0 at 8.0 min: metal +26.0 bank 1600/1600, energy +76.0 bank 1086/1100, units 15
  9.00  [Playtest] eco team 0 at 9.0 min: metal +26.0 bank 1600/1600, energy +76.0 bank 1086/1100, units 15
 10.00  [Playtest] eco team 0 at 10.0 min: metal +26.0 bank 1600/1600, energy +76.0 bank 1086/1100, units 15
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.00  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.00  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 11.00  [Playtest] eco team 0 at 11.0 min: metal +26.0 bank 1600/1600, energy +76.0 bank 1086/1100, units 15
 12.00  [Playtest] eco team 0 at 12.0 min: metal +26.0 bank 1600/1600, energy +76.0 bank 1086/1100, units 15
 13.00  [Playtest] eco team 0 at 13.0 min: metal +26.0 bank 1600/1600, energy +76.0 bank 1086/1100, units 15
 14.00  [Playtest] eco team 0 at 14.0 min: metal +26.0 bank 1600/1600, energy +76.0 bank 1086/1100, units 15
 15.00  [Playtest] eco team 0 at 15.0 min: metal +26.0 bank 1600/1600, energy +76.0 bank 1086/1100, units 15
 16.00  [Playtest] eco team 0 at 16.0 min: metal +26.0 bank 1600/1600, energy +76.0 bank 1086/1100, units 15
 17.00  [Playtest] eco team 0 at 17.0 min: metal +26.0 bank 1600/1600, energy +76.0 bank 1086/1100, units 15
 18.00  [Playtest] eco team 0 at 18.0 min: metal +26.0 bank 1600/1600, energy +76.0 bank 1086/1100, units 15
 19.00  [Playtest] eco team 0 at 19.0 min: metal +26.0 bank 1600/1600, energy +76.0 bank 1086/1100, units 15
 20.00  [Playtest] eco team 0 at 20.0 min: metal +26.0 bank 1600/1600, energy +76.0 bank 1086/1100, units 15
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.01  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
 21.00  [Playtest] eco team 0 at 21.0 min: metal +26.0 bank 1600/1600, energy +76.0 bank 1086/1100, units 15
 22.00  [Playtest] eco team 0 at 22.0 min: metal +26.0 bank 1600/1600, energy +76.0 bank 1086/1100, units 15
 23.00  [Playtest] eco team 0 at 23.0 min: metal +26.0 bank 1600/1600, energy +76.0 bank 1086/1100, units 15
 24.00  [Playtest] eco team 0 at 24.0 min: metal +26.0 bank 1600/1600, energy +76.0 bank 1086/1100, units 15
 25.00  [Playtest] eco team 0 at 25.0 min: metal +26.0 bank 1600/1600, energy +76.0 bank 1086/1100, units 15
 26.00  [Playtest] eco team 0 at 26.0 min: metal +26.0 bank 1600/1600, energy +76.0 bank 1086/1100, units 15
 27.00  [Playtest] eco team 0 at 27.0 min: metal +26.0 bank 1600/1600, energy +76.0 bank 1086/1100, units 15
 28.00  [Playtest] eco team 0 at 28.0 min: metal +26.0 bank 1600/1600, energy +76.0 bank 1086/1100, units 15
 29.00  [Playtest] eco team 0 at 29.0 min: metal +26.0 bank 1600/1600, energy +76.0 bank 1086/1100, units 15
 29.00  [Playtest] camera requested (1700,4550) height=4000
 29.00  [Playtest] camera captured name=ta position=(1700,4550) height=4000
 29.00  [Playtest] screenshot at 29.0 min of team 0 at (1700, 4550)
 30.00  [Playtest] eco team 0 at 30.0 min: metal +26.0 bank 1600/1600, energy +76.0 bank 1086/1100, units 15
```

## Native lines (all AIs, first 120)

```
  0.09  EXP: approach: corcom(1517) at (1899, 5801) walks to (1900, 5829), 139 from the cormex site (1904, 5968)
  0.10  EXP: idle: corcom(1517) on cormex at (1899, 5822), site (1904, 5968), target yes, fails 1 (arrived at the approach point)
  0.16  EXP: approach: armcom(4451) at (700, 4597) walks to (680, 4598), 136 from the armmex site (544, 4608)
  0.16  RESERVE: zone 1 at (14056, 4536) facing 3, 3x3 cells: 9 of 9 held
  0.16  RESERVE: armtide at (14056, 4536) facing 3 (id 1)
  0.16  RESERVE: zone 2 at (14056, 4600) facing 3, 3x3 cells: 9 of 9 held
  0.16  RESERVE: armtide at (14056, 4600) facing 3 (id 2)
  0.16  RESERVE: zone 3 at (14056, 4664) facing 3, 3x3 cells: 9 of 9 held
  0.16  RESERVE: armtide at (14056, 4664) facing 3 (id 3)
  0.16  RESERVE: zone 4 at (13992, 4536) facing 3, 3x3 cells: 9 of 9 held
  0.16  RESERVE: armtide at (13992, 4536) facing 3 (id 4)
  0.16  RESERVE: zone 5 at (13992, 4600) facing 3, 3x3 cells: 9 of 9 held
  0.16  RESERVE: armtide at (13992, 4600) facing 3 (id 5)
  0.16  RESERVE: zone 6 at (13992, 4664) facing 3, 3x3 cells: 9 of 9 held
  0.16  RESERVE: armtide at (13992, 4664) facing 3 (id 6)
  0.16  RESERVE: zone 7 at (14018, 4597) facing 3, 9x13 cells: 63 of 117 held
  0.16  RESERVE: served armtide at (14056, 4536) facing 3 (id 1, 5 of this def still held)
  0.17  RESERVE: zone 1 at (13272, 3944) facing 3, 3x3 cells: 9 of 9 held
  0.17  RESERVE: legtide at (13272, 3944) facing 3 (id 1)
  0.17  RESERVE: zone 2 at (13272, 4008) facing 3, 3x3 cells: 9 of 9 held
  0.17  RESERVE: legtide at (13272, 4008) facing 3 (id 2)
  0.17  RESERVE: zone 3 at (13272, 4072) facing 3, 3x3 cells: 9 of 9 held
  0.17  RESERVE: legtide at (13272, 4072) facing 3 (id 3)
  0.17  RESERVE: zone 4 at (13208, 3944) facing 3, 3x3 cells: 9 of 9 held
  0.17  RESERVE: legtide at (13208, 3944) facing 3 (id 4)
  0.17  RESERVE: zone 5 at (13208, 4008) facing 3, 3x3 cells: 9 of 9 held
  0.17  RESERVE: legtide at (13208, 4008) facing 3 (id 5)
  0.17  RESERVE: zone 6 at (13208, 4072) facing 3, 3x3 cells: 9 of 9 held
  0.17  RESERVE: legtide at (13208, 4072) facing 3 (id 6)
  0.17  RESERVE: zone 7 at (13243, 4000) facing 3, 9x12 cells: 54 of 108 held
  0.17  RESERVE: served legtide at (13272, 3944) facing 3 (id 1, 5 of this def still held)
  0.17  EXP: approach: armcom(18255) at (1430, 3997) walks to (1457, 3986), 136 from the armmex site (1584, 3936)
  0.18  EXP: approach: corcom(1517) at (1899, 5823) walks to (1882, 5821), 139 from the cormex site (1744, 5808)
  0.23  EXP: approach: corcom(23841) at (12677, 5763) walks to (12712, 5841), 139 from the cormex site (12768, 5968)
  0.29  RESERVE: zone 1 at (344, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (344, 4664) facing 1 (id 1)
  0.29  RESERVE: zone 2 at (344, 4600) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (344, 4600) facing 1 (id 2)
  0.29  RESERVE: zone 3 at (344, 4536) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (344, 4536) facing 1 (id 3)
  0.29  RESERVE: zone 4 at (408, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (408, 4664) facing 1 (id 4)
  0.29  RESERVE: zone 5 at (408, 4600) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (408, 4600) facing 1 (id 5)
  0.29  RESERVE: zone 6 at (408, 4536) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (408, 4536) facing 1 (id 6)
  0.29  RESERVE: zone 7 at (382, 4597) facing 1, 9x13 cells: 63 of 117 held
  0.29  RESERVE: served armtide at (344, 4664) facing 1 (id 1, 5 of this def still held)
  0.30  RESERVE: zone 1 at (1080, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.30  RESERVE: armtide at (1080, 4056) facing 1 (id 1)
  0.30  RESERVE: zone 2 at (1080, 3992) facing 1, 3x3 cells: 9 of 9 held
  0.30  RESERVE: armtide at (1080, 3992) facing 1 (id 2)
  0.30  RESERVE: zone 3 at (1080, 3928) facing 1, 3x3 cells: 9 of 9 held
  0.30  RESERVE: armtide at (1080, 3928) facing 1 (id 3)
  0.30  RESERVE: zone 4 at (1144, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.30  RESERVE: armtide at (1144, 4056) facing 1 (id 4)
  0.30  RESERVE: zone 5 at (1144, 3992) facing 1, 3x3 cells: 9 of 9 held
  0.30  RESERVE: armtide at (1144, 3992) facing 1 (id 5)
  0.30  RESERVE: zone 6 at (1144, 3928) facing 1, 3x3 cells: 9 of 9 held
  0.30  RESERVE: armtide at (1144, 3928) facing 1 (id 6)
  0.30  RESERVE: zone 7 at (1112, 3997) facing 1, 9x13 cells: 63 of 117 held
  0.30  RESERVE: served armtide at (1080, 4056) facing 1 (id 1, 5 of this def still held)
  0.31  EXP: approach: corcom(1517) at (1899, 5823) walks to (1807, 6004), 139 from the cormex site (1744, 6128)
  0.39  EXP: approach: corcom(23841) at (12698, 5816) walks to (12567, 5896), 139 from the cormex site (12448, 5968)
  0.49  EXP: approach: armcom(27473) at (13890, 4481) walks to (13767, 4465), 136 from the armmex site (13632, 4448)
  0.52  EXP: approach: corcom(1517) at (1820, 5986) walks to (1722, 5978), 139 from the cormex site (1584, 5968)
  0.57  EXP: approach: legcom(23127) at (13114, 3974) walks to (13138, 3979), 137 from the legtide site (13272, 4008)
  0.58  EXP: approach: legcom(23127) at (13115, 3974) walks to (13006, 3859), 137 from the legmex site (12912, 3760)
  0.58  EXP: approach: armcom(4451) at (512, 4668) walks to (583, 4705), 136 from the armmex site (704, 4768)
  0.59  EXP: approach: corcom(23841) at (12591, 5916) walks to (12597, 5990), 139 from the cormex site (12608, 6128)
  0.70  RESERVE: served armtide at (14056, 4600) facing 3 (id 2, 4 of this def still held)
  0.70  EXP: approach: armcom(18255) at (1250, 4027) walks to (1217, 4020), 140 from the armtide site (1080, 3992)
  0.70  RESERVE: served armtide at (1080, 3992) facing 1 (id 2, 4 of this def still held)
  0.72  EXP: approach: corcom(1517) at (1753, 5981) walks to (986, 6630), 139 from the cormex site (880, 6720)
  0.74  EXP: approach: corcom(23841) at (12593, 5962) walks to (13367, 6629), 139 from the cormex site (13472, 6720)
  0.76  EXP: approach: armcom(4451) at (552, 4696) walks to (471, 4659), 140 from the armtide site (344, 4600)
  0.76  RESERVE: served armtide at (344, 4600) facing 1 (id 2, 4 of this def still held)
  0.82  RESERVE: served legtide at (13272, 4008) facing 3 (id 2, 4 of this def still held)
  0.84  EXP: approach: armcom(18255) at (1250, 4027) walks to (1361, 3871), 136 from the armmex site (1440, 3760)
  0.94  EXP: approach: armcom(27473) at (13905, 4520) walks to (13746, 4674), 136 from the armmex site (13648, 4768)
  0.97  EXP: approach: armcom(4451) at (495, 4670) walks to (729, 4641), 136 from the armmex site (864, 4624)
  1.09  EXP: approach: armcom(18255) at (1349, 3896) walks to (1730, 2848), 136 from the armmex site (1776, 2720)
  1.10  EXP: approach: legcom(23127) at (13110, 3991) walks to (12887, 3957), 137 from the legmex site (12752, 3936)
  1.22  EXP: approach: armcom(27473) at (13783, 4667) walks to (13607, 4643), 136 from the armmex site (13472, 4624)
  1.25  RESERVE: served armtide at (344, 4536) facing 1 (id 3, 3 of this def still held)
  1.28  EXP: approach: corcom(1517) at (1008, 6616) walks to (1023, 6742), 139 from the cormex site (1040, 6880)
  1.31  EXP: approach: corcom(23841) at (13348, 6606) walks to (13330, 6742), 139 from the cormex site (13312, 6880)
  1.38  RESERVE: served legtide at (13272, 4072) facing 3 (id 3, 3 of this def still held)
  1.45  RESERVE: served armtide at (14056, 4664) facing 3 (id 3, 3 of this def still held)
  1.46  EXP: approach: corcom(1517) at (1020, 6727) walks to (936, 6913), 139 from the cormex site (880, 7040)
  1.49  EXP: approach: corcom(23841) at (13331, 6728) walks to (13508, 6817), 139 from the cormex site (13632, 6880)
  1.55  RESERVE: zone 8 at (344, 4760) facing 1, 3x3 cells: 9 of 9 held
  1.55  RESERVE: armfmkr at (344, 4760) facing 1 (id 7)
  1.55  RESERVE: zone 8 released
  1.55  EXP: approach: armcom(4451) at (516, 4533) walks to (497, 4556), 140 from the armtide site (408, 4664)
  1.55  RESERVE: served armtide at (408, 4664) facing 1 (id 4, 2 of this def still held)
  1.66  EXP: approach: legcom(23127) at (13109, 4025) walks to (12628, 2847), 137 from the legmex site (12576, 2720)
  1.67  EXP: approach: corcom(1517) at (950, 6892) walks to (859, 6887), 139 from the cormex site (720, 6880)
  1.70  EXP: approach: corcom(23841) at (13491, 6804) walks to (13483, 6902), 139 from the cormex site (13472, 7040)
  1.70  RESERVE: zone 9 at (248, 4664) facing 1, 3x3 cells: 9 of 9 held
  1.70  RESERVE: armfmkr at (248, 4664) facing 1 (id 8)
  1.70  RESERVE: zone 10 at (248, 4600) facing 1, 3x3 cells: 9 of 9 held
  1.70  RESERVE: armfmkr at (248, 4600) facing 1 (id 9)
  1.70  RESERVE: zone 11 at (248, 4536) facing 1, 3x3 cells: 9 of 9 held
  1.70  RESERVE: armfmkr at (248, 4536) facing 1 (id 10)
  1.70  RESERVE: zone 9 released
  1.70  RESERVE: zone 10 released
  1.70  RESERVE: zone 11 released
  1.70  RESERVE: served armtide at (408, 4600) facing 1 (id 5, 1 of this def still held)
  1.78  RESERVE: zone 8 at (14152, 4536) facing 3, 3x3 cells: 9 of 9 held
  1.78  RESERVE: armfmkr at (14152, 4536) facing 3 (id 7)
  1.78  RESERVE: zone 9 at (14152, 4600) facing 3, 3x3 cells: 9 of 9 held
  1.78  RESERVE: armfmkr at (14152, 4600) facing 3 (id 8)
  1.78  RESERVE: zone 10 at (14152, 4664) facing 3, 3x3 cells: 9 of 9 held
  1.78  RESERVE: armfmkr at (14152, 4664) facing 3 (id 9)
  1.78  RESERVE: zone 8 released
  1.78  RESERVE: zone 9 released
  1.78  RESERVE: zone 10 released
  1.78  EXP: approach: armcom(27473) at (13887, 4695) walks to (13915, 4653), 140 from the armtide site (13992, 4536)
  1.78  RESERVE: served armtide at (13992, 4536) facing 3 (id 4, 2 of this def still held)
```
