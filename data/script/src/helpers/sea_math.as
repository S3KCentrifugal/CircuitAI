// Deterministic SEA admission and handover decisions, independent of engine state.
namespace SeaMath {
    // Centre-out columns keep existing members' slots when reinforcements
    // arrive. Fixed columns avoid a sqrt(N) grid reshuffle at every birth/death.
    int SpreadIndex(int index) { return index==0 ? 0 : (index%2==1 ? (index+1)/2 : -index/2); }
    int AAColumn(int slot,int columns) { return SpreadIndex(slot%(columns>0 ? columns : 1)); }
    int AARow(int slot,int columns) { return slot/(columns>0 ? columns : 1); }
    float AASpacing(float configured,float shortestRange) {
        const float overlap=shortestRange*.55f;
        return configured<overlap ? configured : overlap;
    }
    float InterceptLead(float distance,float shipSpeed,float weaponRange,float maximum) {
        if (distance<=weaponRange || shipSpeed<=0 || maximum<=0) return 0;
        const float seconds=(distance-weaponRange)/shipSpeed;
        return seconds<maximum ? seconds : maximum;
    }
    float RememberThreat(float previous, float observed, int age, int lifetime) {
        return observed>0 ? observed : age<lifetime ? previous : 0.0f;
    }
    bool ReleaseFleet(int count, int ageFrames, int desired, int waitFrames) {
        return count>0 && (count>=desired || ageFrames>=waitFrames);
    }
    bool NeedsScreen(float enemySubMetal, float readyCover, float ratio) {
        return enemySubMetal>0 && readyCover<enemySubMetal*ratio;
    }
    bool NewObjective(int oldTarget, int target, float movedSq, int age, int expiry) {
        return oldTarget!=target || movedSq>192.0f*192.0f || age>=expiry;
    }
    bool ForwardFootprint(float along, float halfDepth, float frontier, float margin) {
        return halfDepth>=0 && margin>=0 && along-halfDepth>=frontier+margin;
    }
    bool OpeningFactory(bool neverHadFactory, bool tierOne, bool notReplacement, bool firstBerth) {
        return neverHadFactory && tierOne && notReplacement && firstBerth;
    }
    bool RearFootprint(float along, float halfDepth, float margin) {
        return halfDepth>=0 && margin>=0 && along+halfDepth<=-margin;
    }
    float ProductionShare(float basePower, float totalBasePower) {
        if (basePower<=0 || totalBasePower<basePower) return 0;
        return basePower/totalBasePower;
    }
    bool SupportNeeded(float target, float existing, float factoryPower, float nanoPower, int cap) {
        return nanoPower>0 && cap>0 && existing<factoryPower+float(cap)*nanoPower
            && target>=existing+nanoPower*.5f;
    }
    float Deficit(float target, float live, float pending) {
        const float value=target-live-pending;
        return value>0 ? value : 0;
    }
    // Coverage delivered per construction second, with saturation so one
    // enormous hull is not selected for a tiny missing escort.
    float CounterScore(float deficit, float coverage, float seconds, bool capable) {
        if (!capable || deficit<=0 || coverage<=0 || seconds<=0) return 0;
        return (deficit<coverage ? deficit : coverage)/seconds;
    }
    bool RetryBerth(bool active, bool unitAlive, int reservationState) {
        return active && !unitAlive && reservationState==0;
    }
    bool RestartStability(int since, bool changedSite) { return since<0 || changedSite; }
    int Missing(int goal, int live, int pending, int batch) {
        const int room = goal - live - pending;
        return room <= 0 || batch <= 0 ? 0 : (room < batch ? room : batch);
    }
    bool TechReady(float incomeM, float incomeE, float bankM, float bankE,
        float minM, float minE, float reserveM, float packageM, float packageE,
        float horizon, float share) {
        if (incomeM < minM || incomeE < minE || bankM < reserveM || bankE < 0
            || horizon <= 0 || share <= 0 || share > 1) return false;
        return bankM + incomeM * horizon * share >= packageM
            && bankE + incomeE * horizon * share >= packageE;
    }
    bool RetireReady(bool replacementComplete, bool exited, bool safe,
        bool tierPreserved, bool currentProduct, float storageRoom, float reclaimMetal) {
        return replacementComplete && exited && safe && tierPreserved
            && !currentProduct && storageRoom >= reclaimMetal;
    }
    bool ForwardWorthwhile(float oldDistance, float newDistance, float minimumGain,
        int stableSeconds, int requiredSeconds) {
        return minimumGain > 0 && oldDistance - newDistance >= minimumGain
            && stableSeconds >= requiredSeconds;
    }
}
