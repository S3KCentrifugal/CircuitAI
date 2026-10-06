# Playtest report: PASS

- Verdict: **PASS** (reached 3 min)
- Game time reached: 3.0 min (frame 5400); wall 61 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\d216\SkirmishAI.dll (fff6f12b014ad652); AI BARbTest/test; staged 2026-10-06T05:03:26
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/armada/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI None, role FRONT
- Checks: ranged-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fatboy-hlt-front\glitters\20261006T080325Z-a370b021\runs\20261006T080430Z-8f560345\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:27.491220][f=-000001] [RangedArena] frame=0 loaded case=fatboy-hlt-front variant=ranged` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:34.917133][f=0000300] [RangedArena] frame=300 spawn id=25497 team=0 unit=armarad x=3200 z=5700` |
| expect `damage` | seen at 1.5 min | `[t=00:00:46.037641][f=0002671] [RangedArena] frame=2671 damage id=20443 team=1 amount=800 attacker=22963 attackerTeam=0 weapon=196` |
| expect `orders` | seen at 0.3 min | `[t=00:00:36.314717][f=0000600] [RangedArena] frame=600 orders team=0 total=135 nonlua=135 lua=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fatboy-hlt-front\glitters\20261006T080325Z-a370b021\runs\20261006T080430Z-8f560345\screen_2026-10-06_08-04-10-686.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fatboy-hlt-front\glitters\20261006T080325Z-a370b021\runs\20261006T080430Z-8f560345\screen_2026-10-06_08-04-16-944.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fatboy-hlt-front\glitters\20261006T080325Z-a370b021\runs\20261006T080430Z-8f560345\screen_2026-10-06_08-04-24-977.png

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
  0.37  [Playtest] finished armsolar team 0 at 0.37 min
  0.64  [Playtest] finished armmex team 0 at 0.64 min
  0.99  [Playtest] finished armmex team 0 at 0.99 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +5.7 bank 834/1150, energy +57.0 bank 999869/1000100, units 13
  1.10  [Playtest] finished armsolar team 0 at 1.10 min
  1.22  [Playtest] finished armmex team 0 at 1.22 min
  1.58  [Playtest] finished armmex team 0 at 1.58 min
  1.98  [Playtest] finished armmex team 0 at 1.98 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +12.1 bank 847/1300, energy +77.0 bank 999923/1000150, units 16
  2.22  [Playtest] finished armlab team 0 at 2.22 min
  2.25  [Playtest] finished armmex team 0 at 2.25 min
  2.45  [Playtest] finished armmex team 0 at 2.45 min
  2.64  [Playtest] finished armllt team 0 at 2.64 min
  2.77  [Playtest] finished armllt team 0 at 2.77 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +16.7 bank 1184/1500, energy +84.0 bank 997093/1000300, units 28
```

## Native lines (all AIs, first 120)

```
```
