// Owner 2026-11-23 (Moonshine Run: three FRONTs ordered their first T2 factory 2.5 to 12 minutes after a
// trigger passed). Only FRONT's base-seat constructor ran the first-T2 rule (front.as Front_T1Constructor_AiMakeTask),
// behind about 15 other rungs and the mex/energy early return, so while it built mexes, energy or repairs nobody
// ordered the lab. Now, once a first-T2 trigger passes (the 10 s minimum metal income at the first-lab threshold,
// stored metal at T2LabStoredMetalThresholdRatio x the factory's cost, or TimeTriggerForFirstT2LabSeconds with its
// income floor), a T1 lab/plant builds ONE extra T1 constructor whose only job is the first T2 factory:
//  - it orders it through the existing helpers (Builder::EnqueueT2BotLabIfNeeded / EnqueueT2VehiclePlant: the same
//    site search round the start, the same 300 s / 600 s order timeouts and the 180 s T2 cooldown);
//  - it joins a live T2 factory order someone else gave (base seat, native factory switch) instead of a second one;
//  - while a gate blocks the order it assists the T1 factory, and after T2LabCrewMaxBlockedSeconds it is released;
//  - when a T2 factory of ours stands it is released into the general builder pool (a FRONT seat if one is open).
// One [FRONT][T2Lab] line, at most every T2LabCrewLogSeconds once a trigger has passed, names the gate that blocks.
// Null guards: the crew is held by id only and resolved with ai.GetTeamUnit at every use; task handles are checked
// with IsDead and dropped in TaskRemoved; after release crewId is -1, so Owns/Work return false/null for everyone.
namespace FrontT2LabCrew {
    int crewId = -1;
    bool crewBot = true;          // the crew builds a T2 bot lab (else a T2 vehicle plant)
    bool released = false;        // one-shot: a T2 factory of ours stood
    IUnitTask@ recruit = null;    // the T1 factory's order for the crew
    string recruitDef = "";
    int recruitFactory = -1;
    int recruitFrame = -100000;
    IUnitTask@ order = null;      // our T2 factory order
    IUnitTask@ anyOrder = null;   // the latest live T2 bot/vehicle factory order on our team, ours or not
    int blockedSince = -1;
    int lastLog = -100000;
    string lastGate = "";
    bool wanted = false;
    string latched = "";          // the first trigger that passed: kept, so an income dip below the line does not undo it
    int lastFactoryAsk = -100000; // last T1 lab/plant ask that reached FactoryMakeTask (log only)

    const int RecruitRetryFrames = 30 * SECOND;   // a finished recruit's unit is still being admitted
    const int ClaimFrames = 240 * SECOND;         // a recruit not delivered by then is not ours any more

    bool Enabled() {
        return Global::AISettings::Role == AiRole::FRONT && Global::RoleSettings::Front::T2LabCrewEnabled;
    }
    bool IsT2Factory(const CCircuitDef@ d) {
        if (d is null) return false;
        const string n = d.GetName();
        return UnitHelpers::IsT2BotLab(n) || UnitHelpers::IsT2VehicleLab(n);
    }
    bool Live(IUnitTask@ t) { return t !is null && !t.IsDead(); }
    // A live order someone is on: framed, or with a builder assigned. Moonshine Run headless (2026-11-23):
    // queued T2 factory orders nobody took sat for minutes, so a bare live order must not block the crew.
    bool Staffed(IUnitTask@ t) {
        if (!Live(t)) return false;
        IBuilderTask@ b = cast<IBuilderTask>(t);
        if (b !is null && b.target !is null) return true;
        array<CCircuitUnit@>@ us = t.GetUnits();
        return us !is null && us.length() > 0;
    }
    string OrderState(IUnitTask@ t) {
        IBuilderTask@ b = cast<IBuilderTask>(t);
        array<CCircuitUnit@>@ us = t.GetUnits();
        return (b !is null && b.buildDef !is null ? b.buildDef.GetName() : "?") + (b !is null && b.target !is null ? " framed" : " not framed")
            + " builders=" + (us is null ? 0 : us.length());
    }
    CCircuitUnit@ Crew() { return crewId < 0 ? null : ai.GetTeamUnit(crewId); }
    bool Owns(CCircuitUnit@ u) { return u !is null && crewId >= 0 && u.id == crewId; }
    // T1 constructor cap +1 while the crew is wanted, ordered or alive (front.as Front_IncomeBuilderLimits)
    int ExtraCap() {
        if (!Enabled() || released) return 0;
        return (wanted || crewId >= 0 || Live(recruit)) ? 1 : 0;
    }

