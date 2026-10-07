# Playtest report: PASS

- Verdict: **PASS** (reached 12 min)
- Game time reached: 12.1 min (frame 21777); wall 40 s
- DLL: build-theatres\d222\candidate3\SkirmishAI.dll (7b443ae28869953b); AI BARbTest/test; staged 2026-10-06T22:40:23
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/cortex/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: production-capacity.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\capacity-cortex\supreme\20261007T014022Z-a4337ad3\runs\20261007T014255Z-f5c016ff\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `assist` | seen at 1.4 min | `[t=00:00:54.639258][f=0002550] [SeaCapacity] PASS commander assists shipyard` |
| expect `support` | seen at 1.5 min | `[t=00:00:55.362454][f=0002767] [SeaCapacity] PASS constructed support turret` |
| expect `four` | seen at 3.4 min | `[t=00:01:07.627709][f=0006150] [SeaCapacity] PASS T2 with four completed in-range turrets` |
| expect `handoff` | seen at 3.6 min | `[t=00:01:08.626795][f=0006450] [SeaCapacity] PASS commander assists economic construction after four-turret handoff` |
| forbid `errors` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\capacity-cortex\supreme\20261007T014022Z-a4337ad3\runs\20261007T014255Z-f5c016ff\screen_2026-10-07_01-41-42-723.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\capacity-cortex\supreme\20261007T014022Z-a4337ad3\runs\20261007T014255Z-f5c016ff\screen_2026-10-07_01-41-56-044.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\capacity-cortex\supreme\20261007T014022Z-a4337ad3\runs\20261007T014255Z-f5c016ff\screen_2026-10-07_01-42-27-043.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 10, 3 shots, end at 12.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished corcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side cortex ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 40
  0.00  [Playtest] speed 10
  0.05  [Playtest] frame 90 team 0 ally 0 side cortex ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 40
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.17  [Playtest] finished corsy team 0 at 0.17 min
  0.19  [Playtest] finished coruwfus team 0 at 0.19 min
  0.20  [Playtest] finished cormex team 0 at 0.20 min
  0.20  [Team][Roster] first mex 28791 at 4607,11071
  0.20  [Team][Roster] Re-announced: roster|1|0|0|SEA|cortex|corsy|4762|11074|0|7|1|4607|11071
  0.35  [SEA][Layout] berth sea.berth.0 corsy at=6176,10480 facing=2
  0.50  [SEA][Layout] berth sea.berth.1 corasy at=6400,9968 facing=2
  0.57  [SEA][Layout] berth sea.berth.2 corplat at=5920,9968 facing=2
  0.58  [SEA][Layout] berth sea.berth.3 corgantuw at=7360,9968 facing=2
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.3 bank 99413/100150, energy +1264.0 bank 1002653/1002700, units 10
  1.00  [Playtest] camera requested (6200,11000) height=3200
  1.01  [Playtest] camera captured name=ta position=(6200,11000) height=3200
  1.01  [Playtest] screenshot at 1.0 min of team 0 at (6200, 11000)
  1.13  [Playtest] finished cormex team 0 at 1.13 min
  1.54  [Playtest] finished cornanotcplat team 0 at 1.54 min
  1.60  [Playtest] finished cormex team 0 at 1.60 min
  1.60  [Playtest] finished corfmkr team 0 at 1.60 min
  1.88  [Playtest] finished cornanotcplat team 0 at 1.88 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +9.9 bank 97964/100250, energy +1278.0 bank 1002620/1002800, units 19
  2.00  [Playtest] finished corasy team 0 at 2.00 min
  2.04  [Playtest] finished cormex team 0 at 2.04 min
  2.26  [Playtest] finished cornanotcplat team 0 at 2.26 min
  2.32  [Playtest] finished cortl team 0 at 2.32 min
  2.45  [Playtest] finished cormex team 0 at 2.45 min
  2.68  [Playtest] finished cornanotcplat team 0 at 2.68 min
  2.69  [Playtest] finished cortl team 0 at 2.69 min
  2.93  [Playtest] finished cornanotcplat team 0 at 2.93 min
  2.97  [Playtest] finished cortl team 0 at 2.97 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +14.5 bank 93808/100550, energy +1322.0 bank 1001276/1003250, units 37
  3.00  [Playtest] camera requested (6200,11000) height=3800
  3.01  [Playtest] camera captured name=ta position=(6200,11000) height=3800
  3.01  [Playtest] screenshot at 3.0 min of team 0 at (6200, 11000)
  3.16  [Playtest] finished cornanotcplat team 0 at 3.16 min
  3.23  [Playtest] finished corfmkr team 0 at 3.23 min
  3.26  [Playtest] finished cortl team 0 at 3.26 min
  3.40  [Playtest] finished cornanotcplat team 0 at 3.40 min
  3.42  [Playtest] finished coruwmme team 0 at 3.42 min
  3.43  [Playtest] finished corfrad team 0 at 3.43 min
  3.47  [Playtest] finished cortide team 0 at 3.47 min
  3.58  [Playtest] finished coruwmme team 0 at 3.58 min
  3.66  [Playtest] finished corfmkr team 0 at 3.66 min
  3.66  [Playtest] finished cornanotcplat team 0 at 3.66 min
  3.80  [Playtest] finished cornanotcplat team 0 at 3.80 min
  3.96  [Playtest] finished cornanotcplat team 0 at 3.96 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +30.3 bank 86130/101650, energy +1403.0 bank 976352/1003600, units 56
  4.00  [Playtest] finished coruwfus team 0 at 4.00 min
  4.00  [Playtest] finished coruwmmm team 0 at 4.00 min
  4.00  [Playtest] finished coruwfus team 0 at 4.00 min
  4.00  [Playtest] finished coruwmmm team 0 at 4.00 min
  4.00  [Playtest] finished coruwfus team 0 at 4.00 min
  4.00  [Playtest] finished coruwmmm team 0 at 4.00 min
  4.00  [Playtest] finished coruwfus team 0 at 4.00 min
  4.00  [Playtest] finished coruwmmm team 0 at 4.00 min
  4.00  [Playtest] finished coruwfus team 0 at 4.00 min
  4.00  [Playtest] finished coruwmmm team 0 at 4.00 min
  4.00  [Playtest] finished coruwfus team 0 at 4.00 min
  4.00  [Playtest] finished coruwmmm team 0 at 4.00 min
  4.00  [Playtest] finished coruwfus team 0 at 4.00 min
  4.00  [Playtest] finished coruwmmm team 0 at 4.00 min
  4.00  [Playtest] finished coruwfus team 0 at 4.00 min
  4.00  [Playtest] finished coruwmmm team 0 at 4.00 min
  4.00  [Playtest] finished coruwfus team 0 at 4.00 min
  4.00  [Playtest] finished coruwmmm team 0 at 4.00 min
  4.00  [Playtest] finished coruwfus team 0 at 4.00 min
  4.00  [Playtest] finished coruwmmm team 0 at 4.00 min
  4.00  [Playtest] finished coruwfus team 0 at 4.00 min
  4.00  [Playtest] finished coruwmmm team 0 at 4.00 min
  4.00  [Playtest] finished coruwfus team 0 at 4.00 min
  4.00  [Playtest] finished coruwmmm team 0 at 4.00 min
  4.01  [Playtest] finished corfrad team 0 at 4.01 min
  4.08  [Playtest] finished cornanotcplat team 0 at 4.07 min
  4.18  [Playtest] finished cornanotcplat team 0 at 4.18 min
  4.18  [Playtest] finished corfmkr team 0 at 4.18 min
  4.27  [Playtest] finished coruwmme team 0 at 4.27 min
  4.30  [Playtest] finished corfmkr team 0 at 4.30 min
  4.31  [Playtest] finished corfmkr team 0 at 4.31 min
  4.37  [Playtest] finished cornanotcplat team 0 at 4.37 min
  4.39  [Playtest] finished coruwmme team 0 at 4.39 min
  4.52  [Playtest] finished cornanotcplat team 0 at 4.52 min
  4.65  [Playtest] finished cornanotcplat team 0 at 4.65 min
  4.71  [Playtest] finished corfmkr team 0 at 4.71 min
  4.72  [Playtest] finished corfrad team 0 at 4.72 min
  4.82  [Playtest] finished cornanotcplat team 0 at 4.82 min
  4.94  [Playtest] finished cornanotcplat team 0 at 4.94 min
  4.96  [Playtest] finished cortl team 0 at 4.96 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +172.2 bank 86291/102750, energy +16403.0 bank 1034683/1035400, units 101
  5.08  [Playtest] finished cornanotcplat team 0 at 5.09 min
  5.27  [Playtest] finished cornanotcplat team 0 at 5.27 min
  5.34  [Playtest] finished corfmkr team 0 at 5.34 min
  5.36  [Playtest] finished cornanotcplat team 0 at 5.36 min
  5.38  [Playtest] finished coruwmmm team 0 at 5.38 min
  5.38  [Playtest] finished cortl team 0 at 5.38 min
  5.39  [Playtest] finished corfmkr team 0 at 5.39 min
  5.44  [Playtest] finished cornanotcplat team 0 at 5.44 min
  5.69  [Playtest] finished coruwmmm team 0 at 5.69 min
  5.76  [Playtest] finished cortl team 0 at 5.76 min
  5.80  [Playtest] finished cornanotcplat team 0 at 5.80 min
  5.84  [Playtest] finished corfmkr team 0 at 5.84 min
  5.88  [Playtest] finished corfmkr team 0 at 5.88 min
  5.97  [Playtest] finished corfmkr team 0 at 5.97 min
  6.00  [Playtest] finished cornanotcplat team 0 at 6.00 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +197.4 bank 85027/102750, energy +16433.0 bank 1033922/1035550, units 127
  6.05  [Playtest] finished corfmkr team 0 at 6.05 min
  6.07  [Playtest] finished corplat team 0 at 6.07 min
  6.21  [Playtest] finished corfmkr team 0 at 6.21 min
  6.30  [Playtest] finished cornanotcplat team 0 at 6.30 min
  6.39  [Playtest] finished corfmkr team 0 at 6.39 min
  6.40  [Playtest] finished corfmkr team 0 at 6.40 min
  6.44  [Playtest] finished cortide team 0 at 6.44 min
  6.48  [Playtest] finished cortide team 0 at 6.48 min
  6.60  [Playtest] finished cortide team 0 at 6.60 min
  6.62  [Playtest] finished corfmkr team 0 at 6.62 min
  6.68  [Playtest] finished corfmkr team 0 at 6.68 min
  6.75  [Playtest] finished corfmkr team 0 at 6.75 min
  6.76  [Playtest] finished corfmkr team 0 at 6.76 min
  6.78  [Playtest] finished corfmkr team 0 at 6.78 min
  6.82  [Playtest] finished cornanotcplat team 0 at 6.82 min
  7.00  [Playtest] finished cortide team 0 at 6.99 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +206.9 bank 83448/102750, energy +16496.0 bank 1033625/1035950, units 162
  7.06  [Playtest] finished corfmkr team 0 at 7.06 min
  7.09  [Playtest] finished corfmkr team 0 at 7.09 min
  7.16  [Playtest] finished corfmkr team 0 at 7.16 min
  7.23  [Playtest] finished cortide team 0 at 7.23 min
  7.24  [Playtest] finished corfmkr team 0 at 7.24 min
  7.32  [Playtest] finished cornanotcplat team 0 at 7.32 min
  7.62  [Playtest] finished cornanotcplat team 0 at 7.62 min
  7.79  [Playtest] finished cornanotcplat team 0 at 7.79 min
  7.89  [Playtest] finished cornanotcplat team 0 at 7.89 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +210.9 bank 82791/102750, energy +16538.0 bank 1033300/1036000, units 190
  8.00  [Playtest] camera requested (6200,11000) height=4000
  8.01  [Playtest] camera captured name=ta position=(6200,11000) height=4000
  8.01  [Playtest] screenshot at 8.0 min of team 0 at (6200, 11000)
  8.03  [Playtest] finished cormex team 0 at 8.03 min
  8.04  [Playtest] finished cormex team 0 at 8.04 min
  8.07  [Playtest] finished cornanotcplat team 0 at 8.07 min
  8.18  [Playtest] finished cornanotcplat team 0 at 8.18 min
  8.34  [Playtest] finished cornanotcplat team 0 at 8.34 min
  8.45  [Playtest] finished cornanotcplat team 0 at 8.45 min
  8.68  [Playtest] finished cornanotcplat team 0 at 8.68 min
  8.78  [Playtest] finished cornanotcplat team 0 at 8.78 min
  8.90  [Playtest] finished cormex team 0 at 8.90 min
  8.96  [Playtest] finished corfrad team 0 at 8.96 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +217.8 bank 81332/102900, energy +16538.0 bank 1032618/1036000, units 219
  9.00  [Playtest] finished cornanotcplat team 0 at 9.00 min
  9.23  [Playtest] finished cornanotcplat team 0 at 9.23 min
  9.30  [Playtest] finished coruwmme team 0 at 9.30 min
  9.36  [Playtest] finished cornanotcplat team 0 at 9.36 min
  9.36  [Playtest] finished cortl team 0 at 9.36 min
  9.47  [Playtest] finished cormex team 0 at 9.47 min
  9.59  [Playtest] finished cornanotcplat team 0 at 9.59 min
  9.64  [Playtest] finished cortl team 0 at 9.64 min
  9.96  [Playtest] finished cornanotcplat team 0 at 9.96 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +227.0 bank 81292/103500, energy +16538.0 bank 1033540/1036000, units 246
 10.07  [Playtest] finished cornanotcplat team 0 at 10.07 min
 10.18  [Playtest] finished cornanotcplat team 0 at 10.18 min
 10.29  [Playtest] finished cornanotcplat team 0 at 10.29 min
 10.41  [Playtest] finished cornanotcplat team 0 at 10.41 min
 10.50  [Playtest] finished cornanotcplat team 0 at 10.50 min
 10.62  [Playtest] finished cornanotcplat team 0 at 10.62 min
 10.71  [Playtest] finished cornanotcplat team 0 at 10.71 min
 10.90  [Playtest] finished cornanotcplat team 0 at 10.90 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +227.0 bank 79698/103500, energy +16538.0 bank 1032457/1036000, units 278
 11.07  [Playtest] finished cornanotcplat team 0 at 11.07 min
 11.13  [Playtest] finished coruwmme team 0 at 11.13 min
 11.18  [Playtest] finished cornanotcplat team 0 at 11.18 min
 11.24  [Playtest] finished cornanotcplat team 0 at 11.24 min
 11.26  [Playtest] finished corrad team 0 at 11.26 min
 11.31  [Playtest] finished cornanotcplat team 0 at 11.31 min
 11.48  [Playtest] finished cornanotcplat team 0 at 11.48 min
 11.62  [Playtest] finished cornanotcplat team 0 at 11.62 min
 11.69  [Playtest] finished cornanotcplat team 0 at 11.69 min
 11.76  [Playtest] finished cornanotcplat team 0 at 11.76 min
 11.91  [Playtest] finished cornanotcplat team 0 at 11.91 min
 11.96  [Playtest] finished corfrad team 0 at 11.96 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +236.3 bank 79634/104100, energy +16538.0 bank 1033848/1036000, units 311
 12.07  [Playtest] finished cornanotcplat team 0 at 12.07 min
