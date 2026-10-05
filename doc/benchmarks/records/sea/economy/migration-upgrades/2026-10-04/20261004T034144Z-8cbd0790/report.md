# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 24.4 min (frame 43834); wall 176 s
- DLL: build-theatres\d188-build-3\SkirmishAI.dll (8791d54889eef1dd); AI BARbTest/test; staged 2026-10-04T00:38:45
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\migration-upgrades\glacial\20261004T033845Z-55ff3aa1\runs\20261004T034144Z-8cbd0790\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:29.254933][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.0 min | `[t=00:00:43.923553][f=0001883] [SeaWatch] finished frame=1883 id=29104 def=armsy builder=13362` |
| expect `first-ship-exit` | seen at 3.1 min | `[t=00:00:52.441841][f=0005610] [SeaWatch] egress id=20691 yard=29104 seconds=27.4` |
| forbid `script` | **hit** | `[t=00:02:54.210823][f=0043834] Skirmish AI <BARb playtest-test>: SCRIPT CRASH: access violation in a script call of team 4 (skirmish AI 4); the script stack, innermost first:` |
| forbid `invariant` | clean |  |
| forbid `crash` | **hit** | `[t=00:02:54.211547][f=0043834] Error: Spring 2026.07.04 has crashed.` |

## Failures

- forbid 'script' hit at 24.4 min: [t=00:02:54.210823][f=0043834] Skirmish AI <BARb playtest-test>: SCRIPT CRASH: access violation in a script call of team 4 (skirmish AI 4); the script stack, innermost first:
- forbid 'crash' hit at 24.4 min: [t=00:02:54.211547][f=0043834] Error: Spring 2026.07.04 has crashed.
- forbid 'crash' hit at 24.4 min: [t=00:02:54.281545][f=0043834] Error: Exception: Access violation (0xc0000005)

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\migration-upgrades\glacial\20261004T033845Z-55ff3aa1\runs\20261004T034144Z-8cbd0790\screen_2026-10-04_03-39-50-028.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\migration-upgrades\glacial\20261004T033845Z-55ff3aa1\runs\20261004T034144Z-8cbd0790\screen_2026-10-04_03-40-11-240.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\migration-upgrades\glacial\20261004T033845Z-55ff3aa1\runs\20261004T034144Z-8cbd0790\screen_2026-10-04_03-41-14-798.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 35.5 min
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
  0.17  [Team][Roster] first mex 10229 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.17  [Team][Roster] team 1 first mex at 704,4448
  0.18  [Team][Roster] team 2 first mex at 1904,5967
  0.29  [Playtest] finished armmex team 0 at 0.29 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 818/1100, energy +30.0 bank 514/1000, units 4
  1.05  [Playtest] finished armsy team 0 at 1.05 min
  1.35  [Playtest] finished armmex team 0 at 1.35 min
  1.93  [Playtest] finished armtide team 0 at 1.93 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 985/1250, energy +53.0 bank 119/1150, units 8
  2.11  [Playtest] finished armtide team 0 at 2.11 min
  2.26  [Playtest] finished armtide team 0 at 2.26 min
  2.40  [Playtest] finished armtide team 0 at 2.40 min
  2.72  [Playtest] finished armtide team 0 at 2.72 min
  3.00  [Playtest] finished armtide team 0 at 3.00 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 560/1250, energy +159.0 bank 1454/1500, units 15
  3.02  [Playtest] finished armmex team 0 at 3.02 min
  3.45  [Playtest] finished armtide team 0 at 3.45 min
  3.54  [Playtest] finished armtide team 0 at 3.54 min
  3.74  [Playtest] finished armtide team 0 at 3.74 min
  3.78  [Playtest] finished armtide team 0 at 3.78 min
  3.81  [Playtest] finished armtide team 0 at 3.81 min
  3.87  [Playtest] finished armtide team 0 at 3.87 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 22/1300, energy +341.0 bank 1944/1950, units 24
  4.33  [Playtest] finished armfmkr team 0 at 4.33 min
  4.42  [Playtest] finished armtide team 0 at 4.42 min
  4.47  [Playtest] finished armfmkr team 0 at 4.47 min
  4.66  [Playtest] finished armfmkr team 0 at 4.66 min
  4.67  [Playtest] finished armtide team 0 at 4.67 min
  4.71  [Playtest] finished armfmkr team 0 at 4.71 min
  4.74  [Playtest] finished armfmkr team 0 at 4.74 min
  4.92  [Playtest] finished armtide team 0 at 4.92 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +15.0 bank 0/1300, energy +417.0 bank 2004/2150, units 36
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.01  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.04  [Playtest] finished armtide team 0 at 5.04 min
  5.05  [Playtest] finished armtide team 0 at 5.05 min
  5.17  [Playtest] finished armtide team 0 at 5.17 min
  5.39  [Playtest] finished armfmkr team 0 at 5.39 min
  5.44  [Playtest] finished armtide team 0 at 5.44 min
  5.67  [Playtest] finished armfmkr team 0 at 5.67 min
  5.78  [Playtest] finished armtide team 0 at 5.78 min
  5.94  [Playtest] finished armtide team 0 at 5.94 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +17.0 bank 12/1300, energy +555.0 bank 2301/2450, units 47
  6.00  [Playtest] finished armtide team 0 at 6.00 min
  6.21  [Playtest] finished armtide team 0 at 6.21 min
  6.26  [Playtest] finished armtide team 0 at 6.26 min
  6.27  [Playtest] finished armtide team 0 at 6.27 min
  6.57  [Playtest] finished armtide team 0 at 6.57 min
  6.58  [Playtest] finished armfmkr team 0 at 6.59 min
  6.65  [Playtest] finished armtide team 0 at 6.65 min
  6.70  [Playtest] finished armfmkr team 0 at 6.70 min
  6.90  [Playtest] finished armtide team 0 at 6.90 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +19.0 bank 13/1300, energy +716.0 bank 2643/2800, units 57
  7.05  [Playtest] finished armtide team 0 at 7.05 min
  7.07  [Playtest] finished armtide team 0 at 7.07 min
  7.14  [Playtest] finished armtide team 0 at 7.14 min
  7.21  [Playtest] finished armtide team 0 at 7.21 min
  7.43  [Playtest] finished armfmkr team 0 at 7.43 min
  7.52  [Playtest] finished armtide team 0 at 7.52 min
  7.55  [Playtest] finished armtide team 0 at 7.55 min
  7.55  [Playtest] finished armfmkr team 0 at 7.55 min
  7.77  [Playtest] finished armtide team 0 at 7.77 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +21.0 bank 0/1300, energy +877.0 bank 2950/3150, units 66
  8.03  [Playtest] finished armtide team 0 at 8.03 min
  8.71  [Playtest] finished armtide team 0 at 8.71 min
  8.80  [Playtest] finished armtide team 0 at 8.80 min
  8.86  [Playtest] finished armtide team 0 at 8.86 min
  8.97  [Playtest] finished armtide team 0 at 8.98 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +21.0 bank 12/1300, energy +934.5 bank 3187/3300, units 72
  9.11  [Playtest] finished armtide team 0 at 9.11 min
  9.14  [Playtest] finished armtide team 0 at 9.14 min
  9.22  [Playtest] finished armtide team 0 at 9.22 min
  9.30  [Playtest] finished armtide team 0 at 9.30 min
  9.65  [Playtest] finished armtide team 0 at 9.65 min
  9.87  [Playtest] finished armfmkr team 0 at 9.87 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +22.0 bank 203/1300, energy +1061.0 bank 3434/3550, units 78
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.02  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.07  [Playtest] finished armtide team 0 at 10.07 min
 10.17  [Playtest] finished armfmkr team 0 at 10.17 min
 10.26  [Playtest] finished armtide team 0 at 10.26 min
 10.47  [Playtest] finished armtide team 0 at 10.47 min
 10.49  [Playtest] finished armtide team 0 at 10.49 min
 10.65  [Playtest] finished armfmkr team 0 at 10.65 min
 10.72  [Playtest] finished armtide team 0 at 10.72 min
 10.74  [Playtest] finished armtide team 0 at 10.74 min
 10.90  [Playtest] finished armtide team 0 at 10.90 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +24.0 bank 257/1300, energy +1222.0 bank 3784/3900, units 87
 11.08  [Playtest] finished armtide team 0 at 11.08 min
 11.24  [Playtest] finished armtide team 0 at 11.24 min
 11.34  [Playtest] finished armfmkr team 0 at 11.34 min
 11.39  [Playtest] finished armtide team 0 at 11.39 min
 11.42  [Playtest] finished armtide team 0 at 11.42 min
 11.57  [Playtest] finished armtide team 0 at 11.57 min
 11.61  [Playtest] finished armtide team 0 at 11.61 min
 11.74  [Playtest] finished armtide team 0 at 11.74 min
 11.95  [Playtest] finished armtide team 0 at 11.95 min
 11.96  [Playtest] finished armfmkr team 0 at 11.96 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +26.0 bank 776/1300, energy +1406.0 bank 4184/4300, units 98
 12.00  [Playtest] finished armtide team 0 at 12.00 min
 12.11  [Playtest] finished armfmkr team 0 at 12.11 min
 12.13  [Playtest] finished armfmkr team 0 at 12.13 min
 12.14  [Playtest] finished armtide team 0 at 12.14 min
 12.31  [Playtest] finished armtide team 0 at 12.31 min
 12.49  [Playtest] finished armtide team 0 at 12.49 min
 12.54  [Playtest] finished armtide team 0 at 12.54 min
 12.58  [Playtest] finished armtide team 0 at 12.58 min
 12.62  [Playtest] finished armtide team 0 at 12.62 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +29.4 bank 1299/1300, energy +1567.0 bank 4604/4650, units 108
 13.40  [Playtest] finished armtide team 0 at 13.40 min
 13.44  [Playtest] finished armfmkr team 0 at 13.44 min
 13.46  [Playtest] finished armfmkr team 0 at 13.46 min
 13.50  [Playtest] finished armtide team 0 at 13.50 min
 13.76  [Playtest] finished armfmkr team 0 at 13.76 min
 13.87  [Playtest] finished armfmkr team 0 at 13.87 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +31.4 bank 1299/1300, energy +1613.0 bank 4311/4750, units 116
 14.06  [Playtest] finished armtide team 0 at 14.06 min
 14.31  [Playtest] finished armtide team 0 at 14.31 min
 14.84  [Playtest] finished armtide team 0 at 14.84 min
 14.85  [Playtest] finished armtide team 0 at 14.85 min
 14.93  [Playtest] finished armtide team 0 at 14.93 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +32.0 bank 1299/1300, energy +1728.0 bank 4897/5000, units 121
 15.30  [Playtest] finished armtide team 0 at 15.30 min
 15.43  [Playtest] finished armtide team 0 at 15.43 min
 15.62  [Playtest] finished armfmkr team 0 at 15.62 min
 15.74  [Playtest] finished armtide team 0 at 15.74 min
 15.82  [Playtest] finished armtide team 0 at 15.82 min
 15.91  [Playtest] finished armtide team 0 at 15.91 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +33.0 bank 1298/1300, energy +1843.0 bank 5144/5250, units 126
 16.02  [Playtest] finished armtide team 0 at 16.02 min
 16.91  [Playtest] finished armtide team 0 at 16.91 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +33.0 bank 1299/1300, energy +1889.0 bank 5256/5350, units 126
 17.30  [Playtest] finished armfmkr team 0 at 17.30 min
 17.40  [Playtest] finished armtide team 0 at 17.40 min
 17.51  [Playtest] finished armtide team 0 at 17.51 min
 17.56  [Playtest] finished armtide team 0 at 17.56 min
 17.78  [Playtest] finished armtide team 0 at 17.78 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +34.0 bank 1298/1300, energy +1981.0 bank 5481/5550, units 132
 18.14  [Playtest] finished armtide team 0 at 18.14 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +34.0 bank 1299/1300, energy +2004.0 bank 5549/5600, units 132
 20.00  [Playtest] eco team 0 at 20.0 min: metal +34.0 bank 1299/1300, energy +2004.0 bank 5549/5600, units 130
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.02  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
 21.00  [Playtest] eco team 0 at 21.0 min: metal +34.0 bank 1299/1300, energy +2004.0 bank 5549/5600, units 131
 22.00  [Playtest] eco team 0 at 22.0 min: metal +34.0 bank 1299/1300, energy +2004.0 bank 5552/5600, units 131
 23.00  [Playtest] eco team 0 at 23.0 min: metal +34.0 bank 1299/1300, energy +1997.0 bank 5502/5550, units 130
 24.00  [Playtest] eco team 0 at 24.0 min: metal +34.0 bank 1299/1300, energy +2004.0 bank 5552/5600, units 130
```

## Native lines (all AIs, first 120)

```
  0.09  EXP: approach: corcom(27259) at (1899, 5801) walks to (1900, 5829), 139 from the cormex site (1904, 5968)
  0.10  RESERVE: zone 1 at (1424, 4000) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (1424, 4000) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (1712, 4000) facing 1, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 1 at (704, 4592) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (704, 4592) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (992, 4592) facing 1, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 1 at (12928, 4000) facing 3, 6x6 cells: 36 of 36 held
  0.10  RESERVE: legsy at (12928, 4000) facing 3 (id 1)
  0.10  RESERVE: corridor 2 at (12640, 4000) facing 3, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 1 at (13696, 4592) facing 3, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (13696, 4592) facing 3 (id 1)
  0.10  RESERVE: corridor 2 at (13408, 4592) facing 3, 30x12 cells: 344 of 360 held
  0.10  EXP: idle: corcom(27259) on cormex at (1899, 5822), site (1904, 5968), target yes, fails 1 (arrived at the approach point)
  0.12  RESERVE: zone 3 at (1424, 3600) facing 1, 12x12 cells: 144 of 144 held
  0.12  RESERVE: armasy at (1424, 3600) facing 1 (id 2)
  0.12  RESERVE: corridor 4 at (1760, 3600) facing 1, 30x18 cells: 540 of 540 held
  0.12  RESERVE: zone 3 at (704, 4192) facing 1, 12x12 cells: 144 of 144 held
  0.12  RESERVE: armasy at (704, 4192) facing 1 (id 2)
  0.12  RESERVE: corridor 4 at (1040, 4192) facing 1, 30x18 cells: 540 of 540 held
  0.12  RESERVE: zone 3 at (12928, 4400) facing 3, 12x12 cells: 144 of 144 held
  0.12  RESERVE: legadvshipyard at (12928, 4400) facing 3 (id 2)
  0.12  RESERVE: corridor 4 at (12592, 4400) facing 3, 30x18 cells: 540 of 540 held
  0.12  RESERVE: zone 3 at (13696, 4992) facing 3, 12x12 cells: 144 of 144 held
  0.12  RESERVE: armasy at (13696, 4992) facing 3 (id 2)
  0.12  RESERVE: corridor 4 at (13360, 4992) facing 3, 30x18 cells: 540 of 540 held
  0.13  RESERVE: zone 5 at (704, 3792) facing 1, 12x12 cells: 144 of 144 held
  0.13  RESERVE: armasy at (704, 3792) facing 1 (id 3)
  0.13  RESERVE: corridor 6 at (1040, 3792) facing 1, 30x18 cells: 531 of 540 held
  0.14  RESERVE: zone 5 at (12928, 4800) facing 3, 12x12 cells: 144 of 144 held
  0.14  RESERVE: legadvshipyard at (12928, 4800) facing 3 (id 3)
  0.14  RESERVE: corridor 6 at (12592, 4800) facing 3, 30x18 cells: 540 of 540 held
  0.14  RESERVE: zone 5 at (13696, 5392) facing 1, 12x12 cells: 144 of 144 held
  0.14  RESERVE: armasy at (13696, 5392) facing 1 (id 3)
  0.14  RESERVE: corridor 6 at (14032, 5392) facing 1, 30x18 cells: 540 of 540 held
  0.17  RESERVE: zone 5 at (1424, 3296) facing 3, 12x12 cells: 144 of 144 held
  0.17  RESERVE: armasy at (1424, 3296) facing 3 (id 3)
  0.17  RESERVE: corridor 6 at (1088, 3296) facing 3, 30x18 cells: 540 of 540 held
  0.17  EXP: approach: armcom(9567) at (700, 4597) walks to (673, 4651), 136 from the armmex site (544, 4608)
  0.17  EXP: approach: armcom(1598) at (13700, 4597) walks to (13732, 4541), 136 from the armmex site (13632, 4448)
  0.17  EXP: approach: armcom(13362) at (1430, 3997) walks to (1448, 3934), 136 from the armmex site (1584, 3936)
  0.18  EXP: approach: legcom(16515) at (12925, 4000) walks to (12997, 4023), 137 from the legmex site (13088, 3920)
  0.19  EXP: approach: corcom(27259) at (1899, 5823) walks to (1882, 5821), 139 from the cormex site (1744, 5808)
  0.22  EXP: approach: corcom(9671) at (12686, 5752) walks to (12719, 5838), 139 from the cormex site (12768, 5968)
  0.29  RESERVE: served armsy at (704, 4592) facing 1 (id 1, 0 of this def still held)
  0.30  RESERVE: served armsy at (13696, 4592) facing 3 (id 1, 0 of this def still held)
  0.30  RESERVE: served armsy at (1424, 4000) facing 1 (id 1, 0 of this def still held)
  0.32  EXP: approach: corcom(27259) at (1899, 5823) walks to (1807, 6004), 139 from the cormex site (1744, 6128)
  0.32  RESERVE: served legsy at (12928, 4000) facing 3 (id 1, 0 of this def still held)
  0.39  EXP: approach: corcom(9671) at (12707, 5817) walks to (12568, 5898), 139 from the cormex site (12448, 5968)
  0.69  RESERVE: zone 7 at (344, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.69  RESERVE: armtide at (344, 4664) facing 1 (id 4)
  0.69  RESERVE: zone 8 at (344, 4600) facing 1, 3x3 cells: 9 of 9 held
  0.69  RESERVE: armtide at (344, 4600) facing 1 (id 5)
  0.69  RESERVE: zone 9 at (344, 4536) facing 1, 3x3 cells: 9 of 9 held
  0.69  RESERVE: armtide at (344, 4536) facing 1 (id 6)
  0.69  RESERVE: zone 10 at (408, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.69  RESERVE: armtide at (408, 4664) facing 1 (id 7)
  0.69  RESERVE: zone 11 at (408, 4600) facing 1, 3x3 cells: 9 of 9 held
  0.69  RESERVE: armtide at (408, 4600) facing 1 (id 8)
  0.69  RESERVE: zone 12 at (408, 4536) facing 1, 3x3 cells: 9 of 9 held
  0.69  RESERVE: armtide at (408, 4536) facing 1 (id 9)
  0.69  RESERVE: zone 13 at (382, 4597) facing 1, 9x13 cells: 63 of 117 held
  0.69  RESERVE: served armtide at (344, 4664) facing 1 (id 4, 5 of this def still held)
  0.70  RESERVE: zone 7 at (14056, 4536) facing 3, 3x3 cells: 9 of 9 held
  0.70  RESERVE: armtide at (14056, 4536) facing 3 (id 4)
  0.70  RESERVE: zone 8 at (14056, 4600) facing 3, 3x3 cells: 9 of 9 held
  0.70  RESERVE: armtide at (14056, 4600) facing 3 (id 5)
  0.70  RESERVE: zone 9 at (14056, 4664) facing 3, 3x3 cells: 9 of 9 held
  0.70  RESERVE: armtide at (14056, 4664) facing 3 (id 6)
  0.70  RESERVE: zone 10 at (13992, 4536) facing 3, 3x3 cells: 9 of 9 held
  0.70  RESERVE: armtide at (13992, 4536) facing 3 (id 7)
  0.70  RESERVE: zone 11 at (13992, 4600) facing 3, 3x3 cells: 9 of 9 held
  0.70  RESERVE: armtide at (13992, 4600) facing 3 (id 8)
  0.70  RESERVE: zone 12 at (13992, 4664) facing 3, 3x3 cells: 9 of 9 held
  0.70  RESERVE: armtide at (13992, 4664) facing 3 (id 9)
  0.70  RESERVE: zone 13 at (14018, 4597) facing 3, 9x13 cells: 63 of 117 held
  0.70  RESERVE: served armtide at (14056, 4536) facing 3 (id 4, 5 of this def still held)
  0.71  EXP: idle: armcom(13362) on armsy at (1587, 3992), site (1424, 4000), target no, fails 1
  0.72  RESERVE: zone 7 at (13272, 3944) facing 3, 3x3 cells: 9 of 9 held
  0.72  RESERVE: legtide at (13272, 3944) facing 3 (id 4)
  0.72  RESERVE: zone 8 at (13272, 4008) facing 3, 3x3 cells: 9 of 9 held
  0.72  RESERVE: legtide at (13272, 4008) facing 3 (id 5)
  0.72  RESERVE: zone 9 at (13272, 4072) facing 3, 3x3 cells: 9 of 9 held
  0.72  RESERVE: legtide at (13272, 4072) facing 3 (id 6)
  0.72  RESERVE: zone 10 at (13208, 3944) facing 3, 3x3 cells: 9 of 9 held
  0.72  RESERVE: legtide at (13208, 3944) facing 3 (id 7)
  0.72  RESERVE: zone 11 at (13208, 4008) facing 3, 3x3 cells: 9 of 9 held
  0.72  RESERVE: legtide at (13208, 4008) facing 3 (id 8)
  0.72  RESERVE: zone 12 at (13208, 4072) facing 3, 3x3 cells: 9 of 9 held
  0.72  RESERVE: legtide at (13208, 4072) facing 3 (id 9)
  0.72  RESERVE: zone 13 at (13243, 4000) facing 3, 9x12 cells: 54 of 108 held
  0.72  EXP: approach: legcom(16515) at (13058, 4029) walks to (13145, 3994), 137 from the legtide site (13272, 3944)
  0.72  RESERVE: served legtide at (13272, 3944) facing 3 (id 4, 5 of this def still held)
  0.75  EXP: idle: armcom(13362) on armsy at (1542, 4020), site (1424, 4000), target no, fails 2
  0.83  RESERVE: zone 1 at (13352, 5368) facing 3, 3x3 cells: 9 of 9 held
  0.83  RESERVE: cortide at (13352, 5368) facing 3 (id 1)
  0.83  RESERVE: zone 1 released
  0.90  RESERVE: zone 2 at (13240, 5176) facing 3, 3x3 cells: 9 of 9 held
  0.90  RESERVE: cortide at (13240, 5176) facing 3 (id 2)
  0.90  RESERVE: zone 3 at (13240, 5240) facing 3, 3x3 cells: 9 of 9 held
  0.90  RESERVE: cortide at (13240, 5240) facing 3 (id 3)
  0.90  RESERVE: zone 2 released
  0.90  RESERVE: zone 3 released
  0.90  RESERVE: zone 4 at (13432, 5304) facing 3, 3x3 cells: 9 of 9 held
  0.90  RESERVE: cortide at (13432, 5304) facing 3 (id 4)
  0.90  RESERVE: zone 5 at (13432, 5368) facing 3, 3x3 cells: 9 of 9 held
  0.90  RESERVE: cortide at (13432, 5368) facing 3 (id 5)
  0.90  RESERVE: zone 4 released
  0.90  RESERVE: zone 5 released
  0.90  RESERVE: zone 1 at (1288, 5240) facing 1, 3x3 cells: 9 of 9 held
  0.90  RESERVE: cortide at (1288, 5240) facing 1 (id 1)
  0.90  RESERVE: zone 2 at (1288, 5176) facing 1, 3x3 cells: 9 of 9 held
  0.90  RESERVE: cortide at (1288, 5176) facing 1 (id 2)
  0.90  RESERVE: zone 3 at (1288, 5112) facing 1, 3x3 cells: 9 of 9 held
  0.90  RESERVE: cortide at (1288, 5112) facing 1 (id 3)
  0.90  RESERVE: zone 4 at (1352, 5240) facing 1, 3x3 cells: 9 of 9 held
  0.90  RESERVE: cortide at (1352, 5240) facing 1 (id 4)
  0.90  RESERVE: zone 5 at (1352, 5176) facing 1, 3x3 cells: 9 of 9 held
  0.90  RESERVE: cortide at (1352, 5176) facing 1 (id 5)
```
