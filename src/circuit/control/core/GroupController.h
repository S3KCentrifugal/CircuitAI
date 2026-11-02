#pragma once
// D-430: group controllers (unit-controller-architecture.md section 9), the
// first being the line (control/group/LineController.h). A group controller
// is one object per formation type per AI. It owns formation templates from
// behaviour.json "formations" (named like presets, with "extends"), decides
// where its groups stand and which stance each member takes, and writes that
// as a directive the member's own controller reads. It never orders a unit:
// the member's controller (or its task) says how, and its hard-hazard escape
// always wins over the group's timing.
//
// Orders reach a group from script (aiControllers.Order) and from the group's
// own assessment; both go through the same routing table, so a self-decided
// withdrawal is staged the same way as a commanded one.
#include "json/json.h"
#include "AIFloat3.h"

#include <string>
#include <vector>

namespace circuit {

class IGroupController {
public:
	virtual ~IGroupController() = default;
	virtual const char* Name() const = 0;  // the template "type"

	// Load time: parse one resolved template; returns its index, or -1.
	virtual int ParseTemplate(const std::string& name, const Json::Value& resolved, std::vector<std::string>& problems) = 0;
	virtual int TemplateIndex(const std::string& name) const = 0;
	// Script lever: one template's key (same names and ranges as the JSON).
	virtual bool SetTemplateOption(const std::string& name, const std::string& key, float value) = 0;

	virtual void Update() = 0;
	virtual void UnitRemoved(int /*unitId*/) {}
	// An order for every group of a template: "hold", "advance", "attack",
	// "withdraw". `pos` is the goal where one applies. False when unknown.
	virtual bool Order(const std::string& name, const std::string& kind, const springai::AIFloat3& pos) = 0;
};

} // namespace circuit
