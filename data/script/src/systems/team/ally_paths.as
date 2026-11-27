// Ally factory paths (owner, 2026-11-27, Glitters live game: AI 14's FRONT wind and T1 converter
// blocks stood between AI 13's gantry and the front, and its T3 units had to squeeze through them).
//
// Every SMRTBARb (any role) tells its allies where the units of its T2 labs and gantries walk out:
// a straight exit lane in front of the factory (Front::AllyPathExitLength along its facing), then the
// coarse lane-class route (aiBattle.GetTerrainRoute, bots) toward the nearest enemy start, cut at
// Front::AllyPathRouteLength. The path is a polyline with a half width (T2 labs
// Front::AllyPathHalfWidth, gantries Front::AllyPathGantryHalfWidth). Our own factories' paths
// are kept too.
//
// Who reads it: FRONT eco blocks are never reserved over a path (front_eco_blocks.as), and once our
// first fusion stands FRONT reclaims the T1 eco standing on a path first (front_reclaim.as).
//
// Messages: allypath|add|<factory id>|<half width>|x:z;x:z;...   allypath|del|<factory id>
// Cost: one factory-list scan every Front::AllyPathScanSeconds; one coarse route per factory, once;
// OnPath is O(paths x points).
namespace Team {
namespace AllyPaths {
    const string Prefix = "allypath|";

    class Path {
        int team = -1;
        int id = -1;
        float halfWidth = 160.0f;
        array<AIFloat3> pts;
    }
    array<Path@> paths;          // ours and our allies'
    array<int> published;        // our factory ids already sent
    array<string> factoryNames;
    array<bool> factoryGantry;
    int lastScan = -100000;

    bool Enabled() { return Global::RoleSettings::Front::AllyPaths; }

    void Names()
    {
        if (factoryNames.length() > 0) return;
        array<string> t2 = UnitHelpers::GetAllT2BotLabs();
        array<string> veh = UnitHelpers::GetAllT2VehicleLabs();
        for (uint i = 0; i < veh.length(); ++i) t2.insertLast(veh[i]);
        for (uint i = 0; i < t2.length(); ++i) { factoryNames.insertLast(t2[i]); factoryGantry.insertLast(false); }
        array<string> g = UnitHelpers::GetAllLandGantries();
        for (uint i = 0; i < g.length(); ++i) { factoryNames.insertLast(g[i]); factoryGantry.insertLast(true); }
    }

    int Find(int team, int id)
    {
        for (uint i = 0; i < paths.length(); ++i) if (paths[i].team == team && paths[i].id == id) return int(i);
        return -1;
    }

    AIFloat3 Forward(int facing)
    {
        return facing == 1 ? AIFloat3(1.f, 0.f, 0.f) : facing == 2 ? AIFloat3(0.f, 0.f, -1.f)
            : facing == 3 ? AIFloat3(-1.f, 0.f, 0.f) : AIFloat3(0.f, 0.f, 1.f);
    }

    AIFloat3 NearestEnemyStart(const AIFloat3 &in p)
    {
        array<AIFloat3> starts = Lanes::EnemyStarts();
        AIFloat3 best(-1.0f, 0.0f, -1.0f);
        float bestSq = 1e30f;
        for (uint i = 0; i < starts.length(); ++i) {
            const float sq = MapHelpers::SqDist(p, starts[i]);
            if (sq < bestSq) { bestSq = sq; best = starts[i]; }
        }
        return best;
    }

    // The factory's exit lane, then its route toward the enemy, both cut to their lengths
    array<AIFloat3> Plan(CCircuitUnit@ f)
    {
        array<AIFloat3> pts;
        const AIFloat3 pos = f.GetPos(ai.frame);
        int facing = aiTerrainMgr.GetBuildingFacing(f);
        if (facing < 0 || facing > 3) facing = 0;
        const AIFloat3 exitEnd = pos + Forward(facing) * Global::RoleSettings::Front::AllyPathExitLength;
        pts.insertLast(pos);
        pts.insertLast(exitEnd);
        const AIFloat3 target = NearestEnemyStart(pos);
        if (target.x < 0.0f) return pts;
        array<AIFloat3>@ r = aiBattle.GetTerrainRoute(pos, target, Lanes::BOT, 1.0f, 6.0f, 0.0f, 0.0f);
        if (r is null || r.length() < 2) return pts;
        float run = 0.0f;
        const float maxRun = Global::RoleSettings::Front::AllyPathRouteLength;
        AIFloat3 last = pos;
        pts.insertLast(pos);   // the route starts again from the factory (a polyline may fold back)
        for (uint i = 1; i < r.length() && run < maxRun; ++i) {
            const float step = sqrt(MapHelpers::SqDist(last, r[i]));
            if (step < 200.0f && i + 1 < r.length()) continue;   // thin the route to ~200-elmo points
            run += step;
            pts.insertLast(r[i]);
            last = r[i];
        }
        return pts;
    }

