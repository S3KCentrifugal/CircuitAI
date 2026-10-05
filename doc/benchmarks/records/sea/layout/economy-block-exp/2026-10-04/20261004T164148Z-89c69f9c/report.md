# Playtest report: FAIL

- Verdict: **FAIL** (expected lines never seen: t2, fusion-support, rear-fusion)
- Game time reached: 12.0 min (frame 21600); wall 94 s
- DLL: build-theatres\d191-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T13:40:11
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: economy-block.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block-exp\supreme\20261004T164011Z-c98f0120\runs\20261004T164148Z-89c69f9c\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `t1` | seen at 4.3 min | `[t=00:00:58.692463][f=0007800] [SeaBlock] PASS packed armfmkr count=12 edges=11` |
| expect `t2` | **missing** (by 12 min) | |
| expect `shipyard` | seen at 1.6 min | `[t=00:00:46.771255][f=0002880] [SeaBlock] PASS factory assist armsy` |
| expect `amphibious` | seen at 1.6 min | `[t=00:00:46.971628][f=0002970] [SeaBlock] PASS factory assist armamsub` |
| expect `fusion-support` | **missing** (by 12 min) | |
| expect `rear-fusion` | **missing** (by 12 min) | |
| forbid `errors` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block-exp\supreme\20261004T164011Z-c98f0120\runs\20261004T164148Z-89c69f9c\screen_2026-10-04_16-41-08-707.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block-exp\supreme\20261004T164011Z-c98f0120\runs\20261004T164148Z-89c69f9c\screen_2026-10-04_16-41-21-698.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block-exp\supreme\20261004T164011Z-c98f0120\runs\20261004T164148Z-89c69f9c\screen_2026-10-04_16-41-22-116.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block-exp\supreme\20261004T164011Z-c98f0120\runs\20261004T164148Z-89c69f9c\screen_2026-10-04_16-41-43-002.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 3 shots, end at 12.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.17  [Playtest] finished armsy team 0 at 0.17 min
  0.18  [Playtest] finished armamsub team 0 at 0.18 min
  0.70  [Playtest] finished armfmkr team 0 at 0.70 min
  0.71  [Playtest] finished armfmkr team 0 at 0.71 min
  0.94  [Playtest] finished armuwmmm team 0 at 0.94 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +14.3 bank 98759/100100, energy +178.0 bank 953997/1001050, units 22
  1.58  [Playtest] finished armnanotcplat team 0 at 1.58 min
  1.63  [Playtest] finished armnanotcplat team 0 at 1.63 min
  1.73  [Playtest] finished armnanotcplat team 0 at 1.73 min
  1.76  [Playtest] finished armnanotcplat team 0 at 1.76 min
  1.89  [Playtest] finished armnanotcplat team 0 at 1.89 min
  1.98  [Playtest] finished armuwmmm team 0 at 1.98 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +14.3 bank 95618/100100, energy +178.0 bank 826897/1001050, units 29
  2.06  [Playtest] finished armuwmmm team 0 at 2.06 min
  2.21  [Playtest] finished armnanotcplat team 0 at 2.21 min
  2.27  [Playtest] finished armnanotcplat team 0 at 2.27 min
  2.28  [Playtest] finished armnanotcplat team 0 at 2.28 min
  2.33  [Playtest] finished armnanotcplat team 0 at 2.33 min
  2.40  [Playtest] finished armnanotcplat team 0 at 2.40 min
  2.54  [Playtest] finished armnanotcplat team 0 at 2.54 min
  2.62  [Playtest] finished armnanotcplat team 0 at 2.62 min
  2.63  [Playtest] finished armuwmmm team 0 at 2.63 min
  2.70  [Playtest] finished armnanotcplat team 0 at 2.70 min
  2.82  [Playtest] finished armuwmmm team 0 at 2.82 min
  2.88  [Playtest] finished armnanotcplat team 0 at 2.88 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 91668/100100, energy +178.0 bank 708243/1001050, units 41
  3.00  [Playtest] camera requested (6200,11000) height=2200
  3.01  [Playtest] camera captured name=ta position=(6200,11000) height=2200
  3.01  [Playtest] screenshot at 3.0 min of team 0 at (6200, 11000)
  3.34  [Playtest] finished armfmkr team 0 at 3.34 min
  3.43  [Playtest] finished armfmkr team 0 at 3.43 min
  3.44  [Playtest] finished armfmkr team 0 at 3.44 min
  3.58  [Playtest] finished armuwmmm team 0 at 3.58 min
  3.71  [Playtest] finished armfmkr team 0 at 3.71 min
  3.75  [Playtest] finished armuwmmm team 0 at 3.74 min
  3.79  [Playtest] finished armfmkr team 0 at 3.79 min
  3.82  [Playtest] finished armfmkr team 0 at 3.82 min
  3.95  [Playtest] finished armfmkr team 0 at 3.95 min
  3.98  [Playtest] finished armfmkr team 0 at 3.98 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 91298/100100, energy +178.0 bank 680809/1001050, units 46
  4.00  [Playtest] finished armfmkr team 0 at 4.00 min
  4.04  [Playtest] finished armfmkr team 0 at 4.04 min
  4.15  [Playtest] finished armfmkr team 0 at 4.15 min
  4.20  [Playtest] finished armfmkr team 0 at 4.20 min
  4.25  [Playtest] finished armfmkr team 0 at 4.25 min
  4.32  [Playtest] finished armfmkr team 0 at 4.32 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 91413/100100, energy +178.0 bank 686291/1001050, units 50
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 91533/100100, energy +178.0 bank 696971/1001050, units 50
  6.00  [Playtest] camera requested (6200,11000) height=2200
  6.01  [Playtest] camera captured name=ta position=(6200,11000) height=2200
  6.01  [Playtest] screenshot at 6.0 min of team 0 at (6200, 11000)
  7.00  [Playtest] eco team 0 at 7.0 min: metal +2.0 bank 91653/100100, energy +178.0 bank 707651/1001050, units 50
  8.00  [Playtest] eco team 0 at 8.0 min: metal +2.0 bank 91773/100100, energy +178.0 bank 718331/1001050, units 50
  9.00  [Playtest] eco team 0 at 9.0 min: metal +2.0 bank 91893/100100, energy +178.0 bank 729011/1001050, units 50
 10.00  [Playtest] eco team 0 at 10.0 min: metal +2.0 bank 92038/100100, energy +178.0 bank 739793/1001050, units 50
 11.00  [Playtest] eco team 0 at 11.0 min: metal +2.0 bank 92158/100100, energy +178.0 bank 750473/1001050, units 50
 11.00  [Playtest] camera requested (6200,11000) height=2200
 11.01  [Playtest] camera captured name=ta position=(6200,11000) height=2200
 11.01  [Playtest] screenshot at 11.0 min of team 0 at (6200, 11000)
 12.00  [Playtest] eco team 0 at 12.0 min: metal +5.1 bank 92455/100100, energy +178.0 bank 750876/1001050, units 50
