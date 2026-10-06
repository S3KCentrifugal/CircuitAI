# Playtest report: PASS

- Verdict: **PASS** (reached 24 min)
- Game time reached: 24.1 min (frame 43320); wall 424 s
- DLL: build-theatres\d212-final\SkirmishAI.dll (f224e17dc3c6f798); AI BARbTest/test; staged 2026-10-06T00:07:24
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/legion/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: amphibious-transition.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T030724Z-211681ba\runs\20261006T031432Z-edbf1d89\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `partial-survey` | seen at 1.8 min | `[t=00:00:52.988778][f=0003300] [SeaInvasionTest] PASS partial-survey-blocked` |
| expect `complex` | seen at 5.3 min | `[t=00:01:40.060723][f=0009523] [SeaInvasionTest] PASS complex-finished` |
| expect `gantry` | seen at 10.9 min | `[t=00:03:08.145053][f=0019540] [SeaInvasionTest] PASS gantry-finished` |
| expect `complex-production` | seen at 5.6 min | `[t=00:01:43.987456][f=0010116] [SeaInvasionTest] PASS complex-produced` |
| expect `gantry-production` | seen at 11.3 min | `[t=00:03:14.111957][f=0020332] [SeaInvasionTest] PASS gantry-produced` |
| expect `landfall` | seen at 7.7 min | `[t=00:02:12.931396][f=0013800] [SeaInvasionTest] PASS landfall` |
| expect `backline` | seen at 7.8 min | `[t=00:02:15.317718][f=0014100] [SeaInvasionTest] PASS backline-reached` |
| expect `escort` | seen at 4.9 min | `[t=00:01:34.469438][f=0008854] [SeaInvasionTest] PASS factory-escorted` |
| expect `gantry-landing` | seen at 12.7 min | `[t=00:03:34.540888][f=0022800] [SeaInvasionTest] PASS gantry-landfall` |
| expect `gantry-backline` | seen at 13.3 min | `[t=00:03:45.988598][f=0024000] [SeaInvasionTest] PASS gantry-backline` |
| expect `combat` | seen at 9.5 min | `[t=00:02:42.486400][f=0017061] [SeaInvasionTest] PASS amphibian-damaged-economy` |
| forbid `errors` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T030724Z-211681ba\runs\20261006T031432Z-edbf1d89\screen_2026-10-06_03-08-23-764.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T030724Z-211681ba\runs\20261006T031432Z-edbf1d89\screen_2026-10-06_03-09-03-696.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T030724Z-211681ba\runs\20261006T031432Z-edbf1d89\screen_2026-10-06_03-09-05-703.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T030724Z-211681ba\runs\20261006T031432Z-edbf1d89\screen_2026-10-06_03-09-42-185.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T030724Z-211681ba\runs\20261006T031432Z-edbf1d89\screen_2026-10-06_03-09-53-886.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T030724Z-211681ba\runs\20261006T031432Z-edbf1d89\screen_2026-10-06_03-10-20-070.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T030724Z-211681ba\runs\20261006T031432Z-edbf1d89\screen_2026-10-06_03-12-02-526.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 20, 4 shots, end at 24.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished legcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 20000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side legion ai true dead false start (5800, 10500) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 35
  0.00  [Playtest] speed 20
  0.05  [Playtest] frame 90 team 0 ally 0 side legion ai true dead false start (5800, 10500) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 35
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.18  [Playtest] finished legsy team 0 at 0.18 min
  0.18  [Playtest] finished legadvshipyard team 0 at 0.18 min
  0.18  [Playtest] finished legsplab team 0 at 0.18 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.18  [Playtest] finished leganavalfusion team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [SEA][Layout] berth sea.berth.0 legadvshipyard at=7456,10032 facing=2
  0.20  [SEA][Layout] berth sea.berth.1 legsplab at=7056,10032 facing=2
  0.43  [SEA][Layout] berth sea.berth.2 legsy at=7744,10032 facing=2
  0.46  [Playtest] finished legtide team 0 at 0.46 min
  0.53  [Playtest] finished legmex team 0 at 0.53 min
  0.53  [Team][Roster] first mex 31828 at 6528,10320
  0.53  [Team][Roster] Re-announced: roster|1|0|0|SEA|legion|legsy|5829|10504|0|7|1|6528|10320
  1.00  [Playtest] finished leganavalmex team 0 at 1.00 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +470.4 bank 39821/100900, energy +29491.0 bank 1047877/1061550, units 113
  1.03  [Playtest] finished legmex team 0 at 1.03 min
  1.08  [Playtest] finished legadvshipyard team 0 at 1.08 min
  1.18  [Playtest] finished leganavalsonarstation team 0 at 1.18 min
  1.25  [SEA][Layout] berth sea.berth.3 legadvshipyard at=7936,10032 facing=2
  1.32  [Playtest] finished legnanotcplat team 0 at 1.32 min
  1.61  [Playtest] finished legfeconv team 0 at 1.61 min
  1.67  [Playtest] finished legmex team 0 at 1.67 min
  1.68  [Playtest] finished legnanotcplat team 0 at 1.67 min
  1.74  [Playtest] finished leganavalmex team 0 at 1.74 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +489.2 bank 66297/101750, energy +29491.0 bank 1048181/1061750, units 118
  2.00  [Playtest] camera requested (8500,6500) height=8500
  2.01  [Playtest] camera captured name=ta position=(8500,6500) height=8500
  2.01  [Playtest] screenshot at 2.0 min of team 0 at (8500, 6500)
  2.16  [Playtest] finished legfrad team 0 at 2.16 min
  2.33  [Playtest] finished legtl team 0 at 2.33 min
  2.39  [Playtest] finished legadvshipyard team 0 at 2.39 min
  2.56  [Playtest] finished leganavalmex team 0 at 2.56 min
  2.64  [Playtest] finished legtl team 0 at 2.64 min
  2.70  [Playtest] finished legfrad team 0 at 2.70 min
  2.73  [SEA][Layout] berth sea.berth.4 legadvshipyard at=6496,10032 facing=2
  2.75  [Playtest] finished legtl team 0 at 2.75 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +496.1 bank 91358/102500, energy +29491.0 bank 1048143/1061950, units 350
  3.33  [Playtest] finished legtl team 0 at 3.33 min
  3.34  [Playtest] finished legadvshipyard team 0 at 3.34 min
  3.55  [Playtest] finished legfrad team 0 at 3.55 min
  3.73  [Playtest] finished legtl team 0 at 3.73 min
  3.81  [Playtest] finished legmex team 0 at 3.81 min
  3.94  [Playtest] finished legtl team 0 at 3.93 min
  3.96  [Playtest] finished leganavaleconv team 0 at 3.96 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +508.7 bank 102750/102750, energy +29491.0 bank 1048374/1062150, units 354
  4.40  [Playtest] finished legmex team 0 at 4.40 min
  4.71  [Playtest] finished legmex team 0 at 4.71 min
  4.95  [Playtest] finished legmex team 0 at 4.95 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +516.4 bank 102898/102900, energy +29491.0 bank 1048275/1062150, units 358
  5.00  [Playtest] camera requested (10800,4000) height=6500
  5.01  [Playtest] camera captured name=ta position=(10800,4000) height=6500
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (10800, 4000)
  5.29  [Playtest] finished legamphlab team 0 at 5.29 min
  5.45  [Playtest] finished legmex team 0 at 5.45 min
  5.52  [Playtest] finished legnanotcplat team 0 at 5.52 min
  5.67  [SEA][Layout] berth sea.berth.5 legadvshipyard at=7456,8976 facing=2
  5.74  [Playtest] finished legmex team 0 at 5.74 min
  5.87  [Playtest] finished legnanotcplat team 0 at 5.87 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +520.5 bank 102998/103000, energy +29491.0 bank 1048291/1062310, units 369
  6.07  [Playtest] finished legnanotcplat team 0 at 6.07 min
  6.26  [Playtest] finished legnanotcplat team 0 at 6.26 min
  6.32  [Playtest] finished legnanotcplat team 0 at 6.32 min
  6.35  [Playtest] finished legnanotcplat team 0 at 6.35 min
  6.37  [Playtest] finished legmex team 0 at 6.37 min
  6.61  [Playtest] finished legrad team 0 at 6.61 min
  6.74  [Playtest] finished legmex team 0 at 6.74 min
  6.82  [Playtest] finished leglht team 0 at 6.82 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +525.1 bank 103097/103100, energy +29491.0 bank 1048382/1062310, units 378
  7.07  [Playtest] finished legfrad team 0 at 7.07 min
  7.36  [Playtest] finished legadvshipyard team 0 at 7.36 min
  7.48  [Playtest] finished leglht team 0 at 7.48 min
  7.66  [Playtest] finished legtl team 0 at 7.66 min
  7.66  [Playtest] finished legrad team 0 at 7.66 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +525.1 bank 103298/103300, energy +29491.0 bank 1048577/1062510, units 385
  8.03  [Playtest] finished legtl team 0 at 8.03 min
  8.05  [SEA][Layout] berth sea.berth.6 legadvshipyard at=8608,10032 facing=2
  8.27  [Playtest] finished leglht team 0 at 8.27 min
  8.45  [Playtest] finished legrad team 0 at 8.45 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +524.3 bank 103298/103300, energy +29491.0 bank 1048518/1062510, units 392
  9.11  [Playtest] finished leglht team 0 at 9.11 min
  9.29  [Playtest] finished legrad team 0 at 9.29 min
  9.99  [Playtest] finished legnanotcplat team 0 at 9.99 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +524.3 bank 103290/103300, energy +29491.0 bank 1048409/1062510, units 396
 10.00  [Playtest] camera requested (10800,4000) height=5500
 10.02  [Playtest] camera captured name=ta position=(10800,4000) height=5500
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (10800, 4000)
 10.21  [Playtest] finished leganavaleconv team 0 at 10.21 min
 10.40  [Playtest] finished legnanotcplat team 0 at 10.40 min
 10.68  [Playtest] finished leganavalmex team 0 at 10.68 min
 10.82  [Playtest] finished legnanotcplat team 0 at 10.82 min
 10.86  [Playtest] finished leggantuw team 0 at 10.86 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +541.6 bank 104646/104650, energy +29491.0 bank 1049048/1063910, units 402
 11.12  [Playtest] finished legnanotcplat team 0 at 11.12 min
 11.27  [Playtest] finished legnanotcplat team 0 at 11.27 min
 11.40  [Playtest] finished legnanotcplat team 0 at 11.40 min
 11.81  [Playtest] finished legadvshipyard team 0 at 11.81 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +541.6 bank 104847/104850, energy +29491.0 bank 1049553/1064110, units 405
 12.22  [SEA][Layout] berth sea.berth.7 legadvshipyard at=7904,8960 facing=2
 12.71  [Playtest] finished legadvshipyard team 0 at 12.71 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +541.6 bank 105047/105050, energy +29491.0 bank 1048992/1064310, units 412
 14.00  [Playtest] eco team 0 at 14.0 min: metal +541.6 bank 105045/105050, energy +29491.0 bank 1049753/1064310, units 418
 15.00  [Playtest] eco team 0 at 15.0 min: metal +541.6 bank 105045/105050, energy +29491.0 bank 1049753/1064310, units 424
 16.00  [Playtest] eco team 0 at 16.0 min: metal +541.6 bank 105045/105050, energy +29491.0 bank 1049971/1064310, units 430
 16.00  [Playtest] camera requested (11000,2800) height=5500
 16.02  [Playtest] camera captured name=ta position=(11000,2800) height=5500
 16.02  [Playtest] screenshot at 16.0 min of team 0 at (11000, 2800)
 17.00  [Playtest] eco team 0 at 17.0 min: metal +541.6 bank 105045/105050, energy +29491.0 bank 1049718/1064310, units 435
 18.00  [Playtest] eco team 0 at 18.0 min: metal +541.6 bank 105045/105050, energy +29491.0 bank 1049718/1064310, units 441
 19.00  [Playtest] eco team 0 at 19.0 min: metal +541.6 bank 105044/105050, energy +29491.0 bank 1049772/1064310, units 446
 20.00  [Playtest] eco team 0 at 20.0 min: metal +541.6 bank 105043/105050, energy +29491.0 bank 1049718/1064310, units 453
 20.92  [Playtest] finished legamstor team 0 at 20.92 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +541.6 bank 107408/115050, energy +29491.0 bank 1049718/1064310, units 459
 22.00  [Playtest] eco team 0 at 22.0 min: metal +541.6 bank 115043/115050, energy +29491.0 bank 1049718/1064310, units 465
 23.00  [Playtest] eco team 0 at 23.0 min: metal +541.6 bank 115043/115050, energy +29491.0 bank 1049718/1064310, units 470
 24.00  [Playtest] eco team 0 at 24.0 min: metal +541.6 bank 115044/115050, energy +29491.0 bank 1049725/1064310, units 476
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: zone 1 at (5912, 11112) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: legtide at (5912, 11112) facing 2 (id 1)
  0.08  RESERVE: zone 1 released
  0.08  RESERVE: zone 2 at (5864, 10984) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: legtide at (5864, 10984) facing 2 (id 2)
  0.08  RESERVE: zone 3 at (5816, 10984) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: legtide at (5816, 10984) facing 2 (id 3)
  0.08  RESERVE: zone 2 released
  0.08  RESERVE: zone 3 released
  0.08  RESERVE: zone 4 at (5880, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: legtide at (5880, 10952) facing 2 (id 4)
  0.08  RESERVE: zone 5 at (5832, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: legtide at (5832, 10952) facing 2 (id 5)
  0.08  RESERVE: zone 6 at (5784, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: legtide at (5784, 10952) facing 2 (id 6)
  0.08  RESERVE: zone 4 released
  0.08  RESERVE: zone 5 released
  0.08  RESERVE: zone 6 released
  0.08  RESERVE: zone 7 at (5912, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: legtide at (5912, 10936) facing 2 (id 7)
  0.08  RESERVE: zone 8 at (5864, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: legtide at (5864, 10936) facing 2 (id 8)
  0.08  RESERVE: zone 9 at (5816, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: legtide at (5816, 10936) facing 2 (id 9)
  0.08  RESERVE: zone 10 at (5768, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: legtide at (5768, 10936) facing 2 (id 10)
  0.08  RESERVE: zone 7 released
  0.08  RESERVE: zone 8 released
  0.08  RESERVE: zone 9 released
  0.08  RESERVE: zone 10 released
  0.08  RESERVE: zone 11 at (5944, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: legtide at (5944, 10920) facing 2 (id 11)
  0.08  RESERVE: zone 12 at (5896, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: legtide at (5896, 10920) facing 2 (id 12)
  0.08  RESERVE: zone 13 at (5848, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: legtide at (5848, 10920) facing 2 (id 13)
  0.08  RESERVE: zone 14 at (5800, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: legtide at (5800, 10920) facing 2 (id 14)
  0.08  RESERVE: zone 11 released
  0.08  RESERVE: zone 12 released
  0.08  RESERVE: zone 13 released
  0.08  RESERVE: zone 14 released
  0.12  RESERVE: zone 15 at (5992, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5992, 10936) facing 2 (id 15)
  0.12  RESERVE: zone 16 at (5944, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5944, 10936) facing 2 (id 16)
  0.12  RESERVE: zone 17 at (5896, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5896, 10936) facing 2 (id 17)
  0.12  RESERVE: zone 18 at (5848, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5848, 10936) facing 2 (id 18)
  0.12  RESERVE: zone 19 at (5800, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5800, 10936) facing 2 (id 19)
  0.12  RESERVE: zone 15 released
  0.12  RESERVE: zone 16 released
  0.12  RESERVE: zone 17 released
  0.12  RESERVE: zone 18 released
  0.12  RESERVE: zone 19 released
  0.12  RESERVE: zone 20 at (6024, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (6024, 10952) facing 2 (id 20)
  0.12  RESERVE: zone 21 at (5976, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5976, 10952) facing 2 (id 21)
  0.12  RESERVE: zone 22 at (5928, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5928, 10952) facing 2 (id 22)
  0.12  RESERVE: zone 23 at (5880, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5880, 10952) facing 2 (id 23)
  0.12  RESERVE: zone 24 at (5832, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5832, 10952) facing 2 (id 24)
  0.12  RESERVE: zone 25 at (5784, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5784, 10952) facing 2 (id 25)
  0.12  RESERVE: zone 26 at (6024, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (6024, 10904) facing 2 (id 26)
  0.12  RESERVE: zone 27 at (5976, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5976, 10904) facing 2 (id 27)
  0.12  RESERVE: zone 28 at (5928, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5928, 10904) facing 2 (id 28)
  0.12  RESERVE: zone 29 at (5880, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5880, 10904) facing 2 (id 29)
  0.12  RESERVE: zone 30 at (5832, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5832, 10904) facing 2 (id 30)
  0.12  RESERVE: zone 31 at (5784, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5784, 10904) facing 2 (id 31)
  0.12  RESERVE: zone 32 at (6024, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (6024, 10856) facing 2 (id 32)
  0.12  RESERVE: zone 33 at (5976, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5976, 10856) facing 2 (id 33)
  0.12  RESERVE: zone 34 at (5928, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5928, 10856) facing 2 (id 34)
  0.12  RESERVE: zone 35 at (5880, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5880, 10856) facing 2 (id 35)
  0.12  RESERVE: zone 36 at (5832, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5832, 10856) facing 2 (id 36)
  0.12  RESERVE: zone 37 at (5784, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5784, 10856) facing 2 (id 37)
  0.12  RESERVE: zone 38 at (6024, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (6024, 10808) facing 2 (id 38)
  0.12  RESERVE: zone 39 at (5976, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5976, 10808) facing 2 (id 39)
  0.12  RESERVE: zone 40 at (5928, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5928, 10808) facing 2 (id 40)
  0.12  RESERVE: zone 41 at (5880, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5880, 10808) facing 2 (id 41)
  0.12  RESERVE: zone 42 at (5832, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5832, 10808) facing 2 (id 42)
  0.12  RESERVE: zone 43 at (5784, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5784, 10808) facing 2 (id 43)
  0.12  RESERVE: zone 44 at (6024, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (6024, 10760) facing 2 (id 44)
  0.12  RESERVE: zone 45 at (5976, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5976, 10760) facing 2 (id 45)
  0.12  RESERVE: zone 46 at (5928, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5928, 10760) facing 2 (id 46)
  0.12  RESERVE: zone 47 at (5880, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5880, 10760) facing 2 (id 47)
  0.12  RESERVE: zone 48 at (5832, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5832, 10760) facing 2 (id 48)
  0.12  RESERVE: zone 49 at (5784, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (5784, 10760) facing 2 (id 49)
  0.12  RESERVE: zone 50 at (6024, 10712) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legtide at (6024, 10712) facing 2 (id 50)
  0.12  RESERVE: zone 51 at (5976, 10712) facing 2, 3x3 cells: 9 of 9 held
```
