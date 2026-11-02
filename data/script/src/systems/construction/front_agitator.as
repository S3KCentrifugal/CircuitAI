// FRONT forward area-control artillery (owner, 2026-11-01; Front::Agitator).
//
// Owner: "Each FRONT role should build an agitator (or equivalent for its faction) at its front mex or
// front porc spot if it has hit 50% metal in the last 2 minutes, and that front mex or front porc spot
// is at 40% map or further towards the enemy."
//
// The gun: Agitator corpun (Cortex), Gauntlet armguard (Armada), Amputator legcluster (Legion), the T1
// "Area Control Plasma Artillery" of each faction (AgitatorUnits). A builder takes its own faction's gun
// first, then any other it can build (traded constructors).
//
// Metal: the bank stood at AgitatorMetalShare (0.5; was 0.8 until 2026-11-02) of storage or more at some sample in the last
// AgitatorMetalWindowSeconds (120). Sampled on every economy update and every ask.
//
// Spot: our finished mexes (T1 or T2) and finished static land guns ("porc"; any non-mobile unit with a
// surface-to-land weapon, the agitators themselves left out), whose map share is AgitatorMapShare (0.4)
// or more. Map share: the spot's position along the lane axis (our allies' start centre toward the
// enemies' start centre), measured across the whole map in that direction: 0 at our edge of the map,
// 1 at the enemy's edge. A spot with an agitator of ours (finished or framed) within AgitatorCoverRadius
// is done. The most forward open spot gets the next order, so the guns follow the front out. A further
// agitator (any after the first standing one) waits until that spot is AgitatorAdvance (500) elmos further
// forward along the axis than our most forward agitator (owner, 2026-11-01 20:31Z); special porc does not.
//
// Builders: FRONT constructors that can build the gun (not commanders, not lolcannon crews), idle /
// guarding / assisting within AgitatorReach of the spot, or walking to an unframed build within
// AgitatorTakeRadius. One order at a time; at most AgitatorMax agitators of ours standing. An order
// that dies without a gun holds that spot (FailHoldSeconds x fails in a row; three, SpotHoldSeconds).
//
// Special porc (owner, 2026-11-01 20:20Z; Front::SpecialPorc): "add persecutors, razorbacks, and eviscerators
// as special porc for when metal is both above 50% and lowest metal per income last 10 seconds is above
// 100 for FRONT and the t2 lab is living." The T2 pop-up plasma artillery: Persecutor cortoast, Eviscerator
// legacluster, and for Armada Rattlesnake armamb (Razorback armraz is a gantry mech, not a turret).
// Same forward spots and rules as the agitators, own cover radius / cap, built by T2 constructors, gated
// by: bank above SpecialPorcMetalShare (0.5) of storage now, the 10 s minimum metal income above
// SpecialPorcMinMetalIncome (100), and one T2 bot lab or vehicle plant of ours standing.
//
// Cost: one owned-unit scan every AgitatorScanSeconds while the feature is on. Log [FRONT][Agitator].
namespace FrontAgitator {
    const int OrderTimeoutSeconds = 180;
    const int FailHoldSeconds = 20;
    const int SpotHoldSeconds = 180;
    const int AGITATOR = 0, SPECIAL = 1, KINDS = 2;
    const array<string> KindName = { "Agitator", "SpecialPorc" };

    class Spot {
        int id = -1;          // the mex or gun
        string defName;
        AIFloat3 pos;
        float share = 0.0f;
        bool mex = false;
    }
    class Kind {
        array<CCircuitDef@> guns;
        array<Spot@> open;    // sorted, most forward first
        int standing = 0;
        float forwardMost = -1e30f;   // the most forward of ours along the lane axis (elmos)
        IUnitTask@ order;
        int orderSpot = -1;
        dictionary fails;     // spot id -> fails in a row
        dictionary holds;     // spot id -> frame the hold ends
        string lastWhy = "";
    }
    array<Kind@> kinds;
    array<CCircuitDef@> t2Labs;
    int lastScan = -100000;
    int lastHigh = -1;        // last frame the bank stood at AgitatorMetalShare or more
    bool defsDone = false;

    bool AgitatorOn() { return Global::RoleSettings::Front::Agitator; }
    bool SpecialOn() { return Global::RoleSettings::Front::SpecialPorc; }
    bool On() { return (AgitatorOn() || SpecialOn()) && Global::AISettings::Role == AiRole::FRONT; }
    bool KindOn(int k) { return k == AGITATOR ? AgitatorOn() : SpecialOn(); }

