#include "circuit/terrain/FactoryCorridor.h"
#include "circuit/terrain/AlliedReservations.h"
#include <cstdlib>
#include <iostream>

int main()
{
    int failures = 0;
    const auto check = [&](bool value, const char* message) {
        if (!value) { ++failures; std::cerr << message << '\n'; }
    };
    using circuit::factory_corridor::Connect;
    std::vector<std::uint8_t> open(35, 1), shared(35, 0), goals(35, 0);
    goals[20] = 1;
    const auto direct = Connect(7, 5, 14, open, shared, goals, 35);
    check(direct.cells.size() == 7 && direct.cells.back() == 20, "direct lane connection");
    for (int x = 0; x < 7; ++x) shared[7 + x] = 1;
    shared[20] = 1;
    const auto reused = Connect(7, 5, 14, open, shared, goals, 35);
    check(reused.cells.size() == 9 && reused.cells[1] == 7, "prefer shared trunk over separate parallel road");
    open[10] = 0;
    const auto blocked = Connect(7, 5, 14, open, shared, goals, 35);
    check(std::find(blocked.cells.begin(), blocked.cells.end(), 10) == blocked.cells.end(), "reuse never bypasses obstruction");
    for (int z = 0; z < 5; ++z) open[z * 7 + 3] = 0;
    check(Connect(7, 5, 14, open, shared, goals, 35).cells.empty(), "orphan trunk is not a lane connection");
    check(Connect(7, 5, 14, open, shared, goals, 1).exhausted, "bounded search reports exhaustion");
    check(Connect(7, 5, -1, open, shared, goals, 35).cells.empty(), "invalid origin refused");
    check(Connect(513, 5, 0, open, shared, goals, 35).cells.empty(), "unbounded window refused");
    const std::vector<std::uint8_t> diagonal = {1, 0, 0, 1}, none(4, 0), target = {0, 0, 0, 1};
    check(Connect(2, 2, 0, diagonal, none, target, 4).cells.empty(), "cannot squeeze diagonally through blocked corner");
    std::vector<uint8_t> obstacles(64,0);
    auto centres=circuit::factory_corridor::OpenCentres(8,8,obstacles,2,2);
    check(centres.size()==16 && centres[5] && !centres[0],"whole width must fit inside map");
    obstacles[3*8+5]=1;
    centres=circuit::factory_corridor::OpenCentres(8,8,obstacles,2,2);
    check(!centres[5],"off-centre obstacle excludes wide product");
    check(circuit::factory_corridor::OpenCentres(8,8,obstacles,0,2).empty(),"invalid raster step refused");
    check(circuit::factory_corridor::Rectangles({-1},3,0,0,2,2).empty(),"negative singleton refused");
    const auto rectangles=circuit::factory_corridor::Rectangles({0,1,2,5,8},3,10,10,2,2);
    check(rectangles.size()==2 && rectangles[0].x1==9 && rectangles[0].x2==18
        && rectangles[1].z2==18,"straight segments coalesce with overlapping corner clearance");
    check(circuit::factory_corridor::Rectangles({2,3},3,0,0,2,2).empty(),"row wrapping is not an edge");
    // The prospective factory must already be an obstacle before the task
    // claims it. Otherwise a rearward lane pulls its road through the factory.
    std::vector<uint8_t> candidateGrid(32*32,0), candidateReuse(16*16,0), candidateGoal(16*16,0);
    candidateGoal[8*16+3]=1;
    auto candidateOpen=circuit::factory_corridor::OpenCentres(32,32,candidateGrid,2,2);
    auto crossesFactory=Connect(16,16,8*16+12,candidateOpen,candidateReuse,candidateGoal,256);
    const auto overlapsFactory=[](const auto& path) {
        for(const auto& r:circuit::factory_corridor::Rectangles(path.cells,16,0,0,2,2))
            if(r.x1<20 && r.x2>12 && r.z1<20 && r.z2>12)return true;
        return false;
    };
    check(overlapsFactory(crossesFactory),"unclaimed candidate reproduces self-blocking road");
    for(int z=12;z<20;++z)for(int x=12;x<20;++x)candidateGrid[z*32+x]=1;
    candidateOpen=circuit::factory_corridor::OpenCentres(32,32,candidateGrid,2,2);
    auto avoidsFactory=Connect(16,16,8*16+12,candidateOpen,candidateReuse,candidateGoal,256);
    check(!avoidsFactory.cells.empty() && !overlapsFactory(avoidsFactory),"provisional factory footprint preserves build admission");
    // Exercise both grid parities, rectangular factories and every facing.
    // This failed for north/west exits in the 8v8 Glitters opening.
    for (int offset=0;offset<2;++offset) for (int facing=0;facing<4;++facing) {
        const circuit::factory_corridor::Rect footprint{20+offset,22+offset,32+offset,30+offset};
        std::vector<uint8_t> grid(64*64,0);
        for(int z=footprint.z1;z<footprint.z2;++z)for(int x=footprint.x1;x<footprint.x2;++x)grid[z*64+x]=1;
        for(int clearance=2;clearance<6;++clearance) {
            auto [x,z]=circuit::factory_corridor::Mouth(footprint,facing,clearance,2);
            const auto available=circuit::factory_corridor::OpenCentres(64,64,grid,2,clearance);
            check(available[(z/2)*32+x/2],"all facing mouths clear their own footprint after grid snapping");
            const auto road=circuit::factory_corridor::Rectangles({(z/2)*32+x/2},32,0,0,2,clearance);
            const auto& r=road.front();
            check(!(r.x1<footprint.x2 && r.x2>footprint.x1 && r.z1<footprint.z2 && r.z2>footprint.z1),"mouth rectangle does not block factory claim");
        }
    }
    circuit::allied_layout::Reservations claims;
    using Claims=circuit::allied_layout::Reservations;
    claims.Put(0,Claims::EXIT,-1025,{2,2,8,5});
    claims.Put(0,Claims::EXIT,-2049,{5,2,11,5});
    claims.Erase(0,Claims::EXIT,-1025);
    check(claims.OverlapsOther(1,{5,2,8,5}),"releasing one factory retains shared trunk lease");
    claims.SetPriority(1,2);
    check(claims.OverlapsOther(1,{5,2,8,5}),"TECH priority cannot preempt a corridor");
    claims.Erase(0,Claims::EXIT,-2049);
    check(!claims.OverlapsOther(1,{5,2,8,5}),"last factory releases trunk");
    int task=0;
    check(claims.ClaimTask(0,task,{12,2,15,5}),"ordinary own building task reserves its footprint");
    int ownHard=0;
    claims.ForEachOther(-1,Claims::TASK,{0,0,20,20},[&](const auto&) { ++ownHard; });
    check(ownHard==1,"road raster includes own ordinary task claims");
    // D-460: the lane road traces 4-connected cells, so Rectangles accepts every run.
    {
        using circuit::factory_corridor::TraceCells;
        std::vector<int> cells;
        TraceCells({{0,0},{3,2}}, 10, 10, cells);
        bool connected = cells.size() == 6 && cells.front() == 0 && cells.back() == 2*10+3;
        for (std::size_t i = 1; i < cells.size(); ++i) {
            const int d = std::abs(cells[i] - cells[i-1]);
            connected = connected && (d == 1 || d == 10);
        }
        check(connected, "diagonal trace is 4-connected, endpoints included");
        check(!circuit::factory_corridor::Rectangles(cells, 10, 0, 0, 2, 2).empty(), "a traced run makes rectangles");
        TraceCells({{2,2},{2,2},{2,5}}, 10, 10, cells);
        check(cells.size() == 4, "repeated vertex adds no duplicate cell");
        TraceCells({{1,1},{4,1},{12,1}}, 10, 10, cells);
        check(cells.size() == 9 && cells.back() == 19, "trace is clipped at the window edge, not dropped");
    }
    return failures ? EXIT_FAILURE : EXIT_SUCCESS;
}
