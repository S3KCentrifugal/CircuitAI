#pragma once

namespace circuit::reservation {

// A reclaimed opening leaves cells without zone underlay. An existing exact
// slot may own those reservation marks; a new slot or another zone may not.
constexpr bool AllowsReservedCell(int zone, int cellZone, bool existingSlot)
{
    return zone > 0 && (cellZone == zone || (existingSlot && cellZone == 0));
}

// Transfer a task's exclusive unconsumed claim with a constant number of
// registry operations (O(log N) for TerrainManager's ordered reservation map).
// Re-pinning our own ID is idempotent; failure preserves our previous claim
// for cancellation to release. Never unclaim the rejected requested ID.
template<class Claim, class Unclaim>
bool ReplaceClaim(int& owned, int requested, Claim claim, Unclaim unclaim)
{
    if (requested < 0) return false;
    if (owned == requested) return true;
    if (!claim(requested)) return false;
    const int previous = owned;
    owned = requested;
    if (previous >= 0) unclaim(previous);
    return true;
}

}
