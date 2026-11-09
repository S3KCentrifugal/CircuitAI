#pragma once
// The unit monitor widget's feed (tools/widgets/gui_barb_unit_monitor.lua):
// what one AI's groups are and what one unit belongs to, as compact text the
// script publishes through the widget state file (systems/presentation/
// widget_link.as, MonitorTick). Diagnostics only: it reads the battle group
// controller, the ranged world's cohorts and the military manager's fighter
// tasks and changes nothing.
//
// Cost: only while the widget holds a monitor lease, once per
// WidgetLink::MonitorSeconds. DescribeGroups is O(L + C + T + M) for L battle groups,
// C cohorts, T fighter tasks and M members listed, one string built; at most
// MAX_TASK_RECORDS tasks are listed. DescribeUnit is O(C x members + L).
//
// Groups payload: "2;<frame>;" then one record per group, ';'-separated:
//   G,<key>,<template>,<partner>,<order>,<script order>,<own order>,<screen stance>,<rear stance>,
//     <spread>,<separation>,<facing x>,<facing z>,<facing set>,<scripted>,<stand firm>,
//     <screens>,<rears>,<short>,<peer>,<long>,<static>,<commander>,<hostile metal>,<order age s>
//   C,<key>,<mode>,<reason>,<x>,<z>,<radius>,<rear>,<partner>,<committed>,<supporting>,<rush>,
//     <own value>,<hostile value>,<advantage>,<target>,<member>:<member>:...
//   T,<id>,<fight type>,<leader>,<x>,<z>,<attack power>,<member>:<member>:...
// A battle group's key is its screen cohort's key; its partner is the rear cohort.
// Unit payload: "2;<frame>;<unit>;<key>=<value>,..." (def, health, task, fight,
// taskid, controller, external, cohort, mode, reason, group, slot (screen or support), stance, order).
// D-508, appended so a format-2 reader still parses: a G record ends
// ",<group factors>" (D-509: then ",<air need>,<air cap>,<air HP held>,<escort>:<escort>:..."),
// a C record ",<activity>,<plan factors>", and the unit
// payload adds act, pf (its cohort's plan factors) and uf (its own), and
// for an anti-air escort (D-509) escort=<group>. An
// activity is an index and factors are lower-case hex bit sets, decoded with
// Dictionary() (control/kernel/ActionWhy.h), which the script publishes once
// per monitor lease as the state key "monitorcodes".
#include <string>

namespace circuit {
class CCircuitAI;

namespace monitor {

constexpr int FORMAT_VERSION = 2;  // 2: battle group records "G", unit key "group" (D-500)
constexpr int MAX_TASK_RECORDS = 256;

std::string DescribeGroups(CCircuitAI* ai, int minTaskMembers);
std::string DescribeUnit(CCircuitAI* ai, int unitId);
std::string Dictionary();  // D-508: the activity and factor names, O(codes)

} // namespace monitor
} // namespace circuit
