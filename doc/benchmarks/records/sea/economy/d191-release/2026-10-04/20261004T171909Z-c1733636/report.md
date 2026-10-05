# Playtest report: PASS

- Verdict: **PASS** (reached 20 min)
- Game time reached: 20.0 min (frame 36002); wall 221 s
- DLL: build-theatres\d191-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T14:15:25
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-release\glacial\20261004T171525Z-30011357\runs\20261004T171909Z-c1733636\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:37.793133][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.3 min | `[t=00:01:03.797207][f=0002362] [SeaWatch] finished frame=2362 id=29073 def=armsy builder=27123` |
| expect `first-ship-exit` | seen at 2.3 min | `[t=00:01:08.496171][f=0004200] [SeaWatch] egress id=17733 yard=29073 seconds=4.8 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-release\glacial\20261004T171525Z-30011357\runs\20261004T171909Z-c1733636\screen_2026-10-04_17-16-57-216.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-release\glacial\20261004T171525Z-30011357\runs\20261004T171909Z-c1733636\screen_2026-10-04_17-17-32-460.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-release\glacial\20261004T171525Z-30011357\runs\20261004T171909Z-c1733636\screen_2026-10-04_17-19-08-436.png

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
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(716,4607) factory=armsy landLocked=no spot=5 known=1/2
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(1899,5801) factory=corsy landLocked=no spot=6 known=2/2
  0.16  [Playtest] finished armmex team 0 at 0.16 min
  0.17  [Team][Roster] first mex 24679 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.18  [Team][Roster] team 2 first mex at 1904,5967
  0.29  [Playtest] finished armmex team 0 at 0.29 min
  0.43  [Playtest] finished armmex team 0 at 0.43 min
  0.75  [Playtest] finished armtide team 0 at 0.75 min
  0.87  [Team][Roster] team 1 first mex at 544,4608
  0.90  [Playtest] finished armtide team 0 at 0.90 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 1049/1150, energy +76.0 bank 1013/1100, units 6
  1.31  [Playtest] finished armsy team 0 at 1.31 min
  1.97  [Playtest] finished armtide team 0 at 1.97 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 615/1250, energy +106.0 bank 1/1300, units 10
  2.19  [Playtest] finished armtide team 0 at 2.18 min
  2.37  [Playtest] finished armtide team 0 at 2.37 min
  2.56  [Playtest] finished armtide team 0 at 2.56 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 0/1250, energy +182.0 bank 1500/1500, units 19
  3.02  [Playtest] finished armtide team 0 at 3.02 min
  3.32  [Playtest] finished armmex team 0 at 3.32 min
  3.37  [Playtest] finished armtide team 0 at 3.37 min
  3.67  [Playtest] finished armtide team 0 at 3.67 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 14/1300, energy +251.0 bank 1637/1650, units 24
  4.17  [Playtest] finished armmex team 0 at 4.18 min
  4.20  [Playtest] finished armfmkr team 0 at 4.20 min
  4.40  [Playtest] finished armmex team 0 at 4.40 min
  4.44  [Playtest] finished armfmkr team 0 at 4.44 min
  4.62  [Playtest] finished armmex team 0 at 4.62 min
  4.74  [Playtest] finished armfmkr team 0 at 4.74 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +19.0 bank 183/1450, energy +251.0 bank 1496/1650, units 29
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.01  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.14  [Playtest] finished armfmkr team 0 at 5.14 min
  5.51  [Playtest] finished armfmkr team 0 at 5.51 min
  5.75  [Playtest] finished armfmkr team 0 at 5.75 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +18.1 bank 839/1450, energy +258.0 bank 1338/1700, units 32
  6.11  [Playtest] finished armfmkr team 0 at 6.11 min
  6.42  [Playtest] finished armtide team 0 at 6.42 min
  6.61  [Playtest] finished armtide team 0 at 6.61 min
  6.75  [Playtest] finished armfmkr team 0 at 6.75 min
  6.99  [Playtest] finished armfmkr team 0 at 6.99 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +17.3 bank 1351/1450, energy +304.0 bank 1463/1800, units 39
  7.06  [Playtest] finished armfmkr team 0 at 7.06 min
  7.31  [Playtest] finished armtide team 0 at 7.31 min
  7.50  [Playtest] finished armfmkr team 0 at 7.50 min
  7.68  [Playtest] finished armtide team 0 at 7.68 min
  7.95  [Playtest] finished armtide team 0 at 7.95 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +21.5 bank 1321/1450, energy +373.0 bank 1582/1950, units 45
  8.10  [Playtest] finished armtide team 0 at 8.10 min
  8.25  [Playtest] finished armtide team 0 at 8.25 min
  8.63  [Playtest] finished armfmkr team 0 at 8.63 min
  8.90  [Playtest] finished armtide team 0 at 8.90 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +19.9 bank 1330/1450, energy +449.0 bank 1746/2150, units 50
  9.02  [Playtest] finished armtide team 0 at 9.02 min
  9.22  [Playtest] finished armtide team 0 at 9.22 min
  9.58  [Playtest] finished armnanotcplat team 0 at 9.58 min
  9.68  [Playtest] finished armfmkr team 0 at 9.68 min
  9.81  [Playtest] finished armtide team 0 at 9.81 min
  9.88  [Playtest] finished armfmkr team 0 at 9.89 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +19.5 bank 743/1450, energy +518.0 bank 1825/2300, units 57
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.01  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.14  [Playtest] finished armtide team 0 at 10.14 min
 10.16  [Playtest] finished armfrad team 0 at 10.16 min
 10.30  [Playtest] finished armtide team 0 at 10.30 min
 10.50  [Playtest] finished armfmkr team 0 at 10.50 min
 10.50  [Playtest] finished armtl team 0 at 10.50 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +20.2 bank 410/1450, energy +564.0 bank 1952/2400, units 66
 11.14  [Playtest] finished armtide team 0 at 11.14 min
 11.23  [Playtest] finished armfmkr team 0 at 11.23 min
 11.45  [Playtest] finished armmex team 0 at 11.45 min
 11.48  [Playtest] finished armtide team 0 at 11.48 min
 11.58  [Playtest] finished armmex team 0 at 11.58 min
 11.68  [Playtest] finished armfmkr team 0 at 11.68 min
 11.74  [Playtest] finished armfrad team 0 at 11.74 min
 11.80  [Playtest] finished armtide team 0 at 11.80 min
 11.97  [Playtest] finished armtl team 0 at 11.97 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +27.2 bank 304/1550, energy +633.0 bank 2155/2550, units 75
 12.01  [Playtest] finished armtide team 0 at 12.01 min
 12.25  [Playtest] finished armmex team 0 at 12.25 min
 12.65  [Playtest] finished armfmkr team 0 at 12.65 min
 12.75  [Playtest] finished armmex team 0 at 12.75 min
 12.95  [Playtest] finished armtide team 0 at 12.95 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +32.7 bank 593/1650, energy +679.0 bank 2210/2650, units 78
 13.11  [Playtest] finished armmex team 0 at 13.11 min
 13.17  [Playtest] finished armmex team 0 at 13.17 min
 13.50  [Playtest] finished armtl team 0 at 13.50 min
 13.55  [Playtest] finished armmex team 0 at 13.56 min
 13.63  [Playtest] finished armtide team 0 at 13.63 min
 13.86  [Playtest] finished armfmkr team 0 at 13.86 min
 13.97  [Playtest] finished armtide team 0 at 13.98 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +33.3 bank 763/1750, energy +713.5 bank 2240/2750, units 83
 14.16  [Playtest] finished armmex team 0 at 14.16 min
 14.19  [Playtest] finished armtide team 0 at 14.19 min
 14.56  [Playtest] finished armmex team 0 at 14.56 min
 14.60  [Playtest] finished armtide team 0 at 14.60 min
 14.80  [Playtest] finished armtide team 0 at 14.80 min
 14.98  [Playtest] finished armtide team 0 at 14.98 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +40.8 bank 1131/1850, energy +805.5 bank 2494/2950, units 88
 15.18  [Playtest] finished armtl team 0 at 15.18 min
 15.36  [Playtest] finished armtide team 0 at 15.36 min
 15.46  [Playtest] finished armfmkr team 0 at 15.46 min
 15.57  [Playtest] finished armtide team 0 at 15.57 min
 15.71  [Playtest] finished armmex team 0 at 15.71 min
 15.79  [Playtest] finished armtide team 0 at 15.79 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +40.6 bank 1501/1900, energy +893.0 bank 2568/3150, units 93
 16.03  [Playtest] finished armnanotcplat team 0 at 16.03 min
 16.26  [Playtest] finished armnanotcplat team 0 at 16.26 min
 16.42  [Playtest] finished armfmkr team 0 at 16.42 min
 16.51  [Playtest] finished armtide team 0 at 16.51 min
 16.52  [Playtest] finished armfmkr team 0 at 16.52 min
 16.85  [Playtest] finished armtide team 0 at 16.85 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +43.4 bank 417/1900, energy +946.0 bank 2569/3300, units 104
 17.56  [Playtest] finished armasy team 0 at 17.56 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +35.8 bank 0/1900, energy +946.0 bank 2863/3500, units 92
 18.48  [Playtest] finished armtide team 0 at 18.48 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +35.7 bank 20/1850, energy +994.0 bank 3053/3600, units 87
 20.00  [Playtest] eco team 0 at 20.0 min: metal +30.6 bank 23/1200, energy +872.0 bank 2388/2900, units 78
 20.00  [Playtest] camera requested (1700,4550) height=3800
```

## Native lines (all AIs, first 120)

```
  0.43  RESERVE: zone 1 at (14040, 4632) facing 3, 3x3 cells: 9 of 9 held
  0.43  RESERVE: armtide at (14040, 4632) facing 3 (id 1)
  0.43  RESERVE: zone 2 at (14040, 4680) facing 3, 3x3 cells: 9 of 9 held
  0.43  RESERVE: armtide at (14040, 4680) facing 3 (id 2)
  0.43  RESERVE: zone 3 at (14040, 4728) facing 3, 3x3 cells: 9 of 9 held
  0.43  RESERVE: armtide at (14040, 4728) facing 3 (id 3)
  0.43  RESERVE: zone 4 at (13992, 4632) facing 3, 3x3 cells: 9 of 9 held
  0.43  RESERVE: armtide at (13992, 4632) facing 3 (id 4)
  0.43  RESERVE: zone 5 at (13992, 4680) facing 3, 3x3 cells: 9 of 9 held
  0.43  RESERVE: armtide at (13992, 4680) facing 3 (id 5)
  0.43  RESERVE: zone 6 at (13992, 4728) facing 3, 3x3 cells: 9 of 9 held
  0.43  RESERVE: armtide at (13992, 4728) facing 3 (id 6)
  0.43  RESERVE: served armtide at (14040, 4632) facing 3 (id 1, 5 of this def still held)
  0.44  RESERVE: zone 1 at (1016, 4136) facing 1, 3x3 cells: 9 of 9 held
  0.44  RESERVE: armtide at (1016, 4136) facing 1 (id 1)
  0.44  RESERVE: zone 2 at (1016, 4088) facing 1, 3x3 cells: 9 of 9 held
  0.44  RESERVE: armtide at (1016, 4088) facing 1 (id 2)
  0.44  RESERVE: zone 3 at (1016, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.44  RESERVE: armtide at (1016, 4040) facing 1 (id 3)
  0.44  RESERVE: zone 4 at (1064, 4136) facing 1, 3x3 cells: 9 of 9 held
  0.44  RESERVE: armtide at (1064, 4136) facing 1 (id 4)
  0.44  RESERVE: zone 5 at (1064, 4088) facing 1, 3x3 cells: 9 of 9 held
  0.44  RESERVE: armtide at (1064, 4088) facing 1 (id 5)
  0.44  RESERVE: zone 6 at (1064, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.44  RESERVE: armtide at (1064, 4040) facing 1 (id 6)
  0.44  RESERVE: served armtide at (1016, 4136) facing 1 (id 1, 5 of this def still held)
  0.47  RESERVE: zone 1 at (312, 4744) facing 1, 3x3 cells: 9 of 9 held
  0.47  RESERVE: armtide at (312, 4744) facing 1 (id 1)
  0.47  RESERVE: zone 2 at (312, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.47  RESERVE: armtide at (312, 4696) facing 1 (id 2)
  0.47  RESERVE: zone 3 at (312, 4648) facing 1, 3x3 cells: 9 of 9 held
  0.47  RESERVE: armtide at (312, 4648) facing 1 (id 3)
  0.47  RESERVE: zone 4 at (360, 4744) facing 1, 3x3 cells: 9 of 9 held
  0.47  RESERVE: armtide at (360, 4744) facing 1 (id 4)
  0.47  RESERVE: zone 5 at (360, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.47  RESERVE: armtide at (360, 4696) facing 1 (id 5)
  0.47  RESERVE: zone 6 at (360, 4648) facing 1, 3x3 cells: 9 of 9 held
  0.47  RESERVE: armtide at (360, 4648) facing 1 (id 6)
  0.47  RESERVE: served armtide at (312, 4744) facing 1 (id 1, 5 of this def still held)
  0.49  RESERVE: zone 1 at (13256, 4040) facing 3, 3x3 cells: 9 of 9 held
  0.49  RESERVE: legtide at (13256, 4040) facing 3 (id 1)
  0.49  RESERVE: zone 2 at (13256, 4088) facing 3, 3x3 cells: 9 of 9 held
  0.49  RESERVE: legtide at (13256, 4088) facing 3 (id 2)
  0.49  RESERVE: zone 3 at (13256, 4136) facing 3, 3x3 cells: 9 of 9 held
  0.49  RESERVE: legtide at (13256, 4136) facing 3 (id 3)
  0.49  RESERVE: zone 4 at (13208, 4040) facing 3, 3x3 cells: 9 of 9 held
  0.49  RESERVE: legtide at (13208, 4040) facing 3 (id 4)
  0.49  RESERVE: zone 5 at (13208, 4088) facing 3, 3x3 cells: 9 of 9 held
  0.49  RESERVE: legtide at (13208, 4088) facing 3 (id 5)
  0.49  RESERVE: zone 6 at (13208, 4136) facing 3, 3x3 cells: 9 of 9 held
  0.49  RESERVE: legtide at (13208, 4136) facing 3 (id 6)
  0.49  RESERVE: served legtide at (13256, 4040) facing 3 (id 1, 5 of this def still held)
  0.72  RESERVE: served armtide at (14040, 4680) facing 3 (id 2, 4 of this def still held)
  0.72  RESERVE: armtide at (312, 4744) is being reclaimed: its slot will be freed (id 1)
  0.76  RESERVE: served armtide at (1016, 4088) facing 1 (id 2, 4 of this def still held)
  0.76  RESERVE: served legtide at (13256, 4088) facing 3 (id 2, 4 of this def still held)
  1.15  BUILDER: discarded 4 unused default task(s) in the last minute
  1.17  RESERVE: zone 7 at (14184, 4872) facing 3, 3x3 cells: 9 of 9 held
  1.17  RESERVE: armnanotcplat at (14184, 4872) facing 3 (id 7)
  1.17  RESERVE: zone 8 at (14184, 4920) facing 3, 3x3 cells: 9 of 9 held
  1.17  RESERVE: armnanotcplat at (14184, 4920) facing 3 (id 8)
  1.17  RESERVE: zone 9 at (14184, 4968) facing 3, 3x3 cells: 9 of 9 held
  1.17  RESERVE: armnanotcplat at (14184, 4968) facing 3 (id 9)
  1.17  RESERVE: zone 10 at (14184, 5016) facing 3, 3x3 cells: 9 of 9 held
  1.17  RESERVE: armnanotcplat at (14184, 5016) facing 3 (id 10)
  1.17  RESERVE: zone 7 released
  1.17  RESERVE: zone 8 released
  1.17  RESERVE: zone 9 released
  1.17  RESERVE: zone 10 released
  1.17  RESERVE: zone 11 at (14104, 4856) facing 3, 3x3 cells: 9 of 9 held
  1.17  RESERVE: armnanotcplat at (14104, 4856) facing 3 (id 11)
  1.17  RESERVE: zone 12 at (14104, 4904) facing 3, 3x3 cells: 9 of 9 held
  1.17  RESERVE: armnanotcplat at (14104, 4904) facing 3 (id 12)
  1.17  RESERVE: zone 13 at (14104, 4952) facing 3, 3x3 cells: 9 of 9 held
  1.17  RESERVE: armnanotcplat at (14104, 4952) facing 3 (id 13)
  1.17  RESERVE: zone 14 at (14104, 5000) facing 3, 3x3 cells: 9 of 9 held
  1.17  RESERVE: armnanotcplat at (14104, 5000) facing 3 (id 14)
  1.17  RESERVE: zone 15 at (14104, 5048) facing 3, 3x3 cells: 9 of 9 held
  1.17  RESERVE: armnanotcplat at (14104, 5048) facing 3 (id 15)
  1.17  RESERVE: zone 16 at (14056, 4856) facing 3, 3x3 cells: 9 of 9 held
  1.17  RESERVE: armnanotcplat at (14056, 4856) facing 3 (id 16)
  1.17  RESERVE: zone 17 at (14056, 4904) facing 3, 3x3 cells: 9 of 9 held
  1.17  RESERVE: armnanotcplat at (14056, 4904) facing 3 (id 17)
  1.17  RESERVE: zone 18 at (14056, 4952) facing 3, 3x3 cells: 9 of 9 held
  1.17  RESERVE: armnanotcplat at (14056, 4952) facing 3 (id 18)
  1.17  RESERVE: zone 19 at (14056, 5000) facing 3, 3x3 cells: 9 of 9 held
  1.17  RESERVE: armnanotcplat at (14056, 5000) facing 3 (id 19)
  1.17  RESERVE: zone 20 at (14056, 5048) facing 3, 3x3 cells: 9 of 9 held
  1.17  RESERVE: armnanotcplat at (14056, 5048) facing 3 (id 20)
  1.17  RESERVE: zone 21 at (14008, 4856) facing 3, 3x3 cells: 9 of 9 held
  1.17  RESERVE: armnanotcplat at (14008, 4856) facing 3 (id 21)
  1.17  RESERVE: zone 22 at (14008, 4904) facing 3, 3x3 cells: 9 of 9 held
  1.17  RESERVE: armnanotcplat at (14008, 4904) facing 3 (id 22)
  1.17  RESERVE: zone 23 at (14008, 4952) facing 3, 3x3 cells: 9 of 9 held
  1.17  RESERVE: armnanotcplat at (14008, 4952) facing 3 (id 23)
  1.17  RESERVE: zone 24 at (14008, 5000) facing 3, 3x3 cells: 9 of 9 held
  1.17  RESERVE: armnanotcplat at (14008, 5000) facing 3 (id 24)
  1.17  RESERVE: zone 25 at (14008, 5048) facing 3, 3x3 cells: 9 of 9 held
  1.17  RESERVE: armnanotcplat at (14008, 5048) facing 3 (id 25)
  1.17  RESERVE: zone 11 released
  1.17  RESERVE: zone 12 released
  1.17  RESERVE: zone 13 released
  1.17  RESERVE: zone 14 released
  1.17  RESERVE: zone 15 released
  1.17  RESERVE: zone 16 released
  1.17  RESERVE: zone 17 released
  1.17  RESERVE: zone 18 released
  1.17  RESERVE: zone 19 released
  1.17  RESERVE: zone 20 released
  1.17  RESERVE: zone 21 released
  1.17  RESERVE: zone 22 released
  1.17  RESERVE: zone 23 released
  1.17  RESERVE: zone 24 released
  1.17  RESERVE: zone 25 released
  1.17  RESERVE: zone 26 at (14056, 4808) facing 3, 3x3 cells: 9 of 9 held
  1.17  RESERVE: armnanotcplat at (14056, 4808) facing 3 (id 26)
  1.17  RESERVE: zone 27 at (14056, 4856) facing 3, 3x3 cells: 9 of 9 held
  1.17  RESERVE: armnanotcplat at (14056, 4856) facing 3 (id 27)
  1.17  RESERVE: zone 28 at (14056, 4904) facing 3, 3x3 cells: 9 of 9 held
  1.17  RESERVE: armnanotcplat at (14056, 4904) facing 3 (id 28)
```
