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
    int economy=-1,desired=0,next=0,bridge=-1;
    IUnitTask@ bridgeRecruit;
    IUnitTask@ decoyFactory;
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
        bridge=aiTerrainMgr.GetLayoutInt("front.group.bridge",-1);
        wantDecoy=aiTerrainMgr.GetLayoutInt("front.group.decoy",0)!=0;
        for(uint i=0;i<members.length();++i) members[i]=aiTerrainMgr.GetLayoutInt("front.group.member."+i,-1);
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
        aiBuilderMgr.SetCommanderCombatOption("commander_group_unit",Eligible(ai.GetTeamUnit(FrontConstructors::seats[2]))?float(FrontConstructors::seats[2]):-1.f);
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
        if(bridgeRecruit !is null && name==BotName("ck") && FrontConstructors::Missing()<0) {
            bridge=unit.id;aiTerrainMgr.SetLayoutInt("front.group.bridge",bridge);@bridgeRecruit=null;
            return false;
        }
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
        if(bridge==unit.id) {bridge=-1;aiTerrainMgr.SetLayoutInt("front.group.bridge",-1);}
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
            // This FRONT-local cap permits the dedicated seat without changing
            // other roles or the shared UnitDef classification.
            if(def.maxThisUnit<def.count+1) def.maxThisUnit=def.count+1;
            if(!def.IsAvailable(ai.frame)) continue;
            IUnitTask@ task=aiFactoryMgr.Enqueue(TaskS::Recruit(seat<3?Task::RecruitType::BUILDPOWER:Task::RecruitType::FIREPOWER,
                Task::Priority::HIGH,def,factory.GetPos(ai.frame),64.f));
            @recruits[seat]=task;
            if(task !is null) GenericHelpers::LogUtil("[CommanderGroup] recruit seat="+seat+" def="+def.GetName(),1);
            return task;
        }
        return null;
    }
    string BotName(const string &in suffix) {
        const string side=Global::AISettings::Side.length()>0?Global::AISettings::Side:ai.GetSideName();
        return (side=="cortex"?"cor":side=="legion"?"leg":"arm")+suffix;
    }
    bool NeedsDecoyFactory() {
        if(!enabled || !wantDecoy || members[5]>=0) return false;
        for(uint i=0;i<decoys.length();++i) {
            // The faction's advanced bot factory is the decoy production edge.
            const string prefix=i==0?"arm":i==1?"cor":"leg";
            CCircuitDef@ lab=ai.GetCircuitDef(prefix+"alab");
            if(lab !is null && lab.count>0) return false;
        }
        return true;
    }
    IUnitTask@ PrepareDecoy(CCircuitUnit@ unit) {
        if(Global::AISettings::Role!=AiRole::FRONT) return null;
        Update();
        if(!NeedsDecoyFactory() || (unit.id!=economy && unit.id!=bridge && !FrontConstructors::IsBase(unit.id))) return null;
        if(unit.task !is null && (unit.task.IsExternalControlled() || unit.task.IsEnemyReclaim()
            || unit.task.GetType()==int(Task::Type::PLAYER) || unit.task.GetType()==int(Task::Type::RETREAT))) return null;
        if(decoyFactory !is null && !decoyFactory.IsDead()) {
            IBuilderTask@ project=cast<IBuilderTask>(decoyFactory);
            return project !is null && project.buildDef !is null && unit.circuitDef.CanBuild(project.buildDef)?decoyFactory:null;
        }
        @decoyFactory=null;
        CCircuitDef@ lab=ai.GetCircuitDef(BotName("alab"));
        if(lab is null || !unit.circuitDef.CanBuild(lab)) @lab=ai.GetCircuitDef(BotName("lab"));
        if(lab is null || !unit.circuitDef.CanBuild(lab) || lab.count>0
            || aiBuilderMgr.GetQueuedBuildCount(int(Task::BuildType::FACTORY),lab)>0) return null;
        if(lab.maxThisUnit<1) lab.maxThisUnit=1;
        @decoyFactory=aiBuilderMgr.Enqueue(TaskB::Factory(Task::Priority::HIGH,lab,Global::Map::StartPos,null));
        return decoyFactory;
    }
    IUnitTask@ RecruitBridge(CCircuitUnit@ factory) {
        if(!NeedsDecoyFactory() || ai.GetTeamUnit(bridge)!is null) return null;
        CCircuitDef@ lab=ai.GetCircuitDef(BotName("alab"));
        CCircuitUnit@ base=ai.GetTeamUnit(FrontConstructors::seats[0]);
        if(lab !is null && base !is null && base.circuitDef.CanBuild(lab)) return null;
        if(bridgeRecruit !is null && !bridgeRecruit.IsDead()) return null;
        CCircuitDef@ def=ai.GetCircuitDef(BotName("ck"));
        if(def is null || !factory.circuitDef.CanBuild(def) || aiFactoryMgr.GetPendingRecruitCount(def)>0
            || aiBuilderMgr.GetUnfinishedCount(def)>0) return null;
        if(def.maxThisUnit<def.count+1) def.maxThisUnit=def.count+1;
        @bridgeRecruit=aiFactoryMgr.Enqueue(TaskS::Recruit(Task::RecruitType::BUILDPOWER,Task::Priority::HIGH,
            def,factory.GetPos(ai.frame),64.f));
        return bridgeRecruit;
    }
    IUnitTask@ Recruit(CCircuitUnit@ factory) {
        Update();
        IUnitTask@ task=FrontConstructors::Recruit(factory,enabled);
        if(task !is null || !enabled) return task;
        @task=RecruitBridge(factory);if(task !is null) return task;
        if(wantDecoy) {@task=RecruitSeat(factory,5,decoys);if(task !is null) return task;}
        for(int i=0;i<desired;++i) {@task=RecruitSeat(factory,i,t2);if(task !is null) return task;}
        if(desired>0) {
            @task=RecruitSeat(factory,3,radars);if(task !is null) return task;
            @task=RecruitSeat(factory,4,jammers);if(task !is null) return task;
        }
        return null;
    }
    IUnitTask@ Work(CCircuitUnit@ unit) {
        Update();
        return Owns(unit.id)?aiBuilderMgr.CommanderFrontWork(unit,19,null,0.f):null;
    }
}
