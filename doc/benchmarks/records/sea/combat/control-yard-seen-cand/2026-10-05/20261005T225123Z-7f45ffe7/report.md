# Playtest report: PASS

- Verdict: **PASS** (reached 4 min)
- Game time reached: 4.0 min (frame 7200); wall 105 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (15958e3e8775d55b); AI BARbTest/test; staged 2026-10-05T19:49:35
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea-control-visible-yard.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\control-yard-seen-cand\supreme\20261005T224934Z-5dd56760\runs\20261005T225123Z-7f45ffe7\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:31.601519][f=-000001] [SeaArena] frame=0 loaded case=control-yard-seen control=false` |
| expect `yard-visible` | seen at 0.2 min | `[t=00:00:41.821735][f=0000330] [SeaArena] frame=330 detected id=17119 unit=corsy` |
| expect `yard-damaged` | seen at 0.5 min | `[t=00:00:48.611141][f=0000953] [SeaArena] frame=953 damage victim=17119 attacker=11472 team=0 amount=235.2 attackerUnit=armroy victimUnit=corsy produced=false` |
| expect `yard-destroyed` | seen at 0.7 min | `[t=00:00:50.559059][f=0001187] [SeaArena] frame=1187 death id=17119 team=1 cost=450 attackerTeam=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\control-yard-seen-cand\supreme\20261005T224934Z-5dd56760\runs\20261005T225123Z-7f45ffe7\screen_2026-10-05_22-50-26-634.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\control-yard-seen-cand\supreme\20261005T224934Z-5dd56760\runs\20261005T225123Z-7f45ffe7\screen_2026-10-05_22-50-42-680.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\control-yard-seen-cand\supreme\20261005T224934Z-5dd56760\runs\20261005T225123Z-7f45ffe7\screen_2026-10-05_22-51-06-118.png

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
  0.50  [Playtest] camera requested (5700,2050) height=4000
  0.50  [Playtest] camera captured name=ta position=(5700,2050) height=4000
  0.50  [Playtest] screenshot at 0.5 min of team 0 at (5700, 2050)
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 10
  1.50  [Playtest] camera requested (5700,2050) height=4000
  1.50  [Playtest] camera captured name=ta position=(5700,2050) height=4000
  1.50  [Playtest] screenshot at 1.5 min of team 0 at (5700, 2050)
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 10
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 10
  3.00  [Playtest] camera requested (5700,2050) height=4000
  3.00  [Playtest] camera captured name=ta position=(5700,2050) height=4000
  3.00  [Playtest] screenshot at 3.0 min of team 0 at (5700, 2050)
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 10
```

## Native lines (all AIs, first 120)

```
  0.18  RESERVE: zone 1 at (4800, 1040) facing 2, 12x12 cells: 144 of 144 held
  0.18  RESERVE: armasy at (4800, 1040) facing 2 (id 1)
  0.18  RESERVE: corridor 2 at (4800, 704) facing 2, 18x30 cells: 524 of 540 held
  0.18  RESERVE: zone 3 at (4712, 1416) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4712, 1416) facing 2 (id 2)
  0.18  RESERVE: zone 4 at (4664, 1416) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4664, 1416) facing 2 (id 3)
  0.18  RESERVE: zone 3 released
  0.18  RESERVE: zone 4 released
  0.18  RESERVE: zone 5 at (4712, 1336) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4712, 1336) facing 2 (id 4)
  0.18  RESERVE: zone 6 at (4664, 1336) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4664, 1336) facing 2 (id 5)
  0.18  RESERVE: zone 7 at (4616, 1336) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4616, 1336) facing 2 (id 6)
  0.18  RESERVE: zone 8 at (4568, 1336) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4568, 1336) facing 2 (id 7)
  0.18  RESERVE: zone 5 released
  0.18  RESERVE: zone 6 released
  0.18  RESERVE: zone 7 released
  0.18  RESERVE: zone 8 released
  0.18  RESERVE: zone 9 at (4712, 1256) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4712, 1256) facing 2 (id 8)
  0.18  RESERVE: zone 10 at (4664, 1256) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4664, 1256) facing 2 (id 9)
  0.18  RESERVE: zone 11 at (4616, 1256) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4616, 1256) facing 2 (id 10)
  0.18  RESERVE: zone 12 at (4568, 1256) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4568, 1256) facing 2 (id 11)
  0.18  RESERVE: zone 13 at (4520, 1256) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4520, 1256) facing 2 (id 12)
  0.18  RESERVE: zone 14 at (4712, 1208) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4712, 1208) facing 2 (id 13)
  0.18  RESERVE: zone 15 at (4664, 1208) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4664, 1208) facing 2 (id 14)
  0.18  RESERVE: zone 16 at (4616, 1208) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4616, 1208) facing 2 (id 15)
  0.18  RESERVE: zone 17 at (4568, 1208) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4568, 1208) facing 2 (id 16)
  0.18  RESERVE: zone 18 at (4520, 1208) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4520, 1208) facing 2 (id 17)
  0.18  RESERVE: zone 19 at (4712, 1160) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4712, 1160) facing 2 (id 18)
  0.18  RESERVE: zone 20 at (4664, 1160) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4664, 1160) facing 2 (id 19)
  0.18  RESERVE: zone 21 at (4616, 1160) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4616, 1160) facing 2 (id 20)
  0.18  RESERVE: zone 22 at (4568, 1160) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4568, 1160) facing 2 (id 21)
  0.18  RESERVE: zone 23 at (4520, 1160) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4520, 1160) facing 2 (id 22)
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
  0.18  RESERVE: zone 21 released
  0.18  RESERVE: zone 22 released
  0.18  RESERVE: zone 23 released
  0.18  RESERVE: zone 24 at (4760, 1208) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4760, 1208) facing 2 (id 23)
  0.18  RESERVE: zone 25 at (4712, 1208) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4712, 1208) facing 2 (id 24)
  0.18  RESERVE: zone 26 at (4664, 1208) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4664, 1208) facing 2 (id 25)
  0.18  RESERVE: zone 27 at (4616, 1208) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4616, 1208) facing 2 (id 26)
  0.18  RESERVE: zone 28 at (4568, 1208) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4568, 1208) facing 2 (id 27)
  0.18  RESERVE: zone 29 at (4760, 1160) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4760, 1160) facing 2 (id 28)
  0.18  RESERVE: zone 30 at (4712, 1160) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4712, 1160) facing 2 (id 29)
  0.18  RESERVE: zone 31 at (4664, 1160) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4664, 1160) facing 2 (id 30)
  0.18  RESERVE: zone 32 at (4616, 1160) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4616, 1160) facing 2 (id 31)
  0.18  RESERVE: zone 33 at (4568, 1160) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4568, 1160) facing 2 (id 32)
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
  0.18  RESERVE: zone 34 at (4968, 1832) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4968, 1832) facing 2 (id 33)
  0.18  RESERVE: zone 34 released
  0.18  RESERVE: zone 35 at (4712, 1656) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4712, 1656) facing 2 (id 34)
  0.18  RESERVE: zone 36 at (4664, 1656) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4664, 1656) facing 2 (id 35)
  0.18  RESERVE: zone 37 at (4616, 1656) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4616, 1656) facing 2 (id 36)
  0.18  RESERVE: zone 38 at (4568, 1656) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4568, 1656) facing 2 (id 37)
  0.18  RESERVE: zone 39 at (4520, 1656) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4520, 1656) facing 2 (id 38)
  0.18  RESERVE: zone 40 at (4712, 1608) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4712, 1608) facing 2 (id 39)
  0.18  RESERVE: zone 41 at (4664, 1608) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4664, 1608) facing 2 (id 40)
  0.18  RESERVE: zone 42 at (4616, 1608) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4616, 1608) facing 2 (id 41)
  0.18  RESERVE: zone 43 at (4568, 1608) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4568, 1608) facing 2 (id 42)
  0.18  RESERVE: zone 44 at (4520, 1608) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (4520, 1608) facing 2 (id 43)
  0.18  RESERVE: zone 45 at (4712, 1560) facing 2, 3x3 cells: 9 of 9 held
```
