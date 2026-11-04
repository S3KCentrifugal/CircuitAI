// FRONT recovery (owner, 2026-10-19; Front::Recovery, off in src). Played (2026-10-19, AI 11, Legion
// FRONT): the base fell at 30 min, metal income dropped from +80 to +3, the rebuilt T1 vehicle plant's
// constructor ordered a T2 vehicle plant at once, and for 8 minutes after that nothing was built (pull
// 0, bank up to 800). Recovery starts once metal income falls below Front::RecoveryEnterMetalIncome
// after it had reached Front::RecoveryMinPeakMetalIncome, and ends after Front::RecoveryExitSeconds at
// or above Front::RecoveryExitMetalIncome. While it lasts: T1 constructors and the commander (when
// CommanderFront has nothing for it) retake mex spots with a safe path (nearest the start first, then
// nearest the worker), solars while energy stalls; FRONT's T2 lab/plant, nano and second-factory
// orders wait; the T1 factory makes Front::RecoveryMinT1Constructors constructors first.
namespace FrontRecovery {
    bool active = false;
    float peak = 0.0f;
    int aboveSince = -1;
    int since = -1;
    int lastLog = -100000;
    int lastMexLog = -100000;

    bool On() { return Global::RoleSettings::Front::Recovery; }
    bool Active() { return On() && active; }

