# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 45.0 min (frame 81002); wall 961 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-baseline\cohort\20261003T164015Z-53db5088\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T15:37:38
- Map: Tundra Continents v2.3.1; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\tundra\runs\20261003T185343Z-bc951b46\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 2.1 min: [INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s
- forbid 'invariant' hit at 2.5 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 11.7 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 3 T2 constructors, none added
- forbid 'invariant' hit at 12.5 min: [INVARIANT] INV-014 legwin ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 13.5 min: [INVARIANT] INV-014 legwin ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 14.8 min: [INVARIANT] INV-020 no layout room for legestor for 140 s
- forbid 'invariant' hit at 15.2 min: [INVARIANT] INV-008 6 turret(s) in range of the reclaim of legalab 4518 are not on it
- forbid 'invariant' hit at 17.1 min: [t=00:01:34.767574][f=0030795] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.1 min: [t=00:01:34.781328][f=0030810] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.0 min: [INVARIANT] INV-020 no layout room for legadveconv for 189 s
- forbid 'invariant' hit at 18.0 min: [t=00:01:37.608783][f=0032400] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.0 min: [t=00:01:37.748498][f=0032415] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.0 min: [t=00:01:37.786129][f=0032430] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.0 min: [t=00:01:37.816488][f=0032445] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.0 min: [t=00:01:37.833836][f=0032460] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.0 min: [t=00:01:37.860918][f=0032475] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.1 min: [t=00:01:38.041492][f=0032490] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.1 min: [t=00:01:38.056323][f=0032505] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.1 min: [t=00:01:38.080901][f=0032520] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.1 min: [t=00:01:38.181366][f=0032535] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.1 min: [t=00:01:38.194010][f=0032550] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.1 min: [t=00:01:38.221157][f=0032565] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.8 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 19.9 min: [t=00:01:45.903992][f=0035730] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.9 min: [t=00:01:45.929538][f=0035745] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.5 min: [INVARIANT] INV-029 legaap 30807 stands 11 cells from the turrets, not tight
- forbid 'invariant' hit at 20.6 min: [t=00:01:50.440234][f=0037140] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.6 min: [t=00:01:50.467676][f=0037155] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.6 min: [t=00:01:50.505155][f=0037170] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.7 min: [t=00:01:50.575136][f=0037185] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.7 min: [t=00:01:50.600293][f=0037200] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.7 min: [t=00:01:50.676761][f=0037215] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.7 min: [t=00:01:50.692698][f=0037230] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.7 min: [t=00:01:50.743515][f=0037245] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.7 min: [t=00:01:50.763427][f=0037260] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.7 min: [t=00:01:50.790939][f=0037275] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.7 min: [t=00:01:50.812138][f=0037290] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.7 min: [t=00:01:50.844073][f=0037305] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.7 min: [t=00:01:50.863439][f=0037320] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.8 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 20.9 min: [t=00:01:51.947401][f=0037680] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.9 min: [t=00:01:51.997428][f=0037695] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.9 min: [t=00:01:52.025032][f=0037710] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.0 min: [t=00:01:52.062722][f=0037725] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.0 min: [t=00:01:52.096638][f=0037740] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.0 min: [t=00:01:52.134010][f=0037755] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.0 min: [t=00:01:52.171214][f=0037770] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.0 min: [t=00:01:52.217482][f=0037785] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.0 min: [t=00:01:52.288561][f=0037800] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.0 min: [t=00:01:52.343895][f=0037815] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.0 min: [t=00:01:52.370530][f=0037830] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.0 min: [t=00:01:52.399102][f=0037845] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.0 min: [t=00:01:52.425655][f=0037860] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.2 min: [t=00:01:53.507775][f=0038205] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.5 min: [INVARIANT] INV-020 no layout room for legadveconv for 120 s
- forbid 'invariant' hit at 21.8 min: [t=00:01:57.592927][f=0039255] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.9 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 21.9 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 22.5 min: [INVARIANT] INV-020 no layout room for legmstor for 180 s
- forbid 'invariant' hit at 22.9 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 22.9 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 23.0 min: [INVARIANT] INV-053 air constructor 15950 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 23.0 min: [INVARIANT] INV-053 air constructor 29335 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 23.0 min: [INVARIANT] INV-051 no advanced shipyard 480 s after the harbour began
- forbid 'invariant' hit at 23.5 min: [INVARIANT] INV-020 no layout room for legafus for 240 s
- forbid 'invariant' hit at 23.5 min: [INVARIANT] INV-053 air constructor 27953 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 23.5 min: [INVARIANT] INV-053 air constructor 28843 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 23.5 min: [INVARIANT] INV-053 air constructor 11930 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 23.9 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 24.0 min: [INVARIANT] INV-053 air constructor 10871 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 24.0 min: [INVARIANT] INV-053 air constructor 4516 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 24.1 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (1 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 24.5 min: [INVARIANT] INV-020 no layout room for legafus for 300 s
- forbid 'invariant' hit at 24.5 min: [INVARIANT] INV-053 air constructor 1037 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 24.5 min: [INVARIANT] INV-053 air constructor 28005 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 24.9 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 24.9 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 25.0 min: [INVARIANT] INV-053 air constructor 27152 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 25.4 min: [t=00:02:34.191729][f=0045810] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.5 min: [t=00:02:34.254259][f=0045825] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.5 min: [INVARIANT] INV-020 no layout room for legmstor for 361 s
- forbid 'invariant' hit at 25.5 min: [INVARIANT] INV-053 air constructor 6236 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 25.5 min: [INVARIANT] INV-053 air constructor 31382 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 25.5 min: [INVARIANT] INV-053 air constructor 3825 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 25.9 min: [INVARIANT] INV-029 leghp 30424 stands 25 cells from the turrets, not tight
- forbid 'invariant' hit at 25.9 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 25.9 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 26.0 min: [INVARIANT] INV-053 air constructor 7923 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 26.0 min: [INVARIANT] INV-053 air constructor 22499 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 26.5 min: [INVARIANT] INV-020 no layout room for legmstor for 421 s
- forbid 'invariant' hit at 26.5 min: [INVARIANT] INV-053 air constructor 23941 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 26.5 min: [INVARIANT] INV-053 air constructor 4516 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 26.5 min: [INVARIANT] INV-053 air constructor 11904 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 26.5 min: [INVARIANT] INV-053 air constructor 10871 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 26.9 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 27.0 min: [INVARIANT] INV-053 air constructor 25492 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 27.1 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (1 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 27.5 min: [INVARIANT] INV-020 no layout room for legafus for 481 s
- forbid 'invariant' hit at 27.5 min: [INVARIANT] INV-053 air constructor 28451 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 27.9 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 27.9 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 28.0 min: [t=00:03:07.638580][f=0050325] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 28.0 min: [t=00:03:07.697444][f=0050340] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 28.0 min: [t=00:03:07.753403][f=0050355] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 28.0 min: [t=00:03:07.820917][f=0050370] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 28.0 min: [t=00:03:07.919296][f=0050385] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 28.0 min: [t=00:03:07.993322][f=0050400] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 28.0 min: [INVARIANT] INV-053 air constructor 23988 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 28.0 min: [INVARIANT] INV-053 air constructor 16364 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 28.0 min: [INVARIANT] INV-053 air constructor 28005 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 28.0 min: [t=00:03:08.098197][f=0050415] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 28.0 min: [t=00:03:08.168006][f=0050430] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 28.0 min: [t=00:03:08.241654][f=0050445] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 28.0 min: [t=00:03:08.323698][f=0050460] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 28.0 min: [t=00:03:08.403964][f=0050475] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 28.1 min: [t=00:03:08.488902][f=0050490] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 28.1 min: [t=00:03:08.590914][f=0050505] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 28.5 min: [INVARIANT] INV-020 no layout room for legafus for 541 s
- forbid 'invariant' hit at 28.5 min: [INVARIANT] INV-053 air constructor 11930 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 28.5 min: [INVARIANT] INV-053 air constructor 23033 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 28.5 min: [INVARIANT] INV-053 air constructor 29335 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 28.5 min: [INVARIANT] INV-053 air constructor 17027 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 28.5 min: [INVARIANT] INV-053 air constructor 10557 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 28.5 min: [INVARIANT] INV-053 air constructor 28843 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 28.5 min: [INVARIANT] INV-053 air constructor 4828 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 28.5 min: [INVARIANT] INV-053 air constructor 27953 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 28.9 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 28.9 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 29.0 min: [INVARIANT] INV-053 air constructor 7319 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 29.0 min: [INVARIANT] INV-053 air constructor 31382 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 29.0 min: [INVARIANT] INV-053 air constructor 14132 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 29.5 min: [INVARIANT] INV-020 no layout room for legadveconv for 601 s
- forbid 'invariant' hit at 29.5 min: [INVARIANT] INV-053 air constructor 3825 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 29.5 min: [INVARIANT] INV-053 air constructor 27152 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 29.5 min: [INVARIANT] INV-053 air constructor 6236 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 29.5 min: [INVARIANT] INV-053 air constructor 22499 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 30.5 min: [INVARIANT] INV-020 no layout room for legmstor for 661 s
- forbid 'invariant' hit at 30.5 min: [INVARIANT] INV-053 air constructor 27675 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 30.8 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (1 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 31.0 min: [INVARIANT] INV-053 air constructor 28451 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 31.0 min: [INVARIANT] INV-053 air constructor 4828 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 31.0 min: [INVARIANT] INV-053 air constructor 16364 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 31.0 min: [INVARIANT] INV-053 air constructor 23988 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 31.1 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 31.3 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 31.5 min: [INVARIANT] INV-020 no layout room for legafus for 721 s
- forbid 'invariant' hit at 31.5 min: [INVARIANT] INV-053 air constructor 14734 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 31.5 min: [INVARIANT] INV-053 air constructor 16719 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 31.5 min: [INVARIANT] INV-053 air constructor 15950 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 31.5 min: [INVARIANT] INV-053 air constructor 29335 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 31.5 min: [INVARIANT] INV-053 air constructor 1037 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 32.0 min: [INVARIANT] INV-053 air constructor 17915 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 32.0 min: [INVARIANT] INV-053 air constructor 11205 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 32.0 min: [INVARIANT] INV-053 air constructor 24568 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 32.0 min: [INVARIANT] INV-053 air constructor 28005 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 32.0 min: [INVARIANT] INV-053 air constructor 28190 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 32.0 min: [INVARIANT] INV-053 air constructor 31382 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 32.0 min: [INVARIANT] INV-053 air constructor 700 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 32.1 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 32.5 min: [INVARIANT] INV-020 no layout room for legmstor for 781 s
- forbid 'invariant' hit at 32.5 min: [INVARIANT] INV-053 air constructor 15321 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 32.5 min: [INVARIANT] INV-053 air constructor 11904 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 32.5 min: [INVARIANT] INV-053 air constructor 23540 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 32.5 min: [INVARIANT] INV-053 air constructor 22499 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 32.5 min: [INVARIANT] INV-053 air constructor 23941 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 33.0 min: [INVARIANT] INV-053 air constructor 29440 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 33.0 min: [INVARIANT] INV-053 air constructor 4596 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 33.0 min: [INVARIANT] INV-053 air constructor 30205 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 33.0 min: [INVARIANT] INV-053 air constructor 29831 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 33.5 min: [INVARIANT] INV-020 no layout room for legmstor for 841 s
- forbid 'invariant' hit at 33.5 min: [INVARIANT] INV-053 air constructor 29845 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 33.8 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (1 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 34.0 min: [INVARIANT] INV-053 air constructor 25492 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 34.1 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-020 no layout room for legmstor for 901 s
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 28451 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 24568 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 7319 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 10871 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 27953 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 28843 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 25575 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 10557 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 17027 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 23033 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 4516 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 14132 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 7923 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 4676 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 35.0 min: [INVARIANT] INV-053 air constructor 11930 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 35.1 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-020 no layout room for legadveconv for 961 s
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 14734 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 16719 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 11205 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 29831 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 15950 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 1037 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 27675 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 31382 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 23540 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 17915 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 700 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 29440 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-020 no layout room for legmstor for 1021 s
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 23988 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 16364 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 4828 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 29335 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 17514 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 17229 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 15899 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 6848 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 29126 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 6941 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 36.6 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 36.8 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (1 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 23941 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 25492 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 22499 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 23033 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 27152 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 3825 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 11904 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 37.0 min: [INVARIANT] INV-053 air constructor 6236 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 37.1 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-020 no layout room for legadveconv for 1081 s
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-053 air constructor 25808 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-053 air constructor 439 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-053 air constructor 1037 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-053 air constructor 15950 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-053 air constructor 29831 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-053 air constructor 31382 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-053 air constructor 28451 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 18780 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 2977 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 23540 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 28005 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 7003 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 28190 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 27787 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 30205 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 17915 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 15321 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 4596 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 700 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 29440 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 4851 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 1442 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 29845 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 30772 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 7273 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 38.1 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 38.4 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-020 no layout room for legadveconv for 1141 s
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 24250 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 16791 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 17229 has done nothing for 60 s (task type 2, last rule power.turret)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 31591 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 4676 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 6046 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 14132 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 4516 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 11930 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 27675 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 17027 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 25575 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 28843 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 7319 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 24568 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 10557 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 11205 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 16719 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 14734 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 27953 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 10871 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 15899 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.1 min: [INVARIANT] INV-011 metal floating at 3549 of 3550 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 39.4 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-020 no layout room for legmstor for 1201 s
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 11169 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 21853 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 25808 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 23988 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 439 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 16364 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 4828 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 29335 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 29996 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 638 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 28451 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 10886 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 17514 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 6848 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 29126 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 6941 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.8 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (1 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 18780 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 2977 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 23540 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 28005 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 7003 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 28190 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 27787 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 30205 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 11739 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 17915 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 15321 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 4596 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 700 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 29440 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 4851 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 1442 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 29845 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 30772 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 17502 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 7273 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.1 min: [INVARIANT] INV-011 metal floating at 3546 of 3550 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 40.4 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 40.5 min: [INVARIANT] INV-020 no layout room for legadveconv for 1261 s
- forbid 'invariant' hit at 40.5 min: [INVARIANT] INV-053 air constructor 4623 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.5 min: [INVARIANT] INV-053 air constructor 18859 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.5 min: [INVARIANT] INV-053 air constructor 23941 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.5 min: [INVARIANT] INV-053 air constructor 25492 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.5 min: [INVARIANT] INV-053 air constructor 7923 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.5 min: [INVARIANT] INV-053 air constructor 23033 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.5 min: [INVARIANT] INV-053 air constructor 11904 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 41.0 min: [INVARIANT] INV-053 air constructor 4504 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 41.0 min: [INVARIANT] INV-053 air constructor 4676 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 41.0 min: [INVARIANT] INV-053 air constructor 27675 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 41.1 min: [INVARIANT] INV-011 metal floating at 3547 of 3550 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 41.4 min: [INVARIANT] INV-039 T1 land constructors released 1225 s, 0 spam labs of 1 wanted, no forward order for 180 s
- forbid 'invariant' hit at 41.4 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-020 no layout room for legadveconv for 1321 s
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 31247 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 14809 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 11169 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 21853 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 24250 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 16791 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 6046 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 41.5 min: [INVARIANT] INV-053 air constructor 14552 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-053 air constructor 11548 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-053 air constructor 18780 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-053 air constructor 2977 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-053 air constructor 7003 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-053 air constructor 27787 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.0 min: [INVARIANT] INV-053 air constructor 30772 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.1 min: [INVARIANT] INV-011 metal floating at 3536 of 3550 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 42.4 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-020 no layout room for legmstor for 1381 s
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 5389 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 25808 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 23988 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 439 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 16364 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 4828 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 4516 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 28451 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 17514 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 17229 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 10871 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 15899 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 6848 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 29126 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.5 min: [INVARIANT] INV-053 air constructor 6941 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 42.8 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (1 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 43.0 min: [INVARIANT] INV-053 air constructor 22314 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 43.0 min: [INVARIANT] INV-053 air constructor 23915 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 43.0 min: [INVARIANT] INV-053 air constructor 30240 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 43.0 min: [INVARIANT] INV-053 air constructor 3109 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 43.0 min: [INVARIANT] INV-053 air constructor 1899 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 43.0 min: [INVARIANT] INV-053 air constructor 31382 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 43.0 min: [INVARIANT] INV-053 air constructor 10252 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 43.0 min: [INVARIANT] INV-053 air constructor 22205 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 43.0 min: [INVARIANT] INV-053 air constructor 27871 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 43.1 min: [INVARIANT] INV-011 metal floating at 3547 of 3550 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 43.4 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 43.5 min: [INVARIANT] INV-020 no layout room for legmstor for 1441 s
- forbid 'invariant' hit at 43.5 min: [INVARIANT] INV-053 air constructor 16462 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 43.5 min: [INVARIANT] INV-053 air constructor 11930 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 43.5 min: [INVARIANT] INV-053 air constructor 713 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 43.5 min: [INVARIANT] INV-053 air constructor 17027 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 43.5 min: [INVARIANT] INV-053 air constructor 28843 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 44.0 min: [INVARIANT] INV-053 air constructor 5104 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 44.0 min: [INVARIANT] INV-053 air constructor 5423 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 44.0 min: [INVARIANT] INV-053 air constructor 31591 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 44.0 min: [INVARIANT] INV-053 air constructor 9531 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 44.0 min: [INVARIANT] INV-053 air constructor 1037 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 44.0 min: [INVARIANT] INV-053 air constructor 29335 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 44.0 min: [INVARIANT] INV-053 air constructor 25575 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 44.0 min: [INVARIANT] INV-053 air constructor 15950 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 44.0 min: [INVARIANT] INV-053 air constructor 29831 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 44.0 min: [INVARIANT] INV-053 air constructor 7319 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 44.0 min: [INVARIANT] INV-053 air constructor 24568 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 44.0 min: [INVARIANT] INV-053 air constructor 11205 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 44.0 min: [INVARIANT] INV-053 air constructor 16719 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 44.0 min: [INVARIANT] INV-053 air constructor 14734 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 44.1 min: [INVARIANT] INV-011 metal floating at 3550 of 3550 for 60 s with an income step of the plan unmet
- forbid 'invariant' hit at 44.4 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 44.5 min: [INVARIANT] INV-020 no layout room for legadveconv for 1501 s
- forbid 'invariant' hit at 44.5 min: [INVARIANT] INV-053 air constructor 7139 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 44.5 min: [INVARIANT] INV-053 air constructor 30205 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 44.5 min: [INVARIANT] INV-053 air constructor 29440 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 44.5 min: [INVARIANT] INV-053 air constructor 4851 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 44.5 min: [INVARIANT] INV-053 air constructor 1442 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 44.5 min: [INVARIANT] INV-053 air constructor 29845 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 44.5 min: [INVARIANT] INV-053 air constructor 7273 has done nothing for 60 s (task type 2, last rule keep.current)

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\tundra\runs\20261003T185343Z-bc951b46\screen_2026-10-03_18-38-35-559.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\tundra\runs\20261003T185343Z-bc951b46\screen_2026-10-03_18-39-10-236.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\tundra\runs\20261003T185343Z-bc951b46\screen_2026-10-03_18-39-29-818.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\tundra\runs\20261003T185343Z-bc951b46\screen_2026-10-03_18-41-38-932.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-verified\cohort\20261003T182258Z-d6d6fc9c\tundra\runs\20261003T185343Z-bc951b46\screen_2026-10-03_18-49-22-142.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 30, 5 shots, end at 45.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (2800, 800) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (300, 460) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (4600, 11400) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (6000, 11400) units 1
  0.00  [Playtest] frame 1 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (2800, 800) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (300, 460) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (4600, 11400) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (6000, 11400) units 1
  0.05  [Playtest] frame 90 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order armap
  0.10  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=0 upgraded=pending reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2866, 888), 84 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|armada|armap|2809|825|1|2|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(326,467) factory=armlab landLocked=yes spot=0 known=1/1
  0.20  [Team][Roster] team 1 first mex at 480,432
  0.21  [Playtest] finished armmex team 0 at 0.21 min
  0.22  [Team][Roster] first mex 19579 at 2848,928
  0.22  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|2809|825|1|2|1|2848|928
  0.22  [AIR][Rule] opening.mex builder=2274
  0.27  [AIR][Capacity] own=2/30 usage=0/3 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=970 E=18 bank=781 pull=3 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=50/500
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.39  [Playtest] finished armmex team 0 at 0.39 min
  0.43  [AIR][Capacity] own=3/30 usage=0/6 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=3 bank=964 E=30 bank=544 pull=6 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=50/500
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.60  [AIR][Capacity] own=5/30 usage=8/89 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=5 bank=1008 E=30 bank=566 pull=89 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=25/258
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.65  [Playtest] finished armmex team 0 at 0.65 min
  0.66  [AIR][Wind] cluster=0 slots=6 at=3048,928 local=true builder=2274
  0.66  [AIR][Rule] opening.energy builder=2274
  0.77  [AIR][Capacity] own=5/30 usage=7/41 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP M=5 bank=1032 E=30 bank=418 pull=41 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=18/79
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.81  [Playtest] finished armwin team 0 at 0.81 min
  0.92  [Playtest] finished armwin team 0 at 0.92 min
  0.93  [AIR][Capacity] own=7/30 usage=6/38 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=7 bank=1046 E=30 bank=445 pull=38 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=1 committed=40/175
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 1057/1150, energy +51.8 bank 487/1001, units 7
  1.02  [Playtest] finished armwin team 0 at 1.02 min
  1.10  [AIR][Capacity] own=7/50 usage=7/41 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=7 bank=1068 E=47 bank=642 pull=41 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=14/63
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.13  [Playtest] finished armwin team 0 at 1.13 min
  1.27  [AIR][Capacity] own=7/66 usage=7/41 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=7 bank=1104 E=64 bank=982 pull=41 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=10/45
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.29  [Playtest] finished armwin team 0 at 1.29 min
  1.40  [Playtest] finished armwin team 0 at 1.40 min
  1.41  [AIR][Starter] nearby distance=128
  1.41  [AIR][Rule] opening.plant builder=2274
  1.42  [AIR][EcoLayout] reserved air.eco.0 reactor=1792,816 converters=8 support=12 zone=42
  1.43  [AIR][EcoLayout] reserved air.eco.1 reactor=1792,1328 converters=8 support=12 zone=74
  1.43  [AIR][Capacity] own=7/89 usage=0/9 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=7 bank=1126 E=88 bank=952 pull=9 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=639/1081
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.43  [AIR][Bay] 0 plant=17130 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.45  [AIR][EcoLayout] reserved air.eco.2 reactor=2304,1840 converters=8 support=12 zone=126
  1.60  [AIR][Capacity] own=7/112 usage=35/69 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=7 bank=872 E=115 bank=1003 pull=69 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=281/476
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=17130 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.73  [Playtest] finished armap team 0 at 1.73 min
  1.73  [AIR][Claim] cancel unowned native order armnanotc
  1.73  [AIR][Claim] cancel unowned native order armnanotc
  1.73  [AIR][State] T1_CONTEST
  1.74  [AIR][Produce] opening.scout armpeep plant=17130 projected=1/1
  1.74  [AIR][Rule] opening.commander.guard builder=2274
  1.77  [AIR][Capacity] own=7/78 usage=0/36 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] T1_CONTEST M=7 bank=635 E=82 bank=1096 pull=36 plants=1/0 aircraftDemand=3/121
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=17130 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.86  [AIR][Produce] constructor.recovery armca plant=17130 projected=1/3
  1.93  [AIR][Capacity] own=7/48 usage=0/13 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T1_CONTEST M=7 bank=650 E=56 bank=134 pull=153 plants=1/0 aircraftDemand=3/121
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=17130 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +7.0 bank 661/1250, energy +37.0 bank 3/1103, units 13
  2.10  [AIR][Capacity] own=6/36 usage=0/0 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=677 E=36 bank=0 pull=160 plants=1/0 aircraftDemand=3/121
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=17130 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.23  [AIR][Produce] constructor.recovery armca plant=17130 projected=2/3
  2.24  [AIR][Rule] recovery.energy builder=14452
  2.27  [AIR][Capacity] own=6/44 usage=0/0 gifts=0 sent=0 excess=0 pressure=true mobile=50 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=704 E=39 bank=166 pull=69 plants=1/0 aircraftDemand=3/121
  2.27  [AIR][Projects] energyQueued=1 committed=155/0
  2.27  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=100 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=17130 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Capacity] own=7/69 usage=2/4 gifts=0 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=50 shortage=143 reason=funded workload
  2.43  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=676 E=69 bank=0 pull=174 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=0 committed=128/0
  2.43  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=243 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=17130 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.48  [AIR][Produce] constructor.recovery armca plant=17130 projected=3/3
  2.48  [AIR][Rule] recovery.energy builder=18537
  2.60  [AIR][Capacity] own=6/71 usage=6/24 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=99 shortage=39 reason=funded workload
  2.60  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=653 E=69 bank=2 pull=170 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=244/0
  2.60  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=189 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=17130 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.77  [AIR][Capacity] own=5/87 usage=5/4 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=100 shortage=44 reason=funded workload
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=618 E=83 bank=3 pull=134 plants=1/0 aircraftDemand=3/121
  2.77  [AIR][Projects] energyQueued=0 committed=184/0
  2.77  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=194 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=17130 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.81  [AIR][Produce] opening.screen armfig plant=17130 projected=1/6
  2.81  [AIR][Rule] recovery.energy builder=21105
  2.82  [AIR][Commander] cleared factory guard for commander.idle.assist
  2.82  [AIR][Rule] commander.idle.assist builder=2274
  2.84  [AIR][Rule] commander.factory.guard builder=2274
  2.93  [AIR][Capacity] own=6/111 usage=18/381 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=600 E=108 bank=660 pull=381 plants=1/0 aircraftDemand=3/121
  2.93  [AIR][Projects] energyQueued=0 committed=272/0
  2.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=17130 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 554/1250, energy +129.4 bank 5/1178, units 19
  3.09  [AIR][Produce] opening.screen armfig plant=17130 projected=2/6
  3.09  [AIR][Screen] fighters=1 cells=8 centre=471,839 width=600 advance=400 responding=false
  3.10  [AIR][Capacity] own=7/126 usage=9/33 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=44 reason=funded workload
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=533 E=123 bank=566 pull=33 plants=1/0 aircraftDemand=3/127
  3.10  [AIR][Projects] energyQueued=0 committed=183/0
  3.10  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=194 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=17130 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.15  [Playtest] finished armsolar team 0 at 3.15 min
  3.27  [AIR][Capacity] own=7/132 usage=13/191 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=459 E=131 bank=48 pull=191 plants=1/0 aircraftDemand=3/127
  3.27  [AIR][Projects] energyQueued=0 committed=254/0
  3.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=17130 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Screen] fighters=1 cells=8 centre=471,839 width=600 advance=400 responding=false
  3.27  [AIR][Produce] opening.screen armfig plant=17130 projected=3/6
  3.42  [AIR][Layout] cluster=0 labs=1 at=1873,2625
  3.42  [Playtest] finished armsolar team 0 at 3.42 min
  3.43  [AIR][Rule] recovery.assist builder=18537
  3.43  [AIR][Capacity] own=7/160 usage=12/158 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=100 shortage=0 reason=no funded workload
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=410 E=160 bank=19 pull=257 plants=1/0 aircraftDemand=3/127
  3.43  [AIR][Projects] energyQueued=0 committed=167/0
  3.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=17130 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.45  [AIR][Screen] fighters=2 cells=8 centre=471,839 width=600 advance=400 responding=false
  3.57  [AIR][Produce] opening.screen armfig plant=17130 projected=4/6
  3.60  [AIR][Capacity] own=6/180 usage=9/25 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=368 E=176 bank=247 pull=25 plants=1/0 aircraftDemand=3/127
  3.60  [AIR][Projects] energyQueued=0 committed=85/0
  3.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=17130 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=3 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.62  [Playtest] finished armsolar team 0 at 3.62 min
  3.62  [AIR][Screen] fighters=3 cells=8 centre=471,839 width=600 advance=400 responding=false
  3.63  [AIR][Rule] recovery.assist builder=21105
  3.77  [AIR][Capacity] own=6/180 usage=11/96 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=563 E=180 bank=185 pull=96 plants=1/0 aircraftDemand=3/127
  3.77  [AIR][Projects] energyQueued=0 committed=12/0
  3.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=17130 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.78  [AIR][Screen] fighters=3 cells=8 centre=471,839 width=600 advance=400 responding=false
  3.79  [Playtest] finished armsolar team 0 at 3.79 min
  3.81  [AIR][Rule] mex.expand builder=14452
  3.81  [AIR][Rule] intel.radar builder=18537
  3.81  [AIR][Rule] wait builder=21105
  3.82  [AIR][Commander] cleared factory guard for commander.idle.energy
  3.82  [AIR][Rule] commander.idle.energy builder=2274
  3.83  [AIR][Produce] opening.screen armfig plant=17130 projected=5/6
  3.85  [AIR][Rule] commander.factory.guard builder=2274
  3.88  [AIR][Rule] project.assist builder=21105
  3.93  [AIR][Layout] cluster=1 labs=1 at=3409,1473
  3.93  [AIR][Capacity] own=5/200 usage=13/423 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=136 shortage=0 reason=no funded workload
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=558 E=200 bank=318 pull=423 plants=1/0 aircraftDemand=3/127
  3.93  [AIR][Projects] energyQueued=0 committed=86/889
  3.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=17130 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.95  [AIR][Layout] cluster=2 labs=1 at=3217,1665
  3.97  [AIR][Screen] fighters=4 cells=8 centre=471,839 width=600 advance=400 responding=false
  4.00  [Playtest] eco team 0 at 4.0 min: metal +5.0 bank 531/1250, energy +220.6 bank 0/1378, units 26
  4.09  [Playtest] finished armrad team 0 at 4.09 min
  4.10  [AIR][Capacity] own=2/218 usage=6/84 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=100 ecoStatic=0 working=50 shortage=0 reason=available or arriving power
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=3 bank=517 E=219 bank=205 pull=84 plants=1/0 aircraftDemand=3/125
  4.10  [AIR][Projects] energyQueued=0 committed=40/407
  4.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=17130 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=4 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=146
  4.11  [AIR][Rule] project.assist builder=18537
  4.12  [AIR][Produce] opening.screen armfig plant=17130 projected=6/6
  4.17  [AIR][Screen] fighters=5 cells=8 centre=471,839 width=600 advance=400 responding=false
  4.27  [AIR][Capacity] own=7/213 usage=6/180 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=118 shortage=0 reason=no funded workload
  4.27  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=764 E=213 bank=133 pull=180 plants=1/0 aircraftDemand=3/125
  4.27  [AIR][Projects] energyQueued=0 committed=17/171
  4.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=17130 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.33  [AIR][Screen] fighters=5 cells=8 centre=471,839 width=600 advance=400 responding=false
  4.37  [Playtest] finished armmex team 0 at 4.37 min
  4.39  [AIR][Rule] wait builder=18537
  4.39  [AIR][Rule] wait builder=21105
  4.42  [AIR][Produce] intercept armfig plant=17130 projected=7/7
  4.43  [AIR][Capacity] own=7/213 usage=3/161 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=100 ecoStatic=0 working=0 shortage=75 reason=funded workload
  4.43  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=796 E=213 bank=647 pull=161 plants=1/0 aircraftDemand=3/126
  4.43  [AIR][Projects] energyQueued=0 committed=49/496
  4.43  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=225 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=17130 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.45  [AIR][Rule] project.assist builder=18537
  4.46  [AIR][Rule] project.assist builder=21105
  4.50  [AIR][Screen] fighters=6 cells=8 centre=471,839 width=600 advance=400 responding=false
  4.60  [AIR][Capacity] own=9/218 usage=8/219 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=149 shortage=0 reason=no funded workload
  4.60  [AIR][Economy] T1_CONTEST M=9 bank=826 E=217 bank=841 pull=219 plants=1/0 aircraftDemand=3/126
  4.60  [AIR][Projects] energyQueued=0 committed=16/161
  4.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=17130 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=132
  4.66  [Playtest] finished armmex team 0 at 4.66 min
  4.67  [AIR][Screen] fighters=6 cells=8 centre=471,839 width=600 advance=400 responding=false
  4.68  [AIR][Produce] recon.replace armpeep plant=17130 projected=1/1
  4.68  [AIR][Wind] cluster=1 slots=6 at=2568,688 local=false builder=14452
  4.68  [AIR][Rule] energy.grow builder=14452
  4.68  [AIR][Rule] energy.grow builder=18537
  4.68  [AIR][Layout] repaired support air.bay.0 viable=2/5 slot=733 at=3176,1064
  4.68  [AIR][Rule] opening.support builder=21105
  4.77  [AIR][Capacity] own=9/207 usage=5/186 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.77  [AIR][Economy] T1_CONTEST M=9 bank=1105 E=209 bank=756 pull=186 plants=1/0 aircraftDemand=3/126
  4.77  [AIR][Projects] energyQueued=2 committed=310/3550
  4.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=true savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=17130 BP=150 nanos=0+0/2 available=yes firstSlot=2
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.82  [AIR][Commander] cleared factory guard for opening.support.assist
  4.82  [AIR][Rule] opening.support.assist builder=2274
  4.83  [AIR][Produce] air.control armfig plant=17130 projected=8/8
  4.85  [AIR][Screen] fighters=7 cells=8 centre=471,839 width=600 advance=400 responding=false
  4.93  [AIR][Capacity] own=11/207 usage=7/176 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=406 shortage=106 reason=funded workload
  4.93  [AIR][Economy] T1_CONTEST RECOVERY M=11 bank=1085 E=207 bank=7 pull=361 plants=1/0 aircraftDemand=3/126
  4.93  [AIR][Projects] energyQueued=0 committed=201/2229
  4.93  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=256 floating=true savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=17130 BP=150 nanos=0+1/0 available=yes firstSlot=2
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.97  [AIR][Layout] cluster=3 labs=1 at=2065,2337
  5.00  [Playtest] eco team 0 at 5.0 min: metal +12.0 bank 1062/1350, energy +220.1 bank 2/1378, units 33
  5.00  [Playtest] target team 0 at (2800, 800) from its start position
  5.00  [Playtest] camera requested (3248,1000) height=2200
  5.02  [AIR][Screen] fighters=7 cells=8 centre=471,839 width=600 advance=400 responding=false
  5.02  [Playtest] camera captured name=ta position=(3248,1000) height=2200
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (3248, 1000)
  5.10  [AIR][Capacity] own=11/215 usage=2/29 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=409 shortage=23 reason=funded workload
  5.10  [AIR][Economy] T1_CONTEST RECOVERY M=11 bank=1041 E=214 bank=9 pull=237 plants=1/0 aircraftDemand=3/126
  5.10  [AIR][Projects] energyQueued=0 committed=38/192
  5.10  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=173 floating=true savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.10  [AIR][Bay] 0 plant=17130 BP=150 nanos=0+1/0 available=yes firstSlot=2
  5.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Attack] home=7 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=120
  5.10  [Playtest] finished armnanotc team 0 at 5.10 min
  5.12  [AIR][Rule] commander.factory.guard builder=2274
  5.12  [AIR][Rule] recovery.assist builder=21105
  5.13  [AIR][Share] metal 1293 of 1350 (95%): sent 270 to team 1 (76% full); the engine counts 0 metal sent in the last update (D-106)
  5.17  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1188) (D-106)
  5.18  [AIR][Screen] fighters=7 cells=8 centre=471,839 width=600 advance=400 responding=false
  5.23  [AIR][Share] metal 1319 of 1350 (97%): sent 244 to team 1 (79% full); the engine counts 0 metal sent in the last update (D-106)
  5.27  [AIR][Capacity] own=7/188 usage=9/264 gifts=0 sent=227 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=136 shortage=0 reason=no funded workload
  5.27  [AIR][Economy] T1_CONTEST RECOVERY M=11 bank=1095 E=192 bank=0 pull=387 plants=1/0 aircraftDemand=8/288
  5.27  [AIR][Projects] energyQueued=0 committed=8/37
  5.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=true savingLab=false
  5.27  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.27  [AIR][Bay] 0 plant=17130 BP=350 nanos=1+0/0 available=yes firstSlot=3
  5.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1188) (D-106)
  5.29  [Playtest] finished armwin team 0 at 5.28 min
  5.30  [AIR][Rule] wait builder=18537
  5.30  [AIR][State] T1_SCALE
  5.30  [AIR][Rule] wait builder=21105
  5.32  [AIR][Share] metal 1336 of 1350 (99%): sent 212 to team 1 (82% full); the engine counts 0 metal sent in the last update (D-106)
  5.35  [AIR][Share] after the donation: we sent 192; team 1 received 192 (bank 1188) (D-106)
  5.36  [Playtest] finished armwin team 0 at 5.36 min
  5.37  [AIR][Rule] transition.storage builder=18537
  5.37  [AIR][Rule] wait builder=14452
  5.38  [AIR][Screen] fighters=8 cells=8 centre=668,1343 width=1200 advance=941 responding=false
  5.40  [AIR][Share] metal 1336 of 1350 (99%): sent 120 to team 1 (89% full); the engine counts 1 metal sent in the last update (D-106)
  5.41  [AIR][NanoGate] armcom 2274 can=no busy=no count=1
  5.41  [AIR][Commander] cleared factory guard for commander.idle.energy
  5.41  [AIR][Rule] commander.idle.energy builder=2274
  5.43  [AIR][NanoGate] armca 21105 can=yes busy=no count=1
  5.43  [AIR][Rule] project.assist builder=21105
  5.43  [AIR][Capacity] own=5/188 usage=0/15 gifts=0 sent=114 excess=0 pressure=true mobile=150 arriving=0 idle=50 ecoStatic=0 working=0 shortage=73 reason=funded workload
  5.43  [AIR][Economy] T1_SCALE RECOVERY M=41 bank=1248 E=189 bank=1248 pull=15 plants=1/0 aircraftDemand=8/286
  5.43  [AIR][Projects] energyQueued=0 committed=330/570
  5.43  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=223 floating=true savingLab=false
  5.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.43  [AIR][Bay] 0 plant=17130 BP=350 nanos=1+0/0 available=yes firstSlot=3
  5.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1188) (D-106)
  5.44  [AIR][NanoGate] armca 14452 can=yes busy=no count=1
  5.44  [AIR][Rule] project.assist builder=14452
  5.47  [AIR][Produce] constructor.expand armca plant=17130 projected=4/4
  5.48  [AIR][Share] metal 1312 of 1350 (97%): sent 54 to team 1 (95% full); the engine counts 0 metal sent in the last update (D-106)
  5.49  [AIR][Rule] commander.factory.guard builder=2274
  5.50  [AIR][Support] return to production bay=0
  5.52  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1188) (D-106)
  5.55  [AIR][Screen] fighters=8 cells=8 centre=668,1343 width=1200 advance=941 responding=false
  5.57  [AIR][Share] metal 1307 of 1350 (96%): sent 124 to team 1 (89% full); the engine counts 0 metal sent in the last update (D-106)
  5.60  [AIR][Capacity] own=11/248 usage=18/69 gifts=0 sent=106 excess=0 pressure=true mobile=150 arriving=50 idle=0 ecoStatic=0 working=149 shortage=0 reason=no funded workload
  5.60  [AIR][Economy] T1_SCALE M=15 bank=1185 E=250 bank=1121 pull=317 plants=1/0 aircraftDemand=8/286
  5.60  [AIR][Projects] energyQueued=0 committed=102/176
  5.60  [AIR][Workforce] t1=4/4 t2=0/2 targetBP=200 floating=true savingLab=false
  5.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.60  [AIR][Bay] 0 plant=17130 BP=350 nanos=1+0/2 available=yes firstSlot=3
  5.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Attack] home=8 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=206
