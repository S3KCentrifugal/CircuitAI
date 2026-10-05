# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 6.1 min (frame 10981); wall 72 s
- DLL: build-theatres\d200\build-3\SkirmishAI.dll (bcac8c987b1d8164); AI BARbTest/test; staged 2026-10-05T01:30:09
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/cortex/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea-sub-production.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\response-sub-cortex-cand\glacial\20261005T043009Z-5ca8d26d\runs\20261005T043125Z-1db2a128\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:29.510289][f=-000001] [SeaArena] frame=0 loaded case=response-sub-cortex control=false` |
| expect `response` | seen at 1.1 min | `[SEA][Response] layer=1 deficit=6840 observedSub=6500 subCover=960 recruit=corsub` |
| expect `counter-started` | seen at 1.1 min | `[t=00:00:44.487496][f=0001959] [SeaArena] frame=1959 produced id=27000 team=0 unit=corsub` |
| expect `new-counter-fired` | **missing** (by 6 min) | |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Failures

- 'new-counter-fired' not seen by 6.0 min

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\response-sub-cortex-cand\glacial\20261005T043009Z-5ca8d26d\runs\20261005T043125Z-1db2a128\screen_2026-10-05_04-30-53-094.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\response-sub-cortex-cand\glacial\20261005T043009Z-5ca8d26d\runs\20261005T043125Z-1db2a128\screen_2026-10-05_04-30-55-583.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\response-sub-cortex-cand\glacial\20261005T043009Z-5ca8d26d\runs\20261005T043125Z-1db2a128\screen_2026-10-05_04-31-08-324.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 12, 4 shots, end at 6.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished corcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side cortex ai true dead false start (2300, 4400) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (4600, 4400) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 12
  0.05  [Playtest] frame 90 team 0 ally 0 side cortex ai true dead false start (2300, 4400) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (4600, 4400) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.17  [Playtest] finished corsy team 0 at 0.17 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.18  [Playtest] finished coruwfus team 0 at 0.18 min
  0.18  [Playtest] finished coruwmmm team 0 at 0.18 min
  0.19  [Playtest] finished coruwmmm team 0 at 0.19 min
  0.19  [Playtest] finished coruwmmm team 0 at 0.19 min
  0.19  [Playtest] finished coruwmmm team 0 at 0.19 min
  0.19  [Playtest] finished coruwmmm team 0 at 0.19 min
  0.19  [Playtest] finished coruwmmm team 0 at 0.19 min
  0.20  [Playtest] finished coruwmmm team 0 at 0.20 min
  0.20  [Playtest] finished coruwmmm team 0 at 0.20 min
  0.20  [Playtest] finished coruwms team 0 at 0.20 min
  0.20  [Playtest] finished coruwms team 0 at 0.20 min
  0.20  [Playtest] finished coruwms team 0 at 0.20 min
  0.21  [Playtest] finished coruwms team 0 at 0.21 min
  0.21  [Playtest] finished corfrad team 0 at 0.21 min
  0.21  [Playtest] finished corason team 0 at 0.21 min
  0.22  [SEA][Layout] berth sea.berth.0 corasy at=3296,4576 facing=1
  0.23  [SEA][Layout] berth sea.berth.1 corasy at=3216,4000 facing=1
  0.40  [Playtest] camera requested (3400,4450) height=2400
  0.41  [Playtest] camera captured name=ta position=(3400,4450) height=2400
  0.41  [Playtest] screenshot at 0.4 min of team 0 at (3400, 4450)
  0.70  [Playtest] camera requested (3400,4450) height=2400
  0.70  [Playtest] camera captured name=ta position=(3400,4450) height=2400
  0.70  [Playtest] screenshot at 0.7 min of team 0 at (3400, 4450)
  1.00  [Playtest] eco team 0 at 1.0 min: metal +84.8 bank 4874/13100, energy +4924.0 bank 1007771/1010200, units 25
  2.00  [Playtest] eco team 0 at 2.0 min: metal +0.0 bank 8826/12500, energy +3660.0 bank 1007000/1007000, units 7
  3.00  [Playtest] eco team 0 at 3.0 min: metal +0.0 bank 8826/12500, energy +3660.0 bank 1007000/1007000, units 7
  3.00  [Playtest] camera requested (3400,4450) height=3200
  3.00  [Playtest] camera captured name=ta position=(3400,4450) height=3200
  3.00  [Playtest] screenshot at 3.0 min of team 0 at (3400, 4450)
  4.00  [Playtest] eco team 0 at 4.0 min: metal +0.0 bank 8826/12500, energy +3660.0 bank 1007000/1007000, units 7
  5.00  [Playtest] eco team 0 at 5.0 min: metal +0.0 bank 8826/12500, energy +3660.0 bank 1007000/1007000, units 7
  6.00  [Playtest] eco team 0 at 6.0 min: metal +0.0 bank 8826/12500, energy +3660.0 bank 1007000/1007000, units 7
```

