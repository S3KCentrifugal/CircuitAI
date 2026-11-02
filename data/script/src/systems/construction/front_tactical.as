// FRONT tactical launchers against enemy heavy turret clusters (owner, 2026-11-02; Front::Tactical).
//
// Owner: "If the enemy team has at least 2 pulsars or bulwarks or bastions within 700 elmos of each other
// (any type or combination), and if a single FRONT has living mexes or porc within 2250 elmos of a
// pulsar/bulwark/bastion, then task t2 cons assisted by t1 cons to build the special tactical unit
// (paralyzer, catalyst, and perdition) at the edge of its weapon range of the pulsars/bulwarks/bastions if
// the front has at least 150 minimum metal per second last 10 seconds and 5000 energy per second. Each
// front can build 1 of its special tactical unit per bastion/pulsar/bulwark it sees, with each built just
// barely in range of a different bastion/pulsar/bulwark. Use ghost images to calculate the range."
//
// Targets (TacticalTargets): Pulsar armanni, Bulwark cordoom, Bastion legbastion. Known from the shared
// battle snapshot: identified ground contacts in radar / LOS now, plus the ghost images (identified
// structures out of radar and LOS whose spot was not seen empty). Positions are the image's position.
//
// Gate (all of them):
//  - cluster: two known targets (any mix) within TacticalClusterRadius (700) of each other, anywhere;
//  - near us: the target has one of our living, finished mexes or static land guns ("porc") within
//    TacticalFrontRadius (2250). Only such targets get a launcher ("it sees");
//  - economy: 10 s minimum metal income >= TacticalMinMetalIncome (150) and energy income >=
//    TacticalMinEnergyIncome (5000).
//
// Launcher (TacticalUnits): Paralyzer armemp, Catalyst cortron, Perdition legperdition; a builder takes its
// own faction's first, then any other it can build (traded constructors).
//
// One per target: each of our launchers (finished or framed) is matched to one target in its range, the
// one it is nearest to being out of range of (the one it was placed for); a target with no launcher
// matched is open. TacticalMax caps the total standing.
//
// Site: from the target toward our nearest mex / porc within TacticalFrontRadius of it, at the launcher's
// range less TacticalRangeMargin, then pulled in until the height-aware range (aiBattle.EffectiveRange,
// measured from the site to the image) still holds the target with half that margin to spare. Built with
// TacticalShake of room, small enough that the frame stays in range.
//
// Builders: FRONT constructors that can build the launcher (T2), idle / guarding / assisting within
// TacticalReach of the site, or walking to an unframed build within TacticalTakeRadius; one order at a
// time, a second constructor that can build it may join. T1 constructors help (TacticalAssistT1 at most,
// within TacticalAssistReach, never the commander group's seat): they guard the T2 constructor until the
// frame stands, then repair the frame. An order that dies without a launcher holds that target
// FailHoldSeconds x fails; three in a row, TargetHoldSeconds.
//
// Firing is native: the launchers are role "super" statics and CSuperTask aims them.
// Cost: the battle snapshot's ground contacts and ghosts plus one owned-unit scan every TacticalScanSeconds
// while on; O(t^2) over the t known targets. Log [FRONT][Tactical].
namespace FrontTactical {
    const int OrderTimeoutSeconds = 240;
    const int FailHoldSeconds = 30;
    const int TargetHoldSeconds = 240;
    const int AssistGuardSeconds = 20;

    class Target {
        string key;
        string defName;
        AIFloat3 pos;
        bool ghost = false;
        AIFloat3 asset;        // our nearest mex / porc (valid when near)
        float assetDist = -1.0f;
        bool covered = false;
    }

    array<CCircuitDef@> launchers;
    array<CCircuitDef@> targetDefs;
    array<Target@> targets;
    array<AIFloat3> assets;    // our living finished mexes and static land guns
    int standing = 0;
    bool cluster = false;
    int lastScan = -100000;
    bool defsDone = false;

    IUnitTask@ order;
    string orderKey = "";
    AIFloat3 orderSite;
    IUnitTask@ assist;         // the repair of the order's frame, shared by the T1 helpers
    array<int> helpers;        // T1 constructors on the order, with when their guard / repair is due again
    array<int> helperUntil;
    dictionary fails;          // target key -> fails in a row
    dictionary holds;          // target key -> frame the hold ends
    string lastWhy = "";

    bool On() { return Global::RoleSettings::Front::Tactical && Global::AISettings::Role == AiRole::FRONT; }

