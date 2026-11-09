// Direct contracts for every extracted corridor stage. No engine or mocks.
#include "terrain/field/FieldCorridorHelpers.h"
#include "terrain/field/FieldSettings.h"
#include "json/json.h"
#include <iostream>
#include <stdexcept>

using namespace circuit::field;
using namespace circuit::field::corridor;

static void Require(bool ok, const char* message) { if (!ok) throw std::runtime_error(message); }
static Geometry Grid(int w, int h) { return {{w,h},{w*2,h*2},32,{0,0},{0,float(h*32)},w*32,h*32}; }
static std::vector<int> Column(const SGridShape& g, int x) {
	std::vector<int> cells;
	for (int z=0; z<g.gh; ++z) cells.push_back(g.Index(x,z));
	return cells;
}

static void test_geometry_axis_and_coarse_mapping() {
	const auto a = Grid(4,4);
	Require(a.Coarse(a.fg.Index(3,3)) == a.g.Index(1,1), "fine/coarse correspondence");
	Require(a.Centre(5).x == 48 && a.Centre(5).z == 48, "cell centre");
	Require(a.Forward(48,80) == 80 && a.Sideways(48,80) == -48, "north/south projections");
	const Geometry b({4,4},{8,8},32,{128,0},{0,0},128,128);
	Require(b.Forward(48,80) == 80 && b.Sideways(48,80) == -80, "reversed east/west projections");
}

static void test_clearance_partial_cell_and_reused_storage() {
	const auto a = Grid(2,2);
	std::vector<unsigned char> pass(16,1); pass[0]=0;
	std::vector<char> open(4), mask(16);
	std::vector<int> fine(16), best(4), worst(4);
	const auto* memory = fine.data();
	BuildClearance(a,pass,open,mask,fine,best,worst);
	Require(open[0] && worst[0]==0 && best[0]>0, "partial cell stays mobile but not formation-safe");
	Require(worst[3]>0 && mask[0]==0, "clear interior and fine mask");
	Require(fine.data()==memory, "reuse clearance capacity");
}

static void test_obstacles_threshold_and_four_connectivity() {
	SGridShape g{4,4};
	std::vector<unsigned char> pass(16,1); pass[0]=pass[1]=pass[6]=0;
	std::vector<int> comp(16); std::vector<char> kept(16); std::vector<SObstacle> obstacles;
	FindObstacles(g,pass,2,C_BOT,comp,kept,obstacles);
	Require(obstacles.size()==1 && obstacles[0].cells==2 && obstacles[0].cls==C_BOT, "only large obstacle retained");
	Require(kept[0] && kept[1] && !kept[6] && comp[1]!=comp[6], "diagonal contact does not merge obstacles");
	Require(obstacles[0].centre.x==16 && obstacles[0].centre.z==8, "obstacle centroid");
}

static void test_candidates_direct_and_specialist_fallback() {
	const auto a=Grid(5,5); SSettings st; st.corridorMax=1;
	std::vector<char> open(25,1), goal(25), route(25); goal[22]=1;
	std::vector<int> clr(25,12), minimum(25,3); std::vector<float> cost(25);
	const auto paths=FindCandidates(a,st,nullptr,{2},goal,open,clr,minimum,route,cost);
	Require(paths==Paths{Column(a.g,2)}, "equal-cost route is direct");
	st.footprintWidth=100000;
	const auto fallback=FindCandidates(a,st,nullptr,{2},goal,open,clr,minimum,route,cost);
	Require(fallback==paths && route==open, "no broad connection retains specialist path");
}

static void test_candidates_blocked_diagonal_and_cancellation() {
	const auto a=Grid(2,2); SSettings st; st.corridorMax=1;
	std::vector<char> open{1,0,0,1}, goal{0,0,0,1}, route(4);
	std::vector<int> clr(4,12), minimum(4,3); std::vector<float> cost(4);
	Require(FindCandidates(a,st,nullptr,{0},goal,open,clr,minimum,route,cost).empty(), "no corner cutting");
	std::atomic<bool> cancel{true}; bool cancelled=false;
	try { FindCandidates(a,st,&cancel,{0},goal,open,clr,minimum,route,cost); } catch (const Cancelled&) { cancelled=true; }
	Require(cancelled, "cancellation retained at candidate boundary");
}

static void test_group_routes_obstacle_separates_open_passage() {
	const auto a=Grid(7,7); const Paths paths{Column(a.g,1),Column(a.g,5)};
	std::vector<char> kept(a.fg.Size()),inside(a.fg.Size()),seams,blocked; std::vector<int> group;
	Require(GroupRoutes(a,paths,.2f,kept,inside,seams,blocked,group)==1, "open field is one passage");
	for (int z=0;z<a.fg.gh;++z) kept[a.fg.Index(7,z)]=1;
	Require(GroupRoutes(a,paths,.2f,kept,inside,seams,blocked,group)==2 && group[0]!=group[1], "wall separates passages");
	Require(GroupRoutes(a,{},.2f,kept,inside,seams,blocked,group)==0 && group.empty(), "empty route set");
}

static void test_ownership_ties_closed_and_unreachable_cells() {
	SGridShape g{5,3}; std::vector<char> open(15,1); open[7]=0;
	std::vector<std::int16_t> owner(15);
	AssignOwnership(g,open,{{0},{4}},{1,0},owner);
	Require(owner[2]==0 && owner[7]==-1, "lower group wins equal distance; closed stays unowned");
	AssignOwnership(g,open,{}, {},owner);
	Require(std::all_of(owner.begin(),owner.end(),[](int i){return i==-1;}), "no sources means no ownership");
}

