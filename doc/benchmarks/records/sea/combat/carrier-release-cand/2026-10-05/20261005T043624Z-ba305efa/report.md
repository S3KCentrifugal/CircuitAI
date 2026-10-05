# Playtest report: PASS

- Verdict: **PASS** (reached 6 min)
- Game time reached: 6.0 min (frame 10800); wall 71 s
- DLL: build-theatres\d200\build-3\SkirmishAI.dll (bcac8c987b1d8164); AI BARbTest/test; staged 2026-10-05T01:35:10
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/legion/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\carrier-release-cand\glacial\20261005T043510Z-a78737dd\runs\20261005T043624Z-ba305efa\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:29.033027][f=-000001] [SeaArena] frame=0 loaded case=carrier-release control=false` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:36.878297][f=0000301] [SeaArena] frame=301 spawn id=24620 team=0 unit=legnavydestro` |
| expect `combat` | seen at 0.3 min | `[t=00:00:37.523126][f=0000534] [SeaArena] frame=534 damage victim=1602 attacker=29006 team=0 amount=9.6 attackerUnit=legnavydestro victimUnit=corsnap produced=false` |
| expect `orders` | seen at 1.0 min | `[t=00:00:43.288506][f=0001800] [SeaArena] frame=1800 orders team=1 apm=893 repeated=20` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\carrier-release-cand\glacial\20261005T043510Z-a78737dd\runs\20261005T043624Z-ba305efa\screen_2026-10-05_04-35-53-148.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\carrier-release-cand\glacial\20261005T043510Z-a78737dd\runs\20261005T043624Z-ba305efa\screen_2026-10-05_04-35-55-630.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\carrier-release-cand\glacial\20261005T043510Z-a78737dd\runs\20261005T043624Z-ba305efa\screen_2026-10-05_04-36-08-387.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 12, 4 shots, end at 6.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished legcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side legion ai true dead false start (2300, 4400) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (4600, 4400) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 12
  0.05  [Playtest] frame 90 team 0 ally 0 side legion ai true dead false start (2300, 4400) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (4600, 4400) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.20  [Playtest] finished armfrad team 0 at 0.20 min
  0.40  [Playtest] camera requested (3400,4450) height=2400
  0.40  [Playtest] camera captured name=ta position=(3400,4450) height=2400
  0.40  [Playtest] screenshot at 0.4 min of team 0 at (3400, 4450)
  0.70  [Playtest] camera requested (3400,4450) height=2400
  0.70  [Playtest] camera captured name=ta position=(3400,4450) height=2400
  0.70  [Playtest] screenshot at 0.7 min of team 0 at (3400, 4450)
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 997397/1000000, units 19
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 999197/1000000, units 1
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 1
  3.00  [Playtest] camera requested (3400,4450) height=3200
  3.00  [Playtest] camera captured name=ta position=(3400,4450) height=3200
  3.00  [Playtest] screenshot at 3.0 min of team 0 at (3400, 4450)
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 1
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 1
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 1
```

## Native lines (all AIs, first 120)

```
```
