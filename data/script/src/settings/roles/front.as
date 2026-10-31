// FRONT defaults. Namespaces and mutable values are API-compatible.
// Profile hooks/JSON loaders may override these; do not reapply defaults at runtime.
// Role entry: ../../roles/front/front.as
namespace Global {
namespace RoleSettings {
namespace Front {
            float BaseSupportRadius = 1000.0f; // first land constructor stays with home economy
            bool GeothermalEnabled = true;
            uint GeothermalBuilders = 2;
            float GeothermalRadius = 3200.0f;
            // FRONT funds a T1 vent over three minutes while reserving half
            // its conservative income for units and ordinary energy growth.
            float GeothermalBudgetSeconds = 180.0f;
            float GeothermalIncomeFraction = 0.5f;
            float GeothermalBootstrapEnergy = 120.0f;

            // First factory at the spawn (owner, 2026-10-19; systems/construction/front_spawn_factory.as).
            // Off here; experimental_balanced turns it on. Until a factory is framed: commander jobs further
            // than the leash radius from the spawn become a solar at the spawn; from SpawnFactorySeconds,
            // while energy income is short of native's start check, every non-energy job does too.
            bool SpawnFactoryEnabled = false;
            int SpawnFactorySeconds = 45;
            float SpawnFactoryLeashRadius = 700.0f;   // 0 = no leash
            int SpawnFactoryLeashMaxSeconds = 180;    // after this, native as before

            // Role switch cadence (seconds)
            int MinAiSwitchTime = 20;
            int MaxAiSwitchTime = 60;

            // NukeLimit: maximum number of nukes allowed for FRONT role
            /******************** FRONT BASE SETTINGS ********************/
            // All settings applied to front role at game start, logic can change throughout game
            float AllyRange = 900.0f;

            /******************** FRONT MILITARY QUOTAS ********************/
            // Scout unit cap for FRONT role (defaults)
            // Attack gate (required power to trigger attack waves) (defaults)
            // Raid thresholds (power) (defaults)

            // Split thresholds by opening: bots vs vehicles.
            // These default to the baseline values above; tweak per-profile as needed.
            int MilitaryScoutCapBots = 7;
            int MilitaryScoutCapVehicles = 2;
            float MilitaryAttackThresholdBots = 12.0f;
            float MilitaryAttackThresholdVehicles = 30.0f;
            float MilitaryRaidMinPowerBots = 12.0f;
            float MilitaryRaidMinPowerVehicles = 40.0f;
            float MilitaryRaidAvgPowerBots = 60.0f;
            float MilitaryRaidAvgPowerVehicles = 180.0f;

            // Number of T1 scouts/raiders to rush from the very first T1 land factory
            // Only applies to the first T1 Bot Lab or Vehicle Plant built; subsequent factories use normal logic
            int ScoutRushCount = 1;

             /******************** FRONT NANO POLICY ********************/
            // How much income per additional T1 nano caretaker; and cap
            float NanoEnergyPerUnit = 150.0f; // energy per nano
            int NanoMaxCount = 200; 
            int NanoMinCount = 1;
            float NanoEnergyIncomeThresholdForMax = 2000.0f;
            // Reserves-based nano condition threshold
            float NanoBuildWhenOverMetal = 1000.0f;

            // Minimum constructor maintenance targets for factory recruitment
            int MinT1BotConstructorCount = 1;
            int MinT1VehicleConstructorCount = 1;

            // Minimum T2 constructor targets for FRONT role.
            // These mirror TECH's MinimumT2ConstructorBots but are scoped to FRONT so
            // front.as can enforce its own T2 constructor policy without cross-referencing.
            int MinT2BotConstructorCount = 1;
            int MinT2VehicleConstructorCount = 1;

            // Time triggers for T2 lab construction
            int TimeTriggerForFirstT2LabSeconds = 22 * 60; // 22 minutes
            // The time trigger above fires only while metal income is at least this (0 = no floor, as before).
            // Stops a FRONT that lost its base from ordering a T2 lab/plant at +3 metal right after rebuilding a T1 factory.
            float TimeTriggerForFirstT2LabMinMetalIncome = 0.0f;
            int TimeTriggerForT2EcoGatingSeconds = 20 * 60; // 20 minutes

            // Combat settings
            int DefaultT1CombatFireState = 3;

            // Start Caps
            int StartCapRezBots = 10;
            int StartCapT1AircraftPlants = 0;
            int StartCapNukeSilos = 0;

