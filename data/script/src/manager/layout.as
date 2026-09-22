// TECH base layout policy: the native factory pair (D-060) and the turret box (D-063).
#include "../define.as"
#include "../unit.as"
#include "../task.as"
#include "../global.as"
#include "../helpers/generic_helpers.as"
#include "../helpers/unit_helpers.as"
#include "../helpers/map_helpers.as"
#include "../helpers/layout_helpers.as"
#include "widget_link.as"

/******************************************************************************

LAYOUT (doc/layout-design.md)

Two things are planned at frame zero, before the first structure:

  1. The factory pair (D-060, native): the T1 and T2 bot labs side by side,
     each with its snug rear nano block and a held exit rectangle.

  2. The turret box (D-063): a rectangle of the flattest, most buildable
     ground directly behind the pair, sized from the settings and shrunk or
     slid until it fits. Inside it, rows of construction turrets are
     reserved as if they stood already - the "invisible turrets". Every row
     is laid slot by slot, so a boulder or a mex costs one slot, not the
     row, and never the plan.

Everything TECH builds for its economy after that - winds, solars, converters,
storages, fusions - is packed by native into the box on the free cells
nearest to a turret slot (PackNearGroup), inside a turret's reach and never
beyond it. The task is pinned to that footprint: no spiral, no walk. Turrets
themselves go up on demand, nearest the factories first, when the planner
finds build power short or metal floating.

This file answers "where"; it never decides "what" or "when". The planner
(eco_planner.as) decides those and crosses into here through Place,
NanoTask, CanPlace, CanPlaceTurret and BaseCentre only.

When the box cannot be planned (no candidate reaches LayoutBoxMinScore) the
economy is placed around the factory nanos with a short shake; that fallback
is logged once at level 1 and is the only case in which a TECH economy
structure is placed by the spiral.

******************************************************************************/
namespace Layout {

    const string FACTORY_ROOT = "tech.factory.start";
    const string BOX = "tech.box";

    bool planned = false;
    bool fallback = false;
    int facing = 0;
    bool overlay = false;
    int overlayTick = 0;
    bool fallbackLogged = false;

    // The box, mirrored in native layout ints (tech.box.*) for save/load.
    int boxZone = 0;
    int nanoGroup = 0;
    int boxAcross = 0;   // cells
    int boxDepth = 0;    // cells
    int boxRows = 0;
    array<int> extraZones;      // D-072: boxes grown behind the first when it was full
    AIFloat3 lastBoxCentre = AIFloat3(-1.0f, 0.0f, -1.0f);
    int lastBoxDepth = 0;
    AIFloat3 boxCentre = AIFloat3(-1.0f, 0.0f, -1.0f);
    AIFloat3 factoryCentre = AIFloat3(-1.0f, 0.0f, -1.0f);

    CCircuitDef@ nano;

    bool HasComplex()
    {
        return planned && !fallback && aiTerrainMgr.IsLayoutEnabled();
    }

    bool HasBox()
    {
        return HasComplex() && boxZone > 0 && nanoGroup > 0;
    }

    bool Enable(bool on)
    {
        const bool enabled = aiTerrainMgr.SetLayoutEnabled(on);
        GenericHelpers::LogUtil("[Layout] " + (enabled ? "on" : "off") + " for this AI"
            + (on && !enabled ? " (JSON gate is closed)" : ""), 1);
        return enabled;
    }

    void ClearScriptState()
    {
        planned = false;
        fallback = false;
        facing = 0;
        fallbackLogged = false;
        boxZone = 0;
        nanoGroup = 0;
        boxAcross = 0;
        boxDepth = 0;
        boxRows = 0;
        boxCentre = AIFloat3(-1.0f, 0.0f, -1.0f);
        factoryCentre = AIFloat3(-1.0f, 0.0f, -1.0f);
        @nano = null;
        extraZones.resize(0);
        lastBoxCentre = AIFloat3(-1.0f, 0.0f, -1.0f);
        lastBoxDepth = 0;
    }

    void OnRoleLeave()
    {
        if (!planned && !aiTerrainMgr.IsLayoutEnabled()) return;
        aiTerrainMgr.ResetLayout();
        aiTerrainMgr.SetLayoutEnabled(false);
        ClearScriptState();
        GenericHelpers::LogUtil("[Layout] cleared for a role switch", 1);
    }

    // ---------------------------------------------------------------- geometry

    // Native's facing convention (ReserveGridEx): SOUTH 0 +z, EAST 1 +x, NORTH 2 -z, WEST 3 -x.
    AIFloat3 Fwd(int f)
    {
        if (f == 1) return AIFloat3(1.0f, 0.0f, 0.0f);
        if (f == 2) return AIFloat3(0.0f, 0.0f, -1.0f);
        if (f == 3) return AIFloat3(-1.0f, 0.0f, 0.0f);
        return AIFloat3(0.0f, 0.0f, 1.0f);
    }

