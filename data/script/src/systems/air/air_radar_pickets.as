// Radar pickets (owner 2026-11-24): AIR builds and restocks one T2 radar plane
// (armawac Eagle, corawac Vulture, legwhisper Whisper) per FRONT lane, stationed
// RadarPicketBehind (700) elmos behind that lane's frontline, for vision and
// radar over radar blockers (jammers) near the front.
//
// Lanes: the fixed FRONT corridors the FRONT allies publish to the team
// (CoverageLanes "corridor|..." messages, one polyline per FRONT seat from its
// base toward the enemy; 6 in an 8v8). At most RadarPicketCount (6) lanes, one
// plane each.
//
// Frontline of a lane (refreshed one lane every RadarPicketScanSeconds):
//   held  = the furthest progress along the lane of an allied mex, builder
//           structure or geo (aiBattle ally assets) within RadarPicketLateral
//   enemy = the progress where known enemy ground units and structure images
//           (ghosts) within RadarPicketLateral of the lane first add up to
//           RadarPicketEnemyCost metal (lone scouts and raiders do not count)
//   front = min(held, enemy); either alone when the other is unknown; with
//           neither, RadarPicketDefaultShare of the lane.
// Post = the lane point RadarPicketBehind before the front (never before the
// lane's first RadarPicketMinProgress elmos); a known air threat at the post
// pushes it back RadarPicketThreatStep at a time, at most RadarPicketThreatBack.
//
// Losses (owner): after a lane's plane dies, that lane's next plane stands a
// further RadarPicketFallback (600) back for RadarPicketFallbackSeconds (5 min).
// If the lane's last two planes died within RadarPicketQuickSeconds (3 min) of
// each other, the lane is not restocked for RadarPicketSuspendSeconds (10 min;
// -1 = rest of the game); it then restocks at the further-back post.
//
// One AIR per ally team runs it (the lowest team id among the AIRs), so a team
// with two AIRs still has 6 planes. Planes are excluded from the scout sweep
// drafts and counts.
namespace AirRadarPickets {
    class Lane {
        int team = -1;                 // the FRONT seat whose corridor this is
        array<AIFloat3> points;        // ally end first
        array<float> along;            // cumulative length at each point
        float length = 0.0f;
        float front = -1.0f, held = -1.0f, enemy = -1.0f;
        int scanned = -1;
        int plane = -1;                // unit id, -1 none
        int lastDeath = -1, prevDeath = -1;
        int fallbackUntil = -1, suspendedUntil = -1;
        bool suspendedForever = false;
        AIFloat3 post(-1, 0, -1);
        int routed = -1;
        int losses = 0;
    }
    array<Lane@> lanes;
    dictionary byTeam;                 // corridor team id -> lane index
    dictionary owned;                  // plane id -> lane index
    CRouteTask@ group;
    int nextScan = 0, nextAssign = 0, scanCursor = 0, nextLog = 0, nextElect = 0;
    bool elected = false;

    bool Enabled() { return Global::RoleSettings::Air::RadarPicketEnabled; }
    bool Owns(int id) { return owned.exists("" + id); }
    int Count() { return int(owned.getSize()); }
    string Clock(int frame) { const int s = frame / SECOND; return "" + (s / 60) + ":" + (s % 60 < 10 ? "0" : "") + (s % 60); }

