#pragma once
// D-388: per-unit-type behaviour controllers (unit-controller-architecture.md).
//
// IUnitController is what the registry, managers and tasks see. A controller
// is one object per controller type per AI (a system), holding the state of
// every unit it controls. CUnitControllerBase writes the shared parts once:
// presets (flyweight Config per preset, parsed and range-checked from
// behaviour.json), script levers applied to every preset, unit attach/detach
// in ascending id order, and the per-unit preset binding of `cfg`.
//
// Inheritance stops at: IUnitController -> CUnitControllerBase<Config, State>
// -> a final concrete controller. Abilities are composed as Config/State
// sub-structs plus kernel functions (control/kernel/), never as base classes.

#include "control/core/ConfigTable.h"
#include "control/core/SlotStore.h"

#include "json/json.h"

#include <algorithm>
#include <string>
#include <unordered_map>
#include <vector>

namespace circuit {

class CCircuitUnit;
class IUnitTask;

class IUnitController {
public:
	virtual ~IUnitController() = default;
	virtual const char* Name() const = 0;

	// Load time: parse one resolved preset; returns its index, or -1.
	virtual int ParsePreset(const std::string& name, const Json::Value& resolved, std::vector<std::string>& problems) = 0;
	virtual int PresetIndex(const std::string& name) const = 0;
	virtual void BindDef(int defId, int preset) = 0;
	virtual int PresetForDef(int defId) const = 0;  // -1 when this controller does not control the type

	// Lifecycle of one unit of a bound type.
	virtual void Attach(CCircuitUnit* unit) = 0;
	virtual void Detach(int unitId) = 0;
	virtual bool Controls(int unitId) const = 0;
	// The controller currently owns the unit's orders and its cloak, fire and
	// move states: attached, enabled, and not paused by the precedence ladder.
	virtual bool Owns(CCircuitUnit* unit) const = 0;

	// Any unit of this AI's team leaves (destroyed, given away); controllers
	// drop references to it. Called before Detach for a controlled unit.
	virtual void TeamUnitRemoved(int /*unitId*/) {}

	virtual void Update() = 0;
	virtual void Damaged(CCircuitUnit* /*unit*/) {}
	virtual void MoveFailed(int /*unitId*/) {}
	virtual void WeaponFired(int /*unitId*/, int /*weaponDefId*/) {}
	virtual bool ReceiveMessage(const char* /*message*/) { return false; }

	// Levers. SetOption applies to every preset (per-AI script policy);
	// SetPresetOption to one preset; AssignPreset moves a unit type.
	virtual bool SetOption(const std::string& name, float value) = 0;
	virtual bool SetPresetOption(const std::string& preset, const std::string& name, float value) = 0;
	virtual bool AssignPreset(int defId, const std::string& preset) = 0;
	virtual std::string PresetName(int preset) const = 0;

	// Lease hooks for CControlledTask: the task ends, the controller restores.
	virtual void RestoreAfterLease(CCircuitUnit* unit, int fireState, int moveState) = 0;
	virtual bool CanResumeTask(CCircuitUnit* /*unit*/, IUnitTask* /*task*/) const { return true; }
};

namespace control {
// Every controller State carries the preset of its unit.
struct ControlledState {
	int preset = 0;
};
}

template <class Config, class State>
class CUnitControllerBase : public IUnitController {
public:
	int ParsePreset(const std::string& name, const Json::Value& resolved, std::vector<std::string>& problems) override {
		Config config = presets.front().config;  // built-in defaults
		table.Apply(config, resolved, {"type"}, problems);
		const int existing = PresetIndex(name);
		if (existing >= 0) { presets[existing].config = config; return existing; }
		presets.push_back({name, config});
		cfg = &presets.front().config;  // the vector may have moved
		return int(presets.size()) - 1;
	}
	int PresetIndex(const std::string& name) const override {
		for (std::size_t i = 0; i < presets.size(); ++i) if (presets[i].name == name) return int(i);
		return -1;
	}
	void BindDef(int defId, int preset) override {
		presetByDef[defId] = std::clamp(preset, 0, int(presets.size()) - 1);
	}
	int PresetForDef(int defId) const override {
		const auto it = presetByDef.find(defId);
		return it == presetByDef.end() ? -1 : it->second;
	}
	bool Controls(int unitId) const override { return states.Contains(unitId); }

	bool SetOption(const std::string& name, float value) override {
		bool accepted = false;
		for (auto& p : presets) accepted = table.Set(p.config, name, value) || accepted;
		return accepted;
	}
	bool SetPresetOption(const std::string& preset, const std::string& name, float value) override {
		const int index = PresetIndex(preset);
		return index >= 0 && table.Set(presets[index].config, name, value);
	}
	bool AssignPreset(int defId, const std::string& preset) override {
		const int index = PresetIndex(preset);
		if (index < 0 || PresetForDef(defId) < 0) return false;
		presetByDef[defId] = index;
		OnPresetAssigned(defId, index);
		return true;
	}
	std::string PresetName(int preset) const override {
		return (preset >= 0 && preset < int(presets.size())) ? presets[preset].name : std::string();
	}

protected:
	explicit CUnitControllerBase(const control::CConfigTable<Config>& table) : table(table) {
		presets.push_back({"default", Config{}});
		cfg = &presets.front().config;
	}
	// A unit type moved to another preset at runtime; attached units follow.
	virtual void OnPresetAssigned(int defId, int preset) = 0;

	// Points `cfg` at a unit's preset for the lifetime of the binding and
	// restores the previous one, so nested calls for another unit are safe.
	class Bind {
	public:
		Bind(const CUnitControllerBase* owner, int preset) : owner(owner), previous(owner->cfg) {
			owner->cfg = &owner->presets[std::clamp(preset, 0, int(owner->presets.size()) - 1)].config;
		}
		~Bind() { owner->cfg = previous; }
		Bind(const Bind&) = delete;
		Bind& operator=(const Bind&) = delete;
	private:
		const CUnitControllerBase* owner;
		const Config* previous;
	};
	int PresetOfUnit(int unitId) const {
		const State* s = states.Find(unitId);
		return s ? s->preset : 0;
	}

	struct Preset { std::string name; Config config; };
	const control::CConfigTable<Config>& table;
	std::vector<Preset> presets;               // [0] = built-in defaults
	std::unordered_map<int, int> presetByDef;  // unit type -> preset index
	control::CSlotStore<State> states;
	mutable const Config* cfg = nullptr;       // the bound unit's preset
};

} // namespace circuit
