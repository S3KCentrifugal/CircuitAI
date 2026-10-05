# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.1 min (frame 54164); wall 249 s
- DLL: build-theatres\d189-build-7\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T08:13:42
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\glacial\20261004T111341Z-f67ab1d2\runs\20261004T111753Z-0edc3c74\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:40.280133][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.0 min | `[t=00:00:58.033493][f=0001883] [SeaWatch] finished frame=1883 id=22058 def=armsy builder=27123` |
| expect `first-ship-exit` | seen at 2.8 min | `[t=00:01:05.836245][f=0005010] [SeaWatch] egress id=6935 yard=22058 seconds=4.7 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\glacial\20261004T111341Z-f67ab1d2\runs\20261004T111753Z-0edc3c74\screen_2026-10-04_11-15-02-024.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\glacial\20261004T111341Z-f67ab1d2\runs\20261004T111753Z-0edc3c74\screen_2026-10-04_11-15-27-433.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\glacial\20261004T111341Z-f67ab1d2\runs\20261004T111753Z-0edc3c74\screen_2026-10-04_11-16-36-567.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-final\glacial\20261004T111341Z-f67ab1d2\runs\20261004T111753Z-0edc3c74\screen_2026-10-04_11-17-44-322.png

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
  0.15  [Playtest] finished armmex team 0 at 0.15 min
  0.17  [SEA][Layout] berth sea.berth.2 armasy at=1424,3296 facing=3
  0.17  [Team][Roster] first mex 24679 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.17  [Team][Roster] team 1 first mex at 704,4448
  0.18  [Team][Roster] team 2 first mex at 1904,5967
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 802/1100, energy +30.0 bank 514/1000, units 4
  1.05  [Playtest] finished armsy team 0 at 1.05 min
  1.47  [Playtest] finished armtide team 0 at 1.47 min
  1.66  [Playtest] finished armtide team 0 at 1.66 min
  1.96  [Playtest] finished armtide team 0 at 1.96 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.0 bank 608/1200, energy +106.0 bank 389/1300, units 9
  2.22  [Playtest] finished armtide team 0 at 2.22 min
  2.31  [Playtest] finished armmex team 0 at 2.31 min
  2.36  [Playtest] finished armtide team 0 at 2.36 min
  2.56  [Playtest] finished armmex team 0 at 2.56 min
  2.80  [Playtest] finished armtide team 0 at 2.80 min
  2.95  [Playtest] finished armfrad team 0 at 2.95 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 345/1300, energy +182.0 bank 1430/1500, units 17
  3.39  [Playtest] finished armmex team 0 at 3.39 min
  3.39  [Playtest] finished armfmkr team 0 at 3.39 min
  3.44  [Playtest] finished armfmkr team 0 at 3.44 min
  3.61  [Playtest] finished armmex team 0 at 3.61 min
  3.86  [Playtest] finished armmex team 0 at 3.86 min
  3.99  [Playtest] finished armtide team 0 at 3.99 min
  4.00  [Playtest] finished armtide team 0 at 3.99 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +16.6 bank 43/1450, energy +182.0 bank 1175/1600, units 25
  4.36  [Playtest] finished armtide team 0 at 4.36 min
  4.39  [Playtest] finished armmex team 0 at 4.39 min
  4.62  [Playtest] finished armmex team 0 at 4.62 min
  4.69  [Playtest] finished armtide team 0 at 4.69 min
  4.83  [Playtest] finished armmex team 0 at 4.83 min
  4.84  [Playtest] finished armtide team 0 at 4.84 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +24.0 bank 134/1600, energy +297.0 bank 1426/1750, units 35
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.00  [Playtest] finished armmex team 0 at 5.00 min
  5.02  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.15  [Playtest] finished armtide team 0 at 5.15 min
  5.35  [Playtest] finished armtide team 0 at 5.35 min
  5.57  [Playtest] finished armmex team 0 at 5.57 min
  5.67  [Playtest] finished armtide team 0 at 5.67 min
  5.68  [Playtest] finished armtide team 0 at 5.68 min
  5.79  [Playtest] finished armmex team 0 at 5.79 min
  5.98  [Playtest] finished armmex team 0 at 5.98 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +30.0 bank 719/1800, energy +389.0 bank 1904/1950, units 44
  6.01  [Playtest] finished armtide team 0 at 6.01 min
  6.32  [Playtest] finished armtide team 0 at 6.32 min
  6.38  [Playtest] finished armtide team 0 at 6.38 min
  6.41  [Playtest] finished armnanotcplat team 0 at 6.41 min
  6.74  [Playtest] finished armtide team 0 at 6.74 min
  6.80  [Playtest] finished armfmkr team 0 at 6.80 min
  6.86  [Playtest] finished armtide team 0 at 6.86 min
  6.91  [Playtest] finished armtide team 0 at 6.91 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +33.0 bank 926/1800, energy +537.5 bank 2339/2350, units 50
  7.24  [Playtest] finished armtide team 0 at 7.24 min
  7.31  [Playtest] finished armtide team 0 at 7.31 min
  7.45  [Playtest] finished armfmkr team 0 at 7.45 min
  7.50  [Playtest] finished armtide team 0 at 7.50 min
  7.71  [Playtest] finished armnanotcplat team 0 at 7.71 min
  7.76  [Playtest] finished armfmkr team 0 at 7.76 min
  7.79  [Playtest] finished armtide team 0 at 7.79 min
  7.83  [Playtest] finished armtide team 0 at 7.83 min
  7.89  [Playtest] finished armtide team 0 at 7.89 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +32.0 bank 816/1800, energy +686.0 bank 2319/2700, units 64
  8.02  [Playtest] finished armfmkr team 0 at 8.02 min
  8.11  [Playtest] finished armtide team 0 at 8.11 min
  8.15  [Playtest] finished armtide team 0 at 8.15 min
  8.16  [Playtest] finished armtide team 0 at 8.16 min
  8.33  [Playtest] finished armtide team 0 at 8.33 min
  8.45  [Playtest] finished armtide team 0 at 8.45 min
  8.56  [Playtest] finished armtide team 0 at 8.56 min
  8.63  [Playtest] finished armtide team 0 at 8.63 min
  8.65  [Playtest] finished armtide team 0 at 8.65 min
  8.70  [Playtest] finished armtide team 0 at 8.70 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +36.0 bank 904/1800, energy +893.0 bank 3148/3150, units 76
  9.17  [Playtest] finished armtide team 0 at 9.17 min
  9.25  [Playtest] finished armtide team 0 at 9.25 min
  9.56  [Playtest] finished armfmkr team 0 at 9.56 min
  9.61  [Playtest] finished armfmkr team 0 at 9.61 min
  9.79  [Playtest] finished armfmkr team 0 at 9.79 min
  9.98  [Playtest] finished armfmkr team 0 at 9.98 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +36.8 bank 31/1800, energy +939.0 bank 2704/3250, units 81
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.02  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.68  [Playtest] finished armtide team 0 at 10.68 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +40.0 bank 0/1800, energy +962.0 bank 3161/3300, units 83
 11.07  [Playtest] finished armasy team 0 at 11.07 min
 11.16  [Playtest] finished armtide team 0 at 11.16 min
 11.64  [Playtest] finished armtide team 0 at 11.64 min
 11.66  [Playtest] finished armfmkr team 0 at 11.66 min
 11.66  [Playtest] finished armtide team 0 at 11.66 min
 11.72  [Playtest] finished armfmkr team 0 at 11.72 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +39.0 bank 0/2000, energy +1061.0 bank 3163/3800, units 89
 12.27  [Playtest] finished armtide team 0 at 12.27 min
 12.52  [Playtest] finished armuwmme team 0 at 12.52 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +43.0 bank 0/2500, energy +1114.0 bank 3315/4000, units 93
 13.22  [Playtest] finished armtide team 0 at 13.22 min
 13.25  [Playtest] finished armmex team 0 at 13.25 min
 13.35  [Playtest] finished armmex team 0 at 13.35 min
 13.49  [Playtest] finished armfrad team 0 at 13.49 min
 13.81  [Playtest] finished armuwmme team 0 at 13.81 min
 13.86  [Playtest] finished armtl team 0 at 13.86 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +53.3 bank 0/3150, energy +1137.0 bank 3362/4050, units 95
 14.20  [Playtest] finished armuwmme team 0 at 14.20 min
 14.21  [Playtest] finished armfrad team 0 at 14.21 min
 14.23  [Playtest] finished armtide team 0 at 14.23 min
 14.26  [Playtest] finished armtide team 0 at 14.26 min
 14.49  [Playtest] finished armtide team 0 at 14.49 min
 14.82  [Playtest] finished armtide team 0 at 14.82 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +58.7 bank 285/3700, energy +1222.0 bank 3202/4200, units 99
 15.15  [Playtest] finished armatl team 0 at 15.15 min
 15.51  [Playtest] finished armbats team 0 at 15.51 min
 16.00  [Playtest] finished armmex team 0 at 16.00 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +57.8 bank 0/3750, energy +1208.0 bank 3335/4100, units 101
 16.07  [Playtest] finished armuwmme team 0 at 16.07 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +60.8 bank 0/3700, energy +1501.0 bank 4540/5550, units 96
 17.01  [Playtest] finished armuwmme team 0 at 17.01 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +65.7 bank 0/4250, energy +1508.0 bank 4534/5600, units 96
 18.14  [Playtest] finished armuwfus team 0 at 18.14 min
 18.50  [Playtest] finished armnanotcplat team 0 at 18.50 min
 18.54  [Playtest] finished armmex team 0 at 18.54 min
 18.80  [Playtest] finished armmex team 0 at 18.80 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +118.0 bank 38/4250, energy +2708.0 bank 7908/8100, units 106
 19.24  [Playtest] finished armllt team 0 at 19.24 min
 19.72  [Playtest] finished armuwmme team 0 at 19.72 min
 19.74  [Playtest] finished armtl team 0 at 19.74 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +74.0 bank 48/4800, energy +2708.0 bank 7948/8100, units 105
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.01  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
 20.06  [Playtest] finished armmship team 0 at 20.06 min
 20.07  [Playtest] finished armmex team 0 at 20.07 min
 20.38  [Playtest] finished armfrad team 0 at 20.38 min
 20.65  [Playtest] finished armmex team 0 at 20.65 min
 20.82  [Playtest] finished armnanotcplat team 0 at 20.82 min
 20.95  [Playtest] finished armmex team 0 at 20.95 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +80.0 bank 925/4950, energy +2715.0 bank 8032/8150, units 110
 21.06  [Playtest] finished armuwmmm team 0 at 21.06 min
 21.69  [Playtest] finished armfrad team 0 at 21.69 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +89.5 bank 49/4950, energy +2715.0 bank 6817/8150, units 114
 22.03  [Playtest] finished armbats team 0 at 22.03 min
 22.66  [Playtest] finished armuwmmm team 0 at 22.66 min
 22.73  [Playtest] finished armfrad team 0 at 22.73 min
 22.97  [Playtest] finished armuwmmm team 0 at 22.97 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +90.8 bank 57/4950, energy +2715.0 bank 6962/8150, units 117
 23.14  [Playtest] finished armfmkr team 0 at 23.14 min
 23.34  [Playtest] finished armnanotcplat team 0 at 23.34 min
 23.34  [Playtest] finished armbats team 0 at 23.34 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +94.0 bank 53/4950, energy +2708.0 bank 6834/8100, units 120
 25.00  [Playtest] eco team 0 at 25.0 min: metal +94.7 bank 10/4950, energy +2708.0 bank 6844/8100, units 121
 25.30  [Playtest] finished armuwfus team 0 at 25.31 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +111.0 bank 947/4950, energy +3926.5 bank 9951/10700, units 123
 26.10  [Playtest] finished armmex team 0 at 26.10 min
 26.13  [Playtest] finished armfmkr team 0 at 26.13 min
 26.59  [Playtest] finished armatl team 0 at 26.59 min
 26.75  [Playtest] finished armtide team 0 at 26.75 min
 26.95  [Playtest] finished armrad team 0 at 26.95 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +114.0 bank 876/5000, energy +3952.0 bank 9654/10800, units 133
 27.11  [Playtest] finished armtide team 0 at 27.11 min
 27.15  [Playtest] finished armuwmmm team 0 at 27.15 min
 27.24  [Playtest] finished armatl team 0 at 27.24 min
 27.63  [Playtest] finished armnanotcplat team 0 at 27.63 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +116.8 bank 1220/5000, energy +3982.0 bank 9266/10900, units 136
 28.01  [Playtest] finished armatl team 0 at 28.01 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +119.6 bank 2061/4950, energy +3982.0 bank 9411/10900, units 142
 29.00  [Playtest] camera requested (1700,4550) height=4000
 29.01  [Playtest] camera captured name=ta position=(1700,4550) height=4000
 29.01  [Playtest] screenshot at 29.0 min of team 0 at (1700, 4550)
 29.08  [Playtest] finished armmex team 0 at 29.08 min
 29.35  [Playtest] finished armason team 0 at 29.35 min
 29.50  [Playtest] finished armfrad team 0 at 29.50 min
 29.73  [Playtest] finished armfrad team 0 at 29.73 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +107.1 bank 2348/5000, energy +3982.0 bank 9412/10900, units 152
```

## Native lines (all AIs, first 120)

```
  0.09  EXP: approach: corcom(8444) at (1899, 5801) walks to (1900, 5829), 139 from the cormex site (1904, 5968)
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
