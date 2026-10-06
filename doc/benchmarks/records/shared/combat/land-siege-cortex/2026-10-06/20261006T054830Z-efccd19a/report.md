# Playtest report: PASS

- Verdict: **PASS** (reached 5 min)
- Game time reached: 5.0 min (frame 9000); wall 77 s
- DLL: build-theatres\d212-final\SkirmishAI.dll (f224e17dc3c6f798); AI BARbTest/test; staged 2026-10-06T02:47:10
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/cortex/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI 0, role FRONT
- Checks: land-siege-production.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\land-siege-cortex\glitters\20261006T054710Z-6e11787f\runs\20261006T054830Z-efccd19a\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:28.057202][f=-000001] [RangedArena] frame=0 loaded case=land-siege-cortex variant=ranged` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:37.216392][f=0000426] [RangedArena] frame=426 spawn id=5832 team=0 unit=coravp x=3600 z=3500` |
| expect `orders` | seen at 0.3 min | `[t=00:00:37.938790][f=0000600] [RangedArena] frame=600 orders team=0 total=206 nonlua=206 lua=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\land-siege-cortex\glitters\20261006T054710Z-6e11787f\runs\20261006T054830Z-efccd19a\screen_2026-10-06_05-47-58-131.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\land-siege-cortex\glitters\20261006T054710Z-6e11787f\runs\20261006T054830Z-efccd19a\screen_2026-10-06_05-48-09-988.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\land-siege-cortex\glitters\20261006T054710Z-6e11787f\runs\20261006T054830Z-efccd19a\screen_2026-10-06_05-48-21-724.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role FRONT, team 0, speed 8, 0 shots, end at 5.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished corcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000000/1000000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side cortex ai true dead false start (4000, 2400) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 8
  0.05  [Playtest] frame 90 team 0 ally 0 side cortex ai true dead false start (4000, 2400) units 1
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
  0.24  [Playtest] finished coravp team 0 at 0.24 min
  0.24  [Playtest] finished coravp team 0 at 0.24 min
  0.24  [Playtest] finished cornanotc team 0 at 0.24 min
  0.24  [Playtest] finished cornanotc team 0 at 0.24 min
  0.24  [Playtest] finished cornanotc team 0 at 0.24 min
  0.25  [Playtest] finished cornanotc team 0 at 0.25 min
  0.25  [Playtest] finished cornanotc team 0 at 0.25 min
  0.25  [Playtest] finished cornanotc team 0 at 0.25 min
  0.25  [Playtest] finished cornanotc team 0 at 0.25 min
  0.25  [Playtest] finished cornanotc team 0 at 0.25 min
  0.25  [Playtest] finished cornanotc team 0 at 0.25 min
  0.26  [Playtest] finished cornanotc team 0 at 0.25 min
  0.26  [Playtest] finished cornanotc team 0 at 0.26 min
  0.26  [Playtest] finished cornanotc team 0 at 0.26 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +126.1 bank 1000112/1000400, energy +6070.0 bank 864708/1018600, units 47
  2.00  [Playtest] eco team 0 at 2.0 min: metal +85.6 bank 1000263/1000400, energy +6130.0 bank 766630/1018900, units 54
  3.00  [Playtest] eco team 0 at 3.0 min: metal +85.2 bank 999731/1000400, energy +6130.0 bank 766404/1018900, units 66
  4.00  [Playtest] eco team 0 at 4.0 min: metal +81.7 bank 997677/1000400, energy +6150.0 bank 766805/1019000, units 75
  5.00  [Playtest] eco team 0 at 5.0 min: metal +84.7 bank 998145/1000400, energy +6230.0 bank 766558/1019400, units 87
```

## Native lines (all AIs, first 120)

```
```
