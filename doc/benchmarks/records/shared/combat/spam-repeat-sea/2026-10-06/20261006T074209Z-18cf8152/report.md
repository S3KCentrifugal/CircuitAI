# Playtest report: PASS

- Verdict: **PASS** (reached 3 min)
- Game time reached: 3.0 min (frame 5425); wall 63 s
- DLL: build-theatres\d216\SkirmishAI.dll (fff6f12b014ad652); AI BARbTest/test; staged 2026-10-06T04:41:02
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: spam-repeat.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-repeat-sea\glitters\20261006T074102Z-fe61cc0d\runs\20261006T074209Z-18cf8152\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `spawn` | seen at 0.2 min | `[t=00:00:37.884057][f=0000399] [RangedArena] frame=399 spawn id=13180 team=0 unit=armlab x=3400 z=3600` |
| expect `repeat` | seen at 0.7 min | `[t=00:00:42.312493][f=0001320] [RangedArena] frame=1320 factory id=23479 unit=armlab repeat=true builds=1 building=9898` |
| expect `offspring` | seen at 0.9 min | `[t=00:00:44.306504][f=0001646] [RangedArena] frame=1646 finished id=8806 team=0 unit=armpw cost=54` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-repeat-sea\glitters\20261006T074102Z-fe61cc0d\runs\20261006T074209Z-18cf8152\screen_2026-10-06_07-41-50-046.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-repeat-sea\glitters\20261006T074102Z-fe61cc0d\runs\20261006T074209Z-18cf8152\screen_2026-10-06_07-41-56-290.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-repeat-sea\glitters\20261006T074102Z-fe61cc0d\runs\20261006T074209Z-18cf8152\screen_2026-10-06_07-42-04-282.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 8, 0 shots, end at 3.5 min
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
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armafus team 0 at 0.17 min
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
  0.23  [Playtest] finished armlab team 0 at 0.22 min
  0.23  [Playtest] finished armnanotc team 0 at 0.23 min
  0.23  [Playtest] finished armnanotc team 0 at 0.23 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +208.9 bank 3486/3500, energy +24058.0 bank 1066374/1072700, units 52
  2.00  [Playtest] eco team 0 at 2.0 min: metal +208.9 bank 3481/3500, energy +24119.0 bank 1066667/1073075, units 69
  3.00  [Playtest] eco team 0 at 3.0 min: metal +208.9 bank 3483/3500, energy +24152.0 bank 1066845/1073250, units 83
```

## Native lines (all AIs, first 120)

```
```
