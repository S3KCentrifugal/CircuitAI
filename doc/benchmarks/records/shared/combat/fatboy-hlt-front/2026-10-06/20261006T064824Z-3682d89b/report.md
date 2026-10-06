# Playtest report: PASS

- Verdict: **PASS** (reached 3 min)
- Game time reached: 3.0 min (frame 5438); wall 68 s
- DLL: build-theatres\d215\SkirmishAI.dll (9507e1c6b5eda75d); AI BARbTest/test; staged 2026-10-06T03:47:12
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/armada/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI 0, role FRONT
- Checks: ranged-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fatboy-hlt-front\glitters\20261006T064711Z-b7eaceb3\runs\20261006T064824Z-3682d89b\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:27.674454][f=-000001] [RangedArena] frame=0 loaded case=fatboy-hlt-front variant=baseline` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:36.729008][f=0000300] [RangedArena] frame=300 spawn id=14262 team=0 unit=armarad x=3200 z=5700` |
| expect `damage` | seen at 1.5 min | `[t=00:00:50.460253][f=0002668] [RangedArena] frame=2668 damage id=29947 team=1 amount=756 attacker=29202 attackerTeam=0 weapon=196` |
| expect `orders` | seen at 0.3 min | `[t=00:00:38.389764][f=0000600] [RangedArena] frame=600 orders team=0 total=107 nonlua=107 lua=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fatboy-hlt-front\glitters\20261006T064711Z-b7eaceb3\runs\20261006T064824Z-3682d89b\screen_2026-10-06_06-47-59-616.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fatboy-hlt-front\glitters\20261006T064711Z-b7eaceb3\runs\20261006T064824Z-3682d89b\screen_2026-10-06_06-48-07-685.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fatboy-hlt-front\glitters\20261006T064711Z-b7eaceb3\runs\20261006T064824Z-3682d89b\screen_2026-10-06_06-48-18-172.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role FRONT, team 0, speed 6, 0 shots, end at 3.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4000, 2400) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 6
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4000, 2400) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.17  [Playtest] finished armarad team 0 at 0.17 min
  0.17  [Playtest] finished armeyes team 0 at 0.17 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +37.0 bank 1000047/1000050, units 8
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +37.0 bank 1000047/1000050, units 8
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +37.0 bank 1000047/1000050, units 8
```

## Native lines (all AIs, first 120)

```
```
