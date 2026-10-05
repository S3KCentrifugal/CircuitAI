# Playtest report: FAIL

- Verdict: **FAIL** (script errors)
- Game time reached: 19.3 min (frame 34741); wall 131 s
- DLL: build-theatres\d191-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T13:28:31
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-compact\supreme\20261004T162830Z-eb69d388\runs\20261004T163046Z-af2c6ce0\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:32.251961][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.8 min | `[t=00:00:47.829809][f=0003275] [SeaWatch] finished frame=3275 id=23668 def=armsy builder=1433` |
| expect `first-ship-exit` | **missing** (by 6 min) | |
| forbid `script` | **hit** | `[t=00:01:59.814811][f=0034741] Skirmish AI <BARb playtest-test>: SCRIPT CRASH: access violation in a script call of team 1 (skirmish AI 1); the script stack, innermost first:` |
| forbid `invariant` | clean |  |
| forbid `crash` | **hit** | `[t=00:01:59.815611][f=0034741] Error: Spring 2026.07.04 has crashed.` |

## Failures

- 'first-ship-exit' not seen by 6.0 min
- forbid 'script' hit at 19.3 min: [t=00:01:59.814811][f=0034741] Skirmish AI <BARb playtest-test>: SCRIPT CRASH: access violation in a script call of team 1 (skirmish AI 1); the script stack, innermost first:
- forbid 'crash' hit at 19.3 min: [t=00:01:59.815611][f=0034741] Error: Spring 2026.07.04 has crashed.
- forbid 'crash' hit at 19.3 min: [t=00:01:59.902061][f=0034741] Error: Exception: Access violation (0xc0000005)
- forbid 'crash' hit at 19.3 min: [t=00:02:02.532016][f=0034741] Fatal: [ExitSpringProcess] errorMsg="Spring has crashed:
- forbid 'crash' hit at 19.3 min:   Access violation.
- forbid 'script' hit at 19.3 min: =00:02:02.826526][f=0034741] Skirmish AI <BARb playtest-test>:  (0, 0) : ERR  : Object {55896}. GC cannot destroy an object of type 'dictionary' as it can't see all references. Current ref count is 1.
- forbid 'script' hit at 19.3 min: t=00:02:02.826587][f=0034741] Skirmish AI <BARb playtest-test>:  (0, 0) : ERR  : Object {3549}. GC cannot destroy an object of type 'dictionary' as it can't see all references. Current ref count is 1.
- forbid 'script' hit at 19.3 min: =00:02:02.826629][f=0034741] Skirmish AI <BARb playtest-test>:  (0, 0) : ERR  : Object {55895}. GC cannot destroy an object of type 'dictionary' as it can't see all references. Current ref count is 1.
- forbid 'script' hit at 19.3 min: =00:02:02.826681][f=0034741] Skirmish AI <BARb playtest-test>:  (0, 0) : ERR  : Object {3548}. GC cannot destroy an object of type 'RoleConfig' as it can't see all references. Current ref count is -1.
- forbid 'script' hit at 19.3 min: 2:02.826722][f=0034741] Skirmish AI <BARb playtest-test>:  (0, 0) : ERR  : Object {11}. GC cannot destroy an object of type 'ProfileController' as it can't see all references. Current ref count is -1.

## Script errors

