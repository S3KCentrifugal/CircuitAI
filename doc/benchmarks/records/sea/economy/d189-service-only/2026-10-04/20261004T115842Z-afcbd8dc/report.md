# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.1 min (frame 54245); wall 265 s
- DLL: build-theatres\d189-build-7\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T08:54:14
- Map: Tundra Continents v2.3.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-service-only\tundra\20261004T115414Z-688ef9e6\runs\20261004T115842Z-afcbd8dc\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:35.329388][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.6 min | `[t=00:00:53.456782][f=0001104] [SeaWatch] finished frame=1104 id=3076 def=armsy builder=24679` |
| expect `first-ship-exit` | seen at 2.1 min | `[t=00:00:59.852385][f=0003780] [SeaWatch] egress id=18500 yard=3076 seconds=9.1 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-service-only\tundra\20261004T115414Z-688ef9e6\runs\20261004T115842Z-afcbd8dc\screen_2026-10-04_11-55-30-815.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-service-only\tundra\20261004T115414Z-688ef9e6\runs\20261004T115842Z-afcbd8dc\screen_2026-10-04_11-55-55-931.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-service-only\tundra\20261004T115414Z-688ef9e6\runs\20261004T115842Z-afcbd8dc\screen_2026-10-04_11-57-18-317.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-service-only\tundra\20261004T115414Z-688ef9e6\runs\20261004T115842Z-afcbd8dc\screen_2026-10-04_11-58-30-443.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4100, 2100) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (5400, 800) units 1
  0.00  [Playtest] frame 1 team 2 ally 0 side cortex ai true dead false start (6400, 800) units 1
  0.00  [Playtest] frame 1 team 3 ally 0 side legion ai true dead false start (7800, 1500) units 1
  0.00  [Playtest] frame 1 team 4 ally 1 side armada ai true dead false start (1504, 12000) units 1
  0.00  [Playtest] frame 1 team 5 ally 1 side cortex ai true dead false start (1610, 10300) units 1
  0.00  [Playtest] frame 1 team 6 ally 1 side legion ai true dead false start (6700, 10600) units 1
  0.00  [Playtest] frame 1 team 7 ally 1 side armada ai true dead false start (8200, 10900) units 1
  0.00  [Playtest] frame 1 team 8 ally 1 side cortex ai true dead false start (9000, 11400) units 1
  0.00  [Playtest] frame 1 team 9 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 10 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4100, 2100) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (5400, 800) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (6400, 800) units 1
  0.05  [Playtest] frame 90 team 3 ally 0 side legion ai true dead false start (7800, 1500) units 1
  0.05  [Playtest] frame 90 team 4 ally 1 side armada ai true dead false start (1504, 12000) units 1
  0.05  [Playtest] frame 90 team 5 ally 1 side cortex ai true dead false start (1610, 10300) units 1
  0.05  [Playtest] frame 90 team 6 ally 1 side legion ai true dead false start (6700, 10600) units 1
  0.05  [Playtest] frame 90 team 7 ally 1 side armada ai true dead false start (8200, 10900) units 1
  0.05  [Playtest] frame 90 team 8 ally 1 side cortex ai true dead false start (9000, 11400) units 1
  0.05  [Playtest] frame 90 team 9 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 10 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.10  [SEA][Layout] berth sea.berth.0 armsy at=4096,2096 facing=0
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|4100|2097|0|3|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(5340,795) factory=armsy landLocked=no spot=4 known=1/3
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(6399,801) factory=corsy landLocked=no spot=5 known=2/3
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(7816,1505) factory=legsy landLocked=no spot=6 known=3/3
  0.12  [SEA][Layout] berth sea.berth.1 armasy at=4496,2096 facing=0
  0.13  [SEA][Layout] berth sea.berth.2 armasy at=4896,2096 facing=0
  0.16  [Playtest] finished armmex team 0 at 0.16 min
  0.17  [Team][Roster] first mex 21142 at 4016,2016
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4100|2097|0|3|1|4016|2016
  0.18  [Team][Roster] team 2 first mex at 6384,720
  0.22  [Team][Roster] team 3 first mex at 7984,1504
  0.28  [Team][Roster] team 1 first mex at 5136,752
  0.61  [Playtest] finished armsy team 0 at 0.61 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.0 bank 616/1150, energy +30.0 bank 66/1100, units 5
  1.11  [Playtest] finished armtide team 0 at 1.12 min
  1.47  [Playtest] finished armmex team 0 at 1.47 min
  1.82  [Playtest] finished armmex team 0 at 1.82 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 649/1250, energy +52.0 bank 110/1200, units 8
  2.27  [Playtest] finished armtide team 0 at 2.27 min
  2.46  [Playtest] finished armtide team 0 at 2.46 min
  2.55  [Playtest] finished armmex team 0 at 2.55 min
  2.69  [Playtest] finished armtide team 0 at 2.69 min
  2.88  [Playtest] finished armmex team 0 at 2.88 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +12.0 bank 873/1350, energy +104.0 bank 407/1400, units 14
  3.47  [Playtest] finished armmex team 0 at 3.47 min
  3.48  [Playtest] finished armmex team 0 at 3.48 min
  3.60  [Playtest] finished armmex team 0 at 3.60 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +18.0 bank 1074/1500, energy +104.0 bank 99/1400, units 19
  4.04  [Playtest] finished armmex team 0 at 4.05 min
  4.40  [Playtest] finished armtl team 0 at 4.40 min
  4.65  [Playtest] finished armmex team 0 at 4.65 min
  4.85  [Playtest] finished armtide team 0 at 4.85 min
  4.97  [Playtest] finished armmex team 0 at 4.97 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +24.0 bank 1269/1650, energy +119.0 bank 219/1450, units 24
  5.00  [Playtest] target team 0 at (4100, 2100) from its start position
  5.00  [Playtest] camera requested (4100,2100) height=2200
  5.01  [Playtest] camera captured name=ta position=(4100,2100) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (4100, 2100)
  5.53  [Playtest] finished armmex team 0 at 5.53 min
  5.64  [Playtest] finished armmex team 0 at 5.64 min
  5.85  [Playtest] finished armllt team 0 at 5.85 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +28.0 bank 1465/1750, energy +119.0 bank 484/1450, units 27
  6.42  [Playtest] finished armmex team 0 at 6.43 min
  6.94  [Playtest] finished armmex team 0 at 6.94 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +31.9 bank 1849/1850, energy +119.0 bank 1266/1450, units 30
  7.19  [Playtest] finished armtide team 0 at 7.19 min
  7.29  [Playtest] finished armmex team 0 at 7.29 min
  7.31  [Playtest] finished armtl team 0 at 7.31 min
  7.98  [Playtest] finished armmex team 0 at 7.98 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +34.9 bank 1946/1950, energy +134.0 bank 1148/1500, units 35
  8.01  [Playtest] finished armtl team 0 at 8.01 min
  8.50  [Playtest] finished armtl team 0 at 8.50 min
  8.96  [Playtest] finished armtl team 0 at 8.97 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +33.9 bank 1897/1900, energy +134.0 bank 1456/1500, units 37
  9.72  [Playtest] finished armmex team 0 at 9.72 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +30.0 bank 1781/1800, energy +134.0 bank 1341/1500, units 37
 10.00  [Playtest] camera requested (4100,2100) height=2200
 10.02  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (4100, 2100)
 10.06  [Playtest] finished armmex team 0 at 10.06 min
 10.14  [Playtest] finished armtl team 0 at 10.14 min
 10.25  [Playtest] finished armtide team 0 at 10.25 min
 10.37  [Playtest] finished armmex team 0 at 10.37 min
 10.60  [Playtest] finished armtide team 0 at 10.60 min
 10.92  [Playtest] finished armtide team 0 at 10.92 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +33.9 bank 1892/1900, energy +179.0 bank 1604/1650, units 41
 11.01  [Playtest] finished armmex team 0 at 11.01 min
 11.24  [Playtest] finished armtide team 0 at 11.24 min
 11.35  [Playtest] finished armmex team 0 at 11.35 min
 11.56  [Playtest] finished armtide team 0 at 11.56 min
 11.68  [Playtest] finished armmex team 0 at 11.68 min
 11.88  [Playtest] finished armtide team 0 at 11.88 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +37.9 bank 1549/1550, energy +201.0 bank 1345/1350, units 45
 12.26  [Playtest] finished armtide team 0 at 12.26 min
 12.32  [Playtest] finished armmex team 0 at 12.32 min
 12.67  [Playtest] finished armtide team 0 at 12.67 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +39.9 bank 1370/1600, energy +245.0 bank 1543/1550, units 52
 13.04  [Playtest] finished armtide team 0 at 13.04 min
 13.05  [Playtest] finished armtide team 0 at 13.05 min
 13.35  [Playtest] finished armtide team 0 at 13.35 min
 13.41  [Playtest] finished armtide team 0 at 13.41 min
 13.56  [Playtest] finished armtl team 0 at 13.56 min
 13.80  [Playtest] finished armtide team 0 at 13.80 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +39.9 bank 1329/1600, energy +313.0 bank 1734/1750, units 56
 14.20  [Playtest] finished armnanotcplat team 0 at 14.20 min
 14.39  [Playtest] finished armnanotcplat team 0 at 14.39 min
 14.52  [Playtest] finished armtide team 0 at 14.52 min
 14.60  [Playtest] finished armtide team 0 at 14.60 min
 14.68  [Playtest] finished armtide team 0 at 14.68 min
 14.79  [Playtest] finished armtide team 0 at 14.79 min
 14.94  [Playtest] finished armtide team 0 at 14.94 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +39.9 bank 1276/1600, energy +395.0 bank 1985/2050, units 65
 15.23  [Playtest] finished armtide team 0 at 15.23 min
 15.26  [Playtest] finished armtide team 0 at 15.26 min
 15.53  [Playtest] finished armtl team 0 at 15.53 min
 15.64  [Playtest] finished armtide team 0 at 15.64 min
 15.78  [Playtest] finished armtide team 0 at 15.78 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +39.9 bank 1276/1600, energy +455.0 bank 2210/2250, units 71
 16.11  [Playtest] finished armtl team 0 at 16.11 min
 16.18  [Playtest] finished armtide team 0 at 16.17 min
 16.20  [Playtest] finished armtide team 0 at 16.20 min
 16.78  [Playtest] finished armtl team 0 at 16.78 min
 16.81  [Playtest] finished armtide team 0 at 16.81 min
 16.86  [Playtest] finished armtide team 0 at 16.86 min
 16.98  [Playtest] finished armtl team 0 at 16.98 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +39.9 bank 1008/1600, energy +522.0 bank 2485/2500, units 81
 17.13  [Playtest] finished armtide team 0 at 17.13 min
 17.18  [Playtest] finished armtide team 0 at 17.18 min
 17.46  [Playtest] finished armtide team 0 at 17.46 min
 17.50  [Playtest] finished armtide team 0 at 17.50 min
 17.78  [Playtest] finished armtide team 0 at 17.78 min
 17.83  [Playtest] finished armtide team 0 at 17.83 min
 17.99  [Playtest] finished armtl team 0 at 17.99 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +39.9 bank 717/1600, energy +612.0 bank 2787/2800, units 86
 18.11  [Playtest] finished armtide team 0 at 18.11 min
 18.18  [Playtest] finished armtide team 0 at 18.18 min
 18.55  [Playtest] finished armtide team 0 at 18.55 min
 18.89  [Playtest] finished armtide team 0 at 18.89 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +35.9 bank 275/1500, energy +665.0 bank 2896/2950, units 85
 19.23  [Playtest] finished armtide team 0 at 19.23 min
 19.56  [Playtest] finished armtide team 0 at 19.56 min
 19.83  [Playtest] finished armtide team 0 at 19.83 min
 19.94  [Playtest] finished armtide team 0 at 19.94 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +29.9 bank 11/1350, energy +718.0 bank 3091/3100, units 84
 20.00  [Playtest] camera requested (4100,2100) height=2200
 20.00  [Playtest] finished armtide team 0 at 20.00 min
 20.01  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (4100, 2100)
 20.22  [Playtest] finished armtide team 0 at 20.22 min
 20.58  [Playtest] finished armtide team 0 at 20.58 min
 20.78  [Playtest] finished armtide team 0 at 20.78 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +26.0 bank 73/1250, energy +727.0 bank 3050/3050, units 76
 21.83  [SEA][Layout] berth sea.berth.3 armsy at=4192,2096 facing=0
 22.00  [Playtest] eco team 0 at 22.0 min: metal +24.0 bank 571/1100, energy +172.0 bank 1050/1050, units 32
 23.00  [Playtest] eco team 0 at 23.0 min: metal +16.0 bank 740/900, energy +7.0 bank 527/550, units 15
 24.00  [Playtest] eco team 0 at 24.0 min: metal +10.0 bank 586/750, energy +0.0 bank 378/500, units 8
 25.00  [Playtest] eco team 0 at 25.0 min: metal +10.0 bank 585/750, energy +0.0 bank 405/500, units 8
 26.00  [Playtest] eco team 0 at 26.0 min: metal +10.0 bank 584/750, energy +0.0 bank 193/500, units 8
 27.00  [Playtest] eco team 0 at 27.0 min: metal +0.0 bank 500/500, energy +0.0 bank 1/500, units 0
 28.00  [Playtest] eco team 0 at 28.0 min: metal +0.0 bank 500/500, energy +0.0 bank 1/500, units 0
 29.00  [Playtest] eco team 0 at 29.0 min: metal +0.0 bank 500/500, energy +0.0 bank 1/500, units 0
 29.00  [Playtest] camera requested (4100,2100) height=2200
 29.01  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 29.01  [Playtest] screenshot at 29.0 min of team 0 at (4100, 2100)
 30.00  [Playtest] eco team 0 at 30.0 min: metal +0.0 bank 500/500, energy +0.0 bank 1/500, units 0
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(891) at (5340, 795) walks to (5269, 780), 136 from the armmex site (5136, 752)
  0.09  EXP: approach: legcom(28578) at (7816, 1505) walks to (7847, 1505), 137 from the legmex site (7984, 1504)
  0.09  EXP: approach: corcom(22737) at (9045, 11418) walks to (9370, 11502), 139 from the cormex site (9504, 11536)
  0.10  RESERVE: zone 1 at (4096, 2096) facing 0, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (4096, 2096) facing 0 (id 1)
  0.10  RESERVE: corridor 2 at (4096, 2384) facing 0, 12x30 cells: 356 of 360 held
  0.10  RESERVE: zone 3 at (4040, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4040, 1880) facing 0 (id 2)
  0.10  RESERVE: zone 4 at (4104, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4104, 1880) facing 0 (id 3)
  0.10  RESERVE: zone 5 at (4168, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4168, 1880) facing 0 (id 4)
  0.10  RESERVE: zone 6 at (4040, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4040, 1944) facing 0 (id 5)
  0.10  RESERVE: zone 7 at (4104, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4104, 1944) facing 0 (id 6)
  0.10  RESERVE: zone 8 at (4168, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4168, 1944) facing 0 (id 7)
  0.10  RESERVE: zone 9 at (4096, 1904) facing 0, 12x8 cells: 42 of 96 held
  0.10  RESERVE: zone 1 at (7824, 1504) facing 0, 6x6 cells: 36 of 36 held
  0.10  RESERVE: legsy at (7824, 1504) facing 0 (id 1)
  0.10  RESERVE: corridor 2 at (7824, 1792) facing 0, 12x30 cells: 348 of 360 held
  0.10  RESERVE: zone 3 at (7768, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7768, 1288) facing 0 (id 2)
  0.10  RESERVE: zone 4 at (7832, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7832, 1288) facing 0 (id 3)
  0.10  RESERVE: zone 5 at (7896, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7896, 1288) facing 0 (id 4)
  0.10  RESERVE: zone 6 at (7768, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7768, 1352) facing 0 (id 5)
  0.10  RESERVE: zone 7 at (7832, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7832, 1352) facing 0 (id 6)
  0.10  RESERVE: zone 8 at (7896, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7896, 1352) facing 0 (id 7)
  0.10  RESERVE: zone 9 at (7824, 1312) facing 0, 12x8 cells: 42 of 96 held
  0.10  RESERVE: zone 1 at (9040, 11424) facing 2, 6x6 cells: 36 of 36 held
  0.10  RESERVE: corsy at (9040, 11424) facing 2 (id 1)
  0.10  RESERVE: corridor 2 at (9040, 11136) facing 2, 12x30 cells: 360 of 360 held
  0.10  RESERVE: zone 3 at (9112, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9112, 11656) facing 2 (id 2)
  0.10  RESERVE: zone 4 at (9048, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9048, 11656) facing 2 (id 3)
  0.10  RESERVE: zone 5 at (8984, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (8984, 11656) facing 2 (id 4)
  0.10  RESERVE: zone 6 at (9112, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9112, 11592) facing 2 (id 5)
  0.10  RESERVE: zone 7 at (9048, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9048, 11592) facing 2 (id 6)
  0.10  RESERVE: zone 8 at (8984, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (8984, 11592) facing 2 (id 7)
  0.10  RESERVE: zone 9 at (9040, 11616) facing 2, 12x8 cells: 42 of 96 held
  0.12  EXP: idle: legcom(28578) on legmex at (7839, 1505), site (7984, 1504), target yes, fails 2 (arrived at the approach point)
  0.12  RESERVE: zone 10 at (4496, 2096) facing 0, 12x12 cells: 144 of 144 held
  0.12  RESERVE: armasy at (4496, 2096) facing 0 (id 8)
  0.12  RESERVE: corridor 11 at (4496, 2432) facing 0, 18x30 cells: 540 of 540 held
  0.12  RESERVE: zone 12 at (4536, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (4536, 1880) facing 0 (id 9)
  0.12  RESERVE: zone 13 at (4600, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (4600, 1880) facing 0 (id 10)
  0.12  RESERVE: zone 14 at (4664, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (4664, 1880) facing 0 (id 11)
  0.12  RESERVE: zone 15 at (4536, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (4536, 1944) facing 0 (id 12)
  0.12  RESERVE: zone 16 at (4600, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (4600, 1944) facing 0 (id 13)
  0.12  RESERVE: zone 17 at (4664, 1944) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armnanotcplat at (4664, 1944) facing 0 (id 14)
  0.12  RESERVE: zone 18 at (4592, 1904) facing 0, 12x8 cells: 42 of 96 held
  0.12  RESERVE: zone 10 at (8224, 1504) facing 0, 12x12 cells: 144 of 144 held
  0.12  RESERVE: legadvshipyard at (8224, 1504) facing 0 (id 8)
  0.12  RESERVE: corridor 11 at (8224, 1840) facing 0, 18x30 cells: 540 of 540 held
  0.12  RESERVE: zone 12 at (8264, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8264, 1288) facing 0 (id 9)
  0.12  RESERVE: zone 13 at (8328, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8328, 1288) facing 0 (id 10)
  0.12  RESERVE: zone 14 at (8392, 1288) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8392, 1288) facing 0 (id 11)
  0.12  RESERVE: zone 15 at (8264, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8264, 1352) facing 0 (id 12)
  0.12  RESERVE: zone 16 at (8328, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8328, 1352) facing 0 (id 13)
  0.12  RESERVE: zone 17 at (8392, 1352) facing 0, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (8392, 1352) facing 0 (id 14)
  0.12  RESERVE: zone 18 at (8320, 1312) facing 0, 12x8 cells: 42 of 96 held
  0.12  RESERVE: zone 10 at (8640, 11424) facing 2, 12x12 cells: 144 of 144 held
  0.12  RESERVE: corasy at (8640, 11424) facing 2 (id 8)
  0.12  RESERVE: corridor 11 at (8640, 11088) facing 2, 18x30 cells: 540 of 540 held
  0.12  RESERVE: zone 12 at (8808, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cornanotcplat at (8808, 11656) facing 2 (id 9)
  0.12  RESERVE: zone 13 at (8744, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cornanotcplat at (8744, 11656) facing 2 (id 10)
  0.12  RESERVE: zone 14 at (8680, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cornanotcplat at (8680, 11656) facing 2 (id 11)
  0.12  RESERVE: zone 15 at (8808, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cornanotcplat at (8808, 11592) facing 2 (id 12)
  0.12  RESERVE: zone 16 at (8744, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cornanotcplat at (8744, 11592) facing 2 (id 13)
  0.12  RESERVE: zone 17 at (8680, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cornanotcplat at (8680, 11592) facing 2 (id 14)
  0.12  RESERVE: zone 18 at (8736, 11616) facing 2, 12x8 cells: 42 of 96 held
  0.13  RESERVE: zone 19 at (4896, 2096) facing 0, 12x12 cells: 144 of 144 held
  0.13  RESERVE: armasy at (4896, 2096) facing 0 (id 15)
  0.13  RESERVE: corridor 20 at (4896, 2432) facing 0, 18x30 cells: 540 of 540 held
  0.13  RESERVE: zone 21 at (4920, 1912) facing 0, 3x3 cells: 9 of 9 held
  0.13  RESERVE: armnanotcplat at (4920, 1912) facing 0 (id 16)
  0.13  RESERVE: zone 22 at (4984, 1912) facing 0, 3x3 cells: 9 of 9 held
  0.13  RESERVE: armnanotcplat at (4984, 1912) facing 0 (id 17)
  0.13  RESERVE: zone 23 at (5048, 1912) facing 0, 3x3 cells: 9 of 9 held
  0.13  RESERVE: armnanotcplat at (5048, 1912) facing 0 (id 18)
  0.13  RESERVE: zone 24 at (4920, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.13  RESERVE: armnanotcplat at (4920, 1976) facing 0 (id 19)
  0.13  RESERVE: zone 25 at (4984, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.13  RESERVE: armnanotcplat at (4984, 1976) facing 0 (id 20)
  0.13  RESERVE: zone 26 at (5048, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.13  RESERVE: armnanotcplat at (5048, 1976) facing 0 (id 21)
  0.13  RESERVE: zone 27 at (4985, 1941) facing 0, 13x9 cells: 56 of 117 held
  0.14  RESERVE: zone 19 at (8240, 11424) facing 2, 12x12 cells: 144 of 144 held
  0.14  RESERVE: corasy at (8240, 11424) facing 2 (id 15)
  0.14  RESERVE: corridor 20 at (8240, 11088) facing 2, 18x30 cells: 516 of 540 held
  0.14  RESERVE: zone 21 at (8392, 11688) facing 2, 3x3 cells: 9 of 9 held
```
