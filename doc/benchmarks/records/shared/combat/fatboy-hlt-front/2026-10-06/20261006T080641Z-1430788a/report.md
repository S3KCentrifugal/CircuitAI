# Playtest report: PASS

- Verdict: **PASS** (reached 3 min)
- Game time reached: 3.1 min (frame 5550); wall 62 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\d216\SkirmishAI.dll (fff6f12b014ad652); AI BARbTest/test; staged 2026-10-06T05:05:35
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/armada/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI None, role FRONT
- Checks: ranged-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fatboy-hlt-front\glitters\20261006T080535Z-2183c945\runs\20261006T080641Z-1430788a\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:28.470496][f=-000001] [RangedArena] frame=0 loaded case=fatboy-hlt-front variant=ranged` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:35.895114][f=0000300] [RangedArena] frame=300 spawn id=25497 team=0 unit=armarad x=3200 z=5700` |
| expect `damage` | seen at 1.5 min | `[t=00:00:47.849422][f=0002749] [RangedArena] frame=2749 damage id=20443 team=1 amount=800 attacker=22963 attackerTeam=0 weapon=196` |
| expect `orders` | seen at 0.3 min | `[t=00:00:37.457297][f=0000600] [RangedArena] frame=600 orders team=0 total=144 nonlua=144 lua=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fatboy-hlt-front\glitters\20261006T080535Z-2183c945\runs\20261006T080641Z-1430788a\screen_2026-10-06_08-06-21-515.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fatboy-hlt-front\glitters\20261006T080535Z-2183c945\runs\20261006T080641Z-1430788a\screen_2026-10-06_08-06-27-792.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fatboy-hlt-front\glitters\20261006T080535Z-2183c945\runs\20261006T080641Z-1430788a\screen_2026-10-06_08-06-35-797.png

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
  0.71  [Playtest] finished armlab team 0 at 0.71 min
  0.80  [Playtest] finished armsolar team 0 at 0.80 min
  0.96  [Playtest] finished armmex team 0 at 0.96 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +5.7 bank 289/1200, energy +88.7 bank 998895/1000201, units 17
  1.22  [Playtest] finished armmex team 0 at 1.22 min
  1.34  [Playtest] finished armmex team 0 at 1.34 min
  1.41  [Playtest] finished armmex team 0 at 1.41 min
  1.76  [Playtest] finished armmex team 0 at 1.76 min
  1.86  [Playtest] finished armllt team 0 at 1.86 min
  1.94  [Playtest] finished armwin team 0 at 1.94 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +13.0 bank 285/1400, energy +89.0 bank 995342/1000251, units 23
  2.31  [Playtest] finished armmex team 0 at 2.31 min
  2.37  [Playtest] finished armwin team 0 at 2.37 min
  2.57  [Playtest] finished armmex team 0 at 2.57 min
  2.61  [Playtest] finished armrad team 0 at 2.61 min
  2.75  [Playtest] finished armwin team 0 at 2.75 min
  2.76  [Playtest] finished armmex team 0 at 2.76 min
  2.78  [Playtest] finished armllt team 0 at 2.78 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +18.5 bank 475/1550, energy +113.9 bank 992141/1000302, units 38
```

## Native lines (all AIs, first 120)

```
```
