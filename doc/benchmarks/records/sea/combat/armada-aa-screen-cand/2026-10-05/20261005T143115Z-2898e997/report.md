# Playtest report: PASS

- Verdict: **PASS** (reached 6 min)
- Game time reached: 6.0 min (frame 10800); wall 93 s
- DLL: build-theatres\d202\build-4\SkirmishAI.dll (9af405acf9a6180b); AI BARbTest/test; staged 2026-10-05T11:29:38
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea-aa-screen.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\armada-aa-screen-cand\supreme\20261005T142938Z-5e55e23c\runs\20261005T143115Z-2898e997\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:31.612719][f=-000001] [SeaArena] frame=0 loaded case=armada-aa-screen control=false` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:40.892175][f=0000301] [SeaArena] frame=301 spawn id=28301 team=0 unit=armpt` |
| expect `orders` | seen at 1.0 min | `[t=00:00:47.861995][f=0001800] [SeaArena] frame=1800 orders team=1 apm=6 repeated=1` |
| expect `physical_patrol` | seen at 0.2 min | `[t=00:00:41.605145][f=0000450] [SeaArena] frame=450 boat id=28301 x=6580 z=10848 patrol=true target=-1` |
| expect `physical_air_damage` | seen at 1.7 min | `[t=00:00:55.148466][f=0003030] [SeaArena] frame=3030 damage victim=30878 attacker=7986 team=0 amount=1.3 attackerUnit=armpt victimUnit=armbrawl produced=false` |
| expect `screen` | seen at 1.7 min | `[SEA][AAFormation] id=6218 body=2 slot=0 target=7596 goal=6500,10540 unit=armpt` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\armada-aa-screen-cand\supreme\20261005T142938Z-5e55e23c\runs\20261005T143115Z-2898e997\screen_2026-10-05_14-30-31-285.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\armada-aa-screen-cand\supreme\20261005T142938Z-5e55e23c\runs\20261005T143115Z-2898e997\screen_2026-10-05_14-30-36-203.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\armada-aa-screen-cand\supreme\20261005T142938Z-5e55e23c\runs\20261005T143115Z-2898e997\screen_2026-10-05_14-30-39-771.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\armada-aa-screen-cand\supreme\20261005T142938Z-5e55e23c\runs\20261005T143115Z-2898e997\screen_2026-10-05_14-30-41-994.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\armada-aa-screen-cand\supreme\20261005T142938Z-5e55e23c\runs\20261005T143115Z-2898e997\screen_2026-10-05_14-30-46-720.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\armada-aa-screen-cand\supreme\20261005T142938Z-5e55e23c\runs\20261005T143115Z-2898e997\screen_2026-10-05_14-31-02-692.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 8, 0 shots, end at 6.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.00  [Playtest] speed 8
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.19  [Playtest] finished armfrad team 0 at 0.19 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 20
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 17
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 17
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 17
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 17
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000000/1000000, units 17
```

## Native lines (all AIs, first 120)

```
```
