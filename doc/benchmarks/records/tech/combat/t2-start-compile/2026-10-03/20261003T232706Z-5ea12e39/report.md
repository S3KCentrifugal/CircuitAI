# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 1.3 min (frame 2260); wall 38 s
- DLL: build-theatres\games\air\economy\workforce-baseline\cohort\20261003T164015Z-53db5088\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T20:26:24
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=TECH/legion/test, 1=TECH/armada/test
- Team 0 (under test): skirmish AI 0, role TECH
- Checks: smoke.json; widget loaded: yes
- Log: build-theatres\games\tech\combat\t2-start-compile\supreme\20261003T232603Z-406f5e85\runs\20261003T232706Z-5ea12e39\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `exp on` | seen at 0.1 min | `[TECH][Build] experimental build system on: direct range 1600, search radius 512` |
| expect `opening mex` | **missing** (by 1.0 min) | |
| expect `widget` | seen at -0.0 min | `[t=00:00:28.532500][f=-000001] [Playtest] widget loaded: role TECH, team 0, speed 20, 0 shots, end at 1.5 min` |
| expect `screenshot` | **missing** (by 2.0 min) | |
| forbid `script error` | clean |  |
| forbid `invariant` | clean |  |

## Failures

- 'opening mex' not seen by 1.0 min

## Screenshots

