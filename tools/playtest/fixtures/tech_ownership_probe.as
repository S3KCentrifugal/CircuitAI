// Supplied owner tests: real units/tasks, no natural production timing claim.
namespace TechOwnershipProbe {
    bool Handle(const string& in message) {
        array<string>@ parts=message.split("|");
        if(parts.length()!=5 || parts[0]!="tech-ownership") return false;
        const int expected=int(parseInt(parts[1]));
        CCircuitUnit@ worker=ai.GetTeamUnit(int(parseInt(parts[2])));
        CCircuitUnit@ heavy=ai.GetTeamUnit(int(parseInt(parts[3])));
        CCircuitUnit@ factory=ai.GetTeamUnit(int(parseInt(parts[4])));
        if(worker is null || heavy is null || factory is null) {
            GenericHelpers::LogUtil("[TechOwnershipTest] FAIL fixture units",1);return true;
        }
        GenericHelpers::LogUtil("[TechOwnershipTest] actual seats="+TechAirFoundry::Count(),1);
        bool ok=int(TechAirFoundry::Count())==expected && !TechAirFoundry::Owns(worker.id);
        if(expected>0) {
            CCircuitUnit@ first=ai.GetTeamUnit(TechAirFoundry::seats[0]);
            TechAirFoundry::Removed(first);
            TechAirFoundry::Added(worker);
            ok=ok && TechAirFoundry::Owns(worker.id) && !TechAirFoundry::Owns(first.id)
                && int(TechAirFoundry::Count())==expected;
            TechAirFoundry::Removed(worker);
            TechAirFoundry::Added(first);
            CCircuitUnit@ plant=Factory::primaryT1AirPlant;
            @Factory::primaryT1AirPlant=null;
            ok=ok && TechAirFoundry::Work(first) is null;
            @Factory::primaryT1AirPlant=plant;
            Global::AISettings::Role=AiRole::SUPPORT;
            ok=ok && !TechAirFoundry::Owns(first.id);
            Global::AISettings::Role=AiRole::TECH;
        }
        Global::RoleSettings::Tech::StrategyMask=uint(1)<<uint(Strategy::T2_RUSH);
        TechHeavyRush::Retain(heavy.id);
        // Supply a known spam route; the heavy must reuse this exact task,
        // even though its producer is not the spam factory.
        IUnitTask@ base=aiMilitaryMgr.Enqueue(TaskF::Route());
        CRouteTask@ route=cast<CRouteTask>(cast<IFighterTask>(base));
        const array<AIFloat3> points={heavy.GetPos(ai.frame),AIFloat3(4000,0,3000)};
        route.SetRoute(points);
        Spam::routeByFactory.set(""+factory.id,@route);
        IUnitTask@ selected=TechHeavyRush::MilitaryTask(heavy);
        ok=ok && selected is route && TechHeavyRush::OnFinished(heavy);
        if(selected !is null) aiMilitaryMgr.TransferUnit(heavy,selected);
        GenericHelpers::LogUtil("[TechOwnershipTest] "+(ok?"PASS":"FAIL")+" seats="+expected+" spare unclaimed; heavy uses spam route without delivery",1);
        return true;
    }
}
