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
// Metal (owner 2026-11-03): at least AgitatorMinMetalStock (1000) metal stockpiled right now, and the 10 s minimum
// metal income at least AgitatorMinMetalIncome (35). Replaces the old percent-of-storage gate (80%, then 50%,
// in the last 120 s).
//
// Spot: our finished mexes (T1 or T2) and finished static land guns ("porc"; any non-mobile unit with a
// surface-to-land weapon, the agitators themselves left out), whose map share is AgitatorMapShare (0.4)
// or more. Map share: the spot's position along the lane axis (our allies' start centre toward the
// enemies' start centre), measured across the whole map in that direction: 0 at our edge of the map,
// 1 at the enemy's edge. A spot with an agitator of ours (finished or framed) within AgitatorCoverRadius
// is done. The most forward open spot gets the next order, so the guns follow the front out. A further
// agitator (any after the first standing one) waits until that spot is AgitatorAdvance (500) elmos further
// forward along the axis than our most forward artillery (either tier).
//
// Builders: FRONT constructors that can build the gun (not commanders, not lolcannon crews), idle /
// guarding / assisting within AgitatorReach of the spot, or walking to an unframed build within
// AgitatorTakeRadius. One order at a time; at most AgitatorMax agitators of ours standing. An order
// that dies without a gun holds that spot (FailHoldSeconds x fails in a row; three, SpotHoldSeconds).
//
// Owner 2026-11-05: from 12 minutes and a 10-second minimum metal income >=65,
// new clusters use Rattlesnake / Persecutor / Eviscerator instead of T1 artillery.
// They share the stock, forward-spot, coverage, advance and preparation rules.
// Existing clusters finish their chosen tier. A traded T2 builder is sufficient;
// there is no separate percent-storage or own-T2-factory prerequisite.
//
// Cost: one owned-unit scan every AgitatorScanSeconds while the feature is on. Log [FRONT][Agitator].
namespace FrontAgitator {
    const int OrderTimeoutSeconds = 180;
    const int FailHoldSeconds = 20;
    const int SpotHoldSeconds = 180;
    const int AGITATOR = 0, SPECIAL = 1, KINDS = 2;
    const float PrepUnitTolerance = 16.0f; // owned-unit API returns model midpoints (Twin Guard +3.12 z)
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
        string orderWhat;
        dictionary fails;     // spot id -> fails in a row
        dictionary holds;     // spot id -> frame the hold ends
        string lastWhy = "";
    }
    array<Kind@> kinds;
    int lastScan = -100000;
    bool defsDone = false;
    int nextPrepPlan = -1; // failed quartet search: one bounded attempt per existing scan interval

    bool AgitatorOn() { return Global::RoleSettings::Front::Agitator; }
    bool SpecialOn() { return Global::RoleSettings::Front::SpecialPorc; }
    bool On() { return (AgitatorOn() || SpecialOn()) && Global::AISettings::Role == AiRole::FRONT; }
    bool UseT2At(int frame, float income) {
        return SpecialOn() && frame >= Global::RoleSettings::Front::SpecialPorcMinGameSeconds * SECOND
            && income >= Global::RoleSettings::Front::SpecialPorcMinMetalIncome;
    }
    int SelectedKind() { return UseT2At(ai.frame, Economy::GetMinMetalIncomeLast10s()) ? SPECIAL : AGITATOR; }
    bool KindOn(int k) { return k == SelectedKind() && (k == AGITATOR ? AgitatorOn() : SpecialOn()); }

    void Reset() {
        kinds.resize(0);
        for (int k = 0; k < KINDS; ++k) kinds.insertLast(Kind());
        ClearPrep();
        prepNanos.resize(0); prepLlts.resize(0); prepGuns.resize(0);
        lastScan = -100000;
        nextPrepPlan = -1;
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
        for (uint i = 0; i < Global::RoleSettings::Front::AgitatorPrepNanoUnits.length(); ++i) {
            CCircuitDef@ d = ai.GetCircuitDef(Global::RoleSettings::Front::AgitatorPrepNanoUnits[i]);
            if (d !is null) prepNanos.insertLast(d);
        }
        for (uint i = 0; i < Global::RoleSettings::Front::AgitatorPrepLltUnits.length(); ++i) {
            CCircuitDef@ d = ai.GetCircuitDef(Global::RoleSettings::Front::AgitatorPrepLltUnits[i]);
            if (d !is null) prepLlts.insertLast(d);
        }
        for (uint i = 0; i < Global::RoleSettings::Front::AgitatorPrepGunUnits.length(); ++i) {
            CCircuitDef@ d = ai.GetCircuitDef(Global::RoleSettings::Front::AgitatorPrepGunUnits[i]);
            if (d !is null) prepGuns.insertLast(d);
        }
    }

    bool InDefs(const array<CCircuitDef@>& in defs, const CCircuitDef@ d) {
        for (uint i = 0; i < defs.length(); ++i) if (defs[i] is d) return true;
        return false;
    }
    bool Near(const array<AIFloat3>& in at, const AIFloat3 &in p, float r) {
        for (uint i = 0; i < at.length(); ++i) if (MapHelpers::SqDist(at[i], p) <= r * r) return true;
        return false;
    }
    // The builder's own faction's def from a list first, then any it can build
    CCircuitDef@ PickFor(const array<CCircuitDef@>& in defs, CCircuitUnit@ u) {
        const string side = UnitHelpers::GetSideForUnitName(u.circuitDef.GetName());
        CCircuitDef@ other = null;
        for (uint i = 0; i < defs.length(); ++i) {
            if (!u.circuitDef.CanBuild(defs[i])) continue;
            if (UnitHelpers::GetSideForUnitName(defs[i].GetName()) == side) return defs[i];
            if (other is null) @other = defs[i];
        }
        return other;
    }

    int GunKind(const CCircuitDef@ d) {
        for (int k = 0; k < KINDS; ++k)
            for (uint i = 0; i < kinds[k].guns.length(); ++i) if (kinds[k].guns[i] is d) return k;
        return -1;
    }

    // Front_EconomyUpdate and every ask
    void Sample() {
        if (!On()) return;
        // nothing to sample since 2026-11-03: the agitator gate reads the bank as it stands
    }

    // "" when the kind's metal gate is open, else why not
    string Gate(int k) {
        {
            // owner 2026-11-02 17:20Z: the 10 s minimum metal income at least AgitatorMinMetalIncome (35), all factions
            const float ami = Economy::GetMinMetalIncomeLast10s();
            const float minimum = k == SPECIAL ? Global::RoleSettings::Front::SpecialPorcMinMetalIncome : Global::RoleSettings::Front::AgitatorMinMetalIncome;
            if (k == SPECIAL && ai.frame < Global::RoleSettings::Front::SpecialPorcMinGameSeconds * SECOND) return "waiting for T2 artillery time";
            if (ami < minimum) return "10 s minimum metal income below +" + int(minimum);
            // owner 2026-11-03: at least AgitatorMinMetalStock (1000) metal stockpiled, instead of a percent of storage
            if (aiEconomyMgr.metal.current >= Global::RoleSettings::Front::AgitatorMinMetalStock) return "";
            return "metal bank " + int(aiEconomyMgr.metal.current) + " below " + int(Global::RoleSettings::Front::AgitatorMinMetalStock);
        }
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

    // owner 2026-11-02 15:56Z: "if a single FRONT builds a third agitator and similar, it should reclaim the
    // furthest back agitator. This is for commander group." Once AgitatorReclaimAt (3) of our agitators stand
    // finished, the commander group's T1 constructor reclaims the one furthest back along the lane axis.
    // Owner 2026-11-05: nano, LLT, Beamer/Twin Guard/Cacophony, artillery.
    // Both guns face the enemy ahead of the artillery and nano. All three
    // structures must fit inside the nano's loaded build distance. One owner
    // retains the exact formation through callbacks, repairs and tier changes.
    array<CCircuitDef@> prepNanos, prepLlts, prepGuns;

    // One artillery project owns four exact slots, never borrowed unit handles.
    // Slot planning is bounded (nine quartets per failed spot, then backoff).
    // The existing five-second census resolves at most four IDs per owned unit;
    // task completion invalidates it. No additional owned-unit scan or cadence.
    class PrepLayout {
        int kind = AGITATOR, spot = -1;
        array<CCircuitDef@> defs(4); // nano, LLT, faction light gun, artillery
        array<AIFloat3> pos(4);
        array<int> slots = { -1, -1, -1, -1 };
        array<int> units = { -1, -1, -1, -1 };
    }
    PrepLayout@ prep;

    void ClearPrep() {
        if (prep !is null)
            for (uint i = 0; i < prep.slots.length(); ++i)
                if (prep.slots[i] >= 0) aiTerrainMgr.ReleaseReservation(prep.slots[i]);
        @prep = null;
    }

    bool Geometry(const array<AIFloat3>& in p, float range) {
        if (p.length() != 4 || range <= 0.0f) return false;
        // Both defensive guns must remain in front of BOTH rear structures.
        const float rear = AiMax(Along(p[0]), Along(p[3]));
        if (Along(p[1]) <= rear || Along(p[2]) <= rear) return false;
        const float reach = range - Global::RoleSettings::Front::AgitatorPrepRangeMargin;
        if (reach <= 0.0f) return false;
        for (uint i = 1; i < 4; ++i) {
            const float dy = p[i].y - p[0].y;
            if (MapHelpers::SqDist(p[0], p[i]) + dy * dy > reach * reach) return false;
        }
        return true;
    }

    bool PlanPrep(int k, Spot@ s, CCircuitUnit@ u, CCircuitDef@ gun) {
        CCircuitDef@ nano = PrepDef(prepNanos, gun);
        CCircuitDef@ llt = PrepDef(prepLlts, gun);
        CCircuitDef@ light = PrepDef(prepGuns, gun);
        if (nano is null || llt is null || light is null || gun is null || !Axis()) return false;
        const bool enabled = aiTerrainMgr.IsLayoutEnabled();
        if (!enabled && !aiTerrainMgr.SetLayoutEnabled(true)) return false;
        PrepLayout@ plan = PrepLayout();
        plan.kind = k; plan.spot = s.id;
        @plan.defs[0] = nano; @plan.defs[1] = llt; @plan.defs[2] = light; @plan.defs[3] = gun;
        bool found = false;
        // Translate the complete formation together; failed individual sites
        // never independently drift into the rear row or out of nano reach.
        for (int attempt = 0; attempt < 9 && !found; ++attempt) {
            const float across = float(attempt % 3 - 1) * 128.0f;
            const float along = float(attempt / 3 - 1) * 128.0f;
            const AIFloat3 c(s.pos.x - az * across + ax * along, 0.0f, s.pos.z + ax * across + az * along);
            const float front = Global::RoleSettings::Front::AgitatorPrepFront;
            const float back = Global::RoleSettings::Front::AgitatorPrepBack;
            const float side = Global::RoleSettings::Front::AgitatorPrepGunSide;
            const float ns = Global::RoleSettings::Front::AgitatorPrepNanoSide;
            plan.pos[0] = AIFloat3(c.x - ax * back - az * ns, 0.0f, c.z - az * back + ax * ns);
            plan.pos[1] = AIFloat3(c.x + ax * front + az * side, 0.0f, c.z + az * front - ax * side);
            plan.pos[2] = AIFloat3(c.x + ax * front - az * side, 0.0f, c.z + az * front + ax * side);
            plan.pos[3] = AIFloat3(c.x - ax * back, 0.0f, c.z - az * back);
            bool ok = Geometry(plan.pos, nano.GetBuildDistance());
            for (uint j = 0; j < 4 && ok; ++j) {
                if (!aiTerrainMgr.CanReachAt(u, plan.pos[j], u.circuitDef.GetBuildDistance())) { ok = false; break; }
                plan.slots[j] = aiTerrainMgr.ReserveBuilding(plan.defs[j], plan.pos[j], 0);
                ok = plan.slots[j] >= 0;
                if (ok) plan.pos[j] = aiTerrainMgr.GetReservationPos(plan.slots[j]);
            }
            found = ok && Geometry(plan.pos, nano.GetBuildDistance());
            if (!found) {
                for (uint j = 0; j < 4; ++j) {
                    if (plan.slots[j] >= 0) aiTerrainMgr.ReleaseReservation(plan.slots[j]);
                    plan.slots[j] = -1;
                }
            }
        }
        if (!enabled) aiTerrainMgr.SetLayoutEnabled(false);
        if (!found) return false;
        @prep = plan;
        GenericHelpers::LogUtil("[FRONT][" + KindName[k] + "] reserved four-step cluster spot=" + s.id
            + " nano range=" + int(nano.GetBuildDistance()) + " gun=" + gun.GetName(), 1);
        return true;
    }

    // T1 crew can prepare the chosen faction's cluster for a T2 gun builder.
    // Each actual step still requires its assignee to be able to build it.
    CCircuitDef@ PrepDef(const array<CCircuitDef@>& in defs, CCircuitDef@ gun) {
        if (gun is null) return null;
        const string side = UnitHelpers::GetSideForUnitName(gun.GetName());
        for (uint i = 0; i < defs.length(); ++i)
            if (UnitHelpers::GetSideForUnitName(defs[i].GetName()) == side) return defs[i];
        return null;
    }

    IUnitTask@ PrepWork(CCircuitUnit@ u) {
        PrepLayout@ plan = prep;
        if (plan is null || u is null || u.circuitDef is null) return null;
        Kind@ kd = kinds[plan.kind];
        int until = -1;
        if (kd.holds.get("" + plan.spot, until) && ai.frame < until) return null;
        for (uint j = 0; j < 4; ++j) {
            CCircuitUnit@ built = ai.GetTeamUnit(plan.units[j]);
            if (built !is null && built.circuitDef is plan.defs[j] && MapHelpers::SqDist(built.GetPos(ai.frame), plan.pos[j]) <= PrepUnitTolerance * PrepUnitTolerance) {
                if (built.GetBuildProgress() >= 1.0f) continue;
            } else @built = null;
            CCircuitDef@ d = plan.defs[j];
            if (d is null || !u.circuitDef.CanBuild(d)
                || !aiTerrainMgr.CanReachAt(u, plan.pos[j], u.circuitDef.GetBuildDistance())) return null;
            IUnitTask@ task;
            if (built !is null) {
                @task = aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::HIGH, built, OrderTimeoutSeconds * SECOND));
            } else {
                // Consumed/destroyed reservations are recreated only at the
                // same planned footprint. Never issue an unpinned fallback.
                int slot = plan.slots[j];
                const int state = aiTerrainMgr.GetReservationState(slot);
                if (state != 0) {
                    if (state == 1) return null; // still owned by a live task
                    if (slot >= 0) aiTerrainMgr.ReleaseReservation(slot);
                    const bool enabled = aiTerrainMgr.IsLayoutEnabled();
                    if (!enabled && !aiTerrainMgr.SetLayoutEnabled(true)) return null;
                    slot = aiTerrainMgr.ReserveBuilding(d, plan.pos[j], 0);
                    if (!enabled) aiTerrainMgr.SetLayoutEnabled(false);
                    plan.slots[j] = slot;
                }
                if (slot < 0) { kd.holds.set("" + plan.spot, ai.frame + FailHoldSeconds * SECOND); return null; }
                if (d.maxThisUnit >= 0 && d.maxThisUnit <= d.count) d.maxThisUnit = d.count + 1;
                if (!d.IsAvailable(ai.frame)) return null;
                @task = aiBuilderMgr.Enqueue(TaskB::Common(j == 0 ? Task::BuildType::NANO : Task::BuildType::DEFENCE,
                    Task::Priority::HIGH, d, plan.pos[j], 0.0f, true, OrderTimeoutSeconds * SECOND));
                if (task !is null && !AiPinReservation(task, slot)) { aiBuilderMgr.AbortTask(task); @task = null; }
            }
            if (task is null || task.IsDead()) { kd.holds.set("" + plan.spot, ai.frame + FailHoldSeconds * SECOND); return null; }
            @kd.order = task; kd.orderSpot = plan.spot; kd.orderWhat = d.GetName();
            GenericHelpers::LogUtil("[FRONT][" + KindName[plan.kind] + "] step " + (j + 1) + " of 4 orders " + d.GetName()
                + " at (" + int(plan.pos[j].x) + "," + int(plan.pos[j].z) + ") spot=" + plan.spot, 1);
            return task;
        }
        ClearPrep();
        return null;
    }

    int finishedAgitators = 0;
    int backmostAgitator = -1;
    IUnitTask@ reclaim;
    int reclaimTarget = -1;
    int reclaimHoldUntil = -1;

    void Scan() {
        lastScan = ai.frame;
        finishedAgitators = 0;
        backmostAgitator = -1;
        float backmostAlong = 1e30f;
        if (prep !is null) for (uint j = 0; j < 4; ++j) prep.units[j] = -1;
        for (int k = 0; k < KINDS; ++k) { kinds[k].open.resize(0); kinds[k].standing = 0; kinds[k].forwardMost = -1e30f; }
        if (!Axis()) return;
        array<AIFloat3> placed;
        array<Spot@> spots;
        const float minShare = Global::RoleSettings::Front::AgitatorMapShare;
        array<Id>@ ids = ai.GetOwnedUnitIds();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef is null) continue;
            const CCircuitDef@ d = u.circuitDef;
            if (prep !is null)
                for (uint j = 0; j < 4; ++j)
                    if (d is prep.defs[j] && MapHelpers::SqDist(u.GetPos(ai.frame), prep.pos[j]) <= PrepUnitTolerance * PrepUnitTolerance) prep.units[j] = u.id;
            const int gk = GunKind(d);
            if (gk >= 0) {   // ours, finished or framed
                ++kinds[gk].standing;
                const AIFloat3 gp = u.GetPos(ai.frame);
                placed.insertLast(gp);
                kinds[gk].forwardMost = AiMax(kinds[gk].forwardMost, Along(gp));
                if (u.GetBuildProgress() >= 1.0f) {
                    ++finishedAgitators;
                    if (Along(gp) < backmostAlong) { backmostAlong = Along(gp); backmostAgitator = u.id; }
                }
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
        const int total = kinds[AGITATOR].standing + kinds[SPECIAL].standing;
        const float most = AiMax(kinds[AGITATOR].forwardMost, kinds[SPECIAL].forwardMost);
        for (int k = 0; k < KINDS; ++k) {
            Kind@ kd = kinds[k];
            kd.standing = total; kd.forwardMost = most;
            const float r = (k == AGITATOR) ? Global::RoleSettings::Front::AgitatorCoverRadius : Global::RoleSettings::Front::SpecialPorcCoverRadius;
            for (uint i = 0; i < spots.length(); ++i) {
                bool covered = false;
                for (uint q = 0; q < placed.length() && !covered; ++q) covered = MapHelpers::SqDist(spots[i].pos, placed[q]) <= r * r;
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
        if (reclaim is task) {
            @reclaim = null;
            lastScan = -100000;
            GenericHelpers::LogUtil("[FRONT][Agitator] reclaim of the furthest-back agitator " + reclaimTarget + (done ? " done" : " ended unfinished"), 1);
            if (!done) reclaimHoldUntil = ai.frame + FailHoldSeconds * SECOND;
            return;
        }
        for (uint k = 0; k < kinds.length(); ++k) {
            Kind@ kd = kinds[k];
            if (kd.order !is task) continue;
            @kd.order = null;
            const string key = "" + kd.orderSpot;
            lastScan = -100000;   // the next ask rescans
            if (done) {
                kd.fails.delete(key);
                GenericHelpers::LogUtil("[FRONT][" + KindName[k] + "] built " + kd.orderWhat + " at spot " + kd.orderSpot, 1);
                if (prep !is null && int(k) == prep.kind && kd.orderWhat == prep.defs[3].GetName()) ClearPrep();
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
        if (kd.order !is null && !kd.order.IsDead()) {
            // join the open order (two constructors at most)
            IBuilderTask@ b = cast<IBuilderTask>(kd.order);
            array<CCircuitUnit@>@ on = kd.order.GetUnits();
            if ((on is null || on.length() < 2) && b !is null && (b.buildDef is null || u.circuitDef.CanBuild(b.buildDef))
                && (group || FrontFactoryNanos::Free(u)) && MapHelpers::SqDist(u.GetPos(ai.frame), b.GetBuildPos()) <= 1500.0f * 1500.0f)
                return kd.order;
            return null;
        }
        // A committed cluster finishes the selected tier through income/time
        // changes and nanoframe coverage. IDs are resolved by the same census.
        if (prep !is null) {
            if (prep.kind != k) return null;
            if (ai.GetTeamUnit(prep.spot) is null) { ClearPrep(); return null; }
            return PrepWork(u);
        }
        if (d is null) return null;   // no artillery this builder can start
        if (kd.open.length() == 0) return null;
        const int cap = (k == AGITATOR) ? Global::RoleSettings::Front::AgitatorMax : Global::RoleSettings::Front::SpecialPorcMax;
        if (kd.standing >= cap) { Why(kd, k, "cap reached: " + kd.standing + " standing"); return null; }
        const string gate = Gate(k);
        if (gate != "") { Why(kd, k, "waiting: " + gate + " (" + kd.open.length() + " forward spots open)"); return null; }
        // owner 2026-11-01 20:31Z: a further agitator only once the most forward mex / turret is
        // AgitatorAdvance (500) elmos further forward along the lane axis than our most forward agitator
        const bool advanceGate = kd.standing > 0;
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
        if (Global::RoleSettings::Front::AgitatorPrep && ai.frame < nextPrepPlan) return null;
        for (uint i = 0; i < kd.open.length(); ++i) {
            Spot@ s = kd.open[i];
            if (advanceGate && Along(s.pos) < needAlong) break;   // sorted most forward first
            int until = -1;
            if (kd.holds.get("" + s.id, until) && ai.frame < until) continue;
            if (MapHelpers::SqDist(wp, s.pos) > reach * reach || ai.GetTeamUnit(s.id) is null) continue;
            if (!aiTerrainMgr.CanReachAt(u, s.pos, u.circuitDef.GetBuildDistance())) continue;
            // One formation and build chain for either selected artillery tier.
            if (Global::RoleSettings::Front::AgitatorPrep) {
                if (!PlanPrep(k, s, u, d)) {
                    kd.holds.set("" + s.id, ai.frame + FailHoldSeconds * SECOND);
                    nextPrepPlan = ai.frame + Global::RoleSettings::Front::AgitatorScanSeconds * SECOND;
                    return null;
                }
                return PrepWork(u);
            }
            CCircuitDef@ what = d;
            string step = "";
            if (what.maxThisUnit >= 0 && what.maxThisUnit <= what.count) what.maxThisUnit = what.count + 1;
            if (!what.IsAvailable(ai.frame)) return null;
            int n = 0;
            if (!kd.fails.get("" + s.id, n)) n = 0;
            const float shake = Global::RoleSettings::Front::AgitatorShake + 80.0f * float(n);
            const Task::BuildType bt = (what is d) ? Task::BuildType::DEFENCE
                : InDefs(prepNanos, what) ? Task::BuildType::NANO : Task::BuildType::DEFENCE;
            @kd.order = aiBuilderMgr.Enqueue(TaskB::Common(bt, Task::Priority::HIGH, what, s.pos, shake, true,
                OrderTimeoutSeconds * SECOND));
            if (kd.order is null) { kd.holds.set("" + s.id, ai.frame + FailHoldSeconds * SECOND); continue; }
            kd.orderSpot = s.id;
            kd.orderWhat = what.GetName();
            kd.lastWhy = "";
            const string why = (k == AGITATOR)
                ? "bank " + int(aiEconomyMgr.metal.current) + ", 10 s min income +" + int(Economy::GetMinMetalIncomeLast10s())
                : "T2 artillery, 10 s min income +" + int(Economy::GetMinMetalIncomeLast10s());
            GenericHelpers::LogUtil("[FRONT][" + KindName[k] + "] " + u.circuitDef.GetName() + " " + u.id + " orders " + what.GetName() + step + " at front "
                + (s.mex ? "mex " : "porc ") + s.defName + " " + s.id + " (" + int(s.pos.x) + "," + int(s.pos.z) + "), "
                + int(s.share * 100.0f) + "% of the map toward the enemy; " + why + "; " + kd.standing + " standing", 1);
            return kd.order;
        }
        return null;
    }

    // Front_BuilderAiMakeTask: finish the committed project, otherwise select
    // the current tier. T1 and T2 constructors can perform different steps.
    IUnitTask@ Work(CCircuitUnit@ u) {
        if (!On() || u is null || u.circuitDef is null || FrontRecovery::Active()) return null;
        if (kinds.length() != uint(KINDS)) Reset();
        for (uint k = 0; k < kinds.length(); ++k) {
            IUnitTask@ t = kinds[k].order;
            if (t !is null && !t.IsDead() && u.task is t) return t;
        }
        if (UnitHelpers::IsCommander(u.circuitDef) || LolCannon::IsCrew(u.id)) return null;
        Refresh();
        if (prep !is null) return KindWork(prep.kind, u);
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
        return reclaim !is null && reclaim is u.task;
    }

    // The group constructor reclaims our furthest-back agitator once AgitatorReclaimAt stand finished
    IUnitTask@ ReclaimBackmost(CCircuitUnit@ u) {
        const int at = Global::RoleSettings::Front::AgitatorReclaimAt;
        if (at <= 0 || finishedAgitators < at || ai.frame < reclaimHoldUntil) return null;
        if (reclaim !is null && !reclaim.IsDead()) return null;
        @reclaim = null;
        CCircuitUnit@ back = ai.GetTeamUnit(backmostAgitator);
        if (back is null || back.GetBuildProgress() < 1.0f) return null;
        @reclaim = aiBuilderMgr.Enqueue(TaskB::Reclaim(Task::Priority::HIGH, back, 180 * SECOND));
        if (reclaim is null) {
            reclaimHoldUntil = ai.frame + 60 * SECOND;
            GenericHelpers::LogUtil("[FRONT][Agitator] reclaim of agitator " + back.id + " refused natively; retry in 60 s", 1);
            return null;
        }
        reclaimTarget = back.id;
        const AIFloat3 bp = back.GetPos(ai.frame);
        GenericHelpers::LogUtil("[FRONT][Agitator] " + finishedAgitators + " agitators standing: commander group constructor " + u.circuitDef.GetName()
            + " " + u.id + " reclaims the furthest back, " + back.circuitDef.GetName() + " " + back.id + " (" + int(bp.x) + "," + int(bp.z) + "), "
            + int(Share(bp) * 100.0f) + "% of the map", 1);
        return reclaim;
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
        IUnitTask@ r = ReclaimBackmost(u);
        if (r !is null) return r;
        IUnitTask@ t = KindWork(prep !is null ? prep.kind : SelectedKind(), u, true);
        if (t !is null) GenericHelpers::LogUtil("[FRONT][Agitator] commander group constructor " + u.circuitDef.GetName() + " " + u.id + " takes the agitator order", 1);
        return t;
    }
}
