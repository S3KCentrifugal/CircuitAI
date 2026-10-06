# Playtest report: PASS

- Verdict: **PASS** (reached 6 min)
- Game time reached: 6.0 min (frame 10860); wall 86 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\d216\SkirmishAI.dll (fff6f12b014ad652); AI BARbTest/test; staged 2026-10-06T05:00:51
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/armada/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI 0, role FRONT
- Checks: spam-build.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-build-front\glitters\20261006T080050Z-028e1243\runs\20261006T080220Z-d81f446d\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `spawn` | seen at 1.3 min | `[t=00:00:47.454474][f=0002358] [RangedArena] frame=2358 finished id=17428 team=0 unit=armlab cost=500` |
| expect `repeat` | seen at 0.6 min | `[t=00:00:41.413447][f=0001080] [RangedArena] frame=1080 factory id=27235 unit=armvp repeat=true builds=1 building=23452` |
| expect `offspring` | seen at 1.5 min | `[t=00:00:49.466541][f=0002723] [RangedArena] frame=2723 finished id=25277 team=0 unit=armpw cost=54` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-build-front\glitters\20261006T080050Z-028e1243\runs\20261006T080220Z-d81f446d\screen_2026-10-06_08-01-38-626.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-build-front\glitters\20261006T080050Z-028e1243\runs\20261006T080220Z-d81f446d\screen_2026-10-06_08-01-44-864.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-build-front\glitters\20261006T080050Z-028e1243\runs\20261006T080220Z-d81f446d\screen_2026-10-06_08-01-52-856.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role FRONT, team 0, speed 8, 0 shots, end at 6.5 min
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
  0.18  [Playtest] finished armmex team 0 at 0.18 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.20  [Playtest] finished armmmkr team 0 at 0.19 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Team][Roster] first mex 14262 at 3984,2608
  0.20  [Team][Roster] Re-announced: roster|1|0|0|FRONT|armada|armvp|3997|2443|0|6|1|3984|2608
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.21  [Playtest] finished armmmkr team 0 at 0.21 min
  0.21  [Playtest] finished armmmkr team 0 at 0.21 min
  0.21  [Playtest] finished armmmkr team 0 at 0.21 min
  0.21  [Playtest] finished armmmkr team 0 at 0.21 min
  0.22  [Playtest] finished armalab team 0 at 0.22 min
  0.23  [Playtest] finished armnanotc team 0 at 0.23 min
  0.23  [Playtest] finished armnanotc team 0 at 0.23 min
  0.58  [Playtest] finished armvp team 0 at 0.58 min
  0.76  [Playtest] finished armnanotc team 0 at 0.76 min
  0.95  [Playtest] finished armnanotc team 0 at 0.95 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +210.7 bank 3327/3350, energy +24078.0 bank 1066296/1072625, units 51
  1.08  [Playtest] finished armnanotc team 0 at 1.08 min
  1.15  [Playtest] finished armnanotc team 0 at 1.15 min
  1.24  [Playtest] finished armnanotc team 0 at 1.24 min
  1.30  [Playtest] finished armnanotc team 0 at 1.30 min
  1.31  [Playtest] finished armlab team 0 at 1.31 min
  1.40  [Playtest] finished armnanotc team 0 at 1.40 min
  1.50  [Playtest] finished armnanotc team 0 at 1.50 min
  1.62  [Playtest] finished armnanotc team 0 at 1.62 min
  1.75  [Playtest] finished armnanotc team 0 at 1.75 min
  1.80  [Playtest] finished armnanotc team 0 at 1.80 min
  1.85  [Playtest] finished armmoho team 0 at 1.85 min
  1.88  [Playtest] finished armnanotc team 0 at 1.88 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +216.2 bank 3954/4000, energy +24126.0 bank 1066088/1073025, units 79
  2.03  [Playtest] finished armnanotc team 0 at 2.03 min
  2.07  [Playtest] finished armnanotc team 0 at 2.07 min
  2.11  [Playtest] finished armnanotc team 0 at 2.11 min
  2.17  [Playtest] finished armnanotc team 0 at 2.17 min
  2.28  [Playtest] finished armmex team 0 at 2.28 min
  2.49  [Playtest] finished armllt team 0 at 2.49 min
  2.59  [Playtest] finished armrad team 0 at 2.59 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +216.2 bank 3934/4000, energy +24194.0 bank 1066753/1073450, units 97
  3.26  [Playtest] finished armafus team 0 at 3.26 min
  3.33  [Playtest] finished armnanotc team 0 at 3.33 min
  3.47  [Playtest] finished armnanotc team 0 at 3.47 min
  3.60  [Playtest] finished armnanotc team 0 at 3.60 min
  3.69  [Playtest] finished armnanotc team 0 at 3.69 min
  3.74  [Playtest] finished armmoho team 0 at 3.74 min
  3.88  [Playtest] finished armnanotc team 0 at 3.88 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +223.6 bank 4092/4600, energy +27288.0 bank 1076713/1083000, units 118
  4.36  [Playtest] finished armnanotc team 0 at 4.36 min
  4.60  [Playtest] finished armafus team 0 at 4.60 min
  4.67  [Playtest] finished armnanotc team 0 at 4.67 min
  4.73  [Playtest] finished armnanotc team 0 at 4.73 min
  4.73  [Playtest] finished armmoho team 0 at 4.73 min
  4.96  [Playtest] finished armmmkr team 0 at 4.96 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +241.3 bank 3453/5200, energy +30392.0 bank 1088363/1092500, units 143
  5.22  [Playtest] finished armnanotc team 0 at 5.22 min
  5.26  [Playtest] finished armmoho team 0 at 5.26 min
  5.44  [Playtest] finished armmex team 0 at 5.44 min
  5.67  [Playtest] finished armafus team 0 at 5.67 min
  5.84  [Playtest] finished armmmkr team 0 at 5.84 min
  5.86  [Playtest] finished armnanotc team 0 at 5.86 min
  5.92  [Playtest] finished armmex team 0 at 5.93 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +262.7 bank 2779/5900, energy +33442.0 bank 1097957/1101675, units 159
```

## Native lines (all AIs, first 120)

```
```
