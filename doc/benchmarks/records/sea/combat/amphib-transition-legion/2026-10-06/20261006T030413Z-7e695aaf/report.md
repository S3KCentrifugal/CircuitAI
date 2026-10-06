# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 24.1 min (frame 43320); wall 418 s
- DLL: build-theatres\d212-final\SkirmishAI.dll (f224e17dc3c6f798); AI BARbTest/test; staged 2026-10-05T23:57:06
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/legion/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: amphibious-transition.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T025705Z-a987c843\runs\20261006T030413Z-7e695aaf\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `partial-survey` | seen at 1.8 min | `[t=00:00:49.338665][f=0003300] [SeaInvasionTest] PASS partial-survey-blocked` |
| expect `complex` | seen at 5.5 min | `[t=00:01:38.817703][f=0009916] [SeaInvasionTest] PASS complex-finished` |
| expect `gantry` | **missing** (by 18 min) | |
| expect `complex-production` | seen at 5.8 min | `[t=00:01:43.251577][f=0010508] [SeaInvasionTest] PASS complex-produced` |
| expect `gantry-production` | **missing** (by 18 min) | |
| expect `landfall` | seen at 7.8 min | `[t=00:02:15.495370][f=0014100] [SeaInvasionTest] PASS landfall` |
| expect `backline` | seen at 8.0 min | `[t=00:02:18.161817][f=0014400] [SeaInvasionTest] PASS backline-reached` |
| expect `escort` | seen at 4.9 min | `[t=00:01:28.357094][f=0008734] [SeaInvasionTest] PASS factory-escorted` |
| expect `gantry-landing` | **missing** (by 24 min) | |
| expect `gantry-backline` | **missing** (by 24 min) | |
| expect `combat` | **missing** (by 24 min) | |
| forbid `errors` | clean |  |

## Failures

