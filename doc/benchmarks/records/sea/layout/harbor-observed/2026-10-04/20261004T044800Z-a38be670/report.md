# Playtest report: PASS

- Verdict: **PASS** (reached 20 min)
- Game time reached: 20.1 min (frame 36137); wall 148 s
- DLL: build-theatres\d188-build-6\SkirmishAI.dll (ac71826721992d84); AI BARbTest/test; staged 2026-10-04T01:45:27
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: harbor-lifecycle.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\harbor-observed\glacial\20261004T044526Z-93b1ae26\runs\20261004T044800Z-a38be670\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `adoption` | seen at 1.0 min | `[SeaProbe] PASS named-state adoption` |
| expect `replan` | seen at 1.6 min | `[SeaProbe] PASS physical blocker replanned unused berth` |
| expect `egress` | seen at 4.0 min | `[SEA][Harbor] exit verified yard=19236 ship=19713` |
| expect `retired` | seen at 4.9 min | `[SeaProbe] PASS original yard entered retirement` |
| expect `removed` | seen at 5.0 min | `[SeaProbe] PASS original yard physically removed` |
| expect `physical-handover` | seen at 4.9 min | `[t=00:01:15.350981][f=0008893] [SeaFixture] PASS replacement exit precedes old reclaim old=19236 new=11483` |
| expect `reclaimed` | seen at 5.0 min | `[t=00:01:16.737585][f=0009068] [SeaFixture] PASS observed old yard removal after reclaim` |
| forbid `runtime` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\harbor-observed\glacial\20261004T044526Z-93b1ae26\runs\20261004T044800Z-a38be670\screen_2026-10-04_04-46-49-762.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\harbor-observed\glacial\20261004T044526Z-93b1ae26\runs\20261004T044800Z-a38be670\screen_2026-10-04_04-47-11-094.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\harbor-observed\glacial\20261004T044526Z-93b1ae26\runs\20261004T044800Z-a38be670\screen_2026-10-04_04-47-53-321.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 3 shots, end at 20.5 min
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
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|1423|4027|0|4|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(700,4597) factory=armsy landLocked=no spot=5 known=1/2
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(1899,5801) factory=corsy landLocked=no spot=6 known=2/2
  0.23  [SEA][Layout] berth sea.berth.0 armsy at=1616,4032 facing=1
  0.25  [SEA][Layout] berth sea.berth.1 armasy at=1424,3632 facing=1
  0.28  [SEA][Layout] berth sea.berth.2 armasy at=1488,3296 facing=3
  0.31  [Playtest] finished armtl team 0 at 0.31 min
  0.61  [Playtest] finished armsy team 0 at 0.61 min
  0.74  [Playtest] finished armmex team 0 at 0.74 min
  0.75  [Team][Roster] first mex 660 at 1424,4096
  0.75  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1423|4027|0|4|1|1424|4096
  0.91  [Playtest] finished armmex team 0 at 0.91 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 474/1200, energy +30.0 bank 200/1100, units 6
  1.02  [SEA][Layout] enabled; adopted berths=3 patches=4
  1.21  [Playtest] finished armtide team 0 at 1.21 min
  1.27  [Playtest] finished armtide team 0 at 1.27 min
  1.28  [SEA][Layout] replan unused berth sea.berth.1
  1.42  [Playtest] finished armtide team 0 at 1.41 min
  1.42  [SEA][Layout] berth sea.berth.1 armasy at=1616,3632 facing=1
  1.46  [Playtest] finished armtide team 0 at 1.46 min
  1.62  [Playtest] finished armtide team 0 at 1.62 min
  1.76  [Playtest] finished armtide team 0 at 1.76 min
  1.85  [Playtest] finished armmex team 0 at 1.85 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 11/1250, energy +182.0 bank 1486/1500, units 17
  2.02  [Playtest] finished armuwfus team 0 at 2.02 min
  2.02  [Playtest] finished armuwfus team 0 at 2.02 min
  2.02  [Playtest] finished armuwfus team 0 at 2.02 min
  2.02  [Playtest] finished armuwfus team 0 at 2.02 min
  2.02  [Playtest] finished armuwfus team 0 at 2.02 min
  2.02  [Playtest] finished armuwfus team 0 at 2.02 min
  2.03  [Playtest] finished armuwmmm team 0 at 2.03 min
  2.03  [Playtest] finished armuwmmm team 0 at 2.03 min
  2.03  [Playtest] finished armuwmmm team 0 at 2.03 min
  2.03  [Playtest] finished armuwmmm team 0 at 2.03 min
  2.03  [Playtest] finished armuwmmm team 0 at 2.03 min
  2.03  [Playtest] finished armuwmmm team 0 at 2.03 min
  2.03  [Playtest] finished armuwmmm team 0 at 2.03 min
  2.03  [Playtest] finished armuwmmm team 0 at 2.03 min
  2.03  [Playtest] finished armuwmmm team 0 at 2.03 min
  2.03  [Playtest] finished armuwmmm team 0 at 2.03 min
  2.03  [Playtest] finished armuwmmm team 0 at 2.03 min
  2.03  [Playtest] finished armuwmmm team 0 at 2.03 min
  2.04  [Playtest] finished armuwms team 0 at 2.04 min
  2.04  [Playtest] finished armuwms team 0 at 2.04 min
  2.04  [Playtest] finished armuwms team 0 at 2.04 min
  2.04  [Playtest] finished armuwms team 0 at 2.04 min
  2.04  [Playtest] finished armuwes team 0 at 2.04 min
  2.04  [Playtest] finished armuwes team 0 at 2.04 min
  2.04  [Playtest] finished armuwes team 0 at 2.04 min
  2.04  [Playtest] finished armuwes team 0 at 2.04 min
  2.07  [Playtest] finished armtide team 0 at 2.07 min
  2.26  [Playtest] finished armtl team 0 at 2.26 min
  2.29  [Playtest] finished armmex team 0 at 2.29 min
  2.37  [Playtest] finished armfrad team 0 at 2.37 min
  2.64  [Playtest] finished armuwmme team 0 at 2.64 min
  2.71  [Playtest] finished armuwmme team 0 at 2.71 min
  2.81  [Playtest] finished armuwmme team 0 at 2.81 min
  2.90  [SEA][Layout] berth sea.berth.3 armsy at=2800,3904 facing=1
  3.00  [Playtest] eco team 0 at 3.0 min: metal +148.8 bank 8683/14900, energy +7525.0 bank 34354/41150, units 58
  3.23  [Playtest] finished armasy team 0 at 3.23 min
  3.49  [Playtest] finished armsy team 0 at 3.49 min
  3.51  [Playtest] finished armnanotcplat team 0 at 3.51 min
  3.66  [Playtest] finished armmex team 0 at 3.66 min
  3.73  [Playtest] finished armtl team 0 at 3.73 min
  3.90  [Playtest] finished armmex team 0 at 3.90 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +149.6 bank 13178/15300, energy +7562.0 bank 34590/41650, units 68
  4.12  [Playtest] finished armmex team 0 at 4.12 min
  4.23  [Playtest] finished armnanotcplat team 0 at 4.23 min
  4.27  [Playtest] finished armllt team 0 at 4.27 min
  4.39  [Playtest] finished armrad team 0 at 4.39 min
  4.41  [Playtest] finished armnanotcplat team 0 at 4.41 min
  4.55  [Playtest] finished armnanotcplat team 0 at 4.55 min
  4.58  [Playtest] finished armnanotcplat team 0 at 4.58 min
  4.59  [Playtest] finished armnanotcplat team 0 at 4.59 min
  4.65  [Playtest] finished armnanotcplat team 0 at 4.65 min
  4.71  [Playtest] finished armnanotcplat team 0 at 4.71 min
  4.75  [Playtest] finished armnanotcplat team 0 at 4.75 min
  4.79  [Playtest] finished armnanotcplat team 0 at 4.79 min
  4.89  [Playtest] finished armnanotcplat team 0 at 4.89 min
  4.94  [Playtest] finished armnanotcplat team 0 at 4.94 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +142.7 bank 14573/15350, energy +7583.0 bank 34500/41800, units 89
  5.00  [Playtest] camera requested (2200,4200) height=3500
  5.00  [Playtest] finished armnanotcplat team 0 at 5.00 min
  5.01  [Playtest] camera captured name=ta position=(2200,4200) height=3500
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (2200, 4200)
  5.04  [Playtest] finished armnanotcplat team 0 at 5.04 min
  5.08  [Playtest] finished armnanotcplat team 0 at 5.08 min
  5.57  [SEA][Layout] berth sea.berth.4 armasy at=2944,4320 facing=1
  5.92  [Playtest] finished armuwfus team 0 at 5.92 min
  5.98  [Playtest] finished armmex team 0 at 5.98 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +157.1 bank 11724/15300, energy +8783.0 bank 40836/44200, units 98
  6.40  [Playtest] finished armuwmme team 0 at 6.40 min
  6.58  [Playtest] finished armtide team 0 at 6.58 min
  6.84  [Playtest] finished armasy team 0 at 6.84 min
  6.93  [Playtest] finished armfrad team 0 at 6.93 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +164.1 bank 12255/16050, energy +8806.0 bank 41281/44450, units 112
  7.15  [Playtest] finished armuwmme team 0 at 7.15 min
  7.25  [Playtest] finished armtl team 0 at 7.25 min
  7.51  [Playtest] finished armmex team 0 at 7.51 min
  7.66  [Playtest] finished armuwmme team 0 at 7.66 min
  7.71  [Playtest] finished armtl team 0 at 7.71 min
  7.73  [Playtest] finished armuwmme team 0 at 7.73 min
  7.82  [Playtest] finished armnanotcplat team 0 at 7.82 min
  7.86  [Playtest] finished armnanotcplat team 0 at 7.86 min
  7.93  [Playtest] finished armnanotcplat team 0 at 7.93 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +190.1 bank 12624/17900, energy +8806.0 bank 37325/44450, units 130
  8.00  [Playtest] finished armmex team 0 at 8.00 min
  8.04  [Playtest] finished armuwmme team 0 at 8.04 min
  8.21  [Playtest] finished armmex team 0 at 8.21 min
  8.41  [Playtest] finished armmex team 0 at 8.41 min
  8.84  [Playtest] finished armnanotcplat team 0 at 8.84 min
  8.90  [Playtest] finished armnanotcplat team 0 at 8.90 min
  8.94  [Playtest] finished armnanotcplat team 0 at 8.94 min
  9.00  [Playtest] finished armnanotcplat team 0 at 9.00 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +176.7 bank 17006/18450, energy +8896.0 bank 36099/44700, units 151
  9.01  [Playtest] finished armnanotcplat team 0 at 9.01 min
  9.03  [Playtest] finished armnanotcplat team 0 at 9.03 min
  9.09  [Playtest] finished armnanotcplat team 0 at 9.09 min
  9.13  [Playtest] finished armnanotcplat team 0 at 9.14 min
  9.17  [Playtest] finished armuwmmm team 0 at 9.17 min
  9.26  [Playtest] finished armmship team 0 at 9.26 min
  9.27  [Playtest] finished armnanotcplat team 0 at 9.27 min
  9.33  [Playtest] finished armnanotcplat team 0 at 9.33 min
  9.39  [Playtest] finished armnanotcplat team 0 at 9.39 min
  9.44  [Playtest] finished armnanotcplat team 0 at 9.44 min
  9.44  [Playtest] finished armuwfus team 0 at 9.44 min
  9.50  [Playtest] finished armnanotcplat team 0 at 9.50 min
  9.55  [Playtest] finished armnanotcplat team 0 at 9.55 min
  9.62  [SEA][Layout] berth sea.berth.5 armsy at=4016,4288 facing=1
  9.64  [Playtest] finished armnanotcplat team 0 at 9.64 min
  9.73  [Playtest] finished armnanotcplat team 0 at 9.73 min
  9.79  [Playtest] finished armnanotcplat team 0 at 9.80 min
  9.82  [Playtest] finished armnanotcplat team 0 at 9.82 min
  9.83  [Playtest] finished armmship team 0 at 9.83 min
  9.86  [Playtest] finished armnanotcplat team 0 at 9.86 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +214.5 bank 11060/18450, energy +10126.0 bank 43132/47350, units 176
 10.00  [Playtest] camera requested (2200,4200) height=3500
 10.01  [Playtest] camera captured name=ta position=(2200,4200) height=3500
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (2200, 4200)
 10.05  [Playtest] finished armmship team 0 at 10.06 min
 10.28  [Playtest] finished armnanotcplat team 0 at 10.28 min
 10.33  [Playtest] finished armmship team 0 at 10.33 min
 10.43  [Playtest] finished armsy team 0 at 10.43 min
 10.49  [Playtest] finished armmship team 0 at 10.49 min
 10.82  [Playtest] finished armuwmme team 0 at 10.82 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +181.3 bank 783/19150, energy +10456.0 bank 39452/49100, units 202
 11.01  [Playtest] finished armmex team 0 at 11.01 min
 11.03  [Playtest] finished armuwmme team 0 at 11.02 min
 11.12  [Playtest] finished armmex team 0 at 11.12 min
 11.28  [Playtest] finished armnanotcplat team 0 at 11.28 min
 11.51  [Playtest] finished armfrad team 0 at 11.51 min
 11.52  [Playtest] finished armuwmme team 0 at 11.52 min
 11.54  [Playtest] finished armuwmme team 0 at 11.54 min
 11.56  [Playtest] finished armuwmmm team 0 at 11.56 min
 11.57  [Playtest] finished armtl team 0 at 11.57 min
 11.63  [Playtest] finished armuwmmm team 0 at 11.63 min
 11.68  [Playtest] finished armuwmme team 0 at 11.68 min
 11.71  [Playtest] finished armuwmme team 0 at 11.71 min
 11.72  [Playtest] finished armuwmme team 0 at 11.72 min
 11.72  [Playtest] finished armmex team 0 at 11.72 min
 11.81  [Playtest] finished armuwmme team 0 at 11.81 min
 11.84  [Playtest] finished armuwmme team 0 at 11.84 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +279.8 bank 243/24050, energy +10456.0 bank 40529/49100, units 210
 12.12  [Playtest] finished armuwmme team 0 at 12.11 min
 12.19  [Playtest] finished armuwmme team 0 at 12.19 min
 12.24  [Playtest] finished armepoch team 0 at 12.24 min
 12.44  [Playtest] finished armtl team 0 at 12.44 min
 12.63  [SEA][Layout] berth sea.berth.6 armsy at=1712,4032 facing=1
 12.89  [Playtest] finished armfmkr team 0 at 12.89 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +326.1 bank 15387/25100, energy +10456.0 bank 45568/49000, units 212
 13.13  [Playtest] finished armfmkr team 0 at 13.13 min
 13.31  [Playtest] finished armfmkr team 0 at 13.31 min
 13.31  [Playtest] finished armfmkr team 0 at 13.31 min
 13.31  [Playtest] finished armmex team 0 at 13.31 min
 13.34  [Playtest] finished armfrad team 0 at 13.34 min
 13.38  [Playtest] finished armmex team 0 at 13.38 min
 13.42  [Playtest] finished armuwmme team 0 at 13.42 min
 13.44  [Playtest] finished armfmkr team 0 at 13.44 min
 13.58  [Playtest] finished armtl team 0 at 13.58 min
 13.81  [Playtest] finished armuwmme team 0 at 13.81 min
 13.89  [Playtest] finished armtl team 0 at 13.89 min
 13.96  [Playtest] finished armtl team 0 at 13.96 min
 13.96  [Playtest] finished armmex team 0 at 13.96 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +299.6 bank 26298/26300, energy +10456.0 bank 40943/49000, units 228
 14.08  [Playtest] finished armfrad team 0 at 14.08 min
 14.20  [Playtest] finished armtl team 0 at 14.19 min
 14.29  [Playtest] finished armmex team 0 at 14.29 min
 14.57  [SEA][Layout] berth sea.berth.7 armasy at=4912,4624 facing=1
 14.58  [Playtest] finished armnanotcplat team 0 at 14.58 min
 14.63  [Playtest] finished armuwmme team 0 at 14.63 min
 14.73  [Playtest] finished armfrad team 0 at 14.73 min
 14.74  [Playtest] finished armuwmme team 0 at 14.74 min
 14.81  [Playtest] finished armuwmmm team 0 at 14.81 min
 14.86  [Playtest] finished armnanotcplat team 0 at 14.86 min
 14.95  [Playtest] finished armuwmme team 0 at 14.95 min
 14.95  [Playtest] finished armepoch team 0 at 14.95 min
 14.96  [Playtest] finished armtl team 0 at 14.96 min
 15.00  [Playtest] finished armuwmme team 0 at 15.00 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +390.9 bank 18460/28700, energy +10456.0 bank 41397/49000, units 241
 15.19  [Playtest] finished armnanotcplat team 0 at 15.19 min
 15.31  [Playtest] finished armuwmme team 0 at 15.31 min
 15.42  [Playtest] finished armtl team 0 at 15.42 min
 15.50  [Playtest] finished armuwmme team 0 at 15.50 min
 15.55  [Playtest] finished armbats team 0 at 15.55 min
 15.79  [Playtest] finished armbats team 0 at 15.79 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +360.4 bank 28909/29850, energy +11056.0 bank 40274/49000, units 251
 16.02  [Playtest] finished armbats team 0 at 16.02 min
 16.17  [Playtest] finished armmex team 0 at 16.17 min
 16.22  [Playtest] finished armmex team 0 at 16.22 min
 16.25  [Playtest] finished armbats team 0 at 16.25 min
 16.49  [Playtest] finished armbats team 0 at 16.49 min
 16.57  [SEA][Layout] berth sea.berth.8 armasy at=4912,4624 facing=1
 16.61  [Playtest] finished armfrad team 0 at 16.61 min
 16.63  [Playtest] finished armtl team 0 at 16.63 min
 16.72  [Playtest] finished armbats team 0 at 16.72 min
 16.90  [Playtest] finished armtl team 0 at 16.90 min
 16.91  [Playtest] finished armmex team 0 at 16.91 min
 16.91  [Playtest] finished armfrad team 0 at 16.92 min
 16.95  [Playtest] finished armbats team 0 at 16.95 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +395.5 bank 29997/30000, energy +10456.0 bank 41370/49000, units 270
 17.10  [Playtest] finished armtl team 0 at 17.10 min
 17.19  [Playtest] finished armbats team 0 at 17.19 min
 17.33  [Playtest] finished armuwmme team 0 at 17.33 min
 17.42  [Playtest] finished armbats team 0 at 17.42 min
 17.48  [Playtest] finished armtl team 0 at 17.48 min
 17.65  [Playtest] finished armbats team 0 at 17.65 min
 17.72  [Playtest] finished armmex team 0 at 17.72 min
 17.89  [Playtest] finished armbats team 0 at 17.89 min
 17.96  [Playtest] finished armuwmme team 0 at 17.96 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +371.3 bank 30542/31150, energy +10456.0 bank 40163/49000, units 280
 18.12  [Playtest] finished armbats team 0 at 18.12 min
 18.26  [Playtest] finished armtl team 0 at 18.26 min
 18.35  [Playtest] finished armbats team 0 at 18.35 min
 18.52  [Playtest] finished armtl team 0 at 18.52 min
 18.52  [Playtest] finished armuwfus team 0 at 18.52 min
 18.59  [Playtest] finished armbats team 0 at 18.59 min
 18.62  [Playtest] finished armfrad team 0 at 18.62 min
 18.82  [Playtest] finished armbats team 0 at 18.82 min
 18.98  [Playtest] finished armuwmme team 0 at 18.98 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +447.1 bank 31251/31700, energy +11656.0 bank 42707/51500, units 292
 19.00  [Playtest] camera requested (2200,4200) height=4000
 19.02  [Playtest] camera captured name=ta position=(2200,4200) height=4000
 19.02  [Playtest] screenshot at 19.0 min of team 0 at (2200, 4200)
 19.05  [Playtest] finished armbats team 0 at 19.05 min
 19.29  [Playtest] finished armbats team 0 at 19.29 min
 19.30  [Playtest] finished armtide team 0 at 19.30 min
 19.51  [Playtest] finished armuwmme team 0 at 19.51 min
 19.52  [Playtest] finished armbats team 0 at 19.52 min
 19.75  [Playtest] finished armbats team 0 at 19.75 min
 19.82  [Playtest] finished armfmkr team 0 at 19.82 min
 19.99  [Playtest] finished armbats team 0 at 19.99 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +411.0 bank 32247/32250, energy +11679.0 bank 43852/51550, units 302