    AIFloat3 Side(int f)
    {
        if (f == 1) return AIFloat3(0.0f, 0.0f, -1.0f);
        if (f == 2) return AIFloat3(-1.0f, 0.0f, 0.0f);
        if (f == 3) return AIFloat3(0.0f, 0.0f, 1.0f);
        return AIFloat3(1.0f, 0.0f, 0.0f);
    }

    // Footprint extent along the facing (cells), across it.
    int Along(const CCircuitDef@ def, int f)
    {
        return ((f & 1) == 1) ? def.GetFootprintX() : def.GetFootprintZ();
    }

    int Across(const CCircuitDef@ def, int f)
    {
        return ((f & 1) == 1) ? def.GetFootprintZ() : def.GetFootprintX();
    }

    bool ResolveDefs(const string& in side)
    {
        @nano = ai.GetCircuitDef(UnitHelpers::GetT1NanoNameForSide(side));
        return nano !is null;
    }

    // ---------------------------------------------------------------- adoption (save/load)

    bool Adopt(const string& in side)
    {
        if (!aiTerrainMgr.HasLayoutGroup(FACTORY_ROOT + ".t1.nano")) return false;
        if (!ResolveDefs(side)) return false;
        planned = true;
        fallback = false;
        facing = aiTerrainMgr.GetLayoutInt(FACTORY_ROOT + ".facing", 0);
        boxZone = aiTerrainMgr.GetLayoutInt(BOX + ".zone", 0);
        nanoGroup = aiTerrainMgr.GetLayoutInt(BOX + ".nano_group", 0);
        boxAcross = aiTerrainMgr.GetLayoutInt(BOX + ".across", 0);
        boxDepth = aiTerrainMgr.GetLayoutInt(BOX + ".depth", 0);
        boxRows = aiTerrainMgr.GetLayoutInt(BOX + ".rows", 0);
        boxCentre = AIFloat3(float(aiTerrainMgr.GetLayoutInt(BOX + ".centre_x", -1)), 0.0f,
            float(aiTerrainMgr.GetLayoutInt(BOX + ".centre_z", -1)));
        factoryCentre = AIFloat3(float(aiTerrainMgr.GetLayoutInt(BOX + ".factory_x", -1)), 0.0f,
            float(aiTerrainMgr.GetLayoutInt(BOX + ".factory_z", -1)));
        extraZones.resize(0);
        const int extra = aiTerrainMgr.GetLayoutInt(BOX + ".extra_count", 0);
        for (int i = 0; i < extra; ++i) extraZones.insertLast(aiTerrainMgr.GetLayoutInt(BOX + ".extra" + i, 0));
        lastBoxCentre = AIFloat3(float(aiTerrainMgr.GetLayoutInt(BOX + ".last_x", int(boxCentre.x))), 0.0f,
            float(aiTerrainMgr.GetLayoutInt(BOX + ".last_z", int(boxCentre.z))));
        lastBoxDepth = aiTerrainMgr.GetLayoutInt(BOX + ".last_depth", boxDepth);
        string box = ", no turret box";
        if (HasBox()) {
            box = ", turret box zone " + boxZone + " " + boxAcross + "x" + boxDepth + " cells, "
                + boxRows + " rows, " + aiTerrainMgr.GetGroupCount(nanoGroup, false) + " turret slots";
        }
        GenericHelpers::LogUtil("[Layout] adopted restored native plan: facing " + facing + box, 1);
        return true;
    }

    // ---------------------------------------------------------------- the factory pair (D-060)

    array<int> SearchOffsets(int step, int tries)
    {
        array<int> result;
        result.reserve(uint(1 + tries * 2));
        result.insertLast(0);
        for (int i = 1; i <= tries; ++i) {
            result.insertLast(i * step);
            result.insertLast(-i * step);
        }
        return result;
    }

