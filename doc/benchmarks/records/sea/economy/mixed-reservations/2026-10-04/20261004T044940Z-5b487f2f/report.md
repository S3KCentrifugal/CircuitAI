# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 2.2 min (frame 4026); wall 66 s
- DLL: build-theatres\d188-build-6\SkirmishAI.dll (ac71826721992d84); AI BARbTest/test; staged 2026-10-04T01:48:31
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=TECH/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=TECH/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\mixed-reservations\glacial\20261004T044831Z-ccdc3426\runs\20261004T044940Z-5b487f2f\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:35.560670][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.8 min | `[t=00:00:55.938942][f=0001359] [SeaWatch] finished frame=1359 id=22087 def=armsy builder=13631` |
| expect `first-ship-exit` | **missing** (by 6 min) | |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 2.1 min: [INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s

## Screenshots

- none

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 20.5 min
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
  0.10  [SEA][Layout] berth sea.berth.0 armsy at=1424,4000 facing=1
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(490,1137) factory=armlab landLocked=no spot=0 known=1/3
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(699,4601) factory=corsy landLocked=no spot=5 known=2/3
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(1900,5800) factory=legsy landLocked=no spot=6 known=3/3
  0.12  [SEA][Layout] berth sea.berth.1 armasy at=1424,3600 facing=1
  0.16  [Playtest] finished armmex team 0 at 0.16 min
  0.17  [SEA][Layout] berth sea.berth.2 armasy at=1424,3296 facing=3
  0.17  [Team][Roster] first mex 22546 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.17  [Team][Roster] team 1 first mex at 496,1296
  0.17  [Team][Roster] team 2 first mex at 704,4447
  0.20  [Team][Roster] team 3 first mex at 1904,5968
  0.30  [Playtest] finished armmex team 0 at 0.30 min
  0.76  [Playtest] finished armsy team 0 at 0.75 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 701/1200, energy +30.0 bank 0/1100, units 6
  1.12  [Playtest] finished armmex team 0 at 1.12 min
  1.54  [Playtest] finished armtide team 0 at 1.54 min
  1.83  [Playtest] finished armtide team 0 at 1.83 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 761/1250, energy +76.0 bank 163/1200, units 9
  2.01  [Playtest] finished armtide team 0 at 2.01 min
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
  0.09  EXP: approach: legcom(27814) at (1900, 5800) walks to (1901, 5831), 137 from the legmex site (1904, 5968)
  0.09  RESERVE: factory pair 'tech.factory.start' committed atomically facing 2
  0.09  RESERVE: zone 7 at (13509, 1272) facing 2, 77x63 cells: 4554 of 4851 held
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
  0.10  RESERVE: zone 1 at (1424, 4000) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (1424, 4000) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (1712, 4000) facing 1, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (1208, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1208, 4072) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (1208, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1208, 4008) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (1208, 3944) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1208, 3944) facing 1 (id 4)
  0.10  RESERVE: zone 6 at (1272, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1272, 4072) facing 1 (id 5)
  0.10  RESERVE: zone 7 at (1272, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1272, 4008) facing 1 (id 6)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 released
  0.10  RESERVE: zone 6 released
  0.10  RESERVE: zone 7 released
  0.10  RESERVE: zone 8 at (1304, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1304, 4072) facing 1 (id 7)
  0.10  RESERVE: zone 9 at (1304, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1304, 4008) facing 1 (id 8)
  0.10  RESERVE: zone 8 released
  0.10  RESERVE: zone 9 released
  0.10  RESERVE: zone 10 at (1288, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1288, 4104) facing 1 (id 9)
  0.10  RESERVE: zone 11 at (1288, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1288, 4040) facing 1 (id 10)
  0.10  RESERVE: zone 12 at (1288, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1288, 3976) facing 1 (id 11)
  0.10  RESERVE: zone 13 at (1352, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 4104) facing 1 (id 12)
  0.10  RESERVE: zone 14 at (1352, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 4040) facing 1 (id 13)
  0.10  RESERVE: zone 15 at (1352, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 3976) facing 1 (id 14)
  0.10  RESERVE: zone 16 at (1321, 4037) facing 1, 9x13 cells: 54 of 117 held
  0.10  RESERVE: zone 1 at (704, 4608) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: corsy at (704, 4608) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (992, 4608) facing 1, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (488, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (488, 4680) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (488, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (488, 4616) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (488, 4552) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (488, 4552) facing 1 (id 4)
  0.10  RESERVE: zone 6 at (552, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (552, 4680) facing 1 (id 5)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 released
  0.10  RESERVE: zone 6 released
  0.10  RESERVE: zone 7 at (584, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (584, 4680) facing 1 (id 6)
  0.10  RESERVE: zone 7 released
  0.10  RESERVE: zone 8 at (568, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (568, 4712) facing 1 (id 7)
  0.10  RESERVE: zone 8 released
  0.10  RESERVE: zone 9 at (552, 4744) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (552, 4744) facing 1 (id 8)
  0.10  RESERVE: zone 10 at (552, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (552, 4680) facing 1 (id 9)
  0.10  RESERVE: zone 9 released
  0.10  RESERVE: zone 10 released
  0.10  RESERVE: zone 11 at (520, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (520, 4760) facing 1 (id 10)
  0.10  RESERVE: zone 12 at (520, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (520, 4696) facing 1 (id 11)
  0.10  RESERVE: zone 11 released
  0.10  RESERVE: zone 12 released
  0.10  RESERVE: zone 13 at (488, 4776) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (488, 4776) facing 1 (id 12)
  0.10  RESERVE: zone 14 at (488, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (488, 4712) facing 1 (id 13)
  0.10  RESERVE: zone 15 at (488, 4648) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (488, 4648) facing 1 (id 14)
  0.10  RESERVE: zone 16 at (552, 4776) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (552, 4776) facing 1 (id 15)
  0.10  RESERVE: zone 17 at (552, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (552, 4712) facing 1 (id 16)
  0.10  RESERVE: zone 13 released
  0.10  RESERVE: zone 14 released
  0.10  RESERVE: zone 15 released
```
