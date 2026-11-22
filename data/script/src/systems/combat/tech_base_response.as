// TECH's temporary home defense. Uses the shared enemy spatial publication,
// one local query per second; no army scan and no per-unit polling/order loop.
namespace TechBaseResponse {
    int updated = -100000, clearSince = -1, target = -1;
    bool active = false;
    AIFloat3 aim;
    CRouteTask@ group;
    dictionary productionSince, productionUntil; // per-lab emergency birth windows
    dictionary defenders; // owned product IDs, removed on death/transfer and reset on load

    bool Enabled() { return Global::AISettings::Role == AiRole::TECH
        && Global::RoleSettings::Tech::BaseResponseRadius > 0.f; }
    bool CombatDef(const CCircuitDef@ def) {
        if (def is null) return false;
        const string name = def.GetName();
        return name == "armpw" || name == "corak" || name == "leggob"
            || name == "armfast" || name == "corpyro" || name == "legstr";
    }
    bool Lab(CCircuitUnit@ u) {
        return u !is null && (UnitHelpers::IsT1BotLab(u.circuitDef.GetName())
            || UnitHelpers::IsT2BotLab(u.circuitDef.GetName()));
    }
    void ClearGroup() {
        CRouteTask@ previous = group;
        @group = null;
        if (previous !is null && !previous.IsDead()) previous.Abort();
    }
    void Reset() {
        active = false; updated = -100000; clearSince = -1; target = -1;
        ClearGroup(); defenders.deleteAll(); productionSince.deleteAll(); productionUntil.deleteAll();
    }
    void Tick() {
        if (!Enabled()) { if (active) Reset(); return; }
        if (ai.frame < updated + SECOND) return;
        updated = ai.frame;
        AIFloat3 observed;
        const int contact = aiBattle.LocalGroundContact(Layout::BaseCentre(),
            Global::RoleSettings::Tech::BaseResponseRadius,
            Global::RoleSettings::Tech::BaseResponseMemorySeconds, observed);
        if (contact == -2) return; // stale observation cannot clear an active defense
        if (contact < 0) {
            if (!active) return;
            if (clearSince < 0) clearSince = ai.frame;
            if (ai.frame - clearSince < int(Global::RoleSettings::Tech::BaseResponseClearSeconds * SECOND)) return;
            active = false; target = -1;
            array<string>@ origins = productionSince.getKeys();
            for (uint i = 0; i < origins.length(); ++i) {
                int until = -1;
                if (productionUntil.get(origins[i], until) && until < 0) productionUntil.set(origins[i], ai.frame);
            }
            ClearGroup();
            GenericHelpers::LogUtil("[TECH][BaseResponse] clear: resume economy", 1);
            return;
        }
        clearSince = -1;
        const bool entering = !active;
        active = true;
        const bool changed = contact != target || aim.SqDistance2D(observed) >= 64.f * 64.f;
        target = contact; aim = observed;
        if (group is null || group.IsDead()) {
            @group = cast<CRouteTask>(aiMilitaryMgr.Enqueue(TaskF::Route()));
            if (group !is null) {
                group.SetTraversal(true, 64.f, true);
                group.SetLanes(1, 0.f, 0.f);
                array<AIFloat3> path = {aim};
                group.SetRoute(path);
                if (!group.SetLandTarget(target)) group.SetLandTarget(-1);
            }
        } else if (changed) {
            array<AIFloat3> path = {aim};
            group.SetRoute(path);
            if (!group.SetLandTarget(target)) group.SetLandTarget(-1);
        }
        if (entering) {
            GenericHelpers::LogUtil("[TECH][BaseResponse] active: land contact " + target, 1);
            // Wake idle labs once on entry, never cancel a paid product. Factory
            // lifecycle remains authoritative. O(F) only on emergency transition.
            for (uint i = 0; i < Factory::factoryList.length(); ++i) {
                CCircuitUnit@ lab = Factory::factoryList[i];
                if (!Lab(lab) || Lifecycle::IsRetiring(lab)) continue;
                IUnitTask@ task = lab.task;
                if (task !is null && task.GetType() == int(Task::Type::WAIT)) aiFactoryMgr.AbortTask(task);
            }
        }
    }
    bool Emergency() { Tick(); return Enabled() && active; }
    IUnitTask@ Produce(CCircuitUnit@ lab) {
        if (!Enabled() || !Lab(lab) || Lifecycle::IsRetiring(lab) || !Emergency()) return null;
        const float radius = Global::RoleSettings::Tech::BaseResponseRadius;
        if (lab.GetPos(ai.frame).SqDistance2D(Layout::BaseCentre()) > radius * radius) return null;
        const string side = UnitHelpers::GetSideForUnitName(lab.circuitDef.GetName());
        string name;
        if (UnitHelpers::IsT2BotLab(lab.circuitDef.GetName())) {
            array<string> names = UnitHelpers::GetFastT2Bots(side);
            if (names.length() > 0) name = names[0];
        } else name = side == "armada" ? "armpw" : side == "cortex" ? "corak" : "leggob";
        CCircuitDef@ def = ai.GetCircuitDef(name);
        if (def is null || !def.IsBuildAllowed() || !lab.circuitDef.CanBuild(def)) return null;
        // Explicit single-product admission bypasses TECH's economic income/cap
        // gates without changing shared definition caps. No long queue or repeat
        // survives the emergency. Engine build restrictions remain authoritative.
        const string origin = "" + lab.id;
        int until = -1;
        if (!productionSince.exists(origin) || (productionUntil.get(origin, until) && until >= 0))
            productionSince.set(origin, ai.frame);
        productionUntil.set(origin, -1);
        GenericHelpers::LogUtil("[TECH][BaseResponse] recruit " + name + " lab=" + lab.id, 1);
        IUnitTask@ job = aiFactoryMgr.Enqueue(TaskS::Recruit(Task::RecruitType::FIREPOWER,
            Task::Priority::HIGH, def, lab.GetPos(ai.frame), 64.f), true);
        IBuilderTask@ recruit = cast<IBuilderTask>(job);
        if (job !is null && (recruit is null || recruit.buildDef !is def))
            Invariants::Violation("INV-277", "base-response", "emergency recruit does not match admitted defender");
        return job;
    }
    bool OnFinished(CCircuitUnit@ u) {
        if (!Enabled() || u is null || !CombatDef(u.circuitDef)) return false;
        int since = -1, until = -1;
        const string origin = "" + u.GetProducerId();
        const bool produced = productionSince.get(origin, since) && productionUntil.get(origin, until)
            && u.GetProductionFrame() >= since && (until < 0 || u.GetProductionFrame() <= until);
        const float radius = Global::RoleSettings::Tech::BaseResponseRadius;
        const bool local = Emergency() && u.GetPos(ai.frame).SqDistance2D(Layout::BaseCentre()) <= radius * radius;
        if (!produced && !local) return false;
        defenders.set("" + u.id, true); // intercept before donation/heavy/offensive ownership
        return true;
    }
    IUnitTask@ TaskFor(CCircuitUnit@ u) {
        if (!Enabled() || u is null || !CombatDef(u.circuitDef)) return null;
        IUnitTask@ current = u.task;
        if (current !is null && (current.IsExternalControlled() || current.GetType() == int(Task::Type::PLAYER)
            || current.GetType() == int(Task::Type::RETREAT))) return null;
        if (!Emergency()) return defenders.exists("" + u.id) ? aiMilitaryMgr.DefaultMakeTask(u) : null;
        const float radius = Global::RoleSettings::Tech::BaseResponseRadius;
        if (!defenders.exists("" + u.id) && u.GetPos(ai.frame).SqDistance2D(Layout::BaseCentre()) > radius * radius) return null;
        if (group is null || group.IsDead()) return null;
        defenders.set("" + u.id, true);
        return group;
    }
    void Removed(CCircuitUnit@ u) {
        if (u is null) return;
        const string key = "" + u.id;
        defenders.delete(key); productionSince.delete(key); productionUntil.delete(key);
    }
}
