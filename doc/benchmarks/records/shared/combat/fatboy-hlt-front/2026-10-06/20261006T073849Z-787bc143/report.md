# Playtest report: PASS

- Verdict: **PASS** (reached 3 min)
- Game time reached: 3.0 min (frame 5400); wall 61 s
- DLL: build-theatres\d216\SkirmishAI.dll (fff6f12b014ad652); AI BARbTest/test; staged 2026-10-06T04:37:45
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/armada/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI 0, role FRONT
- Checks: ranged-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fatboy-hlt-front\glitters\20261006T073745Z-2ffe04ea\runs\20261006T073849Z-787bc143\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:27.572101][f=-000001] [RangedArena] frame=0 loaded case=fatboy-hlt-front variant=ranged` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:36.122126][f=0000300] [RangedArena] frame=300 spawn id=14262 team=0 unit=armarad x=3200 z=5700` |
| expect `damage` | seen at 1.5 min | `[t=00:00:46.607561][f=0002669] [RangedArena] frame=2669 damage id=29947 team=1 amount=756 attacker=29202 attackerTeam=0 weapon=196` |
| expect `orders` | seen at 0.3 min | `[t=00:00:37.369657][f=0000600] [RangedArena] frame=600 orders team=0 total=136 nonlua=136 lua=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fatboy-hlt-front\glitters\20261006T073745Z-2ffe04ea\runs\20261006T073849Z-787bc143\screen_2026-10-06_07-38-30-564.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fatboy-hlt-front\glitters\20261006T073745Z-2ffe04ea\runs\20261006T073849Z-787bc143\screen_2026-10-06_07-38-36-807.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fatboy-hlt-front\glitters\20261006T073745Z-2ffe04ea\runs\20261006T073849Z-787bc143\screen_2026-10-06_07-38-44-845.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role FRONT, team 0, speed 8, 0 shots, end at 3.5 min
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
  0.17  [Playtest] finished armeyes team 0 at 0.17 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +37.0 bank 1000047/1000050, units 8
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +37.0 bank 1000047/1000050, units 8
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +37.0 bank 1000047/1000050, units 8
```

## Native lines (all AIs, first 120)

```
```
