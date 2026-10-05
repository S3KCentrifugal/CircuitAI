# Playtest report: PASS

- Verdict: **PASS** (reached 4 min)
- Game time reached: 4.0 min (frame 7200); wall 134 s
- DLL: build-theatres\d199\build-6\SkirmishAI.dll (1eb777348e1d5f78); AI BARbTest/test; staged 2026-10-04T23:42:05
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=TECH/armada/test, 1=TECH/armada/test
- Team 0 (under test): skirmish AI 0, role TECH
- Checks: weapon_work.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\weapon-work-terrible\supreme\20261005T024205Z-59ffc177\runs\20261005T024422Z-84019acb\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `opening` | seen at 0.3 min | `[Rule] chain.next for armcom 10279 / M +2 E 30/76 T1 M-float` |
| expect `probe` | seen at 1.8 min | `[WeaponPerf] PASS 500 old and 500 new asks, 32 clusters x 16 slots, actual UnitDef mapping, no orders` |
| expect `old-timer` | seen at 1.0 min | `[t=00:01:20.442280][f=0001800] Skirmish AI <BARb playtest-test>: [PerfLabel] team=0 frame=1800 label=weapon-fixture-old calls=25 inclusive_ms=15762.943000 exclusive_ms=15762.943000 max_ms=641.135800` |
| expect `new-timer` | seen at 1.0 min | `[t=00:01:20.442240][f=0001800] Skirmish AI <BARb playtest-test>: [PerfLabel] team=0 frame=1800 label=weapon-fixture-new calls=26 inclusive_ms=541.998400 exclusive_ms=528.230100 max_ms=24.915700` |
| forbid `script` | clean |  |
| forbid `probe-failed` | clean |  |
| forbid `invariant` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\weapon-work-terrible\supreme\20261005T024205Z-59ffc177\runs\20261005T024422Z-84019acb\screen_2026-10-05_02-44-10-477.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\weapon-work-terrible\supreme\20261005T024205Z-59ffc177\runs\20261005T024422Z-84019acb\screen_2026-10-05_02-44-20-915.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role TECH, team 0, speed 15, 2 shots, end at 4.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 32
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 32
  0.08  [Layout] on for this AI
  0.08  [TECH][Opening] mexes within 700 elmos first (nearest 3); start factory held up to 240 s
  0.08  [TECH][Build] experimental build system on: direct range 1600, search radius 512
  0.08  [TECH][Opening] complete after 0 mexes, 0 s: the rush chain owns the opening; the lab is next
  0.08  [Layout] on for this AI
  0.08  [Layout] native factory pair committed facing 1, side offset 16 cells, forward offset 0 cells
  0.08  [Layout] home centre (850, 10424), 49 from the start
  0.08  [Layout] turret box 32x44 cells at (850, 9656), from the start rear 0, side 48, ground 99%, halo 84%: zone 7, 4 rows, 40 of 40 turret slots
  0.08  [Layout] advanced lab on the front line at (1290, 9832) facing 1, 1 cells ahead of turret row 0
  0.08  [Layout] the front is (6144, 6144): the labs face 1 (lane (6144, 6144), the pair faces 1)
  0.08  [Layout] advanced lab faces 1 (the pair faces 1)
  0.08  [Layout] advanced lab's footprint reserved at (1288, 9832), 736 from the home centre, 18 turret slots within reach, 5 flush (D-095)
  0.08  [Layout] forward cluster 32x28 cells at (1554, 9912), 8 cells ahead of the main cluster, ground 82%: zone 8, 4 rows, 30 turret slots
  0.08  [Rule] table of 50 rules loaded
  0.29  [Playtest] finished armmex team 0 at 0.29 min
  0.30  [Team][Roster] first mex 24157 at 752,10160
  0.30  [Team][Roster] Re-announced: roster|1|0|0|TECH|armada|armlab|814|10389|0|1|1|752|10160
  0.30  [Rule] chain.next for armcom 10279 | M +2 E 30/76 T1 M-float
  0.56  [Playtest] finished armmex team 0 at 0.56 min
  0.57  [Rule] chain.next for armcom 10279 | M +4 E 30/94 T1 M-float
  0.82  [Playtest] finished armmex team 0 at 0.82 min
  0.84  [TECH][Build] first lab at the commander: (976, 10400), 93 from it, facing 1; the pair's slot stays planned
  0.84  [Rule] chain.next for armcom 10279 | M +6 E 30/116 T1 M-float
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.9 bank 876/1150, energy +30.0 bank 235/1000, units 5
  1.16  [Playtest] finished armlab team 0 at 1.16 min
  1.17  [TECH][Build] first lab's exit held (zone 54) until it is reclaimed
  1.60  [Playtest] finished armwin team 0 at 1.60 min
  1.61  [Rule] chain.next for armcom 10279 | M +4 E 30/98 T1 draining
  1.72  [Playtest] finished armwin team 0 at 1.72 min
  1.73  [Rule] chain.next for armcom 10279 | M +5 E 30/102 T1
  1.80  [Playtest] target team 0 at (837, 10407) from its start position
  1.80  [Playtest] camera requested (837,10407) height=2200
  1.81  [Playtest] camera captured name=ta position=(837,10407) height=2200
  1.81  [Playtest] screenshot at 1.8 min of team 0 at (837, 10407)
  1.86  [Playtest] finished armwin team 0 at 1.86 min
  1.88  [Rule] chain.next for armcom 10279 | M +8 E 41/143 T1
  2.00  [Playtest] finished armwin team 0 at 2.00 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.9 bank 896/1250, energy +81.3 bank 123/1102, units 10
  2.01  [Rule] chain.next for armcom 10279 | M +8 E 55/143 T1
  2.13  [Playtest] finished armwin team 0 at 2.13 min
  2.19  [Rule] chain.next for armck 8815 | M +8 E 93/143 T1
  2.24  [Playtest] finished armwin team 0 at 2.24 min
  2.35  [Playtest] finished armwin team 0 at 2.35 min
  2.36  [Rule] chain.next for armcom 10279 | M +8 E 97/143 T1 draining
  2.62  [Rule] chain.next for armck 6042 | M +8 E 73/143 T1
  2.69  [Playtest] finished armwin team 0 at 2.69 min
  2.81  [Playtest] finished armwin team 0 at 2.81 min
  2.91  [Playtest] finished armwin team 0 at 2.91 min
  2.92  [Rule] chain.next for armcom 10279 | M +8 E 121/143 T1 draining
  2.94  [TECH][Build] no open mex spot within 2500 of armrectr 2129 at +8 metal
  2.94  [Rule] assist.any for armrectr 2129 | M +8 E 123/143 T1
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.9 bank 835/1250, energy +115.5 bank 335/1205, units 21
  3.05  [Playtest] finished armwin team 0 at 3.05 min
  3.11  [Playtest] finished armmex team 0 at 3.11 min
  3.12  [Rule] chain.next for armrectr 2129 | M +8 E 115/143 T1
  3.12  [Rule] chain.next for armck 8815 | M +8 E 115/143 T1
  3.16  [Playtest] finished armwin team 0 at 3.16 min
  3.24  [Rule] chain.next for armrectr 2129 | M +8 E 128/143 T1
  3.30  [Playtest] finished armwin team 0 at 3.30 min
  3.31  [Rule] chain.next for armcom 10279 | M +11 E 153/173 T1 E-float
  3.34  [Rule] chain.next for armck 7308 | M +11 E 181/173 T1 E-float
  3.38  [Rule] assist.any for armrectr 2129 | M +11 E 198/173 T1 E-float
  3.41  [Playtest] finished armwin team 0 at 3.41 min
  3.42  [Rule] chain.next for armcom 10279 | M +11 E 217/173 T1 E-float
  3.43  [Layout] advanced lab on its planned slot (1288, 9832): 18 turret slots within 260
  3.55  [Rule] chain.next for armrectr 2129 | M +11 E 257/173 T2 E-float
  3.65  [Playtest] finished armwin team 0 at 3.65 min
  3.66  [TECH][Build] T1 lab reclaim deferred: metal 931 of 1300 leaves no room for its 500
  3.66  [Rule] energy.convert.float for armcom 10279 | M +11 E 310/173 T2 E-float
  3.80  [Playtest] camera requested (837,10407) height=2200
  3.81  [Playtest] camera captured name=ta position=(837,10407) height=2200
  3.81  [Playtest] screenshot at 3.8 min of team 0 at (837, 10407)
  3.81  [Playtest] finished armmakr team 0 at 3.81 min
  3.88  [Playtest] finished armmex team 0 at 3.88 min
  3.90  [Rule] energy.convert.float for armck 6042 | M +11 E 325/173 T2 E-float
  3.97  [Playtest] finished armmakr team 0 at 3.97 min
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 1
  0.08  RESERVE: zone 7 at (707, 9656) facing 1, 63x69 cells: 3906 of 4347 held
  0.08  RESERVE: grid of armnanotc 10x1 gap 0 behind (1203, 9656) facing 1: 10 of 10 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 10x1 gap 0 behind (1155, 9656) facing 1: 10 of 10 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 10x1 gap 0 behind (1107, 9656) facing 1: 10 of 10 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 10x1 gap 0 behind (1059, 9656) facing 1: 10 of 10 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (1288, 9832) facing 1 (id 51)
  0.08  RESERVE: zone 8 at (1555, 9912) facing 1, 29x33 cells: 939 of 957 held
  0.08  RESERVE: grid of armnanotc 10x1 gap 0 behind (1779, 9912) facing 1: 10 of 10 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 10x1 gap 0 behind (1731, 9912) facing 1: 10 of 10 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 10x1 gap 0 behind (1683, 9912) facing 1: 5 of 10 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 10x1 gap 0 behind (1635, 9912) facing 1: 5 of 10 slots (group 6, held, zone)
  0.08  RESERVE: armlab at (2064, 8464) facing 1 (id 82)
  0.08  RESERVE: zone 9 at (1992, 8464) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (2016, 8464) facing 1: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: armlab at (2352, 8384) facing 1 (id 85)
  0.08  RESERVE: zone 10 at (2280, 8384) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (2304, 8384) facing 1: 2 of 2 slots (group 8, zone)
  0.08  RESERVE: armlab at (2272, 8288) facing 1 (id 88)
  0.08  RESERVE: zone 11 at (2200, 8288) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (2224, 8288) facing 1: 2 of 2 slots (group 9, zone)
  0.08  RESERVE: corridor 12 at (2248, 8384) facing 1, 21x6 cells: 108 of 126 held
  0.08  RESERVE: zone 13 at (2248, 8288) facing 0, 9x6 cells: 0 of 54 held
  0.08  RESERVE: corridor 13 at (2496, 8288) facing 1, 20x10 cells: 190 of 200 held
  0.08  EXP: approach: armcom(10279) at (815, 10389) walks to (788, 10291), 136 from the armmex site (752, 10160)
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
  0.17  RESERVE: armlab at (3184, 8544) facing 1 (id 91)
  0.17  RESERVE: zone 14 at (3112, 8544) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (3136, 8544) facing 1: 2 of 2 slots (group 10, zone)
  0.17  RESERVE: armlab at (3104, 8448) facing 1 (id 94)
  0.17  RESERVE: zone 15 at (3032, 8448) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (3056, 8448) facing 1: 2 of 2 slots (group 11, zone)
  0.17  RESERVE: corridor 16 at (3080, 8544) facing 1, 21x6 cells: 108 of 126 held
  0.17  RESERVE: zone 17 at (3080, 8448) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 17 at (3328, 8448) facing 1, 20x10 cells: 190 of 200 held
  0.17  RESERVE: armlab at (9648, 3968) facing 3 (id 119)
  0.17  RESERVE: zone 12 at (9720, 3968) facing 3, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (9696, 3968) facing 3: 2 of 2 slots (group 8, zone)
  0.17  RESERVE: corridor 13 at (9672, 4064) facing 3, 21x6 cells: 126 of 126 held
  0.17  RESERVE: zone 14 at (9672, 3968) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 14 at (9424, 3968) facing 3, 20x10 cells: 190 of 200 held
  0.23  EXP: approach: armcom(18473) at (11494, 1983) walks to (11576, 1804), 136 from the armmex site (11632, 1680)
  0.25  RESERVE: armalab at (1672, 8408) facing 1 (id 97)
  0.25  RESERVE: zone 18 at (1552, 8408) facing 1, 6x7 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (1600, 8408) facing 1: 4 of 4 slots (group 12, zone)
  0.25  RESERVE: zone 19 at (1624, 8408) facing 0, 15x9 cells: 12 of 135 held
  0.25  RESERVE: corridor 20 at (1920, 8408) facing 1, 20x13 cells: 242 of 260 held
  0.25  RESERVE: zone 21 at (2112, 9904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 9904) facing 0 (id 102)
  0.25  RESERVE: zone 22 at (2112, 9936) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 9936) facing 0 (id 103)
  0.25  RESERVE: zone 23 at (2112, 9968) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 9968) facing 0 (id 104)
  0.25  RESERVE: zone 24 at (2112, 10000) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10000) facing 0 (id 105)
  0.25  RESERVE: zone 25 at (2112, 10032) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10032) facing 0 (id 106)
  0.25  RESERVE: zone 26 at (2112, 10064) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10064) facing 0 (id 107)
  0.25  RESERVE: zone 27 at (2112, 10096) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10096) facing 0 (id 108)
  0.25  RESERVE: zone 28 at (2112, 10128) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10128) facing 0 (id 109)
  0.25  RESERVE: zone 29 at (2112, 10160) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10160) facing 0 (id 110)
  0.25  RESERVE: zone 30 at (2112, 10192) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10192) facing 0 (id 111)
  0.25  RESERVE: zone 31 at (2112, 10224) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10224) facing 0 (id 112)
  0.25  RESERVE: zone 32 at (2112, 10544) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10544) facing 0 (id 113)
  0.25  RESERVE: zone 33 at (2112, 10576) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10576) facing 0 (id 114)
  0.25  RESERVE: zone 34 at (2112, 10608) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10608) facing 0 (id 115)
  0.25  RESERVE: zone 35 at (2112, 10640) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10640) facing 0 (id 116)
  0.25  RESERVE: zone 36 at (2112, 10672) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10672) facing 0 (id 117)
  0.25  RESERVE: zone 37 at (2112, 10704) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10704) facing 0 (id 118)
  0.25  RESERVE: zone 38 at (2112, 10736) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10736) facing 0 (id 119)
  0.25  RESERVE: zone 39 at (2112, 10768) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10768) facing 0 (id 120)
  0.25  RESERVE: zone 40 at (2112, 10800) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10800) facing 0 (id 121)
  0.25  RESERVE: zone 41 at (2112, 10832) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10832) facing 0 (id 122)
  0.25  RESERVE: zone 42 at (2112, 10864) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2112, 10864) facing 0 (id 123)
  0.25  RESERVE: zone 43 at (2000, 10128) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armllt at (2000, 10128) facing 0 (id 124)
  0.25  RESERVE: zone 44 at (1992, 10648) facing 0, 3x3 cells: 9 of 9 held
  0.25  RESERVE: armrl at (1992, 10648) facing 0 (id 125)
  0.25  RESERVE: armalab at (10408, 4056) facing 3 (id 122)
  0.25  RESERVE: zone 15 at (10528, 4056) facing 3, 6x7 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (10480, 4056) facing 3: 4 of 4 slots (group 9, zone)
  0.25  RESERVE: zone 16 at (10456, 4056) facing 0, 15x9 cells: 12 of 135 held
  0.25  RESERVE: corridor 17 at (10160, 4056) facing 3, 20x13 cells: 245 of 260 held
  0.25  RESERVE: zone 18 at (10176, 2432) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (10176, 2432) facing 0 (id 127)
  0.25  RESERVE: zone 19 at (10176, 2400) facing 0, 2x2 cells: 4 of 4 held
```
