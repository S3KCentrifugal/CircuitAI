# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 15.5 min (frame 27902); wall 1 s
- DLL: build-theatres\d216-final\SkirmishAI.dll (45eb0f2e89a285e3); AI BARbTest/test; staged 2026-10-06T05:56:03
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: mex-expansion.json; widget loaded: yes
- Log: build-theatres\games\sea\economy\mex-expansion-migrated\glacial\20261006T085602Z-50c5e14d\runs\20261006T090203Z-705e6f0e\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:28.790159][f=-000001] [SeaExpansionWatch] loaded` |
| expect `frontier` | **missing** (by 10 min) | |
| expect `fortify` | seen at 3.2 min | `[t=00:00:55.100983][f=0005694] [SeaExpansionWatch] finished team=4 id=11953 def=armtl builder=nil x=13768 z=4392` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Failures

- 'frontier' not seen by 10.0 min

## Screenshots

- build-theatres\games\sea\economy\mex-expansion-migrated\glacial\20261006T085602Z-50c5e14d\runs\20261006T090203Z-705e6f0e\screen_2026-10-06_08-57-29-225.png
- build-theatres\games\sea\economy\mex-expansion-migrated\glacial\20261006T085602Z-50c5e14d\runs\20261006T090203Z-705e6f0e\screen_2026-10-06_08-57-55-335.png
- build-theatres\games\sea\economy\mex-expansion-migrated\glacial\20261006T085602Z-50c5e14d\runs\20261006T090203Z-705e6f0e\screen_2026-10-06_08-58-20-566.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 12, 3 shots, end at 15.5 min
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
  0.00  [Playtest] speed 12
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (1430, 4000) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (700, 4600) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (1900, 5800) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (12925, 4000) units 1
  0.05  [Playtest] frame 90 team 4 ally 1 side armada ai true dead false start (13700, 4600) units 1
  0.05  [Playtest] frame 90 team 5 ally 1 side cortex ai true dead false start (12618, 5800) units 1
  0.05  [Playtest] frame 90 team 6 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 7 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.10  [SEA][Layout] berth sea.berth.0 armsy at=1424,4000 facing=1
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(700,4597) factory=armsy landLocked=no spot=5 known=1/2
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(1899,5801) factory=corsy landLocked=no spot=6 known=2/2
  0.12  [SEA][Layout] berth sea.berth.1 armasy at=1424,3600 facing=1
  0.13  [SEA][Layout] berth sea.berth.2 armplat at=1488,3264 facing=1
  0.15  [Team][Roster] team 1 first mex at 704,4448
  0.15  [Playtest] finished armmex team 0 at 0.15 min
  0.17  [Team][Roster] first mex 10685 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.18  [Team][Roster] team 2 first mex at 1904,5967
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.73  [Playtest] finished armsy team 0 at 0.73 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 706/1200, energy +30.0 bank 1/1100, units 6
  1.14  [Playtest] finished armmex team 0 at 1.14 min
  1.52  [Playtest] finished armmex team 0 at 1.52 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +10.0 bank 1098/1300, energy +30.0 bank 94/1100, units 7
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 1297/1300, energy +30.0 bank 36/1100, units 7
  3.85  [Playtest] finished armtl team 0 at 3.85 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 1287/1300, energy +37.0 bank 40/1150, units 9
  4.61  [Playtest] finished armtl team 0 at 4.61 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +10.0 bank 1017/1300, energy +44.0 bank 84/1200, units 13
  5.00  [Playtest] camera requested (2800,4800) height=5000
  5.00  [Playtest] camera captured name=ta position=(2800,4800) height=5000
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (2800, 4800)
  5.03  [Playtest] finished armtide team 0 at 5.03 min
  5.36  [Playtest] finished armtide team 0 at 5.36 min
  5.37  [Playtest] finished armtide team 0 at 5.37 min
  5.67  [Playtest] finished armtide team 0 at 5.67 min
  5.68  [Playtest] finished armtide team 0 at 5.68 min
  5.98  [Playtest] finished armtide team 0 at 5.98 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +10.0 bank 593/1300, energy +159.0 bank 1489/1500, units 21
  6.21  [Playtest] finished armfmkr team 0 at 6.21 min
  6.29  [Playtest] finished armtide team 0 at 6.29 min
  6.60  [Playtest] finished armtide team 0 at 6.60 min
  6.76  [Playtest] finished armtide team 0 at 6.76 min
  6.84  [Playtest] finished armllt team 0 at 6.84 min
  6.90  [Playtest] finished armtide team 0 at 6.90 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +11.0 bank 18/1300, energy +281.0 bank 1742/1750, units 27
  7.13  [Playtest] finished armtide team 0 at 7.13 min
  7.48  [Playtest] finished armfmkr team 0 at 7.48 min
  7.53  [Playtest] finished armfrad team 0 at 7.53 min
  7.71  [Playtest] finished armfmkr team 0 at 7.71 min
  7.89  [Playtest] finished armfmkr team 0 at 7.89 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +14.0 bank 147/1300, energy +304.0 bank 1658/1800, units 33
  8.15  [Playtest] finished armfmkr team 0 at 8.15 min
  8.28  [Playtest] finished armtide team 0 at 8.28 min
  8.35  [Playtest] finished armtide team 0 at 8.35 min
  8.71  [Playtest] finished armtide team 0 at 8.71 min
  8.76  [Playtest] finished armtide team 0 at 8.76 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +15.0 bank 12/1300, energy +396.0 bank 1814/2000, units 40
  9.30  [Playtest] finished armfmkr team 0 at 9.30 min
  9.39  [Playtest] finished armrad team 0 at 9.39 min
  9.51  [Playtest] finished armtide team 0 at 9.51 min
  9.66  [Playtest] finished armfmkr team 0 at 9.66 min
  9.72  [Playtest] finished armtide team 0 at 9.72 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +16.6 bank 315/1300, energy +442.0 bank 1789/2100, units 47
 10.00  [Playtest] camera requested (4000,4800) height=5500
 10.01  [Playtest] camera captured name=ta position=(4000,4800) height=5500
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4000, 4800)
 10.05  [Playtest] finished armtide team 0 at 10.05 min
 10.06  [Playtest] finished armfmkr team 0 at 10.06 min
 10.17  [Playtest] finished armfmkr team 0 at 10.17 min
 10.49  [Playtest] finished armfmkr team 0 at 10.49 min
 10.70  [Playtest] finished armfmkr team 0 at 10.70 min
 10.71  [Playtest] finished armfmkr team 0 at 10.71 min
 10.86  [Playtest] finished armfmkr team 0 at 10.86 min
 10.89  [Playtest] finished armfmkr team 0 at 10.89 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +18.5 bank 954/1300, energy +465.0 bank 1790/2150, units 53
 11.54  [Playtest] finished armtl team 0 at 11.54 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +18.6 bank 1299/1300, energy +465.0 bank 1811/2150, units 55
 12.15  [Playtest] finished armmex team 0 at 12.15 min
 12.49  [Playtest] finished armmex team 0 at 12.49 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +24.3 bank 1399/1400, energy +465.0 bank 1787/2150, units 54
 14.00  [Playtest] eco team 0 at 14.0 min: metal +22.3 bank 1388/1400, energy +465.0 bank 1762/2150, units 56
 14.00  [Playtest] camera requested (6500,4800) height=7000
 14.02  [Playtest] camera captured name=ta position=(6500,4800) height=7000
 14.02  [Playtest] screenshot at 14.0 min of team 0 at (6500, 4800)
 14.19  [Playtest] finished armtl team 0 at 14.19 min
 14.38  [Playtest] finished armtide team 0 at 14.38 min
 14.39  [Playtest] finished armtide team 0 at 14.39 min
 14.71  [Playtest] finished armtide team 0 at 14.71 min
 14.71  [Playtest] finished armtide team 0 at 14.71 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +21.9 bank 1128/1350, energy +557.0 bank 1981/2350, units 61
 15.05  [Playtest] finished armtide team 0 at 15.05 min
 15.08  [Playtest] finished armtide team 0 at 15.08 min
 15.50  [Playtest] end at 15.5 min: quitting
```

