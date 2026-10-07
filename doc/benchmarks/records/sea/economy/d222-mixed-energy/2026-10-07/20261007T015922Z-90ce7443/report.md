# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 25.1 min (frame 45099); wall 218 s
- DLL: build-theatres\d222\candidate3\SkirmishAI.dll (7b443ae28869953b); AI BARbTest/test; staged 2026-10-06T22:55:41
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test, 4=AIR/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: capacity-natural.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d222-mixed-energy\supreme\20261007T015540Z-b123f4ce\runs\20261007T015922Z-90ce7443\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `commander-assist` | seen at 1.0 min | `[t=00:00:52.055252][f=0001800] [SeaCapacity] PASS commander assists shipyard` |
| expect `mex-growth` | seen at 4.8 min | `[t=00:01:08.380220][f=0008700] [SeaCapacity] PASS six completed mexes` |
| expect `energy-growth` | seen at 7.6 min | `[t=00:01:21.639783][f=0013650] [SeaCapacity] PASS six completed tidals` |
| expect `support-growth` | seen at 17.0 min | `[t=00:02:22.620224][f=0030683] [SeaCapacity] PASS constructed support turret` |
| forbid `errors` | **hit** | `[INVARIANT] INV-008 3 turret(s) in range of the reclaim of armwin 22787 are not on it` |

## Failures

