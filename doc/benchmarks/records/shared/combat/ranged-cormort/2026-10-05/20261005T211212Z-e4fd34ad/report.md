# Playtest report: PASS

- Verdict: **PASS** (reached 4 min)
- Game time reached: 4.1 min (frame 7350); wall 75 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (af16eafa2a99324c); AI BARbTest/test; staged 2026-10-05T18:10:53
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/cortex/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI 0, role FRONT
- Checks: ranged-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-cormort\glitters\20261005T211053Z-febf14c1\runs\20261005T211212Z-e4fd34ad\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:32.364327][f=-000001] [RangedArena] frame=0 loaded case=ranged-cormort variant=ranged` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:42.001846][f=0000300] [RangedArena] frame=300 spawn id=14262 team=0 unit=armarad x=3900 z=4750` |
| expect `damage` | seen at 0.3 min | `[t=00:00:43.127326][f=0000571] [RangedArena] frame=571 damage id=29947 team=1 amount=105 attacker=22963 attackerTeam=0 weapon=554` |
| expect `orders` | seen at 0.3 min | `[t=00:00:43.244357][f=0000600] [RangedArena] frame=600 orders team=0 total=74 nonlua=74 lua=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-cormort\glitters\20261005T211053Z-febf14c1\runs\20261005T211212Z-e4fd34ad\screen_2026-10-05_21-11-45-070.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-cormort\glitters\20261005T211053Z-febf14c1\runs\20261005T211212Z-e4fd34ad\screen_2026-10-05_21-11-55-224.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-cormort\glitters\20261005T211053Z-febf14c1\runs\20261005T211212Z-e4fd34ad\screen_2026-10-05_21-12-06-936.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role FRONT, team 0, speed 8, 0 shots, end at 4.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished corcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side cortex ai true dead false start (4000, 2400) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 8
  0.05  [Playtest] frame 90 team 0 ally 0 side cortex ai true dead false start (4000, 2400) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.17  [Playtest] finished armarad team 0 at 0.17 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +37.0 bank 997843/1000050, units 9
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +37.0 bank 995263/1000050, units 9
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +37.0 bank 992683/1000050, units 9
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +37.0 bank 990103/1000050, units 9
```

## Native lines (all AIs, first 120)

```
```
