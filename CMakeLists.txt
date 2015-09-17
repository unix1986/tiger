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
add_subdirectory(proj)

add_custom_target(detach
COMMAND rm -rf *.dbg &>/dev/null
COMMAND ls | xargs -i objcopy --only-keep-debug {} {}.dbg &>/dev/null
COMMAND ls -I*.dbg | xargs -i objcopy --strip-debug {} &>/dev/null
COMMAND ls -I*.dbg | xargs -i objcopy --add-gnu-debuglink={}.dbg {} &>/dev/null
WORKING_DIRECTORY ${PROJECT_BINARY_DIR}/bin
COMMENT "Detach debug info from binaries")
