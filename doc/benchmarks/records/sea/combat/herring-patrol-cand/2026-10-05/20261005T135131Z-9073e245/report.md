# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 2.2 min (frame 3900); wall 59 s
- DLL: build-theatres\d200\build-3\SkirmishAI.dll (bcac8c987b1d8164); AI BARbTest/test; staged 2026-10-05T10:50:29
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/cortex/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea-patrol.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-patrol-cand\supreme\20261005T135029Z-e0fe9352\runs\20261005T135131Z-9073e245\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:33.775935][f=-000001] [SeaArena] frame=0 loaded case=herring-patrol control=false` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:42.634234][f=0000302] [SeaArena] frame=302 spawn id=28301 team=0 unit=corpt` |
| expect `orders` | seen at 1.0 min | `[t=00:00:48.900888][f=0001800] [SeaArena] frame=1800 orders team=1 apm=6 repeated=1` |
| expect `physical_patrol` | **missing** (by 2 min) | |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Failures

- 'physical_patrol' not seen by 2.0 min

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-patrol-cand\supreme\20261005T135029Z-e0fe9352\runs\20261005T135131Z-9073e245\screen_2026-10-05_13-51-20-220.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-patrol-cand\supreme\20261005T135029Z-e0fe9352\runs\20261005T135131Z-9073e245\screen_2026-10-05_13-51-25-989.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-patrol-cand\supreme\20261005T135029Z-e0fe9352\runs\20261005T135131Z-9073e245\screen_2026-10-05_13-51-31-164.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 10, 5 shots, end at 6.5 min
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
  0.75  [Playtest] camera requested (6800,10800) height=4400
  0.75  [Playtest] camera captured name=ta position=(6800,10800) height=4400
  0.75  [Playtest] screenshot at 0.8 min of team 0 at (6800, 10800)
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 13
  1.50  [Playtest] camera requested (6800,10800) height=5400
  1.50  [Playtest] camera captured name=ta position=(6800,10800) height=5400
  1.50  [Playtest] screenshot at 1.5 min of team 0 at (6800, 10800)
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 13
```

## Native lines (all AIs, first 120)

```
```
