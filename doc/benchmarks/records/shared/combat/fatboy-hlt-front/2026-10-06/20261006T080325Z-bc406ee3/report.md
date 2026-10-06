# Playtest report: PASS

- Verdict: **PASS** (reached 3 min)
- Game time reached: 3.0 min (frame 5400); wall 61 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\d216\SkirmishAI.dll (fff6f12b014ad652); AI BARbTest/test; staged 2026-10-06T05:02:21
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/armada/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI None, role FRONT
- Checks: ranged-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fatboy-hlt-front\glitters\20261006T080220Z-6ceb5e4b\runs\20261006T080325Z-bc406ee3\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:28.052607][f=-000001] [RangedArena] frame=0 loaded case=fatboy-hlt-front variant=ranged` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:35.469744][f=0000301] [RangedArena] frame=301 spawn id=25497 team=0 unit=armarad x=3200 z=5700` |
| expect `damage` | seen at 1.5 min | `[t=00:00:47.253273][f=0002712] [RangedArena] frame=2712 damage id=20443 team=1 amount=440 attacker=22963 attackerTeam=0 weapon=196` |
| expect `orders` | seen at 0.3 min | `[t=00:00:36.888230][f=0000600] [RangedArena] frame=600 orders team=0 total=139 nonlua=139 lua=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fatboy-hlt-front\glitters\20261006T080220Z-6ceb5e4b\runs\20261006T080325Z-bc406ee3\screen_2026-10-06_08-03-06-331.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fatboy-hlt-front\glitters\20261006T080220Z-6ceb5e4b\runs\20261006T080325Z-bc406ee3\screen_2026-10-06_08-03-12-577.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fatboy-hlt-front\glitters\20261006T080220Z-6ceb5e4b\runs\20261006T080325Z-bc406ee3\screen_2026-10-06_08-03-20-606.png

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
  0.18  [Playtest] finished armmex team 0 at 0.18 min
  0.43  [Playtest] finished armsolar team 0 at 0.43 min
  0.64  [Playtest] finished armllt team 0 at 0.64 min
  0.73  [Playtest] finished armmex team 0 at 0.73 min
  0.95  [Playtest] finished armmex team 0 at 0.95 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +7.5 bank 789/1150, energy +57.0 bank 999651/1000100, units 14
  1.19  [Playtest] finished armsolar team 0 at 1.19 min
  1.35  [Playtest] finished armsolar team 0 at 1.35 min
  1.40  [Playtest] finished armllt team 0 at 1.40 min
  1.70  [Playtest] finished armmex team 0 at 1.70 min
  1.92  [Playtest] finished armllt team 0 at 1.91 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +9.3 bank 364/1200, energy +97.0 bank 999983/1000200, units 17
  2.08  [Playtest] finished armvp team 0 at 2.08 min
  2.32  [Playtest] finished armmex team 0 at 2.32 min
  2.61  [Playtest] finished armwin team 0 at 2.61 min
  2.92  [Playtest] finished armmex team 0 at 2.92 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +13.0 bank 278/1400, energy +111.8 bank 1000099/1000300, units 25
```

## Native lines (all AIs, first 120)

```
  1.02  BUILDER: discarded 3 unused default task(s) in the last minute
```
