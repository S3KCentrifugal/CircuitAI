"""Compile the production retirement callback against small manager-owned tasks.

This isolates lifetime/alias cleanup from engine APIs, without copying the
callback implementation. Run with Python; CXX may select a C++20 compiler.
"""
import os
import argparse
from pathlib import Path
import shutil
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / 'src/circuit/control/unit/commander/CommanderGroup.cpp'
PRELUDE = r'''
#include <algorithm>
#include <array>
#include <cassert>
#include <vector>
#define LOG(...) Log()
#define SQUARE(x) ((x)*(x))
constexpr float FRONT_GEO_SITE_RADIUS=64;
constexpr int GEO_GUARD_RETRIES=1, FRONT_GEO_FAILS=3;
struct AIFloat3 { float x=0,y=0,z=0; float SqDistance2D(AIFloat3 b) const {return SQUARE(x-b.x)+SQUARE(z-b.z);} };
bool OnMap(AIFloat3) {return true;}
enum class BT {GEO,MEXUP,DEFENCE,BUNKER};
struct Def {
    int GetId() const {return 1;} const Def* GetDef() const {return this;}
    const char* GetName() const {return "test";} bool IsRadar() const {return false;}
    float GetJammerRadius() const {return 0;}
};
int DefTier(const Def*) {return 1;}
struct Target {bool IsFinished() {return true;} int GetId() {return 1;}};
struct IUnitTask {virtual ~IUnitTask()=default;};
struct IBuilderTask: IUnitTask {
    Def def; BT type=BT::GEO;
    Def* GetBuildDef() {return &def;} const Def* GetBuildDef() const {return &def;}
    BT GetBuildType() const {return type;} AIFloat3 GetBuildPos() const {return {};}
    AIFloat3 GetPosition() const {return {};} Target* GetTarget() {return nullptr;}
};
struct Eco {bool IsGeoForward(int) {return false;} int GeoSpotAt(AIFloat3) {return 0;}};
struct AI {Eco eco; void Log() {} int GetTeamId() {return 0;} Eco* GetEconomyManager() {return &eco;}
    const Def* GetCircuitDefSafe(int) {return nullptr;}};
struct Work {
    IUnitTask* task=nullptr; IUnitTask* origin=nullptr;
    void Retire(IUnitTask* t) {if(task==t) task=nullptr;}
    void RetireOrigin(IUnitTask* t) {if(origin==t) origin=nullptr;}
};
struct State {Work work;};
struct Entry {State* value;};
struct CCommanderController {
    struct ExpansionJob {IUnitTask* task=nullptr; bool earnsNano=true,nano=false,committed=false; int until=-1;};
    struct Solar {IUnitTask* task=nullptr;};
    struct Guard {std::array<IUnitTask*,2> tasks{}; std::array<char,2> state{},retries{};};
    struct FrontGeoSite {AIFloat3 pos; int fails=0;};
    struct TacticalBlock {const IUnitTask* launcherTask=nullptr; int launcher=1,group=0; bool launcherStood=false; AIFloat3 launcherSite;};
    struct Config {struct Group {float nanoOther=0,nanoT2=4,nanoT1=1;} group;} config;
    AI engine; AI* ai=&engine; Config* cfg=&config;
    struct Role {bool frontDuty=true;} role;
    IUnitTask *junoJob=nullptr,*geoJob=nullptr,*tacticalJob=nullptr,*t1Job=nullptr;
    std::array<ExpansionJob,6> expansionJobs{};
    std::vector<Entry> states; std::vector<Solar> frontSolarReclaims;
    std::vector<Guard> geoGuards; std::vector<FrontGeoSite> frontGeoSites;
    std::vector<std::pair<int,TacticalBlock>> tacticalBlocks;
    int defenseNext=1,defenseOfferNext=1,defenseDecisionNext=1;
    int groupNanoOwed=0,groupRadar=-1,groupRadar2=-2,groupJammer=-3,groupJammer2=-4;
    bool groupNanoDue=false; AIFloat3 groupNanoSite; int plans=0;
    void PlanGeoGuard(const Def*,AIFloat3) {++plans;}
    void TaskFinished(IUnitTask*,bool);
};
'''
MAIN = r'''
int main() {
    // Completion and abort of the exact cross-queue geo alias from the crash.
    // Include duplicate slots and every other borrowed reference, then delete
    // the manager-owned task before the next queue inspection.
    for(bool done:{false,true}) for(int dedicated=0;dedicated<4;++dedicated) {
        CCommanderController c;
        auto* task=new IBuilderTask;
        IBuilderTask unrelated;
        State state; state.work={task,task}; c.states.push_back({&state});
        if(dedicated==0) c.geoJob=task;
        if(dedicated==1) c.junoJob=task;
        if(dedicated==2) c.tacticalJob=task;
        c.t1Job=task;
        c.expansionJobs[0].task=task; c.expansionJobs[1].task=task;
        c.expansionJobs[4].task=task;
        c.expansionJobs[2].task=&unrelated;
        c.frontSolarReclaims.push_back({task});
        c.geoGuards.push_back({}); c.geoGuards[0].tasks[0]=task;
        c.tacticalBlocks.push_back({1,{}}); c.tacticalBlocks[0].second.launcherTask=task;
        c.TaskFinished(task,done);
        delete task;
        assert(!c.expansionJobs[0].task && !c.expansionJobs[1].task);
        assert(!c.expansionJobs[4].task);
        assert(!c.geoJob && !c.junoJob && !c.tacticalJob && !c.t1Job);
        assert(!state.work.task && !state.work.origin);
        assert(c.expansionJobs[2].task==&unrelated);
        assert(!c.frontSolarReclaims[0].task && !c.geoGuards[0].tasks[0]);
        assert(c.geoGuards[0].state[0]==(done?2:0));
        assert(c.geoGuards[0].retries[0]==(done?0:1));
        assert(!c.tacticalBlocks[0].second.launcherTask);
        assert(c.tacticalBlocks[0].second.launcherStood==done);
        assert(c.groupNanoOwed==0);
        assert(c.plans==int(done && dedicated==0));
        // The surviving unrelated queue entry remains a live polymorphic task.
        for(const auto& slot:c.expansionJobs) if(slot.task)
            assert(dynamic_cast<IBuilderTask*>(slot.task)==&unrelated);
    }
    // Ordinary expansion completion still earns its construction-turret debt.
    CCommanderController c; IBuilderTask task; task.type=BT::DEFENCE;
    c.expansionJobs[0].task=&task;
    c.TaskFinished(&task,true);
    assert(c.groupNanoOwed==1 && c.groupNanoDue);
    // Recorded external geo site is removed safely before guard planning.
    CCommanderController external; IBuilderTask geo;
    external.frontGeoSites.push_back({}); external.TaskFinished(&geo,true);
    assert(external.frontGeoSites.empty() && external.plans==1);
}
'''


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', type=Path, default=SOURCE,
                        help='Callback source; permits checking the pre-fix negative control')
    source = parser.parse_args().source.read_text()
    callback = source[source.index('void CCommanderController::TaskFinished('):
                      source.index('IUnitTask* CCommanderController::GroupBuild(')]
    compiler = os.environ.get('CXX') or shutil.which('g++') or r'C:\msys64\mingw64\bin\g++.exe'
    environment = dict(os.environ)
    environment['PATH'] = str(Path(compiler).resolve().parent) + os.pathsep + environment['PATH']
    with tempfile.TemporaryDirectory(prefix='task-retirement-', dir=ROOT.parent) as folder:
        folder = Path(folder)
        unit = folder / 'retirement.cpp'
        binary = folder / 'retirement.exe'
        unit.write_text(PRELUDE + callback + MAIN)
        subprocess.run([compiler, '-std=c++20', '-Wall', '-Wextra', '-Werror',
                        '-Wno-unused-variable', '-D_GLIBCXX_DEBUG', str(unit), '-o', str(binary)],
                       check=True, env=environment)
        subprocess.run([str(binary)], check=True, env=environment)
    print('PASS: production TaskFinished completion/abort, all aliases, deletion, nano debt and geo-site retirement')


if __name__ == '__main__':
    main()
