# Playtest report: PASS

- Verdict: **PASS** (reached 6 min)
- Game time reached: 6.0 min (frame 10800); wall 72 s
- DLL: build-theatres\d200\build-3\SkirmishAI.dll (bcac8c987b1d8164); AI BARbTest/test; staged 2026-10-05T01:28:54
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea-sub-production.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\response-submarine-cand\glacial\20261005T042854Z-284ea2ff\runs\20261005T043009Z-6bbb7889\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:29.682960][f=-000001] [SeaArena] frame=0 loaded case=response-submarine control=false` |
| expect `response` | seen at 1.1 min | `[SEA][Response] layer=1 deficit=6320 observedSub=6000 subCover=880 recruit=armsub` |
| expect `counter-started` | seen at 1.1 min | `[t=00:00:44.604371][f=0001958] [SeaArena] frame=1958 produced id=27000 team=0 unit=armsub` |
| expect `new-counter-fired` | seen at 1.9 min | `[t=00:00:48.646959][f=0003418] [SeaArena] frame=3418 damage victim=26627 attacker=27000 team=0 amount=342.1 attackerUnit=armsub victimUnit=corsub produced=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\response-submarine-cand\glacial\20261005T042854Z-284ea2ff\runs\20261005T043009Z-6bbb7889\screen_2026-10-05_04-29-38-163.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\response-submarine-cand\glacial\20261005T042854Z-284ea2ff\runs\20261005T043009Z-6bbb7889\screen_2026-10-05_04-29-40-647.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\response-submarine-cand\glacial\20261005T042854Z-284ea2ff\runs\20261005T043009Z-6bbb7889\screen_2026-10-05_04-29-53-393.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 12, 4 shots, end at 6.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (2300, 4400) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (4600, 4400) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 12
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (2300, 4400) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (4600, 4400) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.17  [Playtest] finished armsy team 0 at 0.17 min
  0.19  [Playtest] finished armuwfus team 0 at 0.19 min
  0.19  [Playtest] finished armuwfus team 0 at 0.19 min
  0.19  [Playtest] finished armuwfus team 0 at 0.19 min
  0.20  [Playtest] finished armuwfus team 0 at 0.20 min
  0.20  [Playtest] finished armuwmmm team 0 at 0.20 min
  0.20  [Playtest] finished armuwmmm team 0 at 0.20 min
  0.20  [Playtest] finished armuwmmm team 0 at 0.20 min
  0.20  [Playtest] finished armuwmmm team 0 at 0.20 min
  0.20  [Playtest] finished armuwmmm team 0 at 0.20 min
  0.20  [Playtest] finished armuwmmm team 0 at 0.20 min
  0.21  [Playtest] finished armuwmmm team 0 at 0.21 min
  0.21  [Playtest] finished armuwmmm team 0 at 0.21 min
  0.21  [Playtest] finished armuwms team 0 at 0.21 min
  0.21  [Playtest] finished armuwms team 0 at 0.21 min
  0.21  [Playtest] finished armuwms team 0 at 0.21 min
  0.21  [Playtest] finished armuwms team 0 at 0.22 min
  0.22  [SEA][Layout] berth sea.berth.0 armasy at=3296,4576 facing=1
  0.22  [Playtest] finished armfrad team 0 at 0.22 min
  0.22  [Playtest] finished armason team 0 at 0.22 min
  0.23  [SEA][Layout] berth sea.berth.1 armasy at=3216,4000 facing=1
  0.40  [Playtest] camera requested (3400,4450) height=2400
  0.41  [Playtest] camera captured name=ta position=(3400,4450) height=2400
  0.41  [Playtest] screenshot at 0.4 min of team 0 at (3400, 4450)
  0.70  [Playtest] camera requested (3400,4450) height=2400
  0.70  [Playtest] camera captured name=ta position=(3400,4450) height=2400
  0.70  [Playtest] screenshot at 0.7 min of team 0 at (3400, 4450)
  1.00  [Playtest] eco team 0 at 1.0 min: metal +84.8 bank 4817/13100, energy +4844.0 bank 1004117/1010200, units 25
  2.00  [Playtest] eco team 0 at 2.0 min: metal +84.8 bank 9274/13100, energy +4844.0 bank 1002144/1010200, units 24
  3.00  [Playtest] eco team 0 at 3.0 min: metal +84.8 bank 13000/13000, energy +4844.0 bank 1002465/1010100, units 20
  3.00  [Playtest] camera requested (3400,4450) height=3200
  3.00  [Playtest] camera captured name=ta position=(3400,4450) height=3200
  3.00  [Playtest] screenshot at 3.0 min of team 0 at (3400, 4450)
  4.00  [Playtest] eco team 0 at 4.0 min: metal +84.8 bank 13000/13000, energy +4844.0 bank 1005105/1010100, units 20
  5.00  [Playtest] eco team 0 at 5.0 min: metal +84.8 bank 13000/13000, energy +4844.0 bank 1007700/1010100, units 20
  6.00  [Playtest] eco team 0 at 6.0 min: metal +84.8 bank 13000/13000, energy +4844.0 bank 1007700/1010100, units 20
