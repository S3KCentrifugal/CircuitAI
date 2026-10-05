# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.2 min (frame 54298); wall 198 s
- DLL: build-theatres\d189-build-7\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T08:13:42
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\supreme\20261004T111341Z-938b79c4\runs\20261004T111702Z-fe132b52\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:40.636540][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.1 min | `[t=00:00:55.340004][f=0002060] [SeaWatch] finished frame=2060 id=13026 def=armsy builder=28578` |
| expect `first-ship-exit` | seen at 3.2 min | `[t=00:01:03.908949][f=0005820] [SeaWatch] egress id=26405 yard=13026 seconds=9.6 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\supreme\20261004T111341Z-938b79c4\runs\20261004T111702Z-fe132b52\screen_2026-10-04_11-14-57-550.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\supreme\20261004T111341Z-938b79c4\runs\20261004T111702Z-fe132b52\screen_2026-10-04_11-15-19-055.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\supreme\20261004T111341Z-938b79c4\runs\20261004T111702Z-fe132b52\screen_2026-10-04_11-16-09-992.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\supreme\20261004T111341Z-938b79c4\runs\20261004T111702Z-fe132b52\screen_2026-10-04_11-16-54-522.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 30.5 min
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
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.20  [Playtest] finished armmex team 0 at 0.20 min
  0.22  [Team][Roster] first mex 6887 at 4608,11072
  0.22  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4775|11078|0|7|1|4608|11072
  0.23  [SEA][Layout] berth sea.berth.0 armsy at=5840,10640 facing=2
  0.39  [Playtest] finished armmex team 0 at 0.39 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 936/1100, energy +30.0 bank 731/1000, units 4
  1.14  [Playtest] finished armsy team 0 at 1.14 min
  1.72  [Playtest] finished armmex team 0 at 1.72 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.9 bank 947/1250, energy +30.0 bank 115/1100, units 6
  2.73  [Playtest] finished armmex team 0 at 2.73 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +11.2 bank 1300/1300, energy +30.0 bank 104/1100, units 7
  3.66  [Playtest] finished armllt team 0 at 3.66 min
  3.95  [Playtest] finished armmex team 0 at 3.95 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +13.5 bank 1349/1350, energy +37.0 bank 102/1150, units 10
  4.17  [Playtest] finished armwin team 0 at 4.17 min
  4.29  [Playtest] finished armwin team 0 at 4.29 min
  4.40  [Playtest] finished armwin team 0 at 4.40 min
  4.48  [Playtest] finished armmex team 0 at 4.48 min
  4.51  [Playtest] finished armwin team 0 at 4.51 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +15.8 bank 1398/1400, energy +119.5 bank 398/1202, units 17
  5.00  [Playtest] target team 0 at (4814, 11077) from its start position
  5.00  [Playtest] camera requested (4814,11077) height=2200
  5.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (4814, 11077)
  5.06  [Playtest] finished armmex team 0 at 5.06 min
  5.45  [Playtest] finished armtl team 0 at 5.45 min
  5.59  [Playtest] finished armtide team 0 at 5.59 min
  5.70  [Playtest] finished armmex team 0 at 5.70 min
  5.92  [Playtest] finished armtide team 0 at 5.92 min
  5.98  [Playtest] finished armtide team 0 at 5.98 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +20.4 bank 1398/1500, energy +172.4 bank 147/1352, units 25
  6.23  [Playtest] finished armtl team 0 at 6.23 min
  6.24  [Playtest] finished armtide team 0 at 6.24 min
  6.55  [Playtest] finished armtide team 0 at 6.55 min
  6.76  [Playtest] finished armtl team 0 at 6.76 min
  6.84  [Playtest] finished armmex team 0 at 6.84 min
  6.86  [Playtest] finished armtide team 0 at 6.86 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +22.4 bank 1445/1550, energy +251.5 bank 1523/1552, units 33
  7.11  [Playtest] finished armllt team 0 at 7.11 min
  7.29  [Playtest] finished armfrad team 0 at 7.28 min
  7.29  [Playtest] finished armmex team 0 at 7.29 min
  7.36  [Playtest] finished armtl team 0 at 7.36 min
  7.57  [Playtest] finished armmex team 0 at 7.57 min
  7.78  [Playtest] finished armfrad team 0 at 7.78 min
  7.84  [Playtest] finished armtl team 0 at 7.84 min
  7.92  [Playtest] finished armfrad team 0 at 7.92 min
  7.92  [Playtest] finished armmex team 0 at 7.93 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +28.8 bank 1365/1700, energy +223.2 bank 1421/1552, units 41
  8.32  [Playtest] finished armmex team 0 at 8.32 min
  8.45  [Playtest] finished armtide team 0 at 8.45 min
  8.52  [Playtest] finished armtide team 0 at 8.52 min
  8.65  [Playtest] finished armllt team 0 at 8.65 min
  8.76  [Playtest] finished armtide team 0 at 8.76 min
  8.83  [Playtest] finished armtide team 0 at 8.83 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +31.1 bank 1748/1750, energy +332.2 bank 1741/1752, units 51
  9.15  [Playtest] finished armtide team 0 at 9.15 min
  9.15  [Playtest] finished armmex team 0 at 9.15 min
  9.20  [Playtest] finished armfmkr team 0 at 9.20 min
  9.24  [Playtest] finished armrad team 0 at 9.24 min
  9.48  [Playtest] finished armtide team 0 at 9.48 min
  9.48  [Playtest] finished armmex team 0 at 9.48 min
  9.57  [Playtest] finished armfmkr team 0 at 9.57 min
  9.64  [Playtest] finished armllt team 0 at 9.64 min
  9.76  [Playtest] finished armnanotcplat team 0 at 9.76 min
  9.86  [Playtest] finished armfmkr team 0 at 9.86 min
  9.99  [Playtest] finished armfmkr team 0 at 9.99 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +35.7 bank 1844/1850, energy +365.3 bank 1015/1852, units 64
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 10.07  [Playtest] finished armfmkr team 0 at 10.07 min
 10.08  [Playtest] finished armmex team 0 at 10.08 min
 10.14  [Playtest] finished armfmkr team 0 at 10.14 min
 10.24  [Playtest] finished armtide team 0 at 10.24 min
 10.27  [Playtest] finished armllt team 0 at 10.27 min
 10.36  [Playtest] finished armtide team 0 at 10.35 min
 10.45  [Playtest] finished armtide team 0 at 10.44 min
 10.56  [Playtest] finished armtide team 0 at 10.56 min
 10.65  [Playtest] finished armtide team 0 at 10.65 min
 10.75  [Playtest] finished armtide team 0 at 10.75 min
 10.87  [Playtest] finished armrad team 0 at 10.87 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +43.5 bank 1899/1900, energy +502.8 bank 1868/2152, units 75
 11.05  [Playtest] finished armtide team 0 at 11.05 min
 11.33  [Playtest] finished armllt team 0 at 11.33 min
 11.36  [Playtest] finished armtide team 0 at 11.35 min
 11.48  [Playtest] finished armmex team 0 at 11.48 min
 11.48  [Playtest] finished armtide team 0 at 11.48 min
 11.67  [Playtest] finished armrad team 0 at 11.67 min
 11.85  [Playtest] finished armtide team 0 at 11.85 min
 11.87  [Playtest] finished armnanotcplat team 0 at 11.87 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +57.8 bank 1945/1950, energy +642.0 bank 2049/2402, units 88
 12.03  [Playtest] finished armtide team 0 at 12.03 min
 12.14  [Playtest] finished armmex team 0 at 12.14 min
 12.21  [Playtest] finished armrad team 0 at 12.20 min
 12.22  [Playtest] finished armtide team 0 at 12.22 min
 12.52  [Playtest] finished armtide team 0 at 12.52 min
 12.54  [Playtest] finished armtide team 0 at 12.54 min
 12.65  [Playtest] finished armtl team 0 at 12.65 min
 12.66  [Playtest] finished armtide team 0 at 12.66 min
 12.86  [Playtest] finished armtide team 0 at 12.86 min
 12.86  [Playtest] finished armtide team 0 at 12.86 min
 12.94  [Playtest] finished armfrad team 0 at 12.94 min
 12.96  [Playtest] finished armllt team 0 at 12.96 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +46.6 bank 1282/2000, energy +756.9 bank 2279/2852, units 104
 13.07  [Playtest] finished armtide team 0 at 13.07 min
 13.29  [Playtest] finished armtide team 0 at 13.29 min
 13.31  [Playtest] finished armtide team 0 at 13.31 min
 13.39  [Playtest] finished armtl team 0 at 13.39 min
 13.42  [Playtest] finished armfrad team 0 at 13.42 min
 13.61  [Playtest] finished armtide team 0 at 13.61 min
 13.63  [Playtest] finished armtide team 0 at 13.63 min
 13.63  [Playtest] finished armtide team 0 at 13.63 min
 13.97  [Playtest] finished armtide team 0 at 13.98 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +48.6 bank 1998/2000, energy +892.9 bank 3201/3202, units 114
 14.18  [Playtest] finished armtide team 0 at 14.18 min
 14.20  [Playtest] finished armtide team 0 at 14.20 min
 14.42  [Playtest] finished armtide team 0 at 14.42 min
 14.47  [Playtest] finished armmex team 0 at 14.47 min
 14.53  [Playtest] finished armtide team 0 at 14.53 min
 14.65  [Playtest] finished armllt team 0 at 14.65 min
 14.68  [Playtest] finished armfmkr team 0 at 14.68 min
 14.79  [Playtest] finished armtide team 0 at 14.79 min
 14.80  [Playtest] finished armrad team 0 at 14.81 min
 14.86  [Playtest] finished armtide team 0 at 14.86 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +51.9 bank 2049/2050, energy +1025.1 bank 3486/3502, units 123
 15.26  [Playtest] finished armtide team 0 at 15.26 min
 15.38  [Playtest] finished armtide team 0 at 15.38 min
 15.40  [Playtest] finished armfmkr team 0 at 15.40 min
 15.57  [Playtest] finished armtide team 0 at 15.57 min
 15.69  [Playtest] finished armtide team 0 at 15.69 min
 15.80  [Playtest] finished armfmkr team 0 at 15.80 min
 15.88  [Playtest] finished armtide team 0 at 15.88 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +53.9 bank 2049/2050, energy +1110.5 bank 3713/3752, units 132
 16.18  [Playtest] finished armtide team 0 at 16.18 min
 16.25  [Playtest] finished armfmkr team 0 at 16.25 min
 16.26  [Playtest] finished armtide team 0 at 16.26 min
 16.46  [Playtest] finished armtide team 0 at 16.46 min
 16.59  [Playtest] finished armtide team 0 at 16.59 min
 16.70  [Playtest] finished armtide team 0 at 16.70 min
 16.78  [Playtest] finished armtide team 0 at 16.78 min
 16.81  [Playtest] finished armtide team 0 at 16.81 min
 16.97  [Playtest] finished armfmkr team 0 at 16.97 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +55.4 bank 2049/2050, energy +1265.9 bank 4061/4102, units 139
 17.05  [Playtest] finished armfmkr team 0 at 17.05 min
 17.32  [Playtest] finished armtide team 0 at 17.32 min
 17.40  [Playtest] finished armtide team 0 at 17.40 min
 17.45  [Playtest] finished armfrad team 0 at 17.45 min
 17.64  [Playtest] finished armtide team 0 at 17.64 min
 17.67  [Playtest] finished armtide team 0 at 17.67 min
 17.71  [Playtest] finished armtide team 0 at 17.71 min
 17.78  [Playtest] finished armfmkr team 0 at 17.78 min
 17.82  [Playtest] finished armfmkr team 0 at 17.82 min
 17.92  [Playtest] finished armtide team 0 at 17.92 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +58.9 bank 2049/2050, energy +1406.2 bank 4315/4402, units 151
 18.17  [Playtest] finished armfmkr team 0 at 18.17 min
 18.21  [Playtest] finished armfmkr team 0 at 18.21 min
 18.24  [Playtest] finished armfmkr team 0 at 18.24 min
 18.35  [Playtest] finished armfmkr team 0 at 18.35 min
 18.90  [Playtest] finished armtide team 0 at 18.90 min
 18.92  [Playtest] finished armfmkr team 0 at 18.92 min
 18.97  [Playtest] finished armfmkr team 0 at 18.97 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +62.8 bank 2049/2050, energy +1429.0 bank 3984/4452, units 158
 19.12  [Playtest] finished armtide team 0 at 19.12 min
 19.16  [Playtest] finished armfmkr team 0 at 19.16 min
 19.17  [Playtest] finished armtide team 0 at 19.17 min
 19.39  [Playtest] finished armfmkr team 0 at 19.39 min
 19.41  [Playtest] finished armfmkr team 0 at 19.41 min
 19.43  [Playtest] finished armtide team 0 at 19.43 min
 19.60  [Playtest] finished armtide team 0 at 19.60 min
 19.64  [Playtest] finished armfmkr team 0 at 19.64 min
 19.85  [Playtest] finished armtide team 0 at 19.85 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +63.8 bank 2049/2050, energy +1486.2 bank 4184/4702, units 165
 20.00  [Playtest] camera requested (4814,11077) height=2200
 20.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (4814, 11077)
 20.03  [Playtest] finished armfmkr team 0 at 20.03 min
 20.30  [Playtest] finished armtl team 0 at 20.30 min
 20.33  [Playtest] finished armfmkr team 0 at 20.33 min
 20.44  [Playtest] finished armfmkr team 0 at 20.44 min
 20.65  [Playtest] finished armfmkr team 0 at 20.65 min
 20.73  [Playtest] finished armtide team 0 at 20.73 min
 20.75  [Playtest] finished armfmkr team 0 at 20.75 min
 20.81  [Playtest] finished armtide team 0 at 20.81 min
 20.96  [Playtest] finished armtide team 0 at 20.96 min
 20.96  [Playtest] finished armfmkr team 0 at 20.96 min
 20.99  [Playtest] finished armtide team 0 at 20.99 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +66.0 bank 2050/2050, energy +1597.0 bank 4417/4902, units 175
 21.23  [Playtest] finished armtide team 0 at 21.23 min
 21.26  [Playtest] finished armfmkr team 0 at 21.26 min
 21.31  [Playtest] finished armtide team 0 at 21.31 min
 21.71  [Playtest] finished armtide team 0 at 21.71 min
 21.75  [Playtest] finished armtide team 0 at 21.75 min
 21.97  [Playtest] finished armtide team 0 at 21.97 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +67.2 bank 2049/2050, energy +1691.1 bank 4669/5152, units 183
 22.03  [Playtest] finished armtide team 0 at 22.03 min
 22.17  [Playtest] finished armtide team 0 at 22.17 min
 22.22  [Playtest] finished armfmkr team 0 at 22.22 min
 22.35  [Playtest] finished armtide team 0 at 22.35 min
 22.38  [Playtest] finished armfmkr team 0 at 22.38 min
 22.50  [Playtest] finished armfmkr team 0 at 22.50 min
 22.57  [Playtest] finished armfmkr team 0 at 22.57 min
 22.77  [Playtest] finished armfmkr team 0 at 22.76 min
 22.94  [Playtest] finished armfmkr team 0 at 22.94 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +69.2 bank 2049/2050, energy +1755.0 bank 4749/5302, units 191
 23.07  [Playtest] finished armfmkr team 0 at 23.07 min
 23.21  [Playtest] finished armfmkr team 0 at 23.21 min
 23.27  [Playtest] finished armfmkr team 0 at 23.27 min
 23.36  [Playtest] finished armfmkr team 0 at 23.36 min
 23.43  [Playtest] finished armfmkr team 0 at 23.43 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +69.6 bank 2050/2050, energy +1785.6 bank 4840/5302, units 195
 25.00  [Playtest] eco team 0 at 25.0 min: metal +69.6 bank 2050/2050, energy +1785.2 bank 4840/5302, units 195
 25.46  [Playtest] finished armtl team 0 at 25.46 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +69.4 bank 2050/2050, energy +1773.3 bank 4835/5302, units 196
 26.51  [Playtest] finished armtl team 0 at 26.51 min
 26.83  [Playtest] finished armtl team 0 at 26.83 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +69.6 bank 2050/2050, energy +1783.5 bank 4840/5302, units 198
 28.00  [Playtest] eco team 0 at 28.0 min: metal +69.2 bank 2050/2050, energy +1756.7 bank 4824/5302, units 198
 29.00  [Playtest] eco team 0 at 29.0 min: metal +69.5 bank 2050/2050, energy +1776.2 bank 4835/5302, units 198
 29.00  [Playtest] camera requested (4814,11077) height=2200
 29.02  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (4814, 11077)
 30.00  [Playtest] eco team 0 at 30.0 min: metal +68.8 bank 2050/2050, energy +1732.3 bank 4815/5302, units 198
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(28578) at (4776, 11079) walks to (4744, 11078), 136 from the armmex site (4608, 11072)
  0.08  EXP: approach: armcom(891) at (7537, 1223) walks to (7560, 1224), 136 from the armmex site (7696, 1232)
  0.21  EXP: approach: armcom(891) at (7548, 1223) walks to (7475, 1094), 136 from the armmex site (7408, 976)
  0.21  EXP: approach: armcom(28578) at (4758, 11078) walks to (4830, 11209), 136 from the armmex site (4896, 11328)
  0.22  RESERVE: zone 1 at (6480, 1664) facing 0, 6x6 cells: 36 of 36 held
  0.22  RESERVE: armsy at (6480, 1664) facing 0 (id 1)
  0.22  RESERVE: corridor 2 at (6480, 1952) facing 0, 12x30 cells: 360 of 360 held
  0.22  RESERVE: zone 3 at (6424, 1448) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6424, 1448) facing 0 (id 2)
  0.22  RESERVE: zone 4 at (6488, 1448) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6488, 1448) facing 0 (id 3)
  0.22  RESERVE: zone 3 released
  0.22  RESERVE: zone 4 released
  0.22  RESERVE: zone 5 at (6520, 1448) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6520, 1448) facing 0 (id 4)
  0.22  RESERVE: zone 5 released
  0.22  RESERVE: zone 6 at (6504, 1480) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6504, 1480) facing 0 (id 5)
  0.22  RESERVE: zone 6 released
  0.22  RESERVE: zone 7 at (6488, 1512) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6488, 1512) facing 0 (id 6)
  0.22  RESERVE: zone 7 released
  0.22  RESERVE: zone 8 at (6456, 1528) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6456, 1528) facing 0 (id 7)
  0.22  RESERVE: zone 9 at (6520, 1528) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6520, 1528) facing 0 (id 8)
  0.22  RESERVE: zone 8 released
  0.22  RESERVE: zone 9 released
  0.22  RESERVE: zone 10 at (6424, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6424, 1544) facing 0 (id 9)
  0.22  RESERVE: zone 11 at (6488, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6488, 1544) facing 0 (id 10)
  0.22  RESERVE: zone 12 at (6552, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6552, 1544) facing 0 (id 11)
  0.22  RESERVE: zone 10 released
  0.22  RESERVE: zone 11 released
  0.22  RESERVE: zone 12 released
  0.22  RESERVE: zone 13 at (6376, 1528) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6376, 1528) facing 0 (id 12)
  0.22  RESERVE: zone 14 at (6440, 1528) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6440, 1528) facing 0 (id 13)
  0.22  RESERVE: zone 15 at (6504, 1528) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6504, 1528) facing 0 (id 14)
  0.22  RESERVE: zone 16 at (6376, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6376, 1592) facing 0 (id 15)
  0.22  RESERVE: zone 17 at (6440, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6440, 1592) facing 0 (id 16)
  0.22  RESERVE: zone 18 at (6504, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6504, 1592) facing 0 (id 17)
  0.22  RESERVE: zone 19 at (6443, 1561) facing 0, 13x9 cells: 57 of 117 held
  0.23  RESERVE: zone 1 at (5840, 10640) facing 2, 6x6 cells: 36 of 36 held
  0.23  RESERVE: armsy at (5840, 10640) facing 2 (id 1)
  0.23  RESERVE: corridor 2 at (5840, 10352) facing 2, 12x30 cells: 360 of 360 held
  0.23  RESERVE: zone 3 at (5912, 10872) facing 2, 3x3 cells: 9 of 9 held
  0.23  RESERVE: armnanotcplat at (5912, 10872) facing 2 (id 2)
  0.23  RESERVE: zone 4 at (5848, 10872) facing 2, 3x3 cells: 9 of 9 held
  0.23  RESERVE: armnanotcplat at (5848, 10872) facing 2 (id 3)
  0.23  RESERVE: zone 5 at (5784, 10872) facing 2, 3x3 cells: 9 of 9 held
  0.23  RESERVE: armnanotcplat at (5784, 10872) facing 2 (id 4)
  0.23  RESERVE: zone 6 at (5912, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.23  RESERVE: armnanotcplat at (5912, 10808) facing 2 (id 5)
  0.23  RESERVE: zone 7 at (5848, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.23  RESERVE: armnanotcplat at (5848, 10808) facing 2 (id 6)
  0.23  RESERVE: zone 8 at (5784, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.23  RESERVE: armnanotcplat at (5784, 10808) facing 2 (id 7)
  0.23  RESERVE: zone 9 at (5840, 10832) facing 2, 12x8 cells: 42 of 96 held
  0.41  EXP: approach: armcom(28578) at (4810, 11181) walks to (5691, 10718), 169 from the armsy site (5840, 10640)
  0.41  RESERVE: served armsy at (5840, 10640) facing 2 (id 1, 0 of this def still held)
  0.41  EXP: approach: armcom(891) at (7490, 1116) walks to (6628, 1584), 168 from the armsy site (6480, 1664)
  0.41  RESERVE: served armsy at (6480, 1664) facing 0 (id 1, 0 of this def still held)
  1.14  RESERVE: zone 20 at (6424, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.14  RESERVE: armtide at (6424, 1416) facing 0 (id 18)
  1.14  RESERVE: zone 21 at (6488, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.14  RESERVE: armtide at (6488, 1416) facing 0 (id 19)
  1.14  RESERVE: zone 20 released
  1.14  RESERVE: zone 21 released
  1.14  RESERVE: zone 22 at (6376, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.14  RESERVE: armtide at (6376, 1400) facing 0 (id 20)
  1.14  RESERVE: zone 22 released
  1.14  RESERVE: zone 23 at (6344, 1384) facing 0, 3x3 cells: 9 of 9 held
  1.14  RESERVE: armtide at (6344, 1384) facing 0 (id 21)
  1.14  RESERVE: zone 23 released
  1.14  EXP: approach: armcom(891) at (6656, 1566) walks to (7272, 1515), 136 from the armmex site (7408, 1504)
  1.16  RESERVE: zone 10 at (5912, 10984) facing 2, 3x3 cells: 9 of 9 held
  1.16  RESERVE: armtide at (5912, 10984) facing 2 (id 8)
  1.16  RESERVE: zone 11 at (5848, 10984) facing 2, 3x3 cells: 9 of 9 held
  1.16  RESERVE: armtide at (5848, 10984) facing 2 (id 9)
  1.16  RESERVE: zone 12 at (5784, 10984) facing 2, 3x3 cells: 9 of 9 held
  1.16  RESERVE: armtide at (5784, 10984) facing 2 (id 10)
  1.16  RESERVE: zone 13 at (5912, 10920) facing 2, 3x3 cells: 9 of 9 held
  1.16  RESERVE: armtide at (5912, 10920) facing 2 (id 11)
  1.16  RESERVE: zone 14 at (5848, 10920) facing 2, 3x3 cells: 9 of 9 held
  1.16  RESERVE: armtide at (5848, 10920) facing 2 (id 12)
  1.16  RESERVE: zone 15 at (5784, 10920) facing 2, 3x3 cells: 9 of 9 held
  1.16  RESERVE: armtide at (5784, 10920) facing 2 (id 13)
  1.16  RESERVE: zone 16 at (5840, 10958) facing 2, 12x9 cells: 42 of 108 held
  1.17  EXP: approach: armcom(28578) at (5670, 10735) walks to (5032, 10789), 136 from the armmex site (4896, 10800)
  1.70  RESERVE: zone 24 at (6328, 1352) facing 0, 3x3 cells: 9 of 9 held
  1.70  RESERVE: armtide at (6328, 1352) facing 0 (id 22)
  1.70  RESERVE: zone 25 at (6392, 1352) facing 0, 3x3 cells: 9 of 9 held
  1.70  RESERVE: armtide at (6392, 1352) facing 0 (id 23)
  1.70  RESERVE: zone 24 released
  1.70  RESERVE: zone 25 released
  1.70  RESERVE: zone 26 at (6328, 1320) facing 0, 3x3 cells: 9 of 9 held
  1.70  RESERVE: armtide at (6328, 1320) facing 0 (id 24)
  1.70  RESERVE: zone 27 at (6392, 1320) facing 0, 3x3 cells: 9 of 9 held
  1.70  RESERVE: armtide at (6392, 1320) facing 0 (id 25)
  1.70  RESERVE: zone 26 released
  1.70  RESERVE: zone 27 released
  1.70  RESERVE: zone 28 at (6328, 1272) facing 0, 3x3 cells: 9 of 9 held
  1.70  RESERVE: armtide at (6328, 1272) facing 0 (id 26)
  1.70  RESERVE: zone 29 at (6392, 1272) facing 0, 3x3 cells: 9 of 9 held
  1.70  RESERVE: armtide at (6392, 1272) facing 0 (id 27)
  1.70  RESERVE: zone 28 released
  1.70  RESERVE: zone 29 released
  1.70  RESERVE: zone 30 at (6344, 1240) facing 0, 3x3 cells: 9 of 9 held
  1.70  RESERVE: armtide at (6344, 1240) facing 0 (id 28)
  1.70  RESERVE: zone 30 released
  1.70  RESERVE: zone 31 at (6376, 1224) facing 0, 3x3 cells: 9 of 9 held
  1.70  RESERVE: armtide at (6376, 1224) facing 0 (id 29)
```
