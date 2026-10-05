# Playtest report: PASS

- Verdict: **PASS** (reached 6 min)
- Game time reached: 6.0 min (frame 10800); wall 70 s
- DLL: build-theatres\d200\build-3\SkirmishAI.dll (bcac8c987b1d8164); AI BARbTest/test; staged 2026-10-05T02:05:45
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\surface-line-cand\glacial\20261005T050545Z-17417428\runs\20261005T050658Z-fb9160e8\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:28.498101][f=-000001] [SeaArena] frame=0 loaded case=surface-line control=false` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:36.436453][f=0000302] [SeaArena] frame=302 spawn id=24620 team=0 unit=armroy` |
| expect `combat` | seen at 0.6 min | `[t=00:00:39.370387][f=0001007] [SeaArena] frame=1007 damage victim=22959 attacker=29006 team=0 amount=225.1 attackerUnit=armroy victimUnit=corason produced=false` |
| expect `orders` | seen at 1.0 min | `[t=00:00:42.820346][f=0001800] [SeaArena] frame=1800 orders team=1 apm=74 repeated=1` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\surface-line-cand\glacial\20261005T050545Z-17417428\runs\20261005T050658Z-fb9160e8\screen_2026-10-05_05-06-27-534.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\surface-line-cand\glacial\20261005T050545Z-17417428\runs\20261005T050658Z-fb9160e8\screen_2026-10-05_05-06-30-017.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\surface-line-cand\glacial\20261005T050545Z-17417428\runs\20261005T050658Z-fb9160e8\screen_2026-10-05_05-06-42-763.png

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
  0.19  [Playtest] finished armfrad team 0 at 0.19 min
  0.19  [Playtest] finished armason team 0 at 0.19 min
  0.40  [Playtest] camera requested (3400,4450) height=2400
  0.40  [Playtest] camera captured name=ta position=(3400,4450) height=2400
  0.40  [Playtest] screenshot at 0.4 min of team 0 at (3400, 4450)
  0.70  [Playtest] camera requested (3400,4450) height=2400
  0.70  [Playtest] camera captured name=ta position=(3400,4450) height=2400
  0.70  [Playtest] screenshot at 0.7 min of team 0 at (3400, 4450)
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 6
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 3
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 3
  3.00  [Playtest] camera requested (3400,4450) height=3200
  3.00  [Playtest] camera captured name=ta position=(3400,4450) height=3200
  3.00  [Playtest] screenshot at 3.0 min of team 0 at (3400, 4450)
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 3
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 3
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 3
```

## Native lines (all AIs, first 120)

```
```
