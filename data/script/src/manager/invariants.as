#include "../global.as"
#include "../helpers/economy_helpers.as"
#include "../helpers/unit_helpers.as"
#include "lifecycle.as"
#include "layout.as"

// D-076: the invariants the TECH role promises, checked once a second in the
// game and written to the log as "[INVARIANT] INV-nnn ..." when broken. Every
// playtest check file forbids that line, so the benchmark loop is the
// regression suite; doc/invariants.md lists every id here and
// tools/knowledge/check_invariants.py keeps the two in step.
//
// Adding one: a Violation call with a new id, a row in doc/invariants.md, and
// the decision that introduced it names the invariant.
namespace Invariants {
    dictionary lastSaid;   // id|key -> frame last logged; one line a minute per subject

    void Violation(const string &in id, const string &in key, const string &in msg)
    {
        const string k = id + "|" + key;
        int64 last = -100000;
        lastSaid.get(k, last);
        if (ai.frame - int(last) < 60 * SECOND) return;
        lastSaid.set(k, int64(ai.frame));
        GenericHelpers::LogUtil("[INVARIANT] " + id + " " + msg, 1);
    }

    // INV-001: a retiring factory produces nothing. Called from the role's
    // unit-added hooks; a mobile unit appearing beside a retired factory is
    // the observable form of production continuing.
    void OnUnitAdded(CCircuitUnit@ u)
    {
        if (u is null || u.circuitDef is null || !u.circuitDef.IsMobile()) return;
        if (Lifecycle::RetiringNear(u.GetPos(ai.frame), Global::RoleSettings::Tech::InvariantFactoryRadius))
            Violation("INV-001", "" + u.id, "a retiring factory produced " + u.circuitDef.GetName() + " " + u.id);
    }

    // INV-003: the chain never skips a step whose frame is under construction.
    void ChainStepSkipped(const string &in key, int unfinished)
    {
        if (unfinished > 0)
            Violation("INV-003", key, "chain step " + key + " skipped while " + unfinished + " frame(s) of it are under construction");
    }

    int frameId = -1;
    int frameSince = 0;
    int floatSince = -1;
    int afusSince = -1;
    dictionary energyFrames;   // energy def name -> unfinished count last tick (INV-009)
    dictionary offSince;   // reclaim target id -> frame turrets were first seen off it (INV-008)

