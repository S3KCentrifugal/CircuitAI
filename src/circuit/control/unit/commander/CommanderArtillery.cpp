/*
 * CommanderArtillery.cpp
 *
 * D-492 (owner, 2026-11-07): fire control for our static artillery (the
 * commander group's artillery definitions, whoever built them), and the soft
 * limit that keeps the group's artillery moving forward instead of stacking.
 */

#include "control/unit/commander/CommanderController.h"
#include "module/BuilderManager.h"
#include "unit/CircuitUnit.h"
#include "unit/enemy/EnemyUnit.h"
#include "spring/SpringUnit.h"
#include "CircuitAI.h"
#include "AISCommands.h"
#include "util/Utils.h"
#include "Log.h"
#include <algorithm>
#include <vector>

namespace circuit {
using springai::AIFloat3;

namespace {
// Fire control runs once per this many frames (one second).
constexpr int ARTILLERY_PERIOD_FRAMES=FRAMES_PER_SEC;
// An unchanged aim is ordered again after this many seconds (a dropped command).
constexpr int ARTILLERY_REISSUE_SECONDS=15;
// An attack order's engine timeout.
constexpr int ARTILLERY_ORDER_SECONDS=60;
// Heavy units are taken within this share of the artillery's range.
constexpr float ARTILLERY_HEAVY_RANGE_SHARE=.5f;
// The crowding log is written at most once per this many seconds.
constexpr int ARTILLERY_CROWD_LOG_SECONDS=30;
// Target kinds, highest first: an aim is kept until dead unless a higher kind appears.
enum ArtilleryKind { AIM_NONE=0, AIM_STATIC=1, AIM_HEAVY=2, AIM_SUPPORT=3 };
const char* KindName(int kind) {
    return kind==AIM_SUPPORT?"support":kind==AIM_HEAVY?"heavy":kind==AIM_STATIC?"static":"none";
}
}

bool CCommanderController::IsArtilleryDef(const CCircuitDef* def) const {
    if(!def) return false;
    const int id=def->GetId();
    return std::find(artilleryT2Defs.begin(),artilleryT2Defs.end(),id)!=artilleryT2Defs.end()
        || std::find(artilleryT1Defs.begin(),artilleryT1Defs.end(),id)!=artilleryT1Defs.end();
}

// From TaskFinished: a finished artillery structure of ours joins fire control.
// Not saved: after a load only artillery finished later is aimed.
void CCommanderController::AdoptArtillery(int unitId) {
    if(artilleryFireControl<=0 || artilleryAims.count(unitId)) return;
    artilleryAims[unitId]=ArtilleryAim{};
    ai->LOG("[Artillery] adopt unit=%i count=%i",unitId,int(artilleryAims.size()));
}

/*
 * Once a second, for every aimed artillery structure (A of them) against every
 * known enemy (E): O(A*E) distance tests, the enemies classified once per pass.
 * Order: an enemy construction turret or resurrection bot in range, a heavy
 * unit within half range, then the known static weapon with the longest range
 * (fired at by location until it is dead), else the engine's own targeting.
 * A static aim is kept until the enemy is gone; only a higher kind replaces it.
 * Commands only on a change or every ARTILLERY_REISSUE_SECONDS.
 */
void CCommanderController::UpdateArtillery() {
    const int frame=ai->GetLastFrame();
    if(artilleryFireControl<=0 || artilleryAims.empty() || frame<artilleryNext) return;
    artilleryNext=frame+ARTILLERY_PERIOD_FRAMES;
    struct Candidate { CEnemyInfo* enemy; AIFloat3 pos; int kind; float range; };
    std::vector<Candidate> candidates;
    for(const auto& kv:ai->GetEnemyInfos()) {
        CEnemyInfo* enemy=kv.second;
        if(!enemy || enemy->IsHidden()) continue;
        const CCircuitDef* def=enemy->GetCircuitDef();
        if(!def) continue;
        const bool mobile=def->IsMobile();
        if(mobile && !enemy->IsInRadarOrLOS()) continue;  // a remembered mobile position is stale
        int kind=AIM_NONE;
        if((!mobile && def->IsAbleToAssist() && def->GetBuildOptions().empty()) || (mobile && def->IsAbleToResurrect()))
            kind=AIM_SUPPORT;
        else if(mobile && (def->IsRoleHeavy() || (artilleryHeavyCost>0 && def->GetCostM()>=artilleryHeavyCost)))
            kind=AIM_HEAVY;
        else if(!mobile && def->GetMaxRange()>0.f)
            kind=AIM_STATIC;
        if(kind!=AIM_NONE) candidates.push_back(Candidate{enemy,enemy->GetPos(),kind,def->GetMaxRange()});
    }
    for(auto it=artilleryAims.begin();it!=artilleryAims.end();) {
        CCircuitUnit* unit=ai->GetTeamUnit(it->first);
        if(!unit || unit->IsDead()) { it=artilleryAims.erase(it); continue; }
        auto& aim=it->second;
        const AIFloat3 pos=unit->GetPos(frame);
        const float range=unit->GetCircuitDef()->GetMaxRange();
        const float rangeSq=SQUARE(range),heavySq=SQUARE(range*ARTILLERY_HEAVY_RANGE_SHARE);
        // The current aim, while its enemy lives and stays in range.
        const Candidate* current=nullptr;
        const Candidate* best=nullptr;
        float bestRange=-1.f,bestSq=0.f;
        for(const auto& c:candidates) {
            const float sq=pos.SqDistance2D(c.pos);
            if(sq>(c.kind==AIM_HEAVY?heavySq:rangeSq)) continue;
            if(c.enemy->GetId()==aim.target) current=&c;
            const bool better=!best || c.kind>best->kind
                || (c.kind==best->kind && (c.range>bestRange || (c.range==bestRange && sq<bestSq)));
            if(better) { best=&c; bestRange=c.range; bestSq=sq; }
        }
        const Candidate* chosen=(current && (!best || best->kind<=current->kind))?current:best;
        if(!chosen) {
            if(aim.target>=0) {
                TRY_UNIT(ai,unit,unit->CmdStop();)
                ai->LOG("[Artillery] release unit=%i target=%i: none in range, engine targeting",it->first,aim.target);
                aim=ArtilleryAim{};
            }
            ++it; continue;
        }
        const int id=chosen->enemy->GetId();
        if(id!=aim.target || frame>=aim.issued+ARTILLERY_REISSUE_SECONDS*FRAMES_PER_SEC) {
            const int timeout=frame+ARTILLERY_ORDER_SECONDS*FRAMES_PER_SEC;
            // A static is fired at by its location (also as a radar or sight ghost);
            // a mobile one by unit while it is seen or on radar.
            if(chosen->kind==AIM_STATIC || (chosen->kind==AIM_SUPPORT && !chosen->enemy->GetCircuitDef()->IsMobile())) {
                TRY_UNIT(ai,unit,unit->CmdAttackGround(chosen->pos,UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY,timeout);)
            } else {
                TRY_UNIT(ai,unit,unit->GetUnit()->Attack(chosen->enemy->GetUnit(),UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY,timeout);)
            }
            if(id!=aim.target)
                ai->LOG("[Artillery] aim unit=%i target=%i def=%s kind=%s range=%.0f at=%.0f,%.0f",it->first,id,
                    chosen->enemy->GetCircuitDef()->GetDef()->GetName(),KindName(chosen->kind),chosen->range,chosen->pos.x,chosen->pos.z);
            aim.target=id; aim.kind=chosen->kind; aim.issued=frame;
        }
        // INV-265: an aim never names an enemy the AI no longer knows.
        if(aim.target>=0 && ai->GetEnemyInfo(aim.target)==nullptr)
            ai->LOG("[INVARIANT] INV-265 artillery %i aims at unknown enemy %i",it->first,aim.target);
        ++it;
    }
}

/*
 * D-492: the group's artillery stacked in one block while the front stood
 * still (owner's screenshot, 2026-11-07). Another artillery structure is held
 * back while artillery_local_max of ours stand within artillery_local_radius
 * of where it would go (the def's open block, else the commander), unless the enemy statics in that def's reach there
 * outnumber them (then more guns are called for). Cost: O(A + E) per ask.
 */
bool CCommanderController::ArtilleryCrowded(const CCircuitDef* def) const {
    if(artilleryLocalMax<=0 || !def) return false;
    auto* anchor=GroupCommander();
    if(!anchor) return false;
    const int frame=ai->GetLastFrame();
    // Where the next one would go: the def's open block, else the commander
    // (played, aim arena b55: the commander walked on, the block stayed and
    // filled with seven Rattlesnakes the commander's disc never counted).
    AIFloat3 at=anchor->GetPos(frame);
    const auto block=tacticalBlocks.find(def->GetId());
    if(block!=tacticalBlocks.end() && block->second.group>0) at=block->second.centre;
    const float radiusSq=SQUARE(artilleryLocalRadius);
    int ours=0;
    for(const auto& kv:artilleryAims) {
        auto* unit=ai->GetTeamUnit(kv.first);
        if(unit && !unit->IsDead() && unit->GetPos(frame).SqDistance2D(at)<=radiusSq) ++ours;
    }
    if(tacticalJob && !tacticalJob->IsDead()) if(auto* build=dynamic_cast<IBuilderTask*>(tacticalJob);
        build && IsArtilleryDef(build->GetBuildDef())) ++ours;
    if(ours<int(artilleryLocalMax)) return false;
    const float reachSq=SQUARE(def->GetMaxRange()+artilleryLocalRadius);
    int statics=0;
    for(const auto& kv:ai->GetEnemyInfos()) {
        const CEnemyInfo* enemy=kv.second;
        if(!enemy || enemy->IsHidden() || !enemy->GetCircuitDef()) continue;
        if(!enemy->GetCircuitDef()->IsMobile() && enemy->GetPos().SqDistance2D(at)<=reachSq) ++statics;
    }
    if(statics>ours) return false;
    if(frame>=artilleryCrowdLog) {
        artilleryCrowdLog=frame+ARTILLERY_CROWD_LOG_SECONDS*FRAMES_PER_SEC;
        ai->LOG("[CommanderGroup] artillery_crowded def=%s ours=%i statics=%i at=%.0f,%.0f",
            def->GetDef()->GetName(),ours,statics,at.x,at.z);
    }
    return true;
}

} // namespace circuit
