# Playtest report: PASS

- Verdict: **PASS** (reached 12 min)
- Game time reached: 12.0 min (frame 21600); wall 122 s
- DLL: build-theatres\d191-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T14:16:11
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: economy-block.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T171611Z-1a576cf1\runs\20261004T171817Z-9ae5216e\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `t1` | seen at 5.9 min | `[t=00:01:32.903453][f=0010680] [SeaBlock] PASS packed armfmkr count=12 edges=12` |
| expect `t2` | seen at 4.5 min | `[t=00:01:27.173596][f=0008100] [SeaBlock] PASS packed armuwmmm count=8 edges=4` |
| expect `shipyard` | seen at 3.6 min | `[t=00:01:23.638229][f=0006510] [SeaBlock] PASS factory assist armsy` |
| expect `amphibious` | seen at 3.9 min | `[t=00:01:24.570245][f=0006930] [SeaBlock] PASS factory assist armamsub` |
| expect `fusion-support` | seen at 3.6 min | `[t=00:01:23.501837][f=0006450] [SeaBlock] PASS fusion assist` |
| expect `rear-fusion` | seen at 5.0 min | `[t=00:01:29.374137][f=0009090] [SeaBlock] PASS rear fusion completed` |
| expect `square` | seen at 4.8 min | `[t=00:01:28.508823][f=0008700] [SeaBlock] PASS square turret grid count=4 columns=3 rows=2` |
| forbid `errors` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T171611Z-1a576cf1\runs\20261004T171817Z-9ae5216e\screen_2026-10-04_17-17-37-834.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T171611Z-1a576cf1\runs\20261004T171817Z-9ae5216e\screen_2026-10-04_17-17-46-021.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T171611Z-1a576cf1\runs\20261004T171817Z-9ae5216e\screen_2026-10-04_17-17-50-818.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T171611Z-1a576cf1\runs\20261004T171817Z-9ae5216e\screen_2026-10-04_17-17-51-223.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T171611Z-1a576cf1\runs\20261004T171817Z-9ae5216e\screen_2026-10-04_17-18-12-180.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 3 shots, end at 12.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 31
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 31
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.17  [Playtest] finished armsy team 0 at 0.17 min
  0.18  [Playtest] finished armamsub team 0 at 0.18 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.4 bank 99218/100100, energy +178.0 bank 984903/1001050, units 22
  1.21  [Playtest] finished armfmkr team 0 at 1.21 min
  1.24  [Playtest] finished armnanotcplat team 0 at 1.24 min
  1.27  [Playtest] finished armfmkr team 0 at 1.27 min
  1.90  [Playtest] finished armuwmmm team 0 at 1.90 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +14.3 bank 96900/100100, energy +178.0 bank 906267/1001050, units 24
  2.11  [Playtest] finished armuwmmm team 0 at 2.11 min
  2.31  [Playtest] finished armuwmmm team 0 at 2.31 min
  2.55  [Playtest] finished armuwmmm team 0 at 2.55 min
  2.72  [Playtest] finished armuwmmm team 0 at 2.72 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.4 bank 96386/100100, energy +178.0 bank 746512/1001050, units 31
  3.00  [Playtest] camera requested (6200,11000) height=2200
  3.01  [Playtest] camera captured name=ta position=(6200,11000) height=2200
  3.01  [Playtest] screenshot at 3.0 min of team 0 at (6200, 11000)
  3.08  [Playtest] finished armnanotcplat team 0 at 3.08 min
  3.57  [Playtest] finished armuwmmm team 0 at 3.57 min
  3.60  [Playtest] finished armnanotcplat team 0 at 3.60 min
  3.63  [Playtest] finished armnanotcplat team 0 at 3.63 min
  3.83  [Playtest] finished armnanotcplat team 0 at 3.83 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 92393/100100, energy +178.0 bank 679403/1001050, units 33
  4.15  [Playtest] finished armuwmmm team 0 at 4.15 min
  4.49  [Playtest] finished armuwmmm team 0 at 4.49 min
  4.69  [Playtest] finished armnanotcplat team 0 at 4.69 min
  4.83  [Playtest] finished armnanotcplat team 0 at 4.83 min
  4.93  [Playtest] finished armnanotcplat team 0 at 4.93 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 87544/100100, energy +178.0 bank 637758/1001050, units 38
  5.01  [Playtest] finished armnanotcplat team 0 at 5.01 min
  5.04  [Playtest] finished armuwfus team 0 at 5.04 min
  5.09  [Playtest] finished armnanotcplat team 0 at 5.09 min
  5.18  [Playtest] finished armfmkr team 0 at 5.18 min
  5.22  [Playtest] finished armfmkr team 0 at 5.22 min
  5.30  [Playtest] finished armfmkr team 0 at 5.30 min
  5.36  [Playtest] finished armnanotcplat team 0 at 5.36 min
  5.38  [Playtest] finished armfmkr team 0 at 5.38 min
  5.40  [Playtest] finished armfmkr team 0 at 5.40 min
  5.53  [Playtest] finished armfmkr team 0 at 5.53 min
  5.61  [Playtest] finished armfmkr team 0 at 5.61 min
  5.65  [Playtest] finished armfmkr team 0 at 5.65 min
  5.71  [Playtest] finished armfmkr team 0 at 5.71 min
  5.92  [Playtest] finished armfmkr team 0 at 5.92 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 86973/100100, energy +1378.0 bank 698644/1003550, units 49
  6.00  [Playtest] camera requested (6200,11000) height=2200
  6.01  [Playtest] camera captured name=ta position=(6200,11000) height=2200
  6.01  [Playtest] screenshot at 6.0 min of team 0 at (6200, 11000)
  6.64  [Playtest] finished armnanotcplat team 0 at 6.64 min
  6.73  [Playtest] finished armnanotcplat team 0 at 6.73 min
  6.74  [Playtest] finished armnanotcplat team 0 at 6.74 min
  6.80  [Playtest] finished armnanotcplat team 0 at 6.80 min
  6.88  [Playtest] finished armnanotcplat team 0 at 6.88 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +2.0 bank 82824/100100, energy +1378.0 bank 725225/1003550, units 60
  7.12  [Playtest] finished armnanotcplat team 0 at 7.12 min
  7.15  [Playtest] finished armnanotcplat team 0 at 7.15 min
  7.18  [Playtest] finished armnanotcplat team 0 at 7.18 min
  7.27  [Playtest] finished armnanotcplat team 0 at 7.27 min
  7.36  [Playtest] finished armnanotcplat team 0 at 7.36 min
  7.43  [Playtest] finished armnanotcplat team 0 at 7.43 min
  7.51  [Playtest] finished armnanotcplat team 0 at 7.51 min
  7.56  [Playtest] finished armnanotcplat team 0 at 7.56 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +25.8 bank 79514/100100, energy +1378.0 bank 753351/1003550, units 68
  9.00  [Playtest] eco team 0 at 9.0 min: metal +25.8 bank 81059/100100, energy +1378.0 bank 753351/1003550, units 68
 10.00  [Playtest] eco team 0 at 10.0 min: metal +25.8 bank 82604/100100, energy +1378.0 bank 753351/1003550, units 68
 11.00  [Playtest] eco team 0 at 11.0 min: metal +25.8 bank 84149/100100, energy +1378.0 bank 753351/1003550, units 68
 11.00  [Playtest] camera requested (6200,11000) height=2200
 11.01  [Playtest] camera captured name=ta position=(6200,11000) height=2200
 11.01  [Playtest] screenshot at 11.0 min of team 0 at (6200, 11000)
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
  0.21  RESERVE: served armfmkr at (6632, 11544) facing 2 (id 51, 2 of this def still held)
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
  0.25  RESERVE: served armnanotcplat at (6488, 11448) facing 2 (id 34, 31 of this def still held)
  0.25  RESERVE: set of 2 armuwmmm from (6568, 11392), 0 cell(s) from a turret, growing (0, -4) cells a step (group 8, id 69)
  0.26  RESERVE: served armuwmmm at (6568, 11392) facing 2 (id 69, 1 of this def still held)
  0.26  RESERVE: served armuwmmm at (6568, 11328) facing 2 (id 70, 0 of this def still held)
  0.42  RESERVE: set of 2 armuwmmm from (6600, 11456), 0 cell(s) from a turret, growing (5, 0) cells a step (group 9, id 71)
  0.43  RESERVE: served armuwmmm at (6600, 11456) facing 2 (id 71, 1 of this def still held)
  0.45  RESERVE: served armuwmmm at (6680, 11456) facing 2 (id 72, 0 of this def still held)
  0.51  RESERVE: served armfmkr at (6680, 11544) facing 2 (id 52, 1 of this def still held)
  0.67  RESERVE: set of 2 armuwmmm from (6600, 11600), 0 cell(s) from a turret, growing (5, 0) cells a step (group 10, id 73)
  0.67  RESERVE: served armuwmmm at (6600, 11600) facing 2 (id 73, 1 of this def still held)
  0.85  RESERVE: served armuwmmm at (6680, 11600) facing 2 (id 74, 0 of this def still held)
  0.90  RESERVE: zone 32 at (6208, 11648) facing 2, 40x40 cells: 832 of 1600 held
  0.90  RESERVE: zone 32 released
  0.90  RESERVE: zone 33 at (6336, 11648) facing 2, 40x40 cells: 576 of 1600 held
  0.90  RESERVE: zone 33 released
  0.90  RESERVE: zone 34 at (6464, 11648) facing 2, 40x40 cells: 320 of 1600 held
  0.90  RESERVE: zone 34 released
  0.90  RESERVE: zone 35 at (6592, 11648) facing 2, 40x40 cells: 576 of 1600 held
  0.90  RESERVE: zone 35 released
  0.96  RESERVE: armfmkr at (6632, 11544) lost; slot restored (id 51)
  1.04  RESERVE: zone 36 at (6336, 11776) facing 2, 40x40 cells: 832 of 1600 held
  1.04  RESERVE: zone 36 released
  1.18  RESERVE: zone 37 at (6464, 11776) facing 2, 40x40 cells: 640 of 1600 held
  1.18  RESERVE: zone 37 released
  1.18  RESERVE: zone 38 at (6592, 11776) facing 2, 40x40 cells: 832 of 1600 held
  1.18  RESERVE: zone 38 released
  1.29  RESERVE: zone 39 at (6592, 11904) facing 2, 40x40 cells: 1088 of 1600 held
  1.29  RESERVE: zone 39 released
  2.13  RESERVE: zone 40 at (5952, 11520) facing 2, 40x40 cells: 1232 of 1600 held
  2.13  RESERVE: zone 40 released
  2.13  RESERVE: zone 41 at (6080, 11520) facing 2, 40x40 cells: 920 of 1600 held
  2.13  RESERVE: zone 41 released
  2.13  RESERVE: zone 42 at (6208, 11520) facing 2, 40x40 cells: 632 of 1600 held
  2.13  RESERVE: zone 42 released
  2.32  RESERVE: zone 43 at (6336, 11520) facing 2, 40x40 cells: 320 of 1600 held
  2.32  RESERVE: zone 43 released
  2.32  RESERVE: zone 44 at (6464, 11520) facing 2, 40x40 cells: 0 of 1600 held
  2.32  RESERVE: zone 44 at (6592, 11520) facing 2, 40x40 cells: 320 of 1600 held
  2.32  RESERVE: zone 44 released
  2.35  RESERVE: served armnanotcplat at (6440, 11448) facing 2 (id 35, 30 of this def still held)
  2.57  RESERVE: set of 2 armuwmmm from (6392, 11392), 0 cell(s) from a turret, growing (0, -4) cells a step (group 24, id 75)
  2.58  RESERVE: served armnanotcplat at (5832, 10568) facing 2 (id 1, 29 of this def still held)
  2.58  RESERVE: served armuwmmm at (6392, 11392) facing 2 (id 75, 1 of this def still held)
  2.75  RESERVE: served armnanotcplat at (6872, 10616) facing 2 (id 61, 28 of this def still held)
  2.75  RESERVE: served armuwmmm at (6392, 11328) facing 2 (id 76, 0 of this def still held)
```
