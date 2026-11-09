// Pure lane allocation policy. Distances are along a lane, never straight-line.
// A negative share represents missing evidence and must not win allocation.
namespace FrontlineEngineeringMath {
    float OwnedShare(float heldDistance, float laneLength) {
        if (!(laneLength > 0.0f) || !(heldDistance >= 0.0f)) return -1.0f;
        const float share = heldDistance / laneLength;
        return share > 1.0f ? 1.0f : share;
    }
    bool BetterLane(float share, int team, float bestShare, int bestTeam) {
        if (!(share >= 0.0f && share <= 1.0f) || team < 0) return false;
        if (bestTeam < 0 || bestShare < 0.0f) return true;
        return share < bestShare || (share == bestShare && team < bestTeam);
    }
    bool ReassessmentDue(int frame, int nextFrame) {
        return nextFrame < 0 || frame >= nextFrame;
    }
    bool CombatNearby(float combatDistance,float stationDistance,int age,int freshness,float radius) {
        return age>=0 && age<=freshness && combatDistance>=0.0f && stationDistance>=0.0f
            && combatDistance+stationDistance<=radius;
    }
}
