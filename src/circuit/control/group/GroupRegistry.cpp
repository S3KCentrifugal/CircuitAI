#include "control/group/GroupRegistry.h"
#include "control/kernel/GroupCohesion.h"
#include "task/fighter/RangedWorld.h"
#include "terrain/TerrainManager.h"
#include "unit/CircuitDef.h"
#include "unit/CircuitUnit.h"
#include "CircuitAI.h"
#include "setup/SetupManager.h"
#include "util/Utils.h"
#include "Log.h"

#include <algorithm>

namespace circuit {

namespace {
using springai::AIFloat3;
using FormationPosition = RangedPolicy::FormationPosition;
// Two groups merge once their anchors are within this share of the cohort
// radius: the admission JoinCohort and the cohort merge already use.
constexpr float ADMISSION_SHARE = .5f;
AIFloat3 A(ranged::Point p) { return AIFloat3(p.x, 0.f, p.z); }
}

const char* CGroupRegistry::RankName(FormationPosition position)
{
    switch (position) {
        case FormationPosition::FRONT: return "screen";
        case FormationPosition::REAR: return "support";
        default: return "";
    }
}

bool CGroupRegistry::Gather(const CRangedWorld& world, int key, int frame)
{
    live.clear();
    const auto it = world.Cohorts().find(key);
    if (it == world.Cohorts().end()) return false;
    centre = {0.f, 0.f};
    for (int id : it->second.members) {
        auto* u = ai->GetTeamUnit(id);
        if (u == nullptr || u->IsDead()) continue;
        const AIFloat3 p = u->GetPos(frame);
        live.push_back({id, {p.x, p.z}});
        centre.x += p.x; centre.z += p.z;
    }
    if (live.empty()) return false;
    centre.x /= float(live.size()); centre.z /= float(live.size());
    return true;
}

bool CGroupRegistry::Cohesion(CRangedWorld& world, int key, const GroupSpec& spec, int frame)
{
    leaving.clear();
    const auto& plan = world.Cohorts().at(key);
    auto* anchor = ai->GetTeamUnit(plan.members.front());
    terrain::SArea* area = anchor != nullptr ? anchor->GetArea() : nullptr;
    // 1a. Parts with no direct way between them (a mountain): the largest part,
    // the anchor's on a tie, keeps the group.
    ranged::Point kept = centre;
    // D-502: a fight spreads a group on purpose; split only out of one.
    if (spec.splitLink > 0.f && live.size() > 1 && plan.target < 0) {
        points.clear();
        for (const Live& m : live) points.push_back(m.pos);
        auto* terrain = ai->GetTerrainManager();
        const int parts = group_cohesion::Components(points, spec.splitLink, [&](ranged::Point a, ranged::Point b) {
            return terrain->IsDirectPassable(area, A(a), A(b));
        }, label);
        if (parts > 1) {
            int anchorIndex = 0;
            for (std::size_t i = 0; i < live.size(); ++i) if (live[i].id == plan.members.front()) anchorIndex = int(i);
            const int part = group_cohesion::KeptPart(label, parts, anchorIndex);
            kept = {0.f, 0.f}; int count = 0;
            for (std::size_t i = 0; i < live.size(); ++i) {
                if (label[i] == part) { kept.x += live[i].pos.x; kept.z += live[i].pos.z; ++count; }
                else leaving.push_back(live[i].id);
            }
            if (count > 0) { kept.x /= float(count); kept.z /= float(count); }
        }
    }
    // 1b. Strays: away from the kept part's centre for stray_seconds, and only
    // while the group is not fighting (a fight spreads a group on purpose).
    if (spec.strayRadius > 0.f && plan.target < 0) {
        const int frames = int(spec.straySeconds * FRAMES_PER_SEC);
        for (const Live& m : live) {
            if (std::find(leaving.begin(), leaving.end(), m.id) != leaving.end()) continue;
            const float d = ranged::DistanceSq(m.pos, kept);
            if (d <= spec.strayRadius * spec.strayRadius) { straySince.erase(m.id); continue; }
            const int since = straySince.try_emplace(m.id, frame).first->second;
            if (group_cohesion::Stray(d, spec.strayRadius, since, frame, frames)) leaving.push_back(m.id);
        }
    }
    if (leaving.empty() || leaving.size() >= live.size()) { splitSeen.erase(key); return false; }
    // D-502: the separation must still stand on the next check (a group
    // crossing a ridge or strung out on a road joins up again by itself).
    if (splitSeen.try_emplace(key, frame).second) return false;
    splitSeen.erase(key);
    for (int id : leaving) straySince.erase(id);
    const int part = world.SplitCohort(key, leaving);
    ai->LOG("GROUP: registry split group=%i part=%i leaving=%u reason=cohesion frame=%i", key, part, unsigned(leaving.size()), frame);
    return part >= 0;
}

bool CGroupRegistry::Size(CRangedWorld& world, int key, const GroupSpec& spec, const group_composition::RankSpec* rank)
{
    const int excess = group_composition::Excess(int(live.size()), rank, spec.size);
    if (excess <= 0) return false;
    // The farthest from the centre leave: they would walk farthest to a slot.
    std::sort(live.begin(), live.end(), [&](const Live& a, const Live& b) {
        const float da = ranged::DistanceSq(a.pos, centre), db = ranged::DistanceSq(b.pos, centre);
        return da != db ? da > db : a.id < b.id;
    });
    leaving.clear();
    for (int i = 0; i < excess; ++i) leaving.push_back(live[i].id);
    const int part = world.SplitCohort(key, leaving);
    ai->LOG("GROUP: registry split group=%i part=%i leaving=%u reason=size", key, part, unsigned(leaving.size()));
    return part >= 0;
}

int CGroupRegistry::Primary(const CRangedWorld& world, const GroupSpec* spec, const SpecFor& specFor) const
{
    int best = -1; std::size_t size = 0;
    for (const auto& [key, g] : world.Cohorts()) {
        if (g.members.empty()) continue;
        auto* u = ai->GetTeamUnit(g.members.front());
        if (u == nullptr || u->IsDead()) continue;
        const CCircuitDef* def = u->GetCircuitDef();
        if (def->GetRangedPolicy().formationPosition != FormationPosition::FRONT || specFor(def) != spec) continue;
        if (g.members.size() > size) { size = g.members.size(); best = key; }  // map order: the lowest key wins a tie
    }
    return best;
}

void CGroupRegistry::Recruit(CRangedWorld& world, int key, const GroupSpec& spec, const group_composition::RankSpec* rank,
                             const SpecFor& specFor, int frame, int primary)
{
    const auto& cohorts = world.Cohorts();
    const auto& plan = cohorts.at(key);
    auto* leader = ai->GetTeamUnit(plan.members.front());
    if (leader == nullptr) return;
    const CCircuitDef* def = leader->GetCircuitDef();
    const auto& policy = def->GetRangedPolicy();
    const bool rear = policy.formationPosition == FormationPosition::REAR;
    // A paired support cohort follows its screen; it merges with the screen's merges.
    if (rear && plan.formationPartner >= 0) {
        if (plan.recruitTarget >= 0) world.SetRecruitTarget(key, -1);
        return;
    }
    const int size = int(live.size());
    const AIFloat3 here = A(centre);
    const auto anchorOf = [&](const CRangedWorld::CohortPlan& g) -> CCircuitUnit* {
        auto* u = g.members.empty() ? nullptr : ai->GetTeamUnit(g.members.front());
        return (u == nullptr || u->IsDead() || u->GetArea() != leader->GetArea()) ? nullptr : u;
    };
    // 1. Merge with the nearest compatible group already beside this one,
    // fighting or not: groups fighting side by side are one group.
    const float admit = policy.cohortRadius * ADMISSION_SHARE;
    int beside = -1; float besideDistance = admit * admit;
    for (const auto& [other, g] : cohorts) {
        if (other == key) continue;
        auto* u = anchorOf(g);
        if (u == nullptr) continue;
        const CCircuitDef* otherDef = u->GetCircuitDef();
        if (otherDef->GetRangedPolicy().formationPosition != policy.formationPosition || !world.Compatible(def, otherDef)) continue;
        if (specFor(otherDef) == nullptr || !group_composition::CanMerge(size, int(g.members.size()), rank, spec.size)) continue;
        const float d = u->GetPos(frame).SqDistance2D(here);
        if (d < besideDistance || (d == besideDistance && other < beside)) { besideDistance = d; beside = other; }
    }
    if (beside >= 0) {
        // Into the main group if either is; else into a paired support cohort
        // for a lone one; else the lower key: never flips with check order.
        const bool besidePaired = cohorts.at(beside).formationPartner >= 0;
        int into = std::min(key, beside);
        if (key == primary || beside == primary) into = primary;
        else if (rear) into = besidePaired ? beside : std::min(key, beside);
        const int from = into == key ? beside : key;
        const int fromRear = rear ? -1 : cohorts.at(from).formationPartner;
        const int intoRear = rear ? -1 : cohorts.at(into).formationPartner;
        world.MergeCohorts(from, into);
        ai->LOG("GROUP: registry merge group=%i into=%i members=%u main=%i frame=%i", from, into, unsigned(cohorts.at(into).members.size()), primary, frame);
        // Their support cohorts merge too while the support rank allows it.
        if (fromRear >= 0 && intoRear >= 0 && fromRear != intoRear) {
            const auto fr = cohorts.find(fromRear), ir = cohorts.find(intoRear);
            if (fr != cohorts.end() && ir != cohorts.end()) {
                const group_composition::RankSpec* support = spec.ranks ? group_composition::Find(*spec.ranks, RankName(FormationPosition::REAR)) : nullptr;
                if (group_composition::CanMerge(int(fr->second.members.size()), int(ir->second.members.size()), support, spec.size)) {
                    world.MergeCohorts(fromRear, intoRear);
                    ai->LOG("GROUP: registry merge group=%i into=%i reason=support frame=%i", fromRear, intoRear, frame);
                }
            }
        }
        return;
    }
    // 2. Walk, only out of a fight (a group fighting on its own is a second front).
    // D-504: a group below recall_size is no front; it walks to the main group
    // even while it fights (firing on the way), unless the fight is at home.
    const AIFloat3& home = ai->GetSetupManager()->GetBasePos();
    const bool atHome = spec.homeRadius > 0.f && here.SqDistance2D(home) < spec.homeRadius * spec.homeRadius;
    // The recall holds once given (the walk itself clears the target) until the merge.
    const bool recalled = (plan.target >= 0 || plan.recruitUrgent) && !rear && size < spec.recallSize && !atHome;
    const bool mayWalk = plan.target < 0 || recalled;
    int walk = -1;
    if (mayWalk && primary >= 0 && primary != key) {
        const auto main = cohorts.find(primary);
        if (main != cohorts.end() && anchorOf(main->second) != nullptr) {
            // A lone support cohort walks to the main screen; pairing links it there.
            if (rear || group_composition::CanMerge(size, int(main->second.members.size()), rank, spec.size)) walk = primary;
        }
    }
    if (walk < 0 && !rear && mayWalk && group_composition::Recruits(size, rank, spec.size)) {
        // The main group is full or unreachable: gather with the nearest group in reach.
        const float seek = std::max(spec.joinSeekRadius, admit);
        float nearest = seek * seek;
        for (const auto& [other, g] : cohorts) {
            if (other == key) continue;
            auto* u = anchorOf(g);
            if (u == nullptr) continue;
            const CCircuitDef* otherDef = u->GetCircuitDef();
            if (otherDef->GetRangedPolicy().formationPosition != policy.formationPosition || !world.Compatible(def, otherDef)) continue;
            if (specFor(otherDef) == nullptr || !group_composition::CanMerge(size, int(g.members.size()), rank, spec.size)) continue;
            const float d = u->GetPos(frame).SqDistance2D(here);
            if (d < nearest && key > other) { nearest = d; walk = other; }  // the higher key walks
        }
    }
    const bool urgent = walk >= 0 && recalled;
    if (walk != plan.recruitTarget || urgent != plan.recruitUrgent) {
        world.SetRecruitTarget(key, walk, urgent);
        if (walk >= 0) ai->LOG("GROUP: registry join group=%i walks_to=%i members=%i main=%i recalled=%i frame=%i", key, walk, size, primary, int(urgent), frame);
    }
}

void CGroupRegistry::Tick(CRangedWorld& world, int frame, const SpecFor& specFor)
{
    // Snapshot keys: a merge or split edits the cohort map.
    keys.clear();
    for (const auto& [key, plan] : world.Cohorts()) if (!plan.members.empty()) keys.push_back(key);
    for (auto it = splitSeen.begin(); it != splitSeen.end();) {
        if (world.Cohorts().count(it->first) == 0) it = splitSeen.erase(it); else ++it;
    }
    for (int key : keys) {
        const auto it = world.Cohorts().find(key);
        if (it == world.Cohorts().end() || it->second.members.empty()) continue;
        auto* leader = ai->GetTeamUnit(it->second.members.front());
        if (leader == nullptr || leader->IsDead()) continue;
        const CCircuitDef* def = leader->GetCircuitDef();
        const auto position = def->GetRangedPolicy().formationPosition;
        if (position == FormationPosition::NONE) continue;
        const GroupSpec* spec = specFor(def);
        if (spec == nullptr || !spec->Enabled()) continue;
        if (!world.CompositionDue(key, frame, int(spec->recruitSeconds * FRAMES_PER_SEC))) continue;
        if (!Gather(world, key, frame)) continue;
        const group_composition::RankSpec* rank = spec->ranks ? group_composition::Find(*spec->ranks, RankName(position)) : nullptr;
        if (Cohesion(world, key, *spec, frame)) continue;
        if (Size(world, key, *spec, rank)) continue;
        // The main group as of now: a merge or split above can change it.
        Recruit(world, key, *spec, rank, specFor, frame, Primary(world, spec, specFor));
    }
}

} // namespace circuit
