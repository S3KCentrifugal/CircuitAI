// TECH defence crew (owner 2026-11-23): TECH's own T2 constructor for the first antinuke and the
// Pinpointers. Played All That Smolders 11-23: TECH kept 3 T2 constructors, two of them dedicated mex
// upgraders (EarlyMexUpgraders, still upgrading allies at 18:00) and one that the chain's fusion, then a
// Pinpointer, then the growth AFUS seat took for good; the antinuke was ordered at 19:27.
// TECH now keeps 4 (MinimumT2ConstructorBots / T2BotConstructorCap / DonationKeepT2Constructors): the
// first kept T2 land constructor born once the mex upgraders are staffed is claimed here
// (donation.as OnConstructorBuilt), the next keeps the general T2 work. It is never donated, never a mex
// upgrader, never a growth seat. Its work, in order: the first antinuke (its frame, or its order at any
// distance from the pad), an extra antinuke per scouted enemy silo, Pinpointers when wanted, else a
// short assist of anything going up near the antinuke pad (the timeout brings it back to ask). A lost
// crew is replaced by the next kept constructor the lab builds.
namespace TechDefenceCrew {
    int crewId = -1;

    bool On() {
        return Global::AISettings::Role == AiRole::TECH && Global::RoleSettings::Tech::DefenceCrewEnabled;
    }
    bool Owns(int id) { return crewId >= 0 && id == crewId; }

    bool Steered(IUnitTask@ t) {
        return t !is null && !t.IsDead() && (t.IsExternalControlled() || t.GetType() == int(Task::Type::PLAYER)
            || t.GetType() == int(Task::Type::RETREAT));
    }
    bool OwnedElsewhere(CCircuitUnit@ u) {
        const int id = u.id;
        return EarlyMexUpgraders::IsClaimed(id) || TechAirSquads::Owns(id) || LolCannon::IsCrew(id) || LrpcBlock::IsCrew(id)
            || TechAirFoundry::Owns(id) || TechFlank::Owns(u) || CommanderGroup::Owns(id) || TechGantryCrew::crewId == id
            || TechBuild::IsDedicatedAirCon(u) || Team::Ferry::IsGift(id) || Team::Recovery::IsGift(id);
    }
    void Claim(CCircuitUnit@ u, const string &in how) {
        crewId = u.id;
        GenericHelpers::LogUtil("[TECH][DefenceCrew] " + u.circuitDef.GetName() + " " + u.id + " is the antinuke/Pinpointer constructor ("
            + how + ")", 1);
    }
    void Release(const string &in why) {
        if (crewId < 0) return;
        GenericHelpers::LogUtil("[TECH][DefenceCrew] constructor " + crewId + " released: " + why, 1);
        crewId = -1;
    }

    // The crew's own build (antinuke or Pinpointer frame/order): never pulled off it
    bool OnOwnBuild(CCircuitUnit@ u) {
        IBuilderTask@ cur = (u.task is null) ? null : cast<IBuilderTask>(u.task);
        if (cur is null || cur.IsDead()) return false;
        if (cur.target !is null && cur.target.GetBuildProgress() >= 1.0f) return false;
        const CCircuitDef@ d = cur.target !is null ? cur.target.circuitDef : cur.buildDef;
        if (d is null) return false;
        const string n = d.GetName();
        return UnitHelpers::GetAllAntiNukes().find(n) >= 0 || TechPinpointers::Def() !is null && n == TechPinpointers::Def().GetName()
            || n == UnitHelpers::GetAdvEnergyConverterNameForSide(Global::AISettings::Side);
    }
    bool OnAssist(CCircuitUnit@ u) {
        IBuilderTask@ cur = (u.task is null) ? null : cast<IBuilderTask>(u.task);
        return cur !is null && !cur.IsDead() && Task::BuildType(cur.GetBuildType()) == Task::BuildType::REPAIR
            && cur.target !is null && cur.target.GetBuildProgress() < 1.0f;
    }