    void Reset() {
        launchers.resize(0); targetDefs.resize(0); targets.resize(0); assets.resize(0);
        standing = 0; cluster = false; lastScan = -100000; defsDone = false;
        @order = null; orderKey = ""; @assist = null;
        helpers.resize(0); helperUntil.resize(0);
        fails.deleteAll(); holds.deleteAll();
        lastWhy = "";
    }

    void Defs() {
        if (defsDone) return;
        defsDone = true;
        const array<string>@ l = Global::RoleSettings::Front::TacticalUnits;
        for (uint i = 0; i < l.length(); ++i) { CCircuitDef@ d = ai.GetCircuitDef(l[i]); if (d !is null) launchers.insertLast(d); }
        const array<string>@ t = Global::RoleSettings::Front::TacticalTargets;
        for (uint i = 0; i < t.length(); ++i) { CCircuitDef@ d = ai.GetCircuitDef(t[i]); if (d !is null) targetDefs.insertLast(d); }
    }

    bool IsLauncher(const CCircuitDef@ d) {
        for (uint i = 0; i < launchers.length(); ++i) if (launchers[i] is d) return true;
        return false;
    }
    bool IsTargetDef(int defId) {
        for (uint i = 0; i < targetDefs.length(); ++i) if (int(targetDefs[i].id) == defId) return true;
        return false;
    }

    string Key(const AIFloat3 &in p) { return "" + int(p.x / 32.0f) + "_" + int(p.z / 32.0f); }

    void AddTarget(const AIFloat3 &in p, int defId, bool ghost) {
        for (uint i = 0; i < targets.length(); ++i)
            if (MapHelpers::SqDist(targets[i].pos, p) <= 48.0f * 48.0f) return;   // the same structure
        Target@ t = Target();
        t.key = Key(p); t.pos = p; t.ghost = ghost;
        CCircuitDef@ d = ai.GetCircuitDef(defId);
        t.defName = (d is null) ? ("def " + defId) : d.GetName();
        targets.insertLast(t);
    }

    // The launcher's range to a target at `to` when standing at `from` (height aware)
    float RangeAt(const CCircuitDef@ d, const AIFloat3 &in from, const AIFloat3 &in to) {
        const float r = aiBattle.EffectiveRange(d, from, to);
        return (r > 0.0f) ? r : d.GetMaxRange();
    }

