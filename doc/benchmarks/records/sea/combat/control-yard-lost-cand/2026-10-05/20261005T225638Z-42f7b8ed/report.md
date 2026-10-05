# Playtest report: PASS

- Verdict: **PASS** (reached 4 min)
- Game time reached: 4.5 min (frame 8100); wall 1 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (15958e3e8775d55b); AI BARbTest/test; staged 2026-10-05T19:52:08
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea-control-lost-yard.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\control-yard-lost-cand\supreme\20261005T225208Z-e0873a13\runs\20261005T225638Z-42f7b8ed\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:31.112053][f=-000001] [SeaArena] frame=0 loaded case=control-yard-lost control=false` |
| expect `yard-visible` | seen at 0.2 min | `[t=00:00:41.753569][f=0000330] [SeaArena] frame=330 detected id=17119 unit=corsy` |
| expect `radar-removed` | seen at 0.2 min | `[t=00:00:42.998236][f=0000450] [SeaArena] frame=450 fixture_removed team=0 unit=armfrad count=1` |
| expect `yard-lost-from-vision` | seen at 0.3 min | `[t=00:00:44.399094][f=0000600] [SeaArena] frame=600 objective id=17119 unit=corsy los=false radar=false health=4300 progress=1` |
| expect `yard-damaged` | seen at 0.7 min | `[t=00:00:50.987363][f=0001245] [SeaArena] frame=1245 damage victim=17119 attacker=14996 team=0 amount=235.1 attackerUnit=armroy victimUnit=corsy produced=false` |
| expect `yard-destroyed` | seen at 0.8 min | `[t=00:00:52.163935][f=0001386] [SeaArena] frame=1386 death id=17119 team=1 cost=450 attackerTeam=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\control-yard-lost-cand\supreme\20261005T225208Z-e0873a13\runs\20261005T225638Z-42f7b8ed\screen_2026-10-05_22-54-31-968.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\control-yard-lost-cand\supreme\20261005T225208Z-e0873a13\runs\20261005T225638Z-42f7b8ed\screen_2026-10-05_22-54-48-010.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\control-yard-lost-cand\supreme\20261005T225208Z-e0873a13\runs\20261005T225638Z-42f7b8ed\screen_2026-10-05_22-55-11-450.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 4, 3 shots, end at 4.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.00  [Playtest] speed 4
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.18  [Playtest] finished armfrad team 0 at 0.18 min
  0.50  [Playtest] camera requested (5500,1250) height=4000
  0.51  [Playtest] camera captured name=ta position=(5500,1250) height=4000
  0.51  [Playtest] screenshot at 0.5 min of team 0 at (5500, 1250)
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 9
  1.50  [Playtest] camera requested (5500,1600) height=5000
  1.50  [Playtest] camera captured name=ta position=(5500,1600) height=5000
  1.50  [Playtest] screenshot at 1.5 min of team 0 at (5500, 1600)
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 9
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 9
  3.00  [Playtest] camera requested (5300,2400) height=6000
  3.00  [Playtest] camera captured name=ta position=(5300,2400) height=6000
  3.00  [Playtest] screenshot at 3.0 min of team 0 at (5300, 2400)
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 9
  4.50  [Playtest] end at 4.5 min: quitting
