# Playtest report: PASS

- Verdict: **PASS** (reached 2 min)
- Game time reached: 2.0 min (frame 3600); wall 159 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\ranged-rework\baseline\SkirmishAI.dll (9af405acf9a6180b); AI BARbTest/test; staged 2026-10-05T19:15:26
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/armada/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI 0, role FRONT
- Checks: ranged-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-population-120\glitters\20261005T221525Z-6136dd02\runs\20261005T221808Z-ed9e79dc\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:29.567900][f=-000001] [RangedArena] frame=0 loaded case=ranged-population-120 variant=baseline` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:46.776806][f=0000300] [RangedArena] frame=300 spawn id=14262 team=0 unit=armarad x=3000 z=4800` |
| expect `damage` | seen at 0.7 min | `[t=00:01:15.855851][f=0001171] [RangedArena] frame=1171 damage id=3464 team=1 amount=105 attacker=18895 attackerTeam=0 weapon=554` |
| expect `orders` | seen at 0.3 min | `[t=00:00:56.820739][f=0000600] [RangedArena] frame=600 orders team=0 total=620 nonlua=620 lua=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-population-120\glitters\20261005T221525Z-6136dd02\runs\20261005T221808Z-ed9e79dc\screen_2026-10-05_22-17-07-925.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role FRONT, team 0, speed 1, 0 shots, end at 2.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4000, 2400) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4000, 2400) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.17  [Playtest] finished armarad team 0 at 0.17 min
  0.17  [Playtest] finished armarad team 0 at 0.17 min
  0.17  [Playtest] finished armarad team 0 at 0.17 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 997165/1000000, units 128
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 895965/1000000, units 128
```

## Native lines (all AIs, first 120)

```
```
