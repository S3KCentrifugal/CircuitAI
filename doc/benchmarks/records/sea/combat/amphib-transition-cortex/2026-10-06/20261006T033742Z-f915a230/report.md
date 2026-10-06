# Playtest report: PASS

- Verdict: **PASS** (reached 24 min)
- Game time reached: 24.0 min (frame 43230); wall 399 s
- DLL: build-theatres\d212-final\SkirmishAI.dll (f224e17dc3c6f798); AI BARbTest/test; staged 2026-10-06T00:30:54
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/cortex/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: amphibious-transition.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-cortex\supreme\20261006T033053Z-612b7bab\runs\20261006T033742Z-f915a230\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `partial-survey` | seen at 1.8 min | `[t=00:00:51.348128][f=0003300] [SeaInvasionTest] PASS partial-survey-blocked` |
| expect `complex` | seen at 5.9 min | `[t=00:01:43.115608][f=0010532] [SeaInvasionTest] PASS complex-finished` |
| expect `gantry` | seen at 11.4 min | `[t=00:03:01.094635][f=0020596] [SeaInvasionTest] PASS gantry-finished` |
| expect `complex-production` | seen at 6.5 min | `[t=00:01:50.527061][f=0011649] [SeaInvasionTest] PASS complex-produced` |
| expect `gantry-production` | seen at 11.9 min | `[t=00:03:07.596028][f=0021375] [SeaInvasionTest] PASS gantry-produced` |
| expect `landfall` | seen at 8.5 min | `[t=00:02:17.677075][f=0015300] [SeaInvasionTest] PASS landfall` |
| expect `backline` | seen at 9.3 min | `[t=00:02:31.403821][f=0016800] [SeaInvasionTest] PASS backline-reached` |
| expect `escort` | seen at 4.3 min | `[t=00:01:23.065916][f=0007789] [SeaInvasionTest] PASS factory-escorted` |
| expect `gantry-landing` | seen at 13.7 min | `[t=00:03:35.640460][f=0024600] [SeaInvasionTest] PASS gantry-landfall` |
| expect `gantry-backline` | seen at 15.2 min | `[t=00:04:01.420223][f=0027300] [SeaInvasionTest] PASS gantry-backline` |
| expect `combat` | seen at 9.7 min | `[t=00:02:36.443511][f=0017435] [SeaInvasionTest] PASS amphibian-damaged-economy` |
| forbid `errors` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-cortex\supreme\20261006T033053Z-612b7bab\runs\20261006T033742Z-f915a230\screen_2026-10-06_03-31-57-651.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-cortex\supreme\20261006T033053Z-612b7bab\runs\20261006T033742Z-f915a230\screen_2026-10-06_03-32-27-877.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-cortex\supreme\20261006T033053Z-612b7bab\runs\20261006T033742Z-f915a230\screen_2026-10-06_03-32-37-766.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-cortex\supreme\20261006T033053Z-612b7bab\runs\20261006T033742Z-f915a230\screen_2026-10-06_03-33-22-457.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-cortex\supreme\20261006T033053Z-612b7bab\runs\20261006T033742Z-f915a230\screen_2026-10-06_03-33-35-211.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-cortex\supreme\20261006T033053Z-612b7bab\runs\20261006T033742Z-f915a230\screen_2026-10-06_03-33-47-298.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-cortex\supreme\20261006T033053Z-612b7bab\runs\20261006T033742Z-f915a230\screen_2026-10-06_03-35-06-202.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-cortex\supreme\20261006T033053Z-612b7bab\runs\20261006T033742Z-f915a230\screen_2026-10-06_03-35-21-601.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 20, 4 shots, end at 24.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished corcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 20000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side cortex ai true dead false start (5800, 10500) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 26
  0.00  [Playtest] speed 20
  0.05  [Playtest] frame 90 team 0 ally 0 side cortex ai true dead false start (5800, 10500) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 26
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.18  [Playtest] finished corsy team 0 at 0.18 min
  0.18  [Playtest] finished corasy team 0 at 0.18 min
  0.18  [Playtest] finished corplat team 0 at 0.18 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.18  [SEA][Layout] berth sea.berth.0 corasy at=7456,10032 facing=2
  0.20  [SEA][Layout] berth sea.berth.1 corplat at=7056,10032 facing=2
  0.51  [Playtest] finished cormex team 0 at 0.50 min
  0.52  [Team][Roster] first mex 18126 at 6527,10319
  0.52  [Team][Roster] Re-announced: roster|1|0|0|SEA|cortex|corsy|5830|10504|0|7|1|6527|10319
  0.53  [Playtest] finished cortide team 0 at 0.52 min
  0.93  [Playtest] finished corason team 0 at 0.93 min
  0.98  [Playtest] finished cornanotcplat team 0 at 0.98 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +467.5 bank 41837/100300, energy +29507.0 bank 1048046/1061550, units 115
  1.01  [Playtest] finished cormex team 0 at 1.01 min
  1.14  [Playtest] finished coruwmme team 0 at 1.14 min
  1.27  [Playtest] finished cornanotcplat team 0 at 1.27 min
  1.42  [Playtest] finished corfrad team 0 at 1.42 min
  1.68  [Playtest] finished cormex team 0 at 1.68 min
  1.81  [Playtest] finished cortl team 0 at 1.81 min
  1.86  [Playtest] finished coruwmme team 0 at 1.86 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +488.2 bank 69011/101550, energy +29507.0 bank 1047972/1061550, units 123
  2.00  [Playtest] camera requested (8500,6500) height=8500
  2.01  [Playtest] camera captured name=ta position=(8500,6500) height=8500
  2.01  [Playtest] screenshot at 2.0 min of team 0 at (8500, 6500)
  2.25  [Playtest] finished cormex team 0 at 2.25 min
  2.42  [Playtest] finished cortl team 0 at 2.42 min
  2.44  [Playtest] finished cortl team 0 at 2.44 min
  2.76  [Playtest] finished corason team 0 at 2.76 min
  2.81  [Playtest] finished cortl team 0 at 2.81 min
  2.85  [Playtest] finished coruwmme team 0 at 2.85 min
  3.00  [Playtest] finished corfrad team 0 at 3.00 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +496.7 bank 96449/102100, energy +29507.0 bank 1047852/1061550, units 351
  3.26  [Playtest] finished coruwmme team 0 at 3.26 min
  3.43  [Playtest] finished cortl team 0 at 3.43 min
  3.61  [Playtest] finished coruwadvms team 0 at 3.61 min
  3.91  [Playtest] finished cormex team 0 at 3.91 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +507.1 bank 112749/112750, energy +29507.0 bank 1048044/1061550, units 353
  4.02  [Playtest] finished cortl team 0 at 4.02 min
  4.21  [Playtest] finished corfrad team 0 at 4.21 min
  4.45  [Playtest] finished cormex team 0 at 4.45 min
  4.74  [Playtest] finished cortl team 0 at 4.74 min
  4.78  [Playtest] finished cormex team 0 at 4.78 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +511.2 bank 112847/112850, energy +29507.0 bank 1047878/1061550, units 359
  5.00  [Playtest] camera requested (10800,4000) height=6500
  5.01  [Playtest] camera captured name=ta position=(10800,4000) height=6500
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (10800, 4000)
  5.01  [Playtest] finished coruwmmm team 0 at 5.01 min
  5.01  [Playtest] finished cormex team 0 at 5.01 min
  5.28  [Playtest] finished cortl team 0 at 5.28 min
  5.41  [Playtest] finished coruwmmm team 0 at 5.41 min
  5.46  [Playtest] finished corfrad team 0 at 5.46 min
  5.55  [Playtest] finished cormex team 0 at 5.55 min
  5.83  [Playtest] finished cormex team 0 at 5.83 min
  5.85  [Playtest] finished coramsub team 0 at 5.85 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +538.3 bank 112999/113000, energy +29507.0 bank 1047435/1061710, units 365
  6.45  [Playtest] finished cormex team 0 at 6.45 min
  6.56  [Playtest] finished cornanotcplat team 0 at 6.56 min
  6.70  [Playtest] finished corrad team 0 at 6.70 min
  6.94  [Playtest] finished corllt team 0 at 6.94 min
  6.99  [Playtest] finished coruwmmm team 0 at 6.99 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +540.6 bank 113048/113050, energy +29507.0 bank 1047141/1061710, units 373
  7.22  [Playtest] finished cornanotcplat team 0 at 7.22 min
  7.36  [Playtest] finished cornanotcplat team 0 at 7.36 min
  7.37  [Playtest] finished cornanotcplat team 0 at 7.37 min
  7.49  [Playtest] finished cornanotcplat team 0 at 7.49 min
  7.54  [Playtest] finished cornanotcplat team 0 at 7.54 min
  7.64  [Playtest] finished corllt team 0 at 7.64 min
  7.85  [Playtest] finished corrad team 0 at 7.85 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +551.9 bank 113049/113050, energy +29507.0 bank 1047198/1061710, units 381
  8.44  [Playtest] finished corllt team 0 at 8.44 min
  8.65  [Playtest] finished corrad team 0 at 8.65 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +551.3 bank 113049/113050, energy +29507.0 bank 1047226/1061710, units 384
  9.32  [Playtest] finished corllt team 0 at 9.32 min
  9.47  [Playtest] finished corrad team 0 at 9.47 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +552.5 bank 113046/113050, energy +29507.0 bank 1047030/1061710, units 391
 10.00  [Playtest] camera requested (10800,4000) height=5500
 10.01  [Playtest] camera captured name=ta position=(10800,4000) height=5500
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (10800, 4000)
 10.79  [Playtest] finished cornanotcplat team 0 at 10.79 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +550.9 bank 113036/113050, energy +29507.0 bank 1037704/1061710, units 392
 11.07  [Playtest] finished cornanotcplat team 0 at 11.07 min
 11.35  [Playtest] finished cornanotcplat team 0 at 11.35 min
 11.44  [Playtest] finished corgantuw team 0 at 11.44 min
 11.62  [Playtest] finished cornanotcplat team 0 at 11.62 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +551.7 bank 113830/113850, energy +29507.0 bank 1000057/1063110, units 400
 12.13  [Playtest] finished cornanotcplat team 0 at 12.13 min
 12.38  [Playtest] finished cornanotcplat team 0 at 12.38 min
 12.40  [Playtest] finished cornanotcplat team 0 at 12.40 min
 12.41  [Playtest] finished cornanotcplat team 0 at 12.41 min
 12.65  [Playtest] finished cornanotcplat team 0 at 12.65 min
 12.77  [Playtest] finished cornanotcplat team 0 at 12.77 min
 12.81  [Playtest] finished cornanotcplat team 0 at 12.81 min
 12.89  [Playtest] finished cornanotcplat team 0 at 12.89 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +551.7 bank 113840/113850, energy +29507.0 bank 940081/1063110, units 409
 14.00  [Playtest] eco team 0 at 14.0 min: metal +551.7 bank 113840/113850, energy +29507.0 bank 899965/1063110, units 414
 15.00  [Playtest] eco team 0 at 15.0 min: metal +551.7 bank 113836/113850, energy +29507.0 bank 853249/1063110, units 417
 15.89  [Playtest] finished coruwmmm team 0 at 15.89 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +540.4 bank 113844/113850, energy +29507.0 bank 811376/1063110, units 422
 16.00  [Playtest] camera requested (11000,2800) height=5500
 16.01  [Playtest] camera captured name=ta position=(11000,2800) height=5500
 16.01  [Playtest] screenshot at 16.0 min of team 0 at (11000, 2800)
 17.00  [Playtest] eco team 0 at 17.0 min: metal +549.9 bank 113844/113850, energy +29507.0 bank 811382/1063110, units 427
 18.00  [Playtest] eco team 0 at 18.0 min: metal +540.4 bank 113844/113850, energy +29507.0 bank 811382/1063110, units 430
 19.00  [Playtest] eco team 0 at 19.0 min: metal +540.0 bank 113844/113850, energy +29507.0 bank 811382/1063110, units 434
 20.00  [Playtest] eco team 0 at 20.0 min: metal +541.2 bank 113843/113850, energy +29507.0 bank 811382/1063110, units 438
 20.55  [Playtest] finished coratl team 0 at 20.55 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +538.8 bank 113843/113850, energy +29507.0 bank 811382/1063110, units 442
 22.00  [Playtest] eco team 0 at 22.0 min: metal +538.8 bank 113843/113850, energy +29507.0 bank 811382/1063110, units 447
 23.00  [Playtest] eco team 0 at 23.0 min: metal +538.8 bank 113844/113850, energy +29507.0 bank 811475/1063110, units 451
 24.00  [Playtest] eco team 0 at 24.0 min: metal +538.8 bank 113842/113850, energy +29507.0 bank 811382/1063110, units 455
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: zone 1 at (5912, 11112) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: cortide at (5912, 11112) facing 2 (id 1)
  0.08  RESERVE: zone 1 released
  0.08  RESERVE: zone 2 at (5864, 10984) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: cortide at (5864, 10984) facing 2 (id 2)
  0.08  RESERVE: zone 3 at (5816, 10984) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: cortide at (5816, 10984) facing 2 (id 3)
  0.08  RESERVE: zone 2 released
  0.08  RESERVE: zone 3 released
  0.08  RESERVE: zone 4 at (5880, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: cortide at (5880, 10952) facing 2 (id 4)
  0.08  RESERVE: zone 5 at (5832, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: cortide at (5832, 10952) facing 2 (id 5)
  0.08  RESERVE: zone 6 at (5784, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: cortide at (5784, 10952) facing 2 (id 6)
  0.08  RESERVE: zone 4 released
  0.08  RESERVE: zone 5 released
  0.08  RESERVE: zone 6 released
  0.08  RESERVE: zone 7 at (5912, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: cortide at (5912, 10936) facing 2 (id 7)
  0.08  RESERVE: zone 8 at (5864, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: cortide at (5864, 10936) facing 2 (id 8)
  0.08  RESERVE: zone 9 at (5816, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: cortide at (5816, 10936) facing 2 (id 9)
  0.08  RESERVE: zone 10 at (5768, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: cortide at (5768, 10936) facing 2 (id 10)
  0.08  RESERVE: zone 7 released
  0.08  RESERVE: zone 8 released
  0.08  RESERVE: zone 9 released
  0.08  RESERVE: zone 10 released
  0.08  RESERVE: zone 11 at (5944, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: cortide at (5944, 10920) facing 2 (id 11)
  0.08  RESERVE: zone 12 at (5896, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: cortide at (5896, 10920) facing 2 (id 12)
  0.08  RESERVE: zone 13 at (5848, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: cortide at (5848, 10920) facing 2 (id 13)
  0.08  RESERVE: zone 14 at (5800, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: cortide at (5800, 10920) facing 2 (id 14)
  0.08  RESERVE: zone 11 released
  0.08  RESERVE: zone 12 released
  0.08  RESERVE: zone 13 released
  0.08  RESERVE: zone 14 released
  0.12  RESERVE: zone 15 at (5992, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5992, 10936) facing 2 (id 15)
  0.12  RESERVE: zone 16 at (5944, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5944, 10936) facing 2 (id 16)
  0.12  RESERVE: zone 17 at (5896, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5896, 10936) facing 2 (id 17)
  0.12  RESERVE: zone 18 at (5848, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5848, 10936) facing 2 (id 18)
  0.12  RESERVE: zone 19 at (5800, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5800, 10936) facing 2 (id 19)
  0.12  RESERVE: zone 15 released
  0.12  RESERVE: zone 16 released
  0.12  RESERVE: zone 17 released
  0.12  RESERVE: zone 18 released
  0.12  RESERVE: zone 19 released
  0.12  RESERVE: zone 20 at (6024, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (6024, 10952) facing 2 (id 20)
  0.12  RESERVE: zone 21 at (5976, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5976, 10952) facing 2 (id 21)
  0.12  RESERVE: zone 22 at (5928, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5928, 10952) facing 2 (id 22)
  0.12  RESERVE: zone 23 at (5880, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5880, 10952) facing 2 (id 23)
  0.12  RESERVE: zone 24 at (5832, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5832, 10952) facing 2 (id 24)
  0.12  RESERVE: zone 25 at (5784, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5784, 10952) facing 2 (id 25)
  0.12  RESERVE: zone 26 at (6024, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (6024, 10904) facing 2 (id 26)
  0.12  RESERVE: zone 27 at (5976, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5976, 10904) facing 2 (id 27)
  0.12  RESERVE: zone 28 at (5928, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5928, 10904) facing 2 (id 28)
  0.12  RESERVE: zone 29 at (5880, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5880, 10904) facing 2 (id 29)
  0.12  RESERVE: zone 30 at (5832, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5832, 10904) facing 2 (id 30)
  0.12  RESERVE: zone 31 at (5784, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5784, 10904) facing 2 (id 31)
  0.12  RESERVE: zone 32 at (6024, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (6024, 10856) facing 2 (id 32)
  0.12  RESERVE: zone 33 at (5976, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5976, 10856) facing 2 (id 33)
  0.12  RESERVE: zone 34 at (5928, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5928, 10856) facing 2 (id 34)
  0.12  RESERVE: zone 35 at (5880, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5880, 10856) facing 2 (id 35)
  0.12  RESERVE: zone 36 at (5832, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5832, 10856) facing 2 (id 36)
  0.12  RESERVE: zone 37 at (5784, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5784, 10856) facing 2 (id 37)
  0.12  RESERVE: zone 38 at (6024, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (6024, 10808) facing 2 (id 38)
  0.12  RESERVE: zone 39 at (5976, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5976, 10808) facing 2 (id 39)
  0.12  RESERVE: zone 40 at (5928, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5928, 10808) facing 2 (id 40)
  0.12  RESERVE: zone 41 at (5880, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5880, 10808) facing 2 (id 41)
  0.12  RESERVE: zone 42 at (5832, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5832, 10808) facing 2 (id 42)
  0.12  RESERVE: zone 43 at (5784, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5784, 10808) facing 2 (id 43)
  0.12  RESERVE: zone 44 at (6024, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (6024, 10760) facing 2 (id 44)
  0.12  RESERVE: zone 45 at (5976, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5976, 10760) facing 2 (id 45)
  0.12  RESERVE: zone 46 at (5928, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5928, 10760) facing 2 (id 46)
  0.12  RESERVE: zone 47 at (5880, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5880, 10760) facing 2 (id 47)
  0.12  RESERVE: zone 48 at (5832, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5832, 10760) facing 2 (id 48)
  0.12  RESERVE: zone 49 at (5784, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (5784, 10760) facing 2 (id 49)
  0.12  RESERVE: zone 50 at (6024, 10712) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: cortide at (6024, 10712) facing 2 (id 50)
  0.12  RESERVE: zone 51 at (5976, 10712) facing 2, 3x3 cells: 9 of 9 held
```
