# Playtest report: FAIL

- Verdict: **FAIL** (script errors)
- Game time reached: 13.0 min (frame 23400); wall 105 s
- DLL: build-theatres\d212-build\SkirmishAI.dll (f20faeb36c0d227b); AI BARbTest/test; staged 2026-10-05T23:19:03
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI None, role SEA
- Checks: amphibious-transition.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T021903Z-09b858d6\runs\20261006T022058Z-5ff2119e\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `partial-survey` | seen at 1.8 min | `[t=00:00:54.689120][f=0003300] [SeaInvasionTest] PASS partial-survey-blocked` |
| expect `complex` | **missing** (by 18 min) | |
| expect `gantry` | **missing** (by 18 min) | |
| expect `complex-production` | **missing** (by 18 min) | |
| expect `gantry-production` | **missing** (by 18 min) | |
| expect `landfall` | **missing** (by 18 min) | |
| expect `backline` | **missing** (by 18 min) | |
| forbid `errors` | **hit** | `I/build-theatres/games/sea/combat/amphib-transition-armada/supreme/20261006T021903Z-09b858d6/AI/Skirmish/BARbTest/test/script/src/manager/military.as (15, 87) : ERR  : No matching symbol 'TaskF::Wait'` |

## Failures

- forbid 'errors' hit at 0.0 min: I/build-theatres/games/sea/combat/amphib-transition-armada/supreme/20261006T021903Z-09b858d6/AI/Skirmish/BARbTest/test/script/src/manager/military.as (15, 87) : ERR  : No matching symbol 'TaskF::Wait'
- forbid 'errors' hit at 0.0 min: I/build-theatres/games/sea/combat/amphib-transition-armada/supreme/20261006T021903Z-09b858d6/AI/Skirmish/BARbTest/test/script/src/manager/military.as (15, 87) : ERR  : No matching symbol 'TaskF::Wait'
- forbid 'errors' hit at 0.2 min: [t=00:00:48.753511][f=0000300] [SeaInvasionTest] FAIL missing armmm

## Script errors

```
[t=00:00:40.946399][f=-000001] Skirmish AI <BARb playtest-test>: C:/bardev/s3k-CircuitAI/build-theatres/games/sea/combat/amphib-transition-armada/supreme/20261006T021903Z-09b858d6/AI/Skirmish/BARbTest/test/script/src/manager/military.as (15, 87) : ERR  : No matching symbol 'TaskF::Wait'
[t=00:00:41.343230][f=-000001] Skirmish AI <BARb playtest-test>: Script: Fix compilation errors!
[t=00:00:42.038242][f=-000001] Skirmish AI <BARb playtest-test>: C:/bardev/s3k-CircuitAI/build-theatres/games/sea/combat/amphib-transition-armada/supreme/20261006T021903Z-09b858d6/AI/Skirmish/BARbTest/test/script/src/manager/military.as (15, 87) : ERR  : No matching symbol 'TaskF::Wait'
[t=00:00:42.433734][f=-000001] Skirmish AI <BARb playtest-test>: Script: Fix compilation errors!
```

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T021903Z-09b858d6\runs\20261006T022058Z-5ff2119e\screen_2026-10-06_02-20-09-850.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T021903Z-09b858d6\runs\20261006T022058Z-5ff2119e\screen_2026-10-06_02-20-21-477.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T021903Z-09b858d6\runs\20261006T022058Z-5ff2119e\screen_2026-10-06_02-20-40-418.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 20, 4 shots, end at 18.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 20000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (5800, 10500) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.00  [Playtest] speed 20
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai false dead false start (5800, 10500) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai false dead false start (11456, 1901) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 33
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
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.17  [Playtest] finished armuwmmm team 0 at 0.17 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +467.5 bank 43128/100300, energy +29006.0 bank 1048088/1061500, units 107
  2.00  [Playtest] eco team 0 at 2.0 min: metal +467.5 bank 71176/100300, energy +29006.0 bank 1048088/1061500, units 107
  2.00  [Playtest] camera requested (8500,6500) height=8500
  2.01  [Playtest] camera captured name=ta position=(8500,6500) height=8500
  2.01  [Playtest] screenshot at 2.0 min of team 0 at (8500, 6500)
  3.00  [Playtest] eco team 0 at 3.0 min: metal +467.5 bank 99225/100300, energy +29006.0 bank 1048088/1061500, units 331
  4.00  [Playtest] eco team 0 at 4.0 min: metal +467.5 bank 100300/100300, energy +29006.0 bank 1048088/1061500, units 331
  5.00  [Playtest] eco team 0 at 5.0 min: metal +467.5 bank 100300/100300, energy +29006.0 bank 1048088/1061500, units 331
  5.00  [Playtest] camera requested (10800,4000) height=6500
  5.00  [Playtest] camera captured name=ta position=(10800,4000) height=6500
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (10800, 4000)
  6.00  [Playtest] eco team 0 at 6.0 min: metal +467.5 bank 100300/100300, energy +29006.0 bank 1048088/1061500, units 331
  7.00  [Playtest] eco team 0 at 7.0 min: metal +467.5 bank 100300/100300, energy +29006.0 bank 1048088/1061500, units 331
  8.00  [Playtest] eco team 0 at 8.0 min: metal +467.5 bank 100300/100300, energy +29006.0 bank 1048088/1061500, units 331
  9.00  [Playtest] eco team 0 at 9.0 min: metal +467.5 bank 100300/100300, energy +29006.0 bank 1048088/1061500, units 331
 10.00  [Playtest] eco team 0 at 10.0 min: metal +467.5 bank 100300/100300, energy +29006.0 bank 1048088/1061500, units 331
 10.00  [Playtest] camera requested (10800,4000) height=5500
 10.00  [Playtest] camera captured name=ta position=(10800,4000) height=5500
 10.00  [Playtest] screenshot at 10.0 min of team 0 at (10800, 4000)
 11.00  [Playtest] eco team 0 at 11.0 min: metal +467.5 bank 100300/100300, energy +29006.0 bank 1048088/1061500, units 331
 12.00  [Playtest] eco team 0 at 12.0 min: metal +467.5 bank 100300/100300, energy +29006.0 bank 1048088/1061500, units 331
 13.00  [Playtest] eco team 0 at 13.0 min: metal +467.5 bank 100300/100300, energy +29006.0 bank 1048088/1061500, units 331
```

## Native lines (all AIs, first 120)

```
```
