# Playtest report: PASS

- Verdict: **PASS** (reached 15 min)
- Game time reached: 15.5 min (frame 27900); wall 1 s
- DLL: build-theatres\d216-final\SkirmishAI.dll (45eb0f2e89a285e3); AI BARbTest/test; staged 2026-10-06T06:06:01
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: mex-expansion.json; widget loaded: yes
- Log: build-theatres\games\sea\economy\mex-expansion-homefirst\glacial\20261006T090601Z-94b8a5a8\runs\20261006T091234Z-586cc3c3\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:28.989000][f=-000001] [SeaExpansionWatch] loaded` |
| expect `frontier` | seen at 6.5 min | `[t=00:01:13.066943][f=0011700] [SeaExpansionWatch] sample frame=11700 team=0 mexes=9 beyond2400=2 furthest=2599 constructors=2` |
| expect `fortify` | seen at 3.5 min | `[t=00:00:57.136139][f=0006320] [SeaExpansionWatch] finished team=1 id=27341 def=armtl builder=nil x=552 z=4504` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- build-theatres\games\sea\economy\mex-expansion-homefirst\glacial\20261006T090601Z-94b8a5a8\runs\20261006T091234Z-586cc3c3\screen_2026-10-06_09-07-29-990.png
- build-theatres\games\sea\economy\mex-expansion-homefirst\glacial\20261006T090601Z-94b8a5a8\runs\20261006T091234Z-586cc3c3\screen_2026-10-06_09-07-55-984.png
- build-theatres\games\sea\economy\mex-expansion-homefirst\glacial\20261006T090601Z-94b8a5a8\runs\20261006T091234Z-586cc3c3\screen_2026-10-06_09-08-21-482.png

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
  2.00  [Playtest] eco team 0 at 2.0 min: metal +10.0 bank 1099/1300, energy +30.0 bank 105/1100, units 7
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 1297/1300, energy +30.0 bank 41/1100, units 7
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 1276/1300, energy +37.0 bank 120/1150, units 8
  4.38  [Playtest] finished armtide team 0 at 4.38 min
  4.55  [Playtest] finished armtide team 0 at 4.55 min
  4.79  [Playtest] finished armtide team 0 at 4.79 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +10.0 bank 594/1300, energy +113.0 bank 1082/1350, units 15
  5.00  [Playtest] camera requested (2800,4800) height=5000
  5.00  [Playtest] camera captured name=ta position=(2800,4800) height=5000
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (2800, 4800)
  5.09  [Playtest] finished armtide team 0 at 5.09 min
  5.17  [Playtest] finished armtl team 0 at 5.17 min
  5.30  [Playtest] finished armmex team 0 at 5.30 min
  5.40  [Playtest] finished armtide team 0 at 5.40 min
  5.47  [Playtest] finished armmex team 0 at 5.47 min
  5.68  [Playtest] finished armmex team 0 at 5.68 min
  5.73  [Playtest] finished armtide team 0 at 5.73 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +16.0 bank 163/1450, energy +182.0 bank 1484/1500, units 22
  6.04  [Playtest] finished armtide team 0 at 6.03 min
  6.17  [Playtest] finished armmex team 0 at 6.18 min
  6.34  [Playtest] finished armtide team 0 at 6.34 min
  6.39  [Playtest] finished armmex team 0 at 6.39 min
  6.59  [Playtest] finished armmex team 0 at 6.59 min
  6.60  [Playtest] finished armmex team 0 at 6.60 min
  6.65  [Playtest] finished armtide team 0 at 6.65 min
  6.76  [Playtest] finished armmex team 0 at 6.76 min
  6.90  [Playtest] finished armmex team 0 at 6.90 min
  6.96  [Playtest] finished armtide team 0 at 6.96 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +28.0 bank 264/1750, energy +274.0 bank 1690/1700, units 36
  7.26  [Playtest] finished armtide team 0 at 7.26 min
  7.33  [Playtest] finished armmex team 0 at 7.33 min
  7.41  [Playtest] finished armtl team 0 at 7.41 min
  7.57  [Playtest] finished armtide team 0 at 7.57 min
  7.88  [Playtest] finished armtide team 0 at 7.88 min
  7.89  [Playtest] finished armtide team 0 at 7.89 min
  7.90  [Playtest] finished armllt team 0 at 7.90 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +30.0 bank 968/1800, energy +373.0 bank 1942/1950, units 44
  8.22  [Playtest] finished armtide team 0 at 8.22 min
  8.25  [Playtest] finished armtide team 0 at 8.25 min
  8.52  [Playtest] finished armmex team 0 at 8.52 min
  8.56  [Playtest] finished armtide team 0 at 8.56 min
  8.58  [Playtest] finished armtide team 0 at 8.58 min
  8.72  [Playtest] finished armmex team 0 at 8.72 min
  8.87  [Playtest] finished armtide team 0 at 8.87 min
  8.88  [Playtest] finished armmex team 0 at 8.88 min
  8.89  [Playtest] finished armtide team 0 at 8.89 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +36.0 bank 1240/1950, energy +511.0 bank 2233/2250, units 55
  9.16  [Playtest] finished armnanotcplat team 0 at 9.16 min
  9.18  [Playtest] finished armtide team 0 at 9.18 min
  9.21  [Playtest] finished armtide team 0 at 9.21 min
  9.50  [Playtest] finished armtide team 0 at 9.50 min
  9.54  [Playtest] finished armtide team 0 at 9.54 min
  9.57  [Playtest] finished armnanotcplat team 0 at 9.57 min
  9.89  [Playtest] finished armtide team 0 at 9.89 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +36.0 bank 1191/1950, energy +633.0 bank 2597/2600, units 63
 10.00  [Playtest] camera requested (4000,4800) height=5500
 10.01  [Playtest] camera captured name=ta position=(4000,4800) height=5500
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4000, 4800)
 10.02  [Playtest] finished armtide team 0 at 10.02 min
 10.25  [Playtest] finished armtide team 0 at 10.25 min
 10.37  [Playtest] finished armtide team 0 at 10.37 min
 10.56  [Playtest] finished armtide team 0 at 10.56 min
 10.62  [Playtest] finished armfmkr team 0 at 10.62 min
 10.65  [Playtest] finished armtide team 0 at 10.65 min
 10.93  [Playtest] finished armtide team 0 at 10.93 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +37.0 bank 478/1950, energy +785.0 bank 2882/2950, units 77
 11.01  [Playtest] finished armtide team 0 at 11.01 min
 11.04  [Playtest] finished armtide team 0 at 11.04 min
 11.25  [Playtest] finished armtide team 0 at 11.25 min
 11.32  [Playtest] finished armtide team 0 at 11.32 min
 11.33  [Playtest] finished armtl team 0 at 11.33 min
 11.41  [Playtest] finished armtide team 0 at 11.41 min
 11.56  [Playtest] finished armtide team 0 at 11.56 min
 11.79  [Playtest] finished armtide team 0 at 11.79 min
 11.83  [Playtest] finished armllt team 0 at 11.83 min
 11.84  [Playtest] finished armtide team 0 at 11.84 min
 11.88  [Playtest] finished armtide team 0 at 11.88 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +37.0 bank 823/1950, energy +992.0 bank 3386/3400, units 91
 12.37  [Playtest] finished armfmkr team 0 at 12.37 min
 12.41  [Playtest] finished armtide team 0 at 12.41 min
 12.42  [Playtest] finished armtide team 0 at 12.42 min
 12.60  [Playtest] finished armtide team 0 at 12.60 min
 12.68  [Playtest] finished armnanotcplat team 0 at 12.68 min
 12.70  [Playtest] finished armfhlt team 0 at 12.70 min
 12.73  [Playtest] finished armtide team 0 at 12.73 min
 12.78  [Playtest] finished armfmkr team 0 at 12.78 min
 12.84  [Playtest] finished armtide team 0 at 12.84 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +39.0 bank 886/1950, energy +1107.0 bank 3594/3650, units 103
 13.07  [Playtest] finished armfmkr team 0 at 13.07 min
 13.08  [Playtest] finished armtide team 0 at 13.08 min
 13.19  [Playtest] finished armfmkr team 0 at 13.19 min
 13.29  [Playtest] finished armfmkr team 0 at 13.29 min
 13.33  [Playtest] finished armtide team 0 at 13.33 min
 13.36  [Playtest] finished armnanotcplat team 0 at 13.36 min
 13.47  [Playtest] finished armfmkr team 0 at 13.47 min
 13.48  [Playtest] finished armtide team 0 at 13.48 min
 13.65  [Playtest] finished armfmkr team 0 at 13.65 min
 13.68  [Playtest] finished armfmkr team 0 at 13.68 min
 13.85  [Playtest] finished armfmkr team 0 at 13.85 min
 13.94  [Playtest] finished armfmkr team 0 at 13.94 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +95.7 bank 925/1950, energy +1169.0 bank 3178/3750, units 120
 14.00  [Playtest] camera requested (6500,4800) height=7000
 14.01  [Playtest] camera captured name=ta position=(6500,4800) height=7000
 14.01  [Playtest] screenshot at 14.0 min of team 0 at (6500, 4800)
 14.19  [Playtest] finished armfmkr team 0 at 14.19 min
 14.22  [Playtest] finished armfmkr team 0 at 14.22 min
 14.31  [Playtest] finished armfmkr team 0 at 14.31 min
 14.79  [Playtest] finished armasy team 0 at 14.79 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +45.2 bank 498/2150, energy +1176.0 bank 3155/4000, units 127
 15.11  [Playtest] finished armfmkr team 0 at 15.11 min
 15.14  [Playtest] finished armfmkr team 0 at 15.14 min
 15.24  [Playtest] finished armfmkr team 0 at 15.24 min
 15.32  [Playtest] finished armfmkr team 0 at 15.32 min
 15.32  [Playtest] finished armfmkr team 0 at 15.32 min
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
  0.10  EXP: idle: corcom(8444) on cormex at (1899, 5822), site (1904, 5968), target yes, fails 1 (arrived at the approach point)
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
```
