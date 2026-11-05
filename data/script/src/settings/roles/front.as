// FRONT defaults. Namespaces and mutable values are API-compatible.
// Profile hooks/JSON loaders may override these; do not reapply defaults at runtime.
// Role entry: ../../roles/front/front.as
namespace Global {
namespace RoleSettings {
namespace Front {
            bool FactoryLayoutsEnabled = true;
            int FactorySupportRows = 4; // reserved growth, not an instruction to build all turrets
            float FactoryUtilityBlastMargin = 32.f;
            // D-459: the opening builder's walking budget when FRONT plans
            // its first district; later factories keep their district slot.
            float FactoryTravelSeconds = 3.0f;
            // D-461: with no factory standing after this many seconds, the
            // commander takes the queued start factory itself. 0 disables.
            float StartFactoryTakeoverSeconds = 60.0f;
            float FactoryProductionBudgetShare = 0.65f;
            // D-468, INV-252: a construction turret holding a repair order on a
            // target outside its reach this long is logged as a violation
            // (native releases it on the task's next update).
            float TurretRepairReachGraceSeconds = 5.0f;
            float FactoryT1BudgetShare = 0.6f;
            float BaseSupportRadius = 1000.0f; // first land constructor stays with home economy
            bool GeothermalEnabled = true;
            uint GeothermalBuilders = 2;
            float GeothermalRadius = 3200.0f;
            // FRONT funds a T1 vent over three minutes while reserving half
            // its conservative income for units and ordinary energy growth.
            float GeothermalBudgetSeconds = 180.0f;
            float GeothermalIncomeFraction = 0.5f;
            float GeothermalBootstrapEnergy = 120.0f;

            // D-463: the T1 energy seat. It first builds a free geothermal
            // vent within EnergySeatGeoRadius of the factory that produced it.
            // When the map's average wind ((min + max) / 2) is above
            // EnergySeatWindAverage it builds wind turbines in dense blocks,
            // else native's energy choice. While energy income (lowest of the
            // last 10 s) is above EnergySeatReleaseIncome it does default work.
            // D-466: before any energy, the seat builds every unbuilt mex this
            // AI owns within EnergySeatMexRadius of its start (native
            // ownership and allied-territory rules, 3D reach).
            float EnergySeatMexRadius = 1000.0f;
            // A base mex order that ends without a mex (the same spot offered
            // again) skips that spot EnergySeatMexRetrySeconds x failures;
            // after EnergySeatMexAttempts failures the seat skips it for good.
            float EnergySeatMexRetrySeconds = 60.0f;
            int EnergySeatMexAttempts = 3;
            float EnergySeatGeoRadius = 900.0f;
            // A geothermal order that ends without a geothermal (re-offered at
            // the same vent) backs off EnergySeatGeoRetrySeconds x failures;
            // after EnergySeatGeoAttempts failures the seat stops trying.
            float EnergySeatGeoRetrySeconds = 60.0f;
            int EnergySeatGeoAttempts = 3;
            // An own geothermal order not started (no frame) within this many
            // seconds is aborted and counted as a failure.
            float EnergySeatGeoOrderSeconds = 90.0f;
            float EnergySeatWindAverage = 7.0f;
            float EnergySeatReleaseIncome = 2000.0f;
            // D-463: the fifth T1 constructor builds T1 energy converters in
            // dense blocks (not on metal maps or with converters disabled)
            // until metal income (lowest of the last 10 s) first exceeds
            // ConverterSeatReleaseMetalIncome, then does default work for
            // good. A converter is ordered only with energy storage at least
            // ConverterSeatEnergyFill full and no stall; else it assists the
            // energy seat.
            bool ConverterSeatEnabled = true;
            float ConverterSeatReleaseMetalIncome = 60.0f;
            float ConverterSeatEnergyFill = 0.5f;
            // D-463 dense blocks: columns x rows touching footprints (no gap),
            // searched on a lattice behind the start position within
            // BaseSupportRadius. A block is kept when EcoBlockMinimumFill of
            // its slots reserve; a failed search retries after
            // EcoBlockRetrySeconds.
            int WindBlockColumns = 4;
            int WindBlockRows = 3;
            int ConverterBlockColumns = 4;
            int ConverterBlockRows = 3;
            float EcoBlockRearOffset = 192.0f;
            int EcoBlockSearchRings = 3;
            float EcoBlockMinimumFill = 0.75f;
            float EcoBlockRetrySeconds = 20.0f;
            float EcoBlockOrderSeconds = 120.0f;

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
            int TimeTriggerForT2EcoGatingSeconds = 20 * 60; // 20 minutes

            // Combat settings
            int DefaultT1CombatFireState = 3;

            // Start Caps
            int StartCapRezBots = 10;
            int StartCapT1AircraftPlants = 0;
            int StartCapNukeSilos = 0;

            // Dynamic Quota Settings
            float DynamicQuotaEnemyCostAttackThresholdMultiplier = 1.0f;
            float DynamicQuotaEnemyCostWithdrawThresholdMultiplier = 0.8f;
            float UnderpoweredAttackQuota = 100.0f;
            float UnderpoweredRaidMinQuota = 100.0f;
            float UnderpoweredRaidAvgQuota = 200.0f;
            int DynamicQuotaDelaySeconds = 2 * 60;

            // Economy Scaling Limits
            float MetalIncomePerLab = 35.0f;
            float MetalIncomeForGantry = 250.0f;
            float MetalIncomePerT1Builder = 20.0f;
            int MinBuilderCap = 5;
            float MetalIncomePerT2Builder = 40.0f;

            // Misc Logic Settings
            int RaiderOpenerCount = 10;
            // Opt-in profile policy: retain the first scout, then choose tanks.
            float VehicleTankOpenerChance = 0.0f;
            // D-471: Cortex vehicle labs keep the Rascal scout, then open with
            // the RaiderOpenerCount batch as Incisors (corgator), not Rascals.
            float VehicleTankOpenerChanceCortex = 1.0f;
            int VehicleTankGatherSeconds = 300; // release a disrupted/incomplete batch
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
            // Hard AFUS admission floors, unlike native energy-table preferences.
            float MinimumMetalIncomeForAFUS = 70.0f;
            float MinimumEnergyIncomeForAFUS = 4000.0f;
        }
}
}
