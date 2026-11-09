#!/usr/bin/env bash
# D-498: lint the Lua files a pull request changed, nothing else. Four checks:
#   1. whitespace errors on the changed lines (git diff --check);
#   2. syntax: luac5.1 -p, the Lua version BAR's LuaUI and LuaRules run;
#   3. global variables: luacheck with the repository's .luacheckrc, which
#      reports only syntax errors and undefined or accidental globals (W111,
#      W112, W113) and declares the engine names each kind of file may use;
#   4. when gui_barb_plans.lua or tools/widgets/include/ changed: the embedded
#      strategy module matches its include (tools/widgets/embed_strategy.py --check).
# Findings are printed as GitHub annotations (::error file=...,line=...) on the
# changed lines and summarised in the step summary. Exit 1 on any finding.
# Unchanged files are never linted: a pre-existing finding in a file appears
# the first time a pull request touches that file.
#
#   tools/ci/lint_lua.sh origin/smrt-test                 # files from tools/ci/changed_files.sh
#   tools/ci/lint_lua.sh origin/smrt-test a.lua b.lua     # these files
set -uo pipefail
base="${1:?base ref}"
shift
root="$(git rev-parse --show-toplevel)"
cd "$root"
if [ $# -gt 0 ]; then
	files=("$@")
else
	mapfile -t files < <(tools/ci/changed_files.sh "$base" lua)
fi
summary() { [ -n "${GITHUB_STEP_SUMMARY:-}" ] && printf '%s\n' "$@" >> "$GITHUB_STEP_SUMMARY"; return 0; }
if [ ${#files[@]} -eq 0 ]; then
	echo "lint_lua: no Lua files changed"
	summary "| Check | Files | Result |" "|---|---|---|" "| Lua lint | 0 | skipped, nothing changed |"
	exit 0
fi
echo "lint_lua: ${#files[@]} changed Lua file(s):"
printf '  %s\n' "${files[@]}"
status=0

# 1. whitespace on the changed lines only
if git rev-parse -q --verify "$base" > /dev/null && ! git diff --check "$base...HEAD" -- "${files[@]}"; then
	echo "::error title=whitespace::git diff --check found whitespace errors on changed lines (listed above)"
	whitespace="findings"
	status=1
else
	whitespace="clean"
fi

# 2. syntax
for tool in luac5.1 luacheck; do
	if ! command -v "$tool" > /dev/null; then
		echo "::error title=$tool::$tool is not installed on this runner (apt-get install lua5.1 lua-check)"
		exit 1
	fi
done
syntax_findings=0
for file in "${files[@]}"; do
	if ! out="$(luac5.1 -p "$file" 2>&1)"; then
		# "luac5.1: file.lua:12: message"
		line="$(printf '%s' "$out" | sed -nE 's/^[^:]+: [^:]+:([0-9]+):.*/\1/p' | head -1)"
		echo "::error file=$file,line=${line:-1},title=Lua syntax::$out"
		syntax_findings=$((syntax_findings + 1))
		status=1
	fi
done

# 3. globals (luacheck reads .luacheckrc from the repository root)
report="$(mktemp)"
luacheck --formatter plain --no-cache --codes "${files[@]}" > "$report" 2>&1
code=$?
global_findings=0
if [ "$code" -ne 0 ]; then
	# "file.lua:12:3: (W113) accessing undefined variable 'x'"
	while IFS= read -r finding; do
		file="$(printf '%s' "$finding" | cut -d: -f1)"
		line="$(printf '%s' "$finding" | cut -d: -f2)"
		col="$(printf '%s' "$finding" | cut -d: -f3)"
		message="$(printf '%s' "$finding" | cut -d: -f4- | sed 's/^ //')"
		echo "::error file=$file,line=$line,col=$col,title=luacheck::$message"
		global_findings=$((global_findings + 1))
	done < <(grep -E '^[^:]+:[0-9]+:[0-9]+' "$report")
	if [ "$global_findings" -eq 0 ]; then cat "$report"; global_findings=1; fi
	status=1
fi
rm -f "$report"

# 4. the embedded strategy module
embed="not affected"
for file in "${files[@]}"; do
	case "$file" in
		tools/widgets/gui_barb_plans.lua|tools/widgets/include/*)
			if python3 tools/widgets/embed_strategy.py --check; then embed="matches"
			else
				echo "::error file=tools/widgets/gui_barb_plans.lua,title=embedded strategy::the embedded strategy module differs from tools/widgets/include/barb_strategy.lua: run tools/widgets/embed_strategy.py"
				embed="differs"
				status=1
			fi
			break ;;
	esac
done

summary "| Check | Files | Result |" "|---|---|---|" \
	"| whitespace on changed lines | ${#files[@]} | $whitespace |" \
	"| syntax (luac5.1 -p) | ${#files[@]} | $syntax_findings finding(s) |" \
	"| globals (luacheck, .luacheckrc) | ${#files[@]} | $global_findings finding(s) |" \
	"| embedded strategy module | - | $embed |"
summary "" "Changed Lua files:" "$(printf -- '- `%s`\n' "${files[@]}")"
[ "$status" -eq 0 ] && echo "lint_lua: clean"
exit "$status"
