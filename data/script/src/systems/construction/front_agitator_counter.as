// FRONT counter to enemy agitators on our porc (owner, 2026-11-12; Front::AgitatorCounter).
//
// Owner: "When a front is above 65 metal per second minima 10s, and an enemy front is scouted to have an
// agitator or equivalents whose range overlaps our porc (llts, beamers, twin guards, light aa turrets, nano
// turrets) on the front, the t2 in the commander group should drop a t2 rattlesnake or equivalent that
// barely overlaps it, at maximum 80% of the rattlesnake's range. Then drop that faction's equivalent of a
// pitbull (pitbull, chimera, scorpion) in front of the rattlesnake/eviscerator/incinerator. Guard against
// null pointers as we assign jobs and return the unit to what it was doing."
//
// Targets (AgitatorCounterTargets): Gauntlet armguard, Agitator corpun, Amputator legcluster. Known from the
// shared battle snapshot: identified ground contacts in radar / LOS now plus ghost images.
// Threatened: one of our finished porc (AgitatorCounterPorc: LLT, Beamer / Twin Guard / Cacophony, light AA,
// nano turret) stands within the target's height-aware range (+ AgitatorCounterOverlapMargin for the hull).
// Covered: one of our T2 pop-up artillery (AgitatorCounterHeavy: Rattlesnake armamb, Persecutor cortoast,
// Eviscerator legacluster; finished or framed, ours from any system) reaches the target.
// Gate: 10 s minimum metal income >= AgitatorCounterMinMetalIncome (65); at most AgitatorCounterMax heavies.
//
// Job (one at a time): a T2 seat of the commander group (CommanderGroup members 0..2) that can build the
// heavy, finished, not retreating / player-controlled / on another script order, within
// AgitatorCounterReach of the site (nearest first), is taken off the group and
//   1. builds the heavy from the target toward the threatened porc at AgitatorCounterRangeShare (0.8) of the
//      heavy's range less the build shake, pulled in until 0.8 of the height-aware range still holds the
//      target (so it just overlaps it, never further than 80% of its range);
//   2. then that faction's 730-range pop-up (AgitatorCounterPopup: Pit Bull armpb, Scorpion corvipe, Chimera
//      legapopupdef) AgitatorCounterPopupForward in front of the heavy, toward the target;
//   3. is given back the task it had before the job when that task still lives, and is published to the
//      native group again (native re-assigns group seats every second; while on the job the seat is
//      published as -1 so native cannot take it back).
// A failed heavy holds that target HoldSeconds; the pop-up is skipped when the heavy failed.
// Every unit / task handle is checked for null (and IsDead) before use. Log [FRONT][AgitatorCounter].
// Cost: battle snapshot contacts + ghosts and one owned-unit scan every AgitatorCounterScanSeconds while on;
// O(targets x (porc + heavies)).
namespace FrontAgitatorCounter {
    const int OrderTimeoutSeconds = 240;
    const int FrameDeadlineSeconds = 150;   // an order with no frame by then is aborted
    const int HoldSeconds = 120;
    const float EdgeGap = 96.0f;

    class Target {
        string key;
        string defName;
        int defId = -1;
        AIFloat3 pos;
        bool ghost = false;
        AIFloat3 porc;          // the threatened porc of ours nearest to it
        float porcDist = -1.0f; // < 0: none threatened
        bool covered = false;
    }

    array<CCircuitDef@> targetDefs, porcDefs, heavyDefs, popupDefs;
    array<Target@> targets;
    int standing = 0;
    int lastScan = -100000;
    bool defsDone = false;
    dictionary holds;            // target key -> frame the hold ends

    // the job
    int stage = 0;               // 0 none, 1 heavy order open, 2 pop-up order open, 3 pop-up still to order
    int jobUnit = -1;
    IUnitTask@ order;
    IUnitTask@ prevTask;         // what the T2 was doing before the job
    string jobKey = "";
    AIFloat3 jobTarget, heavySite, popupSite;
    CCircuitDef@ popupDef;
    int orderFrame = 0;

    bool On() { return Global::RoleSettings::Front::AgitatorCounter && Global::AISettings::Role == AiRole::FRONT; }

