// AA interrupt for builders that see enemy air (owner, 2026-11-24).
//
// Played (All That Smolders 2026-11-24, live; Delta Siege Dry long-game audit):
// idle T1 constructors and commanders watched enemy fighters and bombers fly
// past and built no AA. The only builder-side reaction was CommanderGroupAA
// (commander_group_air_aa.as): FRONT only, armed air worth 750 metal within
// 1800 of the FRONT commander, T1.5 only, and its fallback took only a free or
// walking T1 constructor (never one mid-build, never the commander). In the
// Smolders game it fired four times: twice the nearest free constructor was
// 1700-2400 elmos away and timed out after 180 s unbuilt, once all three
// capable constructors were busy ("fallback none ... busy=3").
//
// This module: every CheckSeconds, when the ally team sees any enemy aircraft
// (armed or a scout) within SightRadius of one of our T1 constructors or our
// commander, and none of our AA turrets stands within CoverRadius of that
// builder, the builder is pulled off whatever it is doing (idle, walking, or
// mid-build) and builds one AA turret next to itself: the side's light AA
// (Nettle / Thistle / legrl), or its T1.5 AA (Ferret / Eradicator / Rhapsis)
// when the air seen there is worth HeavyMetal or more and the builder can
// build it. When that order ends the builder goes back to the kind of build it
// left (FindQueuedTask of that build type: the abandoned build stays queued,
// so it is normally the one picked up again).
//
// Limits: at most MaxOrders orders at once, one new order per MinGapSeconds,
// never two orders within AreaRadius of each other for AreaHoldSeconds, and a
// builder whose current build is BusyFinish or more complete finishes it first.
// Builders on retreat, player orders, external control, ferry gifts and
// flying constructors are never taken.
//
// Cost: nothing when the ally team sees no enemy aircraft (one native call).
// Otherwise one pass over our owned units (builders and AA turrets) and, per
// eligible builder, one pass over the air contact snapshot CBattleAnalysis
// already keeps: O(units + builders x contacts) every CheckSeconds, at most one
// AssignTask per pass. No messages. Task handles held are only the orders this
// module enqueued, dropped in TaskRemoved; the resume record is a build type
// and a frame per unit id, never a handle to another task.
namespace AirSightAA {
    bool loaded = false;
    bool enabled = true;
    float checkSeconds = 2.0f, sightRadius = 1000.0f, coverRadius = 650.0f, heavyMetal = 400.0f;
    float minMetal = 1.0f, areaRadius = 700.0f, areaHoldSeconds = 90.0f, minGapSeconds = 8.0f;
    float orderSeconds = 75.0f, busyFinish = 0.8f, resumeSeconds = 60.0f, backOffset = 80.0f;
    int maxOrders = 2;
    int next = 0, lastOrder = -100000;
    CCircuitDef@ light;
    CCircuitDef@ heavy;
    array<int> aaDefIds;                 // our AA turret defs (cover check)
    array<IUnitTask@> orders;            // our orders, live
    array<int> orderUnit, orderFrame;
    array<float> orderX, orderZ;
    array<float> areaX, areaZ;           // recent order sites
    array<int> areaFrame;
    array<int> resumeUnit, resumeType, resumeFrame;

    float Setting(const string &in key, float fallback) {
        return aiSetupMgr.ConfigFloat("builder/air_sight_aa/" + key, fallback);
    }

    void AddAA(const string &in name) {
        CCircuitDef@ d = ai.GetCircuitDef(name);
        if (d !is null) aaDefIds.insertLast(d.id);
    }

    void Load() {
        if (loaded) return;
        loaded = true;
        enabled = Setting("enabled", 1) != 0;
        checkSeconds = Setting("check_seconds", 2);
        sightRadius = Setting("sight_radius", 1000);
        coverRadius = Setting("cover_radius", 650);
        heavyMetal = Setting("heavy_metal", 400);
        minMetal = Setting("min_metal", 1);
        areaRadius = Setting("area_radius", 700);
        areaHoldSeconds = Setting("area_hold_seconds", 90);
        minGapSeconds = Setting("min_gap_seconds", 8);
        orderSeconds = Setting("order_seconds", 75);
        busyFinish = Setting("busy_finish", 0.8f);
        resumeSeconds = Setting("resume_seconds", 60);
        backOffset = Setting("back_offset", 80);
        maxOrders = int(Setting("max_orders", 2));
        const string side = Global::AISettings::Side.length() > 0 ? Global::AISettings::Side : ai.GetSideName();
        @light = ai.GetCircuitDef(UnitHelpers::GetStaticAALightNameForSide(side));
        @heavy = ai.GetCircuitDef(UnitHelpers::GetStaticAAHeavyNameForSide(side));
        const array<string> names = { "armrl", "corrl", "legrl", "armferret", "armcir", "cormadsam", "corerad",
            "legrhapsis", "leglupara", "armflak", "corflak", "legflak", "armmercury", "corscreamer", "leglraa" };
        for (uint i = 0; i < names.length(); ++i) AddAA(names[i]);
    }

