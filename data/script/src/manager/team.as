#include "../global.as"
#include "../helpers/unit_helpers.as"
#include "../helpers/generic_helpers.as"

namespace Team {
    // Count of T2 constructors ever produced by TECH role (bots/vehicles; include T2 air explicitly)
    int T2CtorEverBuilt = 0;
    // Ensure we donate only once per game
    bool DonatedThird = false;

    // Return true if the def represents a T2 constructor (land or air)
    bool IsT2Constructor(const CCircuitDef @d) {
        if (d is null) return false;
        // Tier via helper (bots/vehicles)
        int tier = UnitHelpers::GetConstructorTier(d);
        if (tier == 2) return true;
        // Air constructors: infer T2 by explicit names
        const string n = d.GetName();
        // T2 air constructors (BAR): armaca/coraca/legaca
        if (UnitHelpers::IsAirConstructor(d)) {
            if (n == "armaca" || n == "coraca" || n == "legaca") return true;
        }
        return false;
    }

    // Attempt to donate a unit to the lead team; logs and guards
    void TryDonate(CCircuitUnit @u) {
        if (u is null) return;
        const int leader = ai.GetLeadTeamId();
        if (ai.teamId == leader) {
            GenericHelpers::LogUtil("[Team] We are the leader team; skip donation for unit id=" + u.id, 3);
            return; // no-op when this AI is the leader
        }

        array<CCircuitUnit @> give(1);
        @give[0] = u; // valid handle this frame
        ai.GiveUnits(give, leader);
        GenericHelpers::LogUtil("[Team] Transferred unit id=" + u.id + " to team " + leader, 2);
    }

    void CheckDonation(CCircuitUnit @unit) {
        if (unit is null) return;
        const CCircuitDef @d = unit.circuitDef;
        if (d is null) return;

        if (IsT2Constructor(d)) {
            // Assuming this is called from Tech_BuilderAiUnitAdded where we might want to disable assist
            // But disabling assist is factory manager logic.
            // The original code did: aiFactoryMgr.isAssistRequired = false;
            // We will leave that side effect in the caller or handle it here if we can access aiFactoryMgr.
            // Since aiFactoryMgr is likely a global or member of the main script class, we might not have access here easily without passing it.
            // However, for now, we will just handle the donation logic.
            
            T2CtorEverBuilt += 1;
            GenericHelpers::LogUtil("[Team] T2 constructor observed (" + d.GetName() + ") count=" + T2CtorEverBuilt + " id=" + unit.id, 3);

            if (!DonatedThird && T2CtorEverBuilt == 3) {
                DonatedThird = true; // lock before attempt to avoid re-entry
                GenericHelpers::LogUtil("[Team] Triggering donation of 3rd T2 constructor (id=" + unit.id + ")", 2);
                TryDonate(unit);
            }
        }
    }
}
