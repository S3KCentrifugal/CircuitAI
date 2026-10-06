# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 30.0 min (frame 54030); wall 239 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (aff90f713fc9746a); AI BARbTest/test; staged 2026-10-05T21:18:58
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: seaplane-natural.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada-eco\supreme\20261006T001858Z-cfce7f14\runs\20261006T002307Z-31832977\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `mex` | seen at 4.4 min | `[t=00:01:07.058009][f=0007859] [SeaTransition] PASS mex completed by first construction ship` |
| expect `platform` | **missing** (by 30 min) | |
| expect `aircraft` | **missing** (by 30 min) | |
| expect `support` | **missing** (by 30 min) | |
| forbid `errors` | clean |  |

## Failures

- 'platform' not seen by 30.0 min
- 'aircraft' not seen by 30.0 min
- 'support' not seen by 30.0 min

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada-eco\supreme\20261006T001858Z-cfce7f14\runs\20261006T002307Z-31832977\screen_2026-10-06_00-20-20-825.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada-eco\supreme\20261006T001858Z-cfce7f14\runs\20261006T002307Z-31832977\screen_2026-10-06_00-20-51-803.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada-eco\supreme\20261006T001858Z-cfce7f14\runs\20261006T002307Z-31832977\screen_2026-10-06_00-21-53-172.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada-eco\supreme\20261006T001858Z-cfce7f14\runs\20261006T002307Z-31832977\screen_2026-10-06_00-22-55-961.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 10, 4 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 36
  0.00  [Playtest] speed 10
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 36
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.23  [SEA][Layout] berth sea.berth.0 armsy at=5840,10640 facing=2
  0.23  [Playtest] finished armmex team 0 at 0.23 min
  0.25  [Team][Roster] first mex 28084 at 4608,11072
  0.25  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4777|11079|0|7|1|4608|11072
  0.38  [SEA][Layout] berth sea.berth.1 armasy at=6064,10384 facing=2
  0.45  [Playtest] finished armmex team 0 at 0.45 min
  0.57  [SEA][Layout] berth sea.berth.2 armplat at=6096,10640 facing=2
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 1014/1100, energy +30.0 bank 856/1000, units 4
  1.21  [Playtest] finished armsy team 0 at 1.21 min
  1.79  [Playtest] finished armmex team 0 at 1.79 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.6 bank 894/1250, energy +30.0 bank 0/1100, units 7
  2.34  [Playtest] finished armllt team 0 at 2.34 min
  2.95  [Playtest] finished armrad team 0 at 2.95 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.9 bank 1136/1250, energy +30.0 bank 58/1100, units 8
  3.41  [Playtest] finished armwin team 0 at 3.41 min
  3.52  [Playtest] finished armwin team 0 at 3.52 min
  3.63  [Playtest] finished armwin team 0 at 3.63 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +6.6 bank 1242/1250, energy +62.5 bank 1/1151, units 14
  4.05  [Playtest] finished armmex team 0 at 4.05 min
  4.34  [Playtest] finished armwin team 0 at 4.34 min
  4.37  [Playtest] finished armmex team 0 at 4.37 min
  4.46  [Playtest] finished armwin team 0 at 4.46 min
  4.74  [Playtest] finished armllt team 0 at 4.74 min
  4.83  [Playtest] finished armmex team 0 at 4.83 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +15.8 bank 1399/1400, energy +138.9 bank 682/1202, units 19
  5.00  [Playtest] camera requested (6200,11000) height=3800
  5.00  [Playtest] camera captured name=ta position=(6200,11000) height=3800
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (6200, 11000)
  5.42  [Playtest] finished armmex team 0 at 5.42 min
  5.71  [Playtest] finished armtl team 0 at 5.71 min
  5.98  [Playtest] finished armtl team 0 at 5.98 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +13.5 bank 1450/1450, energy +90.9 bank 63/1202, units 24
  6.24  [Playtest] finished armmex team 0 at 6.24 min
  6.66  [Playtest] finished armtide team 0 at 6.66 min
  6.72  [Playtest] finished armtl team 0 at 6.72 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +20.4 bank 1471/1500, energy +160.0 bank 31/1252, units 30
  7.02  [Playtest] finished armmex team 0 at 7.02 min
  7.26  [Playtest] finished armtl team 0 at 7.26 min
  7.38  [Playtest] finished armtide team 0 at 7.38 min
  7.60  [Playtest] finished armmex team 0 at 7.60 min
  7.68  [Playtest] finished armtide team 0 at 7.68 min
  7.82  [Playtest] finished armtide team 0 at 7.82 min
  7.88  [Playtest] finished armmex team 0 at 7.88 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +26.8 bank 1616/1650, energy +222.6 bank 681/1402, units 36
  8.19  [Playtest] finished armtide team 0 at 8.19 min
  8.32  [Playtest] finished armtl team 0 at 8.32 min
  8.51  [Playtest] finished armtide team 0 at 8.51 min
  8.60  [Playtest] finished armfrad team 0 at 8.60 min
  8.66  [Playtest] finished armwin team 0 at 8.66 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +26.8 bank 1647/1650, energy +291.0 bank 1541/1553, units 44
  9.26  [Playtest] finished armfrad team 0 at 9.26 min
  9.28  [Playtest] finished armtide team 0 at 9.28 min
  9.50  [Playtest] finished armnanotcplat team 0 at 9.50 min
  9.59  [Playtest] finished armtide team 0 at 9.59 min
  9.60  [Playtest] finished armmex team 0 at 9.60 min
  9.67  [Playtest] finished armfrad team 0 at 9.67 min
  9.81  [Playtest] finished armllt team 0 at 9.81 min
 10.00  [Playtest] finished armtide team 0 at 10.00 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +28.8 bank 1562/1700, energy +323.8 bank 1715/1753, units 55
 10.00  [Playtest] camera requested (6200,11000) height=4200
 10.00  [Playtest] finished armtide team 0 at 10.00 min
 10.01  [Playtest] camera captured name=ta position=(6200,11000) height=4200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (6200, 11000)
 10.11  [Playtest] finished armtide team 0 at 10.11 min
 10.30  [Playtest] finished armmex team 0 at 10.30 min
 10.38  [Playtest] finished armtide team 0 at 10.38 min
 10.43  [Playtest] finished armtide team 0 at 10.43 min
 10.43  [Playtest] finished armtide team 0 at 10.43 min
 10.49  [Playtest] finished armtide team 0 at 10.49 min
 10.62  [Playtest] finished armllt team 0 at 10.62 min
 10.71  [Playtest] finished armtide team 0 at 10.71 min
 10.86  [Playtest] finished armtide team 0 at 10.86 min
 10.88  [Playtest] finished armtide team 0 at 10.88 min
 10.90  [Playtest] finished armtide team 0 at 10.90 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +31.1 bank 704/1750, energy +582.0 bank 2330/2353, units 72
 11.01  [Playtest] finished armmex team 0 at 11.01 min
 11.01  [Playtest] finished armtide team 0 at 11.01 min
 11.02  [Playtest] finished armtide team 0 at 11.02 min
 11.24  [Playtest] finished armtide team 0 at 11.24 min
 11.30  [Playtest] finished armmex team 0 at 11.30 min
 11.32  [Playtest] finished armtide team 0 at 11.32 min
 11.37  [Playtest] finished armtide team 0 at 11.37 min
 11.41  [Playtest] finished armtide team 0 at 11.41 min
 11.41  [Playtest] finished armtide team 0 at 11.41 min
 11.45  [Playtest] finished armllt team 0 at 11.45 min
 11.57  [Playtest] finished armrad team 0 at 11.57 min
 11.58  [Playtest] finished armtide team 0 at 11.58 min
 11.70  [Playtest] finished armtide team 0 at 11.70 min
 11.72  [Playtest] finished armtide team 0 at 11.72 min
 11.76  [Playtest] finished armmex team 0 at 11.76 min
 11.87  [Playtest] finished armtide team 0 at 11.87 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +38.0 bank 75/1900, energy +761.7 bank 2877/2903, units 91
 12.02  [Playtest] finished armmex team 0 at 12.02 min
 12.03  [Playtest] finished armtide team 0 at 12.03 min
 12.05  [Playtest] finished armtide team 0 at 12.05 min
 12.18  [Playtest] finished armtide team 0 at 12.18 min
 12.21  [Playtest] finished armllt team 0 at 12.21 min
 12.33  [Playtest] finished armtide team 0 at 12.33 min
 12.62  [Playtest] finished armtide team 0 at 12.62 min
 12.72  [Playtest] finished armtide team 0 at 12.72 min
 12.93  [Playtest] finished armtide team 0 at 12.93 min
 12.99  [Playtest] finished armmex team 0 at 12.99 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +40.3 bank 844/2000, energy +933.0 bank 3249/3253, units 100
 13.03  [Playtest] finished armtide team 0 at 13.03 min
 13.11  [Playtest] finished armtide team 0 at 13.11 min
 13.19  [Playtest] finished armrad team 0 at 13.19 min
 13.24  [Playtest] finished armtide team 0 at 13.24 min
 13.33  [Playtest] finished armtide team 0 at 13.33 min
 13.41  [Playtest] finished armtide team 0 at 13.41 min
 13.63  [Playtest] finished armtl team 0 at 13.63 min
 13.94  [Playtest] finished armfrad team 0 at 13.94 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +42.6 bank 1136/2000, energy +1005.7 bank 3486/3503, units 110
 14.25  [Playtest] finished armtide team 0 at 14.25 min
 14.56  [Playtest] finished armtide team 0 at 14.56 min
 14.58  [Playtest] finished armtide team 0 at 14.58 min
 14.90  [Playtest] finished armtide team 0 at 14.90 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +42.6 bank 0/2000, energy +1150.6 bank 3703/3703, units 119
 15.19  [Playtest] finished armasy team 0 at 15.19 min
 15.29  [Playtest] finished armtide team 0 at 15.29 min
 15.37  [Playtest] finished armfrad team 0 at 15.37 min
 15.37  [Playtest] finished armtide team 0 at 15.37 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +42.6 bank 0/2200, energy +1224.0 bank 4108/4153, units 124
 16.11  [Playtest] finished armnanotcplat team 0 at 16.11 min
 16.52  [Playtest] finished armtl team 0 at 16.52 min
 16.64  [Playtest] finished armuwmme team 0 at 16.64 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +49.5 bank 2/2750, energy +1199.5 bank 4276/4303, units 127
 17.40  [Playtest] finished armuwmme team 0 at 17.40 min
 17.83  [Playtest] finished armuwmme team 0 at 17.83 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +63.3 bank 192/3850, energy +1468.8 bank 5732/5803, units 133
 18.15  [Playtest] finished armfmkr team 0 at 18.15 min
 18.24  [Playtest] finished armnanotcplat team 0 at 18.24 min
 18.28  [Playtest] finished armfmkr team 0 at 18.28 min
 18.31  [Playtest] finished armfmkr team 0 at 18.31 min
 18.47  [Playtest] finished armfmkr team 0 at 18.47 min
 18.60  [Playtest] finished armnanotcplat team 0 at 18.60 min
 18.67  [Playtest] finished armuwmme team 0 at 18.67 min
 18.86  [Playtest] finished armnanotcplat team 0 at 18.86 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +70.4 bank 45/4400, energy +1476.1 bank 4237/5803, units 142
 19.06  [Playtest] finished armuwmmm team 0 at 19.06 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +77.3 bank 12/4400, energy +1521.2 bank 4545/5803, units 146
 20.00  [Playtest] camera requested (6200,11000) height=4800
 20.01  [Playtest] camera captured name=ta position=(6200,11000) height=4800
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (6200, 11000)
 20.93  [Playtest] finished armuwmmm team 0 at 20.93 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +77.7 bank 11/4400, energy +1527.5 bank 4571/5803, units 147
 21.18  [Playtest] finished armuwfus team 0 at 21.18 min
 21.29  [Playtest] finished armfmkr team 0 at 21.29 min
 21.41  [Playtest] finished armfmkr team 0 at 21.41 min
 21.54  [Playtest] finished armatl team 0 at 21.53 min
 21.63  [Playtest] finished armfmkr team 0 at 21.63 min
 21.65  [Playtest] finished armfmkr team 0 at 21.65 min
 21.77  [Playtest] finished armfmkr team 0 at 21.77 min
 21.82  [Playtest] finished armfmkr team 0 at 21.82 min
 21.88  [Playtest] finished armfmkr team 0 at 21.88 min
 21.93  [Playtest] finished armfmkr team 0 at 21.93 min
 21.97  [Playtest] finished armfmkr team 0 at 21.97 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +84.6 bank 525/4400, energy +2716.2 bank 6666/8303, units 163
 22.32  [Playtest] finished armuwmmm team 0 at 22.32 min
 22.68  [Playtest] finished armnanotcplat team 0 at 22.68 min
 22.86  [Playtest] finished armnanotcplat team 0 at 22.86 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +93.7 bank 1190/4400, energy +2640.0 bank 6948/8300, units 165
 23.33  [Playtest] finished armfmkr team 0 at 23.33 min
 23.36  [Playtest] finished armfmkr team 0 at 23.35 min
 23.56  [Playtest] finished armfmkr team 0 at 23.56 min
 23.65  [Playtest] finished armfmkr team 0 at 23.65 min
 23.84  [Playtest] finished armnanotcplat team 0 at 23.84 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +92.4 bank 1302/4400, energy +2640.0 bank 7284/8300, units 178
 24.17  [Playtest] finished armfmkr team 0 at 24.17 min
 24.43  [Playtest] finished armfmkr team 0 at 24.43 min
 24.50  [Playtest] finished armfmkr team 0 at 24.50 min
 24.72  [Playtest] finished armfmkr team 0 at 24.72 min
 24.77  [Playtest] finished armfmkr team 0 at 24.77 min
 24.92  [Playtest] finished armfmkr team 0 at 24.92 min
 24.99  [Playtest] finished armfmkr team 0 at 24.99 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +84.6 bank 929/4400, energy +2640.0 bank 6804/8300, units 194
 25.18  [Playtest] finished armfmkr team 0 at 25.18 min
 25.22  [Playtest] finished armfmkr team 0 at 25.22 min
 25.30  [Playtest] finished armfmkr team 0 at 25.31 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +87.7 bank 474/4400, energy +2640.0 bank 6728/8300, units 207
 26.01  [Playtest] finished armtl team 0 at 26.01 min
 26.10  [SEA][Layout] berth sea.berth.3 armsy at=6608,9008 facing=2
 26.39  [Playtest] finished armtl team 0 at 26.39 min
 26.58  [Playtest] finished armfrad team 0 at 26.58 min
 26.61  [Playtest] finished armtl team 0 at 26.61 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +91.5 bank 300/4400, energy +2640.0 bank 6828/8300, units 219
 27.27  [Playtest] finished armtl team 0 at 27.27 min
 27.58  [Playtest] finished armrad team 0 at 27.58 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +87.7 bank 47/4400, energy +2640.0 bank 6965/8300, units 227
 29.00  [Playtest] eco team 0 at 29.0 min: metal +90.6 bank 271/4400, energy +2640.0 bank 6816/8300, units 235
 29.00  [Playtest] camera requested (6200,11000) height=4800
 29.01  [Playtest] camera captured name=ta position=(6200,11000) height=4800
 29.01  [Playtest] screenshot at 29.0 min of team 0 at (6200, 11000)
 30.00  [Playtest] eco team 0 at 30.0 min: metal +99.0 bank 143/4400, energy +2640.0 bank 6922/8300, units 243
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(12123) at (4778, 11079) walks to (4744, 11078), 136 from the armmex site (4608, 11072)
  0.08  EXP: approach: armcom(29089) at (7531, 1225) walks to (7560, 1226), 136 from the armmex site (7696, 1232)
  0.22  RESERVE: zone 1 at (6464, 1664) facing 0, 6x6 cells: 36 of 36 held
  0.22  RESERVE: armsy at (6464, 1664) facing 0 (id 1)
  0.22  RESERVE: corridor 2 at (6464, 1952) facing 0, 12x30 cells: 360 of 360 held
  0.22  RESERVE: zone 3 at (6440, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6440, 1544) facing 0 (id 2)
  0.22  RESERVE: zone 4 at (6488, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6488, 1544) facing 0 (id 3)
  0.22  RESERVE: zone 5 at (6536, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6536, 1544) facing 0 (id 4)
  0.22  RESERVE: zone 6 at (6584, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6584, 1544) facing 0 (id 5)
  0.22  RESERVE: zone 7 at (6632, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6632, 1544) facing 0 (id 6)
  0.22  RESERVE: zone 8 at (6440, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6440, 1592) facing 0 (id 7)
  0.22  RESERVE: zone 9 at (6488, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6488, 1592) facing 0 (id 8)
  0.22  RESERVE: zone 10 at (6536, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6536, 1592) facing 0 (id 9)
  0.22  RESERVE: zone 11 at (6584, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6584, 1592) facing 0 (id 10)
  0.22  RESERVE: zone 12 at (6632, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6632, 1592) facing 0 (id 11)
  0.22  RESERVE: zone 3 released
  0.22  RESERVE: zone 4 released
  0.22  RESERVE: zone 5 released
  0.22  RESERVE: zone 6 released
  0.22  RESERVE: zone 7 released
  0.22  RESERVE: zone 8 released
  0.22  RESERVE: zone 9 released
  0.22  RESERVE: zone 10 released
  0.22  RESERVE: zone 11 released
  0.22  RESERVE: zone 12 released
  0.22  RESERVE: zone 13 at (6376, 1560) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6376, 1560) facing 0 (id 12)
  0.22  RESERVE: zone 14 at (6424, 1560) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6424, 1560) facing 0 (id 13)
  0.22  RESERVE: zone 15 at (6472, 1560) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6472, 1560) facing 0 (id 14)
  0.22  RESERVE: zone 16 at (6520, 1560) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6520, 1560) facing 0 (id 15)
  0.22  RESERVE: zone 17 at (6568, 1560) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6568, 1560) facing 0 (id 16)
  0.22  RESERVE: zone 18 at (6376, 1608) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6376, 1608) facing 0 (id 17)
  0.22  RESERVE: zone 13 released
  0.22  RESERVE: zone 14 released
  0.22  RESERVE: zone 15 released
  0.22  RESERVE: zone 16 released
  0.22  RESERVE: zone 17 released
  0.22  RESERVE: zone 18 released
  0.22  RESERVE: zone 19 at (6296, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6296, 1544) facing 0 (id 18)
  0.22  RESERVE: zone 20 at (6344, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6344, 1544) facing 0 (id 19)
  0.22  RESERVE: zone 21 at (6392, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6392, 1544) facing 0 (id 20)
  0.22  RESERVE: zone 22 at (6440, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6440, 1544) facing 0 (id 21)
  0.22  RESERVE: zone 23 at (6488, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6488, 1544) facing 0 (id 22)
  0.22  RESERVE: zone 24 at (6296, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6296, 1592) facing 0 (id 23)
  0.22  RESERVE: zone 25 at (6344, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6344, 1592) facing 0 (id 24)
  0.22  RESERVE: zone 26 at (6392, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6392, 1592) facing 0 (id 25)
  0.22  RESERVE: zone 27 at (6440, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6440, 1592) facing 0 (id 26)
  0.22  RESERVE: zone 28 at (6488, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6488, 1592) facing 0 (id 27)
  0.22  RESERVE: zone 29 at (6296, 1640) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6296, 1640) facing 0 (id 28)
  0.22  RESERVE: zone 30 at (6344, 1640) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6344, 1640) facing 0 (id 29)
  0.22  RESERVE: zone 31 at (6392, 1640) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6392, 1640) facing 0 (id 30)
  0.22  RESERVE: zone 19 released
  0.22  RESERVE: zone 20 released
  0.22  RESERVE: zone 21 released
  0.22  RESERVE: zone 22 released
  0.22  RESERVE: zone 23 released
  0.22  RESERVE: zone 24 released
  0.22  RESERVE: zone 25 released
  0.22  RESERVE: zone 26 released
  0.22  RESERVE: zone 27 released
  0.22  RESERVE: zone 28 released
  0.22  RESERVE: zone 29 released
  0.22  RESERVE: zone 30 released
  0.22  RESERVE: zone 31 released
  0.22  RESERVE: zone 32 at (6232, 1496) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6232, 1496) facing 0 (id 31)
  0.22  RESERVE: zone 33 at (6280, 1496) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6280, 1496) facing 0 (id 32)
  0.22  RESERVE: zone 34 at (6328, 1496) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6328, 1496) facing 0 (id 33)
  0.22  RESERVE: zone 35 at (6376, 1496) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6376, 1496) facing 0 (id 34)
  0.22  RESERVE: zone 36 at (6424, 1496) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6424, 1496) facing 0 (id 35)
  0.22  RESERVE: zone 37 at (6232, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6232, 1544) facing 0 (id 36)
  0.22  RESERVE: zone 38 at (6280, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6280, 1544) facing 0 (id 37)
  0.22  RESERVE: zone 39 at (6328, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6328, 1544) facing 0 (id 38)
  0.22  RESERVE: zone 40 at (6376, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6376, 1544) facing 0 (id 39)
  0.22  RESERVE: zone 41 at (6424, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6424, 1544) facing 0 (id 40)
  0.22  RESERVE: zone 42 at (6232, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6232, 1592) facing 0 (id 41)
  0.22  RESERVE: zone 43 at (6280, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6280, 1592) facing 0 (id 42)
  0.22  RESERVE: zone 44 at (6328, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6328, 1592) facing 0 (id 43)
  0.22  RESERVE: zone 45 at (6376, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6376, 1592) facing 0 (id 44)
```
