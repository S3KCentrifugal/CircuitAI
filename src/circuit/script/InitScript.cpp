/*
 * InitScript.cpp
 *
 *  Created on: May 13, 2020
 *      Author: rlcevg
 */

#include "script/InitScript.h"
#include "script/SetupScript.h"
#include "script/ScriptManager.h"
#include "script/RefCounter.h"
#include "map/ThreatMap.h"
#include "scheduler/Scheduler.h"
#include "setup/SetupManager.h"
#include "resource/MetalManager.h"
#include "spring/SpringMap.h"
#include "terrain/TerrainManager.h"
#include "UnitDef.h"
#include "task/builder/BuilderTask.h"
#include "task/static/SuperTask.h"
#include "task/fighter/RouteTask.h"
#include "task/fighter/FerryTask.h"
#include "task/fighter/AirWaveTask.h"
#include "unit/CircuitUnit.h"
#include "CircuitAI.h"
#include "util/GameAttribute.h"
#include "util/MaskHandler.h"
#include "util/ExtAS.h"
#include "util/Utils.h"

#include "angelscript/include/angelscript.h"
#include "angelscript/add_on/scriptarray/scriptarray.h"
#include "angelscript/add_on/scriptdictionary/scriptdictionary.h"
// FIXME: MinGW didn't like asbind20
//#include "asbind20/asbind.hpp"
//#include "asbind20/operators.hpp"  // _this, const_this, param<T>, ->return<T>()

#include "spring/SpringMap.h"

#include "Log.h"
#include "Drawer.h"
#include "Game.h"
#include "Team.h"
#include "Lua.h"

#include <format>

