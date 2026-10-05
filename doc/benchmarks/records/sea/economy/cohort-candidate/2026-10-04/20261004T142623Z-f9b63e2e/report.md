# Playtest report: PASS

- Verdict: **PASS** (reached 20 min)
- Game time reached: 20.0 min (frame 36003); wall 156 s
- DLL: build-theatres\d190-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T11:23:44
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\glacial\20261004T142344Z-3d73153d\runs\20261004T142623Z-f9b63e2e\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:32.522479][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.7 min | `[t=00:00:45.235497][f=0001313] [SeaWatch] finished frame=1313 id=3157 def=armsy builder=27123` |
| expect `first-ship-exit` | seen at 2.9 min | `[t=00:00:54.052016][f=0005280] [SeaWatch] egress id=28689 yard=3157 seconds=4.3 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\glacial\20261004T142344Z-3d73153d\runs\20261004T142623Z-f9b63e2e\screen_2026-10-04_14-24-51-332.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\glacial\20261004T142344Z-3d73153d\runs\20261004T142623Z-f9b63e2e\screen_2026-10-04_14-25-13-673.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 20.5 min
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
  0.10  [SEA][Layout] berth sea.berth.0 armsy at=1424,4000 facing=1
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(700,4597) factory=armsy landLocked=no spot=5 known=1/2
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(1899,5801) factory=corsy landLocked=no spot=6 known=2/2
  0.12  [SEA][Layout] berth sea.berth.1 armasy at=1424,3600 facing=1
  0.15  [Team][Roster] team 1 first mex at 704,4448
  0.15  [Playtest] finished armmex team 0 at 0.15 min
  0.17  [SEA][Layout] berth sea.berth.2 armasy at=1424,3296 facing=3
  0.17  [Team][Roster] first mex 10685 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.18  [Team][Roster] team 2 first mex at 1904,5967
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.73  [Playtest] finished armsy team 0 at 0.73 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 711/1200, energy +30.0 bank 59/1100, units 5
  1.21  [Playtest] finished armtide team 0 at 1.21 min
  1.43  [Playtest] finished armmex team 0 at 1.43 min
  1.61  [Playtest] finished armtide team 0 at 1.61 min
  1.93  [Playtest] finished armmex team 0 at 1.93 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +10.0 bank 725/1300, energy +76.0 bank 176/1200, units 9
  2.23  [Playtest] finished armtide team 0 at 2.23 min
  2.37  [Playtest] finished armtide team 0 at 2.37 min
  2.44  [Playtest] finished armtide team 0 at 2.44 min
  2.51  [Playtest] finished armtide team 0 at 2.51 min
  2.95  [Playtest] finished armtide team 0 at 2.95 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 460/1300, energy +205.0 bank 887/1550, units 20
  3.10  [Playtest] finished armtl team 0 at 3.10 min
  3.25  [Playtest] finished armtide team 0 at 3.25 min
  3.30  [Playtest] finished armnanotcplat team 0 at 3.30 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 0/1300, energy +228.0 bank 1600/1600, units 23
  4.11  [Playtest] finished armtl team 0 at 4.11 min
  4.37  [Playtest] finished armrad team 0 at 4.37 min
  4.58  [Playtest] finished armfmkr team 0 at 4.58 min
  4.79  [Playtest] finished armllt team 0 at 4.78 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +11.0 bank 0/1300, energy +228.0 bank 1557/1600, units 27
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.00  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.11  [Playtest] finished armtide team 0 at 5.11 min
  5.45  [Playtest] finished armfmkr team 0 at 5.45 min
  5.53  [Playtest] finished armtide team 0 at 5.53 min
  5.77  [Playtest] finished armfmkr team 0 at 5.77 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +12.7 bank 19/1300, energy +274.0 bank 1422/1700, units 31
  6.03  [Playtest] finished armtide team 0 at 6.03 min
  6.41  [Playtest] finished armtide team 0 at 6.41 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +13.0 bank 0/1300, energy +320.0 bank 1708/1800, units 36
  7.28  [Playtest] finished armtide team 0 at 7.28 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +13.0 bank 11/1300, energy +343.0 bank 1747/1850, units 38
  9.00  [Playtest] eco team 0 at 9.0 min: metal +13.0 bank 11/1300, energy +343.0 bank 1755/1850, units 36
 10.00  [Playtest] eco team 0 at 10.0 min: metal +13.0 bank 11/1300, energy +343.0 bank 1755/1850, units 34
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.02  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.49  [Playtest] finished armtide team 0 at 10.49 min
 10.83  [Playtest] finished armtide team 0 at 10.83 min
 10.87  [Playtest] finished armfmkr team 0 at 10.86 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +14.0 bank 10/1300, energy +389.0 bank 1580/1950, units 38
 12.00  [Playtest] eco team 0 at 12.0 min: metal +13.3 bank 11/1300, energy +389.0 bank 1576/1950, units 36
 12.26  [Playtest] finished armtide team 0 at 12.26 min
 12.62  [Playtest] finished armtl team 0 at 12.62 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +14.0 bank 10/1300, energy +412.0 bank 1889/2000, units 40
 13.70  [Playtest] finished armtide team 0 at 13.70 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +14.0 bank 0/1300, energy +435.0 bank 1976/2050, units 40
 14.00  [Playtest] finished armtide team 0 at 14.00 min
 14.58  [Playtest] finished armtl team 0 at 14.58 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +14.0 bank 10/1300, energy +458.0 bank 1966/2100, units 40
 15.29  [Playtest] finished armfmkr team 0 at 15.29 min
 15.66  [Playtest] finished armtide team 0 at 15.66 min
 15.90  [Playtest] finished armtide team 0 at 15.90 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +15.0 bank 94/1300, energy +504.0 bank 2002/2200, units 44
 16.23  [Playtest] finished armfmkr team 0 at 16.23 min
 16.28  [Playtest] finished armtide team 0 at 16.28 min
 16.82  [Playtest] finished armnanotcplat team 0 at 16.82 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +15.6 bank 197/1300, energy +527.0 bank 1851/2200, units 44
 17.05  [Playtest] finished armmex team 0 at 17.05 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +13.3 bank 643/1300, energy +451.0 bank 1598/2050, units 39
 18.71  [Playtest] finished armmex team 0 at 18.71 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +14.0 bank 994/1150, energy +444.0 bank 1785/1900, units 32
 20.00  [Playtest] eco team 0 at 20.0 min: metal +8.0 bank 1134/1150, energy +168.0 bank 1278/1300, units 14
 20.00  [Playtest] camera requested (1700,4550) height=3800
```

## Native lines (all AIs, first 120)

```
  0.09  EXP: approach: corcom(8444) at (1899, 5801) walks to (1900, 5829), 139 from the cormex site (1904, 5968)
  0.10  RESERVE: zone 1 at (1424, 4000) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (1424, 4000) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (1712, 4000) facing 1, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (1208, 4280) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1208, 4280) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (1208, 4232) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1208, 4232) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (1208, 4184) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1208, 4184) facing 1 (id 4)
  0.10  RESERVE: zone 6 at (1208, 4136) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1208, 4136) facing 1 (id 5)
  0.10  RESERVE: zone 7 at (1208, 4088) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1208, 4088) facing 1 (id 6)
  0.10  RESERVE: zone 8 at (1256, 4280) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1256, 4280) facing 1 (id 7)
  0.10  RESERVE: zone 9 at (1256, 4232) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1256, 4232) facing 1 (id 8)
  0.10  RESERVE: zone 10 at (1256, 4184) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1256, 4184) facing 1 (id 9)
  0.10  RESERVE: zone 11 at (1256, 4136) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1256, 4136) facing 1 (id 10)
  0.10  RESERVE: zone 12 at (1256, 4088) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1256, 4088) facing 1 (id 11)
  0.10  RESERVE: zone 13 at (1304, 4280) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1304, 4280) facing 1 (id 12)
  0.10  RESERVE: zone 14 at (1304, 4232) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1304, 4232) facing 1 (id 13)
  0.10  RESERVE: zone 15 at (1304, 4184) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1304, 4184) facing 1 (id 14)
  0.10  RESERVE: zone 16 at (1304, 4136) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1304, 4136) facing 1 (id 15)
  0.10  RESERVE: zone 17 at (1304, 4088) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1304, 4088) facing 1 (id 16)
  0.10  RESERVE: zone 18 at (1352, 4280) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 4280) facing 1 (id 17)
  0.10  RESERVE: zone 19 at (1352, 4232) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 4232) facing 1 (id 18)
  0.10  RESERVE: zone 20 at (1352, 4184) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 4184) facing 1 (id 19)
  0.10  RESERVE: zone 21 at (1352, 4136) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 4136) facing 1 (id 20)
  0.10  RESERVE: zone 22 at (1352, 4088) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 4088) facing 1 (id 21)
  0.10  RESERVE: zone 1 at (704, 4592) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (704, 4592) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (992, 4592) facing 1, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (488, 4872) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4872) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (488, 4824) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4824) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (488, 4776) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4776) facing 1 (id 4)
  0.10  RESERVE: zone 6 at (488, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4728) facing 1 (id 5)
  0.10  RESERVE: zone 7 at (488, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4680) facing 1 (id 6)
  0.10  RESERVE: zone 8 at (536, 4872) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (536, 4872) facing 1 (id 7)
  0.10  RESERVE: zone 9 at (536, 4824) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (536, 4824) facing 1 (id 8)
  0.10  RESERVE: zone 10 at (536, 4776) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (536, 4776) facing 1 (id 9)
  0.10  RESERVE: zone 11 at (536, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (536, 4728) facing 1 (id 10)
  0.10  RESERVE: zone 12 at (536, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (536, 4680) facing 1 (id 11)
  0.10  RESERVE: zone 13 at (584, 4872) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (584, 4872) facing 1 (id 12)
  0.10  RESERVE: zone 14 at (584, 4824) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (584, 4824) facing 1 (id 13)
  0.10  RESERVE: zone 15 at (584, 4776) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (584, 4776) facing 1 (id 14)
  0.10  RESERVE: zone 16 at (584, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (584, 4728) facing 1 (id 15)
  0.10  RESERVE: zone 17 at (584, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (584, 4680) facing 1 (id 16)
  0.10  RESERVE: zone 18 at (632, 4872) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (632, 4872) facing 1 (id 17)
  0.10  RESERVE: zone 19 at (632, 4824) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (632, 4824) facing 1 (id 18)
  0.10  RESERVE: zone 20 at (632, 4776) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (632, 4776) facing 1 (id 19)
  0.10  RESERVE: zone 21 at (632, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (632, 4728) facing 1 (id 20)
  0.10  RESERVE: zone 22 at (632, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (632, 4680) facing 1 (id 21)
  0.10  RESERVE: zone 1 at (12928, 4000) facing 3, 6x6 cells: 36 of 36 held
  0.10  RESERVE: legsy at (12928, 4000) facing 3 (id 1)
  0.10  RESERVE: corridor 2 at (12640, 4000) facing 3, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (13304, 4088) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (13304, 4088) facing 3 (id 2)
  0.10  RESERVE: zone 4 at (13304, 4136) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (13304, 4136) facing 3 (id 3)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 at (13224, 4104) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (13224, 4104) facing 3 (id 4)
  0.10  RESERVE: zone 6 at (13224, 4152) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (13224, 4152) facing 3 (id 5)
  0.10  RESERVE: zone 7 at (13224, 4200) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (13224, 4200) facing 3 (id 6)
  0.10  RESERVE: zone 8 at (13224, 4248) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (13224, 4248) facing 3 (id 7)
  0.10  RESERVE: zone 5 released
  0.10  RESERVE: zone 6 released
  0.10  RESERVE: zone 7 released
  0.10  RESERVE: zone 8 released
  0.10  RESERVE: zone 9 at (13144, 4088) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (13144, 4088) facing 3 (id 8)
  0.10  RESERVE: zone 10 at (13144, 4136) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (13144, 4136) facing 3 (id 9)
  0.10  RESERVE: zone 11 at (13144, 4184) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (13144, 4184) facing 3 (id 10)
  0.10  RESERVE: zone 12 at (13144, 4232) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (13144, 4232) facing 3 (id 11)
  0.10  RESERVE: zone 13 at (13144, 4280) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (13144, 4280) facing 3 (id 12)
  0.10  RESERVE: zone 14 at (13096, 4088) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (13096, 4088) facing 3 (id 13)
```
