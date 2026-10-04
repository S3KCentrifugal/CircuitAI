# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 30.0 min (frame 54000); wall 227 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-paired\cohort\20261003T172751Z-47454589\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T14:39:50
- Map: Tundra Continents v2.3.1; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811001\cohort\20261003T172752Z-f3ec5e2c\tundra\runs\20261003T174339Z-a2208e3a\infolog.txt

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
- forbid 'invariant' hit at 2.6 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 14.1 min: [INVARIANT] INV-008 7 turret(s) in range of the reclaim of legalab 1029 are not on it
- forbid 'invariant' hit at 15.0 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 15.7 min: [t=00:01:40.206330][f=0028290] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 16.0 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 17.0 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 17.1 min: [t=00:01:45.321299][f=0030810] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.1 min: [t=00:01:45.360918][f=0030825] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.1 min: [t=00:01:45.400145][f=0030840] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.1 min: [t=00:01:45.433849][f=0030855] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.1 min: [t=00:01:45.454999][f=0030870] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.2 min: [t=00:01:45.490271][f=0030885] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.2 min: [t=00:01:45.519590][f=0030900] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.2 min: [t=00:01:45.570749][f=0030915] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.2 min: [t=00:01:45.590460][f=0030930] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.2 min: [t=00:01:45.628931][f=0030945] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.2 min: [t=00:01:45.656056][f=0030960] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.2 min: [t=00:01:45.693492][f=0030975] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.2 min: [t=00:01:45.715145][f=0030990] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.2 min: [t=00:01:45.752248][f=0031005] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.2 min: [t=00:01:45.766876][f=0031020] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.2 min: [t=00:01:45.807762][f=0031035] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.2 min: [t=00:01:45.830845][f=0031050] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.3 min: [t=00:01:45.866114][f=0031065] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.3 min: [t=00:01:45.902242][f=0031080] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.3 min: [t=00:01:45.938498][f=0031095] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.3 min: [t=00:01:45.951197][f=0031110] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.3 min: [t=00:01:45.979661][f=0031125] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.3 min: [t=00:01:45.992957][f=0031140] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.3 min: [t=00:01:46.024438][f=0031155] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.3 min: [t=00:01:46.042010][f=0031170] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.3 min: [t=00:01:46.076682][f=0031185] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.3 min: [t=00:01:46.112240][f=0031200] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.3 min: [t=00:01:46.153257][f=0031215] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.4 min: [t=00:01:46.169128][f=0031230] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.4 min: [t=00:01:46.202177][f=0031245] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.4 min: [t=00:01:46.219486][f=0031260] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.4 min: [t=00:01:46.250488][f=0031275] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.4 min: [t=00:01:46.279309][f=0031290] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.4 min: [t=00:01:46.310256][f=0031305] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.4 min: [t=00:01:46.340015][f=0031320] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.4 min: [t=00:01:46.366700][f=0031335] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.6 min: [t=00:01:47.081867][f=0031680] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.6 min: [t=00:01:47.108502][f=0031695] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.6 min: [t=00:01:47.139783][f=0031710] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.6 min: [t=00:01:47.160832][f=0031725] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.6 min: [t=00:01:47.188269][f=0031740] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.6 min: [t=00:01:47.220821][f=0031755] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.6 min: [t=00:01:47.247115][f=0031770] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.7 min: [t=00:01:47.271208][f=0031785] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.7 min: [t=00:01:47.308783][f=0031800] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.7 min: [t=00:01:47.351748][f=0031815] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.7 min: [t=00:01:47.368763][f=0031830] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.7 min: [t=00:01:47.395641][f=0031845] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.7 min: [t=00:01:47.424812][f=0031860] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.7 min: [t=00:01:47.455822][f=0031875] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.7 min: [t=00:01:47.488306][f=0031890] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.7 min: [t=00:01:47.515504][f=0031905] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.7 min: [t=00:01:47.546836][f=0031920] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.7 min: [t=00:01:47.578906][f=0031935] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.8 min: [t=00:01:47.608655][f=0031950] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.8 min: [t=00:01:47.641414][f=0031965] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.8 min: [t=00:01:47.680193][f=0031980] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.8 min: [t=00:01:47.712657][f=0031995] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.8 min: [t=00:01:47.726777][f=0032010] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.8 min: [t=00:01:47.753449][f=0032025] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.8 min: [t=00:01:47.783327][f=0032040] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 17.8 min: [t=00:01:47.815281][f=0032055] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.0 min: [t=00:01:48.595031][f=0032400] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.0 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 18.0 min: [t=00:01:48.640868][f=0032415] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.0 min: [t=00:01:48.661109][f=0032430] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.0 min: [t=00:01:48.696567][f=0032445] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.0 min: [t=00:01:48.720619][f=0032460] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.0 min: [t=00:01:48.749660][f=0032475] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.1 min: [t=00:01:48.783807][f=0032490] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.1 min: [t=00:01:48.815873][f=0032505] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.1 min: [t=00:01:48.850266][f=0032520] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.1 min: [t=00:01:48.883911][f=0032535] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.1 min: [t=00:01:48.915382][f=0032550] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.1 min: [t=00:01:48.941351][f=0032565] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.1 min: [t=00:01:48.989354][f=0032580] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.1 min: [t=00:01:49.025277][f=0032595] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.1 min: [t=00:01:49.048905][f=0032610] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.1 min: [t=00:01:49.069551][f=0032625] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.1 min: [t=00:01:49.100441][f=0032640] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.1 min: [t=00:01:49.130348][f=0032655] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.1 min: [t=00:01:49.160658][f=0032670] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.2 min: [t=00:01:49.194045][f=0032685] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.2 min: [t=00:01:49.229785][f=0032700] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.2 min: [t=00:01:49.272347][f=0032715] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.2 min: [t=00:01:49.302017][f=0032730] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.2 min: [t=00:01:49.321445][f=0032745] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.2 min: [t=00:01:49.353541][f=0032760] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.2 min: [t=00:01:49.381036][f=0032775] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.2 min: [t=00:01:49.418190][f=0032790] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.2 min: [t=00:01:49.447626][f=0032805] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.2 min: [t=00:01:49.478304][f=0032820] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.2 min: [t=00:01:49.516798][f=0032835] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.2 min: [t=00:01:49.553427][f=0032850] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.3 min: [t=00:01:49.584489][f=0032865] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.3 min: [t=00:01:49.617828][f=0032880] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.3 min: [t=00:01:49.651138][f=0032895] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.3 min: [t=00:01:49.673339][f=0032910] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.3 min: [t=00:01:49.701170][f=0032925] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.3 min: [t=00:01:49.730335][f=0032940] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.3 min: [t=00:01:49.763564][f=0032955] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.3 min: [t=00:01:49.798164][f=0032970] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.3 min: [t=00:01:49.830752][f=0032985] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.3 min: [t=00:01:49.863709][f=0033000] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.3 min: [t=00:01:49.972673][f=0033015] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.4 min: [t=00:01:50.010613][f=0033030] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.4 min: [t=00:01:50.048650][f=0033045] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.4 min: [t=00:01:50.083872][f=0033060] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.4 min: [t=00:01:50.133082][f=0033075] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.4 min: [t=00:01:50.165445][f=0033090] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.4 min: [t=00:01:50.199578][f=0033105] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.4 min: [t=00:01:50.220256][f=0033120] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.4 min: [t=00:01:50.262244][f=0033135] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.4 min: [t=00:01:50.297822][f=0033150] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.4 min: [t=00:01:50.337255][f=0033165] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.4 min: [t=00:01:50.368911][f=0033180] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.4 min: [t=00:01:50.401472][f=0033195] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.4 min: [t=00:01:50.432032][f=0033210] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.5 min: [t=00:01:50.451583][f=0033225] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.5 min: [t=00:01:50.478968][f=0033240] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.5 min: [t=00:01:50.515270][f=0033255] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.5 min: [t=00:01:50.549275][f=0033270] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.5 min: [t=00:01:50.575581][f=0033285] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.5 min: [t=00:01:50.612544][f=0033300] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.5 min: [t=00:01:50.670645][f=0033315] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.5 min: [t=00:01:50.690948][f=0033330] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.5 min: [t=00:01:50.718221][f=0033345] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.5 min: [t=00:01:50.736829][f=0033360] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.5 min: [t=00:01:50.778184][f=0033375] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.6 min: [t=00:01:50.819947][f=0033390] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.6 min: [t=00:01:50.857710][f=0033405] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.6 min: [t=00:01:50.885762][f=0033420] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.6 min: [t=00:01:50.938450][f=0033435] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.6 min: [t=00:01:50.976205][f=0033450] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.6 min: [t=00:01:51.020542][f=0033465] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.6 min: [t=00:01:51.051228][f=0033480] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.6 min: [t=00:01:51.122012][f=0033495] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.6 min: [t=00:01:51.137667][f=0033510] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.6 min: [t=00:01:51.173488][f=0033525] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.6 min: [t=00:01:51.209627][f=0033540] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.6 min: [t=00:01:51.234620][f=0033555] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.6 min: [t=00:01:51.267052][f=0033570] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.7 min: [t=00:01:51.306687][f=0033585] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.7 min: [t=00:01:51.330329][f=0033600] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.7 min: [t=00:01:51.392481][f=0033615] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.7 min: [t=00:01:51.412894][f=0033630] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.7 min: [t=00:01:51.445176][f=0033645] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.7 min: [t=00:01:51.463732][f=0033660] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.7 min: [t=00:01:51.501677][f=0033675] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.7 min: [t=00:01:51.555788][f=0033690] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.7 min: [t=00:01:51.591577][f=0033705] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.7 min: [t=00:01:51.607480][f=0033720] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.7 min: [t=00:01:51.655196][f=0033735] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.8 min: [t=00:01:51.675913][f=0033750] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.8 min: [t=00:01:51.708493][f=0033765] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.8 min: [t=00:01:51.731973][f=0033780] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.8 min: [t=00:01:51.770652][f=0033795] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.8 min: [t=00:01:51.805031][f=0033810] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.8 min: [t=00:01:51.846460][f=0033825] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.8 min: [t=00:01:51.865594][f=0033840] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.8 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 18.8 min: [t=00:01:51.892963][f=0033855] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.8 min: [t=00:01:51.906351][f=0033870] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.8 min: [t=00:01:51.933617][f=0033885] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.8 min: [t=00:01:51.963169][f=0033900] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.8 min: [t=00:01:52.004650][f=0033915] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.9 min: [t=00:01:52.024273][f=0033930] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.9 min: [t=00:01:52.052078][f=0033945] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.9 min: [t=00:01:52.083287][f=0033960] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.9 min: [t=00:01:52.123132][f=0033975] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.9 min: [t=00:01:52.152484][f=0033990] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.9 min: [t=00:01:52.192785][f=0034005] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.9 min: [t=00:01:52.245447][f=0034020] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.9 min: [t=00:01:52.284684][f=0034035] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.9 min: [t=00:01:52.304958][f=0034050] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.9 min: [t=00:01:52.353124][f=0034065] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.9 min: [t=00:01:52.376812][f=0034080] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.9 min: [t=00:01:52.416769][f=0034095] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 18.9 min: [t=00:01:52.459143][f=0034110] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.0 min: [t=00:01:52.537722][f=0034125] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.0 min: [t=00:01:52.553167][f=0034140] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.0 min: [t=00:01:52.583179][f=0034155] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.0 min: [t=00:01:52.606514][f=0034170] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.0 min: [t=00:01:52.629149][f=0034185] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.0 min: [t=00:01:52.658371][f=0034200] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.0 min: [t=00:01:52.716416][f=0034215] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.0 min: [t=00:01:52.742777][f=0034230] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.0 min: [t=00:01:52.770031][f=0034245] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.0 min: [t=00:01:52.797667][f=0034260] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.0 min: [t=00:01:52.835396][f=0034275] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.1 min: [t=00:01:52.855901][f=0034290] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.1 min: [t=00:01:52.889646][f=0034305] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.1 min: [t=00:01:52.921272][f=0034320] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.1 min: [t=00:01:52.950526][f=0034335] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.1 min: [t=00:01:52.988435][f=0034350] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.1 min: [t=00:01:53.027030][f=0034365] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.1 min: [t=00:01:53.068849][f=0034380] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.1 min: [t=00:01:53.109934][f=0034395] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.1 min: [t=00:01:53.158139][f=0034410] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.1 min: [t=00:01:53.189812][f=0034425] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.1 min: [t=00:01:53.203880][f=0034440] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.1 min: [t=00:01:53.238592][f=0034455] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.1 min: [t=00:01:53.253844][f=0034470] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.2 min: [t=00:01:53.291396][f=0034485] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.2 min: [t=00:01:53.329895][f=0034500] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.2 min: [t=00:01:53.374333][f=0034515] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.2 min: [t=00:01:53.391524][f=0034530] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.2 min: [t=00:01:53.418426][f=0034545] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.2 min: [t=00:01:53.432702][f=0034560] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.2 min: [t=00:01:53.450010][f=0034575] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.2 min: [t=00:01:53.472962][f=0034590] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.2 min: [t=00:01:53.498201][f=0034605] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.2 min: [t=00:01:53.534347][f=0034620] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.2 min: [t=00:01:53.584988][f=0034635] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.2 min: [t=00:01:53.611212][f=0034650] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.3 min: [t=00:01:53.651348][f=0034665] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.3 min: [t=00:01:53.700663][f=0034680] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.3 min: [t=00:01:53.739668][f=0034695] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.3 min: [t=00:01:53.761194][f=0034710] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.3 min: [t=00:01:53.794727][f=0034725] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.3 min: [t=00:01:53.841164][f=0034740] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.3 min: [t=00:01:53.870504][f=0034755] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.3 min: [t=00:01:53.902617][f=0034770] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.3 min: [t=00:01:53.940276][f=0034785] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.3 min: [t=00:01:53.963326][f=0034800] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.3 min: [t=00:01:54.012403][f=0034815] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.4 min: [t=00:01:54.045518][f=0034830] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.4 min: [t=00:01:54.069127][f=0034845] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.4 min: [t=00:01:54.101573][f=0034860] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.4 min: [t=00:01:54.149270][f=0034875] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.4 min: [t=00:01:54.171891][f=0034890] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.4 min: [t=00:01:54.211797][f=0034905] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.4 min: [t=00:01:54.244189][f=0034920] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.4 min: [t=00:01:54.292328][f=0034935] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.4 min: [t=00:01:54.312931][f=0034950] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.4 min: [t=00:01:54.354697][f=0034965] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.4 min: [t=00:01:54.387143][f=0034980] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.4 min: [t=00:01:54.422412][f=0034995] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.4 min: [t=00:01:54.459754][f=0035010] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.5 min: [t=00:01:54.483623][f=0035025] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.5 min: [t=00:01:54.516353][f=0035040] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.5 min: [t=00:01:54.536751][f=0035055] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.5 min: [t=00:01:54.561540][f=0035070] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.5 min: [t=00:01:54.577125][f=0035085] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.5 min: [t=00:01:54.603780][f=0035100] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.5 min: [t=00:01:54.646891][f=0035115] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.5 min: [t=00:01:54.660192][f=0035130] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.5 min: [t=00:01:54.687640][f=0035145] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.5 min: [t=00:01:54.713309][f=0035160] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.5 min: [t=00:01:54.760887][f=0035175] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.6 min: [t=00:01:54.795591][f=0035190] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.6 min: [t=00:01:54.818687][f=0035205] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.6 min: [t=00:01:54.848325][f=0035220] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.6 min: [t=00:01:54.887577][f=0035235] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.6 min: [t=00:01:54.910730][f=0035250] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.6 min: [t=00:01:54.942555][f=0035265] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.6 min: [t=00:01:54.977389][f=0035280] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.6 min: [t=00:01:55.018000][f=0035295] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.6 min: [t=00:01:55.050394][f=0035310] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.6 min: [t=00:01:55.090245][f=0035325] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.6 min: [t=00:01:55.112644][f=0035340] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.6 min: [t=00:01:55.147113][f=0035355] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.6 min: [t=00:01:55.171900][f=0035370] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.7 min: [t=00:01:55.239853][f=0035385] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.7 min: [t=00:01:55.266935][f=0035400] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.7 min: [t=00:01:55.343884][f=0035415] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.7 min: [t=00:01:55.367493][f=0035430] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.7 min: [t=00:01:55.397288][f=0035445] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.7 min: [t=00:01:55.413075][f=0035460] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.7 min: [t=00:01:55.444272][f=0035475] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.7 min: [t=00:01:55.467226][f=0035490] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.7 min: [t=00:01:55.497323][f=0035505] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.7 min: [t=00:01:55.525105][f=0035520] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.7 min: [t=00:01:55.574773][f=0035535] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.8 min: [t=00:01:55.598281][f=0035550] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.8 min: [t=00:01:55.631269][f=0035565] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.8 min: [t=00:01:55.659323][f=0035580] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.8 min: [t=00:01:55.702034][f=0035595] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.8 min: [t=00:01:55.762053][f=0035610] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.8 min: [t=00:01:55.801930][f=0035625] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.8 min: [t=00:01:55.829994][f=0035640] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.8 min: [t=00:01:55.878838][f=0035655] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.8 min: [t=00:01:55.909943][f=0035670] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.8 min: [t=00:01:55.949505][f=0035685] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.8 min: [t=00:01:55.982789][f=0035700] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.8 min: [t=00:01:56.037621][f=0035715] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.9 min: [t=00:01:56.069180][f=0035730] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.9 min: [t=00:01:56.095336][f=0035745] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.9 min: [t=00:01:56.452515][f=0035760] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.9 min: [t=00:01:56.494199][f=0035775] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.9 min: [t=00:01:56.528111][f=0035790] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.9 min: [t=00:01:56.580941][f=0035805] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.9 min: [t=00:01:56.630523][f=0035820] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.9 min: [t=00:01:56.690328][f=0035835] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.9 min: [t=00:01:56.734432][f=0035850] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.9 min: [t=00:01:56.791702][f=0035865] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.9 min: [t=00:01:56.843426][f=0035880] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.9 min: [t=00:01:56.924716][f=0035895] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 19.9 min: [t=00:01:56.975947][f=0035910] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.0 min: [t=00:01:57.045493][f=0035925] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.0 min: [t=00:01:57.100200][f=0035940] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.0 min: [t=00:01:57.153563][f=0035955] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.0 min: [t=00:01:57.198903][f=0035970] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.0 min: [t=00:01:57.244112][f=0035985] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.0 min: [t=00:01:57.279579][f=0036000] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.0 min: [t=00:01:57.356398][f=0036015] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.0 min: [t=00:01:57.570694][f=0036030] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.0 min: [t=00:01:58.318074][f=0036045] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.0 min: [t=00:01:58.333621][f=0036060] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.0 min: [t=00:01:58.364929][f=0036075] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.1 min: [t=00:01:58.391706][f=0036090] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.1 min: [t=00:01:58.427559][f=0036105] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.1 min: [t=00:01:58.460411][f=0036120] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.1 min: [INVARIANT] INV-029 legap 27352 stands 16 cells from the turrets, not tight
- forbid 'invariant' hit at 20.1 min: [t=00:01:58.516241][f=0036135] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.1 min: [t=00:01:58.550767][f=0036150] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.1 min: [t=00:01:58.588064][f=0036165] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.1 min: [t=00:01:58.633049][f=0036180] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.1 min: [t=00:01:58.664087][f=0036195] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.1 min: [t=00:01:58.694869][f=0036210] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.1 min: [t=00:01:58.727514][f=0036225] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.1 min: [t=00:01:58.743132][f=0036240] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.1 min: [t=00:01:58.768016][f=0036255] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.1 min: [t=00:01:58.807785][f=0036270] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.2 min: [t=00:01:58.836381][f=0036285] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.2 min: [t=00:01:58.851660][f=0036300] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.2 min: [t=00:01:58.891251][f=0036315] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.2 min: [t=00:01:58.913605][f=0036330] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.2 min: [t=00:01:58.945191][f=0036345] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.2 min: [t=00:01:58.958306][f=0036360] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.2 min: [t=00:01:58.984099][f=0036375] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.2 min: [t=00:01:59.001227][f=0036390] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.2 min: [t=00:01:59.034125][f=0036405] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.2 min: [t=00:01:59.057319][f=0036420] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.2 min: [t=00:01:59.095044][f=0036435] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.2 min: [t=00:01:59.114612][f=0036450] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.3 min: [t=00:01:59.144144][f=0036465] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.3 min: [t=00:01:59.170110][f=0036480] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.3 min: [t=00:01:59.208605][f=0036495] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.3 min: [t=00:01:59.232808][f=0036510] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.3 min: [t=00:01:59.266580][f=0036525] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.3 min: [t=00:01:59.297665][f=0036540] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.3 min: [t=00:01:59.399382][f=0036555] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.3 min: [t=00:01:59.440989][f=0036570] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.3 min: [t=00:01:59.462171][f=0036585] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.3 min: [t=00:01:59.498329][f=0036600] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.3 min: [t=00:01:59.541436][f=0036615] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.4 min: [t=00:01:59.574077][f=0036630] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.4 min: [t=00:01:59.607289][f=0036645] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.4 min: [t=00:01:59.639348][f=0036660] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.4 min: [t=00:01:59.677300][f=0036675] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.4 min: [t=00:01:59.703449][f=0036690] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.4 min: [t=00:01:59.737986][f=0036705] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.4 min: [t=00:01:59.770020][f=0036720] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.4 min: [t=00:01:59.813747][f=0036735] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.4 min: [t=00:01:59.846658][f=0036750] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.4 min: [t=00:01:59.900393][f=0036765] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.4 min: [t=00:01:59.938273][f=0036780] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.4 min: [t=00:01:59.969487][f=0036795] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.4 min: [t=00:01:59.983987][f=0036810] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.5 min: [t=00:02:00.013412][f=0036825] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.5 min: [t=00:02:00.030626][f=0036840] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.5 min: [t=00:02:00.060598][f=0036855] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.5 min: [t=00:02:00.072606][f=0036870] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.5 min: [t=00:02:00.103985][f=0036885] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.5 min: [t=00:02:00.129580][f=0036900] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.5 min: [t=00:02:00.173048][f=0036915] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.5 min: [t=00:02:00.194962][f=0036930] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.5 min: [t=00:02:00.223024][f=0036945] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.5 min: [t=00:02:00.239649][f=0036960] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.5 min: [t=00:02:00.276952][f=0036975] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.6 min: [t=00:02:00.321483][f=0036990] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.6 min: [t=00:02:00.352278][f=0037005] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.6 min: [t=00:02:00.380566][f=0037020] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.6 min: [t=00:02:00.421064][f=0037035] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.6 min: [t=00:02:00.440928][f=0037050] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.6 min: [t=00:02:00.477245][f=0037065] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.6 min: [t=00:02:00.517781][f=0037080] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.6 min: [t=00:02:00.554216][f=0037095] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.6 min: [t=00:02:00.587294][f=0037110] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.6 min: [t=00:02:00.611459][f=0037125] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.6 min: [t=00:02:00.643865][f=0037140] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.6 min: [t=00:02:00.676288][f=0037155] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.6 min: [t=00:02:00.692998][f=0037170] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.7 min: [t=00:02:00.719082][f=0037185] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.7 min: [t=00:02:00.765937][f=0037200] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.7 min: [t=00:02:00.806022][f=0037215] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.7 min: [t=00:02:00.827867][f=0037230] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.7 min: [t=00:02:00.861017][f=0037245] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.7 min: [t=00:02:00.892438][f=0037260] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.7 min: [t=00:02:00.935508][f=0037275] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.7 min: [t=00:02:00.948689][f=0037290] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.7 min: [t=00:02:00.977849][f=0037305] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.7 min: [t=00:02:00.992473][f=0037320] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.7 min: [t=00:02:01.032500][f=0037335] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.8 min: [t=00:02:01.053213][f=0037350] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.8 min: [t=00:02:01.080198][f=0037365] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.8 min: [t=00:02:01.104250][f=0037380] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.8 min: [t=00:02:01.133825][f=0037395] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.8 min: [t=00:02:01.163566][f=0037410] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.8 min: [t=00:02:01.188472][f=0037425] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.8 min: [t=00:02:01.210851][f=0037440] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.8 min: [t=00:02:01.239582][f=0037455] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.8 min: [t=00:02:01.255133][f=0037470] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.8 min: [t=00:02:01.287044][f=0037485] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.8 min: [t=00:02:01.313459][f=0037500] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.8 min: [t=00:02:01.367418][f=0037515] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.9 min: [t=00:02:01.380572][f=0037530] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.9 min: [t=00:02:01.416124][f=0037545] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.9 min: [t=00:02:01.433686][f=0037560] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.9 min: [t=00:02:01.460438][f=0037575] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.9 min: [t=00:02:01.490803][f=0037590] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.9 min: [t=00:02:01.510338][f=0037605] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.9 min: [t=00:02:01.537477][f=0037620] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.9 min: [t=00:02:01.584089][f=0037635] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.9 min: [t=00:02:01.603899][f=0037650] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.9 min: [t=00:02:01.640658][f=0037665] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.9 min: [t=00:02:01.679868][f=0037680] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.9 min: [t=00:02:01.715708][f=0037695] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 20.9 min: [t=00:02:01.731286][f=0037710] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.0 min: [t=00:02:01.754932][f=0037725] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.0 min: [t=00:02:01.770092][f=0037740] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.0 min: [t=00:02:01.803434][f=0037755] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.0 min: [t=00:02:01.837060][f=0037770] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.0 min: [t=00:02:01.857414][f=0037785] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.0 min: [t=00:02:01.885945][f=0037800] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.0 min: [t=00:02:01.928607][f=0037815] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.0 min: [t=00:02:01.944473][f=0037830] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.0 min: [t=00:02:01.972683][f=0037845] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.0 min: [t=00:02:01.990581][f=0037860] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.0 min: [t=00:02:02.018775][f=0037875] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.1 min: [t=00:02:02.058032][f=0037890] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.1 min: [t=00:02:02.075538][f=0037905] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.1 min: [t=00:02:02.103427][f=0037920] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.1 min: [t=00:02:02.124515][f=0037935] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.1 min: [t=00:02:02.158827][f=0037950] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.1 min: [t=00:02:02.187635][f=0037965] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.1 min: [t=00:02:02.215719][f=0037980] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.1 min: [t=00:02:02.255501][f=0037995] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.1 min: [t=00:02:02.290831][f=0038010] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.1 min: [t=00:02:02.324183][f=0038025] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.1 min: [t=00:02:02.342793][f=0038040] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.1 min: [t=00:02:02.375395][f=0038055] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.1 min: [t=00:02:02.406089][f=0038070] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.2 min: [t=00:02:02.422869][f=0038085] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.2 min: [t=00:02:02.451207][f=0038100] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.2 min: [t=00:02:02.498195][f=0038115] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.2 min: [t=00:02:02.568093][f=0038130] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.2 min: [t=00:02:02.602782][f=0038145] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.2 min: [t=00:02:02.621570][f=0038160] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.2 min: [t=00:02:02.658380][f=0038175] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.2 min: [t=00:02:02.694417][f=0038190] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.2 min: [t=00:02:02.733298][f=0038205] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.2 min: [t=00:02:02.771919][f=0038220] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.2 min: [t=00:02:02.819222][f=0038235] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.2 min: [t=00:02:02.860290][f=0038250] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.3 min: [t=00:02:02.901229][f=0038265] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.3 min: [t=00:02:02.938891][f=0038280] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.3 min: [t=00:02:03.000753][f=0038295] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.3 min: [t=00:02:03.045985][f=0038310] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.3 min: [t=00:02:03.068613][f=0038325] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.3 min: [t=00:02:03.098433][f=0038340] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.3 min: [t=00:02:03.129030][f=0038355] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.3 min: [t=00:02:03.142293][f=0038370] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.3 min: [t=00:02:03.173414][f=0038385] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.3 min: [t=00:02:03.196622][f=0038400] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.3 min: [t=00:02:03.236737][f=0038415] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.4 min: [t=00:02:03.269511][f=0038430] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.4 min: [t=00:02:03.305516][f=0038445] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.4 min: [t=00:02:03.355618][f=0038460] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.4 min: [t=00:02:03.397354][f=0038475] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.4 min: [t=00:02:03.429603][f=0038490] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.4 min: [t=00:02:03.474802][f=0038505] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.4 min: [t=00:02:03.509916][f=0038520] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.4 min: [t=00:02:03.535496][f=0038535] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.4 min: [t=00:02:03.570092][f=0038550] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.4 min: [t=00:02:03.613632][f=0038565] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.4 min: [t=00:02:03.672594][f=0038580] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.4 min: [t=00:02:03.707930][f=0038595] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.4 min: [t=00:02:03.744002][f=0038610] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.5 min: [t=00:02:03.768963][f=0038625] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.5 min: [t=00:02:03.804706][f=0038640] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.5 min: [t=00:02:03.838772][f=0038655] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.5 min: [t=00:02:03.871912][f=0038670] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.5 min: [t=00:02:03.895238][f=0038685] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.5 min: [t=00:02:03.927006][f=0038700] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.5 min: [t=00:02:03.971537][f=0038715] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.5 min: [t=00:02:03.995063][f=0038730] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.5 min: [t=00:02:04.017712][f=0038745] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.5 min: [t=00:02:04.043628][f=0038760] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.5 min: [t=00:02:04.062665][f=0038775] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.6 min: [t=00:02:04.085254][f=0038790] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.6 min: [t=00:02:04.104795][f=0038805] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.6 min: [t=00:02:04.136011][f=0038820] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.6 min: [INVARIANT] INV-029 legaap 14792 stands 11 cells from the turrets, not tight
- forbid 'invariant' hit at 21.6 min: [t=00:02:04.173085][f=0038835] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.6 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 21.6 min: [t=00:02:04.233390][f=0038850] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.6 min: [t=00:02:04.273936][f=0038865] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.6 min: [t=00:02:04.316544][f=0038880] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.6 min: [t=00:02:04.376539][f=0038895] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.6 min: [t=00:02:04.391308][f=0038910] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.6 min: [t=00:02:04.419528][f=0038925] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.6 min: [t=00:02:04.435739][f=0038940] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.6 min: [t=00:02:04.483268][f=0038955] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.6 min: [t=00:02:04.522284][f=0038970] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.7 min: [t=00:02:04.554369][f=0038985] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.7 min: [t=00:02:04.586557][f=0039000] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.7 min: [t=00:02:04.628888][f=0039015] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.7 min: [t=00:02:04.642626][f=0039030] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.7 min: [t=00:02:04.681813][f=0039045] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.7 min: [t=00:02:04.724667][f=0039060] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.7 min: [t=00:02:04.795335][f=0039075] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.7 min: [t=00:02:04.843166][f=0039090] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.7 min: [t=00:02:04.890617][f=0039105] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.7 min: [t=00:02:04.932310][f=0039120] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.7 min: [t=00:02:04.973945][f=0039135] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.8 min: [t=00:02:05.012589][f=0039150] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.8 min: [t=00:02:05.058455][f=0039165] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.8 min: [t=00:02:05.125780][f=0039180] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.8 min: [t=00:02:05.212327][f=0039195] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.8 min: [t=00:02:05.269327][f=0039210] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.8 min: [t=00:02:05.312332][f=0039225] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.8 min: [t=00:02:05.356534][f=0039240] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.8 min: [t=00:02:05.413086][f=0039255] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.8 min: [t=00:02:05.455956][f=0039270] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.8 min: [t=00:02:05.509750][f=0039285] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.8 min: [t=00:02:05.557342][f=0039300] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.8 min: [t=00:02:05.628696][f=0039315] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.9 min: [t=00:02:05.652384][f=0039330] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.9 min: [t=00:02:05.714813][f=0039345] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.9 min: [t=00:02:05.737433][f=0039360] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.9 min: [t=00:02:05.805942][f=0039375] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.9 min: [t=00:02:05.885478][f=0039390] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.9 min: [t=00:02:05.970298][f=0039405] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.9 min: [t=00:02:05.992134][f=0039420] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.9 min: [t=00:02:06.037474][f=0039435] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.9 min: [t=00:02:06.072551][f=0039450] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.9 min: [t=00:02:06.129731][f=0039465] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.9 min: [t=00:02:06.155181][f=0039480] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.9 min: [t=00:02:06.214652][f=0039495] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 21.9 min: [t=00:02:06.245638][f=0039510] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.0 min: [t=00:02:06.299919][f=0039525] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.0 min: [t=00:02:06.326671][f=0039540] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.0 min: [t=00:02:06.355502][f=0039555] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.0 min: [t=00:02:06.374119][f=0039570] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.0 min: [t=00:02:06.404784][f=0039585] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.0 min: [t=00:02:06.419907][f=0039600] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.0 min: [t=00:02:06.483039][f=0039615] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.0 min: [t=00:02:06.496469][f=0039630] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.0 min: [t=00:02:06.549107][f=0039645] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.0 min: [t=00:02:06.575044][f=0039660] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.0 min: [t=00:02:06.619877][f=0039675] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.1 min: [t=00:02:06.649508][f=0039690] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.1 min: [t=00:02:06.687468][f=0039705] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.1 min: [t=00:02:06.731499][f=0039720] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.1 min: [t=00:02:06.783160][f=0039735] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.1 min: [t=00:02:06.805383][f=0039750] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.1 min: [t=00:02:06.881779][f=0039765] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.1 min: [t=00:02:06.944485][f=0039780] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.1 min: [t=00:02:06.990007][f=0039795] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.1 min: [t=00:02:07.028139][f=0039810] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.1 min: [t=00:02:07.070732][f=0039825] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.1 min: [t=00:02:07.100604][f=0039840] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.1 min: [t=00:02:07.146687][f=0039855] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.1 min: [t=00:02:07.181301][f=0039870] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.2 min: [t=00:02:07.224396][f=0039885] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.2 min: [t=00:02:07.246057][f=0039900] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.2 min: [t=00:02:07.297410][f=0039915] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.2 min: [t=00:02:07.313539][f=0039930] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.2 min: [t=00:02:07.343091][f=0039945] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.2 min: [t=00:02:07.415092][f=0039960] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.2 min: [t=00:02:07.589300][f=0039975] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.2 min: [t=00:02:07.628499][f=0039990] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.2 min: [t=00:02:07.651725][f=0040005] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.2 min: [t=00:02:07.680986][f=0040020] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.2 min: [t=00:02:07.724803][f=0040035] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.2 min: [t=00:02:07.757942][f=0040050] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.3 min: [t=00:02:07.791883][f=0040065] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.3 min: [t=00:02:07.874110][f=0040080] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.3 min: [t=00:02:07.922518][f=0040095] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.3 min: [t=00:02:07.950899][f=0040110] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.3 min: [t=00:02:07.997549][f=0040125] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.3 min: [t=00:02:08.022718][f=0040140] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.3 min: [t=00:02:08.046112][f=0040155] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.3 min: [t=00:02:08.085340][f=0040170] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.3 min: [t=00:02:08.127063][f=0040185] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.3 min: [t=00:02:08.201767][f=0040200] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.3 min: [t=00:02:08.292439][f=0040215] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.4 min: [t=00:02:08.332957][f=0040230] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.4 min: [t=00:02:08.384213][f=0040245] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.4 min: [t=00:02:08.403489][f=0040260] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.4 min: [t=00:02:08.442650][f=0040275] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.4 min: [t=00:02:08.478156][f=0040290] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.4 min: [t=00:02:08.508595][f=0040305] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.4 min: [t=00:02:08.537562][f=0040320] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.4 min: [t=00:02:08.625051][f=0040335] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.4 min: [t=00:02:08.677957][f=0040350] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.4 min: [t=00:02:08.750936][f=0040365] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.4 min: [t=00:02:08.782393][f=0040380] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.4 min: [t=00:02:08.817589][f=0040395] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.4 min: [t=00:02:08.848822][f=0040410] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.5 min: [t=00:02:08.885506][f=0040425] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.5 min: [t=00:02:08.916303][f=0040440] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.5 min: [t=00:02:08.952493][f=0040455] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.5 min: [t=00:02:09.037355][f=0040470] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.5 min: [t=00:02:09.089270][f=0040485] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.5 min: [t=00:02:09.135261][f=0040500] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.5 min: [t=00:02:09.243337][f=0040515] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.5 min: [t=00:02:09.275942][f=0040530] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.5 min: [t=00:02:09.301003][f=0040545] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.5 min: [t=00:02:09.415156][f=0040560] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.5 min: [t=00:02:09.492127][f=0040575] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.6 min: [t=00:02:09.564340][f=0040590] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.6 min: [t=00:02:09.611779][f=0040605] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.6 min: [t=00:02:09.671433][f=0040620] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.6 min: [t=00:02:09.730296][f=0040635] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.6 min: [t=00:02:09.778013][f=0040650] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.6 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 22.6 min: [t=00:02:09.844498][f=0040665] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.6 min: [t=00:02:09.875789][f=0040680] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.6 min: [t=00:02:09.933139][f=0040695] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.6 min: [t=00:02:09.998623][f=0040710] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.6 min: [t=00:02:10.057516][f=0040725] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.6 min: [t=00:02:10.075535][f=0040740] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.6 min: [t=00:02:10.110414][f=0040755] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.6 min: [t=00:02:10.138477][f=0040770] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.7 min: [t=00:02:10.212661][f=0040785] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.7 min: [t=00:02:10.282731][f=0040800] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.7 min: [t=00:02:10.345900][f=0040815] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.7 min: [t=00:02:10.408749][f=0040830] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.7 min: [t=00:02:10.666233][f=0040845] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.7 min: [t=00:02:10.785220][f=0040860] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.7 min: [t=00:02:10.896633][f=0040875] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.7 min: [t=00:02:11.051076][f=0040890] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.7 min: [t=00:02:11.097642][f=0040905] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.7 min: [t=00:02:11.148470][f=0040920] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.7 min: [t=00:02:11.262149][f=0040935] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.8 min: [t=00:02:11.344640][f=0040950] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.8 min: [t=00:02:11.406695][f=0040965] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.8 min: [t=00:02:11.482315][f=0040980] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.8 min: [t=00:02:11.530325][f=0040995] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.8 min: [t=00:02:11.574932][f=0041010] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.8 min: [t=00:02:11.612751][f=0041025] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.8 min: [t=00:02:11.664560][f=0041040] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.8 min: [t=00:02:11.740652][f=0041055] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.8 min: [t=00:02:11.825661][f=0041070] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.8 min: [t=00:02:11.885797][f=0041085] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.8 min: [t=00:02:11.937121][f=0041100] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.8 min: [t=00:02:12.025655][f=0041115] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.9 min: [t=00:02:12.094786][f=0041130] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.9 min: [t=00:02:12.138949][f=0041145] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.9 min: [t=00:02:12.212241][f=0041160] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.9 min: [t=00:02:12.253802][f=0041175] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.9 min: [t=00:02:12.365869][f=0041190] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.9 min: [t=00:02:12.435595][f=0041205] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.9 min: [t=00:02:12.568451][f=0041220] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.9 min: [t=00:02:12.627067][f=0041235] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.9 min: [t=00:02:12.723657][f=0041250] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.9 min: [t=00:02:12.775253][f=0041265] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.9 min: [t=00:02:12.811605][f=0041280] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.9 min: [t=00:02:12.849791][f=0041295] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 22.9 min: [t=00:02:12.891586][f=0041310] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.0 min: [t=00:02:12.979072][f=0041325] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.0 min: [t=00:02:13.052377][f=0041340] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.0 min: [t=00:02:13.090024][f=0041355] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.0 min: [t=00:02:13.154091][f=0041370] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.0 min: [t=00:02:13.283171][f=0041385] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.0 min: [t=00:02:13.348710][f=0041400] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.0 min: [t=00:02:13.439754][f=0041415] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.0 min: [t=00:02:13.517131][f=0041430] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.0 min: [t=00:02:13.556557][f=0041445] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.0 min: [t=00:02:13.588932][f=0041460] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.0 min: [t=00:02:13.634160][f=0041475] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.1 min: [t=00:02:13.671985][f=0041490] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.1 min: [t=00:02:13.745450][f=0041505] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.1 min: [t=00:02:13.952795][f=0041520] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.1 min: [t=00:02:14.057450][f=0041535] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.1 min: [t=00:02:14.116380][f=0041550] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.1 min: [t=00:02:14.208323][f=0041565] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.1 min: [t=00:02:14.259737][f=0041580] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.1 min: [t=00:02:14.318828][f=0041595] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.1 min: [t=00:02:14.347763][f=0041610] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.1 min: [t=00:02:14.414558][f=0041625] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.1 min: [t=00:02:14.497837][f=0041640] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.1 min: [t=00:02:14.653787][f=0041655] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.1 min: [t=00:02:14.708414][f=0041670] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.2 min: [t=00:02:14.781843][f=0041685] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.2 min: [t=00:02:14.827967][f=0041700] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.2 min: [t=00:02:14.877697][f=0041715] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.2 min: [INVARIANT] INV-020 no layout room for legafus for 120 s
- forbid 'invariant' hit at 23.2 min: [t=00:02:14.906489][f=0041730] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.2 min: [t=00:02:14.986810][f=0041745] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.2 min: [t=00:02:15.060039][f=0041760] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.2 min: [t=00:02:15.115712][f=0041775] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.2 min: [t=00:02:15.202612][f=0041790] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.2 min: [t=00:02:15.226094][f=0041805] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.2 min: [t=00:02:15.254022][f=0041820] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.2 min: [t=00:02:15.288537][f=0041835] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.2 min: [t=00:02:15.449633][f=0041850] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.3 min: [t=00:02:15.535505][f=0041865] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.3 min: [t=00:02:15.606789][f=0041880] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.3 min: [t=00:02:15.670649][f=0041895] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.3 min: [t=00:02:15.730760][f=0041910] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.3 min: [t=00:02:15.774563][f=0041925] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.3 min: [t=00:02:15.793912][f=0041940] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.3 min: [t=00:02:15.828970][f=0041955] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.3 min: [t=00:02:15.868896][f=0041970] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.3 min: [t=00:02:15.949712][f=0041985] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.3 min: [t=00:02:16.011348][f=0042000] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.3 min: [t=00:02:16.130031][f=0042015] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.4 min: [t=00:02:16.234403][f=0042030] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.4 min: [t=00:02:16.319683][f=0042045] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.4 min: [t=00:02:16.346619][f=0042060] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.4 min: [t=00:02:16.417957][f=0042075] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.4 min: [t=00:02:16.495882][f=0042090] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.4 min: [t=00:02:16.535213][f=0042105] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.4 min: [t=00:02:16.557961][f=0042120] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.4 min: [t=00:02:16.730173][f=0042135] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.4 min: [t=00:02:16.819826][f=0042150] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.4 min: [t=00:02:16.934791][f=0042165] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.4 min: [t=00:02:17.038170][f=0042180] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.4 min: [t=00:02:17.112967][f=0042195] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.4 min: [t=00:02:17.239113][f=0042210] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.5 min: [t=00:02:17.335822][f=0042225] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.5 min: [t=00:02:17.451091][f=0042240] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.5 min: [t=00:02:17.546503][f=0042255] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.5 min: [t=00:02:17.602895][f=0042270] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.5 min: [t=00:02:17.668907][f=0042285] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.5 min: [t=00:02:17.726271][f=0042300] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.5 min: [INVARIANT] INV-053 air constructor 29610 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 23.5 min: [t=00:02:17.791997][f=0042315] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.5 min: [t=00:02:17.859801][f=0042330] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.5 min: [t=00:02:18.872268][f=0042345] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.5 min: [t=00:02:18.914420][f=0042360] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.5 min: [t=00:02:18.972052][f=0042375] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.6 min: [t=00:02:19.067077][f=0042390] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.6 min: [t=00:02:19.109619][f=0042405] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.6 min: [t=00:02:19.146536][f=0042420] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.6 min: [t=00:02:19.272728][f=0042435] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.6 min: [t=00:02:19.355972][f=0042450] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.6 min: [t=00:02:19.466952][f=0042465] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.6 min: [t=00:02:19.637703][f=0042480] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.6 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 23.6 min: [t=00:02:19.744356][f=0042495] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.6 min: [t=00:02:20.016464][f=0042510] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.6 min: [t=00:02:20.097482][f=0042525] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.6 min: [t=00:02:20.162091][f=0042540] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.6 min: [t=00:02:20.383500][f=0042555] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.6 min: [t=00:02:20.420466][f=0042570] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.7 min: [t=00:02:20.463138][f=0042585] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.7 min: [t=00:02:20.542120][f=0042600] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.7 min: [t=00:02:20.666924][f=0042615] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.7 min: [t=00:02:20.808406][f=0042630] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.7 min: [t=00:02:20.940974][f=0042645] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.7 min: [t=00:02:21.008862][f=0042660] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.7 min: [t=00:02:21.121384][f=0042675] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.7 min: [t=00:02:21.189579][f=0042690] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.7 min: [t=00:02:21.239743][f=0042705] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.7 min: [t=00:02:21.278459][f=0042720] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.7 min: [t=00:02:21.443182][f=0042735] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.8 min: [t=00:02:21.563552][f=0042750] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.8 min: [t=00:02:21.733172][f=0042765] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.8 min: [t=00:02:21.944151][f=0042780] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.8 min: [t=00:02:22.026179][f=0042795] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.8 min: [t=00:02:22.230961][f=0042810] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.8 min: [t=00:02:22.457472][f=0042825] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.8 min: [t=00:02:22.613777][f=0042840] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.8 min: [t=00:02:22.667749][f=0042855] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.8 min: [t=00:02:22.715101][f=0042870] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.8 min: [t=00:02:22.769995][f=0042885] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.8 min: [t=00:02:22.908736][f=0042900] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.8 min: [t=00:02:22.996446][f=0042915] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.9 min: [t=00:02:23.089379][f=0042930] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.9 min: [t=00:02:23.243211][f=0042945] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.9 min: [t=00:02:23.298965][f=0042960] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.9 min: [t=00:02:23.401423][f=0042975] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.9 min: [t=00:02:23.454756][f=0042990] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.9 min: [t=00:02:23.516140][f=0043005] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.9 min: [t=00:02:23.596796][f=0043020] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.9 min: [t=00:02:23.650964][f=0043035] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.9 min: [t=00:02:23.750711][f=0043050] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.9 min: [t=00:02:23.838636][f=0043065] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.9 min: [t=00:02:23.941970][f=0043080] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.9 min: [t=00:02:24.040448][f=0043095] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 23.9 min: [t=00:02:24.119478][f=0043110] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.0 min: [t=00:02:24.327299][f=0043125] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.0 min: [t=00:02:24.406712][f=0043140] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.0 min: [t=00:02:24.458569][f=0043155] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.0 min: [t=00:02:24.544618][f=0043170] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.0 min: [t=00:02:24.620279][f=0043185] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.0 min: [t=00:02:24.666763][f=0043200] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.0 min: [t=00:02:24.722672][f=0043215] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.0 min: [t=00:02:24.769842][f=0043230] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.0 min: [t=00:02:24.855919][f=0043245] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.0 min: [t=00:02:24.889850][f=0043260] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.0 min: [t=00:02:24.945831][f=0043275] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.1 min: [t=00:02:25.037040][f=0043290] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.1 min: [t=00:02:25.096574][f=0043305] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.1 min: [t=00:02:25.174042][f=0043320] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.1 min: [t=00:02:25.243442][f=0043335] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.1 min: [t=00:02:25.326917][f=0043350] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.1 min: [t=00:02:25.395110][f=0043365] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.1 min: [t=00:02:25.486729][f=0043380] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.1 min: [t=00:02:25.549128][f=0043395] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.1 min: [t=00:02:25.626326][f=0043410] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.1 min: [t=00:02:25.700905][f=0043425] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.1 min: [t=00:02:25.800283][f=0043440] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.1 min: [t=00:02:25.898489][f=0043455] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.1 min: [t=00:02:25.990507][f=0043470] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.2 min: [t=00:02:26.084505][f=0043485] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.2 min: [t=00:02:26.149714][f=0043500] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.2 min: [t=00:02:26.222123][f=0043515] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.2 min: [INVARIANT] INV-020 no layout room for legmstor for 180 s
- forbid 'invariant' hit at 24.2 min: [t=00:02:26.307283][f=0043530] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.2 min: [t=00:02:26.372155][f=0043545] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.2 min: [t=00:02:26.448984][f=0043560] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.2 min: [t=00:02:26.535756][f=0043575] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.2 min: [t=00:02:26.562545][f=0043590] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.2 min: [t=00:02:26.604851][f=0043605] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.2 min: [t=00:02:26.667655][f=0043620] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.2 min: [t=00:02:26.724800][f=0043635] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.2 min: [t=00:02:26.816147][f=0043650] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.3 min: [t=00:02:26.890226][f=0043665] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.3 min: [t=00:02:26.991951][f=0043680] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.3 min: [t=00:02:27.062983][f=0043695] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.3 min: [t=00:02:27.132294][f=0043710] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.3 min: [t=00:02:27.347496][f=0043725] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.3 min: [t=00:02:27.483453][f=0043740] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.3 min: [t=00:02:27.525251][f=0043755] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.3 min: [t=00:02:27.562659][f=0043770] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.3 min: [t=00:02:27.627060][f=0043785] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.3 min: [t=00:02:27.667374][f=0043800] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.3 min: [t=00:02:27.733121][f=0043815] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.4 min: [t=00:02:27.792939][f=0043830] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.4 min: [t=00:02:27.872464][f=0043845] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.4 min: [t=00:02:27.964451][f=0043860] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.4 min: [t=00:02:28.051743][f=0043875] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.4 min: [t=00:02:28.155486][f=0043890] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.4 min: [t=00:02:28.246888][f=0043905] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.4 min: [t=00:02:28.357656][f=0043920] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.4 min: [t=00:02:28.436863][f=0043935] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.4 min: [t=00:02:28.516561][f=0043950] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.4 min: [t=00:02:28.620465][f=0043965] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.4 min: [t=00:02:28.701887][f=0043980] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.4 min: [t=00:02:28.770779][f=0043995] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.4 min: [t=00:02:28.853654][f=0044010] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.5 min: [t=00:02:28.970938][f=0044025] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.5 min: [t=00:02:29.034479][f=0044040] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.5 min: [t=00:02:29.081412][f=0044055] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.5 min: [t=00:02:29.162647][f=0044070] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.5 min: [t=00:02:29.260976][f=0044085] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.5 min: [t=00:02:29.355394][f=0044100] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.5 min: [INVARIANT] INV-053 air constructor 1146 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 24.5 min: [INVARIANT] INV-053 air constructor 18792 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 24.5 min: [INVARIANT] INV-053 air constructor 24446 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 24.5 min: [t=00:02:29.473346][f=0044115] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.5 min: [t=00:02:29.540389][f=0044130] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.5 min: [t=00:02:29.620053][f=0044145] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.5 min: [t=00:02:29.687926][f=0044160] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.5 min: [t=00:02:29.765519][f=0044175] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.6 min: [t=00:02:29.876284][f=0044190] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.6 min: [t=00:02:29.954556][f=0044205] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.6 min: [t=00:02:30.006460][f=0044220] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.6 min: [t=00:02:30.051333][f=0044235] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.6 min: [t=00:02:30.089504][f=0044250] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.6 min: [t=00:02:30.136309][f=0044265] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.6 min: [t=00:02:30.205628][f=0044280] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.6 min: [t=00:02:30.282088][f=0044295] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.6 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 24.6 min: [t=00:02:30.340589][f=0044310] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.6 min: [t=00:02:30.424349][f=0044325] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.6 min: [t=00:02:30.498877][f=0044340] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.6 min: [t=00:02:30.622528][f=0044355] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.6 min: [t=00:02:30.705377][f=0044370] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.7 min: [t=00:02:30.920353][f=0044385] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.7 min: [t=00:02:31.124777][f=0044400] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.7 min: [t=00:02:31.225816][f=0044415] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.7 min: [t=00:02:31.315217][f=0044430] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.7 min: [t=00:02:31.377295][f=0044445] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.7 min: [t=00:02:31.456209][f=0044460] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.7 min: [t=00:02:31.520984][f=0044475] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.7 min: [t=00:02:31.596082][f=0044490] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.7 min: [t=00:02:31.649424][f=0044505] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.7 min: [t=00:02:31.695605][f=0044520] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.7 min: [t=00:02:31.789429][f=0044535] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.8 min: [t=00:02:31.895319][f=0044550] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.8 min: [t=00:02:31.969478][f=0044565] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.8 min: [t=00:02:32.058067][f=0044580] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.8 min: [t=00:02:32.133087][f=0044595] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.8 min: [t=00:02:32.226308][f=0044610] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.8 min: [t=00:02:32.311081][f=0044625] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.8 min: [t=00:02:32.406070][f=0044640] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.8 min: [t=00:02:32.477709][f=0044655] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.8 min: [t=00:02:32.546397][f=0044670] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.8 min: [t=00:02:32.647318][f=0044685] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.8 min: [t=00:02:32.684755][f=0044700] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.8 min: [t=00:02:32.728300][f=0044715] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.9 min: [t=00:02:32.768595][f=0044730] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.9 min: [t=00:02:32.805628][f=0044745] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.9 min: [t=00:02:32.873765][f=0044760] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.9 min: [t=00:02:32.972398][f=0044775] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.9 min: [t=00:02:33.049578][f=0044790] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.9 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (1 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 24.9 min: [t=00:02:33.136348][f=0044805] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.9 min: [t=00:02:33.206000][f=0044820] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.9 min: [t=00:02:33.282358][f=0044835] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.9 min: [t=00:02:33.348919][f=0044850] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.9 min: [t=00:02:33.421267][f=0044865] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.9 min: [t=00:02:33.504817][f=0044880] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.9 min: [t=00:02:33.585272][f=0044895] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 24.9 min: [t=00:02:33.657663][f=0044910] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.0 min: [t=00:02:33.744948][f=0044925] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.0 min: [t=00:02:33.824430][f=0044940] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.0 min: [t=00:02:33.916446][f=0044955] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.0 min: [t=00:02:33.976122][f=0044970] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.0 min: [t=00:02:34.095242][f=0044985] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.0 min: [t=00:02:34.147803][f=0045000] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.0 min: [t=00:02:34.213725][f=0045015] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.0 min: [t=00:02:34.351588][f=0045030] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.0 min: [t=00:02:34.452669][f=0045045] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.0 min: [t=00:02:34.528709][f=0045060] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.0 min: [t=00:02:34.606231][f=0045075] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.1 min: [t=00:02:34.665026][f=0045090] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.1 min: [t=00:02:34.754081][f=0045105] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.1 min: [t=00:02:34.814924][f=0045120] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.1 min: [t=00:02:34.892989][f=0045135] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.1 min: [t=00:02:34.947480][f=0045150] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.1 min: [t=00:02:35.015709][f=0045165] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.1 min: [t=00:02:35.072895][f=0045180] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.1 min: [t=00:02:35.144902][f=0045195] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.1 min: [t=00:02:35.246534][f=0045210] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.1 min: [t=00:02:35.336594][f=0045225] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.1 min: [t=00:02:35.406928][f=0045240] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.1 min: [t=00:02:35.441839][f=0045255] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.1 min: [t=00:02:35.482532][f=0045270] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.2 min: [t=00:02:35.528079][f=0045285] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.2 min: [t=00:02:35.613013][f=0045300] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.2 min: [t=00:02:35.671816][f=0045315] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.2 min: [INVARIANT] INV-020 no layout room for legafus for 240 s
- forbid 'invariant' hit at 25.2 min: [t=00:02:35.752655][f=0045330] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.2 min: [t=00:02:35.917221][f=0045345] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.2 min: [t=00:02:36.070400][f=0045360] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.2 min: [t=00:02:36.153176][f=0045375] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.2 min: [t=00:02:36.224465][f=0045390] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.2 min: [t=00:02:36.310587][f=0045405] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.2 min: [t=00:02:36.371289][f=0045420] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.2 min: [t=00:02:36.446085][f=0045435] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.2 min: [t=00:02:36.541678][f=0045450] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.3 min: [t=00:02:36.643894][f=0045465] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.3 min: [t=00:02:36.710023][f=0045480] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.3 min: [t=00:02:36.795727][f=0045495] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.3 min: [t=00:02:36.868738][f=0045510] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.3 min: [t=00:02:36.977481][f=0045525] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.3 min: [t=00:02:37.042939][f=0045540] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.3 min: [t=00:02:37.090893][f=0045555] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.3 min: [t=00:02:37.155555][f=0045570] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.3 min: [t=00:02:37.242215][f=0045585] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.3 min: [t=00:02:37.358019][f=0045600] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.3 min: [t=00:02:37.456608][f=0045615] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.4 min: [t=00:02:37.523049][f=0045630] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.4 min: [t=00:02:37.682747][f=0045645] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.4 min: [t=00:02:37.874916][f=0045660] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.4 min: [t=00:02:37.945041][f=0045675] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.4 min: [t=00:02:37.993146][f=0045690] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.4 min: [t=00:02:38.072342][f=0045705] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.4 min: [t=00:02:38.164912][f=0045720] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.4 min: [t=00:02:38.268973][f=0045735] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.4 min: [t=00:02:38.362991][f=0045750] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.4 min: [t=00:02:38.467154][f=0045765] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.4 min: [t=00:02:38.581764][f=0045780] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.4 min: [t=00:02:38.669116][f=0045795] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.4 min: [t=00:02:38.778671][f=0045810] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.5 min: [t=00:02:38.886963][f=0045825] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.5 min: [t=00:02:39.000838][f=0045840] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.5 min: [t=00:02:39.116014][f=0045855] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.5 min: [t=00:02:39.224228][f=0045870] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.5 min: [t=00:02:39.366650][f=0045885] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.5 min: [t=00:02:39.468489][f=0045900] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.5 min: [INVARIANT] INV-053 air constructor 10871 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 25.5 min: [INVARIANT] INV-053 air constructor 23955 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 25.5 min: [INVARIANT] INV-053 air constructor 31335 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 25.5 min: [INVARIANT] INV-053 air constructor 4014 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 25.5 min: [INVARIANT] INV-053 air constructor 20100 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 25.5 min: [INVARIANT] INV-053 air constructor 10346 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 25.5 min: [INVARIANT] INV-053 air constructor 4559 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 25.5 min: [t=00:02:39.565976][f=0045915] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.5 min: [t=00:02:39.675357][f=0045930] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.5 min: [t=00:02:39.802418][f=0045945] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.5 min: [t=00:02:39.902630][f=0045960] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.5 min: [t=00:02:40.146616][f=0045975] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.6 min: [t=00:02:40.379012][f=0045990] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.6 min: [t=00:02:40.481265][f=0046005] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.6 min: [t=00:02:40.559510][f=0046020] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.6 min: [t=00:02:40.641120][f=0046035] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.6 min: [t=00:02:40.717319][f=0046050] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.6 min: [t=00:02:40.808266][f=0046065] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.6 min: [t=00:02:40.902301][f=0046080] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.6 min: [t=00:02:40.980867][f=0046095] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.6 min: [t=00:02:41.023085][f=0046110] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.6 min: [t=00:02:41.069864][f=0046125] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.6 min: [t=00:02:41.120070][f=0046140] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.6 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 25.6 min: [t=00:02:41.205317][f=0046155] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.6 min: [t=00:02:41.303770][f=0046170] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.7 min: [t=00:02:41.380766][f=0046185] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.7 min: [t=00:02:41.470457][f=0046200] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.7 min: [t=00:02:41.585835][f=0046215] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.7 min: [t=00:02:41.655682][f=0046230] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.7 min: [t=00:02:41.744225][f=0046245] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.7 min: [t=00:02:41.846248][f=0046260] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.7 min: [t=00:02:42.000954][f=0046275] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.7 min: [t=00:02:42.211861][f=0046290] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.7 min: [t=00:02:42.368362][f=0046305] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.7 min: [t=00:02:42.442580][f=0046320] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.7 min: [t=00:02:42.522916][f=0046335] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.8 min: [t=00:02:42.625444][f=0046350] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.8 min: [t=00:02:42.727154][f=0046365] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.8 min: [t=00:02:42.830949][f=0046380] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.8 min: [t=00:02:42.911663][f=0046395] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.8 min: [t=00:02:42.986553][f=0046410] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.8 min: [t=00:02:43.052409][f=0046425] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.8 min: [t=00:02:43.099272][f=0046440] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.8 min: [t=00:02:43.150681][f=0046455] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.8 min: [t=00:02:43.206191][f=0046470] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.8 min: [t=00:02:43.296999][f=0046485] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.8 min: [t=00:02:43.384194][f=0046500] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.8 min: [t=00:02:43.460600][f=0046515] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.9 min: [t=00:02:43.529738][f=0046530] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.9 min: [t=00:02:43.614756][f=0046545] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.9 min: [t=00:02:43.696820][f=0046560] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.9 min: [t=00:02:43.933269][f=0046575] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.9 min: [t=00:02:44.136789][f=0046590] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.9 min: [t=00:02:44.189815][f=0046605] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.9 min: [t=00:02:44.242722][f=0046620] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.9 min: [t=00:02:44.323259][f=0046635] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.9 min: [t=00:02:44.389692][f=0046650] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.9 min: [t=00:02:44.502484][f=0046665] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.9 min: [t=00:02:44.610248][f=0046680] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.9 min: [t=00:02:44.709081][f=0046695] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 25.9 min: [t=00:02:44.827863][f=0046710] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.0 min: [t=00:02:44.949910][f=0046725] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.0 min: [t=00:02:45.043209][f=0046740] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.0 min: [t=00:02:45.165401][f=0046755] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.0 min: [t=00:02:45.272711][f=0046770] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.0 min: [t=00:02:45.381981][f=0046785] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.0 min: [t=00:02:45.512941][f=0046800] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.0 min: [INVARIANT] INV-053 air constructor 31603 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 26.0 min: [INVARIANT] INV-053 air constructor 824 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 26.0 min: [INVARIANT] INV-053 air constructor 6818 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 26.0 min: [t=00:02:45.624112][f=0046815] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.0 min: [t=00:02:45.722066][f=0046830] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.0 min: [t=00:02:45.845041][f=0046845] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.0 min: [t=00:02:45.952117][f=0046860] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.0 min: [t=00:02:46.096579][f=0046875] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.1 min: [t=00:02:46.245998][f=0046890] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.1 min: [t=00:02:46.443964][f=0046905] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.1 min: [t=00:02:46.648031][f=0046920] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.1 min: [t=00:02:46.727544][f=0046935] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.1 min: [t=00:02:46.796564][f=0046950] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.1 min: [t=00:02:46.881071][f=0046965] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.1 min: [t=00:02:46.964608][f=0046980] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.1 min: [t=00:02:47.036630][f=0046995] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.1 min: [t=00:02:47.100211][f=0047010] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.1 min: [t=00:02:47.182092][f=0047025] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.1 min: [t=00:02:47.247054][f=0047040] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.1 min: [t=00:02:47.298180][f=0047055] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.1 min: [t=00:02:47.362621][f=0047070] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.2 min: [t=00:02:47.445520][f=0047085] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.2 min: [t=00:02:47.546822][f=0047100] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.2 min: [t=00:02:47.618465][f=0047115] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.2 min: [t=00:02:47.708656][f=0047130] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.2 min: [INVARIANT] INV-020 no layout room for legafus for 300 s
- forbid 'invariant' hit at 26.2 min: [t=00:02:47.791825][f=0047145] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.2 min: [t=00:02:47.882348][f=0047160] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.2 min: [t=00:02:47.991805][f=0047175] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.2 min: [t=00:02:48.206821][f=0047190] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.2 min: [t=00:02:48.275981][f=0047205] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.2 min: [t=00:02:48.331491][f=0047220] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.2 min: [t=00:02:48.415530][f=0047235] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.2 min: [t=00:02:48.521581][f=0047250] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.3 min: [t=00:02:48.620343][f=0047265] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.3 min: [t=00:02:48.710756][f=0047280] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.3 min: [t=00:02:48.808294][f=0047295] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.3 min: [t=00:02:48.887572][f=0047310] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.3 min: [t=00:02:48.963671][f=0047325] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.3 min: [t=00:02:49.121575][f=0047340] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.3 min: [t=00:02:49.198502][f=0047355] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.3 min: [t=00:02:49.289393][f=0047370] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.3 min: [t=00:02:49.355018][f=0047385] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.3 min: [t=00:02:49.440120][f=0047400] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.3 min: [t=00:02:49.523993][f=0047415] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.4 min: [t=00:02:49.555613][f=0047430] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.4 min: [t=00:02:49.599651][f=0047445] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.4 min: [t=00:02:49.677320][f=0047460] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.4 min: [t=00:02:49.763735][f=0047475] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.4 min: [t=00:02:49.915386][f=0047490] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.4 min: [t=00:02:50.060828][f=0047505] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.4 min: [t=00:02:50.130550][f=0047520] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.4 min: [t=00:02:50.208295][f=0047535] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.4 min: [t=00:02:50.267691][f=0047550] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.4 min: [t=00:02:50.329353][f=0047565] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.4 min: [t=00:02:50.399464][f=0047580] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.4 min: [t=00:02:50.464374][f=0047595] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.4 min: [t=00:02:50.556002][f=0047610] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.5 min: [t=00:02:50.644401][f=0047625] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.5 min: [t=00:02:50.732214][f=0047640] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.5 min: [t=00:02:50.855230][f=0047655] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.5 min: [t=00:02:50.928281][f=0047670] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.5 min: [t=00:02:51.044222][f=0047685] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.5 min: [t=00:02:51.135631][f=0047700] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.5 min: [INVARIANT] INV-053 air constructor 16807 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 26.5 min: [INVARIANT] INV-053 air constructor 30231 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 26.5 min: [INVARIANT] INV-053 air constructor 15479 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 26.5 min: [INVARIANT] INV-053 air constructor 10623 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 26.5 min: [t=00:02:51.262341][f=0047715] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.5 min: [t=00:02:51.353817][f=0047730] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.5 min: [t=00:02:51.436779][f=0047745] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.5 min: [t=00:02:51.485350][f=0047760] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.5 min: [t=00:02:51.552048][f=0047775] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.6 min: [t=00:02:51.652045][f=0047790] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.6 min: [t=00:02:51.733800][f=0047805] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.6 min: [t=00:02:51.868616][f=0047820] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.6 min: [t=00:02:51.940946][f=0047835] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.6 min: [t=00:02:52.020661][f=0047850] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.6 min: [t=00:02:52.113525][f=0047865] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.6 min: [t=00:02:52.206629][f=0047880] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.6 min: [t=00:02:52.275049][f=0047895] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.6 min: [t=00:02:52.357598][f=0047910] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.6 min: [t=00:02:52.443341][f=0047925] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.6 min: [t=00:02:52.523476][f=0047940] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.6 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 26.6 min: [t=00:02:52.594820][f=0047955] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.6 min: [t=00:02:52.671282][f=0047970] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.7 min: [t=00:02:52.738371][f=0047985] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.7 min: [t=00:02:52.825533][f=0048000] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.7 min: [t=00:02:52.925799][f=0048015] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.7 min: [t=00:02:53.000601][f=0048030] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.7 min: [t=00:02:53.083133][f=0048045] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.7 min: [t=00:02:53.165722][f=0048060] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.7 min: [t=00:02:53.311241][f=0048075] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.7 min: [t=00:02:53.452937][f=0048090] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.7 min: [t=00:02:53.508820][f=0048105] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.7 min: [t=00:02:53.575159][f=0048120] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.7 min: [t=00:02:53.653531][f=0048135] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.8 min: [t=00:02:53.693010][f=0048150] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.8 min: [t=00:02:53.738442][f=0048165] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.8 min: [t=00:02:53.850674][f=0048180] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.8 min: [t=00:02:53.938008][f=0048195] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.8 min: [t=00:02:54.013068][f=0048210] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.8 min: [t=00:02:54.105658][f=0048225] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.8 min: [t=00:02:54.198456][f=0048240] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.8 min: [t=00:02:54.279043][f=0048255] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.8 min: [t=00:02:54.349226][f=0048270] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.8 min: [t=00:02:54.445859][f=0048285] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.8 min: [t=00:02:54.521546][f=0048300] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.8 min: [t=00:02:54.607470][f=0048315] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.9 min: [t=00:02:54.684622][f=0048330] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.9 min: [t=00:02:54.770440][f=0048345] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.9 min: [t=00:02:54.843194][f=0048360] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.9 min: [t=00:02:55.074119][f=0048375] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.9 min: [t=00:02:55.152699][f=0048390] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.9 min: [t=00:02:55.224113][f=0048405] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.9 min: [t=00:02:55.297377][f=0048420] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.9 min: [t=00:02:55.372103][f=0048435] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.9 min: [t=00:02:55.460361][f=0048450] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.9 min: [t=00:02:55.620863][f=0048465] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.9 min: [t=00:02:55.669144][f=0048480] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.9 min: [t=00:02:55.752609][f=0048495] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 26.9 min: [t=00:02:55.776361][f=0048510] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.0 min: [t=00:02:55.842683][f=0048525] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.0 min: [t=00:02:55.872646][f=0048540] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.0 min: [t=00:02:55.946921][f=0048555] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.0 min: [t=00:02:56.033694][f=0048570] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.0 min: [t=00:02:56.087267][f=0048585] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.0 min: [t=00:02:56.158659][f=0048600] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.0 min: [INVARIANT] INV-053 air constructor 17499 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 27.0 min: [INVARIANT] INV-053 air constructor 18792 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 27.0 min: [INVARIANT] INV-053 air constructor 3979 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 27.0 min: [t=00:02:56.288767][f=0048615] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.0 min: [t=00:02:56.355410][f=0048630] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.0 min: [t=00:02:56.431163][f=0048645] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.0 min: [t=00:02:56.509925][f=0048660] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.0 min: [t=00:02:56.656671][f=0048675] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.1 min: [t=00:02:56.882716][f=0048690] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.1 min: [t=00:02:57.053163][f=0048705] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.1 min: [t=00:02:57.284565][f=0048720] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.1 min: [t=00:02:57.375037][f=0048735] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.1 min: [t=00:02:57.442567][f=0048750] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.1 min: [t=00:02:57.543518][f=0048765] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.1 min: [t=00:02:57.650696][f=0048780] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.1 min: [t=00:02:58.023922][f=0048795] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.1 min: [t=00:02:58.107315][f=0048810] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.1 min: [t=00:02:58.176754][f=0048825] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.1 min: [t=00:02:58.250480][f=0048840] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.1 min: [t=00:02:58.339653][f=0048855] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.1 min: [t=00:02:58.413415][f=0048870] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.2 min: [t=00:02:58.496075][f=0048885] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.2 min: [t=00:02:58.560121][f=0048900] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.2 min: [t=00:02:58.619827][f=0048915] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.2 min: [t=00:02:58.660287][f=0048930] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.2 min: [INVARIANT] INV-020 no layout room for legafus for 360 s
- forbid 'invariant' hit at 27.2 min: [t=00:02:58.722025][f=0048945] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.2 min: [t=00:02:58.810027][f=0048960] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.2 min: [t=00:02:58.874984][f=0048975] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.2 min: [t=00:02:58.928978][f=0048990] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.2 min: [t=00:02:59.063489][f=0049005] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.2 min: [t=00:02:59.187413][f=0049020] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.2 min: [t=00:02:59.257768][f=0049035] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.2 min: [t=00:02:59.341063][f=0049050] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.3 min: [t=00:02:59.487560][f=0049065] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.3 min: [t=00:02:59.568201][f=0049080] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.3 min: [t=00:02:59.679395][f=0049095] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.3 min: [t=00:02:59.756952][f=0049110] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.3 min: [t=00:02:59.837130][f=0049125] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.3 min: [t=00:02:59.916278][f=0049140] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.3 min: [t=00:02:59.989698][f=0049155] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.3 min: [t=00:03:00.087881][f=0049170] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.3 min: [t=00:03:00.176238][f=0049185] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.5 min: [INVARIANT] INV-053 air constructor 1600 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 27.5 min: [INVARIANT] INV-053 air constructor 15672 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 27.5 min: [INVARIANT] INV-053 air constructor 19072 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 27.6 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 27.9 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (1 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 28.0 min: [INVARIANT] INV-053 air constructor 3502 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 28.0 min: [INVARIANT] INV-053 air constructor 16070 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 28.0 min: [INVARIANT] INV-053 air constructor 12376 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 28.2 min: [INVARIANT] INV-020 no layout room for legafus for 420 s
- forbid 'invariant' hit at 28.5 min: [INVARIANT] INV-053 air constructor 22766 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 28.5 min: [INVARIANT] INV-053 air constructor 13773 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 28.5 min: [INVARIANT] INV-053 air constructor 6087 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 28.5 min: [INVARIANT] INV-053 air constructor 1146 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 28.7 min: [INVARIANT] INV-014 legafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 29.0 min: [INVARIANT] INV-053 air constructor 1863 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 29.0 min: [INVARIANT] INV-053 air constructor 18901 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 29.0 min: [INVARIANT] INV-053 air constructor 10346 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 29.0 min: [INVARIANT] INV-053 air constructor 20100 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 29.0 min: [INVARIANT] INV-053 air constructor 31335 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 29.0 min: [INVARIANT] INV-053 air constructor 23955 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 29.0 min: [INVARIANT] INV-053 air constructor 15310 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 29.0 min: [INVARIANT] INV-053 air constructor 10871 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 29.2 min: [INVARIANT] INV-020 no layout room for legafus for 480 s
- forbid 'invariant' hit at 29.5 min: [INVARIANT] INV-053 air constructor 4559 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 29.5 min: [INVARIANT] INV-053 air constructor 824 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 29.5 min: [INVARIANT] INV-053 air constructor 10623 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 29.5 min: [INVARIANT] INV-053 air constructor 15479 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 29.5 min: [INVARIANT] INV-053 air constructor 16807 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 29.5 min: [INVARIANT] INV-053 air constructor 15672 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 29.5 min: [INVARIANT] INV-053 air constructor 31603 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 29.5 min: [INVARIANT] INV-053 air constructor 30452 has done nothing for 60 s (task type 2, last rule wait)

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811001\cohort\20261003T172752Z-f3ec5e2c\tundra\runs\20261003T174339Z-a2208e3a\screen_2026-10-03_17-40-52-972.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811001\cohort\20261003T172752Z-f3ec5e2c\tundra\runs\20261003T174339Z-a2208e3a\screen_2026-10-03_17-41-30-667.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811001\cohort\20261003T172752Z-f3ec5e2c\tundra\runs\20261003T174339Z-a2208e3a\screen_2026-10-03_17-41-52-212.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 30, 5 shots, end at 30.5 min
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
  0.10  [Layout] home centre (2866, 888), 82 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|armada|armap|2810|827|1|2|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(327,467) factory=armlab landLocked=yes spot=0 known=1/1
  0.21  [Playtest] finished armmex team 0 at 0.21 min
  0.22  [Team][Roster] first mex 19579 at 2848,928
  0.22  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|2810|827|1|2|1|2848|928
  0.22  [Team][Roster] team 1 first mex at 480,432
  0.22  [AIR][Rule] opening.mex builder=2274
  0.27  [AIR][Capacity] own=2/30 usage=0/3 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=972 E=18 bank=803 pull=3 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=50/500
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.38  [Playtest] finished armmex team 0 at 0.38 min
  0.43  [AIR][Capacity] own=3/30 usage=0/6 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=3 bank=967 E=30 bank=561 pull=6 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=50/500
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.60  [AIR][Capacity] own=5/30 usage=8/89 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=5 bank=1003 E=30 bank=509 pull=89 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=17/174
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.63  [Playtest] finished armmex team 0 at 0.63 min
  0.65  [AIR][Wind] cluster=0 slots=6 at=3048,928 local=true builder=2274
  0.65  [AIR][Rule] opening.energy builder=2274
  0.77  [AIR][Capacity] own=5/30 usage=7/41 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP M=5 bank=1033 E=30 bank=414 pull=41 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=14/63
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.80  [Playtest] finished armwin team 0 at 0.80 min
  0.91  [Playtest] finished armwin team 0 at 0.91 min
  0.93  [AIR][Capacity] own=7/30 usage=2/22 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=7 bank=1051 E=30 bank=463 pull=22 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=37/161
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 1058/1150, energy +60.3 bank 562/1001, units 7
  1.01  [Playtest] finished armwin team 0 at 1.01 min
  1.10  [AIR][Capacity] own=7/58 usage=7/41 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=7 bank=1069 E=53 bank=750 pull=41 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=10/47
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.12  [Playtest] finished armwin team 0 at 1.12 min
  1.27  [AIR][Capacity] own=7/54 usage=7/41 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=7 bank=1105 E=57 bank=958 pull=41 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=6/29
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.28  [Playtest] finished armwin team 0 at 1.28 min
  1.39  [Playtest] finished armwin team 0 at 1.39 min
  1.40  [AIR][Wind] cluster=1 slots=6 at=2712,848 local=false builder=2274
  1.43  [AIR][Capacity] own=7/53 usage=0/9 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=7 bank=1131 E=55 bank=1001 pull=9 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=1 committed=40/175
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Capacity] own=7/99 usage=0/9 gifts=0 sent=7 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=7 bank=1138 E=89 bank=1003 pull=9 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=1 committed=40/175
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.68  [Playtest] finished armwin team 0 at 1.68 min
  1.70  [AIR][Starter] nearby distance=128
  1.70  [AIR][Rule] opening.plant builder=2274
  1.70  [AIR][EcoLayout] reserved air.eco.0 reactor=1792,816 converters=8 support=12 zone=49
  1.72  [AIR][EcoLayout] reserved air.eco.1 reactor=1792,1328 converters=8 support=12 zone=82
  1.73  [AIR][EcoLayout] reserved air.eco.2 reactor=2304,1840 converters=8 support=12 zone=138
  1.77  [AIR][Capacity] own=7/100 usage=35/69 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] BOOTSTRAP M=7 bank=1057 E=104 bank=997 pull=69 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=0 committed=510/863
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=16353 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Capacity] own=7/101 usage=35/69 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] BOOTSTRAP M=7 bank=779 E=103 bank=1001 pull=69 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=0 committed=152/258
  1.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=16353 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 641/1150, energy +101.5 bank 994/1003, units 12
  2.00  [Playtest] finished armap team 0 at 2.00 min
  2.02  [AIR][Produce] opening.scout armpeep plant=16353 projected=1/1
  2.02  [AIR][State] T1_CONTEST
  2.02  [AIR][Rule] opening.commander.guard builder=2274
  2.10  [AIR][Capacity] own=7/101 usage=8/258 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T1_CONTEST M=7 bank=648 E=101 bank=717 pull=258 plants=1/0 aircraftDemand=3/121
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=16353 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.16  [AIR][Produce] constructor.recovery armca plant=16353 projected=1/3
  2.27  [AIR][Capacity] own=7/107 usage=0/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] T1_CONTEST M=7 bank=651 E=104 bank=608 pull=197 plants=1/0 aircraftDemand=3/121
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=16353 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.37  [AIR][Produce] constructor.recovery armca plant=16353 projected=2/3
  2.37  [AIR][Rule] mex.expand builder=15154
  2.43  [AIR][Capacity] own=7/132 usage=1/29 gifts=0 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T1_CONTEST M=7 bank=657 E=132 bank=1117 pull=197 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=0 committed=50/500
  2.43  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=100 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=16353 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.59  [AIR][Produce] constructor.recovery armca plant=16353 projected=3/3
  2.60  [AIR][Rule] mex.assist builder=14291
  2.60  [AIR][Capacity] own=7/138 usage=10/193 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=50 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T1_CONTEST M=7 bank=630 E=142 bank=1141 pull=193 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=38/380
  2.60  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=16353 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.77  [AIR][Capacity] own=7/104 usage=2/36 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=99 shortage=0 reason=available or arriving power
  2.77  [AIR][Economy] T1_CONTEST M=7 bank=613 E=109 bank=521 pull=225 plants=1/0 aircraftDemand=3/121
  2.77  [AIR][Projects] energyQueued=0 committed=17/170
  2.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=16353 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.82  [AIR][Produce] opening.screen armfig plant=16353 projected=1/6
  2.82  [AIR][Rule] energy.grow builder=19456
  2.88  [Playtest] finished armmex team 0 at 2.88 min
  2.89  [AIR][Rule] mex.expand builder=14291
  2.90  [AIR][Commander] cleared factory guard for commander.energy.local
  2.90  [AIR][Rule] commander.energy.local builder=2274
  2.90  [AIR][Rule] recovery.energy builder=15154
  2.93  [AIR][Capacity] own=3/95 usage=6/95 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=326 shortage=0 reason=funded workload
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=614 E=97 bank=9 pull=203 plants=1/0 aircraftDemand=3/121
  2.93  [AIR][Projects] energyQueued=1 committed=272/794
  2.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=16353 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.00  [Playtest] eco team 0 at 3.0 min: metal +7.0 bank 604/1300, energy +102.1 bank 0/1178, units 22
  3.01  [Playtest] finished armwin team 0 at 3.01 min
  3.02  [AIR][Rule] commander.energy.assist builder=2274
  3.09  [Playtest] finished armwin team 0 at 3.09 min
  3.10  [AIR][Capacity] own=6/97 usage=12/99 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=63 shortage=0 reason=available or arriving power
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=597 E=96 bank=43 pull=104 plants=1/0 aircraftDemand=3/121
  3.10  [AIR][Projects] energyQueued=0 committed=185/474
  3.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=16353 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.11  [AIR][Rule] recovery.energy builder=19456
  3.23  [Playtest] finished armsolar team 0 at 3.23 min
  3.24  [AIR][Rule] commander.factory.guard builder=2274
  3.27  [AIR][Capacity] own=9/123 usage=7/150 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=100 shortage=152 reason=funded workload
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=498 E=123 bank=355 pull=150 plants=1/0 aircraftDemand=3/121
  3.27  [AIR][Projects] energyQueued=1 committed=320/336
  3.27  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=302 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=16353 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.32  [AIR][Produce] opening.screen armfig plant=16353 projected=2/6
  3.32  [AIR][Screen] fighters=1 cells=8 centre=472,839 width=600 advance=400 responding=false
  3.37  [AIR][Layout] cluster=0 labs=1 at=1874,2627
  3.43  [AIR][Capacity] own=8/147 usage=9/147 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=100 shortage=102 reason=funded workload
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=492 E=154 bank=3 pull=351 plants=1/0 aircraftDemand=3/127
  3.43  [AIR][Projects] energyQueued=0 committed=259/290
  3.43  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=252 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=16353 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.50  [AIR][Screen] fighters=1 cells=8 centre=472,839 width=600 advance=400 responding=false
  3.60  [AIR][Capacity] own=7/136 usage=9/133 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=100 shortage=158 reason=funded workload
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=731 E=137 bank=13 pull=273 plants=1/0 aircraftDemand=3/127
  3.60  [AIR][Projects] energyQueued=0 committed=200/290
  3.60  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=308 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=16353 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.67  [AIR][Screen] fighters=1 cells=8 centre=472,839 width=600 advance=400 responding=false
  3.68  [AIR][Produce] opening.screen armfig plant=16353 projected=3/6
  3.77  [AIR][Capacity] own=8/146 usage=10/184 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=100 shortage=141 reason=funded workload
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=728 E=141 bank=3 pull=268 plants=1/0 aircraftDemand=3/127
  3.77  [AIR][Projects] energyQueued=0 committed=136/249
  3.77  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=291 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=16353 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.85  [AIR][Screen] fighters=2 cells=8 centre=472,839 width=600 advance=400 responding=false
  3.88  [AIR][Layout] cluster=1 labs=1 at=3410,1475
  3.90  [AIR][Layout] cluster=2 labs=1 at=3218,1667
  3.93  [AIR][Capacity] own=7/168 usage=9/169 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=100 shortage=58 reason=funded workload
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=724 E=171 bank=4 pull=260 plants=1/0 aircraftDemand=3/127
  3.93  [AIR][Projects] energyQueued=0 committed=76/249
  3.93  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=208 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=16353 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.98  [AIR][Produce] opening.screen armfig plant=16353 projected=4/6
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 723/1300, energy +166.2 bank 53/1229, units 27
  4.01  [Playtest] finished armsolar team 0 at 4.01 min
  4.02  [AIR][Screen] fighters=3 cells=8 centre=472,839 width=600 advance=400 responding=false
  4.10  [AIR][Capacity] own=7/165 usage=7/191 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=50 shortage=183 reason=funded workload
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=729 E=166 bank=13 pull=260 plants=1/0 aircraftDemand=3/127
  4.10  [AIR][Projects] energyQueued=0 committed=187/230
  4.10  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=333 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=16353 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=3 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.15  [Playtest] finished armsolar team 0 at 4.15 min
  4.17  [AIR][Rule] recovery.assist builder=15154
  4.18  [AIR][Screen] fighters=3 cells=8 centre=472,839 width=600 advance=400 responding=false
  4.23  [AIR][Produce] opening.screen armfig plant=16353 projected=5/6
  4.27  [AIR][Capacity] own=8/195 usage=10/154 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=149 shortage=215 reason=funded workload
  4.27  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=973 E=189 bank=274 pull=154 plants=1/0 aircraftDemand=3/127
  4.27  [AIR][Projects] energyQueued=0 committed=135/199
  4.27  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=365 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=16353 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.37  [AIR][Screen] fighters=4 cells=8 centre=472,839 width=600 advance=400 responding=false
  4.43  [AIR][Produce] opening.screen armfig plant=16353 projected=6/6
  4.43  [AIR][Capacity] own=7/246 usage=12/264 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=133 shortage=56 reason=funded workload
  4.43  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=939 E=245 bank=137 pull=322 plants=1/0 aircraftDemand=3/124
  4.43  [AIR][Projects] energyQueued=0 committed=74/188
  4.43  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=206 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=16353 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.53  [AIR][Screen] fighters=5 cells=8 centre=472,839 width=600 advance=400 responding=false
  4.59  [Playtest] finished armsolar team 0 at 4.59 min
  4.60  [AIR][Capacity] own=9/240 usage=13/293 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=100 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.60  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=908 E=245 bank=7 pull=326 plants=1/0 aircraftDemand=3/124
  4.60  [AIR][Projects] energyQueued=0 committed=10/106
  4.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=16353 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Attack] home=5 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=346
  4.60  [AIR][Rule] intel.radar builder=19456
  4.61  [AIR][Rule] wait builder=15154
  4.67  [AIR][Rule] project.assist builder=15154
  4.69  [AIR][Produce] constructor.expand armca plant=16353 projected=4/4
  4.70  [AIR][Screen] fighters=6 cells=8 centre=472,839 width=600 advance=400 responding=false
  4.75  [Playtest] finished armmex team 0 at 4.75 min
  4.76  [AIR][Rule] wait builder=14291
  4.77  [AIR][Capacity] own=7/221 usage=6/81 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=50 idle=50 ecoStatic=0 working=99 shortage=0 reason=no funded workload
  4.77  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=1169 E=225 bank=918 pull=270 plants=1/0 aircraftDemand=3/124
  4.77  [AIR][Projects] energyQueued=0 committed=25/264
  4.77  [AIR][Workforce] t1=4/4 t2=0/2 targetBP=200 floating=true savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=16353 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.85  [Playtest] finished armrad team 0 at 4.85 min
  4.86  [AIR][Rule] energy.grow builder=19456
  4.86  [AIR][Rule] energy.grow builder=15154
  4.87  [AIR][Screen] fighters=6 cells=8 centre=472,839 width=600 advance=400 responding=false
  4.89  [AIR][Rule] opening.support builder=14291
  4.90  [AIR][Commander] cleared factory guard for commander.energy.assist
  4.90  [AIR][Rule] commander.energy.assist builder=2274
  4.91  [AIR][Produce] recon.replace armpeep plant=16353 projected=1/1
  4.92  [AIR][Rule] energy.grow builder=10320
  4.92  [AIR][Layout] cluster=3 labs=1 at=2066,2339
  4.93  [AIR][Capacity] own=11/220 usage=5/45 gifts=0 sent=0 excess=0 pressure=true mobile=200 arriving=0 idle=0 ecoStatic=0 working=399 shortage=186 reason=funded workload
  4.93  [AIR][Economy] T1_CONTEST M=11 bank=1163 E=221 bank=1131 pull=45 plants=1/0 aircraftDemand=3/124
  4.93  [AIR][Projects] energyQueued=1 committed=331/3645
  4.93  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=386 floating=true savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=16353 BP=150 nanos=0+0/2 available=yes firstSlot=2
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.98  [Playtest] finished armwin team 0 at 4.98 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +12.0 bank 1163/1350, energy +254.9 bank 1400/1405, units 35
  5.00  [Playtest] target team 0 at (2800, 800) from its start position
  5.00  [Playtest] camera requested (2928,952) height=2200
  5.00  [AIR][Rule] transition.storage builder=15154
  5.01  [Playtest] camera captured name=ta position=(2928,952) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (2928, 952)
  5.03  [AIR][Screen] fighters=6 cells=8 centre=472,839 width=600 advance=400 responding=false
  5.10  [AIR][Capacity] own=11/246 usage=10/118 gifts=0 sent=0 excess=0 pressure=true mobile=200 arriving=0 idle=0 ecoStatic=0 working=199 shortage=211 reason=funded workload
  5.10  [AIR][Economy] T1_CONTEST M=11 bank=1170 E=236 bank=1398 pull=148 plants=1/0 aircraftDemand=3/124
  5.10  [AIR][Projects] energyQueued=0 committed=575/3830
  5.10  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=411 floating=true savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.10  [AIR][Bay] 0 plant=16353 BP=150 nanos=0+1/2 available=yes firstSlot=2
  5.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=313
  5.15  [AIR][Share] metal 1336 of 1350 (99%): sent 211 to team 1 (82% full); the engine counts 0 metal sent in the last update (D-106)
  5.18  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1188) (D-106)
  5.20  [AIR][Screen] fighters=6 cells=8 centre=472,839 width=600 advance=400 responding=false
  5.25  [AIR][Produce] air.control armfig plant=16353 projected=7/7
  5.25  [AIR][Share] metal 1335 of 1350 (98%): sent 155 to team 1 (87% full); the engine counts 0 metal sent in the last update (D-106)
  5.26  [Playtest] finished armwin team 0 at 5.26 min
  5.27  [AIR][Capacity] own=11/222 usage=8/41 gifts=162 sent=0 excess=0 pressure=true mobile=200 arriving=0 idle=50 ecoStatic=0 working=149 shortage=250 reason=funded workload
  5.27  [AIR][Economy] T1_CONTEST M=11 bank=1335 E=228 bank=1334 pull=71 plants=1/0 aircraftDemand=3/124
  5.27  [AIR][Projects] energyQueued=0 committed=472/3323
  5.27  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=450 floating=true savingLab=false
  5.27  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.27  [AIR][Bay] 0 plant=16353 BP=150 nanos=0+1/2 available=yes firstSlot=2
  5.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.28  [AIR][Rule] commander.factory.guard builder=2274
  5.28  [AIR][Rule] opening.support.assist builder=10320
  5.28  [AIR][Share] after the donation: we sent 133; team 1 received 133 (bank 1188) (D-106)
  5.32  [AIR][State] T1_SCALE
  5.33  [AIR][Share] metal 1332 of 1350 (98%): sent 110 to team 1 (90% full); the engine counts 0 metal sent in the last update (D-106)
  5.37  [AIR][Screen] fighters=6 cells=8 centre=472,839 width=600 advance=400 responding=false
  5.37  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1188) (D-106)
  5.41  [Playtest] finished armwin team 0 at 5.41 min
  5.42  [AIR][Share] metal 1324 of 1350 (98%): sent 108 to team 1 (90% full); the engine counts 0 metal sent in the last update (D-106)
  5.42  [AIR][NanoGate] armca 19456 can=yes busy=yes count=1
  5.42  [AIR][Rule] opening.support.assist builder=19456
  5.43  [AIR][Capacity] own=11/212 usage=15/399 gifts=0 sent=0 excess=0 pressure=true mobile=200 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  5.43  [AIR][Economy] T1_SCALE M=36 bank=1324 E=219 bank=319 pull=460 plants=1/0 aircraftDemand=3/124
  5.43  [AIR][Projects] energyQueued=0 committed=366/2628
  5.43  [AIR][Workforce] t1=4/4 t2=0/2 targetBP=200 floating=true savingLab=false
  5.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.43  [AIR][Bay] 0 plant=16353 BP=150 nanos=0+1/2 available=yes firstSlot=2
  5.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.45  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1188) (D-106)
  5.45  [Ferry] AIR: queued request from team 1
  5.45  [Ferry] AIR: serving team 1 queued=0
  5.47  [AIR][NanoGate] armcom 2274 can=no busy=yes count=1
  5.47  [AIR][Commander] cleared factory guard for commander.idle.energy
  5.47  [AIR][Rule] commander.idle.energy builder=2274
  5.47  [Ferry] AIR: ordered one armatlas for team 1
  5.50  [AIR][Rule] commander.factory.guard builder=2274
  5.50  [AIR][Share] metal 1335 of 1350 (98%): sent 104 to team 1 (91% full); the engine counts 0 metal sent in the last update (D-106)
  5.53  [AIR][Share] after the donation: we sent 84; team 1 received 84 (bank 1188) (D-106)
  5.55  [AIR][Screen] fighters=7 cells=8 centre=472,839 width=600 advance=400 responding=false
  5.58  [AIR][Share] metal 1329 of 1350 (98%): sent 82 to team 1 (93% full); the engine counts 0 metal sent in the last update (D-106)
  5.60  [AIR][Capacity] own=7/204 usage=11/127 gifts=0 sent=0 excess=0 pressure=true mobile=200 arriving=0 idle=0 ecoStatic=0 working=200 shortage=137 reason=funded workload
  5.60  [AIR][Economy] T1_SCALE RECOVERY M=32 bank=1329 E=205 bank=279 pull=218 plants=1/0 aircraftDemand=3/125
  5.60  [AIR][Projects] energyQueued=0 committed=253/1735
  5.60  [AIR][Workforce] t1=4/5 t2=0/2 targetBP=337 floating=true savingLab=false
  5.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  5.60  [AIR][Bay] 0 plant=16353 BP=150 nanos=0+1/0 available=yes firstSlot=2
  5.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.60  [AIR][Attack] home=7 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=283
  5.62  [AIR][Share] after the donation: we sent 61; team 1 received 61 (bank 1188) (D-106)
  5.67  [AIR][State] T1_CONTEST
  5.67  [AIR][Share] metal 1327 of 1350 (98%): sent 74 to team 1 (93% full); the engine counts 0 metal sent in the last update (D-106)
  5.70  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 1188) (D-106)
  5.70  [Ferry] AIR: transport 12941 built for team 1; hold pending task
  5.72  [AIR][Screen] fighters=7 cells=8 centre=472,839 width=600 advance=400 responding=false
  5.72  [Ferry] AIR: transport 12941 flying to (327,467)
  5.75  [AIR][Share] metal 1336 of 1350 (98%): sent 54 to team 1 (95% full); the engine counts 1 metal sent in the last update (D-106)
  5.77  [AIR][Capacity] own=11/219 usage=5/24 gifts=0 sent=1 excess=0 pressure=true mobile=200 arriving=0 idle=0 ecoStatic=0 working=200 shortage=83 reason=funded workload
