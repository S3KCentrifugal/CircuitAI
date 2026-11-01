#pragma once
#include <algorithm>
#include <array>
#include <cmath>

namespace circuit::commander {
// Numeric values are appended to the existing widget snapshot. Never reorder.
enum class AdvanceReason { ADVANCE, ARRIVED, CONTACT, LANE_BOUND, NO_ROUTE, THREAT, HOME, NO_GOAL, STALE };
inline bool ShouldStartDeployment(float distanceSquared,float arrivalRadius) {
    return std::isfinite(distanceSquared) && distanceSquared>arrivalRadius*arrivalRadius;
}
inline float ReclaimHeadroom(float stored,float capacity,float fraction) {
    return std::max(0.f,capacity*std::clamp(fraction,0.f,1.f)-stored);
}
struct ReclaimValue { float score=0,value=0; bool metal=true; };
inline ReclaimValue ResourceReclaimValue(float metal,float energy,float metalRoom,float energyRoom,
    float minMetal,float minEnergy,float energyPerMetal,float distance) {
    const float m=metal>=minMetal?std::min(std::max(0.f,metal),metalRoom):0.f;
    const float e=energy>=minEnergy?std::min(std::max(0.f,energy),energyRoom):0.f;
    const float weightedEnergy=e/std::max(1.f,energyPerMetal);
    return {(m+weightedEnergy)/(1.f+std::max(0.f,distance)),m>=weightedEnergy?metal:energy,m>=weightedEnergy};
}
struct ReclaimCandidate {
    float x=0,y=0,z=0,score=0,distance=0,value=0;
    int id=-1; bool metal=true;
};
inline bool BetterReclaim(const ReclaimCandidate& a,const ReclaimCandidate& b) {
    if(a.score!=b.score)return a.score>b.score;
    return a.distance!=b.distance?a.distance<b.distance:a.id<b.id;
}
// O(K) selection, four slots, no heap. Engine feature wrappers still cost O(K).
// Ownership: one task offer only; never retain feature handles between frames.
class LocalReclaimCandidates {
public:
    void Add(ReclaimCandidate c) {
        if(!(c.score>0) || !std::isfinite(c.score))return;
        size_t at=0;while(at<count && !BetterReclaim(c,items[at]))++at;
        if(at==items.size())return;
        count=std::min(count+1,items.size());
        for(size_t i=count-1;i>at;--i)items[i]=items[i-1];
        items[at]=c;
    }
    std::array<ReclaimCandidate,4> items{};
    size_t count=0;
};
}