```

## Native lines (all AIs, first 120)

```
  0.18  RESERVE: corridor 1 at (6600, 11028) facing 0, 13x31 cells: 273 of 403 held
  0.18  RESERVE: corridor 2 at (5824, 11024) facing 0, 12x30 cells: 240 of 360 held
  0.18  RESERVE: zone 3 at (6600, 11188) facing 2, 41x41 cells: 1300 of 1681 held
  0.18  RESERVE: zone 3 released
  0.18  RESERVE: zone 4 at (6472, 11188) facing 2, 41x41 cells: 1304 of 1681 held
  0.18  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6472, 11092) facing 2: 8 of 16 slots (group 2, held, zone)
  0.18  RESERVE: zone 4 released
  0.18  RESERVE: zone 5 at (6728, 11188) facing 2, 41x41 cells: 1308 of 1681 held
  0.18  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6728, 11092) facing 2: 6 of 16 slots (group 3, held, zone)
  0.18  RESERVE: zone 5 released
  0.18  RESERVE: zone 6 at (6344, 11188) facing 2, 41x41 cells: 1357 of 1681 held
  0.18  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6344, 11092) facing 2: 16 of 16 slots (group 4, held, zone)
  0.18  RESERVE: armuwfus at (6336, 11312) facing 2 (id 31)
  0.18  RESERVE: packed armuwfus at (6336, 11312) facing 2 in zone 6, 313 from a turret (id 31, group 0, 824 candidates)
  0.20  RESERVE: zone 7 at (6888, 10536) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6888, 10536) facing 2 (id 32)
  0.20  RESERVE: zone 8 at (6840, 10536) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6840, 10536) facing 2 (id 33)
  0.20  RESERVE: zone 9 at (6792, 10536) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6792, 10536) facing 2 (id 34)
  0.20  RESERVE: zone 10 at (6744, 10536) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6744, 10536) facing 2 (id 35)
  0.20  RESERVE: zone 11 at (6696, 10536) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6696, 10536) facing 2 (id 36)
  0.20  RESERVE: zone 12 at (6888, 10488) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6888, 10488) facing 2 (id 37)
  0.20  RESERVE: zone 13 at (6840, 10488) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6840, 10488) facing 2 (id 38)
  0.20  RESERVE: zone 7 released
  0.20  RESERVE: zone 8 released
  0.20  RESERVE: zone 9 released
  0.20  RESERVE: zone 10 released
  0.20  RESERVE: zone 11 released
  0.20  RESERVE: zone 12 released
  0.20  RESERVE: zone 13 released
  0.20  RESERVE: zone 14 at (6872, 10616) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6872, 10616) facing 2 (id 39)
  0.20  RESERVE: zone 15 at (6824, 10616) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6824, 10616) facing 2 (id 40)
  0.20  RESERVE: zone 16 at (6776, 10616) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6776, 10616) facing 2 (id 41)
  0.20  RESERVE: zone 17 at (6728, 10616) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6728, 10616) facing 2 (id 42)
  0.20  RESERVE: zone 18 at (6680, 10616) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6680, 10616) facing 2 (id 43)
  0.20  RESERVE: zone 19 at (6872, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6872, 10568) facing 2 (id 44)
  0.20  RESERVE: zone 20 at (6824, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6824, 10568) facing 2 (id 45)
  0.20  RESERVE: zone 21 at (6776, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6776, 10568) facing 2 (id 46)
  0.20  RESERVE: set of 4 armfmkr from (6232, 11208), 0 cell(s) from a turret, growing (-3, 0) cells a step (group 5, id 47)
  0.20  RESERVE: served armfmkr at (6232, 11208) facing 2 (id 47, 3 of this def still held)
  0.20  EXP: approach: armcs(14977) at (6124, 10524) walks to (6009, 11153), 184 from the armfmkr site (6184, 11208)
  0.21  RESERVE: served armfmkr at (6184, 11208) facing 2 (id 48, 2 of this def still held)
  0.22  RESERVE: zone 22 at (5832, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (5832, 10568) facing 2 (id 51)
  0.22  RESERVE: zone 23 at (5784, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (5784, 10568) facing 2 (id 52)
  0.22  RESERVE: zone 24 at (5736, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (5736, 10568) facing 2 (id 53)
  0.22  RESERVE: zone 25 at (5688, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (5688, 10568) facing 2 (id 54)
  0.22  RESERVE: zone 26 at (5640, 10568) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (5640, 10568) facing 2 (id 55)
  0.22  RESERVE: zone 27 at (5832, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (5832, 10520) facing 2 (id 56)
  0.22  RESERVE: zone 28 at (5784, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (5784, 10520) facing 2 (id 57)
  0.22  RESERVE: zone 29 at (5736, 10520) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (5736, 10520) facing 2 (id 58)
  0.22  RESERVE: zone 1 at (6432, 1664) facing 0, 6x6 cells: 36 of 36 held
  0.22  RESERVE: armsy at (6432, 1664) facing 0 (id 1)
  0.22  RESERVE: corridor 2 at (6432, 1952) facing 0, 12x30 cells: 360 of 360 held
  0.22  RESERVE: zone 3 at (6408, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6408, 1544) facing 0 (id 2)
  0.22  RESERVE: zone 4 at (6456, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6456, 1544) facing 0 (id 3)
  0.22  RESERVE: zone 5 at (6504, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6504, 1544) facing 0 (id 4)
  0.22  RESERVE: zone 6 at (6552, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6552, 1544) facing 0 (id 5)
  0.22  RESERVE: zone 7 at (6600, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6600, 1544) facing 0 (id 6)
  0.22  RESERVE: zone 8 at (6408, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6408, 1592) facing 0 (id 7)
  0.22  RESERVE: zone 9 at (6456, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6456, 1592) facing 0 (id 8)
  0.22  RESERVE: zone 10 at (6504, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6504, 1592) facing 0 (id 9)
  0.22  RESERVE: zone 11 at (6552, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6552, 1592) facing 0 (id 10)
  0.22  RESERVE: zone 12 at (6600, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6600, 1592) facing 0 (id 11)
  0.22  RESERVE: zone 3 released
  0.22  RESERVE: zone 4 released
  0.22  RESERVE: zone 5 released
  0.22  RESERVE: zone 6 released
  0.22  RESERVE: zone 7 released
  0.22  RESERVE: zone 8 released
  0.22  RESERVE: zone 9 released
  0.22  RESERVE: zone 10 released
  0.22  RESERVE: zone 11 released
  0.22  RESERVE: zone 12 released
  0.22  RESERVE: zone 13 at (6344, 1560) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6344, 1560) facing 0 (id 12)
  0.22  RESERVE: zone 14 at (6392, 1560) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6392, 1560) facing 0 (id 13)
  0.22  RESERVE: zone 15 at (6440, 1560) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6440, 1560) facing 0 (id 14)
  0.22  RESERVE: zone 16 at (6488, 1560) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6488, 1560) facing 0 (id 15)
  0.22  RESERVE: zone 17 at (6536, 1560) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6536, 1560) facing 0 (id 16)
  0.22  RESERVE: zone 18 at (6344, 1608) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6344, 1608) facing 0 (id 17)
  0.22  RESERVE: zone 13 released
  0.22  RESERVE: zone 14 released
  0.22  RESERVE: zone 15 released
  0.22  RESERVE: zone 16 released
```
