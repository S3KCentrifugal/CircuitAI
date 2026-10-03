# Playtest report: FAIL

- Verdict: **FAIL** (script errors)
- Game time reached: 7.0 min (frame 12600); wall 1 s
- DLL: build-theatres\d179-build\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T11:57:11
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/cortex/test, 1=AIR/armada/test
- Team 0 (under test): skirmish AI None, role AIR
- Checks: air_recon.json; widget loaded: yes
- Log: build-theatres\games\air\combat\recon-d179\supreme\20261003T145605Z-331b5838\runs\20261003T145857Z-25a42eb3\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `formation` | **missing** (by 3 min) | |
| expect `dispatch` | **missing** (by 6 min) | |
| expect `survey` | **missing** (by 8 min) | |
| forbid `script` | **hit** | `[t=00:00:34.691163][f=-000001] Skirmish AI <BARb playtest-test>:  (0, 0) : ERR  : Warnings are treated as errors by the application` |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Failures

- forbid 'script' hit at 0.0 min: [t=00:00:34.691163][f=-000001] Skirmish AI <BARb playtest-test>:  (0, 0) : ERR  : Warnings are treated as errors by the application
- forbid 'script' hit at 0.0 min: [t=00:00:35.601772][f=-000001] Skirmish AI <BARb playtest-test>:  (0, 0) : ERR  : Warnings are treated as errors by the application
- 'formation' not seen by 3.0 min
- 'dispatch' not seen by 6.0 min

## Script errors

```
[t=00:00:34.691163][f=-000001] Skirmish AI <BARb playtest-test>:  (0, 0) : ERR  : Warnings are treated as errors by the application
[t=00:00:34.720210][f=-000001] Skirmish AI <BARb playtest-test>: Script: Fix compilation errors!
[t=00:00:35.601772][f=-000001] Skirmish AI <BARb playtest-test>:  (0, 0) : ERR  : Warnings are treated as errors by the application
[t=00:00:35.632818][f=-000001] Skirmish AI <BARb playtest-test>: Script: Fix compilation errors!
```

## Screenshots

- build-theatres\games\air\combat\recon-d179\supreme\20261003T145605Z-331b5838\runs\20261003T145857Z-25a42eb3\screen_2026-10-03_14-58-19-387.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 8, 0 shots, end at 8.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished corcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side cortex ai true dead false start (2155, 11747) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (10129, 541) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 24
  0.00  [Playtest] speed 8
  0.05  [Playtest] frame 90 team 0 ally 0 side cortex ai false dead false start (2155, 11747) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai false dead false start (10129, 541) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 24
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000/1000, units 1
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000/1000, units 21
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000/1000, units 21
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000/1000, units 21
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000/1000, units 21
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000/1000, units 21
  7.00  [Playtest] eco team 0 at 7.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000/1000, units 21
```

## Native lines (all AIs, first 120)

```
```
