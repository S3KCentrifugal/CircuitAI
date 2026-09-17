// role: TECH
#include "../global.as"
#include "../helpers/role_limit_helpers.as"
#include "../helpers/unit_helpers.as"
#include "../helpers/unitdef_helpers.as"
#include "../types/role_config.as"
#include "../types/terrain.as"

// Guard assignment helper utilities
#include "../helpers/guard_helpers.as"
// Economy decision helpers (converter logic, nano counts, etc.)
#include "../helpers/economy_helpers.as"
// Collection/dictionary helpers
#include "../helpers/collection_helpers.as"
#include "../helpers/objective_helpers.as"
// Builder state and helpers
#include "../helpers/map_helpers.as"
#include "../manager/builder.as"
#include "../manager/team.as"

namespace RoleTech
{
	// One-time flag to apply economy-threshold behaviors only once when threshold is reached
	bool hasAppliedT1EcoThreshold = false;
	bool hasAppliedT1VehicleEcoThreshold = false;
	// One-way gate to unlock advanced storages when economy is ready
	bool hasUnlockedAdvancedStorage = false;
	// One-way gate: have the T2 rush bots had their engine cap restored?
	bool hasUncappedRushBots = false;
	// One-way gate: after first T2 bot lab, allow one T1 metal storage (raise cap to 1)
	bool hasRaisedT1MetalStorageCap = false;
	// One-way gate: has the nuke silo targeted the farthest tech spot?
	bool hasTargetedFarthestTech = false;
	// Global fast-assist cap for TECH role (computed from income in Tech_IncomeBuilderLimits)
	int g_fastAssistBotCap = 0;

	// Engine-supplied maxthisunit for the T2 rush bots - Sprinter (armfast),
	// Fiend (corpyro), Hoplite (legstr) - snapshotted before Tech_ApplyStartLimits
	// zeroes the combat lists, so the rush can restore the real value instead of an
	// invented one. The engine value is MAX_UNITS clamped by any game-level unit
	// restriction (Recoil UnitDef.cpp: maxThisUnit / unitRestricted), which a
	// hardcoded cap would silently ignore.
	dictionary g_rushBotEngineCaps;

	/******************************************************************************

	INITIALIZATION

	******************************************************************************/
	void Tech_Init()
	{

		// Apply TECH role settings
		aiTerrainMgr.SetAllyZoneRange(Global::RoleSettings::Tech::AllyRange);
		// Change scout cap (unit count)
		aiMilitaryMgr.quota.scout = Global::RoleSettings::Tech::MilitaryScoutCap;

		// Change attack gate (power threshold, not a headcount)
		aiMilitaryMgr.quota.attack = Global::RoleSettings::Tech::MilitaryAttackThreshold;

		// Change raid thresholds (power)
		aiMilitaryMgr.quota.raid.min = Global::RoleSettings::Tech::MilitaryRaidMinPower;
		aiMilitaryMgr.quota.raid.avg = Global::RoleSettings::Tech::MilitaryRaidAvgPower;

		GenericHelpers::LogUtil("[Tech][Quota] scout=" + aiMilitaryMgr.quota.scout +
									" attack=" + aiMilitaryMgr.quota.attack +
									" raid.min=" + aiMilitaryMgr.quota.raid.min +
									" raid.avg=" + aiMilitaryMgr.quota.raid.avg,
								3);

		Tech_ApplyStartLimits();
		Tech_ApplyAttributes();

		// Log all strategic objectives with distance from start
		ObjectiveHelpers::LogAllObjectivesFromStart(AiRole::TECH, "TECH");
	}

	// Restore the engine's own maxthisunit for Sprinter/Fiend/Hoplite. Called when the
	// T2 rush is active so the rush bots are never the limiting factor; falls back to
	// leaving the def alone if no snapshot exists.
	void Tech_UncapRushBots(const string &in reason)
	{
		array<string> rushBots = UnitHelpers::GetAllFastT2Bots();
		for (uint i = 0; i < rushBots.length(); ++i)
		{
			CCircuitDef @rd = ai.GetCircuitDef(rushBots[i]);
			if (rd is null)
				continue;

			int engineCap = 0;
			if (!g_rushBotEngineCaps.get(rushBots[i], engineCap))
			{
				GenericHelpers::LogUtil("[TECH][Limits] No engine cap snapshot for rush bot '"
					+ rushBots[i] + "'; leaving cap at " + rd.maxThisUnit, 2);
				continue;
			}
			if (rd.maxThisUnit != engineCap)
			{
				rd.maxThisUnit = engineCap;
				GenericHelpers::LogUtil("[TECH][Limits] Rush bot '" + rushBots[i]
					+ "' uncapped to engine limit " + engineCap + " (" + reason + ")", 2);
			}
		}
	}

	void Tech_ApplyStartLimits()
	{
		GenericHelpers::LogUtil("[TECH] Enter Tech_ApplyStartLimits", 4);

		// ****************** COMBAT UNIT LIMITS ****************** //
		// Don't let tech player build anything except t3. Or logically enable T1/T2 later if desired
		//
		// Snapshot the rush bots first. armfast is currently filed under
		// GetArmadaT1CombatUnits() while corpyro/legstr are in the T2 lists, so both
		// blanket caps below can zero them; capturing by name covers either list.
		{
			array<string> rushBots = UnitHelpers::GetAllFastT2Bots();
			for (uint i = 0; i < rushBots.length(); ++i)
			{
				CCircuitDef @rd = ai.GetCircuitDef(rushBots[i]);
				if (rd !is null)
					g_rushBotEngineCaps.set(rushBots[i], rd.maxThisUnit);
			}
		}

		UnitHelpers::BatchApplyUnitCaps(UnitHelpers::GetAllT1CombatUnits(), Global::RoleSettings::Tech::StartCapT1CombatUnits);
		UnitHelpers::BatchApplyUnitCaps(UnitHelpers::GetAllT2CombatUnits(), Global::RoleSettings::Tech::StartCapT2CombatUnits);

		// T2_RUSH is decided in Main::AiMain by ApplyTechStrategyWeights, which runs
		// before ApplyProfileSettings reaches Tech_Init, so the strategy is known here.
		// When the rush is on, the three rush bots must not stay capped: they are what
		// the additional T2 bot labs exist to produce, alongside T3 from the gantry.
		// The primary T2 lab still makes fast-assist bots - that branch is ordered
		// ahead of the combat batch in Tech_FactoryAiMakeTask.
		//
		// The cap is NOT lifted here. Releasing it at start makes the bots buildable
		// from frame 0, and the script's own income gate does not protect against that:
		// it only guards the batch in Tech_FactoryAiMakeTask. Native production
		// (DefaultMakeTask -> CreateFactoryTask -> UpdateFirePower -> RequiredFireDef)
		// selects purely on availability and has no income threshold, so an uncapped
		// rush bot is produced as soon as any T2 bot lab exists - and the first lab is
		// allowed at MinimumMetalIncomeForT2Lab (18), far below the rush gate. That
		// stalls the economy. Tech_EconomyUpdate lifts the cap at the same income the
		// batch uses, so cap release and production gate unlock together.
		hasUncappedRushBots = false;

		// ****************** REZBOT LIMITS ****************** //
		UnitHelpers::BatchApplyUnitCaps(UnitHelpers::GetAllRezBots(), Global::RoleSettings::Tech::StartCapRezBots);

		// ****************** FAST ASSIST LIMITS ****************** //
		UnitHelpers::BatchApplyUnitCaps(UnitHelpers::GetAllFastAssistBots(), Global::RoleSettings::Tech::StartCapFastAssistBots);

		// ****************** LAB LIMITS ****************** //
		UnitHelpers::BatchApplyUnitCaps(UnitHelpers::GetAllT1BotLabs(), Global::RoleSettings::Tech::StartCapT1BotLabs);
		UnitHelpers::BatchApplyUnitCaps(UnitHelpers::GetAllT2BotLabs(), Global::RoleSettings::Tech::StartCapT2BotLabs);

		UnitHelpers::BatchApplyUnitCaps(UnitHelpers::GetAllT1VehicleLabs(), Global::RoleSettings::Tech::StartCapT1VehiclePlants);
		// TECH role must not build T2 Vehicle Plants
		UnitHelpers::BatchApplyUnitCaps(UnitHelpers::GetAllT2VehicleLabs(), 0);

		// TECH role must not build any hover plants
		UnitHelpers::BatchApplyUnitCaps(UnitHelpers::GetAllT1HoverPlants(), 0);
		UnitHelpers::BatchApplyUnitCaps(UnitHelpers::GetAllFloatingHoverPlants(), 0);

		// ****************** Aircraft Plant LIMITS ****************** //
		UnitHelpers::BatchApplyUnitCaps(UnitHelpers::GetAllT1AircraftPlants(), Global::RoleSettings::Tech::StartCapT1AircraftPlants);
		UnitHelpers::BatchApplyUnitCaps(UnitHelpers::GetAllT2AircraftPlants(), Global::RoleSettings::Tech::StartCapT2AircraftPlants);

		// ****************** Shipyard LIMITS ****************** //
		UnitHelpers::BatchApplyUnitCaps(UnitHelpers::GetAllT1Shipyards(), Global::RoleSettings::Tech::StartCapT1Shipyards);
		UnitHelpers::BatchApplyUnitCaps(UnitHelpers::GetAllT2Shipyards(), Global::RoleSettings::Tech::StartCapT2Shipyards);

		// ****************** ENERGY LIMITS ****************** //
		// Don't over produce t1 solars. At the moment reclaiming energy buildings is not possible

		UnitHelpers::BatchApplyUnitCaps(UnitHelpers::GetAllT1Solar(), Global::RoleSettings::Tech::StartCapT1Solar);
		UnitHelpers::BatchApplyUnitCaps(UnitHelpers::GetAllT2Solar(), Global::RoleSettings::Tech::MaxAdvancedSolars);
		UnitHelpers::BatchApplyUnitCaps(UnitHelpers::GetAllFusionReactors(), Global::RoleSettings::Tech::StartCapFusionReactors);
		UnitHelpers::BatchApplyUnitCaps(UnitHelpers::GetAllAdvancedFusionReactors(), Global::RoleSettings::Tech::StartCapAdvancedFusionReactors);

		// ****************** STATIC LAND DEFENCE LIMITS ****************** //
		// TECH must not build anti-ground land defenses (AA and LRPC remain allowed)
		UnitHelpers::BatchApplyUnitCaps(UnitHelpers::GetAllLandDefences(), 0);

		// ****************** SUPER WEAPON LIMITS ****************** //
		// Apply a unified cap across all nuke silos
		UnitHelpers::BatchApplyUnitCaps(UnitHelpers::GetAllNukeSilos(), Global::RoleSettings::Tech::NukeLimit);

		// ****************** T1 METAL STORAGE LIMITS ****************** //
		// Per request: start with standard T1 metal storages disabled (cap=0).
		// Do NOT change T1 energy storage limits here.
		{
			array<string> t1Metal = UnitHelpers::GetAllT1MetalStorages();
			UnitHelpers::BatchApplyUnitCaps(t1Metal, 0);
			GenericHelpers::LogUtil("[TECH][Limits] T1 metal storage init cap set to 0", 3);
			hasRaisedT1MetalStorageCap = false; // ensure locked at start
		}

		// ****************** ADVANCED STORAGE LIMITS ****************** //
		// Per request: start with advanced metal/energy storages disabled (cap=0).
		// Do NOT change T1 storages.
		{
			array<string> advE = UnitHelpers::GetAllAdvancedEnergyStorages();
			array<string> advM = UnitHelpers::GetAllAdvancedMetalStorages();
			UnitHelpers::BatchApplyUnitCaps(advE, 0);
			UnitHelpers::BatchApplyUnitCaps(advM, 0);
			GenericHelpers::LogUtil("[TECH][Limits] Advanced storages init caps set: energy=0, metal=0", 3);
			hasUnlockedAdvancedStorage = false; // ensure locked at start
		}

		// Ignore all T1 combat units for TECH role
		array<string> t1Units = UnitHelpers::GetAllT1CombatUnits();
		UnitDefHelpers::SetIgnoreFor(t1Units, true);

		// Tag only T1/T2 land + air labs as 'support' for TECH role (keep factories conservative by default)
		// Excludes: T3 gantries and shipyards/sea labs.
		{
			array<string> supportLabs = UnitHelpers::GetAllT1T2LandLabsAndAircraftPlants();
			UnitDefHelpers::SetMainRoleFor(supportLabs, "support");
			GenericHelpers::LogUtil("[TECH][Labs] Set mainRole=support for T1/T2 bot, vehicle, and air plants only (excluding gantries/shipyards)", 3);
		}

		// For TECH, set max caps for non-construction aircraft using global settings
		array<string> t1AirCombat = UnitHelpers::GetAllT1AircraftCombatUnits();
		UnitHelpers::BatchApplyUnitCaps(t1AirCombat, Global::RoleSettings::Tech::StartCapT1AirCombatUnits);
		array<string> t2AirCombat = UnitHelpers::GetAllT2AircraftCombatUnits();
		UnitHelpers::BatchApplyUnitCaps(t2AirCombat, Global::RoleSettings::Tech::StartCapT2AirCombatUnits);

		GenericHelpers::LogUtil("Tech start limits applied", 3);

		// Re-apply merged map+role unit limits so map constraints always win over role caps
		if (Global::Map::MergedUnitLimits.getKeys().length() > 0)
		{
			GenericHelpers::LogUtil("[TECH][Limits] Applying merged map+role unit limits (start)", 3);
			UnitHelpers::ApplyUnitLimits(Global::Map::MergedUnitLimits);

			// Print out all unit limits from the merged dictionary for visibility
			array<string> @_mk = Global::Map::MergedUnitLimits.getKeys();
			for (uint i = 0; i < _mk.length(); ++i)
			{
				const string uname = _mk[i];
				int cap = 0;
				if (Global::Map::MergedUnitLimits.get(uname, cap))
				{
					GenericHelpers::LogUtil("[TECH][Limits] merged unit cap: " + uname + " = " + cap, 3);
				}
			}
		}
		else
		{
			GenericHelpers::LogUtil("[TECH][Limits] No merged unit limits found to apply at start", 3);
		}
	}

