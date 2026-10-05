# Playtest report: PASS

- Verdict: **PASS** (reached 4 min)
- Game time reached: 4.2 min (frame 7500); wall 78 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (af16eafa2a99324c); AI BARbTest/test; staged 2026-10-05T18:11:08
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/legion/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI 0, role FRONT
- Checks: ranged-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-legvcarry\glitters\20261005T211107Z-d15fcefb\runs\20261005T211229Z-a5c65a16\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:32.403705][f=-000001] [RangedArena] frame=0 loaded case=ranged-legvcarry variant=ranged` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:43.118161][f=0000301] [RangedArena] frame=301 spawn id=14262 team=0 unit=armarad x=3900 z=4750` |
| expect `damage` | seen at 0.3 min | `[t=00:00:44.081512][f=0000486] [RangedArena] frame=486 damage id=15598 team=1 amount=12 attacker=3874 attackerTeam=0 weapon=912` |
| expect `orders` | seen at 0.3 min | `[t=00:00:44.676929][f=0000600] [RangedArena] frame=600 orders team=0 total=135 nonlua=106 lua=29` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-legvcarry\glitters\20261005T211107Z-d15fcefb\runs\20261005T211229Z-a5c65a16\screen_2026-10-05_21-12-01-570.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-legvcarry\glitters\20261005T211107Z-d15fcefb\runs\20261005T211229Z-a5c65a16\screen_2026-10-05_21-12-11-587.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-legvcarry\glitters\20261005T211107Z-d15fcefb\runs\20261005T211229Z-a5c65a16\screen_2026-10-05_21-12-23-328.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role FRONT, team 0, speed 8, 0 shots, end at 4.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished legcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000000/1000000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side legion ai true dead false start (4000, 2400) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 8
  0.05  [Playtest] frame 90 team 0 ally 0 side legion ai true dead false start (4000, 2400) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.17  [Playtest] finished armarad team 0 at 0.17 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 999853/1000000, energy +37.0 bank 991236/1000050, units 33
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 999973/1000000, energy +37.0 bank 988656/1000050, units 33
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000000/1000000, energy +37.0 bank 986076/1000050, units 33
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000000/1000000, energy +37.0 bank 983496/1000050, units 33
```

## Native lines (all AIs, first 120)

```
```
