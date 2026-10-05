# Playtest report: FAIL

- Verdict: **FAIL** (script errors)
- Game time reached: 7.5 min (frame 13502); wall 95 s
- DLL: build-theatres\d194-build\SkirmishAI.dll (8a05e13b0b70c836); AI BARbTest/test; staged 2026-10-04T18:04:09
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=FRONT/armada/test, 2=FRONT/cortex/test
- Team 0 (under test): skirmish AI None, role AIR
- Checks: naval-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\naval-parity-armada\supreme\20261004T210409Z-f2eb5381\runs\20261004T210547Z-fd6000df\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `fixture` | seen at -0.0 min | `[t=00:00:35.868263][f=-000001] [AirNavalWatch] loaded case=parity` |
| forbid `script` | **hit** | `ild-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (83, 72) : ERR  : No matching symbol 'IsSubmarine'` |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |
| forbid `widget` | clean |  |
| forbid `false_support` | clean |  |

## Failures

- forbid 'script' hit at 0.0 min: ild-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (83, 72) : ERR  : No matching symbol 'IsSubmarine'
- forbid 'script' hit at 0.0 min: /build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (83, 59) : ERR  : No matching symbol 'IsSurfer'
- forbid 'script' hit at 0.0 min: build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (83, 45) : ERR  : No matching symbol 'IsFloater'
- forbid 'script' hit at 0.0 min: ld-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (98, 126) : ERR  : No matching symbol 'IsSubmarine'
- forbid 'script' hit at 0.0 min: build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (98, 103) : ERR  : No matching symbol 'IsSurfer'
- forbid 'script' hit at 0.0 min: build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (98, 79) : ERR  : No matching symbol 'IsFloater'
- forbid 'script' hit at 0.0 min: ild-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (83, 72) : ERR  : No matching symbol 'IsSubmarine'
- forbid 'script' hit at 0.0 min: /build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (83, 59) : ERR  : No matching symbol 'IsSurfer'
- forbid 'script' hit at 0.0 min: build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (83, 45) : ERR  : No matching symbol 'IsFloater'
- forbid 'script' hit at 0.0 min: ld-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (98, 126) : ERR  : No matching symbol 'IsSubmarine'
- forbid 'script' hit at 0.0 min: build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (98, 103) : ERR  : No matching symbol 'IsSurfer'
- forbid 'script' hit at 0.0 min: build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (98, 79) : ERR  : No matching symbol 'IsFloater'
- forbid 'script' hit at 0.0 min: ild-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (83, 72) : ERR  : No matching symbol 'IsSubmarine'
- forbid 'script' hit at 0.0 min: /build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (83, 59) : ERR  : No matching symbol 'IsSurfer'
- forbid 'script' hit at 0.0 min: build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (83, 45) : ERR  : No matching symbol 'IsFloater'
- forbid 'script' hit at 0.0 min: ld-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (98, 126) : ERR  : No matching symbol 'IsSubmarine'
- forbid 'script' hit at 0.0 min: build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (98, 103) : ERR  : No matching symbol 'IsSurfer'
- forbid 'script' hit at 0.0 min: build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (98, 79) : ERR  : No matching symbol 'IsFloater'

## Script errors

