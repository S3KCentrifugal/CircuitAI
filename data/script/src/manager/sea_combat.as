// SEA-owned fleet procurement. Native tasks retain movement, target and repair
// ownership; this module never issues per-unit movement orders.
#include "sea_economy.as"
namespace SeaCombat {
    class Hull {
        CCircuitDef@ def;
        float surface=0, underwater=0, air=0;
        bool siege=false;
        Hull(const string &in name, float s, float w, float a, bool artillery=false) {
            @def=ai.GetCircuitDef(name); surface=s; underwater=w; air=a; siege=artillery;
        }
    }
    array<Hull@> roster;
    dictionary airResponders;
    int frame=-100000;
    float surface=0, underwater=0, air=0, shore=0, fleet=0;
    bool Active() { return SeaLayout::Active() && Global::RoleSettings::Sea::AdaptiveFleet; }
    bool HybridScoutAA(const CCircuitDef@ def) {
        return def !is null && def.GetName()=="armpt" && def.HasSurfToAir();
    }
    void MilitaryRemoved(CCircuitUnit@ u, Unit::UseAs usage) {
        if (u !is null) airResponders.delete(""+u.id);
    }
    IUnitTask@ MilitaryTask(CCircuitUnit@ u) {
        if (u is null) return null;
        if (Active() && Global::RoleSettings::Sea::RespectCarrierControl
            && u.GetRulesParam("carrier_host_unit_id",-1)>=0) {
            if (u.task !is null && u.task.IsExternalControlled()) return u.task;
            return aiMilitaryMgr.EnqueueExternalControl("carrier_host_unit_id");
        }
        if (Active() && Global::RoleSettings::Sea::HybridScoutAirResponse && air>0 && HybridScoutAA(u.circuitDef)) {
            airResponders.set(""+u.id,true);
            return aiMilitaryMgr.Enqueue(TaskF::Common(Task::FightType::AA));
        }
        return aiMilitaryMgr.DefaultMakeTask(u);
    }
    void AirResponse() {
        if (!Global::RoleSettings::Sea::HybridScoutAirResponse || air<=0) return;
        for (uint i=0;i<SeaEconomy::owned.length();++i) {
            CCircuitUnit@ u=ai.GetTeamUnit(SeaEconomy::owned[i]);
            if (u is null || !HybridScoutAA(u.circuitDef)) continue;
            IFighterTask@ old=cast<IFighterTask>(u.task);
            // Preserve player, retreat, transport and already-correct tasks.
            if (old is null || old.GetFightType()!=int(Task::FightType::SCOUT)) continue;
            IUnitTask@ task=aiMilitaryMgr.Enqueue(TaskF::Common(Task::FightType::AA));
            if (task !is null && aiMilitaryMgr.TransferUnit(u,task)) {
                airResponders.set(""+u.id,true);
                GenericHelpers::LogUtil("[SEA][AirCover] scout joins AA task "+u.id,1);
            } else if (task !is null) {
                task.Abort();
                Invariants::Violation("INV-133",""+u.id,"SEA could not assign hybrid scout air defense");
            }
        }
    }
    void CarrierControl() {
        if (!Global::RoleSettings::Sea::RespectCarrierControl) return;
        // Host ownership is assigned after the engine's creation callback.
        // Adopt on the next SEA census as well as at normal task assignment.
        for (uint i=0;i<SeaEconomy::owned.length();++i) {
            CCircuitUnit@ u=ai.GetTeamUnit(SeaEconomy::owned[i]);
            if (u is null || u.task is null || u.task.IsExternalControlled()
                || u.task.GetType()==int(Task::Type::PLAYER) || !u.circuitDef.IsMobile()
                || u.circuitDef.GetBuildSpeed()>0 || u.GetRulesParam("carrier_host_unit_id",-1)<0) continue;
            IUnitTask@ task=aiMilitaryMgr.EnqueueExternalControl("carrier_host_unit_id");
            if (task !is null && aiMilitaryMgr.TransferUnit(u,task))
                GenericHelpers::LogUtil("[SEA][Carrier] game owns "+u.circuitDef.GetName()+"("+u.id+")",1);
            else if (task !is null) {
                task.Abort();
                Invariants::Violation("INV-132",""+u.id,"SEA could not yield a carrier-owned military unit");
            }
        }
    }
    void Leave() {
        for (uint i=0;i<SeaEconomy::owned.length();++i) {
            CCircuitUnit@ u=ai.GetTeamUnit(SeaEconomy::owned[i]);
            if (u is null || u.task is null) continue;
            IFighterTask@ fighter=cast<IFighterTask>(u.task);
            const bool hybrid=airResponders.exists(""+u.id) && fighter !is null && fighter.GetFightType()==int(Task::FightType::AA);
            if (!u.task.IsExternalControlled() && !hybrid) continue;
            IUnitTask@ old=u.task;
            IUnitTask@ task=aiMilitaryMgr.DefaultMakeTask(u);
            if (task !is null && !aiMilitaryMgr.TransferUnit(u,task)) task.Abort();
            if (old.IsExternalControlled()) old.Abort();
        }
        airResponders.deleteAll();
        frame=-100000;
    }
    void Add(const string &in name,float s,float w,float a,bool siege=false) { roster.insertLast(Hull(name,s,w,a,siege)); }
    void Init() {
        if (roster.length()>0) return;
        const float hybrid=Global::RoleSettings::Sea::HybridSubCoverWeight;
        Add("armdecade",1,0,0); Add("armpt",.25f,0,.5f); Add("armpship",1,0,0); Add("armroy",1,hybrid,0); Add("armsub",0,1,0);
        Add("coresupp",1,0,0); Add("corpt",.25f,0,.7f); Add("corpship",1,0,0); Add("corroy",1,hybrid,0); Add("corsub",0,1,0);
        Add("legnavyscout",1,0,0); Add("legnavyaaship",0,0,1); Add("legnavyfrigate",0,1,0); Add("legnavydestro",1,0,0); Add("legnavysub",0,1,0); Add("legnavyartyship",1,0,0,true);
        Add("armcrus",1,1,0); Add("armsubk",0,1,0); Add("armserp",0,1.25f,0); Add("armaas",0,0,1); Add("armbats",1,0,0); Add("armmship",1,0,.2f,true); Add("armepoch",1,0,.15f,true); Add("armlship",1,0,.25f);
        Add("corcrus",1,1,0); Add("corshark",0,1,0); Add("corssub",0,1.25f,0); Add("corarch",0,0,1); Add("corbats",1,0,0); Add("cormship",1,0,.2f,true); Add("corblackhy",1,0,.15f,true); Add("corfship",1,0,.25f);
        Add("leganavycruiser",1,1,0); Add("leganavybattlesub",0,1,0); Add("leganavyheavysub",0,1.25f,0); Add("leganavyaaship",0,0,1); Add("leganavybattleship",1,0,0); Add("leganavymissileship",1,0,.2f,true); Add("leganavyartyship",1,0,0,true); Add("leganavyflagship",1,0,0,true); Add("leganavyantiswarm",1,0,.25f);
    }
    void Tick() {
        if (!Active() || ai.frame-frame<SECOND) return;
        frame=ai.frame; Init(); CarrierControl(); fleet=0;
        for (uint i=0;i<roster.length();++i) if (roster[i].def !is null) fleet+=roster[i].def.costM*float(roster[i].def.count);
        AIFloat3 origin=Global::Map::StartPos;
        for (uint i=0;i<SeaLayout::berths.length();++i) if (SeaLayout::berths[i].slot>=0 && !SeaLayout::berths[i].retired) { origin=SeaLayout::berths[i].centre; break; }
        aiBattle.SampleNavalThreat(origin,Global::RoleSettings::Sea::ThreatResponseRadius);
        const float nextSub=aiBattle.GetNavalThreatCost(1), nextAir=aiBattle.GetNavalThreatCost(2);
        if ((nextSub>0 && underwater==0) || (nextAir>0 && air==0))
            GenericHelpers::LogUtil("[SEA][Threat] submarine="+nextSub+" aircraft="+nextAir,1);
        surface=aiBattle.GetNavalThreatCost(0); underwater=nextSub;
        air=nextAir; shore=aiBattle.GetNavalThreatCost(3);
        AirResponse();
        // Avoid the legacy map-wide army/per-player comparison. The native
        // reachable-group gate and damage-triggered response remain active.
        aiMilitaryMgr.quota.attack=Global::RoleSettings::Sea::MilitaryAttackThreshold;
        aiMilitaryMgr.quota.attackWait=Global::RoleSettings::Sea::FleetAssemblySeconds;
    }
    float Coverage(Hull@ h,int kind) {
        const CCircuitDef@ d=h.def;
        if (d is null) return 0;
        if (kind==2) return d.HasSurfToAir() ? h.air : 0;
        if (kind==1) return d.HasSurfToWater() || d.HasSubToWater() ? h.underwater : 0;
        return d.HasSurfToLand() ? h.surface : 0;
    }
    CCircuitDef@ Select(CCircuitUnit@ yard,bool urgentOnly=false) {
        if (!Active()) return null;
        Tick();
        if (!urgentOnly && fleet<1000 && UnitHelpers::IsT1Shipyard(yard.circuitDef.GetName())) {
            const string side=UnitHelpers::GetSideForUnitName(yard.circuitDef.GetName());
            CCircuitDef@ scout=ai.GetCircuitDef(side=="armada" ? "armpt" : side=="cortex" ? "corpt" : "legnavyscout");
            if (scout !is null && scout.count+aiFactoryMgr.GetPendingRecruitCount(scout)==0
                && scout.IsAvailable(ai.frame) && yard.circuitDef.CanBuild(scout)) return scout;
        }
        array<float> have(3,0.0f);
        for (uint i=0;i<roster.length();++i) {
            Hull@ h=roster[i]; if (h.def is null) continue;
            const float value=h.def.costM*float(h.def.count+aiFactoryMgr.GetPendingRecruitCount(h.def));
            for (int k=0;k<3;++k) have[k]+=value*Coverage(h,k);
        }
        const float needAir=SeaMath::Deficit(air*Global::RoleSettings::Sea::AirCounterRatio,have[2],0);
        const float needSub=SeaMath::Deficit(underwater*Global::RoleSettings::Sea::SubCounterRatio,have[1],0);
        int kind=-1; float deficit=0;
        if (needAir>0) { kind=2; deficit=needAir; }
        if (needSub>deficit) { kind=1; deficit=needSub; }
        if (kind<0 && urgentOnly) return null;
        if (kind<0) {
            if (have[2]<fleet*Global::RoleSettings::Sea::FleetAirCoverShare) { kind=2; deficit=fleet*Global::RoleSettings::Sea::FleetAirCoverShare-have[2]; }
            else if (have[1]<fleet*Global::RoleSettings::Sea::FleetSubCoverShare) { kind=1; deficit=fleet*Global::RoleSettings::Sea::FleetSubCoverShare-have[1]; }
            else { kind=0; deficit=AiMax(1000.0f,surface); }
        }
        CCircuitDef@ best=null; float score=0;
        const float power=SeaEconomy::LocalPower(yard);
        for (uint i=0;i<roster.length();++i) {
            Hull@ h=roster[i]; CCircuitDef@ d=h.def;
            if (d is null || !d.IsAvailable(ai.frame) || !yard.circuitDef.CanBuild(d)) continue;
            if (h.siege && (urgentOnly || kind!=0 || fleet<Global::RoleSettings::Sea::SiegeFleetMetal || shore<=0)) continue;
            // Preserve a screen; expensive siege never fills the entire queue.
            if (h.siege && float(d.count+aiFactoryMgr.GetPendingRecruitCount(d))*d.costM>fleet*.25f) continue;
            const float weight=Coverage(h,kind);
            float rank=SeaMath::CounterScore(deficit,d.costM*weight,d.GetBuildTime()/AiMax(1.0f,power),weight>0);
            if (kind==0) {
                // Longer range is useful in fleet combat; cheap fast raiders
                // still appear at the opening, before a battle line exists.
                const float range=d.GetMaxRange(1); // CCircuitDef::RangeType::LAND
                rank*=1.0f+range/400.0f;
                if (range<400 && fleet>600) rank*=.3f;
                if (h.siege) rank*=1.5f;
            }
            if (rank>score) { @best=d; score=rank; }
        }
        if (best !is null && urgentOnly) GenericHelpers::LogUtil("[SEA][Response] layer="+kind+" deficit="+deficit+" recruit="+best.GetName(),1);
        if (best !is null && ((kind==2 && !best.HasSurfToAir())
            || (kind==1 && !best.HasSurfToWater() && !best.HasSubToWater())
            || (kind==0 && !best.HasSurfToLand()))) {
            Invariants::Violation("INV-131",best.GetName(),"SEA counter lacks target-layer weapon");
            return null;
        }
        return best;
    }
}
