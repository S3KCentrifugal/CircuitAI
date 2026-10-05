# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 15.1 min (frame 27124); wall 104 s
- DLL: build-theatres\d192-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T15:12:33
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: allied-bases-supplied.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\allied-bases-supplied\glacial\20261004T181233Z-70e40763\runs\20261004T181421Z-a4817bb4\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `yard-0` | **missing** (by 15 min) | |
| expect `yard-1` | **missing** (by 15 min) | |
| expect `yard-2` | **missing** (by 15 min) | |
| expect `clusters` | seen at 14.0 min | `[t=00:01:37.371100][f=0025200] [BaseWatch] PASS cluster observation complete count=4` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `probe` | clean |  |
| forbid `crash` | clean |  |

## Failures

- 'yard-0' not seen by 15.0 min
- 'yard-1' not seen by 15.0 min
- 'yard-2' not seen by 15.0 min

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\allied-bases-supplied\glacial\20261004T181233Z-70e40763\runs\20261004T181421Z-a4817bb4\screen_2026-10-04_18-13-28-945.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\allied-bases-supplied\glacial\20261004T181233Z-70e40763\runs\20261004T181421Z-a4817bb4\screen_2026-10-04_18-13-42-043.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\allied-bases-supplied\glacial\20261004T181233Z-70e40763\runs\20261004T181421Z-a4817bb4\screen_2026-10-04_18-13-59-031.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\allied-bases-supplied\glacial\20261004T181233Z-70e40763\runs\20261004T181421Z-a4817bb4\screen_2026-10-04_18-14-16-015.png

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
  0.17  [Team][Roster] first mex 30357 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.17  [Team][Roster] team 2 first mex at 1904,5967
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.33  [SEA][Layout] berth sea.berth.0 armsy at=1424,4000 facing=2
  0.33  [Playtest] finished armsy team 0 at 0.33 min
  0.48  [Playtest] finished armmex team 0 at 0.48 min
  0.48  [Playtest] finished armmex team 0 at 0.48 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +10.0 bank 100062/100300, energy +125.0 bank 1000640/1000650, units 16
  1.14  [Playtest] finished armtide team 0 at 1.14 min
  1.19  [Playtest] finished armtide team 0 at 1.19 min
  1.25  [Playtest] finished armtide team 0 at 1.25 min
  1.32  [Playtest] finished armtide team 0 at 1.32 min
  1.38  [Playtest] finished armtide team 0 at 1.38 min
  1.45  [Playtest] finished armtide team 0 at 1.45 min
  1.50  [Playtest] finished armtide team 0 at 1.50 min
  1.57  [Playtest] finished armtide team 0 at 1.57 min
  1.58  [SEA][Layout] berth sea.berth.1 armasy at=1632,3792 facing=1
  1.65  [Playtest] finished armtide team 0 at 1.65 min
  1.72  [Playtest] finished armtide team 0 at 1.72 min
  1.74  [Playtest] finished armtide team 0 at 1.74 min
  1.82  [Playtest] finished armtide team 0 at 1.82 min
  1.91  [Playtest] finished armtide team 0 at 1.91 min
  1.93  [Playtest] finished armtide team 0 at 1.93 min
  1.99  [Playtest] finished armtide team 0 at 1.99 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +10.0 bank 99271/100300, energy +447.0 bank 1001393/1001400, units 32
  2.01  [Playtest] finished armtide team 0 at 2.01 min
  2.05  [Playtest] finished armtide team 0 at 2.05 min
  2.10  [Playtest] finished armtide team 0 at 2.10 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 99677/100300, energy +539.0 bank 1001550/1001550, units 32
  3.00  [Playtest] camera requested (1500,4600) height=3500
  3.01  [Playtest] camera captured name=ta position=(1500,4600) height=3500
  3.01  [Playtest] screenshot at 3.0 min of team 0 at (1500, 4600)
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 100278/100300, energy +539.0 bank 1001550/1001550, units 32
  5.00  [Playtest] eco team 0 at 5.0 min: metal +10.0 bank 100300/100300, energy +539.0 bank 1001550/1001550, units 31
  6.00  [Playtest] eco team 0 at 6.0 min: metal +10.0 bank 100300/100300, energy +539.0 bank 1001550/1001550, units 31
  6.00  [Playtest] camera requested (1500,4600) height=3500
  6.00  [Playtest] camera captured name=ta position=(1500,4600) height=3500
  6.00  [Playtest] screenshot at 6.0 min of team 0 at (1500, 4600)
  7.00  [Playtest] eco team 0 at 7.0 min: metal +10.0 bank 100300/100300, energy +539.0 bank 1001550/1001550, units 31
  8.00  [Playtest] eco team 0 at 8.0 min: metal +10.0 bank 100300/100300, energy +539.0 bank 1001550/1001550, units 31
  9.00  [Playtest] eco team 0 at 9.0 min: metal +10.0 bank 100300/100300, energy +539.0 bank 1001550/1001550, units 31
 10.00  [Playtest] eco team 0 at 10.0 min: metal +10.0 bank 100300/100300, energy +539.0 bank 1001550/1001550, units 31
 10.00  [Playtest] camera requested (1500,4600) height=3500
 10.01  [Playtest] camera captured name=ta position=(1500,4600) height=3500
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (1500, 4600)
 11.00  [Playtest] eco team 0 at 11.0 min: metal +10.0 bank 100300/100300, energy +539.0 bank 1001550/1001550, units 31
 12.00  [Playtest] eco team 0 at 12.0 min: metal +10.0 bank 100300/100300, energy +539.0 bank 1001550/1001550, units 31
 13.00  [Playtest] eco team 0 at 13.0 min: metal +10.0 bank 100300/100300, energy +539.0 bank 1001550/1001550, units 31
 14.00  [Playtest] eco team 0 at 14.0 min: metal +10.0 bank 100300/100300, energy +539.0 bank 1001550/1001550, units 31
 14.00  [Playtest] camera requested (1500,4600) height=3500
 14.01  [Playtest] camera captured name=ta position=(1500,4600) height=3500
 14.01  [Playtest] screenshot at 14.0 min of team 0 at (1500, 4600)
 15.00  [Playtest] eco team 0 at 15.0 min: metal +10.0 bank 100300/100300, energy +539.0 bank 1001550/1001550, units 31