    void Reset() {
        kinds.resize(0);
        for (int k = 0; k < KINDS; ++k) kinds.insertLast(Kind());
        t2Labs.resize(0);
        lastScan = -100000; lastHigh = -1;
        defsDone = false;
    }

    void Defs() {
        if (defsDone) return;
        defsDone = true;
        if (kinds.length() != uint(KINDS)) { Reset(); defsDone = true; }
        for (int k = 0; k < KINDS; ++k) {
            const array<string>@ names = (k == AGITATOR) ? Global::RoleSettings::Front::AgitatorUnits : Global::RoleSettings::Front::SpecialPorcUnits;
            for (uint i = 0; i < names.length(); ++i) {
                CCircuitDef@ d = ai.GetCircuitDef(names[i]);
                if (d !is null) kinds[k].guns.insertLast(d);
            }
        }
        array<string> labs = UnitHelpers::GetAllT2BotLabs();
        array<string> veh = UnitHelpers::GetAllT2VehicleLabs();
        for (uint i = 0; i < veh.length(); ++i) labs.insertLast(veh[i]);
        for (uint i = 0; i < labs.length(); ++i) {
            CCircuitDef@ d = ai.GetCircuitDef(labs[i]);
            if (d !is null) t2Labs.insertLast(d);
        }
    }

    int GunKind(const CCircuitDef@ d) {
        for (int k = 0; k < KINDS; ++k)
            for (uint i = 0; i < kinds[k].guns.length(); ++i) if (kinds[k].guns[i] is d) return k;
        return -1;
    }

    // Front_EconomyUpdate and every ask
    void Sample() {
        if (!On()) return;
        const float storage = aiEconomyMgr.metal.storage;
        if (storage > 0.0f && aiEconomyMgr.metal.current >= storage * Global::RoleSettings::Front::AgitatorMetalShare)
            lastHigh = ai.frame;
    }

    bool T2LabLiving() {
        for (uint i = 0; i < t2Labs.length(); ++i) if (t2Labs[i].count > 0) return true;
        return false;
    }

    // "" when the kind's metal gate is open, else why not
    string Gate(int k) {
        if (k == AGITATOR) {
            if (lastHigh >= 0 && ai.frame - lastHigh <= Global::RoleSettings::Front::AgitatorMetalWindowSeconds * SECOND) return "";
            return "metal bank not at " + int(Global::RoleSettings::Front::AgitatorMetalShare * 100.0f) + "% in the last "
                + Global::RoleSettings::Front::AgitatorMetalWindowSeconds + " s";
        }
        const float storage = aiEconomyMgr.metal.storage;
        if (storage <= 0.0f || aiEconomyMgr.metal.current <= storage * Global::RoleSettings::Front::SpecialPorcMetalShare)
            return "metal bank not above " + int(Global::RoleSettings::Front::SpecialPorcMetalShare * 100.0f) + "%";
        const float mi = Economy::GetMinMetalIncomeLast10s();
        if (mi <= Global::RoleSettings::Front::SpecialPorcMinMetalIncome)
            return "10 s minimum metal income +" + int(mi) + " not above +" + int(Global::RoleSettings::Front::SpecialPorcMinMetalIncome);
        if (!T2LabLiving()) return "no T2 lab standing";
        return "";
    }

    AIFloat3 Centre(const array<AIFloat3>& in points) {
        AIFloat3 p(0.0f, 0.0f, 0.0f);
        for (uint i = 0; i < points.length(); ++i) { p.x += points[i].x; p.z += points[i].z; }
        const float n = float(AiMax(1, int(points.length())));
        return AIFloat3(p.x / n, 0.0f, p.z / n);
    }

