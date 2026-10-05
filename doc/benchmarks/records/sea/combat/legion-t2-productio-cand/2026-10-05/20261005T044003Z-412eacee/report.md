# Playtest report: PASS

- Verdict: **PASS** (reached 6 min)
- Game time reached: 6.1 min (frame 10950); wall 71 s
- DLL: build-theatres\d200\build-3\SkirmishAI.dll (bcac8c987b1d8164); AI BARbTest/test; staged 2026-10-05T01:38:49
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/legion/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: legion-t2-production.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\legion-t2-productio-cand\glacial\20261005T043849Z-26b62acc\runs\20261005T044003Z-412eacee\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:28.977292][f=-000001] [SeaArena] frame=0 loaded case=legion-t2-production control=false` |
| expect `registration` | seen at 0.1 min | `[SEA][Factory] Legion T2 runtime metadata ready` |
| expect `t2-constructor` | seen at 0.6 min | `[t=00:00:40.107998][f=0001104] [SeaArena] frame=1104 finished id=8691 team=0 unit=leganavyconsub` |
| expect `t2-combat` | seen at 1.0 min | `[t=00:00:43.237955][f=0001781] [SeaArena] frame=1781 finished id=28374 team=0 unit=leganavyantiswarm` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\legion-t2-productio-cand\glacial\20261005T043849Z-26b62acc\runs\20261005T044003Z-412eacee\screen_2026-10-05_04-39-31-955.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\legion-t2-productio-cand\glacial\20261005T043849Z-26b62acc\runs\20261005T044003Z-412eacee\screen_2026-10-05_04-39-34-441.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\legion-t2-productio-cand\glacial\20261005T043849Z-26b62acc\runs\20261005T044003Z-412eacee\screen_2026-10-05_04-39-47-193.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 12, 4 shots, end at 6.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished legcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side legion ai true dead false start (2300, 4400) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (4600, 4400) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 12
  0.05  [Playtest] frame 90 team 0 ally 0 side legion ai true dead false start (2300, 4400) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (4600, 4400) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
  0.17  [Playtest] finished leganavalfusion team 0 at 0.17 min
  0.17  [Playtest] finished leganavaleconv team 0 at 0.17 min
  0.17  [Playtest] finished leganavaleconv team 0 at 0.17 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.18 min
  0.18  [Playtest] finished leganavaleconv team 0 at 0.19 min
  0.19  [Playtest] finished armuwms team 0 at 0.19 min
  0.19  [Playtest] finished armuwms team 0 at 0.19 min
  0.19  [Playtest] finished armuwms team 0 at 0.19 min
  0.19  [Playtest] finished armuwms team 0 at 0.19 min
  0.19  [Playtest] finished legnanotcplat team 0 at 0.19 min
  0.20  [Playtest] finished legnanotcplat team 0 at 0.20 min
  0.20  [Playtest] finished legnanotcplat team 0 at 0.20 min
  0.20  [Playtest] finished legnanotcplat team 0 at 0.20 min
  0.20  [Playtest] finished legnanotcplat team 0 at 0.20 min
  0.20  [Playtest] finished legnanotcplat team 0 at 0.20 min
  0.20  [Playtest] finished legadvshipyard team 0 at 0.20 min
  0.22  [SEA][Layout] berth sea.berth.0 legadvshipyard at=3216,4400 facing=1
  0.23  [SEA][Layout] berth sea.berth.1 legadvshipyard at=3216,4000 facing=1
  0.40  [Playtest] camera requested (3400,4450) height=2400
  0.40  [Playtest] camera captured name=ta position=(3400,4450) height=2400
  0.40  [Playtest] screenshot at 0.4 min of team 0 at (3400, 4450)
  0.70  [Playtest] camera requested (3400,4450) height=2400
  0.70  [Playtest] camera captured name=ta position=(3400,4450) height=2400
  0.70  [Playtest] screenshot at 0.7 min of team 0 at (3400, 4450)
  1.00  [Playtest] eco team 0 at 1.0 min: metal +84.8 bank 3212/13200, energy +4970.0 bank 984058/1010500, units 33
  2.00  [Playtest] eco team 0 at 2.0 min: metal +84.8 bank 4022/13200, energy +4970.0 bank 943658/1010500, units 38
  3.00  [Playtest] eco team 0 at 3.0 min: metal +84.8 bank 5709/13200, energy +5270.0 bank 918583/1012000, units 48
  3.00  [Playtest] camera requested (3400,4450) height=3200
  3.00  [Playtest] camera captured name=ta position=(3400,4450) height=3200
  3.00  [Playtest] screenshot at 3.0 min of team 0 at (3400, 4450)
  4.00  [Playtest] eco team 0 at 4.0 min: metal +84.8 bank 6839/13200, energy +5270.0 bank 882757/1012000, units 54
  5.00  [Playtest] eco team 0 at 5.0 min: metal +84.8 bank 7909/13200, energy +5270.0 bank 847748/1012000, units 59
  6.00  [Playtest] eco team 0 at 6.0 min: metal +84.8 bank 9208/13200, energy +5270.0 bank 816964/1012000, units 63
```

