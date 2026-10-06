# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 30.0 min (frame 54015); wall 403 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (8f86a21003fa1cb7); AI BARbTest/test; staged 2026-10-05T22:03:27
- Map: Shore_to_Shore_V3; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=SEA/cortex/test, 9=SEA/legion/test, 10=SEA/armada/test, 11=SEA/cortex/test, 12=SEA/legion/test, 13=SEA/armada/test, 14=SEA/cortex/test, 15=SEA/legion/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea-production-8v8.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\production-8v8\shore\20261006T010326Z-a15a0203\runs\20261006T011019Z-cd0a68df\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:28.939896][f=-000001] [SeaRecoveryTest] loaded teams=16 fixture=false` |
| expect `sub-scaling` | **missing** (by 30 min) | |
| expect `start-count` | seen at 0.1 min | `[Setup] StartSpots length=16` |
| forbid `errors` | clean |  |

## Failures

- 'sub-scaling' not seen by 30.0 min

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\production-8v8\shore\20261006T010326Z-a15a0203\runs\20261006T011019Z-cd0a68df\screen_2026-10-06_01-05-01-467.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\production-8v8\shore\20261006T010326Z-a15a0203\runs\20261006T011019Z-cd0a68df\screen_2026-10-06_01-05-52-063.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\production-8v8\shore\20261006T010326Z-a15a0203\runs\20261006T011019Z-cd0a68df\screen_2026-10-06_01-07-53-569.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\production-8v8\shore\20261006T010326Z-a15a0203\runs\20261006T011019Z-cd0a68df\screen_2026-10-06_01-10-02-365.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 20, 4 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (1600, 600) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (1600, 1200) units 1
  0.00  [Playtest] frame 1 team 2 ally 0 side cortex ai true dead false start (1600, 1800) units 1
  0.00  [Playtest] frame 1 team 3 ally 0 side legion ai true dead false start (1600, 2400) units 1
  0.00  [Playtest] frame 1 team 4 ally 0 side armada ai true dead false start (2800, 600) units 1
  0.00  [Playtest] frame 1 team 5 ally 0 side cortex ai true dead false start (2800, 1200) units 1
  0.00  [Playtest] frame 1 team 6 ally 0 side legion ai true dead false start (2800, 1800) units 1
  0.00  [Playtest] frame 1 team 7 ally 0 side armada ai true dead false start (2800, 2400) units 1
  0.00  [Playtest] frame 1 team 8 ally 1 side cortex ai true dead false start (13750, 600) units 1
  0.00  [Playtest] frame 1 team 9 ally 1 side legion ai true dead false start (13750, 1200) units 1
  0.00  [Playtest] frame 1 team 10 ally 1 side armada ai true dead false start (13750, 1800) units 1
  0.00  [Playtest] frame 1 team 11 ally 1 side cortex ai true dead false start (13750, 2400) units 1
  0.00  [Playtest] frame 1 team 12 ally 1 side legion ai true dead false start (12550, 600) units 1
  0.00  [Playtest] frame 1 team 13 ally 1 side armada ai true dead false start (12550, 1200) units 1
  0.00  [Playtest] frame 1 team 14 ally 1 side cortex ai true dead false start (12550, 1800) units 1
  0.00  [Playtest] frame 1 team 15 ally 1 side legion ai true dead false start (12550, 2400) units 1
  0.00  [Playtest] frame 1 team 16 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 17 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 20
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (1600, 600) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (1600, 1200) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (1600, 1800) units 1
  0.05  [Playtest] frame 90 team 3 ally 0 side legion ai true dead false start (1600, 2400) units 1
  0.05  [Playtest] frame 90 team 4 ally 0 side armada ai true dead false start (2800, 600) units 1
  0.05  [Playtest] frame 90 team 5 ally 0 side cortex ai true dead false start (2800, 1200) units 1
  0.05  [Playtest] frame 90 team 6 ally 0 side legion ai true dead false start (2800, 1800) units 1
  0.05  [Playtest] frame 90 team 7 ally 0 side armada ai true dead false start (2800, 2400) units 1
  0.05  [Playtest] frame 90 team 8 ally 1 side cortex ai true dead false start (13750, 600) units 1
  0.05  [Playtest] frame 90 team 9 ally 1 side legion ai true dead false start (13750, 1200) units 1
  0.05  [Playtest] frame 90 team 10 ally 1 side armada ai true dead false start (13750, 1800) units 1
  0.05  [Playtest] frame 90 team 11 ally 1 side cortex ai true dead false start (13750, 2400) units 1
  0.05  [Playtest] frame 90 team 12 ally 1 side legion ai true dead false start (12550, 600) units 1
  0.05  [Playtest] frame 90 team 13 ally 1 side armada ai true dead false start (12550, 1200) units 1
  0.05  [Playtest] frame 90 team 14 ally 1 side cortex ai true dead false start (12550, 1800) units 1
  0.05  [Playtest] frame 90 team 15 ally 1 side legion ai true dead false start (12550, 2400) units 1
  0.05  [Playtest] frame 90 team 16 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 17 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|1628|638|0|0|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(1637,1241) factory=armsy landLocked=no spot=1 known=1/7
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(1599,1801) factory=corsy landLocked=no spot=2 known=2/7
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(1595,2418) factory=legsy landLocked=no spot=3 known=3/7
  0.10  [Team][Roster] Team 4 (AI 4): role=SEA side=armada start=(2802,638) factory=armsy landLocked=no spot=4 known=4/7
  0.10  [Team][Roster] Team 5 (AI 5): role=SEA side=cortex start=(2778,1237) factory=corsy landLocked=no spot=5 known=5/7
  0.10  [Team][Roster] Team 6 (AI 6): role=SEA side=legion start=(2763,1795) factory=legsy landLocked=no spot=6 known=6/7
  0.10  [Team][Roster] Team 7 (AI 7): role=SEA side=armada start=(2833,2410) factory=armsy landLocked=no spot=7 known=7/7
  0.18  [Team][Roster] team 2 first mex at 1568,1951
  0.19  [Team][Roster] team 3 first mex at 1568,2528
  0.24  [Playtest] finished armmex team 0 at 0.24 min
  0.25  [Team][Roster] first mex 8022 at 1792,832
  0.25  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1628|638|0|0|1|1792|832
  0.27  [Team][Roster] team 6 first mex at 2528,1696
  0.28  [Team][Roster] team 1 first mex at 1888,1488
  0.29  [Team][Roster] team 4 first mex at 2816,944
  0.32  [Team][Roster] team 7 first mex at 3168,2448
  0.35  [Playtest] finished armwin team 0 at 0.35 min
  0.61  [Playtest] finished armmex team 0 at 0.61 min
  0.72  [Playtest] finished armwin team 0 at 0.72 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.1 bank 903/1100, energy +60.3 bank 982/1001, units 6
  1.16  [Playtest] finished armsy team 0 at 1.16 min
  1.25  [SEA][Layout] berth sea.berth.0 armasy at=3056,192 facing=1
  1.32  [SEA][Layout] berth sea.berth.1 armplat at=2880,160 facing=1
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.1 bank 552/1200, energy +80.0 bank 205/1201, units 10
  2.10  [Playtest] finished armmex team 0 at 2.10 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.1 bank 465/1250, energy +66.8 bank 18/1201, units 11
  3.37  [Team][Roster] team 5 first mex at 4784,1935
  4.00  [Playtest] eco team 0 at 4.0 min: metal +8.1 bank 237/1250, energy +80.0 bank 1154/1201, units 12
  5.00  [Playtest] eco team 0 at 5.0 min: metal +8.1 bank 182/1250, energy +63.8 bank 1162/1201, units 15
  5.00  [Playtest] camera requested (2200,1550) height=4200
  5.02  [Playtest] camera captured name=ta position=(2200,1550) height=4200
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (2200, 1550)
  5.15  [Playtest] finished armmex team 0 at 5.15 min
  5.52  [Playtest] finished armtl team 0 at 5.52 min
  5.84  [Playtest] finished armfrad team 0 at 5.84 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +10.2 bank 21/1300, energy +79.7 bank 1178/1201, units 18
  7.00  [Playtest] eco team 0 at 7.0 min: metal +10.2 bank 0/1300, energy +80.0 bank 1170/1201, units 17
  8.00  [Playtest] eco team 0 at 8.0 min: metal +10.2 bank 0/1300, energy +79.7 bank 1164/1201, units 17
  8.13  [Playtest] finished armtl team 0 at 8.13 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +10.2 bank 0/1300, energy +79.7 bank 1163/1201, units 17
  9.05  [Playtest] finished armllt team 0 at 9.05 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +10.2 bank 5/1300, energy +74.7 bank 1198/1201, units 17
 10.00  [Playtest] camera requested (5500,1550) height=6000
 10.02  [Playtest] camera captured name=ta position=(5500,1550) height=6000
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (5500, 1550)
 11.00  [Playtest] eco team 0 at 11.0 min: metal +10.2 bank 0/1300, energy +64.5 bank 1156/1201, units 19
 12.00  [Playtest] eco team 0 at 12.0 min: metal +10.2 bank 0/1300, energy +70.2 bank 1162/1201, units 19
 13.00  [Playtest] eco team 0 at 13.0 min: metal +10.2 bank 9/1300, energy +80.0 bank 1162/1201, units 19
 13.75  [Playtest] finished armtl team 0 at 13.75 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +10.2 bank 17/1300, energy +68.3 bank 1152/1201, units 20
 15.00  [Playtest] eco team 0 at 15.0 min: metal +10.2 bank 79/1300, energy +72.3 bank 1156/1201, units 19
 15.44  [Playtest] finished armtl team 0 at 15.44 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +10.2 bank 86/1300, energy +78.4 bank 1177/1201, units 22
 17.00  [Playtest] eco team 0 at 17.0 min: metal +10.2 bank 73/1300, energy +79.9 bank 1147/1201, units 22
 18.00  [Playtest] eco team 0 at 18.0 min: metal +10.2 bank 0/1300, energy +77.7 bank 1165/1201, units 20
 19.00  [Playtest] eco team 0 at 19.0 min: metal +10.2 bank 0/1300, energy +75.8 bank 1162/1201, units 18
 20.00  [Playtest] eco team 0 at 20.0 min: metal +10.2 bank 3/1300, energy +76.7 bank 1161/1201, units 19
 20.00  [Playtest] camera requested (7500,1550) height=7000
 20.02  [Playtest] camera captured name=ta position=(7500,1550) height=7000
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (7500, 1550)
 21.00  [Playtest] eco team 0 at 21.0 min: metal +10.2 bank 0/1300, energy +70.9 bank 1166/1201, units 20
 22.00  [Playtest] eco team 0 at 22.0 min: metal +10.2 bank 15/1300, energy +69.8 bank 1192/1201, units 20
 23.00  [Playtest] eco team 0 at 23.0 min: metal +10.2 bank 0/1300, energy +69.0 bank 1164/1201, units 20
 24.00  [Playtest] eco team 0 at 24.0 min: metal +10.2 bank 0/1300, energy +57.3 bank 1153/1201, units 19
 25.00  [Playtest] eco team 0 at 25.0 min: metal +10.2 bank 9/1300, energy +80.0 bank 1159/1201, units 19
 26.00  [Playtest] eco team 0 at 26.0 min: metal +10.2 bank 0/1300, energy +74.0 bank 1167/1201, units 18
 26.58  [Playtest] finished armtl team 0 at 26.58 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +10.2 bank 0/1300, energy +79.6 bank 1167/1201, units 19
 27.75  [Playtest] finished armrad team 0 at 27.75 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +8.1 bank 0/1250, energy +73.9 bank 1178/1201, units 16
 29.00  [Playtest] eco team 0 at 29.0 min: metal +8.1 bank 0/1250, energy +79.7 bank 1178/1201, units 16
 29.00  [Playtest] camera requested (2800,1550) height=5000
 29.02  [Playtest] camera captured name=ta position=(2800,1550) height=5000
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (2800, 1550)
 30.00  [Playtest] eco team 0 at 30.0 min: metal +8.1 bank 0/1250, energy +79.6 bank 1185/1201, units 16
```

