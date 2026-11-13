// Early T2 mex upgraders (owner, 2026-11-13). Every role and faction: the first T2 factory we finish
// builds 1-2 T2 constructors ahead of its normal production (EarlyMexUpgraders::FactoryMakeTask), and
// those constructors only upgrade our own T1 mexes (Economy::MexTracker, nearest first, reachable and
// safe: IsMexSpotSafe reads the threat map and enemy porc, ghosts too) or assist a mex upgrade.
// They go back to normal duty once no owned T1 mex is left that is safe to upgrade (all upgraded, or
// the rest sit under enemy porc) for EarlyMexUpgradersReleaseSeconds; after that the phase is over
// and no more are claimed or built.
// Claimed: a T2 constructor at its first ask for work (fresh from a factory, so nothing is pulled off
// a job), not owned by another program (lolcannon / LRPC crew, FRONT commander group, tactical,
// agitator counter, catalyst trade, TECH air foundry or flank, TECH's D-107 air constructors).
namespace EarlyMexUpgraders {
    array<int> claimed;          // dedicated constructors
    array<int> asked;            // T2 constructors already judged at their first ask
    array<IUnitTask@> ours;      // upgrades our dedicated constructors started (to assist)
    int idleSince = -1;          // first frame no safe target was found (-1: one was)
    bool done = false;           // phase over: every owned T1 mex upgraded or unsafe
    IUnitTask@ recruit = null;   // our factory order in flight
    int recruits = 0;
    int holdUntil = -1;
    int lastLog = -100000;
    int firstT2Frame = -1;       // first T2 factory order of ours (for the log)

    bool On() { return Global::RoleSettings::EarlyMexUpgraders; }

    bool IsT2Constructor(CCircuitUnit@ u) {
        return u !is null && u.circuitDef !is null && u.circuitDef.IsMobile()
            && !UnitHelpers::IsCommander(u.circuitDef) && UnitHelpers::GetConstructorTier(u.circuitDef) == 2;
    }

    bool IsAir(const string &in name) {
        return UnitHelpers::GetAllT2AirConstructors().find(name) >= 0;
    }

    bool IsClaimed(int id) { return claimed.find(id) >= 0; }

    // Owned by another program: never claimed, and a claimed one is let go
    bool OwnedElsewhere(CCircuitUnit@ u) {
        const int id = u.id;
        if (LolCannon::IsCrew(id) || LrpcBlock::IsCrew(id) || CommanderGroup::Owns(id) || TechAirFoundry::Owns(id)) return true;
        if (FrontAgitatorCounter::Owns(u) || FrontTactical::Owns(u) || TechFlank::Owns(u)) return true;
        if (Team::CatalystTrade::IsGift(id) || Team::CatalystTrade::IsTraded(id)) return true;
        if (Team::Ferry::IsGift(id) || Team::Recovery::IsGift(id)) return true;
        // TECH's first two T2 air constructors are dedicated to converters and fusions (D-107)
        if (Global::AISettings::Role == AiRole::TECH && IsAir(u.circuitDef.GetName())) return true;
        if ((Builder::primaryT2AirConstructor !is null && Builder::primaryT2AirConstructor.id == id)
            || (Builder::secondaryT2AirConstructor !is null && Builder::secondaryT2AirConstructor.id == id)) return true;
        IUnitTask@ t = u.task;
        if (t !is null && !t.IsDead() && (t.IsExternalControlled() || t.GetType() == int(Task::Type::PLAYER)
            || t.GetType() == int(Task::Type::RETREAT))) return true;
        return false;
    }

    // Owned T1 mexes not upgraded and not being upgraded (no safety test: the factory's view)
    int OpenCount() {
        int n = 0;
        for (uint i = 0; i < Economy::MexTracker::myMexes.length(); ++i)
            if (!Economy::MexTracker::myMexes[i].isUpgraded && !Economy::MexTracker::myMexes[i].isUpgradeInProgress) n++;
        return n;
    }
    int UpgradedCount() {
        int n = 0;
        for (uint i = 0; i < Economy::MexTracker::myMexes.length(); ++i)
            if (Economy::MexTracker::myMexes[i].isUpgraded) n++;
        return n;
    }

    int Target() {
        if (done) return 0;
        const int open = OpenCount();
        if (open <= 0) return 0;
        return open >= Global::RoleSettings::EarlyMexUpgradersSecondAt ? Global::RoleSettings::EarlyMexUpgradersMax : 1;
    }