## Native lines (all AIs, first 120)

```
  0.22  RESERVE: zone 1 at (3216, 4400) facing 1, 12x12 cells: 144 of 144 held
  0.22  RESERVE: legadvshipyard at (3216, 4400) facing 1 (id 1)
  0.22  RESERVE: corridor 2 at (3552, 4400) facing 1, 30x18 cells: 540 of 540 held
  0.22  RESERVE: zone 3 at (3000, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (3000, 4680) facing 1 (id 2)
  0.22  RESERVE: zone 4 at (3000, 4632) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (3000, 4632) facing 1 (id 3)
  0.22  RESERVE: zone 5 at (3000, 4584) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (3000, 4584) facing 1 (id 4)
  0.22  RESERVE: zone 6 at (3000, 4536) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (3000, 4536) facing 1 (id 5)
  0.22  RESERVE: zone 7 at (3000, 4488) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (3000, 4488) facing 1 (id 6)
  0.22  RESERVE: zone 8 at (3048, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (3048, 4680) facing 1 (id 7)
  0.22  RESERVE: zone 9 at (3048, 4632) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (3048, 4632) facing 1 (id 8)
  0.22  RESERVE: zone 10 at (3048, 4584) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (3048, 4584) facing 1 (id 9)
  0.22  RESERVE: zone 11 at (3048, 4536) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (3048, 4536) facing 1 (id 10)
  0.22  RESERVE: zone 12 at (3048, 4488) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (3048, 4488) facing 1 (id 11)
  0.22  RESERVE: zone 13 at (3096, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (3096, 4680) facing 1 (id 12)
  0.22  RESERVE: zone 14 at (3096, 4632) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (3096, 4632) facing 1 (id 13)
  0.22  RESERVE: zone 15 at (3096, 4584) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (3096, 4584) facing 1 (id 14)
  0.22  RESERVE: zone 16 at (3096, 4536) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (3096, 4536) facing 1 (id 15)
  0.22  RESERVE: zone 17 at (3096, 4488) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (3096, 4488) facing 1 (id 16)
  0.22  RESERVE: zone 18 at (3144, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (3144, 4680) facing 1 (id 17)
  0.22  RESERVE: zone 19 at (3144, 4632) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (3144, 4632) facing 1 (id 18)
  0.22  RESERVE: zone 20 at (3144, 4584) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (3144, 4584) facing 1 (id 19)
  0.22  RESERVE: zone 21 at (3144, 4536) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (3144, 4536) facing 1 (id 20)
  0.22  RESERVE: zone 3 released
  0.22  RESERVE: zone 4 released
  0.22  RESERVE: zone 5 released
  0.22  RESERVE: zone 6 released
  0.22  RESERVE: zone 7 released
  0.22  RESERVE: zone 8 released
  0.22  RESERVE: zone 9 released
  0.22  RESERVE: zone 10 released
  0.22  RESERVE: zone 11 released
  0.22  RESERVE: zone 12 released
  0.22  RESERVE: zone 13 released
  0.22  RESERVE: zone 14 released
  0.22  RESERVE: zone 15 released
  0.22  RESERVE: zone 16 released
  0.22  RESERVE: zone 17 released
  0.22  RESERVE: zone 18 released
  0.22  RESERVE: zone 19 released
  0.22  RESERVE: zone 20 released
  0.22  RESERVE: zone 21 released
  0.22  RESERVE: zone 22 at (2248, 4408) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (2248, 4408) facing 1 (id 21)
  0.22  RESERVE: zone 23 at (2248, 4360) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (2248, 4360) facing 1 (id 22)
  0.22  RESERVE: zone 24 at (2248, 4312) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (2248, 4312) facing 1 (id 23)
  0.22  RESERVE: zone 25 at (2248, 4264) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (2248, 4264) facing 1 (id 24)
  0.22  RESERVE: zone 26 at (2248, 4216) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (2248, 4216) facing 1 (id 25)
  0.22  RESERVE: zone 22 released
  0.22  RESERVE: zone 23 released
  0.22  RESERVE: zone 24 released
  0.22  RESERVE: zone 25 released
  0.22  RESERVE: zone 26 released
  0.22  RESERVE: zone 27 at (2200, 4344) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (2200, 4344) facing 1 (id 26)
  0.22  RESERVE: zone 28 at (2200, 4296) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (2200, 4296) facing 1 (id 27)
  0.22  RESERVE: zone 29 at (2200, 4248) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (2200, 4248) facing 1 (id 28)
  0.22  RESERVE: zone 27 released
  0.22  RESERVE: zone 28 released
  0.22  RESERVE: zone 29 released
  0.22  RESERVE: zone 30 at (2184, 4280) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (2184, 4280) facing 1 (id 29)
  0.22  RESERVE: zone 31 at (2184, 4232) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: legnanotcplat at (2184, 4232) facing 1 (id 30)
  0.22  RESERVE: zone 30 released
  0.22  RESERVE: zone 31 released
  0.22  RESERVE: corridor 32 at (2450, 4736) facing 0, 19x30 cells: 510 of 570 held
  0.22  RESERVE: zone 33 at (2432, 4400) facing 1, 40x40 cells: 917 of 1600 held
  0.22  RESERVE: zone 33 released
  0.22  RESERVE: zone 34 at (2432, 4272) facing 1, 40x40 cells: 1002 of 1600 held
  0.22  RESERVE: grid of legnanotcplat 4x4 gap 0 behind (2528, 4272) facing 1: 3 of 16 slots (group 2, held, zone)
  0.22  RESERVE: zone 34 released
  0.22  RESERVE: zone 35 at (2432, 4528) facing 1, 40x40 cells: 810 of 1600 held
  0.22  RESERVE: zone 35 released
  0.22  RESERVE: zone 36 at (2432, 4144) facing 1, 40x40 cells: 1075 of 1600 held
  0.22  RESERVE: grid of legnanotcplat 4x4 gap 0 behind (2528, 4144) facing 1: 13 of 16 slots (group 4, held, zone)
  0.22  RESERVE: zone 36 released
  0.22  RESERVE: zone 37 at (2432, 4656) facing 1, 40x40 cells: 652 of 1600 held
  0.22  RESERVE: zone 37 released
  0.22  RESERVE: zone 38 at (2432, 4016) facing 1, 40x40 cells: 1205 of 1600 held
  0.22  RESERVE: grid of legnanotcplat 4x4 gap 0 behind (2528, 4016) facing 1: 14 of 16 slots (group 6, held, zone)
  0.22  RESERVE: zone 38 released
  0.22  RESERVE: zone 39 at (2432, 4784) facing 1, 40x40 cells: 736 of 1600 held
  0.22  RESERVE: zone 39 released
  0.22  RESERVE: zone 40 at (2432, 3888) facing 1, 40x40 cells: 1295 of 1600 held
  0.22  RESERVE: grid of legnanotcplat 4x4 gap 0 behind (2528, 3888) facing 1: 16 of 16 slots (group 8, held, zone)
  0.22  RESERVE: leganavalfusion at (2568, 3872) facing 1 (id 77)
  0.22  RESERVE: packed leganavalfusion at (2568, 3872) facing 1 in zone 40, 320 from a turret (id 77, group 0, 693 candidates)
  0.23  RESERVE: zone 41 at (3216, 4000) facing 1, 12x12 cells: 144 of 144 held
  0.23  RESERVE: legadvshipyard at (3216, 4000) facing 1 (id 78)
  0.23  RESERVE: corridor 42 at (3552, 4000) facing 1, 30x18 cells: 540 of 540 held
  0.23  RESERVE: zone 43 at (2840, 4312) facing 1, 3x3 cells: 9 of 9 held
  0.23  RESERVE: legnanotcplat at (2840, 4312) facing 1 (id 79)
  0.23  RESERVE: zone 44 at (2840, 4264) facing 1, 3x3 cells: 9 of 9 held
  0.23  RESERVE: legnanotcplat at (2840, 4264) facing 1 (id 80)
  0.23  RESERVE: zone 43 released
```
