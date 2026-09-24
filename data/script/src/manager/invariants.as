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
        // INV-010: no mobile combat unit under the plan's income gate (D-080)
        const string name = u.circuitDef.GetName();
        const bool builder = UnitHelpers::IsCommander(u.circuitDef) || UnitHelpers::GetConstructorTier(u.circuitDef) > 0 || UnitHelpers::IsAirConstructor(u.circuitDef)
            || UnitHelpers::GetAllRezBots().find(name) >= 0 || UnitHelpers::GetAllFastAssistBots().find(name) >= 0   // reclaimers and assist bots are build power, not combat
            || u.circuitDef.IsRoleAny(Unit::Role::TRANS.mask);   // D-093: the ferry's transport is logistics (played: armatlas and corvalk flagged)
        const float mi = Economy::GetMinMetalIncomeLast10s();
        if (!builder && mi < TechPlan::CombatGate())
            Violation("INV-010", u.circuitDef.GetName(), "combat unit " + u.circuitDef.GetName() + " " + u.id + " produced at +" + int(mi) + " metal under the gate " + int(TechPlan::CombatGate()));
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
    int t2LabSince = -1;
    int lastLabTurretDist = -2;
    int lastLabFacing = -2;       // D-096: INV-018's log on change
    int lastLabExitCount = -1;
    int noForwardSince = -1;
    int turretsOverSince = -1;    // D-097: INV-019
    int fusionFramesLast = 0;     // D-100: INV-021
    int ladderFloatSince = -1;
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

        // INV-011: past the objective the metal bank does not float while an
        // income step is unmet (D-080, the KI-415 promise)
        if (TechChain::LadderUnmet() && floating) {
            if (ladderFloatSince < 0) ladderFloatSince = ai.frame;
            else if (ai.frame - ladderFloatSince >= int(Global::RoleSettings::Tech::InvariantLadderFloatSeconds) * SECOND)
                Violation("INV-011", "ladder", "metal floating at " + int(cur) + " of " + int(stor) + " for " + int(Global::RoleSettings::Tech::InvariantLadderFloatSeconds) + " s with an income step of the plan unmet");
        } else ladderFloatSince = -1;

        // INV-013: a main cluster has a forward cluster planned within
        // InvariantForwardSeconds, unless every re-plan was used up (D-081)
        if (Layout::HasBox() && !Layout::ForwardPlanned() && !Layout::ForwardGivenUp()) {
            if (noForwardSince < 0) noForwardSince = ai.frame;
            else if (ai.frame - noForwardSince >= int(Global::RoleSettings::Tech::InvariantForwardSeconds) * SECOND)
                Violation("INV-013", "forward", "the main turret cluster has had no forward cluster planned for " + int(Global::RoleSettings::Tech::InvariantForwardSeconds) + " s");
        } else noForwardSince = -1;

        // INV-016: the advanced lab stands within a turret's reach (D-085)
        {
            CCircuitUnit@ t2 = Factory::primaryT2BotLab;
            if (t2 is null) t2LabSince = -1;
            else {
                if (t2LabSince < 0) t2LabSince = ai.frame;
                // D-099: a turret slot, planned or built, not a standing turret: the
                // owner's sequencing (D-098) lets the lab come first while build power is
                // short (played: the lab at 4.98 min, the first turret at 9.5 min, metal
                // spent throughout); where the lab stands is what this checks
                else if (ai.frame - t2LabSince >= int(Global::RoleSettings::Tech::InvariantLabReachSeconds) * SECOND
                    && aiTerrainMgr.CountGroupSlotsWithin(Layout::nanoGroup, t2.GetPos(ai.frame), Global::RoleSettings::Tech::ExpLabBuildPowerReach) == 0
                    && aiBuilderMgr.GetStaticBuildPowerNear(t2.GetPos(ai.frame), Global::RoleSettings::Tech::ExpLabBuildPowerReach) <= 0.0f)
                    Violation("INV-016", "" + t2.id, "the advanced lab " + t2.id + " has stood " + int(Global::RoleSettings::Tech::InvariantLabReachSeconds) + " s with no turret or turret slot within " + int(Global::RoleSettings::Tech::ExpLabBuildPowerReach));
                // D-088 (owner's ask): the distance from the advanced lab to the nearest
                // construction turret, logged when it changes; INV-017 when not flush
                CCircuitDef@ nano = ai.GetCircuitDef(UnitHelpers::GetT1NanoNameForSide(Global::AISettings::Side));
                CCircuitUnit@ n = (nano is null) ? null : aiBuilderMgr.FindOwnNear(t2.GetPos(ai.frame), 3000.0f, nano);
                const int d = (n is null) ? -1 : int(sqrt(MapHelpers::SqDist(n.GetPos(ai.frame), t2.GetPos(ai.frame))));
                if (d != lastLabTurretDist && (d < 0 || lastLabTurretDist < 0 || abs(d - lastLabTurretDist) >= 16)) {
                    lastLabTurretDist = d;
                    GenericHelpers::LogUtil("[Layout] advanced lab " + t2.id + ": nearest construction turret " + ((d < 0) ? "none" : ("" + d + " elmos"))
                        + ((d >= 0 && d <= int(Global::RoleSettings::Tech::LayoutLabFlushElmos)) ? " (flush)" : " (not flush)"), 1);
                }
                if (ai.frame - t2LabSince >= int(Global::RoleSettings::Tech::InvariantLabReachSeconds) * SECOND && d > int(Global::RoleSettings::Tech::LayoutLabFlushElmos))
                    Violation("INV-017", "" + t2.id, "the advanced lab's nearest construction turret is " + d + " elmos away, not flush (" + int(Global::RoleSettings::Tech::LayoutLabFlushElmos) + ")");
                // INV-018 (D-096): the advanced lab faces the front and nothing of ours
                // stands in its exit lane, so what it makes walks out toward the enemy
                const int labF = aiTerrainMgr.GetBuildingFacing(t2);
                // D-098: the facing it was ordered with (the front then); never away from the front now
                const int planned = Layout::LabPlannedFacing();
                const int frontF = (planned >= 0) ? planned : Layout::LabFacing();
                const int inExit = aiTerrainMgr.CountStructuresInExit(t2);
                if (labF != lastLabFacing || inExit != lastLabExitCount) {
                    lastLabFacing = labF; lastLabExitCount = inExit;
                    GenericHelpers::LogUtil("[Layout] advanced lab " + t2.id + ": faces " + labF + ", the front " + frontF + ", "
                        + inExit + " structures in its exit lane", 1);
                }
                if (ai.frame - t2LabSince >= int(Global::RoleSettings::Tech::InvariantLabReachSeconds) * SECOND
                    && (labF != frontF || labF == (Layout::LabFacing() + 2) % 4 || inExit > 0))
                    Violation("INV-018", "" + t2.id, "the advanced lab faces " + labF + " (the front " + frontF + ") with " + inExit + " structures in its exit lane");
            }
        }

        // INV-019 (D-097): no more turret frames stand unfinished than
        // Layout::TurretsAllowed for InvariantTurretFlightSeconds (played: five
        // at once in the early game, the metal stalled)
        {
            CCircuitDef@ nd = ai.GetCircuitDef(UnitHelpers::GetT1NanoNameForSide(Global::AISettings::Side));
            const int frames = (nd is null) ? 0 : aiBuilderMgr.GetUnfinishedCount(nd);
            string why;
            // the slots, not what is left after the dear frames: a turret started
            // before the lab is not a violation once the lab starts (D-098)
            const int allowed = Layout::TurretSlots(why);
            if (frames > allowed) {
                if (turretsOverSince < 0) turretsOverSince = ai.frame;
                else if (ai.frame - turretsOverSince >= int(Global::RoleSettings::Tech::InvariantTurretFlightSeconds) * SECOND)
                    Violation("INV-019", "turrets", "" + frames + " turret frames under construction, " + allowed + " allowed (" + why + ")");
            } else turretsOverSince = -1;
        }

        // INV-021 (D-100): a fusion frame is not started while a mex of ours
        // within ChainMexFarRadius is still T1 with no upgrade under way
        {
            CCircuitDef@ fd = ai.GetCircuitDef(UnitHelpers::GetFusionNameForSide(Global::AISettings::Side));
            const int frames = (fd is null) ? 0 : aiBuilderMgr.GetUnfinishedCount(fd);
            // not while the metal floats (the fusion then goes ahead on purpose, D-100)
            if (frames > fusionFramesLast && Global::RoleSettings::Tech::ChainMohoRadius > 0.0f && !TechBuild::MetalFullLong()) {
                const AIFloat3 t1 = Economy::MexTracker::GetNearestNonUpgradedMexInRange(Global::Map::StartPos, Global::Map::StartPos,
                    Global::RoleSettings::Tech::ChainMohoRadius);
                if (t1.x >= 0.0f)
                    Violation("INV-021", "fusion", "a fusion frame started with a T1 mex at (" + int(t1.x) + ", " + int(t1.z) + ") not upgraded");
            }
            fusionFramesLast = frames;
        }

        // INV-015: a dear chain order does not wait for its first builder (D-084)
        if (TechChain::DearOrderPendingSeconds() >= Global::RoleSettings::Tech::InvariantDearOrderSeconds)
            Violation("INV-015", "dear", "a dear chain order has had no frame for " + int(Global::RoleSettings::Tech::InvariantDearOrderSeconds) + " s");

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
