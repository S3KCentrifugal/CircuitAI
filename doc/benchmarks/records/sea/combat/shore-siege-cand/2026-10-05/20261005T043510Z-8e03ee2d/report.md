# Playtest report: PASS

- Verdict: **PASS** (reached 6 min)
- Game time reached: 6.1 min (frame 10980); wall 71 s
- DLL: build-theatres\d200\build-3\SkirmishAI.dll (bcac8c987b1d8164); AI BARbTest/test; staged 2026-10-05T01:33:55
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\shore-siege-cand\glacial\20261005T043355Z-e39c6c21\runs\20261005T043510Z-8e03ee2d\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:28.401042][f=-000001] [SeaArena] frame=0 loaded case=shore-siege control=false` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:36.248882][f=0000301] [SeaArena] frame=301 spawn id=24620 team=0 unit=armmship` |
| expect `combat` | seen at 0.4 min | `[t=00:00:37.323872][f=0000690] [SeaArena] frame=690 damage victim=124 attacker=5984 team=0 amount=235.2 attackerUnit=armroy victimUnit=cortl produced=false` |
| expect `orders` | seen at 1.0 min | `[t=00:00:42.945529][f=0001800] [SeaArena] frame=1800 orders team=1 apm=44 repeated=7` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\shore-siege-cand\glacial\20261005T043355Z-e39c6c21\runs\20261005T043510Z-8e03ee2d\screen_2026-10-05_04-34-37-769.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\shore-siege-cand\glacial\20261005T043355Z-e39c6c21\runs\20261005T043510Z-8e03ee2d\screen_2026-10-05_04-34-40-550.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\shore-siege-cand\glacial\20261005T043355Z-e39c6c21\runs\20261005T043510Z-8e03ee2d\screen_2026-10-05_04-34-53-303.png

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
  0.17  [Playtest] finished armmship team 0 at 0.17 min
  0.17  [Playtest] finished armmship team 0 at 0.17 min
  0.17  [Playtest] finished armmship team 0 at 0.17 min
  0.19  [Playtest] finished armfrad team 0 at 0.19 min
  0.19  [Playtest] finished armason team 0 at 0.19 min
  0.40  [Playtest] camera requested (3400,4450) height=2400
  0.40  [Playtest] camera captured name=ta position=(3400,4450) height=2400
  0.40  [Playtest] screenshot at 0.4 min of team 0 at (3400, 4450)
  0.70  [Playtest] camera requested (3400,4450) height=2400
  0.70  [Playtest] camera captured name=ta position=(3400,4450) height=2400
  0.70  [Playtest] screenshot at 0.7 min of team 0 at (3400, 4450)
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 9
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 9
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 9
  3.00  [Playtest] camera requested (3400,4450) height=3200
  3.00  [Playtest] camera captured name=ta position=(3400,4450) height=3200
  3.00  [Playtest] screenshot at 3.0 min of team 0 at (3400, 4450)
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 9
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 9
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 9
```

## Native lines (all AIs, first 120)

```
  0.20  RESERVE: zone 1 at (3584, 4656) facing 3, 12x12 cells: 144 of 144 held
  0.20  RESERVE: armasy at (3584, 4656) facing 3 (id 1)
  0.20  RESERVE: corridor 2 at (3248, 4656) facing 3, 30x18 cells: 540 of 540 held
  0.20  RESERVE: zone 3 at (3960, 4744) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3960, 4744) facing 3 (id 2)
  0.20  RESERVE: zone 4 at (3960, 4792) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3960, 4792) facing 3 (id 3)
  0.20  RESERVE: zone 3 released
  0.20  RESERVE: zone 4 released
  0.20  RESERVE: zone 5 at (3880, 4760) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3880, 4760) facing 3 (id 4)
  0.20  RESERVE: zone 6 at (3880, 4808) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3880, 4808) facing 3 (id 5)
  0.20  RESERVE: zone 7 at (3880, 4856) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3880, 4856) facing 3 (id 6)
  0.20  RESERVE: zone 8 at (3880, 4904) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3880, 4904) facing 3 (id 7)
  0.20  RESERVE: zone 5 released
  0.20  RESERVE: zone 6 released
  0.20  RESERVE: zone 7 released
  0.20  RESERVE: zone 8 released
  0.20  RESERVE: zone 9 at (3800, 4744) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3800, 4744) facing 3 (id 8)
  0.20  RESERVE: zone 10 at (3800, 4792) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3800, 4792) facing 3 (id 9)
  0.20  RESERVE: zone 11 at (3800, 4840) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3800, 4840) facing 3 (id 10)
  0.20  RESERVE: zone 12 at (3800, 4888) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3800, 4888) facing 3 (id 11)
  0.20  RESERVE: zone 13 at (3800, 4936) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3800, 4936) facing 3 (id 12)
  0.20  RESERVE: zone 14 at (3752, 4744) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3752, 4744) facing 3 (id 13)
  0.20  RESERVE: zone 15 at (3752, 4792) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3752, 4792) facing 3 (id 14)
  0.20  RESERVE: zone 16 at (3752, 4840) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3752, 4840) facing 3 (id 15)
  0.20  RESERVE: zone 17 at (3752, 4888) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3752, 4888) facing 3 (id 16)
  0.20  RESERVE: zone 18 at (3752, 4936) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3752, 4936) facing 3 (id 17)
  0.20  RESERVE: zone 19 at (3704, 4744) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3704, 4744) facing 3 (id 18)
  0.20  RESERVE: zone 20 at (3704, 4792) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3704, 4792) facing 3 (id 19)
  0.20  RESERVE: zone 21 at (3704, 4840) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3704, 4840) facing 3 (id 20)
  0.20  RESERVE: zone 22 at (3704, 4888) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3704, 4888) facing 3 (id 21)
  0.20  RESERVE: zone 23 at (3704, 4936) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3704, 4936) facing 3 (id 22)
  0.20  RESERVE: zone 9 released
  0.20  RESERVE: zone 10 released
  0.20  RESERVE: zone 11 released
  0.20  RESERVE: zone 12 released
  0.20  RESERVE: zone 13 released
  0.20  RESERVE: zone 14 released
  0.20  RESERVE: zone 15 released
  0.20  RESERVE: zone 16 released
  0.20  RESERVE: zone 17 released
  0.20  RESERVE: zone 18 released
  0.20  RESERVE: zone 19 released
  0.20  RESERVE: zone 20 released
  0.20  RESERVE: zone 21 released
  0.20  RESERVE: zone 22 released
  0.20  RESERVE: zone 23 released
  0.20  RESERVE: zone 24 at (3752, 4696) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3752, 4696) facing 3 (id 23)
  0.20  RESERVE: zone 25 at (3752, 4744) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3752, 4744) facing 3 (id 24)
  0.20  RESERVE: zone 26 at (3752, 4792) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3752, 4792) facing 3 (id 25)
  0.20  RESERVE: zone 27 at (3752, 4840) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3752, 4840) facing 3 (id 26)
  0.20  RESERVE: zone 28 at (3752, 4888) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3752, 4888) facing 3 (id 27)
  0.20  RESERVE: zone 29 at (3704, 4696) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3704, 4696) facing 3 (id 28)
  0.20  RESERVE: zone 30 at (3704, 4744) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3704, 4744) facing 3 (id 29)
  0.20  RESERVE: zone 31 at (3704, 4792) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3704, 4792) facing 3 (id 30)
  0.20  RESERVE: zone 32 at (3704, 4840) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3704, 4840) facing 3 (id 31)
  0.20  RESERVE: zone 33 at (3704, 4888) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3704, 4888) facing 3 (id 32)
  0.20  RESERVE: zone 24 released
  0.20  RESERVE: zone 25 released
  0.20  RESERVE: zone 26 released
  0.20  RESERVE: zone 27 released
  0.20  RESERVE: zone 28 released
  0.20  RESERVE: zone 29 released
  0.20  RESERVE: zone 30 released
  0.20  RESERVE: zone 31 released
  0.20  RESERVE: zone 32 released
  0.20  RESERVE: zone 33 released
  0.20  RESERVE: zone 34 at (3704, 4632) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3704, 4632) facing 3 (id 33)
  0.20  RESERVE: zone 35 at (3704, 4680) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3704, 4680) facing 3 (id 34)
  0.20  RESERVE: zone 36 at (3704, 4728) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3704, 4728) facing 3 (id 35)
  0.20  RESERVE: zone 37 at (3704, 4776) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3704, 4776) facing 3 (id 36)
  0.20  RESERVE: zone 38 at (3704, 4824) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3704, 4824) facing 3 (id 37)
  0.20  RESERVE: zone 34 released
  0.20  RESERVE: zone 35 released
  0.20  RESERVE: zone 36 released
  0.20  RESERVE: zone 37 released
  0.20  RESERVE: zone 38 released
  0.20  RESERVE: zone 39 at (3704, 4488) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3704, 4488) facing 3 (id 38)
  0.20  RESERVE: zone 40 at (3704, 4536) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3704, 4536) facing 3 (id 39)
  0.20  RESERVE: zone 41 at (3704, 4584) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3704, 4584) facing 3 (id 40)
  0.20  RESERVE: zone 42 at (3704, 4632) facing 3, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (3704, 4632) facing 3 (id 41)
  0.20  RESERVE: zone 43 at (3704, 4680) facing 3, 3x3 cells: 9 of 9 held
```
