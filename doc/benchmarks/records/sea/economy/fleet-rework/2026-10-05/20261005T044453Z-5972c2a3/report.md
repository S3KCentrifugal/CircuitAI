# Playtest report: PASS

- Verdict: **PASS** (reached 20 min)
- Game time reached: 20.0 min (frame 36031); wall 138 s
- DLL: build-theatres\d200\build-3\SkirmishAI.dll (bcac8c987b1d8164); AI BARbTest/test; staged 2026-10-05T01:42:33
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\fleet-rework\glacial\20261005T044232Z-c0082086\runs\20261005T044453Z-5972c2a3\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:29.002265][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 2.5 min | `[t=00:00:46.705097][f=0004491] [SeaWatch] finished frame=4491 id=18556 def=armsy builder=27123` |
| expect `first-ship-exit` | seen at 3.8 min | `[t=00:00:50.800507][f=0006900] [SeaWatch] egress id=14679 yard=18556 seconds=17.2 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\fleet-rework\glacial\20261005T044232Z-c0082086\runs\20261005T044453Z-5972c2a3\screen_2026-10-05_04-43-32-018.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\fleet-rework\glacial\20261005T044232Z-c0082086\runs\20261005T044453Z-5972c2a3\screen_2026-10-05_04-43-52-652.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\fleet-rework\glacial\20261005T044232Z-c0082086\runs\20261005T044453Z-5972c2a3\screen_2026-10-05_04-44-52-450.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 20, 4 shots, end at 20.5 min
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
  0.00  [Playtest] speed 20
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
  1.25  [Playtest] finished armtl team 0 at 1.25 min
  1.75  [Playtest] finished armtide team 0 at 1.75 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.0 bank 1076/1100, energy +53.0 bank 1045/1050, units 6
  2.14  [Playtest] finished armtide team 0 at 2.14 min
  2.50  [Playtest] finished armsy team 0 at 2.49 min
  2.75  [SEA][Layout] berth sea.berth.0 armasy at=1792,3584 facing=1
  2.97  [SEA][Layout] berth sea.berth.1 armasy at=2464,3952 facing=1
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.0 bank 599/1200, energy +83.0 bank 1/1250, units 10
  3.55  [Playtest] finished armmex team 0 at 3.55 min
  3.79  [Playtest] finished armtide team 0 at 3.79 min
  3.85  [Playtest] finished armmex team 0 at 3.85 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +12.7 bank 239/1300, energy +113.0 bank 1333/1350, units 15
  4.08  [Playtest] finished armtide team 0 at 4.08 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +10.0 bank 0/1300, energy +136.0 bank 1384/1400, units 17
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.01  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.49  [Playtest] finished armtide team 0 at 5.49 min
  5.64  [Playtest] finished armmex team 0 at 5.64 min
  5.89  [Playtest] finished armmex team 0 at 5.89 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +14.0 bank 14/1400, energy +159.0 bank 1421/1450, units 22
  6.12  [Playtest] finished armmex team 0 at 6.12 min
  6.19  [Playtest] finished armtide team 0 at 6.19 min
  6.32  [Playtest] finished armmex team 0 at 6.32 min
  6.84  [Playtest] finished armmex team 0 at 6.84 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +20.0 bank 367/1550, energy +182.0 bank 1412/1500, units 29
  7.08  [Playtest] finished armmex team 0 at 7.08 min
  7.12  [Playtest] finished armtide team 0 at 7.12 min
  7.31  [Playtest] finished armmex team 0 at 7.31 min
  7.50  [Playtest] finished armmex team 0 at 7.50 min
  7.68  [Playtest] finished armllt team 0 at 7.68 min
  7.69  [Playtest] finished armtide team 0 at 7.69 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +26.0 bank 771/1700, energy +228.0 bank 1579/1600, units 34
  8.14  [Playtest] finished armtide team 0 at 8.14 min
  8.24  [Playtest] finished armtide team 0 at 8.24 min
  8.29  [Playtest] finished armmex team 0 at 8.29 min
  8.68  [Playtest] finished armfmkr team 0 at 8.68 min
  8.98  [Playtest] finished armfmkr team 0 at 8.98 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +29.0 bank 1526/1750, energy +274.0 bank 1488/1700, units 35
  9.34  [Playtest] finished armfmkr team 0 at 9.34 min
  9.88  [Playtest] finished armtide team 0 at 9.88 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +30.3 bank 1549/1750, energy +297.0 bank 1393/1750, units 38
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.02  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.11  [Playtest] finished armtide team 0 at 10.11 min
 10.92  [Playtest] finished armtide team 0 at 10.92 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +31.0 bank 1433/1750, energy +343.0 bank 1739/1850, units 41
 12.00  [Playtest] eco team 0 at 12.0 min: metal +30.9 bank 1418/1750, energy +343.0 bank 1490/1850, units 40
 12.24  [Playtest] finished armtide team 0 at 12.24 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +31.0 bank 1479/1750, energy +366.0 bank 1565/1900, units 46
 13.28  [Playtest] finished armtide team 0 at 13.27 min
 13.30  [Playtest] finished armfmkr team 0 at 13.30 min
 13.52  [Playtest] finished armtide team 0 at 13.52 min
 13.74  [Playtest] finished armfmkr team 0 at 13.74 min
 13.85  [Playtest] finished armtide team 0 at 13.85 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +33.5 bank 1611/1750, energy +435.0 bank 1676/2050, units 50
 14.11  [Playtest] finished armtide team 0 at 14.11 min
 14.16  [Playtest] finished armfmkr team 0 at 14.16 min
 14.63  [Playtest] finished armfmkr team 0 at 14.63 min
 14.82  [Playtest] finished armtide team 0 at 14.82 min
 14.86  [Playtest] finished armfmkr team 0 at 14.86 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +32.9 bank 1547/1750, energy +481.0 bank 1784/2150, units 55
 15.39  [Playtest] finished armtide team 0 at 15.40 min
 15.43  [Playtest] finished armfmkr team 0 at 15.43 min
 15.69  [Playtest] finished armfmkr team 0 at 15.69 min
 15.89  [Playtest] finished armfmkr team 0 at 15.89 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +33.0 bank 1556/1750, energy +504.0 bank 1827/2200, units 62
 16.07  [Playtest] finished armtide team 0 at 16.07 min
 16.24  [Playtest] finished armfmkr team 0 at 16.24 min
 16.28  [Playtest] finished armfmkr team 0 at 16.28 min
 16.40  [Playtest] finished armtide team 0 at 16.40 min
 16.65  [Playtest] finished coruwmme team 0 at 16.65 min
 16.68  [Playtest] finished armfrad team 0 at 16.68 min
 16.73  [Playtest] finished armtide team 0 at 16.73 min
 16.75  [Playtest] finished armtl team 0 at 16.75 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +39.8 bank 1733/2300, energy +573.0 bank 1966/2350, units 69
 17.07  [Playtest] finished armtide team 0 at 17.07 min
 17.66  [Playtest] finished coruwmme team 0 at 17.66 min
 17.74  [Playtest] finished armnanotcplat team 0 at 17.74 min
 17.94  [Playtest] finished coruwmme team 0 at 17.94 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +46.2 bank 2321/3400, energy +596.0 bank 1896/2400, units 69
 18.03  [Playtest] finished armtide team 0 at 18.03 min
 18.08  [Playtest] finished armnanotcplat team 0 at 18.08 min
 18.48  [Playtest] finished armtl team 0 at 18.48 min
 18.94  [Playtest] finished armtide team 0 at 18.94 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +56.1 bank 2672/3400, energy +642.0 bank 2082/2500, units 75
 19.14  [Playtest] finished armtide team 0 at 19.14 min
 19.43  [Playtest] finished armtide team 0 at 19.43 min
 19.77  [Playtest] finished armtide team 0 at 19.77 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +50.0 bank 2537/3400, energy +711.0 bank 2121/2650, units 83
 20.00  [Playtest] camera requested (1700,4550) height=3800
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
