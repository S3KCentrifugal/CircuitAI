# Playtest report: PASS

- Verdict: **PASS** (reached 4 min)
- Game time reached: 4.1 min (frame 7350); wall 74 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (5ffc6c0f33ea506b); AI BARbTest/test; staged 2026-10-05T19:04:51
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/armada/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI 0, role FRONT
- Checks: ranged-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-mixed-sensors\glitters\20261005T220451Z-b71f2013\runs\20261005T220610Z-cfe7154f\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:31.745925][f=-000001] [RangedArena] frame=0 loaded case=ranged-mixed-sensors variant=ranged` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:41.303184][f=0000301] [RangedArena] frame=301 spawn id=14262 team=0 unit=armarad x=3200 z=3500` |
| expect `damage` | seen at 0.9 min | `[t=00:00:47.164494][f=0001554] [RangedArena] frame=1554 damage id=7383 team=1 amount=382 attacker=14370 attackerTeam=0 weapon=196` |
| expect `orders` | seen at 0.3 min | `[t=00:00:42.547672][f=0000600] [RangedArena] frame=600 orders team=0 total=43 nonlua=43 lua=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-mixed-sensors\glitters\20261005T220451Z-b71f2013\runs\20261005T220610Z-cfe7154f\screen_2026-10-05_22-05-42-611.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-mixed-sensors\glitters\20261005T220451Z-b71f2013\runs\20261005T220610Z-cfe7154f\screen_2026-10-05_22-05-52-706.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-mixed-sensors\glitters\20261005T220451Z-b71f2013\runs\20261005T220610Z-cfe7154f\screen_2026-10-05_22-06-04-443.png

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
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 974237/1000000, units 18
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 947462/1000000, units 18
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 921662/1000000, units 18
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 895862/1000000, units 18
```

## Native lines (all AIs, first 120)

```
```
