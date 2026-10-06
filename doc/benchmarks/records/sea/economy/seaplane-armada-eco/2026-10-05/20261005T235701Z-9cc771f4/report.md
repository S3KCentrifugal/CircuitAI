# Playtest report: FAIL

- Verdict: **FAIL** (expected lines never seen: platform, aircraft, support)
- Game time reached: 30.0 min (frame 54000); wall 233 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (aff90f713fc9746a); AI BARbTest/test; staged 2026-10-05T20:52:59
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: seaplane-natural.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada-eco\supreme\20261005T235259Z-fc7bec7f\runs\20261005T235701Z-9cc771f4\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `mex` | seen at 3.0 min | `[t=00:00:58.394883][f=0005462] [SeaTransition] PASS mex completed by first construction ship` |
| expect `platform` | **missing** (by 30 min) | |
| expect `aircraft` | **missing** (by 30 min) | |
| expect `support` | **missing** (by 30 min) | |
| forbid `errors` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada-eco\supreme\20261005T235259Z-fc7bec7f\runs\20261005T235701Z-9cc771f4\screen_2026-10-05_23-54-20-196.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada-eco\supreme\20261005T235259Z-fc7bec7f\runs\20261005T235701Z-9cc771f4\screen_2026-10-05_23-54-51-221.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada-eco\supreme\20261005T235259Z-fc7bec7f\runs\20261005T235701Z-9cc771f4\screen_2026-10-05_23-55-52-199.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada-eco\supreme\20261005T235259Z-fc7bec7f\runs\20261005T235701Z-9cc771f4\screen_2026-10-05_23-56-52-831.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 10, 4 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 30
  0.00  [Playtest] speed 10
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 30
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.20  [Playtest] finished armmex team 0 at 0.20 min
  0.22  [Team][Roster] first mex 8528 at 4608,11072
  0.22  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4764|11076|0|7|1|4608|11072
  0.40  [Playtest] finished armmex team 0 at 0.40 min
  0.51  [Playtest] finished armwin team 0 at 0.51 min
  0.62  [Playtest] finished armwin team 0 at 0.62 min
  0.79  [Playtest] finished armsolar team 0 at 0.79 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 814/1100, energy +65.5 bank 1051/1051, units 7
  1.00  [Playtest] finished armsolar team 0 at 1.00 min
  1.74  [Playtest] finished armsy team 0 at 1.74 min
  1.82  [SEA][Layout] berth sea.berth.0 armasy at=6080,10048 facing=2
  1.93  [SEA][Layout] berth sea.berth.1 armplat at=6272,9936 facing=2
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.6 bank 538/1200, energy +106.1 bank 352/1251, units 10
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.6 bank 1/1200, energy +121.9 bank 92/1301, units 15
  3.03  [Playtest] finished armmex team 0 at 3.03 min
  3.50  [Playtest] finished armmex team 0 at 3.50 min
  3.60  [Playtest] finished armmex team 0 at 3.60 min
  3.94  [Playtest] finished armmex team 0 at 3.94 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +15.5 bank 1/1400, energy +112.4 bank 846/1301, units 19
  4.17  [Playtest] finished armmex team 0 at 4.17 min
  4.23  [Playtest] finished armmex team 0 at 4.23 min
  4.44  [Playtest] finished armtide team 0 at 4.44 min
  4.53  [Playtest] finished armmex team 0 at 4.53 min
  4.75  [Playtest] finished armtide team 0 at 4.75 min
  4.92  [Playtest] finished armmex team 0 at 4.93 min
  4.95  [Playtest] finished armmex team 0 at 4.95 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +26.5 bank 361/1650, energy +153.5 bank 435/1401, units 25
  5.00  [Playtest] camera requested (6200,11000) height=3800
  5.00  [Playtest] camera captured name=ta position=(6200,11000) height=3800
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (6200, 11000)
  5.32  [Playtest] finished armmex team 0 at 5.32 min
  5.43  [Playtest] finished armtide team 0 at 5.43 min
  5.66  [Playtest] finished armmex team 0 at 5.66 min
  5.69  [Playtest] finished armtide team 0 at 5.69 min
  5.84  [Playtest] finished armllt team 0 at 5.84 min
  5.94  [Playtest] finished armrad team 0 at 5.94 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +31.1 bank 1239/1750, energy +205.9 bank 1493/1501, units 35
  6.17  [Playtest] finished armmex team 0 at 6.18 min
  6.62  [Playtest] finished armmex team 0 at 6.62 min
  6.65  [Playtest] finished armtide team 0 at 6.65 min
  6.80  [Playtest] finished armllt team 0 at 6.80 min
  6.95  [Playtest] finished armnanotcplat team 0 at 6.95 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +35.7 bank 1847/1850, energy +201.9 bank 272/1551, units 41
  7.02  [Playtest] finished armwin team 0 at 7.02 min
  7.03  [Playtest] finished armtide team 0 at 7.03 min
  7.13  [Playtest] finished armwin team 0 at 7.13 min
  7.26  [Playtest] finished armtide team 0 at 7.26 min
  7.31  [Playtest] finished armwin team 0 at 7.31 min
  7.49  [Playtest] finished armtide team 0 at 7.49 min
  7.71  [Playtest] finished armtide team 0 at 7.71 min
  7.89  [Playtest] finished armllt team 0 at 7.89 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +35.7 bank 1845/1850, energy +367.6 bank 1722/1752, units 50
  8.12  [Playtest] finished armrad team 0 at 8.12 min
  8.23  [Playtest] finished armfmkr team 0 at 8.23 min
  8.50  [Playtest] finished armtide team 0 at 8.50 min
  8.75  [Playtest] finished armnanotcplat team 0 at 8.75 min
  8.80  [Playtest] finished armmstor team 0 at 8.80 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +35.7 bank 1441/4850, energy +386.5 bank 867/1802, units 58
  9.03  [Playtest] finished armtide team 0 at 9.03 min
  9.16  [Playtest] finished armtide team 0 at 9.16 min
  9.56  [Playtest] finished armmex team 0 at 9.56 min
  9.84  [Playtest] finished armfmkr team 0 at 9.84 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +38.3 bank 1381/4900, energy +414.3 bank 1766/1902, units 66
 10.00  [Playtest] camera requested (6200,11000) height=4200
 10.01  [Playtest] camera captured name=ta position=(6200,11000) height=4200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (6200, 11000)
 10.03  [Playtest] finished armtide team 0 at 10.03 min
 10.29  [Playtest] finished armestor team 0 at 10.29 min
 10.42  [Playtest] finished armnanotcplat team 0 at 10.42 min
 10.68  [Playtest] finished armtide team 0 at 10.68 min
 10.70  [Playtest] finished armtide team 0 at 10.70 min
 10.88  [Playtest] finished armtide team 0 at 10.88 min
 10.96  [Playtest] finished armtide team 0 at 10.96 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +38.0 bank 840/4900, energy +504.5 bank 2030/8152, units 76
 11.01  [Playtest] finished armwin team 0 at 11.01 min
 11.08  [Playtest] finished armtide team 0 at 11.08 min
 11.35  [Playtest] finished armtide team 0 at 11.35 min
 11.47  [Playtest] finished armtide team 0 at 11.47 min
 11.62  [Playtest] finished armtl team 0 at 11.62 min
 11.77  [Playtest] finished armtide team 0 at 11.77 min
 11.85  [Playtest] finished armtide team 0 at 11.85 min
 11.93  [Playtest] finished armfrad team 0 at 11.93 min
 11.96  [Playtest] finished armtide team 0 at 11.96 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +40.0 bank 45/4900, energy +676.7 bank 8433/8453, units 89
 12.27  [Playtest] finished armmex team 0 at 12.27 min
 12.37  [Playtest] finished armtide team 0 at 12.37 min
 12.45  [Playtest] finished armllt team 0 at 12.45 min
 12.60  [Playtest] finished armrad team 0 at 12.60 min
 12.89  [Playtest] finished armtide team 0 at 12.89 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +42.3 bank 243/4950, energy +722.3 bank 8519/8553, units 99
 13.01  [Playtest] finished armfmkr team 0 at 13.01 min
 13.13  [Playtest] finished armtide team 0 at 13.13 min
 13.30  [Playtest] finished armtide team 0 at 13.30 min
 13.41  [Playtest] finished armtide team 0 at 13.41 min
 13.76  [Playtest] finished armtide team 0 at 13.76 min
 13.83  [Playtest] finished armfmkr team 0 at 13.83 min
 13.88  [Playtest] finished armtide team 0 at 13.88 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +44.3 bank 48/4950, energy +771.6 bank 8738/8803, units 109
 14.56  [Playtest] finished armtide team 0 at 14.56 min
 14.59  [Playtest] finished armfmkr team 0 at 14.59 min
 14.69  [Playtest] finished armfmkr team 0 at 14.69 min
 14.76  [Playtest] finished armfmkr team 0 at 14.76 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +46.1 bank 144/4950, energy +799.9 bank 6920/8853, units 119
 15.16  [Playtest] finished armfmkr team 0 at 15.16 min
 15.44  [Playtest] finished armfmkr team 0 at 15.44 min
 15.46  [Playtest] finished armtide team 0 at 15.46 min
 15.68  [Playtest] finished armfmkr team 0 at 15.68 min
 15.74  [Playtest] finished armtide team 0 at 15.74 min
 15.84  [Playtest] finished armtide team 0 at 15.84 min
 15.96  [Playtest] finished armtide team 0 at 15.95 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +45.8 bank 392/4950, energy +932.6 bank 6893/9053, units 129
 16.00  [Playtest] finished armfmkr team 0 at 16.00 min
 16.22  [Playtest] finished armtide team 0 at 16.22 min
 16.33  [Playtest] finished armllt team 0 at 16.33 min
 16.61  [Playtest] finished armtide team 0 at 16.61 min
 16.94  [Playtest] finished armtl team 0 at 16.94 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +48.2 bank 46/4950, energy +939.6 bank 7137/9153, units 138
 17.00  [Playtest] finished armllt team 0 at 17.00 min
 17.05  [Playtest] finished armtide team 0 at 17.05 min
 17.11  [Playtest] finished armrad team 0 at 17.11 min
 17.38  [Playtest] finished armtide team 0 at 17.38 min
 17.55  [Playtest] finished armtide team 0 at 17.55 min
 17.75  [Playtest] finished armllt team 0 at 17.75 min
 17.85  [Playtest] finished armrad team 0 at 17.85 min
 17.90  [Playtest] finished armmex team 0 at 17.90 min
 17.92  [Playtest] finished armtide team 0 at 17.92 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +51.5 bank 165/5000, energy +1018.2 bank 7450/9353, units 152
 18.04  [Playtest] finished armtide team 0 at 18.04 min
 18.25  [Playtest] finished armllt team 0 at 18.25 min
 18.41  [Playtest] finished armtl team 0 at 18.41 min
 18.42  [Playtest] finished armtide team 0 at 18.42 min
 18.68  [Playtest] finished armfrad team 0 at 18.68 min
 18.85  [Playtest] finished armtide team 0 at 18.85 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +53.6 bank 329/5000, energy +1058.1 bank 7667/9503, units 163
 19.17  [Playtest] finished armtide team 0 at 19.17 min
 19.33  [Playtest] finished armmex team 0 at 19.33 min
 19.50  [Playtest] finished armtide team 0 at 19.50 min
 19.82  [Playtest] finished armtide team 0 at 19.82 min
 19.86  [Playtest] finished armtl team 0 at 19.86 min
 19.99  [Playtest] finished armtide team 0 at 19.99 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +55.9 bank 278/5050, energy +1185.0 bank 9408/9703, units 172
 20.00  [Playtest] camera requested (6200,11000) height=4800
 20.01  [Playtest] camera captured name=ta position=(6200,11000) height=4800
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (6200, 11000)
 20.67  [Playtest] finished armfmkr team 0 at 20.67 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +55.8 bank 447/5050, energy +1168.4 bank 7588/9703, units 178
 21.81  [Playtest] finished armtl team 0 at 21.81 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +59.7 bank 654/5050, energy +1181.6 bank 8331/9703, units 187
 22.28  [Playtest] finished armtide team 0 at 22.28 min
 22.84  [Playtest] finished armtide team 0 at 22.84 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +56.9 bank 843/5050, energy +1219.2 bank 9224/9803, units 192
 23.38  [Playtest] finished armnanotcplat team 0 at 23.38 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +52.9 bank 598/5050, energy +1234.3 bank 7623/9803, units 199
 24.11  [Playtest] finished armtide team 0 at 24.11 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +56.9 bank 239/5050, energy +1268.8 bank 8887/9853, units 207
 25.89  [Playtest] finished armrad team 0 at 25.89 min
 25.92  [Playtest] finished armfrad team 0 at 25.92 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +55.9 bank 42/5050, energy +1267.0 bank 7740/9853, units 215
 26.21  [Playtest] finished armtl team 0 at 26.21 min
 26.89  [Playtest] finished armtl team 0 at 26.89 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +56.9 bank 99/5050, energy +1259.3 bank 7682/9853, units 222
 27.63  [Playtest] finished armtl team 0 at 27.63 min
 27.93  [Playtest] finished armfrad team 0 at 27.93 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +56.9 bank 318/5050, energy +1189.2 bank 8461/9853, units 231
 28.20  [Playtest] finished armtide team 0 at 28.20 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +56.4 bank 42/5050, energy +1281.4 bank 7808/9903, units 235
 29.00  [Playtest] camera requested (6200,11000) height=4800
 29.02  [Playtest] camera captured name=ta position=(6200,11000) height=4800
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (6200, 11000)
 29.68  [Playtest] finished armtl team 0 at 29.68 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +56.6 bank 100/5050, energy +1276.2 bank 8225/9903, units 242
