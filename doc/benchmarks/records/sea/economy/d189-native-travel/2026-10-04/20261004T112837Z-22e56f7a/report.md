# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.1 min (frame 54151); wall 239 s
- DLL: build-theatres\d189-build-7\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T08:24:34
- Map: Tundra Continents v2.3.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-native-travel\tundra\20261004T112434Z-501b0212\runs\20261004T112837Z-22e56f7a\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:33.038474][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 2.6 min | `[t=00:00:55.865006][f=0004656] [SeaWatch] finished frame=4656 id=19948 def=armsy builder=24679` |
| expect `first-ship-exit` | seen at 4.9 min | `[t=00:01:05.252813][f=0008880] [SeaWatch] egress id=29246 yard=19948 seconds=10.9 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-native-travel\tundra\20261004T112434Z-501b0212\runs\20261004T112837Z-22e56f7a\screen_2026-10-04_11-25-45-365.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-native-travel\tundra\20261004T112434Z-501b0212\runs\20261004T112837Z-22e56f7a\screen_2026-10-04_11-26-08-951.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-native-travel\tundra\20261004T112434Z-501b0212\runs\20261004T112837Z-22e56f7a\screen_2026-10-04_11-27-05-446.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-native-travel\tundra\20261004T112434Z-501b0212\runs\20261004T112837Z-22e56f7a\screen_2026-10-04_11-28-24-522.png

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
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(5331,792) factory=armsy landLocked=no spot=4 known=1/3
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(6399,801) factory=corsy landLocked=no spot=5 known=2/3
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(7820,1503) factory=legsy landLocked=no spot=6 known=3/3
  0.12  [SEA][Layout] berth sea.berth.1 armasy at=4496,2096 facing=0
  0.13  [SEA][Layout] berth sea.berth.2 armasy at=4896,2096 facing=0
  0.17  [Team][Roster] team 2 first mex at 6384,720
  0.21  [Playtest] finished armmex team 0 at 0.21 min
  0.22  [Team][Roster] first mex 21142 at 4016,2016
  0.22  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4100|2097|0|3|1|4016|2016
  0.22  [Team][Roster] team 1 first mex at 5136,752
  0.45  [Team][Roster] team 3 first mex at 7984,1504
  0.87  [Playtest] finished armmex team 0 at 0.87 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +9.1 bank 946/1100, energy +30.0 bank 238/1000, units 5
  1.81  [Playtest] finished armtl team 0 at 1.81 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.0 bank 1094/1100, energy +30.0 bank 266/1000, units 4
  2.24  [Playtest] finished armtide team 0 at 2.24 min
  2.59  [Playtest] finished armsy team 0 at 2.59 min
  2.90  [Playtest] finished armmex team 0 at 2.90 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 1234/1250, energy +45.0 bank 0/1150, units 9
  3.57  [Playtest] finished armtl team 0 at 3.57 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +8.0 bank 1239/1250, energy +45.0 bank 2/1150, units 10
  4.08  [Playtest] finished armfrad team 0 at 4.08 min
  4.41  [Playtest] finished armtide team 0 at 4.41 min
  4.57  [SEA][Layout] berth sea.berth.3 armsy at=4288,2096 facing=0
  5.00  [Playtest] eco team 0 at 5.0 min: metal +10.7 bank 1240/1250, energy +67.0 bank 137/1250, units 14
  5.00  [Playtest] target team 0 at (4100, 2100) from its start position
  5.00  [Playtest] camera requested (4100,2100) height=2200
  5.01  [Playtest] camera captured name=ta position=(4100,2100) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (4100, 2100)
  5.56  [Playtest] finished armmex team 0 at 5.56 min
  5.65  [Playtest] finished armtide team 0 at 5.65 min
  5.71  [Playtest] finished armtide team 0 at 5.71 min
  5.98  [Playtest] finished armtide team 0 at 5.98 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +10.0 bank 1241/1300, energy +104.0 bank 594/1450, units 19
  6.23  [Playtest] finished armmex team 0 at 6.23 min
  6.26  [Playtest] finished armmstor team 0 at 6.26 min
  6.31  [Playtest] finished armtide team 0 at 6.31 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +10.0 bank 740/4300, energy +141.0 bank 1489/1550, units 23
  7.02  [Playtest] finished armmex team 0 at 7.02 min
  7.12  [Playtest] finished armtl team 0 at 7.12 min
  7.30  [Playtest] finished armmex team 0 at 7.30 min
  7.56  [Playtest] finished armtl team 0 at 7.56 min
  7.70  [Playtest] finished armtide team 0 at 7.70 min
  7.76  [Playtest] finished armtide team 0 at 7.76 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +14.0 bank 418/4400, energy +164.0 bank 1563/1600, units 28
  8.04  [Playtest] finished armtide team 0 at 8.04 min
  8.41  [Playtest] finished armtide team 0 at 8.41 min
  8.78  [Playtest] finished armtide team 0 at 8.78 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +14.0 bank 459/4400, energy +202.0 bank 1201/1700, units 28
  9.47  [Playtest] finished armtide team 0 at 9.47 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +14.7 bank 752/4350, energy +217.0 bank 1744/1750, units 27
 10.00  [Playtest] camera requested (4100,2100) height=2200
 10.02  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (4100, 2100)
 11.00  [Playtest] eco team 0 at 11.0 min: metal +8.0 bank 1064/4150, energy +45.0 bank 83/1000, units 6
 12.00  [Playtest] eco team 0 at 12.0 min: metal +8.0 bank 1103/4150, energy +30.0 bank 688/1000, units 7
 12.01  [Playtest] finished armsy team 0 at 12.01 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +8.0 bank 1298/4250, energy +30.0 bank 108/1100, units 8
 13.77  [SEA][Layout] berth sea.berth.4 legsy at=4192,2096 facing=0
 13.87  [SEA][Layout] berth sea.berth.5 legsy at=4000,2096 facing=0
 14.00  [Playtest] eco team 0 at 14.0 min: metal +4.0 bank 1734/3600, energy +5.0 bank 543/550, units 5
 15.00  [Playtest] eco team 0 at 15.0 min: metal +0.0 bank 495/500, energy +0.0 bank 495/500, units 0
 16.00  [Playtest] eco team 0 at 16.0 min: metal +0.0 bank 495/500, energy +0.0 bank 495/500, units 0
 17.00  [Playtest] eco team 0 at 17.0 min: metal +0.0 bank 495/500, energy +0.0 bank 475/500, units 0
 18.00  [Playtest] eco team 0 at 18.0 min: metal +0.0 bank 495/500, energy +0.0 bank 475/500, units 0
 19.00  [Playtest] eco team 0 at 19.0 min: metal +0.0 bank 495/500, energy +0.0 bank 475/500, units 0
 20.00  [Playtest] eco team 0 at 20.0 min: metal +0.0 bank 495/500, energy +0.0 bank 475/500, units 0
 20.00  [Playtest] camera requested (4100,2100) height=2200
 20.01  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (4100, 2100)
 21.00  [Playtest] eco team 0 at 21.0 min: metal +0.0 bank 495/500, energy +0.0 bank 475/500, units 0
 22.00  [Playtest] eco team 0 at 22.0 min: metal +0.0 bank 495/500, energy +0.0 bank 475/500, units 0
 23.00  [Playtest] eco team 0 at 23.0 min: metal +0.0 bank 495/500, energy +0.0 bank 475/500, units 0
 24.00  [Playtest] eco team 0 at 24.0 min: metal +0.0 bank 495/500, energy +0.0 bank 475/500, units 0
 25.00  [Playtest] eco team 0 at 25.0 min: metal +0.0 bank 495/500, energy +0.0 bank 475/500, units 0
 26.00  [Playtest] eco team 0 at 26.0 min: metal +0.0 bank 495/500, energy +0.0 bank 475/500, units 0
 27.00  [Playtest] eco team 0 at 27.0 min: metal +0.0 bank 495/500, energy +0.0 bank 475/500, units 0
 28.00  [Playtest] eco team 0 at 28.0 min: metal +0.0 bank 495/500, energy +0.0 bank 475/500, units 0
 29.00  [Playtest] eco team 0 at 29.0 min: metal +0.0 bank 495/500, energy +0.0 bank 475/500, units 0
 29.00  [Playtest] camera requested (4100,2100) height=2200
 29.01  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 29.01  [Playtest] screenshot at 29.0 min of team 0 at (4100, 2100)
 30.00  [Playtest] eco team 0 at 30.0 min: metal +0.0 bank 495/500, energy +0.0 bank 475/500, units 0
```

## Native lines (all AIs, first 120)

```
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
  0.10  RESERVE: zone 1 at (6800, 10608) facing 2, 6x6 cells: 36 of 36 held
  0.10  RESERVE: legsy at (6800, 10608) facing 2 (id 1)
  0.10  RESERVE: corridor 2 at (6800, 10320) facing 2, 12x30 cells: 360 of 360 held
  0.10  RESERVE: zone 3 at (6872, 10840) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6872, 10840) facing 2 (id 2)
  0.10  RESERVE: zone 4 at (6808, 10840) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6808, 10840) facing 2 (id 3)
  0.10  RESERVE: zone 5 at (6744, 10840) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6744, 10840) facing 2 (id 4)
  0.10  RESERVE: zone 6 at (6872, 10776) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6872, 10776) facing 2 (id 5)
  0.10  RESERVE: zone 7 at (6808, 10776) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6808, 10776) facing 2 (id 6)
  0.10  RESERVE: zone 8 at (6744, 10776) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (6744, 10776) facing 2 (id 7)
  0.10  RESERVE: zone 9 at (6800, 10800) facing 2, 12x8 cells: 42 of 96 held
  0.10  RESERVE: zone 1 at (8208, 10896) facing 2, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (8208, 10896) facing 2 (id 1)
  0.10  RESERVE: corridor 2 at (8208, 10608) facing 2, 12x30 cells: 360 of 360 held
  0.10  RESERVE: zone 3 at (8376, 11128) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8376, 11128) facing 2 (id 2)
  0.10  RESERVE: zone 4 at (8312, 11128) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8312, 11128) facing 2 (id 3)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 at (8360, 11160) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8360, 11160) facing 2 (id 4)
  0.10  RESERVE: zone 5 released
  0.10  RESERVE: zone 6 at (8344, 11192) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8344, 11192) facing 2 (id 5)
  0.10  RESERVE: zone 6 released
  0.10  RESERVE: zone 7 at (8312, 11208) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8312, 11208) facing 2 (id 6)
  0.10  RESERVE: zone 7 released
  0.10  RESERVE: zone 8 at (8280, 11224) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8280, 11224) facing 2 (id 7)
  0.10  RESERVE: zone 9 at (8216, 11224) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8216, 11224) facing 2 (id 8)
  0.10  RESERVE: zone 10 at (8152, 11224) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8152, 11224) facing 2 (id 9)
  0.10  RESERVE: zone 8 released
  0.10  RESERVE: zone 9 released
  0.10  RESERVE: zone 10 released
  0.10  RESERVE: zone 11 at (8200, 11192) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8200, 11192) facing 2 (id 10)
  0.10  RESERVE: zone 12 at (8136, 11192) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8136, 11192) facing 2 (id 11)
  0.10  RESERVE: zone 13 at (8072, 11192) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8072, 11192) facing 2 (id 12)
  0.10  RESERVE: zone 14 at (8200, 11128) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8200, 11128) facing 2 (id 13)
  0.10  RESERVE: zone 15 at (8136, 11128) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8136, 11128) facing 2 (id 14)
  0.10  RESERVE: zone 16 at (8072, 11128) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (8072, 11128) facing 2 (id 15)
  0.10  RESERVE: zone 17 at (8140, 11156) facing 2, 13x9 cells: 59 of 117 held
  0.10  RESERVE: zone 1 at (9056, 11424) facing 2, 6x6 cells: 36 of 36 held
  0.10  RESERVE: corsy at (9056, 11424) facing 2 (id 1)
  0.10  RESERVE: corridor 2 at (9056, 11136) facing 2, 12x30 cells: 360 of 360 held
  0.10  RESERVE: zone 3 at (9128, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9128, 11656) facing 2 (id 2)
  0.10  RESERVE: zone 4 at (9064, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9064, 11656) facing 2 (id 3)
  0.10  RESERVE: zone 5 at (9000, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9000, 11656) facing 2 (id 4)
  0.10  RESERVE: zone 6 at (9128, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9128, 11592) facing 2 (id 5)
  0.10  RESERVE: zone 7 at (9064, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9064, 11592) facing 2 (id 6)
  0.10  RESERVE: zone 8 at (9000, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: cornanotcplat at (9000, 11592) facing 2 (id 7)
  0.10  RESERVE: zone 9 at (9056, 11616) facing 2, 12x8 cells: 42 of 96 held
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
```
