// Supplied post-rush state; production Ladder and native task admission stay real.
namespace TechLadderProbe {
    bool active = false;
    bool checked = false;
    bool assisted = false;
    bool giftPending = false;
    int giftedId = -1;
    uint beforeGiftRevision = 0;
    bool Gift(const string& in message) {
        array<string>@ fields = message.split("|");
        if (fields.length() != 3 || fields[0] != "tech-ladder" || fields[1] != "gift") return false;
        CCircuitUnit@ mex = ai.GetTeamUnit(parseInt(fields[2]));
        const bool owned = mex !is null && mex.GetBuildProgress() >= 1.0f
            && OwnedEconomy::Extractors().find(mex.id) >= 0;
        GenericHelpers::LogUtil("[TechLadderTest] " + (owned ? "PASS" : "FAIL") + " owned_before_gift", 1);
        if (!owned) return true;
        Economy::MexTracker::myMexes.resize(0);
        Economy::MexTracker::RegisterMex(mex.GetPos(ai.frame));
        giftedId = mex.id;
        beforeGiftRevision = ai.GetOwnedUnitRevision();
        array<CCircuitUnit@> transfer = {mex};
        ai.GiveUnits(transfer, 1);
        giftPending = true;
        return true;
    }
    void Tick() {
        if (!active || !checked || assisted) return;
        if (ai.GetCircuitDef("cornanotc").count < 12) return;
        CCircuitUnit@ frame = aiBuilderMgr.FindUnfinishedNear(Global::Map::StartPos, 2000.0f, ai.GetCircuitDef("corafus"));
        if (frame is null) return;
        array<Id>@ ids = ai.GetOwnedUnitIds();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ unit = ai.GetTeamUnit(ids[i]);
            if (unit is null || unit.circuitDef.GetName() != "cornanotc") continue;
            IUnitTask@ repair = aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::HIGH, frame, 300 * SECOND));
            if (repair !is null) aiBuilderMgr.AssignTask(unit, repair);
        }
        assisted = true;
    }
    bool Handle(const string& in message) {
        if (Gift(message)) return true;
        if (message != "tech-ladder|setup") return false;
        if (!Global::Map::MapResolved) Setup::setupMap(AIFloat3(1400,0,10100));
        Global::AISettings::Role = AiRole::TECH;
        Global::AISettings::Side = "cortex";
        Global::Map::StartPos = AIFloat3(1400,0,10100);
        TechChain::active = false;
        TechChain::done = true;
        Layout::OnRoleLeave();
        aiTerrainMgr.SetLayoutEnabled(true);
        Layout::fallback = true;
        // Reproduce a remembered site whose extractor no longer belongs to us.
        Economy::MexTracker::myMexes.resize(0);
        Economy::MexTracker::RegisterMex(AIFloat3(1500,0,10100));
        active = true;
        return true;
    }
    IUnitTask@ Task(CCircuitUnit@ unit) {
        if (active && !unit.circuitDef.IsMobile()) {
            CCircuitUnit@ frame = aiBuilderMgr.FindUnfinishedNear(unit.GetPos(ai.frame),
                unit.circuitDef.GetBuildDistance(), ai.GetCircuitDef("corafus"));
            if (frame !is null) return aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::HIGH, frame, 60 * SECOND));
        }
        if (!active || unit.circuitDef.GetName() != "corack") return TechBuild::Wait(SECOND);
        if (giftPending) {
            if (ai.GetTeamUnit(giftedId) !is null) return TechBuild::Wait(SECOND);
            const bool invalidated = ai.GetOwnedUnitRevision() != beforeGiftRevision
                && OwnedEconomy::Extractors().find(giftedId) < 0;
            GenericHelpers::LogUtil("[TechLadderTest] " + (invalidated ? "PASS" : "FAIL") + " gift_cache_invalidated", 1);
            giftPending = false;
        }
        IUnitTask@ current = TechBuild::KeepCurrent(unit);
        if (current !is null) return current;
        if (checked) return TechBuild::Wait(SECOND);
        // Supply funded growth, independent of frame cadence / resource sharing.
        Global::RoleSettings::Tech::PowerAheadSeconds = 0.0f;
        TechBuild::metalFullSince = 0;
        IUnitTask@ stale = EcoPlanner::Enqueue("mexup", unit);
        GenericHelpers::LogUtil("[TechLadderTest] " + (stale is null ? "PASS" : "FAIL") + " ordinary_rejects_stale_mex", 1);
        if (stale !is null) aiBuilderMgr.AbortTask(stale);
        TechChain::Step income("income", "", 200);
        IUnitTask@ task = TechChain::Ladder(unit, 0, @income);
        IBuilderTask@ build = cast<IBuilderTask>(task);
        const bool growth = build !is null && build.buildDef !is null
            && build.buildDef.GetName() == "corafus";
        GenericHelpers::LogUtil("[TechLadderTest] " + (growth ? "PASS" : "FAIL")
            + " stale_mex_releases_reactor task=" + (build is null ? "null" : build.buildDef.GetName()), 1);
        checked = true;
        return task is null ? TechBuild::Wait(SECOND) : task;
    }
}
