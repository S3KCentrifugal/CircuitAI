# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.1 min (frame 54109); wall 213 s
- DLL: build-theatres\d189-build-7\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T08:33:21
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-air-defense\glacial\20261004T113320Z-40b61b26\runs\20261004T113656Z-830c994f\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:29.518798][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.8 min | `[t=00:00:42.680212][f=0001390] [SeaWatch] finished frame=1390 id=9800 def=armsy builder=27123` |
| expect `first-ship-exit` | seen at 3.2 min | `[t=00:00:52.770308][f=0005790] [SeaWatch] egress id=16606 yard=9800 seconds=5.2 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-air-defense\glacial\20261004T113320Z-40b61b26\runs\20261004T113656Z-830c994f\screen_2026-10-04_11-34-25-446.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-air-defense\glacial\20261004T113320Z-40b61b26\runs\20261004T113656Z-830c994f\screen_2026-10-04_11-34-48-340.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-air-defense\glacial\20261004T113320Z-40b61b26\runs\20261004T113656Z-830c994f\screen_2026-10-04_11-35-45-016.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-air-defense\glacial\20261004T113320Z-40b61b26\runs\20261004T113656Z-830c994f\screen_2026-10-04_11-36-48-052.png

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
  0.17  [Team][Roster] first mex 10685 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.18  [Team][Roster] team 2 first mex at 1904,5967
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.77  [Playtest] finished armsy team 0 at 0.77 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 706/1200, energy +30.0 bank 2/1100, units 6
  1.19  [Playtest] finished armmex team 0 at 1.19 min
  1.75  [Playtest] finished armtide team 0 at 1.75 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 931/1250, energy +53.0 bank 65/1150, units 8
  2.11  [Playtest] finished armtide team 0 at 2.11 min
  2.46  [Playtest] finished armtide team 0 at 2.46 min
  2.56  [Playtest] finished armmex team 0 at 2.56 min
  2.76  [Playtest] finished armtide team 0 at 2.76 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 995/1300, energy +136.0 bank 861/1400, units 14
  3.01  [Playtest] finished armtide team 0 at 3.01 min
  3.32  [Playtest] finished armtide team 0 at 3.32 min
  3.88  [Playtest] finished armtl team 0 at 3.88 min
  3.96  [Playtest] finished armmex team 0 at 3.96 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +12.0 bank 895/1350, energy +182.0 bank 1096/1500, units 19
  4.16  [Playtest] finished armmex team 0 at 4.16 min
  4.36  [Playtest] finished armmex team 0 at 4.36 min
  4.47  [Playtest] finished armtide team 0 at 4.47 min
  4.53  [Playtest] finished armmex team 0 at 4.53 min
  4.61  [Playtest] finished armtide team 0 at 4.61 min
  4.77  [Playtest] finished armtide team 0 at 4.77 min
  4.92  [Playtest] finished armtide team 0 at 4.92 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +18.0 bank 480/1500, energy +281.0 bank 1729/1750, units 30
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.01  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.03  [Playtest] finished armmex team 0 at 5.03 min
  5.12  [Playtest] finished armtide team 0 at 5.12 min
  5.20  [Playtest] finished armtide team 0 at 5.20 min
  5.25  [Playtest] finished armmex team 0 at 5.25 min
  5.45  [Playtest] finished armmex team 0 at 5.45 min
  5.62  [Playtest] finished armmex team 0 at 5.62 min
  5.76  [Playtest] finished armtide team 0 at 5.76 min
  5.77  [Playtest] finished armtide team 0 at 5.77 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +26.0 bank 824/1700, energy +380.0 bank 1993/2000, units 39
  6.08  [Playtest] finished armtide team 0 at 6.07 min
  6.18  [Playtest] finished armmex team 0 at 6.18 min
  6.32  [Playtest] finished armtide team 0 at 6.32 min
  6.42  [Playtest] finished armmex team 0 at 6.42 min
  6.42  [Playtest] finished armtide team 0 at 6.42 min
  6.61  [Playtest] finished armmex team 0 at 6.61 min
  6.64  [Playtest] finished armtide team 0 at 6.64 min
  6.78  [Playtest] finished armmex team 0 at 6.78 min
  6.78  [Playtest] finished armnanotcplat team 0 at 6.78 min
  6.95  [Playtest] finished armnanotcplat team 0 at 6.95 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +34.0 bank 1087/1900, energy +472.0 bank 2166/2200, units 48
  7.07  [Playtest] finished armnanotcplat team 0 at 7.07 min
  7.15  [Playtest] finished armtide team 0 at 7.15 min
  7.28  [Playtest] finished armmex team 0 at 7.28 min
  7.44  [Playtest] finished armtide team 0 at 7.44 min
  7.50  [Playtest] finished armtide team 0 at 7.50 min
  7.55  [Playtest] finished armtide team 0 at 7.55 min
  7.62  [Playtest] finished armtide team 0 at 7.62 min
  7.72  [Playtest] finished armtide team 0 at 7.72 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +36.0 bank 90/1950, energy +617.0 bank 2516/2550, units 61
  8.05  [Playtest] finished armfmkr team 0 at 8.05 min
  8.22  [Playtest] finished armtide team 0 at 8.22 min
  8.29  [Playtest] finished armtide team 0 at 8.29 min
  8.43  [Playtest] finished armtide team 0 at 8.43 min
  8.54  [Playtest] finished armtide team 0 at 8.54 min
  8.64  [Playtest] finished armtide team 0 at 8.64 min
  8.66  [Playtest] finished armfmkr team 0 at 8.66 min
  8.66  [Playtest] finished armtide team 0 at 8.66 min
  8.98  [Playtest] finished armtide team 0 at 8.98 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +38.0 bank 16/1950, energy +755.0 bank 2838/2900, units 73
  9.14  [Playtest] finished armfmkr team 0 at 9.14 min
  9.16  [Playtest] finished armfmkr team 0 at 9.16 min
  9.16  [Playtest] finished armtide team 0 at 9.16 min
  9.24  [Playtest] finished armtide team 0 at 9.24 min
  9.30  [Playtest] finished armtide team 0 at 9.30 min
  9.41  [Playtest] finished armfmkr team 0 at 9.41 min
  9.52  [Playtest] finished armtide team 0 at 9.52 min
  9.55  [Playtest] finished armfmkr team 0 at 9.55 min
  9.62  [Playtest] finished armtide team 0 at 9.63 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +42.0 bank 1043/1950, energy +900.0 bank 3086/3200, units 83
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.02  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.07  [Playtest] finished armtide team 0 at 10.07 min
 10.24  [Playtest] finished armtide team 0 at 10.24 min
 10.39  [Playtest] finished armfmkr team 0 at 10.39 min
 10.40  [Playtest] finished armtide team 0 at 10.40 min
 10.40  [Playtest] finished armfmkr team 0 at 10.40 min
 10.51  [Playtest] finished armtide team 0 at 10.51 min
 10.56  [Playtest] finished armtide team 0 at 10.56 min
 10.76  [Playtest] finished armtide team 0 at 10.76 min
 10.83  [Playtest] finished armfmkr team 0 at 10.83 min
 10.85  [Playtest] finished armtide team 0 at 10.85 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +45.0 bank 1949/1950, energy +1061.0 bank 3418/3550, units 91
 11.18  [Playtest] finished armtide team 0 at 11.18 min
 11.19  [Playtest] finished armfmkr team 0 at 11.19 min
 11.19  [Playtest] finished armtide team 0 at 11.19 min
 11.29  [Playtest] finished armtide team 0 at 11.28 min
 11.50  [Playtest] finished armtide team 0 at 11.50 min
 11.58  [Playtest] finished armtide team 0 at 11.58 min
 11.79  [Playtest] finished armtide team 0 at 11.79 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +46.0 bank 0/1950, energy +1199.0 bank 3720/3850, units 98
 12.01  [Playtest] finished armfmkr team 0 at 12.01 min
 12.06  [Playtest] finished armasy team 0 at 12.06 min
 12.37  [Playtest] finished armtide team 0 at 12.37 min
 12.56  [Playtest] finished armtide team 0 at 12.56 min
 12.59  [Playtest] finished armfmkr team 0 at 12.59 min
 12.70  [Playtest] finished armtide team 0 at 12.70 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +48.0 bank 17/2150, energy +1298.0 bank 4041/4350, units 106
 13.20  [Playtest] finished armmex team 0 at 13.20 min
 13.30  [Playtest] finished armtide team 0 at 13.30 min
 13.41  [Playtest] finished armuwmme team 0 at 13.41 min
 13.50  [Playtest] finished armfmkr team 0 at 13.50 min
 13.84  [Playtest] finished armfmkr team 0 at 13.84 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +54.0 bank 0/2650, energy +1344.0 bank 3937/4500, units 106
 14.06  [Playtest] finished armmex team 0 at 14.06 min
 14.22  [Playtest] finished armuwmme team 0 at 14.22 min
 14.61  [Playtest] finished armuwmme team 0 at 14.61 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +62.6 bank 4/3750, energy +1330.0 bank 3631/4400, units 102
 15.03  [Playtest] finished armllt team 0 at 15.03 min
 15.09  [Playtest] finished armbats team 0 at 15.09 min
 15.84  [Playtest] finished armtl team 0 at 15.84 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +64.9 bank 91/3750, energy +1293.0 bank 3490/4150, units 100
 17.00  [Playtest] eco team 0 at 17.0 min: metal +64.3 bank 0/3750, energy +1323.0 bank 3599/4350, units 100
 17.41  [Playtest] finished armmex team 0 at 17.41 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +61.3 bank 0/3800, energy +1316.0 bank 3486/4300, units 101
 18.34  [Playtest] finished armuwfus team 0 at 18.34 min
 18.91  [Playtest] finished armtide team 0 at 18.91 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +64.0 bank 107/3750, energy +2454.0 bank 6543/6650, units 94
 19.68  [Playtest] finished armmex team 0 at 19.68 min
 19.85  [Playtest] finished armfrad team 0 at 19.85 min
 19.93  [Playtest] finished armllt team 0 at 19.93 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +60.0 bank 424/3800, energy +2109.0 bank 5885/5950, units 74
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.01  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
 20.66  [Playtest] finished armrl team 0 at 20.66 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +26.0 bank 1598/1600, energy +1651.0 bank 4469/4500, units 36
 21.09  [Playtest] finished armuwmmm team 0 at 21.09 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +26.0 bank 1589/1600, energy +60.0 bank 1073/1150, units 19
 22.05  [Playtest] finished cormex team 0 at 22.05 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +11.0 bank 1100/1100, energy +0.0 bank 1/500, units 15
 24.00  [Playtest] eco team 0 at 24.0 min: metal +10.0 bank 1100/1100, energy +0.0 bank 0/500, units 15
 25.00  [Playtest] eco team 0 at 25.0 min: metal +9.0 bank 1100/1100, energy +0.0 bank 1/500, units 15
 26.00  [Playtest] eco team 0 at 26.0 min: metal +9.0 bank 1100/1100, energy +0.0 bank 1/500, units 15
 27.00  [Playtest] eco team 0 at 27.0 min: metal +9.0 bank 1100/1100, energy +0.0 bank 1/500, units 15
 28.00  [Playtest] eco team 0 at 28.0 min: metal +9.0 bank 1100/1100, energy +0.0 bank 1/500, units 15
 29.00  [Playtest] eco team 0 at 29.0 min: metal +9.0 bank 1100/1100, energy +0.0 bank 1/500, units 15
 29.00  [Playtest] camera requested (1700,4550) height=4000
 29.02  [Playtest] camera captured name=ta position=(1700,4550) height=4000
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (1700, 4550)
 30.00  [Playtest] eco team 0 at 30.0 min: metal +0.0 bank 1089/1100, energy +0.0 bank 1/500, units 15
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
