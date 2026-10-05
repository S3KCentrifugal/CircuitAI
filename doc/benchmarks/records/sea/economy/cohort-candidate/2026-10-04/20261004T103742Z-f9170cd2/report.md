# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.1 min (frame 54115); wall 539 s
- DLL: build-theatres\d189-build-5\SkirmishAI.dll (1b875078bc2aa763); AI BARbTest/test; staged 2026-10-04T07:28:41
- Map: Serene Caldera v1.3; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=SEA/cortex/test, 9=SEA/legion/test, 10=SEA/armada/test, 11=SEA/cortex/test, 12=SEA/legion/test, 13=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\caldera\20261004T102840Z-dd3361c2\runs\20261004T103742Z-f9170cd2\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:41.934762][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.1 min | `[t=00:01:07.828354][f=0001911] [SeaWatch] finished frame=1911 id=18277 def=armsy builder=30071` |
| expect `first-ship-exit` | seen at 3.0 min | `[t=00:01:19.285794][f=0005340] [SeaWatch] egress id=7925 yard=18277 seconds=10.9 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\caldera\20261004T102840Z-dd3361c2\runs\20261004T103742Z-f9170cd2\screen_2026-10-04_10-30-20-403.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\caldera\20261004T102840Z-dd3361c2\runs\20261004T103742Z-f9170cd2\screen_2026-10-04_10-31-13-130.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\caldera\20261004T102840Z-dd3361c2\runs\20261004T103742Z-f9170cd2\screen_2026-10-04_10-33-56-014.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\caldera\20261004T102840Z-dd3361c2\runs\20261004T103742Z-f9170cd2\screen_2026-10-04_10-37-17-121.png

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
  0.00  [Playtest] frame 1 team 15 ally 3 side  ai false dead false start (0, 0) units 107
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
  0.05  [Playtest] frame 90 team 15 ally 3 side  ai false dead false start (0, 0) units 107
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|2836|2905|0|0|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(4500,1597) factory=armhp landLocked=no spot=1 known=1/6
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(6626,998) factory=corhp landLocked=no spot=2 known=2/6
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(8000,2900) factory=corhp landLocked=no spot=3 known=3/6
  0.10  [Team][Roster] Team 4 (AI 4): role=SEA side=armada start=(10084,3171) factory=armsy landLocked=no spot=5 known=4/6
  0.10  [Team][Roster] Team 5 (AI 5): role=SEA side=cortex start=(11030,1625) factory=corsy landLocked=no spot=6 known=5/6
  0.10  [Team][Roster] Team 6 (AI 6): role=SEA side=legion start=(12803,2748) factory=legsy landLocked=no spot=7 known=6/6
  0.18  [Team][Roster] team 1 first mex at 4480,1536
  0.20  [Team][Roster] team 6 first mex at 12800,2912
  0.22  [Team][Roster] team 3 first mex at 7936,3040
  0.22  [Team][Roster] team 5 first mex at 10976,1584
  0.23  [SEA][Layout] berth sea.berth.0 armsy at=2352,2912 facing=2
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.28  [Team][Roster] team 2 first mex at 6688,960
  0.29  [Team][Roster] team 4 first mex at 10080,2976
  0.30  [Team][Roster] first mex 26509 at 3008,2912
  0.30  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|2836|2905|0|0|1|3008|2912
  0.45  [SEA][Layout] berth sea.berth.1 armasy at=2688,2144 facing=1
  0.58  [Playtest] finished armmex team 0 at 0.58 min
  0.82  [SEA][Layout] berth sea.berth.2 armasy at=2640,1904 facing=1
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.9 bank 802/1100, energy +30.0 bank 521/1000, units 4
  1.06  [Playtest] finished armsy team 0 at 1.06 min
  1.53  [Playtest] finished armmex team 0 at 1.53 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +9.3 bank 964/1250, energy +30.0 bank 120/1100, units 6
  2.71  [Playtest] finished armmex team 0 at 2.71 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +9.1 bank 1172/1300, energy +37.0 bank 0/1150, units 9
  3.54  [Playtest] finished armtide team 0 at 3.54 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +11.4 bank 1197/1300, energy +142.0 bank 1229/1250, units 12
  4.05  [Playtest] finished armmex team 0 at 4.05 min
  4.14  [Playtest] finished armllt team 0 at 4.14 min
  4.23  [Playtest] finished armtide team 0 at 4.23 min
  4.55  [Playtest] finished armtide team 0 at 4.55 min
  4.65  [Playtest] finished armmex team 0 at 4.65 min
  4.87  [Playtest] finished armtide team 0 at 4.87 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +15.5 bank 1238/1400, energy +136.0 bank 1286/1400, units 20
  5.00  [Playtest] target team 0 at (2800, 2900) from its start position
  5.00  [Playtest] camera requested (2800,2900) height=2200
  5.00  [Playtest] finished armmex team 0 at 5.00 min
  5.01  [Playtest] camera captured name=ta position=(2800,2900) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (2800, 2900)
  5.18  [Playtest] finished armtide team 0 at 5.18 min
  5.19  [Playtest] finished armmex team 0 at 5.19 min
  5.29  [Playtest] finished armmex team 0 at 5.29 min
  5.59  [Playtest] finished armtide team 0 at 5.59 min
  5.63  [Playtest] finished armmex team 0 at 5.63 min
  5.70  [Playtest] finished armfrad team 0 at 5.70 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +24.8 bank 1517/1600, energy +189.0 bank 1535/1550, units 27
  6.24  [Playtest] finished armmex team 0 at 6.24 min
  6.40  [Playtest] finished armtl team 0 at 6.40 min
  6.78  [Playtest] finished armllt team 0 at 6.78 min
  6.87  [Playtest] finished armtl team 0 at 6.87 min
  6.95  [Playtest] finished armtide team 0 at 6.95 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +27.3 bank 1372/1650, energy +212.0 bank 1583/1600, units 33
  7.05  [Playtest] finished armtl team 0 at 7.05 min
  7.29  [Playtest] finished armtide team 0 at 7.29 min
  7.30  [Playtest] finished armmex team 0 at 7.30 min
  7.43  [Playtest] finished armfrad team 0 at 7.43 min
  7.61  [Playtest] finished armtide team 0 at 7.61 min
  7.71  [Playtest] finished armtl team 0 at 7.70 min
  7.75  [Playtest] finished armtide team 0 at 7.75 min
  7.78  [Playtest] finished armmex team 0 at 7.78 min
  7.92  [Playtest] finished armtide team 0 at 7.92 min
  7.96  [Playtest] finished armtide team 0 at 7.96 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +31.4 bank 1444/1750, energy +334.0 bank 1897/1900, units 44
  8.36  [Playtest] finished armfrad team 0 at 8.36 min
  8.52  [Playtest] finished armtide team 0 at 8.52 min
  8.69  [Playtest] finished armnanotcplat team 0 at 8.69 min
  8.94  [Playtest] finished armtide team 0 at 8.94 min
  8.99  [Playtest] finished armtide team 0 at 8.99 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +31.4 bank 1607/1750, energy +387.0 bank 2090/2100, units 53
  9.03  [Playtest] finished armmex team 0 at 9.03 min
  9.08  [Playtest] finished armtl team 0 at 9.08 min
  9.15  [Playtest] finished armmex team 0 at 9.15 min
  9.29  [Playtest] finished armtide team 0 at 9.29 min
  9.33  [Playtest] finished armtide team 0 at 9.33 min
  9.41  [Playtest] finished armllt team 0 at 9.41 min
  9.45  [Playtest] finished armtide team 0 at 9.45 min
  9.53  [Playtest] finished armfrad team 0 at 9.53 min
  9.62  [Playtest] finished armtide team 0 at 9.62 min
  9.63  [Playtest] finished armtide team 0 at 9.63 min
  9.67  [Playtest] finished armtide team 0 at 9.67 min
  9.84  [Playtest] finished armtide team 0 at 9.84 min
  9.86  [Playtest] finished armtide team 0 at 9.86 min
  9.95  [Playtest] finished armtide team 0 at 9.95 min
  9.96  [Playtest] finished armtl team 0 at 9.96 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +35.9 bank 1188/1850, energy +624.0 bank 2591/2600, units 68
 10.00  [Playtest] camera requested (2800,2900) height=2200
 10.02  [Playtest] camera captured name=ta position=(2800,2900) height=2200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (2800, 2900)
 10.04  [Playtest] finished armfmkr team 0 at 10.04 min
 10.24  [Playtest] finished armfmkr team 0 at 10.24 min
 10.34  [Playtest] finished armtide team 0 at 10.34 min
 10.41  [Playtest] finished armtide team 0 at 10.41 min
 10.47  [Playtest] finished armfmkr team 0 at 10.47 min
 10.52  [Playtest] finished armtide team 0 at 10.52 min
 10.54  [Playtest] finished armtl team 0 at 10.54 min
 10.61  [Playtest] finished armtide team 0 at 10.61 min
 10.62  [Playtest] finished armtl team 0 at 10.62 min
 10.64  [Playtest] finished armfmkr team 0 at 10.64 min
 10.72  [Playtest] finished armtide team 0 at 10.72 min
 10.73  [Playtest] finished armfmkr team 0 at 10.73 min
 10.80  [Playtest] finished armtide team 0 at 10.80 min
 10.90  [Playtest] finished armfmkr team 0 at 10.90 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +41.9 bank 1507/1850, energy +762.0 bank 2718/2900, units 84
 11.08  [Playtest] finished armnanotcplat team 0 at 11.08 min
 11.21  [Playtest] finished armnanotcplat team 0 at 11.21 min
 11.31  [Playtest] finished armnanotcplat team 0 at 11.31 min
 11.46  [Playtest] finished armtide team 0 at 11.46 min
 11.67  [Playtest] finished armtl team 0 at 11.67 min
 11.88  [Playtest] finished armtide team 0 at 11.88 min
 11.93  [Playtest] finished armtide team 0 at 11.93 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +41.9 bank 1510/1850, energy +831.0 bank 2707/3050, units 96
 12.20  [Playtest] finished armtide team 0 at 12.20 min
 12.25  [Playtest] finished armtide team 0 at 12.25 min
 12.41  [Playtest] finished armtl team 0 at 12.41 min
 12.66  [Playtest] finished armtl team 0 at 12.66 min
 12.73  [Playtest] finished armtide team 0 at 12.73 min
 12.96  [Playtest] finished armtide team 0 at 12.96 min
 12.99  [Playtest] finished armtide team 0 at 12.99 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +41.9 bank 1667/1850, energy +916.0 bank 3199/3250, units 100
 13.14  [Playtest] finished armtide team 0 at 13.14 min
 13.22  [Playtest] finished armtide team 0 at 13.22 min
 13.24  [Playtest] finished armtide team 0 at 13.24 min
 13.40  [Playtest] finished armtide team 0 at 13.40 min
 13.43  [Playtest] finished armtide team 0 at 13.43 min
 13.75  [Playtest] finished armfmkr team 0 at 13.75 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +42.9 bank 848/1850, energy +1054.0 bank 3215/3500, units 104
 14.53  [Playtest] finished armtl team 0 at 14.53 min
 14.81  [Playtest] finished armfrad team 0 at 14.81 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +42.9 bank 84/1850, energy +1054.0 bank 3428/3500, units 111
 15.05  [Playtest] finished armtl team 0 at 15.05 min
 15.63  [Playtest] finished armasy team 0 at 15.63 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +42.9 bank 19/2050, energy +1054.0 bank 3578/3700, units 114
 16.28  [Playtest] finished armfmkr team 0 at 16.28 min
 16.30  [Playtest] finished armtide team 0 at 16.30 min
 16.52  [Playtest] finished armfmkr team 0 at 16.52 min
 16.59  [Playtest] finished armfmkr team 0 at 16.59 min
 16.66  [Playtest] finished armtide team 0 at 16.66 min
 16.83  [Playtest] finished armfmkr team 0 at 16.83 min
 16.88  [Playtest] finished armtide team 0 at 16.88 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +42.9 bank 42/2050, energy +1161.0 bank 3237/4100, units 124
 17.28  [Playtest] finished armtide team 0 at 17.28 min
 17.41  [Playtest] finished armuwmme team 0 at 17.41 min
 17.73  [Playtest] finished armtide team 0 at 17.73 min
 17.88  [Playtest] finished armllt team 0 at 17.88 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +53.1 bank 24/2600, energy +1522.0 bank 5467/5700, units 123
 18.23  [Playtest] finished armuwmme team 0 at 18.23 min
 18.54  [Playtest] finished armmex team 0 at 18.53 min
 18.76  [Playtest] finished armuwmme team 0 at 18.76 min
 18.91  [Playtest] finished armfmkr team 0 at 18.91 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +66.4 bank 5/3700, energy +1508.0 bank 5099/5600, units 121
 19.05  [Playtest] finished armrad team 0 at 19.05 min
 19.45  [Playtest] finished armmship team 0 at 19.45 min
 19.55  [Playtest] finished armuwmme team 0 at 19.55 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +70.4 bank 51/4250, energy +1508.0 bank 4467/5600, units 120
 20.00  [Playtest] camera requested (2800,2900) height=2200
 20.02  [Playtest] camera captured name=ta position=(2800,2900) height=2200
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (2800, 2900)
 20.02  [Playtest] finished armuwmme team 0 at 20.02 min
 20.76  [Playtest] finished armuwmme team 0 at 20.76 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +82.6 bank 62/5350, energy +1501.0 bank 4394/5550, units 120
 21.11  [Playtest] finished armuwmme team 0 at 21.11 min
 21.56  [Playtest] finished armbats team 0 at 21.56 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +79.1 bank 57/5900, energy +1215.0 bank 3037/4150, units 122
 22.19  [Playtest] finished armatl team 0 at 22.19 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +83.3 bank 70/5900, energy +1485.0 bank 4345/5500, units 127
 23.08  [Playtest] finished armtl team 0 at 23.08 min
 23.61  [Playtest] finished armtl team 0 at 23.61 min
 23.76  [Playtest] finished armmex team 0 at 23.76 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +89.9 bank 147/5950, energy +1515.0 bank 4828/5650, units 129
 24.41  [Playtest] finished armtl team 0 at 24.41 min
 24.82  [Playtest] finished armtl team 0 at 24.82 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +86.1 bank 69/5900, energy +1208.0 bank 3244/4100, units 123
 25.96  [Playtest] finished armbats team 0 at 25.96 min
 25.96  [Playtest] finished armnanotcplat team 0 at 25.96 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +78.0 bank 59/5300, energy +1208.0 bank 3225/4100, units 124
 27.00  [Playtest] eco team 0 at 27.0 min: metal +72.6 bank 52/4700, energy +1508.0 bank 4497/5600, units 111
 28.00  [Playtest] eco team 0 at 28.0 min: metal +62.6 bank 43/4050, energy +1501.0 bank 4547/5550, units 102
 28.44  [Playtest] finished armbats team 0 at 28.44 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +62.8 bank 44/4050, energy +1508.0 bank 4545/5600, units 105
 29.00  [Playtest] camera requested (2800,2900) height=2200
 29.02  [Playtest] camera captured name=ta position=(2800,2900) height=2200
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (2800, 2900)
 29.23  [Playtest] finished armuwfus team 0 at 29.23 min
 29.31  [Playtest] finished armtl team 0 at 29.31 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +62.0 bank 39/3550, energy +2701.0 bank 7610/7700, units 106
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(30071) at (2836, 2906) walks to (2872, 2907), 136 from the armmex site (3008, 2912)
  0.09  EXP: approach: legcom(28578) at (8000, 2900) walks to (7993, 2915), 137 from the legmex site (7936, 3040)
  0.09  EXP: approach: armcom(19480) at (10084, 3172) walks to (10083, 3112), 136 from the armmex site (10080, 2976)
  0.09  EXP: approach: legcom(3424) at (12803, 2749) walks to (12803, 2775), 137 from the legmex site (12800, 2912)
  0.09  EXP: approach: armcom(27123) at (2798, 12604) walks to (2775, 12632), 136 from the armmex site (2688, 12736)
  0.09  EXP: approach: corcom(22737) at (4457, 13822) walks to (4287, 13897), 139 from the cormex site (4160, 13952)
  0.09  EXP: approach: legcom(24526) at (7960, 13019) walks to (7761, 13090), 137 from the legmex site (7632, 13136)
  0.09  EXP: approach: corcom(5679) at (10073, 12977) walks to (9926, 12728), 139 from the cormex site (9856, 12608)
  0.09  EXP: approach: armcom(16913) at (12744, 12493) walks to (12674, 12472), 136 from the armmex site (12544, 12432)
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
  0.11  EXP: idle: legcom(28578) on legmex at (7996, 2908), site (7936, 3040), target yes, fails 2 (arrived at the approach point)
  0.12  EXP: idle: armcom(27123) on armmex at (2783, 12622), site (2688, 12736), target yes, fails 2 (arrived at the approach point)
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
  0.19  EXP: approach: armcom(891) at (4500, 1597) walks to (4584, 1870), 136 from the armmex site (4624, 2000)
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