    void Add(int team, int id, float halfWidth, const array<AIFloat3> &in pts)
    {
        int k = Find(team, id);
        Path@ p = null;
        if (k >= 0) @p = paths[k]; else { @p = Path(); paths.insertLast(p); }
        p.team = team; p.id = id; p.halfWidth = halfWidth; p.pts = pts;
    }

    void Remove(int team, int id)
    {
        const int k = Find(team, id);
        if (k >= 0) paths.removeAt(k);
    }

    // Every Front::AllyPathScanSeconds: publish our new T2 labs and gantries (framed or finished),
    // withdraw the ones that are gone.
    void Tick()
    {
        if (!Enabled() || ai.frame - lastScan < int(Global::RoleSettings::Front::AllyPathScanSeconds * SECOND)) return;
        lastScan = ai.frame;
        Names();
        array<int> alive;
        array<Id>@ ids = ai.GetOwnedUnitIds();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef is null) continue;
            const int k = factoryNames.find(u.circuitDef.GetName());
            if (k < 0) continue;
            alive.insertLast(u.id);
            if (published.find(u.id) >= 0) continue;
            published.insertLast(u.id);
            const float hw = factoryGantry[k] ? Global::RoleSettings::Front::AllyPathGantryHalfWidth
                                              : Global::RoleSettings::Front::AllyPathHalfWidth;
            array<AIFloat3> pts = Plan(u);
            Add(ai.teamId, u.id, hw, pts);
            string msg = Prefix + "add|" + u.id + "|" + int(hw) + "|";
            for (uint p = 0; p < pts.length(); ++p) msg += (p > 0 ? ";" : "") + int(pts[p].x) + ":" + int(pts[p].z);
            AiSendMessage(msg);
            GenericHelpers::LogUtil("[AllyPaths] " + u.circuitDef.GetName() + " " + u.id + " at (" + int(pts[0].x) + ","
                + int(pts[0].z) + "): path of " + pts.length() + " points, half width " + int(hw) + " sent to the allies", 1);
        }
        for (int i = int(published.length()) - 1; i >= 0; --i) {
            if (alive.find(published[i]) >= 0) continue;
            Remove(ai.teamId, published[i]);
            AiSendMessage(Prefix + "del|" + published[i]);
            published.removeAt(i);
        }
    }

    bool HandleMessage(const string &in message, int sender)
    {
        if (message.findFirst(Prefix) != 0) return false;
        if (sender == ai.teamId) return true;
        array<string>@ f = message.split("|");
        if (f.length() >= 3 && f[1] == "del") { Remove(sender, parseInt(f[2])); return true; }
        if (f.length() < 5 || f[1] != "add") return true;
        array<AIFloat3> pts;
        array<string>@ xs = f[4].split(";");
        for (uint i = 0; i < xs.length(); ++i) {
            array<string>@ xz = xs[i].split(":");
            if (xz.length() != 2) continue;
            pts.insertLast(AIFloat3(float(parseInt(xz[0])), 0.0f, float(parseInt(xz[1]))));
        }
        if (pts.length() < 2) return true;
        Add(sender, parseInt(f[2]), float(parseInt(f[3])), pts);
        GenericHelpers::LogUtil("[AllyPaths] team " + sender + " factory " + f[2] + " path of " + pts.length()
            + " points from (" + int(pts[0].x) + "," + int(pts[0].z) + ")", 2);
        return true;
    }

    float SqSegDist(const AIFloat3 &in p, const AIFloat3 &in a, const AIFloat3 &in b)
    {
        const float dx = b.x - a.x, dz = b.z - a.z;
        const float len = dx * dx + dz * dz;
        float t = len > 0.0f ? ((p.x - a.x) * dx + (p.z - a.z) * dz) / len : 0.0f;
        t = AiMax(0.0f, AiMin(1.0f, t));
        const float qx = a.x + dx * t - p.x, qz = a.z + dz * t - p.z;
        return qx * qx + qz * qz;
    }

    // True when p, padded by `pad` elmos, touches a factory path (ours or an ally's)
    bool OnPath(const AIFloat3 &in p, float pad, bool alliesOnly = false)
    {
        if (!Enabled()) return false;
        for (uint i = 0; i < paths.length(); ++i) {
            Path@ path = paths[i];
            if (alliesOnly && path.team == ai.teamId) continue;
            const float r = path.halfWidth + pad;
            for (uint s = 1; s < path.pts.length(); ++s)
                if (SqSegDist(p, path.pts[s - 1], path.pts[s]) <= r * r) return true;
        }
        return false;
    }
}  // namespace AllyPaths
}  // namespace Team