    // CoverageLanes::HandleMessage: a FRONT ally's corridor (no points: cleared)
    void Corridor(int team, const array<AIFloat3> &in points) {
        if (!Enabled()) return;
        int index = -1;
        if (byTeam.exists("" + team)) byTeam.get("" + team, index);
        if (points.length() < 2) {
            if (index >= 0) { lanes[index].points.resize(0); lanes[index].length = 0.0f; }
            return;
        }
        Lane@ lane;
        if (index < 0) {
            if (int(lanes.length()) >= AiMax(1, Global::RoleSettings::Air::RadarPicketCount)) return;
            @lane = Lane(); lane.team = team;
            byTeam.set("" + team, int(lanes.length())); lanes.insertLast(lane);
        } else @lane = lanes[index];
        // orient from our side: the end nearer our team's start centroid first
        AIFloat3 home = Global::Map::StartPos;
        array<AIFloat3> allies = Lanes::AllyStarts();
        if (allies.length() > 0) {
            home = AIFloat3(0, 0, 0);
            for (uint i = 0; i < allies.length(); ++i) { home.x += allies[i].x; home.z += allies[i].z; }
            home.x /= float(allies.length()); home.z /= float(allies.length());
        }
        lane.points = points;
        if (MapHelpers::SqDist(points[points.length() - 1], home) < MapHelpers::SqDist(points[0], home)) lane.points.reverse();
        lane.along.resize(lane.points.length());
        lane.along[0] = 0.0f;
        for (uint i = 1; i < lane.points.length(); ++i)
            lane.along[i] = lane.along[i - 1] + sqrt(MapHelpers::SqDist(lane.points[i - 1], lane.points[i]));
        lane.length = lane.along[lane.along.length() - 1];
        lane.scanned = -1;
        GenericHelpers::LogUtil("[AIR][Picket] lane team=" + team + " points=" + lane.points.length() + " length=" + int(lane.length), 1);
    }

