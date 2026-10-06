# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 8.0 min (frame 14400); wall 81 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (d11e654d41abebfb); AI BARbTest/test; staged 2026-10-05T21:51:32
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea-recovery-priorities.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\priorities\supreme\20261006T005131Z-22a58d8a\runs\20261006T005302Z-2b792f67\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:35.653228][f=-000001] [SeaRecoveryTest] loaded teams=2 fixture=true` |
| expect `reclaim` | seen at 0.3 min | `[t=00:00:46.068367][f=0000510] [SeaRecoveryTest] PASS reclaim` |
| expect `flagship-repair` | seen at 0.5 min | `[t=00:00:46.679908][f=0000870] [SeaRecoveryTest] PASS flagship-repair` |
| expect `resurrect` | seen at 1.9 min | `[t=00:00:52.057412][f=0003330] [SeaRecoveryTest] PASS resurrect` |
| expect `ordinary-repair` | seen at 5.3 min | `[t=00:01:04.863496][f=0009600] [SeaRecoveryTest] PASS ordinary-repair` |
| expect `t1-producing` | seen at 4.3 min | `[t=00:01:00.442460][f=0007658] [SeaRecoveryTest] PASS t1-producing` |
| expect `t2-producing` | seen at 4.8 min | `[t=00:01:02.182524][f=0008643] [SeaRecoveryTest] PASS t2-producing` |
| expect `platform-producing` | seen at 4.7 min | `[t=00:01:01.776187][f=0008417] [SeaRecoveryTest] PASS platform-producing` |
| expect `sub-scaling` | seen at 5.0 min | `[t=00:01:02.808757][f=0009000] [SeaRecoveryTest] PASS sub-scaling` |
| forbid `errors` | **hit** | `[t=00:00:59.575096][f=0007200] [SeaRecoveryTest] FAIL dry fixture armcs` |

## Failures

- forbid 'errors' hit at 4.0 min: [t=00:00:59.575096][f=0007200] [SeaRecoveryTest] FAIL dry fixture armcs
- forbid 'errors' hit at 4.0 min: [t=00:00:59.575117][f=0007200] [SeaRecoveryTest] FAIL dry fixture armnanotcplat
- forbid 'errors' hit at 4.0 min: [t=00:00:59.575135][f=0007200] [SeaRecoveryTest] FAIL dry fixture armnanotcplat
- forbid 'errors' hit at 4.0 min: [t=00:00:59.575151][f=0007200] [SeaRecoveryTest] FAIL dry fixture armnanotcplat

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\priorities\supreme\20261006T005131Z-22a58d8a\runs\20261006T005302Z-2b792f67\screen_2026-10-06_00-52-31-186.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\priorities\supreme\20261006T005131Z-22a58d8a\runs\20261006T005302Z-2b792f67\screen_2026-10-06_00-52-35-947.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\priorities\supreme\20261006T005131Z-22a58d8a\runs\20261006T005302Z-2b792f67\screen_2026-10-06_00-52-46-242.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\priorities\supreme\20261006T005131Z-22a58d8a\runs\20261006T005302Z-2b792f67\screen_2026-10-06_00-52-53-615.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 20, 4 shots, end at 8.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 0/1000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (5800, 10500) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (11500, 7500) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 29
  0.00  [Playtest] speed 20
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (5800, 10500) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (11500, 7500) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 29
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.18  [Playtest] finished armepoch team 0 at 0.18 min
  0.80  [Playtest] camera requested (6200,10700) height=2200
  0.81  [Playtest] camera captured name=ta position=(6200,10700) height=2200
  0.81  [Playtest] screenshot at 0.8 min of team 0 at (6200, 10700)
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 557/1000, energy +30.0 bank 1000000/1000000, units 4
  1.00  [Playtest] finished armuwmmm team 0 at 1.00 min
  1.00  [Playtest] finished armuwmmm team 0 at 1.00 min
  1.00  [Playtest] finished armuwmmm team 0 at 1.00 min
  1.00  [Playtest] finished armuwmmm team 0 at 1.00 min
  1.00  [Playtest] finished armuwmmm team 0 at 1.00 min
  1.00  [Playtest] finished armuwmmm team 0 at 1.00 min
  1.00  [Playtest] finished armuwmmm team 0 at 1.00 min
  1.00  [Playtest] finished armuwmmm team 0 at 1.00 min
  1.00  [Playtest] finished armuwmmm team 0 at 1.00 min
  1.00  [Playtest] finished armuwmmm team 0 at 1.00 min
  1.00  [Playtest] finished armuwmmm team 0 at 1.00 min
  1.00  [Playtest] finished armuwmmm team 0 at 1.00 min
  1.00  [Playtest] finished armuwfus team 0 at 1.00 min
  1.00  [Playtest] finished armuwfus team 0 at 1.00 min
  1.00  [Playtest] finished armuwfus team 0 at 1.00 min
  1.00  [Playtest] finished armuwfus team 0 at 1.00 min
  1.00  [Playtest] finished armuwfus team 0 at 1.00 min
  1.00  [Playtest] finished armuwfus team 0 at 1.00 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +126.1 bank 1000/1000, energy +7230.0 bank 1004907/1015000, units 22
  2.00  [Playtest] camera requested (6200,10700) height=2200
  2.01  [Playtest] camera captured name=ta position=(6200,10700) height=2200
  2.01  [Playtest] screenshot at 2.0 min of team 0 at (6200, 10700)
  3.00  [Playtest] eco team 0 at 3.0 min: metal +126.1 bank 1000/1000, energy +7230.0 bank 1003868/1015000, units 23
  4.00  [Playtest] eco team 0 at 4.0 min: metal +126.1 bank 1000/1000, energy +7230.0 bank 1003671/1015000, units 23
  4.00  [Playtest] finished armsy team 0 at 4.00 min
  4.00  [Playtest] finished armasy team 0 at 4.00 min
  4.00  [Playtest] finished armplat team 0 at 4.00 min
  4.00  [Playtest] finished armnanotcplat team 0 at 4.00 min
  4.35  [SEA][Layout] berth sea.berth.0 armasy at=8976,10608 facing=1
  4.70  [SEA][Layout] berth sea.berth.1 armplat at=8976,10208 facing=1
  5.00  [Playtest] eco team 0 at 5.0 min: metal +126.1 bank 1296/1300, energy +7604.0 bank 979487/1017400, units 38
  5.00  [Playtest] camera requested (6500,10800) height=2800
  5.01  [Playtest] camera captured name=ta position=(6500,10800) height=2800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (6500, 10800)
  6.00  [Playtest] eco team 0 at 6.0 min: metal +126.1 bank 1281/1300, energy +7604.0 bank 970144/1017400, units 46
  7.00  [Playtest] eco team 0 at 7.0 min: metal +126.1 bank 1292/1300, energy +7604.0 bank 936569/1017400, units 50
  7.00  [Playtest] camera requested (6500,10800) height=3500
  7.02  [Playtest] camera captured name=ta position=(6500,10800) height=3500
  7.02  [Playtest] screenshot at 7.0 min of team 0 at (6500, 10800)
  8.00  [Playtest] eco team 0 at 8.0 min: metal +126.1 bank 1297/1300, energy +7604.0 bank 905860/1017400, units 54
```

