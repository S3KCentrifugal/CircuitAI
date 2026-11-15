// FRONT counter to enemy T1.5 porc clusters (owner, 2026-11-14; Front::PorcCluster*).
//
// Owner: "when more than 3 enemy T1.5 anti-ground statics (Beamer, Overwatch, Cacophony, Warden, Twin Guard and
// every faction's equivalents) stand within 350 elmos of each other, place behind our commander group's
// furthest-forward T1.5 defensive static, in a semicircle up to 300 behind and 300 to either side: the T1
// constructor builds an Amputator / Gauntlet / Agitator; if a T2 constructor is at the commander group and metal
// income is above 65/s, the T2 instead places a Persecutor / Rattlesnake / Eviscerator as soon as it reaches the
// front group."
//
// Cluster: known enemy PorcClusterTargets (identified ground contacts in radar / LOS now plus ghost images, from
// the shared battle snapshot). A turret with PorcClusterMinCount - 1 or more others within PorcClusterRadius seeds
// a cluster of itself and those others (most neighbours first, each turret in one cluster).
// Covered: a gun of ours (T1 or T2 list; finished or framed, from any system) reaches one of its turrets.
// Anchor: our finished PorcClusterAnchors within PorcClusterGroupRadius of the commander group's centre (the FRONT
// commander, else a T2 seat, else the group's T1 constructor), nearest the cluster first. None: the group centre
// itself (fallback, logged).
// Site: the half disc behind the anchor (away from the cluster centre), PorcClusterBack deep and PorcClusterSide to
// either side; buildable terrain (CanUpgradeTerrain), reachable by the builder, and the gun's height-aware range x
// PorcClusterReachShare must hold at least one cluster turret. Best: most cluster turrets held, then furthest out
// of the cluster turrets' reach (vehicle constructors: must be outside it, native drops their builds inside a
// scouted gun's reach, so for them outside every known enemy static ground gun's), then nearest the anchor.
// Builder: with a 10 s minimum metal income > PorcClusterT2MinMetalIncome and a T2 seat of the group (members 0..2)
// that can build a T2 gun: the nearest such seat within PorcClusterT2JoinRadius of the group centre. A T2 seat still
// on its way holds the cluster PorcClusterT2WaitSeconds, then the T1 builds. Otherwise the group's T1 constructor
// (FrontConstructors COMMANDER seat). One job at a time; the builder is unpublished from native group work while on
// it (CommanderGroup::Update / PublishUnit), is kept first in AiMakeTask, and gets its old task back after.
// Every unit / task handle is checked for null (and IsDead) before use. Log [FRONT][PorcCluster].
// Cost: battle snapshot contacts + ghosts filtered to six defs, one owned-unit scan, every PorcClusterScanSeconds
// while on; clustering O(T^2) over the few targets; site search (~90 points x cluster turrets) only when a job
// starts.
namespace FrontPorcClusterCounter {
    const int OrderTimeoutSeconds = 240;
    const int FrameDeadlineSeconds = 150;   // an order with no frame by then is aborted
    const int HoldSeconds = 120;
    const float EdgeGap = 96.0f;
    const float SiteStep = 50.0f;
    const float MinBack = 64.0f;            // clear of the anchor's own footprint

    class Turret {
        AIFloat3 pos;
        int defId = -1;
        bool ghost = false;
        int cluster = -1;
        int near = 0;
    }
    class Cluster {
        string key;
        AIFloat3 centre;
        array<int> members;   // indices into turrets
        bool covered = false;
        string names;
    }

    array<CCircuitDef@> targetDefs, anchorDefs, t1Defs, t2Defs;
    array<Turret@> turrets;
    array<Cluster@> clusters;
    array<AIFloat3> anchors;   // our group anchors (scan)
    // every known enemy static ground gun (scan): native drops a vehicle constructor's build inside any of their
    // reach (IBuilderTask::DropIfPorc, EnemyPorcClearance), not only the cluster's (headless 11-14: Persecutor
    // orders of coracv died at once, 64 behind our static, outside every cluster turret's reach)
    array<AIFloat3> gunPos;
    array<float> gunReach;
    int standing = 0;          // our guns covering a current cluster
    int lastScan = -100000;
    bool defsDone = false;
    dictionary holds;          // cluster key -> frame the hold ends
    dictionary waits;          // cluster key -> frame the T2 wait began