    void Reset() {
        targetDefs.resize(0); porcDefs.resize(0); heavyDefs.resize(0); popupDefs.resize(0);
        targets.resize(0); standing = 0; lastScan = -100000; defsDone = false; holds.deleteAll();
        stage = 0; jobUnit = -1; @order = null; @prevTask = null; @popupDef = null; jobKey = "";
    }

    void AddDefs(const array<string>@ names, array<CCircuitDef@>@ into) {
        if (names is null || into is null) return;
        for (uint i = 0; i < names.length(); ++i) { CCircuitDef@ d = ai.GetCircuitDef(names[i]); if (d !is null) into.insertLast(d); }
    }
    void Defs() {
        if (defsDone) return;
        defsDone = true;
        AddDefs(Global::RoleSettings::Front::AgitatorCounterTargets, targetDefs);
        AddDefs(Global::RoleSettings::Front::AgitatorCounterPorc, porcDefs);
        AddDefs(Global::RoleSettings::Front::AgitatorCounterHeavy, heavyDefs);
        AddDefs(Global::RoleSettings::Front::AgitatorCounterPopup, popupDefs);
    }
    bool In(const array<CCircuitDef@>@ l, const CCircuitDef@ d) {
        if (d is null) return false;
        for (uint i = 0; i < l.length(); ++i) if (l[i] is d) return true;
        return false;
    }
    bool IsTargetDef(int defId) {
        for (uint i = 0; i < targetDefs.length(); ++i) if (int(targetDefs[i].id) == defId) return true;
        return false;
    }

    string Key(const AIFloat3 &in p) { return "" + int(p.x / 32.0f) + "_" + int(p.z / 32.0f); }

    // d's range to `to` standing at `from` (height aware; the def's max range when unknown)
    float RangeAt(const CCircuitDef@ d, const AIFloat3 &in from, const AIFloat3 &in to) {
        if (d is null) return 0.0f;
        const float r = aiBattle.EffectiveRange(d, from, to);
        return (r > 0.0f) ? r : d.GetMaxRange();
    }

    void AddTarget(const AIFloat3 &in p, int defId, bool ghost) {
        for (uint i = 0; i < targets.length(); ++i)
            if (MapHelpers::SqDist(targets[i].pos, p) <= 48.0f * 48.0f) return;   // the same structure
        Target@ t = Target();
        t.key = Key(p); t.pos = p; t.ghost = ghost; t.defId = defId;
        CCircuitDef@ d = ai.GetCircuitDef(defId);
        t.defName = (d is null) ? ("def " + defId) : d.GetName();
        targets.insertLast(t);
    }

