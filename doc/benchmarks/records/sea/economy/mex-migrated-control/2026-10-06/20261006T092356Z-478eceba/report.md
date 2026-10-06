# Playtest report: PASS

- Verdict: **PASS** (reached 15 min)
- Game time reached: 15.5 min (frame 27903); wall 1 s
- DLL: build-theatres\d216-final\SkirmishAI.dll (45eb0f2e89a285e3); AI BARbTest/test; staged 2026-10-06T06:00:37
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: checks.json; widget loaded: yes
- Log: build-theatres\games\sea\economy\mex-migrated-control\glacial\20261006T090037Z-00fb6091\runs\20261006T092356Z-478eceba\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:28.417229][f=-000001] [SeaExpansionWatch] loaded` |
| expect `frontier` | seen at 7.0 min | `[t=00:01:15.435524][f=0012600] [SeaExpansionWatch] sample frame=12600 team=0 mexes=8 beyond2400=2 furthest=2599 constructors=2` |
| expect `fortify` | seen at 4.0 min | `[t=00:00:59.459940][f=0007203] [SeaExpansionWatch] finished team=0 id=23710 def=armtl builder=nil x=1336 z=3800` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- build-theatres\games\sea\economy\mex-migrated-control\glacial\20261006T090037Z-00fb6091\runs\20261006T092356Z-478eceba\screen_2026-10-06_09-02-15-224.png
- build-theatres\games\sea\economy\mex-migrated-control\glacial\20261006T090037Z-00fb6091\runs\20261006T092356Z-478eceba\screen_2026-10-06_09-02-41-248.png
- build-theatres\games\sea\economy\mex-migrated-control\glacial\20261006T090037Z-00fb6091\runs\20261006T092356Z-478eceba\screen_2026-10-06_09-03-05-681.png

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
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 706/1200, energy +30.0 bank 2/1100, units 6
  1.14  [Playtest] finished armmex team 0 at 1.14 min
  1.79  [Playtest] finished armmex team 0 at 1.79 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +10.0 bank 1054/1300, energy +30.0 bank 54/1100, units 7
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 1291/1300, energy +30.0 bank 1/1100, units 7
  4.00  [Playtest] eco team 0 at 4.0 min: metal +8.0 bank 1269/1300, energy +37.0 bank 0/1150, units 9
  4.00  [Playtest] finished armtl team 0 at 4.00 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +10.0 bank 953/1300, energy +44.0 bank 103/1200, units 13
  5.00  [Playtest] camera requested (2800,4800) height=5000
  5.00  [Playtest] camera captured name=ta position=(2800,4800) height=5000
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (2800, 4800)
  5.03  [Playtest] finished armtide team 0 at 5.03 min
  5.23  [Playtest] finished armtide team 0 at 5.23 min
  5.25  [Playtest] finished armtide team 0 at 5.25 min
  5.26  [Playtest] finished armtide team 0 at 5.26 min
  5.54  [Playtest] finished armtide team 0 at 5.54 min
  5.57  [Playtest] finished armtide team 0 at 5.57 min
  5.95  [Playtest] finished armtide team 0 at 5.95 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +10.0 bank 390/1300, energy +205.0 bank 1475/1550, units 22
  6.01  [Playtest] finished armmex team 0 at 6.01 min
  6.09  [Playtest] finished armfmkr team 0 at 6.09 min
  6.25  [Playtest] finished armmex team 0 at 6.25 min
  6.25  [Playtest] finished armtide team 0 at 6.25 min
  6.46  [Playtest] finished armfmkr team 0 at 6.46 min
  6.56  [Playtest] finished armtide team 0 at 6.56 min
  6.72  [Playtest] finished armmex team 0 at 6.72 min
  6.81  [Playtest] finished armfmkr team 0 at 6.81 min
  6.87  [Playtest] finished armtide team 0 at 6.87 min
  6.93  [Playtest] finished armmex team 0 at 6.93 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +21.0 bank 155/1500, energy +274.0 bank 1561/1700, units 32
  7.13  [Playtest] finished armmex team 0 at 7.13 min
  7.17  [Playtest] finished armtide team 0 at 7.17 min
  7.17  [Playtest] finished armfmkr team 0 at 7.17 min
  7.30  [Playtest] finished armmex team 0 at 7.30 min
  7.48  [Playtest] finished armtide team 0 at 7.48 min
  7.54  [Playtest] finished armfmkr team 0 at 7.54 min
  7.79  [Playtest] finished armtide team 0 at 7.79 min
  7.88  [Playtest] finished armmex team 0 at 7.88 min
  7.91  [Playtest] finished armfmkr team 0 at 7.91 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +29.2 bank 693/1650, energy +343.0 bank 1502/1850, units 44
  8.09  [Playtest] finished armmex team 0 at 8.09 min
  8.15  [Playtest] finished armtide team 0 at 8.15 min
  8.29  [Playtest] finished armmex team 0 at 8.29 min
  8.30  [Playtest] finished armfmkr team 0 at 8.31 min
  8.46  [Playtest] finished armtide team 0 at 8.46 min
  8.47  [Playtest] finished armmex team 0 at 8.47 min
  8.69  [Playtest] finished armfmkr team 0 at 8.69 min
  8.77  [Playtest] finished armtide team 0 at 8.77 min
  8.97  [Playtest] finished armmex team 0 at 8.97 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +37.5 bank 1499/1850, energy +412.0 bank 1604/2000, units 53
  9.05  [Playtest] finished armfmkr team 0 at 9.05 min
  9.07  [Playtest] finished armtide team 0 at 9.07 min
  9.18  [Playtest] finished armmex team 0 at 9.18 min
  9.38  [Playtest] finished armtide team 0 at 9.38 min
  9.38  [Playtest] finished armmex team 0 at 9.38 min
  9.41  [Playtest] finished armfmkr team 0 at 9.41 min
  9.56  [Playtest] finished armmex team 0 at 9.56 min
  9.69  [Playtest] finished armtide team 0 at 9.69 min
  9.71  [Playtest] finished armllt team 0 at 9.71 min
  9.78  [Playtest] finished armfmkr team 0 at 9.78 min
  9.99  [Playtest] finished armtide team 0 at 9.99 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +46.7 bank 1620/2000, energy +481.0 bank 1850/2200, units 63
 10.00  [Playtest] camera requested (4000,4800) height=5500
 10.01  [Playtest] camera captured name=ta position=(4000,4800) height=5500
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4000, 4800)
 10.15  [Playtest] finished armfmkr team 0 at 10.15 min
 10.33  [Playtest] finished armtide team 0 at 10.33 min
 10.51  [Playtest] finished armfmkr team 0 at 10.51 min
 10.65  [Playtest] finished armtide team 0 at 10.65 min
 10.73  [Playtest] finished armfmkr team 0 at 10.73 min
 10.88  [Playtest] finished armfmkr team 0 at 10.88 min
 10.96  [Playtest] finished armtide team 0 at 10.96 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +47.5 bank 1999/2000, energy +573.0 bank 1879/2350, units 71
 11.13  [Playtest] finished armfmkr team 0 at 11.13 min
 11.26  [Playtest] finished armfmkr team 0 at 11.26 min
 11.34  [Playtest] finished armtide team 0 at 11.34 min
 11.35  [Playtest] finished armfmkr team 0 at 11.35 min
 11.67  [Playtest] finished armtide team 0 at 11.67 min
 11.76  [Playtest] finished armtide team 0 at 11.76 min
 11.99  [Playtest] finished armtide team 0 at 11.99 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +49.6 bank 1760/2000, energy +642.0 bank 2102/2550, units 76
 12.32  [Playtest] finished armtide team 0 at 12.32 min
 12.32  [Playtest] finished armfmkr team 0 at 12.32 min
 12.64  [Playtest] finished armtide team 0 at 12.64 min
 12.80  [Playtest] finished armfmkr team 0 at 12.80 min
 12.95  [Playtest] finished armtide team 0 at 12.95 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +49.4 bank 1776/2000, energy +734.0 bank 2240/2700, units 83
 13.01  [Playtest] finished armllt team 0 at 13.01 min
 13.17  [Playtest] finished armfmkr team 0 at 13.17 min
 13.27  [Playtest] finished armtide team 0 at 13.27 min
 13.59  [Playtest] finished armtide team 0 at 13.59 min
 13.90  [Playtest] finished armtide team 0 at 13.90 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +51.0 bank 1702/2000, energy +803.0 bank 2457/2850, units 85
 14.00  [Playtest] camera requested (6500,4800) height=7000
 14.02  [Playtest] camera captured name=ta position=(6500,4800) height=7000
 14.02  [Playtest] screenshot at 14.0 min of team 0 at (6500, 4800)
 14.21  [Playtest] finished armtide team 0 at 14.21 min
 14.40  [Playtest] finished armfrad team 0 at 14.40 min
 14.45  [Playtest] finished armfmkr team 0 at 14.45 min
 14.53  [Playtest] finished armtide team 0 at 14.53 min
 14.65  [Playtest] finished armfmkr team 0 at 14.65 min
 14.85  [Playtest] finished armtide team 0 at 14.85 min
 14.90  [Playtest] finished armfmkr team 0 at 14.90 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +46.8 bank 1879/2000, energy +872.0 bank 2559/3000, units 92
 15.08  [Playtest] finished armfmkr team 0 at 15.08 min
 15.19  [Playtest] finished armtide team 0 at 15.19 min
 15.25  [Playtest] finished armfmkr team 0 at 15.25 min
 15.50  [Playtest] end at 15.5 min: quitting
 15.50  [Playtest] finished armtide team 0 at 15.50 min
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
