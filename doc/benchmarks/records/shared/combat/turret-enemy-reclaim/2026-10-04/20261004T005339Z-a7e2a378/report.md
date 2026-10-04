# Playtest report: PASS

- Verdict: **PASS** (reached 9 min)
- Game time reached: 9.5 min (frame 17100); wall 168 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\d184-build-2\SkirmishAI.dll (3ecbc2deecda41e7); AI BARbTest/test; staged 2026-10-03T21:48:02
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=TECH/armada/test, 1=TECH/armada/test
- Team 0 (under test): skirmish AI 0, role TECH
- Checks: turret_enemy_reclaim.json; widget loaded: yes
- Log: build-theatres\games\shared\combat\turret-enemy-reclaim\supreme\20261004T004801Z-a4de4c72\runs\20261004T005339Z-a7e2a378\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `fixture loaded` | seen at -0.0 min | `[t=00:00:38.013851][f=-000001] [TurretFixture] loaded supplied=1` |
| expect `all variants` | seen at 0.2 min | `[t=00:00:48.379553][f=0000300] [TurretFixture] sites=12` |
| expect `completed` | seen at 8.0 min | `[t=00:02:31.991328][f=0014400] [TurretFixture] complete variants=12 phases=6` |
| expect `native interrupt` | seen at 1.3 min | `[t=00:01:01.502365][f=0002266] Skirmish AI <BARb playtest-test>: [TurretReclaim] interrupt turret=19499 def=armnanotc target=3072` |
| expect `physical reclaim` | seen at 1.3 min | `[t=00:01:01.595592][f=0002280] [TurretFixture] physical_reclaim role=TECH nano=armnanotc hp=757` |
| expect `normal work resumes` | seen at 1.4 min | `[t=00:01:06.486703][f=0002475] [TurretFixture] resumed role=TECH nano=armnanotct2` |
| expect `lifecycle or legacy completion` | seen at 8.1 min | `[t=00:02:33.688799][f=0014655] [TurretFixture] lifecycle_complete` |
| forbid `fixture failure` | clean |  |
| forbid `fixture removed` | clean |  |
| forbid `script error` | clean |  |
| forbid `invariant` | clean |  |

## Screenshots

