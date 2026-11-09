// Admission only: an accepted delivery plan permanently selects the FRONT floor.
namespace FrontTechMath {
    bool RememberPlan(bool planned, bool requested, bool techSender) {
        return planned || (requested && techSender);
    }
    bool FactoryAllowed(bool front, bool planned, float income, float minimum) {
        return !front || !planned || minimum <= 0.f || income >= minimum;
    }
}
