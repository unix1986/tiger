cmake_minimum_required(VERSION 2.5)
project(TIGER C CXX)

set(CMAKE_MODULE_PATH
    ${PROJECT_SOURCE_DIR}/cmake
    ${CMAKE_MODULE_PATH}
)

include(tiger_config)
include(tiger_policy NO_POLICY_SCOPE)
include(tiger_macro)

include_directories(
    "${PROJECT_SOURCE_DIR}"
    "${TIGER_PB_OUTPUT_PATH}"
    "${TIGER_TF_OUTPUT_PATH}"
)

add_subdirectory(common/framework)
add_subdirectory(proj/samples)
add_subdirectory(proj/hello_tiger)

DETACH_DEBUG_INFO_BY_PATH(detach "${PROJECT_BINARY_DIR}/bin")