    bool PlanFactories(const string& in side)
    {
        CCircuitDef@ t1 = ai.GetCircuitDef(UnitHelpers::GetT1BotLabForSide(side));
        CCircuitDef@ t2 = ai.GetCircuitDef(UnitHelpers::GetT2BotLabForSide(side));
        if (t1 is null || t2 is null || nano is null) return false;
        const AIFloat3 base = Global::Map::StartPos;
        const AIFloat3 lane = aiSetupMgr.GetLanePos();
        const bool laneKnown = (lane.x > 0.0f || lane.z > 0.0f)
            && MapHelpers::SqDist(lane, base) > 100.0f * 100.0f;
        const int primary = LayoutHelpers::FacingToward(base, laneKnown ? lane : LayoutHelpers::TerrainCentre());
        const array<int> facings = { primary, (primary + 1) % 4, (primary + 3) % 4 };
        const array<int>@ sideOffsets = SearchOffsets(
            Global::RoleSettings::Tech::LayoutFactorySideStepCells,
            Global::RoleSettings::Tech::LayoutFactorySideTries);
        const array<int>@ forwardOffsets = SearchOffsets(
            Global::RoleSettings::Tech::LayoutFactoryForwardStepCells,
            Global::RoleSettings::Tech::LayoutFactoryForwardTries);
        for (uint fi = 0; fi < facings.length(); ++fi) {
            for (uint f = 0; f < forwardOffsets.length(); ++f) {
                for (uint s = 0; s < sideOffsets.length(); ++s) {
                    if (aiTerrainMgr.PlanFactoryPair(FACTORY_ROOT, t1, t2, nano, base,
                            facings[fi], sideOffsets[s], forwardOffsets[f])) {
                        facing = facings[fi];
                        GenericHelpers::LogUtil("[Layout] native factory pair committed facing " + facing
                            + ", side offset " + sideOffsets[s] + " cells, forward offset "
                            + forwardOffsets[f] + " cells", 1);
                        return true;
                    }
                }
            }
        }
        return false;
    }

    // ---------------------------------------------------------------- the turret box (D-063)

    int NanoRows()
    {
        return (Global::Map::Config.TechLayoutNanoRows > 0)
            ? Global::Map::Config.TechLayoutNanoRows
            : Global::RoleSettings::Tech::LayoutBoxNanoRows;
    }

    // The centre of the pair's rear edge, nanos included: the line the box
    // touches. Both labs share one rear edge (native aligns them); the T2
    // block is two nano rows deep, the T1 block one.
    bool PairRear(const string& in side, AIFloat3 &out rearCentre)
    {
        CCircuitDef@ t1 = ai.GetCircuitDef(UnitHelpers::GetT1BotLabForSide(side));
        CCircuitDef@ t2 = ai.GetCircuitDef(UnitHelpers::GetT2BotLabForSide(side));
        const int t1Slot = aiTerrainMgr.GetLayoutInt(FACTORY_ROOT + ".t1_slot", -1);
        const int t2Slot = aiTerrainMgr.GetLayoutInt(FACTORY_ROOT + ".t2_slot", -1);
        if (t1 is null || t2 is null || nano is null || t1Slot < 0 || t2Slot < 0) return false;
        const AIFloat3 p1 = aiTerrainMgr.GetReservationPos(t1Slot);
        const AIFloat3 p2 = aiTerrainMgr.GetReservationPos(t2Slot);
        if (p1.x < 0.0f || p2.x < 0.0f) return false;
        const AIFloat3 fwd = Fwd(facing);
        const float cell = SQUARE_SIZE * 2;
        // The factory rear edges: centre minus half the depth along the facing.
        const AIFloat3 r1 = p1 - fwd * (float(Along(t1, facing)) * 0.5f * cell);
        const AIFloat3 r2 = p2 - fwd * (float(Along(t2, facing)) * 0.5f * cell);
        const AIFloat3 mid = (r1 + r2) * 0.5f;
        factoryCentre = (p1 + p2) * 0.5f;
        // The deeper of the two nano blocks (T2: two rows) plus a one-cell gap.
        const int nanoRowsBehind = 2;
        rearCentre = mid - fwd * (float(nanoRowsBehind * Along(nano, facing) + 1) * cell);
        return true;
    }

    float BoxScore(const AIFloat3& in centre, int acrossCells, int depthCells)
    {
        const float halfAcross = float(acrossCells) * SQUARE_SIZE;   // cells * 16 / 2
        const float halfAlong = float(depthCells) * SQUARE_SIZE;
        const float flat = aiTerrainMgr.FlatFraction(centre, facing, halfAcross, halfAlong,
            Global::RoleSettings::Tech::LayoutBoxMaxSlope);
        const float buildable = aiTerrainMgr.BuildableFraction(nano, centre, halfAcross, halfAlong, facing);
        return flat * buildable;
    }

