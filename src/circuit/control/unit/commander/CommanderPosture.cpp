// D-389: the commander's cloak posture, the shared threat picture it reads,
// cloak energy accounting and the single-writer cloak sync.
// Policy: rjm.bar.docs/projects/circuitai/commander-cloak-policy.md section 4;
// kernel and worked examples: control/kernel/CommanderPosture.h and
// tests/commander_posture_test.cpp.
//
// Cost per commander: UpdatePosture runs once per posture_period (default one
// second) or on damage; it reads the side's combat snapshot in O(cells + K)
// for K enemies within the uncertainty-expanded radius, plus O(log M) cached
// matchup lookups for M definition pairs (no per-query allocation on hits).
// AccountCloak runs on the three-frame tick: two engine reads.
#include "control/unit/commander/CommanderController.h"
#include "control/core/ControlledTask.h"
#include "control/service/CombatSnapshot.h"
#include "module/EconomyManager.h"
#include "module/MilitaryManager.h"
#include "task/fighter/RangedWorld.h"
#include "task/UnitTask.h"
#include "unit/ally/AllyTeam.h"
#include "unit/CircuitUnit.h"
#include "unit/CircuitDef.h"
#include "unit/CircuitWDef.h"
#include "spring/SpringUnit.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "Log.h"

#include <cmath>

