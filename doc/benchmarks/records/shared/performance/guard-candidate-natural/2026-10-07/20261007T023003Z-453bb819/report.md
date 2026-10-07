# Playtest report: PASS

- Verdict: **PASS** (reached 10 min)
- Game time reached: 10.0 min (frame 18003); wall 112 s
- DLL: build-theatres\d223\candidate\SkirmishAI.dll (48e4995544486f4a); AI BARbTest/test; staged 2026-10-06T23:28:01
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: guard-natural.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\guard-candidate-natural\glacial\20261007T022801Z-7a701b75\runs\20261007T023003Z-453bb819\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:33.313707][f=-000001] [GuardTest] loaded fixture=false` |
| expect `complete` | seen at 10.0 min | `[t=00:01:49.596207][f=0018000] [GuardTest] frame=18000 commands=1908 guards=1 repeated_targets=0 finished_mobile=10` |
| forbid `errors` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\guard-candidate-natural\glacial\20261007T022801Z-7a701b75\runs\20261007T023003Z-453bb819\screen_2026-10-07_02-29-17-214.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\guard-candidate-natural\glacial\20261007T022801Z-7a701b75\runs\20261007T023003Z-453bb819\screen_2026-10-07_02-29-36-192.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\guard-candidate-natural\glacial\20261007T022801Z-7a701b75\runs\20261007T023003Z-453bb819\screen_2026-10-07_02-29-55-170.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 10, 3 shots, end at 10.5 min
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
  0.00  [Playtest] speed 10
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
  0.17  [Team][Roster] first mex 13478 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.17  [Team][Roster] team 2 first mex at 1904,5967
  0.27  [Playtest] finished armmex team 0 at 0.27 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.7 bank 1097/1100, energy +30.0 bank 997/1000, units 4
  1.18  [Playtest] finished armmex team 0 at 1.18 min
  1.41  [Playtest] finished armmex team 0 at 1.41 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +10.0 bank 1194/1200, energy +30.0 bank 961/1000, units 6
  2.14  [Playtest] finished armtide team 0 at 2.14 min
  2.39  [Playtest] finished armtide team 0 at 2.39 min
  2.70  [Playtest] finished armsy team 0 at 2.70 min
  2.80  [SEA][Layout] berth sea.berth.0 armasy at=3440,4000 facing=1
  3.00  [SEA][Layout] berth sea.berth.1 armplat at=4384,3984 facing=1
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 854/1300, energy +83.0 bank 2/1250, units 10
  3.00  [Playtest] camera requested (1450,4350) height=2800
  3.00  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  3.00  [Playtest] screenshot at 3.0 min of team 0 at (1450, 4350)
  3.07  [SEA][Layout] berth sea.berth.2 armshltxuw at=3728,4960 facing=1
  3.76  [Playtest] finished armtide team 0 at 3.76 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 683/1300, energy +113.0 bank 85/1350, units 15
  4.08  [Playtest] finished armtide team 0 at 4.08 min
  4.15  [Playtest] finished armtide team 0 at 4.15 min
  4.46  [Playtest] finished armtide team 0 at 4.46 min
  4.47  [Playtest] finished armtide team 0 at 4.47 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +10.0 bank 0/1300, energy +205.0 bank 1546/1550, units 20
  5.07  [Playtest] finished armtide team 0 at 5.07 min
  5.11  [Playtest] finished armtide team 0 at 5.11 min
  5.57  [Playtest] finished armtide team 0 at 5.57 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +10.0 bank 13/1300, energy +274.0 bank 1692/1700, units 23
  6.00  [Playtest] camera requested (1450,4350) height=3200
  6.00  [Playtest] camera captured name=ta position=(1450,4350) height=3200
  6.00  [Playtest] screenshot at 6.0 min of team 0 at (1450, 4350)
  6.33  [Playtest] finished armmex team 0 at 6.33 min
  6.75  [Playtest] finished armmex team 0 at 6.75 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +14.0 bank 0/1400, energy +274.0 bank 1686/1700, units 27
  7.05  [Playtest] finished armtide team 0 at 7.05 min
  7.41  [Playtest] finished armtide team 0 at 7.41 min
  7.77  [Playtest] finished armtide team 0 at 7.77 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +14.0 bank 3/1400, energy +343.0 bank 1845/1850, units 32
  8.04  [Playtest] finished armmex team 0 at 8.04 min
  8.23  [Playtest] finished armtide team 0 at 8.23 min
  8.79  [Playtest] finished armmex team 0 at 8.79 min
  8.85  [Playtest] finished armtide team 0 at 8.85 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +16.0 bank 0/1450, energy +389.0 bank 1940/1950, units 34
  9.00  [Playtest] camera requested (1450,4350) height=3200
  9.00  [Playtest] camera captured name=ta position=(1450,4350) height=3200
  9.00  [Playtest] screenshot at 9.0 min of team 0 at (1450, 4350)
  9.13  [Playtest] finished armfrt team 0 at 9.13 min
  9.26  [Playtest] finished armtide team 0 at 9.26 min
  9.46  [Playtest] finished armmex team 0 at 9.46 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +18.0 bank 9/1500, energy +412.0 bank 1987/2000, units 37
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
