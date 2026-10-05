#include "sea_layout.as"
#include "../helpers/build_power_math.as"
#include "../helpers/sea_math.as"
#include "economy.as"
#include "team_economy.as"

namespace SeaEconomy {
    array<int> owned;
    array<int> productionFactories;
    array<IUnitTask@> projects;
    dictionary counts, finished, busy, support, products;
    float productionBasePower=0;
    int frame=-1, logFrame=-100000, mexWorker=-1;
    float mobilePower=0, pendingPower=0, idlePower=0, committedM=0, committedE=0;
    float admittedM=0, admittedE=0;
    float recruitAdmittedM=0, recruitAdmittedE=0;
    int fundedFrame=-1; string fundedName;
    int Number(const string &in name, bool complete=false) {
        int64 n=0; if (complete) finished.get(name,n); else counts.get(name,n); return int(n);
    }
    void Increment(dictionary &inout values, const string &in key) {
        int64 n=0; values.get(key,n); values.set(key,n+1);
    }
    void Added(IUnitTask@ task) {
        if (!SeaLayout::Enabled()) return;
        IBuilderTask@ t=cast<IBuilderTask>(task);
        if (t !is null && t.buildDef !is null && t.GetBuildType()<int(Task::BuildType::REPAIR)
            && projects.findByRef(t)<0) projects.insertLast(t);
    }
    void Removed(IUnitTask@ task) {
        const int index=projects.findByRef(task);
        if (index>=0) projects.removeAt(index);
    }
    bool OwnsTask(IUnitTask@ task) {
        // Native reservationId is set only when the builder reaches/serves its
        // slot. A claimed pin is already ours throughout the approach journey.
        return task !is null && (projects.findByRef(task)>=0 || AiTaskReservationId(task)>=0);
    }
    int Pending(CCircuitDef@ d) {
        if (d is null) return 0;
        int n=0;
        for (uint i=0; i<projects.length(); ++i) {
            IBuilderTask@ t=cast<IBuilderTask>(projects[i]);
            if (t !is null && !t.IsDead() && t.buildDef is d && t.target is null) ++n;
        }
        return n;
    }
    int Have(CCircuitDef@ d) { return d is null ? 0 : d.count+Pending(d); }
    string Constructor(const string &in side, bool advanced) {
        if (advanced) return side=="armada" ? "armacsub" : side=="cortex" ? "coracsub" : "leganavyconsub";
        return side=="armada" ? "armcs" : side=="cortex" ? "corcs" : "legnavyconship";
    }
    bool Yard(const CCircuitDef@ d) { return d !is null && (UnitHelpers::IsT1Shipyard(d.GetName()) || UnitHelpers::IsT2Shipyard(d.GetName())); }
    // Support eligibility is broader than shipyard tech and relocation policy.
    bool SupportedFactory(const CCircuitDef@ d) {
        if (d is null) return false;
        const string name=d.GetName();
        return Yard(d) || name=="armamsub" || name=="coramsub" || name=="legamphlab"
            || UnitHelpers::IsFloatingHoverPlant(name) || UnitHelpers::IsWaterGantry(name);
    }
    CCircuitDef@ Product(int factoryId) {
        int id=-1;
        return products.get(""+factoryId,id) ? ai.GetCircuitDef(id) : null;
    }
    bool ConstructorDef(const CCircuitDef@ d) { return d !is null && (SeaConstructor::IsT1(d) || SeaConstructor::IsT2(d)); }
    string SiteKey(const string &in name, const AIFloat3 &in p) { return name+":"+int(p.x)+":"+int(p.z); }
    bool Busy(int id) { return busy.exists(""+id); }
    void Tick() {
        if (!SeaLayout::Enabled() || ai.frame-frame<SECOND) return;
        frame=ai.frame; owned.resize(0); counts.deleteAll(); finished.deleteAll(); busy.deleteAll(); support.deleteAll(); mexWorker=-1;
        productionFactories.resize(0); products.deleteAll(); productionBasePower=0;
        mobilePower=0; pendingPower=0; idlePower=0; committedM=0; committedE=0; admittedM=0; admittedE=0; recruitAdmittedM=0; recruitAdmittedE=0;
        dictionary berthSites, berthProducers;
        for (uint b=0; b<SeaLayout::berths.length(); ++b) {
            SeaLayout::Berth@ berth=SeaLayout::berths[b];
            if (berth.slot>=0) berthSites.set(SiteKey(berth.name,berth.centre),int64(b));
            if (berth.unit>=0) berthProducers.set(""+berth.unit,int64(b));
        }
        array<Id>@ ids=ai.GetOwnedUnitIds();
        for (uint i=0; i<ids.length(); ++i) {
            CCircuitUnit@ u=ai.GetTeamUnit(ids[i]); if (u is null) continue;
            owned.insertLast(u.id); const CCircuitDef@ d=u.circuitDef;
            const float progress=u.GetBuildProgress(); Increment(counts,d.GetName());
            // Unit handles borrowed from tasks can outlive a transfer. Account
            // framed work only through the currently owned, validated units.
            if (progress<1.0f) { committedM+=d.costM*(1-progress); committedE+=d.costE*(1-progress); }
            if (progress>=1.0f) Increment(finished,d.GetName());
            if (progress>=1 && SeaConstructor::IsT1(d) && (mexWorker<0 || u.id<mexWorker)) mexWorker=u.id;
            if (u.GetProducerId()>=0 && progress<1.0f) {
                busy.set(""+u.GetProducerId(),true);
                products.set(""+u.GetProducerId(),int(d.id));
            }
            if (progress>=1 && SupportedFactory(d) && !Lifecycle::IsRetiring(u)) productionFactories.insertLast(u.id);
            // A shore commander is not a naval expansion worker. Count its
            // actual yard assistance in LocalPower, not in mobile capacity.
            if (ConstructorDef(d)) {
                if (progress<1.0f) pendingPower+=d.GetBuildSpeed();
                else {
                    mobilePower+=d.GetBuildSpeed();
                    if (u.task is null || u.task.GetType()==int(Task::Type::WAIT) || u.task.GetType()==int(Task::Type::IDLE)) idlePower+=d.GetBuildSpeed();
                }
            }
            // Re-associate completed yards after reload, transfer or frame creation.
            int64 berthIndex=-1;
            if (Yard(d) && berthSites.get(SiteKey(d.GetName(),u.GetPos(ai.frame)),berthIndex)) {
                SeaLayout::Berth@ berth=SeaLayout::berths[uint(berthIndex)];
                if (berth.unit!=u.id) { berth.unit=u.id; berth.active=true; SeaLayout::Save(berth); }
                berthProducers.set(""+u.id,berthIndex);
            }
            // A real ordinary product must leave: a completed building is not proof.
            if (progress>=1.0f && d.IsMobile() && !d.IsAbleToFly() && u.GetProducerId()>=0
                && berthProducers.get(""+u.GetProducerId(),berthIndex)) {
                SeaLayout::Berth@ berth=SeaLayout::berths[uint(berthIndex)];
                if (!berth.exited && MapHelpers::SqDist(u.GetPos(ai.frame),berth.centre)>Global::RoleSettings::Sea::ExitLength*Global::RoleSettings::Sea::ExitLength) {
                    berth.exited=true; SeaLayout::Save(berth);
                    GenericHelpers::LogUtil("[SEA][Harbor] exit verified yard="+berth.unit+" ship="+u.id,1);
                }
            }
        }
        for (uint i=0; i<productionFactories.length(); ++i) {
            CCircuitUnit@ factory=ai.GetTeamUnit(productionFactories[i]);
            if (factory !is null && Busy(factory.id)) productionBasePower+=factory.circuitDef.GetBuildSpeed();
        }
        for (int i=int(projects.length())-1; i>=0; --i) {
            IBuilderTask@ t=cast<IBuilderTask>(projects[i]);
            if (t is null || t.IsDead()) { projects.removeAt(i); continue; }
            if (t.target is null) { committedM+=t.buildDef.costM; committedE+=t.buildDef.costE; }
        }
        const array<string> constructors=UnitHelpers::GetAllT1SeaConstructors();
        const array<string> advanced=UnitHelpers::GetAllT2SeaConstructors();
        for (uint i=0; i<constructors.length()+advanced.length(); ++i) {
            CCircuitDef@ d=ai.GetCircuitDef(i<constructors.length() ? constructors[i] : advanced[i-constructors.length()]);
            if (d !is null) pendingPower+=float(aiFactoryMgr.GetPendingRecruitCount(d))*d.GetBuildSpeed();
        }
        if (ai.frame-logFrame>=30*SECOND) {
            logFrame=ai.frame;
            GenericHelpers::LogUtil("[SEA][Economy] M="+aiEconomyMgr.metal.income+" E="+aiEconomyMgr.energy.income
                +" bank="+aiEconomyMgr.metal.current+" workers="+mobilePower+" pending="+pendingPower+" committed="+committedM,1);
        }
    }
    bool TechReady(CCircuitDef@ yard, bool saving=false) {
        if (yard is null || !Economy::IncomeWindowReady()) return false;
        CCircuitDef@ con=ai.GetCircuitDef(Constructor(UnitHelpers::GetSideForUnitName(yard.GetName()),true));
        if (con is null) return false;
        return SeaMath::TechReady(Economy::GetMinMetalIncomeLast10s(),Economy::GetMinEnergyIncomeLast10s(),
            saving ? yard.costM+con.costM+800.0f : AiMax(0.0f,aiEconomyMgr.metal.current-admittedM),aiEconomyMgr.energy.current,
            Global::RoleSettings::Sea::TechMinimumMetalIncome,Global::RoleSettings::Sea::MinimumEnergyIncomeForT2Shipyard,
            Global::RoleSettings::Sea::RequiredMetalCurrentForT2Shipyard,yard.costM+con.costM+800.0f,yard.costE+con.costE+8000.0f,
            Global::RoleSettings::Sea::TechPackageSeconds,Global::RoleSettings::Sea::TechPackageIncomeShare);
    }
    bool Fund(CCircuitDef@ d, float buildPower, float extraM=0, float extraE=0) {
        fundedFrame=-1; fundedName="";
        if (d is null || buildPower<=0) return false;
        const float seconds=AiMax(1.0f,d.GetBuildTime()/buildPower);
        // Existing usage already pays framed work. Unframed commitments reserve bank.
        float queuedM=0, queuedE=0;
        for (uint i=0; i<projects.length(); ++i) {
            IBuilderTask@ t=cast<IBuilderTask>(projects[i]);
            if (t !is null && !t.IsDead() && t.target is null) { queuedM+=t.buildDef.costM; queuedE+=t.buildDef.costE; }
        }
        const bool funded=BuildPowerMath::Funded(aiEconomyMgr.metal.current,0,aiEconomyMgr.metal.income,TeamEconomy::OwnMetal(TeamEconomy::USAGE),
            queuedM+recruitAdmittedM,d.costM,seconds,extraM,Global::RoleSettings::Sea::WorkforceHorizon)
            && BuildPowerMath::Funded(aiEconomyMgr.energy.current,0,aiEconomyMgr.energy.income,TeamEconomy::OwnEnergy(TeamEconomy::USAGE),
            queuedE+recruitAdmittedE,d.costE,seconds,extraE,Global::RoleSettings::Sea::WorkforceHorizon);
        if (funded) { fundedFrame=ai.frame; fundedName=d.GetName(); }
        return funded;
    }
    void Admit(CCircuitDef@ d, bool funded=false, bool pinnedProject=false) {
        if (d is null) return;
        if (funded && (fundedFrame!=ai.frame || fundedName!=d.GetName()))
            Invariants::Violation("INV-129",d.GetName(),"SEA workforce lacks same-frame funding");
        admittedM+=d.costM; admittedE+=d.costE;
        // Pinned construction is already present in the live projects ledger
        // used by Fund. Only factory admissions need a separate bank reserve.
        if (!pinnedProject) { recruitAdmittedM+=d.costM; recruitAdmittedE+=d.costE; }
    }
    float UsefulPower(CCircuitDef@ work, float share) {
        if (work is null) return 0;
        const float m=aiEconomyMgr.metal.income*share+AiMax(0.0f,aiEconomyMgr.metal.current-committedM-admittedM)/Global::RoleSettings::Sea::WorkforceHorizon;
        const float e=aiEconomyMgr.energy.income*share+AiMax(0.0f,aiEconomyMgr.energy.current-committedE-admittedE)/Global::RoleSettings::Sea::WorkforceHorizon;
        return BuildPowerMath::Power(m,e,work.GetBuildTime(),work.costM,work.costE);
    }
    float LocalPower(CCircuitUnit@ yard) {
        float value=yard.circuitDef.GetBuildSpeed();
        const AIFloat3 p=yard.GetPos(ai.frame);
        dictionary seen;
        for (uint i=0; i<owned.length(); ++i) {
            CCircuitUnit@ u=ai.GetTeamUnit(owned[i]);
            if (u is null || u is yard || SupportedFactory(u.circuitDef) || Factory::userData[u.circuitDef.id].attr!=0
                || u.circuitDef.GetBuildSpeed()<=0 || Lifecycle::IsRetiring(u)) continue;
            if (u.circuitDef.IsMobile()) {
                if (u.GetBuildProgress()<1) continue;
                IBuilderTask@ assist=cast<IBuilderTask>(u.task);
                if (assist is null || assist.target !is yard) continue;
            }
            const float reach=u.circuitDef.GetBuildDistance();
            if (MapHelpers::SqDist(u.GetPos(ai.frame),p)<=reach*reach) {
                value+=u.circuitDef.GetBuildSpeed(); seen.set(""+u.id,true);
            }
        }
        for (uint i=0; i<projects.length(); ++i) {
            IBuilderTask@ t=cast<IBuilderTask>(projects[i]);
            if (t is null || t.IsDead() || t.GetBuildType()!=int(Task::BuildType::NANO)) continue;
            // A just-framed turret may not be in the once-per-second census yet.
            if (t.target !is null && (seen.exists(""+t.target.id) || ai.GetTeamUnit(t.target.id) is null)) continue;
            const float reach=t.buildDef.GetBuildDistance();
            if (MapHelpers::SqDist(t.GetBuildPos(),p)<=reach*reach) value+=t.buildDef.GetBuildSpeed();
        }
        return value;
    }
    float SupportTarget(CCircuitUnit@ yard, CCircuitDef@ work) {
        if (yard is null || work is null) return 0;
        const float fraction=SeaMath::ProductionShare(yard.circuitDef.GetBuildSpeed(),productionBasePower);
        const float share=1.0f-Global::RoleSettings::Sea::EconomyIncomeShare;
        const float horizon=AiMax(1.0f,Global::RoleSettings::Sea::WorkforceHorizon);
        const float m=(aiEconomyMgr.metal.income*share+AiMax(0.0f,aiEconomyMgr.metal.current-committedM-admittedM)/horizon)*fraction;
        const float e=(aiEconomyMgr.energy.income*share+AiMax(0.0f,aiEconomyMgr.energy.current-committedE-admittedE)/horizon)*fraction;
        return BuildPowerMath::Power(m,e,work.GetBuildTime(),work.costM,work.costE);
    }
}
