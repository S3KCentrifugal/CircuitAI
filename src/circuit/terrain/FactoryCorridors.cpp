// Factory-to-lane routing and reservation lifetime. Role policy is supplied by script.
#include "terrain/TerrainManager.h"
#include "terrain/FactoryCorridor.h"
#include "terrain/TerrainData.h"
#include "module/BuilderManager.h"
#include "module/FactoryManager.h"
#include "scheduler/Scheduler.h"
#include "CircuitAI.h"
#include "spring/SpringMap.h"
#include "util/Utils.h"
#include "util/Performance.h"
#include "Log.h"
#include <charconv>
#include <cstdlib>

namespace circuit {
using namespace springai;
namespace {
constexpr int CELL = 16, STEP = 2, RADIUS = 256;
constexpr const char* PREFIX = "native.factoryRoutes.";
bool SameSite(const AIFloat3& a, const AIFloat3& b) { return a.SqDistance2D(b) < 1.f; }
}

void CTerrainManager::SetFactoryCorridorPolicy(bool enabled, bool ownLane, int exemptDef)
{
    const bool changed=factoryCorridorsEnabled!=(enabled && layoutConfigured) || factoryCorridorOwnLane!=ownLane;
    factoryCorridorsEnabled = enabled && layoutConfigured;
    factoryCorridorOwnLane = ownLane;
    factoryCorridorExemptDef = GetLayoutInt(std::string(PREFIX)+"promoted",0) ? -1 : exemptDef;
    layoutInts[std::string(PREFIX)+"enabled"] = factoryCorridorsEnabled;
    layoutInts[std::string(PREFIX)+"own"] = ownLane;
    layoutInts[std::string(PREFIX)+"exempt"] = factoryCorridorExemptDef;
    if (changed) {
        for (auto& [id,r] : factoryRoutes) { r.lane=-1;r.retry=0; }
        QueueFactoryRouteRefresh();
    }
}

void CTerrainManager::SetFactoryLane(int team, const std::vector<AIFloat3>& points)
{
    if (team < 0 || points.size() > 4096) return;
    for (const auto& p : points) if (!std::isfinite(p.x) || !std::isfinite(p.z)
        || p.x < 0 || p.z < 0 || p.x >= blockingMap.columns*CELL || p.z >= blockingMap.rows*CELL) return;
    const auto previous = factoryLanes.find(team);
    if (previous != factoryLanes.end() && previous->second.size() == points.size()) {
        bool equal = true;
        for (std::size_t i=0;i<points.size();++i) if (!SameSite(points[i],previous->second[i])) { equal=false; break; }
        if (equal) return;
    }
    if (points.size()<2) factoryLanes.erase(team); else factoryLanes[team]=points;
    // Publication, not a polling scan. Keep the old exclusion until replacement
    // is committed; an invalidated route is never accepted for a new factory.
    for (auto& [id,r] : factoryRoutes) {
        r.lane=-1; r.retry=0;
    }
    QueueFactoryRouteRefresh();
    SaveFactoryRoutes();
}

void CTerrainManager::SetFactoryCorridorOptions(int probes,int visits,float goalStart,float goalEnd)
{
    factoryRouteProbeLimit=std::clamp(probes,1,16);
    factoryRouteVisitLimit=std::clamp(visits,256,65536);
    factoryRouteGoalStart=std::isfinite(goalStart)?std::clamp(goalStart,0.f,4096.f):768.f;
    factoryRouteGoalEnd=std::isfinite(goalEnd)?std::clamp(goalEnd,factoryRouteGoalStart,8192.f):2048.f;
    layoutInts[std::string(PREFIX)+"probes"]=factoryRouteProbeLimit;
    layoutInts[std::string(PREFIX)+"visits"]=factoryRouteVisitLimit;
    layoutInts[std::string(PREFIX)+"goalStart"]=int(factoryRouteGoalStart);
    layoutInts[std::string(PREFIX)+"goalEnd"]=int(factoryRouteGoalEnd);
}

bool CTerrainManager::FactoryCorridorBlocked(const int2& a, const int2& b) const
{
    return factoryCorridorCoverage.OverlapsOther(-1,{a.x,a.y,b.x,b.y});
}

bool CTerrainManager::FactoryCorridorCellOpen(int x,int z,const std::vector<ExitMovementFacts>& facts) const
{
    if (!blockingMap.IsInBounds(x,z) || blockingMap.IsResourceSite(x,z)) return false;
    const auto& cell=blockingMap.grid[z*blockingMap.columns+x];
    // Building-yard spacing is not a movement obstacle. Actual footprints and
    // immutable resource plots are; reservations are checked in the claim raster.
    if (static_cast<unsigned>(cell.structMask)&~unsigned(SBlockingMap::StructMask::RESERVED)) return false;
    const auto& slopes=terrainData->GetSlopeMap();
    const auto si=std::size_t(z)*terrainData->GetSlopeMapXSize()+x;
    if (si>=slopes.size() || !std::isfinite(slopes[si])) return false;
    const float elevation=areaData->GetElevationAt(x*CELL+8.f,z*CELL+8.f);
    if (!std::isfinite(elevation)) return false;
    for (const auto& f : facts) if (elevation < -f.depth
        || (!(f.hover&&elevation<0.f) && slopes[si]>f.slope)) return false;
    return true;
}

void CTerrainManager::ShareFactoryRoute(const FactoryRoute& r, bool add)
{
    auto& shared=circuit->GetAllyTeam()->GetLayoutReservations();
    // Each route owns its rectangles independently. Overlapping trunks retain
    // exclusion when either route is released. Negative EXIT IDs cannot collide
    // with ordinary positive zone IDs. At most 512 segments per bounded route.
    for (std::size_t i=0;i<r.rectangles.size();++i) {
        const int id=-(r.id*1024+int(i)+1);
        factoryCorridorCoverage.ChangeCells(circuit->GetTeamId(),r.rectangles[i],add);
        if (add) shared.Put(circuit->GetTeamId(),allied_layout::Reservations::EXIT,id,r.rectangles[i]);
        else shared.Erase(circuit->GetTeamId(),allied_layout::Reservations::EXIT,id);
    }
    ++packingRevision;
}

bool CTerrainManager::EnsureFactoryCorridor(CCircuitDef* def, const AIFloat3& position, int facing, bool planning)
{
    if (!factoryCorridorsEnabled || !def || def->IsMobile() || def->GetId()==factoryCorridorExemptDef
        || !circuit->GetFactoryManager()->GetFactoryDef(def)) return true;
    const auto& facts=FactoryMovementFacts(def);
    if (facts.empty()) return true; // aircraft-only and ship-only factories retain their existing exits
    const int frame=circuit->GetLastFrame();
    if (factoryRouteFrame!=frame) {
        factoryRouteFrame=frame; factoryRouteProbes=0;
        PruneFactoryRoutes();
    }
    if (facing<0 || facing>3 || !std::isfinite(position.x) || !std::isfinite(position.z)) return false;
    const auto pos=Pos2BuildPos(def,position,facing);
    int2 fa,fb;
    if (!ReservationCells(def,pos,facing,fa,fb)) return false;
    FactoryRoute* record=nullptr;
    for (auto& [id,r] : factoryRoutes) if (r.def==def->GetId() && r.facing==facing && SameSite(r.pos,pos)) { record=&r; break; }
    if (record && record->lane>=0 && !record->rectangles.empty()) {
        bool clear=true;
        for (const auto& r : record->rectangles) {
            for (int z=r.z1;z<r.z2&&clear;++z) for (int x=r.x1;x<r.x2;++x)
                if (!FactoryCorridorCellOpen(x,z,facts)) { clear=false;break; }
            if (!clear) break;
        }
        if (clear) return true;
        record->lane=-1; record->retry=0;
    }
    if (record && record->retry>frame) return false;
    bool hasLane=false;
    for (const auto& [team,points] : factoryLanes) if (!factoryCorridorOwnLane || team==circuit->GetTeamId()) hasLane=true;
    if (!hasLane) return planning; // pending layout is allowed, actual construction is not
    if (factoryRouteProbes>=factoryRouteProbeLimit) return false;
    ++factoryRouteProbes;
    performance::Scope timing(circuit,performance::LAYOUT_PLACE);
    if (!record) {
        if (nextFactoryRoute>=1000000 || factoryRoutes.size()>=256) return false;
        auto& r=factoryRoutes[nextFactoryRoute]; r.id=nextFactoryRoute++;
        r.def=def->GetId(); r.facing=facing; r.pos=pos; record=&r;
    }
    record->retry=frame+5*FRAMES_PER_SEC;
    float half=16.f;
    for (const auto& f : facts) half=std::max(half,f.halfWidth);
    const int clearance=int(std::ceil(half/CELL))+1;
    const auto [sx,sz]=factory_corridor::Mouth({fa.x,fa.y,fb.x,fb.y},facing,clearance,STEP);
    if (!blockingMap.IsInBounds(sx,sz)) return false;
    const int x0=std::max(0,sx-RADIUS), z0=std::max(0,sz-RADIUS);
    const int x1=std::min(blockingMap.columns,x0+2*RADIUS), z1=std::min(blockingMap.rows,z0+2*RADIUS);
    const int w=x1-x0,h=z1-z0;
    std::vector<uint8_t> blocked(w*h,0), reused(w*h,0);
    const auto paint=[&](const allied_layout::Rect& r, std::vector<uint8_t>& grid, uint8_t value) {
        for (int z=std::max(z0,r.z1);z<std::min(z1,r.z2);++z)
            for (int x=std::max(x0,r.x1);x<std::min(x1,r.x2);++x) grid[(z-z0)*w+x-x0]=value;
    };
    // Our envelope is space we may allocate, not an occupied building. Carve
    // roads through its unused cells; slot/task/structure footprints remain hard
    // obstacles and FactoryCorridorBlocked protects the road from later packing.
    // Allied envelopes remain protected unless they already contain an exit.
    for (const auto& [id,z] : zones) if (z.corridor)
        paint({z.c1.x,z.c1.y,z.c2.x,z.c2.y},reused,1);
    const allied_layout::Rect window{x0,z0,x1,z1};
    auto& allies=circuit->GetAllyTeam()->GetLayoutReservations();
    std::vector<uint8_t> allyZones(w*h,0), allyExits(w*h,0);
    allies.ForEachOther(circuit->GetTeamId(),allied_layout::Reservations::ZONE,window,[&](const auto& r){paint(r,allyZones,1);});
    allies.ForEachOther(circuit->GetTeamId(),allied_layout::Reservations::EXIT,window,[&](const auto& r){paint(r,allyExits,1);});
    for (int i=0;i<w*h;++i) { if (allyZones[i]&&!allyExits[i]) blocked[i]=1; if (allyExits[i]) reused[i]=1; }
    for (auto kind : {allied_layout::Reservations::SLOT,allied_layout::Reservations::TASK,allied_layout::Reservations::STRUCTURE})
        allies.ForEachOther(-1,kind,window,[&](const auto& r){paint(r,blocked,1);}); // hard claims include our own ordinary tasks
    for (const auto& [id,r] : reservations) {
        int2 a,b; if (ReservationCells(r.def,r.pos,r.facing,a,b)) paint({a.x,a.y,b.x,b.y},blocked,1);
    }
    // Ordinary fallback candidates have no slot/task footprint yet. Without
    // this provisional obstacle a road can cross the factory it must serve,
    // then its EXIT claim prevents the factory build order from being admitted.
    paint({fa.x,fa.y,fb.x,fb.y},blocked,1);
    for (const auto& [id,r] : factoryRoutes) for (const auto& rect : r.rectangles) paint(rect,reused,1);
    for (int z=z0;z<z1;++z) for (int x=x0;x<x1;++x) {
        const int i=(z-z0)*w+x-x0;
        if (blocked[i]) continue;
        blocked[i]=!FactoryCorridorCellOpen(x,z,facts);
    }
    // Integral occupancy: O(W*H + V), rather than footprint scans at every
    // Dijkstra neighbour. Terrain/claims are fresh for each bounded planning ask.
    const int gw=w/STEP,gh=h/STEP;
    const auto open=factory_corridor::OpenCentres(w,h,blocked,STEP,clearance);
    std::vector<uint8_t> reuse(gw*gh,0),goals(gw*gh,0);
    std::vector<int> owners(gw*gh,-1);
    for (int z=0;z<gh;++z) for (int x=0;x<gw;++x) {
        const int cx=x*STEP+1,cz=z*STEP+1;
        reuse[z*gw+x]=reused[cz*w+cx];
    }
    // Only the homeward 2048 elmos of each published lane are connection goals.
    // This prevents a base route from travelling down the front or into an enemy base.
    for (const auto& [team,points] : factoryLanes) {
        if (factoryCorridorOwnLane && team!=circuit->GetTeamId()) continue;
        float walked=0.f;
        for (std::size_t i=1;i<points.size()&&walked<factoryRouteGoalEnd;++i) {
            const auto delta=points[i]-points[i-1]; const float length=std::sqrt(delta.SqLength2D());
            const float usable=std::min(length,factoryRouteGoalEnd-walked);
            if (length>0.f) for (float t=std::max(0.f,factoryRouteGoalStart-walked);t<=usable;t+=16.f) {
                const auto p=points[i-1]+delta*(t/length);
                const int x=(int(p.x/CELL)-x0)/STEP,z=(int(p.z/CELL)-z0)/STEP;
                if (p.x<x0*CELL||p.z<z0*CELL||x<0||z<0||x>=gw||z>=gh) continue;
                const int cell=z*gw+x; if (owners[cell]<0) { goals[cell]=1; owners[cell]=team; }
            }
            walked+=length;
        }
    }
    const int start=((sz-z0)/STEP)*gw+(sx-x0)/STEP;
    auto route=factory_corridor::Connect(gw,gh,start,open,reuse,goals,factoryRouteVisitLimit);
    if (route.cells.empty()) {
        if (std::getenv("CIRCUIT_FACTORY_CORRIDOR_TRACE")) circuit->LOG(
            "[FactoryCorridorTrace] def=%s facing=%d site=%.0f,%.0f startOpen=%d goals=%u visited=%d exhausted=%d",
            def->GetDef()->GetName(),facing,pos.x,pos.z,int(open[start]),
            unsigned(std::count(goals.begin(),goals.end(),1)),route.visited,int(route.exhausted));
        return false;
    }
    std::vector<allied_layout::Rect> rectangles;
    for (const auto& r : factory_corridor::Rectangles(route.cells,gw,x0,z0,STEP,clearance))
        rectangles.push_back({r.x1,r.z1,r.x2,r.z2});
    if (rectangles.empty()) return false;
    // Connect the reserved road to the factory's mouth, including ordinary
    // fallback factories which have no pre-existing short exit zone.
    const int cx=int(pos.x/CELL),cz=int(pos.z/CELL);
    allied_layout::Rect stem{cx-clearance,cz-clearance,cx+clearance+1,cz+clearance+1};
    const auto& first=rectangles.front();
    if (facing==0) { stem.z1=fb.y;stem.z2=first.z2; }
    else if (facing==1) { stem.x1=fb.x;stem.x2=first.x2; }
    else if (facing==2) { stem.z1=first.z1;stem.z2=fa.y; }
    else { stem.x1=first.x1;stem.x2=fa.x; }
    if (!stem.Valid()||stem.x1<x0||stem.z1<z0||stem.x2>x1||stem.z2>z1) return false;
    for (int z=stem.z1;z<stem.z2;++z) for (int x=stem.x1;x<stem.x2;++x)
        if (blocked[(z-z0)*w+x-x0]) {
            if (std::getenv("CIRCUIT_FACTORY_CORRIDOR_TRACE")) circuit->LOG("[FactoryCorridorTrace] def=%s stem blocked at %d,%d",def->GetDef()->GetName(),x,z);
            return false;
        }
    rectangles.push_back(stem);
    if (rectangles.size()>512) return false;
    ShareFactoryRoute(*record,false);
    record->rectangles=std::move(rectangles); record->lane=owners[route.cells.back()];
    ShareFactoryRoute(*record,true); SaveFactoryRoutes();
    circuit->LOG("[FactoryCorridor] def=%s lane=%d segments=%u visited=%d team=%d site=%.0f,%.0f facing=%d",def->GetDef()->GetName(),record->lane,unsigned(record->rectangles.size()),route.visited,circuit->GetTeamId(),pos.x,pos.z,facing);
    return true;
}

void CTerrainManager::SaveFactoryRoutes()
{
    SetFactoryCorridorOptions(factoryRouteProbeLimit,factoryRouteVisitLimit,factoryRouteGoalStart,factoryRouteGoalEnd);
    layoutInts[std::string(PREFIX)+"enabled"]=factoryCorridorsEnabled;
    layoutInts[std::string(PREFIX)+"own"]=factoryCorridorOwnLane;
    layoutInts[std::string(PREFIX)+"exempt"]=factoryCorridorExemptDef;
    const std::string lanes=std::string(PREFIX)+"lane.";
    for (auto it=layoutInts.lower_bound(lanes);it!=layoutInts.end()&&it->first.rfind(lanes,0)==0;) it=layoutInts.erase(it);
    for (const auto& [team,points] : factoryLanes) {
        const auto key=lanes+std::to_string(team)+".";
        layoutInts[key+"count"]=int(points.size());
        for (std::size_t i=0;i<points.size();++i) {
            layoutInts[key+std::to_string(i)+".x"]=int(points[i].x);
            layoutInts[key+std::to_string(i)+".z"]=int(points[i].z);
        }
    }
    const std::string prefix=std::string(PREFIX)+"route.";
    for (auto it=layoutInts.lower_bound(prefix);it!=layoutInts.end()&&it->first.rfind(prefix,0)==0;) it=layoutInts.erase(it);
    layoutInts[std::string(PREFIX)+"next"]=nextFactoryRoute;
    for (const auto& [id,r] : factoryRoutes) {
        const auto k=prefix+std::to_string(id)+".";
        layoutInts[k+"def"]=r.def; layoutInts[k+"x"]=int(r.pos.x); layoutInts[k+"z"]=int(r.pos.z);
        layoutInts[k+"facing"]=r.facing; layoutInts[k+"count"]=int(r.rectangles.size());
        for (std::size_t i=0;i<r.rectangles.size();++i) {
            const auto s=k+std::to_string(i)+"."; const auto& a=r.rectangles[i];
            layoutInts[s+"x1"]=a.x1; layoutInts[s+"z1"]=a.z1; layoutInts[s+"x2"]=a.x2; layoutInts[s+"z2"]=a.z2;
        }
    }
}

void CTerrainManager::ClearFactoryRoutes()
{
    for (const auto& [id,r] : factoryRoutes) ShareFactoryRoute(r,false);
    factoryRoutes.clear(); factoryLanes.clear(); factoryRouteRefresh.clear(); nextFactoryRoute=1;
}

void CTerrainManager::LoadFactoryRoutes()
{
    SetFactoryCorridorOptions(GetLayoutInt(std::string(PREFIX)+"probes",4),GetLayoutInt(std::string(PREFIX)+"visits",32768),
        float(GetLayoutInt(std::string(PREFIX)+"goalStart",768)),float(GetLayoutInt(std::string(PREFIX)+"goalEnd",2048)));
    SetFactoryCorridorPolicy(GetLayoutInt(std::string(PREFIX)+"enabled",0)!=0,
        GetLayoutInt(std::string(PREFIX)+"own",0)!=0,GetLayoutInt(std::string(PREFIX)+"exempt",-1));
    nextFactoryRoute=std::clamp(GetLayoutInt(std::string(PREFIX)+"next",1),1,1000000);
    const std::string lanes=std::string(PREFIX)+"lane.";
    for (auto it=layoutInts.lower_bound(lanes);it!=layoutInts.end()&&it->first.rfind(lanes,0)==0;++it) {
        if (!it->first.ends_with(".count")||it->second<2||it->second>4096) continue;
        const auto k=it->first.substr(0,it->first.size()-5);
        int team=-1; const auto parsed=std::from_chars(k.data()+lanes.size(),k.data()+k.size()-1,team);
        if (parsed.ec!=std::errc{}||parsed.ptr!=k.data()+k.size()-1||team<0) continue;
        std::vector<AIFloat3> points;
        for (int i=0;i<it->second;++i) {
            const auto s=k+std::to_string(i)+".";
            const int x=GetLayoutInt(s+"x",-1),z=GetLayoutInt(s+"z",-1);
            if (x<0||z<0||x>=blockingMap.columns*CELL||z>=blockingMap.rows*CELL) { points.clear();break; }
            points.emplace_back(float(x),0.f,float(z));
        }
        if (points.size()>1) factoryLanes.emplace(team,std::move(points));
    }
    const std::string prefix=std::string(PREFIX)+"route.";
    for (auto it=layoutInts.lower_bound(prefix);it!=layoutInts.end()&&it->first.rfind(prefix,0)==0;++it) {
        if (!it->first.ends_with(".def")) continue;
        const auto k=it->first.substr(0,it->first.size()-3);
        FactoryRoute r; r.def=it->second;
        const char* begin=k.data()+prefix.size();
        const char* end=k.data()+k.size()-1;
        const auto parsed=std::from_chars(begin,end,r.id);
        if (parsed.ec!=std::errc{} || parsed.ptr!=end) continue;
        if (r.id<=0||r.id>=nextFactoryRoute||!circuit->GetCircuitDef(r.def)) continue;
        r.pos=AIFloat3(float(GetLayoutInt(k+"x",-1)),0.f,float(GetLayoutInt(k+"z",-1)));
        r.facing=GetLayoutInt(k+"facing",-1);
        const int count=GetLayoutInt(k+"count",0);
        if (count<0||count>512||r.facing<0||r.facing>3) continue;
        for (int i=0;i<count;++i) {
            const auto s=k+std::to_string(i)+".";
            allied_layout::Rect a{GetLayoutInt(s+"x1",-1),GetLayoutInt(s+"z1",-1),GetLayoutInt(s+"x2",-1),GetLayoutInt(s+"z2",-1)};
            if (!a.Valid()||a.x2>blockingMap.columns||a.z2>blockingMap.rows) { r.rectangles.clear(); break; }
            r.rectangles.push_back(a);
        }
        factoryRoutes.emplace(r.id,r); ShareFactoryRoute(r,true);
    }
}

void CTerrainManager::PruneFactoryRoutes()
{
    // Lifecycle-only O(routes*(slots+factories+factory tasks)); no army or per-frame scan.
    bool changed=false;
    for (auto it=factoryRoutes.begin();it!=factoryRoutes.end();) {
        const auto& r=it->second; bool used=r.retry>circuit->GetLastFrame();
        if (!used) for (const auto& [id,slot] : reservations) if (slot.def->GetId()==r.def&&SameSite(slot.pos,r.pos)) { used=true; break; }
        if (!used) for (const auto* task : circuit->GetBuilderManager()->GetTasks(IBuilderTask::BuildType::FACTORY))
            if (!task->IsDead()&&task->GetBuildDef()&&task->GetBuildDef()->GetId()==r.def&&SameSite(task->GetBuildPos(),r.pos)) { used=true; break; }
        if (!used) for (const auto& [id,site] : factoryRouteUnits)
            if (site.first==r.def&&SameSite(site.second,r.pos)) { used=true; break; }
        if (used) { ++it; continue; }
        ShareFactoryRoute(r,false); it=factoryRoutes.erase(it); changed=true;
    }
    if (changed) SaveFactoryRoutes();
}

void CTerrainManager::QueueFactoryRouteRefresh()
{
    factoryRouteRefresh.clear();
    // Release destroys the scheduler before the factory/builder managers.
    // Do not inspect those managers or reconstruct work during that teardown.
    if (!circuit->GetScheduler() || !factoryCorridorsEnabled || factoryLanes.empty()) return;
    // Event-driven O(factory slots + active routes), never a per-unit scan.
    // Capture values: Ensure may prune stale route records while draining.
    for (const auto& [id,r] : factoryRoutes) {
        FactoryRoute request; request.def=r.def;request.pos=r.pos;request.facing=r.facing;
        factoryRouteRefresh.push_back(std::move(request));
    }
    for (const auto& [id,r] : reservations) if (!r.consumed && !r.unitId
        && r.def->GetId()!=factoryCorridorExemptDef && circuit->GetFactoryManager()->GetFactoryDef(r.def)) {
        FactoryRoute request;request.def=r.def->GetId();request.pos=r.pos;request.facing=r.facing;
        factoryRouteRefresh.push_back(std::move(request));
    }
    DrainFactoryRouteRefresh();
}

void CTerrainManager::DrainFactoryRouteRefresh()
{
    if (factoryRouteRefreshQueued || factoryRouteRefresh.empty()) return;
    auto* scheduler = circuit->GetScheduler().get();
    if (!scheduler) return;
    factoryRouteRefreshQueued=true;
    const std::weak_ptr<int> lifetime=factoryRouteLifetime;
    scheduler->RunJobAfter(CScheduler::GameJob([this,lifetime]() {
        if (lifetime.expired()) return;
        factoryRouteRefreshQueued=false;
        int remaining=factoryRouteProbeLimit;
        while (remaining-- > 0 && !factoryRouteRefresh.empty()) {
            if (factoryRouteFrame==circuit->GetLastFrame() && factoryRouteProbes>=factoryRouteProbeLimit) break;
            auto request=std::move(factoryRouteRefresh.back());factoryRouteRefresh.pop_back();
            EnsureFactoryCorridor(circuit->GetCircuitDef(request.def),request.pos,request.facing,true);
        }
        DrainFactoryRouteRefresh();
    }),1);
}

void CTerrainManager::QueueFactoryRoutePrune()
{
    if (factoryRoutePruneQueued || factoryRoutes.empty()) return;
    // KI-736: ClearRelease still removes task claims after scheduler teardown.
    // That synchronous cleanup must succeed without queuing a future prune.
    // Borrow on the AI thread; do not extend scheduler lifetime across Release.
    auto* scheduler = circuit->GetScheduler().get();
    if (!scheduler) return;
    factoryRoutePruneQueued=true;
    const std::weak_ptr<int> lifetime=factoryRouteLifetime;
    scheduler->RunJobAfter(CScheduler::GameJob([this,lifetime]() {
        if (lifetime.expired()) return;
        factoryRoutePruneQueued=false;
        PruneFactoryRoutes();
    }),5*FRAMES_PER_SEC+1);
}
}

