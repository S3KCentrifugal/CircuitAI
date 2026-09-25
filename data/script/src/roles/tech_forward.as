// TECH D-109: the land constructors leave the base once the air constructors
// carry it. T2 land constructors defend the mex clusters (long-range AA and
// flak first); T1 land constructors go forward to a spam cluster (T1 bot labs,
// each with two construction turrets directly behind it) and build its
// defences and small turret pads. A tier whose air constructors go down calls
// its land constructors back to the eco clusters.
// Design and evidence: doc/decisions.md D-109; how it fits the base:
// doc/roles/tech-layout-and-sequence.md.
#include "../define.as"
#include "../unit.as"
#include "../task.as"
#include "../global.as"
#include "../helpers/generic_helpers.as"
#include "../helpers/unit_helpers.as"
#include "../helpers/unitdef_helpers.as"
#include "../helpers/map_helpers.as"
#include "../helpers/guard_helpers.as"
#include "../manager/builder.as"
#include "../manager/layout.as"
#include "tech_build.as"

namespace TechForward {

    // ---------------------------------------------------------------- release

    float Sq(float v) { return v * v; }

    int T1AirCons() { return UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllT1AirConstructors()); }

    // T2: the air constructors hold both dedicated roles (D-107/D-108)
    bool T2Released()
    {
        return TechBuild::airConvId >= 0 && TechBuild::airAfusId >= 0
            && ai.GetTeamUnit(TechBuild::airConvId) !is null && ai.GetTeamUnit(TechBuild::airAfusId) !is null;
    }
    // T1: more than T1AirReleaseAbove T1 air constructors carry the base
    bool T1Released() { return T1AirCons() > Global::RoleSettings::Tech::T1AirReleaseAbove; }

    bool IsLand(CCircuitUnit@ u) { return u !is null && u.circuitDef !is null && !UnitHelpers::IsAirConstructor(u.circuitDef); }
    int Tier(CCircuitUnit@ u) { return (u is null || u.circuitDef is null) ? 0 : UnitHelpers::GetConstructorTier(u.circuitDef); }
    bool Released(int tier) { return (tier >= 2) ? T2Released() : T1Released(); }

    bool wasT1 = false;
    bool wasT2 = false;
    bool everT1 = false;
    bool everT2 = false;
    int sinceT1 = -1, sinceT2 = -1;          // released since (INV-039)
    int recallT1 = -1, recallT2 = -1;        // recalled at (INV-040)
    int lastOrderT1 = -1, lastOrderT2 = -1;  // the last forward order of each tier (INV-039)
    // From TechBuild::Tick: the transitions, said once each
    void Tick()
    {
        const bool r1 = T1Released();
        const bool r2 = T2Released();
        if (r1 != wasT1) {
            GenericHelpers::LogUtil("[TECH][Forward] T1 land constructors " + (r1 ? "released: " : "recalled to the eco clusters: ")
                + T1AirCons() + " T1 air constructors (release above " + Global::RoleSettings::Tech::T1AirReleaseAbove + ") (D-109)", 1);
            wasT1 = r1;
            everT1 = everT1 || r1;
            sinceT1 = r1 ? ai.frame : -1;
            if (!r1) recallT1 = ai.frame;
        }
        if (r2 != wasT2) {
            GenericHelpers::LogUtil("[TECH][Forward] T2 land constructors " + (r2 ? "released to the mex clusters" : "recalled to the eco clusters: a dedicated air role is open")
                + " (D-109)", 1);
            wasT2 = r2;
            everT2 = everT2 || r2;
            sinceT2 = r2 ? ai.frame : -1;
            if (!r2) recallT2 = ai.frame;
        }
        TickSpam();   // D-111
    }

    // A forward job: a construction whose site is beyond ForwardHomeRadius of the base
    bool IsForwardJob(CCircuitUnit@ u)
    {
        if (u is null || u.task is null) return false;
        IBuilderTask@ bt = cast<IBuilderTask>(u.task);
        if (bt is null) return false;
        const AIFloat3 p = bt.GetBuildPos();
        if (p.x < 0.0f) return false;
        return MapHelpers::SqDist(p, Layout::BaseCentre()) > Sq(Global::RoleSettings::Tech::ForwardHomeRadius);
    }
    // Owner's rule: a tier whose air constructors went down sends its land
    // constructors back to an eco cluster first: a forward job is dropped and the
    // eco rows below take the builder (null: the table continues)
    IUnitTask@ Recall(CCircuitUnit@ u)
    {
        if (!IsLand(u)) return null;
        const int tier = Tier(u);
        if (tier < 1 || Released(tier) || !((tier >= 2) ? everT2 : everT1)) return null;
        if (!IsForwardJob(u)) return null;
        // INV-040 (D-109): a recalled land constructor drops its forward job within 60 s
        const int since = (tier >= 2) ? recallT2 : recallT1;
        if (since >= 0 && ai.frame - since > 60 * SECOND)
            Invariants::Violation("INV-040", "recall", u.circuitDef.GetName() + " " + u.id + " still on a forward job " + int((ai.frame - since) / SECOND) + " s after its tier was recalled");
        GenericHelpers::LogUtil("[TECH][Forward] " + u.circuitDef.GetName() + " " + u.id + " recalled: its tier's air constructors are down (D-109)", 1);
        aiBuilderMgr.AbortTask(u.task);
        return null;
    }

    // ---------------------------------------------------------------- mex clusters (T2)

    class MexCluster {
        AIFloat3 c;
        int n;
        MexCluster(const AIFloat3& in p) { c = p; n = 1; }
    }
    // our mexes, grouped greedily: a mex within MexClusterRadius of a cluster's
    // centre joins it
    array<MexCluster@> Clusters()
    {
        array<MexCluster@> cls;
        const float r2 = Sq(Global::RoleSettings::Tech::MexClusterRadius);
        for (uint i = 0; i < Economy::MexTracker::myMexes.length(); ++i) {
            const AIFloat3 p = Economy::MexTracker::myMexes[i].pos;
            bool joined = false;
            for (uint k = 0; k < cls.length(); ++k) {
                if (MapHelpers::SqDist(cls[k].c, p) <= r2) {
                    const float w = float(cls[k].n);
                    cls[k].c = AIFloat3((cls[k].c.x * w + p.x) / (w + 1.0f), cls[k].c.y, (cls[k].c.z * w + p.z) / (w + 1.0f));
                    cls[k].n += 1;
                    joined = true;
                    break;
                }
            }
            if (!joined) cls.insertLast(MexCluster(p));
        }
        return cls;
    }

    dictionary orderAt;   // "x:z:def" -> frame of the last order there
    array<int> orderBuilders;   // D-109: who carries each recent mex defence order (the others follow)
    string OrderKey(const AIFloat3& in p, const string &in def) { return "" + int(p.x / 64.0f) + ":" + int(p.z / 64.0f) + ":" + def; }
    bool RecentlyOrdered(const AIFloat3& in p, const string &in def)
    {
        int f;
        return orderAt.get(OrderKey(p, def), f) && (ai.frame - f < Global::RoleSettings::Tech::ForwardOrderHoldSeconds * SECOND);
    }
    void NoteOrder(const AIFloat3& in p, const string &in def) { orderAt.set(OrderKey(p, def), ai.frame); }

    // Is def (standing or going up) within radius of p?
    bool Stands(const AIFloat3& in p, float radius, CCircuitDef@ def)
    {
        return aiBuilderMgr.FindOwnNear(p, radius, def) !is null || aiBuilderMgr.FindUnfinishedNear(p, radius, def) !is null;
    }
    // D-108's lesson: TECH's start caps pin defences at 0; the owner asks for these
    bool Buildable(CCircuitUnit@ u, CCircuitDef@ d)
    {
        if (d is null || !u.circuitDef.CanBuild(d)) return false;
        if (d.maxThisUnit <= d.count) d.maxThisUnit = d.count + 1;
        return d.IsAvailable(ai.frame);
    }

    IUnitTask@ OrderDefence(CCircuitUnit@ u, CCircuitDef@ d, const AIFloat3& in at, float shake, const string &in why)
    {
        IUnitTask@ t = aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::DEFENCE, Task::Priority::NORMAL, d, at, shake, true,
            Global::RoleSettings::Tech::ForwardOrderHoldSeconds * SECOND));
        if (t is null) return null;
        NoteOrder(at, d.GetName());
        if (Tier(u) >= 2) lastOrderT2 = ai.frame; else lastOrderT1 = ai.frame;
        GenericHelpers::LogUtil("[TECH][Forward] " + u.circuitDef.GetName() + " " + u.id + " orders " + d.GetName() + " at (" + int(at.x) + ", " + int(at.z) + "): " + why + " (D-109)", 1);
        return t;
    }

    // Owner's rule: once the T2 air constructors are up, every T2 land
    // constructor defends the mex clusters, long-range AA and flak first. The
    // nearest cluster outside the base missing one of them.
    IUnitTask@ DefendMexes(CCircuitUnit@ u)
    {
        const string side = Global::AISettings::Side;
        array<CCircuitDef@> defs = {
            ai.GetCircuitDef(UnitHelpers::GetStaticT2AARangeNameForSide(side)),
            ai.GetCircuitDef(UnitHelpers::GetStaticT2AAFlakNameForSide(side))
        };
        array<MexCluster@> cl = Clusters();
        const AIFloat3 from = u.GetPos(ai.frame);
        const AIFloat3 base = Layout::BaseCentre();
        const float clear2 = Sq(Global::RoleSettings::Tech::MexDefenceBaseClear);
        const float r = Global::RoleSettings::Tech::MexDefenceRadius;
        for (uint k = 0; k < defs.length(); ++k) {   // every cluster gets the first before any gets the second
            CCircuitDef@ d = defs[k];
            if (!Buildable(u, d)) continue;
            int best = -1;
            float bestSq = 1.0e30f;
            for (uint i = 0; i < cl.length(); ++i) {
                if (MapHelpers::SqDist(cl[i].c, base) < clear2) continue;   // the base is the eco layout's ground
                if (Stands(cl[i].c, r, d) || RecentlyOrdered(cl[i].c, d.GetName())) continue;
                const float sq = MapHelpers::SqDist(cl[i].c, from);
                if (sq < bestSq) { bestSq = sq; best = int(i); }
            }
            if (best < 0) continue;
            IUnitTask@ t = OrderDefence(u, d, cl[best].c, Global::RoleSettings::Tech::MexDefenceShake,
                "mex cluster of " + cl[best].n + ", " + int(sqrt(bestSq)) + " away");
            if (t !is null && orderBuilders.find(u.id) < 0) orderBuilders.insertLast(u.id);
            return t;
        }
        // D-109 (played: one T2 bot walked to each cluster alone while the rest went
        // back to the eco rows; 1 of 26 defences stood by 36 min): every released
        // T2 land constructor stays on the defences: a defence going up at a
        // cluster first, else follow a constructor carrying a defence order
        CCircuitUnit@ frame = null;
        float frameSq = 1.0e30f;
        for (uint k = 0; k < defs.length(); ++k) {
            if (defs[k] is null) continue;
            for (uint i = 0; i < cl.length(); ++i) {
                CCircuitUnit@ f = aiBuilderMgr.FindUnfinishedNear(cl[i].c, r, defs[k]);
                if (f is null) continue;
                const float sq = MapHelpers::SqDist(f.GetPos(ai.frame), from);
                if (sq < frameSq) { frameSq = sq; @frame = f; }
            }
        }
        if (frame !is null) return aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::NORMAL, frame, 60 * SECOND));
        CCircuitUnit@ lead = null;
        float leadSq = 1.0e30f;
        for (int i = int(orderBuilders.length()) - 1; i >= 0; --i) {
            CCircuitUnit@ b = ai.GetTeamUnit(orderBuilders[i]);
            IBuilderTask@ bt = (b is null || b.task is null) ? null : cast<IBuilderTask>(b.task);
            if (bt is null || Task::BuildType(bt.GetBuildType()) != Task::BuildType::DEFENCE) {
                if (b is null) orderBuilders.removeAt(i);
                continue;
            }
            if (b.id == u.id) continue;
            const float sq = MapHelpers::SqDist(b.GetPos(ai.frame), from);
            if (sq < leadSq) { leadSq = sq; @lead = b; }
        }
        if (lead !is null) return GuardHelpers::AssignWorkerGuard(u, lead, Task::Priority::NORMAL, true, 60 * SECOND);
        return null;
    }

    // ---------------------------------------------------------------- the spam cluster (T1)

    // A spam cluster: T1 bot labs in a row across the front direction, each lab's
    // exit clear toward the front and two construction turrets directly behind it
    // (a nano block tight against its back), so no lab, turret or pad stands in
    // another lab's lane. Small turret pads stand at the row's ends, behind the
    // lab line.
    class SpamLab {
        int labRes = -1;        // the lab's reservation (forgotten by native once built)
        AIFloat3 pos;           // the lab's site
        int nanoGroup = 0;      // its two turrets' group
        array<AIFloat3> turretPos;   // where its two turrets stand (script's record: built slots are forgotten)
        int labId = -1;         // the lab unit, once seen
        int orderedFrame = -100000;
        int standFrame = -1;    // first seen finished (INV-038)
        int invLog = -100000;
    }
    array<SpamLab@> labs;
    bool planned = false;
    AIFloat3 anchor;
    int facing = 0;
    array<int> padGroups;
    array<AIFloat3> padCentres;
    int planLog = -100000;

    bool Plan()
    {
        if (planned) return true;
        const AIFloat3 home = Layout::HomeCentre();
        const AIFloat3 front = Layout::FrontTarget();
        const float dx = front.x - home.x, dz = front.z - home.z;
        const float dist = sqrt(dx * dx + dz * dz);
        if (dist < 1.0f) return false;
        float along = Global::RoleSettings::Tech::SpamForwardElmos;
        const float cap = Global::RoleSettings::Tech::SpamForwardMaxShare * dist;
        if (along > cap) along = cap;
        anchor = AIFloat3(home.x + dx / dist * along, home.y, home.z + dz / dist * along);
        facing = Layout::LabFacing();
        planned = true;
        GenericHelpers::LogUtil("[TECH][Forward] spam cluster anchored at (" + int(anchor.x) + ", " + int(anchor.z) + "), " + int(along)
            + " toward the front, labs facing " + facing + " (D-109)", 1);
        return true;
    }

    // D-109 (played: the row near the anchor had no room and the labs spread
    // over 2,000 elmos): the labs stay one cluster. The first lab takes the
    // first line near the anchor that fits (sliding along the front direction);
    // every later lab joins that line, beside the labs already there, never in
    // front of or behind one (its lane)
    bool lineSet = false;
    int searchTry = -100000;
    float lineAlong = 0.0f;   // the row line's offset along the front direction from the anchor
    AIFloat3 LinePos(CCircuitDef@ lab, float along, int k)
    {
        const int step = (k + 1) / 2;
        const float sign = (k % 2 == 1) ? 1.0f : -1.0f;
        const float pitch = float(Layout::Across(lab, facing) + Global::RoleSettings::Tech::SpamLabGapCells) * SQUARE_SIZE * 2;
        const float off = (k == 0) ? 0.0f : sign * float(step) * pitch;
        return anchor + Layout::Fwd(facing) * along + Layout::Side(facing) * off;
    }
    // the across-offset of the row's labs' middle, so a new lab goes beside them
    float RowMiddle()
    {
        if (labs.length() == 0) return 0.0f;
        const AIFloat3 sd = Layout::Side(facing);
        float sum = 0.0f;
        for (uint i = 0; i < labs.length(); ++i) sum += (labs[i].pos.x - anchor.x) * sd.x + (labs[i].pos.z - anchor.z) * sd.z;
        return sum / float(labs.length());
    }
    bool SiteFits(CCircuitDef@ lab, const AIFloat3& in p)
    {
        return !aiTerrainMgr.IsZoneAlly(p) && aiTerrainMgr.CanReserveBuilding(lab, p, facing) && aiTerrainMgr.IsExitClear(lab, p, facing, 320.0f, 32.0f);
    }

    // Reserve the next lab site of the row with its two turrets behind it
    SpamLab@ ReserveNext(CCircuitDef@ lab, CCircuitDef@ nano)
    {
        array<AIFloat3> cands;
        const int across = Global::RoleSettings::Tech::SpamRowTries;
        if (!lineSet) {
            // D-109 (played: the free ground began ~775 elmos from the anchor and a
            // narrow search found none): every line within SpamSearchLines steps of
            // the anchor, 2 x SpamRowTries positions across each; the fit nearest
            // the anchor takes the line
            if (ai.frame - searchTry < 10 * SECOND) return null;
            searchTry = ai.frame;
            const float lineStep = 4.0f * SQUARE_SIZE * 2;
            float bestSq = 1.0e30f;
            for (int j = 0; j <= 2 * Global::RoleSettings::Tech::SpamSearchLines; ++j) {
                const float along = float((j + 1) / 2) * lineStep * ((j % 2 == 1) ? 1.0f : -1.0f);
                for (int k = 0; k < 2 * across; ++k) {
                    const AIFloat3 p = LinePos(lab, along, k);
                    const float sq = MapHelpers::SqDist(p, anchor);
                    if (sq >= bestSq || !SiteFits(lab, p)) continue;
                    bestSq = sq;
                    if (cands.length() == 0) cands.insertLast(p); else cands[0] = p;
                    lineAlong = along;
                }
            }
        } else {
            // beside the labs already in the row: nearest the row's middle first
            const float mid = RowMiddle();
            const AIFloat3 sd = Layout::Side(facing);
            array<float> dist;
            for (int k = 0; k < 2 * across; ++k) {
                const AIFloat3 p = LinePos(lab, lineAlong, k);
                if (!SiteFits(lab, p)) continue;
                const float o = (p.x - anchor.x) * sd.x + (p.z - anchor.z) * sd.z;
                const float d = abs(o - mid);
                uint at = 0;
                while (at < dist.length() && dist[at] <= d) ++at;
                dist.insertAt(at, d);
                cands.insertAt(at, p);
            }
        }
        for (uint c = 0; c < cands.length(); ++c) {
            const AIFloat3 p = cands[c];
            const int id = aiTerrainMgr.ReserveBuilding(lab, p, facing);
            if (id < 0) continue;
            const AIFloat3 lp = aiTerrainMgr.GetReservationPos(id);
            const int g = aiTerrainMgr.ReserveNanoBlockAt(nano, lab, lp, facing, 2, 1, 0);
            if (g <= 0) { aiTerrainMgr.ReleaseReservation(id); continue; }
            SpamLab@ s = SpamLab();
            s.labRes = id;
            s.pos = lp;
            s.nanoGroup = g;
            // the two slots: the one nearest each side of the lab
            const float far = 400.0f;
            const int a = aiTerrainMgr.NextSlotAny(g, lp + Layout::Side(facing) * far);
            const int b = aiTerrainMgr.NextSlotAny(g, lp - Layout::Side(facing) * far);
            if (a >= 0) s.turretPos.insertLast(aiTerrainMgr.GetReservationPos(a));
            if (b >= 0 && b != a) s.turretPos.insertLast(aiTerrainMgr.GetReservationPos(b));
            labs.insertLast(s);
            lineSet = true;
            GenericHelpers::LogUtil("[TECH][Forward] spam lab " + labs.length() + " reserved at (" + int(lp.x) + ", " + int(lp.z) + ") with "
                + s.turretPos.length() + " turret slot(s) behind it (D-109)", 1);
            return s;
        }
        if (ai.frame - planLog > 60 * SECOND) {
            planLog = ai.frame;
            GenericHelpers::LogUtil("[TECH][Forward] no spam lab site in the row near (" + int(anchor.x) + ", " + int(anchor.z) + ") (D-109)", 1);
        }
        return null;
    }

    // the lab standing (or going up) on a spam site
    CCircuitUnit@ LabAt(SpamLab@ s, CCircuitDef@ lab)
    {
        if (s.labId >= 0) {
            CCircuitUnit@ u = ai.GetTeamUnit(s.labId);
            if (u !is null) return u;
            s.labId = -1;
        }
        CCircuitUnit@ f = aiBuilderMgr.FindOwnNear(s.pos, 48.0f, lab);
        if (f is null) @f = aiBuilderMgr.FindUnfinishedNear(s.pos, 48.0f, lab);
        if (f !is null) s.labId = f.id;
        return f;
    }
    CCircuitUnit@ TurretAt(const AIFloat3& in p, CCircuitDef@ nano)
    {
        CCircuitUnit@ t = aiBuilderMgr.FindOwnNear(p, 32.0f, nano);
        if (t is null) @t = aiBuilderMgr.FindUnfinishedNear(p, 32.0f, nano);
        return t;
    }

    int SpamLabsStanding(CCircuitDef@ lab)
    {
        int n = 0;
        for (uint i = 0; i < labs.length(); ++i) if (LabAt(labs[i], lab) !is null) ++n;
        return n;
    }

    // Owner's rule: one T1 spam bot lab per SpamLabMetalStep (100) of metal
    // income, up to SpamLabsMax
    int SpamLabsWanted(float mi)
    {
        int n = int(mi / Global::RoleSettings::Tech::SpamLabMetalStep);
        return (n > Global::RoleSettings::Tech::SpamLabsMax) ? Global::RoleSettings::Tech::SpamLabsMax : n;
    }

    IUnitTask@ OrderPinned(CCircuitUnit@ u, Task::BuildType type, CCircuitDef@ d, int id, const string &in what)
    {
        const AIFloat3 p = aiTerrainMgr.GetReservationPos(id);
        IUnitTask@ t = (type == Task::BuildType::FACTORY)
            ? aiBuilderMgr.Enqueue(TaskB::Factory(Task::Priority::HIGH, d, p, null, 0.0f, false, true, 300 * SECOND))
            : aiBuilderMgr.Enqueue(TaskB::Common(type, Task::Priority::HIGH, d, p, 0.0f, true, 120 * SECOND));
        if (t is null) return null;
        if (!AiPinReservation(t, id)) GenericHelpers::LogUtil("[TECH][Forward] could not pin " + what + " to slot " + id, 1);
        lastOrderT1 = ai.frame;
        GenericHelpers::LogUtil("[TECH][Forward] " + u.circuitDef.GetName() + " " + u.id + " orders " + what + " at (" + int(p.x) + ", " + int(p.z) + ") (D-109)", 1);
        return t;
    }

    // The released T1 land constructor's work, in order: the next spam lab while
    // income asks for one; a lab's two turrets; the cluster's AA; idle: a small
    // turret pad at a row end; else assist what goes up forward, else guard a lab.
    IUnitTask@ ForwardT1(CCircuitUnit@ u, float mi)
    {
        const string side = Global::AISettings::Side;
        CCircuitDef@ lab = ai.GetCircuitDef(UnitHelpers::GetT1BotLabForSide(side));
        CCircuitDef@ nano = ai.GetCircuitDef(UnitHelpers::GetT1NanoNameForSide(side));
        if (lab is null || nano is null || !Plan()) return null;

        // 1. the spam labs: one per +100 metal; an unordered reserved site first
        const bool gate = Global::Spam::Enabled && TechBuild::EcoOnline();
        if (gate && u.circuitDef.CanBuild(lab)) {
            for (uint i = 0; i < labs.length(); ++i) {
                SpamLab@ s = labs[i];
                if (LabAt(s, lab) !is null || ai.frame - s.orderedFrame < 120 * SECOND) continue;
                if (s.labRes < 0) continue;
                IUnitTask@ t = OrderPinned(u, Task::BuildType::FACTORY, lab, s.labRes, "spam lab " + (i + 1));
                if (t !is null) { s.orderedFrame = ai.frame; return t; }
            }
            if (int(labs.length()) < SpamLabsWanted(mi) && aiBuilderMgr.GetQueuedBuildCount(int(Task::BuildType::FACTORY), lab) == 0) {
                if (lab.maxThisUnit <= lab.count) lab.maxThisUnit = lab.count + 1;
                SpamLab@ s = ReserveNext(lab, nano);
                if (s !is null) {
                    IUnitTask@ t = OrderPinned(u, Task::BuildType::FACTORY, lab, s.labRes, "spam lab " + labs.length() + " (+" + int(mi) + " metal)");
                    if (t !is null) { s.orderedFrame = ai.frame; return t; }
                }
            }
        }
        // 2. each lab's two turrets directly behind it
        for (uint i = 0; i < labs.length(); ++i) {
            SpamLab@ s = labs[i];
            if (LabAt(s, lab) is null) continue;
            const int id = aiTerrainMgr.NextSlotAny(s.nanoGroup, s.pos);
            if (id < 0) continue;
            IUnitTask@ t = OrderPinned(u, Task::BuildType::NANO, nano, id, "a turret behind spam lab " + (i + 1));
            if (t !is null) return t;
        }
        // 3. the cluster's AA: one per lab, behind the lab line at its side
        CCircuitDef@ aa = ai.GetCircuitDef(UnitHelpers::GetStaticAAHeavyNameForSide(side));
        if (Buildable(u, aa)) {
            for (uint i = 0; i < labs.length(); ++i) {
                SpamLab@ s = labs[i];
                if (LabAt(s, lab) is null) continue;
                const AIFloat3 at = s.pos - Layout::Fwd(facing) * (float(Layout::Along(lab, facing) + 2 * Layout::Along(nano, facing) + 2) * SQUARE_SIZE);
                if (Stands(at, 160.0f, aa) || RecentlyOrdered(at, aa.GetName())) continue;
                IUnitTask@ t = OrderDefence(u, aa, at, 64.0f, "spam lab " + (i + 1) + "'s AA, behind the lab line");
                if (t !is null) return t;
            }
        }
        // 4. idle: a small pad of turrets at a row end, behind the lab line
        IUnitTask@ pad = PadTurret(u, lab, nano);
        if (pad !is null) return pad;
        // 5. assist what goes up forward, else guard the nearest spam lab
        CCircuitUnit@ f = aiBuilderMgr.FindUnfinishedNear(anchor, Global::RoleSettings::Tech::SpamClusterRadius, null);
        if (f !is null) return aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::NORMAL, f, 30 * SECOND));
        CCircuitUnit@ best = null;
        float bestSq = 1.0e30f;
        for (uint i = 0; i < labs.length(); ++i) {
            CCircuitUnit@ l = LabAt(labs[i], lab);
            if (l is null) continue;
            const float sq = MapHelpers::SqDist(l.GetPos(ai.frame), u.GetPos(ai.frame));
            if (sq < bestSq) { bestSq = sq; @best = l; }
        }
        if (best !is null) return GuardHelpers::AssignWorkerGuard(u, best, Task::Priority::LOW, true, 30 * SECOND);
        return null;
    }

    // Owner's rule: T1 constructors sent out and idle build small clusters of
    // construction turrets near the front to assist, not on a lane: a 2x2 pad at
    // an end of the lab row, its front edge on the labs' back line
    IUnitTask@ PadTurret(CCircuitUnit@ u, CCircuitDef@ lab, CCircuitDef@ nano)
    {
        if (labs.length() < 2) return null;
        for (uint i = 0; i < padGroups.length(); ++i) {
            const int id = aiTerrainMgr.NextSlotAny(padGroups[i], padCentres[i]);
            if (id >= 0) return OrderPinned(u, Task::BuildType::NANO, nano, id, "a turret on forward pad " + (i + 1));
        }
        if (int(padGroups.length()) >= Global::RoleSettings::Tech::SpamPadsMax) return null;
        // the row's ends: the outermost reserved labs on each side
        float lo = 1.0e30f, hi = -1.0e30f;
        const AIFloat3 sd = Layout::Side(facing);
        for (uint i = 0; i < labs.length(); ++i) {
            const float o = (labs[i].pos.x - anchor.x) * sd.x + (labs[i].pos.z - anchor.z) * sd.z;
            if (o < lo) lo = o;
            if (o > hi) hi = o;
        }
        // D-109 (played: pads at the row's ends took the next lab sites and the
        // row broke in two): behind the end labs' turret blocks, a cell of
        // walking room between, never on the lab line
        const float back = (float(Layout::Along(lab, facing)) * 0.5f + float(Layout::Along(nano, facing)) + 1.0f) * SQUARE_SIZE * 2;
        array<float> ends = { hi, lo };
        const uint e = padGroups.length() % 2;
        const AIFloat3 fc = anchor + Layout::Fwd(facing) * lineAlong + sd * ends[e] - Layout::Fwd(facing) * back;
        const int g = aiTerrainMgr.ReserveGrid(nano, fc, facing, 2, 2, 0);
        if (g <= 0) return null;
        padGroups.insertLast(g);
        padCentres.insertLast(fc);
        GenericHelpers::LogUtil("[TECH][Forward] forward turret pad " + padGroups.length() + " reserved at (" + int(fc.x) + ", " + int(fc.z) + "), behind the lab line (D-109)", 1);
        const int id = aiTerrainMgr.NextSlotAny(g, fc);
        return (id < 0) ? null : OrderPinned(u, Task::BuildType::NANO, nano, id, "a turret on forward pad " + padGroups.length());
    }

    // Owner's rule: the two turrets closest to a spam lab always work for that
    // lab: its two slots directly behind it
    IUnitTask@ TurretFocus(CCircuitUnit@ u)
    {
        if (u is null || labs.length() == 0) return null;
        CCircuitDef@ lab = ai.GetCircuitDef(UnitHelpers::GetT1BotLabForSide(Global::AISettings::Side));
        if (lab is null) return null;
        const AIFloat3 p = u.GetPos(ai.frame);
        for (uint i = 0; i < labs.length(); ++i) {
            SpamLab@ s = labs[i];
            bool mine = false;
            for (uint k = 0; k < s.turretPos.length(); ++k) {
                if (MapHelpers::SqDist(s.turretPos[k], p) <= Sq(32.0f)) { mine = true; break; }
            }
            if (!mine) continue;
            CCircuitUnit@ l = LabAt(s, lab);
            if (l is null) return null;
            if (l.GetBuildProgress() < 1.0f) return aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::HIGH, l, 30 * SECOND));
            return GuardHelpers::AssignWorkerGuard(u, l, Task::Priority::HIGH, true, 60 * SECOND);
        }
        return null;
    }

    // D-111 (owner: the route from the factory is never set, repeat is not put
    // on, each factory correlates directly to a lane): while spam runs, every
    // spam lab of ours is on repeat, runs the lane of its place in the row
    // (0, +1, -1, ... as the row itself was laid out), and carries that lane as
    // its factory route, so each unit leaves on it before any task is given;
    // the spam unit is kept buildable (TECH's start caps pin T1 combat at 0:
    // played, "corak unavailable" from 28 min)
    int routesSeen = -1;
    dictionary factoryRouteVersion;   // factory id -> Spam::routesVersion its route was set at
    void TickSpam()
    {
        if (!Spam::active) return;
        const string side = Global::AISettings::Side;
        CCircuitDef@ lab = ai.GetCircuitDef(UnitHelpers::GetT1BotLabForSide(side));
        if (lab is null) return;
        const string unitName = Spam::SpamUnitFor(lab);
        CCircuitDef@ su = (unitName.length() == 0) ? null : ai.GetCircuitDef(unitName);
        if (su !is null && su.maxThisUnit <= su.count + 5) su.maxThisUnit = su.count + 50;
        for (uint i = 0; i < labs.length(); ++i) {
            CCircuitUnit@ f = LabAt(labs[i], lab);
            if (f is null || f.GetBuildProgress() < 1.0f) continue;
            const string key = "" + f.id;
            // the lane of the lab's place in the row, fixed for good
            const int lane = (i == 0) ? 0 : ((i % 2 == 1) ? int((i + 1) / 2) : -int(i / 2));
            Spam::SetFactoryLane(f, lane);
            Spam::SetRepeatFactory(f);
            int v = -1;
            if (!factoryRouteVersion.get(key, v)) {
                f.CmdRepeat(true);
                GenericHelpers::LogUtil("[TECH][Spam] spam lab " + (i + 1) + " (" + f.id + ") on repeat, lane " + lane + " (D-111)", 1);
            }
            if (v != Spam::routesVersion) {
                array<AIFloat3> route = Spam::RouteOf(f);
                f.CmdFactoryRoute(route);
                factoryRouteVersion.set(key, Spam::routesVersion);
                GenericHelpers::LogUtil("[TECH][Spam] spam lab " + (i + 1) + " factory route set: " + route.length() + " waypoints on lane " + lane + " (D-111)", 2);
            }
        }
    }

    // INV-038 input: a standing spam lab and how many of its turrets stand
    int TurretsOf(SpamLab@ s, CCircuitDef@ nano)
    {
        int n = 0;
        for (uint k = 0; k < s.turretPos.length(); ++k) if (TurretAt(s.turretPos[k], nano) !is null) ++n;
        return n;
    }
}
