# Playtest report: PASS

- Verdict: **PASS** (reached 20 min)
- Game time reached: 20.0 min (frame 36021); wall 137 s
- DLL: build-theatres\d190-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T11:03:59
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d190-dense\glacial\20261004T140359Z-3222d969\runs\20261004T140619Z-3cd1a8c3\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:28.063703][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.0 min | `[t=00:00:42.302717][f=0001883] [SeaWatch] finished frame=1883 id=1973 def=armsy builder=27123` |
| expect `first-ship-exit` | seen at 3.1 min | `[t=00:00:50.520340][f=0005580] [SeaWatch] egress id=13308 yard=1973 seconds=4.5 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d190-dense\glacial\20261004T140359Z-3222d969\runs\20261004T140619Z-3cd1a8c3\screen_2026-10-04_14-05-02-012.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d190-dense\glacial\20261004T140359Z-3222d969\runs\20261004T140619Z-3cd1a8c3\screen_2026-10-04_14-05-23-805.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d190-dense\glacial\20261004T140359Z-3222d969\runs\20261004T140619Z-3cd1a8c3\screen_2026-10-04_14-06-18-585.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 20.5 min
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
  0.17  [Team][Roster] first mex 10685 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.18  [Team][Roster] team 2 first mex at 1904,5967
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 802/1100, energy +30.0 bank 514/1000, units 4
  1.05  [Playtest] finished armsy team 0 at 1.05 min
  1.47  [Playtest] finished armtide team 0 at 1.47 min
  1.76  [Playtest] finished armmex team 0 at 1.76 min
  1.91  [Playtest] finished armtide team 0 at 1.91 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 725/1250, energy +76.0 bank 106/1200, units 8
  2.26  [Playtest] finished armmex team 0 at 2.26 min
  2.54  [Playtest] finished armtide team 0 at 2.54 min
  2.71  [Playtest] finished armtide team 0 at 2.71 min
  2.90  [Playtest] finished armtide team 0 at 2.90 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 844/1300, energy +159.0 bank 1080/1450, units 15
  3.31  [Playtest] finished armfrad team 0 at 3.31 min
  3.70  [Playtest] finished armtide team 0 at 3.70 min
  3.74  [Playtest] finished armnanotcplat team 0 at 3.74 min
  3.85  [Playtest] finished armmex team 0 at 3.85 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +12.0 bank 12/1350, energy +182.0 bank 883/1500, units 23
  4.10  [Playtest] finished armmex team 0 at 4.10 min
  4.22  [Playtest] finished armtide team 0 at 4.22 min
  4.28  [Playtest] finished armtide team 0 at 4.28 min
  4.35  [Playtest] finished armmex team 0 at 4.35 min
  4.57  [Playtest] finished armmex team 0 at 4.57 min
  4.68  [Playtest] finished armtide team 0 at 4.68 min
  4.94  [Playtest] finished armtide team 0 at 4.94 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +18.0 bank 7/1500, energy +274.0 bank 1689/1700, units 31
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.00  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.07  [Playtest] finished armmex team 0 at 5.07 min
  5.25  [Playtest] finished armtide team 0 at 5.25 min
  5.29  [Playtest] finished armmex team 0 at 5.29 min
  5.33  [Playtest] finished armtide team 0 at 5.33 min
  5.49  [Playtest] finished armmex team 0 at 5.49 min
  5.66  [Playtest] finished armmex team 0 at 5.66 min
  5.71  [Playtest] finished armtide team 0 at 5.71 min
  5.91  [Playtest] finished armtide team 0 at 5.91 min
  5.98  [Playtest] finished armfmkr team 0 at 5.98 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +27.0 bank 219/1700, energy +366.0 bank 1835/1900, units 41
  6.21  [Playtest] finished armtide team 0 at 6.21 min
  6.22  [Playtest] finished armmex team 0 at 6.22 min
  6.34  [Playtest] finished armfmkr team 0 at 6.34 min
  6.45  [Playtest] finished armmex team 0 at 6.45 min
  6.50  [Playtest] finished armtide team 0 at 6.50 min
  6.58  [Playtest] finished armfmkr team 0 at 6.58 min
  6.67  [Playtest] finished armtide team 0 at 6.67 min
  6.94  [Playtest] finished armfmkr team 0 at 6.94 min
  6.98  [Playtest] finished armtide team 0 at 6.98 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +31.5 bank 140/1800, energy +435.0 bank 1642/2100, units 49
  7.17  [Playtest] finished armfmkr team 0 at 7.17 min
  7.42  [Playtest] finished armfmkr team 0 at 7.41 min
  7.67  [Playtest] finished armfmkr team 0 at 7.67 min
  7.92  [Playtest] finished armtide team 0 at 7.92 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +32.8 bank 1009/1800, energy +488.0 bank 1748/2200, units 58
  8.07  [Playtest] finished armtide team 0 at 8.07 min
  8.25  [Playtest] finished armtide team 0 at 8.25 min
  8.39  [Playtest] finished armtide team 0 at 8.39 min
  8.57  [Playtest] finished armfmkr team 0 at 8.57 min
  8.57  [Playtest] finished armtide team 0 at 8.57 min
  8.64  [Playtest] finished armtide team 0 at 8.65 min
  8.92  [Playtest] finished armnanotcplat team 0 at 8.92 min
  8.97  [Playtest] finished armtide team 0 at 8.97 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +32.0 bank 1076/1800, energy +626.0 bank 1955/2500, units 68
  9.22  [Playtest] finished armfmkr team 0 at 9.22 min
  9.23  [Playtest] finished armtide team 0 at 9.23 min
  9.55  [Playtest] finished armtide team 0 at 9.55 min
  9.63  [Playtest] finished armtide team 0 at 9.63 min
  9.82  [Playtest] finished armtide team 0 at 9.82 min
  9.87  [Playtest] finished armtide team 0 at 9.87 min
  9.94  [Playtest] finished armtide team 0 at 9.94 min
  9.98  [Playtest] finished armtide team 0 at 9.98 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +38.4 bank 547/1800, energy +778.0 bank 2478/2950, units 75
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.02  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.27  [Playtest] finished armfmkr team 0 at 10.27 min
 10.33  [Playtest] finished armtide team 0 at 10.33 min
 10.41  [Playtest] finished armtide team 0 at 10.41 min
 10.59  [Playtest] finished armtide team 0 at 10.59 min
 10.60  [Playtest] finished armtide team 0 at 10.60 min
 10.70  [Playtest] finished armfmkr team 0 at 10.70 min
 10.78  [Playtest] finished armmex team 0 at 10.78 min
 10.90  [Playtest] finished armtide team 0 at 10.90 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +43.0 bank 1528/1850, energy +916.0 bank 3069/3200, units 79
 11.02  [Playtest] finished armtide team 0 at 11.02 min
 11.36  [Playtest] finished armtide team 0 at 11.36 min
 11.37  [Playtest] finished armtide team 0 at 11.37 min
 11.38  [Playtest] finished armtide team 0 at 11.38 min
 11.42  [Playtest] finished armmex team 0 at 11.42 min
 11.56  [Playtest] finished armtide team 0 at 11.56 min
 11.81  [Playtest] finished armfmkr team 0 at 11.81 min
 11.81  [Playtest] finished armtide team 0 at 11.81 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +41.2 bank 781/1900, energy +1054.0 bank 2876/3500, units 89
 12.10  [Playtest] finished armmex team 0 at 12.10 min
 12.19  [Playtest] finished armtide team 0 at 12.19 min
 12.44  [Playtest] finished armmex team 0 at 12.44 min
 12.51  [Playtest] finished armtide team 0 at 12.51 min
 12.59  [Playtest] finished armtide team 0 at 12.59 min
 12.79  [Playtest] finished armfrad team 0 at 12.79 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +50.0 bank 0/2000, energy +1123.0 bank 3304/3650, units 95
 13.22  [Playtest] finished armasy team 0 at 13.22 min
 13.26  [Playtest] finished armtide team 0 at 13.26 min
 13.32  [Playtest] finished armtide team 0 at 13.32 min
 13.72  [Playtest] finished armtide team 0 at 13.72 min
 13.75  [Playtest] finished armtide team 0 at 13.75 min
 13.81  [Playtest] finished armllt team 0 at 13.81 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +45.6 bank 12/2100, energy +1238.0 bank 3449/4150, units 98
 14.59  [Playtest] finished armtide team 0 at 14.59 min
 14.61  [Playtest] finished armuwmme team 0 at 14.61 min
 14.66  [Playtest] finished armtide team 0 at 14.66 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +45.0 bank 0/2550, energy +1307.0 bank 3574/4350, units 97
 15.60  [Playtest] finished armuwmme team 0 at 15.60 min
 15.73  [Playtest] finished armuwmme team 0 at 15.73 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +56.0 bank 6/3650, energy +1307.0 bank 3508/4350, units 97
 16.50  [Playtest] finished armuwmme team 0 at 16.50 min
 16.67  [Playtest] finished armnanotcplat team 0 at 16.67 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +65.4 bank 92/4200, energy +1307.0 bank 3820/4350, units 95
 17.54  [Playtest] finished armbats team 0 at 17.54 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +57.3 bank 513/4200, energy +1109.0 bank 2979/3850, units 88
 18.22  [Playtest] finished armnanotcplat team 0 at 18.22 min
 18.45  [Playtest] finished armtide team 0 at 18.44 min
 18.58  [Playtest] finished armtide team 0 at 18.58 min
 18.71  [Playtest] finished armtide team 0 at 18.71 min
 18.90  [Playtest] finished armtide team 0 at 18.90 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +63.1 bank 3/4200, energy +1208.0 bank 3383/4100, units 96
 20.00  [Playtest] eco team 0 at 20.0 min: metal +62.3 bank 0/4200, energy +1363.0 bank 4317/5250, units 84
 20.00  [Playtest] camera requested (1700,4550) height=3800
```

## Native lines (all AIs, first 120)

```
  0.09  EXP: approach: corcom(8444) at (1899, 5801) walks to (1900, 5829), 139 from the cormex site (1904, 5968)
  0.10  RESERVE: zone 1 at (1424, 4000) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (1424, 4000) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (1712, 4000) facing 1, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (1128, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1128, 4104) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (1128, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1128, 4056) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (1128, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1128, 4008) facing 1 (id 4)
  0.10  RESERVE: zone 6 at (1128, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1128, 3960) facing 1 (id 5)
  0.10  RESERVE: zone 7 at (1128, 3912) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1128, 3912) facing 1 (id 6)
  0.10  RESERVE: zone 8 at (1176, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1176, 4104) facing 1 (id 7)
  0.10  RESERVE: zone 9 at (1176, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1176, 4056) facing 1 (id 8)
  0.10  RESERVE: zone 10 at (1176, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1176, 4008) facing 1 (id 9)
  0.10  RESERVE: zone 11 at (1176, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1176, 3960) facing 1 (id 10)
  0.10  RESERVE: zone 12 at (1176, 3912) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1176, 3912) facing 1 (id 11)
  0.10  RESERVE: zone 13 at (1224, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1224, 4104) facing 1 (id 12)
  0.10  RESERVE: zone 14 at (1224, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1224, 4056) facing 1 (id 13)
  0.10  RESERVE: zone 15 at (1224, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1224, 4008) facing 1 (id 14)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 released
  0.10  RESERVE: zone 6 released
  0.10  RESERVE: zone 7 released
  0.10  RESERVE: zone 8 released
  0.10  RESERVE: zone 9 released
  0.10  RESERVE: zone 10 released
  0.10  RESERVE: zone 11 released
  0.10  RESERVE: zone 12 released
  0.10  RESERVE: zone 13 released
  0.10  RESERVE: zone 14 released
  0.10  RESERVE: zone 15 released
  0.10  RESERVE: zone 16 at (1224, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1224, 4104) facing 1 (id 15)
  0.10  RESERVE: zone 17 at (1224, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1224, 4056) facing 1 (id 16)
  0.10  RESERVE: zone 18 at (1224, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1224, 4008) facing 1 (id 17)
  0.10  RESERVE: zone 16 released
  0.10  RESERVE: zone 17 released
  0.10  RESERVE: zone 18 released
  0.10  RESERVE: zone 19 at (1224, 4136) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1224, 4136) facing 1 (id 18)
  0.10  RESERVE: zone 20 at (1224, 4088) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1224, 4088) facing 1 (id 19)
  0.10  RESERVE: zone 21 at (1224, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1224, 4040) facing 1 (id 20)
  0.10  RESERVE: zone 22 at (1224, 3992) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1224, 3992) facing 1 (id 21)
  0.10  RESERVE: zone 19 released
  0.10  RESERVE: zone 20 released
  0.10  RESERVE: zone 21 released
  0.10  RESERVE: zone 22 released
  0.10  RESERVE: zone 23 at (1192, 4168) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1192, 4168) facing 1 (id 22)
  0.10  RESERVE: zone 24 at (1192, 4120) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1192, 4120) facing 1 (id 23)
  0.10  RESERVE: zone 25 at (1192, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1192, 4072) facing 1 (id 24)
  0.10  RESERVE: zone 26 at (1192, 4024) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1192, 4024) facing 1 (id 25)
  0.10  RESERVE: zone 27 at (1192, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1192, 3976) facing 1 (id 26)
  0.10  RESERVE: zone 28 at (1240, 4168) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1240, 4168) facing 1 (id 27)
  0.10  RESERVE: zone 29 at (1240, 4120) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1240, 4120) facing 1 (id 28)
  0.10  RESERVE: zone 30 at (1240, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1240, 4072) facing 1 (id 29)
  0.10  RESERVE: zone 31 at (1240, 4024) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1240, 4024) facing 1 (id 30)
  0.10  RESERVE: zone 32 at (1240, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1240, 3976) facing 1 (id 31)
  0.10  RESERVE: zone 33 at (1288, 4168) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1288, 4168) facing 1 (id 32)
  0.10  RESERVE: zone 34 at (1288, 4120) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1288, 4120) facing 1 (id 33)
  0.10  RESERVE: zone 35 at (1288, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1288, 4072) facing 1 (id 34)
  0.10  RESERVE: zone 36 at (1288, 4024) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1288, 4024) facing 1 (id 35)
  0.10  RESERVE: zone 37 at (1288, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1288, 3976) facing 1 (id 36)
  0.10  RESERVE: zone 38 at (1336, 4168) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1336, 4168) facing 1 (id 37)
  0.10  RESERVE: zone 39 at (1336, 4120) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1336, 4120) facing 1 (id 38)
  0.10  RESERVE: zone 40 at (1336, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1336, 4072) facing 1 (id 39)
  0.10  RESERVE: zone 41 at (1336, 4024) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1336, 4024) facing 1 (id 40)
  0.10  RESERVE: zone 42 at (1336, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1336, 3976) facing 1 (id 41)
  0.10  RESERVE: zone 1 at (704, 4592) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (704, 4592) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (992, 4592) facing 1, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (408, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (408, 4696) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (408, 4648) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (408, 4648) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (408, 4600) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (408, 4600) facing 1 (id 4)
  0.10  RESERVE: zone 6 at (408, 4552) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (408, 4552) facing 1 (id 5)
  0.10  RESERVE: zone 7 at (408, 4504) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (408, 4504) facing 1 (id 6)
  0.10  RESERVE: zone 8 at (456, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (456, 4696) facing 1 (id 7)
  0.10  RESERVE: zone 9 at (456, 4648) facing 1, 3x3 cells: 9 of 9 held
```
