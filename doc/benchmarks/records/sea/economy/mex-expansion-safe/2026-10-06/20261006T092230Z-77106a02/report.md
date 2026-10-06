# Playtest report: PASS

- Verdict: **PASS** (reached 15 min)
- Game time reached: 15.5 min (frame 27902); wall 1 s
- DLL: build-theatres\d216-final\SkirmishAI.dll (45eb0f2e89a285e3); AI BARbTest/test; staged 2026-10-06T06:14:06
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: mex-expansion.json; widget loaded: yes
- Log: build-theatres\games\sea\economy\mex-expansion-safe\glacial\20261006T091405Z-58a37df6\runs\20261006T092230Z-77106a02\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:28.770973][f=-000001] [SeaExpansionWatch] loaded` |
| expect `frontier` | seen at 6.0 min | `[t=00:01:10.262014][f=0010800] [SeaExpansionWatch] sample frame=10800 team=0 mexes=5 beyond2400=1 furthest=3330 constructors=2` |
| expect `cluster-fort-order` | seen at 5.2 min | `[SEA][Expansion] fort=cortl ship=4850 x=9807 z=4768` |
| expect `fortify` | seen at 3.6 min | `[t=00:00:57.373551][f=0006515] [SeaExpansionWatch] finished team=0 id=4199 def=armtl builder=nil x=1336 z=3800` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- build-theatres\games\sea\economy\mex-expansion-safe\glacial\20261006T091405Z-58a37df6\runs\20261006T092230Z-77106a02\screen_2026-10-06_09-16-35-928.png
- build-theatres\games\sea\economy\mex-expansion-safe\glacial\20261006T091405Z-58a37df6\runs\20261006T092230Z-77106a02\screen_2026-10-06_09-17-02-087.png
- build-theatres\games\sea\economy\mex-expansion-safe\glacial\20261006T091405Z-58a37df6\runs\20261006T092230Z-77106a02\screen_2026-10-06_09-17-27-090.png

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
  1.18  [Playtest] finished armmex team 0 at 1.18 min
  1.56  [Playtest] finished armmex team 0 at 1.56 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +10.0 bank 1090/1300, energy +30.0 bank 126/1100, units 7
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 1297/1300, energy +30.0 bank 27/1100, units 7
  3.62  [Playtest] finished armtl team 0 at 3.62 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 1291/1300, energy +37.0 bank 0/1150, units 10
  4.32  [Playtest] finished armtl team 0 at 4.32 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +10.0 bank 1134/1300, energy +44.0 bank 1034/1200, units 11
  5.00  [Playtest] camera requested (2800,4800) height=5000
  5.00  [Playtest] camera captured name=ta position=(2800,4800) height=5000
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (2800, 4800)
  5.42  [Playtest] finished armtide team 0 at 5.42 min
  5.48  [Playtest] finished armllt team 0 at 5.48 min
  5.64  [Playtest] finished armmex team 0 at 5.64 min
  5.72  [Playtest] finished armtide team 0 at 5.72 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +12.0 bank 702/1350, energy +90.0 bank 1210/1300, units 19
  6.03  [Playtest] finished armtide team 0 at 6.03 min
  6.20  [Playtest] finished armmex team 0 at 6.20 min
  6.34  [Playtest] finished armtide team 0 at 6.34 min
  6.46  [Playtest] finished armfrad team 0 at 6.46 min
  6.67  [Playtest] finished armtide team 0 at 6.67 min
  6.74  [Playtest] finished armfmkr team 0 at 6.74 min
  6.99  [Playtest] finished armtide team 0 at 6.99 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +15.0 bank 238/1400, energy +159.0 bank 1393/1500, units 27
  7.02  [Playtest] finished armfrad team 0 at 7.02 min
  7.29  [Playtest] finished armtide team 0 at 7.29 min
  7.60  [Playtest] finished armtide team 0 at 7.60 min
  7.62  [Playtest] finished armmex team 0 at 7.62 min
  7.91  [Playtest] finished armtide team 0 at 7.91 min
  7.97  [Playtest] finished armmex team 0 at 7.97 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +18.0 bank 299/1500, energy +251.0 bank 1638/1650, units 35
  8.16  [Playtest] finished armtl team 0 at 8.16 min
  8.18  [Playtest] finished armmex team 0 at 8.18 min
  8.22  [Playtest] finished armtide team 0 at 8.22 min
  8.38  [Playtest] finished armmex team 0 at 8.38 min
  8.42  [Playtest] finished armfrad team 0 at 8.42 min
  8.52  [Playtest] finished armtide team 0 at 8.52 min
  8.67  [Playtest] finished armmex team 0 at 8.67 min
  8.84  [Playtest] finished armtide team 0 at 8.84 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +25.0 bank 327/1650, energy +320.0 bank 1792/1800, units 43
  9.16  [Playtest] finished armtide team 0 at 9.16 min
  9.53  [Playtest] finished armtide team 0 at 9.53 min
  9.54  [Playtest] finished armfmkr team 0 at 9.54 min
  9.73  [Playtest] finished armfmkr team 0 at 9.73 min
  9.84  [Playtest] finished armtide team 0 at 9.84 min
  9.89  [Playtest] finished armfmkr team 0 at 9.89 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +28.0 bank 962/1650, energy +389.0 bank 1721/1950, units 47
 10.00  [Playtest] camera requested (4000,4800) height=5500
 10.01  [Playtest] camera captured name=ta position=(4000,4800) height=5500
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4000, 4800)
 10.06  [Playtest] finished armfmkr team 0 at 10.06 min
 10.16  [Playtest] finished armtide team 0 at 10.16 min
 10.27  [Playtest] finished armfmkr team 0 at 10.27 min
 10.43  [Playtest] finished armfmkr team 0 at 10.43 min
 10.47  [Playtest] finished armtide team 0 at 10.47 min
 10.47  [Playtest] finished armfmkr team 0 at 10.47 min
 10.64  [Playtest] finished armfmkr team 0 at 10.64 min
 10.78  [Playtest] finished armtide team 0 at 10.78 min
 10.82  [Playtest] finished armfmkr team 0 at 10.82 min
 10.99  [Playtest] finished armfmkr team 0 at 10.99 min
 10.99  [Playtest] finished armtl team 0 at 10.99 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +30.2 bank 1319/1650, energy +458.0 bank 1738/2100, units 60
 11.09  [Playtest] finished armtide team 0 at 11.09 min
 11.17  [Playtest] finished armfmkr team 0 at 11.17 min
 11.34  [Playtest] finished armfmkr team 0 at 11.34 min
 11.41  [Playtest] finished armtide team 0 at 11.41 min
 11.50  [Playtest] finished armfmkr team 0 at 11.50 min
 11.72  [Playtest] finished armfmkr team 0 at 11.72 min
 11.76  [Playtest] finished armtide team 0 at 11.76 min
 11.95  [Playtest] finished armfmkr team 0 at 11.95 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +33.2 bank 1252/1650, energy +527.0 bank 1846/2250, units 71
 12.08  [Playtest] finished armtide team 0 at 12.08 min
 12.17  [Playtest] finished armfmkr team 0 at 12.17 min
 12.37  [Playtest] finished armfmkr team 0 at 12.37 min
 12.39  [Playtest] finished armtide team 0 at 12.39 min
 12.59  [Playtest] finished armfmkr team 0 at 12.59 min
 12.71  [Playtest] finished armtide team 0 at 12.71 min
 12.76  [Playtest] finished armfmkr team 0 at 12.76 min
 12.95  [Playtest] finished armfmkr team 0 at 12.95 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +33.3 bank 1271/1650, energy +596.0 bank 2001/2400, units 79
 13.07  [Playtest] finished armtide team 0 at 13.07 min
 13.38  [Playtest] finished armtide team 0 at 13.38 min
 13.40  [Playtest] finished armtl team 0 at 13.40 min
 13.70  [Playtest] finished armtide team 0 at 13.70 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +34.6 bank 1349/1650, energy +665.0 bank 2174/2550, units 83
 14.00  [Playtest] camera requested (6500,4800) height=7000
 14.02  [Playtest] finished armtide team 0 at 14.02 min
 14.02  [Playtest] camera captured name=ta position=(6500,4800) height=7000
 14.02  [Playtest] screenshot at 14.0 min of team 0 at (6500, 4800)
 14.17  [Playtest] finished armllt team 0 at 14.17 min
 14.33  [Playtest] finished armtide team 0 at 14.33 min
 14.65  [Playtest] finished armtide team 0 at 14.65 min
 14.96  [Playtest] finished armtide team 0 at 14.96 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +36.0 bank 1634/1650, energy +757.0 bank 2370/2750, units 84
 15.22  [Playtest] finished armfmkr team 0 at 15.22 min
 15.28  [Playtest] finished armtide team 0 at 15.28 min
 15.43  [Playtest] finished armfmkr team 0 at 15.43 min
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
