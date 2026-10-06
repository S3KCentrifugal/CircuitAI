# Playtest report: PASS

- Verdict: **PASS** (reached 24 min)
- Game time reached: 24.0 min (frame 43260); wall 466 s
- DLL: build-theatres\d212-final\SkirmishAI.dll (f224e17dc3c6f798); AI BARbTest/test; staged 2026-10-06T00:45:55
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/legion/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: amphibious-transition.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T034555Z-6a426aa3\runs\20261006T035345Z-639013c7\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `partial-survey` | seen at 1.8 min | `[t=00:01:33.771169][f=0003300] [SeaInvasionTest] PASS partial-survey-blocked` |
| expect `complex` | seen at 5.9 min | `[t=00:02:30.700998][f=0010604] [SeaInvasionTest] PASS complex-finished` |
| expect `gantry` | seen at 11.5 min | `[t=00:03:55.989780][f=0020744] [SeaInvasionTest] PASS gantry-finished` |
| expect `complex-production` | seen at 6.2 min | `[t=00:02:35.018950][f=0011196] [SeaInvasionTest] PASS complex-produced` |
| expect `gantry-production` | seen at 12.0 min | `[t=00:04:02.605572][f=0021513] [SeaInvasionTest] PASS gantry-produced` |
| expect `landfall` | seen at 8.3 min | `[t=00:03:05.928414][f=0015000] [SeaInvasionTest] PASS landfall` |
| expect `backline` | seen at 9.5 min | `[t=00:03:23.386708][f=0017100] [SeaInvasionTest] PASS backline-reached` |
| expect `escort` | seen at 4.2 min | `[t=00:02:07.823316][f=0007623] [SeaInvasionTest] PASS factory-escorted` |
| expect `complex-support` | seen at 7.5 min | `[t=00:02:52.854298][f=0013500] [SeaInvasionTest] PASS complex-support-six` |
| expect `gantry-support` | seen at 12.0 min | `[t=00:04:03.321200][f=0021600] [SeaInvasionTest] PASS gantry-support-twelve` |
| expect `gantry-landing` | seen at 13.8 min | `[t=00:04:34.209464][f=0024900] [SeaInvasionTest] PASS gantry-landfall` |
| expect `gantry-backline` | seen at 15.7 min | `[t=00:05:07.610837][f=0028200] [SeaInvasionTest] PASS gantry-backline` |
| expect `combat` | seen at 10.0 min | `[t=00:03:31.398484][f=0017985] [SeaInvasionTest] PASS amphibian-damaged-economy` |
| forbid `errors` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T034555Z-6a426aa3\runs\20261006T035345Z-639013c7\screen_2026-10-06_03-47-35-091.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T034555Z-6a426aa3\runs\20261006T035345Z-639013c7\screen_2026-10-06_03-48-07-661.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T034555Z-6a426aa3\runs\20261006T035345Z-639013c7\screen_2026-10-06_03-48-18-814.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T034555Z-6a426aa3\runs\20261006T035345Z-639013c7\screen_2026-10-06_03-49-05-790.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T034555Z-6a426aa3\runs\20261006T035345Z-639013c7\screen_2026-10-06_03-49-20-947.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T034555Z-6a426aa3\runs\20261006T035345Z-639013c7\screen_2026-10-06_03-49-32-252.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T034555Z-6a426aa3\runs\20261006T035345Z-639013c7\screen_2026-10-06_03-51-07-487.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T034555Z-6a426aa3\runs\20261006T035345Z-639013c7\screen_2026-10-06_03-51-13-347.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 20, 4 shots, end at 24.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished legcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 20000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side legion ai true dead false start (5800, 10500) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 22
  0.00  [Playtest] speed 20
  0.05  [Playtest] frame 90 team 0 ally 0 side legion ai true dead false start (5800, 10500) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 22
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
  0.46  [Playtest] finished legtide team 0 at 0.46 min
  0.55  [SEA][Layout] berth sea.berth.2 legsy at=7744,10032 facing=2
  0.57  [Playtest] finished legmex team 0 at 0.57 min
  0.58  [Team][Roster] first mex 13766 at 6528,10320
  0.58  [Team][Roster] Re-announced: roster|1|0|0|SEA|legion|legsy|5829|10504|0|7|1|6528|10320
  1.00  [Playtest] eco team 0 at 1.0 min: metal +469.8 bank 42404/100350, energy +29491.0 bank 1047938/1061550, units 114
  1.06  [Playtest] finished legmex team 0 at 1.06 min
  1.19  [Playtest] finished legfeconv team 0 at 1.19 min
  1.34  [Playtest] finished legnanotcplat team 0 at 1.34 min
  1.42  [Playtest] finished legnanotcplat team 0 at 1.42 min
  1.70  [Playtest] finished legmex team 0 at 1.70 min
  1.76  [Playtest] finished legadvshipyard team 0 at 1.76 min
  1.80  [Playtest] finished legfrad team 0 at 1.80 min
  1.92  [SEA][Layout] berth sea.berth.3 legadvshipyard at=7936,10032 facing=2
  2.00  [Playtest] eco team 0 at 2.0 min: metal +475.4 bank 67391/100650, energy +29491.0 bank 1048214/1061750, units 121
  2.00  [Playtest] camera requested (8500,6500) height=8500
  2.01  [Playtest] camera captured name=ta position=(8500,6500) height=8500
  2.01  [Playtest] screenshot at 2.0 min of team 0 at (8500, 6500)
  2.04  [Playtest] finished legtl team 0 at 2.04 min
  2.24  [Playtest] finished legmex team 0 at 2.24 min
  2.47  [Playtest] finished legtl team 0 at 2.47 min
  2.50  [Playtest] finished legtl team 0 at 2.50 min
  2.60  [Playtest] finished legfrad team 0 at 2.60 min
  2.70  [Playtest] finished leganavalmex team 0 at 2.70 min
  2.73  [Playtest] finished legadvshipyard team 0 at 2.73 min
  2.93  [Playtest] finished legfrad team 0 at 2.93 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +484.6 bank 91787/101450, energy +29491.0 bank 1048331/1061950, units 351
  3.08  [Playtest] finished legtl team 0 at 3.08 min
  3.10  [SEA][Layout] berth sea.berth.4 legadvshipyard at=6400,10032 facing=2
  3.31  [Playtest] finished legmex team 0 at 3.31 min
  3.42  [Playtest] finished legfrad team 0 at 3.42 min
  3.53  [Playtest] finished legtl team 0 at 3.53 min
  3.68  [Playtest] finished legtl team 0 at 3.68 min
  3.80  [Playtest] finished legmex team 0 at 3.80 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +487.7 bank 101491/101500, energy +29491.0 bank 1048180/1061950, units 356
  4.02  [Playtest] finished legtl team 0 at 4.02 min
  4.14  [Playtest] finished leganavalmex team 0 at 4.14 min
  4.16  [Playtest] finished legtl team 0 at 4.16 min
  4.38  [Playtest] finished legmex team 0 at 4.38 min
  4.69  [Playtest] finished legmex team 0 at 4.69 min
  4.84  [Playtest] finished leganavaleconv team 0 at 4.84 min
  4.93  [Playtest] finished legmex team 0 at 4.93 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +511.0 bank 102199/102200, energy +29491.0 bank 1048021/1061950, units 361
  5.00  [Playtest] camera requested (10800,4000) height=6500
  5.01  [Playtest] camera captured name=ta position=(10800,4000) height=6500
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (10800, 4000)
  5.17  [Playtest] finished leganavalmex team 0 at 5.17 min
  5.42  [Playtest] finished legmex team 0 at 5.42 min
  5.71  [Playtest] finished legmex team 0 at 5.71 min
  5.89  [Playtest] finished legamphlab team 0 at 5.89 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +522.8 bank 102848/102850, energy +29491.0 bank 1048113/1062110, units 366
  6.11  [Playtest] finished legnanotcplat team 0 at 6.11 min
  6.18  [Playtest] finished leganavalmex team 0 at 6.18 min
  6.46  [Playtest] finished legmex team 0 at 6.46 min
  6.55  [Playtest] finished legrad team 0 at 6.55 min
  6.59  [Playtest] finished legnanotcplat team 0 at 6.59 min
  6.79  [Playtest] finished leglht team 0 at 6.79 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +532.0 bank 103447/103450, energy +29491.0 bank 1048062/1062110, units 376
  7.00  [Playtest] finished legnanotcplat team 0 at 7.00 min
  7.26  [Playtest] finished legnanotcplat team 0 at 7.26 min
  7.30  [Playtest] finished legnanotcplat team 0 at 7.30 min
  7.40  [Playtest] finished legnanotcplat team 0 at 7.40 min
  7.47  [Playtest] finished leglht team 0 at 7.47 min
  7.67  [Playtest] finished legrad team 0 at 7.67 min
  7.75  [Playtest] finished legadvshipyard team 0 at 7.75 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +532.0 bank 103649/103650, energy +29491.0 bank 1048460/1062310, units 381
  8.13  [SEA][Layout] berth sea.berth.5 legadvshipyard at=7456,8976 facing=2
  9.00  [Playtest] eco team 0 at 9.0 min: metal +532.0 bank 103649/103650, energy +29491.0 bank 1048460/1062310, units 384
  9.96  [Playtest] finished leglht team 0 at 9.96 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +532.0 bank 103647/103650, energy +29491.0 bank 1048312/1062310, units 390
 10.00  [Playtest] camera requested (10800,4000) height=5500
 10.01  [Playtest] camera captured name=ta position=(10800,4000) height=5500
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (10800, 4000)
 10.15  [Playtest] finished legrad team 0 at 10.15 min
 10.63  [Playtest] finished legnanotcplat team 0 at 10.64 min
 10.94  [Playtest] finished legnanotcplat team 0 at 10.94 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +532.0 bank 103637/103650, energy +30101.0 bank 1048065/1062310, units 396
 11.23  [Playtest] finished legnanotcplat team 0 at 11.23 min
 11.52  [Playtest] finished leggantuw team 0 at 11.52 min
 11.55  [Playtest] finished leglht team 0 at 11.55 min
 11.56  [Playtest] finished legnanotcplat team 0 at 11.56 min
 11.79  [Playtest] finished legrad team 0 at 11.79 min
 11.84  [Playtest] finished legnanotcplat team 0 at 11.84 min
 11.99  [Playtest] finished legnanotcplat team 0 at 11.99 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +531.2 bank 104445/104450, energy +29491.0 bank 1049418/1063710, units 402
 12.37  [Playtest] finished legadvshipyard team 0 at 12.37 min
 12.77  [SEA][Layout] berth sea.berth.6 legadvshipyard at=8608,10032 facing=2
 13.00  [Playtest] eco team 0 at 13.0 min: metal +531.2 bank 104645/104650, energy +29491.0 bank 1049618/1063910, units 408
 13.59  [Playtest] finished legadvshipyard team 0 at 13.59 min
 14.00  [SEA][Layout] berth sea.berth.7 legadvshipyard at=7904,8960 facing=2
 14.00  [Playtest] eco team 0 at 14.0 min: metal +531.2 bank 104843/104850, energy +29491.0 bank 1049818/1064110, units 415
 14.61  [Playtest] finished legadvshipyard team 0 at 14.61 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +531.2 bank 105043/105050, energy +29491.0 bank 1050018/1064310, units 422
 16.00  [Playtest] eco team 0 at 16.0 min: metal +531.2 bank 105043/105050, energy +29491.0 bank 1050018/1064310, units 428
 16.00  [Playtest] camera requested (11000,2800) height=5500
 16.02  [Playtest] camera captured name=ta position=(11000,2800) height=5500
 16.02  [Playtest] screenshot at 16.0 min of team 0 at (11000, 2800)
 17.00  [Playtest] eco team 0 at 17.0 min: metal +531.2 bank 105048/105050, energy +29491.0 bank 1050460/1064310, units 433
 18.00  [Playtest] eco team 0 at 18.0 min: metal +531.2 bank 105042/105050, energy +29491.0 bank 1049944/1064310, units 439
 19.00  [Playtest] eco team 0 at 19.0 min: metal +531.2 bank 105042/105050, energy +29491.0 bank 1049944/1064310, units 445
 20.00  [Playtest] eco team 0 at 20.0 min: metal +531.2 bank 105043/105050, energy +29491.0 bank 1049994/1064310, units 452
 20.92  [Playtest] finished legamstor team 0 at 20.92 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +531.2 bank 107339/115050, energy +29491.0 bank 1049944/1064310, units 459
 22.00  [Playtest] eco team 0 at 22.0 min: metal +531.2 bank 115040/115050, energy +29491.0 bank 1049944/1064310, units 465
 23.00  [Playtest] eco team 0 at 23.0 min: metal +531.2 bank 115040/115050, energy +29491.0 bank 1049944/1064310, units 471
 24.00  [Playtest] eco team 0 at 24.0 min: metal +531.2 bank 115040/115050, energy +29491.0 bank 1049944/1064310, units 477
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
