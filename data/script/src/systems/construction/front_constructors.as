#include "../../helpers/math/front_constructor_math.as"
#include "front_eco_blocks.as"
// Stable FRONT seats, assigned in completion order rather than engine unit-ID
// order. A casualty opens only its own seat; surviving workers never reshuffle.
namespace FrontConstructors {
    const int SUPPORT = FrontConstructorMath::SUPPORT, EXPANSION = FrontConstructorMath::EXPANSION,
        COMMANDER = FrontConstructorMath::COMMANDER, ENERGY = FrontConstructorMath::ENERGY,
        CONVERTER = FrontConstructorMath::CONVERTER;
    // Preserve persisted seat IDs; admission order adds energy before expansion.

    array<int> seats = {-1, -1, -1, -1, -1};
    array<bool> filled = {false, false, false, false, false};
    // D-463: where the energy seat's own factory stood (geothermal search
    // centre), and the one-way release of the converter seat.
    AIFloat3 energyHome = AIFloat3(-1.f, 0.f, -1.f);
    bool converterReleased = false;
    // D-463: the energy seat's last geothermal site, how many orders there
    // ended without a geothermal, and the frame before which it does not try
    // geothermal again. The same site offered again means the last order
    // failed (a finished geo occupies its vent and is never offered).
    int geoSiteX = -1, geoSiteZ = -1, geoFails = 0, geoRetryFrame = 0, geoOrderFrame = 0;
    void GeoFailed(const string &in why) {
        ++geoFails;
        aiTerrainMgr.SetLayoutInt("front.constructor.geo_fails", geoFails);
        geoRetryFrame = ai.frame + FrontConstructorMath::GeoBackoffFrames(geoFails,
            int(Global::RoleSettings::Front::EnergySeatGeoRetrySeconds * SECOND));
        GenericHelpers::LogUtil("[FrontConstructors] energy geothermal " + why + " at " + geoSiteX + "," + geoSiteZ
            + " fails=" + geoFails + (geoFails >= Global::RoleSettings::Front::EnergySeatGeoAttempts
            ? " giving up geothermal" : " retry after " + ((geoRetryFrame - ai.frame) / SECOND) + " s"), 1);
        geoSiteX = -1; geoSiteZ = -1;
    }
    int convertersAllowed = -1;   // mod option, read once: -1 unknown, 0 no, 1 yes
    IUnitTask@ openingNano = null;
    int openingTurret = -1;
    bool loaded = false;
    IUnitTask@ recruit = null;
    void Load() {
        if (loaded) return;
        loaded = true;
        for (uint i = 0; i < seats.length(); ++i) {
            seats[i] = aiTerrainMgr.GetLayoutInt("front.constructor." + i, -1);
            filled[i] = aiTerrainMgr.GetLayoutInt("front.constructor.filled." + i, 0) != 0;
        }
        energyHome = AIFloat3(float(aiTerrainMgr.GetLayoutInt("front.constructor.energy_home.x", -1)), 0.f,
            float(aiTerrainMgr.GetLayoutInt("front.constructor.energy_home.z", -1)));
        converterReleased = aiTerrainMgr.GetLayoutInt("front.constructor.converter_released", 0) != 0;
        geoFails = aiTerrainMgr.GetLayoutInt("front.constructor.geo_fails", 0);
    }
    void Save(int seat) {
        aiTerrainMgr.SetLayoutInt("front.constructor." + seat, seats[seat]);
        aiTerrainMgr.SetLayoutInt("front.constructor.filled." + seat, filled[seat] ? 1 : 0);
    }
    const array<string> candidates = {"armck","corck","legck","armcv","corcv","legcv",
        "armch","corch","legch","armbeaver","cormuskrat","legotter"};
    bool Eligible(CCircuitUnit@ unit) {
        return unit !is null && candidates.find(unit.circuitDef.GetName()) >= 0
            && !unit.circuitDef.IsAbleToFly();
    }
    int Seat(int id) { Load(); return seats.find(id); }
    bool IsBase(int id) { Load(); return id >= 0 && seats[SUPPORT] == id; }
    int Missing() {
        Load();
        return FrontConstructorMath::Missing(seats, ConverterWanted());
    }
    bool OnAdded(CCircuitUnit@ unit) {
        if (Global::AISettings::Role != AiRole::FRONT || !Eligible(unit)) return false;
        if (Team::Ferry::IsGift(unit.id) || Team::Recovery::IsGift(unit.id)) return false;
        // Called on builder admission/completion. No recurring owned-army scan,
        // borrowed handles, or random-ID ordering. At most four comparisons.
        int seat = Seat(unit.id);
        if (seat < 0) {
            seat = Missing();
            if (seat >= 0) { seats[seat] = unit.id; filled[seat] = true; Save(seat); }
            if (seat == ENERGY) RecordEnergyHome(unit);
            GenericHelpers::LogUtil("[FrontConstructors] assigned unit=" + unit.id + " seat=" + seat, 1);
        }
        if (seat == SUPPORT || seat == ENERGY || seat == CONVERTER) unit.AddAttribute(Unit::Attr::BASE.type);
        else unit.DelAttribute(Unit::Attr::BASE.type);
        return true; // bypass generic primary/secondary/guard reassignment
    }
    void OnRemoved(CCircuitUnit@ unit) {
        const int seat = Seat(unit.id);
        if (seat < 0) return;
        seats[seat] = -1; Save(seat);
        GenericHelpers::LogUtil("[FrontConstructors] vacant seat=" + seat + " unit=" + unit.id, 1);
    }
    IUnitTask@ Recruit(CCircuitUnit@ factory, bool commanderEnabled) {
        const int seat = Missing();
        if (seat < 0) return null;
        // Preserve two constructors/scout/raiders/expansion opening order. Once
        // a seat has existed, replacing it precedes all optional production.
        if (!FrontConstructorMath::RecruitAllowed(seat,filled[seat],RoleFront::g_frontPostRaidConstructorQueued,
            commanderEnabled,ConverterWanted())) return null;
        // Hold our one recruit through frame construction; the shared pending
        // index counts only unstarted orders. Release the handle on completion
        // or cancellation, without retaining an engine unit across callbacks.
        if (recruit !is null && !recruit.IsDead()) return null;
        @recruit = null;
        for (uint i = 0; i < candidates.length(); ++i) {
            CCircuitDef@ def = ai.GetCircuitDef(candidates[i]);
            if (def !is null && aiFactoryMgr.GetPendingRecruitCount(def) > 0) return null;
        }
        for (uint i = 0; i < candidates.length(); ++i) {
            CCircuitDef@ def = ai.GetCircuitDef(candidates[i]);
            if (def is null || !factory.circuitDef.CanBuild(def) || !def.IsAvailable(ai.frame)) continue;
            IUnitTask@ task = aiFactoryMgr.Enqueue(TaskS::Recruit(Task::RecruitType::BUILDPOWER,
                Task::Priority::HIGH, def, factory.GetPos(ai.frame), 64.f));
            @recruit = task;
            if (task !is null) GenericHelpers::LogUtil("[FrontConstructors] recruit seat=" + seat + " def=" + def.GetName(), 1);
            return task;
        }
        return null;
    }
    bool OpeningPending(CCircuitUnit@ factory) {
        Load();
        if (FrontConstructorMath::OpeningDone(filled)) return false;
        for (uint i=0; i<candidates.length(); ++i) {
            CCircuitDef@ def=ai.GetCircuitDef(candidates[i]);
            if (def !is null && factory.circuitDef.CanBuild(def) && def.IsAvailable(ai.frame)) return true;
        }
        return recruit !is null && !recruit.IsDead();
    }
    CCircuitUnit@ OpeningFactory() {
        if (Factory::primaryT1BotLab !is null) return Factory::primaryT1BotLab;
        return Factory::primaryT1VehPlant;
    }
    IUnitTask@ AssistFactory(CCircuitUnit@ unit) {
        CCircuitUnit@ factory=OpeningFactory();
        if (factory is null) return aiBuilderMgr.Enqueue(TaskB::Wait(SECOND));
        return GuardHelpers::AssignWorkerGuard(unit,factory,Task::Priority::NORMAL,true,10*SECOND);
    }
    bool ReachesFactory(CCircuitUnit@ turret,CCircuitUnit@ factory) {
        if(factory is null || turret is null || turret.circuitDef.IsMobile()
            || turret.circuitDef.GetName()!=UnitHelpers::GetT1NanoNameForSide(Global::AISettings::Side)) return false;
        const float reach=turret.circuitDef.GetBuildDistance();
        return MapHelpers::SqDist(turret.GetPos(ai.frame),factory.GetPos(ai.frame))<=reach*reach;
    }
    bool UsefulTurret(CCircuitUnit@ factory) {
        // Cache only identity; validate existence/type/reach on each task ask.
        // Scan the lifecycle-maintained turret list only after loss or relocation.
        if(ReachesFactory(ai.GetTeamUnit(openingTurret),factory)) return true;
        openingTurret=-1;
        IBuilderTask@ pending=cast<IBuilderTask>(openingNano);
        if(pending !is null && !pending.IsDead() && ReachesFactory(pending.target,factory)) {
            openingTurret=pending.target.id;return true;
        }
        FrontFactorySupport::Load();
        for (uint i=0; i<FrontFactorySupport::turrets.length(); ++i) {
            CCircuitUnit@ turret=ai.GetTeamUnit(FrontFactorySupport::turrets[i]);
            if (ReachesFactory(turret,factory)) {openingTurret=turret.id;return true;}
        }
        return false;
    }
    bool OpeningComplete() {
        CCircuitUnit@ factory=OpeningFactory();
        return factory !is null && UsefulTurret(factory)
            && ai.GetTeamUnit(openingTurret).GetBuildProgress()>=1.f;
    }
    IUnitTask@ EnqueueOpeningTurret(CCircuitUnit@ unit,CCircuitUnit@ factory,CCircuitDef@ nano) {
        // One retained task owns this opener independently of unrelated front
        // defence queues/cooldowns. Slot search is bounded by the layout group.
        int group=aiTerrainMgr.GetLayoutInt(FrontLayout::TierKey(0)+".adopted_nano",-1);
        if(group<0) group=aiTerrainMgr.GetNamedLayoutGroup(FrontLayout::PlanKey(0)+".nano");
        const int slot=aiTerrainMgr.NextSupportSlot(unit,nano,group,factory.GetPos(ai.frame),8);
        if(slot>=0) {
            IUnitTask@ task=aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::NANO,Task::Priority::HIGH,
                nano,aiTerrainMgr.GetReservationPos(slot),0.f,true,300*SECOND));
            if(task !is null && !AiPinReservation(task,slot)) {aiBuilderMgr.AbortTask(task);return null;}
            return task;
        }
        // Ordinary placement retains native reservation checks on cramped maps.
        return aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::NANO,Task::Priority::HIGH,
            nano,factory.GetPos(ai.frame),SQUARE_SIZE*24,true,300*SECOND));
    }
    IUnitTask@ OpeningSupport(CCircuitUnit@ unit) {
        if (openingNano !is null && !openingNano.IsDead()) return openingNano;
        @openingNano=null;
        CCircuitUnit@ factory=OpeningFactory();
        if (factory is null || UsefulTurret(factory)) return null;
        CCircuitDef@ nano=ai.GetCircuitDef(UnitHelpers::GetT1NanoNameForSide(Global::AISettings::Side));
        if (nano !is null && unit.circuitDef.CanBuild(nano) && nano.IsAvailable(ai.frame)) {
            @openingNano=EnqueueOpeningTurret(unit,factory,nano);
            if (openingNano !is null) {
                GenericHelpers::LogUtil("[FrontConstructors] opening turret builder="+unit.id,1);
                return openingNano;
            }
        }
        return AssistFactory(unit);
    }
    IUnitTask@ CommanderOpening(CCircuitUnit@ unit) {
        if (!UnitHelpers::IsCommander(unit.circuitDef) || CommanderFront::Ready()) return null;
        CCircuitUnit@ factory=OpeningFactory();
        if (factory is null || factory.GetBuildProgress()<1.f) return null;
        IUnitTask@ current=unit.task;
        if (current !is null && (current.IsExternalControlled() || current.IsEnemyReclaim()
            || current.GetType()==int(Task::Type::PLAYER) || current.GetType()==int(Task::Type::RETREAT))) return current;
        IBuilderTask@ build=cast<IBuilderTask>(current);
        if (build !is null && !build.IsDead() && build.target !is null
            && build.GetBuildType()<int(Task::BuildType::REPAIR)) return current;
        if(UsefulTurret(factory)) {
            CCircuitUnit@ turret=ai.GetTeamUnit(openingTurret);
            const int phase=FrontConstructorMath::CommanderPhase(true,turret.GetBuildProgress());
            if(phase==2) return null;
            if(build !is null && !build.IsDead() && build.target is turret
                && build.GetBuildType()==int(Task::BuildType::REPAIR)) return current;
            GenericHelpers::LogUtil("[FrontConstructors] commander assist turret="+turret.id,1);
            return aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::HIGH,turret,10*SECOND));
        }
        return AssistFactory(unit);
    }
    // D-463: the position of the factory that produced the energy seat, kept
    // so a lost factory does not move the geothermal search. A constructor
    // with no producer (gift, commander-built) searches from the start.
    void RecordEnergyHome(CCircuitUnit@ unit) {
        CCircuitUnit@ factory = ai.GetTeamUnit(unit.GetProducerId());
        energyHome = factory is null ? Global::Map::StartPos : factory.GetPos(ai.frame);
        aiTerrainMgr.SetLayoutInt("front.constructor.energy_home.x", int(energyHome.x));
        aiTerrainMgr.SetLayoutInt("front.constructor.energy_home.z", int(energyHome.z));
    }
    AIFloat3 EnergyHome() {
        Load();
        return energyHome.x < 0.f ? Global::Map::StartPos : energyHome;
    }
    string Prefix(CCircuitUnit@ unit) {
        const string side = UnitHelpers::GetSideForUnitName(unit.circuitDef.GetName());
        return side == "armada" ? "arm" : side == "cortex" ? "cor" : "leg";
    }
    // Played (Supreme Isthmus team 2): an unstarted order held the seat 7.6
    // minutes with no energy built. Our own order that has not started within
    // EnergySeatGeoOrderSeconds counts as a failure.
    bool AbortStaleGeo(IBuilderTask@ task) {
        if (task is null || task.IsDead() || task.target !is null
            || task.GetBuildType() != int(Task::BuildType::GEO)) return false;
        const AIFloat3 at = task.GetBuildPos();
        if (int(at.x) != geoSiteX || int(at.z) != geoSiteZ
            || ai.frame - geoOrderFrame <= int(Global::RoleSettings::Front::EnergySeatGeoOrderSeconds * SECOND)) return false;
        aiBuilderMgr.AbortTask(task);
        GeoFailed("not started in " + int(Global::RoleSettings::Front::EnergySeatGeoOrderSeconds) + " s");
        return true;
    }
    // Played (Scylla and Charybdis 8v8, owner's game): a constructor stuck
    // below a plateau vent is never idle, so its builder ask, where the
    // deadline used to live, never came. FRONT's once-a-second update checks
    // the energy seat's own task instead: O(1), no unit scan.
    void Watch() {
        if (Global::AISettings::Role != AiRole::FRONT) return;
        Load();
        CCircuitUnit@ unit = ai.GetTeamUnit(seats[ENERGY]);
        if (unit is null) return;
        IBuilderTask@ task = cast<IBuilderTask>(unit.task);
        if (task is null || task.GetBuildType() != int(Task::BuildType::GEO)) return;
        // INV-251: ground construction never holds an air-only geothermal vent.
        if (aiEconomyMgr.IsGeoAirOnly(task.GetBuildPos()))
            Invariants::Violation("INV-251", "front-geo", "FRONT energy seat " + unit.id + " holds a geothermal order on an air-only vent at "
                + int(task.GetBuildPos().x) + "," + int(task.GetBuildPos().z));
        AbortStaleGeo(task);
    }
    bool Started(IBuilderTask@ task) {
        return task !is null && !task.IsDead() && task.target !is null
            && task.GetBuildType() < int(Task::BuildType::REPAIR) && Local(task);
    }
    // Geothermal first: a free vent within EnergySeatGeoRadius of the seat's
    // factory, or a GEO job already queued there. EnqueueLocalGeo keeps
    // native's safe-reach, occupancy and allied-layout checks; it scans the
    // map's few vent positions with a distance test first.
    IUnitTask@ EnergyGeo(CCircuitUnit@ unit, IBuilderTask@ current) {
        Load();
        if (current !is null && !current.IsDead() && current.GetBuildType() == int(Task::BuildType::GEO)) {
            if (AbortStaleGeo(current)) return null;
            return current;
        }
        if (!FrontConstructorMath::GeoAllowed(geoFails, Global::RoleSettings::Front::EnergySeatGeoAttempts,
            ai.frame, geoRetryFrame)) return null;
        CCircuitDef@ geo = ai.GetCircuitDef(Prefix(unit) + "geo");
        if (geo is null || !unit.circuitDef.CanBuild(geo) || !geo.IsAvailable(ai.frame)) return null;
        const AIFloat3 home = EnergyHome();
        const float radius = Global::RoleSettings::Front::EnergySeatGeoRadius;
        IBuilderTask@ queued = cast<IBuilderTask>(aiBuilderMgr.FindQueuedTask(unit, int(Task::BuildType::GEO)));
        if (queued !is null && MapHelpers::SqDist(queued.GetBuildPos(), home) <= radius * radius) return queued;
        IUnitTask@ task = aiEconomyMgr.EnqueueLocalGeo(unit, geo, home, radius);
        if (task is null) return null;
        const AIFloat3 site = cast<IBuilderTask>(task).GetBuildPos();
        if (int(site.x) == geoSiteX && int(site.z) == geoSiteZ) {
            // Played (Supreme Isthmus team 6): one vent re-ordered ten times
            // while two energy constructors died walking to it, and no wind
            // was built meanwhile. Back off, longer each time, then give up.
            aiBuilderMgr.AbortTask(task);
            GeoFailed("failed");
            return null;
        }
        geoSiteX = int(site.x); geoSiteZ = int(site.z); geoOrderFrame = ai.frame;
        GenericHelpers::LogUtil("[FrontConstructors] energy geothermal builder=" + unit.id
            + " site=" + geoSiteX + "," + geoSiteZ, 1);
        return task;
    }
    // The wind turbine the seat builds on this map, or null when the map's
    // average wind is not above EnergySeatWindAverage or it cannot build one.
    CCircuitDef@ WindDef(CCircuitUnit@ unit) {
        if (!FrontConstructorMath::Windy(ai.GetWindMin(), ai.GetWindMax(),
            Global::RoleSettings::Front::EnergySeatWindAverage)) return null;
        CCircuitDef@ wind = ai.GetCircuitDef(UnitHelpers::GetWindNameForSide(
            UnitHelpers::GetSideForUnitName(unit.circuitDef.GetName())));
        if (wind is null || !unit.circuitDef.CanBuild(wind) || !wind.IsAvailable(ai.frame)) return null;
        if (Global::energyAllowed !is null && !Global::energyAllowed(wind.GetName())) return null;
        return wind;
    }
    // A loose order near the start when no dense block can be reserved
    // (layout disabled or no room); native placement finds the site.
    IUnitTask@ LooseOrder(Task::BuildType type, CCircuitDef@ def) {
        return aiBuilderMgr.Enqueue(TaskB::Common(type, Task::Priority::HIGH, def, Global::Map::StartPos,
            SQUARE_SIZE * 32, true, int(Global::RoleSettings::Front::EcoBlockOrderSeconds * SECOND)));
    }
    // D-463 energy seat, in order: finish a started local structure; default
    // work while energy income is above the release; a geothermal near its
    // factory; wind turbines in a dense block on a windy map; native energy.
    bool energyPolicyLogged = false;
    IUnitTask@ EnergyWork(CCircuitUnit@ unit) {
        if (!energyPolicyLogged) {
            energyPolicyLogged = true;
            const AIFloat3 home = EnergyHome();
            GenericHelpers::LogUtil("[FrontConstructors] energy seat policy wind=" + int(ai.GetWindMin()) + ".."
                + int(ai.GetWindMax()) + " windy=" + (FrontConstructorMath::Windy(ai.GetWindMin(), ai.GetWindMax(),
                Global::RoleSettings::Front::EnergySeatWindAverage) ? 1 : 0) + " geoHome=" + int(home.x) + ","
                + int(home.z) + " converterSeat=" + (ConverterWanted() ? 1 : 0), 1);
        }
        IBuilderTask@ current=cast<IBuilderTask>(unit.task);
        if (Started(current)) return current;
        if (!FrontConstructorMath::EnergyHeld(Economy::GetMinEnergyIncomeLast10s(),
            Global::RoleSettings::Front::EnergySeatReleaseIncome)) return aiBuilderMgr.DefaultMakeTask(unit);
        IUnitTask@ geo = EnergyGeo(unit, current);
        if (geo !is null) return geo;
        CCircuitDef@ wind = WindDef(unit);
        if (current !is null && !current.IsDead() && Local(current)
            && current.GetBuildType()==int(Task::BuildType::ENERGY)) {
            if (wind is null || current.buildDef is wind) return current;
            // INV-250: with wind slots open, a held energy seat builds wind.
            FrontEcoBlocks::Load();
            if (FrontEcoBlocks::Open(FrontEcoBlocks::WIND))
                Invariants::Violation("INV-250", "front-energy", "held FRONT energy seat " + unit.id + " had a "
                    + current.buildDef.GetName() + " job with wind block slots open");
        }
        if (wind !is null) {
            IUnitTask@ task = FrontEcoBlocks::Order(FrontEcoBlocks::WIND, unit, wind, Task::BuildType::ENERGY,
                Global::RoleSettings::Front::WindBlockColumns, Global::RoleSettings::Front::WindBlockRows);
            if (task is null) @task = LooseOrder(Task::BuildType::ENERGY, wind);
            if (task !is null) {
                GenericHelpers::LogUtil("[FrontConstructors] energy wind builder=" + unit.id, 2);
                return task;
            }
        }
        // Ask for energy explicitly: default planning can select factory assist
        // indefinitely. Native selection retains affordability/wind/cap policy
        // and filters definitions before enqueueing for this worker.
        IUnitTask@ energy=aiEconomyMgr.EnqueueWorkerEnergy(unit);
        if(energy is null) return aiBuilderMgr.Enqueue(TaskB::Wait(SECOND));
        GenericHelpers::LogUtil("[FrontConstructors] energy work builder="+unit.id,1);
        return energy;
    }
    // D-463 converter seat. The BAR option unit_restrictions_noconverters
    // marks converters modoption_blocked, which the AI does not read, so the
    // option itself is checked (once; mod options are fixed for the game).
    bool ConvertersAllowed() {
        if (convertersAllowed < 0) {
            convertersAllowed = 1;
            dictionary@ options = aiSetupMgr.GetModOptions();
            string value;
            if (options !is null && options.get("unit_restrictions_noconverters", value)
                && value.length() > 0 && value != "0" && value != "false") convertersAllowed = 0;
        }
        if (convertersAllowed == 0) return false;
        CCircuitDef@ converter = ai.GetCircuitDef(UnitHelpers::GetEnergyConverterNameForSide(Global::AISettings::Side));
        return converter !is null && converter.maxThisUnit > 0;
    }
    // One-way: once metal income first exceeds the release, the seat is done.
    bool ConverterReleased() {
        Load();
        if (!converterReleased && FrontConstructorMath::ConverterReleases(Economy::GetMinMetalIncomeLast10s(),
            Global::RoleSettings::Front::ConverterSeatReleaseMetalIncome)) {
            converterReleased = true;
            aiTerrainMgr.SetLayoutInt("front.constructor.converter_released", 1);
            GenericHelpers::LogUtil("[FrontConstructors] converter seat released: metal income above "
                + int(Global::RoleSettings::Front::ConverterSeatReleaseMetalIncome), 1);
        }
        return converterReleased;
    }
    bool ConverterWanted() {
        if (!Global::RoleSettings::Front::ConverterSeatEnabled || aiEconomyMgr.IsMetalMap()) return false;
        return FrontConstructorMath::ConverterWanted(true, false, ConvertersAllowed(), ConverterReleased());
    }
    // D-463 converter seat, in order: finish a started local structure;
    // default work once released; with energy to spare, the next T1
    // converter in a dense block; else assist the energy seat.
    IUnitTask@ ConverterWork(CCircuitUnit@ unit) {
        IBuilderTask@ current=cast<IBuilderTask>(unit.task);
        const bool released = ConverterReleased();
        CCircuitDef@ converter = ai.GetCircuitDef(UnitHelpers::GetEnergyConverterNameForSide(
            UnitHelpers::GetSideForUnitName(unit.circuitDef.GetName())));
        if (!released && converter !is null && current !is null && !current.IsDead()
            && current.GetBuildType() < int(Task::BuildType::REPAIR) && current.buildDef !is converter)
            Invariants::Violation("INV-250", "front-converter", "held FRONT converter seat " + unit.id + " had a "
                + (current.buildDef is null ? "construction" : current.buildDef.GetName()) + " job");
        if (Started(current)) return current;
        if (released || converter is null || !unit.circuitDef.CanBuild(converter) || !converter.IsAvailable(ai.frame))
            return aiBuilderMgr.DefaultMakeTask(unit);
        if (current !is null && !current.IsDead() && Local(current)
            && current.GetBuildType()==int(Task::BuildType::CONVERT)) return current;
        if (!FrontConstructorMath::ConverterFunded(aiEconomyMgr.energy.current, aiEconomyMgr.energy.storage,
            Global::RoleSettings::Front::ConverterSeatEnergyFill, aiEconomyMgr.isEnergyStalling)) {
            CCircuitUnit@ energy = ai.GetTeamUnit(seats[ENERGY]);
            if (energy !is null && energy !is unit) return GuardHelpers::AssignWorkerGuard(unit, energy, Task::Priority::NORMAL, true, 10 * SECOND);
            return aiBuilderMgr.Enqueue(TaskB::Wait(SECOND));
        }
        IUnitTask@ task = FrontEcoBlocks::Order(FrontEcoBlocks::CONVERTER, unit, converter, Task::BuildType::CONVERT,
            Global::RoleSettings::Front::ConverterBlockColumns, Global::RoleSettings::Front::ConverterBlockRows);
        if (task is null) @task = LooseOrder(Task::BuildType::CONVERT, converter);
        if (task is null) return aiBuilderMgr.Enqueue(TaskB::Wait(SECOND));
        GenericHelpers::LogUtil("[FrontConstructors] converter work builder=" + unit.id, 2);
        return task;
    }
    bool Local(IUnitTask@ task) {
        IBuilderTask@ build = cast<IBuilderTask>(task);
        if (build is null) return false;
        const AIFloat3 p = build.GetBuildPos();
        const float radius = Global::RoleSettings::Front::BaseSupportRadius;
        return p.x >= 0.f && p.z >= 0.f && MapHelpers::SqDist(p, Global::Map::StartPos) <= radius * radius;
    }
    IUnitTask@ BaseWork(CCircuitUnit@ unit) {
        // Keep an in-progress local structure; never abort shared work merely
        // to select another economic rung. Native retreat/combat owns safety.
        IBuilderTask@ current = cast<IBuilderTask>(unit.task);
        if (current !is null && !current.IsDead() && current.target !is null
            && current.GetBuildType() < int(Task::BuildType::REPAIR) && Local(current)) return current;
        IUnitTask@ opening=OpeningSupport(unit);
        if (opening !is null) return opening;
        IUnitTask@ normal = aiBuilderMgr.DefaultMakeTask(unit);
        IBuilderTask@ build = cast<IBuilderTask>(normal);
        if (normal is null) return aiBuilderMgr.Enqueue(TaskB::Wait(SECOND));
        if (normal.GetType() == int(Task::Type::WAIT)) {
            // Native has no support admission once the FRONT planner owns it.
            // Preserve its other rungs; an idle base seat may fund a missing nano.
            if(FrontFactorySupport::Active()) {
                IUnitTask@ support=RoleFront::Front_TryBuildNano(Economy::GetMinMetalIncomeLast10s(),true);
                if(support !is null) return support;
            }
            return normal;
        }
        if (Local(normal) && build.GetBuildType() == int(Task::BuildType::ENERGY)) return normal;
        IUnitTask@ special = RoleFront::Front_T1Constructor_AiMakeTask(unit, null,
            Economy::GetMinMetalIncomeLast10s(), Economy::GetMinEnergyIncomeLast10s(),
            aiEconomyMgr.isEnergyStalling, aiEconomyMgr.isEnergyFull);
        if (special !is null) return special;
        if (Local(normal)) return normal;
        // Rejected fresh defaults are retired by the native default-task owner;
        // queued tasks belonging to other builders remain untouched.
        return aiBuilderMgr.Enqueue(TaskB::Patrol(Task::Priority::LOW, Global::Map::StartPos, 10 * SECOND));
    }
}