    // A finished T2 bot lab or vehicle plant of ours (Factory::allFactories holds finished factories; a few entries)
    bool T2Standing() {
        array<string>@ keys = Factory::allFactories.getKeys();
        for (uint i = 0; i < keys.length(); ++i) {
            CCircuitUnit@ f = null;
            if (!Factory::allFactories.get(keys[i], @f) || f is null || f.circuitDef is null) continue;
            if (f.GetBuildProgress() >= 1.0f && IsT2Factory(f.circuitDef)) return true;
        }
        return false;
    }
    string LabName(bool bot, const string &in side) {
        if (bot) return UnitHelpers::GetT2BotLabForSide(side);
        return side == "armada" ? "armavp" : side == "cortex" ? "coravp" : side == "legion" ? "legavp" : "";
    }
    CCircuitDef@ LabDef(bool bot, const string &in side) {
        const string n = LabName(bot, side);
        return n.length() == 0 ? null : ai.GetCircuitDef(n);
    }
    // The first-T2 trigger that passed, or "" (the same three triggers as front.as Front_T1Constructor_AiMakeTask)
    string Trigger(bool bot, const string &in side, float mi) {
        const float income = bot ? Global::RoleSettings::Front::MinimumMetalIncomeForFirstT2Lab
            : Global::RoleSettings::Front::MinimumMetalIncomeForFirstT2VehiclePlant;
        if (mi >= income) return "income";
        CCircuitDef@ def = LabDef(bot, side);
        if (def !is null && aiEconomyMgr.metal.current >= def.costM * Global::RoleSettings::Front::T2LabStoredMetalThresholdRatio) return "bank";
        if (ai.frame >= Global::RoleSettings::Front::TimeTriggerForFirstT2LabSeconds * SECOND
            && mi >= Global::RoleSettings::Front::TimeTriggerForFirstT2LabMinMetalIncome) return "time";
        return "";
    }
    // "" when a T2 factory order may be given now, else the gate that blocks it
    string Gate(bool bot, const string &in side, bool cooldown = true) {
        if (FrontRecovery::Active()) return "recovering";
        if (!Team::Donation::FrontFactoryAllowed()) return "donation floor";
        if (!cooldown) {}
        else if (bot && !Builder::IsT2BotFactoryOffCooldown())
            return "cooldown " + ((Builder::T2_FACTORY_COOLDOWN_FRAMES - (ai.frame - Builder::lastT2BotFactoryEnqueueFrame)) / SECOND) + " s";
        else if (!bot && !Builder::IsT2VehFactoryOffCooldown())
            return "cooldown " + ((Builder::T2_FACTORY_COOLDOWN_FRAMES - (ai.frame - Builder::lastT2VehFactoryEnqueueFrame)) / SECOND) + " s";
        CCircuitDef@ def = LabDef(bot, side);
        if (def is null) return "no T2 factory for side " + side;
        if (!def.IsAvailable(ai.frame)) return "cap/not available (" + def.GetName() + ")";
        return "";
    }
    // Which T2 factory the next crew builds: the kind of our primary T1 factory (bot lab first)
    bool KindBot() {
        if (Factory::primaryT1BotLab !is null) return true;
        if (Factory::primaryT1VehPlant !is null) return false;
        return true;
    }

    void Release(const string &in why, bool done) {
        const int id = crewId;
        crewId = -1;
        blockedSince = -1;
        if (done) released = true;
        if (id < 0) return;
        GenericHelpers::LogUtil("[FRONT][T2Lab] crew " + id + " released: " + why, 1);
        CCircuitUnit@ unit = ai.GetTeamUnit(id);   // null guard: it may have died this frame
        if (unit !is null) FrontConstructors::OnAdded(unit);   // a FRONT seat if one is open, else the general pool
    }

