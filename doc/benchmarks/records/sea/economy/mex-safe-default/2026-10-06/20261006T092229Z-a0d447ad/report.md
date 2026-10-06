# Playtest report: PASS

- Verdict: **PASS** (reached 15 min)
- Game time reached: 15.5 min (frame 27900); wall 1 s
- DLL: build-theatres\d216-final\SkirmishAI.dll (45eb0f2e89a285e3); AI BARbTest/test; staged 2026-10-06T06:17:11
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: mex-expansion.json; widget loaded: yes
- Log: build-theatres\games\sea\economy\mex-safe-default\glacial\20261006T091710Z-82ee68ba\runs\20261006T092229Z-a0d447ad\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:28.787431][f=-000001] [SeaExpansionWatch] loaded` |
| expect `frontier` | seen at 6.5 min | `[t=00:01:12.845132][f=0011700] [SeaExpansionWatch] sample frame=11700 team=0 mexes=10 beyond2400=2 furthest=2599 constructors=2` |
| expect `cluster-fort-order` | seen at 3.8 min | `[SEA][Expansion] fort=cortl ship=2817 x=9967 z=4608` |
| expect `fortify` | seen at 4.3 min | `[t=00:01:00.916571][f=0007760] [SeaExpansionWatch] finished team=5 id=16523 def=cortl builder=nil x=9944 z=4504` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- build-theatres\games\sea\economy\mex-safe-default\glacial\20261006T091710Z-82ee68ba\runs\20261006T092229Z-a0d447ad\screen_2026-10-06_09-19-22-307.png
- build-theatres\games\sea\economy\mex-safe-default\glacial\20261006T091710Z-82ee68ba\runs\20261006T092229Z-a0d447ad\screen_2026-10-06_09-19-48-892.png
- build-theatres\games\sea\economy\mex-safe-default\glacial\20261006T091710Z-82ee68ba\runs\20261006T092229Z-a0d447ad\screen_2026-10-06_09-20-10-615.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 12, 3 shots, end at 15.5 min
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
  0.00  [Playtest] speed 12
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
  0.27  [Playtest] finished armmex team 0 at 0.27 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.7 bank 1094/1100, energy +30.0 bank 984/1000, units 5
  1.17  [Playtest] finished armmex team 0 at 1.17 min
  1.76  [Playtest] finished armtide team 0 at 1.76 min
  1.94  [Playtest] finished armtide team 0 at 1.94 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 1101/1150, energy +76.0 bank 1058/1100, units 7
  2.25  [Playtest] finished armsy team 0 at 2.25 min
  2.42  [SEA][Layout] berth sea.berth.0 armasy at=1824,3904 facing=1
  2.43  [SEA][Layout] berth sea.berth.1 armplat at=1584,4016 facing=1
  2.66  [Playtest] finished armtide team 0 at 2.66 min
  2.83  [Playtest] finished armtide team 0 at 2.83 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 546/1250, energy +129.0 bank 176/1400, units 13
  3.09  [Playtest] finished armmex team 0 at 3.09 min
  3.12  [Playtest] finished armtide team 0 at 3.12 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +12.4 bank 0/1300, energy +159.0 bank 1440/1450, units 17
  5.00  [Playtest] eco team 0 at 5.0 min: metal +10.0 bank 0/1300, energy +159.0 bank 1440/1450, units 20
  5.00  [Playtest] camera requested (2800,4800) height=5000
  5.00  [Playtest] camera captured name=ta position=(2800,4800) height=5000
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (2800, 4800)
  5.01  [Playtest] finished armmex team 0 at 5.01 min
  5.21  [Playtest] finished armmex team 0 at 5.21 min
  5.44  [Playtest] finished armmex team 0 at 5.44 min
  5.50  [Playtest] finished armtide team 0 at 5.50 min
  5.63  [Playtest] finished armmex team 0 at 5.63 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +18.0 bank 16/1500, energy +182.0 bank 1472/1500, units 26
  6.01  [Playtest] finished armtide team 0 at 6.01 min
  6.08  [Playtest] finished armtide team 0 at 6.08 min
  6.17  [Playtest] finished armmex team 0 at 6.17 min
  6.40  [Playtest] finished armmex team 0 at 6.40 min
  6.48  [Playtest] finished armtide team 0 at 6.48 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +22.0 bank 431/1600, energy +251.0 bank 1640/1650, units 32
  7.33  [Playtest] finished armfmkr team 0 at 7.33 min
  7.57  [Playtest] finished armfmkr team 0 at 7.57 min
  7.76  [Playtest] finished armmex team 0 at 7.76 min
  7.94  [Playtest] finished armmex team 0 at 7.94 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +27.5 bank 1115/1700, energy +251.0 bank 1290/1650, units 34
  8.18  [Playtest] finished armmex team 0 at 8.18 min
  8.35  [Playtest] finished armmex team 0 at 8.35 min
  8.37  [Playtest] finished armtide team 0 at 8.37 min
  8.82  [Playtest] finished armtide team 0 at 8.82 min
  8.84  [Playtest] finished armmex team 0 at 8.84 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +34.0 bank 1558/1850, energy +297.0 bank 1640/1750, units 39
 10.00  [Playtest] eco team 0 at 10.0 min: metal +34.0 bank 1423/1850, energy +297.0 bank 1681/1750, units 40
 10.00  [Playtest] camera requested (4000,4800) height=5500
 10.01  [Playtest] camera captured name=ta position=(4000,4800) height=5500
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4000, 4800)
 10.28  [Playtest] finished armfmkr team 0 at 10.28 min
 10.68  [Playtest] finished armtide team 0 at 10.68 min
 10.98  [Playtest] finished armfmkr team 0 at 10.98 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +32.6 bank 1644/1850, energy +320.0 bank 1428/1800, units 43
 11.28  [Playtest] finished armtide team 0 at 11.28 min
 11.44  [Playtest] finished armfmkr team 0 at 11.44 min
 11.82  [Playtest] finished armfmkr team 0 at 11.82 min
 11.88  [Playtest] finished armtide team 0 at 11.88 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +35.4 bank 1579/1850, energy +366.0 bank 1532/1900, units 49
 12.38  [Playtest] finished armfmkr team 0 at 12.38 min
 12.51  [Playtest] finished armtide team 0 at 12.51 min
 12.85  [Playtest] finished armtide team 0 at 12.85 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +35.8 bank 1507/1850, energy +412.0 bank 1597/2000, units 54
 13.30  [Playtest] finished armtl team 0 at 13.30 min
 13.44  [Playtest] finished armtide team 0 at 13.44 min
 13.86  [Playtest] finished armtide team 0 at 13.86 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +33.6 bank 1696/1850, energy +458.0 bank 1635/2100, units 53
 14.00  [Playtest] camera requested (6500,4800) height=7000
 14.02  [Playtest] camera captured name=ta position=(6500,4800) height=7000
 14.02  [Playtest] screenshot at 14.0 min of team 0 at (6500, 4800)
 14.49  [Playtest] finished armtide team 0 at 14.49 min
 14.69  [Playtest] finished armtide team 0 at 14.69 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +39.0 bank 1839/1850, energy +504.0 bank 1832/2200, units 56
 15.03  [Playtest] finished armtide team 0 at 15.03 min
 15.50  [Playtest] end at 15.5 min: quitting
```

