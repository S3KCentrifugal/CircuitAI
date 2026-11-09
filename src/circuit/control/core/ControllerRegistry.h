#pragma once
// D-388: owns this AI's unit controllers, maps unit types to a controller and
// preset from behaviour.json, routes engine events to the owning controller,
// and answers "who owns this unit" (the ownership arbiter of
// unit-controller-architecture.md section 5).
//
// behaviour.json grammar (all optional):
//   "controllers": {
//     "presets": { "<name>": {"type": "<controller>", "extends": "<parent>", <levers>...} },
//     "roles":   { "<role>": "<preset>" }           // default preset per unit role
//   }
//   "behaviour": { "<unitdef>": { ..., "controller": "<preset>" } }
// A unit type's own "controller" wins over its role default. With no
// controllers block, every commander-role type gets the commander
// controller's built-in defaults, as before D-388.
// Lookups are hash-map O(1); configuration is read once after the managers.

#include "control/core/UnitController.h"

#include "json/json.h"

#include <memory>
#include <string>
#include <unordered_map>
#include <vector>

namespace circuit {

class CCircuitAI;
class CCircuitUnit;

class CControllerRegistry final {
public:
	explicit CControllerRegistry(CCircuitAI* ai) : ai(ai) {}

	template <class T>
	T* Add(std::unique_ptr<T> controller) {
		controllers.push_back(std::move(controller));
		// Borrow from the registry after ownership transfer, not the moved-from parameter.
		return static_cast<T*>(controllers.back().get());
	}

	void ReadConfig(const Json::Value& root);

	IUnitController* ByName(const std::string& type) const;
	IUnitController* ForDef(int defId) const;
	IUnitController* Controlling(int unitId) const;
	// The controller that owns this unit's orders and states right now, or null.
	IUnitController* OwnerOf(CCircuitUnit* unit) const;

	void UnitAdded(CCircuitUnit* unit);
	void UnitRemoved(int unitId);
	void Update();
	void Damaged(CCircuitUnit* unit);
	void WeaponFired(int unitId, int weaponDefId);
	bool ReceiveMessage(const char* message);

	// Script levers (aiControllers).
	bool SetPresetOption(const std::string& preset, const std::string& key, float value);
	bool AssignPreset(int defId, const std::string& preset);
	std::string PresetOf(int defId) const;

private:
	void Bind(int defId, const std::string& preset, const char* source);

	CCircuitAI* ai;
	std::vector<std::unique_ptr<IUnitController>> controllers;
	std::unordered_map<std::string, int> presetOwner;  // preset name -> controller index
	std::unordered_map<int, int> defController;         // unit type -> controller index
};

} // namespace circuit
