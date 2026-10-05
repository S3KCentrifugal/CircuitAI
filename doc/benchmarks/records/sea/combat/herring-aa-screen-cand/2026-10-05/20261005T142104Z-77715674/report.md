# Playtest report: PASS

- Verdict: **PASS** (reached 6 min)
- Game time reached: 6.0 min (frame 10800); wall 93 s
- DLL: build-theatres\d202\build-4\SkirmishAI.dll (9af405acf9a6180b); AI BARbTest/test; staged 2026-10-05T11:19:28
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/cortex/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea-aa-screen.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-aa-screen-cand\supreme\20261005T141927Z-92a0d517\runs\20261005T142104Z-77715674\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:31.358941][f=-000001] [SeaArena] frame=0 loaded case=herring-aa-screen control=false` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:40.602125][f=0000302] [SeaArena] frame=302 spawn id=28301 team=0 unit=corpt` |
| expect `orders` | seen at 1.0 min | `[t=00:00:47.560204][f=0001800] [SeaArena] frame=1800 orders team=1 apm=6 repeated=1` |
| expect `physical_patrol` | seen at 0.2 min | `[t=00:00:41.284652][f=0000450] [SeaArena] frame=450 boat id=14996 x=6455 z=11112 patrol=true target=-1` |
| expect `physical_air_damage` | seen at 1.7 min | `[t=00:00:54.804321][f=0003013] [SeaArena] frame=3013 damage victim=28362 attacker=7986 team=0 amount=120.3 attackerUnit=corpt victimUnit=armbrawl produced=false` |
| expect `screen` | seen at 1.7 min | `[SEA][AAFormation] id=6218 body=2 slot=0 target=15212 goal=6500,10540 unit=corpt` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-aa-screen-cand\supreme\20261005T141927Z-92a0d517\runs\20261005T142104Z-77715674\screen_2026-10-05_14-20-20-184.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-aa-screen-cand\supreme\20261005T141927Z-92a0d517\runs\20261005T142104Z-77715674\screen_2026-10-05_14-20-25-139.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-aa-screen-cand\supreme\20261005T141927Z-92a0d517\runs\20261005T142104Z-77715674\screen_2026-10-05_14-20-28-631.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-aa-screen-cand\supreme\20261005T141927Z-92a0d517\runs\20261005T142104Z-77715674\screen_2026-10-05_14-20-30-850.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-aa-screen-cand\supreme\20261005T141927Z-92a0d517\runs\20261005T142104Z-77715674\screen_2026-10-05_14-20-35-572.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-aa-screen-cand\supreme\20261005T141927Z-92a0d517\runs\20261005T142104Z-77715674\screen_2026-10-05_14-20-51-548.png

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
  0.19  [Playtest] finished corfrad team 0 at 0.19 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 14
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 8
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 7
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 7
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 7
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 7
```

## Native lines (all AIs, first 120)

```
```
