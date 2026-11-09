-- luacheck configuration for the repository's Lua (D-498): LuaUI widgets,
-- playtest watchers, BAR gadgets and the AI's data tables. CI lints only the
-- changed files (tools/ci/lint_lua.sh, the "Lint Lua (changed files)" job).
--
-- The lint is deliberately narrow: syntax errors and global variables. An
-- undefined global is how a widget breaks at runtime without warning (the team
-- link's /barbtactical read a nil global `territory` for months); unused
-- variables, shadowing and line length are style and not checked.
std = "lua51"
codes = true
-- Only the global-variable warnings: setting, mutating and reading an
-- undefined global (111, 112, 113). Syntax errors are always reported.
only = { "111", "112", "113" }

-- What BAR's LuaUI gives every widget.
local luaui = {
	"Spring", "gl", "GL", "VFS", "WG", "widget", "widgetHandler", "UnitDefs", "UnitDefNames",
	"FeatureDefs", "FeatureDefNames", "WeaponDefs", "WeaponDefNames", "Game", "CMD", "CMDTYPE", "LOG",
	"Script", "LUAUI_DIRNAME", "Platform", "KEYSYMS", "RmlUi", "include", "Engine", "math", "table", "string",
	"SYNCED", "GetInfo", "Json",
}
-- What BAR's LuaRules gives every gadget.
local luarules = {
	"Spring", "gl", "GL", "VFS", "GG", "gadget", "gadgetHandler", "UnitDefs", "UnitDefNames", "FeatureDefs",
	"FeatureDefNames", "WeaponDefs", "WeaponDefNames", "Game", "CMD", "CMDTYPE", "LOG", "Script", "SYNCED",
	"UNSYNCED", "include", "Engine", "math", "table", "string",
}

-- Widgets assign their callins on the shared `widget` table; that is the API.
files["tools/widgets/*.lua"] = { read_globals = luaui, globals = { "widget" } }
-- The strategy module is embedded in gui_barb_plans.lua (embed_strategy.py) and
-- reads that file's locals; linted as an include with those names declared.
files["tools/widgets/include/*.lua"] = { read_globals = luaui, globals = { "isPermittedTeam", "field", "dialogUI", "territory" } }
-- Watchers carry __NAME__ placeholders the playtest runner replaces when it stages them.
files["tools/playtest/widgets/*.lua"] = { read_globals = luaui, globals = { "widget" }, ignore = { "113/__.+__" } }
-- The offline lane UI harness builds the widget environment itself.
files["tools/playtest/fixtures/*.lua"] = { allow_defined_top = true, globals = luaui }
-- The upstream debug gadgets share functions through file-level globals.
files["util/LuaRules/Gadgets/*.lua"] = { read_globals = luarules, globals = { "gadget", "SendToUnsynced" }, allow_defined_top = true }
files["tools/integration/*.lua"] = { read_globals = luarules, globals = { "gadget", "SendToUnsynced" } }
-- Engine-read data tables (AIInfo.lua, AIOptions.lua) only return a table.
files["data/*.lua"] = {}
files["packaging/**/*.lua"] = {}
files["util/fibR.lua"] = { allow_defined_top = true }
