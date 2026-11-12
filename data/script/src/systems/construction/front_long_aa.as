// FRONT T2 long-range AA (owner, 2026-11-12; Front::LongAA*): Mercury / Screamer / Xyston.
//
// Before this FRONT built them only through native paths: the porcupine list (slot 18, first at
// the 21st defence of one cluster, so almost never) and the AFUS build chain (one per advanced
// fusion, Armada and Cortex only). Neither had an income gate, so a FRONT on 100-300 m/s often had none.
//
// When: the 10 s minimum metal income (Economy::GetMinMetalIncomeLast10s, i.e. income held for
// 10 s) is at least LongAAMetalIncome. Allowed count = 1 + (income - gate) / LongAAMetalStep,
// at most LongAALimit; counted over our own long-range AA of every faction (gifts too), finished
// or framed, plus the order in flight. One order at a time; an order that dies unbuilt holds the
// next for LongAARetrySeconds.
// Who: a T2 constructor that can build its faction's unit (the commander never).
// Where: the first of a fixed list of sites round the eco anchor behind our start (the anchor,
// the start, then LongAASideStep to either side of both across the start-centre line) that is at
// least LongAASpacing from every long-range AA of ours and reachable; the engine picks the exact
// spot near it. Log [FRONT][LongAA].
namespace FrontLongAA {
    IUnitTask@ pending = null;
    AIFloat3 pendingAt(-1.0f, 0.0f, -1.0f);
    int nextOrder = 0;
    int nextLog = -100000;
    const float LongAASideStep = 700.0f;

    void Reset()
    {
        @pending = null;
        pendingAt = AIFloat3(-1.0f, 0.0f, -1.0f);
        nextOrder = 0;
        nextLog = -100000;
    }

    bool IsLongAA(const string &in name)
    {
        return name == "armmercury" || name == "corscreamer" || name == "leglraa";
    }

    void Held(const string &in why)
    {
        if (ai.frame - nextLog < 60 * SECOND) return;
        nextLog = ai.frame;
        GenericHelpers::LogUtil("[FRONT][LongAA] held: " + why, 1);
    }

