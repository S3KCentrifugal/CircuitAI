#pragma once
#include <vector>

namespace circuit::routecommand {
struct Command {
    int id = 0, options = 0, timeout = -1;
    float x = 0, y = 0, z = 0;
    bool operator==(const Command&) const = default;
};
// Exact surviving suffix of our dispatch, including SHIFT and expiry. Caller
// separately proves task ownership and unchanged intent. O(Q), no allocation.
template<class Reader>
bool LiveSuffix(const std::vector<Command>& issued, int count, int frame, Reader read) {
    if (count <= 0 || static_cast<size_t>(count) > issued.size()) return false;
    const size_t offset = issued.size() - count;
    for (int i=0; i<count; ++i) {
        Command actual;
        const auto& expected = issued[offset+i];
        if (expected.timeout < frame || !read(i,actual) || actual != expected) return false;
    }
    return true;
}
}
