cmake_minimum_required(VERSION 2.5)
project(TIGER CXX)

set(CMAKE_BUILD_TYPE Debug)
#set(CMAKE_C_FLAGS "-static")
#set(CMAKE_CXX_FLAGS "-static")
set(CMAKE_INCLUDE_DIRECTORIES_BEFORE on)
set(CMAKE_LINK_DIRECTORIES_BEFORE on)

include_directories("${PROJECT_SOURCE_DIR}")
link_directories("${PROJECT_SOURCE_DIR}/thirdparty/zlog/lib")
link_directories("${PROJECT_SOURCE_DIR}/thirdparty/libevent/lib")
link_directories("${PROJECT_SOURCE_DIR}/thirdparty/jsoncpp/lib")
add_subdirectory(proj bin)