    // manager/builder.as AiMakeTask (TECH), after the mex upgraders
    IUnitTask@ Work(CCircuitUnit@ u) {
        if (!On() || u is null || u.circuitDef is null) return null;
        if (crewId >= 0 && ai.GetTeamUnit(crewId) is null) Release("lost");
        if (u.id != crewId) return null;
        if (OwnedElsewhere(u)) { Release("taken by another program"); return null; }
        if (Steered(u.task)) return null;
        if (OnOwnBuild(u)) return u.task;
        const int id = u.id;
        const float mi = Economy::GetMinMetalIncomeLast10s();
        const float ei = Economy::GetMinEnergyIncomeLast10s();
        // 1. the first antinuke: its frame, else its order (no distance gate for the crew)
        IUnitTask@ t = TechRules::FirstAntiNuke(u, mi, ei, true);
        if (t !is null) return t;
        @u = ai.GetTeamUnit(id); if (u is null) { Release("lost"); return null; }
        // 2. one more per scouted enemy silo
        @t = SiloAntiNukes::PeripheryWork(u, mi, ei, Global::RoleSettings::Tech::FirstAntiNukeMetalIncome,
            Global::RoleSettings::Tech::FirstAntiNukeEnergyIncome, Global::SiloAntiNukes::TechPeripheryMaxRadius,
            Global::SiloAntiNukes::TechCoreRadius);
        if (t !is null) return t;
        @u = ai.GetTeamUnit(id); if (u is null) { Release("lost"); return null; }
        // 3. Pinpointers when the team has artillery and too few
        if (TechPinpointers::wanted) {
            @t = TechPinpointers::Work(u);
            if (t !is null) return t;
            @u = ai.GetTeamUnit(id); if (u is null) { Release("lost"); return null; }
        }
        // 4. advanced converters while energy floats (a converter worker: the seat waivers apply)
        if (Global::RoleSettings::Tech::DefenceCrewConverters && TechChain::EnergyBankFloats() && !aiEconomyMgr.isEnergyStalling) {
            CCircuitDef@ conv = ai.GetCircuitDef(UnitHelpers::GetAdvEnergyConverterNameForSide(Global::AISettings::Side));
            if (conv !is null && u.circuitDef.CanBuild(conv)) {
                if (TechConverterAssist::OnConverter(u, conv) !is null) return u.task;
                TechBuild::LiftCapForRole(conv.GetName());
                @t = TechBuild::BuildByLayout(u, conv.GetName(), Task::BuildType::CONVERT);
                if (t !is null) return t;
                @u = ai.GetTeamUnit(id); if (u is null) { Release("lost"); return null; }
                @t = TechBuild::AssistNearestOf(u, conv.GetName());
                if (t !is null) return t;
            }
        }
        // 5. a short assist near the antinuke pad, or wait there; the timeout brings it back to ask
        if (OnAssist(u)) return u.task;
        AIFloat3 home = AIFloat3(-1, -1, -1);
        const int slot = Layout::ReserveAntiNuke();
        if (slot >= 0) home = aiTerrainMgr.GetReservationPos(slot);
        if (home.x < 0.0f) home = Global::Map::StartPos;
        CCircuitUnit@ target = aiBuilderMgr.FindUnfinishedNear(home, Global::RoleSettings::Tech::DefenceCrewAssistRadius, null);
        if (target !is null && TechEconomyMath::StructureAssistAllowed(target.circuitDef.IsMobile()) && EcoFlak::AssistanceAllowed(u, target)
            && aiTerrainMgr.CanReachAt(u, target.GetPos(ai.frame), u.circuitDef.GetBuildDistance()))
            return aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::NORMAL, target, Global::RoleSettings::Tech::DefenceCrewAssistSeconds * SECOND));
        return TechBuild::Wait(3 * SECOND);
    }

    // donation.as OnConstructorBuilt, for a T2 constructor TECH keeps: the first kept land one born once
    // the mex upgraders are staffed (or their phase is over) becomes the crew
    bool ClaimOnBuilt(CCircuitUnit@ u) {
        if (!On() || u is null || u.circuitDef is null) return false;
        if (crewId >= 0 && ai.GetTeamUnit(crewId) is null) Release("lost");
        if (crewId >= 0) return false;
        if (UnitHelpers::GetAllT2BotConstructors().find(u.circuitDef.GetName()) < 0) return false;
        if (EarlyMexUpgraders::On() && !EarlyMexUpgraders::done
            && int(EarlyMexUpgraders::claimed.length()) < EarlyMexUpgraders::Target()) return false;
        if (OwnedElsewhere(u)) return false;
        Claim(u, "kept after the mex upgraders");
        return true;
    }
}
