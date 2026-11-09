#ifndef CIRCUIT_RANGED_GEOMETRY_H
#define CIRCUIT_RANGED_GEOMETRY_H

#include <algorithm>
#include <bit>
#include <cmath>
#include <cstdint>
#include <limits>
#include <unordered_map>
#include <vector>

namespace circuit::ranged {
// Rounded per-hull offsets are not necessarily exactly collinear in float.
// Reduce inside a fixed corridor, never by pairwise angle accumulation: every
// removed point AND the final endpoint stay within halfError of the original
// run axis, bounding displacement from the emitted segment by 2*halfError.
// O(points + original-leg validation), O(1) scratch. Reversals, rejected legs,
// joining points and endpoints fence runs. This is opt-in SEA MOVE geometry;
// the exact reducers used by other controllers below remain unchanged.
template<class Position, class ClearLeg>
void CompactValidatedCorridorRoute(std::vector<Position>& route, ClearLeg clearLeg, double halfError) {
    if (route.size()<3 || !std::isfinite(halfError) || halfError<0) return;
    // A wholly bent path cannot save any orders. Avoid terrain callbacks in
    // that common coastal case, using the same criterion as the reducer.
    bool reducible=false;
    for (size_t index=2;index<route.size();++index) {
        const auto& anchor=route[index-2]; const auto& previous=route[index-1]; const auto& point=route[index];
        const double directionX=double(previous.x)-anchor.x, directionZ=double(previous.z)-anchor.z;
        const double offsetX=double(point.x)-anchor.x, offsetZ=double(point.z)-anchor.z;
        const double lengthSquared=directionX*directionX+directionZ*directionZ;
        const double cross=offsetX*directionZ-offsetZ*directionX;
        if (lengthSquared>0 && offsetX*directionX+offsetZ*directionZ>=lengthSquared
            && cross*cross<=halfError*halfError*lengthSquared) { reducible=true; break; }
    }
    if (!reducible) return;
    size_t output=1;
    Position previous=route.front(), anchor=previous;
    double directionX=0, directionZ=0, lengthSquared=0, previousProjection=0;
    bool active=false;
    for (size_t index=1;index<route.size();++index) {
        const Position point=route[index];
        const bool clear=clearLeg(previous,point);
        if (!clear) { active=false; }
        if (active && clear) {
            const double offsetX=double(point.x)-anchor.x, offsetZ=double(point.z)-anchor.z;
            const double cross=offsetX*directionZ-offsetZ*directionX;
            const double projection=offsetX*directionX+offsetZ*directionZ;
            if (projection>=previousProjection && cross*cross<=halfError*halfError*lengthSquared) {
                route[output-1]=point; previous=point; previousProjection=projection;
                continue;
            }
        }
        anchor=previous;
        directionX=double(point.x)-anchor.x; directionZ=double(point.z)-anchor.z;
        lengthSquared=directionX*directionX+directionZ*directionZ;
        previousProjection=lengthSquared;
        active=clear && lengthSquared>0;
        route[output++]=point; previous=point;
    }
    route.resize(output);
}

// Validate each original leg once. A rejected leg fences only its adjacent
// run, not every other straight run in the route. O(N + validation work),
// O(1) scratch; preserve the first point, each bend/reversal and both ends
// of rejected legs. Validation sees original points before in-place writes.
// Regression: route_command_test.cpp, isolated unsafe leg between clear runs.
template<class Position, class ClearLeg>
void CompactValidatedStraightRoute(std::vector<Position>& route, ClearLeg clearLeg) {
    if (route.size() < 3) return;
    // Avoid expensive terrain sampling when exact geometry cannot remove a
    // point at all. This preflight is linear, callback-free and allocation-free.
    bool reducible = false;
    for (size_t i = 2; i < route.size(); ++i) {
        const auto& a=route[i-2]; const auto& b=route[i-1]; const auto& c=route[i];
        const double ux=b.x-a.x, uz=b.z-a.z, vx=c.x-b.x, vz=c.z-b.z;
        if (ux*vz == uz*vx && ux*vx+uz*vz >= 0) { reducible=true; break; }
    }
    if (!reducible) return;
    size_t out = 1, runStart = 0;
    Position previous = route.front();
    for (size_t i = 1; i < route.size(); ++i) {
        const Position point = route[i];
        if (!clearLeg(previous, point)) runStart = out;
        previous = point;
        while (out >= runStart + 2) {
            const auto& a = route[out - 2]; const auto& b = route[out - 1];
            const double ux=b.x-a.x, uz=b.z-a.z, vx=point.x-b.x, vz=point.z-b.z;
            if (ux*vz != uz*vx || ux*vx+uz*vz < 0) break;
            --out;
        }
        route[out++] = point;
    }
    route.resize(out);
}

// Remove only redundant straight-line points, preserving every turn, reversal
// and both endpoints. In-place O(N), O(1) scratch; the exact XZ polyline is
// unchanged, so terrain/threat validation is not replaced by a shortcut. Grid
// routes often contain dozens of collinear cells, each formerly a network MOVE.
template<class Position>
void CompactStraightRoute(std::vector<Position>& route) {
    size_t out=0;
    for(size_t i=0;i<route.size();++i) {
        const Position point=route[i];
        while(out>=2) {
            const auto& a=route[out-2]; const auto& b=route[out-1];
            const double ux=b.x-a.x, uz=b.z-a.z, vx=point.x-b.x, vz=point.z-b.z;
            if(ux*vz!=uz*vx || ux*vx+uz*vz<0) break;
            --out;
        }
        route[out++]=point;
    }
    route.resize(out);
}

// Recoil CCommandAI::GetCancelQueued treats a Shift-Move within 17 elmos
// of a queued position as a toggle. The worker's grid endpoint and our exact
// firing slot can otherwise cancel each other and cause an endless replan.
// Only the overlapping tail is removed (O(k) removed waypoints); the caller validates the
// resulting complete route before issuing it. See D-228 and the native test.
template<class Position>
void AppendExactGoal(std::vector<Position>& route,const Position& goal) {
    while(!route.empty()) {
        const float x=route.back().x-goal.x, z=route.back().z-goal.z;
        if(x*x+z*z>=17.f*17.f) break;
        route.pop_back();
    }
    route.push_back(goal);
}

// Engine IDs are bounded and unique, but keep comparison-sort fallback for a
// malformed/extended callback result. Reused bits give O(N + bound/64) ordering
// with precisely std::sort's ascending output, not a persistent unit cache.
class OrderedIds {
public:
    explicit OrderedIds(int bound): bound(bound), bits((bound+63)/64) {}
    void Sort(std::vector<int>& ids,int count) {
        if(count<128) { std::sort(ids.begin(),ids.begin()+count); return; }
        std::fill(bits.begin(),bits.end(),0);
        for(int i=0;i<count;++i) {
            const int id=ids[i];
            if(id<0 || id>=bound || (bits[id/64]&(std::uint64_t(1)<<(id%64)))) {
                std::sort(ids.begin(),ids.begin()+count); return;
            }
            bits[id/64]|=std::uint64_t(1)<<(id%64);
        }
        int out=0;
        for(size_t word=0;word<bits.size();++word) {
            auto value=bits[word];
            while(value) { ids[out++]=int(word*64)+std::countr_zero(value); value&=value-1; }
        }
    }
private:
    int bound;
    std::vector<std::uint64_t> bits;
};

struct Point { float x = 0.f, z = 0.f; };
inline float DistanceSq(Point a, Point b) {
    const float x = a.x-b.x, z = a.z-b.z; return x*x+z*z;
}
inline float SegmentDistanceSq(Point p, Point a, Point b) {
    const float dx=b.x-a.x, dz=b.z-a.z, den=dx*dx+dz*dz;
    const float t=den>0.f ? std::clamp(((p.x-a.x)*dx+(p.z-a.z)*dz)/den,0.f,1.f) : 0.f;
    return DistanceSq(p,{a.x+dx*t,a.z+dz*t});
}
// Reject a route that enters known coverage even if its endpoint is safe.
// An already exposed unit may escape monotonically; it may not cross the
// coverage center or add exposure to another weapon. Tested by ranged tests.
inline bool SafeSegment(Point a, Point b, Point danger, float radius) {
    const float r2=radius*radius, start=DistanceSq(a,danger);
    if (start>=r2) return SegmentDistanceSq(danger,a,b)>=r2;
    return DistanceSq(b,danger)>start &&
        (a.x-danger.x)*(b.x-a.x)+(a.z-danger.z)*(b.z-a.z)>=0.f;
}
inline float ClosingSpeed(Point from, Point enemy, Point velocity) {
    const float d=std::sqrt(DistanceSq(from,enemy));
    return d>0.f ? std::max(0.f,((from.x-enemy.x)*velocity.x+(from.z-enemy.z)*velocity.z)/d) : 0.f;
}
inline float EscapeSeconds(float speed, float turnRate, float acceleration, bool forwardArc, float reaction) {
    // Engine turn units/frame and acceleration elmos/frame^2 -> seconds.
    // An escape MOVE points away from the enemy. A forward-facing hull may
    // need a full half-turn (32768 engine angle units), not a quarter-turn.
    // Underestimating this window lets fast assault units close during aiming.
    const float turn=forwardArc ? 32768.f/std::max(1.f,turnRate)/30.f : 0.f;
    const float accelerate=std::min(6.f,speed/std::max(1.f,acceleration*900.f));
    return reaction+turn+accelerate*.5f;
}
// D-294: a slow projectile cannot hit a fast, light target. Drift during
// flight is targetSpeed (elmo/s) * distance / (projectileSpeed elmo/frame * 30).
// Evasive when drift exceeds limit * (splash radius + target radius). A
// non-positive limit or projectile speed (beam/instant) is never evasive.
// O(1); called once per candidate mount only when the policy opts in.
inline bool Evasive(float distance, float projectileSpeed, float targetSpeed,
                    float splash, float radius, float limit) {
    if (!(limit>0.f) || !(projectileSpeed>0.f) || !(targetSpeed>0.f)) return false;
    const float flight=distance/(projectileSpeed*30.f);
    return targetSpeed*flight>limit*(std::max(0.f,splash)+std::max(0.f,radius));
}
// D-296: mark every cell of a row-major gw x gh grid (cellSize elmos) whose
// CENTRE lies within radius of (x, z), keeping the maximum value. Bounding-box
// iteration: O(radius^2 / cellSize^2). Non-finite or non-positive inputs and
// discs wholly off the grid write nothing. Returns the number of cells set.
inline int PaintDisc(std::vector<float>& grid, int gw, int gh, float cellSize,
                     float x, float z, float radius, float value) {
    if (gw<=0 || gh<=0 || !(cellSize>0.f) || grid.size()<size_t(gw)*size_t(gh)
        || !std::isfinite(x) || !std::isfinite(z) || !std::isfinite(radius) || !(radius>0.f)) return 0;
    const float x0f=std::floor((x-radius)/cellSize), x1f=std::floor((x+radius)/cellSize);
    const float z0f=std::floor((z-radius)/cellSize), z1f=std::floor((z+radius)/cellSize);
    if (x1f<0.f || z1f<0.f || x0f>=float(gw) || z0f>=float(gh)) return 0;
    const int x0=std::max(0,int(x0f)), x1=std::min(gw-1,int(x1f));
    const int z0=std::max(0,int(z0f)), z1=std::min(gh-1,int(z1f));
    const float r2=radius*radius;
    int painted=0;
    for (int cz=z0; cz<=z1; ++cz) {
        const float dz=(cz+.5f)*cellSize-z;
        for (int cx=x0; cx<=x1; ++cx) {
            const float dx=(cx+.5f)*cellSize-x;
            if (dx*dx+dz*dz>r2) continue;
            float& cell=grid[size_t(cz)*size_t(gw)+size_t(cx)];
            cell=std::max(cell,value); ++painted;
        }
    }
    return painted;
}
inline float UsefulScore(float cost, float hp, float damage, float reserved,
                         bool precision, bool heavy, bool los, float progress) {
    const float left=std::max(0.f,hp-reserved);
    const float useful=std::min(std::max(1.f,damage),left);
    // Claimed lethal salvos lower priority, but do not permanently blacklist a
    // target if all other shots are unavailable. Reservations expire on reload.
    const float efficiency=precision ? useful/std::max(1.f,damage) : 1.f;
    return (1.f+cost)*(.05f+.95f*efficiency)*(heavy?1.2f:1.f)*(los?1.f:.65f)*progress;
}

// Callback-owned storage for a map-sized grid, with a sparse overflow for legal
// negative/off-map coordinates. Configure only before use: touched holds bucket
// addresses. Clear visits last generation's occupied cells, not all historical
// buckets, and vector values retain capacity. No cached engine observation is
// reused. See ranged_geometry_test's ordered legacy oracle (D-221).
template<class T> class CellStore {
public:
    CellStore() = default;
    CellStore(const CellStore&) = delete;
    CellStore& operator=(const CellStore&) = delete;
    void Configure(int width, int height) {
        Clear(); overflow.clear(); dense.clear();
        columns=rows=0;
        // Very large/unknown maps retain the exact sparse path instead of an
        // unbounded allocation. Coordinates are never clamped into other cells.
        if(width>0 && height>0 && std::uint64_t(width)*height<=1048576) {
            columns=width; rows=height; dense.resize(size_t(width)*height);
        }
    }
    void Clear() {
        for(auto* bucket:touched) {
            if constexpr (requires { bucket->value.clear(); }) bucket->value.clear();
            else bucket->value=T{};
            bucket->active=false;
        }
        touched.clear();
        minX=minZ=std::numeric_limits<int>::max();
        maxX=maxZ=std::numeric_limits<int>::min();
    }
    T& Get(int x,int z) {
        Bucket& b=Inside(x,z) ? dense[size_t(z)*columns+x] : overflow[Key(x,z)];
        if(!b.active) {
            b.active=true; touched.push_back(&b);
            minX=std::min(minX,x); maxX=std::max(maxX,x);
            minZ=std::min(minZ,z); maxZ=std::max(maxZ,z);
        }
        return b.value;
    }
    const T* Find(int x,int z) const {
        if(Inside(x,z)) { const auto& b=dense[size_t(z)*columns+x]; return b.active?&b.value:nullptr; }
        const auto it=overflow.find(Key(x,z));
        return it!=overflow.end() && it->second.active ? &it->second.value : nullptr;
    }
    bool Clip(int& x0,int& z0,int& x1,int& z1) const {
        x0=std::max(x0,minX); x1=std::min(x1,maxX);
        z0=std::max(z0,minZ); z1=std::min(z1,maxZ);
        return x0<=x1 && z0<=z1;
    }
private:
    struct Bucket { T value{}; bool active=false; };
    bool Inside(int x,int z) const { return x>=0 && z>=0 && x<columns && z<rows; }
    static std::uint64_t Key(int x,int z) { return (std::uint64_t(std::uint32_t(x))<<32)|std::uint32_t(z); }
    int columns=0,rows=0;
    int minX=std::numeric_limits<int>::max(),minZ=minX;
    int maxX=std::numeric_limits<int>::min(),maxZ=maxX;
    std::vector<Bucket> dense;
    // unordered_map rehash preserves element addresses used by touched.
    std::unordered_map<std::uint64_t,Bucket> overflow;
    std::vector<Bucket*> touched;
};

// Build O(N); clear O(previously occupied cells); queries cost intersecting
// occupied-bounds cells + results. Preserve z/x/insertion traversal exactly.
// Any is only for side-effect-free existence predicates, never scored sums.
class SpatialIndex {
public:
    explicit SpatialIndex(float cell=512.f): cell(cell) {}
    // Callers with a legacy linear fallback can preserve its floating-point
    // semantics for invalid or extreme inputs without an undefined float/int
    // conversion. Double arithmetic also avoids overflow while testing bounds.
    bool CanQuery(Point point,float radius) const {
        const double limit=double(std::numeric_limits<int>::max())-1.0;
        return cell>0.f && std::isfinite(cell) && std::isfinite(radius) && radius>=0.f
            && std::isfinite(point.x) && std::isfinite(point.z)
            && (std::abs(double(point.x))+double(radius))/cell<limit
            && (std::abs(double(point.z))+double(radius))/cell<limit;
    }
    void Configure(float width,float height) { cells.Configure(Coord(width)+1,Coord(height)+1); }
    void Clear() { cells.Clear(); }
    void Add(Point p, int id) { cells.Get(Coord(p.x),Coord(p.z)).push_back(id); }
    void Remove(Point p, int id) {
        // Get only after Find succeeds: a removal must not allocate/touch a
        // previously empty cell or change insertion order of surviving IDs.
        const int x=Coord(p.x),z=Coord(p.z);
        if(cells.Find(x,z)) std::erase(cells.Get(x,z),id);
    }
    template<class F> void Query(Point p, float radius, F&& visit) const {
        int x0=Coord(p.x-radius), x1=Coord(p.x+radius);
        int z0=Coord(p.z-radius), z1=Coord(p.z+radius);
        if(!cells.Clip(x0,z0,x1,z1)) return;
        for (int z=z0;z<=z1;++z) for(int x=x0;x<=x1;++x) {
            const auto* values=cells.Find(x,z);
            if(values) for(int id:*values) visit(id);
        }
    }
    template<class F> bool Any(Point p,float radius,F&& predicate) const {
        int x0=Coord(p.x-radius),x1=Coord(p.x+radius);
        int z0=Coord(p.z-radius),z1=Coord(p.z+radius);
        if(!cells.Clip(x0,z0,x1,z1)) return false;
        for(int z=z0;z<=z1;++z) for(int x=x0;x<=x1;++x) {
            const auto* values=cells.Find(x,z);
            if(values) for(int id:*values) if(predicate(id)) return true;
        }
        return false;
    }
private:
    int Coord(float v) const { return int(std::floor(v/cell)); }
    float cell;
    CellStore<std::vector<int>> cells;
};

// D-462: a SpatialIndex whose cells are filled on first touch within one
// generation (one observation frame). The caller's loader appends a cell's
// values in the order a full build would have inserted them; queries then
// visit exactly the z/x/insertion sequence of a SpatialIndex holding the same
// data. Coordinates are clipped to the configured grid, so every value must
// lie inside it (the ranged reader corrects positions onto the map first).
// FillPass lets a full read complete every unloaded cell without disturbing
// cells already loaded in this generation. Reset is O(previously loaded
// cells); a query costs its intersecting cells, each loaded at most once per
// generation, plus results. Engine-free: tests/ranged_geometry_test.cpp
// compares it with SpatialIndex on random data and query orders.
class LazySpatialIndex {
public:
    explicit LazySpatialIndex(float cell=512.f): cell(cell) {}
    void Configure(float width,float height) {
        columns=std::max(1,Coord(width)+1); rows=std::max(1,Coord(height)+1);
        cells.assign(size_t(columns)*size_t(rows),Cell{});
        touched.clear(); complete=false; generation=1;
    }
    void Reset() {
        for(const int index:touched) cells[size_t(index)].values.clear();
        touched.clear(); complete=false; distinct=0;
        ++generation; // generation 0 is never current: fresh cells start unloaded
    }
    // Distinct cells queries visited in this generation, loaded or not; the
    // caller's load policy (cell by cell or one full read) may use it.
    int Touched() const { return distinct; }
    int Columns() const { return columns; }
    int Rows() const { return rows; }
    float CellSize() const { return cell; }
    int Coord(float v) const { return int(std::floor(v/cell)); }
    bool Inside(int x,int z) const { return x>=0 && z>=0 && x<columns && z<rows; }
    bool Complete() const { return complete; }
    bool Loaded(int x,int z) const { return complete || (Inside(x,z) && At(x,z).generation==generation); }
    // Marks an unloaded cell loaded and calls load(x,z), which appends its
    // values in full-build order. Loading the same cell again is a no-op.
    template<class Load> void Ensure(int x,int z,Load&& load) {
        if(complete || !Inside(x,z)) return;
        Cell& c=At(x,z);
        if(c.generation==generation) return;
        c.generation=generation; c.pass=0; touched.push_back(Index(x,z));
        load(x,z);
    }
    void Append(int x,int z,int value) { if(Inside(x,z)) At(x,z).values.push_back(value); }
    // A full read: BeginPass, then for every value in global full-build order
    // Admit(cell) and Append when admitted, then MarkComplete. Cells already
    // loaded earlier in this generation are refused; unloaded cells are
    // claimed by the pass, so later values of the same cell are admitted too.
    int BeginPass() { return ++pass; }
    bool Admit(int x,int z,int fillPass) {
        if(complete || !Inside(x,z)) return false;
        Cell& c=At(x,z);
        if(c.generation==generation) return c.pass==fillPass;
        c.generation=generation; c.pass=fillPass; touched.push_back(Index(x,z));
        return true;
    }
    void MarkComplete() { complete=true; }
    // Lets a full pass started from inside load(x,z) fill that same cell,
    // which Ensure already marked loaded (and is still empty).
    void Adopt(int x,int z,int fillPass) {
        if(!Inside(x,z)) return;
        Cell& c=At(x,z);
        if(c.generation==generation && c.values.empty()) c.pass=fillPass;
    }
    template<class Load,class F> void Query(Point p,float radius,Load&& load,F&& visit) {
        int x0=Coord(p.x-radius),x1=Coord(p.x+radius),z0=Coord(p.z-radius),z1=Coord(p.z+radius);
        if(!Clip(x0,z0,x1,z1)) return;
        for(int z=z0;z<=z1;++z) for(int x=x0;x<=x1;++x) {
            Visit(x,z); Ensure(x,z,load);
            // A nested query may load other cells while visit runs; the cell
            // storage never moves and a loaded cell never changes this generation.
            const auto& values=At(x,z).values;
            for(size_t i=0;i<values.size();++i) visit(values[i]);
        }
    }
    template<class Load,class F> bool Any(Point p,float radius,Load&& load,F&& predicate) {
        int x0=Coord(p.x-radius),x1=Coord(p.x+radius),z0=Coord(p.z-radius),z1=Coord(p.z+radius);
        if(!Clip(x0,z0,x1,z1)) return false;
        for(int z=z0;z<=z1;++z) for(int x=x0;x<=x1;++x) {
            Visit(x,z); Ensure(x,z,load);
            const auto& values=At(x,z).values;
            for(size_t i=0;i<values.size();++i) if(predicate(values[i])) return true;
        }
        return false;
    }
    const std::vector<int>* Values(int x,int z) const { return Loaded(x,z) && Inside(x,z) ? &At(x,z).values : nullptr; }
private:
    struct Cell { std::vector<int> values; unsigned generation=0, visited=0; int pass=0; };
    int Index(int x,int z) const { return z*columns+x; }
    void Visit(int x,int z) { Cell& c=At(x,z); if(c.visited!=generation) { c.visited=generation; ++distinct; } }
    Cell& At(int x,int z) { return cells[size_t(Index(x,z))]; }
    const Cell& At(int x,int z) const { return cells[size_t(Index(x,z))]; }
    bool Clip(int& x0,int& z0,int& x1,int& z1) const {
        x0=std::max(x0,0); z0=std::max(z0,0); x1=std::min(x1,columns-1); z1=std::min(z1,rows-1);
        return x0<=x1 && z0<=z1;
    }
    float cell;
    int columns=0, rows=0, pass=0, distinct=0;
    unsigned generation=1;
    bool complete=false;
    std::vector<Cell> cells;
    std::vector<int> touched;
};

// D-462: an id-keyed table with the visible behaviour of a map that erases,
// at every Prune(frame), each entry whose `seen` is more than `horizon`
// frames before that prune. The erase is decided when an entry is next read
// or written instead: an entry not written since an earlier prune is absent
// iff (last prune frame - seen) > horizon, because seen only changes on a
// write and prune frames only increase. Prune is O(1); Find and Touch are
// O(1) for ids in [0, bound) (dense, allocated on first write) and expected
// O(1) otherwise (sparse overflow, swept every sweepPrunes prunes). Values
// of an absent entry are reset on the next Touch, as a fresh insert would be.
// Engine-free: tests/ranged_geometry_test.cpp runs it against an erasing
// unordered_map under random operation sequences.
template<class T> class ExpiringTable {
public:
    struct Entry { T value{}; int seen=0; };
    ExpiringTable(int bound,int horizon,unsigned sweepPrunes=1800):
        bound(std::max(0,bound)), horizon(horizon), sweepPrunes(std::max(1u,sweepPrunes)) {}
    const Entry* Find(int id) const {
        const Slot* s=Lookup(id);
        return s && !Absent(*s) ? &s->entry : nullptr;
    }
    Entry& Touch(int id) {
        Slot& s=Get(id);
        if(Absent(s)) { s.entry=Entry{}; s.used=true; }
        s.epoch=epoch;
        return s.entry;
    }
    void Prune(int frame) {
        lastPrune=frame; ++epoch;
        if(++sincePrune<sweepPrunes) return;
        sincePrune=0;
        for(auto it=overflow.begin();it!=overflow.end();) it=Absent(it->second) ? overflow.erase(it) : std::next(it);
    }
    size_t OverflowSize() const { return overflow.size(); }
private:
    struct Slot { Entry entry; unsigned epoch=0; bool used=false; };
    bool Absent(const Slot& s) const {
        return !s.used || (s.epoch<epoch && double(lastPrune)-double(s.entry.seen)>double(horizon));
    }
    const Slot* Lookup(int id) const {
        if(id>=0 && id<bound) return size_t(id)<dense.size() ? &dense[size_t(id)] : nullptr;
        const auto it=overflow.find(id);
        return it==overflow.end() ? nullptr : &it->second;
    }
    Slot& Get(int id) {
        if(id>=0 && id<bound) {
            if(dense.empty()) dense.resize(size_t(bound));
            return dense[size_t(id)];
        }
        return overflow[id];
    }
    int bound, horizon;
    unsigned sweepPrunes, sincePrune=0, epoch=0;
    int lastPrune=0;
    std::vector<Slot> dense;
    std::unordered_map<int,Slot> overflow;
};
}
#endif
