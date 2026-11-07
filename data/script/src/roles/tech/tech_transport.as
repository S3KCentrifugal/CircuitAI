// D-315: transport demand is policy, definition compatibility is native.
namespace TechTransport {
    // UnitDefs are immutable for this AI's lifetime. Cache only definition
    // compatibility, never strategy, caps, cargo ownership or delivery state.
    dictionary compatibility;
    bool Compatible(const CCircuitDef@ carrier, const CCircuitDef@ cargo) {
        if (carrier is null || cargo is null) return false;
        const string key = carrier.GetName() + ":" + cargo.GetName();
        bool result = false;
        if (!compatibility.get(key, result)) {
            result = carrier.CanTransport(cargo);
            compatibility.set(key, result);
        }
        return result;
    }

    bool WantsCarrier(const CCircuitDef@ carrier) {
        if (Global::AISettings::Role != AiRole::TECH || carrier is null) return false;
        if (TechPlan::Choose() != "t3rush") return false;
        const string side = Global::AISettings::Side;
        CCircuitDef@ gantry = ai.GetCircuitDef(UnitHelpers::GetLandGantryForSide(side));
        if (gantry is null) return false;
        // Match the signature/late-heavy selection order, rather than finding
        // any hypothetically carryable unit in the gantry's whole build roster.
        if (!TechHeavyChoice::Late()) {
            CCircuitDef@ cargo = ai.GetCircuitDef(UnitHelpers::GetGantrySignatureUnitForSide(side));
            return cargo !is null && cargo.maxThisUnit > 0 && gantry.CanBuild(cargo) && Compatible(carrier, cargo);
        }
        array<string>@ candidates = TechHeavyChoice::Candidates(side);
        for (uint index = 0; index < candidates.length(); ++index) {
            CCircuitDef@ cargo = ai.GetCircuitDef(candidates[index]);
            if (cargo !is null && cargo.IsAvailable(ai.frame) && gantry.CanBuild(cargo))
                return Compatible(carrier, cargo);
        }
        return false;
    }
}
