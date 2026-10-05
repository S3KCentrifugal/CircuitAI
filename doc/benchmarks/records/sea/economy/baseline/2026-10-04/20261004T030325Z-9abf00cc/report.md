# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54000); wall 172 s
- DLL: build-theatres\sea-baseline-3d8c66d2\SkirmishAI.dll (3ecbc2deecda41e7); AI BARbTest/test; staged 2026-10-04T00:00:03
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: build-theatres\games\sea\economy\baseline\glacial\20261004T025944Z-71a6b8e9\runs\20261004T030325Z-9abf00cc\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:29.169035][f=-000001] [SeaWatch] loaded` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- build-theatres\games\sea\economy\baseline\glacial\20261004T025944Z-71a6b8e9\runs\20261004T030325Z-9abf00cc\screen_2026-10-04_03-01-21-563.png
- build-theatres\games\sea\economy\baseline\glacial\20261004T025944Z-71a6b8e9\runs\20261004T030325Z-9abf00cc\screen_2026-10-04_03-01-43-049.png
- build-theatres\games\sea\economy\baseline\glacial\20261004T025944Z-71a6b8e9\runs\20261004T030325Z-9abf00cc\screen_2026-10-04_03-02-38-275.png
- build-theatres\games\sea\economy\baseline\glacial\20261004T025944Z-71a6b8e9\runs\20261004T030325Z-9abf00cc\screen_2026-10-04_03-03-19-151.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 30.5 min
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
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(700,4597) factory=armsy landLocked=no spot=5 known=1/2
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(1899,5801) factory=corsy landLocked=no spot=6 known=2/2
  0.15  [Team][Roster] team 1 first mex at 704,4448
  0.15  [Playtest] finished armmex team 0 at 0.15 min
  0.17  [Team][Roster] first mex 20990 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.17  [Team][Roster] team 2 first mex at 1904,5967
  0.27  [Playtest] finished armmex team 0 at 0.27 min
  0.41  [Playtest] finished armtide team 0 at 0.41 min
  0.56  [Playtest] finished armtide team 0 at 0.56 min
  0.86  [Playtest] finished armsy team 0 at 0.86 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 498/1200, energy +76.0 bank 730/1200, units 8
  1.06  [Playtest] finished armmex team 0 at 1.06 min
  1.18  [Playtest] finished armmex team 0 at 1.18 min
  1.33  [Playtest] finished armtide team 0 at 1.33 min
  1.47  [Playtest] finished armtide team 0 at 1.47 min
  1.63  [Playtest] finished armtide team 0 at 1.63 min
  1.80  [Playtest] finished armtide team 0 at 1.80 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +10.0 bank 0/1300, energy +182.0 bank 385/1500, units 17
  2.09  [Playtest] finished armtide team 0 at 2.09 min
  2.47  [Playtest] finished armtide team 0 at 2.47 min
  2.86  [Playtest] finished armtide team 0 at 2.86 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 0/1300, energy +251.0 bank 1650/1650, units 21
  3.23  [Playtest] finished armtide team 0 at 3.23 min
  3.42  [Playtest] finished armfmkr team 0 at 3.42 min
  3.66  [Playtest] finished armfmkr team 0 at 3.66 min
  3.86  [Playtest] finished armfmkr team 0 at 3.86 min
  3.90  [Playtest] finished armmex team 0 at 3.90 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +14.7 bank 15/1350, energy +274.0 bank 1377/1700, units 30
  4.04  [Playtest] finished armtide team 0 at 4.04 min
  4.12  [Playtest] finished armmex team 0 at 4.12 min
  4.22  [Playtest] finished armtide team 0 at 4.22 min
  4.34  [Playtest] finished armmex team 0 at 4.34 min
  4.46  [Playtest] finished armtide team 0 at 4.46 min
  4.53  [Playtest] finished armmex team 0 at 4.53 min
  4.71  [Playtest] finished armtide team 0 at 4.71 min
  4.92  [Playtest] finished armtide team 0 at 4.92 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +21.0 bank 107/1500, energy +389.0 bank 1502/1950, units 41
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.01  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.04  [Playtest] finished armmex team 0 at 5.04 min
  5.12  [Playtest] finished armfmkr team 0 at 5.12 min
  5.27  [Playtest] finished armmex team 0 at 5.27 min
  5.49  [Playtest] finished armmex team 0 at 5.49 min
  5.54  [Playtest] finished armnanotcplat team 0 at 5.54 min
  5.65  [Playtest] finished armmex team 0 at 5.65 min
  5.67  [Playtest] finished armtide team 0 at 5.66 min
  5.85  [Playtest] finished armtide team 0 at 5.85 min
  5.97  [Playtest] finished armtide team 0 at 5.97 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +29.5 bank 369/1700, energy +472.0 bank 1822/2200, units 52
  6.06  [Playtest] finished armtide team 0 at 6.06 min
  6.10  [Playtest] finished armtide team 0 at 6.10 min
  6.25  [Playtest] finished armmex team 0 at 6.25 min
  6.39  [Playtest] finished armtide team 0 at 6.39 min
  6.48  [Playtest] finished armtl team 0 at 6.48 min
  6.49  [Playtest] finished armmex team 0 at 6.49 min
  6.53  [Playtest] finished armnanotcplat team 0 at 6.53 min
  6.61  [Playtest] finished armtide team 0 at 6.61 min
  6.72  [Playtest] finished armmex team 0 at 6.72 min
  6.83  [Playtest] finished armnanotcplat team 0 at 6.83 min
  6.86  [Playtest] finished armmex team 0 at 6.86 min
  6.92  [Playtest] finished armtide team 0 at 6.92 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +37.0 bank 21/1900, energy +594.0 bank 1952/2500, units 61
  7.05  [Playtest] finished armnanotcplat team 0 at 7.05 min
  7.15  [Playtest] finished armtide team 0 at 7.15 min
  7.25  [Playtest] finished armnanotcplat team 0 at 7.25 min
  7.39  [Playtest] finished armtide team 0 at 7.39 min
  7.42  [Playtest] finished armmex team 0 at 7.43 min
  7.65  [Playtest] finished armmex team 0 at 7.65 min
  7.72  [Playtest] finished armfmkr team 0 at 7.72 min
  7.78  [Playtest] finished armtl team 0 at 7.78 min
  7.84  [Playtest] finished armmex team 0 at 7.84 min
  7.93  [Playtest] finished armtide team 0 at 7.93 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +40.5 bank 96/2050, energy +656.0 bank 2314/2650, units 71
  8.10  [Playtest] finished armtide team 0 at 8.10 min
  8.23  [Playtest] finished armnanotcplat team 0 at 8.23 min
  8.34  [Playtest] finished armtide team 0 at 8.34 min
  8.57  [Playtest] finished armtide team 0 at 8.57 min
  8.76  [Playtest] finished armtide team 0 at 8.76 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +45.0 bank 287/2050, energy +762.0 bank 2740/2900, units 83
  9.01  [Playtest] finished armllt team 0 at 9.01 min
  9.02  [Playtest] finished armtide team 0 at 9.02 min
  9.20  [Playtest] finished armtide team 0 at 9.20 min
  9.33  [Playtest] finished armtide team 0 at 9.33 min
  9.39  [Playtest] finished armfmkr team 0 at 9.39 min
  9.47  [Playtest] finished armtide team 0 at 9.47 min
  9.62  [Playtest] finished armtide team 0 at 9.62 min
  9.73  [Playtest] finished armfmkr team 0 at 9.73 min
  9.88  [Playtest] finished armtide team 0 at 9.88 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +44.7 bank 68/2050, energy +900.0 bank 3139/3200, units 96
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.02  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.05  [Playtest] finished armtide team 0 at 10.05 min
 10.05  [Playtest] finished armmex team 0 at 10.05 min
 10.28  [Playtest] finished armtide team 0 at 10.28 min
 10.30  [Playtest] finished armllt team 0 at 10.30 min
 10.37  [Playtest] finished armmex team 0 at 10.37 min
 10.46  [Playtest] finished armnanotcplat team 0 at 10.46 min
 10.51  [Playtest] finished armtide team 0 at 10.51 min
 10.60  [Playtest] finished armfmkr team 0 at 10.60 min
 10.71  [Playtest] finished armtide team 0 at 10.71 min
 10.71  [Playtest] finished armnanotcplat team 0 at 10.71 min
 10.81  [Playtest] finished armmex team 0 at 10.81 min
 10.95  [Playtest] finished armllt team 0 at 10.95 min
 10.98  [Playtest] finished armnanotcplat team 0 at 10.98 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +51.1 bank 28/2200, energy +992.0 bank 2920/3400, units 113
 11.02  [Playtest] finished armtide team 0 at 11.02 min
 11.11  [Playtest] finished armtl team 0 at 11.11 min
 11.14  [Playtest] finished armmex team 0 at 11.14 min
 11.21  [Playtest] finished armnanotcplat team 0 at 11.20 min
 11.24  [Playtest] finished armtide team 0 at 11.24 min
 11.42  [Playtest] finished armtide team 0 at 11.42 min
 11.47  [Playtest] finished armfmkr team 0 at 11.47 min
 11.47  [Playtest] finished armestor team 0 at 11.47 min
 11.48  [Playtest] finished armmex team 0 at 11.48 min
 11.60  [Playtest] finished armtide team 0 at 11.60 min
 11.79  [Playtest] finished armmex team 0 at 11.79 min
 11.81  [Playtest] finished armtide team 0 at 11.81 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +61.0 bank 889/2350, energy +1107.0 bank 8457/9650, units 131
 12.23  [Playtest] finished armtide team 0 at 12.23 min
 12.30  [Playtest] finished armtide team 0 at 12.30 min
 12.35  [Playtest] finished armtide team 0 at 12.35 min
 12.48  [Playtest] finished armtide team 0 at 12.48 min
 12.82  [Playtest] finished armtide team 0 at 12.82 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +61.0 bank 0/2350, energy +1222.0 bank 9691/9900, units 141
 13.36  [Playtest] finished armasy team 0 at 13.36 min
 13.74  [Playtest] finished armnanotcplat team 0 at 13.74 min
 13.85  [Playtest] finished armnanotcplat team 0 at 13.85 min
 13.94  [Playtest] finished armnanotcplat team 0 at 13.94 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +61.0 bank 22/2550, energy +1222.0 bank 7902/10100, units 144
 14.12  [Playtest] finished armtide team 0 at 14.12 min
 14.12  [Playtest] finished armfmkr team 0 at 14.12 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +60.8 bank 0/2550, energy +1305.0 bank 8150/10450, units 152
 15.48  [Playtest] finished armuwmme team 0 at 15.48 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +100.7 bank 30/3100, energy +1305.0 bank 7954/10450, units 151
 16.32  [Playtest] finished armuwmme team 0 at 16.32 min
 16.85  [Playtest] finished armuwmme team 0 at 16.85 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +76.8 bank 66/4200, energy +1305.0 bank 8186/10450, units 152
 17.03  [Playtest] finished armuwfus team 0 at 17.03 min
 17.32  [Playtest] finished armuwmme team 0 at 17.32 min
 17.61  [Playtest] finished armnanotcplat team 0 at 17.61 min
 17.93  [Playtest] finished armuwmmm team 0 at 17.93 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +94.1 bank 2342/4750, energy +2505.0 bank 10280/12950, units 151
 18.34  [Playtest] finished armuwmmm team 0 at 18.34 min
 18.40  [Playtest] finished armuwmmm team 0 at 18.40 min
 18.46  [Playtest] finished armnanotcplat team 0 at 18.46 min
 18.67  [Playtest] finished armnanotcplat team 0 at 18.67 min
 18.75  [Playtest] finished armnanotcplat team 0 at 18.75 min
 18.96  [Playtest] finished armuwmmm team 0 at 18.96 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +94.9 bank 4482/4750, energy +2505.0 bank 10188/12950, units 145
 19.20  [Playtest] finished armnanotcplat team 0 at 19.20 min
 19.20  [Playtest] finished armmex team 0 at 19.20 min
 19.37  [Playtest] finished armuwmmm team 0 at 19.37 min
 19.37  [Playtest] finished armmship team 0 at 19.37 min
 19.64  [Playtest] finished armmship team 0 at 19.64 min
 19.68  [Playtest] finished armfrad team 0 at 19.68 min
 19.86  [Playtest] finished armmship team 0 at 19.86 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +101.5 bank 2207/4800, energy +2505.0 bank 10430/12950, units 150
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.01  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
 20.12  [Playtest] finished armmship team 0 at 20.13 min
 20.45  [Playtest] finished armmship team 0 at 20.45 min
 20.49  [Playtest] finished armuwmmm team 0 at 20.49 min
 20.80  [Playtest] finished armuwmmm team 0 at 20.81 min
 20.86  [Playtest] finished armuwmmm team 0 at 20.86 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +96.5 bank 1671/4800, energy +2805.0 bank 11260/14450, units 155
 21.04  [Playtest] finished armtl team 0 at 21.04 min
 21.14  [Playtest] finished armatl team 0 at 21.14 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +165.3 bank 2/4800, energy +2805.0 bank 11328/14450, units 157
 22.68  [Playtest] finished armshltxuw team 0 at 22.68 min
 22.93  [Playtest] finished armnanotcplat team 0 at 22.93 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +145.7 bank 63/5600, energy +2805.0 bank 12407/15850, units 160
 23.05  [Playtest] finished armnanotcplat team 0 at 23.05 min
 23.24  [Playtest] finished armfrad team 0 at 23.24 min
 23.42  [Playtest] finished armnanotcplat team 0 at 23.42 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +115.4 bank 65/5600, energy +2805.0 bank 12662/15850, units 163
 24.38  [Playtest] finished armepoch team 0 at 24.38 min
 24.46  [Playtest] finished armtl team 0 at 24.46 min
 24.54  [Playtest] finished armuwfus team 0 at 24.54 min
 24.79  [Playtest] finished armtl team 0 at 24.79 min
 24.85  [Playtest] finished armuwadves team 0 at 24.85 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +119.5 bank 3669/5600, energy +4005.0 bank 30669/58350, units 171
 25.06  [Playtest] finished armuwmmm team 0 at 25.06 min
 25.29  [Playtest] finished armuwmmm team 0 at 25.29 min
 25.34  [Playtest] finished armtl team 0 at 25.34 min
 25.40  [Playtest] finished armnanotcplat team 0 at 25.40 min
 25.57  [Playtest] finished armnanotcplat team 0 at 25.57 min
 25.61  [Playtest] finished armfrad team 0 at 25.61 min
 25.67  [Playtest] finished armnanotcplat team 0 at 25.67 min
 25.79  [Playtest] finished armtl team 0 at 25.79 min
 25.81  [Playtest] finished armnanotcplat team 0 at 25.81 min
 25.86  [Playtest] finished armuwadvms team 0 at 25.86 min
 25.90  [Playtest] finished armnanotcplat team 0 at 25.90 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +177.9 bank 4588/15600, energy +4005.0 bank 44773/58350, units 184
 26.14  [Playtest] finished armuwmmm team 0 at 26.14 min
 26.57  [Playtest] finished armtl team 0 at 26.57 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +229.2 bank 9034/15600, energy +4005.0 bank 44608/58350, units 190
 27.75  [Playtest] finished armasy team 0 at 27.75 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +106.1 bank 9702/15800, energy +4005.0 bank 45605/58550, units 197
 28.15  [Playtest] finished armtl team 0 at 28.15 min
 28.44  [Playtest] finished armtl team 0 at 28.44 min
 28.86  [Playtest] finished armtl team 0 at 28.86 min
 28.98  [Playtest] finished armtl team 0 at 28.98 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +105.4 bank 9347/15800, energy +4005.0 bank 44783/58550, units 207
 29.00  [Playtest] camera requested (1700,4550) height=4000
 29.01  [Playtest] camera captured name=ta position=(1700,4550) height=4000
 29.01  [Playtest] screenshot at 29.0 min of team 0 at (1700, 4550)
 29.17  [Playtest] finished armmship team 0 at 29.17 min
 29.32  [Playtest] finished armmship team 0 at 29.32 min
 29.47  [Playtest] finished armmship team 0 at 29.47 min
 29.56  [Playtest] finished armtl team 0 at 29.56 min
 29.58  [Playtest] finished armtl team 0 at 29.58 min
 29.62  [Playtest] finished armmship team 0 at 29.62 min
 29.77  [Playtest] finished armmship team 0 at 29.77 min
 29.93  [Playtest] finished armmship team 0 at 29.93 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +136.4 bank 2727/15800, energy +4005.0 bank 45012/58550, units 216
```