## Native lines (all AIs, first 120)

```
  0.09  RESERVE: zone 1 at (2216, 1448) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2216, 1448) facing 1 (id 1)
  0.09  RESERVE: zone 2 at (2216, 1400) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2216, 1400) facing 1 (id 2)
  0.09  RESERVE: zone 3 at (2216, 1352) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2216, 1352) facing 1 (id 3)
  0.09  RESERVE: zone 4 at (2216, 1304) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2216, 1304) facing 1 (id 4)
  0.09  RESERVE: zone 5 at (2216, 1256) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2216, 1256) facing 1 (id 5)
  0.09  RESERVE: zone 6 at (2216, 1208) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2216, 1208) facing 1 (id 6)
  0.09  RESERVE: zone 7 at (2264, 1448) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2264, 1448) facing 1 (id 7)
  0.09  RESERVE: zone 8 at (2264, 1400) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2264, 1400) facing 1 (id 8)
  0.09  RESERVE: zone 9 at (2264, 1352) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2264, 1352) facing 1 (id 9)
  0.09  RESERVE: zone 10 at (2264, 1304) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2264, 1304) facing 1 (id 10)
  0.09  RESERVE: zone 11 at (2264, 1256) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2264, 1256) facing 1 (id 11)
  0.09  RESERVE: zone 12 at (2264, 1208) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2264, 1208) facing 1 (id 12)
  0.09  RESERVE: zone 13 at (2312, 1448) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2312, 1448) facing 1 (id 13)
  0.09  RESERVE: zone 14 at (2312, 1400) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2312, 1400) facing 1 (id 14)
  0.09  RESERVE: zone 15 at (2312, 1352) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2312, 1352) facing 1 (id 15)
  0.09  RESERVE: zone 16 at (2312, 1304) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2312, 1304) facing 1 (id 16)
  0.09  RESERVE: zone 17 at (2312, 1256) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2312, 1256) facing 1 (id 17)
  0.09  RESERVE: zone 18 at (2312, 1208) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2312, 1208) facing 1 (id 18)
  0.09  RESERVE: zone 19 at (2360, 1448) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2360, 1448) facing 1 (id 19)
  0.09  RESERVE: zone 20 at (2360, 1400) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2360, 1400) facing 1 (id 20)
  0.09  RESERVE: zone 21 at (2360, 1352) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2360, 1352) facing 1 (id 21)
  0.09  RESERVE: zone 22 at (2360, 1304) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2360, 1304) facing 1 (id 22)
  0.09  RESERVE: zone 23 at (2360, 1256) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2360, 1256) facing 1 (id 23)
  0.09  RESERVE: zone 24 at (2360, 1208) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2360, 1208) facing 1 (id 24)
  0.09  RESERVE: zone 25 at (2408, 1448) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2408, 1448) facing 1 (id 25)
  0.09  RESERVE: zone 26 at (2408, 1400) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2408, 1400) facing 1 (id 26)
  0.09  RESERVE: zone 27 at (2408, 1352) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2408, 1352) facing 1 (id 27)
  0.09  RESERVE: zone 28 at (2408, 1304) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2408, 1304) facing 1 (id 28)
  0.09  RESERVE: zone 29 at (2408, 1256) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2408, 1256) facing 1 (id 29)
  0.09  RESERVE: zone 30 at (2408, 1208) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2408, 1208) facing 1 (id 30)
  0.09  RESERVE: zone 31 at (2456, 1448) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2456, 1448) facing 1 (id 31)
  0.09  RESERVE: zone 32 at (2456, 1400) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2456, 1400) facing 1 (id 32)
  0.09  RESERVE: zone 33 at (2456, 1352) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2456, 1352) facing 1 (id 33)
  0.09  RESERVE: zone 34 at (2456, 1304) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2456, 1304) facing 1 (id 34)
  0.09  RESERVE: zone 35 at (2456, 1256) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2456, 1256) facing 1 (id 35)
  0.09  RESERVE: zone 36 at (2456, 1208) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2456, 1208) facing 1 (id 36)
  0.09  RESERVE: zone 37 at (2504, 1448) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2504, 1448) facing 1 (id 37)
  0.09  RESERVE: zone 38 at (2504, 1400) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2504, 1400) facing 1 (id 38)
  0.09  RESERVE: zone 39 at (2504, 1352) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2504, 1352) facing 1 (id 39)
  0.09  RESERVE: zone 40 at (2504, 1304) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2504, 1304) facing 1 (id 40)
  0.09  RESERVE: zone 41 at (2504, 1256) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2504, 1256) facing 1 (id 41)
  0.09  RESERVE: zone 42 at (2504, 1208) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2504, 1208) facing 1 (id 42)
  0.09  RESERVE: zone 43 at (2552, 1448) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2552, 1448) facing 1 (id 43)
  0.09  RESERVE: zone 44 at (2552, 1400) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2552, 1400) facing 1 (id 44)
  0.09  RESERVE: zone 45 at (2552, 1352) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2552, 1352) facing 1 (id 45)
  0.09  RESERVE: zone 46 at (2552, 1304) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2552, 1304) facing 1 (id 46)
  0.09  RESERVE: zone 47 at (2552, 1256) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2552, 1256) facing 1 (id 47)
  0.09  RESERVE: zone 48 at (2552, 1208) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2552, 1208) facing 1 (id 48)
  0.09  RESERVE: served cortide at (2216, 1448) facing 1 (id 1, 47 of this def still held)
  0.27  RESERVE: zone 1 at (12952, 2424) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12952, 2424) facing 3 (id 1)
  0.27  RESERVE: zone 2 at (12952, 2472) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12952, 2472) facing 3 (id 2)
  0.27  RESERVE: zone 3 at (12952, 2520) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12952, 2520) facing 3 (id 3)
  0.27  RESERVE: zone 4 at (12952, 2568) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12952, 2568) facing 3 (id 4)
  0.27  RESERVE: zone 5 at (12952, 2616) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12952, 2616) facing 3 (id 5)
  0.27  RESERVE: zone 1 released
  0.27  RESERVE: zone 2 released
  0.27  RESERVE: zone 3 released
  0.27  RESERVE: zone 4 released
  0.27  RESERVE: zone 5 released
  0.27  RESERVE: zone 6 at (12920, 2376) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12920, 2376) facing 3 (id 6)
  0.27  RESERVE: zone 7 at (12920, 2424) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12920, 2424) facing 3 (id 7)
  0.27  RESERVE: zone 8 at (12920, 2472) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12920, 2472) facing 3 (id 8)
  0.27  RESERVE: zone 9 at (12920, 2520) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12920, 2520) facing 3 (id 9)
```
