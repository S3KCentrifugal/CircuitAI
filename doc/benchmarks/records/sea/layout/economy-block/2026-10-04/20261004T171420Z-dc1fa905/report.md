# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 12.0 min (frame 21600); wall 96 s
- DLL: build-theatres\d191-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T14:12:41
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: economy-block.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T171240Z-492b97bf\runs\20261004T171420Z-dc1fa905\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `t1` | seen at 8.3 min | `[t=00:01:18.760088][f=0015000] [SeaBlock] PASS packed armfmkr count=12 edges=14` |
| expect `t2` | seen at 4.6 min | `[t=00:01:02.635290][f=0008340] [SeaBlock] PASS packed armuwmmm count=8 edges=4` |
| expect `shipyard` | seen at 7.1 min | `[t=00:01:13.812870][f=0012780] [SeaBlock] PASS factory assist armsy` |
| expect `amphibious` | seen at 7.0 min | `[t=00:01:13.545978][f=0012660] [SeaBlock] PASS factory assist armamsub` |
| expect `fusion-support` | seen at 1.9 min | `[t=00:00:50.448516][f=0003330] [SeaBlock] PASS fusion assist` |
| expect `rear-fusion` | seen at 5.1 min | `[t=00:01:04.441016][f=0009150] [SeaBlock] PASS rear fusion completed` |
| expect `square` | seen at 4.3 min | `[t=00:01:01.437353][f=0007800] [SeaBlock] PASS square turret grid count=5 columns=4 rows=2` |
| forbid `errors` | **hit** | `[t=00:00:45.079494][f=0001122] [SeaBlock] FAIL T1 converter removed in uncontested block` |

## Failures

