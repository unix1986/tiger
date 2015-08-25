# required version
cmake_minimum_required(VERSION 2.5)
# policy: relative path to CMAKE_CURRENT_SOURCE_DIR
cmake_policy(SET CMP0015 NEW)
# project name and compiler
project(Tiger CXX C)
# load current project headers and libraries first
set(CMAKE_INCLUDE_DIRECTORIES_BEFORE ON)
set(CMAKE_LINK_DIRECTORIES_BEFORE ON)
# binary and library output path
set(EXECUTABLE_OUTPUT_PATH bin)
set(LIBRARY_OUTPUT_PATH lib)
# thirdparty include path
include_directories(../)
include_directories(../thirdparty/libevent/include)
# thirdparty library path
link_directories(../thirdparty/libevent/lib)
link_directories(../thirdparty/gflags/lib)
link_directories(../thirdparty/jsoncpp/lib)
link_directories(../thirdparty/zlog/lib)
# subproject
include(Proj.cmake)