```
[t=00:02:02.826526][f=0034741] Skirmish AI <BARb playtest-test>:  (0, 0) : ERR  : Object {55896}. GC cannot destroy an object of type 'dictionary' as it can't see all references. Current ref count is 1.
[t=00:02:02.826587][f=0034741] Skirmish AI <BARb playtest-test>:  (0, 0) : ERR  : Object {3549}. GC cannot destroy an object of type 'dictionary' as it can't see all references. Current ref count is 1.
[t=00:02:02.826629][f=0034741] Skirmish AI <BARb playtest-test>:  (0, 0) : ERR  : Object {55895}. GC cannot destroy an object of type 'dictionary' as it can't see all references. Current ref count is 1.
[t=00:02:02.826681][f=0034741] Skirmish AI <BARb playtest-test>:  (0, 0) : ERR  : Object {3548}. GC cannot destroy an object of type 'RoleConfig' as it can't see all references. Current ref count is -1.
[t=00:02:02.826722][f=0034741] Skirmish AI <BARb playtest-test>:  (0, 0) : ERR  : Object {11}. GC cannot destroy an object of type 'ProfileController' as it can't see all references. Current ref count is -1.
```

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-compact\supreme\20261004T162830Z-eb69d388\runs\20261004T163046Z-af2c6ce0\screen_2026-10-04_16-29-36-925.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-compact\supreme\20261004T162830Z-eb69d388\runs\20261004T163046Z-af2c6ce0\screen_2026-10-04_16-29-57-911.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 25.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 36
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 36
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.20  [Playtest] finished armmex team 0 at 0.20 min
  0.22  [Team][Roster] first mex 6311 at 4608,11072
  0.22  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4773|11078|0|7|1|4608|11072
  0.81  [Playtest] finished armwin team 0 at 0.81 min
  0.92  [Playtest] finished armwin team 0 at 0.92 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.3 bank 1019/1050, energy +59.7 bank 996/1001, units 5
  1.04  [Playtest] finished armwin team 0 at 1.04 min
  1.82  [Playtest] finished armsy team 0 at 1.82 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +4.3 bank 642/1150, energy +71.7 bank 931/1101, units 7
  3.00  [Playtest] eco team 0 at 3.0 min: metal +4.3 bank 297/1150, energy +100.5 bank 948/1201, units 9
  4.00  [Playtest] eco team 0 at 4.0 min: metal +4.3 bank 13/1150, energy +100.9 bank 1196/1201, units 10
  5.00  [Playtest] eco team 0 at 5.0 min: metal +4.3 bank 12/1150, energy +100.2 bank 1196/1201, units 11
  5.00  [Playtest] target team 0 at (4814, 11077) from its start position
  5.00  [Playtest] camera requested (4814,11077) height=2200
  5.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (4814, 11077)
  6.00  [Playtest] eco team 0 at 6.0 min: metal +4.3 bank 12/1150, energy +100.0 bank 1188/1201, units 12
  7.00  [Playtest] eco team 0 at 7.0 min: metal +4.3 bank 13/1150, energy +71.7 bank 1196/1201, units 12
  8.00  [Playtest] eco team 0 at 8.0 min: metal +4.3 bank 13/1150, energy +100.8 bank 1201/1201, units 13
  9.00  [Playtest] eco team 0 at 9.0 min: metal +4.3 bank 13/1150, energy +97.4 bank 1196/1201, units 13
 10.00  [Playtest] eco team 0 at 10.0 min: metal +4.3 bank 13/1150, energy +79.3 bank 1196/1201, units 14
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 11.00  [Playtest] eco team 0 at 11.0 min: metal +4.3 bank 13/1150, energy +74.9 bank 1196/1201, units 14
 12.00  [Playtest] eco team 0 at 12.0 min: metal +4.3 bank 262/1150, energy +76.9 bank 1201/1201, units 14
 13.00  [Playtest] eco team 0 at 13.0 min: metal +4.3 bank 520/1150, energy +99.9 bank 1201/1201, units 14
 14.00  [Playtest] eco team 0 at 14.0 min: metal +4.3 bank 778/1150, energy +98.5 bank 1201/1201, units 14
 15.00  [Playtest] eco team 0 at 15.0 min: metal +4.3 bank 760/1150, energy +85.6 bank 1187/1201, units 15
 16.00  [Playtest] eco team 0 at 16.0 min: metal +4.3 bank 855/1150, energy +66.3 bank 1201/1201, units 15
 17.00  [Playtest] eco team 0 at 17.0 min: metal +4.3 bank 899/1150, energy +87.0 bank 1192/1201, units 17
 18.00  [Playtest] eco team 0 at 18.0 min: metal +4.3 bank 691/1150, energy +100.5 bank 1201/1201, units 18
 19.00  [Playtest] eco team 0 at 19.0 min: metal +4.3 bank 890/1150, energy +92.3 bank 1182/1201, units 19
