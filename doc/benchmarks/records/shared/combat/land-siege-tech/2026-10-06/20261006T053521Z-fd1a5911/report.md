# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 1.0 min (frame 1803); wall 44 s
- DLL: build-theatres\d212-final\SkirmishAI.dll (f224e17dc3c6f798); AI BARbTest/test; staged 2026-10-06T02:34:33
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=TECH/cortex/test, 1=TECH/armada/test
- Team 0 (under test): skirmish AI 0, role TECH
- Checks: land-siege-production.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\land-siege-tech\glitters\20261006T053432Z-b007ff41\runs\20261006T053521Z-fd1a5911\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:27.699748][f=-000001] [RangedArena] frame=0 loaded case=land-siege-tech variant=ranged` |
| expect `spawn` | **missing** (by 2 min) | |
| expect `orders` | seen at 0.3 min | `[t=00:00:37.581119][f=0000600] [RangedArena] frame=600 orders team=0 total=296 nonlua=296 lua=0` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-047 a structure stands on a T3 lane of spam row 2` |
| forbid `fixture` | clean |  |

## Failures

- forbid 'invariant' hit at 1.0 min: [INVARIANT] INV-047 a structure stands on a T3 lane of spam row 2

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\land-siege-tech\glitters\20261006T053432Z-b007ff41\runs\20261006T053521Z-fd1a5911\screen_2026-10-06_05-35-20-429.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role TECH, team 0, speed 8, 0 shots, end at 5.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished corcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000000/1000000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side cortex ai true dead false start (4000, 2400) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 8
  0.05  [Playtest] frame 90 team 0 ally 0 side cortex ai true dead false start (4000, 2400) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [Layout] on for this AI
  0.08  [TECH][Opening] mexes within 700 elmos first (nearest 3); start factory held up to 240 s
  0.08  [TECH][Build] experimental build system on: direct range 1600, search radius 512
  0.08  [TECH][Opening] complete after 0 mexes, 0 s: the rush chain owns the opening; the lab is next
  0.08  [Layout] on for this AI
  0.08  [Layout] native factory pair committed facing 0, side offset 12 cells, forward offset 0 cells
  0.08  [Layout] home centre (3973, 2250), 152 from the start
  0.08  [Layout] turret box 40x44 cells at (3589, 2250), from the start rear 0, side -24, ground 96%, halo 94%: zone 7, 4 rows, 48 of 52 turret slots
  0.08  [Layout] advanced lab on the front line at (3829, 2674) facing 0, 0 cells ahead of turret row 0
  0.08  [Layout] the front is (3072, 5120): the labs face 0 (lane (3072, 5120), the pair faces 0)
  0.08  [Layout] advanced lab faces 0 (the pair faces 0)
  0.08  [Layout] advanced lab's footprint reserved at (3832, 2680), 451 from the home centre, 22 turret slots within reach, 7 flush (D-095)
  0.08  [Layout] forward cluster 40x44 cells at (3269, 3082), 8 cells ahead of the main cluster, ground 98%: zone 8, 4 rows, 48 turret slots
  0.17  [Playtest] finished armarad team 0 at 0.17 min
  0.17  [Playtest] finished armeyes team 0 at 0.17 min
  0.17  [Playtest] finished armeyes team 0 at 0.17 min
  0.17  [Playtest] finished armeyes team 0 at 0.17 min
  0.17  [Playtest] finished armeyes team 0 at 0.17 min
  0.18  [Playtest] finished armeyes team 0 at 0.18 min
  0.18  [Playtest] finished armeyes team 0 at 0.18 min
  0.18  [Playtest] finished armeyes team 0 at 0.18 min
  0.18  [Playtest] finished armeyes team 0 at 0.18 min
  0.22  [Playtest] finished corafus team 0 at 0.22 min
  0.23  [Playtest] finished corafus team 0 at 0.22 min
  0.23  [Playtest] finished corafus team 0 at 0.23 min
  0.23  [Playtest] finished corafus team 0 at 0.23 min
  0.23  [Playtest] finished corafus team 0 at 0.23 min
  0.23  [Playtest] finished corafus team 0 at 0.23 min
  0.23  [Playtest] finished corafus team 0 at 0.23 min
  0.23  [Playtest] finished corafus team 0 at 0.23 min
  0.24  [Playtest] finished corafus team 0 at 0.24 min
  0.24  [Playtest] finished corafus team 0 at 0.24 min
  0.24  [Playtest] finished cormmkr team 0 at 0.24 min
  0.24  [Playtest] finished cormmkr team 0 at 0.24 min
  0.24  [Playtest] finished cormmkr team 0 at 0.24 min
  0.24  [Playtest] finished cormmkr team 0 at 0.25 min
  0.25  [Playtest] finished cormmkr team 0 at 0.25 min
  0.25  [Playtest] finished cormmkr team 0 at 0.25 min
  0.25  [Playtest] finished cormmkr team 0 at 0.25 min
  0.25  [Layout] forward cluster at (3269, 3082) physically blocked before activation: recalculating
  0.25  [Layout] forward cluster 40x44 cells at (3269, 3274), 20 cells ahead of the main cluster, ground 98%: zone 43, 4 rows, 52 turret slots (re-plan 1)
  0.25  [Playtest] finished cormmkr team 0 at 0.25 min
  0.26  [Playtest] finished cormmkr team 0 at 0.25 min
  0.26  [Playtest] finished cormmkr team 0 at 0.26 min
  0.26  [Playtest] finished cormmkr team 0 at 0.26 min
  0.26  [Playtest] finished cormmkr team 0 at 0.26 min
  0.26  [Playtest] finished cormmkr team 0 at 0.26 min
  0.26  [Playtest] finished cormmkr team 0 at 0.26 min
  0.27  [Playtest] finished cormmkr team 0 at 0.26 min
  0.27  [Playtest] finished cormmkr team 0 at 0.27 min
  0.27  [Playtest] finished cormmkr team 0 at 0.27 min
  0.27  [Playtest] finished cormmkr team 0 at 0.27 min
  0.27  [Playtest] finished cormmkr team 0 at 0.27 min
  0.27  [Playtest] finished cormmkr team 0 at 0.27 min
  0.28  [Playtest] finished cormmkr team 0 at 0.28 min
  0.28  [Playtest] finished cormmkr team 0 at 0.28 min
  0.28  [Playtest] finished cormmkr team 0 at 0.28 min
  0.28  [Playtest] finished cormmkr team 0 at 0.28 min
  0.28  [Playtest] finished cormmkr team 0 at 0.28 min
  0.28  [Playtest] finished cormmkr team 0 at 0.28 min
  0.28  [Playtest] finished cormmkr team 0 at 0.28 min
  0.29  [Playtest] finished cormmkr team 0 at 0.29 min
  0.29  [Playtest] finished cormmkr team 0 at 0.29 min
  0.29  [Playtest] finished cormmkr team 0 at 0.29 min
  0.29  [Playtest] finished cormmkr team 0 at 0.29 min
  0.29  [Playtest] finished cormmkr team 0 at 0.29 min
  0.29  [Playtest] finished cormmkr team 0 at 0.29 min
  0.30  [Playtest] finished cormmkr team 0 at 0.30 min
  0.30  [Playtest] finished cormmkr team 0 at 0.30 min
  0.30  [Playtest] finished cormmkr team 0 at 0.30 min
  0.30  [Playtest] finished cormmkr team 0 at 0.30 min
  0.30  [Playtest] finished cormmkr team 0 at 0.30 min
  0.30  [Playtest] finished cormmkr team 0 at 0.31 min
  0.31  [Playtest] finished cormmkr team 0 at 0.31 min
  0.31  [Playtest] finished cormmkr team 0 at 0.31 min
  0.31  [Playtest] finished cormmkr team 0 at 0.31 min
  0.31  [Playtest] finished cormmkr team 0 at 0.31 min
  0.31  [Playtest] finished cormmkr team 0 at 0.31 min
  0.32  [Playtest] finished cormmkr team 0 at 0.31 min
  0.32  [Playtest] finished cormmkr team 0 at 0.32 min
  0.32  [Playtest] finished cormmkr team 0 at 0.32 min
  0.32  [Playtest] finished cormmkr team 0 at 0.32 min
  0.32  [Playtest] finished cormmkr team 0 at 0.32 min
  0.32  [Playtest] finished cormmkr team 0 at 0.32 min
  0.33  [Playtest] finished cormmkr team 0 at 0.33 min
  0.33  [Playtest] finished cormmkr team 0 at 0.33 min
  0.33  [Playtest] finished cormmkr team 0 at 0.33 min
  0.33  [Playtest] finished cormmkr team 0 at 0.33 min
  0.33  [Playtest] finished cormmkr team 0 at 0.33 min
  0.33  [Playtest] finished cormmkr team 0 at 0.33 min
  0.34  [Playtest] finished cormmkr team 0 at 0.34 min
  0.34  [Playtest] finished cormmkr team 0 at 0.34 min
  0.34  [Playtest] finished cormmkr team 0 at 0.34 min
  0.34  [Playtest] finished cormmkr team 0 at 0.34 min
  0.34  [Playtest] finished cormmkr team 0 at 0.34 min
  0.35  [Playtest] finished cormmkr team 0 at 0.35 min
  0.35  [Playtest] finished cormmkr team 0 at 0.35 min
  0.35  [Playtest] finished cormmkr team 0 at 0.35 min
  0.42  [Layout] forward cluster at (3269, 3274) physically blocked before activation: recalculating
  0.42  [Layout] forward cluster 40x44 cells at (3269, 3466), 32 cells ahead of the main cluster, ground 84%: zone 74, 4 rows, 48 turret slots (re-plan 2)
  0.45  [Ferry] requested a transport (TECH at +20 metal, no transport)
  0.48  [TECH][Build] the economy is online (+287 metal): no lab is reclaimed for metal from now on (D-102, D-105)
  0.48  [TECH][Factory] combat production unlocked at +287.494 metal (gate 200)
  1.00  [Playtest] eco team 0 at 1.0 min: metal +518.6 bank 1000000/1000000, energy +30070.0 bank 832633/1090200, units 86
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 0
  0.08  RESERVE: zone 7 at (3589, 2107) facing 0, 77x63 cells: 4639 of 4851 held
  0.08  RESERVE: grid of cornanotc 13x1 gap 0 behind (3589, 2603) facing 0: 11 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of cornanotc 13x1 gap 0 behind (3589, 2555) facing 0: 11 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of cornanotc 13x1 gap 0 behind (3589, 2507) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of cornanotc 13x1 gap 0 behind (3589, 2459) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: coralab at (3832, 2680) facing 0 (id 59)
  0.08  RESERVE: zone 8 at (3269, 3083) facing 0, 41x45 cells: 1813 of 1845 held
  0.08  RESERVE: grid of cornanotc 13x1 gap 0 behind (3269, 3435) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of cornanotc 13x1 gap 0 behind (3269, 3387) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of cornanotc 13x1 gap 0 behind (3269, 3339) facing 0: 11 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of cornanotc 13x1 gap 0 behind (3269, 3291) facing 0: 11 of 13 slots (group 6, held, zone)
  0.08  RESERVE: corlab at (4400, 3024) facing 0 (id 108)
  0.08  RESERVE: zone 9 at (4400, 2952) facing 0, 6x3 cells: 16 of 18 held
  0.08  RESERVE: grid of cornanotc 2x1 gap 0 behind (4400, 2976) facing 0: 1 of 2 slots (group 7, zone)
  0.08  RESERVE: zone 9 released
  0.08  RESERVE: corlab at (4528, 3056) facing 0 (id 110)
  0.08  RESERVE: zone 10 at (4528, 2984) facing 0, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of cornanotc 2x1 gap 0 behind (4528, 3008) facing 0: 2 of 2 slots (group 8, zone)
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
  0.17  RESERVE: corlab at (4000, 3024) facing 0 (id 113)
  0.17  RESERVE: zone 13 at (4000, 2952) facing 0, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of cornanotc 2x1 gap 0 behind (4000, 2976) facing 0: 2 of 2 slots (group 9, zone)
  0.17  RESERVE: corridor 14 at (4096, 3000) facing 0, 6x21 cells: 126 of 126 held
  0.17  RESERVE: zone 15 at (4000, 3000) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 15 at (4000, 3248) facing 0, 10x20 cells: 190 of 200 held
  0.17  RESERVE: armlab at (3968, 8784) facing 2 (id 4)
  0.17  RESERVE: zone 5 at (3968, 8856) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (3968, 8832) facing 2: 2 of 2 slots (group 2, zone)
  0.17  RESERVE: corridor 6 at (4064, 8808) facing 2, 6x21 cells: 126 of 126 held
  0.17  RESERVE: zone 7 at (3968, 8808) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 7 at (3968, 8560) facing 2, 10x20 cells: 190 of 200 held
  0.25  RESERVE: coralab at (4808, 3144) facing 0 (id 116)
  0.25  RESERVE: zone 16 at (4808, 3024) facing 0, 7x6 cells: 42 of 42 held
  0.25  RESERVE: grid of cornanotc 2x2 gap 0 behind (4808, 3072) facing 0: 4 of 4 slots (group 10, zone)
  0.25  RESERVE: zone 17 at (4808, 3096) facing 0, 9x15 cells: 12 of 135 held
  0.25  RESERVE: corridor 18 at (4808, 3392) facing 0, 13x20 cells: 260 of 260 held
  0.25  RESERVE: zone 19 at (4480, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (4480, 3696) facing 0 (id 121)
  0.25  RESERVE: zone 20 at (4448, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (4448, 3696) facing 0 (id 122)
  0.25  RESERVE: zone 21 at (4416, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (4416, 3696) facing 0 (id 123)
  0.25  RESERVE: zone 22 at (4384, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (4384, 3696) facing 0 (id 124)
  0.25  RESERVE: zone 23 at (4352, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (4352, 3696) facing 0 (id 125)
  0.25  RESERVE: zone 24 at (4320, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (4320, 3696) facing 0 (id 126)
  0.25  RESERVE: zone 25 at (4288, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (4288, 3696) facing 0 (id 127)
  0.25  RESERVE: zone 26 at (4256, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (4256, 3696) facing 0 (id 128)
  0.25  RESERVE: zone 27 at (4224, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (4224, 3696) facing 0 (id 129)
  0.25  RESERVE: zone 28 at (4192, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (4192, 3696) facing 0 (id 130)
  0.25  RESERVE: zone 29 at (4160, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (4160, 3696) facing 0 (id 131)
  0.25  RESERVE: zone 30 at (3840, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (3840, 3696) facing 0 (id 132)
  0.25  RESERVE: zone 31 at (3808, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (3808, 3696) facing 0 (id 133)
  0.25  RESERVE: zone 32 at (3776, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (3776, 3696) facing 0 (id 134)
  0.25  RESERVE: zone 33 at (3744, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (3744, 3696) facing 0 (id 135)
  0.25  RESERVE: zone 34 at (3712, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (3712, 3696) facing 0 (id 136)
  0.25  RESERVE: zone 35 at (3680, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (3680, 3696) facing 0 (id 137)
  0.25  RESERVE: zone 36 at (3648, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (3648, 3696) facing 0 (id 138)
  0.25  RESERVE: zone 37 at (3616, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (3616, 3696) facing 0 (id 139)
  0.25  RESERVE: zone 38 at (3584, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (3584, 3696) facing 0 (id 140)
  0.25  RESERVE: zone 39 at (3552, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (3552, 3696) facing 0 (id 141)
  0.25  RESERVE: zone 40 at (3520, 3696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (3520, 3696) facing 0 (id 142)
  0.25  RESERVE: zone 41 at (4256, 3584) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: corllt at (4256, 3584) facing 0 (id 143)
  0.25  RESERVE: zone 42 at (3736, 3592) facing 0, 3x3 cells: 9 of 9 held
  0.25  RESERVE: corrl at (3736, 3592) facing 0 (id 144)
  0.25  RESERVE: zone 8 released
  0.25  RESERVE: zone 43 at (3269, 3275) facing 0, 41x45 cells: 1817 of 1845 held
  0.25  RESERVE: grid of cornanotc 13x1 gap 0 behind (3269, 3627) facing 0: 13 of 13 slots (group 11, held, zone)
  0.25  RESERVE: grid of cornanotc 13x1 gap 0 behind (3269, 3579) facing 0: 13 of 13 slots (group 11, held, zone)
  0.25  RESERVE: grid of cornanotc 13x1 gap 0 behind (3269, 3531) facing 0: 13 of 13 slots (group 11, held, zone)
  0.25  RESERVE: grid of cornanotc 13x1 gap 0 behind (3269, 3483) facing 0: 13 of 13 slots (group 11, held, zone)
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
  0.25  RESERVE: armdrag at (3712, 8496) facing 0 (id 18)
  0.25  RESERVE: zone 18 at (3744, 8496) facing 0, 2x2 cells: 4 of 4 held
```
