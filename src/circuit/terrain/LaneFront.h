#pragma once
#include <algorithm>
#include <array>
#include <cmath>
#include <limits>

namespace circuit::lane {
// One bounded strip per assigned route. No unit ownership or orders. Evidence
// is rebuilt at one Hz; damage stamps survive rebuilds, but not route changes.
// Tests: lane_front_test.cpp. Empty/expired evidence is UNKNOWN, never CLEAR.
class Front {
public:
    static constexpr int MAX_BINS=128;
    enum State { UNKNOWN=0, SUPPORTED=1, EXPECTED=2, ACTIVE=3, ENEMY=4 };
    struct Bin {
        float friendly=0, enemy=0;
        int supporters=0, damage=-1;
        bool uncertain=false;
    };
    void Reset(float length) {
        count=length>0?std::clamp(int(std::ceil(length/128.f)),1,MAX_BINS):0;
        step=count?length/count:1.f;
        bins={};for(auto& b:bins)b.damage=-1;
    }
    void Begin() {for(int i=0;i<count;++i) {const int d=bins[i].damage;bins[i]=Bin{};bins[i].damage=d;}}
    int Index(float p) const {return std::clamp(int(p/step),0,std::max(0,count-1));}
    void Damage(float p,int frame) {if(count)bins[Index(p)].damage=frame;}
    void Add(float lo,float hi,float power,bool friendly,bool uncertain=false) {
        if(!count || hi<0 || lo>count*step)return;
        for(int i=Index(std::max(0.f,lo));i<=Index(std::max(0.f,hi));++i) {
            auto& b=bins[i];
            if(friendly){b.friendly+=power;++b.supporters;}
            else {b.enemy+=power;b.uncertain|=uncertain;}
        }
    }
    State Status(int i,int frame,int hold) const {
        const auto& b=bins[i];
        if(b.damage>=0 && frame-b.damage<=hold)return ACTIVE;
        if(b.enemy>0 || b.uncertain)return b.friendly>0?EXPECTED:ENEMY;
        return b.supporters>=2?SUPPORTED:UNKNOWN;
    }
    // Distance along the route to the nearest independent combat interval.
    // UNKNOWN/fog and friendly occupation alone are not combat evidence.
    // O(B), B <= 128, allocation-free; callers choose their own memory window.
    float CombatDistance(float progress,int frame,int hold,bool contacts=true) const {
        float distance=std::numeric_limits<float>::infinity();
        if(!std::isfinite(progress)) return distance;
        for(int i=0;i<count;++i) {
            const auto& b=bins[i];
            const bool recent=b.damage>=0 && frame>=b.damage && frame-b.damage<=hold;
            if(!recent && !(contacts && (b.enemy>0 || b.uncertain))) continue;
            distance=std::min(distance,std::max({i*step-progress,progress-(i+1)*step,0.f}));
        }
        return distance;
    }
    // This is an extra admission bound, not permission to override existing
    // matchup, retreat, reachability or screen checks. Rear threats never
    // turn deployment into withdrawal; each remains an independent zone.
    float Limit(float from,float goal,float margin,float ratio,int frame,int hold) const {
        if(!count || goal<=from)return goal;
        for(int i=Index(from);i<=Index(goal);++i) {
            const auto& b=bins[i];
            const bool danger=b.enemy>0 || b.uncertain || Status(i,frame,hold)==ACTIVE;
            if(danger && (b.uncertain || b.supporters<2 || b.enemy<=0 || b.friendly<b.enemy*ratio))
                return std::min(goal,std::max(from,i*step-margin));
        }
        return goal;
    }
    std::array<Bin,MAX_BINS> bins{};
    int count=0;
    float step=1.f;
};
}
