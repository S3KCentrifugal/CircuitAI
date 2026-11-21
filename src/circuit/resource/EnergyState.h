#pragma once
// D-493: one definition of "energy is low" for every caller (the commander's
// assist break and emergency solar, TECH's surplus seats). Each caller keeps
// its own threshold; the computation is shared so they cannot drift apart.
// Engine free; CEconomyManager::GetEnergyState fills it. Tests:
// tests/commander_task_origin_test.cpp.

namespace circuit::economy {

struct EnergyState {
	bool stalling = false;
	float current = 0.f;
	float storage = 0.f;
	float income = 0.f;
	float pull = 0.f;
};

// The bank as a share of storage; 0 without storage.
inline float BankShare(const EnergyState& s)
{
	return (s.storage > 0.f) ? s.current / s.storage : 0.f;
}

// Stalling, or the bank under `share` of storage (share <= 0: stalling only).
inline bool EnergyLow(const EnergyState& s, float share)
{
	return s.stalling || (share > 0.f && s.storage > 0.f && s.current < s.storage * share);
}

// New emergency solar offers only. Existing construction keeps its owner.
// A positive hard ceiling takes precedence over the stall exception.
inline bool EmergencySolarAllowed(const EnergyState& s, float triggerIncome,
        float hardIncome, bool allowStall, float storageShare)
{
	return triggerIncome > 0.f && (hardIncome <= 0.f || s.income < hardIncome)
		&& (s.income < triggerIncome || (allowStall && s.stalling))
		&& s.storage > 0.f && EnergyLow(s, storageShare);
}

} // namespace circuit::economy
