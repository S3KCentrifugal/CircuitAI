# Playtest report: PASS

- Verdict: **PASS** (reached 9 min)
- Game time reached: 9.5 min (frame 17100); wall 161 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\d184-build-2\SkirmishAI.dll (3ecbc2deecda41e7); AI BARbTest/test; staged 2026-10-03T21:56:04
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=TECH/armada/test, 1=TECH/armada/test
- Team 0 (under test): skirmish AI None, role TECH
- Checks: turret_enemy_reclaim.json; widget loaded: yes
- Log: build-theatres\games\shared\combat\turret-enemy-reclaim\supreme\20261004T005603Z-c9d8b4be\runs\20261004T005926Z-00846d17\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `fixture loaded` | seen at -0.0 min | `[t=00:00:31.417406][f=-000001] [TurretFixture] loaded supplied=1` |
| expect `all variants` | seen at 0.2 min | `[t=00:00:39.692444][f=0000300] [TurretFixture] sites=12` |
| expect `completed` | seen at 8.0 min | `[t=00:02:23.928048][f=0014400] [TurretFixture] complete variants=12 phases=6` |
| expect `native interrupt` | seen at 1.3 min | `[t=00:00:53.442469][f=0002266] Skirmish AI <BARb playtest-test>: [TurretReclaim] interrupt turret=25978 def=armnanotct2 target=18428` |
| expect `physical reclaim` | seen at 1.3 min | `[t=00:00:53.537798][f=0002280] [TurretFixture] physical_reclaim role=TECH nano=armnanotc hp=2090` |
| expect `normal work resumes` | seen at 1.4 min | `[t=00:00:57.421047][f=0002445] [TurretFixture] resumed role=TECH nano=armnanotct2` |
| expect `lifecycle or legacy completion` | seen at 8.1 min | `[t=00:02:25.624576][f=0014655] [TurretFixture] legacy_complete` |
| forbid `fixture failure` | clean |  |
| forbid `fixture removed` | clean |  |
| forbid `script error` | clean |  |
| forbid `invariant` | clean |  |

## Screenshots

- build-theatres\games\shared\combat\turret-enemy-reclaim\supreme\20261004T005603Z-c9d8b4be\runs\20261004T005926Z-00846d17\screen_2026-10-04_00-57-36-788.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role TECH, team 0, speed 5, 0 shots, end at 9.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 100000/100000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 31
  0.00  [Playtest] speed 5
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 31
  0.17  [Playtest] finished armnanotc team 0 at 0.17 min
  0.18  [Playtest] finished armafus team 0 at 0.18 min
  0.18  [Playtest] finished armnanotct2 team 0 at 0.18 min
  0.18  [Playtest] finished armafus team 0 at 0.18 min
  0.18  [Playtest] finished cornanotc team 0 at 0.18 min
  0.18  [Playtest] finished armafus team 0 at 0.18 min
  0.18  [Playtest] finished cornanotct2 team 0 at 0.18 min
  0.18  [Playtest] finished armafus team 0 at 0.18 min
  0.18  [Playtest] finished legnanotc team 0 at 0.18 min
  0.18  [Playtest] finished armafus team 0 at 0.18 min
  0.18  [Playtest] finished legnanotct2 team 0 at 0.18 min
  0.18  [Playtest] finished armafus team 0 at 0.19 min
  0.19  [Playtest] finished armnanotcplat team 0 at 0.19 min
  0.19  [Playtest] finished armuwfus team 0 at 0.19 min
  0.19  [Playtest] finished armnanotc2plat team 0 at 0.19 min
  0.19  [Playtest] finished armuwfus team 0 at 0.19 min
  0.19  [Playtest] finished cornanotcplat team 0 at 0.19 min
  0.20  [Playtest] finished armuwfus team 0 at 0.19 min
  0.20  [Playtest] finished cornanotc2plat team 0 at 0.20 min
  0.20  [Playtest] finished armuwfus team 0 at 0.20 min
  0.20  [Playtest] finished legnanotcplat team 0 at 0.20 min
  0.20  [Playtest] finished armuwfus team 0 at 0.20 min
  0.20  [Playtest] finished legnanotct2plat team 0 at 0.20 min
  0.20  [Playtest] finished armuwfus team 0 at 0.20 min
  0.21  [Playtest] finished armmex team 0 at 0.21 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +0.0 bank 99500/99500, energy +25200.0 bank 168500/168500, units 24
  2.00  [Playtest] eco team 0 at 2.0 min: metal +0.0 bank 99500/99500, energy +25200.0 bank 168500/168500, units 24
  3.00  [Playtest] eco team 0 at 3.0 min: metal +0.0 bank 99500/99500, energy +25200.0 bank 168500/168500, units 24
  4.00  [Playtest] eco team 0 at 4.0 min: metal +0.0 bank 99500/99500, energy +25200.0 bank 168500/168500, units 24
  5.00  [Playtest] eco team 0 at 5.0 min: metal +0.0 bank 99500/99500, energy +25200.0 bank 168500/168500, units 24
  6.00  [Playtest] eco team 0 at 6.0 min: metal +0.0 bank 99500/99500, energy +25200.0 bank 168500/168500, units 24
  7.00  [Playtest] eco team 0 at 7.0 min: metal +0.0 bank 99500/99500, energy +25200.0 bank 168500/168500, units 24
  8.00  [Playtest] eco team 0 at 8.0 min: metal +0.0 bank 99500/99500, energy +25200.0 bank 168500/168500, units 24
  9.00  [Playtest] eco team 0 at 9.0 min: metal +0.0 bank 99500/99500, energy +25200.0 bank 168500/168500, units 24
  9.50  [Playtest] end at 9.5 min: quitting
```

## Native lines (all AIs, first 120)

```
```
