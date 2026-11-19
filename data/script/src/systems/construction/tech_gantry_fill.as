#include "../../helpers/construction/support_site_helpers.as"

// TECH gantry fill (owner, 2026-11-19; Tech::GantryFill*). "All gantries should eventually climb to 40
// turrets, within the 5 minutes after the gantry finishes building." Played Scylla and Charybdis 11-19
// (AI 8, t3rush): the first gantry rolled 18 turrets on a 32-slot block; once it stood the t3rush ramp
// climbed toward the block size (32, never 40), its orders went out through rule gantry.support behind
// the shared turret cap (Layout::TurretsCapped, sized by build power at the base, not at the forward
// gantry) and stopped near 24 by 26:00; the 2nd and 3rd gantries had no climb at all and stayed at
// FrontT3TurretsFirst = 10. Now, as FRONT's caretakers do (front_gantry_nanos.as):
//   - every land or water gantry of ours that finishes gets GantryFillTurrets turrets in all (standing
//     turrets within GantryFillRadius count, unless another factory of ours is nearer);
//   - its orders go to the free slots of the TECH cluster's own turret block first, then to blocks
//     reserved beside the gantry (ReserveNanoBlockAt with the facing turned a quarter, so the exit
//     stays clear), then to engine-sited turrets beside it; the shared turret cap does not hold them
//     (at most GantryFillParallel open per gantry);
//   - up to GantryFillCons T1 constructors (land within GantryFillReach, air from anywhere; idle ones
//     first, never one on a factory frame, steered, or owned by another TECH program) are requisitioned
//     with AssignTask; each gets a turret order, else helps a turret frame of the gantry; when every
//     gantry is full they go back to the idle pool.
// Null guards: every unit is held by id and resolved with ai.GetTeamUnit at each use; every task is
// checked for null / IsDead before it is assigned, compared or aborted.
// Cost: while a finished gantry of ours is short, one owned-unit scan every GantryFillScanSeconds; else
// every RecheckSeconds. Log [TECH][GantryFill]: at the finish, +2 min, +5 min and when complete.
namespace TechGantryFill {
    const int RecheckSeconds = 30;
    const int OrderTimeoutSeconds = 120;
    const int HelpTimeoutSeconds = 30;
    const int GiveLimit = 6;           // hand-outs of one order before it is dropped
    const int OrphanSeconds = 5;       // an order nobody is on this long after it was handed out is free to take
    const int FallbackFailLimit = 6;   // pinned orders dying unframed in a row before engine-sited turrets

    // beside-the-gantry block shapes, biggest useful first (cols, rows)
    const array<int> Shapes = { 8, 2, 6, 2, 5, 2, 4, 2, 3, 2, 4, 1, 3, 1, 2, 1 };

    bool On() {
        return Global::AISettings::Role == AiRole::TECH && Global::RoleSettings::Tech::GantryFillTurrets > 0;
    }

    class Gantry {
        int id = -1;
        string defName;
        AIFloat3 pos;
        int facing = 0;
        int want = 0;
        int clusterGroup = -1;  // the TECH cluster's own turret block
        array<int> groups;      // blocks reserved beside the gantry
        bool reserved = false;
        int standing = 0;
        int framed = 0;
        int finishFrame = -1;
        int startStanding = -1;
        int completeFrame = -1;
        int fails = 0;
        int onBlock = 0, onSide = 0, sited = 0;
        bool alive = true;
        bool log2 = false, log5 = false;
    }
    array<Gantry@> gantries;

    array<IUnitTask@> orders;
    array<int> orderGantry;
    array<int> orderGiven;
    array<int> orderFrame;
    array<IUnitTask@> helps;
    array<int> helpGantry;
    array<IUnitTask@> ownAborts;
    array<int> cons;

    CCircuitDef@ nanoDef = null;
    array<CCircuitDef@> gantryDefs;
    array<CCircuitUnit@> scanNanos;
    array<int> scanCons;
    int lastScan = -100000;
    int lastLog = -100000;

