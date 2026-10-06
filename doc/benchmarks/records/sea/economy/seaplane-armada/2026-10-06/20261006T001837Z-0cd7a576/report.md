# Playtest report: PASS

- Verdict: **PASS** (reached 10 min)
- Game time reached: 10.1 min (frame 18140); wall 118 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (aff90f713fc9746a); AI BARbTest/test; staged 2026-10-05T21:16:30
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: seaplane-transition.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada\supreme\20261006T001630Z-4fb702b0\runs\20261006T001837Z-0cd7a576\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `income_hold` | seen at 3.5 min | `[t=00:01:15.446742][f=0006300] [SeaTransition] PASS low-income T2 holds platform despite supplied bank` |
| expect `mex` | seen at 1.1 min | `[t=00:00:59.896965][f=0001929] [SeaTransition] PASS mex completed by first construction ship` |
| expect `platform` | seen at 5.0 min | `[t=00:01:24.548966][f=0009032] [SeaTransition] PASS platform completed armplat` |
| expect `aircraft` | seen at 5.4 min | `[t=00:01:26.560392][f=0009636] [SeaTransition] PASS aircraft produced armsb` |
| expect `footprint` | seen at 5.0 min | `[SeaTransition] footprint slots=31 platform=armplat` |
| expect `support` | seen at 5.2 min | `[t=00:01:25.944259][f=0009450] [SeaTransition] PASS platform assistance turrets=3 assisting=3` |
| forbid `errors` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada\supreme\20261006T001630Z-4fb702b0\runs\20261006T001837Z-0cd7a576\screen_2026-10-06_00-17-39-963.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada\supreme\20261006T001630Z-4fb702b0\runs\20261006T001837Z-0cd7a576\screen_2026-10-06_00-17-53-251.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\seaplane-armada\supreme\20261006T001630Z-4fb702b0\runs\20261006T001837Z-0cd7a576\screen_2026-10-06_00-18-24-240.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 10, 3 shots, end at 10.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 41
  0.00  [Playtest] speed 10
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 41
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.17  [Playtest] finished armsy team 0 at 0.17 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.19  [Playtest] finished armmex team 0 at 0.19 min
  0.20  [Team][Roster] first mex 1880 at 4608,11072
  0.20  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4777|11079|0|7|1|4608|11072
  0.25  [SEA][Layout] berth sea.berth.0 armasy at=6096,10080 facing=2
  0.32  [SEA][Layout] berth sea.berth.1 armplat at=5904,9968 facing=2
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.3 bank 99433/100150, energy +1244.0 bank 1002656/1002700, units 10
  1.00  [Playtest] camera requested (6200,11000) height=3200
  1.01  [Playtest] camera captured name=ta position=(6200,11000) height=3200
  1.01  [Playtest] screenshot at 1.0 min of team 0 at (6200, 11000)
  1.07  [Playtest] finished armmex team 0 at 1.07 min
  1.62  [Playtest] finished armmex team 0 at 1.62 min
  1.64  [Playtest] finished armnanotcplat team 0 at 1.64 min
  1.95  [Playtest] finished armnanotcplat team 0 at 1.95 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.9 bank 97726/100250, energy +1244.0 bank 1002663/1002700, units 17
  2.00  [Playtest] finished armasy team 0 at 2.00 min
  2.02  [SEA][Layout] berth sea.berth.2 armsy at=6288,10080 facing=2
  2.12  [Playtest] finished armmex team 0 at 2.12 min
  2.22  [Playtest] finished armnanotcplat team 0 at 2.22 min
  2.46  [Playtest] finished armnanotcplat team 0 at 2.46 min
  2.70  [Playtest] finished armnanotcplat team 0 at 2.70 min
  2.89  [Playtest] finished armmex team 0 at 2.89 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +13.5 bank 93332/100550, energy +1274.0 bank 1002848/1003050, units 31
  3.00  [Playtest] camera requested (6200,11000) height=3800
  3.00  [Playtest] camera captured name=ta position=(6200,11000) height=3800
  3.00  [Playtest] screenshot at 3.0 min of team 0 at (6200, 11000)
  3.44  [Playtest] finished armmex team 0 at 3.44 min
  3.59  [Playtest] finished armnanotcplat team 0 at 3.59 min
  3.75  [Playtest] finished armmex team 0 at 3.75 min
  3.97  [Playtest] finished armuwmme team 0 at 3.97 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +75.0 bank 87573/101200, energy +1304.0 bank 1002233/1003200, units 42
  4.00  [Playtest] finished armuwfus team 0 at 4.00 min
  4.00  [Playtest] finished armuwmmm team 0 at 4.00 min
  4.00  [Playtest] finished armuwfus team 0 at 4.00 min
  4.00  [Playtest] finished armuwmmm team 0 at 4.00 min
  4.00  [Playtest] finished armuwfus team 0 at 4.00 min
  4.00  [Playtest] finished armuwmmm team 0 at 4.00 min
  4.00  [Playtest] finished armuwfus team 0 at 4.00 min
  4.00  [Playtest] finished armuwmmm team 0 at 4.00 min
  4.00  [Playtest] finished armuwfus team 0 at 4.00 min
  4.00  [Playtest] finished armuwmmm team 0 at 4.00 min
  4.00  [Playtest] finished armuwfus team 0 at 4.00 min
  4.00  [Playtest] finished armuwmmm team 0 at 4.00 min
  4.00  [Playtest] finished armuwfus team 0 at 4.00 min
  4.00  [Playtest] finished armuwmmm team 0 at 4.00 min
  4.00  [Playtest] finished armuwfus team 0 at 4.00 min
  4.00  [Playtest] finished armuwmmm team 0 at 4.00 min
  4.00  [Playtest] finished armuwfus team 0 at 4.00 min
  4.00  [Playtest] finished armuwmmm team 0 at 4.00 min
  4.00  [Playtest] finished armuwfus team 0 at 4.00 min
  4.00  [Playtest] finished armuwmmm team 0 at 4.00 min
  4.00  [Playtest] finished armuwfus team 0 at 4.00 min
  4.00  [Playtest] finished armuwmmm team 0 at 4.00 min
  4.00  [Playtest] finished armuwfus team 0 at 4.00 min
  4.00  [Playtest] finished armuwmmm team 0 at 4.00 min
  4.11  [Playtest] finished armnanotcplat team 0 at 4.11 min
  4.12  [Playtest] finished armuwmme team 0 at 4.12 min
  4.31  [Playtest] finished armnanotcplat team 0 at 4.31 min
  4.34  [Playtest] finished armmex team 0 at 4.34 min
  4.59  [Playtest] finished armmex team 0 at 4.59 min
  4.65  [Playtest] finished armnanotcplat team 0 at 4.65 min
  4.70  [SEA][Layout] berth sea.berth.1 armplat at=5952,10192 facing=2
  4.73  [Playtest] finished armnanotcplat team 0 at 4.73 min
  4.89  [Playtest] finished armmex team 0 at 4.89 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +162.1 bank 89614/101900, energy +16004.0 bank 1034090/1034700, units 82
  5.02  [Playtest] finished armplat team 0 at 5.02 min
  5.25  [Playtest] finished armnanotcplat team 0 at 5.25 min
  5.30  [Playtest] finished armmex team 0 at 5.30 min
  5.50  [Playtest] finished armnanotcplat team 0 at 5.50 min
  5.69  [Playtest] finished armmex team 0 at 5.69 min
  5.70  [Playtest] finished armnanotcplat team 0 at 5.70 min
  5.83  [Playtest] finished armuwmmm team 0 at 5.83 min
  5.83  [Playtest] finished armnanotcplat team 0 at 5.84 min
  5.98  [Playtest] finished armnanotcplat team 0 at 5.98 min
  5.99  [Playtest] finished armmex team 0 at 5.99 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +177.1 bank 90232/102050, energy +16004.0 bank 1033970/1034900, units 106
  6.13  [Playtest] finished armrad team 0 at 6.13 min
  6.14  [Playtest] finished armnanotcplat team 0 at 6.14 min
  6.30  [Playtest] finished armllt team 0 at 6.30 min
  6.42  [Playtest] finished armnanotcplat team 0 at 6.42 min
  6.53  [Playtest] finished armnanotcplat team 0 at 6.53 min
  6.69  [Playtest] finished armnanotcplat team 0 at 6.69 min
  6.80  [Playtest] finished armllt team 0 at 6.80 min
  6.88  [Playtest] finished armnanotcplat team 0 at 6.88 min
  6.95  [Playtest] finished armuwmmm team 0 at 6.95 min
  6.96  [Playtest] finished armrad team 0 at 6.95 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +189.7 bank 90446/102050, energy +16004.0 bank 1033615/1034900, units 131
  7.10  [Playtest] finished armnanotcplat team 0 at 7.10 min
  7.20  [Playtest] finished armnanotcplat team 0 at 7.20 min
  7.38  [Playtest] finished armnanotcplat team 0 at 7.38 min
  7.40  [Playtest] finished armllt team 0 at 7.40 min
  7.49  [Playtest] finished armnanotcplat team 0 at 7.49 min
  7.67  [Playtest] finished armnanotcplat team 0 at 7.67 min
  7.72  [Playtest] finished armllt team 0 at 7.72 min
  7.85  [Playtest] finished armshltxuw team 0 at 7.85 min
  7.88  [Playtest] finished armnanotcplat team 0 at 7.88 min
  7.92  [Playtest] finished armrad team 0 at 7.92 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +190.4 bank 81151/102850, energy +16004.0 bank 1034110/1036300, units 164
  8.00  [Playtest] camera requested (6200,11000) height=4000
  8.01  [Playtest] camera captured name=ta position=(6200,11000) height=4000
  8.01  [Playtest] screenshot at 8.0 min of team 0 at (6200, 11000)
  8.11  [Playtest] finished armnanotcplat team 0 at 8.11 min
  8.24  [Playtest] finished armnanotcplat team 0 at 8.24 min
  8.53  [Playtest] finished armasy team 0 at 8.53 min
  8.53  [Playtest] finished armnanotcplat team 0 at 8.53 min
  8.65  [Playtest] finished armnanotcplat team 0 at 8.65 min
  8.68  [Playtest] finished armmex team 0 at 8.68 min
  8.80  [Playtest] finished armnanotcplat team 0 at 8.80 min
  8.88  [Playtest] finished armnanotcplat team 0 at 8.88 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +194.2 bank 72678/103100, energy +16004.0 bank 1034069/1036500, units 199
  9.02  [Playtest] finished armnanotcplat team 0 at 9.02 min
  9.11  [Playtest] finished armnanotcplat team 0 at 9.11 min
  9.16  [Playtest] finished armmex team 0 at 9.16 min
  9.26  [Playtest] finished armnanotcplat team 0 at 9.26 min
  9.33  [Playtest] finished armllt team 0 at 9.33 min
  9.35  [Playtest] finished armnanotcplat team 0 at 9.35 min
  9.44  [Playtest] finished armuwmme team 0 at 9.44 min
  9.45  [Playtest] finished armnanotcplat team 0 at 9.45 min
  9.53  [Playtest] finished armrad team 0 at 9.53 min
  9.60  [Playtest] finished armnanotcplat team 0 at 9.60 min
  9.65  [Playtest] finished armnanotcplat team 0 at 9.65 min
  9.74  [Playtest] finished armnanotcplat team 0 at 9.74 min
  9.85  [Playtest] finished armnanotcplat team 0 at 9.85 min
  9.93  [Playtest] finished armnanotcplat team 0 at 9.93 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +201.2 bank 63963/103700, energy +16004.0 bank 1033742/1036500, units 238