- build-theatres\games\shared\combat\turret-enemy-reclaim\supreme\20261004T004801Z-a4de4c72\runs\20261004T005339Z-a7e2a378\screen_2026-10-04_00-51-51-114.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role TECH, team 0, speed 5, 0 shots, end at 9.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 100000/100000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 41
  0.00  [Playtest] speed 5
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 41
  0.08  [Layout] on for this AI
  0.08  [TECH][Opening] mexes within 700 elmos first (nearest 3); start factory held up to 240 s
  0.08  [TECH][Build] experimental build system on: direct range 1600, search radius 512
  0.08  [TECH][Opening] complete after 0 mexes, 0 s: the rush chain owns the opening; the lab is next
  0.08  [Layout] on for this AI
  0.08  [Layout] native factory pair committed facing 1, side offset 8 cells, forward offset 4 cells
  0.08  [Layout] home centre (850, 10424), 24 from the start
  0.08  [Layout] turret box 40x44 cells at (850, 9752), from the start rear 0, side 42, ground 99%, halo 84%: zone 7, 4 rows, 52 of 52 turret slots
  0.08  [Layout] advanced lab on the front line at (1290, 9992) facing 1, 1 cells ahead of turret row 0
  0.08  [Layout] the front is (6144, 6144): the labs face 1 (lane (6144, 6144), the pair faces 1)
  0.08  [Layout] advanced lab faces 1 (the pair faces 1)
  0.08  [Layout] advanced lab's footprint reserved at (1288, 9992), 614 from the home centre, 18 turret slots within reach, 5 flush (D-095)
  0.08  [Layout] forward cluster 40x44 cells at (1682, 10072), 8 cells ahead of the main cluster, ground 78%: zone 8, 4 rows, 52 turret slots
  0.17  [Playtest] finished armnanotc team 0 at 0.17 min
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armnanotct2 team 0 at 0.17 min
  0.19  [Playtest] finished armafus team 0 at 0.19 min
  0.19  [Playtest] finished cornanotc team 0 at 0.19 min
  0.19  [Playtest] finished armafus team 0 at 0.19 min
  0.19  [Playtest] finished cornanotct2 team 0 at 0.19 min
  0.19  [Playtest] finished armafus team 0 at 0.19 min
  0.19  [Playtest] finished legnanotc team 0 at 0.19 min
  0.19  [Playtest] finished armafus team 0 at 0.19 min
  0.19  [Playtest] finished legnanotct2 team 0 at 0.19 min
  0.19  [Playtest] finished armafus team 0 at 0.19 min
  0.19  [Playtest] finished armnanotcplat team 0 at 0.19 min
  0.19  [Playtest] finished armuwfus team 0 at 0.19 min
  0.20  [Playtest] finished armnanotc2plat team 0 at 0.19 min
  0.20  [Playtest] finished armuwfus team 0 at 0.20 min
  0.20  [Playtest] finished cornanotcplat team 0 at 0.20 min
  0.20  [Playtest] finished armuwfus team 0 at 0.20 min
  0.20  [Playtest] finished cornanotc2plat team 0 at 0.20 min
  0.20  [Playtest] finished armuwfus team 0 at 0.20 min
  0.20  [Playtest] finished legnanotcplat team 0 at 0.20 min
  0.20  [Playtest] finished armuwfus team 0 at 0.20 min
  0.20  [Playtest] finished legnanotct2plat team 0 at 0.20 min
  0.20  [Playtest] finished armuwfus team 0 at 0.20 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 100000/100000, energy +25230.0 bank 169000/169000, units 25
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 100000/100000, energy +25230.0 bank 169000/169000, units 25
  2.17  [Layout] cleared for a role switch
  2.17  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  2.17  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armlab|837|10404|0|1|1|-1|-1
  2.18  [AIR][Growth] growth objective reached; completed AFUS=6
  2.18  [AIR][Capacity] own=2/25230 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.18  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=25230 bank=169000 pull=0 plants=0/0 aircraftDemand=0/0
  2.18  [AIR][Projects] energyQueued=0 committed=0/0
  2.18  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.18  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  2.18  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.18  [Layout] home centre (850, 10424), 24 from the start
  2.35  [AIR][Capacity] own=2/25230 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.35  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=25230 bank=169000 pull=0 plants=0/0 aircraftDemand=0/0
  2.35  [AIR][Projects] energyQueued=0 committed=0/0
  2.35  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.35  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  2.52  [AIR][Capacity] own=2/25230 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.52  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=25230 bank=169000 pull=0 plants=0/0 aircraftDemand=0/0
  2.52  [AIR][Projects] energyQueued=0 committed=0/0
  2.52  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.52  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  2.68  [AIR][Capacity] own=2/25230 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.68  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=25230 bank=169000 pull=0 plants=0/0 aircraftDemand=0/0
  2.68  [AIR][Projects] energyQueued=0 committed=0/0
  2.68  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.68  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  2.68  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.85  [AIR][Capacity] own=2/25230 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.85  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=25230 bank=169000 pull=0 plants=0/0 aircraftDemand=0/0
  2.85  [AIR][Projects] energyQueued=0 committed=0/0
  2.85  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.85  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 100000/100000, energy +25230.0 bank 169000/169000, units 25
  3.02  [AIR][Capacity] own=2/25230 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.02  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=25230 bank=169000 pull=0 plants=0/0 aircraftDemand=0/0
  3.02  [AIR][Projects] energyQueued=0 committed=0/0
  3.02  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  3.02  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  3.18  [AIR][Capacity] own=2/25230 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.18  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=25230 bank=169000 pull=0 plants=0/0 aircraftDemand=0/0
  3.18  [AIR][Projects] energyQueued=0 committed=0/0
  3.18  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  3.18  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  3.18  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.33  [Team][Roster] Re-announced: roster|1|0|0|FRONT|armada|armlab|837|10404|0|1|1|-1|-1
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 100000/100000, energy +25230.0 bank 169000/169000, units 25
  4.50  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armlab|837|10404|0|1|1|-1|-1
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 100000/100000, energy +25230.0 bank 169000/169000, units 25
  5.67  [Team][Roster] Re-announced: roster|1|0|0|TACTICAL|armada|armsy|837|10404|0|1|1|-1|-1
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 100000/100000, energy +25230.0 bank 169000/169000, units 25
  6.83  [Team][Roster] Re-announced: roster|1|0|0|SUPPORT|armada|armsy|837|10404|0|1|1|-1|-1
  7.00  [Playtest] eco team 0 at 7.0 min: metal +2.0 bank 100000/100000, energy +25230.0 bank 169000/169000, units 25
  8.00  [Playtest] eco team 0 at 8.0 min: metal +2.0 bank 100000/100000, energy +25230.0 bank 169000/169000, units 25
  9.00  [Playtest] eco team 0 at 9.0 min: metal +2.0 bank 100000/100000, energy +25237.0 bank 169050/169050, units 25
  9.50  [Playtest] end at 9.5 min: quitting
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 1
  0.08  RESERVE: zone 7 at (707, 9752) facing 1, 63x77 cells: 4484 of 4851 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1203, 9752) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1155, 9752) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1107, 9752) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1059, 9752) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (1288, 9992) facing 1 (id 63)
  0.08  RESERVE: zone 8 at (1683, 10072) facing 1, 45x41 cells: 1788 of 1845 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2035, 10072) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1987, 10072) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1939, 10072) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1891, 10072) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: armlab at (2064, 8464) facing 1 (id 116)
  0.08  RESERVE: zone 9 at (1992, 8464) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (2016, 8464) facing 1: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: armlab at (2352, 8384) facing 1 (id 119)
  0.08  RESERVE: zone 10 at (2280, 8384) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (2304, 8384) facing 1: 2 of 2 slots (group 8, zone)
  0.08  RESERVE: armlab at (2272, 8288) facing 1 (id 122)
  0.08  RESERVE: zone 11 at (2200, 8288) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (2224, 8288) facing 1: 2 of 2 slots (group 9, zone)
  0.08  RESERVE: corridor 12 at (2248, 8384) facing 1, 21x6 cells: 108 of 126 held
  0.08  RESERVE: zone 13 at (2248, 8288) facing 0, 9x6 cells: 0 of 54 held
  0.08  RESERVE: corridor 13 at (2496, 8288) facing 1, 20x10 cells: 190 of 200 held
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 3
  0.08  RESERVE: zone 7 at (11581, 2536) facing 3, 63x77 cells: 4444 of 4851 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (11085, 2536) facing 3: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (11133, 2536) facing 3: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (11181, 2536) facing 3: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (11229, 2536) facing 3: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (11000, 2296) facing 3 (id 63)
  0.08  RESERVE: zone 8 at (10605, 2216) facing 3, 45x41 cells: 1801 of 1845 held
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
  0.10  RESERVE: zone 1 released
  0.10  RESERVE: zone 2 released
  0.10  RESERVE: corridor 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 released
  0.10  RESERVE: corridor 6 released
  0.10  RESERVE: zone 7 released
  0.10  RESERVE: zone 8 released
  0.10  RESERVE: zone 9 released
  0.10  RESERVE: corridor 10 released
  0.10  RESERVE: corridor 11 released
  0.10  RESERVE: layout reset (118 reservations, 11 zones released)
  0.17  RESERVE: armlab at (3184, 8544) facing 1 (id 125)
  0.17  RESERVE: zone 14 at (3112, 8544) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (3136, 8544) facing 1: 2 of 2 slots (group 10, zone)
  0.17  RESERVE: armlab at (3104, 8448) facing 1 (id 128)
  0.17  RESERVE: zone 15 at (3032, 8448) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (3056, 8448) facing 1: 2 of 2 slots (group 11, zone)
  0.17  RESERVE: corridor 16 at (3080, 8544) facing 1, 21x6 cells: 108 of 126 held
  0.17  RESERVE: zone 17 at (3080, 8448) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 17 at (3328, 8448) facing 1, 20x10 cells: 190 of 200 held
  0.25  RESERVE: armalab at (1672, 8408) facing 1 (id 131)
  0.25  RESERVE: zone 18 at (1552, 8408) facing 1, 6x7 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (1600, 8408) facing 1: 4 of 4 slots (group 12, zone)
  0.25  RESERVE: zone 19 at (1624, 8408) facing 0, 15x9 cells: 12 of 135 held
  0.25  RESERVE: corridor 20 at (1920, 8408) facing 1, 20x13 cells: 242 of 260 held
  0.25  RESERVE: zone 21 at (2128, 9920) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2128, 9920) facing 0 (id 136)
  0.25  RESERVE: zone 22 at (2128, 9952) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2128, 9952) facing 0 (id 137)
  0.25  RESERVE: zone 23 at (2128, 9984) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2128, 9984) facing 0 (id 138)
  0.25  RESERVE: zone 24 at (2128, 10016) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2128, 10016) facing 0 (id 139)
  0.25  RESERVE: zone 25 at (2128, 10048) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2128, 10048) facing 0 (id 140)
  0.25  RESERVE: zone 26 at (2128, 10080) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2128, 10080) facing 0 (id 141)
  0.25  RESERVE: zone 27 at (2128, 10112) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2128, 10112) facing 0 (id 142)
  0.25  RESERVE: zone 28 at (2128, 10144) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2128, 10144) facing 0 (id 143)
  0.25  RESERVE: zone 29 at (2128, 10176) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2128, 10176) facing 0 (id 144)
  0.25  RESERVE: zone 30 at (2128, 10208) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2128, 10208) facing 0 (id 145)
  0.25  RESERVE: zone 31 at (2128, 10240) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2128, 10240) facing 0 (id 146)
  0.25  RESERVE: zone 32 at (2128, 10560) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2128, 10560) facing 0 (id 147)
  0.25  RESERVE: zone 33 at (2128, 10592) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2128, 10592) facing 0 (id 148)
  0.25  RESERVE: zone 34 at (2128, 10624) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2128, 10624) facing 0 (id 149)
  0.25  RESERVE: zone 35 at (2128, 10656) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2128, 10656) facing 0 (id 150)
  0.25  RESERVE: zone 36 at (2128, 10688) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2128, 10688) facing 0 (id 151)
  0.25  RESERVE: zone 37 at (2128, 10720) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2128, 10720) facing 0 (id 152)
  0.25  RESERVE: zone 38 at (2128, 10752) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2128, 10752) facing 0 (id 153)
  0.25  RESERVE: zone 39 at (2128, 10784) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2128, 10784) facing 0 (id 154)
  0.25  RESERVE: zone 40 at (2128, 10816) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2128, 10816) facing 0 (id 155)
  0.25  RESERVE: zone 41 at (2128, 10848) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2128, 10848) facing 0 (id 156)
  0.25  RESERVE: zone 42 at (2128, 10880) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (2128, 10880) facing 0 (id 157)
  0.25  RESERVE: zone 43 at (2024, 10664) facing 0, 3x3 cells: 9 of 9 held
  0.25  RESERVE: armrl at (2024, 10664) facing 0 (id 158)
  0.33  RESERVE: armalab at (2088, 8056) facing 1 (id 159)
  0.33  RESERVE: zone 44 at (1968, 8056) facing 1, 6x7 cells: 42 of 42 held
  0.33  RESERVE: grid of armnanotc 2x2 gap 0 behind (2016, 8056) facing 1: 4 of 4 slots (group 13, zone)
  0.33  RESERVE: zone 45 at (2040, 8056) facing 0, 15x9 cells: 12 of 135 held
  0.33  RESERVE: corridor 46 at (2336, 8056) facing 1, 20x13 cells: 244 of 260 held
  0.42  RESERVE: armshltx at (2880, 10768) facing 1 (id 164)
```