    int T1Constructors() {
        return UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllT1BotConstructors())
            + UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllT1VehicleConstructors());
    }

    void Update(float mi) {
        if (!On()) return;
        if (!active) {
            if (mi > peak) peak = mi;
            if (peak >= Global::RoleSettings::Front::RecoveryMinPeakMetalIncome
                && mi < Global::RoleSettings::Front::RecoveryEnterMetalIncome) {
                active = true; aboveSince = -1; since = ai.frame; lastLog = ai.frame;
                GenericHelpers::LogUtil("[FRONT][Recovery] on: metal income +" + int(mi) + " (peak +" + int(peak)
                    + ") | bank " + int(aiEconomyMgr.metal.current) + " | T1 constructors " + T1Constructors(), 1);
            }
            return;
        }
        if (mi >= Global::RoleSettings::Front::RecoveryExitMetalIncome) {
            if (aboveSince < 0) aboveSince = ai.frame;
            if (ai.frame - aboveSince >= Global::RoleSettings::Front::RecoveryExitSeconds * SECOND) {
                active = false; peak = mi;
                GenericHelpers::LogUtil("[FRONT][Recovery] off after " + ((ai.frame - since) / SECOND) + " s: metal income +" + int(mi), 1);
                return;
            }
        } else aboveSince = -1;
        if (ai.frame - lastLog >= 60 * SECOND) {
            lastLog = ai.frame;
            GenericHelpers::LogUtil("[FRONT][Recovery] " + ((ai.frame - since) / SECOND) + " s: metal income +" + int(mi)
                + " | bank " + int(aiEconomyMgr.metal.current) + " | T1 constructors " + T1Constructors(), 1);
        }
    }

    // Constructors the T1 factory makes first while recovering (0 when not recovering)
    int MinT1Constructors() { return Active() ? Global::RoleSettings::Front::RecoveryMinT1Constructors : 0; }

    // ---- Rebuild (owner, 2026-11-04) -------------------------------------
    // Played (2026-11-04, AI 16 = team 15, Armada FRONT, Ascendancy): commander,
    // T1 lab and every constructor lost by 10:35; TECH's recovery constructor
    // arrived at 12:54 at TECH's own base. It took the base seat, whose
    // BaseWork fell back to a PATROL toward the start (an engine patrol repairs
    // whatever it passes: it stopped on a Recluse) and Work() above was never
    // asked: the seated FRONT constructors return before the role handler.
    // Income +0..3 with 450 metal banked for the last 13 minutes of the game.
    // While recovering with no factory of ours or fewer than RebuildMexes mexes,
    // every T1 constructor of any seat, ahead of the seat work, retakes the
    // mexes nearest the start (the nearest safe ones if the start is held),
    // builds wind/solar to RebuildEnergyIncome and restarts the start factory.
    // Build orders walk it home directly: no patrol.
    IUnitTask@ rebuildPlant = null;
    IUnitTask@ rebuildEnergy = null;
    int rebuildPlantFrame = -1, rebuildEnergyFrame = -1;
    dictionary walkMoveFrame;   // constructor id -> frame of its last CmdMoveTo home

    // A cached rebuild order nobody has started within RebuildStaleSeconds is aborted
    // (headless round 2: the constructor idled 10 minutes on one far energy order).
    bool Stale(IUnitTask@ task, int since) {
        IBuilderTask@ b = cast<IBuilderTask>(task);
        return b !is null && b.target is null && ai.frame - since > Global::RoleSettings::Front::RebuildStaleSeconds * SECOND;
    }

    // Walk home on an explicit move (the Ferry::WaitForDelivery pattern): a held wait task plus
    // CmdMoveTo, re-issued every 8 s. Not a patrol (a patrol repairs whatever it passes) and not a
    // far build order (round 2: native never started an energy order 5,500 from the constructor).
    IUnitTask@ WalkHome(CCircuitUnit@ u, const AIFloat3 &in home) {
        int64 last = -100000;
        const bool walking = walkMoveFrame.get("" + u.id, last);
        IUnitTask@ cur = u.task;
        if (walking && cur !is null && !cur.IsDead() && cur.GetType() == int(Task::Type::WAIT)) {
            if (ai.frame - int(last) >= 8 * SECOND) { u.CmdMoveTo(home); walkMoveFrame.set("" + u.id, int64(ai.frame)); }
            return cur;
        }
        IUnitTask@ wait = aiBuilderMgr.Enqueue(TaskB::Wait(20 * SECOND));
        if (wait is null) return null;
        u.CmdMoveTo(home);
        walkMoveFrame.set("" + u.id, int64(ai.frame));
        RebuildLog(u, "walks home from " + int(u.GetPos(ai.frame).x) + "," + int(u.GetPos(ai.frame).z));
        return wait;
    }
    int lastRebuildLog = -100000;

    int OwnMexes() {
        const array<string> mexes = {"armmex", "cormex", "legmex", "armamex", "corexp", "legmohocon", "leganavalmex", "armuwmme", "coruwmme",
            "armmoho", "cormoho", "legmoho", "cormexp", "armshockwave"};
        return UnitDefHelpers::SumUnitDefCounts(mexes);
    }

    bool Rebuilding() {
        if (!On() || !Global::RoleSettings::Front::Rebuild) return false;
        const bool noFactory = aiFactoryMgr.GetFactoryCount() < 1;
        // An early wipe-out never reached the recovery peak: no factory and no commander is enough.
        if (!active && !(noFactory && Builder::commander is null && ai.frame >= 120 * SECOND)) return false;
        // Income below RebuildMetalIncome keeps the rebuild going only for a FRONT that lost its
        // factory (headless round 3: a struggling Legion FRONT with a lab and 3 cons switched on).
        if (noFactory) wiped = true;
        else if (aiEconomyMgr.metal.income >= Global::RoleSettings::Front::RebuildMetalIncome) wiped = false;
        return noFactory || OwnMexes() < Global::RoleSettings::Front::RebuildMexes
            || (wiped && aiEconomyMgr.metal.income < Global::RoleSettings::Front::RebuildMetalIncome);
    }
    bool wiped = false;

    void RebuildLog(CCircuitUnit@ u, const string &in what) {
        if (ai.frame - lastRebuildLog < 10 * SECOND) return;
        lastRebuildLog = ai.frame;
        GenericHelpers::LogUtil("[FRONT][Rebuild] " + u.circuitDef.GetName() + " " + u.id + ": " + what
            + " | mexes " + OwnMexes() + " | factories " + aiFactoryMgr.GetFactoryCount()
            + " | M +" + int(aiEconomyMgr.metal.income) + " bank " + int(aiEconomyMgr.metal.current)
            + " | E +" + int(aiEconomyMgr.energy.income), 1);
    }

    // The start unless the enemy holds it (surface threat above RebuildHomeThreat), else where it stands.
    // Headless 2026-11-04: CanReachAtSafe failed on any threat above THREAT_MIN at the start, so the
    // constructor built its wind, mexes and lab at the ally's base where it had been handed over.
    AIFloat3 RebuildAnchor(CCircuitUnit@ u) {
        if (aiBattle.SurfThreat(Global::Map::StartPos) <= Global::RoleSettings::Front::RebuildHomeThreat)
            return Global::Map::StartPos;
        return u.GetPos(ai.frame);
    }

    bool ShortOfMetal() {
        return OwnMexes() < Global::RoleSettings::Front::RebuildMexes
            || aiEconomyMgr.metal.income < Global::RoleSettings::Front::RebuildMetalIncome;
    }

    IUnitTask@ RebuildEnergyTask(CCircuitUnit@ u, const AIFloat3 &in anchor) {
        if (rebuildEnergy !is null && !rebuildEnergy.IsDead()) {
            if (!Stale(rebuildEnergy, rebuildEnergyFrame)) return rebuildEnergy;
            rebuildEnergy.Abort();
        }
        @rebuildEnergy = null;
        const string side = UnitHelpers::GetSideForUnitName(u.circuitDef.GetName());
        const bool windy = (ai.GetWindMin() + ai.GetWindMax()) * 0.5f >= Global::RoleSettings::Front::RebuildWindMin;
        array<string> names = {UnitHelpers::GetSolarNameForSide(side), UnitHelpers::GetWindNameForSide(side)};
        if (windy) names.reverse();
        for (uint i = 0; i < names.length(); ++i) {
            if (Global::energyAllowed !is null && !Global::energyAllowed(names[i])) continue;   // D-077
            CCircuitDef@ d = ai.GetCircuitDef(names[i]);
            if (d is null || !u.circuitDef.CanBuild(d) || !d.IsAvailable(ai.frame)) continue;
            @rebuildEnergy = aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::ENERGY, Task::Priority::NOW, d, anchor,
                SQUARE_SIZE * 24, true, 60 * SECOND));
            if (rebuildEnergy !is null) { rebuildEnergyFrame = ai.frame; RebuildLog(u, "energy " + d.GetName()); return rebuildEnergy; }
        }
        return null;
    }

    IUnitTask@ RebuildFactoryTask(CCircuitUnit@ u, const AIFloat3 &in anchor) {
        if (rebuildPlant !is null && !rebuildPlant.IsDead()) {
            if (!Stale(rebuildPlant, rebuildPlantFrame)) return rebuildPlant;
            rebuildPlant.Abort();
        }
        @rebuildPlant = null;
        IUnitTask@ queued = aiBuilderMgr.FindQueuedTask(u, int(Task::BuildType::FACTORY));
        IBuilderTask@ qb = cast<IBuilderTask>(queued);
        if (qb !is null && qb.buildDef !is null && !qb.buildDef.IsMobile() && qb.buildDef.GetBuildSpeed() > 0) {
            @rebuildPlant = queued; rebuildPlantFrame = ai.frame; RebuildLog(u, "adopts the queued " + qb.buildDef.GetName()); return queued;
        }
        // The start factory first (the roster's), then any T1 lab/plant this constructor can build.
        array<string> names;
        Team::Roster::Entry@ self = Team::Roster::Get(ai.teamId);
        if (self !is null && self.startFactory.length() > 0) names.insertLast(self.startFactory);
        const string side = UnitHelpers::GetSideForUnitName(u.circuitDef.GetName());
        names.insertLast(UnitHelpers::GetT1BotLabForSide(side));
        const array<string> vehs = UnitHelpers::GetAllT1VehicleLabs();
        for (uint i = 0; i < vehs.length(); ++i) names.insertLast(vehs[i]);
        const array<string> bots = UnitHelpers::GetAllT1BotLabs();
        for (uint i = 0; i < bots.length(); ++i) names.insertLast(bots[i]);
        for (uint i = 0; i < names.length(); ++i) {
            CCircuitDef@ d = ai.GetCircuitDef(names[i]);
            if (d is null || !u.circuitDef.CanBuild(d)) continue;
            if (d.maxThisUnit <= d.count) d.maxThisUnit = d.count + 1;   // a lost plant may have left the cap full
            if (!d.IsAvailable(ai.frame)) continue;
            @rebuildPlant = aiBuilderMgr.Enqueue(TaskB::Factory(Task::Priority::NOW, d, anchor, d,
                SQUARE_SIZE * 32, false, true, 300 * SECOND));
            if (rebuildPlant !is null) { rebuildPlantFrame = ai.frame; RebuildLog(u, "restarts " + d.GetName()); return rebuildPlant; }
        }
        return null;
    }

    IUnitTask@ Rebuild(CCircuitUnit@ u) {
        if (u is null || u.circuitDef is null || !Rebuilding()) return null;
        if (UnitHelpers::IsCommander(u.circuitDef) || UnitHelpers::GetConstructorTier(u.circuitDef) != 1) return null;
        // Finish a started mex, energy or factory frame of ours; never swap it.
        IBuilderTask@ cur = cast<IBuilderTask>(u.task);
        if (cur !is null && !cur.IsDead() && cur.target !is null) {
            const int bt = cur.GetBuildType();
            if (bt == int(Task::BuildType::MEX) || bt == int(Task::BuildType::ENERGY) || bt == int(Task::BuildType::FACTORY)) return u.task;
        }
        const AIFloat3 anchor = RebuildAnchor(u);
        IUnitTask@ t = null;
        // 0. home first: nothing is built until the constructor is within RebuildHomeRadius of the start
        const bool home = anchor.x == Global::Map::StartPos.x && anchor.z == Global::Map::StartPos.z;
        const float homeR = Global::RoleSettings::Front::RebuildHomeRadius;
        if (home && MapHelpers::SqDist(u.GetPos(ai.frame), anchor) > homeR * homeR) {
            @t = WalkHome(u, anchor);
            if (t !is null) return t;
        }
        walkMoveFrame.delete("" + u.id);
        // 1. the start mexes, and more until metal income reaches RebuildMetalIncome (mexes before energy)
        if (ShortOfMetal()) {
            @t = aiEconomyMgr.EnqueueMexWithin(u, anchor, Global::RoleSettings::Front::RebuildHomeRadius, 0, true);
            if (t is null) @t = aiEconomyMgr.EnqueueMexWithin(u, anchor, Global::RoleSettings::Front::RecoveryMexRadius, 0, true);
            // near the constructor only when the start is held
            if (t is null && !home) @t = aiEconomyMgr.EnqueueMexWithin(u, u.GetPos(ai.frame), Global::RoleSettings::Front::RecoveryMexRadius, 0, true);
            if (t !is null) { RebuildLog(u, "mex"); return t; }
        }
        // 2. wind/solar
        if (aiEconomyMgr.energy.income < Global::RoleSettings::Front::RebuildEnergyIncome || aiEconomyMgr.isEnergyStalling) {
            @t = RebuildEnergyTask(u, anchor);
            if (t !is null) return t;
        }
        // 3. the factory
        if (aiFactoryMgr.GetFactoryCount() < 1) {
            @t = RebuildFactoryTask(u, anchor);
            if (t !is null) return t;
        }
        return null;
    }

    IUnitTask@ Work(CCircuitUnit@ u) {
        if (!Active() || u is null || u.circuitDef is null) return null;
        const bool commander = UnitHelpers::IsCommander(u.circuitDef);
        if (!commander && UnitHelpers::GetConstructorTier(u.circuitDef) != 1) return null;
        IUnitTask@ t = null;
        if (aiEconomyMgr.isEnergyStalling) {
            @t = Builder::EnqueueT1Solar(u.id, Global::AISettings::Side, u.GetPos(ai.frame), SQUARE_SIZE * 16, 60 * SECOND);
            if (t !is null) return t;
        }
        const float radius = Global::RoleSettings::Front::RecoveryMexRadius;
        @t = aiEconomyMgr.EnqueueMexWithin(u, Global::Map::StartPos, radius, 0, true);
        if (t is null) @t = aiEconomyMgr.EnqueueMexWithin(u, u.GetPos(ai.frame), radius, 0, true);
        if (t !is null && ai.frame - lastMexLog >= 20 * SECOND) {
            lastMexLog = ai.frame;
            IBuilderTask@ b = cast<IBuilderTask>(t);
            const AIFloat3 p = (b is null) ? u.GetPos(ai.frame) : b.GetBuildPos();
            GenericHelpers::LogUtil("[FRONT][Recovery] mex at " + int(p.x) + "," + int(p.z) + " by " + u.circuitDef.GetName() + " " + u.id, 1);
        }
        return t;
    }
}
