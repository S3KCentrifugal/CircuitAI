#include <angelscript.h>
#include <fstream>
#include <iostream>
#include <iterator>
#include <string>

namespace {
int failures = 0;
void Check(asIScriptGeneric* call) {
    const bool condition = call->GetArgByte(0) != 0;
    if (!condition) { ++failures; asGetActiveContext()->SetException("assertion failed"); }
}
void Message(const asSMessageInfo* msg, void*) {
    std::cerr << msg->section << ':' << msg->row << ' ' << msg->message << '\n';
}
std::string Read(const char* path) {
    std::ifstream file(path);
    return {std::istreambuf_iterator<char>(file), std::istreambuf_iterator<char>()};
}
}
int main(int argc, char** argv) {
    if (argc != 3) return 2;
    asIScriptEngine* engine = asCreateScriptEngine();
    engine->SetMessageCallback(asFUNCTION(Message), nullptr, asCALL_CDECL);
    engine->RegisterGlobalFunction("void Check(bool)", asFUNCTION(Check), asCALL_GENERIC);
    asIScriptModule* mod = engine->GetModule("tests", asGM_ALWAYS_CREATE);
    const auto policy = Read(argv[1]);
    const auto tests = Read(argv[2]);
    mod->AddScriptSection("production_math.as", policy.c_str(), policy.size());
    mod->AddScriptSection("production_math_tests.as", tests.c_str(), tests.size());
    if (mod->Build() < 0) { engine->ShutDownAndRelease(); return 1; }
    int executed = 0;
    for (asUINT i = 0; i < mod->GetFunctionCount(); ++i) {
        asIScriptFunction* fn = mod->GetFunctionByIndex(i);
        if (std::string(fn->GetName()).rfind("test_", 0) != 0) continue;
        asIScriptContext* ctx = engine->CreateContext();
        ctx->Prepare(fn);
        if (ctx->Execute() != asEXECUTION_FINISHED) {
            std::cerr << fn->GetName() << ": " << ctx->GetExceptionString() << '\n';
            if (failures == 0) ++failures;
        }
        ctx->Release(); ++executed;
    }
    engine->ShutDownAndRelease();
    std::cout << executed << " production policy tests; " << failures << " failures\n";
    return failures == 0 && executed > 0 ? 0 : 1;
}