namespace circuit {

using springai::AIFloat3;
using commander::Point;
namespace posture=commander::posture;

namespace {
Point P(const AIFloat3& p) { return {p.x,p.z}; }
constexpr float FRAMES=30.f;                 // simulation frames per second
constexpr int FRAMES_PER_MINUTE=1800;
constexpr float WINDOW_SECONDS=60.f;         // the cloak budget's decaying one-minute window
constexpr float MOVING_SPEED=8.f;            // elmos/second above which the commander travels
constexpr float SCREEN_RADIUS=450.f;         // friendly combat screen around the commander (Tick's support radius)
constexpr float MIN_RELOAD=.1f;              // seconds; guards a zero reload in weapon data
constexpr int CLOAK_SETTLE_FRAMES=30;       // a cloak order reaches BAR's request flag within a second
constexpr float BUDGET_RESUME=.5f;           // posture cloaks resume below this share of the budget
}

const CCommanderController::Matchup& CCommanderController::MatchupFor(CCircuitDef* enemy,CCircuitDef* self) {
    const int armor=self->GetDef()->GetArmorType();
    const auto key=std::make_pair(enemy->GetId(),self->GetId());
    const auto found=matchups.find(key);
    if(found!=matchups.end()) return found->second;
    Matchup m;
    const auto& cap=ai->GetMilitaryManager()->GetRangedWorld()->CapabilitiesFor(enemy);
    for(const auto& w:cap.weapons) {
        // Same admission as Observe's canHit: a weapon that may target this
        // commander's category and deals damage to its armour class.
        if((w.category & self->GetCategory())==0 || w.damage.empty()) continue;
        const float hits=w.continuous?commander::CollisionHits(self->GetRadius(),w.speed*FRAMES):1.f;
        const float damage=w.damage[std::min(std::size_t(std::max(0,armor)),w.damage.size()-1)]*w.alphaScale*hits;
        if(damage<=0) continue;
        m.dps+=damage/std::max(MIN_RELOAD,w.reload);
        if(w.range>m.range) m.range=w.range;
        if((w.ballistic || w.high) && !w.guided) m.artilleryRange=std::max(m.artilleryRange,w.range);
    }
    m.speed=enemy->GetSpeed();
    m.health=enemy->GetHealth();
    return matchups.emplace(key,m).first->second;
}

posture::Concealment CCommanderController::ConcealmentOf(CCircuitUnit* unit,const State& s) {
    const int frame=ai->GetLastFrame();
    const Point pos=P(unit->GetPos(frame));
    // Off enemy radar and seismic (or inside a friendly jammer), nothing
    // within decloak distance: the cloak hides the commander completely.
    if(CloakSafe(unit,pos,pos,cfg->combat.escapeSeconds)) return posture::Concealment::FULL;
    const float decloak=DefinitionFor(unit->GetCircuitDef()).decloak+cfg->combat.detectionMargin;
    float support=0.f;
    for(const auto& c:contacts) {
        const float distance=commander::Length(c.pos-pos);
        if(!c.friendly && distance<=decloak+c.radius) return posture::Concealment::NONE;
        if(c.friendly && distance<SCREEN_RADIUS) support+=c.cost;
    }
    // On enemy radar: Recoil's automatic targeting ranks a radar-only contact
    // 10x lower than a visible one, so a friendly screen still draws the fire.
    return support>=cfg->combat.support?posture::Concealment::PARTIAL:posture::Concealment::NONE;
}

void CCommanderController::UpdatePosture(CCircuitUnit* unit,State& s,int frame,bool force) {
    auto* def=unit->GetCircuitDef();
    if(cfg->cloak.posture<=0 || !def->IsAbleToCloak()) {
        s.conceal.posture=int(posture::Posture::WORK); s.conceal.postureCloak=false;
        s.conceal.threatNear=false; s.conceal.postureReason="posture off"; return;
    }
    if(!force && frame<s.conceal.postureNext) return;
    s.conceal.postureNext=frame+int(cfg->cloak.period);
    const auto pos=unit->GetPos(frame);
    const auto& cap=ai->GetMilitaryManager()->GetRangedWorld()->CapabilitiesFor(def);
    const float bank=ai->GetEconomyManager()->GetEnergyCur();
    const float shot=std::max(1.f,def->GetDGunDef()->GetCostE());

    // The commander itself: main weapons only (the D-gun is counted as shots).
    posture::Self self;
    self.pos=P(pos);
    self.health=unit->GetUnit()->GetHealth();
    self.laserRange=0.f; self.laserDps=0.f;
    const int defaultArmor=0;
    for(const auto& w:cap.weapons) {
        if(w.def==def->GetDGunDef() || w.damage.empty()) continue;
        self.laserRange=std::max(self.laserRange,w.range);
        self.laserDps+=w.damage[defaultArmor]*w.alphaScale/std::max(MIN_RELOAD,w.reload);
    }
    self.shotsBanked=std::clamp(int((bank-std::max(0.f,reserve))/shot),0,int(cfg->combat.shots));

    // The threat picture: seen, on radar and remembered enemies of the side.
    const auto& snapshot=ai->GetAllyTeam()->GetCombatSnapshot();
    const float snapshotAge=snapshot.Frame()>=0?float(frame-snapshot.Frame())/FRAMES:0.f;
    postureThreats.clear();
    snapshot.Query(self.pos,snapshot.QueryRadius(cfg->cloak.threatRadius,cfg->cloak.memoryCap,snapshotAge),[&](const CCombatSnapshot::Entry& e) {
        const bool remembered=!e.los && !e.radar;
        const float age=float(frame-e.lastObserved)/FRAMES;
        if(remembered && age>cfg->cloak.memorySeconds) {
            // Silence inside a known enemy jammer is not evidence of absence.
            bool jammed=false;
            for(const auto& j:snapshot.EnemyJammers())
                if(commander::Length(e.pos-j.center)<=j.radius) { jammed=true; break; }
            if(!jammed) return;
        }
        posture::ThreatEntry t;
        t.pos=e.pos;
        if(e.defId>=0) {
            CCircuitDef* enemy=ai->GetCircuitDefSafe(e.defId);
            if(enemy==nullptr) return;
            const auto& m=MatchupFor(enemy,def);
            if(m.dps<=0.f) return;
            t.dps=m.dps; t.range=m.range; t.speed=m.speed; t.health=m.health;
            t.artillery=m.IsArtillery(cfg->cloak.artilleryRange);
            t.heavy=DefinitionFor(enemy).t3;
        } else {
            t.dps=cfg->cloak.blipDps; t.range=cfg->cloak.blipRange; t.speed=CCombatSnapshot::BLIP_SPEED;
        }
        const float moved=remembered?std::min(t.speed*age,cfg->cloak.memoryCap):t.speed*snapshotAge;
        t.uncertainty=moved+(e.los?0.f:CCombatSnapshot::RADAR_ERROR);
        if(commander::Length(t.pos-self.pos)>cfg->cloak.threatRadius+t.uncertainty) return;
        postureThreats.push_back(t);
    });

    posture::Settings settings;
    settings.horizon=cfg->cloak.horizon; settings.outrangeMargin=cfg->cloak.outrangeMargin;
    settings.outrangeDps=cfg->cloak.outrangeDps; settings.artilleryDps=cfg->cloak.artilleryDps;
    settings.retreatSeconds=cfg->cloak.retreatSeconds; settings.escapeSeconds=cfg->cloak.escapeSeconds;
    settings.brawlMargin=cfg->cloak.brawlMargin; settings.dgunKills=cfg->cloak.dgunKills;
    settings.ambushSeconds=cfg->cloak.ambushSeconds; settings.withdrawCloakSeconds=cfg->cloak.withdrawCloakSeconds;
    const auto summary=posture::Summarize(postureThreats,self,settings);

    posture::Inputs in;
    in.concealment=summary.incomingDps>0.f?ConcealmentOf(unit,s):posture::Concealment::NONE;
    in.movingFunded=bank>=cap.cloakMoving*cfg->combat.escapeSeconds+cfg->combat.margin;
    in.stillFunded=bank>=cap.cloakCost*cfg->cloak.stillSeconds+cfg->combat.margin;
    const float income=ai->GetEconomyManager()->GetAvgEnergyIncome();
    // One scalar at the existing posture cadence. Keep the unlock across income
    // dips and commander replacement, but only during this FRONT duty lifetime.
    if(role.frontDuty) role.peakEnergyIncome=std::max(role.peakEnergyIncome,income);
    in.preferCloak=posture::IncomeCloakEnabled(role.frontDuty,cfg->cloak.frontIncome,role.peakEnergyIncome);
    // Hysteresis: once the one-minute cloak spend passes the budget, posture
    // cloaks stay off until it falls to half of it (no on/off every second).
    const float budgetCap=cfg->cloak.budget*income*WINDOW_SECONDS;
    if(cfg->cloak.budget<=0.f) s.conceal.budgetHold=false;
    else if(s.conceal.window>budgetCap) s.conceal.budgetHold=true;
    else if(s.conceal.window<budgetCap*BUDGET_RESUME) s.conceal.budgetHold=false;
    in.budgetOk=!s.conceal.budgetHold;
    float raw[3]={0,0,0};
    ai->GetUnitAPI()->GetVelocity(unit->GetId(),raw);
    in.moving=std::sqrt(raw[0]*raw[0]+raw[2]*raw[2])*FRAMES>MOVING_SPEED;
    const auto choice=posture::Choose(summary,self,settings,in);

    const bool cloak=choice.cloak && !s.retreat.energy;
    // Count cloak decision changes only: a posture change that keeps the cloak
    // as it was issues no order. Toggles are what cost orders and energy.
    if(cloak!=s.conceal.postureCloak) ++s.conceal.postureChanges;
    if(int(choice.posture)!=s.conceal.posture || cloak!=s.conceal.postureCloak) {
        ai->LOG("[CommanderPosture] unit=%i posture=%s cloak=%i reason=%s dps=%.0f ttd=%.1f outranged=%.0f artillery=%.0f clear=%.1f threats=%i concealment=%i",
            unit->GetId(),posture::Name(choice.posture),cloak?1:0,choice.reason,summary.incomingDps,
            std::isinf(summary.timeToDie)?-1.f:summary.timeToDie,summary.outrangedDps,summary.artilleryDps,
            summary.clearSeconds,int(postureThreats.size()),int(in.concealment));
    }
    s.conceal.posture=int(choice.posture);
    s.conceal.postureCloak=cloak;
    s.conceal.threatNear=summary.incomingDps>0.f;
    s.conceal.postureReason=choice.reason;
}

void CCommanderController::AccountCloak(CCircuitUnit* unit,State& s,int frame) {
    if(s.conceal.accountFrame<0) { s.conceal.accountFrame=frame; s.conceal.minute=frame/FRAMES_PER_MINUTE; return; }
    const float dt=float(frame-s.conceal.accountFrame)/FRAMES;
    s.conceal.accountFrame=frame;
    if(dt<=0.f) return;
    s.conceal.window*=std::exp(-dt/WINDOW_SECONDS);
    if(unit->GetUnit()->IsCloaked()) {
        const auto& cap=ai->GetMilitaryManager()->GetRangedWorld()->CapabilitiesFor(unit->GetCircuitDef());
        float raw[3]={0,0,0};
        ai->GetUnitAPI()->GetVelocity(unit->GetId(),raw);
        const bool moving=std::sqrt(raw[0]*raw[0]+raw[2]*raw[2])*FRAMES>MOVING_SPEED;
        const float cost=(moving?cap.cloakMoving:cap.cloakCost)*dt;
        (moving?s.conceal.movingSeconds:s.conceal.stillSeconds)+=dt;
        s.conceal.energy+=cost;
        s.conceal.window+=cost;
    }
    const int minute=frame/FRAMES_PER_MINUTE;
    if(minute==s.conceal.minute) return;
    if(cfg->cloak.log>0) ai->LOG("[CommanderCloak] unit=%i minute=%i still=%.0f moving=%.0f energy=%.0f posture=%s toggles=%i",
        unit->GetId(),s.conceal.minute,s.conceal.stillSeconds,s.conceal.movingSeconds,s.conceal.energy,
        posture::Name(posture::Posture(s.conceal.posture)),s.conceal.postureChanges);
    s.conceal.minute=minute; s.conceal.stillSeconds=0; s.conceal.movingSeconds=0;
    s.conceal.energy=0; s.conceal.postureChanges=0;
}

bool CCommanderController::SupportCloak(CCircuitUnit* /*unit*/,const State& s) const {
    return s.conceal.postureCloak && !s.retreat.energy && s.pending<0 && s.t3.target<0
        && s.retreat.healthShotUntil<0;
}

void CCommanderController::SyncSupportCloak(CCircuitUnit* unit,State& s,int frame,bool verify) {
    const IUnitTask* current=unit->GetTask();
    // An engagement owns the cloak through Conceal; a retreat through RetreatConceal.
    if(current==nullptr || dynamic_cast<const CControlledTask*>(current)!=nullptr
        || current->GetType()==IUnitTask::Type::RETREAT) return;
    const bool want=SupportCloak(unit,s);
    if(verify) {
        // INV-246: in support, only this controller turns the cloak on. Once a
        // second, compare BAR's request flag with this controller's last request.
        const bool wanted=unit->GetUnit()->GetRulesParamFloat("wantcloak",0.f)>0.f;
        // Compare with what this writer last *sent* (the engagement code's
        // request cache can be reset from the actual cloak state), after the
        // gadget has had time to apply that order (it lands next frame).
        const auto* last=writer.LastSent(unit->GetId());
        const bool ours=last!=nullptr && last->cloak;
        const bool settled=last==nullptr || frame-last->frame>CLOAK_SETTLE_FRAMES;
        if(s.conceal.known && wanted && !ours && settled && frame>=s.conceal.invariantNext) {
            s.conceal.invariantNext=frame+FRAMES_PER_MINUTE;
            ai->LOG("[INVARIANT] INV-246 commander cloak requested by another writer unit=%i task=%i",
                unit->GetId(),int(current->GetType()));
        }
        if(wanted!=want) writer.CloakFrom(unit,want,wanted,s.conceal.postureReason);
        s.conceal.known=true;
    } else {
        writer.CloakFrom(unit,want,s.conceal.requested,s.conceal.postureReason);
    }
    s.conceal.requested=want;
}

void CCommanderController::RetreatConceal(CCircuitUnit* unit,State& s,int frame,bool threatened) {
    // D-389: a retreat cloaks only when it hides the commander (no enemy
    // radar or seismic, nothing within decloak distance) from a real threat
    // and the bank pays the moving cloak; fire is held only while hidden.
    // Formerly CRetreatTask cloaked every retreat (KI-689 defects 1 and 4).
    const auto pos=P(unit->GetPos(frame));
    // An approaching threat counts: a low-health commander must already be
    // hidden when it arrives (commander-health-cloaked-t3), not start cloaking
    // once it is in range. A retreat with nothing near still does not cloak.
    const bool hide=(threatened || s.conceal.threatNear || s.conceal.postureCloak) && !s.retreat.energy && RetreatCloakFunded(unit)
        && CloakSafe(unit,pos,pos,cfg->combat.escapeSeconds);
    writer.FireState(unit,hide?CCircuitDef::FireType::HOLD:CCircuitDef::FireType::RETURN,"retreat");
    writer.CloakFrom(unit,hide,s.conceal.requested,hide?"retreat hidden":"retreat seen");
    s.conceal.requested=hide;
}

void CCommanderController::RestoreAfterLease(CCircuitUnit* unit,int fireState,int moveState) {
    State* s=states.Find(unit->GetId());
    TRY_UNIT(ai,unit,
        writer.FireState(unit,fireState,"lease_end");
        writer.MoveState(unit,moveState,"lease_end");
    )
    if(!s) return;
    Bind bound(this,s->preset);
    const bool want=SupportCloak(unit,*s);
    writer.Cloak(unit,want,"lease_end");
    s->conceal.requested=want;
}

} // namespace circuit
