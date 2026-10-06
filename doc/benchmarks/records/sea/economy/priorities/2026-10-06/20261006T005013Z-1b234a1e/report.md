# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 8.2 min (frame 14700); wall 74 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (d11e654d41abebfb); AI BARbTest/test; staged 2026-10-05T21:48:50
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea-recovery-priorities.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\priorities\supreme\20261006T004850Z-4700688f\runs\20261006T005013Z-1b234a1e\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:33.742042][f=-000001] [SeaRecoveryTest] loaded teams=2 fixture=true` |
| expect `reclaim` | seen at 0.3 min | `[t=00:00:43.157257][f=0000510] [SeaRecoveryTest] PASS reclaim` |
| expect `flagship-repair` | seen at 0.5 min | `[t=00:00:43.752452][f=0000870] [SeaRecoveryTest] PASS flagship-repair` |
| expect `resurrect` | seen at 1.9 min | `[t=00:00:49.301709][f=0003390] [SeaRecoveryTest] PASS resurrect` |
| expect `ordinary-repair` | **missing** (by 8 min) | |
| expect `t1-producing` | seen at 4.2 min | `[t=00:00:57.769853][f=0007633] [SeaRecoveryTest] PASS t1-producing` |
| expect `t2-producing` | seen at 4.8 min | `[t=00:00:59.498345][f=0008650] [SeaRecoveryTest] PASS t2-producing` |
| expect `platform-producing` | seen at 4.7 min | `[t=00:00:59.136129][f=0008420] [SeaRecoveryTest] PASS platform-producing` |
| expect `sub-scaling` | **missing** (by 8 min) | |
| forbid `errors` | **hit** | `[t=00:00:56.918504][f=0007200] [SeaRecoveryTest] FAIL dry fixture armcs` |

## Failures

- forbid 'errors' hit at 4.0 min: [t=00:00:56.918504][f=0007200] [SeaRecoveryTest] FAIL dry fixture armcs
- forbid 'errors' hit at 4.0 min: [t=00:00:56.918531][f=0007200] [SeaRecoveryTest] FAIL dry fixture armnanotcplat
- forbid 'errors' hit at 4.0 min: [t=00:00:56.918549][f=0007200] [SeaRecoveryTest] FAIL dry fixture armnanotcplat
- forbid 'errors' hit at 4.0 min: [t=00:00:56.918565][f=0007200] [SeaRecoveryTest] FAIL dry fixture armnanotcplat
- 'ordinary-repair' not seen by 8.0 min
- 'sub-scaling' not seen by 8.0 min

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\priorities\supreme\20261006T004850Z-4700688f\runs\20261006T005013Z-1b234a1e\screen_2026-10-06_00-49-46-115.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\priorities\supreme\20261006T004850Z-4700688f\runs\20261006T005013Z-1b234a1e\screen_2026-10-06_00-49-50-878.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\priorities\supreme\20261006T004850Z-4700688f\runs\20261006T005013Z-1b234a1e\screen_2026-10-06_00-50-01-326.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\priorities\supreme\20261006T004850Z-4700688f\runs\20261006T005013Z-1b234a1e\screen_2026-10-06_00-50-08-600.png

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
  0.80  [Playtest] camera captured name=ta position=(6200,10700) height=2200
  0.80  [Playtest] screenshot at 0.8 min of team 0 at (6200, 10700)
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 554/1000, energy +30.0 bank 1000000/1000000, units 4
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
  2.00  [Playtest] eco team 0 at 2.0 min: metal +43.1 bank 1000/1000, energy +2430.0 bank 754940/1005000, units 18
  2.00  [Playtest] camera requested (6200,10700) height=2200
  2.01  [Playtest] camera captured name=ta position=(6200,10700) height=2200
  2.01  [Playtest] screenshot at 2.0 min of team 0 at (6200, 10700)
  3.00  [Playtest] eco team 0 at 3.0 min: metal +43.1 bank 1000/1000, energy +2430.0 bank 754940/1005000, units 18
  4.00  [Playtest] eco team 0 at 4.0 min: metal +43.1 bank 1000/1000, energy +2430.0 bank 754940/1005000, units 19
  4.00  [Playtest] finished armsy team 0 at 4.00 min
  4.00  [Playtest] finished armasy team 0 at 4.00 min
  4.00  [Playtest] finished armplat team 0 at 4.00 min
  4.00  [Playtest] finished armnanotcplat team 0 at 4.00 min
  4.75  [SEA][Layout] berth sea.berth.0 armasy at=8784,10704 facing=1
  5.00  [Playtest] eco team 0 at 5.0 min: metal +46.7 bank 1030/1300, energy +2804.0 bank 756817/1007400, units 34
  5.00  [Playtest] camera requested (6500,10800) height=2800
  5.01  [Playtest] camera captured name=ta position=(6500,10800) height=2800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (6500, 10800)
  5.47  [SEA][Layout] berth sea.berth.1 armplat at=8688,10304 facing=1
  6.00  [Playtest] eco team 0 at 6.0 min: metal +40.9 bank 1283/1300, energy +2804.0 bank 756677/1007400, units 39
  7.00  [Playtest] eco team 0 at 7.0 min: metal +33.2 bank 634/1300, energy +2804.0 bank 756547/1007400, units 42
  7.00  [Playtest] camera requested (6500,10800) height=3500
  7.01  [Playtest] camera captured name=ta position=(6500,10800) height=3500
  7.01  [Playtest] screenshot at 7.0 min of team 0 at (6500, 10800)
  8.00  [Playtest] eco team 0 at 8.0 min: metal +39.0 bank 4/1300, energy +2804.0 bank 756624/1007400, units 46
```