## Native lines (all AIs, first 120)

```
  0.09  EXP: approach: corcom(8444) at (1899, 5801) walks to (1900, 5829), 139 from the cormex site (1904, 5968)
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
  0.10  RESERVE: zone 1 at (704, 4592) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (704, 4592) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (992, 4592) facing 1, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (488, 4872) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4872) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (488, 4824) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4824) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (488, 4776) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4776) facing 1 (id 4)
  0.10  RESERVE: zone 6 at (488, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4728) facing 1 (id 5)
  0.10  RESERVE: zone 7 at (488, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4680) facing 1 (id 6)
  0.10  RESERVE: zone 8 at (536, 4872) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (536, 4872) facing 1 (id 7)
  0.10  RESERVE: zone 9 at (536, 4824) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (536, 4824) facing 1 (id 8)
  0.10  RESERVE: zone 10 at (536, 4776) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (536, 4776) facing 1 (id 9)
  0.10  RESERVE: zone 11 at (536, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (536, 4728) facing 1 (id 10)
  0.10  RESERVE: zone 12 at (536, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (536, 4680) facing 1 (id 11)
  0.10  RESERVE: zone 13 at (584, 4872) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (584, 4872) facing 1 (id 12)
  0.10  RESERVE: zone 14 at (584, 4824) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (584, 4824) facing 1 (id 13)
  0.10  RESERVE: zone 15 at (584, 4776) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (584, 4776) facing 1 (id 14)
  0.10  RESERVE: zone 16 at (584, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (584, 4728) facing 1 (id 15)
  0.10  RESERVE: zone 17 at (584, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (584, 4680) facing 1 (id 16)
  0.10  RESERVE: zone 18 at (632, 4872) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (632, 4872) facing 1 (id 17)
  0.10  RESERVE: zone 19 at (632, 4824) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (632, 4824) facing 1 (id 18)
  0.10  RESERVE: zone 20 at (632, 4776) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (632, 4776) facing 1 (id 19)
  0.10  RESERVE: zone 21 at (632, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (632, 4728) facing 1 (id 20)
  0.10  RESERVE: zone 22 at (632, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (632, 4680) facing 1 (id 21)
  0.10  RESERVE: zone 23 at (-80, 4592) facing 1, 15x40 cells: 440 of 600 held
  0.10  RESERVE: refused armnanotcplat at (8, 4664): off map
  0.10  RESERVE: refused armnanotcplat at (8, 4616): off map
  0.10  RESERVE: refused armnanotcplat at (8, 4568): off map
  0.10  RESERVE: refused armnanotcplat at (8, 4520): off map
  0.10  RESERVE: refused armnanotcplat at (8, 4664): off map
  0.10  RESERVE: refused armnanotcplat at (8, 4616): off map
  0.10  RESERVE: refused armnanotcplat at (8, 4568): off map
  0.10  RESERVE: refused armnanotcplat at (8, 4520): off map
  0.10  RESERVE: refused armnanotcplat at (8, 4664): off map
  0.10  RESERVE: refused armnanotcplat at (8, 4616): off map
  0.10  RESERVE: refused armnanotcplat at (8, 4568): off map
  0.10  RESERVE: refused armnanotcplat at (8, 4520): off map
  0.10  RESERVE: refused armnanotcplat at (8, 4664): off map
  0.10  RESERVE: refused armnanotcplat at (8, 4616): off map
  0.10  RESERVE: refused armnanotcplat at (8, 4568): off map
  0.10  RESERVE: refused armnanotcplat at (8, 4520): off map
  0.10  RESERVE: zone 23 released
  0.10  RESERVE: zone 24 at (-80, 4464) facing 1, 15x40 cells: 440 of 600 held
  0.10  RESERVE: refused armnanotcplat at (8, 4536): off map
  0.10  RESERVE: refused armnanotcplat at (8, 4488): off map
  0.10  RESERVE: refused armnanotcplat at (8, 4440): off map
  0.10  RESERVE: refused armnanotcplat at (8, 4392): off map
  0.10  RESERVE: refused armnanotcplat at (8, 4536): off map
  0.10  RESERVE: refused armnanotcplat at (8, 4488): off map
  0.10  RESERVE: refused armnanotcplat at (8, 4440): off map
  0.10  RESERVE: refused armnanotcplat at (8, 4392): off map
  0.10  RESERVE: refused armnanotcplat at (8, 4536): off map
  0.10  RESERVE: refused armnanotcplat at (8, 4488): off map
```
