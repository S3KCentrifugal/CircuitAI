# Playtest report: PASS

- Verdict: **PASS** (reached 10 min)
- Game time reached: 10.0 min (frame 18000); wall 89 s
- DLL: build-theatres\d191-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T14:01:20
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-workers\supreme\20261004T170120Z-99bd75d1\runs\20261004T170252Z-89504213\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:37.008238][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.5 min | `[t=00:00:51.487201][f=0002615] [SeaWatch] finished frame=2615 id=28410 def=armsy builder=28578` |
| expect `first-ship-exit` | seen at 2.9 min | `[t=00:00:57.336731][f=0005190] [SeaWatch] egress id=6328 yard=28410 seconds=4.8 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-workers\supreme\20261004T170120Z-99bd75d1\runs\20261004T170252Z-89504213\screen_2026-10-04_17-02-30-829.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-workers\supreme\20261004T170120Z-99bd75d1\runs\20261004T170252Z-89504213\screen_2026-10-04_17-02-51-826.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 10.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.19  [Playtest] finished armmex team 0 at 0.19 min
  0.20  [Team][Roster] first mex 6887 at 4608,11072
  0.20  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4775|11078|0|7|1|4608|11072
  0.61  [Playtest] finished armwin team 0 at 0.61 min
  0.72  [Playtest] finished armwin team 0 at 0.72 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.3 bank 1050/1050, energy +68.0 bank 1001/1001, units 4
  1.45  [Playtest] finished armsy team 0 at 1.45 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +4.3 bank 600/1150, energy +60.4 bank 138/1151, units 7
  2.56  [Playtest] finished armtide team 0 at 2.56 min
  2.88  [Playtest] finished armtide team 0 at 2.88 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +4.3 bank 208/1150, energy +117.0 bank 1117/1301, units 12
  3.19  [Playtest] finished armtide team 0 at 3.19 min
  3.62  [Playtest] finished armtide team 0 at 3.62 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +4.3 bank 12/1150, energy +165.7 bank 1399/1401, units 16
  4.20  [Playtest] finished armtide team 0 at 4.20 min
  4.85  [Playtest] finished armtide team 0 at 4.85 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +4.3 bank 13/1150, energy +174.4 bank 1501/1501, units 18
  5.00  [Playtest] target team 0 at (4814, 11077) from its start position
  5.00  [Playtest] camera requested (4814,11077) height=2200
  5.00  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (4814, 11077)
  5.74  [Playtest] finished armtide team 0 at 5.74 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +4.3 bank 12/1150, energy +228.0 bank 1550/1551, units 21
  6.27  [Playtest] finished armtide team 0 at 6.27 min
  6.89  [Playtest] finished armtide team 0 at 6.89 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +4.3 bank 12/1150, energy +270.7 bank 1645/1651, units 22
  8.00  [Playtest] eco team 0 at 8.0 min: metal +4.3 bank 13/1150, energy +271.0 bank 1641/1651, units 25
  8.39  [Playtest] finished armfmkr team 0 at 8.39 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +5.3 bank 13/1150, energy +271.0 bank 1606/1651, units 28
  9.36  [Playtest] finished armfmkr team 0 at 9.36 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +6.3 bank 12/1150, energy +271.0 bank 1575/1651, units 30
 10.00  [Playtest] camera requested (4814,11077) height=2200
```

## Native lines (all AIs, first 120)

```
  1.47  RESERVE: zone 1 at (5768, 10872) facing 2, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (5768, 10872) facing 2 (id 1)
  1.47  RESERVE: zone 1 released
  1.47  RESERVE: corridor 2 at (5808, 10416) facing 2, 12x30 cells: 232 of 360 held
  1.47  RESERVE: zone 3 at (5808, 11152) facing 2, 40x40 cells: 1600 of 1600 held
  1.47  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (5808, 11056) facing 2: 6 of 16 slots (group 1, held, zone)
  1.47  RESERVE: zone 3 released
  1.47  RESERVE: zone 4 at (5680, 11152) facing 2, 40x40 cells: 1600 of 1600 held
  1.47  RESERVE: zone 4 released
  1.47  RESERVE: zone 5 at (5936, 11152) facing 2, 40x40 cells: 1600 of 1600 held
  1.47  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (5936, 11056) facing 2: 14 of 16 slots (group 3, held, zone)
  1.47  RESERVE: zone 5 released
  1.47  RESERVE: zone 6 at (6064, 11152) facing 2, 40x40 cells: 1600 of 1600 held
  1.47  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6064, 11056) facing 2: 16 of 16 slots (group 4, held, zone)
  1.47  RESERVE: armuwfus at (6144, 11280) facing 2 (id 38)
  1.47  RESERVE: packed armuwfus at (6144, 11280) facing 2 in zone 6, 313 from a turret (id 38, group 0, 1040 candidates)
  1.47  RESERVE: zone 1 at (6488, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6488, 1544) facing 0 (id 1)
  1.47  RESERVE: zone 2 at (6536, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6536, 1544) facing 0 (id 2)
  1.47  RESERVE: zone 3 at (6584, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6584, 1544) facing 0 (id 3)
  1.47  RESERVE: zone 4 at (6632, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6632, 1544) facing 0 (id 4)
  1.47  RESERVE: zone 1 released
  1.47  RESERVE: zone 2 released
  1.47  RESERVE: zone 3 released
  1.47  RESERVE: zone 4 released
  1.47  RESERVE: zone 5 at (6424, 1560) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6424, 1560) facing 0 (id 5)
  1.47  RESERVE: zone 6 at (6472, 1560) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6472, 1560) facing 0 (id 6)
  1.47  RESERVE: zone 7 at (6520, 1560) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6520, 1560) facing 0 (id 7)
  1.47  RESERVE: zone 8 at (6568, 1560) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6568, 1560) facing 0 (id 8)
  1.47  RESERVE: zone 9 at (6616, 1560) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6616, 1560) facing 0 (id 9)
  1.47  RESERVE: zone 5 released
  1.47  RESERVE: zone 6 released
  1.47  RESERVE: zone 7 released
  1.47  RESERVE: zone 8 released
  1.47  RESERVE: zone 9 released
  1.47  RESERVE: zone 10 at (6344, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6344, 1544) facing 0 (id 10)
  1.47  RESERVE: zone 11 at (6392, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6392, 1544) facing 0 (id 11)
  1.47  RESERVE: zone 12 at (6440, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6440, 1544) facing 0 (id 12)
  1.47  RESERVE: zone 13 at (6488, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6488, 1544) facing 0 (id 13)
  1.47  RESERVE: zone 14 at (6536, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6536, 1544) facing 0 (id 14)
  1.47  RESERVE: zone 15 at (6344, 1592) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6344, 1592) facing 0 (id 15)
  1.47  RESERVE: zone 10 released
  1.47  RESERVE: zone 11 released
  1.47  RESERVE: zone 12 released
  1.47  RESERVE: zone 13 released
  1.47  RESERVE: zone 14 released
  1.47  RESERVE: zone 15 released
  1.47  RESERVE: zone 16 at (6280, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6280, 1496) facing 0 (id 16)
  1.47  RESERVE: zone 17 at (6328, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6328, 1496) facing 0 (id 17)
  1.47  RESERVE: zone 18 at (6376, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6376, 1496) facing 0 (id 18)
  1.47  RESERVE: zone 19 at (6424, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6424, 1496) facing 0 (id 19)
  1.47  RESERVE: zone 20 at (6472, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6472, 1496) facing 0 (id 20)
  1.47  RESERVE: zone 21 at (6280, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6280, 1544) facing 0 (id 21)
  1.47  RESERVE: zone 22 at (6328, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6328, 1544) facing 0 (id 22)
  1.47  RESERVE: zone 23 at (6376, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6376, 1544) facing 0 (id 23)
  1.47  RESERVE: zone 24 at (6424, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6424, 1544) facing 0 (id 24)
  1.47  RESERVE: zone 25 at (6472, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6472, 1544) facing 0 (id 25)
  1.47  RESERVE: zone 26 at (6280, 1592) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6280, 1592) facing 0 (id 26)
  1.47  RESERVE: zone 27 at (6328, 1592) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6328, 1592) facing 0 (id 27)
  1.47  RESERVE: zone 16 released
  1.47  RESERVE: zone 17 released
  1.47  RESERVE: zone 18 released
  1.47  RESERVE: zone 19 released
  1.47  RESERVE: zone 20 released
  1.47  RESERVE: zone 21 released
  1.47  RESERVE: zone 22 released
  1.47  RESERVE: zone 23 released
  1.47  RESERVE: zone 24 released
  1.47  RESERVE: zone 25 released
  1.47  RESERVE: zone 26 released
  1.47  RESERVE: zone 27 released
  1.47  RESERVE: zone 28 at (6232, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6232, 1448) facing 0 (id 28)
  1.47  RESERVE: zone 29 at (6280, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6280, 1448) facing 0 (id 29)
  1.47  RESERVE: zone 30 at (6328, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6328, 1448) facing 0 (id 30)
  1.47  RESERVE: zone 31 at (6376, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6376, 1448) facing 0 (id 31)
  1.47  RESERVE: zone 32 at (6424, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6424, 1448) facing 0 (id 32)
  1.47  RESERVE: zone 33 at (6232, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6232, 1496) facing 0 (id 33)
  1.47  RESERVE: zone 34 at (6280, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6280, 1496) facing 0 (id 34)
  1.47  RESERVE: zone 35 at (6328, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6328, 1496) facing 0 (id 35)
  1.47  RESERVE: zone 36 at (6376, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6376, 1496) facing 0 (id 36)
  1.47  RESERVE: zone 37 at (6424, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6424, 1496) facing 0 (id 37)
  1.47  RESERVE: zone 38 at (6232, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.47  RESERVE: armnanotcplat at (6232, 1544) facing 0 (id 38)
  1.47  RESERVE: zone 39 at (6280, 1544) facing 0, 3x3 cells: 9 of 9 held
```