    void Defs() {
        if (nanoDef !is null) return;
        @nanoDef = ai.GetCircuitDef(UnitHelpers::GetT1NanoNameForSide(Global::AISettings::Side));
        array<string> names = UnitHelpers::GetAllLandGantries();
        array<string> water = UnitHelpers::GetAllWaterGantries();
        for (uint i = 0; i < water.length(); ++i) names.insertLast(water[i]);
        for (uint i = 0; i < names.length(); ++i) {
            CCircuitDef@ d = ai.GetCircuitDef(names[i]);
            if (d !is null && gantryDefs.findByRef(d) < 0) gantryDefs.insertLast(d);
        }
    }

    int GantryCount() {
        int n = 0;
        for (uint i = 0; i < gantryDefs.length(); ++i) n += gantryDefs[i].count;
        return n;
    }
    Gantry@ Find(int id) {
        for (uint i = 0; i < gantries.length(); ++i) if (gantries[i].id == id) return gantries[i];
        return null;
    }
    bool Live(IUnitTask@ t) { return t !is null && !t.IsDead(); }
    void Abort(IUnitTask@ t) {
        if (!Live(t)) return;
        if (ownAborts.findByRef(t) < 0) ownAborts.insertLast(t);
        aiBuilderMgr.AbortTask(t);
    }
    int LiveOrders(int gid) {
        int n = 0;
        for (uint i = 0; i < orders.length(); ++i) if (orderGantry[i] == gid && Live(orders[i])) ++n;
        return n;
    }
    int Committed(Gantry@ g) { return g.standing + AiMax(g.framed, LiveOrders(g.id)); }
    bool Short(Gantry@ g) { return g.alive && g.finishFrame >= 0 && g.standing < g.want; }
    bool IsOurs(IUnitTask@ t) {
        if (!Live(t)) return false;
        for (uint i = 0; i < orders.length(); ++i) if (orders[i] is t) return true;
        for (uint i = 0; i < helps.length(); ++i) if (helps[i] is t) return true;
        return false;
    }
    bool IsCon(int id) { return cons.find(id) >= 0; }
    void Release(int id, const string &in why) {
        const int k = cons.find(id);
        if (k < 0) return;
        cons.removeAt(k);
        GenericHelpers::LogUtil("[TECH][GantryFill] constructor " + id + " back to the idle pool: " + why, 2);
    }
    string Clock(int frame) { const int sec = frame / SECOND; return "" + (sec / 60) + ":" + (sec % 60 < 10 ? "0" : "") + (sec % 60); }

    // ------------------------------------------------------------ blocks

    void ReleaseBlock(int group) {
        if (group <= 0) return;
        const int zone = aiTerrainMgr.GetGroupZone(group);
        if (zone > 0) aiTerrainMgr.ReleaseZone(zone); else aiTerrainMgr.ReleaseGroup(group);
    }
    int ClusterGroup(int gantryId) {
        for (uint i = 0; i < TechFactories::clusters.length(); ++i) {
            TechFactories::Cluster@ c = TechFactories::clusters[i];
            if (c !is null && c.labId == gantryId && c.nanoGroup > 0) return c.nanoGroup;
        }
        return -1;
    }
    int FreeIn(int group) { return group > 0 ? aiTerrainMgr.GetGroupCount(group, true) : 0; }