```

## Native lines (all AIs, first 120)

```
  0.18  RESERVE: zone 1 at (2248, 4408) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2248, 4408) facing 1 (id 1)
  0.18  RESERVE: zone 2 at (2248, 4360) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2248, 4360) facing 1 (id 2)
  0.18  RESERVE: zone 3 at (2248, 4312) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2248, 4312) facing 1 (id 3)
  0.18  RESERVE: zone 4 at (2248, 4264) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2248, 4264) facing 1 (id 4)
  0.18  RESERVE: zone 5 at (2248, 4216) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2248, 4216) facing 1 (id 5)
  0.18  RESERVE: zone 6 at (2296, 4408) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2296, 4408) facing 1 (id 6)
  0.18  RESERVE: zone 7 at (2296, 4360) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2296, 4360) facing 1 (id 7)
  0.18  RESERVE: zone 8 at (2296, 4312) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2296, 4312) facing 1 (id 8)
  0.18  RESERVE: zone 9 at (2296, 4264) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2296, 4264) facing 1 (id 9)
  0.18  RESERVE: zone 10 at (2296, 4216) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2296, 4216) facing 1 (id 10)
  0.18  RESERVE: zone 1 released
  0.18  RESERVE: zone 2 released
  0.18  RESERVE: zone 3 released
  0.18  RESERVE: zone 4 released
  0.18  RESERVE: zone 5 released
  0.18  RESERVE: zone 6 released
  0.18  RESERVE: zone 7 released
  0.18  RESERVE: zone 8 released
  0.18  RESERVE: zone 9 released
  0.18  RESERVE: zone 10 released
  0.18  RESERVE: zone 11 at (2200, 4344) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2200, 4344) facing 1 (id 11)
  0.18  RESERVE: zone 12 at (2200, 4296) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2200, 4296) facing 1 (id 12)
  0.18  RESERVE: zone 13 at (2200, 4248) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2200, 4248) facing 1 (id 13)
  0.18  RESERVE: zone 14 at (2200, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2200, 4200) facing 1 (id 14)
  0.18  RESERVE: zone 15 at (2200, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2200, 4152) facing 1 (id 15)
  0.18  RESERVE: zone 16 at (2248, 4344) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2248, 4344) facing 1 (id 16)
  0.18  RESERVE: zone 17 at (2248, 4296) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2248, 4296) facing 1 (id 17)
  0.18  RESERVE: zone 18 at (2248, 4248) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2248, 4248) facing 1 (id 18)
  0.18  RESERVE: zone 19 at (2248, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2248, 4200) facing 1 (id 19)
  0.18  RESERVE: zone 20 at (2248, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2248, 4152) facing 1 (id 20)
  0.18  RESERVE: zone 21 at (2296, 4344) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2296, 4344) facing 1 (id 21)
  0.18  RESERVE: zone 22 at (2296, 4296) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2296, 4296) facing 1 (id 22)
  0.18  RESERVE: zone 23 at (2296, 4248) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2296, 4248) facing 1 (id 23)
  0.18  RESERVE: zone 24 at (2296, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2296, 4200) facing 1 (id 24)
  0.18  RESERVE: zone 25 at (2296, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2296, 4152) facing 1 (id 25)
  0.18  RESERVE: zone 11 released
  0.18  RESERVE: zone 12 released
  0.18  RESERVE: zone 13 released
  0.18  RESERVE: zone 14 released
  0.18  RESERVE: zone 15 released
  0.18  RESERVE: zone 16 released
  0.18  RESERVE: zone 17 released
  0.18  RESERVE: zone 18 released
  0.18  RESERVE: zone 19 released
  0.18  RESERVE: zone 20 released
  0.18  RESERVE: zone 21 released
  0.18  RESERVE: zone 22 released
  0.18  RESERVE: zone 23 released
  0.18  RESERVE: zone 24 released
  0.18  RESERVE: zone 25 released
  0.18  RESERVE: zone 26 at (2184, 4280) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2184, 4280) facing 1 (id 26)
  0.18  RESERVE: zone 27 at (2184, 4232) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2184, 4232) facing 1 (id 27)
  0.18  RESERVE: zone 28 at (2184, 4184) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2184, 4184) facing 1 (id 28)
  0.18  RESERVE: zone 29 at (2184, 4136) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2184, 4136) facing 1 (id 29)
  0.18  RESERVE: zone 26 released
  0.18  RESERVE: zone 27 released
  0.18  RESERVE: zone 28 released
  0.18  RESERVE: zone 29 released
  0.18  RESERVE: zone 30 at (2200, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2200, 4200) facing 1 (id 30)
  0.18  RESERVE: zone 31 at (2200, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2200, 4152) facing 1 (id 31)
  0.18  RESERVE: zone 32 at (2200, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2200, 4104) facing 1 (id 32)
  0.18  RESERVE: zone 30 released
  0.18  RESERVE: zone 31 released
  0.18  RESERVE: zone 32 released
  0.18  RESERVE: zone 33 at (2248, 4136) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2248, 4136) facing 1 (id 33)
  0.18  RESERVE: zone 34 at (2248, 4088) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (2248, 4088) facing 1 (id 34)
  0.18  RESERVE: zone 33 released
  0.18  RESERVE: zone 34 released
  0.18  RESERVE: corridor 35 at (2450, 4688) facing 0, 13x30 cells: 260 of 390 held
  0.18  RESERVE: zone 36 at (1666, 4400) facing 1, 41x40 cells: 1628 of 1640 held
  0.18  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (1762, 4400) facing 1: 16 of 16 slots (group 1, held, zone)
  0.18  RESERVE: armuwfus at (1536, 4416) facing 1 (id 51)
  0.18  RESERVE: packed armuwfus at (1536, 4416) facing 1 in zone 36, 313 from a turret (id 51, group 0, 1054 candidates)
  0.20  RESERVE: zone 37 at (2376, 4088) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (2376, 4088) facing 1 (id 52)
  0.20  RESERVE: zone 38 at (2376, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (2376, 4040) facing 1 (id 53)
  0.20  RESERVE: zone 37 released
  0.20  RESERVE: zone 38 released
  0.20  RESERVE: zone 39 at (2456, 4088) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (2456, 4088) facing 1 (id 54)
  0.20  RESERVE: zone 40 at (2456, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (2456, 4040) facing 1 (id 55)
  0.20  RESERVE: zone 39 released
  0.20  RESERVE: zone 40 released
  0.20  RESERVE: zone 41 at (2520, 4136) facing 1, 3x3 cells: 9 of 9 held
```
