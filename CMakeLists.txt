cmake_minimum_required(VERSION 2.5)
project(TIGER C CXX)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH}
    ${PROJECT_SOURCE_DIR}/cmake)

include(tiger_cmake_config)
include(tiger_policy NO_POLICY_SCOPE)
include(tiger_macro)

include_directories(
    "${PROJECT_SOURCE_DIR}"
    "${TIGER_PB_OUTPUT_PATH}"
    "${TIGER_TF_OUTPUT_PATH}"
)

add_subdirectory(common/framework)
add_subdirectory(proj)
