#include "circuit/terrain/FactoryDistrictGeometry.h"
#include "circuit/terrain/TerrainCorridor.h"
#include <cstdlib>
#include <iostream>

using namespace circuit::base_layout;
int main()
{
    int failures = 0;
    const auto check = [&failures](bool value, const char* message) {
        if (!value) { ++failures; std::cerr << message << '\n'; }
    };
    check(!OutsideBlast(32,32,{1,1,3,3},1), "inside protected footprint");
    check(!OutsideBlast(64,32,{1,1,3,3},16), "blast grazing footprint rejected");
    check(OutsideBlast(65,32,{1,1,3,3},16), "outside blast radius admitted");
    check(!OutsideBlast(65,32,{1,1,3,3},-1), "invalid blast radius rejected");
    const auto flat=[](float,float) { return 0.f; };
    check(FactoryExitSlope(-30.f,.9f,true)==0.f, "hover ignores submerged slope");
    check(FactoryExitSlope(30.f,.9f,true)==.9f, "hover respects land slope");
    check(FactoryExitSlope(-30.f,.9f,false)==.9f, "ground slope unchanged");
    check(!std::isfinite(FactoryExitSlope(-30.f,INFINITY,true)), "hover retains physical blocker");
    const auto ramp=[](float x,float) { return x>32.f && x<64.f ? .4f : 0.f; };
    check(circuit::lane::TerrainCorridor(0,32,96,32,8,.5f,0,false,flat,ramp), "bot exit crosses legal ramp");
    check(!circuit::lane::TerrainCorridor(0,32,96,32,8,.2f,0,false,flat,ramp), "vehicle exit rejects same steep ramp");
    check(!circuit::lane::TerrainCorridor(0,32,96,32,8,.5f,10,false,
        [](float,float){return -20.f;},flat), "exit rejects excessive depth");
    for (int facing = 0; facing < 4; ++facing) {
        for (int rows = 1; rows <= 4; ++rows) {
            const auto district = MakeFactoryDistrict({200, 200}, facing,
                {6, 6}, {9, 9}, {3, 3}, rows, rows, 4, 400.f);
            check(district.valid, "rotated district fits");
            check(district.first.nanos.size() == unsigned(rows * 2), "T1 capacity");
            check(district.second.nanos.size() == unsigned(rows * 3), "T2 capacity");
            check(!Intersects(district.first.nanoBounds, district.second.nanoBounds), "separate banks");
            check(!Intersects(district.first.exit, district.second.exit), "separate exits");
        }
        // Rectangular factories must rotate the basis, not their local depth
        // twice: the support bank and exit touch opposite factory edges.
        // {9, 6} is BAR's T1 air plant (armap/corap), the shape D-455 changed
        // at east/west facings; {6, 9} is the same plant described sideways.
        for (const auto footprint : {Footprint{12, 8}, Footprint{8, 12}, Footprint{12, 9}, Footprint{9, 12},
                Footprint{9, 6}, Footprint{6, 9}}) {
            const Point centre{200+Across(footprint,facing)%2,200+Along(footprint,facing)%2};
            auto cluster = MakeFactoryCluster(centre,facing,footprint,{3,3},FactoryTier::T1);
            check(cluster.valid, "rectangular factory cluster fits every rotation");
            check(ResizeSupportBank(cluster,{3,3},2,4,400.f), "rectangular support resize");
            const auto factoryRect=RectFromCentre(cluster.factory.centre,footprint,facing);
            check(TouchesEdge(factoryRect,cluster.nanoBounds), "no dead strip behind rectangular factory");
            check(!Intersects(factoryRect,cluster.nanoBounds), "support does not overlap factory");
            check(TouchesEdge(factoryRect,cluster.exit), "rectangular exit meets mouth");
            for (const auto& slot : cluster.nanos)
                check(!Intersects(RectFromCentre(slot.centre,slot.footprint,facing),cluster.exit), "turrets avoid exit");
        }
        const auto legacy = MakeFactoryCluster({200, 200}, facing, {6, 6}, {3, 3}, FactoryTier::T1);
        check(legacy.valid && legacy.nanos.size() == 2, "legacy T1 unchanged");
    }
    check(!MakeFactoryDistrict({200,200}, 0, {6,6}, {9,9}, {3,3}, 0, 2, 4, 400.f).valid, "zero rows rejected");
    check(!MakeFactoryDistrict({200,200}, 0, {6,6}, {9,9}, {3,3}, 9, 2, 4, 400.f).valid, "unbounded rows rejected");
    check(!MakeFactoryDistrict({200,200}, 0, {6,6}, {9,9}, {3,3}, 2, 2, 4, 1.f).valid, "unreachable banks rejected");
    check(!MakeFactoryDistrict({200,200}, 4, {6,6}, {9,9}, {3,3}, 2, 2, 4, 400.f).valid, "invalid facing rejected");
    // D-460 (KI-743): never away from the goal. Glitters team 4's T2 plant
    // at (200, 9080) with its lane to the north-east took south before.
    {
        int order[3] = {-1, -1, -1};
        int n = FacingsToward(200.f, 9080.f, 1392.f, 8208.f, 3072.f, 5120.f, order);
        check(n == 2 && order[0] == 1 && order[1] == 2, "goal north-east: east, then north, never south or west");
        // Goal straight ahead: both sides allowed, the map interior first.
        n = FacingsToward(600.f, 8000.f, 600.f, 2000.f, 3072.f, 5120.f, order);
        check(n == 3 && order[0] == 2 && order[1] == 1 && order[2] == 3, "goal ahead at the west edge: north, east, west");
        n = FacingsToward(100.f, 100.f, 100.f, 100.f, 0.f, 0.f, order);
        check(n == 0, "no goal distance, no facing");
        for (int facing = 0; facing < 4; ++facing) {
            const float gx = facing == 1 ? 1000.f : facing == 3 ? -1000.f : 0.f;
            const float gz = facing == 0 ? 1000.f : facing == 2 ? -1000.f : 0.f;
            n = FacingsToward(0.f, 0.f, gx, gz, 0.f, 0.f, order);
            bool opposite = false;
            for (int i = 0; i < n; ++i) opposite = opposite || order[i] == (facing + 2) % 4;
            check(n >= 1 && order[0] == facing && !opposite, "axis goal: its facing first, never the opposite");
        }
    }
    return failures ? EXIT_FAILURE : EXIT_SUCCESS;
}