    bool PlanBox(const string& in side)
    {
        AIFloat3 front;
        if (!PairRear(side, front)) {
            GenericHelpers::LogUtil("[Layout] turret box: the factory pair's rear line is unknown", 1);
            return false;
        }
        const AIFloat3 fwd = Fwd(facing);
        const AIFloat3 sideVec = Side(facing);
        const float cell = SQUARE_SIZE * 2;
        const int fullAcross = Global::RoleSettings::Tech::LayoutBoxAcrossCells;
        const int fullDepth = Global::RoleSettings::Tech::LayoutBoxDepthCells;
        const int shrink = Global::RoleSettings::Tech::LayoutBoxShrinkCells;
        const int minAcross = Global::RoleSettings::Tech::LayoutBoxMinAcrossCells;
        const int minDepth = Global::RoleSettings::Tech::LayoutBoxMinDepthCells;
        const array<int>@ sideOffsets = SearchOffsets(
            Global::RoleSettings::Tech::LayoutBoxSideStepCells,
            Global::RoleSettings::Tech::LayoutBoxSideTries);
        const int rearStep = Global::RoleSettings::Tech::LayoutBoxRearStepCells;
        const int rearTries = Global::RoleSettings::Tech::LayoutBoxRearTries;
        const float minScore = Global::RoleSettings::Tech::LayoutBoxMinScore;

        // Largest box first; a size is accepted when its best candidate
        // clears the score. Rows shrink only after the width has.
        for (int depth = fullDepth; depth >= minDepth; depth -= shrink) {
            for (int across = fullAcross; across >= minAcross; across -= shrink) {
                float best = -1.0f;
                AIFloat3 bestCentre;
                int bestSide = 0, bestRear = 0;
                for (int r = 0; r <= rearTries; ++r) {
                    const int rear = r * rearStep;
                    for (uint s = 0; s < sideOffsets.length(); ++s) {
                        const AIFloat3 centre = front - fwd * (float(rear) * cell + float(depth) * 0.5f * cell)
                            + sideVec * (float(sideOffsets[s]) * cell);
                        const float score = BoxScore(centre, across, depth);
                        if (score > best) {
                            best = score;
                            bestCentre = centre;
                            bestSide = sideOffsets[s];
                            bestRear = rear;
                        }
                    }
                }
                if (best < minScore) {
                    GenericHelpers::LogUtil("[Layout] turret box " + across + "x" + depth
                        + " cells: best ground scores " + int(best * 100.0f) + "%, under "
                        + int(minScore * 100.0f) + "%", 2);
                    continue;
                }
                const int zone = aiTerrainMgr.ReserveZone(bestCentre, facing,
                    float(across) * SQUARE_SIZE, float(depth) * SQUARE_SIZE, false);
                if (zone == 0) continue;
                boxZone = zone;
                boxAcross = across;
                boxDepth = depth;
                boxCentre = bestCentre;
                lastBoxCentre = bestCentre;
                lastBoxDepth = depth;
                aiTerrainMgr.SetLayoutInt(BOX + ".last_x", int(bestCentre.x));
                aiTerrainMgr.SetLayoutInt(BOX + ".last_z", int(bestCentre.z));
                aiTerrainMgr.SetLayoutInt(BOX + ".last_depth", depth);
                // Turret rows: the first touches the pair's nanos, then one every
                // shelf plus a turret depth, as many as the depth holds. Each
                // slot is laid on its own: refused ground is a hole, not a veto.
                const int nanoAlong = Along(nano, facing);
                const int nanoAcross = Across(nano, facing);
                const int pitch = Global::RoleSettings::Tech::LayoutBoxShelfCells + nanoAlong;
                const int cols = (nanoAcross > 0) ? across / nanoAcross : 0;
                const AIFloat3 boxFront = bestCentre + fwd * (float(depth) * 0.5f * cell);
                int rows = 0;
                for (int row = 0; row < NanoRows(); ++row) {
                    if (row * pitch + nanoAlong > depth) break;
                    const AIFloat3 rowFront = boxFront - fwd * (float(row * pitch) * cell);
                    const int group = aiTerrainMgr.LayBand(zone, nano, rowFront, facing, cols, 1, 0,
                        false, true, false, nanoGroup);
                    if (group > 0) nanoGroup = group;
                    ++rows;
                }
                boxRows = rows;
                const int slots = (nanoGroup > 0) ? aiTerrainMgr.GetGroupCount(nanoGroup, false) : 0;
                aiTerrainMgr.SetLayoutInt(BOX + ".zone", boxZone);
                aiTerrainMgr.SetLayoutInt(BOX + ".nano_group", nanoGroup);
                aiTerrainMgr.SetLayoutInt(BOX + ".across", boxAcross);
                aiTerrainMgr.SetLayoutInt(BOX + ".depth", boxDepth);
                aiTerrainMgr.SetLayoutInt(BOX + ".rows", boxRows);
                aiTerrainMgr.SetLayoutInt(BOX + ".centre_x", int(boxCentre.x));
                aiTerrainMgr.SetLayoutInt(BOX + ".centre_z", int(boxCentre.z));
                aiTerrainMgr.SetLayoutInt(BOX + ".factory_x", int(factoryCentre.x));
                aiTerrainMgr.SetLayoutInt(BOX + ".factory_z", int(factoryCentre.z));
                GenericHelpers::LogUtil("[Layout] turret box " + across + "x" + depth + " cells at ("
                    + int(bestCentre.x) + ", " + int(bestCentre.z) + "), rear " + bestRear + ", side " + bestSide
                    + ", ground " + int(best * 100.0f) + "%: zone " + zone + ", " + rows + " rows, "
                    + slots + " of " + (rows * cols) + " turret slots", 1);
                return slots > 0;
            }
        }
        return false;
    }

