#include "front_constructors.as"
#include "defense_planner.as"
#include "../../helpers/math/commander_group_math.as"
// Stable FRONT roster. Lifecycle admission/removal is O(7); no army scans.
// Layout keys survive load; pending recruit handles cover framed production.
namespace CommanderGroup {
    array<int> members={-1,-1,-1,-1,-1,-1}; // T2 x3, radar, jammer, decoy
    array<IUnitTask@> recruits(6);
    const array<string> t2={"armack","armacv","corack","coracv","legack","legacv"};
    const array<string> radars={"armmark","armseer","corvoyr","corvrad","legavrad"};
    const array<string> jammers={"armaser","armjam","corspec","coreter","legavjam"};
    const array<string> decoys={"armdecom","cordecom","legdecom"};
    bool loaded=false,enabled=false,wantDecoy=false;
    int economy=-1,desired=0,next=0;
    float decoyM=100,decoyE=2000,decoySeconds=60,decoyReserveM=500,decoyReserveE=2000;
    float firstM=50,firstE=1000,secondM=120,secondE=2500,thirdM=240,thirdE=5000;
    bool Eligible(CCircuitUnit@ unit) {
        return unit !is null && !unit.circuitDef.IsAbleToFly()
            && !Team::Ferry::IsGift(unit.id) && !Team::Recovery::IsGift(unit.id);
    }
    void Definition(const string &in key,const string &in fallback) {
        CCircuitDef@ def=ai.GetCircuitDef(aiSetupMgr.ConfigString("commander/combat/"+key,fallback));
        aiBuilderMgr.SetCommanderCombatOption(key,def is null?-1.f:float(def.id));
    }
    float Setting(const string &in key,float fallback) {
        return aiSetupMgr.ConfigFloat("commander/combat/commander_group_"+key,fallback);
    }
    void Load() {
        if(loaded) return;
        loaded=true;
        FrontConstructors::Load();
        DefensePlanner::Load();
        enabled=aiTerrainMgr.GetLayoutInt("front.constructor.group_enabled",0)!=0;
        desired=aiTerrainMgr.GetLayoutInt("front.group.desired",0);
        economy=aiTerrainMgr.GetLayoutInt("front.group.economy",-1);
        wantDecoy=aiTerrainMgr.GetLayoutInt("front.group.decoy",0)!=0;
        for(uint i=0;i<members.length();++i) members[i]=aiTerrainMgr.GetLayoutInt("front.group.member."+i,-1);
        decoyM=Setting("decoy_metal",100);decoyE=Setting("decoy_energy",2000);
        decoySeconds=Setting("decoy_seconds",60);
        decoyReserveM=Setting("decoy_reserve_metal",500);decoyReserveE=Setting("decoy_reserve_energy",2000);
        firstM=Setting("t2_metal",50);firstE=Setting("t2_energy",1000);
        secondM=Setting("second_t2_metal",120);secondE=Setting("second_t2_energy",2500);
        thirdM=Setting("third_t2_metal",240);thirdE=Setting("third_t2_energy",5000);
        const string side=Global::AISettings::Side.length()>0?Global::AISettings::Side:ai.GetSideName();
        Definition("commander_group_def",side=="cortex"?"corhllt":side=="legion"?"legmg":"armbeamer");
        Definition("commander_group_nano",side=="cortex"?"cornanotc":side=="legion"?"legnanotc":"armnanotc");
        Definition("commander_group_radar",UnitHelpers::GetStaticRadarNameForSide(side));
        Definition("commander_group_jammer",UnitHelpers::GetStaticJammerNameForSide(side));
        Definition("commander_group_aa",UnitHelpers::GetStaticAALightNameForSide(side));
        Definition("commander_group_def2",side=="cortex"?"corvipe":side=="legion"?"legacluster":"armpb");
        Definition("commander_group_radar2",side=="cortex"?"corarad":side=="legion"?"legarad":"armarad");
        Definition("commander_group_jammer2",side=="cortex"?"corshroud":side=="legion"?"legajam":"armveil");
        Definition("commander_group_aa2",side=="cortex"?"corflak":side=="legion"?"legflak":"armflak");
    }
    void Save(int seat) {aiTerrainMgr.SetLayoutInt("front.group.member."+seat,members[seat]);}
    void Update() {
        if(Global::AISettings::Role!=AiRole::FRONT) return;
        Load();
        if(ai.frame<next) return;
        next=ai.frame+SECOND;
        if(!enabled && aiEconomyMgr.metal.income>=Setting("income",20)) {
            enabled=true;aiTerrainMgr.SetLayoutInt("front.constructor.group_enabled",1);
        }
        if(!enabled) return;
        desired=CommanderGroupMath::DesiredT2(desired,aiEconomyMgr.metal.income,aiEconomyMgr.energy.income,
            firstM,firstE,secondM,secondE,thirdM,thirdE);
        aiTerrainMgr.SetLayoutInt("front.group.desired",desired);
        if(ai.GetTeamUnit(economy) is null) economy=-1;
        aiTerrainMgr.SetLayoutInt("front.group.economy",economy);
        if(aiBuilderMgr.FrontCommanderId()<0) wantDecoy=true;
        aiTerrainMgr.SetLayoutInt("front.group.decoy",wantDecoy?1:0);
        for(uint i=0;i<members.length();++i) {
            if(!Eligible(ai.GetTeamUnit(members[i]))) {members[i]=-1;Save(int(i));}
            aiBuilderMgr.SetCommanderCombatOption("commander_group_member"+i,float(members[i]));
        }
        // owner 2026-11-01: the group's T1 constructor also builds forward agitators (front_agitator.as GroupPull);
        // while it is on one, native group work must not take it back, so it is unpublished meanwhile
        CCircuitUnit@ con=ai.GetTeamUnit(FrontConstructors::seats[2]);
        if(Eligible(con)) {
            IUnitTask@ agit=FrontAgitator::GroupPull(con);
            if(agit !is null && con.task !is agit) aiBuilderMgr.AssignTask(con,agit);
        }
        PublishUnit(false);
    }
    void PublishUnit(bool detached) {   // native resets its group state only when the value changes
        CCircuitUnit@ con=ai.GetTeamUnit(FrontConstructors::seats[2]);
        const int id=(!detached && Eligible(con) && !FrontAgitator::OnOrder(con))?FrontConstructors::seats[2]:-1;
        aiBuilderMgr.SetCommanderCombatOption("commander_group_unit",float(id));
    }
    bool Owns(int id) {
        if(Global::AISettings::Role!=AiRole::FRONT) return false;
        Load();return id>=0 && (members.find(id)>=0 || (enabled && FrontConstructors::seats[2]==id));
    }
    bool OnAdded(CCircuitUnit@ unit) {
        if(Global::AISettings::Role!=AiRole::FRONT || !Eligible(unit)) return false;
        next=0;Update();
        if(members.find(unit.id)>=0) return true;
        if(unit.id==economy) return false;
        const string name=unit.circuitDef.GetName();

        int seat=-1;
        if(t2.find(name)>=0) {
            seat=CommanderGroupMath::Admission(ai.GetTeamUnit(economy)!is null,members,desired);
            if(seat==-2) {economy=unit.id;aiTerrainMgr.SetLayoutInt("front.group.economy",economy);return false;}
        } else if(radars.find(name)>=0 && members[3]<0) seat=3;
        else if(jammers.find(name)>=0 && members[4]<0) seat=4;
        else if(decoys.find(name)>=0 && members[5]<0) seat=5;
        if(seat<0) return false;
        members[seat]=unit.id;Save(seat);unit.DelAttribute(Unit::Attr::BASE.type);
        aiBuilderMgr.SetCommanderCombatOption("commander_group_member"+seat,float(unit.id));
        GenericHelpers::LogUtil("[CommanderGroup] admitted seat="+seat+" unit="+unit.id,1);
        return true;
    }
    void OnRemoved(CCircuitUnit@ unit) {
        if(!loaded) return;
        const int seat=members.find(unit.id);
        if(seat>=0) {members[seat]=-1;Save(seat);aiBuilderMgr.SetCommanderCombatOption("commander_group_member"+seat,-1.f);}
        if(economy==unit.id) {economy=-1;aiTerrainMgr.SetLayoutInt("front.group.economy",-1);}
        next=0;
    }
    IUnitTask@ RecruitSeat(CCircuitUnit@ factory,int seat,const array<string>& in names) {
        if(members[seat]>=0) return null;
        if(recruits[seat]!is null && !recruits[seat].IsDead()) return null;
        @recruits[seat]=null;
        // One T2 admission at a time: the first completion can refill economy.
        if(seat<3) for(uint i=0;i<3;++i) if(recruits[i]!is null && !recruits[i].IsDead()) return null;
        for(uint i=0;i<names.length();++i) {
            CCircuitDef@ def=ai.GetCircuitDef(names[i]);
            // Our retained task covers its factory frame. The global builder
            // unfinished count also includes distant resurrection projects;
            // those must not indefinitely block a vacant frontline seat.
            if(def !is null && aiFactoryMgr.GetPendingRecruitCount(def)>0) return null;
        }
        for(uint i=0;i<names.length();++i) {
            CCircuitDef@ def=ai.GetCircuitDef(names[i]);
            if(def is null || !factory.circuitDef.CanBuild(def)) continue;
            if(seat==5 && !DecoyFunded(factory,def)) return null;
            // This FRONT-local cap permits the dedicated seat without changing
            // other roles or the shared UnitDef classification.
            if(def.maxThisUnit<def.count+1) def.maxThisUnit=def.count+1;
            if(!def.IsAvailable(ai.frame)) continue;
            IUnitTask@ task=aiFactoryMgr.Enqueue(TaskS::Recruit(seat<3?Task::RecruitType::BUILDPOWER:Task::RecruitType::FIREPOWER,
                seat==5?Task::Priority::NORMAL:Task::Priority::HIGH,def,factory.GetPos(ai.frame),64.f));
            @recruits[seat]=task;
            if(task !is null) GenericHelpers::LogUtil("[CommanderGroup] recruit seat="+seat+" def="+def.GetName(),1);
            return task;
        }
        return null;
    }
    bool DecoyFunded(CCircuitUnit@ factory,CCircuitDef@ def) {
        if(aiBuilderMgr.FrontCommanderId()>=0 || FrontConstructors::Missing()>=0) return false;
        if(desired>0 && ai.GetTeamUnit(economy) is null) return false;
        for(int i=0;i<desired;++i) if(members[i]<0) return false;
        if(!CommanderGroupMath::DecoyIncome(aiEconomyMgr.metal.income,aiEconomyMgr.energy.income,decoyM,decoyE)) return false;
        // Read cached resource aggregates only on a compatible factory ask.
        // Bound the forecast by unassisted production time; never extend it
        // to justify a faster factory. No army scan or recurring allocation.
        const float power=factory.circuitDef.GetBuildSpeed();
        if(power<=0) return false;
        const float seconds=AiMin(decoySeconds,def.GetBuildTime()/power);
        return CommanderGroupMath::ReplacementResource(aiEconomyMgr.metal.current,decoyReserveM,
                aiEconomyMgr.metal.income,aiEconomyMgr.metal.pull,def.costM,seconds)
            && CommanderGroupMath::ReplacementResource(aiEconomyMgr.energy.current,decoyReserveE,
                aiEconomyMgr.energy.income,aiEconomyMgr.energy.pull,def.costE,seconds);
    }
    IUnitTask@ Recruit(CCircuitUnit@ factory) {
        Update();
        IUnitTask@ task=FrontConstructors::Recruit(factory,enabled);
        if(task !is null || !enabled) return task;
        for(int i=0;i<desired;++i) {@task=RecruitSeat(factory,i,t2);if(task !is null) return task;}
        if(desired>0) {
            @task=RecruitSeat(factory,3,radars);if(task !is null) return task;
            @task=RecruitSeat(factory,4,jammers);if(task !is null) return task;
        }
        if(wantDecoy) {@task=RecruitSeat(factory,5,decoys);if(task !is null) return task;}
        return null;
    }
    IUnitTask@ Work(CCircuitUnit@ unit) {
        Update();
        if(!Owns(unit.id)) return null;
        if(FrontConstructors::seats[2]==unit.id) {
            IUnitTask@ agit=FrontAgitator::GroupPull(unit);
            PublishUnit(agit !is null);
            if(agit !is null) return agit;
        }
        return aiBuilderMgr.CommanderFrontWork(unit,19,null,0.f);
    }
}
