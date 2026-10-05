# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 15.2 min (frame 27421); wall 110 s
- DLL: build-theatres\d192-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T15:09:36
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: allied-bases-supplied.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\allied-bases-supplied\glacial\20261004T180935Z-24492424\runs\20261004T181129Z-fcbeb64e\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `yard-0` | **missing** (by 15 min) | |
| expect `yard-1` | seen at 11.2 min | `[t=00:01:30.456094][f=0020248] [BaseWatch] PASS forward yard team=1 unit=armasy rear=260 eco=-194.73801 facing=1 expected=1` |
| expect `yard-2` | **missing** (by 15 min) | |
| expect `clusters` | seen at 14.0 min | `[t=00:01:41.719707][f=0025200] [BaseWatch] PASS cluster observation complete count=4` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `probe` | clean |  |
| forbid `crash` | clean |  |

## Failures

- 'yard-0' not seen by 15.0 min
- 'yard-2' not seen by 15.0 min

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\allied-bases-supplied\glacial\20261004T180935Z-24492424\runs\20261004T181129Z-fcbeb64e\screen_2026-10-04_18-10-35-292.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\allied-bases-supplied\glacial\20261004T180935Z-24492424\runs\20261004T181129Z-fcbeb64e\screen_2026-10-04_18-10-48-392.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\allied-bases-supplied\glacial\20261004T180935Z-24492424\runs\20261004T181129Z-fcbeb64e\screen_2026-10-04_18-11-05-883.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\allied-bases-supplied\glacial\20261004T180935Z-24492424\runs\20261004T181129Z-fcbeb64e\screen_2026-10-04_18-11-23-134.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 15.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
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
  0.17  [Team][Roster] first mex 25616 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.17  [Team][Roster] team 2 first mex at 1904,5967
  0.27  [Playtest] finished armmex team 0 at 0.27 min
  0.33  [Playtest] finished armsy team 0 at 0.33 min
  0.53  [Playtest] finished armmex team 0 at 0.53 min
  0.60  [Playtest] finished armmex team 0 at 0.60 min
  0.80  [Playtest] finished armnanotcplat team 0 at 0.80 min
  0.82  [Playtest] finished armnanotcplat team 0 at 0.82 min
  0.90  [Playtest] finished armnanotcplat team 0 at 0.90 min
  0.98  [Playtest] finished armtide team 0 at 0.98 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +10.0 bank 99296/100300, energy +136.5 bank 990936/1000700, units 20
  1.10  [Playtest] finished armtide team 0 at 1.10 min
  1.16  [Playtest] finished armtide team 0 at 1.16 min
  1.23  [Playtest] finished armtide team 0 at 1.23 min
  1.30  [Playtest] finished armtide team 0 at 1.30 min
  1.37  [Playtest] finished armtide team 0 at 1.37 min
  1.43  [Playtest] finished armtide team 0 at 1.43 min
  1.51  [Playtest] finished armtide team 0 at 1.51 min
  1.58  [Playtest] finished armtide team 0 at 1.58 min
  1.58  [Playtest] finished armtide team 0 at 1.58 min
  1.58  [SEA][Layout] berth sea.berth.0 armasy at=1632,3792 facing=1
  1.88  [Playtest] finished armtide team 0 at 1.88 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +10.0 bank 99288/100300, energy +378.0 bank 1001187/1001200, units 35
  2.00  [Playtest] finished armtide team 0 at 2.00 min
  2.41  [Playtest] finished armtide team 0 at 2.41 min
  2.41  [Playtest] finished armtide team 0 at 2.41 min
  2.99  [Playtest] finished armnanotcplat team 0 at 2.99 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +11.5 bank 99212/100300, energy +447.0 bank 1001134/1001350, units 38
  3.00  [Playtest] camera requested (1500,4600) height=3500
  3.01  [Playtest] camera captured name=ta position=(1500,4600) height=3500
  3.01  [Playtest] screenshot at 3.0 min of team 0 at (1500, 4600)
  3.74  [Playtest] finished armnanotcplat team 0 at 3.74 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 99295/100300, energy +447.0 bank 1001302/1001350, units 38
  4.00  [Playtest] finished armnanotcplat team 0 at 4.00 min
  4.22  [Playtest] finished armnanotcplat team 0 at 4.22 min
  4.52  [Playtest] finished armuwmmm team 0 at 4.52 min
  4.69  [Playtest] finished armnanotcplat team 0 at 4.69 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +20.3 bank 99307/100300, energy +447.0 bank 990742/1001350, units 41
  5.89  [Playtest] finished armuwmmm team 0 at 5.89 min
  5.99  [Playtest] finished armnanotcplat team 0 at 5.99 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +34.2 bank 99478/100300, energy +447.0 bank 981533/1001350, units 41
  6.00  [Playtest] camera requested (1500,4600) height=3500
  6.00  [Playtest] camera captured name=ta position=(1500,4600) height=3500
  6.00  [Playtest] screenshot at 6.0 min of team 0 at (1500, 4600)
  6.16  [Playtest] finished armuwmmm team 0 at 6.16 min
  6.32  [Playtest] finished armnanotcplat team 0 at 6.32 min
  6.54  [Playtest] finished armnanotcplat team 0 at 6.54 min
  6.79  [Playtest] finished armnanotcplat team 0 at 6.79 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +42.0 bank 100295/100300, energy +447.0 bank 887268/1001350, units 46
  7.07  [Playtest] finished armnanotcplat team 0 at 7.07 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +41.0 bank 100295/100300, energy +447.0 bank 784809/1001350, units 48
  8.53  [Playtest] finished armuwmmm team 0 at 8.53 min
  8.55  [Playtest] finished armnanotcplat team 0 at 8.55 min
  8.61  [Playtest] finished armnanotcplat team 0 at 8.61 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +16.2 bank 99284/100300, energy +447.0 bank 751026/1001350, units 51
  9.27  [Playtest] finished armnanotcplat team 0 at 9.27 min
  9.78  [Playtest] finished armuwfus team 0 at 9.78 min
  9.87  [Playtest] finished armnanotcplat team 0 at 9.86 min
  9.92  [Playtest] finished armnanotcplat team 0 at 9.92 min
  9.96  [Playtest] finished armnanotcplat team 0 at 9.96 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +39.2 bank 99328/100300, energy +1647.0 bank 753699/1003850, units 52
 10.00  [Playtest] camera requested (1500,4600) height=3500
 10.01  [Playtest] camera captured name=ta position=(1500,4600) height=3500
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (1500, 4600)
 10.14  [Playtest] finished armtide team 0 at 10.14 min
 10.21  [Playtest] finished armtide team 0 at 10.21 min
 10.26  [Playtest] finished armtide team 0 at 10.26 min
 10.36  [Playtest] finished armtide team 0 at 10.36 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +40.8 bank 99811/100300, energy +1739.0 bank 753901/1004050, units 55
 12.00  [Playtest] eco team 0 at 12.0 min: metal +40.8 bank 100300/100300, energy +1739.0 bank 753901/1004050, units 55
 13.00  [Playtest] eco team 0 at 13.0 min: metal +40.8 bank 100300/100300, energy +1739.0 bank 753901/1004050, units 55
 14.00  [Playtest] eco team 0 at 14.0 min: metal +40.8 bank 100300/100300, energy +1739.0 bank 753901/1004050, units 55
 14.00  [Playtest] camera requested (1500,4600) height=3500
 14.01  [Playtest] camera captured name=ta position=(1500,4600) height=3500
 14.01  [Playtest] screenshot at 14.0 min of team 0 at (1500, 4600)
 15.00  [Playtest] eco team 0 at 15.0 min: metal +40.8 bank 100300/100300, energy +1739.0 bank 753901/1004050, units 55
