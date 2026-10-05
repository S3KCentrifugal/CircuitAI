# Playtest report: PASS

- Verdict: **PASS** (reached 15 min)
- Game time reached: 15.1 min (frame 27118); wall 137 s
- DLL: build-theatres\d192-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T15:45:30
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: allied-bases-supplied.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\allied-bases-supplied\glacial\20261004T184529Z-12b458bb\runs\20261004T184751Z-038f3d53\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `yard-0` | seen at 5.2 min | `[t=00:01:18.504177][f=0009418] [BaseWatch] PASS forward yard team=0 unit=armasy rear=202 eco=-194.73999 facing=1 expected=1` |
| expect `yard-1` | seen at 8.6 min | `[t=00:01:37.257334][f=0015534] [BaseWatch] PASS forward yard team=1 unit=armasy rear=212 eco=-194.73801 facing=1 expected=1` |
| expect `yard-2` | seen at 11.6 min | `[t=00:01:55.684946][f=0020951] [BaseWatch] PASS forward yard team=2 unit=corasy rear=-188 eco=-516.07996 facing=1 expected=1` |
| expect `clusters` | seen at 14.0 min | `[t=00:02:08.921477][f=0025200] [BaseWatch] PASS cluster observation complete count=5` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `probe` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\allied-bases-supplied\glacial\20261004T184529Z-12b458bb\runs\20261004T184751Z-038f3d53\screen_2026-10-04_18-46-42-805.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\allied-bases-supplied\glacial\20261004T184529Z-12b458bb\runs\20261004T184751Z-038f3d53\screen_2026-10-04_18-46-57-893.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\allied-bases-supplied\glacial\20261004T184529Z-12b458bb\runs\20261004T184751Z-038f3d53\screen_2026-10-04_18-47-20-688.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\allied-bases-supplied\glacial\20261004T184529Z-12b458bb\runs\20261004T184751Z-038f3d53\screen_2026-10-04_18-47-44-580.png

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
  0.15  [Playtest] finished armmex team 0 at 0.15 min
  0.17  [Team][Roster] first mex 31849 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.17  [Team][Roster] team 1 first mex at 704,4448
  0.17  [Team][Roster] team 2 first mex at 1904,5967
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.42  [Playtest] finished armmex team 0 at 0.42 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 100146/100150, energy +30.0 bank 999795/1000000, units 5
  1.15  [Playtest] finished armtide team 0 at 1.15 min
  1.39  [Playtest] finished armtide team 0 at 1.39 min
  1.70  [Playtest] finished armsy team 0 at 1.70 min
  1.99  [Playtest] finished armtide team 0 at 1.99 min
  2.00  [SEA][Layout] berth sea.berth.0 armasy at=1728,4016 facing=1
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 99871/100250, energy +171.0 bank 1000798/1000800, units 17
  2.27  [SEA][Layout] berth sea.berth.1 armasy at=1632,3664 facing=1
  2.60  [Playtest] finished armtide team 0 at 2.60 min
  2.79  [Playtest] finished armtide team 0 at 2.79 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.7 bank 99218/100250, energy +240.0 bank 995930/1000900, units 25
  3.00  [Playtest] camera requested (1500,4600) height=3500
  3.01  [Playtest] camera captured name=ta position=(1500,4600) height=3500
  3.01  [Playtest] screenshot at 3.0 min of team 0 at (1500, 4600)
  3.06  [Playtest] finished armtide team 0 at 3.06 min
  3.93  [Playtest] finished armnanotcplat team 0 at 3.93 min
  3.98  [Playtest] finished armnanotcplat team 0 at 3.98 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +8.0 bank 99192/100250, energy +263.0 bank 990922/1000950, units 26
  4.42  [Playtest] finished armnanotcplat team 0 at 4.42 min
  4.61  [Playtest] finished armnanotcplat team 0 at 4.61 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +8.7 bank 99214/100250, energy +263.0 bank 973591/1000950, units 30
  5.23  [Playtest] finished armasy team 0 at 5.23 min
  5.59  [Playtest] finished armuwfus team 0 at 5.59 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +8.7 bank 99446/100450, energy +1463.0 bank 954621/1003650, units 30
  6.00  [Playtest] camera requested (1500,4600) height=3500
  6.02  [Playtest] camera captured name=ta position=(1500,4600) height=3500
  6.02  [Playtest] screenshot at 6.0 min of team 0 at (1500, 4600)
  6.45  [Playtest] finished armuwmmm team 0 at 6.45 min
  6.54  [Playtest] finished armnanotcplat team 0 at 6.54 min
  6.75  [Playtest] finished armnanotcplat team 0 at 6.76 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +18.3 bank 99451/100450, energy +1463.0 bank 953829/1003650, units 32
  7.28  [Playtest] finished armtide team 0 at 7.28 min
  7.36  [Playtest] finished armuwmmm team 0 at 7.36 min
  7.52  [Playtest] finished armuwmmm team 0 at 7.52 min
  7.61  [Playtest] finished armtide team 0 at 7.61 min
  7.86  [Playtest] finished armtide team 0 at 7.86 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +39.0 bank 99472/100450, energy +1532.0 bank 930801/1003800, units 37
  8.04  [Playtest] finished armuwmmm team 0 at 8.04 min
  8.17  [Playtest] finished armtide team 0 at 8.17 min
  8.23  [Playtest] finished armtide team 0 at 8.23 min
  8.31  [Playtest] finished armtide team 0 at 8.31 min
  8.45  [Playtest] finished armtide team 0 at 8.45 min
  8.46  [Playtest] finished armfmkr team 0 at 8.45 min
  8.49  [Playtest] finished armtide team 0 at 8.49 min
  8.55  [Playtest] finished armtide team 0 at 8.55 min
  8.66  [Playtest] finished armtide team 0 at 8.66 min
  8.70  [Playtest] finished armtide team 0 at 8.70 min
  8.79  [Playtest] finished armtide team 0 at 8.79 min
  8.90  [Playtest] finished armfmkr team 0 at 8.90 min
  8.96  [Playtest] finished armfmkr team 0 at 8.96 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +52.4 bank 99494/100450, energy +1739.0 bank 876401/1004250, units 49
  9.05  [Playtest] finished armfmkr team 0 at 9.05 min
  9.14  [Playtest] finished armfmkr team 0 at 9.14 min
  9.23  [Playtest] finished armfmkr team 0 at 9.23 min
  9.27  [Playtest] finished armfmkr team 0 at 9.27 min
  9.32  [Playtest] finished armfmkr team 0 at 9.32 min
  9.42  [Playtest] finished armfmkr team 0 at 9.42 min
  9.51  [Playtest] finished armfmkr team 0 at 9.51 min
  9.64  [Playtest] finished armfmkr team 0 at 9.64 min
  9.64  [Playtest] finished armfmkr team 0 at 9.64 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +61.4 bank 99503/100450, energy +1739.0 bank 789945/1004250, units 54
 10.00  [Playtest] camera requested (1500,4600) height=3500
 10.02  [Playtest] camera captured name=ta position=(1500,4600) height=3500
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (1500, 4600)
 11.00  [Playtest] eco team 0 at 11.0 min: metal +37.8 bank 100450/100450, energy +1739.0 bank 754052/1004250, units 54
 12.00  [Playtest] eco team 0 at 12.0 min: metal +37.8 bank 100450/100450, energy +1739.0 bank 754052/1004250, units 54
 13.00  [Playtest] eco team 0 at 13.0 min: metal +37.8 bank 100450/100450, energy +1739.0 bank 754052/1004250, units 54
 14.00  [Playtest] eco team 0 at 14.0 min: metal +37.8 bank 100450/100450, energy +1739.0 bank 754052/1004250, units 54
 14.00  [Playtest] camera requested (1500,4600) height=3500
 14.02  [Playtest] camera captured name=ta position=(1500,4600) height=3500
 14.02  [Playtest] screenshot at 14.0 min of team 0 at (1500, 4600)
 15.00  [Playtest] eco team 0 at 15.0 min: metal +37.8 bank 100450/100450, energy +1739.0 bank 754052/1004250, units 54
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
  0.42  RESERVE: served armtide at (152, 4808) facing 1 (id 1, 47 of this def still held)
  0.42  RESERVE: zone 1 at (14184, 4568) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armtide at (14184, 4568) facing 3 (id 1)
  0.42  RESERVE: zone 2 at (14184, 4616) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armtide at (14184, 4616) facing 3 (id 2)
  0.42  RESERVE: zone 3 at (14184, 4664) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armtide at (14184, 4664) facing 3 (id 3)
  0.42  RESERVE: zone 4 at (14184, 4712) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armtide at (14184, 4712) facing 3 (id 4)
  0.42  RESERVE: zone 5 at (14184, 4760) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armtide at (14184, 4760) facing 3 (id 5)
  0.42  RESERVE: zone 6 at (14184, 4808) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armtide at (14184, 4808) facing 3 (id 6)
  0.42  RESERVE: zone 7 at (14136, 4568) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armtide at (14136, 4568) facing 3 (id 7)
  0.42  RESERVE: zone 8 at (14136, 4616) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armtide at (14136, 4616) facing 3 (id 8)
  0.42  RESERVE: zone 9 at (14136, 4664) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armtide at (14136, 4664) facing 3 (id 9)
  0.42  RESERVE: zone 10 at (14136, 4712) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armtide at (14136, 4712) facing 3 (id 10)
  0.42  RESERVE: zone 11 at (14136, 4760) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armtide at (14136, 4760) facing 3 (id 11)
  0.42  RESERVE: zone 12 at (14136, 4808) facing 3, 3x3 cells: 9 of 9 held
```
