#include "control/core/ControllerRegistry.h"
#include "control/core/PresetResolver.h"
#include "unit/CircuitDef.h"
#include "unit/CircuitUnit.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "Log.h"

namespace circuit {

namespace {
constexpr const char* COMMANDER_CONTROLLER = "commander";
constexpr const char* COMMANDER_ROLE = "commander";
}

IUnitController* CControllerRegistry::ByName(const std::string& type) const {
	for (const auto& c : controllers) if (type == c->Name()) return c.get();
	return nullptr;
}

void CControllerRegistry::Bind(int defId, const std::string& preset, const char* source) {
	const auto owner = presetOwner.find(preset);
	if (owner == presetOwner.end()) {
		ai->LOG("CONFIG controllers: %s names unknown preset '%s'", source, preset.c_str());
		return;
	}
	IUnitController* c = controllers[owner->second].get();
	c->BindDef(defId, c->PresetIndex(preset));
	defController[defId] = owner->second;
}

void CControllerRegistry::ReadConfig(const Json::Value& root) {
	const Json::Value& block = root["controllers"];
	const Json::Value& presets = block["presets"];
	if (presets.isObject()) {
		for (const std::string& name : presets.getMemberNames()) {
			Json::Value resolved;
			std::string error;
			if (!control::ResolvePreset(presets, name, resolved, error)) {
				ai->LOG("CONFIG controllers: %s", error.c_str());
				continue;
			}
			const std::string type = resolved.get("type", "").asString();
			IUnitController* c = ByName(type);
			if (c == nullptr) {
				ai->LOG("CONFIG controllers: preset '%s' has unknown type '%s'", name.c_str(), type.c_str());
				continue;
			}
			std::vector<std::string> problems;
			const int index = c->ParsePreset(name, resolved, problems);
			for (const auto& p : problems) ai->LOG("CONFIG controllers: preset '%s': %s", name.c_str(), p.c_str());
			if (index < 0) continue;
			for (std::size_t i = 0; i < controllers.size(); ++i) if (controllers[i].get() == c) presetOwner[name] = int(i);
		}
	}

	// Explicit per-type assignment.
	const Json::Value& behaviours = root["behaviour"];
	if (behaviours.isObject()) {
		for (const std::string& defName : behaviours.getMemberNames()) {
			const Json::Value& entry = behaviours[defName];
			if (!entry.isObject() || !entry.isMember("controller")) continue;
			CCircuitDef* def = ai->GetCircuitDef(defName.c_str());
			if (def == nullptr) continue;  // FactoryManager already logs unknown unit types
			if (!entry["controller"].isString()) {
				ai->LOG("CONFIG controllers: '%s' controller is not a preset name", defName.c_str());
				continue;
			}
			Bind(def->GetId(), entry["controller"].asString(), defName.c_str());
		}
	}

	// Role defaults for every type not assigned above.
	const Json::Value& roles = block["roles"];
	bool commanderRoleMapped = false;
	if (roles.isObject()) {
		const auto& roleNames = CCircuitDef::GetRoleNames();
		for (const std::string& roleName : roles.getMemberNames()) {
			const auto role = roleNames.find(roleName);
			if (role == roleNames.end() || !roles[roleName].isString()) {
				ai->LOG("CONFIG controllers: role '%s' is unknown or has no preset name", roleName.c_str());
				continue;
			}
			commanderRoleMapped |= roleName == COMMANDER_ROLE;
			const std::string preset = roles[roleName].asString();
			for (CCircuitDef& def : ai->GetCircuitDefs()) {
				if (def.GetId() <= 0 || defController.count(def.GetId())) continue;
				if (def.IsRoleAny(role->second.mask)) Bind(def.GetId(), preset, roleName.c_str());
			}
		}
	}

	// Compatibility: without a commander mapping, every commander-role type
	// gets the commander controller's built-in defaults (pre-D-388 behaviour).
	if (!commanderRoleMapped) {
		IUnitController* commander = ByName(COMMANDER_CONTROLLER);
		int index = -1;
		for (std::size_t i = 0; i < controllers.size(); ++i) if (controllers[i].get() == commander) index = int(i);
		if (index >= 0) {
			for (CCircuitDef& def : ai->GetCircuitDefs()) {
				if (def.GetId() <= 0 || defController.count(def.GetId()) || !def.IsRoleComm()) continue;
				commander->BindDef(def.GetId(), 0);
				defController[def.GetId()] = index;
			}
		}
	}
}

IUnitController* CControllerRegistry::ForDef(int defId) const {
	const auto it = defController.find(defId);
	return it == defController.end() ? nullptr : controllers[it->second].get();
}

IUnitController* CControllerRegistry::Controlling(int unitId) const {
	// A handful of controllers, each answering in O(log n): no per-unit index
	// to fall out of step when a controller attaches units itself.
	for (const auto& c : controllers) if (c->Controls(unitId)) return c.get();
	return nullptr;
}

IUnitController* CControllerRegistry::OwnerOf(CCircuitUnit* unit) const {
	if (unit == nullptr) return nullptr;
	IUnitController* c = Controlling(unit->GetId());
	return (c != nullptr && c->Owns(unit)) ? c : nullptr;
}

void CControllerRegistry::UnitAdded(CCircuitUnit* unit) {
	if (IUnitController* c = ForDef(unit->GetCircuitDef()->GetId())) c->Attach(unit);
}

void CControllerRegistry::UnitRemoved(int unitId) {
	for (auto& c : controllers) {
		c->TeamUnitRemoved(unitId);
		if (c->Controls(unitId)) c->Detach(unitId);
	}
}

void CControllerRegistry::Update() {
	for (auto& c : controllers) c->Update();
}

void CControllerRegistry::Damaged(CCircuitUnit* unit) {
	if (IUnitController* c = Controlling(unit->GetId())) c->Damaged(unit);
}

void CControllerRegistry::WeaponFired(int unitId, int weaponDefId) {
	if (IUnitController* c = Controlling(unitId)) c->WeaponFired(unitId, weaponDefId);
}

bool CControllerRegistry::ReceiveMessage(const char* message) {
	for (auto& c : controllers) if (c->ReceiveMessage(message)) return true;
	return false;
}

bool CControllerRegistry::SetPresetOption(const std::string& preset, const std::string& key, float value) {
	const auto owner = presetOwner.find(preset);
	if (owner == presetOwner.end()) {
		// "default" names each controller's built-in preset; the first that takes the key wins.
		for (auto& c : controllers) if (c->SetPresetOption(preset, key, value)) return true;
		return false;
	}
	return controllers[owner->second]->SetPresetOption(preset, key, value);
}

bool CControllerRegistry::AssignPreset(int defId, const std::string& preset) {
	IUnitController* c = ForDef(defId);
	return c != nullptr && c->AssignPreset(defId, preset);
}

std::string CControllerRegistry::PresetOf(int defId) const {
	IUnitController* c = ForDef(defId);
	return c == nullptr ? std::string() : c->PresetName(c->PresetForDef(defId));
}

} // namespace circuit