    void Status(const string &in why) {
        GenericHelpers::LogUtil("[MexUpT2] " + why + ": owned mexes " + Economy::MexTracker::myMexes.length()
            + ", upgraded " + UpgradedCount() + ", open " + OpenCount() + ", dedicated " + claimed.length()
            + (done ? " (phase over)" : ""), 1);
    }

    // Periodic summary for the before/after measure; also runs with the program off
    void Tick() {
        if (ai.frame - lastLog < Global::RoleSettings::EarlyMexUpgradersLogSeconds * SECOND) return;
        lastLog = ai.frame;
        if (Economy::MexTracker::myMexes.length() == 0) return;
        Status("status");
    }

    void Release(int id, const string &in why) {
        const int i = claimed.find(id);
        if (i < 0) return;
        claimed.removeAt(i);
        GenericHelpers::LogUtil("[MexUpT2] constructor " + id + " back to normal duty: " + why, 1);
    }

    CCircuitDef@ Moho(CCircuitUnit@ u) {
        CCircuitDef@ d = ai.GetCircuitDef(UnitHelpers::GetT2MexNameForSide(UnitHelpers::GetSideForUnitName(u.circuitDef.GetName())));
        if (d is null || !d.IsAvailable(ai.frame)) return null;
        if (d.maxThisUnit >= 0 && d.count >= d.maxThisUnit) return null;
        if (!u.circuitDef.CanBuild(d)) return null;
        return d;
    }

    // A live upgrade (ours first, then an unassigned queued one) this constructor can assist
    IUnitTask@ Assist(CCircuitUnit@ u) {
        for (int i = int(ours.length()) - 1; i >= 0; --i) {
            if (ours[i] is null || ours[i].IsDead()) { ours.removeAt(i); continue; }
        }
        IUnitTask@ best = null;
        float bestSq = 3.4e+38f;
        const AIFloat3 at = u.GetPos(ai.frame);
        for (uint i = 0; i < ours.length(); ++i) {
            IBuilderTask@ b = cast<IBuilderTask>(ours[i]);
            if (b is null) continue;
            const float d = MapHelpers::SqDist(at, b.GetBuildPos());
            if (d < bestSq) { bestSq = d; @best = ours[i]; }
        }
        if (best !is null) return best;
        return aiBuilderMgr.FindQueuedTask(u, int(Task::BuildType::MEXUP));
    }

    // manager/builder.as AiMakeTask, first: work for a dedicated constructor (or a claim of a fresh one).
    // null: not ours, or nothing to upgrade right now (the caller's providers give it normal work).
    // Sets keep when the constructor should stay on what it has (AiMakeTask returns null).
    IUnitTask@ Work(CCircuitUnit@ u, bool &out keep) {
        keep = false;
        if (!On() || !IsT2Constructor(u)) return null;
        if (!IsClaimed(u.id)) {
            if (asked.find(u.id) >= 0) return null;
            asked.insertLast(u.id);
            if (done || OwnedElsewhere(u) || int(claimed.length()) >= Target()) return null;
            claimed.insertLast(u.id);
            GenericHelpers::LogUtil("[MexUpT2] " + u.circuitDef.GetName() + " " + u.id + " dedicated to mex upgrades ("
                + claimed.length() + " of " + Target() + ")", 1);
        }
        if (OwnedElsewhere(u)) { Release(u.id, "taken by another program"); return null; }
        // already on an upgrade: stay
        IBuilderTask@ cur = (u.task is null) ? null : cast<IBuilderTask>(u.task);
        if (cur !is null && !cur.IsDead() && Task::BuildType(cur.GetBuildType()) == Task::BuildType::MEXUP) {
            idleSince = -1;
            keep = true;
            return null;
        }
        CCircuitDef@ moho = Moho(u);
        AIFloat3 spot(-1, -1, -1);
        if (moho !is null)
            spot = Economy::MexTracker::GetNearestNonUpgradedMexInRange(u.GetPos(ai.frame), Global::Map::StartPos,
                100000.0f, u, moho);
        if (spot.x >= 0.0f) {
            idleSince = -1;
            IUnitTask@ t = aiBuilderMgr.Enqueue(TaskB::Spot(Task::BuildType::MEXUP, Task::Priority::NOW, moho, spot, -1));
            if (t !is null) {
                ours.insertLast(t);
                GenericHelpers::LogUtil("[MexUpT2] " + u.circuitDef.GetName() + " " + u.id + " upgrades ("
                    + int(spot.x) + "," + int(spot.z) + "), open " + OpenCount(), 1);
                return t;
            }
        }
        IUnitTask@ help = Assist(u);
        if (help !is null) {
            idleSince = -1;
            if (help is u.task) { keep = true; return null; }
            GenericHelpers::LogUtil("[MexUpT2] " + u.circuitDef.GetName() + " " + u.id + " assists a mex upgrade", 1);
            return help;
        }
        // nothing safe to upgrade: normal duty meanwhile; for good after the release delay
        if (idleSince < 0) idleSince = ai.frame;
        if (ai.frame - idleSince >= Global::RoleSettings::EarlyMexUpgradersReleaseSeconds * SECOND) {
            done = true;
            Status("phase over, no owned T1 mex left that is safe to upgrade");
            while (claimed.length() > 0) Release(claimed[0], "no safe T1 mex left");
        }
        return null;
    }