## Native lines (all AIs, first 120)

```
  4.02  RESERVE: zone 1 at (6936, 10600) facing 1, 3x3 cells: 9 of 9 held
  4.02  RESERVE: armnanotcplat at (6936, 10600) facing 1 (id 1)
  4.02  RESERVE: zone 2 at (6936, 10552) facing 1, 3x3 cells: 9 of 9 held
  4.02  RESERVE: armnanotcplat at (6936, 10552) facing 1 (id 2)
  4.02  RESERVE: zone 3 at (6936, 10504) facing 1, 3x3 cells: 9 of 9 held
  4.02  RESERVE: armnanotcplat at (6936, 10504) facing 1 (id 3)
  4.02  RESERVE: zone 4 at (6936, 10456) facing 1, 3x3 cells: 9 of 9 held
  4.02  RESERVE: armnanotcplat at (6936, 10456) facing 1 (id 4)
  4.02  RESERVE: zone 5 at (6936, 10408) facing 1, 3x3 cells: 9 of 9 held
  4.02  RESERVE: armnanotcplat at (6936, 10408) facing 1 (id 5)
  4.02  RESERVE: zone 6 at (6984, 10600) facing 1, 3x3 cells: 9 of 9 held
  4.02  RESERVE: armnanotcplat at (6984, 10600) facing 1 (id 6)
  4.02  RESERVE: zone 7 at (6984, 10552) facing 1, 3x3 cells: 9 of 9 held
  4.02  RESERVE: armnanotcplat at (6984, 10552) facing 1 (id 7)
  4.02  RESERVE: zone 8 at (6984, 10504) facing 1, 3x3 cells: 9 of 9 held
  4.02  RESERVE: armnanotcplat at (6984, 10504) facing 1 (id 8)
  4.02  RESERVE: zone 9 at (6984, 10456) facing 1, 3x3 cells: 9 of 9 held
  4.02  RESERVE: armnanotcplat at (6984, 10456) facing 1 (id 9)
  4.02  RESERVE: zone 10 at (6984, 10408) facing 1, 3x3 cells: 9 of 9 held
  4.02  RESERVE: armnanotcplat at (6984, 10408) facing 1 (id 10)
  4.02  RESERVE: zone 1 released
  4.02  RESERVE: zone 2 released
  4.02  RESERVE: zone 3 released
  4.02  RESERVE: zone 4 released
  4.02  RESERVE: zone 5 released
  4.02  RESERVE: zone 6 released
  4.02  RESERVE: zone 7 released
  4.02  RESERVE: zone 8 released
  4.02  RESERVE: zone 9 released
  4.02  RESERVE: zone 10 released
  4.02  RESERVE: zone 11 at (6904, 10552) facing 1, 3x3 cells: 9 of 9 held
  4.02  RESERVE: armnanotcplat at (6904, 10552) facing 1 (id 11)
  4.02  RESERVE: zone 12 at (6904, 10504) facing 1, 3x3 cells: 9 of 9 held
  4.02  RESERVE: armnanotcplat at (6904, 10504) facing 1 (id 12)
  4.02  RESERVE: zone 13 at (6904, 10456) facing 1, 3x3 cells: 9 of 9 held
  4.02  RESERVE: armnanotcplat at (6904, 10456) facing 1 (id 13)
  4.02  RESERVE: zone 14 at (6904, 10408) facing 1, 3x3 cells: 9 of 9 held
  4.02  RESERVE: armnanotcplat at (6904, 10408) facing 1 (id 14)
  4.02  RESERVE: zone 11 released
  4.02  RESERVE: zone 12 released
  4.02  RESERVE: zone 13 released
  4.02  RESERVE: zone 14 released
  4.02  RESERVE: zone 15 at (6888, 10472) facing 1, 3x3 cells: 9 of 9 held
  4.02  RESERVE: armnanotcplat at (6888, 10472) facing 1 (id 15)
  4.02  RESERVE: zone 16 at (6888, 10424) facing 1, 3x3 cells: 9 of 9 held
  4.02  RESERVE: armnanotcplat at (6888, 10424) facing 1 (id 16)
  4.02  RESERVE: zone 15 released
  4.02  RESERVE: zone 16 released
  4.02  RESERVE: zone 17 at (6904, 10392) facing 1, 3x3 cells: 9 of 9 held
  4.02  RESERVE: armnanotcplat at (6904, 10392) facing 1 (id 17)
  4.02  RESERVE: zone 17 released
  4.02  RESERVE: zone 18 at (6936, 10344) facing 1, 3x3 cells: 9 of 9 held
  4.02  RESERVE: armnanotcplat at (6936, 10344) facing 1 (id 18)
  4.02  RESERVE: zone 19 at (6936, 10296) facing 1, 3x3 cells: 9 of 9 held
  4.02  RESERVE: armnanotcplat at (6936, 10296) facing 1 (id 19)
  4.02  RESERVE: zone 18 released
  4.02  RESERVE: zone 19 released
  4.02  RESERVE: corridor 20 at (7150, 10888) facing 0, 13x31 cells: 156 of 403 held
  4.02  RESERVE: corridor 21 at (5800, 10988) facing 0, 13x31 cells: 260 of 403 held
  4.02  RESERVE: corridor 22 at (6800, 11436) facing 0, 18x31 cells: 340 of 558 held
  4.02  RESERVE: zone 23 at (6366, 10600) facing 1, 41x41 cells: 1133 of 1681 held
  4.02  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6462, 10600) facing 1: 8 of 16 slots (group 1, held, zone)
  4.02  RESERVE: zone 23 released
  4.02  RESERVE: zone 24 at (6366, 10472) facing 1, 41x41 cells: 1284 of 1681 held
  4.02  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6462, 10472) facing 1: 12 of 16 slots (group 2, held, zone)
  4.02  RESERVE: zone 24 released
  4.02  RESERVE: zone 25 at (6366, 10728) facing 1, 41x41 cells: 1161 of 1681 held
  4.02  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6462, 10728) facing 1: 4 of 16 slots (group 3, held, zone)
  4.02  RESERVE: zone 25 released
  4.02  RESERVE: zone 26 at (6366, 10344) facing 1, 41x41 cells: 1417 of 1681 held
  4.02  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6462, 10344) facing 1: 16 of 16 slots (group 4, held, zone)
  4.02  RESERVE: armuwfus at (6240, 10336) facing 1 (id 60)
  4.02  RESERVE: packed armuwfus at (6240, 10336) facing 1 in zone 26, 313 from a turret (id 60, group 0, 799 candidates)
  4.03  RESERVE: zone 27 at (7000, 10296) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (7000, 10296) facing 1 (id 61)
  4.03  RESERVE: zone 28 at (7000, 10248) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (7000, 10248) facing 1 (id 62)
  4.03  RESERVE: zone 27 released
  4.03  RESERVE: zone 28 released
  4.03  RESERVE: zone 29 at (7080, 10280) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (7080, 10280) facing 1 (id 63)
  4.03  RESERVE: zone 30 at (7080, 10232) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (7080, 10232) facing 1 (id 64)
  4.03  RESERVE: zone 29 released
  4.03  RESERVE: zone 30 released
  4.03  RESERVE: zone 31 at (7144, 10296) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (7144, 10296) facing 1 (id 65)
  4.03  RESERVE: zone 32 at (7144, 10248) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (7144, 10248) facing 1 (id 66)
  4.03  RESERVE: zone 31 released
  4.03  RESERVE: zone 32 released
  4.03  RESERVE: zone 33 at (7208, 10344) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (7208, 10344) facing 1 (id 67)
  4.03  RESERVE: zone 34 at (7208, 10296) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (7208, 10296) facing 1 (id 68)
  4.03  RESERVE: zone 35 at (7208, 10248) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (7208, 10248) facing 1 (id 69)
  4.03  RESERVE: zone 33 released
  4.03  RESERVE: zone 34 released
  4.03  RESERVE: zone 35 released
  4.03  RESERVE: zone 36 at (7256, 10392) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (7256, 10392) facing 1 (id 70)
  4.03  RESERVE: zone 37 at (7256, 10344) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (7256, 10344) facing 1 (id 71)
  4.03  RESERVE: zone 38 at (7256, 10296) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (7256, 10296) facing 1 (id 72)
  4.03  RESERVE: zone 39 at (7256, 10248) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (7256, 10248) facing 1 (id 73)
  4.03  RESERVE: zone 36 released
  4.03  RESERVE: zone 37 released
  4.03  RESERVE: zone 38 released
  4.03  RESERVE: zone 39 released
  4.05  RESERVE: zone 40 at (6968, 10744) facing 1, 3x3 cells: 9 of 9 held
  4.05  RESERVE: armnanotcplat at (6968, 10744) facing 1 (id 74)
  4.05  RESERVE: zone 41 at (6968, 10696) facing 1, 3x3 cells: 9 of 9 held
  4.05  RESERVE: armnanotcplat at (6968, 10696) facing 1 (id 75)
  4.05  RESERVE: zone 42 at (6968, 10648) facing 1, 3x3 cells: 9 of 9 held
  4.05  RESERVE: armnanotcplat at (6968, 10648) facing 1 (id 76)
  4.05  RESERVE: zone 43 at (6968, 10600) facing 1, 3x3 cells: 9 of 9 held
  4.05  RESERVE: armnanotcplat at (6968, 10600) facing 1 (id 77)
```
