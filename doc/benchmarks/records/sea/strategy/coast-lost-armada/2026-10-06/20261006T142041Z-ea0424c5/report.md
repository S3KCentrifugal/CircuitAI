# Playtest report: PASS

- Verdict: **PASS** (reached 14 min)
- Game time reached: 14.0 min (frame 25200); wall 119 s
- DLL: build-theatres\d216-final\SkirmishAI.dll (45eb0f2e89a285e3); AI BARbTest/test; staged 2026-10-06T11:18:39
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI None, role TECH
- Checks: coast-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T141839Z-7661879f\runs\20261006T142041Z-ea0424c5\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loss` | seen at 2.5 min | `[SEA][Coast] fallback=true body=2` |
| expect `donation` | seen at 2.0 min | `[t=00:00:48.282117][f=0003633] [CoastFixture] frame=3633 donated armck id=7957` |
| expect `lab` | seen at 4.7 min | `[t=00:01:00.320426][f=0008520] [CoastFixture] frame=8520 finished armlab x=5392 z=8608` |
| expect `metal-storage` | seen at 6.0 min | `[t=00:01:06.048721][f=0010779] [CoastFixture] frame=10779 finished armmstor x=5728 z=8704` |
| expect `energy-storage` | seen at 6.4 min | `[t=00:01:09.712163][f=0011586] [CoastFixture] frame=11586 finished armestor x=5160 z=8616` |
| expect `t1-defense` | seen at 9.7 min | `[t=00:01:24.908297][f=0017399] [CoastFixture] frame=17399 finished armhlt x=5312 z=10592` |
| expect `t2-defense` | seen at 7.6 min | `[t=00:01:15.279404][f=0013601] [CoastFixture] frame=13601 finished armpb x=5400 z=11128` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T141839Z-7661879f\runs\20261006T142041Z-ea0424c5\screen_2026-10-06_14-19-35-230.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T141839Z-7661879f\runs\20261006T142041Z-ea0424c5\screen_2026-10-06_14-19-36-229.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T141839Z-7661879f\runs\20261006T142041Z-ea0424c5\screen_2026-10-06_14-19-40-215.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T141839Z-7661879f\runs\20261006T142041Z-ea0424c5\screen_2026-10-06_14-19-44-356.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T141839Z-7661879f\runs\20261006T142041Z-ea0424c5\screen_2026-10-06_14-19-48-920.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T141839Z-7661879f\runs\20261006T142041Z-ea0424c5\screen_2026-10-06_14-19-49-923.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T141839Z-7661879f\runs\20261006T142041Z-ea0424c5\screen_2026-10-06_14-19-55-482.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T141839Z-7661879f\runs\20261006T142041Z-ea0424c5\screen_2026-10-06_14-20-00-406.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T141839Z-7661879f\runs\20261006T142041Z-ea0424c5\screen_2026-10-06_14-20-04-578.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T141839Z-7661879f\runs\20261006T142041Z-ea0424c5\screen_2026-10-06_14-20-09-215.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T141839Z-7661879f\runs\20261006T142041Z-ea0424c5\screen_2026-10-06_14-20-10-216.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T141839Z-7661879f\runs\20261006T142041Z-ea0424c5\screen_2026-10-06_14-20-14-497.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T141839Z-7661879f\runs\20261006T142041Z-ea0424c5\screen_2026-10-06_14-20-21-001.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T141839Z-7661879f\runs\20261006T142041Z-ea0424c5\screen_2026-10-06_14-20-30-567.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T141839Z-7661879f\runs\20261006T142041Z-ea0424c5\screen_2026-10-06_14-20-31-569.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-armada\supreme\20261006T141839Z-7661879f\runs\20261006T142041Z-ea0424c5\screen_2026-10-06_14-20-40-012.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 14.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 25
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 25
  0.34  [Playtest] finished armsy team 0 at 0.34 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1080/1100, energy +37.0 bank 1150/1150, units 3
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1100/1100, energy +37.0 bank 1150/1150, units 3
  3.00  [Playtest] eco team 0 at 3.0 min: metal +0.0 bank 500/500, energy +7.0 bank 550/550, units 1
  3.00  [Playtest] target team 0 at (4814, 11077) from its start position
  3.00  [Playtest] camera requested (4814,11077) height=2200
  3.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  3.01  [Playtest] screenshot at 3.0 min of team 0 at (4814, 11077)
  4.00  [Playtest] eco team 0 at 4.0 min: metal +0.0 bank 468/500, energy +7.0 bank 517/550, units 2
  4.73  [Playtest] finished armlab team 0 at 4.73 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +0.0 bank 562/600, energy +7.0 bank 402/650, units 4
  5.45  [Playtest] finished armsolar team 0 at 5.45 min
  5.99  [Playtest] finished armmstor team 0 at 5.99 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +0.0 bank 502/3600, energy +55.0 bank 641/900, units 11
  6.00  [Playtest] camera requested (4814,11077) height=2200
  6.00  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  6.00  [Playtest] screenshot at 6.0 min of team 0 at (4814, 11077)
  6.32  [Playtest] finished armsolar team 0 at 6.32 min
  6.44  [Playtest] finished armestor team 0 at 6.44 min
  6.76  [Playtest] finished armsolar team 0 at 6.76 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +0.0 bank 3507/3600, energy +95.0 bank 6306/7000, units 18
  7.01  [Playtest] finished armsolar team 0 at 7.01 min
  7.56  [Playtest] finished armpb team 0 at 7.56 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +0.0 bank 3539/3600, energy +115.0 bank 6885/7050, units 24
  9.00  [Playtest] eco team 0 at 9.0 min: metal +0.0 bank 3489/3600, energy +115.0 bank 5976/7050, units 30
  9.43  [Playtest] finished armpb team 0 at 9.43 min
  9.67  [Playtest] finished armhlt team 0 at 9.67 min
  9.76  [Playtest] finished armhlt team 0 at 9.76 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +0.0 bank 3552/3600, energy +115.0 bank 6953/7050, units 34
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 10.51  [Playtest] finished armhlt team 0 at 10.51 min
 10.87  [Playtest] finished armsolar team 0 at 10.87 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +0.0 bank 3526/3600, energy +166.6 bank 6505/7100, units 40
 11.65  [Playtest] finished armsolar team 0 at 11.65 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +0.0 bank 3495/3600, energy +155.0 bank 6436/7150, units 47
 12.08  [Playtest] finished armpb team 0 at 12.08 min
 12.43  [Playtest] finished armsolar team 0 at 12.43 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +0.0 bank 3502/3600, energy +175.0 bank 6370/7200, units 51
 13.00  [Playtest] camera requested (4814,11077) height=2200
 13.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 13.01  [Playtest] screenshot at 13.0 min of team 0 at (4814, 11077)
 13.47  [Playtest] finished armhlt team 0 at 13.47 min
 13.64  [Playtest] finished armpb team 0 at 13.64 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +0.0 bank 3552/3600, energy +175.0 bank 7160/7200, units 55
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
