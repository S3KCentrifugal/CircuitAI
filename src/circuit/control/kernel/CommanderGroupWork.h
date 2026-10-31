#pragma once
#include <algorithm>

namespace circuit::commander {
enum class ConstructionPhase { URGENT, NANO, SENSORS, DEFENSE };
// Lazy offers: stop at the first accepted job, with no candidate allocation or
// speculative placement. The caller shares one defense decision across URGENT
// and DEFENSE. Tests exercise competing offers and the nano obligation.
template<class NearCombat,class Offer>
auto SelectGroupConstruction(bool nanoDue, NearCombat&& nearCombat, Offer&& offer)
    -> decltype(offer(ConstructionPhase::URGENT)) {
    if(auto task=offer(ConstructionPhase::URGENT)) return task;
    if(nanoDue) {
        if(auto task=offer(ConstructionPhase::NANO)) return task;
    } else if(nearCombat()) {
        if(auto task=offer(ConstructionPhase::SENSORS)) return task;
    }
    return offer(ConstructionPhase::DEFENSE);
}
// Non-owning task identity. The manager must retire it before releasing a task,
// otherwise allocator address reuse can turn unrelated work into a protected job.
// Constant-time, no reference ownership or allocation; tested with address reuse.
template<class Task> struct WorkIdentity {
    const Task* task=nullptr;
    int kind=-1;
    void Retire(const Task* finished) {
        if(task!=finished) return;
        task=nullptr;
        kind=-1;
    }
};
// Admission only: never cancel a funded frame when income later fluctuates.
inline bool GroupBudget(float metalIncome, float energyIncome, float minMetal, float minEnergy,
    float metalBank, float energyBank, float metalPull, float energyPull,
    float metalCost, float energyCost, float seconds, float fraction) {
    return metalIncome>=minMetal && energyIncome>=minEnergy
        && metalBank+seconds*(metalIncome-metalPull)>=metalCost*fraction
        && energyBank+seconds*(energyIncome-energyPull)>=energyCost*fraction;
}
// Admission and retention have different boundaries: an already owned job may
// use build reach beyond the anchor radius, avoiding boundary chatter.
inline bool GroupJobInRange(float distanceSquared, float radius, float buildReach, bool owned) {
    const float limit=std::max(0.f,radius)+(owned?std::max(0.f,buildReach):0.f);
    return distanceSquared>=0.f && distanceSquared<=limit*limit;
}
inline bool ReviewLine(bool pending, int frame, int reviewFrame, float distance, float localRadius) {
    return pending || (frame>=reviewFrame && distance<=localRadius);
}
// An unfinished frame is useful even at full current health; finished repair
// work requires actual damage. Self-repair and unrelated mobile units excluded.
inline bool UsefulGroupRepair(bool self, bool mobile, bool member, bool unfinished, float health, float maximum) {
    return !self && (!mobile || member) && health>0.f && (unfinished || health<maximum);
}
}
