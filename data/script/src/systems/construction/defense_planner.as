// Policy catalog for the reusable native defense mechanism. Costs, weapons,
// stockpiles, geometry and live capabilities come from the engine, not this table.
namespace DefensePlanner {
    bool loaded=false;
    void Option(int slot,const string& in key,float fallback,const string& in path) {
        aiBuilderMgr.SetDefenseRule(slot,key,aiSetupMgr.ConfigFloat(path+key,fallback));
    }
    void Rule(int slot,const string& in name,const string& in key,int band,int limit,
        float metal,float energy,float seconds,float priority,float valueRatio,
        float light,float heavy,float air,float stationary,float nuclear,float plasma) {
        CCircuitDef@ def=ai.GetCircuitDef(name);
        if(def is null) return; // content availability, not an invented equivalent
        const string path="commander/defense/rules/"+key+"/";
        aiBuilderMgr.SetDefenseRule(slot,"def",float(def.id));
        Option(slot,"surplus_priority",0,path);
        Option(slot,"band",float(band),path);Option(slot,"limit",float(limit),path);
        Option(slot,"metal",metal,path);Option(slot,"energy",energy,path);
        Option(slot,"seconds",seconds,path);Option(slot,"priority",priority,path);
        Option(slot,"value_ratio",valueRatio,path);Option(slot,"window",30,path);
        Option(slot,"reserve",.2f,path);Option(slot,"efficiency",.65f,path);
        Option(slot,"light",light,path);Option(slot,"heavy",heavy,path);Option(slot,"air",air,path);
        Option(slot,"static",stationary,path);Option(slot,"nuclear",nuclear,path);Option(slot,"plasma",plasma,path);
        // Local saturation is native. Keep a separate per-AI safety cap so
        // defenses left at an old front do not consume the new station's quota.
        const int total=int(aiSetupMgr.ConfigFloat(path+"total_limit",32));
        if(priority>0 && def.maxThisUnit<total) def.maxThisUnit=total;
    }
    void Load() {
        if(loaded || Global::AISettings::Role!=AiRole::FRONT) return;
        loaded=true;
        const string path="commander/defense/";
        Option(-1,"surplus_metal",0,path); Option(-1,"surplus_energy_margin",100,path);
        Option(-1,"surplus_fire_seconds",10,path); Option(-1,"surplus_limit",32,path);
        Option(-1,"enabled",1,path);Option(-1,"radius",1800,path);
        Option(-1,"memory",45,path);Option(-1,"strategic_memory",600,path);
        Option(-1,"heavy_metal",1200,path);Option(-1,"heavy_health",4000,path);
        Option(-1,"baseline_health",1000,path);Option(-1,"stable_seconds",60,path);Option(-1,"stable_distance",160,path);
        Option(-1,"urgent_band",4,path);
        Option(-1,"shield_in_plasma_zone",1,path);Option(-1,"shield_safe_seconds",10,path);
        const string side=Global::AISettings::Side.length()>0?Global::AISettings::Side:ai.GetSideName();
        const bool cor=side=="cortex",leg=side=="legion";
        Rule(0,cor?"corhllt":leg?"leglht":"armbeamer","light",2,2,0,0,60,1,0,1,.15f,0,0,0,0);
        Rule(1,cor?"corhlt":leg?"legmg":"armhlt","hlt",2,3,20,500,90,2,0,1,.6f,0,0,0,0);
        Rule(2,cor?"corvipe":leg?"legapopupdef":"armpb","t2",2,4,50,1000,90,4,0,1,1,0,0,0,0);
        Rule(3,cor?"cordoom":leg?"legbastion":"armanni","heavy",2,3,120,2500,120,3,.75f,cor||leg?.5f:0,1,0,0,0,0);
        Rule(4,cor?"cortoast":leg?"legacluster":"armamb","artillery",1,3,120,2500,120,2,.5f,0,0,0,1,0,0);
        Rule(5,cor?"corint":leg?"leglrpc":"armbrtha","lrpc",1,2,200,5000,240,2,1,0,0,0,1,0,0);
        Rule(6,cor?"corflak":leg?"legflak":"armflak","aa",2,3,50,1000,90,2,0,0,0,1,0,0,0);
        Rule(7,cor?"corfmd":leg?"legabm":"armamd","antinuke",3,2,50,1000,240,1,0,0,0,0,0,1,0);
        Rule(8,cor?"corgate":leg?"legdeflector":"armgate","shield",3,2,100,2500,150,1,0,0,0,0,0,0,1);
        Rule(15,UnitHelpers::GetStaticAALightNameForSide(side),"aa_light",2,3,0,0,60,1,0,0,0,1,0,0,0);
        // Read coverage from every faction. A captured builder can be supported
        // by a policy-added buildable row; priority zero means coverage only.
        const array<string> anti={"armamd","corfmd","legabm"};
        const array<string> shield={"armgate","corgate","legdeflector"};
        for(uint i=0;i<3;++i) {
            Rule(9+int(i)*2,anti[i],"allied_antinuke",3,2,0,0,240,0,0,0,0,0,0,1,0);
            Rule(10+int(i)*2,shield[i],"allied_shield",3,2,0,0,150,0,0,0,0,0,0,0,1);
        }
    }
}