    // The lane axis as a unit direction and the map's span along it; false when there is none
    bool axisDone = false, axisOk = false;
    float ax = 0.0f, az = 0.0f, spanMin = 0.0f, spanMax = 1.0f;
    bool Axis() {
        if (axisDone) return axisOk;
        axisDone = true;
        array<AIFloat3> a = Lanes::AllyStarts(), b = Lanes::EnemyStarts();
        if (a.length() == 0 || b.length() == 0) return false;
        const AIFloat3 ours = Centre(a), theirs = Centre(b);
        const float dx = theirs.x - ours.x, dz = theirs.z - ours.z;
        const float d = sqrt(dx * dx + dz * dz);
        if (d < 64.0f) return false;
        ax = dx / d; az = dz / d;
        const float w = float(aiTerrainMgr.GetTerrainWidth()), h = float(aiTerrainMgr.GetTerrainHeight());
        const array<float> cx = { 0.0f, w, 0.0f, w }, cz = { 0.0f, 0.0f, h, h };
        spanMin = 1e30f; spanMax = -1e30f;
        for (uint i = 0; i < 4; ++i) {
            const float p = cx[i] * ax + cz[i] * az;
            spanMin = AiMin(spanMin, p); spanMax = AiMax(spanMax, p);
        }
        axisOk = spanMax - spanMin > 1.0f;
        GenericHelpers::LogUtil("[FRONT][Agitator] lane axis from (" + int(ours.x) + "," + int(ours.z) + ") to (" + int(theirs.x) + ","
            + int(theirs.z) + "); spots at " + int(Global::RoleSettings::Front::AgitatorMapShare * 100.0f) + "% of the map or further qualify", 1);
        return axisOk;
    }

    float Along(const AIFloat3 &in p) { return p.x * ax + p.z * az; }

    float Share(const AIFloat3 &in p) {
        return (p.x * ax + p.z * az - spanMin) / (spanMax - spanMin);
    }

