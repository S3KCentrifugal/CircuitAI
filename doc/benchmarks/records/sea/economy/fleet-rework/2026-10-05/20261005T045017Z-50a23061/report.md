# Playtest report: PASS

- Verdict: **PASS** (reached 20 min)
- Game time reached: 20.0 min (frame 36005); wall 126 s
- DLL: build-theatres\d200\build-3\SkirmishAI.dll (bcac8c987b1d8164); AI BARbTest/test; staged 2026-10-05T01:48:07
- Map: Shore_to_Shore_V3; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\fleet-rework\shore\20261005T044807Z-750b1ae3\runs\20261005T045017Z-50a23061\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:26.793127][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.1 min | `[t=00:00:40.432548][f=0002002] [SeaWatch] finished frame=2002 id=4850 def=armsy builder=27123` |
| expect `first-ship-exit` | seen at 1.8 min | `[t=00:00:42.494770][f=0003240] [SeaWatch] egress id=21386 yard=4850 seconds=16.3 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\fleet-rework\shore\20261005T044807Z-750b1ae3\runs\20261005T045017Z-50a23061\screen_2026-10-05_04-49-04-473.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\fleet-rework\shore\20261005T044807Z-750b1ae3\runs\20261005T045017Z-50a23061\screen_2026-10-05_04-49-24-436.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\fleet-rework\shore\20261005T044807Z-750b1ae3\runs\20261005T045017Z-50a23061\screen_2026-10-05_04-50-15-837.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 20, 4 shots, end at 20.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (2000, 730) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (2000, 1740) units 1
  0.00  [Playtest] frame 1 team 2 ally 0 side cortex ai true dead false start (2000, 2700) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (13250, 730) units 1
  0.00  [Playtest] frame 1 team 4 ally 1 side armada ai true dead false start (13250, 1740) units 1
  0.00  [Playtest] frame 1 team 5 ally 1 side cortex ai true dead false start (13250, 2700) units 1
  0.00  [Playtest] frame 1 team 6 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 7 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 20
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (2000, 730) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (2000, 1740) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (2000, 2700) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (13250, 730) units 1
  0.05  [Playtest] frame 90 team 4 ally 1 side armada ai true dead false start (13250, 1740) units 1
  0.05  [Playtest] frame 90 team 5 ally 1 side cortex ai true dead false start (13250, 2700) units 1
  0.05  [Playtest] frame 90 team 6 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 7 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|1947|757|0|3|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(1973,1703) factory=armsy landLocked=no spot=4 known=1/2
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(1954,2751) factory=corsy landLocked=no spot=5 known=2/2
  0.20  [Playtest] finished armmex team 0 at 0.20 min
  0.22  [Team][Roster] first mex 24526 at 1792,832
  0.22  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1947|757|0|3|1|1792|832
  0.23  [Team][Roster] team 1 first mex at 1888,1488
  0.23  [Team][Roster] team 2 first mex at 1808,2911
  0.47  [Playtest] finished armmex team 0 at 0.47 min
  0.58  [Playtest] finished armwin team 0 at 0.58 min
  0.70  [Playtest] finished armwin team 0 at 0.70 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.1 bank 821/1100, energy +45.5 bank 927/1001, units 6
  1.11  [Playtest] finished armsy team 0 at 1.11 min
  1.22  [SEA][Layout] berth sea.berth.0 armasy at=2752,736 facing=1
  1.23  [SEA][Layout] berth sea.berth.1 armasy at=3056,160 facing=1
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.1 bank 655/1200, energy +61.9 bank 60/1151, units 9
  2.52  [Playtest] finished armtide team 0 at 2.52 min
  2.86  [Playtest] finished armtide team 0 at 2.86 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.1 bank 316/1200, energy +104.1 bank 66/1301, units 13
  3.13  [Playtest] finished armtide team 0 at 3.13 min
  3.34  [Playtest] finished armtide team 0 at 3.34 min
  3.61  [Playtest] finished armmex team 0 at 3.61 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +8.1 bank 0/1250, energy +159.2 bank 1388/1401, units 19
  4.13  [Playtest] finished armmex team 0 at 4.13 min
  4.86  [Playtest] finished armmex team 0 at 4.86 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +14.9 bank 6/1350, energy +143.2 bank 1350/1401, units 20
  5.00  [Playtest] target team 0 at (2000, 730) from its start position
  5.00  [Playtest] camera requested (2000,730) height=2200
  5.02  [Playtest] camera captured name=ta position=(2000,730) height=2200
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (2000, 730)
  5.28  [Playtest] finished armmex team 0 at 5.28 min
  5.40  [Playtest] finished armrad team 0 at 5.40 min
  5.65  [Playtest] finished armllt team 0 at 5.65 min
  5.70  [Playtest] finished armtide team 0 at 5.70 min
  5.80  [Playtest] finished armtide team 0 at 5.80 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +14.2 bank 100/1400, energy +199.5 bank 1481/1501, units 26
  6.18  [Playtest] finished armtide team 0 at 6.18 min
  6.42  [Playtest] finished armtide team 0 at 6.42 min
  6.45  [Playtest] finished armmex team 0 at 6.45 min
  6.79  [Playtest] finished armtl team 0 at 6.79 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +16.3 bank 16/1450, energy +240.0 bank 1589/1601, units 31
  7.17  [Playtest] finished armtide team 0 at 7.17 min
  7.69  [Playtest] finished armllt team 0 at 7.69 min
  7.71  [Playtest] finished armtide team 0 at 7.71 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +16.3 bank 74/1450, energy +276.5 bank 1691/1701, units 33
  8.80  [Playtest] finished armtl team 0 at 8.81 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +16.3 bank 89/1450, energy +280.0 bank 1653/1701, units 37
  9.07  [Playtest] finished armfrad team 0 at 9.07 min
  9.87  [Playtest] finished armllt team 0 at 9.87 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +16.3 bank 114/1450, energy +280.0 bank 1684/1701, units 36
 10.00  [Playtest] camera requested (2000,730) height=2200
 10.02  [Playtest] camera captured name=ta position=(2000,730) height=2200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (2000, 730)
 10.78  [Playtest] finished armnanotcplat team 0 at 10.78 min
 10.92  [Playtest] finished armtide team 0 at 10.92 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +16.3 bank 79/1450, energy +277.4 bank 1070/1751, units 39
 11.92  [Playtest] finished armtide team 0 at 11.92 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +16.3 bank 0/1450, energy +312.9 bank 1801/1801, units 39
 13.00  [Playtest] eco team 0 at 13.0 min: metal +16.3 bank 12/1450, energy +320.0 bank 1764/1801, units 39
 14.00  [Playtest] eco team 0 at 14.0 min: metal +16.3 bank 0/1450, energy +320.0 bank 1797/1801, units 41
 15.00  [Playtest] eco team 0 at 15.0 min: metal +16.3 bank 138/1450, energy +318.2 bank 1604/1801, units 39
 15.03  [Playtest] finished armtide team 0 at 15.03 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +16.3 bank 0/1450, energy +340.0 bank 1851/1851, units 41
 16.30  [Playtest] finished armtide team 0 at 16.30 min
 16.58  [Playtest] finished armtide team 0 at 16.58 min
 16.71  [Playtest] finished armtl team 0 at 16.71 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +16.3 bank 255/1450, energy +369.3 bank 1933/1951, units 43
 17.32  [Playtest] finished armtide team 0 at 17.32 min
 17.79  [Playtest] finished armrad team 0 at 17.79 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +14.2 bank 19/1400, energy +390.0 bank 1992/2001, units 42
 18.03  [Playtest] finished armtide team 0 at 18.03 min
 18.54  [Playtest] finished armestor team 0 at 18.54 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +14.2 bank 0/1400, energy +399.8 bank 7711/8051, units 42
 19.03  [Playtest] finished armnanotcplat team 0 at 19.03 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +12.2 bank 11/1350, energy +415.0 bank 8036/8051, units 40
 20.00  [Playtest] camera requested (2000,730) height=2200
```

## Native lines (all AIs, first 120)

```
  1.00  RESERVE: corridor 1 at (12784, 960) facing 3, 30x12 cells: 216 of 360 held
  1.00  RESERVE: zone 1 at (13160, 1560) facing 3, 3x3 cells: 9 of 9 held
  1.00  RESERVE: armnanotcplat at (13160, 1560) facing 3 (id 1)
  1.00  RESERVE: zone 2 at (13160, 1608) facing 3, 3x3 cells: 9 of 9 held
  1.00  RESERVE: armnanotcplat at (13160, 1608) facing 3 (id 2)
  1.00  RESERVE: zone 3 at (13160, 1656) facing 3, 3x3 cells: 9 of 9 held
  1.00  RESERVE: armnanotcplat at (13160, 1656) facing 3 (id 3)
  1.00  RESERVE: zone 4 at (13160, 1704) facing 3, 3x3 cells: 9 of 9 held
  1.00  RESERVE: armnanotcplat at (13160, 1704) facing 3 (id 4)
  1.00  RESERVE: zone 5 at (13160, 1752) facing 3, 3x3 cells: 9 of 9 held
  1.00  RESERVE: armnanotcplat at (13160, 1752) facing 3 (id 5)
  1.00  RESERVE: zone 1 released
  1.00  RESERVE: zone 2 released
  1.00  RESERVE: zone 3 released
  1.00  RESERVE: zone 4 released
  1.00  RESERVE: zone 5 released
  1.00  RESERVE: corridor 6 at (12768, 1648) facing 3, 30x12 cells: 207 of 360 held
  1.02  RESERVE: zone 2 at (12272, 864) facing 3, 12x12 cells: 144 of 144 held
  1.02  RESERVE: legadvshipyard at (12272, 864) facing 3 (id 1)
  1.02  RESERVE: corridor 3 at (11936, 864) facing 3, 30x18 cells: 450 of 540 held
  1.02  RESERVE: zone 4 at (12440, 904) facing 3, 3x3 cells: 9 of 9 held
  1.02  RESERVE: legnanotcplat at (12440, 904) facing 3 (id 2)
  1.02  RESERVE: zone 4 released
  1.02  RESERVE: zone 5 at (12392, 840) facing 3, 3x3 cells: 9 of 9 held
  1.02  RESERVE: legnanotcplat at (12392, 840) facing 3 (id 3)
  1.02  RESERVE: zone 6 at (12392, 888) facing 3, 3x3 cells: 9 of 9 held
  1.02  RESERVE: legnanotcplat at (12392, 888) facing 3 (id 4)
  1.02  RESERVE: zone 7 at (12392, 936) facing 3, 3x3 cells: 9 of 9 held
  1.02  RESERVE: legnanotcplat at (12392, 936) facing 3 (id 5)
  1.02  RESERVE: zone 5 released
  1.02  RESERVE: zone 6 released
  1.02  RESERVE: zone 7 released
  1.02  RESERVE: zone 8 at (12392, 696) facing 3, 3x3 cells: 9 of 9 held
  1.02  RESERVE: legnanotcplat at (12392, 696) facing 3 (id 6)
  1.02  RESERVE: zone 9 at (12392, 744) facing 3, 3x3 cells: 9 of 9 held
  1.02  RESERVE: legnanotcplat at (12392, 744) facing 3 (id 7)
  1.02  RESERVE: zone 10 at (12392, 792) facing 3, 3x3 cells: 9 of 9 held
  1.02  RESERVE: legnanotcplat at (12392, 792) facing 3 (id 8)
  1.02  RESERVE: zone 11 at (12392, 840) facing 3, 3x3 cells: 9 of 9 held
  1.02  RESERVE: legnanotcplat at (12392, 840) facing 3 (id 9)
  1.02  RESERVE: zone 12 at (12392, 888) facing 3, 3x3 cells: 9 of 9 held
  1.02  RESERVE: legnanotcplat at (12392, 888) facing 3 (id 10)
  1.02  RESERVE: zone 13 at (12344, 696) facing 3, 3x3 cells: 9 of 9 held
  1.02  RESERVE: legnanotcplat at (12344, 696) facing 3 (id 11)
  1.02  RESERVE: zone 14 at (12344, 744) facing 3, 3x3 cells: 9 of 9 held
  1.02  RESERVE: legnanotcplat at (12344, 744) facing 3 (id 12)
  1.02  RESERVE: zone 8 released
  1.02  RESERVE: zone 9 released
  1.02  RESERVE: zone 10 released
  1.02  RESERVE: zone 11 released
  1.02  RESERVE: zone 12 released
  1.02  RESERVE: zone 13 released
  1.02  RESERVE: zone 14 released
  1.02  RESERVE: zone 15 at (12440, 632) facing 3, 3x3 cells: 9 of 9 held
  1.02  RESERVE: legnanotcplat at (12440, 632) facing 3 (id 13)
  1.02  RESERVE: zone 16 at (12440, 680) facing 3, 3x3 cells: 9 of 9 held
  1.02  RESERVE: legnanotcplat at (12440, 680) facing 3 (id 14)
  1.02  RESERVE: zone 17 at (12440, 728) facing 3, 3x3 cells: 9 of 9 held
  1.02  RESERVE: legnanotcplat at (12440, 728) facing 3 (id 15)
  1.02  RESERVE: zone 18 at (12440, 776) facing 3, 3x3 cells: 9 of 9 held
  1.02  RESERVE: legnanotcplat at (12440, 776) facing 3 (id 16)
  1.02  RESERVE: zone 19 at (12440, 824) facing 3, 3x3 cells: 9 of 9 held
  1.02  RESERVE: legnanotcplat at (12440, 824) facing 3 (id 17)
  1.02  RESERVE: zone 20 at (12392, 632) facing 3, 3x3 cells: 9 of 9 held
  1.02  RESERVE: legnanotcplat at (12392, 632) facing 3 (id 18)
  1.02  RESERVE: zone 21 at (12392, 680) facing 3, 3x3 cells: 9 of 9 held
  1.02  RESERVE: legnanotcplat at (12392, 680) facing 3 (id 19)
  1.02  RESERVE: zone 22 at (12392, 728) facing 3, 3x3 cells: 9 of 9 held
  1.02  RESERVE: legnanotcplat at (12392, 728) facing 3 (id 20)
  1.02  RESERVE: zone 23 at (12392, 776) facing 3, 3x3 cells: 9 of 9 held
  1.02  RESERVE: legnanotcplat at (12392, 776) facing 3 (id 21)
  1.02  RESERVE: zone 24 at (12392, 824) facing 3, 3x3 cells: 9 of 9 held
  1.02  RESERVE: legnanotcplat at (12392, 824) facing 3 (id 22)
  1.02  RESERVE: zone 25 at (12344, 632) facing 3, 3x3 cells: 9 of 9 held
  1.02  RESERVE: legnanotcplat at (12344, 632) facing 3 (id 23)
  1.02  RESERVE: zone 26 at (12344, 680) facing 3, 3x3 cells: 9 of 9 held
  1.02  RESERVE: legnanotcplat at (12344, 680) facing 3 (id 24)
  1.02  RESERVE: zone 27 at (12344, 728) facing 3, 3x3 cells: 9 of 9 held
  1.02  RESERVE: legnanotcplat at (12344, 728) facing 3 (id 25)
  1.02  RESERVE: zone 15 released
  1.02  RESERVE: zone 16 released
  1.02  RESERVE: zone 17 released
  1.02  RESERVE: zone 18 released
  1.02  RESERVE: zone 19 released
  1.02  RESERVE: zone 20 released
  1.02  RESERVE: zone 21 released
  1.02  RESERVE: zone 22 released
  1.02  RESERVE: zone 23 released
  1.02  RESERVE: zone 24 released
  1.02  RESERVE: zone 25 released
  1.02  RESERVE: zone 26 released
  1.02  RESERVE: zone 27 released
  1.02  RESERVE: zone 28 at (13056, 352) facing 3, 40x40 cells: 1504 of 1600 held
  1.02  RESERVE: grid of legnanotcplat 4x4 gap 0 behind (12960, 352) facing 3: 8 of 16 slots (group 1, held, zone)
  1.02  RESERVE: zone 28 released
  1.02  RESERVE: zone 29 at (13056, 224) facing 3, 40x34 cells: 1184 of 1360 held
  1.02  RESERVE: grid of legnanotcplat 4x4 gap 0 behind (12960, 224) facing 3: 7 of 16 slots (group 2, held, zone)
  1.02  RESERVE: zone 29 released
  1.03  RESERVE: zone 30 at (12304, 1360) facing 3, 12x12 cells: 144 of 144 held
  1.03  RESERVE: legadvshipyard at (12304, 1360) facing 3 (id 41)
  1.03  RESERVE: corridor 31 at (11968, 1360) facing 3, 30x18 cells: 540 of 540 held
  1.03  RESERVE: zone 32 at (12488, 584) facing 3, 3x3 cells: 9 of 9 held
  1.03  RESERVE: legnanotcplat at (12488, 584) facing 3 (id 42)
  1.03  RESERVE: zone 33 at (12488, 632) facing 3, 3x3 cells: 9 of 9 held
  1.03  RESERVE: legnanotcplat at (12488, 632) facing 3 (id 43)
  1.03  RESERVE: zone 34 at (12488, 680) facing 3, 3x3 cells: 9 of 9 held
  1.03  RESERVE: legnanotcplat at (12488, 680) facing 3 (id 44)
  1.03  RESERVE: zone 35 at (12488, 728) facing 3, 3x3 cells: 9 of 9 held
  1.03  RESERVE: legnanotcplat at (12488, 728) facing 3 (id 45)
  1.03  RESERVE: zone 36 at (12488, 776) facing 3, 3x3 cells: 9 of 9 held
  1.03  RESERVE: legnanotcplat at (12488, 776) facing 3 (id 46)
  1.03  RESERVE: zone 37 at (12440, 584) facing 3, 3x3 cells: 9 of 9 held
  1.03  RESERVE: legnanotcplat at (12440, 584) facing 3 (id 47)
  1.03  RESERVE: zone 38 at (12440, 632) facing 3, 3x3 cells: 9 of 9 held
  1.03  RESERVE: legnanotcplat at (12440, 632) facing 3 (id 48)
  1.03  RESERVE: zone 39 at (12440, 680) facing 3, 3x3 cells: 9 of 9 held
  1.03  RESERVE: legnanotcplat at (12440, 680) facing 3 (id 49)
  1.03  RESERVE: zone 40 at (12440, 728) facing 3, 3x3 cells: 9 of 9 held
  1.03  RESERVE: legnanotcplat at (12440, 728) facing 3 (id 50)
  1.03  RESERVE: zone 41 at (12440, 776) facing 3, 3x3 cells: 9 of 9 held
```