```

## Native lines (all AIs, first 120)

```
  0.35  RESERVE: zone 1 at (1224, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (1224, 4008) facing 1 (id 1)
  0.35  RESERVE: zone 1 released
  0.35  RESERVE: zone 2 at (1176, 3944) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (1176, 3944) facing 1 (id 2)
  0.35  RESERVE: zone 3 at (1176, 3896) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (1176, 3896) facing 1 (id 3)
  0.35  RESERVE: zone 4 at (1176, 3848) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (1176, 3848) facing 1 (id 4)
  0.35  RESERVE: zone 5 at (1176, 3800) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (1176, 3800) facing 1 (id 5)
  0.35  RESERVE: zone 6 at (1176, 3752) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (1176, 3752) facing 1 (id 6)
  0.35  RESERVE: zone 2 released
  0.35  RESERVE: zone 3 released
  0.35  RESERVE: zone 4 released
  0.35  RESERVE: zone 5 released
  0.35  RESERVE: zone 6 released
  0.35  RESERVE: zone 7 at (1160, 3864) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (1160, 3864) facing 1 (id 7)
  0.35  RESERVE: zone 8 at (1160, 3816) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (1160, 3816) facing 1 (id 8)
  0.35  RESERVE: zone 9 at (1160, 3768) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (1160, 3768) facing 1 (id 9)
  0.35  RESERVE: zone 10 at (1160, 3720) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (1160, 3720) facing 1 (id 10)
  0.35  RESERVE: zone 7 released
  0.35  RESERVE: zone 8 released
  0.35  RESERVE: zone 9 released
  0.35  RESERVE: zone 10 released
  0.35  RESERVE: zone 11 at (1176, 3800) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (1176, 3800) facing 1 (id 11)
  0.35  RESERVE: zone 12 at (1176, 3752) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (1176, 3752) facing 1 (id 12)
  0.35  RESERVE: zone 13 at (1176, 3704) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (1176, 3704) facing 1 (id 13)
  0.35  RESERVE: zone 11 released
  0.35  RESERVE: zone 12 released
  0.35  RESERVE: zone 13 released
  0.35  RESERVE: zone 14 at (1224, 3736) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (1224, 3736) facing 1 (id 14)
  0.35  RESERVE: zone 15 at (1224, 3688) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (1224, 3688) facing 1 (id 15)
  0.35  RESERVE: zone 14 released
  0.35  RESERVE: zone 15 released
  0.35  RESERVE: corridor 16 at (1430, 4285) facing 0, 13x31 cells: 273 of 403 held
  0.35  RESERVE: zone 1 at (488, 4600) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (488, 4600) facing 1 (id 1)
  0.35  RESERVE: zone 2 at (488, 4552) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (488, 4552) facing 1 (id 2)
  0.35  RESERVE: zone 3 at (488, 4504) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (488, 4504) facing 1 (id 3)
  0.35  RESERVE: zone 4 at (488, 4456) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (488, 4456) facing 1 (id 4)
  0.35  RESERVE: zone 5 at (488, 4408) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (488, 4408) facing 1 (id 5)
  0.35  RESERVE: zone 1 released
  0.35  RESERVE: zone 2 released
  0.35  RESERVE: zone 3 released
  0.35  RESERVE: zone 4 released
  0.35  RESERVE: zone 5 released
  0.35  RESERVE: zone 6 at (456, 4536) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (456, 4536) facing 1 (id 6)
  0.35  RESERVE: zone 7 at (456, 4488) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (456, 4488) facing 1 (id 7)
  0.35  RESERVE: zone 8 at (456, 4440) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (456, 4440) facing 1 (id 8)
  0.35  RESERVE: zone 9 at (456, 4392) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (456, 4392) facing 1 (id 9)
  0.35  RESERVE: zone 10 at (456, 4344) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (456, 4344) facing 1 (id 10)
  0.35  RESERVE: zone 11 at (504, 4536) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (504, 4536) facing 1 (id 11)
  0.35  RESERVE: zone 12 at (504, 4488) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (504, 4488) facing 1 (id 12)
  0.35  RESERVE: zone 13 at (504, 4440) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (504, 4440) facing 1 (id 13)
  0.35  RESERVE: zone 14 at (504, 4392) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (504, 4392) facing 1 (id 14)
  0.35  RESERVE: zone 15 at (504, 4344) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (504, 4344) facing 1 (id 15)
  0.35  RESERVE: zone 6 released
  0.35  RESERVE: zone 7 released
  0.35  RESERVE: zone 8 released
  0.35  RESERVE: zone 9 released
  0.35  RESERVE: zone 10 released
  0.35  RESERVE: zone 11 released
  0.35  RESERVE: zone 12 released
  0.35  RESERVE: zone 13 released
  0.35  RESERVE: zone 14 released
  0.35  RESERVE: zone 15 released
  0.35  RESERVE: zone 16 at (440, 4472) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (440, 4472) facing 1 (id 16)
  0.35  RESERVE: zone 17 at (440, 4424) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (440, 4424) facing 1 (id 17)
  0.35  RESERVE: zone 18 at (440, 4376) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (440, 4376) facing 1 (id 18)
  0.35  RESERVE: zone 19 at (440, 4328) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (440, 4328) facing 1 (id 19)
  0.35  RESERVE: zone 16 released
  0.35  RESERVE: zone 17 released
  0.35  RESERVE: zone 18 released
  0.35  RESERVE: zone 19 released
  0.35  RESERVE: zone 20 at (456, 4392) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (456, 4392) facing 1 (id 20)
  0.35  RESERVE: zone 21 at (456, 4344) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (456, 4344) facing 1 (id 21)
  0.35  RESERVE: zone 22 at (456, 4296) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (456, 4296) facing 1 (id 22)
  0.35  RESERVE: zone 20 released
  0.35  RESERVE: zone 21 released
  0.35  RESERVE: zone 22 released
  0.35  RESERVE: zone 23 at (488, 4328) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (488, 4328) facing 1 (id 23)
  0.35  RESERVE: zone 24 at (488, 4280) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: armnanotcplat at (488, 4280) facing 1 (id 24)
  0.35  RESERVE: zone 23 released
  0.35  RESERVE: zone 24 released
  0.35  RESERVE: corridor 25 at (700, 4885) facing 0, 13x31 cells: 273 of 403 held
  0.35  RESERVE: zone 26 at (-84, 4597) facing 1, 15x41 cells: 451 of 615 held
```