    // Blocks beside the gantry for what the cluster block cannot hold; once, when first needed
    void Reserve(Gantry@ g) {
        if (g.reserved || nanoDef is null) return;
        g.reserved = true;
        CCircuitUnit@ unit = ai.GetTeamUnit(g.id);
        if (unit is null || unit.circuitDef is null) return;
        int need = g.want - Committed(g) - FreeIn(g.clusterGroup);
        if (need <= 0) return;
        const bool layoutOn = aiTerrainMgr.IsLayoutEnabled();
        if (!layoutOn && !aiTerrainMgr.SetLayoutEnabled(true)) return;
        const array<int> turns = { 1, 3 };
        string where = "";
        int held = 0;
        for (uint t = 0; t < turns.length() && need > 0; ++t) {
            const int facing = (g.facing + turns[t]) % 4;
            int best = 0, bestN = 0, bestC = 0, bestR = 0;
            for (uint s = 0; s + 1 < Shapes.length(); s += 2) {
                const int c = Shapes[s], r = Shapes[s + 1];
                if (c * r < need && bestN >= need) continue;
                const int grp = aiTerrainMgr.ReserveNanoBlockAt(nanoDef, unit.circuitDef, g.pos, facing, c, r, 0);
                const int n = grp > 0 ? aiTerrainMgr.GetGroupCount(grp, false) : 0;
                if (n > bestN) {
                    if (best > 0) ReleaseBlock(best);
                    best = grp; bestN = n; bestC = c; bestR = r;
                    if (n >= need) break;
                } else if (grp > 0) ReleaseBlock(grp);
            }
            if (best <= 0) continue;
            g.groups.insertLast(best); held += bestN; need -= bestN;
            where += (where.length() > 0 ? ", " : "") + bestC + "x" + bestR + " holds " + bestN;
        }
        if (!layoutOn) aiTerrainMgr.SetLayoutEnabled(false);
        GenericHelpers::LogUtil("[TECH][GantryFill] " + g.defName + " " + g.id + ": blocks beside it " + (where.length() > 0 ? where : "none")
            + " (" + held + " slots" + (need > 0 ? ", " + need + " engine-sited)" : ")"), 1);
    }

    int Slot(CCircuitUnit@ u, Gantry@ g, bool &out side) {
        side = false;
        if (u is null || g is null || nanoDef is null) return -1;
        int slot = SupportSites::Nearest(u, nanoDef, g.clusterGroup, g.pos);
        if (slot >= 0) return slot;
        Reserve(g);
        int best = -1;
        float bestSq = 1.0e12f;
        for (uint i = 0; i < g.groups.length(); ++i) {
            const int s = SupportSites::Nearest(u, nanoDef, g.groups[i], g.pos);
            if (s < 0) continue;
            const float sq = MapHelpers::SqDist(u.GetPos(ai.frame), aiTerrainMgr.GetReservationPos(s));
            if (sq < bestSq) { bestSq = sq; best = s; }
        }
        side = best >= 0;
        return best;
    }

    // ------------------------------------------------------------ scan