    // Factory hook (manager/factory.as, FRONT block, after the seat recruits): one crew per trigger
    IUnitTask@ FactoryMakeTask(CCircuitUnit@ factory) {
        if (!Enabled() || released || factory is null || factory.circuitDef is null) return null;
        if (crewId >= 0 || Live(recruit) || ai.frame - recruitFrame < RecruitRetryFrames) return null;
        if (factory.GetBuildProgress() < 1.0f) return null;
        const string fname = factory.circuitDef.GetName();
        const bool bot = UnitHelpers::IsT1BotLab(fname);
        if (!bot && !UnitHelpers::IsT1VehicleLab(fname)) return null;
        lastFactoryAsk = ai.frame;
        if (Staffed(anyOrder)) return null;   // a T2 factory order is framed or has a builder on it
        const string side = UnitHelpers::GetSideForUnitName(fname);
        const float mi = Economy::GetMinMetalIncomeLast10s();
        string trig = Trigger(bot, side, mi);
        if (trig.length() > 0 && latched.length() == 0) latched = trig;
        // Moonshine Run headless (2026-11-23): the 10 s minimum income hovered at +50, so a trigger checked only at
        // the factory's ask missed for minutes; the first trigger that passed holds
        if (trig.length() == 0) trig = latched;
        // Moonshine Run headless (2026-11-23): the base seat re-ordered the lab every 180 s and each order died
        // unstaffed, so the cooldown never ran out; the crew joins such an order, or waits out the cooldown assisting
        if (trig.length() == 0 || Gate(bot, side, false).length() > 0 || T2Standing()) return null;
        for (uint i = 0; i < FrontConstructors::candidates.length(); ++i) {
            CCircuitDef@ def = ai.GetCircuitDef(FrontConstructors::candidates[i]);
            if (def is null || !factory.circuitDef.CanBuild(def) || !def.IsAvailable(ai.frame)) continue;
            IUnitTask@ task = aiFactoryMgr.Enqueue(TaskS::Recruit(Task::RecruitType::BUILDPOWER,
                Task::Priority::HIGH, def, factory.GetPos(ai.frame), 64.f));
            if (task is null) return null;
            @recruit = task;
            recruitDef = def.GetName();
            recruitFactory = factory.id;
            recruitFrame = ai.frame;
            crewBot = bot;
            GenericHelpers::LogUtil("[FRONT][T2Lab] crew recruit " + recruitDef + " at factory " + factory.id
                + " for " + LabName(bot, side) + " trigger=" + trig + " mi=" + int(mi)
                + " bank=" + int(aiEconomyMgr.metal.current), 1);
            return task;
        }
        return null;
    }

    // Builder admission (manager/builder.as, before FrontConstructors::OnAdded): the recruit becomes the crew
    bool OnAdded(CCircuitUnit@ unit) {
        if (!Enabled() || released || crewId >= 0 || recruitDef.length() == 0 || unit is null || unit.circuitDef is null) return false;
        if (ai.frame - recruitFrame > ClaimFrames) { recruitDef = ""; return false; }
        if (unit.circuitDef.GetName() != recruitDef || unit.GetProducerId() != recruitFactory) return false;
        if (Team::Ferry::IsGift(unit.id) || Team::Recovery::IsGift(unit.id)) return false;
        crewId = unit.id;
        recruitDef = "";
        blockedSince = -1;
        unit.AddAttribute(Unit::Attr::BASE.type);
        GenericHelpers::LogUtil("[FRONT][T2Lab] crew " + unit.id + " (" + unit.circuitDef.GetName() + ") holds the first T2 factory job", 1);
        return true;
    }
    void OnRemoved(CCircuitUnit@ unit) {
        if (unit is null || crewId < 0 || unit.id != crewId) return;
        GenericHelpers::LogUtil("[FRONT][T2Lab] crew " + crewId + " lost", 1);
        crewId = -1;
        blockedSince = -1;
    }

    // Builder tasks (manager/builder.as AiTaskAdded / AiTaskRemoved)
    void TaskAdded(IUnitTask@ task) {
        if (!Enabled() || released) return;
        IBuilderTask@ b = cast<IBuilderTask>(task);
        if (b is null || b.IsDead() || !IsT2Factory(b.buildDef)) return;
        @anyOrder = task;
    }
    void TaskRemoved(IUnitTask@ task, bool done) {
        if (task is null) return;
        if (task is order) {
            GenericHelpers::LogUtil("[FRONT][T2Lab] our T2 factory order ended " + (done ? "built" : "unfinished"), 1);
            @order = null;
        }
        if (task is anyOrder) @anyOrder = null;
    }

