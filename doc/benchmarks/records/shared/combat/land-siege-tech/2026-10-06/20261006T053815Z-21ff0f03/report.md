# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 5.0 min (frame 9040); wall 77 s
- DLL: build-theatres\d212-final\SkirmishAI.dll (f224e17dc3c6f798); AI BARbTest/test; staged 2026-10-06T02:36:55
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=TECH/cortex/test, 1=TECH/armada/test
- Team 0 (under test): skirmish AI 0, role TECH
- Checks: land-siege-production.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\land-siege-tech\glitters\20261006T053654Z-6ebd090e\runs\20261006T053815Z-21ff0f03\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:27.918714][f=-000001] [RangedArena] frame=0 loaded case=land-siege-tech variant=ranged` |
| expect `spawn` | seen at 1.1 min | `[t=00:00:43.989042][f=0001893] [RangedArena] frame=1893 spawn id=15559 team=0 unit=coravp x=3600 z=3500` |
| expect `orders` | seen at 0.3 min | `[t=00:00:37.976847][f=0000600] [RangedArena] frame=600 orders team=0 total=304 nonlua=304 lua=0` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-050 no factory 300 s into the game (layout not planned)` |
| forbid `fixture` | clean |  |

## Failures

- forbid 'invariant' hit at 5.0 min: [INVARIANT] INV-050 no factory 300 s into the game (layout not planned)

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\land-siege-tech\glitters\20261006T053654Z-6ebd090e\runs\20261006T053815Z-21ff0f03\screen_2026-10-06_05-37-42-881.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\land-siege-tech\glitters\20261006T053654Z-6ebd090e\runs\20261006T053815Z-21ff0f03\screen_2026-10-06_05-37-54-732.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\land-siege-tech\glitters\20261006T053654Z-6ebd090e\runs\20261006T053815Z-21ff0f03\screen_2026-10-06_05-38-06-469.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role TECH, team 0, speed 8, 0 shots, end at 5.5 min
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
  0.08  [Layout] off for this AI
  0.08  [TECH][Opening] mexes within 700 elmos first (nearest 3); start factory held up to 240 s
  0.08  [TECH][Build] experimental build system on: direct range 1600, search radius 512
  0.08  [TECH][Opening] complete after 0 mexes, 0 s: the rush chain owns the opening; the lab is next
  0.08  [Layout] home centre (3973, 2250), 152 from the start
  0.17  [Playtest] finished armarad team 0 at 0.17 min
  0.17  [Playtest] finished armeyes team 0 at 0.17 min
  0.17  [Playtest] finished armeyes team 0 at 0.17 min
  0.17  [Playtest] finished armeyes team 0 at 0.17 min
  0.17  [Playtest] finished armeyes team 0 at 0.17 min
  0.17  [Playtest] finished armeyes team 0 at 0.17 min
  0.18  [Playtest] finished armeyes team 0 at 0.18 min
  0.18  [Playtest] finished armeyes team 0 at 0.18 min
  0.18  [Playtest] finished armeyes team 0 at 0.18 min
  0.22  [Playtest] finished corafus team 0 at 0.22 min
  0.22  [Playtest] finished corafus team 0 at 0.22 min
  0.23  [Playtest] finished corafus team 0 at 0.23 min
  0.23  [Playtest] finished corafus team 0 at 0.23 min
  0.23  [Playtest] finished corafus team 0 at 0.23 min
  0.23  [Playtest] finished corafus team 0 at 0.23 min
  0.23  [Playtest] finished corafus team 0 at 0.23 min
  0.23  [Playtest] finished corafus team 0 at 0.23 min
  0.23  [Playtest] finished corafus team 0 at 0.23 min
  0.24  [Playtest] finished corafus team 0 at 0.24 min
  0.24  [Playtest] finished cormmkr team 0 at 0.24 min
  0.24  [Playtest] finished cormmkr team 0 at 0.24 min
  0.24  [Playtest] finished cormmkr team 0 at 0.24 min
  0.24  [Playtest] finished cormmkr team 0 at 0.24 min
  0.24  [Playtest] finished cormmkr team 0 at 0.25 min
  0.25  [Playtest] finished cormmkr team 0 at 0.25 min
  0.25  [Playtest] finished cormmkr team 0 at 0.25 min
  0.25  [Playtest] finished cormmkr team 0 at 0.25 min
  0.25  [Playtest] finished cormmkr team 0 at 0.25 min
  0.25  [Playtest] finished cormmkr team 0 at 0.25 min
  0.26  [Playtest] finished cormmkr team 0 at 0.25 min
  0.26  [Playtest] finished cormmkr team 0 at 0.26 min
  0.26  [Playtest] finished cormmkr team 0 at 0.26 min
  0.26  [Playtest] finished cormmkr team 0 at 0.26 min
  0.26  [Playtest] finished cormmkr team 0 at 0.26 min
  0.26  [Playtest] finished cormmkr team 0 at 0.26 min
  0.27  [Playtest] finished cormmkr team 0 at 0.26 min
  0.27  [Playtest] finished cormmkr team 0 at 0.27 min
  0.27  [Playtest] finished cormmkr team 0 at 0.27 min
  0.27  [Playtest] finished cormmkr team 0 at 0.27 min
  0.27  [Playtest] finished cormmkr team 0 at 0.27 min
  0.27  [Playtest] finished cormmkr team 0 at 0.27 min
  0.28  [Playtest] finished cormmkr team 0 at 0.28 min
  0.28  [Playtest] finished cormmkr team 0 at 0.28 min
  0.28  [Playtest] finished cormmkr team 0 at 0.28 min
  0.28  [Playtest] finished cormmkr team 0 at 0.28 min
  0.28  [Playtest] finished cormmkr team 0 at 0.28 min
  0.28  [Playtest] finished cormmkr team 0 at 0.28 min
  0.28  [Playtest] finished cormmkr team 0 at 0.28 min
  0.29  [Playtest] finished cormmkr team 0 at 0.29 min
  0.29  [Playtest] finished cormmkr team 0 at 0.29 min
  0.29  [Playtest] finished cormmkr team 0 at 0.29 min
  0.29  [Playtest] finished cormmkr team 0 at 0.29 min
  0.29  [Playtest] finished cormmkr team 0 at 0.29 min
  0.29  [Playtest] finished cormmkr team 0 at 0.29 min
  0.30  [Playtest] finished cormmkr team 0 at 0.30 min
  0.30  [Playtest] finished cormmkr team 0 at 0.30 min
  0.30  [Playtest] finished cormmkr team 0 at 0.30 min
  0.30  [Playtest] finished cormmkr team 0 at 0.30 min
  0.30  [Playtest] finished cormmkr team 0 at 0.30 min
  0.30  [Playtest] finished cormmkr team 0 at 0.31 min
  0.31  [Playtest] finished cormmkr team 0 at 0.31 min
  0.31  [Playtest] finished cormmkr team 0 at 0.31 min
  0.31  [Playtest] finished cormmkr team 0 at 0.31 min
  0.31  [Playtest] finished cormmkr team 0 at 0.31 min
  0.31  [Playtest] finished cormmkr team 0 at 0.31 min
  0.32  [Playtest] finished cormmkr team 0 at 0.31 min
  0.32  [Playtest] finished cormmkr team 0 at 0.32 min
  0.32  [Playtest] finished cormmkr team 0 at 0.32 min
  0.32  [Playtest] finished cormmkr team 0 at 0.32 min
  0.32  [Playtest] finished cormmkr team 0 at 0.32 min
  0.32  [Playtest] finished cormmkr team 0 at 0.32 min
  0.33  [Playtest] finished cormmkr team 0 at 0.32 min
  0.33  [Playtest] finished cormmkr team 0 at 0.33 min
  0.33  [Playtest] finished cormmkr team 0 at 0.33 min
  0.33  [Playtest] finished cormmkr team 0 at 0.33 min
  0.33  [Playtest] finished cormmkr team 0 at 0.33 min
  0.33  [Playtest] finished cormmkr team 0 at 0.33 min
  0.34  [Playtest] finished cormmkr team 0 at 0.34 min
  0.34  [Playtest] finished cormmkr team 0 at 0.34 min
  0.34  [Playtest] finished cormmkr team 0 at 0.34 min
  0.34  [Playtest] finished cormmkr team 0 at 0.34 min
  0.34  [Playtest] finished cormmkr team 0 at 0.34 min
  0.34  [Playtest] finished cormmkr team 0 at 0.34 min
  0.43  [Ferry] requested a transport (TECH at +20 metal, no transport)
  0.47  [TECH][Build] the economy is online (+206 metal): no lab is reclaimed for metal from now on (D-102, D-105)
  0.47  [TECH][Factory] combat production unlocked at +206.811 metal (gate 200)
  1.00  [Playtest] eco team 0 at 1.0 min: metal +518.6 bank 1000000/1000000, energy +30070.0 bank 832633/1090200, units 86
  1.05  [Playtest] finished coravp team 0 at 1.05 min
  1.05  [Playtest] finished coravp team 0 at 1.05 min
  1.05  [Playtest] finished cornanotc team 0 at 1.05 min
  1.06  [Playtest] finished cornanotc team 0 at 1.06 min
  1.06  [Playtest] finished cornanotc team 0 at 1.06 min
  1.06  [Playtest] finished cornanotc team 0 at 1.06 min
  1.07  [Playtest] finished cornanotc team 0 at 1.07 min
  1.07  [Playtest] finished cornanotc team 0 at 1.07 min
  1.07  [Playtest] finished cornanotc team 0 at 1.07 min
  1.07  [Playtest] finished cornanotc team 0 at 1.07 min
  1.08  [Playtest] finished cornanotc team 0 at 1.08 min
  1.08  [Playtest] finished cornanotc team 0 at 1.08 min
  1.08  [Playtest] finished cornanotc team 0 at 1.08 min
  1.09  [Playtest] finished cornanotc team 0 at 1.09 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +517.1 bank 1000394/1000400, energy +30090.0 bank 832808/1090700, units 135
  3.00  [Playtest] eco team 0 at 3.0 min: metal +511.7 bank 1000400/1000400, energy +30090.0 bank 833018/1090700, units 150
  3.43  [Ferry] requested a transport (TECH at +20 metal, no transport)
  4.00  [Playtest] eco team 0 at 4.0 min: metal +505.7 bank 1000391/1000400, energy +30090.0 bank 832756/1090700, units 165
  5.00  [Playtest] eco team 0 at 5.0 min: metal +511.7 bank 1000383/1000400, energy +30090.0 bank 832573/1090700, units 180
```

## Native lines (all AIs, first 120)

```
```
