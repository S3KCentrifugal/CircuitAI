// TECH perimeter defence. Geometry remains owned by Layout/native reservations;
// this policy owns only desired counts, soft candidate sites and order cooldown.
namespace EcoFlak {
    const string ROOT = "tech.ecoflak.";
    class Cluster {
        int zone;
        AIFloat3 low, high, centre;
        array<AIFloat3> sites;
        array<int> slots;
        int desired = 0, retry = 0, cursor = 0;
        Cluster(int z) { zone = z; }
    }
    array<Cluster@> clusters;
    bool loaded = false;
    IUnitTask@ construction;
    int constructorId = -1;
    // One retained task handle, validated by task and unit lifetime. No owned
    // unit scan or periodic allocation; a lost builder leaves a recoverable frame.
    bool Busy() {
        if (construction is null) return false;
        if (!construction.IsDead() && ai.GetTeamUnit(constructorId) !is null) return true;
        if (!construction.IsDead()) aiBuilderMgr.AbortTask(construction);
        @construction = null; constructorId = -1;
        return false;
    }
    IUnitTask@ Claim(CCircuitUnit@ worker, IUnitTask@ task) {
        if (task !is null) { @construction = task; constructorId = worker.id; }
        return task;
    }
    bool AssistanceAllowed(CCircuitUnit@ worker, CCircuitUnit@ target) {
        if (worker is null || target is null) return false;
        CCircuitDef@ flak = Definition();
        return TechEconomyMath::FlakAssistAllowed(worker.circuitDef.IsMobile(),
            UnitHelpers::GetConstructorTier(worker.circuitDef),
            target.circuitDef is flak, worker.id == constructorId && Busy());
    }
    int tickFrame = -100000, planBudget = 0;
    int threatFrame = -1, threatened = -1;
    array<AIFloat3> bases;

