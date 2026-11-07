/*
 * CommanderArtillery.cpp
 *
 * D-492 / D-493: the commander group's side of artillery: which definitions
 * are artillery, and whether another may go up at the next site (crowding).
 * Fire control is the artillery controller's (control/unit/artillery/).
 */

#include "control/unit/commander/CommanderController.h"
#include "control/unit/artillery/ArtilleryController.h"
#include "control/kernel/ArtilleryTargeting.h"
#include "task/builder/BuilderTask.h"
#include "unit/CircuitUnit.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "Log.h"
#include <algorithm>

namespace circuit {
using springai::AIFloat3;

namespace {
// The crowding log is written at most once per this many seconds.
constexpr int ARTILLERY_CROWD_LOG_SECONDS=30;
}

bool CCommanderController::IsArtilleryDef(const CCircuitDef* def) const {
    if(!def) return false;
    const int id=def->GetId();
    return std::find(artilleryT2Defs.begin(),artilleryT2Defs.end(),id)!=artilleryT2Defs.end()
        || std::find(artilleryT1Defs.begin(),artilleryT1Defs.end(),id)!=artilleryT1Defs.end();
}

/*
 * The group holds another artillery structure back while artillery_local_max
 * of ours stand within artillery_local_radius of where it would go (the def's
 * open block, else the commander), unless the enemy structures in that def's
 * reach there outnumber them (artillery::Crowded). The counts come from the
 * artillery controller's census and the side's combat snapshot: O(A + k).
 */
bool CCommanderController::ArtilleryCrowded(const CCircuitDef* def) const {
    if(artilleryLocalMax<=0 || !def) return false;
    auto* census=ai->GetArtilleryCensus();
    auto* anchor=GroupCommander();
    if(!census || !anchor) return false;
    const int frame=ai->GetLastFrame();
    AIFloat3 at=anchor->GetPos(frame);
    const auto block=tacticalBlocks.find(def->GetId());
    if(block!=tacticalBlocks.end() && block->second.group>0) at=block->second.centre;
    int ours=census->CountNear(at,artilleryLocalRadius);
    if(tacticalJob && !tacticalJob->IsDead()) if(auto* build=dynamic_cast<IBuilderTask*>(tacticalJob);
        build && IsArtilleryDef(build->GetBuildDef())) ++ours;
    const int statics=census->EnemyStaticsNear(at,def->GetMaxRange()+artilleryLocalRadius);
    if(!artillery::Crowded(ours,statics,int(artilleryLocalMax))) return false;
    if(frame>=artilleryCrowdLog) {
        artilleryCrowdLog=frame+ARTILLERY_CROWD_LOG_SECONDS*FRAMES_PER_SEC;
        ai->LOG("[CommanderGroup] artillery_crowded def=%s ours=%i statics=%i at=%.0f,%.0f",
            def->GetDef()->GetName(),ours,statics,at.x,at.z);
    }
    return true;
}

} // namespace circuit
