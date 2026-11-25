#include "../../define.as"
#include "../../unit.as"
#include "../../task.as"
#include "../../global.as"
#include "../../settings/shared/mobile_antinuke.as"
#include "../../helpers/common/generic_helpers.as"
#include "../../helpers/spatial/map_helpers.as"
#include "../construction/silo_antinukes.as"
#include "../world/lanes.as"

// FRONT mobile antinukes (owner, 2026-11-24; Global::MobileAntiNuke).
//
// Owner: "After it detects the first human team nuke launch, it queues up an antinuke if it has the required
// structures (t2 bot lab for armada, t2 vehicle lab for cortex and legion). This special antinuke bot lingers
// on the frontline trying to keep the AI that built it under antinuke protection for its artillery. The
// artillery hang back to attack, and the antinuke bot or vehicle hangs even further back just barely keeping
// the artillery units (ambassador, negotiator, boreas) under its protective antinuke range. It does not move
// past its lane's furthest advanced porc (built by commander-group, and still alive). If the artillery wander
// so far forward out of the range of its lane's furthest advanced porc, it will linger back behind the furthest
// advanced porc structure instead." FRONTs without the lab ask the other FRONTs; the nearest with the lab builds
// one and trades it, and it walks to the receiver's lane. More than one enemy silo (launch frequency or
// scouting): one mobile antinuke per silo.
//
// Units: Armada Umbrella armscab (T2 bot lab, coverage 1400), Cortex Saviour cormabm (T2 vehicle lab, 1750),
// Legion Hera legavantinuke (T2 vehicle lab, 1575). Mobile STOCK units: the native finished handler already
// queues their stockpile (MilitaryManager attackerFinishedHandler); the interceptor fires by itself.
//
// Wanted (FRONT): 0 until the first enemy launch (SiloAntiNukes: a BAR launch warning, or an interception by
// any of our or an allied BARb's antinukes, these mobile ones included); then max(1, silos), silos = the
// higher of scouted and inferred from the launch frequency (SiloAntiNukes::Silos). One scouted silo (any faction, finished or a
// frame) starts it too. At most Max. Owned = every finished mobile antinuke of ours (built by us, traded to us, or
// a native factory-weight one), all driven here.
//
// Post (every UpdateSeconds per antinuke): our artillery (Ambassador / Negotiator / Boreas, finished) is split
// into groups (GroupGap); groups and antinukes are paired nearest first. For a group: from its centre, the post
// goes back toward our start as far as still keeps every member within CoverShare x coverage (tried from
// BackMax down). Lane limit: our porc (own finished ground-armed statics, range <= PorcMaxRange, no AA-only,
// supers or antinukes) within LaneRadius of the post; Forward(p) = how far p stands from our start toward the
// nearest enemy start (along that axis). The post never goes past (furthest porc Forward - BehindPorc); when it
// is pulled back and the group is out of its reach, it waits BehindPorc behind that furthest porc (at the
// porc's side position). No artillery: behind the furthest porc. No porc: NoPorcForward from our start.
// Orders: a hold-position route task (the stealth-scout pattern), re-sent when the post moves Retarget+ at most
// every RetargetSeconds.
//
// Production: FRONT's factory hook (Factory::AiMakeTask) orders one at a time in a finished lab that can build
// one, for our own shortfall first while we own none, else for an ally's request first. Trade: a FRONT with a
// shortfall and no such lab for AskAfterSeconds broadcasts barbmabm|req|<token>; every FRONT ally with the lab
// answers barbmabm|offer|<token>; after OfferSeconds the nearest start (to ours) gets barbmabm|accept|<token>,
// builds it and sends it with ai.GiveUnits + barbmabm|sent|<token>|<id>. No delivery in DeliverSeconds: cancel,
// skip that donor 3 x RetrySeconds, ask again. Log [MobileAntiNuke].
//
// Cost: Update every UpdateSeconds: one pass over our units (artillery, porc, antinukes), O(antinukes x groups)
// pairing and a few dozen point tests per antinuke; messages only per trade.
namespace MobileAntiNuke {
    const string MSG = "barbmabm";
    const array<string> Names = {"armscab", "cormabm", "legavantinuke"};
    const array<float> FallbackCoverage = {1400.0f, 1750.0f, 1575.0f};