    void Scan() {
        lastScan = ai.frame;
        for (int k = 0; k < KINDS; ++k) { kinds[k].open.resize(0); kinds[k].standing = 0; kinds[k].forwardMost = -1e30f; }
        if (!Axis()) return;
        array<array<AIFloat3>> placed(KINDS);
        array<Spot@> spots;
        const float minShare = Global::RoleSettings::Front::AgitatorMapShare;
        array<Id>@ ids = ai.GetOwnedUnitIds();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef is null) continue;
            const CCircuitDef@ d = u.circuitDef;
            const int gk = GunKind(d);
            if (gk >= 0) {   // ours, finished or framed
                ++kinds[gk].standing;
                const AIFloat3 gp = u.GetPos(ai.frame);
                placed[gk].insertLast(gp);
                kinds[gk].forwardMost = AiMax(kinds[gk].forwardMost, Along(gp));
                continue;
            }
            if (d.IsMobile() || u.GetBuildProgress() < 1.0f) continue;
            const bool mex = d.GetExtractsMetal() > 0.0f;
            if (!mex && !d.HasSurfToLand()) continue;
            const AIFloat3 p = u.GetPos(ai.frame);
            const float s = Share(p);
            if (s < minShare) continue;
            Spot@ sp = Spot();
            sp.id = u.id; sp.defName = d.GetName(); sp.pos = p; sp.share = s; sp.mex = mex;
            spots.insertLast(sp);
        }
        for (int k = 0; k < KINDS; ++k) {
            Kind@ kd = kinds[k];
            const float r = (k == AGITATOR) ? Global::RoleSettings::Front::AgitatorCoverRadius : Global::RoleSettings::Front::SpecialPorcCoverRadius;
            for (uint i = 0; i < spots.length(); ++i) {
                bool covered = false;
                for (uint q = 0; q < placed[k].length() && !covered; ++q) covered = MapHelpers::SqDist(spots[i].pos, placed[k][q]) <= r * r;
                if (covered) continue;
                uint at = 0;   // most forward first
                while (at < kd.open.length() && kd.open[at].share >= spots[i].share) ++at;
                kd.open.insertAt(at, spots[i]);
            }
            if (kd.order !is null && kd.order.IsDead()) @kd.order = null;
        }
    }

    void Refresh() {
        Defs();
        Sample();
        if (ai.frame - lastScan >= Global::RoleSettings::Front::AgitatorScanSeconds * SECOND) Scan();
    }

    // Front_BuilderAiTaskRemoved
    void TaskRemoved(IUnitTask@ task, bool done) {
        if (task is null) return;
        for (uint k = 0; k < kinds.length(); ++k) {
            Kind@ kd = kinds[k];
            if (kd.order !is task) continue;
            @kd.order = null;
            const string key = "" + kd.orderSpot;
            lastScan = -100000;   // the next ask rescans
            if (done) {
                kd.fails.delete(key);
                GenericHelpers::LogUtil("[FRONT][" + KindName[k] + "] built at spot " + kd.orderSpot, 1);
                return;
            }
            // an &out argument is overwritten even when the key is missing: check the result
            int n = 0;
            if (!kd.fails.get(key, n)) n = 0;
            ++n;
            if (n >= 3) {
                kd.holds.set(key, ai.frame + SpotHoldSeconds * SECOND);
                kd.fails.delete(key);
                GenericHelpers::LogUtil("[FRONT][" + KindName[k] + "] three orders at spot " + kd.orderSpot + " died with no gun; holding it " + SpotHoldSeconds + " s", 1);
            } else {
                kd.fails.set(key, n);
                kd.holds.set(key, ai.frame + FailHoldSeconds * n * SECOND);
            }
            return;
        }
    }

    void Why(Kind@ kd, int k, const string &in why) {
        if (why == kd.lastWhy) return;
        kd.lastWhy = why;
        GenericHelpers::LogUtil("[FRONT][" + KindName[k] + "] " + why, 2);
    }

    // The gun this builder makes: its own faction's first, then any other it can build
    CCircuitDef@ GunFor(Kind@ kd, CCircuitUnit@ u) {
        const string side = UnitHelpers::GetSideForUnitName(u.circuitDef.GetName());
        CCircuitDef@ other = null;
        for (uint i = 0; i < kd.guns.length(); ++i) {
            if (!u.circuitDef.CanBuild(kd.guns[i])) continue;
            if (UnitHelpers::GetSideForUnitName(kd.guns[i].GetName()) == side) return kd.guns[i];
            if (other is null) @other = kd.guns[i];
        }
        return other;
    }

    IUnitTask@ KindWork(int k, CCircuitUnit@ u, bool group = false) {
        Kind@ kd = kinds[k];
        CCircuitDef@ d = GunFor(kd, u);
        if (d is null) return null;   // this builder cannot make this kind's gun
        if (kd.order !is null && !kd.order.IsDead()) {
            // join the open order (two constructors at most)
            IBuilderTask@ b = cast<IBuilderTask>(kd.order);
            array<CCircuitUnit@>@ on = kd.order.GetUnits();
            if ((on is null || on.length() < 2) && b !is null && b.buildDef !is null && u.circuitDef.CanBuild(b.buildDef)
                && (group || FrontFactoryNanos::Free(u)) && MapHelpers::SqDist(u.GetPos(ai.frame), b.GetBuildPos()) <= 1500.0f * 1500.0f)
                return kd.order;
            return null;
        }
        if (kd.open.length() == 0) return null;
        const int cap = (k == AGITATOR) ? Global::RoleSettings::Front::AgitatorMax : Global::RoleSettings::Front::SpecialPorcMax;
        if (kd.standing >= cap) { Why(kd, k, "cap reached: " + kd.standing + " standing"); return null; }
        const string gate = Gate(k);
        if (gate != "") { Why(kd, k, "waiting: " + gate + " (" + kd.open.length() + " forward spots open)"); return null; }
        // owner 2026-11-01 20:31Z: a further agitator only once the most forward mex / turret is
        // AgitatorAdvance (500) elmos further forward along the lane axis than our most forward agitator
        const bool advanceGate = (k == AGITATOR && kd.standing > 0);
        const float needAlong = kd.forwardMost + Global::RoleSettings::Front::AgitatorAdvance;
        if (advanceGate && Along(kd.open[0].pos) < needAlong) {
            Why(kd, k, "waiting: most forward spot " + int(Along(kd.open[0].pos) - kd.forwardMost) + " elmos ahead of our most forward agitator, needs "
                + int(Global::RoleSettings::Front::AgitatorAdvance));
            return null;
        }
        const bool free = group || FrontFactoryNanos::Free(u);
        if (!free && !FrontFactoryNanos::Takeable(u)) return null;
        const float reach = group ? Global::RoleSettings::Front::AgitatorGroupReach
            : free ? Global::RoleSettings::Front::AgitatorReach : Global::RoleSettings::Front::AgitatorTakeRadius;
        const AIFloat3 wp = u.GetPos(ai.frame);
        for (uint i = 0; i < kd.open.length(); ++i) {
            Spot@ s = kd.open[i];
            if (advanceGate && Along(s.pos) < needAlong) break;   // sorted most forward first
            int until = -1;
            if (kd.holds.get("" + s.id, until) && ai.frame < until) continue;
            if (MapHelpers::SqDist(wp, s.pos) > reach * reach || ai.GetTeamUnit(s.id) is null) continue;
            if (!aiTerrainMgr.CanReachAt(u, s.pos, u.circuitDef.GetBuildDistance())) continue;
            if (d.maxThisUnit >= 0 && d.maxThisUnit <= d.count) d.maxThisUnit = d.count + 1;
            if (!d.IsAvailable(ai.frame)) return null;
            int n = 0;
            if (!kd.fails.get("" + s.id, n)) n = 0;
            const float shake = Global::RoleSettings::Front::AgitatorShake + 80.0f * float(n);
            @kd.order = aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::DEFENCE, Task::Priority::HIGH, d, s.pos, shake, true,
                OrderTimeoutSeconds * SECOND));
            if (kd.order is null) { kd.holds.set("" + s.id, ai.frame + FailHoldSeconds * SECOND); continue; }
            kd.orderSpot = s.id;
            kd.lastWhy = "";
            const string why = (k == AGITATOR)
                ? "bank hit " + int(Global::RoleSettings::Front::AgitatorMetalShare * 100.0f) + "% " + ((ai.frame - lastHigh) / SECOND) + " s ago"
                : "bank " + int(100.0f * aiEconomyMgr.metal.current / AiMax(1.0f, aiEconomyMgr.metal.storage)) + "%, 10 s min income +"
                    + int(Economy::GetMinMetalIncomeLast10s()) + ", T2 lab standing";
            GenericHelpers::LogUtil("[FRONT][" + KindName[k] + "] " + u.circuitDef.GetName() + " " + u.id + " orders " + d.GetName() + " at front "
                + (s.mex ? "mex " : "porc ") + s.defName + " " + s.id + " (" + int(s.pos.x) + "," + int(s.pos.z) + "), "
                + int(s.share * 100.0f) + "% of the map toward the enemy; " + why + "; " + kd.standing + " standing", 1);
            return kd.order;
        }
        return null;
    }

    // Front_BuilderAiMakeTask: special porc first (T2 constructors), then agitators
    IUnitTask@ Work(CCircuitUnit@ u) {
        if (!On() || u is null || u.circuitDef is null || FrontRecovery::Active()) return null;
        if (kinds.length() != uint(KINDS)) Reset();
        for (uint k = 0; k < kinds.length(); ++k) {
            IUnitTask@ t = kinds[k].order;
            if (t !is null && !t.IsDead() && u.task is t) return t;
        }
        if (UnitHelpers::IsCommander(u.circuitDef) || LolCannon::IsCrew(u.id)) return null;
        Refresh();
        for (int k = KINDS - 1; k >= 0; --k) {
            if (!KindOn(k)) continue;
            IUnitTask@ t = KindWork(k, u);
            if (t !is null) return t;
        }
        return null;
    }

    // The commander group's T1 constructor (FrontConstructors seat 2, the one that walks with the
    // FRONT commander and builds its front porc; owner, 2026-11-01 20:40Z). Native CommanderGroup work
    // reassigns it every second and FRONT's AiMakeTask never reaches Front_BuilderAiMakeTask for it,
    // so CommanderGroup::Update asks here each second: when an agitator is due within AgitatorGroupReach
    // of it and it is not finishing a framed build, it takes (or joins) the order; CommanderGroup then
    // unpublishes it from the native group (commander_group_unit -1) until the order ends.
    bool OnOrder(CCircuitUnit@ u) {
        if (u is null || u.task is null || u.task.IsDead()) return false;
        for (uint k = 0; k < kinds.length(); ++k) if (kinds[k].order is u.task) return true;
        return false;
    }
    IUnitTask@ GroupPull(CCircuitUnit@ u) {
        if (!On() || !Global::RoleSettings::Front::AgitatorGroupConstructor || u is null || u.circuitDef is null) return null;
        if (FrontRecovery::Active() || u.GetBuildProgress() < 1.0f) return null;
        if (kinds.length() != uint(KINDS)) Reset();
        if (OnOrder(u)) return u.task;
        IBuilderTask@ cur = cast<IBuilderTask>(u.task);
        if (cur !is null && !cur.IsDead() && cur.target !is null && cur.GetBuildType() < int(Task::BuildType::REPAIR)) return null;
        if (u.task !is null && (u.task.IsExternalControlled() || u.task.GetType() == int(Task::Type::PLAYER)
            || u.task.GetType() == int(Task::Type::RETREAT))) return null;
        Refresh();
        if (!AgitatorOn()) return null;
        IUnitTask@ t = KindWork(AGITATOR, u, true);
        if (t !is null) GenericHelpers::LogUtil("[FRONT][Agitator] commander group constructor " + u.circuitDef.GetName() + " " + u.id + " takes the agitator order", 1);
        return t;
    }
}
