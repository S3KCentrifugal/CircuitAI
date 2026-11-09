#pragma once
// D-501 (battle-group-composition-proposal.md, phases 1 to 3): the one owner
// of battle group membership decisions. The cohort world still records who
// is in which cohort and forms the first cohorts as units arrive; this
// registry decides, per group on its own staggered clock, whether the group
//   1. has come apart: members with no direct way to the rest (a mountain
//      between, group_cohesion::Components) or away from the centre for
//      `stray_seconds` leave as a new group;
//   2. is too big: members beyond the rank's maximum leave, farthest first;
//   3. should join another: it merges with the nearest compatible group
//      within the cohort's admission radius, fighting or not (side by side).
//      D-502: one main group per template (the largest screen cohort, the
//      lowest key on a tie) takes every other idle screen cohort, wherever it
//      is on the same terrain area: reinforcements and the survivors of a
//      split walk to it and merge on arrival, so it refills after losses. A
//      second group forms only where the main group is full (size_max) or
//      where a group is fighting on its own (a second front, an attack near
//      base); the latter walks to the main group once its fight ends. Below
//      its target a group that cannot join the main group walks to the
//      nearest compatible group within `join_seek_radius` (the higher key
//      walks). Merging two screens merges their support cohorts too while the
//      support rank allows; a lone support cohort merges into a nearby
//      support cohort and walks to the main group's screen when no screen is
//      within its pair_seek_radius.
// It decides in one pass and applies through the world's membership API
// (CRangedWorld::MergeCohorts, SplitCohort, SetRecruitTarget), at most one
// change per group per check.
//
// D-502: a cohesion split needs the separation on two consecutive checks
// and is never made in a fight; it used to shed one member at a time
// (441 splits against 3 merges in one 8v8 game).
//
// Cost: per check of one group, O(M log M + M K) for M <= MAX_GROUP_SIZE
// members (K = group_cohesion::NEIGHBOURS direct-passability tests each, every
// test length / 32 sector reads) plus O(L) over the L groups for a recruit;
// each group is checked once per `recruit_seconds`, so O(L^2 / period) at
// worst per AI. No engine query beyond unit positions, no orders.
// Phase: performance::BATTLE_GROUP_DECISION (inside the controller's update).
#include "control/kernel/GroupComposition.h"
#include "terrain/RangedGeometry.h"
#include "unit/RangedPolicy.h"

#include <functional>
#include <unordered_map>
#include <vector>

namespace circuit {
class CCircuitAI;
class CCircuitDef;
class CRangedWorld;

// What a template asks of the registry; size.target <= 0 leaves it off.
struct GroupSpec {
    group_composition::SizeSpec size{1, 0, 24};
    const std::vector<group_composition::RankSpec>* ranks = nullptr;
    float joinSeekRadius = 0.f, recruitSeconds = 2.f;
    float strayRadius = 0.f, straySeconds = 6.f, splitLink = 0.f;
    // D-504: a group smaller than recallSize walks to the main group even while
    // it fights (0: off), unless it fights within homeRadius of the base.
    int recallSize = 0;
    float homeRadius = 0.f;
    bool Enabled() const { return size.target > 0; }
};

class CGroupRegistry {
public:
    explicit CGroupRegistry(CCircuitAI* ai) : ai(ai) {}

    // The rank a cohort's formation position fills in a template.
    static const char* RankName(RangedPolicy::FormationPosition position);

    using SpecFor = std::function<const GroupSpec*(const CCircuitDef*)>;
    void Tick(CRangedWorld& world, int frame, const SpecFor& specFor);
    void UnitRemoved(int unitId) { straySince.erase(unitId); }

private:
    struct Live { int id; ranged::Point pos; };
    bool Cohesion(CRangedWorld& world, int key, const GroupSpec& spec, int frame);
    bool Size(CRangedWorld& world, int key, const GroupSpec& spec, const group_composition::RankSpec* rank);
    void Recruit(CRangedWorld& world, int key, const GroupSpec& spec, const group_composition::RankSpec* rank,
                 const SpecFor& specFor, int frame, int primary);
    // D-502: the main screen cohort of `spec`'s template, or -1. O(L) per tick.
    int Primary(const CRangedWorld& world, const GroupSpec* spec, const SpecFor& specFor) const;
    bool Gather(const CRangedWorld& world, int key, int frame);

    CCircuitAI* ai;
    std::unordered_map<int, int> straySince;  // member id -> first frame away from its group
    std::unordered_map<int, int> splitSeen;   // D-502: cohort key -> check that first saw it apart
    // Reused per check.
    std::vector<int> keys, label, leaving;
    std::vector<Live> live;
    std::vector<ranged::Point> points;
    ranged::Point centre{0.f, 0.f};
};

} // namespace circuit
