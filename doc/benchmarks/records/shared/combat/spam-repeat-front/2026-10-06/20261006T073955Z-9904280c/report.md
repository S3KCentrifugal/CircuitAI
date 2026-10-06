# Playtest report: PASS

- Verdict: **PASS** (reached 3 min)
- Game time reached: 3.1 min (frame 5550); wall 62 s
- DLL: build-theatres\d216\SkirmishAI.dll (fff6f12b014ad652); AI BARbTest/test; staged 2026-10-06T04:38:50
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/armada/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI 0, role FRONT
- Checks: spam-repeat.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-repeat-front\glitters\20261006T073849Z-40e917bd\runs\20261006T073955Z-9904280c\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `spawn` | seen at 0.2 min | `[t=00:00:36.967671][f=0000399] [RangedArena] frame=399 spawn id=13180 team=0 unit=armlab x=3400 z=3600` |
| expect `repeat` | seen at 0.4 min | `[t=00:00:38.553097][f=0000780] [RangedArena] frame=780 factory id=8355 unit=armlab repeat=true builds=1 building=-1` |
| expect `offspring` | seen at 0.6 min | `[t=00:00:39.955407][f=0001116] [RangedArena] frame=1116 finished id=7961 team=0 unit=armpw cost=54` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-repeat-front\glitters\20261006T073849Z-40e917bd\runs\20261006T073955Z-9904280c\screen_2026-10-06_07-39-35-853.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-repeat-front\glitters\20261006T073849Z-40e917bd\runs\20261006T073955Z-9904280c\screen_2026-10-06_07-39-42-098.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-repeat-front\glitters\20261006T073849Z-40e917bd\runs\20261006T073955Z-9904280c\screen_2026-10-06_07-39-50-083.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role FRONT, team 0, speed 8, 0 shots, end at 3.5 min
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
  1.00  [Playtest] eco team 0 at 1.0 min: metal +208.9 bank 3497/3500, energy +24072.0 bank 1066749/1072800, units 49
  2.00  [Playtest] eco team 0 at 2.0 min: metal +208.9 bank 3497/3500, energy +24072.0 bank 1066749/1072800, units 61
  3.00  [Playtest] eco team 0 at 3.0 min: metal +208.9 bank 3496/3500, energy +24072.0 bank 1066744/1072800, units 71
```

## Native lines (all AIs, first 120)

```
```