    // progress along the lane and the lateral distance of p from it
    float Project(Lane@ lane, const AIFloat3 &in p, float &out lateral) {
        float bestSq = 1.0e30f, bestS = 0.0f;
        for (uint i = 1; i < lane.points.length(); ++i) {
            const AIFloat3 a = lane.points[i - 1], b = lane.points[i];
            const float dx = b.x - a.x, dz = b.z - a.z;
            const float len2 = dx * dx + dz * dz;
            float t = len2 > 1.0f ? ((p.x - a.x) * dx + (p.z - a.z) * dz) / len2 : 0.0f;
            t = AiMax(0.0f, AiMin(1.0f, t));
            const float qx = a.x + dx * t - p.x, qz = a.z + dz * t - p.z;
            const float sq = qx * qx + qz * qz;
            if (sq < bestSq) { bestSq = sq; bestS = lane.along[i - 1] + t * (lane.along[i] - lane.along[i - 1]); }
        }
        lateral = sqrt(bestSq);
        return bestS;
    }
    AIFloat3 PointAt(Lane@ lane, float s) {
        s = AiMax(0.0f, AiMin(lane.length, s));
        for (uint i = 1; i < lane.points.length(); ++i) {
            if (lane.along[i] < s && i + 1 < lane.points.length()) continue;
            const float seg = lane.along[i] - lane.along[i - 1];
            const float t = seg > 1.0f ? (s - lane.along[i - 1]) / seg : 0.0f;
            const AIFloat3 a = lane.points[i - 1], b = lane.points[i];
            return AIFloat3(a.x + (b.x - a.x) * t, 0, a.z + (b.z - a.z) * t);
        }
        return lane.points[0];
    }
    bool InBox(Lane@ lane, const AIFloat3 &in p, float pad) {
        // cheap reject before the per-segment projection
        float minX = 1.0e9f, maxX = -1.0e9f, minZ = 1.0e9f, maxZ = -1.0e9f;
        for (uint i = 0; i < lane.points.length(); ++i) {
            minX = AiMin(minX, lane.points[i].x); maxX = AiMax(maxX, lane.points[i].x);
            minZ = AiMin(minZ, lane.points[i].z); maxZ = AiMax(maxZ, lane.points[i].z);
        }
        return p.x >= minX - pad && p.x <= maxX + pad && p.z >= minZ - pad && p.z <= maxZ + pad;
    }
    void Scan(Lane@ lane) {
        lane.scanned = ai.frame;
        const float W = Global::RoleSettings::Air::RadarPicketLateral;
        float lateral = 0.0f;
        lane.held = -1.0f;
        const int na = aiBattle.GetAllyAssetCount();
        for (int i = 0; i < na; ++i) {
            const AIFloat3 p = aiBattle.GetAllyAssetPos(i);
            if (!InBox(lane, p, W)) continue;
            const float s = Project(lane, p, lateral);
            if (lateral <= W && s > lane.held) lane.held = s;
        }
        array<float> at, cost;
        const int nc = aiBattle.GetGroundContactCount();
        for (int i = 0; i < nc; ++i) {
            const AIFloat3 p = aiBattle.GetGroundContactPos(i);
            if (!InBox(lane, p, W)) continue;
            const float s = Project(lane, p, lateral);
            if (lateral > W) continue;
            at.insertLast(s); cost.insertLast(AiMax(1.0f, aiBattle.GetGroundContactCost(i)));
        }
        const int ng = aiBattle.GetGhostCount();
        for (int i = 0; i < ng; ++i) {
            const AIFloat3 p = aiBattle.GetGhostPos(i);
            if (!InBox(lane, p, W)) continue;
            const float s = Project(lane, p, lateral);
            if (lateral > W) continue;
            CCircuitDef@ d = ai.GetCircuitDef(aiBattle.GetGhostDefId(i));
            at.insertLast(s); cost.insertLast(d is null ? 50.0f : AiMax(1.0f, d.costM));
        }
        lane.enemy = -1.0f;
        // walk forward along the lane: the first progress where the enemy cost adds up
        const float need = Global::RoleSettings::Air::RadarPicketEnemyCost;
        array<bool> used(at.length(), false);
        float sum = 0.0f;
        for (uint n = 0; n < at.length(); ++n) {
            int best = -1;
            for (uint j = 0; j < at.length(); ++j) if (!used[j] && (best < 0 || at[j] < at[best])) best = int(j);
            if (best < 0) break;
            used[best] = true; sum += cost[best];
            if (sum >= need) { lane.enemy = at[best]; break; }
        }
        if (lane.held >= 0.0f && lane.enemy >= 0.0f) lane.front = AiMin(lane.held, lane.enemy);
        else if (lane.held >= 0.0f) lane.front = lane.held;
        else if (lane.enemy >= 0.0f) lane.front = lane.enemy;
        else lane.front = lane.length * Global::RoleSettings::Air::RadarPicketDefaultShare;
    }
    float Back(Lane@ lane) {
        float back = Global::RoleSettings::Air::RadarPicketBehind;
        if (lane.fallbackUntil >= 0 && ai.frame < lane.fallbackUntil) back += Global::RoleSettings::Air::RadarPicketFallback;
        return back;
    }
    AIFloat3 Post(Lane@ lane, float &out s) {
        const float minS = AiMin(lane.length, Global::RoleSettings::Air::RadarPicketMinProgress);
        s = AiMax(minS, lane.front - Back(lane));
        AIFloat3 p = AirScreen::Clamp(PointAt(lane, s));
        // known enemy air threat (AA) over the post: step back along the lane
        float extra = 0.0f;
        while (aiBattle.AirThreat(p) > Global::RoleSettings::Air::RadarSafeThreat
            && extra + Global::RoleSettings::Air::RadarPicketThreatStep <= Global::RoleSettings::Air::RadarPicketThreatBack
            && s > minS) {
            extra += Global::RoleSettings::Air::RadarPicketThreatStep;
            s = AiMax(minS, s - Global::RoleSettings::Air::RadarPicketThreatStep);
            p = AirScreen::Clamp(PointAt(lane, s));
        }
        return p;
    }
    bool Open(Lane@ lane) {
        if (lane.length < 1.0f) return false;
        if (lane.suspendedForever) return false;
        return lane.suspendedUntil < 0 || ai.frame >= lane.suspendedUntil;
    }
    int Needed() {
        int n = 0;
        for (uint i = 0; i < lanes.length(); ++i) if (lanes[i].plane < 0 && Open(lanes[i])) ++n;
        return n;
    }
    bool Elect() {
        if (ai.frame < nextElect) return elected;
        nextElect = ai.frame + 10 * SECOND;
        bool lowest = true;
        array<Team::Roster::Entry@>@ airs = Team::Roster::WithRole(AiRole::AIR);
        for (uint i = 0; i < airs.length(); ++i)
            if (airs[i] !is null && airs[i].teamId != ai.teamId && airs[i].teamId < ai.teamId) lowest = false;
        if (lowest != elected) GenericHelpers::LogUtil("[AIR][Picket] " + (lowest ? "running" : "left to AIR team with lower id"), 1);
        elected = lowest;
        return elected;
    }
    bool Active() { return Enabled() && AirEconomy::Active() && Elect(); }

