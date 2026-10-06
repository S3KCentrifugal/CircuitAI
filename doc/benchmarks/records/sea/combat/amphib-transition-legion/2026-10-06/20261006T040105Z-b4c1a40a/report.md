# Playtest report: PASS

- Verdict: **PASS** (reached 24 min)
- Game time reached: 24.1 min (frame 43332); wall 393 s
- DLL: build-theatres\d212-final\SkirmishAI.dll (f224e17dc3c6f798); AI BARbTest/test; staged 2026-10-06T00:54:29
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/legion/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: amphibious-transition.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T035428Z-fec16459\runs\20261006T040105Z-b4c1a40a\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `partial-survey` | seen at 1.8 min | `[t=00:00:53.231815][f=0003300] [SeaInvasionTest] PASS partial-survey-blocked` |
| expect `complex` | seen at 5.8 min | `[t=00:01:49.227485][f=0010354] [SeaInvasionTest] PASS complex-finished` |
| expect `gantry` | seen at 9.0 min | `[t=00:02:32.250978][f=0016116] [SeaInvasionTest] PASS gantry-finished` |
| expect `complex-production` | seen at 6.1 min | `[t=00:01:53.416538][f=0010948] [SeaInvasionTest] PASS complex-produced` |
| expect `gantry-production` | seen at 9.4 min | `[t=00:02:37.755822][f=0016884] [SeaInvasionTest] PASS gantry-produced` |
| expect `landfall` | seen at 7.8 min | `[t=00:02:16.986559][f=0014100] [SeaInvasionTest] PASS landfall` |
| expect `backline` | seen at 8.8 min | `[t=00:02:30.705239][f=0015900] [SeaInvasionTest] PASS backline-reached` |
| expect `escort` | seen at 4.5 min | `[t=00:01:31.153427][f=0008014] [SeaInvasionTest] PASS factory-escorted` |
| expect `complex-support` | seen at 6.8 min | `[t=00:02:03.022541][f=0012300] [SeaInvasionTest] PASS complex-support-six` |
| expect `gantry-support` | seen at 9.8 min | `[t=00:02:44.781464][f=0017700] [SeaInvasionTest] PASS gantry-support-twelve` |
| expect `gantry-landing` | seen at 11.3 min | `[t=00:03:06.499998][f=0020400] [SeaInvasionTest] PASS gantry-landfall` |
| expect `gantry-backline` | seen at 12.2 min | `[t=00:03:18.560419][f=0021900] [SeaInvasionTest] PASS gantry-backline` |
| expect `combat` | seen at 9.4 min | `[t=00:02:38.677958][f=0017009] [SeaInvasionTest] PASS amphibian-damaged-economy` |
| forbid `errors` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T035428Z-fec16459\runs\20261006T040105Z-b4c1a40a\screen_2026-10-06_03-55-27-881.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T035428Z-fec16459\runs\20261006T040105Z-b4c1a40a\screen_2026-10-06_03-56-04-381.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T035428Z-fec16459\runs\20261006T040105Z-b4c1a40a\screen_2026-10-06_03-56-13-190.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T035428Z-fec16459\runs\20261006T040105Z-b4c1a40a\screen_2026-10-06_03-56-50-202.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T035428Z-fec16459\runs\20261006T040105Z-b4c1a40a\screen_2026-10-06_03-56-55-402.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T035428Z-fec16459\runs\20261006T040105Z-b4c1a40a\screen_2026-10-06_03-57-20-764.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T035428Z-fec16459\runs\20261006T040105Z-b4c1a40a\screen_2026-10-06_03-57-51-784.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T035428Z-fec16459\runs\20261006T040105Z-b4c1a40a\screen_2026-10-06_03-58-51-221.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 20, 4 shots, end at 24.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished legcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 20000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side legion ai true dead false start (5800, 10500) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 25
  0.00  [Playtest] speed 20
  0.05  [Playtest] frame 90 team 0 ally 0 side legion ai true dead false start (5800, 10500) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 25
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
  0.38  [Playtest] finished legtl team 0 at 0.38 min
  0.48  [SEA][Layout] berth sea.berth.2 legsy at=7744,10032 facing=2
  0.58  [Playtest] finished legtide team 0 at 0.58 min
  0.82  [Playtest] finished legmex team 0 at 0.82 min
  0.83  [Team][Roster] first mex 23696 at 6528,10320
  0.83  [Team][Roster] Re-announced: roster|1|0|0|SEA|legion|legsy|5829|10504|0|7|1|6528|10320
  1.00  [Playtest] eco team 0 at 1.0 min: metal +471.2 bank 40888/100350, energy +29491.0 bank 1047932/1061550, units 114
  1.23  [Playtest] finished legadvshipyard team 0 at 1.23 min
  1.30  [Playtest] finished legmex team 0 at 1.30 min
  1.38  [SEA][Layout] berth sea.berth.3 legadvshipyard at=7936,10032 facing=2
  1.51  [Playtest] finished legmex team 0 at 1.51 min
  1.56  [Playtest] finished legnanotcplat team 0 at 1.56 min
  1.65  [Playtest] finished legnanotcplat team 0 at 1.65 min
  1.70  [Playtest] finished leganavaleconv team 0 at 1.70 min
  1.75  [Playtest] finished legtl team 0 at 1.75 min
  1.85  [Playtest] finished legmex team 0 at 1.85 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +487.0 bank 65965/100700, energy +29491.0 bank 1047688/1061750, units 123
  2.00  [Playtest] camera requested (8500,6500) height=8500
  2.01  [Playtest] camera captured name=ta position=(8500,6500) height=8500
  2.01  [Playtest] screenshot at 2.0 min of team 0 at (8500, 6500)
  2.11  [Playtest] finished legfrad team 0 at 2.11 min
  2.12  [Playtest] finished legtl team 0 at 2.12 min
  2.14  [Playtest] finished leganavalmex team 0 at 2.14 min
  2.44  [Playtest] finished legfrad team 0 at 2.44 min
  2.46  [Playtest] finished legadvshipyard team 0 at 2.46 min
  2.46  [Playtest] finished legtl team 0 at 2.46 min
  2.64  [Playtest] finished leganavaleconv team 0 at 2.64 min
  2.80  [Playtest] finished leganavalmex team 0 at 2.80 min
  2.83  [SEA][Layout] berth sea.berth.4 legadvshipyard at=6400,10032 facing=2
  3.00  [Playtest] eco team 0 at 3.0 min: metal +511.2 bank 91667/102000, energy +29491.0 bank 1047526/1061950, units 353
  3.09  [Playtest] finished legtl team 0 at 3.09 min
  3.17  [Playtest] finished legfrad team 0 at 3.17 min
  3.17  [Playtest] finished leganavalmex team 0 at 3.17 min
  3.44  [Playtest] finished legadvshipyard team 0 at 3.44 min
  3.65  [Playtest] finished legfeconv team 0 at 3.65 min
  3.70  [Playtest] finished legfrad team 0 at 3.70 min
  3.81  [Playtest] finished legmex team 0 at 3.81 min
  3.91  [Playtest] finished leganavalmex team 0 at 3.91 min
  3.93  [Playtest] finished legtl team 0 at 3.93 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +528.3 bank 103349/103350, energy +29491.0 bank 1048025/1062150, units 356
  4.12  [Playtest] finished legtl team 0 at 4.12 min
  4.40  [Playtest] finished legmex team 0 at 4.40 min
  4.40  [Playtest] finished legtl team 0 at 4.40 min
  4.61  [Playtest] finished legtl team 0 at 4.61 min
  4.71  [Playtest] finished legmex team 0 at 4.71 min
  4.95  [Playtest] finished legmex team 0 at 4.95 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +535.2 bank 103499/103500, energy +29491.0 bank 1048035/1062150, units 362
  5.00  [Playtest] camera requested (10800,4000) height=6500
  5.01  [Playtest] camera captured name=ta position=(10800,4000) height=6500
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (10800, 4000)
  5.47  [Playtest] finished legmex team 0 at 5.47 min
  5.75  [Playtest] finished legamphlab team 0 at 5.75 min
  5.76  [Playtest] finished legmex team 0 at 5.76 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +539.3 bank 103598/103600, energy +29491.0 bank 1048015/1062310, units 367
  6.04  [Playtest] finished legnanotcplat team 0 at 6.04 min
  6.12  [SEA][Layout] berth sea.berth.5 legadvshipyard at=7456,8976 facing=2
  6.28  [Playtest] finished legnanotcplat team 0 at 6.28 min
  6.40  [Playtest] finished legmex team 0 at 6.40 min
  6.50  [Playtest] finished legnanotcplat team 0 at 6.50 min
  6.57  [Playtest] finished legnanotcplat team 0 at 6.57 min
  6.60  [Playtest] finished legrad team 0 at 6.60 min
  6.71  [Playtest] finished legnanotcplat team 0 at 6.71 min
  6.77  [Playtest] finished legnanotcplat team 0 at 6.77 min
  6.83  [Playtest] finished leglht team 0 at 6.83 min
  6.95  [Playtest] finished legadvshipyard team 0 at 6.95 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +541.6 bank 103849/103850, energy +29491.0 bank 1048279/1062510, units 379
  7.33  [SEA][Layout] berth sea.berth.6 legadvshipyard at=8608,10032 facing=2
  7.48  [Playtest] finished leglht team 0 at 7.48 min
  7.66  [Playtest] finished legrad team 0 at 7.66 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +541.6 bank 103849/103850, energy +29491.0 bank 1048279/1062510, units 388
  8.27  [Playtest] finished leglht team 0 at 8.27 min
  8.46  [Playtest] finished legrad team 0 at 8.46 min
  8.95  [Playtest] finished leggantuw team 0 at 8.95 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +541.6 bank 104647/104650, energy +29491.0 bank 1046186/1063910, units 397
  9.10  [Playtest] finished leglht team 0 at 9.10 min
  9.16  [Playtest] finished legnanotcplat team 0 at 9.16 min
  9.30  [Playtest] finished legrad team 0 at 9.31 min
  9.42  [Playtest] finished legnanotcplat team 0 at 9.42 min
  9.52  [Playtest] finished legnanotcplat team 0 at 9.52 min
  9.66  [Playtest] finished legnanotcplat team 0 at 9.66 min
  9.73  [Playtest] finished legnanotcplat team 0 at 9.73 min
  9.81  [Playtest] finished legnanotcplat team 0 at 9.81 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +541.6 bank 104643/104650, energy +29491.0 bank 1033525/1063910, units 409
 10.00  [Playtest] camera requested (10800,4000) height=5500
 10.01  [Playtest] camera captured name=ta position=(10800,4000) height=5500
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (10800, 4000)
 10.57  [Playtest] finished legadvshipyard team 0 at 10.57 min
 10.97  [SEA][Layout] berth sea.berth.7 legadvshipyard at=7904,8960 facing=2
 11.00  [Playtest] eco team 0 at 11.0 min: metal +541.6 bank 104845/104850, energy +29491.0 bank 1032319/1064110, units 412
 11.55  [Playtest] finished legadvshipyard team 0 at 11.55 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +541.6 bank 105044/105050, energy +29491.0 bank 1029152/1064310, units 413
 13.00  [Playtest] eco team 0 at 13.0 min: metal +541.6 bank 105044/105050, energy +29491.0 bank 1037597/1064310, units 420
 14.00  [Playtest] eco team 0 at 14.0 min: metal +541.6 bank 105042/105050, energy +29491.0 bank 1039334/1064310, units 425
 15.00  [Playtest] eco team 0 at 15.0 min: metal +541.6 bank 105042/105050, energy +29491.0 bank 1039696/1064310, units 431
 16.00  [Playtest] eco team 0 at 16.0 min: metal +541.6 bank 105042/105050, energy +29491.0 bank 1038067/1064310, units 437
 16.00  [Playtest] camera requested (11000,2800) height=5500
 16.01  [Playtest] camera captured name=ta position=(11000,2800) height=5500
 16.01  [Playtest] screenshot at 16.0 min of team 0 at (11000, 2800)
 17.00  [Playtest] eco team 0 at 17.0 min: metal +541.6 bank 105042/105050, energy +29491.0 bank 1037826/1064310, units 443
 18.00  [Playtest] eco team 0 at 18.0 min: metal +541.6 bank 105043/105050, energy +29491.0 bank 1037110/1064310, units 449
 19.00  [Playtest] eco team 0 at 19.0 min: metal +541.6 bank 105040/105050, energy +29491.0 bank 1036344/1064310, units 456
 20.00  [Playtest] eco team 0 at 20.0 min: metal +541.6 bank 105040/105050, energy +29491.0 bank 1035675/1064310, units 462
 20.81  [Playtest] finished legamstor team 0 at 20.81 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +541.6 bank 110768/115050, energy +29491.0 bank 1023722/1064310, units 469
 22.00  [Playtest] eco team 0 at 22.0 min: metal +541.6 bank 115040/115050, energy +29491.0 bank 1024131/1064310, units 475
 23.00  [Playtest] eco team 0 at 23.0 min: metal +541.6 bank 115040/115050, energy +29491.0 bank 1023288/1064310, units 481
 24.00  [Playtest] eco team 0 at 24.0 min: metal +541.6 bank 115040/115050, energy +29491.0 bank 1022221/1064310, units 488
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
