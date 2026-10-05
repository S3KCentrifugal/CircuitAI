# Playtest report: PASS

- Verdict: **PASS** (reached 25 min)
- Game time reached: 25.1 min (frame 45185); wall 214 s
- DLL: build-theatres\d192-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T15:30:41
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-final\glacial\20261004T183041Z-8fd5db8b\runs\20261004T183418Z-835583e4\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:36.192338][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.6 min | `[t=00:00:59.398877][f=0002962] [SeaWatch] finished frame=2962 id=28410 def=armsy builder=27123` |
| expect `first-ship-exit` | seen at 2.6 min | `[t=00:01:03.473561][f=0004710] [SeaWatch] egress id=2035 yard=28410 seconds=5.0 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-final\glacial\20261004T183041Z-8fd5db8b\runs\20261004T183418Z-835583e4\screen_2026-10-04_18-32-01-139.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-final\glacial\20261004T183041Z-8fd5db8b\runs\20261004T183418Z-835583e4\screen_2026-10-04_18-32-29-918.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-final\glacial\20261004T183041Z-8fd5db8b\runs\20261004T183418Z-835583e4\screen_2026-10-04_18-33-42-495.png

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
  0.15  [Playtest] finished armmex team 0 at 0.15 min
  0.17  [Team][Roster] first mex 24526 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.17  [Team][Roster] team 1 first mex at 704,4448
  0.17  [Team][Roster] team 2 first mex at 1904,5967
  0.27  [Playtest] finished armmex team 0 at 0.27 min
  0.43  [Playtest] finished armmex team 0 at 0.43 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 1133/1150, energy +30.0 bank 980/1000, units 5
  1.05  [Playtest] finished armtide team 0 at 1.05 min
  1.31  [Playtest] finished armtide team 0 at 1.31 min
  1.65  [Playtest] finished armsy team 0 at 1.65 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 810/1250, energy +83.0 bank 340/1250, units 9
  2.32  [Playtest] finished armtide team 0 at 2.32 min
  2.65  [Playtest] finished armtide team 0 at 2.65 min
  2.89  [Playtest] finished armmex team 0 at 2.89 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 412/1300, energy +136.0 bank 1259/1400, units 16
  3.07  [Playtest] finished armtide team 0 at 3.07 min
  3.57  [Playtest] finished armtide team 0 at 3.57 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 0/1300, energy +182.0 bank 1500/1500, units 23
  4.01  [Playtest] finished armmex team 0 at 4.01 min
  4.95  [Playtest] finished armmex team 0 at 4.95 min
  4.97  [Playtest] finished armtide team 0 at 4.97 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +14.0 bank 2/1400, energy +205.0 bank 1530/1550, units 22
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.02  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.23  [Playtest] finished armmex team 0 at 5.23 min
  5.39  [Playtest] finished armtide team 0 at 5.39 min
  5.48  [Playtest] finished armmex team 0 at 5.48 min
  5.65  [Playtest] finished armtide team 0 at 5.65 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +18.0 bank 154/1500, energy +251.0 bank 1644/1650, units 24
  6.17  [Playtest] finished armmex team 0 at 6.18 min
  6.38  [Playtest] finished armmex team 0 at 6.38 min
  6.62  [Playtest] finished armmex team 0 at 6.63 min
  6.81  [Playtest] finished armmex team 0 at 6.81 min
  6.99  [Playtest] finished armllt team 0 at 6.99 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +26.0 bank 489/1700, energy +251.0 bank 1602/1650, units 31
  7.56  [Playtest] finished armnanotcplat team 0 at 7.56 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +26.0 bank 1037/1700, energy +265.0 bank 1687/1750, units 33
  9.00  [Playtest] finished armtl team 0 at 9.00 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +26.0 bank 919/1700, energy +265.0 bank 1269/1750, units 38
  9.03  [Playtest] finished armtide team 0 at 9.03 min
  9.17  [Playtest] finished armfrad team 0 at 9.17 min
  9.31  [Playtest] finished armtide team 0 at 9.31 min
  9.72  [Playtest] finished armnanotcplat team 0 at 9.72 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +26.0 bank 1043/1700, energy +311.0 bank 1850/1850, units 45
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.02  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.34  [Playtest] finished armtide team 0 at 10.34 min
 10.49  [Playtest] finished armtide team 0 at 10.49 min
 10.62  [Playtest] finished armtide team 0 at 10.62 min
 10.79  [Playtest] finished armtide team 0 at 10.79 min
 11.00  [Playtest] finished armtide team 0 at 11.00 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +26.0 bank 0/1700, energy +403.0 bank 2100/2100, units 57
 12.00  [Playtest] eco team 0 at 12.0 min: metal +26.0 bank 103/1700, energy +433.0 bank 2136/2150, units 49
 13.00  [Playtest] eco team 0 at 13.0 min: metal +26.0 bank 192/1700, energy +440.0 bank 2168/2200, units 52
 14.00  [Playtest] eco team 0 at 14.0 min: metal +26.0 bank 550/1700, energy +440.0 bank 2177/2200, units 52
 14.35  [Playtest] finished armtide team 0 at 14.35 min
 14.49  [Playtest] finished armtide team 0 at 14.49 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +26.0 bank 25/1700, energy +486.0 bank 2270/2300, units 53
 16.00  [Playtest] eco team 0 at 16.0 min: metal +26.0 bank 62/1700, energy +486.0 bank 2300/2300, units 49
 16.31  [Playtest] finished armtide team 0 at 16.31 min
 16.46  [Playtest] finished armnanotcplat team 0 at 16.46 min
 16.90  [Playtest] finished armtide team 0 at 16.90 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +22.0 bank 120/1600, energy +525.0 bank 2343/2350, units 43
 18.00  [Playtest] eco team 0 at 18.0 min: metal +0.0 bank 500/500, energy +0.0 bank 483/500, units 0
 19.00  [Playtest] eco team 0 at 19.0 min: metal +0.0 bank 500/500, energy +0.0 bank 483/500, units 0
 20.00  [Playtest] eco team 0 at 20.0 min: metal +0.0 bank 500/500, energy +0.0 bank 483/500, units 0
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.02  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
 21.00  [Playtest] eco team 0 at 21.0 min: metal +0.0 bank 500/500, energy +0.0 bank 483/500, units 0
 22.00  [Playtest] eco team 0 at 22.0 min: metal +0.0 bank 500/500, energy +0.0 bank 483/500, units 0
 23.00  [Playtest] eco team 0 at 23.0 min: metal +0.0 bank 500/500, energy +0.0 bank 483/500, units 0
 24.00  [Playtest] eco team 0 at 24.0 min: metal +0.0 bank 500/500, energy +0.0 bank 483/500, units 0
 25.00  [Playtest] eco team 0 at 25.0 min: metal +0.0 bank 500/500, energy +0.0 bank 483/500, units 0
```

## Native lines (all AIs, first 120)

```
  0.29  RESERVE: zone 1 at (152, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (152, 4808) facing 1 (id 1)
  0.29  RESERVE: zone 2 at (152, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (152, 4760) facing 1 (id 2)
  0.29  RESERVE: zone 3 at (152, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (152, 4712) facing 1 (id 3)
  0.29  RESERVE: zone 4 at (152, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (152, 4664) facing 1 (id 4)
  0.29  RESERVE: zone 5 at (152, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (152, 4616) facing 1 (id 5)
  0.29  RESERVE: zone 6 at (152, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (152, 4568) facing 1 (id 6)
  0.29  RESERVE: zone 7 at (200, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (200, 4808) facing 1 (id 7)
  0.29  RESERVE: zone 8 at (200, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (200, 4760) facing 1 (id 8)
  0.29  RESERVE: zone 9 at (200, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (200, 4712) facing 1 (id 9)
  0.29  RESERVE: zone 10 at (200, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (200, 4664) facing 1 (id 10)
  0.29  RESERVE: zone 11 at (200, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (200, 4616) facing 1 (id 11)
  0.29  RESERVE: zone 12 at (200, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (200, 4568) facing 1 (id 12)
  0.29  RESERVE: zone 13 at (248, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (248, 4808) facing 1 (id 13)
  0.29  RESERVE: zone 14 at (248, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (248, 4760) facing 1 (id 14)
  0.29  RESERVE: zone 15 at (248, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (248, 4712) facing 1 (id 15)
  0.29  RESERVE: zone 16 at (248, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (248, 4664) facing 1 (id 16)
  0.29  RESERVE: zone 17 at (248, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (248, 4616) facing 1 (id 17)
  0.29  RESERVE: zone 18 at (248, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (248, 4568) facing 1 (id 18)
  0.29  RESERVE: zone 19 at (296, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (296, 4808) facing 1 (id 19)
  0.29  RESERVE: zone 20 at (296, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (296, 4760) facing 1 (id 20)
  0.29  RESERVE: zone 21 at (296, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (296, 4712) facing 1 (id 21)
  0.29  RESERVE: zone 22 at (296, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (296, 4664) facing 1 (id 22)
  0.29  RESERVE: zone 23 at (296, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (296, 4616) facing 1 (id 23)
  0.29  RESERVE: zone 24 at (296, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (296, 4568) facing 1 (id 24)
  0.29  RESERVE: zone 25 at (344, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (344, 4808) facing 1 (id 25)
  0.29  RESERVE: zone 26 at (344, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (344, 4760) facing 1 (id 26)
  0.29  RESERVE: zone 27 at (344, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (344, 4712) facing 1 (id 27)
  0.29  RESERVE: zone 28 at (344, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (344, 4664) facing 1 (id 28)
  0.29  RESERVE: zone 29 at (344, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (344, 4616) facing 1 (id 29)
  0.29  RESERVE: zone 30 at (344, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (344, 4568) facing 1 (id 30)
  0.29  RESERVE: zone 31 at (392, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (392, 4808) facing 1 (id 31)
  0.29  RESERVE: zone 32 at (392, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (392, 4760) facing 1 (id 32)
  0.29  RESERVE: zone 33 at (392, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (392, 4712) facing 1 (id 33)
  0.29  RESERVE: zone 34 at (392, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (392, 4664) facing 1 (id 34)
  0.29  RESERVE: zone 35 at (392, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (392, 4616) facing 1 (id 35)
  0.29  RESERVE: zone 36 at (392, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (392, 4568) facing 1 (id 36)
  0.29  RESERVE: zone 37 at (440, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (440, 4808) facing 1 (id 37)
  0.29  RESERVE: zone 38 at (440, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (440, 4760) facing 1 (id 38)
  0.29  RESERVE: zone 39 at (440, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (440, 4712) facing 1 (id 39)
  0.29  RESERVE: zone 40 at (440, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (440, 4664) facing 1 (id 40)
  0.29  RESERVE: zone 41 at (440, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (440, 4616) facing 1 (id 41)
  0.29  RESERVE: zone 42 at (440, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (440, 4568) facing 1 (id 42)
  0.29  RESERVE: zone 43 at (488, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (488, 4808) facing 1 (id 43)
  0.29  RESERVE: zone 44 at (488, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (488, 4760) facing 1 (id 44)
  0.29  RESERVE: zone 45 at (488, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (488, 4712) facing 1 (id 45)
  0.29  RESERVE: zone 46 at (488, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (488, 4664) facing 1 (id 46)
  0.29  RESERVE: zone 47 at (488, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (488, 4616) facing 1 (id 47)
  0.29  RESERVE: zone 48 at (488, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (488, 4568) facing 1 (id 48)
  0.29  RESERVE: served armtide at (152, 4808) facing 1 (id 1, 47 of this def still held)
  0.42  RESERVE: zone 1 at (14184, 4568) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armtide at (14184, 4568) facing 3 (id 1)
  0.42  RESERVE: zone 2 at (14184, 4616) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armtide at (14184, 4616) facing 3 (id 2)
  0.42  RESERVE: zone 3 at (14184, 4664) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armtide at (14184, 4664) facing 3 (id 3)
  0.42  RESERVE: zone 4 at (14184, 4712) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armtide at (14184, 4712) facing 3 (id 4)
  0.42  RESERVE: zone 5 at (14184, 4760) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armtide at (14184, 4760) facing 3 (id 5)
  0.42  RESERVE: zone 6 at (14184, 4808) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armtide at (14184, 4808) facing 3 (id 6)
  0.42  RESERVE: zone 7 at (14136, 4568) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armtide at (14136, 4568) facing 3 (id 7)
  0.42  RESERVE: zone 8 at (14136, 4616) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armtide at (14136, 4616) facing 3 (id 8)
  0.42  RESERVE: zone 9 at (14136, 4664) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armtide at (14136, 4664) facing 3 (id 9)
  0.42  RESERVE: zone 10 at (14136, 4712) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armtide at (14136, 4712) facing 3 (id 10)
  0.42  RESERVE: zone 11 at (14136, 4760) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armtide at (14136, 4760) facing 3 (id 11)
  0.42  RESERVE: zone 12 at (14136, 4808) facing 3, 3x3 cells: 9 of 9 held
```