## Native lines (all AIs, first 120)

```
  4.02  RESERVE: corridor 1 at (5800, 10988) facing 0, 13x31 cells: 260 of 403 held
  4.02  RESERVE: corridor 2 at (6800, 11436) facing 0, 18x31 cells: 340 of 558 held
  4.02  RESERVE: corridor 3 at (7150, 10888) facing 0, 13x31 cells: 156 of 403 held
  4.03  RESERVE: zone 4 at (5656, 10392) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (5656, 10392) facing 1 (id 1)
  4.03  RESERVE: zone 5 at (5656, 10344) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (5656, 10344) facing 1 (id 2)
  4.03  RESERVE: zone 4 released
  4.03  RESERVE: zone 5 released
  4.03  RESERVE: zone 6 at (5736, 10376) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (5736, 10376) facing 1 (id 3)
  4.03  RESERVE: zone 7 at (5736, 10328) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (5736, 10328) facing 1 (id 4)
  4.03  RESERVE: zone 6 released
  4.03  RESERVE: zone 7 released
  4.03  RESERVE: zone 8 at (5800, 10392) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (5800, 10392) facing 1 (id 5)
  4.03  RESERVE: zone 9 at (5800, 10344) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (5800, 10344) facing 1 (id 6)
  4.03  RESERVE: zone 8 released
  4.03  RESERVE: zone 9 released
  4.03  RESERVE: zone 10 at (5864, 10440) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (5864, 10440) facing 1 (id 7)
  4.03  RESERVE: zone 11 at (5864, 10392) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (5864, 10392) facing 1 (id 8)
  4.03  RESERVE: zone 12 at (5864, 10344) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (5864, 10344) facing 1 (id 9)
  4.03  RESERVE: zone 10 released
  4.03  RESERVE: zone 11 released
  4.03  RESERVE: zone 12 released
  4.03  RESERVE: zone 13 at (5912, 10504) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (5912, 10504) facing 1 (id 10)
  4.03  RESERVE: zone 14 at (5912, 10456) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (5912, 10456) facing 1 (id 11)
  4.03  RESERVE: zone 15 at (5912, 10408) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (5912, 10408) facing 1 (id 12)
  4.03  RESERVE: zone 16 at (5912, 10360) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (5912, 10360) facing 1 (id 13)
  4.03  RESERVE: zone 13 released
  4.03  RESERVE: zone 14 released
  4.03  RESERVE: zone 15 released
  4.03  RESERVE: zone 16 released
  4.03  RESERVE: zone 17 at (6024, 10568) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (6024, 10568) facing 1 (id 14)
  4.03  RESERVE: zone 18 at (6024, 10520) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (6024, 10520) facing 1 (id 15)
  4.03  RESERVE: zone 19 at (6024, 10472) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (6024, 10472) facing 1 (id 16)
  4.03  RESERVE: zone 20 at (6024, 10424) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (6024, 10424) facing 1 (id 17)
  4.03  RESERVE: zone 21 at (6024, 10376) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (6024, 10376) facing 1 (id 18)
  4.03  RESERVE: zone 22 at (6072, 10568) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (6072, 10568) facing 1 (id 19)
  4.03  RESERVE: zone 23 at (6072, 10520) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (6072, 10520) facing 1 (id 20)
  4.03  RESERVE: zone 24 at (6072, 10472) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (6072, 10472) facing 1 (id 21)
  4.03  RESERVE: zone 25 at (6072, 10424) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (6072, 10424) facing 1 (id 22)
  4.03  RESERVE: zone 17 released
  4.03  RESERVE: zone 18 released
  4.03  RESERVE: zone 19 released
  4.03  RESERVE: zone 20 released
  4.03  RESERVE: zone 21 released
  4.03  RESERVE: zone 22 released
  4.03  RESERVE: zone 23 released
  4.03  RESERVE: zone 24 released
  4.03  RESERVE: zone 25 released
  4.03  RESERVE: zone 26 at (5992, 10680) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (5992, 10680) facing 1 (id 23)
  4.03  RESERVE: zone 27 at (5992, 10632) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (5992, 10632) facing 1 (id 24)
  4.03  RESERVE: zone 28 at (5992, 10584) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (5992, 10584) facing 1 (id 25)
  4.03  RESERVE: zone 29 at (5992, 10536) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (5992, 10536) facing 1 (id 26)
  4.03  RESERVE: zone 30 at (5992, 10488) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (5992, 10488) facing 1 (id 27)
  4.03  RESERVE: zone 31 at (6040, 10680) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (6040, 10680) facing 1 (id 28)
  4.03  RESERVE: zone 32 at (6040, 10632) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (6040, 10632) facing 1 (id 29)
  4.03  RESERVE: zone 33 at (6040, 10584) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (6040, 10584) facing 1 (id 30)
  4.03  RESERVE: zone 34 at (6040, 10536) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (6040, 10536) facing 1 (id 31)
  4.03  RESERVE: zone 35 at (6040, 10488) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (6040, 10488) facing 1 (id 32)
  4.03  RESERVE: zone 36 at (6088, 10680) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (6088, 10680) facing 1 (id 33)
  4.03  RESERVE: zone 37 at (6088, 10632) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (6088, 10632) facing 1 (id 34)
  4.03  RESERVE: zone 38 at (6088, 10584) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (6088, 10584) facing 1 (id 35)
  4.03  RESERVE: zone 39 at (6088, 10536) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (6088, 10536) facing 1 (id 36)
  4.03  RESERVE: zone 40 at (6088, 10488) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (6088, 10488) facing 1 (id 37)
  4.03  RESERVE: zone 41 at (6136, 10680) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (6136, 10680) facing 1 (id 38)
  4.03  RESERVE: zone 42 at (6136, 10632) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (6136, 10632) facing 1 (id 39)
  4.03  RESERVE: zone 43 at (6136, 10584) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (6136, 10584) facing 1 (id 40)
  4.03  RESERVE: zone 44 at (6136, 10536) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (6136, 10536) facing 1 (id 41)
  4.03  RESERVE: zone 45 at (6136, 10488) facing 1, 3x3 cells: 9 of 9 held
  4.03  RESERVE: armnanotcplat at (6136, 10488) facing 1 (id 42)
  4.05  RESERVE: zone 46 at (6600, 11112) facing 1, 3x3 cells: 9 of 9 held
  4.05  RESERVE: armnanotcplat at (6600, 11112) facing 1 (id 43)
  4.05  RESERVE: zone 47 at (6600, 11064) facing 1, 3x3 cells: 9 of 9 held
  4.05  RESERVE: armnanotcplat at (6600, 11064) facing 1 (id 44)
  4.05  RESERVE: zone 48 at (6600, 11016) facing 1, 3x3 cells: 9 of 9 held
  4.05  RESERVE: armnanotcplat at (6600, 11016) facing 1 (id 45)
  4.05  RESERVE: zone 49 at (6600, 10968) facing 1, 3x3 cells: 9 of 9 held
  4.05  RESERVE: armnanotcplat at (6600, 10968) facing 1 (id 46)
  4.05  RESERVE: zone 50 at (6600, 10920) facing 1, 3x3 cells: 9 of 9 held
  4.05  RESERVE: armnanotcplat at (6600, 10920) facing 1 (id 47)
  4.05  RESERVE: zone 46 released
```
