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
// measured from the site to the image) still holds the target with half that margin to spare. A site within
// EdgeGap of a map edge is never used (a clamped point was out of range and never got a constructor, B13):
// the direction is turned by +-20, 40, 60, 80 degrees, then the same directions are walked in down to
// ShortestRangeShare of the range; with none the target is held. Built with TacticalShake of room, small
// enough that the frame stays in range. An order no constructor took within UnmannedSeconds (the placing
// T2 is assigned to it) is aborted as a fail.
//
// Builders: FRONT constructors that can build the launcher (T2), idle / guarding / assisting within
// TacticalReach of the site, or walking to an unframed build within TacticalTakeRadius; one order at a
// time, a second constructor that can build it may join. T1 constructors help (TacticalAssistT1 at most,
// within TacticalAssistReach, never the commander group's seat): they guard the T2 constructor until the
// frame stands, then repair the frame. Update (from Front_EconomyUpdate, every PullSeconds) pulls the
// nearest free / takeable T1s onto the order with AssignTask: only seats 0 and 1 reach AssistPull from
// AiMakeTask, and native re-asks busy builders only now and then, so asked-for help alone never came
// (fixture run 2026-11-02: 6 launchers, 0 T1 helpers). A helper's guard is returned unchanged on a re-ask.
// An order that dies without a launcher holds that target FailHoldSeconds x fails; three in a row,
// TargetHoldSeconds. Every failed order is logged.
//
// Firing is native: the launchers are role "super" statics and CSuperTask aims them.
// Cost: the battle snapshot's ground contacts and ghosts plus one owned-unit scan every TacticalScanSeconds
// while on; O(t^2) over the t known targets. Log [FRONT][Tactical].
namespace FrontTactical {
    const int OrderTimeoutSeconds = 240;
    const int FailHoldSeconds = 30;
    const int TargetHoldSeconds = 240;
    const int AssistGuardSeconds = 60;
    const int PullSeconds = 2;
    const int UnmannedSeconds = 30;      // an order no constructor took by then is aborted as a fail (B13)
    const int FrameDeadlineSeconds = 180; // an order with no frame by then is aborted as a fail
    const float BadSiteRadius = 160.0f;  // a new site keeps this far from a site an order died on
    const uint MaxBadSites = 32;
    const float EdgeGap = 96.0f;       // a site stands this far inside every map edge
    const float ShortestRangeShare = 0.7f;
    const int DiagSeconds = 30;

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
    array<IUnitTask@> helperTask;  // the guard / repair each helper was given
    array<string> announced;   // "G" / "R" + helper id already logged for this order
    int lastPull = -100000;
    int orderFrame = 0;        // when the order was placed
    int orderBy = -1;          // the T2 constructor that placed it
    array<AIFloat3> badSites;  // sites orders died on, oldest first (at most MaxBadSites)
    bool orderManned = false;  // a constructor was on it once
    dictionary diagAt;         // helper skip reason -> frame it may print again
    dictionary fails;          // target key -> fails in a row
    dictionary holds;          // target key -> frame the hold ends
    string lastWhy = "";

    bool On() { return Global::RoleSettings::Front::Tactical && Global::AISettings::Role == AiRole::FRONT; }