    void Scan() {
        lastScan = ai.frame;
        targets.resize(0); standing = 0;
        const int nc = aiBattle.GetGroundContactCount();
        for (int i = 0; i < nc; ++i)
            if (IsTargetDef(aiBattle.GetGroundContactDefId(i))) AddTarget(aiBattle.GetGroundContactPos(i), aiBattle.GetGroundContactDefId(i), false);
        const int ng = aiBattle.GetGhostCount();
        for (int i = 0; i < ng; ++i)
            if (IsTargetDef(aiBattle.GetGhostDefId(i))) AddTarget(aiBattle.GetGhostPos(i), aiBattle.GetGhostDefId(i), true);
        if (targets.length() == 0) return;
        array<AIFloat3> porc, hpos;
        array<const CCircuitDef@> hdef;
        array<Id>@ ids = ai.GetOwnedUnitIds();
        if (ids is null) return;
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef is null) continue;
            const CCircuitDef@ d = u.circuitDef;
            if (In(heavyDefs, d)) { ++standing; hpos.insertLast(u.GetPos(ai.frame)); hdef.insertLast(d); continue; }
            if (u.GetBuildProgress() < 1.0f || !In(porcDefs, d)) continue;
            porc.insertLast(u.GetPos(ai.frame));
        }
        const float margin = Global::RoleSettings::Front::AgitatorCounterOverlapMargin;
        for (uint i = 0; i < targets.length(); ++i) {
            Target@ t = targets[i];
            CCircuitDef@ td = ai.GetCircuitDef(t.defId);
            float best = 1e12f;
            for (uint a = 0; a < porc.length(); ++a) {
                const float sq = MapHelpers::SqDist(t.pos, porc[a]);
                if (sq >= best) continue;
                const float reach = RangeAt(td, t.pos, porc[a]) + margin;
                if (sq > reach * reach) continue;
                best = sq; t.porc = porc[a]; t.porcDist = sqrt(sq);
            }
            for (uint h = 0; h < hpos.length() && !t.covered; ++h) {
                const float r = RangeAt(hdef[h], hpos[h], t.pos) + 16.0f;
                t.covered = MapHelpers::SqDist(hpos[h], t.pos) <= r * r;
            }
        }
    }

    bool Busy(CCircuitUnit@ u) {
        if (u is null || u.task is null) return false;
        return u.task.IsExternalControlled() || u.task.GetType() == int(Task::Type::PLAYER) || u.task.GetType() == int(Task::Type::RETREAT);
    }

    CCircuitDef@ Pick(array<CCircuitDef@>@ l, CCircuitUnit@ u) {
        if (l is null || u is null || u.circuitDef is null) return null;
        const string side = UnitHelpers::GetSideForUnitName(u.circuitDef.GetName());
        CCircuitDef@ other = null;
        for (uint i = 0; i < l.length(); ++i) {
            if (l[i] is null || !u.circuitDef.CanBuild(l[i])) continue;
            if (UnitHelpers::GetSideForUnitName(l[i].GetName()) == side) return l[i];
            if (other is null) @other = l[i];
        }
        return other;
    }

    bool OnMap(const AIFloat3 &in p) {
        const float w = float(aiTerrainMgr.GetTerrainWidth()), h = float(aiTerrainMgr.GetTerrainHeight());
        return p.x >= EdgeGap && p.z >= EdgeGap && p.x <= w - EdgeGap && p.z <= h - EdgeGap;
    }

    // From the target toward the threatened porc (turned +-20..80 degrees when that leaves the map), at
    // RangeShare x range less the shake, pulled in until RangeShare x the height-aware range holds the target;
    // x < 0 when none
    AIFloat3 HeavySite(CCircuitDef@ d, Target@ t) {
        if (d is null || t is null) return AIFloat3(-1.0f, 0.0f, -1.0f);
        float dx = t.porc.x - t.pos.x, dz = t.porc.z - t.pos.z;
        float len = sqrt(dx * dx + dz * dz);
        if (len < 1.0f) { dx = Global::Map::StartPos.x - t.pos.x; dz = Global::Map::StartPos.z - t.pos.z; len = sqrt(dx * dx + dz * dz); }
        if (len < 1.0f) return AIFloat3(-1.0f, 0.0f, -1.0f);
        dx /= len; dz /= len;
        float range = aiBattle.MainRange(d);
        if (range <= 0.0f) range = d.GetMaxRange();
        const float share = Global::RoleSettings::Front::AgitatorCounterRangeShare;
        const float shake = Global::RoleSettings::Front::AgitatorCounterShake;
        for (int k = 0; k < 9; ++k) {
            const float deg = (k == 0) ? 0.0f : 20.0f * float((k + 1) / 2) * ((k % 2 == 1) ? 1.0f : -1.0f);
            const float a = deg * 3.14159265f / 180.0f;
            const float c = cos(a), s = sin(a);
            const float ux = dx * c - dz * s, uz = dx * s + dz * c;
            float r = range * share - shake;
            for (int it = 0; it < 12 && r >= 200.0f; ++it) {
                const AIFloat3 p(t.pos.x + ux * r, 0.0f, t.pos.z + uz * r);
                if (!OnMap(p)) break;
                const float lim = RangeAt(d, p, t.pos) * share - shake;
                if (r <= lim) return p;
                r = AiMin(r - 48.0f, lim);
            }
        }
        return AIFloat3(-1.0f, 0.0f, -1.0f);
    }

    // The commander group's T2 seats only (members 0..2)
    bool IsGroupT2(int id) {
        if (id < 0) return false;
        for (uint i = 0; i < 3 && i < CommanderGroup::members.length(); ++i) if (CommanderGroup::members[i] == id) return true;
        return false;
    }

    // A seat on the job is published to native as -1 (CommanderGroup::Update)
    bool Holds(int id) { return stage != 0 && id >= 0 && id == jobUnit; }

    bool OrderLive() { return order !is null && !order.IsDead(); }

    void Log(const string &in s) { GenericHelpers::LogUtil("[FRONT][AgitatorCounter] " + s, 1); }

    // The job ended: stage 4 until the T2 is handed back (from Update or its next ask, never inside a task
    // removal callback)
    void Finish(const string &in why) {
        stage = 4; @order = null; @popupDef = null;
        Log("job on " + jobKey + " ended (" + why + ")");
    }

    // Back to what it did before: its old task when it still lives, else native gives it group work.
    // `assign` false: the caller returns the task itself (an ask from native).
    IUnitTask@ Return(bool assign) {
        CCircuitUnit@ u = ai.GetTeamUnit(jobUnit);
        IUnitTask@ prev = prevTask;
        const int id = jobUnit;
        stage = 0; jobUnit = -1; @order = null; @prevTask = null; @popupDef = null;
        CommanderGroup::next = 0;   // republish the seat on the next group update
        if (u is null || u.circuitDef is null) { Log("T2 " + id + " gone; nothing to return"); return null; }
        if (prev is null || prev.IsDead() || Busy(u)) { Log("T2 " + id + " back to group work (its old task is gone)"); return null; }
        Log("T2 " + id + " back to its old task (type " + int(prev.GetType()) + ")");
        if (assign && !(u.task is prev)) aiBuilderMgr.AssignTask(u, prev);
        return prev;
    }

    void Abort(const string &in why) {
        IUnitTask@ dead = order;
        @order = null;
        if (dead !is null && !dead.IsDead()) aiBuilderMgr.AbortTask(dead);
        holds.set(jobKey, ai.frame + HoldSeconds * SECOND);
        Finish(why);
    }

    // Stage 3: the heavy stands; order the pop-up in front of it
    void OrderPopup() {
        CCircuitUnit@ u = ai.GetTeamUnit(jobUnit);
        if (u is null || u.circuitDef is null) { Finish("T2 died before the pop-up"); return; }
        CCircuitDef@ d = popupDef;
        if (d is null) @d = Pick(popupDefs, u);
        if (d is null) { Finish("no pop-up it can build"); return; }
        if (d.maxThisUnit >= 0 && d.maxThisUnit <= d.count) d.maxThisUnit = d.count + 1;
        if (!d.IsAvailable(ai.frame)) { Finish("pop-up not available"); return; }
        @order = aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::DEFENCE, Task::Priority::HIGH, d, popupSite,
            Global::RoleSettings::Front::AgitatorCounterPopupShake, true, OrderTimeoutSeconds * SECOND));
        if (order is null) { Finish("pop-up order refused"); return; }
        stage = 2; orderFrame = ai.frame;
        if (!(u.task is order) && !Busy(u)) aiBuilderMgr.AssignTask(u, order);
        Log("T2 " + u.id + " orders " + d.GetName() + " at (" + int(popupSite.x) + "," + int(popupSite.z) + ") in front of the heavy");
    }

    // Builder AiMakeTask, first for every FRONT constructor: the T2 on the job keeps its order
    bool Owns(CCircuitUnit@ u) {
        if (u is null || u.task is null || u.task.IsDead() || (stage != 1 && stage != 2) || u.id != jobUnit) return false;
        return OrderLive() && u.task is order;
    }

    // Front_BuilderAiTaskRemoved
    void TaskRemoved(IUnitTask@ task, bool done) {
        if (task is null || stage == 0 || !(order is task)) return;
        @order = null;
        if (!done) {
            // why: which task the T2 is on now and how far from the site (diagnostic)
            CCircuitUnit@ u = ai.GetTeamUnit(jobUnit);
            string now = " dead";
            if (u !is null) {
                now = " now on " + ((u.task is null) ? "no task" : "task type " + int(u.task.GetType()));
                IBuilderTask@ cur = cast<IBuilderTask>(u.task);
                if (cur !is null) now += " build " + int(cur.GetBuildType());
                now += ", " + int(sqrt(MapHelpers::SqDist(u.GetPos(ai.frame), heavySite))) + " from the site";
            }
            Log("order removed undone; T2 " + jobUnit + now);
        }
        if (stage == 1) {
            if (!done) {
                holds.set(jobKey, ai.frame + HoldSeconds * SECOND);
                Finish("heavy order died without a heavy; target held " + HoldSeconds + " s");
                return;
            }
            Log("heavy built against " + jobKey);
            stage = 3;   // ordered from Update / Work (not inside the removal callback)
            lastScan = -100000;
            return;
        }
        if (stage == 2) Finish(done ? "pop-up built" : "pop-up order died");
    }

    // CommanderGroup::Update, once a second before the seats are published
    void Update() {
        if (!On()) { if (stage == 4) Return(true); else if (stage != 0) Abort("off"); return; }
        Defs();
        if (stage == 4) { Return(true); return; }
        if (stage != 0) {
            CCircuitUnit@ u = ai.GetTeamUnit(jobUnit);
            if (u is null || u.circuitDef is null || !IsGroupT2(jobUnit)) {
                IUnitTask@ dead = order;
                @order = null;   // before the abort: its removal callback must not count it
                if (dead !is null && !dead.IsDead()) aiBuilderMgr.AbortTask(dead);
                Finish("T2 gone from the group");
                return;
            }
            if (FrontRecovery::Active()) { Abort("base recovery"); return; }
            if (stage == 3) { OrderPopup(); return; }
            if (!OrderLive()) { if (stage == 1) Abort("heavy order lost"); else Finish("pop-up order lost"); return; }
            IBuilderTask@ b = cast<IBuilderTask>(order);
            if (b !is null && b.target is null && ai.frame - orderFrame >= FrameDeadlineSeconds * SECOND) {
                Abort("no frame after " + FrameDeadlineSeconds + " s");
                return;
            }
            if (!(u.task is order) && !Busy(u)) aiBuilderMgr.AssignTask(u, order);   // native took it: back on the job
            return;
        }
        if (FrontRecovery::Active()) return;
        if (ai.frame - lastScan < Global::RoleSettings::Front::AgitatorCounterScanSeconds * SECOND) return;
        Scan();
        Start();
    }

    void Start() {
        int open = 0;
        for (uint i = 0; i < targets.length(); ++i) if (!targets[i].covered && targets[i].porcDist >= 0.0f) ++open;
        if (open == 0) return;
        if (standing >= Global::RoleSettings::Front::AgitatorCounterMax) return;
        const float mi = Economy::GetMinMetalIncomeLast10s();
        if (mi < Global::RoleSettings::Front::AgitatorCounterMinMetalIncome) return;
        // targets nearest our porc first
        array<int> byDist;
        for (uint i = 0; i < targets.length(); ++i) {
            if (targets[i].covered || targets[i].porcDist < 0.0f) continue;
            uint at = 0;
            while (at < byDist.length() && targets[byDist[at]].porcDist <= targets[i].porcDist) ++at;
            byDist.insertAt(at, int(i));
        }
        const float reach = Global::RoleSettings::Front::AgitatorCounterReach;
        for (uint k = 0; k < byDist.length(); ++k) {
            Target@ t = targets[byDist[k]];
            if (t is null) continue;
            int until = -1;
            if (holds.get(t.key, until) && ai.frame < until) continue;
            CCircuitUnit@ best = null;
            CCircuitDef@ bestDef = null;
            AIFloat3 bestSite;
            float bestSq = reach * reach;
            int vehicleBlocked = 0;
            for (uint s = 0; s < 3 && s < CommanderGroup::members.length(); ++s) {
                CCircuitUnit@ u = ai.GetTeamUnit(CommanderGroup::members[s]);
                if (u is null || u.circuitDef is null || u.GetBuildProgress() < 1.0f || Busy(u)) continue;
                if (FrontTactical::Owns(u) || FrontAgitator::OnOrder(u) || LolCannon::IsCrew(u.id)) continue;
                CCircuitDef@ d = Pick(heavyDefs, u);
                if (d is null) continue;
                const AIFloat3 site = HeavySite(d, t);
                if (site.x < 0.0f) continue;
                // native drops a vehicle constructor's build inside a scouted enemy gun's reach (owner 2026-11-04,
                // IBuilderTask::DropIfPorc): a T2 vehicle only takes a site outside the agitator's reach
                // (Gauntlet 1220 / Agitator 1245 always reach 80% of a heavy's range; Amputator 1000 does not)
                if (Global::RoleSettings::Front::AgitatorCounterVehicleUnits.find(u.circuitDef.GetName()) >= 0) {
                    const float reachT = RangeAt(ai.GetCircuitDef(t.defId), t.pos, site) + Global::RoleSettings::Front::AgitatorCounterOverlapMargin;
                    if (MapHelpers::SqDist(site, t.pos) <= reachT * reachT) { ++vehicleBlocked; continue; }
                }
                const float sq = MapHelpers::SqDist(u.GetPos(ai.frame), site);
                if (sq > bestSq || !aiTerrainMgr.CanReachAt(u, site, u.circuitDef.GetBuildDistance())) continue;
                bestSq = sq; @best = u; @bestDef = d; bestSite = site;
            }
            if (best is null || bestDef is null) {
                if (vehicleBlocked > 0) {
                    holds.set(t.key, ai.frame + HoldSeconds * SECOND);
                    Log("only T2 vehicles near " + t.defName + " at (" + int(t.pos.x) + "," + int(t.pos.z)
                        + "); its reach covers the 80% site and native keeps vehicles out of enemy gun reach; held " + HoldSeconds + " s");
                }
                continue;
            }
            if (bestDef.maxThisUnit >= 0 && bestDef.maxThisUnit <= bestDef.count) bestDef.maxThisUnit = bestDef.count + 1;
            if (!bestDef.IsAvailable(ai.frame)) return;
            IUnitTask@ o = aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::DEFENCE, Task::Priority::HIGH, bestDef, bestSite,
                Global::RoleSettings::Front::AgitatorCounterShake, true, OrderTimeoutSeconds * SECOND));
            if (o is null) { holds.set(t.key, ai.frame + HoldSeconds * SECOND); continue; }
            // the job: remember what it did, take it off the group (published -1), put it on the order
            @prevTask = (best.task !is null && !best.task.IsDead()) ? best.task : null;
            @order = o; stage = 1; jobUnit = best.id; jobKey = t.key; jobTarget = t.pos; heavySite = bestSite;
            orderFrame = ai.frame;
            @popupDef = Pick(popupDefs, best);
            float dx = t.pos.x - bestSite.x, dz = t.pos.z - bestSite.z;
            const float len = sqrt(dx * dx + dz * dz);
            const float fwd = Global::RoleSettings::Front::AgitatorCounterPopupForward;
            popupSite = (len > 1.0f) ? AIFloat3(bestSite.x + dx / len * fwd, bestSite.y, bestSite.z + dz / len * fwd) : bestSite;
            // unpublish the seat before the assign: native group work took a still-published seat straight back
            // onto its own defence job inside AssignTask and the order died with nobody on it (Carrot, headless 11-12)
            for (uint s = 0; s < 3 && s < CommanderGroup::members.length(); ++s)
                if (CommanderGroup::members[s] == best.id) aiBuilderMgr.SetCommanderCombatOption("commander_group_member" + s, -1.0f);
            const int bestId = best.id;
            Log("T2 " + best.circuitDef.GetName() + " " + best.id + " orders " + bestDef.GetName() + " at (" + int(bestSite.x) + ","
                + int(bestSite.z) + "), " + int(sqrt(MapHelpers::SqDist(bestSite, t.pos))) + " from " + (t.ghost ? "ghost of " : "")
                + t.defName + " at (" + int(t.pos.x) + "," + int(t.pos.z) + ") (range " + int(RangeAt(bestDef, bestSite, t.pos))
                + "); it reaches our porc " + int(t.porcDist) + " away; mi +" + int(mi) + "; " + standing + " heavies, " + open + " open"
                + (prevTask is null ? "; no previous task" : "; previous task type " + int(prevTask.GetType())));
            CCircuitUnit@ again = ai.GetTeamUnit(bestId);   // re-resolve: the log line ran no callback, but stay safe
            if (again !is null && OrderLive() && !(again.task is order)) aiBuilderMgr.AssignTask(again, order);
            return;
        }
    }

    // CommanderGroup::Work for a T2 seat: on the job it keeps the order; a finished job hands it nothing
    // (Finish already gave it its old task), so the group's native work runs
    IUnitTask@ Work(CCircuitUnit@ u) {
        if (u is null || stage == 0 || u.id != jobUnit) return null;
        if (stage == 3) OrderPopup();
        if (stage == 4) return Return(false);
        if (OrderLive()) return order;
        return null;
    }
}
