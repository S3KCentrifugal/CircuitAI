# Playtest report: PASS

- Verdict: **PASS** (reached 10 min)
- Game time reached: 10.0 min (frame 18005); wall 89 s
- DLL: build-theatres\d192-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T14:59:53
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-compile\glacial\20261004T175953Z-8fa0edd9\runs\20261004T180126Z-62060b97\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:34.690588][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.4 min | `[t=00:00:50.860013][f=0002527] [SeaWatch] finished frame=2527 id=6887 def=armsy builder=27123` |
| expect `first-ship-exit` | seen at 2.8 min | `[t=00:00:56.696074][f=0005100] [SeaWatch] egress id=26405 yard=6887 seconds=70.0 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-compile\glacial\20261004T175953Z-8fa0edd9\runs\20261004T180126Z-62060b97\screen_2026-10-04_18-01-04-125.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-compile\glacial\20261004T175953Z-8fa0edd9\runs\20261004T180126Z-62060b97\screen_2026-10-04_18-01-25-470.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 10.5 min
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
  0.27  [Playtest] finished armmex team 0 at 0.27 min
  0.45  [Playtest] finished armmex team 0 at 0.45 min
  0.94  [Playtest] finished armtide team 0 at 0.94 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 1112/1150, energy +53.0 bank 1045/1050, units 6
  1.10  [Playtest] finished armtide team 0 at 1.10 min
  1.40  [Playtest] finished armsy team 0 at 1.40 min
  1.77  [Playtest] finished armtide team 0 at 1.77 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 599/1250, energy +106.0 bank 74/1300, units 11
  2.35  [Playtest] finished armtide team 0 at 2.35 min
  2.55  [Playtest] finished armtide team 0 at 2.55 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 1/1250, energy +159.0 bank 1450/1450, units 16
  3.12  [Playtest] finished armtide team 0 at 3.12 min
  3.44  [Playtest] finished armmex team 0 at 3.44 min
  3.93  [Playtest] finished armtide team 0 at 3.93 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 12/1300, energy +205.0 bank 1533/1550, units 20
  4.17  [Playtest] finished armmex team 0 at 4.17 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +12.0 bank 0/1350, energy +205.0 bank 1530/1550, units 26
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.00  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.24  [Playtest] finished armtl team 0 at 5.24 min
  5.54  [Playtest] finished armtide team 0 at 5.54 min
  5.84  [Playtest] finished armtide team 0 at 5.84 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +12.0 bank 13/1350, energy +251.0 bank 1641/1650, units 30
  6.18  [Playtest] finished armfrad team 0 at 6.18 min
  6.32  [Playtest] finished armtide team 0 at 6.32 min
  6.92  [Playtest] finished armtide team 0 at 6.92 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +12.0 bank 0/1350, energy +297.0 bank 1750/1750, units 30
  8.00  [Playtest] eco team 0 at 8.0 min: metal +12.0 bank 0/1350, energy +297.0 bank 1750/1750, units 30
  9.00  [Playtest] eco team 0 at 9.0 min: metal +12.0 bank 0/1350, energy +297.0 bank 1750/1750, units 29
 10.00  [Playtest] eco team 0 at 10.0 min: metal +12.0 bank 0/1350, energy +297.0 bank 1750/1750, units 32
 10.00  [Playtest] camera requested (1450,4350) height=3200
```

## Native lines (all AIs, first 120)

```
  0.28  RESERVE: zone 1 at (920, 4024) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 4024) facing 1 (id 1)
  0.28  RESERVE: zone 2 at (920, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 3976) facing 1 (id 2)
  0.28  RESERVE: zone 3 at (920, 3928) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 3928) facing 1 (id 3)
  0.28  RESERVE: zone 4 at (920, 3880) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 3880) facing 1 (id 4)
  0.28  RESERVE: zone 5 at (920, 3832) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 3832) facing 1 (id 5)
  0.28  RESERVE: zone 6 at (920, 3784) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 3784) facing 1 (id 6)
  0.28  RESERVE: zone 7 at (968, 4024) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 4024) facing 1 (id 7)
  0.28  RESERVE: zone 8 at (968, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 3976) facing 1 (id 8)
  0.28  RESERVE: zone 9 at (968, 3928) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 3928) facing 1 (id 9)
  0.28  RESERVE: zone 10 at (968, 3880) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 3880) facing 1 (id 10)
  0.28  RESERVE: zone 11 at (968, 3832) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 3832) facing 1 (id 11)
  0.28  RESERVE: zone 12 at (968, 3784) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 3784) facing 1 (id 12)
  0.28  RESERVE: zone 13 at (1016, 4024) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 4024) facing 1 (id 13)
  0.28  RESERVE: zone 14 at (1016, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 3976) facing 1 (id 14)
  0.28  RESERVE: zone 15 at (1016, 3928) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 3928) facing 1 (id 15)
  0.28  RESERVE: zone 16 at (1016, 3880) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 3880) facing 1 (id 16)
  0.28  RESERVE: zone 17 at (1016, 3832) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 3832) facing 1 (id 17)
  0.28  RESERVE: zone 18 at (1016, 3784) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 3784) facing 1 (id 18)
  0.28  RESERVE: zone 19 at (1064, 4024) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1064, 4024) facing 1 (id 19)
  0.28  RESERVE: zone 20 at (1064, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1064, 3976) facing 1 (id 20)
  0.28  RESERVE: zone 21 at (1064, 3928) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1064, 3928) facing 1 (id 21)
  0.28  RESERVE: zone 22 at (1064, 3880) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1064, 3880) facing 1 (id 22)
  0.28  RESERVE: zone 23 at (1064, 3832) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1064, 3832) facing 1 (id 23)
  0.28  RESERVE: zone 24 at (1064, 3784) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1064, 3784) facing 1 (id 24)
  0.28  RESERVE: zone 25 at (1112, 4024) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1112, 4024) facing 1 (id 25)
  0.28  RESERVE: zone 26 at (1112, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1112, 3976) facing 1 (id 26)
  0.28  RESERVE: zone 27 at (1112, 3928) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1112, 3928) facing 1 (id 27)
  0.28  RESERVE: zone 28 at (1112, 3880) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1112, 3880) facing 1 (id 28)
  0.28  RESERVE: zone 29 at (1112, 3832) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1112, 3832) facing 1 (id 29)
  0.28  RESERVE: zone 30 at (1112, 3784) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1112, 3784) facing 1 (id 30)
  0.28  RESERVE: zone 31 at (1160, 4024) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1160, 4024) facing 1 (id 31)
  0.28  RESERVE: zone 32 at (1160, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1160, 3976) facing 1 (id 32)
  0.28  RESERVE: zone 33 at (1160, 3928) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1160, 3928) facing 1 (id 33)
  0.28  RESERVE: zone 34 at (1160, 3880) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1160, 3880) facing 1 (id 34)
  0.28  RESERVE: zone 35 at (1160, 3832) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1160, 3832) facing 1 (id 35)
  0.28  RESERVE: zone 36 at (1160, 3784) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1160, 3784) facing 1 (id 36)
  0.28  RESERVE: zone 37 at (1208, 4024) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1208, 4024) facing 1 (id 37)
  0.28  RESERVE: zone 38 at (1208, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1208, 3976) facing 1 (id 38)
  0.28  RESERVE: zone 39 at (1208, 3928) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1208, 3928) facing 1 (id 39)
  0.28  RESERVE: zone 40 at (1208, 3880) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1208, 3880) facing 1 (id 40)
  0.28  RESERVE: zone 41 at (1208, 3832) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1208, 3832) facing 1 (id 41)
  0.28  RESERVE: zone 42 at (1208, 3784) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1208, 3784) facing 1 (id 42)
  0.28  RESERVE: zone 43 at (1256, 4024) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1256, 4024) facing 1 (id 43)
  0.28  RESERVE: zone 44 at (1256, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1256, 3976) facing 1 (id 44)
  0.28  RESERVE: zone 1 released
  0.28  RESERVE: zone 2 released
  0.28  RESERVE: zone 3 released
  0.28  RESERVE: zone 4 released
  0.28  RESERVE: zone 5 released
  0.28  RESERVE: zone 6 released
  0.28  RESERVE: zone 7 released
  0.28  RESERVE: zone 8 released
  0.28  RESERVE: zone 9 released
  0.28  RESERVE: zone 10 released
  0.28  RESERVE: zone 11 released
  0.28  RESERVE: zone 12 released
  0.28  RESERVE: zone 13 released
  0.28  RESERVE: zone 14 released
  0.28  RESERVE: zone 15 released
  0.28  RESERVE: zone 16 released
  0.28  RESERVE: zone 17 released
  0.28  RESERVE: zone 18 released
  0.28  RESERVE: zone 19 released
  0.28  RESERVE: zone 20 released
  0.28  RESERVE: zone 21 released
  0.28  RESERVE: zone 22 released
  0.28  RESERVE: zone 23 released
  0.28  RESERVE: zone 24 released
  0.28  RESERVE: zone 25 released
  0.28  RESERVE: zone 26 released
  0.28  RESERVE: zone 27 released
  0.28  RESERVE: zone 28 released
  0.28  RESERVE: zone 29 released
  0.28  RESERVE: zone 30 released
  0.28  RESERVE: zone 31 released
  0.28  RESERVE: zone 32 released
```
