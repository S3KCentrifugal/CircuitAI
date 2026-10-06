# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 24.0 min (frame 43238); wall 368 s
- DLL: build-theatres\d212-final\SkirmishAI.dll (f224e17dc3c6f798); AI BARbTest/test; staged 2026-10-05T23:45:27
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/legion/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: amphibious-transition.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T024527Z-b0472b16\runs\20261006T025145Z-d7f24cad\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `partial-survey` | seen at 1.8 min | `[t=00:00:52.955758][f=0003300] [SeaInvasionTest] PASS partial-survey-blocked` |
| expect `complex` | **missing** (by 18 min) | |
| expect `gantry` | **missing** (by 18 min) | |
| expect `complex-production` | **missing** (by 18 min) | |
| expect `gantry-production` | **missing** (by 18 min) | |
| expect `landfall` | **missing** (by 18 min) | |
| expect `backline` | **missing** (by 18 min) | |
| expect `escort` | **missing** (by 18 min) | |
| expect `gantry-landing` | **missing** (by 24 min) | |
| expect `gantry-backline` | **missing** (by 24 min) | |
| expect `combat` | **missing** (by 24 min) | |
| forbid `errors` | clean |  |

## Failures

- 'complex' not seen by 18.0 min
- 'gantry' not seen by 18.0 min
- 'complex-production' not seen by 18.0 min
- 'gantry-production' not seen by 18.0 min
- 'landfall' not seen by 18.0 min
- 'backline' not seen by 18.0 min
- 'escort' not seen by 18.0 min
- 'gantry-landing' not seen by 24.0 min
- 'gantry-backline' not seen by 24.0 min
- 'combat' not seen by 24.0 min

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T024527Z-b0472b16\runs\20261006T025145Z-d7f24cad\screen_2026-10-06_02-46-32-411.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T024527Z-b0472b16\runs\20261006T025145Z-d7f24cad\screen_2026-10-06_02-47-15-761.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T024527Z-b0472b16\runs\20261006T025145Z-d7f24cad\screen_2026-10-06_02-48-31-086.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-legion\supreme\20261006T024527Z-b0472b16\runs\20261006T025145Z-d7f24cad\screen_2026-10-06_02-49-53-996.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 20, 4 shots, end at 24.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished legcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 20000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side legion ai true dead false start (5800, 10500) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 31
  0.00  [Playtest] speed 20
  0.05  [Playtest] frame 90 team 0 ally 0 side legion ai true dead false start (5800, 10500) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 31
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
  0.51  [Playtest] finished legtide team 0 at 0.51 min
  0.57  [Playtest] finished legmex team 0 at 0.57 min
  0.58  [Team][Roster] first mex 17113 at 6528,10320
  0.58  [Team][Roster] Re-announced: roster|1|0|0|SEA|legion|legsy|5829|10504|0|7|1|6528|10320
  0.60  [SEA][Layout] berth sea.berth.2 legsy at=7744,10032 facing=2
  0.92  [Playtest] finished legnanotcplat team 0 at 0.92 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +469.8 bank 42282/100350, energy +29491.0 bank 1047786/1061550, units 115
  1.05  [Playtest] finished legnanotcplat team 0 at 1.05 min
  1.08  [Playtest] finished legmex team 0 at 1.08 min
  1.18  [Playtest] finished legfeconv team 0 at 1.18 min
  1.74  [Playtest] finished legmex team 0 at 1.74 min
  1.78  [Playtest] finished legfrad team 0 at 1.78 min
  1.84  [Playtest] finished legadvshipyard team 0 at 1.84 min
  1.98  [SEA][Layout] berth sea.berth.3 legadvshipyard at=7936,10032 facing=2
  2.00  [Playtest] eco team 0 at 2.0 min: metal +475.4 bank 66865/100650, energy +29491.0 bank 1048133/1061750, units 119
  2.00  [Playtest] camera requested (8500,6500) height=8500
  2.01  [Playtest] camera captured name=ta position=(8500,6500) height=8500
  2.01  [Playtest] screenshot at 2.0 min of team 0 at (8500, 6500)
  2.04  [Playtest] finished leganavalmex team 0 at 2.04 min
  2.26  [Playtest] finished legtl team 0 at 2.26 min
  2.45  [Playtest] finished legtl team 0 at 2.45 min
  2.59  [Playtest] finished legtl team 0 at 2.59 min
  2.87  [Playtest] finished legtl team 0 at 2.87 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +483.1 bank 92474/101200, energy +29491.0 bank 1048015/1061750, units 347
  3.11  [Playtest] finished legadvshipyard team 0 at 3.11 min
  3.15  [Playtest] finished leganavalmex team 0 at 3.15 min
  3.31  [Playtest] finished legfrad team 0 at 3.31 min
  3.48  [SEA][Layout] berth sea.berth.4 legadvshipyard at=6400,10032 facing=2
  3.69  [Playtest] finished legfrad team 0 at 3.69 min
  3.80  [Playtest] finished legmex team 0 at 3.80 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +492.3 bank 101968/102000, energy +29491.0 bank 1048183/1061950, units 351
  4.09  [Playtest] finished leganavalmex team 0 at 4.09 min
  4.30  [Playtest] finished legadvshipyard team 0 at 4.30 min
  4.39  [Playtest] finished legmex team 0 at 4.39 min
  4.42  [Playtest] finished legtl team 0 at 4.42 min
  4.67  [SEA][Layout] berth sea.berth.5 legadvshipyard at=7456,8976 facing=2
  4.72  [Playtest] finished legmex team 0 at 4.72 min
  4.79  [Playtest] finished legtl team 0 at 4.79 min
  4.97  [Playtest] finished legmex team 0 at 4.97 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +505.3 bank 102899/102900, energy +29491.0 bank 1048568/1062150, units 355
  5.00  [Playtest] camera requested (10800,4000) height=6500
  5.01  [Playtest] camera captured name=ta position=(10800,4000) height=6500
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (10800, 4000)
  5.47  [Playtest] finished legmex team 0 at 5.47 min
  5.64  [Playtest] finished legadvshipyard team 0 at 5.64 min
  5.75  [Playtest] finished legmex team 0 at 5.75 min
  5.77  [Playtest] finished legmex team 0 at 5.77 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +512.5 bank 103249/103250, energy +29491.0 bank 1048837/1062350, units 360
  6.03  [SEA][Layout] berth sea.berth.6 legadvshipyard at=8608,10032 facing=2
  6.23  [Playtest] finished legfrad team 0 at 6.23 min
  6.35  [Playtest] finished legmex team 0 at 6.35 min
  6.54  [Playtest] finished legrad team 0 at 6.54 min
  6.76  [Playtest] finished leglht team 0 at 6.76 min
  6.90  [Playtest] finished legadvshipyard team 0 at 6.90 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +514.8 bank 103499/103500, energy +29491.0 bank 1049044/1062550, units 365
  7.21  [Playtest] finished legtl team 0 at 7.21 min
  7.42  [Playtest] finished leglht team 0 at 7.42 min
  7.65  [Playtest] finished legrad team 0 at 7.65 min
  7.77  [Playtest] finished legtl team 0 at 7.77 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +514.8 bank 103500/103500, energy +29491.0 bank 1049063/1062550, units 368
  8.19  [Playtest] finished leglht team 0 at 8.19 min
  8.34  [Playtest] finished legrad team 0 at 8.34 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +514.8 bank 103499/103500, energy +29491.0 bank 1049031/1062550, units 371
  9.05  [Playtest] finished leglht team 0 at 9.05 min
  9.27  [Playtest] finished legrad team 0 at 9.27 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +514.8 bank 103500/103500, energy +29491.0 bank 1049063/1062550, units 372
 10.00  [Playtest] camera requested (10800,4000) height=5500
 10.02  [Playtest] camera captured name=ta position=(10800,4000) height=5500
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (10800, 4000)
 10.59  [Playtest] finished leganavalmex team 0 at 10.59 min
 11.00  [SEA][Layout] berth sea.berth.7 legadvshipyard at=7904,8960 facing=2
 11.00  [Playtest] eco team 0 at 11.0 min: metal +520.9 bank 104050/104050, energy +29491.0 bank 1049055/1062550, units 371
 12.00  [Playtest] eco team 0 at 12.0 min: metal +520.9 bank 104050/104050, energy +29491.0 bank 1049055/1062550, units 371
 13.00  [Playtest] eco team 0 at 13.0 min: metal +520.9 bank 104050/104050, energy +29491.0 bank 1049055/1062550, units 371
 14.00  [Playtest] eco team 0 at 14.0 min: metal +520.9 bank 104050/104050, energy +29491.0 bank 1049055/1062550, units 371
 15.00  [Playtest] eco team 0 at 15.0 min: metal +520.9 bank 104050/104050, energy +29491.0 bank 1049055/1062550, units 371
 16.00  [Playtest] eco team 0 at 16.0 min: metal +520.9 bank 104050/104050, energy +29491.0 bank 1049055/1062550, units 371
 16.00  [Playtest] camera requested (11000,2800) height=5500
 16.02  [Playtest] camera captured name=ta position=(11000,2800) height=5500
 16.02  [Playtest] screenshot at 16.0 min of team 0 at (11000, 2800)
 17.00  [Playtest] eco team 0 at 17.0 min: metal +520.9 bank 104050/104050, energy +29491.0 bank 1049055/1062550, units 371
 18.00  [Playtest] eco team 0 at 18.0 min: metal +520.9 bank 104050/104050, energy +29491.0 bank 1049055/1062550, units 371
 19.00  [Playtest] eco team 0 at 19.0 min: metal +520.9 bank 104050/104050, energy +29491.0 bank 1049055/1062550, units 371
 20.00  [Playtest] eco team 0 at 20.0 min: metal +520.9 bank 104050/104050, energy +29491.0 bank 1049055/1062550, units 371
 20.55  [Playtest] finished legamstor team 0 at 20.55 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +520.9 bank 114050/114050, energy +29491.0 bank 1049055/1062550, units 372
 22.00  [Playtest] eco team 0 at 22.0 min: metal +520.9 bank 114050/114050, energy +29491.0 bank 1049055/1062550, units 372
 23.00  [Playtest] eco team 0 at 23.0 min: metal +520.9 bank 114050/114050, energy +29491.0 bank 1049055/1062550, units 372
 24.00  [Playtest] eco team 0 at 24.0 min: metal +520.9 bank 114050/114050, energy +29491.0 bank 1049055/1062550, units 372
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
