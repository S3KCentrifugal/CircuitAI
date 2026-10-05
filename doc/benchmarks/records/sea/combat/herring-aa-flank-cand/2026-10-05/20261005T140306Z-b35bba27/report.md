# Playtest report: PASS

- Verdict: **PASS** (reached 6 min)
- Game time reached: 6.1 min (frame 10950); wall 109 s
- DLL: build-theatres\d202\build-3\SkirmishAI.dll (67ac3d0e1e1989a0); AI BARbTest/test; staged 2026-10-05T11:01:14
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/cortex/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea-aa-screen.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-aa-flank-cand\supreme\20261005T140113Z-e09ffdc1\runs\20261005T140306Z-b35bba27\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:31.432921][f=-000001] [SeaArena] frame=0 loaded case=herring-aa-flank control=false` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:41.117330][f=0000301] [SeaArena] frame=301 spawn id=28301 team=0 unit=corpt` |
| expect `orders` | seen at 1.0 min | `[t=00:00:50.211930][f=0001800] [SeaArena] frame=1800 orders team=1 apm=6 repeated=1` |
| expect `physical_patrol` | seen at 0.2 min | `[t=00:00:42.143867][f=0000450] [SeaArena] frame=450 boat id=14996 x=6453 z=11113 patrol=true target=-1` |
| expect `physical_air_damage` | seen at 1.7 min | `[t=00:00:59.087563][f=0003052] [SeaArena] frame=3052 damage victim=17431 attacker=31764 team=0 amount=120.1 attackerUnit=corpt victimUnit=armthund produced=false` |
| expect `screen` | seen at 1.7 min | `[SEA][AAFormation] id=6218 body=2 slot=0 target=25694 goal=7900,9580` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-aa-flank-cand\supreme\20261005T140113Z-e09ffdc1\runs\20261005T140306Z-b35bba27\screen_2026-10-05_14-02-08-728.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-aa-flank-cand\supreme\20261005T140113Z-e09ffdc1\runs\20261005T140306Z-b35bba27\screen_2026-10-05_14-02-14-690.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-aa-flank-cand\supreme\20261005T140113Z-e09ffdc1\runs\20261005T140306Z-b35bba27\screen_2026-10-05_14-02-18-985.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-aa-flank-cand\supreme\20261005T140113Z-e09ffdc1\runs\20261005T140306Z-b35bba27\screen_2026-10-05_14-02-21-614.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-aa-flank-cand\supreme\20261005T140113Z-e09ffdc1\runs\20261005T140306Z-b35bba27\screen_2026-10-05_14-02-27-571.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-aa-flank-cand\supreme\20261005T140113Z-e09ffdc1\runs\20261005T140306Z-b35bba27\screen_2026-10-05_14-02-48-534.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 6, 0 shots, end at 6.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished corcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side cortex ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.00  [Playtest] speed 6
  0.05  [Playtest] frame 90 team 0 ally 0 side cortex ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.19  [Playtest] finished corfrad team 0 at 0.19 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 14
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 12
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 12
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 12
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 12
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 12
```

## Native lines (all AIs, first 120)

```
```
