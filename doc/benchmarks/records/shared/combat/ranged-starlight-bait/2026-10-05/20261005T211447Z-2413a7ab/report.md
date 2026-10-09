# Playtest report: PASS

- Verdict: **PASS** (reached 4 min)
- Game time reached: 4.0 min (frame 7200); wall 71 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (af16eafa2a99324c); AI BARbTest/test; staged 2026-10-05T18:13:32
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/armada/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI 0, role FRONT
- Checks: ranged-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-starlight-bait\glitters\20261005T211331Z-a58eb56e\runs\20261005T211447Z-2413a7ab\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:30.396338][f=-000001] [RangedArena] frame=0 loaded case=ranged-starlight-bait variant=ranged` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:39.141615][f=0000301] [RangedArena] frame=301 spawn id=14262 team=0 unit=armarad x=3600 z=4750` |
| expect `damage` | seen at 0.2 min | `[t=00:00:39.441692][f=0000373] [RangedArena] frame=373 damage id=15598 team=1 amount=155 attacker=18782 attackerTeam=0 weapon=236` |
| expect `orders` | seen at 0.3 min | `[t=00:00:40.389343][f=0000600] [RangedArena] frame=600 orders team=0 total=161 nonlua=161 lua=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-starlight-bait\glitters\20261005T211331Z-a58eb56e\runs\20261005T211447Z-2413a7ab\screen_2026-10-05_21-14-20-788.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-starlight-bait\glitters\20261005T211331Z-a58eb56e\runs\20261005T211447Z-2413a7ab\screen_2026-10-05_21-14-30-791.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-starlight-bait\glitters\20261005T211331Z-a58eb56e\runs\20261005T211447Z-2413a7ab\screen_2026-10-05_21-14-42-530.png

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
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000000/1000000, energy +30.0 bank 979500/1000000, units 10
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000000/1000000, energy +30.0 bank 976500/1000000, units 10
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000000/1000000, energy +30.0 bank 973500/1000000, units 10
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000000/1000000, energy +30.0 bank 970500/1000000, units 10
```

## Native lines (all AIs, first 120)

```
```
