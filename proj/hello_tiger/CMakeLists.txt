COMPILE_TF_PATH(tf_files)
aux_source_directory(${TIGER_TF_OUTPUT_PATH}/proj/hello_tiger/tf_files tf_files_src_list)
REMOVE_ITEM_REGEX(tf_files_src_list ".*.skeleton.cpp")
add_library(tf_hello_tiger STATIC EXCLUDE_FROM_ALL ${tf_files_src_list})
target_include_directories(tf_hello_tiger
PUBLIC ${TIGER_THIRDPARTY_LIB_PATH}/thrift/include
PUBLIC ${TIGER_THIRDPARTY_LIB_PATH}/boost/include)

add_executable(hello_tiger_server server.cpp)
target_link_libraries(hello_tiger_server tiger tf_hello_tiger
-Wl,-Bstatic
-L${TIGER_THIRDPARTY_LIB_PATH}/thrift/lib -lthrift
-lzlog
-lgflags
-Wl,-Bdynamic
-lpthread
)

add_executable(hello_tiger_client client.cpp)
target_link_libraries(hello_tiger_client tf_hello_tiger
-Wl,-Bstatic
-L${TIGER_THIRDPARTY_LIB_PATH}/thrift/lib -lthrift
-Wl,-Bdynamic
-lpthread
)
