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

add_subdirectory(common)
add_subdirectory(proj/samples EXCLUDE_FROM_ALL)
add_subdirectory(proj/hello_tiger)

DETACH_DEBUG_INFO_BY_PATH(detach "${PROJECT_BINARY_DIR}/bin")
ADD_CTAGS(proj common build/tf_srcs build/pb_srcs)
