namespace FrontFactoryMath {
    // Six passes: forward, then each side; each full then compact.
    const uint LAYOUT_PASSES=6;
    // A side facing may point this far away from the goal, as a fraction of
    // the goal distance (the native FacingsToward uses the same, D-460).
    const float SIDE_TOLERANCE=.05f;
    // Facings: 0 south (+z), 1 east (+x), 2 north (-z), 3 west (-x).
    float FacingDot(int facing,float dx,float dz) {
        return facing==0?dz:(facing==1?dx:(facing==2?-dz:-dx));
    }
    // Exhaust both capacities facing the front before accepting a sideways
    // bay. D-460 (KI-743): the side nearer the goal (dx,dz from the site) goes
    // first, the map interior (ix,iz from the site) on a tie, and a side that
    // points away from the goal is never offered (-1): at a west-edge start
    // the fixed "primary+1" side faced the map edge.
    int LayoutFacing(int primary,uint pass,float dx,float dz,float ix,float iz) {
        if (primary<0 || primary>3 || pass>=LAYOUT_PASSES) return -1;
        const uint direction=pass/2;
        if (direction==0) return primary;
        int first=(primary+1)%4,second=(primary+3)%4;
        const float a=FacingDot(first,dx,dz),b=FacingDot(second,dx,dz);
        if (b>a || (b==a && FacingDot(second,ix,iz)>FacingDot(first,ix,iz))) { const int t=first;first=second;second=t; }
        const int side=direction==1?first:second;
        // dot >= -tolerance x |goal|, compared squared (no sqrt in the pure suite)
        const float dot=FacingDot(side,dx,dz);
        return (dot>=0.f || dot*dot<=SIDE_TOLERANCE*SIDE_TOLERANCE*(dx*dx+dz*dz))?side:-1;
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
