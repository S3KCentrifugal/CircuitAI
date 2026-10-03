// One production owner, a friendly radar wall, then a persistent enemy sweep.
namespace AirRecon {
    dictionary waiting, sweeping;
    dictionary originalCaps;
    CRouteTask@ wall;
    int nextCycle = 0;
    string Name(const string &in side) { return side == "cortex" ? "corawac" : side == "legion" ? "legwhisper" : "armawac"; }
    void Unlock(CCircuitDef@ def)
    {
        if (def is null) return;
        if (!originalCaps.exists(def.GetName())) originalCaps.set(def.GetName(), int(def.maxThisUnit));
        def.maxThisUnit = 2147483647;
    }
    int FighterPlant()
    {
        int selected = -1, count = 0;
        const int prior = aiTerrainMgr.GetLayoutInt("air.fighterPlant", -1);
        bool retained = false;
        array<Id>@ ids = ai.GetOwnedUnitIds();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.GetBuildProgress() < 1.0f || Lifecycle::IsRetiring(u)
                || !UnitHelpers::IsT2AircraftPlant(u.circuitDef.GetName())) continue;
            ++count;
            if (u.id == prior) retained = true;
            if (selected < 0 || u.id < selected) selected = u.id;
        }
        if (count < 2) return -1;
        if (retained) return prior;
        aiTerrainMgr.SetLayoutInt("air.fighterPlant", selected);
        return selected;
    }
    int ProductionTarget(CCircuitDef@ def)
    {
        if (def is null || ai.frame < nextCycle) return 0;
        int away = 0;
        array<string>@ ids = sweeping.getKeys();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(parseInt(ids[i]));
            if (u is null) sweeping.delete(ids[i]);
            else if (u.circuitDef.GetName() == def.GetName()) ++away;
        }
        return away + AiMax(1, Global::RoleSettings::Air::RadarWaveSize);
    }
    IUnitTask@ MakeTask(CCircuitUnit@ u)
    {
        if (!AirEconomy::Active() || u is null || u.circuitDef.GetName() != Name(UnitHelpers::GetSideForUnitName(u.circuitDef.GetName()))) return null;
        CRouteTask@ active;
        if (sweeping.get("" + u.id, @active) && active !is null && !active.IsDead()) return active;
        if (wall is null || wall.IsDead()) {
            @wall = cast<CRouteTask>(aiMilitaryMgr.Enqueue(TaskF::Route()));
            if (wall is null) return null;
            const AIFloat3 centre = AirScreen::Anchor(), enemy = AirScreen::Enemy(centre);
            const float dx = enemy.x-centre.x, dz = enemy.z-centre.z;
            const float length = AiMax(1.0f, sqrt(dx*dx+dz*dz));
            array<AIFloat3> route = {AirScreen::Clamp(AIFloat3(centre.x-dz/length*1000,0,centre.z+dx/length*1000)),
                AirScreen::Clamp(AIFloat3(centre.x+dz/length*1000,0,centre.z-dx/length*1000))};
            wall.SetAirControl(true); wall.SetPatrol(true); wall.SetRoute(route);
            wall.SetLanes(AiMax(1, Global::RoleSettings::Air::RadarWaveSize), 80.0f, 1.0f);
        }
        waiting.set("" + u.id, true); u.SetIdleMode(0); u.SetFireState(0);
        return wall;
    }
    void Tick()
    {
        array<string>@ ids = waiting.getKeys();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ unit = ai.GetTeamUnit(parseInt(ids[i]));
            if (unit is null || (unit.task !is null && unit.task.GetType() == int(Task::Type::PLAYER))) waiting.delete(ids[i]);
        }
        if (int(waiting.getSize()) < AiMax(1, Global::RoleSettings::Air::RadarWaveSize)) return;
        CRouteTask@ sweep = cast<CRouteTask>(aiMilitaryMgr.Enqueue(TaskF::Route()));
        if (sweep is null) return;
        array<AIFloat3> route = Lanes::ScriptStarts(true);
        if (route.length() == 0) route.insertLast(AirScreen::Enemy(Global::Map::StartPos));
        // The whole cohort traverses every known enemy start, with lateral lanes
        // widening coverage. Patrol repeats there; it never routes home.
        for (uint i = 0; i < route.length(); ++i) route[i] = AirScreen::Clamp(route[i]);
        if (route.length() == 1) route.insertLast(AirScreen::Clamp(AIFloat3(route[0].x+800,0,route[0].z+800)));
        sweep.SetAirControl(true); sweep.SetPatrol(true);
        sweep.SetLanes(AiMax(1, Global::RoleSettings::Air::RadarWaveSize), 160.0f, 1.0f);
        sweep.SetRoute(route);
        @ids = waiting.getKeys(); int sent = 0;
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(parseInt(ids[i]));
            if (u !is null && aiMilitaryMgr.TransferUnit(u, sweep)) {
                sweeping.set(ids[i], @sweep); waiting.delete(ids[i]); ++sent;
            }
        }
        nextCycle = ai.frame + AiMax(1, Global::RoleSettings::Air::RadarWaveIntervalSeconds)*SECOND;
        GenericHelpers::LogUtil("[AIR][Recon] synchronized sweep=" + sent + " enemy starts=" + route.length(), 1);
    }
    void Reset()
    {
        if (wall !is null && !wall.IsDead()) wall.Abort();
        array<string>@ ids = sweeping.getKeys();
        for (uint i = 0; i < ids.length(); ++i) {
            CRouteTask@ task; sweeping.get(ids[i], @task);
            if (task !is null && !task.IsDead()) task.Abort();
        }
        @wall = null; waiting.deleteAll(); sweeping.deleteAll(); nextCycle = 0;
        @ids = originalCaps.getKeys();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitDef@ def = ai.GetCircuitDef(ids[i]); int cap = 0;
            if (def !is null && originalCaps.get(ids[i], cap)) def.maxThisUnit = cap;
        }
        originalCaps.deleteAll();
    }
}