```

## Native lines (all AIs, first 120)

```
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
  0.10  RESERVE: legnanotcplat at (13160, 4008) facing 3 (id 3)
  0.10  RESERVE: zone 5 at (13160, 4072) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (13160, 4072) facing 3 (id 4)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 released
  0.10  RESERVE: zone 6 at (13256, 3944) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (13256, 3944) facing 3 (id 5)
  0.10  RESERVE: zone 7 at (13256, 4008) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (13256, 4008) facing 3 (id 6)
  0.10  RESERVE: zone 8 at (13256, 4072) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (13256, 4072) facing 3 (id 7)
  0.10  RESERVE: zone 9 at (13192, 3944) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (13192, 3944) facing 3 (id 8)
  0.10  RESERVE: zone 10 at (13192, 4008) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (13192, 4008) facing 3 (id 9)
  0.10  RESERVE: zone 11 at (13192, 4072) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (13192, 4072) facing 3 (id 10)
  0.10  RESERVE: zone 12 at (13216, 4000) facing 3, 8x12 cells: 42 of 96 held
  0.10  RESERVE: zone 1 at (13696, 4592) facing 3, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (13696, 4592) facing 3 (id 1)
  0.10  RESERVE: corridor 2 at (13408, 4592) facing 3, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (13928, 4536) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (13928, 4536) facing 3 (id 2)
  0.10  RESERVE: zone 4 at (13928, 4600) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (13928, 4600) facing 3 (id 3)
  0.10  RESERVE: zone 5 at (13928, 4664) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (13928, 4664) facing 3 (id 4)
  0.10  RESERVE: zone 6 at (13864, 4536) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (13864, 4536) facing 3 (id 5)
  0.10  RESERVE: zone 7 at (13864, 4600) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (13864, 4600) facing 3 (id 6)
  0.10  RESERVE: zone 8 at (13864, 4664) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (13864, 4664) facing 3 (id 7)
  0.10  RESERVE: zone 9 at (13888, 4592) facing 3, 8x12 cells: 38 of 96 held
  0.12  RESERVE: zone 30 at (704, 4192) facing 1, 12x12 cells: 144 of 144 held
  0.12  RESERVE: armasy at (704, 4192) facing 1 (id 28)
  0.12  RESERVE: corridor 31 at (1040, 4192) facing 1, 30x18 cells: 540 of 540 held
```