    // D-072: when the box is full, another box of the same width directly
    // behind the last one, with its own turret rows in the same group, so
    // energy, converters, fusions and labs stay tight to the turret cluster
    // instead of scattering around the base centre.
    int growFailFrame = -100000;
    bool GrowBox()
    {
        if (!HasBox() || lastBoxCentre.x < 0.0f || nano is null) return false;
        if (int(extraZones.length()) >= Global::RoleSettings::Tech::LayoutBoxMaxExtra) return false;
        if (ai.frame - growFailFrame < 60 * SECOND) return false;   // a failed search is not repeated every ask
        const AIFloat3 fwd = Fwd(facing);
        const AIFloat3 sideVec = Side(facing);
        const float cell = SQUARE_SIZE * 2;
        const int across = boxAcross;
        const int shrink = Global::RoleSettings::Tech::LayoutBoxShrinkCells;
        const int minDepth = Global::RoleSettings::Tech::LayoutBoxMinDepthCells;
        const float minScore = Global::RoleSettings::Tech::LayoutBoxMinScore;
        // behind the last box first; then beside the first box on either hand
        // (played: the ground behind the base on Supreme Isthmus scored under
        // the floor and the base scattered); the best ground wins
        const AIFloat3 rearFront = lastBoxCentre - fwd * (float(lastBoxDepth) * 0.5f * cell);
        const AIFloat3 firstFront = boxCentre + fwd * (float(boxDepth) * 0.5f * cell);
        for (int depth = Global::RoleSettings::Tech::LayoutBoxDepthCells; depth >= minDepth; depth -= shrink) {
            array<AIFloat3> fronts = { rearFront, firstFront + sideVec * (float(across) * cell), firstFront - sideVec * (float(across) * cell) };
            array<string> names = { "behind", "beside (right)", "beside (left)" };
            float best = -1.0f; int bestIdx = -1; AIFloat3 bestCentre;
            for (uint i = 0; i < fronts.length(); ++i) {
                const AIFloat3 centre = fronts[i] - fwd * (float(depth) * 0.5f * cell);
                const float score = BoxScore(centre, across, depth);
                if (score >= minScore && score > best) { best = score; bestIdx = int(i); bestCentre = centre; }
            }
            if (bestIdx < 0) continue;
            const int zone = aiTerrainMgr.ReserveZone(bestCentre, facing, float(across) * SQUARE_SIZE, float(depth) * SQUARE_SIZE, false);
            if (zone == 0) continue;
            const AIFloat3 front = fronts[bestIdx];
            const int nanoAlong = Along(nano, facing);
            const int nanoAcross = Across(nano, facing);
            const int pitch = Global::RoleSettings::Tech::LayoutBoxShelfCells + nanoAlong;
            const int cols = (nanoAcross > 0) ? across / nanoAcross : 0;
            int rows = 0;
            for (int row = 0; row < NanoRows(); ++row) {
                if (row * pitch + nanoAlong > depth) break;
                const AIFloat3 rowFront = front - fwd * (float(row * pitch) * cell);
                const int group = aiTerrainMgr.LayBand(zone, nano, rowFront, facing, cols, 1, 0, false, true, false, nanoGroup);
                if (group > 0) nanoGroup = group;
                ++rows;
            }
            extraZones.insertLast(zone);
            if (bestIdx == 0) { lastBoxCentre = bestCentre; lastBoxDepth = depth; }
            aiTerrainMgr.SetLayoutInt(BOX + ".extra_count", int(extraZones.length()));
            aiTerrainMgr.SetLayoutInt(BOX + ".extra" + (extraZones.length() - 1), zone);
            aiTerrainMgr.SetLayoutInt(BOX + ".last_x", int(lastBoxCentre.x));
            aiTerrainMgr.SetLayoutInt(BOX + ".last_z", int(lastBoxCentre.z));
            aiTerrainMgr.SetLayoutInt(BOX + ".last_depth", lastBoxDepth);
            aiTerrainMgr.SetLayoutInt(BOX + ".nano_group", nanoGroup);
            GenericHelpers::LogUtil("[Layout] turret box full: grown " + names[bestIdx] + " by " + across + "x" + depth + " cells at ("
                + int(bestCentre.x) + ", " + int(bestCentre.z) + "), ground " + int(best * 100.0f) + "%: zone " + zone + ", " + rows
                + " turret rows (box " + (extraZones.length() + 1) + ")", 1);
            return true;
        }
        growFailFrame = ai.frame;
        GenericHelpers::LogUtil("[Layout] turret box full and no ground behind or beside it scores " + int(minScore * 100.0f) + "%; retried in a minute", 1);
        return false;
    }

