namespace FrontEnergyProbe {
    bool done = false;
    void Check(const string& in name, bool pass) {
        AiLog("[FrontEnergyTest] " + (pass ? "PASS " : "FAIL ") + name);
    }
    void Income(float metal, float energy) {
        Economy::_metalMin10s.frames.resize(0); Economy::_metalMin10s.values.resize(0); Economy::_metalMin10s.head = 0;
        Economy::_energyMin10s.frames.resize(0); Economy::_energyMin10s.values.resize(0); Economy::_energyMin10s.head = 0;
        Economy::_UpdateSlidingMinima(ai.frame, metal, energy);
        FrontEnergy::Update();
    }
    void Tick() {
        if (ai.teamId != 0 || ai.frame < 20 * SECOND || done) return;
        Global::AISettings::Role = AiRole::FRONT;
        FrontEnergy::Release();
        CCircuitDef@ afus = ai.GetCircuitDef("armafus");
        CCircuitDef@ fus = ai.GetCircuitDef("armfus");
        const int original = afus.maxThisUnit, fusionCap = fus.maxThisUnit;
        Income(100, 3999);
        bool allBlocked = true;
        for (uint i = 0; i < FrontEnergy::gates.length(); ++i)
            allBlocked = allBlocked && !FrontEnergy::gates[i].definition.IsAvailable(ai.frame);
        Check("all_factions_energy_blocked", allBlocked);
        Check("script_afus_blocked", Builder::EnqueueAFUS("armada", Global::Map::StartPos, 64, SECOND) is null);
        Income(69, 5000);
        Check("metal_blocked", !afus.IsAvailable(ai.frame));
        CCircuitUnit@ worker;
        array<int>@ ids = ai.GetOwnedUnitIds();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ unit = ai.GetTeamUnit(ids[i]);
            if (unit !is null && unit.circuitDef.GetName() == "armack") { @worker = unit; break; }
        }
        IUnitTask@ order;
        if (worker !is null) {
            @Builder::primaryT2BotConstructor = worker;
            @Builder::freelanceT2BotConstructor = null;
            @order = RoleFront::Front_T2Constructor_AiMakeTask(worker, null, false, 69, 5000, 1000, true);
        }
        IBuilderTask@ building = cast<IBuilderTask>(order);
        Check("normal_fusion_admitted", building !is null && building.buildDef is fus && fus.maxThisUnit == fusionCap);
        if (order !is null) aiBuilderMgr.AbortTask(order);
        Income(70, 4000);
        Check("both_boundaries_restore_cap", afus.maxThisUnit == original && afus.IsAvailable(ai.frame));
        Income(70, 3999);
        Check("income_drop_reblocks", !afus.IsAvailable(ai.frame));
        // A map ban equal to our zero cap must not be mistaken for our overlay.
        Global::Map::Config.UnitLimits.set("armafus", 0);
        afus.maxThisUnit = 0;
        FrontEnergy::Update(true);
        Income(100, 5000);
        Check("map_ban_preserved", afus.maxThisUnit == 0);
        Global::Map::Config.UnitLimits.delete("armafus");
        afus.maxThisUnit = original;
        Income(50, 2000);
        FrontEnergy::Release();
        Global::AISettings::Role = AiRole::SUPPORT;
        FrontEnergy::Update();
        Check("role_exit_restores_caps", afus.maxThisUnit == original);
        Global::AISettings::Role = AiRole::FRONT;
        done = true;
        AiLog("[FrontEnergyTest] complete");
    }
}
