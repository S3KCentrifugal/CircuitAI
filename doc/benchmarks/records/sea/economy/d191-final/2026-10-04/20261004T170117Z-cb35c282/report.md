# Playtest report: PASS

- Verdict: **PASS** (reached 20 min)
- Game time reached: 20.1 min (frame 36121); wall 164 s
- DLL: build-theatres\d191-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T13:58:30
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-final\glacial\20261004T165829Z-0a9c4f38\runs\20261004T170117Z-cb35c282\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:53.789981][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.3 min | `[t=00:01:11.806884][f=0002332] [SeaWatch] finished frame=2332 id=6887 def=armsy builder=27123` |
| expect `first-ship-exit` | seen at 2.5 min | `[t=00:01:16.729768][f=0004530] [SeaWatch] egress id=25989 yard=6887 seconds=5.1 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-final\glacial\20261004T165829Z-0a9c4f38\runs\20261004T170117Z-cb35c282\screen_2026-10-04_17-00-02-782.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-final\glacial\20261004T165829Z-0a9c4f38\runs\20261004T170117Z-cb35c282\screen_2026-10-04_17-00-25-066.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d191-final\glacial\20261004T165829Z-0a9c4f38\runs\20261004T170117Z-cb35c282\screen_2026-10-04_17-01-16-011.png

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
  0.15  [Playtest] finished armmex team 0 at 0.15 min
  0.17  [Team][Roster] first mex 24526 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.17  [Team][Roster] team 1 first mex at 704,4448
  0.17  [Team][Roster] team 2 first mex at 1904,5967
  0.27  [Playtest] finished armmex team 0 at 0.27 min
  0.43  [Playtest] finished armmex team 0 at 0.43 min
  0.75  [Playtest] finished armtide team 0 at 0.75 min
  0.89  [Playtest] finished armtide team 0 at 0.89 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 1043/1150, energy +76.0 bank 1100/1100, units 6
  1.30  [Playtest] finished armsy team 0 at 1.30 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 694/1250, energy +83.0 bank 494/1250, units 10
  2.17  [Playtest] finished armtide team 0 at 2.17 min
  2.50  [Playtest] finished armtide team 0 at 2.50 min
  2.61  [Playtest] finished armtide team 0 at 2.61 min
  2.83  [Playtest] finished armtide team 0 at 2.83 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 373/1250, energy +182.0 bank 1492/1500, units 16
  3.48  [Playtest] finished armtide team 0 at 3.48 min
  3.80  [Playtest] finished armtide team 0 at 3.80 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +8.0 bank 74/1250, energy +228.0 bank 1589/1600, units 23
  4.29  [Playtest] finished armmex team 0 at 4.29 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +10.0 bank 0/1300, energy +228.0 bank 1586/1600, units 24
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.01  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.58  [Playtest] finished armtide team 0 at 5.58 min
  5.91  [Playtest] finished armtide team 0 at 5.91 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +10.0 bank 14/1300, energy +274.0 bank 1694/1700, units 25
  7.00  [Playtest] eco team 0 at 7.0 min: metal +10.0 bank 13/1300, energy +274.0 bank 1691/1700, units 26
  7.46  [Playtest] finished armfmkr team 0 at 7.46 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +11.0 bank 46/1300, energy +274.0 bank 1654/1700, units 30
  8.35  [Playtest] finished armfmkr team 0 at 8.35 min
  8.50  [Playtest] finished armfmkr team 0 at 8.50 min
  8.73  [Playtest] finished armfmkr team 0 at 8.73 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +14.0 bank 116/1300, energy +274.0 bank 1460/1700, units 33
  9.08  [Playtest] finished armfmkr team 0 at 9.08 min
  9.17  [Playtest] finished armfmkr team 0 at 9.17 min
  9.55  [Playtest] finished armfmkr team 0 at 9.55 min
  9.74  [Playtest] finished armfmkr team 0 at 9.74 min
  9.94  [Playtest] finished armfmkr team 0 at 9.94 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +15.8 bank 265/1300, energy +274.0 bank 1365/1700, units 37
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.02  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.32  [Playtest] finished armfmkr team 0 at 10.32 min
 10.48  [Playtest] finished armfmkr team 0 at 10.48 min
 10.89  [Playtest] finished armfmkr team 0 at 10.89 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +15.8 bank 440/1300, energy +274.0 bank 1315/1700, units 38
 11.48  [Playtest] finished armfmkr team 0 at 11.48 min
 11.85  [Playtest] finished armfmkr team 0 at 11.85 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +15.6 bank 730/1300, energy +274.0 bank 1294/1700, units 40
 12.66  [Playtest] finished armfmkr team 0 at 12.66 min
 12.90  [Playtest] finished armfmkr team 0 at 12.90 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +15.6 bank 886/1300, energy +274.0 bank 1302/1700, units 42
 13.30  [Playtest] finished armfmkr team 0 at 13.30 min
 13.74  [Playtest] finished armfmkr team 0 at 13.74 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +15.8 bank 1194/1300, energy +274.0 bank 1332/1700, units 45
 14.21  [Playtest] finished armfmkr team 0 at 14.21 min
 14.81  [Playtest] finished armfmkr team 0 at 14.81 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +15.7 bank 1128/1300, energy +274.0 bank 1363/1700, units 49
 15.70  [Playtest] finished armfmkr team 0 at 15.70 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +15.7 bank 1093/1300, energy +274.0 bank 1357/1700, units 48
 16.95  [Playtest] finished armfmkr team 0 at 16.95 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +13.9 bank 1098/1300, energy +274.0 bank 1361/1700, units 49
 17.53  [Playtest] finished armtide team 0 at 17.53 min
 17.54  [Playtest] finished armfmkr team 0 at 17.54 min
 17.86  [Playtest] finished armtide team 0 at 17.86 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +16.5 bank 994/1300, energy +320.0 bank 1476/1800, units 51
 18.93  [Playtest] finished armfmkr team 0 at 18.93 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +14.2 bank 983/1300, energy +320.0 bank 1455/1800, units 52
 19.78  [Playtest] finished armtide team 0 at 19.78 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +12.3 bank 1152/1300, energy +343.0 bank 1414/1850, units 53
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.02  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
```

## Native lines (all AIs, first 120)

```
  0.29  RESERVE: zone 1 at (296, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (296, 4728) facing 1 (id 1)
  0.29  RESERVE: zone 2 at (296, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (296, 4680) facing 1 (id 2)
  0.29  RESERVE: zone 3 at (296, 4632) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (296, 4632) facing 1 (id 3)
  0.29  RESERVE: zone 4 at (344, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (344, 4728) facing 1 (id 4)
  0.29  RESERVE: zone 5 at (344, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (344, 4680) facing 1 (id 5)
  0.29  RESERVE: zone 6 at (344, 4632) facing 1, 3x3 cells: 9 of 9 held
  0.29  RESERVE: armtide at (344, 4632) facing 1 (id 6)
  0.29  RESERVE: served armtide at (296, 4728) facing 1 (id 1, 5 of this def still held)
  0.42  RESERVE: zone 1 at (14040, 4632) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armtide at (14040, 4632) facing 3 (id 1)
  0.42  RESERVE: zone 2 at (14040, 4680) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armtide at (14040, 4680) facing 3 (id 2)
  0.42  RESERVE: zone 3 at (14040, 4728) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armtide at (14040, 4728) facing 3 (id 3)
  0.42  RESERVE: zone 4 at (13992, 4632) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armtide at (13992, 4632) facing 3 (id 4)
  0.42  RESERVE: zone 5 at (13992, 4680) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armtide at (13992, 4680) facing 3 (id 5)
  0.42  RESERVE: zone 6 at (13992, 4728) facing 3, 3x3 cells: 9 of 9 held
  0.42  RESERVE: armtide at (13992, 4728) facing 3 (id 6)
  0.42  RESERVE: served armtide at (14040, 4632) facing 3 (id 1, 5 of this def still held)
  0.44  RESERVE: zone 1 at (1016, 4136) facing 1, 3x3 cells: 9 of 9 held
  0.44  RESERVE: armtide at (1016, 4136) facing 1 (id 1)
  0.44  RESERVE: zone 2 at (1016, 4088) facing 1, 3x3 cells: 9 of 9 held
  0.44  RESERVE: armtide at (1016, 4088) facing 1 (id 2)
  0.44  RESERVE: zone 3 at (1016, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.44  RESERVE: armtide at (1016, 4040) facing 1 (id 3)
  0.44  RESERVE: zone 4 at (1064, 4136) facing 1, 3x3 cells: 9 of 9 held
  0.44  RESERVE: armtide at (1064, 4136) facing 1 (id 4)
  0.44  RESERVE: zone 5 at (1064, 4088) facing 1, 3x3 cells: 9 of 9 held
  0.44  RESERVE: armtide at (1064, 4088) facing 1 (id 5)
  0.44  RESERVE: zone 6 at (1064, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.44  RESERVE: armtide at (1064, 4040) facing 1 (id 6)
  0.44  RESERVE: served armtide at (1016, 4136) facing 1 (id 1, 5 of this def still held)
  0.48  RESERVE: zone 1 at (13256, 4040) facing 3, 3x3 cells: 9 of 9 held
  0.48  RESERVE: legtide at (13256, 4040) facing 3 (id 1)
  0.48  RESERVE: zone 2 at (13256, 4088) facing 3, 3x3 cells: 9 of 9 held
  0.48  RESERVE: legtide at (13256, 4088) facing 3 (id 2)
  0.48  RESERVE: zone 3 at (13256, 4136) facing 3, 3x3 cells: 9 of 9 held
  0.48  RESERVE: legtide at (13256, 4136) facing 3 (id 3)
  0.48  RESERVE: zone 4 at (13208, 4040) facing 3, 3x3 cells: 9 of 9 held
  0.48  RESERVE: legtide at (13208, 4040) facing 3 (id 4)
  0.48  RESERVE: zone 5 at (13208, 4088) facing 3, 3x3 cells: 9 of 9 held
  0.48  RESERVE: legtide at (13208, 4088) facing 3 (id 5)
  0.48  RESERVE: zone 6 at (13208, 4136) facing 3, 3x3 cells: 9 of 9 held
  0.48  RESERVE: legtide at (13208, 4136) facing 3 (id 6)
  0.48  RESERVE: served legtide at (13256, 4040) facing 3 (id 1, 5 of this def still held)
  0.62  RESERVE: served armtide at (296, 4680) facing 1 (id 2, 4 of this def still held)
  0.74  RESERVE: served armtide at (14040, 4680) facing 3 (id 2, 4 of this def still held)
  0.76  RESERVE: served armtide at (1016, 4088) facing 1 (id 2, 4 of this def still held)
  0.79  RESERVE: served legtide at (13256, 4088) facing 3 (id 2, 4 of this def still held)
  1.07  RESERVE: zone 7 at (248, 5048) facing 1, 3x3 cells: 9 of 9 held
  1.07  RESERVE: armnanotcplat at (248, 5048) facing 1 (id 7)
  1.07  RESERVE: zone 8 at (248, 5000) facing 1, 3x3 cells: 9 of 9 held
  1.07  RESERVE: armnanotcplat at (248, 5000) facing 1 (id 8)
  1.07  RESERVE: zone 9 at (248, 4952) facing 1, 3x3 cells: 9 of 9 held
  1.07  RESERVE: armnanotcplat at (248, 4952) facing 1 (id 9)
  1.07  RESERVE: zone 10 at (248, 4904) facing 1, 3x3 cells: 9 of 9 held
  1.07  RESERVE: armnanotcplat at (248, 4904) facing 1 (id 10)
  1.07  RESERVE: zone 11 at (248, 4856) facing 1, 3x3 cells: 9 of 9 held
  1.07  RESERVE: armnanotcplat at (248, 4856) facing 1 (id 11)
  1.07  RESERVE: zone 12 at (296, 5048) facing 1, 3x3 cells: 9 of 9 held
  1.07  RESERVE: armnanotcplat at (296, 5048) facing 1 (id 12)
  1.07  RESERVE: zone 13 at (296, 5000) facing 1, 3x3 cells: 9 of 9 held
  1.07  RESERVE: armnanotcplat at (296, 5000) facing 1 (id 13)
  1.07  RESERVE: zone 14 at (296, 4952) facing 1, 3x3 cells: 9 of 9 held
  1.07  RESERVE: armnanotcplat at (296, 4952) facing 1 (id 14)
  1.07  RESERVE: zone 15 at (296, 4904) facing 1, 3x3 cells: 9 of 9 held
  1.07  RESERVE: armnanotcplat at (296, 4904) facing 1 (id 15)
  1.07  RESERVE: zone 16 at (296, 4856) facing 1, 3x3 cells: 9 of 9 held
  1.07  RESERVE: armnanotcplat at (296, 4856) facing 1 (id 16)
  1.07  RESERVE: zone 17 at (344, 5048) facing 1, 3x3 cells: 9 of 9 held
  1.07  RESERVE: armnanotcplat at (344, 5048) facing 1 (id 17)
  1.07  RESERVE: zone 18 at (344, 5000) facing 1, 3x3 cells: 9 of 9 held
  1.07  RESERVE: armnanotcplat at (344, 5000) facing 1 (id 18)
  1.07  RESERVE: zone 19 at (344, 4952) facing 1, 3x3 cells: 9 of 9 held
  1.07  RESERVE: armnanotcplat at (344, 4952) facing 1 (id 19)
  1.07  RESERVE: zone 20 at (344, 4904) facing 1, 3x3 cells: 9 of 9 held
  1.07  RESERVE: armnanotcplat at (344, 4904) facing 1 (id 20)
  1.07  RESERVE: zone 21 at (344, 4856) facing 1, 3x3 cells: 9 of 9 held
  1.07  RESERVE: armnanotcplat at (344, 4856) facing 1 (id 21)
  1.07  RESERVE: zone 22 at (392, 5048) facing 1, 3x3 cells: 9 of 9 held
  1.07  RESERVE: armnanotcplat at (392, 5048) facing 1 (id 22)
  1.07  RESERVE: zone 23 at (392, 5000) facing 1, 3x3 cells: 9 of 9 held
  1.07  RESERVE: armnanotcplat at (392, 5000) facing 1 (id 23)
  1.07  RESERVE: zone 24 at (392, 4952) facing 1, 3x3 cells: 9 of 9 held
  1.07  RESERVE: armnanotcplat at (392, 4952) facing 1 (id 24)
  1.07  RESERVE: zone 7 released
  1.07  RESERVE: zone 8 released
  1.07  RESERVE: zone 9 released
  1.07  RESERVE: zone 10 released
  1.07  RESERVE: zone 11 released
  1.07  RESERVE: zone 12 released
  1.07  RESERVE: zone 13 released
  1.07  RESERVE: zone 14 released
  1.07  RESERVE: zone 15 released
  1.07  RESERVE: zone 16 released
  1.07  RESERVE: zone 17 released
  1.07  RESERVE: zone 18 released
  1.07  RESERVE: zone 19 released
  1.07  RESERVE: zone 20 released
  1.07  RESERVE: zone 21 released
  1.07  RESERVE: zone 22 released
  1.07  RESERVE: zone 23 released
  1.07  RESERVE: zone 24 released
  1.07  RESERVE: corridor 25 at (752, 4768) facing 1, 30x12 cells: 88 of 360 held
  1.07  RESERVE: zone 26 at (16, 4768) facing 1, 21x40 cells: 596 of 840 held
  1.07  RESERVE: refused armnanotcplat at (8, 4840): off map
  1.07  RESERVE: refused armnanotcplat at (8, 4792): off map
  1.07  RESERVE: refused armnanotcplat at (8, 4744): off map
  1.07  RESERVE: refused armnanotcplat at (8, 4696): off map
  1.07  RESERVE: refused armnanotcplat at (8, 4840): off map
  1.07  RESERVE: refused armnanotcplat at (8, 4792): off map
  1.07  RESERVE: refused armnanotcplat at (8, 4744): off map
  1.07  RESERVE: refused armnanotcplat at (8, 4696): off map
```