    class Anti {
        int id = -1;
        CRouteTask@ task;
        AIFloat3 post;
        bool hasPost = false;
        int lastOrder = -100000;
        string mode;
    }
    array<Anti@> antis;
    int lastUpdate = -100000;
    int wantLogged = -1;
    bool started = false;

    // ---- production state
    IUnitTask@ order;
    int orderFactory = -1, orderDef = -1, orderFrame = -1, orderFor = -1;   // orderFor: -1 ours, else team
    int savedCap = -1, openedCap = -1;

    // ---- requester
    int reqState = 0;          // 0 idle, 1 collecting offers, 2 accepted
    int token = -1, askFrame = -1, acceptFrame = -1, donor = -1, nextAsk = 0, noLabSince = -1;
    array<int> offerTeam;
    dictionary avoidUntil;
    array<int> incoming;       // ids sent to us, not admitted yet ...
    array<int> incomingAt;     // ... and when each "sent" came
    // ---- donor
    class Owed { int team = -1, token = -1, since = -1, gift = -1; }
    array<Owed@> owed;

    bool IsFront() { return Global::AISettings::Role == AiRole::FRONT; }
    bool Active() { return Global::MobileAntiNuke::Enabled && IsFront(); }
    void Log(const string &in t) { GenericHelpers::LogUtil("[MobileAntiNuke] " + t, 1); }
    string XY(const AIFloat3 &in p) { return "(" + int(p.x) + "," + int(p.z) + ")"; }

    int NameIndex(const CCircuitDef@ d)
    {
        if (d is null) return -1;
        const string n = d.GetName();
        for (uint i = 0; i < Names.length(); ++i) if (Names[i] == n) return int(i);
        return -1;
    }
    bool IsMobileAnti(const CCircuitDef@ d) { return NameIndex(d) >= 0; }

    float Coverage(const CCircuitDef@ d)
    {
        const int k = NameIndex(d);
        float r = d is null ? 0.0f : aiBattle.InterceptorCoverage(d);
        if (r <= 0.0f && k >= 0) r = FallbackCoverage[k];
        return r;
    }

    bool InMap(const AIFloat3 &in p)
    {
        return p.x >= 64.0f && p.z >= 64.0f && p.x <= float(AiTerrainWidth()) - 64.0f && p.z <= float(AiTerrainHeight()) - 64.0f;
    }

    // ---------------- wanted ----------------
    int Wanted()
    {
        if (!Active()) return 0;
        const int silos = SiloAntiNukes::Silos();
        int n = 0;
        // owner 2026-11-25: a launch, an interception or one scouted silo (armsilo / corsilo / legsilo, finished or a frame) starts it
        if (SiloAntiNukes::LaunchesEver() > 0 || silos > 0) n = AiMax(1, silos);
        n = AiMin(Global::MobileAntiNuke::Max, n);
        if (n != wantLogged) {
            Log("wanted " + n + " (enemy launches seen " + SiloAntiNukes::LaunchesEver() + ", silos " + SiloAntiNukes::SiloNote() + "); own " + antis.length());
            wantLogged = n;
        }
        return n;
    }

    // ---------------- axis / porc / artillery ----------------
    AIFloat3 home, enemy;
    AIFloat3 axis(1.0f, 0.0f, 0.0f);
    array<AIFloat3> porcPos;
    array<float> porcFwd;
    array<AIFloat3> artyPos;

    float Forward(const AIFloat3 &in p) { return (p.x - home.x) * axis.x + (p.z - home.z) * axis.z; }

    void Axis()
    {
        home = Global::Map::StartPos;
        array<AIFloat3> es = Lanes::EnemyStarts();
        float best = 1e30f;
        enemy = home;
        for (uint i = 0; i < es.length(); ++i) {
            const float d = MapHelpers::SqDist(es[i], home);
            if (d < best) { best = d; enemy = es[i]; }
        }
        if (es.length() == 0) enemy = AIFloat3(float(AiTerrainWidth()) - home.x, 0.0f, float(AiTerrainHeight()) - home.z);
        float dx = enemy.x - home.x, dz = enemy.z - home.z;
        const float len = sqrt(dx * dx + dz * dz);
        if (len > 1.0f) axis = AIFloat3(dx / len, 0.0f, dz / len);
    }

