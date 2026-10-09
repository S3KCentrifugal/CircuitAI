# Playtest report: PASS

- Verdict: **PASS** (reached 4 min)
- Game time reached: 4.0 min (frame 7200); wall 69 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (af16eafa2a99324c); AI BARbTest/test; staged 2026-10-05T18:15:02
- Map: Comet Catcher Remake 1.8; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/armada/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI 0, role FRONT
- Checks: ranged-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-mixed-flat\comet\20261005T211502Z-acaf8535\runs\20261005T211614Z-9d50eedd\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:27.048459][f=-000001] [RangedArena] frame=0 loaded case=ranged-mixed-flat variant=ranged` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:35.653469][f=0000300] [RangedArena] frame=300 spawn id=14262 team=0 unit=armarad x=3200 z=3500` |
| expect `damage` | seen at 0.9 min | `[t=00:00:42.106872][f=0001551] [RangedArena] frame=1551 damage id=7383 team=1 amount=800 attacker=14370 attackerTeam=0 weapon=196` |
| expect `orders` | seen at 0.3 min | `[t=00:00:37.127511][f=0000600] [RangedArena] frame=600 orders team=0 total=38 nonlua=38 lua=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-mixed-flat\comet\20261005T211502Z-acaf8535\runs\20261005T211614Z-9d50eedd\screen_2026-10-05_21-15-47-962.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-mixed-flat\comet\20261005T211502Z-acaf8535\runs\20261005T211614Z-9d50eedd\screen_2026-10-05_21-15-58-011.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-mixed-flat\comet\20261005T211502Z-acaf8535\runs\20261005T211614Z-9d50eedd\screen_2026-10-05_21-16-09-749.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role FRONT, team 0, speed 8, 0 shots, end at 4.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4000, 1800) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (4000, 6144) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 8
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4000, 1800) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (4000, 6144) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.17  [Playtest] finished armarad team 0 at 0.17 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 976625/1000000, units 18
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 932850/1000000, units 18
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 907050/1000000, units 18
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 881250/1000000, units 18
```

## Native lines (all AIs, first 120)

```
```
