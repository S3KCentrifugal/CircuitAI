# Playtest report: PASS

- Verdict: **PASS** (reached 20 min)
- Game time reached: 20.0 min (frame 36004); wall 138 s
- DLL: build-theatres\d190-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T11:23:44
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\glacial\20261004T142344Z-43e6982d\runs\20261004T142605Z-6ddb1ba4\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:32.505303][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.8 min | `[t=00:00:45.427224][f=0001465] [SeaWatch] finished frame=1465 id=9800 def=armsy builder=27123` |
| expect `first-ship-exit` | seen at 2.5 min | `[t=00:00:52.372827][f=0004590] [SeaWatch] egress id=11953 yard=9800 seconds=4.3 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\glacial\20261004T142344Z-43e6982d\runs\20261004T142605Z-6ddb1ba4\screen_2026-10-04_14-24-51-211.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\glacial\20261004T142344Z-43e6982d\runs\20261004T142605Z-6ddb1ba4\screen_2026-10-04_14-25-12-395.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\glacial\20261004T142344Z-43e6982d\runs\20261004T142605Z-6ddb1ba4\screen_2026-10-04_14-26-05-019.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 20.5 min
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
  0.17  [Team][Roster] team 2 first mex at 1904,5967
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.81  [Playtest] finished armsy team 0 at 0.81 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 715/1200, energy +30.0 bank 97/1100, units 5
  1.26  [Playtest] finished armtide team 0 at 1.26 min
  1.44  [Playtest] finished armtide team 0 at 1.44 min
  1.60  [Playtest] finished armtide team 0 at 1.60 min
  1.84  [Playtest] finished armtide team 0 at 1.84 min
  1.96  [Playtest] finished armmex team 0 at 1.96 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 388/1250, energy +129.0 bank 188/1350, units 12
  2.11  [Playtest] finished armtide team 0 at 2.11 min
  2.41  [Playtest] finished armmex team 0 at 2.41 min
  2.54  [Playtest] finished armtide team 0 at 2.54 min
  2.99  [Playtest] finished armfmkr team 0 at 2.99 min
  3.00  [Playtest] finished armfmkr team 0 at 3.00 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 389/1300, energy +182.0 bank 1028/1500, units 18
  3.15  [Playtest] finished armfrad team 0 at 3.15 min
  3.72  [Playtest] finished armtide team 0 at 3.72 min
  3.94  [Playtest] finished armtide team 0 at 3.94 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +12.0 bank 0/1300, energy +228.0 bank 1275/1600, units 24
  4.24  [Playtest] finished armtide team 0 at 4.24 min
  4.39  [Playtest] finished armtide team 0 at 4.39 min
  4.55  [Playtest] finished armtide team 0 at 4.55 min
  4.90  [Playtest] finished armtide team 0 at 4.90 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +12.0 bank 153/1300, energy +320.0 bank 1755/1800, units 29
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.00  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.16  [Playtest] finished armfmkr team 0 at 5.16 min
  5.73  [Playtest] finished armtide team 0 at 5.73 min
  5.79  [Playtest] finished armtide team 0 at 5.79 min
  5.81  [Playtest] finished armmex team 0 at 5.81 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +15.0 bank 82/1350, energy +366.0 bank 1818/1900, units 34
  6.12  [Playtest] finished armtide team 0 at 6.12 min
  6.21  [Playtest] finished armfmkr team 0 at 6.21 min
  6.60  [Playtest] finished armtide team 0 at 6.60 min
  6.73  [Playtest] finished armtide team 0 at 6.73 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +16.0 bank 180/1350, energy +435.0 bank 1968/2050, units 37
  7.06  [Playtest] finished armfmkr team 0 at 7.06 min
  7.48  [Playtest] finished armtide team 0 at 7.48 min
  7.92  [Playtest] finished armtide team 0 at 7.92 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +17.0 bank 285/1350, energy +481.0 bank 1825/2150, units 40
  8.22  [Playtest] finished armtide team 0 at 8.22 min
  8.53  [Playtest] finished armtide team 0 at 8.53 min
  8.83  [Playtest] finished armfmkr team 0 at 8.83 min
  8.84  [Playtest] finished armtide team 0 at 8.84 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +18.0 bank 406/1350, energy +550.0 bank 2039/2300, units 44
  9.16  [Playtest] finished armtide team 0 at 9.16 min
  9.58  [Playtest] finished armtide team 0 at 9.58 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +18.0 bank 733/1350, energy +610.0 bank 2388/2500, units 50
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.01  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.07  [Playtest] finished armmex team 0 at 10.07 min
 10.11  [Playtest] finished armmex team 0 at 10.11 min
 10.28  [Playtest] finished armfmkr team 0 at 10.28 min
 10.38  [Playtest] finished armfrad team 0 at 10.38 min
 10.66  [Playtest] finished armtl team 0 at 10.66 min
 10.93  [Playtest] finished armtl team 0 at 10.93 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +19.9 bank 666/1450, energy +610.0 bank 2007/2500, units 55
 11.04  [Playtest] finished armfmkr team 0 at 11.04 min
 11.19  [Playtest] finished armmex team 0 at 11.19 min
 11.28  [Playtest] finished armtl team 0 at 11.28 min
 11.43  [Playtest] finished armtl team 0 at 11.43 min
 11.45  [Playtest] finished armfrad team 0 at 11.45 min
 11.46  [Playtest] finished armtide team 0 at 11.46 min
 11.78  [Playtest] finished armtide team 0 at 11.78 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +26.0 bank 808/1500, energy +656.0 bank 2443/2600, units 60
 12.23  [Playtest] finished armrl team 0 at 12.23 min
 12.30  [Playtest] finished armfmkr team 0 at 12.30 min
 12.58  [Playtest] finished armmex team 0 at 12.58 min
 12.62  [Playtest] finished armtide team 0 at 12.62 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +29.0 bank 1265/1500, energy +658.0 bank 2223/2500, units 58
 14.00  [Playtest] eco team 0 at 14.0 min: metal +25.0 bank 1200/1450, energy +651.0 bank 2286/2450, units 55
 15.00  [Playtest] eco team 0 at 15.0 min: metal +20.6 bank 1021/1350, energy +665.0 bank 2199/2550, units 52
 15.03  [Playtest] finished armfmkr team 0 at 15.03 min
 15.40  [Playtest] finished armtide team 0 at 15.40 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +23.5 bank 1110/1350, energy +577.5 bank 1976/2250, units 46
 16.66  [Playtest] finished armfrad team 0 at 16.66 min
 16.67  [Playtest] finished armfrad team 0 at 16.67 min
 16.99  [Playtest] finished armmex team 0 at 16.99 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +12.8 bank 854/1300, energy +458.0 bank 1757/2100, units 38
 17.86  [Playtest] finished armtide team 0 at 17.86 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +13.0 bank 660/800, energy +444.0 bank 1375/1600, units 38
 19.00  [Playtest] eco team 0 at 19.0 min: metal +11.3 bank 737/800, energy +451.0 bank 1353/1650, units 42
 19.04  [Playtest] finished armfmkr team 0 at 19.04 min
 19.07  [Playtest] finished armfmkr team 0 at 19.07 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +12.0 bank 621/650, energy +421.0 bank 1303/1450, units 31
 20.00  [Playtest] camera requested (1700,4550) height=3800
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
