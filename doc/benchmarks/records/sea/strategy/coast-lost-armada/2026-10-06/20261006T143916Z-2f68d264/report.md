# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 25.1 min (frame 45130); wall 275 s
- DLL: build-theatres\d216-final\SkirmishAI.dll (45eb0f2e89a285e3); AI BARbTest/test; staged 2026-10-06T11:34:39
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: coast-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T143438Z-eba024f5\runs\20261006T143916Z-2f68d264\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loss` | seen at 2.5 min | `[SEA][Coast] fallback=true body=2` |
| expect `donation` | seen at 2.0 min | `[t=00:00:48.356399][f=0003631] [CoastFixture] frame=3631 donated armck id=5254` |
| expect `lab` | seen at 4.7 min | `[t=00:01:00.424740][f=0008534] [CoastFixture] frame=8534 finished armlab x=5392 z=8608` |
| expect `metal-storage` | seen at 6.6 min | `[t=00:01:23.277106][f=0011819] [CoastFixture] frame=11819 finished armmstor x=5728 z=8704` |
| expect `energy-storage` | seen at 6.9 min | `[t=00:01:27.015969][f=0012428] [CoastFixture] frame=12428 finished armestor x=5160 z=8616` |
| expect `t1-defense` | **missing** (by 10 min) | |
| expect `t2-defense` | seen at 7.4 min | `[t=00:01:35.237887][f=0013379] [CoastFixture] frame=13379 finished armpb x=5336 z=10024` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Failures

- 't1-defense' not seen by 10.0 min

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T143438Z-eba024f5\runs\20261006T143916Z-2f68d264\screen_2026-10-06_14-35-34-815.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T143438Z-eba024f5\runs\20261006T143916Z-2f68d264\screen_2026-10-06_14-35-35-815.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T143438Z-eba024f5\runs\20261006T143916Z-2f68d264\screen_2026-10-06_14-35-39-802.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T143438Z-eba024f5\runs\20261006T143916Z-2f68d264\screen_2026-10-06_14-35-43-952.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T143438Z-eba024f5\runs\20261006T143916Z-2f68d264\screen_2026-10-06_14-35-59-389.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T143438Z-eba024f5\runs\20261006T143916Z-2f68d264\screen_2026-10-06_14-36-00-391.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T143438Z-eba024f5\runs\20261006T143916Z-2f68d264\screen_2026-10-06_14-36-10-253.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T143438Z-eba024f5\runs\20261006T143916Z-2f68d264\screen_2026-10-06_14-36-24-910.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T143438Z-eba024f5\runs\20261006T143916Z-2f68d264\screen_2026-10-06_14-36-34-146.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T143438Z-eba024f5\runs\20261006T143916Z-2f68d264\screen_2026-10-06_14-36-43-758.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T143438Z-eba024f5\runs\20261006T143916Z-2f68d264\screen_2026-10-06_14-36-44-763.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T143438Z-eba024f5\runs\20261006T143916Z-2f68d264\screen_2026-10-06_14-36-53-088.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T143438Z-eba024f5\runs\20261006T143916Z-2f68d264\screen_2026-10-06_14-37-02-342.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T143438Z-eba024f5\runs\20261006T143916Z-2f68d264\screen_2026-10-06_14-37-09-839.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T143438Z-eba024f5\runs\20261006T143916Z-2f68d264\screen_2026-10-06_14-37-10-838.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T143438Z-eba024f5\runs\20261006T143916Z-2f68d264\screen_2026-10-06_14-37-18-896.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T143438Z-eba024f5\runs\20261006T143916Z-2f68d264\screen_2026-10-06_14-37-28-482.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T143438Z-eba024f5\runs\20261006T143916Z-2f68d264\screen_2026-10-06_14-37-38-814.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T143438Z-eba024f5\runs\20261006T143916Z-2f68d264\screen_2026-10-06_14-37-48-833.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T143438Z-eba024f5\runs\20261006T143916Z-2f68d264\screen_2026-10-06_14-37-57-635.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T143438Z-eba024f5\runs\20261006T143916Z-2f68d264\screen_2026-10-06_14-38-08-677.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T143438Z-eba024f5\runs\20261006T143916Z-2f68d264\screen_2026-10-06_14-38-17-778.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T143438Z-eba024f5\runs\20261006T143916Z-2f68d264\screen_2026-10-06_14-38-27-172.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T143438Z-eba024f5\runs\20261006T143916Z-2f68d264\screen_2026-10-06_14-38-38-762.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T143438Z-eba024f5\runs\20261006T143916Z-2f68d264\screen_2026-10-06_14-38-50-354.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T143438Z-eba024f5\runs\20261006T143916Z-2f68d264\screen_2026-10-06_14-39-02-661.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T143438Z-eba024f5\runs\20261006T143916Z-2f68d264\screen_2026-10-06_14-39-14-196.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 25.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 23
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 23
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.33  [Playtest] finished armsy team 0 at 0.33 min
  0.35  [SEA][Layout] berth sea.berth.0 armasy at=5968,10304 facing=2
  0.42  [SEA][Layout] berth sea.berth.1 armplat at=5776,10512 facing=2
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1080/1100, energy +37.0 bank 1150/1150, units 3
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1100/1100, energy +37.0 bank 1150/1150, units 3
  2.10  [SEA][Layout] berth sea.berth.2 armsy at=6160,10304 facing=2
  3.00  [Playtest] eco team 0 at 3.0 min: metal +0.0 bank 500/500, energy +7.0 bank 550/550, units 1
  3.00  [Playtest] target team 0 at (4814, 11077) from its start position
  3.00  [Playtest] camera requested (4814,11077) height=2200
  3.00  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  3.00  [Playtest] screenshot at 3.0 min of team 0 at (4814, 11077)
  4.00  [Playtest] eco team 0 at 4.0 min: metal +0.0 bank 468/500, energy +7.0 bank 517/550, units 2
  4.74  [Playtest] finished armlab team 0 at 4.74 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +0.0 bank 567/600, energy +7.0 bank 210/650, units 4
  5.89  [Playtest] finished armnanotc team 0 at 5.89 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +0.0 bank 517/600, energy +84.0 bank 59/1200, units 13
  6.00  [Playtest] camera requested (4814,11077) height=2200
  6.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  6.01  [Playtest] screenshot at 6.0 min of team 0 at (4814, 11077)
  6.57  [Playtest] finished armmstor team 0 at 6.57 min
  6.90  [Playtest] finished armestor team 0 at 6.90 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +0.0 bank 3437/3600, energy +94.5 bank 2385/7300, units 19
  7.43  [Playtest] finished armrad team 0 at 7.43 min
  7.43  [Playtest] finished armpb team 0 at 7.43 min
  7.67  [Playtest] finished armpb team 0 at 7.66 min
  7.73  [Playtest] finished armsolar team 0 at 7.73 min
  7.85  [Playtest] finished armpb team 0 at 7.85 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +0.0 bank 3481/3600, energy +153.9 bank 6296/7450, units 29
  8.06  [Playtest] finished armpb team 0 at 8.06 min
  8.68  [Playtest] finished armdl team 0 at 8.68 min
  8.92  [Playtest] finished armdl team 0 at 8.92 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +0.0 bank 3413/3600, energy +132.0 bank 3950/7450, units 41
  9.33  [Playtest] finished armpb team 0 at 9.33 min
  9.37  [Playtest] finished armrad team 0 at 9.37 min
  9.74  [Playtest] finished armpb team 0 at 9.74 min
  9.93  [Playtest] finished armpb team 0 at 9.93 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +0.0 bank 3453/3600, energy +132.0 bank 5025/7450, units 54
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 10.41  [Playtest] finished armdl team 0 at 10.41 min
 10.47  [Playtest] finished armdl team 0 at 10.47 min
 10.53  [Playtest] finished armjamt team 0 at 10.53 min
 10.54  [Playtest] finished armjamt team 0 at 10.54 min
 10.88  [Playtest] finished armpb team 0 at 10.88 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +0.0 bank 3414/3600, energy +132.0 bank 4112/7450, units 63
 11.46  [Playtest] finished armpb team 0 at 11.46 min
 11.46  [Playtest] finished armjamt team 0 at 11.46 min
 11.49  [Playtest] finished armjamt team 0 at 11.49 min
 11.66  [Playtest] finished armrad team 0 at 11.66 min
 11.69  [Playtest] finished armpb team 0 at 11.69 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +0.0 bank 3489/3600, energy +132.0 bank 5386/7450, units 74
 12.10  [Playtest] finished armdl team 0 at 12.10 min
 12.34  [Playtest] finished armdl team 0 at 12.34 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +0.0 bank 3441/3600, energy +189.5 bank 4100/7450, units 81
 13.00  [Playtest] camera requested (4814,11077) height=2200
 13.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 13.01  [Playtest] screenshot at 13.0 min of team 0 at (4814, 11077)
 13.04  [Playtest] finished armrad team 0 at 13.04 min
 13.20  [Playtest] finished armpb team 0 at 13.20 min
 13.23  [Playtest] finished armfort team 0 at 13.23 min
 13.28  [Playtest] finished armfort team 0 at 13.28 min
 13.39  [Playtest] finished armjamt team 0 at 13.39 min
 13.51  [Playtest] finished armfort team 0 at 13.51 min
 13.62  [Playtest] finished armfort team 0 at 13.62 min
 13.81  [Playtest] finished armrad team 0 at 13.81 min
 13.86  [Playtest] finished armjamt team 0 at 13.86 min
 13.98  [Playtest] finished armpb team 0 at 13.98 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +0.0 bank 3478/3600, energy +132.0 bank 3953/7450, units 95
 14.21  [Playtest] finished armdl team 0 at 14.21 min
 14.36  [Playtest] finished armjamt team 0 at 14.36 min
 14.65  [Playtest] finished armdl team 0 at 14.65 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +0.0 bank 3513/3600, energy +132.0 bank 4919/7450, units 102
 15.31  [Playtest] finished armmine2 team 0 at 15.31 min
 15.44  [Playtest] finished armfort team 0 at 15.44 min
 15.51  [Playtest] finished armmine2 team 0 at 15.51 min
 15.69  [Playtest] finished armmine2 team 0 at 15.69 min
 15.85  [Playtest] finished armfort team 0 at 15.85 min
 15.89  [Playtest] finished armrad team 0 at 15.89 min
 15.91  [Playtest] finished armjamt team 0 at 15.91 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +0.0 bank 3493/3600, energy +118.0 bank 4541/7350, units 118
 16.24  [Playtest] finished armfort team 0 at 16.24 min
 16.64  [Playtest] finished armdl team 0 at 16.64 min
 16.70  [Playtest] finished armdl team 0 at 16.70 min
 16.88  [Playtest] finished armfort team 0 at 16.88 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +0.0 bank 3483/3600, energy +118.0 bank 4212/7350, units 128
 17.02  [Playtest] finished armjamt team 0 at 17.02 min
 17.24  [Playtest] finished armdl team 0 at 17.24 min
 17.61  [Playtest] finished armfort team 0 at 17.61 min
 17.69  [Playtest] finished armfort team 0 at 17.69 min
 17.99  [Playtest] finished armjamt team 0 at 17.99 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +0.0 bank 3485/3600, energy +118.0 bank 4366/7350, units 138
 18.43  [Playtest] finished armfort team 0 at 18.43 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +0.0 bank 3498/3600, energy +150.6 bank 4548/7350, units 148
 19.09  [Playtest] finished armhlt team 0 at 19.09 min
 19.11  [Playtest] finished armfort team 0 at 19.11 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +0.0 bank 3518/3600, energy +175.5 bank 4750/7350, units 157
 20.08  [Playtest] finished armdl team 0 at 20.08 min
 20.14  [Playtest] finished armhlt team 0 at 20.14 min
 20.98  [Playtest] finished armhlt team 0 at 20.98 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +0.0 bank 3427/3600, energy +118.0 bank 4240/7350, units 164
 21.40  [Playtest] finished armfort team 0 at 21.40 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +0.0 bank 3436/3600, energy +118.0 bank 4335/7350, units 169
 22.20  [Playtest] finished armhlt team 0 at 22.20 min
 22.20  [Playtest] finished armalab team 0 at 22.20 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +0.0 bank 3681/3800, energy +118.0 bank 1241/7550, units 177
 23.82  [Playtest] finished armsolar team 0 at 23.82 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +0.0 bank 3643/3800, energy +138.0 bank 2767/7600, units 188
 24.09  [Playtest] finished armsolar team 0 at 24.09 min
 24.37  [Playtest] finished armmex team 0 at 24.37 min
 24.38  [Team][Roster] first mex 24364 at 4752,8512
 24.38  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4814|11074|0|7|1|4752|8512
 25.00  [Playtest] eco team 0 at 25.0 min: metal +2.3 bank 3665/3850, energy +158.0 bank 880/7650, units 197
```

