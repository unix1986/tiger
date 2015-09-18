add_executable(main EXCLUDE_FROM_ALL main.cpp)
target_link_libraries(main
-Wl,-Bstatic
-L${TIGER_THIRDPARTY_LIB_PATH}/zlog/lib -lzlog
-Wl,-Bdynamic
-lpthread
)

add_custom_target(MYLS
COMMAND ls -al .
WORKING_DIRECTORY ${PROJECT_SOURCE_DIR})

add_executable(server EXCLUDE_FROM_ALL server.cpp)
target_include_directories(server BEFORE
PRIVATE ${TIGER_THIRDPARTY_LIB_PATH}/libevent/include
)
target_link_libraries(server
-Wl,-Bstatic
-L${TIGER_THIRDPARTY_LIB_PATH}/libevent/lib -levent
-Wl,-Bdynamic
-lrt
)

add_executable(jsontest EXCLUDE_FROM_ALL jsontest.cpp)
target_link_libraries(jsontest
-Wl,-Bstatic
-L${TIGER_THIRDPARTY_LIB_PATH}/jsoncpp/lib -ljsoncpp
-Wl,-Bdynamic
)


add_executable(gflagstest EXCLUDE_FROM_ALL  gflagstest.cpp)
target_link_libraries(gflagstest
-Wl,-Bstatic
-L${TIGER_THIRDPARTY_LIB_PATH}/gflags/lib -lgflags
-Wl,-Bdynamic
-lpthread
)

add_executable(template EXCLUDE_FROM_ALL template.cpp)
target_link_libraries(template tiger
-Wl,-Bstatic
-L${TIGER_THIRDPARTY_LIB_PATH}/gflags/lib -lgflags
-L${TIGER_THIRDPARTY_LIB_PATH}/zlog/lib -lzlog
-Wl,-Bdynamic
-lpthread
)
add_dependencies(template tiger)

COMPILE_PB_PATH(pb_files)
add_executable(pb_test EXCLUDE_FROM_ALL pb_test.cpp
${TIGER_PB_OUTPUT_PATH}/proj/samples/pb_files/test.pb.cc)
target_link_libraries(pb_test tiger
-Wl,-Bstatic
-lprotobuf
-lzlog
-lgflags
-Wl,-Bdynamic
-lpthread
)
add_dependencies(pb_test tiger)
COMPILE_TF_PATH(tf_files)

aux_source_directory(${TIGER_TF_OUTPUT_PATH}/proj/samples/tf_files tf_tutorial_src_list)
REMOVE_ITEM_REGEX(tf_tutorial_src_list ".*.skeleton.cpp")
add_library(tf_tutorial STATIC EXCLUDE_FROM_ALL ${tf_tutorial_src_list})
target_include_directories(tf_tutorial
PUBLIC ${TIGER_THIRDPARTY_LIB_PATH}/boost/include
PUBLIC ${TIGER_THIRDPARTY_LIB_PATH}/thrift/include
)
target_link_libraries(tf_tutorial
-Wl,-Bstatic
-L${TIGER_THIRDPARTY_LIB_PATH}/thrift/lib -lthrift
-Wl,-Bdynamic
)
add_executable(tf_client EXCLUDE_FROM_ALL CppClient.cpp)
target_link_libraries(tf_client tf_tutorial
-Wl,-Bstatic
-lthrift
-Wl,-Bdynamic
-lpthread
)
add_dependencies(tf_client tf_tutorial)

add_executable(tf_server EXCLUDE_FROM_ALL CppServer.cpp)
target_include_directories(tf_server
PRIVATE ${TIGER_THIRDPARTY_LIB_PATH}/libevent/include
)
target_link_libraries(tf_server tf_tutorial
-Wl,-Bstatic
-lthriftnb
-lthrift
-L${TIGER_THIRDPARTY_LIB_PATH}/libevent/lib -levent
-Wl,-Bdynamic
-lrt
-lpthread
)
add_dependencies(tf_server tf_tutorial)

# phony target
add_custom_target(nbtest)
add_dependencies(nbtest tf_server tf_client)