            // Nuclear silos (owner, 2026-10-30; systems/construction/front_silo_grid.as). From NukeMinSeconds,
            // once the 10 s minimum metal / energy income have stayed at or above NukeMetalIncome / NukeEnergyIncome
            // for NukeSustainSeconds without a break, one silo at a time up to NukeLimit, all on one grid reserved
            // at the first: SiloGridColumns across, no gap, SiloGridMargin clear round it, at least SiloGridLaneClear
            // off every allied start's line to its nearest enemy start, nearest home first. Log [FRONT][SiloGrid].
            bool SiloGrid = true;
            int NukeLimit = 8;
            int NukeMinSeconds = 35 * 60;
            float NukeMetalIncome = 225.0f;
            float NukeEnergyIncome = 2000.0f;
            int NukeSustainSeconds = 60;
            int SiloGridColumns = 4;
            float SiloGridMargin = 48.0f;
            float SiloGridLaneClear = 200.0f;   // played: 500 left no site round a FRONT (8 allied lanes cross its base)
            float SiloGridSearchStep = 256.0f;
            int SiloGridSearchRings = 20;       // x SiloGridSearchStep: 5,120 out (played: edge FRONTs found no site within 3,584)
            int SiloGridSearchSpokes = 32;
            int SiloGridRetrySeconds = 30;
            int SiloGridRetryMaxSeconds = 300;
            int SiloGridMaxTries = 12;          // reservations tried per search (each reserves up to NukeLimit slots)

            // Dynamic Quota Settings
            float DynamicQuotaEnemyCostAttackThresholdMultiplier = 1.0f;
            float DynamicQuotaEnemyCostWithdrawThresholdMultiplier = 0.8f;
            float UnderpoweredAttackQuota = 100.0f;
            float UnderpoweredRaidMinQuota = 100.0f;
            float UnderpoweredRaidAvgQuota = 200.0f;
            int DynamicQuotaDelaySeconds = 2 * 60;

