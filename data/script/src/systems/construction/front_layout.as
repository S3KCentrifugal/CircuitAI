#include "../../helpers/spatial/layout_helpers.as"
#include "../../helpers/units/unit_helpers.as"
#include "../../helpers/math/front_factory_math.as"

namespace FrontLayout {
    const string ROOT = "front.factory.home";

    int ForwardFacing() {
        const AIFloat3 start=Global::Map::StartPos;
        // Setup's legacy lane position is an expansion anchor, not the combat
        // lane direction. The lane is not necessarily published at startup.
        const AIFloat3 goal=aiBattle.GetFrontLaneLength()>0.f
            ? aiBattle.GetFrontLanePoint(AiMin(1024.f,aiBattle.GetFrontLaneLength()))
            : LayoutHelpers::TerrainCentre();
        return LayoutHelpers::FacingToward(start,goal);
    }

    void OwnSupportAdmission() {
        if(aiTerrainMgr.GetLayoutInt(ROOT+".support_owner",0)==0) {
            aiTerrainMgr.SetLayoutInt(ROOT+".prior_nano",aiEconomyMgr.assistNanoEnabled?1:0);
            aiTerrainMgr.SetLayoutInt(ROOT+".support_owner",1);
        }
        aiEconomyMgr.assistNanoEnabled=false;
    }

    string TierKey(uint tier) { return ROOT+(tier==0?".t1":".t2"); }
    string PlanKey(uint tier) {
        return tier==1 && aiTerrainMgr.GetLayoutInt(ROOT+".extension",0)!=0?ROOT+".extension":TierKey(tier);
    }

    void ArmCluster(const string& in name) {
        aiTerrainMgr.ArmGroup(aiTerrainMgr.GetNamedLayoutGroup(name+".factory"),true);
        aiTerrainMgr.ArmGroup(aiTerrainMgr.GetNamedLayoutGroup(name+".nano"),true);
    }

    void Prepare(IUnitTask@ task) {
        if(!Global::RoleSettings::Front::FactoryLayoutsEnabled || !Global::Map::HasStart) return;
        IBuilderTask@ build=cast<IBuilderTask>(task);
        if(build is null || build.GetBuildType()!=int(Task::BuildType::FACTORY) || build.buildDef is null) return;
        const CCircuitDef@ def=build.buildDef;
        const string name=def.GetName();
        const bool t2=UnitHelpers::IsT2BotLab(name) || UnitHelpers::IsT2VehicleLab(name);
        if(!t2 && !UnitHelpers::IsT1BotLab(name) && !UnitHelpers::IsT1VehicleLab(name)) return;
        AiPreferFactoryFacing(task,ForwardFacing());
        if(aiTerrainMgr.GetReservationCount(def)>0) return;
        const bool homeExtension=t2 && Factory(1) is null;
        const string counterKey=ROOT+".extra_index."+def.id;
        const int serial=aiTerrainMgr.GetLayoutInt(counterKey,0);
        const string key=homeExtension?ROOT+".extension":ROOT+".additional."+def.id+"."+serial;
        // Failed admission retries only with a later build request. No poller.
        if(ai.frame<aiTerrainMgr.GetLayoutInt(key+".retry",-SECOND)+5*SECOND) return;
        aiTerrainMgr.SetLayoutInt(key+".retry",ai.frame);
        CCircuitDef@ nano=ai.GetCircuitDef(UnitHelpers::GetT1NanoNameForSide(Global::AISettings::Side));
        if(nano is null) return;
        const AIFloat3 seed=Global::Map::StartPos;
        const int facing=aiTerrainMgr.GetLayoutInt(ROOT+".facing",LayoutHelpers::FacingToward(seed,LayoutHelpers::TerrainCentre()));
        const array<float> offsets={0.f,256.f,-256.f,512.f,-512.f};
        for(uint i=0;i<offsets.length();++i) for(int rows=Global::RoleSettings::Front::FactorySupportRows;rows>=1;--rows) {
            const AIFloat3 site=LayoutHelpers::Offset(seed,facing,offsets[i],256.f);
            const int slot=aiTerrainMgr.PlanFactoryCluster(key,def,nano,site,facing,t2?3:2,rows);
            if(slot<0) continue;
            ArmCluster(key);
            if(!homeExtension) aiTerrainMgr.SetLayoutInt(counterKey,serial+1);
            if(homeExtension) {
                // Commit the alternative first; a failed preview must never
                // discard the existing expansion or any already-paid work.
                aiTerrainMgr.ReleaseUnusedLayout(ROOT+".t2");
                aiTerrainMgr.SetLayoutInt(ROOT+".extension",1);
                aiTerrainMgr.SetLayoutInt(ROOT+".t2_slot",slot);
                aiTerrainMgr.SetLayoutInt(ROOT+".capacity",2);
            }
            GenericHelpers::LogUtil("[FrontLayout] additional factory="+name+" rows="+rows,1);
            return;
        }
    }