    // Every box zone, the first first: the older box fills before the newer
    int ZoneCount() { return HasBox() ? 1 + int(extraZones.length()) : 0; }
    int ZoneAt(int i) { return (i == 0) ? boxZone : extraZones[i - 1]; }

    void Plan(const string& in side)
    {
        if (!Global::RoleSettings::Tech::ExperimentalBuild || !Global::RoleSettings::Tech::LayoutEnabled || !Enable(true)) return;
        if (Adopt(side)) return;
        if (!ResolveDefs(side) || !PlanFactories(side)) {
            fallback = true;
            planned = false;
            Enable(false);
            GenericHelpers::LogUtil("[Layout] no atomic factory pair fits; TECH retains normal placement", 1);
            return;
        }
        planned = true;
        fallback = false;
        if (!PlanBox(side)) {
            boxZone = 0;
            nanoGroup = 0;
            GenericHelpers::LogUtil("[Layout] no turret box fits behind the factory pair; the economy is placed around the factory nanos", 1);
        }
    }

    void Update(float metalIncome, bool t2LabStands, int t2ConstructorCount)
    {
        if (!planned && aiTerrainMgr.IsLayoutEnabled()) {
            Adopt(Global::AISettings::Side);
        } else if (planned) {
            facing = aiTerrainMgr.GetLayoutInt(FACTORY_ROOT + ".facing", facing);
        }
        if (overlay) SendOverlay();
    }

    // ---------------------------------------------------------------- queries for the planner

    // The centre of the planned base: the turret box, else the factory nanos,
    // else the start. The planner measures build power around it.
    AIFloat3 BaseCentre()
    {
        if (HasBox()) return boxCentre;
        return FactoryNanoCentre();
    }

    AIFloat3 FactoryNanoCentre()
    {
        const AIFloat3 center = aiTerrainMgr.GetLayoutGroupCenter(FACTORY_ROOT + ".t1.nano");
        return (center.x >= 0.0f && center.z >= 0.0f) ? center : Global::Map::StartPos;
    }

    // Is there a planned turret slot left: a completed factory's rear slot
    // or a box slot? The planner asks before it names a turret.
    bool CanPlaceTurret()
    {
        if (!HasComplex()) return false;
        if (aiTerrainMgr.GetFactoryNanoAvailable() > 0) return true;
        return HasBox() && aiTerrainMgr.GetGroupCount(nanoGroup, true) > 0;
    }

    // ---------------------------------------------------------------- placement

    // A structure that kills the turrets next to it when it dies keeps this
    // distance from every turret slot (knowledge base: an advanced converter
    // kills a nano within 173 elmos, a fusion within 379). The defaults are 0:
    // the owner chose density and shared build power over firebreaks.
    float MinNanoDist(const CCircuitDef@ def)
    {
        if (def is null) return 0.0f;
        const string name = def.GetName();
        const string side = Global::AISettings::Side;
        if (name == UnitHelpers::GetAdvEnergyConverterNameForSide(side)) return Global::RoleSettings::Tech::LayoutConverterNanoGap;
        if (name == UnitHelpers::GetFusionNameForSide(side) || name == UnitHelpers::GetAdvFusionNameForSide(side)) return Global::RoleSettings::Tech::LayoutFusionNanoGap;
        return 0.0f;
    }

    // Would the box hold this def within a turret's reach? Without a box the
    // spiral fallback always can.
    bool CanPlace(const CCircuitDef@ def)
    {
        if (def is null) return false;
        if (!HasBox()) return true;
        for (int i = 0; i < ZoneCount(); ++i)
            if (aiTerrainMgr.CanPackNearGroup(ZoneAt(i), def, nanoGroup, facing, 0.0f, MinNanoDist(def))) return true;
        return true;   // the box grows when it is full (Place)
    }

