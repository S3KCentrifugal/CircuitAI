# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.1 min (frame 54098); wall 228 s
- DLL: build-theatres\d189-build-2\SkirmishAI.dll (74e86ed1d462f25d); AI BARbTest/test; staged 2026-10-04T06:44:27
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-candidate-1\glacial\20261004T094426Z-bcec9347\runs\20261004T094818Z-a32be1a9\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:31.257297][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.8 min | `[t=00:00:45.469950][f=0001465] [SeaWatch] finished frame=1465 id=13862 def=armsy builder=14326` |
| expect `first-ship-exit` | seen at 2.8 min | `[t=00:00:53.218206][f=0004950] [SeaWatch] egress id=9020 yard=13862 seconds=39.8 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-candidate-1\glacial\20261004T094426Z-bcec9347\runs\20261004T094818Z-a32be1a9\screen_2026-10-04_09-45-33-488.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-candidate-1\glacial\20261004T094426Z-bcec9347\runs\20261004T094818Z-a32be1a9\screen_2026-10-04_09-45-54-494.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-candidate-1\glacial\20261004T094426Z-bcec9347\runs\20261004T094818Z-a32be1a9\screen_2026-10-04_09-46-56-366.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-candidate-1\glacial\20261004T094426Z-bcec9347\runs\20261004T094818Z-a32be1a9\screen_2026-10-04_09-48-09-264.png

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
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.10  [SEA][Layout] berth sea.berth.0 armsy at=1424,4000 facing=1
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(700,4597) factory=armsy landLocked=no spot=5 known=1/2
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(1899,5801) factory=corsy landLocked=no spot=6 known=2/2
  0.12  [SEA][Layout] berth sea.berth.1 armasy at=1424,3600 facing=1
  0.15  [Team][Roster] team 1 first mex at 704,4448
  0.15  [Playtest] finished armmex team 0 at 0.15 min
  0.17  [SEA][Layout] berth sea.berth.2 armasy at=1424,3296 facing=3
  0.17  [Team][Roster] first mex 4036 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.18  [Team][Roster] team 2 first mex at 1904,5967
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.81  [Playtest] finished armsy team 0 at 0.81 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 715/1200, energy +30.0 bank 94/1100, units 5
  1.26  [Playtest] finished armtide team 0 at 1.26 min
  1.48  [Playtest] finished armtide team 0 at 1.48 min
  1.62  [Playtest] finished armtide team 0 at 1.62 min
  1.87  [Playtest] finished armtide team 0 at 1.87 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.0 bank 396/1200, energy +129.0 bank 126/1350, units 11
  2.11  [Playtest] finished armtide team 0 at 2.11 min
  2.39  [Playtest] finished armmex team 0 at 2.39 min
  2.73  [Playtest] finished armtide team 0 at 2.73 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 0/1250, energy +182.0 bank 1496/1500, units 16
  3.29  [Playtest] finished armfrad team 0 at 3.29 min
  3.37  [Playtest] finished armmex team 0 at 3.37 min
  3.48  [Playtest] finished armtide team 0 at 3.48 min
  3.61  [Playtest] finished armmex team 0 at 3.61 min
  3.81  [Playtest] finished armmex team 0 at 3.81 min
  3.98  [Playtest] finished armmex team 0 at 3.98 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +14.0 bank 7/1450, energy +205.0 bank 1534/1550, units 22
  4.22  [Playtest] finished armtide team 0 at 4.22 min
  4.48  [Playtest] finished armmex team 0 at 4.48 min
  4.53  [Playtest] finished armtide team 0 at 4.53 min
  4.71  [Playtest] finished armmex team 0 at 4.71 min
  4.91  [Playtest] finished armmex team 0 at 4.91 min
  4.99  [Playtest] finished armtide team 0 at 4.99 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +22.0 bank 18/1600, energy +251.0 bank 1614/1700, units 31
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.00  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.08  [Playtest] finished armmex team 0 at 5.07 min
  5.21  [Playtest] finished armmex team 0 at 5.21 min
  5.39  [Playtest] finished armtide team 0 at 5.39 min
  5.64  [Playtest] finished armmex team 0 at 5.64 min
  5.70  [Playtest] finished armtide team 0 at 5.70 min
  5.76  [Playtest] finished armtl team 0 at 5.76 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +28.0 bank 535/1750, energy +320.0 bank 1792/1800, units 35
  6.21  [Playtest] finished armllt team 0 at 6.21 min
  6.33  [Playtest] finished armtide team 0 at 6.33 min
  6.72  [Playtest] finished armtide team 0 at 6.72 min
  6.82  [Playtest] finished armllt team 0 at 6.82 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +28.0 bank 1184/1750, energy +366.0 bank 1888/1900, units 42
  7.05  [Playtest] finished armnanotcplat team 0 at 7.05 min
  7.23  [Playtest] finished armtide team 0 at 7.23 min
  7.47  [Playtest] finished armtide team 0 at 7.47 min
  7.54  [Playtest] finished armtide team 0 at 7.54 min
  7.68  [Playtest] finished armfmkr team 0 at 7.68 min
  7.90  [Playtest] finished armtide team 0 at 7.90 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +29.0 bank 1290/1750, energy +465.0 bank 2098/2150, units 51
  8.04  [Playtest] finished armfmkr team 0 at 8.04 min
  8.19  [Playtest] finished armfmkr team 0 at 8.19 min
  8.38  [Playtest] finished armtide team 0 at 8.38 min
  8.54  [Playtest] finished armtide team 0 at 8.54 min
  8.82  [Playtest] finished armtide team 0 at 8.82 min
  8.84  [Playtest] finished armtide team 0 at 8.84 min
  8.89  [Playtest] finished armtide team 0 at 8.89 min
  8.96  [Playtest] finished armtide team 0 at 8.96 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +31.0 bank 1314/1750, energy +610.0 bank 2446/2500, units 59
  9.24  [Playtest] finished armfmkr team 0 at 9.24 min
  9.26  [Playtest] finished armtide team 0 at 9.26 min
  9.29  [Playtest] finished armtide team 0 at 9.29 min
  9.34  [Playtest] finished armtide team 0 at 9.34 min
  9.49  [Playtest] finished armfmkr team 0 at 9.49 min
  9.59  [Playtest] finished armtide team 0 at 9.59 min
  9.67  [Playtest] finished armtide team 0 at 9.67 min
  9.73  [Playtest] finished armtide team 0 at 9.73 min
  9.74  [Playtest] finished armfmkr team 0 at 9.74 min
  9.91  [Playtest] finished armtide team 0 at 9.91 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +34.0 bank 1332/1750, energy +778.0 bank 2698/2900, units 74
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.01  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.04  [Playtest] finished armtide team 0 at 10.04 min
 10.06  [Playtest] finished armtide team 0 at 10.06 min
 10.17  [Playtest] finished armtide team 0 at 10.17 min
 10.35  [Playtest] finished armtide team 0 at 10.35 min
 10.39  [Playtest] finished armnanotcplat team 0 at 10.39 min
 10.44  [Playtest] finished armtide team 0 at 10.44 min
 10.86  [Playtest] finished armtide team 0 at 10.86 min
 10.99  [Playtest] finished armtide team 0 at 10.99 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +34.0 bank 918/1750, energy +916.0 bank 3204/3250, units 83
 11.27  [Playtest] finished armfmkr team 0 at 11.27 min
 11.31  [Playtest] finished armfmkr team 0 at 11.31 min
 11.54  [Playtest] finished armtide team 0 at 11.54 min
 11.65  [Playtest] finished armfmkr team 0 at 11.65 min
 11.67  [Playtest] finished armfmkr team 0 at 11.67 min
 11.83  [Playtest] finished armmex team 0 at 11.83 min
 11.86  [Playtest] finished armtide team 0 at 11.86 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +37.4 bank 808/1800, energy +985.0 bank 2772/3350, units 92
 12.02  [Playtest] finished armfmkr team 0 at 12.02 min
 12.17  [Playtest] finished armtide team 0 at 12.17 min
 12.43  [Playtest] finished armmex team 0 at 12.43 min
 12.54  [Playtest] finished armtide team 0 at 12.54 min
 12.96  [Playtest] finished armtide team 0 at 12.96 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +40.7 bank 1041/1850, energy +1054.0 bank 2926/3500, units 101
 13.30  [Playtest] finished armtl team 0 at 13.30 min
 13.59  [Playtest] finished armtide team 0 at 13.59 min
 13.89  [Playtest] finished armtl team 0 at 13.89 min
 13.91  [Playtest] finished armmex team 0 at 13.91 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +45.0 bank 781/1900, energy +1077.0 bank 3406/3550, units 107
 14.22  [Playtest] finished armmex team 0 at 14.22 min
 14.28  [Playtest] finished armtide team 0 at 14.28 min
 14.31  [Playtest] finished armfrad team 0 at 14.31 min
 14.50  [Playtest] finished armmex team 0 at 14.50 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +46.8 bank 290/2000, energy +1100.0 bank 2935/3600, units 105
 15.24  [Playtest] finished armmex team 0 at 15.24 min
 15.25  [Playtest] finished armasy team 0 at 15.25 min
 15.80  [Playtest] finished armfmkr team 0 at 15.80 min
 15.81  [Playtest] finished armtl team 0 at 15.81 min
 15.82  [Playtest] finished armtide team 0 at 15.82 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +45.9 bank 194/2250, energy +1153.0 bank 3090/4000, units 111
 16.03  [Playtest] finished armfrad team 0 at 16.03 min
 16.14  [Playtest] finished armtide team 0 at 16.14 min
 16.19  [Playtest] finished armtide team 0 at 16.19 min
 16.32  [Playtest] finished armmex team 0 at 16.32 min
 16.57  [Playtest] finished armrad team 0 at 16.57 min
 16.61  [Playtest] finished armtide team 0 at 16.61 min
 16.68  [Playtest] finished armuwmme team 0 at 16.68 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +50.0 bank 386/2800, energy +1238.0 bank 3213/4200, units 110
 17.29  [Playtest] finished armnanotcplat team 0 at 17.29 min
 17.39  [Playtest] finished armuwmme team 0 at 17.39 min
 17.60  [Playtest] finished armuwmme team 0 at 17.60 min
 17.63  [Playtest] finished armfrad team 0 at 17.63 min
 17.64  [Playtest] finished armnanotcplat team 0 at 17.64 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +67.8 bank 2/3850, energy +1238.0 bank 3520/4200, units 112
 18.44  [Playtest] finished armnanotcplat team 0 at 18.44 min
 18.45  [Playtest] finished armmex team 0 at 18.45 min
 18.53  [Playtest] finished armtl team 0 at 18.53 min
 18.68  [Playtest] finished armmex team 0 at 18.68 min
 18.76  [Playtest] finished armbats team 0 at 18.76 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +59.9 bank 0/3700, energy +1231.0 bank 3403/4150, units 108
 20.00  [Playtest] eco team 0 at 20.0 min: metal +58.0 bank 0/3650, energy +1224.0 bank 3425/4100, units 100
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.02  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
 20.15  [Playtest] finished armuwfus team 0 at 20.15 min
 20.90  [Playtest] finished armatl team 0 at 20.90 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +56.0 bank 48/3550, energy +2731.0 bank 8094/8150, units 100
 21.29  [Playtest] finished armllt team 0 at 21.29 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +56.0 bank 0/3550, energy +2731.0 bank 8027/8150, units 106
 22.59  [Playtest] finished armrl team 0 at 22.59 min
 22.88  [Playtest] finished armbats team 0 at 22.88 min
 22.91  [Playtest] finished armmex team 0 at 22.91 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +58.0 bank 36/3600, energy +2731.0 bank 7961/8150, units 105
 23.10  [Playtest] finished armuwmmm team 0 at 23.10 min
 23.35  [Playtest] finished armuwmmm team 0 at 23.35 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +71.5 bank 39/3550, energy +2417.0 bank 5719/6550, units 102
 24.99  [Playtest] finished armmex team 0 at 24.99 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +73.8 bank 41/3600, energy +2431.0 bank 5844/6650, units 103
 25.37  [Playtest] finished armtide team 0 at 25.37 min
 25.40  [Playtest] finished armbats team 0 at 25.40 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +50.0 bank 71/3550, energy +2118.0 bank 5719/5800, units 79
 26.33  [Playtest] finished armfmkr team 0 at 26.33 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +51.0 bank 1219/3550, energy +2148.0 bank 6009/6100, units 84
 27.84  [Playtest] finished armuwmmm team 0 at 27.84 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +61.3 bank 30/3550, energy +2478.0 bank 7202/7600, units 89
 28.63  [Playtest] finished armuwmmm team 0 at 28.63 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +61.2 bank 31/3550, energy +2178.0 bank 5123/6100, units 86
 29.00  [Playtest] camera requested (1700,4550) height=4000
 29.00  [Playtest] camera captured name=ta position=(1700,4550) height=4000
 29.00  [Playtest] screenshot at 29.0 min of team 0 at (1700, 4550)
 29.08  [Playtest] finished armuwmmm team 0 at 29.08 min
 29.25  [Playtest] finished armfmkr team 0 at 29.25 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +48.0 bank 1/3050, energy +2111.0 bank 5348/5400, units 77
```

## Native lines (all AIs, first 120)

```
  0.09  EXP: approach: corcom(7049) at (1899, 5801) walks to (1900, 5829), 139 from the cormex site (1904, 5968)
  0.10  RESERVE: zone 1 at (1424, 4000) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (1424, 4000) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (1712, 4000) facing 1, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (1208, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1208, 4072) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (1208, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1208, 4008) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (1208, 3944) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1208, 3944) facing 1 (id 4)
  0.10  RESERVE: zone 6 at (1272, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1272, 4072) facing 1 (id 5)
  0.10  RESERVE: zone 7 at (1272, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1272, 4008) facing 1 (id 6)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 released
  0.10  RESERVE: zone 6 released
  0.10  RESERVE: zone 7 released
  0.10  RESERVE: zone 8 at (1304, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1304, 4072) facing 1 (id 7)
  0.10  RESERVE: zone 9 at (1304, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1304, 4008) facing 1 (id 8)
  0.10  RESERVE: zone 8 released
  0.10  RESERVE: zone 9 released
  0.10  RESERVE: zone 10 at (1288, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1288, 4104) facing 1 (id 9)
  0.10  RESERVE: zone 11 at (1288, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1288, 4040) facing 1 (id 10)
  0.10  RESERVE: zone 12 at (1288, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1288, 3976) facing 1 (id 11)
  0.10  RESERVE: zone 13 at (1352, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 4104) facing 1 (id 12)
  0.10  RESERVE: zone 14 at (1352, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 4040) facing 1 (id 13)
  0.10  RESERVE: zone 15 at (1352, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 3976) facing 1 (id 14)
  0.10  RESERVE: zone 16 at (1321, 4037) facing 1, 9x13 cells: 54 of 117 held
  0.10  RESERVE: zone 1 at (704, 4592) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (704, 4592) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (992, 4592) facing 1, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (488, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4664) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (488, 4600) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4600) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (488, 4536) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4536) facing 1 (id 4)
  0.10  RESERVE: zone 6 at (552, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4664) facing 1 (id 5)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 released
  0.10  RESERVE: zone 6 released
  0.10  RESERVE: zone 7 at (584, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (584, 4664) facing 1 (id 6)
  0.10  RESERVE: zone 7 released
  0.10  RESERVE: zone 8 at (568, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (568, 4696) facing 1 (id 7)
  0.10  RESERVE: zone 8 released
  0.10  RESERVE: zone 9 at (552, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4728) facing 1 (id 8)
  0.10  RESERVE: zone 10 at (552, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4664) facing 1 (id 9)
  0.10  RESERVE: zone 9 released
  0.10  RESERVE: zone 10 released
  0.10  RESERVE: zone 11 at (520, 4744) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (520, 4744) facing 1 (id 10)
  0.10  RESERVE: zone 12 at (520, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (520, 4680) facing 1 (id 11)
  0.10  RESERVE: zone 11 released
  0.10  RESERVE: zone 12 released
  0.10  RESERVE: zone 13 at (488, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4760) facing 1 (id 12)
  0.10  RESERVE: zone 14 at (488, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4696) facing 1 (id 13)
  0.10  RESERVE: zone 15 at (488, 4632) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4632) facing 1 (id 14)
  0.10  RESERVE: zone 16 at (552, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4760) facing 1 (id 15)
  0.10  RESERVE: zone 17 at (552, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4696) facing 1 (id 16)
  0.10  RESERVE: zone 13 released
  0.10  RESERVE: zone 14 released
  0.10  RESERVE: zone 15 released
  0.10  RESERVE: zone 16 released
  0.10  RESERVE: zone 17 released
  0.10  RESERVE: zone 18 at (440, 4744) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (440, 4744) facing 1 (id 17)
  0.10  RESERVE: zone 19 at (440, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (440, 4680) facing 1 (id 18)
  0.10  RESERVE: zone 20 at (440, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (440, 4616) facing 1 (id 19)
  0.10  RESERVE: zone 21 at (504, 4744) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (504, 4744) facing 1 (id 20)
  0.10  RESERVE: zone 22 at (504, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (504, 4680) facing 1 (id 21)
  0.10  RESERVE: zone 18 released
  0.10  RESERVE: zone 19 released
  0.10  RESERVE: zone 20 released
  0.10  RESERVE: zone 21 released
  0.10  RESERVE: zone 22 released
  0.10  RESERVE: zone 23 at (408, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (408, 4728) facing 1 (id 22)
  0.10  RESERVE: zone 24 at (408, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (408, 4664) facing 1 (id 23)
  0.10  RESERVE: zone 25 at (408, 4600) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (408, 4600) facing 1 (id 24)
  0.10  RESERVE: zone 26 at (472, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (472, 4728) facing 1 (id 25)
  0.10  RESERVE: zone 27 at (472, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (472, 4664) facing 1 (id 26)
  0.10  RESERVE: zone 28 at (472, 4600) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (472, 4600) facing 1 (id 27)
  0.10  RESERVE: zone 29 at (444, 4660) facing 1, 9x13 cells: 63 of 117 held
  0.10  RESERVE: zone 1 at (12928, 4000) facing 3, 6x6 cells: 36 of 36 held
  0.10  RESERVE: legsy at (12928, 4000) facing 3 (id 1)
  0.10  RESERVE: corridor 2 at (12640, 4000) facing 3, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (13160, 3944) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (13160, 3944) facing 3 (id 2)
  0.10  RESERVE: zone 4 at (13160, 4008) facing 3, 3x3 cells: 9 of 9 held
```
