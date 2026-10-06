# Playtest report: PASS

- Verdict: **PASS** (reached 5 min)
- Game time reached: 5.0 min (frame 9000); wall 77 s
- DLL: build-theatres\d212-final\SkirmishAI.dll (f224e17dc3c6f798); AI BARbTest/test; staged 2026-10-06T02:32:34
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/legion/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI 0, role FRONT
- Checks: land-siege-production.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\land-siege-legion\glitters\20261006T053233Z-41c30df9\runs\20261006T053354Z-2d20daf6\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:27.791098][f=-000001] [RangedArena] frame=0 loaded case=land-siege-legion variant=ranged` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:37.271551][f=0000426] [RangedArena] frame=426 spawn id=5832 team=0 unit=legavp x=3600 z=3500` |
| expect `orders` | seen at 0.3 min | `[t=00:00:37.994540][f=0000600] [RangedArena] frame=600 orders team=0 total=205 nonlua=205 lua=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\land-siege-legion\glitters\20261006T053233Z-41c30df9\runs\20261006T053354Z-2d20daf6\screen_2026-10-06_05-33-21-876.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\land-siege-legion\glitters\20261006T053233Z-41c30df9\runs\20261006T053354Z-2d20daf6\screen_2026-10-06_05-33-33-736.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\land-siege-legion\glitters\20261006T053233Z-41c30df9\runs\20261006T053354Z-2d20daf6\screen_2026-10-06_05-33-45-474.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role FRONT, team 0, speed 8, 0 shots, end at 5.5 min
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
  0.17  [Playtest] finished armeyes team 0 at 0.17 min
  0.17  [Playtest] finished armeyes team 0 at 0.17 min
  0.17  [Playtest] finished armeyes team 0 at 0.17 min
  0.17  [Playtest] finished armeyes team 0 at 0.17 min
  0.20  [Playtest] finished corafus team 0 at 0.20 min
  0.20  [Playtest] finished corafus team 0 at 0.20 min
  0.20  [Playtest] finished cormmkr team 0 at 0.20 min
  0.21  [Playtest] finished cormmkr team 0 at 0.21 min
  0.21  [Playtest] finished cormmkr team 0 at 0.21 min
  0.21  [Playtest] finished cormmkr team 0 at 0.21 min
  0.21  [Playtest] finished cormmkr team 0 at 0.21 min
  0.21  [Playtest] finished cormmkr team 0 at 0.21 min
  0.21  [Playtest] finished cormmkr team 0 at 0.22 min
  0.22  [Playtest] finished cormmkr team 0 at 0.22 min
  0.22  [Playtest] finished cormmkr team 0 at 0.22 min
  0.22  [Playtest] finished cormmkr team 0 at 0.22 min
  0.22  [Playtest] finished cormmkr team 0 at 0.22 min
  0.22  [Playtest] finished cormmkr team 0 at 0.22 min
  0.24  [Playtest] finished legavp team 0 at 0.24 min
  0.24  [Playtest] finished legavp team 0 at 0.24 min
  0.24  [Playtest] finished cornanotc team 0 at 0.24 min
  0.24  [Playtest] finished cornanotc team 0 at 0.24 min
  0.24  [Playtest] finished cornanotc team 0 at 0.24 min
  0.24  [Playtest] finished cornanotc team 0 at 0.25 min
  0.25  [Playtest] finished cornanotc team 0 at 0.25 min
  0.25  [Playtest] finished cornanotc team 0 at 0.25 min
  0.25  [Playtest] finished cornanotc team 0 at 0.25 min
  0.25  [Playtest] finished cornanotc team 0 at 0.25 min
  0.25  [Playtest] finished cornanotc team 0 at 0.25 min
  0.26  [Playtest] finished cornanotc team 0 at 0.25 min
  0.26  [Playtest] finished cornanotc team 0 at 0.26 min
  0.26  [Playtest] finished cornanotc team 0 at 0.26 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +126.1 bank 1000373/1000400, energy +6090.0 bank 895468/1018700, units 48
  2.00  [Playtest] eco team 0 at 2.0 min: metal +126.1 bank 1000257/1000400, energy +6100.0 bank 771719/1018750, units 61
  3.00  [Playtest] eco team 0 at 3.0 min: metal +104.7 bank 999953/1000400, energy +6100.0 bank 766529/1018750, units 72
  4.00  [Playtest] eco team 0 at 4.0 min: metal +100.5 bank 999671/1000400, energy +6100.0 bank 767032/1018750, units 82
  5.00  [Playtest] eco team 0 at 5.0 min: metal +87.6 bank 1000390/1000400, energy +6100.0 bank 766489/1018750, units 96
```

## Native lines (all AIs, first 120)

```
```
