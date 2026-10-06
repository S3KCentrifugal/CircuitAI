# Playtest report: PASS

- Verdict: **PASS** (reached 10 min)
- Game time reached: 10.1 min (frame 18201); wall 106 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (aff90f713fc9746a); AI BARbTest/test; staged 2026-10-05T20:48:15
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/cortex/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: seaplane-transition.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-cortex\supreme\20261005T234815Z-223643fa\runs\20261005T235010Z-46bbe5e4\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `mex` | seen at 1.1 min | `[t=00:00:48.694104][f=0002052] [SeaTransition] PASS mex completed by first construction ship` |
| expect `platform` | seen at 3.7 min | `[t=00:01:05.215222][f=0006714] [SeaTransition] PASS platform completed corplat` |
| expect `aircraft` | seen at 4.3 min | `[t=00:01:08.371080][f=0007659] [SeaTransition] PASS aircraft produced corsb` |
| expect `footprint` | seen at 1.0 min | `[SeaTransition] footprint slots=20 platform=corplat` |
| expect `support` | seen at 5.5 min | `[t=00:01:15.842067][f=0009900] [SeaTransition] PASS platform assistance turrets=13 assisting=1` |
| forbid `errors` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-cortex\supreme\20261005T234815Z-223643fa\runs\20261005T235010Z-46bbe5e4\screen_2026-10-05_23-49-12-249.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-cortex\supreme\20261005T234815Z-223643fa\runs\20261005T235010Z-46bbe5e4\screen_2026-10-05_23-49-25-543.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-cortex\supreme\20261005T234815Z-223643fa\runs\20261005T235010Z-46bbe5e4\screen_2026-10-05_23-49-56-536.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 10, 3 shots, end at 10.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished corcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side cortex ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.00  [Playtest] speed 10
  0.05  [Playtest] frame 90 team 0 ally 0 side cortex ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.17  [Playtest] finished corsy team 0 at 0.17 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.20  [Playtest] finished cormex team 0 at 0.20 min
  0.22  [SEA][Layout] berth sea.berth.0 corsy at=6016,11072 facing=2
  0.22  [Team][Roster] first mex 7708 at 4607,11071
  0.22  [Team][Roster] Re-announced: roster|1|0|0|SEA|cortex|corsy|4775|11078|0|7|1|4607|11071
  0.40  [Playtest] finished cormex team 0 at 0.40 min
  0.43  [SEA][Layout] berth sea.berth.1 corasy at=5904,10368 facing=2
  0.62  [SEA][Layout] berth sea.berth.2 corplat at=6176,11072 facing=2
  0.64  [Playtest] finished cormex team 0 at 0.64 min
  0.83  [Playtest] finished corllt team 0 at 0.83 min
  0.99  [Playtest] finished corrad team 0 at 0.99 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.9 bank 99653/100250, energy +1257.0 bank 1002624/1002650, units 11
  1.00  [Playtest] camera requested (6200,11000) height=3200
  1.00  [Playtest] camera captured name=ta position=(6200,11000) height=3200
  1.00  [Playtest] screenshot at 1.0 min of team 0 at (6200, 11000)
  1.14  [Playtest] finished cormex team 0 at 1.14 min
  1.60  [Playtest] finished cormex team 0 at 1.60 min
  1.65  [Playtest] finished cormex team 0 at 1.65 min
  1.79  [Playtest] finished cornanotcplat team 0 at 1.79 min
  1.81  [Playtest] finished corllt team 0 at 1.81 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +15.8 bank 99755/100400, energy +1264.0 bank 1002651/1002700, units 17
  2.00  [Playtest] finished corasy team 0 at 2.00 min
  2.24  [Playtest] finished cormex team 0 at 2.24 min
  2.57  [Playtest] finished cortl team 0 at 2.57 min
  2.84  [Playtest] finished cormex team 0 at 2.84 min
  2.86  [Playtest] finished cornanotcplat team 0 at 2.86 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +20.4 bank 97061/100700, energy +1322.0 bank 1002998/1003250, units 33
  3.00  [Playtest] camera requested (6200,11000) height=3800
  3.00  [Playtest] camera captured name=ta position=(6200,11000) height=3800
  3.00  [Playtest] screenshot at 3.0 min of team 0 at (6200, 11000)
  3.01  [Playtest] finished cornanotcplat team 0 at 3.01 min
  3.17  [Playtest] finished cortl team 0 at 3.17 min
  3.29  [Playtest] finished cornanotcplat team 0 at 3.29 min
  3.48  [Playtest] finished cornanotcplat team 0 at 3.48 min
  3.50  [Playtest] finished coruwmme team 0 at 3.50 min
  3.58  [Playtest] finished cornanotcplat team 0 at 3.58 min
  3.65  [Playtest] finished cornanotcplat team 0 at 3.65 min
  3.73  [Playtest] finished corplat team 0 at 3.73 min
  3.75  [Playtest] finished cornanotcplat team 0 at 3.75 min
  3.79  [Playtest] finished cornanotcplat team 0 at 3.79 min
  3.84  [Playtest] finished cornanotcplat team 0 at 3.84 min
  3.89  [Playtest] finished cornanotcplat team 0 at 3.89 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +27.3 bank 90108/101250, energy +1352.0 bank 984943/1003600, units 53
  4.08  [Playtest] finished cornanotcplat team 0 at 4.08 min
  4.12  [Playtest] finished cornanotcplat team 0 at 4.12 min
  4.12  [Playtest] finished coruwmme team 0 at 4.12 min
  4.13  [Playtest] finished cornanotcplat team 0 at 4.13 min
  4.16  [Playtest] finished cornanotcplat team 0 at 4.16 min
  4.21  [Playtest] finished cornanotcplat team 0 at 4.20 min
  4.26  [Playtest] finished cortl team 0 at 4.26 min
  4.40  [Playtest] finished coruwmme team 0 at 4.40 min
  4.55  [Playtest] finished corfrad team 0 at 4.55 min
  4.58  [Playtest] finished cormex team 0 at 4.58 min
  4.74  [Playtest] finished cornanotcplat team 0 at 4.74 min
  4.75  [Playtest] finished coruwmme team 0 at 4.74 min
  4.81  [Playtest] finished corfrad team 0 at 4.81 min
  4.85  [Playtest] finished cortl team 0 at 4.85 min
  4.90  [Playtest] finished cornanotcplat team 0 at 4.90 min
  4.97  [Playtest] finished cornanotcplat team 0 at 4.97 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +50.0 bank 80728/102950, energy +1712.0 bank 928687/1005400, units 74
  5.01  [Playtest] finished cornanotcplat team 0 at 5.01 min
  5.10  [Playtest] finished cornanotcplat team 0 at 5.10 min
  5.16  [Playtest] finished corfrad team 0 at 5.16 min
  5.16  [Playtest] finished cormex team 0 at 5.16 min
  5.18  [Playtest] finished cornanotcplat team 0 at 5.18 min
  5.23  [Playtest] finished cornanotcplat team 0 at 5.23 min
  5.29  [Playtest] finished cornanotcplat team 0 at 5.29 min
  5.35  [Playtest] finished cornanotcplat team 0 at 5.35 min
  5.39  [Playtest] finished cornanotcplat team 0 at 5.39 min
  5.41  [Playtest] finished cornanotcplat team 0 at 5.41 min
  5.45  [Playtest] finished cornanotcplat team 0 at 5.45 min
  5.49  [Playtest] finished cornanotcplat team 0 at 5.49 min
  5.53  [Playtest] finished cornanotcplat team 0 at 5.53 min
  5.53  [Playtest] finished cornanotcplat team 0 at 5.53 min
  5.57  [Playtest] finished cormex team 0 at 5.57 min
  5.62  [Playtest] finished cornanotcplat team 0 at 5.62 min
  5.62  [Playtest] finished cornanotcplat team 0 at 5.62 min
  5.73  [Playtest] finished cornanotcplat team 0 at 5.73 min
  5.74  [Playtest] finished cornanotcplat team 0 at 5.74 min
  5.78  [Playtest] finished cornanotcplat team 0 at 5.78 min
  5.82  [Playtest] finished cornanotcplat team 0 at 5.82 min
  5.86  [Playtest] finished cornanotcplat team 0 at 5.86 min
  5.89  [Playtest] finished cornanotcplat team 0 at 5.89 min
  5.90  [Playtest] finished cormex team 0 at 5.90 min
  5.93  [Playtest] finished cornanotcplat team 0 at 5.93 min
  5.99  [Playtest] finished cornanotcplat team 0 at 5.99 min
  5.99  [Playtest] finished cornanotcplat team 0 at 5.99 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +56.4 bank 68294/103100, energy +1712.0 bank 798438/1005400, units 118
  6.03  [Playtest] finished cornanotcplat team 0 at 6.03 min
  6.03  [Playtest] finished cornanotcplat team 0 at 6.03 min
  6.08  [Playtest] finished cornanotcplat team 0 at 6.08 min
  6.18  [Playtest] finished cornanotcplat team 0 at 6.18 min
  6.24  [Playtest] finished cornanotcplat team 0 at 6.24 min
  6.29  [Playtest] finished cornanotcplat team 0 at 6.29 min
  6.29  [Playtest] finished cornanotcplat team 0 at 6.29 min
  6.30  [Playtest] finished cormex team 0 at 6.30 min
  6.33  [Playtest] finished cornanotcplat team 0 at 6.34 min
  6.38  [Playtest] finished cornanotcplat team 0 at 6.38 min
  6.42  [Playtest] finished cornanotcplat team 0 at 6.42 min
  6.48  [Playtest] finished cornanotcplat team 0 at 6.48 min
  6.49  [Playtest] finished cornanotcplat team 0 at 6.49 min
  6.56  [Playtest] finished cormex team 0 at 6.56 min
  6.67  [Playtest] finished cornanotcplat team 0 at 6.67 min
  6.68  [SEA][Layout] berth sea.berth.3 corsy at=6544,9040 facing=2
  6.69  [Playtest] finished cornanotcplat team 0 at 6.69 min
  6.72  [Playtest] finished cornanotcplat team 0 at 6.72 min
  6.76  [Playtest] finished cornanotcplat team 0 at 6.76 min
  6.83  [Playtest] finished cormex team 0 at 6.83 min
  6.99  [Playtest] finished corllt team 0 at 6.99 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +63.3 bank 55508/103250, energy +1712.0 bank 643328/1005400, units 155
  7.07  [Playtest] finished corrad team 0 at 7.07 min
  7.21  [Playtest] finished cornanotcplat team 0 at 7.22 min
  7.26  [Playtest] finished cornanotcplat team 0 at 7.26 min
  7.29  [Playtest] finished cornanotcplat team 0 at 7.29 min
  7.31  [Playtest] finished cornanotcplat team 0 at 7.31 min
  7.33  [Playtest] finished cornanotcplat team 0 at 7.33 min
  7.34  [Playtest] finished cornanotcplat team 0 at 7.34 min
  7.51  [Playtest] finished cormex team 0 at 7.51 min
  7.71  [Playtest] finished corllt team 0 at 7.71 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +65.6 bank 43087/103300, energy +1712.0 bank 515299/1005400, units 189
  8.00  [Playtest] camera requested (6200,11000) height=4000
  8.01  [Playtest] camera captured name=ta position=(6200,11000) height=4000
  8.01  [Playtest] screenshot at 8.0 min of team 0 at (6200, 11000)
  8.31  [Playtest] finished corllt team 0 at 8.31 min
  8.50  [Playtest] finished corrad team 0 at 8.50 min
  8.93  [Playtest] finished corllt team 0 at 8.93 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +65.6 bank 31602/103300, energy +1712.0 bank 402434/1005400, units 216
  9.24  [Playtest] finished corllt team 0 at 9.24 min
  9.39  [Playtest] finished corrad team 0 at 9.39 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +65.6 bank 20415/103300, energy +1712.0 bank 297099/1005400, units 241
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: corcom(22389) at (4775, 11078) walks to (4747, 11077), 139 from the cormex site (4608, 11072)
  0.10  EXP: idle: corcom(22389) on cormex at (4753, 11077), site (4608, 11072), target yes, fails 2 (arrived at the approach point)
  0.18  RESERVE: zone 1 at (5736, 10584) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5736, 10584) facing 2 (id 1)
  0.18  RESERVE: zone 2 at (5688, 10584) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5688, 10584) facing 2 (id 2)
  0.18  RESERVE: zone 3 at (5640, 10584) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5640, 10584) facing 2 (id 3)
  0.18  RESERVE: zone 1 released
  0.18  RESERVE: zone 2 released
  0.18  RESERVE: zone 3 released
  0.18  RESERVE: zone 4 at (5736, 10504) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5736, 10504) facing 2 (id 4)
  0.18  RESERVE: zone 5 at (5688, 10504) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5688, 10504) facing 2 (id 5)
  0.18  RESERVE: zone 6 at (5640, 10504) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5640, 10504) facing 2 (id 6)
  0.18  RESERVE: zone 4 released
  0.18  RESERVE: zone 5 released
  0.18  RESERVE: zone 6 released
  0.18  RESERVE: zone 7 at (5784, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5784, 10456) facing 2 (id 7)
  0.18  RESERVE: zone 8 at (5736, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5736, 10456) facing 2 (id 8)
  0.18  RESERVE: zone 9 at (5688, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5688, 10456) facing 2 (id 9)
  0.18  RESERVE: zone 10 at (5640, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (5640, 10456) facing 2 (id 10)
  0.18  RESERVE: zone 7 released
  0.18  RESERVE: zone 8 released
  0.18  RESERVE: zone 9 released
  0.18  RESERVE: zone 10 released
  0.18  RESERVE: corridor 11 at (5824, 11024) facing 0, 12x30 cells: 228 of 360 held
  0.18  RESERVE: zone 12 at (5952, 11520) facing 2, 40x40 cells: 1552 of 1600 held
  0.18  RESERVE: zone 12 released
  0.18  RESERVE: zone 13 at (6080, 11520) facing 2, 40x40 cells: 1560 of 1600 held
  0.18  RESERVE: grid of cornanotcplat 4x4 gap 0 behind (6080, 11424) facing 2: 2 of 16 slots (group 2, held, zone)
  0.18  RESERVE: zone 13 released
  0.18  RESERVE: zone 14 at (6208, 11520) facing 2, 40x40 cells: 1592 of 1600 held
  0.18  RESERVE: grid of cornanotcplat 4x4 gap 0 behind (6208, 11424) facing 2: 8 of 16 slots (group 3, held, zone)
  0.18  RESERVE: zone 14 released
  0.20  RESERVE: zone 15 at (5848, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (5848, 10408) facing 2 (id 21)
  0.20  RESERVE: zone 16 at (5800, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (5800, 10408) facing 2 (id 22)
  0.20  RESERVE: zone 17 at (5752, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (5752, 10408) facing 2 (id 23)
  0.20  RESERVE: zone 18 at (5704, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (5704, 10408) facing 2 (id 24)
  0.20  RESERVE: zone 19 at (5656, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (5656, 10408) facing 2 (id 25)
  0.20  RESERVE: zone 20 at (5848, 10360) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (5848, 10360) facing 2 (id 26)
  0.20  RESERVE: zone 21 at (5800, 10360) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (5800, 10360) facing 2 (id 27)
  0.20  RESERVE: zone 22 at (5752, 10360) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (5752, 10360) facing 2 (id 28)
  0.20  RESERVE: zone 23 at (5704, 10360) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (5704, 10360) facing 2 (id 29)
  0.20  RESERVE: zone 15 released
  0.20  RESERVE: zone 16 released
  0.20  RESERVE: zone 17 released
  0.20  RESERVE: zone 18 released
  0.20  RESERVE: zone 19 released
  0.20  RESERVE: zone 20 released
  0.20  RESERVE: zone 21 released
  0.20  RESERVE: zone 22 released
  0.20  RESERVE: zone 23 released
  0.20  RESERVE: zone 24 at (5928, 10392) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (5928, 10392) facing 2 (id 30)
  0.20  RESERVE: zone 25 at (5880, 10392) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (5880, 10392) facing 2 (id 31)
  0.20  RESERVE: zone 26 at (5832, 10392) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (5832, 10392) facing 2 (id 32)
  0.20  RESERVE: zone 27 at (5784, 10392) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (5784, 10392) facing 2 (id 33)
  0.20  RESERVE: zone 28 at (5736, 10392) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (5736, 10392) facing 2 (id 34)
  0.20  RESERVE: zone 24 released
  0.20  RESERVE: zone 25 released
  0.20  RESERVE: zone 26 released
  0.20  RESERVE: zone 27 released
  0.20  RESERVE: zone 28 released
  0.20  RESERVE: zone 29 at (5992, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (5992, 10408) facing 2 (id 35)
  0.20  RESERVE: zone 30 at (5944, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (5944, 10408) facing 2 (id 36)
  0.20  RESERVE: zone 31 at (5896, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (5896, 10408) facing 2 (id 37)
  0.20  RESERVE: zone 32 at (5848, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (5848, 10408) facing 2 (id 38)
  0.20  RESERVE: zone 33 at (5800, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (5800, 10408) facing 2 (id 39)
  0.20  RESERVE: zone 29 released
  0.20  RESERVE: zone 30 released
  0.20  RESERVE: zone 31 released
  0.20  RESERVE: zone 32 released
  0.20  RESERVE: zone 33 released
  0.20  RESERVE: zone 34 at (6056, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (6056, 10456) facing 2 (id 40)
  0.20  RESERVE: zone 35 at (6008, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (6008, 10456) facing 2 (id 41)
  0.20  RESERVE: zone 36 at (5960, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (5960, 10456) facing 2 (id 42)
  0.20  RESERVE: zone 37 at (5912, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (5912, 10456) facing 2 (id 43)
  0.20  RESERVE: zone 38 at (5864, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (5864, 10456) facing 2 (id 44)
  0.20  RESERVE: zone 34 released
  0.20  RESERVE: zone 35 released
  0.20  RESERVE: zone 36 released
  0.20  RESERVE: zone 37 released
  0.20  RESERVE: zone 38 released
  0.20  RESERVE: zone 39 at (6104, 10504) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (6104, 10504) facing 2 (id 45)
  0.20  RESERVE: zone 40 at (6056, 10504) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (6056, 10504) facing 2 (id 46)
  0.20  RESERVE: zone 41 at (6008, 10504) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (6008, 10504) facing 2 (id 47)
  0.20  RESERVE: zone 42 at (5960, 10504) facing 2, 3x3 cells: 9 of 9 held
```
