# Playtest report: PASS

- Verdict: **PASS** (reached 3 min)
- Game time reached: 3.0 min (frame 5460); wall 63 s
- DLL: build-theatres\d216\SkirmishAI.dll (fff6f12b014ad652); AI BARbTest/test; staged 2026-10-06T04:42:09
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=SUPPORT/armada/test, 1=SUPPORT/armada/test
- Team 0 (under test): skirmish AI 0, role SUPPORT
- Checks: spam-repeat.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-repeat-support\glitters\20261006T074209Z-1d8850df\runs\20261006T074315Z-cc7f6bc7\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `spawn` | seen at 0.2 min | `[t=00:00:37.676325][f=0000399] [RangedArena] frame=399 spawn id=13180 team=0 unit=armlab x=3400 z=3600` |
| expect `repeat` | seen at 0.7 min | `[t=00:00:41.456242][f=0001170] [RangedArena] frame=1170 factory id=23479 unit=armlab repeat=true builds=1 building=8806` |
| expect `offspring` | seen at 0.8 min | `[t=00:00:43.466590][f=0001481] [RangedArena] frame=1481 finished id=17428 team=0 unit=armpw cost=54` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-repeat-support\glitters\20261006T074209Z-1d8850df\runs\20261006T074315Z-cc7f6bc7\screen_2026-10-06_07-42-56-592.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-repeat-support\glitters\20261006T074209Z-1d8850df\runs\20261006T074315Z-cc7f6bc7\screen_2026-10-06_07-43-02-848.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-repeat-support\glitters\20261006T074209Z-1d8850df\runs\20261006T074315Z-cc7f6bc7\screen_2026-10-06_07-43-10-840.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SUPPORT, team 0, speed 8, 0 shots, end at 3.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 3000/3000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4000, 2400) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 8
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4000, 2400) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.18  [Playtest] finished armafus team 0 at 0.18 min
  0.18  [Playtest] finished armafus team 0 at 0.18 min
  0.18  [Playtest] finished armafus team 0 at 0.18 min
  0.18  [Playtest] finished armmmkr team 0 at 0.18 min
  0.18  [Playtest] finished armmmkr team 0 at 0.18 min
  0.18  [Playtest] finished armmmkr team 0 at 0.18 min
  0.18  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.20  [Playtest] finished armmmkr team 0 at 0.19 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.21  [Playtest] finished armmmkr team 0 at 0.21 min
  0.21  [Playtest] finished armmmkr team 0 at 0.21 min
  0.21  [Playtest] finished armmmkr team 0 at 0.21 min
  0.21  [Playtest] finished armmmkr team 0 at 0.21 min
  0.22  [Playtest] finished armalab team 0 at 0.22 min
  0.22  [Playtest] finished armlab team 0 at 0.22 min
  0.22  [Playtest] finished armlab team 0 at 0.22 min
  0.23  [Playtest] finished armlab team 0 at 0.23 min
  0.23  [Playtest] finished armnanotc team 0 at 0.23 min
  0.23  [Playtest] finished armnanotc team 0 at 0.23 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +208.9 bank 3486/3500, energy +24121.0 bank 1066851/1073150, units 52
  2.00  [Playtest] eco team 0 at 2.0 min: metal +208.9 bank 3480/3500, energy +24161.0 bank 1066871/1073375, units 75
  3.00  [Playtest] eco team 0 at 3.0 min: metal +208.9 bank 3484/3500, energy +24185.0 bank 1066900/1073425, units 95
```

## Native lines (all AIs, first 120)

```
```