```

## Native lines (all AIs, first 120)

```
  1.75  RESERVE: zone 1 at (5768, 10872) facing 2, 3x3 cells: 9 of 9 held
  1.75  RESERVE: armnanotcplat at (5768, 10872) facing 2 (id 1)
  1.75  RESERVE: zone 1 released
  1.75  RESERVE: corridor 2 at (5808, 10416) facing 2, 12x30 cells: 221 of 360 held
  1.75  RESERVE: zone 3 at (5936, 11488) facing 2, 40x40 cells: 1600 of 1600 held
  1.75  RESERVE: zone 3 released
  1.75  RESERVE: zone 4 at (6064, 11488) facing 2, 40x40 cells: 1600 of 1600 held
  1.75  RESERVE: zone 4 released
  1.75  RESERVE: zone 5 at (6192, 11488) facing 2, 40x40 cells: 1600 of 1600 held
  1.75  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6192, 11392) facing 2: 9 of 16 slots (group 3, held, zone)
  1.75  RESERVE: zone 5 released
  1.77  RESERVE: zone 6 at (5832, 10824) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5832, 10824) facing 2 (id 11)
  1.77  RESERVE: zone 7 at (5784, 10824) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5784, 10824) facing 2 (id 12)
  1.77  RESERVE: zone 6 released
  1.77  RESERVE: zone 7 released
  1.77  RESERVE: zone 8 at (5912, 10808) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5912, 10808) facing 2 (id 13)
  1.77  RESERVE: zone 9 at (5864, 10808) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5864, 10808) facing 2 (id 14)
  1.77  RESERVE: zone 10 at (5816, 10808) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5816, 10808) facing 2 (id 15)
  1.77  RESERVE: zone 11 at (5768, 10808) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5768, 10808) facing 2 (id 16)
  1.77  RESERVE: zone 8 released
  1.77  RESERVE: zone 9 released
  1.77  RESERVE: zone 10 released
  1.77  RESERVE: zone 11 released
  1.77  RESERVE: zone 12 at (5976, 10824) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5976, 10824) facing 2 (id 17)
  1.77  RESERVE: zone 13 at (5928, 10824) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5928, 10824) facing 2 (id 18)
  1.77  RESERVE: zone 14 at (5880, 10824) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5880, 10824) facing 2 (id 19)
  1.77  RESERVE: zone 15 at (5832, 10824) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5832, 10824) facing 2 (id 20)
  1.77  RESERVE: zone 16 at (5784, 10824) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5784, 10824) facing 2 (id 21)
  1.77  RESERVE: zone 17 at (5976, 10776) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5976, 10776) facing 2 (id 22)
  1.77  RESERVE: zone 12 released
  1.77  RESERVE: zone 13 released
  1.77  RESERVE: zone 14 released
  1.77  RESERVE: zone 15 released
  1.77  RESERVE: zone 16 released
  1.77  RESERVE: zone 17 released
  1.77  RESERVE: zone 18 at (6040, 10872) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (6040, 10872) facing 2 (id 23)
  1.77  RESERVE: zone 19 at (5992, 10872) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5992, 10872) facing 2 (id 24)
  1.77  RESERVE: zone 20 at (5944, 10872) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5944, 10872) facing 2 (id 25)
  1.77  RESERVE: zone 21 at (5896, 10872) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5896, 10872) facing 2 (id 26)
  1.77  RESERVE: zone 22 at (5848, 10872) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5848, 10872) facing 2 (id 27)
  1.77  RESERVE: zone 23 at (6040, 10824) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (6040, 10824) facing 2 (id 28)
  1.77  RESERVE: zone 24 at (5992, 10824) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5992, 10824) facing 2 (id 29)
  1.77  RESERVE: zone 25 at (5944, 10824) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5944, 10824) facing 2 (id 30)
  1.77  RESERVE: zone 26 at (5896, 10824) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5896, 10824) facing 2 (id 31)
  1.77  RESERVE: zone 27 at (5848, 10824) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5848, 10824) facing 2 (id 32)
  1.77  RESERVE: zone 28 at (6040, 10776) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (6040, 10776) facing 2 (id 33)
  1.77  RESERVE: zone 29 at (5992, 10776) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5992, 10776) facing 2 (id 34)
  1.77  RESERVE: zone 18 released
  1.77  RESERVE: zone 19 released
  1.77  RESERVE: zone 20 released
  1.77  RESERVE: zone 21 released
  1.77  RESERVE: zone 22 released
  1.77  RESERVE: zone 23 released
  1.77  RESERVE: zone 24 released
  1.77  RESERVE: zone 25 released
  1.77  RESERVE: zone 26 released
  1.77  RESERVE: zone 27 released
  1.77  RESERVE: zone 28 released
  1.77  RESERVE: zone 29 released
  1.77  RESERVE: zone 30 at (6088, 10920) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (6088, 10920) facing 2 (id 35)
  1.77  RESERVE: zone 31 at (6040, 10920) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (6040, 10920) facing 2 (id 36)
  1.77  RESERVE: zone 32 at (5992, 10920) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5992, 10920) facing 2 (id 37)
  1.77  RESERVE: zone 33 at (5944, 10920) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5944, 10920) facing 2 (id 38)
  1.77  RESERVE: zone 34 at (5896, 10920) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5896, 10920) facing 2 (id 39)
  1.77  RESERVE: zone 35 at (6088, 10872) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (6088, 10872) facing 2 (id 40)
  1.77  RESERVE: zone 36 at (6040, 10872) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (6040, 10872) facing 2 (id 41)
  1.77  RESERVE: zone 37 at (5992, 10872) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5992, 10872) facing 2 (id 42)
  1.77  RESERVE: zone 38 at (5944, 10872) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5944, 10872) facing 2 (id 43)
  1.77  RESERVE: zone 39 at (5896, 10872) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5896, 10872) facing 2 (id 44)
  1.77  RESERVE: zone 40 at (6088, 10824) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (6088, 10824) facing 2 (id 45)
  1.77  RESERVE: zone 41 at (6040, 10824) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (6040, 10824) facing 2 (id 46)
  1.77  RESERVE: zone 42 at (5992, 10824) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5992, 10824) facing 2 (id 47)
  1.77  RESERVE: zone 43 at (5944, 10824) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5944, 10824) facing 2 (id 48)
  1.77  RESERVE: zone 44 at (5896, 10824) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5896, 10824) facing 2 (id 49)
  1.77  RESERVE: zone 45 at (6088, 10776) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (6088, 10776) facing 2 (id 50)
  1.77  RESERVE: zone 46 at (6040, 10776) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (6040, 10776) facing 2 (id 51)
  1.77  RESERVE: zone 47 at (5992, 10776) facing 2, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armnanotcplat at (5992, 10776) facing 2 (id 52)
  1.77  RESERVE: zone 30 released
```
