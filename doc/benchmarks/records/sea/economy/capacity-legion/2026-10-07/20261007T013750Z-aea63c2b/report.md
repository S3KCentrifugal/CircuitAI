# Playtest report: PASS

- Verdict: **PASS** (reached 12 min)
- Game time reached: 12.0 min (frame 21660); wall 137 s
- DLL: build-theatres\d222\candidate3\SkirmishAI.dll (7b443ae28869953b); AI BARbTest/test; staged 2026-10-06T22:35:24
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/legion/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: production-capacity.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\capacity-legion\supreme\20261007T013524Z-075fa849\runs\20261007T013750Z-aea63c2b\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `assist` | seen at 1.2 min | `[t=00:00:54.178375][f=0002100] [SeaCapacity] PASS commander assists shipyard` |
| expect `support` | seen at 1.6 min | `[t=00:00:56.721094][f=0002864] [SeaCapacity] PASS constructed support turret` |
| expect `four` | seen at 3.6 min | `[t=00:01:09.658697][f=0006450] [SeaCapacity] PASS T2 with four completed in-range turrets` |
| expect `handoff` | seen at 3.7 min | `[t=00:01:10.160146][f=0006600] [SeaCapacity] PASS commander assists economic construction after four-turret handoff` |
| forbid `errors` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\capacity-legion\supreme\20261007T013524Z-075fa849\runs\20261007T013750Z-aea63c2b\screen_2026-10-07_01-36-27-595.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\capacity-legion\supreme\20261007T013524Z-075fa849\runs\20261007T013750Z-aea63c2b\screen_2026-10-07_01-36-40-908.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\capacity-legion\supreme\20261007T013524Z-075fa849\runs\20261007T013750Z-aea63c2b\screen_2026-10-07_01-37-13-371.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 10, 3 shots, end at 12.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished legcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side legion ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 31
  0.00  [Playtest] speed 10
  0.05  [Playtest] frame 90 team 0 ally 0 side legion ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 31
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.17  [Playtest] finished legsy team 0 at 0.17 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.19 min
  0.20  [Playtest] finished legmex team 0 at 0.20 min
  0.20  [Team][Roster] first mex 26536 at 4608,11072
  0.20  [Team][Roster] Re-announced: roster|1|0|0|SEA|legion|legsy|4764|11076|0|7|1|4608|11072
  0.30  [SEA][Layout] berth sea.berth.0 legadvshipyard at=6304,9968 facing=2
  0.42  [SEA][Layout] berth sea.berth.1 legsplab at=6144,10304 facing=2
  0.43  [SEA][Layout] berth sea.berth.2 leggantuw at=7264,9968 facing=2
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.3 bank 99505/100150, energy +1265.0 bank 1002732/1002750, units 10
  1.00  [Playtest] camera requested (6200,11000) height=3200
  1.01  [Playtest] camera captured name=ta position=(6200,11000) height=3200
  1.01  [Playtest] screenshot at 1.0 min of team 0 at (6200, 11000)
  1.07  [SEA][Layout] berth sea.berth.3 legsy at=6512,9760 facing=2
  1.45  [Playtest] finished legmex team 0 at 1.45 min
  1.59  [Playtest] finished legnanotcplat team 0 at 1.59 min
  1.98  [Playtest] finished legmex team 0 at 1.98 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +7.8 bank 97438/100250, energy +1275.0 bank 1002745/1002850, units 23
  2.00  [Playtest] finished legadvshipyard team 0 at 2.00 min
  2.14  [Playtest] finished legnanotcplat team 0 at 2.14 min
  2.23  [Playtest] finished legfrad team 0 at 2.23 min
  2.51  [Playtest] finished legtl team 0 at 2.51 min
  2.52  [Playtest] finished legmex team 0 at 2.52 min
  2.65  [Playtest] finished legnanotcplat team 0 at 2.64 min
  2.96  [Playtest] finished legnanotcplat team 0 at 2.96 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +11.2 bank 93607/100500, energy +1310.0 bank 1003069/1003250, units 39
  3.00  [Playtest] camera requested (6200,11000) height=3800
  3.01  [Playtest] camera captured name=ta position=(6200,11000) height=3800
  3.01  [Playtest] screenshot at 3.0 min of team 0 at (6200, 11000)
  3.17  [Playtest] finished legnanotcplat team 0 at 3.17 min
  3.49  [Playtest] finished leganavalmex team 0 at 3.49 min
  3.51  [Playtest] finished legnanotcplat team 0 at 3.51 min
  3.71  [Playtest] finished legnanotcplat team 0 at 3.71 min
  3.91  [Playtest] finished legnanotcplat team 0 at 3.91 min
  3.94  [Playtest] finished legtl team 0 at 3.94 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +18.1 bank 87391/101050, energy +1370.0 bank 997857/1003550, units 57
  4.00  [Playtest] finished leganavalfusion team 0 at 4.00 min
  4.00  [Playtest] finished leganavaleconv team 0 at 4.00 min
  4.00  [Playtest] finished leganavalfusion team 0 at 4.00 min
  4.00  [Playtest] finished leganavaleconv team 0 at 4.00 min
  4.00  [Playtest] finished leganavalfusion team 0 at 4.00 min
  4.00  [Playtest] finished leganavaleconv team 0 at 4.00 min
  4.00  [Playtest] finished leganavalfusion team 0 at 4.00 min
  4.00  [Playtest] finished leganavaleconv team 0 at 4.00 min
  4.00  [Playtest] finished leganavalfusion team 0 at 4.00 min
  4.00  [Playtest] finished leganavaleconv team 0 at 4.00 min
  4.00  [Playtest] finished leganavalfusion team 0 at 4.00 min
  4.00  [Playtest] finished leganavaleconv team 0 at 4.00 min
  4.00  [Playtest] finished leganavalfusion team 0 at 4.00 min
  4.00  [Playtest] finished leganavaleconv team 0 at 4.00 min
  4.00  [Playtest] finished leganavalfusion team 0 at 4.00 min
  4.00  [Playtest] finished leganavaleconv team 0 at 4.00 min
  4.00  [Playtest] finished leganavalfusion team 0 at 4.00 min
  4.00  [Playtest] finished leganavaleconv team 0 at 4.00 min
  4.00  [Playtest] finished leganavalfusion team 0 at 4.00 min
  4.00  [Playtest] finished leganavaleconv team 0 at 4.00 min
  4.00  [Playtest] finished leganavalfusion team 0 at 4.00 min
  4.00  [Playtest] finished leganavaleconv team 0 at 4.00 min
  4.00  [Playtest] finished leganavalfusion team 0 at 4.00 min
  4.00  [Playtest] finished leganavaleconv team 0 at 4.00 min
  4.06  [Playtest] finished legtl team 0 at 4.06 min
  4.13  [Playtest] finished legmex team 0 at 4.13 min
  4.13  [Playtest] finished legnanotcplat team 0 at 4.13 min
  4.25  [Playtest] finished legnanotcplat team 0 at 4.25 min
  4.36  [Playtest] finished leganavalmex team 0 at 4.36 min
  4.55  [Playtest] finished legnanotcplat team 0 at 4.55 min
  4.56  [Playtest] finished legfeconv team 0 at 4.56 min
  4.62  [Playtest] finished legnanotcplat team 0 at 4.62 min
  4.70  [Playtest] finished legsplab team 0 at 4.70 min
  4.75  [Playtest] finished legnanotcplat team 0 at 4.74 min
  4.86  [Playtest] finished legnanotcplat team 0 at 4.86 min
  4.86  [Playtest] finished leganavalmex team 0 at 4.86 min
  4.98  [Playtest] finished legnanotcplat team 0 at 4.98 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +159.3 bank 86133/102200, energy +16340.0 bank 1034713/1035400, units 108
  5.08  [Playtest] finished legnanotcplat team 0 at 5.08 min
  5.10  [SEA][Layout] berth sea.berth.0 legadvshipyard at=6704,9088 facing=2
  5.29  [Playtest] finished legnanotcplat team 0 at 5.29 min
  5.38  [Playtest] finished legnanotcplat team 0 at 5.38 min
  5.45  [SEA][Layout] berth sea.berth.0 legadvshipyard at=7184,8608 facing=2
  5.47  [Playtest] finished legmex team 0 at 5.47 min
  5.52  [Playtest] finished legnanotcplat team 0 at 5.52 min
  5.60  [Playtest] finished legnanotcplat team 0 at 5.60 min
  5.65  [SEA][Layout] berth sea.berth.0 legadvshipyard at=7248,8544 facing=2
  5.71  [Playtest] finished legnanotcplat team 0 at 5.71 min
  5.78  [Playtest] finished legnanotcplat team 0 at 5.78 min
  5.80  [Playtest] finished leganavalmex team 0 at 5.80 min
  5.86  [Playtest] finished legnanotcplat team 0 at 5.86 min
  5.87  [SEA][Layout] berth sea.berth.0 legadvshipyard at=7312,8480 facing=2
  5.92  [Playtest] finished legnanotcplat team 0 at 5.92 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +168.5 bank 84052/102800, energy +16370.0 bank 1034412/1035550, units 146
  6.03  [Playtest] finished legnanotcplat team 0 at 6.03 min
  6.07  [SEA][Layout] berth sea.berth.0 legadvshipyard at=7776,9152 facing=2
  6.08  [Playtest] finished legnanotcplat team 0 at 6.08 min
  6.10  [Playtest] finished legtl team 0 at 6.10 min
  6.19  [Playtest] finished legnanotcplat team 0 at 6.19 min
  6.27  [SEA][Layout] berth sea.berth.0 legadvshipyard at=8032,9968 facing=2
  6.30  [Playtest] finished legnanotcplat team 0 at 6.30 min
  6.33  [Playtest] finished legmex team 0 at 6.33 min
  6.36  [Playtest] finished legnanotcplat team 0 at 6.36 min
  6.48  [SEA][Layout] berth sea.berth.0 legadvshipyard at=7392,8400 facing=2
  6.51  [Playtest] finished legnanotcplat team 0 at 6.51 min
  6.68  [SEA][Layout] berth sea.berth.0 legadvshipyard at=7856,9120 facing=2
  6.70  [Playtest] finished legnanotcplat team 0 at 6.70 min
  6.79  [Playtest] finished legnanotcplat team 0 at 6.79 min
  6.87  [SEA][Layout] berth sea.berth.0 legadvshipyard at=8128,9968 facing=2
  6.95  [Playtest] finished legtl team 0 at 6.95 min
  6.95  [Playtest] finished legnanotcplat team 0 at 6.95 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +170.8 bank 79534/102850, energy +16470.0 bank 1035284/1035925, units 192
  7.07  [SEA][Layout] berth sea.berth.0 legadvshipyard at=7456,8336 facing=2
  7.17  [Playtest] finished legnanotcplat team 0 at 7.17 min
  7.27  [SEA][Layout] berth sea.berth.0 legadvshipyard at=7952,9088 facing=2
  7.32  [Playtest] finished legfrad team 0 at 7.32 min
  7.35  [Playtest] finished leganavalmex team 0 at 7.35 min
  7.43  [Playtest] finished legnanotcplat team 0 at 7.43 min
  7.45  [Playtest] finished leghive team 0 at 7.45 min
  7.49  [Playtest] finished leganavalsonarstation team 0 at 7.49 min
  7.63  [Playtest] finished legnanotcplat team 0 at 7.64 min
  7.87  [Playtest] finished legeconv team 0 at 7.87 min
  7.92  [Playtest] finished legnanotcplat team 0 at 7.92 min
  7.98  [SEA][Layout] berth sea.berth.0 legadvshipyard at=6704,9088 facing=2
  8.00  [Playtest] eco team 0 at 8.0 min: metal +178.8 bank 74269/103400, energy +16470.0 bank 1034854/1036125, units 243
  8.00  [Playtest] camera requested (6200,11000) height=4000
  8.02  [Playtest] camera captured name=ta position=(6200,11000) height=4000
  8.02  [Playtest] screenshot at 8.0 min of team 0 at (6200, 11000)
  8.03  [Playtest] finished legnanotcplat team 0 at 8.03 min
  8.11  [Playtest] finished leganavalmex team 0 at 8.11 min
  8.11  [Playtest] finished legeconv team 0 at 8.11 min
  8.22  [Playtest] finished legeconv team 0 at 8.22 min
  8.37  [Playtest] finished legeconv team 0 at 8.37 min
  8.43  [Playtest] finished legnanotcplat team 0 at 8.43 min
  8.53  [SEA][Layout] berth sea.berth.0 legadvshipyard at=7184,8608 facing=2
  8.54  [Playtest] finished legeconv team 0 at 8.54 min
  8.57  [Playtest] finished legnanotcplat team 0 at 8.57 min
  8.66  [Playtest] finished legnanotcplat team 0 at 8.66 min
  8.72  [Playtest] finished legeconv team 0 at 8.72 min
  8.73  [SEA][Layout] berth sea.berth.0 legadvshipyard at=7248,8544 facing=2
  8.89  [Playtest] finished legeconv team 0 at 8.89 min
  8.95  [Playtest] finished legnanotcplat team 0 at 8.95 min
  8.97  [SEA][Layout] berth sea.berth.0 legadvshipyard at=7312,8480 facing=2
  9.00  [Playtest] eco team 0 at 9.0 min: metal +191.7 bank 71135/103950, energy +16470.0 bank 1034109/1036125, units 293
  9.10  [Playtest] finished legeconv team 0 at 9.10 min
  9.15  [SEA][Layout] berth sea.berth.0 legadvshipyard at=7776,9152 facing=2
  9.22  [Playtest] finished legnanotcplat team 0 at 9.22 min
  9.27  [Playtest] finished legeconv team 0 at 9.27 min
  9.35  [SEA][Layout] berth sea.berth.0 legadvshipyard at=8032,9968 facing=2
  9.36  [Playtest] finished legmex team 0 at 9.36 min
  9.43  [Playtest] finished legnanotcplat team 0 at 9.43 min
  9.45  [Playtest] finished legeconv team 0 at 9.45 min
  9.52  [Playtest] finished legnanotcplat team 0 at 9.52 min
  9.57  [SEA][Layout] berth sea.berth.0 legadvshipyard at=7392,8400 facing=2
  9.64  [Playtest] finished legnanotcplat team 0 at 9.64 min
  9.65  [Playtest] finished legeconv team 0 at 9.65 min
  9.75  [SEA][Layout] berth sea.berth.0 legadvshipyard at=7856,9120 facing=2
  9.82  [Playtest] finished legeconv team 0 at 9.82 min
  9.82  [Playtest] finished legnanotcplat team 0 at 9.82 min
  9.95  [SEA][Layout] berth sea.berth.0 legadvshipyard at=8128,9968 facing=2
  9.96  [Playtest] finished legnanotcplat team 0 at 9.96 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +199.0 bank 68161/104000, energy +16570.0 bank 1034601/1036500, units 340
 10.01  [Playtest] finished legeconv team 0 at 10.01 min
 10.10  [Playtest] finished legnanotcplat team 0 at 10.10 min
 10.15  [SEA][Layout] berth sea.berth.0 legadvshipyard at=7456,8336 facing=2
 10.21  [Playtest] finished legeconv team 0 at 10.21 min
 10.23  [Playtest] finished legnanotcplat team 0 at 10.23 min
 10.34  [Playtest] finished legnanotcplat team 0 at 10.34 min
 10.35  [SEA][Layout] berth sea.berth.0 legadvshipyard at=7952,9088 facing=2
 10.36  [Playtest] finished legtl team 0 at 10.36 min
 10.38  [Playtest] finished legeconv team 0 at 10.38 min
 10.51  [Playtest] finished legnanotcplat team 0 at 10.51 min
 10.59  [Playtest] finished legeconv team 0 at 10.59 min
 10.74  [Playtest] finished legnanotcplat team 0 at 10.74 min
 10.78  [Playtest] finished legeconv team 0 at 10.78 min
 10.90  [Playtest] finished legmex team 0 at 10.90 min
 10.96  [Playtest] finished legnanotcplat team 0 at 10.96 min
 10.99  [Playtest] finished legfrad team 0 at 10.99 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +210.8 bank 65671/104050, energy +16570.0 bank 1034551/1036500, units 385
 11.03  [Playtest] finished legeconv team 0 at 11.03 min
 11.07  [SEA][Layout] berth sea.berth.0 legadvshipyard at=6704,9088 facing=2
 11.09  [Playtest] finished legnanotcplat team 0 at 11.09 min
 11.10  [Playtest] finished legeconv team 0 at 11.10 min
 11.14  [Playtest] finished legnanotcplat team 0 at 11.14 min
 11.32  [Playtest] finished legeconv team 0 at 11.32 min
 11.43  [SEA][Layout] berth sea.berth.0 legadvshipyard at=7184,8608 facing=2
 11.44  [Playtest] finished legnanotcplat team 0 at 11.44 min
 11.53  [Playtest] finished legeconv team 0 at 11.53 min
 11.62  [Playtest] finished legnanotcplat team 0 at 11.62 min
 11.63  [SEA][Layout] berth sea.berth.0 legadvshipyard at=7248,8544 facing=2
 11.73  [Playtest] finished legeconv team 0 at 11.73 min
 11.74  [Playtest] finished legnanotcplat team 0 at 11.74 min
 11.83  [Playtest] finished legnanotcplat team 0 at 11.83 min
 11.83  [SEA][Layout] berth sea.berth.0 legadvshipyard at=7312,8480 facing=2
 11.89  [Playtest] finished legeconv team 0 at 11.90 min
 11.95  [Playtest] finished legnanotcplat team 0 at 11.95 min
 11.99  [Playtest] finished legtl team 0 at 11.99 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +212.0 bank 63542/104050, energy +16570.0 bank 1034081/1036500, units 436
 12.02  [SEA][Layout] berth sea.berth.0 legadvshipyard at=7776,9152 facing=2
