# Playtest report: PASS

- Verdict: **PASS** (reached 12 min)
- Game time reached: 12.1 min (frame 21868); wall 125 s
- DLL: build-theatres\d222\candidate2\SkirmishAI.dll (d5016e5fac38bee0); AI BARbTest/test; staged 2026-10-06T22:02:46
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: production-capacity.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\capacity-armada\supreme\20261007T010246Z-00354975\runs\20261007T010500Z-4d166447\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `assist` | seen at 1.5 min | `[t=00:00:54.689605][f=0002700] [SeaCapacity] PASS commander assists shipyard` |
| expect `support` | seen at 1.7 min | `[t=00:00:55.670889][f=0002995] [SeaCapacity] PASS constructed support turret` |
| expect `four` | seen at 3.6 min | `[t=00:01:08.167663][f=0006450] [SeaCapacity] PASS T2 with four completed in-range turrets` |
| expect `handoff` | seen at 3.6 min | `[t=00:01:08.167700][f=0006450] [SeaCapacity] PASS commander assists economic construction after four-turret handoff` |
| forbid `errors` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\capacity-armada\supreme\20261007T010246Z-00354975\runs\20261007T010500Z-4d166447\screen_2026-10-07_01-03-48-019.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\capacity-armada\supreme\20261007T010246Z-00354975\runs\20261007T010500Z-4d166447\screen_2026-10-07_01-04-01-312.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\capacity-armada\supreme\20261007T010246Z-00354975\runs\20261007T010500Z-4d166447\screen_2026-10-07_01-04-32-313.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 10, 3 shots, end at 12.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 30
  0.00  [Playtest] speed 10
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 30
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.17  [Playtest] finished armsy team 0 at 0.17 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.20  [Playtest] finished armmex team 0 at 0.20 min
  0.22  [Team][Roster] first mex 3714 at 4608,11072
  0.22  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4770|11077|0|7|1|4608|11072
  0.30  [SEA][Layout] berth sea.berth.0 armasy at=6304,9968 facing=2
  0.37  [SEA][Layout] berth sea.berth.1 armplat at=5920,9968 facing=2
  0.38  [SEA][Layout] berth sea.berth.2 armshltxuw at=7264,9968 facing=2
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.3 bank 99488/100150, energy +1251.0 bank 1002722/1002750, units 10
  1.00  [Playtest] camera requested (6200,11000) height=3200
  1.01  [Playtest] camera captured name=ta position=(6200,11000) height=3200
  1.01  [Playtest] screenshot at 1.0 min of team 0 at (6200, 11000)
  1.08  [SEA][Layout] berth sea.berth.3 armsy at=6512,9760 facing=2
  1.16  [Playtest] finished armmex team 0 at 1.16 min
  1.64  [Playtest] finished armfrad team 0 at 1.64 min
  1.66  [Playtest] finished armnanotcplat team 0 at 1.66 min
  1.68  [Playtest] finished armmex team 0 at 1.68 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.9 bank 97435/100250, energy +1265.0 bank 1002804/1002850, units 19
  2.00  [Playtest] finished armasy team 0 at 2.00 min
  2.14  [Playtest] finished armnanotcplat team 0 at 2.14 min
  2.19  [Playtest] finished armtl team 0 at 2.19 min
  2.42  [Playtest] finished armmex team 0 at 2.42 min
  2.46  [Playtest] finished armmex team 0 at 2.46 min
  2.78  [Playtest] finished armnanotcplat team 0 at 2.78 min
  2.98  [Playtest] finished armtl team 0 at 2.97 min
  2.98  [Playtest] finished armtl team 0 at 2.98 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +13.5 bank 93822/100550, energy +1302.0 bank 1003009/1003250, units 36
  3.00  [Playtest] camera requested (6200,11000) height=3800
  3.01  [Playtest] camera captured name=ta position=(6200,11000) height=3800
  3.01  [Playtest] screenshot at 3.0 min of team 0 at (6200, 11000)
  3.11  [Playtest] finished armnanotcplat team 0 at 3.11 min
  3.24  [Playtest] finished armfrad team 0 at 3.24 min
  3.32  [Playtest] finished armnanotcplat team 0 at 3.32 min
  3.54  [Playtest] finished armnanotcplat team 0 at 3.54 min
  3.66  [Playtest] finished armuwmme team 0 at 3.66 min
  3.79  [Playtest] finished armfmkr team 0 at 3.79 min
  3.83  [Playtest] finished armnanotcplat team 0 at 3.83 min
  3.84  [Playtest] finished armtl team 0 at 3.84 min
  3.94  [Playtest] finished armnanotcplat team 0 at 3.94 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +21.4 bank 87841/101100, energy +1362.0 bank 996834/1003550, units 53
  4.00  [Playtest] finished armuwfus team 0 at 4.00 min
  4.00  [Playtest] finished armuwmmm team 0 at 4.00 min
  4.00  [Playtest] finished armuwfus team 0 at 4.00 min
  4.00  [Playtest] finished armuwmmm team 0 at 4.00 min
  4.00  [Playtest] finished armuwfus team 0 at 4.00 min
  4.00  [Playtest] finished armuwmmm team 0 at 4.00 min
  4.00  [Playtest] finished armuwfus team 0 at 4.00 min
  4.00  [Playtest] finished armuwmmm team 0 at 4.00 min
  4.00  [Playtest] finished armuwfus team 0 at 4.00 min
  4.00  [Playtest] finished armuwmmm team 0 at 4.00 min
  4.00  [Playtest] finished armuwfus team 0 at 4.00 min
  4.00  [Playtest] finished armuwmmm team 0 at 4.00 min
  4.00  [Playtest] finished armuwfus team 0 at 4.00 min
  4.00  [Playtest] finished armuwmmm team 0 at 4.00 min
  4.00  [Playtest] finished armuwfus team 0 at 4.00 min
  4.00  [Playtest] finished armuwmmm team 0 at 4.00 min
  4.00  [Playtest] finished armuwfus team 0 at 4.00 min
  4.00  [Playtest] finished armuwmmm team 0 at 4.00 min
  4.00  [Playtest] finished armuwfus team 0 at 4.00 min
  4.00  [Playtest] finished armuwmmm team 0 at 4.00 min
  4.00  [Playtest] finished armuwfus team 0 at 4.00 min
  4.00  [Playtest] finished armuwmmm team 0 at 4.00 min
  4.00  [Playtest] finished armuwfus team 0 at 4.00 min
  4.00  [Playtest] finished armuwmmm team 0 at 4.00 min
  4.01  [Playtest] finished armfmkr team 0 at 4.01 min
  4.02  [Playtest] finished armuwmme team 0 at 4.02 min
  4.20  [Playtest] finished armnanotcplat team 0 at 4.20 min
  4.25  [Playtest] finished armfmkr team 0 at 4.25 min
  4.33  [Playtest] finished armfmkr team 0 at 4.33 min
  4.58  [Playtest] finished armnanotcplat team 0 at 4.58 min
  4.74  [Playtest] finished armnanotcplat team 0 at 4.74 min
  4.88  [Playtest] finished armnanotcplat team 0 at 4.88 min
  4.99  [Playtest] finished armuwmme team 0 at 4.99 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +158.9 bank 89705/102200, energy +16092.0 bank 1034548/1035200, units 92
  5.05  [Playtest] finished armnanotcplat team 0 at 5.05 min
  5.21  [Playtest] finished armnanotcplat team 0 at 5.21 min
  5.21  [Playtest] finished armuwmmm team 0 at 5.21 min
  5.36  [Playtest] finished armnanotcplat team 0 at 5.36 min
  5.51  [Playtest] finished armnanotcplat team 0 at 5.51 min
  5.67  [Playtest] finished armnanotcplat team 0 at 5.67 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +173.4 bank 89816/102200, energy +16122.0 bank 1034396/1035350, units 109
  6.13  [Playtest] finished armnanotcplat team 0 at 6.13 min
  6.27  [Playtest] finished armnanotcplat team 0 at 6.27 min
  6.40  [Playtest] finished armnanotcplat team 0 at 6.40 min
  6.55  [Playtest] finished armnanotcplat team 0 at 6.55 min
  6.66  [Playtest] finished armnanotcplat team 0 at 6.66 min
  6.77  [Playtest] finished armnanotcplat team 0 at 6.77 min
  6.90  [Playtest] finished armnanotcplat team 0 at 6.90 min
  6.98  [Playtest] finished armnanotcplat team 0 at 6.98 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +183.5 bank 88673/102200, energy +16182.0 bank 1035111/1035650, units 129
  7.08  [Playtest] finished armnanotcplat team 0 at 7.08 min
  7.22  [Playtest] finished armnanotcplat team 0 at 7.22 min
  7.31  [Playtest] finished armnanotcplat team 0 at 7.31 min
  7.48  [Playtest] finished armmex team 0 at 7.48 min
  7.50  [Playtest] finished armnanotcplat team 0 at 7.50 min
  7.57  [Playtest] finished armuwmmm team 0 at 7.57 min
  7.94  [Playtest] finished armnanotcplat team 0 at 7.94 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +188.1 bank 86982/102250, energy +16182.0 bank 1034553/1035650, units 151
  8.00  [Playtest] camera requested (6200,11000) height=4000
  8.01  [Playtest] camera captured name=ta position=(6200,11000) height=4000
  8.01  [Playtest] screenshot at 8.0 min of team 0 at (6200, 11000)
  8.04  [Playtest] finished armnanotcplat team 0 at 8.04 min
  8.10  [Playtest] finished armnanotcplat team 0 at 8.10 min
  8.11  [Playtest] finished armuwmmm team 0 at 8.11 min
  8.23  [Playtest] finished armnanotcplat team 0 at 8.23 min
  8.49  [Playtest] finished armnanotcplat team 0 at 8.49 min
  8.72  [Playtest] finished armason team 0 at 8.72 min
  8.82  [Playtest] finished armuwmme team 0 at 8.82 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +205.4 bank 83672/102800, energy +16182.0 bank 1033458/1035650, units 175
  9.03  [Playtest] finished armmex team 0 at 9.03 min
  9.18  [Playtest] finished armuwmmm team 0 at 9.18 min
  9.87  [Playtest] finished armnanotcplat team 0 at 9.87 min
  9.95  [Playtest] finished armuwmme team 0 at 9.95 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +222.1 bank 84112/103400, energy +16182.0 bank 1032712/1035650, units 198
 10.04  [Playtest] finished armnanotcplat team 0 at 10.04 min
 10.19  [Playtest] finished armuwmmm team 0 at 10.19 min
 10.21  [Playtest] finished armfrad team 0 at 10.21 min
 10.40  [Playtest] finished armnanotcplat team 0 at 10.40 min
 10.52  [Playtest] finished armnanotcplat team 0 at 10.52 min
 10.71  [Playtest] finished armnanotcplat team 0 at 10.71 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +232.5 bank 82417/103400, energy +16182.0 bank 1032071/1035650, units 218
 11.01  [Playtest] finished armuwmmm team 0 at 11.01 min
 11.41  [Playtest] finished armnanotcplat team 0 at 11.41 min
 11.47  [Playtest] finished armnanotcplat team 0 at 11.48 min
 11.60  [Playtest] finished armnanotcplat team 0 at 11.60 min
 11.86  [Playtest] finished armnanotcplat team 0 at 11.86 min
 11.92  [Playtest] finished armplat team 0 at 11.92 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +242.8 bank 82281/103400, energy +16182.0 bank 1033882/1035850, units 241
 12.15  [Playtest] finished armnanotcplat team 0 at 12.15 min
