// FRONT porc cluster artillery (owner, 2026-11-14; Front::PorcCluster*).
//
// Owner: "add a commander group step that starts an amputator/gauntlet/agitator with a commander group t1 con if
// there are more than 3 standing t1.5 static anti-ground defensive structures within 350 elmos of each other ...
// placed behind the furthest forward t1.5 defensive static, forward defined as closest to the enemy ... up to 300
// behind that unit, and up to 300 to one side or the other, roughly a semicircle. If a t2 con is present at the
// commander group, and metal income exceeds 65 metal per second, have the t2 con place a persecutor/rattlesnake/
// eviscerator as soon as a t2 con reaches front group instead." Owner 2026-11-14 (later): "the trigger is allied AI
// defenses and augmenting those defenses with t1.5 static arti or t2 heavy static arti." (An earlier version of this
// file triggered on ENEMY clusters; kept on branch porc-cluster-enemy-76min2.)
//
// Cluster: this AI's own finished PorcClusterTurrets (Beamer, Overwatch, Twin Guard, Warden, Cacophony, Hive), in
// points (owner 2026-11-18): PorcClusterHeavyTurrets (Overwatch, Warden, Cacophony) PorcClusterHeavyWeight each, the rest 1. A
// turret with PorcClusterMinCount points or more (itself + others) within PorcClusterRadius seeds a cluster of itself and those
// others (most neighbours first, each turret in one cluster). Every allied SMRTBARb FRONT runs this over its own
// turrets: script has no def-aware view of an ally's units, so a cluster made of two allies' turrets is not seen.
// Owner 2026-11-15: "Also count any combination of t2 pitbulls/scorpions/chimeras in range of any of the t1.5 ...
// always drop a persecutor/rattlesnake/eviscerator": our finished PorcClusterPopups count as cluster members (a cluster
// still needs one T1.5 turret), and a cluster holding one only takes a T2 gun from a T2 seat (no income gate).
// Forward turret: the cluster member nearest an enemy start (Lanes::EnemyStarts).
// Covered: a gun of ours (T1 or T2 list; finished or framed, from any system) within PorcClusterCoverRadius of the
// forward turret.
// Site: the half disc behind the forward turret (away from that enemy start), PorcClusterBack deep and
// PorcClusterSide to either side; buildable terrain (CanUpgradeTerrain) and reachable by the builder. Best: furthest
// out of every known enemy static ground gun's reach (capped), then nearest the turret. Vehicle constructors only
// take a site outside every such gun's reach + PorcClusterVehicleMargin: native drops their builds inside one
// (IBuilderTask::DropIfPorc).
// Builder: with a 10 s minimum metal income > PorcClusterT2MinMetalIncome and a T2 seat of the group (members 0..2)
// that can build a T2 gun: the nearest such seat within PorcClusterT2JoinRadius of the group centre. A T2 seat still
// on its way holds the cluster PorcClusterT2WaitSeconds, then the T1 builds. Otherwise the group's T1 constructor
// (FrontConstructors COMMANDER seat). The builder must be within PorcClusterReach of the site. One job at a time;
// the builder is unpublished from native group work while on it (CommanderGroup::Update / PublishUnit), is kept
// first in AiMakeTask, and gets its old task back after.
// Every unit / task handle is checked for null (and IsDead) before use. Log [FRONT][PorcCluster].
// Cost: one owned-unit scan, plus the battle snapshot contacts + ghosts filtered to static ground guns, every
// PorcClusterScanSeconds while on; clustering O(T^2) over our own T1.5 turrets; site search (~90 points x nearby
// enemy guns) only when a job starts.
namespace FrontPorcClusterCounter {
    const int OrderTimeoutSeconds = 240;
    const int FrameDeadlineSeconds = 150;   // an order with no frame by then is aborted
    const int HoldSeconds = 120;
    const float EdgeGap = 96.0f;
    const float SiteStep = 50.0f;
    const float MinBack = 64.0f;            // clear of the turret's own footprint

    class Turret {
        AIFloat3 pos;
        string name;
        bool popup = false;    // a T2 pop-up (Pit Bull / Scorpion / Chimera)
        int weight = 1;        // points toward PorcClusterMinCount: heavy laser towers PorcClusterHeavyWeight
        int cluster = -1;
        int near = 0;          // points of the turrets within PorcClusterRadius (-1 once used as a seed)
    }
    class Cluster {
        string key;
        AIFloat3 forward;      // the turret nearest an enemy start
        AIFloat3 enemy;        // that enemy start
        array<int> members;    // indices into turrets
        bool covered = false;
        bool popup = false;    // holds a T2 pop-up: always a T2 gun (owner 2026-11-15)
        string names;
    }

