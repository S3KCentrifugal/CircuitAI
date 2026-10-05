# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.1 min (frame 54116); wall 248 s
- DLL: build-theatres\d189-build-7\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T08:52:43
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-service-lanes\glacial\20261004T115243Z-b1788577\runs\20261004T115654Z-b5ab794b\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:29.111744][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.8 min | `[t=00:00:42.625410][f=0001465] [SeaWatch] finished frame=1465 id=9800 def=armsy builder=27123` |
| expect `first-ship-exit` | seen at 3.5 min | `[t=00:00:53.239150][f=0006240] [SeaWatch] egress id=10465 yard=9800 seconds=4.7 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-service-lanes\glacial\20261004T115243Z-b1788577\runs\20261004T115654Z-b5ab794b\screen_2026-10-04_11-53-47-618.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-service-lanes\glacial\20261004T115243Z-b1788577\runs\20261004T115654Z-b5ab794b\screen_2026-10-04_11-54-08-883.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-service-lanes\glacial\20261004T115243Z-b1788577\runs\20261004T115654Z-b5ab794b\screen_2026-10-04_11-55-20-811.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-service-lanes\glacial\20261004T115243Z-b1788577\runs\20261004T115654Z-b5ab794b\screen_2026-10-04_11-56-37-548.png

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
  0.10  [SEA][Layout] berth sea.berth.0 armsy at=1424,4000 facing=1
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(700,4597) factory=armsy landLocked=no spot=5 known=1/2
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(1899,5801) factory=corsy landLocked=no spot=6 known=2/2
  0.12  [SEA][Layout] berth sea.berth.1 armasy at=1424,3600 facing=1
  0.15  [Team][Roster] team 1 first mex at 704,4448
  0.15  [Playtest] finished armmex team 0 at 0.15 min
  0.17  [SEA][Layout] berth sea.berth.2 armasy at=1424,3296 facing=3
  0.17  [Team][Roster] first mex 10685 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.18  [Team][Roster] team 2 first mex at 1904,5967
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.81  [Playtest] finished armsy team 0 at 0.81 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 706/1200, energy +30.0 bank 0/1100, units 6
  1.16  [Playtest] finished armmex team 0 at 1.16 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 1002/1250, energy +30.0 bank 113/1100, units 7
  2.04  [Playtest] finished armtide team 0 at 2.05 min
  2.67  [Playtest] finished armtide team 0 at 2.67 min
  2.89  [Playtest] finished armmex team 0 at 2.89 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 1012/1300, energy +83.0 bank 81/1250, units 11
  3.04  [Playtest] finished armtide team 0 at 3.04 min
  3.48  [Playtest] finished armtide team 0 at 3.48 min
  3.79  [Playtest] finished armtide team 0 at 3.79 min
  3.81  [Playtest] finished armtide team 0 at 3.81 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 699/1300, energy +182.0 bank 1491/1500, units 16
  4.39  [Playtest] finished armtide team 0 at 4.39 min
  4.55  [Playtest] finished armfmkr team 0 at 4.55 min
  4.70  [Playtest] finished armtide team 0 at 4.70 min
  4.91  [Playtest] finished armfmkr team 0 at 4.91 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +13.0 bank 376/1300, energy +228.0 bank 1387/1600, units 23
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.01  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.23  [Playtest] finished armtide team 0 at 5.23 min
  5.27  [Playtest] finished armfmkr team 0 at 5.27 min
  5.53  [Playtest] finished armtide team 0 at 5.53 min
  5.63  [Playtest] finished armfmkr team 0 at 5.63 min
  5.71  [Playtest] finished armmex team 0 at 5.71 min
  5.84  [Playtest] finished armtide team 0 at 5.84 min
  5.96  [Playtest] finished armllt team 0 at 5.96 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +16.0 bank 227/1350, energy +297.0 bank 1643/1750, units 31
  6.14  [Playtest] finished armmex team 0 at 6.14 min
  6.15  [Playtest] finished armtide team 0 at 6.15 min
  6.34  [Playtest] finished armmex team 0 at 6.34 min
  6.42  [Playtest] finished armtide team 0 at 6.42 min
  6.51  [Playtest] finished armmex team 0 at 6.51 min
  6.80  [Playtest] finished armtide team 0 at 6.80 min
  6.83  [Playtest] finished armtide team 0 at 6.84 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +22.0 bank 192/1500, energy +389.0 bank 1508/1950, units 39
  7.00  [Playtest] finished armmex team 0 at 7.00 min
  7.17  [Playtest] finished armtide team 0 at 7.17 min
  7.21  [Playtest] finished armfmkr team 0 at 7.21 min
  7.27  [Playtest] finished armllt team 0 at 7.27 min
  7.48  [Playtest] finished armtide team 0 at 7.48 min
  7.57  [Playtest] finished armfmkr team 0 at 7.57 min
  7.79  [Playtest] finished armtide team 0 at 7.78 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +25.0 bank 516/1550, energy +458.0 bank 1738/2100, units 45
  8.00  [Playtest] finished armtide team 0 at 8.00 min
  8.17  [Playtest] finished armtide team 0 at 8.17 min
  8.31  [Playtest] finished armtide team 0 at 8.31 min
  8.47  [Playtest] finished armtide team 0 at 8.48 min
  8.73  [Playtest] finished armtide team 0 at 8.73 min
  8.97  [Playtest] finished armtide team 0 at 8.97 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +26.0 bank 945/1550, energy +603.0 bank 2366/2450, units 51
  9.14  [Playtest] finished armtide team 0 at 9.14 min
  9.31  [Playtest] finished armtide team 0 at 9.31 min
  9.37  [Playtest] finished armtide team 0 at 9.37 min
  9.45  [Playtest] finished armtide team 0 at 9.45 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +26.0 bank 1221/1550, energy +695.0 bank 2472/2650, units 57
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.02  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.16  [Playtest] finished armnanotcplat team 0 at 10.16 min
 10.23  [Playtest] finished armnanotcplat team 0 at 10.23 min
 10.33  [Playtest] finished armfmkr team 0 at 10.33 min
 10.40  [Playtest] finished armnanotcplat team 0 at 10.40 min
 10.89  [Playtest] finished armtide team 0 at 10.89 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +21.6 bank 245/1550, energy +732.0 bank 2154/2800, units 65
 11.05  [Playtest] finished armfmkr team 0 at 11.06 min
 11.09  [Playtest] finished armfmkr team 0 at 11.09 min
 11.52  [Playtest] finished armfmkr team 0 at 11.52 min
 11.79  [Playtest] finished armtide team 0 at 11.79 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +27.4 bank 16/1550, energy +755.0 bank 2409/2850, units 72
 12.01  [Playtest] finished armmex team 0 at 12.01 min
 12.21  [Playtest] finished armmex team 0 at 12.21 min
 12.50  [Playtest] finished armfrad team 0 at 12.50 min
 12.54  [Playtest] finished armtide team 0 at 12.54 min
 12.89  [Playtest] finished armtide team 0 at 12.89 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +28.3 bank 15/1550, energy +787.0 bank 2428/2850, units 68
 13.20  [Playtest] finished armtide team 0 at 13.20 min
 13.71  [Playtest] finished armfmkr team 0 at 13.71 min
 13.85  [Playtest] finished armrl team 0 at 13.85 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +25.5 bank 33/1550, energy +803.0 bank 2442/2850, units 69
 14.02  [Playtest] finished armrad team 0 at 14.02 min
 14.39  [Playtest] finished armtide team 0 at 14.39 min
 14.90  [Playtest] finished armfmkr team 0 at 14.90 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +29.1 bank 296/1550, energy +826.0 bank 2487/2900, units 71
 15.21  [Playtest] finished armfrad team 0 at 15.21 min
 15.72  [Playtest] finished armfrad team 0 at 15.72 min
 15.88  [Playtest] finished armfmkr team 0 at 15.88 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +28.8 bank 702/1550, energy +833.0 bank 2476/2950, units 74
 16.38  [Playtest] finished armtide team 0 at 16.38 min
 16.75  [Playtest] finished armtide team 0 at 16.75 min
 16.78  [Playtest] finished armfmkr team 0 at 16.78 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +29.7 bank 15/1550, energy +886.0 bank 2658/3100, units 81
 17.51  [Playtest] finished armtide team 0 at 17.51 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +25.0 bank 14/1550, energy +895.0 bank 2623/3050, units 84
 18.11  [Playtest] finished armmex team 0 at 18.11 min
 18.48  [Playtest] finished armtide team 0 at 18.48 min
 18.89  [Playtest] finished armtide team 0 at 18.89 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +30.7 bank 13/1550, energy +941.0 bank 2735/3150, units 78
 19.05  [Playtest] finished armtide team 0 at 19.05 min
 19.10  [Playtest] finished coruwmme team 0 at 19.10 min
 19.22  [Playtest] finished armtide team 0 at 19.22 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +29.8 bank 30/1600, energy +727.0 bank 1952/2250, units 68
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.02  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
 20.32  [Playtest] finished armfmkr team 0 at 20.32 min
 20.48  [Playtest] finished armfmkr team 0 at 20.48 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +31.6 bank 584/1600, energy +566.0 bank 1637/1900, units 58
 21.23  [Playtest] finished armtide team 0 at 21.23 min
 21.55  [Playtest] finished armtl team 0 at 21.55 min
 21.55  [Playtest] finished armtide team 0 at 21.55 min
 21.82  [Playtest] finished armtide team 0 at 21.82 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +29.4 bank 47/1600, energy +628.0 bank 1694/2000, units 61
 23.00  [Playtest] eco team 0 at 23.0 min: metal +27.2 bank 485/1550, energy +566.0 bank 1608/1900, units 54
 23.27  [Playtest] finished cormex team 0 at 23.27 min
 23.39  [Playtest] finished corfrad team 0 at 23.39 min
 23.40  [Playtest] finished armtide team 0 at 23.40 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +0.0 bank 500/500, energy +0.0 bank 500/500, units 0
 25.00  [Playtest] eco team 0 at 25.0 min: metal +0.0 bank 500/500, energy +0.0 bank 500/500, units 0
 26.00  [Playtest] eco team 0 at 26.0 min: metal +0.0 bank 500/500, energy +0.0 bank 500/500, units 0
 27.00  [Playtest] eco team 0 at 27.0 min: metal +0.0 bank 500/500, energy +0.0 bank 500/500, units 0
 28.00  [Playtest] eco team 0 at 28.0 min: metal +0.0 bank 500/500, energy +0.0 bank 500/500, units 0
 29.00  [Playtest] eco team 0 at 29.0 min: metal +0.0 bank 500/500, energy +0.0 bank 500/500, units 0
 29.00  [Playtest] camera requested (1700,4550) height=4000
 29.02  [Playtest] camera captured name=ta position=(1700,4550) height=4000
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (1700, 4550)
 30.00  [Playtest] eco team 0 at 30.0 min: metal +0.0 bank 500/500, energy +0.0 bank 500/500, units 0
```

## Native lines (all AIs, first 120)

```
  0.09  EXP: approach: corcom(8444) at (1899, 5801) walks to (1900, 5829), 139 from the cormex site (1904, 5968)
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
  0.10  RESERVE: zone 1 at (704, 4592) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (704, 4592) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (992, 4592) facing 1, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (488, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4664) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (488, 4600) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4600) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (488, 4536) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4536) facing 1 (id 4)
  0.10  RESERVE: zone 6 at (552, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4664) facing 1 (id 5)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 released
  0.10  RESERVE: zone 6 released
  0.10  RESERVE: zone 7 at (584, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (584, 4664) facing 1 (id 6)
  0.10  RESERVE: zone 7 released
  0.10  RESERVE: zone 8 at (568, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (568, 4696) facing 1 (id 7)
  0.10  RESERVE: zone 8 released
  0.10  RESERVE: zone 9 at (552, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4728) facing 1 (id 8)
  0.10  RESERVE: zone 10 at (552, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4664) facing 1 (id 9)
  0.10  RESERVE: zone 9 released
  0.10  RESERVE: zone 10 released
  0.10  RESERVE: zone 11 at (520, 4744) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (520, 4744) facing 1 (id 10)
  0.10  RESERVE: zone 12 at (520, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (520, 4680) facing 1 (id 11)
  0.10  RESERVE: zone 11 released
  0.10  RESERVE: zone 12 released
  0.10  RESERVE: zone 13 at (488, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4760) facing 1 (id 12)
  0.10  RESERVE: zone 14 at (488, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4696) facing 1 (id 13)
  0.10  RESERVE: zone 15 at (488, 4632) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4632) facing 1 (id 14)
  0.10  RESERVE: zone 16 at (552, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4760) facing 1 (id 15)
  0.10  RESERVE: zone 17 at (552, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4696) facing 1 (id 16)
  0.10  RESERVE: zone 13 released
  0.10  RESERVE: zone 14 released
  0.10  RESERVE: zone 15 released
  0.10  RESERVE: zone 16 released
  0.10  RESERVE: zone 17 released
  0.10  RESERVE: zone 18 at (440, 4744) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (440, 4744) facing 1 (id 17)
  0.10  RESERVE: zone 19 at (440, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (440, 4680) facing 1 (id 18)
  0.10  RESERVE: zone 20 at (440, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (440, 4616) facing 1 (id 19)
  0.10  RESERVE: zone 21 at (504, 4744) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (504, 4744) facing 1 (id 20)
  0.10  RESERVE: zone 22 at (504, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (504, 4680) facing 1 (id 21)
  0.10  RESERVE: zone 18 released
  0.10  RESERVE: zone 19 released
  0.10  RESERVE: zone 20 released
  0.10  RESERVE: zone 21 released
  0.10  RESERVE: zone 22 released
  0.10  RESERVE: zone 23 at (408, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (408, 4728) facing 1 (id 22)
  0.10  RESERVE: zone 24 at (408, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (408, 4664) facing 1 (id 23)
  0.10  RESERVE: zone 25 at (408, 4600) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (408, 4600) facing 1 (id 24)
  0.10  RESERVE: zone 26 at (472, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (472, 4728) facing 1 (id 25)
  0.10  RESERVE: zone 27 at (472, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (472, 4664) facing 1 (id 26)
  0.10  RESERVE: zone 28 at (472, 4600) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (472, 4600) facing 1 (id 27)
  0.10  RESERVE: zone 29 at (444, 4660) facing 1, 9x13 cells: 63 of 117 held
  0.10  RESERVE: zone 1 at (12928, 4000) facing 3, 6x6 cells: 36 of 36 held
  0.10  RESERVE: legsy at (12928, 4000) facing 3 (id 1)
  0.10  RESERVE: corridor 2 at (12640, 4000) facing 3, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (13160, 3944) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (13160, 3944) facing 3 (id 2)
  0.10  RESERVE: zone 4 at (13160, 4008) facing 3, 3x3 cells: 9 of 9 held
```