- 'gantry' not seen by 18.0 min
- 'gantry-production' not seen by 18.0 min
- 'gantry-landing' not seen by 24.0 min
- 'gantry-backline' not seen by 24.0 min
- 'combat' not seen by 24.0 min

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T025705Z-a987c843\runs\20261006T030413Z-7e695aaf\screen_2026-10-06_02-58-07-083.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T025705Z-a987c843\runs\20261006T030413Z-7e695aaf\screen_2026-10-06_02-58-44-570.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T025705Z-a987c843\runs\20261006T030413Z-7e695aaf\screen_2026-10-06_02-58-47-831.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T025705Z-a987c843\runs\20261006T030413Z-7e695aaf\screen_2026-10-06_02-59-31-709.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T025705Z-a987c843\runs\20261006T030413Z-7e695aaf\screen_2026-10-06_03-00-15-316.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T025705Z-a987c843\runs\20261006T030413Z-7e695aaf\screen_2026-10-06_03-01-52-152.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 20, 4 shots, end at 24.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished legcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 20000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side legion ai true dead false start (5800, 10500) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 46
  0.00  [Playtest] speed 20
  0.05  [Playtest] frame 90 team 0 ally 0 side legion ai true dead false start (5800, 10500) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 46
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.17  [Playtest] finished legsy team 0 at 0.17 min
  0.17  [Playtest] finished legadvshipyard team 0 at 0.17 min
  0.17  [Playtest] finished legsplab team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
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
  0.47  [Playtest] finished legtide team 0 at 0.47 min
  0.73  [Playtest] finished leganavalmex team 0 at 0.73 min
  0.73  [Team][Roster] first mex 11434 at 6528,10320
  0.73  [Team][Roster] Re-announced: roster|1|0|0|SEA|legion|legsy|5829|10504|0|7|1|6528|10320
  0.91  [Playtest] finished legmex team 0 at 0.91 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +479.0 bank 39996/100950, energy +29491.0 bank 1047984/1061550, units 113
  1.09  [Playtest] finished legadvshipyard team 0 at 1.09 min
  1.25  [SEA][Layout] berth sea.berth.3 legadvshipyard at=7936,10032 facing=2
  1.27  [Playtest] finished legfrad team 0 at 1.27 min
  1.41  [Playtest] finished leganavalmex team 0 at 1.41 min
  1.42  [Playtest] finished legnanotcplat team 0 at 1.42 min
  1.55  [Playtest] finished legmex team 0 at 1.55 min
  1.68  [Playtest] finished legtl team 0 at 1.68 min
  1.85  [Playtest] finished legtl team 0 at 1.85 min
  1.86  [Playtest] finished legnanotcplat team 0 at 1.86 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +488.2 bank 64784/101750, energy +29491.0 bank 1048236/1061750, units 119
  2.00  [Playtest] camera requested (8500,6500) height=8500
  2.02  [Playtest] camera captured name=ta position=(8500,6500) height=8500
  2.02  [Playtest] screenshot at 2.0 min of team 0 at (8500, 6500)
  2.09  [Playtest] finished legmex team 0 at 2.09 min
  2.11  [Playtest] finished legadvshipyard team 0 at 2.11 min
  2.48  [SEA][Layout] berth sea.berth.4 legadvshipyard at=6400,10032 facing=2
  2.52  [Playtest] finished legtl team 0 at 2.52 min
  2.67  [Playtest] finished legtl team 0 at 2.67 min
  2.69  [Playtest] finished legtl team 0 at 2.69 min
  2.85  [Playtest] finished legfrad team 0 at 2.85 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +490.5 bank 92030/102000, energy +29491.0 bank 1048363/1061950, units 352
  3.12  [Playtest] finished legtl team 0 at 3.12 min
  3.53  [Playtest] finished legadvshipyard team 0 at 3.53 min
  3.58  [Playtest] finished leganavalmex team 0 at 3.58 min
  3.82  [Playtest] finished legmex team 0 at 3.82 min
  3.83  [Playtest] finished leganavalmex team 0 at 3.83 min
  3.84  [Playtest] finished legfrad team 0 at 3.84 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +506.6 bank 103349/103350, energy +29491.0 bank 1048598/1062150, units 353
  4.40  [Playtest] finished legmex team 0 at 4.40 min
  4.73  [Playtest] finished legmex team 0 at 4.73 min
  4.96  [Playtest] finished legmex team 0 at 4.96 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +514.3 bank 103499/103500, energy +29491.0 bank 1048670/1062150, units 356
  5.00  [Playtest] camera requested (10800,4000) height=6500
  5.01  [Playtest] camera captured name=ta position=(10800,4000) height=6500
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (10800, 4000)
  5.46  [Playtest] finished legmex team 0 at 5.46 min
  5.51  [Playtest] finished legamphlab team 0 at 5.51 min
  5.73  [Playtest] finished legnanotcplat team 0 at 5.73 min
  5.75  [Playtest] finished legmex team 0 at 5.75 min
  5.90  [SEA][Layout] berth sea.berth.5 legadvshipyard at=7456,8976 facing=2
  6.00  [Playtest] eco team 0 at 6.0 min: metal +518.4 bank 103598/103600, energy +29491.0 bank 1048677/1062310, units 365
  6.32  [Playtest] finished legnanotcplat team 0 at 6.32 min
  6.40  [Playtest] finished legmex team 0 at 6.40 min
  6.51  [Playtest] finished legnanotcplat team 0 at 6.51 min
  6.54  [Playtest] finished legnanotcplat team 0 at 6.54 min
  6.56  [Playtest] finished legnanotcplat team 0 at 6.56 min
  6.61  [Playtest] finished legrad team 0 at 6.61 min
  6.61  [Playtest] finished legnanotcplat team 0 at 6.61 min
  6.83  [Playtest] finished leglht team 0 at 6.83 min
  6.86  [Playtest] finished legnanotcplat team 0 at 6.86 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +520.7 bank 103626/103650, energy +29491.0 bank 1048488/1062310, units 379
  7.01  [Playtest] finished legadvshipyard team 0 at 7.01 min
  7.29  [Playtest] finished legnanotcplat team 0 at 7.29 min
  7.40  [SEA][Layout] berth sea.berth.6 legadvshipyard at=8608,10032 facing=2
  7.43  [Playtest] finished legnanotcplat team 0 at 7.43 min
  7.43  [Playtest] finished legnanotcplat team 0 at 7.43 min
  7.52  [Playtest] finished legnanotcplat team 0 at 7.52 min
  7.53  [Playtest] finished leglht team 0 at 7.53 min
  7.59  [Playtest] finished legnanotcplat team 0 at 7.59 min
  7.80  [Playtest] finished legrad team 0 at 7.80 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +520.7 bank 103836/103850, energy +29491.0 bank 1048872/1062510, units 385
  8.57  [Playtest] finished legadvshipyard team 0 at 8.57 min
  8.66  [Playtest] finished leglht team 0 at 8.66 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +520.7 bank 104048/104050, energy +29491.0 bank 1049128/1062710, units 391
  9.03  [Playtest] finished legrad team 0 at 9.03 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +520.7 bank 104049/104050, energy +29491.0 bank 1049199/1062710, units 392
 10.00  [Playtest] camera requested (10800,4000) height=5500
 10.01  [Playtest] camera captured name=ta position=(10800,4000) height=5500
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (10800, 4000)
 10.14  [Playtest] finished leglht team 0 at 10.14 min
 10.38  [Playtest] finished legrad team 0 at 10.38 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +520.7 bank 104049/104050, energy +29491.0 bank 1049199/1062710, units 395
 12.00  [Playtest] eco team 0 at 12.0 min: metal +519.9 bank 104049/104050, energy +29491.0 bank 1049199/1062710, units 394
 13.00  [Playtest] eco team 0 at 13.0 min: metal +519.9 bank 104049/104050, energy +29491.0 bank 1049199/1062710, units 397
 14.00  [Playtest] eco team 0 at 14.0 min: metal +519.9 bank 104050/104050, energy +29491.0 bank 1049250/1062710, units 400
 15.00  [Playtest] eco team 0 at 15.0 min: metal +519.9 bank 104049/104050, energy +29491.0 bank 1049199/1062710, units 404
 16.00  [Playtest] eco team 0 at 16.0 min: metal +519.9 bank 104049/104050, energy +29491.0 bank 1049199/1062710, units 407
 16.00  [Playtest] camera requested (11000,2800) height=5500
 16.01  [Playtest] camera captured name=ta position=(11000,2800) height=5500
 16.01  [Playtest] screenshot at 16.0 min of team 0 at (11000, 2800)
 17.00  [Playtest] eco team 0 at 17.0 min: metal +519.9 bank 104049/104050, energy +29491.0 bank 1049199/1062710, units 410
 18.00  [Playtest] eco team 0 at 18.0 min: metal +519.9 bank 104049/104050, energy +29491.0 bank 1049199/1062710, units 413
 19.00  [Playtest] eco team 0 at 19.0 min: metal +519.9 bank 104049/104050, energy +29491.0 bank 1049199/1062710, units 416
 20.00  [Playtest] eco team 0 at 20.0 min: metal +519.9 bank 104050/104050, energy +29491.0 bank 1049250/1062710, units 419
 20.67  [Playtest] finished legamstor team 0 at 20.67 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +519.9 bank 114048/114050, energy +29491.0 bank 1049199/1062710, units 424
 22.00  [Playtest] eco team 0 at 22.0 min: metal +519.9 bank 114048/114050, energy +29491.0 bank 1049199/1062710, units 427
 23.00  [Playtest] eco team 0 at 23.0 min: metal +519.9 bank 114048/114050, energy +29491.0 bank 1049199/1062710, units 430
 24.00  [Playtest] eco team 0 at 24.0 min: metal +519.9 bank 114048/114050, energy +29491.0 bank 1049199/1062710, units 433
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