    void Reset() {
        launchers.resize(0); targetDefs.resize(0); targets.resize(0); assets.resize(0);
        standing = 0; cluster = false; lastScan = -100000; defsDone = false;
        @order = null; orderKey = ""; @assist = null;
        helpers.resize(0); helperUntil.resize(0); helperTask.resize(0);
        fails.deleteAll(); holds.deleteAll(); diagAt.deleteAll(); badSites.resize(0);
        lastWhy = ""; lastPull = -100000;
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
        // one launcher per target: greedy over every in-range (launcher, target) pair, targets near our mexes /
        // porc first, then the pair nearest to losing range. Launcher by launcher let one "cover" a far target
        // with nothing of ours near it and left its own open (fixture g12: 4 Catalysts on one Pulsar).
        // O(l x t) pairs, sorted by insertion; l <= TacticalMax, t the known heavy turrets.
        array<int> pl, pt;
        array<float> ps;
        for (uint l = 0; l < lpos.length(); ++l) {
            for (uint i = 0; i < targets.length(); ++i) {
                const float s = RangeAt(ldef[l], lpos[l], targets[i].pos) + 32.0f - sqrt(MapHelpers::SqDist(lpos[l], targets[i].pos));
                if (s < 0.0f) continue;
                const float key = s + ((targets[i].assetDist >= 0.0f) ? 0.0f : 1e6f);
                uint k = 0;
                while (k < ps.length() && ps[k] <= key) ++k;
                pl.insertAt(k, int(l)); pt.insertAt(k, int(i)); ps.insertAt(k, key);
            }
        }
        array<bool> used(lpos.length(), false);
        for (uint k = 0; k < ps.length(); ++k) {
            if (used[uint(pl[k])] || targets[pt[k]].covered) continue;
            used[uint(pl[k])] = true;
            targets[pt[k]].covered = true;
        }
        if (order !is null && order.IsDead()) @order = null;
    }

    void Refresh() {
        Defs();
        if (ai.frame - lastScan >= Global::RoleSettings::Front::TacticalScanSeconds * SECOND) Scan();
    }

    // One line per key per DiagSeconds (LOG_LEVEL is 1, so level 2 never prints)
    void RateLog(const string &in key, const string &in text) {
        int until = 0;
        if (diagAt.get(key, until) && ai.frame < until) return;
        diagAt.set(key, ai.frame + DiagSeconds * SECOND);
        GenericHelpers::LogUtil("[FRONT][Tactical] " + text, 1);
    }
    // why a T1 constructor did not help
    void Diag(const string &in reason, const string &in detail) { RateLog("helper " + reason, "helper skip (" + reason + "): " + detail); }

    string TaskText(CCircuitUnit@ u) {
        if (u.task is null || u.task.IsDead()) return "no task";
        IBuilderTask@ b = cast<IBuilderTask>(u.task);
        return "task type " + int(u.task.GetType()) + (b is null ? "" : " build " + int(b.GetBuildType()) + (b.target is null ? "" : " framed"));
    }

    void ClearHelpers() { helpers.resize(0); helperUntil.resize(0); helperTask.resize(0); announced.resize(0); }

    void Why(const string &in why) {
        // a changed reason prints, at most once per DiagSeconds per kind ("waiting", "cap")
        if (why == lastWhy) return;
        lastWhy = why;
        const int colon = why.findFirst(":");
        RateLog(colon > 0 ? why.substr(0, colon) : why, why);
    }

