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
// Dedicated seat (owner 2026-11-23, Front::PorcClusterSeat, default 1 = the group's second T2 seat): once it stands,
// it is the only T2 seat this rule uses. Each scan it first reclaims a flagged T1 gun whose T2 gun stands (the seat
// itself, unpublished while on it; nanos and native builders may help), then builds a T2 upgrade gun behind a
// flagged cluster, and only then a T2 gun for a new cluster. Between jobs it guards the commander. CommanderGroup
// recruits it as soon as WantsSeat() (T2 gate passes, work pending) with seat 0 standing. Without it the old seats
// 0..2 do the T2 work and the reclaim is queued for native builders; upgrades still come before new clusters.
// A built T1 gun is flagged by the build task's own target id (fallback: ours within PorcClusterFlagRadius of the
// site); flagged guns are left out of front_agitator.as's 3-gun reclaim (IsClusterGun).
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
    const float FlagRadius = 128.0f;        // a built T1 job's gun: ours this near its site (native shake + footprint)
    const int FlagSiteSeconds = 60;         // ... looked for this long
    const int ReclaimSeconds = 180;         // reclaim order timeout
    const int ReclaimTries = 5;             // a flagged gun still standing after this many reclaim orders is unflagged
    const int ReclaimRetrySeconds = 20;     // a reclaim that ended with the gun standing is queued again after this
    const int GuardLogSeconds = 60;

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
        bool coveredT2 = false;   // a T2 gun of ours (finished or framed) within PorcClusterCoverRadius
        bool t2Stands = false;    // ... and one of them finished
        int oldGun = -1;          // a finished flagged T1 gun (this rule's) within PorcClusterCoverRadius
    }
    class Gun {
        AIFloat3 pos;
        int id = -1;
        bool t2 = false;
        bool done = false;     // finished
    }

    array<CCircuitDef@> turretDefs, heavyDefs, popupDefs, t1Defs, t2Defs;
    array<Turret@> turrets;
    array<Cluster@> clusters;
    array<AIFloat3> gunPos;    // known enemy static ground guns (scan)
    array<float> gunReach;
    array<Gun@> guns;          // our artillery (T1 + T2 lists), finished or framed (scan)
    int standing = 0;          // clusters already covered
    int lastScan = -100000;
    bool defsDone = false;
    dictionary holds;          // cluster key -> frame the hold ends
    dictionary waits;          // cluster key -> frame the T2 wait began
    // owner 2026-11-18: a T1 gun this rule built is flagged; once the T2 gate passes and a T2 seat is at the
    // group, the faction's T2 gun goes behind that cluster, and once it stands the flagged gun is reclaimed
    dictionary flagged;        // T1 gun unit id -> reclaim attempts so far
    array<AIFloat3> flagSites; // T1 jobs built: the next scan flags our T1 gun nearest each
    array<int> flagSiteUntil;

    // the job
    int stage = 0;             // 0 none, 1 order open, 4 ended (hand back)
    int jobUnit = -1;
    bool jobT2 = false;
    int jobKind = 0;           // 0 gun for an open cluster, 1 T2 upgrade gun
    int jobOld = -1;           // kind 1: the flagged T1 gun; kind 2 (seat reclaim): the gun being reclaimed
    int jobTarget = -1;        // the build order's frame (unit id), seen while the order is open
    IUnitTask@ guard;          // the dedicated seat's guard between jobs
    int guardLog = -100000;
    // the reclaim of a flagged T1 gun whose T2 gun stands: queued for native builders and nanos, like the stuck-T3
    // reclaims (t3_unstick.as); no seat is put on it (a reclaim order dies the moment its only builder is pulled off)
    IUnitTask@ rcTask;
    int rcOld = -1;
    string rcKey = "";
    int rcFrame = 0;
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
        flagged.deleteAll(); flagSites.resize(0); flagSiteUntil.resize(0);
        @rcTask = null; rcOld = -1; rcKey = "";
        stage = 0; jobUnit = -1; jobT2 = false; jobKind = 0; jobOld = -1; jobTarget = -1; @order = null; @prevTask = null; jobKey = "";
        @guard = null; guardLog = -100000;
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

    // Scan, after the owned-unit pass: our T1 gun nearest each built T1 job's site (within FlagRadius) is flagged
    // for a later T2 upgrade; flags of guns no longer ours are dropped
    void FlagGuns() {
        for (int i = int(flagSites.length()) - 1; i >= 0; --i) {
            int best = -1;
            const float fr = AiMax(FlagRadius, Global::RoleSettings::Front::PorcClusterFlagRadius);
            float bestSq = fr * fr;
            for (uint g = 0; g < guns.length(); ++g) {
                if (guns[g] is null || guns[g].t2 || !guns[g].done) continue;
                const float sq = MapHelpers::SqDist(guns[g].pos, flagSites[i]);
                if (sq <= bestSq) { bestSq = sq; best = guns[g].id; }
            }
            if (best >= 0 && !flagged.exists("" + best)) {
                flagged.set("" + best, 0);
                Log("T1 gun " + best + " at " + At(flagSites[i]) + " flagged for a T2 upgrade");
            }
            if (best >= 0 || ai.frame > flagSiteUntil[i]) { flagSites.removeAt(i); flagSiteUntil.removeAt(i); }
        }
        array<string>@ keys = flagged.getKeys();
        for (uint k = 0; k < keys.length(); ++k) {
            CCircuitUnit@ u = ai.GetTeamUnit(int(parseInt(keys[k])));
            if (u is null || !ai.IsOwnedUnit(u)) flagged.delete(keys[k]);
        }
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
            if (In(t1Defs, d) || In(t2Defs, d)) {
                Gun@ g = Gun();
                g.pos = u.GetPos(ai.frame); g.id = u.id; g.t2 = In(t2Defs, d); g.done = u.GetBuildProgress() >= 1.0f;
                guns.insertLast(g);
                continue;
            }
            if (u.GetBuildProgress() < 1.0f) continue;
            const bool pop = In(popupDefs, d);
            if (!pop && !In(turretDefs, d)) continue;
            Turret@ t = Turret();
            t.pos = u.GetPos(ai.frame); t.name = d.GetName(); t.popup = pop;
            if (!pop && In(heavyDefs, d)) t.weight = Global::RoleSettings::Front::PorcClusterHeavyWeight;
            turrets.insertLast(t);
            points += t.weight;
        }
        FlagGuns();
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
            for (uint g = 0; g < guns.length(); ++g) {
                Gun@ gun = guns[g];
                if (gun is null || MapHelpers::SqDist(gun.pos, c.forward) > cover * cover) continue;
                c.covered = true;
                if (gun.t2) { c.coveredT2 = true; if (gun.done) c.t2Stands = true; }
                else if (gun.done && c.oldGun < 0 && flagged.exists("" + gun.id)) c.oldGun = gun.id;
            }
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
        stage = 0; jobUnit = -1; jobTarget = -1; @order = null; @prevTask = null;
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
    // The reclaim order ended (TaskRemoved) or vanished (Update): the gun gone = done; still standing = tried again
    // after ReclaimRetrySeconds, at most ReclaimTries times
    void ReclaimEnded(const string &in how) {
        const int id = rcOld;
        const string key = rcKey;
        const int took = (ai.frame - rcFrame) / SECOND;
        @rcTask = null; rcOld = -1; rcKey = "";
        if (id < 0) return;
        CCircuitUnit@ old = ai.GetTeamUnit(id);
        const string k = "" + id;
        if (old is null || !ai.IsOwnedUnit(old)) {
            flagged.delete(k);
            Log("flagged T1 gun " + id + " reclaimed behind cluster " + key + " in " + took + " s");
            lastScan = -100000;
            return;
        }
        int64 tries = 0;
        flagged.get(k, tries);
        ++tries;
        if (tries >= ReclaimTries) { flagged.delete(k); Log("flagged T1 gun " + id + " still stands after " + tries + " reclaim orders: unflagged"); return; }
        flagged.set(k, tries);
        holds.set(key, ai.frame + ReclaimRetrySeconds * SECOND);
        Log("reclaim of flagged T1 gun " + id + " " + how + " after " + took + " s with the gun standing; again in " + ReclaimRetrySeconds + " s (try " + (tries + 1) + " of " + ReclaimTries + ")");
    }

    void TaskRemoved(IUnitTask@ task, bool done) {
        if (task is null) return;
        if (guard !is null && guard is task) { @guard = null; return; }
        if (rcTask !is null && rcTask is task) {
            ReclaimEnded(done ? "done" : "dropped");
            // the dedicated seat's own reclaim: the job ends with it (ReclaimEnded set any retry hold)
            if (stage == 1 && jobKind == 2 && order is task) { @order = null; Finish("reclaim ended"); }
            return;
        }
        if (stage == 0 || !(order is task)) return;
        // the frame this order built: its own target, else the id seen while it was open
        IBuilderTask@ bt = cast<IBuilderTask>(task);
        if (bt !is null && bt.target !is null) jobTarget = bt.target.id;
        @order = null;
        if (!done) {
            holds.set(jobKey, ai.frame + HoldSeconds * SECOND);
            Finish("order died without a gun; cluster held " + HoldSeconds + " s");
            return;
        }
        Log((jobKind == 1 ? "T2 upgrade gun" : "gun") + " built at " + At(jobSite) + " behind cluster " + jobKey + " in " + ((ai.frame - orderFrame) / SECOND) + " s"
            + (jobKind == 1 ? "; flagged T1 gun " + jobOld + " is reclaimed once it stands" : ""));
        // owner 2026-11-18: a T1 gun of this rule is flagged for a later T2 upgrade
        // owner 2026-11-23: by the frame's id (Live 11-23: guns placed 185-230 from the ordered site were never
        // found within 128 of it); the site search stays as the fallback when no id was seen
        if (jobKind == 0 && !jobT2 && Global::RoleSettings::Front::PorcClusterUpgrade) {
            CCircuitUnit@ built = jobTarget >= 0 ? ai.GetTeamUnit(jobTarget) : null;
            if (built !is null && built.circuitDef !is null && In(t1Defs, built.circuitDef) && ai.IsOwnedUnit(built)) {
                if (!flagged.exists("" + built.id)) {
                    flagged.set("" + built.id, 0);
                    Log("T1 gun " + built.id + " at " + At(built.GetPos(ai.frame)) + " flagged for a T2 upgrade (by id)");
                }
            } else {
                flagSites.insertLast(jobSite); flagSiteUntil.insertLast(ai.frame + FlagSiteSeconds * SECOND);
            }
        }
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
        if (rcTask !is null && rcTask.IsDead()) ReclaimEnded("ended");
        else if (rcTask is null && rcOld >= 0) ReclaimEnded("lost");
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
            if (!OrderLive()) {
                if (jobKind == 2) { @order = null; Finish("reclaim order gone"); return; }   // ReclaimEnded holds the retry
                Abort("order lost");
                return;
            }
            IBuilderTask@ b = cast<IBuilderTask>(order);
            if (b !is null && b.target !is null && jobKind != 2) jobTarget = b.target.id;
            if (b !is null && b.target is null && jobKind != 2 && ai.frame - orderFrame >= FrameDeadlineSeconds * SECOND) {
                Abort("no frame after " + FrameDeadlineSeconds + " s");
                return;
            }
            if (!(u.task is order) && !Busy(u)) aiBuilderMgr.AssignTask(u, order);   // native took it: back on the job
            return;
        }
        if (FrontRecovery::Active()) return;
        if (ai.frame - lastScan < Global::RoleSettings::Front::PorcClusterScanSeconds * SECOND) return;
        Scan();
        // owner 2026-11-23: flagged guns first (reclaim, then upgrade), new clusters after. Live 11-23 (Moonshine
        // AI 10/14/15): with new clusters first, T2 seats at the group for 14-20 min never upgraded 5 flagged guns
        FollowUp();
        if (stage == 0) Start();
    }

    // The dedicated cluster seat (Front::PorcClusterSeat) when it stands; null when off or vacant
    CCircuitUnit@ DedicatedSeat() {
        const int s = Global::RoleSettings::Front::PorcClusterSeat;
        if (s < 0 || s >= 3 || uint(s) >= CommanderGroup::members.length()) return null;
        CCircuitUnit@ u = ai.GetTeamUnit(CommanderGroup::members[s]);
        if (u is null || u.circuitDef is null || Pick(t2Defs, u) is null) return null;
        return u;
    }
    bool IsDedicated(int id) {
        CCircuitUnit@ d = DedicatedSeat();
        return d !is null && id >= 0 && d.id == id;
    }
    // front_agitator.as: a flagged gun is this rule's (upgraded and reclaimed here), not one of its agitators
    bool IsClusterGun(int id) { return id >= 0 && flagged.exists("" + id); }
    // CommanderGroup::Update: recruit the dedicated seat early while the T2 gate passes and there is cluster work
    bool WantsSeat() {
        if (!On() || !Global::RoleSettings::Front::PorcClusterUpgrade || Global::RoleSettings::Front::PorcClusterSeat < 0) return false;
        if (Economy::GetMinMetalIncomeLast10s() <= Global::RoleSettings::Front::PorcClusterT2MinMetalIncome) return false;
        if (flagged.getSize() > 0) return true;
        for (uint i = 0; i < clusters.length(); ++i) if (clusters[i] !is null && !clusters[i].covered) return true;
        return false;
    }

    // The nearest free T2 seat at the group that can build a T2 gun; `any` whether the group has such a seat at all
    CCircuitUnit@ T2Seat(const AIFloat3 &in centre, bool &out any) {
        any = false;
        CCircuitUnit@ best = null;
        float bestSq = 1e30f;
        const float join = Global::RoleSettings::Front::PorcClusterT2JoinRadius;
        // owner 2026-11-23: once the dedicated seat stands, only it takes cluster T2 work
        CCircuitUnit@ ded = DedicatedSeat();
        for (uint s = 0; s < 3 && s < CommanderGroup::members.length(); ++s) {
            CCircuitUnit@ u = ai.GetTeamUnit(CommanderGroup::members[s]);
            if (ded !is null && !(u is ded)) continue;
            if (u is null || u.circuitDef is null || Pick(t2Defs, u) is null) continue;
            any = true;
            if (!Free(u)) continue;
            const float sq = MapHelpers::SqDist(u.GetPos(ai.frame), centre);
            if (sq > join * join || sq >= bestSq) continue;
            bestSq = sq; @best = u;
        }
        return best;
    }

    // Job bookkeeping shared by the follow-ups: the builder is unpublished from native group work and put on `o`
    void Launch(CCircuitUnit@ b, IUnitTask@ o, bool t2, int kind, int old, const string &in key, const AIFloat3 &in site) {
        if (b is null || o is null) return;
        @prevTask = (b.task !is null && !b.task.IsDead()) ? b.task : null;
        @order = o; stage = 1; jobUnit = b.id; jobT2 = t2; jobKind = kind; jobOld = old; jobKey = key; jobSite = site; orderFrame = ai.frame; jobTarget = -1;
        if (t2) {
            for (uint s = 0; s < 3 && s < CommanderGroup::members.length(); ++s)
                if (CommanderGroup::members[s] == b.id) aiBuilderMgr.SetCommanderCombatOption("commander_group_member" + s, -1.0f);
        } else aiBuilderMgr.SetCommanderCombatOption("commander_group_unit", -1.0f);
        CCircuitUnit@ again = ai.GetTeamUnit(jobUnit);
        if (again !is null && OrderLive() && !(again.task is order)) aiBuilderMgr.AssignTask(again, order);
    }

    // Owner 2026-11-18: clusters this rule gave a T1 gun (flagged) get the faction's T2 gun once the T2 gate passes
    // and a T2 seat is at the group (no wait, no T1 fallback); once that T2 gun stands, the flagged T1 gun is
    // reclaimed (queued for native builders and nanos). One job and one reclaim at a time, after open clusters.
    void FollowUp() {
        if (!Global::RoleSettings::Front::PorcClusterUpgrade) return;
        const AIFloat3 centre = GroupCentre();
        if (centre.x < 0.0f) return;
        const float mi = Economy::GetMinMetalIncomeLast10s();
        const bool t2Gate = mi > Global::RoleSettings::Front::PorcClusterT2MinMetalIncome;
        const float reach = Global::RoleSettings::Front::PorcClusterReach;
        for (uint i = 0; i < clusters.length(); ++i) {
            Cluster@ c = clusters[i];
            if (c is null || c.oldGun < 0) continue;
            int64 until = -1;   // dictionary ints read through int64 (pending-all 2215c25c1)
            if (holds.get(c.key, until) && int64(ai.frame) < until) continue;
            CCircuitUnit@ old = ai.GetTeamUnit(c.oldGun);
            if (old is null || old.circuitDef is null || !ai.IsOwnedUnit(old) || old.GetBuildProgress() < 1.0f) continue;
            const AIFloat3 op = old.GetPos(ai.frame);
            const int oid = old.id;
            if (c.t2Stands) {
                if (aiBuilderMgr.IsReclaimProtected(old.circuitDef)) {
                    flagged.delete("" + oid);
                    Log("flagged T1 gun " + oid + " " + old.circuitDef.GetName() + " is reclaim-protected: unflagged");
                    continue;
                }
                if (rcTask !is null || rcOld >= 0) continue;   // one reclaim at a time
                // owner 2026-11-23: the dedicated seat reclaims it itself (unpublished while on it, so native group
                // work cannot pull it off and kill the order); without that seat it is queued for native builders
                CCircuitUnit@ ded = DedicatedSeat();
                if (ded !is null) {
                    if (stage != 0 || !Free(ded) || MapHelpers::SqDist(ded.GetPos(ai.frame), op) > reach * reach) continue;
                    IUnitTask@ ro = aiBuilderMgr.Enqueue(TaskB::Reclaim(Task::Priority::HIGH, old, ReclaimSeconds * SECOND));
                    if (ro is null || ro.IsDead()) {
                        holds.set(c.key, ai.frame + HoldSeconds * SECOND);
                        Log("cluster " + c.key + ": seat reclaim of flagged T1 gun " + oid + " refused natively; held " + HoldSeconds + " s");
                        continue;
                    }
                    @rcTask = ro; rcOld = oid; rcKey = c.key; rcFrame = ai.frame;
                    Log("T2 " + ded.circuitDef.GetName() + " " + ded.id + " (cluster seat) reclaims flagged T1 gun " + old.circuitDef.GetName() + " " + oid
                        + " at " + At(op) + ": the T2 gun of cluster " + c.key + " [" + c.names + "] stands");
                    Launch(ded, ro, true, 2, oid, c.key, op);
                    return;
                }
                IUnitTask@ o = aiBuilderMgr.Enqueue(TaskB::Reclaim(Task::Priority::HIGH, old, ReclaimSeconds * SECOND));
                if (o is null || o.IsDead()) {
                    holds.set(c.key, ai.frame + HoldSeconds * SECOND);
                    Log("cluster " + c.key + ": reclaim of flagged T1 gun " + oid + " refused natively; held " + HoldSeconds + " s");
                    continue;
                }
                @rcTask = o; rcOld = oid; rcKey = c.key; rcFrame = ai.frame;
                Log("reclaim of flagged T1 gun " + old.circuitDef.GetName() + " " + oid + " at " + At(op) + " queued for our builders: the T2 gun of cluster "
                    + c.key + " [" + c.names + "] stands");
                continue;
            }
            if (c.coveredT2 || !t2Gate) continue;
            bool anyT2 = false;
            CCircuitUnit@ b = T2Seat(centre, anyT2);
            if (b is null || MapHelpers::SqDist(b.GetPos(ai.frame), c.forward) > reach * reach) continue;
            CCircuitDef@ d = Pick(t2Defs, b);
            if (d is null) continue;
            float clear = 0.0f;
            const AIFloat3 site = Site(d, b, c, clear);
            if (site.x < 0.0f) {
                holds.set(c.key, ai.frame + HoldSeconds * SECOND);
                Log("cluster " + c.key + ": no " + d.GetName() + " upgrade site behind " + At(c.forward) + "; held " + HoldSeconds + " s");
                continue;
            }
            if (d.maxThisUnit >= 0 && d.maxThisUnit <= d.count) d.maxThisUnit = d.count + 1;
            if (!d.IsAvailable(ai.frame)) return;
            IUnitTask@ o = aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::DEFENCE, Task::Priority::HIGH, d, site,
                Global::RoleSettings::Front::PorcClusterShake, true, OrderTimeoutSeconds * SECOND));
            if (o is null) { holds.set(c.key, ai.frame + HoldSeconds * SECOND); Log("cluster " + c.key + ": " + d.GetName() + " upgrade order refused"); continue; }
            Log("T2 " + b.circuitDef.GetName() + " " + b.id + " orders upgrade " + d.GetName() + " at " + At(site) + " for cluster " + c.key
                + " [" + c.names + "], replacing flagged T1 gun " + old.circuitDef.GetName() + " " + oid + " at " + At(op) + "; mi +" + int(mi));
            Launch(b, o, true, 1, oid, c.key, site);
            return;
        }
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
            int64 until = -1;   // dictionary ints read through int64 (memory: as-dictionary-int64)
            if (holds.get(c.key, until) && int64(ai.frame) < until) continue;
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
                    int64 since = -1;
                    if (!waits.get(c.key, since)) { since = ai.frame; waits.set(c.key, since); Log("cluster " + c.key + ": waiting up to " + Global::RoleSettings::Front::PorcClusterT2WaitSeconds + " s for a T2 seat to reach the group"); }
                    if (int64(ai.frame) - since < int64(Global::RoleSettings::Front::PorcClusterT2WaitSeconds * SECOND)) continue;
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
            @order = o; stage = 1; jobUnit = b.id; jobT2 = t2; jobKind = 0; jobOld = -1; jobKey = c.key; jobSite = site; orderFrame = ai.frame; jobTarget = -1;
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
        if (u is null) return null;
        if (stage != 0 && u.id == jobUnit) {
            if (stage == 4) {
                IUnitTask@ back = Return(false);
                if (back !is null || !IsDedicated(u.id)) return back;
            } else if (OrderLive()) return order;
            else return null;
        }
        return SeatGuard(u);
    }

    // owner 2026-11-23: between jobs the dedicated seat only assists: it guards the commander (else the group's T1
    // constructor), so it stays with the group and helps its builds and repairs. A guard is never a framed build, so
    // Free() lets the next cluster job take the seat at once. Null for every other unit (native group work as before).
    IUnitTask@ SeatGuard(CCircuitUnit@ u) {
        if (!On() || u is null || !IsDedicated(u.id) || Busy(u)) return null;
        if (guard !is null && !guard.IsDead()) return guard;
        @guard = null;
        CCircuitUnit@ t = ai.GetTeamUnit(aiBuilderMgr.FrontCommanderId());
        if (t is null) @t = ai.GetTeamUnit(FrontConstructors::seats[FrontConstructors::COMMANDER]);
        if (t is null || t is u) return null;
        @guard = GuardHelpers::AssignWorkerGuard(u, t, Task::Priority::NORMAL, true, Global::RoleSettings::Front::PorcClusterSeatGuardSeconds * SECOND);
        if (guard !is null && ai.frame - guardLog >= GuardLogSeconds * SECOND) {
            guardLog = ai.frame;
            Log("cluster seat " + u.circuitDef.GetName() + " " + u.id + " guards " + t.circuitDef.GetName() + " " + t.id + " between jobs");
        }
        return guard;
    }
}
