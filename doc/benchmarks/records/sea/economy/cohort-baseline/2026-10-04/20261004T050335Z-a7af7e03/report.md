# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54009); wall 507 s
- DLL: build-theatres\d188-build-6\SkirmishAI.dll (ac71826721992d84); AI BARbTest/test; staged 2026-10-04T01:55:05
- Map: Serene Caldera v1.3; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=SEA/cortex/test, 9=SEA/legion/test, 10=SEA/armada/test, 11=SEA/cortex/test, 12=SEA/legion/test, 13=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\caldera\20261004T045504Z-0dffcb92\runs\20261004T050335Z-a7af7e03\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:43.370808][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.2 min | `[t=00:01:10.815794][f=0002136] [SeaWatch] finished frame=2136 id=31323 def=armsy builder=30651` |
| expect `first-ship-exit` | seen at 4.4 min | `[t=00:01:34.247370][f=0007950] [SeaWatch] egress id=23220 yard=31323 seconds=14.8 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\caldera\20261004T045504Z-0dffcb92\runs\20261004T050335Z-a7af7e03\screen_2026-10-04_04-56-49-484.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\caldera\20261004T045504Z-0dffcb92\runs\20261004T050335Z-a7af7e03\screen_2026-10-04_04-57-42-577.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\caldera\20261004T045504Z-0dffcb92\runs\20261004T050335Z-a7af7e03\screen_2026-10-04_05-00-32-787.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\caldera\20261004T045504Z-0dffcb92\runs\20261004T050335Z-a7af7e03\screen_2026-10-04_05-03-16-963.png

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
  0.00  [Playtest] frame 1 team 15 ally 3 side  ai false dead false start (0, 0) units 105
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
  0.05  [Playtest] frame 90 team 15 ally 3 side  ai false dead false start (0, 0) units 105
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|2836|2905|0|0|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(4500,1597) factory=armhp landLocked=no spot=1 known=1/6
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(6626,998) factory=corhp landLocked=no spot=2 known=2/6
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(8000,2900) factory=corhp landLocked=no spot=3 known=3/6
  0.10  [Team][Roster] Team 4 (AI 4): role=SEA side=armada start=(10084,3170) factory=armsy landLocked=no spot=5 known=4/6
  0.10  [Team][Roster] Team 5 (AI 5): role=SEA side=cortex start=(11030,1625) factory=corsy landLocked=no spot=6 known=5/6
  0.10  [Team][Roster] Team 6 (AI 6): role=SEA side=legion start=(12803,2748) factory=legsy landLocked=no spot=7 known=6/6
  0.18  [Team][Roster] team 1 first mex at 4480,1536
  0.19  [Team][Roster] team 3 first mex at 7936,3040
  0.20  [Playtest] finished armmex team 0 at 0.20 min
  0.20  [Team][Roster] team 6 first mex at 12800,2912
  0.22  [Team][Roster] first mex 11742 at 3008,2912
  0.22  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|2836|2905|0|0|1|3008|2912
  0.22  [Team][Roster] team 4 first mex at 10080,2976
  0.24  [Team][Roster] team 5 first mex at 10976,1584
  0.30  [Team][Roster] team 2 first mex at 6688,960
  0.48  [Playtest] finished armmex team 0 at 0.48 min
  0.65  [Playtest] finished armwin team 0 at 0.65 min
  0.76  [Playtest] finished armwin team 0 at 0.76 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.9 bank 966/1100, energy +69.9 bank 992/1001, units 6
  1.19  [Playtest] finished armsy team 0 at 1.19 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.9 bank 460/1200, energy +68.6 bank 17/1201, units 10
  2.03  [Playtest] finished armtide team 0 at 2.03 min
  2.30  [Playtest] finished armtide team 0 at 2.30 min
  2.60  [Playtest] finished armtide team 0 at 2.60 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.9 bank 0/1200, energy +152.7 bank 1351/1351, units 13
  3.09  [Playtest] finished armtide team 0 at 3.09 min
  3.40  [Playtest] finished armtide team 0 at 3.40 min
  3.51  [Playtest] finished armmex team 0 at 3.51 min
  3.66  [Playtest] finished armtide team 0 at 3.66 min
  3.88  [Playtest] finished armtide team 0 at 3.88 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +9.3 bank 9/1250, energy +244.8 bank 1549/1551, units 18
  4.06  [Playtest] finished armtide team 0 at 4.06 min
  4.28  [Playtest] finished armfmkr team 0 at 4.28 min
  4.32  [Playtest] finished armmex team 0 at 4.32 min
  4.50  [Playtest] finished armfmkr team 0 at 4.50 min
  4.72  [Playtest] finished armtide team 0 at 4.72 min
  4.93  [Playtest] finished armfmkr team 0 at 4.93 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +14.0 bank 30/1300, energy +290.6 bank 1321/1651, units 27
  5.00  [Playtest] target team 0 at (2800, 2900) from its start position
  5.00  [Playtest] camera requested (2800,2900) height=2200
  5.02  [Playtest] camera captured name=ta position=(2800,2900) height=2200
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (2800, 2900)
  5.20  [Playtest] finished armtide team 0 at 5.20 min
  5.21  [Playtest] finished armmex team 0 at 5.20 min
  5.52  [Playtest] finished armtide team 0 at 5.52 min
  5.57  [Playtest] finished armmex team 0 at 5.57 min
  5.75  [Playtest] finished armfmkr team 0 at 5.75 min
  5.93  [Playtest] finished armtide team 0 at 5.93 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +20.2 bank 183/1400, energy +362.7 bank 1720/1851, units 35
  6.08  [Playtest] finished armtide team 0 at 6.08 min
  6.23  [Playtest] finished armtide team 0 at 6.23 min
  6.69  [Playtest] finished armnanotcplat team 0 at 6.69 min
  6.77  [Playtest] finished armmex team 0 at 6.77 min
  6.82  [Playtest] finished armtide team 0 at 6.82 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +22.7 bank 263/1450, energy +428.8 bank 1755/2001, units 44
  7.05  [Playtest] finished armfmkr team 0 at 7.05 min
  7.19  [Playtest] finished armtide team 0 at 7.19 min
  7.26  [Playtest] finished armmex team 0 at 7.26 min
  7.32  [Playtest] finished armtide team 0 at 7.32 min
  7.46  [Playtest] finished armtide team 0 at 7.46 min
  7.73  [Playtest] finished armfmkr team 0 at 7.73 min
  7.80  [Playtest] finished armnanotcplat team 0 at 7.80 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +21.6 bank 185/1500, energy +502.9 bank 1648/2201, units 55
  8.00  [Playtest] finished armtide team 0 at 8.00 min
  8.24  [Playtest] finished armnanotcplat team 0 at 8.24 min
  8.34  [Playtest] finished armtide team 0 at 8.34 min
  8.69  [Playtest] finished armtide team 0 at 8.69 min
  8.77  [Playtest] finished armnanotcplat team 0 at 8.77 min
  8.91  [Playtest] finished armtide team 0 at 8.91 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +26.7 bank 15/1500, energy +594.8 bank 1961/2401, units 56
  9.12  [Playtest] finished armfmkr team 0 at 9.12 min
  9.47  [Playtest] finished armnanotcplat team 0 at 9.47 min
  9.53  [Playtest] finished armtide team 0 at 9.53 min
  9.67  [Playtest] finished armfmkr team 0 at 9.67 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +27.0 bank 0/1500, energy +625.7 bank 2054/2451, units 61
 10.00  [Playtest] camera requested (2800,2900) height=2200
 10.02  [Playtest] camera captured name=ta position=(2800,2900) height=2200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (2800, 2900)
 10.05  [Playtest] finished armtide team 0 at 10.05 min
 10.16  [Playtest] finished armtide team 0 at 10.16 min
 10.51  [Playtest] finished armtide team 0 at 10.51 min
 10.62  [Playtest] finished armmex team 0 at 10.62 min
 10.86  [Playtest] finished armtide team 0 at 10.86 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +29.6 bank 12/1550, energy +712.9 bank 2242/2701, units 73
 11.28  [Playtest] finished armtide team 0 at 11.28 min
 11.50  [Playtest] finished armtl team 0 at 11.50 min
 11.65  [Playtest] finished armtide team 0 at 11.65 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +30.2 bank 0/1550, energy +768.3 bank 2363/2801, units 75
 12.17  [Playtest] finished armmex team 0 at 12.17 min
 12.19  [Playtest] finished armtide team 0 at 12.19 min
 12.22  [Playtest] finished armtl team 0 at 12.22 min
 12.39  [Playtest] finished armtide team 0 at 12.39 min
 12.55  [Playtest] finished armfmkr team 0 at 12.55 min
 12.76  [Playtest] finished armtide team 0 at 12.76 min
 12.78  [Playtest] finished armtl team 0 at 12.78 min
 12.94  [Playtest] finished armmex team 0 at 12.94 min
 12.94  [Playtest] finished armtide team 0 at 12.94 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +35.0 bank 49/1650, energy +836.5 bank 2682/3001, units 90
 13.19  [Playtest] finished armtide team 0 at 13.19 min
 13.29  [Playtest] finished armmex team 0 at 13.29 min
 13.48  [Playtest] finished armtide team 0 at 13.48 min
 13.70  [Playtest] finished armnanotcplat team 0 at 13.70 min
 13.78  [Playtest] finished armtide team 0 at 13.78 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +36.6 bank 16/1700, energy +908.1 bank 2619/3101, units 89
 14.01  [Playtest] finished armtide team 0 at 14.01 min
 14.13  [Playtest] finished armnanotcplat team 0 at 14.13 min
 14.25  [Playtest] finished armtide team 0 at 14.25 min
 14.48  [Playtest] finished armfmkr team 0 at 14.48 min
 14.52  [Playtest] finished armfmkr team 0 at 14.52 min
 14.57  [Playtest] finished armfmkr team 0 at 14.57 min
 14.63  [Playtest] finished armfmkr team 0 at 14.63 min
 14.81  [Playtest] finished armtide team 0 at 14.81 min
 14.91  [Playtest] finished armfrad team 0 at 14.91 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +38.9 bank 0/1700, energy +996.1 bank 2862/3351, units 97
 15.09  [Playtest] finished armtide team 0 at 15.09 min
 15.26  [Playtest] finished armnanotcplat team 0 at 15.26 min
 15.37  [Playtest] finished armtide team 0 at 15.37 min
 15.58  [Playtest] finished armtide team 0 at 15.58 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +35.9 bank 0/1600, energy +1061.5 bank 3012/3501, units 98
 16.05  [Playtest] finished armtide team 0 at 16.05 min
 16.19  [Playtest] finished armfmkr team 0 at 16.19 min
 16.62  [Playtest] finished armtide team 0 at 16.62 min
 16.64  [Playtest] finished armtl team 0 at 16.64 min
 16.86  [Playtest] finished armtide team 0 at 16.86 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +34.9 bank 0/1550, energy +1125.8 bank 3065/3501, units 95
 17.17  [Playtest] finished armtide team 0 at 17.17 min
 17.53  [Playtest] finished armtide team 0 at 17.53 min
 17.71  [Playtest] finished armtide team 0 at 17.71 min
 17.72  [Playtest] finished armtide team 0 at 17.72 min
 17.79  [Playtest] finished armfmkr team 0 at 17.79 min
 17.91  [Playtest] finished armtide team 0 at 17.91 min
 18.00  [Playtest] finished armfmkr team 0 at 18.00 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +33.0 bank 15/1550, energy +1245.6 bank 3235/3801, units 102
 18.05  [Playtest] finished armtide team 0 at 18.05 min
 18.27  [Playtest] finished armfmkr team 0 at 18.27 min
 18.36  [Playtest] finished armtide team 0 at 18.36 min
 18.49  [Playtest] finished armfmkr team 0 at 18.49 min
 18.90  [Playtest] finished armtl team 0 at 18.90 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +36.7 bank 13/1550, energy +1287.6 bank 3459/3951, units 105
 19.15  [Playtest] finished armtl team 0 at 19.15 min
 19.31  [Playtest] finished armfmkr team 0 at 19.31 min
 19.52  [Playtest] finished armtl team 0 at 19.52 min
 19.70  [Playtest] finished armfmkr team 0 at 19.70 min
 19.91  [Playtest] finished armfmkr team 0 at 19.91 min
 19.91  [Playtest] finished armfrad team 0 at 19.91 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +33.9 bank 14/1500, energy +1290.6 bank 3444/3951, units 115
 20.00  [Playtest] camera requested (2800,2900) height=2200
 20.00  [Playtest] camera captured name=ta position=(2800,2900) height=2200
 20.00  [Playtest] screenshot at 20.0 min of team 0 at (2800, 2900)
 20.08  [Playtest] finished armfmkr team 0 at 20.08 min
 20.11  [Playtest] finished armfrad team 0 at 20.11 min
 20.42  [Playtest] finished armfmkr team 0 at 20.42 min
 20.66  [Playtest] finished armfmkr team 0 at 20.66 min
 20.72  [Playtest] finished armtl team 0 at 20.72 min
 20.91  [Playtest] finished armfmkr team 0 at 20.91 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +37.9 bank 3/1500, energy +1303.8 bank 3411/4001, units 125
 21.11  [Playtest] finished armfmkr team 0 at 21.11 min
 21.17  [Playtest] finished armfrad team 0 at 21.17 min
 21.24  [Playtest] finished armfmkr team 0 at 21.24 min
 21.39  [Playtest] finished armfmkr team 0 at 21.40 min
 21.63  [Playtest] finished armfmkr team 0 at 21.63 min
 21.85  [Playtest] finished armtl team 0 at 21.85 min
 21.91  [Playtest] finished armfmkr team 0 at 21.91 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +33.3 bank 0/1450, energy +1289.2 bank 3471/3951, units 118
 22.25  [Playtest] finished armfmkr team 0 at 22.25 min
 22.43  [Playtest] finished armfmkr team 0 at 22.43 min
 22.85  [Playtest] finished armfmkr team 0 at 22.85 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +19.2 bank 16/1350, energy +1278.4 bank 3326/3801, units 116
 23.07  [Playtest] finished armfmkr team 0 at 23.07 min
 23.39  [Playtest] finished armfmkr team 0 at 23.39 min
 23.55  [Playtest] finished armfmkr team 0 at 23.55 min
 23.81  [Playtest] finished armfmkr team 0 at 23.81 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +21.6 bank 162/1200, energy +1254.0 bank 3472/3900, units 111
 25.00  [Playtest] eco team 0 at 25.0 min: metal +0.0 bank 395/500, energy +0.0 bank 474/500, units 0
 26.00  [Playtest] eco team 0 at 26.0 min: metal +0.0 bank 395/500, energy +0.0 bank 474/500, units 0
 27.00  [Playtest] eco team 0 at 27.0 min: metal +0.0 bank 395/500, energy +0.0 bank 474/500, units 0
 28.00  [Playtest] eco team 0 at 28.0 min: metal +0.0 bank 395/500, energy +0.0 bank 474/500, units 0
 29.00  [Playtest] eco team 0 at 29.0 min: metal +0.0 bank 395/500, energy +0.0 bank 474/500, units 0
 29.00  [Playtest] camera requested (2800,2900) height=2200
 29.00  [Playtest] camera captured name=ta position=(2800,2900) height=2200
 29.00  [Playtest] screenshot at 29.0 min of team 0 at (2800, 2900)
 30.00  [Playtest] eco team 0 at 30.0 min: metal +0.0 bank 395/500, energy +0.0 bank 474/500, units 0
```

## Native lines (all AIs, first 120)

```
  1.14  BUILDER: discarded 1 unused default task(s) in the last minute
  1.16  BUILDER: discarded 1 unused default task(s) in the last minute
  1.24  BUILDER: discarded 1 unused default task(s) in the last minute
  1.28  BUILDER: discarded 1 unused default task(s) in the last minute
  1.35  BUILDER: discarded 1 unused default task(s) in the last minute
  1.40  BUILDER: discarded 1 unused default task(s) in the last minute
  1.44  BUILDER: discarded 1 unused default task(s) in the last minute
  1.51  BUILDER: discarded 2 unused default task(s) in the last minute
  2.14  BUILDER: discarded 2 unused default task(s) in the last minute
  2.16  BUILDER: discarded 3 unused default task(s) in the last minute
  2.28  BUILDER: discarded 2 unused default task(s) in the last minute
  2.30  BUILDER: discarded 4 unused default task(s) in the last minute
  2.35  BUILDER: discarded 2 unused default task(s) in the last minute
  2.41  BUILDER: discarded 2 unused default task(s) in the last minute
  2.45  BUILDER: discarded 3 unused default task(s) in the last minute
  3.11  CBFactoryTask: no site for armtide in a usable armtide area near (3091, 2375); retrying without the area check
  3.11  CBFactoryTask: no site for armtide at all | origin (3091, 2375) elev -38 | canBuildHere=1 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
  3.14  BUILDER: discarded 1 unused default task(s) in the last minute
  3.17  BUILDER: discarded 3 unused default task(s) in the last minute
  3.30  BUILDER: discarded 6 unused default task(s) in the last minute
  3.30  BUILDER: discarded 4 unused default task(s) in the last minute
  3.41  BUILDER: discarded 3 unused default task(s) in the last minute
  3.44  BUILDER: discarded 1 unused default task(s) in the last minute
  3.46  BUILDER: discarded 4 unused default task(s) in the last minute
  3.47  BUILDER: discarded 3 unused default task(s) in the last minute
  4.17  BUILDER: discarded 4 unused default task(s) in the last minute
  4.30  BUILDER: discarded 3 unused default task(s) in the last minute
  4.42  BUILDER: discarded 2 unused default task(s) in the last minute
  4.45  BUILDER: discarded 2 unused default task(s) in the last minute
  4.46  BUILDER: discarded 4 unused default task(s) in the last minute
  5.18  BUILDER: discarded 1 unused default task(s) in the last minute
  5.31  BUILDER: discarded 1 unused default task(s) in the last minute
  5.45  BUILDER: discarded 1 unused default task(s) in the last minute
  5.69  BUILDER: discarded 1 unused default task(s) in the last minute
  5.92  BUILDER: discarded 1 unused default task(s) in the last minute
  6.06  BUILDER: discarded 1 unused default task(s) in the last minute
  6.18  BUILDER: discarded 1 unused default task(s) in the last minute
  6.31  BUILDER: discarded 1 unused default task(s) in the last minute
  6.45  BUILDER: discarded 2 unused default task(s) in the last minute
  7.22  BUILDER: discarded 1 unused default task(s) in the last minute
  7.32  BUILDER: discarded 3 unused default task(s) in the last minute
  7.41  BUILDER: discarded 1 unused default task(s) in the last minute
  7.58  BUILDER: discarded 1 unused default task(s) in the last minute
  7.75  BUILDER: discarded 1 unused default task(s) in the last minute
  8.17  BUILDER: discarded 1 unused default task(s) in the last minute
  8.22  BUILDER: discarded 4 unused default task(s) in the last minute
  8.32  BUILDER: discarded 3 unused default task(s) in the last minute
  8.41  BUILDER: discarded 1 unused default task(s) in the last minute
  8.58  BUILDER: discarded 1 unused default task(s) in the last minute
  8.65  BUILDER: discarded 1 unused default task(s) in the last minute
  8.67  BUILDER: discarded 1 unused default task(s) in the last minute
  8.75  BUILDER: discarded 1 unused default task(s) in the last minute
  9.17  BUILDER: discarded 2 unused default task(s) in the last minute
  9.23  BUILDER: discarded 1 unused default task(s) in the last minute
  9.32  BUILDER: discarded 1 unused default task(s) in the last minute
  9.42  BUILDER: discarded 3 unused default task(s) in the last minute
  9.75  BUILDER: discarded 3 unused default task(s) in the last minute
  9.89  CBFactoryTask: no site for armtide in a usable armtide area near (10706, 2641); retrying without the area check
  9.89  CBFactoryTask: no site for armtide at all | origin (10706, 2641) elev -62 | canBuildHere=1 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
  9.90  BUILDER: discarded 1 unused default task(s) in the last minute
  9.95  CBFactoryTask: no site for armtide in a usable armtide area near (10783, 2640); retrying without the area check
  9.95  CBFactoryTask: no site for armtide at all | origin (10783, 2640) elev -63 | canBuildHere=1 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
 10.18  BUILDER: discarded 2 unused default task(s) in the last minute
 10.24  BUILDER: discarded 5 unused default task(s) in the last minute
 10.32  BUILDER: discarded 2 unused default task(s) in the last minute
 10.43  BUILDER: discarded 4 unused default task(s) in the last minute
 10.48  BUILDER: discarded 1 unused default task(s) in the last minute
 10.66  BUILDER: discarded 1 unused default task(s) in the last minute
 10.75  BUILDER: discarded 3 unused default task(s) in the last minute
 10.97  BUILDER: discarded 1 unused default task(s) in the last minute
 10.99  CBFactoryTask: no site for armtide in a usable armtide area near (10715, 2573); retrying without the area check
 10.99  CBFactoryTask: no site for armtide at all | origin (10715, 2573) elev -66 | canBuildHere=1 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
 11.05  CBFactoryTask: no site for armtide in a usable armtide area near (10692, 2536); retrying without the area check
 11.05  CBFactoryTask: no site for armtide at all | origin (10692, 2536) elev -67 | canBuildHere=1 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
 11.18  BUILDER: discarded 1 unused default task(s) in the last minute
 11.25  BUILDER: discarded 2 unused default task(s) in the last minute
 11.32  BUILDER: discarded 2 unused default task(s) in the last minute
 11.43  BUILDER: discarded 3 unused default task(s) in the last minute
 11.67  BUILDER: discarded 3 unused default task(s) in the last minute
 11.76  BUILDER: discarded 3 unused default task(s) in the last minute
 11.80  BUILDER: discarded 3 unused default task(s) in the last minute
 11.98  BUILDER: discarded 1 unused default task(s) in the last minute
 12.19  BUILDER: discarded 3 unused default task(s) in the last minute
 12.25  BUILDER: discarded 3 unused default task(s) in the last minute
 12.33  BUILDER: discarded 2 unused default task(s) in the last minute
 12.43  BUILDER: discarded 1 unused default task(s) in the last minute
 12.55  CBFactoryTask: no site for armtide in a usable armtide area near (10757, 2608); retrying without the area check
 12.55  CBFactoryTask: no site for armtide at all | origin (10757, 2608) elev -65 | canBuildHere=1 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
 12.58  CBFactoryTask: no site for armtide in a usable armtide area near (10794, 2581); retrying without the area check
 12.58  CBFactoryTask: no site for armtide at all | origin (10794, 2581) elev -66 | canBuildHere=1 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
 12.67  BUILDER: discarded 5 unused default task(s) in the last minute
 12.69  CBFactoryTask: no site for armtide in a usable armtide area near (10766, 2663); retrying without the area check
 12.69  CBFactoryTask: no site for armtide at all | origin (10766, 2663) elev -62 | canBuildHere=1 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
 12.72  CBFactoryTask: no site for armtide in a usable armtide area near (10853, 2600); retrying without the area check
 12.72  CBFactoryTask: no site for armtide at all | origin (10853, 2600) elev -67 | canBuildHere=1 reach=1 threat=0.0 enginePossible=1 mobileId=-1 immobileId=20 builder=armcs radius=1600
 12.76  BUILDER: discarded 3 unused default task(s) in the last minute
 12.84  CBFactoryTask: no site for armtide in a usable armtide area near (10857, 2517); retrying without the area check
 12.84  CBFactoryTask: no site for armtide at all | origin (10857, 2517) elev -68 | canBuildHere=1 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
 12.99  BUILDER: discarded 1 unused default task(s) in the last minute
 12.99  BUILDER: discarded 3 unused default task(s) in the last minute
 13.19  BUILDER: discarded 3 unused default task(s) in the last minute
 13.22  BUILDER: discarded 1 unused default task(s) in the last minute
 13.25  BUILDER: discarded 2 unused default task(s) in the last minute
 13.50  BUILDER: discarded 1 unused default task(s) in the last minute
 13.53  CBFactoryTask: no site for armtide in a usable armtide area near (10752, 2550); retrying without the area check
 13.53  CBFactoryTask: no site for armtide at all | origin (10752, 2550) elev -67 | canBuildHere=1 reach=1 threat=0.0 enginePossible=0 mobileId=-1 immobileId=20 builder=armcs radius=1600
 13.67  BUILDER: discarded 1 unused default task(s) in the last minute
 13.67  BUILDER: discarded 8 unused default task(s) in the last minute
 13.76  BUILDER: discarded 4 unused default task(s) in the last minute
 13.90  BUILDER: discarded 1 unused default task(s) in the last minute
 13.99  BUILDER: discarded 2 unused default task(s) in the last minute
 14.17  BUILDER: discarded 1 unused default task(s) in the last minute
 14.17  BUILDER: discarded 1 unused default task(s) in the last minute
 14.20  BUILDER: discarded 2 unused default task(s) in the last minute
 14.25  BUILDER: discarded 4 unused default task(s) in the last minute
 14.47  CBFactoryTask: no site for armtide in a usable armtide area near (10846, 2664); retrying without the area check
 14.47  CBFactoryTask: no site for armtide at all | origin (10846, 2664) elev -64 | canBuildHere=1 reach=1 threat=0.0 enginePossible=1 mobileId=-1 immobileId=20 builder=armcs radius=1600
 14.50  BUILDER: discarded 4 unused default task(s) in the last minute
 14.67  BUILDER: discarded 4 unused default task(s) in the last minute
 14.67  BUILDER: discarded 4 unused default task(s) in the last minute
```