- none

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role TECH, team 0, speed 20, 0 shots, end at 1.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished legcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side legion ai true dead false start (837, 10407) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 38
  0.00  [Playtest] speed 20
  0.05  [Playtest] frame 90 team 0 ally 0 side legion ai true dead false start (837, 10407) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 38
  0.08  [Layout] on for this AI
  0.08  [TECH][Opening] mexes within 700 elmos first (nearest 3); start factory held up to 240 s
  0.08  [TECH][Build] experimental build system on: direct range 1600, search radius 512
  0.08  [TECH][Opening] complete after 0 mexes, 0 s: the rush chain owns the opening; the lab is next
  0.08  [Layout] on for this AI
  0.08  [Layout] native factory pair committed facing 1, side offset 12 cells, forward offset 4 cells
  0.08  [Layout] home centre (850, 10424), 46 from the start
  0.08  [Layout] turret box 40x44 cells at (850, 9656), from the start rear 0, side 48, ground 99%, halo 85%: zone 7, 4 rows, 52 of 52 turret slots
  0.08  [Layout] advanced lab on the front line at (1290, 9896) facing 1, 1 cells ahead of turret row 0
  0.08  [Layout] the front is (6144, 6144): the labs face 1 (lane (6144, 6144), the pair faces 1)
  0.08  [Layout] advanced lab faces 1 (the pair faces 1)
  0.08  [Layout] advanced lab's footprint reserved at (1288, 9896), 685 from the home centre, 18 turret slots within reach, 5 flush (D-095)
  0.08  [Layout] forward cluster 40x36 cells at (1618, 9976), 8 cells ahead of the main cluster, ground 75%: zone 8, 4 rows, 52 turret slots
  0.08  [Rule] table of 50 rules loaded
  0.34  [Playtest] finished legmex team 0 at 0.34 min
  0.35  [Team][Roster] first mex 6022 at 672,10624
  0.35  [Team][Roster] Re-announced: roster|1|0|0|TECH|legion|leglab|809|10443|0|1|1|672|10624
  0.35  [Rule] chain.next for legcom 20428 | M +2 E 30/76 T1 M-float
  0.56  [Playtest] finished legmex team 0 at 0.56 min
  0.57  [Rule] chain.next for legcom 20428 | M +4 E 30/94 T1 M-float
  0.82  [Playtest] finished legmex team 0 at 0.82 min
  0.84  [TECH][Build] first lab at the commander: (1056, 10624), 188 from it, facing 1; the pair's slot stays planned
  0.84  [Rule] chain.next for legcom 20428 | M +6 E 30/116 T1 M-float
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.9 bank 866/1150, energy +30.0 bank 67/1000, units 5
  1.24  [Playtest] finished leglab team 0 at 1.24 min
  1.25  [TECH][Build] first lab's exit held (zone 54) until it is reclaimed
  1.25  [Rule] chain.next for legcom 20428 | M +2 E 30/79 T1 draining
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 1
  0.08  RESERVE: zone 7 at (707, 9656) facing 1, 63x77 cells: 4528 of 4851 held
  0.08  RESERVE: grid of legnanotc 13x1 gap 0 behind (1203, 9656) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of legnanotc 13x1 gap 0 behind (1155, 9656) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of legnanotc 13x1 gap 0 behind (1107, 9656) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of legnanotc 13x1 gap 0 behind (1059, 9656) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: legalab at (1288, 9896) facing 1 (id 63)
  0.08  RESERVE: zone 8 at (1619, 9976) facing 1, 37x41 cells: 1486 of 1517 held
  0.08  RESERVE: grid of legnanotc 13x1 gap 0 behind (1907, 9976) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of legnanotc 13x1 gap 0 behind (1859, 9976) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of legnanotc 13x1 gap 0 behind (1811, 9976) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of legnanotc 13x1 gap 0 behind (1763, 9976) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: leglab at (2064, 8464) facing 1 (id 116)
  0.08  RESERVE: zone 9 at (1992, 8464) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of legnanotc 2x1 gap 0 behind (2016, 8464) facing 1: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: leglab at (2352, 8384) facing 1 (id 119)
  0.08  RESERVE: zone 10 at (2280, 8384) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of legnanotc 2x1 gap 0 behind (2304, 8384) facing 1: 2 of 2 slots (group 8, zone)
  0.08  RESERVE: leglab at (2272, 8288) facing 1 (id 122)
  0.08  RESERVE: zone 11 at (2200, 8288) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of legnanotc 2x1 gap 0 behind (2224, 8288) facing 1: 2 of 2 slots (group 9, zone)
  0.08  RESERVE: corridor 12 at (2248, 8384) facing 1, 21x6 cells: 108 of 126 held
  0.08  RESERVE: zone 13 at (2248, 8288) facing 0, 9x6 cells: 0 of 54 held
  0.08  RESERVE: corridor 13 at (2496, 8288) facing 1, 20x10 cells: 190 of 200 held
  0.08  EXP: approach: legcom(20428) at (809, 10444) walks to (755, 10515), 137 from the legmex site (672, 10624)
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 3
  0.08  RESERVE: zone 7 at (11581, 2536) facing 3, 63x77 cells: 4408 of 4851 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (11085, 2536) facing 3: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (11133, 2536) facing 3: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (11181, 2536) facing 3: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (11229, 2536) facing 3: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (11000, 2296) facing 3 (id 63)
  0.08  RESERVE: zone 8 at (10605, 2216) facing 3, 45x41 cells: 1827 of 1845 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (10253, 2216) facing 3: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (10301, 2216) facing 3: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (10349, 2216) facing 3: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (10397, 2216) facing 3: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: armlab at (10224, 3824) facing 3 (id 116)
  0.08  RESERVE: zone 9 at (10296, 3824) facing 3, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (10272, 3824) facing 3: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: corridor 10 at (10248, 3920) facing 3, 21x6 cells: 126 of 126 held
  0.08  RESERVE: zone 11 at (10248, 3824) facing 0, 9x6 cells: 0 of 54 held
  0.08  RESERVE: corridor 11 at (10000, 3824) facing 3, 20x10 cells: 190 of 200 held
  0.17  RESERVE: leglab at (3184, 8544) facing 1 (id 125)
  0.17  RESERVE: zone 14 at (3112, 8544) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (3136, 8544) facing 1: 2 of 2 slots (group 10, zone)
  0.17  RESERVE: leglab at (3104, 8448) facing 1 (id 128)
  0.17  RESERVE: zone 15 at (3032, 8448) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (3056, 8448) facing 1: 2 of 2 slots (group 11, zone)
  0.17  RESERVE: corridor 16 at (3080, 8544) facing 1, 21x6 cells: 108 of 126 held
  0.17  RESERVE: zone 17 at (3080, 8448) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 17 at (3328, 8448) facing 1, 20x10 cells: 190 of 200 held
  0.17  RESERVE: armlab at (9648, 3968) facing 3 (id 119)
  0.17  RESERVE: zone 12 at (9720, 3968) facing 3, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (9696, 3968) facing 3: 2 of 2 slots (group 8, zone)
  0.17  RESERVE: corridor 13 at (9672, 4064) facing 3, 21x6 cells: 126 of 126 held
  0.17  RESERVE: zone 14 at (9672, 3968) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 14 at (9424, 3968) facing 3, 20x10 cells: 190 of 200 held
  0.23  EXP: approach: armcom(6187) at (11494, 1983) walks to (11576, 1804), 136 from the armmex site (11632, 1680)
  0.25  RESERVE: legalab at (1672, 8408) facing 1 (id 131)
  0.25  RESERVE: zone 18 at (1552, 8408) facing 1, 6x7 cells: 42 of 42 held
  0.25  RESERVE: grid of legnanotc 2x2 gap 0 behind (1600, 8408) facing 1: 4 of 4 slots (group 12, zone)
  0.25  RESERVE: zone 19 at (1624, 8408) facing 0, 15x9 cells: 12 of 135 held
  0.25  RESERVE: corridor 20 at (1920, 8408) facing 1, 20x13 cells: 242 of 260 held
  0.25  RESERVE: zone 21 at (2112, 9968) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 9968) facing 0 (id 136)
  0.25  RESERVE: zone 22 at (2112, 10000) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10000) facing 0 (id 137)
  0.25  RESERVE: zone 23 at (2112, 10032) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10032) facing 0 (id 138)
  0.25  RESERVE: zone 24 at (2112, 10064) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10064) facing 0 (id 139)
  0.25  RESERVE: zone 25 at (2112, 10096) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10096) facing 0 (id 140)
  0.25  RESERVE: zone 26 at (2112, 10128) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10128) facing 0 (id 141)
  0.25  RESERVE: zone 27 at (2112, 10160) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10160) facing 0 (id 142)
  0.25  RESERVE: zone 28 at (2112, 10192) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10192) facing 0 (id 143)
  0.25  RESERVE: zone 29 at (2112, 10224) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10224) facing 0 (id 144)
  0.25  RESERVE: zone 30 at (2112, 10256) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10256) facing 0 (id 145)
  0.25  RESERVE: zone 31 at (2112, 10288) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10288) facing 0 (id 146)
  0.25  RESERVE: zone 32 at (2112, 10608) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10608) facing 0 (id 147)
  0.25  RESERVE: zone 33 at (2112, 10640) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10640) facing 0 (id 148)
  0.25  RESERVE: zone 34 at (2112, 10672) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10672) facing 0 (id 149)
  0.25  RESERVE: zone 35 at (2112, 10704) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10704) facing 0 (id 150)
  0.25  RESERVE: zone 36 at (2112, 10736) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10736) facing 0 (id 151)
  0.25  RESERVE: zone 37 at (2112, 10768) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10768) facing 0 (id 152)
  0.25  RESERVE: zone 38 at (2112, 10800) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10800) facing 0 (id 153)
  0.25  RESERVE: zone 39 at (2112, 10832) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10832) facing 0 (id 154)
  0.25  RESERVE: zone 40 at (2112, 10864) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10864) facing 0 (id 155)
  0.25  RESERVE: zone 41 at (2112, 10896) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10896) facing 0 (id 156)
  0.25  RESERVE: zone 42 at (2112, 10928) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2112, 10928) facing 0 (id 157)
  0.25  RESERVE: zone 43 at (2000, 10192) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: leglht at (2000, 10192) facing 0 (id 158)
  0.25  RESERVE: zone 44 at (1992, 10696) facing 0, 3x3 cells: 9 of 9 held
  0.25  RESERVE: legrl at (1992, 10696) facing 0 (id 159)
  0.25  RESERVE: armalab at (10408, 4056) facing 3 (id 122)
  0.25  RESERVE: zone 15 at (10528, 4056) facing 3, 6x7 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (10480, 4056) facing 3: 4 of 4 slots (group 9, zone)
  0.25  RESERVE: zone 16 at (10456, 4056) facing 0, 15x9 cells: 12 of 135 held
  0.25  RESERVE: corridor 17 at (10160, 4056) facing 3, 20x13 cells: 245 of 260 held
  0.25  RESERVE: zone 18 at (10176, 2432) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (10176, 2432) facing 0 (id 127)
  0.25  RESERVE: zone 19 at (10176, 2400) facing 0, 2x2 cells: 4 of 4 held
```