static void test_record_width_choke_metadata_and_empty_path() {
	const auto a=Grid(3,10); const auto path=Column(a.g,1);
	std::vector<int> clr(30,12); clr[path[0]]=1; clr[path[5]]=6;
	const auto r=MakeRecord(a,C_BOT,9,path,clr,65,3,1,2);
	Require(r.id==9 && r.cls==C_BOT && r.routes==3 && r.lane==1 && r.lanes==2, "record identity");
	Require(r.narrowest==64 && r.choke.z==176 && r.specialist, "ignore endpoint choke; classify interior width");
	Require(r.length==288 && r.centre.size()==2 && r.width.size()==2, "length and simplification");
	const auto empty=MakeRecord(a,C_BOT,0,{},clr,64,0,0,1);
	Require(empty.centre.empty() && empty.length==0 && empty.narrowest==0, "empty record is safe");
}

static void test_centre_filters_seeds_and_restores_candidate_cells() {
	const auto a=Grid(3,5); const Paths routes{Column(a.g,1)};
	std::vector<char> routeOpen(15,1),free(15),goal(15); routeOpen[7]=0;
	std::vector<std::int16_t> owner(15,0); std::vector<int> clr(15,12); std::vector<float> cost(15);
	const auto path=FindCentre(a,routes,{0},0,0,{1},{13},routeOpen,owner,clr,0,free,goal,cost);
	Require(path==routes[0] && free[7], "candidate cells remain connected after ownership filtering");
	const auto fallback=FindCentre(a,routes,{0},0,0,{}, {},routeOpen,owner,clr,0,free,goal,cost);
	Require(fallback==path, "missing seeds fall back to candidate endpoints");
}

static void test_lane_paths_split_and_failure_reset() {
	const auto a=Grid(40,40); const int n=a.g.Size(); SSettings st; st.laneSpacing=512;
	std::vector<char> open(n,1),goal(n); std::vector<std::int16_t> owner(n,0); std::vector<int> clr(n,30);
	SCorridor whole; whole.centre={{640,16},{640,1264}}; Paths paths; std::vector<int> bands;
	const int count=BuildLanePaths(a,st,0,open,open,owner,clr,whole,goal,paths,bands);
	Require(count==2 && paths.size()==2 && bands.size()==std::size_t(n), "wide field splits into two usable bands");
	Require(paths[0]!=paths[1] && whole.extent>1000, "distinct paths and measured extent");
	std::vector<char> closed(n,0);
	Require(BuildLanePaths(a,st,0,open,closed,owner,clr,whole,goal,paths,bands)==1 && paths.empty(), "failed split resets all partial paths");
	st.laneMax=1;
	Require(BuildLanePaths(a,st,0,open,open,owner,clr,whole,goal,paths,bands)==1 && bands.empty(), "disabled splitting clears stale output");
}

static void test_distance_cost_and_json_compatibility() {
	Require(CentreCost(9,0)==.1f && CentreCost(9,.1f)==.2f, "zero preserves old cost; distance adds floor");
	Require(CentreCost(1,.08f)>CentreCost(100,.08f) && CentreCost(100,.08f)>.08f, "clearance still matters with positive floor");
	SSettings st; Json::Value root; root["field"]["corridors"]["distance_cost"]=0;
	ReadTerrainSettings(root,st); Require(st.laneDistanceCost==0, "JSON can restore legacy cost");
	root["field"]["corridors"]["distance_cost"]=-1;
	ReadTerrainSettings(root,st); Require(st.laneDistanceCost==0, "negative cost rejected by clamp");
	root["field"]["corridors"]["distance_cost"]=2;
	ReadTerrainSettings(root,st); Require(st.laneDistanceCost==1, "cost bounded above");
}

static void test_centre_distance_floor_rejects_clearance_detour() {
	const auto a=Grid(9,7);
	const std::vector<int> direct{28,29,30,31,32,33,34};
	const Paths routes{direct};
	std::vector<char> open(63,1),free(63),goal(63);
	std::vector<std::int16_t> owner(63,0); std::vector<int> clr(63,100); std::vector<float> cost(63);
	std::fill(clr.begin()+27,clr.begin()+36,9);
	const auto legacy=FindCentre(a,routes,{0},0,0,{28},{34},open,owner,clr,0,free,goal,cost);
	const auto bounded=FindCentre(a,routes,{0},0,0,{28},{34},open,owner,clr,1,free,goal,cost);
	Require(legacy!=direct && bounded==direct, "distance lever rejects a needless excursion onto wider ground");
}

int main() {
	try {
		test_geometry_axis_and_coarse_mapping();
		test_clearance_partial_cell_and_reused_storage();
		test_obstacles_threshold_and_four_connectivity();
		test_candidates_direct_and_specialist_fallback();
		test_candidates_blocked_diagonal_and_cancellation();
		test_group_routes_obstacle_separates_open_passage();
		test_ownership_ties_closed_and_unreachable_cells();
		test_record_width_choke_metadata_and_empty_path();
		test_centre_filters_seeds_and_restores_candidate_cells();
		test_lane_paths_split_and_failure_reset();
		test_distance_cost_and_json_compatibility();
		test_centre_distance_floor_rejects_clearance_detour();
	} catch (const std::exception& e) { std::cerr << e.what() << '\n'; return 1; }
	std::cout << "field_corridor_helpers_test: 12 contracts passed\n";
}