	void Tech_ApplyAttributes()
	{
		GenericHelpers::LogUtil("[TECH] Enter Tech_ApplyAttributes", 4);

		// Add VAMPIRE attribute to T1/T2 bot constructors, fast assist bots, and construction turrets
		// This ensures they stay near the base or are treated as base defenders/builders
		// Note: BASE attribute is dynamic (per unit), VAMPIRE is static (per def)

		// Apply per-unitdef attributes via UnitDefHelpers using attribute name string
		UnitDefHelpers::AddAttrFor(UnitHelpers::GetAllT1BotConstructors(), "vampire");
		UnitDefHelpers::AddAttrFor(UnitHelpers::GetAllT2BotConstructors(), "vampire");
		UnitDefHelpers::AddAttrFor(UnitHelpers::GetAllFastAssistBots(), "vampire");
		UnitDefHelpers::AddAttrFor(UnitHelpers::GetT1NanoUnitNames(), "vampire");

		GenericHelpers::LogUtil("[TECH] Applied VAMPIRE attribute to T1/T2 bot constructors, fast assist bots, and all T1 nanos", 3);
	}

	/******************************************************************************

	MAIN HOOKS

	******************************************************************************/

	void Tech_MainUpdate()
	{
		GenericHelpers::LogUtil("[TECH] Enter Tech_MainUpdate", 4);
	}

	/******************************************************************************

	ECONOMY HOOKS

	******************************************************************************/

