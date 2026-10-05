# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.1 min (frame 54152); wall 290 s
- DLL: build-theatres\d188-build-6\SkirmishAI.dll (ac71826721992d84); AI BARbTest/test; staged 2026-10-04T01:40:17
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\glacial\20261004T044017Z-c1d2a5d8\runs\20261004T044511Z-2a6408b9\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:35.909423][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 2.4 min | `[t=00:01:08.751475][f=0004356] [SeaWatch] finished frame=4356 id=3393 def=armsy builder=24361` |
| expect `first-ship-exit` | seen at 5.6 min | `[t=00:01:24.039678][f=0010140] [SeaWatch] egress id=27629 yard=3393 seconds=89.0 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\glacial\20261004T044017Z-c1d2a5d8\runs\20261004T044511Z-2a6408b9\screen_2026-10-04_04-41-42-454.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\glacial\20261004T044017Z-c1d2a5d8\runs\20261004T044511Z-2a6408b9\screen_2026-10-04_04-42-13-476.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\glacial\20261004T044017Z-c1d2a5d8\runs\20261004T044511Z-2a6408b9\screen_2026-10-04_04-43-41-627.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\glacial\20261004T044017Z-c1d2a5d8\runs\20261004T044511Z-2a6408b9\screen_2026-10-04_04-44-59-574.png

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
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|1426|4014|0|4|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(716,4607) factory=armsy landLocked=no spot=5 known=1/2
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(1899,5801) factory=corsy landLocked=no spot=6 known=2/2
  0.20  [Team][Roster] team 2 first mex at 1904,5967
  0.21  [Playtest] finished armmex team 0 at 0.21 min
  0.22  [Team][Roster] first mex 16023 at 1424,4096
  0.22  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1426|4014|0|4|1|1424|4096
  0.23  [SEA][Layout] berth sea.berth.0 armsy at=1616,4016 facing=1
  0.25  [SEA][Layout] berth sea.berth.1 armasy at=1424,3616 facing=1
  0.30  [SEA][Layout] berth sea.berth.2 armasy at=1456,3296 facing=3
  0.57  [Team][Roster] team 1 first mex at 704,4448
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.0 bank 1043/1050, energy +30.0 bank 977/1000, units 2
  2.00  [Playtest] eco team 0 at 2.0 min: metal +4.0 bank 1043/1050, energy +30.0 bank 977/1000, units 2
  2.11  [Playtest] finished armmex team 0 at 2.11 min
  2.42  [Playtest] finished armsy team 0 at 2.42 min
  2.78  [Playtest] finished armmex team 0 at 2.78 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +4.0 bank 769/1250, energy +30.0 bank 0/1100, units 7
  3.14  [Playtest] finished armmex team 0 at 3.14 min
  3.45  [Playtest] finished armtide team 0 at 3.45 min
  3.78  [Playtest] finished armtl team 0 at 3.78 min
  3.98  [Playtest] finished armtide team 0 at 3.98 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +8.0 bank 778/1300, energy +64.5 bank 41/1200, units 10
  4.15  [Playtest] finished armtide team 0 at 4.15 min
  4.29  [Playtest] finished armtide team 0 at 4.29 min
  4.44  [Playtest] finished armtide team 0 at 4.44 min
  4.80  [Playtest] finished armtide team 0 at 4.80 min
  4.97  [Playtest] finished armtide team 0 at 4.97 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +10.0 bank 257/1300, energy +205.0 bank 1544/1550, units 17
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.02  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.41  [Playtest] finished armtide team 0 at 5.41 min
  5.43  [Playtest] finished armtide team 0 at 5.43 min
  5.73  [Playtest] finished armtide team 0 at 5.73 min
  5.83  [Playtest] finished armmex team 0 at 5.83 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +12.0 bank 31/1350, energy +274.0 bank 1678/1700, units 26
  6.04  [Playtest] finished armfmkr team 0 at 6.04 min
  6.08  [Playtest] finished armllt team 0 at 6.08 min
  6.23  [Playtest] finished armrad team 0 at 6.23 min
  6.43  [Playtest] finished armmex team 0 at 6.43 min
  6.60  [Playtest] finished armtide team 0 at 6.60 min
  6.69  [Playtest] finished armmex team 0 at 6.69 min
  6.83  [Playtest] finished armmex team 0 at 6.83 min
  6.96  [Playtest] finished armmex team 0 at 6.96 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +21.0 bank 2/1550, energy +297.0 bank 1691/1750, units 35
  7.15  [Playtest] finished armfrad team 0 at 7.15 min
  7.45  [Playtest] finished armmex team 0 at 7.45 min
  7.49  [Playtest] finished armtide team 0 at 7.49 min
  7.67  [Playtest] finished armmex team 0 at 7.67 min
  7.74  [Playtest] finished armmex team 0 at 7.74 min
  7.92  [Playtest] finished armmex team 0 at 7.92 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +29.0 bank 377/1750, energy +327.0 bank 1795/1850, units 41
  8.05  [Playtest] finished armmex team 0 at 8.05 min
  8.12  [Playtest] finished armmex team 0 at 8.13 min
  8.31  [Playtest] finished armmex team 0 at 8.31 min
  8.52  [Playtest] finished armfmkr team 0 at 8.52 min
  8.62  [Playtest] finished armmex team 0 at 8.62 min
  8.83  [Playtest] finished armtide team 0 at 8.83 min
  8.86  [Playtest] finished armtl team 0 at 8.86 min
  8.89  [Playtest] finished armmex team 0 at 8.89 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +40.0 bank 1372/2000, energy +357.0 bank 1823/1950, units 49
  9.17  [Playtest] finished armtide team 0 at 9.17 min
  9.44  [Playtest] finished armtl team 0 at 9.44 min
  9.52  [Playtest] finished armtide team 0 at 9.52 min
  9.74  [Playtest] finished armmex team 0 at 9.74 min
  9.85  [Playtest] finished armtide team 0 at 9.85 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +42.0 bank 1847/2050, energy +440.0 bank 2126/2200, units 58
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.02  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.10  [Playtest] finished armmex team 0 at 10.10 min
 10.19  [Playtest] finished armtide team 0 at 10.19 min
 10.24  [Playtest] finished armfmkr team 0 at 10.24 min
 10.53  [Playtest] finished armtide team 0 at 10.53 min
 10.68  [Playtest] finished armfmkr team 0 at 10.68 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +46.0 bank 2098/2100, energy +486.0 bank 2045/2300, units 64
 11.25  [Playtest] finished armtide team 0 at 11.25 min
 11.56  [Playtest] finished armnanotcplat team 0 at 11.56 min
 11.58  [Playtest] finished armtide team 0 at 11.58 min
 11.90  [Playtest] finished armmex team 0 at 11.90 min
 11.91  [Playtest] finished armtide team 0 at 11.91 min
 11.97  [Playtest] finished armmex team 0 at 11.97 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +49.5 bank 2186/2200, energy +555.0 bank 2085/2450, units 71
 12.06  [Playtest] finished armtide team 0 at 12.06 min
 12.13  [Playtest] finished armtide team 0 at 12.13 min
 12.24  [Playtest] finished armtide team 0 at 12.24 min
 12.25  [Playtest] finished armmex team 0 at 12.25 min
 12.36  [Playtest] finished armtide team 0 at 12.36 min
 12.50  [Playtest] finished armtide team 0 at 12.50 min
 12.78  [Playtest] finished armtide team 0 at 12.78 min
 12.82  [Playtest] finished armfrad team 0 at 12.82 min
 12.84  [Playtest] finished armtl team 0 at 12.84 min
 12.90  [Playtest] finished armnanotcplat team 0 at 12.90 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +52.0 bank 2241/2250, energy +693.0 bank 2735/2750, units 83
 13.01  [Playtest] finished armtide team 0 at 13.01 min
 13.07  [Playtest] finished armtide team 0 at 13.07 min
 13.19  [Playtest] finished armtide team 0 at 13.19 min
 13.56  [Playtest] finished armtide team 0 at 13.56 min
 13.69  [Playtest] finished armtide team 0 at 13.69 min
 13.80  [Playtest] finished armtide team 0 at 13.80 min
 13.92  [Playtest] finished armtide team 0 at 13.92 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +52.0 bank 2102/2250, energy +847.0 bank 3096/3100, units 90
 14.11  [Playtest] finished armtide team 0 at 14.11 min
 14.12  [Playtest] finished armtide team 0 at 14.12 min
 14.21  [Playtest] finished armnanotcplat team 0 at 14.21 min
 14.41  [Playtest] finished armtide team 0 at 14.41 min
 14.56  [Playtest] finished armtide team 0 at 14.56 min
 14.73  [Playtest] finished armtide team 0 at 14.73 min
 14.80  [Playtest] finished armtide team 0 at 14.80 min
 14.90  [Playtest] finished armtide team 0 at 14.90 min
 14.91  [Playtest] finished armfmkr team 0 at 14.91 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +53.0 bank 1963/2250, energy +1015.0 bank 3396/3450, units 101
 15.04  [Playtest] finished armtide team 0 at 15.04 min
 15.12  [Playtest] finished armtide team 0 at 15.13 min
 15.17  [Playtest] finished armtide team 0 at 15.17 min
 15.21  [Playtest] finished armtide team 0 at 15.21 min
 15.29  [Playtest] finished armfmkr team 0 at 15.29 min
 15.32  [SEA][Layout] berth sea.berth.3 armasy at=2128,3728 facing=1
 15.32  [Playtest] finished armtide team 0 at 15.32 min
 15.48  [Playtest] finished armtide team 0 at 15.48 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +48.0 bank 263/2100, energy +1153.0 bank 3590/3750, units 107
 16.40  [Playtest] finished armtide team 0 at 16.40 min
 16.49  [Playtest] finished armasy team 0 at 16.49 min
 16.70  [Playtest] finished armtide team 0 at 16.70 min
 16.84  [Playtest] finished armtide team 0 at 16.84 min
 16.93  [Playtest] finished armtide team 0 at 16.93 min
 16.99  [Playtest] finished armtide team 0 at 16.99 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +48.0 bank 18/2300, energy +1245.0 bank 4188/4200, units 112
 17.11  [Playtest] finished armtide team 0 at 17.11 min
 17.21  [Playtest] finished armtide team 0 at 17.21 min
 17.94  [Playtest] finished armuwmme team 0 at 17.94 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +54.0 bank 26/2850, energy +1374.0 bank 4569/4600, units 112
 18.74  [Playtest] finished armuwmme team 0 at 18.74 min
 18.78  [Playtest] finished armuwmme team 0 at 18.78 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +66.0 bank 39/3950, energy +1374.0 bank 4447/4600, units 117
 19.08  [Playtest] finished armuwmme team 0 at 19.08 min
 19.21  [Playtest] finished armmex team 0 at 19.21 min
 19.21  [Playtest] finished armmex team 0 at 19.21 min
 19.66  [Playtest] finished armmex team 0 at 19.66 min
 19.74  [Playtest] finished armmex team 0 at 19.74 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +79.0 bank 986/4700, energy +1374.0 bank 3577/4600, units 117
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.01  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
 20.14  [Playtest] finished armnanotcplat team 0 at 20.14 min
 20.32  [Playtest] finished armmex team 0 at 20.32 min
 20.42  [Playtest] finished armnanotcplat team 0 at 20.42 min
 20.59  [Playtest] finished armmex team 0 at 20.59 min
 20.68  [Playtest] finished armnanotcplat team 0 at 20.68 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +84.0 bank 4278/4800, energy +1374.0 bank 4043/4600, units 127
 22.00  [Playtest] eco team 0 at 22.0 min: metal +78.0 bank 2272/4800, energy +1374.0 bank 1848/4600, units 132
 22.78  [Playtest] finished armuwfus team 0 at 22.78 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +84.0 bank 967/4800, energy +2574.0 bank 7049/7100, units 134
 24.00  [Playtest] eco team 0 at 24.0 min: metal +84.0 bank 50/4800, energy +2574.0 bank 7023/7100, units 140
 25.00  [Playtest] eco team 0 at 25.0 min: metal +84.0 bank 50/4800, energy +2574.0 bank 7010/7100, units 134
 25.26  [Playtest] finished armuwfus team 0 at 25.26 min
 25.77  [Playtest] finished armtl team 0 at 25.77 min
 25.95  [Playtest] finished armtl team 0 at 25.95 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +84.0 bank 762/4800, energy +3774.0 bank 9588/9600, units 140
 26.66  [Playtest] finished armfrad team 0 at 26.66 min
 26.71  [Playtest] finished armtl team 0 at 26.71 min
 26.75  [Playtest] finished armtl team 0 at 26.75 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +84.0 bank 48/4800, energy +3774.0 bank 9434/9600, units 136
 27.26  [Playtest] finished armtl team 0 at 27.26 min
 27.48  [Playtest] finished armtl team 0 at 27.48 min
 27.75  [Playtest] finished armfrad team 0 at 27.75 min
 27.77  [Playtest] finished armtl team 0 at 27.77 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +84.0 bank 261/4800, energy +3774.0 bank 9371/9600, units 143
 28.09  [Playtest] finished armtl team 0 at 28.09 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +84.0 bank 991/4800, energy +3774.0 bank 9396/9600, units 146
 29.00  [Playtest] camera requested (1700,4550) height=4000
 29.02  [Playtest] camera captured name=ta position=(1700,4550) height=4000
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (1700, 4550)
 29.94  [Playtest] finished armmex team 0 at 29.94 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +86.0 bank 632/4850, energy +3767.0 bank 9309/9550, units 149
```

## Native lines (all AIs, first 120)

```
  0.09  EXP: approach: corcom(1973) at (1899, 5801) walks to (1900, 5829), 139 from the cormex site (1904, 5968)
  0.10  RESERVE: zone 1 at (13040, 4016) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: legsy at (13040, 4016) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (13328, 4016) facing 1, 30x12 cells: 356 of 360 held
  0.10  RESERVE: zone 3 at (12824, 3960) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (12824, 3960) facing 3 (id 2)
  0.10  RESERVE: zone 4 at (12824, 4024) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (12824, 4024) facing 3 (id 3)
  0.10  RESERVE: zone 5 at (12824, 4088) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (12824, 4088) facing 3 (id 4)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 released
  0.10  RESERVE: zone 6 at (12824, 4056) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (12824, 4056) facing 3 (id 5)
  0.10  RESERVE: zone 7 at (12824, 4120) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (12824, 4120) facing 3 (id 6)
  0.10  RESERVE: zone 8 at (12824, 4184) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (12824, 4184) facing 3 (id 7)
  0.10  RESERVE: zone 9 at (12760, 4056) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (12760, 4056) facing 3 (id 8)
  0.10  RESERVE: zone 10 at (12760, 4120) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (12760, 4120) facing 3 (id 9)
  0.10  RESERVE: zone 11 at (12760, 4184) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (12760, 4184) facing 3 (id 10)
  0.10  RESERVE: zone 12 at (12784, 4112) facing 3, 8x12 cells: 42 of 96 held
  0.11  EXP: idle: corcom(1973) on cormex at (1899, 5822), site (1904, 5968), target yes, fails 2 (arrived at the approach point)
  0.12  RESERVE: zone 13 at (12944, 4416) facing 3, 12x12 cells: 144 of 144 held
  0.12  RESERVE: legadvshipyard at (12944, 4416) facing 3 (id 11)
  0.12  RESERVE: corridor 14 at (12608, 4416) facing 3, 30x18 cells: 540 of 540 held
  0.12  RESERVE: zone 15 at (13128, 4440) facing 3, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (13128, 4440) facing 3 (id 12)
  0.12  RESERVE: zone 16 at (13128, 4504) facing 3, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (13128, 4504) facing 3 (id 13)
  0.12  RESERVE: zone 17 at (13128, 4568) facing 3, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (13128, 4568) facing 3 (id 14)
  0.12  RESERVE: zone 18 at (13064, 4440) facing 3, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (13064, 4440) facing 3 (id 15)
  0.12  RESERVE: zone 19 at (13064, 4504) facing 3, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (13064, 4504) facing 3 (id 16)
  0.12  RESERVE: zone 20 at (13064, 4568) facing 3, 3x3 cells: 9 of 9 held
  0.12  RESERVE: legnanotcplat at (13064, 4568) facing 3 (id 17)
  0.12  RESERVE: zone 21 at (13099, 4505) facing 3, 9x13 cells: 56 of 117 held
  0.14  RESERVE: zone 22 at (12944, 4816) facing 3, 12x12 cells: 144 of 144 held
  0.14  RESERVE: legadvshipyard at (12944, 4816) facing 3 (id 18)
  0.14  RESERVE: corridor 23 at (12608, 4816) facing 3, 30x18 cells: 540 of 540 held
  0.14  RESERVE: zone 24 at (13096, 4824) facing 3, 3x3 cells: 9 of 9 held
  0.14  RESERVE: legnanotcplat at (13096, 4824) facing 3 (id 19)
  0.14  RESERVE: zone 25 at (13096, 4888) facing 3, 3x3 cells: 9 of 9 held
  0.14  RESERVE: legnanotcplat at (13096, 4888) facing 3 (id 20)
  0.14  RESERVE: zone 26 at (13096, 4952) facing 3, 3x3 cells: 9 of 9 held
  0.14  RESERVE: legnanotcplat at (13096, 4952) facing 3 (id 21)
  0.14  RESERVE: zone 24 released
  0.14  RESERVE: zone 25 released
  0.14  RESERVE: zone 26 released
  0.14  RESERVE: zone 27 at (13080, 4792) facing 3, 3x3 cells: 9 of 9 held
  0.14  RESERVE: legnanotcplat at (13080, 4792) facing 3 (id 22)
  0.14  RESERVE: zone 28 at (13080, 4856) facing 3, 3x3 cells: 9 of 9 held
  0.14  RESERVE: legnanotcplat at (13080, 4856) facing 3 (id 23)
  0.14  RESERVE: zone 29 at (13080, 4920) facing 3, 3x3 cells: 9 of 9 held
  0.14  RESERVE: legnanotcplat at (13080, 4920) facing 3 (id 24)
  0.14  RESERVE: zone 27 released
  0.14  RESERVE: zone 28 released
  0.14  RESERVE: zone 29 released
  0.14  RESERVE: zone 30 at (13080, 4760) facing 3, 3x3 cells: 9 of 9 held
  0.14  RESERVE: legnanotcplat at (13080, 4760) facing 3 (id 25)
  0.14  RESERVE: zone 31 at (13080, 4824) facing 3, 3x3 cells: 9 of 9 held
  0.14  RESERVE: legnanotcplat at (13080, 4824) facing 3 (id 26)
  0.14  RESERVE: zone 32 at (13080, 4888) facing 3, 3x3 cells: 9 of 9 held
  0.14  RESERVE: legnanotcplat at (13080, 4888) facing 3 (id 27)
  0.14  RESERVE: zone 30 released
  0.14  RESERVE: zone 31 released
  0.14  RESERVE: zone 32 released
  0.14  RESERVE: zone 33 at (13080, 4712) facing 3, 3x3 cells: 9 of 9 held
  0.14  RESERVE: legnanotcplat at (13080, 4712) facing 3 (id 28)
  0.14  RESERVE: zone 34 at (13080, 4776) facing 3, 3x3 cells: 9 of 9 held
  0.14  RESERVE: legnanotcplat at (13080, 4776) facing 3 (id 29)
  0.14  RESERVE: zone 35 at (13080, 4840) facing 3, 3x3 cells: 9 of 9 held
  0.14  RESERVE: legnanotcplat at (13080, 4840) facing 3 (id 30)
  0.14  RESERVE: zone 33 released
  0.14  RESERVE: zone 34 released
  0.14  RESERVE: zone 35 released
  0.14  RESERVE: zone 36 at (13096, 4680) facing 3, 3x3 cells: 9 of 9 held
  0.14  RESERVE: legnanotcplat at (13096, 4680) facing 3 (id 31)
  0.14  RESERVE: zone 37 at (13096, 4744) facing 3, 3x3 cells: 9 of 9 held
  0.14  RESERVE: legnanotcplat at (13096, 4744) facing 3 (id 32)
  0.14  RESERVE: zone 38 at (13096, 4808) facing 3, 3x3 cells: 9 of 9 held
  0.14  RESERVE: legnanotcplat at (13096, 4808) facing 3 (id 33)
  0.14  RESERVE: zone 39 at (13032, 4680) facing 3, 3x3 cells: 9 of 9 held
  0.14  RESERVE: legnanotcplat at (13032, 4680) facing 3 (id 34)
  0.14  RESERVE: zone 36 released
  0.14  RESERVE: zone 37 released
  0.14  RESERVE: zone 38 released
  0.14  RESERVE: zone 39 released
  0.14  RESERVE: zone 40 at (13128, 4664) facing 3, 3x3 cells: 9 of 9 held
  0.14  RESERVE: legnanotcplat at (13128, 4664) facing 3 (id 35)
  0.14  RESERVE: zone 41 at (13128, 4728) facing 3, 3x3 cells: 9 of 9 held
  0.14  RESERVE: legnanotcplat at (13128, 4728) facing 3 (id 36)
  0.14  RESERVE: zone 42 at (13128, 4792) facing 3, 3x3 cells: 9 of 9 held
  0.14  RESERVE: legnanotcplat at (13128, 4792) facing 3 (id 37)
  0.14  RESERVE: zone 43 at (13064, 4664) facing 3, 3x3 cells: 9 of 9 held
  0.14  RESERVE: legnanotcplat at (13064, 4664) facing 3 (id 38)
  0.14  RESERVE: zone 44 at (13064, 4728) facing 3, 3x3 cells: 9 of 9 held
  0.14  RESERVE: legnanotcplat at (13064, 4728) facing 3 (id 39)
  0.14  RESERVE: zone 45 at (13064, 4792) facing 3, 3x3 cells: 9 of 9 held
  0.14  RESERVE: legnanotcplat at (13064, 4792) facing 3 (id 40)
  0.14  RESERVE: zone 46 at (13099, 4727) facing 3, 9x13 cells: 56 of 117 held
  0.17  RESERVE: zone 1 at (13584, 4608) facing 0, 6x6 cells: 36 of 36 held
  0.17  RESERVE: armsy at (13584, 4608) facing 0 (id 1)
  0.17  RESERVE: corridor 2 at (13584, 4896) facing 0, 12x30 cells: 341 of 360 held
  0.17  RESERVE: zone 3 at (13592, 4328) facing 3, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotcplat at (13592, 4328) facing 3 (id 2)
  0.17  RESERVE: zone 4 at (13592, 4392) facing 3, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotcplat at (13592, 4392) facing 3 (id 3)
  0.17  RESERVE: zone 3 released
  0.17  RESERVE: zone 4 released
  0.17  RESERVE: zone 5 at (13688, 4328) facing 3, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotcplat at (13688, 4328) facing 3 (id 4)
  0.17  RESERVE: zone 6 at (13688, 4392) facing 3, 3x3 cells: 9 of 9 held
  0.17  RESERVE: armnanotcplat at (13688, 4392) facing 3 (id 5)
```