    void Scan() {
        lastScan = ai.frame;
        for (uint i = 0; i < gantries.length(); ++i) { gantries[i].alive = false; gantries[i].standing = 0; gantries[i].framed = 0; }
        scanNanos.resize(0); scanCons.resize(0);
        array<Id>@ ids = ai.GetOwnedUnitIds();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef is null) continue;
            const CCircuitDef@ d = u.circuitDef;
            if (d is nanoDef) { scanNanos.insertLast(u); continue; }
            if (d.IsMobile()) {
                if (!UnitHelpers::IsCommander(d) && UnitHelpers::GetConstructorTier(d) == 1 && nanoDef !is null && d.CanBuild(nanoDef))
                    scanCons.insertLast(u.id);
                continue;
            }
            bool isGantry = false;
            for (uint k = 0; k < gantryDefs.length() && !isGantry; ++k) isGantry = (d is gantryDefs[k]);
            if (!isGantry) continue;
            Gantry@ g = Find(u.id);
            if (g is null) {
                @g = Gantry();
                g.id = u.id; g.defName = d.GetName(); g.pos = u.GetPos(ai.frame);
                g.facing = aiTerrainMgr.GetBuildingFacing(u);
                if (g.facing < 0 || g.facing > 3) g.facing = 0;
                g.want = Global::RoleSettings::Tech::GantryFillTurrets;
                gantries.insertLast(g);
            }
            g.alive = true;
            if (g.clusterGroup <= 0) g.clusterGroup = ClusterGroup(g.id);
            if (g.finishFrame < 0 && u.GetBuildProgress() >= 1.0f) g.finishFrame = ai.frame;
        }
        const float r = Global::RoleSettings::Tech::GantryFillRadius;
        for (uint n = 0; n < scanNanos.length(); ++n) {
            const AIFloat3 p = scanNanos[n].GetPos(ai.frame);
            Gantry@ best = null;
            float bestSq = r * r;
            for (uint i = 0; i < gantries.length(); ++i) {
                if (!gantries[i].alive) continue;
                const float sq = MapHelpers::SqDist(p, gantries[i].pos);
                if (sq <= bestSq) { bestSq = sq; @best = gantries[i]; }
            }
            if (best is null) continue;
            bool other = false;
            for (uint f = 0; f < Factory::factoryList.length() && !other; ++f) {
                CCircuitUnit@ fac = Factory::factoryList[f];
                if (fac is null || Find(fac.id) !is null) continue;
                other = MapHelpers::SqDist(p, fac.GetPos(ai.frame)) < bestSq;
            }
            if (other) continue;
            if (scanNanos[n].GetBuildProgress() < 1.0f) best.framed++; else best.standing++;
        }
        scanNanos.resize(0);
        for (int i = int(gantries.length()) - 1; i >= 0; --i) {
            Gantry@ g = gantries[i];
            if (g.alive) { Report(g); continue; }
            for (uint k = 0; k < orders.length(); ++k) if (orderGantry[k] == g.id) Abort(orders[k]);
            for (uint k = 0; k < helps.length(); ++k) if (helpGantry[k] == g.id) Abort(helps[k]);
            for (uint k = 0; k < g.groups.length(); ++k) ReleaseBlock(g.groups[k]);
            GenericHelpers::LogUtil("[TECH][GantryFill] " + g.defName + " " + g.id + " is gone; its turret work ends", 1);
            gantries.removeAt(i);
        }
        Prune();
    }

    void Prune() {
        for (int i = int(orders.length()) - 1; i >= 0; --i)
            if (!Live(orders[i])) { orders.removeAt(i); orderGantry.removeAt(i); orderGiven.removeAt(i); orderFrame.removeAt(i); }
        for (int i = int(helps.length()) - 1; i >= 0; --i)
            if (!Live(helps[i])) { helps.removeAt(i); helpGantry.removeAt(i); }
        for (int i = int(cons.length()) - 1; i >= 0; --i) {
            CCircuitUnit@ u = ai.GetTeamUnit(cons[i]);
            if (u is null) { cons.removeAt(i); continue; }
            IUnitTask@ t = u.task;
            if (t is null || t.IsDead() || IsOurs(t)) continue;
            const int type = t.GetType();
            if (type == int(Task::Type::IDLE) || type == int(Task::Type::NIL) || type == int(Task::Type::WAIT)) continue;
            Release(cons[i], "moved to other work (task type " + type + ")");
        }
        bool any = false;
        for (uint i = 0; i < gantries.length() && !any; ++i) any = Short(gantries[i]);
        if (!any) while (cons.length() > 0) Release(cons[cons.length() - 1], "every gantry has its turrets");
    }

    // the owner's test: standing turrets at the finish, +2 min, +5 min, and when complete
    void Report(Gantry@ g) {
        if (g.finishFrame < 0) return;
        const int after = ai.frame - g.finishFrame;
        if (g.startStanding < 0) {
            g.startStanding = g.standing;
            GenericHelpers::LogUtil("[TECH][GantryFill] " + g.defName + " " + g.id + " finished at " + Clock(ai.frame) + " with " + g.standing + "/" + g.want
                + " turrets standing (" + g.framed + " framed, cluster block " + (g.clusterGroup > 0 ? "" + FreeIn(g.clusterGroup) + " free slots" : "none")
                + "): it fills to " + g.want + " within " + Global::RoleSettings::Tech::GantryFillSeconds + " s", 1);
        }
        if (g.completeFrame < 0 && g.standing >= g.want) {
            g.completeFrame = ai.frame;
            GenericHelpers::LogUtil("[TECH][GantryFill] " + g.defName + " " + g.id + " complete: " + g.standing + "/" + g.want + " turrets at " + Clock(ai.frame)
                + " (" + (after / SECOND) + " s after its finish, " + (g.standing - g.startStanding) + " added" + (after <= Global::RoleSettings::Tech::GantryFillSeconds * SECOND ? ", in time" : ", LATE")
                + "); our orders " + g.onBlock + " on the cluster block, " + g.onSide + " beside, " + g.sited + " engine-sited", 1);
        }
        string tag = "";
        if (!g.log2 && after >= 120 * SECOND) { g.log2 = true; tag = "+2 min"; }
        else if (!g.log5 && after >= Global::RoleSettings::Tech::GantryFillSeconds * SECOND) { g.log5 = true; tag = "+" + (Global::RoleSettings::Tech::GantryFillSeconds / 60) + " min"; }
        if (tag.length() == 0) return;
        GenericHelpers::LogUtil("[TECH][GantryFill] " + g.defName + " " + g.id + " " + tag + " (" + Clock(ai.frame) + "): "
            + g.standing + "/" + g.want + " turrets standing, " + g.framed + " framed, " + LiveOrders(g.id) + " ordered, "
            + cons.length() + " constructors requisitioned | M +" + int(Economy::GetMinMetalIncomeLast10s()) + " bank " + int(aiEconomyMgr.metal.current), 1);
    }
    bool ReportDue() {
        for (uint i = 0; i < gantries.length(); ++i) {
            Gantry@ g = gantries[i];
            if (g.finishFrame < 0) continue;
            const int after = ai.frame - g.finishFrame;
            if ((!g.log2 && after >= 120 * SECOND) || (!g.log5 && after >= Global::RoleSettings::Tech::GantryFillSeconds * SECOND)) return true;
        }
        return false;
    }

    // ------------------------------------------------------------ work

    bool Eligible(CCircuitUnit@ u) {
        if (u is null || u.circuitDef is null || nanoDef is null) return false;
        if (UnitHelpers::IsCommander(u.circuitDef) || UnitHelpers::GetConstructorTier(u.circuitDef) != 1 || !u.circuitDef.CanBuild(nanoDef)) return false;
        if (TechGantryCrew::OwnedElsewhere(u) || TechBuild::IsDedicatedAirCon(u) || TechGantryCrew::crewId == u.id) return false;
        IUnitTask@ t = u.task;
        if (t is null || t.IsDead()) return true;
        if (TechGantryCrew::Steered(t)) return false;
        IBuilderTask@ b = cast<IBuilderTask>(t);
        if (b !is null && !b.IsDead() && b.target !is null && Task::BuildType(b.GetBuildType()) == Task::BuildType::FACTORY) return false;
        return true;
    }
    bool Idle(CCircuitUnit@ u) {
        IUnitTask@ t = u.task;
        if (t is null || t.IsDead()) return true;
        const int type = t.GetType();
        return type == int(Task::Type::IDLE) || type == int(Task::Type::NIL) || type == int(Task::Type::WAIT);
    }

    IUnitTask@ Track(IUnitTask@ t, Gantry@ g) {
        if (t is null || g is null) return null;
        orders.insertLast(t); orderGantry.insertLast(g.id); orderGiven.insertLast(1); orderFrame.insertLast(ai.frame);
        Builder::MarkNanoEnqueued();
        return t;
    }

    // The next turret work at gantry g for constructor u: an order of ours nobody is on, a new order
    // (the cluster block, a block beside it, else engine-sited), or a turret frame to help
    IUnitTask@ Next(CCircuitUnit@ u, Gantry@ g) {
        if (u is null || u.circuitDef is null || g is null || !g.alive || nanoDef is null) return null;
        for (uint i = 0; i < orders.length(); ++i) {
            if (orderGantry[i] != g.id || !Live(orders[i])) continue;
            if (ai.frame - orderFrame[i] < OrphanSeconds * SECOND) continue;
            array<CCircuitUnit@>@ on = orders[i].GetUnits();
            if (on !is null && on.length() > 0) continue;
            if (orderGiven[i] >= GiveLimit) { Abort(orders[i]); continue; }
            orderGiven[i]++; orderFrame[i] = ai.frame;
            return orders[i];
        }
        if (Committed(g) < g.want && LiveOrders(g.id) < AiMax(1, Global::RoleSettings::Tech::GantryFillParallel)
            && aiBattle.SurfThreat(g.pos) <= Global::RoleSettings::Tech::GantryMaximumSurfaceThreat) {
            if (nanoDef.maxThisUnit >= 0 && nanoDef.count >= nanoDef.maxThisUnit) nanoDef.maxThisUnit = nanoDef.count + 1;
            if (nanoDef.IsAvailable(ai.frame)) {
                bool side = false;
                const int slot = g.fails < FallbackFailLimit ? Slot(u, g, side) : -1;
                if (slot >= 0) {
                    const AIFloat3 at = aiTerrainMgr.GetReservationPos(slot);
                    IUnitTask@ t = aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::NANO, Task::Priority::HIGH, nanoDef, at, 0.0f, true, OrderTimeoutSeconds * SECOND));
                    if (t !is null && !AiPinReservation(t, slot)) { aiBuilderMgr.AbortTask(t); @t = null; }
                    if (t !is null) {
                        GenericHelpers::LogUtil("[TECH][GantryFill] turret " + (Committed(g) + 1) + "/" + g.want + " for " + g.defName + " " + g.id
                            + (side ? " beside it" : " on its block") + " (slot " + slot + ") by " + u.circuitDef.GetName() + " " + u.id, 2);
                        if (side) g.onSide++; else g.onBlock++;
                        return Track(t, g);
                    }
                }
                if (slot < 0 || g.fails >= FallbackFailLimit) {
                    // sited from a point behind or beside the gantry, never its front: the exit stays clear
                    IUnitTask@ t = aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::NANO, Task::Priority::HIGH, nanoDef, SitePoint(g),
                        SQUARE_SIZE * 16, true, OrderTimeoutSeconds * SECOND));
                    if (t !is null) {
                        GenericHelpers::LogUtil("[TECH][GantryFill] turret " + (Committed(g) + 1) + "/" + g.want + " for " + g.defName + " " + g.id
                            + " engine-sited by " + u.circuitDef.GetName() + " " + u.id, 2);
                        g.sited++;
                        return Track(t, g);
                    }
                }
            }
        }
        CCircuitUnit@ frame = aiBuilderMgr.FindUnfinishedNear(g.pos, Global::RoleSettings::Tech::GantryFillRadius, nanoDef);
        if (frame is null) return null;
        IUnitTask@ r = aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::HIGH, frame, HelpTimeoutSeconds * SECOND));
        if (r !is null && helps.findByRef(r) < 0) { helps.insertLast(r); helpGantry.insertLast(g.id); }
        return r;
    }

    // Engine-sited turrets start their search behind the gantry, then beside it (left, right), in turn.
    // Facing (Spring): 0 south +z, 1 east +x, 2 north -z, 3 west -x; the exit is the facing side.
    AIFloat3 SitePoint(Gantry@ g) {
        const array<int> turns = { 2, 1, 3 };
        const int dir = (g.facing + turns[g.sited % 3]) % 4;
        const float d = 240.0f;
        AIFloat3 p = g.pos;
        if (dir == 0) p.z += d; else if (dir == 1) p.x += d; else if (dir == 2) p.z -= d; else p.x -= d;
        p.x = AiMax(0.0f, AiMin(float(aiTerrainMgr.GetTerrainWidth()), p.x));
        p.z = AiMax(0.0f, AiMin(float(aiTerrainMgr.GetTerrainHeight()), p.z));
        return p;
    }

    bool InReach(CCircuitUnit@ u, Gantry@ g, float &out sq) {
        sq = MapHelpers::SqDist(u.GetPos(ai.frame), g.pos);
        if (UnitHelpers::IsAirConstructor(u.circuitDef)) return true;
        const float reach = Global::RoleSettings::Tech::GantryFillReach;
        return sq <= reach * reach && aiTerrainMgr.CanReachAt(u, g.pos, Global::RoleSettings::Tech::GantryFillRadius);
    }
    Gantry@ NearestShort(CCircuitUnit@ u) {
        if (u is null) return null;
        Gantry@ best = null;
        float bestSq = 1.0e12f;
        for (uint i = 0; i < gantries.length(); ++i) {
            Gantry@ g = gantries[i];
            if (!Short(g)) continue;
            float sq;
            if (!InReach(u, g, sq) || sq >= bestSq) continue;
            bestSq = sq; @best = g;
        }
        return best;
    }

    // builder.as AiMakeTask, first in the TECH block: a requisitioned constructor keeps our task, or between
    // tasks gets the next one; none left: it goes back to the idle pool
    IUnitTask@ Work(CCircuitUnit@ u) {
        if (!On() || u is null || !IsCon(u.id)) return null;
        if (IsOurs(u.task)) return u.task;
        IUnitTask@ t = Next(u, NearestShort(u));
        if (t is null) Release(u.id, "no turret work left");
        return t;
    }

    // Tech_MainUpdate
    void Tick() {
        if (!On()) return;
        Defs();
        if (nanoDef is null || gantryDefs.length() == 0) return;
        if (gantries.length() == 0 && GantryCount() == 0) return;
        bool open = GantryCount() != int(gantries.length());
        for (uint i = 0; i < gantries.length() && !open; ++i) open = Short(gantries[i]) || (gantries[i].finishFrame < 0);
        const int every = (open ? AiMax(1, Global::RoleSettings::Tech::GantryFillScanSeconds) : RecheckSeconds) * SECOND;
        if (ai.frame - lastScan < every && !ReportDue()) return;
        Scan();
        Requisition();
    }

    void Requisition() {
        const int maxCons = AiMax(0, Global::RoleSettings::Tech::GantryFillCons);
        for (uint gi = 0; gi < gantries.length(); ++gi) {
            Gantry@ g = gantries[gi];
            if (!Short(g)) continue;
            int guard = 0;
            while (int(cons.length()) < maxCons && guard++ < maxCons) {
                // the nearest eligible constructor not yet ours: idle ones first
                int pick = -1;
                bool pickIdle = false;
                float bestSq = 1.0e12f;
                for (uint i = 0; i < scanCons.length(); ++i) {
                    if (IsCon(scanCons[i])) continue;
                    CCircuitUnit@ c = ai.GetTeamUnit(scanCons[i]);
                    if (c is null || !Eligible(c) || IsOurs(c.task)) continue;
                    float sq;
                    if (!InReach(c, g, sq)) continue;
                    const bool idle = Idle(c);
                    if (pickIdle && !idle) continue;
                    if (idle == pickIdle && sq >= bestSq) continue;
                    bestSq = sq; pick = scanCons[i]; pickIdle = idle;
                }
                if (pick < 0) break;
                CCircuitUnit@ u = ai.GetTeamUnit(pick);
                if (u is null) break;
                const string wasName = pickIdle ? "idle" : ("task type " + u.task.GetType());
                IUnitTask@ t = Next(u, g);
                if (!Live(t)) break;
                aiBuilderMgr.AssignTask(u, t);
                cons.insertLast(pick);
                if (ai.frame - lastLog >= 5 * SECOND) {
                    lastLog = ai.frame;
                    GenericHelpers::LogUtil("[TECH][GantryFill] requisitioned " + pick + " (" + wasName + ") for " + g.defName + " " + g.id + ": "
                        + g.standing + "/" + g.want + " standing, " + g.framed + " framed, " + LiveOrders(g.id) + " ordered, " + cons.length() + " constructors", 1);
                }
            }
        }
    }

    // Tech_BuilderAiTaskRemoved
    void TaskRemoved(IUnitTask@ task, bool done) {
        if (!On() || task is null) return;
        const int own = ownAborts.findByRef(task);
        if (own >= 0) ownAborts.removeAt(own);
        for (uint i = 0; i < orders.length(); ++i) {
            if (orders[i] !is task) continue;
            Gantry@ g = Find(orderGantry[i]);
            if (g !is null) {
                if (done) g.fails = 0;
                else if (own < 0 && ++g.fails == FallbackFailLimit)
                    GenericHelpers::LogUtil("[TECH][GantryFill] " + g.fails + " turret orders for " + g.defName + " " + g.id
                        + " ended unframed in a row: engine-sited turrets from now", 1);
            }
            orders.removeAt(i); orderGantry.removeAt(i); orderGiven.removeAt(i); orderFrame.removeAt(i);
            return;
        }
        for (uint i = 0; i < helps.length(); ++i)
            if (helps[i] is task) { helps.removeAt(i); helpGantry.removeAt(i); return; }
    }
}
