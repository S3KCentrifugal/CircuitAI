# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54061); wall 172 s
- DLL: build-theatres\d188-build-4\SkirmishAI.dll (4269e12be49092f4); AI BARbTest/test; staged 2026-10-04T01:24:47
- Map: Erebos Lakes v1.0; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\erebos\20261004T042446Z-66d49ff1\runs\20261004T042741Z-4e0afe11\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:36.319676][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.7 min | `[t=00:00:52.874030][f=0003112] [SeaWatch] finished frame=3112 id=18473 def=armsy builder=13647` |
| expect `first-ship-exit` | seen at 3.2 min | `[t=00:00:58.987646][f=0005820] [SeaWatch] egress id=28295 yard=18473 seconds=23.7 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\erebos\20261004T042446Z-66d49ff1\runs\20261004T042741Z-4e0afe11\screen_2026-10-04_04-25-57-655.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\erebos\20261004T042446Z-66d49ff1\runs\20261004T042741Z-4e0afe11\screen_2026-10-04_04-26-18-644.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\erebos\20261004T042446Z-66d49ff1\runs\20261004T042741Z-4e0afe11\screen_2026-10-04_04-26-59-636.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\erebos\20261004T042446Z-66d49ff1\runs\20261004T042741Z-4e0afe11\screen_2026-10-04_04-27-36-622.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (2076, 6352) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (8128, 3879) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (2076, 6352) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (8128, 3879) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.20  [Playtest] finished armmex team 0 at 0.20 min
  0.20  [Team][Roster] first mex 28916 at 2032,6192
  0.20  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|2076|6349|0|3|1|2032|6192
  0.36  [Playtest] finished armmex team 0 at 0.36 min
  0.53  [Playtest] finished armmex team 0 at 0.53 min
  0.77  [Playtest] finished armwin team 0 at 0.77 min
  0.90  [SEA][Layout] berth sea.berth.0 armsy at=2608,6128 facing=1
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 1150/1150, energy +36.9 bank 756/1000, units 5
  1.22  [Playtest] finished armmex team 0 at 1.22 min
  1.73  [Playtest] finished armsy team 0 at 1.73 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +10.0 bank 982/1300, energy +46.0 bank 118/1100, units 8
  2.10  [SEA][Layout] berth sea.berth.1 armasy at=2688,5344 facing=0
  2.37  [Playtest] finished armmex team 0 at 2.37 min
  2.64  [Playtest] finished armwin team 0 at 2.64 min
  2.79  [Playtest] finished armwin team 0 at 2.79 min
  2.96  [Playtest] finished armwin team 0 at 2.96 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +12.0 bank 1344/1350, energy +100.7 bank 135/1152, units 14
  3.17  [Playtest] finished armmex team 0 at 3.17 min
  3.41  [Playtest] finished armmex team 0 at 3.41 min
  3.85  [Playtest] finished armwin team 0 at 3.85 min
  3.94  [Playtest] finished armmex team 0 at 3.94 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +19.0 bank 1479/1500, energy +104.3 bank 106/1202, units 21
  4.23  [Playtest] finished armmex team 0 at 4.23 min
  4.42  [Playtest] finished armmex team 0 at 4.43 min
  4.79  [Playtest] finished armtl team 0 at 4.79 min
  4.80  [Playtest] finished armwin team 0 at 4.80 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +22.0 bank 1597/1600, energy +137.5 bank 68/1203, units 25
  5.00  [Playtest] target team 0 at (2076, 6352) from its start position
  5.00  [Playtest] camera requested (2076,6352) height=2200
  5.01  [Playtest] camera captured name=ta position=(2076,6352) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (2076, 6352)
  5.06  [Playtest] finished armfrad team 0 at 5.06 min
  5.28  [Playtest] finished armmex team 0 at 5.28 min
  5.84  [Playtest] finished armtl team 0 at 5.84 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +24.0 bank 1648/1650, energy +137.6 bank 290/1203, units 28
  6.23  [Playtest] finished armllt team 0 at 6.23 min
  6.88  [Playtest] finished armmex team 0 at 6.88 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +26.0 bank 1698/1700, energy +139.9 bank 151/1203, units 32
  7.99  [Playtest] finished armmex team 0 at 7.99 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +21.0 bank 1720/1750, energy +78.7 bank 18/1203, units 34
  8.36  [Playtest] finished armmex team 0 at 8.36 min
  8.92  [Playtest] finished armwin team 0 at 8.92 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +30.0 bank 1798/1800, energy +153.4 bank 95/1203, units 32
  9.06  [Playtest] finished armwin team 0 at 9.06 min
  9.75  [Playtest] finished armmex team 0 at 9.75 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +30.0 bank 1799/1800, energy +170.5 bank 535/1204, units 32
 10.00  [Playtest] camera requested (2076,6352) height=2200
 10.01  [Playtest] camera captured name=ta position=(2076,6352) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (2076, 6352)
 10.38  [Playtest] finished armwin team 0 at 10.38 min
 10.65  [SEA][Layout] berth sea.berth.2 armasy at=3056,5152 facing=0
 11.00  [Playtest] eco team 0 at 11.0 min: metal +24.0 bank 900/850, energy +142.6 bank 503/502, units 15
 12.00  [Playtest] eco team 0 at 12.0 min: metal +0.0 bank 500/500, energy +0.0 bank 500/500, units 0
 13.00  [Playtest] eco team 0 at 13.0 min: metal +0.0 bank 500/500, energy +0.0 bank 500/500, units 0
 14.00  [Playtest] eco team 0 at 14.0 min: metal +0.0 bank 500/500, energy +0.0 bank 500/500, units 0
 15.00  [Playtest] eco team 0 at 15.0 min: metal +0.0 bank 500/500, energy +0.0 bank 500/500, units 0
 16.00  [Playtest] eco team 0 at 16.0 min: metal +0.0 bank 500/500, energy +0.0 bank 500/500, units 0
 17.00  [Playtest] eco team 0 at 17.0 min: metal +0.0 bank 500/500, energy +0.0 bank 500/500, units 0
 18.00  [Playtest] eco team 0 at 18.0 min: metal +0.0 bank 500/500, energy +0.0 bank 500/500, units 0
 19.00  [Playtest] eco team 0 at 19.0 min: metal +0.0 bank 500/500, energy +0.0 bank 500/500, units 0
 20.00  [Playtest] eco team 0 at 20.0 min: metal +0.0 bank 500/500, energy +0.0 bank 500/500, units 0
 20.00  [Playtest] camera requested (2076,6352) height=2200
 20.00  [Playtest] camera captured name=ta position=(2076,6352) height=2200
 20.00  [Playtest] screenshot at 20.0 min of team 0 at (2076, 6352)
 21.00  [Playtest] eco team 0 at 21.0 min: metal +0.0 bank 500/500, energy +0.0 bank 500/500, units 0
 22.00  [Playtest] eco team 0 at 22.0 min: metal +0.0 bank 500/500, energy +0.0 bank 500/500, units 0
 23.00  [Playtest] eco team 0 at 23.0 min: metal +0.0 bank 500/500, energy +0.0 bank 500/500, units 0
 24.00  [Playtest] eco team 0 at 24.0 min: metal +0.0 bank 500/500, energy +0.0 bank 500/500, units 0
 25.00  [Playtest] eco team 0 at 25.0 min: metal +0.0 bank 500/500, energy +0.0 bank 500/500, units 0
 26.00  [Playtest] eco team 0 at 26.0 min: metal +0.0 bank 500/500, energy +0.0 bank 500/500, units 0
 27.00  [Playtest] eco team 0 at 27.0 min: metal +0.0 bank 500/500, energy +0.0 bank 500/500, units 0
 28.00  [Playtest] eco team 0 at 28.0 min: metal +0.0 bank 500/500, energy +0.0 bank 500/500, units 0
 29.00  [Playtest] eco team 0 at 29.0 min: metal +0.0 bank 500/500, energy +0.0 bank 500/500, units 0
 29.00  [Playtest] camera requested (2076,6352) height=2200
 29.00  [Playtest] camera captured name=ta position=(2076,6352) height=2200
 29.00  [Playtest] screenshot at 29.0 min of team 0 at (2076, 6352)
 30.00  [Playtest] eco team 0 at 30.0 min: metal +0.0 bank 500/500, energy +0.0 bank 500/500, units 0
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(13647) at (2076, 6349) walks to (2069, 6323), 136 from the armmex site (2032, 6192)
  0.08  EXP: approach: armcom(6127) at (8103, 3868) walks to (8078, 3859), 136 from the armmex site (7952, 3808)
  0.12  EXP: idle: armcom(13647) on armmex at (2063, 6332), site (2032, 6192), target yes, fails 2 (arrived at the approach point)
  0.21  EXP: approach: armcom(13647) at (2063, 6332) walks to (2028, 6383), 136 from the armmex site (1952, 6496)
  0.28  EXP: approach: armcom(6127) at (8013, 3831) walks to (8158, 3785), 136 from the armmex site (8288, 3744)
  0.37  EXP: approach: armcom(13647) at (2044, 6362) walks to (2157, 6394), 136 from the armmex site (2288, 6432)
  0.48  EXP: approach: armcom(6127) at (8131, 3789) walks to (8169, 3918), 136 from the armmex site (8208, 4048)
  0.55  RESERVE: zone 1 at (1720, 6408) facing 1, 3x3 cells: 9 of 9 held
  0.55  RESERVE: armwin at (1720, 6408) facing 1 (id 1)
  0.55  RESERVE: zone 2 at (1720, 6344) facing 1, 3x3 cells: 9 of 9 held
  0.55  RESERVE: armwin at (1720, 6344) facing 1 (id 2)
  0.55  RESERVE: zone 3 at (1720, 6280) facing 1, 3x3 cells: 9 of 9 held
  0.55  RESERVE: armwin at (1720, 6280) facing 1 (id 3)
  0.55  RESERVE: zone 4 at (1784, 6408) facing 1, 3x3 cells: 9 of 9 held
  0.55  RESERVE: armwin at (1784, 6408) facing 1 (id 4)
  0.55  RESERVE: zone 5 at (1784, 6344) facing 1, 3x3 cells: 9 of 9 held
  0.55  RESERVE: armwin at (1784, 6344) facing 1 (id 5)
  0.55  RESERVE: zone 6 at (1784, 6280) facing 1, 3x3 cells: 9 of 9 held
  0.55  RESERVE: armwin at (1784, 6280) facing 1 (id 6)
  0.55  RESERVE: zone 7 at (1758, 6349) facing 1, 9x13 cells: 63 of 117 held
  0.55  RESERVE: served armwin at (1720, 6408) facing 1 (id 1, 5 of this def still held)
  0.66  RESERVE: zone 1 at (8456, 3800) facing 3, 3x3 cells: 9 of 9 held
  0.66  RESERVE: armwin at (8456, 3800) facing 3 (id 1)
  0.66  RESERVE: zone 2 at (8456, 3864) facing 3, 3x3 cells: 9 of 9 held
  0.66  RESERVE: armwin at (8456, 3864) facing 3 (id 2)
  0.66  RESERVE: zone 3 at (8456, 3928) facing 3, 3x3 cells: 9 of 9 held
  0.66  RESERVE: armwin at (8456, 3928) facing 3 (id 3)
  0.66  RESERVE: zone 4 at (8392, 3800) facing 3, 3x3 cells: 9 of 9 held
  0.66  RESERVE: armwin at (8392, 3800) facing 3 (id 4)
  0.66  RESERVE: zone 5 at (8392, 3864) facing 3, 3x3 cells: 9 of 9 held
  0.66  RESERVE: armwin at (8392, 3864) facing 3 (id 5)
  0.66  RESERVE: zone 6 at (8392, 3928) facing 3, 3x3 cells: 9 of 9 held
  0.66  RESERVE: armwin at (8392, 3928) facing 3 (id 6)
  0.66  RESERVE: zone 7 at (8421, 3868) facing 3, 9x13 cells: 63 of 117 held
  0.66  RESERVE: served armwin at (8456, 3800) facing 3 (id 1, 5 of this def still held)
  0.79  EXP: approach: armcom(13647) at (1877, 6396) walks to (2489, 6734), 136 from the armmex site (2608, 6800)
  0.85  EXP: approach: armcom(6127) at (8301, 3855) walks to (8320, 3856), 136 from the armwin site (8456, 3864)
  0.85  RESERVE: served armwin at (8456, 3864) facing 3 (id 2, 4 of this def still held)
  0.90  RESERVE: zone 8 at (2608, 6128) facing 1, 6x6 cells: 36 of 36 held
  0.90  RESERVE: armsy at (2608, 6128) facing 1 (id 7)
  0.90  RESERVE: corridor 9 at (2896, 6128) facing 1, 30x12 cells: 360 of 360 held
  0.93  RESERVE: zone 10 at (2584, 6200) facing 1, 3x3 cells: 9 of 9 held
  0.93  RESERVE: armnanotcplat at (2584, 6200) facing 1 (id 8)
  0.93  RESERVE: zone 10 released
  0.95  RESERVE: zone 11 at (2456, 6008) facing 1, 3x3 cells: 9 of 9 held
  0.95  RESERVE: armnanotcplat at (2456, 6008) facing 1 (id 9)
  0.95  RESERVE: zone 12 at (2456, 5944) facing 1, 3x3 cells: 9 of 9 held
  0.95  RESERVE: armnanotcplat at (2456, 5944) facing 1 (id 10)
  0.95  RESERVE: zone 13 at (2456, 5880) facing 1, 3x3 cells: 9 of 9 held
  0.95  RESERVE: armnanotcplat at (2456, 5880) facing 1 (id 11)
  0.95  RESERVE: zone 14 at (2520, 6008) facing 1, 3x3 cells: 9 of 9 held
  0.95  RESERVE: armnanotcplat at (2520, 6008) facing 1 (id 12)
  0.95  RESERVE: zone 15 at (2520, 5944) facing 1, 3x3 cells: 9 of 9 held
  0.95  RESERVE: armnanotcplat at (2520, 5944) facing 1 (id 13)
  0.95  RESERVE: zone 16 at (2520, 5880) facing 1, 3x3 cells: 9 of 9 held
  0.95  RESERVE: armnanotcplat at (2520, 5880) facing 1 (id 14)
  0.95  RESERVE: zone 17 at (2489, 5951) facing 1, 9x13 cells: 63 of 117 held
  0.95  RESERVE: zone 8 at (7632, 4336) facing 3, 6x6 cells: 36 of 36 held
  0.95  RESERVE: armsy at (7632, 4336) facing 3 (id 7)
  0.95  RESERVE: corridor 9 at (7344, 4336) facing 3, 30x12 cells: 352 of 360 held
  0.97  EXP: approach: armcom(6127) at (8301, 3855) walks to (7769, 4238), 169 from the armsy site (7632, 4336)
  0.97  RESERVE: served armsy at (7632, 4336) facing 3 (id 7, 0 of this def still held)
  0.98  RESERVE: zone 10 at (7784, 4456) facing 3, 3x3 cells: 9 of 9 held
  0.98  RESERVE: armnanotcplat at (7784, 4456) facing 3 (id 8)
  0.98  RESERVE: zone 11 at (7784, 4520) facing 3, 3x3 cells: 9 of 9 held
  0.98  RESERVE: armnanotcplat at (7784, 4520) facing 3 (id 9)
  0.98  RESERVE: zone 12 at (7784, 4584) facing 3, 3x3 cells: 9 of 9 held
  0.98  RESERVE: armnanotcplat at (7784, 4584) facing 3 (id 10)
  0.98  RESERVE: zone 10 released
  0.98  RESERVE: zone 11 released
  0.98  RESERVE: zone 12 released
  1.02  RESERVE: zone 13 at (7752, 4536) facing 3, 3x3 cells: 9 of 9 held
  1.02  RESERVE: armnanotcplat at (7752, 4536) facing 3 (id 11)
  1.02  RESERVE: zone 14 at (7752, 4600) facing 3, 3x3 cells: 9 of 9 held
  1.02  RESERVE: armnanotcplat at (7752, 4600) facing 3 (id 12)
  1.02  RESERVE: zone 13 released
  1.02  RESERVE: zone 14 released
  1.03  RESERVE: zone 15 at (7592, 4168) facing 3, 3x3 cells: 9 of 9 held
  1.03  RESERVE: armnanotcplat at (7592, 4168) facing 3 (id 13)
  1.03  RESERVE: zone 15 released
  1.10  RESERVE: zone 16 at (7784, 4456) facing 3, 3x3 cells: 9 of 9 held
  1.10  RESERVE: armnanotcplat at (7784, 4456) facing 3 (id 14)
  1.10  RESERVE: zone 17 at (7784, 4520) facing 3, 3x3 cells: 9 of 9 held
  1.10  RESERVE: armnanotcplat at (7784, 4520) facing 3 (id 15)
  1.10  RESERVE: zone 18 at (7784, 4584) facing 3, 3x3 cells: 9 of 9 held
  1.10  RESERVE: armnanotcplat at (7784, 4584) facing 3 (id 16)
  1.10  RESERVE: zone 16 released
  1.10  RESERVE: zone 17 released
  1.10  RESERVE: zone 18 released
  1.13  RESERVE: zone 19 at (7752, 4536) facing 3, 3x3 cells: 9 of 9 held
  1.13  RESERVE: armnanotcplat at (7752, 4536) facing 3 (id 17)
  1.13  RESERVE: zone 20 at (7752, 4600) facing 3, 3x3 cells: 9 of 9 held
  1.13  RESERVE: armnanotcplat at (7752, 4600) facing 3 (id 18)
  1.13  RESERVE: zone 19 released
  1.13  RESERVE: zone 20 released
  1.15  RESERVE: zone 21 at (7592, 4168) facing 3, 3x3 cells: 9 of 9 held
  1.15  RESERVE: armnanotcplat at (7592, 4168) facing 3 (id 19)
  1.15  RESERVE: zone 21 released
  1.22  RESERVE: zone 22 at (7784, 4456) facing 3, 3x3 cells: 9 of 9 held
  1.22  RESERVE: armnanotcplat at (7784, 4456) facing 3 (id 20)
  1.22  RESERVE: zone 23 at (7784, 4520) facing 3, 3x3 cells: 9 of 9 held
  1.22  RESERVE: armnanotcplat at (7784, 4520) facing 3 (id 21)
  1.22  RESERVE: zone 24 at (7784, 4584) facing 3, 3x3 cells: 9 of 9 held
  1.22  RESERVE: armnanotcplat at (7784, 4584) facing 3 (id 22)
  1.22  RESERVE: zone 22 released
  1.22  RESERVE: zone 23 released
  1.22  RESERVE: zone 24 released
  1.23  EXP: approach: armcom(13647) at (2452, 6730) walks to (2566, 6291), 169 from the armsy site (2608, 6128)
  1.23  RESERVE: served armsy at (2608, 6128) facing 1 (id 7, 0 of this def still held)
  1.25  RESERVE: zone 25 at (7752, 4536) facing 3, 3x3 cells: 9 of 9 held
  1.25  RESERVE: armnanotcplat at (7752, 4536) facing 3 (id 23)
  1.25  RESERVE: zone 26 at (7752, 4600) facing 3, 3x3 cells: 9 of 9 held
  1.25  RESERVE: armnanotcplat at (7752, 4600) facing 3 (id 24)
  1.25  RESERVE: zone 25 released
  1.25  RESERVE: zone 26 released
  1.27  RESERVE: zone 27 at (7592, 4168) facing 3, 3x3 cells: 9 of 9 held
  1.27  RESERVE: armnanotcplat at (7592, 4168) facing 3 (id 25)
  1.27  RESERVE: zone 27 released
  1.33  RESERVE: zone 28 at (7784, 4456) facing 3, 3x3 cells: 9 of 9 held
  1.33  RESERVE: armnanotcplat at (7784, 4456) facing 3 (id 26)
```
