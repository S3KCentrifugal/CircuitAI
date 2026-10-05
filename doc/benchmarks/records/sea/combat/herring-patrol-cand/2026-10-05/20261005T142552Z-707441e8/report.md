# Playtest report: PASS

- Verdict: **PASS** (reached 6 min)
- Game time reached: 6.1 min (frame 10950); wall 93 s
- DLL: build-theatres\d202\build-4\SkirmishAI.dll (9af405acf9a6180b); AI BARbTest/test; staged 2026-10-05T11:24:16
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/cortex/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea-patrol.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-patrol-cand\supreme\20261005T142415Z-37ef9a2c\runs\20261005T142552Z-707441e8\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:31.179798][f=-000001] [SeaArena] frame=0 loaded case=herring-patrol control=false` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:40.357596][f=0000301] [SeaArena] frame=301 spawn id=28301 team=0 unit=corpt` |
| expect `orders` | seen at 1.0 min | `[t=00:00:47.327998][f=0001800] [SeaArena] frame=1800 orders team=1 apm=6 repeated=1` |
| expect `physical_patrol` | seen at 0.2 min | `[t=00:00:40.998097][f=0000450] [SeaArena] frame=450 boat id=14996 x=6453 z=11113 patrol=true target=-1` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-patrol-cand\supreme\20261005T142415Z-37ef9a2c\runs\20261005T142552Z-707441e8\screen_2026-10-05_14-25-07-820.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-patrol-cand\supreme\20261005T142415Z-37ef9a2c\runs\20261005T142552Z-707441e8\screen_2026-10-05_14-25-12-750.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-patrol-cand\supreme\20261005T142415Z-37ef9a2c\runs\20261005T142552Z-707441e8\screen_2026-10-05_14-25-16-221.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-patrol-cand\supreme\20261005T142415Z-37ef9a2c\runs\20261005T142552Z-707441e8\screen_2026-10-05_14-25-18-450.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-patrol-cand\supreme\20261005T142415Z-37ef9a2c\runs\20261005T142552Z-707441e8\screen_2026-10-05_14-25-23-176.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-patrol-cand\supreme\20261005T142415Z-37ef9a2c\runs\20261005T142552Z-707441e8\screen_2026-10-05_14-25-39-149.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 8, 0 shots, end at 6.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished corcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side cortex ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.00  [Playtest] speed 8
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
