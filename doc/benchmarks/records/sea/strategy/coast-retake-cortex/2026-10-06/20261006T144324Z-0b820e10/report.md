# Playtest report: PASS

- Verdict: **PASS** (reached 15 min)
- Game time reached: 15.0 min (frame 27000); wall 126 s
- DLL: build-theatres\d216-final\SkirmishAI.dll (45eb0f2e89a285e3); AI BARbTest/test; staged 2026-10-06T11:41:16
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/cortex/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: coast-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T144115Z-4c4eb78b\runs\20261006T144324Z-0b820e10\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loss` | seen at 2.5 min | `[SEA][Coast] fallback=true body=2` |
| expect `donation` | seen at 2.0 min | `[t=00:00:49.015189][f=0003631] [CoastFixture] frame=3631 donated corck id=14964` |
| expect `lab` | seen at 4.7 min | `[t=00:01:02.539944][f=0008529] [CoastFixture] frame=8529 finished corlab x=5392 z=8608` |
| expect `metal-storage` | seen at 6.5 min | `[t=00:01:14.552021][f=0011757] [CoastFixture] frame=11757 finished cormstor x=5728 z=8704` |
| expect `energy-storage` | seen at 6.1 min | `[t=00:01:12.212904][f=0011032] [CoastFixture] frame=11032 finished corestor x=5280 z=8608` |
| expect `t1-defense` | seen at 7.3 min | `[t=00:01:19.651659][f=0013229] [CoastFixture] frame=13229 finished corhlt x=5936 z=8944` |
| expect `t2-defense` | seen at 6.9 min | `[t=00:01:16.137335][f=0012494] [CoastFixture] frame=12494 finished corvipe x=5336 z=10024` |
| expect `retake` | seen at 13.0 min | `[SEA][Coast] fallback=false body=2` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T144115Z-4c4eb78b\runs\20261006T144324Z-0b820e10\screen_2026-10-06_14-42-13-169.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T144115Z-4c4eb78b\runs\20261006T144324Z-0b820e10\screen_2026-10-06_14-42-13-759.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T144115Z-4c4eb78b\runs\20261006T144324Z-0b820e10\screen_2026-10-06_14-42-18-685.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T144115Z-4c4eb78b\runs\20261006T144324Z-0b820e10\screen_2026-10-06_14-42-23-777.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T144115Z-4c4eb78b\runs\20261006T144324Z-0b820e10\screen_2026-10-06_14-42-29-616.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T144115Z-4c4eb78b\runs\20261006T144324Z-0b820e10\screen_2026-10-06_14-42-29-918.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T144115Z-4c4eb78b\runs\20261006T144324Z-0b820e10\screen_2026-10-06_14-42-36-561.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T144115Z-4c4eb78b\runs\20261006T144324Z-0b820e10\screen_2026-10-06_14-42-42-980.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T144115Z-4c4eb78b\runs\20261006T144324Z-0b820e10\screen_2026-10-06_14-42-48-752.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T144115Z-4c4eb78b\runs\20261006T144324Z-0b820e10\screen_2026-10-06_14-42-54-496.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T144115Z-4c4eb78b\runs\20261006T144324Z-0b820e10\screen_2026-10-06_14-42-55-127.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T144115Z-4c4eb78b\runs\20261006T144324Z-0b820e10\screen_2026-10-06_14-43-01-114.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T144115Z-4c4eb78b\runs\20261006T144324Z-0b820e10\screen_2026-10-06_14-43-07-096.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T144115Z-4c4eb78b\runs\20261006T144324Z-0b820e10\screen_2026-10-06_14-43-13-282.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T144115Z-4c4eb78b\runs\20261006T144324Z-0b820e10\screen_2026-10-06_14-43-13-929.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T144115Z-4c4eb78b\runs\20261006T144324Z-0b820e10\screen_2026-10-06_14-43-18-853.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T144115Z-4c4eb78b\runs\20261006T144324Z-0b820e10\screen_2026-10-06_14-43-23-793.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 15.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished corcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side cortex ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 34
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side cortex ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 34
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.33  [Playtest] finished corsy team 0 at 0.33 min
  0.35  [SEA][Layout] berth sea.berth.0 corasy at=5968,10304 facing=2
  0.42  [SEA][Layout] berth sea.berth.1 corplat at=5776,10512 facing=2
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1079/1100, energy +37.0 bank 1150/1150, units 3
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1100/1100, energy +37.0 bank 1150/1150, units 3
  2.12  [SEA][Layout] berth sea.berth.2 corsy at=6160,10304 facing=2
  3.00  [Playtest] eco team 0 at 3.0 min: metal +0.0 bank 500/500, energy +7.0 bank 550/550, units 1
  3.00  [Playtest] target team 0 at (4814, 11077) from its start position
  3.00  [Playtest] camera requested (4814,11077) height=2200
  3.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  3.01  [Playtest] screenshot at 3.0 min of team 0 at (4814, 11077)
  4.00  [Playtest] eco team 0 at 4.0 min: metal +0.0 bank 468/500, energy +7.0 bank 507/550, units 2
  4.74  [Playtest] finished corlab team 0 at 4.74 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +0.0 bank 579/600, energy +7.0 bank 384/650, units 3
  6.00  [Playtest] eco team 0 at 6.0 min: metal +0.0 bank 483/600, energy +77.0 bank 59/1150, units 13
  6.00  [Playtest] camera requested (4814,11077) height=2200
  6.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  6.01  [Playtest] screenshot at 6.0 min of team 0 at (4814, 11077)
  6.13  [Playtest] finished corestor team 0 at 6.13 min
  6.53  [Playtest] finished cormstor team 0 at 6.53 min
  6.88  [Playtest] finished corsolar team 0 at 6.88 min
  6.91  [Playtest] finished corsolar team 0 at 6.91 min
  6.94  [Playtest] finished corvipe team 0 at 6.94 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +0.0 bank 3421/3600, energy +138.0 bank 4812/7400, units 22
  7.26  [Playtest] finished corvipe team 0 at 7.26 min
  7.35  [Playtest] finished corhlt team 0 at 7.35 min
  7.39  [Playtest] finished corvipe team 0 at 7.39 min
  7.71  [Playtest] finished cornanotc team 0 at 7.72 min
  7.73  [Playtest] finished corvipe team 0 at 7.73 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +0.0 bank 3397/3600, energy +152.0 bank 6327/7700, units 28
  8.35  [Playtest] finished corrad team 0 at 8.35 min
  8.88  [Playtest] finished corvipe team 0 at 8.88 min
  8.96  [Playtest] finished corjamt team 0 at 8.96 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +0.0 bank 3306/3600, energy +152.0 bank 4850/7700, units 39
  9.05  [Playtest] finished corrad team 0 at 9.05 min
  9.10  [Playtest] finished cordl team 0 at 9.10 min
  9.31  [Playtest] finished coralab team 0 at 9.31 min
  9.38  [Playtest] finished cordl team 0 at 9.38 min
  9.41  [Playtest] finished corvipe team 0 at 9.41 min
  9.46  [Playtest] finished corvipe team 0 at 9.46 min
  9.85  [Playtest] finished corjamt team 0 at 9.85 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +0.0 bank 3491/3800, energy +152.0 bank 2629/7900, units 52
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 10.02  [Playtest] finished corjamt team 0 at 10.02 min
 10.05  [Playtest] finished cordl team 0 at 10.05 min
 10.32  [Playtest] finished corrad team 0 at 10.32 min
 10.64  [Playtest] finished cordl team 0 at 10.64 min
 10.65  [Playtest] finished corvipe team 0 at 10.65 min
 10.96  [Playtest] finished corjamt team 0 at 10.96 min
 10.99  [Playtest] finished corvipe team 0 at 10.99 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +0.0 bank 3515/3800, energy +152.0 bank 598/7900, units 66
 11.47  [Playtest] finished cordl team 0 at 11.47 min
 11.61  [Playtest] finished corrad team 0 at 11.61 min
 11.64  [Playtest] finished corvipe team 0 at 11.64 min
 11.88  [Playtest] finished corjamt team 0 at 11.88 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +0.0 bank 3526/3800, energy +152.0 bank 3586/7900, units 80
 12.00  [Playtest] finished corsy team 0 at 12.00 min
 12.17  [Playtest] finished cordl team 0 at 12.17 min
 12.88  [Playtest] finished corfort team 0 at 12.88 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +0.0 bank 3566/3900, energy +166.0 bank 308/8100, units 98
 13.00  [Playtest] camera requested (4814,11077) height=2200
 13.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 13.01  [Playtest] screenshot at 13.0 min of team 0 at (4814, 11077)
 13.11  [Playtest] finished corvipe team 0 at 13.11 min
 13.18  [Playtest] finished corvipe team 0 at 13.18 min
 13.19  [Playtest] finished corjamt team 0 at 13.19 min
 13.24  [Playtest] finished corjamt team 0 at 13.24 min
 13.47  [Playtest] finished cormex team 0 at 13.47 min
 13.48  [Team][Roster] first mex 27842 at 6815,11135
 13.48  [Team][Roster] Re-announced: roster|1|0|0|SEA|cortex|corsy|4813|11078|0|7|1|6815|11135
 13.48  [Playtest] finished corrad team 0 at 13.48 min
 13.68  [Playtest] finished cordl team 0 at 13.68 min
 13.68  [Playtest] finished cormex team 0 at 13.68 min
 13.97  [Playtest] finished cormex team 0 at 13.97 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +6.9 bank 3577/4050, energy +190.0 bank 2805/8220, units 116
 14.21  [Playtest] finished coradvsol team 0 at 14.21 min
 14.30  [Playtest] finished cornanotcplat team 0 at 14.30 min
 14.32  [Playtest] finished corllt team 0 at 14.32 min
 14.59  [Playtest] finished coruwadvms team 0 at 14.59 min
 14.70  [Playtest] finished cormex team 0 at 14.70 min
 14.91  [Playtest] finished coradvsol team 0 at 14.91 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +9.2 bank 13634/14100, energy +415.4 bank 449/8720, units 125
```

