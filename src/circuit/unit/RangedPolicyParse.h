#ifndef CIRCUIT_RANGED_POLICY_PARSE_H
#define CIRCUIT_RANGED_POLICY_PARSE_H
// D-430: one parser for a `ranged` policy block, shared by the legacy
// attribute path (CFactoryManager::ReadConfig, behaviour.json "ranged") and the
// ranged unit controller's presets (behaviour.json "controllers"). Both paths
// therefore produce byte-identical policies from the same keys: the preset
// form of a unit type is the same block without the attribute.
//
// Engine-free: name resolution (unit types for "spam_units", BAR category
// flags for "avoid_categories") is supplied by the caller, so the parser is
// testable without a game (tests/ranged_policy_test.cpp). Validation keeps
// the legacy semantics: an out-of-range or mistyped value rejects the whole
// block (`false`), it is never clamped, so a typo cannot change play silently.
#include "unit/RangedPolicy.h"

#include "json/json.h"

#include <functional>
#include <string>
#include <vector>

namespace circuit::ranged_policy {

struct Resolver {
    // Unit type id for a name, or -1 when this game has no such type.
    std::function<int(const std::string&)> defId;
    // BAR category flag for a category list, 0 when unknown.
    std::function<int(const std::string&)> categoryFlag;
};

// Parses `settings` (the object under "ranged", or a resolved preset) into
// `policy`. Keys in `skip` (preset grammar such as "type") are ignored.
// Returns false, with `problems` naming the reasons, when the block is
// invalid; `policy` is then unspecified and the caller keeps its old one.
// A spam unit this game lacks is reported but does not invalidate the block.
bool Parse(const Json::Value& settings, RangedPolicy& policy, const Resolver& resolver,
           const std::vector<std::string>& skip, std::vector<std::string>& problems);
// D-432: the same, refusing keys in `forbidden` (another job's levers): a
// block carrying one is invalid, with the key named in `problems`.
bool Parse(const Json::Value& settings, RangedPolicy& policy, const Resolver& resolver,
           const std::vector<std::string>& skip, const std::vector<std::string>& forbidden,
           std::vector<std::string>& problems);

// The numeric keys a script lever may set at runtime (CConfigTable form):
// name, accessor, legal range. Strings and the formation object are load-time
// only. Kept beside the parser so the two never disagree on a range.
struct NumericKey {
    const char* name;
    float& (*access)(RangedPolicy&);
    float low, high;
};
const std::vector<NumericKey>& NumericKeys();

} // namespace circuit::ranged_policy
#endif
