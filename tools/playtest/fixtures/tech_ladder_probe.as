// Supplied post-rush state; production Ladder and native task admission stay real.
namespace TechLadderProbe {
    bool active = false;
    bool checked = false;
    bool assisted = false;
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