    void Scan() {
        lastScan = ai.frame;
        targets.resize(0); assets.resize(0); standing = 0; cluster = false;
        // enemy heavy turrets: seen now, then ghost images
        const int nc = aiBattle.GetGroundContactCount();
        for (int i = 0; i < nc; ++i)
            if (IsTargetDef(aiBattle.GetGroundContactDefId(i))) AddTarget(aiBattle.GetGroundContactPos(i), aiBattle.GetGroundContactDefId(i), false);
        const int ng = aiBattle.GetGhostCount();
        for (int i = 0; i < ng; ++i)
            if (IsTargetDef(aiBattle.GetGhostDefId(i))) AddTarget(aiBattle.GetGhostPos(i), aiBattle.GetGhostDefId(i), true);
        const float cr = Global::RoleSettings::Front::TacticalClusterRadius;
        for (uint i = 0; i < targets.length() && !cluster; ++i)
            for (uint j = i + 1; j < targets.length() && !cluster; ++j)
                cluster = MapHelpers::SqDist(targets[i].pos, targets[j].pos) <= cr * cr;
        if (targets.length() == 0) return;
        // ours: mexes / porc, and the launchers
        array<AIFloat3> lpos;
        array<const CCircuitDef@> ldef;
        array<Id>@ ids = ai.GetOwnedUnitIds();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef is null) continue;
            const CCircuitDef@ d = u.circuitDef;
            if (IsLauncher(d)) { ++standing; lpos.insertLast(u.GetPos(ai.frame)); ldef.insertLast(d); continue; }
            if (d.IsMobile() || u.GetBuildProgress() < 1.0f) continue;
            if (d.GetExtractsMetal() <= 0.0f && !d.HasSurfToLand()) continue;
            assets.insertLast(u.GetPos(ai.frame));
        }
        const float fr = Global::RoleSettings::Front::TacticalFrontRadius;
        for (uint i = 0; i < targets.length(); ++i) {
            Target@ t = targets[i];
            float best = fr * fr;
            for (uint a = 0; a < assets.length(); ++a) {
                const float sq = MapHelpers::SqDist(t.pos, assets[a]);
                if (sq <= best) { best = sq; t.asset = assets[a]; t.assetDist = sqrt(sq); }
            }
        }
        // one launcher per target: each takes the in-range target it is nearest to losing
        for (uint l = 0; l < lpos.length(); ++l) {
            int pick = -1;
            float slack = 1e30f;
            for (uint i = 0; i < targets.length(); ++i) {
                if (targets[i].covered) continue;
                const float s = RangeAt(ldef[l], lpos[l], targets[i].pos) + 32.0f - sqrt(MapHelpers::SqDist(lpos[l], targets[i].pos));
                if (s >= 0.0f && s < slack) { slack = s; pick = int(i); }
            }
            if (pick >= 0) targets[pick].covered = true;
        }
        if (order !is null && order.IsDead()) @order = null;
    }

    void Refresh() {
        Defs();
        if (ai.frame - lastScan >= Global::RoleSettings::Front::TacticalScanSeconds * SECOND) Scan();
    }

    void Why(const string &in why) {
        if (why == lastWhy) return;
        lastWhy = why;
        GenericHelpers::LogUtil("[FRONT][Tactical] " + why, 2);
    }

    // Front_BuilderAiTaskRemoved
    void TaskRemoved(IUnitTask@ task, bool done) {
        if (task is null) return;
        if (assist is task) { @assist = null; return; }
        if (order !is task) return;
        @order = null; @assist = null;
        helpers.resize(0); helperUntil.resize(0);
        lastScan = -100000;
        const string key = orderKey;
        if (done) {
            fails.delete(key);
            GenericHelpers::LogUtil("[FRONT][Tactical] built against target at " + key, 1);
            return;
        }
        int n = 0;
        if (!fails.get(key, n)) n = 0;   // an &out argument is junk when the key is missing
        ++n;
        if (n >= 3) {
            holds.set(key, ai.frame + TargetHoldSeconds * SECOND);
            fails.delete(key);
            GenericHelpers::LogUtil("[FRONT][Tactical] three orders against target " + key + " died with no launcher; holding it " + TargetHoldSeconds + " s", 1);
        } else {
            fails.set(key, n);
            holds.set(key, ai.frame + FailHoldSeconds * n * SECOND);
        }
    }

    CCircuitDef@ LauncherFor(CCircuitUnit@ u) {
        const string side = UnitHelpers::GetSideForUnitName(u.circuitDef.GetName());
        CCircuitDef@ other = null;
        for (uint i = 0; i < launchers.length(); ++i) {
            if (!u.circuitDef.CanBuild(launchers[i])) continue;
            if (UnitHelpers::GetSideForUnitName(launchers[i].GetName()) == side) return launchers[i];
            if (other is null) @other = launchers[i];
        }
        return other;
    }

    // Just inside the launcher's range of t, on the side of our nearest mex / porc; x < 0 when there is none
    AIFloat3 Site(CCircuitDef@ d, Target@ t) {
        float dx = t.asset.x - t.pos.x, dz = t.asset.z - t.pos.z;
        float len = sqrt(dx * dx + dz * dz);
        if (len < 1.0f) { dx = Global::Map::StartPos.x - t.pos.x; dz = Global::Map::StartPos.z - t.pos.z; len = sqrt(dx * dx + dz * dz); }
        if (len < 1.0f) return AIFloat3(-1.0f, 0.0f, -1.0f);
        dx /= len; dz /= len;
        const float margin = Global::RoleSettings::Front::TacticalRangeMargin;
        const float w = float(aiTerrainMgr.GetTerrainWidth()), h = float(aiTerrainMgr.GetTerrainHeight());
        float r = aiBattle.MainRange(d);
        if (r <= 0.0f) r = d.GetMaxRange();
        r -= margin;
        AIFloat3 p;
        for (int it = 0; it < 4; ++it) {
            if (r < 300.0f) return AIFloat3(-1.0f, 0.0f, -1.0f);
            p = AIFloat3(AiMax(64.0f, AiMin(w - 64.0f, t.pos.x + dx * r)), 0.0f, AiMax(64.0f, AiMin(h - 64.0f, t.pos.z + dz * r)));
            const float dist = sqrt(MapHelpers::SqDist(p, t.pos));
            const float eff = RangeAt(d, p, t.pos);
            if (dist <= eff - margin * 0.5f) return p;
            r = AiMin(r - 64.0f, eff - margin);
        }
        return AIFloat3(-1.0f, 0.0f, -1.0f);
    }

    // "" when the gate is open, else why not
    string Gate() {
        if (!cluster) return "no two known enemy heavy turrets within " + int(Global::RoleSettings::Front::TacticalClusterRadius) + " of each other";
        const float mi = Economy::GetMinMetalIncomeLast10s();
        if (mi < Global::RoleSettings::Front::TacticalMinMetalIncome)
            return "10 s minimum metal income +" + int(mi) + " under +" + int(Global::RoleSettings::Front::TacticalMinMetalIncome);
        const float ei = aiEconomyMgr.energy.income;
        if (ei < Global::RoleSettings::Front::TacticalMinEnergyIncome)
            return "energy income +" + int(ei) + " under +" + int(Global::RoleSettings::Front::TacticalMinEnergyIncome);
        return "";
    }

    // Front_BuilderAiMakeTask: a constructor that can build the launcher takes (or joins) the order;
    // a T1 constructor that reaches here (air) helps
    IUnitTask@ Work(CCircuitUnit@ u) {
        if (!On() || u is null || u.circuitDef is null || FrontRecovery::Active()) return null;
        if (order !is null && !order.IsDead() && (u.task is order || (assist !is null && u.task is assist))) return u.task;
        if (UnitHelpers::IsCommander(u.circuitDef) || LolCannon::IsCrew(u.id)) return null;
        Refresh();
        CCircuitDef@ d = LauncherFor(u);
        if (d is null) {
            if (UnitHelpers::GetConstructorTier(u.circuitDef) == 1) return Help(u);
            return null;
        }
        if (order !is null && !order.IsDead()) {
            IBuilderTask@ b = cast<IBuilderTask>(order);
            array<CCircuitUnit@>@ on = order.GetUnits();
            if ((on is null || on.length() < 2) && b !is null && b.buildDef !is null && u.circuitDef.CanBuild(b.buildDef)
                && FrontFactoryNanos::Free(u) && MapHelpers::SqDist(u.GetPos(ai.frame), b.GetBuildPos()) <= 2000.0f * 2000.0f)
                return order;
            return null;
        }
        if (targets.length() == 0) return null;
        int open = 0;
        for (uint i = 0; i < targets.length(); ++i) if (!targets[i].covered && targets[i].assetDist >= 0.0f) ++open;
        if (open == 0) return null;
        if (standing >= Global::RoleSettings::Front::TacticalMax) { Why("cap reached: " + standing + " standing"); return null; }
        const string gate = Gate();
        if (gate != "") { Why("waiting: " + gate + " (" + open + " heavy turrets near our mexes / porc)"); return null; }
        const bool free = FrontFactoryNanos::Free(u);
        if (!free && !FrontFactoryNanos::Takeable(u)) return null;
        const float reach = free ? Global::RoleSettings::Front::TacticalReach : Global::RoleSettings::Front::TacticalTakeRadius;
        const AIFloat3 wp = u.GetPos(ai.frame);
        // nearest our mexes / porc first
        array<int> order_;
        for (uint i = 0; i < targets.length(); ++i) {
            if (targets[i].covered || targets[i].assetDist < 0.0f) continue;
            uint at = 0;
            while (at < order_.length() && targets[order_[at]].assetDist <= targets[i].assetDist) ++at;
            order_.insertAt(at, int(i));
        }
        for (uint k = 0; k < order_.length(); ++k) {
            Target@ t = targets[order_[k]];
            int until = -1;
            if (holds.get(t.key, until) && ai.frame < until) continue;
            const AIFloat3 site = Site(d, t);
            if (site.x < 0.0f) { holds.set(t.key, ai.frame + FailHoldSeconds * SECOND); continue; }
            if (MapHelpers::SqDist(wp, site) > reach * reach) continue;
            if (!aiTerrainMgr.CanReachAt(u, site, u.circuitDef.GetBuildDistance())) continue;
            if (d.maxThisUnit >= 0 && d.maxThisUnit <= d.count) d.maxThisUnit = d.count + 1;
            if (!d.IsAvailable(ai.frame)) return null;
            @order = aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::DEFENCE, Task::Priority::HIGH, d, site,
                Global::RoleSettings::Front::TacticalShake, true, OrderTimeoutSeconds * SECOND));
            if (order is null) { holds.set(t.key, ai.frame + FailHoldSeconds * SECOND); continue; }
            orderKey = t.key; orderSite = site; @assist = null;
            helpers.resize(0); helperUntil.resize(0);
            lastWhy = "";
            GenericHelpers::LogUtil("[FRONT][Tactical] " + u.circuitDef.GetName() + " " + u.id + " orders " + d.GetName() + " at (" + int(site.x) + ","
                + int(site.z) + "), " + int(sqrt(MapHelpers::SqDist(site, t.pos))) + " from " + (t.ghost ? "ghost of " : "") + t.defName + " at ("
                + int(t.pos.x) + "," + int(t.pos.z) + ") (range " + int(RangeAt(d, site, t.pos)) + "); our mex / porc " + int(t.assetDist)
                + " from it; mi +" + int(Economy::GetMinMetalIncomeLast10s()) + ", ei +" + int(aiEconomyMgr.energy.income) + "; " + standing
                + " standing, " + open + " heavy turrets open", 1);
            return order;
        }
        return null;
    }

    // A T1 constructor helps the order: guard its T2 constructor until the frame stands, then repair the frame
    IUnitTask@ Help(CCircuitUnit@ u) {
        if (order is null || order.IsDead()) return null;
        if (assist !is null && !assist.IsDead() && u.task is assist) return assist;
        IBuilderTask@ b = cast<IBuilderTask>(order);
        if (b is null) return null;
        // prune helpers that are gone or done
        for (int i = int(helpers.length()) - 1; i >= 0; --i)
            if (ai.GetTeamUnit(helpers[i]) is null || ai.frame >= helperUntil[i]) { helpers.removeAt(i); helperUntil.removeAt(i); }
        const int at = helpers.find(u.id);
        if (at < 0 && int(helpers.length()) >= Global::RoleSettings::Front::TacticalAssistT1) return null;
        if (at < 0 && !FrontFactoryNanos::Free(u) && !FrontFactoryNanos::Takeable(u)) return null;
        const float reach = Global::RoleSettings::Front::TacticalAssistReach;
        AIFloat3 site = orderSite;
        if (b.target !is null) site = b.target.GetPos(ai.frame);
        if (MapHelpers::SqDist(u.GetPos(ai.frame), site) > reach * reach) return null;
        if (!aiTerrainMgr.CanReachAt(u, site, u.circuitDef.GetBuildDistance() + 200.0f)) return null;
        IUnitTask@ t = null;
        int secs = AssistGuardSeconds;
        if (b.target !is null) {
            if (assist is null || assist.IsDead()) @assist = aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::HIGH, b.target, 120 * SECOND));
            @t = assist;
            secs = 120;
        } else {
            array<CCircuitUnit@>@ on = order.GetUnits();
            if (on is null || on.length() == 0) return null;   // nobody to follow yet
            @t = aiBuilderMgr.Enqueue(TaskB::Guard(Task::Priority::HIGH, on[0], true, AssistGuardSeconds * SECOND));
        }
        if (t is null) return null;
        if (at < 0) {
            helpers.insertLast(u.id); helperUntil.insertLast(ai.frame + secs * SECOND);
            GenericHelpers::LogUtil("[FRONT][Tactical] T1 " + u.circuitDef.GetName() + " " + u.id + (b.target !is null ? " repairs the launcher frame" : " guards the launcher's constructor")
                + " (" + helpers.length() + " of " + Global::RoleSettings::Front::TacticalAssistT1 + ")", 2);
        } else helperUntil[at] = ai.frame + secs * SECOND;
        return t;
    }

    // Builder AiMakeTask, before the FRONT T1 seats route to native work: the base / expansion /
    // unseated T1 constructors help while an order is open (never the commander group's seat 2,
    // never one finishing a framed build of its own)
    IUnitTask@ AssistPull(CCircuitUnit@ u) {
        if (!On() || u is null || u.circuitDef is null || order is null || order.IsDead()) return null;
        if (FrontRecovery::Active() || u.GetBuildProgress() < 1.0f) return null;
        if (FrontConstructors::Seat(u.id) == 2) return null;
        if (u.task !is null && (u.task.IsExternalControlled() || u.task.GetType() == int(Task::Type::PLAYER)
            || u.task.GetType() == int(Task::Type::RETREAT))) return null;
        IBuilderTask@ cur = cast<IBuilderTask>(u.task);
        if (cur !is null && !cur.IsDead() && cur.target !is null && cur.GetBuildType() < int(Task::BuildType::REPAIR)
            && !(assist !is null && u.task is assist)) return null;
        if (LauncherFor(u) !is null) return null;
        return Help(u);
    }
}
