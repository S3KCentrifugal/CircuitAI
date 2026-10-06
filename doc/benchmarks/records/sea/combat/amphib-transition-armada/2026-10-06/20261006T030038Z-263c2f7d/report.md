# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 2.1 min (frame 3783); wall 100 s
- DLL: build-theatres\d212-final\SkirmishAI.dll (f224e17dc3c6f798); AI BARbTest/test; staged 2026-10-05T23:58:48
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: amphibious-transition.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T025847Z-dda77ab8\runs\20261006T030038Z-263c2f7d\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `partial-survey` | seen at 1.8 min | `[t=00:01:03.112069][f=0003300] [SeaInvasionTest] PASS partial-survey-blocked` |
| expect `complex` | **missing** (by 18 min) | |
| expect `gantry` | **missing** (by 18 min) | |
| expect `complex-production` | **missing** (by 18 min) | |
| expect `gantry-production` | **missing** (by 18 min) | |
| expect `landfall` | **missing** (by 18 min) | |
| expect `backline` | **missing** (by 18 min) | |
| expect `escort` | **missing** (by 18 min) | |
| expect `gantry-landing` | **missing** (by 24 min) | |
| expect `gantry-backline` | **missing** (by 24 min) | |
| expect `combat` | **missing** (by 24 min) | |
| forbid `errors` | **hit** | `[t=00:01:06.401957][f=0003783] Error: Spring 2026.07.04 has crashed.` |

## Failures

