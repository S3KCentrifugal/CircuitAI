# Playtest report: PASS

- Verdict: **PASS** (reached 15 min)
- Game time reached: 15.0 min (frame 27005); wall 122 s
- DLL: build-theatres\d216-final\SkirmishAI.dll (45eb0f2e89a285e3); AI BARbTest/test; staged 2026-10-06T05:32:23
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\mex-expansion-candidate\glacial\20261006T083222Z-b9132924\runs\20261006T083502Z-cce5165b\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:28.778246][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 2.3 min | `[t=00:00:50.753633][f=0004146] [SeaWatch] finished frame=4146 id=29615 def=armsy builder=27123` |
| expect `first-ship-exit` | seen at 2.7 min | `[t=00:00:52.817353][f=0004890] [SeaWatch] egress id=6935 yard=29615 seconds=6.4 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\mex-expansion-candidate\glacial\20261006T083222Z-b9132924\runs\20261006T083502Z-cce5165b\screen_2026-10-06_08-34-04-686.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\mex-expansion-candidate\glacial\20261006T083222Z-b9132924\runs\20261006T083502Z-cce5165b\screen_2026-10-06_08-34-31-468.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\mex-expansion-candidate\glacial\20261006T083222Z-b9132924\runs\20261006T083502Z-cce5165b\screen_2026-10-06_08-34-54-765.png

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
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.7 bank 1095/1100, energy +30.0 bank 989/1000, units 5
  1.17  [Playtest] finished armmex team 0 at 1.17 min
  1.78  [Playtest] finished armtide team 0 at 1.78 min
  2.00  [Playtest] finished armtide team 0 at 2.00 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 1144/1150, energy +53.0 bank 1052/1100, units 6
  2.30  [Playtest] finished armsy team 0 at 2.30 min
  2.47  [SEA][Layout] berth sea.berth.0 armasy at=1808,3904 facing=1
  2.48  [SEA][Layout] berth sea.berth.1 armplat at=1568,4016 facing=1
  2.65  [Playtest] finished armtide team 0 at 2.65 min
  2.81  [Playtest] finished armtide team 0 at 2.81 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 570/1250, energy +129.0 bank 433/1350, units 13
  3.10  [Playtest] finished armtide team 0 at 3.10 min
  3.32  [Playtest] finished armmex team 0 at 3.32 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 0/1300, energy +159.0 bank 1446/1450, units 17
  4.78  [Playtest] finished armtide team 0 at 4.78 min
  4.82  [Playtest] finished armmex team 0 at 4.82 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +12.0 bank 0/1350, energy +182.0 bank 1489/1500, units 19
  5.00  [Playtest] camera requested (2800,4800) height=5000
  5.00  [Playtest] camera captured name=ta position=(2800,4800) height=5000
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (2800, 4800)
  5.03  [Playtest] finished armmex team 0 at 5.03 min
  5.21  [Playtest] finished armmex team 0 at 5.21 min
  5.44  [Playtest] finished armmex team 0 at 5.44 min
  5.62  [Playtest] finished armmex team 0 at 5.62 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +20.0 bank 431/1550, energy +182.0 bank 1466/1500, units 26
  6.14  [Playtest] finished armmex team 0 at 6.14 min
  6.18  [Playtest] finished armtide team 0 at 6.18 min
  6.38  [Playtest] finished armmex team 0 at 6.38 min
  6.54  [Playtest] finished armtide team 0 at 6.54 min
  6.58  [Playtest] finished armmex team 0 at 6.58 min
  6.77  [Playtest] finished armmex team 0 at 6.77 min
  6.86  [Playtest] finished armtide team 0 at 6.86 min
  6.93  [Playtest] finished armllt team 0 at 6.93 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +28.0 bank 787/1750, energy +251.0 bank 1642/1650, units 35
  7.29  [Playtest] finished armtide team 0 at 7.29 min
  7.68  [Playtest] finished armnanotcplat team 0 at 7.68 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +28.0 bank 1457/1750, energy +274.0 bank 1693/1700, units 36
  9.00  [Playtest] eco team 0 at 9.0 min: metal +28.0 bank 1599/1750, energy +274.0 bank 1688/1700, units 35
  9.36  [Playtest] finished armfmkr team 0 at 9.35 min
  9.38  [Playtest] finished armfmkr team 0 at 9.39 min
  9.76  [Playtest] finished armfmkr team 0 at 9.76 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +28.3 bank 1745/1750, energy +274.0 bank 1340/1700, units 39
 10.00  [Playtest] camera requested (4000,4800) height=5500
 10.01  [Playtest] camera captured name=ta position=(4000,4800) height=5500
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4000, 4800)
 10.03  [Playtest] finished armtide team 0 at 10.03 min
 10.07  [Playtest] finished armfmkr team 0 at 10.07 min
 10.72  [Playtest] finished armtide team 0 at 10.72 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +28.0 bank 1726/1750, energy +320.0 bank 427/1800, units 44
 11.03  [Playtest] finished armtide team 0 at 11.03 min
 11.21  [Playtest] finished armtide team 0 at 11.20 min
 11.49  [Playtest] finished armtide team 0 at 11.49 min
 12.00  [Playtest] finished armtide team 0 at 12.00 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +29.7 bank 1734/1750, energy +389.0 bank 1556/2000, units 49
 12.25  [Playtest] finished armtide team 0 at 12.25 min
 12.41  [Playtest] finished armtl team 0 at 12.41 min
 12.49  [Playtest] finished armtide team 0 at 12.49 min
 12.72  [Playtest] finished armtide team 0 at 12.72 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +29.9 bank 1730/1750, energy +481.0 bank 1648/2150, units 55
 13.05  [Playtest] finished armtide team 0 at 13.05 min
 13.27  [Playtest] finished armfmkr team 0 at 13.27 min
 13.29  [Playtest] finished armtide team 0 at 13.29 min
 13.74  [Playtest] finished armtide team 0 at 13.74 min
 13.84  [Playtest] finished armfmkr team 0 at 13.84 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +33.4 bank 1732/1750, energy +550.0 bank 1938/2300, units 60
 14.00  [Playtest] camera requested (6500,4800) height=7000
 14.02  [Playtest] camera captured name=ta position=(6500,4800) height=7000
 14.02  [Playtest] screenshot at 14.0 min of team 0 at (6500, 4800)
 14.09  [Playtest] finished armtide team 0 at 14.09 min
 14.24  [Playtest] finished armfmkr team 0 at 14.24 min
 14.60  [Playtest] finished armtide team 0 at 14.60 min
 14.80  [Playtest] finished armfmkr team 0 at 14.80 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +35.1 bank 1742/1750, energy +596.0 bank 2017/2400, units 61
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