            // Economy Scaling Limits
            float MetalIncomePerLab = 35.0f;
            float MetalIncomeForGantry = 225.0f;   // owner, 2026-10-25 (175 before)
            // Owner (2026-10-25): without the eco ladder, the T2 constructors order the gantry themselves at
            // MetalIncomeForGantry (roles/front/front.as Front_TryLadderGantry), not the native factory switch
            bool DirectGantry = true;
            // Owner (2026-10-16): once a fusion stands FRONT reclaims its winds and solars, those within
            // ReclaimNearFactoryRadius of a factory first (played: Fatboys boxed in by advanced solars and
            // winds round the labs), advanced solars too at ReclaimAdvSolarMargin or with an advanced fusion.
            // Off here, on in experimental_balanced (systems/construction/front_reclaim.as).
            bool ReclaimT1EnergyAfterFusion = false;
            float ReclaimT1EnergyMargin = 1.25f;    // energy income without winds/solars covers the pull by this
            float ReclaimAdvSolarMargin = 1.5f;     // ... without advanced solars as well
            float ReclaimNearFactoryRadius = 900.0f;
            float ReclaimEnergyRadius = 3000.0f;   // from the worker
            int ReclaimEnergyConcurrent = 3;
            // Owner (2026-10-16, 2026-10-17): FRONT's eco climbs to a gantry. Three fusions (winds, solars,
            // advanced solars and T1 converters reclaimed once the first stands), one advanced fusion, a
            // second (the fusions reclaimed as it builds), then the gantry, its EcoLadderGantryNanos turrets
            // ordered from the moment it is framed. T2 converters from the first fusion while energy would
            // be wasted (EcoLadderT2ConverterEnergy, EcoLadderT2ConverterReserve); past two advanced fusions,
            // one more at a time until metal income reaches EcoLadderGantryMetalIncome, which the gantry
            // waits for; once it stands with its turrets, advanced fusions resume. Converters only with the
            // energy bank at EcoLadderConvertBankPercent. The stage caps the native eco too (fusions 3,
            // advanced fusions 2, then EcoLadderMaxAdvFusions). Off here, on in experimental_balanced
            // (systems/construction/front_eco_ladder.as). Log [FRONT][Eco].
            bool EcoLadder = false;
            float EcoLadderFusionMetalIncome = 20.0f;     // first, second and third fusion
            float EcoLadderAdvFusionMetalIncome = 30.0f;  // first and second advanced fusion
            float EcoLadderStoredFraction = 0.3f;         // or a bank of this share of its metal cost
            int EcoLadderT1Converters = 5;                // unused since 2026-10-17 (no T1 converters once a fusion stands)
            int EcoLadderT2ConvertersTwoFusions = 2;      // unused since 2026-10-17 (surplus-based)
            int EcoLadderT2ConvertersPerAdvFusion = 3;    // unused since 2026-10-17 (surplus-based)
            int EcoLadderMaxT2Converters = 30;
            // T2 converters from the first fusion: one more while energy income beats the pull by a
            // converter's draw plus this reserve and the bank is at EcoLadderConvertBankPercent (owner, 2026-10-17)
            float EcoLadderT2ConverterEnergy = 600.0f;
            float EcoLadderT2ConverterReserve = 200.0f;
            float EcoLadderConvertFullPercent = 0.9f;     // or one more whenever the energy bank is this full
            int EcoLadderMaxAdvFusions = 8;               // past two, one after another while metal income is under the gantry's, and after it
            int EcoLadderGantryNanos = 6;                 // caretaker turrets on the gantry before advanced fusions resume
            // owner, 2026-10-26 (gantry turrets first): every FRONT builder (T2 constructors too) helps a gantry
            // turret frame before the gantry frame, and up to EcoLadderGantryNanoParallel turret orders go out at once
            bool EcoLadderGantryNanoFirst = false;
            int EcoLadderGantryNanoParallel = 3;
            int EcoLadderFrameHelpers = 4;                // the ladder's constructors on a reactor frame at a time
            float EcoLadderFrameHelpRadius = 3000.0f;     // a frame this near the constructor
            float EcoLadderConvertBankPercent = 0.6f;
            int EcoLadderGantryAfterAdvFusions = 2;       // the gantry step once this many advanced fusions stand (1 in experimental_balanced)
            // Owner (2026-10-31): rezzed fusions of other factions, underwater/cloaked fusions and every geothermal
            // plant (regular and advanced) count as fusions for the ladder, so one standing is "the first fusion stands"
            bool EcoLadderFusionEquivalents = false;
            // Owner (2026-10-31): energy overflow into metal (systems/construction/front_overflow.as). Off here, on in
            // experimental_balanced. OverflowLog (the per-minute [FRONT][Overflow] line) runs either way.
            bool OverflowConverters = false;
            bool OverflowLog = true;
            float OverflowBankPercent = 0.9f;     // the energy bank this full...
            float OverflowSpareEnergy = 800.0f;   // ...or income beating the pull by this
            int OverflowSeconds = 20;             // for this long
            int OverflowParallel = 3;             // T2 converters unfinished at once
            int OverflowMaxConverters = 40;
            int OverflowBlockCols = 3;            // a block: cols x rows converters, no gaps
            int OverflowBlockRows = 3;
            float OverflowBlockMargin = 64.0f;    // free ground round a block (the converter's block-map yard)
            int OverflowBlockFailLimit = 3;       // failed cells before the rest of a block is given up
            float OverflowOrderBankPercent = 0.6f; // no converter order under this bank (native aborts them under 55%)
            int OverflowFullBankParallel = 1;     // converters going up at once while the bank is full, whatever the spare
            float OverflowMaxThreat = 0.0f;       // surface threat allowed at a new block
            int OverflowPullSeconds = 10;         // a helping T2 constructor moved onto a converter at most this often
            bool OverflowMexFirst = true;         // with the bank full, T1 mex upgrades before converters and reactors
            int OverflowExtraT2Seconds = 45;      // extra T2 constructors once an overflow lasts this long:
            int OverflowExtraT2Max = 3;           // 1, plus 1 per OverflowExtraT2Spare above OverflowSpareEnergy, at most this
            float OverflowExtraT2Spare = 1200.0f;
            int MexUpExtraT2Max = 3;              // extra T2 constructors while T1 mexes of ours wait for an upgrade
            int MexUpExtraAssistMax = 2;          // fast-assist bots (Butler, Twitcher, Proteus) for those upgrades
            int OverflowRecruitSeconds = 30;      // one extra recruit at most this often
            // FRONT recovery after losing the base (systems/construction/front_recovery.as); off here, on in experimental_balanced
            bool Recovery = false;
            float RecoveryEnterMetalIncome = 15.0f;      // recovery starts below this metal income...
            float RecoveryMinPeakMetalIncome = 40.0f;    // ...once income had reached this
            float RecoveryExitMetalIncome = 30.0f;       // and ends after RecoveryExitSeconds at or above this
            int RecoveryExitSeconds = 30;
            float RecoveryMexRadius = 2500.0f;           // mex spots retaken within this of the start (then of the worker)
            int RecoveryMinT1Constructors = 3;           // the T1 factory makes this many constructors first
            bool EcoLadderLaterAdvFusionAtStart = false;  // second and later advanced fusions tried at the start before the eco anchor
            float EcoLadderGantryMetalIncome = 225.0f;    // the gantry waits for this metal income (owner, 2026-10-16; 225 since 2026-10-25)
            float EcoLadderFusionReclaimMargin = 1.0f;    // income without the fusion covers the pull (always once the second advanced fusion stands)
            float EcoLadderAnchorBack = 400.0f;           // eco this far behind the start, away from the map centre
            int EcoLadderMetalStorages = 2;               // from the first advanced fusion, while storage is under a fusion's cost plus the spare
            float EcoLadderStorageSpare = 1000.0f;
            int EcoLadderLogSeconds = 60;
            float MetalIncomePerT1Builder = 20.0f;
            int MinBuilderCap = 5;
            float MetalIncomePerT2Builder = 40.0f;