## Native lines (all AIs, first 120)

```
  0.28  RESERVE: zone 1 at (872, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (872, 4200) facing 1 (id 1)
  0.28  RESERVE: zone 2 at (872, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (872, 4152) facing 1 (id 2)
  0.28  RESERVE: zone 3 at (872, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (872, 4104) facing 1 (id 3)
  0.28  RESERVE: zone 4 at (872, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (872, 4056) facing 1 (id 4)
  0.28  RESERVE: zone 5 at (872, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (872, 4008) facing 1 (id 5)
  0.28  RESERVE: zone 6 at (872, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (872, 3960) facing 1 (id 6)
  0.28  RESERVE: zone 7 at (920, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 4200) facing 1 (id 7)
  0.28  RESERVE: zone 8 at (920, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 4152) facing 1 (id 8)
  0.28  RESERVE: zone 9 at (920, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 4104) facing 1 (id 9)
  0.28  RESERVE: zone 10 at (920, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 4056) facing 1 (id 10)
  0.28  RESERVE: zone 11 at (920, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 4008) facing 1 (id 11)
  0.28  RESERVE: zone 12 at (920, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 3960) facing 1 (id 12)
  0.28  RESERVE: zone 13 at (968, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 4200) facing 1 (id 13)
  0.28  RESERVE: zone 14 at (968, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 4152) facing 1 (id 14)
  0.28  RESERVE: zone 15 at (968, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 4104) facing 1 (id 15)
  0.28  RESERVE: zone 16 at (968, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 4056) facing 1 (id 16)
  0.28  RESERVE: zone 17 at (968, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 4008) facing 1 (id 17)
  0.28  RESERVE: zone 18 at (968, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 3960) facing 1 (id 18)
  0.28  RESERVE: zone 19 at (1016, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 4200) facing 1 (id 19)
  0.28  RESERVE: zone 20 at (1016, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 4152) facing 1 (id 20)
  0.28  RESERVE: zone 21 at (1016, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 4104) facing 1 (id 21)
  0.28  RESERVE: zone 22 at (1016, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 4056) facing 1 (id 22)
  0.28  RESERVE: zone 23 at (1016, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 4008) facing 1 (id 23)
  0.28  RESERVE: zone 24 at (1016, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 3960) facing 1 (id 24)
  0.28  RESERVE: zone 25 at (1064, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1064, 4200) facing 1 (id 25)
  0.28  RESERVE: zone 26 at (1064, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1064, 4152) facing 1 (id 26)
  0.28  RESERVE: zone 27 at (1064, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1064, 4104) facing 1 (id 27)
  0.28  RESERVE: zone 28 at (1064, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1064, 4056) facing 1 (id 28)
  0.28  RESERVE: zone 29 at (1064, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1064, 4008) facing 1 (id 29)
  0.28  RESERVE: zone 30 at (1064, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1064, 3960) facing 1 (id 30)
  0.28  RESERVE: zone 31 at (1112, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1112, 4200) facing 1 (id 31)
  0.28  RESERVE: zone 32 at (1112, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1112, 4152) facing 1 (id 32)
  0.28  RESERVE: zone 33 at (1112, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1112, 4104) facing 1 (id 33)
  0.28  RESERVE: zone 34 at (1112, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1112, 4056) facing 1 (id 34)
  0.28  RESERVE: zone 35 at (1112, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1112, 4008) facing 1 (id 35)
  0.28  RESERVE: zone 36 at (1112, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1112, 3960) facing 1 (id 36)
  0.28  RESERVE: zone 37 at (1160, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1160, 4200) facing 1 (id 37)
  0.28  RESERVE: zone 38 at (1160, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1160, 4152) facing 1 (id 38)
  0.28  RESERVE: zone 39 at (1160, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1160, 4104) facing 1 (id 39)
  0.28  RESERVE: zone 40 at (1160, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1160, 4056) facing 1 (id 40)
  0.28  RESERVE: zone 41 at (1160, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1160, 4008) facing 1 (id 41)
  0.28  RESERVE: zone 42 at (1160, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1160, 3960) facing 1 (id 42)
  0.28  RESERVE: zone 43 at (1208, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1208, 4200) facing 1 (id 43)
  0.28  RESERVE: zone 44 at (1208, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1208, 4152) facing 1 (id 44)
  0.28  RESERVE: zone 45 at (1208, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1208, 4104) facing 1 (id 45)
  0.28  RESERVE: zone 46 at (1208, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1208, 4056) facing 1 (id 46)
  0.28  RESERVE: zone 47 at (1208, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1208, 4008) facing 1 (id 47)
  0.28  RESERVE: zone 48 at (1208, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1208, 3960) facing 1 (id 48)
  0.28  RESERVE: served armtide at (872, 4200) facing 1 (id 1, 47 of this def still held)
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
```
