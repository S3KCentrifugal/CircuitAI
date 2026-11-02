// Read-only observer over ordinary TECH policy; no task or economy overrides.
namespace GrowthProbe {
    int last=-SECOND;
    bool enabled=false, seats=false, nano=false, reactor=false, conversion=false, air=false, continued=false;
    int airCount=0, diagnostic=-100000;
    void Pass(const string& in label) { AiLog("[GrowthTest] PASS "+label); }
    bool Building(int id,const string& in name) {
        CCircuitUnit@ u=ai.GetTeamUnit(id);
        if(u is null) return false;
        IBuilderTask@ task=cast<IBuilderTask>(u.task);
        return task !is null && task.buildDef !is null && task.buildDef.GetName()==name;
    }
    void Tick() {
        if(ai.teamId!=0 || ai.frame<last+SECOND) return;
        last=ai.frame;
        if(!TechGrowth::active) return;
        if(!enabled) {
            enabled=true;
            if(aiTerrainMgr.GetLayoutInt("tech.growth.reclaim",0)!=1) AiLog("[GrowthTest] FAIL activation without accepted reclaim");
            else Pass("activated after accepted reclaim");
        }
        const int n=TechGrowth::nanoId, a=TechGrowth::afusId, c=TechGrowth::converterId;
        if(n>=0 && a>=0 && c>=0) {
            if(n==a || n==c || a==c) AiLog("[GrowthTest] FAIL duplicate worker assignment");
            else if(!seats) {seats=true; Pass("three distinct economy workers");}
        }
        const string side=Global::AISettings::Side;
        if(!nano && Building(n,UnitHelpers::GetT1NanoNameForSide(side))) {nano=true;Pass("turret worker constructs");}
        if(!reactor && Building(a,UnitHelpers::GetAdvFusionNameForSide(side))) {reactor=true;Pass("AFUS worker constructs");}
        if(!conversion && Building(c,UnitHelpers::GetAdvEnergyConverterNameForSide(side))) {conversion=true;Pass("converter worker constructs");}
        CCircuitUnit@ af=ai.GetTeamUnit(a); CCircuitUnit@ co=ai.GetTeamUnit(c);
        if(!air && af !is null && co !is null && TechBuild::IsT2AirCon(af) && TechBuild::IsT2AirCon(co)) {
            air=true;
            CCircuitDef@ reactorDef=ai.GetCircuitDef(UnitHelpers::GetAdvFusionNameForSide(side));
            // Do not count finishing a bot's pre-handover frame as proof that
            // the replacement can admit the next AFUS itself.
            airCount=reactorDef.count+aiBuilderMgr.GetQueuedBuildCount(int(Task::BuildType::ENERGY),reactorDef);
            Pass("air replaces both T2 economy workers");
        }
        if(air && !continued && TechBuild::FinishedOf(UnitHelpers::GetAdvFusionNameForSide(side))>airCount) {
            continued=true;Pass("AFUS completed after air handover");
        }
        if(air && ai.frame>=diagnostic+60*SECOND) {
            diagnostic=ai.frame;
            CCircuitDef@ def=ai.GetCircuitDef(UnitHelpers::GetAdvFusionNameForSide(side));
            AiLog("[GrowthState] afus="+a+" available="+def.IsAvailable(ai.frame)
                +" singleProject="+TechBuild::CanStartAfus(def)+" support="+(Layout::economySupportTask !is null)
                +" metal="+aiEconomyMgr.metal.current+" energy="+aiEconomyMgr.energy.current
                +" stalled="+aiEconomyMgr.isEnergyStalling);
        }
    }
}