	void Tech_EconomyUpdate()
	{
		GenericHelpers::LogUtil("[TECH] Enter Tech_EconomyUpdate", 4);
		// float metalIncome = Global::Economy::GetMetalIncome();
		float metalIncome = Economy::GetMinMetalIncomeLast10s();

		int t2ConstructionBotCount = UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllT2BotConstructors());
		int t1ConstructionBotCount = UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllT1BotConstructors());

		bool hasT2Lab = (@Factory::primaryT2BotLab !is null);
		bool hasT1Lab = (@Factory::primaryT1BotLab !is null);

		float energyIncome = aiEconomyMgr.energy.income;
		float metalCurrent = aiEconomyMgr.metal.current;

		// Ensure factory assist is required when we have a T2 lab but no T2 constructors yet
		// This helps bootstrap the first T2 constructor quickly
		if (hasT2Lab && t2ConstructionBotCount < 1)
		{
			aiFactoryMgr.isAssistRequired = true;
			GenericHelpers::LogUtil("[TECH][Assist] Forcing factory assist: T2 lab present, T2 constructors=0", 3);
		}

		Tech_IncomeBuilderLimits(metalIncome);

		// --- Unlock advanced storages when economy is strong enough ---
		if (!hasUnlockedAdvancedStorage && metalIncome >= 100.0f)
		{
			array<string> advE = UnitHelpers::GetAllAdvancedEnergyStorages();
			array<string> advM = UnitHelpers::GetAllAdvancedMetalStorages();
			UnitHelpers::BatchApplyUnitCaps(advE, 1);
			UnitHelpers::BatchApplyUnitCaps(advM, 1);
			hasUnlockedAdvancedStorage = true;
			GenericHelpers::LogUtil("[TECH][Limits] Advanced storages unlocked at mi>=100: energy=1, metal=1", 2);
			// Ensure merged map+role limits are reapplied so map constraints win
			if (Global::Map::MergedUnitLimits.getKeys().length() > 0)
			{
				GenericHelpers::LogUtil("[TECH][Limits] Re-applying merged map+role unit limits after storage unlock", 4);
				UnitHelpers::ApplyUnitLimits(Global::Map::MergedUnitLimits);
			}
		}

		// --- Dynamic Gantry cap: compute allowed from incomes; if >1, raise cap and clear 'support' by setting to TECH ---
		{
			int allowedGantry = EconomyHelpers::AllowedGantryCountFromIncome(
				/*mi*/ metalIncome,
				/*ei*/ energyIncome,
				/*metalIncomePerGantry*/ Global::RoleSettings::Tech::MetalIncomePerGantry,
				/*energyIncomePerGantry*/ Global::RoleSettings::Tech::EnergyIncomePerGantry);
			GenericHelpers::LogUtil(
				"[TECH][Gantry] Allowed from income: " + allowedGantry +
					" (miPer=" + Global::RoleSettings::Tech::MetalIncomePerGantry +
					", eiPer=" + Global::RoleSettings::Tech::EnergyIncomePerGantry + ")",
				3);

			// Start building gantries on front line, get rid of support role
			if (allowedGantry > 1)
			{
				// Apply caps for gantries so we can build more than one when economy permits
				array<string> landGantries = UnitHelpers::GetAllLandGantries();
				array<string> waterGantries = UnitHelpers::GetAllWaterGantries();
				UnitHelpers::BatchApplyUnitCaps(landGantries, allowedGantry);
				UnitHelpers::BatchApplyUnitCaps(waterGantries, allowedGantry);
			}
		}

		// --- Dynamic T2 Bot Lab cap ---
		// The primary T2 bot lab is reserved for fast-assist production, so the T2 combat
		// rush depends on additional labs existing. Tech_ApplyStartLimits pins maxThisUnit to
		// StartCapT2BotLabs (1) and nothing raised it again, unlike T1 bot labs below, so a
		// second lab was impossible: CCircuitDef::IsAvailable() is maxThisUnit > count, and
		// Builder::EnqueueT2BotLabIfNeeded bails on that check.
		{
			int allowedT2Labs = EconomyHelpers::AllowedT2BotLabCountFromIncome(
				/*mi*/ metalIncome,
				/*ei*/ energyIncome,
				/*metalIncomePerLab*/ Global::RoleSettings::Tech::MetalIncomePerT2Lab,
				/*energyIncomePerLab*/ Global::RoleSettings::Tech::EnergyIncomePerT2Lab);
			if (allowedT2Labs < 1)
				allowedT2Labs = 1;
			if (allowedT2Labs > Global::RoleSettings::Tech::MaxT2BotLabs)
				allowedT2Labs = Global::RoleSettings::Tech::MaxT2BotLabs;

			UnitHelpers::BatchApplyUnitCaps(UnitHelpers::GetAllT2BotLabs(), allowedT2Labs);

			// Release the rush bots' engine cap once income reaches the same gate the T2
			// combat batch uses in Tech_FactoryAiMakeTask (botLabGate). Doing it earlier
			// lets native production build them from the first T2 lab at ~18 income and
			// stall the economy; doing it here keeps cap release and production gate in
			// step. One-way: once unlocked it stays unlocked, so a dip in income does not
			// re-cap mid-rush.
			//
			// Also re-asserted on later passes because Tech_IncomeBuilderLimits and the
			// storage-unlock branch both re-apply Global::Map::MergedUnitLimits, which can
			// re-cap these defs; this runs after those and is a no-op when already correct.
			if (Global::RoleSettings::Tech::HasStrategy(Strategy::T2_RUSH))
			{
				const float rushGate = Global::RoleSettings::Tech::MetalIncomeThresholdForEarlyBotLabExpansion;
				if (!hasUncappedRushBots && metalIncome >= rushGate)
				{
					hasUncappedRushBots = true;
					Tech_UncapRushBots("metalIncome " + metalIncome + " >= rush gate " + rushGate);
				}
				else if (hasUncappedRushBots)
				{
					Tech_UncapRushBots("re-assert after limit re-apply, allowed=" + allowedT2Labs);
				}
			}
			GenericHelpers::LogUtil(
				"[TECH][Labs] T2 bot lab cap=" + allowedT2Labs +
					" (mi=" + metalIncome + "/" + Global::RoleSettings::Tech::MetalIncomePerT2Lab +
					" ei=" + energyIncome + "/" + Global::RoleSettings::Tech::EnergyIncomePerT2Lab +
					" max=" + Global::RoleSettings::Tech::MaxT2BotLabs + ")",
				3);
		}

		// --- Dynamic T1 Bot Lab caps and land factory placement after eco threshold ---
		if (!hasAppliedT1EcoThreshold && metalIncome >= Global::RoleSettings::Tech::MetalIncomeThresholdForBotLabExpansion)
		{
			// Allow up to 5 T1 bot labs across all sides when economy is strong
			UnitHelpers::BatchApplyUnitCaps(UnitHelpers::GetAllT1BotLabs(), 3);

			// After threshold, remove 'support' behavior from land factories so they can be built outside base
			array<string> landLabs = UnitHelpers::GetAllLandLabs();
			UnitDefHelpers::SetMainRoleFor(landLabs, "static");
			GenericHelpers::LogUtil("[TECH][Labs] Eco>=threshold: cap T1 bot labs to 5 and set land factories mainRole=static", 3);

			// Ensure high caps for T1 bot scouts (ticks and equivalents)
			// armada: armflea (Tick), cortex: corak (raider), legion: leggob (light skirm)
			{
				array<string> t1BotScouts = UnitHelpers::GetAllT1BotScouts();
				UnitHelpers::BatchApplyUnitCaps(t1BotScouts, 100);
			}

			// // Ensure high caps for fast T2 bots per side (canonical unit IDs)
			// // armada: armfast (Sprinter), cortex: corpyro (Fiend), legion: legstr (Hoplite)
			// {
			//     array<string> fastT2Bots = UnitHelpers::GetAllFastT2Bots();
			//     UnitHelpers::BatchApplyUnitCaps(fastT2Bots, 100);
			// }

			Global::RoleSettings::Tech::MaxT1Builders = 25;

			Global::RoleSettings::Tech::MaxT2BotLabs = 3;
			// Mark threshold actions applied so this block does not run again
			hasAppliedT1EcoThreshold = true;
		}

		// --- Dynamic T1 Vehicle Plant caps and land factory placement after eco threshold ---
		if (!hasAppliedT1VehicleEcoThreshold && metalIncome >= Global::RoleSettings::Tech::MetalIncomeThresholdForVehiclePlantExpansion)
		{
			// Allow up to 3 T1 vehicle plants across all sides when economy is strong
			UnitHelpers::BatchApplyUnitCaps(UnitHelpers::GetAllT1VehicleLabs(), 3);

			// After threshold, remove 'support' behavior from land factories so they can be built outside base
			// (This is redundant if bot lab expansion already ran, but safe to repeat or ensure)
			array<string> landLabs = UnitHelpers::GetAllLandLabs();
			UnitDefHelpers::SetMainRoleFor(landLabs, "static");
			GenericHelpers::LogUtil("[TECH][Labs] Eco>=threshold: cap T1 vehicle plants to 3 and set land factories mainRole=static", 3);

			// Ensure high caps for T1 vehicle scouts
			{
				array<string> t1VehScouts = UnitHelpers::GetAllT1VehicleScouts();
				UnitHelpers::BatchApplyUnitCaps(t1VehScouts, 100);
			}

			Global::RoleSettings::Tech::MaxT1Builders = 25;

			// Mark threshold actions applied so this block does not run again
			hasAppliedT1VehicleEcoThreshold = true;
		}

		// --- Dynamic Aircraft Plant caps: compute allowed T1/T2 from incomes and apply to all sides ---
		{
			// int allowedT1Air = EconomyHelpers::AllowedT1AircraftPlantCountFromIncome(
			//     /*mi*/ metalIncome,
			//     /*ei*/ energyIncome,
			//     /*metalIncomePerPlant*/ Global::RoleSettings::Tech::RequiredMetalIncomeForAirPlant,
			//     /*energyIncomePerPlant*/ Global::RoleSettings::Tech::RequiredEnergyIncomeForAirPlant
			// );
			int allowedT1Air = 0;
			int allowedT2Air = EconomyHelpers::AllowedT2AircraftPlantCountFromIncome(
				/*mi*/ metalIncome,
				/*ei*/ energyIncome,
				/*metalIncomePerPlant*/ Global::RoleSettings::Tech::RequiredMetalIncomeForT2AircraftPlant,
				/*energyIncomePerPlant*/ Global::RoleSettings::Tech::RequiredEnergyIncomeForT2AircraftPlant);

			if (allowedT2Air > 0)
			{
				allowedT1Air = 1; // We don't really need more than 1 t1 lab
			}

			GenericHelpers::LogUtil(
				"[TECH][AirPlants] Allowed T1/T2 from income: " + allowedT1Air + "/" + allowedT2Air +
					" (t1 miPer=" + Global::RoleSettings::Tech::RequiredMetalIncomeForAirPlant +
					", eiPer=" + Global::RoleSettings::Tech::RequiredEnergyIncomeForAirPlant +
					"; t2 miPer=" + Global::RoleSettings::Tech::RequiredMetalIncomeForT2AircraftPlant +
					", eiPer=" + Global::RoleSettings::Tech::RequiredEnergyIncomeForT2AircraftPlant + ")",
				3);

			array<string> t1AirPlants = UnitHelpers::GetAllT1AircraftPlants();
			array<string> t2AirPlants = UnitHelpers::GetAllT2AircraftPlants();
			UnitHelpers::BatchApplyUnitCaps(t1AirPlants, allowedT1Air);
			UnitHelpers::BatchApplyUnitCaps(t2AirPlants, allowedT2Air);
		}
	}

	/******************************************************************************

	FACTORY HOOKS

	******************************************************************************/

	// Helper to enqueue a batch of units if available
	IUnitTask @Tech_EnqueueUnitBatch(const string& in unitName, int count, const AIFloat3& in pos, Task::Priority priority = Task::Priority::NORMAL)
	{
		if (unitName.length() == 0)
			return null;
		CCircuitDef @def = ai.GetCircuitDef(unitName);
		if (def !is null && def.IsAvailable(ai.frame))
		{
			GenericHelpers::LogUtil("[TECH][Factory] EnqueueUnitBatch: " + count + "x '" + unitName + "'", 3);
			IUnitTask @last = null;
			for (int i = 0; i < count; ++i)
			{
				@last = aiFactoryMgr.Enqueue(TaskS::Recruit(Task::RecruitType::FIREPOWER, priority, def, pos, 64.f));
			}
			return last;
		}
		return null;
	}

	IUnitTask @Tech_FactoryAiMakeTask(CCircuitUnit @u)
	{
		// Ensure we always fall back to default factory task unless we can recruit constructors
		// based on global minimum thresholds.
		const CCircuitDef @facDef = (u is null ? null : u.circuitDef);
		if (facDef is null)
		{
			return aiFactoryMgr.DefaultMakeTask(u);
		}

		// Determine side from factory unit name
		string side = UnitHelpers::GetSideForUnitName(facDef.GetName());
		const AIFloat3 pos = u.GetPos(ai.frame);
		float metalIncome = Economy::GetMinMetalIncomeLast10s();
		GenericHelpers::LogUtil("[TECH][Factory] MakeTask called for factory '" + facDef.GetName() + "' (side=" + side + ")", 4);
		// Debug: log current primary factory ids vs this unit
		{
			int uid = u.id;
			int pT1Bot = (Factory::primaryT1BotLab is null ? -1 : Factory::primaryT1BotLab.id);
			int pT2Bot = (Factory::primaryT2BotLab is null ? -1 : Factory::primaryT2BotLab.id);
			int pT1Air = (Factory::primaryT1AirPlant is null ? -1 : Factory::primaryT1AirPlant.id);
			int pT2Air = (Factory::primaryT2AirPlant is null ? -1 : Factory::primaryT2AirPlant.id);
			GenericHelpers::LogUtil("[TECH][Factory] ids: u=" + uid + " pT1Bot=" + pT1Bot + " pT2Bot=" + pT2Bot + " pT1Air=" + pT1Air + " pT2Air=" + pT2Air, 4);
		}
		// Select income gate based on strategy: use rush threshold when T2_RUSH is enabled
		const bool isEarlyBotLabExpansionEnabled = Global::RoleSettings::Tech::HasStrategy(Strategy::T2_RUSH);
		const float botLabGate = isEarlyBotLabExpansionEnabled ? Global::RoleSettings::Tech::MetalIncomeThresholdForEarlyBotLabExpansion : Global::RoleSettings::Tech::MetalIncomeThresholdForBotLabExpansion;

		const float vehiclePlantGate = isEarlyBotLabExpansionEnabled ? Global::RoleSettings::Tech::MetalIncomeThresholdForEarlyVehiclePlantExpansion : Global::RoleSettings::Tech::MetalIncomeThresholdForVehiclePlantExpansion;

		GenericHelpers::LogUtil("[TECH][Factory] Strategy gate: EarlyBotLabExpansion=" + (isEarlyBotLabExpansionEnabled ? "on" : "off") + " botLabGate=" + botLabGate + " vehiclePlantGate=" + vehiclePlantGate, 4);

		// Diagnostic: if this is a gantry, explicitly log that we delegate to default
		// (no custom gantry build queue here by design)
		if (UnitHelpers::IsGantryLab(facDef.GetName()))
		{
			GenericHelpers::LogUtil("[TECH][Factory] Gantry detected ('" + facDef.GetName() + "')", 3);
			// If economy is very strong, queue a batch of signature experimentals
			if (metalIncome > 200.0f)
			{
				IUnitTask @tSig = Factory::EnqueueGantrySignatureBatch(u, side, /*count*/ 5, Task::Priority::HIGH);
				if (tSig !is null)
					return tSig;
			}
			// Fallback: Let default choose heavy/super units to build
			return aiFactoryMgr.DefaultMakeTask(u);
		}

		// Check T1 constructor threshold
		if (UnitHelpers::IsT1BotLab(facDef.GetName()))
		{
			int t1CtorCount = UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllT1BotConstructors());
			if (t1CtorCount < Global::RoleSettings::Tech::MinimumT1ConstructorBots)
			{
				// Recruit only bot constructors from a bot lab
				array<string> t1BotCtors = UnitHelpers::GetT1BotConstructors(side);
				if (t1BotCtors.length() > 0)
				{
					CCircuitDef @t1Ctor = ai.GetCircuitDef(t1BotCtors[0]);
					if (t1Ctor !is null && t1Ctor.IsAvailable(ai.frame))
					{
						// Recruit a T1 constructor bot
						return aiFactoryMgr.Enqueue(
							TaskS::Recruit(Task::RecruitType::BUILDPOWER, Task::Priority::HIGH, t1Ctor, pos, 64.f));
					}
				}
			}
		}

		// Check T2 constructor threshold
		if (UnitHelpers::IsT2BotLab(facDef.GetName()))
		{
			int t2CtorCount = UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllT2BotConstructors());
			if (t2CtorCount < Global::RoleSettings::Tech::MinimumT2ConstructorBots)
			{
				// Recruit only bot constructors from a bot lab
				array<string> t2BotCtors = UnitHelpers::GetT2BotConstructors(side);
				if (t2BotCtors.length() > 0)
				{
					CCircuitDef @t2Ctor = ai.GetCircuitDef(t2BotCtors[0]);
					if (t2Ctor !is null && t2Ctor.IsAvailable(ai.frame))
					{
						// Recruit a T2 constructor bot
						return aiFactoryMgr.Enqueue(
							TaskS::Recruit(Task::RecruitType::BUILDPOWER, Task::Priority::HIGH, t2Ctor, pos, 64.f));
					}
				}
			}

			// If fast-assist bots are below their dynamic cap and we have high metal reserves, queue one.
			// Cap mirrors Tech_IncomeBuilderLimits: fastAssistBotCap = 5 * int(metalIncome / 45.0f)
			//
			// PRIMARY lab only. This branch returns, so without the guard it starves the T2
			// combat batch further down: g_fastAssistBotCap scales with income without bound,
			// so haveAssist never catches it and the rush never starts. Additional T2 bot labs,
			// unlocked by economy in Tech_EconomyUpdate, carry the rush instead. Mirrors the
			// primary-plant guard used for air constructor upkeep below.
			if (Factory::primaryT2BotLab !is null && u.id == Factory::primaryT2BotLab.id)
			{
				array<string> fastAssist = UnitHelpers::GetFastAssistBots(side);
				int haveAssist = UnitDefHelpers::SumUnitDefCounts(fastAssist);
				float metalCurrent = aiEconomyMgr.metal.current;
				GenericHelpers::LogUtil(
					"[TECH][Factory] Fast-assist check: have=" + haveAssist + " cap=" + g_fastAssistBotCap +
						" metalCurrent=" + metalCurrent + " side=" + side,
					4);
				if (fastAssist.length() == 0)
				{
					GenericHelpers::LogUtil("[TECH][Factory] No fast-assist unit defined for side=" + side + ", skipping", 4);
				}
				if (g_fastAssistBotCap <= 0)
				{
					GenericHelpers::LogUtil("[TECH][Factory] Fast-assist cap is 0 at current income, skipping", 4);
				}
				if (metalCurrent <= 2000.0f)
				{
					GenericHelpers::LogUtil("[TECH][Factory] Metal reserve below 2000, skipping fast-assist enqueue", 4);
				}
				if (fastAssist.length() > 0 && haveAssist < g_fastAssistBotCap && metalCurrent > 2000.0f)
				{
					string assistName = fastAssist[0];
					CCircuitDef @assistDef = ai.GetCircuitDef(assistName);
					bool avail = (assistDef !is null && assistDef.IsAvailable(ai.frame));
					if (avail)
					{
						GenericHelpers::LogUtil(
							"[TECH][Factory] Enqueue fast-assist bot '" + assistName + "' have=" + haveAssist +
								" cap=" + g_fastAssistBotCap + " metalCurrent=" + metalCurrent + " side=" + side +
								" pos=(" + pos.x + "," + pos.y + "," + pos.z + ")",
							3);
						return aiFactoryMgr.Enqueue(
							TaskS::Recruit(Task::RecruitType::BUILDPOWER, Task::Priority::HIGH, assistDef, pos, 64.f));
					}
					else
					{
						const string defName = (assistDef is null ? "null" : assistDef.GetName());
						string availDetail = "false";
						int maxUnits = -1;

						if (assistDef is null)
						{
							availDetail = "null_def";
						}
						else
						{
							maxUnits = assistDef.maxThisUnit;
							if (!assistDef.IsAvailable(ai.frame))
							{
								availDetail = "not_available";
							}
						}

						GenericHelpers::LogUtil(
							"[TECH][Factory][WARN] Fast-assist NOT enqueued: assistName='" + assistName + "' assistDef=" + defName +
								" available=" + availDetail +
								" maxUnits=" + maxUnits +
								" ai.frame=" + ai.frame +
								" fastAssistList.len=" + fastAssist.length() +
								" haveAssist=" + haveAssist +
								" cap=" + g_fastAssistBotCap +
								" metalCurrent=" + metalCurrent +
								" side=" + side +
								" pos=(" + pos.x + "," + pos.y + "," + pos.z + ")" +
								" primaryT2BotLab.id=" + (Factory::primaryT2BotLab is null ? -1 : Factory::primaryT2BotLab.id) +
								" primaryT1BotLab.id=" + (Factory::primaryT1BotLab is null ? -1 : Factory::primaryT1BotLab.id),
							2);
						// Fast-assist not available now; fall through to allow other factory logic to proceed
					}
				}
				else if (fastAssist.length() > 0 && haveAssist >= g_fastAssistBotCap)
				{
					GenericHelpers::LogUtil("[TECH][Factory] Fast-assist at/over cap (" + haveAssist + "/" + g_fastAssistBotCap + ")", 4);
				}
			}
		}

		// After bot lab logic: maintain air constructor counts from aircraft plants (T1/T2)
		// Only the PRIMARY T1/T2 aircraft plant should perform this maintenance (mirror bot lab checks)
		// If either tier's air constructor count is below 50, prioritize making construction aircraft
		{
			// Current counts per tier
			int t1AirCtorCount = UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllT1AirConstructors());
			// T2 air constructors list
			int t2AirCtorCount = UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllT2AirConstructors());

			const string facName = facDef.GetName();
			// If this factory is the PRIMARY T1 aircraft plant and we're under 50 T1 air constructors, build one
			if (Factory::primaryT1AirPlant !is null && u.id == Factory::primaryT1AirPlant.id && t1AirCtorCount < 100)
			{
				string ctorName = UnitHelpers::GetT1AirConstructorNameForSide(side);
				CCircuitDef @ctorDef = ai.GetCircuitDef(ctorName);
				if (ctorDef !is null && ctorDef.IsAvailable(ai.frame))
				{
					GenericHelpers::LogUtil("[TECH][Factory] T1 air ctor below target (" + t1AirCtorCount + "), enqueue '" + ctorName + "'", 3);
					return aiFactoryMgr.Enqueue(
						TaskS::Recruit(Task::RecruitType::BUILDPOWER, Task::Priority::HIGH, ctorDef, pos, 64.f));
				}
			}

			// If this factory is the PRIMARY T2 aircraft plant and we're under 50 T2 air constructors, build one
			if (Factory::primaryT2AirPlant !is null && u.id == Factory::primaryT2AirPlant.id && t2AirCtorCount < 100)
			{
				string ctorName2 = UnitHelpers::GetT2AirConstructorNameForSide(side);
				CCircuitDef @ctorDef2 = ai.GetCircuitDef(ctorName2);
				if (ctorDef2 !is null && ctorDef2.IsAvailable(ai.frame))
				{
					GenericHelpers::LogUtil("[TECH][Factory] T2 air ctor below target (" + t2AirCtorCount + "), enqueue '" + ctorName2 + "'", 3);
					return aiFactoryMgr.Enqueue(
						TaskS::Recruit(Task::RecruitType::BUILDPOWER, Task::Priority::HIGH, ctorDef2, pos, 64.f));
				}
			}
		}
		GenericHelpers::LogUtil("[TECH][Factory] Checking bot lab for scout/fast bot enqueue", 4);
		// float metalIncome = Global::Economy::GetMetalIncome();
		// After builder production priorities, if this is a T1 bot lab and eco is strong, enqueue a block of scouts
		if (UnitHelpers::IsT1BotLab(facDef.GetName()))
		{

			if (metalIncome >= botLabGate)
			{
				const bool landLocked = Global::Map::LandLocked;
				string unitName;

				if (landLocked)
				{
					// Use amphibious T1 AA bots for landlocked starts
					unitName = UnitHelpers::GetT1AntiAirBotForSide(side);
					GenericHelpers::LogUtil("[TECH][Factory] LandLocked start: using amphib AA bot '" + unitName + "' instead of ground scout", 3);
				}
				else
				{
					// Use normal T1 ground scouts
					unitName = UnitHelpers::GetT1BotScoutForSide(side);
				}

				GenericHelpers::LogUtil("[TECH][Factory] Eco>=gate: enqueue 10 '" + unitName + "' from T1 bot lab (gate=" + botLabGate + ")", 3);
				IUnitTask @last = Tech_EnqueueUnitBatch(unitName, 10, pos);
				if (last !is null)
					return last;
			}
		}

		// After builder production priorities, if this is a T2 bot lab and eco is strong, enqueue a block of units.
		// If the current start point is land-locked by water (Global::Map::LandLocked == true), prefer amphibious T2 units
		// instead of ground-only fast T2 bots, since ground T2 is less effective on water-heavy maps.
		if (UnitHelpers::IsT2BotLab(facDef.GetName()))
		{
			GenericHelpers::LogUtil("[TECH][Factory] Checking T2 bot lab for fast T2 bot/amphib enqueue", 4);
			if (metalIncome >= botLabGate)
			{
				const bool landLocked = Global::Map::LandLocked;
				string unitName;
				if (landLocked)
				{
					// Amphibious choices per side
					unitName = UnitHelpers::GetAmphibiousT2BotForSide(side);
					GenericHelpers::LogUtil("[TECH][Factory] LandLocked start: using amphib unit '" + unitName + "' instead of ground fast T2", 3);
				}
				else
				{
					// Use canonical ground fast T2 bots consistent with caps and units.json
					array<string> fastBots = UnitHelpers::GetFastT2Bots(side);
					if (fastBots.length() > 0)
					{
						unitName = fastBots[0];
					}
				}

				GenericHelpers::LogUtil("[TECH][Factory] Eco>=gate: enqueue 10 '" + unitName + "' from T2 bot lab (gate=" + botLabGate + ")", 3);
				IUnitTask @last2 = Tech_EnqueueUnitBatch(unitName, 10, pos);
				if (last2 !is null)
					return last2;
			}
		}

		// After builder production priorities, if this is a T1 vehicle plant and eco is strong, enqueue a block of scouts
		if (UnitHelpers::IsT1VehicleLab(facDef.GetName()))
		{
			if (metalIncome >= vehiclePlantGate)
			{
				string unitName = UnitHelpers::GetT1VehicleScoutForSide(side);
				GenericHelpers::LogUtil("[TECH][Factory] Eco>=gate: enqueue 10 '" + unitName + "' from T1 vehicle plant (gate=" + vehiclePlantGate + ")", 3);
				IUnitTask @last = Tech_EnqueueUnitBatch(unitName, 10, pos);
				if (last !is null)
					return last;
			}
		}

		// After builder production priorities, if this is a T2 vehicle plant and eco is strong, enqueue a block of units.
		if (UnitHelpers::IsT2VehicleLab(facDef.GetName()))
		{
			if (metalIncome >= vehiclePlantGate)
			{
				string unitName = UnitHelpers::GetMainBattleTankForSide(side);

				GenericHelpers::LogUtil("[TECH][Factory] Eco>=gate: enqueue 10 '" + unitName + "' from T2 vehicle plant (gate=" + vehiclePlantGate + ")", 3);
				IUnitTask @last2 = Tech_EnqueueUnitBatch(unitName, 10, pos);
				if (last2 !is null)
					return last2;
			}
		}
		GenericHelpers::LogUtil("[TECH][Factory] No custom tasks applicable; using DefaultMakeTask for factory '" + facDef.GetName() + "'", 4);
		return aiFactoryMgr.DefaultMakeTask(u);
	}

	string Tech_SelectFactoryHandler(const AIFloat3& in pos, bool isStart, bool isReset)
	{
		GenericHelpers::LogUtil("[TECH] Enter Tech_SelectFactoryHandler", 4);

		if (isStart)
		{
			if (Global::Map::NearestMapStartPosition !is null)
			{
				// Prefer configured map role weights; fallback to role-appropriate default if none found
				return FactoryHelpers::SelectStartFactoryForRole(Global::AISettings::Role, Global::AISettings::Side);
			}
			else
			{
				GenericHelpers::LogUtil("[Tech_SelectFactoryHandler] nearestMapPosition is null", 2);
				// Even if nearest start is unavailable, attempt a safe fallback
				return FactoryHelpers::GetFallbackStartFactoryForRole(Global::AISettings::Role, Global::AISettings::Side);
			}
		}

		return "";
	}

	bool Tech_AiIsSwitchTime(int lastSwitchFrame)
	{
		GenericHelpers::LogUtil("[TECH] Enter Tech_AiIsSwitchTime", 4);

		int interval = (20 * SECOND);
		return (lastSwitchFrame + interval) <= ai.frame;
	}

	bool Tech_AiIsSwitchAllowed(const CCircuitDef @facDef, float armyCost, int factoryCount, float metalCurrent, bool&out assistRequired)
	{
		GenericHelpers::LogUtil("[TECH] Enter Tech_AiIsSwitchAllowed", 4);

		float metalIncome = aiEconomyMgr.metal.income;
		bool switchAllowed = metalIncome > 100.0f;

		// Always disable factory assist until at least one gantry exists (land or water)
		int landGantryCount = UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllLandGantries());
		int waterGantryCount = UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllWaterGantries());
		int totalGantryCount = landGantryCount + waterGantryCount;

		// Note: assistRequired is the out parameter; ensure we set it before returning
		// If no gantries exist yet, force assist off regardless of switchAllowed.
		assistRequired = (totalGantryCount < 1) ? false : (!switchAllowed);

		GenericHelpers::LogUtil(
			"[TECH] switch_allowed=" + (switchAllowed ? "true" : "false") +
				" assist_required=" + (assistRequired ? "true" : "false") +
				" gantries_total=" + totalGantryCount + " (land=" + landGantryCount + ", water=" + waterGantryCount + ")",
			2);

		return switchAllowed;
	}

	int Tech_MakeSwitchInterval()
	{
		GenericHelpers::LogUtil("[TECH] Enter Tech_MakeSwitchInterval", 4);
		return AiRandom(Global::RoleSettings::Tech::MinAiSwitchTime, Global::RoleSettings::Tech::MaxAiSwitchTime) * SECOND;
	}

	void Tech_FactoryAiUnitAdded(CCircuitUnit @unit, Unit::UseAs usage)
	{
		if (unit is null)
		{
			GenericHelpers::LogUtil("[TECH] AiUnitAdded: unit=<null>", 2);
			return;
		}
		GenericHelpers::LogUtil("[TECH] Enter Tech_FactoryAiUnitAdded", 4);
		// Lab tracking is now centralized in Factory::AiUnitAdded

		// When the first T2 bot lab is created, raise T1 metal storage cap to 1 (if previously 0)
		if (!hasRaisedT1MetalStorageCap)
		{
			const CCircuitDef @cdef = unit.circuitDef;
			if (cdef !is null)
			{
				string uname = cdef.GetName();
				if (UnitHelpers::IsT2BotLab(uname))
				{
					int t2LabCount = UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllT2BotLabs());
					if (t2LabCount <= 1)
					{
						array<string> t1Metal = UnitHelpers::GetAllT1MetalStorages();
						UnitHelpers::BatchApplyUnitCaps(t1Metal, 1);
						hasRaisedT1MetalStorageCap = true;
						GenericHelpers::LogUtil("[TECH][Limits] First T2 bot lab created; raising T1 metal storage cap to 1", 2);
						// Re-apply merged map+role limits so map constraints win
						if (Global::Map::MergedUnitLimits.getKeys().length() > 0)
						{
							GenericHelpers::LogUtil("[TECH][Limits] Re-applying merged map+role unit limits after T1 metal storage unlock", 4);
							UnitHelpers::ApplyUnitLimits(Global::Map::MergedUnitLimits);
						}
					}
				}
			}
		}
	}

	void Tech_FactoryAiUnitRemoved(CCircuitUnit @unit, Unit::UseAs usage)
	{
		GenericHelpers::LogUtil("[TECH] Enter Tech_FactoryAiUnitRemoved", 4);
		// Lab tracking is now centralized in Factory::AiUnitRemoved
	}

	/******************************************************************************

	MILITARY HOOKS

	******************************************************************************/

	IUnitTask @Tech_MilitaryAiMakeTask(CCircuitUnit @u)
	{
		float metalIncome = Economy::GetMinMetalIncomeLast10s();

		// Check if this is a nuclear silo and we haven't targeted the farthest tech spot yet
		const CCircuitDef @def = (u is null ? null : u.circuitDef);
		if (def !is null)
		{
			string name = def.GetName();
			array<string> silos = UnitHelpers::GetAllNukeSilos();
			if (silos.find(name) >= 0)
			{
				if (!hasTargetedFarthestTech)
				{
					// Find farthest Tech spot
					AIFloat3 startPos = Global::Map::StartPos;
					float maxDistSq = -1.0f;
					AIFloat3 targetPos;
					bool found = false;

					for (uint i = 0; i < Global::Map::Config.StartSpots.length(); ++i)
					{
						const StartSpot @spot = Global::Map::Config.StartSpots[i];
						if (spot.aiRole == AiRole::TECH)
						{
							float d = MapHelpers::SqDist(startPos, spot.pos);
							if (d > maxDistSq)
							{
								maxDistSq = d;
								targetPos = spot.pos;
								found = true;
							}
						}
					}

					if (found)
					{
						hasTargetedFarthestTech = true;
						GenericHelpers::LogUtil("[TECH] Nuke Silo targeting farthest Tech spot at distSq=" + maxDistSq, 2);

						// FIX: Use CallRules to fire, as FactoryMgr is for building.
						// Command format: "ai_super_fire:UNIT_ID/X/Z"

						// Send intention first
						string cmdIntention = "ai_super_intention:" + u.id + "/" + int(targetPos.x) + "/" + int(targetPos.z);
						ai.CallRules(cmdIntention);

						string cmd = "ai_super_fire:" + u.id + "/" + int(targetPos.x) + "/" + int(targetPos.z);
						GenericHelpers::LogUtil("[TECH] Sending CallRules: " + cmd, 2);
						ai.CallRules(cmd);

						// Return a Wait task to occupy the unit while it fires
						return aiFactoryMgr.Enqueue(TaskS::Wait(false, 300)); // Wait ~10s
					}
				}
			}
		}

		if (metalIncome < 50.0f)
		{
			return null;
		}

		return aiMilitaryMgr.DefaultMakeTask(u);
	}

	void Tech_AiMakeDefence(int cluster, const AIFloat3& in pos)
	{
		// float metalIncome = Economy::GetMetalIncome();
		float metalIncome = Economy::GetMinMetalIncomeLast10s();

		if (metalIncome < Global::RoleSettings::Tech::MilitaryDefenceMetalIncomeThreshold)
		{
			aiMilitaryMgr.DefaultMakeDefence(cluster, pos);
		}
	}

	/******************************************************************************

	BUILDER HOOKS

	******************************************************************************/

	void Tech_BuilderAiUnitAdded(CCircuitUnit @unit, Unit::UseAs usage)
	{
		// Donation hook: when the 3rd T2 constructor is created, donate it to the team leader
		if (unit is null)
			return;
		const CCircuitDef @d = unit.circuitDef;
		if (d is null)
			return;

		// Add BASE attribute to T1 bot constructors, T2 bot constructors, and T2 fast assist bots
		// This ensures they stay near the base or are treated as base defenders/builders
		string name = d.GetName();
		bool isT1BotCtor = (UnitHelpers::GetAllT1BotConstructors().find(name) >= 0);
		bool isT2BotCtor = UnitHelpers::IsT2BotConstructor(name);
		bool isFastAssist = (UnitHelpers::GetAllFastAssistBots().find(name) >= 0);

		if (isT1BotCtor || isT2BotCtor || isFastAssist)
		{
			GenericHelpers::LogUtil("[TECH] Adding BASE attribute to builder: " + name + " id=" + unit.id, 3);
			unit.AddAttribute(Unit::Attr::BASE.type);
		}

		Team::CheckDonation(unit);
		if (Team::IsT2Constructor(d))
		{
			aiFactoryMgr.isAssistRequired = false;
		}
	}

	void Tech_BuilderAiUnitRemoved(CCircuitUnit @unit, Unit::UseAs usage)
	{ /* moved to Builder::AiUnitRemoved */
	}

	IUnitTask @Tech_BuilderAiMakeTask(CCircuitUnit @u)
	{
		GenericHelpers::LogUtil("[TECH] Enter Tech_BuilderAiMakeTask", 4);
		// Pre-create a default task to return if no other rules trigger
		IUnitTask @defaultTask = Builder::MakeDefaultTaskWithLog(u.id, "TECH");
		// If the default task is a BUILDER and its build type is MEX/MEXUP/GEO/GEOUP, don't override it; return immediately.
		{
			IBuilderTask @defaultBuilderTask = cast<IBuilderTask>(defaultTask);
			if (defaultBuilderTask !is null)
			{
				Task::BuildType dbt = Task::BuildType(defaultBuilderTask.GetBuildType());

				// Special handling for MEXUP: only allow if we built the underlying MEX
				if (dbt == Task::BuildType::MEXUP)
				{
					if (Economy::MexTracker::IsOwnedMex(defaultBuilderTask.GetBuildPos()))
					{
						GenericHelpers::LogUtil("[TECH] defaultTask (BUILDER) is MEXUP for owned MEX; upgrading immediately.", 3);
						string side = UnitHelpers::GetSideForUnitName(u.circuitDef.GetName());
						string t2MexName = UnitHelpers::GetT2MexNameForSide(side);
						CCircuitDef @upgradeDef = ai.GetCircuitDef(t2MexName);
						if (upgradeDef !is null)
						{
							return aiBuilderMgr.Enqueue(TaskB::Spot(Task::BuildType::MEXUP, Task::Priority::NOW, upgradeDef, defaultBuilderTask.GetBuildPos(), -1));
						}
						// return defaultTask;
					}
					else
					{
						GenericHelpers::LogUtil("[TECH] defaultTask (BUILDER) is MEXUP for unowned/ally MEX; redirecting to owned MEX", 3);

						// Find nearest owned Mex to upgrade using MexTracker
						AIFloat3 unitPos = u.GetPos(ai.frame);
						AIFloat3 bestPos = Economy::MexTracker::GetNearestNonUpgradedMex(unitPos);

						if (bestPos.x != -1)
						{
							// Get T2 Mex Def for upgrade
							string side = UnitHelpers::GetSideForUnitName(u.circuitDef.GetName());
							string t2MexName = UnitHelpers::GetT2MexNameForSide(side);
							CCircuitDef @upgradeDef = ai.GetCircuitDef(t2MexName);

							if (upgradeDef !is null)
							{
								GenericHelpers::LogUtil("[TECH] Redirecting MEXUP to nearest owned Mex at (" + bestPos.x + "," + bestPos.z + ")", 3);
								return aiBuilderMgr.Enqueue(TaskB::Spot(Task::BuildType::MEXUP, Task::Priority::NOW, upgradeDef, bestPos, -1));
							}
						}

						// return null;
					}
				}

				if (dbt == Task::BuildType::MEX || dbt == Task::BuildType::GEO || dbt == Task::BuildType::GEOUP)
				{
					GenericHelpers::LogUtil("[TECH] defaultTask (BUILDER) is MEX/GEO/GEOUP; returning immediately.", 3);
					return defaultTask;
				}
			}
		}

		// Log economy snapshot for task decisions
		// float metalIncome = Global::Economy::MetalIncome;
		// float energyIncome = Global::Economy::EnergyIncome;
		float metalIncome = Economy::GetMinMetalIncomeLast10s();
		float energyIncome = Economy::GetMinEnergyIncomeLast10s();

		GenericHelpers::LogUtil("[TECH] Econ snapshot metalIncome=" + metalIncome + " energyIncome=" + energyIncome, 2);

		const CCircuitDef @udef = (u is null ? null : u.circuitDef);

		bool isCommander = UnitHelpers::IsCommander(udef);

		if (isCommander)
		{
			// return null;
			return Tech_Commander_AiMakeTask(u, defaultTask, metalIncome);
		}
		GenericHelpers::LogUtil("[TECH] Not a commander, checking constructor tier", 4);

		int constructorTier = UnitHelpers::GetConstructorTier(udef);

		// Check if we have T2 constructors but un-upgraded mexes near start
		if (constructorTier == 2)
		{
			// Count total T2 mexes globally
			array<string> t2Mexes = UnitHelpers::GetAllT2Mexes();
			int totalT2MexCount = UnitDefHelpers::SumUnitDefCounts(t2Mexes);

			if (totalT2MexCount < 3)
			{
				const float checkRadius = 600.0f;
				const AIFloat3 startPos = Global::Map::StartPos;

				// Count owned mexes within range of start position
				int nearbyOwnedMexCount = Economy::MexTracker::GetOwnedMexCountInRange(startPos, checkRadius);

				// If we have fewer T2 mexes than owned mexes near start, assume start mexes aren't fully upgraded
				// and move the builder to the nearest start mex to wait/prioritize upgrades.
				if (totalT2MexCount < nearbyOwnedMexCount)
				{

					AIFloat3 unitPos = u.GetPos(ai.frame);
					AIFloat3 bestPos = Economy::MexTracker::GetNearestNonUpgradedMexInRange(unitPos, startPos, checkRadius);

					if (bestPos.x != -1)
					{
						GenericHelpers::LogUtil("[TECH] T2 Constructor available but local mexes not upgraded (T2Mex=" + totalT2MexCount + " < LocalOwned=" + nearbyOwnedMexCount + "). Moving to nearest mex at (" + bestPos.x + "," + bestPos.z + ")", 3);
						string side = UnitHelpers::GetSideForUnitName(u.circuitDef.GetName());
						string t2MexName = UnitHelpers::GetT2MexNameForSide(side);
						CCircuitDef @upgradeDef = ai.GetCircuitDef(t2MexName);

						if (upgradeDef !is null)
						{
							return aiBuilderMgr.Enqueue(TaskB::Spot(Task::BuildType::MEXUP, Task::Priority::NOW, upgradeDef, bestPos, -1));
						}
					}
					// return null;
				}
			}
		}

		if (constructorTier == 1)
		{
			IUnitTask @recycleTask = Recycle(u, metalIncome);
			if (recycleTask !is null)
			{
				GenericHelpers::LogUtil("[TECH] Recycling task assigned", 2);
				return recycleTask;
			}

			GenericHelpers::LogUtil("[TECH] Attempt Tier 1 Build Tasks", 4);

			// Route T1 constructors by movement type: bots vs aircraft vs others
			if (UnitHelpers::IsAirConstructor(udef))
			{
				return Tech_T1AirConstructor_AiMakeTask(u, metalIncome, energyIncome, defaultTask);
			}
			if (UnitHelpers::IsT1BotConstructor(udef.GetName()))
			{
				return Tech_T1BotConstructor_AiMakeTask(u, metalIncome, energyIncome, defaultTask);
			}

			// Fallback: use the pre-created default task for non-bot T1 constructors (e.g., vehicles/ships)
			return defaultTask;
		}

		// Otherwise do normal selection (and we simply won't accept stray factory tasks)
		// Before falling back, if this is an extra T2 constructor assigned as guard, enforce it
		if (constructorTier == 2)
		{
			GenericHelpers::LogUtil("[TECH] Attempt Tier 2 Build Tasks", 4);
			string ctorName = udef.GetName();
			bool isEnergyFull = aiEconomyMgr.isEnergyFull;
			bool isEnergyLessThan90Percent = aiEconomyMgr.energy.current < aiEconomyMgr.energy.storage * Global::RoleSettings::Tech::EnergyStorageLowPercent;
			float metalCurrent = aiEconomyMgr.metal.current;

			// Route T2 constructors by movement type: bots vs aircraft vs others
			if (UnitHelpers::IsAirConstructor(udef))
			{
				return Tech_T2AirConstructor_AiMakeTask(u, isEnergyFull, metalIncome, energyIncome, metalCurrent, isEnergyLessThan90Percent, defaultTask);
			}
			if (UnitHelpers::IsT2BotConstructor(ctorName))
			{
				GenericHelpers::LogUtil("[TECH] T2 Bot constructor making task: " + ctorName + " id=" + u.id, 2);
				return Tech_T2BotConstructor_AiMakeTask(u, isEnergyFull, metalIncome, energyIncome, metalCurrent, isEnergyLessThan90Percent, defaultTask);
			}
			if (UnitHelpers::IsFastAssistBot(ctorName))
			{
				GenericHelpers::LogUtil("[TECH] Fast-assist bot making task: " + ctorName + " id=" + u.id, 2);
				// Use a dedicated helper for fast-assist builders so their behavior can
				// diverge from normal T2 bot constructors if needed.
				return Tech_T2FastAssistBotConstructor_AiMakeTask(u, isEnergyFull, metalIncome, energyIncome, metalCurrent, isEnergyLessThan90Percent, defaultTask);
			}

			// Fallback: use the pre-created default task for non-bot T2 constructors (e.g., vehicles/ships)
			return defaultTask;
		}

		// Allow null to propagate; Builder::AiMakeTask will fallback to DefaultMakeTask if needed
		GenericHelpers::LogUtil("[TECH] No role-specific task; using pre-created default", 2);
		return defaultTask;
	}

	void Tech_BuilderAiTaskAdded(IUnitTask @task)
	{
		GenericHelpers::LogUtil("[TECH] Enter Tech_BuilderAiTaskAdded", 4);
		if (task is null)
			return;

		IBuilderTask @builderTask = cast<IBuilderTask>(task);
		if (builderTask !is null && Task::BuildType(builderTask.GetBuildType()) == Task::BuildType::MEXUP)
		{
			GenericHelpers::LogUtil("[TECH] AiTaskAdded: detected MEX upgrade task, tracking it", 2);
			Economy::MexTracker::MarkUpgradeInProgress(builderTask.GetBuildPos(), true);
		}
	}

	void Tech_BuilderAiTaskRemoved(IUnitTask @task, bool done)
	{
		GenericHelpers::LogUtil("[TECH] Enter Tech_BuilderAiTaskRemoved", 4);
		if (task is null)
			return;

		IBuilderTask @builderTask = cast<IBuilderTask>(task);
		if (builderTask !is null)
		{
			Task::BuildType bt = Task::BuildType(builderTask.GetBuildType());

			// Track completed MEX builds to own them for future upgrades
			if (done && bt == Task::BuildType::MEX)
			{
				Economy::MexTracker::RegisterMex(builderTask.GetBuildPos());
			}

			if (bt == Task::BuildType::MEXUP)
			{
				Economy::MexTracker::MarkUpgradeInProgress(builderTask.GetBuildPos(), false);
				if (done)
				{
					Economy::MexTracker::MarkUpgraded(builderTask.GetBuildPos());
				}
				GenericHelpers::LogUtil("[TECH] AiTaskRemoved: detected MEX upgrade task, removing it", 2);
			}
		}
	}

	/******************************************************************************

	ECONOMY LOGIC

	******************************************************************************/

	void Tech_IncomeBuilderLimits(float metalIncome)
	{
		GenericHelpers::LogUtil("[TECH] Enter Tech_IncomeBuilderLimits", 4);

		// Determine cap: 35 metal income per lab (e.g., 70 -> 2 labs)
		int rezBotCap = 1 * int(metalIncome / 20.0f);
		if (rezBotCap < 5)
			rezBotCap = 1;

		string side = Global::AISettings::Side;

		array<string> rezList = UnitHelpers::GetRezBots(side);
		UnitHelpers::BatchApplyUnitCaps(rezList, rezBotCap);
		int rezCount = UnitDefHelpers::SumUnitDefCounts(rezList);
		GenericHelpers::LogUtil("[TECH][Limits] RezBots cap=" + rezBotCap + " current=" + rezCount + " side=" + side, 4);

		// Fast-assist cap scaling (stored globally for reuse in factory logic):
		// - Below 100 metal income: original behaviour (5 bots per 45 income)
		// - At/above 100 metal income: more aggressive scaling (5 bots per 20 income)
		if (metalIncome < 100.0f)
		{
			g_fastAssistBotCap = 5 * int(metalIncome / 45.0f);
		}
		else
		{
			g_fastAssistBotCap = 5 * int(metalIncome / 20.0f);
		}
		// if (g_fastAssistBotCap < 5) g_fastAssistBotCap = 1;

		array<string> faList = UnitHelpers::GetFastAssistBots(side);
		UnitHelpers::BatchApplyUnitCaps(faList, g_fastAssistBotCap);
		int faCount = UnitDefHelpers::SumUnitDefCounts(faList);
		GenericHelpers::LogUtil("[TECH][Limits] FastAssist cap=" + g_fastAssistBotCap + " current=" + faCount + " side=" + side, 4);

		// T1 builder cap via economic helper; honor min and global max
		int t1BuilderCap = EconomyHelpers::CalculateT1BuilderCap(
			/*metalIncome*/ metalIncome,
			/*minCap*/ 5,
			/*maxCap*/ Global::RoleSettings::Tech::MaxT1Builders);

		UnitHelpers::BatchApplyUnitCaps(UnitHelpers::GetT1LandBuilders(side), t1BuilderCap);

		// T2 builder cap via economic helper; honor min and global max
		int t2BuilderCap = EconomyHelpers::CalculateT2BuilderCap(
			/*metalIncome*/ metalIncome,
			/*minCap*/ 3,
			/*maxCap*/ Global::RoleSettings::Tech::MaxT2Builders);

		UnitHelpers::BatchApplyUnitCaps(UnitHelpers::GetT2LandBuilders(side), t2BuilderCap);

		// Ensure merged map+role limits are reapplied after dynamic economy-based caps
		if (Global::Map::MergedUnitLimits.getKeys().length() > 0)
		{
			GenericHelpers::LogUtil("[TECH][Limits] Re-applying merged map+role unit limits (economy update)", 4);
			UnitHelpers::ApplyUnitLimits(Global::Map::MergedUnitLimits);
		}
	}

	/******************************************************************************

	COMMANDER LOGIC

	******************************************************************************/

	IUnitTask @Tech_Commander_AiMakeTask(CCircuitUnit @u, IUnitTask @defaultTask, float metalIncome)
	{
		GenericHelpers::LogUtil("[TECH] Enter Tech_Commander_AiMakeTask", 4);

		GenericHelpers::LogUtil("[TECH] Commander making task: " + u.circuitDef.GetName() + " id=" + u.id, 2);
		IUnitTask @recycleTask = Recycle(u, metalIncome);
		if (recycleTask !is null)
			return recycleTask;

		GenericHelpers::LogUtil("[TECH] No commander-specific task, using pre-created default", 2);
		// Use the pre-created default task passed from caller when no commander-specific path applies
		return defaultTask;
	}

	/******************************************************************************

	BUILDER LOGIC

	******************************************************************************/

	// Finishing a reactor that is already under construction beats starting any new
	// energy structure: the metal is already committed, and an unfinished reactor
	// produces nothing until it completes. Returns an assist task when a Fusion or
	// Advanced Fusion is in progress, otherwise null so the caller proceeds normally.
	// A merely queued reactor does not qualify - see Builder::GetReactorUnderConstruction.
	IUnitTask @Tech_RedirectEnergyToReactor(const string &in what)
	{
		IUnitTask @assist = Builder::EnqueueAssistReactor(Task::Priority::HIGH, 60 * SECOND);
		if (assist !is null)
		{
			GenericHelpers::LogUtil("[TECH][Energy] Reactor under construction; redirecting "
				+ what + " to assist it instead", 2);
		}
		return assist;
	}

	IUnitTask @Tech_T1BotConstructor_AiMakeTask(CCircuitUnit @u, float metalIncome, float energyIncome, IUnitTask @defaultTask)
	{
		GenericHelpers::LogUtil("[TECH] Enter Tech_T1BotConstructor_AiMakeTask", 4);
		// Economy snapshot is provided by caller (to avoid repeated global reads)

		AIFloat3 conLocation = u.GetPos(ai.frame);

		string unitSide = UnitHelpers::GetSideForUnitName(u.circuitDef.GetName());

		// Primary Constructor Tasks
		// if (u is Builder::primaryT1BotConstructor)
		//{
		GenericHelpers::LogUtil("[TECH] Primary T1 bot constructor making task: " + u.circuitDef.GetName() + " id=" + u.id, 2);
		// Keep local counts for decisions that need them
		int t2ConstructionBotCount = UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllT2BotConstructors());
		int t2LabCount = UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllT2BotLabs());

		//******************************* T2 LAB CHECKS ******************************//
		// Hybrid policy: require minimum incomes for the FIRST T2 lab; after that, scale allowed count by income-per-lab.
		// Reference old threshold helper (ShouldBuildT2BotLab) for first-gate semantics.
		bool shouldT2Lab = EconomyHelpers::ShouldBuildT2BotLabFromIncomeWithFirstGate(
			/*mi*/ metalIncome,
			/*ei*/ energyIncome,
			/*currentT2Labs*/ t2LabCount,
			/*metalIncomePerLab*/ Global::RoleSettings::Tech::MetalIncomePerT2Lab,
			/*energyIncomePerLab*/ Global::RoleSettings::Tech::EnergyIncomePerT2Lab,
			/*firstLabRequiredMetalIncome*/ Global::RoleSettings::Tech::MinimumMetalIncomeForT2Lab,
			/*firstLabRequiredEnergyIncome*/ Global::RoleSettings::Tech::MinimumEnergyIncomeForT2Lab,
			/*maxAllowed*/ Global::RoleSettings::Tech::MaxT2BotLabs);
		if (shouldT2Lab)
		{
			GenericHelpers::LogUtil("[TECH] Econ OK for T2 attempt", 2);
			// For the FIRST T2 lab, place at the map StartPos; for additional labs, place at the commander's position.
			AIFloat3 anchorPos;
			if (t2LabCount == 0)
			{
				anchorPos = Global::Map::StartPos;
				GenericHelpers::LogUtil("[TECH] T2 lab anchor: StartPos (first lab)", 3);
			}
			else
			{
				CCircuitUnit @com = Builder::GetCommander();
				if (com !is null)
				{
					anchorPos = com.GetPos(ai.frame);
					GenericHelpers::LogUtil("[TECH] T2 lab anchor: Commander position", 4);
				}
				else
				{
					// Fallback: previous behavior (near existing T2 bot lab or commander if absent)
					anchorPos = Factory::GetT2BotLabPos();
					GenericHelpers::LogUtil("[TECH] T2 lab anchor: Fallback to T2 Bot Lab position (commander absent)", 4);
				}
			}
			IUnitTask @tLab = Builder::EnqueueT2BotLabIfNeeded(unitSide, anchorPos, SQUARE_SIZE * 20, SECOND * 300);
			if (tLab !is null)
				return tLab;
		}
		else
		{
			GenericHelpers::LogUtil("[TECH] Econ NOT OK for T2)", 2);
		}

		// ********************** AIRCRAFT PLANT CHECKS ********************** //
		// Consider a T1 aircraft plant if economy allows and within max allowed
		int t1AirPlants = UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllT1AircraftPlants());
		GenericHelpers::LogUtil(
			"[TECH] T1AirPlant check: metalIncome=" + metalIncome + " energyIncome=" + energyIncome + " metalCurrent=" + aiEconomyMgr.metal.current +
				" t1Count=" + t1AirPlants + " max=" + Global::RoleSettings::Tech::MaxT1AircraftPlants,
			3);
		bool shouldT1Air = EconomyHelpers::ShouldBuildT1AircraftPlant(
			metalIncome,
			energyIncome,
			aiEconomyMgr.metal.current,
			Global::RoleSettings::Tech::RequiredMetalIncomeForAirPlant,
			Global::RoleSettings::Tech::RequiredMetalCurrentForAirPlant,
			Global::RoleSettings::Tech::RequiredEnergyIncomeForAirPlant,
			t1AirPlants,
			Global::RoleSettings::Tech::MaxT1AircraftPlants);

		GenericHelpers::LogUtil("[TECH] ShouldBuildT1AircraftPlant => " + (shouldT1Air ? "true" : "false"), 3);
		if (shouldT1Air)
		{
			AIFloat3 preferredPosition = Factory::GetPreferredFactoryPos();
			IUnitTask @tAir = Builder::EnqueueT1AirFactory(unitSide, preferredPosition, SQUARE_SIZE * 24, 30 * SECOND, Task::Priority::HIGH);
			if (tAir !is null)
				return tAir;
		}

		// ********************** ENERGY/CONVERTER/SOLAR CHECKS********************** //
		if (EconomyHelpers::ShouldBuildT1EnergyConverter(
				metalIncome,
				energyIncome,
				aiEconomyMgr.energy.current,
				aiEconomyMgr.energy.storage,
				Global::RoleSettings::Tech::BuildT1ConvertersUntilMetalIncome,
				Global::RoleSettings::Tech::BuildT1ConvertersMinimumEnergyIncome,
				Global::RoleSettings::Tech::BuildT1ConvertersMinimumEnergyCurrentPercent))
		{
			IUnitTask @redirect = Tech_RedirectEnergyToReactor("T1 energy converter");
			if (redirect !is null)
				return redirect;
			IUnitTask @tConv = Builder::EnqueueT1EnergyConverter(unitSide, conLocation, SQUARE_SIZE * 32, SECOND * 30);
			if (tConv !is null)
				return tConv;
		}

		// Build regular solar?
		if (EconomyHelpers::ShouldBuildT1Solar(
				/*ei*/ energyIncome,
				/*min*/ Global::RoleSettings::Tech::SolarEnergyIncomeMinimum))
		{
			IUnitTask @redirect = Tech_RedirectEnergyToReactor("T1 solar");
			if (redirect !is null)
				return redirect;
			IUnitTask @tSolar = Builder::EnqueueT1Solar(u.id, unitSide, conLocation, SQUARE_SIZE * 32, SECOND * 75);
			if (tSolar !is null)
				return tSolar;
		}

		// Build a T1 nano caretaker if under desired target (income-based) or reserves allow
		float energyPercent = (aiEconomyMgr.energy.storage > 0.0f) ? (aiEconomyMgr.energy.current / aiEconomyMgr.energy.storage) : 0.0f;
		// Only build nanos if we have a preferred factory to anchor around
		if (Factory::GetPreferredFactory() !is null && EconomyHelpers::ShouldBuildT1Nano(
														   energyIncome,
														   metalIncome,
														   Global::RoleSettings::Tech::NanoEnergyPerUnit,
														   Global::RoleSettings::Tech::NanoMetalPerUnit,
														   Global::RoleSettings::Tech::NanoMaxCount,
														   aiEconomyMgr.metal.current,
														   Global::RoleSettings::Tech::NanoBuildWhenOverMetal,
														   energyPercent))
		{
			// Always place nano near our preferred factory location, not the constructor's current position
			AIFloat3 nanoPos = Factory::GetPreferredFactoryPos();
			IUnitTask @tNano = Builder::EnqueueT1Nano(unitSide, nanoPos, /*shake*/ SQUARE_SIZE * 24, /*timeout*/ 30);
			if (tNano !is null)
				return tNano;
		}

		// Advanced T1 solar decision via unified helper with TECH thresholds and T2 gating
			if (EconomyHelpers::ShouldBuildT1AdvancedSolar(
				/*energyIncome*/ energyIncome,
				/*metalIncome*/ metalIncome,
				/*energyIncomeMinimumThreshold*/ Global::RoleSettings::Tech::AdvancedSolarEnergyIncomeMinimum,
				/*energyIncomeMaximumThreshold*/ Global::RoleSettings::Tech::AdvancedSolarEnergyIncomeMaximum,
				/*t2ConstructorCount*/ t2ConstructionBotCount,
				/*t2FactoryCount*/ t2LabCount,
				/*isT2FactoryQueued*/ Factory::IsT2LabBuildQueued(),
				/*enableT2ProgressGate*/ true,
				/*metalIncomeFallbackMinimum*/ 6.0f))
		{
				IUnitTask @redirect = Tech_RedirectEnergyToReactor("advanced solar");
				if (redirect !is null)
					return redirect;
				IUnitTask @tAdvSolar = Builder::EnqueueT1AdvancedSolar(u.id, unitSide, conLocation, SQUARE_SIZE * 32, SECOND * 75);
			if (tAdvSolar !is null)
				return tAdvSolar;
		}

		// After eco threshold, expand T1 bot labs up to 5 via builder logic (uses cooldown in Builder)
		if (metalIncome >= Global::RoleSettings::Tech::MetalIncomeThresholdForBotLabExpansion)
		{
			int t1LabCount = UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllT1BotLabs());
			if (t1LabCount < 5)
			{
				AIFloat3 preferredPosition = Factory::GetPreferredFactoryPos();
				IUnitTask @tLab1 = Builder::EnqueueT1BotLab(unitSide, preferredPosition, SQUARE_SIZE * 24, 300 * SECOND, Task::Priority::NORMAL);
				if (tLab1 !is null)
					return tLab1;
			}
		}

		// After eco threshold, expand T1 vehicle plants up to 3 via builder logic
		if (metalIncome >= Global::RoleSettings::Tech::MetalIncomeThresholdForVehiclePlantExpansion)
		{
			int t1VehCount = UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllT1VehicleLabs());
			if (t1VehCount < 3)
			{
				AIFloat3 preferredPosition = Factory::GetPreferredFactoryPos();
				IUnitTask @tLabVeh = Builder::EnqueueT1VehiclePlant(unitSide, preferredPosition, SQUARE_SIZE * 24, 300 * SECOND, Task::Priority::NORMAL);
				if (tLabVeh !is null)
					return tLabVeh;
			}
		}

		// if (Builder::primaryT2BotConstructor !is null)
		// {
		// 	return GuardHelpers::AssignWorkerGuard(u, Builder::primaryT2BotConstructor, Task::Priority::HIGH, true, 120 * SECOND);
		// }
		// }
		// else if (u is Builder::secondaryT1BotConstructor)
		// {
		// 	GenericHelpers::LogUtil("[TECH] Secondary T1 constructor making task: " + u.circuitDef.GetName() + " id=" + u.id, 2);
		// 	// Check if anything needs to be recycled
		// 	IUnitTask @recycleTask = Recycle(u, metalIncome);
		// 	if (recycleTask !is null)
		// 		return recycleTask;

		// 	if (EconomyHelpers::ShouldSecondaryT1AssistPrimary(
		// 			/*metalIncome*/ metalIncome,
		// 			/*threshold*/ 80.0f))
		// 	{
		// 		GenericHelpers::LogUtil("[TECH] Secondary T1 assisting primary", 2);
		// 		return GuardHelpers::AssignWorkerGuard(u, Builder::primaryT1BotConstructor, Task::Priority::HIGH, true, 20 * SECOND);
		// 	}
		// }

		GenericHelpers::LogUtil("[TECH] No role-specific task; using pre-created default", 2);
		// Use the pre-created default task passed from caller when no T1-constructor-specific path applies
		return defaultTask;
	}

	IUnitTask @Tech_T1AirConstructor_AiMakeTask(CCircuitUnit @u, float metalIncome, float energyIncome, IUnitTask @defaultTask)
	{
		GenericHelpers::LogUtil("[TECH] Enter Tech_T1AirConstructor_AiMakeTask", 4);
		// For now, reuse the full T1 bot constructor logic for air constructors as well.
		// If we later want air-specific behavior (e.g., different placement), we can
		// specialize this function while keeping the same signature.
		return Tech_T1BotConstructor_AiMakeTask(u, metalIncome, energyIncome, defaultTask);
	}

	IUnitTask @Tech_T2BotConstructor_AiMakeTask(CCircuitUnit @u, bool isEnergyFull, float metalIncome, float energyIncome, float metalCurrent, bool isEnergyLessThan90Percent, IUnitTask @defaultTask)
	{

		string unitSide = UnitHelpers::GetSideForUnitName(u.circuitDef.GetName());

		AIFloat3 anchor = Factory::GetT2BotLabPos();

		// Build experimental gantry by economy thresholds (per request)
		int gantryCount = UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllLandGantries());
		if (EconomyHelpers::ShouldBuildGantry(
				/*mi*/ metalIncome,
				/*ei*/ energyIncome,
				/*metalStored*/ metalCurrent,
				/*currentGantryCount*/ gantryCount,
				/*metalIncomePerGantry*/ Global::RoleSettings::Tech::MetalIncomePerGantry,
				/*energyIncomePerGantry*/ Global::RoleSettings::Tech::EnergyIncomePerGantry))
		{
			IUnitTask @tGantry = Builder::EnqueueLandGantry(unitSide);
			if (tGantry !is null)
				return tGantry;
		}

		if (EconomyHelpers::ShouldBuildT2EnergyConverter(
				/*metalIncome*/ metalIncome,
				/*energyIncome*/ energyIncome,
				/*energy<90%*/ isEnergyLessThan90Percent,
				/*energyFull*/ isEnergyFull,
				/*reqMi*/ Global::RoleSettings::Tech::MinimumMetalIncomeForAdvConverter,
				/*reqEi*/ Global::RoleSettings::Tech::MinimumEnergyIncomeForAdvConverter))
		{
			GenericHelpers::LogUtil("[TECH] Economy OK to build Advanced Energy Converter", 2);
			IUnitTask @redirect = Tech_RedirectEnergyToReactor("advanced energy converter");
			if (redirect !is null)
				return redirect;
			IUnitTask @tConv = Builder::EnqueueAdvEnergyConverter(unitSide, Factory::GetT2BotLabPos(), SQUARE_SIZE * 32, SECOND * 60);
			if (tConv !is null)
				return tConv;
		}

		// Nuke silo decision via helper using cached snapshot
		int nukeTotal = EconomyHelpers::GetNukeSiloCount();
		int nukeQueued = Builder::NukeSiloQueuedCount;
		if (EconomyHelpers::ShouldBuildNuclearSilo(
				/*mi*/ metalIncome,
				/*ei*/ energyIncome,
				/*queued*/ nukeQueued,
				/*total*/ nukeTotal,
				/*rushCount*/ Global::RoleSettings::Tech::NukeRush,
				/*reqMiRush*/ Global::RoleSettings::Tech::MinimumMetalIncomeForNukeRush,
				/*reqEiRush*/ Global::RoleSettings::Tech::MinimumEnergyIncomeForNukeRush,
				/*reqMiReg*/ Global::RoleSettings::Tech::MinimumMetalIncomeForNuke,
				/*reqEiReg*/ Global::RoleSettings::Tech::MinimumEnergyIncomeForNuke))
		{
			GenericHelpers::LogUtil("[TECH] Economy OK to build Nuke Silo", 2);
			IUnitTask @tNuke = Builder::EnqueueNukeSilo(unitSide, anchor, SQUARE_SIZE * 32, SECOND * 300);
			if (tNuke !is null)
				return tNuke;
		}

		// Anti-nuke decision: ensure at least target number based on income-scaled allowance and minimum
		int antiNukeTotal = EconomyHelpers::GetAntiNukeCount();
		int allowedAnti = EconomyHelpers::AllowedAntiNukesFromIncome(
			/*metalIncome*/ metalIncome,
			/*per*/ Global::RoleSettings::Tech::MetalIncomePerAntiNuke);
		if (EconomyHelpers::ShouldBuildAntiNuke(
				/*mi*/ metalIncome,
				/*ei*/ energyIncome,
				/*current*/ antiNukeTotal,
				/*reqMi*/ Global::RoleSettings::Tech::MinimumMetalIncomeForAntiNuke,
				/*reqEi*/ Global::RoleSettings::Tech::MinimumEnergyIncomeForAntiNuke,
				/*minCount*/ Global::RoleSettings::Tech::MinimumAntiNukeCount,
				/*allowed*/ allowedAnti))
		{
			GenericHelpers::LogUtil("[TECH] Economy OK to build Anti-Nuke (below target)", 2);
			IUnitTask @tAmd = Builder::EnqueueAntiNuke(unitSide, anchor, SQUARE_SIZE * 32, SECOND * 300);
			if (tAmd !is null)
				return tAmd;
		}

		if (EconomyHelpers::ShouldBuildAdvancedFusionReactor(
				/*mi*/ metalIncome,
				/*ei*/ energyIncome,
				/*energy<90%*/ isEnergyLessThan90Percent,
				/*nukeRush*/ Global::RoleSettings::Tech::NukeRush,
				/*nukeSilos*/ nukeTotal,
				/*reqMi*/ Global::RoleSettings::Tech::MinimumMetalIncomeForAFUS,
				/*reqEi*/ Global::RoleSettings::Tech::MinimumEnergyIncomeForAFUS))
		{
			GenericHelpers::LogUtil("[TECH] Economy OK to build Advanced Fusion Reactor", 2);
			// Additional gate: If a nuclear silo is on cooldown and we have <2 AFUS built, suppress AFUS build
			// NOTE: There's no explicit nuke-silo cooldown helper; we treat "queued" as a cooldown proxy.
			int afusBuilt = 0;
			{
				array<string> afusNames = UnitHelpers::GetAllAdvancedFusionReactors();
				for (uint i = 0; i < afusNames.length(); ++i)
				{
					CCircuitDef @d = ai.GetCircuitDef(afusNames[i]);
					if (d !is null)
					{
						afusBuilt += d.count;
					}
				}
			}
			const bool nukeCooldownActive = Builder::IsNukeSiloBuildQueued(); // TODO: replace with explicit cooldown if added
			if (nukeCooldownActive && afusBuilt < 2)
			{
				GenericHelpers::LogUtil("[TECH] Suppress AFUS: nuke silo cooldown active and AFUS<2 (built=" + afusBuilt + ")", 2);
			}
			else
			{
				IUnitTask @tAfus = Builder::EnqueueAFUS(unitSide, Factory::GetT2BotLabPos(), SQUARE_SIZE * 32, SECOND * 300);
				if (tAfus !is null)
					return tAfus;
			}
		}

		if (EconomyHelpers::ShouldBuildFusionReactor(
				/*mi*/ metalIncome,
				/*ei*/ energyIncome,
				/*energy<90%*/ isEnergyLessThan90Percent,
				/*reqMi*/ Global::RoleSettings::Tech::MinimumMetalIncomeForFUS,
				/*reqEi*/ Global::RoleSettings::Tech::MinimumEnergyIncomeForFUS,
				/*maxEi*/ Global::RoleSettings::Tech::MaxEnergyIncomeForFUS))
		{
			GenericHelpers::LogUtil("[TECH] Economy OK to build fusion reactor", 2);
			IUnitTask @tFus = Builder::EnqueueFUS(unitSide, Factory::GetT2BotLabPos(), SQUARE_SIZE * 32, SECOND * 300);
			if (tFus !is null)
				return tFus;
		}

		GenericHelpers::LogUtil("[TECH] No role-specific task; using pre-created default", 2);
		// Use the pre-created default task passed from caller when no T2-constructor-specific path applies
		return defaultTask;
	}

	// Dedicated make-task for fast-assist T2 builders. For now this mirrors the
	// T2 bot constructor logic exactly, but is kept separate so it can diverge
	// later without impacting normal T2 bots.
	IUnitTask @Tech_T2FastAssistBotConstructor_AiMakeTask(CCircuitUnit @u, bool isEnergyFull, float metalIncome, float energyIncome, float metalCurrent, bool isEnergyLessThan90Percent, IUnitTask @defaultTask)
	{

		string unitSide = UnitHelpers::GetSideForUnitName(u.circuitDef.GetName());

		IUnitTask @recycleTask = Recycle(u, metalIncome);
		if (recycleTask !is null)
		{
			GenericHelpers::LogUtil("[TECH] Recycling task assigned", 2);
			return recycleTask;
		}

		GenericHelpers::LogUtil("[TECH] No fast-assist-specific task; using pre-created default", 2);
		return defaultTask;
	}

	IUnitTask @Tech_T2AirConstructor_AiMakeTask(CCircuitUnit @u, bool isEnergyFull, float metalIncome, float energyIncome, float metalCurrent, bool isEnergyLessThan90Percent, IUnitTask @defaultTask)
	{
		GenericHelpers::LogUtil("[TECH] Enter Tech_T2AirConstructor_AiMakeTask", 4);
		// For now, reuse the full T2 bot constructor logic for air constructors as well.
		// If we later want air-specific behavior, we can specialize this function while
		// keeping the same signature.
		return Tech_T2BotConstructor_AiMakeTask(u, isEnergyFull, metalIncome, energyIncome, metalCurrent, isEnergyLessThan90Percent, defaultTask);
	}

	IUnitTask @Recycle(CCircuitUnit @u, float metalIncome)
	{
		GenericHelpers::LogUtil(
			"[TECH] Enter Recycle IsT2LabQueued=" + (Factory::IsT2LabBuildQueued() ? "true" : "false") +
				" MetalCurrent=" + aiEconomyMgr.metal.current + " metalIncome=" + metalIncome,
			4);

		// Policy: Never recycle T1/T2 labs if we already have at least one Advanced Fusion built
		// Sum counts across all factions' Advanced Fusion reactor unit IDs
		array<string> afusNames = UnitHelpers::GetAllAdvancedFusionReactors();
		int afusBuilt = 0;
		for (uint i = 0; i < afusNames.length(); ++i)
		{
			CCircuitDef @d = ai.GetCircuitDef(afusNames[i]);
			if (d !is null)
			{
				afusBuilt += d.count;
			}
		}
		if (afusBuilt >= 1)
		{
			GenericHelpers::LogUtil("[TECH] Skip recycle: Advanced Fusion present (total=" + afusBuilt + ")", 2);
			return null;
		}

		// Gate reclaim of the T1 bot lab until we have sufficient T1 construction bots on the field
		int t1CtorCountForRecycle = UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllT1BotConstructors());
		// Additional gate: do NOT reclaim if metal income is healthy (> 45)
		if (Factory::IsT2LabBuildQueued() && aiEconomyMgr.metal.current < 100.0f && t1CtorCountForRecycle >= 3 && metalIncome <= 45.0f)
		{
			// Reclaim T1 Lab if T2 lab is queued and metal stored is low
			if (Factory::primaryT1BotLab !is null)
			{
				// AIFloat3 labPos = Factory::primaryT1BotLab.GetPos(ai.frame);
				IUnitTask @t = aiBuilderMgr.Enqueue(
					TaskB::Reclaim(Task::Priority::NORMAL, Factory::primaryT1BotLab, 180 * SECOND));
				if (t !is null)
				{
					GenericHelpers::LogUtil("[TECH] Reclaiming primary T1 bot lab (t1CtorCount=" + t1CtorCountForRecycle + ")", 2);
					// Proactively clear the primary pointer to avoid later references during reclaim
					@Factory::primaryT1BotLab = null;
					return t;
				}
			}
		}

		// If an Advanced Fusion OR a Nuclear Silo is queued and metal reserves are low, consider reclaiming the primary T2 bot lab
		// New rule: Only proceed if there is enough free metal storage to hold the lab's metal cost (to avoid wasting reclaim).
		if ((Builder::IsAdvancedFusionBuildQueued() || Builder::IsNukeSiloBuildQueued()) && aiEconomyMgr.metal.current < 600.0f)
		{
			if (Factory::primaryT2BotLab !is null)
			{
				const CCircuitDef @labDef = Factory::primaryT2BotLab.circuitDef;
				float labCostM = (labDef is null ? 0.0f : labDef.costM);
				const SResourceInfo @metal = aiEconomyMgr.metal;
				float freeStorage = ((metal is null) ? 0.0f : (metal.storage - metal.current));

				if (labCostM > 0.0f && freeStorage >= labCostM)
				{
					IUnitTask @t2 = aiBuilderMgr.Enqueue(
						TaskB::Reclaim(Task::Priority::NORMAL, Factory::primaryT2BotLab, 180 * SECOND));
					if (t2 !is null)
					{
						GenericHelpers::LogUtil("[TECH] Reclaiming primary T2 bot lab for AFUS/NUKE (labCostM=" + labCostM + ", freeStorage=" + freeStorage + ")", 2);
						// Proactively clear the primary pointer to avoid later references during reclaim
						@Factory::primaryT2BotLab = null;
						return t2;
					}
				}
				else
				{
					GenericHelpers::LogUtil(
						"[TECH] Suppress reclaim of T2 bot lab: insufficient free metal storage (labCostM=" + labCostM + ", freeStorage=" + freeStorage + ")",
						2);
				}
			}
		}

		return null;
	}

	/******************************************************************************

	ROLE CONFIGURATION

	******************************************************************************/

	bool Tech_RoleMatch(AiRole preferredMapRole, const string&in side, const AIFloat3& in pos, const string&in defaultStartFactory)
	{
		GenericHelpers::LogUtil("[TECH] Enter Tech_RoleMatch", 4);
		bool match = false;

		if (preferredMapRole == AiRole::TECH)
			match = true;

		if (match)
		{
			GenericHelpers::LogUtil("[RoleMatch] TECH", 2);
		}

		return match;
	}

	// Rules moved to EconomyHelpers

	void Register()
	{
		GenericHelpers::LogUtil("[TECH] Enter Register", 4);
		if (RoleConfigs::Get(AiRole::TECH) !is null)
			return;
		RoleConfig @cfg = RoleConfig(AiRole::TECH, cast<MainUpdateDelegate @>(@Tech_MainUpdate));

		@cfg.InitHandler = cast<InitDelegate @>(@Tech_Init);

		@cfg.AiIsSwitchTimeHandler = cast<AiIsSwitchTimeDelegate @>(@Tech_AiIsSwitchTime);
		@cfg.AiIsSwitchAllowedHandler = cast<AiIsSwitchAllowedDelegate @>(@Tech_AiIsSwitchAllowed);
		@cfg.MakeSwitchIntervalHandler = cast<MakeSwitchIntervalDelegate @>(@Tech_MakeSwitchInterval);

		@cfg.BuilderAiUnitAdded = cast<AiUnitAddedDelegate @>(@Tech_BuilderAiUnitAdded);
		@cfg.BuilderAiUnitRemoved = cast<AiUnitRemovedDelegate @>(@Tech_BuilderAiUnitRemoved);

		@cfg.FactoryAiMakeTaskHandler = cast<AiMakeTaskDelegate @>(@Tech_FactoryAiMakeTask);
		@cfg.FactoryAiUnitAdded = cast<AiUnitAddedDelegate @>(@Tech_FactoryAiUnitAdded);
		@cfg.FactoryAiUnitRemoved = cast<AiUnitRemovedDelegate @>(@Tech_FactoryAiUnitRemoved);

		@cfg.BuilderAiMakeTaskHandler = cast<AiMakeTaskDelegate @>(@Tech_BuilderAiMakeTask);
		@cfg.BuilderAiTaskAddedHandler = cast<AiTaskAddedDelegate @>(@Tech_BuilderAiTaskAdded);
		@cfg.BuilderAiTaskRemovedHandler = cast<AiTaskRemovedDelegate @>(@Tech_BuilderAiTaskRemoved);

		@cfg.MilitaryAiMakeTaskHandler = cast<AiMakeTaskDelegate @>(@Tech_MilitaryAiMakeTask);

		@cfg.SelectFactoryHandler = cast<SelectFactoryDelegate @>(@Tech_SelectFactoryHandler);
		@cfg.EconomyUpdateHandler = cast<EconomyUpdateDelegate @>(@Tech_EconomyUpdate);

		@cfg.AiMakeDefenceHandler = cast<AiMakeDefence @>(@Tech_AiMakeDefence);

		@cfg.RoleMatchHandler = cast<RoleMatchDelegate @>(@Tech_RoleMatch);

		RoleConfigs::Register(cfg);
	}

}