## Native lines (all AIs, first 120)

```
  0.35  RESERVE: zone 1 at (5968, 10304) facing 2, 12x12 cells: 144 of 144 held
  0.35  RESERVE: armasy at (5968, 10304) facing 2 (id 1)
  0.35  RESERVE: corridor 2 at (5968, 9968) facing 2, 18x30 cells: 540 of 540 held
  0.35  RESERVE: zone 3 at (5880, 10680) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5880, 10680) facing 2 (id 2)
  0.35  RESERVE: zone 4 at (5832, 10680) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5832, 10680) facing 2 (id 3)
  0.35  RESERVE: zone 3 released
  0.35  RESERVE: zone 4 released
  0.35  RESERVE: zone 5 at (5880, 10600) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5880, 10600) facing 2 (id 4)
  0.35  RESERVE: zone 6 at (5832, 10600) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5832, 10600) facing 2 (id 5)
  0.35  RESERVE: zone 7 at (5784, 10600) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5784, 10600) facing 2 (id 6)
  0.35  RESERVE: zone 8 at (5736, 10600) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5736, 10600) facing 2 (id 7)
  0.35  RESERVE: zone 5 released
  0.35  RESERVE: zone 6 released
  0.35  RESERVE: zone 7 released
  0.35  RESERVE: zone 8 released
  0.35  RESERVE: zone 9 at (5880, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5880, 10520) facing 2 (id 8)
  0.35  RESERVE: zone 10 at (5832, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5832, 10520) facing 2 (id 9)
  0.35  RESERVE: zone 11 at (5784, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5784, 10520) facing 2 (id 10)
  0.35  RESERVE: zone 12 at (5736, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5736, 10520) facing 2 (id 11)
  0.35  RESERVE: zone 13 at (5688, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5688, 10520) facing 2 (id 12)
  0.35  RESERVE: zone 14 at (5880, 10472) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5880, 10472) facing 2 (id 13)
  0.35  RESERVE: zone 15 at (5832, 10472) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5832, 10472) facing 2 (id 14)
  0.35  RESERVE: zone 16 at (5784, 10472) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5784, 10472) facing 2 (id 15)
  0.35  RESERVE: zone 17 at (5736, 10472) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5736, 10472) facing 2 (id 16)
  0.35  RESERVE: zone 18 at (5688, 10472) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5688, 10472) facing 2 (id 17)
  0.35  RESERVE: zone 19 at (5880, 10424) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5880, 10424) facing 2 (id 18)
  0.35  RESERVE: zone 20 at (5832, 10424) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5832, 10424) facing 2 (id 19)
  0.35  RESERVE: zone 21 at (5784, 10424) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5784, 10424) facing 2 (id 20)
  0.35  RESERVE: zone 22 at (5736, 10424) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5736, 10424) facing 2 (id 21)
  0.35  RESERVE: zone 23 at (5688, 10424) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5688, 10424) facing 2 (id 22)
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
  0.35  RESERVE: armnanotcplat at (5928, 10472) facing 2 (id 23)
  0.35  RESERVE: zone 25 at (5880, 10472) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5880, 10472) facing 2 (id 24)
  0.35  RESERVE: zone 26 at (5832, 10472) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5832, 10472) facing 2 (id 25)
  0.35  RESERVE: zone 27 at (5784, 10472) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5784, 10472) facing 2 (id 26)
  0.35  RESERVE: zone 28 at (5736, 10472) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5736, 10472) facing 2 (id 27)
  0.35  RESERVE: zone 29 at (5928, 10424) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5928, 10424) facing 2 (id 28)
  0.35  RESERVE: zone 30 at (5880, 10424) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5880, 10424) facing 2 (id 29)
  0.35  RESERVE: zone 31 at (5832, 10424) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5832, 10424) facing 2 (id 30)
  0.35  RESERVE: zone 32 at (5784, 10424) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5784, 10424) facing 2 (id 31)
  0.35  RESERVE: zone 33 at (5736, 10424) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5736, 10424) facing 2 (id 32)
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
  0.35  RESERVE: armnanotcplat at (5864, 10920) facing 2 (id 33)
  0.35  RESERVE: zone 35 at (5816, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5816, 10920) facing 2 (id 34)
  0.35  RESERVE: zone 36 at (5768, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5768, 10920) facing 2 (id 35)
  0.35  RESERVE: zone 34 released
  0.35  RESERVE: zone 35 released
  0.35  RESERVE: zone 36 released
  0.35  RESERVE: zone 37 at (5880, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5880, 10856) facing 2 (id 36)
  0.35  RESERVE: zone 38 at (5832, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5832, 10856) facing 2 (id 37)
  0.35  RESERVE: zone 39 at (5784, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5784, 10856) facing 2 (id 38)
  0.35  RESERVE: zone 37 released
  0.35  RESERVE: zone 38 released
  0.35  RESERVE: zone 39 released
  0.35  RESERVE: zone 40 at (5928, 10792) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5928, 10792) facing 2 (id 39)
  0.35  RESERVE: zone 41 at (5880, 10792) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5880, 10792) facing 2 (id 40)
  0.35  RESERVE: zone 42 at (5832, 10792) facing 2, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (5832, 10792) facing 2 (id 41)
```
