# Playtest report: PASS

- Verdict: **PASS** (reached 24 min)
- Game time reached: 24.0 min (frame 43260); wall 411 s
- DLL: build-theatres\d212-final\SkirmishAI.dll (f224e17dc3c6f798); AI BARbTest/test; staged 2026-10-06T00:38:05
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: amphibious-transition.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T033805Z-86e6a22b\runs\20261006T034506Z-e532b320\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `partial-survey` | seen at 1.8 min | `[t=00:00:49.714743][f=0003300] [SeaInvasionTest] PASS partial-survey-blocked` |
| expect `complex` | seen at 6.5 min | `[t=00:01:51.622674][f=0011779] [SeaInvasionTest] PASS complex-finished` |
| expect `gantry` | seen at 12.3 min | `[t=00:03:18.580475][f=0022208] [SeaInvasionTest] PASS gantry-finished` |
| expect `complex-production` | seen at 7.7 min | `[t=00:02:08.013849][f=0013942] [SeaInvasionTest] PASS complex-produced` |
| expect `gantry-production` | seen at 12.6 min | `[t=00:03:22.501058][f=0022710] [SeaInvasionTest] PASS gantry-produced` |
| expect `landfall` | seen at 9.8 min | `[t=00:02:37.931088][f=0017700] [SeaInvasionTest] PASS landfall` |
| expect `backline` | seen at 11.0 min | `[t=00:02:58.991486][f=0019800] [SeaInvasionTest] PASS backline-reached` |
| expect `escort` | seen at 5.1 min | `[t=00:01:33.709425][f=0009109] [SeaInvasionTest] PASS factory-escorted` |
| expect `gantry-landing` | seen at 13.7 min | `[t=00:03:37.355957][f=0024600] [SeaInvasionTest] PASS gantry-landfall` |
| expect `gantry-backline` | seen at 15.0 min | `[t=00:04:01.996832][f=0027000] [SeaInvasionTest] PASS gantry-backline` |
| expect `combat` | seen at 11.4 min | `[t=00:03:03.906544][f=0020435] [SeaInvasionTest] PASS amphibian-damaged-economy` |
| forbid `errors` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T033805Z-86e6a22b\runs\20261006T034506Z-e532b320\screen_2026-10-06_03-39-06-905.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T033805Z-86e6a22b\runs\20261006T034506Z-e532b320\screen_2026-10-06_03-39-48-651.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T033805Z-86e6a22b\runs\20261006T034506Z-e532b320\screen_2026-10-06_03-39-49-483.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T033805Z-86e6a22b\runs\20261006T034506Z-e532b320\screen_2026-10-06_03-40-53-691.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T033805Z-86e6a22b\runs\20261006T034506Z-e532b320\screen_2026-10-06_03-40-55-356.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T033805Z-86e6a22b\runs\20261006T034506Z-e532b320\screen_2026-10-06_03-40-57-067.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T033805Z-86e6a22b\runs\20261006T034506Z-e532b320\screen_2026-10-06_03-42-17-771.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T033805Z-86e6a22b\runs\20261006T034506Z-e532b320\screen_2026-10-06_03-42-36-740.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 20, 4 shots, end at 24.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 20000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (5800, 10500) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 29
  0.00  [Playtest] speed 20
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (5800, 10500) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 29
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.18  [Playtest] finished armsy team 0 at 0.18 min
  0.18  [Playtest] finished armasy team 0 at 0.18 min
  0.18  [Playtest] finished armplat team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [SEA][Layout] berth sea.berth.0 armasy at=7456,10032 facing=2
  0.20  [SEA][Layout] berth sea.berth.1 armplat at=7056,10032 facing=2
  0.40  [SEA][Layout] berth sea.berth.2 armsy at=7648,10032 facing=2
  0.51  [Playtest] finished armtide team 0 at 0.51 min
  0.86  [Playtest] finished armmex team 0 at 0.86 min
  0.87  [Team][Roster] first mex 30113 at 6848,9664
  0.87  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|5826|10504|0|7|1|6848|9664
  0.91  [Playtest] finished armuwmme team 0 at 0.91 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +480.4 bank 41943/100950, energy +29027.0 bank 1048042/1061550, units 115
  1.14  [Playtest] finished armnanotcplat team 0 at 1.14 min
  1.27  [Playtest] finished armnanotcplat team 0 at 1.27 min
  1.47  [Playtest] finished armmex team 0 at 1.47 min
  1.48  [Playtest] finished armuwmme team 0 at 1.48 min
  1.52  [Playtest] finished armason team 0 at 1.52 min
  1.76  [Playtest] finished armtl team 0 at 1.76 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +486.6 bank 68798/101500, energy +29027.0 bank 1047938/1061550, units 120
  2.00  [Playtest] camera requested (8500,6500) height=8500
  2.01  [Playtest] camera captured name=ta position=(8500,6500) height=8500
  2.01  [Playtest] screenshot at 2.0 min of team 0 at (8500, 6500)
  2.03  [Playtest] finished armuwmme team 0 at 2.03 min
  2.06  [Playtest] finished armtl team 0 at 2.06 min
  2.23  [Playtest] finished armfrad team 0 at 2.23 min
  2.87  [Playtest] finished armtl team 0 at 2.87 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +495.8 bank 97722/102100, energy +29027.0 bank 1047821/1061550, units 349
  3.19  [Playtest] finished armtl team 0 at 3.19 min
  3.41  [Playtest] finished armfrad team 0 at 3.41 min
  3.72  [Playtest] finished armuwmmm team 0 at 3.72 min
  3.83  [Playtest] finished armmex team 0 at 3.83 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +507.7 bank 102148/102150, energy +29027.0 bank 1047622/1061550, units 350
  4.42  [Playtest] finished armmex team 0 at 4.42 min
  4.74  [Playtest] finished armmex team 0 at 4.74 min
  4.83  [Playtest] finished armuwmmm team 0 at 4.83 min
  4.99  [Playtest] finished armmex team 0 at 4.99 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +523.2 bank 102299/102300, energy +29027.0 bank 1047427/1061550, units 353
  5.00  [Playtest] camera requested (10800,4000) height=6500
  5.01  [Playtest] camera captured name=ta position=(10800,4000) height=6500
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (10800, 4000)
  5.26  [Playtest] finished armuwmmm team 0 at 5.26 min
  5.51  [Playtest] finished armmex team 0 at 5.51 min
  5.66  [Playtest] finished armuwmmm team 0 at 5.66 min
  5.79  [Playtest] finished armmex team 0 at 5.79 min
  5.97  [Playtest] finished armmex team 0 at 5.97 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +552.0 bank 102449/102450, energy +29027.0 bank 1041223/1061550, units 359
  6.42  [Playtest] finished armmex team 0 at 6.42 min
  6.54  [Playtest] finished armamsub team 0 at 6.54 min
  6.65  [Playtest] finished armrad team 0 at 6.65 min
  6.85  [Playtest] finished armllt team 0 at 6.85 min
  6.92  [Playtest] finished armuwmme team 0 at 6.92 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +563.4 bank 103049/103050, energy +29027.0 bank 982702/1061700, units 367
  7.12  [Playtest] finished armnanotcplat team 0 at 7.12 min
  7.28  [Playtest] finished armnanotcplat team 0 at 7.28 min
  7.52  [Playtest] finished armllt team 0 at 7.52 min
  7.59  [Playtest] finished armnanotcplat team 0 at 7.59 min
  7.71  [Playtest] finished armrad team 0 at 7.71 min
  7.97  [Playtest] finished armnanotcplat team 0 at 7.97 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +563.4 bank 103049/103050, energy +29027.0 bank 925185/1061700, units 373
  8.23  [Playtest] finished armnanotcplat team 0 at 8.23 min
  8.32  [Playtest] finished armllt team 0 at 8.32 min
  8.45  [Playtest] finished armnanotcplat team 0 at 8.45 min
  8.49  [Playtest] finished armrad team 0 at 8.49 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +562.0 bank 103049/103050, energy +29027.0 bank 865333/1061700, units 375
  9.88  [Playtest] finished armuwmmm team 0 at 9.88 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +533.4 bank 103047/103050, energy +29027.0 bank 810204/1061700, units 376
 10.00  [Playtest] camera requested (10800,4000) height=5500
 10.01  [Playtest] camera captured name=ta position=(10800,4000) height=5500
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (10800, 4000)
 10.23  [Playtest] finished armuwmmm team 0 at 10.23 min
 10.70  [Playtest] finished armuwmmm team 0 at 10.70 min
 10.85  [Playtest] finished armtl team 0 at 10.85 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +542.9 bank 103047/103050, energy +29027.0 bank 810441/1061700, units 379
 11.18  [Playtest] finished armtl team 0 at 11.18 min
 11.32  [Playtest] finished armfrad team 0 at 11.32 min
 11.95  [Playtest] finished armnanotcplat team 0 at 11.95 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +541.7 bank 103044/103050, energy +29027.0 bank 810371/1061700, units 383
 12.34  [Playtest] finished armshltxuw team 0 at 12.34 min
 12.38  [Playtest] finished armllt team 0 at 12.38 min
 12.53  [Playtest] finished armrad team 0 at 12.53 min
 12.69  [Playtest] finished armnanotcplat team 0 at 12.69 min
 12.89  [Playtest] finished armnanotcplat team 0 at 12.90 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +515.4 bank 103833/103850, energy +29027.0 bank 810696/1063100, units 396
 13.15  [Playtest] finished armnanotcplat team 0 at 13.15 min
 13.31  [Playtest] finished armnanotcplat team 0 at 13.31 min
 13.40  [Playtest] finished armnanotcplat team 0 at 13.40 min
 13.44  [Playtest] finished armnanotcplat team 0 at 13.44 min
 13.45  [Playtest] finished armnanotcplat team 0 at 13.44 min
 13.52  [Playtest] finished armnanotcplat team 0 at 13.52 min
 13.62  [Playtest] finished armnanotcplat team 0 at 13.62 min
 13.72  [Playtest] finished armnanotcplat team 0 at 13.72 min
 13.81  [Playtest] finished armnanotcplat team 0 at 13.81 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +525.8 bank 103847/103850, energy +29027.0 bank 811642/1063100, units 402
 15.00  [Playtest] eco team 0 at 15.0 min: metal +515.0 bank 103834/103850, energy +29027.0 bank 810681/1063100, units 407
 16.00  [Playtest] eco team 0 at 16.0 min: metal +514.9 bank 103834/103850, energy +29027.0 bank 810681/1063100, units 412
 16.00  [Playtest] camera requested (11000,2800) height=5500
 16.01  [Playtest] camera captured name=ta position=(11000,2800) height=5500
 16.01  [Playtest] screenshot at 16.0 min of team 0 at (11000, 2800)
 17.00  [Playtest] eco team 0 at 17.0 min: metal +511.8 bank 103831/103850, energy +29027.0 bank 810594/1063100, units 418
 18.00  [Playtest] eco team 0 at 18.0 min: metal +535.6 bank 103831/103850, energy +29027.0 bank 810586/1063100, units 425
 19.00  [Playtest] eco team 0 at 19.0 min: metal +511.8 bank 103831/103850, energy +29027.0 bank 810586/1063100, units 431
 20.00  [Playtest] eco team 0 at 20.0 min: metal +511.6 bank 103831/103850, energy +29027.0 bank 810586/1063100, units 437
 20.64  [Playtest] finished armatl team 0 at 20.64 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +518.7 bank 103826/103850, energy +29027.0 bank 810487/1063100, units 446
 21.08  [Playtest] finished armuwadvms team 0 at 21.08 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +508.2 bank 113826/113850, energy +29027.0 bank 810487/1063100, units 452
 22.21  [Playtest] finished armuwadvms team 0 at 22.22 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +508.2 bank 123846/123850, energy +29027.0 bank 811582/1063100, units 459
 23.23  [Playtest] finished armuwadvms team 0 at 23.23 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +508.2 bank 133826/133850, energy +29027.0 bank 810487/1063100, units 467
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: zone 1 at (5912, 11112) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5912, 11112) facing 2 (id 1)
  0.08  RESERVE: zone 1 released
  0.08  RESERVE: zone 2 at (5864, 10984) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5864, 10984) facing 2 (id 2)
  0.08  RESERVE: zone 3 at (5816, 10984) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5816, 10984) facing 2 (id 3)
  0.08  RESERVE: zone 2 released
  0.08  RESERVE: zone 3 released
  0.08  RESERVE: zone 4 at (5880, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5880, 10952) facing 2 (id 4)
  0.08  RESERVE: zone 5 at (5832, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5832, 10952) facing 2 (id 5)
  0.08  RESERVE: zone 6 at (5784, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5784, 10952) facing 2 (id 6)
  0.08  RESERVE: zone 4 released
  0.08  RESERVE: zone 5 released
  0.08  RESERVE: zone 6 released
  0.08  RESERVE: zone 7 at (5912, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5912, 10936) facing 2 (id 7)
  0.08  RESERVE: zone 8 at (5864, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5864, 10936) facing 2 (id 8)
  0.08  RESERVE: zone 9 at (5816, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5816, 10936) facing 2 (id 9)
  0.08  RESERVE: zone 10 at (5768, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5768, 10936) facing 2 (id 10)
  0.08  RESERVE: zone 7 released
  0.08  RESERVE: zone 8 released
  0.08  RESERVE: zone 9 released
  0.08  RESERVE: zone 10 released
  0.08  RESERVE: zone 11 at (5944, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5944, 10920) facing 2 (id 11)
  0.08  RESERVE: zone 12 at (5896, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5896, 10920) facing 2 (id 12)
  0.08  RESERVE: zone 13 at (5848, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5848, 10920) facing 2 (id 13)
  0.08  RESERVE: zone 14 at (5800, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5800, 10920) facing 2 (id 14)
  0.08  RESERVE: zone 11 released
  0.08  RESERVE: zone 12 released
  0.08  RESERVE: zone 13 released
  0.08  RESERVE: zone 14 released
  0.12  RESERVE: zone 15 at (5976, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5976, 10936) facing 2 (id 15)
  0.12  RESERVE: zone 16 at (5928, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5928, 10936) facing 2 (id 16)
  0.12  RESERVE: zone 17 at (5880, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5880, 10936) facing 2 (id 17)
  0.12  RESERVE: zone 18 at (5832, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5832, 10936) facing 2 (id 18)
  0.12  RESERVE: zone 19 at (5784, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5784, 10936) facing 2 (id 19)
  0.12  RESERVE: zone 15 released
  0.12  RESERVE: zone 16 released
  0.12  RESERVE: zone 17 released
  0.12  RESERVE: zone 18 released
  0.12  RESERVE: zone 19 released
  0.12  RESERVE: zone 20 at (6008, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (6008, 10952) facing 2 (id 20)
  0.12  RESERVE: zone 21 at (5960, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5960, 10952) facing 2 (id 21)
  0.12  RESERVE: zone 22 at (5912, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5912, 10952) facing 2 (id 22)
  0.12  RESERVE: zone 23 at (5864, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5864, 10952) facing 2 (id 23)
  0.12  RESERVE: zone 24 at (5816, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5816, 10952) facing 2 (id 24)
  0.12  RESERVE: zone 25 at (5768, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5768, 10952) facing 2 (id 25)
  0.12  RESERVE: zone 26 at (6008, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (6008, 10904) facing 2 (id 26)
  0.12  RESERVE: zone 27 at (5960, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5960, 10904) facing 2 (id 27)
  0.12  RESERVE: zone 28 at (5912, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5912, 10904) facing 2 (id 28)
  0.12  RESERVE: zone 29 at (5864, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5864, 10904) facing 2 (id 29)
  0.12  RESERVE: zone 30 at (5816, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5816, 10904) facing 2 (id 30)
  0.12  RESERVE: zone 31 at (5768, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5768, 10904) facing 2 (id 31)
  0.12  RESERVE: zone 32 at (6008, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (6008, 10856) facing 2 (id 32)
  0.12  RESERVE: zone 33 at (5960, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5960, 10856) facing 2 (id 33)
  0.12  RESERVE: zone 34 at (5912, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5912, 10856) facing 2 (id 34)
  0.12  RESERVE: zone 35 at (5864, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5864, 10856) facing 2 (id 35)
  0.12  RESERVE: zone 36 at (5816, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5816, 10856) facing 2 (id 36)
  0.12  RESERVE: zone 37 at (5768, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5768, 10856) facing 2 (id 37)
  0.12  RESERVE: zone 38 at (6008, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (6008, 10808) facing 2 (id 38)
  0.12  RESERVE: zone 39 at (5960, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5960, 10808) facing 2 (id 39)
  0.12  RESERVE: zone 40 at (5912, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5912, 10808) facing 2 (id 40)
  0.12  RESERVE: zone 41 at (5864, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5864, 10808) facing 2 (id 41)
  0.12  RESERVE: zone 42 at (5816, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5816, 10808) facing 2 (id 42)
  0.12  RESERVE: zone 43 at (5768, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5768, 10808) facing 2 (id 43)
  0.12  RESERVE: zone 44 at (6008, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (6008, 10760) facing 2 (id 44)
  0.12  RESERVE: zone 45 at (5960, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5960, 10760) facing 2 (id 45)
  0.12  RESERVE: zone 46 at (5912, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5912, 10760) facing 2 (id 46)
  0.12  RESERVE: zone 47 at (5864, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5864, 10760) facing 2 (id 47)
  0.12  RESERVE: zone 48 at (5816, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5816, 10760) facing 2 (id 48)
  0.12  RESERVE: zone 49 at (5768, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5768, 10760) facing 2 (id 49)
  0.12  RESERVE: zone 50 at (6008, 10712) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (6008, 10712) facing 2 (id 50)
  0.12  RESERVE: zone 51 at (5960, 10712) facing 2, 3x3 cells: 9 of 9 held
```