```

## Native lines (all AIs, first 120)

```
  0.53  RESERVE: zone 1 at (4792, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (4792, 11544) facing 2 (id 1)
  0.53  RESERVE: zone 2 at (4744, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (4744, 11544) facing 2 (id 2)
  0.53  RESERVE: zone 3 at (4696, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (4696, 11544) facing 2 (id 3)
  0.53  RESERVE: zone 4 at (4792, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (4792, 11496) facing 2 (id 4)
  0.53  RESERVE: zone 5 at (4744, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (4744, 11496) facing 2 (id 5)
  0.53  RESERVE: zone 6 at (4696, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (4696, 11496) facing 2 (id 6)
  0.53  RESERVE: zone 1 at (7416, 920) facing 0, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (7416, 920) facing 0 (id 1)
  0.53  RESERVE: zone 2 at (7464, 920) facing 0, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (7464, 920) facing 0 (id 2)
  0.53  RESERVE: zone 3 at (7512, 920) facing 0, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (7512, 920) facing 0 (id 3)
  0.53  RESERVE: zone 1 released
  0.53  RESERVE: zone 2 released
  0.53  RESERVE: zone 3 released
  0.53  RESERVE: zone 4 at (7400, 888) facing 0, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (7400, 888) facing 0 (id 4)
  0.53  RESERVE: zone 5 at (7448, 888) facing 0, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (7448, 888) facing 0 (id 5)
  0.53  RESERVE: zone 6 at (7496, 888) facing 0, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (7496, 888) facing 0 (id 6)
  0.53  RESERVE: zone 4 released
  0.53  RESERVE: zone 5 released
  0.53  RESERVE: zone 6 released
  0.53  RESERVE: zone 7 at (7400, 856) facing 0, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (7400, 856) facing 0 (id 7)
  0.53  RESERVE: zone 8 at (7448, 856) facing 0, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (7448, 856) facing 0 (id 8)
  0.53  RESERVE: zone 9 at (7496, 856) facing 0, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (7496, 856) facing 0 (id 9)
  0.53  RESERVE: zone 10 at (7400, 904) facing 0, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (7400, 904) facing 0 (id 10)
  0.53  RESERVE: zone 11 at (7448, 904) facing 0, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (7448, 904) facing 0 (id 11)
  0.53  RESERVE: zone 12 at (7496, 904) facing 0, 3x3 cells: 9 of 9 held
  0.53  RESERVE: armwin at (7496, 904) facing 0 (id 12)
  0.53  RESERVE: served armwin at (4792, 11544) facing 2 (id 1, 5 of this def still held)
  0.53  RESERVE: served armwin at (7400, 856) facing 0 (id 7, 5 of this def still held)
  0.69  RESERVE: armwin at (4792, 11544) is being reclaimed: its slot will be freed (id 1)
  0.72  RESERVE: restored armwin at (4792, 11544) (id 1)
  0.72  RESERVE: served armwin at (4792, 11544) facing 2 (id 1, 5 of this def still held)
  0.77  RESERVE: served armwin at (7448, 856) facing 0 (id 8, 4 of this def still held)
  0.83  RESERVE: served armwin at (4744, 11544) facing 2 (id 2, 4 of this def still held)
  0.88  RESERVE: served armwin at (7496, 856) facing 0 (id 9, 3 of this def still held)
  0.94  RESERVE: served armwin at (4696, 11544) facing 2 (id 3, 3 of this def still held)
  1.73  RESERVE: zone 13 at (6472, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armnanotcplat at (6472, 1512) facing 0 (id 13)
  1.73  RESERVE: zone 14 at (6520, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armnanotcplat at (6520, 1512) facing 0 (id 14)
  1.73  RESERVE: zone 13 released
  1.73  RESERVE: zone 14 released
  1.73  RESERVE: zone 15 at (6408, 1528) facing 0, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armnanotcplat at (6408, 1528) facing 0 (id 15)
  1.73  RESERVE: zone 16 at (6456, 1528) facing 0, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armnanotcplat at (6456, 1528) facing 0 (id 16)
  1.73  RESERVE: zone 17 at (6504, 1528) facing 0, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armnanotcplat at (6504, 1528) facing 0 (id 17)
  1.73  RESERVE: zone 15 released
  1.73  RESERVE: zone 16 released
  1.73  RESERVE: zone 17 released
  1.73  RESERVE: zone 18 at (6328, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armnanotcplat at (6328, 1512) facing 0 (id 18)
  1.73  RESERVE: zone 19 at (6376, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armnanotcplat at (6376, 1512) facing 0 (id 19)
  1.73  RESERVE: zone 20 at (6424, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armnanotcplat at (6424, 1512) facing 0 (id 20)
  1.73  RESERVE: zone 21 at (6472, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armnanotcplat at (6472, 1512) facing 0 (id 21)
  1.73  RESERVE: zone 22 at (6520, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armnanotcplat at (6520, 1512) facing 0 (id 22)
  1.73  RESERVE: zone 23 at (6328, 1560) facing 0, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armnanotcplat at (6328, 1560) facing 0 (id 23)
  1.73  RESERVE: zone 18 released
  1.73  RESERVE: zone 19 released
  1.73  RESERVE: zone 20 released
  1.73  RESERVE: zone 21 released
  1.73  RESERVE: zone 22 released
  1.73  RESERVE: zone 23 released
  1.73  RESERVE: zone 24 at (6264, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armnanotcplat at (6264, 1464) facing 0 (id 24)
  1.73  RESERVE: zone 25 at (6312, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armnanotcplat at (6312, 1464) facing 0 (id 25)
  1.73  RESERVE: zone 26 at (6360, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armnanotcplat at (6360, 1464) facing 0 (id 26)
  1.73  RESERVE: zone 27 at (6408, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armnanotcplat at (6408, 1464) facing 0 (id 27)
  1.73  RESERVE: zone 28 at (6456, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armnanotcplat at (6456, 1464) facing 0 (id 28)
  1.73  RESERVE: zone 29 at (6264, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armnanotcplat at (6264, 1512) facing 0 (id 29)
  1.73  RESERVE: zone 30 at (6312, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armnanotcplat at (6312, 1512) facing 0 (id 30)
  1.73  RESERVE: zone 31 at (6360, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armnanotcplat at (6360, 1512) facing 0 (id 31)
  1.73  RESERVE: zone 32 at (6408, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armnanotcplat at (6408, 1512) facing 0 (id 32)
  1.73  RESERVE: zone 33 at (6456, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armnanotcplat at (6456, 1512) facing 0 (id 33)
  1.73  RESERVE: zone 34 at (6264, 1560) facing 0, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armnanotcplat at (6264, 1560) facing 0 (id 34)
  1.73  RESERVE: zone 35 at (6312, 1560) facing 0, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armnanotcplat at (6312, 1560) facing 0 (id 35)
  1.73  RESERVE: zone 24 released
  1.73  RESERVE: zone 25 released
  1.73  RESERVE: zone 26 released
  1.73  RESERVE: zone 27 released
  1.73  RESERVE: zone 28 released
  1.73  RESERVE: zone 29 released
  1.73  RESERVE: zone 30 released
  1.73  RESERVE: zone 31 released
  1.73  RESERVE: zone 32 released
  1.73  RESERVE: zone 33 released
  1.73  RESERVE: zone 34 released
  1.73  RESERVE: zone 35 released
```