    // the job
    int stage = 0;             // 0 none, 1 order open, 4 ended (hand back)
    int jobUnit = -1;
    bool jobT2 = false;
    IUnitTask@ order;
    IUnitTask@ prevTask;
    string jobKey = "";
    AIFloat3 jobSite;
    int orderFrame = 0;

    bool On() { return Global::RoleSettings::Front::PorcClusterCounter && Global::AISettings::Role == AiRole::FRONT; }

    void Reset() {
        targetDefs.resize(0); anchorDefs.resize(0); t1Defs.resize(0); t2Defs.resize(0);
        turrets.resize(0); clusters.resize(0); anchors.resize(0); standing = 0; lastScan = -100000; defsDone = false;
        holds.deleteAll(); waits.deleteAll();
        stage = 0; jobUnit = -1; jobT2 = false; @order = null; @prevTask = null; jobKey = "";
    }

    void AddDefs(const array<string>@ names, array<CCircuitDef@>@ into) {
        if (names is null || into is null) return;
        for (uint i = 0; i < names.length(); ++i) { CCircuitDef@ d = ai.GetCircuitDef(names[i]); if (d !is null) into.insertLast(d); }
    }
    void Defs() {
        if (defsDone) return;
        defsDone = true;
        AddDefs(Global::RoleSettings::Front::PorcClusterTargets, targetDefs);
        AddDefs(Global::RoleSettings::Front::PorcClusterAnchors, anchorDefs);
        AddDefs(Global::RoleSettings::Front::PorcClusterT1Guns, t1Defs);
        AddDefs(Global::RoleSettings::Front::PorcClusterT2Guns, t2Defs);
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
    string At(const AIFloat3 &in p) { return "(" + int(p.x) + "," + int(p.z) + ")"; }
    float Dist(const AIFloat3 &in a, const AIFloat3 &in b) { return sqrt(MapHelpers::SqDist(a, b)); }

    float RangeAt(const CCircuitDef@ d, const AIFloat3 &in from, const AIFloat3 &in to) {
        if (d is null) return 0.0f;
        const float r = aiBattle.EffectiveRange(d, from, to);
        return (r > 0.0f) ? r : d.GetMaxRange();
    }

    void Log(const string &in s) { GenericHelpers::LogUtil("[FRONT][PorcCluster] " + s, 1); }

    void AddTurret(const AIFloat3 &in p, int defId, bool ghost) {
        for (uint i = 0; i < turrets.length(); ++i)
            if (MapHelpers::SqDist(turrets[i].pos, p) <= 48.0f * 48.0f) return;   // the same structure (seen + ghost)
        Turret@ t = Turret();
        t.pos = p; t.defId = defId; t.ghost = ghost;
        turrets.insertLast(t);
    }

    void AddGun(const AIFloat3 &in p, int defId) {
        CCircuitDef@ d = ai.GetCircuitDef(defId);
        if (d is null || d.IsMobile() || d.IsAbleToFly() || !d.HasSurfToLand()) return;
        // native's list (CEconomyManager::RefreshMexPorc): land range, guns over porc_max_range 1800 left out
        const float r = d.GetMaxRange();
        if (r <= 0.0f || r > 1800.0f) return;
        gunPos.insertLast(p); gunReach.insertLast(r);
    }
    // elmos outside the nearest known enemy static gun's reach (< 0 inside); only guns within `near` of `at`
    float GunClear(const AIFloat3 &in p, const array<int>@ near) {
        float clear = 1e9f;
        for (uint i = 0; i < near.length(); ++i)
            clear = AiMin(clear, Dist(p, gunPos[near[i]]) - gunReach[near[i]]);
        return clear;
    }

    // The commander group's centre: its commander, else a T2 seat, else its T1 constructor; x < 0 when none
    AIFloat3 GroupCentre() {
        CCircuitUnit@ c = ai.GetTeamUnit(aiBuilderMgr.FrontCommanderId());
        if (c !is null) return c.GetPos(ai.frame);
        for (uint i = 0; i < 3 && i < CommanderGroup::members.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(CommanderGroup::members[i]);
            if (u !is null) return u.GetPos(ai.frame);
        }
        CCircuitUnit@ con = ai.GetTeamUnit(FrontConstructors::seats[FrontConstructors::COMMANDER]);
        if (con !is null) return con.GetPos(ai.frame);
        return AIFloat3(-1.0f, 0.0f, -1.0f);
    }

    void Scan() {
        lastScan = ai.frame;
        turrets.resize(0); clusters.resize(0); anchors.resize(0); gunPos.resize(0); gunReach.resize(0); standing = 0;
        const int nc = aiBattle.GetGroundContactCount();
        for (int i = 0; i < nc; ++i) {
            const int id = aiBattle.GetGroundContactDefId(i);
            if (IsTargetDef(id)) AddTurret(aiBattle.GetGroundContactPos(i), id, false);
            AddGun(aiBattle.GetGroundContactPos(i), id);
        }
        const int ng = aiBattle.GetGhostCount();
        for (int i = 0; i < ng; ++i) {
            const int id = aiBattle.GetGhostDefId(i);
            if (IsTargetDef(id)) AddTurret(aiBattle.GetGhostPos(i), id, true);
            AddGun(aiBattle.GetGhostPos(i), id);
        }
        const int need = Global::RoleSettings::Front::PorcClusterMinCount;
        if (int(turrets.length()) < need) return;
        // neighbours within the radius
        const float r = Global::RoleSettings::Front::PorcClusterRadius;
        const float r2 = r * r;
        for (uint i = 0; i < turrets.length(); ++i)
            for (uint j = i + 1; j < turrets.length(); ++j)
                if (MapHelpers::SqDist(turrets[i].pos, turrets[j].pos) <= r2) { ++turrets[i].near; ++turrets[j].near; }
        // seeds, most neighbours first; each turret in one cluster
        for (;;) {
            int seed = -1;
            for (uint i = 0; i < turrets.length(); ++i) {
                if (turrets[i].cluster >= 0 || turrets[i].near + 1 < need) continue;
                if (seed < 0 || turrets[i].near > turrets[seed].near) seed = int(i);
            }
            if (seed < 0) break;
            Cluster@ c = Cluster();
            c.members.insertLast(seed);
            for (uint j = 0; j < turrets.length(); ++j)
                if (int(j) != seed && turrets[j].cluster < 0 && MapHelpers::SqDist(turrets[seed].pos, turrets[j].pos) <= r2)
                    c.members.insertLast(int(j));
            turrets[seed].near = -1;   // consumed as a seed
            if (int(c.members.length()) < need) continue;   // its neighbours already went to an earlier cluster
            float x = 0.0f, z = 0.0f;
            for (uint k = 0; k < c.members.length(); ++k) {
                Turret@ t = turrets[c.members[k]];
                t.cluster = int(clusters.length());
                x += t.pos.x; z += t.pos.z;
                CCircuitDef@ d = ai.GetCircuitDef(t.defId);
                c.names += ((k == 0) ? "" : " ") + ((d is null) ? ("def" + t.defId) : d.GetName()) + (t.ghost ? "*" : "");
            }
            c.centre = AIFloat3(x / float(c.members.length()), 0.0f, z / float(c.members.length()));
            c.key = Key(turrets[seed].pos);
            clusters.insertLast(c);
        }
        if (clusters.length() == 0) return;
        // our guns (coverage) and the group's anchors
        const AIFloat3 centre = GroupCentre();
        const float gr = Global::RoleSettings::Front::PorcClusterGroupRadius;
        const float coverShare = Global::RoleSettings::Front::PorcClusterCoverShare;
        array<Id>@ ids = ai.GetOwnedUnitIds();
        if (ids is null) return;
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef is null) continue;
            const CCircuitDef@ d = u.circuitDef;
            if (In(t1Defs, d) || In(t2Defs, d)) {
                const AIFloat3 p = u.GetPos(ai.frame);
                bool counts = false;
                // covers a cluster when it holds one of its turrets (the site rule), not only its centre: a gun
                // placed behind our static often reaches the near turrets only (headless 11-14: a second Persecutor
                // ordered on the first one's site)
                for (uint c = 0; c < clusters.length(); ++c) {
                    if (clusters[c].covered) continue;
                    for (uint m = 0; m < clusters[c].members.length() && !clusters[c].covered; ++m) {
                        const AIFloat3 tp = turrets[clusters[c].members[m]].pos;
                        const float reach = RangeAt(d, p, tp) * coverShare;
                        if (MapHelpers::SqDist(p, tp) <= reach * reach) { clusters[c].covered = true; counts = true; }
                    }
                }
                if (counts) ++standing;
                continue;
            }
            if (centre.x < 0.0f || u.GetBuildProgress() < 1.0f || !In(anchorDefs, d)) continue;
            const AIFloat3 p = u.GetPos(ai.frame);
            if (MapHelpers::SqDist(p, centre) <= gr * gr) anchors.insertLast(p);
        }
    }

    bool Busy(CCircuitUnit@ u) {
        if (u is null || u.task is null) return false;
        return u.task.IsExternalControlled() || u.task.GetType() == int(Task::Type::PLAYER) || u.task.GetType() == int(Task::Type::RETREAT);
    }
    // on a framed build of its own: it finishes first (a lone builder leaving its frame strands it)
    bool OnFrame(CCircuitUnit@ u) {
        if (u is null) return false;
        IBuilderTask@ cur = cast<IBuilderTask>(u.task);
        return cur !is null && !cur.IsDead() && cur.target !is null && cur.GetBuildType() < int(Task::BuildType::REPAIR);
    }
    bool Free(CCircuitUnit@ u) {
        if (u is null || u.circuitDef is null || u.GetBuildProgress() < 1.0f || Busy(u) || OnFrame(u)) return false;
        if (FrontAgitatorCounter::Holds(u.id) || FrontAgitatorCounter::Owns(u)) return false;
        if (FrontTactical::Owns(u) || FrontAgitator::OnOrder(u) || LolCannon::IsCrew(u.id)) return false;
        return true;
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

    // The best site in the half disc behind `anchor` (away from the cluster centre) for `d` built by `u`;
    // x < 0 when none. `held` returns how many cluster turrets it holds.
    AIFloat3 Site(CCircuitDef@ d, CCircuitUnit@ u, Cluster@ c, const AIFloat3 &in anchor, int &out held) {
        held = 0;
        AIFloat3 none(-1.0f, 0.0f, -1.0f);
        if (d is null || u is null || u.circuitDef is null || c is null) return none;
        float bx = anchor.x - c.centre.x, bz = anchor.z - c.centre.z;
        const float len = sqrt(bx * bx + bz * bz);
        if (len < 1.0f) return none;
        bx /= len; bz /= len;
        const float sx = -bz, sz = bx;   // sideways
        const float back = Global::RoleSettings::Front::PorcClusterBack, side = Global::RoleSettings::Front::PorcClusterSide;
        const float share = Global::RoleSettings::Front::PorcClusterReachShare;
        const bool vehicle = Global::RoleSettings::Front::PorcClusterVehicleUnits.find(u.circuitDef.GetName()) >= 0;
        const float vmargin = Global::RoleSettings::Front::PorcClusterVehicleMargin;
        array<int> near;   // enemy guns that could reach the half disc (vehicles only)
        if (vehicle)
            for (uint i = 0; i < gunPos.length(); ++i) {
                const float r = gunReach[i] + AiMax(back, side) + vmargin;
                if (MapHelpers::SqDist(gunPos[i], anchor) <= r * r) near.insertLast(int(i));
            }
        AIFloat3 best = none;
        float bestScore = -1e30f;
        for (float along = MinBack; along <= back + 0.5f; along += SiteStep) {
            for (float across = -side; across <= side + 0.5f; across += SiteStep) {
                const float ea = along / back, ec = across / side;
                if (ea * ea + ec * ec > 1.0f) continue;   // outside the half disc
                const AIFloat3 p(anchor.x + bx * along + sx * across, 0.0f, anchor.z + bz * along + sz * across);
                if (!OnMap(p) || !aiTerrainMgr.CanUpgradeTerrain(d, p)) continue;
                int n = 0;
                float clear = 1e9f;   // elmos outside the nearest cluster turret's reach (< 0 inside)
                for (uint k = 0; k < c.members.length(); ++k) {
                    Turret@ t = turrets[c.members[k]];
                    const float dist = Dist(p, t.pos);
                    if (dist <= RangeAt(d, p, t.pos) * share) ++n;
                    clear = AiMin(clear, dist - RangeAt(ai.GetCircuitDef(t.defId), t.pos, p));
                }
                if (n == 0) continue;
                if (vehicle && (clear < vmargin || GunClear(p, near) < vmargin)) continue;
                const float score = float(n) * 10000.0f + AiMin(clear, 300.0f) * 4.0f - (along * along + across * across) * 0.001f;
                if (score <= bestScore) continue;
                if (!aiTerrainMgr.CanReachAt(u, p, u.circuitDef.GetBuildDistance())) continue;
                bestScore = score; best = p; held = n;
            }
        }
        return best;
    }

    // A seat on the job is unpublished from native group work (CommanderGroup::Update / PublishUnit)
    bool Holds(int id) { return stage != 0 && id >= 0 && id == jobUnit; }
    bool OrderLive() { return order !is null && !order.IsDead(); }

    void Finish(const string &in why) {
        stage = 4; @order = null;
        Log("job on " + jobKey + " ended (" + why + ")");
    }

    IUnitTask@ Return(bool assign) {
        CCircuitUnit@ u = ai.GetTeamUnit(jobUnit);
        IUnitTask@ prev = prevTask;
        const int id = jobUnit;
        stage = 0; jobUnit = -1; @order = null; @prevTask = null;
        CommanderGroup::next = 0;   // republish the seat on the next group update
        if (u is null || u.circuitDef is null) { Log("builder " + id + " gone; nothing to return"); return null; }
        if (prev is null || prev.IsDead() || Busy(u)) { Log("builder " + id + " back to group work (its old task is gone)"); return null; }
        Log("builder " + id + " back to its old task (type " + int(prev.GetType()) + ")");
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

    // Builder AiMakeTask, first for every FRONT constructor: the builder on the job keeps its order
    bool Owns(CCircuitUnit@ u) {
        if (u is null || u.task is null || u.task.IsDead() || stage != 1 || u.id != jobUnit) return false;
        return OrderLive() && u.task is order;
    }

    // Front_BuilderAiTaskRemoved
    void TaskRemoved(IUnitTask@ task, bool done) {
        if (task is null || stage == 0 || !(order is task)) return;
        @order = null;
        if (!done) {
            holds.set(jobKey, ai.frame + HoldSeconds * SECOND);
            Finish("order died without a gun; cluster held " + HoldSeconds + " s");
            return;
        }
        Log("gun built at " + At(jobSite) + " against cluster " + jobKey + " in " + ((ai.frame - orderFrame) / SECOND) + " s");
        lastScan = -100000;
        Finish("built");
    }

    bool IsGroupT2(int id) {
        if (id < 0) return false;
        for (uint i = 0; i < 3 && i < CommanderGroup::members.length(); ++i) if (CommanderGroup::members[i] == id) return true;
        return false;
    }
    bool StillGroup(int id) {
        return jobT2 ? IsGroupT2(id) : (id >= 0 && FrontConstructors::seats[FrontConstructors::COMMANDER] == id);
    }

    // CommanderGroup::Update, once a second before the seats are published
    void Update() {
        if (!On()) { if (stage == 4) Return(true); else if (stage != 0) Abort("off"); return; }
        Defs();
        if (stage == 4) { Return(true); return; }
        if (stage != 0) {
            CCircuitUnit@ u = ai.GetTeamUnit(jobUnit);
            if (u is null || u.circuitDef is null || !StillGroup(jobUnit)) {
                IUnitTask@ dead = order;
                @order = null;
                if (dead !is null && !dead.IsDead()) aiBuilderMgr.AbortTask(dead);
                Finish("builder gone from the group");
                return;
            }
            if (FrontRecovery::Active()) { Abort("base recovery"); return; }
            if (!OrderLive()) { Abort("order lost"); return; }
            IBuilderTask@ b = cast<IBuilderTask>(order);
            if (b !is null && b.target is null && ai.frame - orderFrame >= FrameDeadlineSeconds * SECOND) {
                Abort("no frame after " + FrameDeadlineSeconds + " s");
                return;
            }
            if (!(u.task is order) && !Busy(u)) aiBuilderMgr.AssignTask(u, order);   // native took it: back on the job
            return;
        }
        if (FrontRecovery::Active()) return;
        if (ai.frame - lastScan < Global::RoleSettings::Front::PorcClusterScanSeconds * SECOND) return;
        Scan();
        Start();
    }

    // The nearest T2 seat that can build a T2 gun; `joined` whether it is at the group
    CCircuitUnit@ T2Seat(const AIFloat3 &in centre, bool &out any) {
        any = false;
        CCircuitUnit@ best = null;
        float bestSq = 1e30f;
        const float join = Global::RoleSettings::Front::PorcClusterT2JoinRadius;
        for (uint s = 0; s < 3 && s < CommanderGroup::members.length(); ++s) {
            CCircuitUnit@ u = ai.GetTeamUnit(CommanderGroup::members[s]);
            if (u is null || u.circuitDef is null || Pick(t2Defs, u) is null) continue;
            any = true;
            if (!Free(u)) continue;
            const float sq = MapHelpers::SqDist(u.GetPos(ai.frame), centre);
            if (sq > join * join || sq >= bestSq) continue;
            bestSq = sq; @best = u;
        }
        return best;
    }

    // The nearest of `pts` to the cluster's nearest turret (elmos); `at` returns that point
    float Gap(Cluster@ c, const array<AIFloat3>@ pts, AIFloat3 &out at) {
        float best = 1e30f;
        at = AIFloat3(-1.0f, 0.0f, -1.0f);
        for (uint a = 0; a < pts.length(); ++a)
            for (uint k = 0; k < c.members.length(); ++k) {
                const float sq = MapHelpers::SqDist(pts[a], turrets[c.members[k]].pos);
                if (sq < best) { best = sq; at = pts[a]; }
            }
        return sqrt(best);
    }
    float MaxRange(const array<CCircuitDef@>@ l) {
        float r = 0.0f;
        for (uint i = 0; i < l.length(); ++i) if (l[i] !is null) r = AiMax(r, l[i].GetMaxRange());
        return r;
    }

    void Start() {
        int open = 0;
        for (uint i = 0; i < clusters.length(); ++i) if (!clusters[i].covered) ++open;
        if (open == 0) return;
        if (standing >= Global::RoleSettings::Front::PorcClusterMax) return;
        const AIFloat3 centre = GroupCentre();
        if (centre.x < 0.0f) return;
        // clusters nearest the group first
        array<int> byDist;
        for (uint i = 0; i < clusters.length(); ++i) {
            if (clusters[i].covered) continue;
            uint at = 0;
            const float sq = MapHelpers::SqDist(clusters[i].centre, centre);
            while (at < byDist.length() && MapHelpers::SqDist(clusters[byDist[at]].centre, centre) <= sq) ++at;
            byDist.insertAt(at, int(i));
        }
        const float mi = Economy::GetMinMetalIncomeLast10s();
        const bool t2Gate = mi > Global::RoleSettings::Front::PorcClusterT2MinMetalIncome;
        const float reach = Global::RoleSettings::Front::PorcClusterReach;
        for (uint k = 0; k < byDist.length(); ++k) {
            Cluster@ c = clusters[byDist[k]];
            if (c is null) continue;
            int until = -1;
            if (holds.get(c.key, until) && ai.frame < until) continue;
            // a cluster no gun of ours could reach from behind the group's statics (or its centre) is someone
            // else's front: skipped silently (every allied FRONT sees every cluster)
            array<AIFloat3> pts = anchors;
            if (pts.length() == 0) pts.insertLast(centre);
            AIFloat3 nearPt;
            const float gap = Gap(c, pts, nearPt);
            const float back = Global::RoleSettings::Front::PorcClusterBack;
            if (gap > AiMax(MaxRange(t1Defs), MaxRange(t2Defs)) + back) continue;
            // the builder: a T2 seat at the group (income gate), else the group's T1 constructor
            CCircuitUnit@ b = null;
            bool t2 = false;
            if (t2Gate) {
                bool anyT2 = false;
                @b = T2Seat(centre, anyT2);
                if (b !is null) { t2 = true; waits.delete(c.key); }
                else if (anyT2) {
                    int since = -1;
                    if (!waits.get(c.key, since)) { since = ai.frame; waits.set(c.key, since); Log("cluster " + c.key + ": waiting up to " + Global::RoleSettings::Front::PorcClusterT2WaitSeconds + " s for a T2 seat to reach the group"); }
                    if (ai.frame - since < Global::RoleSettings::Front::PorcClusterT2WaitSeconds * SECOND) continue;
                }
            }
            if (b is null) {
                CCircuitUnit@ con = ai.GetTeamUnit(FrontConstructors::seats[FrontConstructors::COMMANDER]);
                if (con !is null && CommanderGroup::Eligible(con) && Free(con) && Pick(t1Defs, con) !is null) @b = con;
            }
            if (b is null) continue;
            CCircuitDef@ d = Pick(t2 ? t2Defs : t1Defs, b);
            if (d is null || gap > d.GetMaxRange() + back) continue;
            // anchors nearest the cluster first; none: the group centre
            array<AIFloat3> order_;
            for (uint a = 0; a < anchors.length(); ++a) {
                uint at = 0;
                const float sq = MapHelpers::SqDist(anchors[a], c.centre);
                while (at < order_.length() && MapHelpers::SqDist(order_[at], c.centre) <= sq) ++at;
                order_.insertAt(at, anchors[a]);
            }
            const bool fallback = order_.length() == 0;
            if (fallback) order_.insertLast(centre);
            AIFloat3 site(-1.0f, 0.0f, -1.0f), anchor;
            int held = 0;
            for (uint a = 0; a < order_.length() && a < 4 && site.x < 0.0f; ++a) {
                site = Site(d, b, c, order_[a], held);
                anchor = order_[a];
            }
            if (site.x < 0.0f) {
                holds.set(c.key, ai.frame + HoldSeconds * SECOND);
                Log("cluster " + c.key + " at " + At(c.centre) + " [" + c.names + "]: no " + d.GetName() + " site behind "
                    + (fallback ? "the group centre" : (order_.length() + " group statics")) + " reaches it (nearest "
                    + int(gap) + " from " + At(nearPt) + ", range " + int(d.GetMaxRange()) + "); held " + HoldSeconds + " s");
                continue;
            }
            if (MapHelpers::SqDist(b.GetPos(ai.frame), site) > reach * reach) continue;
            if (d.maxThisUnit >= 0 && d.maxThisUnit <= d.count) d.maxThisUnit = d.count + 1;
            if (!d.IsAvailable(ai.frame)) return;
            IUnitTask@ o = aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::DEFENCE, Task::Priority::HIGH, d, site,
                Global::RoleSettings::Front::PorcClusterShake, true, OrderTimeoutSeconds * SECOND));
            if (o is null) { holds.set(c.key, ai.frame + HoldSeconds * SECOND); Log("cluster " + c.key + ": " + d.GetName() + " order refused"); continue; }
            @prevTask = (b.task !is null && !b.task.IsDead()) ? b.task : null;
            @order = o; stage = 1; jobUnit = b.id; jobT2 = t2; jobKey = c.key; jobSite = site; orderFrame = ai.frame;
            // unpublish before the assign: native group work takes a still-published seat straight back
            if (t2) {
                for (uint s = 0; s < 3 && s < CommanderGroup::members.length(); ++s)
                    if (CommanderGroup::members[s] == b.id) aiBuilderMgr.SetCommanderCombatOption("commander_group_member" + s, -1.0f);
            } else aiBuilderMgr.SetCommanderCombatOption("commander_group_unit", -1.0f);
            const int bid = b.id;
            Log((t2 ? "T2 " : "T1 ") + b.circuitDef.GetName() + " " + bid + " orders " + d.GetName() + " at " + At(site)
                + " behind " + (fallback ? "the group centre (no group T1.5 static)" : "group static") + " at " + At(anchor)
                + " (" + int(Dist(site, anchor)) + " back/side), against cluster " + c.key + " at " + At(c.centre) + " of "
                + c.members.length() + " [" + c.names + "], " + int(Dist(site, c.centre)) + " from its centre, holds " + held
                + "; mi +" + int(mi) + "; " + standing + " guns, " + open + " open"
                + (prevTask is null ? "; no previous task" : "; previous task type " + int(prevTask.GetType())));
            CCircuitUnit@ again = ai.GetTeamUnit(bid);
            if (again !is null && OrderLive() && !(again.task is order)) aiBuilderMgr.AssignTask(again, order);
            return;
        }
    }

    // CommanderGroup::Work: on the job it keeps the order; a finished job hands back its old task
    IUnitTask@ Work(CCircuitUnit@ u) {
        if (u is null || stage == 0 || u.id != jobUnit) return null;
        if (stage == 4) return Return(false);
        if (OrderLive()) return order;
        return null;
    }
}
