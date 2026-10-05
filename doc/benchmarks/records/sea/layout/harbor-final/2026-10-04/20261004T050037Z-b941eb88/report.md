# Playtest report: PASS

- Verdict: **PASS** (reached 20 min)
- Game time reached: 20.0 min (frame 36060); wall 156 s
- DLL: build-theatres\d188-build-6\SkirmishAI.dll (ac71826721992d84); AI BARbTest/test; staged 2026-10-04T01:57:57
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: harbor-lifecycle.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\harbor-final\glacial\20261004T045756Z-cda824de\runs\20261004T050037Z-b941eb88\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `adoption` | seen at 1.0 min | `[SeaProbe] PASS named-state adoption` |
| expect `replan` | seen at 1.6 min | `[SeaProbe] PASS physical blocker replanned unused berth` |
| expect `egress` | seen at 3.8 min | `[SEA][Harbor] exit verified yard=19410 ship=19275` |
| expect `retired` | seen at 4.8 min | `[SeaProbe] PASS original yard entered retirement` |
| expect `removed` | seen at 5.0 min | `[SeaProbe] PASS original yard physically removed` |
| expect `physical-handover` | seen at 4.9 min | `[t=00:01:14.142309][f=0008738] [SeaFixture] PASS replacement exit precedes old reclaim old=19410 new=9238` |
| expect `reclaimed` | seen at 5.0 min | `[t=00:01:15.921314][f=0009081] [SeaFixture] PASS observed old yard removal after reclaim` |
| forbid `runtime` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\harbor-final\glacial\20261004T045756Z-cda824de\runs\20261004T050037Z-b941eb88\screen_2026-10-04_04-59-17-645.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\harbor-final\glacial\20261004T045756Z-cda824de\runs\20261004T050037Z-b941eb88\screen_2026-10-04_04-59-39-856.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\layout\harbor-final\glacial\20261004T045756Z-cda824de\runs\20261004T050037Z-b941eb88\screen_2026-10-04_05-00-28-386.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 3 shots, end at 20.5 min
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
  0.15  [Playtest] finished armmex team 0 at 0.15 min
  0.17  [SEA][Layout] berth sea.berth.2 armasy at=1424,3296 facing=3
  0.17  [Team][Roster] first mex 7123 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.61  [Playtest] finished armsy team 0 at 0.61 min
  0.74  [Playtest] finished armmex team 0 at 0.74 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 721/1200, energy +30.0 bank 487/1150, units 5
  1.02  [SEA][Layout] enabled; adopted berths=3 patches=4
  1.27  [Playtest] finished armtide team 0 at 1.27 min
  1.28  [SEA][Layout] replan unused berth sea.berth.1
  1.35  [Playtest] finished armtide team 0 at 1.35 min
  1.42  [SEA][Layout] berth sea.berth.1 armasy at=1616,3600 facing=1
  1.44  [Playtest] finished armmex team 0 at 1.44 min
  1.51  [Playtest] finished armtide team 0 at 1.51 min
  1.63  [Playtest] finished armtide team 0 at 1.63 min
  1.94  [Playtest] finished armtide team 0 at 1.94 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 217/1250, energy +159.0 bank 1413/1450, units 15
  2.02  [Playtest] finished armuwfus team 0 at 2.02 min
  2.02  [Playtest] finished armuwfus team 0 at 2.02 min
  2.02  [Playtest] finished armuwfus team 0 at 2.02 min
  2.02  [Playtest] finished armuwfus team 0 at 2.02 min
  2.02  [Playtest] finished armuwfus team 0 at 2.02 min
  2.02  [Playtest] finished armuwfus team 0 at 2.02 min
  2.03  [Playtest] finished armuwmmm team 0 at 2.03 min
  2.03  [Playtest] finished armuwmmm team 0 at 2.03 min
  2.03  [Playtest] finished armuwmmm team 0 at 2.03 min
  2.03  [Playtest] finished armuwmmm team 0 at 2.03 min
  2.03  [Playtest] finished armuwmmm team 0 at 2.03 min
  2.03  [Playtest] finished armuwmmm team 0 at 2.03 min
  2.03  [Playtest] finished armuwmmm team 0 at 2.03 min
  2.03  [Playtest] finished armuwmmm team 0 at 2.03 min
  2.03  [Playtest] finished armuwmmm team 0 at 2.03 min
  2.03  [Playtest] finished armuwmmm team 0 at 2.03 min
  2.03  [Playtest] finished armuwmmm team 0 at 2.03 min
  2.03  [Playtest] finished armuwmmm team 0 at 2.03 min
  2.04  [Playtest] finished armuwms team 0 at 2.04 min
  2.04  [Playtest] finished armuwms team 0 at 2.04 min
  2.04  [Playtest] finished armuwms team 0 at 2.04 min
  2.04  [Playtest] finished armuwms team 0 at 2.04 min
  2.05  [Playtest] finished armuwes team 0 at 2.05 min
  2.05  [Playtest] finished armuwes team 0 at 2.05 min
  2.05  [Playtest] finished armuwes team 0 at 2.05 min
  2.05  [Playtest] finished armuwes team 0 at 2.05 min
  2.24  [Playtest] finished armtl team 0 at 2.24 min
  2.24  [Playtest] finished armmex team 0 at 2.24 min
  2.25  [Playtest] finished armtide team 0 at 2.25 min
  2.52  [Playtest] finished armuwmme team 0 at 2.52 min
  2.74  [Playtest] finished armmex team 0 at 2.74 min
  2.75  [Playtest] finished armuwmme team 0 at 2.75 min
  2.78  [SEA][Layout] berth sea.berth.3 armsy at=2704,3904 facing=1
  2.91  [Playtest] finished armuwmme team 0 at 2.91 min
  2.97  [Playtest] finished armnanotcplat team 0 at 2.97 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +152.0 bank 9227/14950, energy +7509.0 bank 34597/41150, units 59
  3.27  [Playtest] finished armnanotcplat team 0 at 3.27 min
  3.35  [Playtest] finished armuwmme team 0 at 3.35 min
  3.35  [Playtest] finished armtl team 0 at 3.36 min
  3.42  [Playtest] finished armsy team 0 at 3.42 min
  3.58  [Playtest] finished armnanotcplat team 0 at 3.58 min
  3.59  [Playtest] finished armasy team 0 at 3.59 min
  3.69  [Playtest] finished armnanotcplat team 0 at 3.69 min
  3.86  [Playtest] finished armmex team 0 at 3.86 min
  3.96  [Playtest] finished armfrad team 0 at 3.96 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +146.7 bank 10877/15850, energy +7530.0 bank 34527/41600, units 74
  4.08  [Playtest] finished armuwmme team 0 at 4.08 min
  4.26  [Playtest] finished armnanotcplat team 0 at 4.26 min
  4.27  [Playtest] finished armtl team 0 at 4.27 min
  4.35  [Playtest] finished armnanotcplat team 0 at 4.35 min
  4.38  [Playtest] finished armnanotcplat team 0 at 4.38 min
  4.48  [Playtest] finished armmex team 0 at 4.48 min
  4.49  [Playtest] finished armnanotcplat team 0 at 4.49 min
  4.51  [Playtest] finished armnanotcplat team 0 at 4.51 min
  4.58  [Playtest] finished armnanotcplat team 0 at 4.58 min
  4.66  [Playtest] finished armnanotcplat team 0 at 4.66 min
  4.72  [Playtest] finished armmex team 0 at 4.72 min
  4.76  [Playtest] finished armnanotcplat team 0 at 4.76 min
  4.83  [Playtest] finished armnanotcplat team 0 at 4.83 min
  4.89  [Playtest] finished armmex team 0 at 4.89 min
  4.90  [Playtest] finished armnanotcplat team 0 at 4.90 min
  4.97  [Playtest] finished armnanotcplat team 0 at 4.97 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +151.0 bank 10171/16600, energy +7530.0 bank 34562/41600, units 95
  5.00  [Playtest] camera requested (2200,4200) height=3500
  5.01  [Playtest] camera captured name=ta position=(2200,4200) height=3500
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (2200, 4200)
  5.06  [Playtest] finished armnanotcplat team 0 at 5.06 min
  5.15  [Playtest] finished armnanotcplat team 0 at 5.15 min
  5.22  [Playtest] finished armnanotcplat team 0 at 5.22 min
  5.25  [Playtest] finished armnanotcplat team 0 at 5.25 min
  5.42  [Playtest] finished armnanotcplat team 0 at 5.41 min
  5.48  [SEA][Layout] berth sea.berth.4 armasy at=2896,4352 facing=1
  5.48  [Playtest] finished armmex team 0 at 5.48 min
  5.50  [Playtest] finished armnanotcplat team 0 at 5.50 min
  5.67  [Playtest] finished armfrad team 0 at 5.66 min
  5.73  [Playtest] finished armtl team 0 at 5.73 min
  5.74  [Playtest] finished armmship team 0 at 5.74 min
  5.83  [Playtest] finished armuwmme team 0 at 5.82 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +166.4 bank 12369/17150, energy +7530.0 bank 34179/41500, units 112
  6.05  [Playtest] finished armllt team 0 at 6.05 min
  6.13  [Playtest] finished armrad team 0 at 6.13 min
  6.32  [Playtest] finished armtide team 0 at 6.32 min
  6.39  [Playtest] finished armmship team 0 at 6.39 min
  6.52  [Playtest] finished armasy team 0 at 6.52 min
  6.55  [Playtest] finished armtide team 0 at 6.55 min
  6.76  [Playtest] finished armmship team 0 at 6.76 min
  6.91  [Playtest] finished armnanotcplat team 0 at 6.91 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +162.4 bank 9722/17350, energy +7606.0 bank 34210/41950, units 127
  7.02  [Playtest] finished armnanotcplat team 0 at 7.02 min
  7.12  [Playtest] finished armnanotcplat team 0 at 7.12 min
  7.12  [Playtest] finished armmship team 0 at 7.12 min
  7.14  [Playtest] finished armmship team 0 at 7.14 min
  7.22  [Playtest] finished armnanotcplat team 0 at 7.22 min
  7.27  [Playtest] finished armnanotcplat team 0 at 7.27 min
  7.32  [Playtest] finished armnanotcplat team 0 at 7.32 min
  7.91  [Playtest] finished armtide team 0 at 7.91 min
  7.99  [Playtest] finished armtide team 0 at 7.99 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +170.9 bank 6797/17350, energy +7959.0 bank 35857/43700, units 139
  8.32  [Playtest] finished armtide team 0 at 8.32 min
  8.40  [Playtest] finished armtide team 0 at 8.40 min
  8.84  [Playtest] finished armmex team 0 at 8.84 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +148.9 bank 4362/17200, energy +8028.0 bank 35129/43600, units 150
  9.07  [Playtest] finished armmex team 0 at 9.07 min
  9.08  [Playtest] finished armuwfus team 0 at 9.08 min
  9.25  [Playtest] finished armmex team 0 at 9.25 min
  9.40  [Playtest] finished armnanotcplat team 0 at 9.40 min
  9.41  [Playtest] finished armllt team 0 at 9.41 min
  9.50  [Playtest] finished armnanotcplat team 0 at 9.50 min
  9.51  [Playtest] finished armrad team 0 at 9.51 min
  9.60  [Playtest] finished armnanotcplat team 0 at 9.60 min
  9.75  [Playtest] finished armnanotcplat team 0 at 9.75 min
  9.92  [Playtest] finished armepoch team 0 at 9.92 min
  9.93  [Playtest] finished armnanotcplat team 0 at 9.93 min
  9.98  [Playtest] finished armmex team 0 at 9.98 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +190.2 bank 2499/17350, energy +9228.0 bank 42978/46100, units 160
 10.00  [Playtest] camera requested (2200,4200) height=3500
 10.01  [Playtest] camera captured name=ta position=(2200,4200) height=3500
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (2200, 4200)
 10.28  [Playtest] finished armfrad team 0 at 10.28 min
 10.29  [Playtest] finished armmex team 0 at 10.29 min
 10.39  [Playtest] finished armtl team 0 at 10.39 min
 10.55  [Playtest] finished armmex team 0 at 10.55 min
 10.66  [Playtest] finished armmex team 0 at 10.66 min
 10.67  [Playtest] finished armtl team 0 at 10.67 min
 10.73  [Playtest] finished armuwmme team 0 at 10.73 min
 10.77  [Playtest] finished armuwmme team 0 at 10.77 min
 10.83  [Playtest] finished armuwmme team 0 at 10.83 min
 10.87  [Playtest] finished armuwmme team 0 at 10.86 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +230.2 bank 8214/19900, energy +9348.0 bank 43492/46700, units 179
 11.25  [Playtest] finished armtl team 0 at 11.25 min
 11.27  [Playtest] finished armfrad team 0 at 11.27 min
 11.32  [Playtest] finished armuwmme team 0 at 11.32 min
 11.46  [Playtest] finished armmex team 0 at 11.46 min
 11.50  [Playtest] finished armuwmme team 0 at 11.50 min
 11.51  [Playtest] finished armnanotcplat team 0 at 11.51 min
 11.69  [Playtest] finished armuwmme team 0 at 11.69 min
 11.74  [Playtest] finished armtl team 0 at 11.74 min
 11.76  [Playtest] finished armuwmme team 0 at 11.76 min
 11.82  [Playtest] finished armtl team 0 at 11.82 min
 11.83  [Playtest] finished armfrad team 0 at 11.83 min
 11.85  [SEA][Layout] berth sea.berth.5 armsy at=3664,4304 facing=1
 11.91  [Playtest] finished armuwmme team 0 at 11.91 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +264.2 bank 18086/22750, energy +9348.0 bank 43215/46700, units 189
 12.10  [Playtest] finished armuwmmm team 0 at 12.10 min
 12.13  [Playtest] finished armuwmmm team 0 at 12.14 min
 12.15  [Playtest] finished armtl team 0 at 12.15 min
 12.27  [Playtest] finished armmex team 0 at 12.27 min
 12.34  [Playtest] finished armuwmme team 0 at 12.34 min
 12.45  [Playtest] finished armuwmme team 0 at 12.45 min
 12.48  [Playtest] finished armuwmme team 0 at 12.48 min
 12.48  [Playtest] finished armnanotcplat team 0 at 12.48 min
 12.56  [Playtest] finished armuwmmm team 0 at 12.56 min
 12.85  [Playtest] finished armuwmme team 0 at 12.85 min
 12.94  [Playtest] finished armuwmme team 0 at 12.94 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +289.8 bank 18033/25750, energy +9348.0 bank 38179/46700, units 200
 13.02  [Playtest] finished armmex team 0 at 13.02 min
 13.04  [Playtest] finished armsy team 0 at 13.04 min
 13.10  [Playtest] finished armuwmme team 0 at 13.10 min
 13.21  [Playtest] finished armuwmme team 0 at 13.21 min
 13.25  [Playtest] finished armtl team 0 at 13.25 min
 13.55  [Playtest] finished armfrad team 0 at 13.55 min
 13.72  [Playtest] finished armuwmme team 0 at 13.73 min
 13.79  [Playtest] finished armepoch team 0 at 13.79 min
 13.82  [Playtest] finished armnanotcplat team 0 at 13.82 min
 13.83  [Playtest] finished armnanotcplat team 0 at 13.83 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +341.6 bank 23167/27600, energy +9348.0 bank 39033/46800, units 208
 14.10  [Playtest] finished armuwmme team 0 at 14.10 min
 14.11  [Playtest] finished armnanotcplat team 0 at 14.11 min
 14.12  [Playtest] finished armtl team 0 at 14.12 min
 14.17  [Playtest] finished armmship team 0 at 14.17 min
 14.21  [Playtest] finished armuwmme team 0 at 14.21 min
 14.37  [Playtest] finished armuwmme team 0 at 14.37 min
 14.37  [Playtest] finished armmship team 0 at 14.37 min
 14.39  [Playtest] finished armnanotcplat team 0 at 14.39 min
 14.43  [Playtest] finished armtl team 0 at 14.43 min
 14.52  [Playtest] finished armnanotcplat team 0 at 14.52 min
 14.52  [Playtest] finished armmship team 0 at 14.52 min
 14.53  [Playtest] finished armmex team 0 at 14.53 min
 14.61  [Playtest] finished armnanotcplat team 0 at 14.61 min
 14.67  [Playtest] finished armnanotcplat team 0 at 14.67 min
 14.67  [Playtest] finished armuwmme team 0 at 14.67 min
 14.68  [Playtest] finished armfrad team 0 at 14.68 min
 14.78  [Playtest] finished armuwmme team 0 at 14.78 min
 14.81  [Playtest] finished armuwmme team 0 at 14.81 min
 14.85  [Playtest] finished armnanotcplat team 0 at 14.85 min
 14.87  [Playtest] finished armtl team 0 at 14.87 min
 14.88  [Playtest] finished armuwmme team 0 at 14.88 min
 14.93  [Playtest] finished armmex team 0 at 14.93 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +375.7 bank 27248/31850, energy +9348.0 bank 38370/46800, units 235
 15.04  [Playtest] finished armuwmme team 0 at 15.04 min
 15.07  [Playtest] finished armmship team 0 at 15.07 min
 15.19  [Playtest] finished armuwmme team 0 at 15.19 min
 15.20  [Playtest] finished armmship team 0 at 15.20 min
 15.33  [Playtest] finished armmship team 0 at 15.33 min
 15.47  [Playtest] finished armmship team 0 at 15.47 min
 15.53  [SEA][Layout] berth sea.berth.6 armsy at=1520,4032 facing=1
 15.56  [Playtest] finished armuwmme team 0 at 15.56 min
 15.61  [Playtest] finished armmship team 0 at 15.61 min
 15.63  [Playtest] finished armmex team 0 at 15.63 min
 15.75  [Playtest] finished armuwmme team 0 at 15.75 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +374.8 bank 32266/34150, energy +9348.0 bank 37396/46700, units 245
 16.15  [SEA][Layout] berth sea.berth.7 armasy at=4864,4608 facing=1
 16.17  [Playtest] finished armnanotcplat team 0 at 16.17 min
 16.19  [Playtest] finished armtl team 0 at 16.19 min
 16.27  [Playtest] finished armuwmme team 0 at 16.27 min
 16.34  [Playtest] finished armtl team 0 at 16.34 min
 16.63  [Playtest] finished armnanotcplat team 0 at 16.63 min
 16.67  [Playtest] finished armepoch team 0 at 16.67 min
 16.71  [Playtest] finished armnanotcplat team 0 at 16.71 min
 16.72  [Playtest] finished armuwmme team 0 at 16.72 min
 16.83  [Playtest] finished armtl team 0 at 16.83 min
 16.93  [Playtest] finished armfrad team 0 at 16.93 min
 16.95  [Playtest] finished armtl team 0 at 16.95 min
 16.96  [Playtest] finished armnanotcplat team 0 at 16.96 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +392.2 bank 32428/35300, energy +9348.0 bank 37320/46700, units 257
 17.05  [Playtest] finished armfrad team 0 at 17.05 min
 17.18  [Playtest] finished armnanotcplat team 0 at 17.18 min
 17.33  [Playtest] finished armfrad team 0 at 17.33 min
 17.75  [Playtest] finished armepoch team 0 at 17.75 min
 17.82  [Playtest] finished armtl team 0 at 17.82 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +384.7 bank 32321/35300, energy +9348.0 bank 37256/46700, units 270
 18.07  [Playtest] finished armtl team 0 at 18.07 min
 18.84  [Playtest] finished armepoch team 0 at 18.84 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +395.8 bank 30674/35300, energy +9348.0 bank 37315/46700, units 280
 19.00  [Playtest] camera requested (2200,4200) height=4000
 19.02  [Playtest] camera captured name=ta position=(2200,4200) height=4000
 19.02  [Playtest] screenshot at 19.0 min of team 0 at (2200, 4200)
 19.45  [Playtest] finished armuwfus team 0 at 19.45 min
 19.81  [Playtest] finished armasy team 0 at 19.81 min
 19.92  [Playtest] finished armepoch team 0 at 19.92 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +448.9 bank 29943/35500, energy +10548.0 bank 40392/49400, units 291
