#include "air_economy.as"
#include "roster.as"
#include "lanes.as"

// AIR policy owns the line; native RouteTask only executes a looping patrol.
namespace AirScreen {
    dictionary routes; // unit id -> retained native task; units are resolved by id
    dictionary cellByUnit;
    int updated = -100000;
    bool changed = true;
    bool IsFighter(const CCircuitDef@ d)
    {
        if (d is null) return false;
        const string side = UnitHelpers::GetSideForUnitName(d.GetName());
        return d.GetName() == AirEconomy::Fighter(false, side) || d.GetName() == AirEconomy::Fighter(true, side);
    }
    int CountOther(const string &in name)
    {
        int count = 0;
        array<string>@ ids = routes.getKeys();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(parseInt(ids[i]));
            if (u !is null && u.circuitDef.GetName() != name) ++count;
        }
        return count;
    }
    AIFloat3 Clamp(const AIFloat3 &in p)
    {
        return AIFloat3(AiMax(128.0f, AiMin(float(AiTerrainWidth()) - 128.0f, p.x)), 0.0f,
            AiMax(128.0f, AiMin(float(AiTerrainHeight()) - 128.0f, p.z)));
    }
    void Tick()
    {
        array<string>@ ids = routes.getKeys();
        for (uint i = 0; i < ids.length(); ++i) {
            CRouteTask@ task = null;
            CCircuitUnit@ u = ai.GetTeamUnit(parseInt(ids[i]));
            if (u is null || !routes.get(ids[i], @task) || task is null || task.IsDead()) {
                routes.delete(ids[i]); cellByUnit.delete(ids[i]); changed = true;
            }
        }
        if (!changed && ai.frame - updated < Global::RoleSettings::Air::ScreenUpdateSeconds * SECOND) return;
        updated = ai.frame; changed = false;
        @ids = routes.getKeys();
        if (ids.length() == 0) return;
        ids.sortAsc();
        AIFloat3 anchor = Global::Map::StartPos;
        int tech = -1;
        float nearest = 1.0e20f;
        array<Team::Roster::Entry@>@ allies = Team::Roster::WithRole(AiRole::TECH);
        for (uint i = 0; i < allies.length(); ++i) {
            const float distance = MapHelpers::SqDist(Global::Map::StartPos, allies[i].startPos);
            if (distance < nearest) { nearest = distance; anchor = allies[i].startPos; tech = allies[i].teamId; }
        }
        AIFloat3 enemy(float(AiTerrainWidth()) - anchor.x, 0.0f, float(AiTerrainHeight()) - anchor.z);
        array<AIFloat3> starts = Lanes::ScriptStarts(true);
        nearest = 1.0e20f;
        for (uint i = 0; i < starts.length(); ++i) {
            const float distance = MapHelpers::SqDist(anchor, starts[i]);
            if (distance < nearest) { nearest = distance; enemy = starts[i]; }
        }
        float dx = enemy.x - anchor.x, dz = enemy.z - anchor.z;
        const float distance = sqrt(dx * dx + dz * dz);
        if (distance < 1.0f) { dx = 0.0f; dz = 1.0f; } else { dx /= distance; dz /= distance; }
        const float progress = ProductionMath::Progress(int(ids.length()), 4, Global::RoleSettings::Air::ScreenFullFighters);
        const float limit = AiMax(0.0f, distance * 0.5f - Global::RoleSettings::Air::ScreenFrontSetback);
        const float advance = ProductionMath::BoundedBlend(AiMin(limit, Global::RoleSettings::Air::ScreenRearAdvance), limit, progress);
        const float width = ProductionMath::BoundedBlend(Global::RoleSettings::Air::ScreenRearWidth, Global::RoleSettings::Air::ScreenFrontWidth, progress);
        const int cells = AiMax(1, AiMin(int(ids.length()), Global::RoleSettings::Air::ScreenCells));
        const AIFloat3 centre = Clamp(AIFloat3(anchor.x + dx * advance, 0.0f, anchor.z + dz * advance));
        // Retain cells on births instead of rotating the whole line whenever
        // a randomly allocated unit ID sorts ahead of existing fighters.
        array<int> assigned(ids.length(), -1), population(cells, 0);
        for (uint i = 0; i < ids.length(); ++i) {
            int cell = -1;
            if (cellByUnit.get(ids[i], cell) && cell >= 0 && cell < cells) { assigned[i] = cell; ++population[cell]; }
        }
        for (uint i = 0; i < ids.length(); ++i) {
            if (assigned[i] >= 0) continue;
            int best = 0;
            for (int c = 1; c < cells; ++c) if (population[c] < population[best]) best = c;
            assigned[i] = best; ++population[best];
        }
        // Fill holes after losses by moving one fighter from a populated cell.
        for (int c = 0; c < cells; ++c) {
            if (population[c] > 0) continue;
            for (uint i = 0; i < ids.length(); ++i) {
                if (population[assigned[i]] <= 1) continue;
                --population[assigned[i]]; assigned[i] = c; ++population[c]; break;
            }
        }
        for (uint i = 0; i < ids.length(); ++i) {
            CRouteTask@ task = null;
            if (!routes.get(ids[i], @task) || task is null) continue;
            const int cell = assigned[i]; cellByUnit.set(ids[i], cell);
            const float left = width * (float(cell) / float(cells) - 0.5f);
            const float right = width * (float(cell + 1) / float(cells) - 0.5f);
            array<AIFloat3> points = { Clamp(AIFloat3(centre.x - dz * left, 0.0f, centre.z + dx * left)),
                Clamp(AIFloat3(centre.x - dz * right, 0.0f, centre.z + dx * right)) };
            if (!AirLayout::Inside(points[0], 64.0f) || !AirLayout::Inside(points[1], 64.0f))
                Invariants::Violation("INV-080", ids[i], "AIR screen endpoint is outside map");
            task.SetRoute(points);
        }
        GenericHelpers::LogUtil("[AIR][Screen] fighters=" + ids.length() + " cells=" + cells + " tech=" + tech
            + " centre=" + int(centre.x) + "," + int(centre.z) + " width=" + int(width) + " advance=" + int(advance), 1);
    }
    IUnitTask@ TaskFor(CCircuitUnit@ u)
    {
        const string key = "" + u.id;
        CRouteTask@ task = null;
        if (routes.get(key, @task) && task !is null && !task.IsDead()) return task;
        @task = cast<CRouteTask>(aiMilitaryMgr.Enqueue(TaskF::Route()));
        if (task is null) return null;
        task.SetPatrol(true);
        routes.set(key, @task); changed = true;
        Tick();
        return task;
    }
    void Removed(int id) { routes.delete("" + id); cellByUnit.delete("" + id); changed = true; }
    void Reset() { routes.deleteAll(); cellByUnit.deleteAll(); updated = -100000; changed = true; }
}
