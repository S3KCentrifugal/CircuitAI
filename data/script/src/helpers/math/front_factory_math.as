namespace FrontFactoryMath {
    // Exhaust both capacities facing the front before accepting a sideways bay.
    int LayoutFacing(int primary, uint pass) {
        if (primary<0 || primary>3 || pass>=6) return -1;
        const uint direction=pass/2;
        return (primary+(direction==0?0:(direction==1?1:3)))%4;
    }
    class Budget { float metal=0.f; float energy=0.f; }
    float FirstShare(bool secondActive,float protectedShare) {
        if(!secondActive) return 1.f;
        return protectedShare<0.f?0.f:(protectedShare>1.f?1.f:protectedShare);
    }
    // BP is raw build work/second. Budgets are income allocated to this line,
    // never storage or whole-team income counted twice for two factories.
    float FundedPower(float work,float metal,float energy,float budgetM,float budgetE) {
        if(work<=0.f || metal<0.f || energy<0.f || budgetM<0.f || budgetE<0.f || (metal==0.f && energy==0.f)) return 0.f;
        float power=metal>0.f?budgetM*work/metal:budgetE*work/energy;
        if(energy>0.f && budgetE*work/energy<power) power=budgetE*work/energy;
        return power;
    }
    float SupportDemand(float funded,float factoryPower) {
        return funded>factoryPower?funded-factoryPower:0.f;
    }
    int Choose(bool reachesFirst,bool reachesSecond,float firstDeficit,float secondDeficit) {
        // Existing T1 throughput is protected during T2 construction/production.
        if(reachesFirst && firstDeficit>0.f) return 0;
        if(reachesSecond && secondDeficit>0.f) return 1;
        return -1;
    }
    void Allocate(const array<uint>& in masks,const array<float>& in powers,
        array<float>& inout deficits,array<int>& inout owners) {
        owners.resize(masks.length());
        for(uint i=0;i<owners.length();++i) owners[i]=-1;
        if(deficits.length()!=2 || powers.length()!=masks.length()) return;
        for(uint pass=0;pass<2;++pass) for(uint i=0;i<masks.length();++i) {
            const uint mask=masks[i];
            if(mask==0 || mask>3 || powers[i]<=0.f || (mask==3)!=(pass==1)) continue;
            const int owner=Choose((mask&1)!=0,(mask&2)!=0,deficits[0],deficits[1]);
            if(owner<0) continue;
            owners[i]=owner;
            deficits[owner]-=powers[i];
        }
    }
}
