#pragma once
// D-388: the "controllers" block of behaviour.json holds named presets. A
// preset may name one parent in "extends"; members of the child override the
// parent's. Resolution is load-time only: O(depth x members), depth capped.
// A missing parent or a cycle is an error and yields no preset.
// Tests: tests/control_core_test.cpp.

#include "json/json.h"

#include <string>
#include <vector>

namespace circuit::control {

inline constexpr int PRESET_MAX_DEPTH = 8;

// Returns true and the merged object when `name` resolves; otherwise false
// and the reason in `error`.
inline bool ResolvePreset(const Json::Value& presets, const std::string& name, Json::Value& out, std::string& error) {
	std::vector<std::string> chain;
	std::string current = name;
	while (true) {
		if (!presets.isObject() || !presets.isMember(current) || !presets[current].isObject()) {
			error = "preset '" + current + "' not found";
			return false;
		}
		for (const auto& seen : chain) {
			if (seen == current) { error = "preset '" + name + "' extends itself through '" + current + "'"; return false; }
		}
		chain.push_back(current);
		if ((int)chain.size() > PRESET_MAX_DEPTH) { error = "preset '" + name + "' extends too deeply"; return false; }
		const Json::Value& node = presets[current];
		if (!node.isMember("extends")) break;
		if (!node["extends"].isString()) { error = "preset '" + current + "' has a non-string extends"; return false; }
		current = node["extends"].asString();
	}
	out = Json::Value(Json::objectValue);
	// Root first, so each child overrides its parent.
	for (auto it = chain.rbegin(); it != chain.rend(); ++it) {
		const Json::Value& node = presets[*it];
		for (const std::string& key : node.getMemberNames()) {
			if (key == "extends") continue;
			out[key] = node[key];
		}
	}
	return true;
}

} // namespace circuit::control