            // Misc Logic Settings
            int RaiderOpenerCount = 10;
            // Opt-in profile policy: retain the first scout, then choose tanks.
            float VehicleTankOpenerChance = 0.0f;
            int VehicleTankGatherSeconds = 300; // release a disrupted/incomplete batch
            // Owner (2026-10-19): after the opener and until a T2 factory stands, a T1 vehicle plant rolls
            // every VehicleTankMassIntervalSeconds; on VehicleTankMassChance it builds VehicleTankMassMin..Max
            // (random) medium tanks (Stout/Brute/Decurion) in succession, held at the plant until the last is
            // out, then on normal orders. Off here, on in experimental_balanced (systems/production/front_tank_mass.as).
            float VehicleTankMassChance = 0.0f;
            int VehicleTankMassIntervalSeconds = 180;
            int VehicleTankMassMin = 5;
            int VehicleTankMassMax = 8;
            int VehicleTankMassGatherSeconds = 480; // release a disrupted/incomplete mass
            // Owner (2026-10-19): the same for a finished T2 vehicle plant, all game: Bull/Tiger/Prometheus,
            // held until the last is out, then sent at the enemy as one attack squad. Off here, on in experimental_balanced.
            float VehicleT2TankMassChance = 0.0f;
            int VehicleT2TankMassIntervalSeconds = 180;
            int VehicleT2TankMassMin = 5;
            int VehicleT2TankMassMax = 8;
            int VehicleT2TankMassGatherSeconds = 600;
            // Owner (2026-10-19): each T2 wave also gets a radar jammer, radar and flak vehicle from the same plant,
            // moved every WaveEscortUpdateSeconds to the wave's safe centre (its tanks' centroid, WaveEscortBehind
            // back toward our start) once that moves WaveEscortRepath. Off here (systems/production/front_wave_escort.as).
            bool VehicleT2WaveEscorts = false;
            float WaveEscortBehind = 150.0f;   // owner (2026-10-20): close behind, moving with the group
            int WaveEscortUpdateSeconds = 2;
            float WaveEscortRepath = 120.0f;
            // Owner (2026-10-20): on the same T2 roll, VehicleT2ArtySquadChance for a faction artillery squad held until
            // complete, then led by its Starlight/Quaker/Cleaver, which stops at ArtySquadRangeFraction of its range from
            // the nearest known enemy; the rest follow ArtySquadFollowBehind behind, all on hold position and fire at will.
            // Off here (systems/production/front_arty_squad.as).
            float VehicleT2ArtySquadChance = 0.0f;
            int ArtySquadUpdateSeconds = 2;
            float ArtySquadRangeFraction = 0.95f;
            float ArtySquadCohesion = 450.0f;
            float ArtySquadFollowBehind = 120.0f;
            float ArtySquadRepath = 96.0f;
            int ArtySquadStragglerSeconds = 60;   // longest the lead waits for stragglers before advancing anyway
            // Owner (2026-10-31): formation. Heavies/anti-spam walk ArtySquadHeavyAhead in front of the artillery lead;
            // the lead advances ArtySquadPaceStep at a time, the next step once every member is within
            // ArtySquadPaceTolerance of its place, so the squad keeps its slowest member's pace.
            float ArtySquadHeavyAhead = 60.0f;
            float ArtySquadHeavySpacing = 80.0f;    // heavies' line abreast, apart
            float ArtySquadPackRadius = 170.0f;     // the other artillery's ring around the lead (support: ArtySquadFollowBehind)
            float ArtySquadPaceStep = 200.0f;
            float ArtySquadPaceTolerance = 90.0f;
            int ArtySquadPaceWaitSeconds = 20;   // longest the lead paces for one member short of its place
            // Owner (2026-10-31): while a finished T2 bot lab stands, every T2BotSquadIntervalSeconds, T2BotSquadChance
            // for one faction bot squad (heavy, or artillery on T2BotSquadArtyShare) with a radar, two jammer and a flak
            // bot, held at the lab until complete, then moved as the artillery squad above. Off here.
            float T2BotSquadChance = 0.0f;
            int T2BotSquadIntervalSeconds = 180;
            float T2BotSquadArtyShare = 0.5f;
            int T2BotSquadGatherSeconds = 600;
            // Owner (2026-10-19): bot lab FRONTs, from the opener wave until a T2 factory stands: every
            // BotWaveIntervalSeconds, BotWaveChance for BotWaveMin..Max Pawns/Grunts (Goblins: BotWaveGoblinMin..Max),
            // held at the lab until the last is out, then one attack wave. Off here, on in experimental_balanced.
            float BotWaveChance = 0.0f;
            int BotWaveIntervalSeconds = 180;
            int BotWaveMin = 10;
            int BotWaveMax = 15;
            int BotWaveGoblinMin = 15;
            int BotWaveGoblinMax = 20;
            int BotWaveGatherSeconds = 360;
            float SwitchFactoryCostMultiplier = 1.2f;
            int ScoutAssignmentLimit = 5;
            float BuilderCostThresholdForBase = 200.0f;

