# Playtest report: PASS

- Verdict: **PASS** (reached 8 min)
- Game time reached: 8.6 min (frame 15480); wall 1 s
- DLL: build-theatres\d216-final\SkirmishAI.dll (45eb0f2e89a285e3); AI BARbTest/test; staged 2026-10-06T10:46:53
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=TECH/armada/test, 1=FRONT/armada/test, 2=AIR/cortex/test, 3=FRONT/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=TACTICAL/armada/test, 8=FRONT/cortex/test, 9=TECH/legion/test, 10=FRONT/armada/test, 11=AIR/cortex/test, 12=SEA/legion/test, 13=SEA/armada/test, 14=SEA/cortex/test, 15=TACTICAL/legion/test
- Team 0 (under test): skirmish AI 0, role TECH
- Checks: recovery-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\economy\recovery-walk-lua\glacial\20261006T134652Z-6d9a6516\runs\20261006T134950Z-fad54bf4\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `delayed-lab` | seen at 1.5 min | `[t=00:00:54.273327][f=0002700] [RecoveryFixture] frame=2700 delayed TECH lab supplied` |
| expect `front` | seen at 3.2 min | `[t=00:01:03.588295][f=0005700] [RecoveryFixture] frame=5700 recovered team=1 role=FRONT id=20765 x=901 z=1172` |
| expect `air` | seen at 2.0 min | `[t=00:00:56.777772][f=0003600] [RecoveryFixture] frame=3600 recovered team=2 role=AIR id=14204 x=900 z=1181` |
| expect `support-self` | seen at 2.3 min | `[t=00:00:59.421753][f=0004200] [RecoveryFixture] frame=4200 recovered team=3 role=SUPPORT id=21015 x=963 z=1168` |
| expect `sea` | seen at 3.5 min | `[t=00:01:05.254762][f=0006300] [RecoveryFixture] frame=6300 recovered team=4 role=SEA id=6436 x=956 z=1191` |
| expect `tactical` | seen at 3.8 min | `[t=00:01:06.921879][f=0006900] [RecoveryFixture] frame=6900 recovered team=5 role=TACTICAL id=13475 x=900 z=1159` |
| expect `tech` | seen at 2.7 min | `[t=00:01:01.099728][f=0004800] [RecoveryFixture] frame=4800 recovered team=6 role=TECH id=31107 x=900 z=1193` |
| expect `support-donation` | seen at 2.2 min | `[t=00:00:59.008236][f=0004050] [RecoveryFixture] frame=4050 given team=3 id=21015 def=legck x=901 z=1162` |
| expect `lua-relay` | seen at 0.5 min | `[Recovery] channel=lua verb=request target=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `healthy-team` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\economy\recovery-walk-lua\glacial\20261006T134652Z-6d9a6516\runs\20261006T134950Z-fad54bf4\screen_2026-10-06_13-47-59-210.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\economy\recovery-walk-lua\glacial\20261006T134652Z-6d9a6516\runs\20261006T134950Z-fad54bf4\screen_2026-10-06_13-48-10-191.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\economy\recovery-walk-lua\glacial\20261006T134652Z-6d9a6516\runs\20261006T134950Z-fad54bf4\screen_2026-10-06_13-48-26-174.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role TECH, team 0, speed 12, 3 shots, end at 8.60000038 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (490, 1140) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (1800, 1400) units 1
  0.00  [Playtest] frame 1 team 2 ally 0 side cortex ai true dead false start (430, 2300) units 1
  0.00  [Playtest] frame 1 team 3 ally 0 side legion ai true dead false start (1800, 2550) units 1
  0.00  [Playtest] frame 1 team 4 ally 0 side armada ai true dead false start (1430, 4000) units 1
  0.00  [Playtest] frame 1 team 5 ally 0 side cortex ai true dead false start (700, 4600) units 1
  0.00  [Playtest] frame 1 team 6 ally 0 side legion ai true dead false start (1900, 5800) units 1
  0.00  [Playtest] frame 1 team 7 ally 0 side armada ai true dead false start (880, 6850) units 1
  0.00  [Playtest] frame 1 team 8 ally 1 side cortex ai true dead false start (12572, 1400) units 1
  0.00  [Playtest] frame 1 team 9 ally 1 side legion ai true dead false start (14000, 1100) units 1
  0.00  [Playtest] frame 1 team 10 ally 1 side armada ai true dead false start (12640, 2500) units 1
  0.00  [Playtest] frame 1 team 11 ally 1 side cortex ai true dead false start (13890, 2246) units 1
  0.00  [Playtest] frame 1 team 12 ally 1 side legion ai true dead false start (12925, 4000) units 1
  0.00  [Playtest] frame 1 team 13 ally 1 side armada ai true dead false start (13700, 4600) units 1
  0.00  [Playtest] frame 1 team 14 ally 1 side cortex ai true dead false start (12618, 5800) units 1
  0.00  [Playtest] frame 1 team 15 ally 1 side legion ai true dead false start (13454, 6850) units 1
  0.00  [Playtest] frame 1 team 16 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 17 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 12
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (490, 1140) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (1800, 1400) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (430, 2300) units 1
  0.05  [Playtest] frame 90 team 3 ally 0 side legion ai true dead false start (1800, 2550) units 1
  0.05  [Playtest] frame 90 team 4 ally 0 side armada ai true dead false start (1430, 4000) units 1
  0.05  [Playtest] frame 90 team 5 ally 0 side cortex ai true dead false start (700, 4600) units 1
  0.05  [Playtest] frame 90 team 6 ally 0 side legion ai true dead false start (1900, 5800) units 1
  0.05  [Playtest] frame 90 team 7 ally 0 side armada ai true dead false start (880, 6850) units 1
  0.05  [Playtest] frame 90 team 8 ally 1 side cortex ai true dead false start (12572, 1400) units 1
  0.05  [Playtest] frame 90 team 9 ally 1 side legion ai true dead false start (14000, 1100) units 1
  0.05  [Playtest] frame 90 team 10 ally 1 side armada ai true dead false start (12640, 2500) units 1
  0.05  [Playtest] frame 90 team 11 ally 1 side cortex ai true dead false start (13890, 2246) units 1
  0.05  [Playtest] frame 90 team 12 ally 1 side legion ai true dead false start (12925, 4000) units 1
  0.05  [Playtest] frame 90 team 13 ally 1 side armada ai true dead false start (13700, 4600) units 1
  0.05  [Playtest] frame 90 team 14 ally 1 side cortex ai true dead false start (12618, 5800) units 1
  0.05  [Playtest] frame 90 team 15 ally 1 side legion ai true dead false start (13454, 6850) units 1
  0.05  [Playtest] frame 90 team 16 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 17 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [Layout] on for this AI
  0.08  [TECH][Opening] mexes within 700 elmos first (nearest 3); start factory held up to 240 s
  0.08  [TECH][Build] experimental build system on: direct range 1600, search radius 512
  0.08  [TECH][Opening] complete after 0 mexes, 0 s: the rush chain owns the opening; the lab is next
  0.08  [Layout] on for this AI
  0.08  [Layout] native factory pair committed facing 1, side offset 12 cells, forward offset 8 cells
  0.08  [Layout] home centre (442, 1128), 48 from the start
  0.08  [Layout] turret box 40x44 cells at (570, 1512), from the start rear -8, side -24, ground 99%, halo 71%: zone 7, 4 rows, 52 of 52 turret slots
  0.08  [Layout] advanced lab on the front line at (994, 1272) facing 1, 0 cells ahead of turret row 0
  0.08  [Layout] the front is (7168, 910): the labs face 1 (lane (7168, 910), the pair faces 1)
  0.08  [Layout] advanced lab faces 1 (the pair faces 1)
  0.08  [Layout] advanced lab's footprint reserved at (1000, 1272), 575 from the home centre, 22 turret slots within reach, 7 flush (D-095)
  0.08  [Layout] forward cluster 40x44 cells at (1402, 1832), 8 cells ahead of the main cluster, ground 99%: zone 8, 4 rows, 50 turret slots
  0.10  [Team][Roster] Announced: roster|1|0|0|TECH|armada|armlab|490|1137|0|0|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=FRONT side=armada start=(1800,1397) factory=armvp landLocked=no spot=1 known=1/7
  0.10  [Team][Roster] Team 2 (AI 2): role=AIR side=cortex start=(429,2301) factory=corap landLocked=no spot=2 known=2/7
  0.10  [Team][Roster] Team 3 (AI 3): role=FRONT side=legion start=(1800,2550) factory=leglab landLocked=no spot=3 known=3/7
  0.10  [Team][Roster] Team 4 (AI 4): role=SEA side=armada start=(1430,3997) factory=armsy landLocked=no spot=4 known=4/7
  0.10  [Team][Roster] Team 5 (AI 5): role=SEA side=cortex start=(699,4601) factory=corsy landLocked=no spot=5 known=5/7
  0.10  [Team][Roster] Team 6 (AI 6): role=SEA side=legion start=(1900,5800) factory=legsy landLocked=no spot=6 known=6/7
  0.10  [Team][Roster] Team 7 (AI 7): role=TACTICAL side=armada start=(880,6847) factory=armhp landLocked=no spot=7 known=7/7
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armmmkr team 0 at 0.17 min
  0.17  [Playtest] finished armmstor team 0 at 0.17 min
  0.17  [Playtest] finished armestor team 0 at 0.17 min
  0.38  [Ferry] requested a transport (TECH at +20 metal, no transport)
  1.00  [Playtest] eco team 0 at 1.0 min: metal +12.3 bank 2336/4000, energy +3037.0 bank 15750/16050, units 6
  1.50  [Playtest] finished leglab team 0 at 1.50 min
  1.50  [TECH][Build] first lab's exit held (zone 27) until it is reclaimed
  2.00  [Playtest] eco team 0 at 2.0 min: metal +12.3 bank 4099/4100, energy +3037.0 bank 15835/16150, units 8
  2.00  [Playtest] camera requested (800,1400) height=2800
  2.00  [Playtest] camera captured name=ta position=(800,1400) height=2800
  2.00  [Playtest] screenshot at 2.0 min of team 0 at (800, 1400)
  3.00  [Playtest] eco team 0 at 3.0 min: metal +12.3 bank 4099/4100, energy +3037.0 bank 15835/16150, units 8
  4.00  [Playtest] eco team 0 at 4.0 min: metal +12.3 bank 4100/4100, energy +3037.0 bank 15850/16150, units 7
  4.00  [Playtest] camera requested (1000,1800) height=3500
  4.00  [Playtest] camera captured name=ta position=(1000,1800) height=3500
  4.00  [Playtest] screenshot at 4.0 min of team 0 at (1000, 1800)
  5.00  [Playtest] eco team 0 at 5.0 min: metal +12.3 bank 4100/4100, energy +3037.0 bank 15850/16150, units 7
  6.00  [Playtest] eco team 0 at 6.0 min: metal +12.3 bank 4100/4100, energy +3037.0 bank 15850/16150, units 7
  7.00  [Playtest] eco team 0 at 7.0 min: metal +12.3 bank 4100/4100, energy +3037.0 bank 15850/16150, units 7
  7.00  [Playtest] camera requested (1000,3000) height=4000
  7.00  [Playtest] camera captured name=ta position=(1000,3000) height=4000
  7.00  [Playtest] screenshot at 7.0 min of team 0 at (1000, 3000)
  8.00  [Playtest] eco team 0 at 8.0 min: metal +12.3 bank 4100/4100, energy +3037.0 bank 15850/16150, units 7
  8.60  [Playtest] end at 8.6 min: quitting
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 1
  0.08  RESERVE: zone 7 at (427, 1512) facing 1, 58x77 cells: 3799 of 4466 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (923, 1512) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (875, 1512) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (827, 1512) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (779, 1512) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (1000, 1272) facing 1 (id 63)
  0.08  RESERVE: zone 8 at (1403, 1832) facing 1, 45x41 cells: 1841 of 1845 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1755, 1832) facing 1: 11 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1707, 1832) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1659, 1832) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1611, 1832) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: armlab at (1792, 1088) facing 1 (id 114)
  0.08  RESERVE: zone 9 at (1720, 1088) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (1744, 1088) facing 1: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: corridor 10 at (1768, 1184) facing 1, 21x6 cells: 122 of 126 held
  0.08  RESERVE: zone 11 at (1768, 1088) facing 0, 9x6 cells: 0 of 54 held
  0.08  RESERVE: corridor 11 at (2016, 1088) facing 1, 20x10 cells: 190 of 200 held
  0.09  RESERVE: factory pair 'tech.factory.start' committed atomically facing 0
  0.09  RESERVE: zone 7 at (13509, 984) facing 0, 77x63 cells: 4553 of 4851 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (13509, 1480) facing 0: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (13509, 1432) facing 0: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (13509, 1384) facing 0: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (13509, 1336) facing 0: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: legalab at (13496, 1176) facing 3 (id 63)
  0.09  RESERVE: packed legalab at (13496, 1176) facing 3 in zone 7 where 8 slots of group 5 reach (id 63)
  0.09  RESERVE: zone 8 at (13189, 1960) facing 0, 41x45 cells: 1845 of 1845 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (13189, 2312) facing 0: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (13189, 2264) facing 0: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (13189, 2216) facing 0: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (13189, 2168) facing 0: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: leglab at (12544, 1088) facing 3 (id 116)
  0.09  RESERVE: zone 9 at (12616, 1088) facing 3, 3x6 cells: 18 of 18 held
  0.09  RESERVE: grid of legnanotc 2x1 gap 0 behind (12592, 1088) facing 3: 2 of 2 slots (group 7, zone)
  0.09  RESERVE: corridor 10 at (12568, 992) facing 3, 21x6 cells: 126 of 126 held
  0.09  RESERVE: corridor 11 at (12568, 1184) facing 3, 21x6 cells: 122 of 126 held
  0.09  RESERVE: zone 12 at (12568, 1088) facing 0, 9x6 cells: 0 of 54 held
  0.09  RESERVE: corridor 12 at (12320, 1088) facing 3, 20x10 cells: 180 of 200 held
  0.17  RESERVE: armlab at (976, 704) facing 2 (id 117)
  0.17  RESERVE: zone 12 at (976, 776) facing 2, 6x3 cells: 6 of 18 held
  0.17  RESERVE: armlab at (1088, 656) facing 2 (id 118)
  0.17  RESERVE: zone 13 at (1088, 728) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (1088, 704) facing 2: 2 of 2 slots (group 9, zone)
  0.17  RESERVE: armlab at (480, 832) facing 2 (id 121)
  0.17  RESERVE: zone 14 at (480, 904) facing 2, 6x3 cells: 6 of 18 held
  0.17  RESERVE: armlab at (720, 736) facing 2 (id 122)
  0.17  RESERVE: zone 15 at (720, 808) facing 2, 6x3 cells: 6 of 18 held
  0.17  RESERVE: armlab at (832, 704) facing 2 (id 123)
  0.17  RESERVE: zone 16 at (832, 776) facing 2, 6x3 cells: 6 of 18 held
  0.17  RESERVE: armlab at (960, 656) facing 2 (id 124)
  0.17  RESERVE: zone 17 at (960, 728) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (960, 704) facing 2: 2 of 2 slots (group 13, zone)
  0.17  RESERVE: armlab at (464, 784) facing 2 (id 127)
  0.17  RESERVE: zone 18 at (464, 856) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (464, 832) facing 2: 2 of 2 slots (group 14, zone)
  0.17  RESERVE: armlab at (576, 736) facing 2 (id 130)
  0.17  RESERVE: zone 19 at (576, 808) facing 2, 6x3 cells: 6 of 18 held
  0.17  RESERVE: armlab at (704, 704) facing 2 (id 131)
  0.17  RESERVE: zone 20 at (704, 776) facing 2, 6x3 cells: 13 of 18 held
  0.17  RESERVE: armlab at (816, 656) facing 2 (id 132)
  0.17  RESERVE: zone 21 at (816, 728) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (816, 704) facing 2: 2 of 2 slots (group 17, zone)
  0.17  RESERVE: armlab at (800, 608) facing 2 (id 135)
  0.17  RESERVE: zone 22 at (800, 680) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (800, 656) facing 2: 2 of 2 slots (group 18, zone)
  0.17  RESERVE: armalab at (1192, 616) facing 2 (id 138)
  0.17  RESERVE: zone 23 at (1192, 736) facing 2, 7x6 cells: 42 of 42 held
  0.17  RESERVE: grid of armnanotc 2x2 gap 0 behind (1192, 688) facing 2: 4 of 4 slots (group 19, zone)
  0.17  RESERVE: zone 24 at (1192, 664) facing 0, 9x15 cells: 9 of 135 held
  0.17  RESERVE: corridor 25 at (1192, 368) facing 2, 13x20 cells: 260 of 260 held
  0.17  RESERVE: corridor 13 at (14003, 1610) facing 0, 11x21 cells: 79 of 231 held
  0.17  RESERVE: leglab at (12560, 832) facing 3 (id 119)
  0.17  RESERVE: zone 14 at (12632, 832) facing 3, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (12608, 832) facing 3: 2 of 2 slots (group 8, zone)
  0.17  RESERVE: corridor 15 at (12584, 736) facing 3, 21x6 cells: 126 of 126 held
  0.17  RESERVE: zone 16 at (12584, 832) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 16 at (12336, 832) facing 3, 20x10 cells: 190 of 200 held
  0.25  RESERVE: armalab at (1016, 632) facing 2 (id 143)
  0.25  RESERVE: zone 26 at (1016, 752) facing 2, 7x6 cells: 9 of 42 held
  0.26  RESERVE: legalab at (12520, 1960) facing 3 (id 122)
  0.26  RESERVE: zone 17 at (12640, 1960) facing 3, 6x7 cells: 42 of 42 held
  0.26  RESERVE: grid of legnanotc 2x2 gap 0 behind (12592, 1960) facing 3: 4 of 4 slots (group 9, zone)
  0.26  RESERVE: zone 18 at (12568, 1960) facing 0, 15x9 cells: 12 of 135 held
  0.26  RESERVE: corridor 19 at (12272, 1960) facing 3, 20x13 cells: 260 of 260 held
  0.33  RESERVE: layout reset (0 reservations, 0 zones released)
  0.33  RESERVE: layout reset (0 reservations, 0 zones released)
  0.33  RESERVE: factory pair 'tech.factory.start' committed atomically facing 1
  0.33  RESERVE: zone 7 at (1645, 6344) facing 1, 63x77 cells: 4631 of 4851 held
  0.33  RESERVE: grid of legnanotc 13x1 gap 0 behind (2141, 6344) facing 1: 13 of 13 slots (group 5, held, zone)
  0.33  RESERVE: grid of legnanotc 13x1 gap 0 behind (2093, 6344) facing 1: 13 of 13 slots (group 5, held, zone)
  0.33  RESERVE: grid of legnanotc 13x1 gap 0 behind (2045, 6344) facing 1: 13 of 13 slots (group 5, held, zone)
  0.33  RESERVE: grid of legnanotc 13x1 gap 0 behind (1997, 6344) facing 1: 13 of 13 slots (group 5, held, zone)
  0.33  RESERVE: legalab at (2216, 6104) facing 1 (id 63)
  0.33  RESERVE: armlab at (960, 656) facing 2 (id 144)
  0.33  RESERVE: zone 27 at (960, 728) facing 2, 6x3 cells: 0 of 18 held
  0.33  RESERVE: armlab at (464, 784) facing 2 (id 145)
  0.33  RESERVE: zone 27 at (464, 856) facing 2, 6x3 cells: 0 of 18 held
  0.33  RESERVE: armlab at (576, 736) facing 2 (id 146)
  0.33  RESERVE: zone 27 at (576, 808) facing 2, 6x3 cells: 0 of 18 held
  0.33  RESERVE: armlab at (704, 704) facing 2 (id 147)
  0.33  RESERVE: zone 27 at (704, 776) facing 2, 6x3 cells: 0 of 18 held
  0.33  RESERVE: armlab at (800, 608) facing 2 (id 148)
  0.33  RESERVE: zone 27 at (800, 680) facing 2, 6x3 cells: 0 of 18 held
  0.34  RESERVE: leglab at (3712, 6368) facing 1 (id 64)
  0.34  RESERVE: zone 8 at (3640, 6368) facing 1, 3x6 cells: 18 of 18 held
  0.34  RESERVE: grid of legnanotc 2x1 gap 0 behind (3664, 6368) facing 1: 2 of 2 slots (group 6, zone)
  0.34  RESERVE: corridor 9 at (3688, 6464) facing 1, 21x6 cells: 126 of 126 held
  0.34  RESERVE: zone 10 at (3688, 6368) facing 0, 9x6 cells: 0 of 54 held
  0.34  RESERVE: corridor 10 at (3936, 6368) facing 1, 20x10 cells: 190 of 200 held
  0.34  RESERVE: legalab at (11992, 1768) facing 3 (id 127)
  0.34  RESERVE: zone 20 at (12112, 1768) facing 3, 6x7 cells: 42 of 42 held
  0.34  RESERVE: grid of legnanotc 2x2 gap 0 behind (12064, 1768) facing 3: 4 of 4 slots (group 10, zone)
  0.34  RESERVE: zone 21 at (12040, 1768) facing 0, 15x9 cells: 12 of 135 held
  0.34  RESERVE: corridor 22 at (11744, 1768) facing 3, 20x13 cells: 260 of 260 held
  0.42  RESERVE: armalab at (1016, 632) facing 2 (id 149)
  0.42  RESERVE: zone 27 at (1016, 752) facing 2, 7x6 cells: 0 of 42 held
  0.42  RESERVE: leglab at (3680, 6752) facing 1 (id 67)
  0.42  RESERVE: zone 11 at (3608, 6752) facing 1, 3x6 cells: 18 of 18 held
  0.42  RESERVE: grid of legnanotc 2x1 gap 0 behind (3632, 6752) facing 1: 2 of 2 slots (group 7, zone)
  0.42  RESERVE: leglab at (2816, 6688) facing 1 (id 70)
```
