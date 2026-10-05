# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54008); wall 478 s
- DLL: build-theatres\d188-build-4\SkirmishAI.dll (4269e12be49092f4); AI BARbTest/test; staged 2026-10-04T01:15:57
- Map: Serene Caldera v1.3; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=SEA/cortex/test, 9=SEA/legion/test, 10=SEA/armada/test, 11=SEA/cortex/test, 12=SEA/legion/test, 13=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\caldera\20261004T041557Z-e3bd263b\runs\20261004T042358Z-51cbfbc0\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:40.974902][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.2 min | `[t=00:01:03.665602][f=0002120] [SeaWatch] finished frame=2120 id=1454 def=armsy builder=4207` |
| expect `first-ship-exit` | seen at 2.5 min | `[t=00:01:10.057846][f=0004560] [SeaWatch] egress id=28647 yard=1454 seconds=8.8 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\caldera\20261004T041557Z-e3bd263b\runs\20261004T042358Z-51cbfbc0\screen_2026-10-04_04-17-27-301.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\caldera\20261004T041557Z-e3bd263b\runs\20261004T042358Z-51cbfbc0\screen_2026-10-04_04-18-22-572.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\caldera\20261004T041557Z-e3bd263b\runs\20261004T042358Z-51cbfbc0\screen_2026-10-04_04-20-52-191.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\caldera\20261004T041557Z-e3bd263b\runs\20261004T042358Z-51cbfbc0\screen_2026-10-04_04-23-43-141.png

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
  0.00  [Playtest] frame 1 team 15 ally 3 side  ai false dead false start (0, 0) units 139
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
  0.05  [Playtest] frame 90 team 15 ally 3 side  ai false dead false start (0, 0) units 139
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|2836|2905|0|0|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(4500,1597) factory=armhp landLocked=no spot=1 known=1/6
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(6626,998) factory=corhp landLocked=no spot=2 known=2/6
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(8000,2900) factory=corhp landLocked=no spot=3 known=3/6
  0.10  [Team][Roster] Team 4 (AI 4): role=SEA side=armada start=(10084,3171) factory=armsy landLocked=no spot=5 known=4/6
  0.10  [Team][Roster] Team 5 (AI 5): role=SEA side=cortex start=(11030,1625) factory=corsy landLocked=no spot=6 known=5/6
  0.10  [Team][Roster] Team 6 (AI 6): role=SEA side=legion start=(12803,2748) factory=legsy landLocked=no spot=7 known=6/6
  0.18  [Team][Roster] team 1 first mex at 4480,1536
  0.19  [Team][Roster] team 3 first mex at 7936,3040
  0.20  [Playtest] finished armmex team 0 at 0.20 min
  0.20  [Team][Roster] team 6 first mex at 12800,2912
  0.22  [Team][Roster] first mex 30727 at 3008,2912
  0.22  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|2836|2905|0|0|1|3008|2912
  0.22  [Team][Roster] team 4 first mex at 10080,2976
  0.24  [Team][Roster] team 5 first mex at 10976,1584
  0.30  [Team][Roster] team 2 first mex at 6688,960
  0.48  [Playtest] finished armmex team 0 at 0.48 min
  0.66  [Playtest] finished armwin team 0 at 0.66 min
  0.76  [Playtest] finished armwin team 0 at 0.76 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.9 bank 951/1100, energy +70.0 bank 990/1001, units 6
  1.18  [Playtest] finished armsy team 0 at 1.18 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.9 bank 729/1200, energy +55.0 bank 51/1151, units 8
  2.34  [Playtest] finished armtide team 0 at 2.34 min
  2.53  [Playtest] finished armtide team 0 at 2.53 min
  2.75  [Playtest] finished armtide team 0 at 2.75 min
  2.94  [Playtest] finished armtide team 0 at 2.94 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.9 bank 188/1200, energy +170.5 bank 1379/1401, units 17
  3.13  [Playtest] finished armtide team 0 at 3.13 min
  3.34  [Playtest] finished armtide team 0 at 3.34 min
  3.50  [Playtest] finished armmex team 0 at 3.50 min
  3.62  [Playtest] finished armtide team 0 at 3.62 min
  3.80  [Playtest] finished armtide team 0 at 3.80 min
  3.97  [Playtest] finished armtide team 0 at 3.97 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +9.3 bank 19/1250, energy +263.1 bank 1651/1651, units 23
  4.19  [Playtest] finished armfmkr team 0 at 4.19 min
  4.33  [Playtest] finished armmex team 0 at 4.33 min
  4.51  [Playtest] finished armfmkr team 0 at 4.51 min
  4.78  [Playtest] finished armfmkr team 0 at 4.78 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +14.1 bank 0/1300, energy +262.8 bank 1329/1651, units 27
  5.00  [Playtest] target team 0 at (2800, 2900) from its start position
  5.00  [Playtest] camera requested (2800,2900) height=2200
  5.02  [Playtest] camera captured name=ta position=(2800,2900) height=2200
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (2800, 2900)
  5.04  [Playtest] finished armtide team 0 at 5.04 min
  5.21  [Playtest] finished armmex team 0 at 5.21 min
  5.32  [Playtest] finished armtide team 0 at 5.32 min
  5.59  [Playtest] finished armtide team 0 at 5.59 min
  5.60  [Playtest] finished armmex team 0 at 5.60 min
  5.79  [Playtest] finished armtide team 0 at 5.79 min
  5.98  [Playtest] finished armmex team 0 at 5.98 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +20.4 bank 2/1450, energy +353.0 bank 1710/1851, units 35
  6.03  [Playtest] finished armtide team 0 at 6.03 min
  6.33  [Playtest] finished armfmkr team 0 at 6.33 min
  6.53  [Playtest] finished armmex team 0 at 6.53 min
  6.85  [Playtest] finished armnanotcplat team 0 at 6.85 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +24.7 bank 256/1500, energy +386.3 bank 1596/1951, units 40
  7.01  [Playtest] finished armtide team 0 at 7.01 min
  7.14  [Playtest] finished armtide team 0 at 7.14 min
  7.17  [Playtest] finished armmex team 0 at 7.18 min
  7.24  [Playtest] finished armtide team 0 at 7.24 min
  7.40  [Playtest] finished armtide team 0 at 7.40 min
  7.60  [Playtest] finished armfmkr team 0 at 7.60 min
  7.67  [Playtest] finished armmex team 0 at 7.67 min
  7.80  [Playtest] finished armtide team 0 at 7.80 min
  7.92  [Playtest] finished armnanotcplat team 0 at 7.92 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +25.8 bank 173/1600, energy +532.1 bank 1811/2301, units 54
  8.02  [Playtest] finished armtide team 0 at 8.02 min
  8.14  [Playtest] finished armnanotcplat team 0 at 8.14 min
  8.22  [Playtest] finished armtide team 0 at 8.22 min
  8.45  [Playtest] finished armtide team 0 at 8.45 min
  8.62  [Playtest] finished armnanotcplat team 0 at 8.62 min
  8.76  [Playtest] finished armnanotcplat team 0 at 8.76 min
  8.78  [Playtest] finished armtide team 0 at 8.78 min
  8.90  [Playtest] finished armtide team 0 at 8.90 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +30.2 bank 19/1600, energy +639.1 bank 2390/2551, units 65
  9.05  [Playtest] finished armfmkr team 0 at 9.05 min
  9.40  [Playtest] finished armtide team 0 at 9.40 min
  9.40  [Playtest] finished armnanotcplat team 0 at 9.40 min
  9.70  [Playtest] finished armtide team 0 at 9.70 min
  9.72  [Playtest] finished armestor team 0 at 9.72 min
  9.95  [Playtest] finished armtide team 0 at 9.95 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +31.2 bank 17/1600, energy +725.5 bank 7715/8701, units 68
 10.00  [Playtest] camera requested (2800,2900) height=2200
 10.02  [Playtest] camera captured name=ta position=(2800,2900) height=2200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (2800, 2900)
 10.16  [Playtest] finished armtide team 0 at 10.16 min
 10.16  [Playtest] finished armtl team 0 at 10.16 min
 10.34  [Playtest] finished armmex team 0 at 10.34 min
 10.39  [Playtest] finished armfmkr team 0 at 10.39 min
 10.63  [Playtest] finished armfmkr team 0 at 10.63 min
 10.73  [Playtest] finished armmex team 0 at 10.73 min
 10.78  [Playtest] finished armtide team 0 at 10.78 min
 10.88  [Playtest] finished armtl team 0 at 10.88 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +35.8 bank 20/1700, energy +755.0 bank 6902/8851, units 81
 11.07  [Playtest] finished armmex team 0 at 11.07 min
 11.11  [Playtest] finished armtide team 0 at 11.11 min
 11.25  [Playtest] finished armtl team 0 at 11.25 min
 11.29  [Playtest] finished armtide team 0 at 11.29 min
 11.49  [Playtest] finished armnanotcplat team 0 at 11.49 min
 11.50  [Playtest] finished armmex team 0 at 11.50 min
 11.60  [Playtest] finished armfrad team 0 at 11.60 min
 11.61  [Playtest] finished armtl team 0 at 11.60 min
 11.68  [Playtest] finished armtide team 0 at 11.68 min
 11.71  [Playtest] finished armtide team 0 at 11.71 min
 11.85  [Playtest] finished armtide team 0 at 11.85 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +41.4 bank 19/1800, energy +893.9 bank 8418/9101, units 90
 12.01  [Playtest] finished armtide team 0 at 12.01 min
 12.04  [Playtest] finished armtl team 0 at 12.04 min
 12.33  [Playtest] finished armfrad team 0 at 12.33 min
 12.36  [Playtest] finished armtide team 0 at 12.36 min
 12.69  [Playtest] finished armtide team 0 at 12.69 min
 12.76  [Playtest] finished armmex team 0 at 12.76 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +43.5 bank 0/1850, energy +955.5 bank 8803/9201, units 97
 13.04  [Playtest] finished armtide team 0 at 13.04 min
 13.28  [Playtest] finished armtl team 0 at 13.27 min
 13.30  [Playtest] finished armmex team 0 at 13.30 min
 13.38  [Playtest] finished armtl team 0 at 13.38 min
 13.43  [Playtest] finished armtide team 0 at 13.43 min
 13.74  [Playtest] finished armtide team 0 at 13.74 min
 13.91  [Playtest] finished armtl team 0 at 13.91 min
 13.96  [Playtest] finished armnanotcplat team 0 at 13.96 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +45.5 bank 17/1900, energy +1014.9 bank 8734/9351, units 104
 14.07  [Playtest] finished armtide team 0 at 14.07 min
 14.26  [Playtest] finished armfrad team 0 at 14.26 min
 14.41  [Playtest] finished armtide team 0 at 14.41 min
 14.57  [Playtest] finished armnanotcplat team 0 at 14.57 min
 14.74  [Playtest] finished armtide team 0 at 14.74 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +45.5 bank 65/1900, energy +1101.0 bank 9349/9551, units 115
 15.09  [Playtest] finished armtide team 0 at 15.09 min
 15.41  [Playtest] finished armtide team 0 at 15.41 min
 15.78  [Playtest] finished armtide team 0 at 15.78 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +45.5 bank 0/1900, energy +1150.8 bank 9466/9701, units 114
 16.09  [Playtest] finished armfrad team 0 at 16.09 min
 16.15  [Playtest] finished armtide team 0 at 16.15 min
 16.48  [Playtest] finished armtide team 0 at 16.48 min
 16.57  [Playtest] finished armtl team 0 at 16.57 min
 16.79  [Playtest] finished armtide team 0 at 16.79 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +45.5 bank 16/1900, energy +1195.0 bank 9570/9751, units 114
 17.19  [Playtest] finished armtide team 0 at 17.19 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +43.5 bank 14/1850, energy +1235.2 bank 9559/9851, units 120
 18.94  [Playtest] finished armfrad team 0 at 18.94 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +41.4 bank 0/1800, energy +1233.6 bank 9705/9851, units 116
 19.75  [Playtest] finished armllt team 0 at 19.75 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +41.4 bank 15/1800, energy +1246.9 bank 9824/9901, units 112
 20.00  [Playtest] camera requested (2800,2900) height=2200
 20.00  [Playtest] camera captured name=ta position=(2800,2900) height=2200
 20.00  [Playtest] screenshot at 20.0 min of team 0 at (2800, 2900)
 20.34  [Playtest] finished armfmkr team 0 at 20.34 min
 20.50  [Playtest] finished armfmkr team 0 at 20.50 min
 20.69  [Playtest] finished armtl team 0 at 20.69 min
 20.72  [Playtest] finished armfmkr team 0 at 20.72 min
 20.86  [Playtest] finished armfmkr team 0 at 20.86 min
 20.96  [Playtest] finished armfmkr team 0 at 20.96 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +41.9 bank 16/1700, energy +1251.2 bank 8424/9901, units 117
 21.30  [Playtest] finished armtl team 0 at 21.31 min
 21.57  [Playtest] finished armfrad team 0 at 21.57 min
 21.80  [Playtest] finished armrl team 0 at 21.80 min
 21.91  [Playtest] finished armrad team 0 at 21.91 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +39.9 bank 45/1650, energy +1230.0 bank 8297/9701, units 110
 22.20  [Playtest] finished armfmkr team 0 at 22.19 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +38.8 bank 14/1600, energy +1255.8 bank 8094/9901, units 111
 23.57  [Playtest] finished armfmkr team 0 at 23.57 min
 23.73  [Playtest] finished armfmkr team 0 at 23.73 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +30.2 bank 12/1400, energy +1227.0 bank 7710/9651, units 100
 24.25  [Playtest] finished armfmkr team 0 at 24.25 min
 24.58  [Playtest] finished armtide team 0 at 24.58 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +12.7 bank 10/1150, energy +181.1 bank 1082/1300, units 28
 25.94  [Playtest] finished armsy team 0 at 25.94 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +4.1 bank 178/1150, energy +30.0 bank 899/1100, units 4
 27.00  [Playtest] eco team 0 at 27.0 min: metal +2.0 bank 81/1000, energy +30.0 bank 911/1000, units 1
 28.00  [Playtest] eco team 0 at 28.0 min: metal +2.0 bank 60/1000, energy +30.0 bank 910/1000, units 2
 29.00  [Playtest] eco team 0 at 29.0 min: metal +2.0 bank 0/1000, energy +30.0 bank 965/1000, units 2
 29.00  [Playtest] camera requested (2800,2900) height=2200
 29.00  [Playtest] camera captured name=ta position=(2800,2900) height=2200
 29.00  [Playtest] screenshot at 29.0 min of team 0 at (2800, 2900)
 29.20  [Playtest] finished armsy team 0 at 29.20 min
 29.34  [Playtest] finished armmex team 0 at 29.34 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +4.1 bank 187/1150, energy +37.0 bank 1062/1150, units 6
```

## Native lines (all AIs, first 120)

```
  1.27  BUILDER: discarded 1 unused default task(s) in the last minute
  1.31  BUILDER: discarded 1 unused default task(s) in the last minute
  1.37  BUILDER: discarded 1 unused default task(s) in the last minute
  1.37  BUILDER: discarded 1 unused default task(s) in the last minute
  1.38  BUILDER: discarded 1 unused default task(s) in the last minute
  1.39  BUILDER: discarded 1 unused default task(s) in the last minute
  1.51  BUILDER: discarded 2 unused default task(s) in the last minute
  1.51  BUILDER: discarded 1 unused default task(s) in the last minute
  2.32  BUILDER: discarded 2 unused default task(s) in the last minute
  2.38  BUILDER: discarded 2 unused default task(s) in the last minute
  2.38  BUILDER: discarded 2 unused default task(s) in the last minute
  2.38  BUILDER: discarded 2 unused default task(s) in the last minute
  2.40  BUILDER: discarded 3 unused default task(s) in the last minute
  2.41  BUILDER: discarded 1 unused default task(s) in the last minute
  2.51  BUILDER: discarded 2 unused default task(s) in the last minute
  3.32  BUILDER: discarded 1 unused default task(s) in the last minute
  3.38  BUILDER: discarded 4 unused default task(s) in the last minute
  3.38  BUILDER: discarded 4 unused default task(s) in the last minute
  3.41  BUILDER: discarded 1 unused default task(s) in the last minute
  3.41  BUILDER: discarded 4 unused default task(s) in the last minute
  3.47  BUILDER: discarded 1 unused default task(s) in the last minute
  3.48  BUILDER: discarded 2 unused default task(s) in the last minute
  3.51  BUILDER: discarded 5 unused default task(s) in the last minute
  4.38  BUILDER: discarded 3 unused default task(s) in the last minute
  4.38  BUILDER: discarded 2 unused default task(s) in the last minute
  4.42  BUILDER: discarded 4 unused default task(s) in the last minute
  4.48  BUILDER: discarded 2 unused default task(s) in the last minute
  4.49  BUILDER: discarded 1 unused default task(s) in the last minute
  4.52  BUILDER: discarded 4 unused default task(s) in the last minute
  5.42  BUILDER: discarded 3 unused default task(s) in the last minute
  5.53  BUILDER: discarded 1 unused default task(s) in the last minute
  5.69  BUILDER: discarded 1 unused default task(s) in the last minute
  6.42  BUILDER: discarded 3 unused default task(s) in the last minute
  6.54  BUILDER: discarded 1 unused default task(s) in the last minute
  6.69  BUILDER: discarded 1 unused default task(s) in the last minute
  6.72  BUILDER: discarded 1 unused default task(s) in the last minute
  6.74  BUILDER: discarded 1 unused default task(s) in the last minute
  6.97  BUILDER: discarded 1 unused default task(s) in the last minute
  7.13  BUILDER: discarded 1 unused default task(s) in the last minute
  7.43  BUILDER: discarded 1 unused default task(s) in the last minute
  7.70  BUILDER: discarded 1 unused default task(s) in the last minute
  7.74  BUILDER: discarded 2 unused default task(s) in the last minute
  7.97  BUILDER: discarded 1 unused default task(s) in the last minute
  8.13  BUILDER: discarded 1 unused default task(s) in the last minute
  8.31  BUILDER: discarded 1 unused default task(s) in the last minute
  8.43  BUILDER: discarded 2 unused default task(s) in the last minute
  8.68  BUILDER: discarded 1 unused default task(s) in the last minute
  8.70  BUILDER: discarded 1 unused default task(s) in the last minute
  8.74  BUILDER: discarded 2 unused default task(s) in the last minute
  8.97  BUILDER: discarded 2 unused default task(s) in the last minute
  9.14  BUILDER: discarded 1 unused default task(s) in the last minute
  9.32  BUILDER: discarded 5 unused default task(s) in the last minute
  9.43  BUILDER: discarded 3 unused default task(s) in the last minute
  9.74  BUILDER: discarded 2 unused default task(s) in the last minute
  9.81  BUILDER: discarded 1 unused default task(s) in the last minute
  9.88  BUILDER: discarded 1 unused default task(s) in the last minute
  9.96  BUILDER: discarded 1 unused default task(s) in the last minute
  9.98  BUILDER: discarded 2 unused default task(s) in the last minute
 10.15  BUILDER: discarded 1 unused default task(s) in the last minute
 10.20  BUILDER: discarded 1 unused default task(s) in the last minute
 10.32  BUILDER: discarded 3 unused default task(s) in the last minute
 10.44  BUILDER: discarded 3 unused default task(s) in the last minute
 10.75  BUILDER: discarded 4 unused default task(s) in the last minute
 10.81  BUILDER: discarded 4 unused default task(s) in the last minute
 10.88  BUILDER: discarded 1 unused default task(s) in the last minute
 10.88  BUILDER: discarded 2 unused default task(s) in the last minute
 10.90  BUILDER: discarded 1 unused default task(s) in the last minute
 10.96  BUILDER: discarded 1 unused default task(s) in the last minute
 10.98  BUILDER: discarded 3 unused default task(s) in the last minute
 11.15  BUILDER: discarded 1 unused default task(s) in the last minute
 11.20  BUILDER: discarded 15 unused default task(s) in the last minute
 11.32  BUILDER: discarded 5 unused default task(s) in the last minute
 11.44  BUILDER: discarded 1 unused default task(s) in the last minute
 11.75  BUILDER: discarded 3 unused default task(s) in the last minute
 11.88  BUILDER: discarded 3 unused default task(s) in the last minute
 11.90  BUILDER: discarded 16 unused default task(s) in the last minute
 11.96  BUILDER: discarded 1 unused default task(s) in the last minute
 11.98  BUILDER: discarded 3 unused default task(s) in the last minute
 12.15  BUILDER: discarded 2 unused default task(s) in the last minute
 12.30  BUILDER: discarded 1 unused default task(s) in the last minute
 12.32  BUILDER: discarded 2 unused default task(s) in the last minute
 12.44  BUILDER: discarded 3 unused default task(s) in the last minute
 12.75  BUILDER: discarded 2 unused default task(s) in the last minute
 12.88  BUILDER: discarded 3 unused default task(s) in the last minute
 12.90  BUILDER: discarded 4 unused default task(s) in the last minute
 12.99  BUILDER: discarded 3 unused default task(s) in the last minute
 13.08  BUILDER: discarded 1 unused default task(s) in the last minute
 13.15  BUILDER: discarded 2 unused default task(s) in the last minute
 13.30  BUILDER: discarded 1 unused default task(s) in the last minute
 13.33  BUILDER: discarded 6 unused default task(s) in the last minute
 13.44  BUILDER: discarded 2 unused default task(s) in the last minute
 13.71  BUILDER: discarded 1 unused default task(s) in the last minute
 13.75  BUILDER: discarded 5 unused default task(s) in the last minute
 13.88  BUILDER: discarded 2 unused default task(s) in the last minute
 13.91  BUILDER: discarded 2 unused default task(s) in the last minute
 14.08  BUILDER: discarded 2 unused default task(s) in the last minute
 14.16  BUILDER: discarded 2 unused default task(s) in the last minute
 14.18  BUILDER: discarded 1 unused default task(s) in the last minute
 14.31  BUILDER: discarded 7 unused default task(s) in the last minute
 14.33  BUILDER: discarded 4 unused default task(s) in the last minute
 14.42  BUILDER: discarded 1 unused default task(s) in the last minute
 14.45  BUILDER: discarded 4 unused default task(s) in the last minute
 14.71  BUILDER: discarded 1 unused default task(s) in the last minute
 14.76  BUILDER: discarded 4 unused default task(s) in the last minute
 14.90  BUILDER: discarded 2 unused default task(s) in the last minute
 14.91  BUILDER: discarded 3 unused default task(s) in the last minute
 15.16  BUILDER: discarded 5 unused default task(s) in the last minute
 15.31  BUILDER: discarded 2 unused default task(s) in the last minute
 15.43  BUILDER: discarded 2 unused default task(s) in the last minute
 15.47  BUILDER: discarded 1 unused default task(s) in the last minute
 15.71  BUILDER: discarded 3 unused default task(s) in the last minute
 15.76  BUILDER: discarded 3 unused default task(s) in the last minute
 15.90  BUILDER: discarded 3 unused default task(s) in the last minute
 16.16  BUILDER: discarded 2 unused default task(s) in the last minute
 16.31  BUILDER: discarded 1 unused default task(s) in the last minute
 16.43  BUILDER: discarded 6 unused default task(s) in the last minute
 16.48  BUILDER: discarded 1 unused default task(s) in the last minute
 16.72  BUILDER: discarded 1 unused default task(s) in the last minute
 16.78  BUILDER: discarded 2 unused default task(s) in the last minute
 16.90  BUILDER: discarded 3 unused default task(s) in the last minute
```
