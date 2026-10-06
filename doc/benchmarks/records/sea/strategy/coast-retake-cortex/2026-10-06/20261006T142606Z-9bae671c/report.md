# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 14.2 min (frame 25552); wall 105 s
- DLL: build-theatres\d216-final\SkirmishAI.dll (45eb0f2e89a285e3); AI BARbTest/test; staged 2026-10-06T11:24:19
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/cortex/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI None, role TECH
- Checks: coast-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T142419Z-36c1c812\runs\20261006T142606Z-9bae671c\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loss` | seen at 2.5 min | `[SEA][Coast] fallback=true body=2` |
| expect `donation` | seen at 2.0 min | `[t=00:00:47.165824][f=0003631] [CoastFixture] frame=3631 donated corck id=25877` |
| expect `lab` | seen at 4.7 min | `[t=00:00:59.181600][f=0008528] [CoastFixture] frame=8528 finished corlab x=5392 z=8608` |
| expect `metal-storage` | seen at 6.4 min | `[t=00:01:08.301922][f=0011572] [CoastFixture] frame=11572 finished cormstor x=5728 z=8704` |
| expect `energy-storage` | seen at 6.1 min | `[t=00:01:07.039910][f=0010997] [CoastFixture] frame=10997 finished corestor x=5280 z=8608` |
| expect `t1-defense` | **missing** (by 10 min) | |
| expect `t2-defense` | **missing** (by 14 min) | |
| expect `retake` | seen at 7.7 min | `[SEA][Coast] fallback=false body=2` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Failures

- 't1-defense' not seen by 10.0 min
- 't2-defense' not seen by 14.0 min

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T142419Z-36c1c812\runs\20261006T142606Z-9bae671c\screen_2026-10-06_14-25-13-683.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T142419Z-36c1c812\runs\20261006T142606Z-9bae671c\screen_2026-10-06_14-25-14-684.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T142419Z-36c1c812\runs\20261006T142606Z-9bae671c\screen_2026-10-06_14-25-18-667.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T142419Z-36c1c812\runs\20261006T142606Z-9bae671c\screen_2026-10-06_14-25-22-821.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T142419Z-36c1c812\runs\20261006T142606Z-9bae671c\screen_2026-10-06_14-25-27-888.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T142419Z-36c1c812\runs\20261006T142606Z-9bae671c\screen_2026-10-06_14-25-28-890.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T142419Z-36c1c812\runs\20261006T142606Z-9bae671c\screen_2026-10-06_14-25-33-521.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T142419Z-36c1c812\runs\20261006T142606Z-9bae671c\screen_2026-10-06_14-25-37-745.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T142419Z-36c1c812\runs\20261006T142606Z-9bae671c\screen_2026-10-06_14-25-41-739.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T142419Z-36c1c812\runs\20261006T142606Z-9bae671c\screen_2026-10-06_14-25-45-742.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T142419Z-36c1c812\runs\20261006T142606Z-9bae671c\screen_2026-10-06_14-25-46-742.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T142419Z-36c1c812\runs\20261006T142606Z-9bae671c\screen_2026-10-06_14-25-50-728.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T142419Z-36c1c812\runs\20261006T142606Z-9bae671c\screen_2026-10-06_14-25-54-726.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T142419Z-36c1c812\runs\20261006T142606Z-9bae671c\screen_2026-10-06_14-25-58-732.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T142419Z-36c1c812\runs\20261006T142606Z-9bae671c\screen_2026-10-06_14-25-59-732.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T142419Z-36c1c812\runs\20261006T142606Z-9bae671c\screen_2026-10-06_14-26-03-865.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 14.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished corcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side cortex ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side cortex ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.33  [Playtest] finished corsy team 0 at 0.33 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1079/1100, energy +37.0 bank 1150/1150, units 3
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1100/1100, energy +37.0 bank 1150/1150, units 3
  3.00  [Playtest] eco team 0 at 3.0 min: metal +0.0 bank 500/500, energy +7.0 bank 550/550, units 1
  3.00  [Playtest] target team 0 at (4814, 11077) from its start position
  3.00  [Playtest] camera requested (4814,11077) height=2200
  3.00  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  3.00  [Playtest] screenshot at 3.0 min of team 0 at (4814, 11077)
  4.00  [Playtest] eco team 0 at 4.0 min: metal +0.0 bank 468/500, energy +7.0 bank 507/550, units 2
  4.74  [Playtest] finished corlab team 0 at 4.74 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +0.0 bank 561/600, energy +7.0 bank 384/650, units 4
  5.47  [Playtest] finished corsolar team 0 at 5.47 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +0.0 bank 513/600, energy +41.0 bank 402/800, units 9
  6.00  [Playtest] camera requested (4814,11077) height=2200
  6.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  6.01  [Playtest] screenshot at 6.0 min of team 0 at (4814, 11077)
  6.11  [Playtest] finished corestor team 0 at 6.11 min
  6.43  [Playtest] finished cormstor team 0 at 6.43 min
  6.67  [Playtest] finished corsy team 0 at 6.67 min
  6.81  [Playtest] finished corsolar team 0 at 6.81 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +0.0 bank 3619/3700, energy +105.4 bank 6544/7000, units 18
  7.60  [Playtest] finished corsolar team 0 at 7.60 min
  7.95  [Playtest] finished cornanotc team 0 at 7.95 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +0.0 bank 3552/3700, energy +132.4 bank 6345/7100, units 28
  8.20  [Playtest] finished cormex team 0 at 8.20 min
  8.31  [Playtest] finished corsolar team 0 at 8.31 min
  8.44  [Playtest] finished coradvsol team 0 at 8.44 min
  8.54  [Playtest] finished cornanotcplat team 0 at 8.54 min
  8.63  [Playtest] finished cormstor team 0 at 8.63 min
  8.70  [Playtest] finished cormex team 0 at 8.70 min
  8.95  [Playtest] finished corhllt team 0 at 8.95 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +4.6 bank 6689/6800, energy +202.0 bank 6431/7300, units 41
  9.06  [Playtest] finished cornanotcplat team 0 at 9.06 min
  9.14  [Playtest] finished corllt team 0 at 9.14 min
  9.18  [Playtest] finished cormex team 0 at 9.18 min
  9.38  [Playtest] finished cornanotcplat team 0 at 9.38 min
  9.43  [Playtest] finished cormex team 0 at 9.43 min
  9.54  [Playtest] finished cornanotcplat team 0 at 9.55 min
  9.68  [Playtest] finished cornanotcplat team 0 at 9.68 min
  9.72  [Playtest] finished cormex team 0 at 9.72 min
  9.90  [Playtest] finished cornanotcplat team 0 at 9.90 min
  9.99  [Playtest] finished corrad team 0 at 9.99 min
 10.00  [Playtest] finished coradvsol team 0 at 10.00 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +11.5 bank 6357/6950, energy +223.0 bank 2942/7550, units 61
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 10.02  [Playtest] finished cormex team 0 at 10.02 min
 10.04  [Playtest] finished cormex team 0 at 10.05 min
 10.22  [Playtest] finished corllt team 0 at 10.22 min
 10.24  [Playtest] finished cornanotc team 0 at 10.24 min
 10.54  [Playtest] finished cornanotc team 0 at 10.54 min
 10.54  [Playtest] finished coradvsol team 0 at 10.54 min
 10.61  [Playtest] finished cortl team 0 at 10.61 min
 10.92  [Playtest] finished corfrad team 0 at 10.92 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +16.1 bank 6793/7050, energy +533.0 bank 7250/7900, units 79
 11.36  [Playtest] finished corgeo team 0 at 11.36 min
 11.52  [Playtest] finished coradvsol team 0 at 11.52 min
 11.53  [Playtest] finished corhllt team 0 at 11.53 min
 11.72  [Playtest] finished cornanotcplat team 0 at 11.72 min
 11.78  [Playtest] finished cormakr team 0 at 11.77 min
 11.81  [Playtest] finished cornanotcplat team 0 at 11.81 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +17.1 bank 6989/7050, energy +848.7 bank 8914/9000, units 99
 12.21  [Playtest] finished coradvsol team 0 at 12.21 min
 12.47  [Playtest] finished cormakr team 0 at 12.47 min
 12.92  [Playtest] finished corasy team 0 at 12.92 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +18.1 bank 6690/7250, energy +878.0 bank 7810/9300, units 124
 13.00  [Playtest] camera requested (4814,11077) height=2200
 13.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 13.01  [Playtest] screenshot at 13.0 min of team 0 at (4814, 11077)
 13.01  [Playtest] finished corhllt team 0 at 13.01 min
 13.17  [Playtest] finished corhllt team 0 at 13.17 min
 13.18  [Playtest] finished corplat team 0 at 13.18 min
 13.40  [Playtest] finished cornanotcplat team 0 at 13.40 min
 13.40  [Playtest] finished corhlt team 0 at 13.40 min
 13.51  [Playtest] finished cornanotcplat team 0 at 13.51 min
 13.56  [Playtest] finished corhllt team 0 at 13.56 min
 13.68  [Playtest] finished coradvsol team 0 at 13.68 min
 13.89  [Playtest] finished cornanotcplat team 0 at 13.89 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +16.1 bank 6676/7250, energy +988.0 bank 483/9950, units 153
 14.11  [Playtest] finished coradvsol team 0 at 14.11 min
 14.20  [Playtest] finished corjuno team 0 at 14.20 min
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