```

## Native lines (all AIs, first 120)

```
  0.10  RESERVE: zone 1 at (1424, 4000) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (1424, 4000) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (1712, 4000) facing 1, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (1208, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1208, 4072) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (1208, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1208, 4008) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (1208, 3944) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1208, 3944) facing 1 (id 4)
  0.10  RESERVE: zone 6 at (1272, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1272, 4072) facing 1 (id 5)
  0.10  RESERVE: zone 7 at (1272, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1272, 4008) facing 1 (id 6)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 released
  0.10  RESERVE: zone 6 released
  0.10  RESERVE: zone 7 released
  0.10  RESERVE: zone 8 at (1304, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1304, 4072) facing 1 (id 7)
  0.10  RESERVE: zone 9 at (1304, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1304, 4008) facing 1 (id 8)
  0.10  RESERVE: zone 8 released
  0.10  RESERVE: zone 9 released
  0.10  RESERVE: zone 10 at (1288, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1288, 4104) facing 1 (id 9)
  0.10  RESERVE: zone 11 at (1288, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1288, 4040) facing 1 (id 10)
  0.10  RESERVE: zone 12 at (1288, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1288, 3976) facing 1 (id 11)
  0.10  RESERVE: zone 13 at (1352, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 4104) facing 1 (id 12)
  0.10  RESERVE: zone 14 at (1352, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 4040) facing 1 (id 13)
  0.10  RESERVE: zone 15 at (1352, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 3976) facing 1 (id 14)
  0.10  RESERVE: zone 16 at (1321, 4037) facing 1, 9x13 cells: 54 of 117 held
  0.10  RESERVE: zone 1 at (704, 4592) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (704, 4592) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (992, 4592) facing 1, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (488, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4664) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (488, 4600) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4600) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (488, 4536) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4536) facing 1 (id 4)
  0.10  RESERVE: zone 6 at (552, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4664) facing 1 (id 5)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 released
  0.10  RESERVE: zone 6 released
  0.10  RESERVE: zone 7 at (584, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (584, 4664) facing 1 (id 6)
  0.10  RESERVE: zone 7 released
  0.10  RESERVE: zone 8 at (568, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (568, 4696) facing 1 (id 7)
  0.10  RESERVE: zone 8 released
  0.10  RESERVE: zone 9 at (552, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4728) facing 1 (id 8)
  0.10  RESERVE: zone 10 at (552, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4664) facing 1 (id 9)
  0.10  RESERVE: zone 9 released
  0.10  RESERVE: zone 10 released
  0.10  RESERVE: zone 11 at (520, 4744) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (520, 4744) facing 1 (id 10)
  0.10  RESERVE: zone 12 at (520, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (520, 4680) facing 1 (id 11)
  0.10  RESERVE: zone 11 released
  0.10  RESERVE: zone 12 released
  0.10  RESERVE: zone 13 at (488, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4760) facing 1 (id 12)
  0.10  RESERVE: zone 14 at (488, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4696) facing 1 (id 13)
  0.10  RESERVE: zone 15 at (488, 4632) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4632) facing 1 (id 14)
  0.10  RESERVE: zone 16 at (552, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4760) facing 1 (id 15)
  0.10  RESERVE: zone 17 at (552, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4696) facing 1 (id 16)
  0.10  RESERVE: zone 13 released
  0.10  RESERVE: zone 14 released
  0.10  RESERVE: zone 15 released
  0.10  RESERVE: zone 16 released
  0.10  RESERVE: zone 17 released
  0.10  RESERVE: zone 18 at (440, 4744) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (440, 4744) facing 1 (id 17)
  0.10  RESERVE: zone 19 at (440, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (440, 4680) facing 1 (id 18)
  0.10  RESERVE: zone 20 at (440, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (440, 4616) facing 1 (id 19)
  0.10  RESERVE: zone 21 at (504, 4744) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (504, 4744) facing 1 (id 20)
  0.10  RESERVE: zone 22 at (504, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (504, 4680) facing 1 (id 21)
  0.10  RESERVE: zone 18 released
  0.10  RESERVE: zone 19 released
  0.10  RESERVE: zone 20 released
  0.10  RESERVE: zone 21 released
  0.10  RESERVE: zone 22 released
  0.10  RESERVE: zone 23 at (408, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (408, 4728) facing 1 (id 22)
  0.10  RESERVE: zone 24 at (408, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (408, 4664) facing 1 (id 23)
  0.10  RESERVE: zone 25 at (408, 4600) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (408, 4600) facing 1 (id 24)
  0.10  RESERVE: zone 26 at (472, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (472, 4728) facing 1 (id 25)
  0.10  RESERVE: zone 27 at (472, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (472, 4664) facing 1 (id 26)
  0.10  RESERVE: zone 28 at (472, 4600) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (472, 4600) facing 1 (id 27)
  0.10  RESERVE: zone 29 at (444, 4660) facing 1, 9x13 cells: 63 of 117 held
  0.10  RESERVE: zone 1 at (12928, 4000) facing 3, 6x6 cells: 36 of 36 held
  0.10  RESERVE: legsy at (12928, 4000) facing 3 (id 1)
  0.10  RESERVE: corridor 2 at (12640, 4000) facing 3, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (13160, 3944) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (13160, 3944) facing 3 (id 2)
  0.10  RESERVE: zone 4 at (13160, 4008) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (13160, 4008) facing 3 (id 3)
```