            // Nano Policy Extras
            float NanoMinIncomeForFirst = 10.0f;
            float T2LabStoredMetalThresholdRatio = 0.9f;

            // Transition thresholds for switching between T1 factory types (Bot <-> Vehicle)
            float MinimumMetalIncomeForT1FactoryTransition = 200.0f;

            /******************** FRONT T2 LAB THRESHOLDS ********************/
            // Economy thresholds and caps for building a T2 Bot Lab when in FRONT role
            // Mirrors FrontTech defaults but scoped to Front so front.as does not reference FrontTech settings.
            // Special-case: first T2 lab/plant fast-track threshold (bot or vehicle) when none exist yet
            // If total T2 labs (bot + vehicle) < 1 and metal income >= this, FRONT will attempt to build one.
            float MinimumMetalIncomeForFirstT2Lab = 50.0f;
            float MinimumMetalIncomeForT2Lab = 40.0f;
            // Permanent admission floor once TECH acknowledges a constructor plan.
            // Uses the existing ten-second minimum income; no plan keeps defaults.
            float DeliveredConstructorT2FactoryIncome = 40.0f;
            float MinimumEnergyIncomeForT2Lab = 2000.0f;
            float RequiredMetalCurrentForT2Lab = 200.0f;

            // Vehicle-specific T2 thresholds
            float MinimumMetalIncomeForFirstT2VehiclePlant = 50.0f;

            int MaxT2BotLabs = 1;
            int MaxT2VehicleLabs = 1;

            /******************** FRONT ECONOMY SETTINGS ********************/
            // Consider energy storage "low" when current < storage * percent
            float EnergyStorageLowPercent = 0.90f;

            // Minimum incomes levels before normal Fusion will be built
            float MinimumMetalIncomeForFUS = 40.0f; 
            float MinimumEnergyIncomeForFUS = 1200.0f;
            float MaxEnergyIncomeForFUS = 4000.0f;

