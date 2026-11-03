#pragma once

#include <algorithm>
#include <cstdint>
#include <cstdlib>
#include <limits>
#include <queue>
#include <vector>

namespace circuit::factory_corridor {

struct Route {
    std::vector<int> cells;
    int visited = 0;
    bool exhausted = false;
};

// Each centre must fit the entire square footprint, including the half-step
// joining neighbouring centres. The prefix sum keeps admission O(W*H + V).
inline std::vector<std::uint8_t> OpenCentres(int width, int height,
        const std::vector<std::uint8_t>& blocked, int step, int clearance)
{
    if (width<=0 || height<=0 || width>512 || height>512 || step<=0
        || clearance<step/2 || int(blocked.size())!=width*height) return {};
    std::vector<int> sums((width+1)*(height+1),0);
    for (int z=0;z<height;++z) for (int x=0;x<width;++x)
        sums[(z+1)*(width+1)+x+1]=(blocked[z*width+x]!=0)+sums[z*(width+1)+x+1]
            +sums[(z+1)*(width+1)+x]-sums[z*(width+1)+x];
    const int w=width/step,h=height/step;
    std::vector<std::uint8_t> result(w*h,0);
    for (int z=0;z<h;++z) for (int x=0;x<w;++x) {
        const int cx=x*step+step/2,cz=z*step+step/2;
        const int a=cx-clearance,b=cz-clearance,c=cx+clearance+1,d=cz+clearance+1;
        if (a<0||b<0||c>width||d>height) continue;
        result[z*w+x]=(sums[d*(width+1)+c]-sums[b*(width+1)+c]
            -sums[d*(width+1)+a]+sums[b*(width+1)+a])==0;
    }
    return result;
}

struct Rect { int x1,z1,x2,z2; };
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

// Planning-time deterministic Dijkstra. Open cells already include clearance
// for the widest factory product. Reuse is a cost preference, never permission
// to cross blocked terrain or to stop at a disconnected old corridor.
// O(V log V) time/O(V) scratch, explicitly bounded by maximumVisited.
inline Route Connect(int width, int height, int start,
        const std::vector<std::uint8_t>& open,
        const std::vector<std::uint8_t>& shared,
        const std::vector<std::uint8_t>& goals, int maximumVisited,
        int newCost = 10, int sharedCost = 4)
{
    Route result;
    if (width <= 0 || height <= 0 || width > 512 || height > 512
            || maximumVisited <= 0 || sharedCost <= 0 || newCost < sharedCost) return result;
    const int size = width * height;
    if (int(open.size()) != size || int(shared.size()) != size || int(goals.size()) != size
            || start < 0 || start >= size || !open[start]) return result;
    using Entry = std::pair<int, int>;
    std::priority_queue<Entry, std::vector<Entry>, std::greater<Entry>> pending;
    std::vector<int> costs(size, std::numeric_limits<int>::max()), parent(size, -1);
    costs[start] = 0;
    pending.emplace(0, start);
    while (!pending.empty()) {
        const auto [cost, cell] = pending.top();
        pending.pop();
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
            pending.emplace(candidate, next);
        }
    }
    return result;
}
}