```

## Native lines (all AIs, first 120)

```
  0.18  RESERVE: zone 1 at (4968, 824) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4968, 824) facing 2 (id 1)
  0.18  RESERVE: zone 1 released
  0.18  RESERVE: zone 2 at (4712, 648) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4712, 648) facing 2 (id 2)
  0.18  RESERVE: zone 3 at (4664, 648) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4664, 648) facing 2 (id 3)
  0.18  RESERVE: zone 4 at (4616, 648) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4616, 648) facing 2 (id 4)
  0.18  RESERVE: zone 5 at (4568, 648) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4568, 648) facing 2 (id 5)
  0.18  RESERVE: zone 6 at (4520, 648) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4520, 648) facing 2 (id 6)
  0.18  RESERVE: zone 7 at (4712, 600) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4712, 600) facing 2 (id 7)
  0.18  RESERVE: zone 8 at (4664, 600) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4664, 600) facing 2 (id 8)
  0.18  RESERVE: zone 9 at (4616, 600) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4616, 600) facing 2 (id 9)
  0.18  RESERVE: zone 10 at (4568, 600) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4568, 600) facing 2 (id 10)
  0.18  RESERVE: zone 11 at (4520, 600) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4520, 600) facing 2 (id 11)
  0.18  RESERVE: zone 12 at (4712, 552) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4712, 552) facing 2 (id 12)
  0.18  RESERVE: zone 13 at (4664, 552) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4664, 552) facing 2 (id 13)
  0.18  RESERVE: zone 14 at (4616, 552) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4616, 552) facing 2 (id 14)
  0.18  RESERVE: zone 15 at (4568, 552) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4568, 552) facing 2 (id 15)
  0.18  RESERVE: zone 16 at (4520, 552) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4520, 552) facing 2 (id 16)
  0.18  RESERVE: zone 17 at (4712, 504) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4712, 504) facing 2 (id 17)
  0.18  RESERVE: zone 18 at (4664, 504) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4664, 504) facing 2 (id 18)
  0.18  RESERVE: zone 19 at (4616, 504) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4616, 504) facing 2 (id 19)
  0.18  RESERVE: zone 20 at (4568, 504) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4568, 504) facing 2 (id 20)
  0.18  RESERVE: zone 2 released
  0.18  RESERVE: zone 3 released
  0.18  RESERVE: zone 4 released
  0.18  RESERVE: zone 5 released
  0.18  RESERVE: zone 6 released
  0.18  RESERVE: zone 7 released
  0.18  RESERVE: zone 8 released
  0.18  RESERVE: zone 9 released
  0.18  RESERVE: zone 10 released
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
  0.18  RESERVE: zone 21 at (4712, 568) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4712, 568) facing 2 (id 21)
  0.18  RESERVE: zone 22 at (4664, 568) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4664, 568) facing 2 (id 22)
  0.18  RESERVE: zone 23 at (4616, 568) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4616, 568) facing 2 (id 23)
  0.18  RESERVE: zone 24 at (4568, 568) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4568, 568) facing 2 (id 24)
  0.18  RESERVE: zone 25 at (4520, 568) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4520, 568) facing 2 (id 25)
  0.18  RESERVE: zone 26 at (4712, 520) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4712, 520) facing 2 (id 26)
  0.18  RESERVE: zone 27 at (4664, 520) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4664, 520) facing 2 (id 27)
  0.18  RESERVE: zone 28 at (4616, 520) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4616, 520) facing 2 (id 28)
  0.18  RESERVE: zone 29 at (4568, 520) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4568, 520) facing 2 (id 29)
  0.18  RESERVE: zone 30 at (4520, 520) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4520, 520) facing 2 (id 30)
  0.18  RESERVE: zone 31 at (4712, 472) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4712, 472) facing 2 (id 31)
  0.18  RESERVE: zone 32 at (4664, 472) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4664, 472) facing 2 (id 32)
  0.18  RESERVE: zone 33 at (4616, 472) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4616, 472) facing 2 (id 33)
  0.18  RESERVE: zone 34 at (4568, 472) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4568, 472) facing 2 (id 34)
  0.18  RESERVE: zone 21 released
  0.18  RESERVE: zone 22 released
  0.18  RESERVE: zone 23 released
  0.18  RESERVE: zone 24 released
  0.18  RESERVE: zone 25 released
  0.18  RESERVE: zone 26 released
  0.18  RESERVE: zone 27 released
  0.18  RESERVE: zone 28 released
  0.18  RESERVE: zone 29 released
  0.18  RESERVE: zone 30 released
  0.18  RESERVE: zone 31 released
  0.18  RESERVE: zone 32 released
  0.18  RESERVE: zone 33 released
  0.18  RESERVE: zone 34 released
  0.18  RESERVE: corridor 35 at (4800, 1088) facing 0, 12x30 cells: 228 of 360 held
  0.18  RESERVE: zone 36 at (4800, 1584) facing 2, 40x40 cells: 1552 of 1600 held
  0.18  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (4800, 1488) facing 2: 16 of 16 slots (group 1, held, zone)
  0.18  RESERVE: armuwfus at (4784, 1712) facing 2 (id 51)
  0.18  RESERVE: packed armuwfus at (4784, 1712) facing 2 in zone 36, 313 from a turret (id 51, group 0, 972 candidates)
  0.20  RESERVE: zone 37 at (4904, 456) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (4904, 456) facing 2 (id 52)
  0.20  RESERVE: zone 38 at (4856, 456) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (4856, 456) facing 2 (id 53)
  0.20  RESERVE: zone 39 at (4808, 456) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (4808, 456) facing 2 (id 54)
  0.20  RESERVE: zone 40 at (4760, 456) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (4760, 456) facing 2 (id 55)
  0.20  RESERVE: zone 41 at (4712, 456) facing 2, 3x3 cells: 9 of 9 held
  0.20  RESERVE: armnanotcplat at (4712, 456) facing 2 (id 56)
  0.20  RESERVE: zone 37 released
  0.20  RESERVE: zone 38 released
  0.20  RESERVE: zone 39 released
```