    bool Enabled() { return Global::RoleSettings::Tech::EcoFlakEnabled
        && Global::AISettings::Role == AiRole::TECH && aiTerrainMgr.IsLayoutEnabled(); }
    int Maximum() { return AiMax(0, AiMin(64, Global::RoleSettings::Tech::EcoFlakMaximum)); }
    string Key(Cluster@ c) { return ROOT + c.zone + "."; }
    void Clear() { clusters.resize(0); bases.resize(0); tickFrame = -100000; threatFrame=-1; }
    void Load() {
        if (loaded) return;
        loaded = true;
        Global::RoleSettings::Tech::EcoFlakMinimum = aiSetupMgr.ConfigInt("weapons/eco_flak/minimum", Global::RoleSettings::Tech::EcoFlakMinimum);
        Global::RoleSettings::Tech::EcoFlakMaximum = aiSetupMgr.ConfigInt("weapons/eco_flak/maximum", Global::RoleSettings::Tech::EcoFlakMaximum);
        Global::RoleSettings::Tech::EcoFlakCooldownSeconds = aiSetupMgr.ConfigFloat("weapons/eco_flak/cooldown_seconds", Global::RoleSettings::Tech::EcoFlakCooldownSeconds);
        Global::RoleSettings::Tech::EcoFlakBaseRadius = aiSetupMgr.ConfigFloat("weapons/eco_flak/base_radius", Global::RoleSettings::Tech::EcoFlakBaseRadius);
    }
    CCircuitDef@ Definition() { return ai.GetCircuitDef(UnitHelpers::GetStaticT2AAFlakNameForSide(Global::AISettings::Side)); }
    void Add(int zone) {
        if (zone <= 0) return;
        for (uint i=0; i<clusters.length(); ++i) if (clusters[i].zone == zone) return;
        const AIFloat3 low = aiTerrainMgr.GetZoneCorner(zone, false), high = aiTerrainMgr.GetZoneCorner(zone, true);
        if (low.x < 0.f) return;
        Cluster@ c = Cluster(zone);
        c.low = low; c.high = high; c.centre = (low + high) * .5f;
        c.desired = AiMax(0, AiMin(Maximum(), aiTerrainMgr.GetLayoutInt(Key(c)+"desired", 0)));
        for (int i=0; i<Maximum(); ++i) {
            const int slot = aiTerrainMgr.GetLayoutInt(Key(c)+"slot"+i, -1);
            c.slots.insertLast(slot);
            c.sites.insertLast(slot >= 0 ? aiTerrainMgr.GetReservationPos(slot) : AIFloat3(-1.f,0.f,-1.f));
        }
        clusters.insertLast(c);
        GenericHelpers::LogUtil("[EcoFlak] cluster="+zone+" planned maximum="+Maximum(),1);
    }
    // Native packing can use the turret-reach ring outside its zone. Leave
    // that ring, including compact turret spread, available for economy.
    float Margin() {
        float margin = 64.f + (Layout::nano is null ? 400.f : Layout::nano.GetBuildDistance());
        if (CompactEco::Active()) margin += Global::RoleSettings::Tech::CompactEcoTurretSpread;
        return margin;
    }
    bool OutsideEconomy(const AIFloat3& in p) {
        const float margin = Margin();
        for (uint i=0; i<clusters.length(); ++i) {
            Cluster@ c = clusters[i];
            if (p.x > c.low.x-margin && p.x < c.high.x+margin
                && p.z > c.low.z-margin && p.z < c.high.z+margin) return false;
        }
        return true;
    }
    bool OwnsArea(const AIFloat3& in p) {
        if (!Enabled()) return false;
        const float radius = AiMax(0.f, Global::RoleSettings::Tech::EcoFlakBaseRadius);
        for (uint i=0; i<clusters.length(); ++i)
            if (MapHelpers::SqDist(p,clusters[i].centre) <= radius*radius) return true;
        return false;
    }
    bool Space(const AIFloat3& in p, Cluster@ owner, uint index) {
        for (uint i=0; i<clusters.length(); ++i) for (uint j=0; j<clusters[i].sites.length(); ++j) {
            if (clusters[i] is owner && j == index) continue;
            const AIFloat3 other = clusters[i].sites[j];
            if (other.x >= 0.f && MapHelpers::SqDist(p,other) < 112.f*112.f) return false;
        }
        return true;
    }
    bool Plan(Cluster@ c, uint index, CCircuitDef@ def) {
        // Soft sites do not reserve future expansion ground. A task pins its
        // footprint only after fresh placement/reach checks. At most 32 native
        // placement probes per TECH economy tick, shared across all clusters.
        if (planBudget <= 0 || ai.frame < c.retry) return false;
        const float margin = Margin();
        const float hx = (c.high.x-c.low.x)*.5f + margin + 16.f;
        const float hz = (c.high.z-c.low.z)*.5f + margin + 16.f;
        for (int trial=0; trial<32 && planBudget>0; ++trial) {
            --planBudget;
            const int candidate = c.cursor++ % 192;
            // Coprime stride spreads the first few guns around the perimeter.
            const float angle = float((candidate * 25) % 64) * 6.2831853f / 64.f;
            const float x = cos(angle), z = sin(angle);
            const float ring = float(candidate/64)*96.f;
            const float scale = AiMax(abs(x)/(hx+ring), abs(z)/(hz+ring));
            const AIFloat3 p(c.centre.x+x/scale,0.f,c.centre.z+z/scale);
            if (p.x<64.f || p.z<64.f || p.x>=AiTerrainWidth()-64.f || p.z>=AiTerrainHeight()-64.f
                || !OutsideEconomy(p) || !Space(p,c,index) || aiBattle.IsFriendlyLane(p)
                || !aiTerrainMgr.IsAlliedSpaceFree(def,p,0) || !aiTerrainMgr.CanReserveBuilding(def,p,0)) continue;
            c.sites[index]=p;
            return true;
        }
        if (c.cursor % 192 == 0) c.retry=ai.frame+30*SECOND;
        return false;
    }
    void Tick() {
        if (!Enabled() || ai.frame < tickFrame+SECOND) return;
        Load(); tickFrame=ai.frame; planBudget=32;
        if (bases.length()==0) bases=Lanes::AllyStarts();
        if (Layout::HasBox()) for (int i=0; i<Layout::ZoneCount(); ++i) Add(Layout::ZoneAt(i));
        else if (Layout::nanoGroup>0) Add(aiTerrainMgr.GetGroupZone(Layout::nanoGroup));
        if (CompactEco::Active()) for (uint i=0; i<CompactEco::zones.length(); ++i) Add(CompactEco::zones[i]);
        CCircuitDef@ def=Definition();
        if (def is null) return;
        bool afus=aiTerrainMgr.GetLayoutInt(ROOT+"afus",0)>0;
        if (!afus) {
            const array<string> names=UnitHelpers::GetAllAdvancedFusionReactors();
            for (uint i=0; i<names.length(); ++i) {
                CCircuitDef@ d=ai.GetCircuitDef(names[i]);
                if (d !is null && d.count>aiBuilderMgr.GetUnfinishedCount(d)) { afus=true; break; }
            }
            if (afus) aiTerrainMgr.SetLayoutInt(ROOT+"afus",1);
        }
        for (uint i=0; i<clusters.length(); ++i) {
            Cluster@ c=clusters[i];
            const int minimum=afus ? AiMax(0,AiMin(Maximum(),Global::RoleSettings::Tech::EcoFlakMinimum)) : 0;
            if (c.desired<minimum) { c.desired=minimum; aiTerrainMgr.SetLayoutInt(Key(c)+"desired",c.desired); }
            for (uint j=0; j<c.sites.length() && planBudget>0; ++j)
                if (c.slots[j]<0 && c.sites[j].x<0.f) Plan(c,j,def);
        }
    }
    int ThreatenedCluster() {
        // Existing legal air-contact snapshot; O(A*(C+B)), once per work ask
        // only when cooldown allows a new obligation. No hidden contact reads.
        if (threatFrame==ai.frame) return threatened;
        threatFrame=ai.frame;
        int best=-1; float distance=1.e30f;
        const float radius=AiMax(0.f,Global::RoleSettings::Tech::EcoFlakBaseRadius);
        for (int a=0; a<aiBattle.GetAirContactCount(); ++a) {
            const AIFloat3 p=aiBattle.GetAirContactPos(a);
            bool inside=OwnsArea(p);
            for (uint b=0; !inside && b<bases.length(); ++b) inside=MapHelpers::SqDist(p,bases[b])<=radius*radius;
            if (!inside) continue;
            for (uint i=0; i<clusters.length(); ++i) {
                if (ai.frame<clusters[i].retry || clusters[i].desired>=Maximum()) continue;
                const float sq=MapHelpers::SqDist(p,clusters[i].centre);
                if (sq<distance) { distance=sq; best=int(i); }
            }
        }
        threatened=best; return best;
    }
    int Occupied(Cluster@ c) {
        int count=0;
        for (uint i=0; i<c.slots.length(); ++i) {
            const int state=aiTerrainMgr.GetReservationState(c.slots[i]);
            if (state>=1 && state<=3) ++count;
        }
        return count;
    }
    IUnitTask@ Work(CCircuitUnit@ worker) {
        if (!Enabled() || worker is null) return null;
        if (Busy()) return worker.id == constructorId ? construction : null;
        Tick();
        CCircuitDef@ def=Definition();
        if (def is null || !worker.circuitDef.CanBuild(def)) return null;
        // Load/death recovery: only query a frame when the native definition
        // counter says one exists. The repair is detached just like the build.
        if (aiBuilderMgr.GetUnfinishedCount(def) > 0) {
            CCircuitUnit@ frame = null;
            for (uint i = 0; i < clusters.length() && frame is null; ++i) {
                Cluster@ cluster = clusters[i];
                const float radius = (cluster.high.x-cluster.low.x + cluster.high.z-cluster.low.z)*0.5f + Margin()*2.0f + 384.0f;
                @frame = aiBuilderMgr.FindUnfinishedNear(cluster.centre, radius, def);
            }
            if (frame !is null && aiTerrainMgr.CanReachAtSafe(worker, frame.GetPos(ai.frame), worker.circuitDef.GetBuildDistance())) {
                SBuildTask repair = TaskB::Repair(Task::Priority::HIGH, frame, 120 * SECOND);
                repair.isActive = false;
                return Claim(worker, aiBuilderMgr.Enqueue(repair));
            }
            return null;
        }
        const int cooldown=int(AiMax(0.f,Global::RoleSettings::Tech::EcoFlakCooldownSeconds)*SECOND);
        if (ai.frame < aiTerrainMgr.GetLayoutInt(ROOT+"last",-100000)+cooldown) return null;
        int selected=-1;
        // Restore existing commitments before increasing any cluster's quota.
        for (uint i=0; i<clusters.length(); ++i)
            if (ai.frame>=clusters[i].retry && Occupied(clusters[i])<clusters[i].desired) { selected=int(i); break; }
        bool increase=false;
        if (selected<0) { selected=ThreatenedCluster(); increase=selected>=0; }
        if (selected<0 || !def.IsBuildAllowed()) return null;
        Cluster@ c=clusters[selected];
        if (ai.frame<c.retry) return null;
        for (uint i=0; i<c.slots.length(); ++i) {
            int state=aiTerrainMgr.GetReservationState(c.slots[i]);
            if (state>=1 && state<=3) continue;
            if (state==4 || (state<0 && c.slots[i]>=0)) {
                aiTerrainMgr.ReleasePersistentBuilding(c.slots[i]);
                c.slots[i]=-1; c.sites[i]=AIFloat3(-1.f,0.f,-1.f);
            }
            if (c.slots[i]<0 && c.sites[i].x>=0.f && (!OutsideEconomy(c.sites[i])
                || !aiTerrainMgr.CanReserveBuilding(def,c.sites[i],0))) c.sites[i]=AIFloat3(-1.f,0.f,-1.f);
            if (c.sites[i].x<0.f && !Plan(c,i,def)) continue;
            const AIFloat3 p=c.sites[i];
            if (!aiTerrainMgr.IsAlliedSpaceFree(def,p,0)) {
                if (c.slots[i]>=0) aiTerrainMgr.ReleasePersistentBuilding(c.slots[i]);
                c.slots[i]=-1; c.sites[i]=AIFloat3(-1.f,0.f,-1.f);
                continue;
            }
            if (!aiTerrainMgr.CanReachAtSafe(worker,p,worker.circuitDef.GetBuildDistance())) continue;
            if (c.slots[i]>=0 && !aiTerrainMgr.IsReservationBuildable(c.slots[i])) continue;
            if (def.maxThisUnit<=def.count) def.maxThisUnit=def.count+1;
            if (!def.IsAvailable(ai.frame)) return null;
            if (c.slots[i]<0) {
                c.slots[i]=aiTerrainMgr.ReservePersistentBuilding(def,p,0);
                if (c.slots[i]<0) continue;
                aiTerrainMgr.SetLayoutInt("strict.slot."+c.slots[i],1);
                c.sites[i]=aiTerrainMgr.GetReservationPos(c.slots[i]);
                aiTerrainMgr.SetLayoutInt(Key(c)+"slot"+i,c.slots[i]);
            }
            aiTerrainMgr.SetLayoutInt("strict.slot."+c.slots[i],1);
            IUnitTask@ task=aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::DEFENCE,Task::Priority::HIGH,
                def,c.sites[i],0.f,false,120*SECOND));
            if (task is null) return null;
            if (!AiPinReservation(task,c.slots[i])) { aiBuilderMgr.AbortTask(task); return null; }
            if (increase) { ++c.desired; aiTerrainMgr.SetLayoutInt(Key(c)+"desired",c.desired); }
            aiTerrainMgr.SetLayoutInt(ROOT+"last",ai.frame);
            threatFrame=-1;
            if (Occupied(c)>Maximum()) Invariants::Violation("INV-226",""+c.zone,"eco flak exceeds cluster cap");
            GenericHelpers::LogUtil("[EcoFlak] order cluster="+c.zone+" slot="+c.slots[i]+" desired="+c.desired
                +" cause="+(increase?"air":"minimum-or-rebuild")+" frame="+ai.frame,1);
            return Claim(worker, task);
        }
        c.retry=ai.frame+5*SECOND;
        return null;
    }
}
