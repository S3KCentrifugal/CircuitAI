# Playtest report: PASS

- Verdict: **PASS** (reached 4 min)
- Game time reached: 4.1 min (frame 7350); wall 86 s
- DLL: build-theatres\d212-final\SkirmishAI.dll (f224e17dc3c6f798); AI BARbTest/test; staged 2026-10-06T02:02:21
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/legion/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI 0, role FRONT
- Checks: ranged-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\incinerator-front-push\glitters\20261006T050221Z-5035783b\runs\20261006T050352Z-b262dd77\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:42.789946][f=-000001] [RangedArena] frame=0 loaded case=incinerator-front-push variant=baseline` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:51.882141][f=0000300] [RangedArena] frame=300 spawn id=14262 team=0 unit=armarad x=3200 z=5100` |
| expect `damage` | seen at 0.3 min | `[t=00:00:53.528516][f=0000617] [RangedArena] frame=617 damage id=7270 team=1 amount=18 attacker=29202 attackerTeam=0 weapon=960` |
| expect `orders` | seen at 0.3 min | `[t=00:00:53.439321][f=0000600] [RangedArena] frame=600 orders team=0 total=59 nonlua=59 lua=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\incinerator-front-push\glitters\20261006T050221Z-5035783b\runs\20261006T050352Z-b262dd77\screen_2026-10-06_05-03-25-112.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\incinerator-front-push\glitters\20261006T050221Z-5035783b\runs\20261006T050352Z-b262dd77\screen_2026-10-06_05-03-35-119.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\incinerator-front-push\glitters\20261006T050221Z-5035783b\runs\20261006T050352Z-b262dd77\screen_2026-10-06_05-03-46-857.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role FRONT, team 0, speed 8, 0 shots, end at 4.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished legcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000000/1000000, units 1
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
  0.18  [Playtest] finished leginc team 0 at 0.18 min
  0.18  [Playtest] finished leginc team 0 at 0.18 min
  0.18  [Playtest] finished leginc team 0 at 0.18 min
  0.18  [Playtest] finished leginc team 0 at 0.18 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +35.0 bank 999780/1000050, units 7
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +35.0 bank 996300/1000050, units 7
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +35.0 bank 998400/1000050, units 7
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +35.0 bank 1000050/1000050, units 7
```

## Native lines (all AIs, first 120)

```
```