## Native lines (all AIs, first 120)

```
  0.18  RESERVE: zone 1 at (2248, 4408) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (2248, 4408) facing 1 (id 1)
  0.18  RESERVE: zone 2 at (2248, 4360) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (2248, 4360) facing 1 (id 2)
  0.18  RESERVE: zone 1 released
  0.18  RESERVE: zone 2 released
  0.18  RESERVE: zone 3 at (2200, 4344) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotcplat at (2200, 4344) facing 1 (id 3)
  0.18  RESERVE: zone 3 released
  0.18  RESERVE: corridor 4 at (2450, 4688) facing 0, 13x30 cells: 247 of 390 held
  0.18  RESERVE: zone 5 at (1666, 4400) facing 1, 41x40 cells: 1435 of 1640 held
  0.18  RESERVE: grid of cornanotcplat 4x4 gap 0 behind (1762, 4400) facing 1: 16 of 16 slots (group 1, held, zone)
  0.18  RESERVE: coruwfus at (1528, 4424) facing 1 (id 20)
  0.18  RESERVE: packed coruwfus at (1528, 4424) facing 1 in zone 5, 320 from a turret (id 20, group 0, 856 candidates)
  0.20  RESERVE: zone 6 at (2376, 4088) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (2376, 4088) facing 1 (id 21)
  0.20  RESERVE: zone 7 at (2376, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (2376, 4040) facing 1 (id 22)
  0.20  RESERVE: zone 6 released
  0.20  RESERVE: zone 7 released
  0.20  RESERVE: zone 8 at (2456, 4088) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (2456, 4088) facing 1 (id 23)
  0.20  RESERVE: zone 9 at (2456, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (2456, 4040) facing 1 (id 24)
  0.20  RESERVE: zone 8 released
  0.20  RESERVE: zone 9 released
  0.20  RESERVE: zone 10 at (2520, 4136) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (2520, 4136) facing 1 (id 25)
  0.20  RESERVE: zone 11 at (2520, 4088) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (2520, 4088) facing 1 (id 26)
  0.20  RESERVE: zone 12 at (2520, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (2520, 4040) facing 1 (id 27)
  0.20  RESERVE: zone 10 released
  0.20  RESERVE: zone 11 released
  0.20  RESERVE: zone 12 released
  0.20  RESERVE: zone 13 at (2552, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (2552, 4200) facing 1 (id 28)
  0.20  RESERVE: zone 14 at (2552, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (2552, 4152) facing 1 (id 29)
  0.20  RESERVE: zone 15 at (2552, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (2552, 4104) facing 1 (id 30)
  0.20  RESERVE: zone 16 at (2552, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (2552, 4056) facing 1 (id 31)
  0.20  RESERVE: zone 13 released
  0.20  RESERVE: zone 14 released
  0.20  RESERVE: zone 15 released
  0.20  RESERVE: zone 16 released
  0.20  RESERVE: zone 17 at (2664, 4280) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (2664, 4280) facing 1 (id 32)
  0.20  RESERVE: zone 18 at (2664, 4232) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (2664, 4232) facing 1 (id 33)
  0.20  RESERVE: zone 19 at (2664, 4184) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (2664, 4184) facing 1 (id 34)
  0.20  RESERVE: zone 20 at (2664, 4136) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (2664, 4136) facing 1 (id 35)
  0.20  RESERVE: zone 21 at (2664, 4088) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (2664, 4088) facing 1 (id 36)
  0.20  RESERVE: zone 22 at (2712, 4280) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (2712, 4280) facing 1 (id 37)
  0.20  RESERVE: zone 23 at (2712, 4232) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (2712, 4232) facing 1 (id 38)
  0.20  RESERVE: zone 24 at (2712, 4184) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (2712, 4184) facing 1 (id 39)
  0.20  RESERVE: zone 25 at (2712, 4136) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: cornanotcplat at (2712, 4136) facing 1 (id 40)
  0.20  RESERVE: zone 17 released
  0.20  RESERVE: zone 18 released
  0.20  RESERVE: zone 19 released
  0.20  RESERVE: zone 20 released
  0.20  RESERVE: zone 21 released
  0.20  RESERVE: zone 22 released
  0.20  RESERVE: zone 23 released
  0.20  RESERVE: zone 24 released
  0.20  RESERVE: zone 25 released
  0.22  RESERVE: zone 26 at (3296, 4576) facing 1, 12x12 cells: 144 of 144 held
  0.22  RESERVE: corasy at (3296, 4576) facing 1 (id 41)
  0.22  RESERVE: corridor 27 at (3632, 4576) facing 1, 30x18 cells: 450 of 540 held
  0.22  RESERVE: zone 28 at (3080, 4856) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (3080, 4856) facing 1 (id 42)
  0.22  RESERVE: zone 29 at (3080, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (3080, 4808) facing 1 (id 43)
  0.22  RESERVE: zone 30 at (3080, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (3080, 4760) facing 1 (id 44)
  0.22  RESERVE: zone 31 at (3080, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (3080, 4712) facing 1 (id 45)
  0.22  RESERVE: zone 32 at (3080, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (3080, 4664) facing 1 (id 46)
  0.22  RESERVE: zone 33 at (3128, 4856) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (3128, 4856) facing 1 (id 47)
  0.22  RESERVE: zone 34 at (3128, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (3128, 4808) facing 1 (id 48)
  0.22  RESERVE: zone 35 at (3128, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (3128, 4760) facing 1 (id 49)
  0.22  RESERVE: zone 36 at (3128, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (3128, 4712) facing 1 (id 50)
  0.22  RESERVE: zone 37 at (3128, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (3128, 4664) facing 1 (id 51)
  0.22  RESERVE: zone 38 at (3176, 4856) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (3176, 4856) facing 1 (id 52)
  0.22  RESERVE: zone 39 at (3176, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (3176, 4808) facing 1 (id 53)
  0.22  RESERVE: zone 40 at (3176, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (3176, 4760) facing 1 (id 54)
  0.22  RESERVE: zone 41 at (3176, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (3176, 4712) facing 1 (id 55)
  0.22  RESERVE: zone 42 at (3176, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (3176, 4664) facing 1 (id 56)
  0.22  RESERVE: zone 43 at (3224, 4856) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (3224, 4856) facing 1 (id 57)
  0.22  RESERVE: zone 44 at (3224, 4808) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (3224, 4808) facing 1 (id 58)
  0.22  RESERVE: zone 45 at (3224, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (3224, 4760) facing 1 (id 59)
  0.22  RESERVE: zone 46 at (3224, 4712) facing 1, 3x3 cells: 9 of 9 held
  0.22  RESERVE: cornanotcplat at (3224, 4712) facing 1 (id 60)
  0.22  RESERVE: zone 28 released
  0.22  RESERVE: zone 29 released
  0.22  RESERVE: zone 30 released
  0.22  RESERVE: zone 31 released
  0.22  RESERVE: zone 32 released
```
