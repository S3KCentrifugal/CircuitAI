# Playtest report: PASS

- Verdict: **PASS** (reached 15 min)
- Game time reached: 15.1 min (frame 27110); wall 118 s
- DLL: build-theatres\d192-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T15:33:45
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: allied-bases-supplied.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\allied-bases-supplied\glacial\20261004T183345Z-af549eb3\runs\20261004T183546Z-dcc652a5\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `yard-0` | seen at 12.0 min | `[t=00:01:38.894655][f=0021631] [BaseWatch] PASS forward yard team=0 unit=armasy rear=90 eco=-194.73999 facing=1 expected=1` |
| expect `yard-1` | seen at 5.7 min | `[t=00:01:08.945952][f=0010310] [BaseWatch] PASS forward yard team=1 unit=armasy rear=-60 eco=-194.73801 facing=1 expected=1` |
| expect `yard-2` | seen at 10.5 min | `[t=00:01:31.666478][f=0018945] [BaseWatch] PASS forward yard team=2 unit=corasy rear=-188 eco=-516.07996 facing=1 expected=1` |
| expect `clusters` | seen at 14.0 min | `[t=00:01:49.793982][f=0025200] [BaseWatch] PASS cluster observation complete count=5` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `probe` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\allied-bases-supplied\glacial\20261004T183345Z-af549eb3\runs\20261004T183546Z-dcc652a5\screen_2026-10-04_18-34-47-842.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\allied-bases-supplied\glacial\20261004T183345Z-af549eb3\runs\20261004T183546Z-dcc652a5\screen_2026-10-04_18-35-00-878.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\allied-bases-supplied\glacial\20261004T183345Z-af549eb3\runs\20261004T183546Z-dcc652a5\screen_2026-10-04_18-35-19-058.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\allied-bases-supplied\glacial\20261004T183345Z-af549eb3\runs\20261004T183546Z-dcc652a5\screen_2026-10-04_18-35-40-640.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 15.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
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
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(700,4597) factory=armsy landLocked=no spot=5 known=1/2
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(1899,5801) factory=corsy landLocked=no spot=6 known=2/2
  0.15  [Team][Roster] team 1 first mex at 704,4448
  0.15  [Playtest] finished armmex team 0 at 0.15 min
  0.17  [Team][Roster] first mex 21028 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.17  [Team][Roster] team 2 first mex at 1904,5967
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.42  [Playtest] finished armmex team 0 at 0.42 min
  0.96  [Playtest] finished armtide team 0 at 0.96 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 100119/100150, energy +53.0 bank 999662/1000050, units 6
  1.11  [Playtest] finished armtide team 0 at 1.11 min
  1.41  [Playtest] finished armsy team 0 at 1.41 min
  1.73  [SEA][Layout] berth sea.berth.0 armasy at=1616,4096 facing=1
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 99710/100250, energy +171.0 bank 1000593/1000750, units 21
  2.15  [Playtest] finished armtide team 0 at 2.15 min
  2.22  [Playtest] finished armfmkr team 0 at 2.22 min
  2.25  [Playtest] finished armtide team 0 at 2.25 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.5 bank 99244/100250, energy +217.0 bank 996483/1000850, units 25
  3.00  [Playtest] camera requested (1500,4600) height=3500
  3.00  [Playtest] camera captured name=ta position=(1500,4600) height=3500
  3.00  [Playtest] screenshot at 3.0 min of team 0 at (1500, 4600)
  3.81  [Playtest] finished armnanotcplat team 0 at 3.81 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +9.0 bank 99228/100250, energy +217.0 bank 990446/1000850, units 23
  4.31  [Playtest] finished armnanotcplat team 0 at 4.31 min
  4.45  [Playtest] finished armuwmmm team 0 at 4.45 min
  4.51  [Playtest] finished armuwmmm team 0 at 4.51 min
  4.53  [Playtest] finished armnanotcplat team 0 at 4.53 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +29.7 bank 99256/100250, energy +217.0 bank 983505/1000850, units 29
  6.00  [Playtest] eco team 0 at 6.0 min: metal +29.7 bank 99257/100250, energy +217.0 bank 906221/1000850, units 28
  6.00  [Playtest] camera requested (1500,4600) height=3500
  6.01  [Playtest] camera captured name=ta position=(1500,4600) height=3500
  6.01  [Playtest] screenshot at 6.0 min of team 0 at (1500, 4600)
  6.24  [Playtest] finished armnanotcplat team 0 at 6.24 min
  6.26  [Playtest] finished armnanotcplat team 0 at 6.26 min
  6.32  [Playtest] finished armuwmmm team 0 at 6.32 min
  6.40  [Playtest] finished armuwmmm team 0 at 6.40 min
  6.55  [Playtest] finished armnanotcplat team 0 at 6.55 min
  6.62  [Playtest] finished armnanotcplat team 0 at 6.62 min
  6.72  [Playtest] finished armnanotcplat team 0 at 6.72 min
  6.98  [Playtest] finished armnanotcplat team 0 at 6.98 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +50.4 bank 99268/100250, energy +217.0 bank 787490/1000850, units 34
  7.17  [Playtest] finished armnanotcplat team 0 at 7.17 min
  7.44  [Playtest] finished armnanotcplat team 0 at 7.44 min
  7.59  [Playtest] finished armnanotcplat team 0 at 7.59 min
  7.68  [Playtest] finished armnanotcplat team 0 at 7.68 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +12.0 bank 99196/100250, energy +217.0 bank 750559/1000850, units 39
  8.24  [Playtest] finished armnanotcplat team 0 at 8.24 min
  8.25  [Playtest] finished armtide team 0 at 8.25 min
  8.39  [Playtest] finished armuwfus team 0 at 8.39 min
  8.43  [Playtest] finished armnanotcplat team 0 at 8.43 min
  8.56  [Playtest] finished armnanotcplat team 0 at 8.56 min
  8.58  [Playtest] finished armtide team 0 at 8.58 min
  8.77  [Playtest] finished armtide team 0 at 8.77 min
  8.85  [Playtest] finished armtide team 0 at 8.85 min
  8.92  [Playtest] finished armtide team 0 at 8.92 min
  8.98  [Playtest] finished armtide team 0 at 8.98 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +37.4 bank 99259/100250, energy +1543.5 bank 753473/1003650, units 48
  9.09  [Playtest] finished armtide team 0 at 9.09 min
  9.16  [Playtest] finished armtide team 0 at 9.16 min
  9.23  [Playtest] finished armtide team 0 at 9.23 min
  9.31  [Playtest] finished armtide team 0 at 9.31 min
  9.32  [Playtest] finished armtide team 0 at 9.32 min
  9.38  [Playtest] finished armtide team 0 at 9.38 min
  9.46  [Playtest] finished armtide team 0 at 9.46 min
  9.52  [Playtest] finished armtide team 0 at 9.52 min
  9.57  [Playtest] finished armfmkr team 0 at 9.57 min
  9.68  [Playtest] finished armfmkr team 0 at 9.68 min
  9.76  [Playtest] finished armfmkr team 0 at 9.76 min
  9.88  [Playtest] finished armfmkr team 0 at 9.88 min
  9.96  [Playtest] finished armfmkr team 0 at 9.96 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +38.8 bank 99971/100250, energy +1739.0 bank 753850/1004050, units 61
 10.00  [Playtest] camera requested (1500,4600) height=3500
 10.02  [Playtest] camera captured name=ta position=(1500,4600) height=3500
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (1500, 4600)
 10.08  [Playtest] finished armfmkr team 0 at 10.08 min
 10.15  [Playtest] finished armfmkr team 0 at 10.15 min
 10.28  [Playtest] finished armfmkr team 0 at 10.28 min
 10.29  [Playtest] finished armfmkr team 0 at 10.29 min
 10.48  [Playtest] finished armfmkr team 0 at 10.48 min
 10.56  [Playtest] finished armfmkr team 0 at 10.56 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +41.5 bank 100246/100250, energy +1739.0 bank 753877/1004050, units 64
 12.00  [Playtest] eco team 0 at 12.0 min: metal +41.5 bank 100246/100250, energy +1739.0 bank 753877/1004050, units 64
 12.02  [Playtest] finished armasy team 0 at 12.02 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +42.4 bank 100450/100450, energy +1739.0 bank 754052/1004250, units 64
 14.00  [Playtest] eco team 0 at 14.0 min: metal +42.4 bank 100450/100450, energy +1739.0 bank 754052/1004250, units 64
 14.00  [Playtest] camera requested (1500,4600) height=3500
 14.02  [Playtest] camera captured name=ta position=(1500,4600) height=3500
 14.02  [Playtest] screenshot at 14.0 min of team 0 at (1500, 4600)
 15.00  [Playtest] eco team 0 at 15.0 min: metal +42.4 bank 100450/100450, energy +1739.0 bank 754052/1004250, units 64