- forbid 'errors' hit at 13.2 min: [INVARIANT] INV-008 3 turret(s) in range of the reclaim of armwin 22787 are not on it
- forbid 'errors' hit at 14.2 min: [INVARIANT] INV-008 3 turret(s) in range of the reclaim of armwin 22787 are not on it
- forbid 'errors' hit at 15.2 min: [INVARIANT] INV-008 5 turret(s) in range of the reclaim of armwin 22787 are not on it
- forbid 'errors' hit at 16.0 min: [INVARIANT] INV-008 17 turret(s) in range of the reclaim of legalab 30757 are not on it
- forbid 'errors' hit at 16.1 min: [INVARIANT] INV-008 6 turret(s) in range of the reclaim of armalab 18069 are not on it
- forbid 'errors' hit at 23.5 min: [INVARIANT] INV-022 a new set of legadveconv starts 3 cell(s) from the turrets, not flush
- forbid 'errors' hit at 25.0 min: [INVARIANT] INV-022 a new set of legadveconv starts 4 cell(s) from the turrets, not flush

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d222-mixed-energy\supreme\20261007T015540Z-b123f4ce\runs\20261007T015922Z-90ce7443\screen_2026-10-07_01-56-54-752.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d222-mixed-energy\supreme\20261007T015540Z-b123f4ce\runs\20261007T015922Z-90ce7443\screen_2026-10-07_01-57-20-676.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d222-mixed-energy\supreme\20261007T015540Z-b123f4ce\runs\20261007T015922Z-90ce7443\screen_2026-10-07_01-58-31-042.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 25.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.00  [Playtest] frame 1 team 2 ally 0 side cortex ai true dead false start (2155, 11747) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 4 ally 1 side armada ai true dead false start (10129, 541) units 1
  0.00  [Playtest] frame 1 team 5 ally 1 side cortex ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 6 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 7 ally 3 side  ai false dead false start (0, 0) units 32
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (2155, 11747) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (11456, 1901) units 1
  0.05  [Playtest] frame 90 team 4 ally 1 side armada ai true dead false start (10129, 541) units 1
  0.05  [Playtest] frame 90 team 5 ally 1 side cortex ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 6 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 7 ally 3 side  ai false dead false start (0, 0) units 32
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|4775|11078|0|7|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(813,10380) factory=armlab landLocked=no spot=1 known=1/2
  0.10  [Team][Roster] Team 2 (AI 2): role=AIR side=cortex start=(2181,11797) factory=corap landLocked=no spot=2 known=2/2
  0.23  [SEA][Layout] berth sea.berth.0 armsy at=5840,10640 facing=1
  0.26  [Playtest] finished armmex team 0 at 0.26 min
  0.27  [Team][Roster] first mex 28755 at 4608,11072
  0.27  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4775|11078|0|7|1|4608|11072
  0.28  [Team][Roster] team 2 first mex at 2287,11967
  0.30  [Team][Roster] team 1 first mex at 752,10160
  0.48  [Playtest] finished armmex team 0 at 0.48 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 1044/1100, energy +30.0 bank 885/1000, units 4
  1.08  [SEA][Layout] berth sea.berth.1 armasy at=6320,9872 facing=2
  1.15  [SEA][Layout] berth sea.berth.2 armplat at=5888,10096 facing=2
  1.17  [SEA][Layout] berth sea.berth.3 armshltxuw at=7280,9872 facing=2
  1.25  [Playtest] finished armsy team 0 at 1.25 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +3.2 bank 803/1200, energy +37.0 bank 4/1150, units 6
  2.61  [Playtest] finished armmex team 0 at 2.61 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +4.3 bank 769/1250, energy +37.0 bank 0/1150, units 8
  3.29  [Playtest] finished armmex team 0 at 3.29 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +5.5 bank 681/1300, energy +44.0 bank 1/1200, units 12
  4.18  [Playtest] finished armmex team 0 at 4.18 min
  4.76  [Playtest] finished armmex team 0 at 4.76 min
  4.76  [Playtest] finished armtl team 0 at 4.76 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +15.8 bank 458/1400, energy +44.0 bank 467/1200, units 15
  5.00  [Playtest] camera requested (6200,11000) height=3800
  5.01  [Playtest] camera captured name=ta position=(6200,11000) height=3800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (6200, 11000)
  5.33  [Playtest] finished armtl team 0 at 5.33 min
  5.65  [Playtest] finished armtl team 0 at 5.65 min
  5.98  [Playtest] finished armtl team 0 at 5.98 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +8.9 bank 42/1400, energy +44.0 bank 0/1200, units 21
  6.34  [Playtest] finished armtide team 0 at 6.34 min
  6.67  [Playtest] finished armtide team 0 at 6.67 min
  6.69  [Playtest] finished armtide team 0 at 6.69 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +15.8 bank 0/1400, energy +107.0 bank 1333/1350, units 25
  7.10  [Playtest] finished armtide team 0 at 7.10 min
  7.19  [Playtest] finished armtide team 0 at 7.19 min
  7.54  [Playtest] finished armtide team 0 at 7.54 min
  7.78  [Playtest] finished armfrad team 0 at 7.78 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +15.8 bank 0/1400, energy +170.0 bank 1421/1500, units 29
  8.27  [Playtest] finished armfrad team 0 at 8.27 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +15.8 bank 0/1400, energy +170.0 bank 1471/1500, units 31
  9.08  [Playtest] finished armtide team 0 at 9.08 min
  9.53  [Playtest] finished armtide team 0 at 9.53 min
  9.84  [Playtest] finished armmex team 0 at 9.84 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +18.1 bank 0/1450, energy +226.0 bank 1670/1700, units 36
 10.00  [Playtest] camera requested (6200,11000) height=4200
 10.00  [Playtest] finished armtide team 0 at 10.00 min
 10.02  [Playtest] camera captured name=ta position=(6200,11000) height=4200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (6200, 11000)
 10.37  [Playtest] finished armtide team 0 at 10.37 min
 10.78  [Playtest] finished armtide team 0 at 10.77 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +18.1 bank 0/1450, energy +289.0 bank 1850/1850, units 41
 11.10  [Playtest] finished armmoho team 0 at 11.10 min
 11.22  [Playtest] finished armtide team 0 at 11.22 min
 11.27  [Playtest] finished armmex team 0 at 11.27 min
 11.79  [Playtest] finished armtl team 0 at 11.79 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +27.3 bank 25/2050, energy +310.0 bank 1878/1900, units 45
 12.47  [Playtest] finished armfrad team 0 at 12.47 min
 12.50  [Playtest] finished armmoho team 0 at 12.50 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +34.2 bank 258/2600, energy +310.0 bank 1840/1900, units 49
 13.01  [Playtest] finished armtl team 0 at 13.01 min
 13.10  [Playtest] finished armfrad team 0 at 13.10 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +34.2 bank 323/2600, energy +310.0 bank 1861/1900, units 52
 15.00  [Playtest] eco team 0 at 15.0 min: metal +34.2 bank 684/2600, energy +310.0 bank 1356/1900, units 56
 16.00  [Playtest] eco team 0 at 16.0 min: metal +34.2 bank 988/2600, energy +310.0 bank 1519/1900, units 61
 16.94  [Playtest] finished armmmkr team 0 at 16.94 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +34.2 bank 1778/2600, energy +310.0 bank 148/1900, units 62
 17.05  [Playtest] finished armnanotcplat team 0 at 17.05 min
 17.73  [Playtest] finished armnanotcplat team 0 at 17.73 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +34.2 bank 2029/2600, energy +310.0 bank 181/1900, units 65
 18.47  [Playtest] finished armnanotcplat team 0 at 18.47 min
 18.99  [Playtest] finished armnanotcplat team 0 at 18.99 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +38.1 bank 2157/2600, energy +310.0 bank 1405/1900, units 71
 20.00  [Playtest] eco team 0 at 20.0 min: metal +34.2 bank 304/2600, energy +310.0 bank 75/1900, units 79
 20.00  [Playtest] camera requested (6200,11000) height=4800
 20.02  [Playtest] camera captured name=ta position=(6200,11000) height=4800
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (6200, 11000)
 21.00  [Playtest] eco team 0 at 21.0 min: metal +34.2 bank 955/2600, energy +310.0 bank 146/1900, units 82
 21.23  [Playtest] finished armnanotcplat team 0 at 21.23 min
 21.84  [Playtest] finished armnanotcplat team 0 at 21.84 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +34.2 bank 1620/2600, energy +310.0 bank 152/1900, units 85
 22.23  [Playtest] finished armnanotcplat team 0 at 22.23 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +34.2 bank 1345/2600, energy +310.0 bank 109/1900, units 90
 23.40  [Playtest] finished armnanotcplat team 0 at 23.40 min
 23.52  [Playtest] finished armmmkr team 0 at 23.52 min
 23.78  [Playtest] finished armnanotcplat team 0 at 23.78 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +34.2 bank 1484/2600, energy +310.0 bank 1125/1900, units 93
 24.59  [Playtest] finished armnanotcplat team 0 at 24.58 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +34.2 bank 2567/2600, energy +310.0 bank 121/1900, units 100
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(27123) at (4776, 11079) walks to (4744, 11078), 136 from the armmex site (4608, 11072)
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 2
  0.08  RESERVE: zone 7 at (1619, 10568) facing 2, 77x63 cells: 4619 of 4851 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1619, 10072) facing 2: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1619, 10120) facing 2: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1619, 10168) facing 2: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1619, 10216) facing 2: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (1384, 9992) facing 2 (id 63)
  0.08  RESERVE: zone 8 at (1299, 9720) facing 2, 41x29 cells: 1163 of 1189 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1299, 9496) facing 2: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1299, 9544) facing 2: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1299, 9592) facing 2: 8 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1299, 9640) facing 2: 8 of 13 slots (group 6, held, zone)
  0.08  RESERVE: armlab at (1376, 8656) facing 2 (id 106)
  0.08  RESERVE: zone 9 at (1376, 8728) facing 2, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (1376, 8704) facing 2: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: armlab at (1472, 8368) facing 2 (id 109)
  0.08  RESERVE: zone 10 at (1472, 8440) facing 2, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (1472, 8416) facing 2: 2 of 2 slots (group 8, zone)
  0.08  RESERVE: corridor 11 at (1568, 8392) facing 2, 6x21 cells: 126 of 126 held
  0.08  RESERVE: corridor 12 at (1376, 8392) facing 2, 6x21 cells: 126 of 126 held
  0.08  RESERVE: zone 13 at (1472, 8392) facing 0, 6x9 cells: 0 of 54 held
  0.08  RESERVE: corridor 13 at (1472, 8144) facing 2, 10x20 cells: 180 of 200 held
  0.08  EXP: approach: armcom(891) at (814, 10380) walks to (789, 10291), 136 from the armmex site (752, 10160)
  0.09  EXP: approach: corcom(8444) at (2181, 11797) walks to (2214, 11850), 139 from the cormex site (2288, 11968)
  0.09  RESERVE: factory pair 'tech.factory.start' committed atomically facing 0
  0.09  RESERVE: zone 7 at (10765, 1720) facing 0, 77x63 cells: 4540 of 4851 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (10765, 2216) facing 0: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (10765, 2168) facing 0: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (10765, 2120) facing 0: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (10765, 2072) facing 0: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: legalab at (11000, 2296) facing 0 (id 63)
  0.09  RESERVE: zone 8 at (11085, 2568) facing 0, 41x29 cells: 1106 of 1189 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (11085, 2792) facing 0: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (11085, 2744) facing 0: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (11085, 2696) facing 0: 8 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (11085, 2648) facing 0: 8 of 13 slots (group 6, held, zone)
  0.09  RESERVE: leglab at (10912, 3632) facing 0 (id 106)
  0.09  RESERVE: zone 9 at (10912, 3560) facing 0, 6x3 cells: 18 of 18 held
  0.09  RESERVE: grid of legnanotc 2x1 gap 0 behind (10912, 3584) facing 0: 2 of 2 slots (group 7, zone)
  0.09  RESERVE: leglab at (10784, 3584) facing 0 (id 109)
  0.09  RESERVE: zone 10 at (10784, 3512) facing 0, 6x3 cells: 18 of 18 held
  0.09  RESERVE: grid of legnanotc 2x1 gap 0 behind (10784, 3536) facing 0: 2 of 2 slots (group 8, zone)
  0.09  RESERVE: leglab at (11024, 3664) facing 0 (id 112)
  0.09  RESERVE: zone 11 at (11024, 3592) facing 0, 6x3 cells: 18 of 18 held
  0.09  RESERVE: grid of legnanotc 2x1 gap 0 behind (11024, 3616) facing 0: 2 of 2 slots (group 9, zone)
  0.09  RESERVE: leglab at (11152, 3696) facing 0 (id 115)
  0.09  RESERVE: zone 12 at (11152, 3624) facing 0, 6x3 cells: 18 of 18 held
  0.09  RESERVE: grid of legnanotc 2x1 gap 0 behind (11152, 3648) facing 0: 2 of 2 slots (group 10, zone)
  0.09  RESERVE: leglab at (10816, 3920) facing 0 (id 118)
  0.09  RESERVE: zone 13 at (10816, 3848) facing 0, 6x3 cells: 18 of 18 held
  0.09  RESERVE: grid of legnanotc 2x1 gap 0 behind (10816, 3872) facing 0: 2 of 2 slots (group 11, zone)
  0.09  RESERVE: corridor 14 at (10912, 3896) facing 0, 6x21 cells: 126 of 126 held
  0.09  RESERVE: zone 15 at (10816, 3896) facing 0, 6x9 cells: 0 of 54 held
  0.09  RESERVE: corridor 15 at (10816, 4144) facing 0, 10x20 cells: 190 of 200 held
  0.09  EXP: approach: legcom(28578) at (11479, 1952) walks to (11503, 2016), 137 from the legmex site (11552, 2144)
  0.09  EXP: approach: armcom(19480) at (10103, 516) walks to (10075, 458), 136 from the armmex site (10016, 336)
  0.09  EXP: approach: corcom(7223) at (7536, 1222) walks to (7557, 1223), 139 from the cormex site (7696, 1232)
  0.17  RESERVE: armlab at (1712, 8432) facing 2 (id 112)
  0.17  RESERVE: zone 14 at (1712, 8504) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (1712, 8480) facing 2: 2 of 2 slots (group 9, zone)
  0.17  RESERVE: corridor 15 at (1808, 8456) facing 2, 6x21 cells: 126 of 126 held
  0.17  RESERVE: zone 16 at (1712, 8456) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 16 at (1712, 8208) facing 2, 10x20 cells: 190 of 200 held
  0.17  RESERVE: leglab at (10576, 3856) facing 0 (id 121)
  0.17  RESERVE: zone 16 at (10576, 3784) facing 0, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (10576, 3808) facing 0: 2 of 2 slots (group 12, zone)
  0.17  RESERVE: corridor 17 at (10672, 3832) facing 0, 6x21 cells: 126 of 126 held
  0.17  RESERVE: zone 18 at (10576, 3832) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 18 at (10576, 4080) facing 0, 10x20 cells: 190 of 200 held
  0.21  EXP: approach: corcom(7223) at (7544, 1222) walks to (7475, 1098), 139 from the cormex site (7408, 976)
  0.22  RESERVE: zone 1 at (6480, 1664) facing 3, 6x6 cells: 36 of 36 held
  0.22  RESERVE: corsy at (6480, 1664) facing 3 (id 1)
  0.22  RESERVE: corridor 2 at (6032, 1664) facing 3, 50x12 cells: 600 of 600 held
  0.22  RESERVE: zone 3 at (6584, 1672) facing 3, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (6584, 1672) facing 3 (id 2)
  0.22  RESERVE: zone 4 at (6488, 1576) facing 3, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (6488, 1576) facing 3 (id 3)
  0.22  RESERVE: zone 5 at (6488, 1768) facing 3, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (6488, 1768) facing 3 (id 4)
  0.22  RESERVE: zone 6 at (6584, 1624) facing 3, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (6584, 1624) facing 3 (id 5)
  0.22  RESERVE: zone 7 at (6584, 1720) facing 3, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (6584, 1720) facing 3 (id 6)
  0.22  RESERVE: zone 8 at (6536, 1576) facing 3, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (6536, 1576) facing 3 (id 7)
  0.22  RESERVE: zone 9 at (6536, 1768) facing 3, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (6536, 1768) facing 3 (id 8)
  0.22  RESERVE: zone 10 at (6584, 1576) facing 3, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (6584, 1576) facing 3 (id 9)
  0.22  RESERVE: zone 11 at (6584, 1768) facing 3, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (6584, 1768) facing 3 (id 10)
  0.22  RESERVE: zone 12 at (6632, 1672) facing 3, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (6632, 1672) facing 3 (id 11)
  0.22  RESERVE: zone 13 at (6488, 1528) facing 3, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (6488, 1528) facing 3 (id 12)
  0.22  RESERVE: zone 14 at (6488, 1816) facing 3, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (6488, 1816) facing 3 (id 13)
  0.22  RESERVE: zone 15 at (6632, 1624) facing 3, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (6632, 1624) facing 3 (id 14)
  0.22  RESERVE: zone 16 at (6632, 1720) facing 3, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (6632, 1720) facing 3 (id 15)
  0.22  RESERVE: zone 17 at (6536, 1816) facing 3, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (6536, 1816) facing 3 (id 16)
  0.22  RESERVE: zone 18 at (6440, 1528) facing 3, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (6440, 1528) facing 3 (id 17)
  0.22  RESERVE: zone 19 at (6440, 1816) facing 3, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (6440, 1816) facing 3 (id 18)
  0.22  RESERVE: zone 20 at (6632, 1576) facing 3, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (6632, 1576) facing 3 (id 19)
  0.22  RESERVE: zone 21 at (6632, 1768) facing 3, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (6632, 1768) facing 3 (id 20)
  0.22  RESERVE: zone 22 at (6584, 1816) facing 3, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (6584, 1816) facing 3 (id 21)
  0.22  RESERVE: zone 23 at (6488, 1480) facing 3, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (6488, 1480) facing 3 (id 22)
  0.22  RESERVE: zone 24 at (6488, 1864) facing 3, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (6488, 1864) facing 3 (id 23)
  0.22  RESERVE: zone 25 at (6536, 1864) facing 3, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (6536, 1864) facing 3 (id 24)
```