    // AirProduction::MakeTask, T2 plant: order a plane while a lane lacks one
    IUnitTask@ Produce(CCircuitUnit@ plant) {
        if (!Active() || plant is null || !UnitHelpers::IsT2AircraftPlant(plant.circuitDef.GetName())
            || Lifecycle::IsRetiring(plant) || !AirRecon::Controlled(plant)) return null;
        const int needed = Needed();
        if (needed <= 0) return null;
        if (!Economy::IncomeWindowReady()
            || Economy::GetMinMetalIncomeLast10s() < Global::RoleSettings::Air::RadarPicketMetal
            || Economy::GetMinEnergyIncomeLast10s() < Global::RoleSettings::Air::RadarPicketEnergy) return null;
        const string side = UnitHelpers::GetSideForUnitName(plant.circuitDef.GetName());
        CCircuitDef@ def = ai.GetCircuitDef(AirRecon::Name(side));
        if (def is null || !plant.circuitDef.CanBuild(def)) return null;
        // orders without a frame, and finished radar planes nobody holds, cover the need
        int spare = aiFactoryMgr.GetPendingRecruitCount(def);
        array<Id>@ ids = ai.GetOwnedUnitIds();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef.GetName() != def.GetName() || Owns(u.id)) continue;
            if (u.GetBuildProgress() < 1.0f || Free(u)) ++spare;
        }
        if (spare >= needed) return null;
        AirRecon::Unlock(def);
        IUnitTask@ t = AirProduction::Recruit(plant, def.GetName(), AirProduction::Projected(def) + 1, "radar.picket", Task::Priority::HIGH);
        if (t !is null) GenericHelpers::LogUtil("[AIR][Picket] order def=" + def.GetName() + " plant=" + plant.id + " lanesNeeding=" + needed, 1);
        return t;
    }
    // under base ground contact (not an air emergency): every Nth plant order
    int underFireTurn = 0;
    IUnitTask@ ProduceUnderFire(CCircuitUnit@ plant) {
        if (!Active() || Needed() <= 0 || plant is null || !UnitHelpers::IsT2AircraftPlant(plant.circuitDef.GetName())) return null;
        if ((underFireTurn++ % AiMax(1, Global::RoleSettings::Air::RadarPicketUnderFireEvery)) != 0) return null;
        return Produce(plant);
    }
    bool Free(CCircuitUnit@ u) {
        if (u is null || u.GetBuildProgress() < 1.0f || !AirRecon::Controlled(u) || AirScoutSweep::Flying(u.id)) return false;
        IUnitTask@ task = u.task;
        return task is null || task.GetType() == int(Task::Type::IDLE);
    }
    void EnsureGroup() {
        if (group !is null && !group.IsDead()) return;
        @group = cast<CRouteTask>(aiMilitaryMgr.Enqueue(TaskF::Route()));
        if (group is null) return;
        array<AIFloat3> route = {Global::Map::StartPos};
        group.SetAirControl(true); group.SetPatrol(true); group.SetTraversal(true, 128.0f, false); group.SetRoute(route);
        for (uint i = 0; i < lanes.length(); ++i) lanes[i].routed = -1;
    }
    // Air_MilitaryAiMakeTask: a finished radar plane goes to the first open lane without one
    IUnitTask@ TaskFor(CCircuitUnit@ u) {
        if (!Active() || u is null || u.GetBuildProgress() < 1.0f || !AirRecon::Controlled(u)) return null;
        const string side = UnitHelpers::GetSideForUnitName(u.circuitDef.GetName());
        if (u.circuitDef.GetName() != AirRecon::Name(side)) return null;
        const string key = "" + u.id;
        EnsureGroup();
        if (group is null) return null;
        if (Owns(u.id)) return group;
        if (AirScoutSweep::Flying(u.id)) return null;
        int pick = -1; float best = 1.0e30f;
        const AIFloat3 here = u.GetPos(ai.frame);
        for (uint i = 0; i < lanes.length(); ++i) {
            Lane@ lane = lanes[i];
            if (lane.plane >= 0 || !Open(lane)) continue;
            if (lane.scanned < 0) Scan(lane);
            float s = 0.0f;
            const float d = MapHelpers::SqDist(here, Post(lane, s));
            if (d < best) { best = d; pick = int(i); }
        }
        if (pick < 0) return null;
        Lane@ lane = lanes[pick];
        lane.plane = u.id; lane.routed = -1;
        owned.set(key, pick);
        AirScoutSweep::Exclude(u);
        AirProduction::home.delete(key); AirScreen::Removed(u.id);
        u.SetIdleMode(0); u.SetFireState(0);
        GenericHelpers::LogUtil("[AIR][Picket] plane=" + u.id + " lane team=" + lane.team + " at " + Clock(ai.frame), 1);
        return group;
    }
    void Route(Lane@ lane, CCircuitUnit@ u, bool force) {
        float s = 0.0f;
        const AIFloat3 p = Post(lane, s);
        if (!force && lane.routed >= 0 && MapHelpers::SqDist(p, lane.post) < 200.0f * 200.0f) return;
        const float r = AiMax(96.0f, Global::RoleSettings::Air::RadarPicketPatrolRadius);
        // orbit across the lane so the plane's centre stays on the post
        AIFloat3 dir(1, 0, 0);
        const AIFloat3 ahead = PointAt(lane, s + 200.0f), behind = PointAt(lane, s - 200.0f);
        const float dx = ahead.x - behind.x, dz = ahead.z - behind.z, dl = sqrt(dx * dx + dz * dz);
        if (dl > 1.0f) dir = AIFloat3(dx / dl, 0, dz / dl);
        array<AIFloat3> route = {
            AirScreen::Clamp(AIFloat3(p.x - dir.z * r, 0, p.z + dir.x * r)),
            AirScreen::Clamp(AIFloat3(p.x - dir.x * r * 0.5f, 0, p.z - dir.z * r * 0.5f)),
            AirScreen::Clamp(AIFloat3(p.x + dir.z * r, 0, p.z - dir.x * r))};
        if (group.SetUnitRoute(u, route, 128.0f)) {
            lane.post = p; lane.routed = ai.frame;
            GenericHelpers::LogUtil("[AIR][Picket] post lane team=" + lane.team + " plane=" + u.id + " x=" + int(p.x) + " z=" + int(p.z)
                + " at=" + int(s) + "/" + int(lane.length) + " front=" + int(lane.front) + " held=" + int(lane.held) + " enemy=" + int(lane.enemy)
                + " back=" + int(Back(lane)), 1);
        }
    }
    // Air_MilitaryAiUnitRemoved
    void Removed(CCircuitUnit@ u) {
        if (u is null || !Owns(u.id)) return;
        const string key = "" + u.id;
        int index = -1; owned.get(key, index); owned.delete(key);
        if (index < 0 || index >= int(lanes.length())) return;
        Lane@ lane = lanes[index];
        if (lane.plane != u.id) return;
        lane.plane = -1; lane.routed = -1; ++lane.losses;
        lane.prevDeath = lane.lastDeath; lane.lastDeath = ai.frame;
        lane.fallbackUntil = ai.frame + Global::RoleSettings::Air::RadarPicketFallbackSeconds * SECOND;
        string gate = "fallback " + Global::RoleSettings::Air::RadarPicketFallbackSeconds + " s";
        if (lane.prevDeath >= 0 && lane.lastDeath - lane.prevDeath <= Global::RoleSettings::Air::RadarPicketQuickSeconds * SECOND) {
            if (Global::RoleSettings::Air::RadarPicketSuspendSeconds < 0) { lane.suspendedForever = true; gate = "lane closed"; }
            else {
                lane.suspendedUntil = ai.frame + Global::RoleSettings::Air::RadarPicketSuspendSeconds * SECOND;
                // the restock after the pause stands at the further-back post too
                lane.fallbackUntil = AiMax(lane.fallbackUntil, lane.suspendedUntil + Global::RoleSettings::Air::RadarPicketFallbackSeconds * SECOND);
                gate = "suspended until " + Clock(lane.suspendedUntil);
            }
        }
        const AIFloat3 at = u.GetPos(ai.frame);
        GenericHelpers::LogUtil("[AIR][Picket] lost plane=" + u.id + " lane team=" + lane.team + " losses=" + lane.losses + " at " + Clock(ai.frame)
            + " x=" + int(at.x) + " z=" + int(at.z) + " " + gate, 1);
    }
    void Tick() {
        if (!Active()) return;
        if (ai.frame >= nextScan && lanes.length() > 0) {
            nextScan = ai.frame + AiMax(1, Global::RoleSettings::Air::RadarPicketScanSeconds) * SECOND / int(lanes.length());
            scanCursor = (scanCursor + 1) % int(lanes.length());
            if (lanes[scanCursor].length >= 1.0f) Scan(lanes[scanCursor]);
        }
        if (ai.frame < nextAssign) return;
        nextAssign = ai.frame + 2 * SECOND;
        EnsureGroup();
        array<string>@ keys = owned.getKeys();
        for (uint i = 0; i < keys.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(parseInt(keys[i]));
            int index = -1; owned.get(keys[i], index);
            if (index < 0 || index >= int(lanes.length())) { owned.delete(keys[i]); continue; }
            Lane@ lane = lanes[index];
            if (u is null || !AirRecon::Controlled(u)) {
                owned.delete(keys[i]); if (lane.plane == parseInt(keys[i])) { lane.plane = -1; lane.routed = -1; }
                continue;
            }
            if (group is null) continue;
            if (u.task !is group) {
                // something else took it (retreat): get it back when it is free again
                if (u.task is null || u.task.GetType() == int(Task::Type::IDLE)) aiMilitaryMgr.TransferUnit(u, group);
                lane.routed = -1;
                continue;
            }
            if (lane.length < 1.0f) continue;
            Route(lane, u, lane.routed < 0);
        }
        if (ai.frame >= nextLog) {
            nextLog = ai.frame + 60 * SECOND;
            string s = "[AIR][Picket] status " + Clock(ai.frame) + " lanes=" + lanes.length() + " planes=" + Count();
            for (uint i = 0; i < lanes.length(); ++i)
                s += " | t" + lanes[i].team + (lanes[i].plane >= 0 ? " p" + lanes[i].plane : " -") + " f" + int(lanes[i].front)
                    + "/" + int(lanes[i].length) + " L" + lanes[i].losses + (Open(lanes[i]) ? "" : " SUSP");
            GenericHelpers::LogUtil(s, 1);
        }
    }
    void Reset() {
        if (group !is null && !group.IsDead()) group.Abort();
        @group = null; owned.deleteAll();
        for (uint i = 0; i < lanes.length(); ++i) { lanes[i].plane = -1; lanes[i].routed = -1; }
    }
}
