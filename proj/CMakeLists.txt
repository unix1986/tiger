add_executable(tiger main.cpp)
#target_include_directories(tiger
#PRIVATE -I${THIRDPARTY_LIB_PATH}/zlog/include)
target_link_libraries(tiger
-Wl,-Bstatic
-L${THIRDPARTY_LIB_PATH}/zlog/lib -lzlog
-Wl,-Bdynamic
-lpthread
)

add_executable(server server.cpp)
target_link_libraries(server
-Wl,-Bstatic
-L${THIRDPARTY_LIB_PATH}/libevent/lib -levent
-Wl,-Bdynamic
-lrt
)

add_executable(jsontest jsontest.cpp)
target_link_libraries(jsontest
-Wl,-Bstatic
-L${THIRDPARTY_LIB_PATH}/jsoncpp/lib -ljsoncpp
-Wl,-Bdynamic
)


add_executable(gflagstest gflagstest.cpp)
target_link_libraries(gflagstest
-Wl,-Bstatic
-L${THIRDPARTY_LIB_PATH}/gflags/lib -lgflags
-Wl,-Bdynamic
-lpthread
)
