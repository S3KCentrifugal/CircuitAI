# Playtest report: PASS

- Verdict: **PASS** (reached 25 min)
- Game time reached: 25.0 min (frame 45000); wall 171 s
- DLL: build-theatres\d192-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T15:19:38
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-natural\supreme\20261004T181938Z-3534e6ed\runs\20261004T182232Z-2d772291\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:35.586854][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.4 min | `[t=00:00:49.163533][f=0002570] [SeaWatch] finished frame=2570 id=26482 def=armsy builder=28578` |
| expect `first-ship-exit` | seen at 2.5 min | `[t=00:00:53.455951][f=0004500] [SeaWatch] egress id=19532 yard=26482 seconds=50.1 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-natural\supreme\20261004T181938Z-3534e6ed\runs\20261004T182232Z-2d772291\screen_2026-10-04_18-20-46-347.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-natural\supreme\20261004T181938Z-3534e6ed\runs\20261004T182232Z-2d772291\screen_2026-10-04_18-21-08-396.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-natural\supreme\20261004T181938Z-3534e6ed\runs\20261004T182232Z-2d772291\screen_2026-10-04_18-21-56-568.png

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
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.19  [Playtest] finished armmex team 0 at 0.19 min
  0.20  [Team][Roster] first mex 6887 at 4608,11072
  0.20  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4775|11078|0|7|1|4608|11072
  0.38  [Playtest] finished armmex team 0 at 0.38 min
  0.49  [Playtest] finished armwin team 0 at 0.49 min
  0.60  [Playtest] finished armwin team 0 at 0.60 min
  0.71  [Playtest] finished armwin team 0 at 0.71 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 1085/1100, energy +86.2 bank 1001/1001, units 6
  1.43  [Playtest] finished armsy team 0 at 1.43 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.6 bank 582/1200, energy +93.7 bank 8/1151, units 9
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.6 bank 163/1200, energy +100.4 bank 75/1201, units 12
  3.13  [Playtest] finished armtide team 0 at 3.13 min
  3.49  [Playtest] finished armmex team 0 at 3.49 min
  3.92  [Playtest] finished armmex team 0 at 3.92 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.9 bank 1/1300, energy +112.4 bank 1128/1251, units 16
  4.24  [Playtest] finished armmex team 0 at 4.24 min
  4.58  [Playtest] finished armmex team 0 at 4.58 min
  4.77  [Playtest] finished armtide team 0 at 4.77 min
  4.99  [Playtest] finished armmex team 0 at 4.99 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +15.0 bank 13/1450, energy +142.6 bank 1039/1301, units 21
  5.00  [Playtest] target team 0 at (4814, 11077) from its start position
  5.00  [Playtest] camera requested (4814,11077) height=2200
  5.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (4814, 11077)
  5.18  [Playtest] finished armtide team 0 at 5.18 min
  5.40  [Playtest] finished armmex team 0 at 5.40 min
  5.50  [Playtest] finished armtide team 0 at 5.50 min
  5.71  [Playtest] finished armmex team 0 at 5.71 min
  5.80  [Playtest] finished armrad team 0 at 5.80 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +21.9 bank 106/1550, energy +185.0 bank 1347/1401, units 27
  6.07  [Playtest] finished armmex team 0 at 6.07 min
  6.24  [Playtest] finished armllt team 0 at 6.24 min
  6.55  [Playtest] finished armtide team 0 at 6.55 min
  6.70  [Playtest] finished armmex team 0 at 6.70 min
  6.76  [Playtest] finished armtide team 0 at 6.76 min
  6.87  [Playtest] finished armllt team 0 at 6.87 min
  6.96  [Playtest] finished armtide team 0 at 6.96 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +26.5 bank 461/1650, energy +254.8 bank 1598/1601, units 34
  7.32  [Playtest] finished armfmkr team 0 at 7.32 min
  7.53  [Playtest] finished armfmkr team 0 at 7.53 min
  7.98  [Playtest] finished armmex team 0 at 7.98 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +27.0 bank 1252/1700, energy +243.7 bank 1261/1601, units 39
  8.02  [Playtest] finished armtide team 0 at 8.02 min
  8.33  [Playtest] finished armtide team 0 at 8.33 min
  8.56  [Playtest] finished armmex team 0 at 8.56 min
  8.74  [Playtest] finished armtide team 0 at 8.74 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +33.1 bank 1749/1750, energy +280.0 bank 1610/1801, units 44
  9.12  [Playtest] finished armtide team 0 at 9.12 min
  9.27  [Playtest] finished armmex team 0 at 9.27 min
  9.61  [Playtest] finished armtide team 0 at 9.61 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +35.4 bank 1798/1800, energy +372.8 bank 1795/1951, units 51
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 10.07  [Playtest] finished armmex team 0 at 10.07 min
 10.09  [Playtest] finished armtide team 0 at 10.09 min
 10.19  [Playtest] finished armnanotcplat team 0 at 10.19 min
 10.31  [Playtest] finished armtide team 0 at 10.31 min
 10.66  [Playtest] finished armtide team 0 at 10.66 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +37.7 bank 1846/1850, energy +425.0 bank 1559/2101, units 56
 11.10  [Playtest] finished armfmkr team 0 at 11.10 min
 11.29  [Playtest] finished armtide team 0 at 11.29 min
 11.39  [Playtest] finished armmex team 0 at 11.39 min
 11.54  [Playtest] finished armtide team 0 at 11.54 min
 11.80  [Playtest] finished armtide team 0 at 11.80 min
 11.82  [Playtest] finished armnanotcplat team 0 at 11.82 min
 11.97  [Playtest] finished armmstor team 0 at 11.97 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +41.0 bank 1674/4900, energy +506.6 bank 2001/2301, units 67
 12.30  [Playtest] finished armtide team 0 at 12.30 min
 12.39  [Playtest] finished armestor team 0 at 12.39 min
 12.56  [Playtest] finished armtl team 0 at 12.56 min
 12.73  [Playtest] finished armtide team 0 at 12.73 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +41.0 bank 2975/4900, energy +549.0 bank 8394/8401, units 73
 13.11  [Playtest] finished armtl team 0 at 13.11 min
 13.14  [Playtest] finished armfmkr team 0 at 13.14 min
 13.27  [Playtest] finished armtl team 0 at 13.27 min
 13.62  [Playtest] finished armfmkr team 0 at 13.62 min
 13.82  [Playtest] finished armtide team 0 at 13.82 min
 13.86  [Playtest] finished armtl team 0 at 13.86 min
 13.89  [Playtest] finished armfrad team 0 at 13.89 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +41.1 bank 4392/4900, energy +569.7 bank 6437/8451, units 81
 14.22  [Playtest] finished armnanotcplat team 0 at 14.23 min
 14.24  [Playtest] finished armfmkr team 0 at 14.24 min
 14.31  [Playtest] finished armtide team 0 at 14.31 min
 14.94  [Playtest] finished armnanotcplat team 0 at 14.94 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +38.0 bank 4382/4900, energy +588.7 bank 6394/8501, units 89
 15.43  [Playtest] finished armllt team 0 at 15.43 min
 15.60  [Playtest] finished armmex team 0 at 15.60 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +46.8 bank 4175/4950, energy +591.2 bank 7274/8501, units 99
 16.07  [Playtest] finished armtide team 0 at 16.07 min
 16.17  [Playtest] finished armtl team 0 at 16.17 min
 16.39  [Playtest] finished armtide team 0 at 16.39 min
 16.43  [Playtest] finished armtide team 0 at 16.43 min
 16.48  [Playtest] finished armfrad team 0 at 16.48 min
 16.50  [Playtest] finished armmex team 0 at 16.50 min
 16.80  [Playtest] finished armfrad team 0 at 16.80 min
 16.81  [Playtest] finished armtide team 0 at 16.81 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +45.7 bank 3973/5000, energy +672.1 bank 6452/8701, units 112
 17.15  [Playtest] finished armtide team 0 at 17.15 min
 17.47  [Playtest] finished armtl team 0 at 17.47 min
 17.52  [Playtest] finished armtide team 0 at 17.52 min
 17.87  [Playtest] finished armtide team 0 at 17.87 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +48.6 bank 4144/5000, energy +738.0 bank 7801/8851, units 120
 18.11  [Playtest] finished armmex team 0 at 18.11 min
 18.23  [Playtest] finished armtide team 0 at 18.23 min
 18.32  [Playtest] finished armllt team 0 at 18.32 min
 18.32  [Playtest] finished armfmkr team 0 at 18.32 min
 18.50  [Playtest] finished armrad team 0 at 18.50 min
 18.57  [Playtest] finished armtide team 0 at 18.57 min
 18.92  [Playtest] finished armtide team 0 at 18.92 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +51.9 bank 4330/5050, energy +795.7 bank 6872/9001, units 137
 19.22  [Playtest] finished armfmkr team 0 at 19.22 min
 19.28  [Playtest] finished armtide team 0 at 19.28 min
 19.37  [Playtest] finished armfmkr team 0 at 19.37 min
 19.56  [Playtest] finished armllt team 0 at 19.56 min
 19.64  [Playtest] finished armtide team 0 at 19.65 min
 20.00  [Playtest] finished armnanotcplat team 0 at 20.00 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +44.9 bank 3952/5050, energy +842.9 bank 6340/9101, units 147
 20.00  [Playtest] camera requested (4814,11077) height=2200
 20.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (4814, 11077)
 20.02  [Playtest] finished armtide team 0 at 20.02 min
 20.02  [Playtest] finished armrad team 0 at 20.02 min
 20.39  [Playtest] finished armtide team 0 at 20.40 min
 20.56  [Playtest] finished armrad team 0 at 20.56 min
 20.75  [Playtest] finished armtide team 0 at 20.75 min
 20.76  [Playtest] finished armfmkr team 0 at 20.76 min
 20.93  [Playtest] finished armllt team 0 at 20.93 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +48.3 bank 4441/5050, energy +854.7 bank 6894/9251, units 164
 21.00  [Playtest] finished armnanotcplat team 0 at 21.00 min
 21.09  [Playtest] finished armnanotcplat team 0 at 21.09 min
 21.15  [Playtest] finished armfmkr team 0 at 21.15 min
 21.20  [Playtest] finished armnanotcplat team 0 at 21.20 min
 21.25  [Playtest] finished armsolar team 0 at 21.25 min
 21.61  [Playtest] finished armtide team 0 at 21.61 min
 21.85  [Playtest] finished armtide team 0 at 21.85 min
 21.92  [Playtest] finished armrad team 0 at 21.92 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +58.7 bank 4120/5050, energy +960.8 bank 7822/9401, units 182
 22.13  [Playtest] finished armtide team 0 at 22.13 min
 22.51  [Playtest] finished armtide team 0 at 22.51 min
 22.77  [Playtest] finished armtide team 0 at 22.77 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +55.9 bank 4124/5050, energy +1022.4 bank 8501/9551, units 200
 23.01  [Playtest] finished armtide team 0 at 23.01 min
 23.38  [Playtest] finished armtide team 0 at 23.38 min
 23.50  [Playtest] finished armnanotcplat team 0 at 23.50 min
 23.66  [Playtest] finished armfmkr team 0 at 23.66 min
 23.74  [Playtest] finished armtide team 0 at 23.74 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +56.9 bank 3949/5050, energy +1051.8 bank 7121/9701, units 214
 24.10  [Playtest] finished armtide team 0 at 24.10 min
 24.12  [Playtest] finished armfmkr team 0 at 24.12 min
 24.40  [Playtest] finished armtide team 0 at 24.40 min
 24.68  [Playtest] finished armtide team 0 at 24.68 min
 24.81  [Playtest] finished armfmkr team 0 at 24.81 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +58.9 bank 4258/5050, energy +1115.9 bank 8263/9851, units 221
```

## Native lines (all AIs, first 120)

```
  1.43  RESERVE: zone 1 at (5800, 10904) facing 2, 3x3 cells: 9 of 9 held
  1.43  RESERVE: armnanotcplat at (5800, 10904) facing 2 (id 1)
  1.43  RESERVE: zone 1 released
  1.43  RESERVE: corridor 2 at (5840, 10448) facing 2, 12x30 cells: 210 of 360 held
  1.43  RESERVE: zone 3 at (5968, 11520) facing 2, 40x40 cells: 1600 of 1600 held
  1.43  RESERVE: zone 3 released
  1.43  RESERVE: zone 4 at (6096, 11520) facing 2, 40x40 cells: 1600 of 1600 held
  1.43  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6096, 11424) facing 2: 2 of 16 slots (group 2, held, zone)
  1.43  RESERVE: zone 4 released
  1.43  RESERVE: zone 5 at (6224, 11520) facing 2, 40x40 cells: 1600 of 1600 held
  1.43  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6224, 11424) facing 2: 10 of 16 slots (group 3, held, zone)
  1.43  RESERVE: zone 5 released
  1.45  RESERVE: zone 6 at (5864, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (5864, 10856) facing 2 (id 14)
  1.45  RESERVE: zone 7 at (5816, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (5816, 10856) facing 2 (id 15)
  1.45  RESERVE: zone 8 at (5768, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (5768, 10856) facing 2 (id 16)
  1.45  RESERVE: zone 6 released
  1.45  RESERVE: zone 7 released
  1.45  RESERVE: zone 8 released
  1.45  RESERVE: zone 9 at (5944, 10840) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (5944, 10840) facing 2 (id 17)
  1.45  RESERVE: zone 10 at (5896, 10840) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (5896, 10840) facing 2 (id 18)
  1.45  RESERVE: zone 11 at (5848, 10840) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (5848, 10840) facing 2 (id 19)
  1.45  RESERVE: zone 12 at (5800, 10840) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (5800, 10840) facing 2 (id 20)
  1.45  RESERVE: zone 9 released
  1.45  RESERVE: zone 10 released
  1.45  RESERVE: zone 11 released
  1.45  RESERVE: zone 12 released
  1.45  RESERVE: zone 13 at (6008, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6008, 10856) facing 2 (id 21)
  1.45  RESERVE: zone 14 at (5960, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (5960, 10856) facing 2 (id 22)
  1.45  RESERVE: zone 15 at (5912, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (5912, 10856) facing 2 (id 23)
  1.45  RESERVE: zone 16 at (5864, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (5864, 10856) facing 2 (id 24)
  1.45  RESERVE: zone 17 at (5816, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (5816, 10856) facing 2 (id 25)
  1.45  RESERVE: zone 18 at (6008, 10808) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6008, 10808) facing 2 (id 26)
  1.45  RESERVE: zone 13 released
  1.45  RESERVE: zone 14 released
  1.45  RESERVE: zone 15 released
  1.45  RESERVE: zone 16 released
  1.45  RESERVE: zone 17 released
  1.45  RESERVE: zone 18 released
  1.45  RESERVE: zone 19 at (6072, 10904) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6072, 10904) facing 2 (id 27)
  1.45  RESERVE: zone 20 at (6024, 10904) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6024, 10904) facing 2 (id 28)
  1.45  RESERVE: zone 21 at (5976, 10904) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (5976, 10904) facing 2 (id 29)
  1.45  RESERVE: zone 22 at (5928, 10904) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (5928, 10904) facing 2 (id 30)
  1.45  RESERVE: zone 23 at (5880, 10904) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (5880, 10904) facing 2 (id 31)
  1.45  RESERVE: zone 24 at (6072, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6072, 10856) facing 2 (id 32)
  1.45  RESERVE: zone 25 at (6024, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6024, 10856) facing 2 (id 33)
  1.45  RESERVE: zone 26 at (5976, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (5976, 10856) facing 2 (id 34)
  1.45  RESERVE: zone 27 at (5928, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (5928, 10856) facing 2 (id 35)
  1.45  RESERVE: zone 28 at (5880, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (5880, 10856) facing 2 (id 36)
  1.45  RESERVE: zone 29 at (6072, 10808) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6072, 10808) facing 2 (id 37)
  1.45  RESERVE: zone 30 at (6024, 10808) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6024, 10808) facing 2 (id 38)
  1.45  RESERVE: zone 19 released
  1.45  RESERVE: zone 20 released
  1.45  RESERVE: zone 21 released
  1.45  RESERVE: zone 22 released
  1.45  RESERVE: zone 23 released
  1.45  RESERVE: zone 24 released
  1.45  RESERVE: zone 25 released
  1.45  RESERVE: zone 26 released
  1.45  RESERVE: zone 27 released
  1.45  RESERVE: zone 28 released
  1.45  RESERVE: zone 29 released
  1.45  RESERVE: zone 30 released
  1.45  RESERVE: zone 31 at (6120, 10952) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6120, 10952) facing 2 (id 39)
  1.45  RESERVE: zone 32 at (6072, 10952) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6072, 10952) facing 2 (id 40)
  1.45  RESERVE: zone 33 at (6024, 10952) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6024, 10952) facing 2 (id 41)
  1.45  RESERVE: zone 34 at (5976, 10952) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (5976, 10952) facing 2 (id 42)
  1.45  RESERVE: zone 35 at (5928, 10952) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (5928, 10952) facing 2 (id 43)
  1.45  RESERVE: zone 36 at (6120, 10904) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6120, 10904) facing 2 (id 44)
  1.45  RESERVE: zone 37 at (6072, 10904) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6072, 10904) facing 2 (id 45)
  1.45  RESERVE: zone 38 at (6024, 10904) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6024, 10904) facing 2 (id 46)
  1.45  RESERVE: zone 39 at (5976, 10904) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (5976, 10904) facing 2 (id 47)
  1.45  RESERVE: zone 40 at (5928, 10904) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (5928, 10904) facing 2 (id 48)
  1.45  RESERVE: zone 41 at (6120, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6120, 10856) facing 2 (id 49)
  1.45  RESERVE: zone 42 at (6072, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6072, 10856) facing 2 (id 50)
  1.45  RESERVE: zone 43 at (6024, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6024, 10856) facing 2 (id 51)
  1.45  RESERVE: zone 44 at (5976, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (5976, 10856) facing 2 (id 52)
  1.45  RESERVE: zone 45 at (5928, 10856) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (5928, 10856) facing 2 (id 53)
  1.45  RESERVE: zone 46 at (6120, 10808) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6120, 10808) facing 2 (id 54)
  1.45  RESERVE: zone 47 at (6072, 10808) facing 2, 3x3 cells: 9 of 9 held
```
