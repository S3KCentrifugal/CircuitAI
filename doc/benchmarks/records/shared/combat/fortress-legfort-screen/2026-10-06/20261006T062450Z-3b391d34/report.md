# Playtest report: PASS

- Verdict: **PASS** (reached 2 min)
- Game time reached: 2.0 min (frame 3600); wall 60 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\d215\SkirmishAI.dll (9507e1c6b5eda75d); AI BARbTest/test; staged 2026-10-06T03:23:47
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/legion/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI 0, role FRONT
- Checks: ranged-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fortress-legfort-screen\glitters\20261006T062346Z-60bfe985\runs\20261006T062450Z-3b391d34\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:27.843689][f=-000001] [RangedArena] frame=0 loaded case=fortress-legfort-screen variant=ranged` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:36.863794][f=0000300] [RangedArena] frame=300 spawn id=14262 team=0 unit=armarad x=3250 z=4500` |
| expect `damage` | seen at 0.2 min | `[t=00:00:37.224944][f=0000365] [RangedArena] frame=365 damage id=15598 team=1 amount=36 attacker=31054 attackerTeam=0 weapon=948` |
| expect `orders` | seen at 0.3 min | `[t=00:00:38.528965][f=0000600] [RangedArena] frame=600 orders team=0 total=37 nonlua=37 lua=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fortress-legfort-screen\glitters\20261006T062346Z-60bfe985\runs\20261006T062450Z-3b391d34\screen_2026-10-06_06-24-31-121.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fortress-legfort-screen\glitters\20261006T062346Z-60bfe985\runs\20261006T062450Z-3b391d34\screen_2026-10-06_06-24-35-020.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fortress-legfort-screen\glitters\20261006T062346Z-60bfe985\runs\20261006T062450Z-3b391d34\screen_2026-10-06_06-24-43-109.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role FRONT, team 0, speed 6, 0 shots, end at 2.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished legcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side legion ai true dead false start (4000, 2400) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 6
  0.05  [Playtest] frame 90 team 0 ally 0 side legion ai true dead false start (4000, 2400) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.17  [Playtest] finished armarad team 0 at 0.17 min
  0.18  [Playtest] finished legfort team 0 at 0.19 min
  0.19  [Playtest] finished legfort team 0 at 0.19 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 4
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 4
```

## Native lines (all AIs, first 120)

```
```
