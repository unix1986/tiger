cmake_minimum_required(VERSION 2.5)
project(TIGER C CXX)

set(CMAKE_BUILD_TYPE Debug)

set(CMAKE_INCLUDE_DIRECTORIES_BEFORE on)
set(CMAKE_LINK_DIRECTORIES_BEFORE on)

set(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin)
set(LIBRARY_OUTPUT_PATH lib)

set(THIRDPARTY_LIB_PATH "${PROJECT_SOURCE_DIR}/thirdparty"
    CACHE PATH "thirdparty directory")

include_directories("${PROJECT_SOURCE_DIR}")

add_subdirectory(proj)