    CCircuitUnit@ Factory(uint tier) {
        const string key=TierKey(tier);
        CCircuitUnit@ actual=ai.GetTeamUnit(aiTerrainMgr.GetLayoutInt(key+".unit",-1));
        if(actual !is null && IsFactoryTier(actual,tier)) return actual;
        return aiTerrainMgr.GetReservationUnit(aiTerrainMgr.GetLayoutInt(ROOT+(tier==0?".t1_slot":".t2_slot"),-1));
    }

    bool IsFactoryTier(CCircuitUnit@ unit,uint tier) {
        if(unit is null) return false;
        const string name=unit.circuitDef.GetName();
        return tier==0?(UnitHelpers::IsT1BotLab(name) || UnitHelpers::IsT1VehicleLab(name))
            :(UnitHelpers::IsT2BotLab(name) || UnitHelpers::IsT2VehicleLab(name));
    }

    void Removed(CCircuitUnit@ unit) {
        if(unit is null) return;
        for(uint tier=0;tier<2;++tier) {
            const string key=TierKey(tier)+".unit";
            if(aiTerrainMgr.GetLayoutInt(key,-1)==unit.id) aiTerrainMgr.SetLayoutInt(key,-1);
        }
    }

    CCircuitUnit@ OpeningBuilder(const CCircuitDef@ def,const AIFloat3& in start) {
        // One startup census, never a per-builder task scan. Only evaluate a
        // local builder; planning must not recruit a commander from the front.
        array<Id>@ ids=ai.GetOwnedUnitIds();
        CCircuitUnit@ best=null;
        float distance=512.f*512.f;
        for(uint i=0;i<ids.length();++i) {
            CCircuitUnit@ unit=ai.GetTeamUnit(ids[i]);
            if(unit is null || !unit.circuitDef.IsMobile() || !unit.circuitDef.CanBuild(def)) continue;
            const float d=MapHelpers::SqDist(start,unit.GetPos(ai.frame));
            if(d<distance || (d==distance && best !is null && unit.id<best.id)) {
                @best=unit;distance=d;
            }
        }
        return best;
    }

    void Adopt(CCircuitUnit@ factory) {
        if(factory is null || !Global::RoleSettings::Front::FactoryLayoutsEnabled) return;
        const string name=factory.circuitDef.GetName();
        const bool t1=UnitHelpers::IsT1BotLab(name) || UnitHelpers::IsT1VehicleLab(name);
        const bool t2=UnitHelpers::IsT2BotLab(name) || UnitHelpers::IsT2VehicleLab(name);
        if(!t1 && !t2) return;
        const uint tier=t1?0:1;
        const string key=TierKey(tier);
        CCircuitUnit@ prior=Factory(tier);
        if(prior !is null && prior.id!=factory.id) return;
        if(aiTerrainMgr.GetLayoutInt(key+".unit",-1)==factory.id) return;
        const int slot=aiTerrainMgr.GetLayoutInt(ROOT+(t1?".t1_slot":".t2_slot"),-1);
        const bool planned=slot>=0 && MapHelpers::SqDist(factory.GetPos(ai.frame),aiTerrainMgr.GetReservationPos(slot))<64.f;
        if(!planned && aiTerrainMgr.ReleaseUnusedLayout(PlanKey(tier))) {
            // Utility pockets were checked against the old production core.
            // Do not advertise that clearance after moving the actual factory.
            aiTerrainMgr.ReleaseUnusedLayout(ROOT+".utilities");
            // The existing structure is already shared by the ordinary-site
            // lifecycle. Replace only unclaimed support/exit reservations.
            CCircuitDef@ nano=ai.GetCircuitDef(UnitHelpers::GetT1NanoNameForSide(Global::AISettings::Side));
            if(nano !is null) for(int rows=Global::RoleSettings::Front::FactorySupportRows;rows>=1;--rows) {
                const int group=aiTerrainMgr.ReserveNanoBlock(factory,nano,t1?2:3,rows,0);
                if(group<=0) continue;
                aiTerrainMgr.ArmGroup(group,true);
                aiTerrainMgr.SetLayoutInt(key+".adopted_nano",group);
                break;
            }
        }
        aiTerrainMgr.SetLayoutInt(key+".unit",factory.id);
        OwnSupportAdmission();
        GenericHelpers::LogUtil("[FrontLayout] factory adopted tier="+tier+" unit="+factory.id+" planned="+planned,1);
    }

