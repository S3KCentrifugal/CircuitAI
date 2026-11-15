#include "task/fighter/RangedWorld.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "Log.h"
#include "module/MilitaryManager.h"
#include "setup/SetupManager.h"
#include "terrain/TerrainManager.h"
#include "unit/CircuitUnit.h"
#include "unit/CircuitWDef.h"
#include "unit/enemy/EnemyUnit.h"
#include "unit/enemy/EnemyManager.h"
#include "spring/SpringMap.h"
#include "spring/SpringUnit.h"
#include "spring/SpringCallback.h"
#include "util/Performance.h"
#include "unit/ally/AllyTeam.h"
#include "Damage.h"
#include "WeaponMount.h"
#include <algorithm>
#include <cmath>
#include <cstdlib>

namespace circuit {
using springai::AIFloat3;
static ranged::Point P(const AIFloat3& p) { return {p.x,p.z}; }
static const bool verifyRangedQueries=std::getenv("CIRCUIT_VERIFY_RANGED_QUERIES")!=nullptr;
// A contact unseen for longer than this leaves the stall history (frames).
static constexpr int HISTORY_FRAMES = 1800;
bool CRangedWorld::PeerSeesCommander(const Contact& contact,CCircuitDef* def,const AIFloat3& shooter,float peerRadius) const
{
    if(!contact.los || !contact.def || !contact.def->IsEnemyRoleAny(CCircuitDef::COMM)) return false;
    EnsureAllies();
    bool seen=false;
    // Reuse the current legal friendly snapshot and spatial buckets. No army
    // scan per hull; only commander candidates query local same-definition
    // peers. LOS is aggregate legal LOS plus the individual peer's sight disc.
    allies.Query(P(contact.pos),def->GetLosRadius(),[&](int index) {
        const auto& peer=friends[index];
        if(!seen && peer.def==def && peer.pos.SqDistance2D(contact.pos)<=SQUARE(peer.los)
            && peer.pos.SqDistance2D(shooter)<=SQUARE(peerRadius)) {
            auto* observer=circuit->GetFriendlyUnit(peer.id);
            if(observer && !observer->GetUnit()->IsBeingBuilt()) seen=true;
        }
    });
    return seen;
}
CRangedWorld::CRangedWorld(CCircuitAI* circuit)
    : circuit(circuit), observation(circuit->GetAllyTeam()->GetRangedObservation(circuit)),
      contacts(observation->Contacts()), objectives(observation->Objectives()),
      enemies(observation->Enemies()), staticHazards(observation->StaticHazards()),
      clusterValues(observation->ClusterValues()), friends(observation->Friends()),
      allies(observation->AlliesIndex()), history(MAX_UNITS,HISTORY_FRAMES)
{
    const float width=float(circuit->GetMap()->GetWidth()*SQUARE_SIZE);
    const float height=float(circuit->GetMap()->GetHeight()*SQUARE_SIZE);
    formations.Configure(width,height);
}
CRangedWorld::Weapon::Weapon() = default;
CRangedWorld::Weapon::~Weapon() = default;
CRangedWorld::Weapon::Weapon(Weapon&&) noexcept = default;
CRangedWorld::Weapon& CRangedWorld::Weapon::operator=(Weapon&&) noexcept = default;
CRangedWorld::~CRangedWorld() = default;

const CRangedWorld::Capabilities& CRangedWorld::CapabilitiesFor(CCircuitDef* def)
{
    auto [it,fresh]=capabilities.try_emplace(def->GetId());
    auto& c=it->second;
    if (!fresh) return c;
    auto* ud=def->GetDef();
    c.speed=def->GetSpeed(); c.turnRate=ud->GetTurnRate();
    c.acceleration=ud->GetMaxAcceleration(); c.radius=def->GetRadius();
    c.cloak=def->IsAbleToCloak();
    c.cloakCost=ud->GetCloakCost(); c.cloakMoving=ud->GetCloakCostMoving();
    const std::unique_ptr<springai::WeaponDef> death(ud->GetDeathExplosion());
    if (death) c.blastRadius=death->GetAreaOfEffect(); // wrapper already returns radius
    for (auto* raw: ud->GetWeaponMounts()) {
        Weapon w; w.mount.reset(raw);
        const std::unique_ptr<springai::WeaponDef> wd(raw->GetWeaponDef());
        if (!wd || wd->IsShield() || wd->IsManualFire()) continue;
        const auto& params=wd->GetCustomParams();
        w.fake=params.find("fake_weapon")!=params.end();
        w.def=circuit->GetWeaponDef(wd->GetWeaponDefId());
        const std::unique_ptr<springai::Damage> damage(wd->GetDamage());
        if (damage) w.damage=damage->GetTypes();
        const bool carrier=def->GetRangedPolicy().mode==RangedPolicy::Mode::CARRIER;
        if (!carrier && (w.fake || w.damage.empty() || w.damage[0]<=0.f || wd->IsParalyzer())) continue;
        w.index=raw->GetWeaponMountId(); w.category=raw->GetOnlyTargetCategory();
        w.range=wd->GetRange(); w.arc=raw->GetMaxAngleDif();
        w.forward=w.arc>-.99f;
        w.reload=std::max(.1f,wd->GetReload());
        w.burst=std::max(wd->GetBeamTime(),wd->GetSalvoDelay()*std::max(0,wd->GetSalvoSize()-1));
        w.alphaScale=float(std::max(1,wd->GetSalvoSize())*std::max(1,wd->GetProjectilesPerShot()));
        w.splash=wd->GetAreaOfEffect(); w.heightMod=wd->GetHeightMod(); w.cylinder=wd->GetCylinderTargetting();
        const std::string weaponType=wd->GetType();
        w.ballistic=weaponType=="Cannon";
        w.instant=weaponType=="BeamLaser" || weaponType=="LightningCannon" || weaponType=="Melee";
        w.continuous=wd->IsNoExplode();
        // Immutable per-definition metadata: two callbacks once per beam,
        // retained for this AI lifetime; no live weapon calls in risk scoring.
        if(weaponType=="BeamLaser") {
            w.beamMinIntensity=wd->GetMinIntensity();
            w.beamTargetBorder=std::max(0.f,wd->GetTargetBorder());
        }
        w.guided=wd->IsTracks();
        // highTrajectory 2 = switchable, fired low unless toggled (RangedPolicy::lowTrajectory).
        w.high=w.def && w.def->IsHighTrajectory()
            && !(def->GetRangedPolicy().lowTrajectory && w.ballistic && wd->GetHighTrajectory()==2);
        w.speed=wd->GetProjectileSpeed();
        w.gravity=wd->GetMyGravity()>0.f ? wd->GetMyGravity() : -circuit->GetMap()->GetGravity();
        c.weapons.push_back(std::move(w));
    }
    return c;
}

void CRangedWorld::Refresh()
{
    const int now=circuit->GetLastFrame();
    if (frame==now) return;
    performance::Scope measured(circuit,performance::RANGED_SNAPSHOT);
    frame=now; formations.Clear();
    largestSpacing=0.f;
    // D-462: the ally team's shared contacts for this frame and enemy revision
    // (built here if this AI is the first reader since they changed), and this
    // AI bound as the reader of the shared friend cells for its turn.
    observation->AcquireContacts(circuit);
    const auto& bounds=observation->Bounds();
    largestRange=bounds.largestRange; largestStaticRange=bounds.largestStaticRange;
    largestCohortHazard=bounds.largestCohortHazard;
    nonnegativeHazardCosts=bounds.nonnegativeHazardCosts; finiteStaticHazards=bounds.finiteStaticHazards;
    observation->BindFriends(circuit);
    largestFriendRadius=0.f; // slots only; friends' radius comes from the observation per query
    ObserveHistory(now);
    performance::Scope statePhase(circuit,performance::RANGED_STATE);
    for (auto it=slots.begin();it!=slots.end();) {
        auto* u=circuit->GetTeamUnit(it->first);
        if (!u || u->IsDead() || !u->GetCircuitDef()->HasEngagementPolicy()) {
            // Match task-release cleanup even if a lifecycle callback arrived
            // after this snapshot. Otherwise stale members inflate rush value
            // and keep empty cohorts alive. Advance before Leave erases here.
            const int stale=(it++)->first;
            Leave(stale);
            continue;
        }
        formations.Add(P(it->second.pos),it->first);
        largestSpacing=std::max(largestSpacing,it->second.spacing); ++it;
    }
    for (auto it=shots.begin();it!=shots.end();) {
        if (it->second.until<=now || !circuit->GetEnemyManager()->GetEnemyUnit(it->second.target) || !slots.count(it->first)) {
            auto sum=reserved.find(it->second.target);
            if (sum!=reserved.end()) {
                sum->second-=it->second.damage;
                if (sum->second<.01f) reserved.erase(sum);
            }
            it=shots.erase(it);
        } else ++it;
    }
    for (auto it=escorts.begin();it!=escorts.end();) {
        if (!circuit->GetTeamUnit(it->first) || !slots.count(it->second.anchor)) it=escorts.erase(it); else ++it;
    }
}

void CRangedWorld::Join(CCircuitUnit* unit)
{
    const auto* d=unit->GetCircuitDef();
    SetSlot(unit->GetId(),unit->GetPos(circuit->GetLastFrame()),d->GetRangedPolicy().spacing,d->GetCostM());
    if(d->GetRangedPolicy().coordinated) JoinCohort(unit);
}
void CRangedWorld::InvalidateCohortPlans(CohortPlan& group)
{
    group.frame=group.formationFrame=-1;
    // Membership can change between callbacks in one frame. Invalidate both
    // ends so the paired plan is reusable for every shooter without repeating
    // partner discovery/validation until the next observation or mutation.
    auto partner=cohorts.find(group.formationPartner);
    if(partner!=cohorts.end()) partner->second.frame=partner->second.formationFrame=-1;
}

void CRangedWorld::ObserveHistory(int now)
{
    // Per-AI repair/stall tracking over the shared contacts, in contact order:
    // the writes the pre-D-462 enemy pass made, then its 60-second expiry.
    // O(E identified contacts) array writes; the expiry costs O(1) (INV-249).
    performance::Scope measured(circuit,performance::RANGED_HISTORY);
    const bool verify=CRangedObservation::verify;
    for (const auto& c:contacts) {
        if (!c.def) continue;
        auto& entry=history.Touch(c.id); auto& h=entry.value;
        if (c.los) {
            if (now-h.frame>=300) {
                // A repaired target remains legal, but repeated negligible net
                // progress makes another useful shot preferable. Unknown repair
                // income and hidden repairers are never inspected.
                h.stalled=(h.frame>0 && h.engaged>=h.frame && h.health-c.health< std::max(20.f,h.health*.03f)) ? std::min(4,h.stalled+1) : 0;
                h.health=c.health; h.frame=now;
            }
            entry.seen=now;
        }
        if (verify) {
            auto& l=legacyHistory[c.id];
            if (c.los) {
                if (now-l.frame>=300) {
                    l.stalled=(l.frame>0 && l.engaged>=l.frame && l.health-c.health< std::max(20.f,l.health*.03f)) ? std::min(4,l.stalled+1) : 0;
                    l.health=c.health; l.frame=now;
                }
                l.seen=now;
            }
        }
    }
    history.Prune(now);
    if (!verify) return;
    for (auto it=legacyHistory.begin();it!=legacyHistory.end();) {
        if (now-it->second.seen>HISTORY_FRAMES) it=legacyHistory.erase(it); else ++it;
    }
    bool equal=true;
    for (const auto& c:contacts) {
        const auto* e=history.Find(c.id); const auto l=legacyHistory.find(c.id);
        if ((e==nullptr)!=(l==legacyHistory.end())) { equal=false; break; }
        if (e && (e->seen!=l->second.seen || e->value.stalled!=l->second.stalled || e->value.frame!=l->second.frame
                  || e->value.engaged!=l->second.engaged || e->value.health!=l->second.health)) { equal=false; break; }
    }
    if (!equal) circuit->LOG("[INVARIANT] INV-249 ranged contact history differs from the erasing map (team %d frame %d)",circuit->GetTeamId(),now);
}

void CRangedWorld::EnsureAllies() const
{
    // D-462: friend cells load from the engine on first touch this frame, with
    // this AI's callbacks; the data is what a full read at Refresh would hold.
    observation->BindFriends(circuit);
}
void CRangedWorld::Leave(int id) {
    rushes.Leave(id);
    if(verifyRangedQueries && !rushes.Valid())
        circuit->LOG("[INVARIANT] INV-196 local rush membership or original-front casualty accounting is inconsistent");
    slots.erase(id); ReleaseShot(id); unitWhy.erase(id);
    auto member=membership.find(id);
    if(member!=membership.end()) {
        auto group=cohorts.find(member->second);
        if(group!=cohorts.end()) {
            std::erase(group->second.members,id);
            InvalidateCohortPlans(group->second);
            if(group->second.members.empty()) {
                auto partner=cohorts.find(group->second.formationPartner);
                if(partner!=cohorts.end() && partner->second.formationPartner==group->first) {
                    partner->second.formationPartner=-1;
                    partner->second.formationRear=false;
                }
                cohorts.erase(group);
            }
        }
        membership.erase(member);
    }
}
const group_layout::Slot* CRangedWorld::LayoutSlot(const CohortPlan& g,int id,const AIFloat3& origin,
                                                   const AIFloat3& back,float rowWidth,float spacing) const
{
    const int now=circuit->GetLastFrame();
    if(g.layoutFrame!=now) {
        // One layout per cohort per frame: every member of it reads the same
        // order, so nobody's slot depends on which member decided first.
        g.layoutFrame=now;
        layoutMembers.clear();
        for(int member:g.members) {
            auto* u=circuit->GetTeamUnit(member);
            if(!u || u->IsDead()) continue;
            const AIFloat3 p=u->GetPos(now);
            layoutMembers.push_back({member,{p.x,p.z}});
        }
        group_layout::Order({origin.x,origin.z},{back.x,back.z},
            group_layout::PerRow(rowWidth,spacing,int(layoutMembers.size())),layoutMembers,g.layout);
    }
    for(const auto& slot:g.layout) if(slot.id==id) return &slot;
    return nullptr;
}

void CRangedWorld::MergeCohorts(int from,int into)
{
    if(from==into) return;
    auto source=cohorts.find(from), target=cohorts.find(into);
    if(source==cohorts.end() || target==cohorts.end()) return;
    for(int member:source->second.members) { target->second.members.push_back(member); membership[member]=into; }
    // The target keeps its own partner; without one it takes the source's, so a
    // screen merging into a lone screen keeps its rockets. Otherwise the
    // source's partner is free again and pairs anew (GroundFormations.cpp).
    auto partner=cohorts.find(source->second.formationPartner);
    if(partner!=cohorts.end() && partner->second.formationPartner==from) {
        if(target->second.formationPartner<0) {
            target->second.formationPartner=source->second.formationPartner;
            target->second.formationRear=source->second.formationRear;
            partner->second.formationPartner=into;
        } else {
            partner->second.formationPartner=-1; partner->second.formationRear=false;
        }
    }
    for(auto& [key,plan]:cohorts) if(plan.recruitTarget==from) plan.recruitTarget=into;
    InvalidateCohortPlans(target->second);
    target->second.recruitTarget=-1; target->second.recruitUrgent=false;
    circuit->LOG("COHORT: merged group=%d members=%u by=registry",into,unsigned(target->second.members.size()));
    cohorts.erase(source);
}

int CRangedWorld::SplitCohort(int key,const std::vector<int>& leaving)
{
    auto source=cohorts.find(key);
    if(source==cohorts.end() || leaving.empty()) return -1;
    const int fresh=nextCohort++;
    auto& part=cohorts[fresh];
    auto& group=source->second;   // std::map inserts keep references valid
    for(int member:leaving) {
        if(std::find(group.members.begin(),group.members.end(),member)==group.members.end()) continue;
        std::erase(group.members,member);
        part.members.push_back(member); membership[member]=fresh;
    }
    if(part.members.empty()) { cohorts.erase(fresh); return -1; }
    InvalidateCohortPlans(group);
    part.frame=part.formationFrame=-1;
    if(group.members.empty()) {
        // Everyone left: the new part takes over the old one's partner.
        part.formationPartner=group.formationPartner; part.formationRear=group.formationRear;
        auto partner=cohorts.find(group.formationPartner);
        if(partner!=cohorts.end() && partner->second.formationPartner==key) partner->second.formationPartner=fresh;
        cohorts.erase(key);
    }
    circuit->LOG("COHORT: split group=%d part=%d members=%u",key,fresh,unsigned(part.members.size()));
    return fresh;
}

bool CRangedWorld::CompositionDue(int key,int frame,int period)
{
    auto group=cohorts.find(key);
    if(group==cohorts.end() || frame<group->second.nextComposition) return false;
    // Stagger by key so groups formed together are not all checked on one frame.
    group->second.nextComposition=frame+std::max(1,period)+key%std::max(1,period/2);
    return true;
}

void CRangedWorld::SetRecruitTarget(int key,int target,bool urgent)
{
    auto group=cohorts.find(key);
    if(group!=cohorts.end()) { group->second.recruitTarget=target; group->second.recruitUrgent=target>=0 && urgent; }
}

void CRangedWorld::SetSlot(int id,const AIFloat3& pos,float spacing,float value)
{
    auto old=slots.find(id);
    if(old!=slots.end()) formations.Remove(P(old->second.pos),id);
    slots[id]={pos,spacing,value};
    // Cache immutable type facts at the mutation boundary, not in every local
    // neighbor test. A reused unit ID receives fresh facts on Join/SetSlot.
    if(const auto* unit=circuit->GetTeamUnit(id)) {
        auto* def=unit->GetCircuitDef();
        slots[id].radius=def->GetRadius();
        slots[id].coordinated=def->GetRangedPolicy().coordinated;
        largestFriendRadius=std::max(largestFriendRadius,slots[id].radius);
    }
    largestSpacing=std::max(largestSpacing,spacing);
    formations.Add(P(pos),id);
}
bool CRangedWorld::FreeSlot(int id,const AIFloat3& pos,float spacing) const
{
    const auto own=slots.find(id);
    const float radius=own==slots.end()?0.f:own->second.radius;
    const float friendRadius=std::max(largestFriendRadius,observation->FriendRadius());
    return !formations.Any(P(pos),std::max({spacing,largestSpacing,radius+friendRadius}),[&](int other) {
        const auto it=slots.find(other); if(other==id || it==slots.end()) return false;
        // D-228: Thug screen reservations must not exclude the entire narrow
        // firing band of a Starlight behind them. Other artillery pairs retain
        // their old spacing; FriendlyLine still forbids shooting through hulls.
        const float separation=own==slots.end()?std::max(spacing,it->second.spacing)
            :cohort::PairSpacing(spacing,it->second.spacing,own->second.coordinated,
                                 it->second.coordinated,radius+it->second.radius);
        return pos.SqDistance2D(it->second.pos)<separation*separation;
    });
}
void CRangedWorld::Nearby(const AIFloat3& pos,float radius,std::vector<int>& result) const
{
    result.clear(); enemies.Query(P(pos),radius,[&](int i) {
        if(contacts[i].pos.SqDistance2D(pos)<=radius*radius) result.push_back(i);
    });
}
bool CRangedWorld::Safe(const AIFloat3& from,const AIFloat3& to,float margin,bool escaping,float press) const
{
    const AIFloat3 center=(from+to)*.5f;
    // Only static hazards can reject this predicate. Preserve the old bounds
    // for unusual negative margins; for ordinary nonnegative margins the
    // static maximum remains a conservative bound for the same exact test.
    const float query=(margin>=0.f && finiteStaticHazards?largestStaticRange:largestRange)+margin+std::sqrt(from.SqDistance2D(to))*.5f;
    const bool safe=!staticHazards.Any(P(center),query,[&](int i) {
        const auto& c=contacts[i];
        const float hazard=HazardFor(c,press);
        if(!(hazard>0.f)) return false;
        const float radius=hazard+margin;
        if(escaping) return !ranged::SafeSegment(P(from),P(to),P(c.pos),radius);
        return !(ranged::SegmentDistanceSq(P(c.pos),P(from),P(to))>=radius*radius);
    });
    if(verifyRangedQueries) {
        // Same live observation, old full-contact bounds/predicate. No commands
        // or RNG calls. Run separately from timing: this deliberately repeats
        // the old expensive query and checks static-bound reduction in-engine.
        bool legacy=true;
        enemies.Query(P(center),largestRange+margin+std::sqrt(from.SqDistance2D(to))*.5f,[&](int i) {
            const auto& c=contacts[i]; if(!legacy || HazardFor(c,press)<=0.f || c.mobile) return;
            const float radius=HazardFor(c,press)+margin;
            legacy=escaping ? ranged::SafeSegment(P(from),P(to),P(c.pos),radius)
                : ranged::SegmentDistanceSq(P(c.pos),P(from),P(to))>=radius*radius;
        });
        if(legacy!=safe) circuit->LOG("[INVARIANT] INV-161 ranged safety query differs from legacy predicate");
    }
    return safe;
}
float CRangedWorld::Danger(const AIFloat3& pos,float margin,float press) const
{
    float danger=0.f;
    enemies.Query(P(pos),largestRange+margin,[&](int i) {
        const auto& c=contacts[i]; const float hazard=HazardFor(c,press); if(hazard<=0.f) return;
        if(pos.SqDistance2D(c.pos)<std::pow(hazard+margin,2.f)) danger+=c.cost;
    });
    return danger;
}
int CRangedWorld::DangerSign(const AIFloat3& pos,float margin,float press) const
{
    // Callers ask ==0 or >0, not a magnitude. Nonnegative finite contributions
    // permit existence short-circuiting without changing either comparison.
    // Keep ordered accumulation for exceptional/negative values; -1 also
    // represents NaN, for which both original comparisons are false.
    int result;
    if(!nonnegativeHazardCosts) {
        const float value=Danger(pos,margin,press);
        result=value>0.f?1:value==0.f?0:-1;
    } else result=enemies.Any(P(pos),largestRange+margin,[&](int i) {
        const auto& c=contacts[i]; const float hazard=HazardFor(c,press);
        return hazard>0.f && c.cost>0.f
            && pos.SqDistance2D(c.pos)<std::pow(hazard+margin,2.f);
    }) ? 1 : 0;
    if(verifyRangedQueries) {
        const float value=Danger(pos,margin,press);
        const int expected=value>0.f?1:value==0.f?0:-1;
        if(result!=expected) circuit->LOG("[INVARIANT] INV-161 ranged danger sign differs from ordered sum");
    }
    return result;
}
bool CRangedWorld::FriendlySplash(int id,const AIFloat3& target,float radius) const
{
    if(radius<=16.f) return false;
    EnsureAllies();
    return allies.Any(P(target),radius+observation->FriendRadius(),[&](int i) {
        const auto& f=friends[i];
        return f.id!=id && target.SqDistance2D(f.pos)<std::pow(radius+f.radius,2.f);
    });
}
bool CRangedWorld::FriendlySplash(int id,const AIFloat3& target,float radius,const Weapon& weapon,float factor)
{
    if(factor<=0.f) return FriendlySplash(id,target,radius);
    if(radius<=16.f) return false;
    EnsureAllies();
    return allies.Any(P(target),radius+largestFriendRadius,[&](int i) {
        Friend& f=friends[i];
        if(f.id==id || target.SqDistance2D(f.pos)>=std::pow(radius+f.radius,2.f)) return false;
        if(!f.def || f.def->IsRoleComm()) return true;
        const int armor=MetadataFor(f.def).armor;
        const float hit=armor>=0 && size_t(armor)<weapon.damage.size()?weapon.damage[armor]*weapon.alphaScale:0.f;
        if(hit<=0.f) return false;
        if(f.combatHealth<0.f) f.combatHealth=circuit->GetUnitAPI()->GetCombatHealth(f.id);
        return f.combatHealth<factor*hit;
    });
}
void CRangedWorld::Statics(const AIFloat3& from,float radius,std::vector<StaticPost>& out) const
{
    out.clear();
    EnsureAllies();
    allies.Query(P(from),radius,[&](int i) {
        const Friend& f=friends[i];
        if(!f.def || f.def->IsMobile() || !f.screen || f.range<=0.f) return;
        if(from.SqDistance2D(f.pos)<=radius*radius) out.push_back({f.pos,f.range});
    });
}
bool CRangedWorld::HasScreen(int id,const AIFloat3& from,const AIFloat3& target) const
{
    EnsureAllies();
    const float distance=from.SqDistance2D(target);
    return allies.Any(P(from),700.f,[&](int i) {
        const auto& f=friends[i];
        return f.id!=id && f.screen && f.pos.SqDistance2D(target)<distance && f.pos.SqDistance2D(from)<490000.f;
    });
}
bool CRangedWorld::Engaged(int contact,float margin,int* ally) const
{
    if(ally) *ally=-1;
    if(contact<0 || size_t(contact)>=contacts.size()) return false;
    const auto& c=contacts[contact];
    // Only identified, currently visible ground contacts can be an allied
    // engagement; a radar dot or aircraft never pulls a precision gun forward.
    if(!c.def || !c.los || c.def->IsAbleToFly() || c.pos.y< -20.f) return false;
    if(engagedFrame!=frame || engagedMargin!=margin || engagedGeneration!=observation->ContactGeneration()) {
        engagedMemo.assign(contacts.size(),-1); // reuses capacity
        engagedFrame=frame; engagedMargin=margin; engagedGeneration=observation->ContactGeneration();
    }
    int& memo=engagedMemo[contact];
    if(memo<0) {
        // One bounded local query per contact per frame: O(allies near c).
        // Other assisters are excluded so assisting guns never bootstrap
        // each other forward. Allied teams' units are included because the
        // snapshot is GetFriendlyUnitIds (engine: same allyteam, not neutral).
        // The broad phase is sized by the largest screen range of ALL allies,
        // so this query needs the complete friend picture: one full read per
        // side per frame, shared by every assister of the ally team.
        EnsureAllies();
        observation->LoadAllFriends();
        int found=-1;
        allies.Any(P(c.pos),observation->ScreenRange()+margin+c.radius,[&](int k) {
            const auto& f=friends[k];
            if(!f.screen || f.assist || f.range<=0.f) return false;
            const float reach=f.range+margin+c.radius;
            if(f.pos.SqDistance2D(c.pos)>reach*reach) return false;
            found=k; return true;
        });
        memo=found+1;
    }
    if(memo>0 && ally) *ally=friends[memo-1].id;
    return memo>0;
}
bool CRangedWorld::FriendlyLine(const Weapon& w,int id,const AIFloat3& from,const AIFloat3& target) const
{
    // Ballistic/high-arc trajectories may legitimately clear a screen. For
    // direct and guided projectiles, reserve a conservative firing corridor;
    // engine avoidance alone did not prevent Medusa rockets hitting a radar.
    // Query local cells along this segment, not all allies for every target.
    if(w.fake || w.ballistic) return false;
    const AIFloat3 delta=target-from;
    const float length=delta.SqLength2D();
    if(length<1.f) return false;
    EnsureAllies();
    // Guided rockets curve in height and may descend after losing a target.
    // A straight-line height exemption let Medusa hit a radar on a hillside
    // after its target died. Require a clear 2-D corridor for guided weapons,
    // including their splash padding. Direct beams retain the height test.
    // The Medusa fixture requires zero allied damage as well as target kills.
    const float padding=w.guided ? std::max(8.f,w.splash) : 8.f;
    return allies.Any(P((from+target)*.5f),std::sqrt(length)*.5f+observation->FriendRadius()+padding,[&](int i) {
        const auto& f=friends[i];
        if(f.id==id) return false;
        const float t=((f.pos.x-from.x)*delta.x+(f.pos.z-from.z)*delta.z)/length;
        if(t<=0.f || t>=1.f) return false;
        const auto p=from+delta*t;
        const float radius=f.radius+padding;
        return f.pos.SqDistance2D(p)<radius*radius
            && (w.guided || std::fabs(f.pos.y-(p.y+24.f))<radius+24.f);
    });
}
float CRangedWorld::Range(const Weapon& w,const AIFloat3& from,const AIFloat3& to) const
{
    const float h=(to.y-from.y)*w.heightMod;
    if(w.cylinder>0.f) return std::fabs(h)<w.cylinder*w.range ? w.range : 0.f;
    // Conservative uphill correction; do not assume bonus downhill reach.
    // The engine remains authoritative for actual firing reach and aim.
    return w.ballistic ? std::max(0.f,w.range-std::max(0.f,h)) : std::sqrt(std::max(0.f,w.range*w.range-h*h));
}
bool CRangedWorld::Trajectory(const Weapon& w,const AIFloat3& from,const AIFloat3& to) const
{
    if(w.fake || w.high) return true; // starburst/carrier requires actual firing fixture
    const float distance=std::sqrt(from.SqDistance2D(to));
    const int steps=std::max(1,int(distance/32.f));
    float tangent=0.f;
    if(w.ballistic && w.speed>0.f && w.gravity>0.f) {
        const float v2=w.speed*w.speed;
        const float disc=v2*v2-w.gravity*(w.gravity*distance*distance+2.f*(to.y-from.y)*v2);
        if(disc<0.f) return false;
        tangent=(v2-std::sqrt(disc))/std::max(1.f,w.gravity*distance);
    }
    const auto* area=circuit->GetTerrainManager()->GetAreaData();
    for(int i=1;i<steps;++i) {
        const float t=float(i)/steps, x=distance*t;
        const float y=w.ballistic && w.speed>0.f ? from.y+24.f+x*tangent-w.gravity*x*x*(1.f+tangent*tangent)/(2.f*w.speed*w.speed)
            : from.y+24.f+(to.y-from.y)*t;
        if(area->GetElevationAt(from.x+(to.x-from.x)*t,from.z+(to.z-from.z)*t)>y) return false;
    }
    return true;
}
void CRangedWorld::ReleaseShot(int owner)
{
    auto it=shots.find(owner); if(it==shots.end()) return;
    auto sum=reserved.find(it->second.target);
    if(sum!=reserved.end()) {
        sum->second-=it->second.damage;
        if(sum->second<.01f) reserved.erase(sum);
    }
    shots.erase(it);
}
void CRangedWorld::ReserveShot(int owner,int target,float damage,int until)
{
    ReleaseShot(owner); shots[owner]={target,until,damage}; reserved[target]+=damage;
    history.Touch(target).value.engaged=circuit->GetLastFrame();
    if(CRangedObservation::verify) legacyHistory[target].engaged=circuit->GetLastFrame();
}
float CRangedWorld::Reserved(int target,int owner) const
{
    const auto r=reserved.find(target); const auto s=shots.find(owner);
    return std::max(0.f,(r==reserved.end()?0.f:r->second)-(s!=shots.end() && s->second.target==target?s->second.damage:0.f));
}
float CRangedWorld::Progress(int target,float penalty) const
{
    const auto* entry=history.Find(target);
    const float progress=entry==nullptr?1.f:std::max(.05f,std::pow(penalty,float(entry->value.stalled)));
    if(CRangedObservation::verify) {
        const auto it=legacyHistory.find(target);
        const float legacy=it==legacyHistory.end()?1.f:std::max(.05f,std::pow(penalty,float(it->second.stalled)));
        if(legacy!=progress) circuit->LOG("[INVARIANT] INV-249 ranged progress differs from the erasing map (target %d)",target);
    }
    return progress;
}
float CRangedWorld::ClusterValue(const AIFloat3& target,float radius) const
{
    // A coarse density score, not predicted damage. Aggregate once per shared
    // snapshot so a dense battle does not become an enemy-pair scan for every
    // splash shooter. Cost depends on weapon footprint, not total army size.
    if(radius<32.f) return 0.f;
    float value=0.f;
    const int cells=int(std::ceil(std::min(512.f,radius)/128.f));
    const int x=int(target.x/128.f),z=int(target.z/128.f);
    for(int dz=-cells;dz<=cells;++dz) for(int dx=-cells;dx<=cells;++dx) {
        if(dx*dx+dz*dz>cells*cells) continue;
        const auto* cell=clusterValues.Find(x+dx,z+dz);
        if(cell) value+=*cell;
    }
    return value;
}
bool CRangedWorld::Escort(CCircuitUnit* sensor,AIFloat3& position)
{
    performance::Scope measured(circuit,performance::RANGED_ESCORT);
    Refresh();
    auto* d=sensor->GetCircuitDef(); const auto& meta=MetadataFor(d);
    const float radar=meta.radar, jammer=meta.jammer;
    static const bool trace=std::getenv("CIRCUIT_RANGED_TRACE")!=nullptr;
    const bool report=trace && frame%150==3;
    if(report) circuit->LOG("RANGED: escort sensor=%d radar=%.0f jammer=%.0f land=%d anchors=%u",sensor->GetId(),radar,jammer,int(d->IsLander()),unsigned(slots.size()));
    if((radar<=0.f && jammer<=0.f) || d->IsAbleToFly() || !d->IsLander()) return false;
    EnsureAllies();
    const bool isJammer=jammer>0.f;
    const auto pos=sensor->GetPos(frame);
    float best=-1.f; int anchor=-1;
    for(const auto& [id,slot]:slots) {
        if(!circuit->GetTerrainManager()->CanMoveToPos(sensor->GetArea(),slot.pos)) continue;
        AIFloat3 coveragePoint=slot.pos;
        if(!isJammer) {
            float nearest=2000.f*2000.f;
            enemies.Query(P(slot.pos),2000.f,[&](int i) {
                const float distance=slot.pos.SqDistance2D(contacts[i].pos);
                if(distance<nearest) { nearest=distance; coveragePoint=contacts[i].pos; }
            });
        }
        bool covered=false;
        allies.Query(P(coveragePoint),std::max(radar,jammer),[&](int i) {
            const auto& f=friends[i]; if(f.id==sensor->GetId()) return;
            // Radar over the firing line does not replace vision of targets.
            // A radar escort's scarce useful resource here is its allied LOS.
            const float reach=isJammer?f.jammer:f.los;
            if(reach>0.f && f.pos.SqDistance2D(coveragePoint)<reach*reach*.81f) covered=true;
        });
        for(const auto& [other,lease]:escorts) {
            if(other==sensor->GetId() || lease.jammer!=isJammer) continue;
            const auto a=slots.find(lease.anchor);
            if(a!=slots.end() && a->second.pos.SqDistance2D(slot.pos)<262144.f) covered=true;
        }
        if(covered) continue;
        auto* gun=circuit->GetTeamUnit(id);
        if(!gun) continue;
        AIFloat3 direction=isJammer ? circuit->GetSetupManager()->GetBasePos()-slot.pos : coveragePoint-slot.pos;
        if(direction.SqLength2D()<1.f) direction=circuit->GetSetupManager()->GetBasePos()-slot.pos;
        direction.Normalize2D();
        const float offset=gun->GetCircuitDef()->GetRangedPolicy().sensorOffset;
        AIFloat3 candidate=slot.pos+direction*offset;
        bool safe=false;
        // A short-range anchor may put the nominal forward sensor offset
        // inside static coverage. Try the firing line itself, then another
        // anchor; never reserve an unreachable/unsafe escort slot.
        for(int attempt=0;attempt<2;++attempt) {
            CTerrainManager::CorrectPosition(candidate);
            candidate.y=circuit->GetTerrainManager()->GetAreaData()->GetElevationAt(candidate.x,candidate.z);
            safe=circuit->GetTerrainManager()->CanMoveToPos(sensor->GetArea(),candidate)
                && Safe(pos,candidate,32.f,true) && DangerSign(candidate,32.f)==0;
            if(safe) break;
            candidate=slot.pos;
        }
        if(!safe) continue;
        const auto previous=escorts.find(sensor->GetId());
        const float value=slot.value/(256.f+std::sqrt(pos.SqDistance2D(slot.pos))) *
            (previous!=escorts.end() && previous->second.anchor==id?1.5f:1.f);
        if(value>best) { best=value; anchor=id; position=candidate; }
    }
    if(anchor<0) { if(report) circuit->LOG("RANGED: escort covered sensor=%d",sensor->GetId()); escorts.erase(sensor->GetId()); return false; }
    escorts[sensor->GetId()]={anchor,isJammer};
    if(report) circuit->LOG("RANGED: escort choice sensor=%d anchor=%d pos=%.0f,%.0f",sensor->GetId(),anchor,position.x,position.z);
    return true;
}
}
