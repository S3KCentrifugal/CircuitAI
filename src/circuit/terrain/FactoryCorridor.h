#pragma once

#include <algorithm>
#include <cstdint>
#include <cstdlib>
#include <functional>
#include <limits>
#include <utility>
#include <vector>

namespace circuit::factory_corridor {

// Largest planning raster side, in blocking cells (the 4096-elmo window).
constexpr int kMaxRasterSide = 512;

struct Route {
    std::vector<int> cells;
    int visited = 0;
    bool exhausted = false;
};

// Each centre must fit the entire square footprint, including the half-step
// joining neighbouring centres. The prefix sum keeps admission O(W*H + V).
// The scratch overload reuses caller-owned buffers (D-451): no allocation
// once they have grown to the window size.
inline bool OpenCentres(int width, int height, const std::vector<std::uint8_t>& blocked,
        int step, int clearance, std::vector<int>& sums, std::vector<std::uint8_t>& result)
{
    result.clear();
    if (width<=0 || height<=0 || width>kMaxRasterSide || height>kMaxRasterSide || step<=0
        || clearance<step/2 || int(blocked.size())!=width*height) return false;
    sums.assign((width+1)*(height+1),0);
    for (int z=0;z<height;++z) for (int x=0;x<width;++x)
        sums[(z+1)*(width+1)+x+1]=(blocked[z*width+x]!=0)+sums[z*(width+1)+x+1]
            +sums[(z+1)*(width+1)+x]-sums[z*(width+1)+x];
    const int w=width/step,h=height/step;
    result.assign(w*h,0);
    for (int z=0;z<h;++z) for (int x=0;x<w;++x) {
        const int cx=x*step+step/2,cz=z*step+step/2;
        const int a=cx-clearance,b=cz-clearance,c=cx+clearance+1,d=cz+clearance+1;
        if (a<0||b<0||c>width||d>height) continue;
        result[z*w+x]=(sums[d*(width+1)+c]-sums[b*(width+1)+c]
            -sums[d*(width+1)+a]+sums[b*(width+1)+a])==0;
    }
    return true;
}
inline std::vector<std::uint8_t> OpenCentres(int width, int height,
        const std::vector<std::uint8_t>& blocked, int step, int clearance)
{
    std::vector<int> sums;
    std::vector<std::uint8_t> result;
    OpenCentres(width, height, blocked, step, clearance, sums, result);
    return result;
}

struct Rect { int x1,z1,x2,z2; };

// D-460: the 4-connected grid cells a polyline crosses, in order, without
// consecutive duplicates. Vertices are grid coordinates; the first must lie
// inside width x height, and tracing is clipped at the first cell that leaves
// it (the caller's window). O(cells).
inline void TraceCells(const std::vector<std::pair<int,int>>& vertices, int width, int height, std::vector<int>& out)
{
    out.clear();
    for (const auto& [x, z] : vertices) {
        if (out.empty()) {
            if (x<0 || z<0 || x>=width || z>=height) return;
            out.push_back(z*width+x);
            continue;
        }
        int cx=out.back()%width, cz=out.back()/width;
        const int nx=std::abs(x-cx), nz=std::abs(z-cz), sx=x>cx?1:-1, sz=z>cz?1:-1;
        for (int ix=0,iz=0; ix<nx || iz<nz;) {
            // step along the axis whose next cell boundary the segment meets first
            if ((1+2*ix)*nz < (1+2*iz)*nx) { cx+=sx; ++ix; } else { cz+=sz; ++iz; }
            if (cx<0 || cz<0 || cx>=width || cz>=height) return;
            out.push_back(cz*width+cx);
        }
    }
}
// The route grid snaps a requested cell towards its centre by up to step-1.
// Negative-facing mouths need that extra margin plus the exclusive upper edge
// of the clearance square. Otherwise north/west roads overlap their own factory.
inline std::pair<int,int> Mouth(const Rect& factory, int facing, int clearance, int step)
{
    int x=(factory.x1+factory.x2)/2,z=(factory.z1+factory.z2)/2;
    if (facing==0) z=factory.z2+clearance;
    else if (facing==1) x=factory.x2+clearance;
    else if (facing==2) z=factory.z1-clearance-step;
    else x=factory.x1-clearance-step;
    return {x,z};
}
inline std::vector<Rect> Rectangles(const std::vector<int>& cells, int width,
        int x0, int z0, int step, int clearance)
{
    std::vector<Rect> result;
    if (cells.empty()||cells.front()<0||width<=0||step<=0||clearance<step/2) return result;
    int begin=cells.front(),previous=begin,direction=0;
    const auto append=[&](int a,int b) {
        const int ax=x0+(a%width)*step+step/2,az=z0+(a/width)*step+step/2;
        const int bx=x0+(b%width)*step+step/2,bz=z0+(b/width)*step+step/2;
        result.push_back({std::min(ax,bx)-clearance,std::min(az,bz)-clearance,
            std::max(ax,bx)+clearance+1,std::max(az,bz)+clearance+1});
    };
    for (std::size_t i=1;i<cells.size();++i) {
        const int next=cells[i],d=next-previous;
        if (next<0 || previous<0 || (std::abs(d)!=width && !(std::abs(d)==1&&next/width==previous/width))) return {};
        if (direction&&direction!=d) { append(begin,previous);begin=previous; }
        direction=d;previous=next;
    }
    append(begin,previous);
    return result;
}

// Reused search buffers for Connect (D-451).
struct ConnectScratch {
    std::vector<int> costs, parent;
    std::vector<std::pair<int, int>> heap;
};

// Planning-time deterministic Dijkstra. Open cells already include clearance
// for the widest factory product. Reuse is a cost preference, never permission
// to cross blocked terrain or to stop at a disconnected old corridor.
// O(V log V) time/O(V) scratch, explicitly bounded by maximumVisited. The heap
// uses std::push_heap/pop_heap with std::greater, exactly what
// std::priority_queue does, so the tie order is unchanged.
inline Route Connect(int width, int height, int start,
        const std::vector<std::uint8_t>& open,
        const std::vector<std::uint8_t>& shared,
        const std::vector<std::uint8_t>& goals, int maximumVisited,
        ConnectScratch& scratch, int newCost = 10, int sharedCost = 4)
{
    Route result;
    if (width <= 0 || height <= 0 || width > kMaxRasterSide || height > kMaxRasterSide
            || maximumVisited <= 0 || sharedCost <= 0 || newCost < sharedCost) return result;
    const int size = width * height;
    if (int(open.size()) != size || int(shared.size()) != size || int(goals.size()) != size
            || start < 0 || start >= size || !open[start]) return result;
    using Entry = std::pair<int, int>;
    const std::greater<Entry> later;
    auto& heap = scratch.heap;
    auto& costs = scratch.costs;
    auto& parent = scratch.parent;
    heap.clear();
    costs.assign(size, std::numeric_limits<int>::max());
    parent.assign(size, -1);
    costs[start] = 0;
    heap.emplace_back(0, start);
    std::push_heap(heap.begin(), heap.end(), later);
    while (!heap.empty()) {
        std::pop_heap(heap.begin(), heap.end(), later);
        const auto [cost, cell] = heap.back();
        heap.pop_back();
        if (cost != costs[cell]) continue;
        if (result.visited == maximumVisited) { result.exhausted = true; return result; }
        ++result.visited;
        if (goals[cell]) {
            for (int cursor = cell; cursor >= 0; cursor = parent[cursor]) result.cells.push_back(cursor);
            std::reverse(result.cells.begin(), result.cells.end());
            return result;
        }
        const int x = cell % width, z = cell / width;
        const int neighbours[] = {x > 0 ? cell - 1 : -1, x + 1 < width ? cell + 1 : -1,
            z > 0 ? cell - width : -1, z + 1 < height ? cell + width : -1};
        for (int next : neighbours) {
            if (next < 0 || !open[next]) continue;
            const int step = shared[next] ? sharedCost : newCost;
            if (cost > std::numeric_limits<int>::max() - step) continue;
            const int candidate = cost + step;
            if (candidate >= costs[next]) continue;
            costs[next] = candidate;
            parent[next] = cell;
            heap.emplace_back(candidate, next);
            std::push_heap(heap.begin(), heap.end(), later);
        }
    }
    return result;
}
inline Route Connect(int width, int height, int start,
        const std::vector<std::uint8_t>& open,
        const std::vector<std::uint8_t>& shared,
        const std::vector<std::uint8_t>& goals, int maximumVisited,
        int newCost = 10, int sharedCost = 4)
{
    ConnectScratch scratch;
    return Connect(width, height, start, open, shared, goals, maximumVisited, scratch, newCost, sharedCost);
}
}