    bool IsAA(const CCircuitDef@ d) {
        if (d is null) return false;
        return aaDefIds.find(d.id) >= 0;
    }

    bool Ours(IUnitTask@ t) {
        if (t is null) return false;
        for (uint i = 0; i < orders.length(); ++i) if (orders[i] is t) return true;
        return false;
    }

    // Who may be interrupted: a finished, ground T1 constructor or a commander, not retreating,
    // not under a player order or external control, not already on one of our orders, and not
    // about to finish what it is building.
    bool Takeable(CCircuitUnit@ u) {
        if (u is null || u.circuitDef is null || !u.circuitDef.IsMobile() || u.circuitDef.IsAbleToFly()) return false;
        if (u.GetBuildProgress() < 1.0f) return false;
        const bool cmdr = UnitHelpers::IsCommander(u.circuitDef);
        if (!cmdr && UnitHelpers::GetConstructorTier(u.circuitDef) != 1) return false;
        if (Team::Ferry::IsGift(u.id) || Team::Recovery::IsGift(u.id)) return false;
        IUnitTask@ t = u.task;
        if (t is null || t.IsDead()) return true;
        if (Ours(t) || t.IsExternalControlled()) return false;
        const int type = t.GetType();
        if (type == int(Task::Type::RETREAT) || type == int(Task::Type::PLAYER)) return false;
        if (type != int(Task::Type::BUILDER)) {
            // commanders fight under their controller; only idle/wait ones are pulled
            return type == int(Task::Type::IDLE) || type == int(Task::Type::NIL) || type == int(Task::Type::WAIT) || !cmdr;
        }
        IBuilderTask@ b = cast<IBuilderTask>(t);
        if (b is null) return false;
        if (b.buildDef !is null && IsAA(b.buildDef)) return false;   // already on AA
        if (b.target !is null && b.target.GetBuildProgress() >= busyFinish) return false;
        return true;
    }

    bool AreaHeld(const AIFloat3 &in p) {
        const float sq = areaRadius * areaRadius;
        for (int i = int(areaFrame.length()) - 1; i >= 0; --i) {
            if (ai.frame - areaFrame[i] > int(areaHoldSeconds * SECOND)) {
                areaX.removeAt(i); areaZ.removeAt(i); areaFrame.removeAt(i);
                continue;
            }
            const float dx = areaX[i] - p.x, dz = areaZ[i] - p.z;
            if (dx * dx + dz * dz <= sq) return true;
        }
        return false;
    }