    // Front_BuilderAiTaskRemoved
    void TaskRemoved(IUnitTask@ task, bool done) {
        if (task is null) return;
        if (assist is task) { @assist = null; return; }
        if (order !is task) return;
        @order = null; @assist = null;
        ClearHelpers();
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
        GenericHelpers::LogUtil("[FRONT][Tactical] order against target " + key + " died with no launcher (fail " + n + " in a row); site ("
            + int(orderSite.x) + "," + int(orderSite.z) + ") avoided from now on", 1);
        if (badSites.length() >= MaxBadSites) badSites.removeAt(0);
        badSites.insertLast(orderSite);
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

    // A site an order died on (no constructor, no frame): the next site is looked for elsewhere
    bool NearBadSite(const AIFloat3 &in p) {
        for (uint i = 0; i < badSites.length(); ++i) if (MapHelpers::SqDist(p, badSites[i]) <= BadSiteRadius * BadSiteRadius) return true;
        return false;
    }

    // The point r0 from t along (dx, dz), pulled in until the height-aware range holds t with half the margin
    // to spare; never below rMin (when < 0: at most 4 range fits); x < 0 when none, or it leaves the map
    // (EdgeGap from every edge; a clamped point was not where the range was measured, B13)
    AIFloat3 TrySite(CCircuitDef@ d, Target@ t, float dx, float dz, float r0, float rMin) {
        const float margin = Global::RoleSettings::Front::TacticalRangeMargin;
        const float w = float(aiTerrainMgr.GetTerrainWidth()), h = float(aiTerrainMgr.GetTerrainHeight());
        float r = r0;
        for (int it = 0; it < 16 && (rMin >= 0.0f || it < 4); ++it) {
            if (r < 300.0f || (rMin >= 0.0f && r < rMin)) break;
            const AIFloat3 p(t.pos.x + dx * r, 0.0f, t.pos.z + dz * r);
            if (p.x < EdgeGap || p.z < EdgeGap || p.x > w - EdgeGap || p.z > h - EdgeGap || NearBadSite(p)) {
                if (rMin < 0.0f) break;   // the first pass keeps the range; the second walks in
                r -= 64.0f;
                continue;
            }
            const float dist = sqrt(MapHelpers::SqDist(p, t.pos));
            const float eff = RangeAt(d, p, t.pos);
            if (dist <= eff - margin * 0.5f) return p;
            r = AiMin(r - 64.0f, eff - margin);
        }
        return AIFloat3(-1.0f, 0.0f, -1.0f);
    }

    // Just inside the launcher's range of t, on the side of our nearest mex / porc; when that leaves the map,
    // the direction turned by +-20, 40, 60, 80 degrees (nearest first); then the same directions down to
    // ShortestRangeShare of the range; x < 0 when there is none (the target is held)
    AIFloat3 Site(CCircuitDef@ d, Target@ t) {
        float dx = t.asset.x - t.pos.x, dz = t.asset.z - t.pos.z;
        float len = sqrt(dx * dx + dz * dz);
        if (len < 1.0f) { dx = Global::Map::StartPos.x - t.pos.x; dz = Global::Map::StartPos.z - t.pos.z; len = sqrt(dx * dx + dz * dz); }
        if (len < 1.0f) return AIFloat3(-1.0f, 0.0f, -1.0f);
        dx /= len; dz /= len;
        float range = aiBattle.MainRange(d);
        if (range <= 0.0f) range = d.GetMaxRange();
        const float r0 = range - Global::RoleSettings::Front::TacticalRangeMargin;
        for (int pass = 0; pass < 2; ++pass) {
            for (int k = 0; k < 9; ++k) {
                const float deg = (k == 0) ? 0.0f : 20.0f * float((k + 1) / 2) * ((k % 2 == 1) ? 1.0f : -1.0f);
                const float a = deg * 3.14159265f / 180.0f;
                const float c = cos(a), s = sin(a);
                const AIFloat3 p = TrySite(d, t, dx * c - dz * s, dx * s + dz * c, r0, pass == 0 ? -1.0f : range * ShortestRangeShare);
                if (p.x >= 0.0f) return p;
            }
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
            ClearHelpers(); lastPull = -100000;
            orderFrame = ai.frame; orderBy = u.id; orderManned = false;
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
        PruneHelpers();
        const int at = helpers.find(u.id);
        // a re-ask of a helper still on its guard keeps it (a new guard each ask churned tasks)
        if (at >= 0 && b.target is null && helperTask[at] !is null && !helperTask[at].IsDead() && u.task is helperTask[at]) return u.task;
        if (at < 0 && int(helpers.length()) >= Global::RoleSettings::Front::TacticalAssistT1) return null;
        if (at < 0 && !FrontFactoryNanos::Free(u) && !FrontFactoryNanos::Takeable(u)) {
            Diag("busy", u.circuitDef.GetName() + " " + u.id + " seat " + FrontConstructors::Seat(u.id) + ", " + TaskText(u));
            return null;
        }
        const float reach = Global::RoleSettings::Front::TacticalAssistReach;
        AIFloat3 site = orderSite;
        if (b.target !is null) site = b.target.GetPos(ai.frame);
        const float sq = MapHelpers::SqDist(u.GetPos(ai.frame), site);
        if (sq > reach * reach) {
            Diag("far", u.circuitDef.GetName() + " " + u.id + " seat " + FrontConstructors::Seat(u.id) + " " + int(sqrt(sq)) + " from the site (reach " + int(reach) + ")");
            return null;
        }
        if (!aiTerrainMgr.CanReachAt(u, site, u.circuitDef.GetBuildDistance() + 200.0f)) {
            Diag("unreachable", u.circuitDef.GetName() + " " + u.id + " cannot reach the site");
            return null;
        }
        IUnitTask@ t = null;
        int secs = AssistGuardSeconds;
        if (b.target !is null) {
            if (assist is null || assist.IsDead()) @assist = aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::HIGH, b.target, 120 * SECOND));
            @t = assist;
            secs = 120;
        } else {
            array<CCircuitUnit@>@ on = order.GetUnits();
            if (on is null || on.length() == 0) { Diag("no T2 yet", "the order has no constructor to guard"); return null; }
            @t = aiBuilderMgr.Enqueue(TaskB::Guard(Task::Priority::HIGH, on[0], true, AssistGuardSeconds * SECOND));
        }
        if (t is null) return null;
        // one line per helper per order and per kind of help (a re-pull after its guard expires is silent)
        const string kind = (b.target !is null) ? "R" : "G";
        if (announced.find(kind + u.id) < 0) {
            announced.insertLast(kind + u.id);
            GenericHelpers::LogUtil("[FRONT][Tactical] T1 " + u.circuitDef.GetName() + " " + u.id + " seat " + FrontConstructors::Seat(u.id)
                + (b.target !is null ? " repairs the launcher frame" : " guards the launcher's constructor") + ", " + int(sqrt(sq)) + " from the site ("
                + (at < 0 ? helpers.length() + 1 : helpers.length()) + " of " + Global::RoleSettings::Front::TacticalAssistT1 + ")", 1);
        }
        if (at < 0) { helpers.insertLast(u.id); helperUntil.insertLast(ai.frame + secs * SECOND); helperTask.insertLast(t); }
        else { helperUntil[at] = ai.frame + secs * SECOND; @helperTask[at] = t; }
        return t;
    }

