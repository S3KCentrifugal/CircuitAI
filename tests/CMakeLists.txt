cmake_minimum_required(VERSION 3.16)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
	project(CircuitAITests LANGUAGES CXX)
endif()

include(CTest)

if(BUILD_TESTING)
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
endif()