... 2011 more
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
  0.08  EXP: approach: armcom(1901) at (328, 468) walks to (347, 463), 136 from the armmex site (480, 432)
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
  0.11  EXP: idle: armcom(1901) on armmex at (338, 465), site (480, 432), target yes, fails 2 (arrived at the approach point)
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
  0.18  EXP: approach: corcom(24492) at (4599, 11401) walks to (4532, 11356), 139 from the cormex site (4416, 11280)
  0.22  EXP: approach: armcom(1901) at (338, 465) walks to (280, 654), 136 from the armmex site (240, 784)
  0.22  EXP: approach: armcom(2274) at (2820, 852) walks to (2738, 826), 136 from the armmex site (2608, 784)
  0.25  RESERVE: armlab at (256, 352) facing 2 (id 17)
  0.25  RESERVE: zone 11 at (256, 424) facing 2, 6x3 cells: 0 of 18 held
  0.25  RESERVE: armlab at (272, 144) facing 2 (id 18)
  0.25  RESERVE: zone 11 at (272, 216) facing 2, 6x3 cells: 0 of 18 held
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
  0.34  EXP: approach: corcom(24492) at (4552, 11380) walks to (4747, 11634), 139 from the cormex site (4832, 11744)
  0.39  EXP: approach: armcom(2274) at (2763, 841) walks to (3039, 933), 136 from the armmex site (3168, 976)
  0.42  RESERVE: armlab at (256, 352) facing 2 (id 19)
  0.42  RESERVE: zone 11 at (256, 424) facing 2, 6x3 cells: 0 of 18 held
  0.42  RESERVE: armlab at (288, 144) facing 2 (id 20)
  0.42  RESERVE: zone 11 at (288, 216) facing 2, 6x3 cells: 3 of 18 held
  0.44  RESERVE: armlab at (368, 688) facing 1 (id 21)
  0.44  RESERVE: served armlab at (368, 688) facing 1 (id 21, 1 of this def still held)
  0.58  RESERVE: armlab at (256, 144) facing 2 (id 22)
  0.58  RESERVE: zone 12 at (256, 216) facing 2, 6x3 cells: 3 of 18 held
  0.62  RESERVE: zone 1 at (4824, 11640) facing 2, 3x3 cells: 9 of 9 held
  0.62  RESERVE: corwin at (4824, 11640) facing 2 (id 1)
  0.62  RESERVE: zone 2 at (4776, 11640) facing 2, 3x3 cells: 9 of 9 held
  0.62  RESERVE: corwin at (4776, 11640) facing 2 (id 2)
  0.62  RESERVE: zone 3 at (4728, 11640) facing 2, 3x3 cells: 9 of 9 held
  0.62  RESERVE: corwin at (4728, 11640) facing 2 (id 3)
  0.62  RESERVE: zone 4 at (4824, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.62  RESERVE: corwin at (4824, 11592) facing 2 (id 4)
  0.62  RESERVE: zone 5 at (4776, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.62  RESERVE: corwin at (4776, 11592) facing 2 (id 5)
  0.62  RESERVE: zone 6 at (4728, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.62  RESERVE: corwin at (4728, 11592) facing 2 (id 6)
  0.62  RESERVE: served corwin at (4824, 11640) facing 2 (id 1, 5 of this def still held)
  0.65  RESERVE: zone 1 at (3000, 904) facing 0, 3x3 cells: 9 of 9 held
  0.65  RESERVE: armwin at (3000, 904) facing 0 (id 1)
  0.65  RESERVE: zone 2 at (3048, 904) facing 0, 3x3 cells: 9 of 9 held
  0.65  RESERVE: armwin at (3048, 904) facing 0 (id 2)
  0.65  RESERVE: zone 3 at (3096, 904) facing 0, 3x3 cells: 9 of 9 held
  0.65  RESERVE: armwin at (3096, 904) facing 0 (id 3)
  0.65  RESERVE: zone 4 at (3000, 952) facing 0, 3x3 cells: 9 of 9 held
  0.65  RESERVE: armwin at (3000, 952) facing 0 (id 4)
  0.65  RESERVE: zone 5 at (3048, 952) facing 0, 3x3 cells: 9 of 9 held
  0.65  RESERVE: armwin at (3048, 952) facing 0 (id 5)
  0.65  RESERVE: zone 6 at (3096, 952) facing 0, 3x3 cells: 9 of 9 held
  0.65  RESERVE: armwin at (3096, 952) facing 0 (id 6)
  0.65  RESERVE: served armwin at (3000, 904) facing 0 (id 1, 5 of this def still held)
  0.73  RESERVE: served corwin at (4776, 11640) facing 2 (id 2, 4 of this def still held)
  0.73  RESERVE: corridor 13 at (576, 688) facing 1, 20x10 cells: 150 of 200 held
  0.75  RESERVE: armlab at (256, 352) facing 2 (id 23)
  0.75  RESERVE: zone 14 at (256, 424) facing 2, 6x3 cells: 0 of 18 held
  0.75  RESERVE: armlab at (272, 144) facing 2 (id 24)
```
