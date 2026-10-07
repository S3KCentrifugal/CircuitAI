# Playtest report: PASS

- Verdict: **PASS** (reached 20 min)
- Game time reached: 20.0 min (frame 36004); wall 143 s
- DLL: build-theatres\d222\candidate3\SkirmishAI.dll (7b443ae28869953b); AI BARbTest/test; staged 2026-10-06T22:32:48
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: capacity-natural.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d222-priority\glacial\20261007T013247Z-b91e497c\runs\20261007T013514Z-8453461e\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `commander-assist` | seen at 2.2 min | `[t=00:00:54.864352][f=0004050] [SeaCapacity] PASS commander assists shipyard` |
| expect `mex-growth` | seen at 7.8 min | `[t=00:01:18.564219][f=0014100] [SeaCapacity] PASS six completed mexes` |
| expect `energy-growth` | seen at 5.4 min | `[t=00:01:08.585438][f=0009750] [SeaCapacity] PASS six completed tidals` |
| expect `support-growth` | seen at 16.9 min | `[t=00:02:02.820198][f=0030464] [SeaCapacity] PASS constructed support turret` |
| forbid `errors` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d222-priority\glacial\20261007T013247Z-b91e497c\runs\20261007T013514Z-8453461e\screen_2026-10-07_01-33-58-530.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d222-priority\glacial\20261007T013247Z-b91e497c\runs\20261007T013514Z-8453461e\screen_2026-10-07_01-34-20-517.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d222-priority\glacial\20261007T013247Z-b91e497c\runs\20261007T013514Z-8453461e\screen_2026-10-07_01-35-13-143.png

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
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(700,4597) factory=armsy landLocked=no spot=5 known=1/2
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(1899,5801) factory=corsy landLocked=no spot=6 known=2/2
  0.15  [Team][Roster] team 1 first mex at 704,4448
  0.15  [Playtest] finished armmex team 0 at 0.15 min
  0.17  [Team][Roster] first mex 10685 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.17  [Team][Roster] team 2 first mex at 1904,5967
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.7 bank 1096/1100, energy +30.0 bank 944/1000, units 5
  1.29  [Playtest] finished armtl team 0 at 1.29 min
  1.96  [Playtest] finished armtide team 0 at 1.96 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.0 bank 1071/1100, energy +53.0 bank 1018/1050, units 6
  2.18  [Playtest] finished armtide team 0 at 2.18 min
  2.50  [Playtest] finished armsy team 0 at 2.49 min
  2.58  [SEA][Layout] berth sea.berth.0 armasy at=3440,4000 facing=1
  2.77  [SEA][Layout] berth sea.berth.1 armplat at=4384,3984 facing=1
  2.83  [SEA][Layout] berth sea.berth.2 armshltxuw at=3728,4960 facing=1
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.0 bank 580/1200, energy +83.0 bank 3/1250, units 9
  3.95  [Playtest] finished armtide team 0 at 3.95 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +6.0 bank 194/1200, energy +113.0 bank 100/1350, units 13
  4.27  [Playtest] finished armtide team 0 at 4.27 min
  4.57  [Playtest] finished armmex team 0 at 4.57 min
  4.86  [Playtest] finished armtide team 0 at 4.86 min
  4.94  [Playtest] finished armmex team 0 at 4.94 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +10.0 bank 0/1300, energy +159.0 bank 1437/1450, units 18
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.01  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.39  [Playtest] finished armtide team 0 at 5.39 min
  5.79  [Playtest] finished armtide team 0 at 5.79 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +10.0 bank 0/1300, energy +205.0 bank 1550/1550, units 21
  6.05  [Playtest] finished armtide team 0 at 6.05 min
  6.34  [Playtest] finished armtide team 0 at 6.34 min
  6.59  [Playtest] finished armtide team 0 at 6.59 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +10.0 bank 9/1300, energy +274.0 bank 1683/1700, units 23
  7.43  [Playtest] finished armmex team 0 at 7.43 min
  7.80  [Playtest] finished armmex team 0 at 7.80 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +14.0 bank 0/1400, energy +274.0 bank 1688/1700, units 27
  8.14  [Playtest] finished armfrt team 0 at 8.14 min
  8.15  [Playtest] finished armtide team 0 at 8.15 min
  8.48  [Playtest] finished armtide team 0 at 8.48 min
  8.83  [Playtest] finished armtide team 0 at 8.83 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +14.0 bank 0/1400, energy +343.0 bank 1845/1850, units 33
  9.09  [Playtest] finished armmex team 0 at 9.09 min
  9.33  [Playtest] finished armtide team 0 at 9.33 min
  9.44  [Playtest] finished armmex team 0 at 9.44 min
  9.80  [Playtest] finished armfrt team 0 at 9.80 min
  9.83  [Playtest] finished armtide team 0 at 9.83 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +18.0 bank 7/1500, energy +389.0 bank 1942/1950, units 35
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.01  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.16  [Playtest] finished armtide team 0 at 10.16 min
 10.50  [Playtest] finished armtide team 0 at 10.50 min
 10.87  [Playtest] finished armtide team 0 at 10.87 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +18.0 bank 16/1500, energy +458.0 bank 2093/2100, units 38
 11.84  [Playtest] finished armtl team 0 at 11.84 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +18.0 bank 17/1500, energy +458.0 bank 2090/2100, units 40
 13.00  [Playtest] eco team 0 at 13.0 min: metal +18.0 bank 16/1500, energy +458.0 bank 2087/2100, units 41
 14.00  [Playtest] eco team 0 at 14.0 min: metal +19.0 bank 6/1500, energy +458.0 bank 2064/2100, units 42
 15.00  [Playtest] eco team 0 at 15.0 min: metal +18.0 bank 15/1500, energy +458.0 bank 2083/2100, units 41
 16.00  [Playtest] eco team 0 at 16.0 min: metal +50.5 bank 186/1500, energy +465.0 bank 2074/2150, units 47
 16.17  [Playtest] finished armtide team 0 at 16.17 min
 16.28  [Playtest] finished armtide team 0 at 16.28 min
 16.59  [Playtest] finished armfhlt team 0 at 16.59 min
 16.92  [Playtest] finished armnanotcplat team 0 at 16.92 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +66.8 bank 587/1500, energy +525.0 bank 2269/2350, units 52
 17.16  [Playtest] finished armnanotcplat team 0 at 17.16 min
 17.58  [Playtest] finished armfrad team 0 at 17.58 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +18.0 bank 11/1500, energy +525.0 bank 2331/2350, units 52
 18.27  [Playtest] finished armnanotcplat team 0 at 18.27 min
 18.28  [Playtest] finished armfmkr team 0 at 18.28 min
 18.79  [Playtest] finished armtl team 0 at 18.79 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +19.0 bank 4/1500, energy +525.0 bank 2298/2350, units 58
 19.23  [Playtest] finished armtl team 0 at 19.23 min
 19.23  [Playtest] finished armtl team 0 at 19.23 min
 19.33  [Playtest] finished armfrad team 0 at 19.33 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +19.0 bank 14/1500, energy +525.0 bank 2271/2350, units 61
 20.00  [Playtest] camera requested (1700,4550) height=3800