    // Enqueue a structure on the box cells nearest to a turret, pinned to
    // that exact footprint. Null when nothing fits: the caller must not fall
    // back to the spiral (the walking cap, D-063).
    IUnitTask@ Place(Task::BuildType type, Task::Priority priority, CCircuitDef@ def, int timeout, CCircuitUnit@ builder = null)
    {
        if (def is null) return null;
        // Among the cells equally close to a turret, the one nearest the
        // builder that asked: the less it walks, the sooner it builds (D-064).
        AIFloat3 anchor = factoryCentre;
        if (builder !is null) anchor = builder.GetPos(ai.frame);
        if (!HasBox()) {
            if (!fallbackLogged) {
                fallbackLogged = true;
                GenericHelpers::LogUtil("[Layout] no turret box: economy structures are placed within "
                    + Global::RoleSettings::Tech::LayoutFallbackShakeCells + " cells of the factory nanos", 1);
            }
            return aiBuilderMgr.Enqueue(TaskB::Common(type, priority, def, FactoryNanoCentre(),
                float(Global::RoleSettings::Tech::LayoutFallbackShakeCells) * SQUARE_SIZE * 2, true, timeout));
        }
        int id = -1;
        for (int i = 0; i < ZoneCount() && id < 0; ++i)
            id = aiTerrainMgr.PackNearGroup(ZoneAt(i), def, nanoGroup, facing, anchor, 0.0f, MinNanoDist(def), 0);
        if (id < 0 && GrowBox()) {
            id = aiTerrainMgr.PackNearGroup(ZoneAt(ZoneCount() - 1), def, nanoGroup, facing, anchor, 0.0f, MinNanoDist(def), 0);
        }
        if (id < 0) {
            GenericHelpers::LogUtil("[Layout] no room in the turret boxes for " + def.GetName(), 1);
            return null;
        }
        const AIFloat3 pos = aiTerrainMgr.GetReservationPos(id);
        IUnitTask@ t = aiBuilderMgr.Enqueue(TaskB::Common(type, priority, def, pos, 0.0f, true, timeout));
        if (t is null) {
            aiTerrainMgr.ReleaseReservation(id);
            return null;
        }
        if (!AiPinReservation(t, id)) {
            GenericHelpers::LogUtil("[Layout] could not pin " + def.GetName() + " to slot " + id, 1);
        }
        return t;
    }

