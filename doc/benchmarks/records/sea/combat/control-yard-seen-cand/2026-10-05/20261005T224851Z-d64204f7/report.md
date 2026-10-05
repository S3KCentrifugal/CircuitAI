# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 0.2 min (frame 300); wall 42 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (15958e3e8775d55b); AI BARbTest/test; staged 2026-10-05T19:48:06
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea-control-visible-yard.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\control-yard-seen-cand\supreme\20261005T224805Z-85900259\runs\20261005T224851Z-d64204f7\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:31.689190][f=-000001] [SeaArena] frame=0 loaded case=control-yard-seen control=false` |
| expect `yard-visible` | **missing** (by 1 min) | |
| expect `yard-damaged` | **missing** (by 3 min) | |
| expect `yard-destroyed` | **missing** (by 4 min) | |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | **hit** | `[t=00:00:40.830510][f=0000300] [SeaArena] frame=300 ERROR dry_site=armroy x=6680 z=2100` |
| forbid `crash` | clean |  |

## Failures

- forbid 'fixture' hit at 0.2 min: [t=00:00:40.830510][f=0000300] [SeaArena] frame=300 ERROR dry_site=armroy x=6680 z=2100
- forbid 'fixture' hit at 0.2 min: [t=00:00:40.830542][f=0000300] [SeaArena] frame=300 ERROR dry_site=armroy x=6680 z=2280
- forbid 'fixture' hit at 0.2 min: [t=00:00:40.830564][f=0000300] [SeaArena] frame=300 ERROR dry_site=armroy x=6500 z=2460
- forbid 'fixture' hit at 0.2 min: [t=00:00:40.830583][f=0000300] [SeaArena] frame=300 ERROR dry_site=armroy x=6680 z=2460
- forbid 'fixture' hit at 0.2 min: [t=00:00:40.830610][f=0000300] [SeaArena] frame=300 ERROR dry_site=armroy x=6500 z=2640

## Screenshots

- none

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 8, 3 shots, end at 4.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.00  [Playtest] speed 8
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
```

## Native lines (all AIs, first 120)

```
```