            // T2 mex upgrades first (owner, 2026-10-22; systems/construction/front_mex_upgrade.as):
            // a FRONT T2 constructor upgrades our T1 mexes before assisting factories or other
            // constructors' non-mex work, after the eco ladder's own reactor orders. Helpers already on
            // a shared assist/build are pulled to an open upgrade (never a task's last builder).
            bool MexUpgradeFirst = true;
            float MexUpgradeRadius = 100000.0f;   // from the start position; every mex we hold
            int MexUpgradeMaxConcurrent = 3;      // MEXUP tasks of ours at once
            int MexUpgradeScanSeconds = 3;        // how often busy helpers are reconsidered
            // No ping-pong (owner, 2026-10-27): native re-evaluates a walking builder by asking for new
            // work and swaps when the kind differs, so a T2 constructor on its way to an upgrade was sent
            // to help a fusion frame or assist, and the scan above pulled it back 3 s later. A FRONT T2
            // constructor on a MEXUP is now kept on it for up to MexUpgradeCommitSeconds (0: off); the
            // task's own failure, abort and retreat handling still apply. The scan never pulls the same
            // constructor again within MexUpgradeRepullSeconds.
            int MexUpgradeCommitSeconds = 150;
            int MexUpgradeRepullSeconds = 45;
            // Owner (2026-10-27): with the eco ladder on, every T1 mex of ours goes T2 before the second
            // fusion. From the first fusion standing, the ladder's T2 constructors upgrade first (up to
            // MexUpgradeGateConcurrent at once) and the second fusion waits, the native eco capped too,
            // until no T1 mex of ours is left, metal is full, no upgrade has been under way for
            // MexUpgradeGateIdleSeconds (the rest are unreachable or unsafe), or MexUpgradeGateMaxSeconds
            // have passed. Log [FRONT][Eco] mex gate.
            bool EcoLadderMexUpBeforeSecondFusion = true;
            int MexUpgradeGateConcurrent = 4;
            int MexUpgradeGateIdleSeconds = 45;
            int MexUpgradeGateMaxSeconds = 420;

            // T2 lab turrets (owner, 2026-10-25; systems/construction/front_factory_nanos.as): from the moment
            // a T2 bot lab or vehicle plant of ours is framed, FRONT T1 constructors asking for work within
            // T2FactoryNanoReach build its turrets until T2FactoryNanos stand, are framed or are ordered there,
            // at most T2FactoryNanoParallel orders at once (past that they help a turret frame). The turret
            // cap is raised by the turrets still missing. 0: off here; experimental_balanced sets 6 (the
            // Armada and Legion T2 labs' caretaker in factory.json). Log [FRONT][LabNano].
            int T2FactoryNanos = 0;
            int T2FactoryNanosMax = 0;                 // rising to this as the metal bank nears overflow (experimental_balanced 14)
            float T2FactoryNanoBankLow = 0.5f;         // ... from this share of metal storage (none extra)
            float T2FactoryNanoBankHigh = 0.9f;        // ... to this one (all of them)
            int T2FactoryNanoParallel = 3;
            float T2FactoryNanoStartProgress = 0.0f;   // the lab frame's build progress before the first turret
            float T2FactoryNanoRadius = 400.0f;        // a turret this near (and nearer than any other factory) is the lab's
            float T2FactoryNanoReach = 2500.0f;        // idle, guarding or assisting constructors this near the lab are asked
            float T2FactoryNanoTakeRadius = 1200.0f;   // ... and ones walking to an unframed build this near
            int T2FactoryNanoScanSeconds = 2;          // turret count refresh while a lab is short