```

## Native lines (all AIs, first 120)

```
  0.18  RESERVE: zone 1 at (5832, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5832, 10648) facing 0 (id 1)
  0.18  RESERVE: zone 2 at (5784, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5784, 10648) facing 0 (id 2)
  0.18  RESERVE: zone 3 at (5880, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5880, 10648) facing 0 (id 3)
  0.18  RESERVE: zone 4 at (5736, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5736, 10648) facing 0 (id 4)
  0.18  RESERVE: zone 5 at (5928, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5928, 10648) facing 0 (id 5)
  0.18  RESERVE: zone 6 at (5832, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5832, 10600) facing 0 (id 6)
  0.18  RESERVE: zone 7 at (5784, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5784, 10600) facing 0 (id 7)
  0.18  RESERVE: zone 8 at (5880, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5880, 10600) facing 0 (id 8)
  0.18  RESERVE: zone 9 at (5976, 10696) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5976, 10696) facing 0 (id 9)
  0.18  RESERVE: zone 10 at (5736, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5736, 10600) facing 0 (id 10)
  0.18  RESERVE: zone 11 at (5928, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5928, 10600) facing 0 (id 11)
  0.18  RESERVE: zone 12 at (5688, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5688, 10648) facing 0 (id 12)
  0.18  RESERVE: zone 13 at (5976, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5976, 10648) facing 0 (id 13)
  0.18  RESERVE: zone 14 at (5832, 10552) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5832, 10552) facing 0 (id 14)
  0.18  RESERVE: zone 15 at (5784, 10552) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5784, 10552) facing 0 (id 15)
  0.18  RESERVE: zone 16 at (5880, 10552) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5880, 10552) facing 0 (id 16)
  0.18  RESERVE: zone 17 at (5640, 10696) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5640, 10696) facing 0 (id 17)
  0.18  RESERVE: zone 18 at (6024, 10696) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (6024, 10696) facing 0 (id 18)
  0.18  RESERVE: zone 19 at (5688, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5688, 10600) facing 0 (id 19)
  0.18  RESERVE: zone 20 at (5976, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5976, 10600) facing 0 (id 20)
  0.18  RESERVE: zone 21 at (5736, 10552) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5736, 10552) facing 0 (id 21)
  0.18  RESERVE: zone 22 at (5928, 10552) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5928, 10552) facing 0 (id 22)
  0.18  RESERVE: zone 23 at (5640, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5640, 10648) facing 0 (id 23)
  0.18  RESERVE: zone 24 at (6024, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (6024, 10648) facing 0 (id 24)
  0.18  RESERVE: zone 25 at (5832, 10504) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5832, 10504) facing 0 (id 25)
  0.18  RESERVE: zone 26 at (5688, 10552) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5688, 10552) facing 0 (id 26)
  0.18  RESERVE: zone 27 at (5976, 10552) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5976, 10552) facing 0 (id 27)
  0.18  RESERVE: zone 28 at (5640, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5640, 10600) facing 0 (id 28)
  0.18  RESERVE: zone 29 at (6024, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (6024, 10600) facing 0 (id 29)
  0.18  RESERVE: zone 30 at (5784, 10504) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5784, 10504) facing 0 (id 30)
  0.18  RESERVE: zone 31 at (5880, 10504) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5880, 10504) facing 0 (id 31)
  0.18  RESERVE: zone 32 at (6072, 10696) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (6072, 10696) facing 0 (id 32)
  0.18  RESERVE: zone 33 at (5736, 10504) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5736, 10504) facing 0 (id 33)
  0.18  RESERVE: zone 34 at (5928, 10504) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5928, 10504) facing 0 (id 34)
  0.18  RESERVE: zone 35 at (6072, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (6072, 10648) facing 0 (id 35)
  0.18  RESERVE: zone 36 at (5640, 10552) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5640, 10552) facing 0 (id 36)
  0.18  RESERVE: zone 37 at (6024, 10552) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (6024, 10552) facing 0 (id 37)
  0.18  RESERVE: zone 38 at (5688, 10504) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5688, 10504) facing 0 (id 38)
  0.18  RESERVE: zone 39 at (5976, 10504) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5976, 10504) facing 0 (id 39)
  0.18  RESERVE: zone 40 at (6072, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (6072, 10600) facing 0 (id 40)
  0.18  RESERVE: zone 41 at (5832, 10456) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5832, 10456) facing 0 (id 41)
  0.18  RESERVE: zone 42 at (5784, 10456) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5784, 10456) facing 0 (id 42)
  0.18  RESERVE: zone 43 at (5880, 10456) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5880, 10456) facing 0 (id 43)
  0.18  RESERVE: zone 44 at (6120, 10696) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (6120, 10696) facing 0 (id 44)
  0.18  RESERVE: zone 45 at (5736, 10456) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5736, 10456) facing 0 (id 45)
  0.18  RESERVE: zone 46 at (5928, 10456) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5928, 10456) facing 0 (id 46)
  0.18  RESERVE: zone 47 at (6120, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (6120, 10648) facing 0 (id 47)
  0.18  RESERVE: zone 48 at (5640, 10504) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5640, 10504) facing 0 (id 48)
  0.18  RESERVE: zone 49 at (6024, 10504) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (6024, 10504) facing 0 (id 49)
  0.18  RESERVE: zone 50 at (6072, 10552) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (6072, 10552) facing 0 (id 50)
  0.18  RESERVE: zone 51 at (5688, 10456) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5688, 10456) facing 0 (id 51)
  0.18  RESERVE: zone 52 at (5976, 10456) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5976, 10456) facing 0 (id 52)
  0.18  RESERVE: zone 53 at (6120, 10600) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (6120, 10600) facing 0 (id 53)
  0.18  RESERVE: zone 54 at (5832, 10408) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5832, 10408) facing 0 (id 54)
  0.18  RESERVE: zone 55 at (5784, 10408) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5784, 10408) facing 0 (id 55)
  0.18  RESERVE: zone 56 at (5880, 10408) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5880, 10408) facing 0 (id 56)
  0.18  RESERVE: zone 57 at (6072, 10504) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (6072, 10504) facing 0 (id 57)
  0.18  RESERVE: zone 58 at (6168, 10696) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (6168, 10696) facing 0 (id 58)
  0.18  RESERVE: zone 59 at (5640, 10456) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5640, 10456) facing 0 (id 59)
  0.18  RESERVE: zone 60 at (6024, 10456) facing 0, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (6024, 10456) facing 0 (id 60)
```
