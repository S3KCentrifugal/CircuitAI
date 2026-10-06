# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 18.1 min (frame 32490); wall 280 s
- DLL: build-theatres\d212-build2\SkirmishAI.dll (5879283eb5224a12); AI BARbTest/test; staged 2026-10-05T23:40:17
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/legion/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: amphibious-transition.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T024016Z-daa2f297\runs\20261006T024507Z-2c49a9c7\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `partial-survey` | seen at 1.8 min | `[t=00:00:52.959108][f=0003300] [SeaInvasionTest] PASS partial-survey-blocked` |
| expect `complex` | **missing** (by 18 min) | |
| expect `gantry` | **missing** (by 18 min) | |
| expect `complex-production` | **missing** (by 18 min) | |
| expect `gantry-production` | **missing** (by 18 min) | |
| expect `landfall` | **missing** (by 18 min) | |
| expect `backline` | **missing** (by 18 min) | |
| forbid `errors` | clean |  |

## Failures

- 'complex' not seen by 18.0 min
- 'gantry' not seen by 18.0 min
- 'complex-production' not seen by 18.0 min
- 'gantry-production' not seen by 18.0 min
- 'landfall' not seen by 18.0 min
- 'backline' not seen by 18.0 min

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T024016Z-daa2f297\runs\20261006T024507Z-2c49a9c7\screen_2026-10-06_02-41-22-208.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T024016Z-daa2f297\runs\20261006T024507Z-2c49a9c7\screen_2026-10-06_02-42-04-620.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T024016Z-daa2f297\runs\20261006T024507Z-2c49a9c7\screen_2026-10-06_02-43-16-276.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T024016Z-daa2f297\runs\20261006T024507Z-2c49a9c7\screen_2026-10-06_02-44-38-511.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 20, 4 shots, end at 18.5 min
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
  0.17  [Playtest] finished legsy team 0 at 0.17 min
  0.17  [Playtest] finished legadvshipyard team 0 at 0.17 min
  0.17  [Playtest] finished legsplab team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
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
  0.18  [SEA][Layout] berth sea.berth.0 legadvshipyard at=6544,10032 facing=2
  0.20  [SEA][Layout] berth sea.berth.1 legsplab at=6144,10032 facing=2
  0.40  [Playtest] finished legtl team 0 at 0.40 min
  0.52  [SEA][Layout] berth sea.berth.2 legsy at=6256,10032 facing=2
  0.55  [Playtest] finished legtide team 0 at 0.55 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +469.0 bank 40711/100300, energy +29491.0 bank 1047972/1061550, units 113
  1.01  [Playtest] finished legmex team 0 at 1.01 min
  1.02  [Team][Roster] first mex 4701 at 6528,10320
  1.02  [Team][Roster] Re-announced: roster|1|0|0|SEA|legion|legsy|5829|10504|0|7|1|6528|10320
  1.25  [Playtest] finished legadvshipyard team 0 at 1.25 min
  1.48  [Playtest] finished legnanotcplat team 0 at 1.48 min
  1.52  [Playtest] finished legmex team 0 at 1.52 min
  1.60  [Playtest] finished legnanotcplat team 0 at 1.60 min
  1.63  [Playtest] finished legtl team 0 at 1.63 min
  1.69  [Playtest] finished leganavalmex team 0 at 1.69 min
  1.72  [SEA][Layout] berth sea.berth.3 legadvshipyard at=6544,9360 facing=2
  1.79  [Playtest] finished leganavaleconv team 0 at 1.79 min
  1.83  [Playtest] finished legtl team 0 at 1.83 min
  2.00  [Playtest] finished legfrad team 0 at 2.00 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +489.3 bank 66169/101150, energy +29491.0 bank 1047820/1061750, units 123
  2.00  [Playtest] camera requested (8500,6500) height=8500
  2.01  [Playtest] camera captured name=ta position=(8500,6500) height=8500
  2.01  [Playtest] screenshot at 2.0 min of team 0 at (8500, 6500)
  2.08  [Playtest] finished legmex team 0 at 2.08 min
  2.33  [Playtest] finished legmex team 0 at 2.33 min
  2.37  [Playtest] finished legfeconv team 0 at 2.37 min
  2.46  [Playtest] finished legtl team 0 at 2.46 min
  2.48  [Playtest] finished leganavalmex team 0 at 2.48 min
  2.67  [Playtest] finished legfrad team 0 at 2.67 min
  2.70  [Playtest] finished legtl team 0 at 2.70 min
  2.75  [Playtest] finished legfrad team 0 at 2.75 min
  2.95  [Playtest] finished legtl team 0 at 2.95 min
  2.98  [Playtest] finished legadvshipyard team 0 at 2.98 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +501.8 bank 91538/102000, energy +29491.0 bank 1048034/1061950, units 353
  3.10  [Playtest] finished leganavalmex team 0 at 3.10 min
  3.30  [SEA][Layout] berth sea.berth.4 legadvshipyard at=7504,10032 facing=2
  3.36  [Playtest] finished legtl team 0 at 3.36 min
  3.78  [Playtest] finished legadvshipyard team 0 at 3.78 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +508.7 bank 102749/102750, energy +29491.0 bank 1048153/1062150, units 355
  4.23  [SEA][Layout] berth sea.berth.5 legadvshipyard at=7488,9088 facing=2
  4.28  [Playtest] finished leganavaleconv team 0 at 4.28 min
  4.33  [Playtest] finished legfrad team 0 at 4.33 min
  4.61  [Playtest] finished leganavalmex team 0 at 4.61 min
  4.61  [Playtest] finished legtl team 0 at 4.61 min
  4.83  [Playtest] finished legtl team 0 at 4.83 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +526.0 bank 103299/103300, energy +29491.0 bank 1047910/1062150, units 359
  5.00  [Playtest] camera requested (10800,4000) height=6500
  5.01  [Playtest] camera captured name=ta position=(10800,4000) height=6500
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (10800, 4000)
  5.52  [Playtest] finished legadvshipyard team 0 at 5.52 min
  5.64  [Playtest] finished legmex team 0 at 5.64 min
  5.97  [SEA][Layout] berth sea.berth.6 legadvshipyard at=7792,9520 facing=2
  6.00  [Playtest] eco team 0 at 6.0 min: metal +529.1 bank 103550/103550, energy +29491.0 bank 1048264/1062350, units 360
  6.39  [Playtest] finished legadvshipyard team 0 at 6.39 min
  6.45  [Playtest] finished legmex team 0 at 6.45 min
  6.62  [Playtest] finished leglht team 0 at 6.62 min
  6.77  [Playtest] finished legrad team 0 at 6.77 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +531.4 bank 103800/103800, energy +29491.0 bank 1048462/1062550, units 364
  7.02  [SEA][Layout] berth sea.berth.7 legadvshipyard at=8320,9296 facing=2
  7.50  [Playtest] finished leglht team 0 at 7.50 min
  7.70  [Playtest] finished legrad team 0 at 7.70 min
  7.75  [Playtest] finished legadvshipyard team 0 at 7.75 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +531.4 bank 104000/104000, energy +29491.0 bank 1048662/1062750, units 367
  9.00  [Playtest] eco team 0 at 9.0 min: metal +531.4 bank 104000/104000, energy +29491.0 bank 1048662/1062750, units 367
 10.00  [Playtest] eco team 0 at 10.0 min: metal +531.4 bank 104000/104000, energy +29491.0 bank 1048662/1062750, units 367
 10.00  [Playtest] camera requested (10800,4000) height=5500
 10.01  [Playtest] camera captured name=ta position=(10800,4000) height=5500
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (10800, 4000)
 11.00  [Playtest] eco team 0 at 11.0 min: metal +531.4 bank 104000/104000, energy +29491.0 bank 1048662/1062750, units 367
 12.00  [Playtest] eco team 0 at 12.0 min: metal +531.4 bank 104000/104000, energy +29491.0 bank 1048662/1062750, units 367
 13.00  [Playtest] eco team 0 at 13.0 min: metal +530.6 bank 104000/104000, energy +29491.0 bank 1048662/1062750, units 366
 14.00  [Playtest] eco team 0 at 14.0 min: metal +530.6 bank 104000/104000, energy +29491.0 bank 1048662/1062750, units 366
 15.00  [Playtest] eco team 0 at 15.0 min: metal +530.6 bank 104000/104000, energy +29491.0 bank 1048662/1062750, units 366
 16.00  [Playtest] eco team 0 at 16.0 min: metal +530.6 bank 104000/104000, energy +29491.0 bank 1048662/1062750, units 366
 16.00  [Playtest] camera requested (11000,2800) height=5500
 16.01  [Playtest] camera captured name=ta position=(11000,2800) height=5500
 16.01  [Playtest] screenshot at 16.0 min of team 0 at (11000, 2800)
 17.00  [Playtest] eco team 0 at 17.0 min: metal +530.6 bank 104000/104000, energy +29491.0 bank 1048662/1062750, units 366
 18.00  [Playtest] eco team 0 at 18.0 min: metal +530.6 bank 104000/104000, energy +29491.0 bank 1048662/1062750, units 366
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