```

## Native lines (all AIs, first 120)

```
  0.28  RESERVE: zone 1 at (152, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (152, 4808) facing 1 (id 1)
  0.28  RESERVE: zone 2 at (152, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (152, 4760) facing 1 (id 2)
  0.28  RESERVE: zone 3 at (152, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (152, 4712) facing 1 (id 3)
  0.28  RESERVE: zone 4 at (152, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (152, 4664) facing 1 (id 4)
  0.28  RESERVE: zone 5 at (152, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (152, 4616) facing 1 (id 5)
  0.28  RESERVE: zone 6 at (152, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (152, 4568) facing 1 (id 6)
  0.28  RESERVE: zone 7 at (200, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (200, 4808) facing 1 (id 7)
  0.28  RESERVE: zone 8 at (200, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (200, 4760) facing 1 (id 8)
  0.28  RESERVE: zone 9 at (200, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (200, 4712) facing 1 (id 9)
  0.28  RESERVE: zone 10 at (200, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (200, 4664) facing 1 (id 10)
  0.28  RESERVE: zone 11 at (200, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (200, 4616) facing 1 (id 11)
  0.28  RESERVE: zone 12 at (200, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (200, 4568) facing 1 (id 12)
  0.28  RESERVE: zone 13 at (248, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (248, 4808) facing 1 (id 13)
  0.28  RESERVE: zone 14 at (248, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (248, 4760) facing 1 (id 14)
  0.28  RESERVE: zone 15 at (248, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (248, 4712) facing 1 (id 15)
  0.28  RESERVE: zone 16 at (248, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (248, 4664) facing 1 (id 16)
  0.28  RESERVE: zone 17 at (248, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (248, 4616) facing 1 (id 17)
  0.28  RESERVE: zone 18 at (248, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (248, 4568) facing 1 (id 18)
  0.28  RESERVE: zone 19 at (296, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (296, 4808) facing 1 (id 19)
  0.28  RESERVE: zone 20 at (296, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (296, 4760) facing 1 (id 20)
  0.28  RESERVE: zone 21 at (296, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (296, 4712) facing 1 (id 21)
  0.28  RESERVE: zone 22 at (296, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (296, 4664) facing 1 (id 22)
  0.28  RESERVE: zone 23 at (296, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (296, 4616) facing 1 (id 23)
  0.28  RESERVE: zone 24 at (296, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (296, 4568) facing 1 (id 24)
  0.28  RESERVE: zone 25 at (344, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (344, 4808) facing 1 (id 25)
  0.28  RESERVE: zone 26 at (344, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (344, 4760) facing 1 (id 26)
  0.28  RESERVE: zone 27 at (344, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (344, 4712) facing 1 (id 27)
  0.28  RESERVE: zone 28 at (344, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (344, 4664) facing 1 (id 28)
  0.28  RESERVE: zone 29 at (344, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (344, 4616) facing 1 (id 29)
  0.28  RESERVE: zone 30 at (344, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (344, 4568) facing 1 (id 30)
  0.28  RESERVE: zone 31 at (392, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (392, 4808) facing 1 (id 31)
  0.28  RESERVE: zone 32 at (392, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (392, 4760) facing 1 (id 32)
  0.28  RESERVE: zone 33 at (392, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (392, 4712) facing 1 (id 33)
  0.28  RESERVE: zone 34 at (392, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (392, 4664) facing 1 (id 34)
  0.28  RESERVE: zone 35 at (392, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (392, 4616) facing 1 (id 35)
  0.28  RESERVE: zone 36 at (392, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (392, 4568) facing 1 (id 36)
  0.28  RESERVE: zone 37 at (440, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (440, 4808) facing 1 (id 37)
  0.28  RESERVE: zone 38 at (440, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (440, 4760) facing 1 (id 38)
  0.28  RESERVE: zone 39 at (440, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (440, 4712) facing 1 (id 39)
  0.28  RESERVE: zone 40 at (440, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (440, 4664) facing 1 (id 40)
  0.28  RESERVE: zone 41 at (440, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (440, 4616) facing 1 (id 41)
  0.28  RESERVE: zone 42 at (440, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (440, 4568) facing 1 (id 42)
  0.28  RESERVE: zone 43 at (488, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (488, 4808) facing 1 (id 43)
  0.28  RESERVE: zone 44 at (488, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (488, 4760) facing 1 (id 44)
  0.28  RESERVE: zone 45 at (488, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (488, 4712) facing 1 (id 45)
  0.28  RESERVE: zone 46 at (488, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (488, 4664) facing 1 (id 46)
  0.28  RESERVE: zone 47 at (488, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (488, 4616) facing 1 (id 47)
  0.28  RESERVE: zone 48 at (488, 4568) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (488, 4568) facing 1 (id 48)
  0.28  RESERVE: served armtide at (152, 4808) facing 1 (id 1, 47 of this def still held)
  0.29  RESERVE: zone 1 at (872, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (872, 4200) facing 1 (id 1)
  0.29  RESERVE: zone 2 at (872, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (872, 4152) facing 1 (id 2)
  0.29  RESERVE: zone 3 at (872, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (872, 4104) facing 1 (id 3)
  0.29  RESERVE: zone 4 at (872, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (872, 4056) facing 1 (id 4)
  0.29  RESERVE: zone 5 at (872, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (872, 4008) facing 1 (id 5)
  0.29  RESERVE: zone 6 at (872, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (872, 3960) facing 1 (id 6)
  0.29  RESERVE: zone 7 at (920, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (920, 4200) facing 1 (id 7)
  0.29  RESERVE: zone 8 at (920, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (920, 4152) facing 1 (id 8)
  0.29  RESERVE: zone 9 at (920, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (920, 4104) facing 1 (id 9)
  0.29  RESERVE: zone 10 at (920, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (920, 4056) facing 1 (id 10)
  0.29  RESERVE: zone 11 at (920, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (920, 4008) facing 1 (id 11)
  0.29  RESERVE: zone 12 at (920, 3960) facing 1, 3x3 cells: 9 of 9 held
```
