# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54030); wall 296 s
- DLL: build-theatres\d188-build-6\SkirmishAI.dll (ac71826721992d84); AI BARbTest/test; staged 2026-10-04T01:40:17
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\glacial\20261004T044017Z-34a60107\runs\20261004T044516Z-f7cc36d5\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:42.828490][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.0 min | `[t=00:01:10.704331][f=0001852] [SeaWatch] finished frame=1852 id=7319 def=armsy builder=16088` |
| expect `first-ship-exit` | seen at 2.1 min | `[t=00:01:15.188145][f=0003720] [SeaWatch] egress id=9939 yard=7319 seconds=4.9 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\glacial\20261004T044017Z-34a60107\runs\20261004T044516Z-f7cc36d5\screen_2026-10-04_04-41-50-267.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\glacial\20261004T044017Z-34a60107\runs\20261004T044516Z-f7cc36d5\screen_2026-10-04_04-42-20-098.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\glacial\20261004T044017Z-34a60107\runs\20261004T044516Z-f7cc36d5\screen_2026-10-04_04-43-43-229.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\glacial\20261004T044017Z-34a60107\runs\20261004T044516Z-f7cc36d5\screen_2026-10-04_04-45-05-342.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (1430, 4000) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (700, 4600) units 1
  0.00  [Playtest] frame 1 team 2 ally 0 side cortex ai true dead false start (1900, 5800) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (12925, 4000) units 1
  0.00  [Playtest] frame 1 team 4 ally 1 side armada ai true dead false start (13700, 4600) units 1
  0.00  [Playtest] frame 1 team 5 ally 1 side cortex ai true dead false start (12618, 5800) units 1
  0.00  [Playtest] frame 1 team 6 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 7 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (1430, 4000) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (700, 4600) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (1900, 5800) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (12925, 4000) units 1
  0.05  [Playtest] frame 90 team 4 ally 1 side armada ai true dead false start (13700, 4600) units 1
  0.05  [Playtest] frame 90 team 5 ally 1 side cortex ai true dead false start (12618, 5800) units 1
  0.05  [Playtest] frame 90 team 6 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 7 ally 3 side  ai false dead false start (0, 0) units 0
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(700,4597) factory=armsy landLocked=no spot=5 known=1/2
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(1899,5801) factory=corsy landLocked=no spot=6 known=2/2
  0.15  [Playtest] finished armmex team 0 at 0.15 min
  0.17  [Team][Roster] first mex 27860 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.17  [Team][Roster] team 1 first mex at 704,4448
  0.17  [Team][Roster] team 2 first mex at 1904,5967
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.42  [Playtest] finished armmex team 0 at 0.42 min
  0.56  [Playtest] finished armtide team 0 at 0.56 min
  0.72  [Playtest] finished armtide team 0 at 0.72 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 639/1150, energy +76.0 bank 634/1100, units 7
  1.03  [Playtest] finished armsy team 0 at 1.03 min
  1.22  [Playtest] finished armmex team 0 at 1.22 min
  1.36  [Playtest] finished armtide team 0 at 1.36 min
  1.51  [Playtest] finished armtide team 0 at 1.51 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +10.0 bank 325/1300, energy +136.0 bank 390/1400, units 14
  2.04  [Playtest] finished armtide team 0 at 2.04 min
  2.33  [Playtest] finished armtide team 0 at 2.33 min
  2.37  [Playtest] finished armtide team 0 at 2.37 min
  2.68  [Playtest] finished armtide team 0 at 2.68 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 0/1300, energy +228.0 bank 1600/1600, units 22
  3.04  [Playtest] finished armtide team 0 at 3.04 min
  3.28  [Playtest] finished armfmkr team 0 at 3.28 min
  3.48  [Playtest] finished armfmkr team 0 at 3.48 min
  3.69  [Playtest] finished armfmkr team 0 at 3.69 min
  3.86  [Playtest] finished armmex team 0 at 3.86 min
  4.00  [Playtest] finished armfmkr team 0 at 4.00 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +12.9 bank 19/1350, energy +251.0 bank 1236/1650, units 30
  4.10  [Playtest] finished armmex team 0 at 4.10 min
  4.37  [Playtest] finished armmex team 0 at 4.37 min
  4.43  [Playtest] finished armtide team 0 at 4.43 min
  4.60  [Playtest] finished armmex team 0 at 4.60 min
  4.75  [Playtest] finished armtide team 0 at 4.75 min
  4.96  [Playtest] finished armtide team 0 at 4.96 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +21.0 bank 111/1500, energy +320.0 bank 1445/1800, units 35
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.01  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.12  [Playtest] finished armmex team 0 at 5.12 min
  5.14  [Playtest] finished armtide team 0 at 5.14 min
  5.34  [Playtest] finished armmex team 0 at 5.34 min
  5.56  [Playtest] finished armmex team 0 at 5.56 min
  5.62  [Playtest] finished armnanotcplat team 0 at 5.62 min
  5.74  [Playtest] finished armmex team 0 at 5.74 min
  5.78  [Playtest] finished armtide team 0 at 5.78 min
  5.94  [Playtest] finished armtide team 0 at 5.94 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +28.5 bank 106/1700, energy +403.0 bank 1604/2050, units 44
  6.08  [Playtest] finished armtide team 0 at 6.08 min
  6.21  [Playtest] finished armtide team 0 at 6.21 min
  6.34  [Playtest] finished armmex team 0 at 6.34 min
  6.35  [Playtest] finished armtide team 0 at 6.35 min
  6.46  [Playtest] finished armtide team 0 at 6.46 min
  6.59  [Playtest] finished armmex team 0 at 6.59 min
  6.69  [Playtest] finished armtide team 0 at 6.69 min
  6.85  [Playtest] finished armmex team 0 at 6.85 min
  6.91  [Playtest] finished armnanotcplat team 0 at 6.91 min
  6.98  [Playtest] finished armtide team 0 at 6.98 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +33.2 bank 2/1850, energy +536.5 bank 1780/2400, units 57
  7.07  [Playtest] finished armmex team 0 at 7.07 min
  7.11  [Playtest] finished armnanotcplat team 0 at 7.11 min
  7.28  [Playtest] finished armnanotcplat team 0 at 7.28 min
  7.33  [Playtest] finished armtide team 0 at 7.33 min
  7.61  [Playtest] finished armmex team 0 at 7.61 min
  7.66  [Playtest] finished armtide team 0 at 7.66 min
  7.72  [Playtest] finished armtl team 0 at 7.72 min
  7.76  [Playtest] finished armfmkr team 0 at 7.76 min
  7.85  [Playtest] finished armnanotcplat team 0 at 7.85 min
  7.90  [Playtest] finished armtide team 0 at 7.90 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +40.5 bank 60/1950, energy +624.0 bank 2359/2600, units 64
  8.09  [Playtest] finished armtide team 0 at 8.09 min
  8.33  [Playtest] finished armtide team 0 at 8.33 min
  8.55  [Playtest] finished armtide team 0 at 8.56 min
  8.72  [Playtest] finished armtide team 0 at 8.72 min
  8.91  [Playtest] finished armtide team 0 at 8.91 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +40.6 bank 20/1950, energy +739.0 bank 2414/2850, units 80
  9.12  [Playtest] finished armnanotcplat team 0 at 9.12 min
  9.17  [Playtest] finished armtide team 0 at 9.17 min
  9.18  [Playtest] finished armmex team 0 at 9.18 min
  9.21  [Playtest] finished armmex team 0 at 9.21 min
  9.49  [Playtest] finished armtl team 0 at 9.49 min
  9.49  [Playtest] finished armtide team 0 at 9.49 min
  9.50  [Playtest] finished armnanotcplat team 0 at 9.50 min
  9.60  [Playtest] finished armmex team 0 at 9.60 min
  9.75  [Playtest] finished armtide team 0 at 9.75 min
  9.94  [Playtest] finished armmex team 0 at 9.94 min
  9.95  [Playtest] finished armtide team 0 at 9.95 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +49.0 bank 22/2150, energy +831.0 bank 3011/3050, units 92
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.02  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.18  [Playtest] finished armtide team 0 at 10.18 min
 10.28  [Playtest] finished armmex team 0 at 10.28 min
 10.28  [Playtest] finished armfrad team 0 at 10.28 min
 10.37  [Playtest] finished armtide team 0 at 10.37 min
 10.57  [Playtest] finished armtide team 0 at 10.57 min
 10.61  [Playtest] finished armfrad team 0 at 10.61 min
 10.75  [Playtest] finished armmex team 0 at 10.75 min
 10.77  [Playtest] finished armtide team 0 at 10.77 min
 10.91  [Playtest] finished armtl team 0 at 10.91 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +88.0 bank 15/2250, energy +923.0 bank 2721/3250, units 105
 11.04  [Playtest] finished armtide team 0 at 11.04 min
 11.07  [Playtest] finished armmex team 0 at 11.07 min
 11.12  [Playtest] finished armmex team 0 at 11.12 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +71.8 bank 28/2350, energy +946.0 bank 3168/3300, units 102
 12.42  [Playtest] finished armasy team 0 at 12.42 min
 12.61  [Playtest] finished armtide team 0 at 12.61 min
 12.83  [Playtest] finished armtide team 0 at 12.83 min
 12.86  [Playtest] finished armnanotcplat team 0 at 12.86 min
 12.92  [Playtest] finished armtide team 0 at 12.92 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +57.0 bank 23/2550, energy +1015.0 bank 3521/3650, units 108
 13.00  [Playtest] finished armtide team 0 at 13.00 min
 13.14  [Playtest] finished armnanotcplat team 0 at 13.14 min
 13.19  [Playtest] finished armtide team 0 at 13.19 min
 13.31  [Playtest] finished armtide team 0 at 13.31 min
 13.48  [Playtest] finished armnanotcplat team 0 at 13.48 min
 13.69  [Playtest] finished armuwmme team 0 at 13.69 min
 13.81  [Playtest] finished armfmkr team 0 at 13.81 min
 13.96  [Playtest] finished armtide team 0 at 13.96 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +103.7 bank 30/3100, energy +1167.0 bank 2955/4150, units 114
 14.05  [Playtest] finished armuwmme team 0 at 14.05 min
 14.20  [Playtest] finished armtide team 0 at 14.20 min
 14.23  [Playtest] finished armfmkr team 0 at 14.23 min
 14.31  [Playtest] finished armtide team 0 at 14.31 min
 14.65  [Playtest] finished armuwmme team 0 at 14.65 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +70.6 bank 44/4200, energy +1213.0 bank 3385/4250, units 117
 15.00  [Playtest] finished armuwmme team 0 at 15.00 min
 15.89  [Playtest] finished armuwfus team 0 at 15.90 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +83.0 bank 530/4750, energy +2413.0 bank 6698/6750, units 118
 16.24  [Playtest] finished armnanotcplat team 0 at 16.24 min
 16.50  [Playtest] finished armuwadves team 0 at 16.50 min
 16.56  [Playtest] finished armnanotcplat team 0 at 16.56 min
 16.77  [Playtest] finished armuwmmm team 0 at 16.77 min
 16.82  [Playtest] finished armnanotcplat team 0 at 16.82 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +90.8 bank 1647/4750, energy +2406.0 bank 35613/46700, units 122
 17.01  [Playtest] finished armnanotcplat team 0 at 17.01 min
 17.18  [Playtest] finished armnanotcplat team 0 at 17.18 min
 17.39  [Playtest] finished armnanotcplat team 0 at 17.39 min
 17.63  [Playtest] finished armuwmmm team 0 at 17.63 min
 17.81  [Playtest] finished armuwmmm team 0 at 17.81 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +98.8 bank 2863/4750, energy +2406.0 bank 36017/46700, units 123
 18.26  [Playtest] finished armfrad team 0 at 18.26 min
 18.40  [Playtest] finished armtl team 0 at 18.40 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +112.0 bank 4502/4750, energy +2406.0 bank 36317/46700, units 127
 19.20  [Playtest] finished armmship team 0 at 19.19 min
 19.75  [Playtest] finished armmship team 0 at 19.75 min
 19.94  [Playtest] finished armmship team 0 at 19.94 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +108.0 bank 966/4650, energy +2406.0 bank 35560/46700, units 129
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.01  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
 20.14  [Playtest] finished armmship team 0 at 20.14 min
 20.36  [Playtest] finished armmex team 0 at 20.36 min
 20.46  [Playtest] finished armmex team 0 at 20.46 min
 20.52  [Playtest] finished armmship team 0 at 20.52 min
 20.66  [Playtest] finished armatl team 0 at 20.66 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +91.1 bank 187/4750, energy +2692.0 bank 36607/48100, units 129
 22.00  [Playtest] eco team 0 at 22.0 min: metal +96.6 bank 0/4550, energy +2678.0 bank 36833/48000, units 121
 23.00  [Playtest] eco team 0 at 23.0 min: metal +97.2 bank 0/4550, energy +2685.0 bank 36884/48050, units 113
 23.58  [Playtest] finished armshltxuw team 0 at 23.58 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +93.3 bank 55/5300, energy +2685.0 bank 37912/49450, units 109
 25.00  [Playtest] eco team 0 at 25.0 min: metal +93.1 bank 55/5300, energy +2685.0 bank 37956/49450, units 109
 25.80  [Playtest] finished armepoch team 0 at 25.80 min
 25.91  [Playtest] finished armfrad team 0 at 25.91 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +88.0 bank 453/5250, energy +2685.0 bank 37789/49450, units 110
 27.00  [Playtest] eco team 0 at 27.0 min: metal +80.3 bank 56/5150, energy +2385.0 bank 36744/47950, units 109
 28.00  [Playtest] eco team 0 at 28.0 min: metal +85.7 bank 54/5150, energy +2385.0 bank 36786/47950, units 109
 28.27  [Playtest] finished armuwfus team 0 at 28.27 min
 28.92  [Playtest] finished armuwmmm team 0 at 28.92 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +106.4 bank 1332/5150, energy +3585.0 bank 39499/50450, units 110
 29.00  [Playtest] camera requested (1700,4550) height=4000
 29.00  [Playtest] camera captured name=ta position=(1700,4550) height=4000
 29.00  [Playtest] screenshot at 29.0 min of team 0 at (1700, 4550)
 29.72  [Playtest] finished armuwmmm team 0 at 29.72 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +96.9 bank 2054/5150, energy +3578.0 bank 38347/50400, units 112
```

## Native lines (all AIs, first 120)

```
  1.38  BUILDER: discarded 1 unused default task(s) in the last minute
  1.50  BUILDER: discarded 1 unused default task(s) in the last minute
  1.55  BUILDER: discarded 1 unused default task(s) in the last minute
  1.57  BUILDER: discarded 1 unused default task(s) in the last minute
  1.71  BUILDER: discarded 1 unused default task(s) in the last minute
  1.80  BUILDER: discarded 1 unused default task(s) in the last minute
  2.39  BUILDER: discarded 1 unused default task(s) in the last minute
  2.50  BUILDER: discarded 1 unused default task(s) in the last minute
  2.56  BUILDER: discarded 1 unused default task(s) in the last minute
  2.57  BUILDER: discarded 3 unused default task(s) in the last minute
  2.71  BUILDER: discarded 1 unused default task(s) in the last minute
  2.80  BUILDER: discarded 2 unused default task(s) in the last minute
  3.57  BUILDER: discarded 2 unused default task(s) in the last minute
  5.14  BUILDER: discarded 1 unused default task(s) in the last minute
  5.93  BUILDER: discarded 1 unused default task(s) in the last minute
  6.14  BUILDER: discarded 1 unused default task(s) in the last minute
  6.18  BUILDER: discarded 1 unused default task(s) in the last minute
  6.23  BUILDER: discarded 1 unused default task(s) in the last minute
  7.15  BUILDER: discarded 1 unused default task(s) in the last minute
  7.23  BUILDER: discarded 3 unused default task(s) in the last minute
  7.59  BUILDER: discarded 1 unused default task(s) in the last minute
  7.77  BUILDER: discarded 1 unused default task(s) in the last minute
  7.91  BUILDER: discarded 1 unused default task(s) in the last minute
  7.99  BUILDER: discarded 1 unused default task(s) in the last minute
  8.16  BUILDER: discarded 3 unused default task(s) in the last minute
  8.24  BUILDER: discarded 1 unused default task(s) in the last minute
  8.60  BUILDER: discarded 1 unused default task(s) in the last minute
  8.78  BUILDER: discarded 2 unused default task(s) in the last minute
  8.91  BUILDER: discarded 2 unused default task(s) in the last minute
  9.00  BUILDER: discarded 3 unused default task(s) in the last minute
  9.17  BUILDER: discarded 2 unused default task(s) in the last minute
  9.24  BUILDER: discarded 3 unused default task(s) in the last minute
  9.60  BUILDER: discarded 3 unused default task(s) in the last minute
  9.78  BUILDER: discarded 1 unused default task(s) in the last minute
  9.91  BUILDER: discarded 5 unused default task(s) in the last minute
 10.00  BUILDER: discarded 2 unused default task(s) in the last minute
 10.17  BUILDER: discarded 4 unused default task(s) in the last minute
 10.25  BUILDER: discarded 3 unused default task(s) in the last minute
 10.60  BUILDER: discarded 2 unused default task(s) in the last minute
 10.79  BUILDER: discarded 1 unused default task(s) in the last minute
 10.91  BUILDER: discarded 3 unused default task(s) in the last minute
 11.07  BUILDER: discarded 1 unused default task(s) in the last minute
 11.18  BUILDER: discarded 2 unused default task(s) in the last minute
 11.25  BUILDER: discarded 1 unused default task(s) in the last minute
 11.60  BUILDER: discarded 2 unused default task(s) in the last minute
 11.91  BUILDER: discarded 1 unused default task(s) in the last minute
 12.31  BUILDER: discarded 1 unused default task(s) in the last minute
 12.35  BUILDER: discarded 1 unused default task(s) in the last minute
 12.59  BUILDER: discarded 1 unused default task(s) in the last minute
 12.94  BUILDER: discarded 2 unused default task(s) in the last minute
 13.18  BUILDER: discarded 1 unused default task(s) in the last minute
 13.35  BUILDER: discarded 2 unused default task(s) in the last minute
 13.40  BUILDER: discarded 1 unused default task(s) in the last minute
 13.67  BUILDER: discarded 13 unused default task(s) in the last minute
 13.72  BUILDER: discarded 1 unused default task(s) in the last minute
 13.94  BUILDER: discarded 4 unused default task(s) in the last minute
 14.21  BUILDER: discarded 2 unused default task(s) in the last minute
 14.67  BUILDER: discarded 1 unused default task(s) in the last minute
 14.72  BUILDER: discarded 4 unused default task(s) in the last minute
 14.94  BUILDER: discarded 3 unused default task(s) in the last minute
 15.22  BUILDER: discarded 1 unused default task(s) in the last minute
 15.41  BUILDER: discarded 1 unused default task(s) in the last minute
 15.68  BUILDER: discarded 2 unused default task(s) in the last minute
 15.72  BUILDER: discarded 1 unused default task(s) in the last minute
 15.95  BUILDER: discarded 5 unused default task(s) in the last minute
 16.68  BUILDER: discarded 1 unused default task(s) in the last minute
 16.70  BUILDER: discarded 1 unused default task(s) in the last minute
 16.73  BUILDER: discarded 7 unused default task(s) in the last minute
 16.95  BUILDER: discarded 2 unused default task(s) in the last minute
 17.68  BUILDER: discarded 1 unused default task(s) in the last minute
 17.70  BUILDER: discarded 3 unused default task(s) in the last minute
 17.73  BUILDER: discarded 3 unused default task(s) in the last minute
 17.95  BUILDER: discarded 2 unused default task(s) in the last minute
 18.46  BUILDER: discarded 1 unused default task(s) in the last minute
 18.68  BUILDER: discarded 3 unused default task(s) in the last minute
 18.73  BUILDER: discarded 2 unused default task(s) in the last minute
 18.95  BUILDER: discarded 4 unused default task(s) in the last minute
 19.46  BUILDER: discarded 5 unused default task(s) in the last minute
 19.68  BUILDER: discarded 1 unused default task(s) in the last minute
 19.73  BUILDER: discarded 1 unused default task(s) in the last minute
 19.96  BUILDER: discarded 2 unused default task(s) in the last minute
 20.02  BUILDER: discarded 1 unused default task(s) in the last minute
 20.46  BUILDER: discarded 1 unused default task(s) in the last minute
 20.97  BUILDER: discarded 1 unused default task(s) in the last minute
 21.02  BUILDER: discarded 1 unused default task(s) in the last minute
 21.02  BUILDER: discarded 2 unused default task(s) in the last minute
 21.98  BUILDER: discarded 3 unused default task(s) in the last minute
 22.02  BUILDER: discarded 1 unused default task(s) in the last minute
 22.03  BUILDER: discarded 1 unused default task(s) in the last minute
 22.36  BUILDER: discarded 1 unused default task(s) in the last minute
 22.77  BUILDER: discarded 1 unused default task(s) in the last minute
 22.98  BUILDER: discarded 1 unused default task(s) in the last minute
 23.36  BUILDER: discarded 4 unused default task(s) in the last minute
 23.78  BUILDER: discarded 1 unused default task(s) in the last minute
 26.85  BUILDER: discarded 1 unused default task(s) in the last minute
 27.30  BUILDER: discarded 1 unused default task(s) in the last minute
 27.85  BUILDER: discarded 1 unused default task(s) in the last minute
 28.35  BUILDER: discarded 1 unused default task(s) in the last minute
 28.88  BUILDER: discarded 1 unused default task(s) in the last minute
 29.89  BUILDER: discarded 3 unused default task(s) in the last minute
```
