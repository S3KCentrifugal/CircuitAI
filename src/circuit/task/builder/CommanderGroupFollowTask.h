#pragma once
#include "task/common/WaitTask.h"

namespace circuit {
// One task per member under its actual builder/military manager. Builders move
// without autonomous GUARD construction; mobile sensors guard the anchor.
class CCommanderGroupFollowTask final: public IWaitTask {
public:
    CCommanderGroupFollowTask(ITaskModule* manager,int target,float radius,bool guard=false,
        const springai::AIFloat3& destination={-1,0,-1});
    void Start(CCircuitUnit* unit) override;
    void Update() override;
    void OnUnitIdle(CCircuitUnit* unit) override;
    void OnUnitDamaged(CCircuitUnit* unit,CEnemyInfo* attacker) override;
    int Target() const { return target; }
    const springai::AIFloat3& Destination() const { return destination; }
private:
    void Follow(CCircuitUnit* unit);
    int target,next=0,sent=-10000;
    float radius;
    bool waiting=false,guard=false;
    springai::AIFloat3 destination;
    springai::AIFloat3 goal{-1,0,-1};
};
}