    // Builder ask (manager/builder.as, FRONT block, first): the crew's only job
    IUnitTask@ Work(CCircuitUnit@ u) {
        if (!Owns(u) || u.circuitDef is null) return null;
        IUnitTask@ cur = u.task;
        if (Live(cur) && (cur.IsExternalControlled() || cur.GetType() == int(Task::Type::PLAYER)
            || cur.GetType() == int(Task::Type::RETREAT))) return cur;
        if (FrontRecovery::Active()) { Release("recovering", false); return null; }
        if (T2Standing()) { Release("a T2 factory stands", true); return null; }
        if (Live(order)) return order;
        if (Live(anyOrder)) {
            IBuilderTask@ b = cast<IBuilderTask>(anyOrder);
            if (b !is null && b.target !is null) {
                // a frame stands: help it up, whoever's order it is
                if (cur is anyOrder) return cur;
                if (b.buildDef !is null && u.circuitDef.CanBuild(b.buildDef)) return anyOrder;
                return aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::HIGH, b.target, 30 * SECOND));
            }
            if (b !is null && b.buildDef !is null && u.circuitDef.CanBuild(b.buildDef)) return anyOrder;
            // an unframed order of a kind we cannot build: our own kind below (MaxT2BotLabs/MaxT2VehicleLabs still cap)
            if (Staffed(anyOrder)) {
                if (blockedSince < 0) blockedSince = ai.frame;
                return FrontConstructors::AssistFactory(u);
            }
        }
        const string side = UnitHelpers::GetSideForUnitName(u.circuitDef.GetName());
        string gate = Gate(crewBot, side);
        if (gate.length() == 0) {
            IUnitTask@ t = crewBot
                ? Builder::EnqueueT2BotLabIfNeeded(side, Global::Map::StartPos, SQUARE_SIZE * 30, SECOND * 300)
                : Builder::EnqueueT2VehiclePlant(side, Global::Map::StartPos, SQUARE_SIZE * 24, 600 * SECOND);
            if (t !is null) {
                // native's income-drop auto-abort of a >1000-metal build killed such orders within seconds
                // (front gantry, 2026-11-09); the order's own timeout still ends it
                IBuilderTask@ b = cast<IBuilderTask>(t);
                if (b !is null) b.canAutoAbort = false;
                @order = t;
                @anyOrder = t;
                blockedSince = -1;
                GenericHelpers::LogUtil("[FRONT][T2Lab] crew " + u.id + " ordered " + LabName(crewBot, side)
                    + " mi=" + int(Economy::GetMinMetalIncomeLast10s()) + " bank=" + int(aiEconomyMgr.metal.current), 1);
                return t;
            }
            gate = "order refused";
        }
        lastGate = gate;
        if (blockedSince < 0) blockedSince = ai.frame;
        if (ai.frame - blockedSince > int(Global::RoleSettings::Front::T2LabCrewMaxBlockedSeconds * SECOND)) {
            Release("blocked " + int(Global::RoleSettings::Front::T2LabCrewMaxBlockedSeconds) + " s: " + gate, false);
            return null;
        }
        return FrontConstructors::AssistFactory(u);
    }

    // Once a second (front.as Front_MainUpdate): release once a T2 factory stands; the gate log line
    void Tick() {
        if (!Enabled() || released) return;
        if (T2Standing()) {
            wanted = false;
            if (crewId >= 0) Release("a T2 factory stands", true);
            else { released = true; GenericHelpers::LogUtil("[FRONT][T2Lab] a T2 factory stands; crew not needed any more", 1); }
            return;
        }
        if (crewId >= 0 && Crew() is null) { crewId = -1; blockedSince = -1; }   // null guard: died unseen
        const string side = Global::AISettings::Side;
        const bool bot = crewId >= 0 ? crewBot : KindBot();
        const float mi = Economy::GetMinMetalIncomeLast10s();
        string trig = Trigger(bot, side, mi);
        if (trig.length() > 0 && latched.length() == 0) latched = trig;
        if (trig.length() == 0 && latched.length() > 0) trig = latched + " (held)";
        wanted = trig.length() > 0;
        if (!wanted && crewId < 0) return;
        if (ai.frame - lastLog < int(Global::RoleSettings::Front::T2LabCrewLogSeconds * SECOND)) return;
        lastLog = ai.frame;
        string state;
        if (Live(order)) state = "ordered (crew): " + OrderState(order);
        else if (Staffed(anyOrder)) state = "ordered (other): " + OrderState(anyOrder);
        else {
            const string gate = Gate(bot, side);
            if (gate.length() > 0) state = "blocked: " + gate;
            else if (crewId >= 0) state = "blocked: crew not asked yet" + (lastGate.length() > 0 ? " (last " + lastGate + ")" : "");
            else if (Live(recruit)) state = "blocked: crew recruit in production at factory " + recruitFactory;
            else state = "blocked: no crew (last T1 factory ask " + (lastFactoryAsk < 0 ? "never" : "" + ((ai.frame - lastFactoryAsk) / SECOND) + " s ago") + ")";
            if (Live(anyOrder)) state += "; unstaffed order " + OrderState(anyOrder);
        }
        GenericHelpers::LogUtil("[FRONT][T2Lab] want=" + (bot ? "bot" : "veh") + " mi=" + int(mi)
            + " ei=" + int(Economy::GetMinEnergyIncomeLast10s()) + " bank=" + int(aiEconomyMgr.metal.current)
            + " trigger=" + (trig.length() > 0 ? trig : "none") + " crew=" + (crewId >= 0 ? "" + crewId : "none")
            + " -> " + state, 1);
    }
}
