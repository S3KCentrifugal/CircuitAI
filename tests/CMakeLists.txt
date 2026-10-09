cmake_minimum_required(VERSION 3.16)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
	project(CircuitAITests LANGUAGES CXX)
endif()

include(CTest)
add_executable(circuit_enemy_reclaim_policy_test enemy_reclaim_policy_test.cpp)
target_compile_features(circuit_enemy_reclaim_policy_test PRIVATE cxx_std_20)
target_include_directories(circuit_enemy_reclaim_policy_test PRIVATE ../src)
add_test(NAME circuit_enemy_reclaim_policy_test COMMAND circuit_enemy_reclaim_policy_test)

if(BUILD_TESTING)
    add_executable(circuit_ranged_geometry_test ranged_geometry_test.cpp)
    target_compile_features(circuit_ranged_geometry_test PRIVATE cxx_std_20)
    target_include_directories(circuit_ranged_geometry_test PRIVATE ../src/circuit)
    add_test(NAME circuit_ranged_geometry_test COMMAND circuit_ranged_geometry_test)
    add_executable(circuit_local_reservations_test local_reservations_test.cpp)
    target_compile_features(circuit_local_reservations_test PRIVATE cxx_std_20)
    target_include_directories(circuit_local_reservations_test PRIVATE ../src)
    add_test(NAME circuit_local_reservations_test COMMAND circuit_local_reservations_test)
    add_executable(circuit_allied_reservations_test allied_reservations_test.cpp)
    target_compile_features(circuit_allied_reservations_test PRIVATE cxx_std_20)
    target_include_directories(circuit_allied_reservations_test PRIVATE ../src)
    add_test(NAME circuit_allied_reservations_test COMMAND circuit_allied_reservations_test)
    file(GLOB ANGELSCRIPT_SOURCES "../src/lib/angelscript/source/*.cpp")
    add_executable(circuit_production_math_test production_math_test.cpp ${ANGELSCRIPT_SOURCES}
        ../src/lib/angelscript/add_on/scriptarray/scriptarray.cpp)
    target_compile_features(circuit_production_math_test PRIVATE cxx_std_20)
    target_include_directories(circuit_production_math_test PRIVATE ../src/lib/angelscript/include
        ../src/lib/angelscript/add_on/scriptarray)
    target_compile_definitions(circuit_production_math_test PRIVATE ANGELSCRIPT_EXPORT AS_MAX_PORTABILITY)
    add_test(NAME circuit_production_math_test COMMAND circuit_production_math_test
        "${CMAKE_CURRENT_SOURCE_DIR}/../data/script/src/helpers/production_math.as" "${CMAKE_CURRENT_SOURCE_DIR}/production_math_tests.as")
    add_test(NAME circuit_placement_math_test COMMAND circuit_production_math_test
        "${CMAKE_CURRENT_SOURCE_DIR}/../data/script/src/helpers/placement_math.as" "${CMAKE_CURRENT_SOURCE_DIR}/placement_math_tests.as")
    add_test(NAME circuit_air_math_test COMMAND circuit_production_math_test
        "${CMAKE_CURRENT_SOURCE_DIR}/../data/script/src/helpers/air_math.as" "${CMAKE_CURRENT_SOURCE_DIR}/air_math_tests.as")
    add_test(NAME circuit_build_power_math_test COMMAND circuit_production_math_test
        "${CMAKE_CURRENT_SOURCE_DIR}/../data/script/src/helpers/build_power_math.as" "${CMAKE_CURRENT_SOURCE_DIR}/build_power_math_tests.as")
    find_package(Python3 COMPONENTS Interpreter QUIET)
    if(Python3_Interpreter_FOUND)
        add_test(NAME circuit_performance_policy_test COMMAND "${Python3_EXECUTABLE}"
            "${CMAKE_CURRENT_SOURCE_DIR}/../tools/knowledge/check_performance_policy.py"
            --runner "$<TARGET_FILE:circuit_production_math_test>"
            --output "${CMAKE_CURRENT_BINARY_DIR}/performance-policy")
        add_test(NAME circuit_weapon_work_test COMMAND "${Python3_EXECUTABLE}"
            "${CMAKE_CURRENT_SOURCE_DIR}/../tools/knowledge/check_weapon_work.py"
            --runner "$<TARGET_FILE:circuit_production_math_test>"
            --output "${CMAKE_CURRENT_BINARY_DIR}/weapon-policy")
    endif()
    add_executable(circuit_air_geometry_test air_geometry_test.cpp)
    target_compile_features(circuit_air_geometry_test PRIVATE cxx_std_20)
    target_include_directories(circuit_air_geometry_test PRIVATE ../src ../src/circuit)
    add_test(NAME circuit_air_geometry_test COMMAND circuit_air_geometry_test)
    find_package(Threads REQUIRED)
    target_link_libraries(circuit_production_math_test PRIVATE Threads::Threads)
    add_executable(circuit_lane_solver_test lane_solver_test.cpp ../src/circuit/terrain/LaneSolver.cpp)
    target_compile_features(circuit_lane_solver_test PRIVATE cxx_std_20)
    target_include_directories(circuit_lane_solver_test PRIVATE ../src ../src/circuit)
    target_link_libraries(circuit_lane_solver_test PRIVATE Threads::Threads)
    add_test(NAME circuit_lane_solver_test COMMAND circuit_lane_solver_test)
	add_executable(circuit_base_layout_test base_layout_geometry_test.cpp)
	target_compile_features(circuit_base_layout_test PRIVATE cxx_std_20)
	set_target_properties(circuit_base_layout_test PROPERTIES CXX_STANDARD_REQUIRED YES CXX_EXTENSIONS NO)
	target_include_directories(circuit_base_layout_test PRIVATE "${CMAKE_CURRENT_LIST_DIR}/../src")
	add_test(NAME circuit_base_layout_test COMMAND circuit_base_layout_test)

	# D-094: the TECH layout's ranking rules
	add_executable(circuit_layout_ranking_test layout_ranking_test.cpp)
	target_compile_features(circuit_layout_ranking_test PRIVATE cxx_std_20)
	set_target_properties(circuit_layout_ranking_test PROPERTIES CXX_STANDARD_REQUIRED YES CXX_EXTENSIONS NO)
	target_include_directories(circuit_layout_ranking_test PRIVATE "${CMAKE_CURRENT_LIST_DIR}/../src")
	add_test(NAME circuit_layout_ranking_test COMMAND circuit_layout_ranking_test)
    add_executable(circuit_metal_field_test metal_field_test.cpp)
    target_compile_features(circuit_metal_field_test PRIVATE cxx_std_20)
    target_include_directories(circuit_metal_field_test PRIVATE ../src)
    add_test(NAME circuit_metal_field_test COMMAND circuit_metal_field_test)
    add_test(NAME circuit_metal_math_test COMMAND circuit_production_math_test
        "${CMAKE_CURRENT_SOURCE_DIR}/../data/script/src/helpers/metal_math.as" "${CMAKE_CURRENT_SOURCE_DIR}/metal_math_tests.as")
endif()

if(BUILD_TESTING)
    add_executable(circuit_naval_geometry_test naval_geometry_test.cpp)
    target_compile_features(circuit_naval_geometry_test PRIVATE cxx_std_20)
    target_include_directories(circuit_naval_geometry_test PRIVATE ../src/circuit)
    add_test(NAME circuit_naval_geometry_test COMMAND circuit_naval_geometry_test)
    add_test(NAME circuit_sea_math_test COMMAND circuit_production_math_test "${CMAKE_CURRENT_SOURCE_DIR}/../data/script/src/helpers/sea_math.as" "${CMAKE_CURRENT_SOURCE_DIR}/sea_math_tests.as")
endif()

if(BUILD_TESTING)
    add_executable(circuit_air_safety_test air_safety_test.cpp)
    target_compile_features(circuit_air_safety_test PRIVATE cxx_std_20)
    target_include_directories(circuit_air_safety_test PRIVATE ../src/circuit)
    add_test(NAME circuit_air_safety_test COMMAND circuit_air_safety_test)
endif()
