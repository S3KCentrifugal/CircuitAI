# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54060); wall 179 s
- DLL: build-theatres\d188-build-4\SkirmishAI.dll (4269e12be49092f4); AI BARbTest/test; staged 2026-10-04T01:23:59
- Map: Erebos Lakes v1.0; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\erebos\20261004T042358Z-0c82f212\runs\20261004T042701Z-578838ff\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:41.463858][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.3 min | `[t=00:00:55.989858][f=0002421] [SeaWatch] finished frame=2421 id=18780 def=armsy builder=16715` |
| expect `first-ship-exit` | seen at 2.8 min | `[t=00:01:01.677845][f=0004980] [SeaWatch] egress id=15365 yard=18780 seconds=5.4 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\erebos\20261004T042358Z-0c82f212\runs\20261004T042701Z-578838ff\screen_2026-10-04_04-25-15-141.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\erebos\20261004T042358Z-0c82f212\runs\20261004T042701Z-578838ff\screen_2026-10-04_04-25-36-405.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\erebos\20261004T042358Z-0c82f212\runs\20261004T042701Z-578838ff\screen_2026-10-04_04-26-18-031.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\erebos\20261004T042358Z-0c82f212\runs\20261004T042701Z-578838ff\screen_2026-10-04_04-26-55-187.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (2076, 6352) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (8128, 3879) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (2076, 6352) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (8128, 3879) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.16  [Playtest] finished armmex team 0 at 0.16 min
  0.17  [Team][Roster] first mex 585 at 2032,6192
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|2076|6349|0|3|1|2032|6192
  0.30  [Playtest] finished armmex team 0 at 0.30 min
  0.48  [Playtest] finished armmex team 0 at 0.48 min
  0.59  [Playtest] finished armwin team 0 at 0.59 min
  0.70  [Playtest] finished armwin team 0 at 0.70 min
  0.85  [Playtest] finished armwin team 0 at 0.85 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 1092/1150, energy +49.1 bank 791/1001, units 7
  1.34  [Playtest] finished armsy team 0 at 1.35 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 798/1250, energy +74.4 bank 4/1151, units 11
  2.63  [Playtest] finished armtide team 0 at 2.63 min
  2.92  [Playtest] finished armtide team 0 at 2.92 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +9.0 bank 661/1250, energy +105.9 bank 102/1301, units 16
  3.13  [Playtest] finished armtide team 0 at 3.13 min
  3.30  [Playtest] finished armtide team 0 at 3.30 min
  3.38  [Playtest] finished armmex team 0 at 3.38 min
  3.54  [Playtest] finished armtide team 0 at 3.54 min
  3.67  [Playtest] finished armmex team 0 at 3.67 min
  3.71  [Playtest] finished armtide team 0 at 3.71 min
  3.88  [Playtest] finished armtide team 0 at 3.88 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +12.0 bank 206/1350, energy +230.2 bank 1532/1551, units 26
  4.07  [Playtest] finished armtide team 0 at 4.07 min
  4.25  [Playtest] finished armmex team 0 at 4.25 min
  4.27  [Playtest] finished armtide team 0 at 4.27 min
  4.53  [Playtest] finished armmex team 0 at 4.53 min
  4.53  [Playtest] finished armfmkr team 0 at 4.53 min
  4.76  [Playtest] finished armmex team 0 at 4.76 min
  4.76  [Playtest] finished armtide team 0 at 4.76 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +19.0 bank 84/1500, energy +274.4 bank 1514/1701, units 34
  5.00  [Playtest] target team 0 at (2076, 6352) from its start position
  5.00  [Playtest] camera requested (2076,6352) height=2200
  5.02  [Playtest] camera captured name=ta position=(2076,6352) height=2200
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (2076, 6352)
  5.03  [Playtest] finished armfmkr team 0 at 5.03 min
  5.13  [Playtest] finished armmex team 0 at 5.13 min
  5.21  [Playtest] finished armtide team 0 at 5.21 min
  5.65  [Playtest] finished armnanotcplat team 0 at 5.65 min
  5.79  [Playtest] finished armmex team 0 at 5.79 min
  5.83  [Playtest] finished armtide team 0 at 5.83 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +24.0 bank 124/1600, energy +320.8 bank 1646/1801, units 41
  6.08  [Playtest] finished armtide team 0 at 6.08 min
  6.22  [Playtest] finished armmex team 0 at 6.22 min
  6.26  [Playtest] finished armfmkr team 0 at 6.26 min
  6.39  [Playtest] finished armtide team 0 at 6.39 min
  6.48  [Playtest] finished armmex team 0 at 6.48 min
  6.57  [Playtest] finished armtide team 0 at 6.57 min
  6.68  [Playtest] finished armtide team 0 at 6.68 min
  6.78  [Playtest] finished armmex team 0 at 6.78 min
  6.78  [Playtest] finished armtide team 0 at 6.78 min
  6.97  [Playtest] finished armfmkr team 0 at 6.97 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +28.0 bank 243/1750, energy +440.0 bank 1868/2151, units 54
  7.17  [Playtest] finished armmex team 0 at 7.17 min
  7.19  [Playtest] finished armtide team 0 at 7.19 min
  7.30  [Playtest] finished armtide team 0 at 7.30 min
  7.39  [Playtest] finished armtide team 0 at 7.39 min
  7.72  [Playtest] finished armmex team 0 at 7.72 min
  7.82  [Playtest] finished armtl team 0 at 7.82 min
  7.87  [Playtest] finished armtide team 0 at 7.87 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +35.5 bank 19/1850, energy +532.1 bank 1910/2401, units 64
  8.00  [Playtest] finished armmex team 0 at 8.00 min
  8.20  [Playtest] finished armtide team 0 at 8.20 min
  8.36  [Playtest] finished armmex team 0 at 8.36 min
  8.44  [Playtest] finished armtide team 0 at 8.44 min
  8.76  [Playtest] finished armtide team 0 at 8.76 min
  8.78  [Playtest] finished armmex team 0 at 8.77 min
  8.85  [Playtest] finished armnanotcplat team 0 at 8.85 min
  8.99  [Playtest] finished armllt team 0 at 8.99 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +130.8 bank 1034/2000, energy +577.1 bank 1997/2601, units 71
  9.03  [Playtest] finished armtide team 0 at 9.03 min
  9.21  [Playtest] finished armtide team 0 at 9.21 min
  9.35  [Playtest] finished armtide team 0 at 9.35 min
  9.38  [Playtest] finished armllt team 0 at 9.38 min
  9.39  [Playtest] finished armtide team 0 at 9.39 min
  9.61  [Playtest] finished armnanotcplat team 0 at 9.61 min
  9.71  [Playtest] finished armtide team 0 at 9.71 min
  9.76  [Playtest] finished armtide team 0 at 9.76 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +39.2 bank 297/2000, energy +718.1 bank 2218/2901, units 79
 10.00  [Playtest] camera requested (2076,6352) height=2200
 10.00  [Playtest] finished armmex team 0 at 10.00 min
 10.02  [Playtest] camera captured name=ta position=(2076,6352) height=2200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (2076, 6352)
 10.12  [Playtest] finished armtide team 0 at 10.12 min
 10.30  [Playtest] finished armmex team 0 at 10.30 min
 10.40  [Playtest] finished armmex team 0 at 10.40 min
 10.50  [Playtest] finished armllt team 0 at 10.50 min
 10.53  [Playtest] finished armtide team 0 at 10.53 min
 10.60  [Playtest] finished armrad team 0 at 10.60 min
 10.72  [Playtest] finished armmex team 0 at 10.72 min
 10.79  [Playtest] finished armtide team 0 at 10.79 min
 10.82  [Playtest] finished armtl team 0 at 10.82 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +50.0 bank 21/2200, energy +778.5 bank 2950/3051, units 93
 11.10  [Playtest] finished armtide team 0 at 11.10 min
 11.17  [Playtest] finished armmex team 0 at 11.17 min
 11.19  [Playtest] finished armfrad team 0 at 11.19 min
 11.31  [Playtest] finished armtl team 0 at 11.31 min
 11.33  [Playtest] finished armmex team 0 at 11.33 min
 11.38  [Playtest] finished armmex team 0 at 11.38 min
 11.42  [Playtest] finished armtide team 0 at 11.42 min
 11.51  [Playtest] finished armfrad team 0 at 11.51 min
 11.62  [Playtest] finished armmex team 0 at 11.62 min
 11.74  [Playtest] finished armtide team 0 at 11.74 min
 11.86  [Playtest] finished armllt team 0 at 11.86 min
 11.94  [Playtest] finished armtide team 0 at 11.94 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +58.0 bank 33/2400, energy +859.6 bank 3164/3251, units 105
 12.27  [Playtest] finished armtide team 0 at 12.27 min
 12.32  [Playtest] finished armmex team 0 at 12.32 min
 12.43  [Playtest] finished armrad team 0 at 12.43 min
 12.80  [Playtest] finished armtide team 0 at 12.80 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +60.0 bank 23/2450, energy +899.9 bank 3336/3351, units 110
 13.11  [Playtest] finished armtide team 0 at 13.11 min
 13.11  [Playtest] finished armasy team 0 at 13.11 min
 13.49  [Playtest] finished armtide team 0 at 13.49 min
 13.67  [Playtest] finished armtide team 0 at 13.67 min
 13.85  [Playtest] finished armtide team 0 at 13.85 min
 13.88  [Playtest] finished armtide team 0 at 13.88 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +60.0 bank 2386/2650, energy +1029.7 bank 3942/3951, units 118
 14.03  [Playtest] finished armtide team 0 at 14.03 min
 14.23  [Playtest] finished armtide team 0 at 14.23 min
 14.25  [Playtest] finished armmex team 0 at 14.25 min
 14.32  [Playtest] finished armuwmme team 0 at 14.32 min
 14.42  [Playtest] finished armtide team 0 at 14.42 min
 14.53  [Playtest] finished armmex team 0 at 14.52 min
 14.58  [Playtest] finished armmex team 0 at 14.58 min
 14.69  [Playtest] finished armllt team 0 at 14.69 min
 14.76  [Playtest] finished armfrad team 0 at 14.76 min
 14.88  [Playtest] finished armtide team 0 at 14.88 min
 14.92  [Playtest] finished armnanotcplat team 0 at 14.92 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +72.0 bank 2848/3350, energy +1123.3 bank 3168/4301, units 133
 15.07  [Playtest] finished armtl team 0 at 15.07 min
 15.10  [Playtest] finished armmex team 0 at 15.10 min
 15.18  [Playtest] finished armnanotcplat team 0 at 15.18 min
 15.20  [Playtest] finished armtide team 0 at 15.20 min
 15.36  [Playtest] finished armtide team 0 at 15.36 min
 15.42  [Playtest] finished armuwmme team 0 at 15.42 min
 15.42  [Playtest] finished armtide team 0 at 15.42 min
 15.49  [Playtest] finished armtide team 0 at 15.49 min
 15.60  [Playtest] finished armnanotcplat team 0 at 15.60 min
 15.70  [Playtest] finished armmex team 0 at 15.70 min
 15.99  [Playtest] finished armtl team 0 at 15.99 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +78.0 bank 3705/4000, energy +1219.9 bank 823/4501, units 142
 16.17  [Playtest] finished armuwmmm team 0 at 16.17 min
 16.21  [Playtest] finished armfrad team 0 at 16.21 min
 16.30  [Playtest] finished armtide team 0 at 16.30 min
 16.40  [Playtest] finished armnanotcplat team 0 at 16.40 min
 16.65  [Playtest] finished armnanotcplat team 0 at 16.65 min
 16.91  [Playtest] finished armnanotcplat team 0 at 16.91 min
 16.91  [Playtest] finished armtide team 0 at 16.91 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +78.0 bank 2681/4000, energy +1258.6 bank 491/4601, units 153
 17.14  [Playtest] finished armtide team 0 at 17.14 min
 17.15  [Playtest] finished armnanotcplat team 0 at 17.15 min
 17.36  [Playtest] finished armmex team 0 at 17.36 min
 17.55  [Playtest] finished armnanotcplat team 0 at 17.55 min
 17.65  [Playtest] finished armmship team 0 at 17.65 min
 17.72  [Playtest] finished armnanotcplat team 0 at 17.72 min
 17.76  [Playtest] finished armmex team 0 at 17.76 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +82.0 bank 1638/4100, energy +1279.7 bank 1648/4651, units 165
 18.03  [Playtest] finished armmship team 0 at 18.03 min
 18.05  [Playtest] finished armnanotcplat team 0 at 18.05 min
 18.19  [Playtest] finished armnanotcplat team 0 at 18.19 min
 18.21  [Playtest] finished armwin team 0 at 18.21 min
 18.28  [Playtest] finished armnanotcplat team 0 at 18.28 min
 18.33  [Playtest] finished armwin team 0 at 18.33 min
 18.44  [Playtest] finished armtl team 0 at 18.44 min
 18.44  [Playtest] finished armmship team 0 at 18.44 min
 18.47  [Playtest] finished armwin team 0 at 18.47 min
 18.51  [Playtest] finished armnanotcplat team 0 at 18.51 min
 18.64  [Playtest] finished armwin team 0 at 18.64 min
 18.70  [Playtest] finished armnanotcplat team 0 at 18.70 min
 18.72  [Playtest] finished armfrad team 0 at 18.72 min
 18.79  [Playtest] finished armrad team 0 at 18.79 min
 18.85  [Playtest] finished armmship team 0 at 18.85 min
 18.91  [Playtest] finished armwin team 0 at 18.91 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +82.0 bank 14/4100, energy +1314.9 bank 2971/4654, units 179
 19.03  [Playtest] finished armwin team 0 at 19.03 min
 19.14  [Playtest] finished armuwmmm team 0 at 19.14 min
 19.27  [Playtest] finished armllt team 0 at 19.27 min
 19.35  [Playtest] finished armmship team 0 at 19.35 min
 19.55  [Playtest] finished armuwfus team 0 at 19.56 min
 19.97  [Playtest] finished armnanotcplat team 0 at 19.97 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +98.8 bank 36/4100, energy +2813.3 bank 6884/8653, units 183
 20.00  [Playtest] camera requested (2076,6352) height=2200
 20.01  [Playtest] camera captured name=ta position=(2076,6352) height=2200
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (2076, 6352)
 20.12  [Playtest] finished armuwmmm team 0 at 20.12 min
 20.35  [Playtest] finished armuwmmm team 0 at 20.35 min
 20.38  [Playtest] finished armnanotcplat team 0 at 20.38 min
 20.72  [Playtest] finished armuwmmm team 0 at 20.72 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +107.2 bank 41/4100, energy +2731.1 bank 7137/8552, units 180
 21.07  [Playtest] finished armatl team 0 at 21.07 min
 21.76  [Playtest] finished armuwadves team 0 at 21.76 min
 21.93  [Playtest] finished armuwmme team 0 at 21.93 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +88.0 bank 67/4650, energy +2294.7 bank 17482/47352, units 157
 23.00  [Playtest] eco team 0 at 23.0 min: metal +100.9 bank 38/4650, energy +1975.2 bank 35269/46602, units 143
 23.34  [Playtest] finished armepoch team 0 at 23.34 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +99.1 bank 43/4650, energy +1955.8 bank 35242/46602, units 146
 24.79  [Playtest] finished armuwfus team 0 at 24.79 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +136.8 bank 529/4650, energy +3159.5 bank 37296/49052, units 149
 25.99  [Playtest] finished armfrad team 0 at 25.99 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +91.4 bank 1060/4650, energy +2945.6 bank 36584/48552, units 146
 26.10  [Playtest] finished armtl team 0 at 26.10 min
 26.38  [Playtest] finished armrl team 0 at 26.38 min
 26.80  [Playtest] finished armtl team 0 at 26.80 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +106.1 bank 632/4650, energy +2952.1 bank 36584/48552, units 157
 27.04  [Playtest] finished armtl team 0 at 27.03 min
 27.30  [Playtest] finished armrad team 0 at 27.31 min
 27.48  [Playtest] finished armrl team 0 at 27.48 min
 27.63  [Playtest] finished armtl team 0 at 27.63 min
 27.65  [Playtest] finished armmship team 0 at 27.65 min
 27.92  [Playtest] finished armmship team 0 at 27.92 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +111.2 bank 41/4650, energy +2923.7 bank 37443/48552, units 165
 28.20  [Playtest] finished armmship team 0 at 28.20 min
 28.50  [Playtest] finished armmship team 0 at 28.50 min
 28.65  [Playtest] finished armtl team 0 at 28.65 min
 28.73  [Playtest] finished armtl team 0 at 28.73 min
 28.80  [Playtest] finished armmship team 0 at 28.80 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +122.9 bank 40/4650, energy +2945.7 bank 37444/48552, units 170
 29.00  [Playtest] camera requested (2076,6352) height=2200
 29.01  [Playtest] camera captured name=ta position=(2076,6352) height=2200
 29.01  [Playtest] screenshot at 29.0 min of team 0 at (2076, 6352)
 29.08  [Playtest] finished armmship team 0 at 29.08 min
 29.35  [Playtest] finished armmship team 0 at 29.35 min
 29.63  [Playtest] finished armmship team 0 at 29.63 min
 29.90  [Playtest] finished armmship team 0 at 29.90 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +98.7 bank 12/4650, energy +2939.3 bank 37390/48552, units 174
```

## Native lines (all AIs, first 120)

```
  1.76  BUILDER: discarded 1 unused default task(s) in the last minute
  1.80  BUILDER: discarded 1 unused default task(s) in the last minute
  2.76  BUILDER: discarded 3 unused default task(s) in the last minute
  2.80  BUILDER: discarded 1 unused default task(s) in the last minute
  3.76  BUILDER: discarded 4 unused default task(s) in the last minute
  3.80  BUILDER: discarded 13 unused default task(s) in the last minute
  4.81  BUILDER: discarded 7 unused default task(s) in the last minute
  5.81  BUILDER: discarded 7 unused default task(s) in the last minute
  6.01  BUILDER: discarded 1 unused default task(s) in the last minute
  6.82  BUILDER: discarded 59 unused default task(s) in the last minute
  7.02  BUILDER: discarded 16 unused default task(s) in the last minute
  7.82  BUILDER: discarded 18 unused default task(s) in the last minute
  8.02  BUILDER: discarded 1 unused default task(s) in the last minute
  9.04  BUILDER: discarded 1 unused default task(s) in the last minute
 10.05  BUILDER: discarded 2 unused default task(s) in the last minute
 10.72  BUILDER: discarded 1 unused default task(s) in the last minute
 11.05  BUILDER: discarded 1 unused default task(s) in the last minute
 11.82  BUILDER: discarded 5 unused default task(s) in the last minute
 12.05  BUILDER: discarded 2 unused default task(s) in the last minute
 12.29  CBFactoryTask: no site for armtide in a usable armtide area near (2936, 5965); retrying without the area check
 12.29  CBFactoryTask: no site for armtide at all | origin (2936, 5965) elev -96 | canBuildHere=1 reach=1 threat=0.0 enginePossible=1 mobileId=-1 immobileId=20 builder=armcs radius=1600
 12.34  CBFactoryTask: no site for armtide in a usable armtide area near (3004, 5884); retrying without the area check
 12.34  CBFactoryTask: no site for armtide at all | origin (3004, 5884) elev -96 | canBuildHere=1 reach=1 threat=0.0 enginePossible=1 mobileId=-1 immobileId=20 builder=armcs radius=1600
 12.37  CBFactoryTask: no site for armtide in a usable armtide area near (3028, 5863); retrying without the area check
 12.37  CBFactoryTask: no site for armtide at all | origin (3028, 5863) elev -89 | canBuildHere=1 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
 12.41  CBFactoryTask: no site for armtide in a usable armtide area near (3004, 5848); retrying without the area check
 12.41  CBFactoryTask: no site for armtide at all | origin (3004, 5848) elev -92 | canBuildHere=1 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
 12.45  CBFactoryTask: no site for armtide in a usable armtide area near (2900, 5911); retrying without the area check
 12.45  CBFactoryTask: no site for armtide at all | origin (2900, 5911) elev -99 | canBuildHere=1 reach=1 threat=0.0 enginePossible=1 mobileId=-1 immobileId=20 builder=armcs radius=1600
 13.13  CBFactoryTask: no site for armtide in a usable armtide area near (2937, 5885); retrying without the area check
 13.13  CBFactoryTask: no site for armtide at all | origin (2937, 5885) elev -99 | canBuildHere=1 reach=1 threat=0.0 enginePossible=1 mobileId=-1 immobileId=20 builder=armcs radius=1600
 13.17  CBFactoryTask: no site for armtide in a usable armtide area near (3084, 5894); retrying without the area check
 13.17  CBFactoryTask: no site for armtide at all | origin (3084, 5894) elev -78 | canBuildHere=1 reach=1 threat=0.0 enginePossible=1 mobileId=-1 immobileId=20 builder=armcs radius=1600
 13.20  CBFactoryTask: no site for armtide in a usable armtide area near (2878, 5785); retrying without the area check
 13.20  CBFactoryTask: no site for armtide at all | origin (2878, 5785) elev -104 | canBuildHere=1 reach=1 threat=0.0 enginePossible=1 mobileId=-1 immobileId=20 builder=armcs radius=1600
 13.24  CBFactoryTask: no site for armtide in a usable armtide area near (2999, 5805); retrying without the area check
 13.24  CBFactoryTask: no site for armtide at all | origin (2999, 5805) elev -88 | canBuildHere=1 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
 13.30  CBFactoryTask: no site for armtide in a usable armtide area near (2962, 5992); retrying without the area check
 13.30  CBFactoryTask: no site for armtide at all | origin (2962, 5992) elev -98 | canBuildHere=1 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
 14.06  CBFactoryTask: no site for armtide in a usable armtide area near (3045, 5922); retrying without the area check
 14.06  CBFactoryTask: no site for armtide at all | origin (3045, 5922) elev -92 | canBuildHere=1 reach=1 threat=0.0 enginePossible=1 mobileId=-1 immobileId=20 builder=armcs radius=1600
 14.09  CBFactoryTask: no site for armtide in a usable armtide area near (3037, 5825); retrying without the area check
 14.09  CBFactoryTask: no site for armtide at all | origin (3037, 5825) elev -81 | canBuildHere=1 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
 14.45  CBFactoryTask: no site for armtide in a usable armtide area near (2997, 5811); retrying without the area check
 14.45  CBFactoryTask: no site for armtide at all | origin (2997, 5811) elev -89 | canBuildHere=1 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
 15.39  CBFactoryTask: no site for armtide in a usable armtide area near (3131, 5958); retrying without the area check
 15.39  CBFactoryTask: no site for armtide at all | origin (3131, 5958) elev -69 | canBuildHere=1 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcom radius=1600
```