```

## Native lines (all AIs, first 120)

```
  0.18  RESERVE: zone 1 at (5832, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5832, 10648) facing 0 (id 1)
  0.18  RESERVE: zone 2 at (5784, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5784, 10648) facing 0 (id 2)
  0.18  RESERVE: zone 3 at (5880, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5880, 10648) facing 0 (id 3)
  0.18  RESERVE: zone 4 at (5736, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5736, 10648) facing 0 (id 4)
  0.18  RESERVE: zone 5 at (5928, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5928, 10648) facing 0 (id 5)
  0.18  RESERVE: zone 6 at (5832, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5832, 10600) facing 0 (id 6)
  0.18  RESERVE: zone 7 at (5784, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5784, 10600) facing 0 (id 7)
  0.18  RESERVE: zone 8 at (5880, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5880, 10600) facing 0 (id 8)
  0.18  RESERVE: zone 9 at (5976, 10696) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5976, 10696) facing 0 (id 9)
  0.18  RESERVE: zone 10 at (5736, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5736, 10600) facing 0 (id 10)
  0.18  RESERVE: zone 11 at (5928, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5928, 10600) facing 0 (id 11)
  0.18  RESERVE: zone 12 at (5688, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5688, 10648) facing 0 (id 12)
  0.18  RESERVE: zone 13 at (5976, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5976, 10648) facing 0 (id 13)
  0.18  RESERVE: zone 14 at (5832, 10552) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5832, 10552) facing 0 (id 14)
  0.18  RESERVE: zone 15 at (5784, 10552) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5784, 10552) facing 0 (id 15)
  0.18  RESERVE: zone 16 at (5880, 10552) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5880, 10552) facing 0 (id 16)
  0.18  RESERVE: zone 17 at (5640, 10696) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5640, 10696) facing 0 (id 17)
  0.18  RESERVE: zone 18 at (6024, 10696) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6024, 10696) facing 0 (id 18)
  0.18  RESERVE: zone 19 at (5688, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5688, 10600) facing 0 (id 19)
  0.18  RESERVE: zone 20 at (5976, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5976, 10600) facing 0 (id 20)
  0.18  RESERVE: zone 21 at (5736, 10552) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5736, 10552) facing 0 (id 21)
  0.18  RESERVE: zone 22 at (5928, 10552) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5928, 10552) facing 0 (id 22)
  0.18  RESERVE: zone 23 at (5640, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5640, 10648) facing 0 (id 23)
  0.18  RESERVE: zone 24 at (6024, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6024, 10648) facing 0 (id 24)
  0.18  RESERVE: zone 25 at (5832, 10504) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5832, 10504) facing 0 (id 25)
  0.18  RESERVE: zone 26 at (5688, 10552) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5688, 10552) facing 0 (id 26)
  0.18  RESERVE: zone 27 at (5976, 10552) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5976, 10552) facing 0 (id 27)
  0.18  RESERVE: zone 28 at (5640, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5640, 10600) facing 0 (id 28)
  0.18  RESERVE: zone 29 at (6024, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6024, 10600) facing 0 (id 29)
  0.18  RESERVE: zone 30 at (5784, 10504) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5784, 10504) facing 0 (id 30)
  0.18  RESERVE: zone 31 at (5880, 10504) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5880, 10504) facing 0 (id 31)
  0.18  RESERVE: zone 32 at (6072, 10696) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6072, 10696) facing 0 (id 32)
  0.18  RESERVE: zone 33 at (5736, 10504) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5736, 10504) facing 0 (id 33)
  0.18  RESERVE: zone 34 at (5928, 10504) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5928, 10504) facing 0 (id 34)
  0.18  RESERVE: zone 35 at (6072, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6072, 10648) facing 0 (id 35)
  0.18  RESERVE: zone 36 at (5640, 10552) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5640, 10552) facing 0 (id 36)
  0.18  RESERVE: zone 37 at (6024, 10552) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6024, 10552) facing 0 (id 37)
  0.18  RESERVE: zone 38 at (5688, 10504) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5688, 10504) facing 0 (id 38)
  0.18  RESERVE: zone 39 at (5976, 10504) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5976, 10504) facing 0 (id 39)
  0.18  RESERVE: zone 40 at (6072, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6072, 10600) facing 0 (id 40)
  0.18  RESERVE: zone 41 at (5832, 10456) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5832, 10456) facing 0 (id 41)
  0.18  RESERVE: zone 42 at (5784, 10456) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5784, 10456) facing 0 (id 42)
  0.18  RESERVE: zone 43 at (5880, 10456) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5880, 10456) facing 0 (id 43)
  0.18  RESERVE: zone 44 at (6120, 10696) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6120, 10696) facing 0 (id 44)
  0.18  RESERVE: zone 45 at (5736, 10456) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5736, 10456) facing 0 (id 45)
  0.18  RESERVE: zone 46 at (5928, 10456) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5928, 10456) facing 0 (id 46)
  0.18  RESERVE: zone 47 at (6120, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6120, 10648) facing 0 (id 47)
  0.18  RESERVE: zone 48 at (5640, 10504) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5640, 10504) facing 0 (id 48)
  0.18  RESERVE: zone 49 at (6024, 10504) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6024, 10504) facing 0 (id 49)
  0.18  RESERVE: zone 50 at (6072, 10552) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6072, 10552) facing 0 (id 50)
  0.18  RESERVE: zone 51 at (5688, 10456) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5688, 10456) facing 0 (id 51)
  0.18  RESERVE: zone 52 at (5976, 10456) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5976, 10456) facing 0 (id 52)
  0.18  RESERVE: zone 53 at (6120, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6120, 10600) facing 0 (id 53)
  0.18  RESERVE: zone 54 at (5832, 10408) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5832, 10408) facing 0 (id 54)
  0.18  RESERVE: zone 55 at (5784, 10408) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5784, 10408) facing 0 (id 55)
  0.18  RESERVE: zone 56 at (5880, 10408) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5880, 10408) facing 0 (id 56)
  0.18  RESERVE: zone 57 at (6072, 10504) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6072, 10504) facing 0 (id 57)
  0.18  RESERVE: zone 58 at (6168, 10696) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6168, 10696) facing 0 (id 58)
  0.18  RESERVE: zone 59 at (5640, 10456) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5640, 10456) facing 0 (id 59)
  0.18  RESERVE: zone 60 at (6024, 10456) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6024, 10456) facing 0 (id 60)
```
