# Playtest report: PASS

- Verdict: **PASS** (reached 25 min)
- Game time reached: 25.0 min (frame 45089); wall 323 s
- DLL: build-theatres\d216-final\SkirmishAI.dll (45eb0f2e89a285e3); AI BARbTest/test; staged 2026-10-06T11:59:25
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: coast-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T145925Z-f060a592\runs\20261006T150451Z-59d7d108\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loss` | seen at 2.5 min | `[SEA][Coast] fallback=true body=2` |
| expect `donation` | seen at 2.0 min | `[t=00:00:48.110347][f=0003630] [CoastFixture] frame=3630 donated armck id=24571` |
| expect `lab` | seen at 4.7 min | `[t=00:01:01.726746][f=0008533] [CoastFixture] frame=8533 finished armlab x=5392 z=8608` |
| expect `metal-storage` | seen at 6.0 min | `[t=00:01:08.184614][f=0010797] [CoastFixture] frame=10797 finished armmstor x=5728 z=8704` |
| expect `energy-storage` | seen at 6.5 min | `[t=00:01:11.818076][f=0011767] [CoastFixture] frame=11767 finished armestor x=5160 z=8616` |
| expect `t1-defense` | seen at 7.7 min | `[t=00:01:28.804240][f=0013942] [CoastFixture] frame=13942 finished armhlt x=5936 z=8944` |
| expect `t2-defense` | seen at 7.3 min | `[t=00:01:21.691757][f=0013226] [CoastFixture] frame=13226 finished armpb x=5336 z=10024` |
| expect `radar` | seen at 8.6 min | `[t=00:01:37.453889][f=0015450] [CoastFixture] frame=15450 finished armrad x=5232 z=11184` |
| expect `sonar-defense` | seen at 9.8 min | `[t=00:01:58.293777][f=0017550] [CoastFixture] frame=17550 finished armdl x=5584 z=11088` |
| expect `jammer` | seen at 10.7 min | `[t=00:02:11.398756][f=0019205] [CoastFixture] frame=19205 finished armjamt x=5264 z=11168` |
| expect `fortification` | seen at 12.6 min | `[t=00:02:32.323362][f=0022758] [CoastFixture] frame=22758 finished armfort x=5408 z=10432` |
| expect `medium-mine` | seen at 15.8 min | `[t=00:03:01.493390][f=0028438] [CoastFixture] frame=28438 finished armmine2 x=5576 z=11288` |
| expect `amphibious-response` | seen at 15.1 min | `[t=00:02:55.202948][f=0027150] [CoastFixture] frame=27150 invader damaged by live defense` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T145925Z-f060a592\runs\20261006T150451Z-59d7d108\screen_2026-10-06_15-00-21-861.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T145925Z-f060a592\runs\20261006T150451Z-59d7d108\screen_2026-10-06_15-00-22-466.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T145925Z-f060a592\runs\20261006T150451Z-59d7d108\screen_2026-10-06_15-00-27-457.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T145925Z-f060a592\runs\20261006T150451Z-59d7d108\screen_2026-10-06_15-00-32-547.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T145925Z-f060a592\runs\20261006T150451Z-59d7d108\screen_2026-10-06_15-00-37-815.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T145925Z-f060a592\runs\20261006T150451Z-59d7d108\screen_2026-10-06_15-00-38-400.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T145925Z-f060a592\runs\20261006T150451Z-59d7d108\screen_2026-10-06_15-00-45-551.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T145925Z-f060a592\runs\20261006T150451Z-59d7d108\screen_2026-10-06_15-01-01-569.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T145925Z-f060a592\runs\20261006T150451Z-59d7d108\screen_2026-10-06_15-01-13-584.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T145925Z-f060a592\runs\20261006T150451Z-59d7d108\screen_2026-10-06_15-01-31-637.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T145925Z-f060a592\runs\20261006T150451Z-59d7d108\screen_2026-10-06_15-01-32-218.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T145925Z-f060a592\runs\20261006T150451Z-59d7d108\screen_2026-10-06_15-01-44-603.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T145925Z-f060a592\runs\20261006T150451Z-59d7d108\screen_2026-10-06_15-01-55-721.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T145925Z-f060a592\runs\20261006T150451Z-59d7d108\screen_2026-10-06_15-02-05-253.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T145925Z-f060a592\runs\20261006T150451Z-59d7d108\screen_2026-10-06_15-02-05-552.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T145925Z-f060a592\runs\20261006T150451Z-59d7d108\screen_2026-10-06_15-02-14-701.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T145925Z-f060a592\runs\20261006T150451Z-59d7d108\screen_2026-10-06_15-02-23-195.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T145925Z-f060a592\runs\20261006T150451Z-59d7d108\screen_2026-10-06_15-02-33-386.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T145925Z-f060a592\runs\20261006T150451Z-59d7d108\screen_2026-10-06_15-02-48-272.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T145925Z-f060a592\runs\20261006T150451Z-59d7d108\screen_2026-10-06_15-03-02-197.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T145925Z-f060a592\runs\20261006T150451Z-59d7d108\screen_2026-10-06_15-03-16-404.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T145925Z-f060a592\runs\20261006T150451Z-59d7d108\screen_2026-10-06_15-03-32-257.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T145925Z-f060a592\runs\20261006T150451Z-59d7d108\screen_2026-10-06_15-03-46-744.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T145925Z-f060a592\runs\20261006T150451Z-59d7d108\screen_2026-10-06_15-04-02-403.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T145925Z-f060a592\runs\20261006T150451Z-59d7d108\screen_2026-10-06_15-04-17-757.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T145925Z-f060a592\runs\20261006T150451Z-59d7d108\screen_2026-10-06_15-04-33-390.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T145925Z-f060a592\runs\20261006T150451Z-59d7d108\screen_2026-10-06_15-04-49-464.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 25.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 32
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 32
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.33  [Playtest] finished armsy team 0 at 0.33 min
  0.35  [SEA][Layout] berth sea.berth.0 armasy at=5968,10304 facing=2
  0.42  [SEA][Layout] berth sea.berth.1 armplat at=5776,10512 facing=2
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1079/1100, energy +37.0 bank 1150/1150, units 3
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1100/1100, energy +37.0 bank 1150/1150, units 3
  2.10  [SEA][Layout] berth sea.berth.2 armsy at=6160,10304 facing=2
  3.00  [Playtest] eco team 0 at 3.0 min: metal +0.0 bank 500/500, energy +7.0 bank 550/550, units 1
  3.00  [Playtest] target team 0 at (4814, 11077) from its start position
  3.00  [Playtest] camera requested (4814,11077) height=2200
  3.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  3.01  [Playtest] screenshot at 3.0 min of team 0 at (4814, 11077)
  4.00  [Playtest] eco team 0 at 4.0 min: metal +0.0 bank 468/500, energy +7.0 bank 517/550, units 2
  4.74  [Playtest] finished armlab team 0 at 4.74 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +0.0 bank 581/600, energy +7.0 bank 402/650, units 3
  6.00  [Playtest] finished armmstor team 0 at 6.00 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +0.0 bank 479/3600, energy +84.0 bank 0/1200, units 15
  6.00  [Playtest] camera requested (4814,11077) height=2200
  6.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  6.01  [Playtest] screenshot at 6.0 min of team 0 at (4814, 11077)
  6.54  [Playtest] finished armestor team 0 at 6.54 min
  6.98  [Playtest] finished armsolar team 0 at 6.98 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +0.0 bank 3370/3600, energy +91.0 bank 3924/7300, units 21
  7.28  [Playtest] finished armsolar team 0 at 7.28 min
  7.35  [Playtest] finished armpb team 0 at 7.35 min
  7.47  [Playtest] finished armnanotc team 0 at 7.47 min
  7.51  [Playtest] finished armpb team 0 at 7.51 min
  7.67  [Playtest] finished armpb team 0 at 7.67 min
  7.75  [Playtest] finished armhlt team 0 at 7.75 min
  7.84  [Playtest] finished armpb team 0 at 7.84 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +0.0 bank 3539/3600, energy +188.5 bank 7430/7500, units 27
  8.58  [Playtest] finished armrad team 0 at 8.58 min
  8.72  [Playtest] finished armmex team 0 at 8.72 min
  8.72  [Team][Roster] first mex 2589 at 5216,8400
  8.72  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4814|11074|0|7|1|5216|8400
  9.00  [Playtest] eco team 0 at 9.0 min: metal +2.3 bank 3441/3650, energy +152.0 bank 3911/7500, units 40
  9.19  [Playtest] finished armpb team 0 at 9.19 min
  9.36  [Playtest] finished armpb team 0 at 9.36 min
  9.75  [Playtest] finished armdl team 0 at 9.75 min
  9.84  [Playtest] finished armpb team 0 at 9.84 min
  9.99  [Playtest] finished armdl team 0 at 9.99 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +2.3 bank 3452/3650, energy +152.0 bank 5106/7500, units 50
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.02  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 10.44  [Playtest] finished armrad team 0 at 10.44 min
 10.53  [Playtest] finished armdl team 0 at 10.53 min
 10.67  [Playtest] finished armjamt team 0 at 10.67 min
 10.79  [Playtest] finished armpb team 0 at 10.79 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +2.3 bank 3405/3650, energy +152.0 bank 4192/7500, units 59
 11.24  [Playtest] finished armrad team 0 at 11.24 min
 11.29  [Playtest] finished armpb team 0 at 11.29 min
 11.31  [Playtest] finished armpb team 0 at 11.31 min
 11.35  [Playtest] finished armdl team 0 at 11.35 min
 11.42  [Playtest] finished armalab team 0 at 11.42 min
 11.45  [Playtest] finished armjamt team 0 at 11.45 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +2.3 bank 3606/3850, energy +152.0 bank 1881/7700, units 73
 12.61  [Playtest] finished armjamt team 0 at 12.61 min
 12.64  [Playtest] finished armfort team 0 at 12.64 min
 12.74  [Playtest] finished armdl team 0 at 12.74 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +2.3 bank 3581/3850, energy +170.8 bank 57/7700, units 85
 13.00  [Playtest] camera requested (4814,11077) height=2200
 13.02  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 13.02  [Playtest] screenshot at 13.0 min of team 0 at (4814, 11077)
 13.08  [Playtest] finished armrad team 0 at 13.08 min
 13.13  [Playtest] finished armdl team 0 at 13.13 min
 13.21  [Playtest] finished armfort team 0 at 13.22 min
 13.33  [Playtest] finished armpb team 0 at 13.33 min
 13.66  [Playtest] finished armfort team 0 at 13.66 min
 13.70  [Playtest] finished armdl team 0 at 13.70 min
 13.78  [Playtest] finished armjamt team 0 at 13.78 min
 13.93  [Playtest] finished armfort team 0 at 13.93 min
 13.96  [Playtest] finished armjamt team 0 at 13.96 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +2.3 bank 3661/3850, energy +152.0 bank 1371/7700, units 99
 14.03  [Playtest] finished armrad team 0 at 14.03 min
 14.10  [Playtest] finished armpb team 0 at 14.10 min
 14.15  [Playtest] finished armsolar team 0 at 14.15 min
 14.99  [Playtest] finished armsolar team 0 at 14.99 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +2.3 bank 3652/3850, energy +172.0 bank 2794/7800, units 113
 15.13  [Playtest] finished armfort team 0 at 15.13 min
 15.20  [Playtest] finished armfort team 0 at 15.20 min
 15.26  [Playtest] finished armdl team 0 at 15.26 min
 15.46  [Playtest] finished armfort team 0 at 15.46 min
 15.79  [Playtest] finished armdl team 0 at 15.79 min
 15.80  [Playtest] finished armmine2 team 0 at 15.80 min
 15.88  [Playtest] finished armjamt team 0 at 15.88 min
 15.94  [Playtest] finished armrad team 0 at 15.94 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +2.3 bank 3694/3850, energy +178.0 bank 3324/7700, units 128
 16.10  [Playtest] finished armfort team 0 at 16.10 min
 16.96  [Playtest] finished armjamt team 0 at 16.96 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +2.3 bank 3655/3850, energy +178.0 bank 1016/7700, units 142
 17.13  [Playtest] finished armfort team 0 at 17.13 min
 17.88  [Playtest] finished armdl team 0 at 17.88 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +2.3 bank 3709/3850, energy +235.5 bank 3364/7700, units 152
 18.31  [Playtest] finished armjamt team 0 at 18.31 min
 18.32  [Playtest] finished armhlt team 0 at 18.32 min
 18.38  [Playtest] finished armfort team 0 at 18.38 min
 18.89  [Playtest] finished armsolar team 0 at 18.89 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +2.3 bank 3663/3850, energy +198.0 bank 2889/7750, units 164
 19.36  [Playtest] finished armhlt team 0 at 19.36 min
 19.60  [Playtest] finished armmex team 0 at 19.60 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +4.3 bank 3739/3900, energy +198.0 bank 2398/7750, units 175
 20.86  [Playtest] finished armfort team 0 at 20.86 min
 20.91  [Playtest] finished armhlt team 0 at 20.91 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +4.3 bank 3745/3900, energy +198.0 bank 4217/7750, units 185
 22.00  [Playtest] eco team 0 at 22.0 min: metal +4.3 bank 3777/3900, energy +198.0 bank 4280/7750, units 196
 23.00  [Playtest] eco team 0 at 23.0 min: metal +4.3 bank 3737/3900, energy +198.0 bank 3470/7750, units 205
 24.00  [Playtest] eco team 0 at 24.0 min: metal +4.3 bank 3778/3900, energy +198.0 bank 4392/7750, units 215
 25.00  [Playtest] eco team 0 at 25.0 min: metal +4.3 bank 3766/3900, energy +198.0 bank 3515/7750, units 225
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
