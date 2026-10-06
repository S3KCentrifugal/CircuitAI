# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 0.2 min (frame 420); wall 39 s
- DLL: build-theatres\d212-final\SkirmishAI.dll (f224e17dc3c6f798); AI BARbTest/test; staged 2026-10-06T02:24:01
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=TECH/cortex/test, 1=TECH/armada/test
- Team 0 (under test): skirmish AI 0, role TECH
- Checks: land-siege-production.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\land-siege-tech\glitters\20261006T052400Z-790757a5\runs\20261006T052444Z-79cbd348\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:28.069471][f=-000001] [RangedArena] frame=0 loaded case=land-siege-tech variant=ranged` |
| expect `spawn` | **missing** (by 1 min) | |
| expect `orders` | **missing** (by 2 min) | |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | **hit** | `[t=00:00:36.729060][f=0000300] [RangedArena] frame=300 ERROR unbuildable_spawn=corafus x=2600 z=1600` |

## Failures

- forbid 'fixture' hit at 0.2 min: [t=00:00:36.729060][f=0000300] [RangedArena] frame=300 ERROR unbuildable_spawn=corafus x=2600 z=1600
- forbid 'fixture' hit at 0.2 min: [t=00:00:36.729349][f=0000300] [RangedArena] frame=300 ERROR unbuildable_spawn=corafus x=2860 z=1600
- forbid 'fixture' hit at 0.2 min: [t=00:00:36.729623][f=0000300] [RangedArena] frame=300 ERROR unbuildable_spawn=corafus x=3120 z=1600
- forbid 'fixture' hit at 0.2 min: [t=00:00:36.729922][f=0000300] [RangedArena] frame=300 ERROR unbuildable_spawn=corafus x=3380 z=1600
- forbid 'fixture' hit at 0.2 min: [t=00:00:36.730196][f=0000300] [RangedArena] frame=300 ERROR unbuildable_spawn=corafus x=3640 z=1600
- forbid 'fixture' hit at 0.2 min: [t=00:00:36.730470][f=0000300] [RangedArena] frame=300 ERROR unbuildable_spawn=corafus x=3900 z=1600
- forbid 'fixture' hit at 0.2 min: [t=00:00:36.730772][f=0000300] [RangedArena] frame=300 ERROR unbuildable_spawn=corafus x=4160 z=1600
- forbid 'fixture' hit at 0.2 min: [t=00:00:36.731089][f=0000300] [RangedArena] frame=300 ERROR unbuildable_spawn=corafus x=4420 z=1600
- forbid 'fixture' hit at 0.2 min: [t=00:00:36.731388][f=0000300] [RangedArena] frame=300 ERROR unbuildable_spawn=corafus x=2600 z=1860
- forbid 'fixture' hit at 0.2 min: [t=00:00:36.731664][f=0000300] [RangedArena] frame=300 ERROR unbuildable_spawn=corafus x=2860 z=1860
- forbid 'fixture' hit at 0.2 min: [t=00:00:36.731957][f=0000300] [RangedArena] frame=300 ERROR unbuildable_spawn=corafus x=3120 z=1860
- forbid 'fixture' hit at 0.2 min: [t=00:00:36.732232][f=0000300] [RangedArena] frame=300 ERROR unbuildable_spawn=corafus x=3380 z=1860
- forbid 'fixture' hit at 0.2 min: [t=00:00:36.732505][f=0000300] [RangedArena] frame=300 ERROR unbuildable_spawn=corafus x=3640 z=1860
- forbid 'fixture' hit at 0.2 min: [t=00:00:36.732788][f=0000300] [RangedArena] frame=300 ERROR unbuildable_spawn=corafus x=3900 z=1860
- forbid 'fixture' hit at 0.2 min: [t=00:00:36.733065][f=0000300] [RangedArena] frame=300 ERROR unbuildable_spawn=corafus x=4160 z=1860
- forbid 'fixture' hit at 0.2 min: [t=00:00:36.733344][f=0000300] [RangedArena] frame=300 ERROR unbuildable_spawn=corafus x=4420 z=1860
- forbid 'fixture' hit at 0.2 min: [t=00:00:36.733619][f=0000300] [RangedArena] frame=300 ERROR unbuildable_spawn=corafus x=2600 z=2120
- forbid 'fixture' hit at 0.2 min: [t=00:00:36.733900][f=0000300] [RangedArena] frame=300 ERROR unbuildable_spawn=corafus x=2860 z=2120
- forbid 'fixture' hit at 0.2 min: [t=00:00:36.734242][f=0000300] [RangedArena] frame=300 ERROR unbuildable_spawn=corafus x=3120 z=2120
- forbid 'fixture' hit at 0.2 min: [t=00:00:36.734518][f=0000300] [RangedArena] frame=300 ERROR unbuildable_spawn=corafus x=3380 z=2120

## Screenshots

- none

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
  0.22  [Playtest] finished cormmkr team 0 at 0.22 min
  0.23  [Playtest] finished cormmkr team 0 at 0.22 min
  0.23  [Playtest] finished cormmkr team 0 at 0.23 min
  0.23  [Playtest] finished cormmkr team 0 at 0.23 min
  0.23  [Playtest] finished cormmkr team 0 at 0.23 min
  0.23  [Playtest] finished cormmkr team 0 at 0.23 min
  0.23  [Playtest] finished cormmkr team 0 at 0.23 min
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
```
