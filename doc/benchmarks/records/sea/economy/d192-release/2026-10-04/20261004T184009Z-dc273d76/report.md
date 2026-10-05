# Playtest report: PASS

- Verdict: **PASS** (reached 25 min)
- Game time reached: 25.1 min (frame 45151); wall 232 s
- DLL: build-theatres\d192-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T15:36:14
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-release\glacial\20261004T183613Z-e2c23f59\runs\20261004T184009Z-dc273d76\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:38.379212][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 2.2 min | `[t=00:00:59.679965][f=0004041] [SeaWatch] finished frame=4041 id=3682 def=armsy builder=27123` |
| expect `first-ship-exit` | seen at 4.1 min | `[t=00:01:07.290240][f=0007320] [SeaWatch] egress id=3130 yard=3682 seconds=5.6 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-release\glacial\20261004T183613Z-e2c23f59\runs\20261004T184009Z-dc273d76\screen_2026-10-04_18-37-30-942.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-release\glacial\20261004T183613Z-e2c23f59\runs\20261004T184009Z-dc273d76\screen_2026-10-04_18-37-56-312.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-release\glacial\20261004T183613Z-e2c23f59\runs\20261004T184009Z-dc273d76\screen_2026-10-04_18-39-23-597.png

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
  0.27  [Playtest] finished armmex team 0 at 0.27 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.7 bank 1097/1100, energy +30.0 bank 997/1000, units 4
  1.30  [Playtest] finished armtl team 0 at 1.30 min
  1.74  [Playtest] finished armtide team 0 at 1.74 min
  1.91  [Playtest] finished armtide team 0 at 1.91 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.0 bank 1012/1100, energy +76.0 bank 1062/1100, units 7
  2.25  [Playtest] finished armsy team 0 at 2.24 min
  2.63  [Playtest] finished armtide team 0 at 2.63 min
  2.89  [Playtest] finished armtide team 0 at 2.89 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.0 bank 337/1200, energy +136.0 bank 471/1400, units 13
  3.03  [Playtest] finished armtide team 0 at 3.03 min
  3.34  [Playtest] finished armmex team 0 at 3.34 min
  3.36  [Playtest] finished armtide team 0 at 3.36 min
  3.63  [Playtest] finished armtide team 0 at 3.63 min
  3.81  [Playtest] finished armmex team 0 at 3.81 min
  3.93  [Playtest] finished armtide team 0 at 3.93 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 18/1300, energy +228.0 bank 1588/1600, units 20
  4.10  [Playtest] finished armmex team 0 at 4.10 min
  4.23  [Playtest] finished armtide team 0 at 4.23 min
  4.50  [Playtest] finished armtide team 0 at 4.49 min
  4.97  [Playtest] finished armmex team 0 at 4.97 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +14.0 bank 17/1400, energy +274.0 bank 1686/1700, units 23
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.02  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.24  [Playtest] finished armmex team 0 at 5.24 min
  5.47  [Playtest] finished armmex team 0 at 5.47 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +18.0 bank 172/1500, energy +274.0 bank 1665/1700, units 28
  6.04  [Playtest] finished armmex team 0 at 6.04 min
  6.27  [Playtest] finished armmex team 0 at 6.27 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +22.0 bank 607/1600, energy +274.0 bank 1669/1700, units 29
  7.82  [Playtest] finished armnanotcplat team 0 at 7.82 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +22.0 bank 1091/1600, energy +274.0 bank 1668/1700, units 33
  9.00  [Playtest] eco team 0 at 9.0 min: metal +22.0 bank 1420/1600, energy +288.0 bank 1731/1800, units 37
  9.28  [Playtest] finished armmstor team 0 at 9.28 min
  9.92  [Playtest] finished armtl team 0 at 9.92 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +22.0 bank 804/4600, energy +288.0 bank 1737/1800, units 41
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.02  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.14  [Playtest] finished armtide team 0 at 10.14 min
 10.79  [Playtest] finished armtl team 0 at 10.80 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +22.0 bank 705/4600, energy +311.0 bank 1771/1850, units 44
 11.02  [Playtest] finished armfrad team 0 at 11.02 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +22.0 bank 24/4600, energy +311.0 bank 1747/1850, units 42
 13.00  [Playtest] eco team 0 at 13.0 min: metal +22.0 bank 0/4600, energy +311.0 bank 1809/1850, units 42
 14.00  [Playtest] eco team 0 at 14.0 min: metal +22.0 bank 17/4600, energy +311.0 bank 1850/1850, units 42
 15.00  [Playtest] eco team 0 at 15.0 min: metal +22.0 bank 25/4600, energy +311.0 bank 1784/1850, units 42
 16.00  [Playtest] eco team 0 at 16.0 min: metal +22.0 bank 0/4600, energy +311.0 bank 1797/1850, units 45
 17.00  [Playtest] eco team 0 at 17.0 min: metal +22.0 bank 58/4600, energy +311.0 bank 1772/1850, units 50
 18.00  [Playtest] eco team 0 at 18.0 min: metal +22.0 bank 55/4600, energy +311.0 bank 1769/1850, units 52
 19.00  [Playtest] eco team 0 at 19.0 min: metal +22.0 bank 0/4600, energy +311.0 bank 1807/1850, units 44
 20.00  [Playtest] eco team 0 at 20.0 min: metal +22.0 bank 0/4600, energy +311.0 bank 1794/1850, units 40
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.02  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
 21.00  [Playtest] eco team 0 at 21.0 min: metal +22.0 bank 0/4600, energy +311.0 bank 1798/1850, units 40
 22.00  [Playtest] eco team 0 at 22.0 min: metal +22.0 bank 0/4600, energy +311.0 bank 1796/1850, units 39
 23.00  [Playtest] eco team 0 at 23.0 min: metal +22.0 bank 0/4600, energy +311.0 bank 1815/1850, units 41
 23.15  [Playtest] finished armtide team 0 at 23.15 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +10.0 bank 738/3850, energy +10.5 bank 558/650, units 12
 25.00  [Playtest] eco team 0 at 25.0 min: metal +10.0 bank 702/750, energy +0.0 bank 480/500, units 5
```

## Native lines (all AIs, first 120)

```
  0.28  RESERVE: zone 1 at (872, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (872, 4200) facing 1 (id 1)
  0.28  RESERVE: zone 2 at (872, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (872, 4152) facing 1 (id 2)
  0.28  RESERVE: zone 3 at (872, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (872, 4104) facing 1 (id 3)
  0.28  RESERVE: zone 4 at (872, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (872, 4056) facing 1 (id 4)
  0.28  RESERVE: zone 5 at (872, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (872, 4008) facing 1 (id 5)
  0.28  RESERVE: zone 6 at (872, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (872, 3960) facing 1 (id 6)
  0.28  RESERVE: zone 7 at (920, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 4200) facing 1 (id 7)
  0.28  RESERVE: zone 8 at (920, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 4152) facing 1 (id 8)
  0.28  RESERVE: zone 9 at (920, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 4104) facing 1 (id 9)
  0.28  RESERVE: zone 10 at (920, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 4056) facing 1 (id 10)
  0.28  RESERVE: zone 11 at (920, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 4008) facing 1 (id 11)
  0.28  RESERVE: zone 12 at (920, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 3960) facing 1 (id 12)
  0.28  RESERVE: zone 13 at (968, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 4200) facing 1 (id 13)
  0.28  RESERVE: zone 14 at (968, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 4152) facing 1 (id 14)
  0.28  RESERVE: zone 15 at (968, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 4104) facing 1 (id 15)
  0.28  RESERVE: zone 16 at (968, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 4056) facing 1 (id 16)
  0.28  RESERVE: zone 17 at (968, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 4008) facing 1 (id 17)
  0.28  RESERVE: zone 18 at (968, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 3960) facing 1 (id 18)
  0.28  RESERVE: zone 19 at (1016, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 4200) facing 1 (id 19)
  0.28  RESERVE: zone 20 at (1016, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 4152) facing 1 (id 20)
  0.28  RESERVE: zone 21 at (1016, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 4104) facing 1 (id 21)
  0.28  RESERVE: zone 22 at (1016, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 4056) facing 1 (id 22)
  0.28  RESERVE: zone 23 at (1016, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 4008) facing 1 (id 23)
  0.28  RESERVE: zone 24 at (1016, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 3960) facing 1 (id 24)
  0.28  RESERVE: zone 25 at (1064, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1064, 4200) facing 1 (id 25)
  0.28  RESERVE: zone 26 at (1064, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1064, 4152) facing 1 (id 26)
  0.28  RESERVE: zone 27 at (1064, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1064, 4104) facing 1 (id 27)
  0.28  RESERVE: zone 28 at (1064, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1064, 4056) facing 1 (id 28)
  0.28  RESERVE: zone 29 at (1064, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1064, 4008) facing 1 (id 29)
  0.28  RESERVE: zone 30 at (1064, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1064, 3960) facing 1 (id 30)
  0.28  RESERVE: zone 31 at (1112, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1112, 4200) facing 1 (id 31)
  0.28  RESERVE: zone 32 at (1112, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1112, 4152) facing 1 (id 32)
  0.28  RESERVE: zone 33 at (1112, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1112, 4104) facing 1 (id 33)
  0.28  RESERVE: zone 34 at (1112, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1112, 4056) facing 1 (id 34)
  0.28  RESERVE: zone 35 at (1112, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1112, 4008) facing 1 (id 35)
  0.28  RESERVE: zone 36 at (1112, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1112, 3960) facing 1 (id 36)
  0.28  RESERVE: zone 37 at (1160, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1160, 4200) facing 1 (id 37)
  0.28  RESERVE: zone 38 at (1160, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1160, 4152) facing 1 (id 38)
  0.28  RESERVE: zone 39 at (1160, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1160, 4104) facing 1 (id 39)
  0.28  RESERVE: zone 40 at (1160, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1160, 4056) facing 1 (id 40)
  0.28  RESERVE: zone 41 at (1160, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1160, 4008) facing 1 (id 41)
  0.28  RESERVE: zone 42 at (1160, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1160, 3960) facing 1 (id 42)
  0.28  RESERVE: zone 43 at (1208, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1208, 4200) facing 1 (id 43)
  0.28  RESERVE: zone 44 at (1208, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1208, 4152) facing 1 (id 44)
  0.28  RESERVE: zone 45 at (1208, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1208, 4104) facing 1 (id 45)
  0.28  RESERVE: zone 46 at (1208, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1208, 4056) facing 1 (id 46)
  0.28  RESERVE: zone 47 at (1208, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1208, 4008) facing 1 (id 47)
  0.28  RESERVE: zone 48 at (1208, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1208, 3960) facing 1 (id 48)
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
```
