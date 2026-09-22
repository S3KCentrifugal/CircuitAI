/*
 * EconomyScript.cpp
 *
 *  Created on: Apr 19, 2019
 *      Author: rlcevg
 */

#include "script/EconomyScript.h"
#include "script/ScriptManager.h"
#include "module/EconomyManager.h"
#include "task/builder/BuilderTask.h"
#include "util/ExtAS.h"
#include "angelscript/include/angelscript.h"

namespace circuit {

using namespace springai;

static void CEconomyManager_SetEnergyCondition(CEconomyManager* mgr, const CCircuitDef* cdef, int limit, float mi, float ei)
{
	mgr->SetEnergyCondition(const_cast<CCircuitDef*>(cdef), limit, mi, ei);
}

static int CEconomyManager_GetEnergyLimit(CEconomyManager* mgr, const CCircuitDef* cdef)
{
	return mgr->GetEnergyLimit(const_cast<CCircuitDef*>(cdef));
}

static void CEconomyManager_ClearAllyStarts(CEconomyManager* mgr) { mgr->ClearAllyStarts(); }
static void CEconomyManager_AddAllyStart(CEconomyManager* mgr, const AIFloat3& pos) { mgr->AddAllyStart(pos); }

static IUnitTask* CEconomyManager_EnqueueMexWithinAware(
		CEconomyManager* mgr, CCircuitUnit* builder, const AIFloat3& center, float radius, int maxSpots, bool allyAware)
{
	return mgr->EnqueueMexWithin(builder, center, radius, maxSpots, allyAware);
}

static IUnitTask* CEconomyManager_EnqueueMexWithin(
		CEconomyManager* mgr, CCircuitUnit* builder, const AIFloat3& center, float radius, int maxSpots)
{
	return mgr->EnqueueMexWithin(builder, center, radius, maxSpots);
}

CEconomyScript::CEconomyScript(CScriptManager* scr, CEconomyManager* mgr)
		: IModuleScript(scr, mgr)
{
	asIScriptEngine* engine = script->GetEngine();

//	r = engine->RegisterObjectType("SResourceInfo", sizeof(CEconomyManager::SResourceInfo), asOBJ_VALUE | asOBJ_POD | asGetTypeTraits<CEconomyManager::SResourceInfo>()); ASSERT(r >= 0);
	int r = engine->RegisterObjectType("SResourceInfo", sizeof(CEconomyManager::SResourceInfo), asOBJ_REF | asOBJ_NOCOUNT); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("SResourceInfo", "const float current", asOFFSET(CEconomyManager::SResourceInfo, current)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("SResourceInfo", "const float storage", asOFFSET(CEconomyManager::SResourceInfo, storage)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("SResourceInfo", "const float pull", asOFFSET(CEconomyManager::SResourceInfo, pull)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("SResourceInfo", "const float income", asOFFSET(CEconomyManager::SResourceInfo, income)); ASSERT(r >= 0);

	r = engine->RegisterObjectType("CEconomyManager", 0, asOBJ_REF | asOBJ_NOHANDLE); ASSERT(r >= 0);
	r = engine->RegisterGlobalProperty("CEconomyManager aiEconomyMgr", manager); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CEconomyManager", "const SResourceInfo metal", asOFFSET(CEconomyManager, metal)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CEconomyManager", "const SResourceInfo energy", asOFFSET(CEconomyManager, energy)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CEconomyManager", "bool isMetalEmpty", asOFFSET(CEconomyManager, isMetalEmpty)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CEconomyManager", "bool isMetalFull", asOFFSET(CEconomyManager, isMetalFull)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CEconomyManager", "bool isEnergyStalling", asOFFSET(CEconomyManager, isEnergyStalling)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CEconomyManager", "bool isEnergyEmpty", asOFFSET(CEconomyManager, isEnergyEmpty)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CEconomyManager", "bool isEnergyFull", asOFFSET(CEconomyManager, isEnergyFull)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CEconomyManager", "float reclConvertEff", asOFFSET(CEconomyManager, reclConvertEff)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CEconomyManager", "float reclEnergyEff", asOFFSET(CEconomyManager, reclEnergyEff)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CEconomyManager", "bool assistNanoEnabled", asOFFSET(CEconomyManager, assistNanoEnabled)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CEconomyManager", "float assistNanoIncomeMod", asOFFSET(CEconomyManager, assistNanoIncomeMod)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CEconomyManager", "bool holdStartFactory", asOFFSET(CEconomyManager, holdStartFactory)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CEconomyManager", "bool autoStorageEnabled", asOFFSET(CEconomyManager, autoStorageEnabled)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CEconomyManager", "bool reclaimOldConvertersAlways", asOFFSET(CEconomyManager, reclaimOldConvertersAlways)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CEconomyManager", "float startMexTravel", asOFFSET(CEconomyManager, startMexTravel)); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CEconomyManager", "float GetMetalMake(const CCircuitDef@) const", asMETHOD(CEconomyManager, GetMetalMake), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CEconomyManager", "float GetEnergyMake(const CCircuitDef@) const", asMETHOD(CEconomyManager, GetEnergyMake), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CEconomyManager", "float GetEnergyUse(const CCircuitDef@) const", asMETHOD(CEconomyManager, GetEnergyUse), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CEconomyManager", "int GetMexSpotCountWithin(CCircuitUnit@, const AIFloat3& in, float, int)", asMETHOD(CEconomyManager, GetMexSpotCountWithin), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CEconomyManager", "int GetClaimedMexCountWithin(CCircuitUnit@, const AIFloat3& in, float, int)", asMETHOD(CEconomyManager, GetClaimedMexCountWithin), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CEconomyManager", "IUnitTask@+ EnqueueMexWithin(CCircuitUnit@, const AIFloat3& in, float, int)", asFUNCTION(CEconomyManager_EnqueueMexWithin), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CEconomyManager", "IUnitTask@+ EnqueueMexWithin(CCircuitUnit@, const AIFloat3& in, float, int, bool allyAware)", asFUNCTION(CEconomyManager_EnqueueMexWithinAware), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CEconomyManager", "void ClearAllyStarts()", asFUNCTION(CEconomyManager_ClearAllyStarts), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CEconomyManager", "void AddAllyStart(const AIFloat3& in)", asFUNCTION(CEconomyManager_AddAllyStart), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CEconomyManager", "int GetMexTaskCountWithin(const AIFloat3& in, float) const", asMETHOD(CEconomyManager, GetMexTaskCountWithin), asCALL_THISCALL); ASSERT(r >= 0);
	// Per-role energy table overrides (D-047); -1 keeps a field.
	r = engine->RegisterObjectMethod("CEconomyManager", "void SetEnergyCondition(const CCircuitDef@, int limit, float metalIncome, float energyIncome)", asFUNCTION(CEconomyManager_SetEnergyCondition), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CEconomyManager", "int GetEnergyLimit(const CCircuitDef@) const", asFUNCTION(CEconomyManager_GetEnergyLimit), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
}

CEconomyScript::~CEconomyScript()
{
}

bool CEconomyScript::Init()
{
	asIScriptModule* mod = script->GetEngine()->GetModule(CScriptManager::mainName.c_str());
	int r = mod->SetDefaultNamespace("Economy"); ASSERT(r >= 0);
	InitModule(mod);
	economyInfo.updateEconomy = script->GetFunc(mod, "void AiUpdateEconomy()");
	economyInfo.unitAdded = script->GetFunc(mod, "void AiUnitAdded(CCircuitUnit@, Unit::UseAs)");
	economyInfo.unitRemoved = script->GetFunc(mod, "void AiUnitRemoved(CCircuitUnit@, Unit::UseAs)");
	return true;
}

void CEconomyScript::UpdateEconomy()
{
	if (economyInfo.updateEconomy == nullptr) {
		return;
	}
	asIScriptContext* ctx = script->PrepareContext(economyInfo.updateEconomy);
	script->Exec(ctx);
	script->ReturnContext(ctx);
}

} // namespace circuit