## Native lines (all AIs, first 120)

```
  0.35  RESERVE: zone 1 at (5968, 10304) facing 2, 12x12 cells: 144 of 144 held
  0.35  RESERVE: corasy at (5968, 10304) facing 2 (id 1)
  0.35  RESERVE: corridor 2 at (5968, 9968) facing 2, 18x30 cells: 540 of 540 held
  0.35  RESERVE: zone 3 at (5880, 10680) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5880, 10680) facing 2 (id 2)
  0.35  RESERVE: zone 4 at (5832, 10680) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5832, 10680) facing 2 (id 3)
  0.35  RESERVE: zone 3 released
  0.35  RESERVE: zone 4 released
  0.35  RESERVE: zone 5 at (5880, 10600) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5880, 10600) facing 2 (id 4)
  0.35  RESERVE: zone 6 at (5832, 10600) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5832, 10600) facing 2 (id 5)
  0.35  RESERVE: zone 7 at (5784, 10600) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5784, 10600) facing 2 (id 6)
  0.35  RESERVE: zone 8 at (5736, 10600) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5736, 10600) facing 2 (id 7)
  0.35  RESERVE: zone 5 released
  0.35  RESERVE: zone 6 released
  0.35  RESERVE: zone 7 released
  0.35  RESERVE: zone 8 released
  0.35  RESERVE: zone 9 at (5880, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5880, 10520) facing 2 (id 8)
  0.35  RESERVE: zone 10 at (5832, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5832, 10520) facing 2 (id 9)
  0.35  RESERVE: zone 11 at (5784, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5784, 10520) facing 2 (id 10)
  0.35  RESERVE: zone 12 at (5736, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5736, 10520) facing 2 (id 11)
  0.35  RESERVE: zone 13 at (5688, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5688, 10520) facing 2 (id 12)
  0.35  RESERVE: zone 14 at (5880, 10472) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5880, 10472) facing 2 (id 13)
  0.35  RESERVE: zone 15 at (5832, 10472) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5832, 10472) facing 2 (id 14)
  0.35  RESERVE: zone 16 at (5784, 10472) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5784, 10472) facing 2 (id 15)
  0.35  RESERVE: zone 17 at (5736, 10472) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5736, 10472) facing 2 (id 16)
  0.35  RESERVE: zone 18 at (5688, 10472) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5688, 10472) facing 2 (id 17)
  0.35  RESERVE: zone 19 at (5880, 10424) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5880, 10424) facing 2 (id 18)
  0.35  RESERVE: zone 20 at (5832, 10424) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5832, 10424) facing 2 (id 19)
  0.35  RESERVE: zone 21 at (5784, 10424) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5784, 10424) facing 2 (id 20)
  0.35  RESERVE: zone 22 at (5736, 10424) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5736, 10424) facing 2 (id 21)
  0.35  RESERVE: zone 23 at (5688, 10424) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5688, 10424) facing 2 (id 22)
  0.35  RESERVE: zone 9 released
  0.35  RESERVE: zone 10 released
  0.35  RESERVE: zone 11 released
  0.35  RESERVE: zone 12 released
  0.35  RESERVE: zone 13 released
  0.35  RESERVE: zone 14 released
  0.35  RESERVE: zone 15 released
  0.35  RESERVE: zone 16 released
  0.35  RESERVE: zone 17 released
  0.35  RESERVE: zone 18 released
  0.35  RESERVE: zone 19 released
  0.35  RESERVE: zone 20 released
  0.35  RESERVE: zone 21 released
  0.35  RESERVE: zone 22 released
  0.35  RESERVE: zone 23 released
  0.35  RESERVE: zone 24 at (5928, 10472) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5928, 10472) facing 2 (id 23)
  0.35  RESERVE: zone 25 at (5880, 10472) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5880, 10472) facing 2 (id 24)
  0.35  RESERVE: zone 26 at (5832, 10472) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5832, 10472) facing 2 (id 25)
  0.35  RESERVE: zone 27 at (5784, 10472) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5784, 10472) facing 2 (id 26)
  0.35  RESERVE: zone 28 at (5736, 10472) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5736, 10472) facing 2 (id 27)
  0.35  RESERVE: zone 29 at (5928, 10424) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5928, 10424) facing 2 (id 28)
  0.35  RESERVE: zone 30 at (5880, 10424) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5880, 10424) facing 2 (id 29)
  0.35  RESERVE: zone 31 at (5832, 10424) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5832, 10424) facing 2 (id 30)
  0.35  RESERVE: zone 32 at (5784, 10424) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5784, 10424) facing 2 (id 31)
  0.35  RESERVE: zone 33 at (5736, 10424) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5736, 10424) facing 2 (id 32)
  0.35  RESERVE: zone 24 released
  0.35  RESERVE: zone 25 released
  0.35  RESERVE: zone 26 released
  0.35  RESERVE: zone 27 released
  0.35  RESERVE: zone 28 released
  0.35  RESERVE: zone 29 released
  0.35  RESERVE: zone 30 released
  0.35  RESERVE: zone 31 released
  0.35  RESERVE: zone 32 released
  0.35  RESERVE: zone 33 released
  0.35  RESERVE: zone 34 at (5864, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5864, 10920) facing 2 (id 33)
  0.35  RESERVE: zone 35 at (5816, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5816, 10920) facing 2 (id 34)
  0.35  RESERVE: zone 36 at (5768, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5768, 10920) facing 2 (id 35)
  0.35  RESERVE: zone 34 released
  0.35  RESERVE: zone 35 released
  0.35  RESERVE: zone 36 released
  0.35  RESERVE: zone 37 at (5880, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5880, 10856) facing 2 (id 36)
  0.35  RESERVE: zone 38 at (5832, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5832, 10856) facing 2 (id 37)
  0.35  RESERVE: zone 39 at (5784, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5784, 10856) facing 2 (id 38)
  0.35  RESERVE: zone 37 released
  0.35  RESERVE: zone 38 released
  0.35  RESERVE: zone 39 released
  0.35  RESERVE: zone 40 at (5928, 10792) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5928, 10792) facing 2 (id 39)
  0.35  RESERVE: zone 41 at (5880, 10792) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5880, 10792) facing 2 (id 40)
  0.35  RESERVE: zone 42 at (5832, 10792) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: cornanotcplat at (5832, 10792) facing 2 (id 41)
```
