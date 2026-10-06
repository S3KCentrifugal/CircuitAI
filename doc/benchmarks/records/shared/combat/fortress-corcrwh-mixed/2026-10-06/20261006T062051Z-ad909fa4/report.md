# Playtest report: PASS

- Verdict: **PASS** (reached 2 min)
- Game time reached: 2.0 min (frame 3600); wall 70 s
- DLL: build-theatres\d215\SkirmishAI.dll (9507e1c6b5eda75d); AI BARbTest/test; staged 2026-10-06T03:19:37
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/cortex/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI 0, role FRONT
- Checks: ranged-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fortress-corcrwh-mixed\glitters\20261006T061937Z-d792973d\runs\20261006T062051Z-ad909fa4\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:28.410453][f=-000001] [RangedArena] frame=0 loaded case=fortress-corcrwh-mixed variant=ranged` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:38.053373][f=0000300] [RangedArena] frame=300 spawn id=14262 team=0 unit=armarad x=3250 z=4500` |
| expect `damage` | seen at 0.2 min | `[t=00:00:38.860278][f=0000383] [RangedArena] frame=383 damage id=25497 team=1 amount=19 attacker=15146 attackerTeam=0 weapon=422` |
| expect `orders` | seen at 0.3 min | `[t=00:00:40.558539][f=0000600] [RangedArena] frame=600 orders team=0 total=36 nonlua=36 lua=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fortress-corcrwh-mixed\glitters\20261006T061937Z-d792973d\runs\20261006T062051Z-ad909fa4\screen_2026-10-06_06-20-23-931.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fortress-corcrwh-mixed\glitters\20261006T061937Z-d792973d\runs\20261006T062051Z-ad909fa4\screen_2026-10-06_06-20-29-421.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\fortress-corcrwh-mixed\glitters\20261006T061937Z-d792973d\runs\20261006T062051Z-ad909fa4\screen_2026-10-06_06-20-41-141.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role FRONT, team 0, speed 4, 0 shots, end at 2.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished corcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side cortex ai true dead false start (4000, 2400) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 4
  0.05  [Playtest] frame 90 team 0 ally 0 side cortex ai true dead false start (4000, 2400) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.17  [Playtest] finished armarad team 0 at 0.17 min
  0.19  [Playtest] finished corcrwh team 0 at 0.19 min
  0.19  [Playtest] finished corcrwh team 0 at 0.19 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 996040/1000000, units 4
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 997840/1000000, units 4
```

## Native lines (all AIs, first 120)

```
```
