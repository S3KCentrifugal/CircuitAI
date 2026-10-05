# Playtest report: FAIL

- Verdict: **FAIL** (expected lines never seen: first-ship-exit)
- Game time reached: 1.2 min (frame 2134); wall 37 s
- DLL: build-theatres\d190-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T11:02:07
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d190-compile\glacial\20261004T140206Z-2fa3b90d\runs\20261004T140247Z-74cc04f9\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:24.403780][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.8 min | `[t=00:00:34.085026][f=0001396] [SeaWatch] finished frame=1396 id=9800 def=armsy builder=27123` |
| expect `first-ship-exit` | **missing** (by 6 min) | |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- none

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 0 shots, end at 1.5 min
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
  0.16  [Playtest] finished armmex team 0 at 0.16 min
  0.17  [SEA][Layout] berth sea.berth.2 armasy at=1424,3296 facing=3
  0.17  [Team][Roster] first mex 10685 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.17  [Team][Roster] team 1 first mex at 704,4448
  0.20  [Team][Roster] team 2 first mex at 1904,5967
  0.29  [Playtest] finished armmex team 0 at 0.29 min
  0.78  [Playtest] finished armsy team 0 at 0.78 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 702/1200, energy +30.0 bank 0/1100, units 6
```

## Native lines (all AIs, first 120)

```
  0.09  EXP: approach: corcom(8444) at (1899, 5801) walks to (1900, 5829), 139 from the cormex site (1904, 5968)
  0.10  RESERVE: zone 1 at (1424, 4000) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (1424, 4000) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (1712, 4000) facing 1, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (1128, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1128, 4104) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (1128, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1128, 4056) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (1128, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1128, 4008) facing 1 (id 4)
  0.10  RESERVE: zone 6 at (1128, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1128, 3960) facing 1 (id 5)
  0.10  RESERVE: zone 7 at (1128, 3912) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1128, 3912) facing 1 (id 6)
  0.10  RESERVE: zone 8 at (1176, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1176, 4104) facing 1 (id 7)
  0.10  RESERVE: zone 9 at (1176, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1176, 4056) facing 1 (id 8)
  0.10  RESERVE: zone 10 at (1176, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1176, 4008) facing 1 (id 9)
  0.10  RESERVE: zone 11 at (1176, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1176, 3960) facing 1 (id 10)
  0.10  RESERVE: zone 12 at (1176, 3912) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1176, 3912) facing 1 (id 11)
  0.10  RESERVE: zone 13 at (1224, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1224, 4104) facing 1 (id 12)
  0.10  RESERVE: zone 14 at (1224, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1224, 4056) facing 1 (id 13)
  0.10  RESERVE: zone 15 at (1224, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1224, 4008) facing 1 (id 14)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 released
  0.10  RESERVE: zone 6 released
  0.10  RESERVE: zone 7 released
  0.10  RESERVE: zone 8 released
  0.10  RESERVE: zone 9 released
  0.10  RESERVE: zone 10 released
  0.10  RESERVE: zone 11 released
  0.10  RESERVE: zone 12 released
  0.10  RESERVE: zone 13 released
  0.10  RESERVE: zone 14 released
  0.10  RESERVE: zone 15 released
  0.10  RESERVE: zone 16 at (1224, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1224, 4104) facing 1 (id 15)
  0.10  RESERVE: zone 17 at (1224, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1224, 4056) facing 1 (id 16)
  0.10  RESERVE: zone 18 at (1224, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1224, 4008) facing 1 (id 17)
  0.10  RESERVE: zone 16 released
  0.10  RESERVE: zone 17 released
  0.10  RESERVE: zone 18 released
  0.10  RESERVE: zone 19 at (1224, 4136) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1224, 4136) facing 1 (id 18)
  0.10  RESERVE: zone 20 at (1224, 4088) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1224, 4088) facing 1 (id 19)
  0.10  RESERVE: zone 21 at (1224, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1224, 4040) facing 1 (id 20)
  0.10  RESERVE: zone 22 at (1224, 3992) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1224, 3992) facing 1 (id 21)
  0.10  RESERVE: zone 19 released
  0.10  RESERVE: zone 20 released
  0.10  RESERVE: zone 21 released
  0.10  RESERVE: zone 22 released
  0.10  RESERVE: zone 23 at (1192, 4168) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1192, 4168) facing 1 (id 22)
  0.10  RESERVE: zone 24 at (1192, 4120) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1192, 4120) facing 1 (id 23)
  0.10  RESERVE: zone 25 at (1192, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1192, 4072) facing 1 (id 24)
  0.10  RESERVE: zone 26 at (1192, 4024) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1192, 4024) facing 1 (id 25)
  0.10  RESERVE: zone 27 at (1192, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1192, 3976) facing 1 (id 26)
  0.10  RESERVE: zone 28 at (1240, 4168) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1240, 4168) facing 1 (id 27)
  0.10  RESERVE: zone 29 at (1240, 4120) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1240, 4120) facing 1 (id 28)
  0.10  RESERVE: zone 30 at (1240, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1240, 4072) facing 1 (id 29)
  0.10  RESERVE: zone 31 at (1240, 4024) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1240, 4024) facing 1 (id 30)
  0.10  RESERVE: zone 32 at (1240, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1240, 3976) facing 1 (id 31)
  0.10  RESERVE: zone 33 at (1288, 4168) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1288, 4168) facing 1 (id 32)
  0.10  RESERVE: zone 34 at (1288, 4120) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1288, 4120) facing 1 (id 33)
  0.10  RESERVE: zone 35 at (1288, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1288, 4072) facing 1 (id 34)
  0.10  RESERVE: zone 36 at (1288, 4024) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1288, 4024) facing 1 (id 35)
  0.10  RESERVE: zone 37 at (1288, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1288, 3976) facing 1 (id 36)
  0.10  RESERVE: zone 38 at (1336, 4168) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1336, 4168) facing 1 (id 37)
  0.10  RESERVE: zone 39 at (1336, 4120) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1336, 4120) facing 1 (id 38)
  0.10  RESERVE: zone 40 at (1336, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1336, 4072) facing 1 (id 39)
  0.10  RESERVE: zone 41 at (1336, 4024) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1336, 4024) facing 1 (id 40)
  0.10  RESERVE: zone 42 at (1336, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1336, 3976) facing 1 (id 41)
  0.10  RESERVE: zone 1 at (704, 4592) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (704, 4592) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (992, 4592) facing 1, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (408, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (408, 4696) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (408, 4648) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (408, 4648) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (408, 4600) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (408, 4600) facing 1 (id 4)
  0.10  RESERVE: zone 6 at (408, 4552) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (408, 4552) facing 1 (id 5)
  0.10  RESERVE: zone 7 at (408, 4504) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (408, 4504) facing 1 (id 6)
  0.10  RESERVE: zone 8 at (456, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (456, 4696) facing 1 (id 7)
  0.10  RESERVE: zone 9 at (456, 4648) facing 1, 3x3 cells: 9 of 9 held
```
