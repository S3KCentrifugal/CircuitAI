# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.1 min (frame 54093); wall 542 s
- DLL: build-theatres\d188-build-6\SkirmishAI.dll (ac71826721992d84); AI BARbTest/test; staged 2026-10-04T01:57:59
- Map: Serene Caldera v1.3; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=SEA/cortex/test, 9=SEA/legion/test, 10=SEA/armada/test, 11=SEA/cortex/test, 12=SEA/legion/test, 13=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\caldera\20261004T045758Z-46982dd7\runs\20261004T050704Z-6cf93e22\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:48.586123][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.1 min | `[t=00:01:21.452566][f=0001926] [SeaWatch] finished frame=1926 id=8182 def=armsy builder=13561` |
| expect `first-ship-exit` | seen at 3.2 min | `[t=00:01:36.741648][f=0005700] [SeaWatch] egress id=9255 yard=8182 seconds=13.5 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\caldera\20261004T045758Z-46982dd7\runs\20261004T050704Z-6cf93e22\screen_2026-10-04_04-59-59-498.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\caldera\20261004T045758Z-46982dd7\runs\20261004T050704Z-6cf93e22\screen_2026-10-04_05-01-08-843.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\caldera\20261004T045758Z-46982dd7\runs\20261004T050704Z-6cf93e22\screen_2026-10-04_05-04-17-311.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\caldera\20261004T045758Z-46982dd7\runs\20261004T050704Z-6cf93e22\screen_2026-10-04_05-06-47-534.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (2800, 2900) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (4500, 1600) units 1
  0.00  [Playtest] frame 1 team 2 ally 0 side cortex ai true dead false start (6600, 1000) units 1
  0.00  [Playtest] frame 1 team 3 ally 0 side legion ai true dead false start (8000, 2900) units 1
  0.00  [Playtest] frame 1 team 4 ally 0 side armada ai true dead false start (10100, 3200) units 1
  0.00  [Playtest] frame 1 team 5 ally 0 side cortex ai true dead false start (11000, 1600) units 1
  0.00  [Playtest] frame 1 team 6 ally 0 side legion ai true dead false start (12800, 2700) units 1
  0.00  [Playtest] frame 1 team 7 ally 1 side armada ai true dead false start (2800, 12600) units 1
  0.00  [Playtest] frame 1 team 8 ally 1 side cortex ai true dead false start (4500, 13800) units 1
  0.00  [Playtest] frame 1 team 9 ally 1 side legion ai true dead false start (8000, 13000) units 1
  0.00  [Playtest] frame 1 team 10 ally 1 side armada ai true dead false start (8800, 14300) units 1
  0.00  [Playtest] frame 1 team 11 ally 1 side cortex ai true dead false start (10100, 13000) units 1
  0.00  [Playtest] frame 1 team 12 ally 1 side legion ai true dead false start (11000, 14200) units 1
  0.00  [Playtest] frame 1 team 13 ally 1 side armada ai true dead false start (12800, 12500) units 1
  0.00  [Playtest] frame 1 team 14 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 15 ally 3 side  ai false dead false start (0, 0) units 117
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (2800, 2900) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (4500, 1600) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (6600, 1000) units 1
  0.05  [Playtest] frame 90 team 3 ally 0 side legion ai true dead false start (8000, 2900) units 1
  0.05  [Playtest] frame 90 team 4 ally 0 side armada ai true dead false start (10100, 3200) units 1
  0.05  [Playtest] frame 90 team 5 ally 0 side cortex ai true dead false start (11000, 1600) units 1
  0.05  [Playtest] frame 90 team 6 ally 0 side legion ai true dead false start (12800, 2700) units 1
  0.05  [Playtest] frame 90 team 7 ally 1 side armada ai true dead false start (2800, 12600) units 1
  0.05  [Playtest] frame 90 team 8 ally 1 side cortex ai true dead false start (4500, 13800) units 1
  0.05  [Playtest] frame 90 team 9 ally 1 side legion ai true dead false start (8000, 13000) units 1
  0.05  [Playtest] frame 90 team 10 ally 1 side armada ai true dead false start (8800, 14300) units 1
  0.05  [Playtest] frame 90 team 11 ally 1 side cortex ai true dead false start (10100, 13000) units 1
  0.05  [Playtest] frame 90 team 12 ally 1 side legion ai true dead false start (11000, 14200) units 1
  0.05  [Playtest] frame 90 team 13 ally 1 side armada ai true dead false start (12800, 12500) units 1
  0.05  [Playtest] frame 90 team 14 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 15 ally 3 side  ai false dead false start (0, 0) units 117
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|2836|2905|0|0|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(4500,1597) factory=armhp landLocked=no spot=1 known=1/6
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(6626,998) factory=corhp landLocked=no spot=2 known=2/6
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(8000,2900) factory=corhp landLocked=no spot=3 known=3/6
  0.10  [Team][Roster] Team 4 (AI 4): role=SEA side=armada start=(10084,3171) factory=armsy landLocked=no spot=5 known=4/6
  0.10  [Team][Roster] Team 5 (AI 5): role=SEA side=cortex start=(11030,1625) factory=corsy landLocked=no spot=6 known=5/6
  0.10  [Team][Roster] Team 6 (AI 6): role=SEA side=legion start=(12803,2747) factory=legsy landLocked=no spot=7 known=6/6
  0.18  [Team][Roster] team 1 first mex at 4480,1536
  0.20  [Team][Roster] team 6 first mex at 12800,2912
  0.22  [Team][Roster] team 3 first mex at 7936,3040
  0.22  [Team][Roster] team 5 first mex at 10976,1584
  0.23  [SEA][Layout] berth sea.berth.0 armsy at=2352,2912 facing=2
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.28  [Team][Roster] team 2 first mex at 6688,960
  0.29  [Team][Roster] team 4 first mex at 10080,2976
  0.30  [Team][Roster] first mex 1013 at 3008,2912
  0.30  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|2836|2905|0|0|1|3008|2912
  0.45  [SEA][Layout] berth sea.berth.1 armasy at=2688,2144 facing=1
  0.58  [Playtest] finished armmex team 0 at 0.58 min
  0.82  [SEA][Layout] berth sea.berth.2 armasy at=2640,1904 facing=1
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.9 bank 815/1100, energy +30.0 bank 546/1000, units 4
  1.07  [Playtest] finished armsy team 0 at 1.07 min
  1.49  [Playtest] finished armmex team 0 at 1.49 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +9.3 bank 981/1250, energy +30.0 bank 55/1100, units 6
  2.56  [Playtest] finished armmex team 0 at 2.56 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +11.4 bank 1061/1300, energy +37.0 bank 0/1150, units 8
  3.64  [Playtest] finished armtide team 0 at 3.64 min
  3.81  [Playtest] finished armtide team 0 at 3.81 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +11.4 bank 979/1300, energy +83.0 bank 500/1250, units 11
  4.11  [Playtest] finished armmex team 0 at 4.11 min
  4.38  [Playtest] finished armtide team 0 at 4.38 min
  4.73  [Playtest] finished armtide team 0 at 4.73 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +13.4 bank 913/1350, energy +136.0 bank 1293/1400, units 17
  5.00  [Playtest] target team 0 at (2800, 2900) from its start position
  5.00  [Playtest] camera requested (2800,2900) height=2200
  5.02  [Playtest] camera captured name=ta position=(2800,2900) height=2200
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (2800, 2900)
  5.03  [Playtest] finished armtl team 0 at 5.03 min
  5.05  [Playtest] finished armtide team 0 at 5.05 min
  5.13  [Playtest] finished armmex team 0 at 5.13 min
  5.37  [Playtest] finished armtide team 0 at 5.37 min
  5.66  [Playtest] finished armmex team 0 at 5.66 min
  5.83  [Playtest] finished armmex team 0 at 5.83 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +20.0 bank 974/1500, energy +189.0 bank 1531/1550, units 24
  6.15  [Playtest] finished armtl team 0 at 6.15 min
  6.16  [Playtest] finished armmex team 0 at 6.16 min
  6.39  [Playtest] finished armmex team 0 at 6.39 min
  6.50  [Playtest] finished armmex team 0 at 6.50 min
  6.66  [Playtest] finished armfrad team 0 at 6.66 min
  6.69  [Playtest] finished armtide team 0 at 6.69 min
  6.85  [Playtest] finished armtl team 0 at 6.85 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +26.9 bank 1092/1650, energy +219.0 bank 1629/1650, units 35
  7.02  [Playtest] finished armtide team 0 at 7.02 min
  7.10  [Playtest] finished armmex team 0 at 7.10 min
  7.20  [Playtest] finished armtl team 0 at 7.20 min
  7.40  [Playtest] finished armtide team 0 at 7.40 min
  7.63  [Playtest] finished armllt team 0 at 7.63 min
  7.72  [Playtest] finished armtide team 0 at 7.72 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +29.3 bank 1538/1700, energy +288.0 bank 1790/1800, units 41
  8.11  [Playtest] finished armtide team 0 at 8.11 min
  8.15  [Playtest] finished armtl team 0 at 8.15 min
  8.38  [Playtest] finished armtide team 0 at 8.39 min
  8.53  [Playtest] finished armmex team 0 at 8.52 min
  8.64  [Playtest] finished armtide team 0 at 8.64 min
  8.85  [Playtest] finished armtide team 0 at 8.85 min
  8.85  [Playtest] finished armtide team 0 at 8.85 min
  8.90  [Playtest] finished armmex team 0 at 8.90 min
  8.97  [Playtest] finished armtide team 0 at 8.97 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +34.2 bank 1467/1800, energy +433.0 bank 2142/2150, units 53
  9.12  [Playtest] finished armnanotcplat team 0 at 9.12 min
  9.17  [Playtest] finished armtide team 0 at 9.17 min
  9.18  [Playtest] finished armtide team 0 at 9.18 min
  9.27  [Playtest] finished armmex team 0 at 9.27 min
  9.36  [Playtest] finished armtide team 0 at 9.36 min
  9.48  [Playtest] finished armtide team 0 at 9.48 min
  9.55  [Playtest] finished armmex team 0 at 9.55 min
  9.59  [Playtest] finished armtide team 0 at 9.59 min
  9.68  [Playtest] finished armtide team 0 at 9.68 min
  9.70  [Playtest] finished armtide team 0 at 9.70 min
  9.72  [Playtest] finished armfmkr team 0 at 9.72 min
  9.92  [Playtest] finished armtide team 0 at 9.92 min
  9.97  [Playtest] finished armtide team 0 at 9.97 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +39.7 bank 1727/1900, energy +647.0 bank 2631/2650, units 73
 10.00  [Playtest] camera requested (2800,2900) height=2200
 10.02  [Playtest] camera captured name=ta position=(2800,2900) height=2200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (2800, 2900)
 10.08  [Playtest] finished armllt team 0 at 10.08 min
 10.09  [Playtest] finished armtl team 0 at 10.09 min
 10.14  [Playtest] finished armtide team 0 at 10.14 min
 10.15  [Playtest] finished armfmkr team 0 at 10.15 min
 10.21  [Playtest] finished armtide team 0 at 10.21 min
 10.38  [Playtest] finished armtide team 0 at 10.38 min
 10.44  [Playtest] finished armnanotcplat team 0 at 10.44 min
 10.48  [Playtest] finished armtide team 0 at 10.48 min
 10.50  [Playtest] finished armllt team 0 at 10.50 min
 10.58  [Playtest] finished armtide team 0 at 10.58 min
 10.76  [Playtest] finished armnanotcplat team 0 at 10.76 min
 10.86  [Playtest] finished armfmkr team 0 at 10.86 min
 10.96  [Playtest] finished armtide team 0 at 10.95 min
 10.99  [Playtest] finished armtide team 0 at 10.99 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +41.7 bank 1695/1900, energy +785.0 bank 2963/3000, units 89
 11.07  [Playtest] finished armmex team 0 at 11.07 min
 11.13  [Playtest] finished armfmkr team 0 at 11.13 min
 11.21  [Playtest] finished armrad team 0 at 11.21 min
 11.38  [Playtest] finished armtide team 0 at 11.38 min
 11.40  [Playtest] finished armfmkr team 0 at 11.40 min
 11.40  [Playtest] finished armtide team 0 at 11.40 min
 11.44  [Playtest] finished armtide team 0 at 11.44 min
 11.54  [Playtest] finished armtide team 0 at 11.54 min
 11.59  [Playtest] finished armtl team 0 at 11.59 min
 11.67  [SEA][Layout] berth sea.berth.3 armasy at=3248,3312 facing=1
 11.70  [Playtest] finished armfmkr team 0 at 11.70 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +46.7 bank 1225/1950, energy +900.0 bank 3035/3200, units 102
 12.02  [SEA][Layout] berth sea.berth.4 armasy at=3248,2496 facing=1
 12.12  [Playtest] finished armtide team 0 at 12.12 min
 12.12  [Playtest] finished armtide team 0 at 12.12 min
 12.37  [Playtest] finished armtide team 0 at 12.37 min
 12.44  [Playtest] finished armtide team 0 at 12.44 min
 12.47  [Playtest] finished armtide team 0 at 12.47 min
 12.48  [SEA][Layout] berth sea.berth.5 armasy at=3504,2912 facing=2
 12.50  [Playtest] finished armfmkr team 0 at 12.50 min
 12.53  [Playtest] finished armtide team 0 at 12.53 min
 12.64  [Playtest] finished armtide team 0 at 12.64 min
 12.71  [Playtest] finished armtide team 0 at 12.71 min
 12.79  [Playtest] finished armtide team 0 at 12.79 min
 12.86  [Playtest] finished armtide team 0 at 12.86 min
 12.87  [SEA][Layout] berth sea.berth.6 armasy at=3088,3520 facing=0
 12.98  [Playtest] finished armtide team 0 at 12.98 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +47.7 bank 1939/1950, energy +1141.5 bank 3688/3750, units 113
 13.04  [Playtest] finished armtide team 0 at 13.04 min
 13.16  [Playtest] finished armnanotcplat team 0 at 13.16 min
 13.17  [Playtest] finished armtide team 0 at 13.17 min
 13.32  [Playtest] finished armtide team 0 at 13.32 min
 13.36  [Playtest] finished armtide team 0 at 13.36 min
 13.37  [Playtest] finished armllt team 0 at 13.37 min
 13.48  [Playtest] finished armtide team 0 at 13.48 min
 13.56  [Playtest] finished armfmkr team 0 at 13.56 min
 13.62  [Playtest] finished armtide team 0 at 13.62 min
 13.67  [SEA][Layout] berth sea.berth.7 armasy at=3696,2912 facing=2
 13.76  [Playtest] finished armfmkr team 0 at 13.76 min
 13.82  [Playtest] finished armfmkr team 0 at 13.82 min
 13.88  [Playtest] finished armfmkr team 0 at 13.88 min
 13.95  [Playtest] finished armtide team 0 at 13.95 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +51.7 bank 1698/1950, energy +1314.0 bank 3959/4100, units 124
 14.35  [SEA][Layout] berth sea.berth.8 armasy at=2224,2288 facing=2
 14.35  [Playtest] finished armtide team 0 at 14.35 min
 14.43  [Playtest] finished armtide team 0 at 14.43 min
 14.52  [Playtest] finished armfmkr team 0 at 14.52 min
 14.52  [Playtest] finished armfmkr team 0 at 14.52 min
 14.73  [Playtest] finished armfmkr team 0 at 14.73 min
 14.75  [Playtest] finished armtide team 0 at 14.75 min
 14.82  [Playtest] finished armtide team 0 at 14.82 min
 14.85  [Playtest] finished armtide team 0 at 14.85 min
 14.89  [Playtest] finished armfmkr team 0 at 14.89 min
 14.93  [Playtest] finished armfmkr team 0 at 14.93 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +53.5 bank 1611/1950, energy +1429.0 bank 3956/4350, units 141
 15.10  [SEA][Layout] berth sea.berth.9 armasy at=3520,3584 facing=2
 15.14  [Playtest] finished armfmkr team 0 at 15.14 min
 15.15  [Playtest] finished armfmkr team 0 at 15.15 min
 15.28  [Playtest] finished armtide team 0 at 15.28 min
 15.42  [Playtest] finished armfmkr team 0 at 15.42 min
 15.59  [Playtest] finished armfmkr team 0 at 15.59 min
 15.95  [SEA][Layout] berth sea.berth.10 armasy at=1952,2544 facing=2
 15.98  [Playtest] finished armtide team 0 at 15.98 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +56.1 bank 1950/1950, energy +1463.5 bank 4102/4450, units 149
 16.38  [Playtest] finished armfmkr team 0 at 16.38 min
 16.72  [Playtest] finished armtide team 0 at 16.72 min
 16.83  [SEA][Layout] berth sea.berth.11 armasy at=3520,2224 facing=3
 17.00  [Playtest] eco team 0 at 17.0 min: metal +52.3 bank 1930/1950, energy +1498.0 bank 3774/4500, units 148
 17.02  [Playtest] finished armnanotcplat team 0 at 17.02 min
 17.66  [Playtest] finished armfmkr team 0 at 17.66 min
 17.73  [Playtest] finished armmex team 0 at 17.73 min
 17.98  [Playtest] finished armfmkr team 0 at 17.98 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +62.3 bank 1706/2000, energy +1498.0 bank 3928/4500, units 153
 18.08  [SEA][Layout] berth sea.berth.12 armasy at=1680,2912 facing=2
 18.38  [Playtest] finished armfmkr team 0 at 18.38 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +61.5 bank 1622/2000, energy +1498.0 bank 3884/4500, units 156
 19.73  [Playtest] finished armfrad team 0 at 19.73 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +53.8 bank 1839/2000, energy +1494.5 bank 4097/4500, units 163
 20.00  [Playtest] camera requested (2800,2900) height=2200
 20.02  [Playtest] camera captured name=ta position=(2800,2900) height=2200
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (2800, 2900)
 20.62  [Playtest] finished armmex team 0 at 20.62 min
 20.87  [Playtest] finished armtl team 0 at 20.87 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +60.9 bank 1144/2050, energy +1498.0 bank 3753/4500, units 166
 21.14  [Playtest] finished armfmkr team 0 at 21.14 min
 21.20  [Playtest] finished armfrad team 0 at 21.20 min
 21.33  [Playtest] finished armfmkr team 0 at 21.33 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +52.8 bank 1439/2000, energy +1498.0 bank 3683/4450, units 159
 22.70  [Playtest] finished armfmkr team 0 at 22.70 min
 22.78  [Playtest] finished armfmkr team 0 at 22.78 min
 22.99  [Playtest] finished armtl team 0 at 22.99 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +62.2 bank 1753/2000, energy +1498.0 bank 3789/4500, units 166
 23.06  [Playtest] finished armuwmme team 0 at 23.06 min
 23.41  [Playtest] finished armfmkr team 0 at 23.41 min
 23.63  [Playtest] finished armfmkr team 0 at 23.63 min
 23.93  [Playtest] finished armmex team 0 at 23.93 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +68.3 bank 2375/2600, energy +1491.0 bank 3678/4450, units 172
 24.21  [Playtest] finished armfrad team 0 at 24.21 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +63.4 bank 2037/2550, energy +1491.0 bank 3992/4450, units 170
 25.22  [Playtest] finished armfmkr team 0 at 25.22 min
 25.34  [Playtest] finished armfmkr team 0 at 25.34 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +60.0 bank 2085/2550, energy +1528.0 bank 4216/4650, units 178
 27.00  [Playtest] eco team 0 at 27.0 min: metal +65.9 bank 2291/2550, energy +1528.0 bank 3858/4650, units 193
 27.05  [Playtest] finished armuwmme team 0 at 27.05 min
 27.19  [Playtest] finished armtl team 0 at 27.19 min
 27.39  [Playtest] finished armfrad team 0 at 27.39 min
 27.48  [Playtest] finished armtl team 0 at 27.48 min
 27.54  [Playtest] finished armmex team 0 at 27.54 min
 27.81  [Playtest] finished armfrad team 0 at 27.81 min
 27.94  [Playtest] finished armtl team 0 at 27.94 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +69.4 bank 2746/3150, energy +1528.0 bank 4180/4650, units 207
 28.24  [Playtest] finished armtl team 0 at 28.24 min
 28.83  [Playtest] finished armmex team 0 at 28.83 min
 28.95  [Playtest] finished armtl team 0 at 28.95 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +100.3 bank 2660/3200, energy +1528.0 bank 4153/4650, units 219
 29.00  [Playtest] camera requested (2800,2900) height=2200
 29.02  [Playtest] camera captured name=ta position=(2800,2900) height=2200
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (2800, 2900)
 29.10  [Playtest] finished armtl team 0 at 29.10 min
 29.29  [Playtest] finished armtl team 0 at 29.29 min
 29.50  [Playtest] finished armtl team 0 at 29.50 min
 29.72  [Playtest] finished armtl team 0 at 29.72 min
 29.88  [Playtest] finished armtl team 0 at 29.88 min
 29.92  [Playtest] finished armtl team 0 at 29.92 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +67.7 bank 2795/3200, energy +1528.0 bank 4128/4650, units 235
 30.03  [Playtest] finished armtl team 0 at 30.03 min
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(13561) at (2836, 2906) walks to (2872, 2907), 136 from the armmex site (3008, 2912)
  0.09  EXP: approach: legcom(18687) at (8000, 2900) walks to (7993, 2915), 137 from the legmex site (7936, 3040)
  0.09  EXP: approach: armcom(4914) at (10084, 3172) walks to (10083, 3112), 136 from the armmex site (10080, 2976)
  0.09  EXP: approach: legcom(861) at (12803, 2748) walks to (12803, 2775), 137 from the legmex site (12800, 2912)
  0.09  EXP: approach: armcom(7091) at (2798, 12604) walks to (2775, 12632), 136 from the armmex site (2688, 12736)
  0.09  EXP: approach: corcom(31050) at (4457, 13822) walks to (4287, 13897), 139 from the cormex site (4160, 13952)
  0.09  EXP: approach: legcom(4665) at (7960, 13019) walks to (7761, 13090), 137 from the legmex site (7632, 13136)
  0.09  EXP: approach: corcom(15006) at (10073, 12977) walks to (9926, 12728), 139 from the cormex site (9856, 12608)
  0.09  EXP: approach: armcom(15480) at (12744, 12493) walks to (12674, 12472), 136 from the armmex site (12544, 12432)
  0.10  RESERVE: zone 1 at (8000, 2896) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: legsy at (8000, 2896) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (8288, 2896) facing 1, 30x12 cells: 360 of 360 held
  0.10  RESERVE: zone 3 at (7720, 2904) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7720, 2904) facing 0 (id 2)
  0.10  RESERVE: zone 4 at (7784, 2904) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7784, 2904) facing 0 (id 3)
  0.10  RESERVE: zone 5 at (7848, 2904) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7848, 2904) facing 0 (id 4)
  0.10  RESERVE: zone 6 at (7720, 2968) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7720, 2968) facing 0 (id 5)
  0.10  RESERVE: zone 7 at (7784, 2968) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7784, 2968) facing 0 (id 6)
  0.10  RESERVE: zone 8 at (7848, 2968) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7848, 2968) facing 0 (id 7)
  0.10  RESERVE: zone 9 at (7776, 2928) facing 0, 12x8 cells: 42 of 96 held
  0.10  RESERVE: zone 1 at (7968, 13024) facing 2, 6x6 cells: 36 of 36 held
  0.10  RESERVE: legsy at (7968, 13024) facing 2 (id 1)
  0.10  RESERVE: corridor 2 at (7968, 12736) facing 2, 12x30 cells: 360 of 360 held
  0.10  RESERVE: zone 3 at (8040, 13256) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (8040, 13256) facing 2 (id 2)
  0.10  RESERVE: zone 4 at (7976, 13256) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7976, 13256) facing 2 (id 3)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 at (8136, 13256) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (8136, 13256) facing 2 (id 4)
  0.10  RESERVE: zone 6 at (8072, 13256) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (8072, 13256) facing 2 (id 5)
  0.10  RESERVE: zone 7 at (8008, 13256) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (8008, 13256) facing 2 (id 6)
  0.10  RESERVE: zone 8 at (8136, 13192) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (8136, 13192) facing 2 (id 7)
  0.10  RESERVE: zone 9 at (8072, 13192) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (8072, 13192) facing 2 (id 8)
  0.10  RESERVE: zone 10 at (8008, 13192) facing 2, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (8008, 13192) facing 2 (id 9)
  0.10  RESERVE: zone 11 at (8064, 13216) facing 2, 12x8 cells: 42 of 96 held
  0.11  RESERVE: zone 1 at (10080, 12976) facing 3, 6x6 cells: 36 of 36 held
  0.11  RESERVE: corsy at (10080, 12976) facing 3 (id 1)
  0.11  RESERVE: corridor 2 at (9792, 12976) facing 3, 30x12 cells: 360 of 360 held
  0.11  RESERVE: zone 3 at (10376, 12984) facing 2, 3x3 cells: 9 of 9 held
  0.11  RESERVE: cornanotcplat at (10376, 12984) facing 2 (id 2)
  0.11  RESERVE: zone 4 at (10312, 12984) facing 2, 3x3 cells: 9 of 9 held
  0.11  RESERVE: cornanotcplat at (10312, 12984) facing 2 (id 3)
  0.11  RESERVE: zone 5 at (10248, 12984) facing 2, 3x3 cells: 9 of 9 held
  0.11  RESERVE: cornanotcplat at (10248, 12984) facing 2 (id 4)
  0.11  RESERVE: zone 6 at (10376, 12920) facing 2, 3x3 cells: 9 of 9 held
  0.11  RESERVE: cornanotcplat at (10376, 12920) facing 2 (id 5)
  0.11  RESERVE: zone 7 at (10312, 12920) facing 2, 3x3 cells: 9 of 9 held
  0.11  RESERVE: cornanotcplat at (10312, 12920) facing 2 (id 6)
  0.11  RESERVE: zone 8 at (10248, 12920) facing 2, 3x3 cells: 9 of 9 held
  0.11  RESERVE: cornanotcplat at (10248, 12920) facing 2 (id 7)
  0.11  RESERVE: zone 9 at (10304, 12944) facing 2, 12x8 cells: 42 of 96 held
  0.11  EXP: idle: legcom(18687) on legmex at (7996, 2908), site (7936, 3040), target yes, fails 2 (arrived at the approach point)
  0.12  EXP: idle: armcom(7091) on armmex at (2783, 12622), site (2688, 12736), target yes, fails 2 (arrived at the approach point)
  0.14  RESERVE: zone 1 at (3088, 12608) facing 2, 6x6 cells: 36 of 36 held
  0.14  RESERVE: armsy at (3088, 12608) facing 2 (id 1)
  0.14  RESERVE: corridor 2 at (3088, 12320) facing 2, 12x30 cells: 360 of 360 held
  0.14  RESERVE: zone 3 at (3160, 12840) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: armnanotcplat at (3160, 12840) facing 2 (id 2)
  0.14  RESERVE: zone 4 at (3096, 12840) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: armnanotcplat at (3096, 12840) facing 2 (id 3)
  0.14  RESERVE: zone 5 at (3032, 12840) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: armnanotcplat at (3032, 12840) facing 2 (id 4)
  0.14  RESERVE: zone 6 at (3160, 12776) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: armnanotcplat at (3160, 12776) facing 2 (id 5)
  0.14  RESERVE: zone 7 at (3096, 12776) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: armnanotcplat at (3096, 12776) facing 2 (id 6)
  0.14  RESERVE: zone 3 released
  0.14  RESERVE: zone 4 released
  0.14  RESERVE: zone 5 released
  0.14  RESERVE: zone 6 released
  0.14  RESERVE: zone 7 released
  0.14  RESERVE: zone 8 at (3256, 12840) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: armnanotcplat at (3256, 12840) facing 2 (id 7)
  0.14  RESERVE: zone 9 at (3192, 12840) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: armnanotcplat at (3192, 12840) facing 2 (id 8)
  0.14  RESERVE: zone 10 at (3128, 12840) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: armnanotcplat at (3128, 12840) facing 2 (id 9)
  0.14  RESERVE: zone 11 at (3256, 12776) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: armnanotcplat at (3256, 12776) facing 2 (id 10)
  0.14  RESERVE: zone 12 at (3192, 12776) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: armnanotcplat at (3192, 12776) facing 2 (id 11)
  0.14  RESERVE: zone 13 at (3128, 12776) facing 2, 3x3 cells: 9 of 9 held
  0.14  RESERVE: armnanotcplat at (3128, 12776) facing 2 (id 12)
  0.14  RESERVE: zone 14 at (3184, 12800) facing 2, 12x8 cells: 42 of 96 held
  0.19  EXP: approach: armcom(27975) at (4500, 1597) walks to (4584, 1870), 136 from the armmex site (4624, 2000)
  0.19  RESERVE: zone 1 at (13216, 12496) facing 0, 6x6 cells: 36 of 36 held
  0.19  RESERVE: armsy at (13216, 12496) facing 0 (id 1)
  0.19  RESERVE: corridor 2 at (13216, 12784) facing 0, 12x30 cells: 360 of 360 held
  0.19  RESERVE: zone 3 at (13224, 12216) facing 3, 3x3 cells: 9 of 9 held
  0.19  RESERVE: armnanotcplat at (13224, 12216) facing 3 (id 2)
  0.19  RESERVE: zone 4 at (13224, 12280) facing 3, 3x3 cells: 9 of 9 held
  0.19  RESERVE: armnanotcplat at (13224, 12280) facing 3 (id 3)
  0.19  RESERVE: zone 5 at (13224, 12344) facing 3, 3x3 cells: 9 of 9 held
  0.19  RESERVE: armnanotcplat at (13224, 12344) facing 3 (id 4)
  0.19  RESERVE: zone 3 released
  0.19  RESERVE: zone 4 released
  0.19  RESERVE: zone 5 released
  0.19  RESERVE: zone 6 at (13320, 12216) facing 3, 3x3 cells: 9 of 9 held
  0.19  RESERVE: armnanotcplat at (13320, 12216) facing 3 (id 5)
  0.19  RESERVE: zone 7 at (13320, 12280) facing 3, 3x3 cells: 9 of 9 held
  0.19  RESERVE: armnanotcplat at (13320, 12280) facing 3 (id 6)
  0.19  RESERVE: zone 8 at (13320, 12344) facing 3, 3x3 cells: 9 of 9 held
  0.19  RESERVE: armnanotcplat at (13320, 12344) facing 3 (id 7)
  0.19  RESERVE: zone 9 at (13256, 12216) facing 3, 3x3 cells: 9 of 9 held
  0.19  RESERVE: armnanotcplat at (13256, 12216) facing 3 (id 8)
  0.19  RESERVE: zone 10 at (13256, 12280) facing 3, 3x3 cells: 9 of 9 held
  0.19  RESERVE: armnanotcplat at (13256, 12280) facing 3 (id 9)
  0.19  RESERVE: zone 11 at (13256, 12344) facing 3, 3x3 cells: 9 of 9 held
```