    array<CCircuitDef@> turretDefs, heavyDefs, popupDefs, t1Defs, t2Defs;
    array<Turret@> turrets;
    array<Cluster@> clusters;
    array<AIFloat3> gunPos;    // known enemy static ground guns (scan)
    array<float> gunReach;
    array<AIFloat3> guns;      // our artillery (T1 + T2 lists), finished or framed (scan)
    int standing = 0;          // clusters already covered
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
        turretDefs.resize(0); heavyDefs.resize(0); popupDefs.resize(0); t1Defs.resize(0); t2Defs.resize(0);
        turrets.resize(0); clusters.resize(0); gunPos.resize(0); gunReach.resize(0); guns.resize(0);
        standing = 0; lastScan = -100000; defsDone = false;
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
        AddDefs(Global::RoleSettings::Front::PorcClusterTurrets, turretDefs);
        AddDefs(Global::RoleSettings::Front::PorcClusterHeavyTurrets, heavyDefs);
        AddDefs(Global::RoleSettings::Front::PorcClusterPopups, popupDefs);
        AddDefs(Global::RoleSettings::Front::PorcClusterT1Guns, t1Defs);
        AddDefs(Global::RoleSettings::Front::PorcClusterT2Guns, t2Defs);
    }
    bool In(const array<CCircuitDef@>@ l, const CCircuitDef@ d) {
        if (d is null) return false;
        for (uint i = 0; i < l.length(); ++i) if (l[i] is d) return true;
        return false;
    }
    string Key(const AIFloat3 &in p) { return "" + int(p.x / 32.0f) + "_" + int(p.z / 32.0f); }
    string At(const AIFloat3 &in p) { return "(" + int(p.x) + "," + int(p.z) + ")"; }
    float Dist(const AIFloat3 &in a, const AIFloat3 &in b) { return sqrt(MapHelpers::SqDist(a, b)); }

    void Log(const string &in s) { GenericHelpers::LogUtil("[FRONT][PorcCluster] " + s, 1); }

    void AddGun(const AIFloat3 &in p, int defId) {
        CCircuitDef@ d = ai.GetCircuitDef(defId);
        if (d is null || d.IsMobile() || d.IsAbleToFly() || !d.HasSurfToLand()) return;
        // native's list (CEconomyManager::RefreshMexPorc): land range, guns over porc_max_range 1800 left out
        const float r = d.GetMaxRange();
        if (r <= 0.0f || r > 1800.0f) return;
        for (uint i = 0; i < gunPos.length(); ++i) if (MapHelpers::SqDist(gunPos[i], p) <= 48.0f * 48.0f) return;   // seen + ghost
        gunPos.insertLast(p); gunReach.insertLast(r);
    }
    // elmos outside the nearest of the `near` enemy guns' reach (< 0 inside)
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
        turrets.resize(0); clusters.resize(0); gunPos.resize(0); gunReach.resize(0); guns.resize(0); standing = 0;
        int points = 0;
        array<AIFloat3> enemies = Lanes::EnemyStarts();
        if (enemies.length() == 0) return;
        array<Id>@ ids = ai.GetOwnedUnitIds();
        if (ids is null) return;
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef is null) continue;
            const CCircuitDef@ d = u.circuitDef;
            if (In(t1Defs, d) || In(t2Defs, d)) { guns.insertLast(u.GetPos(ai.frame)); continue; }
            if (u.GetBuildProgress() < 1.0f) continue;
            const bool pop = In(popupDefs, d);
            if (!pop && !In(turretDefs, d)) continue;
            Turret@ t = Turret();
            t.pos = u.GetPos(ai.frame); t.name = d.GetName(); t.popup = pop;
            if (!pop && In(heavyDefs, d)) t.weight = Global::RoleSettings::Front::PorcClusterHeavyWeight;
            turrets.insertLast(t);
            points += t.weight;
        }
        const int need = Global::RoleSettings::Front::PorcClusterMinCount;
        if (points < need) return;
        const float r = Global::RoleSettings::Front::PorcClusterRadius;
        const float r2 = r * r;
        for (uint i = 0; i < turrets.length(); ++i)
            for (uint j = i + 1; j < turrets.length(); ++j)
                if (MapHelpers::SqDist(turrets[i].pos, turrets[j].pos) <= r2) { turrets[i].near += turrets[j].weight; turrets[j].near += turrets[i].weight; }
        const float cover = Global::RoleSettings::Front::PorcClusterCoverRadius;
        for (;;) {
            int seed = -1;
            for (uint i = 0; i < turrets.length(); ++i) {
                if (turrets[i].cluster >= 0 || turrets[i].near < 0 || turrets[i].near + turrets[i].weight < need) continue;
                if (seed < 0 || turrets[i].near > turrets[seed].near) seed = int(i);
            }
            if (seed < 0) break;
            Cluster@ c = Cluster();
            c.members.insertLast(seed);
            for (uint j = 0; j < turrets.length(); ++j)
                if (int(j) != seed && turrets[j].cluster < 0 && MapHelpers::SqDist(turrets[seed].pos, turrets[j].pos) <= r2)
                    c.members.insertLast(int(j));
            turrets[seed].near = -1;   // consumed as a seed
            int got = 0;
            for (uint k = 0; k < c.members.length(); ++k) got += turrets[c.members[k]].weight;
            if (got < need) continue;   // its neighbours already went to an earlier cluster
            // owner 2026-11-15: pop-ups count only in range of one of the T1.5 turrets: a cluster needs one
            int t15 = 0;
            for (uint k = 0; k < c.members.length(); ++k) if (!turrets[c.members[k]].popup) ++t15;
            if (t15 == 0) continue;
            // the forward turret: nearest an enemy start
            float best = 1e30f;
            for (uint k = 0; k < c.members.length(); ++k) {
                Turret@ t = turrets[c.members[k]];
                t.cluster = int(clusters.length());
                if (t.popup) c.popup = true;
                c.names += ((k == 0) ? "" : " ") + t.name;
                for (uint e = 0; e < enemies.length(); ++e) {
                    const float sq = MapHelpers::SqDist(t.pos, enemies[e]);
                    if (sq < best) { best = sq; c.forward = t.pos; c.enemy = enemies[e]; }
                }
            }
            c.key = Key(c.forward);
            for (uint g = 0; g < guns.length() && !c.covered; ++g)
                c.covered = MapHelpers::SqDist(guns[g], c.forward) <= cover * cover;
            if (c.covered) ++standing;
            clusters.insertLast(c);
        }
        if (clusters.length() == 0) return;
        // known enemy static ground guns (site safety)
        const int nc = aiBattle.GetGroundContactCount();
        for (int i = 0; i < nc; ++i) AddGun(aiBattle.GetGroundContactPos(i), aiBattle.GetGroundContactDefId(i));
        const int ng = aiBattle.GetGhostCount();
        for (int i = 0; i < ng; ++i) AddGun(aiBattle.GetGhostPos(i), aiBattle.GetGhostDefId(i));
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
        if (SiloAntiNukes::Owns(u)) return false;   // owner 2026-11-15: an antinuke builder
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

    // The best site in the half disc behind the cluster's forward turret (away from its enemy start) for `d` built
    // by `u`; x < 0 when none. `clearOut`: elmos outside the nearest known enemy gun's reach.
    AIFloat3 Site(CCircuitDef@ d, CCircuitUnit@ u, Cluster@ c, float &out clearOut) {
        clearOut = 0.0f;
        AIFloat3 none(-1.0f, 0.0f, -1.0f);
        if (d is null || u is null || u.circuitDef is null || c is null) return none;
        const AIFloat3 anchor = c.forward;
        float bx = anchor.x - c.enemy.x, bz = anchor.z - c.enemy.z;
        const float len = sqrt(bx * bx + bz * bz);
        if (len < 1.0f) return none;
        bx /= len; bz /= len;
        const float sx = -bz, sz = bx;   // sideways
        const float back = Global::RoleSettings::Front::PorcClusterBack, side = Global::RoleSettings::Front::PorcClusterSide;
        const bool vehicle = Global::RoleSettings::Front::PorcClusterVehicleUnits.find(u.circuitDef.GetName()) >= 0;
        const float vmargin = Global::RoleSettings::Front::PorcClusterVehicleMargin;
        array<int> near;   // enemy guns that could reach the half disc
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
                const float clear = GunClear(p, near);
                if (vehicle && clear < vmargin) continue;
                // furthest out of enemy guns' reach first (capped: beyond it the nearest site wins); vehicles weigh
                // it more, since native's site search can move the build ~200 elmos (headless 11-14: a corcv
                // Agitator ordered at (5832,5967) was placed at (5872,5776), inside an enemy gun's reach, and dropped)
                const float cap = vehicle ? 600.0f : 200.0f;
                const float score = AiMin(clear, cap) * 10.0f - (along * along + across * across) * 0.001f;
                if (score <= bestScore) continue;
                if (!aiTerrainMgr.CanReachAt(u, p, u.circuitDef.GetBuildDistance())) continue;
                bestScore = score; best = p; clearOut = clear;
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
        Log("gun built at " + At(jobSite) + " behind cluster " + jobKey + " in " + ((ai.frame - orderFrame) / SECOND) + " s");
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

    // The nearest free T2 seat at the group that can build a T2 gun; `any` whether the group has such a seat at all
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

    void Start() {
        int open = 0;
        for (uint i = 0; i < clusters.length(); ++i) if (!clusters[i].covered) ++open;
        if (open == 0) return;
        if (standing >= Global::RoleSettings::Front::PorcClusterMax) return;
        const AIFloat3 centre = GroupCentre();
        if (centre.x < 0.0f) return;
        // the most forward clusters first (forward turret nearest its enemy start)
        array<int> byFwd;
        for (uint i = 0; i < clusters.length(); ++i) {
            if (clusters[i].covered) continue;
            uint at = 0;
            const float sq = MapHelpers::SqDist(clusters[i].forward, clusters[i].enemy);
            while (at < byFwd.length() && MapHelpers::SqDist(clusters[byFwd[at]].forward, clusters[byFwd[at]].enemy) <= sq) ++at;
            byFwd.insertAt(at, int(i));
        }
        const float mi = Economy::GetMinMetalIncomeLast10s();
        const bool t2Gate = mi > Global::RoleSettings::Front::PorcClusterT2MinMetalIncome;
        const float reach = Global::RoleSettings::Front::PorcClusterReach;
        for (uint k = 0; k < byFwd.length(); ++k) {
            Cluster@ c = clusters[byFwd[k]];
            if (c is null) continue;
            int until = -1;
            if (holds.get(c.key, until) && ai.frame < until) continue;
            // the builder: a T2 seat at the group (income gate), else the group's T1 constructor. A cluster holding a
            // T2 pop-up always gets a T2 gun (owner 2026-11-15): no income gate, no T1 fallback; it waits for a T2
            // seat to reach the group, and is skipped while the group has none
            CCircuitUnit@ b = null;
            bool t2 = false;
            if (c.popup) {
                bool anyT2 = false;
                @b = T2Seat(centre, anyT2);
                if (b is null) {
                    if (anyT2 && !waits.exists(c.key)) { waits.set(c.key, ai.frame); Log("cluster " + c.key + " has a T2 pop-up: waiting for a T2 seat to reach the group"); }
                    continue;
                }
                t2 = true; waits.delete(c.key);
            } else if (t2Gate) {
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
            if (MapHelpers::SqDist(b.GetPos(ai.frame), c.forward) > reach * reach) continue;
            CCircuitDef@ d = Pick(t2 ? t2Defs : t1Defs, b);
            if (d is null) continue;
            float clear = 0.0f;
            const AIFloat3 site = Site(d, b, c, clear);
            if (site.x < 0.0f) {
                holds.set(c.key, ai.frame + HoldSeconds * SECOND);
                Log("cluster " + c.key + " [" + c.names + "]: no " + d.GetName() + " site behind its forward turret "
                    + At(c.forward) + " for " + b.circuitDef.GetName() + "; held " + HoldSeconds + " s");
                continue;
            }
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
                + ", " + int(Dist(site, c.forward)) + " behind forward turret " + At(c.forward) + " of our cluster " + c.key
                + " of " + c.members.length() + " [" + c.names + "] (enemy start " + At(c.enemy) + ", "
                + int(Dist(c.forward, c.enemy)) + " away); clear of enemy guns " + ((clear > 1e8f) ? "none known" : ("" + int(clear)))
                + "; mi +" + int(mi) + "; " + standing + " covered, " + open + " open"
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
