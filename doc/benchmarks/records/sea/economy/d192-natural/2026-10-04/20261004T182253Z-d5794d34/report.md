# Playtest report: PASS

- Verdict: **PASS** (reached 25 min)
- Game time reached: 25.0 min (frame 45064); wall 191 s
- DLL: build-theatres\d192-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T15:19:39
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-natural\glacial\20261004T181938Z-dbd274b5\runs\20261004T182253Z-d5794d34\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:31.554818][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 2.3 min | `[t=00:00:51.061900][f=0004146] [SeaWatch] finished frame=4146 id=5244 def=armsy builder=27123` |
| expect `first-ship-exit` | seen at 3.7 min | `[t=00:00:56.522830][f=0006600] [SeaWatch] egress id=1475 yard=5244 seconds=7.5 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-natural\glacial\20261004T181938Z-dbd274b5\runs\20261004T182253Z-d5794d34\screen_2026-10-04_18-20-45-530.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-natural\glacial\20261004T181938Z-dbd274b5\runs\20261004T182253Z-d5794d34\screen_2026-10-04_18-21-08-610.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-natural\glacial\20261004T181938Z-dbd274b5\runs\20261004T182253Z-d5794d34\screen_2026-10-04_18-22-15-127.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 25.5 min
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
  0.15  [Playtest] finished armmex team 0 at 0.15 min
  0.17  [Team][Roster] first mex 10685 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.17  [Team][Roster] team 2 first mex at 1904,5967
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.7 bank 1094/1100, energy +30.0 bank 895/1000, units 5
  1.80  [Playtest] finished armtide team 0 at 1.80 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +9.1 bank 1082/1100, energy +53.0 bank 1018/1050, units 6
  2.00  [Playtest] finished armtide team 0 at 2.00 min
  2.30  [Playtest] finished armsy team 0 at 2.30 min
  2.68  [Playtest] finished armtide team 0 at 2.68 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.0 bank 467/1200, energy +113.0 bank 203/1350, units 11
  3.42  [Playtest] finished armmex team 0 at 3.42 min
  3.63  [Playtest] finished armtide team 0 at 3.63 min
  3.79  [Playtest] finished armtl team 0 at 3.79 min
  3.97  [Playtest] finished armmex team 0 at 3.97 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 15/1300, energy +136.0 bank 1376/1400, units 16
  4.10  [Playtest] finished armtide team 0 at 4.10 min
  4.26  [Playtest] finished armmex team 0 at 4.26 min
  4.47  [Playtest] finished armtide team 0 at 4.47 min
  4.68  [Playtest] finished armtide team 0 at 4.68 min
  4.90  [Playtest] finished armtide team 0 at 4.90 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +12.0 bank 8/1350, energy +228.0 bank 1589/1600, units 23
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.01  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.08  [Playtest] finished armmex team 0 at 5.08 min
  5.13  [Playtest] finished armtide team 0 at 5.13 min
  5.28  [Playtest] finished armmex team 0 at 5.28 min
  5.33  [Playtest] finished armtide team 0 at 5.33 min
  5.50  [Playtest] finished armmex team 0 at 5.50 min
  5.67  [Playtest] finished armmex team 0 at 5.68 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +20.0 bank 171/1550, energy +274.0 bank 1685/1700, units 28
  6.21  [Playtest] finished armmex team 0 at 6.21 min
  6.52  [Playtest] finished armllt team 0 at 6.52 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +22.0 bank 540/1600, energy +274.0 bank 1639/1700, units 32
  7.00  [Playtest] finished armrad team 0 at 7.01 min
  7.24  [Playtest] finished armllt team 0 at 7.24 min
  7.91  [Playtest] finished armmex team 0 at 7.91 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +24.0 bank 1104/1650, energy +281.0 bank 1709/1750, units 37
  8.20  [Playtest] finished armmex team 0 at 8.20 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +26.0 bank 1558/1700, energy +281.0 bank 1706/1750, units 39
  9.38  [Playtest] finished armnanotcplat team 0 at 9.38 min
  9.57  [Playtest] finished armtide team 0 at 9.57 min
  9.83  [Playtest] finished armtide team 0 at 9.83 min
  9.85  [Playtest] finished armtide team 0 at 9.85 min
  9.97  [Playtest] finished armtide team 0 at 9.97 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +26.0 bank 1500/1700, energy +387.0 bank 2037/2050, units 44
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.02  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.08  [Playtest] finished armtide team 0 at 10.08 min
 10.22  [Playtest] finished armtide team 0 at 10.22 min
 10.83  [Playtest] finished armtide team 0 at 10.83 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +26.0 bank 1475/1700, energy +456.0 bank 2200/2200, units 46
 11.75  [Playtest] finished armnanotcplat team 0 at 11.75 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +26.0 bank 1091/1700, energy +456.0 bank 2163/2200, units 48
 13.00  [Playtest] eco team 0 at 13.0 min: metal +26.0 bank 401/1700, energy +456.0 bank 2200/2200, units 51
 14.00  [Playtest] eco team 0 at 14.0 min: metal +26.0 bank 1080/1700, energy +456.0 bank 2200/2200, units 52
 15.00  [Playtest] eco team 0 at 15.0 min: metal +26.0 bank 1357/1700, energy +456.0 bank 2180/2200, units 53
 15.26  [Playtest] finished armnanotcplat team 0 at 15.26 min
 15.65  [Playtest] finished armtl team 0 at 15.65 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +26.0 bank 1471/1700, energy +456.0 bank 2174/2200, units 52
 17.00  [Playtest] eco team 0 at 17.0 min: metal +26.0 bank 1237/1700, energy +456.0 bank 2040/2200, units 52
 17.20  [Playtest] finished armtide team 0 at 17.20 min
 17.34  [Playtest] finished armtl team 0 at 17.34 min
 17.48  [Playtest] finished armtide team 0 at 17.48 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +26.0 bank 51/1700, energy +502.0 bank 2221/2300, units 55
 19.00  [Playtest] eco team 0 at 19.0 min: metal +26.0 bank 0/1700, energy +502.0 bank 2268/2300, units 62
 19.24  [Playtest] finished armmex team 0 at 19.24 min
 19.57  [Playtest] finished armmex team 0 at 19.57 min
 19.62  [Playtest] finished armtide team 0 at 19.62 min
 19.75  [Playtest] finished armtide team 0 at 19.75 min
 19.92  [Playtest] finished armtide team 0 at 19.92 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +118.7 bank 664/1800, energy +578.0 bank 2340/2500, units 66
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.02  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
 20.11  [Playtest] finished armtide team 0 at 20.11 min
 20.15  [Playtest] finished armmex team 0 at 20.15 min
 20.20  [Playtest] finished armtl team 0 at 20.20 min
 20.27  [Playtest] finished armtide team 0 at 20.27 min
 20.59  [Playtest] finished armtide team 0 at 20.59 min
 20.77  [Playtest] finished armtide team 0 at 20.77 min
 20.94  [Playtest] finished armtide team 0 at 20.94 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +67.5 bank 1527/1850, energy +693.0 bank 2749/2750, units 73
 21.14  [Playtest] finished armtide team 0 at 21.14 min
 21.33  [Playtest] finished armmex team 0 at 21.33 min
 21.44  [Playtest] finished armmex team 0 at 21.44 min
 21.46  [Playtest] finished armtide team 0 at 21.46 min
 21.51  [Playtest] finished armmex team 0 at 21.51 min
 21.63  [Playtest] finished armmex team 0 at 21.63 min
 21.65  [Playtest] finished armtide team 0 at 21.65 min
 21.74  [Playtest] finished armfrad team 0 at 21.74 min
 21.93  [Playtest] finished armtide team 0 at 21.93 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +40.0 bank 2031/2050, energy +785.0 bank 2940/2950, units 91
 22.19  [Playtest] finished armnanotcplat team 0 at 22.19 min
 22.36  [Playtest] finished armnanotcplat team 0 at 22.36 min
 22.46  [SEA][Layout] berth sea.berth.0 armasy at=1616,4064 facing=1
 22.58  [Playtest] finished armnanotcplat team 0 at 22.58 min
 22.64  [Playtest] finished armtide team 0 at 22.64 min
 22.68  [Playtest] finished armtide team 0 at 22.68 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +42.9 bank 1988/2050, energy +831.0 bank 2949/3050, units 102
 23.02  [Playtest] finished armtide team 0 at 23.02 min
 23.39  [Playtest] finished armtide team 0 at 23.39 min
 23.42  [Playtest] finished armmex team 0 at 23.42 min
 23.62  [Playtest] finished armfmkr team 0 at 23.62 min
 23.76  [Playtest] finished armfmkr team 0 at 23.76 min
 23.85  [Playtest] finished armfmkr team 0 at 23.85 min
 23.91  [Playtest] finished armmex team 0 at 23.91 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +86.0 bank 1757/2150, energy +877.0 bank 3010/3150, units 107
 24.17  [Playtest] finished armtide team 0 at 24.17 min
 24.20  [Playtest] finished armmex team 0 at 24.20 min
 24.41  [Playtest] finished armfmkr team 0 at 24.41 min
 24.58  [Playtest] finished armmex team 0 at 24.58 min
 24.69  [Playtest] finished armtl team 0 at 24.69 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +96.4 bank 415/2250, energy +893.0 bank 2906/3150, units 119
```

## Native lines (all AIs, first 120)

```
  0.28  RESERVE: zone 1 at (152, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (152, 4808) facing 1 (id 1)
  0.28  RESERVE: zone 2 at (152, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (152, 4760) facing 1 (id 2)
  0.28  RESERVE: zone 3 at (152, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (152, 4712) facing 1 (id 3)
  0.28  RESERVE: zone 4 at (152, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (152, 4664) facing 1 (id 4)
  0.28  RESERVE: zone 5 at (152, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (152, 4616) facing 1 (id 5)
  0.28  RESERVE: zone 6 at (152, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (152, 4568) facing 1 (id 6)
  0.28  RESERVE: zone 7 at (200, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (200, 4808) facing 1 (id 7)
  0.28  RESERVE: zone 8 at (200, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (200, 4760) facing 1 (id 8)
  0.28  RESERVE: zone 9 at (200, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (200, 4712) facing 1 (id 9)
  0.28  RESERVE: zone 10 at (200, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (200, 4664) facing 1 (id 10)
  0.28  RESERVE: zone 11 at (200, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (200, 4616) facing 1 (id 11)
  0.28  RESERVE: zone 12 at (200, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (200, 4568) facing 1 (id 12)
  0.28  RESERVE: zone 13 at (248, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (248, 4808) facing 1 (id 13)
  0.28  RESERVE: zone 14 at (248, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (248, 4760) facing 1 (id 14)
  0.28  RESERVE: zone 15 at (248, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (248, 4712) facing 1 (id 15)
  0.28  RESERVE: zone 16 at (248, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (248, 4664) facing 1 (id 16)
  0.28  RESERVE: zone 17 at (248, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (248, 4616) facing 1 (id 17)
  0.28  RESERVE: zone 18 at (248, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (248, 4568) facing 1 (id 18)
  0.28  RESERVE: zone 19 at (296, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (296, 4808) facing 1 (id 19)
  0.28  RESERVE: zone 20 at (296, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (296, 4760) facing 1 (id 20)
  0.28  RESERVE: zone 21 at (296, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (296, 4712) facing 1 (id 21)
  0.28  RESERVE: zone 22 at (296, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (296, 4664) facing 1 (id 22)
  0.28  RESERVE: zone 23 at (296, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (296, 4616) facing 1 (id 23)
  0.28  RESERVE: zone 24 at (296, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (296, 4568) facing 1 (id 24)
  0.28  RESERVE: zone 25 at (344, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (344, 4808) facing 1 (id 25)
  0.28  RESERVE: zone 26 at (344, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (344, 4760) facing 1 (id 26)
  0.28  RESERVE: zone 27 at (344, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (344, 4712) facing 1 (id 27)
  0.28  RESERVE: zone 28 at (344, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (344, 4664) facing 1 (id 28)
  0.28  RESERVE: zone 29 at (344, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (344, 4616) facing 1 (id 29)
  0.28  RESERVE: zone 30 at (344, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (344, 4568) facing 1 (id 30)
  0.28  RESERVE: zone 31 at (392, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (392, 4808) facing 1 (id 31)
  0.28  RESERVE: zone 32 at (392, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (392, 4760) facing 1 (id 32)
  0.28  RESERVE: zone 33 at (392, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (392, 4712) facing 1 (id 33)
  0.28  RESERVE: zone 34 at (392, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (392, 4664) facing 1 (id 34)
  0.28  RESERVE: zone 35 at (392, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (392, 4616) facing 1 (id 35)
  0.28  RESERVE: zone 36 at (392, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (392, 4568) facing 1 (id 36)
  0.28  RESERVE: zone 37 at (440, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (440, 4808) facing 1 (id 37)
  0.28  RESERVE: zone 38 at (440, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (440, 4760) facing 1 (id 38)
  0.28  RESERVE: zone 39 at (440, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (440, 4712) facing 1 (id 39)
  0.28  RESERVE: zone 40 at (440, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (440, 4664) facing 1 (id 40)
  0.28  RESERVE: zone 41 at (440, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (440, 4616) facing 1 (id 41)
  0.28  RESERVE: zone 42 at (440, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (440, 4568) facing 1 (id 42)
  0.28  RESERVE: zone 43 at (488, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (488, 4808) facing 1 (id 43)
  0.28  RESERVE: zone 44 at (488, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (488, 4760) facing 1 (id 44)
  0.28  RESERVE: zone 45 at (488, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (488, 4712) facing 1 (id 45)
  0.28  RESERVE: zone 46 at (488, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (488, 4664) facing 1 (id 46)
  0.28  RESERVE: zone 47 at (488, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (488, 4616) facing 1 (id 47)
  0.28  RESERVE: zone 48 at (488, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (488, 4568) facing 1 (id 48)
  0.28  RESERVE: served armtide at (152, 4808) facing 1 (id 1, 47 of this def still held)
  0.29  RESERVE: zone 1 at (872, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (872, 4200) facing 1 (id 1)
  0.29  RESERVE: zone 2 at (872, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (872, 4152) facing 1 (id 2)
  0.29  RESERVE: zone 3 at (872, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (872, 4104) facing 1 (id 3)
  0.29  RESERVE: zone 4 at (872, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (872, 4056) facing 1 (id 4)
  0.29  RESERVE: zone 5 at (872, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (872, 4008) facing 1 (id 5)
  0.29  RESERVE: zone 6 at (872, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (872, 3960) facing 1 (id 6)
  0.29  RESERVE: zone 7 at (920, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (920, 4200) facing 1 (id 7)
  0.29  RESERVE: zone 8 at (920, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (920, 4152) facing 1 (id 8)
  0.29  RESERVE: zone 9 at (920, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (920, 4104) facing 1 (id 9)
  0.29  RESERVE: zone 10 at (920, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (920, 4056) facing 1 (id 10)
  0.29  RESERVE: zone 11 at (920, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (920, 4008) facing 1 (id 11)
  0.29  RESERVE: zone 12 at (920, 3960) facing 1, 3x3 cells: 9 of 9 held
```
