# Playtest report: PASS

- Verdict: **PASS** (reached 18 min)
- Game time reached: 18.0 min (frame 32428); wall 297 s
- DLL: build-theatres\d212-build2\SkirmishAI.dll (5879283eb5224a12); AI BARbTest/test; staged 2026-10-05T23:37:34
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/cortex/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: amphibious-transition.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-cortex\supreme\20261006T023734Z-380e3378\runs\20261006T024241Z-f6091b07\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `partial-survey` | seen at 1.8 min | `[t=00:00:53.354183][f=0003300] [SeaInvasionTest] PASS partial-survey-blocked` |
| expect `complex` | seen at 7.0 min | `[t=00:02:03.376760][f=0012588] [SeaInvasionTest] PASS complex-finished` |
| expect `gantry` | seen at 16.2 min | `[t=00:04:25.733821][f=0029184] [SeaInvasionTest] PASS gantry-finished` |
| expect `complex-production` | seen at 7.6 min | `[t=00:02:11.008119][f=0013680] [SeaInvasionTest] PASS complex-produced` |
| expect `gantry-production` | seen at 16.7 min | `[t=00:04:33.472821][f=0029995] [SeaInvasionTest] PASS gantry-produced` |
| expect `landfall` | seen at 9.3 min | `[t=00:02:33.941568][f=0016800] [SeaInvasionTest] PASS landfall` |
| expect `backline` | seen at 10.2 min | `[t=00:02:46.763880][f=0018300] [SeaInvasionTest] PASS backline-reached` |
| forbid `errors` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-cortex\supreme\20261006T023734Z-380e3378\runs\20261006T024241Z-f6091b07\screen_2026-10-06_02-38-40-712.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-cortex\supreme\20261006T023734Z-380e3378\runs\20261006T024241Z-f6091b07\screen_2026-10-06_02-39-26-095.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-cortex\supreme\20261006T023734Z-380e3378\runs\20261006T024241Z-f6091b07\screen_2026-10-06_02-39-30-221.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-cortex\supreme\20261006T023734Z-380e3378\runs\20261006T024241Z-f6091b07\screen_2026-10-06_02-40-19-029.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-cortex\supreme\20261006T023734Z-380e3378\runs\20261006T024241Z-f6091b07\screen_2026-10-06_02-40-29-582.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-cortex\supreme\20261006T023734Z-380e3378\runs\20261006T024241Z-f6091b07\screen_2026-10-06_02-40-52-103.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-cortex\supreme\20261006T023734Z-380e3378\runs\20261006T024241Z-f6091b07\screen_2026-10-06_02-42-07-798.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 20, 4 shots, end at 18.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished corcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 20000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side cortex ai true dead false start (5800, 10500) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.00  [Playtest] speed 20
  0.05  [Playtest] frame 90 team 0 ally 0 side cortex ai true dead false start (5800, 10500) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 33
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
  0.18  [SEA][Layout] berth sea.berth.0 corasy at=7104,10032 facing=2
  0.20  [SEA][Layout] berth sea.berth.1 corplat at=6608,10032 facing=2
  0.47  [Playtest] finished cortide team 0 at 0.47 min
  0.55  [Playtest] finished cormex team 0 at 0.55 min
  0.55  [Team][Roster] first mex 20981 at 6527,10319
  0.55  [Team][Roster] Re-announced: roster|1|0|0|SEA|cortex|corsy|5830|10504|0|7|1|6527|10319
  1.00  [Playtest] finished corason team 0 at 1.00 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +467.5 bank 42092/100300, energy +29507.0 bank 1047874/1061550, units 115
  1.05  [Playtest] finished cormex team 0 at 1.05 min
  1.17  [Playtest] finished cornanotcplat team 0 at 1.17 min
  1.28  [Playtest] finished cornanotcplat team 0 at 1.28 min
  1.29  [Playtest] finished coruwmme team 0 at 1.29 min
  1.33  [Playtest] finished corfmkr team 0 at 1.33 min
  1.69  [Playtest] finished cormex team 0 at 1.69 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +478.5 bank 69040/100900, energy +29507.0 bank 1047885/1061550, units 118
  2.00  [Playtest] camera requested (8500,6500) height=8500
  2.01  [Playtest] camera captured name=ta position=(8500,6500) height=8500
  2.01  [Playtest] screenshot at 2.0 min of team 0 at (8500, 6500)
  2.04  [Playtest] finished coruwmme team 0 at 2.04 min
  2.25  [Playtest] finished cormex team 0 at 2.25 min
  2.46  [Playtest] finished coruwmme team 0 at 2.46 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +496.5 bank 97062/102100, energy +29507.0 bank 1047681/1061550, units 346
  3.11  [Playtest] finished corason team 0 at 3.11 min
  3.12  [Playtest] finished coruwmme team 0 at 3.12 min
  3.70  [Playtest] finished coruwadvms team 0 at 3.70 min
  3.79  [Playtest] finished cormex team 0 at 3.79 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +511.5 bank 111794/112750, energy +29507.0 bank 1047999/1061550, units 349
  4.14  [Playtest] finished coruwmmm team 0 at 4.14 min
  4.38  [Playtest] finished cormex team 0 at 4.38 min
  4.70  [Playtest] finished cormex team 0 at 4.70 min
  4.94  [Playtest] finished cormex team 0 at 4.94 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +525.6 bank 112900/112900, energy +29507.0 bank 1047767/1061550, units 350
  5.00  [Playtest] camera requested (10800,4000) height=6500
  5.01  [Playtest] camera captured name=ta position=(10800,4000) height=6500
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (10800, 4000)
  5.43  [Playtest] finished cormex team 0 at 5.43 min
  5.70  [Playtest] finished cormex team 0 at 5.70 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +530.5 bank 112999/113000, energy +29507.0 bank 1047737/1061550, units 353
  6.34  [Playtest] finished cormex team 0 at 6.34 min
  6.55  [Playtest] finished corrad team 0 at 6.55 min
  6.79  [Playtest] finished corllt team 0 at 6.79 min
  6.99  [Playtest] finished coramsub team 0 at 6.99 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +532.8 bank 113050/113050, energy +29507.0 bank 1047761/1061710, units 356
  7.46  [Playtest] finished corllt team 0 at 7.46 min
  7.62  [Playtest] finished corrad team 0 at 7.62 min
  7.73  [Playtest] finished cornanotcplat team 0 at 7.73 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +532.0 bank 113049/113050, energy +29507.0 bank 1047702/1061710, units 362
  8.23  [Playtest] finished corllt team 0 at 8.23 min
  8.37  [Playtest] finished corrad team 0 at 8.37 min
  8.46  [Playtest] finished cornanotcplat team 0 at 8.46 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +535.7 bank 113049/113050, energy +29507.0 bank 1047803/1061710, units 367
  9.67  [Playtest] finished cornanotcplat team 0 at 9.67 min
  9.91  [Playtest] finished cornanotcplat team 0 at 9.91 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +532.0 bank 113047/113050, energy +29507.0 bank 1047650/1061710, units 377
 10.00  [Playtest] camera requested (10800,4000) height=5500
 10.01  [Playtest] camera captured name=ta position=(10800,4000) height=5500
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (10800, 4000)
 10.34  [Playtest] finished cornanotcplat team 0 at 10.34 min
 10.38  [Playtest] finished cortl team 0 at 10.38 min
 10.43  [Playtest] finished cornanotcplat team 0 at 10.43 min
 10.43  [Playtest] finished cornanotcplat team 0 at 10.43 min
 10.74  [Playtest] finished cortl team 0 at 10.74 min
 10.83  [Playtest] finished cornanotcplat team 0 at 10.83 min
 10.86  [Playtest] finished cornanotcplat team 0 at 10.86 min
 10.89  [Playtest] finished cornanotcplat team 0 at 10.89 min
 10.90  [Playtest] finished cornanotcplat team 0 at 10.90 min
 10.97  [Playtest] finished corfrad team 0 at 10.97 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +535.7 bank 113048/113050, energy +29507.0 bank 1047577/1061710, units 388
 11.15  [Playtest] finished cornanotcplat team 0 at 11.15 min
 11.16  [Playtest] finished cornanotcplat team 0 at 11.16 min
 11.19  [Playtest] finished cornanotcplat team 0 at 11.19 min
 11.73  [Playtest] finished cornanotcplat team 0 at 11.73 min
 11.74  [Playtest] finished cornanotcplat team 0 at 11.74 min
 11.88  [Playtest] finished cornanotcplat team 0 at 11.88 min
 11.91  [Playtest] finished cornanotcplat team 0 at 11.91 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +538.6 bank 113048/113050, energy +29507.0 bank 1047624/1061710, units 397
 12.33  [Playtest] finished cornanotcplat team 0 at 12.33 min
 12.35  [Playtest] finished cornanotcplat team 0 at 12.35 min
 12.89  [Playtest] finished cornanotcplat team 0 at 12.90 min
 12.89  [Playtest] finished cornanotcplat team 0 at 12.90 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +534.1 bank 113047/113050, energy +29507.0 bank 1047569/1061710, units 396
 13.11  [Playtest] finished cornanotcplat team 0 at 13.11 min
 13.16  [Playtest] finished cornanotcplat team 0 at 13.16 min
 13.34  [Playtest] finished cornanotcplat team 0 at 13.34 min
 13.47  [Playtest] finished cornanotcplat team 0 at 13.47 min
 13.81  [Playtest] finished cornanotcplat team 0 at 13.81 min
 13.96  [Playtest] finished cornanotcplat team 0 at 13.96 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +532.8 bank 113037/113050, energy +29507.0 bank 1047370/1061710, units 407
 14.08  [Playtest] finished cornanotcplat team 0 at 14.08 min
 14.21  [Playtest] finished cornanotcplat team 0 at 14.21 min
 14.22  [Playtest] finished cornanotcplat team 0 at 14.22 min
 14.41  [Playtest] finished cornanotcplat team 0 at 14.41 min
 14.53  [Playtest] finished cornanotcplat team 0 at 14.53 min
 14.57  [Playtest] finished cornanotcplat team 0 at 14.57 min
 14.59  [Playtest] finished cornanotcplat team 0 at 14.59 min
 14.59  [Playtest] finished coruwmmm team 0 at 14.59 min
 14.66  [Playtest] finished cornanotcplat team 0 at 14.66 min
 14.93  [Playtest] finished cornanotcplat team 0 at 14.93 min
 14.94  [Playtest] finished cornanotcplat team 0 at 14.94 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +543.9 bank 113046/113050, energy +29507.0 bank 1047304/1061710, units 416
 15.13  [Playtest] finished cortl team 0 at 15.13 min
 15.19  [Playtest] finished cornanotcplat team 0 at 15.19 min
 15.26  [Playtest] finished cornanotcplat team 0 at 15.26 min
 15.54  [Playtest] finished cortl team 0 at 15.53 min
 15.79  [Playtest] finished corfrad team 0 at 15.79 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +543.1 bank 113025/113050, energy +29507.0 bank 1047155/1061710, units 418
 16.00  [Playtest] camera requested (11000,2800) height=5500
 16.01  [Playtest] camera captured name=ta position=(11000,2800) height=5500
 16.01  [Playtest] screenshot at 16.0 min of team 0 at (11000, 2800)
 16.21  [Playtest] finished corgantuw team 0 at 16.21 min
 16.48  [Playtest] finished cornanotcplat team 0 at 16.48 min
 16.98  [Playtest] finished cornanotcplat team 0 at 16.98 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +548.1 bank 113832/113850, energy +29507.0 bank 1045442/1063110, units 431
 17.42  [Playtest] finished cornanotcplat team 0 at 17.42 min
 17.89  [Playtest] finished cornanotcplat team 0 at 17.89 min
 17.97  [Playtest] finished cornanotcplat team 0 at 17.97 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +546.8 bank 113828/113850, energy +29507.0 bank 1016496/1063110, units 442
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
