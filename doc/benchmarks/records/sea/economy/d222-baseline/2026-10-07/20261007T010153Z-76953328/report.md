# Playtest report: PASS

- Verdict: **PASS** (reached 20 min)
- Game time reached: 20.0 min (frame 36035); wall 172 s
- DLL: build-theatres\d221\candidate1\SkirmishAI.dll (eca9d0229482cc8e); AI BARbTest/test; staged 2026-10-06T21:58:58
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d222-baseline\glacial\20261007T005857Z-21563808\runs\20261007T010153Z-76953328\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:33.449623][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 2.2 min | `[t=00:00:54.523372][f=0004011] [SeaWatch] finished frame=4011 id=29615 def=armsy builder=27123` |
| expect `first-ship-exit` | seen at 2.6 min | `[t=00:00:56.006497][f=0004650] [SeaWatch] egress id=25989 yard=29615 seconds=6.9 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d222-baseline\glacial\20261007T005857Z-21563808\runs\20261007T010153Z-76953328\screen_2026-10-07_01-00-09-768.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d222-baseline\glacial\20261007T005857Z-21563808\runs\20261007T010153Z-76953328\screen_2026-10-07_01-00-36-898.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d222-baseline\glacial\20261007T005857Z-21563808\runs\20261007T010153Z-76953328\screen_2026-10-07_01-01-52-531.png

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
  1.29  [Playtest] finished armtl team 0 at 1.29 min
  1.72  [Playtest] finished armtide team 0 at 1.72 min
  1.89  [Playtest] finished armtide team 0 at 1.89 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.0 bank 992/1100, energy +76.0 bank 1062/1100, units 7
  2.23  [Playtest] finished armsy team 0 at 2.23 min
  2.32  [SEA][Layout] berth sea.berth.0 armasy at=1584,4064 facing=1
  2.35  [SEA][Layout] berth sea.berth.1 armplat at=1488,3920 facing=1
  2.61  [Playtest] finished armtide team 0 at 2.61 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.0 bank 397/1200, energy +113.0 bank 81/1350, units 12
  3.22  [Playtest] finished armmex team 0 at 3.22 min
  3.30  [Playtest] finished armtide team 0 at 3.30 min
  3.63  [Playtest] finished armtide team 0 at 3.63 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +8.0 bank 80/1250, energy +159.0 bank 1437/1450, units 16
  4.23  [Playtest] finished armmex team 0 at 4.23 min
  4.45  [Playtest] finished armmex team 0 at 4.45 min
  4.75  [Playtest] finished armmex team 0 at 4.75 min
  4.97  [Playtest] finished armmex team 0 at 4.97 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +16.0 bank 5/1450, energy +159.0 bank 1342/1450, units 21
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.01  [Playtest] finished armmex team 0 at 5.01 min
  5.01  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.50  [Playtest] finished armmex team 0 at 5.50 min
  5.73  [Playtest] finished armmex team 0 at 5.73 min
  5.96  [Playtest] finished armmex team 0 at 5.96 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +24.0 bank 472/1650, energy +159.0 bank 1415/1450, units 26
  6.14  [Playtest] finished armmex team 0 at 6.14 min
  6.33  [Playtest] finished armllt team 0 at 6.33 min
  6.41  [Playtest] finished armtide team 0 at 6.41 min
  6.43  [Playtest] finished armrad team 0 at 6.43 min
  6.72  [Playtest] finished armtide team 0 at 6.72 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +26.0 bank 1060/1700, energy +205.0 bank 1208/1550, units 36
  7.05  [Playtest] finished armmex team 0 at 7.05 min
  7.24  [Playtest] finished armtide team 0 at 7.24 min
  7.29  [Playtest] finished armmex team 0 at 7.29 min
  7.47  [Playtest] finished armnanotcplat team 0 at 7.47 min
  7.52  [Playtest] finished armtide team 0 at 7.52 min
  7.71  [Playtest] finished armtide team 0 at 7.71 min
  7.87  [Playtest] finished armmex team 0 at 7.87 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +32.0 bank 976/1850, energy +274.0 bank 204/1700, units 42
  8.01  [Playtest] finished armmex team 0 at 8.01 min
  8.04  [Playtest] finished armtide team 0 at 8.04 min
  8.05  [Playtest] finished armtide team 0 at 8.05 min
  8.20  [Playtest] finished armwin team 0 at 8.20 min
  8.23  [Playtest] finished armtide team 0 at 8.23 min
  8.34  [Playtest] finished armwin team 0 at 8.34 min
  8.42  [Playtest] finished armtide team 0 at 8.42 min
  8.84  [Playtest] finished armmex team 0 at 8.84 min
  8.98  [Playtest] finished armfmkr team 0 at 8.98 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +36.0 bank 1295/1950, energy +387.5 bank 1843/1901, units 50
  9.24  [Playtest] finished armfmkr team 0 at 9.24 min
  9.53  [Playtest] finished armfmkr team 0 at 9.53 min
  9.87  [Playtest] finished armfmkr team 0 at 9.87 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +40.0 bank 1814/1950, energy +397.2 bank 1485/1901, units 56
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.01  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.25  [Playtest] finished armtide team 0 at 10.25 min
 10.28  [Playtest] finished armfmkr team 0 at 10.28 min
 10.51  [Playtest] finished armtide team 0 at 10.51 min
 10.76  [Playtest] finished armtide team 0 at 10.76 min
 10.99  [Playtest] finished armtide team 0 at 10.99 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +39.7 bank 1949/1950, energy +467.6 bank 1939/2101, units 61
 11.35  [Playtest] finished armtide team 0 at 11.35 min
 11.54  [Playtest] finished armnanotcplat team 0 at 11.54 min
 11.63  [Playtest] finished armtide team 0 at 11.63 min
 11.85  [Playtest] finished armtide team 0 at 11.85 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +41.0 bank 1945/1950, energy +563.6 bank 1771/2251, units 68
 12.10  [Playtest] finished armfmkr team 0 at 12.10 min
 12.18  [Playtest] finished armtide team 0 at 12.18 min
 12.40  [Playtest] finished armfmkr team 0 at 12.40 min
 12.51  [Playtest] finished armtide team 0 at 12.51 min
 12.89  [Playtest] finished armtide team 0 at 12.89 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +39.2 bank 1916/1950, energy +630.2 bank 1815/2401, units 78
 13.05  [Playtest] finished armfmkr team 0 at 13.05 min
 13.22  [Playtest] finished armfrad team 0 at 13.22 min
 13.36  [Playtest] finished armtide team 0 at 13.36 min
 13.69  [Playtest] finished armtide team 0 at 13.69 min
 13.73  [Playtest] finished armtl team 0 at 13.73 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +39.0 bank 1128/1950, energy +679.9 bank 2081/2501, units 80
 14.04  [Playtest] finished armtide team 0 at 14.04 min
 14.37  [Playtest] finished armtide team 0 at 14.37 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +39.2 bank 1006/1950, energy +696.3 bank 2069/2601, units 85
 15.29  [Playtest] finished armtide team 0 at 15.29 min
 15.33  [Playtest] finished armfmkr team 0 at 15.33 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +42.3 bank 1232/1950, energy +736.2 bank 2205/2651, units 89
 16.12  [Playtest] finished armtide team 0 at 16.12 min
 16.75  [Playtest] finished armtide team 0 at 16.75 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +41.2 bank 1484/1950, energy +781.8 bank 2129/2751, units 97
 17.32  [Playtest] finished armtide team 0 at 17.32 min
 17.65  [Playtest] finished armtide team 0 at 17.65 min
 17.98  [Playtest] finished armtide team 0 at 17.98 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +41.3 bank 1045/1950, energy +852.3 bank 2379/2901, units 101
 18.32  [Playtest] finished armtide team 0 at 18.32 min
 18.52  [Playtest] finished armfmkr team 0 at 18.52 min
 18.64  [Playtest] finished armtide team 0 at 18.64 min
 18.75  [Playtest] finished armnanotcplat team 0 at 18.75 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +46.0 bank 1221/1950, energy +905.6 bank 2507/3001, units 112
 19.00  [Playtest] finished armtide team 0 at 19.00 min
 19.33  [Playtest] finished armtide team 0 at 19.33 min
 19.66  [Playtest] finished armtide team 0 at 19.66 min
 19.67  [Playtest] finished armfmkr team 0 at 19.67 min
 19.98  [Playtest] finished armtide team 0 at 19.98 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +44.2 bank 462/1950, energy +977.0 bank 2638/3201, units 124
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.02  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
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
  0.28  RESERVE: served armtide at (872, 4200) facing 1 (id 1, 47 of this def still held)
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
```