    void ReservePocket(const string& in name, const AIFloat3& in seed, int facing) {
        CCircuitDef@ def = ai.GetCircuitDef(name);
        if (def is null) return;
        // Optional pockets never invalidate the productive factory core.
        for (int i=0; i<5; ++i) {
            const AIFloat3 p = LayoutHelpers::Offset(seed, facing, float(i)*32.0f, 0.0f);
            if (!aiTerrainMgr.CanReserveBuilding(def,p,facing)) continue;
            const int slot=aiTerrainMgr.ReserveIsolatedBuilding(ROOT+".utilities."+name,def,p,facing,ROOT,
                Global::RoleSettings::Front::FactoryUtilityBlastMargin);
            if(slot>=0) {
                GenericHelpers::LogUtil("[FrontLayout] utility="+name+" slot="+slot,1);
                return;
            }
        }
    }

    void ReserveUtilities(const string& in side, const AIFloat3& in rear, int facing) {
        ReservePocket(UnitHelpers::GetAntiNukeNameForSide(side), LayoutHelpers::Offset(rear,facing,-288.0f,-160.0f),facing);
        const string storageName=UnitHelpers::GetEnergyStorageNameForSide(side);
        CCircuitDef@ storage=ai.GetCircuitDef(storageName);
        const float storageOffset=storage is null?288.f:AiMax(288.f,aiTerrainMgr.GetBuildingBlastRadius(storage)+256.f);
        ReservePocket(storageName, LayoutHelpers::Offset(rear,facing,storageOffset,-160.0f),facing);
        ReservePocket(UnitHelpers::GetStaticRadarNameForSide(side), LayoutHelpers::Offset(rear,facing,-288.0f,48.0f),facing);
        ReservePocket(UnitHelpers::GetStaticLLTNameForSide(side), LayoutHelpers::Offset(rear,facing,-288.0f,160.0f),facing);
        ReservePocket(UnitHelpers::GetStaticT2AAFlakNameForSide(side), LayoutHelpers::Offset(rear,facing,288.0f,48.0f),facing);
    }

    void Plan(const string& in firstName, const string& in side) {
        if (!Global::RoleSettings::Front::FactoryLayoutsEnabled || !Global::Map::HasStart) return;
        if (!UnitHelpers::IsT1BotLab(firstName) && !UnitHelpers::IsT1VehicleLab(firstName)) return;
        CCircuitDef@ first = ai.GetCircuitDef(firstName);
        string secondName = UnitHelpers::GetT2BotLabForSide(side);
        if (UnitHelpers::IsT1VehicleLab(firstName)) {
            const array<string> names = UnitHelpers::GetT2VehicleLabs(side);
            if (names.length()==0) return;
            secondName=names[0];
        }
        CCircuitDef@ second=ai.GetCircuitDef(secondName);
        CCircuitDef@ nano=ai.GetCircuitDef(UnitHelpers::GetT1NanoNameForSide(side));
        if (first is null || second is null || nano is null || !aiTerrainMgr.SetLayoutEnabled(true)) return;
        if (aiTerrainMgr.HasLayoutGroup(ROOT+".t1.factory")) return;
        const AIFloat3 start=Global::Map::StartPos;
        CCircuitUnit@ opening=OpeningBuilder(first,start);
        const int primary=ForwardFacing();
        const array<float> offsets={0.0f,128.0f,-128.0f,256.0f,-256.0f};
        // Same six bounded passes, but orientation precedes growth capacity.
        // A compact forward bay is preferable to a larger sideways district.
        for (uint pass=0; pass<6; ++pass) {
                const int facing=FrontFactoryMath::LayoutFacing(primary,pass);
                const bool compact=(pass%2)!=0;
                for (uint i=0; i<offsets.length(); ++i) {
                    // Keep the opening bay close to its builder; starting the
                    // entire rear edge 128 ahead often exceeded the approach
                    // preference after adding the factory's own half-depth.
                    const AIFloat3 rear=LayoutHelpers::Offset(start,facing,offsets[i],64.0f);
                    for (int rows=Global::RoleSettings::Front::FactorySupportRows; rows>=1; --rows) {
                        const int capacity=aiTerrainMgr.PlanFactoryDistrict(ROOT,first,second,nano,rear,facing,rows,rows,compact,opening,Global::RoleSettings::Front::FactoryReservationTravelSeconds);
                        if (capacity==0) continue;
                        // Generic FRONT build intents use armed slots. The shared
                        // pair mechanism holds slots by default for TECH's pins.
                        ArmCluster(ROOT+".t1");
                        ArmCluster(ROOT+".t2");
                        OwnSupportAdmission();
                        ReserveUtilities(side,rear,facing);
                        GenericHelpers::LogUtil("[FrontLayout] reserved capacity="+capacity+" support rows="+rows+" facing="+facing,1);
                        const AIFloat3 site=aiTerrainMgr.GetReservationPos(aiTerrainMgr.GetLayoutInt(ROOT+".t1_slot",-1));
                        GenericHelpers::LogUtil("[FrontLayout] first factory site="+site.x+","+site.z,1);
                        return;
                    }
                }
        }
        GenericHelpers::LogUtil("[FrontLayout] no district fits; ordinary placement retained",1);
    }
}
