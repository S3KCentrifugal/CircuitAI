#pragma once
#include "control/kernel/CommanderCombat.h"
#include <algorithm>
#include <cmath>
#include <vector>

namespace circuit { namespace commander {
// A synchronous local snapshot. Build exposed union arcs once (O(J^2 log J),
// O(J^2) worst-case storage); terrain candidates do no engine callbacks.
// Duplicate/contained circles and overlapping arcs are covered by the unit test.
class JammerCoverage {
public:
    struct Disc { Point center; float radius; };
    explicit JammerCoverage(std::vector<Disc> input={}):discs(std::move(input)) {
        constexpr float tau=6.28318530718f;
        std::vector<std::pair<float,float>> covered;
        for(size_t i=0;i<discs.size();++i) {
            const auto& a=discs[i];
            if(a.radius<=0) continue;
            covered.clear(); bool contained=false;
            for(size_t j=0;j<discs.size();++j) {
                if(i==j) continue;
                const auto& b=discs[j];
                const Point delta=b.center-a.center;
                const float distance=Length(delta);
                if(distance+a.radius<=b.radius) {
                    if(distance>0 || a.radius<b.radius || j<i) {contained=true;break;}
                    continue;
                }
                if(distance>=a.radius+b.radius || distance+b.radius<=a.radius || distance<=0) continue;
                float angle=std::atan2(delta.z,delta.x); if(angle<0) angle+=tau;
                const float half=std::acos(std::clamp((distance*distance+a.radius*a.radius-b.radius*b.radius)
                    /(2.f*distance*a.radius),-1.f,1.f));
                const float lo=angle-half,hi=angle+half;
                if(lo<0) {covered.emplace_back(0,hi);covered.emplace_back(lo+tau,tau);}
                else if(hi>tau) {covered.emplace_back(lo,tau);covered.emplace_back(0,hi-tau);}
                else covered.emplace_back(lo,hi);
            }
            if(contained) continue;
            std::sort(covered.begin(),covered.end());
            float end=0;
            for(const auto& interval:covered) {
                if(interval.first>end) arcs.push_back({a,end,interval.first});
                end=std::max(end,interval.second);
            }
            if(end<tau) arcs.push_back({a,end,tau});
        }
    }
    bool NearUnjammed(Point p,float margin) const {
        bool inside=false;
        for(const auto& d:discs) if(Length(p-d.center)<d.radius) {inside=true;break;}
        if(!inside) return true;
        constexpr float tau=6.28318530718f;
        for(const auto& a:arcs) {
            const Point delta=p-a.disc.center;
            float angle=std::atan2(delta.z,delta.x); if(angle<0) angle+=tau;
            if(angle>=a.lo && angle<=a.hi && std::abs(Length(delta)-a.disc.radius)<=margin) return true;
            for(float end:{a.lo,a.hi}) {
                const Point edge=a.disc.center+Point{std::cos(end),std::sin(end)}*a.disc.radius;
                if(Length(p-edge)<=margin) return true;
            }
        }
        return false;
    }
private:
    struct Arc { Disc disc; float lo,hi; };
    std::vector<Disc> discs;
    std::vector<Arc> arcs;
};

// KI-756: the engine's jam rule, not a disc. Recoil truncates a jammer's range
// to whole radar cells, (jammerRadius / SQUARE_SIZE) >> radarMipLevel
// (ILosType::GetRadius), fills a midpoint circle of cells around the jammer's
// cell (CLosMap::AddCircle) and tests the cell holding the unit's pos
// (ILosType::InSight). The real edge is ragged and inside the nominal disc.
// Row half-widths are built once per AI for every cell radius up to the
// largest jammer: O(Rmax^2) ints, R <= ~24 in BAR. Each test is O(1) for a
// static jammer and O(9) for a mobile one; no engine query, no allocation.
// The engine centres a jammer on its midPos, which the AI interface does not
// expose. Static jammers' midPos matches pos in 2D; a mobile one may sit in a
// neighbouring cell, so it must cover the point from each of those cells.
// commander_jammer_coverage_test checks the rows against the engine loop.
struct JamCell { int x=0, z=0; };
class JamCells {
public:
    JamCells()=default;
    JamCells(int squareSize,int mipLevel,int maxJammerRadius) {
        if(squareSize<=0 || mipLevel<0 || mipLevel>MAX_MIP_LEVEL) return;
        square=squareSize;mip=mipLevel;cell=squareSize<<mipLevel;inverse=1.f/float(cell);
        const int largest=Radius(maxJammerRadius);
        rows.resize(size_t(largest)+1);
        for(int r=1;r<=largest;++r) rows[r]=Rows(r);
    }
    bool Valid() const { return cell>0; }
    float CellSize() const { return float(cell); }
    // Cell radius the engine fills; 0 means it jams nothing.
    int Radius(int jammerRadius) const {
        return cell>0 && jammerRadius>0 ? (jammerRadius/square)>>mip : 0;
    }
    // Same float product and truncation as ILosType::PosToSquare.
    JamCell CellOf(Point p) const { return {int(p.x*inverse),int(p.z*inverse)}; }
    bool Covers(JamCell jammer,int radius,bool mobile,Point p) const {
        if(radius<=0 || size_t(radius)>=rows.size()) return false;
        const JamCell at=CellOf(p);
        if(!mobile) return Inside(rows[radius],at.x-jammer.x,at.z-jammer.z);
        for(int sz=-1;sz<=1;++sz) for(int sx=-1;sx<=1;++sx)
            if(!Inside(rows[radius],at.x-jammer.x-sx,at.z-jammer.z-sz)) return false;
        return true;
    }
    // Every point within margin (per axis) is jammed. Testing the four corners
    // is exact for margin <= half a cell: the square then touches at most 2x2
    // cells, each holding a corner.
    bool CoversAround(JamCell jammer,int radius,bool mobile,Point p,float margin) const {
        for(float sz:{-margin,margin}) for(float sx:{-margin,margin})
            if(!Covers(jammer,radius,mobile,p+Point{sx,sz})) return false;
        return true;
    }
    // From the point `inset` inside the nominal disc towards target, walk in
    // towards the jammer in `step` elmos until CoversAround holds. Bounded by
    // radius/step iterations. False when no point on that ray qualifies.
    bool FiringPoint(Point center,JamCell jammer,int radius,bool mobile,float nominal,float inset,
        Point target,float margin,float step,Point& out) const {
        if(step<=0) return false;
        const Point dir=Normal(target-center);
        for(float d=std::min(std::max(0.f,nominal-inset),Length(target-center));d>=0;d-=step) {
            const Point p=center+dir*d;
            if(CoversAround(jammer,radius,mobile,p,margin)) { out=p;return true; }
        }
        return false;
    }
    // Midpoint row half-widths exactly as MidpointCircleAlgoPerLine emits them
    // (LosMap.cpp); a row called twice keeps its widest span.
    static std::vector<int> Rows(int radius) {
        std::vector<int> widths(size_t(std::max(0,radius))+1,-1);
        if(radius<=0) return widths;
        auto line=[&](int width,int y) {
            y=std::abs(y);
            if(y<=radius) widths[y]=std::max(widths[y],width);
        };
        int x=radius,y=0,decision=1-x;
        while(x>=y) {
            line(x,y);
            if(decision<=0) { ++y;decision+=2*y+1; }
            else { if(x!=y) line(y,x); ++y;--x;decision+=2*(y-x)+1; }
        }
        return widths;
    }
private:
    static constexpr int MAX_MIP_LEVEL=8;
    static bool Inside(const std::vector<int>& widths,int dx,int dz) {
        dz=std::abs(dz);
        return size_t(dz)<widths.size() && widths[dz]>=0 && std::abs(dx)<=widths[dz];
    }
    int square=0,mip=0,cell=0;
    float inverse=0;
    std::vector<std::vector<int>> rows;
};
}}
