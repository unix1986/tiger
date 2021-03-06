set(CMAKE_BUILD_TYPE Debug)

set(CMAKE_INCLUDE_DIRECTORIES_BEFORE on)
set(CMAKE_LINK_DIRECTORIES_BEFORE on)

set(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin)
set(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib)

set(TIGER_THIRDPARTY_LIB_PATH "${PROJECT_SOURCE_DIR}/thirdparty"
    CACHE PATH "tiger thirdparty directory")
set(TIGER_COMMON_LIB_PATH "${PROJECT_SOURCE_DIR}/common"
    CACHE PATH "tiger common directory")

set(TIGER_TOOL_PATH ${CMAKE_SOURCE_DIR}/tool
    CACHE PATH "tiger tool directory")
set(TIGER_PB_OUTPUT_PATH ${CMAKE_BINARY_DIR}/pb_srcs
    CACHE PATH "tiger pb code directory")
set(TIGER_TF_OUTPUT_PATH ${CMAKE_BINARY_DIR}/tf_srcs
    CACHE PATH "tiger pb code directory")
