# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 28.0 min (frame 50406); wall 218 s
- DLL: build-theatres\d189-build-5\SkirmishAI.dll (1b875078bc2aa763); AI BARbTest/test; staged 2026-10-04T07:14:50
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\glacial\20261004T101450Z-93bf111a\runs\20261004T101831Z-c7470d21\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:33.355792][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.8 min | `[t=00:00:47.532258][f=0001390] [SeaWatch] finished frame=1390 id=9800 def=armsy builder=27123` |
| expect `first-ship-exit` | seen at 3.0 min | `[t=00:00:56.244264][f=0005310] [SeaWatch] egress id=16606 yard=9800 seconds=4.7 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-033 metal over 95% for 60 s while team 4 has 722 free` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 27.9 min: [INVARIANT] INV-033 metal over 95% for 60 s while team 4 has 722 free

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\glacial\20261004T101450Z-93bf111a\runs\20261004T101831Z-c7470d21\screen_2026-10-04_10-15-59-314.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\glacial\20261004T101450Z-93bf111a\runs\20261004T101831Z-c7470d21\screen_2026-10-04_10-16-21-843.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\glacial\20261004T101450Z-93bf111a\runs\20261004T101831Z-c7470d21\screen_2026-10-04_10-17-32-453.png

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
  2.00  [Playtest] finished armtide team 0 at 2.00 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 864/1250, energy +53.0 bank 75/1200, units 8
  2.15  [Playtest] finished armtide team 0 at 2.15 min
  2.29  [Playtest] finished armtide team 0 at 2.29 min
  2.46  [Playtest] finished armtide team 0 at 2.46 min
  2.71  [Playtest] finished armtide team 0 at 2.71 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 693/1250, energy +182.0 bank 1487/1500, units 16
  3.09  [Playtest] finished armtide team 0 at 3.09 min
  3.35  [Playtest] finished armmex team 0 at 3.35 min
  3.40  [Playtest] finished armtide team 0 at 3.40 min
  3.70  [Playtest] finished armtide team 0 at 3.70 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 201/1300, energy +251.0 bank 1635/1650, units 21
  4.01  [Playtest] finished armtide team 0 at 4.01 min
  4.28  [Playtest] finished armmex team 0 at 4.28 min
  4.61  [Playtest] finished armllt team 0 at 4.61 min
  4.86  [Playtest] finished armrad team 0 at 4.86 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +12.0 bank 0/1350, energy +274.0 bank 1681/1700, units 26
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.01  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.01  [Playtest] finished armmex team 0 at 5.01 min
  5.04  [Playtest] finished armtide team 0 at 5.04 min
  5.35  [Playtest] finished armtide team 0 at 5.35 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +14.0 bank 274/1400, energy +320.0 bank 1786/1800, units 29
  6.00  [Playtest] finished armtide team 0 at 6.00 min
  6.31  [Playtest] finished armtide team 0 at 6.31 min
  6.74  [Playtest] finished armfmkr team 0 at 6.74 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +15.0 bank 405/1400, energy +373.0 bank 1890/1950, units 35
  7.14  [Playtest] finished armfmkr team 0 at 7.14 min
  7.27  [Playtest] finished armfmkr team 0 at 7.27 min
  7.53  [Playtest] finished armmex team 0 at 7.53 min
  7.63  [Playtest] finished armtide team 0 at 7.63 min
  7.83  [Playtest] finished armtide team 0 at 7.83 min
  7.98  [Playtest] finished armtide team 0 at 7.98 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +19.0 bank 390/1450, energy +419.0 bank 2016/2100, units 39
  8.14  [Playtest] finished armtide team 0 at 8.14 min
  8.44  [Playtest] finished armtide team 0 at 8.44 min
  8.57  [Playtest] finished armtide team 0 at 8.57 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +19.0 bank 583/1450, energy +511.0 bank 2167/2250, units 43
  9.05  [Playtest] finished armfmkr team 0 at 9.05 min
  9.16  [Playtest] finished armfmkr team 0 at 9.16 min
  9.47  [Playtest] finished armfmkr team 0 at 9.47 min
  9.57  [Playtest] finished armmex team 0 at 9.57 min
  9.80  [Playtest] finished armtide team 0 at 9.80 min
  9.88  [Playtest] finished armmex team 0 at 9.88 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +26.0 bank 1175/1550, energy +541.0 bank 2081/2350, units 50
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.02  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.07  [Playtest] finished armtide team 0 at 10.07 min
 10.15  [Playtest] finished armtide team 0 at 10.15 min
 10.39  [Playtest] finished armtide team 0 at 10.39 min
 10.60  [Playtest] finished armtl team 0 at 10.60 min
 10.84  [Playtest] finished armtide team 0 at 10.84 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +24.4 bank 1268/1550, energy +640.0 bank 2105/2600, units 58
 11.09  [Playtest] finished armnanotcplat team 0 at 11.09 min
 11.16  [Playtest] finished armtide team 0 at 11.16 min
 11.16  [Playtest] finished armtide team 0 at 11.16 min
 11.68  [Playtest] finished armtide team 0 at 11.68 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +26.0 bank 1140/1550, energy +716.0 bank 2575/2800, units 62
 12.05  [Playtest] finished armfmkr team 0 at 12.05 min
 12.38  [Playtest] finished armtide team 0 at 12.38 min
 12.65  [Playtest] finished armmex team 0 at 12.65 min
 12.76  [Playtest] finished armfmkr team 0 at 12.76 min
 12.85  [Playtest] finished armmex team 0 at 12.85 min
 12.97  [Playtest] finished armfrad team 0 at 12.97 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +29.8 bank 807/1650, energy +739.0 bank 2481/2850, units 70
 13.12  [Playtest] finished armtide team 0 at 13.12 min
 13.24  [Playtest] finished armmex team 0 at 13.24 min
 13.25  [Playtest] finished armmex team 0 at 13.25 min
 13.79  [Playtest] finished armtide team 0 at 13.79 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +30.4 bank 1454/1650, energy +764.0 bank 2323/2800, units 70
 14.02  [Playtest] finished armmex team 0 at 14.02 min
 14.12  [Playtest] finished armtide team 0 at 14.12 min
 14.22  [Playtest] finished armtide team 0 at 14.22 min
 14.32  [Playtest] finished armfrad team 0 at 14.32 min
 14.43  [Playtest] finished armtide team 0 at 14.43 min
 14.54  [Playtest] finished armtide team 0 at 14.54 min
 14.93  [Playtest] finished armtide team 0 at 14.93 min
 14.94  [Playtest] finished armfmkr team 0 at 14.94 min
 14.96  [Playtest] finished armtide team 0 at 14.96 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +33.0 bank 1616/1650, energy +902.0 bank 2924/3100, units 75
 15.29  [Playtest] finished armtide team 0 at 15.29 min
 15.71  [Playtest] finished armfmkr team 0 at 15.71 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +30.6 bank 1590/1650, energy +925.0 bank 2593/3150, units 76
 16.08  [Playtest] finished armfmkr team 0 at 16.08 min
 16.09  [Playtest] finished armasy team 0 at 16.09 min
 16.43  [Playtest] finished armfrad team 0 at 16.43 min
 16.61  [Playtest] finished armfmkr team 0 at 16.61 min
 16.62  [Playtest] finished armtide team 0 at 16.62 min
 16.91  [Playtest] finished armtide team 0 at 16.91 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +24.2 bank 1708/1750, energy +1015.0 bank 2922/3700, units 82
 17.11  [Playtest] finished armnanotcplat team 0 at 17.11 min
 17.32  [Playtest] finished armtide team 0 at 17.32 min
 17.36  [Playtest] finished armuwmme team 0 at 17.36 min
 17.92  [Playtest] finished armuwmme team 0 at 17.92 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +35.9 bank 4/2700, energy +1040.0 bank 3078/3650, units 73
 18.51  [Playtest] finished armuwmme team 0 at 18.51 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +38.0 bank 4/3250, energy +787.0 bank 2979/3150, units 57
 19.34  [Playtest] finished armatl team 0 at 19.34 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +21.3 bank 91/1750, energy +313.0 bank 1338/1700, units 27
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.00  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.00  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
 20.53  [SEA][Layout] berth sea.berth.3 armsy at=2096,4000 facing=1
 21.00  [Playtest] eco team 0 at 21.0 min: metal +6.0 bank 565/650, energy +145.0 bank 800/800, units 10
 22.00  [Playtest] eco team 0 at 22.0 min: metal +0.0 bank 500/500, energy +0.0 bank 497/500, units 0
 23.00  [Playtest] eco team 0 at 23.0 min: metal +0.0 bank 500/500, energy +0.0 bank 497/500, units 0
 24.00  [Playtest] eco team 0 at 24.0 min: metal +0.0 bank 500/500, energy +0.0 bank 497/500, units 0
 25.00  [Playtest] eco team 0 at 25.0 min: metal +0.0 bank 500/500, energy +0.0 bank 497/500, units 0
 26.00  [Playtest] eco team 0 at 26.0 min: metal +0.0 bank 500/500, energy +0.0 bank 497/500, units 0
 27.00  [Playtest] eco team 0 at 27.0 min: metal +0.0 bank 500/500, energy +0.0 bank 497/500, units 0
 28.00  [Playtest] eco team 0 at 28.0 min: metal +0.0 bank 500/500, energy +0.0 bank 497/500, units 0
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
