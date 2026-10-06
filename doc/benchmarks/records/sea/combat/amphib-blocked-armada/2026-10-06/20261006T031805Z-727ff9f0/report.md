# Playtest report: FAIL

- Verdict: **FAIL** (script errors)
- Game time reached: 0.2 min (frame 323); wall 45 s
- DLL: build-theatres\d212-final\SkirmishAI.dll (f224e17dc3c6f798); AI BARbTest/test; staged 2026-10-06T00:15:56
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI None, role SEA
- Checks: amphibious-blocked.json; widget loaded: yes
- Log: build-theatres\games\sea\combat\amphib-blocked-armada\supreme\20261006T031556Z-3f2eafe0\runs\20261006T031805Z-727ff9f0\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `occupied` | **missing** (by 5 min) | |
| forbid `errors` | **hit** | `[t=00:00:38.295779][f=-000001] Skirmish AI <BARb playtest-test>:  (0, 0) : ERR  : Warnings are treated as errors by the application` |

## Failures

- forbid 'errors' hit at 0.0 min: [t=00:00:38.295779][f=-000001] Skirmish AI <BARb playtest-test>:  (0, 0) : ERR  : Warnings are treated as errors by the application
- forbid 'errors' hit at 0.0 min: [t=00:00:39.384809][f=-000001] Skirmish AI <BARb playtest-test>:  (0, 0) : ERR  : Warnings are treated as errors by the application

## Script errors

```
[t=00:00:38.295779][f=-000001] Skirmish AI <BARb playtest-test>:  (0, 0) : ERR  : Warnings are treated as errors by the application
[t=00:00:38.327730][f=-000001] Skirmish AI <BARb playtest-test>: Script: Fix compilation errors!
[t=00:00:39.384809][f=-000001] Skirmish AI <BARb playtest-test>:  (0, 0) : ERR  : Warnings are treated as errors by the application
[t=00:00:39.418840][f=-000001] Skirmish AI <BARb playtest-test>: Script: Fix compilation errors!
```

## Screenshots

- none

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 20, 4 shots, end at 5.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 20000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (5800, 10500) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 36
  0.00  [Playtest] speed 20
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai false dead false start (5800, 10500) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai false dead false start (11456, 1901) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 36
  0.17  [Playtest] finished armsy team 0 at 0.17 min
  0.17  [Playtest] finished armasy team 0 at 0.17 min
  0.17  [Playtest] finished armplat team 0 at 0.17 min
  0.17  [Playtest] finished armuwfus team 0 at 0.17 min
  0.17  [Playtest] finished armuwfus team 0 at 0.17 min
  0.17  [Playtest] finished armuwfus team 0 at 0.17 min
  0.17  [Playtest] finished armuwfus team 0 at 0.17 min
  0.17  [Playtest] finished armuwfus team 0 at 0.17 min
  0.17  [Playtest] finished armuwfus team 0 at 0.17 min
  0.17  [Playtest] finished armuwfus team 0 at 0.17 min
  0.17  [Playtest] finished armuwfus team 0 at 0.17 min
  0.17  [Playtest] finished armuwfus team 0 at 0.17 min
  0.17  [Playtest] finished armuwfus team 0 at 0.17 min
  0.17  [Playtest] finished armuwfus team 0 at 0.17 min
  0.17  [Playtest] finished armuwfus team 0 at 0.17 min
  0.17  [Playtest] finished armuwfus team 0 at 0.17 min
  0.17  [Playtest] finished armuwfus team 0 at 0.17 min
  0.17  [Playtest] finished armuwfus team 0 at 0.17 min
  0.17  [Playtest] finished armuwfus team 0 at 0.17 min
  0.17  [Playtest] finished armuwfus team 0 at 0.17 min
  0.17  [Playtest] finished armuwfus team 0 at 0.17 min
  0.17  [Playtest] finished armuwfus team 0 at 0.17 min
  0.17  [Playtest] finished armuwfus team 0 at 0.17 min
  0.17  [Playtest] finished armuwfus team 0 at 0.17 min
  0.17  [Playtest] finished armuwfus team 0 at 0.17 min
  0.17  [Playtest] finished armuwfus team 0 at 0.17 min
  0.17  [Playtest] finished armuwfus team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
```

## Native lines (all AIs, first 120)

```
```
