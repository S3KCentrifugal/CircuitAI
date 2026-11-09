#include "control/group/GroupMonitor.h"
#include "control/core/ControllerRegistry.h"
#include "control/core/UnitController.h"
#include "control/group/BattleGroupController.h"
#include "control/kernel/ActionWhy.h"
#include "module/MilitaryManager.h"
#include "task/fighter/FighterTask.h"
#include "task/fighter/RangedWorld.h"
#include "task/fighter/SquadTask.h"
#include "unit/CircuitDef.h"
#include "unit/CircuitUnit.h"
#include "CircuitAI.h"

#include "UnitDef.h"

#include <cstdio>
#include <string>

namespace circuit::monitor {

namespace {

// Names in the order of the enums they label (FighterTask.h, UnitTask.h,
// terrain/GroundCohort.h). An unknown value prints "?".
constexpr const char* FIGHT_NAMES[] = {"rally", "guard", "defend", "scout", "raid", "attack", "bomb", "melee",
	"arty", "aa", "ah", "support", "super", "route", "ferry", "wave", "engage"};
constexpr const char* TASK_NAMES[] = {"nil", "player", "idle", "wait", "retreat", "builder", "factory", "fighter"};
constexpr const char* MODE_NAMES[] = {"advance", "hold", "kite", "withdraw", "rush", "regroup"};
constexpr const char* REASON_NAMES[] = {"travel", "favorable", "hold_fire", "outmatched", "unreachable", "unknown",
	"static", "assemble", "siege", "rushed"};
static_assert(sizeof(FIGHT_NAMES) / sizeof(FIGHT_NAMES[0]) == size_t(IFighterTask::FightType::_SIZE_),
	"FIGHT_NAMES must follow IFighterTask::FightType");
// D-507 added SIEGE without a name here, so a siege printed "?": the last reason must have one.
static_assert(sizeof(REASON_NAMES) / sizeof(REASON_NAMES[0]) == size_t(cohort::Reason::RUSHED) + 1,
	"REASON_NAMES must follow cohort::Reason");

template<size_t N>
const char* NameOf(const char* const (&names)[N], int value)
{
	return (value >= 0 && value < int(N)) ? names[value] : "?";
}

// Fixed decimals keep the payload short and locale-free.
std::string Num(float value, int decimals)
{
	char buf[32];
	std::snprintf(buf, sizeof(buf), "%.*f", decimals, double(value));
	return buf;
}

void AppendMembers(std::string& out, const std::vector<int>& ids)
{
	for (size_t i = 0; i < ids.size(); ++i) {
		if (i > 0) out += ':';
		out += std::to_string(ids[i]);
	}
}

// Opaque, stable for the task's lifetime; only compared for equality by the widget.
std::string TaskId(const IUnitTask* task)
{
	char buf[32];
	std::snprintf(buf, sizeof(buf), "%p", static_cast<const void*>(task));
	return buf;
}

const char* Flag(bool value) { return value ? "1" : "0"; }

} // namespace

std::string DescribeGroups(CCircuitAI* ai, int minTaskMembers)
{
	const int frame = ai->GetLastFrame();
	std::string out = std::to_string(FORMAT_VERSION) + ";" + std::to_string(frame) + ";";

	if (const CBattleGroupController* groups = ai->GetBattleGroupController()) {
		for (const auto& l : groups->Snapshot()) {
			const auto& c = l.composition;
			out += "G," + std::to_string(l.key) + "," + l.templateName + "," + std::to_string(l.partner)
				+ "," + battle_group::Name(l.effective) + "," + battle_group::Name(l.script) + "," + battle_group::Name(l.internal)
				+ "," + battle_group::Name(l.screenStance) + "," + battle_group::Name(l.rearStance)
				+ "," + Num(l.spread, 2) + "," + Num(l.separation, 0)
				+ "," + Num(l.facing.x, 2) + "," + Num(l.facing.z, 2)
				+ "," + Flag(l.facingSet) + "," + Flag(l.scripted) + "," + Flag(l.standFirm)
				+ "," + std::to_string(l.screens) + "," + std::to_string(l.rears);
			for (int t = 0; t < int(battle_group::Threat::COUNT); ++t) out += "," + std::to_string(c.count[t]);
			const float age = (l.orderFrame >= 0) ? float(frame - l.orderFrame) / FRAMES_PER_SEC : -1.f;
			out += "," + Num(c.total, 0) + "," + Num(age, 0);
			// D-501: appended, so a format-2 reader of the first 25 fields still parses.
			out += "," + std::to_string(l.sizeTarget) + "," + std::to_string(l.sizeMax);
			out += "," + why::Hex(l.why);  // D-508: appended, the order's factors
			// D-509: appended, the anti-air need, its cap, the air HP held and the escorts.
			out += "," + std::to_string(l.airNeed) + "," + std::to_string(l.airCap) + "," + Num(l.airHeld, 0) + ",";
			AppendMembers(out, l.escortIds);
			out += ";";
		}
	}

	CMilitaryManager* military = ai->GetMilitaryManager();
	if (const CRangedWorld* world = military->PeekRangedWorld()) {
		for (const auto& [key, plan] : world->Cohorts()) {
			if (plan.members.empty()) continue;
			out += "C," + std::to_string(key) + "," + NameOf(MODE_NAMES, int(plan.mode))
				+ "," + NameOf(REASON_NAMES, int(plan.reason))
				+ "," + Num(plan.center.x, 0) + "," + Num(plan.center.z, 0) + "," + Num(plan.radius, 0)
				+ "," + Flag(plan.formationRear) + "," + std::to_string(plan.formationPartner)
				+ "," + Flag(plan.committed) + "," + Flag(plan.supporting) + "," + Flag(plan.sustainedRush)
				+ "," + Num(plan.ownValue, 0) + "," + Num(plan.hostileValue, 0) + "," + Num(plan.advantage, 2)
				+ "," + std::to_string(plan.target) + ",";
			AppendMembers(out, plan.members);
			out += "," + std::to_string(plan.recruitTarget);  // D-501: appended after the members
			// D-508: appended, the activity index and the plan's factors.
			out += "," + std::to_string(int(why::CohortActivity(plan.mode, plan.why))) + "," + why::Hex(plan.why) + ";";
		}
	}

	int listed = 0;
	std::vector<int> ids;
	for (int type = 0; type < int(IFighterTask::FightType::_SIZE_) && listed < MAX_TASK_RECORDS; ++type) {
		for (const IFighterTask* task : military->GetTasks(static_cast<IFighterTask::FightType>(type))) {
			const auto& units = task->GetAssignees();
			if (int(units.size()) < minTaskMembers) continue;
			if (++listed > MAX_TASK_RECORDS) break;
			ids.clear();
			for (const CCircuitUnit* u : units) ids.push_back(u->GetId());
			int leader = -1;
			if (const auto* squad = dynamic_cast<const ISquadTask*>(task)) {
				if (const CCircuitUnit* lead = squad->GetLeader()) leader = lead->GetId();
			}
			const auto& pos = task->GetPosition();
			out += "T," + TaskId(task) + "," + NameOf(FIGHT_NAMES, type) + "," + std::to_string(leader)
				+ "," + Num(pos.x, 0) + "," + Num(pos.z, 0) + "," + Num(task->GetAttackPower(), 0) + ",";
			AppendMembers(out, ids);
			out += ";";
		}
	}
	return out;
}

std::string DescribeUnit(CCircuitAI* ai, int unitId)
{
	const int frame = ai->GetLastFrame();
	std::string out = std::to_string(FORMAT_VERSION) + ";" + std::to_string(frame) + ";" + std::to_string(unitId) + ";";
	CCircuitUnit* unit = ai->GetTeamUnit(unitId);
	if (unit == nullptr || unit->IsDead()) return out + "missing=1";

	out += std::string("def=") + unit->GetCircuitDef()->GetDef()->GetName();
	out += ",health=" + Num(unit->GetHealthPercent(), 2);
	if (const IUnitTask* task = unit->GetTask()) {
		out += std::string(",task=") + NameOf(TASK_NAMES, int(task->GetType()));
		if (const auto* fighter = dynamic_cast<const IFighterTask*>(task)) {
			out += std::string(",fight=") + NameOf(FIGHT_NAMES, int(fighter->GetFightType()));
		}
		out += ",taskid=" + TaskId(task) + ",external=" + Flag(task->IsExternalControlled());
	}
	if (const CControllerRegistry* controllers = ai->GetControllers()) {
		const IUnitController* owner = controllers->OwnerOf(unit);
		out += std::string(",controller=") + (owner ? owner->Name() : "none");
	}

	int cohort = -1;
	if (const CRangedWorld* world = ai->GetMilitaryManager()->PeekRangedWorld()) {
		for (const auto& [key, plan] : world->Cohorts()) {
			bool found = false;
			for (int id : plan.members) if (id == unitId) { found = true; break; }
			if (!found) continue;
			cohort = key;
			out += ",cohort=" + std::to_string(key) + ",mode=" + NameOf(MODE_NAMES, int(plan.mode))
				+ ",reason=" + NameOf(REASON_NAMES, int(plan.reason));
			// D-508: the member's activity, its cohort's factors and its own.
			const why::Set own = world->UnitWhy(unitId);
			out += ",act=" + std::to_string(int(why::UnitActivity(why::CohortActivity(plan.mode, plan.why), own)))
				+ ",pf=" + why::Hex(plan.why) + ",uf=" + why::Hex(own);
			break;
		}
	}
	if (const CBattleGroupController* groups = ai->GetBattleGroupController(); groups != nullptr && cohort >= 0) {
		for (const auto& l : groups->Snapshot()) {
			if (l.key != cohort && l.partner != cohort) continue;
			out += ",group=" + std::to_string(l.key) + ",slot=" + (l.key == cohort ? "screen" : "support");
			break;
		}
		if (const battle_group::Directive* d = groups->DirectiveFor(unitId)) {
			out += std::string(",stance=") + battle_group::Name(d->stance) + ",order=" + battle_group::Name(d->order);
		}
	}
	// D-509: an anti-air escort rides with a battle group outside its cohorts.
	if (const CBattleGroupController* groups = ai->GetBattleGroupController()) {
		springai::AIFloat3 slot; int group = -1;
		if (groups->EscortPoint(unitId, slot, group)) out += ",escort=" + std::to_string(group);
	}
	return out;
}

std::string Dictionary()
{
	return why::Dictionary();
}

} // namespace circuit::monitor
