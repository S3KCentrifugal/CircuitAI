// Compile-only companion to the opt-in CIRCUIT_AS_INTERFACE engine dump.
// It never executes policy, initializers, or a native callback.
#include "angelscript/include/angelscript.h"
#include "angelscript/add_on/scriptbuilder/scriptbuilder.h"
#include "angelscript/add_on/scripthelper/scripthelper.h"
#include <cstring>
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>

struct Strings final : asIStringFactory {
    const void* GetStringConstant(const char* data, asUINT size) override { return new std::string(data, size); }
    int ReleaseStringConstant(const void* value) override { delete static_cast<const std::string*>(value); return 0; }
    int GetRawStringData(const void* value, char* data, asUINT* size) const override {
        const auto& text = *static_cast<const std::string*>(value);
        if (size) *size = static_cast<asUINT>(text.size());
        if (data) std::memcpy(data, text.data(), text.size());
        return 0;
    }
};
static void Message(const asSMessageInfo* message, void*) {
    std::cout << message->section << ':' << message->row << ':' << message->col << ' '
        << (message->type == asMSGTYPE_ERROR ? "ERROR" : message->type == asMSGTYPE_WARNING ? "WARNING" : "INFO")
        << ' ' << message->message << '\n';
}
int main(int argc, char** argv) {
    if (argc != 3) { std::cerr << "Usage: compile_script.exe interface.main.cfg profile/main.as\n"; return 2; }
    std::ifstream input(argv[1]);
    if (!input) { std::cerr << "Missing interface dump\n"; return 2; }
    Strings strings;
    auto* engine = asCreateScriptEngine();
    engine->SetMessageCallback(asFUNCTION(Message), nullptr, asCALL_CDECL);
    // The bundled helper parses flags with Windows' 32-bit signed atol.
    // APP_CLASS_MORE_CONSTRUCTORS is ABI metadata only; strip that high bit
    // for this generic, non-executing compiler to avoid atol overflow.
    std::stringstream portable;
    std::string line;
    while (std::getline(input, line)) {
        if (line.compare(0, 8, "objtype ") == 0) {
            const auto separator = line.find_last_of(' ');
            const auto flags = std::stoull(line.substr(separator + 1));
            line = line.substr(0, separator + 1) + std::to_string(flags & ~asOBJ_APP_CLASS_MORE_CONSTRUCTORS);
        }
        portable << line << '\n';
    }
    int result = ConfigEngineFromStream(engine, portable, argv[1], &strings);
    if (result >= 0) {
        CScriptBuilder builder;
        result = builder.StartNewModule(engine, "check");
        if (result >= 0) result = builder.AddSectionFromFile(argv[2]);
        if (result >= 0) result = builder.BuildModule();
    }
    engine->ShutDownAndRelease();
    std::cout << (result >= 0 ? "PASS: compiled without executing policy\n" : "FAIL: compile errors\n");
    return result >= 0 ? 0 : 1;
}
