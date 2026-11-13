// Early T2 mex upgraders (owner, 2026-11-13). Every role and faction: the first T2 factory we finish
// builds 1-2 T2 constructors ahead of its normal production (EarlyMexUpgraders::FactoryMakeTask), and
// those constructors only upgrade our own T1 mexes (Economy::MexTracker, nearest first, reachable and
// safe: IsMexSpotSafe reads the threat map and enemy porc, ghosts too) or assist a mex upgrade.
// With none of ours left safe to upgrade they upgrade allies' T1 mexes the same way (owner, same day).
// They go back to normal duty once no owned or allied T1 mex is left that is safe to upgrade (all
// upgraded, or the rest under enemy porc / on the threat map) for EarlyMexUpgradersReleaseSeconds;
// after that the phase is over and no more are claimed or built.
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
        Prune();
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

    // Spot back-off. Played 11-13 (Tartar c1): native refused a legmoho site ("RESERVE: no site for
    // legmoho"), the order died at once, the spot was open again and the same constructor re-ordered it
    // every 24 frames for minutes (7,000 orders a game). An order that dies within OrderFailSeconds with
    // the mex still T1 rests its spot for BackoffSeconds; the constructor takes the next spot meanwhile.
    // Bounded by our owned mexes (tens); checked once per ask of a dedicated constructor.
    array<IUnitTask@> orderTasks;
    array<AIFloat3> orderSpots;
    array<int> orderFrames;
    array<AIFloat3> backSpots;
    array<int> backUntil;

    array<int> backCount;   // a spot refused BackoffLimit times is left to native for the rest of the game

    bool Refused(uint i) { return backCount[i] >= Global::RoleSettings::EarlyMexUpgradersBackoffLimit; }
    bool BackedOff(const AIFloat3 &in p) {
        for (uint i = 0; i < backSpots.length(); ++i)
            if (MapHelpers::IsInRange(p, backSpots[i], 35.0f)) return Refused(i) || backUntil[i] > ai.frame;
        return false;
    }
    // a resting (not given up) spot: the phase does not end while one waits
    bool AnyResting() {
        for (uint i = 0; i < backSpots.length(); ++i)
            if (!Refused(i) && backUntil[i] > ai.frame && !IsUpgradedAt(backSpots[i])) return true;
        return false;
    }
    void Back(const AIFloat3 &in p, const string &in why) {
        int i = -1;
        for (uint j = 0; j < backSpots.length(); ++j)
            if (MapHelpers::IsInRange(p, backSpots[j], 35.0f)) { i = int(j); break; }
        if (i < 0) { backSpots.insertLast(p); backUntil.insertLast(0); backCount.insertLast(0); i = int(backSpots.length()) - 1; }
        backCount[i]++;
        backUntil[i] = ai.frame + Global::RoleSettings::EarlyMexUpgradersBackoffSeconds * SECOND;
        GenericHelpers::LogUtil("[MexUpT2] spot (" + int(p.x) + "," + int(p.z) + ") " + why + ": "
            + (Refused(uint(i)) ? "left to native" : "rests " + Global::RoleSettings::EarlyMexUpgradersBackoffSeconds + " s")
            + " (" + backCount[i] + " refusals)", 1);
    }
    bool IsUpgradedAt(const AIFloat3 &in p) {
        for (uint i = 0; i < Economy::MexTracker::myMexes.length(); ++i)
            if (MapHelpers::IsInRange(p, Economy::MexTracker::myMexes[i].pos, 35.0f)) return Economy::MexTracker::myMexes[i].isUpgraded;
        return false;
    }
    void CheckFailures() {
        for (int i = int(orderTasks.length()) - 1; i >= 0; --i) {
            const bool dead = orderTasks[i] is null || orderTasks[i].IsDead();
            const bool old = ai.frame - orderFrames[i] >= Global::RoleSettings::EarlyMexUpgradersOrderFailSeconds * SECOND;
            if (!dead && !old) continue;
            if (dead && !old && !IsUpgradedAt(orderSpots[i])) Back(orderSpots[i], "order ended at once");
            // an ended order's allied spot waits for the next scan (it may be a moho now)
            if (dead)
                for (int j = int(allied.length()) - 1; j >= 0; --j)
                    if (MapHelpers::IsInRange(allied[j], orderSpots[i], 35.0f)) allied.removeAt(j);
            orderTasks.removeAt(i); orderSpots.removeAt(i); orderFrames.removeAt(i);
        }
    }

    // Nearest owned T1 mex not upgraded, not being upgraded, not resting, buildable, reachable and safe
    // (the same tests as MexTracker::GetNearestNonUpgradedMexInRange, plus the back-off)
    AIFloat3 Pick(CCircuitUnit@ u, CCircuitDef@ moho) {
        AIFloat3 best(-1, -1, -1);
        if (u is null || moho is null) return best;
        const AIFloat3 from = u.GetPos(ai.frame);
        float bestSq = 3.4e+38f;
        for (uint i = 0; i < Economy::MexTracker::myMexes.length(); ++i) {
            Economy::MexTracker::MexInfo@ m = Economy::MexTracker::myMexes[i];
            if (m is null || m.isUpgraded || m.isUpgradeInProgress || BackedOff(m.pos)) continue;
            const float d = MapHelpers::SqDist(from, m.pos);
            if (d >= bestSq) continue;
            if (!aiTerrainMgr.CanUpgradeTerrain(moho, m.pos)
                || !aiTerrainMgr.CanReachAtSafe(u, m.pos, u.circuitDef.GetBuildDistance())
                || !aiEconomyMgr.IsMexSpotSafe(u, m.pos)) continue;
            bestSq = d;
            best = m.pos;
        }
        return best;
    }

    // Allied T1 mexes (owner, 2026-11-13): once none of ours is left safe to upgrade, the dedicated
    // constructors upgrade allies' T1 mexes, nearest first, skipping any under enemy porc or on the
    // threat map (IsMexSpotSafe). Candidates come from the ally asset list (finished friendly static
    // mexes/builders/geos, refreshed natively every 5 s), kept to those on a metal spot and costing at
    // most AlliedT1MaxCost; rebuilt every AlliedScanSeconds: O(assets x spots), tens x ~100, per AI.
    array<AIFloat3> allied;
    int alliedFrame = -100000;

    void ScanAllied() {
        if (ai.frame - alliedFrame < Global::RoleSettings::EarlyMexUpgradersAlliedScanSeconds * SECOND) return;
        alliedFrame = ai.frame;
        allied.resize(0);
        if (aiEconomyMgr.IsMetalMap()) return;
        const int spots = ai.GetMetalSpotCount();
        const int n = aiBattle.GetAllyAssetCount();
        for (int i = 0; i < n; ++i) {
            if (aiBattle.GetAllyAssetCost(i) > Global::RoleSettings::EarlyMexUpgradersAlliedT1MaxCost) continue;
            const AIFloat3 p = aiBattle.GetAllyAssetPos(i);
            if (p.x < 0.0f || Economy::MexTracker::IsOwnedMex(p)) continue;
            for (int s = 0; s < spots; ++s) {
                const AIFloat3 sp = ai.GetMetalSpot(s);
                if (MapHelpers::IsInRange(p, sp, 48.0f)) { allied.insertLast(p); break; }
            }
        }
    }

    bool OrderedAt(const AIFloat3 &in p) {
        for (uint i = 0; i < orderSpots.length(); ++i)
            if (MapHelpers::IsInRange(p, orderSpots[i], 35.0f) && orderTasks[i] !is null && !orderTasks[i].IsDead()) return true;
        return false;
    }

    AIFloat3 PickAllied(CCircuitUnit@ u, CCircuitDef@ moho) {
        AIFloat3 best(-1, -1, -1);
        if (u is null || moho is null || u.circuitDef is null || !Global::RoleSettings::EarlyMexUpgradersAllied) return best;
        ScanAllied();
        const AIFloat3 from = u.GetPos(ai.frame);
        float bestSq = 3.4e+38f;
        for (uint i = 0; i < allied.length(); ++i) {
            const AIFloat3 p = allied[i];
            const float d = MapHelpers::SqDist(from, p);
            if (d >= bestSq || BackedOff(p) || OrderedAt(p)) continue;
            if (!aiTerrainMgr.CanUpgradeTerrain(moho, p)
                || !aiTerrainMgr.CanReachAtSafe(u, p, u.circuitDef.GetBuildDistance())
                || !aiEconomyMgr.IsMexSpotSafe(u, p)) continue;
            bestSq = d;
            best = p;
        }
        return best;
    }

    // A live upgrade (ours first, then an unassigned queued one) this constructor can assist
    IUnitTask@ Assist(CCircuitUnit@ u) {
        if (u is null) return null;
        for (int i = int(ours.length()) - 1; i >= 0; --i)
            if (ours[i] is null || ours[i].IsDead()) ours.removeAt(i);
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
        // null or half-gone unit (lost, given away, between jobs): nothing of it is read
        if (u is null || u.circuitDef is null || !On() || !IsT2Constructor(u)) return null;
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
        CheckFailures();
        bool ally = false;
        if (moho !is null) spot = Pick(u, moho);
        // ours all upgraded or unsafe: an ally's T1 mex (after any upgrade of ours still to assist)
        if (moho !is null && spot.x < 0.0f) { spot = PickAllied(u, moho); ally = spot.x >= 0.0f; }
        // Enqueue may dispatch lifecycle callbacks: from here on the unit is read again by id
        // (it can die or change hands between a job and the next), never through the old handle
        const int id = u.id;
        const string name = u.circuitDef.GetName();
        if (spot.x >= 0.0f) {
            idleSince = -1;
            IUnitTask@ t = aiBuilderMgr.Enqueue(TaskB::Spot(Task::BuildType::MEXUP, Task::Priority::NOW, moho, spot, -1));
            @u = ai.GetTeamUnit(id);
            if (u is null) { Forget(id); return null; }
            if (t is null || t.IsDead()) Back(spot, "order refused");
            if (t !is null && !t.IsDead()) {
                ours.insertLast(t);
                orderTasks.insertLast(t); orderSpots.insertLast(spot); orderFrames.insertLast(ai.frame);
                GenericHelpers::LogUtil("[MexUpT2] " + name + " " + id + " upgrades " + (ally ? "allied " : "") + "("
                    + int(spot.x) + "," + int(spot.z) + "), open " + OpenCount(), 1);
                return t;
            }
        }
        IUnitTask@ help = Assist(u);
        @u = ai.GetTeamUnit(id);
        if (u is null) { Forget(id); return null; }
        if (help !is null && !help.IsDead()) {
            idleSince = -1;
            if (help is u.task) { keep = true; return null; }
            GenericHelpers::LogUtil("[MexUpT2] " + name + " " + id + " assists a mex upgrade", 1);
            return help;
        }
        // nothing safe to upgrade: normal duty meanwhile; for good after the release delay
        if (idleSince < 0 || AnyResting()) idleSince = ai.frame;
        if (ai.frame - idleSince >= Global::RoleSettings::EarlyMexUpgradersReleaseSeconds * SECOND) {
            done = true;
            Status("phase over, no owned or allied T1 mex left that is safe to upgrade");
            // releasing only drops our claim: the unit's handle is not kept or read, native's next
            // ask (idle or re-evaluation) gives it normal work through the providers below ours
            while (claimed.length() > 0) Release(claimed[0], "no safe T1 mex left (ours or allied)");
        }
        return null;
    }

    // Drop every record of a unit (died, given away, captured); engine ids are reused, so a new unit
    // with the same id is judged afresh
    void Forget(int id) {
        int i = claimed.find(id);
        if (i >= 0) { claimed.removeAt(i); GenericHelpers::LogUtil("[MexUpT2] dedicated constructor " + id + " lost", 1); }
        i = asked.find(id);
        if (i >= 0) asked.removeAt(i);
    }

    void UnitRemoved(CCircuitUnit@ u) {
        if (u is null) return;
        Forget(u.id);
    }

    // Dead upgrades and units no longer ours leave the lists (bounded by our T2 constructors)
    void Prune() {
        for (int i = int(ours.length()) - 1; i >= 0; --i)
            if (ours[i] is null || ours[i].IsDead()) ours.removeAt(i);
        for (int i = int(claimed.length()) - 1; i >= 0; --i)
            if (ai.GetTeamUnit(claimed[i]) is null) Forget(claimed[i]);
        for (int i = int(asked.length()) - 1; i >= 0; --i)
            if (ai.GetTeamUnit(asked[i]) is null) asked.removeAt(i);
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
        const string facName = factory.circuitDef.GetName();
        @recruit = aiFactoryMgr.Enqueue(TaskS::Recruit(Task::RecruitType::BUILDPOWER, Task::Priority::HIGH, d,
            factory.GetPos(ai.frame), 64.f));
        if (recruit !is null && recruit.IsDead()) @recruit = null;
        if (recruit !is null) {
            recruits++;
            GenericHelpers::LogUtil("[MexUpT2] " + facName + " builds " + d.GetName()
                + " for mex upgrades (" + (claimed.length() + 1) + " of " + target + ", open " + OpenCount() + ")", 1);
        }
        return recruit;
    }
}
