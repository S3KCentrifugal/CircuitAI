# Playtest report: PASS

- Verdict: **PASS** (reached 3 min)
- Game time reached: 3.0 min (frame 5400); wall 61 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\d216\SkirmishAI.dll (fff6f12b014ad652); AI BARbTest/test; staged 2026-10-06T05:04:31
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/armada/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI None, role FRONT
- Checks: ranged-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fatboy-hlt-front\glitters\20261006T080430Z-3d269f70\runs\20261006T080535Z-796feafb\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:27.434056][f=-000001] [RangedArena] frame=0 loaded case=fatboy-hlt-front variant=ranged` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:35.048248][f=0000300] [RangedArena] frame=300 spawn id=25497 team=0 unit=armarad x=3200 z=5700` |
| expect `damage` | seen at 1.5 min | `[t=00:00:45.958604][f=0002613] [RangedArena] frame=2613 damage id=20443 team=1 amount=800 attacker=22963 attackerTeam=0 weapon=196` |
| expect `orders` | seen at 0.3 min | `[t=00:00:36.496676][f=0000600] [RangedArena] frame=600 orders team=0 total=118 nonlua=118 lua=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fatboy-hlt-front\glitters\20261006T080430Z-3d269f70\runs\20261006T080535Z-796feafb\screen_2026-10-06_08-05-15-745.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fatboy-hlt-front\glitters\20261006T080430Z-3d269f70\runs\20261006T080535Z-796feafb\screen_2026-10-06_08-05-21-995.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fatboy-hlt-front\glitters\20261006T080430Z-3d269f70\runs\20261006T080535Z-796feafb\screen_2026-10-06_08-05-30-038.png

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
  0.30  [Playtest] finished armwin team 0 at 0.30 min
  0.41  [Playtest] finished armwin team 0 at 0.41 min
  0.52  [Playtest] finished armwin team 0 at 0.52 min
  0.58  [Playtest] finished armwin team 0 at 0.58 min
  0.63  [Playtest] finished armwin team 0 at 0.63 min
  0.74  [Playtest] finished armwin team 0 at 0.74 min
  0.91  [Playtest] finished armwin team 0 at 0.91 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +3.8 bank 776/1050, energy +148.5 bank 1000049/1000053, units 17
  1.21  [Playtest] finished armmex team 0 at 1.21 min
  1.49  [Playtest] finished armmex team 0 at 1.49 min
  1.69  [Playtest] finished armmex team 0 at 1.69 min
  2.00  [Playtest] finished armvp team 0 at 2.00 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +9.3 bank 504/1300, energy +148.8 bank 1000029/1000153, units 19
  2.03  [Playtest] finished armmex team 0 at 2.03 min
  2.43  [Playtest] finished armmex team 0 at 2.43 min
  2.54  [Playtest] finished armllt team 0 at 2.54 min
  2.92  [Playtest] finished armmex team 0 at 2.92 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +14.9 bank 693/1450, energy +148.9 bank 999732/1000153, units 28
```

## Native lines (all AIs, first 120)

```
```
