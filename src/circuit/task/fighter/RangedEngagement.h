#ifndef CIRCUIT_RANGED_ENGAGEMENT_H
#define CIRCUIT_RANGED_ENGAGEMENT_H
#include "task/fighter/RangedWorld.h"
#include "unit/RangedPolicy.h"
#include "task/fighter/ArtilleryTask.h"
#include <memory>

namespace springai { class Weapon; }
namespace circuit {
class IUnitTask;
class IPathQuery;
class CRangedEngagement {
public:
    CRangedEngagement(CCircuitAI* ai, IUnitTask* owner, CCircuitUnit* unit);
    ~CRangedEngagement();
    void Update(CCircuitUnit* unit);
    void Idle() { nextFrame=0; }
    void BlindHit(CCircuitUnit* unit); // owner 2026-11-07
    void MoveFailed() { query.reset(); moving=false; completedMove=false; orientUntil=0; nextFrame=0; ++failures; ++rejections; }
    void Release(CCircuitUnit* unit, bool commands=true);
    int Target() const { return target; }
    bool IsSustainedRush() const { return world.IsSustainedRush(id); }
    // Owner 2026-10-19/27, 2026-11-06: spam for this policy (roster, cost class,
    // and with spam_radar_dots an unidentified ground radar dot). Public so the
    // military manager's spam hold uses the same rule outside the controller.
    static bool Spam(const RangedPolicy& policy,const CRangedWorld::Contact& c);
private:
    void SelectTarget(CCircuitUnit* unit,int id,int weapon,float damage,float score=-1.f);
    bool Move(CCircuitUnit* unit,const springai::AIFloat3& destination,bool escape,bool urgent=false);
    void Hold(CCircuitUnit* unit,bool unsafe=false);
    void UpdateFireState(CCircuitUnit* unit,bool open);
    void Disperse(CCircuitUnit* unit);
    void UpdateCohort(CCircuitUnit* unit);
    bool LegalPath(CCircuitUnit* unit,const std::vector<springai::AIFloat3>& route,bool escape);
    bool SafeMove(CCircuitUnit* unit,const springai::AIFloat3& from,const springai::AIFloat3& to,float margin,bool escape);
    bool UnknownStaticBlocks(CCircuitUnit* unit,const springai::AIFloat3& from,const springai::AIFloat3& to);
    // Owner 2026-11-16 (Catapults, Daedalus, Myrmidons idle at the gantry): with no
    // shot, no danger and no usable firing site, walk a threat-aware path towards
    // the objective (or the nearest known enemy) and stop where the walk would
    // enter live or ghost static coverage: the front. False when nothing to do.
    bool March(CCircuitUnit* unit,const springai::AIFloat3& pos,const springai::AIFloat3* objective,float maxRange);
    bool MarchGoal(const springai::AIFloat3& pos,springai::AIFloat3& goal);
    // Owner 2026-11-16: RANGEDTIME log lines, once per unit: born (first
    // assignment), front, engage (first shot or drone launch target).
    void TimingTick(CCircuitUnit* unit,const springai::AIFloat3& pos,float maxRange,bool drones);
    void TimingFront(CCircuitUnit* unit,const char* reason);
    CCircuitAI* ai;
    IUnitTask* owner;
    // Tasks may outlive the derived manager destructor during shutdown.
    std::shared_ptr<CRangedWorld> worldOwner;
    CRangedWorld& world;
    const CRangedWorld::Capabilities& caps;
    int id, target=-1, weaponIndex=-1, nextFrame=0, targetFrame=0;
    int lastReload=-1, burstUntil=0, withdrawalUntil=0, failures=0;
    int lastProgressFrame=0, lastMoveFrame=-10000;
    int lastShotFrame=0, orientUntil=0;
    SGhostFire ghostFire;
    std::unordered_map<int, bool> ghostSupport;
    int traceFrame=-150;
    int homeHoldLogFrame=-150;
    int blindLogFrame=-90;
    bool fireOpen=false; int fireStateFrame=-10000; // individual fire_at_will: last state sent
    size_t pathCursor=0;
    springai::AIFloat3 lastPos, destination;
    std::unique_ptr<springai::Weapon> liveWeapon;
    std::unique_ptr<springai::Weapon> pokeWeapon; // primary mount, owned for this engagement
    int pokeReload=-1,pokeShotFrame=-100000;
    std::shared_ptr<IPathQuery> query;
    // Callback cancellation must not depend on allocator reuse of this/owner.
    std::shared_ptr<int> lifetime=std::make_shared<int>(0);
    unsigned generation=0;
    bool urgentMove=false;
    bool completedMove=false;
    int moveObjective=-1, moveMode=-1;
    int pokePhase=-1; // owner 2026-10-17: -1 not poking, 1 stepping in, 0 stepping out
    bool moving=false, issuing=false, released=false, cloakWanted=false, reorient=false;
    float reservedDamage=0.f;
    float heldScore=0.f; int heldScoreFrame=-1; // current target's score, the tick it last passed the candidate filters
    std::vector<int> nearby;
    // D-295 assist state: reused query buffer (capacity retained), the
    // current assisted contact id (log once per change), and the INV-206
    // one-decision follow-up of an accepted assist Move.
    std::vector<int> assistNearby;
    std::vector<int> ghostNearby; // owner 2026-11-02: ghost porc around this hull, reused storage
    std::vector<int> coverageProbe; // trace only: contacts near a rejected firing site
    int assistTarget=-1, assistCheckFrame=-1, assistIdleStreak=0;
    // Monotonic count of rejected worker paths and engine move failures;
    // unlike `failures` it is never reset by progress (INV-206 baseline).
    unsigned rejections=0, assistCheckRejections=0;
    bool assistInvariantLogged=false;
    std::vector<springai::AIFloat3> path;
    bool marching=false; int marchRetryFrame=0;
    int spamIdleSince=0; bool spamIdleLogged=false;   // owner 2026-11-21: spam_fire_idle_seconds
    std::vector<springai::AIFloat3> unknownStill; int unknownStillFrame=-1;   // owner 2026-11-21: unknown_static_reach
    springai::AIFloat3 marchGoal;
    // Owner 2026-11-23 (Salt Reef): shun_seconds. Contacts left alone until a
    // frame: engine-refused shots and objectives with no firing site or path.
    std::vector<std::pair<int,int>> shunned;   // contact id, until frame
    int refusedTarget=-1, refusedCount=0;      // stalls on the current target
    int marchObjective=-1, marchObjectiveHalts=0;   // objective of the march, its no-progress halts
    bool Shunned(int contact) const;
    void SetMarchObjective(int contact) { if(contact!=marchObjective) { marchObjective=contact; marchObjectiveHalts=0; } }
    void Shun(int contact,const char* why);
};
}
#endif