```

## Native lines (all AIs, first 120)

```
  0.33  RESERVE: zone 1 at (1424, 4000) facing 2, 6x6 cells: 36 of 36 held
  0.33  RESERVE: armsy at (1424, 4000) facing 2 (id 1)
  0.33  RESERVE: corridor 2 at (1424, 3712) facing 2, 12x30 cells: 344 of 360 held
  0.33  RESERVE: zone 3 at (1176, 4248) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (1176, 4248) facing 1 (id 2)
  0.33  RESERVE: zone 4 at (1176, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (1176, 4200) facing 1 (id 3)
  0.33  RESERVE: zone 5 at (1176, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (1176, 4152) facing 1 (id 4)
  0.33  RESERVE: zone 6 at (1176, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (1176, 4104) facing 1 (id 5)
  0.33  RESERVE: zone 7 at (1176, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (1176, 4056) facing 1 (id 6)
  0.33  RESERVE: zone 8 at (1224, 4248) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (1224, 4248) facing 1 (id 7)
  0.33  RESERVE: zone 9 at (1224, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (1224, 4200) facing 1 (id 8)
  0.33  RESERVE: zone 10 at (1224, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (1224, 4152) facing 1 (id 9)
  0.33  RESERVE: zone 11 at (1224, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (1224, 4104) facing 1 (id 10)
  0.33  RESERVE: zone 12 at (1224, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (1224, 4056) facing 1 (id 11)
  0.33  RESERVE: zone 13 at (1272, 4248) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (1272, 4248) facing 1 (id 12)
  0.33  RESERVE: zone 14 at (1272, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (1272, 4200) facing 1 (id 13)
  0.33  RESERVE: zone 15 at (1272, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (1272, 4152) facing 1 (id 14)
  0.33  RESERVE: zone 16 at (1272, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (1272, 4104) facing 1 (id 15)
  0.33  RESERVE: zone 17 at (1272, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (1272, 4056) facing 1 (id 16)
  0.33  RESERVE: zone 18 at (1320, 4248) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (1320, 4248) facing 1 (id 17)
  0.33  RESERVE: zone 19 at (1320, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (1320, 4200) facing 1 (id 18)
  0.33  RESERVE: zone 20 at (1320, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (1320, 4152) facing 1 (id 19)
  0.33  RESERVE: zone 21 at (1320, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (1320, 4104) facing 1 (id 20)
  0.33  RESERVE: zone 22 at (1320, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (1320, 4056) facing 1 (id 21)
  0.33  RESERVE: zone 1 at (704, 4592) facing 0, 6x6 cells: 36 of 36 held
  0.33  RESERVE: armsy at (704, 4592) facing 0 (id 1)
  0.33  RESERVE: corridor 2 at (704, 4880) facing 0, 12x30 cells: 344 of 360 held
  0.33  RESERVE: zone 3 at (456, 4536) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (456, 4536) facing 1 (id 2)
  0.33  RESERVE: zone 4 at (456, 4488) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (456, 4488) facing 1 (id 3)
  0.33  RESERVE: zone 5 at (456, 4440) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (456, 4440) facing 1 (id 4)
  0.33  RESERVE: zone 6 at (456, 4392) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (456, 4392) facing 1 (id 5)
  0.33  RESERVE: zone 7 at (456, 4344) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (456, 4344) facing 1 (id 6)
  0.33  RESERVE: zone 8 at (504, 4536) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (504, 4536) facing 1 (id 7)
  0.33  RESERVE: zone 9 at (504, 4488) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (504, 4488) facing 1 (id 8)
  0.33  RESERVE: zone 10 at (504, 4440) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (504, 4440) facing 1 (id 9)
  0.33  RESERVE: zone 11 at (504, 4392) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (504, 4392) facing 1 (id 10)
  0.33  RESERVE: zone 12 at (504, 4344) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (504, 4344) facing 1 (id 11)
  0.33  RESERVE: zone 13 at (552, 4536) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (552, 4536) facing 1 (id 12)
  0.33  RESERVE: zone 14 at (552, 4488) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (552, 4488) facing 1 (id 13)
  0.33  RESERVE: zone 15 at (552, 4440) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (552, 4440) facing 1 (id 14)
  0.33  RESERVE: zone 16 at (552, 4392) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (552, 4392) facing 1 (id 15)
  0.33  RESERVE: zone 17 at (552, 4344) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (552, 4344) facing 1 (id 16)
  0.33  RESERVE: zone 18 at (600, 4536) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (600, 4536) facing 1 (id 17)
  0.33  RESERVE: zone 19 at (600, 4488) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (600, 4488) facing 1 (id 18)
  0.33  RESERVE: zone 20 at (600, 4440) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (600, 4440) facing 1 (id 19)
  0.33  RESERVE: zone 21 at (600, 4392) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (600, 4392) facing 1 (id 20)
  0.33  RESERVE: zone 22 at (600, 4344) facing 1, 3x3 cells: 9 of 9 held
  0.33  RESERVE: armnanotcplat at (600, 4344) facing 1 (id 21)
  0.33  RESERVE: zone 23 at (-80, 4592) facing 1, 15x40 cells: 440 of 600 held
  0.33  RESERVE: refused armnanotcplat at (8, 4664): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4616): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4568): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4520): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4664): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4616): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4568): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4520): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4664): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4616): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4568): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4520): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4664): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4616): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4568): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4520): off map
  0.33  RESERVE: zone 23 released
  0.33  RESERVE: zone 24 at (-80, 4464) facing 1, 15x40 cells: 440 of 600 held
  0.33  RESERVE: refused armnanotcplat at (8, 4536): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4488): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4440): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4392): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4536): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4488): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4440): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4392): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4536): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4488): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4440): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4392): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4536): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4488): off map
  0.33  RESERVE: refused armnanotcplat at (8, 4440): off map
```