```
[t=00:00:39.222065][f=-000001] Skirmish AI <BARb playtest-test>: C:/bardev/s3k-CircuitAI/build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (83, 72) : ERR  : No matching symbol 'IsSubmarine'
[t=00:00:39.222126][f=-000001] Skirmish AI <BARb playtest-test>: C:/bardev/s3k-CircuitAI/build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (83, 59) : ERR  : No matching symbol 'IsSurfer'
[t=00:00:39.222189][f=-000001] Skirmish AI <BARb playtest-test>: C:/bardev/s3k-CircuitAI/build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (83, 45) : ERR  : No matching symbol 'IsFloater'
[t=00:00:39.222459][f=-000001] Skirmish AI <BARb playtest-test>: C:/bardev/s3k-CircuitAI/build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (98, 126) : ERR  : No matching symbol 'IsSubmarine'
[t=00:00:39.222520][f=-000001] Skirmish AI <BARb playtest-test>: C:/bardev/s3k-CircuitAI/build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (98, 103) : ERR  : No matching symbol 'IsSurfer'
[t=00:00:39.222589][f=-000001] Skirmish AI <BARb playtest-test>: C:/bardev/s3k-CircuitAI/build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (98, 79) : ERR  : No matching symbol 'IsFloater'
[t=00:00:39.409240][f=-000001] Skirmish AI <BARb playtest-test>: Script: Fix compilation errors!
[t=00:00:40.300799][f=-000001] Skirmish AI <BARb playtest-test>: C:/bardev/s3k-CircuitAI/build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (83, 72) : ERR  : No matching symbol 'IsSubmarine'
[t=00:00:40.300862][f=-000001] Skirmish AI <BARb playtest-test>: C:/bardev/s3k-CircuitAI/build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (83, 59) : ERR  : No matching symbol 'IsSurfer'
[t=00:00:40.300925][f=-000001] Skirmish AI <BARb playtest-test>: C:/bardev/s3k-CircuitAI/build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (83, 45) : ERR  : No matching symbol 'IsFloater'
[t=00:00:40.301227][f=-000001] Skirmish AI <BARb playtest-test>: C:/bardev/s3k-CircuitAI/build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (98, 126) : ERR  : No matching symbol 'IsSubmarine'
[t=00:00:40.301296][f=-000001] Skirmish AI <BARb playtest-test>: C:/bardev/s3k-CircuitAI/build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (98, 103) : ERR  : No matching symbol 'IsSurfer'
[t=00:00:40.301362][f=-000001] Skirmish AI <BARb playtest-test>: C:/bardev/s3k-CircuitAI/build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (98, 79) : ERR  : No matching symbol 'IsFloater'
[t=00:00:40.491800][f=-000001] Skirmish AI <BARb playtest-test>: Script: Fix compilation errors!
[t=00:00:41.374974][f=-000001] Skirmish AI <BARb playtest-test>: C:/bardev/s3k-CircuitAI/build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (83, 72) : ERR  : No matching symbol 'IsSubmarine'
[t=00:00:41.375037][f=-000001] Skirmish AI <BARb playtest-test>: C:/bardev/s3k-CircuitAI/build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (83, 59) : ERR  : No matching symbol 'IsSurfer'
[t=00:00:41.375106][f=-000001] Skirmish AI <BARb playtest-test>: C:/bardev/s3k-CircuitAI/build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (83, 45) : ERR  : No matching symbol 'IsFloater'
[t=00:00:41.375353][f=-000001] Skirmish AI <BARb playtest-test>: C:/bardev/s3k-CircuitAI/build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (98, 126) : ERR  : No matching symbol 'IsSubmarine'
[t=00:00:41.375414][f=-000001] Skirmish AI <BARb playtest-test>: C:/bardev/s3k-CircuitAI/build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (98, 103) : ERR  : No matching symbol 'IsSurfer'
[t=00:00:41.375477][f=-000001] Skirmish AI <BARb playtest-test>: C:/bardev/s3k-CircuitAI/build-theatres/games/air/combat/naval-parity-armada/supreme/20261004T210409Z-f2eb5381/AI/Skirmish/BARbTest/test/script/src/manager/air_base_response.as (98, 79) : ERR  : No matching symbol 'IsFloater'
```

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\naval-parity-armada\supreme\20261004T210409Z-f2eb5381\runs\20261004T210547Z-fd6000df\screen_2026-10-04_21-05-11-458.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 10, 0 shots, end at 7.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (2155, 11747) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.00  [Playtest] frame 1 team 3 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 4 ally 3 side  ai false dead false start (0, 0) units 28
  0.00  [Playtest] speed 10
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai false dead false start (2155, 11747) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai false dead false start (837, 10407) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai false dead false start (10129, 541) units 1
  0.05  [Playtest] frame 90 team 3 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 4 ally 3 side  ai false dead false start (0, 0) units 28
  0.17  [Playtest] finished armaap team 0 at 0.17 min
  0.18  [Playtest] finished armnanotc team 0 at 0.18 min
  0.18  [Playtest] finished armnanotc team 0 at 0.18 min
  0.18  [Playtest] finished armnanotc team 0 at 0.18 min
  0.18  [Playtest] finished armnanotc team 0 at 0.18 min
  0.18  [Playtest] finished armnanotc team 0 at 0.18 min
  0.18  [Playtest] finished armnanotc team 0 at 0.18 min
  0.18  [Playtest] finished armnanotc team 0 at 0.18 min
  0.18  [Playtest] finished armnanotc team 0 at 0.18 min
  0.18  [Playtest] finished armnanotc team 0 at 0.18 min
  0.18  [Playtest] finished armnanotc team 0 at 0.18 min
  0.18  [Playtest] finished armnanotc team 0 at 0.18 min
  0.18  [Playtest] finished armnanotc team 0 at 0.18 min
  0.18  [Playtest] finished armafus team 0 at 0.18 min
  0.18  [Playtest] finished armafus team 0 at 0.18 min
  0.18  [Playtest] finished armafus team 0 at 0.18 min
  0.20  [Playtest] finished armfrad team 0 at 0.20 min
  0.20  [Playtest] finished armason team 0 at 0.20 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 100100/100200, energy +9065.0 bank 1027375/1027375, units 40
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 100200/100200, energy +9065.0 bank 1027375/1027375, units 60
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 100200/100200, energy +9065.0 bank 1027375/1027375, units 60
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 100200/100200, energy +9065.0 bank 1027375/1027375, units 60
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 100200/100200, energy +9065.0 bank 1027375/1027375, units 60
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 100200/100200, energy +9065.0 bank 1027375/1027375, units 60
  7.00  [Playtest] eco team 0 at 7.0 min: metal +2.0 bank 100200/100200, energy +9065.0 bank 1027375/1027375, units 60
  7.50  [Playtest] end at 7.5 min: quitting
```

## Native lines (all AIs, first 120)

```
```
