# Playtest report: PASS

- Verdict: **PASS** (reached 4 min)
- Game time reached: 4.0 min (frame 7200); wall 71 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (af16eafa2a99324c); AI BARbTest/test; staged 2026-10-05T17:58:22
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/armada/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI 0, role FRONT
- Checks: ranged-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-mixed-sensors\glitters\20261005T205821Z-7ccacc77\runs\20261005T205936Z-2e25e456\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:29.291225][f=-000001] [RangedArena] frame=0 loaded case=ranged-mixed-sensors variant=ranged` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:37.851932][f=0000300] [RangedArena] frame=300 spawn id=14262 team=0 unit=armarad x=3200 z=3500` |
| expect `damage` | seen at 0.9 min | `[t=00:00:44.237771][f=0001532] [RangedArena] frame=1532 damage id=7383 team=1 amount=800 attacker=14370 attackerTeam=0 weapon=196` |
| expect `orders` | seen at 0.3 min | `[t=00:00:39.225101][f=0000600] [RangedArena] frame=600 orders team=0 total=43 nonlua=43 lua=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-mixed-sensors\glitters\20261005T205821Z-7ccacc77\runs\20261005T205936Z-2e25e456\screen_2026-10-05_20-59-09-916.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-mixed-sensors\glitters\20261005T205821Z-7ccacc77\runs\20261005T205936Z-2e25e456\screen_2026-10-05_20-59-19-981.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-mixed-sensors\glitters\20261005T205821Z-7ccacc77\runs\20261005T205936Z-2e25e456\screen_2026-10-05_20-59-31-718.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role FRONT, team 0, speed 8, 0 shots, end at 4.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4000, 2400) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 8
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4000, 2400) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.17  [Playtest] finished armarad team 0 at 0.17 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 969562/1000000, units 18
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 941537/1000000, units 18
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 915737/1000000, units 18
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 889937/1000000, units 18
```

## Native lines (all AIs, first 120)

```
```
