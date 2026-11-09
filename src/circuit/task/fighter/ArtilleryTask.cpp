/*
 * ArtilleryTask.cpp
 *
 *  Created on: Jan 6, 2016
 *      Author: rlcevg
 */

#include "task/fighter/ArtilleryTask.h"
#include "task/fighter/RouteTask.h"
#include "task/RetreatTask.h"
#include "map/ThreatMap.h"
#include "module/MilitaryManager.h"
#include "setup/SetupManager.h"
#include "terrain/TerrainManager.h"
#include "terrain/path/PathFinder.h"
#include "terrain/path/QueryPathMulti.h"
#include "unit/action/FightAction.h"
#include "unit/action/MoveAction.h"
#include "unit/enemy/EnemyUnit.h"
#include "unit/enemy/EnemyManager.h"
#include "map/MapManager.h"
#include "unit/CircuitUnit.h"
#include "CircuitAI.h"
#include "util/Utils.h"

#include "spring/SpringMap.h"
#include "spring/SpringCallback.h"

#include "AISCommands.h"
#include "Log.h"
#include "Weapon.h"
#include "Feature.h"
#include "FeatureDef.h"

#include "task/fighter/MissileTargetPolicy.h"
#include <cstring>
#include <string>

namespace circuit {

using namespace springai;

/*
 * 2026-11-06: Ambassador, Negotiator, Boreas and Arbiter do not shoot an
 * IDENTIFIED (def known) MOBILE enemy of tech level 1 (customParams.techlevel,
 * 1 when absent) that is idle or slow (SlowMissileSpeedAllowed: stationary, or
 * below min(top speed x 0.25, 12) elmos/s). Unidentified radar dots stay
 * targets. Commanders (no techlevel in BAR, so 1) are not exempt: the
 * commander priority stands.
 */
bool ArtyT1Exempt(const CCircuitDef* launcher, const CEnemyInfo* enemy)
{
    if ((launcher == nullptr) || (enemy == nullptr) || !IsT1ExemptLauncher(launcher->GetDef()->GetName())) return false;
    const CCircuitDef* d = enemy->GetCircuitDef();
    if ((d == nullptr) || !d->IsMobile() || d->IsRoleComm() || (d->GetTechLevel() > 1.5f)) return false;
    return SlowMissileSpeedAllowed(enemy->GetVel().SqLength2D(), d->GetSpeed(), true, FRAMES_PER_SEC);
}

static void T1ExemptDrop(CCircuitAI* circuit, CCircuitUnit* unit, const CEnemyInfo* e, const char* path)
{
    circuit->LOG("T1EXEMPT: %s %i drops %s %i identified T1 (%s)", unit->GetCircuitDef()->GetDef()->GetName(), unit->GetId(),
            (e && e->GetCircuitDef()) ? e->GetCircuitDef()->GetDef()->GetName() : "?", e ? e->GetId() : -1, path);
    TRY_UNIT(circuit, unit,
        unit->ClearPriorityTarget();
        unit->CmdStop();
    )
}

bool MissileTargetAllowed(const CCircuitDef* launcher, const CEnemyInfo* enemy)
{
    if (ArtyT1Exempt(launcher, enemy)) return false;
    if (!IsSlowTargetLauncher(launcher->GetDef()->GetName())) {  // 2026-11-07: + Arbiter
        // Thanatos: an unidentified radar dot only while stationary (same dot rule).
        if ((enemy != nullptr) && (enemy->GetCircuitDef() == nullptr) && IsDotPickLauncher(launcher->GetDef()->GetName())) {
            return SlowMissileSpeedAllowed(enemy->GetVel().SqLength2D(), 0.f, false, FRAMES_PER_SEC);
        }
        return true;
    }
    if (enemy == nullptr) return false;
    const CCircuitDef* def = enemy->GetCircuitDef();
    return SlowMissileSpeedAllowed(enemy->GetVel().SqLength2D(), def ? def->GetSpeed() : 0.f, def != nullptr, FRAMES_PER_SEC);
}
static bool LockPriority(const CMilitaryManager::SArtyCommInfo& info, const CEnemyInfo* e);
static bool GhostGone(CCircuitAI* circuit, int enemyId);
static bool ArtyUnsafeHere(CCircuitAI* circuit, CCircuitUnit* unit, const AIFloat3& pos, int frame);
// Owner 2026-11-04 20:08Z: one ghost volley count per unit and ghost dark period.
// 2026-11-07: per launcher. Vanguard 5 volleys at heavy porc (1 other); Tremor is
// timed, so its need is in frames (105 s heavy, 45 s other).
static int GhostNeedFor(const CMilitaryManager::SArtySnipeInfo& si, const CCircuitDef* d, const CCircuitDef* launcher = nullptr)
{
	const bool heavy = (d != nullptr) && ((si.threats.count(d->GetId()) > 0) || (si.directThreats.count(d->GetId()) > 0));
	const std::string ln = (launcher != nullptr) ? launcher->GetDef()->GetName() : std::string();
	if (IsTimedGhostLauncher(ln)) return FRAMES_PER_SEC * (heavy ? 105 : 45);
	if (ln == "armvang") return heavy ? 5 : 1;
	return heavy ? si.volleys : si.ghostVolleysOther;
}
// 2026-11-07: a unit that gives ghost structures blind fire in its default pick:
// the close-in snipe units, plus Arbiter, Tremor and Vanguard by name.
static bool ArtyGhostPicker(const CMilitaryManager::SArtySnipeInfo& si, const CCircuitDef* cdef)
{
	if (!si.isEnabled || (cdef == nullptr)) return false;
	if (IsGhostPickLauncher(cdef->GetDef()->GetName())) return true;
	return (si.defs.count(cdef->GetId()) > 0) && (cdef->GetMaxRange(CCircuitDef::RangeType::LAND) >= si.closeMinRange);
}
static bool GhostDoneHas(const CMilitaryManager::SArtySnipeState& st, const CEnemyUnit* e)
{
	if (e == nullptr) return false;
	auto it = st.ghostDone.find(e->GetId());
	return (it != st.ghostDone.end()) && (it->second == e->GetDarkSince());
}
static void GhostDoneSet(CMilitaryManager::SArtySnipeState& st, const CEnemyUnit* e)
{
	if (e != nullptr) st.ghostDone[e->GetId()] = e->GetDarkSince();
}
static int& GhostCountRef(CMilitaryManager::SArtySnipeState& st, const CEnemyUnit* e)
{
	auto& c = st.ghostCount[e->GetId()];
	if (c.first != e->GetDarkSince()) c = std::make_pair(e->GetDarkSince(), 0);
	return c.second;
}
// A re-sighting (radar or LOS): its ghost counts start over.
static void GhostSeen(CMilitaryManager::SArtySnipeState& st, int id)
{
	st.ghostDone.erase(id);
	st.ghostCount.erase(id);
}

CArtilleryTask::CArtilleryTask(ITaskModule* mgr)
		: IFighterTask(mgr, FightType::ARTY, 1.f)
{
	position = manager->GetCircuit()->GetSetupManager()->GetBasePos();
}

CArtilleryTask::~CArtilleryTask()
{
}

bool CArtilleryTask::CanAssignTo(CCircuitUnit* unit) const
{
	// D-440: a definition with an engagement policy takes CEngagementTask
	// (TryMakeRangedTask); this task is the structure-bombarding artillery.
	return units.empty() && unit->GetCircuitDef()->IsRoleArty();
}

void CArtilleryTask::AssignTo(CCircuitUnit* unit)
{
	IFighterTask::AssignTo(unit);
	unit->CmdSetMoveState(CCircuitDef::MoveType::HOLD_POS);
	/*
	 * This task only ever ORDERS a structure (FindTarget skips IsMobile), but a
	 * unit holding position on fire-at-will shoots whatever wanders into range,
	 * so a Longbow parked at a porc line spent its salvos on passing boats. For
	 * `siege`-tagged artillery, return fire: it engages its ordered target and
	 * anything that attacks it, and nothing else. Restored to fire-at-will when
	 * the unit leaves the task, so a retreat or a squad reassignment behaves
	 * as before. Config-driven: the attribute is the switch.
	 */
	if (unit->GetCircuitDef()->IsAttrSiege()) {
		unit->CmdSetFireState(CCircuitDef::FireType::RETURN);
	}

	int squareSize = manager->GetCircuit()->GetPathfinder()->GetSquareSize();
	CCircuitDef* cdef = unit->GetCircuitDef();
	ITravelAction* travelAction;
	if (cdef->IsAttrSiege()) {
		travelAction = new CFightAction(unit, squareSize);
	} else {
		travelAction = new CMoveAction(unit, squareSize);
	}
	unit->PushTravelAct(travelAction);
	travelAction->StateWait();
	unit->SetAllowedToJump(cdef->IsAbleToJump() && cdef->IsAttrJump());
}

void CArtilleryTask::RemoveAssignee(CCircuitUnit* unit)
{
	if (unit->GetCircuitDef()->IsAttrSiege()) {
		unit->CmdSetFireState(CCircuitDef::FireType::OPEN);
	}
	ghostFire.erase(unit->GetId());
	IFighterTask::RemoveAssignee(unit);
	if (units.empty()) {
		manager->AbortTask(this);
	}

	unit->CmdSetMoveState(unit->GetCircuitDef()->GetMoveState());  // default: CCircuitDef::MoveType::MANEUVRE
}

void CArtilleryTask::Start(CCircuitUnit* unit)
{
	Execute(unit);
}

bool CArtilleryTask::ForgetUnit(CCircuitUnit* unit)
{
	return IFighterTask::ForgetUnit(unit);
}

void CArtilleryTask::Stop(bool done)
{
	IFighterTask::Stop(done);
}

void CArtilleryTask::Update()
{
	CCircuitAI* circuit = manager->GetCircuit();
	const int frame = circuit->GetLastFrame();

	if (++updCount % 4 == 0) {
		for (CCircuitUnit* unit : units) {
			Execute(unit);
		}
	} else {
		for (CCircuitUnit* unit : units) {
			if (unit->IsForceUpdate(frame)) {
				Execute(unit);
			}
		}
	}
}

void CArtilleryTask::Execute(CCircuitUnit* unit)
{
	if (unit->Blocker() != nullptr) {
		return;  // Do not interrupt current action
	}

	CCircuitAI* circuit = manager->GetCircuit();
	const int frame = circuit->GetLastFrame();
	if (ArtySpamRetreatStep(circuit, unit, frame)) {
		return;  // 2026-11-06: backing off from spam
	}
	if (ArtySnipeStep(circuit, unit, frame)) {
		return;  // owner 2026-11-03: sniping an outranging artillery structure
	}
	const AIFloat3& pos = unit->GetPos(frame);
	CEnemyInfo* bestTarget = FindTarget(unit, pos);
	// 2026-11-06: the previous default pick became identified T1: stop at once.
	{
		CMilitaryManager::SArtySnipeState& ps = circuit->GetMilitaryManager()->GetArtySnipeState(unit->GetId(), frame);
		if ((ps.pickTarget >= 0) && ((bestTarget == nullptr) || (bestTarget->GetId() != ps.pickTarget))) {
			CEnemyInfo* old = circuit->GetEnemyInfo(ps.pickTarget);
			if ((old != nullptr) && ArtyT1Exempt(unit->GetCircuitDef(), old)) T1ExemptDrop(circuit, unit, old, "pick");
		}
		ps.pickTarget = ((bestTarget != nullptr) && bestTarget->IsInRadarOrLOS()) ? bestTarget->GetId() : -1;
	}

	// Owner 2026-11-04 16:58Z: target lock. A commander / heavy pick breaks it
	// for now (it resumes after); else the locked target is kept until dead.
	{
		float lockDist = 0.f;
		CEnemyInfo* locked = ArtyLockGet(circuit, unit, frame, lockDist);
		const CMilitaryManager::SArtyCommInfo& lockInfo = circuit->GetMilitaryManager()->GetArtyCommInfo();
		const bool pickPriority = (bestTarget != nullptr) && bestTarget->IsInRadarOrLOS() && LockPriority(lockInfo, bestTarget);
		const bool safeHere = !ArtyUnsafeHere(circuit, unit, pos, frame);
		if ((locked != nullptr) && safeHere && !(pickPriority && (bestTarget != locked) && !LockPriority(lockInfo, locked))) {
			if (ArtyLockDrive(circuit, unit, frame, locked, lockDist)) return;
		}
		if ((locked == nullptr) && (bestTarget != nullptr) && bestTarget->IsInRadarOrLOS()) {  // a priority pick leaves the lock to resume
			ArtyLockSet(circuit, unit, frame, bestTarget);
		}
	}

	{
		CMilitaryManager* gm = circuit->GetMilitaryManager();
		const CMilitaryManager::SArtySnipeInfo& gsi = gm->GetArtySnipeInfo();
		if (ArtyGhostPicker(gsi, unit->GetCircuitDef())) {
			CMilitaryManager::SArtySnipeState& g = gm->GetArtySnipeState(unit->GetId(), frame);
			if (bestTarget == nullptr) {
				g.ghostAim = -1;  // its volleys are not counted against an old aim
			} else if (!bestTarget->IsInRadarOrLOS() && (g.ghostAim >= 0) && (g.ghostAim != bestTarget->GetId())) {
				// Owner 2026-11-04 20:08Z: a ghost's volleys are not cut short by a
				// re-pick of another ghost; it keeps the unfinished one while it
				// stands, in range (a live pick still comes first).
				CEnemyInfo* ga = circuit->GetEnemyInfo(g.ghostAim);
				const float r = unit->GetCircuitDef()->GetMaxRange();
				if ((ga != nullptr) && !ga->IsInRadarOrLOS() && !GhostGone(circuit, ga->GetId())
					&& !GhostDoneHas(g, ga->GetData()) && (pos.SqDistance2D(ga->GetPos()) <= SQUARE(r)))
				{
					bestTarget = ga;
				}
			}
		}
	}

	// 2026-11-07: Arbiter/Thanatos take the radar-dot pick like the slow launchers:
	// known targets, then unidentified (stationary) dots, then ghosts.
	if ((bestTarget != nullptr) && !bestTarget->IsInRadarOrLOS()
		&& IsDotPickLauncher(unit->GetCircuitDef()->GetDef()->GetName())
		&& ArtyRadarDotStep(circuit, unit, frame, pos))
	{
		return;
	}
	if (bestTarget != nullptr) {
		if (unit->GetTravelAct() != nullptr) unit->GetTravelAct()->StateWait();  // audit 11-04: never null here, guarded anyway

		// A commander can walk off: a short order so ATTACK never chases it out
		// of the firing spot; the next Execute re-picks (a structure if it left).
		const CCircuitDef* edef = bestTarget->GetCircuitDef();
		// Owner 00:29Z: a ghost pick gets a short order (re-issued each
		// Execute while the ghost lasts), so it cannot outlive the image.
		const int timeout = frame + FRAMES_PER_SEC * ((!bestTarget->IsInRadarOrLOS()) ? 8
				: ((edef != nullptr && edef->IsMobile()) ? 5 : 60));
		// Owner 21:36Z: a ghost pick is ground fire on its image; ArtySnipeStep
		// counts the volleys against it.
		const bool ghost = !bestTarget->IsInRadarOrLOS();
		CMilitaryManager* military = circuit->GetMilitaryManager();
		if (ArtyGhostPicker(military->GetArtySnipeInfo(), unit->GetCircuitDef())) {
			CMilitaryManager::SArtySnipeState& gst = military->GetArtySnipeState(unit->GetId(), frame);
			if (!ghost) {
				gst.ghostAim = -1;
				gst.ghostShots = 0;
			} else if (gst.ghostAim != bestTarget->GetId()) {
				gst.ghostAim = bestTarget->GetId();
				// Owner 05:45Z: a heavy ghost gets `volleys`, any other ghost structure
				// ghost_volleys_other (then waits for a fresh sighting, radar or LOS).
				// Owner 20:08Z: counted per dark period, kept across re-picks.
				const CMilitaryManager::SArtySnipeInfo& si = military->GetArtySnipeInfo();
				gst.ghostHeavy = (edef != nullptr) && ((si.threats.count(edef->GetId()) > 0) || (si.directThreats.count(edef->GetId()) > 0));
				gst.ghostNeed = GhostNeedFor(si, edef, unit->GetCircuitDef());
				gst.ghostShots = GhostCountRef(gst, bestTarget->GetData());
				circuit->LOG("ARTYPICK: %s %i tier ghost target %i", unit->GetCircuitDef()->GetDef()->GetName(), unit->GetId(), bestTarget->GetId());
				circuit->LOG("SNIPE: %s %i fires blind on ghost %s %i at (%.0f, %.0f), volleys %i/%i", unit->GetCircuitDef()->GetDef()->GetName(),
						unit->GetId(), (edef != nullptr) ? edef->GetDef()->GetName() : "?", bestTarget->GetId(),
						bestTarget->GetPos().x, bestTarget->GetPos().z, gst.ghostShots, gst.ghostNeed);
			}
			// 2026-11-07: Tremor's ghost fire is timed: the frames it holds this ghost
			// order count (at most 1 s per call, per dark period, kept across re-picks).
			if (ghost && IsTimedGhostLauncher(unit->GetCircuitDef()->GetDef()->GetName())) {
				int& n = GhostCountRef(gst, bestTarget->GetData());
				if ((gst.ghostTickAim == bestTarget->GetId()) && (gst.ghostTick >= 0)) n += std::min(frame - gst.ghostTick, FRAMES_PER_SEC);
				gst.ghostTick = frame;
				gst.ghostTickAim = bestTarget->GetId();
				gst.ghostShots = n;
				if (n >= gst.ghostNeed) {
					GhostDoneSet(gst, bestTarget->GetData());
					circuit->LOG("SNIPE: %s %i fired %.0f s (%s) at ghost %i, leaves it until seen", unit->GetCircuitDef()->GetDef()->GetName(),
							unit->GetId(), float(n) / FRAMES_PER_SEC, gst.ghostHeavy ? "heavy" : "other", bestTarget->GetId());
					gst.ghostAim = -1;
					gst.ghostShots = 0;
					gst.ghostTickAim = -1;
					TRY_UNIT(circuit, unit,
						unit->CmdStop();
					)
					return;
				}
			} else {
				gst.ghostTickAim = -1;
			}
		}
		TRY_UNIT(circuit, unit,
			if (ghost) {
				unit->CmdAttackGround(bestTarget->GetPos(), UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY, timeout);
			} else if (bestTarget->GetUnit() != nullptr) {  // owner 16:57Z: the engine drops it on death, also when cheating
				unit->GetUnit()->Attack(bestTarget->GetUnit(), UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY, timeout);
			} else {  // no unit handle: a short ground-fire order, re-issued while it lives
				unit->CmdAttackGround(bestTarget->GetPos(), UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY, std::min(timeout, frame + FRAMES_PER_SEC * 4));
			}
			if (!ghost) unit->CmdSetTarget(bestTarget);
		)
		return;
	}

	// Owner 2026-11-04 20:03Z: unidentified radar dots in range, after the
	// normal pick and before the idle ghost volley.
	if (ArtyRadarDotStep(circuit, unit, frame, pos)) {
		return;
	}

	if (FireAtGhost(unit, pos, frame)) {
		return;
	}

	// 2026-11-06 Task C: to 0.99 x range of the nearest reachable porc, outside real porc reach.
	if (ArtyApproach99(circuit, unit, frame, pos)) {
		return;
	}

	if (!IsQueryReady(unit)) {
		return;
	}

	if (enemyPositions.empty()) {
		FallbackSafePos(unit);
		return;
	}

	CCircuitDef* cdef = unit->GetCircuitDef();
	CThreatMap* threatMap = circuit->GetThreatMap();
	const float range = std::max(cdef->GetMaxRange()/* - threatMap->GetSquareSize()*/, (float)threatMap->GetSquareSize());

	CPathFinder* pathfinder = circuit->GetPathfinder();
	std::shared_ptr<IPathQuery> query = pathfinder->CreatePathMultiQuery(
			unit, threatMap,
			pos, range, enemyPositions);
	pathQueries[unit] = query;

	pathfinder->RunQuery(circuit->GetScheduler().get(), query, [this](const IPathQuery* query) {
		this->ApplyTargetPath(static_cast<const CQueryPathMulti*>(query));
	});
}

void CArtilleryTask::OnUnitIdle(CCircuitUnit* unit)
{
	IFighterTask::OnUnitIdle(unit);
	if (units.find(unit) != units.end()) {
		RemoveAssignee(unit);
	}
}

void CArtilleryTask::OnUnitMoveFailed(CCircuitUnit* unit)
{
	IFighterTask::OnUnitMoveFailed(unit);
}

void CArtilleryTask::OnUnitDamaged(CCircuitUnit* unit, CEnemyInfo* attacker)
{
	ArtySpamRetreatDamaged(manager->GetCircuit(), unit, attacker);
	IFighterTask::OnUnitDamaged(unit, attacker);
}

/*
 * Owner 2026-11-04 00:29Z: AI 10 kept blind-firing at a ghost image after it
 * was scouted dead and the image disappeared. A blind-fire target is gone when
 * the enemy manager no longer has it, it is hidden (its spot was seen empty),
 * dead or dying, or its spot is in our LOS now with nothing seen there. O(1).
 */
/*
 * Owner 2026-11-04 16:57Z: "If a wreck appears after firing, do not send
 * another salvo." A ghost's own wreck (feature "<def>_dead" / "<def>_heap")
 * within 64 of its spot, visible to us now: the engine returns only features
 * our ally team sees, so this is the live view, not the AI LOS map, which is
 * refreshed with the threat map every few seconds and let ground fire go on
 * at a seen wreck. One feature query per enemy at most every 0.5 s.
 */
static bool WreckSeen(CCircuitAI* circuit, const CEnemyUnit* e)
{
	if ((e == nullptr) || (e->GetCircuitDef() == nullptr)) return false;
	const int frame = circuit->GetLastFrame();
	auto& cache = circuit->GetMilitaryManager()->GetWreckCache();
	auto it = cache.find(e->GetId());
	if ((it != cache.end()) && (frame - it->second.first < FRAMES_PER_SEC / 2)) return it->second.second;
	if (cache.size() > 4096) cache.clear();
	const std::string name = e->GetCircuitDef()->GetDef()->GetName();
	bool seen = false;
	auto features = circuit->GetCallback()->GetFeaturesIn(e->GetPos(), 64.f);
	for (springai::Feature* f : features) {
		if (seen || (f == nullptr)) continue;
		springai::FeatureDef* fd = f->GetDef();
		if (fd != nullptr) {
			const std::string fn = fd->GetName();
			seen = (fn.size() > name.size()) && (fn.compare(0, name.size(), name) == 0)
				&& ((fn.compare(name.size(), std::string::npos, "_dead") == 0) || (fn.compare(name.size(), std::string::npos, "_heap") == 0));
			delete fd;
		}
	}
	utils::free_clear(features);
	cache[e->GetId()] = std::make_pair(frame, seen);
	return seen;
}

// nullptr: the ghost image still stands; else why it is gone.
static const char* GhostGoneWhy(CCircuitAI* circuit, int enemyId, bool wreck = true)
{
	const CEnemyUnit* e = circuit->GetEnemyManager()->GetEnemyUnit(enemyId);
	if ((e == nullptr) || e->IsDead() || ((e->GetData().losStatus & SEnemyData::LosMask::DYING) != 0)) return "dead";
	if (e->IsHidden()) return "seen empty";
	if (e->IsInLOS()) return nullptr;
	if (circuit->GetMapManager()->IsInLOS(e->GetPos())) return "seen empty";
	if (wreck && !e->IsInRadar() && WreckSeen(circuit, e)) return "wreck";
	return nullptr;
}

static bool GhostGone(CCircuitAI* circuit, int enemyId)
{
	return GhostGoneWhy(circuit, enemyId) != nullptr;
}

/*
 * Owner 2026-11-04 15:23Z: recruitment for the overlap sequence. Every
 * Boreas/Negotiator/Ambassador of this AI (artillery_snipe units of at least
 * close_in_min_range) within recruit_radius of an anchor (the gather/hold
 * point, at go-in also every gathered member) joins threat `threatId`: stage
 * 2, gathering (go false) or going in with the synced volley (go true). Only
 * finished, living units in a task that runs ArtySnipeStep (CArtilleryTask, or
 * a CRouteTask: FRONT squads, spam lanes) and not on a snipe already; a squad
 * unit stays in its route task, whose route orders wait while the snipe owns
 * it (ArtySnipeOwns), so the squad script keeps a valid handle. O(team units x
 * anchors) per call: every 0.5 s per gathering unit, and once per go-in.
 */
static int RecruitArtillery(CCircuitAI* circuit, const std::vector<AIFloat3>& anchors, int threatId, bool direct,
		bool go, int goFrame, int frame, int& squad)
{
	CMilitaryManager* military = circuit->GetMilitaryManager();
	const CMilitaryManager::SArtySnipeInfo& info = military->GetArtySnipeInfo();
	squad = 0;
	std::vector<int> ids;
	for (const auto& kv : circuit->GetTeamUnits()) {
		CCircuitUnit* r = kv.second;
		if ((r == nullptr) || r->IsDead() || r->IsDestroying() || !r->IsFinished()) continue;
		const CCircuitDef* rdef = r->GetCircuitDef();
		if ((rdef == nullptr) || (info.defs.count(rdef->GetId()) == 0)
			|| (rdef->GetMaxRange(CCircuitDef::RangeType::LAND) < info.closeMinRange)) continue;
		IUnitTask* task = r->GetTask();
		if (task == nullptr) continue;
		const bool inRoute = (dynamic_cast<CRouteTask*>(task) != nullptr);
		if (!inRoute && (dynamic_cast<CArtilleryTask*>(task) == nullptr)) continue;  // retreat, builder, ...: not ours
		auto sit = military->GetArtySnipeStates().find(r->GetId());
		if ((sit != military->GetArtySnipeStates().end()) && (sit->second.stage != 0)
			&& (frame - sit->second.lastCall <= FRAMES_PER_SEC * 10)) continue;  // on a snipe already
		const AIFloat3 rp = r->GetPos(frame);
		bool close = false;
		for (const AIFloat3& a : anchors) {
			if (rp.SqDistance2D(a) <= SQUARE(info.recruitRadius)) { close = true; break; }
		}
		if (!close) continue;
		ids.push_back(r->GetId());
		if (inRoute) ++squad;
	}
	for (const int id : ids) {
		CMilitaryManager::SArtySnipeState& rs = military->GetArtySnipeState(id, frame);
		rs.stage = 2;
		rs.threat = threatId;
		rs.direct = direct;
		rs.target = -1;
		rs.volleys = 0;
		rs.stageFrame = frame;
		rs.lastCall = frame;
		rs.orderKey = -1;
		rs.go = go;
		rs.goFrame = go ? goFrame : -1;
		rs.syncWait = go;
		rs.atHold = false;
		rs.holdSince = -1;
		rs.hitFrame = -1;
		rs.hasSnipeSpot = false;
		rs.spotFor = -1;
		rs.holding = false;
		rs.ghostAim = -1;
		rs.ghostShots = 0;
		rs.recruited = true;
	}
	return int(ids.size());
}

/*
 * Owner 2026-11-04 16:58Z: target lock (artillery_commander lock*). Returns
 * the unit's locked enemy while it is alive and identified (LOS or radar) and
 * worth keeping, else drops the lock (logged) and returns nullptr. `dist`: 2D
 * distance to it. A mobile lock farther than range + margin drops (no chase).
 * O(1).
 */
static bool LockPriority(const CMilitaryManager::SArtyCommInfo& info, const CEnemyInfo* e)
{
	const CCircuitDef* edef = (e != nullptr) ? e->GetCircuitDef() : nullptr;
	return (edef != nullptr) && (edef->IsRoleComm() || (info.heavyMaxSqSpeed.count(edef->GetId()) > 0));
}

CEnemyInfo* ArtyLockGet(CCircuitAI* circuit, CCircuitUnit* unit, int frame, float& dist)
{
	CMilitaryManager* military = circuit->GetMilitaryManager();
	const CMilitaryManager::SArtyCommInfo& info = military->GetArtyCommInfo();
	const CCircuitDef* cdef = unit->GetCircuitDef();
	if (!info.isEnabled || !info.lockEnabled || (info.defs.count(cdef->GetId()) == 0)) return nullptr;
	CMilitaryManager::SArtySnipeState& st = military->GetArtySnipeState(unit->GetId(), frame);
	if (st.lockId < 0) return nullptr;
	CEnemyInfo* e = circuit->GetEnemyInfo(st.lockId);
	const float range = cdef->GetMaxRange(CCircuitDef::RangeType::LAND);
	const char* why = nullptr;
	bool stop = false;
	if ((e == nullptr) || e->GetData()->IsDead() || e->GetData()->IsDying()) {
		why = "dead";
		stop = true;
	} else if (e->IsHidden()) {
		why = "seen empty";
		stop = true;
	} else if (!e->IsInRadarOrLOS()) {
		if (WreckSeen(circuit, e->GetData())) {
			why = "wreck";
			stop = true;
		} else {
			why = "lost from radar and LOS (ghost rules)";
		}
	} else if (ArtyT1Exempt(cdef, e)) {
		T1ExemptDrop(circuit, unit, e, "lock");
		why = "identified T1 (exempt)";
		stop = false;  // stopped above
	} else if (!MissileTargetAllowed(cdef, e)) {
        why = "moving too fast"; stop = true;
	} else if (e->GetCircuitDef() == nullptr) {
		why = "unidentified";
	} else {
		dist = unit->GetPos(frame).distance2D(e->GetPos());
		if (e->GetCircuitDef()->IsMobile() && (dist > range + info.lockMargin)) why = "moved out of range";
		// a step in is only for a target just out of reach; after a retreat or a
		// long pause (another task) the lock is stale: never walk back to it
		else if (dist > range * 1.5f) why = "far away";
		else if ((st.lockSeen >= 0) && (frame - st.lockSeen > FRAMES_PER_SEC * 30)) why = "away for 30 s (retreat or another task)";
	}
	st.lockSeen = frame;
	if (why == nullptr) return e;
	circuit->LOG("ARTY: %s %i target %s %i %s, lock drops", cdef->GetDef()->GetName(), unit->GetId(),
			(e != nullptr && e->GetCircuitDef() != nullptr) ? e->GetCircuitDef()->GetDef()->GetName() : "?", st.lockId, why);
	if (stop) {
		TRY_UNIT(circuit, unit,
			unit->CmdStop();
		)
	}
	st.lockId = -1;
	st.lockOrderUntil = -1;
	st.lockStepping = false;
	return nullptr;
}

// Locks `e` (picked to shoot: identified, LOS or radar) when it qualifies.
void ArtyLockSet(CCircuitAI* circuit, CCircuitUnit* unit, int frame, CEnemyInfo* e)
{
	CMilitaryManager* military = circuit->GetMilitaryManager();
	const CMilitaryManager::SArtyCommInfo& info = military->GetArtyCommInfo();
	const CCircuitDef* cdef = unit->GetCircuitDef();
	if (!info.isEnabled || !info.lockEnabled || (info.defs.count(cdef->GetId()) == 0)) return;
	if ((e == nullptr) || !e->IsInRadarOrLOS() || (e->GetCircuitDef() == nullptr) || (e->GetUnit() == nullptr)) return;
	if (e->GetCircuitDef()->IsMobile() && !info.lockMobiles && !LockPriority(info, e)) return;
	CMilitaryManager::SArtySnipeState& st = military->GetArtySnipeState(unit->GetId(), frame);
	if (st.lockId == e->GetId()) return;
	if ((st.lockId >= 0) && !LockPriority(info, e)) return;  // only a commander / heavy replaces a lock
	st.lockId = e->GetId();
	st.lockOrderUntil = -1;
	st.lockLastHold = frame;
	st.lockSeen = frame;
	st.lockStepping = false;
	circuit->LOG("ARTY: %s %i locks on %s %i (%s) at %.0f", cdef->GetDef()->GetName(), unit->GetId(),
			e->GetCircuitDef()->GetDef()->GetName(), e->GetId(), e->IsInLOS() ? "LOS" : "radar",
			unit->GetPos(frame).distance2D(e->GetPos()));
}

/*
 * Drives the unit on its lock: within range + margin an attack on the unit
 * handle, re-issued every 4 s (5 s orders); a structure farther out: a move to
 * range - step_in on the line to it, then the attack. True when it gave the
 * order (the caller issues nothing else: no forward path, no route resume).
 */
bool ArtyLockDrive(CCircuitAI* circuit, CCircuitUnit* unit, int frame, CEnemyInfo* e, float dist)
{
	CMilitaryManager* military = circuit->GetMilitaryManager();
	const CMilitaryManager::SArtyCommInfo& info = military->GetArtyCommInfo();
	const CCircuitDef* cdef = unit->GetCircuitDef();
	CMilitaryManager::SArtySnipeState& st = military->GetArtySnipeState(unit->GetId(), frame);
	const float range = cdef->GetMaxRange(CCircuitDef::RangeType::LAND);
	const bool hold = dist <= range + info.lockMargin;
	if (frame - st.lockLastHold > FRAMES_PER_SEC * 2) {
		circuit->LOG("ARTY: %s %i lock resumes on %s %i at %.0f", cdef->GetDef()->GetName(), unit->GetId(),
				e->GetCircuitDef()->GetDef()->GetName(), e->GetId(), dist);
		st.lockOrderUntil = -1;
	}
	st.lockLastHold = frame;
	if (hold == st.lockStepping) st.lockOrderUntil = -1;  // hold <-> step-in changed
	if (frame < st.lockOrderUntil) return true;
	st.lockOrderUntil = frame + FRAMES_PER_SEC * 4;
	const int timeout = frame + FRAMES_PER_SEC * 5;
	if (unit->GetTravelAct() != nullptr) unit->GetTravelAct()->StateWait();
	if (hold) {
		if (st.lockStepping) {
			circuit->LOG("ARTY: %s %i lock holds on %s %i at %.0f (range %.0f + %.0f)", cdef->GetDef()->GetName(), unit->GetId(),
					e->GetCircuitDef()->GetDef()->GetName(), e->GetId(), dist, range, info.lockMargin);
		}
		st.lockStepping = false;
		TRY_UNIT(circuit, unit,
			unit->GetUnit()->Attack(e->GetUnit(), UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY, timeout);
			unit->CmdSetTarget(e);
		)
		return true;
	}
	AIFloat3 here = unit->GetPos(frame);
	AIFloat3 dir = here - e->GetPos();
	dir.y = 0.f;
	const float len = std::max(1.f, dir.Length2D());
	const float want = std::max(100.f, range - info.lockStepIn);
	AIFloat3 to = e->GetPos() + dir * (want / len);
	CTerrainManager::CorrectPosition(to);
	if (!st.lockStepping) {
		circuit->LOG("ARTY: %s %i lock steps in on %s %i: %.0f away, to %.0f (no advance)", cdef->GetDef()->GetName(),
				unit->GetId(), e->GetCircuitDef()->GetDef()->GetName(), e->GetId(), dist, want);
	}
	st.lockStepping = true;
	TRY_UNIT(circuit, unit,
		unit->CmdMoveTo(to, 0, frame + FRAMES_PER_SEC * 8);
		unit->GetUnit()->Attack(e->GetUnit(), UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY | UNIT_COMMAND_OPTION_SHIFT_KEY, frame + FRAMES_PER_SEC * 8);
	)
	return true;
}

/*
 * Owner 2026-11-04 20:03Z: unidentified radar dots. After the normal pick (and
 * the lock), before the idle ghost volley: the nearest enemy in radar, not in
 * LOS, with no def, within weapon range, is attacked by its unit handle (5 s
 * orders, re-issued every 4 s) until it dies. Dropped (and the order stopped)
 * when it dies, gets identified (the normal rules take it on the next pick),
 * leaves radar, or leaves range + lock_margin; never a move toward it.
 * Skipped: dots more than 100 above the ground (aircraft), underwater dots for
 * a non-water weapon, a unit under threat. A dot has no def: nothing here reads
 * one. O(known enemies) at most once a second while no dot is in range.
 */
bool ArtyRadarDotStep(CCircuitAI* circuit, CCircuitUnit* unit, int frame, const AIFloat3& pos)
{
	CMilitaryManager* military = circuit->GetMilitaryManager();
	const CMilitaryManager::SArtyCommInfo& info = military->GetArtyCommInfo();
	CCircuitDef* cdef = unit->GetCircuitDef();
	// 2026-11-07: Vanguard by name (not an artillery_commander unit).
	if (!info.isEnabled || !info.radarDots || ((info.defs.count(cdef->GetId()) == 0) && !IsDotPickLauncher(cdef->GetDef()->GetName()))) return false;
	CMilitaryManager::SArtySnipeState& st = military->GetArtySnipeState(unit->GetId(), frame);
	const float range = cdef->GetMaxRange(CCircuitDef::RangeType::LAND);
	CEnemyInfo* dot = (st.dotId >= 0) ? circuit->GetEnemyInfo(st.dotId) : nullptr;
	if (st.dotId >= 0) {
		const char* why = nullptr;
		if ((dot == nullptr) || dot->GetData()->IsDead() || dot->GetData()->IsDying()) why = "dead";
		else if (dot->GetCircuitDef() != nullptr) {
			why = "identified (normal rules)";
			if (ArtyT1Exempt(cdef, dot)) {
				circuit->LOG("T1EXEMPT: %s %i drops %s %i identified T1 (radar dot)", cdef->GetDef()->GetName(), unit->GetId(),
						dot->GetCircuitDef()->GetDef()->GetName(), dot->GetId());
				why = "identified T1 (exempt)";
			}
		}
		else if (!MissileTargetAllowed(cdef, dot)) why = "moving too fast";
		else if (dot->IsInLOS()) why = "in LOS";
		else if (!dot->GetData()->IsInRadar() || dot->IsHidden()) why = "lost from radar";
		else if (pos.distance2D(dot->GetPos()) > range + info.lockMargin) why = "out of range";
		if (why != nullptr) {
			circuit->LOG("ARTY: %s %i radar dot %i %s, stops", cdef->GetDef()->GetName(), unit->GetId(), st.dotId, why);
			TRY_UNIT(circuit, unit,
				unit->CmdStop();
			)
			st.dotId = -1;
			st.dotOrderUntil = -1;
			dot = nullptr;
		}
	}
	if (dot == nullptr) {
		if (frame < st.dotScan) return false;
		st.dotScan = frame + FRAMES_PER_SEC;
		if (ArtyUnsafeHere(circuit, unit, pos, frame)) return false;  // retreat comes first (Task C: real reach for the 3 launchers)
		const bool notAW = !cdef->HasSurfToWater();
		float bestSq = SQUARE(range);
		for (auto& kv : circuit->GetEnemyInfos()) {
			CEnemyInfo* e = kv.second;
			if ((e == nullptr) || (e->GetCircuitDef() != nullptr) || e->IsInLOS() || e->IsHidden()
				|| !e->GetData()->IsInRadar() || e->GetData()->IsDead() || e->GetData()->IsDying()
				|| (e->GetUnit() == nullptr) || !MissileTargetAllowed(cdef, e)) continue;
			const AIFloat3& ep = e->GetPos();
			if (notAW && (ep.y < -SQUARE_SIZE * 5)) continue;
			if (ep.y > std::max(0.f, circuit->GetMap()->GetElevationAt(ep.x, ep.z)) + 100.f) continue;  // airborne
			const float sq = pos.SqDistance2D(ep);
			if (sq < bestSq) {
				bestSq = sq;
				dot = e;
			}
		}
		if (dot == nullptr) return false;
		st.dotId = dot->GetId();
		st.dotOrderUntil = -1;
		circuit->LOG("ARTY: %s %i fires on radar dot %i at %.0f (unidentified)", cdef->GetDef()->GetName(), unit->GetId(),
				st.dotId, std::sqrt(bestSq));
	}
	if (frame < st.dotOrderUntil) return true;
	st.dotOrderUntil = frame + FRAMES_PER_SEC * 4;
	if (unit->GetTravelAct() != nullptr) unit->GetTravelAct()->StateWait();
	TRY_UNIT(circuit, unit,
		unit->GetUnit()->Attack(dot->GetUnit(), UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY, frame + FRAMES_PER_SEC * 5);
	)
	return true;
}

// A route task holding its lock through the range micro (KeepWeaponRange).
void ArtyLockHeld(CCircuitAI* circuit, CCircuitUnit* unit, int frame)
{
	circuit->GetMilitaryManager()->GetArtySnipeState(unit->GetId(), frame).lockLastHold = frame;
}

/*
 * 2026-11-06 Task C (Ambassador, Negotiator, Boreas): the real weapon reach of
 * known armed enemies, not the padded threat map (which reaches ~110% of porc
 * range and left them idle at its edge). True when `at` is within ground range
 * + 16 of an identified armed structure (live, radar or a ghost that still
 * stands) or of a live (LOS/radar) identified armed mobile. O(known enemies).
 */
bool ArtyRealUnsafeAt(CCircuitAI* circuit, const AIFloat3& at)
{
	for (const auto& kv : circuit->GetEnemyInfos()) {
		const CEnemyInfo* e = kv.second;
		const CCircuitDef* d = (e != nullptr) ? e->GetCircuitDef() : nullptr;
		if ((d == nullptr) || e->IsHidden() || e->GetData()->IsDead() || e->GetData()->IsDying() || !d->HasSurfToLand()) continue;
		const bool live = e->IsInRadarOrLOS();
		if (d->IsMobile() ? !live : (!live && GhostGone(circuit, e->GetId()))) continue;
		if (live && e->IsBeingBuilt()) continue;
		const float r = d->GetMaxRange(CCircuitDef::RangeType::LAND);
		if ((r > 0.f) && (at.SqDistance2D(e->GetPos()) < SQUARE(r + 16.f))) return true;
	}
	return false;
}

static bool ArtyUnsafeHere(CCircuitAI* circuit, CCircuitUnit* unit, const AIFloat3& pos, int frame)
{
	if (!IsSlowMissileLauncher(unit->GetCircuitDef()->GetDef()->GetName())) {
		CThreatMap* tm = circuit->GetThreatMap();
		tm->SetThreatType(unit);
		return tm->GetThreatAt(pos) > THREAT_MIN;
	}
	CMilitaryManager::SArtySnipeState& st = circuit->GetMilitaryManager()->GetArtySnipeState(unit->GetId(), frame);
	if (st.unsafeFrame != frame) {
		st.unsafeFrame = frame;
		st.unsafeHere = ArtyRealUnsafeAt(circuit, pos);
	}
	return st.unsafeHere;
}

/*
 * 2026-11-06 Task C: approach. Nothing in range to shoot: the nearest enemy
 * structure beyond own range (live, radar, or a ghost not yet given its
 * volleys) is approached to 0.99 x own range on the line from it, if that spot
 * is outside the real reach (+16) of every known armed structure and live
 * armed mobile; else the line is turned in 15 degree steps up to +-90. Porc
 * whose reach is beyond 0.99 x own range is left to the snipe routine; none
 * found: false (the old path). Re-issued every 3 s. O(known enemies x 13).
 */
bool ArtyApproach99(CCircuitAI* circuit, CCircuitUnit* unit, int frame, const AIFloat3& pos)
{
	const CCircuitDef* cdef = unit->GetCircuitDef();
	if (!IsSlowMissileLauncher(cdef->GetDef()->GetName())) return false;
	CMilitaryManager* military = circuit->GetMilitaryManager();
	CMilitaryManager::SArtySnipeState& st = military->GetArtySnipeState(unit->GetId(), frame);
	const float range = cdef->GetMaxRange(CCircuitDef::RangeType::LAND);
	const float want = range * 0.99f;
	const int canTargetCat = cdef->GetTargetCategory();
	CEnemyInfo* best = nullptr;
	float bestSq = std::numeric_limits<float>::max();
	for (const auto& kv : circuit->GetEnemyInfos()) {
		CEnemyInfo* e = kv.second;
		const CCircuitDef* d = (e != nullptr) ? e->GetCircuitDef() : nullptr;
		if ((d == nullptr) || d->IsMobile() || d->IsIgnore() || e->IsHidden() || e->GetData()->IsDead() || e->GetData()->IsDying()
			|| ((d->GetCategory() & canTargetCat) == 0)) continue;
		if (!cdef->HasSurfToWater() && (e->GetPos().y < -SQUARE_SIZE * 5)) continue;
		const bool ghost = !e->IsInRadarOrLOS();
		if (ghost && (GhostDoneHas(st, e->GetData()) || GhostGone(circuit, e->GetId()))) continue;
		if (d->HasSurfToLand() && (d->GetMaxRange(CCircuitDef::RangeType::LAND) + 16.f > want)) continue;  // outranges: snipe routine
		const float sq = pos.SqDistance2D(e->GetPos());
		if (sq <= SQUARE(range)) continue;  // in range: the pick's job
		if (sq < bestSq) { bestSq = sq; best = e; }
	}
	if (best == nullptr) {
		st.approachTarget = -1;
		return false;
	}
	const AIFloat3 tp = best->GetPos();
	AIFloat3 dir = pos - tp;
	dir.y = 0.f;
	if (dir.Length2D() < 1.f) dir = AIFloat3(1.f, 0.f, 0.f);
	dir.Normalize2D();
	bool found = false;
	AIFloat3 spot;
	for (int k = 0; (k <= 12) && !found; ++k) {
		const int step = (k + 1) / 2 * ((k % 2) ? 1 : -1);  // 0, +1, -1, +2, -2, ... (x 15 deg)
		const float a = step * 0.261799f;
		const float c = std::cos(a), s = std::sin(a);
		AIFloat3 p(tp.x + (dir.x * c - dir.z * s) * want, tp.y, tp.z + (dir.x * s + dir.z * c) * want);
		CTerrainManager::CorrectPosition(p);
		if (!ArtyRealUnsafeAt(circuit, p)) { spot = p; found = true; }
	}
	if (!found) {
		st.approachTarget = -1;
		return false;
	}
	const bool changed = (st.approachTarget != best->GetId()) || (spot.SqDistance2D(st.approachSpot) > SQUARE(100.f));
	if (changed) {
		circuit->LOG("APPROACH99: %s %i to (%.0f, %.0f) for %s %i %s", cdef->GetDef()->GetName(), unit->GetId(), spot.x, spot.z,
				best->GetCircuitDef()->GetDef()->GetName(), best->GetId(), best->IsInLOS() ? "live" : (best->IsInRadarOrLOS() ? "radar" : "ghost"));
	}
	if (changed || (frame >= st.approachOrderUntil)) {
		st.approachTarget = best->GetId();
		st.approachSpot = spot;
		st.approachOrderUntil = frame + FRAMES_PER_SEC * 3;
		if (pos.SqDistance2D(spot) > SQUARE(48.f)) {
			if (unit->GetTravelAct() != nullptr) unit->GetTravelAct()->StateWait();
			TRY_UNIT(circuit, unit,
				unit->CmdMoveTo(spot, 0, frame + FRAMES_PER_SEC * 8);
			)
		}
	}
	return true;
}

void ArtyRangeTargetCheck(CCircuitAI* circuit, CCircuitUnit* unit, CEnemyInfo* nearest)
{
	if ((circuit == nullptr) || (unit == nullptr) || !IsT1ExemptLauncher(unit->GetCircuitDef()->GetDef()->GetName())) return;
	CMilitaryManager::SArtySnipeState& st = circuit->GetMilitaryManager()->GetArtySnipeState(unit->GetId(), circuit->GetLastFrame());
	if ((st.rangeTarget >= 0) && ((nearest == nullptr) || (nearest->GetId() != st.rangeTarget))) {
		CEnemyInfo* old = circuit->GetEnemyInfo(st.rangeTarget);
		if ((old != nullptr) && ArtyT1Exempt(unit->GetCircuitDef(), old)) T1ExemptDrop(circuit, unit, old, "route range");
	}
	st.rangeTarget = (nearest != nullptr) ? nearest->GetId() : -1;
}

/*
 * 2026-11-06: spam retreat. An Ambassador, Negotiator or Boreas damaged by a
 * T1/T2 mobile that is not a listed heavy unit, or by an unknown attacker
 * (none, or no def), moves spam_retreat_distance away: of three points (away
 * from the attacker, the same turned +-45 degrees) plus one toward our base,
 * the one with the least threat; clamped to the map. More damage re-aims it
 * (at most once a second). Ends (logged) once the unit is at the point and has
 * taken no damage for spam_retreat_quiet_seconds; then the normal steps take
 * it again. Porc and heavies do not trigger it (the snipe/lock rules handle
 * those). O(1) per call.
 */
void ArtySpamRetreatDamaged(CCircuitAI* circuit, CCircuitUnit* unit, CEnemyInfo* attacker)
{
	if ((circuit == nullptr) || (unit == nullptr) || unit->IsDead()) return;
	CMilitaryManager* military = circuit->GetMilitaryManager();
	const CMilitaryManager::SArtySnipeInfo& info = military->GetArtySnipeInfo();
	const CCircuitDef* cdef = unit->GetCircuitDef();
	if (!info.spamRetreat || (cdef == nullptr) || !IsSpamRetreatLauncher(cdef->GetDef()->GetName())) return;  // 2026-11-07: + Arbiter, Thanatos
	const CCircuitDef* adef = (attacker != nullptr) ? attacker->GetCircuitDef() : nullptr;
	if (adef != nullptr) {
		if (!adef->IsMobile()) return;  // porc: snipe rules
		if (adef->GetTechLevel() >= 3.f) return;
		if (military->GetArtyCommInfo().heavyMaxSqSpeed.count(adef->GetId()) > 0) return;  // heavy unit
	}
	const int frame = circuit->GetLastFrame();
	CMilitaryManager::SArtySnipeState& st = military->GetArtySnipeState(unit->GetId(), frame);
	st.retreatDamage = frame;
	if (st.retreating && (frame - st.retreatAimed < FRAMES_PER_SEC)) return;
	const AIFloat3 pos = unit->GetPos(frame);
	AIFloat3 from = (attacker != nullptr) ? attacker->GetPos() : pos;
	const AIFloat3 base = circuit->GetSetupManager()->GetBasePos();
	AIFloat3 away = pos - from;
	away.y = 0.f;
	if (away.Length2D() < 1.f) {
		away = base - pos;
		away.y = 0.f;
	}
	if (away.Length2D() < 1.f) away = AIFloat3(1.f, 0.f, 0.f);
	away.Normalize2D();
	const float d = info.spamRetreatDistance;
	CThreatMap* threatMap = circuit->GetThreatMap();
	threatMap->SetThreatType(unit);
	AIFloat3 best;
	float bestThreat = std::numeric_limits<float>::max();
	const float angles[3] = {0.f, 0.785398f, -0.785398f};
	for (float a : angles) {
		const float c = std::cos(a), s = std::sin(a);
		AIFloat3 p(pos.x + (away.x * c - away.z * s) * d, pos.y, pos.z + (away.x * s + away.z * c) * d);
		CTerrainManager::CorrectPosition(p);
		const float t = threatMap->GetThreatAt(p);
		if (t < bestThreat) { bestThreat = t; best = p; }
	}
	{
		AIFloat3 home = base - pos;
		home.y = 0.f;
		if (home.Length2D() > 1.f) {
			home.Normalize2D();
			AIFloat3 p(pos.x + home.x * d, pos.y, pos.z + home.z * d);
			CTerrainManager::CorrectPosition(p);
			const float t = threatMap->GetThreatAt(p);
			if (t < bestThreat) { bestThreat = t; best = p; }
		}
	}
	if (!st.retreating) {
		circuit->LOG("SPAMRETREAT: start %s %i from %s %i, to (%.0f, %.0f)", cdef->GetDef()->GetName(), unit->GetId(),
				(adef != nullptr) ? adef->GetDef()->GetName() : "unknown", (attacker != nullptr) ? attacker->GetId() : -1, best.x, best.z);
	}
	st.retreating = true;
	st.retreatPoint = best;
	st.retreatAimed = frame;
	st.retreatOrderUntil = -1;  // re-issued on the next step
}

bool ArtySpamRetreatStep(CCircuitAI* circuit, CCircuitUnit* unit, int frame)
{
	if ((circuit == nullptr) || (unit == nullptr)) return false;
	CMilitaryManager* military = circuit->GetMilitaryManager();
	const auto& states = military->GetArtySnipeStates();
	auto it = states.find(unit->GetId());
	if ((it == states.end()) || !it->second.retreating) return false;
	CMilitaryManager::SArtySnipeState& st = military->GetArtySnipeState(unit->GetId(), frame);
	const CMilitaryManager::SArtySnipeInfo& info = military->GetArtySnipeInfo();
	const AIFloat3 pos = unit->GetPos(frame);
	const bool there = pos.SqDistance2D(st.retreatPoint) < SQUARE(120.f);
	if ((frame - st.retreatDamage > info.spamRetreatQuietFrames) && (there || (frame - st.retreatDamage > info.spamRetreatQuietFrames * 4))) {
		st.retreating = false;
		circuit->LOG("SPAMRETREAT: end %s %i at (%.0f, %.0f), %.1f s quiet", unit->GetCircuitDef()->GetDef()->GetName(), unit->GetId(),
				pos.x, pos.z, float(frame - st.retreatDamage) / FRAMES_PER_SEC);
		st.orderKey = -1;
		st.lockOrderUntil = -1;
		return false;
	}
	if (!there && (frame >= st.retreatOrderUntil)) {
		st.retreatOrderUntil = frame + FRAMES_PER_SEC * 2;
		if (unit->GetTravelAct() != nullptr) unit->GetTravelAct()->StateWait();
		TRY_UNIT(circuit, unit,
			unit->CmdMoveTo(st.retreatPoint, 0, frame + FRAMES_PER_SEC * 6);
		)
	}
	return true;
}

bool ArtySnipeOwns(CCircuitAI* circuit, const CCircuitUnit* unit)
{
	if ((circuit == nullptr) || (unit == nullptr)) return false;
	const auto& states = circuit->GetMilitaryManager()->GetArtySnipeStates();
	auto it = states.find(unit->GetId());
	if ((it != states.end()) && it->second.retreating) return true;  // 2026-11-06: spam retreat holds the unit
	return (it != states.end()) && (it->second.stage != 0)
		&& (circuit->GetLastFrame() - it->second.lastCall <= FRAMES_PER_SEC * 10);
}

bool GhostFireStep(CCircuitAI* circuit, CCircuitUnit* unit, const AIFloat3& pos, int frame,
		SGhostFire& track, std::unordered_map<int, bool>& ghostSupport, int volleyLimit, bool allowFire)
{
	// Owner 2026-11-02: listed rocket artillery (Arbiter, Negotiator, Thanatos,
	// Ambassador, Boreas) with nothing seen to shoot fires on a ghost image of
	// enemy porc already in weapon range, once it has not fired for
	// ghost_idle_seconds. One ATTACK_GROUND volley; never a move toward it.
	// Owner 2026-11-02: porc here includes building radars, building jammers
	// and shields, besides armed structures.
	const CMilitaryManager::SArtyCommInfo& info = circuit->GetMilitaryManager()->GetArtyCommInfo();
	CCircuitDef* cdef = unit->GetCircuitDef();
	if (volleyLimit <= 0 && (!info.isEnabled || info.ghostDefs.count(cdef->GetId()) == 0)) {
		return false;
	}
	springai::Weapon* weapon = unit->GetMainWeapon();
	if (weapon == nullptr) {
		return false;
	}
	// A shot is the engine's weapon-fired event for this unit, or a rising
	// main-weapon reload frame (sampled per call, so it can lag). Test g1: the
	// reload sample alone missed an Ambassador's ghost volley and re-fired 21 s
	// later as if idle. O(1) per call.
	const int reload = weapon->GetReloadFrame();
	const int prevShot = track.shot;
	if (track.reload < 0) {
		track.shot = (reload > frame) ? frame : -1;
	} else if (reload > track.reload) {
		track.shot = frame;
		track.orderUntil = -1;
	}
	track.reload = reload;
	if (unit->GetFireFrame() > track.shot) {
		track.shot = unit->GetFireFrame();
		if (track.shot >= track.orderUntil - FRAMES_PER_SEC * 5) track.orderUntil = -1;
	}
	// Owner 2026-11-04 20:08Z: each ghost volley counts (per dark period); a heavy
	// ghost is done after 3, any other after 1, until it is seen again.
	CMilitaryManager* gfm = circuit->GetMilitaryManager();
	CMilitaryManager::SArtySnipeState& gfs = gfm->GetArtySnipeState(unit->GetId(), frame);
    // Ranged ghost users do not enter ArtySnipeStep, so keep their volley ledger alive.
    if (volleyLimit > 0) gfs.lastCall = frame;
	if ((track.shot != prevShot) && (track.shot >= 0) && (track.target >= 0) && !track.counted
		&& (track.orderFrame >= 0) && (track.shot >= track.orderFrame) && (track.shot - track.orderFrame <= FRAMES_PER_SEC * 6))
	{
		track.counted = true;
		const CEnemyUnit* ge = circuit->GetEnemyManager()->GetEnemyUnit(track.target);
		if ((ge != nullptr) && ge->NotInRadarAndLOS()) {
			int& n = GhostCountRef(gfs, ge);
			++n;
            // End this ground-fire order after one detected volley, so a fast
            // reload cannot silently repeat it beyond the configured budget.
            if (volleyLimit > 0) { TRY_UNIT(circuit, unit, unit->CmdStop();) }
			const int need = volleyLimit > 0 ? volleyLimit : GhostNeedFor(gfm->GetArtySnipeInfo(), ge->GetCircuitDef(), cdef);
			circuit->LOG("ARTY: %s %i ghost volley %i/%i at %i", cdef->GetDef()->GetName(), unit->GetId(), n, need, track.target);
			if (n >= need) {
				GhostDoneSet(gfs, ge);

				circuit->LOG("ARTY: %s %i fired %i ghost volleys at %i, leaves it until seen", cdef->GetDef()->GetName(),
						unit->GetId(), n, track.target);
			}
		}
	}
	const char* goneWhy = (((volleyLimit > 0) || (frame < track.orderUntil)) && (track.target >= 0)) ? GhostGoneWhy(circuit, track.target) : nullptr;
	if (goneWhy != nullptr) {
		circuit->LOG("ARTY: %s %i target %i %s, stops", cdef->GetDef()->GetName(), unit->GetId(), track.target, goneWhy);
		track.orderUntil = -1;
		track.target = -1;
		TRY_UNIT(circuit, unit,
			unit->CmdStop();
		)
		return false;
	}
    if (!allowFire) {
        if (track.target >= 0) { TRY_UNIT(circuit, unit, unit->CmdStop();) }
        track.target = -1; track.orderUntil = -1;
        return false;
    }
	if (frame < track.orderUntil) {
		return true;  // the volley is on its way; do not replace the order
	}
	if ((frame - track.shot < (volleyLimit > 0 ? 0 : info.ghostIdleFrames)) || (reload > frame)) {
		return false;
	}
	if (ArtyUnsafeHere(circuit, unit, pos, frame)) {
		return false;  // retreat comes first (Task C: real reach for the 3 launchers)
	}
	const bool notAW = !cdef->HasSurfToWater();
	const int canTargetCat = cdef->GetTargetCategory();
	float bestSqDist = SQUARE(cdef->GetMaxRange(CCircuitDef::RangeType::LAND));
	const CEnemyUnit* best = nullptr;
	// O(known enemies), only while idle past the gate.
	for (const auto& kv : circuit->GetEnemyManager()->GetEnemyUnits()) {
		const CEnemyUnit* e = kv.second;
		const CCircuitDef* edef = (e != nullptr) ? e->GetCircuitDef() : nullptr;
		if ((edef == nullptr) || !e->NotInRadarAndLOS() || e->IsIgnore() || e->IsBeingBuilt() || GhostDoneHas(gfs, e)
			|| (e->GetData().losStatus & (SEnemyData::LosMask::HIDDEN | SEnemyData::LosMask::DYING | SEnemyData::LosMask::DEAD))
			|| edef->IsMobile() || edef->IsAbleToFly()
			|| ((edef->GetCategory() & canTargetCat) == 0)
			|| (notAW && (e->GetPos().y < -SQUARE_SIZE * 5)))
		{
			continue;
		}
		if (!edef->HasSurfToLand()) {
			// Engine def reads once per type per task, then O(1).
			auto it = ghostSupport.find(edef->GetId());
			if (it == ghostSupport.end()) {
				springai::UnitDef* ud = edef->GetDef();
				const bool support = (edef->GetShieldMount() != nullptr)
					|| (ud->GetRadarRadius() > 0) || (ud->GetJammerRadius() > 0);
				it = ghostSupport.emplace(edef->GetId(), support).first;
			}
			if (!it->second) {
				continue;
			}
		}
		const float sqDist = pos.SqDistance2D(e->GetPos());
		if ((sqDist < bestSqDist) && !GhostGone(circuit, e->GetId())) {  // owner 16:57Z: no salvo at a seen wreck
			bestSqDist = sqDist;
			best = e;
		}
	}
	if (best == nullptr) {
		return false;
	}
	if (unit->GetTravelAct() != nullptr) unit->GetTravelAct()->StateWait();  // route-task units (FRONT squads, spam lanes) have none
	const int timeout = frame + FRAMES_PER_SEC * 5;
	track.orderUntil = timeout;
	track.target = best->GetId();
	track.orderFrame = frame;
	track.counted = false;
	TRY_UNIT(circuit, unit,
		if (volleyLimit > 0) unit->CmdStationaryGroundTarget(best->GetPos());
        else unit->CmdAttackGround(best->GetPos(), UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY, timeout);
	)
	circuit->LOG("ARTY: %s %i fires on ghost %s at (%.0f, %.0f), last shot %s %.0f s ago",
			cdef->GetDef()->GetName(), unit->GetId(), best->GetCircuitDef()->GetDef()->GetName(),
			best->GetPos().x, best->GetPos().z, (track.shot < 0) ? "never seen, game time" : "",
			float(frame - std::max(0, track.shot)) / FRAMES_PER_SEC);
	return true;
}

/*
 * Owner 2026-11-03: Thanatos, Arbiter, Boreas, Negotiator and Ambassador were
 * lost to Persecutors (1390), Rattlesnakes and Eviscerators (1380), which
 * outrange them (1200-1310). Before walking into the reach of such a structure
 * (seen, radar dot or ghost image) the unit:
 *  1) shoots seen / radar non-light porc ("porc" list, near the threat) that it
 *     can hit from a spot outside every known threat's reach, from
 *     prep_range_fraction (0.99) of its range, until dead;
 *  2) fires `volleys` at ghost images of that porc, same rule;
 *  3) closes to snipe_range_fraction of its own range of the threat and fires
 *     `volleys` at it (ghost: at its last seen spot);
 *  4) if it is then live (radar or LOS now), attacks it until dead; if it
 *     turns back into a ghost, `volleys` more (owner 02:06Z).
 * Then the ordinary controller has the unit back; that threat is left alone
 * by this unit for repeat_seconds. Returns true while it owns the unit.
 * Owner 2026-11-03 01:36Z: Pulsar, Bulwark and Bastion ("direct_threats") are
 * attacked from snipe_range_fraction before the unit goes into their reach,
 * with no prep step: seen ones until dead (visible_max_volleys at most), ghost
 * images `volleys`, then `volleys` more if seen alive. The outranging threats
 * above are taken first when both are near.
 * Owner 01:43Z: seen porc is shot until dead (visible_max_volleys 0), unless
 * a higher value target meeting the artillery_commander rules (slow commander,
 * then slow heavy unit) is in current weapon range: that is shot first and the
 * sequence waits (those volleys do not count). Give-up timers count from the
 * last volley (stage_max_seconds without one).
 * Cost: O(known enemies) per call while a threat is near, else one pass over
 * known enemies looking only at the threat defs.
 */
namespace {
struct SSnipeHazard { AIFloat3 pos; float sqReach; int id; bool threat; };

bool SnipeAlive(const CEnemyUnit* e)
{
	if ((e == nullptr) || (e->GetCircuitDef() == nullptr) || e->IsHidden() || e->IsDead()) return false;
	return (e->GetData().losStatus & SEnemyData::LosMask::DYING) == 0;
}

// Owner 2026-11-03 20:53Z: share of two weapon-range half-discs, each centred
// on its porc with the flat edge through the porc, perpendicular to the line
// from the porc to `face` (our group's hold point): area of the intersection
// over the smaller half-disc's area. 20 x 24 = 480 area-uniform polar samples
// over the smaller half-disc; O(480).
float HalfDiscShare(const AIFloat3& pA, float rA, const AIFloat3& pB, float rB, const AIFloat3& face)
{
	const bool aSmall = rA <= rB;
	const AIFloat3& pS = aSmall ? pA : pB;
	const AIFloat3& pL = aSmall ? pB : pA;
	const float rS = aSmall ? rA : rB;
	const float rL = aSmall ? rB : rA;
	if ((rS <= 0.f) || (pS.SqDistance2D(pL) > SQUARE(rS + rL))) return 0.f;
	auto axis = [&face](const AIFloat3& p, float& ax, float& az) {
		ax = face.x - p.x; az = face.z - p.z;
		const float len = std::sqrt(ax * ax + az * az);
		if (len < 1.f) { ax = 1.f; az = 0.f; } else { ax /= len; az /= len; }
	};
	float sx, sz, lx, lz;
	axis(pS, sx, sz);
	axis(pL, lx, lz);
	const float base = std::atan2(sz, sx);
	constexpr int NR = 20, NA = 24;
	int inside = 0;
	for (int i = 0; i < NR; ++i) {
		const float r = rS * std::sqrt((i + 0.5f) / NR);
		for (int j = 0; j < NA; ++j) {
			const float a = base - 1.5707963f + 3.14159265f * (j + 0.5f) / NA;
			const float px = pS.x + r * std::cos(a), pz = pS.z + r * std::sin(a);
			const float dx = px - pL.x, dz = pz - pL.z;
			if ((dx * dx + dz * dz <= rL * rL) && (dx * lx + dz * lz >= 0.f)) ++inside;
		}
	}
	return float(inside) / float(NR * NA);
}

// The highest weapon-range half-disc share of aimed heavy `t` with any other
// live or ghost heavy (threats + direct threats) within both ranges; `with`
// gets that heavy. Shares cached per pair for 10 s. O(known enemies + 480 per
// new pair).
float DoubleHeavyShare(CMilitaryManager* military, CEnemyManager* enemyMgr, const CEnemyUnit* t,
		const AIFloat3& face, int frame, const CEnemyUnit*& with)
{
	const CMilitaryManager::SArtySnipeInfo& info = military->GetArtySnipeInfo();
	float best = 0.f;
	with = nullptr;
	// Owner 2026-11-03 21:58Z: any two heavies, live or ghost, count.
	const float rT = t->GetCircuitDef()->GetMaxRange(CCircuitDef::RangeType::LAND);
	auto& cache = military->GetArtySnipeOverlaps();
	for (const auto& kv : enemyMgr->GetEnemyUnits()) {
		const CEnemyUnit* e = kv.second;
		if ((e == t) || (e->GetCircuitDef() == nullptr) || e->IsHidden() || e->IsDead()) continue;
		const CCircuitDef::Id hid = e->GetCircuitDef()->GetId();
		if ((info.threats.count(hid) == 0) && (info.directThreats.count(hid) == 0)) continue;
		const float rH = e->GetCircuitDef()->GetMaxRange(CCircuitDef::RangeType::LAND);
		if (e->GetPos().SqDistance2D(t->GetPos()) > SQUARE(rT + rH)) continue;
		const uint64_t key = (uint64_t(uint32_t(t->GetId())) << 32) | uint32_t(e->GetId());
		auto it = cache.find(key);
		float share;
		if ((it != cache.end()) && (frame - it->second.second < FRAMES_PER_SEC * 10)) {
			share = it->second.first;
		} else {
			share = HalfDiscShare(t->GetPos(), rT, e->GetPos(), rH, face);
			cache[key] = {share, frame};
		}
		if (share > best) { best = share; with = e; }
	}
	return best;
}

const char* SnipeName(const CEnemyUnit* e)
{
	return (e != nullptr && e->GetCircuitDef() != nullptr) ? e->GetCircuitDef()->GetDef()->GetName() : "?";
}
}  // namespace

namespace {
/*
 * Owner 2026-11-01 / 2026-11-03: artillery_commander units shoot a slow enemy
 * commander, then a slow heavy unit (heavy_units, now with Tremor) in current
 * weapon range before anything else, wherever they are: the native artillery
 * task, a FRONT squad route (owner 02:33Z: Arbiters in squads never got this),
 * or a snipe sequence (which waits; those volleys do not count). O(known
 * enemies) at most every 0.5 s per unit while nothing qualifies.
 */
bool ArtyPriorityStep(CCircuitAI* circuit, CCircuitUnit* unit, int frame, CMilitaryManager::SArtySnipeState& st,
		const AIFloat3& pos, float range)
{
	CMilitaryManager* military = circuit->GetMilitaryManager();
	CCircuitDef* cdef = unit->GetCircuitDef();
	if ((frame < st.nextHvScan) && (frame >= st.hvUntil)) {
		return false;
	}
	st.nextHvScan = frame + FRAMES_PER_SEC / 2;
	const CMilitaryManager::SArtyCommInfo& comm = military->GetArtyCommInfo();
	CEnemyInfo* hv = nullptr;
	bool hvComm = false;
	float hvSq = std::numeric_limits<float>::max();
	if (comm.isEnabled && (comm.defs.count(cdef->GetId()) > 0)) {
		const int canTargetCat = cdef->GetTargetCategory();
		const float sqRange = SQUARE(range);
		for (auto& kv : circuit->GetEnemyInfos()) {
			CEnemyInfo* e = kv.second;
			if (e->IsHidden() || !e->IsInRadarOrLOS() || !MissileTargetAllowed(cdef, e)) continue;
			const CCircuitDef* edef = e->GetCircuitDef();
			if ((edef == nullptr) || ((edef->GetCategory() & canTargetCat) == 0)) continue;
			const float sq = pos.SqDistance2D(e->GetPos());
			if (sq > sqRange) continue;
			const float v = e->GetVel().SqLength2D();
			const bool isComm = edef->IsRoleComm() && (v <= comm.maxSqSpeed);
			bool isHeavy = false;
			if (!isComm) {
				auto it = comm.heavyMaxSqSpeed.find(edef->GetId());
				isHeavy = (it != comm.heavyMaxSqSpeed.end()) && (v <= it->second);
			}
			if ((!isComm && !isHeavy) || (hvComm && !isComm)) continue;
			if ((sq < hvSq) || (isComm && !hvComm)) {
				hv = e;
				hvSq = sq;
				hvComm = isComm;
			}
		}
	}
	if ((hv == nullptr) && (st.orderKey <= -1000000)) {
		CEnemyInfo* cur = circuit->GetEnemyInfo(-1000000 - st.orderKey);
		if ((cur != nullptr) && ArtyT1Exempt(cdef, cur)) {
			T1ExemptDrop(circuit, unit, cur, "priority");
			st.orderKey = -1;
		}
	}
	if (hv != nullptr) {
		st.hvUntil = frame + FRAMES_PER_SEC * 3;
		const int key = -1000000 - hv->GetId();
		if ((st.orderKey != key) || (frame >= st.orderUntil)) {
			if (st.orderKey != key) {
				circuit->LOG("PRIORITY: %s %i shoots %s %s %i in range%s", cdef->GetDef()->GetName(), unit->GetId(),
						hvComm ? "commander" : "heavy unit", hv->GetCircuitDef()->GetDef()->GetName(), hv->GetId(),
						(st.stage != 0) ? " (snipe waits)" : "");
			}
			st.orderKey = key;
			st.orderUntil = frame + FRAMES_PER_SEC * 4;
			const int timeout = frame + FRAMES_PER_SEC * 5;
			if (unit->GetTravelAct() != nullptr) unit->GetTravelAct()->StateWait();
			TRY_UNIT(circuit, unit,
				if (hv->GetUnit() != nullptr) {
					unit->GetUnit()->Attack(hv->GetUnit(), UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY, timeout);
				} else {
					unit->CmdAttackGround(hv->GetPos(), UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY, timeout);
				}
			)
		}
		return true;
	}
	return false;
}
}  // namespace

bool ArtySnipeStep(CCircuitAI* circuit, CCircuitUnit* unit, int frame)
{
	CMilitaryManager* military = circuit->GetMilitaryManager();
	const CMilitaryManager::SArtySnipeInfo& info = military->GetArtySnipeInfo();
	CCircuitDef* cdef = unit->GetCircuitDef();
	const bool isSnipe = info.isEnabled && (info.defs.count(cdef->GetId()) > 0);
	const CMilitaryManager::SArtyCommInfo& commInfo = military->GetArtyCommInfo();
	const bool isPriority = commInfo.isEnabled && (commInfo.defs.count(cdef->GetId()) > 0);
	// 2026-11-07: ghost pickers (Arbiter, Tremor, Vanguard) need the volley count and
	// the slow launchers (Tremor) the live pick, even outside both unit lists.
	if (!isSnipe && !isPriority && !ArtyGhostPicker(info, cdef) && !IsSlowMissileLauncher(cdef->GetDef()->GetName())) {
		return false;
	}
	const float range = cdef->GetMaxRange(CCircuitDef::RangeType::LAND);
	springai::Weapon* weapon = unit->GetMainWeapon();
	if ((range < 100.f) || (weapon == nullptr)) {
		return false;
	}
	CMilitaryManager::SArtySnipeState& st = military->GetArtySnipeState(unit->GetId(), frame);
	if ((st.stage != 0) && (frame - st.lastCall > FRAMES_PER_SEC * 10)) {
		st.stage = 0;  // away (retreat, another task) too long: start over
	}
	if (st.fireHeld && ((st.stage != 2) || !st.syncWait)) {
		st.fireHeld = false;  // a synced volley no longer waits: the unit's own fire state back
		unit->TrySetFireState(cdef->GetFireState());
	}
	// Owner 2026-11-04 16:58Z: a lock goes stale only while the unit is out of
	// artillery control (retreat, another task): every artillery update lands here.
	if ((st.lockId >= 0) && (st.lockSeen >= 0) && (frame - st.lockSeen <= FRAMES_PER_SEC * 30)) st.lockSeen = frame;
	st.lastCall = frame;

	// Volleys: a rising main-weapon reload frame or the engine's weapon-fired
	// event; anything within half a reload of the last counted one is the same
	// salvo (Thanatos fires 6 rockets over 1.5 s).
	{
		const int gap = std::max(FRAMES_PER_SEC, cdef->GetReloadTime() / 2);
		const int reload = weapon->GetReloadFrame();
		int shotAt = -1;
		if ((st.reload >= 0) && (reload > st.reload)) shotAt = frame;
		st.reload = reload;
		const int fired = unit->GetFireFrame();
		if (st.fireSeen == -2) {
			st.fireSeen = fired;  // first call: older shots are not ours
		} else if (fired > st.fireSeen) {
			st.fireSeen = fired;
			shotAt = std::max(shotAt, fired);
		}
		if ((shotAt >= 0) && ((st.lastVolley < 0) || (shotAt - st.lastVolley >= gap))) {
			st.lastVolley = shotAt;
			if ((st.stage != 0) && (frame >= st.hvUntil)) ++st.volleys;
			// Owner 2026-11-03 21:36Z: a ghost picked by the default target
			// choice gets `volleys` blind volleys, then is left until a fresh
			// LOS sighting (CArtilleryTask::FindTarget / Execute).
			const CEnemyUnit* ga = ((st.stage == 0) && (st.ghostAim >= 0) && (frame >= st.hvUntil)
					&& !IsTimedGhostLauncher(cdef->GetDef()->GetName()))  // 2026-11-07: Tremor counts time, in Execute
					? circuit->GetEnemyManager()->GetEnemyUnit(st.ghostAim) : nullptr;
			if ((ga != nullptr) && ga->NotInRadarAndLOS()) {
				int& n = GhostCountRef(st, ga);
				st.ghostShots = ++n;
				circuit->LOG("SNIPE: %s %i ghost volley %i/%i at %i", cdef->GetDef()->GetName(), unit->GetId(), n, st.ghostNeed, st.ghostAim);
				if (n >= st.ghostNeed) {
					GhostDoneSet(st, ga);
					circuit->LOG("SNIPE: %s %i fired %i blind volleys (%s) at ghost %i, leaves it until seen", cdef->GetDef()->GetName(),
							unit->GetId(), n, st.ghostHeavy ? "heavy" : "other", st.ghostAim);
					st.ghostAim = -1;
					st.ghostShots = 0;
				}
			}
		}
	}

	CEnemyManager* enemyMgr = circuit->GetEnemyManager();
	const AIFloat3 pos = unit->GetPos(frame);
	// Owner 2026-11-04 00:29Z: the default ghost pick's image is gone (scouted
	// dead, seen empty): stop the ground fire, drop it, clear its counts.
	const char* aimGone = ((st.stage == 0) && (st.ghostAim >= 0)) ? GhostGoneWhy(circuit, st.ghostAim) : nullptr;
	if (aimGone != nullptr) {
		circuit->LOG("ARTY: %s %i target %i %s, stops (ghost pick)", cdef->GetDef()->GetName(), unit->GetId(), st.ghostAim, aimGone);
		st.ghostDone.erase(st.ghostAim);
		st.ghostAim = -1;
		st.ghostShots = 0;
		TRY_UNIT(circuit, unit,
			unit->CmdStop();
		)
	}
    if (IsSlowMissileLauncher(cdef->GetDef()->GetName())) {
        unit->TrySetFireState(CCircuitDef::FireType::HOLD);
        if (st.missileTarget >= 0) {
            CEnemyInfo* cur = circuit->GetEnemyInfo(st.missileTarget);
            if ((cur != nullptr) && ArtyT1Exempt(cdef, cur)) {
                T1ExemptDrop(circuit, unit, cur, "missile");
                st.missileTarget = -1;
                st.missileOrderUntil = -1;
            }
        }
        CEnemyInfo* best = nullptr;
        float bestSq = SQUARE(range);
        // 2026-11-07 (@Barscrewl): 0 known (LOS or identified radar contact, one
        // tier: nearest first), 1 unidentified radar dot. Was LOS > radar > dot.
        int bestTier = 2;
        for (const auto& kv : circuit->GetEnemyInfos()) {
            CEnemyInfo* e = kv.second;
            if (e->IsHidden() || !e->IsInRadarOrLOS() || e->GetData()->IsDead() || e->GetData()->IsDying()
                    || e->GetUnit() == nullptr || !MissileTargetAllowed(cdef, e)) continue;
            const CCircuitDef* edef = e->GetCircuitDef();
            if (edef && ((edef->GetCategory() & cdef->GetTargetCategory()) == 0 || edef->IsIgnore())) continue;
            const AIFloat3& ep = e->GetPos();
            if (!cdef->HasSurfToWater() && ep.y < -SQUARE_SIZE * 5) continue;
            if (!edef && ep.y > std::max(0.f, circuit->GetMap()->GetElevationAt(ep.x, ep.z)) + 100.f) continue;
            const float sq = pos.SqDistance2D(ep);
            if (sq >= SQUARE(range)) continue;
            const int tier = (e->IsInLOS() || (edef != nullptr)) ? 0 : 1;
            if ((tier < bestTier) || ((tier == bestTier) && (sq < bestSq))) { best = e; bestSq = sq; bestTier = tier; }
        }
        if (best && (st.missileTarget != best->GetId())) {
            circuit->LOG("ARTYPICK: %s %i tier %s target %i (%s)", cdef->GetDef()->GetName(), unit->GetId(),
                    (bestTier == 0) ? "known" : "dot", best->GetId(), best->IsInLOS() ? "LOS" : "radar");
        }
        if (best) {
            if (st.missileTarget != best->GetId() || frame >= st.missileOrderUntil) {
                if (st.missileTarget != best->GetId()) circuit->LOG("MISSILE: %s %i selects slow %s target %i speed %.2f elmos/s", cdef->GetDef()->GetName(), unit->GetId(), best->IsInLOS() ? "LOS" : "radar", best->GetId(), std::sqrt(best->GetVel().SqLength2D()) * FRAMES_PER_SEC);
                st.missileTarget = best->GetId();
                st.missileOrderUntil = frame + FRAMES_PER_SEC;
                if (unit->GetTravelAct()) unit->GetTravelAct()->StateWait();
                TRY_UNIT(circuit, unit,
                    unit->ClearPriorityTarget();
                    unit->GetUnit()->Attack(best->GetUnit(), UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY, frame + FRAMES_PER_SEC * 2);
                )
            }
            return true;
        }
        if (st.missileTarget >= 0) {
            circuit->LOG("MISSILE: %s %i drops live target %i (no eligible slow target), resumes ghost rules", cdef->GetDef()->GetName(), unit->GetId(), st.missileTarget);
            st.missileTarget = -1;
            st.missileOrderUntil = -1;
            TRY_UNIT(circuit, unit,
                unit->ClearPriorityTarget();
                unit->CmdStop();
            )
        }
    }
	if (isPriority && ArtyPriorityStep(circuit, unit, frame, st, pos, range)) {
		return true;
	}
	if (!isSnipe || (range < info.closeMinRange)) {
		return false;  // owner 21:36Z: Thanatos/Arbiter: default target choice + GhostFireStep only
	}
	auto skipped = [&st, frame](int id) {
		auto it = st.skipUntil.find(id);
		if (it == st.skipUntil.end()) return false;
		if (frame < it->second) return true;
		st.skipUntil.erase(it);
		return false;
	};
	auto reachOf = [&info](const CCircuitDef* edef) {
		return edef->GetMaxRange(CCircuitDef::RangeType::LAND) + info.threatMargin;
	};

	if (st.stage == 0) {
		if (frame < st.nextScan) {
			return false;
		}
		st.nextScan = frame + FRAMES_PER_SEC / 2;
		const CEnemyUnit* best = nullptr;
		bool bestDirect = true;
		bool bestClear = false;
		int bestRank = std::numeric_limits<int>::max();
		float bestSq = std::numeric_limits<float>::max();
		// Test round 3: the nearest threat (a Pulsar 370 from a Persecutor) was
		// sniped first from a spot inside the other's reach. A threat whose snipe
		// spot can sit outside every other threat's reach goes first; else the
		// earliest in "threats" (Persecutor before Pulsar); then nearest.
		// O(threats^2 x 13) once per 0.5 s, only with a threat in range.
		std::vector<std::pair<AIFloat3, float>> allThreats;  // pos, reach^2
		std::vector<int> allIds;
		for (const auto& kv : enemyMgr->GetEnemyUnits()) {
			const CEnemyUnit* e = kv.second;
			if (!SnipeAlive(e) || (e->IsInRadarOrLOS() && e->IsBeingBuilt())) continue;
			if (info.threats.count(e->GetCircuitDef()->GetId()) == 0) continue;
			allThreats.push_back({e->GetPos(), SQUARE(reachOf(e->GetCircuitDef()))});
			allIds.push_back(e->GetId());
		}
		// Round 5: coming in from one side, a unit entered the Pulsar's trigger
		// before the Persecutor's, so the Persecutor was never compared. Once one
		// threat triggers, every threat within porc_radius of it is a candidate.
		std::vector<AIFloat3> triggered;
		for (size_t i = 0; i < allThreats.size(); ++i) {
			const CEnemyUnit* e = enemyMgr->GetEnemyUnit(allIds[i]);
			if ((e == nullptr) || (!e->IsInRadarOrLOS() && GhostDoneHas(st, e))) continue;
			const float trigger = reachOf(e->GetCircuitDef()) + info.triggerDistance;
			if (pos.SqDistance2D(allThreats[i].first) < SQUARE(trigger)) triggered.push_back(allThreats[i].first);
		}
		auto nearTriggered = [&](const AIFloat3& p) {
			for (const AIFloat3& t : triggered) {
				if (p.SqDistance2D(t) <= SQUARE(info.porcRadius)) return true;
			}
			return false;
		};
		const float snipeR = range * info.snipeFraction;
		auto clearSpot = [&](const CEnemyUnit* t) {
			const AIFloat3& tp = t->GetPos();
			const float base = std::atan2(pos.z - tp.z, pos.x - tp.x);
			for (int k = 0; k < 24; ++k) {
				const float off = ((k + 1) / 2) * (3.14159265f / 12.f) * ((k % 2 == 0) ? 1.f : -1.f);
				AIFloat3 c(tp.x + std::cos(base + off) * snipeR, 0.f, tp.z + std::sin(base + off) * snipeR);
				const float cap = std::max(0.f, pos.distance2D(tp) - snipeR)
					+ t->GetCircuitDef()->GetMaxRange(CCircuitDef::RangeType::LAND) * 1.5707963f;  // owner 02:50Z detour cap
				if (pos.SqDistance2D(c) > SQUARE(cap)) continue;
				// The spot and the straight walk to it (test round 4: a Pulsar spot
				// existed only behind it, reached through the Persecutor's reach).
				bool ok = true;
				const float len = pos.distance2D(c);
				const int n = std::max(1, int(len / 100.f));
				for (int w = n; ok && (w >= 1); --w) {
					const float f = float(w) / n;
					const AIFloat3 p(pos.x + (c.x - pos.x) * f, 0.f, pos.z + (c.z - pos.z) * f);
					for (size_t i = 0; ok && (i < allThreats.size()); ++i) {
						if ((allIds[i] != t->GetId()) && (p.SqDistance2D(allThreats[i].first) < allThreats[i].second)) ok = false;
					}
				}
				if (ok) return true;
			}
			return false;
		};
		for (const auto& kv : enemyMgr->GetEnemyUnits()) {
			const CEnemyUnit* e = kv.second;
			if (!SnipeAlive(e) || (e->IsInRadarOrLOS() && e->IsBeingBuilt())) continue;
			const CCircuitDef::Id eid = e->GetCircuitDef()->GetId();
			const bool direct = info.threats.count(eid) == 0;
			if (direct && (info.directThreats.count(eid) == 0)) continue;
			// Owner 2026-11-04 20:08Z: a re-sighting by radar or LOS resets a
			// ghost's volleys (was LOS only).
			if (e->IsInRadarOrLOS()) GhostSeen(st, e->GetId());
			// Owner 2026-11-03 21:58Z: live or ghost, a heavy only starts a sequence
			// through a pair above double_heavy_overlap (checked below); a single
			// one is left to the default target choice.
			if (!e->IsInRadarOrLOS() && GhostDoneHas(st, e)) continue;  // its ghost already had the volleys
			if (direct && !bestDirect && (best != nullptr)) continue;  // outranging threats first
			float sq = pos.SqDistance2D(e->GetPos());
			const float trigger = reachOf(e->GetCircuitDef()) + info.triggerDistance;
			if ((sq >= SQUARE(trigger)) && (direct || !nearTriggered(e->GetPos()))) continue;
			// A threat other units already work on comes first among equals, so
			// the group is not split (O(snipe states), only for threats in range).
			for (const auto& kv2 : military->GetArtySnipeStates()) {
				if ((kv2.second.threat == e->GetId()) && (kv2.second.stage != 0) && (kv2.first != unit->GetId())) {
					sq *= 0.25f;
					break;
				}
			}
			if (skipped(e->GetId())) continue;
			bool better;
			bool clear = false;
			int rank = std::numeric_limits<int>::max();
			if (direct) {
				better = bestDirect && (sq < bestSq);
			} else {
				clear = clearSpot(e);
				auto rit = info.threatRank.find(e->GetCircuitDef()->GetId());
				if (rit != info.threatRank.end()) rank = rit->second;
				better = (best == nullptr) || bestDirect
					|| (clear && !bestClear)
					|| ((clear == bestClear) && ((rank < bestRank) || ((rank == bestRank) && (sq < bestSq))));
			}
			if (better) {
				bestSq = sq;
				best = e;
				bestDirect = direct;
				bestClear = clear;
				bestRank = rank;
			}
		}
		if (best == nullptr) {
			return false;
		}
		// Owner 2026-11-03 21:36Z / 21:58Z: the default target choice is the
		// baseline (a single ghost is one of its targets); only a heavy, live or
		// ghost, sharing more than double_heavy_overlap with another live or
		// ghost heavy starts a sequence, straight to the gather (no prep porc).
		{
			const CEnemyUnit* with = nullptr;
			const float share = DoubleHeavyShare(military, enemyMgr, best, pos, frame, with);
			if ((with == nullptr) || (share <= info.doubleHeavyOverlap)) {
				return false;
			}
		}
		st.stage = 2;
		st.recruited = false;  // triggered itself
		st.direct = bestDirect;
		st.go = false;
		st.atHold = false;
		st.holdSince = -1;
		st.hasSnipeSpot = false;
		st.spotFor = -1;
		st.holding = false;
		st.threat = best->GetId();
		st.target = -1;
		st.volleys = 0;
		st.stageFrame = frame;
		st.orderKey = -1;
		circuit->LOG("SNIPE: %s %i starts on %s%s %i (%s) at (%.0f, %.0f), %.0f away, its reach %.0f, own range %.0f",
				cdef->GetDef()->GetName(), unit->GetId(), bestDirect ? "porc " : "", SnipeName(best), best->GetId(),
				best->IsInRadarOrLOS() ? "visible" : "ghost", best->GetPos().x, best->GetPos().z,
				std::sqrt(bestSq), reachOf(best->GetCircuitDef()), range);
	}

	const CEnemyUnit* threat = enemyMgr->GetEnemyUnit(st.threat);
	auto finish = [&](const char* why) {
		circuit->LOG("SNIPE: %s %i done with %s %i: %s", cdef->GetDef()->GetName(), unit->GetId(),
				SnipeName(threat), st.threat, why);
		st.skipUntil[st.threat] = frame + info.repeatFrames;
		st.stage = 0;
		st.threat = -1;
		st.target = -1;
		st.orderKey = -1;
		st.syncWait = false;
		if (st.fireHeld) {
			st.fireHeld = false;
			unit->TrySetFireState(cdef->GetFireState());
		}
		return false;  // the ordinary controller takes over on this same call
	};
	const char* threatGone = !SnipeAlive(threat) ? "dead"
			: (!threat->IsInRadarOrLOS() ? GhostGoneWhy(circuit, st.threat) : nullptr);
	if (threatGone != nullptr) {
		// Owner 00:29Z: stop the queued ground fire / attack on a gone target.
		// Owner 16:58Z: "target dead" and "ghost gone" (seen empty / wreck) apart.
		const int gone = st.threat;
		TRY_UNIT(circuit, unit,
			unit->CmdStop();
		)
		st.ghostDone.erase(gone);
		return finish((std::strcmp(threatGone, "dead") == 0) ? "target dead, stops"
				: (std::strcmp(threatGone, "wreck") == 0) ? "ghost gone (wreck seen), stops" : "ghost gone (seen empty), stops");
	}

	// Hazards: every known threat structure, plus (avoid_other_porc) other armed
	// ground-hitting porc with a reach up to 2000. O(known enemies).
	std::vector<SSnipeHazard> hazards;
	for (const auto& kv : enemyMgr->GetEnemyUnits()) {
		const CEnemyUnit* e = kv.second;
		if (!SnipeAlive(e) || (e->IsInRadarOrLOS() && e->IsBeingBuilt())) continue;
		const CCircuitDef* edef = e->GetCircuitDef();
		if (edef->IsMobile()) continue;
		const bool isThreat = info.threats.count(edef->GetId()) > 0;
		if (!isThreat && (!info.avoidOtherPorc || !edef->HasSurfToLand())) continue;
		const float r = edef->GetMaxRange(CCircuitDef::RangeType::LAND);
		if ((r <= 0.f) || (!isThreat && (r > 2000.f))) continue;
		hazards.push_back({e->GetPos(), SQUARE(r + info.threatMargin), e->GetId(), isThreat});
	}
	// Outside every hazard but `except`; threatsOnly for walk checks.
	auto safeAt = [&hazards](const AIFloat3& p, int except, bool threatsOnly) {
		for (const SSnipeHazard& h : hazards) {
			if ((h.id == except) || (threatsOnly && !h.threat)) continue;
			if (p.SqDistance2D(h.pos) < h.sqReach) return false;
		}
		return true;
	};
	// Owner 02:47Z: the walk to a firing spot must stay out of every hazard's
	// reach (threats and other armed porc, ghost images included), the target
	// excepted; no safe walk means no spot, and the prep porc step comes first.
	auto walkSafe = [&](const AIFloat3& a, const AIFloat3& b, int except) {
		if (!safeAt(a, except, false)) return true;  // already inside: any way out will do
		const float len = a.distance2D(b);
		const int n = std::max(1, int(len / 100.f));
		for (int i = 1; i <= n; ++i) {
			const float t = float(i) / n;
			if (!safeAt(AIFloat3(a.x + (b.x - a.x) * t, 0.f, a.z + (b.z - a.z) * t), except, false)) return false;
		}
		return true;
	};
	CTerrainManager* terrain = circuit->GetTerrainManager();
	// A firing spot `radius` from `aim`, nearest the unit: angles out to 90
	// degrees either side of the line to the unit, two rings. strict: every
	// spot and the walk to it must be safe (except `except`); otherwise the
	// safest-first fallback is the straight approach.
	// Owner 02:49Z/02:50Z: no detour longer than pi/2 x the aimed porc's weapon
	// range (a quarter circle around it): a spot counts only within (straight
	// distance to firing range) + that.
	auto rangeOf = [](const CEnemyUnit* e, float fallback) {
		const float r = e->GetCircuitDef()->GetMaxRange(CCircuitDef::RangeType::LAND);
		return (r > 0.f) ? r : fallback;
	};
	auto findSpot = [&](const AIFloat3& aim, float radius, int except, bool strict, AIFloat3& out, float porcRange) {
		float base = std::atan2(pos.z - aim.z, pos.x - aim.x);
		const float maxWalk = std::max(0.f, pos.distance2D(aim) - radius) + porcRange * 1.5707963f;
		bool found = false;
		float bestSq = std::numeric_limits<float>::max();
		// Owner 2026-11-03 16:30Z: with significant overlap, attack from the side
		// with the least shared overlap: the fallback (no fully safe spot) is the
		// candidate covered by the fewest other hazards, then the least exposed
		// walk, then the nearest. O(26 candidates x hazards x walk samples).
		bool haveLeast = false;
		AIFloat3 least;
		int leastExp = std::numeric_limits<int>::max(), leastWalk = std::numeric_limits<int>::max();
		float leastSq = std::numeric_limits<float>::max();
		auto exposure = [&hazards, except](const AIFloat3& p) {
			int n = 0;
			for (const SSnipeHazard& h : hazards) {
				if ((h.id != except) && (p.SqDistance2D(h.pos) < h.sqReach)) ++n;
			}
			return n;
		};
		for (float ring : {1.f, 0.85f}) {
			for (int k = 0; k <= 12; ++k) {
				const float off = ((k + 1) / 2) * (3.14159265f / 12.f) * ((k % 2 == 0) ? 1.f : -1.f);
				AIFloat3 c(aim.x + std::cos(base + off) * radius * ring, 0.f, aim.z + std::sin(base + off) * radius * ring);
				CTerrainManager::CorrectPosition(c);
				if (!terrain->CanMoveToPos(unit->GetArea(), c)) continue;
				const float sq = pos.SqDistance2D(c);
				if (sq > SQUARE(maxWalk)) continue;
				if (safeAt(c, except, false) && walkSafe(pos, c, except)) {
					if (sq < bestSq) { bestSq = sq; out = c; found = true; }
					continue;
				}
				if (strict || found) continue;
				const int e = exposure(c);
				int w = 0;
				const int n = std::max(1, int(std::sqrt(sq) / 100.f));
				for (int i = 1; i <= n; ++i) {
					const float t = float(i) / n;
					if (exposure(AIFloat3(pos.x + (c.x - pos.x) * t, 0.f, pos.z + (c.z - pos.z) * t)) > 0) ++w;
				}
				if ((e < leastExp) || ((e == leastExp) && ((w < leastWalk) || ((w == leastWalk) && (sq < leastSq))))) {
					least = c; leastExp = e; leastWalk = w; leastSq = sq; haveLeast = true;
				}
			}
		}
		if (!found && !strict && haveLeast) {
			out = least;
			found = true;
		}
		if (!found && !strict) {
			out = AIFloat3(aim.x + std::cos(base) * radius, 0.f, aim.z + std::sin(base) * radius);
			CTerrainManager::CorrectPosition(out);
			found = true;
		}
		return found;
	};
	// Orders: move to the spot (when needed), then the attack queued behind it.
	// Re-sent every 8 s or when the aim changes; a seen target is attacked
	// (it is followed by the engine), a ghost gets ground fire on its spot.
	auto issue = [&](const CEnemyUnit* aim, bool ghost, bool move, int key) {
		if ((key == st.orderKey) && (frame < st.orderUntil)) return;
		st.orderKey = key;
		st.orderUntil = frame + FRAMES_PER_SEC * 8;
		const int timeout = frame + FRAMES_PER_SEC * 12;
		if (unit->GetTravelAct() != nullptr) unit->GetTravelAct()->StateWait();
		TRY_UNIT(circuit, unit,
			short opts = UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY;
			if (move) {
				unit->CmdMoveTo(st.spot, 0, timeout);
				opts |= UNIT_COMMAND_OPTION_SHIFT_KEY;
			}
			if (!ghost && (aim->GetUnit() != nullptr)) {
				unit->GetUnit()->Attack(aim->GetUnit(), opts, timeout);
			} else {
				unit->CmdAttackGround(aim->GetPos(), opts, timeout);
			}
		)
	};
	auto stop = [&]() {
		st.orderKey = -1;
		TRY_UNIT(circuit, unit,
			unit->CmdStop();
		)
	};

	if (st.stage == 1) {
		// Already inside a threat's reach and within snipe range of it (it was
		// revealed late): exposed anyway, so snipe now. Inside but farther out:
		// the prep spots below lead it back out first (test: 4 of 8 units that
		// sniped alone from inside died).
		if (!safeAt(pos, -1, true)
			&& (pos.SqDistance2D(threat->GetPos()) <= SQUARE(range * info.snipeFraction + 16.f)))
		{
			circuit->LOG("SNIPE: %s %i already within range of %s %i inside its reach, snipes now",
					cdef->GetDef()->GetName(), unit->GetId(), SnipeName(threat), st.threat);
			st.stage = 2;
			st.go = true;
			st.volleys = 0;
			st.stageFrame = frame;
			st.target = -1;
		}
	}
	while (st.stage == 1) {
		const CEnemyUnit* target = (st.target >= 0) ? enemyMgr->GetEnemyUnit(st.target) : nullptr;
		if (target != nullptr) {
			const bool seen = target->IsInRadarOrLOS();
			const char* why = nullptr;
			if (!SnipeAlive(target)) {
				why = "destroyed";
			} else if (!seen && (GhostGoneWhy(circuit, st.target) != nullptr)) {
				why = "ghost gone (seen empty or wreck)";  // owner 16:57Z: no salvo at a wreck
				st.targetGhost = false;  // gone: not kept as a done ghost
				TRY_UNIT(circuit, unit,
					unit->CmdStop();
				)
			} else {
				if (!st.targetGhost && !seen) {
					st.targetGhost = true;  // lost from radar and LOS: the ghost rule from here
					st.volleys = 0;
				} else if (st.targetGhost && seen) {
					st.targetGhost = false;  // shown again: shoot until dead
				}
				// owner 20:08Z: a ghost prep target gets 3 if heavy, else 1
				const int cap = st.targetGhost ? GhostNeedFor(info, target->GetCircuitDef(), cdef) : info.visibleMaxVolleys;  // 0: until dead
				if ((cap > 0) && (st.volleys >= cap)) why = st.targetGhost ? "ghost volleys fired" : "volley cap";
				else if (st.drifts >= 2) why = "cannot be hit from outside the threats' reach";
				else if (frame - std::max(st.targetFrame, st.lastVolley) > info.stageFrames) why = "no volley, gives up";
			}
			if (why != nullptr) {
				circuit->LOG("SNIPE: %s %i prep %s %i %s (%i volleys)", cdef->GetDef()->GetName(), unit->GetId(),
						SnipeName(target), st.target, why, st.volleys);
				st.skipUntil[st.target] = frame + info.repeatFrames;
				if (st.targetGhost) GhostDoneSet(st, target);  // a dead one stays a ghost: once is enough
				st.target = -1;
				target = nullptr;
			}
		}
		if (target == nullptr) {
			// Next prep target: seen / radar first, then ghosts; nearest spot.
			const CEnemyUnit* best = nullptr;
			AIFloat3 bestSpot;
			bool bestSeen = false;
			float bestSq = std::numeric_limits<float>::max();
			const float prepRadius = range * info.prepFraction;
			for (const auto& kv : enemyMgr->GetEnemyUnits()) {
				const CEnemyUnit* e = kv.second;
				if (!SnipeAlive(e) || (info.porc.count(e->GetCircuitDef()->GetId()) == 0)
					|| (info.threats.count(e->GetCircuitDef()->GetId()) > 0)  // a threat gets its own snipe
					|| (e->IsInRadarOrLOS() && e->IsBeingBuilt())
					|| (e->GetPos().SqDistance2D(threat->GetPos()) > SQUARE(info.porcRadius))
					|| skipped(e->GetId()))
				{
					continue;
				}
				const bool seen = e->IsInRadarOrLOS();
				if (seen) GhostSeen(st, e->GetId());  // owner 2026-11-04 20:08Z: radar or LOS resets
				else if (GhostDoneHas(st, e)) continue;
				if (bestSeen && !seen) continue;
				AIFloat3 spot;
				if ((pos.SqDistance2D(e->GetPos()) <= SQUARE(prepRadius)) && safeAt(pos, e->GetId(), false)) {
					spot = pos;  // already a safe firing spot
				} else if (!findSpot(e->GetPos(), prepRadius, e->GetId(), true, spot, rangeOf(e, prepRadius))) {
					continue;  // cannot be shot from outside the threats' reach
				}
				const float sq = pos.SqDistance2D(spot);
				if ((seen && !bestSeen) || (sq < bestSq)) {
					best = e;
					bestSpot = spot;
					bestSq = sq;
					bestSeen = seen;
				}
			}
			if (best == nullptr) {
				circuit->LOG("SNIPE: %s %i no safe prep porc left, closes on %s %i", cdef->GetDef()->GetName(),
						unit->GetId(), SnipeName(threat), st.threat);
				st.stage = 2;
				st.volleys = 0;
				st.stageFrame = frame;
				break;
			}
			st.target = best->GetId();
			st.targetGhost = !bestSeen;
			st.targetFrame = frame;
			st.volleys = 0;
			st.spot = bestSpot;
			st.orderKey = -1;
			st.drifts = 0;
			st.drifting = false;
			circuit->LOG("SNIPE: %s %i prep %s %s %i at (%.0f, %.0f) from (%.0f, %.0f), %.0f to walk",
					cdef->GetDef()->GetName(), unit->GetId(), bestSeen ? "attacks" : "fires on ghost",
					SnipeName(best), best->GetId(), best->GetPos().x, best->GetPos().z,
					bestSpot.x, bestSpot.z, std::sqrt(bestSq));
			target = best;
		}
		const bool inRange = pos.SqDistance2D(target->GetPos()) <= SQUARE(range * info.prepFraction + 16.f);
		// Slid into a threat's reach (the engine walks a unit closer when 3D
		// range falls short): back to the spot; the second time, give it up.
		const bool drift = !safeAt(pos, -1, true) && safeAt(st.spot, target->GetId(), false);
		if (drift && !st.drifting) {
			++st.drifts;
			circuit->LOG("SNIPE: %s %i slid into a threat's reach on prep %s %i, backs out (%i)",
					cdef->GetDef()->GetName(), unit->GetId(), SnipeName(target), st.target, st.drifts);
		}
		st.drifting = drift;
		const bool move = !inRange || !safeAt(pos, target->GetId(), false);
		issue(target, st.targetGhost, move, target->GetId() * 4 + (st.targetGhost ? 2 : 0) + (move ? 1 : 0));
		return true;
	}

	const bool threatSeen = threat->IsInRadarOrLOS();
	if ((st.stage == 2) && !st.go) {
		// Gather just outside the threat's reach and go in together, when its
		// reach is beyond the snipe spot. O(snipe states).
		const float reach = reachOf(threat->GetCircuitDef());
		// Owner 2026-11-03 20:53Z: double heavy. Every other live or ghost heavy
		// (threats + direct threats) within both weapon ranges of the aimed one:
		// weapon-range half-discs facing the hold point; a share above
		// double_heavy_overlap is double heavy. Shares cached per pair ~10 s.
		// O(known enemies + 480 per new pair).
		const CEnemyUnit* dhWith = nullptr;
		const float dhShare = DoubleHeavyShare(military, enemyMgr, threat,
				(st.spotFor == st.threat) ? st.spot : pos, frame, dhWith);
		const bool doubleHeavy = (dhWith != nullptr) && (dhShare > info.doubleHeavyOverlap);
		if ((dhWith != nullptr) && (st.dhLoggedFor != st.threat)) {
			st.dhLoggedFor = st.threat;
			circuit->LOG("SNIPE: %s %i on %s %i: %s %.2f with %s %i", cdef->GetDef()->GetName(), unit->GetId(),
					SnipeName(threat), st.threat, doubleHeavy ? "double heavy" : "single heavy, overlap",
					dhShare, SnipeName(dhWith), dhWith->GetId());
		}
		// Owner 2026-11-03 21:12Z: a single ghost is fired on by each unit on its
		// own (no gather, no minimum); only double-heavy ghosts gather, hold the
		// Thanatos/Arbiters outside and go in together with a synced volley.
		if ((range * info.snipeFraction >= reach) || !doubleHeavy) {
			st.go = true;  // shoots from outside its reach, or a single heavy: no need to gather
			st.syncWait = false;
		} else if (range < info.closeMinRange) {
			// Test round 8: released to the ordinary controller, these walked into
			// the threat anyway (4 of 4 lost). Hold outside its reach, on the side
			// with the least shared overlap, while a longer-ranged unit is on the
			// same threat; then let go. O(snipe states).
			bool others = false;
			for (const auto& kv : military->GetArtySnipeStates()) {
				const CMilitaryManager::SArtySnipeState& o = kv.second;
				if ((kv.first != unit->GetId()) && (o.threat == st.threat) && (o.stage != 0) && !o.holding
					&& (frame - o.lastCall <= FRAMES_PER_SEC * 10))
				{
					others = true;
					break;
				}
			}
			if (!others) {
				st.holding = false;
				return finish("outranged, no longer-ranged artillery on it");
			}
			const float holdRadius = reach + info.holdMargin;
			if (!st.holding || (st.spotFor != st.threat)) {
				st.holding = true;
				st.spotFor = st.threat;
				findSpot(threat->GetPos(), holdRadius, -1, false, st.spot, rangeOf(threat, holdRadius));
				st.orderKey = -1;
				circuit->LOG("SNIPE: %s %i outranged by %s %i, holds at (%.0f, %.0f) while longer-ranged artillery snipes it",
						cdef->GetDef()->GetName(), unit->GetId(), SnipeName(threat), st.threat, st.spot.x, st.spot.z);
			}
			if ((pos.SqDistance2D(st.spot) > SQUARE(100.f)) && ((st.orderKey != -7 - st.threat) || (frame >= st.orderUntil))) {
				st.orderKey = -7 - st.threat;
				st.orderUntil = frame + FRAMES_PER_SEC * 8;
				if (unit->GetTravelAct() != nullptr) unit->GetTravelAct()->StateWait();
				TRY_UNIT(circuit, unit,
					unit->CmdMoveTo(st.spot, 0, frame + FRAMES_PER_SEC * 12);
				)
			}
			return true;
		} else {
			const float holdRadius = reach + info.holdMargin;
			const float d = pos.distance2D(threat->GetPos());
			// Test round 8: units arriving from prep were already at the hold
			// radius, so the snipe spot below was never chosen and they went in
			// from their own side. Choose it once on entering this stage; only the
			// hold point on its line counts as gathered.
			const bool fresh = (st.spotFor != st.threat);
			const bool at = !fresh && safeAt(pos, -1, true) && (d <= holdRadius + 250.f)
				&& (pos.SqDistance2D(st.spot) <= SQUARE(300.f));
			st.atHold = at;
			// Owner 2026-11-04 15:23Z: from the first trigger on, every 0.5 s until
			// the go-in, launchers within recruit_radius of the gather point or of this
			// (triggered) unit join: the least-overlap gather point can be on the
			// far side of the threat (test 11-04: two near-side Ambassadors missed).
			// Only a unit that triggered itself recruits (test 11-04: recruits that
			// recruited chained the radius across the map).
			if (!fresh && !st.recruited && (frame >= st.recruitScan)) {
				st.recruitScan = frame + FRAMES_PER_SEC / 2;
				int squad = 0;
				const int n = RecruitArtillery(circuit, {st.spot, pos}, st.threat, st.direct, false, -1, frame, squad);
				if (n > 0) {
					circuit->LOG("SNIPE: %s %i recruits %i within %.0f for %s %i (squad %i)", cdef->GetDef()->GetName(),
							unit->GetId(), n, info.recruitRadius, SnipeName(threat), st.threat, squad);
				}
			}
			if (!at) {
				st.holdSince = -1;
				if (fresh || (st.orderKey != -5 - st.threat)) {
					// Round 6: the threat pick found a clear snipe spot (maybe behind
					// the threat) but the group gathered and went in on its own side,
					// through the other threat's reach. Gather on the line out from the
					// checked snipe spot instead; else as before. Owner 16:30Z: with
					// no fully safe spot, the side with the least shared overlap.
					st.spotFor = st.threat;
					const float snipeR2 = range * info.snipeFraction;
					st.hasSnipeSpot = findSpot(threat->GetPos(), snipeR2, threat->GetId(), false, st.snipeSpot,
							rangeOf(threat, snipeR2));
					bool placed = false;
					if (st.hasSnipeSpot) {
						const AIFloat3& tp = threat->GetPos();
						const float dx = st.snipeSpot.x - tp.x, dz = st.snipeSpot.z - tp.z;
						const float len = std::sqrt(dx * dx + dz * dz);
						if (len > 1.f) {
							AIFloat3 h(tp.x + dx / len * holdRadius, 0.f, tp.z + dz / len * holdRadius);
							CTerrainManager::CorrectPosition(h);
							if (terrain->CanMoveToPos(unit->GetArea(), h) && safeAt(h, -1, false)) {
								st.spot = h;
								placed = true;
							}
						}
					}
					if (!placed) findSpot(threat->GetPos(), holdRadius, -1, false, st.spot, rangeOf(threat, holdRadius));
					// Diagnostic (test round 7: no unit used a far-side spot): once per gather order.
					circuit->LOG("SNIPE: %s %i spot for %s %i: snipe %s (%.0f, %.0f), hold %s (%.0f, %.0f), unit at (%.0f, %.0f)",
							cdef->GetDef()->GetName(), unit->GetId(), SnipeName(threat), st.threat,
							st.hasSnipeSpot ? "least-overlap" : "none", st.hasSnipeSpot ? st.snipeSpot.x : 0.f,
							st.hasSnipeSpot ? st.snipeSpot.z : 0.f, placed ? "on its line" : "fallback",
							st.spot.x, st.spot.z, pos.x, pos.z);
				}
				if ((st.orderKey != -5 - st.threat) || (frame >= st.orderUntil)) {
					st.orderKey = -5 - st.threat;
					st.orderUntil = frame + FRAMES_PER_SEC * 8;
					if (unit->GetTravelAct() != nullptr) unit->GetTravelAct()->StateWait();
					TRY_UNIT(circuit, unit,
						unit->CmdMoveTo(st.spot, 0, frame + FRAMES_PER_SEC * 12);
					)
				}
				return true;
			}
			if (st.holdSince < 0) {
				st.holdSince = frame;
				circuit->LOG("SNIPE: %s %i gathers %.0f from %s %i", cdef->GetDef()->GetName(), unit->GetId(),
						d, SnipeName(threat), st.threat);
			}
			int members = 0, gathered = 0, going = 0;
			int firstGo = std::numeric_limits<int>::max();  // when the group already going in left
			int settledSince = st.holdSince;  // when the last gatherer arrived
			for (const auto& kv : military->GetArtySnipeStates()) {
				const CMilitaryManager::SArtySnipeState& o = kv.second;
				if ((o.threat != st.threat) || (o.stage == 0) || (frame - o.lastCall > FRAMES_PER_SEC * 10)) continue;
				++members;
				if ((o.stage >= 2) && o.go) {
					++going;
					firstGo = std::min(firstGo, o.goFrame);
				} else if ((o.stage == 2) && o.atHold) {
					++gathered;
					settledSince = std::max(settledSince, o.holdSince);
				}
			}
			// Test round 3: min_group of gathered+going let part of the group in
			// while the rest was still on prep. Now: everyone on the threat
			// gathered (and settled), or past group_wait_seconds min_group
			// gathered; late arrivals join a group already going in.
			const int need = std::min(info.minGroup, members);
			const bool allGathered = (gathered >= members);
			const bool settled = (frame - settledSince >= info.groupSettleFrames);
			const bool waitOver = (frame - st.holdSince >= info.groupWaitFrames);
			// Double heavy (port of the cluster-branch 5e482338 rule): at least 3
			// gathered, the whole gathered group goes in together (they join within
			// 5 s of the first leaving); no lone or late single; fewer than 3 after
			// group_wait gives the threat up. Otherwise exactly as before.
			const int doubleMin = 3;
			const bool groupLeaving = (going > 0) && (frame - firstGo <= FRAMES_PER_SEC * 5)
				&& (gathered + going >= doubleMin);
			const bool go = doubleHeavy
				? (groupLeaving || ((gathered >= doubleMin) && ((allGathered && settled) || waitOver)))
				: ((going > 0) || (allGathered && (settled || members == 1)) || (waitOver && (gathered >= need)));
			if (!go) {
				if (waitOver) {
					return finish(doubleHeavy ? "double heavy, fewer than 3 gathered" : "too few gathered to go in");
				}
				if (st.orderKey != -6 - st.threat) {
					st.orderKey = -6 - st.threat;
					TRY_UNIT(circuit, unit,
						unit->CmdStop();
					)
				}
				return true;  // others still on their way or on prep porc
			}
			// Owner 2026-11-03 21:58Z recruitment: when the group leaves, every
			// Boreas/Negotiator/Ambassador of this AI within recruit_radius of
			// the hold point or of a gathered member, not already on this
			// threat, joins it (pulled off its default target) and the synced
			// volley. O(team units x group) once per go-in.
			if (going == 0) {
				std::vector<AIFloat3> anchors{st.spot};
				for (const auto& kv : military->GetArtySnipeStates()) {
					const CMilitaryManager::SArtySnipeState& o = kv.second;
					if ((o.threat != st.threat) || (o.stage != 2) || !o.atHold) continue;
					CCircuitUnit* m = circuit->GetTeamUnit(kv.first);
					if (m != nullptr) anchors.push_back(m->GetPos(frame));
				}
				int squad = 0;
				const int n = RecruitArtillery(circuit, anchors, st.threat, st.direct, true, frame, frame, squad);
				circuit->LOG("SNIPE: %s %i recruits %i within %.0f for %s %i (squad %i)", cdef->GetDef()->GetName(),
						unit->GetId(), n, info.recruitRadius, SnipeName(threat), st.threat, squad);
			}
			st.go = true;
			st.goFrame = frame;
			st.syncWait = true;  // owner 21:04Z: walk in with fire held, one synced volley
			st.atSpot = false;
			st.hitFrame = -1;
			st.stageFrame = frame;
			st.volleys = 0;
			st.orderKey = -1;
			circuit->LOG("SNIPE: %s %i goes in on %s %i: %i gathered, %i going, %i on it%s", cdef->GetDef()->GetName(),
					unit->GetId(), SnipeName(threat), st.threat, gathered, going, members,
					doubleHeavy ? " (double heavy)" : "");
		}
	}
	if (st.stage == 2) {
		// A seen direct threat (Pulsar, Bulwark, Bastion) is attacked until dead
		// (visible_max_volleys 0); "gone" ends it.
		const bool untilDead = st.direct && threatSeen;
		if (untilDead && (info.visibleMaxVolleys > 0) && (st.volleys >= info.visibleMaxVolleys)) {
			stop();
			return finish("volley cap on a seen porc");
		}
		if (!untilDead && (st.volleys >= info.volleys)) {
			stop();
			st.stage = 3;
			st.stageFrame = frame;
			circuit->LOG("SNIPE: %s %i fired %i volleys at %s %i (%s), checks it",
					cdef->GetDef()->GetName(), unit->GetId(), st.volleys, SnipeName(threat), st.threat,
					threatSeen ? "visible" : "ghost");
			return true;
		}
		if (frame - std::max(st.stageFrame, st.lastVolley) > info.stageFrames) {
			return finish("no volley, gives up");
		}
		const float snipeRange = range * info.snipeFraction;
		if (st.orderKey != -2 - st.threat) {
			// Firing spot once per stage: the checked one from gathering, else
			// outside other threats if possible.
			if (st.hasSnipeSpot) st.spot = st.snipeSpot;
			else findSpot(threat->GetPos(), snipeRange, threat->GetId(), false, st.spot, rangeOf(threat, snipeRange));
		}
		const bool move = pos.SqDistance2D(threat->GetPos()) > SQUARE(snipeRange + 16.f);
		if (st.syncWait) {
			// Owner 2026-11-03 21:04Z: the gathered group walks to its spots with
			// fire held and opens fire in one frame once all are in range, after
			// 20 s, or when any of them is hit, so the shells land together.
			// Group = units on this threat released within 10 s of each other.
			// O(snipe states) per waiting unit per call.
			st.atSpot = !move;
			const float hp = unit->GetHealthPercent();
			if ((st.lastHp >= 0.f) && (hp < st.lastHp - 0.001f)) st.hitFrame = frame;
			st.lastHp = hp;
			bool allIn = true, hit = (st.hitFrame >= st.goFrame);
			int n = 0;
			for (const auto& kv : military->GetArtySnipeStates()) {
				const CMilitaryManager::SArtySnipeState& o = kv.second;
				if ((o.threat != st.threat) || (o.stage != 2) || !o.syncWait || (frame - o.lastCall > FRAMES_PER_SEC * 10)
					|| (std::abs(o.goFrame - st.goFrame) > FRAMES_PER_SEC * 10)) continue;
				++n;
				allIn = allIn && o.atSpot;
				hit = hit || (o.hitFrame >= o.goFrame);
			}
			if (!allIn && !hit && (frame - st.goFrame < FRAMES_PER_SEC * 20)) {
				if (!st.fireHeld) {
					st.fireHeld = true;
					unit->TrySetFireState(CCircuitDef::FireType::HOLD);
				}
				const int key = move ? (-8 - st.threat) : (-9 - st.threat);
				if ((st.orderKey != key) || (move && (frame >= st.orderUntil))) {
					st.orderKey = key;
					st.orderUntil = frame + FRAMES_PER_SEC * 8;
					if (unit->GetTravelAct() != nullptr) unit->GetTravelAct()->StateWait();
					TRY_UNIT(circuit, unit,
						if (move) unit->CmdMoveTo(st.spot, 0, frame + FRAMES_PER_SEC * 12);
						else unit->CmdStop();
					)
				}
				return true;
			}
			// Release: every unit of the group fires in this frame.
			circuit->LOG("SNIPE: %s %i synced volley on %s %i: %i units%s", cdef->GetDef()->GetName(), unit->GetId(),
					SnipeName(threat), st.threat, n, hit ? " (one was hit)" : (allIn ? "" : " (20 s)"));
			const int goGroup = st.goFrame;
			// Ids first: GetArtySnipeState may prune the map being iterated.
			std::vector<int> members;
			for (const auto& kv : military->GetArtySnipeStates()) {
				const CMilitaryManager::SArtySnipeState& o = kv.second;
				if ((o.threat != st.threat) || (o.stage != 2) || !o.syncWait || (frame - o.lastCall > FRAMES_PER_SEC * 10)
					|| (std::abs(o.goFrame - goGroup) > FRAMES_PER_SEC * 10) || (kv.first == unit->GetId())) continue;
				members.push_back(kv.first);
			}
			for (const int id : members) {
				CCircuitUnit* u = circuit->GetTeamUnit(id);
				if (u == nullptr) continue;
				CMilitaryManager::SArtySnipeState& os = military->GetArtySnipeState(id, frame);
				os.syncWait = false;
				os.orderKey = -2 - st.threat;
				os.orderUntil = frame + FRAMES_PER_SEC * 8;
				if (os.fireHeld) {
					os.fireHeld = false;
					u->TrySetFireState(u->GetCircuitDef()->GetFireState());
				}
				const bool uMove = !os.atSpot;
				const int timeout = frame + FRAMES_PER_SEC * 12;
				if (u->GetTravelAct() != nullptr) u->GetTravelAct()->StateWait();
				TRY_UNIT(circuit, u,
					short opts = UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY;
					if (uMove) {
						u->CmdMoveTo(os.spot, 0, timeout);
						opts |= UNIT_COMMAND_OPTION_SHIFT_KEY;
					}
					if (threatSeen && (threat->GetUnit() != nullptr)) {
						u->GetUnit()->Attack(threat->GetUnit(), opts, timeout);
					} else {
						u->CmdAttackGround(threat->GetPos(), opts, timeout);
					}
				)
			}
			st.syncWait = false;
			st.orderKey = -1;
			if (st.fireHeld) {
				st.fireHeld = false;
				unit->TrySetFireState(cdef->GetFireState());
			}
		}
		issue(threat, !threatSeen, move, -2 - st.threat);
		return true;
	}
	if (st.stage == 3) {
		if ((frame - std::max(st.stageFrame, st.lastVolley) < info.confirmFrames) && !threatSeen) {
			return true;  // shells still landing
		}
		if (!threatSeen) {
			GhostDoneSet(st, threat);  // not again while it stays a ghost
			return finish("not seen alive after the volleys");
		}
		circuit->LOG("SNIPE: %s %i sees %s %i live, attacks it until dead", cdef->GetDef()->GetName(), unit->GetId(),
				SnipeName(threat), st.threat);
		st.stage = 4;
		st.volleys = 0;
		st.targetGhost = false;
		st.stageFrame = frame;
		st.orderKey = -1;
	}
	if (st.stage == 4) {
		// Owner 02:06Z: live (radar or LOS now) after the ghost volleys: attacked
		// until dead ("gone" ends it). Back to a ghost: `volleys` more, then done
		// and not again while it stays a ghost.
		if (!threatSeen && !st.targetGhost) {
			st.targetGhost = true;
			st.volleys = 0;
			circuit->LOG("SNIPE: %s %i lost %s %i to a ghost again, fires %i more", cdef->GetDef()->GetName(),
					unit->GetId(), SnipeName(threat), st.threat, info.volleys);
		} else if (threatSeen && st.targetGhost) {
			st.targetGhost = false;  // live again: until dead
		}
		if (st.targetGhost && (st.volleys >= info.volleys)) {
			stop();
			GhostDoneSet(st, threat);
			return finish("ghost volleys fired after it went dark again");
		}
		if (frame - std::max(st.stageFrame, st.lastVolley) > info.stageFrames) {
			return finish("confirm: no volley, gives up");
		}
		const float snipeRange = range * info.snipeFraction;
		const bool move = pos.SqDistance2D(threat->GetPos()) > SQUARE(snipeRange + 16.f);
		const int key = -3 - st.threat * 2 - (threatSeen ? 0 : 1);  // re-aims at once on live <-> ghost
		if (move && (st.orderKey != key)) {
			if (st.hasSnipeSpot) st.spot = st.snipeSpot;
			else findSpot(threat->GetPos(), snipeRange, threat->GetId(), false, st.spot, rangeOf(threat, snipeRange));
		}
		issue(threat, !threatSeen, move, key);
		return true;
	}
	return false;
}

bool CArtilleryTask::FireAtGhost(CCircuitUnit* unit, const AIFloat3& pos, int frame)
{
	return GhostFireStep(manager->GetCircuit(), unit, pos, frame, ghostFire[unit->GetId()], ghostSupport);
}

CEnemyInfo* CArtilleryTask::FindTarget(CCircuitUnit* unit, const AIFloat3& pos)
{
	CCircuitAI* circuit = manager->GetCircuit();
	CThreatMap* threatMap = circuit->GetThreatMap();
	CCircuitDef* cdef = unit->GetCircuitDef();
	const bool notAW = !cdef->HasSurfToWater();
	const int canTargetCat = cdef->GetTargetCategory();
	const int noChaseCat = cdef->GetNoChaseCategory();
	float range = cdef->GetMaxRange();
	float minSqDist = SQUARE(range);

	enemyPositions.clear();
	threatMap->SetThreatType(unit);
	// 2026-11-06 Task C: Ambassador/Negotiator/Boreas use the real reach of known
	// armed enemies, not the padded threat map (which parked them idle at ~110%).
	bool isPosSafe = IsSlowMissileLauncher(cdef->GetDef()->GetName())
			? !ArtyUnsafeHere(circuit, unit, pos, circuit->GetLastFrame())
			: ((threatMap->GetThreatAt(pos) <= THREAT_MIN) || cdef->IsPlane());

	const CCircuitAI::EnemyInfos& enemies = circuit->GetEnemyInfos();
	if (isPosSafe) {
		// Трубка 15, прицел 120, бац, бац …и мимо!
		float maxThreat = .0f;
		CEnemyInfo* bestTarget = nullptr;
		CEnemyInfo* mediumTarget = nullptr;
		CEnemyInfo* worstTarget = nullptr;
		// Owner 2026-11-01: a stationary or slow enemy commander in range is shot
		// before any structure (see SArtyCommInfo). Same O(enemies) loop.
		const CMilitaryManager::SArtyCommInfo& artyComm = circuit->GetMilitaryManager()->GetArtyCommInfo();
		const bool commTargets = artyComm.isEnabled && (artyComm.defs.count(cdef->GetId()) > 0);
		CEnemyInfo* commTarget = nullptr;
		float commSqDist = SQUARE(range);
		// Then a heavy unit (Fatboy, Tzar, ...) moving at most a fraction of its
		// own top speed, still ahead of every structure.
		CEnemyInfo* heavyTarget = nullptr;
		float heavySqDist = SQUARE(range);
		// Owner 2026-11-03 21:36Z: for the artillery_snipe units of at least
		// close_in_min_range (Boreas, Negotiator, Ambassador) ghost images of
		// structures are targets too, in the same order as everything else; each
		// gets `volleys` blind volleys (counted in ArtySnipeStep), then waits for
		// a fresh LOS sighting. Same O(enemies) loop.
		CMilitaryManager* military = circuit->GetMilitaryManager();
		const CMilitaryManager::SArtySnipeInfo& snipeInfo = military->GetArtySnipeInfo();
		// 2026-11-07: Arbiter too (IsGhostPickLauncher), same 3/1 volley rule.
		CMilitaryManager::SArtySnipeState* ghostSt = ArtyGhostPicker(snipeInfo, cdef)
				? &military->GetArtySnipeState(unit->GetId(), circuit->GetLastFrame()) : nullptr;
		// 2026-11-07 (@Barscrewl): known (LOS / radar) targets first; ghosts only in a
		// second pass when no known target is in range (Arbiter, Vanguard: a ghost
		// never beats a known target by builder role or power). O(2 x enemies).
		for (int pass = 0; pass < 2; ++pass) {
		if ((pass == 1) && ((ghostSt == nullptr) || (bestTarget != nullptr) || (commTarget != nullptr)
			|| (heavyTarget != nullptr) || (mediumTarget != nullptr) || (worstTarget != nullptr))) break;
		for (auto& kv : enemies) {
			CEnemyInfo* enemy = kv.second;
			if ((pass == 0) && (ghostSt != nullptr) && enemy->IsInRadarOrLOS()) {
				GhostSeen(*ghostSt, enemy->GetId());  // a fresh sighting (radar or LOS) resets its blind volleys
			}
			const bool ghost = !enemy->IsInRadarOrLOS();
			if (ghost != (pass == 1)) continue;
			if (enemy->IsHidden()
                || (enemy->IsInRadarOrLOS() && !MissileTargetAllowed(cdef, enemy))
				|| (ghost && ((ghostSt == nullptr) || (enemy->GetCircuitDef() == nullptr) || enemy->GetCircuitDef()->IsMobile()
					|| enemy->GetData()->IsDying() || enemy->GetData()->IsDead()
					|| GhostDoneHas(*ghostSt, enemy->GetData())))
				|| (notAW && (enemy->GetPos().y < -SQUARE_SIZE * 5)))
			{
				continue;
			}

			CCircuitDef* edef = enemy->GetCircuitDef();
			if (commTargets && (edef != nullptr) && edef->IsRoleComm()
				&& ((edef->GetCategory() & canTargetCat) != 0)
				&& (enemy->GetVel().SqLength2D() <= artyComm.maxSqSpeed))
			{
				const float sqDist = pos.SqDistance2D(enemy->GetPos());
				if (sqDist < commSqDist) {
					commTarget = enemy;
					commSqDist = sqDist;
				}
				continue;
			}
			if (commTargets && (edef != nullptr) && ((edef->GetCategory() & canTargetCat) != 0)) {
				auto it = artyComm.heavyMaxSqSpeed.find(edef->GetId());
				if ((it != artyComm.heavyMaxSqSpeed.end()) && (enemy->GetVel().SqLength2D() <= it->second)) {
					const float sqDist = pos.SqDistance2D(enemy->GetPos());
					if (sqDist < heavySqDist) {
						heavyTarget = enemy;
						heavySqDist = sqDist;
					}
					continue;
				}
			}
			// Owner 2026-11-07 (priority_min_tech, Thanatos/Vanguard): an identified
			// T2/T3 mobile in radar or LOS joins the structures in the same pick
			// (siege hulls included); T1 mobiles stay engine auto-fire only.
			const bool prioMobile = (edef != nullptr) && edef->IsMobile() && !ghost && cdef->IsPriorityTarget(edef);
			if ((edef == nullptr) || (edef->IsMobile() && !prioMobile) || (edef->IsAttrSiege() && !prioMobile)
				|| circuit->GetCircuitDef(edef->GetId())->IsIgnore())
			{
				continue;
			}
			int targetCat = edef->GetCategory();
			if ((targetCat & canTargetCat) == 0) {
				continue;
			}

			const float sqDist = pos.SqDistance2D(enemy->GetPos());
			if ((sqDist < minSqDist) && ghost && GhostGone(circuit, enemy->GetId())) {
				continue;  // owner 16:57Z: its wreck (or empty spot) is seen: no salvo
			}
			if (sqDist < minSqDist) {
				if (edef->IsEnemyRoleAny(CCircuitDef::RoleMask::BUILDER)) {
					bestTarget = enemy;
					minSqDist = sqDist;
					maxThreat = std::numeric_limits<float>::max();
				} else if (edef->GetPower() > maxThreat) {
					bestTarget = enemy;
					minSqDist = sqDist;
					maxThreat = edef->GetPower();
				} else if (bestTarget == nullptr) {
					if ((targetCat & noChaseCat) == 0) {
						mediumTarget = enemy;
					} else if (mediumTarget == nullptr) {
						worstTarget = enemy;
					}
				}
				continue;
			}

			if ((targetCat & noChaseCat) != 0) {
				continue;
			}
//			if (sqDist < SQUARE(2000.f)) {  // maxSqDist
				enemyPositions.push_back(enemy->GetPos());
//			}
		}
		}  // pass
		if (commTarget != nullptr) {
			bestTarget = commTarget;
		} else if (heavyTarget != nullptr) {
			bestTarget = heavyTarget;
		} else if (bestTarget == nullptr) {
			bestTarget = (mediumTarget != nullptr) ? mediumTarget : worstTarget;
		}
		if (bestTarget != nullptr) {
			position = bestTarget->GetPos();
			return bestTarget;
		}
	} else {
		// Avoid closest units and choose safe position
		for (auto& kv : enemies) {
			CEnemyInfo* enemy = kv.second;
			if (enemy->IsHidden()
                || (enemy->IsInRadarOrLOS() && !MissileTargetAllowed(cdef, enemy))
				|| !enemy->IsInRadarOrLOS()
				|| (notAW && (enemy->GetPos().y < -SQUARE_SIZE * 5)))
			{
				continue;
			}

			CCircuitDef* edef = enemy->GetCircuitDef();
			if ((edef == nullptr) || edef->IsMobile()
				|| circuit->GetCircuitDef(edef->GetId())->IsIgnore())
			{
				continue;
			}
			int targetCat = edef->GetCategory();
			if (((targetCat & canTargetCat) == 0)
				|| ((targetCat & noChaseCat) != 0))
			{
				continue;
			}

			const float sqDist = pos.SqDistance2D(enemy->GetPos());
			if (sqDist < minSqDist) {
				continue;
			}

//			if (sqDist < SQUARE(2000.f)) {  // maxSqDist
				enemyPositions.push_back(enemy->GetPos());
//			}
		}
	}

	if (enemyPositions.empty()) {
		return nullptr;
	}

	return nullptr;
	// Return: <target>, startPos=pos, enemyPositions
}

void CArtilleryTask::ApplyTargetPath(const CQueryPathMulti* query)
{
	const std::shared_ptr<CPathInfo>& pPath = query->GetPathInfo();
	CCircuitUnit* unit = query->GetUnit();

	if (!pPath->posPath.empty()) {
		if (manager->GetCircuit()->GetThreatMap()->GetThreatAt(pPath->posPath.back()) > THREAT_MIN) {
			FallbackSafePos(unit);
		} else {
			position = pPath->posPath.back();
			if (unit->GetTravelAct() != nullptr) unit->GetTravelAct()->SetPath(pPath);
		}
	} else {
		FallbackSafePos(unit);
	}
}

void CArtilleryTask::FallbackSafePos(CCircuitUnit* unit)
{
	CCircuitAI* circuit = manager->GetCircuit();
	circuit->GetMilitaryManager()->FillSafePos(unit, urgentPositions);
	if (urgentPositions.empty()) {
		Fallback(unit, false);
		return;
	}

	const AIFloat3& startPos = unit->GetPos(circuit->GetLastFrame());
	const float pathRange = DEFAULT_SLACK * 4;

	CPathFinder* pathfinder = circuit->GetPathfinder();
	std::shared_ptr<IPathQuery> query = pathfinder->CreatePathMultiQuery(
			unit, circuit->GetThreatMap(),
			startPos, pathRange, urgentPositions);
	pathQueries[unit] = query;

	pathfinder->RunQuery(circuit->GetScheduler().get(), query, [this](const IPathQuery* query) {
		this->ApplySafePos(static_cast<const CQueryPathMulti*>(query));
	});
}

void CArtilleryTask::ApplySafePos(const CQueryPathMulti* query)
{
	const std::shared_ptr<CPathInfo>& pPath = query->GetPathInfo();
	CCircuitUnit* unit = query->GetUnit();

	const bool proceed = pPath->path.size() > 2;
	if (proceed) {
		if (unit->GetTravelAct() != nullptr) unit->GetTravelAct()->SetPath(pPath);
	} else {
		Fallback(unit, proceed);
	}
}

void CArtilleryTask::Fallback(CCircuitUnit* unit, bool proceed)
{
	if (proceed) {
		return;
	}

	if ((unit->GetTravelAct() == nullptr) || (unit->GetTravelAct()->GetState() == IAction::State::WAIT)) {
		return;
	}
	unit->GetTravelAct()->StateWait();
	TRY_UNIT(manager->GetCircuit(), unit,
		unit->CmdStop();
	)
}

} // namespace circuit