- forbid 'errors' hit at 0.6 min: [t=00:00:45.079494][f=0001122] [SeaBlock] FAIL T1 converter removed in uncontested block
- forbid 'errors' hit at 2.2 min: [t=00:00:52.010977][f=0004019] [SeaBlock] FAIL T1 converter removed in uncontested block

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T171240Z-492b97bf\runs\20261004T171420Z-dc1fa905\screen_2026-10-04_17-13-41-411.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T171240Z-492b97bf\runs\20261004T171420Z-dc1fa905\screen_2026-10-04_17-13-49-734.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T171240Z-492b97bf\runs\20261004T171420Z-dc1fa905\screen_2026-10-04_17-13-54-400.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T171240Z-492b97bf\runs\20261004T171420Z-dc1fa905\screen_2026-10-04_17-13-54-822.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T171240Z-492b97bf\runs\20261004T171420Z-dc1fa905\screen_2026-10-04_17-14-15-716.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 3 shots, end at 12.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 44
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 44
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.17  [Playtest] finished armsy team 0 at 0.17 min
  0.18  [Playtest] finished armamsub team 0 at 0.18 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +5.6 bank 99112/100100, energy +178.0 bank 985894/1001050, units 22
  1.60  [Playtest] finished armnanotcplat team 0 at 1.60 min
  1.71  [Playtest] finished armuwmmm team 0 at 1.71 min
  1.84  [Playtest] finished armnanotcplat team 0 at 1.84 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +12.3 bank 97018/100100, energy +178.0 bank 926986/1001050, units 26
  2.48  [Playtest] finished armuwmmm team 0 at 2.48 min
  2.84  [Playtest] finished armuwmmm team 0 at 2.84 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +33.8 bank 95144/100100, energy +178.0 bank 799351/1001050, units 27
  3.00  [Playtest] camera requested (6200,11000) height=2200
  3.00  [Playtest] camera captured name=ta position=(6200,11000) height=2200
  3.00  [Playtest] screenshot at 3.0 min of team 0 at (6200, 11000)
  3.24  [Playtest] finished armuwmmm team 0 at 3.24 min
  3.31  [Playtest] finished armuwmmm team 0 at 3.31 min
  3.88  [Playtest] finished armnanotcplat team 0 at 3.88 min
  3.89  [Playtest] finished armuwmmm team 0 at 3.89 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 92627/100100, energy +178.0 bank 705395/1001050, units 29
  4.19  [Playtest] finished armuwmmm team 0 at 4.19 min
  4.32  [Playtest] finished armnanotcplat team 0 at 4.32 min
  4.32  [Playtest] finished armnanotcplat team 0 at 4.32 min
  4.62  [Playtest] finished armuwmmm team 0 at 4.62 min
  4.71  [Playtest] finished armnanotcplat team 0 at 4.71 min
  4.73  [Playtest] finished armnanotcplat team 0 at 4.73 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 88159/100100, energy +178.0 bank 653243/1001050, units 36
  5.08  [Playtest] finished armuwfus team 0 at 5.08 min
  5.13  [Playtest] finished armnanotcplat team 0 at 5.13 min
  5.17  [Playtest] finished armnanotcplat team 0 at 5.17 min
  5.19  [Playtest] finished armnanotcplat team 0 at 5.19 min
  5.35  [Playtest] finished armfmkr team 0 at 5.35 min
  5.44  [Playtest] finished armfmkr team 0 at 5.44 min
  5.60  [Playtest] finished armfmkr team 0 at 5.60 min
  5.66  [Playtest] finished armfmkr team 0 at 5.66 min
  5.88  [Playtest] finished armfmkr team 0 at 5.88 min
  5.94  [Playtest] finished armfmkr team 0 at 5.94 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 87013/100100, energy +1378.0 bank 710624/1003550, units 42
  6.00  [Playtest] camera requested (6200,11000) height=2200
  6.00  [Playtest] camera captured name=ta position=(6200,11000) height=2200
  6.00  [Playtest] screenshot at 6.0 min of team 0 at (6200, 11000)
  6.03  [Playtest] finished armfmkr team 0 at 6.03 min
  6.10  [Playtest] finished armfmkr team 0 at 6.10 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +15.2 bank 85070/100100, energy +1378.0 bank 753045/1003550, units 50
  7.01  [Playtest] finished armnanotcplat team 0 at 7.01 min
  7.04  [Playtest] finished armnanotcplat team 0 at 7.03 min
  7.05  [Playtest] finished armnanotcplat team 0 at 7.05 min
  7.08  [Playtest] finished armnanotcplat team 0 at 7.08 min
  7.38  [Playtest] finished armnanotcplat team 0 at 7.38 min
  7.53  [Playtest] finished armnanotcplat team 0 at 7.53 min
  7.63  [Playtest] finished armnanotcplat team 0 at 7.63 min
  7.70  [Playtest] finished armnanotcplat team 0 at 7.70 min
  7.75  [Playtest] finished armnanotcplat team 0 at 7.75 min
  7.80  [Playtest] finished armnanotcplat team 0 at 7.80 min
  7.84  [Playtest] finished armnanotcplat team 0 at 7.84 min
  7.99  [Playtest] finished armfmkr team 0 at 7.99 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +18.3 bank 81101/100100, energy +1378.0 bank 751542/1003550, units 61
  8.04  [Playtest] finished armfmkr team 0 at 8.04 min
  8.31  [Playtest] finished armfmkr team 0 at 8.31 min
  8.33  [Playtest] finished armfmkr team 0 at 8.33 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +25.8 bank 80723/100100, energy +1378.0 bank 753351/1003550, units 65
 10.00  [Playtest] eco team 0 at 10.0 min: metal +25.8 bank 82268/100100, energy +1378.0 bank 753351/1003550, units 65
 11.00  [Playtest] eco team 0 at 11.0 min: metal +25.8 bank 83813/100100, energy +1378.0 bank 753351/1003550, units 65
 11.00  [Playtest] camera requested (6200,11000) height=2200
 11.01  [Playtest] camera captured name=ta position=(6200,11000) height=2200
 11.01  [Playtest] screenshot at 11.0 min of team 0 at (6200, 11000)
 12.00  [Playtest] eco team 0 at 12.0 min: metal +25.8 bank 85358/100100, energy +1378.0 bank 753351/1003550, units 65
