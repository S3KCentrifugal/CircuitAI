# Playtest report: FAIL

- Verdict: **FAIL** (script errors)
- Game time reached: 12.5 min (frame 22501); wall 97 s
- DLL: build-theatres\d191-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T13:31:15
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI None, role SEA
- Checks: economy-block.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T163114Z-d95fe53c\runs\20261004T163255Z-fe6ea1e1\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `t1` | **missing** (by 12 min) | |
| expect `t2` | **missing** (by 12 min) | |
| expect `shipyard` | **missing** (by 12 min) | |
| expect `amphibious` | **missing** (by 12 min) | |
| expect `fusion-support` | **missing** (by 12 min) | |
| expect `rear-fusion` | **missing** (by 12 min) | |
| forbid `errors` | **hit** | `[t=00:00:36.382001][f=-000001] Skirmish AI <BARb playtest-test>:  (0, 0) : ERR  : Warnings are treated as errors by the application` |

## Failures

- forbid 'errors' hit at 0.0 min: [t=00:00:36.382001][f=-000001] Skirmish AI <BARb playtest-test>:  (0, 0) : ERR  : Warnings are treated as errors by the application
- forbid 'errors' hit at 0.0 min: [t=00:00:37.344462][f=-000001] Skirmish AI <BARb playtest-test>:  (0, 0) : ERR  : Warnings are treated as errors by the application
- 't1' not seen by 12.0 min
- 't2' not seen by 12.0 min
- 'shipyard' not seen by 12.0 min
- 'amphibious' not seen by 12.0 min
- 'fusion-support' not seen by 12.0 min
- 'rear-fusion' not seen by 12.0 min

## Script errors

```
[t=00:00:36.382001][f=-000001] Skirmish AI <BARb playtest-test>:  (0, 0) : ERR  : Warnings are treated as errors by the application
[t=00:00:36.411677][f=-000001] Skirmish AI <BARb playtest-test>: Script: Fix compilation errors!
[t=00:00:37.344462][f=-000001] Skirmish AI <BARb playtest-test>:  (0, 0) : ERR  : Warnings are treated as errors by the application
[t=00:00:37.374557][f=-000001] Skirmish AI <BARb playtest-test>: Script: Fix compilation errors!
```

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T163114Z-d95fe53c\runs\20261004T163255Z-fe6ea1e1\screen_2026-10-04_16-32-13-288.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T163114Z-d95fe53c\runs\20261004T163255Z-fe6ea1e1\screen_2026-10-04_16-32-26-275.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\economy-block\supreme\20261004T163114Z-d95fe53c\runs\20261004T163255Z-fe6ea1e1\screen_2026-10-04_16-32-47-264.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 3 shots, end at 12.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 28
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai false dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai false dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 28
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 100000/100000, energy +30.0 bank 1000000/1000000, units 1
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 100000/100000, energy +30.0 bank 1000000/1000000, units 1
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 100000/100000, energy +30.0 bank 1000000/1000000, units 1
  3.00  [Playtest] camera requested (6200,11000) height=2200
  3.00  [Playtest] camera captured name=ta position=(6200,11000) height=2200
  3.00  [Playtest] screenshot at 3.0 min of team 0 at (6200, 11000)
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 100000/100000, energy +30.0 bank 1000000/1000000, units 1
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 100000/100000, energy +30.0 bank 1000000/1000000, units 1
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 100000/100000, energy +30.0 bank 1000000/1000000, units 1
  6.00  [Playtest] camera requested (6200,11000) height=2200
  6.00  [Playtest] camera captured name=ta position=(6200,11000) height=2200
  6.00  [Playtest] screenshot at 6.0 min of team 0 at (6200, 11000)
  7.00  [Playtest] eco team 0 at 7.0 min: metal +2.0 bank 100000/100000, energy +30.0 bank 1000000/1000000, units 1
  8.00  [Playtest] eco team 0 at 8.0 min: metal +2.0 bank 100000/100000, energy +30.0 bank 1000000/1000000, units 1
  9.00  [Playtest] eco team 0 at 9.0 min: metal +2.0 bank 100000/100000, energy +30.0 bank 1000000/1000000, units 1
 10.00  [Playtest] eco team 0 at 10.0 min: metal +2.0 bank 100000/100000, energy +30.0 bank 1000000/1000000, units 1
 11.00  [Playtest] eco team 0 at 11.0 min: metal +2.0 bank 100000/100000, energy +30.0 bank 1000000/1000000, units 1
 11.00  [Playtest] camera requested (6200,11000) height=2200
 11.01  [Playtest] camera captured name=ta position=(6200,11000) height=2200
 11.01  [Playtest] screenshot at 11.0 min of team 0 at (6200, 11000)
 12.00  [Playtest] eco team 0 at 12.0 min: metal +2.0 bank 100000/100000, energy +30.0 bank 1000000/1000000, units 1
 12.50  [Playtest] end at 12.5 min: quitting
```

## Native lines (all AIs, first 120)

```
```
