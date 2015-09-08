add_executable(main main.cpp)
target_link_libraries(main
-Wl,-Bstatic
-L${TIGER_THIRDPARTY_LIB_PATH}/zlog/lib -lzlog
-Wl,-Bdynamic
-lpthread
)

add_custom_target(MYLS
COMMAND ls -al .
WORKING_DIRECTORY ${PROJECT_SOURCE_DIR})

add_executable(server server.cpp)
target_link_libraries(server
-Wl,-Bstatic
-L${TIGER_THIRDPARTY_LIB_PATH}/libevent/lib -levent
-Wl,-Bdynamic
-lrt
)

add_executable(jsontest jsontest.cpp)
target_link_libraries(jsontest
-Wl,-Bstatic
-L${TIGER_THIRDPARTY_LIB_PATH}/jsoncpp/lib -ljsoncpp
-Wl,-Bdynamic
)


add_executable(gflagstest gflagstest.cpp)
target_link_libraries(gflagstest
-Wl,-Bstatic
-L${TIGER_THIRDPARTY_LIB_PATH}/gflags/lib -lgflags
-Wl,-Bdynamic
-lpthread
)

add_executable(template template.cpp)
target_link_libraries(template tiger
-Wl,-Bstatic
-L${TIGER_THIRDPARTY_LIB_PATH}/gflags/lib -lgflags
-L${TIGER_THIRDPARTY_LIB_PATH}/zlog/lib -lzlog
-Wl,-Bdynamic
-lpthread
)
add_dependencies(template tiger)

COMPILE_PB_PATH(pb_files)
add_executable(pb_test pb_test.cpp
${TIGER_PB_OUTPUT_PATH}/proj/pb_files/test.pb.cc)
target_include_directories(pb_test
PRIVATE ${TIGER_THIRDPARTY_LIB_PATH}/protobuf/include
)
target_link_libraries(pb_test tiger
-Wl,-Bstatic
-L${TIGER_THIRDPARTY_LIB_PATH}/protobuf/lib -lprotobuf
-L${TIGER_THIRDPARTY_LIB_PATH}/zlog/lib -lzlog
-L${TIGER_THIRDPARTY_LIB_PATH}/gflags/lib -lgflags
-Wl,-Bdynamic
-lpthread
)
add_dependencies(pb_test tiger)
COMPILE_TF_PATH(tf_files)