    // Our long-range AA positions (finished and framed), every faction.
    array<AIFloat3>@ Standing()
    {
        array<AIFloat3> r;
        array<Id>@ ids = ai.GetOwnedUnitIds();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef is null || !IsLongAA(u.circuitDef.GetName())) continue;
            r.insertLast(u.GetPos(ai.frame));
        }
        return r;
    }

    int Allowed(float income)
    {
        const float gate = Global::RoleSettings::Front::LongAAMetalIncome;
        if (income < gate) return 0;
        const float step = AiMax(1.0f, Global::RoleSettings::Front::LongAAMetalStep);
        return AiMin(Global::RoleSettings::Front::LongAALimit, 1 + int((income - gate) / step));
    }

    array<AIFloat3>@ Sites()
    {
        array<AIFloat3> r;
        const AIFloat3 start = Global::Map::StartPos;
        const AIFloat3 anchor = FrontEcoLadder::Anchor();
        const float w = float(aiTerrainMgr.GetTerrainWidth()), h = float(aiTerrainMgr.GetTerrainHeight());
        float dx = start.x - w * 0.5f, dz = start.z - h * 0.5f;
        const float len = sqrt(dx * dx + dz * dz);
        // across the start-centre line (any direction on a centre start)
        float sx = 1.0f, sz = 0.0f;
        if (len >= 1.0f) { sx = -dz / len; sz = dx / len; }
        r.insertLast(anchor);
        r.insertLast(start);
        const float s = LongAASideStep;
        r.insertLast(FrontEcoLadder::Clamped(anchor.x + sx * s, anchor.z + sz * s));
        r.insertLast(FrontEcoLadder::Clamped(anchor.x - sx * s, anchor.z - sz * s));
        r.insertLast(FrontEcoLadder::Clamped(start.x + sx * s, start.z + sz * s));
        r.insertLast(FrontEcoLadder::Clamped(start.x - sx * s, start.z - sz * s));
        return r;
    }

    void TaskRemoved(IUnitTask@ task, bool done)
    {
        if (pending is null || task !is pending) return;
        @pending = null;
        pendingAt = AIFloat3(-1.0f, 0.0f, -1.0f);
        if (!done) {
            nextOrder = AiMax(nextOrder, ai.frame + Global::RoleSettings::Front::LongAARetrySeconds * SECOND);
            GenericHelpers::LogUtil("[FRONT][LongAA] order ended unbuilt; next in "
                + Global::RoleSettings::Front::LongAARetrySeconds + " s", 1);
        }
    }

    IUnitTask@ Work(CCircuitUnit@ u)
    {
        if (u is null || u.circuitDef is null) return null;
        if (Global::AISettings::Role != AiRole::FRONT || !Global::RoleSettings::Front::LongAA) return null;
        if (UnitHelpers::IsCommander(u.circuitDef) || !u.circuitDef.IsMobile()) return null;
        if (pending !is null && !pending.IsDead()) return null;   // one at a time
        @pending = null;
        if (ai.frame < nextOrder || !Economy::IncomeWindowReady()) return null;
        const float income = Economy::GetMinMetalIncomeLast10s();
        const int allowed = Allowed(income);
        if (allowed <= 0) return null;
        const string side = UnitHelpers::GetSideForUnitName(u.circuitDef.GetName());
        CCircuitDef@ d = ai.GetCircuitDef(UnitHelpers::GetStaticT2AARangeNameForSide(side));
        if (d is null || !u.circuitDef.CanBuild(d)) return null;   // T1 constructors cannot
        array<AIFloat3>@ have = Standing();
        if (int(have.length()) >= allowed) return null;
        if (!d.IsAvailable(ai.frame)) { Held(d.GetName() + " not available"); return null; }
        if (d.maxThisUnit >= 0 && d.maxThisUnit <= d.count) d.maxThisUnit = d.count + 1;
        array<AIFloat3>@ sites = Sites();
        const float spacing = Global::RoleSettings::Front::LongAASpacing;
        const float range = u.circuitDef.GetBuildDistance();
        AIFloat3 at(-1.0f, 0.0f, -1.0f);
        float bestNear = -1.0f;   // when every site is crowded, the one farthest from our nearest
        AIFloat3 fallback(-1.0f, 0.0f, -1.0f);
        for (uint s = 0; s < sites.length(); ++s) {
            float nearest = 1e30f;
            for (uint k = 0; k < have.length(); ++k) nearest = AiMin(nearest, MapHelpers::SqDist(have[k], sites[s]));
            if (!aiTerrainMgr.CanReachAt(u, sites[s], range + 256.0f)) continue;
            if (nearest >= spacing * spacing) { at = sites[s]; break; }
            if (nearest > bestNear) { bestNear = nearest; fallback = sites[s]; }
        }
        if (at.x < 0.0f) at = fallback;
        if (at.x < 0.0f) { Held("no reachable site for " + d.GetName()); nextOrder = ai.frame + 10 * SECOND; return null; }
        IUnitTask@ t = aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::DEFENCE, Task::Priority::HIGH, d, at,
            SQUARE_SIZE * 32, true, Global::RoleSettings::Front::LongAAOrderTimeoutSeconds * SECOND));
        if (t is null) { nextOrder = ai.frame + 10 * SECOND; return null; }
        @pending = t;
        pendingAt = at;
        nextOrder = ai.frame + 5 * SECOND;
        GenericHelpers::LogUtil("[FRONT][LongAA] " + d.GetName() + " " + (have.length() + 1) + " of " + allowed
            + " at (" + int(at.x) + ", " + int(at.z) + "); 10 s min metal +" + int(income)
            + " (gate " + int(Global::RoleSettings::Front::LongAAMetalIncome) + ")", 1);
        return t;
    }
}