    void Update() {
        Load();
        if (!enabled || ai.frame < next) return;
        next = ai.frame + int(checkSeconds * SECOND);
        const int contacts = aiBattle.GetAirContactCount();
        if (contacts <= 0 || light is null) return;
        for (int i = int(orders.length()) - 1; i >= 0; --i)
            if (orders[i] is null || orders[i].IsDead()) Drop(i);
        if (int(orders.length()) >= maxOrders || ai.frame - lastOrder < int(minGapSeconds * SECOND)) return;

        // One pass over our units: candidate builders and our AA turrets.
        array<Id>@ ids = ai.GetOwnedUnitIds();
        array<CCircuitUnit@> builders;
        array<AIFloat3> aaPos;
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef is null) continue;
            if (!u.circuitDef.IsMobile()) {
                if (IsAA(u.circuitDef)) aaPos.insertLast(u.GetPos(ai.frame));
                continue;
            }
            if (Takeable(u) && u.circuitDef.CanBuild(light)) builders.insertLast(u);
        }
        if (builders.length() == 0) return;

        const float sightSq = sightRadius * sightRadius, coverSq = coverRadius * coverRadius;
        CCircuitUnit@ best = null;
        float bestMetal = 0.0f;
        int bestSeen = 0;
        for (uint b = 0; b < builders.length(); ++b) {
            const AIFloat3 p = builders[b].GetPos(ai.frame);
            float metal = 0.0f;
            int seen = 0;
            for (int c = 0; c < contacts; ++c) {
                if (MapHelpers::SqDist(p, aiBattle.GetAirContactPos(c)) > sightSq) continue;
                metal += AiMax(1.0f, aiBattle.GetAirContactCost(c));
                ++seen;
            }
            if (seen == 0 || metal < minMetal || metal <= bestMetal) continue;
            bool covered = false;
            for (uint a = 0; a < aaPos.length() && !covered; ++a) covered = MapHelpers::SqDist(p, aaPos[a]) <= coverSq;
            if (covered || AreaHeld(p)) continue;
            bool near = false;
            for (uint o = 0; o < orders.length() && !near; ++o) {
                const float dx = orderX[o] - p.x, dz = orderZ[o] - p.z;
                near = dx * dx + dz * dz <= areaRadius * areaRadius;
            }
            if (near) continue;
            @best = builders[b]; bestMetal = metal; bestSeen = seen;
        }
        if (best is null) return;
        Order(best, bestMetal, bestSeen);
    }

    void Order(CCircuitUnit@ u, float metal, int seen) {
        CCircuitDef@ d = light;
        if (metal >= heavyMetal && heavy !is null && heavy.IsAvailable(ai.frame) && u.circuitDef.CanBuild(heavy)) @d = heavy;
        if (d is null || !d.IsAvailable(ai.frame)) return;
        AIFloat3 at = u.GetPos(ai.frame);
        const AIFloat3 home = Global::Map::StartPos;
        const float dx = home.x - at.x, dz = home.z - at.z;
        const float len = sqrt(dx * dx + dz * dz);
        if (len > 1.0f) { const float k = AiMin(backOffset, len) / len; at.x += dx * k; at.z += dz * k; }
        if (d.maxThisUnit >= 0 && d.maxThisUnit <= d.count) d.maxThisUnit = d.count + 1;

        // The kind of build it leaves, to go back to afterwards (a type, never the task handle).
        int prevType = -1;
        IBuilderTask@ prev = cast<IBuilderTask>(u.task);
        if (prev !is null && !prev.IsDead()) {
            const Task::BuildType bt = Task::BuildType(prev.GetBuildType());
            if (bt < Task::BuildType::REPAIR) prevType = int(bt);
        }
        IUnitTask@ t = aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::DEFENCE, Task::Priority::HIGH, d, at,
            SQUARE_SIZE * 12, true, int(orderSeconds * SECOND)));
        if (t is null) { GenericHelpers::LogUtil("[AirSightAA] order refused " + d.GetName(), 1); return; }
        orders.insertLast(t); orderUnit.insertLast(u.id); orderFrame.insertLast(ai.frame);
        orderX.insertLast(at.x); orderZ.insertLast(at.z);
        areaX.insertLast(at.x); areaZ.insertLast(at.z); areaFrame.insertLast(ai.frame);
        lastOrder = ai.frame;
        SetResume(u.id, prevType);
        aiBuilderMgr.AssignTask(u, t);
        GenericHelpers::LogUtil("[AirSightAA] " + d.GetName() + " by " + u.circuitDef.GetName() + " " + u.id
            + " at (" + int(at.x) + "," + int(at.z) + ") air=" + seen + " metal=" + int(metal)
            + " left=" + (prevType >= 0 ? "build" + prevType : "none"), 1);
    }

    void SetResume(int unitId, int type) {
        const int i = resumeUnit.find(unitId);
        if (type < 0) {
            if (i >= 0) { resumeUnit.removeAt(i); resumeType.removeAt(i); resumeFrame.removeAt(i); }
            return;
        }
        if (i >= 0) { resumeType[i] = type; resumeFrame[i] = -1; return; }
        resumeUnit.insertLast(unitId); resumeType.insertLast(type); resumeFrame.insertLast(-1);
    }

    // Builder ask hook (manager/builder.as AiMakeTask, ahead of every role rung): a builder on
    // our order keeps it (native re-asks would swap it off); once the order ended, the builder
    // takes the queued build of the kind it left.
    IUnitTask@ Work(CCircuitUnit@ u) {
        if (u is null) return null;
        if (Ours(u.task) && !u.task.IsDead()) return u.task;
        const int i = resumeUnit.find(u.id);
        if (i < 0 || resumeFrame[i] < 0) return null;
        const int type = resumeType[i];
        const bool fresh = ai.frame - resumeFrame[i] <= int(resumeSeconds * SECOND);
        resumeUnit.removeAt(i); resumeType.removeAt(i); resumeFrame.removeAt(i);
        if (!fresh) return null;
        IUnitTask@ t = aiBuilderMgr.FindQueuedTask(u, type);
        if (t !is null) GenericHelpers::LogUtil("[AirSightAA] " + u.id + " resumes build" + type, 1);
        return t;
    }

    void Drop(int i) {
        orders.removeAt(i); orderUnit.removeAt(i); orderFrame.removeAt(i); orderX.removeAt(i); orderZ.removeAt(i);
    }

    void TaskRemoved(IUnitTask@ task, bool done) {
        if (task is null) return;
        for (uint i = 0; i < orders.length(); ++i) {
            if (orders[i] !is task) continue;
            IBuilderTask@ b = cast<IBuilderTask>(task);
            const int unitId = orderUnit[i];
            GenericHelpers::LogUtil("[AirSightAA] order ended done=" + done + " after " + ((ai.frame - orderFrame[i]) / SECOND)
                + " s target=" + (b !is null && b.target !is null ? "framed" : "none") + " unit=" + unitId, 1);
            const int r = resumeUnit.find(unitId);
            if (r >= 0) resumeFrame[r] = ai.frame;   // the next ask of this builder resumes
            Drop(i);
            return;
        }
    }
}