namespace circuit {

using namespace springai;

CInitScript::SInitInfo::SInitInfo(const SInitInfo& o)
{
	armor = o.armor;
	category = o.category;
	if (profile != nullptr) {
		profile->Release();
	}
	profile = o.profile;
	if (profile != nullptr) {
		profile->AddRef();
	}
}

CInitScript::SInitInfo::~SInitInfo()
{
	if (profile != nullptr) {
		profile->Release();
	}
}

static void AddAirArmor(CCircuitDef::SArmorInfo* mem, int type)
{
	mem->airTypes.push_back(type);
}

static void AddSurfaceArmor(CCircuitDef::SArmorInfo* mem, int type)
{
	mem->surfTypes.push_back(type);
}

static void AddWaterArmor(CCircuitDef::SArmorInfo* mem, int type)
{
	mem->waterTypes.push_back(type);
}

static void ConstructVec3(float3* mem)
{
	new(mem) float3();
}

static void ConstructCopyVec3(float3* mem, const float3& o)
{
	new(mem) float3(o);
}

static void ConstructVec3Val1(float3* mem, float a)
{
	new(mem) float3(a);
}

static void ConstructVec3Val3(float3* mem, float x, float y, float z)
{
	new(mem) float3(x, y, z);
}

static std::string ConvertVec3ToStr(const float3& f)
{
	return f.str();  // static_cast<const AIFloat3&>(f).ToString();
}

static geom::CPolygon* FactoryCPolygon(const CScriptArray* array)
{
	F3Vec points;
	points.reserve(array->GetSize());
	for (asUINT i = 0; i < array->GetSize(); ++i) {
		points.push_back(*static_cast<const AIFloat3*>(array->At(i)));
	}
	return new geom::CPolygon(std::move(points));
}

static CScriptArray* CPolygon_GetVerts(geom::CPolygon* poly)
{
	asIScriptEngine* engine = asGetActiveContext()->GetEngine();
	auto cache = static_cast<CScriptManager::STypeInfoCache*>(engine->GetUserData());
	CScriptArray* arr = CScriptArray::Create(cache->vec3Array, poly->GetVerts().size());
	asUINT i = 0;
	for (const AIFloat3& vert : poly->GetVerts()) {
		*(AIFloat3*)arr->At(i++) = vert;  // arr->SetValue(i++, (void*)&vert);
	}
	return arr;
}

static void ConstructSArmorInfo(CCircuitDef::SArmorInfo* mem)
{
	new(mem) CCircuitDef::SArmorInfo();
}

static void ConstructCopySArmorInfo(CCircuitDef::SArmorInfo* mem, const CCircuitDef::SArmorInfo& o)
{
	new(mem) CCircuitDef::SArmorInfo(o);
}

static void DestructSArmorInfo(CCircuitDef::SArmorInfo *mem)
{
	mem->~SArmorInfo();
}

static CCircuitDef::SArmorInfo& AssignSArmorInfoToSArmorInfo(CCircuitDef::SArmorInfo& mem, const CCircuitDef::SArmorInfo& o)
{
	mem = o;
	return mem;
}

static void ConstructSCategoryInfo(CInitScript::SInitInfo::SCategoryInfo* mem)
{
	new(mem) CInitScript::SInitInfo::SCategoryInfo();
}

static void ConstructCopySCategoryInfo(CInitScript::SInitInfo::SCategoryInfo* mem, const CInitScript::SInitInfo::SCategoryInfo& o)
{
	new(mem) CInitScript::SInitInfo::SCategoryInfo(o);
}

static void DestructSCategoryInfo(CInitScript::SInitInfo::SCategoryInfo *mem)
{
	mem->~SCategoryInfo();
}

static CInitScript::SInitInfo::SCategoryInfo& AssignSCategoryInfoToSCategoryInfo(CInitScript::SInitInfo::SCategoryInfo& mem, const CInitScript::SInitInfo::SCategoryInfo& o)
{
	mem = o;
	return mem;
}

static void ConstructSInitInfo(CInitScript::SInitInfo* mem)
{
	new(mem) CInitScript::SInitInfo();
}

static void ConstructCopySInitInfo(CInitScript::SInitInfo* mem, const CInitScript::SInitInfo& o)
{
	new(mem) CInitScript::SInitInfo(o);
}

static void DestructSInitInfo(CInitScript::SInitInfo *mem)
{
	mem->~SInitInfo();
}

static CCircuitDef* CCircuitAI_GetCircuitDef(CCircuitAI* circuit, const std::string& name)
{
	return circuit->GetCircuitDef(name.c_str());
}

static std::string CCircuitAI_GetMapName(CCircuitAI* circuit)
{
	return circuit->GetMap()->GetName();
}

static int CCircuitAI_GetLeadTeamId(CCircuitAI* circuit)
{
	return circuit->GetAllyTeam()->GetLeaderId();
}

static CScriptArray* CCircuitAI_GetTeamIds(CCircuitAI* circuit)
{
	asIScriptEngine* engine = asGetActiveContext()->GetEngine();
	auto cache = static_cast<CScriptManager::STypeInfoCache*>(engine->GetUserData());
	CAllyTeam* allyTeam = circuit->GetAllyTeam();
	CScriptArray* arr = CScriptArray::Create(cache->idArray, allyTeam->GetSize());
	asUINT i = 0;
	for (CAllyTeam::Id teamId : allyTeam->GetTeamIds()) {
		*(CAllyTeam::Id*)arr->At(i++) = teamId;
	}
	return arr;
}

static int CTerrainManager_ReserveBuilding(CTerrainManager* terrainMgr, const CCircuitDef* cdef, const AIFloat3& pos, int facing, int ttlFrames)
{
	return terrainMgr->ReserveBuilding(const_cast<CCircuitDef*>(cdef), pos, facing, ttlFrames, 0);
}

static int CTerrainManager_ReserveGrid(CTerrainManager* terrainMgr, const CCircuitDef* cdef, const AIFloat3& frontCentre,
		int facing, int cols, int rows, int gap, int ttlFrames)
{
	return terrainMgr->ReserveGrid(const_cast<CCircuitDef*>(cdef), frontCentre, facing, cols, rows, gap, ttlFrames);
}

static int CTerrainManager_ReserveNanoBlockAt(CTerrainManager* terrainMgr, const CCircuitDef* nanoDef, const CCircuitDef* facDef,
		const AIFloat3& facPos, int facing, int cols, int rows, int gap)
{
	return terrainMgr->ReserveNanoBlockAt(const_cast<CCircuitDef*>(nanoDef), const_cast<CCircuitDef*>(facDef), facPos, facing, cols, rows, gap);
}

static int CTerrainManager_ReserveNanoBlock(CTerrainManager* terrainMgr, CCircuitUnit* factory, const CCircuitDef* nanoDef, int cols, int rows, int gap)
{
	return terrainMgr->ReserveNanoBlock(factory, const_cast<CCircuitDef*>(nanoDef), cols, rows, gap);
}

static bool CTerrainManager_CanReserveBuilding(CTerrainManager* terrainMgr, const CCircuitDef* cdef, const AIFloat3& pos, int facing)
{
	return terrainMgr->CanReserveBuilding(const_cast<CCircuitDef*>(cdef), pos, facing);
}

static float CTerrainManager_BuildableFraction(CTerrainManager* terrainMgr, const CCircuitDef* cdef, const AIFloat3& centre, float halfAcross, float halfAlong, int facing)
{
	return terrainMgr->BuildableFraction(const_cast<CCircuitDef*>(cdef), centre, halfAcross, halfAlong, facing);
}

static int CTerrainManager_GetReservationCount(CTerrainManager* terrainMgr, const CCircuitDef* cdef)
{
	return terrainMgr->GetReservationCount(const_cast<CCircuitDef*>(cdef));
}

static int CTerrainManager_LayBand(CTerrainManager* terrainMgr, int zone, const CCircuitDef* cdef, const AIFloat3& frontCentre,
		int facing, int cols, int rows, int gap, bool armed, bool anyReach, bool tenant, int group)
{
	return terrainMgr->LayBand(zone, const_cast<CCircuitDef*>(cdef), frontCentre, facing, cols, rows, gap, armed, anyReach, tenant, group);
}

static int CTerrainManager_PackNearGroup(CTerrainManager* terrainMgr, int zone, const CCircuitDef* cdef, int nanoGroup,
		int facing, const AIFloat3& anchor, float maxReach, float minNanoDist, int group)
{
	return terrainMgr->PackNearGroup(zone, const_cast<CCircuitDef*>(cdef), nanoGroup, facing, anchor, maxReach, minNanoDist, group);
}

static bool CTerrainManager_CanPackNearGroup(CTerrainManager* terrainMgr, int zone, const CCircuitDef* cdef, int nanoGroup,
		int facing, float maxReach, float minNanoDist)
{
	return terrainMgr->CanPackNearGroup(zone, const_cast<CCircuitDef*>(cdef), nanoGroup, facing, maxReach, minNanoDist);
}

static bool CTerrainManager_PlanFactoryPair(CTerrainManager* terrainMgr, const std::string& name,
		const CCircuitDef* firstFactory, const CCircuitDef* secondFactory, const CCircuitDef* nanoDef,
		const AIFloat3& base, int facing, int sideOffsetCells, int forwardOffsetCells)
{
	return terrainMgr->PlanFactoryPair(name, const_cast<CCircuitDef*>(firstFactory),
			const_cast<CCircuitDef*>(secondFactory), const_cast<CCircuitDef*>(nanoDef),
			base, facing, sideOffsetCells, forwardOffsetCells);
}

static bool IBuilderTask_PinReservation(IUnitTask* task, int id)
{
	IBuilderTask* bt = dynamic_cast<IBuilderTask*>(task);
	return (bt != nullptr) && bt->PinReservation(id);
}

// The map's economy constants for the eco planner (D-058).
static float CCircuitAI_WindMin(CCircuitAI* circuit) { return circuit->GetMap()->GetMinWind(); }
static float CCircuitAI_WindMax(CCircuitAI* circuit) { return circuit->GetMap()->GetMaxWind(); }
static float CCircuitAI_WindCur(CCircuitAI* circuit) { return circuit->GetMap()->GetCurWind(); }
static float CCircuitAI_Tidal(CCircuitAI* circuit) { return circuit->GetMap()->GetTidalStrength(); }
static int CCircuitAI_MetalSpots(CCircuitAI* circuit) { return (int)circuit->GetMetalManager()->GetSpots().size(); }

static AIFloat3 CSetupManager_GetLanePos(CSetupManager* setupMgr)
{
	return setupMgr->GetLanePos();
}

static int IBuilderTask_GetReservationId(IUnitTask* task)
{
	IBuilderTask* bt = dynamic_cast<IBuilderTask*>(task);
	return (bt != nullptr) ? bt->GetReservationId() : -1;
}

// Footprint in blocking-map cells (16 elmos), what the reservation API measures in.
static int CCircuitDef_GetFootprintX(const CCircuitDef* cdef)
{
	return (cdef->GetDef() == nullptr) ? 0 : cdef->GetDef()->GetXSize() / 2;
}

static int CCircuitDef_GetFootprintZ(const CCircuitDef* cdef)
{
	return (cdef->GetDef() == nullptr) ? 0 : cdef->GetDef()->GetZSize() / 2;
}

static int CTerrainManager_GetTerrainWidth(CTerrainManager* terrainMgr)
{
	return CTerrainManager::GetTerrainWidth();
}

static int CTerrainManager_GetTerrainHeight(CTerrainManager* terrainMgr)
{
	return CTerrainManager::GetTerrainHeight();
}

static void CCircuitAI_GiveUnits(CCircuitAI* circuit, const CScriptArray* array, int newTeamId)
{
	std::vector<CCircuitUnit*> units;
	units.reserve(array->GetSize());
	for (asUINT i = 0; i < array->GetSize(); ++i) {
		units.push_back(*static_cast<CCircuitUnit* const*>(array->At(i)));
	}
	circuit->GiveUnits(std::move(units), newTeamId);
}

static std::string CCircuitAI_CallRules(CCircuitAI* circuit, const std::string& data)
{
	return circuit->GetLua()->CallRules(data.c_str(), data.size());
}

static std::string CCircuitAI_CallUI(CCircuitAI* circuit, const std::string& data)
{
	return circuit->GetLua()->CallUI(data.c_str(), data.size());
}

static float CCircuitAI_GetGameRulesParamFloat(CCircuitAI* circuit, const std::string& key, float defVal)
{
	return circuit->GetGame()->GetRulesParamFloat(key.c_str(), defVal);
}

static std::string CCircuitAI_GetGameRulesParamString(CCircuitAI* circuit, const std::string& key, const std::string& defVal)
{
	return circuit->GetGame()->GetRulesParamString(key.c_str(), defVal.c_str());
}

static float CCircuitAI_GetTeamRulesParamFloat(CCircuitAI* circuit, const std::string& key, float defVal)
{
	return circuit->GetTeam()->GetRulesParamFloat(key.c_str(), defVal);
}

static std::string CCircuitAI_GetTeamRulesParamString(CCircuitAI* circuit, const std::string& key, const std::string& defVal)
{
	return circuit->GetTeam()->GetRulesParamString(key.c_str(), defVal.c_str());
}

static const std::string CCircuitDef_GetName(CCircuitDef* cdef)
{
	return cdef->GetDef()->GetName();
}

static float CCircuitUnit_GetRulesParamFloat(CCircuitUnit* unit, const std::string& key, float defVal)
{
	return unit->GetUnit()->GetRulesParamFloat(key.c_str(), defVal);
}

static std::string CCircuitUnit_GetRulesParamString(CCircuitUnit* unit, const std::string& key, const std::string& defVal)
{
	return unit->GetUnit()->GetRulesParamString(key.c_str(), defVal.c_str());
}

static CScriptArray* IUnitTask_GetUnits(IUnitTask* task)
{
	asIScriptEngine* engine = asGetActiveContext()->GetEngine();
	auto cache = static_cast<CScriptManager::STypeInfoCache*>(engine->GetUserData());
	CScriptArray* arr = CScriptArray::Create(cache->unitArray, task->GetAssignees().size());
	asUINT i = 0;
	for (CCircuitUnit* unit : task->GetAssignees()) {
		arr->SetValue(i++, &unit);
	}
	return arr;
}

template<class From, class To>
To* RefCast(From* src)
{
	// If the handle already is a null handle, then just return the null handle
	if (!src) return nullptr;

	// Now try to dynamically cast the pointer to the wanted type
	To* dst = dynamic_cast<To*>(src);
	if (dst != nullptr) {
		// Since the cast was made, we need to increase the ref counter for the returned handle
		dst->AddRef();
	}
	return dst;
}

template <class Base, class Derived>
void RegisterCast(asIScriptEngine *engine, const char *base, const char* derived)
{
	int r;
	r = engine->RegisterObjectMethod(base, std::format("{}@ opCast()", derived).c_str(), asFUNCTION((RefCast<Base, Derived>)), asCALL_CDECL_OBJLAST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod(derived, std::format("{}@ opImplCast()", base).c_str(), asFUNCTION((RefCast<Derived, Base>)), asCALL_CDECL_OBJLAST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod(base, std::format("const {}@ opCast() const", derived).c_str(), asFUNCTION((RefCast<Base, Derived>)), asCALL_CDECL_OBJLAST); ASSERT( r >= 0 );
	r = engine->RegisterObjectMethod(derived, std::format("const {}@ opImplCast() const", base).c_str(), asFUNCTION((RefCast<Derived, Base>)), asCALL_CDECL_OBJLAST); ASSERT( r >= 0 );
}

CInitScript::CInitScript(CScriptManager* scr, CCircuitAI* ai)
		: IScript(scr)
		, circuit(ai)
{
}

CInitScript::~CInitScript()
{
	for (auto& kv : takenContexts) {
		if (kv.second) {
			kv.second->Release();  // dictionary param
		}
		script->ReleaseContext(kv.first);
	}
}

bool CInitScript::InitConfig(const std::string& profile,
		std::vector<std::string>& outCfgParts, CCircuitDef::SArmorInfo& outArmor)
{
	asIScriptEngine* engine = script->GetEngine();
	// FIXME: asASSERT( refCount == 0 ); at lib/angelscript/source/as_configgroup.cpp:157
	//        on exit
//	int r = engine->BeginConfigGroup(CScriptManager::initName.c_str()); ASSERT(r >= 0);
	int r = engine->RegisterObjectType("SArmorInfo", sizeof(CCircuitDef::SArmorInfo), asOBJ_VALUE | asGetTypeTraits<CCircuitDef::SArmorInfo>()); ASSERT(r >= 0);
	r = engine->RegisterObjectBehaviour("SArmorInfo", asBEHAVE_CONSTRUCT, "void f()", asFUNCTION(ConstructSArmorInfo), asCALL_CDECL_OBJLAST); ASSERT(r >= 0);
	r = engine->RegisterObjectBehaviour("SArmorInfo", asBEHAVE_CONSTRUCT, "void f(const SArmorInfo& in)", asFUNCTION(ConstructCopySArmorInfo), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectBehaviour("SArmorInfo", asBEHAVE_DESTRUCT, "void f()", asFUNCTION(DestructSArmorInfo), asCALL_CDECL_OBJLAST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("SArmorInfo", "SArmorInfo &opAssign(const SArmorInfo &in)", asFUNCTION(AssignSArmorInfoToSArmorInfo), asCALL_CDECL_OBJFIRST); assert( r >= 0 );
	r = engine->RegisterObjectMethod("SArmorInfo", "void AddAir(int)", asFUNCTION(AddAirArmor), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("SArmorInfo", "void AddSurface(int)", asFUNCTION(AddSurfaceArmor), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("SArmorInfo", "void AddWater(int)", asFUNCTION(AddWaterArmor), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectType("SCategoryInfo", sizeof(SInitInfo::SCategoryInfo), asOBJ_VALUE | asGetTypeTraits<SInitInfo::SCategoryInfo>()); ASSERT(r >= 0);
	r = engine->RegisterObjectBehaviour("SCategoryInfo", asBEHAVE_CONSTRUCT, "void f()", asFUNCTION(ConstructSCategoryInfo), asCALL_CDECL_OBJLAST); ASSERT(r >= 0);
	r = engine->RegisterObjectBehaviour("SCategoryInfo", asBEHAVE_CONSTRUCT, "void f(const SCategoryInfo& in)", asFUNCTION(ConstructCopySCategoryInfo), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectBehaviour("SCategoryInfo", asBEHAVE_DESTRUCT, "void f()", asFUNCTION(DestructSCategoryInfo), asCALL_CDECL_OBJLAST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("SCategoryInfo", "SCategoryInfo &opAssign(const SCategoryInfo &in)", asFUNCTION(AssignSCategoryInfoToSCategoryInfo), asCALL_CDECL_OBJFIRST); assert( r >= 0 );
	r = engine->RegisterObjectProperty("SCategoryInfo", "string air", asOFFSET(SInitInfo::SCategoryInfo, air)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("SCategoryInfo", "string land", asOFFSET(SInitInfo::SCategoryInfo, land)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("SCategoryInfo", "string water", asOFFSET(SInitInfo::SCategoryInfo, water)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("SCategoryInfo", "string bad", asOFFSET(SInitInfo::SCategoryInfo, bad)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("SCategoryInfo", "string good", asOFFSET(SInitInfo::SCategoryInfo, good)); ASSERT(r >= 0);
	r = engine->RegisterObjectType("SInitInfo", sizeof(SInitInfo), asOBJ_VALUE | asGetTypeTraits<SInitInfo>()); ASSERT(r >= 0);
	r = engine->RegisterObjectBehaviour("SInitInfo", asBEHAVE_CONSTRUCT, "void f()", asFUNCTION(ConstructSInitInfo), asCALL_CDECL_OBJLAST); ASSERT(r >= 0);
	r = engine->RegisterObjectBehaviour("SInitInfo", asBEHAVE_CONSTRUCT, "void f(const SInitInfo& in)", asFUNCTION(ConstructCopySInitInfo), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectBehaviour("SInitInfo", asBEHAVE_DESTRUCT, "void f()", asFUNCTION(DestructSInitInfo), asCALL_CDECL_OBJLAST); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("SInitInfo", "SArmorInfo armor", asOFFSET(SInitInfo, armor)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("SInitInfo", "SCategoryInfo category", asOFFSET(SInitInfo, category)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("SInitInfo", "array<string>@ profile", asOFFSET(SInitInfo, profile)); ASSERT(r >= 0);
//	r = engine->EndConfigGroup(); ASSERT(r >= 0);

	folderName = profile;
	if (!script->Load(CScriptManager::initName.c_str(), folderName, CScriptManager::initName + ".as")) {
		return false;
	}
	asIScriptModule* mod = script->GetEngine()->GetModule(CScriptManager::initName.c_str());
	r = mod->SetDefaultNamespace("Init"); ASSERT(r >= 0);
	asIScriptFunction* init = script->GetFunc(mod, "SInitInfo AiInit()");

	if (init != nullptr) {
		asIScriptContext* ctx = script->PrepareContext(init);
		SInitInfo* result = script->Exec(ctx) ? (SInitInfo*)ctx->GetReturnObject() : nullptr;
		if (result != nullptr) {
			outArmor = result->armor;
			if (outArmor.airTypes.empty()) {
				outArmor.airTypes.push_back(0);  // default
			}
			if (outArmor.surfTypes.empty()) {
				outArmor.surfTypes.push_back(0);  // default
			}
			if (outArmor.waterTypes.empty()) {
				outArmor.waterTypes.push_back(0);  // default
			}

			Game* game = circuit->GetGame();
			circuit->category.air = game->GetCategoriesFlag(result->category.air.c_str());
			circuit->category.land = game->GetCategoriesFlag(result->category.land.c_str());
			circuit->category.water = game->GetCategoriesFlag(result->category.water.c_str());
			circuit->category.bad = game->GetCategoriesFlag(result->category.bad.c_str());
			circuit->category.good = game->GetCategoriesFlag(result->category.good.c_str());

			if (result->profile != nullptr) {
				for (unsigned j = 0; j < result->profile->GetSize(); ++j) {
					outCfgParts.push_back(*(std::string*)result->profile->At(j));
				}
			}
		}
		// NOTE: Init context shouldn't be used again, hence release;
		//       assuming it contains references to unused types.
		script->ReleaseContext(ctx);
	}

	mod->Discard();
	// NOTE: destroys "array<T>". "main" should be registered and loaded first,
	//       then "array<T>" will be in defaultGroup. But main-first is not a viable option.
	//       And re-creating CScriptManager is not worth the effort.
//	r = script->GetEngine()->RemoveConfigGroup(CScriptManager::initName.c_str()); ASSERT(r >= 0);
	return true;
}

void CInitScript::RegisterCore()
{
	asIScriptEngine* engine = script->GetEngine();

	auto cache = static_cast<CScriptManager::STypeInfoCache*>(engine->GetUserData());
	cache->floatArray = engine->GetTypeInfoByDecl("array<float>");

	// RegisterSpringai
	static_assert(std::is_base_of<float3, AIFloat3>::value, "AIFloat3 must be a subclass of float3!");
	static_assert(sizeof(AIFloat3) == sizeof(float3), "Memory layout of AIFloat3 must be same as float3");
	// FIXME: MinGW didn't like asbind20; 1st value_class<float3> => value_class<AIFloat3>?
//	asbind20::value_class<float3>(
//		engine,
//		"AIFloat3",
//		// value_class is asOBJ_VALUE. Other flags will be automatically set using asGetTypeTraits<T>()
//		asOBJ_POD | asOBJ_APP_CLASS_ALLFLOATS | asOBJ_APP_CLASS_MORE_CONSTRUCTORS
//	)
//		.behaviours_by_traits()
//		.constructor<float>("float", asbind20::use_explicit)
//		.constructor_function("float, float, float", &ConstructVec3Val)
//		.property("float x", &float3::x)
//		.property("float y", &float3::y)
//		.property("float z", &float3::z)
//		.opAdd()                                             // float3 operator+ (const float3& f) const
//		.use(asbind20::const_this + asbind20::param<float>)  // float3 operator+ (const float f) const
//		.opAddAssign()                                       // float3& operator+= (const float3& f)
//		.opSub()                                             // float3 operator- (const float3& f) const
//		.use(asbind20::const_this - asbind20::param<float>)  // float3 operator- (const float f) const
//		.method("void opSubAssign(const AIFloat3& in)", &float3::operator-=)  // bad opSubAssign in float3
//		.opNeg()                                             // constexpr float3 operator- () const
//		.opMul()                                             // float3 operator* (const float3& f) const
//		.use(asbind20::const_this * asbind20::param<float>)  // float3 operator* (const float f) const
////		.use(asbind20::param<float> * asbind20::const_this)  // inline float3 operator*(float f, const float3& v)
//		.method("void opMulAssign(const AIFloat3& in)", asbind20::overload_cast<float>(&float3::operator*=))  // bad opMulAssign in float3
//		.use(asbind20::_this *= asbind20::param<float>)      // float3& operator*= (float f)
//		.opDiv()                                             // float3 operator/ (const float3& f) const
//		.use(asbind20::const_this / asbind20::param<float>)  // float3 operator/ (const float f) const
//		.method("void opDivAssign(const AIFloat3& in)", asbind20::overload_cast<const float3&>(&float3::operator/=))  // bad opDivAssign in float3
//		.method("void opDivAssign(const float)", asbind20::overload_cast<float>(&float3::operator/=))  // void operator/= (const float f)
//		.opEquals()                                          // bool operator== (const float3& f) const
//		.use(asbind20::_this[asbind20::param<int>])          // float& operator[] (const int t)
//		.use(asbind20::const_this[asbind20::param<int>])     // const float& operator[] (const int t) const
//		.method("bool equals(const AIFloat3& in, const AIFloat3& in) const", &float3::equals)
//		.method("bool same(const AIFloat3& in) const", &float3::same)
//		.method("bool binarySame(const AIFloat3& in) const", &float3::binarySame)
//		.method("float dot(const AIFloat3& in) const", &float3::dot)
//		.method("float dot2D(const AIFloat3& in) const", &float3::dot2D)
//		.method("AIFloat3 cross(const AIFloat3& in) const", &float3::cross)
//		.method("AIFloat3 rotate(float, const AIFloat3& in) const", &float3::rotate<false>)
//		.method("AIFloat3 rotateByUpVector(const AIFloat3& in, const AIFloat3& in) const", &float3::rotateByUpVector)
//		.method("AIFloat3 rotate2D(const AIFloat3& in) const", &float3::rotate2D)
//		.method("AIFloat3 snapToAxis() const", &float3::snapToAxis)
//		.method("float distance(const AIFloat3& in) const", &float3::distance)
//		.method("float distance2D(const AIFloat3& in) const", asbind20::overload_cast<const float3&>(&float3::distance2D, asbind20::const_))
//		.method("float SqDistance(const AIFloat3& in) const", &float3::SqDistance)
//		.method("float SqDistance2D(const AIFloat3& in) const", asbind20::overload_cast<const float3&>(&float3::SqDistance2D, asbind20::const_))
//		.method("float Length() const", &float3::Length)
//		.method("float Length2D() const", &float3::Length2D)
//		.method("float SqLength() const", &float3::SqLength)
//		.method("float SqLength2D() const", &float3::SqLength2D)
//		.method("float LengthNormalize()", &float3::LengthNormalize)
//		.method("float LengthNormalize2D()", &float3::LengthNormalize2D)
//		.method("AIFloat3& Normalize()", &float3::Normalize)
//		.method("AIFloat3& Normalize2D()", &float3::Normalize2D)
//		.method("AIFloat3& SafeNormalize()", &float3::SafeNormalize)
//		.method("AIFloat3& SafeNormalize2D()", &float3::SafeNormalize2D)
//		.method("AIFloat3 PickNonParallel() const", &float3::PickNonParallel)
//		.method("bool Normalized() const", &float3::Normalized)
//		.method("bool CheckNaNs() const", &float3::CheckNaNs)
//		.method("bool IsInMap() const", &float3::IsInMap)
//		.method("void ClampInMap()", &float3::ClampInMap)
//		.method("string str() const", &float3::str)
//		.method("string ToString() const", &AIFloat3::ToString)  // HAX
//		.method("string opImplConv() const", [](const float3& f) {
//			return f.str();  // static_cast<const AIFloat3&>(f).ToString();
//		});
//
//	// NOTE: ".use(asbind20::param<float> * asbind20::const_this)" makes IDE go "Syntax error" (but compiles)
//	int r = engine->RegisterObjectMethod("AIFloat3", "AIFloat3 opMul_r(float) const", asFUNCTIONPR(operator*, (float, const float3&), float3), asCALL_CDECL_OBJLAST); ASSERT(r >= 0);
//	asbind20::global(engine)
//		.function("AIFloat3 AiMin(const AIFloat3, const AIFloat3)", &float3::min)
//		.function("AIFloat3 AiMax(const AIFloat3, const AIFloat3)", &float3::max)
//		.function("AIFloat3 AiFabs(const AIFloat3)", &float3::fabs)
//		.function("AIFloat3 AiSign(const AIFloat3)", &float3::sign);

	// WARNING: asGetTypeTraits<float3>() has no asOBJ_APP_CLASS_COPY_CONSTRUCTOR flag, unlike AIFloat3
	//     and fails with this==nullptr if method/function returns AIFloat3
	int r = engine->RegisterObjectType("AIFloat3", sizeof(AIFloat3),
			asOBJ_VALUE | asOBJ_POD | asOBJ_APP_CLASS_ALLFLOATS | asOBJ_APP_CLASS_MORE_CONSTRUCTORS | asGetTypeTraits<AIFloat3>()); ASSERT(r >= 0);
	cache->vec3Array = engine->GetTypeInfoByDecl("array<AIFloat3>");
	r = engine->RegisterObjectBehaviour("AIFloat3", asBEHAVE_CONSTRUCT, "void f()", asFUNCTION(ConstructVec3), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectBehaviour("AIFloat3", asBEHAVE_CONSTRUCT, "void f(const AIFloat3& in)", asFUNCTION(ConstructCopyVec3), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectBehaviour("AIFloat3", asBEHAVE_CONSTRUCT, "void f(float)", asFUNCTION(ConstructVec3Val1), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectBehaviour("AIFloat3", asBEHAVE_CONSTRUCT, "void f(float, float, float)", asFUNCTION(ConstructVec3Val3), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("AIFloat3", "float x", asOFFSET(float3, x)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("AIFloat3", "float y", asOFFSET(float3, y)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("AIFloat3", "float z", asOFFSET(float3, z)); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "AIFloat3 opAdd(const AIFloat3& in) const", asMETHODPR(float3, operator+, (const float3&) const, float3), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "AIFloat3 opAdd(float) const", asMETHODPR(float3, operator+, (const float) const, float3), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "AIFloat3& opAddAssign(const AIFloat3& in)", asMETHOD(float3, operator+=), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "AIFloat3 opSub(const AIFloat3& in) const", asMETHODPR(float3, operator-, (const float3&) const, float3), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "AIFloat3 opSub(float) const", asMETHODPR(float3, operator-, (const float) const, float3), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "void opSubAssign(const AIFloat3& in)", asMETHOD(float3, operator-=), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "AIFloat3 opNeg() const", asMETHODPR(float3, operator-, () const, float3), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "AIFloat3 opMul(const AIFloat3& in) const", asMETHODPR(float3, operator*, (const float3&) const, float3), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "AIFloat3 opMul(float) const", asMETHODPR(float3, operator*, (const float) const, float3), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "AIFloat3 opMul_r(float) const", asFUNCTIONPR(operator*, (float, const float3&), float3), asCALL_CDECL_OBJLAST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "void opMulAssign(const AIFloat3& in)", asMETHODPR(float3, operator*=, (const float3&), void), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "AIFloat3& opMulAssign(float)", asMETHODPR(float3, operator*=, (float), float3&), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "AIFloat3 opDiv(const AIFloat3& in) const", asMETHODPR(float3, operator/, (const float3&) const, float3), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "AIFloat3 opDiv(float) const", asMETHODPR(float3, operator/, (const float) const, float3), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "void opDivAssign(const AIFloat3& in)", asMETHODPR(float3, operator/=, (const float3&), void), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "void opDivAssign(float)", asMETHODPR(float3, operator/=, (const float), void), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "bool opEquals(const AIFloat3& in) const", asMETHOD(float3, operator==), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "float& opIndex(int)", asMETHODPR(float3, operator[], (const int), float&), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "const float& opIndex(int) const", asMETHODPR(float3, operator[], (const int) const, const float&), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "bool equals(const AIFloat3& in, const AIFloat3& in) const", asMETHOD(float3, equals), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "bool same(const AIFloat3& in) const", asMETHOD(float3, same), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "bool binarySame(const AIFloat3& in) const", asMETHOD(float3, binarySame), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "float dot(const AIFloat3& in) const", asMETHOD(float3, dot), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "float dot2D(const AIFloat3& in) const", asMETHOD(float3, dot2D), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "AIFloat3 cross(const AIFloat3& in) const", asMETHOD(float3, cross), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "AIFloat3 rotate(float, const AIFloat3& in) const", asMETHODPR(float3, rotate<false>, (float angle, const float3& axis) const, float3), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "AIFloat3 rotateByUpVector(const AIFloat3& in, const AIFloat3& in) const", asMETHOD(float3, rotateByUpVector), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "AIFloat3 rotate2D(const AIFloat3& in) const", asMETHOD(float3, rotate2D), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "AIFloat3 snapToAxis() const", asMETHOD(float3, snapToAxis), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "float distance(const AIFloat3& in) const", asMETHOD(float3, distance), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "float distance2D(const AIFloat3& in) const", asMETHODPR(float3, distance2D, (const float3&) const, float), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "float SqDistance(const AIFloat3& in) const", asMETHOD(float3, SqDistance), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "float SqDistance2D(const AIFloat3& in) const", asMETHODPR(float3, SqDistance2D, (const float3&) const, float), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "float Length() const", asMETHOD(float3, Length), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "float Length2D() const", asMETHOD(float3, Length2D), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "float SqLength() const", asMETHOD(float3, SqLength), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "float SqLength2D() const", asMETHOD(float3, SqLength2D), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "float LengthNormalize()", asMETHOD(float3, LengthNormalize), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "float LengthNormalize2D()", asMETHOD(float3, LengthNormalize2D), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "AIFloat3& Normalize()", asMETHOD(float3, Normalize), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "AIFloat3& Normalize2D()", asMETHOD(float3, Normalize2D), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "AIFloat3& SafeNormalize()", asMETHOD(float3, SafeNormalize), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "AIFloat3& SafeNormalize2D()", asMETHOD(float3, SafeNormalize2D), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "AIFloat3 PickNonParallel() const", asMETHOD(float3, PickNonParallel), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "bool Normalized() const", asMETHOD(float3, Normalized), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "bool CheckNaNs() const", asMETHOD(float3, CheckNaNs), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "bool IsInMap() const", asMETHOD(float3, IsInMap), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "void ClampInMap()", asMETHOD(float3, ClampInMap), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "string str() const", asMETHOD(float3, str), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("AIFloat3", "string ToString() const", asMETHOD(AIFloat3, ToString), asCALL_THISCALL); ASSERT(r >= 0);  // HAX
	r = engine->RegisterObjectMethod("AIFloat3", "string opImplConv() const", asFUNCTION(ConvertVec3ToStr), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterGlobalFunction("AIFloat3 AiMin(const AIFloat3, const AIFloat3)", asFUNCTION(float3::min), asCALL_CDECL); ASSERT(r >= 0);
	r = engine->RegisterGlobalFunction("AIFloat3 AiMax(const AIFloat3, const AIFloat3)", asFUNCTION(float3::max), asCALL_CDECL); ASSERT(r >= 0);
	r = engine->RegisterGlobalFunction("AIFloat3 AiFabs(const AIFloat3)", asFUNCTION(float3::fabs), asCALL_CDECL); ASSERT(r >= 0);
	r = engine->RegisterGlobalFunction("AIFloat3 AiSign(const AIFloat3)", asFUNCTION(float3::sign), asCALL_CDECL); ASSERT(r >= 0);

	r = engine->RegisterObjectMethod("AIFloat3", "bool IsInRange(const AIFloat3& in, float) const", asFUNCTION(geom::is_in_range), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);

	// RegisterGeometry
	geom::CPolygon::RegisterRefCounted(engine, "CPolygon");
	r = engine->RegisterObjectBehaviour("CPolygon", asBEHAVE_FACTORY, "CPolygon@ f(const array<AIFloat3>@+)", asFUNCTION(FactoryCPolygon), asCALL_CDECL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CPolygon", "array<AIFloat3>@ GetVerts() const", asFUNCTION(CPolygon_GetVerts), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CPolygon", "const float area", asOFFSET(geom::CPolygon, area)); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CPolygon", "bool ContainsPoint(const AIFloat3& in) const", asMETHOD(geom::CPolygon, ContainsPoint), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CPolygon", "AIFloat3 Random() const", asMETHOD(geom::CPolygon, Random), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CPolygon", "void Scale(float)", asMETHOD(geom::CPolygon, Scale), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CPolygon", "void Extend(float)", asMETHOD(geom::CPolygon, Extend), asCALL_THISCALL); ASSERT(r >= 0);

	// RegisterUtils
//	asbind20::global(engine)
//		.function("void AiLog(const string& in)", &CInitScript::Log, asbind20::auxiliary(this));
	r = engine->RegisterGlobalFunction("void AiLog(const string& in)", asMETHOD(CInitScript, Log), asCALL_THISCALL_ASGLOBAL, this); ASSERT(r >= 0);
	r = engine->RegisterGlobalFunction("void AiAddPoint(const AIFloat3& in, const string& in)", asMETHOD(CInitScript, AddPoint), asCALL_THISCALL_ASGLOBAL, this); ASSERT(r >= 0);
	r = engine->RegisterGlobalFunction("void AiDelPoint(const AIFloat3& in)", asMETHOD(CInitScript, DelPoint), asCALL_THISCALL_ASGLOBAL, this); ASSERT(r >= 0);
	r = engine->RegisterGlobalFunction("void AiAddLine(const AIFloat3& in, const AIFloat3& in)", asMETHOD(CInitScript, AddLine), asCALL_THISCALL_ASGLOBAL, this); ASSERT(r >= 0);
	r = engine->RegisterGlobalFunction("void AiPause(bool, const string& in)", asMETHOD(CInitScript, Pause), asCALL_THISCALL_ASGLOBAL, this); ASSERT(r >= 0);
	r = engine->RegisterGlobalFunction("int AiDice(const array<float>@+)", asMETHOD(CInitScript, Dice), asCALL_THISCALL_ASGLOBAL, this); ASSERT(r >= 0);
	r = engine->RegisterGlobalFunction("int AiNearestPointIdx(const AIFloat3& in, const array<AIFloat3>@+)", asMETHOD(CInitScript, NearestPointIdx), asCALL_THISCALL_ASGLOBAL, this); ASSERT(r >= 0);
	r = engine->RegisterGlobalFunction("int AiMin(int, int)", asMETHODPR(CInitScript, Min<int>, (int, int) const, int), asCALL_THISCALL_ASGLOBAL, this); ASSERT(r >= 0);
	r = engine->RegisterGlobalFunction("float AiMin(float, float)", asMETHODPR(CInitScript, Min<float>, (float, float) const, float), asCALL_THISCALL_ASGLOBAL, this); ASSERT(r >= 0);
	r = engine->RegisterGlobalFunction("int AiMax(int, int)", asMETHODPR(CInitScript, Max<int>, (int, int) const, int), asCALL_THISCALL_ASGLOBAL, this); ASSERT(r >= 0);
	r = engine->RegisterGlobalFunction("float AiMax(float, float)", asMETHODPR(CInitScript, Max<float>, (float, float) const, float), asCALL_THISCALL_ASGLOBAL, this); ASSERT(r >= 0);
	r = engine->RegisterGlobalFunction("int AiRandom(int, int)", asMETHOD(CInitScript, Random), asCALL_THISCALL_ASGLOBAL, this); ASSERT(r >= 0);
	r = engine->RegisterGlobalFunction("void AiSendMessage(const string& in, int = -1)", asMETHOD(CInitScript, SendMessage), asCALL_THISCALL_ASGLOBAL, this); ASSERT(r >= 0);
	r = engine->RegisterFuncdef("void AiOnFinish(dictionary@+)"); ASSERT(r >= 0);
	r = engine->RegisterFuncdef("AiOnFinish@+ AiExec(dictionary@+)"); ASSERT(r >= 0);
	r = engine->RegisterGlobalFunction("void AiRun(AiExec@+, dictionary@)", asMETHOD(CInitScript, Run), asCALL_THISCALL_ASGLOBAL, this); ASSERT(r >= 0);
	r = engine->RegisterGlobalFunction("void AiSleep(uint64)", asFUNCTION(utils::sleep), asCALL_CDECL); ASSERT(r >= 0);

	r = engine->RegisterObjectType("IStream", sizeof(std::istream), asOBJ_REF | asOBJ_NOCOUNT); ASSERT(r >= 0);
	r = engine->RegisterObjectType("OStream", sizeof(std::ostream), asOBJ_REF | asOBJ_NOCOUNT); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("IStream", "IStream& opShr(bool& out)", asFUNCTION(utils::binary_read<bool>), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("IStream", "IStream& opShr(int8& out)", asFUNCTION(utils::binary_read<int8_t>), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("IStream", "IStream& opShr(int16& out)", asFUNCTION(utils::binary_read<int16_t>), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("IStream", "IStream& opShr(int& out)", asFUNCTION(utils::binary_read<int32_t>), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("IStream", "IStream& opShr(int64& out)", asFUNCTION(utils::binary_read<int64_t>), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("IStream", "IStream& opShr(uint8& out)", asFUNCTION(utils::binary_read<uint8_t>), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("IStream", "IStream& opShr(uint16& out)", asFUNCTION(utils::binary_read<uint16_t>), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("IStream", "IStream& opShr(uint& out)", asFUNCTION(utils::binary_read<uint32_t>), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("IStream", "IStream& opShr(uint64& out)", asFUNCTION(utils::binary_read<uint64_t>), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("IStream", "IStream& opShr(float& out)", asFUNCTION(utils::binary_read<float>), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("IStream", "IStream& opShr(double& out)", asFUNCTION(utils::binary_read<double>), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("OStream", "OStream& opShl(const bool& in)", asFUNCTION(utils::binary_write<bool>), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("OStream", "OStream& opShl(const int8& in)", asFUNCTION(utils::binary_write<int8_t>), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("OStream", "OStream& opShl(const int16& in)", asFUNCTION(utils::binary_write<int16_t>), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("OStream", "OStream& opShl(const int& in)", asFUNCTION(utils::binary_write<int32_t>), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("OStream", "OStream& opShl(const int64& in)", asFUNCTION(utils::binary_write<int64_t>), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("OStream", "OStream& opShl(const uint8& in)", asFUNCTION(utils::binary_write<uint8_t>), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("OStream", "OStream& opShl(const uint16& in)", asFUNCTION(utils::binary_write<uint16_t>), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("OStream", "OStream& opShl(const uint& in)", asFUNCTION(utils::binary_write<uint32_t>), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("OStream", "OStream& opShl(const uint64& in)", asFUNCTION(utils::binary_write<uint64_t>), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("OStream", "OStream& opShl(const float& in)", asFUNCTION(utils::binary_write<float>), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("OStream", "OStream& opShl(const double& in)", asFUNCTION(utils::binary_write<double>), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);

	r = engine->RegisterObjectMethod("string", "string toLower() const", asFUNCTION(utils::StringToLower), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("string", "string toUpper() const", asFUNCTION(utils::StringToUpper), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);

	// RegisterCircuitAI
	r = engine->RegisterTypedef("Id", "int"); ASSERT(r >= 0);
	cache->idArray = engine->GetTypeInfoByDecl("array<Id>");

	r = engine->RegisterObjectType("TypeMask", sizeof(CMaskHandler::TypeMask), asOBJ_VALUE | asOBJ_POD | asGetTypeTraits<CMaskHandler::TypeMask>()); ASSERT(r >= 0);
	r = engine->RegisterTypedef("Type", "int"); ASSERT(r >= 0);
	r = engine->RegisterTypedef("Mask", "uint"); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("TypeMask", "Type type", asOFFSET(CMaskHandler::TypeMask, type)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("TypeMask", "Mask mask", asOFFSET(CMaskHandler::TypeMask, mask)); ASSERT(r >= 0);

//	r = engine->SetDefaultNamespace("Task"); ASSERT(r >= 0);
//	r = engine->RegisterEnum("RecruitType"); ASSERT(r >= 0);
//	r = engine->RegisterEnumValue("RecruitType", "BUILDPOWER", static_cast<int>(CRecruitTask::RecruitType::BUILDPOWER)); ASSERT(r >= 0);
//	r = engine->RegisterEnumValue("RecruitType", "FIREPOWER", static_cast<int>(CRecruitTask::RecruitType::FIREPOWER)); ASSERT(r >= 0);
//	r = engine->SetDefaultNamespace(""); ASSERT(r >= 0);

	r = engine->RegisterObjectType("CCircuitAI", 0, asOBJ_REF | asOBJ_NOHANDLE); ASSERT(r >= 0);
	r = engine->RegisterGlobalProperty("CCircuitAI ai", circuit); ASSERT(r >= 0);

	r = engine->RegisterObjectType("CCircuitDef", 0, asOBJ_REF | asOBJ_NOCOUNT); ASSERT(r >= 0);
	r = engine->RegisterObjectType("CCircuitUnit", 0, asOBJ_REF | asOBJ_NOCOUNT); ASSERT(r >= 0);
	cache->unitArray = engine->GetTypeInfoByDecl("array<CCircuitUnit@>");
	RegisterUnitTasks(engine);

	r = engine->RegisterObjectProperty("CCircuitAI", "const int frame", asOFFSET(CCircuitAI, lastFrame)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CCircuitAI", "const int skirmishAIId", asOFFSET(CCircuitAI, skirmishAIId)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CCircuitAI", "const int teamId", asOFFSET(CCircuitAI, teamId)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CCircuitAI", "const int allyTeamId", asOFFSET(CCircuitAI, allyTeamId)); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitAI", "CCircuitDef@ GetCircuitDef(const string& in)", asFUNCTION(CCircuitAI_GetCircuitDef), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitAI", "CCircuitDef@ GetCircuitDef(Id)", asMETHODPR(CCircuitAI, GetCircuitDef, (CCircuitDef::Id), CCircuitDef*), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitAI", "int GetDefCount() const", asMETHOD(CCircuitAI, GetDefCount), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitAI", "CCircuitUnit@ GetTeamUnit(Id)", asMETHOD(CCircuitAI, GetTeamUnit), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitAI", "string GetMapName() const", asFUNCTION(CCircuitAI_GetMapName), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitAI", "int GetEnemyTeamSize() const", asMETHOD(CCircuitAI, GetEnemyTeamSize), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitAI", "bool IsLoadSave() const", asMETHOD(CCircuitAI, IsLoadSave), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitAI", "Type GetBindedRole(Type) const", asMETHOD(CCircuitAI, GetBindedRole), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitAI", "int GetLeadTeamId() const", asFUNCTION(CCircuitAI_GetLeadTeamId), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitAI", "Type GetSideId() const", asMETHOD(CCircuitAI, GetSideId), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitAI", "const string& GetSideName() const", asMETHOD(CCircuitAI, GetSideName), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitAI", "array<Id>@ GetTeamIds() const", asFUNCTION(CCircuitAI_GetTeamIds), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitAI", "void GiveUnits(const array<CCircuitUnit@>@+, int)", asFUNCTION(CCircuitAI_GiveUnits), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitAI", "bool UnitControl(CCircuitUnit@, bool)", asMETHODPR(CCircuitAI, UnitControl, (CCircuitUnit*, bool), bool), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitAI", "bool UnitControl(Id, bool)", asMETHODPR(CCircuitAI, UnitControl, (ICoreUnit::Id, bool), bool), asCALL_THISCALL); ASSERT(r >= 0);
	// Lua<-->AI communications [in Spring 0.83+]
	r = engine->RegisterObjectMethod("CCircuitAI", "string CallRules(const string& in)", asFUNCTION(CCircuitAI_CallRules), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitAI", "string CallUI(const string& in)", asFUNCTION(CCircuitAI_CallUI), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	// RulesParams accessors on AI (game/team)
	r = engine->RegisterObjectMethod("CCircuitAI", "float GetGameRulesParam(const string& in, float) const", asFUNCTION(CCircuitAI_GetGameRulesParamFloat), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitAI", "string GetGameRulesParam(const string& in, const string& in) const", asFUNCTION(CCircuitAI_GetGameRulesParamString), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitAI", "float GetTeamRulesParam(const string& in, float) const", asFUNCTION(CCircuitAI_GetTeamRulesParamFloat), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitAI", "string GetTeamRulesParam(const string& in, const string& in) const", asFUNCTION(CCircuitAI_GetTeamRulesParamString), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);

	CMaskHandler* sideMasker = &circuit->GetGameAttribute()->GetSideMasker();
	CMaskHandler* roleMasker = &circuit->GetGameAttribute()->GetRoleMasker();
	CMaskHandler* attrMasker = &circuit->GetGameAttribute()->GetAttrMasker();
	r = engine->RegisterObjectType("CMaskHandler", 0, asOBJ_REF | asOBJ_NOHANDLE); ASSERT(r >= 0);
	r = engine->RegisterGlobalProperty("CMaskHandler aiSideMasker", sideMasker); ASSERT(r >= 0);
	r = engine->RegisterGlobalProperty("CMaskHandler aiRoleMasker", roleMasker); ASSERT(r >= 0);
	r = engine->RegisterGlobalProperty("CMaskHandler aiAttrMasker", attrMasker); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CMaskHandler", "TypeMask GetTypeMask(const string& in)", asMETHOD(CMaskHandler, GetTypeMask), asCALL_THISCALL); ASSERT(r >= 0);

	r = engine->RegisterGlobalFunction("TypeMask AiAddRole(const string& in, Type)", asMETHOD(CInitScript, AddRole), asCALL_THISCALL_ASGLOBAL, this); ASSERT(r >= 0);

	r = engine->RegisterObjectMethod("CCircuitDef", "void SetMainRole(Type)", asMETHOD(CCircuitDef, SetMainRole), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitDef", "Type GetMainRole() const", asMETHOD(CCircuitDef, GetMainRole), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitDef", "bool IsRespRoleAny(Mask) const", asMETHOD(CCircuitDef, IsRespRoleAny), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitDef", "bool IsRoleAny(Mask) const", asMETHOD(CCircuitDef, IsRoleAny), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitDef", "void AddAttribute(Type)", asMETHOD(CCircuitDef, AddAttribute), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitDef", "void DelAttribute(Type)", asMETHOD(CCircuitDef, DelAttribute), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitDef", "void TglAttribute(Type)", asMETHOD(CCircuitDef, TglAttribute), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitDef", "bool IsAttrAny(Mask) const", asMETHOD(CCircuitDef, IsAttrAny), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitDef", "const string GetName() const", asFUNCTION(CCircuitDef_GetName), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CCircuitDef", "const Id id", asOFFSET(CCircuitDef, id)); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitDef", "bool IsAvailable(int)", asMETHODPR(CCircuitDef, IsAvailable, (int) const, bool), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CCircuitDef", "const int count", asOFFSET(CCircuitDef, count)); ASSERT(r >= 0);
	// The def's build options: what a constructor of this def can build (CR-006).
	r = engine->RegisterObjectMethod("CCircuitDef", "bool CanBuild(const CCircuitDef@) const", asMETHODPR(CCircuitDef, CanBuild, (const CCircuitDef*) const, bool), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CCircuitDef", "const float health", asOFFSET(CCircuitDef, health)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CCircuitDef", "const float speed", asOFFSET(CCircuitDef, speed)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CCircuitDef", "const float losRadius", asOFFSET(CCircuitDef, losRadius)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CCircuitDef", "const float sonarRadius", asOFFSET(CCircuitDef, sonarRadius)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CCircuitDef", "const float costM", asOFFSET(CCircuitDef, costM)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CCircuitDef", "const float costE", asOFFSET(CCircuitDef, costE)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CCircuitDef", "const float threat", asOFFSET(CCircuitDef, defThreat)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CCircuitDef", "const float power", asOFFSET(CCircuitDef, power)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CCircuitDef", "const float defDmg", asOFFSET(CCircuitDef, defThrDmg)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CCircuitDef", "const float pwrDmg", asOFFSET(CCircuitDef, pwrDmg)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CCircuitDef", "const float airThrDmg", asOFFSET(CCircuitDef, airThrDmg)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CCircuitDef", "const float surfThrDmg", asOFFSET(CCircuitDef, surfThrDmg)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CCircuitDef", "const float waterThrDmg", asOFFSET(CCircuitDef, waterThrDmg)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CCircuitDef", "const float minRange", asOFFSET(CCircuitDef, minRange)); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitDef", "float GetMaxRange(Type) const", asMETHODPR(CCircuitDef, GetMaxRange, (CCircuitDef::RangeType) const, float), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitDef", "float GetMaxRange() const", asMETHODPR(CCircuitDef, GetMaxRange, () const, float), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitDef", "void SetRange(Type, float)", asMETHODPR(CCircuitDef, SetRange, (CCircuitDef::RangeType, float), void), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitDef", "void SetRange(float)", asMETHODPR(CCircuitDef, SetRange, (float), void), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitDef", "float GetAirThreat() const", asMETHOD(CCircuitDef, GetAirThreat), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitDef", "float GetSurfThreat() const", asMETHOD(CCircuitDef, GetSurfThreat), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitDef", "float GetWaterThreat() const", asMETHOD(CCircuitDef, GetWaterThreat), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitDef", "bool IsAbleToFly() const", asMETHOD(CCircuitDef, IsAbleToFly), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitDef", "bool IsMobile() const", asMETHOD(CCircuitDef, IsMobile), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitDef", "int GetFootprintX() const", asFUNCTION(CCircuitDef_GetFootprintX), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitDef", "int GetFootprintZ() const", asFUNCTION(CCircuitDef_GetFootprintZ), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CCircuitDef", "int maxThisUnit", asOFFSET(CCircuitDef, maxThisUnit)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CCircuitDef", "int sinceFrame", asOFFSET(CCircuitDef, sinceFrame)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CCircuitDef", "int cooldown", asOFFSET(CCircuitDef, cooldown)); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitDef", "void SetIgnore(bool)", asMETHOD(CCircuitDef, SetIgnore), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitDef", "bool IsIgnore() const", asMETHOD(CCircuitDef, IsIgnore), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitDef", "void SetThreatKernel(float)", asMETHOD(CCircuitDef, SetThreatKernel), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitDef", "void SetFireState(int)", asMETHOD(CCircuitDef, SetFireState), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitDef", "int GetFireState() const", asMETHOD(CCircuitDef, GetFireState), asCALL_THISCALL); ASSERT(r >= 0);

	r = engine->RegisterObjectProperty("CCircuitUnit", "const Id id", asOFFSET(CCircuitUnit, id)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CCircuitUnit", "const CCircuitDef@ circuitDef", asOFFSET(CCircuitUnit, circuitDef)); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitUnit", "const AIFloat3& GetPos(int)", asMETHODPR(CCircuitUnit, GetPos, (int), const AIFloat3&), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitUnit", "void AddAttribute(Type)", asMETHOD(CCircuitUnit, AddAttribute), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitUnit", "void DelAttribute(Type)", asMETHOD(CCircuitUnit, DelAttribute), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitUnit", "void TglAttribute(Type)", asMETHOD(CCircuitUnit, TglAttribute), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitUnit", "bool IsAttrAny(Mask) const", asMETHOD(CCircuitUnit, IsAttrAny), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitUnit", "void SetFireState(int)", asMETHOD(CCircuitUnit, TrySetFireState), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitUnit", "void SetMoveState(int)", asMETHOD(CCircuitUnit, TrySetMoveState), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitUnit", "void SelfDestruct(bool)", asMETHOD(CCircuitUnit, CmdSelfD), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CCircuitUnit", "IUnitTask@ const task", asOFFSET(CCircuitUnit, task)); ASSERT(r >= 0);
	// RulesParams accessor on Unit
	r = engine->RegisterObjectMethod("CCircuitUnit", "float GetRulesParam(const string& in, float) const", asFUNCTION(CCircuitUnit_GetRulesParamFloat), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitUnit", "string GetRulesParam(const string& in, const string& in) const", asFUNCTION(CCircuitUnit_GetRulesParamString), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
}

void CInitScript::RegisterMgr()
{
	asIScriptEngine* engine = script->GetEngine();

	CTerrainManager* terrainMgr = circuit->GetTerrainManager();
	int r = engine->RegisterObjectType("CTerrainManager", 0, asOBJ_REF | asOBJ_NOHANDLE); ASSERT(r >= 0);
	r = engine->RegisterGlobalProperty("CTerrainManager aiTerrainMgr", terrainMgr); ASSERT(r >= 0);
	r = engine->RegisterGlobalFunction("int AiTerrainWidth()", asFUNCTION(CTerrainManager::GetTerrainWidth), asCALL_CDECL); ASSERT(r >= 0);
	r = engine->RegisterGlobalFunction("int AiTerrainHeight()", asFUNCTION(CTerrainManager::GetTerrainHeight), asCALL_CDECL); ASSERT(r >= 0);
	r = engine->RegisterGlobalFunction("float AiTerrainDiagonal()", asFUNCTION(CTerrainManager::GetTerrainDiagonal), asCALL_CDECL); ASSERT(r >= 0);
	r = engine->RegisterGlobalFunction("AIFloat3 AiTerrainCenter()", asFUNCTION(CTerrainManager::GetTerrainCenter), asCALL_CDECL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "bool IsWaterAVoid() const", asMETHOD(CTerrainManager, IsWaterAVoid), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "float GetLandPercent() const", asMETHOD(CTerrainManager, GetLandPercent), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "float SetAllyZoneRange(float)", asMETHOD(CTerrainManager, SetAllyZoneRange), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "int GetTerrainWidth() const", asFUNCTION(CTerrainManager_GetTerrainWidth), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	// Reservations: doc/base-layout.md
	r = engine->RegisterObjectMethod("CTerrainManager", "int ReserveBuilding(const CCircuitDef@, const AIFloat3& in, int facing, int ttlFrames = 0)", asFUNCTION(CTerrainManager_ReserveBuilding), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "int ReserveGrid(const CCircuitDef@, const AIFloat3& in frontCentre, int facing, int cols, int rows, int gap, int ttlFrames = 0)", asFUNCTION(CTerrainManager_ReserveGrid), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "int ReserveNanoBlockAt(const CCircuitDef@ nanoDef, const CCircuitDef@ facDef, const AIFloat3& in facPos, int facing, int cols, int rows, int gap)", asFUNCTION(CTerrainManager_ReserveNanoBlockAt), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "int ReserveNanoBlock(CCircuitUnit@ factory, const CCircuitDef@ nanoDef, int cols, int rows, int gap)", asFUNCTION(CTerrainManager_ReserveNanoBlock), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "bool CanReserveBuilding(const CCircuitDef@, const AIFloat3& in, int facing)", asFUNCTION(CTerrainManager_CanReserveBuilding), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "float BuildableFraction(const CCircuitDef@, const AIFloat3& in centre, float halfAcross, float halfAlong, int facing)", asFUNCTION(CTerrainManager_BuildableFraction), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "void ReleaseReservation(int)", asMETHOD(CTerrainManager, ReleaseReservation), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "void ReleaseGroup(int)", asMETHOD(CTerrainManager, ReleaseGroup), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "bool IsReserved(const AIFloat3& in) const", asMETHOD(CTerrainManager, IsReserved), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "int GetReservationCount(const CCircuitDef@) const", asFUNCTION(CTerrainManager_GetReservationCount), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CTerrainManager", "float reservationMatchRadius", asOFFSET(CTerrainManager, reservationMatchRadius)); ASSERT(r >= 0);
	// Layout: JSON permits the mechanism and TECH opts its own AI instance in.
	r = engine->RegisterObjectMethod("CTerrainManager", "bool SetLayoutEnabled(bool)", asMETHOD(CTerrainManager, SetLayoutEnabled), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "bool IsLayoutEnabled() const", asMETHOD(CTerrainManager, IsLayoutEnabled), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "bool IsLayoutConfigured() const", asMETHOD(CTerrainManager, IsLayoutConfigured), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "bool PlanFactoryPair(const string& in, const CCircuitDef@, const CCircuitDef@, const CCircuitDef@, const AIFloat3& in, int facing, int sideOffsetCells, int forwardOffsetCells)", asFUNCTION(CTerrainManager_PlanFactoryPair), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "int GetFactoryNanoAvailable() const", asMETHOD(CTerrainManager, GetFactoryNanoAvailable), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "int GetFactoryNanoActive() const", asMETHOD(CTerrainManager, GetFactoryNanoActive), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "bool HasLayoutGroup(const string& in) const", asMETHOD(CTerrainManager, HasLayoutGroup), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "int GetLayoutGroupTotal(const string& in) const", asMETHOD(CTerrainManager, GetLayoutGroupTotal), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "int GetLayoutGroupBuilt(const string& in) const", asMETHOD(CTerrainManager, GetLayoutGroupBuilt), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "int GetLayoutGroupStarted(const string& in) const", asMETHOD(CTerrainManager, GetLayoutGroupStarted), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "int GetLayoutGroupAvailable(const string& in) const", asMETHOD(CTerrainManager, GetLayoutGroupAvailable), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "int GetLayoutInt(const string& in, int fallback = 0) const", asMETHOD(CTerrainManager, GetLayoutInt), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "AIFloat3 GetLayoutGroupCenter(const string& in) const", asMETHOD(CTerrainManager, GetLayoutGroupCenter), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "int ReserveZone(const AIFloat3& in centre, int facing, float halfAcross, float halfAlong, bool corridor)", asMETHOD(CTerrainManager, ReserveZone), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "void ReleaseZone(int)", asMETHOD(CTerrainManager, ReleaseZone), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "int ReserveExitCone(CCircuitUnit@ factory, float length, float margin)", asMETHOD(CTerrainManager, ReserveExitCone), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "bool IsZoneClear(int) const", asMETHOD(CTerrainManager, IsZoneClear), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "int LayBand(int zone, const CCircuitDef@, const AIFloat3& in frontCentre, int facing, int cols, int rows, int gap, bool armed, bool anyReach, bool tenant, int group = 0)", asFUNCTION(CTerrainManager_LayBand), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "void ArmGroup(int group, bool armed)", asMETHOD(CTerrainManager, ArmGroup), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "void ReleaseUnconsumed(int group)", asMETHOD(CTerrainManager, ReleaseUnconsumed), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "int GetGroupCount(int group, bool unconsumedOnly) const", asMETHOD(CTerrainManager, GetGroupCount), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "int NextSlot(int group, const AIFloat3& in anchor) const", asMETHOD(CTerrainManager, NextSlot), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "int NextBuilt(int group, const AIFloat3& in anchor) const", asMETHOD(CTerrainManager, NextBuilt), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "int NextSlotAny(int group, const AIFloat3& in anchor) const", asMETHOD(CTerrainManager, NextSlotAny), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "void SetLayoutInt(const string& in, int)", asMETHOD(CTerrainManager, SetLayoutInt), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "int PackNearGroup(int zone, const CCircuitDef@, int nanoGroup, int facing, const AIFloat3& in anchor, float maxReach, float minNanoDist, int group)", asFUNCTION(CTerrainManager_PackNearGroup), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "bool CanPackNearGroup(int zone, const CCircuitDef@, int nanoGroup, int facing, float maxReach, float minNanoDist)", asFUNCTION(CTerrainManager_CanPackNearGroup), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "AIFloat3 GetReservationPos(int) const", asMETHOD(CTerrainManager, GetReservationPos), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "int GetReservationFacing(int) const", asMETHOD(CTerrainManager, GetReservationFacing), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "CCircuitUnit@ GetReservationUnit(int) const", asMETHOD(CTerrainManager, GetReservationUnit), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "float FlatFraction(const AIFloat3& in centre, int facing, float halfAcross, float halfAlong, float maxSlope) const", asMETHOD(CTerrainManager, FlatFraction), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "string DescribeLayout() const", asMETHOD(CTerrainManager, DescribeLayout), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "void ResetLayout()", asMETHOD(CTerrainManager, ResetLayout), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterGlobalFunction("bool AiPinReservation(IUnitTask@, int)", asFUNCTION(IBuilderTask_PinReservation), asCALL_CDECL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitAI", "float GetWindMin() const", asFUNCTION(CCircuitAI_WindMin), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitAI", "float GetWindMax() const", asFUNCTION(CCircuitAI_WindMax), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitAI", "float GetWindCur() const", asFUNCTION(CCircuitAI_WindCur), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitAI", "float GetTidalStrength() const", asFUNCTION(CCircuitAI_Tidal), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CCircuitAI", "int GetMetalSpotCount() const", asFUNCTION(CCircuitAI_MetalSpots), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterGlobalFunction("int AiTaskReservationId(IUnitTask@)", asFUNCTION(IBuilderTask_GetReservationId), asCALL_CDECL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CTerrainManager", "int GetTerrainHeight() const", asFUNCTION(CTerrainManager_GetTerrainHeight), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);

	r = engine->RegisterObjectProperty("CSetupManager", "const CCircuitDef@ commChoice", asOFFSET(CSetupManager, commChoice)); ASSERT(r >= 0);
	// The lane point native computes for the front (CalcLanePos); a layout faces it (D-053).
	r = engine->RegisterObjectMethod("CSetupManager", "AIFloat3 GetLanePos() const", asFUNCTION(CSetupManager_GetLanePos), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);

	CEnemyManager* enemyMgr = circuit->GetEnemyManager();
	r = engine->RegisterObjectType("CEnemyManager", 0, asOBJ_REF | asOBJ_NOHANDLE); ASSERT(r >= 0);
	r = engine->RegisterGlobalProperty("CEnemyManager aiEnemyMgr", enemyMgr); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CEnemyManager", "float GetEnemyThreat(Type) const", asMETHODPR(CEnemyManager, GetEnemyThreat, (CCircuitDef::RoleT) const, float), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CEnemyManager", "const float mobileThreat", asOFFSET(CEnemyManager, mobileThreat)); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CEnemyManager", "float GetEnemyCost(Type) const", asMETHOD(CEnemyManager, GetEnemyCost), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty("CEnemyManager", "float maxAAThreat", asOFFSET(CEnemyManager, maxAAThreat)); ASSERT(r >= 0);

	CThreatMap* thrMap = circuit->GetThreatMap();
	r = engine->RegisterObjectType("CThreatMap", 0, asOBJ_REF | asOBJ_NOHANDLE); ASSERT(r >= 0);
	r = engine->RegisterGlobalProperty("CThreatMap aiThreat", thrMap); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CThreatMap", "void ApplyRange(CCircuitDef@)", asMETHOD(CThreatMap, ApplyRange), asCALL_THISCALL); ASSERT(r >= 0);
}

bool CInitScript::Init()
{
	if (!script->Load(CScriptManager::mainName.c_str(), folderName, CScriptManager::mainName + ".as")) {
		return false;
	}

	asIScriptModule* mod = script->GetEngine()->GetModule(CScriptManager::mainName.c_str());
	int r = mod->SetDefaultNamespace("Main"); ASSERT(r >= 0);
	mainInfo.update = script->GetFunc(mod, "void AiUpdate()");
	mainInfo.luaMessage = script->GetFunc(mod, "void AiLuaMessage(const string& in)");
	mainInfo.receiveMessage = script->GetFunc(mod, "void AiMessage(const string& in, int)");
	mainInfo.unitFinished = script->GetFunc(mod, "void AiUnitFinished(CCircuitUnit@)");
	mainInfo.unitDestroyed = script->GetFunc(mod, "void AiUnitDestroyed(CCircuitUnit@)");
	asIScriptFunction* main = script->GetFunc(mod, "void AiMain()");
	if (main == nullptr) {
		return false;
	}

	asIScriptContext* ctx = script->PrepareContext(main);
	script->Exec(ctx);
	script->ReturnContext(ctx);
	return true;
}

void CInitScript::Update()
{
	if (mainInfo.update == nullptr) {
		return;
	}
	asIScriptContext* ctx = script->PrepareContext(mainInfo.update);
	script->Exec(ctx);
	script->ReturnContext(ctx);
}

void CInitScript::LuaMessage(const char* inData)
{
	if (mainInfo.luaMessage == nullptr) {
		return;
	}
	asIScriptContext* ctx = script->PrepareContext(mainInfo.luaMessage);
	std::string data(inData);
	ctx->SetArgAddress(0, &data);
	script->Exec(ctx);
	script->ReturnContext(ctx);
}

void CInitScript::UnitFinished(CCircuitUnit* unit)
{
	if (mainInfo.unitFinished == nullptr) {
		return;
	}
	asIScriptContext* ctx = script->PrepareContext(mainInfo.unitFinished);
	ctx->SetArgObject(0, unit);
	script->Exec(ctx);
	script->ReturnContext(ctx);
}

void CInitScript::UnitDestroyed(CCircuitUnit* unit)
{
	if (mainInfo.unitDestroyed == nullptr) {
		return;
	}
	asIScriptContext* ctx = script->PrepareContext(mainInfo.unitDestroyed);
	ctx->SetArgObject(0, unit);
	script->Exec(ctx);
	script->ReturnContext(ctx);
}

template <class T>
void CInitScript::RegisterIUnitTask(asIScriptEngine* engine, const char* cls)
{
	T::RegisterRefCounted(engine, cls);
	int r;
	r = engine->RegisterObjectMethod(cls, "Type GetType() const", asMETHODPR(T, GetType, () const, IUnitTask::Type), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod(cls, "array<CCircuitUnit@>@ GetUnits() const", asFUNCTION(IUnitTask_GetUnits), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod(cls, "void Abort()", asMETHOD(T, Abort), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod(cls, "void Done()", asMETHOD(T, Done), asCALL_THISCALL); ASSERT(r >= 0);
}

template <class T>
void CInitScript::RegisterIBuilderTask(asIScriptEngine* engine, const char* cls)
{
	RegisterIUnitTask<T>(engine, cls);
	RegisterCast<IUnitTask, T>(engine, "IUnitTask", cls);
	int r;
	r = engine->RegisterObjectMethod(cls, "Type GetBuildType() const", asMETHODPR(T, GetBuildType, () const, IBuilderTask::BuildType), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod(cls, "const AIFloat3& GetBuildPos() const", asMETHODPR(T, GetPosition, () const, const AIFloat3&), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty(cls, "CCircuitDef@ const buildDef", asOFFSET(T, buildDef)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty(cls, "CCircuitUnit@ const target", asOFFSET(T, target)); ASSERT(r >= 0);
	r = engine->RegisterObjectProperty(cls, "bool canAutoAbort", asOFFSET(T, canAutoAbort)); ASSERT(r >= 0);
}

template <class T>
void CInitScript::RegisterIFighterTask(asIScriptEngine* engine, const char* cls)
{
	RegisterIUnitTask<T>(engine, cls);
	RegisterCast<IUnitTask, T>(engine, "IUnitTask", cls);
	int r = engine->RegisterObjectMethod(cls, "Type GetFightType() const", asMETHODPR(T, GetFightType, () const, IFighterTask::FightType), asCALL_THISCALL); ASSERT(r >= 0);
}

void CInitScript::RegisterCSuperTask(asIScriptEngine* engine)
{
	RegisterIFighterTask<CSuperTask>(engine, "CSuperTask");
	RegisterCast<IFighterTask, CSuperTask>(engine, "IFighterTask", "CSuperTask");
	int r = engine->RegisterObjectMethod("CSuperTask", "void SetTargetPos(const AIFloat3& in)", asMETHOD(CSuperTask, SetTargetPos), asCALL_THISCALL); ASSERT(r >= 0);
}

static void CRouteTask_SetRoute(CRouteTask* task, const CScriptArray* array)
{
	std::vector<AIFloat3> route;
	route.reserve(array->GetSize());
	for (asUINT i = 0; i < array->GetSize(); ++i) {
		route.push_back(*static_cast<const AIFloat3*>(array->At(i)));
	}
	task->SetRoute(std::move(route));
}

void CInitScript::RegisterCRouteTask(asIScriptEngine* engine)
{
	RegisterIFighterTask<CRouteTask>(engine, "CRouteTask");
	RegisterCast<IFighterTask, CRouteTask>(engine, "IFighterTask", "CRouteTask");
	int r = engine->RegisterObjectMethod("CRouteTask", "void SetRoute(const array<AIFloat3>@+)", asFUNCTION(CRouteTask_SetRoute), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CRouteTask", "int GetRouteVersion() const", asMETHOD(CRouteTask, GetRouteVersion), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CRouteTask", "uint GetRouteSize() const", asMETHOD(CRouteTask, GetRouteSize), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CRouteTask", "bool IsAtEnd(CCircuitUnit@) const", asMETHOD(CRouteTask, IsAtEnd), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CRouteTask", "void SetLanes(int, float, float)", asMETHOD(CRouteTask, SetLanes), asCALL_THISCALL); ASSERT(r >= 0);
}

void CInitScript::RegisterCFerryTask(asIScriptEngine* engine)
{
	RegisterIFighterTask<CFerryTask>(engine, "CFerryTask");
	RegisterCast<IFighterTask, CFerryTask>(engine, "IFighterTask", "CFerryTask");
	// Cargo is addressed by unit id, not by handle: the script side holds ids
	// across frames (the donation it is waiting on may outlive any handle it
	// captured) and CFerryTask resolves them through CCircuitAI::GetTeamUnit.
	int r = engine->RegisterObjectMethod("CFerryTask", "void SetHoldPos(const AIFloat3& in)", asMETHOD(CFerryTask, SetHoldPos), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CFerryTask", "bool SetCargo(int, const AIFloat3& in)", asMETHOD(CFerryTask, SetCargo), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CFerryTask", "int GetState() const", asMETHOD(CFerryTask, GetState), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CFerryTask", "int GetCargoId() const", asMETHOD(CFerryTask, GetCargoId), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CFerryTask", "void Reset()", asMETHOD(CFerryTask, Reset), asCALL_THISCALL); ASSERT(r >= 0);
}

static AIFloat3 CAirWaveTask_GetAim(CAirWaveTask* task)
{
	return task->GetAim();
}

void CInitScript::RegisterCAirWaveTask(asIScriptEngine* engine)
{
	RegisterIFighterTask<CAirWaveTask>(engine, "CAirWaveTask");
	RegisterCast<IFighterTask, CAirWaveTask>(engine, "IFighterTask", "CAirWaveTask");
	// doc/air-wave-attacks.md. Modes are Task::WaveMode; 999 as the bearing
	// means "sample the threat map".
	int r = engine->RegisterObjectMethod("CAirWaveTask", "void SetPlan(int mode, const AIFloat3& in aim, float formDistance, float spacing, float overrun, int formTimeout, int holdFrames, float bearingDeg, int groups)", asMETHOD(CAirWaveTask, SetPlan), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CAirWaveTask", "bool PickStrikeTarget(const AIFloat3& in from, int preference, float minStaticCost, bool includeHeavy)", asMETHOD(CAirWaveTask, PickStrikeTarget), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CAirWaveTask", "int GetState() const", asMETHOD(CAirWaveTask, GetState), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CAirWaveTask", "int GetMode() const", asMETHOD(CAirWaveTask, GetMode), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CAirWaveTask", "AIFloat3 GetAim() const", asFUNCTION(CAirWaveTask_GetAim), asCALL_CDECL_OBJFIRST); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CAirWaveTask", "int GetStrikeTargetId() const", asMETHOD(CAirWaveTask, GetStrikeTargetId), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CAirWaveTask", "float GetBearingDeg() const", asMETHOD(CAirWaveTask, GetBearingDeg), asCALL_THISCALL); ASSERT(r >= 0);
	r = engine->RegisterObjectMethod("CAirWaveTask", "int GetFormedCount() const", asMETHOD(CAirWaveTask, GetFormedCount), asCALL_THISCALL); ASSERT(r >= 0);
}

void CInitScript::RegisterUnitTasks(asIScriptEngine* engine)
{
	RegisterIUnitTask<IUnitTask>(engine, "IUnitTask");
	RegisterIBuilderTask<IBuilderTask>(engine, "IBuilderTask");
	RegisterIFighterTask<IFighterTask>(engine, "IFighterTask");
	RegisterCSuperTask(engine);
	RegisterCRouteTask(engine);
	RegisterCFerryTask(engine);
	RegisterCAirWaveTask(engine);
}

CMaskHandler::TypeMask CInitScript::AddRole(const std::string& name, int actAsRole)
{
	CMaskHandler::TypeMask result = circuit->GetGameAttribute()->GetRoleMasker().GetTypeMask(name);
	if (result.type < 0) {
		return result;
	}
	circuit->BindRole(result.type, actAsRole);
	return result;
}

void CInitScript::Log(const std::string& msg) const
{
	std::lock_guard<spring::mutex> mlock(mtx);
	circuit->LOG("%s", msg.c_str());
}

void CInitScript::AddPoint(const AIFloat3& pos, const std::string& msg) const
{
	circuit->GetDrawer()->AddPoint(pos, msg.c_str());
}

void CInitScript::DelPoint(const AIFloat3& pos) const
{
	circuit->GetDrawer()->DeletePointsAndLines(pos);
}

void CInitScript::AddLine(const AIFloat3& posA, const AIFloat3& posB) const
{
	circuit->GetDrawer()->AddLine(posA, posB);
}

void CInitScript::Pause(bool enable, const std::string& msg) const
{
	circuit->GetGame()->SetPause(enable, msg.c_str());
}

int CInitScript::Dice(const CScriptArray* array) const
{
	float magnitude = 0.f;
	for (asUINT i = 0; i < array->GetSize(); ++i) {
		magnitude += *static_cast<const float*>(array->At(i));
	}
	float dice = (float)rand() / RAND_MAX * magnitude;
	for (asUINT i = 0; i < array->GetSize(); ++i) {
		dice -= *static_cast<const float*>(array->At(i));
		if (dice < 0.f) {
			return i;
		}
	}
	return -1;
}

int CInitScript::NearestPointIdx(const AIFloat3& pos, const CScriptArray* array)
{
	float bestSqDist = std::numeric_limits<float>::max();
	int bestIdx = -1;
	for (asUINT i = 0; i < array->GetSize(); ++i) {
		float d = pos.SqDistance2D(*static_cast<const AIFloat3*>(array->At(i)));
		if (d < bestSqDist) {
			bestSqDist = d;
			bestIdx = i;
		}
	}
	return bestIdx;
}

void CInitScript::SendMessage(const std::string& msg, int toTeamId)
{
	// NOTE: Can access ai->script because of "friend class CInitScript;"
	if (toTeamId < 0) {
		for (CCircuitAI* ai : circuit->GetGameAttribute()->GetCircuits()) {
			if (ai->IsInitialized()
				&& (ai->GetTeamId() != circuit->GetTeamId())
				&& (ai->GetAllyTeamId() == circuit->GetAllyTeamId())
				&& ai->script->mainInfo.receiveMessage != nullptr)
			{
				int fromTeamId = circuit->GetTeamId();
				ai->GetScheduler()->RunJobAfter(CScheduler::GameJob([ai, msg, fromTeamId]() {
					ai->script->ReceiveMessage(msg, fromTeamId);
				}));
			}
		}
	} else {
		for (CCircuitAI* ai : circuit->GetGameAttribute()->GetCircuits()) {
			if (ai->IsInitialized()
				&& (ai->GetTeamId() == toTeamId)
				&& (ai->GetAllyTeamId() == circuit->GetAllyTeamId())
				&& ai->script->mainInfo.receiveMessage != nullptr)
			{
				int fromTeamId = circuit->GetTeamId();
				ai->GetScheduler()->RunJobAfter(CScheduler::GameJob([ai, msg, fromTeamId]() {
					ai->script->ReceiveMessage(msg, fromTeamId);
				}));
				return;
			}
		}
	}
}

void CInitScript::ReceiveMessage(const std::string& msg, int fromTeamId)
{
	// NOTE: Check done in CInitScript::SendMessage
//	if (mainInfo.receiveMessage == nullptr) {
//		return;
//	}
	asIScriptContext* ctx = script->PrepareContext(mainInfo.receiveMessage);
	ctx->SetArgAddress(0, &const_cast<std::string&>(msg));
	ctx->SetArgDWord(1, fromTeamId);
	script->Exec(ctx);
	script->ReturnContext(ctx);
}

void CInitScript::Run(asIScriptFunction* exec, CScriptDictionary* arg)
{
	// NOTE: If engines created in threads:
	// asPrepareMultithread, asUnprepareMultithread, asThreadCleanup, asGetThreadManager;
	// asAtomicInc, asAtomicDec, asAcquireExclusiveLock, asReleaseExclusiveLock, asAcquireSharedLock, asReleaseSharedLock;
	// ensure garbage collection behaviours are thread safe.
	if (exec == nullptr) {
		return;
	}
	asIScriptContext* ctx = script->RequestContext();  // in main thread to avoid mutexes
	takenContexts[ctx] = arg;
	circuit->GetScheduler()->RunParallelJob(CScheduler::WorkJob([this, ctx, exec, arg]() {
		int r = ctx->Prepare(exec); ASSERT(r >= 0);
		ctx->SetArgObject(0, arg);
		script->Exec(ctx);
		asIScriptFunction* finish = (asIScriptFunction*)ctx->GetReturnObject();
		if (finish != nullptr) {
			r = ctx->Prepare(finish); ASSERT(r >= 0);
			ctx->SetArgObject(0, arg);
		}
		return CScheduler::GameJob([this, ctx, finish, arg]() {
			takenContexts.erase(ctx);
			if (finish != nullptr) {
				script->Exec(ctx);
			}
			if (arg) {
				arg->Release();
			}
			script->ReturnContext(ctx);
		});
	}));
}

} // namespace circuit
