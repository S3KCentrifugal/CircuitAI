# Playtest report: PASS

- Verdict: **PASS** (reached 3 min)
- Game time reached: 3.0 min (frame 5430); wall 61 s
- DLL: build-theatres\d216\SkirmishAI.dll (fff6f12b014ad652); AI BARbTest/test; staged 2026-10-06T04:35:48
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=TECH/armada/test, 1=TECH/armada/test
- Team 0 (under test): skirmish AI 0, role TECH
- Checks: spam-repeat.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-repeat-tech\glitters\20261006T073547Z-7c951b68\runs\20261006T073652Z-ebb7416b\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `spawn` | seen at 0.2 min | `[t=00:00:36.597339][f=0000405] [RangedArena] frame=405 spawn id=13180 team=0 unit=armlab x=3400 z=3600` |
| expect `repeat` | seen at 0.7 min | `[t=00:00:39.788438][f=0001170] [RangedArena] frame=1170 factory id=8355 unit=armlab repeat=true builds=1 building=7961` |
| expect `offspring` | seen at 0.8 min | `[t=00:00:41.762049][f=0001489] [RangedArena] frame=1489 finished id=7961 team=0 unit=armpw cost=54` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-repeat-tech\glitters\20261006T073547Z-7c951b68\runs\20261006T073652Z-ebb7416b\screen_2026-10-06_07-36-33-627.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-repeat-tech\glitters\20261006T073547Z-7c951b68\runs\20261006T073652Z-ebb7416b\screen_2026-10-06_07-36-39-874.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-repeat-tech\glitters\20261006T073547Z-7c951b68\runs\20261006T073652Z-ebb7416b\screen_2026-10-06_07-36-47-867.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role TECH, team 0, speed 8, 0 shots, end at 3.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 3000/3000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4000, 2400) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 8
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4000, 2400) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [Layout] on for this AI
  0.08  [TECH][Opening] mexes within 700 elmos first (nearest 3); start factory held up to 240 s
  0.08  [TECH][Build] experimental build system on: direct range 1600, search radius 512
  0.08  [TECH][Opening] complete after 0 mexes, 0 s: the rush chain owns the opening; the lab is next
  0.08  [Layout] on for this AI
  0.08  [Layout] native factory pair committed facing 0, side offset 12 cells, forward offset 0 cells
  0.08  [Layout] home centre (3973, 2250), 148 from the start
  0.08  [Layout] turret box 40x44 cells at (3589, 2250), from the start rear 0, side -24, ground 96%, halo 94%: zone 7, 4 rows, 48 of 52 turret slots
  0.08  [Layout] advanced lab on the front line at (3829, 2674) facing 0, 0 cells ahead of turret row 0
  0.08  [Layout] the front is (3072, 5120): the labs face 0 (lane (3072, 5120), the pair faces 0)
  0.08  [Layout] advanced lab faces 0 (the pair faces 0)
  0.08  [Layout] advanced lab's footprint reserved at (3832, 2680), 451 from the home centre, 22 turret slots within reach, 7 flush (D-095)
  0.08  [Layout] forward cluster 40x44 cells at (3269, 3082), 8 cells ahead of the main cluster, ground 98%: zone 8, 4 rows, 48 turret slots
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.18  [Playtest] finished armafus team 0 at 0.18 min
  0.18  [Playtest] finished armafus team 0 at 0.18 min
  0.18  [Playtest] finished armafus team 0 at 0.18 min
  0.18  [Playtest] finished armafus team 0 at 0.18 min
  0.18  [Playtest] finished armmmkr team 0 at 0.18 min
  0.18  [Playtest] finished armmmkr team 0 at 0.18 min
  0.18  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.21  [Playtest] finished armmmkr team 0 at 0.21 min
  0.21  [Playtest] finished armmmkr team 0 at 0.21 min
  0.21  [Playtest] finished armmmkr team 0 at 0.21 min
  0.21  [Playtest] finished armmmkr team 0 at 0.21 min
  0.21  [Playtest] finished armmmkr team 0 at 0.21 min
  0.22  [Playtest] finished armalab team 0 at 0.22 min
  0.23  [Playtest] finished armlab team 0 at 0.22 min
  0.23  [Playtest] finished armlab team 0 at 0.23 min
  0.23  [Playtest] finished armlab team 0 at 0.23 min
  0.23  [TECH][Build] first lab's exit held (zone 16) until it is reclaimed
  0.23  [TECH][Build] advanced lab's exit held (zone 17)
  0.23  [Playtest] finished armnanotc team 0 at 0.23 min
  0.24  [TECH][Factory] armalab: T2 constructor 1 of 10 (bank 3208 of 3500) (D-103)
  0.24  [Playtest] finished armnanotc team 0 at 0.24 min
  0.25  [Layout] forward cluster at (3269, 3082) physically blocked before activation: recalculating
  0.25  [Layout] forward cluster 40x44 cells at (3589, 3274), 20 cells ahead of the main cluster, ground 89%: zone 45, 4 rows, 33 turret slots (re-plan 1)
  0.38  [Ferry] requested a transport (TECH at +20 metal, no transport)
  0.45  [TECH][Factory] combat production unlocked at +208.88 metal (gate 200)
  0.49  [TECH][Factory] armalab: T2 constructor 2 of 10 (bank 3500 of 3500) (D-103)
  0.73  [TECH][Factory] armalab: T2 constructor 3 of 10 (bank 3500 of 3500) (D-103)
  0.96  [TECH][Factory] armalab: T2 constructor 4 of 10 (bank 3500 of 3500) (D-103)
  1.00  [Playtest] eco team 0 at 1.0 min: metal +208.9 bank 3488/3500, energy +24114.0 bank 1066833/1073100, units 49
  1.18  [TECH][Factory] armalab: T2 constructor 5 of 10 (bank 3500 of 3500) (D-103)
  1.41  [TECH][Factory] armalab: T2 constructor 6 of 10 (bank 3500 of 3500) (D-103)
  1.65  [TECH][Factory] armalab: T2 constructor 7 of 10 (bank 3500 of 3500) (D-103)
  1.89  [TECH][Factory] armalab: T2 constructor 8 of 10 (bank 3500 of 3500) (D-103)
  2.00  [Playtest] eco team 0 at 2.0 min: metal +208.9 bank 3486/3500, energy +24170.0 bank 1067261/1073500, units 65
  2.11  [TECH][Factory] armalab: T2 constructor 9 of 10 (bank 3500 of 3500) (D-103)
  2.34  [TECH][Factory] armalab: T2 constructor 10 of 10 (bank 3500 of 3500) (D-103)
  3.00  [Playtest] eco team 0 at 3.0 min: metal +208.9 bank 3486/3500, energy +24236.0 bank 1067519/1073850, units 81
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 0
  0.08  RESERVE: zone 7 at (3589, 2107) facing 0, 77x63 cells: 4639 of 4851 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (3589, 2603) facing 0: 11 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (3589, 2555) facing 0: 11 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (3589, 2507) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (3589, 2459) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (3832, 2680) facing 0 (id 59)
  0.08  RESERVE: zone 8 at (3269, 3083) facing 0, 41x45 cells: 1813 of 1845 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (3269, 3435) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (3269, 3387) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (3269, 3339) facing 0: 11 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (3269, 3291) facing 0: 11 of 13 slots (group 6, held, zone)
  0.08  RESERVE: armlab at (4400, 3024) facing 0 (id 108)
  0.08  RESERVE: zone 9 at (4400, 2952) facing 0, 6x3 cells: 16 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (4400, 2976) facing 0: 1 of 2 slots (group 7, zone)
  0.08  RESERVE: zone 9 released
  0.08  RESERVE: armlab at (4528, 3056) facing 0 (id 110)
  0.08  RESERVE: zone 10 at (4528, 2984) facing 0, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (4528, 3008) facing 0: 2 of 2 slots (group 8, zone)
  0.08  RESERVE: corridor 11 at (4624, 3032) facing 0, 6x21 cells: 126 of 126 held
  0.08  RESERVE: zone 12 at (4528, 3032) facing 0, 6x9 cells: 0 of 54 held
  0.08  RESERVE: corridor 12 at (4528, 3280) facing 0, 10x20 cells: 190 of 200 held
  0.08  RESERVE: armlab at (3088, 8880) facing 2 (id 1)
  0.08  RESERVE: zone 1 at (3088, 8952) facing 2, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (3088, 8928) facing 2: 2 of 2 slots (group 1, zone)
  0.08  RESERVE: corridor 2 at (3184, 8904) facing 2, 6x21 cells: 114 of 126 held
  0.08  RESERVE: corridor 3 at (2992, 8904) facing 2, 6x21 cells: 126 of 126 held
  0.08  RESERVE: zone 4 at (3088, 8904) facing 0, 6x9 cells: 0 of 54 held
  0.08  RESERVE: corridor 4 at (3088, 8656) facing 2, 10x20 cells: 180 of 200 held
  0.17  RESERVE: armlab at (4000, 3024) facing 0 (id 113)
  0.17  RESERVE: zone 13 at (4000, 2952) facing 0, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (4000, 2976) facing 0: 2 of 2 slots (group 9, zone)
  0.17  RESERVE: corridor 14 at (4096, 3000) facing 0, 6x21 cells: 126 of 126 held
  0.17  RESERVE: zone 15 at (4000, 3000) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 15 at (4000, 3248) facing 0, 10x20 cells: 190 of 200 held
  0.17  RESERVE: armlab at (3968, 8784) facing 2 (id 4)
  0.17  RESERVE: zone 5 at (3968, 8856) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (3968, 8832) facing 2: 2 of 2 slots (group 2, zone)
  0.17  RESERVE: corridor 6 at (4064, 8808) facing 2, 6x21 cells: 126 of 126 held
  0.17  RESERVE: zone 7 at (3968, 8808) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 7 at (3968, 8560) facing 2, 10x20 cells: 190 of 200 held
  0.23  RESERVE: corridor 16 at (3400, 3808) facing 0, 11x20 cells: 165 of 220 held
  0.23  RESERVE: corridor 17 at (4400, 2032) facing 0, 14x20 cells: 206 of 280 held
  0.25  RESERVE: armalab at (4808, 3144) facing 0 (id 116)
  0.25  RESERVE: zone 18 at (4808, 3024) facing 0, 7x6 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (4808, 3072) facing 0: 4 of 4 slots (group 10, zone)
  0.25  RESERVE: zone 19 at (4808, 3096) facing 0, 9x15 cells: 12 of 135 held
  0.25  RESERVE: corridor 20 at (4808, 3392) facing 0, 13x20 cells: 260 of 260 held
  0.25  RESERVE: zone 21 at (4480, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4480, 3696) facing 0 (id 121)
  0.25  RESERVE: zone 22 at (4448, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4448, 3696) facing 0 (id 122)
  0.25  RESERVE: zone 23 at (4416, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4416, 3696) facing 0 (id 123)
  0.25  RESERVE: zone 24 at (4384, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4384, 3696) facing 0 (id 124)
  0.25  RESERVE: zone 25 at (4352, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4352, 3696) facing 0 (id 125)
  0.25  RESERVE: zone 26 at (4320, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4320, 3696) facing 0 (id 126)
  0.25  RESERVE: zone 27 at (4288, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4288, 3696) facing 0 (id 127)
  0.25  RESERVE: zone 28 at (4256, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4256, 3696) facing 0 (id 128)
  0.25  RESERVE: zone 29 at (4224, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4224, 3696) facing 0 (id 129)
  0.25  RESERVE: zone 30 at (4192, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4192, 3696) facing 0 (id 130)
  0.25  RESERVE: zone 31 at (4160, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4160, 3696) facing 0 (id 131)
  0.25  RESERVE: zone 32 at (3840, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3840, 3696) facing 0 (id 132)
  0.25  RESERVE: zone 33 at (3808, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3808, 3696) facing 0 (id 133)
  0.25  RESERVE: zone 34 at (3776, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3776, 3696) facing 0 (id 134)
  0.25  RESERVE: zone 35 at (3744, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3744, 3696) facing 0 (id 135)
  0.25  RESERVE: zone 36 at (3712, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3712, 3696) facing 0 (id 136)
  0.25  RESERVE: zone 37 at (3680, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3680, 3696) facing 0 (id 137)
  0.25  RESERVE: zone 38 at (3648, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3648, 3696) facing 0 (id 138)
  0.25  RESERVE: zone 39 at (3616, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3616, 3696) facing 0 (id 139)
  0.25  RESERVE: zone 40 at (3584, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3584, 3696) facing 0 (id 140)
  0.25  RESERVE: zone 41 at (3552, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3552, 3696) facing 0 (id 141)
  0.25  RESERVE: zone 42 at (3520, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3520, 3696) facing 0 (id 142)
  0.25  RESERVE: zone 43 at (4256, 3584) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armllt at (4256, 3584) facing 0 (id 143)
  0.25  RESERVE: zone 44 at (3752, 3576) facing 0, 3x3 cells: 9 of 9 held
  0.25  RESERVE: armrl at (3752, 3576) facing 0 (id 144)
  0.25  RESERVE: zone 8 released
  0.25  RESERVE: zone 45 at (3589, 3275) facing 0, 41x45 cells: 1668 of 1845 held
  0.25  RESERVE: grid of armnanotc 13x1 gap 0 behind (3589, 3627) facing 0: 6 of 13 slots (group 11, held, zone)
  0.25  RESERVE: grid of armnanotc 13x1 gap 0 behind (3589, 3579) facing 0: 6 of 13 slots (group 11, held, zone)
  0.25  RESERVE: grid of armnanotc 13x1 gap 0 behind (3589, 3531) facing 0: 8 of 13 slots (group 11, held, zone)
  0.25  RESERVE: grid of armnanotc 13x1 gap 0 behind (3589, 3483) facing 0: 13 of 13 slots (group 11, held, zone)
  0.25  RESERVE: armalab at (2760, 8904) facing 2 (id 7)
  0.25  RESERVE: zone 8 at (2760, 9024) facing 2, 7x6 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (2760, 8976) facing 2: 4 of 4 slots (group 3, zone)
  0.25  RESERVE: zone 9 at (2760, 8952) facing 0, 9x15 cells: 12 of 135 held
  0.25  RESERVE: corridor 10 at (2760, 8656) facing 2, 13x20 cells: 260 of 260 held
  0.25  RESERVE: zone 11 at (3520, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3520, 8496) facing 0 (id 12)
  0.25  RESERVE: zone 12 at (3552, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3552, 8496) facing 0 (id 13)
  0.25  RESERVE: zone 13 at (3584, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3584, 8496) facing 0 (id 14)
  0.25  RESERVE: zone 14 at (3616, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3616, 8496) facing 0 (id 15)
  0.25  RESERVE: zone 15 at (3648, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3648, 8496) facing 0 (id 16)
  0.25  RESERVE: zone 16 at (3680, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3680, 8496) facing 0 (id 17)
  0.25  RESERVE: zone 17 at (3712, 8496) facing 0, 2x2 cells: 4 of 4 held
```