    // The next construction turret slot, nearest the factories: a completed
    // factory's own rear slot (D-060), then the box row behind it. Pinned,
    // never spiralled. Null when no slot is left or the unit cannot build one.
    IUnitTask@ NanoTask(CCircuitUnit@ unit, Task::Priority priority)
    {
        if (!HasComplex() || unit is null || unit.circuitDef is null || nano is null) return null;
        if (!unit.circuitDef.CanBuild(nano)) return null;
        if (aiTerrainMgr.GetFactoryNanoAvailable() > 0) {
            IUnitTask@ t = aiBuilderMgr.EnqueueFactoryNano(
                TaskB::Common(Task::BuildType::NANO, priority, nano, Global::Map::StartPos, 0.0f, true, 120 * SECOND), unit);
            if (t !is null) return t;
        }
        if (!HasBox()) return null;
        if (aiTerrainMgr.GetGroupCount(nanoGroup, true) == 0 && !GrowBox()) return null;   // D-072: more rows behind
        // D-069: the slot nearest a standing lab, whichever lab that is, so
        // every turret reaches a lab; the pair's centre only when no lab stands.
        int id = -1;
        if (Global::RoleSettings::Tech::ExpTurretNearLab) {
            float bestSq = 1.0e30f;
            array<string>@ keys = Factory::allFactories.getKeys();
            for (uint i = 0; keys !is null && i < keys.length(); ++i) {
                CCircuitUnit@ f = null; if (!Factory::allFactories.get(keys[i], @f) || f is null) continue;
                const AIFloat3 fp = f.GetPos(ai.frame);
                const int cand = aiTerrainMgr.NextSlotAny(nanoGroup, fp);
                if (cand < 0) continue;
                const float sq = MapHelpers::SqDist(aiTerrainMgr.GetReservationPos(cand), fp);
                if (sq < bestSq) { bestSq = sq; id = cand; }
            }
            if (id >= 0) GenericHelpers::LogUtil("[Layout] turret slot " + id + ", " + int(sqrt(bestSq)) + " from the nearest lab", 2);
        }
        if (id < 0) id = aiTerrainMgr.NextSlotAny(nanoGroup, factoryCentre);
        if (id < 0) return null;
        const AIFloat3 pos = aiTerrainMgr.GetReservationPos(id);
        IUnitTask@ t = aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::NANO, priority, nano, pos, 0.0f, true, 120 * SECOND));
        if (t is null) return null;
        if (!AiPinReservation(t, id)) {
            GenericHelpers::LogUtil("[Layout] could not pin a turret to slot " + id, 1);
        }
        return t;
    }

    // The advanced lab's site (D-069): the pair's planned slot, unless a free
    // footprint within ExpLabSiteRadius of it has strictly more static build
    // power (turrets, workertime) within ExpLabBuildPowerReach - then that
    // footprint, reserved and pinned, facing as the pair does. Every block,
    // zone and exit cone is honoured by CanReserveBuilding. The first lab is
    // the exception (tech_build.as: at the commander). Null when the lab
    // cannot be ordered now (cooldown, def unavailable, nothing enqueued).
    IUnitTask@ T2LabTask(int timeout)
    {
        const string side = Global::AISettings::Side;
        CCircuitDef@ t2 = ai.GetCircuitDef(UnitHelpers::GetT2BotLabForSide(side));
        if (t2 is null || !t2.IsAvailable(ai.frame)) return null;
        if (!Builder::IsT2BotFactoryOffCooldown()) return null;
        // D-073: the site is scored by the turret slots (standing or planned) that
        // reach it, front first among equals: the pair's planned slot against the
        // best free footprint inside the turret layout (owner: "on the turret
        // layout, tight, the more build power in range of the factory the better;
        // its units leave for the front late").
        const float reach = Global::RoleSettings::Tech::ExpLabBuildPowerReach;
        const int t2Slot = aiTerrainMgr.GetLayoutInt(FACTORY_ROOT + ".t2_slot", -1);
        AIFloat3 pairPos = (t2Slot >= 0) ? aiTerrainMgr.GetReservationPos(t2Slot) : Global::Map::StartPos;
        if (pairPos.x < 0.0f) pairPos = Global::Map::StartPos;
        const int pairScore = (nanoGroup > 0) ? aiTerrainMgr.CountGroupSlotsWithin(nanoGroup, pairPos, reach) : 0;
        int bestScore = pairScore;
        int bestZone = 0;
        AIFloat3 bestPos = pairPos;
        for (int i = 0; i < ZoneCount(); ++i) {
            AIFloat3 p;
            const int s = aiTerrainMgr.PickMost(ZoneAt(i), t2, nanoGroup, facing, reach, p);
            if (s > bestScore) { bestScore = s; bestZone = ZoneAt(i); bestPos = p; }
        }
        if (bestZone == 0 && HasBox() && GrowBox()) {
            AIFloat3 p;
            const int s = aiTerrainMgr.PickMost(ZoneAt(ZoneCount() - 1), t2, nanoGroup, facing, reach, p);
            if (s > bestScore) { bestScore = s; bestZone = ZoneAt(ZoneCount() - 1); bestPos = p; }
        }
        if (bestZone == 0) {
            IUnitTask@ t = Builder::EnqueueT2BotLabIfNeeded(side, Global::Map::StartPos, 0.0f, timeout);
            if (t !is null) GenericHelpers::LogUtil("[Layout] advanced lab on the pair's slot (" + int(pairPos.x) + ", " + int(pairPos.z)
                + "): " + pairScore + " turret slots within " + int(reach) + "; no footprint in the turret layout is reached by more", 1);
            return t;
        }
        const int id = aiTerrainMgr.PackNearGroupMost(bestZone, t2, nanoGroup, facing, reach, 0);
        if (id < 0) {
            GenericHelpers::LogUtil("[Layout] advanced lab: the turret-layout footprint could not be reserved; the pair's slot is used", 1);
            return Builder::EnqueueT2BotLabIfNeeded(side, Global::Map::StartPos, 0.0f, timeout);
        }
        const AIFloat3 p = aiTerrainMgr.GetReservationPos(id);
        IUnitTask@ t = aiBuilderMgr.Enqueue(TaskB::Factory(Task::Priority::NOW, t2, p, null, 0.0f, false, true, timeout));
        if (t is null) { aiTerrainMgr.ReleaseReservation(id); return null; }
        if (!AiPinReservation(t, id)) GenericHelpers::LogUtil("[Layout] could not pin the advanced lab to slot " + id, 1);
        Builder::MarkT2BotFactoryEnqueued();
        GenericHelpers::LogUtil("[Layout] advanced lab in the turret layout at (" + int(p.x) + ", " + int(p.z) + "): " + bestScore
            + " turret slots within " + int(reach) + " reach it, the pair's slot " + pairScore + "; front first among equals", 1);
        return t;
    }

    // ---------------------------------------------------------------- overlay

    void SetOverlay(bool on)
    {
        overlay = on;
        overlayTick = 0;
        if (on) SendOverlay();
    }

    void SendOverlay()
    {
        if (!planned) return;
        if ((overlayTick++ % 4) != 0) return;
        const string all = "complex:" + facing + ":0:0:" + facing + ":0:0:c;" + aiTerrainMgr.DescribeLayout();
        const uint chunk = 3000;
        uint parts = (all.length() + chunk - 1) / chunk;
        if (parts == 0) parts = 1;
        for (uint i = 0; i < parts; ++i) {
            WidgetLink::Send("layout", "" + (i + 1) + "|" + parts + "|" + all.substr(i * chunk, chunk));
        }
    }
}
