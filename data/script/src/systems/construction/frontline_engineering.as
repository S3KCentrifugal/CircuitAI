#include "../team/engineering_lanes.as"
#include "defense_planner.as"
#include "engineering_replacements.as"
// TECH-owned mobile build power: three stable constructor seats plus assistants.
namespace FrontlineEngineering {
    class Seat {
        int id=-1, waypoint=0, issued=-1, retry=0;
        int def=-1;
        bool helper=false,wasSolo=false;
        array<AIFloat3> route;
        IUnitTask@ wait;
    }
    array<Seat@> seats;
    dictionary members;
    array<int> constructorIds={-1,-1,-1};
    array<int> botDefs; // immutable loaded roster, not per-worker string arrays
    array<int> helperDefs;
    IUnitTask@ fiendJob;
    int fiendBuilder=-1;
    int fiendOrigin=-1,fiendSince=-1,previousOrigin=-1,previousSince=-1,previousUntil=-1;
    bool IsFiendProduct(CCircuitUnit@ u) {
        if(u is null || u.circuitDef.GetName()!="corpyro") return false;
        const int origin=u.GetProducerId(),frame=u.GetProductionFrame();
        return (origin==fiendOrigin && fiendSince>=0 && frame>=fiendSince)
            || (origin==previousOrigin && previousSince>=0 && frame>=previousSince && frame<=previousUntil);
    }
    bool active=false,loaded=false;
    int next=0,reassess=-1,target=-1,nextFollow=0;
    AIFloat3 station(-1.0f,0.0f,-1.0f);
    int interval=300;
    float threat=0.0f,arrival=240.0f,exitRadius=512.0f,waypointRadius=64.0f;
    void Load() {
        if(loaded) return;loaded=true;
        interval=AiMax(1,int(aiSetupMgr.ConfigFloat("commander/engineering/reassign_seconds",300)));
        threat=AiMax(0.0f,aiSetupMgr.ConfigFloat("commander/engineering/route_threat",0));
        arrival=AiMax(64.0f,aiSetupMgr.ConfigFloat("commander/engineering/arrival_radius",240));
        exitRadius=AiMax(0.0f,aiSetupMgr.ConfigFloat("commander/engineering/route_exit_radius",512));
        waypointRadius=AiMax(32.0f,aiSetupMgr.ConfigFloat("commander/engineering/waypoint_radius",64));
        array<string> names=UnitHelpers::GetAllT2BotConstructors();
        for(uint i=0;i<names.length();++i) {
            CCircuitDef@ def=ai.GetCircuitDef(names[i]);
            if(def !is null) botDefs.insertLast(def.id);
        }
        names=UnitHelpers::GetAllFastAssistBots();
        for(uint i=0;i<names.length();++i) {
            CCircuitDef@ def=ai.GetCircuitDef(names[i]);
            if(def !is null) helperDefs.insertLast(def.id);
        }
        DefensePlanner::Load(true);
    }
    bool Eligible(CCircuitUnit@ u) {
        return u !is null && ai.GetTeamUnit(u.id) is u && u.GetBuildProgress()>=1.0f && !Team::Ferry::IsGift(u.id)
            && !Team::Recovery::IsGift(u.id)
            && (botDefs.find(u.circuitDef.id)>=0 || helperDefs.find(u.circuitDef.id)>=0);
    }
    int ConstructorId(uint slot) {
        return slot<constructorIds.length()?constructorIds[slot]:-1;
    }
    void Added(CCircuitUnit@ u) {
        if(!active || !Eligible(u)) return;
        if(members.exists(""+u.id)) return;
        const bool helper=helperDefs.find(u.circuitDef.id)>=0;
        const int free=constructorIds.find(-1);
        if(!helper && free<0) return;
        Seat@ seat=Seat();seat.id=u.id;seat.def=u.circuitDef.id;seat.helper=helper;seats.insertLast(seat);
        seat.wasSolo=u.IsAttrAny(Unit::Attr::SOLO.mask);
        u.DelAttribute(Unit::Attr::SOLO.type); // group members may assist and repair
        members.set(""+u.id,@seat);
        if(!helper) constructorIds[free]=u.id;
        u.DelAttribute(Unit::Attr::BASE.type);
    }
    void Forget(uint index,bool loss) {
        Seat@ seat=seats[index];
        CCircuitUnit@ unit=ai.GetTeamUnit(seat.id);
        if(unit !is null && seat.wasSolo) unit.AddAttribute(Unit::Attr::SOLO.type);
        if(loss) EngineeringReplacements::Lost(seat.def);
        const int slot=constructorIds.find(seat.id);
        if(slot>=0) constructorIds[slot]=-1;
        members.delete(""+seat.id);seats.removeAt(index);
    }
    void Removed(CCircuitUnit@ u) {
        if(u is null) return;
        for(uint i=0;i<seats.length();++i) if(seats[i].id==u.id) {
            Forget(i,true);return;
        }
    }
    bool NearLaneCombat(CCircuitUnit@ u) {
        for(uint i=0;i<EngineeringLanes::lanes.length();++i) {
            EngineeringLanes::Lane@ lane=EngineeringLanes::lanes[i];
            if(lane.team==target)
                return FrontlineEngineeringMath::CombatNearby(lane.combatDistance,
                    u.GetPos(ai.frame).distance2D(lane.station),ai.frame-lane.frame,45*SECOND,800);
        }
        return false;
    }
    IUnitTask@ HelperWork(CCircuitUnit@ u) {
        if(u.circuitDef.GetName()=="corfast") {
            // A producer death can retire its task while leaving a nanoframe.
            // Recover that one local project before opening another product.
            IBuilderTask@ old=cast<IBuilderTask>(fiendJob);
            if(old !is null && old.IsDead() && u.GetPos(ai.frame).distance2D(old.GetBuildPos())<=600
                && SafeSegment(u.GetPos(ai.frame),old.GetBuildPos())) {
                CCircuitUnit@ frame=aiBuilderMgr.FindUnfinishedNear(old.GetBuildPos(),128,ai.GetCircuitDef("corpyro"));
                if(frame !is null) {
                    @fiendJob=aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::NORMAL,frame,180*SECOND));
                    fiendBuilder=u.id;
                    if(fiendJob !is null) return fiendJob;
                }
            }
            if(fiendJob !is null && !fiendJob.IsDead()) {
                if(u.id==fiendBuilder) return fiendJob;
                CCircuitUnit@ producer=ai.GetTeamUnit(fiendBuilder);
                if(producer !is null) {
                    IUnitTask@ help=aiBuilderMgr.SupportAssist(u,producer,600);
                    if(help !is null) return help;
                } else {
                    IBuilderTask@ project=cast<IBuilderTask>(fiendJob);
                    if(project !is null && u.GetPos(ai.frame).distance2D(project.GetBuildPos())<=600
                        && SafeSegment(u.GetPos(ai.frame),project.GetBuildPos())) {
                        fiendBuilder=u.id;return fiendJob;
                    }
                }
            } else if(NearLaneCombat(u)) {
                CCircuitDef@ def=ai.GetCircuitDef("corpyro");
                // TECH's factory combat gate caps Fiends at zero until its
                // rush phase. Local Twitcher work is separately authorized;
                // retain the snapshotted engine limit without lifting lab caps.
                int engineCap=0;
                RoleTech::g_rushBotEngineCaps.get("corpyro",engineCap);
                if(def !is null && u.circuitDef.CanBuild(def) && def.IsBuildAllowed() && def.count<engineCap
                    && aiEconomyMgr.metal.current>=def.costM && aiEconomyMgr.energy.current>=def.costE) {
                    @fiendJob=aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::RECRUIT,Task::Priority::NORMAL,def,u.GetPos(ai.frame),64,true,180*SECOND));
                    if(fiendJob !is null) {
                        // Keep the preceding admission through reentrant finish
                        // callbacks; one shared project can be in flight.
                        previousOrigin=fiendOrigin;previousSince=fiendSince;previousUntil=ai.frame;
                        fiendOrigin=u.id;fiendSince=ai.frame;
                    }
                    fiendBuilder=u.id;
                    return fiendJob;
                }
            }
        }
        for(uint i=0;i<constructorIds.length();++i) {
            CCircuitUnit@ worker=ai.GetTeamUnit(constructorIds[i]);
            IUnitTask@ help=aiBuilderMgr.SupportAssist(u,worker,600);
            if(help !is null) return help;
        }
        return null;
    }
    bool Protected(CCircuitUnit@ u) {
        IUnitTask@ task=u.task;
        return task !is null && (task.IsExternalControlled() || task.IsEnemyReclaim()
            || task.GetType()==Task::Type::PLAYER || task.GetType()==Task::Type::RETREAT);
    }
    bool SafeSegment(const AIFloat3& in from,const AIFloat3& in to) {
        const int steps=AiMax(1,int(ceil(from.distance2D(to)/32.0f)));
        for(int i=0;i<=steps;++i) {
            const float t=float(i)/float(steps);
            const AIFloat3 p(from.x+(to.x-from.x)*t,0.0f,from.z+(to.z-from.z)*t);
            if(aiBattle.SurfThreat(p)>threat) return false;
        }
        return true;
    }
    array<AIFloat3>@ ExactSafeRoute(CCircuitUnit@ u,const AIFloat3& in destination) {
        array<AIFloat3>@ path=aiBattle.GetUnitTerrainRoute(u.circuitDef,u.GetPos(ai.frame),destination,true,1.0f,1.0f,10000.0f,0.0f,exitRadius);
        AIFloat3 previous=u.GetPos(ai.frame);
        for(uint i=0;i<path.length();++i) {
            if(!SafeSegment(previous,path[i])) {path.resize(0);break;}
            previous=path[i];
        }
        return path;
    }
    array<AIFloat3>@ SafeRoute(CCircuitUnit@ u,const AIFloat3& in destination) {
        if(u.GetPos(ai.frame).distance2D(destination)<=arrival && SafeSegment(u.GetPos(ai.frame),u.GetPos(ai.frame))) {
            array<AIFloat3> here={u.GetPos(ai.frame)};
            return here;
        }
        array<AIFloat3>@ path=ExactSafeRoute(u,destination);
        if(path.length()>0) return path;
        // Local geometric alternatives must not reinterpret an unsafe station
        // as a safe assignment merely because one edge lies outside fire range.
        if(aiBattle.SurfThreat(destination)>threat) return path;
        // A lane station is an arrival area, not a vacant building slot. Only
        // after the exact route fails, try four points strictly inside that
        // area. Every route/connector still passes the same threat checks.
        // Bounded five solves per retry; no new tick or all-unit scan.
        const float radius=arrival*0.75f;
        for(int i=0;i<4;++i) {
            const AIFloat3 offset(i==0?radius:i==1?-radius:0,0,i==2?radius:i==3?-radius:0);
            @path=ExactSafeRoute(u,destination+offset);
            if(path.length()>0) return path;
        }
        return path;
    }
    bool TryStation(EngineeringLanes::Lane@ lane) {
        int lead=-1;
        array<AIFloat3>@ leadPath;
        for(uint i=0;i<seats.length();++i) {
            CCircuitUnit@ u=ai.GetTeamUnit(seats[i].id);
            if(seats[i].helper || !Eligible(u) || Protected(u)) continue;
            array<AIFloat3>@ path=SafeRoute(u,lane.station);
            if(path.length()==0) continue;
            lead=int(i);@leadPath=path;break;
        }
        if(lead<0) return false;
        target=lane.team;station=lane.station;
        for(uint i=0;i<seats.length();++i) {
            seats[i].route.resize(0);seats[i].waypoint=0;seats[i].issued=-1;
            seats[i].retry=ai.frame;
        }
        seats[lead].route=leadPath;
        nextFollow=ai.frame+30*SECOND;
        GenericHelpers::LogUtil("[FrontlineEngineering] lane="+target+" held="+int(lane.share*100.0f)+"% members="+seats.length(),1);
        return true;
    }
    void FollowAssignedLane() {
        if(target<0 || ai.frame<nextFollow) return;
        nextFollow=ai.frame+30*SECOND;
        // Five minutes governs switching lanes, not following our current
        // lane's front. Only fresh movement >=128 triggers a route solve.
        // No re-ranking; O(L) small summaries, then the existing safe admission.
        for(uint i=0;i<EngineeringLanes::lanes.length();++i) {
            EngineeringLanes::Lane@ lane=EngineeringLanes::lanes[i];
            if(lane.team!=target) continue;
            if(ai.frame-lane.frame<=45*SECOND && lane.share>=0 && station.distance2D(lane.station)>=128)
                TryStation(lane);
            return;
        }
    }
    void SelectLane() {
        reassess=ai.frame+interval*SECOND;
        // Sort only allied lane summaries. Route work happens once per candidate
        // and member at reassessment, never per builder decision or simulation frame.
        // Insertion rank O(L^2), L = allied FRONT teams (normally <= 8).
        // One small allocation per reassessment, no all-unit scan.
        array<int> ranked;
        for(uint i=0;i<EngineeringLanes::lanes.length();++i) {
            EngineeringLanes::Lane@ candidate=EngineeringLanes::lanes[i];
            if(ai.frame-candidate.frame>45*SECOND || candidate.share<0) continue;
            uint at=0;
            while(at<ranked.length()) {
                EngineeringLanes::Lane@ previous=EngineeringLanes::lanes[ranked[at]];
                if(FrontlineEngineeringMath::BetterLane(candidate.share,candidate.team,previous.share,previous.team)) break;
                ++at;
            }
            ranked.insertAt(at,int(i));
        }
        for(uint attempt=0;attempt<ranked.length();++attempt) {
            EngineeringLanes::Lane@ lane=EngineeringLanes::lanes[ranked[attempt]];
            if(target==lane.team && station.distance2D(lane.station)<128.0f) return;
            if(TryStation(lane)) return;
        }
        if(target<0) {
            reassess=ai.frame+30*SECOND; // no first deployment yet
            GenericHelpers::LogUtil("[FrontlineEngineering] waiting lanes="+EngineeringLanes::lanes.length()
                +" usable="+ranked.length()+" members="+seats.length()+" reason="
                +(ranked.length()==0?"no_fresh_held_lane":"no_safe_constructor_route"),1);
        }
    }
    IUnitTask@ Work(CCircuitUnit@ u) {
        if(!active || !Eligible(u) || Protected(u)) return null;
        IUnitTask@ committed=aiBuilderMgr.SupportConstruction(u);
        if(committed !is null) return committed;
        Added(u);
        Seat@ seat;
        members.get(""+u.id,@seat);
        if(seat is null) return null;
        IBuilderTask@ current=cast<IBuilderTask>(u.task);
        if(seat.helper && current !is null && !current.IsDead() && current.buildDef !is null
            && current.buildDef.GetName()=="corpyro") return current;
        if(target>=0 && u.GetPos(ai.frame).distance2D(station)<=arrival) {
            if(seat.helper) {
                IUnitTask@ help=HelperWork(u);
                if(help !is null) return help;
            } else {
            int anchor=-1;
            for(uint i=0;i<constructorIds.length();++i) {
                CCircuitUnit@ member=ai.GetTeamUnit(constructorIds[i]);
                if(Eligible(member) && member.GetPos(ai.frame).distance2D(station)<=arrival) {anchor=member.id;break;}
            }
            IUnitTask@ build=aiBuilderMgr.SupportDefenseWork(u,anchor,ConstructorId(0),ConstructorId(1),ConstructorId(2));
            if(build !is null) return build;
            }
        }
        if(seat.wait !is null && !seat.wait.IsDead() && u.task is seat.wait) return seat.wait;
        @seat.wait=aiBuilderMgr.Enqueue(TaskB::Wait(10*SECOND));
        // A finished project may have moved this builder since the assignment
        // route was solved. Never use an unchecked connector to an old start.
        if(seat.waypoint==0 && seat.route.length()>0 && u.GetPos(ai.frame).distance2D(seat.route[0])>64.0f)
            seat.route.resize(0);
        seat.issued=-1;
        return seat.wait;
    }
    void Tick(bool released) {
        if(Global::AISettings::Role!=AiRole::TECH || ai.frame<next) return;
        next=ai.frame+SECOND;
        if(released) Load();
        if(released!=active) {
            active=released;reassess=-1;
            if(active) {
                array<int>@ own=ai.GetOwnedUnitIds();
                for(uint i=0;i<own.length();++i) Added(ai.GetTeamUnit(own[i]));
            } else {
                aiBuilderMgr.SupportDefenseWork(null,-1,-1,-1,-1);
                for(uint i=0;i<seats.length();++i) {
                    CCircuitUnit@ u=ai.GetTeamUnit(seats[i].id);
                    if(u !is null && u.task is seats[i].wait && !Protected(u)) u.CmdStop();
                    if(u !is null && seats[i].wasSolo) u.AddAttribute(Unit::Attr::SOLO.type);
                }
                seats.resize(0);members.deleteAll();constructorIds={-1,-1,-1};target=-1;return;
            }
        }
        if(!active) return;
        EngineeringReplacements::BaseEmergency(); // renew the shared snapshot reader at 1 Hz
        for(int i=int(seats.length())-1;i>=0;--i) if(!Eligible(ai.GetTeamUnit(seats[i].id))) {
            Forget(uint(i),ai.GetTeamUnit(seats[i].id) is null);
        }
        if(seats.length()==0) return;
        if(FrontlineEngineeringMath::ReassessmentDue(ai.frame,reassess)) SelectLane();
        else FollowAssignedLane();
        for(uint i=0;i<seats.length();++i) {
            Seat@ seat=seats[i];CCircuitUnit@ u=ai.GetTeamUnit(seat.id);
            if(Protected(u)) continue;
            // Finish existing construction before relocating. Task asks own
            // normal job changes; this tick drives only our explicit travel wait.
            IUnitTask@ offered=Work(u);
            if(offered !is null && offered !is u.task) aiBuilderMgr.AssignTask(u,offered);
            if(u.task !is seat.wait || target<0 || u.GetPos(ai.frame).distance2D(station)<=arrival) continue;
            if(seat.route.length()==0 && ai.frame>=seat.retry) {
                array<AIFloat3>@ path=SafeRoute(u,station);seat.route=path;
                seat.waypoint=0;seat.issued=-1;seat.retry=ai.frame+30*SECOND;
            }
            // A grid waypoint can lie just inside a nearby building's collision
            // margin. Accept its local cell neighborhood; validate the next
            // connector from the actual position before issuing any move.
            while(seat.waypoint<int(seat.route.length()) && u.GetPos(ai.frame).distance2D(seat.route[seat.waypoint])<=waypointRadius) ++seat.waypoint;
            if(seat.waypoint>=int(seat.route.length())) continue;
            if(!SafeSegment(u.GetPos(ai.frame),seat.route[seat.waypoint])) {
                u.CmdStop();seat.route.resize(0);seat.issued=-1;seat.retry=ai.frame+30*SECOND;continue;
            }
            if(seat.issued!=seat.waypoint) {u.CmdMoveTo(seat.route[seat.waypoint]);seat.issued=seat.waypoint;}
        }
    }
}