## Native lines (all AIs, first 120)

```
  1.40  BUILDER: discarded 1 unused default task(s) in the last minute
  1.42  BUILDER: discarded 1 unused default task(s) in the last minute
  1.59  BUILDER: discarded 1 unused default task(s) in the last minute
  1.61  BUILDER: discarded 1 unused default task(s) in the last minute
  1.85  BUILDER: discarded 1 unused default task(s) in the last minute
  1.88  BUILDER: discarded 1 unused default task(s) in the last minute
  2.40  BUILDER: discarded 1 unused default task(s) in the last minute
  2.42  BUILDER: discarded 7 unused default task(s) in the last minute
  2.60  BUILDER: discarded 1 unused default task(s) in the last minute
  2.61  BUILDER: discarded 1 unused default task(s) in the last minute
  2.85  BUILDER: discarded 4 unused default task(s) in the last minute
  2.88  BUILDER: discarded 1 unused default task(s) in the last minute
  3.42  BUILDER: discarded 3 unused default task(s) in the last minute
  3.85  BUILDER: discarded 1 unused default task(s) in the last minute
  4.82  BUILDER: discarded 1 unused default task(s) in the last minute
  5.38  BUILDER: discarded 1 unused default task(s) in the last minute
  5.43  BUILDER: discarded 1 unused default task(s) in the last minute
  5.63  BUILDER: discarded 1 unused default task(s) in the last minute
  5.82  BUILDER: discarded 2 unused default task(s) in the last minute
  6.38  BUILDER: discarded 2 unused default task(s) in the last minute
  6.49  BUILDER: discarded 1 unused default task(s) in the last minute
  6.63  BUILDER: discarded 2 unused default task(s) in the last minute
  6.82  BUILDER: discarded 1 unused default task(s) in the last minute
  7.11  BUILDER: discarded 1 unused default task(s) in the last minute
  7.38  BUILDER: discarded 4 unused default task(s) in the last minute
  7.50  BUILDER: discarded 1 unused default task(s) in the last minute
  7.64  BUILDER: discarded 3 unused default task(s) in the last minute
  7.82  BUILDER: discarded 5 unused default task(s) in the last minute
  8.25  BUILDER: discarded 1 unused default task(s) in the last minute
  8.38  BUILDER: discarded 2 unused default task(s) in the last minute
  8.50  BUILDER: discarded 3 unused default task(s) in the last minute
  8.64  BUILDER: discarded 1 unused default task(s) in the last minute
  8.82  BUILDER: discarded 2 unused default task(s) in the last minute
  9.11  BUILDER: discarded 1 unused default task(s) in the last minute
  9.25  BUILDER: discarded 3 unused default task(s) in the last minute
  9.38  BUILDER: discarded 1 unused default task(s) in the last minute
  9.50  BUILDER: discarded 5 unused default task(s) in the last minute
  9.64  BUILDER: discarded 5 unused default task(s) in the last minute
  9.83  BUILDER: discarded 4 unused default task(s) in the last minute
 10.11  BUILDER: discarded 2 unused default task(s) in the last minute
 10.27  BUILDER: discarded 5 unused default task(s) in the last minute
 10.38  BUILDER: discarded 3 unused default task(s) in the last minute
 10.51  BUILDER: discarded 2 unused default task(s) in the last minute
 10.64  BUILDER: discarded 4 unused default task(s) in the last minute
 10.83  BUILDER: discarded 5 unused default task(s) in the last minute
 11.11  BUILDER: discarded 3 unused default task(s) in the last minute
 11.27  BUILDER: discarded 4 unused default task(s) in the last minute
 11.39  BUILDER: discarded 3 unused default task(s) in the last minute
 11.61  BUILDER: discarded 1 unused default task(s) in the last minute
 11.65  BUILDER: discarded 2 unused default task(s) in the last minute
 11.83  BUILDER: discarded 2 unused default task(s) in the last minute
 12.11  BUILDER: discarded 3 unused default task(s) in the last minute
 12.28  BUILDER: discarded 5 unused default task(s) in the last minute
 12.40  BUILDER: discarded 1 unused default task(s) in the last minute
 13.19  BUILDER: discarded 1 unused default task(s) in the last minute
 13.28  BUILDER: discarded 3 unused default task(s) in the last minute
 13.41  BUILDER: discarded 4 unused default task(s) in the last minute
 13.66  BUILDER: discarded 1 unused default task(s) in the last minute
 14.28  BUILDER: discarded 2 unused default task(s) in the last minute
 14.41  BUILDER: discarded 2 unused default task(s) in the last minute
 14.67  BUILDER: discarded 2 unused default task(s) in the last minute
 14.92  BUILDER: discarded 1 unused default task(s) in the last minute
 15.29  BUILDER: discarded 3 unused default task(s) in the last minute
 15.41  BUILDER: discarded 3 unused default task(s) in the last minute
 15.67  BUILDER: discarded 5 unused default task(s) in the last minute
 15.93  BUILDER: discarded 2 unused default task(s) in the last minute
 16.29  BUILDER: discarded 1 unused default task(s) in the last minute
 16.68  BUILDER: discarded 3 unused default task(s) in the last minute
 17.30  BUILDER: discarded 4 unused default task(s) in the last minute
 17.68  BUILDER: discarded 2 unused default task(s) in the last minute
 18.09  BUILDER: discarded 1 unused default task(s) in the last minute
 19.18  BUILDER: discarded 1 unused default task(s) in the last minute
 19.38  BUILDER: discarded 1 unused default task(s) in the last minute
 19.93  BUILDER: discarded 1 unused default task(s) in the last minute
 24.03  BUILDER: discarded 1 unused default task(s) in the last minute
 24.12  BUILDER: discarded 1 unused default task(s) in the last minute
 25.03  BUILDER: discarded 1 unused default task(s) in the last minute
 26.24  BUILDER: discarded 1 unused default task(s) in the last minute
```
