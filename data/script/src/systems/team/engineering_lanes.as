#include "roster.as"
#include "../../helpers/math/frontline_engineering_math.as"
// FRONT publishes bounded summaries, never unit lists or fog boundaries.
namespace EngineeringLanes {
    class Lane {
        int team=-1, frame=-1;
        float share=-1.0f;
        float combatDistance=-1.0f;
        AIFloat3 station;
    }
    array<Lane@> lanes;
    int nextPublish=0;
    void Publish() {
        if(Global::AISettings::Role!=AiRole::FRONT || ai.frame<nextPublish) return;
        nextPublish=ai.frame+15*SECOND;
        const float held=aiBattle.GetLaneHeldProgress();
        const float share=FrontlineEngineeringMath::OwnedShare(held,aiBattle.GetFrontLaneLength());
        const AIFloat3 station=aiBattle.GetFrontLanePoint(AiMax(0.0f,held-400.0f));
        const float distance=aiBattle.LaneCombatDistance(station,60);
        const float combat=distance>=0 && distance<100000?distance:-1;
        array<Team::Roster::Entry@>@ recipients=Team::Roster::WithRole(AiRole::TECH);
        for(uint i=0;i<recipients.length();++i)
            AiSendMessage("barbengineering|"+share+"|"+station.x+"|"+station.z+"|"+combat,recipients[i].teamId);
    }
    bool Handle(const string& in message,int sender) {
        if(message.findFirst("barbengineering|")!=0) return false;
        if(Global::AISettings::Role!=AiRole::TECH) return true;
        Team::Roster::Entry@ ally=Team::Roster::Get(sender);
        if(ally is null || ally.role!=AiRole::FRONT) return true;
        array<string>@ parts=message.split("|");
        if(parts.length()!=4 && parts.length()!=5) return true;
        const float share=parseFloat(parts[1]),x=parseFloat(parts[2]),z=parseFloat(parts[3]);
        if(!(share>=-1.0f && share<=1.0f && x>=0.0f && x<float(AiTerrainWidth()) && z>=0.0f && z<float(AiTerrainHeight()))) return true;
        Lane@ lane;
        for(uint i=0;i<lanes.length();++i) if(lanes[i].team==sender) {@lane=lanes[i];break;}
        if(lane is null) {@lane=Lane();lane.team=sender;lanes.insertLast(lane);}
        lane.frame=ai.frame;lane.share=share;lane.station=AIFloat3(x,0.0f,z);
        lane.combatDistance=parts.length()==5?parseFloat(parts[4]):-1;
        return true;
    }
}
