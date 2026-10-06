# Playtest report: PASS

- Verdict: **PASS** (reached 15 min)
- Game time reached: 15.0 min (frame 27000); wall 136 s
- DLL: build-theatres\d216-final\SkirmishAI.dll (45eb0f2e89a285e3); AI BARbTest/test; staged 2026-10-06T12:05:35
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/cortex/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: coast-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T150535Z-1dda3af0\runs\20261006T150754Z-063c8c6c\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loss` | seen at 2.5 min | `[SEA][Coast] fallback=true body=2` |
| expect `donation` | seen at 2.0 min | `[t=00:00:48.126758][f=0003630] [CoastFixture] frame=3630 donated corck id=18333` |
| expect `lab` | seen at 4.7 min | `[t=00:01:01.676481][f=0008528] [CoastFixture] frame=8528 finished corlab x=5392 z=8608` |
| expect `metal-storage` | seen at 6.6 min | `[t=00:01:14.412231][f=0011813] [CoastFixture] frame=11813 finished cormstor x=5728 z=8704` |
| expect `energy-storage` | seen at 6.2 min | `[t=00:01:11.556391][f=0011096] [CoastFixture] frame=11096 finished corestor x=5280 z=8608` |
| expect `t1-defense` | seen at 7.3 min | `[t=00:01:23.004281][f=0013203] [CoastFixture] frame=13203 finished corhlt x=5936 z=8944` |
| expect `t2-defense` | seen at 6.9 min | `[t=00:01:17.662400][f=0012430] [CoastFixture] frame=12430 finished corvipe x=5336 z=10024` |
| expect `retake` | seen at 13.0 min | `[SEA][Coast] fallback=false body=2` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T150535Z-1dda3af0\runs\20261006T150754Z-063c8c6c\screen_2026-10-06_15-06-31-843.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T150535Z-1dda3af0\runs\20261006T150754Z-063c8c6c\screen_2026-10-06_15-06-32-454.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T150535Z-1dda3af0\runs\20261006T150754Z-063c8c6c\screen_2026-10-06_15-06-37-381.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T150535Z-1dda3af0\runs\20261006T150754Z-063c8c6c\screen_2026-10-06_15-06-42-469.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T150535Z-1dda3af0\runs\20261006T150754Z-063c8c6c\screen_2026-10-06_15-06-48-263.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T150535Z-1dda3af0\runs\20261006T150754Z-063c8c6c\screen_2026-10-06_15-06-48-566.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T150535Z-1dda3af0\runs\20261006T150754Z-063c8c6c\screen_2026-10-06_15-06-58-420.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T150535Z-1dda3af0\runs\20261006T150754Z-063c8c6c\screen_2026-10-06_15-07-10-012.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T150535Z-1dda3af0\runs\20261006T150754Z-063c8c6c\screen_2026-10-06_15-07-18-294.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T150535Z-1dda3af0\runs\20261006T150754Z-063c8c6c\screen_2026-10-06_15-07-24-201.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T150535Z-1dda3af0\runs\20261006T150754Z-063c8c6c\screen_2026-10-06_15-07-24-798.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T150535Z-1dda3af0\runs\20261006T150754Z-063c8c6c\screen_2026-10-06_15-07-30-703.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T150535Z-1dda3af0\runs\20261006T150754Z-063c8c6c\screen_2026-10-06_15-07-36-856.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T150535Z-1dda3af0\runs\20261006T150754Z-063c8c6c\screen_2026-10-06_15-07-42-976.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T150535Z-1dda3af0\runs\20261006T150754Z-063c8c6c\screen_2026-10-06_15-07-43-572.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T150535Z-1dda3af0\runs\20261006T150754Z-063c8c6c\screen_2026-10-06_15-07-48-498.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-retake-cortex\supreme\20261006T150535Z-1dda3af0\runs\20261006T150754Z-063c8c6c\screen_2026-10-06_15-07-53-443.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 15.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished corcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side cortex ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 32
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side cortex ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 32
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
  3.00  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  3.00  [Playtest] screenshot at 3.0 min of team 0 at (4814, 11077)
  4.00  [Playtest] eco team 0 at 4.0 min: metal +0.0 bank 468/500, energy +7.0 bank 507/550, units 2
  4.74  [Playtest] finished corlab team 0 at 4.74 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +0.0 bank 579/600, energy +7.0 bank 384/650, units 3
  6.00  [Playtest] eco team 0 at 6.0 min: metal +0.0 bank 493/600, energy +77.0 bank 112/1150, units 13
  6.00  [Playtest] camera requested (4814,11077) height=2200
  6.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  6.01  [Playtest] screenshot at 6.0 min of team 0 at (4814, 11077)
  6.16  [Playtest] finished corestor team 0 at 6.16 min
  6.56  [Playtest] finished cormstor team 0 at 6.56 min
  6.91  [Playtest] finished corvipe team 0 at 6.91 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +0.0 bank 3407/3600, energy +98.0 bank 4639/7300, units 21
  7.05  [Playtest] finished corsolar team 0 at 7.05 min
  7.25  [Playtest] finished corvipe team 0 at 7.26 min
  7.33  [Playtest] finished corhlt team 0 at 7.34 min
  7.43  [Playtest] finished corvipe team 0 at 7.43 min
  7.63  [Playtest] finished cornanotc team 0 at 7.63 min
  7.76  [Playtest] finished corvipe team 0 at 7.76 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +0.0 bank 3393/3600, energy +132.0 bank 6130/7650, units 27
  8.02  [Playtest] finished corrad team 0 at 8.02 min
  8.71  [Playtest] finished corrad team 0 at 8.71 min
  8.88  [Playtest] finished corvipe team 0 at 8.88 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +0.0 bank 3319/3600, energy +132.0 bank 4764/7650, units 38
  9.23  [Playtest] finished corjamt team 0 at 9.23 min
  9.26  [Playtest] finished coralab team 0 at 9.26 min
  9.35  [Playtest] finished corvipe team 0 at 9.35 min
  9.43  [Playtest] finished cordl team 0 at 9.43 min
  9.47  [Playtest] finished corvipe team 0 at 9.47 min
  9.54  [Playtest] finished cordl team 0 at 9.54 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +0.0 bank 3491/3800, energy +132.0 bank 2469/7850, units 50
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 10.03  [Playtest] finished cordl team 0 at 10.03 min
 10.08  [Playtest] finished corjamt team 0 at 10.08 min
 10.24  [Playtest] finished corrad team 0 at 10.24 min
 10.37  [Playtest] finished cordl team 0 at 10.37 min
 10.67  [Playtest] finished corvipe team 0 at 10.67 min
 10.85  [Playtest] finished corjamt team 0 at 10.85 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +0.0 bank 3604/3800, energy +132.0 bank 1854/7850, units 64
 11.02  [Playtest] finished corvipe team 0 at 11.02 min
 11.40  [Playtest] finished corjamt team 0 at 11.40 min
 11.67  [Playtest] finished corvipe team 0 at 11.67 min
 11.99  [Playtest] finished corrad team 0 at 11.99 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +0.0 bank 3510/3800, energy +132.0 bank 2121/7850, units 81
 12.00  [Playtest] finished corsy team 0 at 12.00 min
 12.15  [Playtest] finished cordl team 0 at 12.15 min
 12.38  [Playtest] finished cordl team 0 at 12.38 min
 12.52  [Playtest] finished corjamt team 0 at 12.52 min
 12.67  [Playtest] finished corjamt team 0 at 12.67 min
 12.86  [Playtest] finished corfort team 0 at 12.86 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +0.0 bank 3572/3900, energy +146.0 bank 429/8050, units 96
 13.00  [Playtest] camera requested (4814,11077) height=2200
 13.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 13.01  [Playtest] screenshot at 13.0 min of team 0 at (4814, 11077)
 13.12  [Playtest] finished corvipe team 0 at 13.12 min
 13.17  [Playtest] finished corvipe team 0 at 13.17 min
 13.41  [Playtest] finished cormex team 0 at 13.41 min
 13.42  [Team][Roster] first mex 26369 at 5215,8399
 13.42  [Team][Roster] Re-announced: roster|1|0|0|SEA|cortex|corsy|4813|11078|0|7|1|5215|8399
 13.54  [Playtest] finished cormex team 0 at 13.54 min
 13.62  [Playtest] finished corllt team 0 at 13.62 min
 13.86  [Playtest] finished coradvsol team 0 at 13.86 min
 13.86  [Playtest] finished cornanotcplat team 0 at 13.86 min
 13.89  [Playtest] finished cordl team 0 at 13.89 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +4.6 bank 3451/4000, energy +263.0 bank 1198/8450, units 118
 14.04  [Playtest] finished corllt team 0 at 14.03 min
 14.05  [Playtest] finished cormex team 0 at 14.05 min
 14.12  [Playtest] finished cornanotc team 0 at 14.12 min
 14.48  [Playtest] finished coruwadvms team 0 at 14.48 min
 14.78  [Playtest] finished cornanotcplat team 0 at 14.78 min
 14.80  [Playtest] finished cormex team 0 at 14.80 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +9.2 bank 13602/14100, energy +294.0 bank 0/8570, units 129
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