    void PruneHelpers() {
        for (int i = int(helpers.length()) - 1; i >= 0; --i)
            if (ai.GetTeamUnit(helpers[i]) is null || ai.frame >= helperUntil[i]) { helpers.removeAt(i); helperUntil.removeAt(i); helperTask.removeAt(i); }
    }

    // Front_EconomyUpdate: while an order is open, every PullSeconds the nearest T1 constructors that are free
    // or walking to an unframed build (never one on its own framed build, the commander group's seat, the
    // lolcannon crew) within TacticalAssistReach are given Help() until TacticalAssistT1 help; a helper native
    // swapped off is given its help again. Cost: one owned-unit scan per PullSeconds while an order is open,
    // O(units + T1s x helpers).
    void Update() {
        if (!On() || order is null || order.IsDead() || FrontRecovery::Active()) return;
        if (ai.frame - lastPull < PullSeconds * SECOND) return;
        lastPull = ai.frame;
        IBuilderTask@ b = cast<IBuilderTask>(order);
        if (b is null) return;
        // B13: native may leave the order with nobody on it; the constructor that placed it takes it, and an
        // order nobody took within UnmannedSeconds is aborted as a fail (it sat its whole 240 s timeout)
        // a manned order whose frame never stood (g10: a T2 and three guards on one for 14 min, the
        // order's own timeout never fired) is aborted at FrameDeadlineSeconds and counted as a fail
        if (b.target is null && ai.frame - orderFrame >= FrameDeadlineSeconds * SECOND) {
            GenericHelpers::LogUtil("[FRONT][Tactical] order against target " + orderKey + " had no frame after " + FrameDeadlineSeconds + " s; aborted", 1);
            IUnitTask@ dead = order;
            aiBuilderMgr.AbortTask(dead);
            if (order is dead) TaskRemoved(dead, false);
            return;
        }
        if (!orderManned) {
            array<CCircuitUnit@>@ on = order.GetUnits();
            if (on !is null && on.length() > 0) orderManned = true;
            else if (ai.frame - orderFrame >= UnmannedSeconds * SECOND) {
                GenericHelpers::LogUtil("[FRONT][Tactical] order against target " + orderKey + " had no constructor after " + UnmannedSeconds + " s; aborted", 1);
                IUnitTask@ dead = order;
                aiBuilderMgr.AbortTask(dead);
                if (order is dead) TaskRemoved(dead, false);   // count the fail when the abort did not call back
                return;
            } else {
                CCircuitUnit@ by = ai.GetTeamUnit(orderBy);
                if (by !is null && !(by.task is order) && (FrontFactoryNanos::Free(by) || FrontFactoryNanos::Takeable(by))) {
                    aiBuilderMgr.AssignTask(by, order);
                    RateLog("assign", by.circuitDef.GetName() + " " + by.id + " assigned to its unmanned order against " + orderKey);
                }
            }
        }
        PruneHelpers();
        const int want = Global::RoleSettings::Front::TacticalAssistT1;
        AIFloat3 site = orderSite;
        if (b.target !is null) site = b.target.GetPos(ai.frame);
        const float reach = Global::RoleSettings::Front::TacticalAssistReach;
        array<CCircuitUnit@> cand;
        array<float> candSq;
        int t1 = 0, group = 0, framed = 0, busy = 0, far = 0;
        array<Id>@ ids = ai.GetOwnedUnitIds();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef is null || UnitHelpers::IsCommander(u.circuitDef) || UnitHelpers::GetConstructorTier(u.circuitDef) != 1) continue;
            if (u.GetBuildProgress() < 1.0f || LauncherFor(u) !is null) continue;
            ++t1;
            const int at = helpers.find(u.id);
            if (at >= 0 && (u.task is helperTask[at] || (assist !is null && u.task is assist))) continue;   // helping
            if (FrontConstructors::Seat(u.id) == 2 || CommanderGroup::Owns(u.id) || LolCannon::IsCrew(u.id)) { ++group; continue; }
            if (u.task !is null && (u.task.IsExternalControlled() || u.task.GetType() == int(Task::Type::PLAYER)
                || u.task.GetType() == int(Task::Type::RETREAT))) { ++busy; continue; }
            IBuilderTask@ cur = cast<IBuilderTask>(u.task);
            if (cur !is null && !cur.IsDead() && cur.target !is null && cur.GetBuildType() < int(Task::BuildType::REPAIR)) { ++framed; continue; }
            if (!FrontFactoryNanos::Free(u) && !FrontFactoryNanos::Takeable(u)) { ++busy; continue; }
            const float sq = MapHelpers::SqDist(u.GetPos(ai.frame), site);
            if (sq > reach * reach) { ++far; continue; }
            uint k = 0;
            while (k < candSq.length() && candSq[k] <= sq) ++k;
            cand.insertAt(k, u); candSq.insertAt(k, sq);
        }
        int pulled = 0;
        for (uint k = 0; k < cand.length(); ++k) {
            CCircuitUnit@ u = cand[k];
            if (helpers.find(u.id) < 0 && int(helpers.length()) >= want) break;
            IUnitTask@ t = Help(u);
            if (t is null || u.task is t) continue;
            aiBuilderMgr.AssignTask(u, t);
            ++pulled;
        }
        if (int(helpers.length()) < want && pulled == 0)
            Diag("none free", "" + helpers.length() + " of " + want + " helping; " + t1 + " T1s: " + group + " commander group / crew, " + framed
                + " on their own framed build, " + busy + " busy, " + far + " beyond " + int(reach) + ", " + cand.length() + " near and free");
    }

    // Builder AiMakeTask, first for every FRONT constructor: one on the order (or a T1 on its repair) keeps it.
    // Without this a re-ask of the T2 went to other rungs, the order lost its only unit and died
    // (fixture g12: 9 Perdition orders died 0.5-20 s after their T2 took them).
    bool Owns(CCircuitUnit@ u) {
        if (!On() || u is null || u.task is null || u.task.IsDead()) return false;
        return (order !is null && !order.IsDead() && u.task is order) || (assist !is null && !assist.IsDead() && u.task is assist);
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