```

## Native lines (all AIs, first 120)

```
  0.18  RESERVE: zone 1 at (5832, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5832, 10648) facing 0 (id 1)
  0.18  RESERVE: zone 2 at (5784, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5784, 10648) facing 0 (id 2)
  0.18  RESERVE: zone 3 at (5736, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5736, 10648) facing 0 (id 3)
  0.18  RESERVE: zone 4 at (5832, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5832, 10600) facing 0 (id 4)
  0.18  RESERVE: zone 5 at (5784, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5784, 10600) facing 0 (id 5)
  0.18  RESERVE: zone 6 at (5736, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5736, 10600) facing 0 (id 6)
  0.18  RESERVE: zone 7 at (5688, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5688, 10648) facing 0 (id 7)
  0.18  RESERVE: zone 8 at (5832, 10552) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5832, 10552) facing 0 (id 8)
  0.18  RESERVE: zone 9 at (5784, 10552) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5784, 10552) facing 0 (id 9)
  0.18  RESERVE: zone 10 at (5640, 10696) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5640, 10696) facing 0 (id 10)
  0.18  RESERVE: zone 11 at (5688, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5688, 10600) facing 0 (id 11)
  0.18  RESERVE: zone 12 at (5736, 10552) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5736, 10552) facing 0 (id 12)
  0.18  RESERVE: zone 13 at (5640, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5640, 10648) facing 0 (id 13)
  0.18  RESERVE: zone 14 at (5832, 10504) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5832, 10504) facing 0 (id 14)
  0.18  RESERVE: zone 15 at (5688, 10552) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5688, 10552) facing 0 (id 15)
  0.18  RESERVE: zone 16 at (5640, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5640, 10600) facing 0 (id 16)
  0.18  RESERVE: zone 17 at (6072, 10744) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (6072, 10744) facing 0 (id 17)
  0.18  RESERVE: zone 18 at (5784, 10504) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5784, 10504) facing 0 (id 18)
  0.18  RESERVE: zone 19 at (6072, 10696) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (6072, 10696) facing 0 (id 19)
  0.18  RESERVE: zone 20 at (6072, 10792) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (6072, 10792) facing 0 (id 20)
  0.18  RESERVE: zone 21 at (5736, 10504) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5736, 10504) facing 0 (id 21)
  0.18  RESERVE: zone 22 at (6072, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (6072, 10648) facing 0 (id 22)
  0.18  RESERVE: zone 23 at (5640, 10552) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5640, 10552) facing 0 (id 23)
  0.18  RESERVE: zone 24 at (5688, 10504) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5688, 10504) facing 0 (id 24)
  0.18  RESERVE: zone 25 at (6072, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (6072, 10600) facing 0 (id 25)
  0.18  RESERVE: zone 26 at (5832, 10456) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5832, 10456) facing 0 (id 26)
  0.18  RESERVE: zone 27 at (6120, 10744) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (6120, 10744) facing 0 (id 27)
  0.18  RESERVE: zone 28 at (5784, 10456) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5784, 10456) facing 0 (id 28)
  0.18  RESERVE: zone 29 at (6120, 10696) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (6120, 10696) facing 0 (id 29)
  0.18  RESERVE: zone 30 at (6120, 10792) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (6120, 10792) facing 0 (id 30)
  0.18  RESERVE: zone 31 at (5736, 10456) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5736, 10456) facing 0 (id 31)
  0.18  RESERVE: zone 32 at (6120, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (6120, 10648) facing 0 (id 32)
  0.18  RESERVE: zone 33 at (5640, 10504) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5640, 10504) facing 0 (id 33)
  0.18  RESERVE: zone 34 at (6072, 10552) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (6072, 10552) facing 0 (id 34)
  0.18  RESERVE: zone 35 at (5688, 10456) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5688, 10456) facing 0 (id 35)
  0.18  RESERVE: zone 36 at (6120, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (6120, 10600) facing 0 (id 36)
  0.18  RESERVE: zone 37 at (5832, 10408) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5832, 10408) facing 0 (id 37)
  0.18  RESERVE: zone 38 at (6168, 10744) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (6168, 10744) facing 0 (id 38)
  0.18  RESERVE: zone 39 at (5784, 10408) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5784, 10408) facing 0 (id 39)
  0.18  RESERVE: zone 40 at (6072, 10504) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (6072, 10504) facing 0 (id 40)
  0.18  RESERVE: zone 41 at (6168, 10696) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (6168, 10696) facing 0 (id 41)
  0.18  RESERVE: zone 42 at (6168, 10792) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (6168, 10792) facing 0 (id 42)
  0.18  RESERVE: zone 43 at (5640, 10456) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5640, 10456) facing 0 (id 43)
  0.18  RESERVE: zone 44 at (6120, 10552) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (6120, 10552) facing 0 (id 44)
  0.18  RESERVE: zone 45 at (5736, 10408) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5736, 10408) facing 0 (id 45)
  0.18  RESERVE: zone 46 at (6168, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (6168, 10648) facing 0 (id 46)
  0.18  RESERVE: zone 47 at (5688, 10408) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5688, 10408) facing 0 (id 47)
  0.18  RESERVE: zone 48 at (6168, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (6168, 10600) facing 0 (id 48)
  0.18  RESERVE: zone 49 at (6072, 10456) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (6072, 10456) facing 0 (id 49)
  0.18  RESERVE: zone 50 at (6120, 10504) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (6120, 10504) facing 0 (id 50)
  0.18  RESERVE: zone 51 at (5832, 10360) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5832, 10360) facing 0 (id 51)
  0.18  RESERVE: zone 52 at (6216, 10744) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (6216, 10744) facing 0 (id 52)
  0.18  RESERVE: zone 53 at (5784, 10360) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5784, 10360) facing 0 (id 53)
  0.18  RESERVE: zone 54 at (5640, 10408) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5640, 10408) facing 0 (id 54)
  0.18  RESERVE: zone 55 at (6168, 10552) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (6168, 10552) facing 0 (id 55)
  0.18  RESERVE: zone 56 at (6216, 10696) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (6216, 10696) facing 0 (id 56)
  0.18  RESERVE: zone 57 at (6216, 10792) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (6216, 10792) facing 0 (id 57)
  0.18  RESERVE: zone 58 at (5736, 10360) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotcplat at (5736, 10360) facing 0 (id 58)
  0.18  RESERVE: corridor 59 at (5824, 11184) facing 0, 12x50 cells: 468 of 600 held
  0.18  RESERVE: zone 60 at (5952, 11520) facing 2, 40x40 cells: 1312 of 1600 held
  0.18  RESERVE: zone 60 released
  0.18  RESERVE: zone 61 at (6080, 11520) facing 2, 40x40 cells: 1360 of 1600 held
```