    bool IsPorc(const CCircuitDef@ d)
    {
        if (d is null || d.IsMobile() || !d.HasSurfToLand()) return false;
        const float r = d.GetMaxRange();
        if (r <= 0.0f || r > Global::MobileAntiNuke::PorcMaxRange) return false;
        if (d.IsRoleAny(Unit::Role::SUPER.mask)) return false;
        return true;
    }

    bool IsArtillery(const CCircuitDef@ d)
    {
        if (d is null) return false;
        const string n = d.GetName();
        return Global::MobileAntiNuke::Artillery.find(n) >= 0;
    }

    void Scan()
    {
        porcPos.resize(0); porcFwd.resize(0); artyPos.resize(0);
        array<Id>@ ids = ai.GetOwnedUnitIds();
        if (ids is null) return;
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef is null || u.GetBuildProgress() < 1.0f) continue;
            if (IsArtillery(u.circuitDef)) { artyPos.insertLast(u.GetPos(ai.frame)); continue; }
            if (IsPorc(u.circuitDef)) {
                const AIFloat3 p = u.GetPos(ai.frame);
                porcPos.insertLast(p); porcFwd.insertLast(Forward(p));
            }
        }
    }

    // The furthest forward porc within LaneRadius of p (index), -1 none
    int LanePorc(const AIFloat3 &in p)
    {
        const float r = Global::MobileAntiNuke::LaneRadius;
        int best = -1;
        for (uint i = 0; i < porcPos.length(); ++i) {
            if (MapHelpers::SqDist(porcPos[i], p) > r * r) continue;
            if (best < 0 || porcFwd[i] > porcFwd[best]) best = int(i);
        }
        return best;
    }
    int FurthestPorc()
    {
        int best = -1;
        for (uint i = 0; i < porcPos.length(); ++i) if (best < 0 || porcFwd[i] > porcFwd[best]) best = int(i);
        return best;
    }

    AIFloat3 BehindPorcPoint(int k)
    {
        AIFloat3 p = porcPos[k] - axis * Global::MobileAntiNuke::BehindPorc;
        p.y = aiBattle.Height(p);
        return p;
    }

    AIFloat3 Fallback(int slot)
    {
        const int k = FurthestPorc();
        AIFloat3 side(-axis.z, 0.0f, axis.x);
        const float off = (slot % 2 == 0 ? 1.0f : -1.0f) * float((slot + 1) / 2) * 300.0f;
        AIFloat3 p = (k >= 0) ? BehindPorcPoint(k) : home + axis * Global::MobileAntiNuke::NoPorcForward;
        p = p + side * off;
        p.y = aiBattle.Height(p);
        return p;
    }

    // ---------------- groups ----------------
    array<array<AIFloat3>@> groups;
    void Group()
    {
        groups.resize(0);
        const float gap = Global::MobileAntiNuke::GroupGap;
        array<int> gi(artyPos.length(), -1);
        for (uint i = 0; i < artyPos.length(); ++i) {
            if (gi[i] >= 0) continue;
            const int g = int(groups.length());
            array<AIFloat3>@ members = array<AIFloat3>();
            gi[i] = g; members.insertLast(artyPos[i]);
            // flood fill (single link)
            for (uint m = 0; m < members.length(); ++m) {
                for (uint j = 0; j < artyPos.length(); ++j) {
                    if (gi[j] >= 0) continue;
                    if (MapHelpers::SqDist(artyPos[j], members[m]) <= gap * gap) { gi[j] = g; members.insertLast(artyPos[j]); }
                }
            }
            groups.insertLast(members);
        }
    }

    AIFloat3 Centre(array<AIFloat3>@ g)
    {
        AIFloat3 c(0.0f, 0.0f, 0.0f);
        for (uint i = 0; i < g.length(); ++i) { c.x += g[i].x; c.z += g[i].z; }
        c.x /= float(g.length()); c.z /= float(g.length());
        return c;
    }

    int Covered(array<AIFloat3>@ g, const AIFloat3 &in p, float r)
    {
        int n = 0;
        for (uint i = 0; i < g.length(); ++i) if (MapHelpers::SqDist(g[i], p) <= r * r) ++n;
        return n;
    }

    // A reachable point at or behind p (toward home)
    bool Reach(CCircuitUnit@ u, const AIFloat3 &in p, AIFloat3 &out r)
    {
        r = p;
        for (int s = 0; s < 8; ++s) {
            AIFloat3 q = p - axis * (float(s) * 64.0f);
            if (!InMap(q)) continue;
            q.y = aiBattle.Height(q);
            if (aiTerrainMgr.CanMoveTo(u, q)) { r = q; return true; }
        }
        return false;
    }

    // The post for antinuke u covering group g (null: no group)
    AIFloat3 PostFor(CCircuitUnit@ u, array<AIFloat3>@ g, int slot, string &out mode)
    {
        if (g is null || g.length() == 0) { mode = "no artillery: behind the furthest porc"; return Fallback(slot); }
        const float R = Coverage(u.circuitDef);
        const float keep = R * Global::MobileAntiNuke::CoverShare;
        const AIFloat3 c = Centre(g);
        AIFloat3 back = home - c; back.y = 0.0f;
        const float bl = sqrt(back.x * back.x + back.z * back.z);
        back = (bl > 1.0f) ? back * (1.0f / bl) : axis * -1.0f;
        AIFloat3 p = c;
        for (float s = Global::MobileAntiNuke::BackMax; s >= 0.0f; s -= Global::MobileAntiNuke::BackStep) {
            AIFloat3 q = c + back * (s * R);
            if (Covered(g, q, keep) == int(g.length())) { p = q; break; }
        }
        // lane limit
        const int k = LanePorc(p);
        if (k < 0) {
            if (porcPos.length() == 0) { mode = "covering " + g.length() + " artillery (no porc yet)"; p.y = aiBattle.Height(p); return p; }
            // artillery far from any porc of ours: behind the furthest porc
            mode = "artillery out of the lane: behind the furthest porc";
            return BehindPorcPoint(FurthestPorc());
        }
        const float limit = porcFwd[k] - Global::MobileAntiNuke::BehindPorc;
        const float f = Forward(p);
        if (f > limit) {
            p = p - axis * (f - limit);
            if (Covered(g, p, R) == 0) { mode = "artillery past porc reach: behind porc " + XY(porcPos[k]); return BehindPorcPoint(k); }
            mode = "covering " + Covered(g, p, R) + "/" + g.length() + " artillery, held at the porc line";
        } else mode = "covering " + Covered(g, p, R) + "/" + g.length() + " artillery";
        p.y = aiBattle.Height(p);
        return p;
    }

    // ---------------- control ----------------
    int FindAnti(int id) { for (uint i = 0; i < antis.length(); ++i) if (antis[i].id == id) return int(i); return -1; }

    CRouteTask@ NewRoute()
    {
        IUnitTask@ task = aiMilitaryMgr.Enqueue(TaskF::Route());
        CRouteTask@ route = cast<CRouteTask>(cast<IFighterTask>(task));
        if (route is null) return null;
        route.SetTraversal(true, 48.0f, false);
        route.SetHoldPosition(true);
        route.SetLanes(1, 0, 0);
        return route;
    }

    // Military::AiMakeTask: every mobile antinuke of a FRONT is ours
    IUnitTask@ MilitaryMakeTask(CCircuitUnit@ u)
    {
        if (!Active() || u is null || !IsMobileAnti(u.circuitDef)) return null;
        CRouteTask@ task = NewRoute();
        if (task is null) return null;
        const int at = FindAnti(u.id);
        Anti@ a = null;
        if (at >= 0) @a = antis[at]; else @a = Anti();
        a.id = u.id; @a.task = task; a.hasPost = false; a.lastOrder = -100000;
        array<AIFloat3> hold = {u.GetPos(ai.frame)};
        task.SetRoute(hold);
        if (at < 0) {
            antis.insertLast(a);
            const int inc = incoming.find(u.id);
            if (inc >= 0) { incoming.removeAt(uint(inc)); incomingAt.removeAt(uint(inc)); }
            Log("admit " + u.circuitDef.GetName() + " " + u.id + " at " + XY(u.GetPos(ai.frame)) + " coverage " + int(Coverage(u.circuitDef))
                + (inc >= 0 ? (u.GetProducerId() == orderFactory || ai.GetTeamUnit(u.GetProducerId()) !is null ? "" : " (traded to us)") : "") + "; own " + antis.length());
        }
        return task;
    }

    void Control()
    {
        for (int i = int(antis.length()) - 1; i >= 0; --i) {
            CCircuitUnit@ u = ai.GetTeamUnit(antis[i].id);
            if (u is null || !ai.IsOwnedUnit(u)) { Log("antinuke " + antis[i].id + " gone; own " + (antis.length() - 1)); antis.removeAt(uint(i)); }
        }
        if (antis.length() == 0) return;
        Axis();
        Scan();
        Group();
        // pair groups (largest first) with antinukes, nearest first
        array<bool> taken(antis.length(), false);
        array<int> groupOf(antis.length(), -1);
        array<int> order;
        for (uint g = 0; g < groups.length(); ++g) order.insertLast(int(g));
        for (uint a = 0; a < order.length(); ++a)
            for (uint b = a + 1; b < order.length(); ++b)
                if (groups[order[b]].length() > groups[order[a]].length()) { const int t = order[a]; order[a] = order[b]; order[b] = t; }
        for (uint o = 0; o < order.length(); ++o) {
            const AIFloat3 c = Centre(groups[order[o]]);
            int best = -1; float bd = 1e30f;
            for (uint i = 0; i < antis.length(); ++i) {
                if (taken[i]) continue;
                CCircuitUnit@ u = ai.GetTeamUnit(antis[i].id);
                if (u is null) continue;
                const float d = MapHelpers::SqDist(u.GetPos(ai.frame), c);
                if (d < bd) { bd = d; best = int(i); }
            }
            if (best < 0) break;
            taken[best] = true; groupOf[best] = order[o];
        }
        int spare = 0;
        for (uint i = 0; i < antis.length(); ++i) {
            Anti@ a = antis[i];
            CCircuitUnit@ u = ai.GetTeamUnit(a.id);
            if (u is null) continue;
            if (a.task is null || a.task.IsDead() || !(u.task is a.task)) continue;   // re-admitted by AiMakeTask when idle
            string mode;
            AIFloat3 p = (groupOf[i] >= 0) ? PostFor(u, groups[groupOf[i]], 0, mode) : PostFor(u, null, spare++, mode);
            AIFloat3 reached;
            if (!Reach(u, p, reached)) continue;
            p = reached;
            if (a.hasPost && MapHelpers::SqDist(p, a.post) < Global::MobileAntiNuke::Retarget * Global::MobileAntiNuke::Retarget) continue;
            if (ai.frame - a.lastOrder < Global::MobileAntiNuke::RetargetSeconds * SECOND) continue;
            array<AIFloat3> route = {p};
            a.task.SetRoute(route);
            if (!a.hasPost || mode != a.mode) Log("antinuke " + a.id + " post " + XY(p) + ": " + mode + " (stock " + u.GetStockpile() + ")");
            a.post = p; a.hasPost = true; a.lastOrder = ai.frame; a.mode = mode;
        }
    }

    // ---------------- production ----------------
    CCircuitDef@ BuildableBy(const CCircuitDef@ lab)
    {
        if (lab is null) return null;
        // our side's unit first
        const string side = Global::AISettings::Side;
        const int first = side == "armada" ? 0 : (side == "cortex" ? 1 : (side == "legion" ? 2 : 0));
        for (uint k = 0; k < Names.length(); ++k) {
            CCircuitDef@ d = ai.GetCircuitDef(Names[(uint(first) + k) % Names.length()]);
            if (d !is null && lab.CanBuild(d)) return d;
        }
        return null;
    }

    bool HasLab()
    {
        array<Id>@ ids = ai.GetOwnedUnitIds();
        if (ids is null) return false;
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef is null || u.circuitDef.IsMobile() || u.GetBuildProgress() < 1.0f) continue;
            if (BuildableBy(u.circuitDef) !is null) return true;
        }
        return false;
    }

    int Shortfall()
    {
        const int pending = (order !is null && orderFor < 0) ? 1 : 0;
        int own = 0;
        for (uint i = 0; i < antis.length(); ++i) if (!IsGift(antis[i].id)) ++own;
        return Wanted() - own - int(incoming.length()) - pending - (reqState == 2 ? 1 : 0);
    }

    void ReleaseCap()
    {
        if (orderDef < 0) return;
        CCircuitDef@ d = ai.GetCircuitDef(orderDef);
        if (d !is null && d.maxThisUnit == openedCap) d.maxThisUnit = savedCap;
        openedCap = -1;
    }
    void ClearOrder() { ReleaseCap(); @order = null; orderFactory = -1; orderDef = -1; orderFor = -1; }

    // Factory::AiMakeTask (FRONT)
    IUnitTask@ FactoryMakeTask(CCircuitUnit@ factory)
    {
        if (!Active() || factory is null || factory.circuitDef is null) return null;
        if (order !is null) {
            if (order.IsDead() || ai.GetTeamUnit(orderFactory) is null || ai.frame - orderFrame > Global::MobileAntiNuke::OrderTimeoutSeconds * SECOND) ClearOrder();
            else return null;   // one at a time
        }
        CCircuitDef@ product = BuildableBy(factory.circuitDef);
        if (product is null || !product.IsBuildAllowed()) return null;
        const int own = Shortfall();
        int forTeam = -2;
        int owedAt = -1;
        for (uint i = 0; i < owed.length() && owedAt < 0; ++i) if (owed[i].gift < 0) owedAt = int(i);
        if (own > 0 && (antis.length() == 0 || owedAt < 0)) forTeam = -1;   // our first one before any gift
        else if (owedAt >= 0) forTeam = owed[owedAt].team;
        else if (own > 0) forTeam = -1;
        if (forTeam == -2) return null;
        orderDef = product.id; savedCap = product.maxThisUnit;
        openedCap = AiMax(product.maxThisUnit, product.count + 1);
        product.maxThisUnit = openedCap;
        if (!product.IsAvailable(ai.frame)) { ReleaseCap(); orderDef = -1; return null; }
        @order = aiFactoryMgr.Enqueue(TaskS::Recruit(Task::RecruitType::FIREPOWER, Task::Priority::HIGH, product, factory.GetPos(ai.frame), 64.0f));
        if (order is null) { ReleaseCap(); orderDef = -1; return null; }
        orderFactory = factory.id; orderFrame = ai.frame; orderFor = forTeam;
        Log("ordered " + product.GetName() + " in " + factory.circuitDef.GetName() + " " + factory.id + (forTeam < 0 ? " for us" : " for team " + forTeam));
        return order;
    }

    // Military::AiUnitAdded: our order's unit (a gift goes from DonorUpdate)
    void UnitAdded(CCircuitUnit@ unit)
    {
        if (unit is null || !IsMobileAnti(unit.circuitDef) || order is null) return;
        if (unit.GetProducerId() != orderFactory || int(unit.circuitDef.id) != orderDef) return;
        if (orderFor >= 0) {
            for (uint i = 0; i < owed.length(); ++i)
                if (owed[i].team == orderFor && owed[i].gift < 0) { owed[i].gift = unit.id; Log("built " + unit.circuitDef.GetName() + " " + unit.id + " for team " + orderFor); break; }
        } else {
            // counted until Military::AiMakeTask admits it: the lab asks for its next task first
            // (headless 11-25: a second one was ordered for us in the same frame)
            if (incoming.find(unit.id) < 0 && FindAnti(unit.id) < 0) { incoming.insertLast(unit.id); incomingAt.insertLast(ai.frame); }
            Log("built " + unit.circuitDef.GetName() + " " + unit.id + " for us");
        }
        ClearOrder();
    }

    // ---------------- trade: requester ----------------
    bool Avoided(int team)
    {
        const string k = "" + team;
        if (!avoidUntil.exists(k)) return false;
        int64 until = 0; avoidUntil.get(k, until);
        return ai.frame < until;
    }

    int FrontAllies()
    {
        array<Team::Roster::Entry@>@ fronts = Team::Roster::WithRole(AiRole::FRONT);
        int n = 0;
        if (fronts is null) return 0;
        for (uint i = 0; i < fronts.length(); ++i)
            if (fronts[i] !is null && fronts[i].teamId != ai.teamId && Team::IsAlly(fronts[i].teamId)) ++n;
        return n;
    }

    void Cancel(const string &in why)
    {
        if (reqState == 2 && donor >= 0) AiSendMessage(MSG + "|cancel|" + token, donor);
        if (reqState != 0) Log("request " + token + " closed: " + why);
        reqState = 0; donor = -1;
    }

    void RequesterUpdate()
    {
        // the hand-over lands up to a second after "sent"; one not admitted in 60 s is gone
        for (int i = int(incoming.length()) - 1; i >= 0; --i)
            if (ai.frame - incomingAt[i] > 60 * SECOND) { incoming.removeAt(uint(i)); incomingAt.removeAt(uint(i)); }
        if (HasLab()) { noLabSince = -1; if (reqState != 0) Cancel("we have the lab now"); return; }
        const int need = Shortfall();
        if (reqState == 1 && ai.frame - askFrame >= Global::MobileAntiNuke::OfferSeconds * SECOND) {
            int best = -1; float bd = 1e30f;
            for (uint i = 0; i < offerTeam.length(); ++i) {
                if (Avoided(offerTeam[i])) continue;
                Team::Roster::Entry@ e = Team::Roster::Get(offerTeam[i]);
                const float d = (e is null) ? 1e29f : MapHelpers::SqDist(e.startPos, Global::Map::StartPos);
                if (d < bd) { bd = d; best = offerTeam[i]; }
            }
            if (best < 0) {
                reqState = 0; nextAsk = ai.frame + Global::MobileAntiNuke::RetrySeconds * SECOND;
                Log("no allied FRONT can build a mobile antinuke for us (" + offerTeam.length() + " offers); asking again in " + Global::MobileAntiNuke::RetrySeconds + " s");
                return;
            }
            donor = best; reqState = 2; acceptFrame = ai.frame;
            AiSendMessage(MSG + "|accept|" + token, donor);
            Log("team " + donor + " (nearest with the lab) builds our mobile antinuke");
            return;
        }
        if (reqState == 2) {
            if (need < 0) { Cancel("no longer wanted"); return; }
            if (ai.frame - acceptFrame >= Global::MobileAntiNuke::DeliverSeconds * SECOND) {
                avoidUntil.set("" + donor, int64(ai.frame + 3 * Global::MobileAntiNuke::RetrySeconds * SECOND));
                Cancel("team " + donor + " sent nothing in " + Global::MobileAntiNuke::DeliverSeconds + " s");
                nextAsk = ai.frame;
            }
            return;
        }
        if (need <= 0) { noLabSince = -1; return; }
        if (noLabSince < 0) { noLabSince = ai.frame; Log("mobile antinuke wanted, no lab that builds one; asking allies in " + Global::MobileAntiNuke::AskAfterSeconds + " s if none comes"); }
        if (ai.frame - noLabSince < Global::MobileAntiNuke::AskAfterSeconds * SECOND || ai.frame < nextAsk || reqState != 0) return;
        if (FrontAllies() == 0) { nextAsk = ai.frame + Global::MobileAntiNuke::RetrySeconds * SECOND; Log("no allied FRONT to ask"); return; }
        token = ai.frame; askFrame = ai.frame; reqState = 1; offerTeam.resize(0);
        AiSendMessage(MSG + "|req|" + token);
        Log("asked " + FrontAllies() + " allied FRONTs for a mobile antinuke (request " + token + ")");
    }

    // ---------------- trade: donor ----------------
    int FindOwed(int team) { for (uint i = 0; i < owed.length(); ++i) if (owed[i].team == team) return int(i); return -1; }

    void DonorUpdate()
    {
        for (int i = int(owed.length()) - 1; i >= 0; --i) {
            Owed@ o = owed[i];
            if (ai.frame - o.since >= Global::MobileAntiNuke::DeliverSeconds * SECOND) { Log("owed mobile antinuke for team " + o.team + " dropped: timed out"); owed.removeAt(uint(i)); continue; }
            if (o.gift < 0) continue;
            CCircuitUnit@ g = ai.GetTeamUnit(o.gift);
            if (g is null) { Log("gift " + o.gift + " for team " + o.team + " died; building another"); o.gift = -1; continue; }
            if (g.GetBuildProgress() < 1.0f || !Team::IsAlly(o.team)) continue;
            const int id = g.id;
            const string name = g.circuitDef.GetName();
            const int at = FindAnti(id);
            if (at >= 0) antis.removeAt(uint(at));
            array<CCircuitUnit@> give = { g };
            ai.GiveUnits(give, o.team);
            AiSendMessage(MSG + "|sent|" + o.token + "|" + id, o.team);
            Log("gave " + name + " " + id + " to team " + o.team);
            WidgetLink::Send("donation", name + "|" + o.team);
            owed.removeAt(uint(i));
        }
    }

    bool IsGift(int id) { for (uint i = 0; i < owed.length(); ++i) if (owed[i].gift == id) return true; return false; }

    // ---------------- hooks ----------------
    // Front_EconomyUpdate
    void Update()
    {
        if (!Active()) return;
        if (ai.frame - lastUpdate < Global::MobileAntiNuke::UpdateSeconds * SECOND) return;
        lastUpdate = ai.frame;
        if (!started && Wanted() > 0) { started = true; Log("enemy nukes: FRONT mobile antinukes on (" + Wanted() + " wanted)"); }
        RequesterUpdate();
        if (owed.length() > 0) DonorUpdate();
        Control();
    }

    // Team::HandleMessage
    bool HandleMessage(const string &in msg, int from)
    {
        if (msg.findFirst(MSG + "|") != 0) return false;
        array<string>@ p = msg.split("|");
        if (p.length() < 3 || from == ai.teamId) return true;
        const string verb = p[1];
        const int tok = int(parseInt(p[2]));
        if (verb == "req") {
            if (!Active()) return true;
            if (HasLab()) { AiSendMessage(MSG + "|offer|" + tok, from); Log("team " + from + " asks for a mobile antinuke: our lab can build one"); }
            return true;
        }
        if (verb == "accept") {
            if (!Active()) return true;
            const int at = FindOwed(from);
            if (at >= 0) { owed[at].token = tok; owed[at].since = ai.frame; return true; }
            Owed@ o = Owed(); o.team = from; o.token = tok; o.since = ai.frame;
            owed.insertLast(o);
            Log("owe team " + from + " a mobile antinuke");
            return true;
        }
        if (verb == "cancel") {
            const int at = FindOwed(from);
            if (at >= 0 && owed[at].token == tok) { Log("owed mobile antinuke for team " + from + " cancelled" + (owed[at].gift >= 0 ? " (the built one stays ours)" : "")); owed.removeAt(uint(at)); }
            return true;
        }
        if (tok != token) return true;
        if (verb == "offer" && reqState == 1) { if (offerTeam.find(from) < 0) offerTeam.insertLast(from); return true; }
        if (verb == "sent" && p.length() >= 4) {
            const int id = int(parseInt(p[3]));
            if (incoming.find(id) < 0 && FindAnti(id) < 0) { incoming.insertLast(id); incomingAt.insertLast(ai.frame); }
            Log("team " + from + " sent mobile antinuke " + id);
            if (reqState == 2) { reqState = 0; donor = -1; acceptFrame = ai.frame; }
            return true;
        }
        return true;
    }
}
