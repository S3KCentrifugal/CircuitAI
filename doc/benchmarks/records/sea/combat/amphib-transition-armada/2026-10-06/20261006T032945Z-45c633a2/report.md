# Playtest report: PASS

- Verdict: **PASS** (reached 24 min)
- Game time reached: 24.0 min (frame 43230); wall 382 s
- DLL: build-theatres\d212-final\SkirmishAI.dll (f224e17dc3c6f798); AI BARbTest/test; staged 2026-10-06T00:23:15
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: amphibious-transition.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T032315Z-fe30536c\runs\20261006T032945Z-45c633a2\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `partial-survey` | seen at 1.8 min | `[t=00:00:46.898759][f=0003300] [SeaInvasionTest] PASS partial-survey-blocked` |
| expect `complex` | seen at 5.9 min | `[t=00:01:34.513582][f=0010678] [SeaInvasionTest] PASS complex-finished` |
| expect `gantry` | seen at 11.4 min | `[t=00:02:46.303452][f=0020513] [SeaInvasionTest] PASS gantry-finished` |
| expect `complex-production` | seen at 7.1 min | `[t=00:01:48.071733][f=0012862] [SeaInvasionTest] PASS complex-produced` |
| expect `gantry-production` | seen at 11.7 min | `[t=00:02:50.044654][f=0021048] [SeaInvasionTest] PASS gantry-produced` |
| expect `landfall` | seen at 9.2 min | `[t=00:02:14.310949][f=0016500] [SeaInvasionTest] PASS landfall` |
| expect `backline` | seen at 9.5 min | `[t=00:02:18.898584][f=0017100] [SeaInvasionTest] PASS backline-reached` |
| expect `escort` | seen at 5.1 min | `[t=00:01:25.428565][f=0009159] [SeaInvasionTest] PASS factory-escorted` |
| expect `gantry-landing` | seen at 13.3 min | `[t=00:03:14.502718][f=0024000] [SeaInvasionTest] PASS gantry-landfall` |
| expect `gantry-backline` | seen at 13.3 min | `[t=00:03:14.502745][f=0024000] [SeaInvasionTest] PASS gantry-backline` |
| expect `combat` | seen at 10.7 min | `[t=00:02:36.961762][f=0019347] [SeaInvasionTest] PASS amphibian-damaged-economy` |
| forbid `errors` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T032315Z-fe30536c\runs\20261006T032945Z-45c633a2\screen_2026-10-06_03-24-12-814.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T032315Z-fe30536c\runs\20261006T032945Z-45c633a2\screen_2026-10-06_03-24-48-900.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T032315Z-fe30536c\runs\20261006T032945Z-45c633a2\screen_2026-10-06_03-24-49-950.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T032315Z-fe30536c\runs\20261006T032945Z-45c633a2\screen_2026-10-06_03-25-35-838.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T032315Z-fe30536c\runs\20261006T032945Z-45c633a2\screen_2026-10-06_03-25-38-884.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T032315Z-fe30536c\runs\20261006T032945Z-45c633a2\screen_2026-10-06_03-25-52-117.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T032315Z-fe30536c\runs\20261006T032945Z-45c633a2\screen_2026-10-06_03-27-24-130.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 20, 4 shots, end at 24.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 20000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (5800, 10500) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 35
  0.00  [Playtest] speed 20
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (5800, 10500) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 35
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
  0.18  [SEA][Layout] berth sea.berth.0 armasy at=6544,10032 facing=2
  0.20  [SEA][Layout] berth sea.berth.1 armplat at=6144,10032 facing=2
  0.42  [SEA][Layout] berth sea.berth.2 armsy at=6352,10032 facing=2
  0.46  [Playtest] finished armtide team 0 at 0.46 min
  0.81  [Playtest] finished armnanotcplat team 0 at 0.81 min
  0.87  [Playtest] finished armmex team 0 at 0.87 min
  0.88  [Team][Roster] first mex 3425 at 6848,9664
  0.88  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|5827|10504|0|7|1|6848|9664
  0.95  [Playtest] finished armuwmme team 0 at 0.95 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +480.4 bank 41710/100950, energy +29027.0 bank 1047948/1061550, units 116
  1.01  [Playtest] finished armnanotcplat team 0 at 1.01 min
  1.31  [Playtest] finished armason team 0 at 1.31 min
  1.48  [Playtest] finished armfmkr team 0 at 1.48 min
  1.49  [Playtest] finished armmex team 0 at 1.49 min
  1.62  [Playtest] finished armuwmme team 0 at 1.63 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +487.6 bank 68779/101500, energy +29027.0 bank 1047859/1061550, units 121
  2.00  [Playtest] camera requested (8500,6500) height=8500
  2.01  [Playtest] camera captured name=ta position=(8500,6500) height=8500
  2.01  [Playtest] screenshot at 2.0 min of team 0 at (8500, 6500)
  2.01  [Playtest] finished armmex team 0 at 2.01 min
  2.03  [Playtest] finished armason team 0 at 2.03 min
  2.11  [Playtest] finished armuwmme team 0 at 2.11 min
  2.38  [Playtest] finished armtl team 0 at 2.38 min
  2.65  [Playtest] finished armtl team 0 at 2.65 min
  2.91  [Playtest] finished armtl team 0 at 2.91 min
  2.98  [Playtest] finished armuwmme team 0 at 2.98 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +501.4 bank 97082/102700, energy +29027.0 bank 1047895/1061550, units 349
  3.24  [Playtest] finished armtl team 0 at 3.24 min
  3.39  [Playtest] finished armfrad team 0 at 3.39 min
  3.58  [Playtest] finished armfrad team 0 at 3.58 min
  3.61  [Playtest] finished armuwmmm team 0 at 3.61 min
  3.93  [Playtest] finished armuwmmm team 0 at 3.93 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +526.0 bank 102699/102700, energy +29027.0 bank 1047330/1061550, units 350
  4.09  [Playtest] finished armuwmmm team 0 at 4.09 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +537.0 bank 102699/102700, energy +29027.0 bank 1045564/1061550, units 353
  5.00  [Playtest] camera requested (10800,4000) height=6500
  5.01  [Playtest] camera captured name=ta position=(10800,4000) height=6500
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (10800, 4000)
  5.12  [Playtest] finished armuwmmm team 0 at 5.12 min
  5.93  [Playtest] finished armamsub team 0 at 5.93 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +548.1 bank 102699/102700, energy +29027.0 bank 994250/1061700, units 358
  6.22  [Playtest] finished armnanotcplat team 0 at 6.22 min
  6.97  [Playtest] finished armnanotcplat team 0 at 6.97 min
  6.97  [Playtest] finished armnanotcplat team 0 at 6.97 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +548.8 bank 102699/102700, energy +29027.0 bank 921956/1061700, units 363
  7.07  [Playtest] finished armuwmmm team 0 at 7.07 min
  7.09  [Playtest] finished armnanotcplat team 0 at 7.09 min
  7.10  [Playtest] finished armnanotcplat team 0 at 7.10 min
  7.36  [Playtest] finished armnanotcplat team 0 at 7.36 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +557.0 bank 102699/102700, energy +29027.0 bank 830284/1061700, units 362
  8.34  [Playtest] finished armtl team 0 at 8.34 min
  8.66  [Playtest] finished armtl team 0 at 8.66 min
  8.73  [Playtest] finished armuwmmm team 0 at 8.73 min
  8.82  [Playtest] finished armfrad team 0 at 8.82 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +528.5 bank 102698/102700, energy +29027.0 bank 810477/1061700, units 367
 10.00  [Playtest] eco team 0 at 10.0 min: metal +527.2 bank 102697/102700, energy +29027.0 bank 810440/1061700, units 369
 10.00  [Playtest] camera requested (10800,4000) height=5500
 10.01  [Playtest] camera captured name=ta position=(10800,4000) height=5500
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (10800, 4000)
 10.27  [Playtest] finished armnanotcplat team 0 at 10.27 min
 10.45  [Playtest] finished armnanotcplat team 0 at 10.45 min
 10.61  [Playtest] finished armnanotcplat team 0 at 10.61 min
 10.80  [Playtest] finished armnanotcplat team 0 at 10.80 min
 10.99  [Playtest] finished armnanotcplat team 0 at 10.99 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +516.8 bank 102696/102700, energy +29027.0 bank 810288/1061700, units 375
 11.07  [Playtest] finished armnanotcplat team 0 at 11.07 min
 11.40  [Playtest] finished armshltxuw team 0 at 11.40 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +504.7 bank 103491/103500, energy +29027.0 bank 810737/1063100, units 385
 12.06  [Playtest] finished armnanotcplat team 0 at 12.06 min
 12.18  [Playtest] finished armnanotcplat team 0 at 12.18 min
 12.21  [Playtest] finished armnanotcplat team 0 at 12.21 min
 12.29  [Playtest] finished armnanotcplat team 0 at 12.29 min
 12.35  [Playtest] finished armnanotcplat team 0 at 12.35 min
 12.41  [Playtest] finished armnanotcplat team 0 at 12.41 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +501.1 bank 103493/103500, energy +29027.0 bank 810731/1063100, units 387
 14.00  [Playtest] eco team 0 at 14.0 min: metal +499.7 bank 103493/103500, energy +29027.0 bank 810692/1063100, units 393
 15.00  [Playtest] eco team 0 at 15.0 min: metal +499.7 bank 103493/103500, energy +29027.0 bank 810692/1063100, units 399
 16.00  [Playtest] eco team 0 at 16.0 min: metal +499.7 bank 103493/103500, energy +29027.0 bank 810692/1063100, units 405
 16.00  [Playtest] camera requested (11000,2800) height=5500
 16.02  [Playtest] camera captured name=ta position=(11000,2800) height=5500
 16.02  [Playtest] screenshot at 16.0 min of team 0 at (11000, 2800)
 17.00  [Playtest] eco team 0 at 17.0 min: metal +501.2 bank 103493/103500, energy +29027.0 bank 810692/1063100, units 411
 18.00  [Playtest] eco team 0 at 18.0 min: metal +501.2 bank 103489/103500, energy +29027.0 bank 810692/1063100, units 417
 19.00  [Playtest] eco team 0 at 19.0 min: metal +501.2 bank 103489/103500, energy +29027.0 bank 810692/1063100, units 422
 20.00  [Playtest] eco team 0 at 20.0 min: metal +534.2 bank 103489/103500, energy +29027.0 bank 810777/1063100, units 428
 20.40  [Playtest] finished armatl team 0 at 20.40 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +503.6 bank 103490/103500, energy +29027.0 bank 810803/1063100, units 434
 21.86  [Playtest] finished armuwadvms team 0 at 21.85 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +503.6 bank 107275/113500, energy +29027.0 bank 811123/1063100, units 442
 22.68  [Playtest] finished armuwadvms team 0 at 22.68 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +500.2 bank 121771/123500, energy +29027.0 bank 810705/1063100, units 448
 23.61  [Playtest] finished armuwadvms team 0 at 23.61 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +519.5 bank 133491/133500, energy +29027.0 bank 811118/1063100, units 455
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
