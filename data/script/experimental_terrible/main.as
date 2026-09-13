#include "../src/setup.as"
#include "../src/helpers/generic_helpers.as"
#include "../src/global.as"
#include "../src/maps.as"
#include "../src/types/strategy.as" // for StrategyUtil names when logging

namespace Main {

	// Weighted strategy configuration for HARD difficulty.
	// Values are likelihoods in [0.0, 1.0] for enabling a given strategy.
	// Adjust these to tune how often a strategy is chosen at game start.
	namespace StrategyWeights {
		float Tech_T2_RUSH = 0.85f;   // 85% chance
		float Tech_T3_RUSH = 0.35f;   // 35% chance
		float Tech_NUKE_RUSH = 0.25f; // 25% chance
	}

	// Decide a boolean from a probability using AiDice with two weights: off vs on.
	bool DecideEnabled(float probability) {
		// Clamp to [0,1]
		float p = AiMax(0.0f, AiMin(probability, 1.0f));
		// Build weights {off, on}
		array<float>@ w = array<float>(2);
		w[0] = 1.0f - p;
		w[1] = p;
		int idx = AiDice(w);
		return (idx == 1);
	}

	void ApplyTechStrategyWeights() {
		// Start fresh (no strategies), then enable per dice outcome
		Global::RoleSettings::Tech::StrategyMask = 0;

		if (DecideEnabled(StrategyWeights::Tech_T2_RUSH)) {
			Global::RoleSettings::Tech::EnableStrategy(Strategy::T2_RUSH);
		}
		if (DecideEnabled(StrategyWeights::Tech_T3_RUSH)) {
			Global::RoleSettings::Tech::EnableStrategy(Strategy::T3_RUSH);
		}
		if (DecideEnabled(StrategyWeights::Tech_NUKE_RUSH)) {
			Global::RoleSettings::Tech::EnableStrategy(Strategy::NUKE_RUSH);
		}

		GenericHelpers::LogUtil(
			"[Strategy] (HARD) Decided: Tech mask=" + Global::RoleSettings::Tech::StrategyMask +
			" (" + StrategyUtil::NamesFromMask(Global::RoleSettings::Tech::StrategyMask) + ")",
			2);
	}

	void AiMain()
	{
		GenericHelpers::LogUtil("Running AiMain()", 1);

		GenericHelpers::LogUtil("registerMaps", 1);
		Maps::registerMaps();

		// HARD difficulty strategy selection: decide per-weight which strategies to enable for the TECH role
		ApplyTechStrategyWeights();

		// Example of user-assigned custom attributes
		array<string> names = {Factory::armalab, Factory::coralab, Factory::armavp, Factory::coravp,
			Factory::armaap, Factory::coraap, Factory::armasy, Factory::corasy};
		for (uint i = 0; i < names.length(); ++i)
			Factory::userData[ai.GetCircuitDef(names[i]).id].attr |= Factory::Attr::T2;
		names = {Factory::armshltx, Factory::corgant, Factory::leggant};
		for (uint i = 0; i < names.length(); ++i)
			Factory::userData[ai.GetCircuitDef(names[i]).id].attr |= Factory::Attr::T3;

		ApplyProfileSettings();
	}

	void AiUpdate()  // SlowUpdate, every 30 frames with initial offset of skirmishAIId
	{
		if (Global::profileController !is null) {
			Global::profileController.MainUpdate();
		}
	}

	void AiLuaMessage(const string& in data)  // Spring.SendSkirmishAIMessage(teamID, msg) from unsynced lua
	{
		GenericHelpers::LogUtil("[AI][LuaMessage] ", 2);
	}

	//Use this to modify global.as and apply difficulty/profile settings
	void ApplyProfileSettings()
	{
	}

}  // namespace Main