```

## Native lines (all AIs, first 120)

```
  0.18  RESERVE: zone 1 at (5736, 10584) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5736, 10584) facing 2 (id 1)
  0.18  RESERVE: zone 2 at (5688, 10584) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5688, 10584) facing 2 (id 2)
  0.18  RESERVE: zone 3 at (5640, 10584) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5640, 10584) facing 2 (id 3)
  0.18  RESERVE: zone 1 released
  0.18  RESERVE: zone 2 released
  0.18  RESERVE: zone 3 released
  0.18  RESERVE: zone 4 at (5736, 10504) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5736, 10504) facing 2 (id 4)
  0.18  RESERVE: zone 5 at (5688, 10504) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5688, 10504) facing 2 (id 5)
  0.18  RESERVE: zone 6 at (5640, 10504) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5640, 10504) facing 2 (id 6)
  0.18  RESERVE: zone 4 released
  0.18  RESERVE: zone 5 released
  0.18  RESERVE: zone 6 released
  0.18  RESERVE: zone 7 at (5784, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5784, 10456) facing 2 (id 7)
  0.18  RESERVE: zone 8 at (5736, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5736, 10456) facing 2 (id 8)
  0.18  RESERVE: zone 9 at (5688, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5688, 10456) facing 2 (id 9)
  0.18  RESERVE: zone 10 at (5640, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (5640, 10456) facing 2 (id 10)
  0.18  RESERVE: zone 7 released
  0.18  RESERVE: zone 8 released
  0.18  RESERVE: zone 9 released
  0.18  RESERVE: zone 10 released
  0.18  RESERVE: corridor 11 at (5824, 11024) facing 0, 12x30 cells: 228 of 360 held
  0.18  RESERVE: zone 12 at (5952, 11520) facing 2, 40x40 cells: 1552 of 1600 held
  0.18  RESERVE: zone 12 released
  0.18  RESERVE: zone 13 at (6080, 11520) facing 2, 40x40 cells: 1560 of 1600 held
  0.18  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6080, 11424) facing 2: 2 of 16 slots (group 2, held, zone)
  0.18  RESERVE: zone 13 released
  0.18  RESERVE: zone 14 at (6208, 11520) facing 2, 40x40 cells: 1592 of 1600 held
  0.18  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6208, 11424) facing 2: 8 of 16 slots (group 3, held, zone)
  0.18  RESERVE: zone 14 released
  0.20  RESERVE: zone 15 at (5848, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5848, 10408) facing 2 (id 21)
  0.20  RESERVE: zone 16 at (5800, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5800, 10408) facing 2 (id 22)
  0.20  RESERVE: zone 17 at (5752, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5752, 10408) facing 2 (id 23)
  0.20  RESERVE: zone 18 at (5704, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5704, 10408) facing 2 (id 24)
  0.20  RESERVE: zone 19 at (5656, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5656, 10408) facing 2 (id 25)
  0.20  RESERVE: zone 20 at (5848, 10360) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5848, 10360) facing 2 (id 26)
  0.20  RESERVE: zone 21 at (5800, 10360) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5800, 10360) facing 2 (id 27)
  0.20  RESERVE: zone 22 at (5752, 10360) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5752, 10360) facing 2 (id 28)
  0.20  RESERVE: zone 23 at (5704, 10360) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5704, 10360) facing 2 (id 29)
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
  0.20  RESERVE: armnanotcplat at (5928, 10392) facing 2 (id 30)
  0.20  RESERVE: zone 25 at (5880, 10392) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5880, 10392) facing 2 (id 31)
  0.20  RESERVE: zone 26 at (5832, 10392) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5832, 10392) facing 2 (id 32)
  0.20  RESERVE: zone 27 at (5784, 10392) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5784, 10392) facing 2 (id 33)
  0.20  RESERVE: zone 28 at (5736, 10392) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5736, 10392) facing 2 (id 34)
  0.20  RESERVE: zone 24 released
  0.20  RESERVE: zone 25 released
  0.20  RESERVE: zone 26 released
  0.20  RESERVE: zone 27 released
  0.20  RESERVE: zone 28 released
  0.20  RESERVE: zone 29 at (5992, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5992, 10408) facing 2 (id 35)
  0.20  RESERVE: zone 30 at (5944, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5944, 10408) facing 2 (id 36)
  0.20  RESERVE: zone 31 at (5896, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5896, 10408) facing 2 (id 37)
  0.20  RESERVE: zone 32 at (5848, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5848, 10408) facing 2 (id 38)
  0.20  RESERVE: zone 33 at (5800, 10408) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5800, 10408) facing 2 (id 39)
  0.20  RESERVE: zone 29 released
  0.20  RESERVE: zone 30 released
  0.20  RESERVE: zone 31 released
  0.20  RESERVE: zone 32 released
  0.20  RESERVE: zone 33 released
  0.20  RESERVE: zone 34 at (6056, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6056, 10456) facing 2 (id 40)
  0.20  RESERVE: zone 35 at (6008, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6008, 10456) facing 2 (id 41)
  0.20  RESERVE: zone 36 at (5960, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5960, 10456) facing 2 (id 42)
  0.20  RESERVE: zone 37 at (5912, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5912, 10456) facing 2 (id 43)
  0.20  RESERVE: zone 38 at (5864, 10456) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5864, 10456) facing 2 (id 44)
  0.20  RESERVE: zone 34 released
  0.20  RESERVE: zone 35 released
  0.20  RESERVE: zone 36 released
  0.20  RESERVE: zone 37 released
  0.20  RESERVE: zone 38 released
  0.20  RESERVE: zone 39 at (6104, 10504) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6104, 10504) facing 2 (id 45)
  0.20  RESERVE: zone 40 at (6056, 10504) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6056, 10504) facing 2 (id 46)
  0.20  RESERVE: zone 41 at (6008, 10504) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (6008, 10504) facing 2 (id 47)
  0.20  RESERVE: zone 42 at (5960, 10504) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (5960, 10504) facing 2 (id 48)
  0.20  RESERVE: zone 43 at (5912, 10504) facing 2, 3x3 cells: 9 of 9 held
```