    void Tick()
    {
        // INV-002: a frame of ours under construction has build power on it
        // within InvariantFrameSeconds (the nearest frame to the base is the
        // one watched; a chain leaves none further out).
        CCircuitUnit@ f = aiBuilderMgr.FindUnfinishedNear(Layout::BaseCentre(), Global::RoleSettings::Tech::ChainAssistRadius, null);
        const bool frame = (f !is null && f.circuitDef !is null && !f.circuitDef.IsMobile());
        if (!frame) {
            frameId = -1;
        } else {
            const float bp = aiBuilderMgr.GetBuildPowerNear(f.GetPos(ai.frame), Global::RoleSettings::Tech::InvariantFrameRadius);
            if (f.id != frameId || bp > 0.0f) { frameId = f.id; frameSince = ai.frame; }
            else if (ai.frame - frameSince >= int(Global::RoleSettings::Tech::InvariantFrameSeconds) * SECOND)
                Violation("INV-002", "" + f.id, f.circuitDef.GetName() + " " + f.id + " under construction has had no build power within "
                    + int(Global::RoleSettings::Tech::InvariantFrameRadius) + " for " + int(Global::RoleSettings::Tech::InvariantFrameSeconds) + " s");
        }

        // INV-004: metal does not float while a structure is under
        // construction and static build power is under the income target
        // (the owner's rule, D-075).
        const float stor = aiEconomyMgr.metal.storage;
        const float cur = aiEconomyMgr.metal.current;
        const float mi = Economy::GetMinMetalIncomeLast10s();
        const float bp = aiBuilderMgr.GetStaticBuildPowerNear(Layout::BaseCentre(), Global::RoleSettings::Tech::EcoBuildPowerRadius);
        const float target = mi * Global::RoleSettings::Tech::PowerBuildPowerPerMetal;
        const bool floating = (stor > 0.0f) && (cur >= Global::RoleSettings::Tech::InvariantFloatPercent * stor);
        if (floating && frame && bp < target) {
            if (floatSince < 0) floatSince = ai.frame;
            else if (ai.frame - floatSince >= int(Global::RoleSettings::Tech::InvariantFloatSeconds) * SECOND)
                Violation("INV-004", "float", "metal floating at " + int(cur) + " of " + int(stor) + " for " + int(Global::RoleSettings::Tech::InvariantFloatSeconds)
                    + " s while " + f.circuitDef.GetName() + " is under construction and static build power " + int(bp) + " is under " + int(target));
        } else {
            floatSince = -1;
        }

        // INV-006: no wind, solar or advanced solar stands InvariantReclaimSeconds
        // after an advanced fusion does (the owner's rule, D-077).
        const string side = Global::AISettings::Side;
        CCircuitDef@ afus = ai.GetCircuitDef(UnitHelpers::GetAdvFusionNameForSide(side));
        if (afus !is null && afus.count - aiBuilderMgr.GetUnfinishedCount(afus) > 0) {
            if (afusSince < 0) afusSince = ai.frame;
            else if (ai.frame - afusSince >= int(Global::RoleSettings::Tech::InvariantReclaimSeconds) * SECOND) {
                int left = 0;
                array<string> names = { UnitHelpers::GetWindNameForSide(side), UnitHelpers::GetSolarNameForSide(side), UnitHelpers::GetAdvSolarNameForSide(side) };
                for (uint i = 0; i < names.length(); ++i) { CCircuitDef@ d = ai.GetCircuitDef(names[i]); if (d !is null) left += d.count; }
                if (left > 0) Violation("INV-006", "energy", left + " wind/solar/advanced-solar structure(s) still stand " + int(Global::RoleSettings::Tech::InvariantReclaimSeconds) + " s after the advanced fusion");
            }
        } else {
            afusSince = -1;
        }

        // INV-009: no energy structure is ordered while energy floats (the
        // owner's rule, D-079): a new energy frame appearing while it floats.
        {
            const bool floats = TechChain::EnergyFullSeconds() >= Global::RoleSettings::Tech::InvariantFloatOrderSeconds;   // long enough that the order was made while floating
            array<string> energy = { UnitHelpers::GetWindNameForSide(side), UnitHelpers::GetSolarNameForSide(side), UnitHelpers::GetAdvSolarNameForSide(side),
                                     UnitHelpers::GetFusionNameForSide(side), UnitHelpers::GetAdvFusionNameForSide(side) };
            for (uint i = 0; i < energy.length(); ++i) {
                CCircuitDef@ d = ai.GetCircuitDef(energy[i]);
                if (d is null) continue;
                const int now = aiBuilderMgr.GetUnfinishedCount(d);
                int64 before = 0; energyFrames.get(energy[i], before);
                if (now > int(before) && floats)
                    Violation("INV-009", energy[i], "a " + energy[i] + " frame appeared while " + TechChain::FloatWhy());
                energyFrames.set(energy[i], int64(now));
            }
        }

        // INV-008: every construction turret in range of a reclaim of ours is
        // on it (the owner's rule, D-078).
        {
            array<string>@ keys = TechBuild::reclaimTargets.getKeys();
            for (uint i = 0; keys !is null && i < keys.length(); ++i) {
                int64 at = 0; TechBuild::reclaimTargets.get(keys[i], at);
                const int id = int(parseInt(keys[i]));
                CCircuitUnit@ t = ai.GetTeamUnit(id);
                if (t is null || ai.frame - int(at) > 180 * SECOND) { TechBuild::reclaimTargets.delete(keys[i]); offSince.delete(keys[i]); continue; }
                const int off = aiBuilderMgr.TurretsOnReclaim(id, Global::RoleSettings::Tech::ReclaimTurretMargin, false);
                if (off <= 0) { offSince.delete(keys[i]); continue; }
                int64 since = 0;
                if (!offSince.get(keys[i], since)) { offSince.set(keys[i], int64(ai.frame)); continue; }
                if (ai.frame - int(since) >= int(Global::RoleSettings::Tech::InvariantReclaimJoinSeconds) * SECOND)
                    Violation("INV-008", keys[i], off + " turret(s) in range of the reclaim of " + t.circuitDef.GetName() + " " + id + " are not on it");
            }
        }
    }
}
