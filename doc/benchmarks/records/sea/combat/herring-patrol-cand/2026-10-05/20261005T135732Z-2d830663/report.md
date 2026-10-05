# Playtest report: PASS

- Verdict: **PASS** (reached 6 min)
- Game time reached: 6.0 min (frame 10800); wall 83 s
- DLL: build-theatres\d202\build-3\SkirmishAI.dll (67ac3d0e1e1989a0); AI BARbTest/test; staged 2026-10-05T10:56:06
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/cortex/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea-patrol.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-patrol-cand\supreme\20261005T135606Z-d907a163\runs\20261005T135732Z-2d830663\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:31.495270][f=-000001] [SeaArena] frame=0 loaded case=herring-patrol control=false` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:40.447614][f=0000301] [SeaArena] frame=301 spawn id=28301 team=0 unit=corpt` |
| expect `orders` | seen at 1.0 min | `[t=00:00:46.085015][f=0001800] [SeaArena] frame=1800 orders team=1 apm=6 repeated=1` |
| expect `physical_patrol` | seen at 0.2 min | `[t=00:00:40.949396][f=0000450] [SeaArena] frame=450 boat id=14996 x=6476 z=11108 patrol=true target=-1` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-patrol-cand\supreme\20261005T135606Z-d907a163\runs\20261005T135732Z-2d830663\screen_2026-10-05_13-56-57-215.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-patrol-cand\supreme\20261005T135606Z-d907a163\runs\20261005T135732Z-2d830663\screen_2026-10-05_13-57-01-420.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-patrol-cand\supreme\20261005T135606Z-d907a163\runs\20261005T135732Z-2d830663\screen_2026-10-05_13-57-06-902.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-patrol-cand\supreme\20261005T135606Z-d907a163\runs\20261005T135732Z-2d830663\screen_2026-10-05_13-57-12-879.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-patrol-cand\supreme\20261005T135606Z-d907a163\runs\20261005T135732Z-2d830663\screen_2026-10-05_13-57-22-361.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 10, 0 shots, end at 6.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished corcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side cortex ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.00  [Playtest] speed 10
  0.05  [Playtest] frame 90 team 0 ally 0 side cortex ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 13
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 13
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 13
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 13
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 13
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 13
```

## Native lines (all AIs, first 120)

```
```
