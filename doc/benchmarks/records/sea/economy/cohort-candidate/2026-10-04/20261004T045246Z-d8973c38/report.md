# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54073); wall 254 s
- DLL: build-theatres\d188-build-6\SkirmishAI.dll (ac71826721992d84); AI BARbTest/test; staged 2026-10-04T01:48:28
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\supreme\20261004T044828Z-2b55a26f\runs\20261004T045246Z-d8973c38\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:39.010021][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.2 min | `[t=00:00:54.610411][f=0002075] [SeaWatch] finished frame=2075 id=18720 def=armsy builder=10235` |
| expect `first-ship-exit` | seen at 4.1 min | `[t=00:01:08.738965][f=0007380] [SeaWatch] egress id=26609 yard=18720 seconds=82.5 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\supreme\20261004T044828Z-2b55a26f\runs\20261004T045246Z-d8973c38\screen_2026-10-04_04-49-45-827.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\supreme\20261004T044828Z-2b55a26f\runs\20261004T045246Z-d8973c38\screen_2026-10-04_04-50-07-971.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\supreme\20261004T044828Z-2b55a26f\runs\20261004T045246Z-d8973c38\screen_2026-10-04_04-51-02-965.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\supreme\20261004T044828Z-2b55a26f\runs\20261004T045246Z-d8973c38\screen_2026-10-04_04-52-29-849.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 31
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 31
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.20  [Playtest] finished armmex team 0 at 0.20 min
  0.20  [Team][Roster] first mex 25176 at 4608,11072
  0.20  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4775|11078|0|7|1|4608|11072
  0.23  [SEA][Layout] berth sea.berth.0 armsy at=5840,10640 facing=2
  0.40  [Playtest] finished armmex team 0 at 0.40 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 943/1100, energy +30.0 bank 736/1000, units 4
  1.15  [Playtest] finished armsy team 0 at 1.15 min
  1.71  [Playtest] finished armmex team 0 at 1.71 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.9 bank 940/1250, energy +30.0 bank 69/1100, units 6
  2.91  [Playtest] finished armwin team 0 at 2.91 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.9 bank 1241/1250, energy +51.4 bank 5/1150, units 9
  3.15  [Playtest] finished armtide team 0 at 3.15 min
  3.68  [Playtest] finished armmex team 0 at 3.68 min
  3.98  [Playtest] finished armtide team 0 at 3.98 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +11.2 bank 1192/1300, energy +84.0 bank 319/1300, units 13
  4.10  [Playtest] finished armwin team 0 at 4.10 min
  4.12  [Playtest] finished armtide team 0 at 4.12 min
  4.23  [Playtest] finished armwin team 0 at 4.23 min
  4.43  [Playtest] finished armtide team 0 at 4.43 min
  4.49  [Playtest] finished armmex team 0 at 4.49 min
  4.73  [Playtest] finished armtide team 0 at 4.73 min
  4.74  [Playtest] finished armfrad team 0 at 4.74 min
  4.92  [Playtest] finished armmex team 0 at 4.92 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +15.5 bank 703/1400, energy +212.9 bank 1486/1501, units 23
  5.00  [Playtest] target team 0 at (4814, 11077) from its start position
  5.00  [Playtest] camera requested (4814,11077) height=2200
  5.00  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (4814, 11077)
  5.04  [Playtest] finished armtide team 0 at 5.04 min
  5.29  [Playtest] finished armtide team 0 at 5.30 min
  5.42  [Playtest] finished armtide team 0 at 5.42 min
  5.50  [Playtest] finished armtl team 0 at 5.50 min
  5.71  [Playtest] finished armtide team 0 at 5.71 min
  5.72  [Playtest] finished armtide team 0 at 5.72 min
  5.75  [Playtest] finished armmex team 0 at 5.75 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +17.8 bank 94/1450, energy +318.0 bank 1735/1751, units 34
  6.02  [Playtest] finished armtide team 0 at 6.02 min
  6.03  [Playtest] finished armmex team 0 at 6.03 min
  6.03  [Playtest] finished armtide team 0 at 6.03 min
  6.42  [Playtest] finished armtide team 0 at 6.42 min
  6.54  [Playtest] finished armtl team 0 at 6.54 min
  6.71  [Playtest] finished armmex team 0 at 6.71 min
  6.74  [Playtest] finished armtide team 0 at 6.74 min
  6.88  [Playtest] finished armtl team 0 at 6.88 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +22.2 bank 101/1550, energy +373.1 bank 1931/1951, units 43
  7.09  [Playtest] finished armmex team 0 at 7.09 min
  7.16  [Playtest] finished armtide team 0 at 7.16 min
  7.33  [Playtest] finished armmex team 0 at 7.33 min
  7.42  [Playtest] finished armmex team 0 at 7.43 min
  7.46  [Playtest] finished armtide team 0 at 7.46 min
  7.59  [Playtest] finished armtide team 0 at 7.59 min
  7.69  [Playtest] finished armtide team 0 at 7.69 min
  7.82  [Playtest] finished armmex team 0 at 7.82 min
  7.86  [Playtest] finished armtl team 0 at 7.86 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +31.1 bank 384/1750, energy +491.9 bank 2180/2201, units 56
  8.08  [Playtest] finished armtide team 0 at 8.08 min
  8.09  [Playtest] finished armmex team 0 at 8.09 min
  8.10  [Playtest] finished armtide team 0 at 8.10 min
  8.35  [Playtest] finished armmex team 0 at 8.35 min
  8.38  [Playtest] finished armtide team 0 at 8.38 min
  8.47  [Playtest] finished armtide team 0 at 8.47 min
  8.50  [Playtest] finished armllt team 0 at 8.50 min
  8.58  [Playtest] finished armtide team 0 at 8.58 min
  8.58  [Playtest] finished armfmkr team 0 at 8.58 min
  8.59  [Playtest] finished armtide team 0 at 8.59 min
  8.65  [Playtest] finished armrad team 0 at 8.65 min
  8.90  [Playtest] finished armnanotcplat team 0 at 8.90 min
  8.98  [Playtest] finished armtide team 0 at 8.98 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +36.7 bank 779/1850, energy +630.9 bank 2564/2601, units 72
  9.05  [Playtest] finished armtide team 0 at 9.05 min
  9.12  [Playtest] finished armmex team 0 at 9.13 min
  9.17  [Playtest] finished armtide team 0 at 9.17 min
  9.28  [Playtest] finished armtide team 0 at 9.28 min
  9.32  [Playtest] finished armllt team 0 at 9.32 min
  9.36  [Playtest] finished armtide team 0 at 9.36 min
  9.45  [Playtest] finished armtide team 0 at 9.45 min
  9.52  [Playtest] finished armtide team 0 at 9.52 min
  9.57  [Playtest] finished armtide team 0 at 9.57 min
  9.58  [Playtest] finished armfmkr team 0 at 9.58 min
  9.74  [Playtest] finished armtide team 0 at 9.74 min
  9.86  [Playtest] finished armtide team 0 at 9.86 min
  9.91  [Playtest] finished armtide team 0 at 9.91 min
  9.93  [Playtest] finished armllt team 0 at 9.93 min
  9.93  [Playtest] finished armfmkr team 0 at 9.93 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +41.0 bank 403/1900, energy +852.0 bank 3098/3151, units 91
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.01  [Playtest] finished armtide team 0 at 10.01 min
 10.02  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 10.10  [Playtest] finished armrad team 0 at 10.10 min
 10.14  [Playtest] finished armtide team 0 at 10.14 min
 10.15  [Playtest] finished armfmkr team 0 at 10.15 min
 10.27  [Playtest] finished armtide team 0 at 10.27 min
 10.31  [Playtest] finished armfmkr team 0 at 10.31 min
 10.53  [Playtest] finished armtide team 0 at 10.53 min
 10.54  [Playtest] finished armllt team 0 at 10.54 min
 10.64  [Playtest] finished armtide team 0 at 10.64 min
 10.65  [Playtest] finished armtide team 0 at 10.65 min
 10.67  [Playtest] finished armfmkr team 0 at 10.67 min
 10.72  [Playtest] finished armtide team 0 at 10.72 min
 10.87  [Playtest] finished armllt team 0 at 10.87 min
 10.91  [Playtest] finished armtide team 0 at 10.91 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +44.0 bank 1599/1900, energy +1010.4 bank 3461/3551, units 107
 11.10  [Playtest] finished armrad team 0 at 11.10 min
 11.12  [Playtest] finished armtide team 0 at 11.12 min
 11.15  [Playtest] finished armtide team 0 at 11.15 min
 11.15  [Playtest] finished armtide team 0 at 11.15 min
 11.24  [Playtest] finished armtide team 0 at 11.24 min
 11.24  [Playtest] finished armtide team 0 at 11.24 min
 11.49  [Playtest] finished armfmkr team 0 at 11.49 min
 11.60  [Playtest] finished armnanotcplat team 0 at 11.60 min
 11.68  [Playtest] finished armtide team 0 at 11.68 min
 11.69  [Playtest] finished armtide team 0 at 11.69 min
 11.76  [Playtest] finished armfmkr team 0 at 11.76 min
 11.85  [Playtest] finished armfmkr team 0 at 11.85 min
 11.86  [Playtest] finished armfmkr team 0 at 11.86 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +48.0 bank 1803/1900, energy +1150.8 bank 3362/3901, units 120
 12.01  [Playtest] finished armtide team 0 at 12.01 min
 12.05  [Playtest] finished armfmkr team 0 at 12.05 min
 12.16  [Playtest] finished armtide team 0 at 12.16 min
 12.37  [Playtest] finished armfmkr team 0 at 12.37 min
 12.41  [Playtest] finished armtide team 0 at 12.41 min
 12.41  [Playtest] finished armfmkr team 0 at 12.41 min
 12.58  [Playtest] finished armtide team 0 at 12.58 min
 12.75  [Playtest] finished armfmkr team 0 at 12.75 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +50.1 bank 1893/1900, energy +1251.3 bank 3445/4101, units 130
 13.15  [Playtest] finished armfmkr team 0 at 13.15 min
 13.19  [Playtest] finished armllt team 0 at 13.19 min
 13.27  [Playtest] finished armmex team 0 at 13.27 min
 13.27  [Playtest] finished armfmkr team 0 at 13.27 min
 13.66  [Playtest] finished armnanotcplat team 0 at 13.66 min
 13.80  [Playtest] finished armmex team 0 at 13.80 min
 13.81  [Playtest] finished armllt team 0 at 13.81 min
 13.81  [Playtest] finished armtl team 0 at 13.81 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +69.7 bank 1815/2000, energy +1294.6 bank 3616/4101, units 141
 14.21  [Playtest] finished armtide team 0 at 14.21 min
 14.33  [Playtest] finished armtl team 0 at 14.33 min
 14.45  [Playtest] finished armfrad team 0 at 14.45 min
 14.52  [Playtest] finished armfmkr team 0 at 14.52 min
 14.53  [Playtest] finished armtide team 0 at 14.53 min
 14.69  [Playtest] finished armfrad team 0 at 14.69 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +56.1 bank 1740/2000, energy +1276.2 bank 3508/4201, units 152
 15.14  [Playtest] finished armtide team 0 at 15.14 min
 15.22  [Playtest] finished armtide team 0 at 15.23 min
 15.29  [Playtest] finished armmex team 0 at 15.29 min
 15.46  [Playtest] finished armtide team 0 at 15.46 min
 15.56  [Playtest] finished armtide team 0 at 15.56 min
 15.95  [Playtest] finished armfmkr team 0 at 15.95 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +56.0 bank 2041/2050, energy +1342.8 bank 3687/4401, units 163
 16.13  [Playtest] finished armfmkr team 0 at 16.13 min
 16.14  [Playtest] finished armrad team 0 at 16.14 min
 16.14  [Playtest] finished armfmkr team 0 at 16.14 min
 16.47  [Playtest] finished armtide team 0 at 16.47 min
 16.57  [Playtest] finished armfmkr team 0 at 16.57 min
 16.80  [Playtest] finished armtide team 0 at 16.80 min
 16.88  [Playtest] finished armfmkr team 0 at 16.88 min
 16.99  [Playtest] finished armtide team 0 at 16.99 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +56.0 bank 2010/2050, energy +1429.1 bank 3744/4551, units 178
 17.07  [Playtest] finished armllt team 0 at 17.07 min
 17.12  [Playtest] finished armfmkr team 0 at 17.12 min
 17.20  [Playtest] finished armrad team 0 at 17.20 min
 17.21  [Playtest] finished armfmkr team 0 at 17.21 min
 17.26  [Playtest] finished armtide team 0 at 17.26 min
 17.33  [Playtest] finished armtide team 0 at 17.33 min
 17.68  [Playtest] finished armtide team 0 at 17.68 min
 17.69  [Playtest] finished armtide team 0 at 17.69 min
 17.77  [Playtest] finished armfmkr team 0 at 17.77 min
 17.92  [Playtest] finished armtide team 0 at 17.92 min
 17.94  [Playtest] finished armtide team 0 at 17.94 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +58.5 bank 2049/2050, energy +1577.9 bank 4341/4851, units 196
 18.15  [Playtest] finished armtide team 0 at 18.15 min
 18.15  [Playtest] finished armfmkr team 0 at 18.15 min
 18.16  [Playtest] finished armfmkr team 0 at 18.16 min
 18.33  [Playtest] finished armfmkr team 0 at 18.33 min
 18.47  [Playtest] finished armfmkr team 0 at 18.47 min
 18.50  [Playtest] finished armfmkr team 0 at 18.50 min
 18.51  [Playtest] finished armtide team 0 at 18.51 min
 18.86  [Playtest] finished armnanotcplat team 0 at 18.86 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +63.0 bank 2049/2050, energy +1611.9 bank 4479/4951, units 211
 19.31  [Playtest] finished armtide team 0 at 19.31 min
 19.36  [Playtest] finished armtide team 0 at 19.36 min
 19.55  [Playtest] finished armtide team 0 at 19.55 min
 19.59  [Playtest] finished armtide team 0 at 19.59 min
 19.77  [Playtest] finished armfmkr team 0 at 19.77 min
 19.81  [Playtest] finished armtide team 0 at 19.81 min
 19.88  [Playtest] finished armfmkr team 0 at 19.88 min
 19.88  [Playtest] finished armfmkr team 0 at 19.88 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +64.5 bank 2044/2050, energy +1691.5 bank 4512/5201, units 230
 20.00  [Playtest] camera requested (4814,11077) height=2200
 20.00  [Playtest] finished armtide team 0 at 20.00 min
 20.02  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (4814, 11077)
 20.10  [Playtest] finished armfmkr team 0 at 20.10 min
 20.15  [Playtest] finished armfmkr team 0 at 20.15 min
 20.29  [Playtest] finished armfmkr team 0 at 20.29 min
 20.41  [Playtest] finished armtide team 0 at 20.41 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +61.2 bank 2045/2050, energy +1736.6 bank 4548/5301, units 237
 22.00  [Playtest] eco team 0 at 22.0 min: metal +60.5 bank 1769/2050, energy +1765.0 bank 4523/5301, units 243
 23.00  [Playtest] eco team 0 at 23.0 min: metal +63.6 bank 2029/2050, energy +1736.2 bank 4560/5301, units 249
 24.00  [Playtest] eco team 0 at 24.0 min: metal +61.6 bank 2043/2050, energy +1731.8 bank 4812/5301, units 257
 25.00  [Playtest] eco team 0 at 25.0 min: metal +69.1 bank 2030/2050, energy +1748.3 bank 4551/5301, units 268
 25.63  [Playtest] finished armtl team 0 at 25.63 min
 25.76  [Playtest] finished armfrad team 0 at 25.76 min
 25.97  [Playtest] finished armfrad team 0 at 25.97 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +58.6 bank 1445/2050, energy +1765.1 bank 4472/5301, units 279
 26.04  [Playtest] finished armtl team 0 at 26.04 min
 26.29  [Playtest] finished armtl team 0 at 26.28 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +67.1 bank 2016/2050, energy +1766.1 bank 4551/5301, units 286
 27.15  [Playtest] finished armtl team 0 at 27.15 min
 27.49  [Playtest] finished armtl team 0 at 27.49 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +60.6 bank 2050/2050, energy +1735.8 bank 4815/5301, units 298
 29.00  [Playtest] eco team 0 at 29.0 min: metal +68.3 bank 2041/2050, energy +1732.3 bank 4670/5301, units 311
 29.00  [Playtest] camera requested (4814,11077) height=2200
 29.02  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (4814, 11077)
 30.00  [Playtest] eco team 0 at 30.0 min: metal +63.6 bank 2042/2050, energy +1767.0 bank 4562/5301, units 318
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(10235) at (4776, 11079) walks to (4744, 11078), 136 from the armmex site (4608, 11072)
  0.08  EXP: approach: armcom(2054) at (7537, 1223) walks to (7560, 1224), 136 from the armmex site (7696, 1232)
  0.21  EXP: approach: armcom(2054) at (7547, 1223) walks to (7475, 1095), 136 from the armmex site (7408, 976)
  0.21  EXP: approach: armcom(10235) at (4762, 11078) walks to (4832, 11208), 136 from the armmex site (4896, 11328)
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
  0.41  EXP: approach: armcom(10235) at (4813, 11185) walks to (5691, 10719), 169 from the armsy site (5840, 10640)
  0.41  EXP: approach: armcom(2054) at (7491, 1117) walks to (6628, 1584), 168 from the armsy site (6480, 1664)
  0.41  RESERVE: served armsy at (5840, 10640) facing 2 (id 1, 0 of this def still held)
  0.41  RESERVE: served armsy at (6480, 1664) facing 0 (id 1, 0 of this def still held)
  1.15  EXP: approach: armcom(2054) at (6656, 1566) walks to (7272, 1515), 136 from the armmex site (7408, 1504)
  1.17  EXP: approach: armcom(10235) at (5667, 10737) walks to (5032, 10789), 136 from the armmex site (4896, 10800)
  1.73  RESERVE: zone 10 at (5912, 10984) facing 2, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armtide at (5912, 10984) facing 2 (id 8)
  1.73  RESERVE: zone 11 at (5848, 10984) facing 2, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armtide at (5848, 10984) facing 2 (id 9)
  1.73  RESERVE: zone 12 at (5784, 10984) facing 2, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armtide at (5784, 10984) facing 2 (id 10)
  1.73  RESERVE: zone 13 at (5912, 10920) facing 2, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armtide at (5912, 10920) facing 2 (id 11)
  1.73  RESERVE: zone 14 at (5848, 10920) facing 2, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armtide at (5848, 10920) facing 2 (id 12)
  1.73  RESERVE: zone 15 at (5784, 10920) facing 2, 3x3 cells: 9 of 9 held
  1.73  RESERVE: armtide at (5784, 10920) facing 2 (id 13)
  1.73  RESERVE: zone 16 at (5840, 10958) facing 2, 12x9 cells: 42 of 108 held
  1.75  RESERVE: zone 20 at (6424, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.75  RESERVE: armtide at (6424, 1416) facing 0 (id 18)
  1.75  RESERVE: zone 21 at (6488, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.75  RESERVE: armtide at (6488, 1416) facing 0 (id 19)
  1.75  RESERVE: zone 20 released
  1.75  RESERVE: zone 21 released
  1.75  RESERVE: zone 22 at (6376, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.75  RESERVE: armtide at (6376, 1400) facing 0 (id 20)
  1.75  RESERVE: zone 22 released
  1.75  RESERVE: zone 23 at (6344, 1384) facing 0, 3x3 cells: 9 of 9 held
  1.75  RESERVE: armtide at (6344, 1384) facing 0 (id 21)
  1.75  RESERVE: zone 23 released
  1.78  RESERVE: zone 24 at (6328, 1352) facing 0, 3x3 cells: 9 of 9 held
  1.78  RESERVE: armtide at (6328, 1352) facing 0 (id 22)
  1.78  RESERVE: zone 25 at (6392, 1352) facing 0, 3x3 cells: 9 of 9 held
  1.78  RESERVE: armtide at (6392, 1352) facing 0 (id 23)
  1.78  RESERVE: zone 24 released
  1.78  RESERVE: zone 25 released
  1.78  RESERVE: zone 26 at (6328, 1320) facing 0, 3x3 cells: 9 of 9 held
  1.78  RESERVE: armtide at (6328, 1320) facing 0 (id 24)
  1.78  RESERVE: zone 27 at (6392, 1320) facing 0, 3x3 cells: 9 of 9 held
  1.78  RESERVE: armtide at (6392, 1320) facing 0 (id 25)
  1.78  RESERVE: zone 26 released
  1.78  RESERVE: zone 27 released
  1.78  RESERVE: zone 28 at (6328, 1272) facing 0, 3x3 cells: 9 of 9 held
  1.78  RESERVE: armtide at (6328, 1272) facing 0 (id 26)
  1.78  RESERVE: zone 29 at (6392, 1272) facing 0, 3x3 cells: 9 of 9 held
  1.78  RESERVE: armtide at (6392, 1272) facing 0 (id 27)
  1.78  RESERVE: zone 28 released
  1.78  RESERVE: zone 29 released
  1.78  RESERVE: zone 30 at (6344, 1240) facing 0, 3x3 cells: 9 of 9 held
  1.78  RESERVE: armtide at (6344, 1240) facing 0 (id 28)
  1.78  RESERVE: zone 30 released
  1.78  RESERVE: zone 31 at (6376, 1224) facing 0, 3x3 cells: 9 of 9 held
  1.78  RESERVE: armtide at (6376, 1224) facing 0 (id 29)
```
