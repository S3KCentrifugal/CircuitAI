namespace EconomyClusterMath {
    int AssistRank(bool turret,bool converter,bool afus,bool fusion,bool healthy,float metal,float minimumMetal) {
        if(turret && healthy && metal>=minimumMetal) return 1;
        if(converter) return 2;
        if(afus) return 3;
        if(fusion) return 4;
        return 100;
    }
    bool Prefer(int rank,float progress,int id,int current,int bestRank,float bestProgress,int bestId) {
        if(rank>=100) return false;
        if(rank!=bestRank) return rank<bestRank;
        if(id==current) return true;
        if(bestId==current) return false;
        return progress>bestProgress || (progress==bestProgress && id<bestId);
    }
    bool EnergyHealthy(bool stalled,float bank,float storage,float minimumShare) {
        return !stalled && storage>0.f && bank>=storage*minimumShare;
    }
    float Surplus(float income,float usage,float converting,float capacity,float reserve) {
        const float other=usage>converting?usage-converting:0.f;
        return income-other-capacity-reserve;
    }
    bool ConversionWanted(bool previous,bool healthy,float surplus,float enter,float leave) {
        return healthy && surplus>(previous?leave:enter);
    }
    bool Funded(bool healthy,float bank,float reserve,float commitments,float remaining) {
        return healthy && remaining>0.f && bank-reserve-commitments>=remaining;
    }
    bool CanStart(int inFlight,int limit,bool funded,bool usable) {
        return funded && usable && limit>0 && inFlight<limit;
    }
    float Remaining(float cost,float progress) {
        const float bounded=progress<0.f?0.f:progress>1.f?1.f:progress;
        return cost*(1.f-bounded);
    }
}