```

## Native lines (all AIs, first 120)

```
  0.41  RESERVE: zone 1 at (152, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (152, 4808) facing 1 (id 1)
  0.41  RESERVE: zone 2 at (152, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (152, 4760) facing 1 (id 2)
  0.41  RESERVE: zone 3 at (152, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (152, 4712) facing 1 (id 3)
  0.41  RESERVE: zone 4 at (152, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (152, 4664) facing 1 (id 4)
  0.41  RESERVE: zone 5 at (152, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (152, 4616) facing 1 (id 5)
  0.41  RESERVE: zone 6 at (152, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (152, 4568) facing 1 (id 6)
  0.41  RESERVE: zone 7 at (200, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (200, 4808) facing 1 (id 7)
  0.41  RESERVE: zone 8 at (200, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (200, 4760) facing 1 (id 8)
  0.41  RESERVE: zone 9 at (200, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (200, 4712) facing 1 (id 9)
  0.41  RESERVE: zone 10 at (200, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (200, 4664) facing 1 (id 10)
  0.41  RESERVE: zone 11 at (200, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (200, 4616) facing 1 (id 11)
  0.41  RESERVE: zone 12 at (200, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (200, 4568) facing 1 (id 12)
  0.41  RESERVE: zone 13 at (248, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (248, 4808) facing 1 (id 13)
  0.41  RESERVE: zone 14 at (248, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (248, 4760) facing 1 (id 14)
  0.41  RESERVE: zone 15 at (248, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (248, 4712) facing 1 (id 15)
  0.41  RESERVE: zone 16 at (248, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (248, 4664) facing 1 (id 16)
  0.41  RESERVE: zone 17 at (248, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (248, 4616) facing 1 (id 17)
  0.41  RESERVE: zone 18 at (248, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (248, 4568) facing 1 (id 18)
  0.41  RESERVE: zone 19 at (296, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (296, 4808) facing 1 (id 19)
  0.41  RESERVE: zone 20 at (296, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (296, 4760) facing 1 (id 20)
  0.41  RESERVE: zone 21 at (296, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (296, 4712) facing 1 (id 21)
  0.41  RESERVE: zone 22 at (296, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (296, 4664) facing 1 (id 22)
  0.41  RESERVE: zone 23 at (296, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (296, 4616) facing 1 (id 23)
  0.41  RESERVE: zone 24 at (296, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (296, 4568) facing 1 (id 24)
  0.41  RESERVE: zone 25 at (344, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (344, 4808) facing 1 (id 25)
  0.41  RESERVE: zone 26 at (344, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (344, 4760) facing 1 (id 26)
  0.41  RESERVE: zone 27 at (344, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (344, 4712) facing 1 (id 27)
  0.41  RESERVE: zone 28 at (344, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (344, 4664) facing 1 (id 28)
  0.41  RESERVE: zone 29 at (344, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (344, 4616) facing 1 (id 29)
  0.41  RESERVE: zone 30 at (344, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (344, 4568) facing 1 (id 30)
  0.41  RESERVE: zone 31 at (392, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (392, 4808) facing 1 (id 31)
  0.41  RESERVE: zone 32 at (392, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (392, 4760) facing 1 (id 32)
  0.41  RESERVE: zone 33 at (392, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (392, 4712) facing 1 (id 33)
  0.41  RESERVE: zone 34 at (392, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (392, 4664) facing 1 (id 34)
  0.41  RESERVE: zone 35 at (392, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (392, 4616) facing 1 (id 35)
  0.41  RESERVE: zone 36 at (392, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (392, 4568) facing 1 (id 36)
  0.41  RESERVE: zone 37 at (440, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (440, 4808) facing 1 (id 37)
  0.41  RESERVE: zone 38 at (440, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (440, 4760) facing 1 (id 38)
  0.41  RESERVE: zone 39 at (440, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (440, 4712) facing 1 (id 39)
  0.41  RESERVE: zone 40 at (440, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (440, 4664) facing 1 (id 40)
  0.41  RESERVE: zone 41 at (440, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (440, 4616) facing 1 (id 41)
  0.41  RESERVE: zone 42 at (440, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (440, 4568) facing 1 (id 42)
  0.41  RESERVE: zone 43 at (488, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (488, 4808) facing 1 (id 43)
  0.41  RESERVE: zone 44 at (488, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (488, 4760) facing 1 (id 44)
  0.41  RESERVE: zone 45 at (488, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (488, 4712) facing 1 (id 45)
  0.41  RESERVE: zone 46 at (488, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (488, 4664) facing 1 (id 46)
  0.41  RESERVE: zone 47 at (488, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (488, 4616) facing 1 (id 47)
  0.41  RESERVE: zone 48 at (488, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (488, 4568) facing 1 (id 48)
  0.41  RESERVE: served armtide at (152, 4808) facing 1 (id 1, 47 of this def still held)
  0.41  RESERVE: zone 1 at (14184, 4568) facing 3, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (14184, 4568) facing 3 (id 1)
  0.41  RESERVE: zone 2 at (14184, 4616) facing 3, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (14184, 4616) facing 3 (id 2)
  0.41  RESERVE: zone 3 at (14184, 4664) facing 3, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (14184, 4664) facing 3 (id 3)
  0.41  RESERVE: zone 4 at (14184, 4712) facing 3, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (14184, 4712) facing 3 (id 4)
  0.41  RESERVE: zone 5 at (14184, 4760) facing 3, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (14184, 4760) facing 3 (id 5)
  0.41  RESERVE: zone 6 at (14184, 4808) facing 3, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (14184, 4808) facing 3 (id 6)
  0.41  RESERVE: zone 7 at (14136, 4568) facing 3, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (14136, 4568) facing 3 (id 7)
  0.41  RESERVE: zone 8 at (14136, 4616) facing 3, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (14136, 4616) facing 3 (id 8)
  0.41  RESERVE: zone 9 at (14136, 4664) facing 3, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (14136, 4664) facing 3 (id 9)
  0.41  RESERVE: zone 10 at (14136, 4712) facing 3, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (14136, 4712) facing 3 (id 10)
  0.41  RESERVE: zone 11 at (14136, 4760) facing 3, 3x3 cells: 9 of 9 held
  0.41  RESERVE: armtide at (14136, 4760) facing 3 (id 11)
  0.41  RESERVE: zone 12 at (14136, 4808) facing 3, 3x3 cells: 9 of 9 held
```
