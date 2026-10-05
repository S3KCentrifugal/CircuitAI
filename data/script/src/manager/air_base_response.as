#include "air_operations.as"
#include "../helpers/air_home.as"

// AIR's immediate reserve: shared tasks and target identities, no per-frame orders.
namespace AirBaseResponse {
    array<CRouteTask@> groups(3);
    array<int> targets(3, -1);
    array<AIFloat3> aims(3);
    dictionary members;
    int updated = -100000, lastSeen = -100000;
    bool contact = false;
    bool Active() { return AirEconomy::Active() && Global::RoleSettings::Air::BaseResponseEnabled; }
    bool Emergency() { return Active() && contact; }
    bool InBase(const AIFloat3 &in p) {
        for (uint i = 0; i < WallHelpers::starts.length(); ++i)
            if (AirMath::BaseContact(MapHelpers::SqDist(p, WallHelpers::starts[i]), Global::RoleSettings::Air::BaseResponseRadius)) return true;
        return false;
    }
    bool Free(CCircuitUnit@ u) {
        if (u is null || u.GetBuildProgress() < 1.0f || !u.circuitDef.IsAbleToFly()
            || u.circuitDef.GetBuildSpeed() > 0 || Team::Ferry::IsFerryTransport(u.circuitDef)
            || u.id == Team::Ferry::buildingId || AirOperations::Committed(u.id)
            || u.GetRulesParam("carrier_host_unit_id", -1) >= 0) return false;
        IUnitTask@ task = u.task;
        if (task is null) return true;
        if (task.GetType() == int(Task::Type::PLAYER) || task.GetType() == int(Task::Type::RETREAT)
            || task.IsExternalControlled()) return false;
        IFighterTask@ fight = cast<IFighterTask>(task);
        if (fight !is null && fight.GetFightType() == int(Task::FightType::FERRY)) return false;
        CAirWaveTask@ wave = cast<CAirWaveTask>(task);
        return wave is null || wave.IsDead(); // offensive commitments are never recalled
    }
    int Kind(const CCircuitDef@ d) {
        if (AirScreen::IsFighter(d)) return 2;
        if (!d.HasSurfToLand()) return -1;
        return AirWaves::IsWaveBomber(d) ? 1 : 0;
    }
    bool Heavy(const CCircuitDef@ d) {
        // Same authoritative gantry-exclusive roster as the offensive wave policy.
        return d !is null && AirOperations::groundHeavyDefs.find(d.GetName()) >= 0;
    }
    void Forget(int id) {
        const string key = "" + id;
        AirRaids::held.delete(key); AirRaids::joining.delete(key);
        AirWaves::heldBombers.delete(key); AirWaves::heldFighters.delete(key);
        AirProduction::home.delete(key); AirScreen::Removed(id);
    }
    IUnitTask@ TaskFor(CCircuitUnit@ u) {
        if (!Active() || !contact || !Free(u)) return null;
        const int kind = Kind(u.circuitDef);
        if (kind < 0 || groups[kind] is null || groups[kind].IsDead()) return null;
        // Let the existing interceptor controller answer simultaneous aircraft.
        if (kind == 2 && AirScreen::IntrusionCost() > 0) return null;
        u.SetIdleMode(0); u.SetFireState(2);
        members.set("" + u.id, kind);
        Forget(u.id);
        return groups[kind];
    }
    void ClearGroup(int kind) {
        CRouteTask@ old = groups[kind];
        @groups[kind] = null; targets[kind] = -1;
        if (old !is null && !old.IsDead()) old.Abort();
    }
    void Reset() {
        contact = false;
        for (int i = 0; i < 3; ++i) ClearGroup(i);
        members.deleteAll(); updated = -100000; lastSeen = -100000;
    }
    void Tick() {
        if (!Active() || ai.frame-updated < SECOND) return;
        updated = ai.frame;
        AirHome::Refresh(); AirOperations::InitHeavyRoster();
        array<int> selected(2, -1);
        array<float> scores(2, -1.0f);
        const int contacts = aiBattle.GetGroundContactCount();
        for (int i = 0; i < contacts; ++i) {
            const AIFloat3 p = aiBattle.GetGroundContactPos(i);
            if (!InBase(p)) continue;
            const CCircuitDef@ d = ai.GetCircuitDef(aiBattle.GetGroundContactDefId(i));
            if (d is null) continue;
            const int id = aiBattle.GetGroundContactId(i);
            const float score = (d.HasSurfToLand() || d.HasSurfToAir() ? 100000.0f : 0.0f)
                + (d.GetBuildSpeed() > 0 ? 50000.0f : 0.0f) + d.costM;
            for (int k = 0; k < 2; ++k) {
                if (!AirMath::DefensiveBomberTarget(k == 1, d.IsMobile(), Heavy(d))) continue;
                // Stable targets avoid churning orders as a formation moves.
                const float rank = score + (targets[k] == id ? 25000.0f : 0.0f);
                if (rank > scores[k]) { scores[k] = rank; selected[k] = i; }
            }
        }
        const bool previous = contact;
        contact = selected[0] >= 0;
        if (contact) lastSeen = ai.frame;
        if (contact != previous) GenericHelpers::LogUtil("[AIR][BaseResponse] contact=" + contact, 1);
        if (!contact && ai.frame-lastSeen >= AiMax(1, Global::RoleSettings::Air::BaseResponseSearchSeconds)*SECOND) {
            for (int k = 0; k < 3; ++k) ClearGroup(k);
            members.deleteAll(); return;
        }
        for (int k = 0; k < 3; ++k) {
            if (k == 2 && AirScreen::IntrusionCost() > 0) { ClearGroup(k); continue; }
            const int index = selected[k == 2 ? 0 : k];
            const int next = index < 0 ? -1 : aiBattle.GetGroundContactId(index);
            if (index >= 0) aims[k] = aiBattle.GetGroundContactPos(index);
            if (k == 1 && contact && index < 0) { ClearGroup(k); continue; }
            if (groups[k] is null || groups[k].IsDead()) {
                if (index < 0) continue;
                @groups[k] = cast<CRouteTask>(aiMilitaryMgr.Enqueue(TaskF::Route()));
                if (groups[k] is null) continue;
                groups[k].SetAirControl(true); groups[k].SetTraversal(true, 192.0f, true);
                groups[k].SetPatrol(true); // retry an empty queue without landing
                targets[k] = -2;
            }
            if (next != targets[k]) {
                array<AIFloat3> route = {AirScreen::Clamp(aims[k])};
                groups[k].SetAirTarget(k == 2 ? -1 : next); groups[k].SetRoute(route);
                targets[k] = next;
                GenericHelpers::LogUtil("[AIR][BaseResponse] group=" + k + " target=" + next, 1);
            }
        }
        array<string>@ enrolled = members.getKeys();
        for (uint i = 0; i < enrolled.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(parseInt(enrolled[i])); int k = -1;
            if (!members.get(enrolled[i], k) || k < 0 || k >= 3 || u is null || u.task !is groups[k]) members.delete(enrolled[i]);
            else if (!Free(u)) Invariants::Violation("INV-140", enrolled[i], "protected aircraft acquired by base response");
        }
        if (!contact) return;
        array<Id>@ ids = ai.GetOwnedUnitIds();
        int joined = 0;
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (members.exists("" + ids[i]) || !Free(u)) continue;
            IUnitTask@ task = TaskFor(u);
            if (task is null) continue;
            if (aiMilitaryMgr.TransferUnit(u, task)) ++joined;
            else { members.delete("" + ids[i]); Invariants::Violation("INV-140", ""+ids[i], "base response transfer failed"); }
        }
        if (joined > 0) GenericHelpers::LogUtil("[AIR][BaseResponse] dispatched=" + joined + " total=" + members.getSize(), 1);
    }
    const array<string> lethal = {"armkam", "armbrawl", "corape", "legmos", "legstronghold", "corshad"};
    int Deficit() {
        int ready = 0, frames = 0, pending = 0;
        array<Id>@ ids = ai.GetOwnedUnitIds();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || lethal.find(u.circuitDef.GetName()) < 0) continue;
            if (u.GetBuildProgress() < 1.0f) ++frames;
            else if (Free(u)) ++ready;
        }
        for (uint i = 0; i < lethal.length(); ++i) {
            CCircuitDef@ d = ai.GetCircuitDef(lethal[i]);
            if (d !is null) pending += aiFactoryMgr.GetPendingRecruitCount(d);
        }
        return AirMath::DefenceDeficit(Global::RoleSettings::Air::BaseResponseGunships, ready, frames, pending);
    }
    IUnitTask@ Produce(CCircuitUnit@ plant) {
        if (!Emergency()) return null;
        const string side = UnitHelpers::GetSideForUnitName(plant.circuitDef.GetName());
        const bool advanced = UnitHelpers::IsT2AircraftPlant(plant.circuitDef.GetName());
        if (!advanced && !UnitHelpers::IsT1AircraftPlant(plant.circuitDef.GetName())) return null;
        // Never substitute an EMP-only army for damage. A small support group
        // follows each damage order at Cortex T1; both are sent immediately.
        string name = side == "armada" ? (advanced ? "armbrawl" : "armkam")
            : side == "cortex" ? (advanced ? "corape" : "corshad") : (advanced ? "legstronghold" : "legmos");
        const int missing = Deficit();
        if (!advanced && side == "cortex" && Global::RoleSettings::Air::BaseResponseGunships-missing > 0) {
            const int support = AiMin(Global::RoleSettings::Air::BaseResponseEmpSupport,
                1+(Global::RoleSettings::Air::BaseResponseGunships-missing)/3);
            IUnitTask@ supportTask = AirProduction::Recruit(plant, "corbw", support, "base.emp", Task::Priority::HIGH);
            if (supportTask !is null) return supportTask;
        }
        if (missing > 0) {
            CCircuitDef@ def = ai.GetCircuitDef(name);
            IUnitTask@ task = AirProduction::Recruit(plant, name, AirProduction::Projected(def)+1,
                "base.defence", Task::Priority::HIGH);
            if (task !is null) return task;
        }
        if (!advanced && side == "cortex")
            return AirProduction::Recruit(plant, "corbw", Global::RoleSettings::Air::BaseResponseEmpSupport,
                "base.emp", Task::Priority::HIGH);
        return null;
    }
}
