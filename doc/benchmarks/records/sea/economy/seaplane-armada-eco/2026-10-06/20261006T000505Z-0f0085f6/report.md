# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54001); wall 255 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (aff90f713fc9746a); AI BARbTest/test; staged 2026-10-05T21:00:41
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: seaplane-natural.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada-eco\supreme\20261006T000041Z-dcec093b\runs\20261006T000505Z-0f0085f6\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `mex` | seen at 3.4 min | `[t=00:01:00.802473][f=0006064] [SeaTransition] PASS mex completed by first construction ship` |
| expect `platform` | seen at 17.4 min | `[t=00:02:26.962239][f=0031253] [SeaTransition] PASS platform completed armplat` |
| expect `aircraft` | seen at 17.8 min | `[t=00:02:29.641227][f=0032007] [SeaTransition] PASS aircraft produced armsb` |
| expect `support` | seen at 17.5 min | `[t=00:02:27.814413][f=0031500] [SeaTransition] PASS platform assistance turrets=3 assisting=2` |
| forbid `errors` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada-eco\supreme\20261006T000041Z-dcec093b\runs\20261006T000505Z-0f0085f6\screen_2026-10-06_00-02-02-563.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada-eco\supreme\20261006T000041Z-dcec093b\runs\20261006T000505Z-0f0085f6\screen_2026-10-06_00-02-33-544.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada-eco\supreme\20261006T000041Z-dcec093b\runs\20261006T000505Z-0f0085f6\screen_2026-10-06_00-03-35-604.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada-eco\supreme\20261006T000041Z-dcec093b\runs\20261006T000505Z-0f0085f6\screen_2026-10-06_00-04-50-813.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 10, 4 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 31
  0.00  [Playtest] speed 10
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 31
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.22  [SEA][Layout] berth sea.berth.0 armsy at=5824,10640 facing=2
  0.23  [Playtest] finished armmex team 0 at 0.23 min
  0.25  [Team][Roster] first mex 6362 at 4608,11072
  0.25  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4764|11076|0|7|1|4608|11072
  0.37  [SEA][Layout] berth sea.berth.1 armasy at=6048,10384 facing=2
  0.45  [Playtest] finished armmex team 0 at 0.45 min
  0.53  [SEA][Layout] berth sea.berth.2 armplat at=6080,10640 facing=2
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 1002/1100, energy +30.0 bank 830/1000, units 4
  1.20  [Playtest] finished armsy team 0 at 1.20 min
  1.75  [Playtest] finished armmex team 0 at 1.75 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.9 bank 917/1250, energy +30.0 bank 62/1100, units 6
  2.22  [Playtest] finished armwin team 0 at 2.22 min
  2.70  [Playtest] finished armllt team 0 at 2.70 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.9 bank 1101/1250, energy +55.9 bank 45/1150, units 10
  3.01  [Playtest] finished armwin team 0 at 3.01 min
  3.11  [Playtest] finished armwin team 0 at 3.11 min
  3.25  [Playtest] finished armwin team 0 at 3.25 min
  3.36  [Playtest] finished armwin team 0 at 3.36 min
  3.37  [Playtest] finished armmex team 0 at 3.37 min
  3.46  [Playtest] finished armwin team 0 at 3.46 min
  3.80  [Playtest] finished armmex team 0 at 3.80 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +13.5 bank 1007/1350, energy +81.2 bank 89/1203, units 19
  4.05  [Playtest] finished armfrad team 0 at 4.05 min
  4.56  [Playtest] finished armtl team 0 at 4.56 min
  4.93  [Playtest] finished armtl team 0 at 4.93 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +13.5 bank 1212/1350, energy +117.6 bank 125/1203, units 22
  5.00  [Playtest] camera requested (6200,11000) height=3800
  5.00  [Playtest] camera captured name=ta position=(6200,11000) height=3800
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (6200, 11000)
  5.04  [Playtest] finished armmex team 0 at 5.04 min
  5.53  [Playtest] finished armmex team 0 at 5.53 min
  5.70  [Playtest] finished armtide team 0 at 5.70 min
  5.84  [Playtest] finished armtide team 0 at 5.84 min
  6.00  [Playtest] finished armtide team 0 at 6.00 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +18.1 bank 941/1450, energy +199.7 bank 143/1353, units 29
  6.01  [Playtest] finished armtide team 0 at 6.01 min
  6.03  [Playtest] finished armtl team 0 at 6.03 min
  6.32  [Playtest] finished armtide team 0 at 6.32 min
  6.68  [Playtest] finished armmex team 0 at 6.68 min
  6.69  [Playtest] finished armtide team 0 at 6.69 min
  6.76  [Playtest] finished armtl team 0 at 6.76 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +20.4 bank 987/1500, energy +283.9 bank 1427/1503, units 37
  7.11  [Playtest] finished armfmkr team 0 at 7.11 min
  7.28  [Playtest] finished armfrad team 0 at 7.28 min
  7.63  [Playtest] finished armnanotcplat team 0 at 7.63 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +21.4 bank 1227/1500, energy +289.9 bank 1444/1553, units 44
  8.06  [Playtest] finished armtide team 0 at 8.06 min
  8.10  [Playtest] finished armmex team 0 at 8.10 min
  8.14  [Playtest] finished armtide team 0 at 8.15 min
  8.31  [Playtest] finished armfmkr team 0 at 8.31 min
  8.36  [Playtest] finished armtide team 0 at 8.36 min
  8.39  [Playtest] finished armmex team 0 at 8.39 min
  8.43  [Playtest] finished armtide team 0 at 8.43 min
  8.68  [Playtest] finished armmex team 0 at 8.68 min
  8.76  [Playtest] finished armtide team 0 at 8.76 min
  8.77  [Playtest] finished armtide team 0 at 8.77 min
  8.77  [Playtest] finished armtide team 0 at 8.77 min
  8.78  [Playtest] finished armtide team 0 at 8.78 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +27.6 bank 122/1650, energy +418.5 bank 1518/2003, units 60
  9.07  [Playtest] finished armmex team 0 at 9.07 min
  9.08  [Playtest] finished armtide team 0 at 9.08 min
  9.08  [Playtest] finished armtide team 0 at 9.08 min
  9.09  [Playtest] finished armtide team 0 at 9.09 min
  9.12  [Playtest] finished armtide team 0 at 9.12 min
  9.46  [Playtest] finished armtide team 0 at 9.46 min
  9.47  [Playtest] finished armmex team 0 at 9.47 min
  9.50  [Playtest] finished armtide team 0 at 9.50 min
  9.52  [Playtest] finished armtide team 0 at 9.52 min
  9.58  [Playtest] finished armfmkr team 0 at 9.58 min
  9.76  [Playtest] finished armtide team 0 at 9.76 min
  9.78  [Playtest] finished armllt team 0 at 9.78 min
  9.93  [Playtest] finished armtide team 0 at 9.93 min
  9.94  [Playtest] finished armfmkr team 0 at 9.94 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +35.1 bank 19/1750, energy +634.3 bank 2370/2453, units 74
 10.00  [Playtest] camera requested (6200,11000) height=4200
 10.01  [Playtest] camera captured name=ta position=(6200,11000) height=4200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (6200, 11000)
 10.12  [Playtest] finished armtide team 0 at 10.12 min
 10.13  [Playtest] finished armtide team 0 at 10.13 min
 10.25  [Playtest] finished armmex team 0 at 10.25 min
 10.29  [Playtest] finished armtide team 0 at 10.29 min
 10.30  [Playtest] finished armfmkr team 0 at 10.30 min
 10.43  [Playtest] finished armtide team 0 at 10.43 min
 10.51  [Playtest] finished armmex team 0 at 10.51 min
 10.53  [Playtest] finished armtide team 0 at 10.52 min
 10.66  [Playtest] finished armllt team 0 at 10.66 min
 10.66  [Playtest] finished armfmkr team 0 at 10.66 min
 10.69  [Playtest] finished armtide team 0 at 10.69 min
 10.73  [Playtest] finished armtide team 0 at 10.73 min
 10.74  [Playtest] finished armrad team 0 at 10.74 min
 10.89  [Playtest] finished armtide team 0 at 10.89 min
 10.99  [Playtest] finished armtide team 0 at 10.99 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +41.7 bank 174/1850, energy +803.9 bank 2846/2903, units 91
 11.04  [Playtest] finished armfmkr team 0 at 11.04 min
 11.13  [Playtest] finished armtide team 0 at 11.13 min
 11.18  [Playtest] finished armmex team 0 at 11.18 min
 11.30  [Playtest] finished armtide team 0 at 11.30 min
 11.31  [Playtest] finished armtide team 0 at 11.31 min
 11.37  [Playtest] finished armllt team 0 at 11.37 min
 11.47  [Playtest] finished armtide team 0 at 11.47 min
 11.47  [Playtest] finished armfmkr team 0 at 11.47 min
 11.60  [Playtest] finished armtide team 0 at 11.60 min
 11.67  [Playtest] finished armtide team 0 at 11.67 min
 11.78  [Playtest] finished armtide team 0 at 11.78 min
 11.84  [Playtest] finished armfmkr team 0 at 11.84 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +47.0 bank 1745/1900, energy +989.7 bank 3017/3253, units 105
 12.05  [Playtest] finished armrad team 0 at 12.05 min
 12.13  [Playtest] finished armtide team 0 at 12.13 min
 12.20  [Playtest] finished armfmkr team 0 at 12.20 min
 12.21  [Playtest] finished armtide team 0 at 12.21 min
 12.43  [Playtest] finished armtide team 0 at 12.43 min
 12.56  [Playtest] finished armfmkr team 0 at 12.56 min
 12.58  [Playtest] finished armtide team 0 at 12.58 min
 12.76  [Playtest] finished armtide team 0 at 12.76 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +47.0 bank 314/1900, energy +1000.9 bank 2887/3503, units 115
 13.04  [Playtest] finished armtide team 0 at 13.04 min
 13.09  [Playtest] finished armtide team 0 at 13.09 min
 13.13  [Playtest] finished armtide team 0 at 13.14 min
 13.27  [Playtest] finished armasy team 0 at 13.27 min
 13.44  [Playtest] finished armtide team 0 at 13.44 min
 13.55  [Playtest] finished armfmkr team 0 at 13.55 min
 13.72  [Playtest] finished armnanotcplat team 0 at 13.72 min
 13.80  [Playtest] finished armfmkr team 0 at 13.80 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +48.0 bank 18/2100, energy +1204.8 bank 3327/4053, units 125
 14.04  [Playtest] finished armllt team 0 at 14.04 min
 14.17  [Playtest] finished armfmkr team 0 at 14.17 min
 14.31  [Playtest] finished armrad team 0 at 14.31 min
 14.46  [Playtest] finished armllt team 0 at 14.46 min
 14.73  [Playtest] finished armuwmme team 0 at 14.73 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +51.9 bank 0/2650, energy +1190.8 bank 3459/4203, units 132
 15.04  [Playtest] finished armmex team 0 at 15.04 min
 15.49  [Playtest] finished armmex team 0 at 15.49 min
 15.61  [Playtest] finished armmex team 0 at 15.61 min
 15.69  [Playtest] finished armtl team 0 at 15.69 min
 15.77  [Playtest] finished armllt team 0 at 15.77 min
 15.81  [Playtest] finished armuwmme team 0 at 15.81 min
 15.90  [Playtest] finished armrad team 0 at 15.90 min
 15.99  [Playtest] finished armfrad team 0 at 15.99 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +69.5 bank 96/3350, energy +1540.0 bank 4688/5703, units 141
 16.01  [Playtest] finished armuwmme team 0 at 16.01 min
 16.04  [Playtest] finished armtl team 0 at 16.04 min
 16.73  [Playtest] finished armnanotcplat team 0 at 16.73 min
 16.78  [Playtest] finished armuwmme team 0 at 16.78 min
 16.82  [Playtest] finished armrad team 0 at 16.82 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +77.3 bank 52/4450, energy +1537.3 bank 4510/5703, units 149
 17.26  [Playtest] finished armfrad team 0 at 17.26 min
 17.36  [Playtest] finished armplat team 0 at 17.36 min
 17.55  [Playtest] finished armllt team 0 at 17.55 min
 17.97  [Playtest] finished armfmkr team 0 at 17.97 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +72.5 bank 88/4450, energy +1535.3 bank 4339/5903, units 159
 18.02  [Playtest] finished armnanotcplat team 0 at 18.02 min
 18.21  [Playtest] finished armnanotcplat team 0 at 18.21 min
 18.49  [Playtest] finished armnanotcplat team 0 at 18.49 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +81.2 bank 6/4450, energy +1520.4 bank 4731/5903, units 164
 20.00  [Playtest] eco team 0 at 20.0 min: metal +81.1 bank 6/4450, energy +1508.3 bank 4727/5903, units 167
 20.00  [Playtest] camera requested (6200,11000) height=4800
 20.01  [Playtest] camera captured name=ta position=(6200,11000) height=4800
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (6200, 11000)
 20.01  [Playtest] finished armuwfus team 0 at 20.01 min
 20.11  [Playtest] finished armfmkr team 0 at 20.11 min
 20.14  [Playtest] finished armfmkr team 0 at 20.14 min
 20.19  [Playtest] finished armfmkr team 0 at 20.19 min
 20.21  [Playtest] finished armfmkr team 0 at 20.21 min
 20.36  [Playtest] finished armfmkr team 0 at 20.36 min
 20.40  [Playtest] finished armfmkr team 0 at 20.40 min
 20.77  [Playtest] finished armatl team 0 at 20.77 min
 20.93  [Playtest] finished armfmkr team 0 at 20.93 min
 20.97  [Playtest] finished armfmkr team 0 at 20.97 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +88.9 bank 551/4450, energy +2657.5 bank 6982/8401, units 180
 21.31  [Playtest] finished armnanotcplat team 0 at 21.31 min
 21.33  [Playtest] finished armnanotcplat team 0 at 21.33 min
 21.55  [Playtest] finished armnanotcplat team 0 at 21.55 min
 21.85  [Playtest] finished armnanotcplat team 0 at 21.85 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +87.6 bank 46/4450, energy +2626.0 bank 6857/8400, units 191
 22.28  [Playtest] finished armfmkr team 0 at 22.28 min
 22.32  [Playtest] finished armfmkr team 0 at 22.32 min
 22.43  [Playtest] finished armuwmmm team 0 at 22.42 min
 22.75  [Playtest] finished armuwmmm team 0 at 22.75 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +97.0 bank 153/4450, energy +2626.0 bank 6887/8400, units 197
 23.02  [Playtest] finished armnanotcplat team 0 at 23.02 min
 23.43  [Playtest] finished armfmkr team 0 at 23.42 min
 23.52  [Playtest] finished armfmkr team 0 at 23.52 min
 23.57  [Playtest] finished armfmkr team 0 at 23.57 min
 23.61  [Playtest] finished armfmkr team 0 at 23.61 min
 23.73  [Playtest] finished armfmkr team 0 at 23.73 min
 23.93  [Playtest] finished armfmkr team 0 at 23.93 min
 23.96  [Playtest] finished armfmkr team 0 at 23.96 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +83.3 bank 67/4450, energy +2626.0 bank 6952/8400, units 213
 25.00  [Playtest] eco team 0 at 25.0 min: metal +95.0 bank 42/4450, energy +2626.0 bank 6877/8400, units 221
 25.72  [Playtest] finished armtl team 0 at 25.72 min
 25.78  [Playtest] finished armfrad team 0 at 25.78 min
 25.89  [Playtest] finished armtl team 0 at 25.89 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +81.7 bank 65/4450, energy +2626.0 bank 6978/8400, units 228
 26.14  [Playtest] finished armtl team 0 at 26.14 min
 26.22  [Playtest] finished armfrad team 0 at 26.22 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +94.9 bank 43/4450, energy +2626.0 bank 6893/8400, units 236
 27.07  [Playtest] finished armtl team 0 at 27.07 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +94.5 bank 44/4450, energy +2626.0 bank 6910/8400, units 242
 28.16  [Playtest] finished armtl team 0 at 28.16 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +96.3 bank 154/4450, energy +2626.0 bank 6474/8400, units 251
 29.00  [Playtest] camera requested (6200,11000) height=4800
 29.01  [Playtest] camera captured name=ta position=(6200,11000) height=4800
 29.01  [Playtest] screenshot at 29.0 min of team 0 at (6200, 11000)
 29.30  [Playtest] finished armnanotcplat team 0 at 29.30 min
 29.69  [Playtest] finished armrad team 0 at 29.69 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +88.4 bank 142/4450, energy +2626.0 bank 6592/8400, units 259
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(25614) at (4764, 11076) walks to (4744, 11076), 136 from the armmex site (4608, 11072)
  0.08  EXP: approach: armcom(13836) at (7529, 1225) walks to (7560, 1226), 136 from the armmex site (7696, 1232)
  0.22  RESERVE: zone 1 at (5824, 10640) facing 2, 6x6 cells: 36 of 36 held
  0.22  RESERVE: armsy at (5824, 10640) facing 2 (id 1)
  0.22  RESERVE: corridor 2 at (5824, 10352) facing 2, 12x30 cells: 360 of 360 held
  0.22  RESERVE: zone 3 at (5784, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (5784, 10808) facing 2 (id 2)
  0.22  RESERVE: zone 3 released
  0.22  RESERVE: zone 4 at (5952, 11424) facing 2, 40x40 cells: 1600 of 1600 held
  0.22  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (5952, 11328) facing 2: 1 of 16 slots (group 1, held, zone)
  0.22  RESERVE: zone 4 released
  0.22  RESERVE: zone 5 at (6080, 11424) facing 2, 40x40 cells: 1600 of 1600 held
  0.22  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6080, 11328) facing 2: 6 of 16 slots (group 2, held, zone)
  0.22  RESERVE: zone 5 released
  0.22  RESERVE: zone 6 at (6208, 11424) facing 2, 40x40 cells: 1600 of 1600 held
  0.22  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6208, 11328) facing 2: 13 of 16 slots (group 3, held, zone)
  0.22  RESERVE: zone 6 released
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
```