... 3681 more
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 1
  0.08  RESERVE: armlab at (272, 384) facing 2 (id 11)
  0.08  RESERVE: zone 7 at (272, 456) facing 2, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (272, 432) facing 2: 2 of 2 slots (group 5, zone)
  0.08  RESERVE: armlab at (272, 368) facing 2 (id 14)
  0.08  RESERVE: zone 8 at (272, 440) facing 2, 6x3 cells: 6 of 18 held
  0.08  RESERVE: armlab at (256, 352) facing 2 (id 15)
  0.08  RESERVE: zone 9 at (256, 424) facing 2, 6x3 cells: 8 of 18 held
  0.08  RESERVE: armlab at (272, 144) facing 2 (id 16)
  0.08  RESERVE: zone 10 at (272, 216) facing 2, 6x3 cells: 6 of 18 held
  0.08  EXP: approach: armcom(1901) at (327, 468) walks to (347, 463), 136 from the armmex site (480, 432)
  0.09  RESERVE: factory pair 'tech.factory.start' committed atomically facing 2
  0.09  RESERVE: zone 7 at (6579, 11928) facing 2, 77x54 cells: 3759 of 4158 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (6579, 11432) facing 2: 5 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (6579, 11480) facing 2: 5 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (6579, 11528) facing 2: 6 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (6579, 11576) facing 2: 6 of 13 slots (group 5, held, zone)
  0.09  RESERVE: legalab at (6344, 11352) facing 2 (id 33)
  0.09  RESERVE: leglab at (5936, 8272) facing 2 (id 34)
  0.09  RESERVE: zone 8 at (5936, 8344) facing 2, 6x3 cells: 18 of 18 held
  0.09  RESERVE: grid of legnanotc 2x1 gap 0 behind (5936, 8320) facing 2: 2 of 2 slots (group 6, zone)
  0.09  RESERVE: leglab at (6704, 7248) facing 2 (id 37)
  0.09  RESERVE: zone 9 at (6704, 7320) facing 2, 6x3 cells: 18 of 18 held
  0.09  RESERVE: grid of legnanotc 2x1 gap 0 behind (6704, 7296) facing 2: 2 of 2 slots (group 7, zone)
  0.09  RESERVE: corridor 10 at (6800, 7272) facing 2, 6x21 cells: 126 of 126 held
  0.09  RESERVE: zone 11 at (6704, 7272) facing 0, 6x9 cells: 0 of 54 held
  0.09  RESERVE: corridor 11 at (6704, 7024) facing 2, 10x20 cells: 190 of 200 held
  0.09  EXP: approach: legcom(17070) at (5988, 11435) walks to (5877, 11461), 137 from the legmex site (5936, 11584)
  0.16  EXP: idle: legcom(17070) on legmex at (5884, 11459), site (5936, 11584), target yes, fails 2 (arrived at the approach point)
  0.17  RESERVE: leglab at (5936, 8272) facing 2 (id 40)
  0.17  RESERVE: zone 12 at (5936, 8344) facing 2, 6x3 cells: 0 of 18 held
  0.17  RESERVE: leglab at (6576, 7232) facing 2 (id 41)
  0.17  RESERVE: zone 12 at (6576, 7304) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: leglab at (6448, 7216) facing 2 (id 42)
  0.17  RESERVE: zone 13 at (6448, 7288) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (6448, 7264) facing 2: 2 of 2 slots (group 9, zone)
  0.17  RESERVE: leglab at (6320, 7200) facing 2 (id 45)
  0.17  RESERVE: zone 14 at (6320, 7272) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (6320, 7248) facing 2: 2 of 2 slots (group 10, zone)
  0.17  RESERVE: leglab at (6192, 7184) facing 2 (id 48)
  0.17  RESERVE: zone 15 at (6192, 7256) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (6192, 7232) facing 2: 2 of 2 slots (group 11, zone)
  0.17  RESERVE: leglab at (7344, 7312) facing 2 (id 51)
  0.17  RESERVE: zone 16 at (7344, 7384) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (7344, 7360) facing 2: 2 of 2 slots (group 12, zone)
  0.17  RESERVE: leglab at (7456, 7328) facing 2 (id 54)
  0.17  RESERVE: zone 17 at (7456, 7400) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (7456, 7376) facing 2: 2 of 2 slots (group 13, zone)
  0.17  RESERVE: corridor 18 at (7552, 7352) facing 2, 6x21 cells: 110 of 126 held
  0.17  RESERVE: zone 19 at (7456, 7352) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 19 at (7456, 7104) facing 2, 10x20 cells: 182 of 200 held
  0.19  EXP: approach: corcom(24492) at (4599, 11401) walks to (4532, 11356), 139 from the cormex site (4416, 11280)
  0.21  EXP: approach: armcom(1901) at (335, 466) walks to (279, 654), 136 from the armmex site (240, 784)
  0.22  EXP: approach: armcom(2274) at (2823, 860) walks to (2736, 829), 136 from the armmex site (2608, 784)
  0.25  RESERVE: armlab at (256, 352) facing 2 (id 17)
  0.25  RESERVE: zone 11 at (256, 424) facing 2, 6x3 cells: 0 of 18 held
  0.25  RESERVE: armlab at (288, 144) facing 2 (id 18)
  0.25  RESERVE: zone 11 at (288, 216) facing 2, 6x3 cells: 3 of 18 held
  0.25  RESERVE: leggant at (4800, 10384) facing 2 (id 57)
  0.25  RESERVE: zone 20 at (4800, 10600) facing 2, 30x15 cells: 450 of 450 held
  0.25  RESERVE: grid of legnanotc 10x5 gap 0 behind (4800, 10480) facing 2: 50 of 50 slots (group 14, zone)
  0.25  RESERVE: zone 20 released
  0.25  RESERVE: zone 21 at (4800, 10600) facing 2, 24x15 cells: 360 of 360 held
  0.25  RESERVE: grid of legnanotc 8x5 gap 0 behind (4800, 10480) facing 2: 40 of 40 slots (group 15, zone)
  0.25  RESERVE: zone 21 released
  0.25  RESERVE: zone 22 at (4800, 10576) facing 2, 24x12 cells: 288 of 288 held
  0.25  RESERVE: grid of legnanotc 8x4 gap 0 behind (4800, 10480) facing 2: 32 of 32 slots (group 16, zone)
  0.25  RESERVE: zone 22 released
  0.25  RESERVE: zone 23 at (4800, 10576) facing 2, 18x12 cells: 216 of 216 held
  0.25  RESERVE: grid of legnanotc 6x4 gap 0 behind (4800, 10480) facing 2: 24 of 24 slots (group 17, zone)
  0.25  RESERVE: zone 23 released
  0.25  RESERVE: zone 24 at (4800, 10552) facing 2, 18x9 cells: 162 of 162 held
  0.25  RESERVE: grid of legnanotc 6x3 gap 0 behind (4800, 10480) facing 2: 18 of 18 slots (group 18, zone)
  0.25  RESERVE: zone 24 released
  0.25  RESERVE: zone 25 at (4800, 10528) facing 2, 10x6 cells: 60 of 60 held
  0.25  RESERVE: grid of legnanotc 3x2 gap 0 behind (4800, 10480) facing 2: 6 of 6 slots (group 19, zone)
  0.25  RESERVE: zone 26 at (4800, 10432) facing 0, 12x18 cells: 12 of 216 held
  0.25  RESERVE: corridor 27 at (4800, 10112) facing 2, 16x20 cells: 320 of 320 held
  0.35  EXP: approach: corcom(24492) at (4541, 11380) walks to (4745, 11636), 139 from the cormex site (4832, 11744)
  0.40  EXP: approach: armcom(2274) at (2757, 836) walks to (3039, 932), 136 from the armmex site (3168, 976)
  0.42  RESERVE: armlab at (256, 352) facing 2 (id 19)
  0.42  RESERVE: zone 12 at (256, 424) facing 2, 6x3 cells: 0 of 18 held
  0.42  RESERVE: armlab at (288, 144) facing 2 (id 20)
  0.42  RESERVE: zone 12 at (288, 216) facing 2, 6x3 cells: 0 of 18 held
  0.43  RESERVE: armlab at (368, 688) facing 1 (id 21)
  0.43  RESERVE: served armlab at (368, 688) facing 1 (id 21, 1 of this def still held)
  0.58  RESERVE: armlab at (272, 352) facing 2 (id 22)
  0.58  RESERVE: zone 12 at (272, 424) facing 2, 6x3 cells: 1 of 18 held
  0.58  RESERVE: armlab at (256, 336) facing 2 (id 23)
  0.58  RESERVE: zone 13 at (256, 408) facing 2, 6x3 cells: 6 of 18 held
  0.58  RESERVE: armlab at (256, 320) facing 2 (id 24)
  0.58  RESERVE: zone 14 at (256, 392) facing 2, 6x3 cells: 6 of 18 held
  0.58  RESERVE: armlab at (304, 144) facing 2 (id 25)
  0.58  RESERVE: zone 15 at (304, 216) facing 2, 6x3 cells: 3 of 18 held
  0.62  RESERVE: zone 1 at (4808, 11640) facing 2, 3x3 cells: 9 of 9 held
  0.62  RESERVE: corwin at (4808, 11640) facing 2 (id 1)
  0.62  RESERVE: zone 2 at (4760, 11640) facing 2, 3x3 cells: 9 of 9 held
  0.62  RESERVE: corwin at (4760, 11640) facing 2 (id 2)
  0.62  RESERVE: zone 3 at (4712, 11640) facing 2, 3x3 cells: 9 of 9 held
  0.62  RESERVE: corwin at (4712, 11640) facing 2 (id 3)
  0.62  RESERVE: zone 4 at (4808, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.62  RESERVE: corwin at (4808, 11592) facing 2 (id 4)
  0.62  RESERVE: zone 5 at (4760, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.62  RESERVE: corwin at (4760, 11592) facing 2 (id 5)
  0.62  RESERVE: zone 6 at (4712, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.62  RESERVE: corwin at (4712, 11592) facing 2 (id 6)
  0.62  RESERVE: served corwin at (4808, 11640) facing 2 (id 1, 5 of this def still held)
  0.66  RESERVE: zone 1 at (3000, 904) facing 0, 3x3 cells: 9 of 9 held
  0.66  RESERVE: armwin at (3000, 904) facing 0 (id 1)
  0.66  RESERVE: zone 2 at (3048, 904) facing 0, 3x3 cells: 9 of 9 held
  0.66  RESERVE: armwin at (3048, 904) facing 0 (id 2)
  0.66  RESERVE: zone 3 at (3096, 904) facing 0, 3x3 cells: 9 of 9 held
  0.66  RESERVE: armwin at (3096, 904) facing 0 (id 3)
  0.66  RESERVE: zone 4 at (3000, 952) facing 0, 3x3 cells: 9 of 9 held
  0.66  RESERVE: armwin at (3000, 952) facing 0 (id 4)
  0.66  RESERVE: zone 5 at (3048, 952) facing 0, 3x3 cells: 9 of 9 held
  0.66  RESERVE: armwin at (3048, 952) facing 0 (id 5)
  0.66  RESERVE: zone 6 at (3096, 952) facing 0, 3x3 cells: 9 of 9 held
  0.66  RESERVE: armwin at (3096, 952) facing 0 (id 6)
  0.66  RESERVE: served armwin at (3000, 904) facing 0 (id 1, 5 of this def still held)
```
