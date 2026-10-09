# Playtest report: PASS

- Verdict: **PASS** (reached 4 min)
- Game time reached: 4.1 min (frame 7350); wall 75 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (5ffc6c0f33ea506b); AI BARbTest/test; staged 2026-10-05T18:59:35
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/armada/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI 0, role FRONT
- Checks: ranged-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-starlight-closing\glitters\20261005T215935Z-6e1bf88b\runs\20261005T220054Z-d8d8217e\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:33.045234][f=-000001] [RangedArena] frame=0 loaded case=ranged-starlight-closing variant=ranged` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:42.323890][f=0000301] [RangedArena] frame=301 spawn id=14262 team=0 unit=armarad x=3600 z=4750` |
| expect `damage` | seen at 0.2 min | `[t=00:00:42.464883][f=0000330] [RangedArena] frame=330 damage id=15598 team=1 amount=148 attacker=7383 attackerTeam=0 weapon=236` |
| expect `orders` | seen at 0.3 min | `[t=00:00:43.640606][f=0000600] [RangedArena] frame=600 orders team=0 total=134 nonlua=134 lua=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-starlight-closing\glitters\20261005T215935Z-6e1bf88b\runs\20261005T220054Z-d8d8217e\screen_2026-10-05_22-00-27-262.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-starlight-closing\glitters\20261005T215935Z-6e1bf88b\runs\20261005T220054Z-d8d8217e\screen_2026-10-05_22-00-37-286.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-starlight-closing\glitters\20261005T215935Z-6e1bf88b\runs\20261005T220054Z-d8d8217e\screen_2026-10-05_22-00-49-025.png

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
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 993500/1000000, units 10
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 988500/1000000, units 8
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 983500/1000000, units 8
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 980500/1000000, units 8
```

## Native lines (all AIs, first 120)

```
```