- forbid 'errors' hit at 2.1 min: [t=00:01:06.401957][f=0003783] Error: Spring 2026.07.04 has crashed.
- forbid 'errors' hit at 2.1 min: [t=00:01:06.458549][f=0003783] Error: Exception: Access violation (0xc0000005)
- forbid 'errors' hit at 2.1 min: [t=00:01:32.235284][f=0003783] Fatal: [ExitSpringProcess] errorMsg="Spring has crashed:

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T025847Z-dda77ab8\runs\20261006T030038Z-263c2f7d\screen_2026-10-06_03-00-03-650.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 20, 4 shots, end at 24.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 20000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (5800, 10500) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 35
  0.00  [Playtest] speed 20
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (5800, 10500) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 35
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.18  [Playtest] finished armsy team 0 at 0.18 min
  0.18  [Playtest] finished armasy team 0 at 0.18 min
  0.18  [Playtest] finished armplat team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [SEA][Layout] berth sea.berth.0 armasy at=6544,10032 facing=2
  0.20  [SEA][Layout] berth sea.berth.1 armplat at=6144,10032 facing=2
  0.42  [SEA][Layout] berth sea.berth.2 armsy at=6352,10032 facing=2
  0.67  [Playtest] finished armtide team 0 at 0.67 min
  0.71  [Playtest] finished armnanotcplat team 0 at 0.71 min
  0.86  [Playtest] finished armmex team 0 at 0.86 min
  0.87  [Team][Roster] first mex 9658 at 6848,9664
  0.87  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|5826|10504|0|7|1|6848|9664
  0.95  [Playtest] finished armuwmme team 0 at 0.95 min
  0.98  [Playtest] finished armnanotcplat team 0 at 0.98 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +479.7 bank 41714/100950, energy +29027.0 bank 1048067/1061550, units 115
  1.49  [Playtest] finished armason team 0 at 1.49 min
  1.73  [Playtest] finished armuwmme team 0 at 1.73 min
  1.95  [Playtest] finished armmex team 0 at 1.95 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +489.7 bank 68757/101550, energy +29027.0 bank 1047797/1061550, units 121
  2.00  [Playtest] camera requested (8500,6500) height=8500
  2.00  [Playtest] finished armuwmmm team 0 at 2.00 min
  2.02  [Playtest] camera captured name=ta position=(8500,6500) height=8500
  2.02  [Playtest] screenshot at 2.0 min of team 0 at (8500, 6500)
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: zone 1 at (5912, 11112) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5912, 11112) facing 2 (id 1)
  0.08  RESERVE: zone 1 released
  0.08  RESERVE: zone 2 at (5864, 10984) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5864, 10984) facing 2 (id 2)
  0.08  RESERVE: zone 3 at (5816, 10984) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5816, 10984) facing 2 (id 3)
  0.08  RESERVE: zone 2 released
  0.08  RESERVE: zone 3 released
  0.08  RESERVE: zone 4 at (5880, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5880, 10952) facing 2 (id 4)
  0.08  RESERVE: zone 5 at (5832, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5832, 10952) facing 2 (id 5)
  0.08  RESERVE: zone 6 at (5784, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5784, 10952) facing 2 (id 6)
  0.08  RESERVE: zone 4 released
  0.08  RESERVE: zone 5 released
  0.08  RESERVE: zone 6 released
  0.08  RESERVE: zone 7 at (5912, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5912, 10936) facing 2 (id 7)
  0.08  RESERVE: zone 8 at (5864, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5864, 10936) facing 2 (id 8)
  0.08  RESERVE: zone 9 at (5816, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5816, 10936) facing 2 (id 9)
  0.08  RESERVE: zone 10 at (5768, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5768, 10936) facing 2 (id 10)
  0.08  RESERVE: zone 7 released
  0.08  RESERVE: zone 8 released
  0.08  RESERVE: zone 9 released
  0.08  RESERVE: zone 10 released
  0.08  RESERVE: zone 11 at (5944, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5944, 10920) facing 2 (id 11)
  0.08  RESERVE: zone 12 at (5896, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5896, 10920) facing 2 (id 12)
  0.08  RESERVE: zone 13 at (5848, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5848, 10920) facing 2 (id 13)
  0.08  RESERVE: zone 14 at (5800, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5800, 10920) facing 2 (id 14)
  0.08  RESERVE: zone 11 released
  0.08  RESERVE: zone 12 released
  0.08  RESERVE: zone 13 released
  0.08  RESERVE: zone 14 released
  0.12  RESERVE: zone 15 at (5976, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5976, 10936) facing 2 (id 15)
  0.12  RESERVE: zone 16 at (5928, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5928, 10936) facing 2 (id 16)
  0.12  RESERVE: zone 17 at (5880, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5880, 10936) facing 2 (id 17)
  0.12  RESERVE: zone 18 at (5832, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5832, 10936) facing 2 (id 18)
  0.12  RESERVE: zone 19 at (5784, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5784, 10936) facing 2 (id 19)
  0.12  RESERVE: zone 15 released
  0.12  RESERVE: zone 16 released
  0.12  RESERVE: zone 17 released
  0.12  RESERVE: zone 18 released
  0.12  RESERVE: zone 19 released
  0.12  RESERVE: zone 20 at (6008, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (6008, 10952) facing 2 (id 20)
  0.12  RESERVE: zone 21 at (5960, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5960, 10952) facing 2 (id 21)
  0.12  RESERVE: zone 22 at (5912, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5912, 10952) facing 2 (id 22)
  0.12  RESERVE: zone 23 at (5864, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5864, 10952) facing 2 (id 23)
  0.12  RESERVE: zone 24 at (5816, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5816, 10952) facing 2 (id 24)
  0.12  RESERVE: zone 25 at (5768, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5768, 10952) facing 2 (id 25)
  0.12  RESERVE: zone 26 at (6008, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (6008, 10904) facing 2 (id 26)
  0.12  RESERVE: zone 27 at (5960, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5960, 10904) facing 2 (id 27)
  0.12  RESERVE: zone 28 at (5912, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5912, 10904) facing 2 (id 28)
  0.12  RESERVE: zone 29 at (5864, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5864, 10904) facing 2 (id 29)
  0.12  RESERVE: zone 30 at (5816, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5816, 10904) facing 2 (id 30)
  0.12  RESERVE: zone 31 at (5768, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5768, 10904) facing 2 (id 31)
  0.12  RESERVE: zone 32 at (6008, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (6008, 10856) facing 2 (id 32)
  0.12  RESERVE: zone 33 at (5960, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5960, 10856) facing 2 (id 33)
  0.12  RESERVE: zone 34 at (5912, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5912, 10856) facing 2 (id 34)
  0.12  RESERVE: zone 35 at (5864, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5864, 10856) facing 2 (id 35)
  0.12  RESERVE: zone 36 at (5816, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5816, 10856) facing 2 (id 36)
  0.12  RESERVE: zone 37 at (5768, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5768, 10856) facing 2 (id 37)
  0.12  RESERVE: zone 38 at (6008, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (6008, 10808) facing 2 (id 38)
  0.12  RESERVE: zone 39 at (5960, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5960, 10808) facing 2 (id 39)
  0.12  RESERVE: zone 40 at (5912, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5912, 10808) facing 2 (id 40)
  0.12  RESERVE: zone 41 at (5864, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5864, 10808) facing 2 (id 41)
  0.12  RESERVE: zone 42 at (5816, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5816, 10808) facing 2 (id 42)
  0.12  RESERVE: zone 43 at (5768, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5768, 10808) facing 2 (id 43)
  0.12  RESERVE: zone 44 at (6008, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (6008, 10760) facing 2 (id 44)
  0.12  RESERVE: zone 45 at (5960, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5960, 10760) facing 2 (id 45)
  0.12  RESERVE: zone 46 at (5912, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5912, 10760) facing 2 (id 46)
  0.12  RESERVE: zone 47 at (5864, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5864, 10760) facing 2 (id 47)
  0.12  RESERVE: zone 48 at (5816, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5816, 10760) facing 2 (id 48)
  0.12  RESERVE: zone 49 at (5768, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5768, 10760) facing 2 (id 49)
  0.12  RESERVE: zone 50 at (6008, 10712) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (6008, 10712) facing 2 (id 50)
  0.12  RESERVE: zone 51 at (5960, 10712) facing 2, 3x3 cells: 9 of 9 held
```
