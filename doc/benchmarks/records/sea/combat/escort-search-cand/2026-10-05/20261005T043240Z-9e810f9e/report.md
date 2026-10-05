# Playtest report: PASS

- Verdict: **PASS** (reached 6 min)
- Game time reached: 6.0 min (frame 10800); wall 71 s
- DLL: build-theatres\d200\build-3\SkirmishAI.dll (bcac8c987b1d8164); AI BARbTest/test; staged 2026-10-05T01:31:25
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea-fleet-escort.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\escort-search-cand\glacial\20261005T043125Z-4d6a08f2\runs\20261005T043240Z-9e810f9e\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `escort` | seen at 0.2 min | `[SEA][Escort] armsjam follows 0:180` |
| expect `fleet-search` | seen at 0.2 min | `[SEA][Fleet] armpship n=8 target=-1 goal=3424,3632` |
| expect `combat` | seen at 1.4 min | `[t=00:00:45.697733][f=0002522] [SeaArena] frame=2522 damage victim=29006 attacker=18885 team=1 amount=97.8 attackerUnit=corpship victimUnit=armpship produced=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\escort-search-cand\glacial\20261005T043125Z-4d6a08f2\runs\20261005T043240Z-9e810f9e\screen_2026-10-05_04-32-08-814.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\escort-search-cand\glacial\20261005T043125Z-4d6a08f2\runs\20261005T043240Z-9e810f9e\screen_2026-10-05_04-32-11-298.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\escort-search-cand\glacial\20261005T043125Z-4d6a08f2\runs\20261005T043240Z-9e810f9e\screen_2026-10-05_04-32-24-044.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 12, 4 shots, end at 6.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (2300, 4400) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (4600, 4400) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 12
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (2300, 4400) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (4600, 4400) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.40  [Playtest] camera requested (3400,4450) height=2400
  0.40  [Playtest] camera captured name=ta position=(3400,4450) height=2400
  0.40  [Playtest] screenshot at 0.4 min of team 0 at (3400, 4450)
  0.70  [Playtest] camera requested (3400,4450) height=2400
  0.70  [Playtest] camera captured name=ta position=(3400,4450) height=2400
  0.70  [Playtest] screenshot at 0.7 min of team 0 at (3400, 4450)
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 992590/1000000, units 11
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 984400/1000000, units 1
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 986200/1000000, units 1
  3.00  [Playtest] camera requested (3400,4450) height=3200
  3.00  [Playtest] camera captured name=ta position=(3400,4450) height=3200
  3.00  [Playtest] screenshot at 3.0 min of team 0 at (3400, 4450)
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 988000/1000000, units 1
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 989800/1000000, units 1
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 991600/1000000, units 1
```

## Native lines (all AIs, first 120)

```
```