            // T2 lab corridors and forward lab porc (owner, 2026-10-30; systems/construction/front_lab_porc.as).
            // LabCorridor: every T2 bot lab and vehicle plant of ours reserves its exit cone and a corridor
            // along its movement class's coarse route to the nearest enemy start; no structure goes
            // on it but mexes (spots are holes). Width = that unit's movement footprint x 8 x WidthFactor.
            // LabPorc: a lab more than LabPorcMinDistance from our start gets LabPorcTier's guns (1 = Pit Bull /
            // Scorpion / Chimera, 2 = Rattlesnake / Persecutor / Eviscerator, 3 = the T2 flak) from FRONT T2 constructors.
            // Both off here; experimental_balanced turns them on. Log [FRONT][LabCorridor], [FRONT][LabPorc].
            bool LabCorridor = false;
            float LabCorridorWidthFactor = 2.0f;
            float LabCorridorStopShort = 900.0f;       // the corridor ends this far short of the enemy start
            float LabCorridorExitLength = 240.0f;      // the exit cone in front of the lab
            // lab, the largest unit it makes (by movement class), that class's footprint in squares
            array<string> LabCorridorLabs = { "armalab", "armavp", "coralab", "coravp", "legalab", "legavp" };
            array<string> LabCorridorUnits = { "armfboy", "armbull", "corsumo", "corgol", "legamph", "legmed" };
            array<int> LabCorridorSquares = { 4, 4, 4, 4, 5, 4 };   // HBOT4, HTANK4, HBOT4, HTANK4, HABOT5, HTANK4
            array<int> LabCorridorClass = { 1, 0, 1, 0, 1, 0 };     // the route's lane class: 1 bots, 0 vehicles (Lanes::BOT, Lanes::LAND)
            int LabCorridorTilesPerFrame = 16;         // corridor reservations per frame over all labs (performance, owner 2026-10-30)
            float LabCorridorMaxRun = 1024.0f;         // the longest single rectangle on a straight axis run
            bool LabPorc = false;
            float LabPorcMinDistance = 900.0f;         // labs further than this from our start get guns
            array<int> LabPorcTier = { 1, 1, 2, 3 };   // build order: two pop-ups, the heavy plasma, then one T2 flak (owner 2026-10-30)
            float LabPorcPopupForward = 320.0f;        // pop-ups this far down the corridor from the lab
            float LabPorcPopupSide = 64.0f;            // ... this far outside the corridor's edge, one each side
            float LabPorcHeavyForward = 160.0f;
            float LabPorcHeavySide = 96.0f;
            float LabPorcShake = 128.0f;               // native looks this far round a slot for room
            float LabPorcRadius = 600.0f;              // our guns of those kinds this near a far lab count for it
            float LabPorcPopupMetalIncome = 15.0f;     // sustained (10 s minimum) metal income for a pop-up order
            float LabPorcHeavyMetalIncome = 30.0f;     // ... and for the heavy
            float LabPorcFlakMetalIncome = 30.0f;      // ... and for the T2 flak
            float LabPorcReach = 3000.0f;              // idle, guarding or assisting T2 constructors this near the lab are asked
            float LabPorcTakeRadius = 1200.0f;         // ... and ones walking to an unframed build this near
            int LabPorcScanSeconds = 5;
            // Forward agitators and special porc (owner, 2026-11-01; systems/construction/front_agitator.as).
            // Agitator: at our most forward mex or static land gun that stands AgitatorMapShare or more of the
            // map toward the enemy (along the ally-start -> enemy-start axis, map edge to map edge), when the
            // metal bank reached AgitatorMetalShare of storage in the last AgitatorMetalWindowSeconds, a FRONT
            // constructor builds the faction's T1 area-control plasma artillery there.
            // SpecialPorc: the T2 pop-up plasma artillery at the same spots, by T2 constructors, while the bank is
            // above SpecialPorcMetalShare, the 10 s minimum metal income above SpecialPorcMinMetalIncome and a T2 lab stands.
            // Both off here; experimental_balanced turns them on. Log [FRONT][Agitator], [FRONT][SpecialPorc].
            bool Agitator = false;
            array<string> AgitatorUnits = { "armguard", "corpun", "legcluster" };   // Gauntlet, Agitator, Amputator
            float AgitatorMetalShare = 0.8f;
            int AgitatorMetalWindowSeconds = 120;
            float AgitatorMapShare = 0.4f;
            float AgitatorAdvance = 500.0f;            // a further agitator waits for a spot this much further forward (elmos, lane axis)
            float AgitatorCoverRadius = 350.0f;        // a spot with one of ours this near is done
            int AgitatorMax = 6;                       // most standing at once
            float AgitatorReach = 3000.0f;             // idle, guarding or assisting constructors this near the spot are asked
            float AgitatorTakeRadius = 1500.0f;        // ... and ones walking to an unframed build this near
            float AgitatorShake = 160.0f;              // native looks this far round the spot for room
            int AgitatorScanSeconds = 5;
            bool AgitatorGroupConstructor = true;      // the commander group's T1 constructor builds them too (owner 2026-11-01)
            float AgitatorGroupReach = 2000.0f;        // ... at spots this near it
            bool SpecialPorc = false;
            array<string> SpecialPorcUnits = { "armamb", "cortoast", "legacluster" };   // Rattlesnake, Persecutor, Eviscerator
            float SpecialPorcMetalShare = 0.5f;
            float SpecialPorcMinMetalIncome = 100.0f;
            float SpecialPorcCoverRadius = 350.0f;
            int SpecialPorcMax = 6;
            // Hard AFUS admission floors, unlike native energy-table preferences.
            float MinimumMetalIncomeForAFUS = 70.0f;
            float MinimumEnergyIncomeForAFUS = 4000.0f;
        }
}
}