```

## Native lines (all AIs, first 120)

```
  0.18  RESERVE: zone 1 at (5832, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5832, 10568) facing 2 (id 1)
  0.18  RESERVE: zone 2 at (5784, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5784, 10568) facing 2 (id 2)
  0.18  RESERVE: zone 3 at (5736, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5736, 10568) facing 2 (id 3)
  0.18  RESERVE: zone 4 at (5688, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5688, 10568) facing 2 (id 4)
  0.18  RESERVE: zone 5 at (5640, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5640, 10568) facing 2 (id 5)
  0.18  RESERVE: zone 6 at (5832, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5832, 10520) facing 2 (id 6)
  0.18  RESERVE: zone 7 at (5784, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5784, 10520) facing 2 (id 7)
  0.18  RESERVE: zone 8 at (5736, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5736, 10520) facing 2 (id 8)
  0.18  RESERVE: corridor 9 at (5824, 11024) facing 0, 12x30 cells: 192 of 360 held
  0.18  RESERVE: corridor 10 at (6600, 11028) facing 0, 13x31 cells: 273 of 403 held
  0.18  RESERVE: zone 11 at (5952, 11520) facing 2, 40x40 cells: 1552 of 1600 held
  0.18  RESERVE: zone 11 released
  0.18  RESERVE: zone 12 at (6080, 11520) facing 2, 40x40 cells: 1560 of 1600 held
  0.18  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6080, 11424) facing 2: 2 of 16 slots (group 2, held, zone)
  0.18  RESERVE: zone 12 released
  0.18  RESERVE: zone 13 at (6208, 11520) facing 2, 40x40 cells: 1582 of 1600 held
  0.18  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6208, 11424) facing 2: 8 of 16 slots (group 3, held, zone)
  0.18  RESERVE: zone 13 released
  0.20  RESERVE: zone 14 at (6336, 11520) facing 2, 40x40 cells: 1550 of 1600 held
  0.20  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6336, 11424) facing 2: 14 of 16 slots (group 4, held, zone)
  0.20  RESERVE: zone 14 released
  0.20  RESERVE: zone 15 at (6464, 11520) facing 2, 40x40 cells: 1535 of 1600 held
  0.20  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6464, 11424) facing 2: 16 of 16 slots (group 5, held, zone)
  0.20  RESERVE: armuwfus at (6480, 11392) facing 2 (id 49)
  0.20  RESERVE: packed armuwfus at (6480, 11392) facing 2 in zone 15, 313 from a turret (id 49, group 0, 950 candidates)
  0.20  RESERVE: set of 4 armfmkr from (6584, 11544), 0 cell(s) from a turret, growing (3, 0) cells a step (group 6, id 50)
  0.21  RESERVE: served armfmkr at (6584, 11544) facing 2 (id 50, 3 of this def still held)
  0.22  RESERVE: zone 16 at (6888, 10536) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6888, 10536) facing 2 (id 54)
  0.22  RESERVE: zone 17 at (6840, 10536) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6840, 10536) facing 2 (id 55)
  0.22  RESERVE: zone 18 at (6792, 10536) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6792, 10536) facing 2 (id 56)
  0.22  RESERVE: zone 19 at (6744, 10536) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6744, 10536) facing 2 (id 57)
  0.22  RESERVE: zone 20 at (6696, 10536) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6696, 10536) facing 2 (id 58)
  0.22  RESERVE: zone 21 at (6888, 10488) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6888, 10488) facing 2 (id 59)
  0.22  RESERVE: zone 22 at (6840, 10488) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6840, 10488) facing 2 (id 60)
  0.22  RESERVE: zone 16 released
  0.22  RESERVE: zone 17 released
  0.22  RESERVE: zone 18 released
  0.22  RESERVE: zone 19 released
  0.22  RESERVE: zone 20 released
  0.22  RESERVE: zone 21 released
  0.22  RESERVE: zone 22 released
  0.22  RESERVE: zone 23 at (6872, 10616) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6872, 10616) facing 2 (id 61)
  0.22  RESERVE: zone 24 at (6824, 10616) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6824, 10616) facing 2 (id 62)
  0.22  RESERVE: zone 25 at (6776, 10616) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6776, 10616) facing 2 (id 63)
  0.22  RESERVE: zone 26 at (6728, 10616) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6728, 10616) facing 2 (id 64)
  0.22  RESERVE: zone 27 at (6680, 10616) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6680, 10616) facing 2 (id 65)
  0.22  RESERVE: zone 28 at (6872, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6872, 10568) facing 2 (id 66)
  0.22  RESERVE: zone 29 at (6824, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6824, 10568) facing 2 (id 67)
  0.22  RESERVE: zone 30 at (6776, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6776, 10568) facing 2 (id 68)
  0.22  RESERVE: zone 31 at (6592, 11520) facing 2, 40x40 cells: 320 of 1600 held
  0.22  RESERVE: zone 31 released
  0.23  RESERVE: served armnanotcplat at (6488, 11448) facing 2 (id 34, 31 of this def still held)
  0.23  RESERVE: set of 2 armuwmmm from (6568, 11392), 0 cell(s) from a turret, growing (0, -4) cells a step (group 8, id 69)
  0.23  RESERVE: served armnanotcplat at (6440, 11448) facing 2 (id 35, 30 of this def still held)
  0.23  RESERVE: served armuwmmm at (6568, 11392) facing 2 (id 69, 1 of this def still held)
  0.24  RESERVE: served armfmkr at (6632, 11544) facing 2 (id 51, 2 of this def still held)
  0.25  RESERVE: served armuwmmm at (6568, 11328) facing 2 (id 70, 0 of this def still held)
  0.25  RESERVE: served armuwfus at (6480, 11392) facing 2 (id 49, 0 of this def still held)
  0.41  RESERVE: set of 2 armuwmmm from (6392, 11392), 0 cell(s) from a turret, growing (0, -4) cells a step (group 9, id 71)
  0.41  RESERVE: served armuwmmm at (6392, 11392) facing 2 (id 71, 1 of this def still held)
  0.62  RESERVE: armfmkr at (6584, 11544) lost; slot restored (id 50)
  0.64  RESERVE: served armnanotcplat at (6536, 11448) facing 2 (id 33, 29 of this def still held)
  0.67  RESERVE: served armuwmmm at (6392, 11328) facing 2 (id 72, 0 of this def still held)
  0.69  RESERVE: set of 2 armuwmmm from (6600, 11456), 0 cell(s) from a turret, growing (5, 0) cells a step (group 10, id 73)
  0.70  RESERVE: served armuwmmm at (6600, 11456) facing 2 (id 73, 1 of this def still held)
  0.84  RESERVE: served armuwmmm at (6680, 11456) facing 2 (id 74, 0 of this def still held)
  0.95  RESERVE: armnanotcplat at (6440, 11448) lost; slot restored (id 35)
  1.07  RESERVE: set of 2 armuwmmm from (6328, 11456), 0 cell(s) from a turret, growing (-5, 0) cells a step (group 11, id 75)
  1.07  RESERVE: served armuwmmm at (6328, 11456) facing 2 (id 75, 1 of this def still held)
  1.11  RESERVE: served armuwmmm at (6248, 11456) facing 2 (id 76, 0 of this def still held)
  1.54  RESERVE: armuwmmm at (6568, 11392) lost; slot restored (id 69)
  1.60  RESERVE: served armuwmmm at (6568, 11392) facing 2 (id 69, 0 of this def still held)
  1.70  RESERVE: armuwmmm at (6600, 11456) lost; slot restored (id 73)
  1.73  RESERVE: served armuwmmm at (6600, 11456) facing 2 (id 73, 0 of this def still held)
  1.81  RESERVE: armuwmmm at (6680, 11456) lost; slot restored (id 74)
  1.93  RESERVE: armuwmmm at (6328, 11456) lost; slot restored (id 75)
  1.96  RESERVE: served armuwmmm at (6680, 11456) facing 2 (id 74, 1 of this def still held)
  2.06  RESERVE: served armuwmmm at (6328, 11456) facing 2 (id 75, 0 of this def still held)
  2.23  RESERVE: armfmkr at (6632, 11544) lost; slot restored (id 51)
  2.93  RESERVE: armuwmmm at (6328, 11456) lost; slot restored (id 75)
  3.08  RESERVE: armuwmmm at (6248, 11456) lost; slot restored (id 76)
  3.27  RESERVE: served armnanotcplat at (6440, 11448) facing 2 (id 35, 29 of this def still held)
  3.27  RESERVE: served armuwmmm at (6328, 11456) facing 2 (id 75, 1 of this def still held)
  3.33  RESERVE: served armuwmmm at (6248, 11456) facing 2 (id 76, 0 of this def still held)
  3.34  RESERVE: served armnanotcplat at (6392, 11448) facing 2 (id 36, 28 of this def still held)
  3.92  RESERVE: served armnanotcplat at (6488, 11496) facing 2 (id 38, 27 of this def still held)
  4.34  RESERVE: served armnanotcplat at (6440, 11496) facing 2 (id 39, 26 of this def still held)
  4.36  RESERVE: served armnanotcplat at (6536, 11496) facing 2 (id 37, 25 of this def still held)
  4.65  RESERVE: served armnanotcplat at (6392, 11496) facing 2 (id 40, 24 of this def still held)
  4.74  RESERVE: served armnanotcplat at (6488, 11544) facing 2 (id 42, 23 of this def still held)
  4.76  RESERVE: served armnanotcplat at (6440, 11544) facing 2 (id 43, 22 of this def still held)
  5.06  RESERVE: armnanotcplat at (6488, 11544) lost; slot restored (id 42)
  5.08  RESERVE: served armnanotcplat at (6488, 11544) facing 2 (id 42, 22 of this def still held)
  5.11  RESERVE: served armfmkr at (6584, 11544) facing 2 (id 50, 3 of this def still held)
  5.16  RESERVE: served armfmkr at (6632, 11544) facing 2 (id 51, 2 of this def still held)
  5.36  RESERVE: served armfmkr at (6680, 11544) facing 2 (id 52, 1 of this def still held)
  5.45  RESERVE: served armfmkr at (6728, 11544) facing 2 (id 53, 0 of this def still held)
```
