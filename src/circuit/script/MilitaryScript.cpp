/*
 * MilitaryScript.cpp
 *
 *  Created on: Apr 4, 2019
 *      Author: rlcevg
 */

#include "script/MilitaryScript.h"
#include "script/ScriptManager.h"
#include "module/MilitaryManager.h"
#include "control/group/BattleSquads.h"
#include "CircuitAI.h"
#include "unit/CircuitUnit.h"
#include "util/ExtAS.h"
#include "angelscript/include/angelscript.h"
#include "angelscript/add_on/scriptarray/scriptarray.h"

#include <string>
#include <vector>

namespace circuit {

using namespace springai;

static std::string CMilitaryManager_GetDebugStrikeState(const CMilitaryManager* mgr, int weapon) { return mgr->GetDebugStrikeState(weapon); }

/*
 * Porcupine chain marshalling. The chain is the ordered list of defences a
 * cluster works through, seeded per side from build_chain.json. Exposing it as
 * unit names lets a role read the default, splice mod-conditional tiers into it
 * (Legion, the Extra Units Pack) and write it back, so the ordering is policy
 * in script rather than frozen in JSON. See doc/porc-chain.md.
 *
 * The array type is looked up by declaration rather than cached: this runs once
 * per game, at role setup.
 */
static CScriptArray* CMilitaryManager_GetPorcChain(CMilitaryManager* militaryMgr,
		const std::string& sideName, bool isWater)
{
	asIScriptEngine* engine = asGetActiveContext()->GetEngine();
	asITypeInfo* strArray = engine->GetTypeInfoByDecl("array<string>");
	const std::vector<std::string> names = militaryMgr->GetPorcChain(sideName, isWater);
	CScriptArray* arr = CScriptArray::Create(strArray, asUINT(names.size()));
	for (asUINT i = 0; i < asUINT(names.size()); ++i) {
		*static_cast<std::string*>(arr->At(i)) = names[i];
	}
	return arr;
}

static bool CMilitaryManager_SetPorcChain(CMilitaryManager* militaryMgr,
		const std::string& sideName, bool isWater, const CScriptArray* array)
{
	if (array == nullptr) {
		return false;
	}
	std::vector<std::string> names;
	names.reserve(array->GetSize());
	for (asUINT i = 0; i < array->GetSize(); ++i) {
		names.push_back(*static_cast<const std::string*>(array->At(i)));
	}
	return militaryMgr->SetPorcChain(sideName, isWater, names);
}

// Explicit regrouping between this manager's live fighter tasks. Refuse the
// cross-manager ownership error guarded by ITaskModule::AssignTask(unit).
static bool CMilitaryManager_TransferUnit(CMilitaryManager* mgr, CCircuitUnit* unit, IUnitTask* task)
{
    if (unit == nullptr || task == nullptr || mgr->GetCircuit()->GetTeamUnit(unit->GetId()) != unit
        || task->IsDead() || task->GetManager() != mgr || unit->GetTask() == nullptr
        || unit->GetTask()->GetManager() != mgr
        || (dynamic_cast<IFighterTask*>(task) == nullptr && !task->IsExternalControlled())) return false;
    if (unit->GetTask() != task) mgr->AssignTask(unit, task);
    return true;
}


// Owner 2026-11-24: battle squads (control/group/BattleSquads.h). Every call is
// a no-op answer (-1, false, null) before InitMilitary or without the template.
static bool CMilitaryManager_BattleSquadTemplate(CMilitaryManager* mgr, const std::string& tmpl)
{
	CBattleSquads* squads = mgr->GetBattleSquads();
	return squads != nullptr && squads->HasTemplate(tmpl);
}
static int CMilitaryManager_BattleSquadCreate(CMilitaryManager* mgr, const std::string& tmpl, const std::string& label, const AIFloat3& rally)
{
	CBattleSquads* squads = mgr->GetBattleSquads();
	return squads != nullptr ? squads->Create(tmpl, label, rally) : -1;
}
static bool CMilitaryManager_BattleSquadAdd(CMilitaryManager* mgr, int squad, CCircuitUnit* unit)
{
	CBattleSquads* squads = mgr->GetBattleSquads();
	return squads != nullptr && unit != nullptr && mgr->GetCircuit()->GetTeamUnit(unit->GetId()) == unit && squads->Add(squad, unit);
}
static bool CMilitaryManager_BattleSquadLaunch(CMilitaryManager* mgr, int squad)
{
	CBattleSquads* squads = mgr->GetBattleSquads();
	return squads != nullptr && squads->Launch(squad);
}
static bool CMilitaryManager_BattleSquadGoal(CMilitaryManager* mgr, int squad, const AIFloat3& goal)
{
	CBattleSquads* squads = mgr->GetBattleSquads();
	return squads != nullptr && squads->SetGoal(squad, goal);
}
static bool CMilitaryManager_BattleSquadRelease(CMilitaryManager* mgr, int squad)
{
	CBattleSquads* squads = mgr->GetBattleSquads();
	return squads != nullptr && squads->Release(squad, "script");
}
static IUnitTask* CMilitaryManager_BattleSquadTask(CMilitaryManager* mgr, CCircuitUnit* unit)
{
	CBattleSquads* squads = mgr->GetBattleSquads();
	return squads != nullptr ? squads->TaskFor(unit) : nullptr;
}
static int CMilitaryManager_BattleSquadOf(CMilitaryManager* mgr, int unitId)
{
	CBattleSquads* squads = mgr->GetBattleSquads();
	return squads != nullptr ? squads->SquadOf(unitId) : -1;
}
static int CMilitaryManager_BattleSquadSize(CMilitaryManager* mgr, int squad)
{
	CBattleSquads* squads = mgr->GetBattleSquads();
	return squads != nullptr ? squads->Size(squad) : -1;
}
static int CMilitaryManager_BattleSquadArmed(CMilitaryManager* mgr, int squad)
{
	CBattleSquads* squads = mgr->GetBattleSquads();
	return squads != nullptr ? squads->Armed(squad) : -1;
}
static std::vector<AIFloat3> BattleSquadPath(const CScriptArray* array)
{
	std::vector<AIFloat3> path;
	if (array == nullptr) return path;
	path.reserve(array->GetSize());
	for (asUINT i = 0; i < array->GetSize(); ++i) path.push_back(*static_cast<const AIFloat3*>(array->At(i)));
	return path;
}
static int CMilitaryManager_BattleSquadDive(CMilitaryManager* mgr, int squad)
{
	CBattleSquads* squads = mgr->GetBattleSquads();
	return squads != nullptr ? squads->DiveOf(squad) : -1;
}
static float CMilitaryManager_BattleSquadValue(CMilitaryManager* mgr, int squad)
{
	CBattleSquads* squads = mgr->GetBattleSquads();
	return squads != nullptr ? squads->Value(squad) : -1.f;
}
static float CMilitaryManager_BattleSquadPathEnemy(CMilitaryManager* mgr, const CScriptArray* path, float width, float staticWeight)
{
	CBattleSquads* squads = mgr->GetBattleSquads();
	return squads != nullptr ? squads->PathEnemy(BattleSquadPath(path), width, staticWeight) : 0.f;
}
static float CMilitaryManager_BattleSquadPathFriends(CMilitaryManager* mgr, const CScriptArray* path, float width, int exceptSquad)
{
	CBattleSquads* squads = mgr->GetBattleSquads();
	return squads != nullptr ? squads->PathFriends(BattleSquadPath(path), width, exceptSquad) : 0.f;
}
static int CMilitaryManager_BattleSquadMember(CMilitaryManager* mgr, int squad)
{
	CBattleSquads* squads = mgr->GetBattleSquads();
	return squads != nullptr ? squads->AnyMember(squad) : -1;
}
static int CMilitaryManager_BattleSquadOrder(CMilitaryManager* mgr, int squad)
{
	CBattleSquads* squads = mgr->GetBattleSquads();
	return squads != nullptr ? squads->OrderOf(squad) : -1;
}

CMilitaryScript::CMilitaryScript(CScriptManager* scr, CMilitaryManager* mgr)
		: ITaskModuleScript(scr, mgr)
{
	asIScriptEngine* engine = script->GetEngine();

	int r = engine->RegisterObjectType("SFightTask", sizeof(TaskF::SFightTask), asOBJ_VALUE | asOBJ_POD); ASSERT(r >= 0);
	static_assert(sizeof(TaskF::SFightTask::type) == sizeof(char), "IFighterTask::FightType is not uint8!");
	r = engine->RegisterObjectProperty("SFightTask", "uint8 type", asOFFSET(TaskF::SFightTask, type)); ASSERT(r >= 0);  // Task::FightType
	static_assert(sizeof(TaskF::SFightTask::check) == sizeof(char), "IFighterTask::FightType is not uint8!");
	r = engine->RegisterObjectProperty("SFightTask", "uint8 check", asOFFSET(TaskF::SFightTask, check)); ASSERT(r >= 0);  // Task::FightType
	static_assert(sizeof(TaskF::SFightTask::promote) == sizeof(char), "IFighterTask::FightType is not uint8!");
	r = engine->RegisterObjectProperty("SFightTask", "uint8 promote", asOFFSET(TaskF::SFightTask, promote)); ASSERT(r >= 0);  // Task::FightType
	r = engine->RegisterObjectProperty("SFightTask", "float power", asOFFSET(TaskF::SFightTask, power)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("SFightTask", "CCircuitUnit@ vip", asOFFSET(TaskF::SFightTask, vip)); ASSERT(r >= 0);

	r = engine->RegisterObjectType("CMilitaryManager", 0, asOBJ_REF | asOBJ_NOHANDLE); ASSERT(r >= 0);
	r = engine->RegisterGlobalProperty("CMilitaryManager aiMilitaryMgr", manager); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "IUnitTask@+ DefaultMakeTask(CCircuitUnit@)", asMETHOD(CMilitaryManager, DefaultMakeTask), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "IUnitTask@+ TryMakeRangedTask(CCircuitUnit@)", asMETHOD(CMilitaryManager, TryMakeRangedTask), asCALL_THISCALL); ASSERT(r >= 0);
	// Owner 2026-11-23: native dodge for cloaked stealth scouts (systems/combat/stealth_scout.as)
	r = engine->RegisterObjectMethod("CMilitaryManager", "void SetStealthDodge(CCircuitUnit@, float)", asMETHOD(CMilitaryManager, SetStealthDodge), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "int GetStealthDodgeUntil(CCircuitUnit@) const", asMETHOD(CMilitaryManager, GetStealthDodgeUntil), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "void SetStealthDodgeParams(float, int, float)", asMETHOD(CMilitaryManager, SetStealthDodgeParams), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "int GetStealthDodgeCount() const", asMETHOD(CMilitaryManager, GetStealthDodgeCount), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "AIFloat3 GetStealthDodgeFrom(CCircuitUnit@) const", asMETHOD(CMilitaryManager, GetStealthDodgeFrom), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "IUnitTask@+ Enqueue(const SFightTask& in)", asMETHODPR(CMilitaryManager, Enqueue, (const TaskF::SFightTask&), IFighterTask*), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "IUnitTask@+ EnqueueGather(const SFightTask& in, const AIFloat3& in, int)", asMETHOD(CMilitaryManager, EnqueueGather), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "bool SetGatherPower(IUnitTask@, float)", asMETHOD(CMilitaryManager, SetGatherPower), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "IUnitTask@+ EnqueueRetreat()", asMETHOD(CMilitaryManager, EnqueueRetreat), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "IUnitTask@+ EnqueueExternalControl(const string& in)", asMETHOD(CMilitaryManager, EnqueueExternalControl), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "IUnitTask@+ EnqueueEscortStrike()", asMETHOD(CMilitaryManager, EnqueueEscortStrike), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "bool TransferUnit(CCircuitUnit@, IUnitTask@)", asFUNCTION(CMilitaryManager_TransferUnit), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	// Owner 2026-11-24: battle squads (control/group/BattleSquads.h)
	r = engine->RegisterObjectMethod("CMilitaryManager", "bool BattleSquadTemplate(const string& in)", asFUNCTION(CMilitaryManager_BattleSquadTemplate), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "int BattleSquadCreate(const string& in, const string& in, const AIFloat3& in)", asFUNCTION(CMilitaryManager_BattleSquadCreate), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "bool BattleSquadAdd(int, CCircuitUnit@)", asFUNCTION(CMilitaryManager_BattleSquadAdd), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "bool BattleSquadLaunch(int)", asFUNCTION(CMilitaryManager_BattleSquadLaunch), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "bool BattleSquadGoal(int, const AIFloat3& in)", asFUNCTION(CMilitaryManager_BattleSquadGoal), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "bool BattleSquadRelease(int)", asFUNCTION(CMilitaryManager_BattleSquadRelease), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "IUnitTask@+ BattleSquadTask(CCircuitUnit@)", asFUNCTION(CMilitaryManager_BattleSquadTask), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "int BattleSquadOf(int)", asFUNCTION(CMilitaryManager_BattleSquadOf), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "int BattleSquadSize(int)", asFUNCTION(CMilitaryManager_BattleSquadSize), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "int BattleSquadArmed(int)", asFUNCTION(CMilitaryManager_BattleSquadArmed), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "int BattleSquadMember(int)", asFUNCTION(CMilitaryManager_BattleSquadMember), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "int BattleSquadDive(int)", asFUNCTION(CMilitaryManager_BattleSquadDive), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "float BattleSquadValue(int)", asFUNCTION(CMilitaryManager_BattleSquadValue), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "float BattleSquadPathEnemy(const array<AIFloat3>& in, float, float)", asFUNCTION(CMilitaryManager_BattleSquadPathEnemy), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "float BattleSquadPathFriends(const array<AIFloat3>& in, float, int)", asFUNCTION(CMilitaryManager_BattleSquadPathFriends), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "int BattleSquadOrder(int)", asFUNCTION(CMilitaryManager_BattleSquadOrder), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "void DefaultMakeDefence(int, const AIFloat3& in)", asMETHOD(CMilitaryManager, DefaultMakeDefence), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "AIFloat3 GetCombatFocusPos() const", asMETHOD(CMilitaryManager, GetCombatFocusPos), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "array<string>@ GetPorcChain(const string& in, bool) const", asFUNCTION(CMilitaryManager_GetPorcChain), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "bool SetPorcChain(const string& in, bool, const array<string>@+)", asFUNCTION(CMilitaryManager_SetPorcChain), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "uint GetGuardTaskNum() const", asMETHOD(CMilitaryManager, GetGuardTaskNum), asCALL_THISCALL); ASSERT(r >= 0);
	// Overnuke (owner 2026-10-28): a rise in the scout count is a request to scout the target
	r = engine->RegisterObjectMethod("CMilitaryManager", "int GetOvernukeScouts() const", asMETHOD(CMilitaryManager, GetOvernukeScouts), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "AIFloat3 GetOvernukePos() const", asMETHOD(CMilitaryManager, GetOvernukePos), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "float GetOvernukeRadius() const", asMETHOD(CMilitaryManager, GetOvernukeRadius), asCALL_THISCALL); ASSERT(r >= 0);
	// Front nukerush (owner 2026-11-03): overnuke targets begun by our silos; one team-wide draw per key
	r = engine->RegisterObjectMethod("CMilitaryManager", "int GetOvernukeRounds() const", asMETHOD(CMilitaryManager, GetOvernukeRounds), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "bool AllyTeamRoll(const string& in, float)", asMETHOD(CMilitaryManager, AllyTeamRoll), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "void SetOvernukeFirstRoll(int, int)", asMETHOD(CMilitaryManager, SetOvernukeFirstRoll), asCALL_THISCALL); ASSERT(r >= 0);
	// Nuke rush scouting (owner 2026-10-28): where the first silo aims, for TECH's scout request
	r = engine->RegisterObjectMethod("CMilitaryManager", "AIFloat3 GetNuclearAim() const", asMETHOD(CMilitaryManager, GetNuclearAim), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "float GetNuclearAimRadius() const", asMETHOD(CMilitaryManager, GetNuclearAimRadius), asCALL_THISCALL); ASSERT(r >= 0);
	// Debug strikes (owner 2026-10-31, debug-widget-test): barb|debug from the widget (presentation/commands.as)
	r = engine->RegisterObjectMethod("CMilitaryManager", "bool SetDebugStrike(int, int, float, float, int)", asMETHOD(CMilitaryManager, SetDebugStrike), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "bool SetDebugStrikePlayer(int, int)", asMETHOD(CMilitaryManager, SetDebugStrikePlayer), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "string GetDebugStrikeState(int) const", asFUNCTION(CMilitaryManager_GetDebugStrikeState), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	// Nuke launch scouting (owner 2026-10-31): a rise in the launch count is a new launch
	r = engine->RegisterObjectMethod("CMilitaryManager", "int GetNuclearLaunches() const", asMETHOD(CMilitaryManager, GetNuclearLaunches), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "AIFloat3 GetNuclearLaunchPos() const", asMETHOD(CMilitaryManager, GetNuclearLaunchPos), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "float GetNuclearLaunchRadius() const", asMETHOD(CMilitaryManager, GetNuclearLaunchRadius), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CMilitaryManager", "const float armyCost", asOFFSET(CMilitaryManager, armyCost)); ASSERT(r >= 0);
    r = engine->RegisterObjectMethod("CMilitaryManager", "void SetAggressionDelta(float)", asMETHOD(CMilitaryManager, SetAggressionDelta), asCALL_THISCALL); ASSERT(r >= 0);
    r = engine->RegisterObjectMethod("CMilitaryManager", "float GetAggressionDelta() const", asMETHOD(CMilitaryManager, GetAggressionDelta), asCALL_THISCALL); ASSERT(r >= 0);
    r = engine->RegisterObjectMethod("CMilitaryManager", "void SetAutomaticAggression(float)", asMETHOD(CMilitaryManager, SetAutomaticAggression), asCALL_THISCALL); ASSERT(r >= 0);
    r = engine->RegisterObjectMethod("CMilitaryManager", "float GetAutomaticAggression() const", asMETHOD(CMilitaryManager, GetAutomaticAggression), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CMilitaryManager", "int porcMode", asOFFSET(CMilitaryManager, porcMode)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CMilitaryManager", "float porcBudgetMod", asOFFSET(CMilitaryManager, porcBudgetMod)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CMilitaryManager", "int porcAllyAA", asOFFSET(CMilitaryManager, porcAllyAA)); ASSERT(r >= 0);

	// NOTE: Config's "quota" scattered across CMilitaryManager, CEnemyManager, CThreatMap, CFactoryManager, CSetupManager
	r = engine->RegisterObjectType("SQuotaMilitary", 0, asOBJ_REF | asOBJ_NOCOUNT); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CMilitaryManager", "SQuotaMilitary quota", 0); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("SQuotaMilitary", "uint scout", asOFFSET(CMilitaryManager, maxScouts)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("SQuotaMilitary", "float attack", asOFFSET(CMilitaryManager, minAttackers)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("SQuotaMilitary", "float attackWait", asOFFSET(CMilitaryManager, attackWaitSeconds)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("SQuotaMilitary", "float attackScale", asOFFSET(CMilitaryManager, attackScale)); ASSERT(r >= 0);
	r = engine->RegisterObjectType("SRaidQuota", 0, asOBJ_REF | asOBJ_NOCOUNT); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("SQuotaMilitary", "SRaidQuota raid", 0); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("SRaidQuota", "float min", asOFFSET(CMilitaryManager::SRaidQuota, min), asOFFSET(CMilitaryManager, raid), false); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("SRaidQuota", "float avg", asOFFSET(CMilitaryManager::SRaidQuota, avg), asOFFSET(CMilitaryManager, raid), false); ASSERT(r >= 0);
	// Alternative "quota" accessors:
//	r = engine->RegisterObjectProperty("CMilitaryManager", "uint quotaScout", asOFFSET(CMilitaryManager, maxScouts)); ASSERT(r >= 0);
//	r = engine->RegisterObjectProperty("CMilitaryManager", "float quotaAttack", asOFFSET(CMilitaryManager, minAttackers)); ASSERT(r >= 0);
//	r = engine->RegisterObjectProperty("CMilitaryManager", "float quotaRaidMin", asOFFSET(CMilitaryManager::SRaidQuota, min), asOFFSET(CMilitaryManager, raid), false); ASSERT(r >= 0);
//	r = engine->RegisterObjectProperty("CMilitaryManager", "float quotaRaidAvg", asOFFSET(CMilitaryManager::SRaidQuota, avg), asOFFSET(CMilitaryManager, raid), false); ASSERT(r >= 0);

	r = engine->RegisterObjectType("SResponseInfo", 0, asOBJ_REF | asOBJ_NOCOUNT); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("SResponseInfo", "float maxPercent", asOFFSET(CMilitaryManager::SRoleInfo, maxPerc)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("SResponseInfo", "float factor", asOFFSET(CMilitaryManager::SRoleInfo, factor)); ASSERT(r >= 0);
	r = engine->RegisterObjectType("SVsInfo", 0, asOBJ_REF | asOBJ_NOCOUNT); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("SVsInfo", "Type role", asOFFSET(CMilitaryManager::SRoleInfo::SVsInfo, role)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("SVsInfo", "float ratio", asOFFSET(CMilitaryManager::SRoleInfo::SVsInfo, ratio)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("SVsInfo", "float importance", asOFFSET(CMilitaryManager::SRoleInfo::SVsInfo, importance)); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("SResponseInfo", "SVsInfo@ GetVsInfo(Type) const", asFUNCTION(CMilitaryScript::GetVsInfo), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMilitaryManager", "SResponseInfo@ GetResponseInfo(Type) const", asMETHOD(CMilitaryManager, GetRoleInfo), asCALL_THISCALL); ASSERT(r >= 0);
}

CMilitaryScript::~CMilitaryScript()
{
}

bool CMilitaryScript::Init()
{
	asIScriptModule* mod = script->GetEngine()->GetModule(CScriptManager::mainName.c_str());
	int r = mod->SetDefaultNamespace("Military"); ASSERT(r >= 0);
	InitModule(mod);
	militaryInfo.makeDefence = script->GetFunc(mod, "void AiMakeDefence(int, const AIFloat3& in)");
	militaryInfo.groundObjective = script->GetFunc(mod, "AIFloat3 AiGroundObjective(CCircuitUnit@, const AIFloat3& in)");
	return true;
}

AIFloat3 CMilitaryScript::GroundObjective(CCircuitUnit* unit, const AIFloat3& previous)
{
	// Optional, called on cohort objective completion, never per shooter.
	// Copy the value before returning the borrowed context to its pool.
	auto result=previous;
	if (!militaryInfo.groundObjective) return result;
	asIScriptContext* ctx=script->PrepareContext(militaryInfo.groundObjective);
	ctx->SetArgObject(0,unit);
	ctx->SetArgAddress(1,const_cast<AIFloat3*>(&previous));
	if (script->Exec(ctx)) result=*static_cast<AIFloat3*>(ctx->GetReturnObject());
	script->ReturnContext(ctx);
	return result;
}

void CMilitaryScript::MakeDefence(int cluster, const AIFloat3& pos)
{
	if (militaryInfo.makeDefence == nullptr) {
		static_cast<CMilitaryManager*>(manager)->DefaultMakeDefence(cluster, pos);
		return;
	}
	asIScriptContext* ctx = script->PrepareContext(militaryInfo.makeDefence);
	ctx->SetArgDWord(0, cluster);
	ctx->SetArgAddress(1, &const_cast<AIFloat3&>(pos));
	script->Exec(ctx);
	script->ReturnContext(ctx);
}

CMilitaryManager::SRoleInfo::SVsInfo* CMilitaryScript::GetVsInfo(CMilitaryManager::SRoleInfo* info, CCircuitDef::RoleT vsType)
{
	for (CMilitaryManager::SRoleInfo::SVsInfo& vs : info->vs) {
		if (vsType == vs.role) {
			return &vs;
		}
	}
	return &info->vs.emplace_back(vsType, 0.f, 0.f);
}

} // namespace circuit
