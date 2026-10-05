# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54000); wall 295 s
- DLL: build-theatres\d188-build-4\SkirmishAI.dll (4269e12be49092f4); AI BARbTest/test; staged 2026-10-04T01:06:35
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\supreme\20261004T040635Z-88953fbd\runs\20261004T041133Z-4c364ef0\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:42.961890][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.4 min | `[t=00:01:03.107841][f=0002600] [SeaWatch] finished frame=2600 id=17207 def=armsy builder=17498` |
| expect `first-ship-exit` | seen at 2.6 min | `[t=00:01:07.862935][f=0004680] [SeaWatch] egress id=30820 yard=17207 seconds=4.5 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\supreme\20261004T040635Z-88953fbd\runs\20261004T041133Z-4c364ef0\screen_2026-10-04_04-07-58-154.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\supreme\20261004T040635Z-88953fbd\runs\20261004T041133Z-4c364ef0\screen_2026-10-04_04-08-23-074.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\supreme\20261004T040635Z-88953fbd\runs\20261004T041133Z-4c364ef0\screen_2026-10-04_04-09-37-514.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\supreme\20261004T040635Z-88953fbd\runs\20261004T041133Z-4c364ef0\screen_2026-10-04_04-11-16-320.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 37
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 37
  0.19  [Playtest] finished armmex team 0 at 0.19 min
  0.20  [Team][Roster] first mex 25428 at 4608,11072
  0.20  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4775|11078|0|7|1|4608|11072
  0.38  [Playtest] finished armmex team 0 at 0.38 min
  0.49  [Playtest] finished armwin team 0 at 0.49 min
  0.60  [Playtest] finished armwin team 0 at 0.60 min
  0.71  [Playtest] finished armwin team 0 at 0.71 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 1085/1100, energy +86.3 bank 1001/1001, units 6
  1.44  [Playtest] finished armsy team 0 at 1.44 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.6 bank 651/1200, energy +78.3 bank 1/1151, units 10
  2.41  [Playtest] finished armtide team 0 at 2.41 min
  2.60  [Playtest] finished armtide team 0 at 2.60 min
  2.90  [Playtest] finished armtide team 0 at 2.90 min
  2.96  [Playtest] finished armtide team 0 at 2.96 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.6 bank 7/1200, energy +165.8 bank 398/1401, units 18
  3.23  [Playtest] finished armtide team 0 at 3.23 min
  3.53  [Playtest] finished armmex team 0 at 3.53 min
  3.61  [Playtest] finished armtide team 0 at 3.61 min
  3.94  [Playtest] finished armtide team 0 at 3.94 min
  3.95  [Playtest] finished armmex team 0 at 3.95 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.9 bank 15/1300, energy +224.0 bank 1545/1551, units 25
  4.23  [Playtest] finished armmex team 0 at 4.23 min
  4.27  [Playtest] finished armtide team 0 at 4.27 min
  4.53  [Playtest] finished armmex team 0 at 4.53 min
  4.59  [Playtest] finished armtide team 0 at 4.59 min
  4.62  [Playtest] finished armtide team 0 at 4.62 min
  4.89  [Playtest] finished armfmkr team 0 at 4.89 min
  4.94  [Playtest] finished armmex team 0 at 4.94 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +18.3 bank 86/1450, energy +311.0 bank 1643/1701, units 33
  5.00  [Playtest] target team 0 at (4814, 11077) from its start position
  5.00  [Playtest] camera requested (4814,11077) height=2200
  5.00  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (4814, 11077)
  5.12  [Playtest] finished armfmkr team 0 at 5.12 min
  5.32  [Playtest] finished armfmkr team 0 at 5.32 min
  5.34  [Playtest] finished armmex team 0 at 5.34 min
  5.51  [Playtest] finished armtide team 0 at 5.51 min
  5.66  [Playtest] finished armmex team 0 at 5.66 min
  5.71  [Playtest] finished armtide team 0 at 5.71 min
  5.93  [Playtest] finished armmex team 0 at 5.93 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +24.2 bank 300/1600, energy +359.3 bank 1057/1851, units 44
  6.07  [Playtest] finished armnanotcplat team 0 at 6.07 min
  6.11  [Playtest] finished armllt team 0 at 6.11 min
  6.21  [Playtest] finished armrad team 0 at 6.20 min
  6.33  [Playtest] finished armtide team 0 at 6.33 min
  6.49  [Playtest] finished armtide team 0 at 6.49 min
  6.61  [Playtest] finished armtide team 0 at 6.61 min
  6.67  [Playtest] finished armmex team 0 at 6.68 min
  6.73  [Playtest] finished armtide team 0 at 6.73 min
  6.84  [Playtest] finished armtide team 0 at 6.84 min
  6.86  [Playtest] finished armllt team 0 at 6.86 min
  6.97  [Playtest] finished armtide team 0 at 6.97 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +29.5 bank 39/1650, energy +492.4 bank 2049/2201, units 57
  7.15  [Playtest] finished armfmkr team 0 at 7.15 min
  7.29  [Playtest] finished armtide team 0 at 7.29 min
  7.61  [Playtest] finished armtide team 0 at 7.61 min
  7.73  [Playtest] finished armnanotcplat team 0 at 7.73 min
  7.79  [Playtest] finished armmex team 0 at 7.79 min
  7.92  [Playtest] finished armnanotcplat team 0 at 7.92 min
  7.92  [Playtest] finished armtide team 0 at 7.93 min
  7.93  [Playtest] finished armmex team 0 at 7.93 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +33.3 bank 20/1750, energy +545.0 bank 1902/2401, units 70
  8.15  [Playtest] finished armnanotcplat team 0 at 8.15 min
  8.19  [Playtest] finished armtide team 0 at 8.19 min
  8.32  [Playtest] finished armtl team 0 at 8.32 min
  8.42  [Playtest] finished armtide team 0 at 8.42 min
  8.45  [Playtest] finished armfmkr team 0 at 8.45 min
  8.48  [Playtest] finished armfmkr team 0 at 8.48 min
  8.53  [Playtest] finished armtide team 0 at 8.53 min
  8.81  [Playtest] finished armtide team 0 at 8.81 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +35.5 bank 20/1750, energy +646.2 bank 2123/2601, units 82
  9.02  [Playtest] finished armmex team 0 at 9.02 min
  9.02  [Playtest] finished armmex team 0 at 9.02 min
  9.06  [Playtest] finished armtl team 0 at 9.06 min
  9.10  [Playtest] finished armtide team 0 at 9.10 min
  9.36  [Playtest] finished armtide team 0 at 9.36 min
  9.49  [Playtest] finished armnanotcplat team 0 at 9.49 min
  9.54  [Playtest] finished armtl team 0 at 9.54 min
  9.68  [Playtest] finished armtide team 0 at 9.68 min
  9.90  [Playtest] finished armmex team 0 at 9.90 min
  9.92  [Playtest] finished armtide team 0 at 9.92 min
  9.98  [Playtest] finished armmex team 0 at 9.98 min
  9.98  [Playtest] finished armfrad team 0 at 9.98 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +43.8 bank 21/1950, energy +722.8 bank 2290/2851, units 97
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 10.10  [Playtest] finished armtide team 0 at 10.10 min
 10.15  [Playtest] finished armfmkr team 0 at 10.15 min
 10.16  [Playtest] finished armtl team 0 at 10.16 min
 10.28  [Playtest] finished armfmkr team 0 at 10.28 min
 10.33  [Playtest] finished armtide team 0 at 10.33 min
 10.42  [Playtest] finished armfmkr team 0 at 10.42 min
 10.50  [Playtest] finished armtl team 0 at 10.50 min
 10.51  [Playtest] finished armnanotcplat team 0 at 10.51 min
 10.56  [Playtest] finished armtide team 0 at 10.56 min
 10.65  [Playtest] finished armestor team 0 at 10.65 min
 10.71  [Playtest] finished armtide team 0 at 10.71 min
 10.81  [Playtest] finished armnanotcplat team 0 at 10.81 min
 10.84  [Playtest] finished armfrad team 0 at 10.84 min
 10.86  [Playtest] finished armtide team 0 at 10.86 min
 10.92  [Playtest] finished armtide team 0 at 10.92 min
 10.96  [Playtest] finished armtide team 0 at 10.96 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +49.3 bank 678/1950, energy +884.0 bank 8091/9201, units 111
 11.01  [Playtest] finished armtide team 0 at 11.01 min
 11.07  [Playtest] finished armtide team 0 at 11.07 min
 11.16  [Playtest] finished armfmkr team 0 at 11.16 min
 11.22  [Playtest] finished armtide team 0 at 11.23 min
 11.23  [Playtest] finished armfmkr team 0 at 11.23 min
 11.29  [Playtest] finished armfmkr team 0 at 11.29 min
 11.33  [Playtest] finished armfmkr team 0 at 11.33 min
 11.38  [Playtest] finished armtide team 0 at 11.38 min
 11.48  [Playtest] finished armtide team 0 at 11.48 min
 11.52  [Playtest] finished armfrad team 0 at 11.52 min
 11.55  [Playtest] finished armtide team 0 at 11.55 min
 11.67  [Playtest] finished armtide team 0 at 11.67 min
 11.75  [Playtest] finished armtide team 0 at 11.75 min
 11.85  [Playtest] finished armtide team 0 at 11.85 min
 11.95  [Playtest] finished armmstor team 0 at 11.95 min
 11.97  [Playtest] finished armtide team 0 at 11.97 min
 11.99  [Playtest] finished armmex team 0 at 11.99 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +53.3 bank 1317/5000, energy +1094.6 bank 7906/9701, units 133
 12.04  [Playtest] finished armtide team 0 at 12.04 min
 12.10  [Playtest] finished armtide team 0 at 12.10 min
 12.17  [Playtest] finished armtide team 0 at 12.17 min
 12.25  [Playtest] finished armnanotcplat team 0 at 12.25 min
 12.26  [Playtest] finished armtide team 0 at 12.26 min
 12.31  [Playtest] finished armfrad team 0 at 12.31 min
 12.38  [Playtest] finished armllt team 0 at 12.38 min
 12.43  [Playtest] finished armtide team 0 at 12.43 min
 12.58  [Playtest] finished armtide team 0 at 12.58 min
 12.78  [Playtest] finished armfmkr team 0 at 12.78 min
 12.88  [Playtest] finished armfmkr team 0 at 12.88 min
 12.97  [Playtest] finished armtl team 0 at 12.97 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +57.6 bank 3495/5000, energy +1206.4 bank 9477/10001, units 145
 13.16  [Playtest] finished armfmkr team 0 at 13.16 min
 13.22  [Playtest] finished armfmkr team 0 at 13.22 min
 13.48  [Playtest] finished armmex team 0 at 13.48 min
 13.51  [Playtest] finished armtide team 0 at 13.51 min
 13.57  [Playtest] finished armtide team 0 at 13.57 min
 13.60  [Playtest] finished armtide team 0 at 13.60 min
 13.66  [Playtest] finished armllt team 0 at 13.66 min
 13.82  [Playtest] finished armrad team 0 at 13.82 min
 13.83  [Playtest] finished armnanotcplat team 0 at 13.83 min
 13.96  [Playtest] finished armtide team 0 at 13.96 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +44.9 bank 3929/5050, energy +1287.6 bank 7660/10201, units 161
 14.71  [Playtest] finished armrad team 0 at 14.71 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +61.9 bank 3877/5050, energy +1289.9 bank 8411/10201, units 167
 15.28  [Playtest] finished armrad team 0 at 15.28 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +61.7 bank 4146/5050, energy +1286.8 bank 7782/10201, units 182
 16.21  [Playtest] finished armllt team 0 at 16.21 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +61.9 bank 3889/5050, energy +1304.0 bank 8417/10201, units 193
 17.25  [Playtest] finished armllt team 0 at 17.25 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +60.6 bank 4371/5050, energy +1304.5 bank 7929/10201, units 210
 19.00  [Playtest] eco team 0 at 19.0 min: metal +50.1 bank 3834/5050, energy +1261.6 bank 7689/10201, units 218
 20.00  [Playtest] eco team 0 at 20.0 min: metal +48.6 bank 4104/5050, energy +1289.3 bank 7660/10201, units 232
 20.00  [Playtest] camera requested (4814,11077) height=2200
 20.00  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 20.00  [Playtest] screenshot at 20.0 min of team 0 at (4814, 11077)
 21.00  [Playtest] eco team 0 at 21.0 min: metal +61.9 bank 4299/5050, energy +1281.1 bank 8326/10201, units 240
 22.00  [Playtest] eco team 0 at 22.0 min: metal +56.0 bank 4239/5050, energy +1261.9 bank 7719/10201, units 251
 23.00  [Playtest] eco team 0 at 23.0 min: metal +46.4 bank 4175/5050, energy +1281.9 bank 8263/10201, units 261
 24.00  [Playtest] eco team 0 at 24.0 min: metal +59.5 bank 4364/5050, energy +1274.0 bank 8190/10201, units 277
 25.00  [Playtest] eco team 0 at 25.0 min: metal +61.9 bank 3883/5050, energy +1304.8 bank 8535/10201, units 287
 25.61  [Playtest] finished armtl team 0 at 25.61 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +61.9 bank 3884/5050, energy +1286.5 bank 8222/10201, units 299
 26.21  [Playtest] finished armtl team 0 at 26.21 min
 26.49  [Playtest] finished armrad team 0 at 26.49 min
 26.53  [Playtest] finished armfrad team 0 at 26.53 min
 26.59  [Playtest] finished armtl team 0 at 26.59 min
 26.94  [Playtest] finished armtl team 0 at 26.94 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +61.9 bank 4107/5050, energy +1299.1 bank 8437/10201, units 310
 27.86  [Playtest] finished armtl team 0 at 27.86 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +61.9 bank 4222/5050, energy +1296.2 bank 7928/10201, units 328
 29.00  [Playtest] eco team 0 at 29.0 min: metal +47.9 bank 3914/5050, energy +1267.8 bank 8256/10201, units 340
 29.00  [Playtest] camera requested (4814,11077) height=2200
 29.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 29.01  [Playtest] screenshot at 29.0 min of team 0 at (4814, 11077)
 30.00  [Playtest] eco team 0 at 30.0 min: metal +61.9 bank 4421/5050, energy +1297.3 bank 7951/10201, units 349
```

## Native lines (all AIs, first 120)

```
  1.75  BUILDER: discarded 1 unused default task(s) in the last minute
  1.77  BUILDER: discarded 1 unused default task(s) in the last minute
  2.75  BUILDER: discarded 3 unused default task(s) in the last minute
  2.77  BUILDER: discarded 1 unused default task(s) in the last minute
  3.75  BUILDER: discarded 3 unused default task(s) in the last minute
  3.96  BUILDER: discarded 4 unused default task(s) in the last minute
  4.76  BUILDER: discarded 6 unused default task(s) in the last minute
  4.96  BUILDER: discarded 14 unused default task(s) in the last minute
  5.76  BUILDER: discarded 60 unused default task(s) in the last minute
  5.97  BUILDER: discarded 60 unused default task(s) in the last minute
  6.77  BUILDER: discarded 48 unused default task(s) in the last minute
  6.97  BUILDER: discarded 64 unused default task(s) in the last minute
  7.80  BUILDER: discarded 1 unused default task(s) in the last minute
  7.98  BUILDER: discarded 57 unused default task(s) in the last minute
  8.81  BUILDER: discarded 1 unused default task(s) in the last minute
  8.99  BUILDER: discarded 13 unused default task(s) in the last minute
 10.34  BUILDER: discarded 1 unused default task(s) in the last minute
 11.08  BUILDER: discarded 1 unused default task(s) in the last minute
 11.34  BUILDER: discarded 5 unused default task(s) in the last minute
 12.08  BUILDER: discarded 6 unused default task(s) in the last minute
 12.34  BUILDER: discarded 9 unused default task(s) in the last minute
 13.08  BUILDER: discarded 5 unused default task(s) in the last minute
 14.09  BUILDER: discarded 2 unused default task(s) in the last minute
```
