# Playtest report: PASS

- Verdict: **PASS** (reached 4 min)
- Game time reached: 4.0 min (frame 7200); wall 77 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (68fa9679ca2841d0); AI BARbTest/test; staged 2026-10-05T18:48:01
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/armada/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI 0, role FRONT
- Checks: ranged-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-sniper-bait\glitters\20261005T214800Z-1f697ed7\runs\20261005T214923Z-3e7477f4\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:33.802731][f=-000001] [RangedArena] frame=0 loaded case=ranged-sniper-bait variant=ranged` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:43.750358][f=0000300] [RangedArena] frame=300 spawn id=14262 team=0 unit=armarad x=3600 z=4750` |
| expect `damage` | seen at 0.4 min | `[t=00:00:45.392579][f=0000631] [RangedArena] frame=631 damage id=15598 team=1 amount=2502 attacker=26019 attackerTeam=0 weapon=283` |
| expect `orders` | seen at 0.3 min | `[t=00:00:45.231480][f=0000600] [RangedArena] frame=600 orders team=0 total=110 nonlua=110 lua=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-sniper-bait\glitters\20261005T214800Z-1f697ed7\runs\20261005T214923Z-3e7477f4\screen_2026-10-05_21-48-56-016.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-sniper-bait\glitters\20261005T214800Z-1f697ed7\runs\20261005T214923Z-3e7477f4\screen_2026-10-05_21-49-06-075.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-sniper-bait\glitters\20261005T214800Z-1f697ed7\runs\20261005T214923Z-3e7477f4\screen_2026-10-05_21-49-17-814.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role FRONT, team 0, speed 8, 0 shots, end at 4.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000000/1000000, energy +0.0 bank 1000000/1000000, units 1
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
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000000/1000000, energy +30.0 bank 964550/1000000, units 10
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000000/1000000, energy +30.0 bank 934350/1000000, units 10
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000000/1000000, energy +30.0 bank 904350/1000000, units 10
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000000/1000000, energy +30.0 bank 874350/1000000, units 10
```

## Native lines (all AIs, first 120)

```
```
