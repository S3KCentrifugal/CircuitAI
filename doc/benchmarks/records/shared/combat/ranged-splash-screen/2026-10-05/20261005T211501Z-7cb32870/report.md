# Playtest report: PASS

- Verdict: **PASS** (reached 4 min)
- Game time reached: 4.1 min (frame 7350); wall 71 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (af16eafa2a99324c); AI BARbTest/test; staged 2026-10-05T18:13:46
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/armada/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI 0, role FRONT
- Checks: ranged-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-splash-screen\glitters\20261005T211346Z-f33aebf5\runs\20261005T211501Z-7cb32870\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:29.369729][f=-000001] [RangedArena] frame=0 loaded case=ranged-splash-screen variant=ranged` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:37.878991][f=0000300] [RangedArena] frame=300 spawn id=14262 team=0 unit=armarad x=3600 z=4750` |
| expect `damage` | seen at 0.3 min | `[t=00:00:38.654681][f=0000484] [RangedArena] frame=484 damage id=10085 team=1 amount=157 attacker=3874 attackerTeam=0 weapon=263` |
| expect `orders` | seen at 0.3 min | `[t=00:00:39.366241][f=0000600] [RangedArena] frame=600 orders team=0 total=179 nonlua=177 lua=2` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-splash-screen\glitters\20261005T211346Z-f33aebf5\runs\20261005T211501Z-7cb32870\screen_2026-10-05_21-14-34-599.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-splash-screen\glitters\20261005T211346Z-f33aebf5\runs\20261005T211501Z-7cb32870\screen_2026-10-05_21-14-44-603.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-splash-screen\glitters\20261005T211346Z-f33aebf5\runs\20261005T211501Z-7cb32870\screen_2026-10-05_21-14-56-336.png

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
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +37.0 bank 997836/1000050, units 8
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +37.0 bank 995256/1000050, units 8
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +37.0 bank 992676/1000050, units 8
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +37.0 bank 990096/1000050, units 8
```

## Native lines (all AIs, first 120)

```
```