    void UnitRemoved(CCircuitUnit@ u) {
        if (u is null) return;
        const int i = claimed.find(u.id);
        if (i >= 0) { claimed.removeAt(i); GenericHelpers::LogUtil("[MexUpT2] dedicated constructor " + u.id + " lost", 1); }
    }

    bool IsT2Factory(const string &in n) {
        return UnitHelpers::IsT2BotLab(n) || UnitHelpers::IsT2VehicleLab(n) || UnitHelpers::IsT2AircraftPlant(n)
            || UnitHelpers::IsT2Shipyard(n);
    }

    // The T2 constructor this factory makes (TECH: never an air one, D-107)
    CCircuitDef@ ConstructorFor(CCircuitUnit@ factory) {
        const string side = UnitHelpers::GetSideForUnitName(factory.circuitDef.GetName());
        array<string> names = UnitHelpers::GetT2BotConstructors(side);
        array<string> veh = UnitHelpers::GetT2VehicleConstructors(side);
        for (uint i = 0; i < veh.length(); ++i) names.insertLast(veh[i]);
        if (Global::AISettings::Role != AiRole::TECH) {
            names.insertLast(UnitHelpers::GetT2AirConstructorNameForSide(side));
            array<string> sea = UnitHelpers::GetAllT2SeaConstructors();
            for (uint i = 0; i < sea.length(); ++i) names.insertLast(sea[i]);
        }
        for (uint i = 0; i < names.length(); ++i) {
            CCircuitDef@ d = ai.GetCircuitDef(names[i]);
            if (d is null || !factory.circuitDef.CanBuild(d) || !d.IsAvailable(ai.frame)) continue;
            if (d.maxThisUnit >= 0 && d.count >= d.maxThisUnit) continue;
            return d;
        }
        return null;
    }

    // manager/factory.as AiMakeTask: a T2 factory builds the dedicated constructors before its normal work
    IUnitTask@ FactoryMakeTask(CCircuitUnit@ factory) {
        if (!On() || done || factory is null || factory.circuitDef is null) return null;
        if (!IsT2Factory(factory.circuitDef.GetName())) return null;
        if (firstT2Frame < 0) { firstT2Frame = ai.frame; Status("first T2 factory " + factory.circuitDef.GetName() + " ready"); }
        if (recruit !is null && !recruit.IsDead()) return null;
        // the constructor just made asks for work (and is claimed) within a few seconds: wait for it
        if (recruit !is null) { @recruit = null; holdUntil = ai.frame + 10 * SECOND; }
        if (ai.frame < holdUntil) return null;
        const int target = Target();
        // the constructors already out count, so is any fresh one not judged yet (asks next)
        if (int(claimed.length()) >= target || recruits >= target + Global::RoleSettings::EarlyMexUpgradersExtraRecruits) return null;
        CCircuitDef@ d = ConstructorFor(factory);
        if (d is null) return null;
        @recruit = aiFactoryMgr.Enqueue(TaskS::Recruit(Task::RecruitType::BUILDPOWER, Task::Priority::HIGH, d,
            factory.GetPos(ai.frame), 64.f));
        if (recruit !is null) {
            recruits++;
            GenericHelpers::LogUtil("[MexUpT2] " + factory.circuitDef.GetName() + " builds " + d.GetName()
                + " for mex upgrades (" + (claimed.length() + 1) + " of " + target + ", open " + OpenCount() + ")", 1);
        }
        return recruit;
    }
}
