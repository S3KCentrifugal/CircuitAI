#pragma once
// D-388: one validated table per controller Config. Each entry names a JSON /
// script key, the field it writes (through a captureless accessor, so nested
// sub-structs need no pointer-to-member chains) and its legal range. The same
// table serves behaviour.json presets and runtime script levers, so both
// clamp identically. Load-time and lever-time only; never on a decision path.
// Tests: tests/control_core_test.cpp.

#include "json/json.h"

#include <algorithm>
#include <cmath>
#include <string>
#include <vector>

namespace circuit::control {

template <class Config>
struct ConfigField {
	const char* name;
	float& (*access)(Config&);
	float low, high;
};

template <class Config>
class CConfigTable {
public:
	explicit CConfigTable(std::vector<ConfigField<Config>> fields) : fields(std::move(fields)) {}

	const ConfigField<Config>* Lookup(const std::string& name) const {
		for (const auto& f : fields) if (name == f.name) return &f;
		return nullptr;
	}

	// Script lever: unknown key or non-finite value is refused; range is clamped.
	bool Set(Config& config, const std::string& name, float value) const {
		const auto* f = Lookup(name);
		if (f == nullptr || !std::isfinite(value)) return false;
		f->access(config) = std::clamp(value, f->low, f->high);
		return true;
	}

	// A resolved preset object. Members in `skip` (preset grammar such as
	// "type" or "extends") are ignored. Every other problem is reported by
	// name and the field keeps its previous value; a clamped value is also
	// reported, so a typo never changes play silently.
	void Apply(Config& config, const Json::Value& object, const std::vector<std::string>& skip,
	           std::vector<std::string>& problems) const {
		if (!object.isObject()) { problems.push_back("preset is not an object"); return; }
		for (const std::string& key : object.getMemberNames()) {
			if (std::find(skip.begin(), skip.end(), key) != skip.end()) continue;
			const auto* f = Lookup(key);
			if (f == nullptr) { problems.push_back("unknown key '" + key + "'"); continue; }
			const Json::Value& v = object[key];
			float value = 0.f;
			if (v.isBool()) value = v.asBool() ? 1.f : 0.f;
			else if (v.isNumeric()) value = v.asFloat();
			else { problems.push_back("'" + key + "' is not a number"); continue; }
			if (!std::isfinite(value)) { problems.push_back("'" + key + "' is not finite"); continue; }
			const float clamped = std::clamp(value, f->low, f->high);
			if (clamped != value) problems.push_back("'" + key + "' clamped to [" + std::to_string(f->low) + ", " + std::to_string(f->high) + "]");
			f->access(config) = clamped;
		}
	}

	const std::vector<ConfigField<Config>>& Fields() const { return fields; }

private:
	std::vector<ConfigField<Config>> fields;
};

} // namespace circuit::control
