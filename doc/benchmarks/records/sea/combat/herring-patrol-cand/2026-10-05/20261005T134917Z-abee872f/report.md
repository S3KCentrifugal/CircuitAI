# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 0.2 min (frame 300); wall 47 s
- DLL: build-theatres\d200\build-3\SkirmishAI.dll (bcac8c987b1d8164); AI BARbTest/test; staged 2026-10-05T10:48:25
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/cortex/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea-patrol.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\herring-patrol-cand\supreme\20261005T134825Z-83d33147\runs\20261005T134917Z-abee872f\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:34.413665][f=-000001] [SeaArena] frame=0 loaded case=herring-patrol control=false` |
| expect `spawn` | **missing** (by 1 min) | |
| expect `orders` | **missing** (by 2 min) | |
| expect `physical_patrol` | **missing** (by 2 min) | |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | **hit** | `[t=00:00:44.137282][f=0000300] [SeaArena] frame=300 ERROR dry_site=corpt x=5200 z=10200` |
| forbid `crash` | clean |  |

## Failures

- forbid 'fixture' hit at 0.2 min: [t=00:00:44.137282][f=0000300] [SeaArena] frame=300 ERROR dry_site=corpt x=5200 z=10200
- forbid 'fixture' hit at 0.2 min: [t=00:00:44.137313][f=0000300] [SeaArena] frame=300 ERROR dry_site=corpt x=5340 z=10200
- forbid 'fixture' hit at 0.2 min: [t=00:00:44.137333][f=0000300] [SeaArena] frame=300 ERROR dry_site=corpt x=5480 z=10200
- forbid 'fixture' hit at 0.2 min: [t=00:00:44.137362][f=0000300] [SeaArena] frame=300 ERROR dry_site=corpt x=5620 z=10200
- forbid 'fixture' hit at 0.2 min: [t=00:00:44.137382][f=0000300] [SeaArena] frame=300 ERROR dry_site=corpt x=5200 z=10340
- forbid 'fixture' hit at 0.2 min: [t=00:00:44.137402][f=0000300] [SeaArena] frame=300 ERROR dry_site=corpt x=5340 z=10340
- forbid 'fixture' hit at 0.2 min: [t=00:00:44.137437][f=0000300] [SeaArena] frame=300 ERROR dry_site=corpt x=5480 z=10340
- forbid 'fixture' hit at 0.2 min: [t=00:00:44.137457][f=0000300] [SeaArena] frame=300 ERROR dry_site=corpt x=5620 z=10340
- forbid 'fixture' hit at 0.2 min: [t=00:00:44.137476][f=0000300] [SeaArena] frame=300 ERROR dry_site=corpt x=5200 z=10480
- forbid 'fixture' hit at 0.2 min: [t=00:00:44.137495][f=0000300] [SeaArena] frame=300 ERROR dry_site=corpt x=5340 z=10480
- forbid 'fixture' hit at 0.2 min: [t=00:00:44.137515][f=0000300] [SeaArena] frame=300 ERROR dry_site=corpt x=5480 z=10480

## Screenshots

- none

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
```

## Native lines (all AIs, first 120)

```
```
