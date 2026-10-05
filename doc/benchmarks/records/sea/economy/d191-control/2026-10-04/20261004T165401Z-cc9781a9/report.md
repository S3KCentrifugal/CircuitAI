# Playtest report: PASS

- Verdict: **PASS** (reached 25 min)
- Game time reached: 25.0 min (frame 45000); wall 189 s
- DLL: build-theatres\d191-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T13:50:50
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-control\supreme\20261004T165049Z-dcf6b4c2\runs\20261004T165401Z-cc9781a9\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:33.415284][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.4 min | `[t=00:00:48.274113][f=0002585] [SeaWatch] finished frame=2585 id=10240 def=armsy builder=28578` |
| expect `first-ship-exit` | seen at 2.4 min | `[t=00:00:52.107978][f=0004260] [SeaWatch] egress id=29615 yard=10240 seconds=4.6 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-control\supreme\20261004T165049Z-dcf6b4c2\runs\20261004T165401Z-cc9781a9\screen_2026-10-04_16-51-57-263.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-control\supreme\20261004T165049Z-dcf6b4c2\runs\20261004T165401Z-cc9781a9\screen_2026-10-04_16-52-18-571.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-control\supreme\20261004T165049Z-dcf6b4c2\runs\20261004T165401Z-cc9781a9\screen_2026-10-04_16-53-17-037.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 25.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.19  [Playtest] finished armmex team 0 at 0.19 min
  0.20  [Team][Roster] first mex 6887 at 4608,11072
  0.20  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4775|11078|0|7|1|4608|11072
  0.38  [Playtest] finished armmex team 0 at 0.38 min
  0.49  [Playtest] finished armwin team 0 at 0.49 min
  0.60  [Playtest] finished armwin team 0 at 0.60 min
  0.71  [Playtest] finished armwin team 0 at 0.71 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 1085/1100, energy +86.4 bank 1001/1001, units 6
  1.44  [Playtest] finished armsy team 0 at 1.44 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +5.9 bank 576/1200, energy +94.0 bank 3/1151, units 10
  2.22  [Playtest] finished armtide team 0 at 2.22 min
  2.43  [Playtest] finished armtide team 0 at 2.43 min
  2.77  [Playtest] finished armtide team 0 at 2.77 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.6 bank 0/1200, energy +155.6 bank 1350/1351, units 18
  3.17  [Playtest] finished armtide team 0 at 3.17 min
  3.51  [Playtest] finished armmex team 0 at 3.51 min
  3.54  [Playtest] finished armtide team 0 at 3.54 min
  3.62  [Playtest] finished armtide team 0 at 3.62 min
  3.83  [Playtest] finished armtide team 0 at 3.83 min
  3.93  [Playtest] finished armmex team 0 at 3.93 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.9 bank 15/1300, energy +248.0 bank 1547/1551, units 24
  4.10  [Playtest] finished armtide team 0 at 4.10 min
  4.21  [Playtest] finished armmex team 0 at 4.21 min
  4.29  [Playtest] finished armfmkr team 0 at 4.29 min
  4.51  [Playtest] finished armmex team 0 at 4.51 min
  4.59  [Playtest] finished armfmkr team 0 at 4.59 min
  4.77  [Playtest] finished armtide team 0 at 4.77 min
  4.91  [Playtest] finished armmex team 0 at 4.91 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +19.3 bank 18/1450, energy +289.0 bank 1505/1651, units 32
  5.00  [Playtest] target team 0 at (4814, 11077) from its start position
  5.00  [Playtest] camera requested (4814,11077) height=2200
  5.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (4814, 11077)
  5.01  [Playtest] finished armtide team 0 at 5.01 min
  5.21  [Playtest] finished armfmkr team 0 at 5.21 min
  5.31  [Playtest] finished armmex team 0 at 5.31 min
  5.39  [Playtest] finished armtide team 0 at 5.39 min
  5.55  [Playtest] finished armtide team 0 at 5.55 min
  5.61  [Playtest] finished armmex team 0 at 5.61 min
  5.87  [Playtest] finished armmex team 0 at 5.87 min
  6.00  [Playtest] finished armnanotcplat team 0 at 6.00 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +24.2 bank 69/1600, energy +341.7 bank 1259/1801, units 42
  6.03  [Playtest] finished armllt team 0 at 6.03 min
  6.17  [Playtest] finished armrad team 0 at 6.17 min
  6.18  [Playtest] finished armtide team 0 at 6.18 min
  6.33  [Playtest] finished armtide team 0 at 6.33 min
  6.45  [Playtest] finished armtide team 0 at 6.45 min
  6.58  [Playtest] finished armtide team 0 at 6.58 min
  6.64  [Playtest] finished armmex team 0 at 6.64 min
  6.70  [Playtest] finished armtide team 0 at 6.70 min
  6.81  [Playtest] finished armfmkr team 0 at 6.81 min
  6.83  [Playtest] finished armllt team 0 at 6.83 min
  6.94  [Playtest] finished armtide team 0 at 6.94 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +30.3 bank 18/1650, energy +482.5 bank 1810/2201, units 56
  7.04  [Playtest] finished armtide team 0 at 7.04 min
  7.33  [Playtest] finished armtide team 0 at 7.32 min
  7.33  [Playtest] finished armnanotcplat team 0 at 7.33 min
  7.66  [Playtest] finished armtide team 0 at 7.66 min
  7.68  [Playtest] finished armnanotcplat team 0 at 7.68 min
  7.89  [Playtest] finished armmex team 0 at 7.89 min
  7.93  [Playtest] finished armtide team 0 at 7.93 min
  7.95  [Playtest] finished armnanotcplat team 0 at 7.95 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +47.8 bank 66/1700, energy +637.1 bank 2255/2401, units 66
  8.13  [Playtest] finished armtide team 0 at 8.13 min
  8.23  [Playtest] finished armnanotcplat team 0 at 8.23 min
  8.45  [Playtest] finished armmex team 0 at 8.45 min
  8.46  [Playtest] finished armtide team 0 at 8.46 min
  8.60  [Playtest] finished armtide team 0 at 8.60 min
  8.68  [Playtest] finished armfmkr team 0 at 8.68 min
  8.82  [Playtest] finished armfmkr team 0 at 8.82 min
  8.89  [Playtest] finished armfrad team 0 at 8.89 min
  8.92  [Playtest] finished armtide team 0 at 8.92 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +34.0 bank 16/1750, energy +635.0 bank 2112/2651, units 81
  9.01  [Playtest] finished armtl team 0 at 9.01 min
  9.09  [Playtest] finished armtide team 0 at 9.09 min
  9.15  [Playtest] finished armmex team 0 at 9.15 min
  9.30  [Playtest] finished armtl team 0 at 9.30 min
  9.34  [Playtest] finished armtide team 0 at 9.34 min
  9.49  [Playtest] finished armtide team 0 at 9.49 min
  9.61  [Playtest] finished armtl team 0 at 9.61 min
  9.71  [Playtest] finished armtide team 0 at 9.71 min
  9.95  [Playtest] finished armmex team 0 at 9.95 min
  9.95  [Playtest] finished armfrad team 0 at 9.95 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +41.7 bank 20/1850, energy +759.0 bank 2790/2901, units 92
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.02  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 10.08  [Playtest] finished armtide team 0 at 10.08 min
 10.25  [Playtest] finished armmex team 0 at 10.25 min
 10.49  [Playtest] finished armtide team 0 at 10.49 min
 10.52  [Playtest] finished armtl team 0 at 10.52 min
 10.78  [Playtest] finished armtl team 0 at 10.78 min
 10.83  [Playtest] finished armmex team 0 at 10.83 min
 10.83  [Playtest] finished armtide team 0 at 10.83 min
 10.92  [Playtest] finished armmex team 0 at 10.92 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +42.6 bank 1231/2000, energy +821.9 bank 1730/3051, units 104
 11.11  [Playtest] finished armfrad team 0 at 11.11 min
 11.13  [Playtest] finished armnanotcplat team 0 at 11.13 min
 11.18  [Playtest] finished armtide team 0 at 11.18 min
 11.18  [Playtest] finished armwin team 0 at 11.18 min
 11.30  [Playtest] finished armtide team 0 at 11.30 min
 11.38  [Playtest] finished armtl team 0 at 11.38 min
 11.48  [Playtest] finished armfmkr team 0 at 11.48 min
 11.52  [Playtest] finished armtide team 0 at 11.52 min
 11.57  [Playtest] finished armestor team 0 at 11.57 min
 11.66  [Playtest] finished armnanotcplat team 0 at 11.66 min
 11.68  [Playtest] finished armtide team 0 at 11.68 min
 11.86  [Playtest] finished armfrad team 0 at 11.86 min
 11.86  [Playtest] finished armtide team 0 at 11.86 min
 11.94  [Playtest] finished armmstor team 0 at 11.94 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +49.6 bank 1567/5000, energy +945.6 bank 9229/9302, units 117
 12.20  [Playtest] finished armtide team 0 at 12.20 min
 12.53  [Playtest] finished armtide team 0 at 12.53 min
 12.64  [Playtest] finished armtide team 0 at 12.65 min
 12.78  [Playtest] finished armmakr team 0 at 12.78 min
 12.88  [Playtest] finished armtide team 0 at 12.88 min
 12.89  [Playtest] finished armmakr team 0 at 12.89 min
 12.97  [Playtest] finished armmakr team 0 at 12.97 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +52.1 bank 4019/5000, energy +1014.7 bank 7961/9502, units 126
 13.01  [Playtest] finished armtide team 0 at 13.01 min
 13.21  [Playtest] finished armtide team 0 at 13.21 min
 13.38  [Playtest] finished armfmkr team 0 at 13.38 min
 13.40  [Playtest] finished armllt team 0 at 13.40 min
 13.43  [Playtest] finished armtide team 0 at 13.43 min
 13.52  [Playtest] finished armtide team 0 at 13.52 min
 13.61  [Playtest] finished armtide team 0 at 13.61 min
 13.72  [Playtest] finished armtide team 0 at 13.72 min
 13.82  [Playtest] finished armtide team 0 at 13.82 min
 13.93  [Playtest] finished armtide team 0 at 13.93 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +53.6 bank 4097/5000, energy +1195.5 bank 9554/9902, units 145
 14.04  [Playtest] finished armtide team 0 at 14.04 min
 14.38  [Playtest] finished armtide team 0 at 14.38 min
 14.95  [Playtest] finished armmex team 0 at 14.95 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +46.2 bank 3652/5050, energy +1229.0 bank 8045/10002, units 152
 15.12  [Playtest] finished armllt team 0 at 15.12 min
 15.30  [Playtest] finished armrad team 0 at 15.31 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +55.9 bank 3882/5050, energy +1237.7 bank 9118/10002, units 159
 16.32  [Playtest] finished armllt team 0 at 16.32 min
 16.45  [Playtest] finished armrad team 0 at 16.45 min
 16.90  [Playtest] finished armmakr team 0 at 16.90 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +56.9 bank 4106/5050, energy +1227.3 bank 7759/10002, units 172
 17.04  [Playtest] finished armmakr team 0 at 17.04 min
 17.64  [Playtest] finished armrad team 0 at 17.64 min
 17.98  [Playtest] finished armllt team 0 at 17.98 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +57.9 bank 3992/5050, energy +1197.4 bank 7528/10002, units 187
 18.12  [Playtest] finished armtide team 0 at 18.12 min
 18.37  [Playtest] finished armtide team 0 at 18.37 min
 18.53  [Playtest] finished armllt team 0 at 18.53 min
 18.64  [Playtest] finished armnanotcplat team 0 at 18.64 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +57.9 bank 4460/5050, energy +1233.4 bank 9075/10102, units 202
 19.34  [Playtest] finished armmakr team 0 at 19.34 min
 19.53  [Playtest] finished armmakr team 0 at 19.53 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +44.9 bank 3605/5050, energy +1253.9 bank 7727/10102, units 216
 20.00  [Playtest] camera requested (4814,11077) height=2200
 20.02  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (4814, 11077)
 20.36  [Playtest] finished armmakr team 0 at 20.36 min
 20.48  [Playtest] finished armmakr team 0 at 20.48 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +61.9 bank 4208/5050, energy +1266.1 bank 7889/10102, units 229
 22.00  [Playtest] eco team 0 at 22.0 min: metal +61.5 bank 4067/5050, energy +1219.1 bank 8158/10102, units 236
 23.00  [Playtest] eco team 0 at 23.0 min: metal +61.9 bank 3887/5050, energy +1277.5 bank 8290/10102, units 245
 24.00  [Playtest] eco team 0 at 24.0 min: metal +61.9 bank 4008/5050, energy +1282.0 bank 7687/10102, units 262
 25.00  [Playtest] eco team 0 at 25.0 min: metal +61.8 bank 4353/5050, energy +1263.1 bank 7709/10102, units 269
```

## Native lines (all AIs, first 120)

```
  1.67  BUILDER: discarded 1 unused default task(s) in the last minute
  1.68  BUILDER: discarded 1 unused default task(s) in the last minute
  2.67  BUILDER: discarded 7 unused default task(s) in the last minute
  2.69  BUILDER: discarded 2 unused default task(s) in the last minute
  3.68  BUILDER: discarded 4 unused default task(s) in the last minute
  3.69  BUILDER: discarded 3 unused default task(s) in the last minute
  4.68  BUILDER: discarded 1 unused default task(s) in the last minute
  5.69  BUILDER: discarded 34 unused default task(s) in the last minute
  6.12  BUILDER: discarded 1 unused default task(s) in the last minute
  6.69  BUILDER: discarded 40 unused default task(s) in the last minute
  7.12  BUILDER: discarded 1 unused default task(s) in the last minute
  8.94  BUILDER: discarded 1 unused default task(s) in the last minute
  9.94  BUILDER: discarded 4 unused default task(s) in the last minute
 10.53  BUILDER: discarded 1 unused default task(s) in the last minute
 10.94  BUILDER: discarded 1 unused default task(s) in the last minute
 11.53  BUILDER: discarded 4 unused default task(s) in the last minute
 11.94  BUILDER: discarded 2 unused default task(s) in the last minute
 12.54  BUILDER: discarded 1 unused default task(s) in the last minute
 12.94  BUILDER: discarded 3 unused default task(s) in the last minute
 13.94  BUILDER: discarded 6 unused default task(s) in the last minute
 14.94  BUILDER: discarded 1 unused default task(s) in the last minute
```
